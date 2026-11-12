# Data Logger Solutions

SD card data loggers for GCBASIC on an ATmega328P (Arduino Uno) and an LGT8F328P (Uno-style board).

Each logger adds a line to a file on an SD card, with the date and time from a DS1307 real time clock. The display
versions also show the clock and the logger on an ILI9341 touch screen, and they have a touch menu.

## The folder

| File | What it is |
|---|---|
| `SD_RTCLogger_ILI9341_mega328p.gcb` | **The finished demonstration**, ATmega328P (Arduino Uno) |
| `SD_RTCLogger_ILI9341_LGT8F328P.gcb` | **The finished demonstration**, LGT8F328P |
| `Touch_Setup\Touch_Probe_mega328p.gcb` | Finds how the touch panel is wired to the shield, and shows raw touch readings |
| `Touch_Setup\Touch_Calibrate_ILI9341_mega328p.gcb` | Touch calibration: shows the four `TOUCH_RAW_` constants for the ATmega328P program |
| `Touch_Setup\Touch_Calibrate_ILI9341_LGT8F328P.gcb` | Touch calibration: the same, for the LGT8F328P program |
| `Simple_Loggers\SD_DataLogger_mega328p.gcb` | The first step: every 5 s, `ReadAD(AN1)` to `DATALOG.TXT`, with no clock and no display |
| `Simple_Loggers\SD_RTCLogger_mega328p.gcb` | The second step: the same with the DS1307, to `RTCLOG.CSV`, with no display |
| `SD_Card_Test\SD_Test_mega328p.gcb` | A test of the SD card and FAT methods, with one line per check on the serial terminal |

The two simple loggers show the logging on its own. The finished demonstrations build on them.

## Hardware

- **Microcontroller board:** an Arduino Uno (ATmega328P, 16 MHz, 5 V), or an LGT8F328P Uno-style board (32 MHz,
  3.3 V).
- **Deek-Robot data logging shield v1.0:** the SD card on the SPI (chip select D10), and a DS1307 on the I2C
  (SDA A4, SCL A5) with a CR1220 battery.
- **ILI9341 8-bit "UNO" display shield** (320 x 240), with a 4-wire resistive touch panel. Its 8-bit display bus is
  on D2 to D9. Control: RD A0, WR A1, RS A2, CS A3, RESET A4. Touch: XP D8, XM A2, YP A3, YM D9.
- **Serial terminal:** the USB serial port of the board, at 9600 bps.

On these shields, A4 is both the RESET of the display and SDA of the DS1307, so each I2C transfer resets the display.
The programs read the DS1307 only at the start, when the clock is set, and once an hour. Between reads, Timer1 keeps
the time, and the screen is started again after each read.

## Before you compile

- **Libraries:** these programs need `sd_card.h` (1.1), `sd_card_avr.h`, `sd_fat.h` (1.2) and `touch_4wire.h` in
  `C:\GCstudio\gcbasic\AdditionalLibraries`. Each program finds them with
  `#option IncludePath "C:\GCstudio\gcbasic\AdditionalLibraries"`, which needs GCBASIC build 1661 or later. If the
  libraries are in another folder, change that line.
- **Flash:** both finished demonstrations are close to full. The ATmega328P program keeps 1 KB for the Optiboot
  bootloader (`#option ReserveHighProg OPTIBOOT`). The LGT8F328P program must end below 0x7400, and it has only a
  few words to spare.

## Getting the finished demonstration running

1. **Find the touch wiring (only if your shield is different).** `Touch_Probe_mega328p.gcb` reports which of A0 to A3
   joins which of D6 to D9. The programs use the usual MCUFRIEND wiring above.
2. **Calibrate the touch panel.** Run `Touch_Calibrate_ILI9341_mega328p.gcb` (or the LGT8F328P version) and tap the
   five crosses. Copy the four `#define TOUCH_RAW_...` lines it shows into the finished program.
3. **Compile and program the finished demonstration.**
4. **Set the clock.** Within 10 s of the start, send `T2026-11-09 14:30:00` from the terminal, or use the clock screen
   (menu button 4). A clock that is not running opens the clock screen.

## The finished demonstration

- **Main screen:** the time and date, the last sample, the lines written to and lost from `RTCLOG.CSV`, and a status
  line.
- **What is logged:** a line every 5 s on the seconds of the clock, `date,time,value`.
  - The ATmega328P logs its own temperature sensor (set `TEMP_OFFSET` from a thermometer).
  - The LGT8F328P has no temperature sensor, so it logs the number of taps.
  - Each tap is a line too: `date,time,touch,screen,raw x,raw y,button`.
- **A card pulled out and put back** is started again, and a `Restarted` line marks the lost samples.
- **Touch menu:**
  1. Start or stop logging. While logging is off, the samples are still counted and shown.
  2. Turn the screen round by 180 degrees.
  3. Black screen, until the next tap.
  4. Set the clock.
- **Clock screen:** the date, the time and the drift. Use `<` and `>` to choose a field, and `-` and `+` to change
  it. Hold `-` or `+` to step by 10. `OK` sets the clock and `X` cancels. The time on the screen keeps running, so
  `OK` sets the time that is shown.
- **Drift correction:** set the drift of the DS1307 in ppm (-250 to 250; + means the clock gains). Each hour, the
  program adds up the drift and moves the seconds of the DS1307 by one second each time a whole second has built up.
  The drift is kept in the battery-backed RAM of the DS1307. Measure it over a day or more: ppm = seconds gained /
  seconds gone x 1000000.
- **No DS1307:** the screen shows "No clock" where the time goes, and the program stops. The program checks the I2C
  pull-ups first, so a missing clock board is found at once.
- **The serial terminal** shows the start, each sample, each tap, the hourly clock read and each drift correction.
  Opening the serial port resets the board, and the program starts again (it adds to `RTCLOG.CSV`).
