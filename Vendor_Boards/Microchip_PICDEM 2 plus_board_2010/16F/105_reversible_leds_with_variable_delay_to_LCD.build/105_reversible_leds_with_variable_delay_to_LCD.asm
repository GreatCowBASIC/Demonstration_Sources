;Program compiled by GCBASIC (2026.08.07 (Windows 64 bit) : Build 1617) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-08-07 CRC247
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\16F\105_reversible_leds_with_variable_delay_to_LCD.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\16F\105_reversible_leds_with_variable_delay_to_LCD.build\105_reversible_leds_with_variable_delay_to_LCD.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1937, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\16F\105_reversible_leds_with_variable_delay_to_LCD.gcb"
 SUBTITLE    "08-09-2026 10:39:20"
#include <P16F1937.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF & _VCAPEN_OFF & _WRT_OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
ADREADPORT                       EQU      32          ; 0x20
BYTENUM                          EQU      33          ; 0x21
BYTETOBIN                        EQU    8597          ; 0x2195
DELAYTEMP                        EQU     112          ; 0x70 (SA)
DELAYTEMP2                       EQU     113          ; 0x71 (SA)
LCD2BYTE                         EQU      34          ; 0x22
LCDBYTE                          EQU      35          ; 0x23
LCDCOLUMN                        EQU      36          ; 0x24
LCDLINE                          EQU      37          ; 0x25
LCDTEMPRWCOUNT                   EQU      38          ; 0x26
LCDVALUE                         EQU      39          ; 0x27
LCDVALUETEMP                     EQU      40          ; 0x28
LCD_STATE                        EQU      41          ; 0x29
LEDPORTSTATE                     EQU      42          ; 0x2A
LEFT                             EQU    8647          ; 0x21C7
L_CALIBRATE                      EQU      43          ; 0x2B
L_CALIBRATE_H                    EQU      44          ; 0x2C
L_FROMHIGH                       EQU      45          ; 0x2D
L_FROMHIGH_H                     EQU      46          ; 0x2E
L_FROMLOW                        EQU      47          ; 0x2F
L_FROMLOW_H                      EQU      48          ; 0x30
L_MAP                            EQU      49          ; 0x31
L_MAP_H                          EQU      50          ; 0x32
L_SYSCALC                        EQU      51          ; 0x33
L_SYSCALCF                       EQU      53          ; 0x35
L_SYSCALCF_E                     EQU      56          ; 0x38
L_SYSCALCF_H                     EQU      54          ; 0x36
L_SYSCALCF_U                     EQU      55          ; 0x37
L_SYSCALC_H                      EQU      52          ; 0x34
L_TOHIGH                         EQU      57          ; 0x39
L_TOHIGH_H                       EQU      58          ; 0x3A
L_TOLOW                          EQU      59          ; 0x3B
L_TOLOW_H                        EQU      60          ; 0x3C
MYDELAY                          EQU      61          ; 0x3D
MYDELAY_H                        EQU      62          ; 0x3E
PRINTLEN                         EQU      63          ; 0x3F
READAD                           EQU      64          ; 0x40
RIGHT                            EQU    8606          ; 0x219E
SCALE                            EQU      65          ; 0x41
SCALE_H                          EQU      66          ; 0x42
STR                              EQU    8591          ; 0x218F
STRINGPOINTER                    EQU      67          ; 0x43
SYSARRAYTEMP1                    EQU      68          ; 0x44
SYSARRAYTEMP2                    EQU      69          ; 0x45
SYSBITVAR0                       EQU      70          ; 0x46
SYSBYTETEMPA                     EQU     117          ; 0x75 (SA)
SYSBYTETEMPB                     EQU     121          ; 0x79 (SA)
SYSBYTETEMPX                     EQU     112          ; 0x70 (SA)
SYSCALCTEMPA                     EQU     117          ; 0x75 (SA)
SYSCALCTEMPX                     EQU     112          ; 0x70 (SA)
SYSCALCTEMPX_H                   EQU     113          ; 0x71 (SA)
SYSCHARCOUNT                     EQU      71          ; 0x47
SYSCHARSTART                     EQU      72          ; 0x48
SYSDIVLOOP                       EQU     116          ; 0x74 (SA)
SYSDIVMULTA                      EQU     119          ; 0x77 (SA)
SYSDIVMULTA_H                    EQU     120          ; 0x78 (SA)
SYSDIVMULTB                      EQU     123          ; 0x7B (SA)
SYSDIVMULTB_H                    EQU     124          ; 0x7C (SA)
SYSDIVMULTX                      EQU     114          ; 0x72 (SA)
SYSDIVMULTX_H                    EQU     115          ; 0x73 (SA)
SYSLCDTEMP                       EQU      73          ; 0x49
SYSLONGDIVMULTA                  EQU      74          ; 0x4A
SYSLONGDIVMULTA_E                EQU      77          ; 0x4D
SYSLONGDIVMULTA_H                EQU      75          ; 0x4B
SYSLONGDIVMULTA_U                EQU      76          ; 0x4C
SYSLONGDIVMULTB                  EQU      78          ; 0x4E
SYSLONGDIVMULTB_E                EQU      81          ; 0x51
SYSLONGDIVMULTB_H                EQU      79          ; 0x4F
SYSLONGDIVMULTB_U                EQU      80          ; 0x50
SYSLONGDIVMULTX                  EQU      82          ; 0x52
SYSLONGDIVMULTX_E                EQU      85          ; 0x55
SYSLONGDIVMULTX_H                EQU      83          ; 0x53
SYSLONGDIVMULTX_U                EQU      84          ; 0x54
SYSLONGTEMPA                     EQU     117          ; 0x75 (SA)
SYSLONGTEMPA_E                   EQU     120          ; 0x78 (SA)
SYSLONGTEMPA_H                   EQU     118          ; 0x76 (SA)
SYSLONGTEMPA_U                   EQU     119          ; 0x77 (SA)
SYSLONGTEMPB                     EQU     121          ; 0x79 (SA)
SYSLONGTEMPB_E                   EQU     124          ; 0x7C (SA)
SYSLONGTEMPB_H                   EQU     122          ; 0x7A (SA)
SYSLONGTEMPB_U                   EQU     123          ; 0x7B (SA)
SYSLONGTEMPX                     EQU     112          ; 0x70 (SA)
SYSLONGTEMPX_E                   EQU     115          ; 0x73 (SA)
SYSLONGTEMPX_H                   EQU     113          ; 0x71 (SA)
SYSLONGTEMPX_U                   EQU     114          ; 0x72 (SA)
SYSPRINTDATAHANDLER              EQU      86          ; 0x56
SYSPRINTDATAHANDLER_H            EQU      87          ; 0x57
SYSPRINTTEMP                     EQU      88          ; 0x58
SYSREPEATTEMP1                   EQU      89          ; 0x59
SYSSTRDATA                       EQU      90          ; 0x5A
SYSSTRINGA                       EQU     119          ; 0x77 (SA)
SYSSTRINGA_H                     EQU     120          ; 0x78 (SA)
SYSSTRINGLENGTH                  EQU     118          ; 0x76 (SA)
SYSSTRINGPARAM1                  EQU     160          ; 0xA0
SYSSTRINGTEMP                    EQU      91          ; 0x5B
SYSSYSINSTRINGHANDLER            EQU      92          ; 0x5C
SYSSYSINSTRINGHANDLER_H          EQU      93          ; 0x5D
SYSTEMP1                         EQU      94          ; 0x5E
SYSTEMP1_E                       EQU      97          ; 0x61
SYSTEMP1_H                       EQU      95          ; 0x5F
SYSTEMP1_U                       EQU      96          ; 0x60
SYSTEMP2                         EQU      98          ; 0x62
SYSTEMP2_H                       EQU      99          ; 0x63
SYSTEMP3                         EQU     100          ; 0x64
SYSVALTEMP                       EQU     101          ; 0x65
SYSVALTEMP_H                     EQU     102          ; 0x66
SYSWAITTEMP10US                  EQU     117          ; 0x75 (SA)
SYSWAITTEMPMS                    EQU     114          ; 0x72 (SA)
SYSWAITTEMPMS_H                  EQU     115          ; 0x73 (SA)
SYSWAITTEMPS                     EQU     116          ; 0x74 (SA)
SYSWAITTEMPUS                    EQU     117          ; 0x75 (SA)
SYSWAITTEMPUS_H                  EQU     118          ; 0x76 (SA)
SYSWORDTEMPA                     EQU     117          ; 0x75 (SA)
SYSWORDTEMPA_H                   EQU     118          ; 0x76 (SA)
SYSWORDTEMPB                     EQU     121          ; 0x79 (SA)
SYSWORDTEMPB_H                   EQU     122          ; 0x7A (SA)
SYSWORDTEMPX                     EQU     112          ; 0x70 (SA)
SYSWORDTEMPX_H                   EQU     113          ; 0x71 (SA)

;********************************************************************************

;Alias variables
AFSR0 EQU 4
AFSR0_H EQU 5
SYSLEFT_0 EQU 727
SYSREADADBYTE EQU 64
SYSRIGHT_0 EQU 686
SYSSCALEWORD EQU 65
SYSSCALEWORD_H EQU 66
SYSSTR_0 EQU 623

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
	call	INIT_OCULAR_OM1614_LCD

;Start_of_the_main_program
;
;A demonstration program for GCBASIC.
;--------------------------------------------------------------------------------------------------------------------------------
;This program demonstrates the capabilities of the board
;
;This the basic test - set the LEDs on
;
;@author 	EvanV
;@licence	GPL
;@version	1.0a
;@date   	14.01.2025
;*******************************************************************************
;Set microcontroller required
;
;------------PORTA---------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ------------SW--------------ADC--
;IO:    ---------------------------------
;
;------------PORTB----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ----------------LED-LED-LED-LED--
;IO:    ---------------------------------
;
;------------PORTC----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ----TX---------------------------
;IO:    ---------------------------------
;
;------------PORTD----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    PWR-EN--RW--RS--DB7-DB6-DB5-DB4--
;IO:    ---------------------------------
;
;------------PORTE----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ----------------RST---------------
;IO:    ---------------------------------
;
;Define constants to make things easier. We can reuse a constant at any time.
;Dir     LEDD0 Out
	banksel	TRISB
	bcf	TRISB,0
;Dir     LEDD1 Out
	bcf	TRISB,1
;Dir     LEDD2 Out
	bcf	TRISB,2
;Dir     LEDD3 Out
	bcf	TRISB,3
;This is the PORTA.0 port
;Dir POTENTIOMETER In
	bsf	TRISA,0
;Dir     SWITCHIN      In
	bsf	TRISA,4
;Dir     RSTBUTTON     In  // this is set automatically - and, you cannot set as an output
	bsf	TRISE,3
;Setup LCD Parameters
;! Specify explicit OCULAR_OM1614 support!!
;! Required for OCULAR LCD driver
;Define LCD Hardware settings
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Print "GCBASIC 2025"
	movlw	low StringTable1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT119
;Wait 2 s: CLS
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;Wait 2 s: CLS
	call	CLS
;Print ChipNameStr
	movlw	low StringTable153
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable153) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT119
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;Print ChipMHz
	movlw	32
	movwf	LCDVALUE
	call	PRINT120
;Print "mHz"
	movlw	low StringTable2
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT119
;Wait 1 s: CLS
	movlw	1
	movwf	SysWaitTempS
	call	Delay_S
;Wait 1 s: CLS
	call	CLS
;Dim direction As Bit
;Dim mydelay As Word
;Dim LEDportState as Byte
;Control Constants
;Start from left direction
;direction = LED_LEFT
	bsf	SYSBITVAR0,0
;Set the initial LED states - change to suit your configuration
;LEDportState = 1
	movlw	1
	movwf	LEDPORTSTATE
;Main loop
;Do
SysDoLoop_S1
;Locate 0, 0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;Get a value for the ADC port
;mydelay = ReadAD( ANA0 )
	clrf	ADREADPORT
	call	FN_READAD6
	movf	SYSREADADBYTE,W
	movwf	MYDELAY
	clrf	MYDELAY_H
;mydelay = scale( mydelay, 0, 255, 50, 1000 )
	movf	MYDELAY,W
	movwf	L_MAP
	movf	MYDELAY_H,W
	movwf	L_MAP_H
	clrf	L_FROMLOW
	clrf	L_FROMLOW_H
	movlw	255
	movwf	L_FROMHIGH
	clrf	L_FROMHIGH_H
	movlw	50
	movwf	L_TOLOW
	clrf	L_TOLOW_H
	movlw	232
	movwf	L_TOHIGH
	movlw	3
	movwf	L_TOHIGH_H
	clrf	L_CALIBRATE
	clrf	L_CALIBRATE_H
	call	FN_SCALE79
	movf	SYSSCALEWORD,W
	movwf	MYDELAY
	movf	SYSSCALEWORD_H,W
	movwf	MYDELAY_H
;Set the port and only the state of our LEDs
;LATB = LEDportState AND 0b00001111
	movlw	15
	andwf	LEDPORTSTATE,W
	banksel	LATB
	movwf	LATB
;Show state on LCD
;Locate 0,5
	banksel	LCDLINE
	clrf	LCDLINE
	movlw	5
	movwf	LCDCOLUMN
	call	LOCATE
;Print Right(ByteToBin ( LEDportState ),4)
	movf	LEDPORTSTATE,W
	movwf	BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysSYSINSTRINGHandler
	movlw	high BYTETOBIN
	movwf	SysSYSINSTRINGHandler_H
	movlw	4
	movwf	SYSCHARCOUNT
	call	FN_RIGHT
	movlw	low RIGHT
	movwf	SysPRINTDATAHandler
	movlw	high RIGHT
	movwf	SysPRINTDATAHandler_H
	call	PRINT119
;Print " "
	movlw	low StringTable3
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT119
;Print Left( Str(mydelay)+"    ",4)
	movf	MYDELAY,W
	movwf	SYSVALTEMP
	movf	MYDELAY_H,W
	movwf	SYSVALTEMP_H
	call	FN_STR
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	call	SYSCOPYSTRINGPART
	movlw	low StringTable4
	movwf	SysStringA
	movlw	(high StringTable4) & 127
	movwf	SysStringA_H
	call	SYSREADSTRINGPART
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysSYSINSTRINGHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRINGHandler_H
	movlw	4
	movwf	SYSCHARCOUNT
;Using SYSSTRINGPARAM1*0
	call	FN_LEFT
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low LEFT
	movwf	FSR0L
	movlw	high LEFT
	movwf	FSR0H
	call	SYSCOPYSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
;Using SYSSTRINGPARAM1*0
	call	PRINT119
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;Wait, and then check the switch has been pressed
;Wait mydelay ms
	movf	MYDELAY,W
	movwf	SysWaitTempMS
	movf	MYDELAY_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;Manage the direction
;If  funcKeyPressed() = TRUE Then
	call	FN_FUNCKEYPRESSED
	btfss	SYSBITVAR0,1
	goto	ENDIF1
;change the direction
;direction = !direction
	clrf	SysTemp1
	btfsc	SYSBITVAR0,0
	incf	SysTemp1,F
	comf	SysTemp1,F
	bcf	SYSBITVAR0,0
	btfsc	SysTemp1,0
	bsf	SYSBITVAR0,0
;End If
ENDIF1
;Set the LEDs
;If  direction = LED_LEFT  Then
	btfss	SYSBITVAR0,0
	goto	ELSE2_1
;Print "<L:"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT119
;If LEDportState.3 = 1 then
	btfss	LEDPORTSTATE,3
	goto	ELSE3_1
;LEDportState = 0
	clrf	LEDPORTSTATE
;C = 1
	bsf	STATUS,C
;Else
	goto	ENDIF3
ELSE3_1
;C = 0
	bcf	STATUS,C
;End If
ENDIF3
;shift the contents of LEDportState
;Rotate LEDportState Left
	rlf	LEDPORTSTATE,F
;Else
	goto	ENDIF2
ELSE2_1
;Print ">R:"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT119
;shift the contents of LEDportState
;C = 0
	bcf	STATUS,C
;Rotate LEDportState Right
	rrf	LEDPORTSTATE,F
;If C = 1 Then LEDportState.3 = 1
	btfsc	STATUS,C
;If C = 1 Then LEDportState.3 = 1
	bsf	LEDPORTSTATE,3
;If C = 1 Then LEDportState.3 = 1
;End If
ENDIF2
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;This is function, it returns the state of the switch
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Source: string.h (1171)
FN_BYTETOBIN
;ByteToBin = ""
	movlw	low BYTETOBIN
	movwf	FSR1L
	movlw	high BYTETOBIN
	movwf	FSR1H
	movlw	low StringTable63
	movwf	SysStringA
	movlw	(high StringTable63) & 127
	movwf	SysStringA_H
	call	SYSREADSTRING
;Repeat 8
	movlw	8
	movwf	SysRepeatTemp1
SysRepeatLoop1
;If ByteNum.7 = 1 Then
	btfss	BYTENUM,7
	goto	ELSE54_1
;ByteToBin = ByteToBin +"1"
	movlw	low BYTETOBIN
	movwf	FSR1L
	movlw	high BYTETOBIN
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	call	SYSCOPYSTRINGPART
	movlw	low StringTable67
	movwf	SysStringA
	movlw	(high StringTable67) & 127
	movwf	SysStringA_H
	call	SYSREADSTRINGPART
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;Else
	goto	ENDIF54
ELSE54_1
;ByteToBin = ByteToBin +"0"
	movlw	low BYTETOBIN
	movwf	FSR1L
	movlw	high BYTETOBIN
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	call	SYSCOPYSTRINGPART
	movlw	low StringTable68
	movwf	SysStringA
	movlw	(high StringTable68) & 127
	movwf	SysStringA_H
	call	SYSREADSTRINGPART
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;End If
ENDIF54
;Rotate ByteNum Left
	rlf	BYTENUM,F
;End Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

;Source: lcd.h (1231)
CHECKBUSYFLAG
;Sub that waits until LCD controller busy flag goes low (ready)
;Only used by LCD_IO 4,8 and only when LCD_NO_RW is NOT Defined
;Called by sub LCDNOrmalWriteByte
;Dim LCDTEMPRWCount
;LCD_RSTemp = LCD_RS
	bcf	SYSLCDTEMP,2
	btfsc	PORTD,4
	bsf	SYSLCDTEMP,2
;DIR SCRIPT_LCD_BF IN
	banksel	TRISD
	bsf	TRISD,3
;SET LCD_RS OFF
	banksel	LATD
	bcf	LATD,4
;SET LCD_RW ON
	bsf	LATD,5
;LCDTEMPRWCount = 0
	banksel	LCDTEMPRWCOUNT
	clrf	LCDTEMPRWCOUNT
;Do
SysDoLoop_S2
;wait 1 us
	movlw	2
	movwf	DELAYTEMP
DelayUS11
	decfsz	DELAYTEMP,F
	goto	DelayUS11
	nop
;Set LCD_Enable ON
	banksel	LATD
	bsf	LATD,6
;wait 1 us
	movlw	2
	movwf	DELAYTEMP
DelayUS12
	decfsz	DELAYTEMP,F
	goto	DelayUS12
	nop
;SysLCDTemp.7 = SCRIPT_LCD_BF
	banksel	SYSLCDTEMP
	bcf	SYSLCDTEMP,7
	btfsc	PORTD,3
	bsf	SYSLCDTEMP,7
;Set LCD_Enable OFF
	banksel	LATD
	bcf	LATD,6
;Wait 1 us
	movlw	2
	movwf	DELAYTEMP
DelayUS13
	decfsz	DELAYTEMP,F
	goto	DelayUS13
	nop
;PulseOut LCD_Enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6
;WaitL1 Time
	movlw	2
	movwf	DELAYTEMP
DelayUS14
	decfsz	DELAYTEMP,F
	goto	DelayUS14
;Set Pin Off
	bcf	LATD,6
;Wait 1 us
	movlw	2
	movwf	DELAYTEMP
DelayUS15
	decfsz	DELAYTEMP,F
	goto	DelayUS15
	nop
;if LCDTEMPRWCount = 255 Then SysLCDTemp.7 = 0
	banksel	LCDTEMPRWCOUNT
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
	banksel	LATD
	bcf	LATD,4
	banksel	SYSLCDTEMP
	btfss	SYSLCDTEMP,2
	goto	ENDIF58
	banksel	LATD
	bsf	LATD,4
ENDIF58
	banksel	STATUS
	return

;********************************************************************************

;Source: lcd.h (614)
CLS
;Sub to clear the LCD
;SET LCD_RS OFF
	banksel	LATD
	bcf	LATD,4
;Clear screen
;LCDWriteByte (0b00000001)
	movlw	1
	banksel	LCDBYTE
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

;Source: 105_reversible_leds_with_variable_delay_to_LCD.gcb (174)
FN_FUNCKEYPRESSED
;Define some variables
;Dim CurrentSwitchState As Bit
;Dim LastSwitchState As Bit
;wait 1 ms
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Is the switch pressed down ?
;If ( SWITCHIN = DOWN ) Then
	btfss	PORTA,4
	goto	ELSE7_1
;Set the state
;CurrentSwitchState = TRUE
	bsf	SYSBITVAR0,2
;Else
	goto	ENDIF7
ELSE7_1
;So, switch is therefore UP/released
;CurrentSwitchState = FALSE
	bcf	SYSBITVAR0,2
;End If
ENDIF7
;This check ensures the state of the switch ....
;ensure the switch has changed state
;If ( CurrentSwitchState <> LastSwitchState ) AND ( CurrentSwitchState = TRUE ) Then
	clrf	SysBYTETempA
	btfsc	SYSBITVAR0,2
	incf	SysBYTETempA,F
	clrf	SysBYTETempB
	btfsc	SYSBITVAR0,3
	incf	SysBYTETempB,F
	call	SYSCOMPEQUAL
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	clrf	SysByteTempX
	btfsc	SYSBITVAR0,2
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp2
	movf	SysTemp1,W
	andwf	SysTemp2,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ELSE8_1
;Return the state value - returns TRUE
;funcKeyPressed = TRUE
	bsf	SYSBITVAR0,1
;Else
	goto	ENDIF8
ELSE8_1
;Switch is not down
;funcKeyPressed = FALSE
	bcf	SYSBITVAR0,1
;End If
ENDIF8
;LastSwitchState = CurrentSwitchState
	bcf	SYSBITVAR0,3
	btfsc	SYSBITVAR0,2
	bsf	SYSBITVAR0,3
	return

;********************************************************************************

;Source: system.h (201)
INITSYS
;Handle chips with only 2 IRCF bits (IRCF1, IRCF0) like 16F720/721 and its LF siblings
;16F72x has 500kHz INTOSC with 32x PLL option and postscaler (÷1,2,4,8)
;Type 103: Chips without SPLLEN, IRCF3, but must have at least IRCF2 (exclude 2-bit IRCF chips)
;OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;equates to OSCCON = OSCCON AND b'10000111' & OSCCON = OSCCON OR b'11110000'
;= 32Mhz
;Set IRCF3 On
	banksel	OSCCON
	bsf	OSCCON,IRCF3
;Set IRCF2 On
	bsf	OSCCON,IRCF2
;Set IRCF1 On
	bsf	OSCCON,IRCF1
;Set IRCF0 Off
	bcf	OSCCON,IRCF0
;Set SPLLEN On
	bsf	OSCCON,SPLLEN
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON1,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELD = 0
	clrf	ANSELD
;ANSELE = 0
	clrf	ANSELE
;Set comparator register bits for many MCUs with register CM2CON0
;C2ON = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
;C1ON = 0
	bcf	CM1CON0,C1ON
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

;Source: lcd.h (3032)
INIT_OCULAR_OM1614_LCD
;`LCD_Speed is SLOW`
;`OPTIMAL is set to ` OPTIMAL
;`LCD_Speed is set to ` LCD_Speed
;Dir LCD_POWER OUT
	banksel	TRISD
	bcf	TRISD,7
;Set LCD_POWER ON
	banksel	LATD
	bsf	LATD,7
;Wait 50 ms
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
;Dir LCD_RW OUT
	banksel	TRISD
	bcf	TRISD,5
;Set LCD_RW OFF
	banksel	LATD
	bcf	LATD,5
;Dir LCD_DB4 OUT
	banksel	TRISD
	bcf	TRISD,0
;Dir LCD_DB5 OUT
	bcf	TRISD,1
;Dir LCD_DB6 OUT
	bcf	TRISD,2
;Dir LCD_DB7 OUT
	bcf	TRISD,3
;Dir LCD_RS      OUT
	bcf	TRISD,4
;Dir LCD_Enable  OUT
	bcf	TRISD,6
;Set LCD_RS      OFF
	banksel	LATD
	bcf	LATD,4
;Set LCD_Enable  OFF
	bcf	LATD,6
;LCDWrite_Nibble HD44780_LCD_RESET
	movlw	48
	banksel	LCD2BYTE
	movwf	LCD2BYTE
	call	LCDWRITE_NIBBLE
;Wait 5 ms
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCDWrite_Nibble HD44780_LCD_RESET
	movlw	48
	movwf	LCD2BYTE
	call	LCDWRITE_NIBBLE
;Wait 100 us
	movlw	1
	movwf	DELAYTEMP2
DelayUSO7
	clrf	DELAYTEMP
DelayUS7
	decfsz	DELAYTEMP,F
	goto	DelayUS7
	decfsz	DELAYTEMP2,F
	goto	DelayUSO7
	movlw	9
	movwf	DELAYTEMP
DelayUS8
	decfsz	DELAYTEMP,F
	goto	DelayUS8
;LCDWrite_Nibble HD44780_LCD_RESET
	movlw	48
	movwf	LCD2BYTE
	call	LCDWRITE_NIBBLE
;CheckBusyFlag
	call	CHECKBUSYFLAG
;LCDWrite_Nibble HD44780_FOUR_BIT
	movlw	32
	movwf	LCD2BYTE
	call	LCDWRITE_NIBBLE
;CheckBusyFlag
	call	CHECKBUSYFLAG
;LCDWriteByte(HD44780_FOUR_BIT_TWO_LINE)
	movlw	40
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;LCDWriteByte(HD44780_DISPLAY_CTRL + HD44780_DISPLAY_ON)
	movlw	12
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;LCDWriteByte(HD44780_ENTRY_MODE + HD44780_CURSOR_INC + HD44780_DSHIFT_OFF)
	movlw	6
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;CLS
	goto	CLS

;********************************************************************************

;Source: lcd.h (1289)
LCDNORMALWRITEBYTE
;Sub to write a byte to the LCD
;Dim LCD_I2C_Address_Current
;CheckBusyFlag         'WaitForReady
	call	CHECKBUSYFLAG
;set LCD_RW OFF
	banksel	LATD
	bcf	LATD,5
;Dim Temp as Byte
;Pins must be outputs if returning from WaitForReady, or after LCDReadByte or GET subs
;DIR LCD_DB4 OUT
	banksel	TRISD
	bcf	TRISD,0
;DIR LCD_DB5 OUT
	bcf	TRISD,1
;DIR LCD_DB6 OUT
	bcf	TRISD,2
;DIR LCD_DB7 OUT
	bcf	TRISD,3
;Write upper nibble to output pins
;set LCD_DB4 OFF
;set LCD_DB5 OFF
;set LCD_DB6 OFF
;set LCD_DB7 OFF
;if LCDByte.7 ON THEN SET LCD_DB7 ON
;if LCDByte.6 ON THEN SET LCD_DB6 ON
;if LCDByte.5 ON THEN SET LCD_DB5 ON
;if LCDByte.4 ON THEN SET LCD_DB4 ON
;LCD_DB7 = LCDByte.7
	banksel	LATD
	bcf	LATD,3
	banksel	LCDBYTE
	btfss	LCDBYTE,7
	goto	ENDIF27
	banksel	LATD
	bsf	LATD,3
ENDIF27
;LCD_DB6 = LCDByte.6
	banksel	LATD
	bcf	LATD,2
	banksel	LCDBYTE
	btfss	LCDBYTE,6
	goto	ENDIF28
	banksel	LATD
	bsf	LATD,2
ENDIF28
;LCD_DB5 = LCDByte.5
	banksel	LATD
	bcf	LATD,1
	banksel	LCDBYTE
	btfss	LCDBYTE,5
	goto	ENDIF29
	banksel	LATD
	bsf	LATD,1
ENDIF29
;LCD_DB4 = LCDByte.4
	banksel	LATD
	bcf	LATD,0
	banksel	LCDBYTE
	btfss	LCDBYTE,4
	goto	ENDIF30
	banksel	LATD
	bsf	LATD,0
ENDIF30
;Wait 1 us
	movlw	2
	movwf	DELAYTEMP
DelayUS2
	decfsz	DELAYTEMP,F
	goto	DelayUS2
	nop
;PulseOut LCD_enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	banksel	LATD
	bsf	LATD,6
;WaitL1 Time
	movlw	2
	movwf	DELAYTEMP
DelayUS3
	decfsz	DELAYTEMP,F
	goto	DelayUS3
;Set Pin Off
	bcf	LATD,6
;All data pins low
;set LCD_DB4 OFF
;set LCD_DB5 OFF
;set LCD_DB6 OFF
;set LCD_DB7 OFF
	bcf	LATD,3
;
;'Write lower nibble to output pins
;if LCDByte.3 ON THEN SET LCD_DB7 ON
	banksel	LCDBYTE
	btfss	LCDBYTE,3
	goto	ENDIF23
;if LCDByte.3 ON THEN SET LCD_DB7 ON
	banksel	LATD
	bsf	LATD,3
;if LCDByte.3 ON THEN SET LCD_DB7 ON
ENDIF23
;if LCDByte.2 ON THEN SET LCD_DB6 ON
;if LCDByte.1 ON THEN SET LCD_DB5 ON
;if LCDByte.0 ON THEN SET LCD_DB4 ON
;LCD_DB7 = LCDByte.3
;LCD_DB6 = LCDByte.2
	banksel	LATD
	bcf	LATD,2
	banksel	LCDBYTE
	btfss	LCDBYTE,2
	goto	ENDIF31
	banksel	LATD
	bsf	LATD,2
ENDIF31
;LCD_DB5 = LCDByte.1
	banksel	LATD
	bcf	LATD,1
	banksel	LCDBYTE
	btfss	LCDBYTE,1
	goto	ENDIF32
	banksel	LATD
	bsf	LATD,1
ENDIF32
;LCD_DB4 = LCDByte.0
	banksel	LATD
	bcf	LATD,0
	banksel	LCDBYTE
	btfss	LCDBYTE,0
	goto	ENDIF33
	banksel	LATD
	bsf	LATD,0
ENDIF33
;Wait 1 us
	movlw	2
	movwf	DELAYTEMP
DelayUS4
	decfsz	DELAYTEMP,F
	goto	DelayUS4
	nop
;PulseOut LCD_enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	banksel	LATD
	bsf	LATD,6
;WaitL1 Time
	movlw	2
	movwf	DELAYTEMP
DelayUS5
	decfsz	DELAYTEMP,F
	goto	DelayUS5
;Set Pin Off
	bcf	LATD,6
;Set data pins low again
;SET LCD_DB7 OFF
;SET LCD_DB6 OFF
;SET LCD_DB5 OFF
;SET LCD_DB4 OFF
;Wait SCRIPT_LCD_POSTWRITEDELAY
	movlw	226
	movwf	DELAYTEMP
DelayUS6
	decfsz	DELAYTEMP,F
	goto	DelayUS6
	nop
;If Register Select is low
;IF LCD_RS = 0 then
	banksel	PORTD
	btfsc	PORTD,4
	goto	ENDIF24
;IF LCDByte < 16 then
	movlw	16
	subwf	LCDBYTE,W
	btfsc	STATUS, C
	goto	ENDIF25
;if LCDByte > 7 then
	movf	LCDBYTE,W
	sublw	7
	btfsc	STATUS, C
	goto	ENDIF26
;LCD_State = LCDByte
	movf	LCDBYTE,W
	movwf	LCD_STATE
;end if
ENDIF26
;END IF
ENDIF25
;END IF
ENDIF24
	return

;********************************************************************************

;Source: lcd.h (3116)
LCDWRITE_NIBBLE
;set LCD_RS OFF
	banksel	LATD
	bcf	LATD,4
;CheckBusyFlag         'WaitForReady
	banksel	STATUS
	call	CHECKBUSYFLAG
;set LCD_RW OFF
	banksel	LATD
	bcf	LATD,5
;Pins must be outputs if returning from WaitForReady, or after LCDReadByte or GET subs
;DIR LCD_DB4 OUT
	banksel	TRISD
	bcf	TRISD,0
;DIR LCD_DB5 OUT
	bcf	TRISD,1
;DIR LCD_DB6 OUT
	bcf	TRISD,2
;DIR LCD_DB7 OUT
	bcf	TRISD,3
;Write upper nibble to output pins
;LCD_DB4 = LCDByte.4
	banksel	LATD
	bcf	LATD,0
	banksel	LCDBYTE
	btfss	LCDBYTE,4
	goto	ENDIF34
	banksel	LATD
	bsf	LATD,0
ENDIF34
;LCD_DB5 = LCDByte.5
	banksel	LATD
	bcf	LATD,1
	banksel	LCDBYTE
	btfss	LCDBYTE,5
	goto	ENDIF35
	banksel	LATD
	bsf	LATD,1
ENDIF35
;LCD_DB6 = LCDByte.6
	banksel	LATD
	bcf	LATD,2
	banksel	LCDBYTE
	btfss	LCDBYTE,6
	goto	ENDIF36
	banksel	LATD
	bsf	LATD,2
ENDIF36
;LCD_DB7 = LCDByte.7
	banksel	LATD
	bcf	LATD,3
	banksel	LCDBYTE
	btfss	LCDBYTE,7
	goto	ENDIF37
	banksel	LATD
	bsf	LATD,3
ENDIF37
;LCD_enable = 1
	banksel	LATD
	bsf	LATD,6
;Wait 1 us
	movlw	2
	movwf	DELAYTEMP
DelayUS9
	decfsz	DELAYTEMP,F
	goto	DelayUS9
	nop
;LCD_enable = 0
	bcf	LATD,6
;Wait SCRIPT_LCD_POSTWRITEDELAY
	movlw	226
	movwf	DELAYTEMP
DelayUS10
	decfsz	DELAYTEMP,F
	goto	DelayUS10
	nop
	banksel	STATUS
	return

;********************************************************************************

;Source: string.h (961)
FN_LEFT
;Empty input?
;If SysInString(0) = 0 Then
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,F
	btfss	STATUS, Z
	goto	ENDIF46
;Left(0) = 0
	banksel	SYSLEFT_0
	clrf	SYSLEFT_0
;Exit Function
	banksel	STATUS
	return
;End If
ENDIF46
;Input length too high?
;If SysInString(0) < SysCharCount Then
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	SYSCHARCOUNT,W
	subwf	INDF0,W
	btfsc	STATUS, C
	goto	ENDIF47
;SysCharCount = SysInString(0)
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SYSCHARCOUNT
;End If
ENDIF47
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
;Legacy method
	clrf	SYSSTRINGTEMP
	movlw	1
	subwf	SYSCHARCOUNT,W
	btfss	STATUS, C
	goto	SysForLoopEnd2
SysForLoop2
	incf	SYSSTRINGTEMP,F
;Left(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W
	addwf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp2
	movwf	SysArrayTemp1
	movlw	low(LEFT)
	addwf	SYSSTRINGTEMP,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(LEFT)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
;Next
	movf	SYSCHARCOUNT,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
;Left(0) = SysCharCount
	movf	SYSCHARCOUNT,W
	banksel	SYSLEFT_0
	movwf	SYSLEFT_0
	banksel	STATUS
	return

;********************************************************************************

;Source: lcd.h (600)
LOCATE
;Sub to locate the cursor
;Where LCDColumn is 0 to screen width-1, LCDLine is 0 to screen height-1
;Set LCD_RS Off
	banksel	LATD
	bcf	LATD,4
;If LCDLine > 1 Then
	banksel	LCDLINE
	movf	LCDLINE,W
	sublw	1
	btfsc	STATUS, C
	goto	ENDIF17
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F
;LCDColumn = LCDColumn + LCD_WIDTH
	movlw	20
	addwf	LCDCOLUMN,F
;End If
ENDIF17
;LCDWriteByte(0x80 or 0x40 * LCDLine + LCDColumn)
	movf	LCDLINE,W
	movwf	SysBYTETempA
	movlw	64
	movwf	SysBYTETempB
	call	SYSMULTSUB
	movf	LCDCOLUMN,W
	addwf	SysBYTETempX,W
	movwf	SysTemp3
	movlw	128
	iorwf	SysTemp3,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US
	goto	Delay_10US

;********************************************************************************

;Overloaded signature: STRING:, Source: lcd.h (1060)
PRINT119
;Sub to print a string variable on the LCD
;Dim SysPrintTemp
;Dim PrintLen
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
	banksel	LATD
	bsf	LATD,4
;Write Data
;For SysPrintTemp = 1 To PrintLen
;Legacy method
	banksel	SYSPRINTTEMP
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

;Overloaded signature: BYTE:, Source: lcd.h (1076)
PRINT120
;Sub to print a byte variable on the LCD
;LCDValueTemp = 0
	clrf	LCDVALUETEMP
;Set LCD_RS On
	banksel	LATD
	bsf	LATD,4
;IF LCDValue >= 100 Then
	movlw	100
	banksel	LCDVALUE
	subwf	LCDVALUE,W
	btfss	STATUS, C
	goto	ENDIF21
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
ENDIF21
;If LCDValueTemp > 0 Or LCDValue >= 10 Then
	movf	LCDVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	call	SYSCOMPLESSTHAN
	movf	SysByteTempX,W
	movwf	SysTemp3
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F
	movf	SysTemp3,W
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF22
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
ENDIF22
;LCDWriteByte (LCDValue + 48)
	movlw	48
	addwf	LCDVALUE,W
	movwf	LCDBYTE
	goto	LCDNORMALWRITEBYTE

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2170)
FN_READAD6
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (637)
;Handle devices with no ANSEL0 AND no ANSEL
;Code for devices with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;#ifNdef Bit(CHS5) ChipPins = 28  Or ChipPins = 40 @DebugADC_H
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
;Case 4: Set ANSELA.5 On
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
;Case 4: Set ANSELA.5 On
	banksel	ANSELA
	bsf	ANSELA,5
;Case 12: Set ANSELB.0 On
	goto	SysSelectEnd1
SysSelect1Case6
	movlw	12
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case7
;Case 12: Set ANSELB.0 On
	banksel	ANSELB
	bsf	ANSELB,0
;Case 10: Set ANSELB.1 On
	goto	SysSelectEnd1
SysSelect1Case7
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case8
;Case 10: Set ANSELB.1 On
	banksel	ANSELB
	bsf	ANSELB,1
;Case 8: Set ANSELB.2 On
	goto	SysSelectEnd1
SysSelect1Case8
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case9
;Case 8: Set ANSELB.2 On
	banksel	ANSELB
	bsf	ANSELB,2
;Case 9: Set ANSELB.3 On
	goto	SysSelectEnd1
SysSelect1Case9
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case10
;Case 9: Set ANSELB.3 On
	banksel	ANSELB
	bsf	ANSELB,3
;Case 11: Set ANSELB.4 On
	goto	SysSelectEnd1
SysSelect1Case10
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case11
;Case 11: Set ANSELB.4 On
	banksel	ANSELB
	bsf	ANSELB,4
;Case 13: Set ANSELB.5 On
	goto	SysSelectEnd1
SysSelect1Case11
	movlw	13
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case12
;Case 13: Set ANSELB.5 On
	banksel	ANSELB
	bsf	ANSELB,5
;Case 20: Set ANSELD.0 On
	goto	SysSelectEnd1
SysSelect1Case12
	movlw	20
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case13
;Case 20: Set ANSELD.0 On
	banksel	ANSELD
	bsf	ANSELD,0
;Case 21: Set ANSELD.1 On
	goto	SysSelectEnd1
SysSelect1Case13
	movlw	21
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case14
;Case 21: Set ANSELD.1 On
	banksel	ANSELD
	bsf	ANSELD,1
;Case 22: Set ANSELD.2 On
	goto	SysSelectEnd1
SysSelect1Case14
	movlw	22
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case15
;Case 22: Set ANSELD.2 On
	banksel	ANSELD
	bsf	ANSELD,2
;Case 23: Set ANSELD.3 On
	goto	SysSelectEnd1
SysSelect1Case15
	movlw	23
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case16
;Case 23: Set ANSELD.3 On
	banksel	ANSELD
	bsf	ANSELD,3
;Case 24: Set ANSELD.4 On
	goto	SysSelectEnd1
SysSelect1Case16
	movlw	24
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case17
;Case 24: Set ANSELD.4 On
	banksel	ANSELD
	bsf	ANSELD,4
;Case 25: Set ANSELD.5 On
	goto	SysSelectEnd1
SysSelect1Case17
	movlw	25
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case18
;Case 25: Set ANSELD.5 On
	banksel	ANSELD
	bsf	ANSELD,5
;Case 26: Set ANSELD.6 On
	goto	SysSelectEnd1
SysSelect1Case18
	movlw	26
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case19
;Case 26: Set ANSELD.6 On
	banksel	ANSELD
	bsf	ANSELD,6
;Case 27: Set ANSELD.7 On
	goto	SysSelectEnd1
SysSelect1Case19
	movlw	27
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case20
;Case 27: Set ANSELD.7 On
	banksel	ANSELD
	bsf	ANSELD,7
;Case 5: Set ANSELE.0 On
	goto	SysSelectEnd1
SysSelect1Case20
	movlw	5
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case21
;Case 5: Set ANSELE.0 On
	banksel	ANSELE
	bsf	ANSELE,0
;Case 6: Set ANSELE.1 On
	goto	SysSelectEnd1
SysSelect1Case21
	movlw	6
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case22
;Case 6: Set ANSELE.1 On
	banksel	ANSELE
	bsf	ANSELE,1
;Case 7: Set ANSELE.2 On
	goto	SysSelectEnd1
SysSelect1Case22
	movlw	7
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;Case 7: Set ANSELE.2 On
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
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADREADPORT
	btfss	ADREADPORT,0
	goto	ENDIF12
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADCON0
	bsf	ADCON0,CHS0
;IF ADReadPort.0 On Then Set CHS0 On
ENDIF12
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADREADPORT
	btfss	ADREADPORT,1
	goto	ENDIF13
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADCON0
	bsf	ADCON0,CHS1
;IF ADReadPort.1 On Then Set CHS1 On
ENDIF13
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADREADPORT
	btfss	ADREADPORT,2
	goto	ENDIF14
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADCON0
	bsf	ADCON0,CHS2
;IF ADReadPort.2 On Then Set CHS2 On
ENDIF14
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADREADPORT
	btfss	ADREADPORT,3
	goto	ENDIF15
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADCON0
	bsf	ADCON0,CHS3
;If ADReadPort.3 On Then Set CHS3 On
ENDIF15
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADREADPORT
	btfss	ADREADPORT,4
	goto	ENDIF16
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADCON0
	bsf	ADCON0,CHS4
;If ADReadPort.4 On Then Set CHS4 On
ENDIF16
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
	bsf	ADCON0,GO_NOT_DONE
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop1
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop1
;Switch off A/D
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
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

;Source: string.h (980)
FN_RIGHT
;Empty input?
;If SysInString(0) = 0 Then
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,F
	btfss	STATUS, Z
	goto	ENDIF50
;Right(0) = 0
	banksel	SYSRIGHT_0
	clrf	SYSRIGHT_0
;Exit Function
	banksel	STATUS
	return
;End If
ENDIF50
;Input length too high?
;If SysInString(0) < SysCharCount Then
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	SYSCHARCOUNT,W
	subwf	INDF0,W
	btfsc	STATUS, C
	goto	ENDIF51
;SysCharCount = SysInString(0)
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SYSCHARCOUNT
;End If
ENDIF51
;Copy rightmost characters
;SysCharStart = SysInString(0) - SysCharCount
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	SYSCHARCOUNT,W
	subwf	INDF0,W
	movwf	SYSCHARSTART
;For SysStringTemp = 1 To SysCharCount
;Legacy method
	clrf	SYSSTRINGTEMP
	movlw	1
	subwf	SYSCHARCOUNT,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
SysForLoop3
	incf	SYSSTRINGTEMP,F
;Right(SysStringTemp) = SysInString(SysCharStart + SysStringTemp)
	movf	SYSSTRINGTEMP,W
	addwf	SYSCHARSTART,W
	movwf	SysTemp3
	addwf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp2
	movwf	SysArrayTemp1
	movlw	low(RIGHT)
	addwf	SYSSTRINGTEMP,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(RIGHT)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
;Next
	movf	SYSCHARCOUNT,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop3
SysForLoopEnd3
;Right(0) = SysCharCount
	movf	SYSCHARCOUNT,W
	banksel	SYSRIGHT_0
	movwf	SYSRIGHT_0
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:integer:, Source: stdbasic.h (266)
FN_SCALE79
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	movf	L_FROMLOW,W
	subwf	L_MAP,W
	movwf	SysTemp1
	movf	L_FROMLOW_H,W
	subwfb	L_MAP_H,W
	movwf	SysTemp1_H
	movf	L_TOLOW,W
	subwf	L_TOHIGH,W
	movwf	SysTemp2
	movf	L_TOLOW_H,W
	subwfb	L_TOHIGH_H,W
	movwf	SysTemp2_H
	movf	SYSTEMP1,W
	movwf	SysLONGTempA
	movf	SYSTEMP1_H,W
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	SYSTEMP2,W
	movwf	SysLONGTempB
	movf	SYSTEMP2_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SYSMULTSUB32
	movf	SysLONGTempX,W
	movwf	L_SYSCALCF
	movf	SysLONGTempX_H,W
	movwf	L_SYSCALCF_H
	movf	SysLONGTempX_U,W
	movwf	L_SYSCALCF_U
	movf	SysLONGTempX_E,W
	movwf	L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	movf	L_FROMLOW,W
	subwf	L_FROMHIGH,W
	movwf	L_SYSCALC
	movf	L_FROMLOW_H,W
	subwfb	L_FROMHIGH_H,W
	movwf	L_SYSCALC_H
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
	movf	L_SYSCALCF,W
	movwf	SysLONGTempA
	movf	L_SYSCALCF_H,W
	movwf	SysLONGTempA_H
	movf	L_SYSCALCF_U,W
	movwf	SysLONGTempA_U
	movf	L_SYSCALCF_E,W
	movwf	SysLONGTempA_E
	movf	L_SYSCALC,W
	movwf	SysLONGTempB
	movf	L_SYSCALC_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SYSDIVSUB32
	movf	SysLONGTempA,W
	movwf	SysTemp1
	movf	SysLONGTempA_H,W
	movwf	SysTemp1_H
	movf	SysLONGTempA_U,W
	movwf	SysTemp1_U
	movf	SysLONGTempA_E,W
	movwf	SysTemp1_E
	movf	L_TOLOW,W
	addwf	SysTemp1,W
	movwf	SysTemp2
	movf	L_TOLOW_H,W
	addwfc	SysTemp1_H,W
	movwf	SysTemp2_H
	movf	L_CALIBRATE,W
	addwf	SysTemp2,W
	movwf	SCALE
	movf	L_CALIBRATE_H,W
	addwfc	SysTemp2_H,W
	movwf	SCALE_H
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
	goto	ENDIF42
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
	clrf	SysTemp3
	movlw	high(STR)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValThousands
	goto	SYSVALTHOUSANDS
;End If
ENDIF42
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
	goto	ENDIF43
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
	clrf	SysTemp3
	movlw	high(STR)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValHundreds
	goto	SYSVALHUNDREDS
;End If
ENDIF43
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
	goto	ENDIF44
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
	clrf	SysTemp3
	movlw	high(STR)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValTens
	goto	SYSVALTENS
;End If
ENDIF44
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
	goto	ENDIF45
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
	clrf	SysTemp3
	movlw	high(STR)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;End If
ENDIF45
;Ones
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(STR)
	addwfc	SysTemp3,W
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

;Source: system.h (4111)
SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;subwf SysByteTempB, W
	subwf	SYSBYTETEMPB, W
;btfsc STATUS, Z
	btfsc	STATUS, Z
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (4137)
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

;Source: system.h (4191)
SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysLongTempA, W
	movf	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	subwf	SYSLONGTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysLongTempA_H, W
	movf	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	subwf	SYSLONGTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test upper, exit if false
;movf SysLongTempA_U, W
	movf	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	subwf	SYSLONGTEMPB_U, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test exp, exit if false
;movf SysLongTempA_E, W
	movf	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	subwf	SYSLONGTEMPB_E, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (4501)
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

;Source: system.h (4531)
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

;Source: system.h (4589)
SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test Exp, exit if more
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT32TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (1766)
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

;Source: system.h (3437)
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

;Source: system.h (3505)
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
	goto	ENDIF59
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF59
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
	goto	ENDIF60
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF60
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

;Source: system.h (3581)
SYSDIVSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	movf	SYSLONGTEMPA,W
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempA
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempA_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempA_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SYSCOMPEQUAL32
	btfss	SysByteTempX,0
	goto	ENDIF40
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF40
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP
SYSDIV32START
;set C off
	bcf	STATUS,C
;Rotate SysLongDivMultA Left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;Rotate SysLongDivMultX Left
	rlf	SYSLONGDIVMULTX,F
	rlf	SYSLONGDIVMULTX_H,F
	rlf	SYSLONGDIVMULTX_U,F
	rlf	SYSLONGDIVMULTX_E,F
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	subwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	subwfb	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	subwfb	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	subwfb	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF41
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	addwfc	SYSLONGDIVMULTX_E,F
;End If
ENDIF41
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv32Start
	goto	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movf	SYSLONGDIVMULTA,W
	movwf	SYSLONGTEMPA
	movf	SYSLONGDIVMULTA_H,W
	movwf	SYSLONGTEMPA_H
	movf	SYSLONGDIVMULTA_U,W
	movwf	SYSLONGTEMPA_U
	movf	SYSLONGDIVMULTA_E,W
	movwf	SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	return

;********************************************************************************

;Source: system.h (2924)
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

;Source: system.h (3088)
SYSMULTSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;Can't use normal SysDivMult variables for 32 bit, they overlap with
;SysLongTemp variables
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	movf	SYSLONGTEMPA,W
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	btfss	SYSLONGDIVMULTB,0
	goto	ENDIF38
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	movf	SYSLONGDIVMULTA,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTA_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTA_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTA_E,W
	addwfc	SYSLONGDIVMULTX_E,F
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
ENDIF38
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysLongDivMultB right
	rrf	SYSLONGDIVMULTB_E,F
	rrf	SYSLONGDIVMULTB_U,F
	rrf	SYSLONGDIVMULTB_H,F
	rrf	SYSLONGDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysLongDivMultA left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempB
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempB_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempB_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempB_E
	clrf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	call	SYSCOMPLESSTHAN32
	btfsc	SysByteTempX,0
;if SysLongDivMultB > 0 then goto MUL32LOOP
	goto	MUL32LOOP
;if SysLongDivMultB > 0 then goto MUL32LOOP
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	return

;********************************************************************************

;Source: system.h (1963)
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
	retlw	53	;5


StringTable2
	retlw	3
	retlw	109	;m
	retlw	72	;H
	retlw	122	;z


StringTable3
	retlw	1
	retlw	32	; 


StringTable4
	retlw	4
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable5
	retlw	3
	retlw	60	;<
	retlw	76	;L
	retlw	58	;:


StringTable6
	retlw	3
	retlw	62	;>
	retlw	82	;R
	retlw	58	;:


StringTable63
	retlw	0


StringTable67
	retlw	1
	retlw	49	;1


StringTable68
	retlw	1
	retlw	48	;0


StringTable153
	retlw	7
	retlw	49	;1
	retlw	54	;6
	retlw	70	;F
	retlw	49	;1
	retlw	57	;9
	retlw	51	;3
	retlw	55	;7


;********************************************************************************

;Program_memory_page: 1
	ORG	2048
;Program_memory_page: 2
	ORG	4096
;Program_memory_page: 3
	ORG	6144

 END
