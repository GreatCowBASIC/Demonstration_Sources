# Eight mTouch buttons the framework way: CVD in GCBASIC on the PIC16F1937

Programs, on Microchip's mTouch CVD Evaluation Board (assembly 02-02091, PIC16F1937 at 32 MHz) with the 8-button
sensor board (02-02094). In both, each of the eight LEDs lights while its button is touched:

| File | What |
|---|---|
| `mTouchCVD_8Buttons.h` | the library: the CVD reading, the filtering and the decoding, shared by both programs |
| `GCBASIC_mTouch_Framework_CVD_8Buttons_16F1937.gcb` | the LEDs only |
| `GCBASIC_mTouch_Framework_CVD_8Buttons_Serial_16F1937.gcb` | the LEDs, plus press / release lines and every button's delta on the serial port (section 7) |

It follows Microchip's **mTouch Framework v2.3** (mTouch SW Package 1.43), project
`mTouchCapDemos\PIC12F PIC16F Demos\02-02091-R3 CVD Eval Board\8 Buttons`, written in plain GCBASIC with no
interrupt routine of its own. The original sends its data to Microchip's mTouch GUI; the serial program sends plain
text instead.

The one-sensor version of the same method, for the Curiosity board, is
`GCBASIC_mTouch_Framework_CVD_Curiosity_board_16F1619.gcb` (`GCBASIC_mTouch_Framework_CVD_explained.md`). This
page covers what changes with eight sensors. The filtering, the jitter and the three-state decoding are the same.

## 1. The board

| Sensor | Pin | ADC channel | LED (on when low) |
|---|---|---|---|
| 0 | RA0 | AN0 | RC2 |
| 1 | RA1 | AN1 | RC1 |
| 2 | RA2 | AN2 | RC0 |
| 3 | RA3 | AN3 | RA7 |
| 4 | RA5 | AN4 | RA6 |
| 5 | RE0 | AN5 | RA4 |
| 6 | RE1 | AN6 | RD7 |
| 7 | RE2 | AN7 | RD6 |

These are the framework project's `MTOUCH_SENSOR0`-`7` and `LED0`-`7` (`main.c`, `LED_ON 0`). Microchip's firmware
runs the internal oscillator with the PLL (32 MHz) and has MCLR disabled. The program does the same with
`#CHIP 16F1937, 32` and `#CONFIG MCLRE_OFF`.

The sensor pins are left digital, as in the framework project (which sets every ANSEL register to 0). The ADC
multiplexer connects CHOLD to a pin whatever its ANSEL bit, so the program does not write ANSEL.

## 2. What changes with several sensors: the reference sensor

The Curiosity board has one sensor, so CHOLD has to be charged through the pad itself, then isolated on an empty
ADC channel while the pad is driven the other way.

With several sensors the framework charges CHOLD through **another sensor's pin**, the reference. Sensor *n* uses
sensor *n* − 1, and sensor 0 uses sensor 7 (`CVD_REFSENSOR_n` = `MTOUCH_INDEXMINUSONE_n`). The reference is a
driven output, so pointing the ADC multiplexer at it charges CHOLD to its level. Pointing the multiplexer at the
sensor then connects CHOLD straight to the sensor, with no isolate step:

```
// Scan A
CVDDrive CVDRefMask, CVDRefPort, 1          // reference high
ADCON0 = CVDRefChannel                      // CHOLD connected to it: charges high
Wait 1 us                                   // CVD_CHOLD_CHARGE_DELAY
CVDFloat CVDSensorMask, CVDSensorPort       // sensor (driven low until now) an input
ADCON0 = CVDSensorChannel                   // CHOLD connected to the sensor: the charge is shared
Wait 1 us                                   // CVD_SETTLING_DELAY
Set ADCON0.GO = 1
Wait While ADCON0.GO = 1
CVDDrive CVDSensorMask, CVDSensorPort, 1    // sensor driven high, ready for scan B
CVDPhaseA = ADRESL
CVDPhaseA_H = ADRESH

// Scan B: the same with the levels swapped - reference low (CHOLD low), sensor high; then the sensor low again
...
CVDRead = CVDPhaseB - CVDPhaseA + 1024
```

- **The order matters.** Each scan ends by driving the sensor to the level the next scan needs (the framework's
  `CVD_RS_EXIT_A` / `CVD_RS_EXIT_B`). After scan B every sensor is back to driven low, the idle state.
- **The reference is only driven.** Its pin stays an output the whole time, and it ends driven low, its idle state.
  Using a neighbour does not disturb its own reading, because every sensor is driven low between its readings.
- **The result** is the framework's `(B | 0x400) - A`, i.e. B − A + 1024. A touch raises it. (On the Curiosity board,
  with the pad itself as the reference, the sign came out the other way and had to be found by testing. Check this
  one the same way: if an LED goes *off* when its button is touched, swap the two scans.)
- **Channel and pin by number.** `ADCON0` for channel *n* is `n * 4 + 1` (CHS in bits 6-2, ADON on). The pin comes
  from the table `CVDPinMasks` (bit masks 1, 2, 4, 8, 32 on PORTA for sensors 0-4, then 1, 2, 4 on PORTE).
  `CVDDrive` and `CVDFloat` change only that bit of `LATx` / `TRISx`, so the LEDs on PORTA are not affected.
- **Nothing slow sits between connecting and `GO`.** The lookups and the `CVDDrive` / `CVDFloat` calls all happen
  while CHOLD is on the reference, or after the conversion. Between connecting CHOLD to the sensor and setting `GO`
  there is only the settling delay.
- **Interrupts are off** for the whole reading (`IntOff` / `IntOn`), so the `millis()` tick cannot stretch a step.

## 3. Filtering: the framework's decimation filter

Each reading moves the sensor's slew-limited value by at most `TOUCH_MAX_STEP` (10, the framework's
`MTOUCH_DECIMATION_MAX_STEP`). A reading within the step is taken as it is:

```
TouchUp = TouchValue + TOUCH_MAX_STEP
TouchDown = 0
If TouchValue > TOUCH_MAX_STEP Then TouchDown = TouchValue - TOUCH_MAX_STEP
If TouchRaw > TouchUp Then
    TouchValue = TouchUp
Else If TouchRaw < TouchDown Then
    TouchValue = TouchDown
Else
    TouchValue = TouchRaw
End If
```

The limits are worked out in Word variables before they are compared, and `TouchDown` cannot wrap below 0. The
eight values of a scan are summed. The Curiosity version uses a step of 1, as Microchip's Curiosity firmware does.
The framework's 10 follows a touch faster and still stops single spikes.

## 4. Eight sensors: arrays and one scan routine

Each sensor's state lives in arrays indexed by sensor number:

| Array | Type | Holds |
|---|---|---|
| `TouchFiltered` | Word | the slew-limited reading |
| `TouchBaseline` | Word | the untouched level |
| `TouchState` | Byte | 0 power-up, 1 released, 2 pressed |
| `TouchScans` | Word | scans counted for the power-up and the press time-out |
| `TouchBaselineScans` | Byte | scans counted for the baseline rate |

Two more arrays, `TouchSums` and `TouchDeltas` (Word), hold each sensor's last sum and its delta above the
baseline, for reporting.

`TouchScanSensor` scans one sensor. It copies that sensor's values into plain variables, works on them, and writes
them back. The decoding is then the same as the one-sensor code and easy to read:

- **0, power-up:** the baseline follows the sum for 30 scans (0.3 s).
- **1, released:** pressed when the sum is `TOUCH_PRESS` above the baseline. Otherwise the baseline moves 1/16 of
  the way towards the sum every 10th scan.
- **2, pressed:** released below `TOUCH_RELEASE`. Held for 1000 scans (10 s), it learns the baseline again.

`TouchService`, called in the main loop, scans all eight sensors every `TOUCH_PERIOD_MS` (10 ms, from `millis()`)
and sets `TouchNewScan` to 1 after a scan. The program then sets the LEDs (`TouchShowLeds`). A scan of all eight is
64 readings, each with its jitter delay, and takes a few milliseconds. All the times above are counted in scans, so
they are real times.

Each sensor has its own baseline and state, so a touch on one button does not affect the others, and each learns its
own untouched level. The pads differ in size and trace length.

## 5. GCBASIC details

- **`#OPTION Explicit`**, and each routine's variables have their own names (`CVD...` in `CVDRead`, `CVDDrive...`,
  `CVDFloat...`, `CVDLookup...`, `Touch...` in the decoding), because GCBASIC routine variables are global by name.
- **RAM is not cleared at reset:** every array element is set in the start-up loop, which also takes each
  sensor's first reading after the one-second LED flash. Keep your hands off the buttons during the flash and the
  0.3 s after it.
- **Arrays** `Dim TouchFiltered(TOUCH_SENSORS) As Word` are indexed 0 to 7.
- **`ReadTable CVDPinMasks, n + 1, ...`:** table entries count from 1.
- **The LEDs** are set by plain assignments (`LED0 = 1`, then `If TouchState(0) = 2 Then LED0 = 0`), never from a
  variable bit.
- **`CVDDrive`** works out `Not mask` into a variable once, then uses it for both `LATx` and `TRISx`.

Size: 1344 words of 8192 and 189 bytes of RAM of 512 (LEDs only); with the serial output 2339 words (text) or 1885
words (GUI format), 217 bytes.

## 7. The library and the serial program

`mTouchCVD_8Buttons.h` holds everything about touch: the settings, the per-sensor arrays, the pin table, the CVD
reading, the jitter and the decoding. A program includes it and makes three calls:

| Call | When | What |
|---|---|---|
| `TouchInit` | first | the ADC, and every sensor pin an output driven low |
| `TouchStart` | once the pads have settled, nothing on them | each sensor's first reading, then power-up learning |
| `TouchService` | in the main loop | scans all sensors every `TOUCH_PERIOD_MS`; `TouchNewScan` = 1 after a scan |

The results are `TouchState(n)` (0 learning, 1 released, 2 pressed), `TouchDeltas(n)`, `TouchSums(n)` and
`TouchBaseline(n)`. The settings (`TOUCH_PRESS`, `TOUCH_RELEASE` and the rest) are `#DEFINE`s at the top of the
library, so both programs share the same tuning. They are defined there only, not in the programs: in GCBASIC a
constant defined twice (once as a default inside `#ifndef`) warns "cannot be reassigned".

The serial program sends on the EUSART, TX on RC6, at 115200 baud 8N1, to a TTL / USB serial adapter. It has two
outputs, chosen by `#DEFINE SERIAL_MTOUCH_GUI`.

### `SERIAL_MTOUCH_GUI 1`: the mTouch one-way format, for mTouch Monitor

The mTouch Framework's one-way output (`mComm.c`, `MCOMM_UART_ONE_WAY`, decimal), the format Microchip's mTouch
One-Way GUI reads. View it with **mTouch Monitor** (section 8). Every 50 ms (`GUI_SCANS` 5 scans) one line is sent. Every field is zero-padded and followed by a comma, and
the line ends with CR LF:

```
00008,00000,000,08190,08201,08187,08597,08176,08199,08204,08188,
```

| Field | Digits | Here |
|---|---|---|
| state mask | 5 | bit *n* set while sensor *n* is pressed (`mTouch_stateMask`) |
| toggle mask | 5 | 0 (no toggle mode) |
| slider | 3 | 0 (no slider) |
| reading per sensor | 5 each | the sensor's last 8-reading sum (`TouchSums`) |

The field order is the framework's (`mComm_Service`), and its configuration notes that the GUI needs the state,
toggle and slider fields always present. Microchip's PIC18/PIC24 mTouch Library sends the same layout at 115200
baud. A line is 64 characters, about 5.6 ms at 115200, so a line every fifth scan leaves the scanning nearly
undisturbed.

### `SERIAL_MTOUCH_GUI 0`: text for a terminal

```
mTouch CVD 8 buttons, press 250, release 125
pad    8   9   A   B   C   D   E   F
d      3   0   1   0   2   0   0   1  ........
Pad B pressed
d      2   0   0 412   1   0   0   0  ...P....
Pad B released
```

- **Pads by their board labels**: sensor 0-7 is pad 8, 9, A-F (the table `PadLabels`), with a heading line of
  the labels at start-up.
- **A line for each press and release**, as it happens (`ReportChanges` compares each sensor's state with its state
  at the last scan).
- **Every 0.25 s** (`REPORT_SCANS` 25 scans), each button's delta above its baseline, right-aligned in four
  characters, then the states: `L` learning, `.` released, `P` pressed.
- **For tuning:** touch each button and read its delta. `TOUCH_PRESS` belongs well below the smallest touched delta
  and well above the largest untouched one, with `TOUCH_RELEASE` at about half of it.
- **Blocking output.** `USART_TX_BLOCKING` waits for each character. A delta line takes about 4 ms at 115200 baud,
  so the scan after it starts a little late. `TouchService` takes its time from `millis()`, so nothing is lost:
  the next scan is simply due 10 ms after that one.

## 6. Tuning

| What | Constant | Effect |
|---|---|---|
| Sensitivity | `TOUCH_PRESS`, `TOUCH_RELEASE` | 250 / 125 on the 8-reading sum to start with: lower is more sensitive; keep RELEASE at about half of PRESS |
| Slew limit | `TOUCH_MAX_STEP` | smaller filters more, larger follows a touch faster |
| Scan rate | `TOUCH_PERIOD_MS` | the times below scale with it |
| Power-up learning | `TOUCH_POWERUP` | scans before the baselines are fixed |
| Drift tracking | `TOUCH_BASELINE_RATE`, the `/ 16` | larger values follow drift more slowly |
| Stuck-press reset | `TOUCH_TIMEOUT` | scans pressed before learning again |
| Jitter | `TOUCH_JITTER_MASK` | larger spreads the readings more, but makes a scan longer |
| Charge and settling | the two `Wait 1 us` in each scan | longer is more sensitive but more open to noise |
| Polarity | `CVDPhaseB - CVDPhaseA` | swap the scans if the LEDs are inverted |

The framework project uses a press threshold of 700 on a different scale (30 samples, halved). Expect to adjust
`TOUCH_PRESS` and `TOUCH_RELEASE` on the board.

## 8. mTouch Monitor: the PC side

`mTouch_Monitor.html` replaces Microchip's mTouch One-Way GUI. It is one page with no other files, for Chrome or
Edge (Web Serial). Start it with `mTouch_Monitor.cmd`, which serves it on `http://localhost:8765` with Python and
opens it. Close any terminal that has the COM port open, press **Connect**, and choose the port (115200).

- A tile per pad, labelled as on the sensor board (sensor 0-7 = pad 8, 9, A-F): pressed / released / learning,
  delta, value, min and max. Click a tile to show or hide its line.
- A live graph of the deltas or raw values over 5-60 s, with Pause and a hover read-out.
- **Zero** takes a new baseline from the next 20 lines; **Record** / **Save CSV** saves the lines.
- It reads `mask,toggle,slider,values...` with `,` or `;`, padded or not, up to 12 pads.
