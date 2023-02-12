'    This library is free software; you can redistribute it and/or
'    modify it under the terms of the GNU Lesser General Public
'    License as published by the Free Software Foundation; either
'    version 2.1 of the License, or (at your option) any later version.

'    This library is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'    Lesser General Public License for more details.

'    You should have received a copy of the GNU Lesser General Public
'    License along with this library; if not, write to the Free Software
'    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

'********************************************************************************
'    PID routine for Great Cow BASIC
'    This is a library  to implement a PID on an 8 bit contoller without
'    Floating point math.
'    Thank You brettbeauregard for helping me to create this PID implementation.
'     http://brettbeauregard.com/blog/2011/04/improving-the-beginners-pid-introduction/

'    I tried to range every thing up 100 times because I was using the
'     DS18B20 which has a variable "TempC_100" with 2 digits whole C temp
'    and last two digits tenths and hundredths. But Integers only have a range
'    to +-32768 so when I did a multiply on larger errors they would go over range
'    So I had to reduce the range of the  kp, ki ,kd to divide by 10.
'    Their values are 0 for being off and 1 to 50 to used. 1 is a gain of 0.1 and
'     10 is a gain of 1,   21 is a gain of 2.1 etc
'
'    SampleTime is actually execution period which uses the millis routine
'    to count milliseconds.  i was implement a heater using a tail light bulb running
'     on HPWM and it would tale 10s of seconds to respond. that is the reason my
'     sampletime is 12000 secs and this is a major variable to the PID
'
'    Copyright (C) 2006 -2023 Hugh Considine,  Evan R. Venn, Mike Otte,
'    1/18/2023
'


#include <millis.h>       ' Include the Library

Dim lastTime as long
Dim Input, Output, Setpoint as integer
Dim ITerm, lastInput, dInput as integer
Dim kp, ki, kd as integer
Dim error as integer
Dim SampleTime as Word
Dim outMin, outMax as integer
Dim inAuto as Bit
Dim now as long
Dim timeChange as Integer


inAuto = 0      'Manual =0  Auto =1
Output = 0   ' 5000 is 50% ... Output times 100
outMax  = 10000     'Output times 100
outMin  = 0
Setpoint  = 2500    ' degrees C times 100
SampleTime =12000   ' in millisec
kp = 20            ' these are also ranged . so 200 is 2 ... 50 is 1/2 ...
ki = 10            ' these are also ranged . so 200 is 2 ... 50 is 1/2 ...
kd = 10            ' these are also ranged . so 200 is 2 ... 50 is 1/2 ...
Bright =50          ' Bright came from PWM of LED  in this case it is the PID output to HPWM
lastInput=0
Iterm =0



sub  ComputePID()
if inAuto = 0 Then return

now = millis()
timeChange = now -lastTime
'hserprint " timeChange "
'hserprint timeChange
'HSerPrintCRLF 1
if timeChange >= SampleTime Then
    error = Setpoint -Input


    Iterm  = Iterm + (ki * error / 10)
    If ITerm > outMax Then ITerm =outMax
    If ITerm < outMin Then ITerm = outMin

    dInput = Input - lastInput

    Output = (kp * error /10) + Iterm - (kd * dInput /10)
    if Output > outMax Then Output = outMax
    if Output < outMin Then Output = outMin


    'hserprint Debug statements
    'execute every time the PID computes a new value

    hserprint "Output= P part = "
    hserprint (kp * error /10)
    hserprint " + I term = "
    hserprint Iterm
    hserprint " + I part = "
    hserprint (ki * error / 10)
    hserprint " -  D part = "
    hserprint (kd * dInput /10)
    HSerPrintCRLF

    lastInput = Input
    lastTime  = now

end If
end Sub

sub SetOutputLimits (newMin as Integer , newMax as Integer)
    if newMin > newMax Then return

    outMin = newMin
    outMax = newMax

    if Output > outMax Then Output = outMax
    if Output < outMin Then Output = outMin

    if ITerm > outMax Then ITerm = outMax
    if ITerm < outMax Then ITerm = outMin

end Sub
