// from https://www.edaboard.com/threads/ut60e-meter-to-arduino.358072/

'#############################################
'# UUNI-TREND METER WIRELESS ADAPTOR RX UNIT #
'#############################################
'###############################################################################
'# HISTORY: -REVISON DATE AND VERSION
'# 10/08/2014 STARTED NEW VERSION AFTER GOT IT ALL WORKING CORRECTLY,
'# 10/08/2014 CHANGED ALL TEXT TO WORK ON 2 X 8 LCD FROM 2 X 16 LCD 
'# 16/08/2014 ADDED BLEEPR FOR DIODE TESTING
'# 16/08/2014 ADDED CODE FOR BLEEPER IN CONTINUITY MODE
'###############################################################################



/*
The parts I'm not sure of is how to create a lookdown table, set up the serial port to receive the 14 bytes sent from the UT60E and this part the bit where step 2, I think if got this bit the ret should be fairly easy to work out has I just change the DMM_ARRAY[X] part
Code:
 For LOOP1 = 1 To 7 Step 2
        TEMP1 = (DMM_ARRAY[1] <<4) | (DMM_ARRAY[2] &$0F) 
        If TEMP1.7 = 1 Then
        Print At 2,1,"-"
       Clear TEMP1.7 ' CLEAR THE MSB.
        Else Print At 2,1," " 'PRINT BLANK SAPCE IF CORRECT
        EndIf
        TEMP1 = LookDown TEMP1,[$7D,$05,$5B,$1F,$27,$3E,$7E,$15,$7F,$3F,$00,$68]
        Next LOOP1
*/

;-------------------------------------------------------------------------------
;**** Added by Fuse Configurator ****
; Use the Fuse Configurator plug-in to change these settings
Device = 16F883

'Config1 FOSC_xt, WDTE_OFF, PWRTE_OFF, MCLRE_ON, BOREN_OFF, BORV_20, DEBUG_OFF, CCP2MX_RC1, CP_OFF
'Config2 FCMEN_OFF, IESO_OFF, BORSEN_OFF

Config1 FOSC_HS, WDTE_OFF, PWRTE_OFF, MCLRE_ON, CP_OFF, CPD_OFF, BOREN_OFF, IESO_ON, FCMEN_OFF, LVP_OFF, DEBUG_OFF
Config2 BOR4V_BOR40V, WRT_OFF
;**** End of Fuse Configurator Settings ****
;-------------------------------------------------------------------------------
      
 
 
 
     Declare LCD_DTPin = PORTC.0
    Declare LCD_RSPin = PORTC.4
    Declare LCD_ENPin = PORTC.5
    Declare LCD_Interface = 4
    Declare LCD_Lines = 2
    Declare LCD_Type = 0
    Declare LCD_CommandUs = 2000
    Declare LCD_DataUs = 50                     ' CURRENT CHOSEN DEVICE  
    All_Digital = true
   Xtal = 4
  
      Symbol comp = PORTA.2
;---------------------------------------------------------------
    'This is important info needed by the RX routine
       Cls
    Symbol RX_BUFFER_SIZE = 14
                    ' THE MAX NUMBER OF BYTES OF DATA EXPECTED     
    Symbol RX_PIN = PORTA.0                    ' SIGNAL IN PIN
    Symbol SYNC_VALUE = %0110100001101110        ' SYNC VALUE: 
    ' Note you can use any value But try not to use any of the following $15,$31,$32,$23,$34,$25,$16,$07,$38,$29,$1A,$0B,$2C,$0D,$0E,$1C    
    ' Eg the above is = $686E
    ' It is advisable to keep the number balanced eg the same no of 1's as 0's over each byte       
   
    Include "SYBLIN_V3A.inc"                                    ' The include file
        
    Dim TEMP0 As Byte=0
    Dim TEMP1 As Byte = 0
    Dim TEMP2 As Byte = 0
    Dim TEMP3 As Byte = 0
    Dim TEMP4 As Byte = 0
    Dim TEMP5 As Byte = 0
    Dim TEMP6 As Byte = 0
    Dim TEMP9 As Byte =0
    Dim TEMP10 As Byte =0
    Dim TEMP11 As Byte =0
    Dim TEMP12 As Byte =0
    Dim TEMP14 As Byte =0
    Dim LOOP1 As Byte = 0
    Dim LOOP2 As Byte = 0
    Dim LOOP3 As Byte = 0
    Dim LOOP4 As Byte = 0
    Dim LOOP5 As Byte = 0
    Dim LOOP As Byte = 0
    Dim PRINT_SIGN As Byte =0
    Dim PRINT_SIGN1 As Byte =0
    Dim TEMP_STORED As Byte = 0
    Dim STORED1 As Bit = 0
    Dim STORED2 As Bit =0
    Dim STORED3 As Bit =0
    Dim STORED4 As Bit =0
    Dim F_SELECT As Byte  =0  
    Dim DMM_ARRAY[14] As Byte 

 

       Cls
       
       DelayMS 100
  MAIN: 
        SerIn PORTC.7 , T2400 , [Str MY_ARRAY]   
       ' DelayMS 25
      ' SerIn PORTC.7 , T2400 , [Str DMM_ARRAY\14] 
       'BYTES 1&2 FOR THE FIRST DIGIT AND PRINTS THE NEGATIVE SIGN
        For LOOP1 = 1 To 7 Step 2
        TEMP1 = (DMM_ARRAY[1] <<4) | (DMM_ARRAY[2] &$0F) 
        If TEMP1.7 = 1 Then
        Print At 2,1,"-"
        'Print $FE, $C0, "-" 'PRINT THE DECIMAL POINT
        Clear TEMP1.7 ' CLEAR THE MSB.
        Else Print At 2,1," "'Print $FE, $C0, " " 'PRINT BLANK SAPCE IF CORRECT
        EndIf
        TEMP1 = LookDown TEMP1,[$7D,$05,$5B,$1F,$27,$3E,$7E,$15,$7F,$3F,$00,$68]
        Next LOOP1
       'BYTES 3&4 FOR THE SECOND DIGIT
        For LOOP2 = 1 To 7 Step 2
        TEMP2 = (DMM_ARRAY[3] <<4) | (DMM_ARRAY[4] &$0F) 
        STORED1 = TEMP2.7  
        Clear TEMP2.7 ' CLEAR THE MSB.
        TEMP2 = LookDown TEMP2,[$7D,$05,$5B,$1F,$27,$3E,$7E,$15,$7F,$3F,$00,$68]
        Next LOOP2
       'BYTES 5&6 FOR THE THIRD DIGIT
        For LOOP3 = 1 To 7 Step 2
        TEMP3 = (DMM_ARRAY[5] <<4) | (DMM_ARRAY[6] &$0F)
        STORED2 = TEMP3.7   
        Clear TEMP3.7 ' CLEAR THE MSB.
        TEMP3 = LookDown TEMP3,[$7D,$05,$5B,$1F,$27,$3E,$7E,$15,$7F,$3F,$00,$68]
        Next LOOP3
       'BYTES 7&8 FOR THE FORTH DIGIT
        For LOOP4 = 1 To 7 Step 2
        TEMP4 = (DMM_ARRAY[7] <<4) | (DMM_ARRAY[8] &$0F)
        STORED3 = TEMP4.7   
        Clear TEMP4.7 ' CLEAR THE MSB.
        TEMP4 = LookDown TEMP4,[$7D,$05,$5B,$1F,$27,$3E,$7E,$15,$7F,$3F,$00,$68]
        Next LOOP4
         
       'SELECT THE SCREEN FOR PRINTING    
       If STORED1 = 1 And STORED2 = 0 And STORED3 = 0 And STORED4 = 0 Then F_SELECT = 1
       If STORED1 = 0 And STORED2 = 1 And STORED3 = 0 And STORED4 = 0 Then F_SELECT = 2
       If STORED1 = 0 And STORED2 = 0 And STORED3 = 1 And STORED4 = 0  Then F_SELECT = 3
       If STORED1 = 0 And STORED2 =  0 And STORED3 = 0 And STORED4 = 0  Then F_SELECT = 4 
       If  TEMP1 = 10 Then F_SELECT = 5   
       Select F_SELECT
       Case 1
      Print At 2,2,Dec1 TEMP1,".",Dec1 TEMP2,Dec1 TEMP3,Dec TEMP4,"  "
       Case 2
       Print At 2,2,Dec1 TEMP1,Dec1 TEMP2,".",Dec1 TEMP3,Dec TEMP4,"  "
      Case 3 
       Print At 2,2,Dec1 TEMP1,Dec1 TEMP2,Dec1 TEMP3,".",Dec TEMP4,"  "
       Case 4
         Print At 2,2,Dec1 TEMP1,Dec1 TEMP2,Dec1 TEMP3,Dec TEMP4,"  "
         Case 5
         Print At 2,2," O.L "
       End Select
       If TEMP0.3 = 1 Then
       Print At 1,7,"AC "
       Else  Print At 1,7,"DC "
       EndIf
        TEMP0 = DMM_ARRAY[0] & $0F
        TEMP9 = DMM_ARRAY[9] & $0F
        TEMP10 = DMM_ARRAY[10] & $0F
        TEMP11 = DMM_ARRAY[11] & $0F
        TEMP12 = DMM_ARRAY[12] & $0F
        TEMP14 = DMM_ARRAY[13] & $0F
        Print At 1,9,#TEMP14.3,#TEMP14.2,#TEMP14.2,#TEMP14.0
         DelayMS 20    
       If TEMP10.3 = 1 And TEMP12.2 = 1  Then PRINT_SIGN = 0  'PRINT THE mV SIGN
       If TEMP10.3 =0 And TEMP12.2 = 1  Then  PRINT_SIGN = 1   'PRINT THE V SIGN
       If TEMP11.2 =1 And TEMP11.1 =0 Then  PRINT_SIGN = 2   'PRINT R SING FOR OHMS
       If TEMP9.1 = 1 And TEMP11.2=1 Then   PRINT_SIGN = 3    'PRINT K SING FOR OHMS
       If TEMP10.1 =1 And TEMP11.2 = 1 Then PRINT_SIGN = 4  'PRINT THE M MEG OHMS
       If TEMP9.0 = 1 And TEMP12.2= 1 Then PRINT_SIGN = 5   'DIODE
       If TEMP10.0 =1 And TEMP11.2 = 1 Then PRINT_SIGN = 6   'BLLEP
       If TEMP9.2 =1 And TEMP11.3= 1 Then PRINT_SIGN = 7     'nF CAP
       If TEMP9.3 =1 And TEMP11.3=1  Then PRINT_SIGN = 8     'uF CAP
       If TEMP9.1 = 0 And TEMP12.1 = 1  Then PRINT_SIGN = 9    ' HZ
       If TEMP9.1 = 1 And TEMP12.1 = 1 Then  PRINT_SIGN = 10    'k HZ
       If TEMP10.1 = 1 And TEMP12.1 = 1  Then  PRINT_SIGN = 11    ' mHZ
       If TEMP10.2 = 1 And TEMP10.1 = 0 Then  PRINT_SIGN = 12       'DUTY %
       If TEMP9.3=0 And TEMP10.3 = 0 And TEMP11.3=0 And TEMP14.0 = 1 Then  PRINT_SIGN = 13      'TEMP
       If TEMP9.3 =1 And TEMP10.3 = 0 And TEMP11.3 =0 And TEMP12.3 = 1 Then PRINT_SIGN = 14     'u AMPS
       If TEMP9.3=0 And TEMP10.3 = 1 And TEMP11.3=0 And TEMP12.3 = 1 Then PRINT_SIGN = 15      'm AMPS
       If TEMP9.3=0 And TEMP10.3 = 0 And TEMP11.2=0 And TEMP12.3=1 Then PRINT_SIGN = 16     'A AMPS
            
       Select PRINT_SIGN
      Case  0
       Print At 1,1,"VOLTS"
       Print At 2,7,"mV"
       Case 1
       Print At 1,1,"VOLTS"
       Print At 2,7," V"
       Case 2
       Print At 1,1," OHMS  "
      Print At 2,7," R"
       Case 3
       Print At 1,1," OHMS  "
       Print At 2,7," K"
        Case 4
       Print At 1,1," OHMS  "
       Print At 2,7," M"
       Case 5 
       Print At 1,1," DIODE "
        Print At 2,7," V"
       Case 6 
       Print At 1,1," BLEEP "
        Print At 2,7,"CM"
       Case 7 
       Print At 1,1,"   CAP   "
       Print At 2,7,"nF"
       Case 8
       Print At 1,1,"   CAP   " 
       Print At 2,7,"uF"
        Case 9
      Print At 1,1," FREQ   "
      Print At 2,7,"HZ"
       Case 10
      Print At 1,1," FREQ   "
      Print At 2,7," k"
       Case 11
       Print At 1,1," FREQ   "
       Print 2,7," M"
       Case 12
       Print At 1,1," DUTY  "
       Print At 2,7," %"
       Case 13
       Print At 1,1," TEMP   "
       Print At 2,7," C"
       Case 14
     Print At 1,1," AMPS "
      Print At 2,7,"uA"
       Case 15
      Print At 1,1," AMPS "
       Print At 2,7,"mA"
       Case 16
     Print At 1,1," AMPS "
       Print At 2,7," A"
       End Select  
       
              
        
                 
                 GoTo MAIN
