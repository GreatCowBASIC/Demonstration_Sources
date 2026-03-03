# **Thallium — A Lightweight Preemptive RTOS for AVR Microcontrollers**

About 25 years ago, I began writing an RTOS for what was then the first AVR microcontroller with enough SRAM to make such a project feasible — the **ATmega103**. 

Recently, thanks to **GCBASIC**, I revived the idea. Although GCBASIC isn’t typically associated with assembly‑level development, it turned out to be the perfect tool to breathe life back into the project. The working title for this RTOS is **Thallium**.

Thallium is written almost entirely in **AVR assembly**, but exposes a clean **macro‑based API** that integrates naturally with GCBASIC programs. The goal is simple:  
**bring true preemptive multitasking to AVR projects without the overhead of a C‑based RTOS.**

---

## 📘 Background

Microchip’s application note **AN2751**, written by *Ivar Holand*, provides an excellent overview of the benefits of multitasking systems — including those implemented by Thallium. Rather than repeat that material here, interested readers are encouraged to consult the document directly.

---

## ✨ Key Features

- **Up to 8 concurrent tasks**
- **Dedicated stack per task**  
  Task switching is performed by simply loading the stack pointer for the next task.
- **8 priority levels**
- **Priority‑based scheduler**  
  The highest‑priority ready task always runs first.
- **Round‑robin scheduling** for tasks sharing the same priority
- **Per‑task flag registers** controlling execution
- **Global tick counter** for delays and timing
- **Up to 15 mutexes** for shared‑resource protection
- **No time‑wasting commands allowed** (except in Task0)

---

## 🧩 API Overview

Thallium exposes a small but powerful set of commands:

### **Task Management**
| Command | Description | Parameters |
|--------|-------------|------------|
| `setUpTask` | Initializes a task (called once per task) | `osTaskNbr`, `osLabel`, `osPriority`, `osFlagsBitMask` |
| `slumber` | Suspends the current task for a number of ticks | `osDuration` |
| `yield` | Allows other tasks to run at least once | `osTaskNbr` |

### **Flags**
| Command | Description | Parameters |
|--------|-------------|------------|
| `setFlags` | Sets flag bits for a task | `osTaskNbr`, `osBitMask` |
| `clrFlags` | Clears flag bits for a task | `osTaskNbr`, `osBitMask` |

### **Mutex / Resource Control**
| Command | Description | Parameters |
|--------|-------------|------------|
| `signal` | Marks a shared resource as occupied | `osTaskNbr`, `osSignalNbr` |
| `passed` | Releases a shared resource | `osSignalNbr` |

### **Interrupt Control**
| Command | Description |
|---------|-------------|
| `lock` | Disables global interrupts |
| `resume` | Enables global interrupts |

---

## ⚙️ Resource Usage

Because Thallium is written in pure AVR assembly, it is extremely compact:

- **Program memory:** ~992 bytes  
- **SRAM usage:** ~87 bytes  

(Values based on the compiler output for the included example program.)

Most preemptive RTOS implementations are written in C and are therefore too large or too rigid for use with GCBASIC. Thallium avoids this entirely by using **assembly macros**, making it both efficient and GCB‑friendly.

---

## 🧪 Supported Devices

Thallium requires AVR microcontrollers with **at least ~1 KB of SRAM**.

### ✔ Working cores:
- **ATmega328PB**
- **AVR128DA28**

### ❌ Not suitable:
- **Small PIC microcontrollers**  
  Their hardware stack makes true preemptive multitasking impractical.

---

## 🚧 Project Status

Thallium is functional and already quite capable, but it remains a **draft**.  
There is plenty of room for refinement, optimisation, and expansion — and it will likely continue evolving.

If there is interest from the community, I’m happy to continue developing and documenting it further.

---

## 📫 Contributing / Feedback

If you experiment with Thallium, find issues, or have ideas for improvement, feel free to open an issue or start a discussion. Collaboration is very welcome.


- a **Getting Started** section  
- a **Quick Example** showing how to define tasks in GCBASIC  
