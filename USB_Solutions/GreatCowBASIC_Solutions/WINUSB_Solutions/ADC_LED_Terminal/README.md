# ADC LED Terminal: the potentiometer on the LEDs

The PICDEM FS USB board (PIC18F4550) shows its potentiometer on its four LEDs, and a terminal on the PC shows the
reading and the LEDs over USB. WinUSB: no driver to install.

## Using it

1. Program the board with `WINUSB_18F4550_ADC_LEDs.gcb` (see [Compile and program](#compile-and-program)).
2. Turn the potentiometer: the LEDs D1 to D4 count with it, with or without a PC.
3. Plug the board into the PC and start `ADC_LED_Terminal.exe`. It waits for the board, then shows one line,
   updated five times a second:

```
GCBASIC WinUSB ADC LED Terminal v1.0.0
The PICDEM FS USB board's potentiometer (RA0, AN0) and its LEDs D1 to D4 (RD0 to RD3).
The board sets the LEDs to the top four bits of the reading. Q or Esc: quit.

18:04:14  Connected: GCBASIC WinUSB ADC LEDs
ADC  765 / 1023    74.8 %   3.74 V    LEDs  D4 [*] D3 [ ] D2 [*] D1 [*]   11 = 1011
```

| On the line | What it is |
|---|---|
| `ADC  765 / 1023` | The reading, 0 to 1023 (10 bits) |
| `74.8 %` | The reading as a part of the range |
| `3.74 V` | The reading in volts, for a 5 V supply |
| `D4 [*] D3 [ ] D2 [*] D1 [*]` | The LEDs: `[*]` on, `[ ]` off, as the board reports them |
| `11 = 1011` | The LEDs as a number, 0 to 15, and in binary (D4 to D1) |

- Unplug the board: the terminal says "The board was removed." and waits; plug it in again and it carries on.
- **Q** or **Esc** quits.
- With its output to a file or a pipe (`ADC_LED_Terminal.exe > log.txt`), the terminal writes a timed line for each
  new reading instead of one line in place.

![The terminal connected to the board: ADC 767 / 1023, 75.0 %, 3.75 V, LEDs D4, D2 and D1 on, 11 = 1011](ADC_LED_Terminal.png)

## The board

| | |
|---|---|
| Board | PICDEM FS USB Demo Board, 2004, PIC18F4550, 20 MHz crystal |
| Potentiometer | RV1 on RA0 (AN0), read with `ReadAD10`: 0 to 1023 |
| LEDs | D1, D2, D3, D4 on RD0, RD1, RD2, RD3 |
| The LEDs show | the reading / 64: its top four bits, 0 to 15, D1 the lowest bit |

The board does the work: its main loop reads the potentiometer about every 20 ms and sets the LEDs. The PC only
reads. To show a bar instead (0 to 4 LEDs lit), change the line `LEDValue = ADCValue / 64` in the main loop.

## USB

| | |
|---|---|
| USB ID | 04D8:0052, bcdDevice 0x0200 |
| Product name | "GCBASIC WinUSB ADC LEDs" |
| WinUSB device interface GUID | `{C1060DC6-E7CA-4011-AA82-B63E9A555A20}` |
| Request 150 | Three bytes: the reading (a Word, low byte first), then the LEDs (0 to 15) |
| Request 255 | The keep-alive: answers 255 |

The bcdDevice and the GUID are this solution's own: the WinUSB Demo Program (bcdDevice 0x0100) does not open this
board, and the terminal does not open the demonstration programs. The firmware copies the reading and the LEDs with
interrupts off, so the USB interrupt never sends half of one reading and half of the next.

## Compile and program

As GC Studio does: F6 (Make HEX), then F5 or Flash Previous with the programmer in `use.ini`. From a command prompt,
in `C:\GCstudio\gcbasic`:

```
GCBASIC.EXE "<path>\WINUSB_18F4550_ADC_LEDs.gcb" /NP /S:use.ini /F:N /P: /DO    (compile)
GCBASIC.EXE "<path>\WINUSB_18F4550_ADC_LEDs.gcb" /NP /S:use.ini /FO /DO         (program the HEX)
```

1,465 words of program memory and 660 bytes of RAM (GCBASIC build 1660).

## Files

| File | What it is |
|---|---|
| `WINUSB_18F4550_ADC_LEDs.gcb` | The firmware |
| `ADC_LED_Terminal.exe`, `LibUsbDotNet.dll` | The terminal, ready to run (.NET Framework 4) |
| `ADC_LED_Terminal.png` | The terminal's window, as above |
| `PC_Application\` | The terminal's source: VB.NET, `ADC_LED_Terminal.sln`, built with Visual Studio 2017. It uses `..\..\LibUsbDotNet.dll`; build from a local copy (MSBuild refuses a network drive's files). |

## Tested

2026-10-25, on the PICDEM FS USB board with the PIC18F4550: programmed with the PICKitPlus, enumerates as
04D8:0052 REV_0200 with WinUSB, the terminal connects and reads 763 to 767 with the LEDs at 11 (1011): the reading /
64, as the board shows it.
