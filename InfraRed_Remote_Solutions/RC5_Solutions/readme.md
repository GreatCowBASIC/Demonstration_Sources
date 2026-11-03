# RC5 Remote Control: Transmitter and Decoder (PIC16F1459 + PIC16F18877)

This is a pair of demonstrations posted by **Ralf Pagel** on the GCBASIC SourceForge discussion forum: a Philips **RC5** remote-control **transmitter** and an RC5 **decoder**. They work together, so one board can send the codes and the other can read and display them.

The original thread, "RC5-Transmitter + RC5-Decoder", is at:

**[https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/c5976fd74a/](https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/c5976fd74a/)**

Ralf's post, with the two attached files:

**[https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/c5976fd74a/?limit=25#8557](https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/c5976fd74a/?limit=25#8557)**

Author: Ralf Pagel. Licence: GPL. Version 1.0, dated 01.11.2026.

| File | What it does | Chip |
|---|---|---|
| `RC5-Transmitter.gcb` | Sends RC5 codes like a remote control. One button selects the command, a second button sends it. The address, toggle bit and command are shown on an LCD. | PIC16F1459, 16 MHz |
| `RC5-Decoder.gcb` | Receives RC5 codes from an IR receiver, decodes them and shows the address, toggle bit and command on an LCD. | PIC16F18877, 29.488 MHz |

---

## The RC5 code

An RC5 frame is 14 bits, sent most significant bit first, using Manchester coding on a 36 kHz carrier. Each bit lasts about 1.778 ms.

| Bits | Field |
|---|---|
| 2 | Start bits. The second start bit is the inverted bit 6 of the command ("field" bit), which allows commands 64 to 127 |
| 1 | Toggle bit |
| 5 | Device address (0 to 31) |
| 6 | Command (0 to 63, plus the field bit) |

The toggle bit stays the same while a button is held down. It changes when the button is released and the same or another button is pressed again. This is how a receiver tells "key held" from "key pressed again". While a key is held, the frame is repeated every 114 ms.

---

## RC5-Transmitter

### What it does

- **SW1** steps through the command number, 1 to 31, and wraps back to 1. The LCD shows the address, the toggle bit and the command.
- **SW2** sends the selected command. While SW2 is held, the same frame is sent every 114 ms (a 25 ms frame and an 89 ms gap), with the same toggle bit. When SW2 is released, the toggle bit flips for the next key press.
- The device address is set in the program (`addres = 19`).
- It was made to program a "learning" (programmable) remote control, as well as to test a device that expects RC5.

### Hardware (PIC16F1459, 16 MHz, HS oscillator)

| Pin | Use |
|---|---|
| PORTC.2 | IR LED output (`RC5Out`) |
| PORTC.0 | Red LED, on while a frame is sent (`LEDrt`) |
| PORTA.3 | SW1, select command (active low) |
| PORTB.7 | SW2, send command (active low) |
| PORTB.4 / PORTB.6 | I2C data / clock to the LCD (`LCD_IO 10`, 16 characters wide) |

### The `RC5Send` routine

The program contains its own copy of `RC5Send`, `RC5High` and `RC5Low`, copied from `include\lowlevel\remote.h` and adjusted (the `#include <lowlevel\remote.h>` line is commented out). The changes are:

- The 36 kHz carrier burst was 64 pulses and is now **32 pulses**; Ralf describes the old value as a mistake. The burst is now 7 us on and 21 us off, 32 times, about 0.9 ms.
- The gap was 88 x 10 us and is now **89 x 10 us**, and the carrier low time was 20 us and is now 21 us. Ralf notes the timing changes may depend on the oscillator frequency.
- The toggle bit is no longer flipped by the command. It is a parameter, `RC5Tggl`, so the program decides when it changes.
- Usage: `RC5Send (address, command, toggle)`.

Because it is a copy of the library routines, the program does not need the library's `RC5Send` to be changed.

---

## RC5-Decoder

### What it does

An IR receiver is wired to PORTC.3. Every edge on that pin raises an interrupt-on-change (IOC) interrupt. **Timer1** measures the time between edges, and a state machine in the interrupt turns the timings into the 14-bit code. When the last bit arrives, the main loop splits the code into the field bit, toggle bit, command and address, and shows them on the LCD.

- If no edge arrives for about 8.9 ms, Timer1 overflows. That resets the state machine and every variable involved, and the red LED flashes with the text "not recognized" on the LCD.
- The timing thresholds are wide, so it keeps working near other IR transmissions.
- The interrupt routine is a GCBASIC translation of the XC8 decoder at [simple-circuit.com](https://simple-circuit.com/mplab-xc8-rc5-remote-control-decoder/), which also explains the state machine in detail.

### Hardware (PIC16F18877, 29.488 MHz)

| Pin | Use |
|---|---|
| PORTC.3 | IR receiver input |
| PORTB.2 | Green LED, toggles on every edge (`LEDgn`) |
| PORTB.1 | Red LED, flashes when a code is not recognised (`LEDrt`) |
| PORTD.4 to PORTD.7 | LCD data DB4 to DB7 (`LCD_IO 4`) |
| PORTD.0, PORTD.1, PORTD.2, PORTD.3 | LCD RS, RW, enable and backlight |

The LEDs are connected through 1 K resistors.

### Clock and bootloader

- The clock is a 7.372 MHz crystal with the PLL x4, giving 29.488 MHz and a 7.372 MHz instruction clock. The odd frequency comes from the bootloader Ralf uses (`#option Bootloader 0x200`).
- If you use another clock frequency, change `short_time`, `med_time`, `long_time`, and possibly the Timer1 prescaler (`T1CLK`). The values in the program are for 7.372 MHz: 700 us, 1200 us and 2000 us.
- Without a bootloader, remove the `#option Bootloader 0x200` line.

### A note on the 16-bit constant

The decoder sets and clears bit `13 - bit_nbr` of a 16-bit code with `0x8001 << (13 - bit_nbr)`. The `<<` is compiled as a call to `FnLSL`. A constant up to 255, such as `0x01`, is a Byte, so `FnLSL(0x01, 13)` is a Byte shift and the bits shifted past bit 7 are lost. Ralf uses `0x8001`, which is larger than 255, so the Word version is used. Bit 15 is not part of an RC5 code, so the extra bit does no harm. Writing `[word]0x01` has the same effect: see the FnLSL page in the GCBASIC Help.

---

## Compiler check

Both programs were compiled and assembled with GCBASIC build 1665 and GCASM. They compile without errors or warnings:

| Program | Chip | Program memory | RAM |
|---|---|---|---|
| `RC5-Transmitter.gcb` | 16F1459 | 713 of 8192 words (8.7%) | 31 of 1024 bytes |
| `RC5-Decoder.gcb` | 16F18877 | 1527 of 32768 words (4.66%) | 53 of 4096 bytes |

This is a compile check only. Ralf has tested the pair on his own hardware; the programs have not been run on other boards here.

## Using the pair

1. Build the transmitter with a 36 kHz IR LED on PORTC.2 and the two buttons, and the decoder with a 36 kHz IR receiver module on PORTC.3.
2. Programme each board with its own file.
3. Point the transmitter at the receiver, press SW1 to choose a command and hold SW2 to send. The decoder shows `Adr`, `Tgl` and `Cmd`. Release SW2 and press it again: `Tgl` changes.
4. Change `addres` in the transmitter to try another device address.
