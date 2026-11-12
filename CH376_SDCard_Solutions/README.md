# The CH376: the SD card methods on a USB drive or an SD card

A WCH CH376 gives a microcontroller files on a FAT USB flash drive, or on an SD card in the CH376's own socket.
The CH376 keeps the FAT file system itself. These GCBASIC libraries put it behind **the same methods as an SD
card**, the ones that `sd_card.h` and `sd_fat.h` give (`FatInit()`, `SDCInit()`, `FatMount()`, `FatOpen`,
`FatAppendByte`, `FatCommit()` and so on). A program written for an SD card runs on a CH376 with only its include
lines and pin `#define` lines changed.

## Files

| File | What it is |
|---|---|
| `CH376_SPI_DataLogger_18F27Q43.gcb` | **data logger**: `ReadAD(AN1)` added to `DATALOG.TXT` every 5 s, the CH376 on SPI1 |
| `CH376_USART_DataLogger_18F27Q43.gcb` | **data logger**: the same, with the CH376 on UART1 (9600 bps) and the serial terminal on UART2 |
| `Test_Programs\CH376_SPI_Test_18F27Q43.gcb` | test program: the CH376 on SPI1, one line per check on the serial terminal |
| `Test_Programs\CH376_USART_Test_18F27Q43.gcb` | test program: the CH376 on UART1, the serial terminal on UART2 |
| `Test_Programs\CH376_SPI_Probe_18F27Q43.gcb` | SPI probe: is the CH376 answering? `CHECK_EXIST` and `GET_IC_VER` twice a second |
| `GCBASICLibraries\ch376_sd.h` | the SD card methods (the sd_card.h and sd_fat.h names, codes and variables) on the CH376 |
| `GCBASICLibraries\ch376.h` | the CH376 itself: its interface and its own file calls. `ch376_sd.h` includes it |

All the programs are for the PIC18F27Q43. They look for the libraries first in `C:\GCstudio\gcbasic\AdditionalLibraries`, then in
the `GCBASICLibraries` folder here:

- the data loggers: `#option IncludePath "C:\GCstudio\gcbasic\AdditionalLibraries;GCBASICLibraries"`
- the test programs: `#option IncludePath "C:\GCstudio\gcbasic\AdditionalLibraries;..\GCBASICLibraries"`

A copy of `ch376.h` or `ch376_sd.h` in `AdditionalLibraries` is used before the one in `GCBASICLibraries`. The
SPI probe needs no library.

`ch376.h` is ported from the WCH reference code in the CH376EVT package (`EXAM\SPI_HW.C`, `UART_HW.C`,
`PARA_HW.C`, `FILE_SYS.C` V1.3, `CH376INC.H`). It uses the shared `hwspi.h` (`SPIMode`, `HWSPITransfer`) and
`usart.h` (`HSerSend`, `HSerReceiveFrom`, `USARTHasData`) of the compiler as they are.

## Interfaces

| Interface | `CH376_COMMS_METHOD` | State |
|---|---|---|
| SPI | `CH376_COMMS_SPI` | **supported**: all 26 checks of the test program pass on the board, with a USB stick and with an SD card |
| Serial (UART) | `CH376_COMMS_USART` | **supported**: all 26 checks pass on the board, and the data logger works |
| Parallel | `CH376_COMMS_PARALLEL` | **not implemented yet**: see [Parallel: to do](#parallel-to-do) |

`CH376_COMMS_METHOD` must be defined. If it is missing or has another value, the build stops with an error that
says so. Only the `#define` lines change between the interfaces: `ch376_sd.h` and the program stay the same.

## Switching a program from an SD card to the CH376

```
' SD card                                  ' CH376 on SPI
#DEFINE SDC_CS        LATC.6                #define CH376_COMMS_METHOD CH376_COMMS_SPI
#DEFINE SDC_SPI_BUF   SSP2BUF               #define CH376_CS        PortA.4
...                                         #define CH376_INT       PortB.4
#include <sd_card.h>                        #define CH376_SPI_SPEED Master
#include <sd_fat.h>                         #include <ch376_sd.h>
```

The rest of the program does not change:

```
If FatInit() <> FAT_OK Then ...             ' SDCInit, then FatMount; FAT_ERR_NO_DRIVE: no drive (SDCError, CH376Error)
FatDate = 0x5D68 : FatTime = 0x6000         ' 2026-11-08 12:00, after FatMount
If FatChDir("LOGS") <> FAT_OK Then ...
If FatOpen("DAY1.CSV") <> FAT_OK Then ...   ' appends; FatCreated() = 1 for a new file
FatAppendByte(...)                          ' a record
If FatCommit() <> FAT_OK Then ...           ' data, size and date on the drive
If FatOpenRead("SETTINGS.INI") = FAT_OK Then
    Do While FatEOF = 0
        Ch = FatReadByte()
    Loop
End If
```

## Settings

Define these before `#include <ch376_sd.h>`.

**SPI** (`CH376_COMMS_SPI`)

| Setting | What it is |
|---|---|
| `CH376_CS` | the chip select output, for example `PortA.4` |
| `CH376_SPI_SPEED` | the `hwspi.h` mode, for example `Master` (4 MHz at 64 MHz). The CH376 takes up to 24 MHz |
| `CH376_INT` | optional: the INT# input. Without it, the CH376's SDO shows the interrupt while CS is high (`SET_SDO_INT`), read on `CH376_SDO_PIN` (by default `CH376_DI`). Do not use SDO for the interrupt when other devices share the SPI bus |
| `CH376_SPI_SHARED` | optional: each command sets `SPIMode` first, for an SPI bus shared with a device that uses another mode or speed |

**Serial** (`CH376_COMMS_USART`)

| Setting | What it is |
|---|---|
| `CH376_UART_PORT` | the `usart.h` port number (default 1) |
| `CH376_UART_HASDATA` | the "byte received" test of that port: `USARTHasData` (default, port 1) or `USART2HasData` |
| `CH376_INT` | optional: without it, the status byte that the CH376 sends on TXD is used |

The CH376 starts at 9600 bps unless its BZ/D4, SCK/D5 and SDI/D6 pins choose another rate at power-up.
`CH376SetBaud` changes its rate; the UART of the microcontroller must then change to the same rate.

**The drive: USB stick (default) or SD card**

```
#define CH376_MEDIA_SDCARD          ' the SD card socket of the CH376
' #define CH376_MEDIA_USBSTICK      ' the USB socket: the default, the same as defining neither
#include <ch376_sd.h>
```

Defining both is a compile error.

| Flag | Drive | CH376EVT board | Block access (`SDCReadBlock` and so on) |
|---|---|---|---|
| `CH376_MEDIA_USBSTICK` (default) | a FAT USB stick in the USB socket (P4) | 5V0, J3 1-2, J2 off | yes |
| `CH376_MEDIA_SDCARD` | a FAT SD card in the SD socket (P5) | 3V3: J3 2-3, J2 on | no: `SDC_ERR_CMD` |

**Other settings**

| Setting | What it is |
|---|---|
| `CH376_TIMEOUT_LOOPS` | the wait for an interrupt, in loops of about 10 us (default 500000, about 5 s or more) |
| `CH376_STREAM_BLOCK` | the `CH376ReadByte` / `CH376WriteByte` buffer, 1 to 64 bytes (default 64) |

## The methods

| sd_card.h / sd_fat.h | On the CH376 |
|---|---|
| `SDCInit()` | resets the CH376, waits for the drive to start and mounts it, and reads the capacity. `SDC_ERR_NO_CARD`: no drive. `SDC_ERR_INIT`: no answer from the CH376, or the drive did not start (`CH376Error` says which; 0xF0 is no CH376) |
| `SDCBlocks`, `SDCCardType`, `SDCError` | the capacity in 512-byte blocks; `SDC_TYPE_CH376_USB` or `SDC_TYPE_CH376_SD`; the last error |
| `SDCReadBlock`, `SDCWriteBlock`, `SDCReadStart` / `SDCReadByte()` / `SDCReadEnd`, `SDCWriteStart` / `SDCWriteByte` / `SDCWriteEnd()` | USB drive sectors (CH376 `DISK_READ` / `DISK_WRITE`, 64 bytes at a time). Not on the SD card socket of the CH376: `SDC_ERR_CMD` there |
| `FatMount()`, `FatType` | the CH376 mounts the drive; `FatType` is 12, 16 or 32 |
| `FatInit()` | `SDCInit()`, then `FatMount()`, in one call; `FAT_ERR_NO_DRIVE` when the drive did not start |
| `FatChDir`, `FatMkDir`, `FatRmDir`, `FatDelete` | as sd_fat.h, with the same `FAT_ERR_` codes (`EXISTS`, `NOT_EMPTY`, `NOT_DIR`, `IS_DIR`, `NOT_FOUND`) |
| `FatOpen`, `FatCreated()`, `FatAppendByte`, `FatCommit()` | append. `FatCreated()` is 1 when `FatOpen` made the file and 0 when it was there already; before a `FatOpen` that succeeded it returns 0 and sets `FatError = FAT_ERR_NOT_OPEN`. `FatCommit()` writes the data, the size in the folder entry, and the date and time `FatDate` / `FatTime` |
| `FatOpenRead`, `FatReadByte()`, `FatEOF`, `FatFileSize` | read from the start |
| `FatListFirst()`, `FatListNext()`, `FatListName`, `FatListAttr`, `FatListSize`, `FatListStamp` | list the current folder, "." and ".." included, as sd_fat.h |

Differences from sd_fat.h:
- FAT12 drives work. sd_fat.h does not accept them.
- The current folder is kept as a path of up to 64 characters, about 7 folders deep.
- The CH376 has one file open at a time. As with sd_fat.h, a file opened with `FatOpen` / `FatOpenRead` stays
  usable through other calls, such as listing or `FatMkDir`. Those calls close it in the CH376 (an appended file
  has its size written), and the next `FatAppendByte` / `FatReadByte()` opens it again where it was.

## The CH376EVT board (WCH EVT376 design; LC-Studio CH376EVT v1.1)

From the WCH documents `CH376SCH.PDF` (the EVT376 schematic) and `CH376EVT.PDF` (the board notes). The LC-Studio
board follows this design. **Check the header labels on your board before wiring.**

**P2 - SPI** (8 pins)

| P2 pin | Signal | CH376 pin |
|---|---|---|
| 1 | D3/SCS (chip select in, low = selected) | 18 |
| 2 | INT# (interrupt out, low = pending) | 1 |
| 3 | D7/SDO (data out to the microcontroller) | 22 |
| 4 | D6/SDI (data in from the microcontroller) | 21 |
| 5 | D5/SCK (clock in) | 20 |
| 6 | RSTI (reset in, high = reset; leave it open: `SDCInit()` resets the CH376 by command) | 2 |
| 7 | +5 (power in) | - |
| 8 | GND | - |

**P1 - parallel** (16 pins): 1-8 D0-D7, 9 INT#, 10 A0 (high = command / status, low = data), 11 RD#, 12 WR#,
13 RSTI, 14 CS#, 15 +5, 16 GND.

**P3 - serial** (8 pins): 1 TXD (to the RX of the microcontroller), 2 RXD (from its TX), 3 GND, 4 +5, 5 INT#,
6 RSTI, 7 SDWP (SD write protect), 8 SDINSERT (SD card in).

P4 is the USB-A socket for the flash drive, and P5 is the SD card socket. The CH376 runs from a 12 MHz crystal.

### Jumpers

The CH376 reads its interface from its pins only at power-up, so set the jumpers with the power off.

| Interface | J1 | J5 | J6 |
|---|---|---|---|
| Parallel | on | off | off |
| SPI | off | on | on |
| Serial (UART) | off | off | off |

| Drive | CH376 supply | J3 | J2 |
|---|---|---|---|
| USB stick | 5 V | 1-2 (North) | off |
| SD card | 3.3 V (still 5V0 on +5: it feeds the 3.3 V regulator of the board) | 2-3 | on |

### Power

The +5 pin on P1, P2 or P3 feeds VBUS of the USB socket (through R1, 2 ohm) and the 3.3 V regulator of the board.
**A USB flash drive needs 5 V**, so feed +5 from a 5 V supply that can give the drive 100-200 mA, and join its
ground to the ground of the microcontroller. Measure it at the board: it must be 5V0. Keep the wires to the board
short, **20 cm at most** (WCH).

## The demonstration programs: PIC18F27Q43

All the programs run the PIC18F27Q43 (28-pin) from its 64 MHz internal oscillator at 3.3 V. PPS is set in
`PPSInit` (`#startup`). They need a FAT USB stick in the USB socket of the CH376EVT (or, with
`#define CH376_MEDIA_SDCARD`, a FAT SD card in its SD socket) and a terminal on the serial port.

### SPI: wiring

| PIC18F27Q43 | Function (PPS) | CH376EVT P2 |
|---|---|---|
| RB1 | SPI1 SCK (`RB1PPS = 0x31`, `SPI1SCKPPS = 0x09`) | 5 D5/SCK |
| RB3 | SPI1 SDO (`RB3PPS = 0x32`) | 4 D6/SDI |
| RB0 | SPI1 SDI (`SPI1SDIPPS = 0x08`) | 3 D7/SDO |
| RA4 | CH376 chip select (`CH376_CS`) | 1 D3/SCS |
| RB4 | CH376 interrupt (`CH376_INT`); optional | 2 INT# |
| GND | | 8 GND |
| | 5 V supply | 7 +5 |

Serial terminal: UART1 TX on RC6 (and RC5), RX on RC7, 115200 bps (`U1RXPPS = 0x17`, `RC6PPS = RC5PPS = 0x20`).
Jumpers: SPI (J1 off, J5 on, J6 on).

### Serial: wiring

The CH376 is on UART1 on its usual pins, RC6 and RC7, and the serial terminal is on UART2.

| PIC18F27Q43 | Function (PPS) | CH376EVT P3 |
|---|---|---|
| RC6 | UART1 TX (`RC6PPS = 0x20`) | 2 RXD |
| RC7 | UART1 RX (`U1RXPPS = 0x17`) | 1 TXD |
| RB4 | CH376 interrupt (`CH376_INT`); optional: without it the status byte on TXD is used | 5 INT# |
| GND | | 3 GND |
| | 5 V supply | 4 +5 (or P2 pin 7) |

Serial terminal: UART2 TX on RC0 and RC5 (`RC0PPS = RC5PPS = 0x23`), RX on RC1 (`U2RXPPS = 0x11`), 115200 bps.
Jumpers: serial (J1 off, J5 off, J6 off). The BZ/D4, SCK/D5 and SDI/D6 pins of the CH376 choose its rate at
power-up, and left open it is 9600 bps, so take the SCK and SDI wires off P2.

```
#define USART2_BAUD_RATE 115200                 ' the serial terminal
#define USART2_BLOCKING

#define USART_BAUD_RATE 9600                    ' the CH376: it starts at 9600
#define USART_BLOCKING
#define CH376_COMMS_METHOD CH376_COMMS_USART
#define CH376_UART_PORT    1
#define CH376_UART_HASDATA USARTHasData
#include <ch376_sd.h>
```

Every serial terminal call names port 2: `HSerPrint "text", 2` and `HSerPrintCRLF 1, 2`. In `HSerPrintCRLF` the
first number is how many line ends and the second is the port, so `HSerPrintCRLF 2` on its own is two line ends on
port 1, the CH376. A call with no port goes to port 1.

### The test programs

`CH376_SPI_Test_18F27Q43.gcb` and `CH376_USART_Test_18F27Q43.gcb` print one line per check
(`01 OK   SDCInit` ... or `nn FAIL name - got ..., FatError ..., CH376Error 0x..`), then
`26 checks, 0 failed - PASS`. They leave `\CH376\HELLO.TXT` on the drive, dated 2026-11-08 12:00.

### The SPI probe

`CH376_SPI_Probe_18F27Q43.gcb` checks the SPI link on its own. Twice a second it sends `CHECK_EXIST 0x55` (the answer is
`AA`) and `GET_IC_VER` (the answer is `4x`). `00` means SDO is held low (no power, or in reset). `FF` means
nothing drives it (the wiring, the chip select or the jumpers).

## Parallel: to do

The parallel interface is not implemented yet. `ch376.h` accepts `#define CH376_COMMS_METHOD CH376_COMMS_PARALLEL`
and has first parallel routines, written from the WCH `PARA_HW.C`:
- `CH376_DATA`: an 8-bit port (read and written; its direction is set as needed).
- `CH376_A0`, `CH376_RD`, `CH376_WR` and `CH376_CS`: outputs.
- `CH376_INT` is optional; without it, bit 7 of the status port is read.

They compile, but they have not been run on a CH376. To finish it:
1. Check the parallel bus timing in `CH376ParWrite` / `CH376ParRead` against the CH376 datasheet.
2. Write a parallel test program and data logger for the PIC18F27Q43 (wiring to P1, jumpers J1 on, J5 off, J6 off).
3. Run the 26 checks on the board, with a USB stick and with an SD card.
4. Update this README.
