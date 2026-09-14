# PIC18F57Q43 Pin Configuration & Code Layout App

An interactive HTML-based design tool created to assist microcontroller developers with physical pin planning, conflict resolution, and code generation for the **PIC18F57Q43** microcontroller.

Written by Craig Fendley and provide here with his permission.

[![Launch Pin Planner](https://img.shields.io/badge/Launch-Pin%20Planner%20App-brightgreen?style=for-the-badge)](https://htmlpreview.github.io/?https://github.com/GreatCowBASIC/Demonstration_Sources/blob/main/UserTools/PCBCode%20Layout%20App/pic18f57q43-pinplanner_V4.html)

> 🚀 **[Launch PIC18F57Q43 Pin Planner App directly in browser](https://htmlpreview.github.io/?https://github.com/GreatCowBASIC/Demonstration_Sources/blob/main/UserTools/PCBCode%20Layout%20App/pic18f57q43-pinplanner_V4.html)**

---

## Overview

Planning physical pin layouts for new PCB designs can be a time-consuming process, especially when trying to avoid pin conflicts. This app provides a quick visual workspace to map out your chip's configuration and leverage Peripheral Pin Select (PPS) capabilities. 

Additionally, it automatically generates code reference snippets for **GCBASIC** and **PicBasic Pro (PBP)**.

> **Note:** Code generation parses GCBASIC and PBP manual functions. Please verify generated pin setups against official compiler documentation to ensure optimal implementation.

---

## Features

* **Pin Filter & Conflict Key:** Easily filter pins and identify pin assignment conflicts via the left control panel.
* **Interactive IC Map:** Select individual pins on the visual PIC18F57Q43 layout to configure properties.
* **Custom Net Naming:** Assign custom net names to any pin on the chip.
* **Multi-Language Code Generation:** Instantly preview pin configuration code in:
  * Generic format
  * [GCBASIC](https://sourceforge.net/p/gcbasic/discussion/629990/thread/8f7b706342/?limit=25#6c44)
  * PicBasic Pro (PBP)
* **Import / Export Capabilities:**
  * **`.json`**: Save and reload project configurations locally.
  * **`.md`**: Export the pinout layout setup as Markdown documentation.
  * **Code Export:** Export generated source code snippets for your targeted programming language.

---

## How to Use

1. **Launch the App:** Open the [Live Web App](https://htmlpreview.github.io/?https://github.com/GreatCowBASIC/Demonstration_Sources/blob/main/UserTools/PCBCode%20Layout%20App/pic18f57q43-pinplanner_V4.html) or open `pic18f57q43-pinplanner_V4.html` in any web browser.
2. **Name Your Project:** Enter your project name in the bottom-left text box.
3. **Select a Pin:** Click on any pin on the central PIC18F57Q43 visual map.
4. **Configure Settings:** 
   * Use the right panel to assign a custom net name.
   * Select the intended function for the pin (leveraging PPS).
5. **Generate Code:** Click one of the code buttons (**Generic**, **GCBASIC**, or **PBP**) under the selection box to review the pin setup code.
6. **Save & Export:** Use the top toolbar to export your project state (`.json`), pinout documentation (`.md`), or compiler source files (e.g., GCBASIC code output).

---

## AI Replication Guide

You can replicate this tool for other integrated circuits (ICs) using AI models (such as Claude or Grok):

1. Upload this application's source files to your AI tool.
2. Provide the datasheet/documentation for your target IC.
3. Provide the reference documentation for your preferred programming language.
4. Prompt the AI to adapt the pin planner logic and code generator to match your new chip and target compiler.