# Ethernet Solutions

TCP/IP networking for GCBASIC: web servers, MQTT, SNTP time, DHCP, DNS and syslog, on three kinds of Ethernet
controller:

- the Microchip **ENC28J60** (SPI), or the Ethernet controller built into the PIC18F67J60 / PIC18F97J60;
- a **WIZnet** W5200 / W5500 (SPI; the WIZnet device does ARP, IP, ping, TCP and UDP itself), or a W5100;
- the **RTL8019AS** (NE2000, 8-bit bus) on the original Microchip PICDEM.net.

## The folder

| Folder | What it is |
|---|---|
| `ENC28J60_STACK` | The full stack: web site (dashboard, configuration and solution pages, live values), MQTT with Home Assistant discovery, SNTP, DHCP, syslog. One program per board - see its README |
| `WIZNET_STACK` | The same feature set on a WIZnet W5200 or W5500 (PIC18F47Q43), and a small web server with SD card file access on a W5100 shield (ATmega328P) |
| `RTL8019_STACK` | A minimal web server on the original PICDEM.net (PIC16F877 and RTL8019AS) |
| `Tutorial` | Six steps to a web server of your own, on the Olimex PIC-WEB (PIC18F67J60): the server answers, one page, read a value, set a value, a large page, several pages |
| `libraries` | The libraries all the programs use: the drivers, the stack modules (ARP, IPv4, ICMP, UDP, TCP, HTTP, MQTT, DHCP, DNS, SNTP, syslog, console, serial to UDP) |
| `hardware` | One folder per board, each with its `hardwareconfig.h` (the microcontroller, pins and Ethernet controller) and, where MQTT is used, its Home Assistant discovery message |

## The programs and their boards

| Program | Microcontroller | Ethernet |
|---|---|---|
| `ENC28J60_STACK\ENC28J60_16F18877.gcb` (and `_Debug`) | PIC16F18877 | ENC28J60 module |
| `ENC28J60_STACK\ENC28J60_18F47Q43.gcb` | PIC18F47Q43 | ENC28J60 module |
| `ENC28J60_STACK\ENC28J60_PICWEB.gcb`, `_PICWEB_41.gcb` | PIC18F67J60 (Olimex PIC-WEB), 25 or 41.667 MHz | built in |
| `ENC28J60_STACK\ENC28J60_PDN2_J1.gcb`, `_J1_41.gcb` | PIC18F97J60 (PICDEM.net 2), port J1 | built in |
| `ENC28J60_STACK\ENC28J60_PDN2_J2.gcb`, `_J2_41.gcb` | PIC18F97J60 (PICDEM.net 2), port J2 | ENC28J60 on the board |
| `WIZNET_STACK\WIZNET_18F47Q43_W5200-8.gcb` | PIC18F47Q43 | WIZnet W5200 |
| `WIZNET_STACK\WIZNET_18F47Q43_W5500-9.gcb` | PIC18F47Q43 | WIZnet W5500 |
| `WIZNET_STACK\WIZNET_MEGA328P_W5100-10.gcb` | ATmega328P (Arduino Uno) | W5100 shield, with its SD card |
| `RTL8019_STACK\RTL8019_PICDEMNET.gcb` | PIC16F877 (PICDEM.net) | RTL8019AS |
| `Tutorial\010_TUT_Step1_ServerOK.gcb` to `060_TUT_Step6_MorePages.gcb` | PIC18F67J60 (Olimex PIC-WEB) | built in |

## Libraries

Every program finds its libraries and its board file in this folder set, with `#option IncludePath`, for
example `#option IncludePath "..\libraries;..\hardware\18F47Q43"`. Keep the folders side by side as they are. The
programs also use the libraries that come with GCBASIC, such as `millis.h`. The one exception is
`WIZNET_STACK\WIZNET_MEGA328P_W5100-10.gcb`: it also searches `C:\GCstudio\gcbasic\AdditionalLibraries`, for the SD card
libraries `sd_card.h`, `sd_card_avr.h` and `sd_fat.h`.

## Before you compile

- **Addresses:** each program sets its own IP address, gateway, MAC address and server addresses (time server,
  MQTT broker, syslog server) near the top. Change them to suit your network before you program a board.
- **Web pages:** each page is an `.htm` file. In each program folder the pages, and the `/v` reply
  (`PageValues.h`, or `Step6Values.h` in `Tutorial`), are in its `webpages` folder, included as `#include "webpages\PageHome.htm"`.
  GCBASIC converts each page to a `.GCB` file of the same name, in the same folder, when the program is compiled,
  so change the `.htm` file, not the `.GCB` file.
- **Build number:** `GCBVersionNumber.cnt` holds a build number and time that change each time a program is
  compiled. The solution page (`/s`) shows them.

Each program folder has a README.md with its settings, its pages and how to test it.
