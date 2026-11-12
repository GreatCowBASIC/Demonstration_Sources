//--------------------------------------------------------------------------------------------------------------------------------
// ARP for the ENC28J60 stack
//
//   - Replies to requests for our IP (RFC 826), with the sender merged into the cache
//   - Requests and a small cache with ageing, so other layers can resolve IP -> MAC (no hard-coded MACs)
//   - Gratuitous announcement (RFC 5227), and IP conflict detection
//
// This device's IP is the variable Net_IP1 to Net_IP4 (fixed or from DHCP).
// While it is 0.0.0.0 (not configured) nothing is answered, announced or reported as a conflict.
//
// Needs ENC28J60_Driver.h (EthFrame, ENC_RxLen, ENC_Transmit, ENC_Service) and millis.h.
//
// The program must define, before including this file:
//   MY_MAC1 to MY_MAC6   this device's MAC
//
// The program may define (defaults below):
//   ARP_CACHE_SIZE, ARP_CACHE_TIMEOUT_S, ARP_RETRIES, ARP_REPLY_TIMEOUT_MS
//
// The program calls ARP_Init once at start-up (the IP is then 0.0.0.0), sets the IP with NET_SetIP, calls
// ARP_ProcessFrame for frames with EtherType 0x0806 (see ARP_IsArpFrame), and ARP_CacheTick once a second.
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

    // Entries
    #ifndef ARP_CACHE_SIZE
        #define ARP_CACHE_SIZE 4
    #endif
    // An entry not refreshed for this long is removed (ARQ-05)
    #ifndef ARP_CACHE_TIMEOUT_S
        #define ARP_CACHE_TIMEOUT_S 60
    #endif
    // Requests sent before giving up (ARQ-06)
    #ifndef ARP_RETRIES
        #define ARP_RETRIES 3
    #endif
    // Wait for a reply to each request
    #ifndef ARP_REPLY_TIMEOUT_MS
        #define ARP_REPLY_TIMEOUT_MS 500
    #endif

// ----- ARP frame. Offsets are from the first byte of the Ethernet header
    #define ARP_HTYPE    14
    #define ARP_PTYPE    16
    #define ARP_HLEN     18
    #define ARP_PLEN     19
    #define ARP_OPER     20
    #define ARP_SHA      22
    #define ARP_SPA      28
    #define ARP_THA      32
    #define ARP_TPA      38
    #define ARP_FRAME_LENGTH 42

    #define ARP_REQUEST 1
    #define ARP_REPLY   2
    #define ARP_NOT_FOUND 255

// ----- Variables
    // This device's IP address; 0.0.0.0 until NET_SetIP
    Dim Net_IP1, Net_IP2, Net_IP3, Net_IP4 As Byte

    Dim ARP_CacheIP(ARP_CACHE_SIZE * 4)
    Dim ARP_CacheMAC(ARP_CACHE_SIZE * 6)
    Dim ARP_CacheState(ARP_CACHE_SIZE)
    Dim ARP_CacheAge(ARP_CACHE_SIZE) As Word

    #if STACK_STATS = 1
        // Statistics
        Dim Stat_RxArp, Stat_ArpReplies, Stat_ArpRequests, Stat_ArpNotForUs, Stat_ArpMalformed, Stat_ArpConflicts As Word
    #endif

// ----- ARP

Function ARP_IsArpFrame As Byte
    // The frame in EthFrame has EtherType 0x0806
    ARP_IsArpFrame = 0
    If EthFrame(ETH_TYPE) = 0x08 And EthFrame(ETH_TYPE + 1) = 0x06 Then ARP_IsArpFrame = 1
End Function

Sub ARP_ProcessFrame
    // The frame in EthFrame is an ARP frame (EtherType 0x0806)
    Dim Slot As Byte

    #if STACK_STATS = 1
        Stat_RxArp++
    #endif

    // Only Ethernet / IPv4 ARP (ARP-05), and a whole ARP message (truncated frames are dropped)
    If ENC_RxLen < ARP_FRAME_LENGTH Or EthFrame(ARP_HTYPE) <> 0 Or EthFrame(ARP_HTYPE + 1) <> 1 Or EthFrame(ARP_PTYPE) <> 0x08 Or EthFrame(ARP_PTYPE + 1) <> 0 Or EthFrame(ARP_HLEN) <> 6 Or EthFrame(ARP_PLEN) <> 4 Or EthFrame(ARP_OPER) <> 0 Then
        #if STACK_STATS = 1
            Stat_ArpMalformed++
        #endif
        Exit Sub
    End If
    If EthFrame(ARP_OPER + 1) <> ARP_REQUEST And EthFrame(ARP_OPER + 1) <> ARP_REPLY Then
        #if STACK_STATS = 1
            Stat_ArpMalformed++
        #endif
        Exit Sub
    End If

    // Someone else using our IP address (DHC-03); our own gratuitous ARP echoed back is not a conflict
    If FrameIsMyIP(ARP_SPA) Then
        If FrameIsMyMAC(ARP_SHA) = 0 Then
            #if STACK_STATS = 1
                Stat_ArpConflicts++
            #endif
            #if STACK_CONSOLE <> 0
                CONSOLE_Print "IP CONFLICT: " : PrintFrameIP ARP_SPA : CONSOLE_Print " is also used by " : PrintFrameMAC ARP_SHA : CONSOLE_CRLF
            #endif
        End If
        Exit Sub
    End If

    // RFC 826 merge: refresh the sender if it is already cached, whatever the message is for
    Slot = ARP_CacheFind(EthFrame(ARP_SPA), EthFrame(ARP_SPA + 1), EthFrame(ARP_SPA + 2), EthFrame(ARP_SPA + 3))
    If Slot <> ARP_NOT_FOUND Then ARP_CacheStore Slot

    If FrameIsMyIP(ARP_TPA) = 0 Then
        #if STACK_STATS = 1
            Stat_ArpNotForUs++
        #endif
        Exit Sub
    End If

    // Addressed to us: cache the sender, then answer a request. A reply is only cached - ARP_Resolve reports it
    If Slot = ARP_NOT_FOUND Then
        Slot = ARP_CacheFreeSlot
        ARP_CacheStore Slot
    End If

    If EthFrame(ARP_OPER + 1) = ARP_REQUEST Then ARP_SendReply
End Sub

Sub ARP_SendReply
    // Turn the request in EthFrame round (ARP-01)
    Dim Index As Byte
    For Index = 0 To 5
        EthFrame(ETH_DEST + Index) = EthFrame(ARP_SHA + Index)
        EthFrame(ARP_THA + Index) = EthFrame(ARP_SHA + Index)
    Next
    For Index = 0 To 3
        EthFrame(ARP_TPA + Index) = EthFrame(ARP_SPA + Index)
    Next
    SetMyAddresses
    EthFrame(ARP_OPER + 1) = ARP_REPLY
    If ENC_Transmit(ARP_FRAME_LENGTH) Then
        #if STACK_STATS = 1
            Stat_ArpReplies++
        #endif
    End If
End Sub

Sub ARP_SendRequest(In TIP1, In TIP2, In TIP3, In TIP4)
    // Broadcast who-has TIP. A gratuitous ARP is a request for our own address
    Dim Index As Byte
    For Index = 0 To 5
        EthFrame(ETH_DEST + Index) = 0xFF
        EthFrame(ARP_THA + Index) = 0
    Next
    EthFrame(ETH_TYPE) = 0x08 : EthFrame(ETH_TYPE + 1) = 0x06
    EthFrame(ARP_HTYPE) = 0 : EthFrame(ARP_HTYPE + 1) = 1
    EthFrame(ARP_PTYPE) = 0x08 : EthFrame(ARP_PTYPE + 1) = 0
    EthFrame(ARP_HLEN) = 6 : EthFrame(ARP_PLEN) = 4
    EthFrame(ARP_OPER) = 0 : EthFrame(ARP_OPER + 1) = ARP_REQUEST
    SetMyAddresses
    EthFrame(ARP_TPA) = TIP1 : EthFrame(ARP_TPA + 1) = TIP2 : EthFrame(ARP_TPA + 2) = TIP3 : EthFrame(ARP_TPA + 3) = TIP4
    If ENC_Transmit(ARP_FRAME_LENGTH) Then
        #if STACK_STATS = 1
            Stat_ArpRequests++
        #endif
    End If
End Sub

Sub ARP_SendGratuitous
    // Only with an address to announce
    If NET_IsConfigured Then ARP_SendRequest Net_IP1, Net_IP2, Net_IP3, Net_IP4
End Sub

Sub SetMyAddresses
    // Our MAC as Ethernet source and ARP sender, our IP as ARP sender
    EthFrame(ETH_SRC) = MY_MAC1 : EthFrame(ETH_SRC + 1) = MY_MAC2 : EthFrame(ETH_SRC + 2) = MY_MAC3
    EthFrame(ETH_SRC + 3) = MY_MAC4 : EthFrame(ETH_SRC + 4) = MY_MAC5 : EthFrame(ETH_SRC + 5) = MY_MAC6
    EthFrame(ARP_SHA) = MY_MAC1 : EthFrame(ARP_SHA + 1) = MY_MAC2 : EthFrame(ARP_SHA + 2) = MY_MAC3
    EthFrame(ARP_SHA + 3) = MY_MAC4 : EthFrame(ARP_SHA + 4) = MY_MAC5 : EthFrame(ARP_SHA + 5) = MY_MAC6
    EthFrame(ARP_SPA) = Net_IP1 : EthFrame(ARP_SPA + 1) = Net_IP2 : EthFrame(ARP_SPA + 2) = Net_IP3 : EthFrame(ARP_SPA + 3) = Net_IP4
End Sub

Function ARP_Resolve(In RIP1, In RIP2, In RIP3, In RIP4) As Byte
    // Returns the cache slot holding RIP's MAC, or ARP_NOT_FOUND after ARP_RETRIES unanswered requests
    Dim ArpAttempt As Byte
    Dim ArpAttemptStart As Long
    ARP_Resolve = ARP_CacheFind(RIP1, RIP2, RIP3, RIP4)
    If ARP_Resolve <> ARP_NOT_FOUND Then Exit Function
    For ArpAttempt = 1 To ARP_RETRIES
        ARP_SendRequest RIP1, RIP2, RIP3, RIP4
        ArpAttemptStart = Millis()
        Do While Millis() - ArpAttemptStart < ARP_REPLY_TIMEOUT_MS
            ENC_Service
            ARP_Resolve = ARP_CacheFind(RIP1, RIP2, RIP3, RIP4)
            If ARP_Resolve <> ARP_NOT_FOUND Then Exit Function
        Loop
    Next
    ARP_Resolve = ARP_NOT_FOUND
End Function

#if STACK_CONSOLE <> 0
Sub ARP_ResolveAndReport(In RIP1, In RIP2, In RIP3, In RIP4)
    Dim Slot As Byte
    CONSOLE_Print "Resolving " : CONSOLE_Number RIP1 : CONSOLE_Print "." : CONSOLE_Number RIP2 : CONSOLE_Print "." : CONSOLE_Number RIP3 : CONSOLE_Print "." : CONSOLE_Number RIP4
    CONSOLE_Print ": "
    Slot = ARP_Resolve(RIP1, RIP2, RIP3, RIP4)
    If Slot = ARP_NOT_FOUND Then
        CONSOLE_Print "no reply after " : CONSOLE_Number ARP_RETRIES : CONSOLE_Print " requests"
    Else
        ARP_PrintCacheMAC Slot
    End If
    CONSOLE_CRLF
End Sub
#endif

// ----- ARP cache

Sub ARP_Init
    // RAM is not cleared at reset: no IP yet, empty the cache and zero the counters once at start-up
    NET_SetIP 0, 0, 0, 0
    ARP_CacheClear
    #if STACK_STATS = 1
        ARP_ClearStats
    #endif
End Sub

Sub NET_SetIP(In SetIP1, In SetIP2, In SetIP3, In SetIP4)
    // This device's IP address (fixed, or from DHCP). 0.0.0.0 = not configured
    Net_IP1 = SetIP1
    Net_IP2 = SetIP2
    Net_IP3 = SetIP3
    Net_IP4 = SetIP4
End Sub

Function NET_IsConfigured As Byte
    // 1 when this device has an IP address
    NET_IsConfigured = 0
    If Net_IP1 <> 0 Or Net_IP2 <> 0 Or Net_IP3 <> 0 Or Net_IP4 <> 0 Then NET_IsConfigured = 1
End Function

#if STACK_STATS = 1
Sub ARP_ClearStats
    Stat_RxArp = 0
    Stat_ArpReplies = 0
    Stat_ArpRequests = 0
    Stat_ArpNotForUs = 0
    Stat_ArpMalformed = 0
    Stat_ArpConflicts = 0
End Sub
#endif

Sub ARP_CacheClear
    Dim Slot As Byte
    For Slot = 0 To ARP_CACHE_SIZE - 1
        ARP_CacheState(Slot) = 0
    Next
End Sub

Function ARP_CacheFind(In FIP1, In FIP2, In FIP3, In FIP4) As Byte
    Dim Slot, Base As Byte
    For Slot = 0 To ARP_CACHE_SIZE - 1
        If ARP_CacheState(Slot) = 1 Then
            Base = Slot * 4
            If ARP_CacheIP(Base) = FIP1 And ARP_CacheIP(Base + 1) = FIP2 And ARP_CacheIP(Base + 2) = FIP3 And ARP_CacheIP(Base + 3) = FIP4 Then
                ARP_CacheFind = Slot
                Exit Function
            End If
        End If
    Next
    ARP_CacheFind = ARP_NOT_FOUND
End Function

Function ARP_CacheFreeSlot As Byte
    // An empty slot, else the oldest entry
    Dim Slot As Byte
    Dim OldestAge As Word
    ARP_CacheFreeSlot = 0
    OldestAge = 0
    For Slot = 0 To ARP_CACHE_SIZE - 1
        If ARP_CacheState(Slot) = 0 Then
            ARP_CacheFreeSlot = Slot
            Exit Function
        End If
        If ARP_CacheAge(Slot) >= OldestAge Then
            OldestAge = ARP_CacheAge(Slot)
            ARP_CacheFreeSlot = Slot
        End If
    Next
End Function

Sub ARP_CacheStore(In Slot)
    // Store the ARP sender of the frame in EthFrame in Slot
    Dim Index, Base As Byte
    Base = Slot * 4
    For Index = 0 To 3
        ARP_CacheIP(Base + Index) = EthFrame(ARP_SPA + Index)
    Next
    Base = Slot * 6
    For Index = 0 To 5
        ARP_CacheMAC(Base + Index) = EthFrame(ARP_SHA + Index)
    Next
    ARP_CacheState(Slot) = 1
    ARP_CacheAge(Slot) = 0
End Sub

Sub ARP_CacheTick
    // Called once a second: age the entries and remove the stale ones (ARQ-05)
    Dim Slot As Byte
    For Slot = 0 To ARP_CACHE_SIZE - 1
        If ARP_CacheState(Slot) = 1 Then
            ARP_CacheAge(Slot)++
            If ARP_CacheAge(Slot) >= ARP_CACHE_TIMEOUT_S Then
                ARP_CacheState(Slot) = 0
                #if STACK_CONSOLE <> 0
                    CONSOLE_Print "ARP cache: expired " : ARP_PrintCacheIP Slot : CONSOLE_CRLF
                #endif
            End If
        End If
    Next
End Sub

#if STACK_CONSOLE <> 0
Sub ARP_PrintCache
    Dim Slot, Used As Byte
    Used = 0
    For Slot = 0 To ARP_CACHE_SIZE - 1
        If ARP_CacheState(Slot) = 1 Then
            Used++
            CONSOLE_Number Slot : CONSOLE_Print "  " : ARP_PrintCacheIP Slot : CONSOLE_Print "  " : ARP_PrintCacheMAC Slot
            CONSOLE_Print "  age " : CONSOLE_Number ARP_CacheAge(Slot) : CONSOLE_Print " s" : CONSOLE_CRLF
        End If
    Next
    If Used = 0 Then CONSOLE_Print "Cache empty" : CONSOLE_CRLF
End Sub
#endif

#if STACK_CONSOLE <> 0
Sub ARP_PrintCacheIP(In Slot)
    Dim Base As Byte
    Base = Slot * 4
    CONSOLE_Number ARP_CacheIP(Base) : CONSOLE_Print "." : CONSOLE_Number ARP_CacheIP(Base + 1) : CONSOLE_Print "."
    CONSOLE_Number ARP_CacheIP(Base + 2) : CONSOLE_Print "." : CONSOLE_Number ARP_CacheIP(Base + 3)
End Sub
#endif

#if STACK_CONSOLE <> 0
Sub ARP_PrintCacheMAC(In Slot)
    Dim Base, Index As Byte
    Base = Slot * 6
    For Index = 0 To 5
        CONSOLE_Print hex(ARP_CacheMAC(Base + Index))
        If Index < 5 Then CONSOLE_Print ":"
    Next
End Sub
#endif

#if STACK_STATS = 1
#if STACK_CONSOLE <> 0
Sub ARP_PrintStats
    CONSOLE_Print "ARP received " : CONSOLE_Number Stat_RxArp
    CONSOLE_Print "  replies sent " : CONSOLE_Number Stat_ArpReplies
    CONSOLE_Print "  requests sent " : CONSOLE_Number Stat_ArpRequests
    CONSOLE_Print "  not for us " : CONSOLE_Number Stat_ArpNotForUs
    CONSOLE_Print "  malformed " : CONSOLE_Number Stat_ArpMalformed
    CONSOLE_Print "  conflicts " : CONSOLE_Number Stat_ArpConflicts
    CONSOLE_CRLF
End Sub
#endif
#endif

// ----- Frame helpers

Function FrameIsMyIP(In Offset) As Byte
    // Never true while not configured, so 0.0.0.0 is not answered or reported as a conflict
    FrameIsMyIP = 0
    If NET_IsConfigured = 0 Then Exit Function
    If EthFrame(Offset) = Net_IP1 And EthFrame(Offset + 1) = Net_IP2 And EthFrame(Offset + 2) = Net_IP3 And EthFrame(Offset + 3) = Net_IP4 Then FrameIsMyIP = 1
End Function

Function FrameIsMyMAC(In Offset) As Byte
    FrameIsMyMAC = 0
    If EthFrame(Offset) = MY_MAC1 And EthFrame(Offset + 1) = MY_MAC2 And EthFrame(Offset + 2) = MY_MAC3 Then
        If EthFrame(Offset + 3) = MY_MAC4 And EthFrame(Offset + 4) = MY_MAC5 And EthFrame(Offset + 5) = MY_MAC6 Then FrameIsMyMAC = 1
    End If
End Function

#if STACK_CONSOLE <> 0
Sub PrintFrameIP(In Offset)
    CONSOLE_Number EthFrame(Offset) : CONSOLE_Print "." : CONSOLE_Number EthFrame(Offset + 1) : CONSOLE_Print "."
    CONSOLE_Number EthFrame(Offset + 2) : CONSOLE_Print "." : CONSOLE_Number EthFrame(Offset + 3)
End Sub
#endif

#if STACK_CONSOLE <> 0
Sub PrintFrameMAC(In Offset)
    Dim MacByte As Byte
    For MacByte = 0 To 5
        CONSOLE_Print hex(EthFrame(Offset + MacByte))
        If MacByte < 5 Then CONSOLE_Print ":"
    Next
End Sub
#endif
