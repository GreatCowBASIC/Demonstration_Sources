# Test 021 - PICDEMNET: a minimal web server on the original PICDEM.net

**03/11/2026: this folder is `RTL8019_STACK` (was `021_PICDEMNET`, now in `..\Development\`); the program is `RTL8019_PICDEMNET.gcb` (was `021_PICDEMNET_Solution.gcb`).**

The original Microchip PICDEM.net (DM163004): PIC16F877 at 19.6608 MHz, RTL8019AS Ethernet controller (NE2000, 8-bit bus), 16x2 LCD, two potentiometers, a switch and LEDs. The 020 ideas cut down to fit the 16F877's 8K words and 368 bytes of RAM: fixed address, ARP reply, ping, a web server on port 80 and one page with the potentiometers AN0 / AN1, the switch RB5 and the user LEDs LED0 (RA2) / LED1 (RA3) with Toggle. The LCD shows a boot screen, then the address and the values; the system LED (RA4) blinks once a second.

## Files

| File | What it is |
|---|---|
| `021_PICDEMNET_Solution.gcb` | The program: configuration, frame handling (ARP, ICMP, TCP), HTTP responses, LCD |
| `webpages\PageHome.htm` | The page `/` (converted to PageHome.GCB when compiled; one table, 2001 bytes - close to the converter's ~2024-byte table limit) |
| `README.md` | This description |

Shared code: `..\libraries\RTL8019_Driver.h` (the RTL8019AS: start-up, remote DMA, receive ring, send) and `..\hardware\16f877\hardwareconfig.h` (the board). Board tests in `..\Project_Support\board_tests\`: `PICDEMNET_LEDS.gcb` (LED walk), `PICDEMNET_LCD.gcb` (LCD only), `PICDEMNET_BOARD.gcb` (pots, switch, LEDs, RTL8019AS ID "Pp").

## How it fits

- **No frame buffer in RAM:** frames stay in the RTL8019AS's 16 KB buffer (transmit pages 0x40-0x45, receive ring 0x46-0x5F). Only the first 58 bytes of each frame (receive header, Ethernet, IPv4, TCP) are read into `RxHdr`; replies are written straight into the transmit buffer by remote DMA. A ping's data is copied through a 16-byte buffer.
- **No ARP cache:** an ARP reply, a ping reply and every TCP segment go to the MAC the frame came from.
- **TCP without connection state:** each segment is answered from its own numbers (we acknowledge its sequence number and send from the number it acknowledges). A SYN gets SYN-ACK, a request the whole response ending with FIN, a FIN alone an ACK. So any number of connections work - a browser opens two on a reload.
- **No retransmission:** responses go out in 536-byte segments without waiting; a lost segment means the browser asks again.
- **Checksums in two passes:** the TCP and IPv4 checksums are worked out over the same bytes before the frame is written (`EmitMode` 0 sums, 1 writes).

## Configuration

| Setting | Value |
|---|---|
| Address (`MY_IP1-4`) | 192.168.0.125, fixed (no DHCP) |
| MAC (`MY_MAC1-6`) | 00:1E:C0:00:00:07 |
| TCP segment (`TCP_SEGMENT`) | 536 bytes |
| Clock | 19.6608 MHz crystal, FOSC HS (board file) |

| Request | Answer |
|---|---|
| `/` (anything else) | the page |
| `/v` | the values as JSON: `{"a":AN0,"b":AN1,"s":switch (1 released),"l":LED0,"m":LED1 (1 on)}` |
| `/t0`, `/t1` | toggles LED0 / LED1 and answers with the values (JSON) |

The page shows the values at once, then asks for `/v` every 2 s (**Auto Update (2 s)**, can be switched off; a failed request is retried after 0.5 s); **Update** asks once; **Toggle** switches a LED and redraws from the answer, without reloading the page.

### Board (hardware\16f877\hardwareconfig.h)

Pins from Microchip's TCP/IP Stack 3.75 (`Include\Compiler.h` PICDEMNET, `Source\RTL8019AS.c`), checked on the board:

| What | Pins |
|---|---|
| RTL8019AS | data PORTD, address RB0-RB4, IOR RE0, IOW RE1, RESET RE2 |
| LCD | 4-bit on RD0-RD3, RS RD4, RW RD5, E RA5 - shares PORTD with the RTL8019AS |
| LEDs | LED0 RA2, LED1 RA3 (user), system LED RA4 - all light when the pin is low |
| Switch | RB5 (PORTB pull-ups on) |
| Potentiometers | AN0, AN1 |
| Not used | 24LC256 (I2C RC3/RC4), USART RC6/RC7. D1-D3 are the RTL8019AS's link, receive and transmit LEDs |

The LCD shares PORTD with the RTL8019AS bus:

- **Write only:** `LCD_NO_RW`, RW (RD5) held low, `LCD_SPEED SLOW`, as Microchip's `LCDBlocking.c` does on this board. The library reading the busy flag through RW never initialised the LCD.
- **The bus back to the LCD:** the RTL8019AS routines leave RD5 low and an output after each access. The program makes RS (RD4) an output again before each LCD update. With RS floating, a cursor command showed as a stray character after the address.
- **Cold start:** the library's `#startup InitLCD` can run before the LCD is ready. The program calls `BoardInit` again, sets RS and RW, waits 100 ms and calls `InitLCD` again. Without that, a cold start garbled the LCD about one time in two.

Build and program: `GCBASIC.EXE 021_PICDEMNET_Solution.gcb /NP /S:use.ini /F:N /DO` (PICkit 2 on the ICSP header; programming fails verification now and then - try again).

## Testing

1. **Cold start:** the LCD shows "GCBASIC  2026" / "Web Server" for 4 s, "PICDEM.net" while the RTL8019AS starts, then `192.168.0.125` and `A0 nnn A1 nnn S1` every second. "RTL8019AS failed" means it did not enter reset or did not read its ID "Pp".
2. `ping 192.168.0.125` (also `-l 1000`); this PC's ARP table shows 00-1E-C0-00-00-07.
3. `curl http://192.168.0.125/` returns the whole page; `curl http://192.168.0.125/v` the JSON; `/t0` and `/t1` toggle the LEDs.
4. A browser: values every 2 s, Toggle, Update, Auto Update on/off, F5.

## Results (02/11/2026)

| Check | Result | Detail |
|---|---|---|
| Compile: 0 errors, 0 warnings | PASS | 6513/8192 words (79.5%), RAM 266/368 bytes (72.3%) |
| Board test | PASS | LCD, LEDs (all on when low), pots, switch, RTL8019AS ID "Pp" |
| ARP | PASS | 00-1E-C0-00-00-07 |
| Ping | PASS | 4/4, 3 ms; 1000-byte pings 5/5 |
| Page `/` | PASS | complete to `</html>`, 10/10 in a row |
| Parallel requests | PASS | 4 pages and 4 `/v` at once: all complete (after TCP without state) |
| `/v` | PASS | valid JSON, 20/20 in 0.66 s |
| `/t0`, `/t1` | PASS | each toggles its LED and answers with the values |
| Browser | PASS | values every 2 s, Toggle, Update, Auto Update, F5 (user) |
| LCD | PASS | address and values; cold start every time (user) |

Not in this program (no room or not needed): DHCP, DNS, UDP, SNTP, MQTT (about 1300 words without Home Assistant discovery, 2100-2800 with it, against 1679 free - dropped, user), retransmission, an answer (RST) on other ports.
