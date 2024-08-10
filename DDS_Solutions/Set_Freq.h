'*********************************************************************
' file: Set_freq.h  2023-12-08
'*********************************************************************
' contains folowing subs:
' Sub FixFreq       : Main loop to adjust frequency
' Sub Set_Steps     : getting step width from table and display string
' Sub Sel_freq      : tuning the DDS with encoder
' Sub disp_Freq     : show changed frequency on display
' Sub readValues    : prime process for loading adjustment values
' Sub saveValues    : prime process for saving adjustment values
' Sub WriteEeProm   : writes values to EEProm
' Sub Limits_Touched: show "reached tuning limits"

'' 2023-12-12
' Changes in Sel_freq: save frequency sets after extreme long push
' on encoder button. (>500ms until display blinks) during setting frequency
' also little corrections without notice.
'
'*********************************************************************
sub fixFreq

  rSwP = OFF  'delete all button flags
  mSwP = OFF

  LCDCMD 14             ' cursor underscore on
  disp_freq(0, 1, freq) ' displays frequency
  locate 0, dPos        ' sets cursor

  upd_DDS(ON)           ' set generator on

 do

   ' get steps value
     set_steps(2)    ' max. step position is set to 1MHz

     rSwP = OFF   ' flag encoder-sw or menu-switch pressed

   ' directly leave loop if menu button pressed before
     If mSwP then

       exit do    ' adjust oscillator frequency

     END IF

   ' else continue to change frequency, stay at tuning generator
     sel_freq

 loop until mSwP ' end loop only when menu button pressed

  ' save last values
    saveValues

  If mSwP then

   upd_DDS(OFF)           ' set generator off for compensating Osc

  End If



 ' cursor underscore off
   LCDCMD 12

 ' here you will come after menu switch pressed

END sub

Sub set_steps(pMin)

' pMin is most left possible position of cursor for maximal 1MHz steps,
' selects new multiplyer / step-width
' gets string dMulti and value for fMulti for dPos
' is ended by any button-Press, only mSwP is returned if occured

 oPos = dPos  'starting with dpos, remember in oPos

 'create step display
 locate 1,0
 print "sel step:       "
 locate 1,9                  ' print step
 print dMulti
 locate 0, dPos              ' set cursor
 LCDCURSOR FLASHON           ' flashing cursor

 'switch not pressed
  mSwP = OFF                 ' menu-switch marker off
  rSwP = OFF                 ' encoder-switch marker off

 do

   ' cursor is set to flash block
   ' get first step width by turning encoder
   ' returns delta as +1 or -1 if no button pressed
   ' if cw turned, directn = ON

     read_enc

      if rSwP then  ' leave set if any button is pressed

        ' any button pressed, set cursor to normal
          LCDCURSOR FLASHOff

              If MSwP then

               ALL_OFF
               mSwP = ON '  aligne generator

              END IF

        ' leave loop
          exit do

      else
         oPos = dPos
         dPos = dPos + delta

       ' limits for dPos are 1 to 10
       ' repeat if limits reached
         if dpos < pMin or dpos > 10 Then ' = 11 then

          ' set to last position noted before, don't go further
            dPos = oPos

         end if

       ' check new position of cursor
       ' skip pos 3 and 7, is decimal point and blank
       ' -> read new value

          if dPos = 3 then

            if oPos = 2 then
              dPos = 4
             Else
              dPos = 2
            end if

          end if

          if dPos = 7 then

            if oPos = 6 then
              dPos = 8
             Else
              dPos = 6
            end if

          end if

       end if

      new_step     ' gets string dMulti and value fMulti for dPos

      locate 1,9                   'print step
      print dMulti

      locate 0, dPos              ' set cursor

 loop     'while no Button pressed

' next go to sel_freq (changing frequency via encoder)

end sub

sub sel_freq

   ' frequency is changed by turning encoder with step width set before
   ' show what to do on Display

     locate 1, 0
     print "select frequency"

     locate 0, dPos       'return cursor to prior position

 do

      read_enc

       if rSwP then exit do  ' any switch is pressed

      oFreq = freq           ' remember actual freq.

     if delta < 0 then

      if fMulti < freq then  ' frequency greater step

        freq = (freq - fMulti)

      Else                   ' frequency <= step

        freq = oFreq         ' go back to old value

        limits_touched("lo limit reached") ' tell me what's on

     end if

   End if

   if delta > 0 then  ' count up

     freq = (freq + fMulti)

     if freq > f_max Then   ' frequency is grater than upper limit

        freq = oFreq        ' go back to old value

        limits_touched("up limit reached") ' tell me what's on

     end if

   end if


   if oFreq <> freq then  ' frequency successful changed

    'display new frequency
     disp_freq(0, 1, freq)

    'reatore cursor
     locate 0, dPos

    'frequency is changed, update DDS
     upd_DDS(ON)

   end if

 loop  ' until button pressed

' to save frequency in between after elLongP
      If elLongP then

        All_OFF       ' reset all button flags
        saveValues    ' save frequency sets

       locate 1,0
        print "frequency  saved"
        wait 2 s

       ' go back to frequency selection
         sel_freq

     End If

     If MSwP then    ' go to adjust to real frequency

       rSwP = OFF    ' all but mSwP are suppressed

     end IF          ' encoder switch pressed returns only

end sub

sub disp_freq (row, pos, sFreq as long)
' formats frequency string with dec-point and units to display
' i.e. 10.000 000 MHz, 25.000 kHz or 900 Hz
' at row, pos

 dim fLen as byte
 dim fUnit as string * 4
 fUnit = " Hz "

 mTempStr = STR32(sfreq)
 mTempStr = LeftPad(mTempStr, 10)

' after MHz insert "." and change units to MHz
  if mid(mTempStr,4,1) <> " " then ' more than 6 digits

    mTempStr = left(mTempStr,4) + "." +mid(mTempStr,5,3) +" "+ right(mTempStr,3)
    fUnit = " MHz"
    goto dpDone

  end if

' after kHz insert "." and change units to kHz
  if mid(mTempStr,7,1) <> " " then ' minimum 4 digits

    mTempStr = left(mTempStr,7) + "." + right(mTempStr,3)
    fUnit = " kHz"

  end if

dpDone:
  mTempStr = right(mTempStr,10) + fUnit

  locate row, pos
  print mTempStr

end sub

sub readValues

' read all values from EEPROM to variables

  for vv= 2 to 6     ' loc at eeProm #16 to #56

    loc = vv * 8     ' values starting at #16 / h10
    mTempStr= ""

    for ee = 0 to 7  ' all values in string*8

      EPRead loc + ee, mChr
      mTempStr = mTempStr + chr(mChr)

    next

    mTempStr =trim(mTempStr)

    select case vv

      case 2
      freq=Str32(mTempStr)   'last used frequency as number

      case 3
      fMulti=Str32(mTempStr) 'last used step width as number

      case 4
      dMulti = mTempStr      'last used step width as text to display

      case 5
      dPos = val(mTempStr)   'last used position of cursor

      case 6
      oPos = val(mTempStr)   'old position of cursor

    end select

  Next

end sub

sub saveValues

   mTempStr = STR32(freq)   ' frequency as string * 8
   WriteEeprom 16, mTempStr ' h 10

   mTempStr = STR32(fMulti) ' stepwidth
   WriteEeprom 24, mTempStr ' h 18

   mTempStr = dMulti        ' stepwidth as text
   WriteEeprom 32, mTempStr ' h 20

   mTempStr = str(dPos)     ' cursorposition
   WriteEeprom 40, mTempStr ' h 28

   mTempStr = str(oPos)     ' old cursorposition
   WriteEeprom 48, mTempStr ' h 30

end sub

sub WriteEeprom ( in loc, in mTempStr as String )

  /*for info:
   # nnn = loc's for EEPROM
   h00  # 00 fix Divisor
   h10  # 16 Frequency
   h18  # 24 Step (fMulti)
   h20  # 32 fMulti as string = dMulti
   h28  # 40 dPos actuel cursor-position
   h30  # 48 oPos old cursor position
  */

 ' Write to the device's eeprom
 ' make it 8 digits long with spaces
   mTempStr = trim(mTempStr)
   mTempStr = LeftPad(mTempStr,8)

   for ee = 1 to 8  'all values are 8 digits long

     epwrite loc, mTempStr(ee)
             loc++

   next

   mTempStr = ""

 end sub

 sub limits_touched (in message as string)
'message with 16 digits

     locate 1,0
     print message

   ' blink display
     LCDCURSOR LCDOFF
     wait 300 ms
     LCDCURSOR LCDON
     wait 1 s
   ' restore display
     locate 1,0
     print "select frequency"

     locate 0, dPos              ' restore cursor

end sub
