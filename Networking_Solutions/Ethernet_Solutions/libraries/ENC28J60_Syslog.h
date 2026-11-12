//--------------------------------------------------------------------------------------------------------------------------------
// Syslog client for the ENC28J60 stack (UDP port 514, RFC 3164 style)
//
// A message is built in three steps, so text and numbers can be mixed without string concatenation:
//   If Syslog_Begin Then
//       Syslog_Text "Link up, frames "
//       Syslog_Number Stat_RxFrames
//       Syslog_End
//   End If
// Each message goes out as "<PRI>TAG: text", TAG being the board's DHCP_HOSTNAME (board file), so each board can be told
// apart in the log. It has no timestamp: the syslog server adds the time it received it.
// Nothing may use the network between Syslog_Begin and Syslog_End (the message is built in EthFrame).
//
// Needs ENC28J60_Driver.h, ENC28J60_ARP.h, ENC28J60_IPv4.h and ENC28J60_UDP.h.
//
// The program must define, before including this file:
//   SYSLOG_IP1 to SYSLOG_IP4    the syslog server
//
// The program may define (default below):
//   SYSLOG_PRIORITY    facility * 8 + severity
//
// The board file defines DHCP_HOSTNAME (the tag). The program defines MY_MAC1-6 and includes GCBVersionNumber.cnt
// (GCBBuildStr, GCBBuildTimeStr) for the start-up message.
//
// Syslog_Init runs once at start-up (Stack_Init); it also reads why the chip restarted. After Stack_StartAddress the
// program calls Syslog_SendStart, e.g.
//   enc28j60-4: Start ENC28J60_18F47Q43 build 395 04/11/2026 05:40, reset power-on, DHCP, MAC 00:1E:C0:00:00:04,
//               link 0.0 s, web 80, MQTT 192.168.0.126
//
//@author    Evan R. Venn
//@licence   GPL
//@date      04/11/2026
//
// Changes:
//   01/11/2026  2026 initial release
//   01/11/2026  CON_ names renamed CONSOLE_
//   04/11/2026  Tag is the board's DHCP_HOSTNAME (was "enc28j60" on every board; SYSLOG_TAG removed). Reset cause read
//                    in Syslog_Init (PCON0 on the 18F47Q43, RCON / STKPTR on the 18F97J60 family). Syslog_SendStart: the
//                    start-up message (firmware, build, build time, reset cause, DHCP or fixed, MAC, link time, web, MQTT)
//   04/11/2026  #option explicit
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

    // Console switch STACK_CONSOLE (0 headless, 1 serial, 2 TCP terminal) is set by the stack, from the program. No
    // default here: a default inside #ifndef was taken as well as the program's value (both console versions were compiled)

    // Statistics switch: 1 = counters and PrintStats in the program, 0 = left out (set by the program or ENC28J60_Stack)
    #ifndef STACK_STATS
        #define STACK_STATS 1
    #endif

// ----- Options

    // local0 (16) * 8 + informational (6)
    #ifndef SYSLOG_PRIORITY
        #define SYSLOG_PRIORITY 134
    #endif

    #define SYSLOG_PORT 514

    // Reset causes (Syslog_ResetCause)
    #define SYSLOG_RESET_OTHER    0
    #define SYSLOG_RESET_MCLR     1
    #define SYSLOG_RESET_SOFTWARE 2
    #define SYSLOG_RESET_WATCHDOG 3
    #define SYSLOG_RESET_STACK    4
    #define SYSLOG_RESET_BROWNOUT 5
    #define SYSLOG_RESET_POWER    6

// ----- Variables
    Dim Syslog_Pos As Word
    Dim Syslog_Slot As Byte
    Dim Syslog_ResetCause As Byte
    // GCBBuildTimeStr copied, for Syslog_SendStart
    Dim Syslog_BuildTime As String * 20

    #if STACK_STATS = 1
        // Statistics
        Dim Stat_SyslogSent, Stat_SyslogNoServer As Word
    #endif

// ----- Syslog

Sub Syslog_Init
    // RAM is not cleared at reset
    #if STACK_STATS = 1
        Stat_SyslogSent = 0
        Stat_SyslogNoServer = 0
    #endif
    // Why the chip restarted, from its reset flags. Each test that matches overrides the one before, so the last (power-on)
    // wins: a power-on also clears the brown-out flag. The flags are then set back, so the next reset reads true
    Syslog_ResetCause = SYSLOG_RESET_OTHER
    #ifdef bit(NRMCLR)
        // PCON0 (18F47Q43, 16F18877): 0 marks the reset, STKOVF / STKUNF 1. Neither flag set: PCON1 (memory violation)
        If NRMCLR = 0 Then Syslog_ResetCause = SYSLOG_RESET_MCLR
        If NRI = 0 Then Syslog_ResetCause = SYSLOG_RESET_SOFTWARE
        If NRWDT = 0 Then Syslog_ResetCause = SYSLOG_RESET_WATCHDOG
        If NWDTWV = 0 Then Syslog_ResetCause = SYSLOG_RESET_WATCHDOG
        If STKUNF = 1 Then Syslog_ResetCause = SYSLOG_RESET_STACK
        If STKOVF = 1 Then Syslog_ResetCause = SYSLOG_RESET_STACK
        If NBOR = 0 Then Syslog_ResetCause = SYSLOG_RESET_BROWNOUT
        If NPOR = 0 Then Syslog_ResetCause = SYSLOG_RESET_POWER
        PCON0 = 0x3F
    #endif
    #ifdef bit(STKFUL)
        // RCON and STKPTR (18F97J60 family): no MCLR flag, so MCLR when nothing else is marked. CM 0: configuration
        // mismatch (other)
        Syslog_ResetCause = SYSLOG_RESET_MCLR
        If CM = 0 Then Syslog_ResetCause = SYSLOG_RESET_OTHER
        If NOT_RI = 0 Then Syslog_ResetCause = SYSLOG_RESET_SOFTWARE
        If NOT_TO = 0 Then Syslog_ResetCause = SYSLOG_RESET_WATCHDOG
        If STKUNF = 1 Then Syslog_ResetCause = SYSLOG_RESET_STACK
        If STKFUL = 1 Then Syslog_ResetCause = SYSLOG_RESET_STACK
        If NOT_BOR = 0 Then Syslog_ResetCause = SYSLOG_RESET_BROWNOUT
        If NOT_POR = 0 Then Syslog_ResetCause = SYSLOG_RESET_POWER
        CM = 1
        NOT_RI = 1
        NOT_POR = 1
        NOT_BOR = 1
        STKFUL = 0
        STKUNF = 0
        // TO is read only: CLRWDT sets it again
        clrwdt
    #endif
End Sub

Function Syslog_Begin As Byte
    // Find the server's MAC and start a message. Returns 0 when the server does not answer ARP
    Syslog_Begin = 0
    Syslog_Slot = ARP_Resolve(SYSLOG_IP1, SYSLOG_IP2, SYSLOG_IP3, SYSLOG_IP4)
    If Syslog_Slot = ARP_NOT_FOUND Then
        #if STACK_STATS = 1
            Stat_SyslogNoServer++
        #endif
        Exit Function
    End If
    Syslog_Pos = UDP_DATA
    Syslog_Text "<"
    Syslog_Number SYSLOG_PRIORITY
    Syslog_Text ">"
    Syslog_Text DHCP_HOSTNAME
    Syslog_Text ": "
    Syslog_Begin = 1
End Function

Sub Syslog_Text(In SyslogText As String)
    // Add the text; characters past the end of the frame buffer are dropped
    Dim SyslogIndex As Byte
    For SyslogIndex = 1 To Len(SyslogText)
        If Syslog_Pos < ETH_BUFFER_SIZE Then
            EthFrame(Syslog_Pos) = SyslogText(SyslogIndex)
            Syslog_Pos++
        End If
    Next
End Sub

Sub Syslog_Number(In SyslogValue As Word)
    // Add the value in decimal, no leading zeros
    Dim SyslogDigit, SyslogStarted As Byte
    Dim SyslogDivisor As Word
    SyslogStarted = 0
    SyslogDivisor = 10000
    Do While SyslogDivisor > 0
        SyslogDigit = SyslogValue / SyslogDivisor
        SyslogValue = SyslogValue - SyslogDigit * SyslogDivisor
        If SyslogDigit <> 0 Or SyslogStarted = 1 Or SyslogDivisor = 1 Then
            If Syslog_Pos < ETH_BUFFER_SIZE Then
                EthFrame(Syslog_Pos) = SyslogDigit + 48
                Syslog_Pos++
            End If
            SyslogStarted = 1
        End If
        SyslogDivisor = SyslogDivisor / 10
    Loop
End Sub

Sub Syslog_Hex(In SyslogHexValue)
    // Add the byte as two hex digits
    Dim SyslogNibble As Byte
    SyslogNibble = SyslogHexValue / 16
    Syslog_HexDigit
    SyslogNibble = SyslogHexValue And 0x0F
    Syslog_HexDigit
End Sub

Sub Syslog_HexDigit
    // Add SyslogNibble (0-15) as one hex digit
    If SyslogNibble > 9 Then SyslogNibble = SyslogNibble + 7
    If Syslog_Pos < ETH_BUFFER_SIZE Then
        EthFrame(Syslog_Pos) = SyslogNibble + 48
        Syslog_Pos++
    End If
End Sub

Sub Syslog_Built(In SyslogBuiltFrom, In SyslogBuiltCount)
    // Add SyslogBuiltCount characters of the build time from position SyslogBuiltFrom
    Dim SyslogBuiltIndex As Byte
    For SyslogBuiltIndex = 1 To SyslogBuiltCount
        If Syslog_Pos < ETH_BUFFER_SIZE Then
            EthFrame(Syslog_Pos) = Syslog_BuildTime(SyslogBuiltFrom)
            Syslog_Pos++
        End If
        SyslogBuiltFrom++
    Next
End Sub

Sub Syslog_SendStart
    // The start-up message, sent once after Stack_StartAddress, e.g.
    // "Start ENC28J60_18F47Q43 build 395 04/11/2026 05:40, reset power-on, DHCP, MAC 00:1E:C0:00:00:04, link 0.0 s,
    //  web 80, MQTT 192.168.0.126"
    If Syslog_Begin = 0 Then Exit Sub
    Syslog_Text "Start "
    Syslog_Text SOURCEFILE
    Syslog_Text " build "
    Syslog_Text GCBBuildStr
    // GCBBuildTimeStr is "MM-DD-YYYY HH:MM:SS": shown as DD/MM/YYYY HH:MM
    Syslog_BuildTime = GCBBuildTimeStr
    Syslog_Text " "
    Syslog_Built 4, 2
    Syslog_Text "/"
    Syslog_Built 1, 2
    Syslog_Text "/"
    Syslog_Built 7, 10
    Syslog_Text ", reset "
    Select Case Syslog_ResetCause
        Case SYSLOG_RESET_POWER: Syslog_Text "power-on"
        Case SYSLOG_RESET_BROWNOUT: Syslog_Text "brown-out"
        Case SYSLOG_RESET_STACK: Syslog_Text "stack"
        Case SYSLOG_RESET_WATCHDOG: Syslog_Text "watchdog"
        Case SYSLOG_RESET_SOFTWARE: Syslog_Text "software"
        Case SYSLOG_RESET_MCLR: Syslog_Text "MCLR"
        Case Else: Syslog_Text "other"
    End Select
    #if STACK_DHCP = 1
        If DHCP_Bound = 1 Then
            Syslog_Text ", DHCP"
        Else
            Syslog_Text ", fixed"
        End If
    #endif
    #if STACK_DHCP = 0
        Syslog_Text ", fixed"
    #endif
    Syslog_Text ", MAC "
    Syslog_Hex MY_MAC1 : Syslog_Text ":" : Syslog_Hex MY_MAC2 : Syslog_Text ":" : Syslog_Hex MY_MAC3 : Syslog_Text ":"
    Syslog_Hex MY_MAC4 : Syslog_Text ":" : Syslog_Hex MY_MAC5 : Syslog_Text ":" : Syslog_Hex MY_MAC6
    // Time Stack_StartAddress waited for the link, in tenths of a second (300 = no link after 30 s)
    If Stack_LinkTenths >= 300 Then
        Syslog_Text ", no link"
    Else
        Syslog_Text ", link "
        Syslog_Number Stack_LinkTenths / 10
        Syslog_Text "."
        Syslog_Number Stack_LinkTenths % 10
        Syslog_Text " s"
    End If
    #if STACK_HTTP = 1
        Syslog_Text ", web "
        Syslog_Number TCP_LISTEN_PORT
    #endif
    #if STACK_MQTT = 1
        Syslog_Text ", MQTT "
        Syslog_Number MQTT_BROKER1 : Syslog_Text "." : Syslog_Number MQTT_BROKER2 : Syslog_Text "."
        Syslog_Number MQTT_BROKER3 : Syslog_Text "." : Syslog_Number MQTT_BROKER4
    #endif
    Syslog_End
End Sub

Sub Syslog_End
    If UDP_Send(Syslog_Slot, SYSLOG_PORT, SYSLOG_PORT, Syslog_Pos - UDP_DATA) Then
        #if STACK_STATS = 1
            Stat_SyslogSent++
        #endif
    End If
End Sub

#if STACK_STATS = 1
#if STACK_CONSOLE <> 0
Sub Syslog_PrintStats
    CONSOLE_Print "Syslog sent " : CONSOLE_Number Stat_SyslogSent
    CONSOLE_Print "  no server " : CONSOLE_Number Stat_SyslogNoServer
    CONSOLE_CRLF
End Sub
#endif
#endif
