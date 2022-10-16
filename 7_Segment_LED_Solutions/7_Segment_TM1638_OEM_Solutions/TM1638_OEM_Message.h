
'   TM1638 Message Processor - TM1638_OEM_Message.h   GreatCowBasic
'   Copyright (C) 2022 -  ToniG
'   This include is used by TM1638_OEM_Lib.h

'    This Library is free software; you can redistribute it and/or
'    modify it under the terms of the GNU Lesser General Public
'    License as published by the Free Software Foundation; either
'    version 2.1 of the License, or (at your option) any later version.

'    This library is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'    Lesser General Public License for more details.

''*********************************************************************
'    2022/08/24   Initial version (copied from TM1637_OEM_Message.h)
'    2022/09/19   Add key(button) read, including 2 keypress.
'    2022/09/22   Add multiple board use.
'
'   Rev 0.9.10
' This include builds TM1638 serial messages for the TM1638 HW_Driver
''********************************************************************

' "ComAnode" remaps digit data for TM1638 registers for Common Anode displays.
' CA mode is slower to process, but need for some displays.
'   digit 9 & 10 always ComAnode.

'TooDoo
'       Com_Anode - Disable revdig for 9&10 ? if TM_LEDs <> 0

' Variables:
' Read - Dig_pos, Num_Digs, Dig_RM, TMdigVal, Dig_n, TM_DispLen, Dbuf(1-10),TM_DispBuf()
' Modified - TM_KeyVal(1-4), TM_ButnVal1 , TM_ButnVal2, BufIndx, TM_lp2, KeyLP, Tmp_1, Tmp_2
'          - LedReg,

'#OPTION explicit  '< while in dev...

' TM1638 message Constants
#Define TMcmd_80h 0x80     ' Ctrl value
#Define TMcmd_40h 0x40     ' Sequential address mode  (Digit registers)
#Define TMcmd_44h 0x44     ' Fixed address mode (1 Digit per cmd)
#Define TMcmd_42h 0x42     ' Read key press
#Define TMaddr 0xC0        ' First disp. register address (digit 1)
Dim BufIndx as byte       ' Loop var
Dim TM_KeyVal(5) as byte   ' 4x key bytes
Dim TM_RdVal, TM_ButnVal1 , TM_ButnVal2, KeyLP as byte

' Send the display buffer to TM1638 (whole buffer is sent in ComAnode mode)
Sub tmSndBuf (Optional In Dig_pos = TM_DispLen, Optional In Num_Digs = TM_DispLen, Optional In Dbuf() = TM_DispBuf)
Dim TM_lp2, Tmp_2 as Byte


'' Common Cathode displays, up to 8 digits - no segment transpose (Reg C0 bits 0-7 is digit 1)
  #Ifdef Com_Cathode   ' Com_Cathode
      setTM1638_STB 0
          Wait TMdly us
          TM1638_WrVal (TMcmd_44h) ' Fixed address mode
      setTM1638_STB 1
          Wait TMdly us
    For BufIndx = Dig_pos - (Num_Digs -1)  to  Dig_pos
      setTM1638_STB 0
          TM1638_WrVal (TMaddr +(BufIndx -1)*2)    ' Digit addr
          TM1638_WrVal (DBuf(BufIndx))             ' Digit data
      setTM1638_STB 1
          Wait TMdly us
    Next
        tmCtrlSnd
  #endif


' Common Anode display, up to 10 digits, seg_dig transpose active.
' Regs C0,C2,C4,C6,C8,CA,CC,CE bit 0 is digit 1.  Need to send whole buffer
'                  we are reading/setting array bits so need temp vars
 #Ifdef Com_Anode
  Dim BitCnt, AddrN, Rpt, RegPtr, RegBitIdx as byte
  Dim RegBuf(16+1) as Byte  ' TM1638 register buffer for ComAnode display

   For BufIndx = 1 to 16
       RegBuf(BufIndx) = 0  ' ClrRegbuffer
   Next '

   For BufIndx = 1 to TM_DispLen +TM_LEDs   '< Digits to process
'Set TM1638_STB1 0 : Wait 10 us : Set TM1638_STB1 1 '< 4 LogicScope
'        get each bit from digit buffer byte & transpose bit to reg buffer bytes.
      #Ifdef RevDig
        If BufIndx < 9 then RegBitIdx = (TM_DispLen+1 - BufIndx)-1 Else RegBitIdx = (TM_DispLen+1 - BufIndx)-1 -8
      #Else
        If BufIndx < 9 then RegBitIdx = BufIndx-1 Else RegBitIdx = BufIndx-1 -8
      #Endif
        BitCnt = 0
        Tmp_1 = DBuf(BufIndx)   '< each buf byte
      Repeat 8                 '< 8 bits to transpose
'Set TM1638_STB1 0 : Wait 5 us : Set TM1638_STB1 1 '< 4 LogicScope
        If BufIndx < 9 then AddrN = (BitCnt*2) +1 Else AddrN = (BitCnt*2) +2 ' <7us 8mhz pic16
        Tmp_2 = RegBuf(AddrN)
        Tmp_2.RegBitIdx = Tmp_1.BitCnt    ' get each bit from digit buf byte
        RegBuf(AddrN) = Tmp_2
        BitCnt++
      End Repeat                              ' "BufIndx < 9" only 8 odd/even regs addr
   Next

'     Send the Reg buffer
      setTM1638_STB 0
          Wait TMdly us
        TM1638_WrVal (TMcmd_40h) ' Seq. address mode
      setTM1638_STB 1
        Wait TMdly us
      setTM1638_STB 0
        TM1638_WrVal TMaddr                ' C0h First Reg addr
   For BufIndx = 1 to 16                  ' send all registers
        TM1638_WrVal (RegBuf(BufIndx))    ' Digit data
   Next
      setTM1638_STB 1
        Wait TMdly us
      tmCtrlSnd
 #endif

End Sub

' Send 1 raw digit byte to TM
Sub tmSndDig (In TMdigVal, In Dig_n)
//      Dim Dig_RM as Byte
' Common Cathode displays, up to 8 digits  Reg C0 bits 0-7 is digit 1
  #Ifdef Com_Cathode   ' Com_Cathode
     setTM1638_STB 0
       TM1638_WrVal (TMcmd_44h)
     setTM1638_STB 1
       Wait TMdly us
     setTM1638_STB 0
       TM1638_WrVal (TMaddr + (Dig_n -1)*2)   ' Even address
       Wait TMdly us
''       Wait 20 us    ' < just for testing
       TM1638_WrVal (TMdigVal)             ' data
     setTM1638_STB 1
       Wait TMdly us
       tmCtrlSnd
  #endif

' Common Anode displays, up to 10 digits,  Need to send whole Reg buffer (16 bytes)
  #Ifdef Com_Anode
      TM_DispBuf(Dig_n) = TMdigVal
      tmSndBuf
  #endif

End Sub


' Set LED on Grid 9 & 10 (bit 0, 1 odd address registers) always ComAnode
Sub tmSetLED (In LEDn, In LEDon) ' LEDn 1 - 16
    Dim LedReg as Byte
    If LEDn = 0 then Exit Sub
    Tmp_1 = LEDn -1
    If LEDn < 9 then
         Tmp_1 = LEDn -1
       If LEDon = 1 then  ' this is for ComAnode SndBuf (it clears odd regs)
         LedReg.0 = 1
         Tmp_2 = TM_DispBuf(9) : Tmp_2.Tmp_1 = 1 : TM_DispBuf(9) = Tmp_2 ' also set buffer
       Else
         LedReg.0 = 0
         Tmp_2 = TM_DispBuf(9) : Tmp_2.Tmp_1 = 0 : TM_DispBuf(9) = Tmp_2
      End If

    Else
         Tmp_1 = LEDn -9  '(-1-8)
       If LEDon = 1 then
         LedReg.0 = 1
         Tmp_2 = TM_DispBuf(10) : Tmp_2.Tmp_1 = 1 : TM_DispBuf(10) = Tmp_2 ' also set buffer
       Else
         LedReg.0 = 0
         Tmp_2 = TM_DispBuf(10) : Tmp_2.Tmp_1 = 0 : TM_DispBuf(10) = Tmp_2
      End If
    End If
       IF LEDn > 8 then LEDn = LEDn -8  ' LEDs 9 - 16
     setTM1638_STB 0
       TM1638_WrVal (TMcmd_44h)  ' Fixed addr mode
     setTM1638_STB 1
       Wait TMdly us
     setTM1638_STB 0
       TM1638_WrVal ((TMaddr+1) + (LEDn-1)*2)   ' odd address
       Wait TMdly us
       TM1638_WrVal (LedReg)             ' data
     setTM1638_STB 1
       Wait TMdly us
       tmCtrlSnd
End Sub

'TM1638 read Key press (Set array TM_KeyVal & var TM_ButnVal1,TM_ButnVal2 )
Sub tmGetKey
       TM_ButnVal1  = 0 : TM_ButnVal2 = 0

     ' ' get each key byte -> array
     setTM1638_STB 0
        TM1638_WrVal(TMcmd_42h)
        Wait TMdly us
       For KeyLP = 1 to 4
         TM1638_RdVal
         TM_KeyVal(KeyLP) = TM_RdVal
       Next
     setTM1638_STB 1
        Wait TMdly us

'   Creates linear button values from 4 Key bytes,
    For KeyLP = 1 to 4 '        value 4,64,2,32,1,16 represent single keypress
      Select Case TM_KeyVal(KeyLP)
        Case 4
          If TM_ButnVal1 <> 0 then TM_ButnVal2 = TM_ButnVal1 ' 2 keypress
          TM_ButnVal1 = KeyLP *2 -1
        Case 64
          If TM_ButnVal1 <> 0 then TM_ButnVal2 = TM_ButnVal1
          TM_ButnVal1 = KeyLP *2
        Case 2
          If TM_ButnVal1 <> 0 then TM_ButnVal2 = TM_ButnVal1
          TM_ButnVal1 = KeyLP *2 +7
        Case 32
          If TM_ButnVal1 <> 0 then TM_ButnVal2 = TM_ButnVal1
          TM_ButnVal1 = KeyLP *2 +8
        Case 1
          If TM_ButnVal1 <> 0 then TM_ButnVal2 = TM_ButnVal1
          TM_ButnVal1 = KeyLP *2 +15
        Case 16
          If TM_ButnVal1 <> 0 then TM_ButnVal2 = TM_ButnVal1
          TM_ButnVal1 = KeyLP *2 +16

'         2 buttons same byte
        Case 68 ' 2 buttons on K1
          TM_ButnVal1 = KeyLP *2 -1
          TM_ButnVal2 = KeyLP *2
        Case 34 ' 2 buttons on K2
          TM_ButnVal1 = KeyLP *2 +7
          TM_ButnVal2 = KeyLP *2 +8
        Case 17 ' 2 buttons son K3
          TM_ButnVal1 = KeyLP *2 +15
          TM_ButnVal2 = KeyLP *2 +16
      End Select
    Next
'          The above could be expanded to include more then 2 sametime buttons
'           DataSheet states only same Kn buttons can be sametime pressed

'          Modify the TM_ButnVal1, TM_ButnVal2 as per Table (if required)
    #Ifdef Butn_Map1 '< for the "LED&KEY" module board
          If TM_ButnVal1 < 25 then ReadTable ButnMap1, TM_ButnVal1-16, TM_ButnVal1
          If TM_ButnVal2 < 25 then ReadTable ButnMap1, TM_ButnVal2-16, TM_ButnVal2
    #Endif

    #Ifdef Butn_Map2 '< for the "Unknown" module board (modify below line[-16] to suit)
          If TM_ButnVal1 < 25 then ReadTable ButnMap2, TM_ButnVal1-16, TM_ButnVal1
          If TM_ButnVal2 < 25 then ReadTable ButnMap2, TM_ButnVal2-16, TM_ButnVal2
    #Endif
          If TM_ButnVal1 <> 0 And  TM_ButnVal2 <> 0 then
             If TM_ButnVal1 > TM_ButnVal2 then Swap(TM_ButnVal1,TM_ButnVal2)
          End If
End Sub

'  Button Map tables     1 of 2 maps or none are selected by //// #Define KeyMap
 Table ButnMap1
'  17,18,19,20,21,22,23,24 '< ButnValn
   1, 5, 2, 6, 3, 7, 4, 8
 End Table
 '  Button Map table for TM1638 "xxx_xxx" module board  (modify this table to suit)
 Table ButnMap2'                         This table is not yest setup!
'  17,18,19,20,21,22,23,24 '< ButnValn
   1, 5, 2, 6, 3, 7, 4, 8
 End Table

' set STBn for the selected display (1~4)
 Sub setTM1638_STB (In tmSTB as bit)
    Select Case TM_STB    '< This is the STB to set
      Case 1
        #IFDEF TM1638_STB1
          'Set TM1638_STB1 tmSTB ' < Cannot use bit variable with Set (silent fail)
          If tmSTB = True then Set TM1638_STB1 1 Else Set TM1638_STB1 0
        #ENDIF
      Case 2
        #IFDEF TM1638_STB2
          'Set TM1638_STB2 tmSTB
          If tmSTB = True then Set TM1638_STB2 1 Else Set TM1638_STB2 0
        #ENDIF
      Case 3
        #IFDEF TM1638_STB3
          'Set TM1638_STB3 tmSTB
          If tmSTB = True then Set TM1638_STB3 1 Else Set TM1638_STB3 0
        #ENDIF
      Case 4
        #IFDEF TM1638_STB4
          'Set TM1638_STB4 tmSTB
          If tmSTB = True then Set TM1638_STB4 1 Else Set TM1638_STB4 0
        #ENDIF
    End Select
End Sub

' clear all TM1638 registers
'Sub tmCLRdisp(Optional In TM_WrVal = 0)
Sub tmCLRdisp(Optional In TM_WrVal = 0)
      setTM1638_STB 0
        TM1638_WrVal (TMcmd_40h) 'seq. addr mode
      setTM1638_STB 1
        Wait TMdly us
      setTM1638_STB 0
        TM1638_WrVal (TMaddr)
    Repeat 16
      TM1638_WrVal (0)
    End Repeat
      setTM1638_STB 1
        tmCtrlSnd
End Sub

' Send TM1638 control byte
Sub tmCtrlSnd
      tmCtrlSet
    setTM1638_STB 0
      TM1638_WrVal (TMctrl)
    setTM1638_STB 1
      Wait TMdly us
End Sub

'----------------------------
' Notes: 1. tmCtrlSnd is not really needed after every message, need if bright or on/off changed.
'        2. TM1638 will hold keypress value in register until next disp. scan.
'                   a very short press may be missed

'==========================================================
' ***************** Hardware Driver Code ******************
' Variables: ' Read - TM_WrVal ' Modified - TM_RdVal,

Dim TM_RdVal as byte

'   Read 8 bits from TM1638 --> TM_RdVal
Sub TM1638_RdVal
       TM_RdVal = 0
    Repeat 8
       Dir TM1638_DIO in
       Set TM1638_CLK 0
       Wait TMdly us
       Set TM1638_CLK 1     ' latch data bit of TM1638
       Wait TMdly us
       Rotate TM_RdVal Right
       TM_RdVal.7 = TM1638_DIO
    End Repeat
       Dir TM1638_DIO Out
End Sub

'   Write 8 bits to TM1638
Sub TM1638_WrVal(In TM_WrVal)
    Repeat 8
         Set TM1638_CLK 0
         Wait TMdly us
       If TM_WrVal.0  = 1 then
         Set TM1638_DIO 1
       Else
         Set TM1638_DIO 0
       End If
         Wait TMdly us
         Set TM1638_CLK 1
         Wait TMdly us
         Rotate TM_WrVal Right
    End Repeat
End Sub
