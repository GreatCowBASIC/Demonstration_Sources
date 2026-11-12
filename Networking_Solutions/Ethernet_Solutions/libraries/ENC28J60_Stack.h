//--------------------------------------------------------------------------------------------------------------------------------
// ENC28J60 stack - the one file a program includes
//
// Includes ARP and IPv4 always, and the optional modules by switch. The Ethernet driver is included by the board file
// (hardwareconfig.h), as it depends on the hardware. A module that is switched off is never
// called, so none of its code is compiled (GCBASIC compiles only routines that are called; note that an #include inside
// #if is not conditional). The frame, datagram and UDP dispatch is here too, so the program never calls into a module
// that is switched off.
//
// Switches: the program defines every one before including this file (the bracket shows the usual value). A switch
// that is missing gives a warning ("... switch is STACK_...") and counts as 0.
//   STACK_ICMP       answer ping                                         (1)
//   STACK_PING       ping other hosts, ICMP_Ping                          (0)  needs STACK_ICMP
//   STACK_UDP        UDP                                                  (1)
//   STACK_UDP_ECHO   UDP echo service on port 7                           (0)  needs STACK_UDP
//   STACK_SYSLOG     syslog client                                        (0)  needs STACK_UDP
//   STACK_SNTP       SNTP client                                          (0)  needs STACK_UDP
//   STACK_DHCP       DHCP client; 0 = fixed address only                  (0)  needs STACK_UDP
//   STACK_DNS        DNS resolver, DNS_Resolve("host.name")               (0)  needs STACK_UDP
//   STACK_TCP        TCP: web server, MQTT client and terminal            (0)  the stack passes data to HTTP (server),
//                    connections                                                MQTT (client) and the TCP terminal
//   STACK_HTTP       web server: pages through program functions          (0)  needs STACK_TCP; the program defines
//                    the page functions listed in ENC28J60_HTTP.h
//   STACK_MQTT       MQTT client: publish values, receive commands        (0)  needs STACK_TCP; the program defines
//                    the broker, login and functions listed in ENC28J60_MQTT.h
//   STACK_STATS      statistics counters and Stack_PrintStats; 0 = none    (1)
//   STACK_CONSOLE    0 headless (no console at all), 1 serial console,     (1)  2 needs STACK_TCP
//                    2 TCP terminal (telnet to port 23)
//   STACK_SERIAL_UDP serial input as UDP to the peer (or broadcast), and  (0)  needs STACK_UDP and the serial port
//                    UDP to our port 50001 out on the serial port          (not STACK_CONSOLE 1)
//                    (ENC28J60_SerialUdp.h; the program calls SerUdp_Service in its main loop)
// A switch that is not 0 or 1 gives a warning and counts as 0. A combination that cannot work stops the compile with a
// message. The compiler output shows the configuration, e.g.
//   Info: ENC28J60 STACK ICMP 1 PING 0 UDP 1 ECHO 0 SYSLOG 1 SNTP 1 DHCP 0 DNS 1 TCP 0 HTTP 0 MQTT 0 STATS 1 CONSOLE 1 SERIALUDP 0
//
// The program must define what the included libraries need: MY_MAC1-6; MY_IP1-4, IP_NETMASK1-4 and IP_GATEWAY1-4
// (the fixed address, also the fall-back with DHCP); SYSLOG_IP1-4 with STACK_SYSLOG; with STACK_SNTP
// SNTP_SERVER_IP1-4, or SNTP_ServerIP1-4 set at run time (SNTP_SetServer or DNS_Resolve);
// pins and ETH_BUFFER_SIZE as for the driver. With STACK_DNS the DNS server is the one the DHCP lease gives, else
// DNS_SERVER1-4 (default: the gateway IP_GATEWAY1-4).
//
// The program calls Stack_Init once (after ENC_Init), Stack_StartAddress to get the address, Stack_Tick once a second,
// and ENC_Service as often as it can.
//
// Libraries (ENC28J60\libraries): ENC28J60_ARP.h, ENC28J60_IPv4.h, and as switched
// ENC28J60_ICMP.h, ENC28J60_UDP.h, ENC28J60_Syslog.h, ENC28J60_SNTP.h, ENC28J60_DHCP.h,
// ENC28J60_DNS.h, ENC28J60_TCP.h, ENC28J60_HTTP.h,
// ENC28J60_MQTT.h, ENC28J60_SerialUdp.h
//
//@author    Evan R. Venn
//@licence   GPL
//@date      10/11/2026
//
// Changes:
//   01/11/2026  2026 initial release
//   01/11/2026  CON_ names renamed CONSOLE_
//   01/11/2026  The Ethernet driver is included by the board file (ENC28J60_Driver.h or ENC28J60_J60Driver.h)
//   02/11/2026  Stack_StartAddress waits for the link (up to 30 s) before DHCP: the built-in PHY links late (about 20 s)
//   03/11/2026  DHCP only with a link; when the link comes up without a lease (later than the 30 s wait, or DHCP failed),
//                    Stack_Tick asks DHCP again (PIC-WEB: link up 21 s after DHCP had failed, left on the fixed address)
//   03/11/2026  The link state at start-up kept from the wait loop: a second ENC_LinkIsUp flipped the PICDEM.net 2 J1 RX
//                    polarity (ENC28J60_RX_SWAP) before DHCP, so start-up DHCP, syslog and SNTP failed
//   04/11/2026  Stack_LinkTenths: how long Stack_StartAddress waited for the link (for the syslog start-up message)
//   04/11/2026  #option explicit
//   04/11/2026  USART_BAUD_RATE checked here, only with the serial console (1) or serial to UDP (was in the board file)
//   04/11/2026  Stack_StartAddress announces the address (ARP_ANNOUNCE_COUNT, ARP_ANNOUNCE_INTERVAL_MS, defaults 2 and 2000 ms):
//                    the programs no longer do it
//   06/11/2026  Stack_Tick checks the Ethernet controller once a second (ENC_CheckAlive); found reset, it is set up
//                    again (ENC_Init), counted in Stack_EncResets, reported on the console and to syslog
//   07/11/2026  The web server is TCP connections 0 and 3 (ENC28J60_TCP.h second server connection)
//   10/11/2026  Stack_Tick checks the receive position once a second (ENC_CheckReceive); found behind, the receive
//                    buffer is restarted, counted in Stack_RxResets and reported on the console
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

// ----- Switches: no defaults (a #script cannot see constants defined inside #if or #ifndef, so a default there
//       would not reach the checks below): the program defines every switch

    // Start-up announce (RFC 5227): Stack_StartAddress sends ARP_ANNOUNCE_COUNT gratuitous ARPs, ARP_ANNOUNCE_INTERVAL_MS
    // apart, once the address is set. No #script checks these, so a default here is safe
    #ifndef ARP_ANNOUNCE_COUNT
        #define ARP_ANNOUNCE_COUNT 2
    #endif
    #ifndef ARP_ANNOUNCE_INTERVAL_MS
        #define ARP_ANNOUNCE_INTERVAL_MS 2000
    #endif

    // DNS server for a fixed address (and when the DHCP lease gives none)
    #ifndef DNS_SERVER1
        #define DNS_SERVER1 IP_GATEWAY1
        #define DNS_SERVER2 IP_GATEWAY2
        #define DNS_SERVER3 IP_GATEWAY3
        #define DNS_SERVER4 IP_GATEWAY4
    #endif

// ----- Switches: each must be 0 or 1; any other value gives a warning and counts as 0 (the module is left out).
//       In #script message text a constant name is replaced by its value, "or" becomes "|", "not" becomes "!" and a
//       colon ends the message, so the messages avoid them

    #script
        if STACK_ICMP <> 0 then
            if STACK_ICMP <> 1 then
                Warning ICMP switch is STACK_ICMP, use 0 to leave out, 1 to include - ICMP left out
                STACK_ICMP = 0
            end if
        end if
        if STACK_PING <> 0 then
            if STACK_PING <> 1 then
                Warning Ping switch is STACK_PING, use 0 to leave out, 1 to include - ping client left out
                STACK_PING = 0
            end if
        end if
        if STACK_UDP <> 0 then
            if STACK_UDP <> 1 then
                Warning UDP switch is STACK_UDP, use 0 to leave out, 1 to include - UDP left out
                STACK_UDP = 0
            end if
        end if
        if STACK_UDP_ECHO <> 0 then
            if STACK_UDP_ECHO <> 1 then
                Warning UDP echo switch is STACK_UDP_ECHO, use 0 to leave out, 1 to include - UDP echo left out
                STACK_UDP_ECHO = 0
            end if
        end if
        if STACK_SYSLOG <> 0 then
            if STACK_SYSLOG <> 1 then
                Warning Syslog switch is STACK_SYSLOG, use 0 to leave out, 1 to include - syslog left out
                STACK_SYSLOG = 0
            end if
        end if
        if STACK_SNTP <> 0 then
            if STACK_SNTP <> 1 then
                Warning SNTP switch is STACK_SNTP, use 0 to leave out, 1 to include - SNTP left out
                STACK_SNTP = 0
            end if
        end if
        if STACK_DHCP <> 0 then
            if STACK_DHCP <> 1 then
                Warning DHCP switch is STACK_DHCP, use 0 to leave out, 1 to include - DHCP left out
                STACK_DHCP = 0
            end if
        end if
        if STACK_DNS <> 0 then
            if STACK_DNS <> 1 then
                Warning DNS switch is STACK_DNS, use 0 to leave out, 1 to include - DNS left out
                STACK_DNS = 0
            end if
        end if
        if STACK_TCP <> 0 then
            if STACK_TCP <> 1 then
                Warning TCP switch is STACK_TCP, use 0 to leave out, 1 to include - TCP left out
                STACK_TCP = 0
            end if
        end if
        if STACK_MQTT <> 0 then
            if STACK_MQTT <> 1 then
                Warning MQTT switch is STACK_MQTT, use 0 to leave out, 1 to include - MQTT left out
                STACK_MQTT = 0
            end if
        end if
        if STACK_HTTP <> 0 then
            if STACK_HTTP <> 1 then
                Warning HTTP switch is STACK_HTTP, use 0 to leave out, 1 to include - HTTP left out
                STACK_HTTP = 0
            end if
        end if
        if STACK_CONSOLE <> 0 then
            if STACK_CONSOLE <> 1 then
                if STACK_CONSOLE <> 2 then
                    Warning Console switch is STACK_CONSOLE, use 0 for headless, 1 for serial, 2 for a TCP terminal - console left out
                    STACK_CONSOLE = 0
                end if
            end if
        end if
        if STACK_SERIAL_UDP <> 0 then
            if STACK_SERIAL_UDP <> 1 then
                Warning Serial to UDP switch is STACK_SERIAL_UDP, use 0 to leave out, 1 to include - left out
                STACK_SERIAL_UDP = 0
            end if
        end if
        if STACK_STATS <> 0 then
            if STACK_STATS <> 1 then
                Warning Statistics switch is STACK_STATS, use 0 to leave out, 1 to include - statistics left out
                STACK_STATS = 0
            end if
        end if
    #endscript

// ----- Switches: combinations that cannot work stop the compile

    #script
        if STACK_PING = 1 then
            if STACK_ICMP = 0 then
                Error Ping needs ICMP - set the ICMP switch to 1
            end if
        end if
        if STACK_UDP = 0 then
            if STACK_UDP_ECHO = 1 then
                Error UDP echo needs UDP - set the UDP switch to 1
            end if
            if STACK_SYSLOG = 1 then
                Error Syslog needs UDP - set the UDP switch to 1
            end if
            if STACK_SNTP = 1 then
                Error SNTP needs UDP - set the UDP switch to 1
            end if
            if STACK_DHCP = 1 then
                Error DHCP needs UDP - set the UDP switch to 1
            end if
            if STACK_DNS = 1 then
                Error DNS needs UDP - set the UDP switch to 1
            end if
            if STACK_SERIAL_UDP = 1 then
                Error Serial to UDP needs UDP - set the UDP switch to 1
            end if
        end if
        if STACK_SERIAL_UDP = 1 then
            if STACK_CONSOLE = 1 then
                Error Serial to UDP needs the serial port - the console uses it - set the console switch to 0 for headless, 2 for the TCP terminal
            end if
        end if
        if STACK_CONSOLE = 1 then
            if nodef(USART_BAUD_RATE) then
                Error The serial console needs USART_BAUD_RATE - define it in the program before including hardwareconfig.h
            end if
        end if
        if STACK_SERIAL_UDP = 1 then
            if nodef(USART_BAUD_RATE) then
                Error Serial to UDP needs USART_BAUD_RATE - define it in the program before including hardwareconfig.h
            end if
        end if
        if STACK_CONSOLE = 2 then
            if STACK_TCP = 0 then
                Error The TCP terminal needs TCP - set the TCP switch to 1
            end if
        end if
        if STACK_MQTT = 1 then
            if STACK_TCP = 0 then
                Error MQTT needs TCP - set the TCP switch to 1
            end if
        end if
        if STACK_HTTP = 1 then
            if STACK_TCP = 0 then
                Error HTTP needs TCP - set the TCP switch to 1
            end if
        end if
    #endscript

// ----- Switches: the configuration as an Info line in the compiler output (after any corrections above)

    #script
        Info ENC28J60 stack ICMP STACK_ICMP PING STACK_PING UDP STACK_UDP ECHO STACK_UDP_ECHO SYSLOG STACK_SYSLOG SNTP STACK_SNTP DHCP STACK_DHCP DNS STACK_DNS TCP STACK_TCP HTTP STACK_HTTP MQTT STACK_MQTT STATS STACK_STATS CONSOLE STACK_CONSOLE SERIALUDP STACK_SERIAL_UDP
    #endscript

// ----- Libraries: the core always, the rest as switched

    #include <millis.h>
    #include <ENC28J60_Console.h>
    #include <ENC28J60_ARP.h>
    #include <ENC28J60_IPv4.h>
    #if STACK_ICMP = 1
        #include <ENC28J60_ICMP.h>
    #endif
    #if STACK_UDP = 1
        #include <ENC28J60_UDP.h>
    #endif
    #if STACK_SYSLOG = 1
        #include <ENC28J60_Syslog.h>
    #endif
    #if STACK_SNTP = 1
        #include <ENC28J60_SNTP.h>
    #endif
    #if STACK_DHCP = 1
        #include <ENC28J60_DHCP.h>
    #endif
    #if STACK_DNS = 1
        #include <ENC28J60_DNS.h>
    #endif
    #if STACK_TCP = 1
        // The TCP terminal is connection 2 of TCP
        #if STACK_CONSOLE = 2
            #define TCP_TERMINAL 1
        #endif
        #include <ENC28J60_TCP.h>
    #endif
    #if STACK_HTTP = 1
        #include <ENC28J60_HTTP.h>
    #endif
    #if STACK_MQTT = 1
        #include <ENC28J60_MQTT.h>
    #endif
    #if STACK_SERIAL_UDP = 1
        #include <ENC28J60_SerialUdp.h>
    #endif

    #define STACK_UDP_ECHO_PORT 7

    // Stack_Tick results
    #define STACK_TICK_NOTHING 0
    #define STACK_TICK_LINK_UP 1
    #define STACK_TICK_LINK_DOWN 2
    #define STACK_TICK_ENC_RESET 3

// ----- Variables
    // DHCP_Tick result of the latest Stack_Tick (DHCP_TICK_...), for the program to report
    Dim Stack_DhcpEvent As Byte
    // Tenths of a second Stack_StartAddress waited for the link (300: no link)
    Dim Stack_LinkTenths As Word
    // Times the Ethernet controller was found reset and set up again (Stack_Tick); 1 = still to tell syslog
    Dim Stack_EncResets As Word
    Dim Stack_EncResetReport As Byte
    // Times the receive position was found behind the controller and the receive buffer restarted (Stack_Tick)
    Dim Stack_RxResets As Word

// ----- Start-up

Sub Stack_Init
    // RAM is not cleared at reset: every included module starts empty. The address is 0.0.0.0 until Stack_StartAddress
    ARP_Init
    IP_Init
    #if STACK_ICMP = 1
        ICMP_Init
    #endif
    #if STACK_UDP = 1
        UDP_Init
    #endif
    #if STACK_SYSLOG = 1
        Syslog_Init
    #endif
    #if STACK_SNTP = 1
        SNTP_Init
    #endif
    #if STACK_DHCP = 1
        DHCP_Init
    #endif
    #if STACK_DNS = 1
        DNS_Init
    #endif
    #if STACK_TCP = 1
        TCP_Init
    #endif
    #if STACK_HTTP = 1
        HTTP_Init
    #endif
    #if STACK_MQTT = 1
        MQTT_Init
    #endif
    #if STACK_SERIAL_UDP = 1
        SerUdp_Init
    #endif
    Stack_DhcpEvent = 0
    Stack_EncResets = 0
    Stack_RxResets = 0
    Stack_EncResetReport = 0
End Sub

Function Stack_StartAddress As Byte
    // DHCP when switched in, else (or when no DHCP server answers) the fixed address. Returns 1 for a DHCP lease
    Stack_StartAddress = 0
    // Wait for the link, up to 30 s: the built-in Ethernet PHY restarts with ENC_Init and links later (PICDEM.net 2 J1:
    // about 20 s). Without the link, DHCP, ARP and SNTP at start-up all fail. Ends as soon as the link is up
    // The link state is kept from the loop, not read again: on a board with ENC28J60_RX_SWAP each ENC_LinkIsUp call while
    // nothing has been received flips the RX polarity, so an extra call can leave it wrong for DHCP
    Dim StackLinked As Byte
    StackLinked = 0
    Stack_LinkTenths = 0
    Repeat 300
        If ENC_LinkIsUp = 1 Then
            StackLinked = 1
            Exit Repeat
        End If
        Wait 100 ms
        Stack_LinkTenths++
    End Repeat
    // Stack_Tick reports a later change only
    ENC_LinkUp = StackLinked
    #if STACK_DHCP = 1
        // DHCP only with a link: without one no server can answer. When the link comes up later, Stack_Tick asks then
        If StackLinked = 1 Then
            If DHCP_Start Then Stack_StartAddress = 1
        End If
    #endif
    If Stack_StartAddress = 0 Then IP_SetStatic
    #if STACK_DNS = 1
        Stack_SetDnsServer
    #endif
    Stack_Announce
End Function

Sub Stack_Announce
    // Announce our address (RFC 5227): ARP_ANNOUNCE_COUNT gratuitous ARPs, each followed by ARP_ANNOUNCE_INTERVAL_MS
    // in which frames are still received and answered
    Dim StackAnnounce As Byte
    Dim StackWaitStart As Long
    For StackAnnounce = 1 To ARP_ANNOUNCE_COUNT
        ARP_SendGratuitous
        StackWaitStart = Millis()
        Do While Millis() - StackWaitStart < ARP_ANNOUNCE_INTERVAL_MS
            ENC_Service
        Loop
    Next
End Sub

#if STACK_DNS = 1
Sub Stack_SetDnsServer
    // The DNS server of the DHCP lease, else DNS_SERVER1-4
    #if STACK_DHCP = 1
        If DHCP_Bound = 1 Then
            If DHCP_Dns1 <> 0 Then
                DNS_SetServer DHCP_Dns1, DHCP_Dns2, DHCP_Dns3, DHCP_Dns4
                Exit Sub
            End If
        End If
    #endif
    DNS_SetServer DNS_SERVER1, DNS_SERVER2, DNS_SERVER3, DNS_SERVER4
End Sub
#endif

Function Stack_Tick As Byte
    // Once a second: ARP cache ageing, link changes (with a gratuitous ARP on link up), DHCP lease.
    // Returns STACK_TICK_LINK_UP or STACK_TICK_LINK_DOWN when the link changed
    Dim StackLink As Byte
    Stack_Tick = STACK_TICK_NOTHING
    // The Ethernet controller reset on its own (its MAC address is gone): set it up again. Its PHY restarts too, so
    // the link reads down for a while; the link-up below then sends a gratuitous ARP (and asks DHCP when needed)
    If ENC_CheckAlive = 0 Then
        Stack_EncResets++
        #if STACK_CONSOLE <> 0
            CONSOLE_Print "Ethernet controller reset found - set up again (" : CONSOLE_Number Stack_EncResets : CONSOLE_Print ")"
            CONSOLE_CRLF
        #endif
        If ENC_Init Then
            ENC_LinkUp = 0
            #if STACK_SYSLOG = 1
                // Said once the link is back: the syslog server is not reachable before
                Stack_EncResetReport = 1
            #endif
        End If
        Stack_Tick = STACK_TICK_ENC_RESET
        Exit Function
    End If
    // Frames left in the receive buffer behind the read position (ENC_CheckReceive): restart the receive buffer
    If ENC_CheckReceive = 1 Then
        Stack_RxResets++
        #if STACK_CONSOLE <> 0
            CONSOLE_Print "RX behind - receive reset (" : CONSOLE_Number Stack_RxResets : CONSOLE_Print ")"
            CONSOLE_CRLF
        #endif
    End If
    ARP_CacheTick
    #if STACK_TCP = 1
        TCP_Tick
    #endif
    #if STACK_MQTT = 1
        MQTT_Tick
    #endif
    StackLink = ENC_LinkIsUp
    If StackLink <> ENC_LinkUp Then
        ENC_LinkUp = StackLink
        If StackLink = 1 Then
            #if STACK_DHCP = 1
                // No lease (the link came up after the start-up wait, or DHCP failed): ask now, else keep the fixed address
                If DHCP_Bound = 0 Then
                    If DHCP_Start = 0 Then IP_SetStatic
                    #if STACK_DNS = 1
                        Stack_SetDnsServer
                    #endif
                End If
            #endif
            ARP_SendGratuitous
            #if STACK_SYSLOG = 1
                If Stack_EncResetReport = 1 Then
                    If Syslog_Begin Then
                        Syslog_Text "Ethernet controller reset found and set up again, "
                        Syslog_Number Stack_EncResets
                        Syslog_Text " so far"
                        Syslog_End
                        Stack_EncResetReport = 0
                    End If
                End If
            #endif
            Stack_Tick = STACK_TICK_LINK_UP
        Else
            Stack_Tick = STACK_TICK_LINK_DOWN
        End If
    End If
    #if STACK_DHCP = 1
        Stack_DhcpEvent = DHCP_Tick
        // Lease lost: ask again, else the fixed address
        If Stack_DhcpEvent = DHCP_TICK_EXPIRED Then
            If DHCP_Start = 0 Then IP_SetStatic
            ARP_SendGratuitous
        End If
        #if STACK_DNS = 1
            // A new or renewed lease can name another DNS server
            If Stack_DhcpEvent <> DHCP_TICK_NOTHING Then Stack_SetDnsServer
        #endif
    #endif
End Function

// ----- Dispatch

Sub ENC_HandleFrame
    // Called by ENC_Service for each good frame
    If ARP_IsArpFrame Then
        ARP_ProcessFrame
        Exit Sub
    End If
    If IP_IsIpFrame Then
        IP_ProcessFrame
        Exit Sub
    End If
    #if STACK_STATS = 1
        Stat_RxOther++
    #endif
End Sub

Sub IP_HandleDatagram
    // Called by IP_ProcessFrame for each good datagram. Not addressed to our IP (broadcast, or before the address is
    // set): only UDP, for DHCP
    If IP_RxBroadcast = 1 Then
        If EthFrame(IP_PROTO) <> 17 Then Exit Sub
    End If
    #if STACK_ICMP = 1
        If EthFrame(IP_PROTO) = IP_PROTO_ICMP Then
            ICMP_ProcessPacket
            Exit Sub
        End If
    #endif
    #if STACK_UDP = 1
        If EthFrame(IP_PROTO) = IP_PROTO_UDP Then
            UDP_ProcessPacket
            Exit Sub
        End If
    #endif
    #if STACK_TCP = 1
        If EthFrame(IP_PROTO) = IP_PROTO_TCP Then
            TCP_ProcessSegment
            Exit Sub
        End If
    #endif
    #if STACK_STATS = 1
        Stat_IpOtherProto++
    #endif
End Sub

#if STACK_UDP = 1
Sub UDP_HandleDatagram
    // Called by UDP_ProcessPacket for each good datagram
    #if STACK_DHCP = 1
        // DHCP answers come to the broadcast address or to our address
        If UDP_RxDstPort = DHCP_CLIENT_PORT Then
            If UDP_RxSrcPort = DHCP_SERVER_PORT Then
                DHCP_ProcessReply
                Exit Sub
            End If
        End If
    #endif
    // Everything else only when it was addressed to us
    If IP_RxBroadcast = 1 Then Exit Sub
    #if STACK_SERIAL_UDP = 1
        If UDP_RxDstPort = SERUDP_PORT Then
            SerUdp_ProcessDatagram
            Exit Sub
        End If
    #endif
    #if STACK_UDP_ECHO = 1
        If UDP_RxDstPort = STACK_UDP_ECHO_PORT Then
            UDP_EchoReply
            Exit Sub
        End If
    #endif
    #if STACK_DNS = 1
        If UDP_RxDstPort = DNS_LOCAL_PORT Then
            If UDP_RxSrcPort = DNS_SERVER_PORT Then
                DNS_ProcessReply
                Exit Sub
            End If
        End If
    #endif
    #if STACK_SNTP = 1
        If UDP_RxDstPort = SNTP_LOCAL_PORT Then
            If UDP_RxSrcPort = SNTP_SERVER_PORT Then
                SNTP_ProcessReply
                Exit Sub
            End If
        End If
    #endif
    #if STACK_STATS = 1
        Stat_UdpNoPort++
    #endif
End Sub
#endif

// ----- Statistics

#if STACK_CONSOLE <> 0
#if STACK_STATS = 1
Sub Stack_PrintStats
    // The counters of every included module
    ENC_PrintStats
    ARP_PrintStats
    IP_PrintStats
    #if STACK_ICMP = 1
        ICMP_PrintStats
    #endif
    #if STACK_UDP = 1
        UDP_PrintStats
    #endif
    #if STACK_SYSLOG = 1
        Syslog_PrintStats
    #endif
    #if STACK_SNTP = 1
        SNTP_PrintStats
    #endif
    #if STACK_DHCP = 1
        DHCP_PrintStats
    #endif
    #if STACK_DNS = 1
        DNS_PrintStats
    #endif
    #if STACK_TCP = 1
        TCP_PrintStats
    #endif
    #if STACK_HTTP = 1
        HTTP_PrintStats
    #endif
End Sub
#endif
#endif

#if STACK_TCP = 1
// ----- TCP to the applications: connections 0 and 3 (server) are the web server, connection 1 (client) is MQTT

Sub TCP_HandleData
    #if STACK_CONSOLE = 2
        If TCP_Conn = 2 Then
            CONSOLE_TcpHandleData
            Exit Sub
        End If
    #endif
    #if STACK_MQTT = 1
        If TCP_Conn = 1 Then
            MQTT_HandleData
            Exit Sub
        End If
    #endif
    #if STACK_HTTP = 1
        If TCP_Conn = 0 Then HTTP_HandleData
        If TCP_Conn = TCP_SERVER2 Then HTTP_HandleData
    #endif
End Sub

Sub TCP_FillData(In TcpFillOffset As Word, In TcpFillCount As Word)
    #if STACK_CONSOLE = 2
        If TCP_Conn = 2 Then
            CONSOLE_TcpFillData TcpFillOffset, TcpFillCount
            Exit Sub
        End If
    #endif
    #if STACK_MQTT = 1
        If TCP_Conn = 1 Then
            MQTT_FillData TcpFillOffset, TcpFillCount
            Exit Sub
        End If
    #endif
    #if STACK_HTTP = 1
        If TCP_Conn = 0 Then HTTP_FillData TcpFillOffset, TcpFillCount
        If TCP_Conn = TCP_SERVER2 Then HTTP_FillData TcpFillOffset, TcpFillCount
    #endif
End Sub
#endif
