//--------------------------------------------------------------------------------------------------------------------------------
// DNS resolver for the ENC28J60 stack (RFC 1035, UDP port 53)
//
//   - DNS_Resolve "host.name", IP1, IP2, IP3, IP4, Status: one A query (recursion desired) to the DNS server, waits for
//     the answer, retries. The address goes into the caller's IP1-4 (0.0.0.0 on failure), Status is DNS_RESULT_OK or
//     why it failed. An optional seventh parameter is the wait per try in ms (default DNS_TIMEOUT_MS).
//     It is a Sub: build 1664 does not copy a Function's Out parameters back
//     (Project_Support\compiler_bugs\function_out_param_bug.gcb)
//   - Each answer is checked: from the server, from port 53, our query ID, a response; names are walked with bounds
//     checks and compression pointers; CNAME records before the A record are skipped
//   - No cache: each call asks the server
//
// Needs ENC28J60_Driver.h, ENC28J60_ARP.h, ENC28J60_IPv4.h (routing), ENC28J60_UDP.h and millis.h.
//
// The program may define (defaults below):
//   DNS_LOCAL_PORT, DNS_TIMEOUT_MS (default wait per try), DNS_RETRIES
//
// The program calls DNS_Init once at start-up, DNS_SetServer when the address is set (DHCP or fixed), and
// DNS_ProcessReply from UDP_HandleDatagram for datagrams from port 53 to DNS_LOCAL_PORT.
// The answer must fit ETH_BUFFER_SIZE (a longer frame is dropped by IPv4 as too big).
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

    // Our UDP port for queries; the answer comes back to it
    #ifndef DNS_LOCAL_PORT
        #define DNS_LOCAL_PORT 50053
    #endif
    // Wait for each answer
    #ifndef DNS_TIMEOUT_MS
        #define DNS_TIMEOUT_MS 2000
    #endif
    // Queries per name
    #ifndef DNS_RETRIES
        #define DNS_RETRIES 2
    #endif

    #define DNS_SERVER_PORT 53

// ----- DNS message. Offsets are from the first byte of the Ethernet header (UDP data starts at 42)
    #define DNSO_ID        42
    #define DNSO_FLAGS     44      // QR, opcode, AA, TC, RD
    #define DNSO_RCODE     45      // RA, Z, response code (low 4 bits)
    #define DNSO_QDCOUNT   46
    #define DNSO_ANCOUNT   48
    #define DNSO_QUESTION  54
    #define DNS_HEADER_LENGTH 12

    // DNS_Result
    // DNS_Resolve status (also in DNS_Result)
    #define DNS_RESULT_OK         0
    #define DNS_RESULT_NO_SERVER  1     // no DNS server set, or it (or the gateway) does not answer ARP
    #define DNS_RESULT_BAD_NAME   2     // empty label or a label over 63 characters
    #define DNS_RESULT_TIMEOUT    3
    #define DNS_RESULT_NOT_FOUND  4     // the name does not exist, or has no IPv4 address
    #define DNS_RESULT_ERROR      5     // the server answered with an error

// ----- Variables
    Dim DNS_ServerIP1, DNS_ServerIP2, DNS_ServerIP3, DNS_ServerIP4 As Byte
    // The address in the latest answer, filled by DNS_ProcessReply
    Dim DNS_RxIP1, DNS_RxIP2, DNS_RxIP3, DNS_RxIP4 As Byte
    Dim DNS_Result, DNS_Answered As Byte
    Dim DNS_Id As Word
    // Walking a message
    Dim DNS_Pos, DNS_End As Word

    #if STACK_STATS = 1
        // Statistics
        Dim Stat_DnsQueries, Stat_DnsAnswers, Stat_DnsNotFound, Stat_DnsErrors, Stat_DnsBad, Stat_DnsTimeouts As Word
    #endif

// ----- DNS

Sub DNS_Init
    // RAM is not cleared at reset
    DNS_SetServer 0, 0, 0, 0
    DNS_Id = 0
    DNS_Answered = 0
    DNS_Result = DNS_RESULT_NO_SERVER
    #if STACK_STATS = 1
        Stat_DnsQueries = 0
        Stat_DnsAnswers = 0
        Stat_DnsNotFound = 0
        Stat_DnsErrors = 0
        Stat_DnsBad = 0
        Stat_DnsTimeouts = 0
    #endif
End Sub

Sub DNS_SetServer(In DnsSet1, In DnsSet2, In DnsSet3, In DnsSet4)
    DNS_ServerIP1 = DnsSet1 : DNS_ServerIP2 = DnsSet2 : DNS_ServerIP3 = DnsSet3 : DNS_ServerIP4 = DnsSet4
End Sub

Sub DNS_Resolve(In DnsName As String, Out DnsIP1, Out DnsIP2, Out DnsIP3, Out DnsIP4, Out DnsStatus, Optional In DnsWaitMs As Word = DNS_TIMEOUT_MS)
    // Look up the IPv4 address of DnsName into DnsIP1-4 (0.0.0.0 when it fails). DnsStatus is DNS_RESULT_OK, or why it
    // failed. A Sub, not a Function: build 1664 copies a Function's Out parameters in, never back
    Dim DnsTry As Byte
    Dim DnsStart As Long

    DnsIP1 = 0 : DnsIP2 = 0 : DnsIP3 = 0 : DnsIP4 = 0
    DNS_Result = DNS_RESULT_NO_SERVER
    If DNS_ServerIP1 <> 0 Then
        For DnsTry = 1 To DNS_RETRIES
            // DNS_SendQuery sets DNS_Result when it cannot send
            If DNS_SendQuery(DnsName) = 0 Then Exit For
            DnsStart = Millis()
            Do While DNS_Answered = 0 And Millis() - DnsStart < DnsWaitMs
                ENC_Service
            Loop
            If DNS_Answered = 1 Then Exit For
            #if STACK_STATS = 1
                Stat_DnsTimeouts++
            #endif
            DNS_Result = DNS_RESULT_TIMEOUT
        Next
    End If
    If DNS_Result = DNS_RESULT_OK Then
        DnsIP1 = DNS_RxIP1 : DnsIP2 = DNS_RxIP2 : DnsIP3 = DNS_RxIP3 : DnsIP4 = DNS_RxIP4
    End If
    DnsStatus = DNS_Result
End Sub

Function DNS_SendQuery(In DnsQName As String) As Byte
    // Build and send an A query for DnsQName. Returns 1 when sent
    Dim DnsSlot, DnsChar, DnsLabel, DnsIndex As Byte
    Dim DnsLabelPos As Word

    DNS_SendQuery = 0
    // The next hop first: resolving uses EthFrame
    DnsSlot = IP_ResolveNextHop(DNS_ServerIP1, DNS_ServerIP2, DNS_ServerIP3, DNS_ServerIP4)
    If DnsSlot = ARP_NOT_FOUND Then
        DNS_Result = DNS_RESULT_NO_SERVER
        Exit Function
    End If

    // Header: a new ID, recursion desired, one question
    DNS_Id = DNS_Id + 1 + Millis()
    For DnsIndex = 0 To DNS_HEADER_LENGTH - 1
        EthFrame(UDP_DATA + DnsIndex) = 0
    Next
    EthFrame(DNSO_ID) = DNS_Id_H
    EthFrame(DNSO_ID + 1) = [byte]DNS_Id
    EthFrame(DNSO_FLAGS) = 0x01
    EthFrame(DNSO_QDCOUNT + 1) = 1

    // Question name: "a.b.c" becomes 1 a 1 b 1 c 0
    DnsLabelPos = DNSO_QUESTION
    DNS_Pos = DNSO_QUESTION + 1
    DnsLabel = 0
    For DnsIndex = 1 To Len(DnsQName)
        DnsChar = DnsQName(DnsIndex)
        If DnsChar = 46 Then
            // "." ends a label
            If DnsLabel = 0 Then
                DNS_Result = DNS_RESULT_BAD_NAME
                Exit Function
            End If
            EthFrame(DnsLabelPos) = DnsLabel
            DnsLabelPos = DNS_Pos
            DNS_Pos++
            DnsLabel = 0
        Else
            If DnsLabel = 63 Then
                DNS_Result = DNS_RESULT_BAD_NAME
                Exit Function
            End If
            EthFrame(DNS_Pos) = DnsChar
            DNS_Pos++
            DnsLabel++
        End If
    Next
    If DnsLabel = 0 Then
        DNS_Result = DNS_RESULT_BAD_NAME
        Exit Function
    End If
    EthFrame(DnsLabelPos) = DnsLabel
    // End of the name, type A (1), class IN (1)
    EthFrame(DNS_Pos) = 0
    EthFrame(DNS_Pos + 1) = 0
    EthFrame(DNS_Pos + 2) = 1
    EthFrame(DNS_Pos + 3) = 0
    EthFrame(DNS_Pos + 4) = 1
    DNS_Pos = DNS_Pos + 5

    UDP_SegLength = DNS_Pos - UDP_SRCPORT
    IP_BuildHeaderTo DnsSlot, DNS_ServerIP1, DNS_ServerIP2, DNS_ServerIP3, DNS_ServerIP4, IP_PROTO_UDP, UDP_SegLength
    EthFrame(UDP_SRCPORT) = DNS_LOCAL_PORT / 256
    EthFrame(UDP_SRCPORT + 1) = DNS_LOCAL_PORT And 255
    EthFrame(UDP_DSTPORT) = 0
    EthFrame(UDP_DSTPORT + 1) = DNS_SERVER_PORT
    EthFrame(UDP_LENGTH) = UDP_SegLength_H
    EthFrame(UDP_LENGTH + 1) = [byte]UDP_SegLength
    UDP_SetChecksum

    DNS_Answered = 0
    If ENC_Transmit(IP_Length + IP_VERHL) Then
        #if STACK_STATS = 1
            Stat_DnsQueries++
            Stat_UdpSent++
        #endif
    End If
    DNS_SendQuery = 1
End Function

Sub DNS_ProcessReply
    // A datagram from port 53 to DNS_LOCAL_PORT is in EthFrame, UDP_SegLength bytes long
    Dim DnsCount, DnsRcode As Byte
    Dim DnsType, DnsClass, DnsRdLength As Word

    // Only the answer to our latest query, from our server
    If DNS_Answered = 1 Then Exit Sub
    If UDP_SegLength < UDP_HEADER_LENGTH + DNS_HEADER_LENGTH Then
        DNS_CountBad
        Exit Sub
    End If
    If EthFrame(IP_SRC) <> DNS_ServerIP1 Or EthFrame(IP_SRC + 1) <> DNS_ServerIP2 Or EthFrame(IP_SRC + 2) <> DNS_ServerIP3 Or EthFrame(IP_SRC + 3) <> DNS_ServerIP4 Then
        DNS_CountBad
        Exit Sub
    End If
    If EthFrame(DNSO_ID) <> DNS_Id_H Or EthFrame(DNSO_ID + 1) <> [byte]DNS_Id Then
        DNS_CountBad
        Exit Sub
    End If
    // QR = 1: a response
    If (EthFrame(DNSO_FLAGS) And 0x80) = 0 Then
        DNS_CountBad
        Exit Sub
    End If

    // Response code: 3 = the name does not exist, others are server errors
    DnsRcode = EthFrame(DNSO_RCODE) And 0x0F
    If DnsRcode = 3 Then
        DNS_Finish DNS_RESULT_NOT_FOUND
        Exit Sub
    End If
    If DnsRcode <> 0 Then
        DNS_Finish DNS_RESULT_ERROR
        Exit Sub
    End If

    // Never read past the datagram or the frame buffer
    DNS_End = UDP_SRCPORT + UDP_SegLength
    If DNS_End > ETH_BUFFER_SIZE Then DNS_End = ETH_BUFFER_SIZE
    DNS_Pos = DNSO_QUESTION

    // Questions: a name, type and class each. Counts over 255 are not expected
    If EthFrame(DNSO_QDCOUNT) <> 0 Or EthFrame(DNSO_ANCOUNT) <> 0 Then
        DNS_CountBad
        Exit Sub
    End If
    DnsCount = EthFrame(DNSO_QDCOUNT + 1)
    Do While DnsCount > 0
        If DNS_SkipName = 0 Then
            DNS_CountBad
            Exit Sub
        End If
        DNS_Pos = DNS_Pos + 4
        DnsCount--
    Loop

    // Answers: the first A record of class IN with 4 bytes of data; others (CNAME) are skipped
    DnsCount = EthFrame(DNSO_ANCOUNT + 1)
    Do While DnsCount > 0
        If DNS_SkipName = 0 Then
            DNS_CountBad
            Exit Sub
        End If
        // Type, class, TTL, data length, then the data
        If DNS_Pos + 10 > DNS_End Then
            DNS_CountBad
            Exit Sub
        End If
        DnsType_H = EthFrame(DNS_Pos) : [byte]DnsType = EthFrame(DNS_Pos + 1)
        DnsClass_H = EthFrame(DNS_Pos + 2) : [byte]DnsClass = EthFrame(DNS_Pos + 3)
        DnsRdLength_H = EthFrame(DNS_Pos + 8) : [byte]DnsRdLength = EthFrame(DNS_Pos + 9)
        DNS_Pos = DNS_Pos + 10
        If DNS_Pos + DnsRdLength > DNS_End Then
            DNS_CountBad
            Exit Sub
        End If
        If DnsType = 1 And DnsClass = 1 And DnsRdLength = 4 Then
            DNS_RxIP1 = EthFrame(DNS_Pos) : DNS_RxIP2 = EthFrame(DNS_Pos + 1)
            DNS_RxIP3 = EthFrame(DNS_Pos + 2) : DNS_RxIP4 = EthFrame(DNS_Pos + 3)
            DNS_Finish DNS_RESULT_OK
            Exit Sub
        End If
        DNS_Pos = DNS_Pos + DnsRdLength
        DnsCount--
    Loop
    // An answer without an IPv4 address
    DNS_Finish DNS_RESULT_NOT_FOUND
End Sub

Function DNS_SkipName As Byte
    // Step DNS_Pos over a name: labels up to a 0, or up to a compression pointer. Returns 0 when it is malformed
    Dim DnsLen As Byte
    DNS_SkipName = 0
    Do While DNS_Pos < DNS_End
        DnsLen = EthFrame(DNS_Pos)
        If DnsLen = 0 Then
            DNS_Pos++
            DNS_SkipName = 1
            Exit Function
        End If
        If (DnsLen And 0xC0) = 0xC0 Then
            // Pointer: 2 bytes, the rest of the name is elsewhere
            DNS_Pos = DNS_Pos + 2
            If DNS_Pos <= DNS_End Then DNS_SkipName = 1
            Exit Function
        End If
        // 0x40 and 0x80 are not valid label types
        If DnsLen > 63 Then Exit Function
        DNS_Pos = DNS_Pos + DnsLen + 1
    Loop
End Function

Sub DNS_Finish(In DnsFinal)
    // The answer to our query: the result, and DNS_Resolve stops waiting
    DNS_Result = DnsFinal
    DNS_Answered = 1
    #if STACK_STATS = 1
        If DnsFinal = DNS_RESULT_OK Then Stat_DnsAnswers++
        If DnsFinal = DNS_RESULT_NOT_FOUND Then Stat_DnsNotFound++
        If DnsFinal = DNS_RESULT_ERROR Then Stat_DnsErrors++
    #endif
End Sub

Sub DNS_CountBad
    #if STACK_STATS = 1
        Stat_DnsBad++
    #endif
End Sub

#if STACK_STATS = 1
#if STACK_CONSOLE <> 0
Sub DNS_PrintStats
    CONSOLE_Print "DNS queries " : CONSOLE_Number Stat_DnsQueries
    CONSOLE_Print "  answers " : CONSOLE_Number Stat_DnsAnswers
    CONSOLE_Print "  not found " : CONSOLE_Number Stat_DnsNotFound
    CONSOLE_Print "  errors " : CONSOLE_Number Stat_DnsErrors
    CONSOLE_Print "  bad " : CONSOLE_Number Stat_DnsBad
    CONSOLE_Print "  timeouts " : CONSOLE_Number Stat_DnsTimeouts
    CONSOLE_CRLF
End Sub
#endif
#endif
