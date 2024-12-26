### PDC-6X1 Display Driver

A driver for the 6-digit, 7-segment LCD, featuring the HT1621 LCD driver chip. This driver supports displaying numbers from -99999 to 999999 and includes functionalities for setting decimal points and battery level indicators.

#### Features:
- **Display Range**: -99999 to 999999
- **Decimal Points**: Adjustable at three positions
- **Battery Indicator**: Integrated control
- **Error Handling**: Displays "Error" for out-of-range values

#### Usage:
- Designed for numerical displays, using subroutines prefixed with `LCD7`

#### Notes:
- Tested on PIC16F1788, compatible with most MCUs supported by GCBASIC
- **Bias Resistor**: Adjust based on voltage (15kΩ for 3.3V, 75kΩ for 5V)
- **Power Consumption**: 165µA at 3.3V, 280µA at 5V

The driver and demo program are attached for reference.

If anybody wants to use my driver to send other letters to the display, or write just one character at a time, it can be done, but is less convenient. If you want to do it, look into the driver source code to see how to do it.

All variable names and subroutines used by the driver begin with `LCD7`, to minimize chances of conflict with user programs.

The driver, and a small demo program that shows how to use it, are attached. Maybe somebody out there might find this useful.

The driver is certainly not highly optimized. A better programmer than I am can surely make a much more efficient driver - but this one works, at least!
