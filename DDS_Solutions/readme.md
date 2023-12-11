Continuous tunable DDS 1Hz to 30MHz

Idea was using a cheap DDS-module with an AD9850 to make a fully tunable sine generator served through a rotary-encoder with switch and a separate single push-button. 
To set an output frequency you need a 32-bit long variable, the tuning-word. Main problem to solve, was the creation of the tuning word.   
 
The „value“ of each step (digit) is calculated from oscillators frequency devided through 2^32. As result you get an 16 digits decimal part. With the oscillator frequency of 125MHz each bit represents a step of  0,0291038304567337 Hz. 
For reasonable accuracy you need in minimum 8, better 9 decimal places.
From this in fact evolved the greatest problem to be solved. I use a 9 decimal digits long fixed value. So accuracy is only slightly degraded as some calculations show.

My solution to calculate the tuning word is a routine, based on strings and long variables which calculates the tuning word for any desired frequency using this fixed value. Up to generated frequency of 25MHz the deviation caused by this calculation of the tuning word is less then +0.5Hz, at 30MHz less then +0.9Hz from true frequency. 
It is to remember, that in principle never an accurate step of 1Hz can be reached. The lowest deviation, even calculated with 16 decimals, is -0.4Hz at 25MHz. The result of using my calculation is only slightly degraded. 

The accuracy of used x-tal-oscillators (TXC JH4D) is designed to be about 6ppm. My module had a deviation of about 900Hz which is about 8ppm. So the quality of the DDS is degraded through accuracy of the used oscillator. For a 10MHz output this means a deviation of about 70Hz.

To compensate this deviation by varying the divisor by steps of 10E-9 I use an additional routine. By this the output frequency can be corrected with 0,343Hz per Step. Effective accuracy to be reached is maximal 0.15Hz deviation at 10MHz and this is less then the possible thermic variation.

Yet another routine transforms the frequency value to a printable string in the format
##.### ###MHz, ##.###kHz or ###Hz for displaying the output frequency on the LCD.

Any chosen frequency and correction value are saved to the EEPROM of the processor and read on startup. So on power-up, the application starts at the last set while powered down.

The attached files are a complete usable app for PIC18F2520 with 32MHz, LCD1602, Encoder Alps EC11 and DDS-module with AD9850 and 125MHz quartz (HC-SR08). The program parts are fully commented, so you can retrace my ideas.

Enjoy!
Immo, DL5KB

