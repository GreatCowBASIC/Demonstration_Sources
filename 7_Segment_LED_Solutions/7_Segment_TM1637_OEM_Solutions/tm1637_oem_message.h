'   TM1637 Message Processor - TM1637_OEM_Message.h   GreatCowBasic
'   Copyright (C) 2022 -  ToniG
'   This include is used by TM1637_OEM_Cmd_Lib.h

'    This Library is free software; you can redistribute it and/or
'    modify it under the terms of the GNU Lesser General Public
'    License as published by the Free Software Foundation; either
'    version 2.1 of the License, or (at your option) any later version.

'    This library is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'    Lesser General Public License for more details.

''********************************************************************************
'    2022/05/05   Initial version
'    2022/06/11   Add Address mode option, Digit/Segment flash
'    2022/06/20   Add tmScrolBuf, TM_ChkKey
'    2022/06/20   Fix a few missing lines  (TM_lp2 = TMlp2, Dig_RM = Dig_n)
                'Remove #Option Explicit, Change include to <>
'    2022/09/15   Improve TMcmd constants, restructure  condition to #IFDEF Snd_SEQ #Else
'   Rev 0.9.20
' This include builds TM1637 serial messages for TM1637_HW_Driver.h
''********************************************************************

' Variables:
' Read - Dig_pos, Num_Digs, Dig_RM, TMdigVal, Dig_n, TM_DispLen, Dbuf()
' Modified - TM_KeyVal, TM_ButnVal, TMlp2, TM_lp2

//#Include "TM1637_HW_Driver.h"
#Include <TM1637_HW_Driver.h>

' TM1637 Constants
' DELETE #Define TMdly 10      ' clk <-> DIO delay us
#Define TMcmd80h 0x80     ' Ctrl value
#Define TMcmd40h 0x40     ' Sequential address mode  (Digit registers)
#Define TMcmd44h 0x44     ' Fixed address mode (1 Digit per cmd)
#Define TMcmd42h 0x42     ' Read key press
#Define TMaddr 0xC0     ' First disp. register address (digit 1)
Dim TMlp2 as byte      ' Loop var

Sub tmSndBuf (Optional In Dig_pos = TM_DispLen, Optional In Num_Digs = TM_DispLen, Optional In Dbuf() = TM_DispBuf)
Dim TM_lp2 as Byte'< re-mapped value
  #Ifdef Snd_SEQ    ' <  compile Sequential mode code
        Nack_Rst
      TM1637_Start
        TM1637_WrVal (TMcmd40h) : TM1637_Ack ' Sequential address mode 40h
      TM1637_Stop
      TM1637_Start
        TM1637_WrVal (TMaddr + (Dig_pos - Num_Digs)) : TM1637_Ack  ' Start addr
     For TMlp2 = Dig_pos - (Num_Digs - 1) to Dig_pos
         TM_lp2 = TMlp2                  '< without remap
         If TM_6dReMap = On then ReadTable Digit_ReMap, TMlp2, TM_lp2
         TM1637_WrVal (DBuf(TM_lp2)) : TM1637_Ack                  ' data
     Next
      TM1637_Stop
        tmCtrlSnd

  #Else       ' <  compile Fixd address mode code.
        Nack_Rst
      TM1637_Start
        TM1637_WrVal (TMcmd44h) : TM1637_Ack ' Fixed address mode 44h
       TM1637_Stop
     For TMlp2 = Dig_pos - (Num_Digs - 1)  to  Dig_pos
          TM_lp2 = TMlp2  '< If not remap
        If TM_6dReMap = On then ReadTable Digit_ReMap, TMlp2, TM_lp2 'reMap_Addr
        TM1637_Start
          TM1637_WrVal (TMaddr + (TM_lp2 -1)) : TM1637_Ack  ' Digit addr
          TM1637_WrVal (DBuf(TMlp2)) : TM1637_Ack          ' Digit data
        TM1637_Stop
     Next
        tmCtrlSnd
  #Endif
End Sub

' For 6d modules with incorrect(swap) wired digits
 Table Digit_ReMap
'  1  2  3  4  5  6
   3, 2, 1, 6, 5, 4
 End Table

' Send 1 raw digit byte to TM  ~1
Sub tmSndDig (In TMdigVal, In Dig_n)
      Dim Dig_RM as Byte
       Dig_RM = Dig_n
       Nack_Rst
       If TM_6dReMap = On then ReadTable Digit_ReMap, Dig_n, Dig_RM 'reMap_Addr
     TM1637_Start
       TM1637_WrVal (TMcmd44h) : TM1637_Ack ' Fixed address mode 44h
     TM1637_Stop
     TM1637_Start
       TM1637_WrVal (TMaddr + Dig_RM-1): TM1637_Ack   ' address
       TM1637_WrVal (TMdigVal) : TM1637_Ack           ' data
     TM1637_Stop
       tmCtrlSnd
End Sub

' Send TM1637 control byte  ~1
Sub tmCtrlSnd
      tmCtrlSet
      Nack_Rst
    TM1637_Start
      TM1637_WrVal (TMctrl) : TM1637_Ack
    TM1637_Stop
End Sub

'TM1637 read Key press (Set var TM_KeyVal & TM_ButnVal)  ~1
Sub tmGetKey
Dim TM_KeyVal, TM_ButnVal as byte
       Nack_Rst
     ' get raw key value
     TM1637_Start
       TM1637_WrVal(TMcmd42h) : TM1637_Ack
       TM1637_RdVal : TM1637_Ack
     TM1637_Stop
     ' Set button number
    If TM_KeyVal > 231 and TM_KeyVal < 248 then      ' valid range
       ReadTable KeyMap, TM_KeyVal - 231, TM_ButnVal '[ KeyMap in #Define]
    Else
      TM_ButnVal = 0
    End If
End Sub

'  Button Map tables     1 of 2 maps are selected by #Define KeyMap
 Table ButnMap1 ' [linear map]
  '232  -->                                           247 '< TM_KeyVal
'   1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 '< ButnVal
   16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 '< ButnVal (aligned to Dig.n)
 End Table

 Table ButnMap2 ' [This (Weird) map is per datasheet]
  '232  -->                                           247 '< TM_KeyVal
   15, 11, 7, 3, 14, 10, 6, 2, 16, 12, 8, 4, 13, 9,  5, 1 '< ButnVal
 End Table
'----------------------------

' Notes: 1.  tmCtrlSnd is not needed after each message,
'            it however ensures convenient control update(Bright, Disp. on/off).
'        2. TM1637 will hold keypress value in register
'            only until next disp. scan.
'            A very short press may be missed
