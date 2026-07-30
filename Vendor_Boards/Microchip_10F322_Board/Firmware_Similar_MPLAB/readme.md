# PIC10F322 Timer‑Driven LED & ADC Demo  
Alternate demonstration firmware using CCS C

This README describes an alternate demo program for the **PIC10F322**, running at **16 MHz** using the internal **RCOSC**.  
The firmware showcases Timer1‑based timing, interrupt‑driven ADC sampling, and LED behaviour controlled by both a pushbutton and analog input.

---

## ⏱️ Timing Architecture  
The firmware uses **Timer1** to generate a **nominal 5 ms timebase**.  
From this base tick, the code derives LED flash periods:

- 100 ms  
- 200 ms  
- 500 ms  
- 1 Hz (1 s period)

Both **Timer1 interrupts** and **ADC interrupts** are used to service timing and sampling.

---

## 🟩 Green LED Behaviour  
The Green LED responds to **both the pushbutton** and the **analog input**.

### Analog‑controlled behaviour  
- **Analog < 0x7F** → Green LED flashes at **1 Hz**  
- **Analog ≥ 0x80** → Green LED **ON**

### Pushbutton override  
- When pressed, the pushbutton **overrides analog control**  
- LED toggles at **~100 ms** intervals

---

## 🟥 Red LED Behaviour  
The Red LED is driven entirely by the **analog input**, sampled every **100 ms**.  
A **rolling average** is maintained:

\[
\text{Value} = \frac{\text{Value} + \text{LatestSample}}{2}
\]

### LED response ranges  
- **< 0x20** → Red LED **OFF**  
- **0x20–0x2F** → Red LED **ON**  
- **0x30–0x3F** → Red LED **Slow Flash**  
- **0x40–0x4F** → Red LED **Medium Flash**  
- **0x50–0x5F** → Red LED **Fast Flash**  
- **0x7E–0x81** → Red LED **OFF**  
- **Else** → Red LED **ON**

There is a **small centre‑position window** on the potentiometer where the Red LED should be **OFF**.

---

## 🔧 Purpose of the Demo  
This firmware is intended to help with:

- Observing **timing variations** on a scope (e.g., temperature drift of RCOSC)  
- Monitoring **analog sample stability** and rolling‑average behaviour  
- Demonstrating interrupt‑driven timing and ADC processing on the PIC10F322

---

## 📝 Notes  
- Code is written in **C** using the **CCS compiler**  
- No effort has been made to optimise size — **this version is intentionally larger**  
- Intended as a **demonstration**, not production firmware
