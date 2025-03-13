# SI4703 FM Tuner Module

This repository contains code and resources for interfacing with the SI4703 FM Radio Tuner module. The SI4703 is a versatile FM radio chip that supports features such as RDS/RBDS decoding, stereo audio output, and signal strength measurement, making it ideal for projects involving FM radio functionalities.

## Features
- **FM Tuning Range:** 76–108 MHz
- **Digital Low-IF Receiver:** Improved performance with lower power consumption
- **RDS/RBDS Support:** Decode radio station information
- **Stereo Audio Output:** For a high-quality audio experience
- **Signal Strength Measurement:** Evaluate signal quality for better performance
- **I²C Communication Protocol:** Simple interfacing with microcontrollers

## Getting Started
Follow these steps to get started with the SI4703 module:

1. **Hardware Requirements:**
   - SI4703 module
   - Microcontroller 
   - I²C communication support
   - Connecting wires and breadboard

2. **Wiring:**
   Connect the module to your microcontroller as follows:
   - `SDA` to microcontroller SDA pin
   - `SCL` to microcontroller SCL pin
   - `3v3` power source to SI4703
   - `5v0` to OLED LCD and Microcontroller
   - `GND` to ground

image::Shema.png

3. **Software:**
   - Clone this repository to your local machine.
   - Upload the provided code examples to your microcontroller.

