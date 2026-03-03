# PCF8574_V2 – Advanced PCF8574 I/O Expander Library

A lightweight but powerful library for **PIC microcontrollers** (GCBASIC) that simplifies working with the **PCF8574 / PCF8574A** I²C I/O expander.  
Designed for home‑automation projects, it supports **mixed input/output usage**, **interrupt‑driven input detection**, **non‑modifiable outputs**, and even **rotary encoder reading**.

This library was originally developed for a home‑automation system where some outputs must never be overridden by external commands, and where inputs need to trigger immediate actions via interrupts.

---

## ✨ Features

### 🔌 Input & Output Handling
- Configure each of the 8 PCF8574 pins as **input** or **output**.
- Inputs automatically use the PCF8574’s **internal pull‑ups**.
- Inputs generate an **interrupt** when pulled LOW.
- Outputs can be controlled individually or all at once.

### 🔒 Non‑Modifiable Outputs
You can define a mask of **protected relays** that cannot be changed by external commands.  
Useful for safety‑critical automation (e.g., gate open/close relays).

### 🔄 Inverted Logic Mode
- Normal mode: `1 = ON`, `0 = OFF`
- Inverted mode: `0 = ON`, `1 = OFF`  
Great for boards using active‑low relays.

### 🛎 Interrupt Support
When enabled:
- Any input pin transitioning **from HIGH → LOW** triggers an interrupt.
- The interrupt handler automatically detects which input changed.
- Custom actions can be added easily.

### 🎚 Rotary Encoder Support
The library includes routines to read a **rotary encoder** connected to the upper bits of the PCF8574.

Two decoding methods are provided:
- A clear, readable state‑machine version
- A compact, optimized version using bit patterns

### 📝 Fully Commented Code
The entire module is heavily commented to make customization easy.

### 🧪 Example Code Included
A minimal usage example is provided at the bottom of the file.

---

## 📦 Included Functionality

### Address & Configuration
- `PCF8574_SetAddress(address)`
- `PCF8574_SetReleNonProgrammabili(mask)`
- `PCF8574_SetInvertedLogic(flag)`
- `PCF8574_ConfigureInputs(mask)`

### Output Control
- `PCF8574_WriteAllOutputs(address, value)`
- `PCF8574_ActivateRelay(address, relayNumber)`
- `PCF8574_DeactivateRelay(address, relayNumber)`
- `PCF8574_ToggleRelay(address, relayNumber)`
- `PCF8574_AzzeraTutto(address)` – reset all outputs

### Input Reading
- `PCF8574_ReadInputs(address)`
- `PCF8574_ReadSingleInput(address, inputNumber)`

### Interrupt Handling (optional)
- `PCF8574_EnableInterrupt()`
- `PCF8574_DisableInterrupt()`
- `HandlePCFInterrupt()` – automatically called on input change

### Rotary Encoder
- `ReadEncoder()`
- `ProcessEncoder()` – readable version
- `ProcessEncoder2()` – compact version

---

## 🚀 Example Usage

```basic
' Configure PCF8574 address
Call PCF8574_SetAddress(PCF1)

' Configure pins 0 and 1 as inputs
Call PCF8574_ConfigureInputs(0b00000011)

' Enable interrupts for input changes
Call PCF8574_EnableInterrupt()

' Set initial outputs
Call PCF8574_WriteAllOutputs(PCF1, RelaysState)

Do
   ' Main loop
   Wait 100 ms
Loop
```

---

## 🧭 Rotary Encoder Example (Interrupt-Based)

```basic
' In interrupt:
CurrentState = ReadEncoder()
ProcessEncoder()
```

`EncoderValue` will automatically increase or decrease based on rotation.

---

## 📚 Notes

- The PCF8574 has **no configuration registers**.  
  Writing `1` makes a pin an **input** (with pull‑up).  
  Writing `0` makes it an **output**.
- Inputs only trigger interrupts on **HIGH → LOW** transitions.
- Outputs marked as *non‑programmable* cannot be changed by library calls.

---

## 🛠 Requirements

- GCBASIC compiler  
- PIC microcontroller with I²C support  
- PCF8574 or PCF8574A module  

---

## 📄 License

GPL