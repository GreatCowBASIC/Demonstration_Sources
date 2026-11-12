//--------------------------------------------------------------------------------------------------------------------------------
// SNTP client for the ENC28J60 stack (RFC 4330, UDP port 123)
//
//   - Asks the server for the time (SNTP_Request) and keeps it as seconds since 1900 plus millis() since the answer
//   - Checks each answer: server mode, stratum 1 to 15, leap indicator not 3 (unsynchronised), and that it answers our
//     request (originate timestamp)
//   - Converts to UTC date and time (SNTP_Now, SNTP_PrintNow)
//
// The server is in the variables SNTP_ServerIP1-4: SNTP_SetServer, or pass them to DNS_Resolve to use a host name.
// It can be on our subnet or beyond the gateway: the next hop comes from IP_ResolveNextHop.
//
// Needs ENC28J60_Driver.h, ENC28J60_ARP.h, ENC28J60_IPv4.h (routing), ENC28J60_UDP.h and millis.h.
//
// The program may define (defaults below):
//   SNTP_SERVER_IP1 to SNTP_SERVER_IP4   the time server SNTP_Init starts with (default 0.0.0.0: none)
//   SNTP_LOCAL_PORT, SNTP_TIMEOUT_MS
//
// The program calls SNTP_Init once at start-up, and SNTP_ProcessReply from UDP_HandleDatagram for datagrams from
// port 123 to SNTP_LOCAL_PORT.
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

    // Our UDP port for the request; the answer comes back to it
    #ifndef SNTP_LOCAL_PORT
        #define SNTP_LOCAL_PORT 50123
    #endif
    #ifndef SNTP_TIMEOUT_MS
        #define SNTP_TIMEOUT_MS 2000
    #endif

    // The time server SNTP_Init starts with
    #ifndef SNTP_SERVER_IP1
        #define SNTP_SERVER_IP1 0
        #define SNTP_SERVER_IP2 0
        #define SNTP_SERVER_IP3 0
        #define SNTP_SERVER_IP4 0
    #endif

    #define SNTP_SERVER_PORT 123
    #define SNTP_MESSAGE_LENGTH 48

// ----- NTP message. Offsets are from the first byte of the Ethernet header (UDP data starts at 42)
    #define SNTPO_FLAGS       42      // leap indicator, version, mode
    #define SNTPO_STRATUM     43
    #define SNTPO_ORIGINATE   66      // our transmit time, copied back by the server
    #define SNTPO_TRANSMIT    82      // server transmit time: seconds since 1900, then the fraction

    // Request: leap indicator 0, version 4, mode 3 (client)
    #define SNTP_REQUEST_FLAGS 0x23
    #define SNTP_MODE_SERVER   4
    // Leap indicator 3 (top two bits): the server's clock is not synchronised
    #define SNTP_LEAP_ALARM    0xC0

    // Seconds from 1900-01-01 (NTP) to 1970-01-01 (Unix)
    #define SNTP_UNIX_OFFSET 2208988800

// ----- Variables
    // The time server
    Dim SNTP_ServerIP1, SNTP_ServerIP2, SNTP_ServerIP3, SNTP_ServerIP4 As Byte
    // Time of the last good answer: NTP seconds, and millis() when it arrived
    Dim SNTP_Seconds, SNTP_SyncMillis As Long
    Dim SNTP_Valid, SNTP_Stratum, SNTP_Answered As Byte
    // Request number, sent in the transmit timestamp and expected back as the originate timestamp
    Dim SNTP_Nonce As Long

    // UTC from SNTP_Now
    Dim SNTP_Year As Word
    Dim SNTP_Month, SNTP_Day, SNTP_Hour, SNTP_Minute, SNTP_Second As Byte

    #if STACK_STATS = 1
        // Statistics
        Dim Stat_SntpRequests, Stat_SntpReplies, Stat_SntpBad, Stat_SntpTimeouts, Stat_SntpNoRoute As Word
    #endif

// ----- SNTP

Sub SNTP_Init
    // RAM is not cleared at reset
    SNTP_Valid = 0
    SNTP_Stratum = 0
    SNTP_Nonce = 0
    SNTP_SetServer SNTP_SERVER_IP1, SNTP_SERVER_IP2, SNTP_SERVER_IP3, SNTP_SERVER_IP4
    #if STACK_STATS = 1
        Stat_SntpRequests = 0
        Stat_SntpReplies = 0
        Stat_SntpBad = 0
        Stat_SntpTimeouts = 0
        Stat_SntpNoRoute = 0
    #endif
End Sub

Sub SNTP_SetServer(In SntpSet1, In SntpSet2, In SntpSet3, In SntpSet4)
    SNTP_ServerIP1 = SntpSet1 : SNTP_ServerIP2 = SntpSet2 : SNTP_ServerIP3 = SntpSet3 : SNTP_ServerIP4 = SntpSet4
End Sub

Function SNTP_Request As Byte
    // Ask the server for the time and wait for the answer. Returns 1 when the time was set
    Dim SntpSlot, SntpIndex As Byte
    Dim SntpStart As Long

    SNTP_Request = 0
    // No server (e.g. its name could not be resolved): counted as no route
    SntpSlot = ARP_NOT_FOUND
    // The next hop first: resolving uses EthFrame
    If SNTP_ServerIP1 <> 0 Then SntpSlot = IP_ResolveNextHop(SNTP_ServerIP1, SNTP_ServerIP2, SNTP_ServerIP3, SNTP_ServerIP4)
    If SntpSlot = ARP_NOT_FOUND Then
        #if STACK_STATS = 1
            Stat_SntpNoRoute++
        #endif
        Exit Function
    End If

    For SntpIndex = 0 To SNTP_MESSAGE_LENGTH - 1
        EthFrame(UDP_DATA + SntpIndex) = 0
    Next
    EthFrame(SNTPO_FLAGS) = SNTP_REQUEST_FLAGS
    SNTP_Nonce++
    EthFrame(SNTPO_TRANSMIT) = SNTP_Nonce_E
    EthFrame(SNTPO_TRANSMIT + 1) = SNTP_Nonce_U
    EthFrame(SNTPO_TRANSMIT + 2) = SNTP_Nonce_H
    EthFrame(SNTPO_TRANSMIT + 3) = [byte]SNTP_Nonce

    UDP_SegLength = UDP_HEADER_LENGTH + SNTP_MESSAGE_LENGTH
    IP_BuildHeaderTo SntpSlot, SNTP_ServerIP1, SNTP_ServerIP2, SNTP_ServerIP3, SNTP_ServerIP4, IP_PROTO_UDP, UDP_SegLength
    EthFrame(UDP_SRCPORT) = SNTP_LOCAL_PORT / 256
    EthFrame(UDP_SRCPORT + 1) = SNTP_LOCAL_PORT And 255
    EthFrame(UDP_DSTPORT) = 0
    EthFrame(UDP_DSTPORT + 1) = SNTP_SERVER_PORT
    EthFrame(UDP_LENGTH) = 0
    EthFrame(UDP_LENGTH + 1) = UDP_HEADER_LENGTH + SNTP_MESSAGE_LENGTH
    UDP_SetChecksum

    SNTP_Answered = 0
    If ENC_Transmit(IP_Length + IP_VERHL) Then
        #if STACK_STATS = 1
            Stat_SntpRequests++
            Stat_UdpSent++
        #endif
    End If
    SntpStart = Millis()
    Do While SNTP_Answered = 0 And Millis() - SntpStart < SNTP_TIMEOUT_MS
        ENC_Service
    Loop
    If SNTP_Answered = 0 Then
        #if STACK_STATS = 1
            Stat_SntpTimeouts++
        #endif
        Exit Function
    End If
    SNTP_Request = 1
End Function

Sub SNTP_ProcessReply
    // A datagram from port 123 to our SNTP port is in EthFrame, UDP_SegLength bytes long
    If UDP_SegLength < UDP_HEADER_LENGTH + SNTP_MESSAGE_LENGTH Then
        #if STACK_STATS = 1
            Stat_SntpBad++
        #endif
        Exit Sub
    End If
    // Server mode, a usable stratum (0 is a "kiss-o'-death" refusal, 16 unsynchronised)
    If (EthFrame(SNTPO_FLAGS) And 7) <> SNTP_MODE_SERVER Or EthFrame(SNTPO_STRATUM) = 0 Or EthFrame(SNTPO_STRATUM) > 15 Then
        #if STACK_STATS = 1
            Stat_SntpBad++
        #endif
        Exit Sub
    End If
    // Leap indicator 3: the server's clock is not synchronised
    If (EthFrame(SNTPO_FLAGS) And SNTP_LEAP_ALARM) = SNTP_LEAP_ALARM Then
        #if STACK_STATS = 1
            Stat_SntpBad++
        #endif
        Exit Sub
    End If
    // Our latest request, copied back
    If EthFrame(SNTPO_ORIGINATE) <> SNTP_Nonce_E Or EthFrame(SNTPO_ORIGINATE + 1) <> SNTP_Nonce_U Or EthFrame(SNTPO_ORIGINATE + 2) <> SNTP_Nonce_H Or EthFrame(SNTPO_ORIGINATE + 3) <> [byte]SNTP_Nonce Then
        #if STACK_STATS = 1
            Stat_SntpBad++
        #endif
        Exit Sub
    End If

    SNTP_Seconds_E = EthFrame(SNTPO_TRANSMIT)
    SNTP_Seconds_U = EthFrame(SNTPO_TRANSMIT + 1)
    SNTP_Seconds_H = EthFrame(SNTPO_TRANSMIT + 2)
    [byte]SNTP_Seconds = EthFrame(SNTPO_TRANSMIT + 3)
    // Round to the nearest second with the top bit of the fraction
    If EthFrame(SNTPO_TRANSMIT + 4) >= 128 Then SNTP_Seconds++
    SNTP_SyncMillis = Millis()
    SNTP_Stratum = EthFrame(SNTPO_STRATUM)
    SNTP_Valid = 1
    SNTP_Answered = 1
    #if STACK_STATS = 1
        Stat_SntpReplies++
    #endif
End Sub

Sub SNTP_Now
    // UTC now into SNTP_Year, SNTP_Month, SNTP_Day, SNTP_Hour, SNTP_Minute, SNTP_Second
    Dim SntpUnix, SntpDays, SntpRest As Long
    Dim SntpDaysInYear As Word
    Dim SntpHourSeconds As Long
    Dim SntpMonthDays As Byte

    SntpUnix = SNTP_Seconds - SNTP_UNIX_OFFSET + (Millis() - SNTP_SyncMillis) / 1000
    SntpDays = SntpUnix / 86400
    SntpRest = SntpUnix - SntpDays * 86400
    SNTP_Hour = SntpRest / 3600
    // In Long: SNTP_Hour * 3600 is worked out in Word and overflows from 19:00 (19 * 3600 = 68400)
    SntpHourSeconds = SNTP_Hour
    SntpHourSeconds = SntpHourSeconds * 3600
    SntpRest = SntpRest - SntpHourSeconds
    SNTP_Minute = SntpRest / 60
    SNTP_Second = SntpRest - SNTP_Minute * 60

    SNTP_Year = 1970
    Do
        SntpDaysInYear = 365
        If SNTP_IsLeap(SNTP_Year) Then SntpDaysInYear = 366
        If SntpDays < SntpDaysInYear Then Exit Do
        SntpDays = SntpDays - SntpDaysInYear
        SNTP_Year++
    Loop

    SNTP_Month = 1
    Do
        SntpMonthDays = SNTP_DaysInMonth(SNTP_Month, SNTP_Year)
        If SntpDays < SntpMonthDays Then Exit Do
        SntpDays = SntpDays - SntpMonthDays
        SNTP_Month++
    Loop
    SNTP_Day = SntpDays + 1
End Sub

Function SNTP_IsLeap(In LeapYear As Word) As Byte
    SNTP_IsLeap = 0
    If LeapYear Mod 4 = 0 Then
        SNTP_IsLeap = 1
        If LeapYear Mod 100 = 0 And LeapYear Mod 400 <> 0 Then SNTP_IsLeap = 0
    End If
End Function

Function SNTP_DaysInMonth(In MonthNo, In MonthYear As Word) As Byte
    Select Case MonthNo
        Case 4, 6, 9, 11
            SNTP_DaysInMonth = 30
        Case 2
            SNTP_DaysInMonth = 28
            If SNTP_IsLeap(MonthYear) Then SNTP_DaysInMonth = 29
        Case Else
            SNTP_DaysInMonth = 31
    End Select
End Function

#if STACK_CONSOLE <> 0
Sub SNTP_PrintNow
    // UTC yyyy-mm-dd hh:mm:ss
    If SNTP_Valid = 0 Then
        CONSOLE_Print "Time not set"
        Exit Sub
    End If
    SNTP_Now
    CONSOLE_Number SNTP_Year : CONSOLE_Print "-" : SNTP_PrintTwo SNTP_Month : CONSOLE_Print "-" : SNTP_PrintTwo SNTP_Day
    CONSOLE_Print " " : SNTP_PrintTwo SNTP_Hour : CONSOLE_Print ":" : SNTP_PrintTwo SNTP_Minute : CONSOLE_Print ":" : SNTP_PrintTwo SNTP_Second
    CONSOLE_Print " UTC"
End Sub
#endif

#if STACK_CONSOLE <> 0
Sub SNTP_PrintTwo(In TwoDigits)
    If TwoDigits < 10 Then CONSOLE_Print "0"
    CONSOLE_Number TwoDigits
End Sub
#endif

#if STACK_STATS = 1
#if STACK_CONSOLE <> 0
Sub SNTP_PrintStats
    CONSOLE_Print "SNTP requests " : CONSOLE_Number Stat_SntpRequests
    CONSOLE_Print "  replies " : CONSOLE_Number Stat_SntpReplies
    CONSOLE_Print "  bad " : CONSOLE_Number Stat_SntpBad
    CONSOLE_Print "  timeouts " : CONSOLE_Number Stat_SntpTimeouts
    CONSOLE_Print "  no route " : CONSOLE_Number Stat_SntpNoRoute
    CONSOLE_Print "  stratum " : CONSOLE_Number SNTP_Stratum
    CONSOLE_CRLF
End Sub
#endif
#endif
