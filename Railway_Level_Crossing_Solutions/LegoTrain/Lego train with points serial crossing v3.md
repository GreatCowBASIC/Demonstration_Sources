# LEGO Train Control System: Code and Hardware Analysis

## Overview
This document summarises the analysis of a Great Cow BASIC program running on an ATmega328P microcontroller (for example, Arduino Uno compatible). The program controls a LEGO train layout using LEGO Power Functions (PF) via infrared (IR) and LEGO Network Protocol (LNP) for inter-device communication. It features a state machine for train movement, sensor-based detection, lap counting, and control of signals, crossings, and points.

The document covers:
- **Code Structure and Logic**: Key components, state machine, subroutines, and unused elements.
- **Hardware Connectivity**: Pin mappings, directions, and inferred connections based on code usage.

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
| SECTION_1 (AN0)   | ADC0 (A0)     | PC0     | Analogue Input  | Analogue sensor (for example, photoresistor/hall) for train detection in section 1. Threshold-checked for presence. |
| SECTION_4 (AN1)   | ADC1 (A1)     | PC1     | Analogue Input  | Sensor for section 4 detection. |
| SECTION_2 (AN2)   | ADC2 (A2)     | PC2     | Analogue Input  | Sensor for section 2. |
| SECTION_3 (AN3)   | ADC3 (A3)     | PC3     | Analogue Input  | Sensor for section 3. |
| IR_OUT (DIGITAL_4)| Digital 4     | PD4     | Digital Output| IR LED (38 kHz modulated) for PF commands to train receiver. Resistor recommended. |
| SIGNAL_DEPART (DIGITAL_2) | Digital 2 | PD2     | Digital Output| Departure signal LED/relay (ON=green, OFF=red). |
| SIGNAL_PASS (DIGITAL_10) | Digital 10 | PB2     | Digital Output| Pass signal LED/relay. |
| DISP_B0 (DIGITAL_5)| Digital 5     | PD5     | Digital Output| Bit 0 of 3-bit display (for example, LEDs for lap count 0–7). |
| DISP_B1 (DIGITAL_6)| Digital 6     | PD6     | Digital Output| Bit 1 of display. |
| DISP_B2 (DIGITAL_7)| Digital 7     | PD7     | Digital Output| Bit 2 of display. |
| BUTTON (DIGITAL_3)| Digital 3     | PD3     | Digital Input | Pushbutton for lap input (active low, debounced). Pull-up resistor needed. |
| LNP_RX_PIN (DIGITAL_0) | Digital 0 (RX) | PD0 | Bidirectional | Single-wire LNP bus (USART RX/TX multiplexed). Connected to other devices (gates, points). Pull-up resistor for open-drain. |

### Additional Hardware Notes
- **Analogue Sensors (PORTC)**: PC0–PC3 for track sections; likely light/magnetic sensors. PC4/PC5 unused.
- **Digital Outputs**: Mostly PORTD; bit-banged IR on PD4 (no hardware PWM used).
- **Serial/LNP**: PD0 for half-duplex communication; interrupt-driven receive, direction override for send.
- **Unused Pins**: PORTB (PB0/PB1/PB3–PB5), PORTC (PC4/PC5), PORTD (PD1/TX).
- **Power/Peripherals**: Standard 5V VCC/GND; internal 8MHz clock assumed. AREF for ADC (default internal reference).

This setup supports a modular LEGO train system with sensors, IR control, and networked peripherals.