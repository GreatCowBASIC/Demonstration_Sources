'    DS18b20 temperature sensor routines for the GCBASIC compiler
'    Copyright (C) 2018-2026

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

'    Supports a multiport DS18B20 reads.

'    These routines use the 12 bit sensor functionality.
'    These routines will NOT work with DS18S20. This a 9 bit sensor and these routines will not work.

'    To read a value, call the readtempfromPort(port) method.
'     Returns readtemp12 and readtemp

    ' Readtemp
    ' Reads temperature from a DS18B20 digital temperature sensor and store in
    ' the output variable.  The conversion takes up to 750ms.  Readtemp carries out a full 12 bit
    ' conversion and then rounds the result to the nearest full degree Celsius (byte
    ' value). For the full 12 bit value use the readtemp12 command.

    ' The temperature is read back in whole degree steps, and the sensor operates from
    ' -55 to + 125 degrees Celsius. Note that bit 7 is 0 for positive temperature values
    ' and 1 for negative values (ie negative values will appear as 128 + numeric value).
    ' Note the readtemp command does not work with the older DS1820 or DS18S20
    ' as they have a different internal resolution. This command is not designed to be
    ' used with parasitically powered DS18B20 sensors, the 5V pin of the sensor must
    ' always be connected.

    ' Readtemp12
    ' Reads 12 bit temperature data from a DS18B20 digital temperature sensor and
    ' store in variable. The conversion takes up to 750ms. Both readtemp and
    ' readtemp12 take the same time to convert.
    ' This command is for advanced users only. For standard whole degree data use the readtemp command.
    ' The temperature is read back as the raw 12 bit data into a word variable (0.0625
    ' degree resolution). The user must interpret the data through mathematical
    ' manipulation. See the DS18B20 datasheet for more information on the 12 bit
    ' Note the readtemp12 command does not work with the older DS1820 or DS18S20 as they have a different internal resolution.
    ' This command is not designed to be used with parasitically powered DS18B20 sensors, the 5V pin of the sensor must be connected.

' Define varaibles
  Dim RxData As Byte   'used to support reading data stream
  Dim DSdata As Word   'need this for negative numbers. (Leave RXdata as a working byte variable)
  Dim DSdec as  String 'need this for holding decimal place from pseudo "lookup table"
  Dim DSint as integer 'need this to return minus sign (set bit 15 = 1 (= negative))
  dim readtemp as Integer ' need this return the temperature
  dim readtemp12 as Integer
  dim tempc_100
  dim whole

#define DS18B20DeviceReadRetry 0xffff

' Define device ROM Commands for 1-Wire DS18B20
#define SearchRom 240   '0xF0 (240)
      'Command for identifying Slave Rom codes, use as many
      'times as needed
#define ReadRom 51            '0x33 (051)
      'Command for single slave
#define MatchRom 85   '0x55 (085)
      'Command for master to identify a specific slave code
#define SkipRom 204   '0xCC (204)
      'Command for addressing all devices simultaneously
#define AlarmSearch 236     '0xEC (236)
      'Command is same as Search Rom to identify any alarm flags

' Define function Commands for for 1-Wire DS18B20
#define ConvertT 68   '0x44 (68)
      'Protocol for Single Temp Conversion
#define WriteScratch 78     '0x4E (78)
      'Protocol for Write Scratchpad
#define ReadScratch 190     '0xBE (190)
      'Protocol for Read Scratchpad
#define CopyScratch  72       '0x48 (72)
      'Protocol for copying Scratchpad TH and TL
      'registers to EEPROM
#define RecallE2 184  '0xB8 (184)
      'Protocol for recalling alarm trigger values from EEPROM
 #define ReadPowerSupply 180  '0xB4 (180)
      'Protocol for identifying Power Supply Mode

'Protocol resolution
#define DS18B20_TEMP_9_BIT  0x1F
#define DS18B20_TEMP_10_BIT 0x3F
#define DS18B20_TEMP_11_BIT 0x5F
#define DS18B20_TEMP_12_BIT 0x7F




'''
'''Sensor value as an integer
macro readtempfromPort ( DQPort )


  dim fraction as byte

   DS18B20DeviceRead ( DQPort )

  readtemp12 = DSdata

   If DSdata.15 = 1 then
     ' its negative
     DSdata = ( DSdata # 0xffff ) + 1 ' take twos comp
     SignBit = true
   else
     SignBit = false
   end if

   readtemp =  DSdata * 6   ' convert raw data 12 bit value of 0.0625
   DSdata = ( DSdata * 25 ) / 100
   readtemp = readtemp + DSdata

   Whole = readtemp / 100
   fraction = TempC_100 % 100
   if fraction > 50 then
      Whole++
   end if

   if SignBit = true then
      readtemp = Whole + 128
   else
      readtemp =  Whole
   end if


end macro



Macro DS18B20DeviceRead ( DQPort )
  ' This routine makes available a variable called DSdata
  ' DSdata is the raw data value from the sensor
   Dim DS18B20DeviceReadBusy as byte
   wait 250 ms             ' Not really needed but left in just in case ***
   MasterRST  DQPort       ' Reset ds18b20
   PPulse DQPort           ' Request a presence pulse
   wait 1 ms
   OWout DQPort, SkipRom   ' Bypass ds18b20 serial number read
   wait 1 ms
   OWout DQPort, ConvertT  ' Instruct ds18b20 to begin temperature conversion to digital

   repeat DS18B20DeviceReadRetry  'try a number of times - sets DS18B20DeviceReadBusy = true if not valid read
      dir DQPort  out
      Set DQPort  Off
      wait 4 us
      Dir DQPort  In
      wait 7 us
      DS18B20DeviceReadBusy = true
      If DQPort = 1 Then
        DS18B20DeviceReadBusy = false
        exit Repeat
      end if
      wait 60 us    'minimum 60 us time slots between reads
   end repeat

    ' The device is ready to be read
    If DS18B20DeviceReadBusy = false then
       MasterRST DQPort
       PPulse DQPort                   '
       OWout DQPort, SkipRom         ' Bypass ds18b20 serial number read
       OWout DQPort, ReadScratch     ' Read temperature from db18b20
       Owin DQPort                   ' Receive temperature low byte from db18b20
       DSdata = RxData               ' First byte  is low byte
       Owin DQPort                   ' Receive temperature high byte from db18b20
       DSdata_H = RxData             ' Second byte is high byte  (auto combined into 16 bit word)
    End if

end Macro


'Utility routines for the device

'''@hide
Macro  MasterRST  ( DQPort )' Master reset low for minimum 480 us
 Dir DQPort In
 Dir DQPort Out
 Set DQPort Off
 wait 60 10us   ' Set to 60 10us for longer wires
 Dir DQPort In      ' HiZ
end Macro

'''@hide
Macro  PPulse (DQPort)               ' Master receive DS18B20 presence pulse
  wait 100 us             ' Set to 100us for long bus wires         'test code
  wait 43 10us
  Dir DQPort In
end Macro

'''@hide
Macro  OWout (DQPort, OWoutCommand)

 dim  ClocksA, _OWoutCommand  as byte
 _OWoutCommand = OWoutCommand
 For ClocksA = 1 to 8
  Dir DQPort Out
  Set DQPort Off
  wait 3 us    ' Need to release bus within 15 us
  If _OWoutCommand.0  On then
  Dir DQPort In
  End if
  wait 100 us  ' Set to 60 us per AN2420 datasheet indicates MAX delay is 120 us . changed to 100uS for longer wires. Only relevant for writing zeros
  Dir DQPort In    ' HiZ the bus if still pulled low
  wait 3 us
  ROTATE _OWoutCommand Right  'The DS18B20 wants data LSB first
 Next ClocksA
end Macro

'''@hide
Macro OWin ( DQPort )
   dim  ClocksB  as byte
   ' Sets RxData
   For ClocksB = 1 to 8
      Rotate RxData Right
      Dir DQPort Out
      Set DQPort Off                   ' Read time slot
      wait 6 us                        ' Minimum is 1uS
      Dir DQPort In                    ' Release bus for one wire Reception
      wait 4 us
      If DQPort On  Then RxData.7 = 1
      If DQPort Off Then RxData.7 = 0
      wait 60 us                   ' Set to 60 uS  for use with longer wires
   Next ClocksB

end Macro

Macro DS18B20SetResolution ( DQPort, DS18B20SetResolutionValue  )

      wait 250 ms ' Not really needed but left in just in case ***
      MasterRST DQPort
      PPulse DQPort
      wait 1 ms
      OWout DQPort, SkipRom        ' Bypass ds18b20 serial number read
      wait 1 ms
      OWout DQPort, WriteScratch
      wait 1 ms
      OWout DQPort, 0x00             'User byte 0 - Unused
      OWout DQPort, 0x00             'User byte 1 - Unused

      If DS18B20SetResolutionValue=DS18B20_TEMP_9_BIT Then OWout ( DQPort, DS18B20_TEMP_9_BIT )  'set up 9bits
      If DS18B20SetResolutionValue=DS18B20_TEMP_10_BIT Then OWout ( DQPort, DS18B20_TEMP_10_BIT )  'set up 10bits
      If DS18B20SetResolutionValue=DS18B20_TEMP_11_BIT Then OWout ( DQPort, DS18B20_TEMP_11_BIT )  'set up 11bits
      If DS18B20SetResolutionValue=DS18B20_TEMP_12_BIT Then OWout ( DQPort, DS18B20_TEMP_12_BIT )  'set up 12bits

      wait 250 ms ' wait for write to complete

End Macro