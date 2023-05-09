'
'    TM1651 7-Segment OEM Display Library - for GreatCowBasic
'----------------------------------------------
'    TM1651_OEM_Lib.h  Copyright (C) 2023 -  ToniG, EvanV

'    This Library is free software; you can redistribute it and/or
'    modify it under the terms of the GNU Lesser General Public
'    License as published by the Free Software Foundation; either
'    version 2.1 of the License, or (at your option) any later version.

'    This library is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'    Lesser General Public License for more details.

''********************************************************************
' Required files "TM1651_oem_msg.h"
'    2023/05/09   Initial release. Based on Rev 0.9.20 

'   Rev 0.9.20
''********************************************************************
'Commands:    [See TM_1637_OEM Demo files for example] & TM1651 OEM CmdLib Ref.pdf
'  tmSndDec    Value -> Display as Dec
'  tmSndHex    Value -> Display as Hex
'  tmSndDig    Raw byte -> Display
'  tmSndStr    String to -> buffer -> display (start at Digit 1)
'  tmSndChr    Character -> disp buffer digit -> display
'  tmDecBuf    Value -> disp buffer as Dec   (7-seg encoded)
'  tmHexBuf    Value -> disp buffer as Hex   (7-seg encoded)
'  tmSndBuf    Send buffer -> Display
'  tmScrlBuf   Scroll buffer -> display    Input from array.
'  tmFlashDsp  Flash display
'  tmFlashDig  Flash digit 6
'  tmFlashSeg  Flash digit(s)
'  tmCLRbuf    Clear Buffer
'  tmCLRdisp   Clear Display
'  tmCtrlSnd   Send TM1651 Control byte
'  tmGetKey    Get key press state
'  tmSegBar    Set segments in buffer for barGraph (up to 16 LED's)

' "TM_DispBuf()" is the main Display buffer(array) name.

' Variables:  Note some Vars are shared use between .h includes
' Read - InVal, DigPos, NumDigs, TM_DispLen, TM_Disp, TM_Bright, TM_Blank0, TMscroll
'      -  TM_ScrollRate, TM_FlashRate, TM_dpPos, TM_KeyChk
' Modified - TM_DispBuf, Dbuf, DigCNT, NumExtr, Nibl, StrPos, StrChr, ChrTblIndx
'          - BufPos, DigCNT, Chr_ok, DPf, TMcnt1, (TmpArrVal used for array bit set).
'          - BG_Dig, BG_Seg, TM_BGlen, BG_Lp1, BG_Tmp, Seg_tmp
'----------------------------------------------

' ISSUES:
'

' TooDoo:
'
#Include "tm1651_oem_msg.h"
//#Include <TM1651_oem_msg.h>   '< for dev

' Variables for use in Main User Program (set these to use the library)
'--------------------------------
Dim TM_Bright as Byte            ' 0 - 7 (LED duty% 6.25 - 87.5)
Dim TM_dpPos as Byte             ' Position of DP (0 = no DP)
Dim TM_Blank0 as Bit             ' 1 = enable zero Blanking
'Dim TM_6dReMap as Bit            ' enable/disable digit remap(for swap com pins)
Dim TM_Disp as Bit               ' 1 = on, 0 = off
Dim TM_Scroll as Bit             ' On/Off Enable text/array scrolling
Dim TM_ScrollRate as Byte         ' Scroll speed ms
Dim TM_FlashRate  as Byte        ' Flash rate ms
Dim TM_KeyChk as Bit             ' Test for keypress during flash
Dim TM_DispBuf(TM_DispLen +1 +TM_LEDs) as Byte  ' digit values display buffer
'  TM_KeyVal, TM_ButnVal1         ' <- vars set by tmGetKey sub
'-------------------------------

'Internal Vars
Dim InVal as Long    ' passed sub->sub so dim here.
Dim TMlp1 as Byte    ' Loop var
Dim TMctrl as Byte   ' TM1651 Control byte (on/off, bright)
Dim Tmp_1 as Byte    ' Temp, eg. var->array bitset, not var bitset
Dim TM_ButnVal1 as Byte
'Other Vars Declared in Subs.

' Default Constants:            (will be set here if not #Define in Main)
#script
  IF NODEF(TM_DispLen) Then
    TM_DispLen=3    ' 7seg display No. of digits
  END IF
  IF NODEF(TM_LEDs) Then
    TM_LEDs=0       ' LEDs other than 7Seg display (use high buffer bytes)
  END IF
  IF NODEF(KeyMap) Then
    KeyMap=ButnMap1 ' Sensible button map (TM_ButnVal1 lookup table)
  END IF
  6dReMap
  IF NODEF(TM_6dReMap) Then
    TM_6dReMap=Off ' Sensible button map (TM_ButnVal1 lookup table)
  END IF
  IF NODEF(TMDly) Then
    TMdly=10       ' clk <-> DIO delay us (Close to this value)
  END IF
  ' Snd_SEQ is optionally defined only in main
#endscript

#startup tmInit

' Variable Defaults & clear
Sub tmInit
   #ifdef TM1651_DIO
     Dir TM1651_DIO Out
   #endif
   #ifdef TM1651_CLK
     Dir TM1651_CLK Out
   #endif

    TMctrl = TMcmd80h
    TM_KeyVal = 0
    TM_ButnVal1 = 0
    TM_Bright = 0
    TM_dpPos = 0
'    TM_6dReMap = Off
    TM_Disp = On
    TM_Blank0 = On
    TM_Scroll = Off
    TM_ScrollRate = 60  ' *4 ms
    TM_FlashRate = 100  ' *4 ms
    TM_KeyChk = Off
End Sub
'                                                    [~n = sub call depth]
 '              Input value processing
 '========================================================
'   Load buffer with Dec 7seg number ~1
Sub tmDecBuf (In InVal, Optional In DigPos = TM_DispLen, Optional In NumDigs = TM_DispLen, Optional In Dbuf() = TM_DispBuf)
    Dim NumExtr, DigCnt as byte
    tmCLRbuf (DigPos, NumDigs)  '< Clear buffer array (or part of)
    DigCnt = DigPos            '< start at digPos
  For TMlp1 = 1 to NumDigs
     If InVal > 9 then NumExtr = InVal MOD 10 else NumExtr = InVal    ' extract Dec LSDigit
     If TM_Blank0 = 1 And InVal = 0 And TMlp1 <> 1 then Exit For      ' blank MSD zero's
     ReadTable Seg7_Val, NumExtr +1, Dbuf(DigCnt)                    ' digit -> buffer
     If TM_dpPos = DigCnt then 
      Dbuf(DigCnt) = Dbuf(DigCnt) OR 128                     ' set DP
     End IF
     Dbuf(DigCnt) = Dbuf(DigCnt) OR 128 
     InVal = InVal / 10                                               ' strip LSD (int rounded)
     DigCNT--
  Next
End Sub

'   Load buffer with Hex 7seg number  ~1
Sub tmHexBuf (In InVal, Optional In DigPos = TM_DispLen, Optional In NumDigs = TM_DispLen, Optional In Dbuf() = TM_DispBuf)
Dim Nibl as byte
    tmCLRbuf (DigPos, NumDigs)
    DigCnt = DigPos
  For TMlp1 = 1 to NumDigs
      Nibl = InVal & 15                                            ' Extract Hex LSDigit
      If TM_Blank0 = 1 And InVal = 0 And TMlp1 <> 1 then Exit For
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
'   Value to Dec 7seg number & send to TM  ~2
Sub tmSndDec (In InVal, Optional In DigPos = TM_DispLen, Optional In NumDigs = TM_DispLen)
     tmDecBuf(InVal, DigPos, NumDigs)
     tmSndBuf(DigPos, NumDigs)
End Sub

'   Value to Hex 7seg number & send to TM ~2
Sub tmSndHex (In InVal, Optional In DigPos = TM_DispLen, Optional In NumDigs = TM_DispLen)
     tmHexBuf(InVal, NumDigs, DigPos)
     tmSndBuf(NumDigs, DigPos)
End Sub

'   Set/Clr Segment for buffer digit (optional send) ~0 or ~2
Sub tmSegBuf (In DigN, In SegN, In SEGon as bit, Optional In Dbuf() = TM_DispBuf, Optional in DSnd as Bit = OFF)
'    Dim TMtmp_1 as Byte
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
    If TM_Scroll = 1  then  '
       For BufShft = 1 to TM_DispLen - 1   ' ShftLft buffer
          Dbuf(BufShft) = Dbuf(BufShft+1)
       Next
         Dbuf(TM_DispLen) = TMchrVal(StrPos)    ' set last buffer digit
         tmSndBuf
         Wait TM_ScrollRate * 4 ms
    End If
  Next
End Sub

'   Send single chr to TM ~2        (uses buffer array element 0)
Sub tmSndChr (In StrChr, In DigN)
    GetChrTblIndx
''    If Chr_ok = 1 and DPf = 0 then
    If Chr_ok And Not DPf then    ' DP is not sent
      ReadTable Seg7Alpha, ChrTblIndx, TM_DispBuf(0)
      tmSndDig(TM_DispBuf(0), DigN)                   ' Uses buffer digit(0)
    End If
End Sub

'   Load single chr to buffer ~0
Sub tmChrBuf (In StrChr, In DigN, Optional In Dbuf() = TM_DispBuf)
    GetChrTblIndx
//    If Chr_ok = 1 and DPf = 0 then
    If Chr_ok And Not DPf then    ' DP is not sent
      ReadTable Seg7Alpha, ChrTblIndx, Dbuf(DigN)
    Else
      Dbuf(DigN).7 = 1
    End If
End Sub

'   String -> 7Seg Val -> Buffer & send ~2    (read str as array)
Sub tmSndStr (In TMchrVal as String, Optional In Dbuf() = TM_DispBuf, Optional in DSnd as Bit = On)
 Dim StrPos, StrChr, ChrTblIndx, BufPos, BufShft as Byte
      TMchrVal = TMchrVal+""             ' < initialize string for AVR compiler
      If len(TMchrVal) = 0 then Exit Sub   ' empty string
      BufPos = 0
   For StrPos = 1 to TMchrVal(0)
       StrChr = TMchrVal(StrPos)
       GetChrTblIndx
//    If Chr_ok = 1 and DPf = 0 then
      If Chr_ok And Not DPf then       ' only for valid character and not for DP
         If TM_Scroll = 1  then  '
            For BufShft = 1 to TM_DispLen - 1   ' ShftLft array
               Dbuf(BufShft) = Dbuf(BufShft+1)   '        into buffer.
            Next
             BufPos = TM_DispLen '< need for DP set
             ReadTable Seg7Alpha, ChrTblIndx, Dbuf(BufPos)    ' Just set last digit
             tmSndBuf
             Wait TM_ScrollRate * 4 ms
         Else
             BufPos++ : If BufPos > TM_DispLen Then Exit Sub ' string longer than disp
             ReadTable Seg7Alpha, ChrTblIndx, Dbuf(BufPos) ' chr -> buffer Array
         End If
      End If
            If DPf = 1 Then Dbuf(BufPos).7 = 1            ' set DP
   Next
            If Dsnd = On then tmSndBuf    ' option to send buffer
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
          If StrChr =  32 Then ChrTblIndx = 1  : Chr_ok = 1    '   space
          If StrChr =  40 Then ChrTblIndx = 2  : Chr_ok = 1    ' (
          If StrChr =  41 Then ChrTblIndx = 3  : Chr_ok = 1    ' )
          If StrChr =  91 Then ChrTblIndx = 2  : Chr_ok = 1    ' [
          If StrChr =  93 Then ChrTblIndx = 3  : Chr_ok = 1    ' ]
          If StrChr =  45 Then ChrTblIndx = 4  : Chr_ok = 1    ' - minus
          If StrChr =  61 Then ChrTblIndx = 5  : Chr_ok = 1    ' =
          If StrChr =  63 Then ChrTblIndx = 6  : Chr_ok = 1    ' ?
          If StrChr =  95 Then ChrTblIndx = 7  : Chr_ok = 1    ' _ Uscore
          If StrChr = 176 Then ChrTblIndx = 8  : Chr_ok = 1    ' � deg
          If StrChr = 126 Then ChrTblIndx = 9  : Chr_ok = 1    ' ~ Oscore
          If StrChr =  34 Then ChrTblIndx = 10 : Chr_ok = 1    ' " Dquote
          If StrChr = 124 Then ChrTblIndx = 11 : Chr_ok = 1    ' | left 1
          If StrChr =  46 Then        DPf =  1 : Chr_ok = 1    ' . DP
          If Chr_ok =   1 Then ChrTblIndx += TblPtr3 ' add table pointer to chr Index

      End Select
End Sub

#Define TblPtr0 = 0    ' upper case alpha
#Define TblPtr1 = 26   ' lower case alpha
#Define TblPtr2 = 52   ' Numbers
#Define TblPtr3 = 62   ' Special chr

Table Seg7Alpha  'chr maps
'  A    B    C   D   E    F    G   H    I  J   K    L   M   N   O   P    Q    R   S    T  U   V   W   X   Y   Z
  119, 124, 57, 94, 121, 113, 61, 118, 6, 30, 118, 60, 55, 55, 63, 115, 103, 49, 109, 7, 62, 62, 62, 18, 110, 27 '< TblPtr0

'  a   b   c   d    E     F    G   h   i   j    k   l   M   n   o   P    Q    r   S    t   u   v   W    y   x   Z
  95, 124, 88, 94, 121, 113, 61, 116, 4, 14, 117, 56, 85, 84, 92, 115, 103, 80, 109, 120, 28, 42, 106, 20, 110, 27 '< TblPtr1

'  0   1   2  3   4    5    6   7   8   9       Number
   63, 6, 91, 79, 102, 109, 125, 7, 127, 111  '<  TblPtr2
  ' 119, 124, 57, 94, 121, 113        '<- Just for now... until code offset in table to 1 for hex

'  spc  [   ]  -   =   ?   _   deg� "   '   |   Special Characters
'  32, 40, 41, 45, 61, 63, 95, 176 126 34  124  [ASCII]
    0, 57, 15, 64, 72, 83,  8, 99,  1, 34, 48  '< TblPtr3
End Table
'-----------------------


'   Misc Subs
'========================================================
'   clear display  ~2
Sub tmCLRdisp
    For TMlp1 = 1 to TM_DispLen
      tmSndDig (0, TMlp1)
    Next
End Sub

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
     TMctrl = TMcmd80h + TM_Bright
     TMctrl.3 = TM_Disp   ' on/off
End Sub

'   Flash whole display once ~1
Sub tmFlashDsp
 Dim TMcnt1 as Byte   ' << Delete
    TM_Disp = Off
    tmCtrlSnd
     FlashWait
    TM_Disp = On
    tmCtrlSnd
     FlashWait
End Sub

'   Flash 1 digit once ~2
Sub tmFlashDig(In DigN, Optional NumDigs = 1, Optional In Dbuf() = TM_DispBuf)
 Dim TMcnt1 as Byte
     TMcnt1 = DigN       '< digit pos
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
End Sub

'   Flash 1 Segment once ~2   (toggle buffer bit - Invert restore)
Sub tmFlashSeg(In DigN, In Seg_n, Optional In Dbuf() = TM_DispBuf)
 Dim TMcnt1 as Byte
     Tmp_1 = DBuf(DigN)
     Seg_n--       '< align to element bit
    If Tmp_1.Seg_n = 1 then Tmp_1.Seg_n = 0 Else Tmp_1.Seg_n = 1 '{workaround for array bitset var}
     tmSndDig (Tmp_1, DigN)
     FlashWait

    If Tmp_1.Seg_n = 1 then Tmp_1.Seg_n = 0 Else Tmp_1.Seg_n = 1
     tmSndDig (Tmp_1, DigN)
     FlashWait
End Sub
'     Note FlashDig & FlashSeg require buffer to match displayed digit.
'----------------------------

Sub FlashWait
 Dim FWLp as Byte
    For FWLp = 1 to 20
      If TM_KeyChk = On And TM_ButnVal1 = 0 then tmGetKey ' Key pressed?
      Wait TM_FlashRate / 5  ms   ' 20ms steps 0 - 1000
    Next
End Sub


' Up to 16 segments (2 buffer digits)
' Setup: "#Define TM_DispLen 4", 2 TM digits free for bargraph(& or discrete LED's)
' "#Define TM_LEDs = 2" will set buffer len 2 bytes more than display

'  Set segments in linear BarGraph display (1 - 16). eg. KYX-125807R
Sub tmSegBar(In BGdig_n, In BGseg_n, Optional In Fill_Bar as Bit = On)
Dim BG_Dig, BG_Seg, TM_BGlen, BG_Lp1, BG_Tmp, Seg_tmp as Byte
      If TM_BGlen = 0 then TM_BGlen = 16
   For BG_Lp1 = 1 to TM_BGlen
     ' Select digit
     If BG_Lp1 > 8 then
       BG_Dig = BGdig_n +1 : BG_Seg = BG_Lp1 -8
     Else
       BG_Dig = BGdig_n : BG_Seg = BG_Lp1
     End If
      ' Set/Clr segments
       BG_tmp = TM_DispBuf(BG_Dig)  '< Workaround for set bit from var
       Seg_tmp = BG_Seg - 1        '< Workaround for calc in bit set (BG_Tmp.BG_Seg-1 = On)
     If Fill_Bar = On then
       If BG_Lp1 <= BGseg_n Then BG_Tmp.Seg_tmp = On Else BG_Tmp.Seg_tmp = Off
     Else
       If BG_Lp1 = BGseg_n Then BG_Tmp.Seg_tmp = On Else BG_Tmp.Seg_tmp = Off
     End If
       TM_DispBuf(BG_Dig) = BG_tmp
   Next
            tmSndBuf(BG_Dig, (BG_Dig - BGdig_n)+1) ' BG might be just 1 Byte
End Sub
