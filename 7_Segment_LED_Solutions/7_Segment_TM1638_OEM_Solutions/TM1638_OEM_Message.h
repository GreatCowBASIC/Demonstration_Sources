//-------------------------------
//*****TESTING ONLY*******
//-------------------------------


'   TM1638 Message Processor - TM1638_OEM_Message.h   GreatCowBasic
'   Copyright (C) 2022 -  ToniG
'   This include is used by TM1638_OEM_Cmd_Lib.h

'    This Library is free software; you can redistribute it and/or
'    modify it under the terms of the GNU Lesser General Public
'    License as published by the Free Software Foundation; either
'    version 2.1 of the License, or (at your option) any later version.

'    This library is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'    Lesser General Public License for more details.

''********************************************************************************
'    2022/08/24   Initial version (copied from TM1637_OEM_Message.h
'
'
'   Rev 0.9.00
' This include builds TM1638 serial messages for TM1638_HW_Driver.h
''********************************************************************

' "ComAnode" remaps digit data for TM1638 registers  for Common Anode displays.
' Only do this if you need to drive eg. 10 digits, otherwise its just silly.


'TooDoo
'     1. Determine range of raw key values for tM1638

' Variables:
' Read - Dig_pos, Num_Digs, Dig_RM, TMdigVal, Dig_n, TM_DispLen, Dbuf()
' Modified - TM_KeyVal, TM_ButnVal, BufIndx, TM_lp2

#OPTION explicit  '< while in dev...
'#Include "TM1638_HW_Driver.h"
' TM1638 Constants
#Define TMdly 10        ' clk <-> DIO delay us (not actual this value)
#Define TMcmd0 0x80     ' Ctrl value
#Define TMcmd1 0x40     ' Sequential address mode  (Digit registers)
#Define TMcmd2 0x44     ' Fixed address mode (1 Digit per cmd)
#Define TMcmd3 0x42     ' Read key press
#Define TMaddr 0xC0     ' First disp. register address (digit 1)
Dim BufIndx as byte      ' Loop var

''   ******* Sequential addressing wont work as coded below(digits 1-8 are even addess)
Sub tmSndBuf (Optional In Dig_pos = TM_DispLen, Optional In Num_Digs = TM_DispLen, Optional In Dbuf() = TM_DispBuf)
Dim TM_lp2 as Byte'< re-mapped value


'' Common Cathode displays, up to 8 digits - no segment transpose (Reg C0 bits 0-7 is digit 1)
  #Ifndef Com_Anode   ' Com_Cathode
      set TM1638_STB 0
          TM1638_WrVal (TMcmd2) ' Fixed address mode 44h
      set TM1638_STB 1
          Wait TMdly us
    For BufIndx = Dig_pos - (Num_Digs -1)  to  Dig_pos
      set TM1638_STB 0
          TM1638_WrVal (TMaddr +(BufIndx -1)*2)    ' Digit addr
          TM1638_WrVal (DBuf(BufIndx))             ' Digit data
      set TM1638_STB 1
          Wait TMdly us
    Next
        tmCtrlSnd
  #endif

' Common Anode display, up to 10 digits, seg_dig transpose active.
' Regs C0,C2,C4,C6,C8,CA,CC,CE bit 0 is digit 1.  Need to send whole buffer
'                  we are reading/setting array bits so need temp vars
 #Ifdef Com_Anode
  Dim BitCnt, Tmp_2, AddrN, Rpt, RegPtr, RegBitIdx as byte
  Dim RegBuf(16+1) as Byte  ' TM1638 register buffer for ComAnode display

   For BufIndx = 1 to 16
       RegBuf(BufIndx) = 0  ' ClrRegbuffer
   Next '

   For BufIndx = 1 to TM_DispLen   '< Digits to process
'Set TM1638_STB 0 : Wait 10 us : Set TM1638_STB 1 '< 4 LogicScope
'        get each bit from digit buffer byte & transpose bit to reg buffer bytes.
#Ifndef RevDig
        If BufIndx < 9 then RegBitIdx = BufIndx -1 Else RegBitIdx = BufIndx -1 -8
#endif
#Ifdef RevDig
        If BufIndx < 9 then RegBitIdx = (TM_DispLen+1 - BufIndx) -1 Else RegBitIdx = (TM_DispLen+1 - BufIndx) -1 -8
#endif
        BitCnt = 0 ': Tmp_2 = 0
        Tmp_1 = DBuf(BufIndx)   '< each buf byte
      Repeat 8                 '< 8 bits to transpose
'Set TM1638_STB 0 : Wait 5 us : Set TM1638_STB 1 '< 4 LogicScope
        If BufIndx < 9 then AddrN = (BitCnt*2) +1 Else AddrN = (BitCnt*2) +2 ' <7us
        Tmp_2 = RegBuf(AddrN)
        Tmp_2.RegBitIdx = Tmp_1.BitCnt    ' get each bit from digit buf byte
        RegBuf(AddrN) = Tmp_2
        BitCnt++
      End Repeat
   Next

'     Send the Reg buffer
      set TM1638_STB 0
        TM1638_WrVal (TMcmd1) ' Seq. address mode 40h
      set TM1638_STB 1
        Wait TMdly us

      set TM1638_STB 0
        TM1638_WrVal TMaddr               ' C0h First Reg addr
   For BufIndx = 1 to 16                  ' send all registers
        TM1638_WrVal (RegBuf(BufIndx))     ' Digit data
   Next
      set TM1638_STB 1
        Wait TMdly us
      tmCtrlSnd
 #endif

End Sub


' Send 1 raw digit byte to TM  ~1
Sub tmSndDig (In TMdigVal, In Dig_n)
//      Dim Dig_RM as Byte
' Common Cathode displays, up to 8 digits  Reg C0 bits 0-7 is digit 1
  #Ifndef Com_Anode
     set TM1638_STB 0
       TM1638_WrVal (TMcmd2)
     set TM1638_STB 1
       Wait TMdly us
     set TM1638_STB 0
       TM1638_WrVal (TMaddr + (Dig_n -1)*2)   ' address
       Wait TMdly us
''       Wait 20 us    ' < just for testing
       TM1638_WrVal (TMdigVal)             ' data
     set TM1638_STB 1
       Wait TMdly us
       tmCtrlSnd
  #endif

' Common Anode displays, up to 10 digits,  Need to send whole Reg buffer (16 bytes)
  #Ifdef Com_Anode
      TM_DispBuf(Dig_n) = TMdigVal
      tmSndBuf
  #endif

End Sub

' Send TM1638 control byte  ~1
Sub tmCtrlSnd
      tmCtrlSet
    set TM1638_STB 0
      TM1638_WrVal (TMctrl)
    set TM1638_STB 1
      Wait TMdly us
End Sub

'TM1638 read Key press (Set var TM_KeyVal & TM_ButnVal)  ~1
Sub tmGetKey
Dim TM_KeyVal, TM_ButnVal as byte

 '      TM_KeyVal = 0  <- already done in driver
     ' get raw key value
     set TM1638_STB 0
       TM1638_WrVal(TMcmd3)
       Wait TMdly us
       TM1638_RdVal
     set TM1638_STB 1
     ' Set button number  ---RANGE TO BE DETERMINED---
    If TM_KeyVal > 231 and TM_KeyVal < 248 then  ' valid range
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

' Notes: 1. tmCtrlSnd is not needed to send after each message,
'            it however ensures convenient control update.
'        2. TM1638 keypress register, how long does TM hold register value?
'            until next disp scan, so need to GetKey while pressed.


' ***************** Hardware Driver Code ******************
'==========================================================

' Varaibles:
' Read - TMValue
' Modified - TM_keyVal, TMlp3, AckBit

'Dim TMlp3 as byte    ' Loop var
Dim TM_KeyVal as byte

'   Read 8 bits from TM1638 --> TM_keyVal
Sub TM1638_RdVal   // NOT TESTED YET 08-2022
       TM_keyVal = 0
    'For TMlp3 = 1 to 8
    Repeat 8
       Dir TM1638_DIO in
       Set TM1638_CLK 0
       Wait TMdly us
       Set TM1638_CLK 1     ' latch data bit of TM1638
       Wait TMdly us
       Rotate TM_keyVal Right
       TM_keyVal.7 = TM1638_DIO
    End Repeat
    'Next
End Sub

'   Write 8 bits to TM1638
Sub TM1638_WrVal(In TMValue) ' Convert_1638_DONE
    'For TMlp3 = 1 to 8
    Repeat 8
         Set TM1638_CLK 0
         Wait TMdly us
       If TMValue.0  = 1 then
         Set TM1638_DIO 1
       Else
         Set TM1638_DIO 0
       End If
         Wait TMdly us
         Set TM1638_CLK 1
         Wait TMdly us
         Rotate TMValue Right
    End Repeat
    'Next
End Sub


'  2. Byte send with 10us wait is about 370us including stop -start  (8mhz PIC12)
'  3. Dir TM1638_DIO relative to Set TM1638_CLK 0 is optimum, dont swap or may glitch.
