# Change1660 - DIM ... AT location OVERRIDE

Build 1660 (`gcbasic.bas`, `variables.bi`, `messages.dat`). `Override`, written after `At location`
in a `Dim`, marks an intended overlap of a fixed location: the compiler gives no
`Memory location specified for ... may be invalid` warning for that one variable. Each overlapping
`Dim` must say `Override` itself, the first one too (the compiler, not the order in the source, decides
which variable is given the location first) - there is no global switch, so an accidental overlap still warns.
Made for the PIC18F Starter Kit 1 bootloader's optimised fork (RAM purposely allocated to parts
that are never in use at the same time: about 1,140 bytes more free).

| File | Behaviour demonstrated |
|---|---|
| `Override_Demo_18F46J50.gcb` | The demo: a 512-byte transfer buffer and a 64-entry name list purposely allocated to the same RAM, every location relative to one constant. No warnings; TRANSFERBUFFER / NAMELIST at 0x400, NAMEKIND at 0x701 |
| `Override_Basic_16F877A.gcb` | Mid-range PIC (banked RAM): two buffers at 0xA0, no warnings |
| `Override_Basic_mega328p.gcb` | AVR: two buffers at 0x200, no warnings |
| `Override_NoOverride_Warning_18F46J50.gcb` | Without `Override` the overlap still gives the one warning (for BUFFERB) |
| `Override_InitialValue_18F46J50.gcb` | `Override` before `= value`: no warnings, COUNTER at 0x400 |
| `Override_VariableNamedOverride_18F46J50.gcb` | A variable called `Override` is unaffected |
| `Override_WithoutAt_Error_18F46J50.gcb` (`#SKIPTEST`) | `Override` without `At`: the one expected `OverrideWithoutAt` error |

All compile and assemble except the one marked `#SKIPTEST`; `Override_NoOverride_Warning_18F46J50.gcb`
compiles with its one expected warning.

## SSD1306 (glcd_SSD1306.h / glcd.h, build 1660)

New for GLCD_TYPE_SSD1306, _32 and _64x32: `GLCDRotate LANDSCAPE | LANDSCAPE_REV` (180 degrees in the controller),
`GLCDSetDisplayInvertMode` / `GLCDSetDisplayNormalMode`, `GLCD_SSD1306_CONTRAST` (the contrast at InitGLCD, default
0xCF) and `SSD1306_SendBufferRun(col1, col2, page)`; in Full GLCD mode `Line` (horizontal and vertical), `Box` and
`FilledBox` write whole bytes, one I2C transaction per page that changes.

| File | Behaviour demonstrated |
|---|---|
| `SSD1306_Demo_16F18326.gcb` | The 16F18326 demonstration (`Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18326_ChipRange_Demonstrations\26_GLCD_I2C_Devices_SSD1306.gcb`): text, shapes, the pot, a bouncing ball moved with `SSD1306_SendBufferRun` (221 frames per second on the board), contrast, invert and normal mode, rotate 180 degrees. The switch on RA2 moves to the next screen. Board-tested |

All 175 Demonstration_Sources programs that use GLCD_TYPE_SSD1306 / _32 / _64x32 compile with the new files.

## GCcode_Support/

Copies of the GCcode (VS Code extension) files updated alongside this change, for reference - they
are already applied to the live install at `C:\GCstudio\`, not meant to be extracted from here.
`install_GCcode_Support.cmd [GC Studio folder]` applies them to another installation (C:\GCstudio by default):
Override, the newer #option words, and (2026-10-19) GLCDSetContrast / GLCDSetDisplayInvertMode /
GLCDSetDisplayNormalMode in autocomplete, highlighting and SynWrite.
