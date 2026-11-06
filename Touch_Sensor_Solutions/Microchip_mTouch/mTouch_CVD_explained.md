# How the mTouch demo works: CVD touch sensing in GCBASIC

Program: `GCBASIC_firmware_for_Microchip_Curiosity_board_16F1619.gcb` (version 1.05), on the Microchip Curiosity
board with a PIC16F1619 at 32 MHz. The touch pad is on **RC1 / AN5**, and **D6 (RA2)** lights while it is touched.

The method is the one used in Microchip's own Curiosity firmware. It was taken from a disassembly of that hex and
rewritten in plain GCBASIC.

## 1. The idea: capacitive voltage divider (CVD)

A touch pad is a small capacitor to ground, C<sub>PAD</sub>, and a finger makes it larger. The ADC has its own small
sample-and-hold capacitor, **CHOLD**. CVD measures C<sub>PAD</sub> by sharing charge between the two capacitors and
converting the resulting voltage. No extra components and no second pin are needed.

1. Charge CHOLD to one level (VDD or 0 V) through the pad pin.
2. Disconnect CHOLD (*isolate*), and drive the pad to the **opposite** level.
3. Make the pad an input and connect CHOLD to it again. The two capacitors share their charge:

   ```
   CHOLD charged high, pad low:   V = VDD x CHOLD / (CHOLD + CPAD)
   CHOLD charged low,  pad high:  V = VDD x CPAD  / (CHOLD + CPAD)
   ```

4. Convert at once, before the charge leaks away.

The demo takes two phases with opposite polarities and subtracts them, so a reading is **differential**:

- Noise and drift common to both phases (supply ripple, mains pick-up, temperature) cancel out.
- The change caused by a finger adds up, because it moves the two phases in opposite directions.

## 2. The ADC registers used directly

`ReadAD` cannot do CVD, because it selects the channel, waits for acquisition and converts as one step. `CVDRead`
writes the ADC registers itself. The `#DEFINE`s name the values:

| Constant | Value | Meaning |
|---|---|---|
| `CVD_PAD` | `0x15` | `ADCON0`: channel AN5 (the pad), ADC on. This connects CHOLD to the pad |
| `CVD_ISOLATE` | `0x41` | `ADCON0`: channel 16, which has no pin, with the ADC on. This disconnects CHOLD from the pad, so it keeps its charge while the pad is driven the other way |
| `CVD_ADCON1` | `0xA0` | `ADCON1`: right justified, ADC clock Fosc/32 (1 µs at 32 MHz) |

`CVDRead` saves `ADCON1`, sets its own value and restores it at the end. It also turns the ADC off (`ADCON0.ADON = 0`),
so the `ReadAD(AN4)` call in the main loop (the potentiometer) is not affected.

## 3. One reading: `Function CVDRead As Word`

```
IntOff                                  // nothing may stretch the timing between the steps

// Phase A
Set LATC.1 = 1                          // pad driven high (it is an output)
ADCON0 = CVD_PAD                        // CHOLD connected to the pad: charged high
ADCON0 = CVD_ISOLATE                    // CHOLD disconnected, keeps its charge
Set LATC.1 = 0                          // pad driven low: pad capacitance discharged
Set TRISC.1 = 1                         // pad becomes an input (floating)
ADCON0 = CVD_PAD                        // CHOLD connected again: the charge is shared
Set ADCON0.GO = 1                       // convert at once
Wait While ADCON0.GO = 1                // wait until the conversion is done
Set LATC.1 = 1                          // only now drive the pad again
Set TRISC.1 = 0
CVDPhaseA = ADRESL
CVDPhaseA_H = ADRESH

// Phase B: the same with the levels swapped (CHOLD low, pad high)
...
IntOn
CVDRead = CVDPhaseA - CVDPhaseB + 1024
```

Implementation points:

- **No waits between the steps.** Every instruction between connecting CHOLD and setting `GO` lets the charge leak,
  so the steps follow each other directly, and interrupts are off (`IntOff` / `IntOn`) for the whole measurement.
- **Drive the pad again only after the conversion has finished.** The ADC samples CHOLD about one ADC clock after
  `GO` is set. Microchip's code drives the pad straight after `GO`, which works only with its Fosc/2 clock (and Fosc/2
  is out of specification at 32 MHz). With Fosc/32 that clock is 1 µs, so the pad drive reached CHOLD before the
  sample was taken and overwrote the shared voltage. The result was D6 stuck on at power-up and inverted after a
  reset. Waiting for `GO` to clear first is safe with any ADC clock.
- **Reading a 10-bit result into a Word.** `CVDPhaseA = ADRESL` sets the low byte (and clears the high byte), then
  `CVDPhaseA_H = ADRESH` sets the high byte. `_H` is GCBASIC's name for the high byte of a Word variable.
- **The function returns its value through its name** (`CVDRead = ...`). A GCBASIC Function has input-only
  parameters, so this one needs none.
- **The sign was found by test.** For an ideal pad the charge equations above say phase B rises with a touch. On the
  Curiosity board, though, B - A *fell* with a touch, which left D6 inverted. The board's pad circuit and the moment
  the sample is taken decide which phase moves more, so the program uses **A - B**. On other hardware, check the sign
  first: touch the pad, and if D6 goes off instead of on, swap the two phases.
- **The `+ 1024` offset** keeps the result positive. Each phase is 0-1023, so A - B is between -1023 and +1023, and a
  Word cannot hold a negative number. With the offset the reading is 1 to 2047, centred on 1024.

## 4. Filtering and the decision: `Sub ReadmTouch`

`ReadmTouch` is called every 64 passes of the main loop. Each call:

1. **Takes eight readings through a slew-rate limiter.** Each raw reading moves `TouchFiltered` by at most 1 count
   towards it:

   ```
   If TouchRaw > TouchFiltered Then TouchFiltered++
   If TouchRaw < TouchFiltered Then TouchFiltered--
   TouchSum = TouchSum + TouchFiltered
   ```

   A single noise spike, however large, moves the value by only one count, while a real touch keeps pushing it the
   same way and gets through within a few calls. The sum of the eight filtered values (about 8 x 1024 = 8192, which
   fits easily in a Word) is the signal used from here on.

2. **Works out the delta**, how far the sum is above the baseline. It is 0 when the sum is below the baseline, so a
   Word never wraps round:

   ```
   TouchDelta = 0
   If TouchSum > TouchBaseline Then TouchDelta = TouchSum - TouchBaseline
   ```

3. **Runs a three-state machine with hysteresis:**

   | `TouchState` | Meaning | Change |
   |---|---|---|
   | 0 | start | the first sum becomes the baseline; go to 1 |
   | 1 | released | delta >= `TOUCH_PRESS` (250) gives pressed (2) |
   | 2 | pressed | delta < `TOUCH_RELEASE` (125) gives released (1) |

   The gap between the press and release thresholds is the hysteresis: a finger resting near the threshold does not
   make D6 flicker. 250 on the sum of 8 is about 31 counts per reading.

4. **Lets the baseline follow slowly, only while released:**

   ```
   If TouchState = 1 Then TouchBaseline = TouchBaseline - TouchBaseline / 16 + TouchSum / 16
   ```

   This is a 1/16 IIR filter: each call moves the baseline 1/16 of the way towards the current sum. It tracks slow
   drift (temperature, humidity, the supply) but cannot catch up with a press. It is frozen while pressed, so a long
   touch is not learned as the new "untouched" level. Each part is divided before adding, so nothing overflows a Word.
   The integer division only costs a count or two of accuracy.

5. **Drives the LED:** `LED6 = 0`, then `If TouchState = 2 Then LED6 = 1`. This uses no `LED6 = expression` with a
   variable bit, which can glitch the pin.

## 5. Start-up

RAM is not cleared at reset, so every touch variable gets an explicit start value: `TouchFiltered`, `TouchSum`,
`TouchBaseline` and `TouchState` are all set to 0. The pad pin is set up once: analog (`ANSELC.1 = 1`), driven low
(`LATC.1 = 0`), an output.

The first real reading is taken **after** the two-second LED flash, `TouchFiltered = CVDRead`. By then the pad and
supply have settled, and the slew limiter starts from a true value. The first call to `ReadmTouch` (state 0) then takes
the baseline from settled readings. **Keep your hand off the pad during the start-up flash**, or the touched level
becomes the baseline.

Two earlier faults came from this part:

- The filter started from a reading taken straight after power-up and could move only one count per sample, so the
  baseline came from an unsettled value.
- A `Dim X = 0` inside a routine runs on **every** call in GCBASIC, which reset a counter each pass in an earlier
  version. State that must survive between calls is a global, set once at the top of the program.

## 6. Other GCBASIC details in the program

- `#OPTION Explicit`: every variable must be `Dim`med. That catches a misspelt register or variable name that would
  otherwise become a new RAM variable without any warning.
- **Variable names are global.** Routine variables in GCBASIC are global by name, so each routine has its own prefix
  (`CVDPhaseA`, `CVDSaveADCON1` in `CVDRead`; `TouchCount`, `TouchRaw`, `TouchDelta` in `ReadmTouch`) and nothing is
  shared by accident.
- `#DEFINE USE_AD5 TRUE` (marked REQUIRED) keeps AN5 in GCBASIC's ADC channel handling. The other `USE_ADn` lines
  leave out the channels the program does not use, to save code.
- The rest of the main loop (switch S1 on D4, potentiometer to PWM3 on D7 through PPS) is independent of the touch
  code. The only shared thing is the ADC, which `CVDRead` saves and restores.

## 7. Tuning

| What | Where | Effect |
|---|---|---|
| Sensitivity | `TOUCH_PRESS` / `TOUCH_RELEASE` | Lower values react to a lighter touch, or through a thicker overlay; keep RELEASE at about half of PRESS |
| Response vs noise | the slew limit (1 count per reading) and the 8-reading sum | More readings per call, or a smaller step, filter more but react more slowly |
| Drift tracking | the `/ 16` in the baseline filter | A larger divider makes the baseline follow more slowly |
| How often | `PWMSetCounter MOD 64` in the main loop | A smaller divisor samples more often |
| Polarity | `CVDPhaseA - CVDPhaseB` | Swap the phases if D6 is inverted on other hardware |
| ADC clock | `CVD_ADCON1` | Any in-specification clock works, because the pad is not driven until the conversion is done |
