# Infrared Remote Solutions (PIC16F18426 RGBW Controller + PIC12F1840 IR Decoder)

This summary describes a demonstration posted by **Janis** on the GCBASIC SourceForge discussion forum. The original thread is located at:

**[https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/](https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/)**

Direct links to the referenced posts include:

- Primary description  
  **[https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/?limit=25#af33](https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/?limit=25#af33)**
- Post containing the  GCB source  
  **[https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/?limit=25#aa2a](https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/?limit=25#aa2a)**

Janis presents a compact and reliable infrared (IR) remote‑control decoder built around the Microchip PIC12F1840 microcontroller. The demonstration shows how a very small device can learn and decode buttons from NEC‑type and TCL‑type consumer IR remotes and expose the decoded button states as logic‑level outputs. The work is intended to be technically clear, easy to integrate, and straightforward to extend.

Two GCBASIC source files form the core of the demonstration:

- **2. PIC12F1840/IR_decoder_4in_2out_12f1840.gcb** — the complete IR decoder implementation  
- **1. PIC16F18426/RGB_WH_16F18426_v2.gcb** — the RGBW LED controller that receives the decoded IR signals  

See [Folder Structure](#folder-structure) for the full list of files.

---

## Functional Overview  
The decoder stores IR codes for four remote‑control buttons and represents the decoded states as four internal variables. These variables can be mapped to physical outputs or passed to a second microcontroller. The default configuration merges the four decoded buttons into two outputs using OR‑logic.

Outputs operate in **momentary mode**: an output remains active only while the corresponding button on the remote control is held. Users who require toggle, latch, or multi‑function behaviour can add these features by modifying the logic around the existing variables.

The design is intentionally minimal to preserve timing accuracy, which is essential for reliable IR decoding.

The companion file **RGB_WH_16F18426_v2.gcb** implements the RGBW LED controller that responds to the decoded IR signals. It handles PWM generation, colour‑mixing logic, and brightness control. Janis separates this functionality into a second microcontroller to avoid timing conflicts.

---

## Hardware Architecture  
The decoder runs on a **PIC12F1840**, chosen for its small footprint and adequate timing performance. Janis provides a schematic showing how the IR decoder interfaces with an RGBW LED controller.

Although the original intention was to combine both the IR decoding and the RGBW LED control on a single microcontroller, timing conflicts with PWM and other high‑speed tasks made this impractical. The final architecture therefore uses **two microcontrollers**:

- **PIC12F1840** for IR decoding  
- **PIC16F18426** for RGBW LED control  

This separation ensures that the IR decoding remains reliable even when the LED controller is busy with intensive operations.

---

## Software Characteristics  

### IR Decoder — *IR_decoder_4in_2out_12f1840.gcb*  
The GCBASIC source file supplied by Janis includes extensive commentary in both English and Latvian. The comments explain:

- the structure of IR packets  
- the timing thresholds used for decoding  
- how to adjust these thresholds  
- how to remap outputs  
- how to adapt the decoder for unusual protocols  

The code implements:

- a precise IR timing‑capture loop  
- pulse‑width classification  
- a state machine for packet assembly  
- mapping of decoded packets into four logical button states  
- a final output layer that drives two physical outputs  

The code is intentionally lightweight to ensure that the microcontroller can maintain precise timing. Janis notes that combining this decoder with CPU‑intensive features on the same device is likely to cause failures.

### RGBW Controller — *RGB_WH_16F18426_v2.gcb*  
This companion file (the current version; the earlier **RGB_WH_IR 16F18426 v1.gcb** is kept in the `archived` folder) implements:

- RGBW PWM generation  
- brightness and mode control  
- input handling for the decoded IR signals  
- a clean separation between colour‑mixing logic and IR decoding  

It is designed to work directly with the outputs of the PIC12F1840 decoder.

---

## User Instructions (Firmware V8.2 TCL STRICT)  
*Translated from the Latvian user instructions supplied by Janis in* **2. PIC12F1840/Instrukcija_IR_decoder_4in_2out_12f1840_LV_EN.docx** *(dated 26 October 2026).*

The device stores four IR remote‑control commands and uses them to control two outputs. This section describes button assignment, learning and LED indication for firmware version V8.2.

### Assigning buttons to outputs  

| Learning slot | Output | Example using two remotes |
|---------------|--------|---------------------------|
| CH1 | OUT1 | Remote A — first function  |
| CH2 | OUT1 | Remote B — first function  |
| CH3 | OUT2 | Remote A — second function |
| CH4 | OUT2 | Remote B — second function |

CH1–CH4 are memory slots, not four physical outputs. All four buttons may also belong to one remote. Teach a different code in each slot; the firmware rejects an NEC button stored in more than one slot as ambiguous.

### Learning the buttons  
1. Press and release **LEARN**. The LED lights continuously. Both outputs are OFF during learning.
2. Press the remote button intended for CH1. Once it is saved, the LED confirms with one flash. Release the remote button.
3. Teach CH2, CH3 and CH4 in the same way. The LED confirms with two, three and four flashes respectively.
4. After releasing each button, wait until its IR transmission has ended before pressing the next button. Do not keep a button held down to advance to the next learning step.
5. After CH1–CH3 are confirmed, the last confirmation flash stays lit: the device is waiting for the next button.
6. After CH4 is confirmed, the LED goes out and the device automatically returns to normal operation.

### Cancelling learning  
Press and release **LEARN** again. The LED goes out and the device returns to normal operation. Each slot is saved immediately: slots already overwritten keep their new buttons; slots not yet overwritten keep their previous codes. Cancelling does not restore overwritten codes.

### Operation and LED indication  
A recognised button activates the output assigned to its slot. While the button is held, valid full frames or repeat frames keep that output ON. After release, the output switches OFF after a short delay. The firmware does not latch or toggle the output ON/OFF on each press.

| Situation | LED behaviour |
|-----------|---------------|
| Recognised learned button | Lit continuously while the command is active. |
| Unrecognised or malformed capture | Each rejected capture toggles the LED. Holding an unknown button makes the LED blink at the packet rate. A single capture may produce only a brief flash. |
| IR transmission has ended | The unknown‑signal indication clears after a short delay. If no recognised command is still active, the LED is OFF. |

The blink rate depends on how often the remote sends packets. This is a *reception* indication only: it can also mean a malformed frame, noise, or a short repeat with no previously recognised full command. LED blinking does not by itself activate an output.

### How remote signals are recognised  
- **NEC‑type remotes (32‑bit code):** the firmware checks the length and timing of a complete 67‑phase frame, decodes four bytes and compares all 32 bits exactly. A short 3‑phase repeat is accepted only for an NEC command that is already active.
- **TCL‑type remotes (51‑phase frame):** the firmware requires a full 51‑phase capture and compares the duration signature of the first 48 phases against EEPROM. This is not a full TCL bit decoder. V8.2 no longer allows any phase outside its timing tolerance — including when checking repeats of the active button.

### TCL settings in version V8.2  

| Parameter | Value | Meaning |
|-----------|-------|---------|
| `PULSE_TOL` | 3 | Timing tolerance for ordinary compared TCL phases. The leading phases have separate rules. |
| `MAX_BAD_PULSES` | 0 | During a TCL button search, no compared phase may exceed its tolerance. |
| `MAX_BAD_ACTIVE_PULSES` | 0 | Repeats of the active TCL button also allow no phases outside tolerance. |

These settings apply only to TCL signature matching; NEC codes are still compared exactly. The timing counters 210 and 120 count main‑loop iterations, not exact milliseconds — capture and processing can lengthen the actual delay.

### Stored buttons and reprogramming  
Buttons are stored in EEPROM and are retained when power is removed. When reprogramming the PIC, choose to preserve EEPROM; if EEPROM is erased, all four buttons must be taught again. V8.2 uses the same EEPROM format as V4–V8.1.

Four independent physical outputs need different wiring and firmware — in practice, a PIC with more available output pins.

---

## Compatibility and Testing  
Janis reports successful decoding with a wide range of consumer IR remotes, including:

- TCL  
- Samsung  
- Philips  
- Sony  
- Kenwood  

and several others. Note that firmware V8.2 recognises only NEC‑type (32‑bit) and TCL‑type (51‑phase) frames — see [How remote signals are recognised](#how-remote-signals-are-recognised). A remote of another brand works only if it transmits one of these formats; other protocols require changes to the decoding logic in the source code.

---

## Folder Structure  

```
InfraRed_Remote_Solutions/
├── readme.md
├── RGB_WH_control_instructions_EN.docx                   RGBW controller MODE button and settings instructions (English; written for v1)
├── 1. PIC16F18426/
│   ├── RGB_WH_16F18426_v2.gcb                            RGBW LED controller (current version)
│   ├── Schematic_RGBW_R-16F18426_12F1840_2026-01-19.pdf  wiring diagram for the two-microcontroller system
│   └── archived/
│       └── RGB_WH_IR 16F18426 v1.gcb                     RGBW LED controller (original version)
└── 2. PIC12F1840/
    ├── IR_decoder_4in_2out_12f1840.gcb                   IR decoder, firmware V8.2 TCL STRICT
    └── Instrukcija_IR_decoder_4in_2out_12f1840_LV_EN.docx IR decoder user instructions (Latvian and English)
```

The original sources and discussion are in the SourceForge thread:

**[https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/](https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/)**

---

## Key Points  
- Janis demonstrates a robust and compact IR decoder for the PIC12F1840.  
- Firmware V8.2 recognises NEC‑type (32‑bit) and TCL‑type (51‑phase) remote controls; buttons from these remotes are taught into four learning slots.  
- The decoder is intentionally simple to preserve timing accuracy.  
- The architecture uses two microcontrollers to avoid timing conflicts.  
- The project is well documented, modular, and easy to extend.  
