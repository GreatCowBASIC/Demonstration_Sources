# GCBASIC USB demonstration: WinUSB with no driver to install

This is the LibK/WinUSB demonstration (`USB_LIBKWINUSB_18F14K50_Demonstration.gcb`), changed so that Windows
needs no driver for it. The device now answers Windows' Microsoft OS 1.0 descriptor requests ("WCID"), so
Windows 8.1 and later load their own WinUSB driver when the board is plugged in. The protocol has not
changed: the PC program sends the same vendor requests (LEDs on and off, LED state, port status, keep-alive).

## Files

| File | What it is |
|---|---|
| `WINUSB_<chip>_Demonstration.gcb` | The solution, one source per board: 18F14K50, 16F1454, 16F1455, 16F1459, 18F45K50, 18F4550, and the Starter Kit (18F46J50). Compile it with GCBASIC as usual (F6 in GCcode). |
| (`usb.h`) | GCBASIC's own `include\usb.h` (2026-10-19): it has `USB_WCID` and the PIC18 bank fix, so the programs use `#include <usb.h>`; there is no local copy any more. |
| `gcbversionnumber.cnt`, `.GCB` | The build counter the program includes. |
| `kit_base.h` | The Starter Kit's pins and APP_VDD soft start (a copy of GCBASICDemo\kit_base.h), for the 18F46J50 program. |
| `PC_Application\` | The Windows program `WinUSB_Demo_Program` (VB.NET, LibUsbDotNet; open `WinUSB_Demo_Program.sln`). It looks for 04D8:0052. |
| `WINUSB_DEMO_PROGRAM.exe`, `.exe.config`, `LibUsbDotNet.dll` | The built Windows program, ready to run. Its window title is "GCBASIC WinUSB Demo Program - no driver". |

The bootloader version of the Starter Kit demo (`WUSB_GCB.gcb` and `WUSB_GCB.HEX`, with the GCBASIC logo at start and
hold MENU 2 s to restart) is in `\\192.168.0.248\iso\MicroChip\PIC18FStartKit1\2026\GCBASICDemo`, with its
`gcb_logo.h` and `menu_restart.h`. Copy WUSB_GCB.HEX to the card's \GCBASIC folder: 10,136 bytes at
0xA000-0xC79B, so it fits the 23,552-byte program area with 13,412 bytes free.

The names say WinUSB, without a second "USB": the original was `USB_LIBKWINUSB_...` (USB, LibK, WinUSB), and
LibK is gone. The firmware's USB product name is "GCBASIC WinUSB <chip>".

## The boards

Every board uses the same protocol, USB ID and GUID: the requests 130 to 138 (red, yellow and green LEDs), 140 (the
four inputs) and 255 (keep-alive). Only the chip, its clock and its pins differ.

| Board | Clock | LEDs I/O 1 to 4 (keep-alive, red, yellow, green) | Inputs I/O 5 to 8 | Switches (PC app) |
|---|---|---|---|---|
| 18F14K50 | 12 MHz crystal, PLL | RC0, RC1, RC2, RC3 | RB4, RA3, RA4, RA5 | 1 (I/O 6) |
| 16F1459 | internal, PLL, active clock tuning | RC0, RC1, RC2, RC3 | RB4, RA4, RA3, RA5 | 1 (I/O 6 = RA4) |
| 16F1454 / 16F1455 | internal, PLL, active clock tuning | RC0, RC1, RC2, RC3 | RC4, RA4, RA3, RA5 | 1 (I/O 6 = RA4) |
| 18F45K50 | internal, PLL, active clock tuning | RA4, RA5, RC0, RC1 | RB4, RB5, RB6, RB7 | 4 |
| 18F4550 | 20 MHz crystal, PLL (PLLDIV 5) | RA4, RA5, RC0, RC1 | RB4, RB5, RB6, RB7 | 4 |
| 18F46J50 (PIC18F Starter Kit 1) | 12 MHz crystal, PLL | drawn on the OLED (GCBASIC GLCD library) | I/O 6 = MENU (RB0); 5, 7, 8 read 1 | 1 (I/O 6) |

- The 16F145x boards match the 16F1459: LEDs on RC0 to RC3, one switch on RA4 (I/O 6). The 16F1459 is pin-compatible
  with the 18F14K50 (the same LEDs; I/O 6 on RA4, I/O 7 on RA3). The 14-pin 16F1454/1455 have no PORTB, so their
  I/O 5 is RC4.
- The old LibK versions (16F145x: two LEDs and ADC values on requests 130 to 136; the 18F45K50 GCBlib demo: an I2C LCD
  and requests 100 to 105) are replaced. The originals are still in Demonstration_Sources.git.
- The PC app finds the number of switches in its `BoardSwitches` table, from the chip in the board's USB product name.
- The Starter Kit program is standalone (no `#option bootloader`): the kit has no user LEDs, so the four LEDs are
  circles on the OLED (filled when on), with the USB state and the MENU button. It also builds for the 18F47J53
  (the kit's pinout) with only its `#chip` line changed: 4,536 words, 1,918 bytes. There is no 18F47J50.

## In the program

```
#define USB_VID 0x04D8
#define USB_PID 0x0052
#define USB_REV 0x0100
#define USB_WCID
#define USB_WCID_GUID "{BFC2B144-FB5A-4F56-98AC-93BC164EED46}"
#include <usb.h>
```

- `USB_WCID` adds three answers: the OS string (string index 0xEE, "MSFT100" and the vendor code), the
  Extended Compat ID ("WINUSB") and the Extended Properties (`DeviceInterfaceGUIDs`).
- `USB_WCID_GUID` is required with `USB_WCID`. It must be 38 characters, and each solution needs its own.
- `USB_WCID_VENDOR_CODE` is the request code Windows uses to read the descriptors. It defaults to 0x20; it
  must not be one of the program's own request codes.
- Without `USB_WCID`, `usb.h` builds as before: the 15 Demonstration_Sources demos that use it give the same code,
  plus one `clrf BSR` at the start of the USB interrupt on PIC18 (the bank fix). Only the build-time strings differ.

## The USB ID

- 04D8 is Microchip's vendor ID: a published solution needs Microchip's permission for a PID under it,
  or a PID of its own from pid.codes (VID 1209).
- The bcdDevice is 0x0100. Windows asks for the OS string only once per VID, PID and bcdDevice, and
  remembers the answer. A device first seen without WCID is not asked again until the bcdDevice changes,
  or until the key `HKLM\SYSTEM\CurrentControlSet\Control\usbflags\04D800520100` is deleted.
- 1209:2006 stays with the LibK solution: the LibK driver's INF matches `VID_1209&PID_2006`.

## Recovery in the PC program

- **Unplug:** the device notification closes the device, and the screen shows "not connected".
- **Plug in again:** the 1 s timer looks for the device and opens it. The LED states are read again.
- **A failed transfer or a wrong keep-alive** (every 10 s): the device is closed and found again
  (`CloseDevice`). Before this change, transfer errors were ignored, and an empty keep-alive reply could throw.

## Sizes (GCBASIC build 1660, 18F14K50)

| Build | Program memory | RAM |
|---|---|---|
| LibK/WinUSB (the original) | 1,124 words | 419 bytes |
| WinUSB, no driver | 1,483 words | 461 bytes |

| WinUSB, no driver, other boards | Program memory | RAM |
|---|---|---|
| 16F1454 | 1,829 words | 716 bytes |
| 16F1455 | 1,834 words | 716 bytes |
| 16F1459 | 1,836 words | 716 bytes |
| 18F45K50 | 1,492 words | 717 bytes |
| 18F4550 | 1,479 words | 717 bytes |
| 18F46J50 (Starter Kit) | 4,534 words | 1,917 bytes |

## Tested

| Board | Status (2026-10-19) |
|---|---|
| 18F14K50 | Tested on the board: works (enumerates with WinUSB and no driver; the PC app connects, reads the LEDs and I/O 6) |
| 16F1454 | Tested on the board |
| 16F1455 | Tested on the board |
| 16F1459 | Tested on the board |
| 18F45K50 | Not tested yet (the pins RA4, RA5, RC0, RC1 and RB4-RB7 are not yet checked on a board) |
| 18F46J50 (Starter Kit) | Not tested yet (standalone: program it with a PICkit; it replaces the bootloader) |
| 18F4550 | Not tested yet (20 MHz crystal; the pins RA4, RA5, RC0, RC1 and RB4-RB7 are not yet checked on a board) |

To test a board:

1. Program its HEX (in `WINUSB_<chip>_Demonstration.build\`).
2. Plug it in. Device Manager should show it under "Universal Serial Bus devices", with WinUSB and no
   driver installed.
3. Start `WINUSB_DEMO_PROGRAM.exe` (or `PC_Application\VBProject\bin\Release\WINUSB_DEMO_PROGRAM.exe`). Check the LEDs, the port
   status and the keep-alive LED.
4. Unplug the board and plug it in again: the program should connect again.

The PC program was built with Visual Studio 2017's MSBuild (the project uses VB 14 syntax). Started with
no board, it runs and keeps looking for the device.
