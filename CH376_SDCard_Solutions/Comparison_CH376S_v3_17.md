# CH376: this solution compared with CH376S_v3_17.gcb

12/11/2026. A comparison of the CH376 libraries in this folder (`GCBASICLibraries\ch376.h`, `ch376_sd.h`) and their
demos with `CH376S_v3_17.gcb` (Scott C, adapted to GCBASIC by Mike Otte, 2020): a menu demo for a PIC18F25K80, with
the CH376 on USART1 and a terminal on USART2.

`CH376_USART_Menu_18F27Q43.gcb` in this folder does the jobs of CH376S_v3_17.gcb with the ch376_sd.h methods.

## CH376S_v3_17.gcb does not compile with build 1675

| Line | Error | Cause |
|---|---|---|
| 306, 322, 507 | Reserved word cannot be used as a variable, parameter, or Sub/Function name: DATA | `data` is a parameter name |
| 51 | Direct array load method only supports bytes arrays | `enter = 13, 10` on a String |

To measure it, a scratch copy had `data` renamed and `enter` set with `Chr(13)` then `+ Chr(10)`. The file itself
was not changed.

## The comparison

| | CH376S_v3_17.gcb | This solution |
|---|---|---|
| Interface | UART only | SPI or USART (parallel is to do) |
| What the program calls | CH376 commands sent inline (0x57 0xAB, the command, its data) | The sd_card.h / sd_fat.h methods (SDCInit, FatInit, FatOpen, FatAppendByte, FatCommit ...): an SD card program changes to a CH376 by its include lines |
| Timeouts | `waitForResponse` counts in a Byte up to `timeOut = 2000`, so it never times out: a CH376 that does not answer hangs the program. `fileWrite` waits with `wait until USBavailable`, no timeout | Every wait has a limit: `CH376_TIMEOUT_LOOPS` for an interrupt, about 100 ms for a byte on the UART |
| Errors | Each sub prints a message and the job carries on after a failure: nothing is returned to the caller | Every method returns an `SDC_` / `FAT_` code (`SDCError`, `FatError`, `CH376Error`). The data logger starts the drive again after a card is pulled out and loses no sample |
| Starting the drive | Every write, append and read does RESET_ALL (200 ms), SET_USB_MODE, DISK_CONNECT and DISK_MOUNT | Started and mounted once. After RESET_ALL, CHECK_EXIST is tried for up to 250 ms (the chip took 40-50 ms on the board); DISK_CONNECT is tried every 100 ms |
| Drives | A USB stick only | A USB stick, or a card in the CH376's SD socket: SD, SDHC, TF (microSD) and MMC cards (the CH376 datasheet: "protocol-compatible MMC and TF cards"), up to 32 GB |
| USB mode | 0x06 | 0x06 for a USB stick, 0x03 for the CH376's SD card socket (`CH376_MEDIA_USBSTICK` / `CH376_MEDIA_SDCARD`) |
| Interrupt | None: the reply bytes on TXD | INT# (`CH376_INT`) optional; without it the status byte on TXD (USART) or SDO (SPI) |
| Writing | One BYTE_WRITE of up to 255 bytes (a String). When the CH376 takes fewer bytes (a 512-byte sector boundary), `appendFile` writes the rest again | `FatAppendByte` into a buffer, any length; `FatCommit()` writes the buffer, the file's size and its date and time into the folder entry |
| Reading | 64-byte BYTE_READ pieces into an 80-byte interrupt ring buffer; the buffer can overrun and the bytes are lost without warning | `FatReadByte` one byte at a time, with `FatEOF` |
| Files | Root folder only; one file at a time by name | Folders (`FatChDir`, `FatMkDir`, `FatRmDir`), `FatDelete`, listing (`FatListFirst`, `FatListNext`), FAT12/16/32 |
| Dates | None (the CH376 default) | `FatDate` / `FatTime` on new files, on writes and on new folders |
| File size | `getFileSize` reads 4 bytes after a fixed 100 ms; bytes not there keep their old value | Read with the CH376's READ_VAR32 |
| Tested | Demo | 26/26 on the board, SPI and USART, with and without INT# |

## Program memory and RAM

Build 1675, compile only.

| Program | Chip | Program memory | RAM |
|---|---|---|---|
| CH376S_v3_17.gcb (scratch copy, the two compile fixes) | 18F25K80 | 4,798 words | 724 bytes |
| CH376_USART_DataLogger_18F27Q43.gcb, moved to the 18F25K80 (scratch copy: #Chip, no PPS, the terminal on RB6 / RB7 at 9600) | 18F25K80 | 2,898 words | 655 bytes |
| CH376_USART_Menu_18F27Q43.gcb | 18F27Q43 | 7,620 words | 856 bytes |

CH376S_v3_17.gcb includes the DS18B20 library and a Timer0 clock. The data logger has none of the menu, reading,
listing or deleting. The menu demo has all the jobs and uses the full library.

## Other faults in CH376S_v3_17.gcb

- `fileClose` prints the error code from `resp`, which is never set.
- `fileDelete` sets the name but does not mount the drive first: it works only after another job.
- The clock (`RTC`) wraps the hour at 30, not 23.
- `readSerDataUSB` and `sendCommand` are C code (`uint32_t`, `_comPort->available()`, `write`): they compile only because
  nothing calls them.
- The header is the LGPL header of the USART library, with "THIS FILE IS ESSENTIAL FOR SOME OF THE COMMANDS IN GCBASIC".

## The menu demo

`CH376_USART_Menu_18F27Q43.gcb`: the CH376 on UART1 (RC6 / RC7, 9600), the terminal on UART2 (RC0 / RC1, 115200),
AN1 on RA1. A `> ` prompt shows when it is ready for a key, and the key is echoed. The file jobs work in the current
folder: C changes it, and it is the root at the start and after 1, 2 or 3.

| Key | Job | Methods |
|---|---|---|
| 1 | Check the CH376: the chip version, card or stick, and its size | `SDCInit()` |
| 2 | Mount the drive, show its FAT type | `FatMount()` |
| 3 | Start again: reset, start, mount | `FatInit()` |
| 4 | Write TEST4.TXT, a new file with one line | `FatDelete`, `FatOpen`, `FatAppendByte`, `FatCommit()` |
| 5 | Read TEST4.TXT to the terminal | `FatOpenRead`, `FatReadByte`, `FatEOF` |
| 6 / 9 | Add the 33-character line, or the first line again | `FatOpen`, `FatCreated()`, `FatCommit()` |
| 7 | Delete TEST4.TXT | `FatDelete` |
| 8 | List the current folder, with its path (CH376S_v3_17.gcb read the file a second time here) | `FatListFirst`, `FatListNext` |
| C | Change folder: type a folder name, `..` (up one) or `\` (the root), then Enter. Letters are made capitals, Backspace removes a character, Esc cancels | `FatChDir` |
| L | Every 2 s add `hh:mm:ss,value` to TEST4.TXT, with value = `ReadAD(AN1)` in place of the DS18B20; any key stops it | |
| ? | The menu | |
