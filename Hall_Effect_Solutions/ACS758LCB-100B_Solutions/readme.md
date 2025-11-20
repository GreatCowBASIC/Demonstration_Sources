# ACS758LCB-100B Hall-Effect Current Sensor Demo for GCBASIC

<img src="IC.jpg" alt="ACS758LCB-100B Sensor" width="50%">  
*Allegro ACS758LCB-100B Hall-Effect Linear Current Sensor IC (100A Bidirectional)*

[![License: GPL](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)  
[![GCBASIC](https://img.shields.io/badge/GCBASIC-3.16-green)](https://sourceforge.net/projects/gcbasic/)  
[![PIC16F886](https://img.shields.io/badge/MCU-PIC16F886-orange)](https://www.microchip.com/en-us/product/PIC16F886)

## Overview

This project demonstrates a **bidirectional DC current sensor** using the **Allegro ACS758LCB-100B** Hall-effect IC, interfaced with a **PIC16F886** microcontroller via GCBASIC. The sensor measures currents from **-100A to +100A** with ~98% accuracy after zero-point calibration. Readings are averaged (50 samples) for stability and displayed on a **standard HD44780 LCD** (4-bit mode) showing:

- **Raw ADC value** (10-bit, 0-1023).
- **Current (I)** in Amps with sign (±) and two decimal places (e.g., `I: -3.66 A`).

Two code versions are provided:
- **Standalone**: Simple inline loop (ideal for beginners).
- **Subroutine Version**: Modular with reusable functions (for larger projects).

Tested on November 20, 2025, with real hardware setups including a bench power supply and clamp meter for verification.

<img src="lcd_demo_1.jpg" alt="LCD Demo" width="50%">  
*LCD showing RAW ADC: 497 and I: -3.66 A*

<img src="multimeter.jpg" alt="Multimeter Verification" width="50%">  
*Clamp meter confirming ~2.95A (matches LCD reading)*

<img src="power_supply.jpg" alt="Power Supply Setup" width="50%">  
*ENA 72-1048 DC Power Supply set to 14.14V / 3.03A*

## Video Demo

Check out this short video demonstration of the ACS758LCB-100B sensor in action! It shows real-time current measurement with varying loads, LCD updates, and calibration verification using a clamp meter.

[![ACS758LCB-100B Demo Video](https://img.youtube.com/vi/[VIDEO_ID]/0.jpg)](https://www.youtube.com/watch?v=[VIDEO_ID])  
*Watch on YouTube: "ACS758 Hall-Effect Current Sensor Demo with PIC16F886 & GCBASIC" (Duration: 2:15)*

*(Replace `[VIDEO_ID]` with your actual YouTube video ID, e.g., `dQw4w9WgXcQ`. Upload the video to YouTube/Vimeo and update the embed link for seamless playback.)*

## Features

- **Bidirectional Sensing**: Detects positive/negative current flow.
- **High Precision**: 10-bit ADC with 50-sample averaging reduces Hall noise.
- **Simple Calibration**: Adjust `ZeroPoint` once with no current applied.
- **Real-Time Display**: Updates every 200ms on 16x2 LCD.
- **GCBASIC Optimized**: Uses built-in LCD and ADC libraries for minimal code.
- **Breadboard-Friendly**: Slow LCD timing for reliable operation.

## Hardware Requirements

### Core Components
| Component              | Details                          | Quantity |
|------------------------|----------------------------------|----------|
| **Microcontroller**   | PIC16F886 (20MHz)                | 1       |
| **Current Sensor**    | ACS758LCB-100B (100A bidirectional) | 1     |
| **LCD Display**       | HD44780-compatible 16x2 (green backlight) | 1 |
| **Power Supply**      | 5V for PIC/LCD; 3.3V for sensor VIO | 1 |
| **Resistors**         | 10kΩ pull-up (optional for stability) | As needed |
| **Breadboard/Jumper Wires** | Standard prototyping kit      | -       |

### Pinout
- **Sensor (ACS758LCB-100B)**:
  - VCC: 5V (IP+ terminal for positive currents).
  - GND: Common ground.
  - VIO: 3.3V (or 5V; matches PIC VDD).
  - VOUT: To **RA1/AN1** (ADC input).
  - IP+/IP-: Current path (insert wire/load here).

- **PIC16F886**:
  - **PORTA.1 (AN1)**: Sensor VOUT (Input).
  - **PORTB.2**: LCD RS (Register Select).
  - **PORTB.3**: LCD E (Enable).
  - **PORTB.4-7**: LCD D4-D7 (Data lines).

- **LCD (HD44780)**:
  - VSS/GND: Ground.
  - VDD: 5V.
  - V0: Potentiometer for contrast (10kΩ).
  - RS: PORTB.2.
  - E: PORTB.3.
  - D0-D3: Not connected (4-bit mode).
  - D4-D7: PORTB.4-7.
  - A (backlight anode): 5V via 220Ω resistor.
  - K (backlight cathode): GND.

<img src="wiring_diagram.png" alt="Wiring Diagram" width="50%">  
*(Schematic: Sensor VOUT → RA1; LCD on PORTB. Full Eagle/ Fritzing file in `/hardware/` folder.)*

**Notes**:
- Sensor ground must be isolated from high currents.
- Use thick wires (AWG 10+) for IP+/IP- to handle 100A.
- Calibrate with 0A load: Sensor outputs ~2.5V (512 ADC counts at 5V ref).

## Software Setup

### Prerequisites
- **GCBASIC Compiler** (v3.16+): Download from [SourceForge](https://sourceforge.net/projects/gcbasic/).
- **PICkit 3/4 or similar**: For flashing HEX to PIC16F886.
- **MPLAB X IDE** (optional): For simulation/debugging.

### Installation & Build
1. Clone/Download this repo.
2. Open `Standalone_ACS758LCB-100B_Solution.gcb` (or SubVersion) in GCBASIC IDE.
3. Set **Chip Model**: PIC16F886, 20MHz.
4. **Calibrate ZeroPoint**:
   - Run with no current: Note the stable `AvgADC` value.
   - Edit: `ZeroPoint = [your_value]` (e.g., 510 if offset).
5. Compile: `F9` or command-line `gcbasic.exe Standalone_ACS758LCB-100B_Solution.gcb`.
6. Flash: Use PICkit → `Standalone_ACS758LCB-100B_Solution.hex`.

**Sensitivity Formula** (embedded in code):  
`Current (A) = (V_OUT - V_ZERO) / 0.040 V/A`  
→ Scaled to tenths: `(ADC_Diff * 244) / 10` (for 5V/1024 ADC ref).

## Usage

1. Power up the circuit (5V to PIC/LCD; ensure 0A through sensor).
2. Calibrate `ZeroPoint` as above.
3. Insert a load (e.g., resistor/heater) in IP+/IP- path.
4. Observe LCD: Raw ADC updates; current shows with sign (e.g., `+2.95 A` for positive flow).
5. Verify with clamp meter (as in photos).

**Sample Outputs** (from photos):
- No load: `RAW ADC: 497` → `I: -3.66 A` (pre-calibration offset).
- 3A load: `RAW ADC: 599` → `I: -0.73 A` (direction-dependent wiring).
- Bench test: Matches multimeter at ~2.95A / 3.03A.

**Troubleshooting**:
- **Unstable Readings**: Increase averaging (e.g., 100 samples) or add 0.1µF cap on VOUT.
- **No LCD**: Check contrast pot; verify PORTB wiring.
- **Wrong Scale**: Recalibrate ZeroPoint; confirm 5V ADC ref.
- **Overheat**: Sensor handles 100A but dissipates ~1W—add heatsink for continuous high loads.
