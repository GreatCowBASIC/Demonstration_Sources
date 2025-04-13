# Overview

This Uwe Seifert project showcases a demonstration program using the **Capacitive Voltage Divider (CVD)** of the Microchip 18F16Q41 microcontroller. The primary focus is querying sensor keys by leveraging CVD functionality.

The solution combines insights from:
- A technical brief (although incomplete)
- The 18F16Q41 PIC datasheet

The final implementation integrates advanced features of the **Analog-to-Digital Converter with Computation (ADCC)** module, such as:
- **Burst Average Mode**
- **Automatic CVD Evaluation**

April 2025

---

## Key Features

### Sensor Key Querying
- Demonstrates a practical implementation using the CVD.

### Switch with Hysteresis
- Provides data evaluation methods to implement hysteresis behavior.

### Display Control
- Includes a driver routine for a four-digit seven-segment display for:
  - Debugging
  - Tuning purposes

---

## Hardware Integration

The program uses the **SAA1064 driver** for the four-digit display, communicating via software I2C.

---

## Additional Applications

If a larger sensor surface is incorporated, this program can also function as a **proximity sensor**, broadening its potential applications.

---

## Significance

This project could play a pivotal role in:
- **CVD-based touch or proximity sensing systems**
- **Display driver development**, particularly with the SAA1064

---

## Call for Interest

Is this demonstration program of interest to you? It could provide valuable contributions to:
- The **CVD/touch/proximity sensing domain**
- **Display driver advancements**

Feel free to reach out for further collaboration or feedback!
