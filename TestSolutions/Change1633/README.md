# Change1633 — MEGA_STRESS_TEST

A GCBASIC "language tour" test program for the PIC18F46Q35, plus a browser simulator that replays
its behaviour without needing hardware or the compiler.

## Files

| File | What it is |
|---|---|
| `MEGA_STRESS_TEST.gcb` | The GCBASIC source — a top-to-bottom tour of most language constructs (data types, Table/DATA, macros, overloaded Subs/Functions, interrupts, control flow, string/math functions, EEPROM, hardware PWM, I2C, watchdog), commented for someone learning the language. |
| `MEGA_STRESS_TEST_COMMON_MISTAKES.gcb` | A companion file showing common beginner mistakes and the compiler's actual error output for each. |
| `MegaStress_Simulator.html` | A standalone, no-install browser page that re-runs `MEGA_STRESS_TEST.gcb`'s logic in JavaScript — see below. |

## Opening the simulator

GitHub's own file viewer only ever shows `.html` files as source text, so clicking the file above will
**not** run it — open it one of these ways instead:

- **Local (most reliable):** clone or download this repo, then just double-click
  `TestSolutions/Change1633/MegaStress_Simulator.html` — it's a single self-contained file, no server or
  build step needed. Drag it into any browser tab if double-clicking opens the wrong app.
- **Straight from GitHub, no download:** open
  <https://htmlpreview.github.io/?https://github.com/GreatCowBASIC/Demonstration_Sources/blob/main/TestSolutions/Change1633/MegaStress_Simulator.html>
  — a preview proxy that fetches and renders the file live. If it ever shows blank, it's usually the
  proxy still catching up to a very recent push (try a hard refresh after a minute), or a browser
  extension blocking its cross-origin fetch — the local copy above always works regardless.

## What the simulator shows

It replays every `HSerPrint`/`HSerSend`/`HSerPrintList` line exactly as it would appear on a serial
terminal connected to EUSART1 (RC6, 9600 baud), alongside a live panel for the digital I/O, the
CCP1→RC0 PWM duty sweep, the I2C1 bus (correctly timing out — no device is wired to RC3/RC4 in this
program), and the watchdog. It's a behavioral re-implementation in JavaScript, not an instruction-accurate
emulator of the compiled `.hex` — a few genuinely hardware-dependent values (`Rotate`'s carry-in bit,
Timer1's post-wait count, `Loge`'s exact library rounding) are estimated and marked `≈`, explained in the
page's own footer.
