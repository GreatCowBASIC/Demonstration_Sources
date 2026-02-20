# DCF77 Time Signal Decoder using Thallium (preemptive µRTOS)

**Author:** Ralf Pagel  
**License:** GPL  
**Version:** 1.0  
**Date:** 18.02.2026

This project decodes the time signals from the DCF77 time signal transmitter  
(location: Germany, near Frankfurt) and displays them on an LCD1602.

It demonstrates the use of *Thallium*, a preemptive micro‑RTOS for AVR microcontrollers,  
running on an *Arduino UNO 3* equipped with an *AVR128DA28* or an *ATmega328PB*.

The system uses:

- LCD1602 with I2C backpack (*PCF8574*)
- DCF77 receiver module
- Thallium µRTOS (OS include files listed below)

For large distances to the transmitter or in noisy environments, a high‑quality  
receiver such as the *DCF‑1060N‑MAS* (approx. 4 euros) is recommended.

**IMPORTANT:**  
The voltage at the *DCF‑1060N‑MAS* receiver must not exceed 3.3V.  
After power‑up, it takes about 45 seconds until the first valid signals appear.

---

## Required OS Includes

This project requires the Thallium µRTOS.  
Include the correct OS file depending on the microcontroller:

```c
#include "oscore128da28.h"   // OS for AVR128DA28
#include "oscore328.h"       // OS for ATmega328PB
```

Both OS files can be found here:  
https://github.com/GreatCowBASIC/Demonstration_Sources/tree/main/Time_Based_Task_Switcher_Solutions/Thallium%20-%20an%20AVR%20%20preemptiv%20%C2%B5RTOS

---

## Purpose

This example focuses on:

- Displaying received DCF77 characters  
- Showing any detected errors  

To turn this into a full clock, you would:

- Add an RTC module (e.g., *DS3231*)  
- Power the DCF77 receiver only once per day (preferably at night)  
- Use the received time to synchronize the RTC  

---

## Why Thallium?

One might think a periodic interrupt would be enough — and technically, it would.  
However, real embedded applications often need to react to many independent events:

- A keypad for setting an alarm time  
- Measuring ambient brightness to adjust LCD backlight  
- Playing an MP3 file from an SD card at wake‑up time (°)  
- Gradually increasing bedside lamp brightness  

With *Thallium*, each of these becomes a small, independent program (task).  
They communicate only via flags, keeping the system clean and maintainable.

Using interrupts alone quickly becomes unwieldy as complexity grows.

---

## Hardware Overview

- Arduino UNO 3 with AVR128DA28 or ATmega328PB  
- LCD1602 + PCF8574 I2C backpack  
- DCF77 receiver (recommended: DCF‑1060N‑MAS)  
- Optional: DS3231 RTC  
- Optional: DFPlayer Mini for MP3 playback (°)

---

## Additional Notes

The DCF77 signal originates near Frankfurt, Germany.  
More information can be found here:  
https://en.wikipedia.org/wiki/DCF77

Enjoy it!  
Ralf

(°) Note: Decoding MP3 files on an 8‑bit controller is not practical.  
A *DFPlayer Mini* module is recommended.

---

## Metadata

- **Author:** Ralf Pagel  
- **License:** GPL  
- **Version:** 1.0  
- **Date:** 18.02.2026
```
