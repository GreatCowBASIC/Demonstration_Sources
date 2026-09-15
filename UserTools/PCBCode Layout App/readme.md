# Pin Configuration & Code Layout App

An interactive HTML-based design tool to assist microcontroller developers with physical pin planning, conflict resolution, and automatic code generation for the **PIC18F57Q43** and **PIC16F18857** devices.

Written by Craig Fendley and reproduced here with his permission.

---

## 🚀 Launch Pin Planner Apps

### PIC18F57Q43

[![Launch Pin Planner](https://img.shields.io/badge/Launch-Pin%20Planner%20App-brightgreen?style=for-the-badge)](https://htmlpreview.github.io/?https://github.com/GreatCowBASIC/Demonstration_Sources/blob/main/UserTools/PCBCode%20Layout%20App/pic18f57q43-pinplanner_V4.html)

> **Launch PIC18F57Q43 Pin Planner App directly in browser:**  
> https://htmlpreview.github.io/?https://github.com/GreatCowBASIC/Demonstration_Sources/blob/main/UserTools/PCBCode%20Layout%20App/pic18f57q43-pinplanner_V4.html

---

### PIC16F18857

[![Launch Pin Planner](https://img.shields.io/badge/Launch-Pin%20Planner%20App-brightgreen?style=for-the-badge)](https://htmlpreview.github.io/?https://github.com/GreatCowBASIC/Demonstration_Sources/blob/main/UserTools/PCBCode%20Layout%20App/pic16f18857-pinplanner.html)

> **Launch PIC16F18857 Pin Planner App directly in browser:**  
> https://htmlpreview.github.io/?https://github.com/GreatCowBASIC/Demonstration_Sources/blob/main/UserTools/PCBCode%20Layout%20App/pic16f18857-pinplanner.html

---

## Overview

Planning pin layouts for new PCB designs can be time-consuming, especially when juggling Peripheral Pin Select (PPS) options and avoiding functional conflicts.

This tool provides a visual, interactive workspace for mapping out pin assignments on the PIC18F57Q43 or PIC16F18857, with automatic generation of reference code in:

- Generic format  
- GCBASIC  
- PicBasic Pro (PBP)

> **Note:** Generated code is based on compiler documentation parsing. Always verify output against official manuals.

---

## Features

- Pin filtering and conflict detection  
- Interactive IC map for selecting and configuring pins  
- Custom net naming  
- Multi-language code generation (Generic, GCBASIC, PBP)  
- Import / Export:
  - `.json` project state  
  - `.md` pinout documentation  
  - Compiler-specific code snippets

---

## Supported Devices

- **PIC18F57Q43** — full PPS-driven planner  
- **PIC16F18857** — replicated variant using datasheet + compiler documentation

---

## 📦 Source Files

### PIC18F57Q43 Source File

[![Open Source File](https://img.shields.io/badge/Open-Source%20File-blue?style=for-the-badge)](https://github.com/GreatCowBASIC/Demonstration_Sources/blob/main/UserTools/PCBCode%20Layout%20App/pic18f57q43-pinplanner_V4.html)

### PIC16F18857 Source File

[![Open Source File](https://img.shields.io/badge/Open-Source%20File-blue?style=for-the-badge)](https://github.com/GreatCowBASIC/Demonstration_Sources/blob/main/UserTools/PCBCode%20Layout%20App/pic16f18857-pinplanner.html)

---

## AI Replication Guide

You can replicate this tool for any PIC or other MCU using an AI model.

### Steps

1. Provide the original HTML/JS source of the PIC18F57Q43 planner.  
2. Supply the target device datasheet.  
3. Include compiler documentation:
   - GCBASIC: https://gcbasic.sourceforge.io/help/  
   - PicBasic Pro: https://melabs.com/resources/pbpmanual/  
4. Use a prompt such as:
     *"Here is my PIC18F57Q43 pin planner HTML app. Please replicate its functionality for the PIC16F18857. I’ve included the datasheet and compiler documentation for correct code generation."*

