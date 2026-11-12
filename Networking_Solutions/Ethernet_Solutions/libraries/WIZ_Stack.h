//--------------------------------------------------------------------------------------------------------------------------------
// WIZnet stack - the one file a program includes for a W5200 / W5500 board (in place of ENC28J60_Stack.h)
//
// The W5200 / W5500 does ARP, IPv4, ICMP (ping) and TCP in the chip. This file gives the ENC28J60 stack's application
// libraries (ENC28J60_HTTP.h, ENC28J60_MQTT.h, ENC28J60_Console.h) the TCP calls they use, unchanged, on the chip's
// sockets (the "TCP shim"), and the program the same start-up and service calls as ENC28J60_Stack.h.
//
// Phase 1: TCP only (web server, MQTT client, TCP terminal), fixed address. UDP (SNTP, syslog, DNS, DHCP) is phase 2.
//
// Sockets (the chip's; each 2 KB TX and RX):
//   0 and 3   web server, both listening on TCP_LISTEN_PORT, served one at a time (TCP connection 0 to the libraries):
//             while one sends a page the other already waits for the next browser, so no connection is refused
//   1         client (TCP connection 1): MQTT
//   2         TCP terminal on TCP_TERMINAL_PORT with STACK_CONSOLE 2 (TCP connection 2)
// Servers are opened when the link comes up, closed when it goes down, and listen again as soon as a connection has
// closed. A watchdog closes any socket that makes no progress, so none can hang and block new connections.
//
// The TCP shim (names and meaning as ENC28J60_TCP.h):
//   TCP_SendStream(length, close)   a reply of length bytes; TCP_FillData builds it in pieces of up to TCP_MSS bytes at
//                                   EthFrame(TCP_DATA), each piece copied to the socket and sent (the chip retransmits)
//   TCP_Connect, TCP_ClientState, TCP_ClientBusy, TCP_ClientSend, TCP_ClientClose     the client (socket 1)
//   TCP_ConnState, TCP_ConnBusy, TCP_ConnSend                                           any connection (terminal: 2)
//   Received data: TCP_HandleData with TCP_Conn, TCP_RxData (= TCP_DATA), TCP_RxLength, and the peer's address in
//   EthFrame(IP_SRC ...). The web server gets the first part of each request only (the rest is dropped)
//   "Busy" ends when the chip has taken the whole stream (not when the peer has acknowledged it)
//
// Switches: as ENC28J60_Stack.h, defined by the program. Phase 1 accepts STACK_TCP, STACK_HTTP, STACK_MQTT,
// STACK_CONSOLE (0, 1, 2), STACK_STATS and STACK_ICMP (ping is always answered by the chip); STACK_PING, STACK_UDP,
// STACK_UDP_ECHO, STACK_SYSLOG, STACK_SNTP, STACK_DHCP, STACK_DNS and STACK_SERIAL_UDP must be 0.
//
// The program calls WIZ_Init (board file driver), Stack_Init, Stack_StartAddress, Stack_Tick once a second and
// ENC_Service as often as it can. ENC_LinkIsUp, ENC_LinkUp and ShowENCStatus are here under their ENC28J60 names.
//
// Needs WIZ_Driver.h (included by the board file), ENC28J60_Console.h, ENC28J60_HTTP.h, ENC28J60_MQTT.h.
//
//@author    Evan R. Venn
//@licence   GPL
//@date      04/11/2026
//
// Changes:
//   03/11/2026  First version (phase 1: TCP)
//   03/11/2026  No socket may hang: sockets served whatever the link reads; link change only after 3 readings in a row;
//                    watchdog (no progress for TCP_IDLE_S s: DISCON, 5 s later CLOSE); SEND not confirmed in 1 s ends
//                    the stream
//   03/11/2026  Phase 2 begins: UDP shim on socket 4 (ENC_Transmit, IP_BuildHeader..., datagrams to UDP_HandleDatagram)
//                    and DHCP (ENC28J60_DHCP.h unchanged), fixed address as the fall-back
//   03/11/2026  SNTP, DNS and syslog (ENC28J60_SNTP.h, _DNS.h, _Syslog.h unchanged): ARP_Resolve and UDP_Send here
//   03/11/2026  UDP echo on port 7 (socket 5) and the ping client ICMP_Ping (IPRAW socket 6, open only while pinging)
//   03/11/2026  DHCP only with a link; when the link comes up without a lease, Stack_Tick asks DHCP again
//   03/11/2026  Serial to UDP (ENC28J60_SerialUdp.h unchanged) on socket 7, open all the time on SERUDP_PORT;
//                    UDP_SegLength of a received datagram counts only the bytes kept (was the full length when cut)
//   04/11/2026  Stack_LinkTenths: how long Stack_StartAddress waited for the link (for the syslog start-up message)
//   04/11/2026  #option explicit
//   04/11/2026  USART_BAUD_RATE checked here, only with the serial console (1) or serial to UDP (was in the board file)
//   04/11/2026  Info line: W 0 when WIZ_CHIP is left out (the chip is found at start-up)
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

// ----- Switches: each 0 or 1 (console 0, 1 or 2); phase 1 has no UDP

    #script
        if STACK_TCP <> 1 then
            if STACK_HTTP = 1 then
                Error HTTP needs TCP - set the TCP switch to 1
            end if
            if STACK_MQTT = 1 then
                Error MQTT needs TCP - set the TCP switch to 1
            end if
            if STACK_CONSOLE = 2 then
                Error The TCP terminal needs TCP - set the TCP switch to 1
            end if
        end if
        if STACK_UDP = 0 then
            if STACK_UDP_ECHO = 1 then
                Error UDP echo needs UDP - set the UDP switch to 1
            end if
        end if
        if STACK_UDP = 0 then
            if STACK_DHCP = 1 then
                Error DHCP needs UDP - set the UDP switch to 1
            end if
            if STACK_SNTP = 1 then
                Error SNTP needs UDP - set the UDP switch to 1
            end if
            if STACK_DNS = 1 then
                Error DNS needs UDP - set the UDP switch to 1
            end if
            if STACK_SYSLOG = 1 then
                Error Syslog needs UDP - set the UDP switch to 1
            end if
        end if
        if STACK_SERIAL_UDP = 1 then
            if STACK_UDP = 0 then
                Error Serial to UDP needs UDP - set the UDP switch to 1
            end if
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
        // WIZ_CHIP 0: the chip is found at start-up (WIZ_Driver.h)
        if nodef(WIZ_CHIP) then
            WIZ_CHIP = 0
        end if
        Info WIZnet stack W WIZ_CHIP PING STACK_PING UDP STACK_UDP ECHO STACK_UDP_ECHO SERIALUDP STACK_SERIAL_UDP DHCP STACK_DHCP SNTP STACK_SNTP DNS STACK_DNS SYSLOG STACK_SYSLOG TCP STACK_TCP HTTP STACK_HTTP MQTT STACK_MQTT STATS STACK_STATS CONSOLE STACK_CONSOLE
    #endscript

// ----- TCP names the libraries use (as ENC28J60_TCP.h)

    #ifndef TCP_LISTEN_PORT
        #define TCP_LISTEN_PORT 80
    #endif
    #if STACK_CONSOLE = 2
        #define TCP_TERMINAL 1
    #endif
    #ifndef TCP_TERMINAL_PORT
        #define TCP_TERMINAL_PORT 23
    #endif
    #ifndef TCP_IDLE_S
        #define TCP_IDLE_S 10
    #endif

    // Data in EthFrame starts where it does in an ENC28J60 frame (Ethernet 14 + IPv4 20 + TCP 20), so the libraries'
    // buffers and checks are the same. The peer's address is put where the IPv4 header has it
    #define TCP_DATA 54
    #define TCP_MSS 536
    #define IP_SRC 26

    // Connection states the libraries test (ENC28J60_TCP.h values); TCP_LISTEN also means closed for the client
    #define TCP_LISTEN       0
    #define TCP_SYN_RCVD     1
    #define TCP_ESTABLISHED  2
    #define TCP_FIN_WAIT_1   3
    #define TCP_CLOSE_WAIT   7
    #define TCP_SYN_SENT     8

    // First local port of the client
    #define TCP_CLIENT_PORT_FIRST 49152

    // Stack_Tick results
    #define STACK_TICK_NOTHING 0
    #define STACK_TICK_LINK_UP 1
    #define STACK_TICK_LINK_DOWN 2

    // Sockets
    #define WIZ_SOCK_WEB    0
    #define WIZ_SOCK_CLIENT 1
    #define WIZ_SOCK_TERM   2
    #define WIZ_SOCK_WEB2   3
    #define WIZ_SOCKET_UDP  4
    #define WIZ_SOCKET_ECHO 5
    #define WIZ_SOCKET_PING 6
    #define WIZ_SOCKET_SERUDP 7

    // UDP echo (RFC 862) port, and the ping client: IPRAW socket for ICMP (Sn_MR 0x03, Sn_PROTO 0x14 = 1)
    #define STACK_UDP_ECHO_PORT 7
    #define WIZ_MODE_IPRAW 0x03
    #define WIZ_SN_PROTO   0x14
    #define WIZ_SOCK_IPRAW 0x32
    #ifndef ICMP_PING_COUNT
        #define ICMP_PING_COUNT 4
    #endif
    #ifndef ICMP_PING_TIMEOUT_MS
        #define ICMP_PING_TIMEOUT_MS 1000
    #endif
    #ifndef ICMP_PING_DATA_LENGTH
        #define ICMP_PING_DATA_LENGTH 32
    #endif

// ----- IPv4 and UDP names the UDP libraries use (as ENC28J60_IPv4.h / ENC28J60_UDP.h): the stack's frame layout is
//       kept in EthFrame, so the libraries build and read their datagrams as before; the chip adds the real headers

    #define IP_VERHL      14
    #define IP_PROTO      23
    #define IP_DATA       34
    #define IP_HEADER_LENGTH 20
    #define IP_PROTO_ICMP 1
    #define IP_PROTO_TCP  6
    #define IP_PROTO_UDP  17
    #define UDP_SRCPORT   34
    #define UDP_DSTPORT   36
    #define UDP_LENGTH    38
    #define UDP_CHECKSUM  40
    #define UDP_DATA      42
    #define UDP_HEADER_LENGTH 8
    #define ARP_NOT_FOUND 255

// ----- Libraries

    // Millis() for the program's one-second tick (as ENC28J60_Stack.h)
    #include <millis.h>
    #include <ENC28J60_Console.h>
    #if STACK_HTTP = 1
        #include <ENC28J60_HTTP.h>
    #endif
    #if STACK_MQTT = 1
        #include <ENC28J60_MQTT.h>
    #endif
    #if STACK_DHCP = 1
        #include <ENC28J60_DHCP.h>
    #endif
    #if STACK_SNTP = 1
        #include <ENC28J60_SNTP.h>
    #endif
    #if STACK_DNS = 1
        #include <ENC28J60_DNS.h>
    #endif
    #if STACK_SYSLOG = 1
        #include <ENC28J60_Syslog.h>
    #endif
    #if STACK_SERIAL_UDP = 1
        #include <ENC28J60_SerialUdp.h>
    #endif

    // DNS server for a fixed address (and when the DHCP lease gives none), as ENC28J60_Stack.h
    #ifndef DNS_SERVER1
        #define DNS_SERVER1 IP_GATEWAY1
        #define DNS_SERVER2 IP_GATEWAY2
        #define DNS_SERVER3 IP_GATEWAY3
        #define DNS_SERVER4 IP_GATEWAY4
    #endif

// ----- Variables

    // UDP (as ENC28J60_UDP.h / ENC28J60_IPv4.h): the datagram being sent or received, and where a sent one goes
    Dim UDP_SegLength, UDP_RxSrcPort, UDP_RxDstPort As Word
    Dim IP_Length As Word
    Dim IP_RxBroadcast As Byte
    Dim WIZ_UdpPort As Word
    Dim WIZ_UdpDst1, WIZ_UdpDst2, WIZ_UdpDst3, WIZ_UdpDst4 As Byte
    // The one "ARP cache slot" (0): the host ARP_Resolve was last asked for (the chip finds its MAC itself)
    Dim WIZ_SlotIP1, WIZ_SlotIP2, WIZ_SlotIP3, WIZ_SlotIP4 As Byte
    #if STACK_STATS = 1
        Dim Stat_UdpSent As Word
    #endif
    // DHCP_Tick result of the latest Stack_Tick (DHCP_TICK_...), for the program to report
    Dim Stack_DhcpEvent As Byte

    // The connection the libraries are working on, and the data received on it
    Dim TCP_Conn As Byte
    Dim TCP_RxData, TCP_RxLength As Word
    Dim TCP_NextClientPort As Word

    // The address (for the program and the pages, as ENC28J60_ARP.h / ENC28J60_IPv4.h)
    Dim Net_IP1, Net_IP2, Net_IP3, Net_IP4 As Byte
    Dim Net_Mask1, Net_Mask2, Net_Mask3, Net_Mask4 As Byte
    Dim Net_Gateway1, Net_Gateway2, Net_Gateway3, Net_Gateway4 As Byte

    // Link state as Stack_Tick last saw it
    Dim ENC_LinkUp As Byte
    // Tenths of a second Stack_StartAddress waited for the link (300: no link)
    Dim Stack_LinkTenths As Word

    // Per socket 0-3: the stream being sent (length, offset, close), a SEND not yet finished, the web request taken,
    // seconds idle
    Dim WIZ_StreamLength(3) As Word
    Dim WIZ_StreamOffset(3) As Word
    Dim WIZ_StreamClose(3)
    Dim WIZ_Streaming(3)
    Dim WIZ_Sending(3)
    Dim WIZ_Handled(3)
    Dim WIZ_Idle(3)
    // Per socket: the state at the last tick (watchdog) and when the last SEND was given (low 16 bits of Millis)
    Dim WIZ_LastState(3)
    Dim WIZ_SendStart(3) As Word

    // Link debounce: ticks in a row that read the other link state
    Dim WIZ_LinkCount As Byte

    // The socket whose data TCP_HandleData is working on (TCP_SendStream starts its stream there)
    Dim WIZ_CurSock As Byte

// ----- Start-up

Sub Stack_Init
    // RAM is not cleared at reset. The chip has its address from WIZ_Init
    Dim WizInitSock As Byte
    For WizInitSock = 0 To 3
        WIZ_StreamLength(WizInitSock) = 0
        WIZ_StreamOffset(WizInitSock) = 0
        WIZ_StreamClose(WizInitSock) = 0
        WIZ_Streaming(WizInitSock) = 0
        WIZ_Sending(WizInitSock) = 0
        WIZ_Handled(WizInitSock) = 0
        WIZ_Idle(WizInitSock) = 0
        WIZ_LastState(WizInitSock) = 0
        WIZ_SendStart(WizInitSock) = 0
    Next
    WIZ_LinkCount = 0
    TCP_Conn = 0
    TCP_RxData = TCP_DATA
    TCP_RxLength = 0
    TCP_NextClientPort = TCP_CLIENT_PORT_FIRST
    WIZ_CurSock = 0
    ENC_LinkUp = 0
    Net_IP1 = MY_IP1 : Net_IP2 = MY_IP2 : Net_IP3 = MY_IP3 : Net_IP4 = MY_IP4
    Net_Mask1 = IP_NETMASK1 : Net_Mask2 = IP_NETMASK2 : Net_Mask3 = IP_NETMASK3 : Net_Mask4 = IP_NETMASK4
    Net_Gateway1 = IP_GATEWAY1 : Net_Gateway2 = IP_GATEWAY2 : Net_Gateway3 = IP_GATEWAY3 : Net_Gateway4 = IP_GATEWAY4
    #if STACK_HTTP = 1
        HTTP_Init
    #endif
    #if STACK_MQTT = 1
        MQTT_Init
    #endif
    WIZ_UdpPort = 0
    UDP_SegLength = 0
    IP_Length = 0
    IP_RxBroadcast = 0
    #if STACK_STATS = 1
        Stat_UdpSent = 0
    #endif
    #if STACK_DHCP = 1
        DHCP_Init
    #endif
    #if STACK_SNTP = 1
        SNTP_Init
    #endif
    #if STACK_DNS = 1
        DNS_Init
    #endif
    #if STACK_SYSLOG = 1
        Syslog_Init
    #endif
    #if STACK_SERIAL_UDP = 1
        SerUdp_Init
    #endif
    WIZ_SlotIP1 = 0 : WIZ_SlotIP2 = 0 : WIZ_SlotIP3 = 0 : WIZ_SlotIP4 = 0
    Stack_DhcpEvent = 0
End Sub

Function Stack_StartAddress As Byte
    // Waits for the link (up to 30 s), then DHCP when switched in, else (or when no DHCP server answers) the fixed
    // address; then opens the servers. Returns 1 for a DHCP lease
    Stack_StartAddress = 0
    Stack_LinkTenths = 0
    Repeat 300
        If WIZ_LinkIsUp = 1 Then Exit Repeat
        Wait 100 ms
        Stack_LinkTenths++
    End Repeat
    ENC_LinkUp = WIZ_LinkIsUp
    #if STACK_DHCP = 1
        // DHCP only with a link: without one no server can answer. When the link comes up later, Stack_Tick asks then
        If ENC_LinkUp = 1 Then
            If DHCP_Start Then Stack_StartAddress = 1
        End If
    #endif
    If Stack_StartAddress = 0 Then IP_SetStatic
    #if STACK_DNS = 1
        Stack_SetDnsServer
    #endif
    WIZ_OpenServers
End Function

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
    // Once a second: link changes (servers opened on link up, every socket closed on link down; a change counts only
    // after 3 readings in a row, so one bad read does not close everything), the socket watchdog, MQTT.
    // Returns STACK_TICK_LINK_UP or STACK_TICK_LINK_DOWN when the link changed
    Dim StackLink, WizTickSock As Byte
    Stack_Tick = STACK_TICK_NOTHING
    StackLink = WIZ_LinkIsUp
    If StackLink = ENC_LinkUp Then
        WIZ_LinkCount = 0
    Else
        WIZ_LinkCount++
        If WIZ_LinkCount >= 3 Then
            WIZ_LinkCount = 0
            ENC_LinkUp = StackLink
            If StackLink = 1 Then
                #if STACK_DHCP = 1
                    // No lease (the link came up after the start-up wait, or DHCP failed): ask now, else the fixed address
                    If DHCP_Bound = 0 Then
                        If DHCP_Start = 0 Then IP_SetStatic
                        #if STACK_DNS = 1
                            Stack_SetDnsServer
                        #endif
                    End If
                #endif
                WIZ_OpenServers
                Stack_Tick = STACK_TICK_LINK_UP
            Else
                For WizTickSock = 0 To 3
                    WIZ_Command WizTickSock, WIZ_CMD_CLOSE
                    WIZ_ResetSocket WizTickSock
                Next
                Stack_Tick = STACK_TICK_LINK_DOWN
            End If
        End If
    End If

    // No socket may hang
    #if STACK_HTTP = 1
        WIZ_Watchdog WIZ_SOCK_WEB
        WIZ_Watchdog WIZ_SOCK_WEB2
    #endif
    #if STACK_MQTT = 1
        WIZ_Watchdog WIZ_SOCK_CLIENT
    #endif
    #if STACK_CONSOLE = 2
        WIZ_Watchdog WIZ_SOCK_TERM
    #endif

    #if STACK_MQTT = 1
        MQTT_Tick
    #endif

    #if STACK_DHCP = 1
        Stack_DhcpEvent = DHCP_Tick
        // Lease lost: ask again, else the fixed address
        If Stack_DhcpEvent = DHCP_TICK_EXPIRED Then
            If DHCP_Start = 0 Then IP_SetStatic
        End If
        #if STACK_DNS = 1
            // A new or renewed lease can name another DNS server
            If Stack_DhcpEvent <> DHCP_TICK_NOTHING Then Stack_SetDnsServer
        #endif
    #endif
End Function

Sub WIZ_Watchdog(In WizWdSock)
    // Once a second. A socket that is not listening or closed, and has made no progress (no state change, no data in,
    // no piece sent) for TCP_IDLE_S seconds, gets DISCON; 5 s later CLOSE, and ENC_Service reopens a server.
    // An open MQTT or terminal connection may be quiet (it has its own keep-alive): only a web connection counts
    // as idle while established
    Dim WizWdState As Byte
    WizWdState = WIZ_Status(WizWdSock)
    If WizWdState = WIZ_SOCK_CLOSED Or WizWdState = WIZ_SOCK_LISTEN Or WizWdState = WIZ_SOCK_INIT Then
        WIZ_Idle(WizWdSock) = 0
        WIZ_LastState(WizWdSock) = WizWdState
        Exit Sub
    End If
    If WizWdState = WIZ_SOCK_ESTABLISHED Then
        If WIZ_ConnOf(WizWdSock) <> 0 Then
            WIZ_Idle(WizWdSock) = 0
            WIZ_LastState(WizWdSock) = WizWdState
            Exit Sub
        End If
    End If
    If WizWdState <> WIZ_LastState(WizWdSock) Then
        WIZ_Idle(WizWdSock) = 0
        WIZ_LastState(WizWdSock) = WizWdState
        Exit Sub
    End If
    WIZ_Idle(WizWdSock)++
    If WIZ_Idle(WizWdSock) = TCP_IDLE_S Then WIZ_Command WizWdSock, WIZ_CMD_DISCON
    If WIZ_Idle(WizWdSock) >= TCP_IDLE_S + 5 Then
        WIZ_Command WizWdSock, WIZ_CMD_CLOSE
        WIZ_ResetSocket WizWdSock
    End If
End Sub

Sub WIZ_OpenServers
    // The listening sockets: web server (two) and terminal
    #if STACK_HTTP = 1
        WIZ_Listen WIZ_SOCK_WEB, TCP_LISTEN_PORT
        WIZ_Listen WIZ_SOCK_WEB2, TCP_LISTEN_PORT
    #endif
    #if STACK_CONSOLE = 2
        WIZ_Listen WIZ_SOCK_TERM, TCP_TERMINAL_PORT
    #endif
End Sub

Sub WIZ_Listen(In WizLsSock, In WizLsPort As Word)
    WIZ_ResetSocket WizLsSock
    WIZ_Open WizLsSock, WIZ_MODE_TCP, WizLsPort
    WIZ_Command WizLsSock, WIZ_CMD_LISTEN
End Sub

Sub WIZ_ResetSocket(In WizRsSock)
    // Forget the socket's stream and request
    WIZ_Streaming(WizRsSock) = 0
    WIZ_Sending(WizRsSock) = 0
    WIZ_Handled(WizRsSock) = 0
    WIZ_Idle(WizRsSock) = 0
End Sub

// ----- Service: as often as the program can

Sub ENC_Service
    // Every socket is served whatever the link reads: the sockets are in the chip, and a socket left alone can hang
    #if STACK_HTTP = 1
        WIZ_ServiceSocket WIZ_SOCK_WEB
        WIZ_ServiceSocket WIZ_SOCK_WEB2
    #endif
    #if STACK_MQTT = 1
        WIZ_ServiceSocket WIZ_SOCK_CLIENT
    #endif
    #if STACK_CONSOLE = 2
        WIZ_ServiceSocket WIZ_SOCK_TERM
    #endif
    #if STACK_UDP = 1
        If WIZ_UdpPort <> 0 Then WIZ_UdpService WIZ_SOCKET_UDP, WIZ_UdpPort
    #endif
    #if STACK_SERIAL_UDP = 1
        // The bridge's socket stays open on SERUDP_PORT, so no datagram for the serial port is missed
        If WIZ_Status(WIZ_SOCKET_SERUDP) <> WIZ_SOCK_UDP Then WIZ_Open WIZ_SOCKET_SERUDP, WIZ_MODE_UDP, SERUDP_PORT
        WIZ_UdpService WIZ_SOCKET_SERUDP, SERUDP_PORT
    #endif
    #if STACK_UDP_ECHO = 1
        WIZ_EchoService
    #endif
End Sub

Sub WIZ_ServiceSocket(In WizSvSock)
    // One socket: send more of its stream, pass received data on, close what the peer closed, listen again
    Dim WizSvState, WizSvConn, WizSvIndex As Byte
    Dim WizSvSize, WizSvRead As Word

    WizSvState = WIZ_Status(WizSvSock)
    WizSvConn = WIZ_ConnOf(WizSvSock)

    If WizSvState = WIZ_SOCK_CLOSED Then
        WIZ_ResetSocket WizSvSock
        // Servers listen again; the client stays closed until TCP_Connect
        If WizSvSock <> WIZ_SOCK_CLIENT Then
            If WizSvSock = WIZ_SOCK_TERM Then
                WIZ_Listen WizSvSock, TCP_TERMINAL_PORT
            Else
                WIZ_Listen WizSvSock, TCP_LISTEN_PORT
            End If
        End If
        Exit Sub
    End If

    If WizSvState <> WIZ_SOCK_ESTABLISHED Then
        If WizSvState <> WIZ_SOCK_CLOSE_WAIT Then Exit Sub
    End If

    // More of the stream
    WIZ_Pump WizSvSock

    // Received data
    WizSvSize = WIZ_RxSize(WizSvSock)
    If WizSvSize > 0 Then
        WIZ_Idle(WizSvSock) = 0
        If WizSvConn = 0 Then
            // Web server: one request at a time (the HTTP library has one reply state); later data of a request dropped
            If WIZ_Handled(WizSvSock) = 1 Then
                WIZ_RxDiscard WizSvSock, WizSvSize
                WizSvSize = 0
            Else
                If WIZ_Streaming(WIZ_SOCK_WEB) = 1 Then WizSvSize = 0
                If WIZ_Streaming(WIZ_SOCK_WEB2) = 1 Then WizSvSize = 0
            End If
        End If
    End If
    If WizSvSize > 0 Then
        WizSvRead = WizSvSize
        If WizSvRead > ETH_BUFFER_SIZE - TCP_DATA Then WizSvRead = ETH_BUFFER_SIZE - TCP_DATA
        WIZ_RxRead WizSvSock, TCP_DATA, WizSvRead
        If WizSvConn = 0 Then
            If WizSvSize > WizSvRead Then WIZ_RxDiscard WizSvSock, WizSvSize - WizSvRead
            WIZ_Handled(WizSvSock) = 1
        End If
        // The peer's address where the IPv4 header has it
        For WizSvIndex = 0 To 3
            EthFrame(IP_SRC + WizSvIndex) = WIZ_Read(WizSvSock, WIZ_BLK_REG, WIZ_SN_DIPR + WizSvIndex)
        Next
        TCP_Conn = WizSvConn
        TCP_RxData = TCP_DATA
        TCP_RxLength = WizSvRead
        WIZ_CurSock = WizSvSock
        TCP_HandleData
        WIZ_Pump WizSvSock
    End If

    // The peer has closed and everything is sent: close our side
    If WizSvState = WIZ_SOCK_CLOSE_WAIT Then
        If WIZ_Streaming(WizSvSock) = 0 Then
            If WIZ_Sending(WizSvSock) = 0 Then WIZ_Command WizSvSock, WIZ_CMD_DISCON
        End If
    End If
End Sub

Function WIZ_ConnOf(In WizCoSock) As Byte
    // The libraries' TCP connection for a socket: both web sockets are connection 0
    WIZ_ConnOf = WizCoSock
    If WizCoSock = WIZ_SOCK_WEB2 Then WIZ_ConnOf = 0
End Function

Function WIZ_SockOf(In WizSoConn) As Byte
    // The socket for a connection (connection 0: the web socket being served)
    WIZ_SockOf = WizSoConn
    If WizSoConn = 0 Then WIZ_SockOf = WIZ_CurSock
End Function

Sub WIZ_Pump(In WizPmSock)
    // The next piece of the socket's stream: wait for the last SEND to finish, then TCP_FillData builds up to TCP_MSS
    // bytes (as much as the TX buffer takes) at EthFrame(TCP_DATA), copied to the socket and sent. After the last piece
    // of a stream with close: DISCON
    Dim WizPmIr As Byte
    Dim WizPmCount, WizPmFree, WizPmNow As Word

    If WIZ_Sending(WizPmSock) = 1 Then
        WizPmIr = WIZ_Read(WizPmSock, WIZ_BLK_REG, WIZ_SN_IR)
        If (WizPmIr And WIZ_IR_SENDOK) = 0 Then
            // No SEND_OK within 1 s: give the stream up (the watchdog closes the socket)
            WizPmNow = Millis()
            If WizPmNow - WIZ_SendStart(WizPmSock) > 1000 Then
                WIZ_Sending(WizPmSock) = 0
                WIZ_Streaming(WizPmSock) = 0
            End If
            Exit Sub
        End If
        WIZ_Write WizPmSock, WIZ_BLK_REG, WIZ_SN_IR, WIZ_IR_SENDOK
        WIZ_Sending(WizPmSock) = 0
    End If
    If WIZ_Streaming(WizPmSock) = 0 Then Exit Sub

    WizPmCount = WIZ_StreamLength(WizPmSock) - WIZ_StreamOffset(WizPmSock)
    If WizPmCount = 0 Then
        // Everything has been sent
        WIZ_Streaming(WizPmSock) = 0
        If WIZ_StreamClose(WizPmSock) = 1 Then WIZ_Command WizPmSock, WIZ_CMD_DISCON
        Exit Sub
    End If
    If WizPmCount > TCP_MSS Then WizPmCount = TCP_MSS
    WizPmFree = WIZ_TxFree(WizPmSock)
    If WizPmCount > WizPmFree Then WizPmCount = WizPmFree
    If WizPmCount = 0 Then Exit Sub

    TCP_Conn = WIZ_ConnOf(WizPmSock)
    TCP_FillData WIZ_StreamOffset(WizPmSock), WizPmCount
    WIZ_TxWrite WizPmSock, TCP_DATA, WizPmCount
    WIZ_Command WizPmSock, WIZ_CMD_SEND
    WIZ_Sending(WizPmSock) = 1
    WIZ_SendStart(WizPmSock) = Millis()
    WIZ_Idle(WizPmSock) = 0
    WIZ_StreamOffset(WizPmSock) = WIZ_StreamOffset(WizPmSock) + WizPmCount

    // A stream without close is done when the chip has all of it, so the next can start
    If WIZ_StreamOffset(WizPmSock) = WIZ_StreamLength(WizPmSock) Then
        If WIZ_StreamClose(WizPmSock) = 0 Then WIZ_Streaming(WizPmSock) = 0
    End If
End Sub

// ----- The TCP shim

Sub TCP_SendStream(In TcpStreamLength As Word, In TcpStreamClose)
    // A reply of TcpStreamLength bytes on the socket being served (built by TCP_FillData); close = 1 ends the connection
    // after it. Called from TCP_HandleData; ENC_Service sends it
    If WIZ_Streaming(WIZ_CurSock) = 1 Then Exit Sub
    WIZ_StreamLength(WIZ_CurSock) = TcpStreamLength
    WIZ_StreamOffset(WIZ_CurSock) = 0
    WIZ_StreamClose(WIZ_CurSock) = TcpStreamClose
    WIZ_Streaming(WIZ_CurSock) = 1
End Sub

Function TCP_ConnState(In TcpStateConn) As Byte
    TCP_ConnState = WIZ_TcpState(WIZ_SockOf(TcpStateConn))
End Function

Function TCP_ConnBusy(In TcpBusyConn) As Byte
    TCP_ConnBusy = WIZ_Streaming(WIZ_SockOf(TcpBusyConn))
End Function

Sub TCP_ConnSend(In TcpSendConn, In TcpSendLength As Word)
    // Send TcpSendLength bytes on connection TcpSendConn (built by TCP_FillData), without close
    WIZ_CurSock = WIZ_SockOf(TcpSendConn)
    TCP_SendStream TcpSendLength, 0
    WIZ_Pump WIZ_CurSock
End Sub

Function TCP_ClientState As Byte
    // The client's state: TCP_LISTEN (closed), TCP_SYN_SENT, TCP_ESTABLISHED, ...
    TCP_ClientState = WIZ_TcpState(WIZ_SOCK_CLIENT)
End Function

Function TCP_ClientBusy As Byte
    // 1 while the chip has not yet taken the whole stream (the next TCP_ClientSend must wait)
    TCP_ClientBusy = WIZ_Streaming(WIZ_SOCK_CLIENT)
End Function

Sub TCP_ClientSend(In TcpClientLength As Word)
    // Send TcpClientLength bytes on the client (built by TCP_FillData with TCP_Conn = 1), without close
    WIZ_CurSock = WIZ_SOCK_CLIENT
    TCP_SendStream TcpClientLength, 0
    WIZ_Pump WIZ_SOCK_CLIENT
End Sub

Sub TCP_Connect(In TcpCon1, In TcpCon2, In TcpCon3, In TcpCon4, In TcpConPort As Word)
    // Open the client to TcpCon1-4, port TcpConPort, from a new local port. The chip finds the MAC (ARP) itself.
    // TCP_ClientState tells when it is open
    If ENC_LinkUp = 0 Then Exit Sub
    If WIZ_TcpState(WIZ_SOCK_CLIENT) <> TCP_LISTEN Then Exit Sub
    TCP_NextClientPort++
    If TCP_NextClientPort < TCP_CLIENT_PORT_FIRST Then TCP_NextClientPort = TCP_CLIENT_PORT_FIRST
    WIZ_ResetSocket WIZ_SOCK_CLIENT
    WIZ_Open WIZ_SOCK_CLIENT, WIZ_MODE_TCP, TCP_NextClientPort
    WIZ_Write WIZ_SOCK_CLIENT, WIZ_BLK_REG, WIZ_SN_DIPR, TcpCon1
    WIZ_Write WIZ_SOCK_CLIENT, WIZ_BLK_REG, WIZ_SN_DIPR + 1, TcpCon2
    WIZ_Write WIZ_SOCK_CLIENT, WIZ_BLK_REG, WIZ_SN_DIPR + 2, TcpCon3
    WIZ_Write WIZ_SOCK_CLIENT, WIZ_BLK_REG, WIZ_SN_DIPR + 3, TcpCon4
    WIZ_Write16 WIZ_SOCK_CLIENT, WIZ_BLK_REG, WIZ_SN_DPORT, TcpConPort
    WIZ_Command WIZ_SOCK_CLIENT, WIZ_CMD_CONNECT
End Sub

Sub TCP_ClientClose
    // End the client (the application gave up on it): FIN, then closed at once so TCP_ClientState reads TCP_LISTEN
    Dim WizCcWait As Byte
    If WIZ_Status(WIZ_SOCK_CLIENT) = WIZ_SOCK_ESTABLISHED Then
        WIZ_Command WIZ_SOCK_CLIENT, WIZ_CMD_DISCON
        For WizCcWait = 1 To 50
            If WIZ_Status(WIZ_SOCK_CLIENT) = WIZ_SOCK_CLOSED Then Exit For
            Wait 2 ms
        Next
    End If
    WIZ_Command WIZ_SOCK_CLIENT, WIZ_CMD_CLOSE
    WIZ_ResetSocket WIZ_SOCK_CLIENT
End Sub

Function WIZ_TcpState(In WizTsSock) As Byte
    // The chip's socket state as an ENC28J60_TCP.h state
    Dim WizTsRaw As Byte
    WizTsRaw = WIZ_Status(WizTsSock)
    WIZ_TcpState = TCP_FIN_WAIT_1
    If WizTsRaw = WIZ_SOCK_CLOSED Then WIZ_TcpState = TCP_LISTEN
    If WizTsRaw = WIZ_SOCK_INIT Then WIZ_TcpState = TCP_LISTEN
    If WizTsRaw = WIZ_SOCK_LISTEN Then WIZ_TcpState = TCP_LISTEN
    If WizTsRaw = 0x15 Then WIZ_TcpState = TCP_SYN_SENT
    If WizTsRaw = 0x16 Then WIZ_TcpState = TCP_SYN_RCVD
    If WizTsRaw = WIZ_SOCK_ESTABLISHED Then WIZ_TcpState = TCP_ESTABLISHED
    If WizTsRaw = WIZ_SOCK_CLOSE_WAIT Then WIZ_TcpState = TCP_CLOSE_WAIT
End Function

// ----- TCP to the applications: connection 0 web server, 1 MQTT, 2 terminal (as ENC28J60_Stack.h)

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
    #endif
End Sub

// ----- Addresses (as ENC28J60_ARP.h / ENC28J60_IPv4.h): kept in Net_ and written to the chip

Sub NET_SetIP(In SetIP1, In SetIP2, In SetIP3, In SetIP4)
    Net_IP1 = SetIP1 : Net_IP2 = SetIP2 : Net_IP3 = SetIP3 : Net_IP4 = SetIP4
    WIZ_SetIP SetIP1, SetIP2, SetIP3, SetIP4
End Sub

Function NET_IsConfigured As Byte
    NET_IsConfigured = 1
    If Net_IP1 = 0 And Net_IP2 = 0 And Net_IP3 = 0 And Net_IP4 = 0 Then NET_IsConfigured = 0
End Function

Sub IP_SetMaskGateway(In SetMask1, In SetMask2, In SetMask3, In SetMask4, In SetGw1, In SetGw2, In SetGw3, In SetGw4)
    Net_Mask1 = SetMask1 : Net_Mask2 = SetMask2 : Net_Mask3 = SetMask3 : Net_Mask4 = SetMask4
    Net_Gateway1 = SetGw1 : Net_Gateway2 = SetGw2 : Net_Gateway3 = SetGw3 : Net_Gateway4 = SetGw4
    WIZ_SetMask SetMask1, SetMask2, SetMask3, SetMask4
    WIZ_SetGateway SetGw1, SetGw2, SetGw3, SetGw4
End Sub

Sub IP_SetStatic
    // The fixed address MY_IP, IP_NETMASK, IP_GATEWAY
    NET_SetIP MY_IP1, MY_IP2, MY_IP3, MY_IP4
    IP_SetMaskGateway IP_NETMASK1, IP_NETMASK2, IP_NETMASK3, IP_NETMASK4, IP_GATEWAY1, IP_GATEWAY2, IP_GATEWAY3, IP_GATEWAY4
End Sub

Function FrameIsMyMAC(In Offset) As Byte
    FrameIsMyMAC = 0
    If EthFrame(Offset) = MY_MAC1 And EthFrame(Offset + 1) = MY_MAC2 And EthFrame(Offset + 2) = MY_MAC3 Then
        If EthFrame(Offset + 3) = MY_MAC4 And EthFrame(Offset + 4) = MY_MAC5 And EthFrame(Offset + 5) = MY_MAC6 Then FrameIsMyMAC = 1
    End If
End Function

Sub ARP_SendGratuitous
    // The chip announces nothing on request; kept so programs that call it build unchanged
End Sub

// ----- The UDP shim: one UDP socket (WIZ_SOCKET_UDP), opened on the local port of the datagram being sent

Function IP_ResolveNextHop(In NextHop1, In NextHop2, In NextHop3, In NextHop4) As Byte
    // The chip resolves MAC addresses itself: always "found" (slot 0)
    IP_ResolveNextHop = 0
End Function

Sub IP_BuildHeaderTo(In IpToSlot, In IpTo1, In IpTo2, In IpTo3, In IpTo4, In IpToProto, In IpToLength As Word)
    // Record where the datagram goes (the chip builds the IPv4 header)
    WIZ_UdpDst1 = IpTo1 : WIZ_UdpDst2 = IpTo2 : WIZ_UdpDst3 = IpTo3 : WIZ_UdpDst4 = IpTo4
    EthFrame(IP_PROTO) = IpToProto
    IP_Length = IP_HEADER_LENGTH + IpToLength
End Sub

Sub IP_BuildHeaderBroadcast(In IpBcProto, In IpBcLength As Word)
    // Record a broadcast to 255.255.255.255 (the chip builds the IPv4 header)
    WIZ_UdpDst1 = 255 : WIZ_UdpDst2 = 255 : WIZ_UdpDst3 = 255 : WIZ_UdpDst4 = 255
    EthFrame(IP_PROTO) = IpBcProto
    IP_Length = IP_HEADER_LENGTH + IpBcLength
End Sub

Sub UDP_SetChecksum
    // The chip adds the UDP checksum
End Sub

Function ENC_Transmit(In WizUtLength As Word) As Byte
    // Send the UDP datagram the library built in EthFrame: ports from the UDP header fields, data from UDP_DATA,
    // UDP_SegLength - 8 bytes, to the address IP_BuildHeader... recorded. Returns 1 when the chip reports it sent
    // (0: not UDP, or no SEND_OK within 1 s, e.g. no ARP answer for a unicast)
    Dim WizUtSrc, WizUtDst, WizUtCount As Word
    Dim WizUtWait, WizUtIr, WizUtSock As Byte
    ENC_Transmit = 0
    If EthFrame(IP_PROTO) <> IP_PROTO_UDP Then Exit Function
    WizUtSrc_H = EthFrame(UDP_SRCPORT) : [byte]WizUtSrc = EthFrame(UDP_SRCPORT + 1)
    WizUtDst_H = EthFrame(UDP_DSTPORT) : [byte]WizUtDst = EthFrame(UDP_DSTPORT + 1)
    WizUtCount = UDP_SegLength - UDP_HEADER_LENGTH

    // The socket: the serial bridge's own (always open on SERUDP_PORT), else the shared UDP socket on this local port
    // (opened again when the port changes or it is not open). Two tests, not one with Or: a function call in an Or
    // condition miscompiles (see CLAUDE.md pitfalls)
    WizUtSock = WIZ_SOCKET_UDP
    #if STACK_SERIAL_UDP = 1
        If WizUtSrc = SERUDP_PORT Then WizUtSock = WIZ_SOCKET_SERUDP
    #endif
    If WizUtSock = WIZ_SOCKET_UDP Then
        WizUtWait = 0
        If WizUtSrc <> WIZ_UdpPort Then WizUtWait = 1
        If WIZ_Status(WIZ_SOCKET_UDP) <> WIZ_SOCK_UDP Then WizUtWait = 1
        If WizUtWait = 1 Then
            WIZ_Open WIZ_SOCKET_UDP, WIZ_MODE_UDP, WizUtSrc
            WIZ_UdpPort = WizUtSrc
        End If
    End If
    WIZ_Write WizUtSock, WIZ_BLK_REG, WIZ_SN_DIPR, WIZ_UdpDst1
    WIZ_Write WizUtSock, WIZ_BLK_REG, WIZ_SN_DIPR + 1, WIZ_UdpDst2
    WIZ_Write WizUtSock, WIZ_BLK_REG, WIZ_SN_DIPR + 2, WIZ_UdpDst3
    WIZ_Write WizUtSock, WIZ_BLK_REG, WIZ_SN_DIPR + 3, WIZ_UdpDst4
    WIZ_Write16 WizUtSock, WIZ_BLK_REG, WIZ_SN_DPORT, WizUtDst
    WIZ_TxWrite WizUtSock, UDP_DATA, WizUtCount
    WIZ_Command WizUtSock, WIZ_CMD_SEND

    // SEND_OK, or TIMEOUT (the chip could not resolve the address), at most 1 s
    For WizUtWait = 1 To 100
        WizUtIr = WIZ_Read(WizUtSock, WIZ_BLK_REG, WIZ_SN_IR)
        If (WizUtIr And (WIZ_IR_SENDOK Or WIZ_IR_TIMEOUT)) <> 0 Then Exit For
        Wait 10 ms
    Next
    WIZ_Write WizUtSock, WIZ_BLK_REG, WIZ_SN_IR, WIZ_IR_SENDOK Or WIZ_IR_TIMEOUT
    // (the libraries count Stat_UdpSent themselves)
    If (WizUtIr And WIZ_IR_SENDOK) <> 0 Then ENC_Transmit = 1
End Function

Function ARP_Resolve(In WizArIP1, In WizArIP2, In WizArIP3, In WizArIP4) As Byte
    // The chip finds the MAC when it sends: keep the address as slot 0 for UDP_Send
    WIZ_SlotIP1 = WizArIP1 : WIZ_SlotIP2 = WizArIP2 : WIZ_SlotIP3 = WizArIP3 : WIZ_SlotIP4 = WizArIP4
    ARP_Resolve = 0
End Function

Function UDP_Send(In WizSdSlot, In WizSdSrcPort As Word, In WizSdDstPort As Word, In WizSdLength As Word) As Byte
    // As ENC28J60_UDP.h: WizSdLength bytes, already in EthFrame from UDP_DATA, to the host of ARP_Resolve
    UDP_SegLength = UDP_HEADER_LENGTH + WizSdLength
    IP_BuildHeaderTo WizSdSlot, WIZ_SlotIP1, WIZ_SlotIP2, WIZ_SlotIP3, WIZ_SlotIP4, IP_PROTO_UDP, UDP_SegLength
    EthFrame(UDP_SRCPORT) = WizSdSrcPort_H
    EthFrame(UDP_SRCPORT + 1) = [byte]WizSdSrcPort
    EthFrame(UDP_DSTPORT) = WizSdDstPort_H
    EthFrame(UDP_DSTPORT + 1) = [byte]WizSdDstPort
    EthFrame(UDP_LENGTH) = UDP_SegLength_H
    EthFrame(UDP_LENGTH + 1) = [byte]UDP_SegLength
    UDP_Send = ENC_Transmit(IP_Length + IP_VERHL)
    If UDP_Send Then
        #if STACK_STATS = 1
            Stat_UdpSent++
        #endif
    End If
End Function

Sub WIZ_UdpService(In WizUsSock, In WizUsPort As Word)
    // A datagram on UDP socket WizUsSock (local port WizUsPort): the chip gives an 8-byte header (peer address, peer
    // port, data length) before the data. Laid out as the libraries expect: peer address at IP_SRC, ports at
    // UDP_SRCPORT / UDP_DSTPORT, data from UDP_DATA (cut at the end of EthFrame), then UDP_HandleDatagram
    Dim WizUsSize, WizUsLength, WizUsRead As Word
    If WIZ_Status(WizUsSock) <> WIZ_SOCK_UDP Then Exit Sub
    WizUsSize = WIZ_RxSize(WizUsSock)
    If WizUsSize < 8 Then Exit Sub
    WIZ_RxRead WizUsSock, IP_SRC, 4
    WIZ_RxRead WizUsSock, UDP_SRCPORT, 2
    WIZ_RxRead WizUsSock, UDP_LENGTH, 2
    WizUsLength_H = EthFrame(UDP_LENGTH) : [byte]WizUsLength = EthFrame(UDP_LENGTH + 1)
    WizUsRead = WizUsLength
    If WizUsRead > ETH_BUFFER_SIZE - UDP_DATA Then WizUsRead = ETH_BUFFER_SIZE - UDP_DATA
    If WizUsRead > 0 Then WIZ_RxRead WizUsSock, UDP_DATA, WizUsRead
    If WizUsLength > WizUsRead Then WIZ_RxDiscard WizUsSock, WizUsLength - WizUsRead

    EthFrame(IP_PROTO) = IP_PROTO_UDP
    EthFrame(UDP_DSTPORT) = WizUsPort_H : EthFrame(UDP_DSTPORT + 1) = [byte]WizUsPort
    UDP_RxSrcPort_H = EthFrame(UDP_SRCPORT) : [byte]UDP_RxSrcPort = EthFrame(UDP_SRCPORT + 1)
    UDP_RxDstPort = WizUsPort
    // Only the bytes kept: a library reads UDP_SegLength - 8 bytes from UDP_DATA
    UDP_SegLength = WizUsRead + UDP_HEADER_LENGTH
    IP_RxBroadcast = 0
    UDP_HandleDatagram
End Sub

Sub UDP_HandleDatagram
    // A datagram for us (as ENC28J60_Stack.h): to the module that owns the port
    #if STACK_DHCP = 1
        If UDP_RxDstPort = DHCP_CLIENT_PORT Then
            If UDP_RxSrcPort = DHCP_SERVER_PORT Then DHCP_ProcessReply
            Exit Sub
        End If
    #endif
    #if STACK_DNS = 1
        If UDP_RxDstPort = DNS_LOCAL_PORT Then
            If UDP_RxSrcPort = DNS_SERVER_PORT Then DNS_ProcessReply
            Exit Sub
        End If
    #endif
    #if STACK_SNTP = 1
        If UDP_RxDstPort = SNTP_LOCAL_PORT Then
            If UDP_RxSrcPort = SNTP_SERVER_PORT Then SNTP_ProcessReply
            Exit Sub
        End If
    #endif
    #if STACK_SERIAL_UDP = 1
        If UDP_RxDstPort = SERUDP_PORT Then SerUdp_ProcessDatagram
    #endif
End Sub

// ----- UDP echo on port 7: its own socket, open all the time

#if STACK_UDP_ECHO = 1
Sub WIZ_EchoService
    // Each datagram to port 7 goes back to its sender (data cut at the end of EthFrame)
    Dim WizEcSize, WizEcLength, WizEcRead, WizEcPort As Word
    Dim WizEcWait, WizEcIr As Byte
    If WIZ_Status(WIZ_SOCKET_ECHO) <> WIZ_SOCK_UDP Then
        WIZ_Open WIZ_SOCKET_ECHO, WIZ_MODE_UDP, STACK_UDP_ECHO_PORT
        Exit Sub
    End If
    WizEcSize = WIZ_RxSize(WIZ_SOCKET_ECHO)
    If WizEcSize < 8 Then Exit Sub
    WIZ_RxRead WIZ_SOCKET_ECHO, IP_SRC, 4
    WIZ_RxRead WIZ_SOCKET_ECHO, UDP_SRCPORT, 2
    WIZ_RxRead WIZ_SOCKET_ECHO, UDP_LENGTH, 2
    WizEcLength_H = EthFrame(UDP_LENGTH) : [byte]WizEcLength = EthFrame(UDP_LENGTH + 1)
    WizEcPort_H = EthFrame(UDP_SRCPORT) : [byte]WizEcPort = EthFrame(UDP_SRCPORT + 1)
    WizEcRead = WizEcLength
    If WizEcRead > ETH_BUFFER_SIZE - UDP_DATA Then WizEcRead = ETH_BUFFER_SIZE - UDP_DATA
    If WizEcRead > 0 Then WIZ_RxRead WIZ_SOCKET_ECHO, UDP_DATA, WizEcRead
    If WizEcLength > WizEcRead Then WIZ_RxDiscard WIZ_SOCKET_ECHO, WizEcLength - WizEcRead

    // Back to the sender
    WIZ_Write WIZ_SOCKET_ECHO, WIZ_BLK_REG, WIZ_SN_DIPR, EthFrame(IP_SRC)
    WIZ_Write WIZ_SOCKET_ECHO, WIZ_BLK_REG, WIZ_SN_DIPR + 1, EthFrame(IP_SRC + 1)
    WIZ_Write WIZ_SOCKET_ECHO, WIZ_BLK_REG, WIZ_SN_DIPR + 2, EthFrame(IP_SRC + 2)
    WIZ_Write WIZ_SOCKET_ECHO, WIZ_BLK_REG, WIZ_SN_DIPR + 3, EthFrame(IP_SRC + 3)
    WIZ_Write16 WIZ_SOCKET_ECHO, WIZ_BLK_REG, WIZ_SN_DPORT, WizEcPort
    If WizEcRead = 0 Then Exit Sub
    WIZ_TxWrite WIZ_SOCKET_ECHO, UDP_DATA, WizEcRead
    WIZ_Command WIZ_SOCKET_ECHO, WIZ_CMD_SEND
    For WizEcWait = 1 To 100
        WizEcIr = WIZ_Read(WIZ_SOCKET_ECHO, WIZ_BLK_REG, WIZ_SN_IR)
        If (WizEcIr And (WIZ_IR_SENDOK Or WIZ_IR_TIMEOUT)) <> 0 Then Exit For
        Wait 10 ms
    Next
    WIZ_Write WIZ_SOCKET_ECHO, WIZ_BLK_REG, WIZ_SN_IR, WIZ_IR_SENDOK Or WIZ_IR_TIMEOUT
    #if STACK_STATS = 1
        If (WizEcIr And WIZ_IR_SENDOK) <> 0 Then Stat_UdpSent++
    #endif
End Sub
#endif

// ----- Ping client: an IPRAW socket for ICMP, open only while pinging (the chip answers pings to us itself)

#if STACK_PING = 1
#if STACK_CONSOLE <> 0
Sub ICMP_Ping(In PIP1, In PIP2, In PIP3, In PIP4)
    // Sends ICMP_PING_COUNT echo requests and reports each reply or time-out, as ENC28J60_ICMP.h (and a PC's ping)
    Dim PingNo, PingIndex, PingReplied, PingIr As Byte
    Dim PingSeq, PingSize, PingLength As Word
    Dim PingStart, PingTime As Long

    CONSOLE_Print "Ping " : CONSOLE_Number PIP1 : CONSOLE_Print "." : CONSOLE_Number PIP2 : CONSOLE_Print "." : CONSOLE_Number PIP3 : CONSOLE_Print "." : CONSOLE_Number PIP4
    CONSOLE_Print " with " : CONSOLE_Number ICMP_PING_DATA_LENGTH : CONSOLE_Print " bytes of data:" : CONSOLE_CRLF

    WIZ_Command WIZ_SOCKET_PING, WIZ_CMD_CLOSE
    WIZ_Write WIZ_SOCKET_PING, WIZ_BLK_REG, WIZ_SN_IR, 0xFF
    WIZ_Write WIZ_SOCKET_PING, WIZ_BLK_REG, WIZ_SN_MR, WIZ_MODE_IPRAW
    WIZ_Write WIZ_SOCKET_PING, WIZ_BLK_REG, WIZ_SN_PROTO, 1
    WIZ_Command WIZ_SOCKET_PING, WIZ_CMD_OPEN
    WIZ_Write WIZ_SOCKET_PING, WIZ_BLK_REG, WIZ_SN_DIPR, PIP1
    WIZ_Write WIZ_SOCKET_PING, WIZ_BLK_REG, WIZ_SN_DIPR + 1, PIP2
    WIZ_Write WIZ_SOCKET_PING, WIZ_BLK_REG, WIZ_SN_DIPR + 2, PIP3
    WIZ_Write WIZ_SOCKET_PING, WIZ_BLK_REG, WIZ_SN_DIPR + 3, PIP4
    PingSeq = Millis()

    For PingNo = 1 To ICMP_PING_COUNT
        // Echo request: type 8, code 0, checksum, identifier 0x4743 ("GC"), sequence, data abcd...w repeated
        PingSeq++
        PingLength = 8 + ICMP_PING_DATA_LENGTH
        EthFrame(IP_DATA) = 8 : EthFrame(IP_DATA + 1) = 0
        EthFrame(IP_DATA + 2) = 0 : EthFrame(IP_DATA + 3) = 0
        EthFrame(IP_DATA + 4) = 0x47 : EthFrame(IP_DATA + 5) = 0x43
        EthFrame(IP_DATA + 6) = PingSeq_H : EthFrame(IP_DATA + 7) = [byte]PingSeq
        For PingIndex = 0 To ICMP_PING_DATA_LENGTH - 1
            EthFrame(IP_DATA + 8 + PingIndex) = 97 + (PingIndex Mod 23)
        Next
        WIZ_IcmpChecksum PingLength

        PingReplied = 0
        PingStart = Millis()
        WIZ_TxWrite WIZ_SOCKET_PING, IP_DATA, PingLength
        WIZ_Command WIZ_SOCKET_PING, WIZ_CMD_SEND
        Do
            // TIMEOUT: the chip found no MAC for the address (no ARP answer)
            PingIr = WIZ_Read(WIZ_SOCKET_PING, WIZ_BLK_REG, WIZ_SN_IR)
            If (PingIr And WIZ_IR_TIMEOUT) <> 0 Then Exit Do
            // A datagram: 6-byte header (from address, length), then the ICMP message
            PingSize = WIZ_RxSize(WIZ_SOCKET_PING)
            If PingSize >= 6 Then
                WIZ_RxRead WIZ_SOCKET_PING, IP_SRC, 4
                WIZ_RxRead WIZ_SOCKET_PING, IP_DATA, 2
                PingSize_H = EthFrame(IP_DATA) : [byte]PingSize = EthFrame(IP_DATA + 1)
                If PingSize > ETH_BUFFER_SIZE - IP_DATA Then
                    WIZ_RxDiscard WIZ_SOCKET_PING, PingSize
                Else
                    WIZ_RxRead WIZ_SOCKET_PING, IP_DATA, PingSize
                    // Echo reply to our identifier and sequence
                    If EthFrame(IP_DATA) = 0 And EthFrame(IP_DATA + 4) = 0x47 And EthFrame(IP_DATA + 5) = 0x43 Then
                        If EthFrame(IP_DATA + 6) = PingSeq_H And EthFrame(IP_DATA + 7) = [byte]PingSeq Then PingReplied = 1
                    End If
                End If
            End If
            PingTime = Millis() - PingStart
        Loop Until PingReplied = 1 Or PingTime >= ICMP_PING_TIMEOUT_MS
        WIZ_Write WIZ_SOCKET_PING, WIZ_BLK_REG, WIZ_SN_IR, 0xFF

        If PingReplied = 1 Then
            CONSOLE_Print "Reply from " : CONSOLE_Number PIP1 : CONSOLE_Print "." : CONSOLE_Number PIP2 : CONSOLE_Print "." : CONSOLE_Number PIP3 : CONSOLE_Print "." : CONSOLE_Number PIP4
            CONSOLE_Print ": seq=" : CONSOLE_Number PingNo : CONSOLE_Print " time=" : CONSOLE_Number PingTime : CONSOLE_Print " ms" : CONSOLE_CRLF
        Else
            If (PingIr And WIZ_IR_TIMEOUT) <> 0 Then
                CONSOLE_Print "Destination host unreachable (no ARP reply)" : CONSOLE_CRLF
            Else
                CONSOLE_Print "Request timed out (seq=" : CONSOLE_Number PingNo : CONSOLE_Print ")" : CONSOLE_CRLF
            End If
            // Wait out the rest of the second, as a PC's ping does
            Do While Millis() - PingStart < ICMP_PING_TIMEOUT_MS
                ENC_Service
            Loop
        End If
    Next
    WIZ_Command WIZ_SOCKET_PING, WIZ_CMD_CLOSE
End Sub

Sub WIZ_IcmpChecksum(In WizCkLength As Word)
    // The Internet checksum of the ICMP message at EthFrame(IP_DATA), WizCkLength bytes, into its checksum field
    Dim WizCkSum As Long
    Dim WizCkIndex, WizCkWord As Word
    WizCkSum = 0
    For WizCkIndex = 0 To WizCkLength - 1 Step 2
        WizCkWord_H = EthFrame(IP_DATA + WizCkIndex)
        [byte]WizCkWord = 0
        If WizCkIndex + 1 < WizCkLength Then [byte]WizCkWord = EthFrame(IP_DATA + WizCkIndex + 1)
        WizCkSum = WizCkSum + WizCkWord
    Next
    Do While WizCkSum > 0xFFFF
        WizCkSum = (WizCkSum And 0xFFFF) + FnLSR(WizCkSum, 16)
    Loop
    WizCkWord = WizCkSum
    WizCkWord = WizCkWord Xor 0xFFFF
    EthFrame(IP_DATA + 2) = WizCkWord_H
    EthFrame(IP_DATA + 3) = [byte]WizCkWord
End Sub
#endif
#endif

// ----- ENC28J60 names the programs use

Function ENC_LinkIsUp As Byte
    ENC_LinkIsUp = WIZ_LinkIsUp
End Function

#if STACK_CONSOLE <> 0
Sub ShowENCStatus
    ShowWIZStatus
End Sub

#if STACK_STATS = 1
Sub Stack_PrintStats
    #if STACK_HTTP = 1
        HTTP_PrintStats
    #endif
    #if STACK_DHCP = 1
        DHCP_PrintStats
    #endif
    #if STACK_SNTP = 1
        SNTP_PrintStats
    #endif
    #if STACK_DNS = 1
        DNS_PrintStats
    #endif
    #if STACK_SYSLOG = 1
        Syslog_PrintStats
    #endif
    ShowWIZStatus
End Sub
#endif
#endif
