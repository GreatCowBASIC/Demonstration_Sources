'
'   TM1638 7-Segment OEM Display Library - for GreatCowBasic
'----------------------------------------------
'    TM1638_OEM_Lib.h  Copyright (C) 2022 -  ToniG

'    This Library is free software; you can redistribute it and/or
'    modify it under the terms of the GNU Lesser General Public
'    License as published by the Free Software Foundation; either
'    version 2.1 of the License, or (at your option) any later version.

'    This library is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'    Lesser General Public License for more details.

''********************************************************************
'  Required file TM1638_OEM_Message.h
'    2022/08/24   Initial version (ported from TM1637_OEM_Cmd_Lib.h)
'    2022/09/22   Add multiple board use.
'    2022/09/22   Get working tmSegBar (on digits 9 & 10 only).
'    2022/10/05   Change bit test structure  - Fix for AVR compiler
'    2022/10/07   Pass as string to sub & initialize - Fix for AVR compiler
'  Rev 0.9.10
''********************************************************************
'Commands:    [See TM_1638_OEM Demo files for example] & TM1638 OEM Lib Ref.pdf
'  tmSndDec    Value -> Display as Dec
'  tmSndHex    Value -> Display as Hex
'  tmSndDig    Raw byte -> Display
'  tmSndStr    String to -> buffer -> display (start at Digit 1)
'  tmSndChr    Character -> disp buffer digit -> display
'  tmDecBuf    Value -> disp buffer as Dec   (7-seg encoded)
'  tmHexBuf    Value -> disp buffer as Hex   (7-seg encoded)
'  tmSndBuf    Send buffer -> Display
'  tmScrlBuf   Scroll buffer -> display    Input from array.
'  tmSndSeg    Set/Clr buffer Segment {-> display}
'  tmFlashDsp  Flash display
'  tmFlashDig  Flash digit 6
'  tmFlashSeg  Flash digit(s)
'  tmCLRbuf    Clear Buffer
'  tmCLRdisp   Clear Display
'  tmCtrlSnd   Send TM1638 Control byte
'  tmGetKey    Get key press state
'  tmSegBar    Set segments in buffer for barGraph digit 9 & 10 (up to 16 LED's)
'  tmSetLED    Set LED's for digit 9 & 10

' "TM_DispBuf()" is the main Display buffer(array) name.

' Variables:  Note some Vars are shared use between .h includes
' Read - InVal, DigPos, NumDigs, TM_DispLen, TM_Disp, TM_Bright, TM_Blank0, TMscroll
'      -  TM_ScrollRate, TM_FlashRate, TM_dpPos, TM_KeyChk, TM_STB
' Modified - TM_DispBuf, Dbuf, DigCNT, NumExtr, Nibl, StrPos, StrChr, ChrTblIndx
'          - BufPos, DigCNT, Chr_ok, DPf, TMcnt1, (TmpArrVal used for array bit set).
'          - BG_Dig, BG_Seg, TM_BGlen, BG_Lp1, BG_Tmp, Seg_tmp
'----------------------------------------------

' ISSUES:
'

' TooDoo:
'     Test tmSetLED whem in ComAnode mode.

//#Include "TM1638_OEM_Message.h"
#Include <TM1638_OEM_Message.h>

' Variables for use in Main User Program (set these to use the library)
'--------------------------------
Dim TM_Bright as Byte            ' 0 - 7 (LED duty% 6.25 - 87.5)
Dim TM_dpPos as Byte             ' Position of DP (0 = no DP)
Dim TM_Blank0 as Bit             ' 1 = enable zero Blanking
'Dim TM_6dReMap as Bit            ' enable/disable digit remap(for swap com pins)
Dim TM_Disp as Bit               ' 1 = on, 0 = off
Dim TM_Scroll as Bit             ' On/Off Enable text/array scrolling
Dim TM_ScrollRate as Byte        ' Scroll speed *4ms
Dim TM_FlashRate  as Byte        ' Flash rate *4ms
Dim TM_KeyChk as Bit             ' Test for keypress during flash
Dim TM_STB as Byte               ' 1 of 4 boards to read/write to (TM_STB = 1~4)
Dim TM_DispBuf(TM_DispLen +1 +TM_LEDs) as Byte  ' digit values display buffer
'  TM_KeyVal, TM_ButnVal1, TM_ButnVal2 ' <- vars set by tmGetKey sub
'-------------------------------

'Internal Vars
Dim InVal as Long    ' passed sub->sub so dim here.
Dim TMlp1 as Byte    ' Loop var
Dim TMctrl as Byte   ' TM1638 Control byte (on/off, bright)
Dim Tmp_1 as Byte    ' Temp, eg. var->array bitset, not var bitset, calc bitn
'Other Vars are Declared in Subs.

' Default Constants:            (#Define in Main will override)
#Script
  IF NODEF(TM_DispLen) then
    TM_DispLen=8    ' 7seg display No. of digits
  END IF
  IF NODEF(TM_LEDs) then
    TM_LEDs=0       ' LEDs other than 7Seg display (use high buffer bytes)
  END IF
  IF NODEF(Com_Cathode) Then
    If NODEF(Com_Anode) then ' Set const "Com_Cathode"
      Com_Cathode=""
'    Warning "====== Message: Com_Cathode Selected ======"
    END IF
  END IF
  IF NODEF(TMDly) then
    TMdly=5       ' clk <-> DIO delay us
  END IF
  IF NODEF(KeyMap) then
'    KeyMap=ButnMap1    ' with no button map, user can create custom map.
  END IF
#EndScript

#startup tmInit
'        tmInit

' Variable Default & clear
Sub tmInit
  #IFDEF TM1638_CLK
    Dir TM1638_CLK Out
  #ENDIF
  #IFDEF TM1638_DIO
    Dir TM1638_DIO Out
  #ENDIF
  #IFDEF TM1638_STB1
    Dir TM1638_STB1 Out
    TM_STB = 1
    setTM1638_STB 1
  #ENDIF

  #IFDEF TM1638_STB2
    Dir TM1638_STB2 Out
    TM_STB = 2
    setTM1638_STB 1
  #ENDIF
  #IFDEF TM1638_STB3
    Dir TM1638_STB3 Out
        TM_STB = 3
    setTM1638_STB 1
  #ENDIF
  #IFDEF TM1638_STB4
    Dir TM1638_STB4 Out
    TM_STB = 4
    setTM1638_STB 1
  #ENDIF

     TMctrl = TMcmd_80h
     TM_KeyVal(1) = 0 : TM_KeyVal(2) = 0 : TM_KeyVal(3) = 0 : TM_KeyVal(4) = 0
     TM_ButnVal1 = 0 : TM_ButnVal2 = 0
     TM_Bright = 0 : TM_dpPos = 0
//     TM_BGlen = 8      ' < cant set unless sub enabled or dim main
     TM_Disp = On
     TM_Blank0 = On
     TM_Scroll = Off
     TM_ScrollRate = 50  ' *4 ms
     TM_FlashRate = 100  ' *4 ms
     TM_KeyChk = Off
     tmCtrlSnd
     tmCLRbuf : tmCLRdisp
End Sub

 '              Input value processing
 '========================================================
'   Load buffer with Dec 7seg number
Sub tmDecBuf (In InVal, Optional In DigPos = TM_DispLen, Optional In NumDigs = TM_DispLen, Optional In Dbuf() = TM_DispBuf)
    Dim NumExtr, DigCnt as byte
    tmCLRbuf (DigPos, NumDigs)  '< Clear buffer array (or part of)
    DigCnt = DigPos            '< start at digPos
  For TMlp1 = 1 to NumDigs
     If InVal > 9 then NumExtr = InVal MOD 10 Else NumExtr = InVal    ' extract Dec LSDigit
     If TM_Blank0 And InVal = 0 And TMlp1 <> 1 then Exit For      ' blank MSD zero's
     ReadTable Seg7_Val, NumExtr +1, Dbuf(DigCnt)                    ' digit -> buffer
     If TM_dpPos = DigCnt then Dbuf(DigCnt).7 = 1                     ' set DP
     InVal = InVal / 10                                               ' strip LSD (int rounded)
     DigCNT--
  Next
End Sub

'   Load buffer with Hex 7seg number
Sub tmHexBuf (In InVal, Optional In DigPos = TM_DispLen, Optional In NumDigs = TM_DispLen, Optional In Dbuf() = TM_DispBuf)
Dim Nibl as byte
    tmCLRbuf (DigPos, NumDigs)
    DigCnt = DigPos
  For TMlp1 = 1 to NumDigs
      Nibl = InVal & 15                                            ' Extract Hex LSDigit
      If TM_Blank0 And InVal = 0 And TMlp1 <> 1 then Exit For
      ReadTable Seg7_Val, Nibl +1, Dbuf(DigCnt)     ' digit -> buffer
      If TM_dpPos = DigCnt then Dbuf(DigCnt).7 = 1
      InVal = FnLSR(InVal, 4)                        ' Strip LSD
      DigCnt--
  Next
End Sub

Table Seg7_Val '   Values for 7 segment numeric display
'  0   1   2  3   4    5    6   7   8   9   <- Digit
   63, 6, 91, 79, 102, 109, 125, 7, 127, 111
'   A    b   C   d   E    F
   119, 124, 57, 94, 121, 113
End Table
'-----------------------

 '       Preprocess/Send Display Values --> Message Subs
'========================================================
'   Value to Dec 7seg number & send to TM
Sub tmSndDec (In InVal, Optional In DigPos = TM_DispLen, Optional In NumDigs = TM_DispLen)
     tmDecBuf(InVal, DigPos, NumDigs)
     tmSndBuf(DigPos, NumDigs)
End Sub

'   Value to Hex 7seg number & send to TM
Sub tmSndHex (In InVal, Optional In DigPos = TM_DispLen, Optional In NumDigs = TM_DispLen)
     tmHexBuf(InVal, NumDigs, DigPos)
     tmSndBuf(NumDigs, DigPos)
End Sub

'   Set/Clr Segment for buffer digit (optional send) ~0 or
Sub tmSegBuf (In DigN, In SegN, In SEGon as bit, Optional In Dbuf() = TM_DispBuf, Optional in DSnd as Bit = OFF)
    If SegN = 0 then Exit Sub
    SegN--                     ' SegN1 = bit0 of byte
    Tmp_1 = DBuf(DigN) : Tmp_1.SegN = SEGon : DBuf(DigN) = Tmp_1 '{workaround for array bitset var}
    If Dsnd = 1 then tmSndDig(Dbuf(DigN), DigN)
End Sub


' Scroll array of raw digit values into buffer & send
' Set array(0) = No. of bytes to read & TM_Scroll = On
Sub tmScrlBuf (In TMchrVal(), Optional In Dbuf() = TM_DispBuf)
Dim StrPos, BufPos, BufShft as Byte
      If TMchrVal(0) = 0 then Exit Sub   ' size not set
      BufPos = 0
  For StrPos = 1 to TMchrVal(0) 'StrLen
    If TM_Scroll = On  then  '
       For BufShft = 1 to TM_DispLen - 1   ' ShftLft buffer
          Dbuf(BufShft) = Dbuf(BufShft+1)
       Next
         Dbuf(TM_DispLen) = TMchrVal(StrPos)    ' set last buffer digit
         tmSndBuf
         Wait TM_ScrollRate * 4 ms
    End If
  Next
End Sub

'   Send single chr to TM         (uses buffer array element 0)
Sub tmSndChr (In StrChr, In DigN)
    GetChrTblIndx
//    If Chr_ok = 1 and DPf = 0 then 'Note 3.
    If Chr_ok and Not DPf then    ' DP is not sent
      ReadTable Seg7Alpha, ChrTblIndx, TM_DispBuf(0)
      tmSndDig(TM_DispBuf(0), DigN)                   ' Uses buffer digit(0)
    End If
End Sub

'   Load single chr to buffer
Sub tmChrBuf (In StrChr, In DigN, Optional In Dbuf() = TM_DispBuf)
    GetChrTblIndx
//    If Chr_ok = 1 and DPf = 0 then 'Note 3.
    If Chr_ok and Not DPf then    ' DP is not sent
      ReadTable Seg7Alpha, ChrTblIndx, Dbuf(DigN)
    Else
      Dbuf(DigN).7 = 1
    End If
End Sub

'   String -> 7Seg Val -> Buffer & send
'Sub tmSndStr (In TMchrVal(), Optional In Dbuf() = TM_DispBuf, Optional in DSnd as Bit = On)
Sub tmSndStr (In TMchrVal as String, Optional In Dbuf() = TM_DispBuf, Optional in DSnd as Bit = On)
Dim StrPos, StrChr, ChrTblIndx, BufPos, BufShft as Byte
      TMchrVal = TMchrVal+""
      If len(TMchrVal) = 0 then Exit Sub   ' empty string
      BufPos = 0
   For StrPos = 1 to TMchrVal(0)
       StrChr = TMchrVal(StrPos)
       GetChrTblIndx
//   If Chr_ok = 1 And DPf = 0 then '< Note 3.
     If Chr_ok And Not DPf then
         If TM_Scroll = On then  '
            For BufShft = 1 to TM_DispLen - 1   ' ShftLft string chrs
               Dbuf(BufShft) = Dbuf(BufShft+1)  '         into buffer.
            Next
             BufPos = TM_DispLen '< need for DP set
             ReadTable Seg7Alpha, ChrTblIndx, Dbuf(BufPos)    ' Just set last digit
             tmSndBuf
             Wait TM_ScrollRate * 4 ms
         Else
             BufPos++ : If BufPos > TM_DispLen then Exit Sub ' only chrs <= TM_DispLen
             ReadTable Seg7Alpha, ChrTblIndx, Dbuf(BufPos)   ' chr -> buffer Array
         End If
     End If
            If DPf = 1 then Dbuf(BufPos).7 = 1            ' set DP
   Next
            If Dsnd = On then tmSndBuf                    ' option to send buffer
End Sub

'   Set 7segment value for ASCII character -> ChrTblIndx, sets Chr_ok
Sub GetChrTblIndx
        Dim Chr_ok, DPf as Bit        '< display chr, DP found
        Chr_ok = 0 : DPf = 0
      Select Case  StrChr
        Case 65 to 90    'upper_case
          ChrTblIndx = StrChr - 64  + TblPtr0
          Chr_ok = 1

        Case 97 to 122   'lower_case
          ChrTblIndx = (StrChr - 96) + TblPtr1
          Chr_ok = 1

        Case 48 to 57    ' 0 - 9
          ChrTblIndx = (StrChr - 47) + TblPtr2
          Chr_ok = 1

        Case Else       ' special chrs
          If StrChr =  32 then ChrTblIndx = 1  : Chr_ok = 1    '   space
          If StrChr =  40 then ChrTblIndx = 2  : Chr_ok = 1    ' (
          If StrChr =  41 then ChrTblIndx = 3  : Chr_ok = 1    ' )
          If StrChr =  91 then ChrTblIndx = 2  : Chr_ok = 1    ' [
          If StrChr =  93 then ChrTblIndx = 3  : Chr_ok = 1    ' ]
          If StrChr =  45 then ChrTblIndx = 4  : Chr_ok = 1    ' - minus
          If StrChr =  61 then ChrTblIndx = 5  : Chr_ok = 1    ' =
          If StrChr =  63 then ChrTblIndx = 6  : Chr_ok = 1    ' ?
          If StrChr =  95 then ChrTblIndx = 7  : Chr_ok = 1    ' _ Uscore
          If StrChr = 176 then ChrTblIndx = 8  : Chr_ok = 1    ' ° deg
          If StrChr = 126 then ChrTblIndx = 9  : Chr_ok = 1    ' ~ Oscore
          If StrChr =  34 then ChrTblIndx = 10 : Chr_ok = 1    ' " Dquote
          If StrChr = 124 then ChrTblIndx = 11 : Chr_ok = 1    ' | left 1
          If StrChr =  46 then        DPf =  1 : Chr_ok = 1    ' . DP
          If Chr_ok =   1 then ChrTblIndx += TblPtr3 ' add table pointer to chr Index

      End Select
End Sub

#Define TblPtr0 = 0    ' upper case alpha
#Define TblPtr1 = 26   ' lower case alpha
#Define TblPtr2 = 52   ' Numbers
#Define TblPtr3 = 62   ' Special chr

Table Seg7Alpha  'chr maps

'  A    B    C   D   E    F    G    H    I  J   K    L   M
  119, 124, 57, 94, 121, 113, 61, 118, 6, 30, 118, 60, 55 '< TblPtr0
'  N   O   P    Q    R   S    T   U   V   W   X   Y   Z
  55, 63, 115, 103, 49, 109, 7, 62, 62, 62, 18, 110, 27

'  a   b   c   d    E     F    G   h   i   j    k   l   M
  95, 124, 88, 94, 121, 113, 61, 116, 4, 14, 117, 56, 85 '< TblPtr1
'  n   o   P    Q    r   S    t   u   v   W    y   x   Z
  84, 92, 115, 103, 80, 109, 120, 28, 42, 106, 20, 110, 27

'  0   1   2  3   4    5    6   7   8   9       Number
   63, 6, 91, 79, 102, 109, 125, 7, 127, 111            '< TblPtr2

'  spc  [   ]  -   =   ?   _   deg° "   '   |   Special Characters
'  32, 40, 41,  45, 61, 63, 95, 176 126 34  124  [ASCII]
    0, 57, 15, 64, 72, 83,  8, 99,  1, 34, 48           '< TblPtr3
End Table
'-----------------------

'   Misc Subs
'========================================================
'   clear display buffer  ~0
Sub tmCLRbuf (Optional In DigPos = TM_DispLen, Optional In NumDigs = TM_DispLen, Optional In Dbuf() = TM_DispBuf)
    For TMlp1 = DigPos - (NumDigs -1) to DigPos
      Dbuf (TMlp1) = 0
    Next
End Sub

'   clear Buffer & Display  ~3
Sub tmCLRall
    tmCLRbuf
    tmCLRdisp
End Sub

'   Setup control byte  ~0   (called by tmCtrlSnd)
Sub tmCtrlSet
    If TM_Bright > 7 then TM_Bright = 7
    TMctrl = TMcmd_80h + TM_Bright
    TMctrl.3 = TM_Disp   ' on/off
End Sub

'   Flash whole display once
Sub tmFlashDsp
    Dim TMcnt1 as Byte   ' << Delete
    TM_Disp = Off
    tmCtrlSnd
     FlashWait
    TM_Disp = On
    tmCtrlSnd
     FlashWait
End Sub

'   Flash 1 digit once
Sub tmFlashDig(In DigN, Optional NumDigs = 1, Optional In Dbuf() = TM_DispBuf)
    Dim TMcnt1 as Byte
     TMcnt1 = DigN       '< digit pos
#Ifndef RevDig
    For TMLp1 = DigN to DigN + (NumDigs -1)
      tmSndDig(0, TMcnt1)
      TMcnt1--
    Next
     FlashWait
     TMcnt1 = DigN
    For TMLp1 = DigN to DigN + (NumDigs -1)
      tmSndDig(Dbuf(TMcnt1), TMcnt1)
      TMcnt1--
    Next
     FlashWait
#endif

#Ifdef RevDig 'some hobby display are reverse wired
    Dim TMtmpArray(TM_DispLen) as Byte
    For TMLp1 = 1 to NumDigs : TMtmpArray(TMLp1) = Dbuf(TMLp1) : Next ' Save digits
        TMcnt1 = DigN       '< digit pos
    For TMLp1 = DigN to DigN + (NumDigs -1)
      tmSndDig(0, TMcnt1)
      TMcnt1--
    Next
    For TMLp1 = 1 to NumDigs : Dbuf(TMLp1) = TMtmpArray(TMLp1) : Next ' Restore digits
     FlashWait
     TMcnt1 = DigN
    For TMLp1 = DigN to DigN + (NumDigs -1)
      tmSndDig(Dbuf(TMcnt1), TMcnt1)
      TMcnt1--
    Next
     FlashWait
#endif

End Sub

'   Flash 1 Segment once    (toggle buffer bit - Invert restore)
Sub tmFlashSeg(In DigN, In Seg_n, Optional In Dbuf() = TM_DispBuf)
    Dim TmpSeg1 as Byte
    TmpSeg1 = DBuf(DigN)
    Seg_n--       '< align to element bit
    If TmpSeg1.Seg_n = 1 then TmpSeg1.Seg_n = 0 Else TmpSeg1.Seg_n = 1 '{workaround for array bitset var}
    tmSndDig (TmpSeg1, DigN)
     FlashWait
    If TmpSeg1.Seg_n = 1 then TmpSeg1.Seg_n = 0 Else TmpSeg1.Seg_n = 1
    tmSndDig (TmpSeg1, DigN)
     FlashWait
End Sub
' Note FlashDig & FlashSeg require buffer to match displayed digit.
'----------------------------

Sub FlashWait
Dim FWLp as Byte
    For FWLp = 1 to 20
      If TM_KeyChk And TM_ButnVal1 = 0 then tmGetKey ' Key pressed?
      Wait TM_FlashRate / 5  ms   ' 20ms steps 0 - 1000
    Next
End Sub

'  Set segments in linear BarGraph display (1 - 16). eg. KYX-125807R
Sub tmSegBar(In BGdig_n, In BGseg_n, Optional In Fill_Bar as Bit = On)
Dim BG_Seg, TM_BGlen, BG_Lp1 as Byte
      If TM_BGlen = 0 then TM_BGlen = 8 ' default 8
      BG_Seg = BGseg_n
   For BG_Lp1 = 1 to TM_BGlen 'set/clear all segments
       If BGdig_n = 10 then BG_Seg = BG_Lp1 +8 'map to LED9~16

     If Fill_Bar = On then
       If BG_Lp1 <= BG_Seg then tmSetLED(BG_Lp1, On) Else tmSetLED(BG_Lp1, Off)
     Else
       If BG_Lp1 = BG_Seg then tmSetLED(BG_Lp1, On) Else tmSetLED(BG_Lp1, Off)
     End If
'    wait 200 ms  '< TESTing ONLY
   Next
End Sub
' Notes: Linear BarGraph
' 1. Up to 16 segments bargraph start Digit 9, or 2x 8 segments bargraph Dig 9 & 10
' 2. To avoid clear of these LED's" in CA mode use #Define TM_LEDs = 2" & #Define TM_DispLen = 8)
' 3. Compile issue "bit And bit = 0" W-ATMEL 2022.10.04 (resolved in new build)
