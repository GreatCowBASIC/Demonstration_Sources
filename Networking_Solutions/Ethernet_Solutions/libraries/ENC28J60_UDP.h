//--------------------------------------------------------------------------------------------------------------------------------
// UDP for the ENC28J60 stack
//
//   - Checks each received datagram: length, and the checksum (pseudo-header included) when the sender set one
//   - Passes good datagrams to the program by destination port (UDP_HandleDatagram)
//   - Echo reply (UDP_EchoReply) and sending (UDP_Send), with checksum
//
// Needs ENC28J60_Driver.h, ENC28J60_ARP.h and ENC28J60_IPv4.h.
//
// The program must define, before including this file:
//   Sub UDP_HandleDatagram    called for each good datagram; ports in UDP_RxSrcPort / UDP_RxDstPort, length in UDP_SegLength
//
// The program calls UDP_ProcessPacket from IP_HandleDatagram for IP protocol 17, and UDP_Init once at start-up.
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

// ----- UDP header. Offsets are from the first byte of the Ethernet header (IPv4 header without options)
    #define UDP_SRCPORT    34
    #define UDP_DSTPORT    36
    #define UDP_LENGTH     38
    #define UDP_CHECKSUM   40
    #define UDP_DATA       42
    #define UDP_HEADER_LENGTH 8

    #define IP_PROTO_UDP   17

// ----- Variables
    // The datagram being processed: UDP length (header + data) and ports
    Dim UDP_SegLength, UDP_RxSrcPort, UDP_RxDstPort As Word

    #if STACK_STATS = 1
        // Statistics
        Dim Stat_RxUdp, Stat_UdpBadLength, Stat_UdpBadChecksum, Stat_UdpNoChecksum, Stat_UdpNoPort, Stat_UdpSent As Word
    #endif

// ----- UDP

Sub UDP_Init
    // RAM is not cleared at reset
    #if STACK_STATS = 1
        UDP_ClearStats
    #endif
End Sub

#if STACK_STATS = 1
Sub UDP_ClearStats
    Stat_RxUdp = 0
    Stat_UdpBadLength = 0
    Stat_UdpBadChecksum = 0
    Stat_UdpNoChecksum = 0
    Stat_UdpNoPort = 0
    Stat_UdpSent = 0
End Sub
#endif

Sub UDP_ProcessPacket
    // The datagram in EthFrame is UDP, addressed to us, IP_Length bytes long and complete
    #if STACK_STATS = 1
        Stat_RxUdp++
    #endif

    If IP_Length < IP_HEADER_LENGTH + UDP_HEADER_LENGTH Then
        #if STACK_STATS = 1
            Stat_UdpBadLength++
        #endif
        Exit Sub
    End If
    UDP_SegLength_H = EthFrame(UDP_LENGTH)
    [byte]UDP_SegLength = EthFrame(UDP_LENGTH + 1)
    If UDP_SegLength < UDP_HEADER_LENGTH Or UDP_SegLength > IP_Length - IP_HEADER_LENGTH Then
        #if STACK_STATS = 1
            Stat_UdpBadLength++
        #endif
        Exit Sub
    End If

    // Checksum 0 means the sender did not set one (allowed in IPv4)
    If EthFrame(UDP_CHECKSUM) = 0 And EthFrame(UDP_CHECKSUM + 1) = 0 Then
        #if STACK_STATS = 1
            Stat_UdpNoChecksum++
        #endif
    Else
        If UDP_PseudoChecksum(UDP_SegLength) <> 0 Then
            #if STACK_STATS = 1
                Stat_UdpBadChecksum++
            #endif
            Exit Sub
        End If
    End If

    UDP_RxSrcPort_H = EthFrame(UDP_SRCPORT)
    [byte]UDP_RxSrcPort = EthFrame(UDP_SRCPORT + 1)
    UDP_RxDstPort_H = EthFrame(UDP_DSTPORT)
    [byte]UDP_RxDstPort = EthFrame(UDP_DSTPORT + 1)
    UDP_HandleDatagram
End Sub

Sub UDP_EchoReply
    // Send the received datagram back to its sender, ports swapped (RFC 862 echo)
    Dim UDPSwap As Byte
    UDPSwap = EthFrame(UDP_SRCPORT)
    EthFrame(UDP_SRCPORT) = EthFrame(UDP_DSTPORT)
    EthFrame(UDP_DSTPORT) = UDPSwap
    UDPSwap = EthFrame(UDP_SRCPORT + 1)
    EthFrame(UDP_SRCPORT + 1) = EthFrame(UDP_DSTPORT + 1)
    EthFrame(UDP_DSTPORT + 1) = UDPSwap
    // Only the UDP datagram goes back, without any padding the IP datagram carried
    IP_Length = IP_HEADER_LENGTH + UDP_SegLength
    EthFrame(IP_TOTLEN) = IP_Length_H
    EthFrame(IP_TOTLEN + 1) = [byte]IP_Length
    IP_PrepareReply
    UDP_SetChecksum
    If ENC_Transmit(IP_Length + IP_VERHL) Then
        #if STACK_STATS = 1
            Stat_UdpSent++
        #endif
    End If
End Sub

Function UDP_Send(In UDPSlot, In UDPSrcPort As Word, In UDPDstPort As Word, In UDPDataLength As Word) As Byte
    // Send UDPDataLength bytes, already in EthFrame from UDP_DATA, to the host in ARP cache slot UDPSlot.
    // Returns 1 when sent
    UDP_SegLength = UDP_HEADER_LENGTH + UDPDataLength
    IP_BuildHeader UDPSlot, IP_PROTO_UDP, UDP_SegLength
    EthFrame(UDP_SRCPORT) = UDPSrcPort_H
    EthFrame(UDP_SRCPORT + 1) = [byte]UDPSrcPort
    EthFrame(UDP_DSTPORT) = UDPDstPort_H
    EthFrame(UDP_DSTPORT + 1) = [byte]UDPDstPort
    EthFrame(UDP_LENGTH) = UDP_SegLength_H
    EthFrame(UDP_LENGTH + 1) = [byte]UDP_SegLength
    UDP_SetChecksum
    UDP_Send = ENC_Transmit(IP_Length + IP_VERHL)
    If UDP_Send Then
        #if STACK_STATS = 1
            Stat_UdpSent++
        #endif
    End If
End Function

Sub UDP_SetChecksum
    // Checksum of the datagram in EthFrame (UDP_SegLength bytes). A computed 0 is sent as 0xFFFF: 0 means none
    Dim UDPSum As Word
    EthFrame(UDP_CHECKSUM) = 0
    EthFrame(UDP_CHECKSUM + 1) = 0
    UDPSum = UDP_PseudoChecksum(UDP_SegLength)
    If UDPSum = 0 Then UDPSum = 0xFFFF
    EthFrame(UDP_CHECKSUM) = UDPSum_H
    EthFrame(UDP_CHECKSUM + 1) = [byte]UDPSum
End Sub

Function UDP_PseudoChecksum(In PsLength As Word) As Word
    // Internet checksum of the pseudo-header (source and destination IP, protocol 17, UDP length) and PsLength bytes
    // of the datagram from UDP_SRCPORT. Over a datagram that holds a correct checksum the result is 0
    Dim PsSum As Long
    Dim PsWord, PsIndex, PsCount As Word
    // Pseudo-header: the 8 address bytes are in the IP header, the protocol and length are added as words
    PsSum = IP_PROTO_UDP + PsLength
    PsIndex = IP_SRC
    PsCount = 8 + PsLength
    Do While PsCount > 1
        // The datagram starts right after the addresses (IP_SRC + 8 = UDP_SRCPORT), so one pass covers both
        PsWord_H = EthFrame(PsIndex)
        [byte]PsWord = EthFrame(PsIndex + 1)
        PsSum = PsSum + PsWord
        PsIndex = PsIndex + 2
        PsCount = PsCount - 2
    Loop
    If PsCount = 1 Then
        PsWord_H = EthFrame(PsIndex)
        [byte]PsWord = 0
        PsSum = PsSum + PsWord
    End If
    Do While PsSum_U <> 0 Or PsSum_E <> 0
        [byte]PsWord = PsSum_U
        PsWord_H = PsSum_E
        PsSum_U = 0
        PsSum_E = 0
        PsSum = PsSum + PsWord
    Loop
    [byte]UDP_PseudoChecksum = 255 - [byte]PsSum
    UDP_PseudoChecksum_H = 255 - PsSum_H
End Function

#if STACK_STATS = 1
#if STACK_CONSOLE <> 0
Sub UDP_PrintStats
    CONSOLE_Print "UDP received " : CONSOLE_Number Stat_RxUdp
    CONSOLE_Print "  bad length " : CONSOLE_Number Stat_UdpBadLength
    CONSOLE_Print "  bad checksum " : CONSOLE_Number Stat_UdpBadChecksum
    CONSOLE_Print "  no checksum " : CONSOLE_Number Stat_UdpNoChecksum
    CONSOLE_Print "  no port " : CONSOLE_Number Stat_UdpNoPort
    CONSOLE_Print "  sent " : CONSOLE_Number Stat_UdpSent
    CONSOLE_CRLF
End Sub
#endif
#endif
