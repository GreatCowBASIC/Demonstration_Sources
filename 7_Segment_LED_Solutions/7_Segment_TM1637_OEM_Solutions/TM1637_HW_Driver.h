'   TM1637 7 Segment LED Driver - TM1637_HW_Driver.h  GreatCowBasic
'   Modified original code  2022 -  ToniG
'   This include is used by TM1637_OEM_Message.h

''*******************************************************
'    2022/04/05   Initial version
'    2022/05/10   Fix issue with ACK - DIO not HiZ at 8th CLK H->L.
'    2022/05/17   Add Ack recovery - DIO would stay HiZ (input) if no ACK.
'    Rev 1.00
''*******************************************************
' Call Nack_Rst at each message start

' Varaibles:
' Read - TMValue
' Modified - TM_keyVal, TMlp3, AckBit

Dim TMlp3 as byte    ' Loop var
Dim AckBit as bit    ' 0 = ack ok
Dim TM_KeyVal as byte

'   Read 8 bits from TM1637 --> TM_keyVal
Sub TM1637_RdVal
       TM_keyVal = 0
    For TMlp3 = 1 to 8
       Dir TM1637_DIO in
       Set TM1637_CLK 0
       Wait TMdly us
       Set TM1637_CLK 1     ' latch data bit of TM1637
       Wait TMdly us
       Rotate TM_keyVal Right
       TM_keyVal.7 = TM1637_DIO
    Next
End Sub

'   Write 8 bits to TM1637
Sub TM1637_WrVal (In TMValue)
    For TMlp3 = 1 to 8
         Set TM1637_CLK 0
         Wait TMdly us
       If TMValue.0  = 1 then
         Set TM1637_DIO 1
       Else
         Set TM1637_DIO 0
       End If
         Wait TMdly us
         Set TM1637_CLK 1
         Wait TMdly us
         Rotate TMValue Right
    Next
End Sub

'   Start of Cmd
Sub TM1637_Start
    Set TM1637_CLK 1
    Set TM1637_DIO 1
     Wait TMdly us
    Set TM1637_DIO 0
     Wait TMdly us
    Set TM1637_CLK 0
     Wait TMdly us
End Sub

'   End of Cmd
Sub TM1637_Stop
    Set TM1637_CLK 0
    Set TM1637_DIO 0
     Wait TMdly us
    Set TM1637_CLK 1
     Wait TMdly us
    Set TM1637_DIO 1
     Wait TMdly us
End Sub

'   Ack sequence (9th bit clk)
Sub TM1637_Ack
    AckBit = 1
    Set TM1637_CLK 0  '< TM assert DIO here
     Dir TM1637_DIO In
     Wait TMdly us
    Set TM1637_CLK 1
     Wait TMdly us
    If TM1637_DIO = 0 then  AckBit = 0 : Dir TM1637_DIO Out '< if ack ok
    Set TM1637_CLK 0  '< TM release DIO here
     Wait TMdly us
End Sub

'   Recover from NACK
Sub Nack_Rst
#Ifndef NackCount
    If AckBit = 1 then Dir TM1637_DIO Out : AckBit = 0
#ENDIF

'  For Testing/Log bad ack events
#Ifdef NackCount
 Dim NackCnt as Word
   If AckBit = 1 then
    Dir TM1637_DIO Out : AckBit = 0
    NackCnt++
   End If
#ENDIF
End Sub
'----------------------------

'Notes:
'  1.  When a NACK is encountered DIO is disabled & NackBit is set, the message code needs to
'    call Nack_Rst at start of each new message.
'  2. Byte send with 10us wait is about 370us including stop -start  (8mhz PIC12)
'  3. Dir TM1637_DIO relative to Set TM1637_CLK 0 is optimum, dont swap or may glitch.
