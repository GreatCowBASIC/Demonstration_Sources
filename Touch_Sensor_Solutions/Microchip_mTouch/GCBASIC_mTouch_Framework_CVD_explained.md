# mTouch the framework way: CVD touch sensing in GCBASIC

Program: `GCBASIC_mTouch_Framework_CVD_Curiosity_board_16F1619.gcb` (version 1.00), on the Microchip Curiosity
board with a PIC16F1619 at 32 MHz. The touch pad S3 is on **RC1 / AN5**, and **D6 (RA2)** lights while it is touched.

This is the robust implementation. It follows Microchip's **mTouch Framework v2.3** (mTouch SW Package 1.43,
`mTouchCVD_macroLibrary_PIC16F1.h`, `mTouch_macroLibrary_common.h`, `mTouch_config.h`), written in plain GCBASIC
with no library and no interrupt routine of its own.

The simpler implementation, as Microchip's original Curiosity firmware, is
`GCBASIC_firmware_for_Microchip_Curiosity_board_16F1619.gcb`, explained in `mTouch_CVD_explained.md`. Both use the
same measurement. This one adds what the framework does to make it reliable in a real product:

| Framework feature | Framework setting | This program |
|---|---|---|
| CHOLD charge delay | `CVD_CHOLD_CHARGE_DELAY` | `Wait 1 us` after CHOLD is connected to the driven pad |
| Settling delay | `CVD_SETTLING_DELAY` | `Wait 1 us` between connecting CHOLD to the floating pad and `GO` |
| Pad left alone while CHOLD may still be connected | `CVD_GO_DONE_DELAY` | wait for the conversion to finish, then drive the pad |
| Random delay between readings | `MTOUCH_JITTER_BITS 6` | `TouchJitter`: 0-63 loops from an 8-bit LFSR |
| Fixed scan rate | timer interrupt | a scan every 10 ms through `millis()` |
| Power-up learning | `MTOUCH_POWER_UP_SAMPLES 30` | the baseline follows the sum for 30 scans (0.3 s) |
| Slow baseline | `MTOUCH_BASELINE_RATE 10`, `MTOUCH_BASELINE_WEIGHT` | 1/16 every 10th scan, only while released |
| Press / release hysteresis | `MTOUCH_RELEASE_THRESH_FACTOR 0.5` | press 250, release 125 |
| Stuck-press reset | `MTOUCH_BUTTON_TIMEOUT 300` | a press held 1000 scans (10 s) learns the baseline again |

## 1. The measurement: capacitive voltage divider (CVD)

A touch pad is a small capacitor to ground, C<sub>PAD</sub>, and a finger makes it larger. The ADC's sample-and-hold
capacitor, **CHOLD**, is charged to one level, the pad to the other, and then the two are connected. They share
their charge, and the ADC converts the voltage they settle at:

```
CHOLD charged high, pad low:   V = VDD x CHOLD / (CHOLD + CPAD)
CHOLD charged low,  pad high:  V = VDD x CPAD  / (CHOLD + CPAD)
```

A reading takes both phases and subtracts them. Noise common to both phases (supply ripple, mains pick-up,
temperature) cancels, and the effect of a finger adds up.

## 2. One reading: `Function CVDRead As Word`

The ADC registers are written directly, because `ReadAD` selects, waits and converts as one step:

| Constant | Value | Meaning |
|---|---|---|
| `CVD_PAD` | `0x15` | `ADCON0`: channel AN5 (the pad), ADC on: CHOLD connected to the pad |
| `CVD_ISOLATE` | `0x41` | `ADCON0`: channel 16, no pin (the framework's `MTOUCH_AD_ISO_NOGO` for the 16F182x, the same value): CHOLD disconnected, keeps its charge |
| `CVD_ADCON1` | `0xA0` | `ADCON1`: right justified, Fosc/32, a 1 µs ADC clock (the framework's setting at 32 MHz) |

Phase A, step by step (phase B is the same with every level swapped):

```
Set LATC.1 = 1                  // pad driven high
ADCON0 = CVD_PAD                // CHOLD connected to the pad
Wait 1 us                       // CHOLD charges (CVD_CHOLD_CHARGE_DELAY)
ADCON0 = CVD_ISOLATE            // CHOLD disconnected, keeps its charge
Set LATC.1 = 0                  // pad driven low: its capacitance discharged
Set TRISC.1 = 1                 // pad an input (floating)
ADCON0 = CVD_PAD                // CHOLD connected again: the charge is shared
Wait 1 us                       // the shared charge settles (CVD_SETTLING_DELAY)
Set ADCON0.GO = 1               // convert
Wait While ADCON0.GO = 1        // until it is done
Set LATC.1 = 1                  // only now drive the pad again
Set TRISC.1 = 0
CVDPhaseA = ADRESL
CVDPhaseA_H = ADRESH
```

- **The delays.** CHOLD charges through the pin's resistance, and the shared charge needs a moment to settle.
  Without the delays the reading is not quite the charge-sharing value and is less sensitive. The framework
  warns that a longer settling time makes the reading more open to noise, so it stays short (1 µs; `Wait 1 us` is
  8 instruction cycles at 32 MHz).
- **Drive the pad again only after the conversion.** CHOLD stays connected for part of the first ADC clock after
  `GO`. The framework waits a delay worked out from the ADC clock (`CVD_GO_DONE_DELAY`, 3 NOPs at 32 MHz with a 1 µs
  clock). Waiting for `GO` to clear is the same idea, and is safe at any ADC clock.
- **Interrupts are off** for the whole reading (`IntOff` / `IntOn`), so the `millis()` interrupt cannot stretch a
  step. A pending tick is handled straight after `IntOn`, so no time is lost.
- **The ADC is restored.** `ADCON1` is saved and put back, and `ADCON0.ADON = 0`, so `ReadAD(AN4)` for the
  potentiometer is not affected.
- **The result:** `CVDRead = CVDPhaseA - CVDPhaseB + 1024`. The offset keeps it positive in a Word: 1 to 2047, about
  1024 at rest.
- **The sign was found by test.** The framework stores `(B | 0x400) - A`, i.e. B − A, and the charge equations say
  the same. On the Curiosity board, though, B − A *falls* with a touch, with or without the delays, which leaves D6
  inverted. So this program uses **A − B**. On other hardware, check first: if D6 goes off when you touch the pad,
  swap the two phases.

## 3. Jitter: `Sub TouchJitter`

Noise at a fixed frequency (a switching supply, a fluorescent lamp, PWM on the same board) can line up with readings
taken at a fixed rate, and then the noise no longer averages out. The framework breaks that up with a random delay
from an 8-bit linear feedback shift register (LFSR), and so does this program, before every reading:

```
If TouchJitterSeed.0 = 1 Then
    TouchJitterSeed = TouchJitterSeed / 2
    TouchJitterSeed = TouchJitterSeed Xor 0xB4
Else
    TouchJitterSeed = TouchJitterSeed / 2
End If
TouchJitterCount = TouchJitterSeed And TOUCH_JITTER_MASK
Do While TouchJitterCount > 0
    TouchJitterCount--
Loop
```

The seed starts at `0xA5`. Any value but 0 works, because an LFSR at 0 stays at 0. `TOUCH_JITTER_MASK` (`0x3F`)
gives 0-63 loops, the framework's 6 jitter bits. The delay is a `Do While` with a test first, so a count of 0 means
no delay.

## 4. A scan: `Sub ReadmTouch`

A scan is eight readings, each after its own jitter delay, through a **slew-rate limiter**. Each reading moves
`TouchFiltered` by at most one count towards it, and the eight filtered values are summed:

```
For TouchCount = 1 To 8
    TouchJitter
    TouchRaw = CVDRead
    If TouchRaw > TouchFiltered Then TouchFiltered++
    If TouchRaw < TouchFiltered Then TouchFiltered--
    TouchSum = TouchSum + TouchFiltered
Next
```

A noise spike, however large, moves the value by one count. A real touch keeps pushing it the same way. The sum,
about 8 x 1024, fits in a Word. The delta above the baseline is 0 when the sum is below it, so it never wraps round.

## 5. The decision: three states

| `TouchState` | Meaning | Each scan |
|---|---|---|
| 0 | power-up learning | `TouchBaseline = TouchSum`; after `TOUCH_POWERUP` (30) scans go to 1 |
| 1 | released | delta >= `TOUCH_PRESS` (250) gives pressed; otherwise every `TOUCH_BASELINE_RATE` (10th) scan `TouchBaseline = TouchBaseline - TouchBaseline / 16 + TouchSum / 16` |
| 2 | pressed | delta < `TOUCH_RELEASE` (125) gives released; held for `TOUCH_TIMEOUT` (1000) scans gives 0, learning again |

- **Power-up learning.** For the first 0.3 s the baseline simply follows the sum, so it ends at the settled
  untouched level, not at one early reading. Keep your hand off the pad during the start-up LED flash and this 0.3 s.
- **Hysteresis.** The release threshold is half the press threshold (the framework's
  `MTOUCH_RELEASE_THRESH_FACTOR 0.5`), so a finger resting near the threshold does not make D6 flicker.
- **Baseline.** It tracks slow drift (temperature, humidity, the supply) at 1/16 every 10 scans, which takes about
  1.6 s to follow, and it is frozen while pressed. Each part is divided before adding, so nothing overflows a Word.
- **Press time-out.** A press that lasts 10 s is taken as something left on the pad (water, an object). The program
  learns a new baseline with it there, so D6 goes off and touch works again around it. When it is removed the sum
  falls below the baseline, the delta is 0, and the baseline follows it back down.

## 6. Timing: `millis()`

The scan rate is fixed by time, not by the speed of the main loop:

```
TouchNowMs = millis()
TouchElapsedMs = TouchNowMs - TouchLastMs
If TouchElapsedMs >= TOUCH_PERIOD_MS Then
    TouchLastMs = TouchNowMs
    ReadmTouch
End If
```

The power-up time, the baseline rate and the time-out are all counted in scans, so they are real times (0.3 s,
1.6 s, 10 s) whatever else the main loop does. The subtraction goes into a Long variable before it is compared: a
Long sum or difference worked out inside an `If` comparison is not reliable in GCBASIC. Unsigned subtraction also
keeps working when `millis()` wraps round after 49 days.

`#include <millis.h>` sets up Timer0 and its interrupt with its own `#startup`. The program's `InitPPS` start-up
(PWM3 to RC5) is separate. HPWM uses Timer2, so nothing clashes.

## 7. GCBASIC details

- **`#OPTION Explicit`:** every variable is `Dim`med, so a misspelt name is an error, not a new variable.
- **RAM is not cleared at reset:** every touch variable (`TouchFiltered`, `TouchSum`, `TouchBaseline`,
  `TouchState`, `TouchScans`, `TouchBaselineScans`, `TouchJitterSeed`, `TouchLastMs`) gets its start value at the top
  of the program. A `Dim X = 0` inside a routine would run on every call.
- **Names are global:** each routine's variables have their own prefix (`CVD...` in `CVDRead`, `TouchJitterCount`
  in `TouchJitter`, `TouchCount` / `TouchRaw` / `TouchDelta` in `ReadmTouch`), so nested calls cannot clobber each
  other.
- **Block `If`s** wherever more than one statement depends on the condition. A single-line `If ... Then a : b` is
  not relied on.
- **Word halves:** `CVDPhaseA = ADRESL` then `CVDPhaseA_H = ADRESH` builds the 10-bit result.
- **The LED** is set with `LED6 = 0` and then `If TouchState = 2 Then LED6 = 1`, not by copying a variable bit to the
  pin.

Size: 1444 words of 8192, 97 bytes of RAM (the simpler program: 1110 words, 67 bytes).

## 8. Tuning

| What | Constant | Effect |
|---|---|---|
| Sensitivity | `TOUCH_PRESS`, `TOUCH_RELEASE` | lower values react to a lighter touch or a thicker overlay; keep RELEASE at about half of PRESS |
| Scan rate | `TOUCH_PERIOD_MS` | the times below scale with it |
| Power-up learning | `TOUCH_POWERUP` | scans before the baseline is fixed |
| Drift tracking | `TOUCH_BASELINE_RATE`, the `/ 16` | larger values follow drift more slowly |
| Stuck-press reset | `TOUCH_TIMEOUT` | scans pressed before learning again |
| Jitter | `TOUCH_JITTER_MASK` | larger spreads the readings more, but makes a scan longer |
| Charge and settling | the two `Wait 1 us` in each phase | longer is more sensitive but more open to noise |
| Polarity | `CVDPhaseA - CVDPhaseB` | swap the phases if D6 is inverted on other hardware |
