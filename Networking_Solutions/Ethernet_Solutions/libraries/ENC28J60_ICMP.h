//--------------------------------------------------------------------------------------------------------------------------------
// ICMP for the ENC28J60 stack
//
//   - Answers echo requests (ping) addressed to us, with the same identifier, sequence number and data
//   - Sends echo requests (ICMP_Ping) and reports the replies and round-trip times
//
// Needs ENC28J60_Driver.h, ENC28J60_ARP.h, ENC28J60_IPv4.h and millis.h.
//
// The program may define (defaults below):
//   ICMP_PING_COUNT, ICMP_PING_TIMEOUT_MS, ICMP_PING_DATA_LENGTH
//
// The program calls ICMP_ProcessPacket from IP_HandleDatagram for IP protocol 1, and ICMP_Init once at start-up.
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

    // Echo requests sent by ICMP_Ping
    #ifndef ICMP_PING_COUNT
        #define ICMP_PING_COUNT 4
    #endif
    #ifndef ICMP_PING_TIMEOUT_MS
        #define ICMP_PING_TIMEOUT_MS 1000
    #endif
    // Data bytes in each request, as Windows ping sends by default
    #ifndef ICMP_PING_DATA_LENGTH
        #define ICMP_PING_DATA_LENGTH 32
    #endif

// ----- ICMP message. Offsets are from the first byte of the Ethernet header (IPv4 header without options)
    #define ICMP_TYPE      34
    #define ICMP_CODE      35
    #define ICMP_CHECKSUM  36
    #define ICMP_IDENT     38
    #define ICMP_SEQ       40
    #define ICMP_DATA      42
    #define ICMP_HEADER_LENGTH 8

    #define ICMP_ECHO_REPLY    0
    #define ICMP_ECHO_REQUEST  8

    // Identifier of our echo requests: "GC"
    #define ICMP_PING_IDENT_H  0x47
    #define ICMP_PING_IDENT_L  0x43

// ----- Variables
    Dim ICMP_PingSeq As Word
    Dim ICMP_PingReplied As Byte

    #if STACK_STATS = 1
        // Statistics
        Dim Stat_RxIcmp, Stat_IcmpEchoRequests, Stat_IcmpEchoReplies, Stat_IcmpRepliesReceived, Stat_IcmpBadChecksum As Word
        Dim Stat_IcmpBadLength, Stat_IcmpOther, Stat_IcmpRequestsSent As Word
    #endif

// ----- ICMP

Sub ICMP_Init
    // RAM is not cleared at reset
    ICMP_PingSeq = 0
    ICMP_PingReplied = 0
    #if STACK_STATS = 1
        ICMP_ClearStats
    #endif
End Sub

#if STACK_STATS = 1
Sub ICMP_ClearStats
    Stat_RxIcmp = 0
    Stat_IcmpEchoRequests = 0
    Stat_IcmpEchoReplies = 0
    Stat_IcmpRepliesReceived = 0
    Stat_IcmpBadChecksum = 0
    Stat_IcmpBadLength = 0
    Stat_IcmpOther = 0
    Stat_IcmpRequestsSent = 0
End Sub
#endif

Sub ICMP_ProcessPacket
    // The datagram in EthFrame is ICMP, addressed to us, IP_Length bytes long and complete
    Dim IcmpLength As Word

    #if STACK_STATS = 1
        Stat_RxIcmp++
    #endif
    IcmpLength = IP_Length - IP_HEADER_LENGTH
    If IcmpLength < ICMP_HEADER_LENGTH Then
        #if STACK_STATS = 1
            Stat_IcmpBadLength++
        #endif
        Exit Sub
    End If
    If NetChecksum(ICMP_TYPE, IcmpLength) <> 0 Then
        #if STACK_STATS = 1
            Stat_IcmpBadChecksum++
        #endif
        Exit Sub
    End If

    Select Case EthFrame(ICMP_TYPE)
        Case ICMP_ECHO_REQUEST
            // Same identifier, sequence and data back; only the type and checksum change
            #if STACK_STATS = 1
                Stat_IcmpEchoRequests++
            #endif
            EthFrame(ICMP_TYPE) = ICMP_ECHO_REPLY
            EthFrame(ICMP_CODE) = 0
            ICMP_SetChecksum IcmpLength
            IP_PrepareReply
            If ENC_Transmit(IP_Length + IP_VERHL) Then
                #if STACK_STATS = 1
                    Stat_IcmpEchoReplies++
                #endif
            End If

        Case ICMP_ECHO_REPLY
            // A reply to our latest request
            #if STACK_STATS = 1
                Stat_IcmpRepliesReceived++
            #endif
            If EthFrame(ICMP_IDENT) = ICMP_PING_IDENT_H And EthFrame(ICMP_IDENT + 1) = ICMP_PING_IDENT_L Then
                If EthFrame(ICMP_SEQ) = ICMP_PingSeq_H And EthFrame(ICMP_SEQ + 1) = [byte]ICMP_PingSeq Then ICMP_PingReplied = 1
            End If

        Case Else
            #if STACK_STATS = 1
                Stat_IcmpOther++
            #endif
    End Select
End Sub

Sub ICMP_SetChecksum(In IcmpSumLength As Word)
    Dim IcmpSum As Word
    EthFrame(ICMP_CHECKSUM) = 0
    EthFrame(ICMP_CHECKSUM + 1) = 0
    IcmpSum = NetChecksum(ICMP_TYPE, IcmpSumLength)
    EthFrame(ICMP_CHECKSUM) = IcmpSum_H
    EthFrame(ICMP_CHECKSUM + 1) = [byte]IcmpSum
End Sub

#if STACK_CONSOLE <> 0
Sub ICMP_Ping(In PIP1, In PIP2, In PIP3, In PIP4)
    // Sends ICMP_PING_COUNT echo requests and reports each reply or time-out, like a PC's ping
    Dim PingSlot, PingNo, PingIndex As Byte
    Dim PingStart, PingTime As Long

    CONSOLE_Print "Ping " : CONSOLE_Number PIP1 : CONSOLE_Print "." : CONSOLE_Number PIP2 : CONSOLE_Print "." : CONSOLE_Number PIP3 : CONSOLE_Print "." : CONSOLE_Number PIP4
    CONSOLE_Print " with " : CONSOLE_Number ICMP_PING_DATA_LENGTH : CONSOLE_Print " bytes of data:" : CONSOLE_CRLF

    For PingNo = 1 To ICMP_PING_COUNT
        // The MAC first: resolving uses EthFrame, so the request is built after it
        PingSlot = ARP_Resolve(PIP1, PIP2, PIP3, PIP4)
        If PingSlot = ARP_NOT_FOUND Then
            CONSOLE_Print "Destination host unreachable (no ARP reply)" : CONSOLE_CRLF
        Else
            ICMP_PingSeq++
            ICMP_PingReplied = 0
            IP_BuildHeader PingSlot, IP_PROTO_ICMP, ICMP_HEADER_LENGTH + ICMP_PING_DATA_LENGTH
            EthFrame(ICMP_TYPE) = ICMP_ECHO_REQUEST
            EthFrame(ICMP_CODE) = 0
            EthFrame(ICMP_IDENT) = ICMP_PING_IDENT_H
            EthFrame(ICMP_IDENT + 1) = ICMP_PING_IDENT_L
            EthFrame(ICMP_SEQ) = ICMP_PingSeq_H
            EthFrame(ICMP_SEQ + 1) = [byte]ICMP_PingSeq
            // Data abcdefghijklmnopqrstuvw repeated, as Windows ping sends
            For PingIndex = 0 To ICMP_PING_DATA_LENGTH - 1
                EthFrame(ICMP_DATA + PingIndex) = 97 + (PingIndex Mod 23)
            Next
            ICMP_SetChecksum ICMP_HEADER_LENGTH + ICMP_PING_DATA_LENGTH

            PingStart = Millis()
            If ENC_Transmit(IP_Length + IP_VERHL) Then
                #if STACK_STATS = 1
                    Stat_IcmpRequestsSent++
                #endif
            End If
            Do
                ENC_Service
                PingTime = Millis() - PingStart
            Loop Until ICMP_PingReplied = 1 Or PingTime >= ICMP_PING_TIMEOUT_MS

            If ICMP_PingReplied = 1 Then
                CONSOLE_Print "Reply from " : CONSOLE_Number PIP1 : CONSOLE_Print "." : CONSOLE_Number PIP2 : CONSOLE_Print "." : CONSOLE_Number PIP3 : CONSOLE_Print "." : CONSOLE_Number PIP4
                CONSOLE_Print ": seq=" : CONSOLE_Number ICMP_PingSeq : CONSOLE_Print " time=" : CONSOLE_Number PingTime : CONSOLE_Print " ms" : CONSOLE_CRLF
            Else
                CONSOLE_Print "Request timed out (seq=" : CONSOLE_Number ICMP_PingSeq : CONSOLE_Print ")" : CONSOLE_CRLF
            End If
        End If
    Next
End Sub
#endif

#if STACK_STATS = 1
#if STACK_CONSOLE <> 0
Sub ICMP_PrintStats
    CONSOLE_Print "ICMP received " : CONSOLE_Number Stat_RxIcmp
    CONSOLE_Print "  echo requests " : CONSOLE_Number Stat_IcmpEchoRequests
    CONSOLE_Print "  replies sent " : CONSOLE_Number Stat_IcmpEchoReplies
    CONSOLE_Print "  requests sent " : CONSOLE_Number Stat_IcmpRequestsSent
    CONSOLE_Print "  replies received " : CONSOLE_Number Stat_IcmpRepliesReceived
    CONSOLE_Print "  bad checksum " : CONSOLE_Number Stat_IcmpBadChecksum
    CONSOLE_Print "  bad length " : CONSOLE_Number Stat_IcmpBadLength
    CONSOLE_Print "  other types " : CONSOLE_Number Stat_IcmpOther
    CONSOLE_CRLF
End Sub
#endif
#endif
