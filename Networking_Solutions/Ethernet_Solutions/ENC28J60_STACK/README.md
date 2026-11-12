# Test 020 - Full stack: web site, MQTT and SNTP time

**03/11/2026: this folder is `ENC28J60_STACK` (was `020_FULLSTACK`, now in `..\Development\`).** The programs are named by controller and board: `ENC28J60_16F18877.gcb` (was `_Solution`), `ENC28J60_18F47Q43.gcb` (`_Solution18F`), `ENC28J60_PICWEB.gcb` / `_PICWEB_41` (`_SolutionJ60` / `_J60_41`), `ENC28J60_PDN2_J1.gcb` / `_PDN2_J1_41` (`_Solution97J60` / `_97J60_41`), `ENC28J60_PDN2_J2.gcb` / `_PDN2_J2_41` (`_Solution97ENC` / `_97ENC_41`). The old names below are history. The file name is the firmware name on /s and in syslog (24 characters shown).

As many modules as fit, in three builds:

- `020_FULLSTACK_Solution.gcb` - 16F18877, headless (no console): TCP, the web site (dashboard, /c, /s, /v), MQTT and SNTP (UDP only for SNTP). ICMP, ping client, syslog and statistics are off for room (91% of program memory).
- `020_FULLSTACK_Solution18F.gcb` - 18F47Q43: every module except the serial UDP bridge, serial console, DHCP.
- `020_FULLSTACK_SolutionJ60.gcb` - Olimex PIC-WEB (18F67J60, Ethernet built in): the 18F program for that board, at 25 MHz.
- `020_FULLSTACK_SolutionJ60_41.gcb` - the same at 41.667 MHz (the 25 MHz crystal through the PLL).
- `020_FULLSTACK_Solution97J60.gcb` / `_Solution97J60_41.gcb` - Microchip PICDEM.net 2 (18F97J60) on its built-in Ethernet port (J1), 25 / 41.667 MHz.
- `020_FULLSTACK_Solution97ENC.gcb` / `_Solution97ENC_41.gcb` - the same board on its ENC28J60 port (J2, SPI1), 25 / 41.667 MHz. All four: dashboard `PageHome97J60.htm` (pot AN2, TC1047A AN3 in C, buttons RB3-RB0, LEDs RJ0-RJ7 with /t0-/t7), MQTT led/0-7, the LCD shows the address and the time; enc28j60-6, .124.

The dashboard and /s show the time (UTC) when STACK_SNTP is 1; /s also the time server, its stratum and the firmware name, build time and build number. With syslog on, start-up is logged as "<file name> build <n>, <address>, web 80, MQTT <broker>" (e.g. "020_FULLSTACK_Solution18F build 172, 192.168.0.120, web 80, MQTT 192.168.0.126") and each time update as "Time set hh:mm:ss". HAND-EDITED beyond the template (firmware and time values, 4-table /c, 2-table dashboard): do not regenerate it.

## Files

| File | What it is |
|---|---|
| `020_FULLSTACK_Solution.gcb` | The test program (16F18877): stack switches, addresses, console and the functions the stack calls |
| `020_FULLSTACK_Solution18F.gcb` | The same for the 18F47Q43 (`..\hardware\18F47Q43`), 192.168.0.120 |
| `020_FULLSTACK_SolutionJ60.gcb` | The same for the Olimex PIC-WEB REV.C (`..\hardware\18F67J60`), 25 MHz, DHCP (fixed fall-back 192.168.0.122), console COM26 |
| `020_FULLSTACK_SolutionJ60_41.gcb` | The PIC-WEB at 41.667 MHz (`#Chip 18F67J60, 41.667`, FOSC HSPLL); otherwise the same |
| `webpages\PageHome.htm` | Dashboard `/` (converted to PageHome.GCB when compiled) - 16F and 18F |
| `webpages\PageHome97J60.htm` | The PICDEM.net 2 dashboard `/`: potentiometer (AN2), temperature (AN3 TC1047A, C from the PIC), buttons 0-3 (RB3-RB0), LEDs 0-7 (RJ0-RJ7) with Toggle |
| `webpages\PageHomeJ60.htm` | The PIC-WEB dashboard `/`: potentiometer (AN8), temperature (AN9 thermistor, worked out in the page), button (RB0), status LED (RB4) with Toggle; the same /v values, read as POT, thermistor, requests, PORTB, LED |
| `webpages\PageConfig.htm` | Configuration page `/c` (converted to PageConfig.GCB) |
| `webpages\PageValues.h` | The JSON reply `/v`, as a commented table of character codes |
| `..\hardware\<chip>\HADiscovery.json` | Home Assistant discovery message, published retained after each MQTT login (converted to HADiscovery.GCB there). It names the chip, so each hardware folder has its own |
| `webpages\PageSolution.htm` | Solution page `/s`: firmware name, build time and number, and the time (converted to PageSolution.GCB) |
| `GCBVersionNumber.cnt` | Build counter: the compiler adds one per build and makes GCBVersionNumber.GCB (GCBBuildStr, GCBBuildTimeStr) for the configuration page |
| `README.md` | This description |

Shared code: `..\libraries\ENC28J60_Stack.h` (includes the modules by switch) and `..\hardware\16f18877\hardwareconfig.h` (the test rig).

## Configuration

Set in each program before `#include <ENC28J60_Stack.h>`:

| Switch | 16F | 18F, J60 | Meaning |
|---|---|---|---|
| `STACK_ICMP` | 0 | 1 | answer ping |
| `STACK_PING` | 0 | 1 | ping other hosts (keys i, e) |
| `STACK_UDP` | 1 | 1 | UDP |
| `STACK_UDP_ECHO` | 0 | 1 | UDP echo service on port 7 |
| `STACK_SYSLOG` | 0 | 1 | syslog messages to SYSLOG_IP (key l) |
| `STACK_SNTP` | 1 | 1 | time from a time server (keys t, y) |
| `STACK_DNS` | 0 | 1 | DNS resolver (key n) |
| `STACK_DHCP` | 0 | 1 | 1 = address from DHCP (MY_IP if no server answers), 0 = fixed MY_IP |
| `STACK_TCP` | 1 | 1 | TCP connections (web server, MQTT client, TCP terminal) |
| `STACK_HTTP` | 1 | 1 | web server on port 80 |
| `STACK_MQTT` | 1 | 1 | MQTT client to the Home Assistant broker |
| `STACK_STATS` | 0 | 1 | statistics counters (key p) |
| `STACK_CONSOLE` | 0 | 1 | 0 headless, 1 serial console, 2 TCP terminal (telnet port 23) |
| `STACK_SERIAL_UDP` | 0 | 0 | Serial UDP:50001 Bridge |

| Setting | Value |
|---|---|
| Serial speed (`USART_BAUD_RATE`) | 115200 |
| Device address (`MY_IP1-4`) | 192.168.0.117 (18F .120, J60 .122; the 18F and J60 take DHCP first: the J60 got .123) |
| Mask / gateway (`IP_NETMASK1-4`, `IP_GATEWAY1-4`) | 255.255.255.0 / 192.168.0.250 |
| MAC (`MY_MAC1-6`) | 00:1E:C0:00:00:03 (18F :04, J60 :05) |
| Router (`ROUTER_IP1-4`, key r) | 192.168.0.250 |
| Time server | `SNTP_SERVER_IP1-4` 192.168.0.250 (the router); asked at start-up, then every `SNTP_INTERVAL_S` 900 s (15 minutes), 60 s after a failed request |
| MQTT broker (`MQTT_BROKER1-4`) | 192.168.0.126 (Home Assistant Mosquitto), user `MQTT_USER` "enc28j60"; type the password of that Home Assistant user into `MQTT_PASSWORD` |

Build and program with GCBASIC: `GCBASIC.EXE 020_FULLSTACK_Solution.gcb /NP /S:use.ini /F:N /DO` (or F6 / Make HEX in GC Code). The rig must be externally powered.

## Testing

1. The serial console (COM21, 115200): ? lists the keys; 	 shows the time, y fetches it now. The web site and MQTT run beside it. Web requests are not logged on the console (HTTP_LOG 0, for room).
2. Dashboard (/): the line under the title shows the time (UTC), updated every 2 s from /v ("t" 0 no SNTP in the build, 1 waiting, 2 valid; "Y" year-2000, "M", "D", "h", "m", "s"), with links to Config and Solution.
3. Configuration (/c): network settings and the TCP/IP stack modules, ON or OFF.
4. Solution (/s): the firmware - program file name (SOURCEFILE, one character per value), build date and time and build number (from GCBVersionNumber.cnt, sent as numbers) - and, only when STACK_SNTP is 1, a Time card with the time (UTC), the time server and its stratum.
5. The address is the fixed MY_IP (192.168.0.117): no DHCP or DNS. Time server: SNTP_SERVER_IP, the router 192.168.0.250.

Automated: `powershell -ExecutionPolicy Bypass -File ..\Project_Support\tools\Test-Phase.ps1 -Test 020` programs the rig, captures the start-up, sends the console keys (on COM21) and runs the network checks; COM21 must be free. The console text is saved in `Project_Support\results\020_FULLSTACK.txt`.

## Results (31/10/2026, retest against the 2026 baseline, 32 MHz clock, SPI 8 MHz)

30 passed, 1 failed.

| Check | Result | Detail |
|---|---|---|
| Compile: 0 errors, 0 warnings | PASS | 16F18877 29804/32768 words, RAM 1976/4096; 18F47Q43 36338/65536, RAM 2652/8192; 18F67J60 25 MHz 33815/65536, RAM 2610/3808; 18F67J60 41.667 MHz 33841, RAM 2613; 18F97J60 J1 25 MHz 35805, RAM 2636; J1 41.667 MHz 35838, RAM 2639; J2 25 MHz 36583, RAM 2669; J2 41.667 MHz 36623, RAM 2672 (02/11/2026) |
| Programmed | PASS |  |
| Start-up banner | PASS | Test 020 FULLSTACK |
| Address reported | PASS | IP 192.168.0.117  mask 255.255.255.0  gateway 192.168.0.250  fixed |
| Help (?) | PASS | Keys: r a g c x f d h p i e ? |
| Address (h) | PASS | IP 192.168.0.117  mask 255.255.255.0  gateway 192.168.0.250  fixed |
| Resolve router (r) | PASS | Resolving 192.168.0.250: 3C:A6:2F:91:59:24 |
| Resolve this PC (a) | PASS | IP: 192.168.0.104 Resolving 192.168.0.104: A0:48:1C:94:F5:48 |
| Resolve absent host (a) | PASS | IP: 192.168.0.99 Resolving 192.168.0.99: no reply after 3 requests |
| Reject bad address (a) | PASS | IP: not an IP address |
| Cache (c) | PASS | 0  192.168.0.250  3C:A6:2F:91:59:24  age 0 s / 1  192.168.0.104  A0:48:1C:94:F5:48  age 20 s / 2  192.168.0.126  40:B0:34:33:EB:62  age 1 s |
| Clear cache (x, c) | FAIL | 0  192.168.0.104  A0:48:1C:94:F5:48  age 0 s |
| Receive filter (f, f) | PASS | Filter: all / Filter: normal |
| ENC28J60 status (d) | PASS | ENC28J60 EREVID 6  MAADR 00:1E:C0:00:00:03 / PHSTAT2 0x0400  link up |
| Gratuitous ARP (g) | INFO | sent |
| Statistics (p) | PASS | RX frames 217  other 55  bad 0  overflow 0  recovered 0 / TX frames 64  errors 0  retries 0 / ARP received 89  replies sent 2  requests sent 8  not for us 85  malformed 0  conflicts 0 |
| Answers ping | PASS | 4/4, 3,3,3,3 ms |
| Oversize ping (1000 bytes) dropped | PASS |  |
| Ping router (i) | PASS | Ping 192.168.0.250 with 32 bytes of data: Reply from 192.168.0.250: seq=1 time=4 ms Reply from 192.168.0.250: seq=2 time=4 ms Reply from 192.168.0.250: seq=3 time=4 ms Reply from 192.168.0.250: seq=4 time=3 ms |
| Ping this PC (e) | PASS | IP: 192.168.0.104 Ping 192.168.0.104 with 32 bytes of data: Reply from 192.168.0.104: seq=5 time=4 ms Reply from 192.168.0.104: seq=6 time=4 ms Reply from 192.168.0.104: seq=7 time=5 ms Reply from 192.168.0.104: seq=8 time=4 ms |
| GET / (complete to </html>) | PASS | HTTP/1.0 200 OK, 1999 bytes |
| GET /nothing gives 404 | PASS | HTTP/1.0 404 Not Found |
| 10 pages in a row | PASS | 10/10 |
| Requests logged on the console | PASS |  |
| Port 81 refused | PASS |  |
| Port 22 refused | PASS |  |
| Live values change per request (request number) | PASS | two replies differ |
| GET /t1 gives 302 Found, Location: / | PASS | HTTP/1.0 302 Found |
| /t1 toggles PORTD.1 | PASS | PORTD 2 then 0 |
| GET /c (configuration page, complete to </html>) | PASS | 6402 bytes |
| GET /v is JSON | PASS | {"a":155,"b": 86,"q": 16,"p": 53,"d":  0} |
| MQTT ready (login to the broker) | PASS |  |

﻿## Notes

- 31/10/2026: SNTP added (user). Program memory 32139/32768 words (98%); ping client and statistics switched off to make room. With STACK_SNTP 0 (and UDP 0) it builds at 30076 words and the time rows are not shown.
- Checked on the rig at 32 MHz, SPI 8 MHz: /v gives the time (t 2), the dashboard shows "2026-10-31 10:13:17 UTC", /c shows Time, Time server 192.168.0.250, Stratum 3, Firmware 020_FULLSTACK_Solution, Built, Build.
- The results table below is from the run before SNTP was added (ping client and statistics on).
- The scope probes had to be off the SPI lines for SPI MasterFast at 32 MHz.
- 31/10/2026: the configuration page split in two (user): Configuration /c (network, stack; 4.2 KB, 3 tables) and Solution /s (firmware and time; 3.4 KB, 2 tables). To fit: build time and build number sent as numbers, file name up to 24 characters, no spaces around = on value lines, request log off. 32509/32768 words (99.2%). Checked in Chrome: /s Firmware 020_FULLSTACK_Solution, Built 2026-10-31 13:49:02, Build 25, Time, Time server 192.168.0.250, Stratum 3; /c network and 17 module rows.
- 03/11/2026: PICDEM.net 2 J1 (`_97J60_41`, build 343) checked with the new J60 driver and left running on .124: DHCP .124 at once, syslog start-up line and "Time set" at once, `/c` "Ethernet: built into the PIC", `/s` "SPI: none", ping 10/10 at 1 ms, 28/30 dashboards. The first try (build 339) failed at start-up: the DHCP-on-link change read the link a second time, and on this board each read before a frame has arrived flips the RX polarity (`ENC28J60_RX_SWAP`). `Stack_StartAddress` now keeps the link state from its wait loop.
- 03/11/2026: `/s` shows the SPI setting under the rig: value 59 = `ENC_SPI_SPEED` (SPIMode: MasterSlow 11, Master 12, MasterFast 13), "none" (0) for Ethernet built into the PIC, whose driver has no `ENC_SPI_SPEED`. 16F MasterFast, 18F Master, PICDEM.net 2 J2 MasterFast (the driver's default), PIC-WEB and J1 none. Programmed into .117, .120, .124, .123. Sizes (words): 16F 30477 (93%), 18F 36777, J60 34238 / 34258, 97J60 36226 / 36253, 97ENC 37008 / 37042.
- 03/11/2026: all boards updated and running together for the first time (user): .117 (16F, build 304), .120 (18F, 307), .123 (PIC-WEB 41.667 MHz, 328), .124 (PICDEM.net 2 J2 41.667 MHz, 314); with .121 (022, W5200) and .125 (021).
- 03/11/2026: PIC-WEB received nothing after the RXAPDIS change (`p`: RX frames 0, TX 150; link only after 20-30 s, then DHCP, ARP, SNTP and MQTT all failed). `ENC28J60_J60Driver.h` now sets RXAPDIS (PHCON2 0x0110) only with `ENC28J60_RX_SWAP` (PICDEM.net 2); other boards keep automatic RX polarity (0x0100). The PIC-WEB then linked, pinged and leased .123 within 6 s.
- 03/11/2026: `ENC28J60_Stack.h`: DHCP only with a link at start-up; when the link comes up later without a lease, `Stack_Tick` asks DHCP then (before, a late link left the board on its fixed address).
- 03/11/2026: `/c` names the Ethernet controller from configuration value 38 (`ENC_ETH_BUILTIN`, 0 in `ENC28J60_Driver.h`, 1 in `ENC28J60_J60Driver.h`): "SPI Driver: ENC28J60 SPI" or "Ethernet: built into the PIC"; `/c` and `/s` titles "GCBASIC configuration" / "GCBASIC solution" (they said ENC28J60 on every board).
- 03/11/2026: dashboards: Auto Update (2 s) is a red (off) / green (on) button after Solution, the same size as the links; it starts on when MQTT is in the build (dashboard value 25 = `STACK_MQTT`, `Q()` in the page).
- 03/11/2026 sizes (words): 16F 30269 (92%), 18F 36648, J60 34112 / 34132, 97J60 36099 / 36126, 97ENC 36876 / 36909.
- 02/11/2026: Microchip PICDEM.net 2 (18F97J60), all four programs checked on the board (user programmed; console COM28). J1 and J2, 25 and 41.667 MHz: DHCP lease, router, SNTP, DNS, syslog start-up line, ping 1-4 ms, / 3327 bytes, /c 4182, /s 4255 (421-660 ms at 41.667 MHz), /t0-/t7 each toggling its own LED, MQTT LED switching from Home Assistant, LCD address and time, temperature 24 C steady (room 23 C), 0 bad frames, 0 transmit errors. On the way: (1) the LCD and LEDs were proven first with `Project_Support\board_tests\PICDEMNET2_LCD.gcb`; (2) the J60 driver's PHY write now follows Microchip's errata workaround (PRODL/PRODH, interrupts off) - before it, PHCON2 (no loopback) failed and J1 received only its own frames; PHCON2 also RXAPDIS; (3) RX polarity swap on RG0 run by the driver (`RX swap 1` found on J1); (4) RA0/RA1 outputs, so J1's LEDs work; (5) `Stack_StartAddress` waits up to 30 s for the link (J1 linked after up to ~20 s, so DHCP, ARP and SNTP had failed at start-up); (6) temperature the average of 8 readings 1 ms apart (single readings 19-26 C; back to back 15-16 C); (7) ENC28J60 RESET on RD2 (JP5), JP9 (ENC28J60 INT to RB0 = Button 3) open, JP14 needed for console input. A network outage at the same time (cleared by rebooting the PIC-WEB) first looked like a J1 fault.
- 02/11/2026 (correction, user): the PIC-WEB has a 10K NTC thermistor on AN9 (not a TC1047: build 202 showed 118-120 C) and one LED, the red status LED on RB4 (RA0/RA1 are the RJ45 LEDs: ETHLED back on). /v b is now the 8-bit AN9 reading; the page and the Home Assistant template work out C with Beta 4100, thermistor from VDD and 10K to ground - as Olimex's demo (PIC_WEB_5_42 CustomHTTPApp.c HTTPPrint_temp: R = 10K x (1023 / ADC - 1), B 4100; its HWP file: LED on LATB4, button RB0, ETHLED on). d is the LED (1 = on); /t0 and MQTT led/0 drive it; discovery has one LED switch. The LED is on when RB4 is low (user: build 208 showed it inverted): the board file starts it off (LATB4 = 1), /v d is 1 when LATB4 is 0, MQTT on/off drive it low/high. Build 211 (41.667 MHz) on the board: potentiometer 148 (58 %), thermistor 131 = 26.2 C, button released, LED on, time valid, syslog start-up and "Time set" lines.
- 02/11/2026: PIC-WEB dashboard (`PageHomeJ60.htm`, 2 tables). /v keeps its names: a potentiometer AN8 (8 bits), b temperature in C (AN9, 10 bits, TC1047 500 mV at 0 C and 10 mV/C, VDD 3.3 V reference; below 0 C is 0), q requests, p PORTB (button bit 0, low when pressed), d LEDs (LATA bits 0, 1). /t0 /t1 and MQTT `enc28j60-5/led/0` `/1` drive the LEDs. Board file: `BOARD_POT/TEMP/LED0/LED1/BUTTON`, ETHLED off (RA0/RA1 are the program's, no link/activity LEDs), LED pins made outputs at start-up. `HADiscovery.json` (one table now): Potentiometer %, Temperature C, LED0, LED1, Button. Home Assistant keeps the old AN2/AN3/RD0-7/RB0-7 entities of enc28j60-5 until deleted. (Superseded by the correction above.)
- 02/11/2026: two PIC-WEB programs, 25 MHz (`_SolutionJ60.gcb`) and 41.667 MHz (`_SolutionJ60_41.gcb`). The program sets `#Chip` and `#Config FOSC` (they are not conditional: inside `#if` in the board file both `#Chip` lines were read, the first used, and the last FOSC applied); the board file works out `BOARD_PLL` and `BOARD_MHZ` from ChipMHz and stops the compile for any other clock. Checked in the assembly: 25 MHz FOSC HS, no OSCTUNE, SPBRG 53, Timer0 1:32 / 61; 41.667 MHz FOSC HSPLL, OSCTUNE 0x40, SPBRG 89, Timer0 1:64 / 93. Build 193 (41.667 MHz) ran on the board (web pages, SNTP, syslog).
- 02/11/2026: PIC-WEB CPU at 41.667 MHz (25 MHz crystal through the PLL, / 3 x 5; was 25 MHz): board file FOSC HSPLL and `ClockInit` (OSCTUNE 0x40), `millis.h` 41.667 MHz entry, /s shows `BOARD_MHZ` 41. Serial 115200 from SPBRG 89 (+0.5%). Runs on the board since build 193.
- 02/11/2026: the Olimex PIC-WEB REV.C (18F67J60, J60 build 187) works: DHCP .123, ping, /, /c, /s, /v, SNTP, DNS, syslog ("020_FULLSTACK_SolutionJ60 build 187, 192.168.0.123, web 80, MQTT 192.168.0.126"), TCP to the broker; 426 frames received (0 bad), 159 sent (0 errors). Two faults first: (1) the compiler's `18f67j60.dat` gave free RAM 0-0xEDF, over the Ethernet registers at 0xE80-0xEFF, so the end of `EthFrame` overwrote MAADR, MACON ... ("TX failed"); now 0-0xE7F and 0xF00-0xF5F. (2) The chip needs another instruction between two MAC / MII register accesses: `MAADR3 = 0xC0` straight before `MAADR4 = 0` was lost (MAADR 00:1E:00:00:00:05), so unicast frames were filtered out (no ARP replies); `ENC28J60_J60Driver.h` now has a NOP after each.
- 01/11/2026: the start-up syslog message names the firmware (SOURCEFILE, build number GCBBuildStr), the address (Net_IP, from DHCP or fixed), the web port (TCP_LISTEN_PORT) and the MQTT broker (MQTT_BROKER1-4); it was "Test 020 start". On the 18F since build 176 ("020_FULLSTACK_Solution18F build 176, 192.168.0.120, web 80, MQTT 192.168.0.126") and on the PIC-WEB.
- 01/11/2026: time updated every 15 minutes (`SNTP_INTERVAL_S` 900, was 600): `millis()` drifts about 0.03% (0.17 s per 600 s from the syslog timestamps), so about 0.26 s before each update. The reload is 900 in all three builds' assembly, the retry 60. On the 18F since build 176: "Time set" every 15 minutes (07:20, 07:35, ... 08:50), drifting about 0.3 s each time. The 16F (.117) still runs the earlier build.
- 01/11/2026: syslog "Time set" as hh:mm:ss (was 19:0:38); the 16F program's comments now match its switches (headless; ICMP and syslog off; UDP and SNTP on). On the 18F and PIC-WEB ("Time set 06:37:10"); the 16F has syslog off.
- 31/10/2026: after the ENC28J60 swap MQTT dropped every minute ("malformed packet"): the TCP library cut the 1804-byte discovery message after two segments. Fixed in ENC28J60_TCP.h; the MQTT values message now carries the first five values (the 100-byte MQTT buffer). Home Assistant: connected 14:59:23 and stayed connected.
