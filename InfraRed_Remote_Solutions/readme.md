# Infrared Decoder Demonstration (PIC12F1840)

This summary describes a demonstration posted by **Janis** on the GCBASIC SourceForge discussion forum. The original thread is located at:

**[https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/](https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/)**

Direct links to the referenced posts include:

- Primary description  
  **[https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/?limit=25#af33](https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/?limit=25#af33)**
- Post containing the  GCB source  
  **[https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/?limit=25#aa2a](https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/?limit=25#aa2a)**

Janis presents a compact and reliable infrared (IR) remote‑control decoder built around the Microchip PIC12F1840 microcontroller. The demonstration shows how a very small device can decode a wide range of consumer IR protocols and expose the decoded button states as logic‑level outputs. The work is intended to be technically clear, easy to integrate, and straightforward to extend.

Two GCBASIC source files form the core of the demonstration:

- **IR_decoder_4in_2out_12f1840.gcb** — the complete IR decoder implementation  
- **RGB_WH_IR 16F18426 v1.gcb** — the RGBW LED controller that receives the decoded IR signals  

---

## Functional Overview  
The decoder stores IR codes for four remote‑control buttons and represents the decoded states as four internal variables. These variables can be mapped to physical outputs or passed to a second microcontroller. The default configuration merges the four decoded buttons into two outputs using OR‑logic.

Outputs operate in **momentary mode**: an output remains active only while the corresponding button on the remote control is held. Users who require toggle, latch, or multi‑function behaviour can add these features by modifying the logic around the existing variables.

The design is intentionally minimal to preserve timing accuracy, which is essential for reliable IR decoding.

The companion file **RGB_WH_IR 16F18426 v1.gcb** implements the RGBW LED controller that responds to the decoded IR signals. It handles PWM generation, colour‑mixing logic, and brightness control. Janis separates this functionality into a second microcontroller to avoid timing conflicts.

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

### RGBW Controller — *RGB_WH_IR 16F18426 v1.gcb*  
This companion file implements:

- RGBW PWM generation  
- brightness and mode control  
- input handling for the decoded IR signals  
- a clean separation between colour‑mixing logic and IR decoding  

It is designed to work directly with the outputs of the PIC12F1840 decoder.

---

## Compatibility and Testing  
Janis reports successful decoding with a wide range of consumer IR remotes, including:

- TCL  
- Samsung  
- Philips  
- Sony  
- Kenwood  

and several others. The decoder is therefore suitable for general‑purpose use and can be adapted for unusual protocols by adjusting the timing variables in the source code.

---

## Provided Materials  
The SourceForge thread includes:

- **IR_decoder_4in_2out_12f1840.gcb** — the complete IR decoder source file  
- **RGB_WH_IR 16F18426 v1.gcb** — the RGBW LED controller source file  
- **Schematic_RGBW_R‑16F18426_12F1840_2026‑01‑19.pdf** — the wiring diagram for the two‑microcontroller system  

All are available directly from the thread:

**[https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/](https://sourceforge.net/p/gcbasic/discussion/projects%26guides/thread/129a9a5340/)**

---

## Key Points  
- Janis demonstrates a robust and compact IR decoder for the PIC12F1840.  
- The design is protocol‑agnostic and works with many common remote controls.  
- The decoder is intentionally simple to preserve timing accuracy.  
- The architecture uses two microcontrollers to avoid timing conflicts.  
- The project is well documented, modular, and easy to extend.  
