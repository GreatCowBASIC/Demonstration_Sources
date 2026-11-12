//--------------------------------------------------------------------------------------------------------------------------------
// TCP for the ENC28J60 stack (RFC 9293, protocol 6) - a server connection and a client connection
//
//   - Four connections: 0 and 3 are the server (both listen on TCP_LISTEN_PORT, e.g. the web server), 1 is the client
//     (opened by TCP_Connect to a server elsewhere, e.g. an MQTT broker), 2 is the terminal server (listens on
//     TCP_TERMINAL_PORT when TCP_TERMINAL is 1, e.g. the console over telnet). The code works on one connection at a
//     time: TCP_Use keeps the current connection's state in per-connection arrays and takes the wanted one's
//     (TCP_Conn says which one is in use)
//   - Server: a SYN opens connection 0, or connection 3 when 0 is in use (SYN-ACK with MSS TCP_MSS). While both are in
//     use, other peers get a reset, as do segments to any port that is not in use (connection refused). The two serve
//     one reply at a time (the program has one reply state): a request on one while the other's reply is not yet all
//     acknowledged is dropped, and the peer sends it again. A server connection with nothing from the peer for
//     TCP_IDLE_S seconds while nothing is outstanding is reset
//   - Client: TCP_Connect sends a SYN from a new local port; the SYN-ACK opens connection 1. It has no idle reset (the
//     application keeps it alive, e.g. MQTT PINGREQ)
//   - Receives data in order only (anything else is answered with an ACK of what we expect), checks the checksum
//   - Sends a reply of any length (a "stream") as segments of up to TCP_MSS bytes, at most TCP_INFLIGHT bytes
//     unacknowledged and never more than the peer's window. Nothing is buffered: each segment is built by the program
//     (TCP_FillData) from the stream offset, so a lost segment is built again for the retransmission (go-back-N from
//     the oldest unacknowledged byte, after 2, 4, 8, 16, 32 s; then the connection is reset). A stream without close
//     ends when all of it is acknowledged, and the next one can start
//   - Closes from either side; after the close a server connection listens again at once (no TIME_WAIT)
//
// Needs ENC28J60_Driver.h, ENC28J60_ARP.h, ENC28J60_IPv4.h and millis.h.
//
// The program may define (defaults below):
//   TCP_LISTEN_PORT, TCP_RETRIES, TCP_IDLE_S
//
// The program must define:
//   Sub TCP_HandleData    new data has arrived on connection TCP_Conn: TCP_RxLength bytes in EthFrame from TCP_RxData.
//                         Server: called for the request only, it may start the reply with TCP_SendStream. Client:
//                         called for all data
//   Sub TCP_FillData(In TcpFillOffset As Word, In TcpFillCount As Word)
//                         write TcpFillCount bytes of the reply, from byte TcpFillOffset (0 = first), to EthFrame from
//                         TCP_DATA. Called for each segment, also for a retransmission: the same offset gives the same bytes
//
// The program calls TCP_Init once at start-up, TCP_ProcessSegment for each datagram with protocol 6 addressed to us,
// and TCP_Tick once a second. A client application uses TCP_Connect, TCP_ClientState, TCP_ClientBusy, TCP_ClientSend
// and TCP_ClientClose; the terminal uses TCP_ConnState, TCP_ConnBusy and TCP_ConnSend with connection 2.
// The program may define TCP_TERMINAL (1 = connection 2 listens on TCP_TERMINAL_PORT, default 23).
// and TCP_ClientClose.
//
//@author    Evan R. Venn
//@licence   GPL
//@date      07/11/2026
//
// Changes:
//   01/11/2026  2026 initial release
//   01/11/2026  A stream without close (MQTT client) longer than two segments stopped after the first two: the stream
//                    counted as complete as soon as everything sent so far was acknowledged. Now only when all of it is
//   01/11/2026  CON_ names renamed CONSOLE_
//   04/11/2026  #option explicit
//   06/11/2026  Optional TCP_LOG_REFUSED (the program defines it): a segment refused because the server connection is
//                    in use by another peer is counted in TCP_RefusedCount, with the refused peer in TCP_RefIP1-4 and
//                    TCP_RefPort, for the program to report. Variables only, no calls: the refusal is deep in the stack
//   07/11/2026  Second server connection (3) on TCP_LISTEN_PORT: a second web client is no longer refused while the
//                    first is served. Replies still go one at a time: a request waits (dropped, sent again by the peer)
//                    until the other connection's reply is all acknowledged
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

    // Console switch STACK_CONSOLE (0 headless, 1 serial, 2 TCP terminal) is set by the stack, from the program. No
    // default here: a default inside #ifndef was taken as well as the program's value (both console versions were compiled)

    // Statistics switch: 1 = counters and PrintStats in the program, 0 = left out (set by the program or ENC28J60_Stack)
    #ifndef STACK_STATS
        #define STACK_STATS 1
    #endif

    #include <millis.h>

// ----- Options

    #ifndef TCP_LISTEN_PORT
        #define TCP_LISTEN_PORT 80
    #endif
    // Largest segment we accept and send (data bytes): 536, the TCP default; it needs ETH_BUFFER_SIZE 590 or more.
    // Fixed, not an option: the size checks in #script cannot see a constant defined inside #ifndef
    #define TCP_MSS 536
    // Unacknowledged bytes we allow: two segments, so a peer that acknowledges every second segment answers at once
    #define TCP_INFLIGHT 1072
    // Retransmissions before the connection is reset
    #ifndef TCP_RETRIES
        #define TCP_RETRIES 5
    #endif
    // Seconds without a segment from the peer before the connection is reset
    #ifndef TCP_IDLE_S
        #define TCP_IDLE_S 10
    #endif
    // First retransmission wait in seconds (TCP_Tick runs once a second, so 2 means 1 to 2 s)
    #define TCP_RTO_FIRST 2

    #script
        TcpFrameNeeded = TCP_MSS + 54
        if ETH_BUFFER_SIZE < TcpFrameNeeded then
            Error TCP_MSS is too large for the frame buffer - ETH_BUFFER_SIZE must be at least TCP_MSS + 54
        end if
    #endscript

    #define IP_PROTO_TCP 6

// ----- TCP segment. Offsets are from the first byte of the Ethernet header (TCP starts at 34)
    #define TCPO_SRCPORT   34
    #define TCPO_DSTPORT   36
    #define TCPO_SEQ       38
    #define TCPO_ACK       42
    #define TCPO_OFFSET    46      // header length in 32-bit words, top 4 bits
    #define TCPO_FLAGS     47
    #define TCPO_WINDOW    48
    #define TCPO_CHECKSUM  50
    #define TCPO_URGENT    52
    #define TCPO_OPTIONS   54
    // Data of the segments we send (20-byte header, no options)
    #define TCP_DATA       54
    #define TCP_HEADER_LENGTH 20

    // Flags
    #define TCP_FIN 0x01
    #define TCP_SYN 0x02
    #define TCP_RST 0x04
    #define TCP_PSH 0x08
    #define TCP_ACK 0x10

    // States. LISTEN is also "closed": the next SYN opens the connection
    #define TCP_LISTEN       0
    #define TCP_SYN_RCVD     1
    #define TCP_ESTABLISHED  2
    #define TCP_FIN_WAIT_1   3
    #define TCP_FIN_WAIT_2   4
    #define TCP_CLOSING      5
    #define TCP_LAST_ACK     6
    #define TCP_CLOSE_WAIT   7
    #define TCP_SYN_SENT     8

    // Terminal server (connection 2): on when TCP_TERMINAL is 1
    #ifndef TCP_TERMINAL
        #define TCP_TERMINAL 0
    #endif
    #ifndef TCP_TERMINAL_PORT
        #define TCP_TERMINAL_PORT 23
    #endif
    // Connections: 0 server, 1 client, 2 terminal server, 3 second server
    #define TCP_CONNECTIONS 4
    #define TCP_SERVER2 3

    // Local ports of the client connection: a new one for each connection, from 49152 up
    #define TCP_CLIENT_PORT_FIRST 49152

// ----- Variables
    // The connection in use (0 and 3 server, 1 client, 2 terminal server); the variables below are its state
    Dim TCP_Conn As Byte
    Dim TCP_LocalPort, TCP_NextClientPort As Word
    Dim TCP_State As Byte
    // The peer: IP, MAC (the frame's source: the peer itself or the router), port, window
    Dim TCP_RemIP1, TCP_RemIP2, TCP_RemIP3, TCP_RemIP4 As Byte
    Dim TCP_RemMAC(6)
    Dim TCP_RemPort, TCP_SndWnd As Word
    // Sequence numbers: oldest unacknowledged, next to send, highest sent, next expected from the peer
    Dim TCP_SndUna, TCP_SndNxt, TCP_SndMax, TCP_RcvNxt As Long
    // The reply: sequence number of its first byte, its length, close after it, FIN sent
    Dim TCP_StreamSeq As Long
    Dim TCP_StreamLength As Word
    Dim TCP_Streaming, TCP_StreamClose, TCP_FinSent As Byte
    // Retransmission: seconds to wait, seconds left, retransmissions so far
    Dim TCP_RtoSeconds, TCP_RtoLeft, TCP_RetryCount As Byte
    // Seconds left before an idle connection is reset
    Dim TCP_IdleLeft As Byte
    // The received segment, for TCP_HandleData
    Dim TCP_RxData, TCP_RxLength As Word
    // Received segment fields
    Dim TCP_SegSeq, TCP_SegAck As Long
    Dim TCP_SegFlags As Byte
    Dim TCP_SegLength As Word
    Dim TCP_IssCount As Word

    // The state of every connection, kept by TCP_Keep and taken back by TCP_Take (index = connection number). One array
    // per Dim: in "Dim A(3), B(3) As Word" only B is a Word array
    Dim TCP_K_State(TCP_CONNECTIONS) As Byte
    Dim TCP_K_RemIP1(TCP_CONNECTIONS) As Byte
    Dim TCP_K_RemIP2(TCP_CONNECTIONS) As Byte
    Dim TCP_K_RemIP3(TCP_CONNECTIONS) As Byte
    Dim TCP_K_RemIP4(TCP_CONNECTIONS) As Byte
    Dim TCP_K_RemMAC(24)
    Dim TCP_K_RemPort(TCP_CONNECTIONS) As Word
    Dim TCP_K_SndWnd(TCP_CONNECTIONS) As Word
    Dim TCP_K_LocalPort(TCP_CONNECTIONS) As Word
    Dim TCP_K_StreamLength(TCP_CONNECTIONS) As Word
    Dim TCP_K_SndUna(TCP_CONNECTIONS) As Long
    Dim TCP_K_SndNxt(TCP_CONNECTIONS) As Long
    Dim TCP_K_SndMax(TCP_CONNECTIONS) As Long
    Dim TCP_K_RcvNxt(TCP_CONNECTIONS) As Long
    Dim TCP_K_StreamSeq(TCP_CONNECTIONS) As Long
    Dim TCP_K_Streaming(TCP_CONNECTIONS) As Byte
    Dim TCP_K_StreamClose(TCP_CONNECTIONS) As Byte
    Dim TCP_K_FinSent(TCP_CONNECTIONS) As Byte
    Dim TCP_K_RtoSeconds(TCP_CONNECTIONS) As Byte
    Dim TCP_K_RtoLeft(TCP_CONNECTIONS) As Byte
    Dim TCP_K_RetryCount(TCP_CONNECTIONS) As Byte
    Dim TCP_K_IdleLeft(TCP_CONNECTIONS) As Byte

    #ifdef TCP_LOG_REFUSED
        // Refusals while the server connection is in use, and the last refused peer
        Dim TCP_RefusedCount As Word
        Dim TCP_RefIP1, TCP_RefIP2, TCP_RefIP3, TCP_RefIP4 As Byte
        Dim TCP_RefPort As Word
    #endif

    #if STACK_STATS = 1
        // Statistics
        Dim Stat_RxTcp, Stat_TcpBadChecksum, Stat_TcpRefused, Stat_TcpConnects, Stat_TcpResets As Word
        Dim Stat_TcpSent, Stat_TcpRetransmits, Stat_TcpOutOfOrder As Word
    #endif

// ----- TCP

Sub TCP_Init
    // RAM is not cleared at reset. Every connection closed, with its local port; connection 0 is left in use
    TCP_IssCount = 0
    TCP_NextClientPort = TCP_CLIENT_PORT_FIRST
    TCP_Conn = TCP_SERVER2
    TCP_Close
    TCP_LocalPort = TCP_LISTEN_PORT
    TCP_Keep
    TCP_Conn = 2
    TCP_Close
    TCP_LocalPort = TCP_TERMINAL_PORT
    TCP_Keep
    TCP_Conn = 1
    TCP_Close
    TCP_LocalPort = TCP_CLIENT_PORT_FIRST
    TCP_Keep
    TCP_Conn = 0
    TCP_Close
    TCP_LocalPort = TCP_LISTEN_PORT
    #ifdef TCP_LOG_REFUSED
        TCP_RefusedCount = 0
    #endif
    #if STACK_STATS = 1
        Stat_RxTcp = 0
        Stat_TcpBadChecksum = 0
        Stat_TcpRefused = 0
        Stat_TcpConnects = 0
        Stat_TcpResets = 0
        Stat_TcpSent = 0
        Stat_TcpRetransmits = 0
        Stat_TcpOutOfOrder = 0
    #endif
End Sub

Sub TCP_ProcessSegment
    // A datagram with protocol 6, addressed to us, is in EthFrame (IP_Length bytes from IP_VERHL)
    Dim TcpHeaderLength, TcpDstPort, TcpSrcPort As Word
    Dim TcpAcked, TcpSentAhead, TcpStreamEnd As Long
    Dim TcpIndex, TcpNeedAck, TcpWhich, TcpOther As Byte

    #if STACK_STATS = 1
        Stat_RxTcp++
    #endif
    TCP_SegLength = IP_Length - IP_HEADER_LENGTH
    If TCP_SegLength < TCP_HEADER_LENGTH Then Exit Sub
    If TCP_Checksum(TCP_SegLength) <> 0 Then
        #if STACK_STATS = 1
            Stat_TcpBadChecksum++
        #endif
        Exit Sub
    End If
    TcpHeaderLength = (EthFrame(TCPO_OFFSET) / 16) * 4
    If TcpHeaderLength < TCP_HEADER_LENGTH Then Exit Sub
    If TcpHeaderLength > TCP_SegLength Then Exit Sub

    TcpSrcPort_H = EthFrame(TCPO_SRCPORT) : [byte]TcpSrcPort = EthFrame(TCPO_SRCPORT + 1)
    TcpDstPort_H = EthFrame(TCPO_DSTPORT) : [byte]TcpDstPort = EthFrame(TCPO_DSTPORT + 1)
    TCP_SegSeq_E = EthFrame(TCPO_SEQ) : TCP_SegSeq_U = EthFrame(TCPO_SEQ + 1)
    TCP_SegSeq_H = EthFrame(TCPO_SEQ + 2) : [byte]TCP_SegSeq = EthFrame(TCPO_SEQ + 3)
    TCP_SegAck_E = EthFrame(TCPO_ACK) : TCP_SegAck_U = EthFrame(TCPO_ACK + 1)
    TCP_SegAck_H = EthFrame(TCPO_ACK + 2) : [byte]TCP_SegAck = EthFrame(TCPO_ACK + 3)
    TCP_SegFlags = EthFrame(TCPO_FLAGS)
    TCP_RxData = TCPO_SRCPORT + TcpHeaderLength
    TCP_RxLength = TCP_SegLength - TcpHeaderLength

    // Which connection: the listening port is the server, the terminal port the terminal server, the client's local
    // port the client (when open); anything else is refused
    TcpWhich = 1
    If TcpDstPort = TCP_LISTEN_PORT Then
        // Server: the connection open to this peer; another peer gets connection 0, or 3 when 0 is in use and 3 is not
        TcpWhich = 0
        TCP_Use TCP_SERVER2
        If TCP_State <> TCP_LISTEN Then
            If TCP_FromPeer(TcpSrcPort) = 1 Then TcpWhich = TCP_SERVER2
        End If
        If TcpWhich = 0 Then
            TCP_Use 0
            If TCP_State <> TCP_LISTEN Then
                If TCP_FromPeer(TcpSrcPort) = 0 Then
                    If TCP_K_State(TCP_SERVER2) = TCP_LISTEN Then TcpWhich = TCP_SERVER2
                End If
            End If
        End If
    End If
    #if TCP_TERMINAL = 1
        If TcpDstPort = TCP_TERMINAL_PORT Then TcpWhich = 2
    #endif
    TCP_Use TcpWhich
    If TcpWhich = 1 Then
        If TCP_State = TCP_LISTEN Then
            TCP_Refuse
            Exit Sub
        End If
        If TcpDstPort <> TCP_LocalPort Then
            TCP_Refuse
            Exit Sub
        End If
    End If

    // ----- Server, no connection: only a SYN opens one
    If TCP_State = TCP_LISTEN Then
        If (TCP_SegFlags And TCP_RST) <> 0 Then Exit Sub
        If (TCP_SegFlags And TCP_ACK) <> 0 Then
            TCP_Refuse
            Exit Sub
        End If
        If (TCP_SegFlags And TCP_SYN) = 0 Then Exit Sub
        // The peer, and the MAC to answer to
        TCP_RemIP1 = EthFrame(IP_SRC) : TCP_RemIP2 = EthFrame(IP_SRC + 1)
        TCP_RemIP3 = EthFrame(IP_SRC + 2) : TCP_RemIP4 = EthFrame(IP_SRC + 3)
        For TcpIndex = 0 To 5
            TCP_RemMAC(TcpIndex) = EthFrame(ETH_SRC + TcpIndex)
        Next
        TCP_RemPort = TcpSrcPort
        TCP_SetWindow
        TCP_IdleLeft = TCP_IDLE_S
        TCP_RcvNxt = TCP_SegSeq + 1
        // Initial sequence number: from the clock, different for each connection
        TCP_IssCount = TCP_IssCount + 4099
        TCP_SndUna = Millis() * 250 + TCP_IssCount
        TCP_State = TCP_SYN_RCVD
        TCP_RetryCount = 0
        TCP_RtoSeconds = TCP_RTO_FIRST
        TCP_Output TCP_SYN Or TCP_ACK, TCP_SndUna, 0
        TCP_RtoLeft = TCP_RtoSeconds
        TCP_SndNxt = TCP_SndUna + 1
        TCP_SndMax = TCP_SndNxt
        Exit Sub
    End If

    // ----- A connection is open: the segment must be from its peer
    If TCP_FromPeer(TcpSrcPort) = 0 Then
        #ifdef TCP_LOG_REFUSED
            // The server connection is held by another peer: note this one for the program
            If TCP_Conn = 0 Then
                TCP_RefusedCount++
                TCP_RefIP1 = EthFrame(IP_SRC) : TCP_RefIP2 = EthFrame(IP_SRC + 1)
                TCP_RefIP3 = EthFrame(IP_SRC + 2) : TCP_RefIP4 = EthFrame(IP_SRC + 3)
                TCP_RefPort = TcpSrcPort
            End If
        #endif
        TCP_Refuse
        Exit Sub
    End If
    TCP_IdleLeft = TCP_IDLE_S

    // ----- Client, SYN sent: the SYN-ACK opens the connection (it must acknowledge our SYN)
    If TCP_State = TCP_SYN_SENT Then
        If (TCP_SegFlags And TCP_ACK) = 0 Then Exit Sub
        If TCP_SegAck <> TCP_SndNxt Then Exit Sub
        // A reset: the server refused
        If (TCP_SegFlags And TCP_RST) <> 0 Then
            TCP_Close
            Exit Sub
        End If
        If (TCP_SegFlags And TCP_SYN) = 0 Then Exit Sub
        TCP_RcvNxt = TCP_SegSeq + 1
        TCP_SndUna = TCP_SegAck
        TCP_SetWindow
        TCP_State = TCP_ESTABLISHED
        TCP_RtoLeft = 0
        TCP_RetryCount = 0
        TCP_RtoSeconds = TCP_RTO_FIRST
        #if STACK_STATS = 1
            Stat_TcpConnects++
        #endif
        TCP_Output TCP_ACK, TCP_SndNxt, 0
        Exit Sub
    End If

    // Reset: accepted when it is in sequence
    If (TCP_SegFlags And TCP_RST) <> 0 Then
        If TCP_SegSeq = TCP_RcvNxt Then TCP_Close
        Exit Sub
    End If

    // The peer's SYN again: our SYN-ACK was lost, the retransmission timer resends it
    If (TCP_SegFlags And TCP_SYN) <> 0 Then Exit Sub

    // Out of order or a repeat: tell the peer what we expect
    If TCP_SegSeq <> TCP_RcvNxt Then
        #if STACK_STATS = 1
            Stat_TcpOutOfOrder++
        #endif
        TCP_Output TCP_ACK, TCP_SndNxt, 0
        Exit Sub
    End If

    // Acknowledgement: SndUna < ack <= SndMax (modulo 2^32). SndMax, not SndNxt: after a go-back-N restart an ACK can
    // cover bytes sent before it
    If (TCP_SegFlags And TCP_ACK) = 0 Then Exit Sub
    TcpAcked = TCP_SegAck - TCP_SndUna
    TcpSentAhead = TCP_SndMax - TCP_SndUna
    If TcpAcked > TcpSentAhead Then
        // Acknowledges something we never sent
        TCP_Output TCP_ACK, TCP_SndNxt, 0
        Exit Sub
    End If
    TCP_SetWindow
    If TcpAcked > 0 Then
        TCP_SndUna = TCP_SegAck
        // Progress: a fresh retransmission count and wait
        TCP_RetryCount = 0
        TCP_RtoSeconds = TCP_RTO_FIRST
        TCP_RtoLeft = TCP_RTO_FIRST
        // After a go-back-N restart the ACK can be beyond SndNxt (the difference wraps round): continue from the ACK
        TcpSentAhead = TCP_SndNxt - TCP_SndUna
        If TcpSentAhead > TCP_INFLIGHT Then TCP_SndNxt = TCP_SndUna
        If TCP_SndUna = TCP_SndMax Then
            // Everything sent is acknowledged: no retransmission; a stream without close is complete when all of it has been
            // sent (a longer one goes on with the next segments below); the state moves on
            TCP_RtoLeft = 0
            If TCP_StreamClose = 0 Then
                // The sum in a Long first (worked out within the If, it was not)
                TcpStreamEnd = TCP_StreamSeq + TCP_StreamLength
                If TCP_SndUna = TcpStreamEnd Then TCP_Streaming = 0
            End If
            Select Case TCP_State
                Case TCP_SYN_RCVD
                    TCP_State = TCP_ESTABLISHED
                    #if STACK_STATS = 1
                        Stat_TcpConnects++
                    #endif
                Case TCP_FIN_WAIT_1
                    If TCP_FinAcked Then TCP_State = TCP_FIN_WAIT_2
                Case TCP_CLOSING
                    If TCP_FinAcked Then
                        TCP_Close
                        Exit Sub
                    End If
                Case TCP_LAST_ACK
                    If TCP_FinAcked Then
                        TCP_Close
                        Exit Sub
                    End If
            End Select
        End If
    End If
    If TCP_State = TCP_SYN_RCVD Then Exit Sub

    // Data, then FIN. Whatever was received is acknowledged once: by the next segment we send, or by a bare ACK
    TcpNeedAck = 0
    If TCP_RxLength > 0 Then
        // Server: a request waits while the other server connection's reply is not all acknowledged (one reply state:
        // a retransmission of it builds the segment again). Dropped unacknowledged, the peer sends it again
        // The other server connection (255: this is not a server connection)
        TcpOther = 255
        If TCP_Conn = 0 Then TcpOther = TCP_SERVER2
        If TCP_Conn = TCP_SERVER2 Then TcpOther = 0
        If TCP_Streaming = 0 Then
            If TcpOther <> 255 Then
                If TCP_K_Streaming(TcpOther) = 1 Then
                    // Reply bytes not yet acknowledged (modulo 2^32: past the end, the FIN acknowledged, is not)
                    TcpStreamEnd = TCP_K_StreamSeq(TcpOther) + TCP_K_StreamLength(TcpOther)
                    TcpSentAhead = TcpStreamEnd - TCP_K_SndUna(TcpOther)
                    If TcpSentAhead <> 0 Then
                        If TcpSentAhead < 0x80000000 Then Exit Sub
                    End If
                End If
            End If
        End If
        TCP_RcvNxt = TCP_RcvNxt + TCP_RxLength
        TcpNeedAck = 1
        // Server: a request starts a reply; data after it, or after our FIN, is acknowledged but not passed on.
        // Client and terminal: all data is passed on
        If TCP_State = TCP_ESTABLISHED Then
            If TcpOther = 255 Then
                TCP_HandleData
            Else
                If TCP_Streaming = 0 Then TCP_HandleData
            End If
        End If
    End If
    If (TCP_SegFlags And TCP_FIN) <> 0 Then
        TCP_RcvNxt = TCP_RcvNxt + 1
        TcpNeedAck = 1
        Select Case TCP_State
            Case TCP_ESTABLISHED
                // The peer closes: send the rest of the reply, then our FIN
                TCP_State = TCP_CLOSE_WAIT
                TCP_StreamClose = 1
                If TCP_Streaming = 0 Then TCP_SendStream 0, 1
            Case TCP_FIN_WAIT_1
                // Both close at once: our FIN is still to be acknowledged
                TCP_State = TCP_CLOSING
            Case TCP_FIN_WAIT_2
                TCP_Output TCP_ACK, TCP_SndNxt, 0
                TCP_Close
                Exit Sub
        End Select
    End If

    // Send what the window allows; any segment carries the ACK
    If TCP_Pump > 0 Then TcpNeedAck = 0
    If TcpNeedAck = 1 Then TCP_Output TCP_ACK, TCP_SndNxt, 0
End Sub

Function TCP_FinAcked As Byte
    // 1 when the peer has acknowledged our FIN: the byte after the reply and its FIN
    Dim TcpFinEnd As Long
    TCP_FinAcked = 0
    If TCP_StreamClose = 0 Then Exit Function
    TcpFinEnd = TCP_StreamSeq + TCP_StreamLength + 1
    If TCP_SndUna = TcpFinEnd Then TCP_FinAcked = 1
End Function

Sub TCP_SetWindow
    // The peer's window from the segment in EthFrame
    TCP_SndWnd_H = EthFrame(TCPO_WINDOW)
    [byte]TCP_SndWnd = EthFrame(TCPO_WINDOW + 1)
End Sub

Function TCP_FromPeer(In TcpPeerPort As Word) As Byte
    // 1 when the segment in EthFrame comes from the connection's peer
    TCP_FromPeer = 0
    If TcpPeerPort <> TCP_RemPort Then Exit Function
    If EthFrame(IP_SRC) <> TCP_RemIP1 Then Exit Function
    If EthFrame(IP_SRC + 1) <> TCP_RemIP2 Then Exit Function
    If EthFrame(IP_SRC + 2) <> TCP_RemIP3 Then Exit Function
    If EthFrame(IP_SRC + 3) <> TCP_RemIP4 Then Exit Function
    TCP_FromPeer = 1
End Function

Sub TCP_SendStream(In TcpStreamLength As Word, In TcpStreamClose)
    // Start a reply of TcpStreamLength bytes (built by TCP_FillData); TcpStreamClose = 1 sends FIN after it.
    // Called from TCP_HandleData; the segments go out when TCP_ProcessSegment finishes, and as ACKs arrive
    If TCP_Streaming = 1 Then Exit Sub
    If TCP_State <> TCP_ESTABLISHED Then
        If TCP_State <> TCP_CLOSE_WAIT Then Exit Sub
    End If
    TCP_StreamSeq = TCP_SndNxt
    TCP_StreamLength = TcpStreamLength
    TCP_StreamClose = TcpStreamClose
    TCP_FinSent = 0
    TCP_Streaming = 1
    TCP_RetryCount = 0
    TCP_RtoSeconds = TCP_RTO_FIRST
End Sub

Function TCP_Pump As Byte
    // Send the reply from TCP_SndNxt while the window and TCP_INFLIGHT allow, then FIN when it is complete and the
    // program asked to close. Returns the number of segments sent
    Dim TcpOffset, TcpCount, TcpRoom As Word
    Dim TcpInFlight, TcpWindow As Long
    Dim TcpPumpFlags As Byte

    TCP_Pump = 0
    If TCP_Streaming = 0 Then Exit Function
    TcpWindow = TCP_SndWnd
    If TcpWindow > TCP_INFLIGHT Then TcpWindow = TCP_INFLIGHT
    Do
        TcpInFlight = TCP_SndNxt - TCP_SndUna
        If TcpInFlight >= TcpWindow Then Exit Do
        TcpRoom = TcpWindow - TcpInFlight
        TcpOffset = TCP_SndNxt - TCP_StreamSeq
        If TcpOffset < TCP_StreamLength Then
            // Data: the next segment
            TcpCount = TCP_StreamLength - TcpOffset
            If TcpCount > TCP_MSS Then TcpCount = TCP_MSS
            If TcpCount > TcpRoom Then TcpCount = TcpRoom
            TcpPumpFlags = TCP_ACK Or TCP_PSH
            // FIN with the last segment when closing
            If TcpOffset + TcpCount = TCP_StreamLength Then
                If TCP_StreamClose = 1 Then TcpPumpFlags = TcpPumpFlags Or TCP_FIN
            End If
            TCP_FillData TcpOffset, TcpCount
            TCP_Output TcpPumpFlags, TCP_SndNxt, TcpCount
            TCP_SndNxt = TCP_SndNxt + TcpCount
        Else
            // All data sent: FIN alone when it has not gone with the data
            If TCP_StreamClose = 0 Then Exit Do
            If TCP_SndNxt <> TCP_StreamSeq + TCP_StreamLength Then Exit Do
            TcpPumpFlags = TCP_ACK Or TCP_FIN
            TCP_Output TcpPumpFlags, TCP_SndNxt, 0
        End If
        TCP_Pump++
        If (TcpPumpFlags And TCP_FIN) <> 0 Then
            TCP_SndNxt = TCP_SndNxt + 1
            TCP_FinSent = 1
            If TCP_State = TCP_ESTABLISHED Then TCP_State = TCP_FIN_WAIT_1
            If TCP_State = TCP_CLOSE_WAIT Then TCP_State = TCP_LAST_ACK
        End If
        If TCP_SndNxt - TCP_SndMax < 0x80000000 Then TCP_SndMax = TCP_SndNxt
        If TCP_RtoLeft = 0 Then TCP_RtoLeft = TCP_RtoSeconds
        If (TcpPumpFlags And TCP_FIN) <> 0 Then Exit Do
    Loop
End Function

Sub TCP_Tick
    // Once a second, for each connection
    TCP_Use 0
    TCP_TickOne
    TCP_Use TCP_SERVER2
    TCP_TickOne
    TCP_Use 1
    TCP_TickOne
    #if TCP_TERMINAL = 1
        TCP_Use 2
        TCP_TickOne
    #endif
End Sub

Sub TCP_TickOne
    // Reset an idle server connection; when something is unacknowledged for the retransmission wait, send it again
    // from the oldest unacknowledged byte (go-back-N), doubling the wait; reset after TCP_RETRIES
    If TCP_State = TCP_LISTEN Then Exit Sub
    // Nothing outstanding: a server connection waits for the peer at most TCP_IDLE_S seconds
    If TCP_SndUna = TCP_SndMax Then
        // Only the server connections (0, 3) have an idle reset
        If TCP_Conn = 1 Then Exit Sub
        If TCP_Conn = 2 Then Exit Sub
        TCP_IdleLeft--
        If TCP_IdleLeft = 0 Then TCP_Abort
        Exit Sub
    End If
    If TCP_RtoLeft > 1 Then
        TCP_RtoLeft--
        Exit Sub
    End If
    If TCP_RetryCount >= TCP_RETRIES Then
        TCP_Abort
        Exit Sub
    End If
    TCP_RetryCount++
    TCP_RtoSeconds = TCP_RtoSeconds * 2
    TCP_RtoLeft = 0
    #if STACK_STATS = 1
        Stat_TcpRetransmits++
    #endif
    If TCP_State = TCP_SYN_RCVD Then
        TCP_Output TCP_SYN Or TCP_ACK, TCP_SndUna, 0
        TCP_RtoLeft = TCP_RtoSeconds
        Exit Sub
    End If
    If TCP_State = TCP_SYN_SENT Then
        TCP_Output TCP_SYN, TCP_SndUna, 0
        TCP_RtoLeft = TCP_RtoSeconds
        Exit Sub
    End If
    // Go back to the oldest unacknowledged byte; a FIN not yet acknowledged goes again too
    TCP_SndNxt = TCP_SndUna
    TCP_FinSent = 0
    If TCP_Pump = 0 Then TCP_RtoLeft = TCP_RtoSeconds
End Sub

Sub TCP_Abort
    // Reset the connection and listen again
    TCP_Output TCP_RST, TCP_SndNxt, 0
    #if STACK_STATS = 1
        Stat_TcpResets++
    #endif
    TCP_Close
End Sub

Sub TCP_Close
    // The connection is over: the server listens again, the client is closed
    TCP_State = TCP_LISTEN
    TCP_Streaming = 0
    TCP_StreamClose = 0
    TCP_FinSent = 0
    TCP_RtoLeft = 0
End Sub

// ----- The two connections

Sub TCP_Use(In TcpWanted)
    // Make connection TcpWanted (0 server, 1 client, 2 terminal server) the one in use: keep the current one's state,
    // take the wanted one's
    If TcpWanted = TCP_Conn Then Exit Sub
    TCP_Keep
    TCP_Conn = TcpWanted
    TCP_Take
End Sub

Sub TCP_Keep
    Dim TcpKeepIndex As Byte
    // Keep connection TCP_Conn's state in the per-connection arrays
    TCP_K_State(TCP_Conn) = TCP_State
    TCP_K_RemIP1(TCP_Conn) = TCP_RemIP1
    TCP_K_RemIP2(TCP_Conn) = TCP_RemIP2
    TCP_K_RemIP3(TCP_Conn) = TCP_RemIP3
    TCP_K_RemIP4(TCP_Conn) = TCP_RemIP4
    TCP_K_Streaming(TCP_Conn) = TCP_Streaming
    TCP_K_StreamClose(TCP_Conn) = TCP_StreamClose
    TCP_K_FinSent(TCP_Conn) = TCP_FinSent
    TCP_K_RtoSeconds(TCP_Conn) = TCP_RtoSeconds
    TCP_K_RtoLeft(TCP_Conn) = TCP_RtoLeft
    TCP_K_RetryCount(TCP_Conn) = TCP_RetryCount
    TCP_K_IdleLeft(TCP_Conn) = TCP_IdleLeft
    TCP_K_RemPort(TCP_Conn) = TCP_RemPort
    TCP_K_SndWnd(TCP_Conn) = TCP_SndWnd
    TCP_K_LocalPort(TCP_Conn) = TCP_LocalPort
    TCP_K_StreamLength(TCP_Conn) = TCP_StreamLength
    TCP_K_SndUna(TCP_Conn) = TCP_SndUna
    TCP_K_SndNxt(TCP_Conn) = TCP_SndNxt
    TCP_K_SndMax(TCP_Conn) = TCP_SndMax
    TCP_K_RcvNxt(TCP_Conn) = TCP_RcvNxt
    TCP_K_StreamSeq(TCP_Conn) = TCP_StreamSeq
    For TcpKeepIndex = 0 To 5
        TCP_K_RemMAC(TCP_Conn * 6 + TcpKeepIndex) = TCP_RemMAC(TcpKeepIndex)
    Next
End Sub

Sub TCP_Take
    Dim TcpKeepIndex As Byte
    // Take connection TCP_Conn's state from the per-connection arrays
    TCP_State = TCP_K_State(TCP_Conn)
    TCP_RemIP1 = TCP_K_RemIP1(TCP_Conn)
    TCP_RemIP2 = TCP_K_RemIP2(TCP_Conn)
    TCP_RemIP3 = TCP_K_RemIP3(TCP_Conn)
    TCP_RemIP4 = TCP_K_RemIP4(TCP_Conn)
    TCP_Streaming = TCP_K_Streaming(TCP_Conn)
    TCP_StreamClose = TCP_K_StreamClose(TCP_Conn)
    TCP_FinSent = TCP_K_FinSent(TCP_Conn)
    TCP_RtoSeconds = TCP_K_RtoSeconds(TCP_Conn)
    TCP_RtoLeft = TCP_K_RtoLeft(TCP_Conn)
    TCP_RetryCount = TCP_K_RetryCount(TCP_Conn)
    TCP_IdleLeft = TCP_K_IdleLeft(TCP_Conn)
    TCP_RemPort = TCP_K_RemPort(TCP_Conn)
    TCP_SndWnd = TCP_K_SndWnd(TCP_Conn)
    TCP_LocalPort = TCP_K_LocalPort(TCP_Conn)
    TCP_StreamLength = TCP_K_StreamLength(TCP_Conn)
    TCP_SndUna = TCP_K_SndUna(TCP_Conn)
    TCP_SndNxt = TCP_K_SndNxt(TCP_Conn)
    TCP_SndMax = TCP_K_SndMax(TCP_Conn)
    TCP_RcvNxt = TCP_K_RcvNxt(TCP_Conn)
    TCP_StreamSeq = TCP_K_StreamSeq(TCP_Conn)
    For TcpKeepIndex = 0 To 5
        TCP_RemMAC(TcpKeepIndex) = TCP_K_RemMAC(TCP_Conn * 6 + TcpKeepIndex)
    Next
End Sub

// ----- Client connection

Sub TCP_Connect(In TcpCon1, In TcpCon2, In TcpCon3, In TcpCon4, In TcpConPort As Word)
    // Open the client connection to TcpCon1-4, port TcpConPort: sends the SYN. TCP_ClientState tells when it is open
    Dim TcpConSlot, TcpConIndex As Byte
    Dim TcpConBase As Byte
    // The next hop's MAC first: resolving uses EthFrame and receives frames (which may change the connection in use)
    TcpConSlot = IP_ResolveNextHop(TcpCon1, TcpCon2, TcpCon3, TcpCon4)
    If TcpConSlot = ARP_NOT_FOUND Then Exit Sub
    TCP_Use 1
    If TCP_State <> TCP_LISTEN Then Exit Sub
    TcpConBase = TcpConSlot * 6
    For TcpConIndex = 0 To 5
        TCP_RemMAC(TcpConIndex) = ARP_CacheMAC(TcpConBase + TcpConIndex)
    Next
    TCP_RemIP1 = TcpCon1 : TCP_RemIP2 = TcpCon2 : TCP_RemIP3 = TcpCon3 : TCP_RemIP4 = TcpCon4
    TCP_RemPort = TcpConPort
    // A new local port for each connection, so a late segment of the last one is not taken for this one
    TCP_NextClientPort++
    If TCP_NextClientPort < TCP_CLIENT_PORT_FIRST Then TCP_NextClientPort = TCP_CLIENT_PORT_FIRST
    TCP_LocalPort = TCP_NextClientPort
    TCP_SndWnd = TCP_MSS
    TCP_RcvNxt = 0
    TCP_IssCount = TCP_IssCount + 4099
    TCP_SndUna = Millis() * 250 + TCP_IssCount
    TCP_Streaming = 0
    TCP_StreamClose = 0
    TCP_FinSent = 0
    TCP_RetryCount = 0
    TCP_RtoSeconds = TCP_RTO_FIRST
    TCP_State = TCP_SYN_SENT
    TCP_Output TCP_SYN, TCP_SndUna, 0
    TCP_RtoLeft = TCP_RtoSeconds
    TCP_SndNxt = TCP_SndUna + 1
    TCP_SndMax = TCP_SndNxt
End Sub

// ----- Any connection by number (the terminal uses connection 2)

Function TCP_ConnState(In TcpStateConn) As Byte
    TCP_Use TcpStateConn
    TCP_ConnState = TCP_State
End Function

Function TCP_ConnBusy(In TcpBusyConn) As Byte
    TCP_Use TcpBusyConn
    TCP_ConnBusy = TCP_Streaming
End Function

Sub TCP_ConnSend(In TcpSendConn, In TcpSendLength As Word)
    // Send TcpSendLength bytes on connection TcpSendConn (built by TCP_FillData), without close
    TCP_Use TcpSendConn
    TCP_SendStream TcpSendLength, 0
    If TCP_Pump = 0 Then Exit Sub
End Sub

Function TCP_ClientState As Byte
    // The client connection's state: TCP_LISTEN (closed), TCP_SYN_SENT, TCP_ESTABLISHED, ...
    TCP_Use 1
    TCP_ClientState = TCP_State
End Function

Function TCP_ClientBusy As Byte
    // 1 while the client connection is sending a stream (the next TCP_ClientSend must wait)
    TCP_Use 1
    TCP_ClientBusy = TCP_Streaming
End Function

Sub TCP_ClientSend(In TcpClientLength As Word)
    // Send TcpClientLength bytes on the client connection (built by TCP_FillData with TCP_Conn = 1), without close
    TCP_Use 1
    TCP_SendStream TcpClientLength, 0
    If TCP_Pump = 0 Then Exit Sub
End Sub

Sub TCP_ClientClose
    // Reset the client connection (the application gave up on it)
    TCP_Use 1
    If TCP_State = TCP_LISTEN Then Exit Sub
    TCP_Abort
End Sub

Sub TCP_Output(In TcpOutFlags, In TcpOutSeq As Long, In TcpOutLength As Word)
    // Send a segment to the peer: TcpOutLength data bytes already in EthFrame from TCP_DATA (a SYN carries the MSS option
    // instead)
    Dim TcpOutIndex, TcpOutHeader As Byte
    Dim TcpOutSum As Word

    TcpOutHeader = TCP_HEADER_LENGTH
    If (TcpOutFlags And TCP_SYN) <> 0 Then
        // MSS option: kind 2, length 4, the value
        TcpOutHeader = TCP_HEADER_LENGTH + 4
        EthFrame(TCPO_OPTIONS) = 2
        EthFrame(TCPO_OPTIONS + 1) = 4
        EthFrame(TCPO_OPTIONS + 2) = TCP_MSS / 256
        EthFrame(TCPO_OPTIONS + 3) = TCP_MSS And 255
    End If
    TCP_SegLength = TcpOutHeader + TcpOutLength

    // Ethernet and IP headers to the peer
    For TcpOutIndex = 0 To 5
        EthFrame(ETH_DEST + TcpOutIndex) = TCP_RemMAC(TcpOutIndex)
    Next
    EthFrame(ETH_TYPE) = 0x08
    EthFrame(ETH_TYPE + 1) = 0x00
    EthFrame(IP_DST) = TCP_RemIP1 : EthFrame(IP_DST + 1) = TCP_RemIP2 : EthFrame(IP_DST + 2) = TCP_RemIP3 : EthFrame(IP_DST + 3) = TCP_RemIP4
    IP_SetMyAddresses
    IP_Length = IP_HEADER_LENGTH + TCP_SegLength
    EthFrame(IP_VERHL) = 0x45
    EthFrame(IP_TOS) = 0
    EthFrame(IP_TOTLEN) = IP_Length_H
    EthFrame(IP_TOTLEN + 1) = [byte]IP_Length
    EthFrame(IP_FLAGFRAG) = 0
    EthFrame(IP_FLAGFRAG + 1) = 0
    EthFrame(IP_TTL) = IP_DEFAULT_TTL
    EthFrame(IP_PROTO) = IP_PROTO_TCP
    IP_SetIdentAndChecksum

    // TCP header
    EthFrame(TCPO_SRCPORT) = TCP_LocalPort_H
    EthFrame(TCPO_SRCPORT + 1) = [byte]TCP_LocalPort
    EthFrame(TCPO_DSTPORT) = TCP_RemPort_H
    EthFrame(TCPO_DSTPORT + 1) = [byte]TCP_RemPort
    EthFrame(TCPO_SEQ) = TcpOutSeq_E : EthFrame(TCPO_SEQ + 1) = TcpOutSeq_U
    EthFrame(TCPO_SEQ + 2) = TcpOutSeq_H : EthFrame(TCPO_SEQ + 3) = [byte]TcpOutSeq
    EthFrame(TCPO_ACK) = TCP_RcvNxt_E : EthFrame(TCPO_ACK + 1) = TCP_RcvNxt_U
    EthFrame(TCPO_ACK + 2) = TCP_RcvNxt_H : EthFrame(TCPO_ACK + 3) = [byte]TCP_RcvNxt
    EthFrame(TCPO_OFFSET) = TcpOutHeader * 4
    EthFrame(TCPO_FLAGS) = TcpOutFlags
    // Window: one segment
    EthFrame(TCPO_WINDOW) = TCP_MSS / 256
    EthFrame(TCPO_WINDOW + 1) = TCP_MSS And 255
    EthFrame(TCPO_CHECKSUM) = 0
    EthFrame(TCPO_CHECKSUM + 1) = 0
    EthFrame(TCPO_URGENT) = 0
    EthFrame(TCPO_URGENT + 1) = 0
    TcpOutSum = TCP_Checksum(TCP_SegLength)
    EthFrame(TCPO_CHECKSUM) = TcpOutSum_H
    EthFrame(TCPO_CHECKSUM + 1) = [byte]TcpOutSum

    If ENC_Transmit(IP_Length + IP_VERHL) Then
        #if STACK_STATS = 1
            Stat_TcpSent++
        #endif
    End If
End Sub

Sub TCP_Refuse
    // Reset for a segment that has no connection (another port, another peer, or an ACK while listening).
    // Built in place from the received segment; never in answer to a reset
    Dim TcpRefIndex, TcpRefSwap As Byte
    Dim TcpRefAck As Long
    Dim TcpRefSum As Word

    If (TCP_SegFlags And TCP_RST) <> 0 Then Exit Sub
    #if STACK_STATS = 1
        Stat_TcpRefused++
    #endif
    // Ports swapped
    For TcpRefIndex = 0 To 1
        TcpRefSwap = EthFrame(TCPO_SRCPORT + TcpRefIndex)
        EthFrame(TCPO_SRCPORT + TcpRefIndex) = EthFrame(TCPO_DSTPORT + TcpRefIndex)
        EthFrame(TCPO_DSTPORT + TcpRefIndex) = TcpRefSwap
    Next
    If (TCP_SegFlags And TCP_ACK) <> 0 Then
        // RST with the sequence number the peer expects
        EthFrame(TCPO_SEQ) = TCP_SegAck_E : EthFrame(TCPO_SEQ + 1) = TCP_SegAck_U
        EthFrame(TCPO_SEQ + 2) = TCP_SegAck_H : EthFrame(TCPO_SEQ + 3) = [byte]TCP_SegAck
        EthFrame(TCPO_FLAGS) = TCP_RST
        TcpRefAck = 0
    Else
        // RST + ACK of everything in the segment (a SYN and a FIN count as one each)
        EthFrame(TCPO_SEQ) = 0 : EthFrame(TCPO_SEQ + 1) = 0 : EthFrame(TCPO_SEQ + 2) = 0 : EthFrame(TCPO_SEQ + 3) = 0
        EthFrame(TCPO_FLAGS) = TCP_RST Or TCP_ACK
        TcpRefAck = TCP_SegSeq + TCP_RxLength
        If (TCP_SegFlags And TCP_SYN) <> 0 Then TcpRefAck++
        If (TCP_SegFlags And TCP_FIN) <> 0 Then TcpRefAck++
    End If
    EthFrame(TCPO_ACK) = TcpRefAck_E : EthFrame(TCPO_ACK + 1) = TcpRefAck_U
    EthFrame(TCPO_ACK + 2) = TcpRefAck_H : EthFrame(TCPO_ACK + 3) = [byte]TcpRefAck
    EthFrame(TCPO_OFFSET) = TCP_HEADER_LENGTH * 4
    EthFrame(TCPO_WINDOW) = 0
    EthFrame(TCPO_WINDOW + 1) = 0
    EthFrame(TCPO_URGENT) = 0
    EthFrame(TCPO_URGENT + 1) = 0
    // A bare header goes back
    IP_Length = IP_HEADER_LENGTH + TCP_HEADER_LENGTH
    EthFrame(IP_TOTLEN) = IP_Length_H
    EthFrame(IP_TOTLEN + 1) = [byte]IP_Length
    IP_PrepareReply
    EthFrame(TCPO_CHECKSUM) = 0
    EthFrame(TCPO_CHECKSUM + 1) = 0
    TcpRefSum = TCP_Checksum(TCP_HEADER_LENGTH)
    EthFrame(TCPO_CHECKSUM) = TcpRefSum_H
    EthFrame(TCPO_CHECKSUM + 1) = [byte]TcpRefSum
    If ENC_Transmit(IP_Length + IP_VERHL) Then
        #if STACK_STATS = 1
            Stat_TcpSent++
        #endif
    End If
End Sub

Function TCP_Checksum(In TcpCkLength As Word) As Word
    // Internet checksum of the pseudo-header (source and destination IP, protocol 6, TCP length) and TcpCkLength bytes
    // of the segment from TCPO_SRCPORT. Over a segment that holds a correct checksum the result is 0
    Dim TcpCkSum As Long
    Dim TcpCkWord, TcpCkIndex, TcpCkCount As Word
    TcpCkSum = IP_PROTO_TCP + TcpCkLength
    // The segment starts right after the addresses (IP_SRC + 8 = TCPO_SRCPORT), so one pass covers both
    TcpCkIndex = IP_SRC
    TcpCkCount = 8 + TcpCkLength
    Do While TcpCkCount > 1
        TcpCkWord_H = EthFrame(TcpCkIndex)
        [byte]TcpCkWord = EthFrame(TcpCkIndex + 1)
        TcpCkSum = TcpCkSum + TcpCkWord
        TcpCkIndex = TcpCkIndex + 2
        TcpCkCount = TcpCkCount - 2
    Loop
    If TcpCkCount = 1 Then
        TcpCkWord_H = EthFrame(TcpCkIndex)
        [byte]TcpCkWord = 0
        TcpCkSum = TcpCkSum + TcpCkWord
    End If
    Do While TcpCkSum_U <> 0 Or TcpCkSum_E <> 0
        [byte]TcpCkWord = TcpCkSum_U
        TcpCkWord_H = TcpCkSum_E
        TcpCkSum_U = 0
        TcpCkSum_E = 0
        TcpCkSum = TcpCkSum + TcpCkWord
    Loop
    [byte]TCP_Checksum = 255 - [byte]TcpCkSum
    TCP_Checksum_H = 255 - TcpCkSum_H
End Function

#if STACK_STATS = 1
#if STACK_CONSOLE <> 0
Sub TCP_PrintStats
    CONSOLE_Print "TCP received " : CONSOLE_Number Stat_RxTcp
    CONSOLE_Print "  bad checksum " : CONSOLE_Number Stat_TcpBadChecksum
    CONSOLE_Print "  refused " : CONSOLE_Number Stat_TcpRefused
    CONSOLE_Print "  connects " : CONSOLE_Number Stat_TcpConnects
    CONSOLE_Print "  sent " : CONSOLE_Number Stat_TcpSent
    CONSOLE_Print "  resent " : CONSOLE_Number Stat_TcpRetransmits
    CONSOLE_Print "  reset " : CONSOLE_Number Stat_TcpResets
    CONSOLE_Print "  out of order " : CONSOLE_Number Stat_TcpOutOfOrder
    CONSOLE_CRLF
End Sub
#endif
#endif
