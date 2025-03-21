# SI4703 FM Tuner Module

This repository contains code and resources for interfacing with the SI4703 FM Radio Tuner module.&#160;&#160;The SI4703 is a versatile FM radio chip that supports features such as RDS/RBDS decoding, stereo audio output, and signal strength measurement, making it ideal for projects involving FM radio functionalities.

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

2. **Wiring for SI4703:**
   Connect the module to your microcontroller as follows:
   - `SDA` to microcontroller SDA pin
   - `SCL` to microcontroller SCL pin
   - `SEN` to microcontroller allocated SEN pin
   - `RST` to microcontroller allocated RESET pin
   - `3v3` power source to SI4703
   - `GND` to ground

3. **Software:**
   - Clone this repository to your local machine.
   - Upload the provided code examples to your microcontroller.
   - There are different demos
      - GLCD

         Si4703 with a SSD1306 GLCD

      <div style="text-align: center;">
      <img src="Si4703_GLCD_Demo.gif" alt="The schema" width="300">
      </div>

      - LCD

         Si4703 with 1602 LCD

      <div style="text-align: center;">
      <img src="Si4703_TM_1638_Demo.gif" alt="The schema" width="300">
      </div>

      - TM1638

         Si4703 with TM1638 unit

      <div style="text-align: center;">
      <img src="Si4703_TM_1638_Demo.gif" alt="The schema" width="300">
      </div>

   Si4703 with an 8-character LED module, 8 buttons, and 8 LEDs on a TM1638 chip.#160;&#160;

   Buttons 1 and 2 adjust the volume, 4 and 5 search for a radio station, 7 and 8 switch saved radio stations.

      The LEDs displays the signal strength.#160;&#160;
      
      The Stereo indicator, the volume level and the frequency of the radio station are on display.

Enjoy