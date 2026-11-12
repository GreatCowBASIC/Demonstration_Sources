//--------------------------------------------------------------------------------------------------------------------------------
// Serial to UDP and back: what comes in on the serial port goes out on Ethernet, and the other way round
// (UDP mode of a serial-to-Ethernet module such as the WIZnet WIZ107SR)
//
// Serial to UDP: every byte received on the hardware serial port (serial port 1, at the program's USART_BAUD_RATE) is sent
// unchanged - line ends, binary bytes and 0 bytes as they come - from port SERUDP_PORT (50001). The bytes are collected
// and sent as one datagram ("packing", as the WIZ107SR's packing time, size and character) when
//   - SERUDP_GAP_MS (20 ms) pass without a new byte, or
//   - SERUDP_MAX_LENGTH (128) bytes have been collected, or
//   - the byte SERUDP_PACK_CHAR arrives (optional, e.g. 13 for CR; it is sent as the last byte of the datagram).
//
// UDP to serial: the data of every datagram sent to this device's address, port SERUDP_PORT, goes out on the serial
// port (TX) unchanged. Datagrams to the broadcast address are not passed on.
//
// The peer (optional, for security):
//   - Without SERUDP_REMOTE_IP1-4: serial data goes out as a broadcast to 255.255.255.255, port SERUDP_PORT, and
//     datagrams from any host are passed to the serial port.
//   - With SERUDP_REMOTE_IP1-4 and SERUDP_REMOTE_PORT (both required): serial data goes only to that host and
//     port (through the gateway when it is not on our subnet), and only datagrams from that host's address are passed
//     to the serial port; others are counted in SerUdp_Rejected and dropped. When the host (or the gateway) does not
//     answer ARP the datagram is dropped and counted in SerUdp_Unreachable; the ARP attempt blocks for up to
//     ARP_RETRIES x ARP_REPLY_TIMEOUT_MS, and serial bytes arriving meanwhile beyond the ring are lost.
//
// Reception is by the receive interrupt (SerialRxBuffer.h): the ring holds SERRX_BUFFER_SIZE - 1 bytes while the
// main loop is busy. About 9.8 kbytes/s get through (measured at 115200 with a 128-byte ring, test 019: bursts of up to
// 255 bytes whole, continuous input lost bytes), so use a speed up to about 57600 for continuous data; 19200 is
// 1.9 kbytes/s and fills a 128-byte ring in 66 ms.
//
// The serial port must be free: not with the serial console (STACK_CONSOLE 1). The stack checks that.
//
// The program calls SerUdp_Init once (Stack_Init does) and SerUdp_Service as often as it can, from the main loop
// (not from inside frame handling: it builds the datagram in EthFrame).
//
// The program may define (defaults below):
//   SERUDP_PORT          local UDP port, and the destination port of broadcasts (50001)
//   SERUDP_MAX_LENGTH    most bytes in one datagram (128)
//   SERUDP_GAP_MS        quiet time that ends a datagram (20 ms)
//   SERUDP_PACK_CHAR     a byte that ends a datagram (not defined: none)
//   SERUDP_REMOTE_IP1-4  the one peer (not defined: broadcast, any sender)
//   SERUDP_REMOTE_PORT   the peer's port (required with SERUDP_REMOTE_IP1-4)
//   SERRX_BUFFER_SIZE    receive ring, a power of two up to 1024 (SerialRxBuffer.h; the default 32 is small here)
//
//@author    Evan R. Venn
//@licence   GPL
//@date      04/11/2026
//
// Changes:
//   01/11/2026  2026 initial release
//   01/11/2026  Comments no longer name one chip family
//   04/11/2026  #option explicit
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

    #include <SerialRxBuffer.h>

// ----- Options

    #ifndef SERUDP_PORT
        #define SERUDP_PORT 50001
    #endif
    #ifndef SERUDP_MAX_LENGTH
        #define SERUDP_MAX_LENGTH 128
    #endif
    #ifndef SERUDP_GAP_MS
        #define SERUDP_GAP_MS 20
    #endif
    // SERUDP_REMOTE_PORT has no default: a default inside #ifdef gives a warning when the program defines it

// ----- Variables
    // Bytes collected for the next datagram, and when the latest one came in
    Dim SerUdp_Data(SERUDP_MAX_LENGTH)
    Dim SerUdp_Count As Byte
    Dim SerUdp_LastByte As Long
    // Datagrams sent and received; with a fixed peer also those from other hosts, and those the peer was not reachable for
    Dim SerUdp_Sent, SerUdp_Received As Word
    #ifdef SERUDP_REMOTE_IP1
        Dim SerUdp_Rejected, SerUdp_Unreachable As Word
    #endif

// ----- Serial to UDP

Sub SerUdp_Init
    // RAM is not cleared at reset
    SerUdp_Count = 0
    SerUdp_Sent = 0
    SerUdp_Received = 0
    #ifdef SERUDP_REMOTE_IP1
        SerUdp_Rejected = 0
        SerUdp_Unreachable = 0
    #endif
    SerRx_Init
End Sub

Sub SerUdp_ProcessDatagram
    // UDP to serial: a datagram to our address, port SERUDP_PORT, is in EthFrame. Its data goes out on the serial port
    // unchanged (blocking: 128 bytes take 67 ms at 19200)
    Dim SerUdpOutIndex, SerUdpOutEnd As Word
    #ifdef SERUDP_REMOTE_IP1
        // Only from the peer
        Dim SerUdpFromPeer As Byte
        SerUdpFromPeer = 1
        If EthFrame(IP_SRC) <> SERUDP_REMOTE_IP1 Then SerUdpFromPeer = 0
        If EthFrame(IP_SRC + 1) <> SERUDP_REMOTE_IP2 Then SerUdpFromPeer = 0
        If EthFrame(IP_SRC + 2) <> SERUDP_REMOTE_IP3 Then SerUdpFromPeer = 0
        If EthFrame(IP_SRC + 3) <> SERUDP_REMOTE_IP4 Then SerUdpFromPeer = 0
        If SerUdpFromPeer = 0 Then
            SerUdp_Rejected++
            Exit Sub
        End If
    #endif
    SerUdpOutEnd = UDP_DATA + UDP_SegLength - UDP_HEADER_LENGTH
    For SerUdpOutIndex = UDP_DATA To SerUdpOutEnd - 1
        HSerSend EthFrame(SerUdpOutIndex)
    Next
    SerUdp_Received++
End Sub

Sub SerUdp_Service
    // Move what has come in into the datagram; send it when full, at the packing character, or when the line has been
    // quiet SERUDP_GAP_MS
    Dim SerUdpByte As Byte
    If SerRx_Available Then
        Do While SerRx_Available
            SerUdpByte = SerRx_Read
            SerUdp_Count++
            SerUdp_Data(SerUdp_Count) = SerUdpByte
            If SerUdp_Count = SERUDP_MAX_LENGTH Then
                SerUdp_Send
            Else
                #ifdef SERUDP_PACK_CHAR
                    If SerUdpByte = SERUDP_PACK_CHAR Then SerUdp_Send
                #endif
            End If
        Loop
        SerUdp_LastByte = Millis()
    End If
    If SerUdp_Count = 0 Then Exit Sub
    If Millis() - SerUdp_LastByte >= SERUDP_GAP_MS Then SerUdp_Send
End Sub

Sub SerUdp_Send
    // The collected bytes as one datagram from SERUDP_PORT: to the peer, or broadcast
    Dim SerUdpIndex As Byte
    Dim SerUdpPort As Word
    #ifdef SERUDP_REMOTE_IP1
        Dim SerUdpSlot As Byte
        // The peer's MAC (or the gateway's) before anything is written to EthFrame: ARP uses it
        SerUdpSlot = IP_ResolveNextHop(SERUDP_REMOTE_IP1, SERUDP_REMOTE_IP2, SERUDP_REMOTE_IP3, SERUDP_REMOTE_IP4)
        If SerUdpSlot = ARP_NOT_FOUND Then
            SerUdp_Unreachable++
            SerUdp_Count = 0
            Exit Sub
        End If
    #endif
    For SerUdpIndex = 1 To SerUdp_Count
        EthFrame(UDP_DATA + SerUdpIndex - 1) = SerUdp_Data(SerUdpIndex)
    Next
    UDP_SegLength = UDP_HEADER_LENGTH + SerUdp_Count
    #ifdef SERUDP_REMOTE_IP1
        IP_BuildHeaderTo SerUdpSlot, SERUDP_REMOTE_IP1, SERUDP_REMOTE_IP2, SERUDP_REMOTE_IP3, SERUDP_REMOTE_IP4, IP_PROTO_UDP, UDP_SegLength
        SerUdpPort = SERUDP_REMOTE_PORT
    #endif
    #ifndef SERUDP_REMOTE_IP1
        IP_BuildHeaderBroadcast IP_PROTO_UDP, UDP_SegLength
        SerUdpPort = SERUDP_PORT
    #endif
    EthFrame(UDP_DSTPORT) = SerUdpPort_H
    EthFrame(UDP_DSTPORT + 1) = [byte]SerUdpPort
    SerUdpPort = SERUDP_PORT
    EthFrame(UDP_SRCPORT) = SerUdpPort_H
    EthFrame(UDP_SRCPORT + 1) = [byte]SerUdpPort
    EthFrame(UDP_LENGTH) = UDP_SegLength_H
    EthFrame(UDP_LENGTH + 1) = [byte]UDP_SegLength
    UDP_SetChecksum
    If ENC_Transmit(IP_Length + IP_VERHL) Then SerUdp_Sent++
    SerUdp_Count = 0
End Sub
