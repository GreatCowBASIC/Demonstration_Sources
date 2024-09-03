;Program compiled by GCBASIC (2024.08.30 (Windows 64 bit) : Build 1420) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2024-08-30 CRC248
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via http://paypal.me/gcbasic
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   w_cholmondeley at users dot sourceforge dot net
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM-2_plus_board\10_first-start-sample.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM-2_plus_board\10_first-start-sample.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F15376, r=DEC
#include <P16F15376.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _RSTOSC_HFINT32 & _FEXTOSC_OFF
 __CONFIG _CONFIG2, _MCLRE_OFF
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF & _WRTSAF_OFF & _WRTB_OFF
 __CONFIG _CONFIG5, _CP_OFF

;********************************************************************************

;Set aside memory locations for variables
ADREADPORT                       EQU      32          ; 0x20
COMPORT                          EQU      33          ; 0x21
DELAYTEMP                        EQU     112          ; 0x70
DELAYTEMP2                       EQU     113          ; 0x71
HSERPRINTCRLFCOUNT               EQU      34          ; 0x22
KEYPADDATA                       EQU      35          ; 0x23
KEYPADDATATEMP                   EQU      36          ; 0x24
KEYPADDATATEMP_H                 EQU      37          ; 0x25
KEYPADRAW                        EQU      38          ; 0x26
KEYPADRAW_H                      EQU      39          ; 0x27
KEYPADTEMP                       EQU      40          ; 0x28
KEYREADCOLUMN                    EQU      41          ; 0x29
LCDBYTE                          EQU      42          ; 0x2A
LCDCOLUMN                        EQU      43          ; 0x2B
LCDCRSR                          EQU      44          ; 0x2C
LCDLINE                          EQU      45          ; 0x2D
LCDTEMP                          EQU      46          ; 0x2E
LCDTEMPRWCOUNT                   EQU      47          ; 0x2F
LCDVALUE                         EQU      48          ; 0x30
LCDVALUETEMP                     EQU      49          ; 0x31
LCD_STATE                        EQU      50          ; 0x32
LEFTPAD                          EQU   10183          ; 0x27C7
OUTVALUETEMP                     EQU      51          ; 0x33
PRINTLEN                         EQU      52          ; 0x34
READAD                           EQU      53          ; 0x35
SERDATA                          EQU      54          ; 0x36
SERPRINTVAL                      EQU      55          ; 0x37
STR                              EQU   10177          ; 0x27C1
STRINGPOINTER                    EQU      56          ; 0x38
SYSARRAYTEMP1                    EQU      57          ; 0x39
SYSARRAYTEMP2                    EQU      58          ; 0x3A
SYSBITVAR0                       EQU      59          ; 0x3B
SYSBYTETEMPA                     EQU     117          ; 0x75
SYSBYTETEMPB                     EQU     121          ; 0x79
SYSBYTETEMPX                     EQU     112          ; 0x70
SYSCALCTEMPA                     EQU     117          ; 0x75
SYSCALCTEMPX                     EQU     112          ; 0x70
SYSCALCTEMPX_H                   EQU     113          ; 0x71
SYSCHARCOUNT                     EQU      60          ; 0x3C
SYSDIVLOOP                       EQU     116          ; 0x74
SYSDIVMULTA                      EQU     119          ; 0x77
SYSDIVMULTA_H                    EQU     120          ; 0x78
SYSDIVMULTB                      EQU     123          ; 0x7B
SYSDIVMULTB_H                    EQU     124          ; 0x7C
SYSDIVMULTX                      EQU     114          ; 0x72
SYSDIVMULTX_H                    EQU     115          ; 0x73
SYSLCDTEMP                       EQU      61          ; 0x3D
SYSPRINTDATAHANDLER              EQU      62          ; 0x3E
SYSPRINTDATAHANDLER_H            EQU      63          ; 0x3F
SYSPRINTTEMP                     EQU      64          ; 0x40
SYSREPEATTEMP1                   EQU      65          ; 0x41
SYSREPEATTEMP2                   EQU      66          ; 0x42
SYSREPEATTEMP3                   EQU      67          ; 0x43
SYSSTRDATA                       EQU      68          ; 0x44
SYSSTRINGA                       EQU     119          ; 0x77
SYSSTRINGA_H                     EQU     120          ; 0x78
SYSSTRINGLENGTH                  EQU     118          ; 0x76
SYSSTRINGTEMP                    EQU      69          ; 0x45
SYSSTRLEN                        EQU      70          ; 0x46
SYSSYSINSTRING2HANDLER           EQU      71          ; 0x47
SYSSYSINSTRING2HANDLER_H         EQU      72          ; 0x48
SYSSYSINSTRINGHANDLER            EQU      73          ; 0x49
SYSSYSINSTRINGHANDLER_H          EQU      74          ; 0x4A
SYSTEMP1                         EQU      75          ; 0x4B
SYSTEMP1_H                       EQU      76          ; 0x4C
SYSTEMP2                         EQU      77          ; 0x4D
SYSTEMP3                         EQU      78          ; 0x4E
SYSTEMP4                         EQU      79          ; 0x4F
SYSVALTEMP                       EQU      80          ; 0x50
SYSVALTEMP_H                     EQU      81          ; 0x51
SYSWAITTEMP10US                  EQU     117          ; 0x75
SYSWAITTEMPMS                    EQU     114          ; 0x72
SYSWAITTEMPMS_H                  EQU     115          ; 0x73
SYSWAITTEMPS                     EQU     116          ; 0x74
SYSWAITTEMPUS                    EQU     117          ; 0x75
SYSWAITTEMPUS_H                  EQU     118          ; 0x76
SYSWORDTEMPA                     EQU     117          ; 0x75
SYSWORDTEMPA_H                   EQU     118          ; 0x76
SYSWORDTEMPB                     EQU     121          ; 0x79
SYSWORDTEMPB_H                   EQU     122          ; 0x7A
SYSWORDTEMPX                     EQU     112          ; 0x70
SYSWORDTEMPX_H                   EQU     113          ; 0x71
TEMP                             EQU      82          ; 0x52

;********************************************************************************

;Alias variables
AFSR0 EQU 4
AFSR0_H EQU 5
SYSLEFTPAD_0 EQU 3175
SYSREADADBYTE EQU 53
SYSSTR_0 EQU 3169

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
	retfie

;********************************************************************************

;Program_memory_page: 0
	ORG	5
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITPPS
	call	INITUSART
	call	INITLCD
	call	INITKEYPAD

;Start_of_the_main_program
;''An example program for GCBASIC.
;''------------------------------------------------------------------------
;''This program blinks the onboard LED of a microcontroller - simple - the demonstration should work across many microcontrollers.
;''
;''This sample file can be adapted to any of the supported microcontrollers by simply changing the #chip definition - do this by changing to your chip. Other common chips are shown.
;''
;''To make your programmer or your bootloader work, simply do the following.
;''
;''From within this IDE, press function_key F4, then select  'Edit Programmer Preferences'.   This will show you the 'Programmer Preferences', select the 'Programmer' tab.
;''
;''For PIC:  Typically, if you are using a PICKIT2 then select 'Microchip PICKit 2 CLI - Default' will work for you - select and drag this to the top of the dialog area.
;''
;''For AVR:  Typically, for an UNO the programmer 'Arduino UNO/328p@115200' will work, select the option from the list of programmers, then, select 'Edit',
;''   please edit the communication 'Port', select 'OK', and, then select this option again and drag this to the top of the dialog area.
;''
;''
;''For further adventures with GCBASIC .... Select F4 and then "view Demos" for 1000's of sample programs.
;''
;''
;''Enjoy.
;''
;''
;''************************************************************************
;----- Configuration
;LCD Setup Constants and connection settings
;Keypad Setup Constants
;Setup the Switches as constants and set the DIRection
;DIR SW2_RA4 IN
	bsf	TRISA,4
;DIR SW3_RC2 IN
	bsf	TRISC,2
;DIR SW1_RE3 IN
	bsf	TRISE,3
;Serial Setup Constants and the PPS
;PIC PPS Tool version: 0.0.6.5
;Add this code segment to your GCBASIC source program
;Dim Direction As Bit
;Dim Temp as Byte
;----- Main body of program commences here.
;Print "GCBASIC 2024"
	movlw	low StringTable1
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT117
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;Print "PICDEM-2 DEMO BOARD"
	movlw	low StringTable2
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT117
;Wait 3 s
	movlw	3
	movwf	SysWaitTempS
	call	Delay_S
;CLS
	call	CLS
;Print "To operate keypad remove J6 jumper"
	movlw	low StringTable3
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT117
;repeat 2
	movlw	2
	movwf	SysRepeatTemp1
SysRepeatLoop1
;LCDCURSOR LCDOFF
	movlw	11
	movwf	LCDCRSR
	call	LCDCURSOR
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;LCDCURSOR LCDON
	movlw	12
	movwf	LCDCRSR
	call	LCDCURSOR
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;If !SW2_RA4 or !SW3_RC2 or !SW1_RE3 Then Exit Repeat
	clrf	SysTemp1
	btfsc	PORTA,4
	incf	SysTemp1,F
	comf	SysTemp1,F
	clrf	SysTemp2
	btfsc	PORTC,2
	incf	SysTemp2,F
	comf	SysTemp2,F
	clrf	SysTemp3
	btfsc	PORTE,3
	incf	SysTemp3,F
	comf	SysTemp3,F
	movf	SysTemp1,W
	iorwf	SysTemp2,W
	movwf	SysTemp4
	iorwf	SysTemp3,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
;If !SW2_RA4 or !SW3_RC2 or !SW1_RE3 Then Exit Repeat
	goto	SysRepeatLoopEnd1
;If !SW2_RA4 or !SW3_RC2 or !SW1_RE3 Then Exit Repeat
;end repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;CLS
	call	CLS
;Do Forever
SysDoLoop_S1
;Get key value from keypad
;Temp = KeypadData
	call	FN_KEYPADDATA
	movf	KEYPADDATA,W
	movwf	TEMP
;If a key is pressed, then display it
;If Temp <> KEY_NONE Then
	incf	TEMP,W
	btfsc	STATUS, Z
	goto	ENDIF5
;Send to Serial
;HSerPrint Temp
	movf	TEMP,W
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	call	HSERPRINT346
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;Send to LCD
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;Print "Key Pressed :"
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT117
;Print LeftPad ( ByteToString(Temp), 2, " ")
	movf	TEMP,W
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H
	movlw	2
	movwf	SYSSTRLEN
	movlw	low StringTable5
	movwf	SysSYSINSTRING2Handler
	movlw	(high StringTable5) | 128
	movwf	SysSYSINSTRING2Handler_H
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H
	call	PRINT117
;Wait until key is released
;wait while KeypadData <> KEY_NONE
SysWaitLoop1
	call	FN_KEYPADDATA
	incf	KEYPADDATA,W
	btfss	STATUS, Z
	goto	SysWaitLoop1
;End If
ENDIF5
;If Direction = 0 Then
	btfsc	SYSBITVAR0,0
	goto	ELSE6_1
;PortB++
	incf	PORTB,F
;Else
	goto	ENDIF6
ELSE6_1
;PortB--
	decf	PORTB,F
;End IF
ENDIF6
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;Print "ADC/RA0 :"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT117
;Print LeftPad ( ByteToString(ReadAD ( AN0 )), 3, " ")
	clrf	ADREADPORT
	call	FN_READAD6
	movf	SYSREADADBYTE,W
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H
	movlw	3
	movwf	SYSSTRLEN
	movlw	low StringTable5
	movwf	SysSYSINSTRING2Handler
	movlw	(high StringTable5) | 128
	movwf	SysSYSINSTRING2Handler_H
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H
	call	PRINT117
;Locate 0, 16
	clrf	LCDLINE
	movlw	16
	movwf	LCDCOLUMN
	call	LOCATE
;Print "SW1_RE3"
	movlw	low StringTable7
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT117
;Locate 1, 19
	movlw	1
	movwf	LCDLINE
	movlw	19
	movwf	LCDCOLUMN
	call	LOCATE
;Print SW1_RE3
	clrf	LCDVALUE
	btfsc	PORTE,3
	incf	LCDVALUE,F
	call	PRINT118
;Locate 0, 24
	clrf	LCDLINE
	movlw	24
	movwf	LCDCOLUMN
	call	LOCATE
;Print "SW2_RA4"
	movlw	low StringTable8
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT117
;Locate 1, 27
	movlw	1
	movwf	LCDLINE
	movlw	27
	movwf	LCDCOLUMN
	call	LOCATE
;Print SW2_RA4
	clrf	LCDVALUE
	btfsc	PORTA,4
	incf	LCDVALUE,F
	call	PRINT118
;Locate 0, 32
	clrf	LCDLINE
	movlw	32
	movwf	LCDCOLUMN
	call	LOCATE
;Print "SW3_RC2"
	movlw	low StringTable9
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable9) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT117
;Locate 1, 35
	movlw	1
	movwf	LCDLINE
	movlw	35
	movwf	LCDCOLUMN
	call	LOCATE
;Print SW3_RC2
	clrf	LCDVALUE
	btfsc	PORTC,2
	incf	LCDVALUE,F
	call	PRINT118
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Source: lcd.h (1106)
CHECKBUSYFLAG
;Sub that waits until LCD controller busy flag goes low (ready)
;Only used by LCD_IO 4,8 and only when LCD_NO_RW is NOT Defined
;Called by sub LCDNOrmalWriteByte
;LCD_RSTemp = LCD_RS
	bcf	SYSLCDTEMP,2
	btfsc	PORTA,1
	bsf	SYSLCDTEMP,2
;DIR SCRIPT_LCD_BF  IN
	bsf	TRISD,7
;SET LCD_RS OFF
	bcf	LATA,1
;SET LCD_RW ON
	bsf	LATA,2
;LCDTEMPRWCount = 0
	clrf	LCDTEMPRWCOUNT
;Do
SysDoLoop_S2
;Wait 1 us
	movlw	2
	movwf	DELAYTEMP
DelayUS8
	decfsz	DELAYTEMP,F
	goto	DelayUS8
	nop
;Set LCD_Enable ON
	bsf	LATA,3
;Wait 1 us
	movlw	2
	movwf	DELAYTEMP
DelayUS9
	decfsz	DELAYTEMP,F
	goto	DelayUS9
	nop
;SysLCDTemp.7 = SCRIPT_LCD_BF
	bcf	SYSLCDTEMP,7
	btfsc	PORTD,7
	bsf	SYSLCDTEMP,7
;Set LCD_Enable OFF
	bcf	LATA,3
;if LCDTEMPRWCount = 255 Then SysLCDTemp.7 = 0
	incf	LCDTEMPRWCOUNT,W
	btfsc	STATUS, Z
;if LCDTEMPRWCount = 255 Then SysLCDTemp.7 = 0
	bcf	SYSLCDTEMP,7
;if LCDTEMPRWCount = 255 Then SysLCDTemp.7 = 0
;LCDTEMPRWCount++
	incf	LCDTEMPRWCOUNT,F
;Loop While SysLCDTemp.7 <> 0
	btfsc	SYSLCDTEMP,7
	goto	SysDoLoop_S2
SysDoLoop_E2
;LCD_RS = LCD_RSTemp
	bcf	LATA,1
	btfsc	SYSLCDTEMP,2
	bsf	LATA,1
	return

;********************************************************************************

;Source: lcd.h (511)
CLS
;Sub to clear the LCD
;SET LCD_RS OFF
	bcf	LATA,1
;Clear screen
;LCDWriteByte (0b00000001)
	movlw	1
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;Wait 4 ms
	movlw	4
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Move to start of visible DDRAM
;LCDWriteByte(0x80)
	movlw	128
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;Wait 50 us
	movlw	133
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	return

;********************************************************************************

Delay_10US
D10US_START
	movlw	25
	movwf	DELAYTEMP
DelayUS0
	decfsz	DELAYTEMP,F
	goto	DelayUS0
	nop
	decfsz	SysWaitTemp10US, F
	goto	D10US_START
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	14
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	189
	movwf	DELAYTEMP
DMS_INNER
	decfsz	DELAYTEMP, F
	goto	DMS_INNER
	decfsz	DELAYTEMP2, F
	goto	DMS_OUTER
	decfsz	SysWaitTempMS, F
	goto	DMS_START
	decfsz	SysWaitTempMS_H, F
	goto	DMS_START
	return

;********************************************************************************

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS
	movlw	3
	movwf	SysWaitTempMS_H
	call	Delay_MS
	decfsz	SysWaitTempS, F
	goto	DS_START
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (3269)
HSERPRINT346
;OutValueTemp = 0
	clrf	OUTVALUETEMP
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W
	btfss	STATUS, C
	goto	ENDIF45
;OutValueTemp = SerPrintVal / 100
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	100
	movwf	SysBYTETempB
	call	SYSDIVSUB
	movf	SysBYTETempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	call	HSERSEND332
;End If
ENDIF45
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movf	OUTVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	call	SYSCOMPLESSTHAN
	movf	SysByteTempX,W
	movwf	SysTemp2
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F
	movf	SysTemp2,W
	iorwf	SysByteTempX,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ENDIF46
;OutValueTemp = SerPrintVal / 10
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SYSDIVSUB
	movf	SysBYTETempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	call	HSERSEND332
;End If
ENDIF46
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W
	movwf	SERDATA
	goto	HSERSEND332
;CR

;********************************************************************************

;Source: usart.h (3403)
HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movf	HSERPRINTCRLFCOUNT,W
	movwf	SysRepeatTemp3
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd3
SysRepeatLoop3
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA
	call	HSERSEND332
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA
	call	HSERSEND332
;end Repeat
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (1960)
HSERSEND332
HSERSENDUSART1HANDLER
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop3
	banksel	PIR3
	btfss	PIR3,TX1IF
	goto	SysWaitLoop3
;Wait until TRMT = 1
SysWaitLoop4
	banksel	TX1STA
	btfss	TX1STA,TRMT
	goto	SysWaitLoop4
;TXREG = SerData
	banksel	SERDATA
	movf	SERDATA,W
	banksel	TXREG
	movwf	TXREG
	banksel	STATUS
	return

;********************************************************************************

;Source: keypad.h (76)
INITKEYPAD
;Set direction when using KeypadPort
;Set direction when using KEYPAD_xxx_y
;Dir KEYPAD_ROW_1 Out
	bcf	TRISB,7
;Dir KEYPAD_ROW_2 Out
	bcf	TRISB,6
;Dir KEYPAD_ROW_3 Out
	bcf	TRISB,5
;Dir KEYPAD_ROW_4 Out
	bcf	TRISB,4
;Dir KEYPAD_COL_1 In
	bsf	TRISB,3
;Dir KEYPAD_COL_2 In
	bsf	TRISB,2
;Dir KEYPAD_COL_3 In
	bsf	TRISB,1
;Dir KEYPAD_COL_4 In
	bsf	TRISB,0
	return

;********************************************************************************

;Source: lcd.h (584)
INITLCD
;`LCD_IO selected is ` LCD_IO
;`LCD_Speed is SLOW`
;`OPTIMAL is set to ` OPTIMAL
;`LCD_Speed is set to ` LCD_Speed
;Wait 50 ms
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Dir LCD_RW OUT
	bcf	TRISA,2
;Set LCD_RW OFF
	bcf	LATA,2
;Dir LCD_RS OUT
	bcf	TRISA,1
;Dir LCD_Enable OUT
	bcf	TRISA,3
;Dir LCD_DATA_PORT OUT
	clrf	TRISD
;Set LCD_RS OFF
	bcf	LATA,1
;Wakeup (0x30)
;LCD_DATA_PORT = 0x30
	movlw	48
	movwf	PORTD
;Wait 2 us
	movlw	5
	movwf	DELAYTEMP
DelayUS2
	decfsz	DELAYTEMP,F
	goto	DelayUS2
;PulseOut LCD_Enable, 2 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATA,3
;WaitL1 Time
	movlw	5
	movwf	DELAYTEMP
DelayUS3
	decfsz	DELAYTEMP,F
	goto	DelayUS3
;Set Pin Off
	bcf	LATA,3
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Repeat 3
	movlw	3
	movwf	SysRepeatTemp2
SysRepeatLoop2
;PulseOut LCD_Enable, 2 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATA,3
;WaitL1 Time
	movlw	5
	movwf	DELAYTEMP
DelayUS4
	decfsz	DELAYTEMP,F
	goto	DelayUS4
;Set Pin Off
	bcf	LATA,3
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;End Repeat
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;LCDWriteByte 0x38    '(b'00111000')  '0x38  set 2 line mode
	movlw	56
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;LCDWriteByte 0x06    '(b'00000110')  'Set cursor movement
	movlw	6
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;LCDWriteByte 0x0C    '(b'00001100')  'Turn off cursor
	movlw	12
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;Cls  'Clear the display
	call	CLS
;LCD_State = 12
	movlw	12
	movwf	LCD_STATE
	return

;********************************************************************************

;Source: 10_first-start-sample.gcb (77)
INITPPS
;Module: EUSART1
;RC6PPS = 0x000F    // TX1 > RC6
	movlw	15
	banksel	RC6PPS
	movwf	RC6PPS
	banksel	STATUS
	return

;********************************************************************************

;Source: system.h (189)
INITSYS
;Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	clrf	OSCCON3
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	clrf	OSCEN
;Default value
;OSCTUNE = 0x00
	clrf	OSCTUNE
;The MCU is a chip family ChipFamily
;OSCCON type is 102
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F188xx MCU family - the default case
;OSCFRQ = 0b00000110
	movlw	6
	movwf	OSCFRQ
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;ANSELD = 0
	clrf	ANSELD
;ANSELE = 0
	clrf	ANSELE
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2EN
;C1EN = 0
	bcf	CM1CON0,C1EN
;Turn off all ports
;PORTA = 0
	banksel	PORTA
	clrf	PORTA
;PORTB = 0
	clrf	PORTB
;PORTC = 0
	clrf	PORTC
;PORTD = 0
	clrf	PORTD
;PORTE = 0
	clrf	PORTE
	return

;********************************************************************************

;Source: usart.h (1177)
INITUSART
;Set the default value for USART handler - required when more than one USART
;comport = SCRIPT_DEFAULT_COMPORT
	movlw	1
	movwf	COMPORT
;PIC USART 1 Init
;Set baud rate
;SPBRG1 = SPBRGL_TEMP
	movlw	64
	banksel	SPBRG1
	movwf	SPBRG1
;SPBRGH1 = SPBRGH_TEMP
	movlw	3
	movwf	SPBRGH1
;BAUDCON1.BRG16 = BRG16_TEMP
	bsf	BAUDCON1,BRG16
;TX1STA.BRGH = BRGH_TEMP
	bsf	TX1STA,BRGH
;Enable async mode
;Set SYNC1 Off
	bcf	TX1STA,SYNC_TX1STA
;Set SPEN1 On
	bsf	RC1STA,SPEN
;Enable Continuous Receive and Transmit Enable bit
;Set CREN1 On
	bsf	RC1STA,CREN
;Set TXEN1 On
	bsf	TX1STA,TXEN
	banksel	STATUS
	return

;********************************************************************************

KEYPADBITTOCODETABLE
	movlw	17
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEKEYPADBITTOCODETABLE
	movwf	SysStringA
	movlw	(high TABLEKEYPADBITTOCODETABLE) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEKEYPADBITTOCODETABLE
	retlw	16
	retlw	1
	retlw	2
	retlw	3
	retlw	10
	retlw	4
	retlw	5
	retlw	6
	retlw	11
	retlw	7
	retlw	8
	retlw	9
	retlw	12
	retlw	14
	retlw	0
	retlw	15
	retlw	13

;********************************************************************************

;Source: keypad.h (262)
FN_KEYPADDATA
;Dim KeypadDataTemp As Word
;Get raw key data
;KeypadDataTemp = KeypadRaw
	call	FN_KEYPADRAW
	movf	KEYPADRAW,W
	movwf	KEYPADDATATEMP
	movf	KEYPADRAW_H,W
	movwf	KEYPADDATATEMP_H
;KeypadData = 255
	movlw	255
	movwf	KEYPADDATA
;For KeypadTemp = 1 to 16
;Legacy method
	clrf	KEYPADTEMP
SysForLoop2
	incf	KEYPADTEMP,F
;if KeypadDataTemp.15 = On then
	btfss	KEYPADDATATEMP_H,7
	goto	ENDIF34
;ReadTable KEYPAD_KEYMAP, KeypadTemp, KeypadData
	movf	KEYPADTEMP,W
	movwf	SYSSTRINGA
	call	KEYPADBITTOCODETABLE
	movwf	KEYPADDATA
;End If
ENDIF34
;rotate KeyPadDataTemp left
	rlf	KEYPADDATATEMP,F
	rlf	KEYPADDATATEMP_H,F
;Next
	movlw	16
	subwf	KEYPADTEMP,W
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
	return

;********************************************************************************

;Source: keypad.h (116)
FN_KEYPADRAW
;KeypadRaw = 0
	clrf	KEYPADRAW
	clrf	KEYPADRAW_H
;for KeyReadColumn = 1 to 4
;Legacy method
	clrf	KEYREADCOLUMN
SysForLoop5
	incf	KEYREADCOLUMN,F
;Set all rows off
;Set KEYPAD_ROW_1 On
	bsf	LATB,7
;Set KEYPAD_ROW_2 On
	bsf	LATB,6
;Set KEYPAD_ROW_3 On
	bsf	LATB,5
;Set KEYPAD_ROW_4 On
	bsf	LATB,4
;Set appropriate row on
;If KeyReadColumn = 1 Then Set KEYPAD_ROW_1 Off
	decf	KEYREADCOLUMN,W
	btfsc	STATUS, Z
;If KeyReadColumn = 1 Then Set KEYPAD_ROW_1 Off
	bcf	LATB,7
;If KeyReadColumn = 1 Then Set KEYPAD_ROW_1 Off
;If KeyReadColumn = 2 Then Set KEYPAD_ROW_2 Off
	movlw	2
	subwf	KEYREADCOLUMN,W
	btfsc	STATUS, Z
;If KeyReadColumn = 2 Then Set KEYPAD_ROW_2 Off
	bcf	LATB,6
;If KeyReadColumn = 2 Then Set KEYPAD_ROW_2 Off
;If KeyReadColumn = 3 Then Set KEYPAD_ROW_3 Off
	movlw	3
	subwf	KEYREADCOLUMN,W
	btfsc	STATUS, Z
;If KeyReadColumn = 3 Then Set KEYPAD_ROW_3 Off
	bcf	LATB,5
;If KeyReadColumn = 3 Then Set KEYPAD_ROW_3 Off
;If KeyReadColumn = 4 Then Set KEYPAD_ROW_4 Off
	movlw	4
	subwf	KEYREADCOLUMN,W
	btfsc	STATUS, Z
;If KeyReadColumn = 4 Then Set KEYPAD_ROW_4 Off
	bcf	LATB,4
;If KeyReadColumn = 4 Then Set KEYPAD_ROW_4 Off
;Wait KeypadReadDelay
	movlw	26
	movwf	DELAYTEMP
DelayUS10
	decfsz	DELAYTEMP,F
	goto	DelayUS10
	nop
;For KeypadTemp = 1 to 4
;Legacy method
	clrf	KEYPADTEMP
SysForLoop6
	incf	KEYPADTEMP,F
;Set C off
	bcf	STATUS,C
;Rotate KeypadRaw Left
	rlf	KEYPADRAW,F
	rlf	KEYPADRAW_H,F
;Next
	movlw	4
	subwf	KEYPADTEMP,W
	btfss	STATUS, C
	goto	SysForLoop6
SysForLoopEnd6
;if KEYPAD_COL_1 = Off then Set KeypadRaw.3 On
	btfss	PORTB,3
;if KEYPAD_COL_1 = Off then Set KeypadRaw.3 On
	bsf	KEYPADRAW,3
;if KEYPAD_COL_1 = Off then Set KeypadRaw.3 On
;if KEYPAD_COL_2 = Off then Set KeypadRaw.2 On
	btfss	PORTB,2
;if KEYPAD_COL_2 = Off then Set KeypadRaw.2 On
	bsf	KEYPADRAW,2
;if KEYPAD_COL_2 = Off then Set KeypadRaw.2 On
;if KEYPAD_COL_3 = Off then Set KeypadRaw.1 On
	btfss	PORTB,1
;if KEYPAD_COL_3 = Off then Set KeypadRaw.1 On
	bsf	KEYPADRAW,1
;if KEYPAD_COL_3 = Off then Set KeypadRaw.1 On
;if KEYPAD_COL_4 = Off then Set KeypadRaw.0 On
	btfss	PORTB,0
;if KEYPAD_COL_4 = Off then Set KeypadRaw.0 On
	bsf	KEYPADRAW,0
;if KEYPAD_COL_4 = Off then Set KeypadRaw.0 On
;Next
	movlw	4
	subwf	KEYREADCOLUMN,W
	btfss	STATUS, C
	goto	SysForLoop5
SysForLoopEnd5
	return

;********************************************************************************

;Source: lcd.h (1654)
LCDCURSOR
;Sub  to set cursor style
;Set LCD_RS OFF
	bcf	LATA,1
;If LCDCRSR = ON  Then LCDTemp = LCD_State OR LCDON
	decf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF25
;If LCDCRSR = ON  Then LCDTemp = LCD_State OR LCDON
	movlw	12
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
;If LCDCRSR = ON  Then LCDTemp = LCD_State OR LCDON
ENDIF25
;IF LCDCRSR = LCDON Then LCDTemp = LCD_State OR LCDON
	movlw	12
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF26
;IF LCDCRSR = LCDON Then LCDTemp = LCD_State OR LCDON
	movlw	12
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
;IF LCDCRSR = LCDON Then LCDTemp = LCD_State OR LCDON
ENDIF26
;If LCDCRSR = OFF Then LCDTemp = LCD_State AND LCDOFF
	movf	LCDCRSR,F
	btfss	STATUS, Z
	goto	ENDIF27
;If LCDCRSR = OFF Then LCDTemp = LCD_State AND LCDOFF
	movlw	11
	andwf	LCD_STATE,W
	movwf	LCDTEMP
;If LCDCRSR = OFF Then LCDTemp = LCD_State AND LCDOFF
ENDIF27
;If LCDCRSR = LCDOFF Then LCDTemp = LCD_State AND LCDOFF
	movlw	11
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF28
;If LCDCRSR = LCDOFF Then LCDTemp = LCD_State AND LCDOFF
	movlw	11
	andwf	LCD_STATE,W
	movwf	LCDTEMP
;If LCDCRSR = LCDOFF Then LCDTemp = LCD_State AND LCDOFF
ENDIF28
;If LCDCRSR = CursorOn Then LCDTemp = LCD_State OR CursorON
	movlw	10
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF29
;If LCDCRSR = CursorOn Then LCDTemp = LCD_State OR CursorON
	movlw	10
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
;If LCDCRSR = CursorOn Then LCDTemp = LCD_State OR CursorON
ENDIF29
;If LCDCRSR = CursorOFF then LCDTemp = LCD_State and CursorOFF
	movlw	13
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF30
;If LCDCRSR = CursorOFF then LCDTemp = LCD_State and CursorOFF
	movlw	13
	andwf	LCD_STATE,W
	movwf	LCDTEMP
;If LCDCRSR = CursorOFF then LCDTemp = LCD_State and CursorOFF
ENDIF30
;If LCDCRSR = FLASH  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF31
;If LCDCRSR = FLASH  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
;If LCDCRSR = FLASH  Then LCDTemp = LCD_State OR FLASHON
ENDIF31
;If LCDCRSR = FLASHON  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF32
;If LCDCRSR = FLASHON  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
;If LCDCRSR = FLASHON  Then LCDTemp = LCD_State OR FLASHON
ENDIF32
;If LCDCRSR = FLASHOFF then LCDTemp = LCD_State and FLASHOFF
	movlw	14
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF33
;If LCDCRSR = FLASHOFF then LCDTemp = LCD_State and FLASHOFF
	movlw	14
	andwf	LCD_STATE,W
	movwf	LCDTEMP
;If LCDCRSR = FLASHOFF then LCDTemp = LCD_State and FLASHOFF
ENDIF33
;LCDWriteByte(LCDTemp)
	movf	LCDTEMP,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;save last state
;LCD_State = LCDtemp
	movf	LCDTEMP,W
	movwf	LCD_STATE
	return

;********************************************************************************

;Source: lcd.h (1160)
LCDNORMALWRITEBYTE
;Sub to write a byte to the LCD
;CheckBusyFlag         'WaitForReady
	call	CHECKBUSYFLAG
;set LCD_RW OFF
	bcf	LATA,2
;Set data port to output
;DIR LCD_DATA_PORT out
	clrf	TRISD
;write the data
;LCD_DATA_PORT = LCDByte
	movf	LCDBYTE,W
	movwf	PORTD
;Wait 1 us
	movlw	2
	movwf	DELAYTEMP
DelayUS5
	decfsz	DELAYTEMP,F
	goto	DelayUS5
	nop
;PulseOut LCD_enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATA,3
;WaitL1 Time
	movlw	2
	movwf	DELAYTEMP
DelayUS6
	decfsz	DELAYTEMP,F
	goto	DelayUS6
;Set Pin Off
	bcf	LATA,3
;LCD_DATA_PORT = 0
	clrf	PORTD
;Wait SCRIPT_LCD_POSTWRITEDELAY
	movlw	242
	movwf	DELAYTEMP
DelayUS7
	decfsz	DELAYTEMP,F
	goto	DelayUS7
	nop
;If Register Select is low
;IF LCD_RS = 0 then
	btfsc	PORTA,1
	goto	ENDIF22
;IF LCDByte < 16 then
	movlw	16
	subwf	LCDBYTE,W
	btfsc	STATUS, C
	goto	ENDIF23
;if LCDByte > 7 then
	movf	LCDBYTE,W
	sublw	7
	btfsc	STATUS, C
	goto	ENDIF24
;LCD_State = LCDByte
	movf	LCDBYTE,W
	movwf	LCD_STATE
;end if
ENDIF24
;END IF
ENDIF23
;END IF
ENDIF22
	return

;********************************************************************************

;Source: string.h (1350)
FN_LEFTPAD
;check input length
;return if too short or equal SysStrLen
;If SysStrLen > SysInString(0) Then
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	SYSSTRLEN,W
	subwf	INDF0,W
	btfsc	STATUS, C
	goto	ELSE40_1
;LeftPad = ""
	movlw	low LEFTPAD
	movwf	FSR1L
	movlw	high LEFTPAD
	movwf	FSR1H
	movlw	low StringTable64
	movwf	SysStringA
	movlw	(high StringTable64) & 127
	movwf	SysStringA_H
	call	SYSREADSTRING
;LeftPad(0) = SysStrLen       'set string to new length
	movf	SYSSTRLEN,W
	banksel	SYSLEFTPAD_0
	movwf	SYSLEFTPAD_0
;SysCharCount = SysStrLen - SysInString(0) 'diff-length To incoming string
	banksel	SYSSYSINSTRINGHANDLER
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	subwf	SYSSTRLEN,W
	movwf	SYSCHARCOUNT
;add sysInString2 to new String
;for SysStringTemp = 1 to SysCharCount
;Legacy method
	clrf	SYSSTRINGTEMP
	movlw	1
	subwf	SYSCHARCOUNT,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
SysForLoop3
	incf	SYSSTRINGTEMP,F
;LeftPad(sysStringTemp) = SysInString2(1)
	movlw	1
	addwf	SysSYSINSTRING2Handler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSINSTRING2Handler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp1
	movwf	SysArrayTemp2
	movlw	low(LEFTPAD)
	addwf	SYSSTRINGTEMP,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(LEFTPAD)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SysArrayTemp2,W
	movwf	INDF0
;Next
	movf	SYSCHARCOUNT,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop3
SysForLoopEnd3
;add old content to new string
;For SysStringTemp = 1 To sysInString(0)
;Legacy method
	clrf	SYSSTRINGTEMP
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movlw	1
	subwf	INDF0,W
	btfss	STATUS, C
	goto	SysForLoopEnd4
SysForLoop4
	incf	SYSSTRINGTEMP,F
;LeftPad(sysCharCount + sysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W
	addwf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp1
	movwf	SysArrayTemp2
	movf	SYSSTRINGTEMP,W
	addwf	SYSCHARCOUNT,W
	movwf	SysTemp2
	movlw	low(LEFTPAD)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(LEFTPAD)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	SysArrayTemp2,W
	movwf	INDF0
;Next
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop4
SysForLoopEnd4
;Else
	goto	ENDIF40
ELSE40_1
;LeftPad = SysInString
	movlw	low LEFTPAD
	movwf	FSR1L
	movlw	high LEFTPAD
	movwf	FSR1H
	movf	SysSYSINSTRINGHandler,W
	movwf	FSR0L
	movf	SysSYSINSTRINGHandler_H,W
	movwf	FSR0H
	call	SYSCOPYSTRING
;end if
ENDIF40
	return

;********************************************************************************

;Source: lcd.h (497)
LOCATE
;Sub to locate the cursor
;Where LCDColumn is 0 to screen width-1, LCDLine is 0 to screen height-1
;Set LCD_RS Off
	bcf	LATA,1
;If LCDLine > 1 Then
	movf	LCDLINE,W
	sublw	1
	btfsc	STATUS, C
	goto	ENDIF16
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F
;LCDColumn = LCDColumn + LCD_WIDTH
	movlw	20
	addwf	LCDCOLUMN,F
;End If
ENDIF16
;LCDWriteByte(0x80 or 0x40 * LCDLine + LCDColumn)
	movf	LCDLINE,W
	movwf	SysBYTETempA
	movlw	64
	movwf	SysBYTETempB
	call	SYSMULTSUB
	movf	LCDCOLUMN,W
	addwf	SysBYTETempX,W
	movwf	SysTemp1
	movlw	128
	iorwf	SysTemp1,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US
	goto	Delay_10US

;********************************************************************************

;Overloaded signature: STRING:, Source: lcd.h (936)
PRINT117
;Sub to print a string variable on the LCD
;PrintLen = PrintData(0)
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F
	btfsc	STATUS, Z
;If PrintLen = 0 Then Exit Sub
	return
;If PrintLen = 0 Then Exit Sub
;Set LCD_RS On
	bsf	LATA,1
;Write Data
;For SysPrintTemp = 1 To PrintLen
;Legacy method
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
SysForLoop1
	incf	SYSPRINTTEMP,F
;LCDWriteByte PrintData(SysPrintTemp)
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;Next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: lcd.h (951)
PRINT118
;Sub to print a byte variable on the LCD
;LCDValueTemp = 0
	clrf	LCDVALUETEMP
;Set LCD_RS On
	bsf	LATA,1
;IF LCDValue >= 100 Then
	movlw	100
	subwf	LCDVALUE,W
	btfss	STATUS, C
	goto	ENDIF20
;LCDValueTemp = LCDValue / 100
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	100
	movwf	SysBYTETempB
	call	SYSDIVSUB
	movf	SysBYTETempA,W
	movwf	LCDVALUETEMP
;LCDValue = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;End If
ENDIF20
;If LCDValueTemp > 0 Or LCDValue >= 10 Then
	movf	LCDVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	call	SYSCOMPLESSTHAN
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F
	movf	SysTemp1,W
	iorwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF21
;LCDValueTemp = LCDValue / 10
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SYSDIVSUB
	movf	SysBYTETempA,W
	movwf	LCDVALUETEMP
;LCDValue = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;End If
ENDIF21
;LCDWriteByte (LCDValue + 48)
	movlw	48
	addwf	LCDVALUE,W
	movwf	LCDBYTE
	goto	LCDNORMALWRITEBYTE

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2101)
FN_READAD6
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (577)
;Handle devices with no ANSEL0 AND no ANSEL
;Code for devices with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;#ifdef Bit(CHS5) ChipPins = 28  Or ChipPins = 40 @DebugADC_H
;Case 0: Set ANSELA.0 On
SysSelect1Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect1Case2
;Case 0: Set ANSELA.0 On
	banksel	ANSELA
	bsf	ANSELA,0
;Case 1: Set ANSELA.1 On
	goto	SysSelectEnd1
SysSelect1Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;Case 1: Set ANSELA.1 On
	banksel	ANSELA
	bsf	ANSELA,1
;Case 2: Set ANSELA.2 On
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;Case 2: Set ANSELA.2 On
	banksel	ANSELA
	bsf	ANSELA,2
;Case 3: Set ANSELA.3 On
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
;Case 3: Set ANSELA.3 On
	banksel	ANSELA
	bsf	ANSELA,3
;Case 4: Set ANSELA.4 On
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
;Case 4: Set ANSELA.4 On
	banksel	ANSELA
	bsf	ANSELA,4
;Case 5: Set ANSELA.5 On
	goto	SysSelectEnd1
SysSelect1Case6
	movlw	5
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case7
;Case 5: Set ANSELA.5 On
	banksel	ANSELA
	bsf	ANSELA,5
;Case 6: Set ANSELA.6 On
	goto	SysSelectEnd1
SysSelect1Case7
	movlw	6
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case8
;Case 6: Set ANSELA.6 On
	banksel	ANSELA
	bsf	ANSELA,6
;Case 7: Set ANSELA.7 On
	goto	SysSelectEnd1
SysSelect1Case8
	movlw	7
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case9
;Case 7: Set ANSELA.7 On
	banksel	ANSELA
	bsf	ANSELA,7
;Case 8: Set ANSELB.0 On
	goto	SysSelectEnd1
SysSelect1Case9
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case10
;Case 8: Set ANSELB.0 On
	banksel	ANSELB
	bsf	ANSELB,0
;Case 9: Set ANSELB.1 On
	goto	SysSelectEnd1
SysSelect1Case10
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case11
;Case 9: Set ANSELB.1 On
	banksel	ANSELB
	bsf	ANSELB,1
;Case 10: Set ANSELB.2 On
	goto	SysSelectEnd1
SysSelect1Case11
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case12
;Case 10: Set ANSELB.2 On
	banksel	ANSELB
	bsf	ANSELB,2
;Case 11: Set ANSELB.3 On
	goto	SysSelectEnd1
SysSelect1Case12
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case13
;Case 11: Set ANSELB.3 On
	banksel	ANSELB
	bsf	ANSELB,3
;Case 12: Set ANSELB.4 On
	goto	SysSelectEnd1
SysSelect1Case13
	movlw	12
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case14
;Case 12: Set ANSELB.4 On
	banksel	ANSELB
	bsf	ANSELB,4
;Case 13: Set ANSELB.5 On
	goto	SysSelectEnd1
SysSelect1Case14
	movlw	13
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case15
;Case 13: Set ANSELB.5 On
	banksel	ANSELB
	bsf	ANSELB,5
;Case 14: Set ANSELB.6 On
	goto	SysSelectEnd1
SysSelect1Case15
	movlw	14
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case16
;Case 14: Set ANSELB.6 On
	banksel	ANSELB
	bsf	ANSELB,6
;Case 15: Set ANSELB.7 On
	goto	SysSelectEnd1
SysSelect1Case16
	movlw	15
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case17
;Case 15: Set ANSELB.7 On
	banksel	ANSELB
	bsf	ANSELB,7
;Case 16: Set ANSELC.0 On
	goto	SysSelectEnd1
SysSelect1Case17
	movlw	16
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case18
;Case 16: Set ANSELC.0 On
	banksel	ANSELC
	bsf	ANSELC,0
;Case 17: Set ANSELC.1 On
	goto	SysSelectEnd1
SysSelect1Case18
	movlw	17
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case19
;Case 17: Set ANSELC.1 On
	banksel	ANSELC
	bsf	ANSELC,1
;Case 18: Set ANSELC.2 On
	goto	SysSelectEnd1
SysSelect1Case19
	movlw	18
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case20
;Case 18: Set ANSELC.2 On
	banksel	ANSELC
	bsf	ANSELC,2
;Case 19: Set ANSELC.3 On
	goto	SysSelectEnd1
SysSelect1Case20
	movlw	19
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case21
;Case 19: Set ANSELC.3 On
	banksel	ANSELC
	bsf	ANSELC,3
;Case 20: Set ANSELC.4 On
	goto	SysSelectEnd1
SysSelect1Case21
	movlw	20
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case22
;Case 20: Set ANSELC.4 On
	banksel	ANSELC
	bsf	ANSELC,4
;Case 21: Set ANSELC.5 On
	goto	SysSelectEnd1
SysSelect1Case22
	movlw	21
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case23
;Case 21: Set ANSELC.5 On
	banksel	ANSELC
	bsf	ANSELC,5
;Case 22: Set ANSELC.6 On
	goto	SysSelectEnd1
SysSelect1Case23
	movlw	22
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case24
;Case 22: Set ANSELC.6 On
	banksel	ANSELC
	bsf	ANSELC,6
;Case 23: Set ANSELC.7 On
	goto	SysSelectEnd1
SysSelect1Case24
	movlw	23
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case25
;Case 23: Set ANSELC.7 On
	banksel	ANSELC
	bsf	ANSELC,7
;Case 24: Set ANSELD.0 On
	goto	SysSelectEnd1
SysSelect1Case25
	movlw	24
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case26
;Case 24: Set ANSELD.0 On
	banksel	ANSELD
	bsf	ANSELD,0
;Case 25: Set ANSELD.1 On
	goto	SysSelectEnd1
SysSelect1Case26
	movlw	25
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case27
;Case 25: Set ANSELD.1 On
	banksel	ANSELD
	bsf	ANSELD,1
;Case 26: Set ANSELD.2 On
	goto	SysSelectEnd1
SysSelect1Case27
	movlw	26
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case28
;Case 26: Set ANSELD.2 On
	banksel	ANSELD
	bsf	ANSELD,2
;Case 27: Set ANSELD.3 On
	goto	SysSelectEnd1
SysSelect1Case28
	movlw	27
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case29
;Case 27: Set ANSELD.3 On
	banksel	ANSELD
	bsf	ANSELD,3
;Case 28: Set ANSELD.4 On
	goto	SysSelectEnd1
SysSelect1Case29
	movlw	28
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case30
;Case 28: Set ANSELD.4 On
	banksel	ANSELD
	bsf	ANSELD,4
;Case 29: Set ANSELD.5 On
	goto	SysSelectEnd1
SysSelect1Case30
	movlw	29
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case31
;Case 29: Set ANSELD.5 On
	banksel	ANSELD
	bsf	ANSELD,5
;Case 30: Set ANSELD.6 On
	goto	SysSelectEnd1
SysSelect1Case31
	movlw	30
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case32
;Case 30: Set ANSELD.6 On
	banksel	ANSELD
	bsf	ANSELD,6
;Case 31: Set ANSELD.7 On
	goto	SysSelectEnd1
SysSelect1Case32
	movlw	31
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case33
;Case 31: Set ANSELD.7 On
	banksel	ANSELD
	bsf	ANSELD,7
;Case 32: Set ANSELE.0 On
	goto	SysSelectEnd1
SysSelect1Case33
	movlw	32
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case34
;Case 32: Set ANSELE.0 On
	banksel	ANSELE
	bsf	ANSELE,0
;Case 33: Set ANSELE.1 On
	goto	SysSelectEnd1
SysSelect1Case34
	movlw	33
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case35
;Case 33: Set ANSELE.1 On
	banksel	ANSELE
	bsf	ANSELE,1
;Case 34: Set ANSELE.2 On
	goto	SysSelectEnd1
SysSelect1Case35
	movlw	34
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;Case 34: Set ANSELE.2 On
	banksel	ANSELE
	bsf	ANSELE,2
;End Select  'End Select #1
SysSelectEnd1
;SET ADCS2 OFF
	banksel	ADCON1
	bcf	ADCON1,ADCS2
;SET ADCS1 OFF
	bcf	ADCON1,ADCS1
;SET ADCS0 ON
	bsf	ADCON1,ADCS0
;Choose port
;SET CHS0 OFF
	bcf	ADCON0,CHS0
;SET CHS1 OFF
	bcf	ADCON0,CHS1
;SET CHS2 OFF
	bcf	ADCON0,CHS2
;SET CHS3 OFF
	bcf	ADCON0,CHS3
;SET CHS4 OFF
	bcf	ADCON0,CHS4
;SET CHS5 OFF
	bcf	ADCON0,CHS5
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADREADPORT
	btfss	ADREADPORT,0
	goto	ENDIF10
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADCON0
	bsf	ADCON0,CHS0
;IF ADReadPort.0 On Then Set CHS0 On
ENDIF10
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADREADPORT
	btfss	ADREADPORT,1
	goto	ENDIF11
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADCON0
	bsf	ADCON0,CHS1
;IF ADReadPort.1 On Then Set CHS1 On
ENDIF11
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADREADPORT
	btfss	ADREADPORT,2
	goto	ENDIF12
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADCON0
	bsf	ADCON0,CHS2
;IF ADReadPort.2 On Then Set CHS2 On
ENDIF12
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADREADPORT
	btfss	ADREADPORT,3
	goto	ENDIF13
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADCON0
	bsf	ADCON0,CHS3
;If ADReadPort.3 On Then Set CHS3 On
ENDIF13
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADREADPORT
	btfss	ADREADPORT,4
	goto	ENDIF14
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADCON0
	bsf	ADCON0,CHS4
;If ADReadPort.4 On Then Set CHS4 On
ENDIF14
;If ADReadPort.5 On Then Set CHS5 On
	banksel	ADREADPORT
	btfss	ADREADPORT,5
	goto	ENDIF15
;If ADReadPort.5 On Then Set CHS5 On
	banksel	ADCON0
	bsf	ADCON0,CHS5
;If ADReadPort.5 On Then Set CHS5 On
ENDIF15
;Enable AD Operations
;SET ADON ON
	banksel	ADCON0
	bsf	ADCON0,ADON
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	call	Delay_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GONDONE
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop2
	btfsc	ADCON0,GONDONE
	goto	SysWaitLoop2
;Switch off A/D
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;ANSELD = 0
	clrf	ANSELD
;ANSELE = 0
	clrf	ANSELE
;ReadAD = ADRESH
	banksel	ADRESH
	movf	ADRESH,W
	banksel	READAD
	movwf	READAD
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
	banksel	STATUS
	return

;********************************************************************************

;Source: string.h (124)
FN_STR
;SysCharCount = 0
	clrf	SYSCHARCOUNT
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF36
;SysStrData = SysValTemp / 10000
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValThousands
	goto	SYSVALTHOUSANDS
;End If
ENDIF36
;Thousands
;IF SysValTemp >= 1000 then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF37
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValHundreds
	goto	SYSVALHUNDREDS
;End If
ENDIF37
;Hundreds
;IF SysValTemp >= 100 then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF38
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValTens
	goto	SYSVALTENS
;End If
ENDIF38
;Tens
;IF SysValTemp >= 10 Then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF39
SYSVALTENS
;SysStrData = SysValTemp / 10
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;End If
ENDIF39
;Ones
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSVALTEMP,W
	movwf	INDF0
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;Str(0) = SysCharCount
	movf	SYSCHARCOUNT,W
	banksel	SYSSTR_0
	movwf	SYSSTR_0
	banksel	STATUS
	return

;********************************************************************************

;Source: system.h (4077)
SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	subwf	SYSWORDTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	subwf	SYSWORDTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (4441)
SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;bsf STATUS, C
	bsf	STATUS, C
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;subwf SysByteTempA, W
	subwf	SYSBYTETEMPA, W
;btfss STATUS, C
	btfss	STATUS, C
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (4471)
SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLT16True
	goto	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (1706)
SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length
;movf INDF0, W
	movf	INDF0, W
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysCopyStringCheck
	goto	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART
;movf INDF0, W
	movf	INDF0, W
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F
SYSCOPYSTRINGCHECK
;Exit if length = 0
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
SYSSTRINGCOPY
;Increment pointers
;addfsr 0, 1
	addfsr	0, 1
;addfsr 1, 1
	addfsr	1, 1
;Copy character
;movf INDF0, W
	movf	INDF0, W
;movwf INDF1
	movwf	INDF1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F
;goto SysStringCopy
	goto	SYSSTRINGCOPY
	return

;********************************************************************************

;Source: system.h (3377)
SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfsc STATUS, Z
	btfsc	STATUS, Z
;return
	return
;Main calc routine
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C
;rlf SysByteTempA, F
	rlf	SYSBYTETEMPA, F
;rlf SysByteTempX, F
	rlf	SYSBYTETEMPX, F
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0
;btfsc STATUS, C
	btfsc	STATUS, C
;goto Div8NotNeg
	goto	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv8Start
	goto	SYSDIV8START
	return

;********************************************************************************

;Source: system.h (3445)
SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movf	SYSWORDTEMPA,W
	movwf	SYSDIVMULTA
	movf	SYSWORDTEMPA_H,W
	movwf	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movf	SYSWORDTEMPB,W
	movwf	SYSDIVMULTB
	movf	SYSWORDTEMPB_H,W
	movwf	SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX
	clrf	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempA
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0
	goto	ENDIF51
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF51
;Main calc routine
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP
SYSDIV16START
;set C off
	bcf	STATUS,C
;Rotate SysDivMultA Left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	rlf	SYSDIVMULTX,F
	rlf	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W
	subwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	subwfb	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF52
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF52
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv16Start
	goto	SYSDIV16START
;SysWordTempA = SysDivMultA
	movf	SYSDIVMULTA,W
	movwf	SYSWORDTEMPA
	movf	SYSDIVMULTA_H,W
	movwf	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************

;Source: system.h (2864)
SYSMULTSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
MUL8LOOP
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;btfsc SysByteTempB, 0
	btfsc	SYSBYTETEMPB, 0
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F
;bcf STATUS, C
	bcf	STATUS, C
;rrf SysByteTempB, F
	rrf	SYSBYTETEMPB, F
;bcf STATUS, C
	bcf	STATUS, C
;rlf SysByteTempA, F
	rlf	SYSBYTETEMPA, F
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfss STATUS, Z
	btfss	STATUS, Z
;goto MUL8LOOP
	goto	MUL8LOOP
	return

;********************************************************************************

;Source: system.h (1903)
SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
;Copy
SYSSTRINGREAD
;Get char
;call SysStringTables
	call	SYSSTRINGTABLES
;Set char
;addfsr 1,1
	addfsr	1,1
;movwf INDF1
	movwf	INDF1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F
;goto SysStringRead
	goto	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable1
	retlw	12
	retlw	71	;G
	retlw	67	;C
	retlw	66	;B
	retlw	65	;A
	retlw	83	;S
	retlw	73	;I
	retlw	67	;C
	retlw	32	; 
	retlw	50	;2
	retlw	48	;0
	retlw	50	;2
	retlw	52	;4


StringTable2
	retlw	19
	retlw	80	;P
	retlw	73	;I
	retlw	67	;C
	retlw	68	;D
	retlw	69	;E
	retlw	77	;M
	retlw	45	;-
	retlw	50	;2
	retlw	32	; 
	retlw	68	;D
	retlw	69	;E
	retlw	77	;M
	retlw	79	;O
	retlw	32	; 
	retlw	66	;B
	retlw	79	;O
	retlw	65	;A
	retlw	82	;R
	retlw	68	;D


StringTable3
	retlw	34
	retlw	84	;T
	retlw	111	;o
	retlw	32	; 
	retlw	111	;o
	retlw	112	;p
	retlw	101	;e
	retlw	114	;r
	retlw	97	;a
	retlw	116	;t
	retlw	101	;e
	retlw	32	; 
	retlw	107	;k
	retlw	101	;e
	retlw	121	;y
	retlw	112	;p
	retlw	97	;a
	retlw	100	;d
	retlw	32	; 
	retlw	114	;r
	retlw	101	;e
	retlw	109	;m
	retlw	111	;o
	retlw	118	;v
	retlw	101	;e
	retlw	32	; 
	retlw	74	;J
	retlw	54	;6
	retlw	32	; 
	retlw	106	;j
	retlw	117	;u
	retlw	109	;m
	retlw	112	;p
	retlw	101	;e
	retlw	114	;r


StringTable4
	retlw	13
	retlw	75	;K
	retlw	101	;e
	retlw	121	;y
	retlw	32	; 
	retlw	80	;P
	retlw	114	;r
	retlw	101	;e
	retlw	115	;s
	retlw	115	;s
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	58	;:


StringTable5
	retlw	1
	retlw	32	; 


StringTable6
	retlw	9
	retlw	65	;A
	retlw	68	;D
	retlw	67	;C
	retlw	47	;/
	retlw	82	;R
	retlw	65	;A
	retlw	48	;0
	retlw	32	; 
	retlw	58	;:


StringTable7
	retlw	7
	retlw	83	;S
	retlw	87	;W
	retlw	49	;1
	retlw	95	;_
	retlw	82	;R
	retlw	69	;E
	retlw	51	;3


StringTable8
	retlw	7
	retlw	83	;S
	retlw	87	;W
	retlw	50	;2
	retlw	95	;_
	retlw	82	;R
	retlw	65	;A
	retlw	52	;4


StringTable9
	retlw	7
	retlw	83	;S
	retlw	87	;W
	retlw	51	;3
	retlw	95	;_
	retlw	82	;R
	retlw	67	;C
	retlw	50	;2


StringTable64
	retlw	0


;********************************************************************************

;Program_memory_page: 1
	ORG	2048
;Program_memory_page: 2
	ORG	4096
;Program_memory_page: 3
	ORG	6144
;Program_memory_page: 4
	ORG	8192
;Program_memory_page: 5
	ORG	10240
;Program_memory_page: 6
	ORG	12288
;Program_memory_page: 7
	ORG	14336

 END
