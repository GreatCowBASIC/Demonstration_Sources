# **Digital Audio Spectrum Analyzer in GCBASIC** 🎶  

## **Overview**  
A few years ago, psychedelic lights were incredibly popular, lighting up in time with the music by following the progression of high, medium, and low frequencies. At the time, circuits relied on complex **RC or RLC filters** to separate frequency bands, making the process more challenging and less precise.  

Now, thanks to advancements in **digital signal processing**, signals can be analysed using **digital filters** that mathematically separate the audio signal into precise frequency bands, allowing for far greater accuracy and flexibility. This project implements a **digital audio spectrum analyzer** using **GCBASIC** with floating point calculations. It processes an audio signal, separates it into distinct frequency bands using **IIR digital filters**, and drives outputs based on the detected frequencies.  

Originally written in **MikroBasic**, this programme has been converted to **GCBASIC**, taking advantage of its **floating point support** for improved precision and performance.  

## **Features**  
- **Real-time audio processing** using ADC sampling  
- **Four frequency bands** separated via IIR digital filters:  
  - **ExtraBass**: Low-pass filter with a cutoff frequency of 100 Hz  
  - **Bass**: Band-pass filter between 101 Hz and 400 Hz  
  - **Middle**: Band-pass filter between 401 Hz and 2 kHz  
  - **High**: High-pass filter with a cutoff frequency of 2 kHz  
- **Threshold-based output activation**  
- **Optimised for a PIC with a 32MHz clock** for smooth performance  

## **How It Works**  
1. The **audio signal** is sampled via the ADC (channel AN0).  
2. The signal is processed by **four IIR digital filters** to separate the bands.  
3. The filtered signals are compared with **potentiometer values** to determine activation thresholds.  
4. If the signal of a band exceeds the corresponding threshold, the **output is activated**.  

## **Hardware Requirements**  
- **PIC microcontroller** (32MHz clock recommended)  
- **Audio input** connected to ADC (AN0)  
- **Potentiometers** for threshold adjustment  
- **LEDs or other output indicators**  

## **Installation & Usage**  
1. Compile the programme using **GCBASIC**.  
2. Connect the hardware components as described in the source code.  
3. Adjust the potentiometers to set frequency thresholds.  
4. Play an audio signal and observe the outputs reacting to different frequency bands.  

## **Notes**  
- Floating point calculations in **GCBASIC** allow precise frequency separation.  
- Ensure the PIC has sufficient processing power for real-time calculations.  
- The source code includes detailed explanations and connection instructions.  

## **License**  
This project is open-source and available under the **MIT License**.  

## **Contributing**  
Pull requests and improvements are welcome! If you encounter any issues or have suggestions, feel free to open an issue.  

---

The orignal README provides a **functional and structured** overview of the project, focusing on its implementation and usage. 🚀