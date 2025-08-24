# LEGO Train Control System: Code and Hardware Analysis

## Overview
This document summarises the analysis of a GCBASIC program running on an ATmega328P microcontroller (for example, Arduino Uno compatible). The program controls a LEGO train layout using LEGO Power Functions (PF) via infrared (IR) and LEGO Network Protocol (LNP) for inter-device communication. It features a state machine for train movement, sensor-based detection, lap counting, and control of signals, crossings, and points.

The document covers:
- **Code Structure and Logic**: Key components, state machine, subroutines, and unused elements.
- **Hardware Connectivity**: Pin mappings, directions, and inferred connections based on code usage.
- **Additional Hardware Details**: Expanded based on project-specific components, sensors, signals, and modules.
- **Implementation Specifics**: Circuit details for train sensors, Feather LED functionality, and IR transmitter circuit (assuming VSLY5940 LEDs with BC337 driver) in the context of the system and real-world applications. Insights into the Emerson Crossing code, including 74HC595 usage.

## Code Analysis

### Program Structure
- **Main Program**:
  - **Initialisation**: Defines constants (for example, sensor pins, speeds, thresholds), declares variables, reads initial analogue sensor values (for potential calibration), sets initial states (for example, `State = 0`), and configures hardware.
  - **Main Loop**: A finite state machine (FSM) with states 0–5 managing train operations:
    - **State 0 (Idle)**: Handles lap input (button or LNP), resets signals/crossing, resends lap count.
    - **State 1 (Start)**: Closes crossing, waits for gates, starts train at drive speed (`DRIVE_SPEED = 11`).
    - **State 2**: Detects section 2, decrements laps, sets points/signals.
    - **State 3/4**: Transitions on sensors 3/4.
    - **State 5 (Slow/Stop)**: Slows train (`SLOW_SPEED = 13`), opens crossing, resets on sensor 1.
  - **Key Features**:
    - IR PF commands for motor control (speeds, brake).
    - Analogue sensor reads (`ReadAD`) with threshold (75) for train detection.
    - LNP for communication (for example, gate control, lap requests).
    - Button polling with debouncing; EEPROM for persistent lap counter.
    - Robustness: Repeats, delays, checksums, retries for IR/LNP reliability.

- **Supporting .H File (lnp_rxpin.h)**:
  - Implements LNP over single serial RX pin (bidirectional).
  - **Initialisation**: Sets USART (19200 baud, odd parity), interrupt for receive.
  - **Receive Handler**: Parses packets (start 0xF0, count, data, checksum) via states.
  - **Send Routines**: `SendOnRec` (byte send with conflict detection), `SendLNPPair`/`SendLNPPairWord` (packets with retries/delays).
  - Integrated via callback `LNPReceived` in main program.

### Unused Elements
- **Variables**:
  - `calVal1`, `calVal2`, `calVal3`, `calVal4`: Set from initial sensor reads but never used (unfinished calibration?).
  - `LNPRecState`: Declared but unused (likely typo; `LNPState` is used instead).
- **Constants**:
  - `PWM_Freq` (38): Defined but not used (IR modulation is hardcoded).
  - `PF_FWD_2`, `PF_FWD_4`, `PF_REV_4`: Speed constants unused (hardcoded speeds preferred).
  - `LIGHT_YELLOW`: Defined but not used in points commands.
- **Dead Code**:
  - `WaitForButton`: Defined but never called (replaced by polling in `CountPresses`).
  - `LNPDumpBuffer`: Debug subroutine unused.

These could be removed for optimisation without affecting functionality.

### Potential Improvements
- Implement sensor calibration using `calVal` variables.
- Add error handling for LNP conflicts or sensor failures.
- Optimise timings/delays for better performance.

## Port Usage Analysis (ATmega328P Connectivity)

The ATmega328P uses PORTB, PORTC, and PORTD. Pins are aliased (for example, `AN0` = ADC0/PC0, `DIGITAL_4` = PD4). Directions inferred from operations (for example, `ReadAD` = analogue input, `Set PIN On` = output).

### Pin Mapping Table

| Pin Alias          | ATmega328P Pin | Port/Bit | Direction      | Inferred Connection/Usage |
|--------------------|----------------|----------|----------------|---------------------------|
| SECTION_1 (AN0)   | ADC0 (A0)     | PC0     | Analogue Input  | Analogue sensor (white LED shining at phototransistor) for train detection in section 1. Threshold-checked for presence. Connected via three-pin servo connector. |
| SECTION_4 (AN1)   | ADC1 (A1)     | PC1     | Analogue Input  | Sensor for section 4 detection, similar setup with LED and phototransistor. |
| SECTION_2 (AN2)   | ADC2 (A2)     | PC2     | Analogue Input  | Sensor for section 2. |
| SECTION_3 (AN3)   | ADC3 (A3)     | PC3     | Analogue Input  | Sensor for section 3. |
| IR_OUT (DIGITAL_4)| Digital 4     | PD4     | Digital Output| IR LED (assuming four VSLY5940 LEDs in parallel, driven by BC337 transistor) for PF commands to train receiver. Multiple LEDs aimed for different areas (e.g., slowdown, start/stop). Resistor recommended per LED. |
| SIGNAL_DEPART (DIGITAL_2) | Digital 2 | PD2     | Digital Output| Departure signal (hacked servo Y lead: red to VCC/signal, green to GND/signal). High lights green, low lights red. |
| SIGNAL_PASS (DIGITAL_10) | Digital 10 | PB2     | Digital Output| Pass signal, similar hacked Y lead setup. |
| DISP_B0 (DIGITAL_5)| Digital 5     | PD5     | Digital Output| Bit 0 of 3-bit display (for example, LEDs for lap count 0–7) on separate Arduino with 7-segment display. |
| DISP_B1 (DIGITAL_6)| Digital 6     | PD6     | Digital Output| Bit 1 of display. |
| DISP_B2 (DIGITAL_7)| Digital 7     | PD7     | Digital Output| Bit 2 of display. |
| BUTTON (DIGITAL_3)| Digital 3     | PD3     | Digital Input | Pushbutton for lap input (active low, debounced) on separate Arduino. Pull-up resistor needed. |
| LNP_RX_PIN (DIGITAL_0) | Digital 0 (RX) | PD0 | Bidirectional | Single-wire LNP bus (USART RX/TX multiplexed). Linked via servo Y leads across Arduinos; power injected from USB. Connected to other devices (gates, points). Pull-up resistor for open-drain. |

### Additional Hardware Notes
- **Analogue Sensors (PORTC)**: PC0–PC3 for track sections; white LEDs (from Christmas lights) shining at 3 mm phototransistors. Housed in LEGO bricks: 1x1 Technic for LEDs, modified 1x1 headlight brick (part 4070: https://www.bricklink.com/v2/catalog/catalogitem.page?P=4070&idColor=11#T=C&C=11) for phototransistors. Wired to three-pin servo connectors (signal-white, +ve-red, -ve-black: https://techspacelearning.org/wp-content/uploads/2021/08/Standard-Component-Wiring-V6.pdf). PC4/PC5 unused.
- **Digital Outputs**: Mostly PORTD; bit-banged IR on PD4 (no hardware PWM used). Signals use hacked servo Y leads for red/green LEDs; red/amber/green signal has individual LEDs plus two whites for route feather.
- **Serial/LNP**: PD0 for half-duplex communication; interrupt-driven receive, direction override for send. RX pins linked via servo Y leads; power from USB. No TX connection (HSerPrint for debugging only).
- **Unused Pins**: PORTB (PB0/PB1/PB3–PB5), PORTC (PC4/PC5), PORTD (PD1/TX).
- **Power/Peripherals**: Standard 5V VCC/GND; internal 8MHz clock assumed. AREF for ADC (default internal reference). Large capacitors on servo-driving Arduinos to prevent brownouts.

## Expanded Hardware Details
- **Techspace Modules**: Custom components from Techspace Learning (https://techspacelearning.org/shop/), including Arduino kits with sensor shields, motors, LEDs, phototransistors, servos, shift registers, and displays. Extension kit adds thermistors, ultrasonic sensors, speakers, and steppers for enhanced control.
- **Emerson Crossing Module**: Single Arduino (Nano or Pro Micro) on servo shield (similar to Nano V3 sensor shield with servo ports: https://hackspark.fr/en/dev-tools/2072-sensor-shield-for-nano-v3-servos-arduino-compatible.html). Includes 8 Ohm speaker driven by BC337 for bell sounds, 74HC595 shift register to minimise wires under track. Servos: Geekservo 9g 270° (3.3-6V, 500g.cm torque, 270° rotation, dimensions 32x16x40 mm; compatible with LEGO: https://www.robotshop.com/products/geekservo-9g-270-servo-compatible-with-lego?qd=486877db9dda7b1c5e01e4e461ee2d5a).
- **Points Servo**: Small cheap servo; horn fits LEGO points lever, secured with bricks.
- **Additional Arduino**: Separate board (not in photos) for 7-segment display and button to control the system.
- **Train Setup**: Any LEGO Power Functions IR train; currently powered carriage at back pushing for better battery life.
- **IR Transmitter**: Assuming four VSLY5940 LEDs in parallel (940 nm, high-power for PF compatibility), driven by BC337 transistor for aimed control (e.g., slowdown and station areas). The BC337 amplifies the signal from DIGITAL_4/PD4, supporting higher current for multiple LEDs.
- **Wiring Standard**: Components use three-pin servo connectors (https://techspacelearning.org/wp-content/uploads/2021/08/Standard-Component-Wiring-V6.pdf); Y-leads for signals and LNP/power distribution.

## Implementation Specifics

### Circuit for the Train Sensors (Beam-Break with White LED and Phototransistor)
Based on the project description and standard electronics practices for optical beam-break sensors, the train sensors consist of two main parts: a white LED (emitter) shining light across the track to a phototransistor (receiver). When a train passes, it interrupts the light beam, causing a change in the phototransistor's output voltage. This voltage is read via the microcontroller's analogue input (e.g., AN0 to AN3 on the ATmega328P, which are pins A0 to A3 in Arduino terms). The code checks if the reading is below a threshold (75) to detect the train.

The sensors are housed in LEGO bricks (1x1 Technic for the LED, modified 1x1 headlight brick like part 4070: https://www.bricklink.com/v2/catalog/catalogitem.page?P=4070&idColor=11#T=C&C=11) and wired using three-pin servo connectors (signal: white wire to analogue input; +ve: red to 5V; -ve: black to GND: https://techspacelearning.org/wp-content/uploads/2021/08/Standard-Component-Wiring-V6.pdf). The phototransistor module includes a 10 kΩ resistor, as per the project's wiring standard.

The emitter (white LED) and receiver (phototransistor) are typically mounted opposite each other across the track to form the beam. The LED is powered continuously, while the phototransistor's output varies with light intensity.

#### Components
- **White LED (Emitter)**: From bulk sources like Christmas lights; forward voltage (Vf) ≈ 3-3.5V, current ≈ 20mA.
- **Phototransistor (Receiver)**: 3mm type (e.g., similar to PT334-6C or 3DU5C); sensitive to visible light from the white LED.
- **Resistors**:
  - For LED: 100-220 Ω (current-limiting; calculate as (5V - Vf)/desired current, e.g., (5-3.2)/0.02 = 90Ω → use 100Ω for safety).
  - For phototransistor: 10 kΩ (load resistor, as per project wiring; provides voltage drop for analogue reading).
- **Power**: 5V DC from the microcontroller (e.g., Arduino 5V pin) and GND.
- **Connector**: Three-pin servo cable for the phototransistor (signal to analogue pin, +ve to 5V, -ve to GND). The LED may use a similar connector or be hardwired separately.
- **Optional**: Capacitor (e.g., 0.1µF) across power for noise filtering if readings are unstable.

#### How It Works
- The white LED emits a constant beam of light.
- The phototransistor conducts more when light hits it (beam unbroken), pulling the voltage at the analogue pin higher (closer to 5V).
- When the beam is broken (train present), less light reaches the phototransistor, reducing conduction and dropping the voltage (closer to 0V).
- The ATmega328P's ADC reads this voltage (0-5V mapped to 0-1023 digitally). In code, low readings (<75) indicate detection.
- This is a simple voltage divider: The phototransistor acts as a variable resistor in series with the 10 kΩ load.

#### Circuit Description and Connections
The circuit is straightforward and passive (no amplification needed for short-range beam-break). The emitter and receiver are often separate modules.

1. **White LED (Emitter) Circuit**:
   - Connect the anode (+) to 5V via a 100-220 Ω resistor.
   - Connect the cathode (-) to GND.
   - If using a three-pin connector: +ve (red) to resistor/anode, -ve (black) to cathode, signal (white) unused or tied to +ve for power.

2. **Phototransistor (Receiver) Circuit**:
   - Collector (longer leg or non-tab side) to 5V (+ve red wire).
   - Emitter (shorter leg or tab side) to one end of 10 kΩ resistor and to the analogue input pin (signal white wire).
   - Other end of 10 kΩ resistor to GND (-ve black wire).
   - Base pin (if present) is unused (phototransistors often lack a base lead).

#### ASCII Schematic
```
Emitter (White LED):                  Receiver (Phototransistor):

5V ---[100-220Ω]--- LED Anode (+)     5V --- Collector (C)
                   |                                 |
                   LED Cathode (-) --- GND           Emitter (E) --- Analogue Pin (e.g., A0)
                                                     |
                                                     [10 kΩ]
                                                     |
                                                     GND
```

- Align the LED and phototransistor so the beam crosses the track (e.g., 1-2 cm gap).
- In LEGO: LED in one brick, phototransistor in opposite brick.

#### Notes and Variations
- **Sensitivity**: The 10 kΩ resistor sets gain; higher values (e.g., 22 kΩ) increase sensitivity but may saturate in bright ambient light. Test and adjust for your environment.
- **Power**: Ensure the microcontroller's 5V rail can supply enough current (LED: ~20mA per sensor; phototransistor: negligible).
- **Ambient Light Rejection**: The white LED is visible, so enclose in tubes (e.g., heat shrink or LEGO) to focus the beam and reduce interference.
- **Troubleshooting**: If readings are noisy, add a 0.1µF capacitor from analogue pin to GND. For longer range, use a brighter LED or lens.
- **Adaptations**: If using IR instead of white (for invisibility), swap to 940nm IR LED and matching IR phototransistor, but the project specifies white for visibility/ease.

### Feather LED Functionality
In the context of this LEGO Train Control System and real-world railway signalling, the **Feather LED** refers to two white LEDs integrated into the red/amber/green signal (likely the pass signal on DIGITAL_10/PB2). These LEDs mimic a UK railway **feather indicator** (or route/junction indicator), which informs the train driver of the route set at a junction or diverging track.

#### Real-World Context
In UK railway signalling, a feather indicator is a set of white lights (typically five or six in a line or arc) above or beside a main signal (red/amber/green). It indicates:
- **Route Selection**: Which path the points are set for at a junction (e.g., straight or diverging).
- **Operation**: Illuminated feather means a diverging route (e.g., left/right branch); off means the default straight route or no clearance. Different light positions indicate specific routes.

#### In the LEGO System
- **Function**: The two white Feather LEDs indicate whether the track points are set for the straight track (`TRACK_STRAIGHT`, value 0) or diverging track (`TRACK_DIVERGE`, value 4, e.g., a loop or siding).
  - Controlled via `SendPointsLNP` in the code:
    - `LIGHT_GREEN + TRACK_STRAIGHT` (value 3 + 0): Feather LEDs off, indicating straight track.
    - `LIGHT_FLASHING + TRACK_DIVERGE` (value 2 + 4): Feather LEDs on, indicating diverging track.
  - `PointsState` (updated in `LNPReceived`) tracks the points’ state, reflecting Feather LED status.
- **Connection**: Part of the red/amber/green signal, controlled via a 74HC595 shift register (on the Emerson Crossing Arduino) to manage multiple LEDs. Each Feather LED has:
  - Anode to shift register output (e.g., Q0), cathode to GND via a 220 Ω resistor.
- **Schematic (Simplified for One Feather LED)**:
  ```
  Shift Register Output (e.g., Q0) ---[220Ω]--- LED Anode (+)
                                    |
                                    LED Cathode (-) --- GND
  ```
- **Purpose**: Enhances realism by mimicking UK railway signalling, showing the operator (or STEM workshop participants) the track configuration. For example, green signal with Feather LEDs on means “proceed to diverging route.”
- **Educational Value**: Teaches railway signalling logic, linking software commands to physical outcomes.

### IR Transmitter Circuit (Assuming VSLY5940 LEDs with BC337 Driver)
The IR transmitter uses four VSLY5940 IR LEDs (940 nm, high-power for PF compatibility) in parallel, driven by a BC337 NPN transistor. This amplifies the signal from DIGITAL_4/PD4, supporting higher current for multiple LEDs. The LEDs are modulated at 38 kHz via bit-banging in the code.

#### Components
- **IR LEDs**: 4 x VSLY5940 (Vf ≈ 1.65V, If max 100mA continuous, pulsed up to 1A; narrow ±3° beam for range).
- **Transistor**: BC337 (NPN, Ic max 800mA).
- **Resistors**:
  - Base: 1-10 kΩ (e.g., 4.7 kΩ) to limit base current from MCU.
  - Per LED: 47-100 Ω (calculate for ~50-100mA per LED at 5V: (5V - 1.65V - Vce sat ~0.2V)/current, e.g., (3.15V)/0.05A = 63Ω → use 68Ω).
- **Power**: 5V DC.
- **Optional**: Flyback diode across LEDs if needed, but not for pure resistive load.

#### How It Works
- MCU pin high: Transistor on, LEDs light (modulated for IR pulses).
- Parallel LEDs share current; transistor handles total load (e.g., 200-400mA for 4 LEDs at 50-100mA each).

#### Circuit Description and Connections
- Common-emitter low-side drive: LEDs from 5V through resistors to collector; emitter to GND; base from MCU via resistor.

#### ASCII Schematic
```
5V ---[68Ω]--- LED1 Cathode ---|
5V ---[68Ω]--- LED2 Cathode ---|
5V ---[68Ω]--- LED3 Cathode ---| Collector (BC337)
5V ---[68Ω]--- LED4 Cathode ---|
                               |
All LED Anodes --- 5V          Emitter --- GND
                               |
MCU Pin (DIGITAL_4) ---[4.7kΩ]--- Base
```

- Aim LEDs for different track areas.
- Notes: Ensure heat dissipation for transistor if high duty cycle; test current to avoid overload.

### Emerson Crossing Code and 74HC595 Usage
The Emerson Crossing v12.gcb code manages the level crossing module, integrating LNP for communication, servo gates, LED signals, and bell sounds. It uses the 74HC595 shift register to expand I/O for controlling signal LEDs, minimizing wiring under the track.

#### Key Code Insights
- **Structure**: Initializes states and hardware (e.g., shift register off, PWM for sound, gates up). Main loop cycles through checking train arrival (via LNP), running lights for "Grey" and "Blue" directions (likely crossing sides), flashing train lights, moving gates, sending status, and debugging.
- **State Machines**: Separate FSMs for Grey and Blue lights (red safe/new, yellow, green) based on timers, train arrival, and gate positions. Gates move incrementally up/down via servo PWM.
- **Sound Playback**: Uses Timer1 interrupt to play bell waveforms from tables, modulating PWM on OCR0B for electronic/mechanical bell sounds when bells are ringing (during train approach or gates moving).
- **LNP Integration**: Receives train arrival commands (byte 1 with value 0/no train or non-0/train) and sends status (gates up, sides stopped).
- **Servo Gates**: Bit-banged PWM on Timer2 for four gates (on ANALOG_2-5, PC2-PC5). Positions defined (e.g., GATE_1_UP=91), incremented/decremented slowly.

#### 74HC595 Usage
- **Pins**: SR_DATA (ANALOG_0/PC0), SR_CLOCK (DIGITAL_13/PB5), SR_LATCH (DIGITAL_12/PB4).
- **Bits in ShiftReg3**: Controls LEDs for signals (e.g., GREEN_SR_B = ShiftReg3.3, RED_SR_G = ShiftReg3.2). Also used for flashing train lights (RED_3_1/RED_3_2=ShiftReg3.7/6).
- **Operation**: SRWrite shifts out a byte bit by bit (MSB first), toggling data and clock. UpdateShiftRegisters latches the output. Called in InitCrossing (off), RunTrainLights, RunLightsGrey, RunLightsBlue to reflect states.
- **Purpose**: Expands outputs to control multiple LEDs without dedicated pins, reducing under-track wiring to one LEGO plate thickness. Handles signals for both crossing directions and train lights.

This code confirms the module's role in coordinating crossing safety, with the 74HC595 enabling efficient LED control in a constrained LEGO setup.

This setup supports a modular LEGO train system with sensors, IR control, and networked peripherals.