# Insertion Sort — KS0108 GLCD Hardware Simulation

An insertion sort visualized on a 128×64 monochrome KS0108 graphic LCD, driven by GCBASIC's `SortArray()` on a PIC16F877 @ 20MHz. This folder includes both the GCBASIC firmware and a browser-based simulation that reproduces the firmware's drawing logic pixel-for-pixel, so you can see how it behaves before flashing real hardware.

## View the simulation

GitHub strips `<script>` tags from files rendered in its own preview, so opening the `.html` file directly on github.com will show blank content. Use one of these instead:

- **[Live preview via htmlpreview.github.io](https://htmlpreview.github.io/?https://github.com/GreatCowBASIC/Demonstration_Sources/blob/main/GLCD_Solutions/GLCD_Sort_Routime_Solutions/ks0108_hardware_loop_sim.html)** — opens and runs immediately, no download required.
- Or download [`ks0108_hardware_loop_sim.html`](./ks0108_hardware_loop_sim.html) and open it locally in any browser.

## What it does

- Simulates a 95-element array of random values (0–63), matching `ArraySize` and `ScreenHeight` in the firmware.
- Each element's screen column is computed with `Scale(posJ, 0, ArraySize - 1, 0, 127)`, exactly as the firmware does, including GCBASIC's integer-truncating rounding — so the same columns collide/skip in the simulation as they would on the real display.
- Draws using the same erase-then-redraw technique as the firmware: a full-height black `Line()` first, then the new bar on top.
- Runs the same `Do...Loop` structure as the firmware: `FillAndShuffle` → `DrawAll` → wait 1s → `SortArray()` → wait 4s → repeat, with `GLCDCLS` and `Box()` called only once at startup — not on every loop pass.
- Reproduces a real consequence of that last point: because the border is only drawn once, and every bar redraw wipes its full column before drawing, the top and side borders visibly erode over time. The bottom border is the one edge that survives indefinitely, since every bar's base pixel coincides with it.

This isn't a stylized approximation — the simulation's pixel framebuffer is the same shape and size as the physical display (128×64, 1 bit per pixel), and the drawing functions mirror the GCBASIC `Line()`/`Box()` calls directly.

## Array Size

The array size is limited by the largest contiguous amount of linear RAM. In the case of the 16F877 that is 95 bytes of RAM. The array will be larger on microcontrollers with large contiguous RAM.

## Hardware target

| | |
|---|---|
| MCU | PIC16F877 @ 20MHz |
| Display | KS0108-based 128×64 monochrome GLCD |
| Data bus | `PORTD.0`–`PORTD.7` |
| Control lines | `GLCD_CS1` `PORTB.1` · `GLCD_CS2` `PORTB.0` · `GLCD_RS` `PORTB.2` · `GLCD_Enable` `PORTB.5` · `GLCD_RW` `PORTB.4` · `GLCD_RESET` `PORTC.2` |

Adjust the `#DEFINE` pin mappings in the `.gcb` source to match your own wiring before compiling.

## Files

| File | Description |
|---|---|
| `ks0108_hardware_loop_sim.html` | Standalone browser simulation — no build step, no dependencies. |
| `*.gcb` | GCBASIC firmware source, compiled and run on the PIC16F877 target. |

## Building the firmware

Compile with [GCBASIC](https://gcbasic.com/) targeting `16f877, 20`. No external libraries beyond the built-in `<glcd.h>` are required.