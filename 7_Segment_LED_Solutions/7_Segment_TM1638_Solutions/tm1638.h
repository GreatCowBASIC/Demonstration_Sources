'This library is free software; you can redistribute it and/or
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
'IMPORTANT:
'THIS FILE IS ESSENTIAL FOR SOME OF THE COMMANDS IN GCBASIC. DO NOT ALTER THIS FILE
'UNLESS YOU KNOW WHAT YOU ARE DOING. CHANGING THIS FILE COULD RENDER SOME GCBASIC
'COMMANDS UNUSABLE!
'********************************************************************************


'    7 Segment LED display routines using the TM1637  for GCBASIC
'     The TM1637 module provide a cheap bright LED Display
'     The ebay modules can be had for $1 to $4, somtimes less.
'     They only need 2 pins to control : clk and dio
'     4 digit 7 seg Display
'     They do have a  colon but no decimal points
'     Brightness can be set: 8 is display on minimum bright , 15 is display on max bright
'     Less than 8  is display off
'     The TM1637 chip has the ability to read key matrix BUT that is not included.
'    Copyright (C)  2018  Mike Otte


'Changes:
'  initial h file build  12/10/2020  by Mike Otte
'
'
' - Support for Siekoo 7 digit alphabet created by Alexander Fako°,
''   more info at:  http://en.fakoo.de/siekoo.html
'
' - 3 new special characters:
'   ° Degree sign as special character 18
'   ) Bracket sign as special character 19
'   ? Question mark as special character 20
'
' - TM_char_Bright command for set brightness with TMvhar, TMdec and TMhex command
'
' - TMdec options for enable/disable leading zeroes and colon
'
'Public Commands:
'
'Write4Dig (dig1, dig2, dig3, dig4, Brightness,  Colon)
'Command defines each digit (left to right) as 0 to 9  OR 0x00 to 0x0F  (15). Additionally  0x10  (16) is a blank, 0x11 (17) is a minus sign, 0x12 (18) is a degree sign,  0x13 (19) is a  bracket and 0x14 (20) is a question mark.
'Optional:
'Brightness set the brightness (8-15) and
'Colon  turn the colon (only on  digit 2) to off (0) or on (1)
'
'TMchar_bright = (Brightness)
'Must be defined before the first use the commands: TMdec, TMhex or TMchar, to set the brightness of the characters (8-15), without this, the display will be blank.
'
'TMDec  (Value, Options)
'Only values from 0 to 9999 can be displayed, values greater than 9999 will be  displayed as ----
'Options:
'0 or omitted, only decimal value will be displayed
'1 decimal valur with  the leading zeros
'2 decimal number with the colon on digit 2
'3 decimal number with the colon on digit 2 and the leading zeros
'
'TMHex  (Value)
'Values from 0x0000 to 0xFFFF can be displayed
'
'
'WriteChar (TMaddr, char)
'TMaddr is 0 , 1 , 2 , 3 (display left to right)
'TMchar is a letter from A to Z for default or  letterd from a to z  for Siekoo alphabet
'You can insert the special characters (blank, -, ) and/or ?)
'
'TM_Print allows printing of 8 char or less string
'TM_Print prints a byte, word, integer, long as a decimal number
'
' Remember you must define the three 3  ports in the main program
'#define TM1638_DIO PORTa.z
'#define TM1638_Clk PORTa.x
'#define TM1638_STB PORTa.v

'commands

#define TM_ACTIVATE 0x8F // Start up
#define TM_BUTTONS_MODE 0x42 // Buttons mode
#define TM_WRITE_LOC 0x44 // Write to a location
#define TM_WRITE_INC 0x40 // Incremental write
#define TM_SEG_ADR 0xC0  // leftmost segment Address C0 C2 C4 C6 C8 CA CC CE
#define TM_LEDS_ADR 0xC1  // Leftmost LED address C1 C3 C5 C7 C9 CB CD CF
#define TM_BRIGHT_ADR 0x88 // Brightness address
#define TM_BRIGHT_MASK 0x07 // Brightness mask
#define TM_DEFAULT_BRIGHTNESS 0x02 //can be 0x00 to 0x07
#define TM_DISPLAY_SIZE 8 //size of display

#define TM_ASCII_OFFSET 32 // Ascii table offset to jump over first missing 32 chars
#define TM_HEX_OFFSET   16 // Ascii table offset to reach number position
#define TM_DOT_MASK_DEC    128 // 0x80 Mask to  switch on decimal point in seven seg.


#startup InitTM1638

Sub InitTM1638
  dim DispTemp as Byte
  dim Bright as Byte
  Dim buttons as byte
  Dim butVal as byte
  Dim temp as byte
  Dim ButArray(4)

  set TM1638_STB on

  Brightness = 15  'full brightness and turn on display

  #ifdef TM1638_DIO
    Dir TM1638_DIO Out
  #endif
  #ifdef TM1638_CLK
    Dir TM1638_CLK Out
  #endif
  sendCommand(TM_ACTIVATE)
  value = TM_BRIGHT_ADR + (TM_BRIGHT_MASK & brightness)
  SendCommand(value)
  TM_reset()                'clears display
end sub

sub sendCommand( value)

  set TM1638_STB off
  sendData(value)
  set TM1638_STB on
end sub

sub sendData(data)

    for yy = 1 to 8
        set TM1638_CLK off
        wait 5 us
        if data & 1 = 1 then
            set TM1638_DIO on
        else
            set TM1638_DIO off
        end if
        wait 5 us
        set TM1638_CLK on
        wait 5 us
        data = FnLSR(data, 1)
    next yy

end sub

'TM_reset  Clears the display  and Leds
sub TM_reset
  sendCommand(TM_WRITE_INC)' set auto increment mode
  set TM1638_STB off
  sendData(TM_SEG_ADR)  ' set starting address to

  repeat 16
    sendData(0x00)  'sendData(0x00)
  end repeat

   set TM1638_STB on

end sub

sub TM1638_setLED(TMaddr,  TMseg2)
  sendCommand(TM_WRITE_LOC)
  set TM1638_STB off
  sendData(TM_LEDS_ADR + (TMaddr *2))
  sendData(TMseg2)
  set TM1638_STB on
end sub

sub TM_setbrightness( brightness)

    value = 0
    value = TM_BRIGHT_ADR + (TM_BRIGHT_MASK & brightness);
    sendCommand(value)

end sub




'Numbers for display - support 0x00 to 0x0F
Table SevenSegDispDigit
  63 '0
  6
  91
  79
  102
  109
  125
  7
  127
  111 '9
          0x77
          0x7c
          0x39
          0x5e
          0x79
          0x71
          0x00  'blank
          0x40  ' -  dash
          0x63  'degree
          0x0f  'bracket
          83    'queastion mark
End Table

'Letters for display
'Letter is at ASC - 64, so A at 1, B at 2, etc
Table SevenSegDispLetter
  119 'A
  124 'B
  57 'C
  94 'D
  121 'E
  113 'F
  61 'G
  118 'H
  6 'I
  14 'J
  118 'K
  56 'L
  55 'M
  55 'N
  63 'O
  115 'P
  103 'Q
  80 'R
  109 'S
  7 'T
  62 'U
  62 'V
  62 'W
  118 'X
  110 'Y
   27 'Z
  95  'a Siekoo alphabet char map
  124 'b by Alexander Fakoo 2012
  88  'c
  94  'd
  121 'E
  113 'F
  61  'G
  116 'h
  4   'i
  13  'j
  117 'k
  56  'L
  85  'M
  84  'n
  92  'o
  115 'P
  103 'Q
  80  'r
  45  'S
  120 't
  28  'u
  42  'v
  106 'W
  20  'x
  110 'y
  27  'Z
End Table

'This subroutine is used by the TMDec and TMHex subroutines to write
' 4 digits representing numbers 0-9999 or 0-FFFF hex
' It has the optional parameters to adjust brightness
' and to turn the decimal point on TM1638 , on / off   1 / 0
sub Write4Dig (In TMdig1, In TMdig2, In TMdig3, In TMdig4, Optional In Bright=15, Optional In ColonON = 0)
    'TMdigx is number 0 -15 , 16 =sp , 17 = -
    'convert digit number to 7segments
    ReadTable SevenSegDispDigit, TMdig1 + 1, TMseg1
    ReadTable SevenSegDispDigit, TMdig2 + 1, TMseg2
    ReadTable SevenSegDispDigit, TMdig3 + 1, TMseg3
    ReadTable SevenSegDispDigit, TMdig4 + 1, TMseg4
    If ColonON = 1 then
     TMseg2 = TMseg2 | 0B10000000   'turns on the colon
    End if
    sendCommand(0x44)
    TMchar_Bright = Bright
    'value = TM_BRIGHT_ADR +  TMchar_Bright   'brightness
    SendCommand( TM_BRIGHT_ADR + (TM_BRIGHT_MASK & Bright))
    'WriteChar(0,TMdig1)
    'wait 2 s
   TM_display7Seg (0,TMseg1)
   TM_display7Seg (1,TMseg2)
   TM_display7Seg (2,TMseg3)
   TM_display7Seg (3,TMseg4)

end sub

sub TM_display7Seg(TMaddr, TMseg1) ' call 7-segment

  sendCommand(TM_WRITE_LOC)
  set TM1638_STB off
  sendData(TM_SEG_ADR + (TMaddr *2))
  sendData(TMseg1)
  set TM1638_STB on
end sub

'This routine writes an Ascii char on the specified 7 seg digit
'On the TM1638 the addresses are 0,1,2...7
'example of use
'WriteChar (0 , "Z")
'WriteChar (1 , "e")
'
sub WriteChar (In TMaddr, In TMchar)
  ' TMaddr  0 ,1, 2 ,3    digit postion to display
  'TMchar   ascii character  to display
  if TMchar_Bright > 15 then TMchar_Bright = 15

  value = TM_BRIGHT_ADR + (TM_BRIGHT_MASK & TMchar_Bright)   'brightness
  SendCommand(value)
  'write ascii letter or number or sp or -
  If TMchar = 32 Then     ' space?
    TMseg1 = 0
    Goto ShowChar
    End if

  ' -
  If TMchar = 45 Then      'minus -
      TMseg1 = 64
      Goto ShowChar
  End if

  If TMchar = 41 Then     ' )
      TMseg1 = 15
      Goto ShowChar
  End if

  If TMchar = 176 Then     '
      TMseg1 = 99
      Goto ShowChar
  End if

  If TMchar = 63 Then     ' ?
      TMseg1 = 83
      Goto ShowChar
  End if

'Numbers
  If TMchar >= 48 And TMchar <= 57 Then
    ReadTable SevenSegDispDigit,  TMchar-47, TMseg1
    Goto ShowChar
  End If

  If TMchar < 65 Then Exit Sub    'should have been covered as number and space and -
  'Convert to upper case

  If TMchar > 96 Then           ' small case letter use Siekoo alphabet
      TMchar = TMchar - 6
  End if

  'Exit if not a letter
  If TMchar > 116 Then Exit Sub

  'Convert to code for output
  ReadTable SevenSegDispLetter, TMchar -64, TMseg1
ShowChar:
  TM_display7Seg(TMaddr,  TMseg1)

end sub

sub TMDec  ( In  TMValue as word, Optional TM1638_Zero as byte = 0)', , Optional TM1638_Colon as byte = 0)
    'TM_reset
    'TMValue must be in the range of 0 to 65535 (Dec)
    'TMValue can be entered as dec, binary or hex
    TMsVal = 0
    TMeVal = 0
    TMhVal = 0
    TMlVal = 0
    TM1638_Colon = 0


    IF TMValue >= 10000 Then
    TMsVal = 17
    TMeVal = 17
    TMhVal = 17
    TMlVal = 17
    Goto TMWord1
    End if


          TMWord1000:
          IF TMValue >= 1000 Then
                    TMsVal = TMsVal + 1
                    TMValue = TMValue -1000
                    Goto TMWord1000
          End If
          TMWord100:
         IF TMValue >= 100 Then
                    TMeVal = TMeVal + 1
                    TMValue = TMValue - 100
                    Goto TMWord100
          End If
          TMWord10:
          IF TMValue >= 10 Then
                    TMhVal = TMhVal + 1
                    TMValue = TMValue - 10
                    Goto TMWord10
          End if
            TMlVal = TMValue
 if TM1638_Zero > 3 Then TM1638_Zero = 0
 if TM1638_Zero = 0 Or TM1638_Zero = 2 Then
    if TMsVal = 0 Then TMsVal = 16
    if TMsVal = 16 And TMeVal = 0 Then TMeVal = 16
    if TMeVal = 16 And TMhVal = 0 Then TMhVal = 16
 End if

if TM1638_Zero > 1 Then TM1638_Colon = 1
    TMWord1:
    Write4Dig ( TMsVal, TMeVal, TMhVal, TMlVal,TMchar_Bright, TM1638_Colon)

end sub
sub TMHex  ( In  TMValue as word)
    'TM_reset
    'TMValue must be in the range of 0 to 65535 (Dec)
    'TMValue can be entered as dec, binary or hex
    TMsVal = 0
    TMeVal = 0
    TMhVal = 0
    TMlVal = 0

          IF TMValue >= 4096 Then
                    TMsVal = TMValue / 4096
                    TMValue = TMValue % 4096
          End If
          IF TMValue >= 256 Then
                    TMeVal = TMValue / 256
                    TMValue = TMValue % 256
          End If
          IF TMValue >= 16 Then
                    TMhVal = TMValue / 16
                    TMlVal = TMValue % 16
          End If

    Write4Dig ( TMsVal, TMeVal, TMhVal, TMlVal,TMchar_Bright,0)

end sub



sub TM1638_readButtons

 buttons = 0
 set TM1638_STB off
 sendData(TM_BUTTONS_MODE)

 wait 3 us
 Dir TM1638_DIO In
 for  ii = 1 to 4

    for yy = 1 to 8
        set TM1638_CLK off
        wait 1 us
         'butVal.0 = TM1638_DIO
        set TM1638_CLK on
        wait 1 us
        butVal.0 = TM1638_DIO
        rotate butVal left
    next
  'butArray(ii) = butVal
 buttons = buttons + butVal*ii
 wait 2 us
 next

 Dir TM1638_DIO Out
 set TM1638_STB on
 'return buttons

end sub

sub TM_Print (In PrintData As String)

  PrintLen = PrintData(0)

  If PrintLen <> 0 then
    If PrintLen >8 then Exit Sub

    for SysPrintTemp =  1 to PrintLen
      WriteChar (SysPrintTemp-1, PrintData(SysPrintTemp))

    next
  End If


end sub



sub TM_Print (In SerPrintVal)

  OutValueTemp = 0

  IF SerPrintVal >= 100 Then
    OutValueTemp = SerPrintVal / 100
    SerPrintVal = SysCalcTempX
    WriteChar( 5,OutValueTemp + 48  )

  End If
  If OutValueTemp > 0 Or SerPrintVal >= 10 Then
    OutValueTemp = SerPrintVal / 10
    SerPrintVal = SysCalcTempX
    WriteChar (6,OutValueTemp + 48  )
  End If
  WriteChar(7,SerPrintVal + 48 )

end sub


Sub TM_Print (In SerPrintVal As Word)
  Dim SysCalcTempX As Word

  OutValueTemp = 0

  If SerPrintVal >= 10000 then
    OutValueTemp = SerPrintVal / 10000 [word]
    SerPrintVal = SysCalcTempX
    WriteChar(3,OutValueTemp + 48 )
    Goto HSerPrintWord1000
  End If

  If SerPrintVal >= 1000 then
  HSerPrintWord1000:
    OutValueTemp = SerPrintVal / 1000 [word]
    SerPrintVal = SysCalcTempX
    WriteChar(4,OutValueTemp + 48 )
    Goto HSerPrintWord100
  End If

  If SerPrintVal >= 100 then
  HSerPrintWord100:
    OutValueTemp = SerPrintVal / 100 [word]
    SerPrintVal = SysCalcTempX
    WriteChar(5,OutValueTemp + 48 )
    Goto HSerPrintWord10
  End If

  If SerPrintVal >= 10 then
  HSerPrintWord10:
    OutValueTemp = SerPrintVal / 10 [word]
    SerPrintVal = SysCalcTempX
    WriteChar(6,OutValueTemp + 48 )
  End If

  WriteChar(7,SerPrintVal + 48 )

End Sub

Sub TM_Print (In SerPrintValInt As Integer)
  Dim SerPrintVal As Word

  'If sign bit is on, print - sign and then negate
  If SerPrintValInt.15 = On Then
    WriteChar(0,"-" )

    SerPrintVal = -SerPrintValInt

  'Sign bit off, so just copy value
  Else
    SerPrintVal = SerPrintValInt
  End If

  'Use Print(word) to display value
  TM_Print SerPrintVal
End Sub


Sub TM_Print (In SerPrintVal As Long)

  Dim SysCalcTempA As Long
  Dim SysPrintBuffer(10)
  SysPrintBuffLen = 0

  Do
    'Divide number by 10, remainder into buffer
    SysPrintBuffLen += 1
    SysPrintBuffer(SysPrintBuffLen) = SerPrintVal % 10
    SerPrintVal = SysCalcTempA
  Loop While SerPrintVal <> 0

  'Display
  For SysPrintTemp =  1 to SysPrintBuffLen
    WriteChar(SysPrintTemp-1  , SysPrintBuffer(SysPrintBuffLen+1-SysPrintTemp) + 48  )
  Next

End Sub