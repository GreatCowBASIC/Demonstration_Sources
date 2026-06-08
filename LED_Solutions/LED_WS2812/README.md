# WS2812 LED Demonstration — ATmega32U4 (Arduino Leonardo)

A GCBASIC demonstration driving WS2812 RGB LEDs using bit-banged timing on an AVR microcontroller.

---

## Video

[▶ Watch WS2812_AVR.mp4](WS2812_AVR.mp4)

---

## Overview

This demonstration shows two display modes driven by a hardware timer interrupt, with speed controlled by a potentiometer and mode selection via a push switch.

| Mode | Behaviour |
|---|---|
| **Chaser** | One lit pixel moves through the strip in sequence |
| **Flash All** | All pixels set to the same colour simultaneously |

---

## Hardware

| Signal | AVR Port | Arduino Leonardo Pin | Notes |
|---|---|---|---|
| WS2812 DIN | PE6 | D7 | Chosen to avoid OC1A hardware timer conflict |
| Potentiometer | PF7 | A0 | Sets update speed (1–1000 ms) |
| Switch | PB4 | D8 | Active-low, toggles display mode |
| Debug LED DS2 | PC0 | — | Not exposed on Leonardo header |
| Debug LED DS3 | PC1 | — | Not exposed on Leonardo header |
| Debug LED DS4 | PC2 | — | Not exposed on Leonardo header |
| Debug LED DS5 | PC3 | — | Not exposed on Leonardo header |

> **Pin note:** PD1 (D2/SDA) and PB5 (D9) are the OC1A hardware compare outputs for Timer 1. Connecting WS2812 DIN to either of those pins would cause the timer hardware to drive the line directly, bypassing the ISR entirely. PE6 (D7) has no timer function and is safe to use.

---

## Configuration

```basic
#chip mega32u4, 16
```

| Parameter | Value |
|---|---|
| MCU | ATmega32U4 |
| Clock | 16 MHz |
| Pixel count | 16 |
| Compiler | GCBASIC |
| IDE | GCCode |

---

## Timer

Timer 1 is configured in CTC mode to fire every **300 µs**, pacing the inter-frame gap.

```
OCR1A = (F_CPU / (Prescaler × Frequency)) − 1
      = (16,000,000 / (64 × 3333.33)) − 1
      = 74  (0x004A)
```

| Register | Value | Purpose |
|---|---|---|
| OCR1AH | 0x00 | Compare target high byte |
| OCR1AL | 0x4A | Compare target low byte |
| WGM12 | 1 | CTC mode |
| CS11:CS10 | 1:1 | Prescaler 64 |
| OCIE1A | 1 | Compare match interrupt enable |

The 300 µs period satisfies the WS2812 reset requirement for all revisions:

| Device | Min Reset Pulse |
|---|---|
| WS2812 / WS2812B (pre-2020) | 50 µs |
| WS2812B (2020+ revision) | 280 µs |

---

## Bit-Bang Timing

WS2812 data is transmitted as 24-bit GRB values. Timing is calibrated for **16 MHz AVR only** — do not port to PIC or any other clock speed without re-measuring on a scope.

| Bit | Target high time | Method |
|---|---|---|
| **1** | ~800 ns | `SET DIN ON` + 7 NOPs + `SET DIN OFF` = ~562 ns |
| **0** | ~400 ns | `SET DIN ON` + 2 NOPs + `SET DIN OFF` = ~250 ns |

The `ROTATE ColorToSend left` executes after `END IF` while DIN is already low, providing ~750 ns of inter-bit low time via the RAM-based rotate (12 cycles × 62.5 ns). This is within the WS2812 minimum low-time spec of 450 ns and must not be optimised away.

> **Rule:** `SET DIN OFF` must remain inside each branch of the `IF/END IF`. Moving it outside extends the high time on both paths and breaks protocol timing.

---

## Files

| File | Description |
|---|---|
| `WS2812_LED_using_BitBanging_AVR.gcb` | GCBASIC source |
| `WS2812_LED_using_BitBanging_AVR.asm` | Compiled AVR assembly (reference) |
| `WS2812_AVR.mp4` | Video of the demonstration running on hardware |

---

## Licence

GPL — see repository root for full licence terms.

**Author:** EvanV
