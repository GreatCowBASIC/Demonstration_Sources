# Test 022 - WIZNET: the 020 feature set on a WIZnet W5200 / W5500

**03/11/2026: this folder is `WIZNET_STACK` (was `022_WIZNET`, now in `..\Development\`); the program is `WIZNET_18F47Q43.gcb` (was `022_WIZNET_Solution.gcb`). Board and driver tests and the plan are in `..\Development\Project_Support\`.**

Test 020 (the 18F47Q43 build) on a WIZnet W5200 module in place of the ENC28J60. The W5200 does ARP, IPv4, ICMP (it answers ping itself) and TCP and UDP with retransmission, in 8 hardware sockets. The PIC opens sockets and moves data. `WIZ_Stack.h` gives the ENC28J60 stack's application libraries - HTTP, MQTT, console, DHCP, SNTP, DNS, syslog, serial to UDP - the calls they use, so they are included **unchanged**. The W5500 is supported by the same code (`WIZ_CHIP 5500`) but not yet tested.

## Files

| File | What it is |
|---|---|
| `022_WIZNET_Solution.gcb` | The program: switches, addresses, pages, console, MQTT functions (from `020_FULLSTACK_Solution18F.gcb`) |
| `webpages\PageHome.htm`, `webpages\PageConfig.htm`, `webpages\PageSolution.htm`, `webpages\PageValues.h` | The pages, as 020 with WIZnet titles ("GCBASIC WIZnet Web Server"; on `/c` the driver, ARP and IPv4 rows name the WIZnet chip); `PageSolution.htm` also shows the SPI clock |
| `GCBVersionNumber.cnt` | Build number and time |
| `README.md` | This description |

Shared code:

| File | What it is |
|---|---|
| `..\libraries\WIZ_Driver.h` | The chip: SPI frames (W5200 and W5500), reset, version check, addresses, link, sockets, copying between `EthFrame` and the socket buffers |
| `..\libraries\WIZ_Stack.h` | The stack for programs (in place of `ENC28J60_Stack.h`): switches, the TCP and UDP shims, start-up, `Stack_Tick`, `ENC_Service`, ping client, UDP echo |
| `..\hardware\18F47Q43_WIZ\hardwareconfig.h` | The board: 18F47Q43 at 64 MHz, the module on SPI1, PPS, serial port, device name wiz5200-8 |
| `..\hardware\18F47Q43_WIZ\HADiscovery.json` | Home Assistant discovery for device "WIZ5200-8" |
| `..\Project_Support\board_tests\WIZ_BOARD.gcb` | Bring-up test, no stack: version, MAC written and read back, link |
| `..\Project_Support\board_tests\WIZ_DRIVER.gcb` | Driver test, no stack: status, a small page on port 80 |

## How it works

### Sockets

| Socket | Use | Open |
|---|---|---|
| 0 and 3 | web server, both listening on port 80, served one at a time (TCP connection 0 to the libraries) | while the link is up; again as soon as a connection closes |
| 1 | client: MQTT (TCP connection 1) | by `TCP_Connect` |
| 2 | telnet terminal, port 23 (TCP connection 2), with `STACK_CONSOLE 2` | as the web sockets |
| 4 | UDP: DHCP, SNTP, DNS, syslog - opened on the local port of each datagram sent | when needed |
| 5 | UDP echo, port 7 | always |
| 6 | ping client: IPRAW, protocol ICMP | only while `ICMP_Ping` runs (the chip answers pings to us itself) |
| 7 | serial to UDP, port 50001, with `STACK_SERIAL_UDP 1` | always |

Two web sockets: while one sends a page, the other already waits for the next browser, so no connection is refused. Each socket has the chip's default 2 KB TX and 2 KB RX buffer.

### The TCP shim

- `TCP_SendStream(length, close)`: `TCP_FillData` builds the reply in pieces of up to 536 bytes at `EthFrame(TCP_DATA)`; each piece is copied to the socket and sent once the last SEND has finished. The chip retransmits, so nothing is rebuilt. With close: DISCON after the last piece.
- Received data: read into `EthFrame` from `TCP_DATA` (54, as in an ENC28J60 frame), the peer's address put at `IP_SRC`, then `TCP_HandleData` with `TCP_Conn`, `TCP_RxData`, `TCP_RxLength`. The web server gets the first 546 bytes of a request; the rest is dropped.
- `TCP_Connect`, `TCP_ClientState`, `TCP_ClientBusy`, `TCP_ClientSend`, `TCP_ClientClose`, `TCP_ConnState`, `TCP_ConnBusy`, `TCP_ConnSend`: as `ENC28J60_TCP.h`. The chip's socket states are mapped to the TCP states the libraries test (closed and listening read as `TCP_LISTEN`). "Busy" ends when the chip has the whole stream, not when the peer has acknowledged it.

**No socket may hang.** A socket that is never closed blocks new connections. So:

- every socket is served whatever the link reads;
- the link counts as changed only after 3 readings in a row, one second apart;
- a watchdog, once a second: a socket that is not listening or closed and has made no progress (state change, data in, piece sent) for `TCP_IDLE_S` (10 s) gets DISCON, 5 s later CLOSE, and is opened again. An open MQTT or terminal connection may be quiet;
- a SEND not confirmed within 1 s ends the stream.

### The UDP shim

The UDP libraries build their datagrams in `EthFrame` as before (`UDP_DATA` 42). `IP_BuildHeaderTo` / `IP_BuildHeaderBroadcast` record where a datagram goes, `ENC_Transmit` sends its data from the socket for its local port (the chip adds the IPv4 and UDP headers and the checksum), and waits for SEND_OK or TIMEOUT (no ARP answer). `IP_ResolveNextHop` and `ARP_Resolve` always "find" the host: the chip resolves MAC addresses itself. A received datagram (the chip's 8-byte header: address, port, length) is laid out as the libraries expect and passed to `UDP_HandleDatagram`. DHCP broadcasts from 0.0.0.0 and receives the broadcast answer, as WIZnet's own DHCP client does.

## Configuration

| Setting | Value |
|---|---|
| Module (`WIZ_CHIP`) | 5200 (5500 for a W5500) |
| Address | DHCP; fixed fall-back 192.168.0.121 (`MY_IP1-4`) |
| MAC (`MY_MAC1-6`) | 00:1E:C0:00:00:08 |
| Clock / SPI | 64 MHz, SPI1 Master 4 MHz (board file `WIZ_SPI_SPEED`) |
| Switches | all on except `STACK_SERIAL_UDP` (0); console serial (`STACK_CONSOLE 1`) |
| Serial to UDP | `STACK_SERIAL_UDP 1` with `STACK_CONSOLE 0` or `2`: broadcast to port 50001, any sender accepted, a datagram ends at CR (`SERUDP_PACK_CHAR 13`), 128 bytes or 20 ms quiet; 256-byte receive ring |
| MQTT | broker 192.168.0.126, discovery topic `homeassistant/device/wiz5200-8/config` |

### Wiring (the ENC28J60's pins on the 18F47Q43 rig)

| PIC | Module |
|---|---|
| RB1 | SCK |
| RB3 | MOSI |
| RB0 | MISO |
| RA5 | CS (nSS) |
| RB4 | RESET |
| 3.3 V, GND | 3.3 V, GND |
| GND | PWDN (W5200 only; high = power down) |

Keep the wires short with a good ground. A loose path read single bits wrong (1s lost: MAC `00:1E:C0:00:00:08` read as `00:1C:80:00:00:00`) while writes were fine - the chip answered ping at the right address, but the PIC never saw its link up, misread the request and the TX pointer, and sent empty replies. Rewiring cured it. The module draws about 0.24 A.

### Console keys (serial 115200, or telnet with `STACK_CONSOLE 2`)

`?` help, `d` W5200 status (version, MAC, addresses, link and the 8 socket states), `h` the address and lease, `p` statistics, `i` ping the router, `e` ping an address typed next, `l` syslog test message, `t` the time, `y` update the time, `w` renew the lease, `n` look up DNS_NAME1-3, `u` serial-to-UDP counters (with the bridge).

Build and program: `GCBASIC.EXE 022_WIZNET_Solution.gcb /NP /S:use.ini /F:N /DO` (PICkit 2).

## Testing

From this PC: ping; `curl` of `/`, `/c`, `/s`, `/v`, `/t0` (50 dashboards in a row); the syslog at the NAS; UDP echo with datagrams of 1 to 548 bytes; the telnet terminal on port 23 (every key); datagrams to port 50001 and a listener for the bridge's broadcasts. On the board's serial terminal: the start-up text and keys. In Home Assistant: the device WIZ5200-8.

## Results (03/11/2026, W5200, 18F47Q43 at 64 MHz)

| Test | Result |
|---|---|
| Board test | VERSIONR 0x03, MAC written and read back, link up 2 s after reset |
| Web site | `/` 3462 bytes 0.24 s, `/c` 0.33 s, `/s` 0.38 s; 50 of 50 dashboards, 40 of 40 `/c` and `/s` |
| `/t0` | 302 to `/`, RD0 toggled |
| MQTT | Home Assistant device WIZ5200-8, values and switches working |
| DHCP | lease from the router (.121); fixed .127 as the fall-back while DHCP was on: the lease was used; DHCP off: everything at .127 |
| SNTP / DNS | time.nist.gov resolved (132.163.96.x), stratum 1, time on the dashboard and `/s` |
| Syslog | start-up line `022_WIZNET_Solution build ..., 192.168.0.121, web 80, MQTT 192.168.0.126` and `Time set hh:mm:ss` at the NAS |
| Ping | the chip answers; the ping client (`i`) 4 of 4 replies from the router in 1-3 ms |
| UDP echo | 20 of 20 datagrams back exactly (1-548 bytes) |
| Telnet terminal | all keys answered over port 23 (`STACK_CONSOLE 2`) |
| Serial to UDP | 5 datagrams to port 50001 out on the serial port; a line typed on the terminal arrived as broadcasts (`Hello back` + CR, then LF) |
| SPI speed | MasterSlow 1 MHz 50/50 (0.26 s a page), Master 4 MHz 50/50 (0.24 s), MasterFast 8 MHz 43/50 (bit errors): Master |

Sizes: 27936 words / 2407 bytes RAM (43% / 29% of the 18F47Q43), serial console, bridge off; 28789 / 2852 with the telnet console and the bridge.

## Known limits

- The page time is the PIC building the page from its tables (about 0.24 s for 3.4 KB), not SPI.
- The telnet console buffers 240 bytes (`CONSOLE_TX_SIZE`): `p` prints more and is cut short - as on the ENC28J60 stack.
- One socket is free with the bridge on (none spare for more services).
- While the link is down the W5200 reports odd socket states (0x10, 0x08, 0x18): sockets are opened only when the link is up.
- The W5500 is not tested yet.

## Arduino Uno with the Ethernet shield (W5100): `WIZNET_MEGA328P_W5100-10.gcb`

A separate, minimal program (as test 021): the WIZnet stack does not fit the ATmega328P (15,360 words below the bootloader, 2 KB RAM) beside the SD card library, and `WIZ_Driver.h` has no W5100. Its own driver `..\libraries\W5100_Driver.h` writes each reply byte straight into the socket's TX buffer, so there is no frame buffer.

| | |
|---|---|
| Board | Arduino Uno (ATmega328P, 16 MHz, 5 V) with the Arduino Ethernet shield; board file `..\hardware\UNO_W5100\hardwareconfig.h` |
| SPI | SCK B.5 (D13), MOSI B.3 (D11), MISO B.4 (D12), 4 MHz; W5100 chip select B.2 (D10), microSD chip select D.4 (D4) |
| SD card library | `sd_card.h` (1.1, with `sd_card_avr.h`) and `sd_fat.h` (1.2) in `C:\GCstudio\gcbasic\AdditionalLibraries`, by `#option IncludePath` |
| Address | 192.168.0.129 fixed, MAC 00:1E:C0:00:00:0A, host name in syslog `wiz5100-10` |
| Sockets | 0 and 1 web (port 80), 2 UDP (SNTP from 192.168.0.250 every 15 min, syslog to 192.168.0.245), 3 spare |
| Console | COM32, 9600 8N1 (opening it resets the Uno); programmed by use.ini's "Arduino UNO @115200" (avrdude, COM32) |

| Path | Reply |
|---|---|
| `/` | dashboard (`UnoHome.htm`): C.0 (A0), C.1 (A1), PORTB (B.0, B.1), PORTD D.2, D.3, D.5, D.6, D.7 with Toggle (the page asks `/t` in the background and redraws: it stays on the dashboard), the time, Auto Update. The pins the program uses - serial D.0, D.1, SPI B.3-B.5, chip selects B.2 and D.4 - are listed as fixed text on the CONFIG card of `/s` |
| `/v` | values as JSON, the same keys as the other boards (`PageValues.h`) |
| `/s`, `/c` | solution and configuration on one page (`UnoSolution.htm`): firmware, build, time, network, W5100 sockets, SD card, CONFIG (the pins) |
| `/t0`-`/t7` | toggle a PORTD bit, answered with `/v`; only D.2 (D2), D.3 (D3), D.5 (D5), D.6 (D6), D.7 (D7); D.0, D.1 (serial port) and D.4 (SD card chip select) are refused |
| `/f/`, `/f/DIR/` | the card's folder as a table (folders end with `/`, files with their size) |
| `/f/DIR/NAME.EXT` | the file as a download (`application/octet-stream`, `Content-Disposition: attachment`, `Content-Length`) |

Checked 09/11/2026 on the board: ping, `/`, `/v`, `/s` complete; `/t2` toggles D.2 (D2), `/t4` refused; 4 dashboard loads at once all complete; SNTP time and syslog start line at the NAS; 15 GB SDHC card (FAT32): `/f/` lists the root, `/f/SDCARD/` the folder with `../`, `/f/SDCARD` answers 302 to `/f/SDCARD/`, a missing file 404, `RTCLOG.CSV` (21,484 bytes) downloaded whole in 2.0 s (about 10.6 KB/s), twice byte for byte the same, and `HELLO.TXT` as written by `SD_Test_mega328p.gcb`.

Not in this program: MQTT, DHCP, DNS, the telnet console (no room). Size 09/11/2026: 16,360 of 16,384 words (the 1,024 reserved for the bootloader included), 1,607 of 2,048 bytes RAM. In a page's `.htm`, a line that has a `_GCB_BYTE` name must not also have `=` unless it is a value line: the converter takes it as a value (the solution page lost its first card this way).
