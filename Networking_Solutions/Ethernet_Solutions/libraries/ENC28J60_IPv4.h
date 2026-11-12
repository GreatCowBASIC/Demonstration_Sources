//--------------------------------------------------------------------------------------------------------------------------------
// IPv4 for the ENC28J60 stack
//
//   - Checks each received datagram: version 4, header length, total length, header checksum, addressed to us
//   - Drops fragments and headers with options (counted), as reassembly and options are not supported yet
//   - Builds headers for replies and for datagrams we send
//   - Routing: a destination outside our subnet is sent through the gateway (IP_ResolveNextHop, IP_BuildHeaderTo)
//   - Broadcast: receives datagrams to 255.255.255.255 (and anything while not configured), sends to 255.255.255.255
//
// IP, subnet mask and gateway are variables (fixed with IP_SetStatic, or from DHCP).
//
// Needs ENC28J60_Driver.h (EthFrame, ENC_RxLen) and ENC28J60_ARP.h (Net_IP, FrameIsMyIP, ARP_Resolve).
//
// The program must define, before including this file:
//   MY_MAC1 to MY_MAC6                     this device's MAC
//   Sub IP_HandleDatagram                  called for each good datagram (protocol in IP_PROTO). IP_RxBroadcast is 1
//                                          when it was not addressed to our IP: pass those only to DHCP
//
// For IP_SetStatic the program defines MY_IP1-4, IP_NETMASK1-4 and IP_GATEWAY1-4.
//
// The program calls IP_ProcessFrame for frames with EtherType 0x0800 (see IP_IsIpFrame), and IP_Init once at start-up.
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

// ----- IPv4 header. Offsets are from the first byte of the Ethernet header; no options (header length 20)
    #define IP_VERHL      14
    #define IP_TOS        15
    #define IP_TOTLEN     16
    #define IP_IDENT      18
    #define IP_FLAGFRAG   20
    #define IP_TTL        22
    #define IP_PROTO      23
    #define IP_CHECKSUM   24
    #define IP_SRC        26
    #define IP_DST        30
    #define IP_DATA       34

    #define IP_HEADER_LENGTH 20
    #define IP_DEFAULT_TTL   64
    #define IP_PROTO_ICMP    1

// ----- Variables
    // Total length of the datagram being processed (header + data)
    Dim IP_Length As Word
    Dim IP_IdentCount As Word
    // 1 when the datagram being processed was not addressed to our IP (broadcast, or received before configuration)
    Dim IP_RxBroadcast As Byte

    // Subnet mask and default gateway; 0.0.0.0 until set
    Dim Net_Mask1, Net_Mask2, Net_Mask3, Net_Mask4 As Byte
    Dim Net_Gateway1, Net_Gateway2, Net_Gateway3, Net_Gateway4 As Byte

    #if STACK_STATS = 1
        // Statistics
        Dim Stat_RxIp, Stat_IpBadHeader, Stat_IpBadChecksum, Stat_IpNotForUs, Stat_IpFragment, Stat_IpOptions, Stat_IpTooBig As Word
        Dim Stat_IpOtherProto As Word
    #endif

// ----- IPv4

Sub IP_Init
    // RAM is not cleared at reset
    IP_IdentCount = 0
    IP_SetMaskGateway 0, 0, 0, 0, 0, 0, 0, 0
    #if STACK_STATS = 1
        IP_ClearStats
    #endif
End Sub

Sub IP_SetMaskGateway(In SetMask1, In SetMask2, In SetMask3, In SetMask4, In SetGw1, In SetGw2, In SetGw3, In SetGw4)
    Net_Mask1 = SetMask1 : Net_Mask2 = SetMask2 : Net_Mask3 = SetMask3 : Net_Mask4 = SetMask4
    Net_Gateway1 = SetGw1 : Net_Gateway2 = SetGw2 : Net_Gateway3 = SetGw3 : Net_Gateway4 = SetGw4
End Sub

Sub IP_SetStatic
    // The fixed address from the program's constants
    NET_SetIP MY_IP1, MY_IP2, MY_IP3, MY_IP4
    IP_SetMaskGateway IP_NETMASK1, IP_NETMASK2, IP_NETMASK3, IP_NETMASK4, IP_GATEWAY1, IP_GATEWAY2, IP_GATEWAY3, IP_GATEWAY4
End Sub

#if STACK_STATS = 1
Sub IP_ClearStats
    Stat_RxIp = 0
    Stat_IpBadHeader = 0
    Stat_IpBadChecksum = 0
    Stat_IpNotForUs = 0
    Stat_IpFragment = 0
    Stat_IpOptions = 0
    Stat_IpTooBig = 0
    Stat_IpOtherProto = 0
End Sub
#endif

Function IP_IsIpFrame As Byte
    // The frame in EthFrame has EtherType 0x0800
    IP_IsIpFrame = 0
    If EthFrame(ETH_TYPE) = 0x08 And EthFrame(ETH_TYPE + 1) = 0x00 Then IP_IsIpFrame = 1
End Function

Sub IP_ProcessFrame
    // The frame in EthFrame is IPv4. Checks it and passes a good datagram addressed to us to IP_HandleDatagram
    #if STACK_STATS = 1
        Stat_RxIp++
    #endif

    If ENC_RxLen < IP_DATA Then
        #if STACK_STATS = 1
            Stat_IpBadHeader++
        #endif
        Exit Sub
    End If

    // Version 4 with a 20-byte header; a longer header carries options
    If EthFrame(IP_VERHL) <> 0x45 Then
        If (EthFrame(IP_VERHL) And 0xF0) = 0x40 And (EthFrame(IP_VERHL) And 0x0F) > 5 Then
            #if STACK_STATS = 1
                Stat_IpOptions++
            #endif
        Else
            #if STACK_STATS = 1
                Stat_IpBadHeader++
            #endif
        End If
        Exit Sub
    End If

    // Total length: at least the header, and not longer than the frame (a short datagram is padded, so the frame can be longer)
    [byte]IP_Length = EthFrame(IP_TOTLEN + 1)
    IP_Length_H = EthFrame(IP_TOTLEN)
    If IP_Length < IP_HEADER_LENGTH Or IP_Length + IP_VERHL > ENC_RxLen Then
        #if STACK_STATS = 1
            Stat_IpBadHeader++
        #endif
        Exit Sub
    End If

    // Header checksum over a good header, checksum field included, is 0. The header is always in EthFrame
    If NetChecksum(IP_VERHL, IP_HEADER_LENGTH) <> 0 Then
        #if STACK_STATS = 1
            Stat_IpBadChecksum++
        #endif
        Exit Sub
    End If

    // Ours, the limited broadcast 255.255.255.255, or anything while not configured (a DHCP answer can be sent to the
    // address being offered)
    // One test per statement: "If Function = 0 Or (...)" compiles to "If Function <> 0" (build 1663)
    IP_RxBroadcast = 0
    If FrameIsMyIP(IP_DST) = 0 Then
        If EthFrame(IP_DST) = 255 And EthFrame(IP_DST + 1) = 255 And EthFrame(IP_DST + 2) = 255 And EthFrame(IP_DST + 3) = 255 Then IP_RxBroadcast = 1
        If NET_IsConfigured = 0 Then IP_RxBroadcast = 1
        If IP_RxBroadcast = 0 Then
            #if STACK_STATS = 1
                Stat_IpNotForUs++
            #endif
            Exit Sub
        End If
    End If

    // Addressed to us: the whole datagram must be in EthFrame
    If IP_Length + IP_VERHL > ETH_BUFFER_SIZE Then
        #if STACK_STATS = 1
            Stat_IpTooBig++
        #endif
        Exit Sub
    End If

    // A fragment has More Fragments set or a fragment offset; reassembly is not supported
    If (EthFrame(IP_FLAGFRAG) And 0x3F) <> 0 Or EthFrame(IP_FLAGFRAG + 1) <> 0 Then
        #if STACK_STATS = 1
            Stat_IpFragment++
        #endif
        Exit Sub
    End If

    IP_HandleDatagram
End Sub

Sub IP_PrepareReply
    // Turn the received datagram in EthFrame round: back to the sender's MAC and IP, from ours, with a new header checksum.
    // The data and IP_Length are left as they are
    Dim IPIndex As Byte
    For IPIndex = 0 To 5
        EthFrame(ETH_DEST + IPIndex) = EthFrame(ETH_SRC + IPIndex)
    Next
    For IPIndex = 0 To 3
        EthFrame(IP_DST + IPIndex) = EthFrame(IP_SRC + IPIndex)
    Next
    IP_SetMyAddresses
    EthFrame(IP_TOS) = 0
    EthFrame(IP_FLAGFRAG) = 0
    EthFrame(IP_FLAGFRAG + 1) = 0
    EthFrame(IP_TTL) = IP_DEFAULT_TTL
    IP_SetIdentAndChecksum
End Sub

Sub IP_BuildHeader(In DestSlot, In IPProto, In IPDataLength As Word)
    // A new datagram to the host in ARP cache slot DestSlot: Ethernet and IPv4 headers. The data goes from IP_DATA
    Dim IPIndex, IPBase As Byte
    IPBase = DestSlot * 6
    For IPIndex = 0 To 5
        EthFrame(ETH_DEST + IPIndex) = ARP_CacheMAC(IPBase + IPIndex)
    Next
    IPBase = DestSlot * 4
    For IPIndex = 0 To 3
        EthFrame(IP_DST + IPIndex) = ARP_CacheIP(IPBase + IPIndex)
    Next
    EthFrame(ETH_TYPE) = 0x08
    EthFrame(ETH_TYPE + 1) = 0x00
    IP_SetMyAddresses
    IP_Length = IP_HEADER_LENGTH + IPDataLength
    EthFrame(IP_VERHL) = 0x45
    EthFrame(IP_TOS) = 0
    EthFrame(IP_TOTLEN) = IP_Length_H
    EthFrame(IP_TOTLEN + 1) = [byte]IP_Length
    EthFrame(IP_FLAGFRAG) = 0
    EthFrame(IP_FLAGFRAG + 1) = 0
    EthFrame(IP_TTL) = IP_DEFAULT_TTL
    EthFrame(IP_PROTO) = IPProto
    IP_SetIdentAndChecksum
End Sub

// ----- Routing

Function IP_ResolveNextHop(In NhIP1, In NhIP2, In NhIP3, In NhIP4) As Byte
    // ARP cache slot of the next hop to NhIP: NhIP itself when it is in our subnet, else the gateway.
    // Returns ARP_NOT_FOUND when the next hop does not answer ARP
    If (NhIP1 And Net_Mask1) = (Net_IP1 And Net_Mask1) And (NhIP2 And Net_Mask2) = (Net_IP2 And Net_Mask2) And (NhIP3 And Net_Mask3) = (Net_IP3 And Net_Mask3) And (NhIP4 And Net_Mask4) = (Net_IP4 And Net_Mask4) Then
        IP_ResolveNextHop = ARP_Resolve(NhIP1, NhIP2, NhIP3, NhIP4)
    Else
        IP_ResolveNextHop = ARP_Resolve(Net_Gateway1, Net_Gateway2, Net_Gateway3, Net_Gateway4)
    End If
End Function

Sub IP_BuildHeaderTo(In NhSlot, In DstIP1, In DstIP2, In DstIP3, In DstIP4, In NhProto, In NhDataLength As Word)
    // A new datagram to DstIP, sent to the MAC in ARP cache slot NhSlot (from IP_ResolveNextHop). The data goes from IP_DATA
    Dim NhIndex, NhBase As Byte
    NhBase = NhSlot * 6
    For NhIndex = 0 To 5
        EthFrame(ETH_DEST + NhIndex) = ARP_CacheMAC(NhBase + NhIndex)
    Next
    EthFrame(IP_DST) = DstIP1 : EthFrame(IP_DST + 1) = DstIP2 : EthFrame(IP_DST + 2) = DstIP3 : EthFrame(IP_DST + 3) = DstIP4
    EthFrame(ETH_TYPE) = 0x08
    EthFrame(ETH_TYPE + 1) = 0x00
    IP_SetMyAddresses
    IP_Length = IP_HEADER_LENGTH + NhDataLength
    EthFrame(IP_VERHL) = 0x45
    EthFrame(IP_TOS) = 0
    EthFrame(IP_TOTLEN) = IP_Length_H
    EthFrame(IP_TOTLEN + 1) = [byte]IP_Length
    EthFrame(IP_FLAGFRAG) = 0
    EthFrame(IP_FLAGFRAG + 1) = 0
    EthFrame(IP_TTL) = IP_DEFAULT_TTL
    EthFrame(IP_PROTO) = NhProto
    IP_SetIdentAndChecksum
End Sub

Sub IP_BuildHeaderBroadcast(In BcProto, In BcDataLength As Word)
    // A new datagram to everyone on the segment: MAC FF:FF:FF:FF:FF:FF, IP 255.255.255.255. The source IP is ours,
    // 0.0.0.0 while not configured (as DHCP requires). The data goes from IP_DATA
    Dim BcIndex As Byte
    For BcIndex = 0 To 5
        EthFrame(ETH_DEST + BcIndex) = 0xFF
    Next
    For BcIndex = 0 To 3
        EthFrame(IP_DST + BcIndex) = 0xFF
    Next
    EthFrame(ETH_TYPE) = 0x08
    EthFrame(ETH_TYPE + 1) = 0x00
    IP_SetMyAddresses
    IP_Length = IP_HEADER_LENGTH + BcDataLength
    EthFrame(IP_VERHL) = 0x45
    EthFrame(IP_TOS) = 0
    EthFrame(IP_TOTLEN) = IP_Length_H
    EthFrame(IP_TOTLEN + 1) = [byte]IP_Length
    EthFrame(IP_FLAGFRAG) = 0
    EthFrame(IP_FLAGFRAG + 1) = 0
    EthFrame(IP_TTL) = IP_DEFAULT_TTL
    EthFrame(IP_PROTO) = BcProto
    IP_SetIdentAndChecksum
End Sub

Sub IP_SetMyAddresses
    // Our MAC as Ethernet source, our IP as IP source
    EthFrame(ETH_SRC) = MY_MAC1 : EthFrame(ETH_SRC + 1) = MY_MAC2 : EthFrame(ETH_SRC + 2) = MY_MAC3
    EthFrame(ETH_SRC + 3) = MY_MAC4 : EthFrame(ETH_SRC + 4) = MY_MAC5 : EthFrame(ETH_SRC + 5) = MY_MAC6
    EthFrame(IP_SRC) = Net_IP1 : EthFrame(IP_SRC + 1) = Net_IP2 : EthFrame(IP_SRC + 2) = Net_IP3 : EthFrame(IP_SRC + 3) = Net_IP4
End Sub

Sub IP_SetIdentAndChecksum
    Dim IPHeaderSum As Word
    IP_IdentCount++
    EthFrame(IP_IDENT) = IP_IdentCount_H
    EthFrame(IP_IDENT + 1) = [byte]IP_IdentCount
    EthFrame(IP_CHECKSUM) = 0
    EthFrame(IP_CHECKSUM + 1) = 0
    IPHeaderSum = NetChecksum(IP_VERHL, IP_HEADER_LENGTH)
    EthFrame(IP_CHECKSUM) = IPHeaderSum_H
    EthFrame(IP_CHECKSUM + 1) = [byte]IPHeaderSum
End Sub

Function NetChecksum(In CkStart As Word, In CkLength As Word) As Word
    // Internet checksum (RFC 1071) of CkLength bytes of EthFrame from CkStart: the one's complement of the
    // one's complement sum of the 16-bit words. Over data that holds a correct checksum the result is 0
    Dim CkSum As Long
    Dim CkWord, CkIndex As Word
    CkSum = 0
    CkIndex = CkStart
    Do While CkLength > 1
        CkWord_H = EthFrame(CkIndex)
        [byte]CkWord = EthFrame(CkIndex + 1)
        CkSum = CkSum + CkWord
        CkIndex = CkIndex + 2
        CkLength = CkLength - 2
    Loop
    // An odd last byte is the high byte of a word
    If CkLength = 1 Then
        CkWord_H = EthFrame(CkIndex)
        [byte]CkWord = 0
        CkSum = CkSum + CkWord
    End If
    // Fold the carries back into the low 16 bits
    Do While CkSum_U <> 0 Or CkSum_E <> 0
        [byte]CkWord = CkSum_U
        CkWord_H = CkSum_E
        CkSum_U = 0
        CkSum_E = 0
        CkSum = CkSum + CkWord
    Loop
    [byte]NetChecksum = 255 - [byte]CkSum
    NetChecksum_H = 255 - CkSum_H
End Function

#if STACK_STATS = 1
#if STACK_CONSOLE <> 0
Sub IP_PrintStats
    CONSOLE_Print "IP received " : CONSOLE_Number Stat_RxIp
    CONSOLE_Print "  bad header " : CONSOLE_Number Stat_IpBadHeader
    CONSOLE_Print "  bad checksum " : CONSOLE_Number Stat_IpBadChecksum
    CONSOLE_Print "  not for us " : CONSOLE_Number Stat_IpNotForUs
    CONSOLE_Print "  fragments " : CONSOLE_Number Stat_IpFragment
    CONSOLE_Print "  options " : CONSOLE_Number Stat_IpOptions
    CONSOLE_Print "  too big " : CONSOLE_Number Stat_IpTooBig
    CONSOLE_Print "  other protocol " : CONSOLE_Number Stat_IpOtherProto
    CONSOLE_CRLF
End Sub
#endif
#endif
