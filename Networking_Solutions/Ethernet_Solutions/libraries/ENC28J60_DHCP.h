//--------------------------------------------------------------------------------------------------------------------------------
// DHCP client for the ENC28J60 stack (RFC 2131, UDP ports 68 and 67)
//
//   - DHCP_Start: DISCOVER, OFFER, REQUEST, ACK (broadcast), with retries. On ACK the IP, subnet mask and gateway are
//     set (NET_SetIP, IP_SetMaskGateway) and the lease starts
//   - DHCP_Tick, once a second: renews the lease at half its time by a unicast REQUEST to the server, retries every
//     60 s, and drops the address when the lease runs out
//   - Each answer is checked: BOOTREPLY, our transaction ID, our MAC; NAK is reported
//   - The first DNS server (option 6) is kept in DHCP_Dns1-4 (0.0.0.0 when the server gives none)
//
// Needs ENC28J60_Driver.h, ENC28J60_ARP.h, ENC28J60_IPv4.h, ENC28J60_UDP.h and millis.h.
//
// The program may define (defaults below):
//   DHCP_RETRIES, DHCP_TIMEOUT_MS, DHCP_HOSTNAME
//
// The program calls DHCP_Init once at start-up, DHCP_ProcessReply from UDP_HandleDatagram for datagrams from port 67
// to port 68 (also when IP_RxBroadcast is 1), and DHCP_Tick once a second.
//
//@author    Evan R. Venn
//@licence   GPL
//@date      04/11/2026
//
// Changes:
//   01/11/2026  2026 initial release
//   01/11/2026  CON_ names renamed CONSOLE_
//   04/11/2026  #option explicit
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

    // Attempts for each exchange (DISCOVER and REQUEST)
    #ifndef DHCP_RETRIES
        #define DHCP_RETRIES 3
    #endif
    // Wait for each answer
    #ifndef DHCP_TIMEOUT_MS
        #define DHCP_TIMEOUT_MS 3000
    #endif
    // Name shown in the router's client list (option 12)
    #ifndef DHCP_HOSTNAME
        #define DHCP_HOSTNAME "enc28j60"
    #endif

    #define DHCP_CLIENT_PORT 68
    #define DHCP_SERVER_PORT 67

// ----- DHCP message. Offsets are from the first byte of the Ethernet header (UDP data starts at 42)
    #define DHCPO_OP       42
    #define DHCPO_HTYPE    43
    #define DHCPO_HLEN     44
    #define DHCPO_XID      46
    #define DHCPO_FLAGS    52
    #define DHCPO_CIADDR   54
    #define DHCPO_YIADDR   58
    #define DHCPO_CHADDR   70
    #define DHCPO_MAGIC    278
    #define DHCPO_OPTIONS  282
    // A BOOTP message is at least 300 bytes; ours are padded to that
    #define DHCP_MESSAGE_LENGTH 300

    // Message types (option 53)
    #define DHCP_DISCOVER 1
    #define DHCP_OFFER    2
    #define DHCP_REQUEST  3
    #define DHCP_ACK      5
    #define DHCP_NAK      6

    // DHCP_Tick results
    #define DHCP_TICK_NOTHING  0
    #define DHCP_TICK_RENEWED  1
    #define DHCP_TICK_FAILED   2
    #define DHCP_TICK_EXPIRED  3

// ----- Variables
    Dim DHCP_Xid As Long
    // Lease: length and time since it was granted or renewed, in seconds
    Dim DHCP_LeaseTime, DHCP_Elapsed As Long
    Dim DHCP_Bound, DHCP_RetryCountdown As Byte
    // The server that granted the lease (option 54)
    Dim DHCP_Server1, DHCP_Server2, DHCP_Server3, DHCP_Server4 As Byte
    // The first DNS server of the lease (option 6); 0.0.0.0 when none was given
    Dim DHCP_Dns1, DHCP_Dns2, DHCP_Dns3, DHCP_Dns4 As Byte

    // Latest answer, filled by DHCP_ProcessReply
    Dim DHCP_Answered, DHCP_RxType As Byte
    Dim DHCP_RxIP1, DHCP_RxIP2, DHCP_RxIP3, DHCP_RxIP4 As Byte
    Dim DHCP_RxMask1, DHCP_RxMask2, DHCP_RxMask3, DHCP_RxMask4 As Byte
    Dim DHCP_RxRouter1, DHCP_RxRouter2, DHCP_RxRouter3, DHCP_RxRouter4 As Byte
    Dim DHCP_RxServer1, DHCP_RxServer2, DHCP_RxServer3, DHCP_RxServer4 As Byte
    Dim DHCP_RxDns1, DHCP_RxDns2, DHCP_RxDns3, DHCP_RxDns4 As Byte
    Dim DHCP_RxLease As Long

    // Building a message
    Dim DHCP_Pos As Word

    #if STACK_STATS = 1
        // Statistics
        Dim Stat_DhcpSent, Stat_DhcpOffers, Stat_DhcpAcks, Stat_DhcpNaks, Stat_DhcpBad, Stat_DhcpTimeouts, Stat_DhcpRenewals As Word
    #endif

// ----- DHCP

Sub DHCP_Init
    // RAM is not cleared at reset
    DHCP_Xid = 0
    DHCP_Bound = 0
    DHCP_LeaseTime = 0
    DHCP_Elapsed = 0
    DHCP_RetryCountdown = 0
    DHCP_Answered = 0
    DHCP_Dns1 = 0 : DHCP_Dns2 = 0 : DHCP_Dns3 = 0 : DHCP_Dns4 = 0
    #if STACK_STATS = 1
        Stat_DhcpSent = 0
        Stat_DhcpOffers = 0
        Stat_DhcpAcks = 0
        Stat_DhcpNaks = 0
        Stat_DhcpBad = 0
        Stat_DhcpTimeouts = 0
        Stat_DhcpRenewals = 0
    #endif
End Sub

Function DHCP_Start As Byte
    // Get an address: DISCOVER / OFFER, then REQUEST / ACK. Returns 1 when bound
    Dim DhcpTry As Byte

    DHCP_Start = 0
    DHCP_Bound = 0
    NET_SetIP 0, 0, 0, 0
    IP_SetMaskGateway 0, 0, 0, 0, 0, 0, 0, 0
    // A new transaction ID: "GC" and the time since start-up
    DHCP_Xid = 0x47430000 + (Millis() And 0xFFFF)

    // DISCOVER until an OFFER arrives
    For DhcpTry = 1 To DHCP_RETRIES
        DHCP_SendMessage DHCP_DISCOVER, 0
        If DHCP_WaitFor(DHCP_OFFER) Then Exit For
    Next
    If DHCP_RxType <> DHCP_OFFER Or DHCP_Answered = 0 Then Exit Function
    #if STACK_STATS = 1
        Stat_DhcpOffers++
    #endif

    // The offer: the address and the server that made it
    DHCP_Server1 = DHCP_RxServer1 : DHCP_Server2 = DHCP_RxServer2 : DHCP_Server3 = DHCP_RxServer3 : DHCP_Server4 = DHCP_RxServer4

    // REQUEST the offered address until ACK or NAK
    For DhcpTry = 1 To DHCP_RETRIES
        DHCP_SendMessage DHCP_REQUEST, 0
        If DHCP_WaitFor(DHCP_ACK) Then Exit For
        If DHCP_RxType = DHCP_NAK And DHCP_Answered = 1 Then Exit Function
    Next
    If DHCP_RxType <> DHCP_ACK Or DHCP_Answered = 0 Then Exit Function

    DHCP_Bind
    DHCP_Start = 1
End Function

Sub DHCP_Bind
    // Use the address in the ACK and start the lease
    #if STACK_STATS = 1
        Stat_DhcpAcks++
    #endif
    NET_SetIP DHCP_RxIP1, DHCP_RxIP2, DHCP_RxIP3, DHCP_RxIP4
    IP_SetMaskGateway DHCP_RxMask1, DHCP_RxMask2, DHCP_RxMask3, DHCP_RxMask4, DHCP_RxRouter1, DHCP_RxRouter2, DHCP_RxRouter3, DHCP_RxRouter4
    DHCP_Dns1 = DHCP_RxDns1 : DHCP_Dns2 = DHCP_RxDns2 : DHCP_Dns3 = DHCP_RxDns3 : DHCP_Dns4 = DHCP_RxDns4
    DHCP_LeaseTime = DHCP_RxLease
    // No lease time given: renew every hour
    If DHCP_LeaseTime = 0 Then DHCP_LeaseTime = 7200
    DHCP_Elapsed = 0
    DHCP_RetryCountdown = 0
    DHCP_Bound = 1
End Sub

Function DHCP_Renew As Byte
    // RENEWING: unicast REQUEST to the server that granted the lease, our address in ciaddr. Returns 1 on ACK
    DHCP_Renew = 0
    If DHCP_Bound = 0 Then Exit Function
    DHCP_Xid++
    DHCP_SendMessage DHCP_REQUEST, 1
    If DHCP_WaitFor(DHCP_ACK) Then
        DHCP_Bind
        #if STACK_STATS = 1
            Stat_DhcpRenewals++
        #endif
        DHCP_Renew = 1
    End If
End Function

Function DHCP_Tick As Byte
    // Once a second: renew at half the lease, retry every 60 s, give the address up when the lease runs out
    DHCP_Tick = DHCP_TICK_NOTHING
    If DHCP_Bound = 0 Then Exit Function
    DHCP_Elapsed++

    If DHCP_Elapsed >= DHCP_LeaseTime Then
        DHCP_Bound = 0
        NET_SetIP 0, 0, 0, 0
        IP_SetMaskGateway 0, 0, 0, 0, 0, 0, 0, 0
        DHCP_Tick = DHCP_TICK_EXPIRED
        Exit Function
    End If

    If DHCP_Elapsed >= DHCP_LeaseTime / 2 Then
        If DHCP_RetryCountdown > 0 Then
            DHCP_RetryCountdown--
            Exit Function
        End If
        If DHCP_Renew Then
            DHCP_Tick = DHCP_TICK_RENEWED
        Else
            DHCP_RetryCountdown = 60
            DHCP_Tick = DHCP_TICK_FAILED
        End If
    End If
End Function

Function DHCP_WaitFor(In DhcpWanted) As Byte
    // Service the network until an answer of type DhcpWanted (or a NAK) arrives, or DHCP_TIMEOUT_MS. Returns 1 for DhcpWanted
    Dim DhcpWaitStart As Long
    DHCP_WaitFor = 0
    DHCP_Answered = 0
    DHCP_RxType = 0
    DhcpWaitStart = Millis()
    Do While Millis() - DhcpWaitStart < DHCP_TIMEOUT_MS
        ENC_Service
        If DHCP_Answered = 1 Then
            If DHCP_RxType = DhcpWanted Then
                DHCP_WaitFor = 1
                Exit Function
            End If
            If DHCP_RxType = DHCP_NAK Then
                #if STACK_STATS = 1
                    Stat_DhcpNaks++
                #endif
                Exit Function
            End If
            // Another type: keep waiting
            DHCP_Answered = 0
        End If
    Loop
    #if STACK_STATS = 1
        Stat_DhcpTimeouts++
    #endif
End Function

Sub DHCP_SendMessage(In DhcpType, In DhcpUnicast)
    // Build and send a DISCOVER or REQUEST. DhcpUnicast = 1: renewal to the server, from our address
    Dim DhcpIndex, DhcpSlot As Byte

    // A unicast renewal needs the next hop's MAC first (resolving uses EthFrame)
    If DhcpUnicast = 1 Then
        DhcpSlot = IP_ResolveNextHop(DHCP_Server1, DHCP_Server2, DHCP_Server3, DHCP_Server4)
        If DhcpSlot = ARP_NOT_FOUND Then Exit Sub
    End If

    For DHCP_Pos = UDP_DATA To UDP_DATA + DHCP_MESSAGE_LENGTH - 1
        EthFrame(DHCP_Pos) = 0
    Next
    EthFrame(DHCPO_OP) = 1                      // BOOTREQUEST
    EthFrame(DHCPO_HTYPE) = 1                   // Ethernet
    EthFrame(DHCPO_HLEN) = 6
    EthFrame(DHCPO_XID) = DHCP_Xid_E
    EthFrame(DHCPO_XID + 1) = DHCP_Xid_U
    EthFrame(DHCPO_XID + 2) = DHCP_Xid_H
    EthFrame(DHCPO_XID + 3) = [byte]DHCP_Xid
    If DhcpUnicast = 1 Then
        EthFrame(DHCPO_CIADDR) = Net_IP1 : EthFrame(DHCPO_CIADDR + 1) = Net_IP2 : EthFrame(DHCPO_CIADDR + 2) = Net_IP3 : EthFrame(DHCPO_CIADDR + 3) = Net_IP4
    Else
        // Broadcast flag: the server answers to 255.255.255.255, which we receive before we have an address
        EthFrame(DHCPO_FLAGS) = 0x80
    End If
    EthFrame(DHCPO_CHADDR) = MY_MAC1 : EthFrame(DHCPO_CHADDR + 1) = MY_MAC2 : EthFrame(DHCPO_CHADDR + 2) = MY_MAC3
    EthFrame(DHCPO_CHADDR + 3) = MY_MAC4 : EthFrame(DHCPO_CHADDR + 4) = MY_MAC5 : EthFrame(DHCPO_CHADDR + 5) = MY_MAC6
    EthFrame(DHCPO_MAGIC) = 99 : EthFrame(DHCPO_MAGIC + 1) = 130 : EthFrame(DHCPO_MAGIC + 2) = 83 : EthFrame(DHCPO_MAGIC + 3) = 99

    // Options
    DHCP_Pos = DHCPO_OPTIONS
    DHCP_PutByte 53 : DHCP_PutByte 1 : DHCP_PutByte DhcpType
    // Client identifier: type 1 (Ethernet) and the MAC
    DHCP_PutByte 61 : DHCP_PutByte 7 : DHCP_PutByte 1
    DHCP_PutByte MY_MAC1 : DHCP_PutByte MY_MAC2 : DHCP_PutByte MY_MAC3 : DHCP_PutByte MY_MAC4 : DHCP_PutByte MY_MAC5 : DHCP_PutByte MY_MAC6
    If DhcpType = DHCP_REQUEST And DhcpUnicast = 0 Then
        // SELECTING: the offered address and the server that offered it
        DHCP_PutByte 50 : DHCP_PutByte 4
        DHCP_PutByte DHCP_RxIP1 : DHCP_PutByte DHCP_RxIP2 : DHCP_PutByte DHCP_RxIP3 : DHCP_PutByte DHCP_RxIP4
        DHCP_PutByte 54 : DHCP_PutByte 4
        DHCP_PutByte DHCP_Server1 : DHCP_PutByte DHCP_Server2 : DHCP_PutByte DHCP_Server3 : DHCP_PutByte DHCP_Server4
    End If
    DHCP_PutHostName DHCP_HOSTNAME
    // Parameters wanted: subnet mask, router, DNS server, lease time, server identifier
    DHCP_PutByte 55 : DHCP_PutByte 5 : DHCP_PutByte 1 : DHCP_PutByte 3 : DHCP_PutByte 6 : DHCP_PutByte 51 : DHCP_PutByte 54
    DHCP_PutByte 255

    If DhcpUnicast = 1 Then
        IP_BuildHeaderTo DhcpSlot, DHCP_Server1, DHCP_Server2, DHCP_Server3, DHCP_Server4, IP_PROTO_UDP, UDP_HEADER_LENGTH + DHCP_MESSAGE_LENGTH
    Else
        IP_BuildHeaderBroadcast IP_PROTO_UDP, UDP_HEADER_LENGTH + DHCP_MESSAGE_LENGTH
    End If
    UDP_SegLength = UDP_HEADER_LENGTH + DHCP_MESSAGE_LENGTH
    EthFrame(UDP_SRCPORT) = 0
    EthFrame(UDP_SRCPORT + 1) = DHCP_CLIENT_PORT
    EthFrame(UDP_DSTPORT) = 0
    EthFrame(UDP_DSTPORT + 1) = DHCP_SERVER_PORT
    EthFrame(UDP_LENGTH) = UDP_SegLength_H
    EthFrame(UDP_LENGTH + 1) = [byte]UDP_SegLength
    UDP_SetChecksum
    If ENC_Transmit(IP_Length + IP_VERHL) Then
        #if STACK_STATS = 1
            Stat_DhcpSent++
            Stat_UdpSent++
        #endif
    End If
End Sub

Sub DHCP_PutByte(In DhcpByte)
    // Next option byte; the options stop before the end of the 300-byte message
    If DHCP_Pos < UDP_DATA + DHCP_MESSAGE_LENGTH Then
        EthFrame(DHCP_Pos) = DhcpByte
        DHCP_Pos++
    End If
End Sub

Sub DHCP_PutHostName(In DhcpName As String)
    // Option 12, host name
    Dim DhcpNameIndex As Byte
    DHCP_PutByte 12
    DHCP_PutByte Len(DhcpName)
    For DhcpNameIndex = 1 To Len(DhcpName)
        DHCP_PutByte DhcpName(DhcpNameIndex)
    Next
End Sub

Sub DHCP_ProcessReply
    // A datagram from port 67 to port 68 is in EthFrame, UDP_SegLength bytes long
    Dim DhcpOpt, DhcpOptLen As Byte
    Dim DhcpIndex, DhcpEnd As Word

    // BOOTREPLY with the options' magic cookie, our transaction and our MAC
    If UDP_SegLength < UDP_HEADER_LENGTH + 240 Or EthFrame(DHCPO_OP) <> 2 Then
        #if STACK_STATS = 1
            Stat_DhcpBad++
        #endif
        Exit Sub
    End If
    If EthFrame(DHCPO_MAGIC) <> 99 Or EthFrame(DHCPO_MAGIC + 1) <> 130 Or EthFrame(DHCPO_MAGIC + 2) <> 83 Or EthFrame(DHCPO_MAGIC + 3) <> 99 Then
        #if STACK_STATS = 1
            Stat_DhcpBad++
        #endif
        Exit Sub
    End If
    If EthFrame(DHCPO_XID) <> DHCP_Xid_E Or EthFrame(DHCPO_XID + 1) <> DHCP_Xid_U Or EthFrame(DHCPO_XID + 2) <> DHCP_Xid_H Or EthFrame(DHCPO_XID + 3) <> [byte]DHCP_Xid Then
        #if STACK_STATS = 1
            Stat_DhcpBad++
        #endif
        Exit Sub
    End If
    If FrameIsMyMAC(DHCPO_CHADDR) = 0 Then
        #if STACK_STATS = 1
            Stat_DhcpBad++
        #endif
        Exit Sub
    End If

    DHCP_RxIP1 = EthFrame(DHCPO_YIADDR) : DHCP_RxIP2 = EthFrame(DHCPO_YIADDR + 1)
    DHCP_RxIP3 = EthFrame(DHCPO_YIADDR + 2) : DHCP_RxIP4 = EthFrame(DHCPO_YIADDR + 3)
    DHCP_RxType = 0
    DHCP_RxLease = 0
    DHCP_RxMask1 = 0 : DHCP_RxMask2 = 0 : DHCP_RxMask3 = 0 : DHCP_RxMask4 = 0
    DHCP_RxRouter1 = 0 : DHCP_RxRouter2 = 0 : DHCP_RxRouter3 = 0 : DHCP_RxRouter4 = 0
    DHCP_RxServer1 = 0 : DHCP_RxServer2 = 0 : DHCP_RxServer3 = 0 : DHCP_RxServer4 = 0
    DHCP_RxDns1 = 0 : DHCP_RxDns2 = 0 : DHCP_RxDns3 = 0 : DHCP_RxDns4 = 0

    // Options: code, length, value; 0 is padding, 255 the end. Never read past the datagram or the frame buffer
    DhcpEnd = UDP_SRCPORT + UDP_SegLength
    If DhcpEnd > ETH_BUFFER_SIZE Then DhcpEnd = ETH_BUFFER_SIZE
    DhcpIndex = DHCPO_OPTIONS
    Do While DhcpIndex < DhcpEnd
        DhcpOpt = EthFrame(DhcpIndex)
        If DhcpOpt = 255 Then Exit Do
        If DhcpOpt = 0 Then
            DhcpIndex++
        Else
            If DhcpIndex + 1 >= DhcpEnd Then Exit Do
            DhcpOptLen = EthFrame(DhcpIndex + 1)
            If DhcpIndex + 2 + DhcpOptLen > DhcpEnd Then Exit Do
            DhcpIndex = DhcpIndex + 2
            Select Case DhcpOpt
                Case 53
                    DHCP_RxType = EthFrame(DhcpIndex)
                Case 1
                    If DhcpOptLen >= 4 Then
                        DHCP_RxMask1 = EthFrame(DhcpIndex) : DHCP_RxMask2 = EthFrame(DhcpIndex + 1)
                        DHCP_RxMask3 = EthFrame(DhcpIndex + 2) : DHCP_RxMask4 = EthFrame(DhcpIndex + 3)
                    End If
                Case 3
                    // The first router
                    If DhcpOptLen >= 4 Then
                        DHCP_RxRouter1 = EthFrame(DhcpIndex) : DHCP_RxRouter2 = EthFrame(DhcpIndex + 1)
                        DHCP_RxRouter3 = EthFrame(DhcpIndex + 2) : DHCP_RxRouter4 = EthFrame(DhcpIndex + 3)
                    End If
                Case 6
                    // The first DNS server
                    If DhcpOptLen >= 4 Then
                        DHCP_RxDns1 = EthFrame(DhcpIndex) : DHCP_RxDns2 = EthFrame(DhcpIndex + 1)
                        DHCP_RxDns3 = EthFrame(DhcpIndex + 2) : DHCP_RxDns4 = EthFrame(DhcpIndex + 3)
                    End If
                Case 51
                    If DhcpOptLen >= 4 Then
                        DHCP_RxLease_E = EthFrame(DhcpIndex) : DHCP_RxLease_U = EthFrame(DhcpIndex + 1)
                        DHCP_RxLease_H = EthFrame(DhcpIndex + 2) : [byte]DHCP_RxLease = EthFrame(DhcpIndex + 3)
                    End If
                Case 54
                    If DhcpOptLen >= 4 Then
                        DHCP_RxServer1 = EthFrame(DhcpIndex) : DHCP_RxServer2 = EthFrame(DhcpIndex + 1)
                        DHCP_RxServer3 = EthFrame(DhcpIndex + 2) : DHCP_RxServer4 = EthFrame(DhcpIndex + 3)
                    End If
            End Select
            DhcpIndex = DhcpIndex + DhcpOptLen
        End If
    Loop

    If DHCP_RxType = 0 Then
        #if STACK_STATS = 1
            Stat_DhcpBad++
        #endif
        Exit Sub
    End If
    DHCP_Answered = 1
End Sub

#if STACK_STATS = 1
#if STACK_CONSOLE <> 0
Sub DHCP_PrintStats
    CONSOLE_Print "DHCP sent " : CONSOLE_Number Stat_DhcpSent
    CONSOLE_Print "  offers " : CONSOLE_Number Stat_DhcpOffers
    CONSOLE_Print "  acks " : CONSOLE_Number Stat_DhcpAcks
    CONSOLE_Print "  naks " : CONSOLE_Number Stat_DhcpNaks
    CONSOLE_Print "  renewals " : CONSOLE_Number Stat_DhcpRenewals
    CONSOLE_Print "  bad " : CONSOLE_Number Stat_DhcpBad
    CONSOLE_Print "  timeouts " : CONSOLE_Number Stat_DhcpTimeouts
    CONSOLE_CRLF
End Sub
#endif
#endif
