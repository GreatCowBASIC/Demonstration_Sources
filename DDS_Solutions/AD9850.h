'**********************************************************
' file: EAD9850_1.02.h / 2023-11-27
'**********************************************************
'***    contains all parts to handle the DDS AD9850     ***
' SUB Init9850 init and set ad9850 to serial input
' SUB Upd_DDS  calculation of tuning word if frequency is changed
' SUB load_9850 sends bitwise tuning_w with SUB SendBit
' SUB SendBit   transmitting the bits to 9850
' SUB tune_f    for compensating main oscillators deviation
' SUB Get_FixDiv Getting and storing of value for FixDiv
'**********************************************************

sub init9850
' init and set ad9850 to serial input

' reset chip
  PulseOut ad9850_reset, 2 us
  wait 10 us

  ''' -- serial load enable setup --
  ' *** HAS TO BE MADE AT HARDWARE ***
  ' for device start-up in serial mode
  ' pin 2 and pin 3 at Vcc , pin 4 at GND
  ' D2 low, D0, D1 high
  ''' ---------------------------------
  ' Inputs Reset, Freq_Upd, W_Clk 4k7 to GND
  ''' ---------------------------------

  ' data (serial)required to reset control registers
  ' note: w32 and w33 should always be set to 0.

   pulseOut AD9850_W_Clk, 2 us
   pulseOut ad9850_fu_ud, 2 us

end sub

sub Upd_DDS(mDS as Bit)
' makes the calculation every time frequency is changed and DDS is ON.
' following the formula: tuningWord = Fout / ( fosc / 2E32)
' Fosc = 125.000.000Hz, 2E32 = 4.294.967.296
' so divisor is 0,029103830456...Hz/BIT
' we use "029103831" as starting value for fix_divisor

    If mDS = ON then

      ' calculate tuning word
        dividend = LongtoString(freq)

      ' result of division as string
        result = float_div(dividend)
        tuning_w = Str32(result)

    End if

   ' load tuning word to DDS
     load_9850(mDS)

end sub

sub load_9850(DS as BIT)

dim myByte as Byte

 'DDS_state  DS: 0 = OFF, 1 = ON
 'send bitwise tuning_w from right (LSB) to left (MSB) to AD9850

 'lowest Byte of long, W0 to W7
 myByte = tuning_w
 sendbit(myByte)

 'lower midByte of long, W8 to W15
 myByte = tuning_w_H
 sendbit(myByte)

 'upper midByte of long, W16 to W23
 myByte = tuning_w_U
 sendbit(myByte)

 'highest Byte of long, W24 to W31
 myByte = tuning_w_E
 sendbit(myByte)

 ' after sending tuning word now bit 32 to 39:
 ' bit 32 and 33: controlbits ever "00"
 ' bit 34: power off "1" / power ON "0"
 ' bits 35 to 39: phase "00000"
 ' makes DDS OFF: myByte = b'00000 1 00'
 ' makes DDS ON : myByte = b'00000 0 00'

  ' W32 Control ever 0 (LSB)
  ' W33 Control ever 0
  ' W34 Power-Down  ; 0 = ON, 1 = OFF
  ' W35 Phase-b0 ever 0
  ' W36 Phase-b1 ever 0
  ' W37 Phase-b2 ever 0
  ' W38 Phase-b3 ever 0
  ' W39 Phase-b4 ever 0 (MSB)

  ' as BYTE: W39, W38, W37, W36, W35, W34, W33, W32
  ' DDS OFF = b '00000 1 00' , h 0x04, # 4
  ' DDS ON  = b '00000 0 00' , h 0x00, # 0
  ' to be sent LSB to MSB

 if DS then  ' DDS ON

    myByte = 0
    set LED = ON

  else       ' DDS OFF

    myByte = 4
    set LED = OFF

 end IF

 sendbit (myByte)

 ' set new frequency
   pulseout ad9850_fu_ud, 1 us
   ' wait 1 us

 ' loaded serial word (40 Bit) to DDS
 ' frequency update finished

  end sub

sub sendbit ( oByte as Byte )

dim oData as Bit
dim sr as Byte

 for sr = 1 to 8

  ' mask last bit
    ' oData = fnEquBit(myByte & 0x01)
    oData = oByte & b'00000001'

  ' set data to Port
    setwith(AD9850_data, oData)

  ' While port is set, write to Port
  ' active at ascending flank, so wait is not needed
    pulseOut AD9850_W_Clk, 1 us

    rotate oByte right

 Next

end sub

Sub adjust_F
 ' comes here from Menu-selection per Button-press meSwP
 ' show what to do
 ' fixed divisor is changed through encoder turning
 ' and saved to EEPROM #0 / h00
 ' Starting output frequency is set to 10MHz.
 ' By varying the fix divisor 1 digit each detent
 ' the deviation of the 125MHz oscillator is compensated
 ' with 4.7Hz per detent positive or negative.

  ALL_OFF  ' reset all flags

  cls

  locate 0,0
  print " this is to set "
  locate 1,0
  print "DDS to true freq"
  wait 2 s

  locate 0,0
  print "to cont. press M"
  locate 1,0
  print "to esc. press E "


  do

    read_SW  ' read switches

  loop  until rSwP


  If eShortP | eLongP  then  'encoder switch pressed only

    locate 0,0
    print " you  did  abort"
    locate 1,0
    print "                "
    wait 2 s

  end If

  If mSwP then ' only menu-switch pressed

    tune_f

  end if

    ALL_OFF    ' reset all flags
    cls        ' clear screen

    LCDCMD 14             ' cursor underscore on
    disp_freq(0, 1, freq) ' displays frequency
    locate 0, dPos        ' sets cursor

end Sub

Function float_Div(in dividend as string * 20) As String * 10
' gets in frequency as string value for dividend, max 10 digits
' dividend has to be defined before in main program
' is devided by fix_Divisor of 0,029103831 Hz/Bit
' fixDivisor has to be defined before in main program
' fixDivisor comes as string*8, min 10E-9
' result returns as float_Div for tuning_w as string *10

'*************************************************************
' calculation frequency part of tuning_word
' through division of two longs
' in main program the variables have to be dim'ed as
/*
  DIM fixDivisor as string * 9  ' oscillatorfreq / 2E16
  DIM Dividend   as string * 11' frequency to be calculated
*/
'*************************************************************

Dim len_dividend      as byte
Dim str_temp_dividend As String * 11
Dim temp_dividend     as long

DIM str_Divisor as string * 9
DIM divisor     as long
DIM len_divisor As Byte

Dim temp_result      As long
Dim int_result       As Byte
Dim temp_len_divisor As Byte
Dim temp_count_div   As Byte


 ' take string fixDivisor to str_divisor
   str_divisor = fixDivisor

 ' initiate result
   float_div = ""

 ' handle divisor, length is total dec part
   len_divisor = len(str_divisor)

 ' handle dividend (is frequency changed to string)
 ' get rid of leading and following spaces
   dividend = trim(dividend)

 ' get real length of frequency value
   len_dividend = Len(dividend)

 ' to avoid division throug decimal parts, multiply dividend
 ' (here: add "0" at the end)
   for temp_len_divisor = 1 to len_divisor

     dividend = dividend + "0"

   next

 ' new length of dividend, max 10 + 9 digits '0'
 ' now division is made with long variables...
 ' we handle up to 19 #-digits for dividend (frequency)
 ' and 9 digits for divisor
  len_dividend = Len(dividend)

  'remove leading zeros from divisor
  do

    if left(str_divisor, 1) = "0" then

     'get right part without 1. digit
     str_divisor = right(str_divisor, len_divisor -1)
     'new length
     len_divisor = len (str_divisor)

    else

       exit do

    end if

  loop

  ' now no leading zero on divisor
  ' first part from dividend, 1 more digit length than divisor
  ' is used for dividing through fixDivisor (Hz/Bit)
   temp_len_divisor = len_divisor + 1
   divisor = Str32(str_divisor)

  ' starting division with first digits from dividend
  ' one digit longer than divisor
     str_temp_dividend = left(dividend,temp_len_divisor)

  ' convert string to long
     temp_dividend = Str32(str_temp_dividend)

  ' do the division
     int_result = temp_dividend / divisor

  ' make a control for rounding
     temp_result = int_result * divisor

      If temp_result > temp_dividend Then

        'instead rounding
        int_result = int_result - 1
        temp_result = int_result * divisor

      End If

  ' result cannot be zero, append result to string of float_div
    float_div = float_div + str(int_result)
  '--------------------------------------------

   For temp_count_div = temp_len_divisor + 1 To len_dividend

     ' remaining part for next division
       temp_dividend = temp_dividend - temp_result

     ' get next digit from dividend and add it to dividend
       str_temp_dividend = LongtoString (temp_dividend)

     ' get next digit from dividend
       str_temp_dividend = str_temp_dividend + Mid(dividend, temp_count_div, 1)

     ' new dividend's value
       temp_dividend = Str32(str_temp_dividend)

       int_result = temp_dividend /  divisor
       temp_result = int_result * divisor

     ' make a control for rounding
       If temp_result > temp_dividend Then

         'instead rounding
          int_result = int_result - 1
          temp_result = int_result * divisor

       End If

        float_div = float_div + str(int_result)

   Next


End Function

sub Get_fixdiv
   ' set or load fix-divisor
   ' DDS with AD9850 125MHz uses fixDivisor = "029103831"
   ' as divisor to calculate tuningword
   ' WriteEeprom ( in loc, in Str *8 )
   ' write to EEPROM, if not done before
   ' first do a read to specified location
   ' if not empty, write it (first use)
   ' write to h0x0 / #0

   mTempStr = "29103831"  'starting value for first (uncompensated) use
        loc = 0  ' h 00

     EPRead loc , mChr

  if mChr < 255 Then

     mTempStr = ""

    for ee = 0 to 7  'all values in string*8

     EPRead loc + ee, mChr
     mTempStr = mTempStr + chr(mChr)

    next

  else

    ' Write to the device's eeprom
      WriteEeprom ( loc, mTempStr )


  end if

     fixDivisor = "0" + mTempStr
     mTempStr = ""

end sub
'
sub tune_f

  ' aligning DDS to real frequency
  ' show fix_Divisor and changes via Encoder
  ' compensate 125MHz-oscillator deviation by 4.31 Hz / step
  ' or 0.343 Hz/step at fout = 10MHz
  ' while turning encoder see divisor changing and frequency direction
  ' update DDS after any step
  ' Starting output frequency is set to 10MHz.
  ' By varying the fix divisor 1 digit each detent
  ' the deviation of the 125MHz oscillator is compensated
  ' with 4.31Hz per detent positive or negative.
  ' the output frequency changes adequate.
  ' If ready, write new value for divisor to eeprom
  ' use new value as fix_divisor, string * 8
  ' tuning_W = 343597384 for 10MHz (with 0,029 Hz/ step)
  ' stays the same.
  ' fix_divisor start value = 0,029103831

  ' new value saved to EEPROM #0 / h0x00
  ' 0,029104005 at 6ppm + (750Hz)
  ' 0,029103976 at 5ppm + (625Hz)
  ' 0,029103947 at 4ppm + (500Hz)
  ' 0,029103918 at 3ppm + (375Hz)
  ' 0,029103889 at 2ppm + (250Hz)
  ' 0,029103860 at 1ppm + (125Hz)
  ' 0,029103831 at 0 deviation

   dim oDivisor as string * 9
   DIM ovDivisor as long
   dim vDivisor as Long
   dim DeltaF as string * 12
   dim dDif as long
   dim VZ as bit

   ALL_OFF   'reset all flags

' save last frequency and divisor
   oFreq = freq
   oDivisor = fixDivisor

' set dds to 10MHz and ON
   readtable steps, 7, freq  ' 10MHz
   upd_DDS(ON)

' place to store new divisor in eeProm
   loc = 0

'divisor from string to number
   vDivisor = Str32(fixDivisor)
  ovDivisor = vDivisor

' now change divisor by turning encoder
' display what to do

   cls
   locate 0,1
   print vDivisor
   locate 1,0
   print "  turn encoder  "


   do   'stays in loop till button is pressed
        'read 1st: encoder, 2nd: M-button

      read_enc

      if rSwP then exit do  'any button was pressed

      vz = 0

     if delta < 0 then

        vDivisor--

     Else if delta > 0 then

        vDivisor++

     end if

     if delta <> 0 then ' value has changed

      fixDivisor = "0" + LongtoString(vDivisor)

     ' show changes
      if vDivisor > ovDivisor then
        vz = 0 ' id "+"
        dDif = vDivisor - ovDivisor
      else
        vz = 1 ' id "-"
        dDif = ovDivisor - vDivisor
      end if

     ' display new divisor
       locate 0,1
       print vDivisor
       print "  "
       Locate 0,12

     ' calculate changed values
       step_To_Freq (dDif , vz)

      'divisor changed, update DDS
       upd_DDS(ON)

      end if

   loop   'end inner loop changing fixDivisor

   ' gets here after pressed any switch
   ' delete all flags
    ALL_OFF
   ' show what to do
   ' now press M to write to eeProm
   ' E exit from tune without change

    cls
    print " M-Sw to update "
    locate 1,0
    print "Enc-SW to escape"

    'wait for switches, read switches
      do
          read_SW  ' read switches

          If eShortP| eLongP then   ' only encoder switch was pressed

             fixDivisor = oDivisor  ' reset to old value, not changed
             cls
             print " tuning aborted "

            exit do

          End If

          If mSwP then

           ' save new value of fixDivisor to eeProm
             mTempStr = LongtoString(vDivisor)
             WriteEeprom ( loc, mTempStr )
             cls
             print "  DDS is tuned  "

            exit do

          end if

      loop

       upd_DDS(OFF) ' generator off
       wait 3 s

       freq = oFreq  ' get old frequency

       ALL_OFF       ' reset all flags

End sub

Sub Step_to_freq (in dDif as word, Vz)
' calculates and displays delta frequency for any step done

' uses variables set in main before starting this function
' ovDivisor is number value of starting tuning-word
' vDivisor is changed value of tuning-word
' dDif is difference between vDevisor and ovDivisor (number of steps)
' DeltaF  is steps (dDif) multiplied with 0.343 Hz/step as string

dim dFreq    as Long       ' to 4.3mio
dim nTempstr as string * 12
dim DeltaF   as string * 12
dim sign as String

mTempStr = ""
nTempStr = ""

dFreq = dDif * 343
mTempStr = LongtoString(dFreq)

' now construct output string to Display as
' "0.0" "0.###" or "#.###"
 If dDif < 3 then
   nTempStr = "0." + mTempStr
 else If dDif < 30 then
   nTempStr = left(mTempStr,1) + "." + right(mTempStr, 3)
 else if dDif < 300 then
   nTempStr = left(mTempStr,2) + "." + right(mTempStr, 3)
 else
   nTempStr = left(mTempStr,3) + "." + right(mTempStr,3)
 End If

locate 0,12
print "     " 'clear digits
locate 0,12


 If VZ then
   Sign = "-"
  else
   Sign = "+"
 End If

if dDif = 0 then Sign = " "

print sign
print dDif

DeltaF = sign + nTempStr + "Hz"
' print result
   locate 1,0
   print "fout:           "
   locate 1,6
   print DeltaF

End Sub
