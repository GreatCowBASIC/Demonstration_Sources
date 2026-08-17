;Program compiled by GCBASIC (2026.08.07 (Windows 64 bit) : Build 1617) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-08-15 CRC247
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\250_millis.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\250_millis.build\250_millis.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\250_millis.gcb"
 SUBTITLE    "08-17-2026 13:00:18"
#include <P18F46Q35.inc>
 CONFIG  CPD = OFF
 CONFIG  CP = OFF
 CONFIG  WRTSAF = OFF
 CONFIG  WRTD = OFF
 CONFIG  WRTB = OFF
 CONFIG  WDTE = OFF
 CONFIG  XINST = OFF
 CONFIG  LVP = OFF
 CONFIG  MVECEN = OFF
 CONFIG  MCLRE = EXTMCLR
 CONFIG  FCMEN = ON
 CONFIG  CLKOUTEN = OFF
 CONFIG  RSTOSC = HFINTOSC_1MHZ
 CONFIG  FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
CURMS                            EQU    1281          ; 0x501 (SA)
CURMS_H                          EQU    1282          ; 0x502 (SA)
LSTMS                            EQU    1283          ; 0x503 (SA)
LSTMS_H                          EQU    1284          ; 0x504 (SA)
MILLIS                           EQU    1296          ; 0x510 (SA)
MILLIS_E                         EQU    1299          ; 0x513 (SA)
MILLIS_H                         EQU    1297          ; 0x511 (SA)
MILLIS_U                         EQU    1298          ; 0x512 (SA)
MSCTR_                           EQU    1300          ; 0x514 (SA)
MSCTR__E                         EQU    1303          ; 0x517 (SA)
MSCTR__H                         EQU    1301          ; 0x515 (SA)
MSCTR__U                         EQU    1302          ; 0x516 (SA)
SYSBSR                           EQU    1287          ; 0x507 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSINTSTATESAVE0                 EQU    1288          ; 0x508 (SA)
SYSSTATUS                        EQU    1295          ; 0x50F (SA)
SYSTEMP1                         EQU    1291          ; 0x50B (SA)
SYSTEMP1_H                       EQU    1292          ; 0x50C (SA)
SYSTEMP2                         EQU    1293          ; 0x50D (SA)
SYSW                             EQU    1294          ; 0x50E (SA)
SYSWORDTEMPA                     EQU    1285          ; 0x505 (SA)
SYSWORDTEMPA_H                   EQU    1286          ; 0x506 (SA)
SYSWORDTEMPB                     EQU    1289          ; 0x509 (SA)
SYSWORDTEMPB_H                   EQU    1290          ; 0x50A (SA)
TMRPOST                          EQU    1304          ; 0x518 (SA)
TMRPRES                          EQU    1305          ; 0x519 (SA)
TMRSOURCE                        EQU    1306          ; 0x51A (SA)

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	bra	INTERRUPT

;********************************************************************************

;Program_memory_page: 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	rcall	INITSYS
	rcall	INIT_MSCTR_INT
;Enable interrupts
	bsf	INTCON0,GIE,ACCESS
	bsf	SYSINTSTATESAVE0,0,ACCESS

;Start_of_the_main_program
;''A demonstration program for GCBASIC.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is a simple GLCD demonstration of the timer capabilities using hthe millis function.
;'':
;'':
;''@author  EvanV
;''@licence GPL
;''@version 1.0
;''@date    31.10.2022
;''********************************************************************************
;Chip Settings.
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
;------------------PORTC-----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ---------------------------------
;----------------------------------------
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
	bcf	TRISB,0,BANKED
;Dir     LEDD1 Out
	bcf	TRISB,1,BANKED
;Dir     LEDD2 Out
	bcf	TRISB,2,BANKED
;Dir     LEDD3 Out
	bcf	TRISB,3,BANKED
;This is the PORTA.0 port
;Dir POTENTIOMETER In
	bsf	TRISA,0,BANKED
;Dir     SWITCHIN      In
	bsf	TRISA,4,BANKED
;Dir     RSTBUTTON     In  // this is set automatically - and, you cannot set as an output
	bsf	TRISE,3,BANKED
;! Specify explicit OCULAR_OM1614 support!!
;Setup LCD Parameters
;Define LCD Hardware settings
;! Required for OCULAR LCD driver
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim CurMs, LstMs as word  ' declare working variables
;Main                    ' This loop runs over and over forever.
;LstMs = 0
	clrf	LSTMS,ACCESS
	clrf	LSTMS_H,ACCESS
;CurMs = 0
	clrf	CURMS,ACCESS
	clrf	CURMS_H,ACCESS
;Main                    ' This loop runs over and over forever.
;Do
SysDoLoop_S1
;CurMs = millis()
	banksel	0
	rcall	FN_MILLIS
	movff	MILLIS,CURMS
	movff	MILLIS_H,CURMS_H
;IntOff
	bcf	SYSINTSTATESAVE0,0,ACCESS
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSINTSTATESAVE0,0,ACCESS
	bcf	INTCON0,GIE,ACCESS
;if CurMs - LstMs >= LEDRate then  ' required Time has Elapsed
	movf	LSTMS,W,ACCESS
	subwf	CURMS,W,ACCESS
	movwf	SysTemp1,ACCESS
	movf	LSTMS_H,W,ACCESS
	subwfb	CURMS_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF1
;LEDD3 = !LEDD3                  ' So Toggle state of LED
	clrf	SysTemp2,ACCESS
	banksel	PORTB
	btfsc	PORTB,3,BANKED
	incf	SysTemp2,F,ACCESS
	comf	SysTemp2,F,ACCESS
	bcf	LATB,3,BANKED
	btfsc	SysTemp2,0,ACCESS
	bsf	LATB,3,BANKED
;LstMs = CurMs                   ' And Record Toggle Time
	movff	CURMS,LSTMS
	movff	CURMS_H,LSTMS_H
;end if
ENDIF1
;IntOn
	btfss	SYSINTSTATESAVE0,0,ACCESS
	bcf	INTCON0,GIE,ACCESS
	btfsc	SYSINTSTATESAVE0,0,ACCESS
	bsf	INTCON0,GIE,ACCESS
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;END
	bra	BASPROGRAMEND
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: system.h (203)
INITSYS
;Clear BSR on ChipFamily16 MCUs
;MOVLB 0
	movlb	0
;Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	movlw	96
	movwf	OSCCON1,BANKED
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	clrf	OSCCON3,BANKED
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	clrf	OSCEN,BANKED
;Default value
;OSCTUNE = 0x00
	clrf	OSCTUNE,BANKED
;The MCU is a chip family 16
;Section supports many MCUs, 18FxxK40, 18FxxK42 etc that have NDIV3 bit
;OSCCON type is 101
;OSCCON1 = 0x60          // Setting OSCCON1 implies clearing Clear NDIV3:0
	movlw	96
	movwf	OSCCON1,BANKED
;OSCFRQ = 0b00001000  '64mhz
	movlw	8
	movwf	OSCFRQ,BANKED
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,BANKED
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;ANSELE = 0
	clrf	ANSELE,BANKED
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2EN,BANKED
;C1EN = 0
	bcf	CM1CON0,C1EN,BANKED
;Turn off all ports
;PORTA = 0
	banksel	PORTA
	clrf	PORTA,BANKED
;PORTB = 0
	clrf	PORTB,BANKED
;PORTC = 0
	clrf	PORTC,BANKED
;PORTD = 0
	clrf	PORTD,BANKED
;PORTE = 0
	clrf	PORTE,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:BYTE:, Source: timer.h (1566)
INITTIMER0205
;Equate to      T0CON1 7:5      3:0        T0CON0 3:0
;Assumed for code below Timer0 is 16-bit capable as we have been passed three parameters
;Set prescaler
;T0CON1 Sets up  CLK Source (7:5)  Sync (4) & Prescale 3:0
;T0CON1 POR Val = b'00000000'
;Re-Use TMRPres as T0CON1 Temp register
;Keep T0CON1 7:4 and write bits 3:0 to  register
;Bits therefore will be cleared!
;TMRPres = (T0CON1 And 240 ) OR TMRPres
	movlw	240
	banksel	T0CON1
	andwf	T0CON1,W,BANKED
	movwf	SysTemp2,ACCESS
	iorwf	TMRPRES,F,ACCESS
;Set the Source bit
;IF TMRSource <> OSC  THEN
	decf	TMRSOURCE,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ELSE4_1
;SET TMRPost.5 ON
	bsf	TMRPOST,5,ACCESS
;ELSE
	bra	ENDIF4
ELSE4_1
;SET TMRPost.5 OFF
	bcf	TMRPOST,5,ACCESS
;END IF
ENDIF4
;Write the TOCON register
;T0CON1 = TMRPres
	movff	TMRPRES,T0CON1
;Assumed for code below Timer0 is 16-bit capable
;Set Postscaler
;Re-Use TMRPost as T0CON0 Temp register
;Keep T0CON0 7:5  and write bits 5:0 to register
;Bits therefore will be cleared!
;TMRPost = (T0CON0 And 224) OR TMRPost
	movlw	224
	andwf	T0CON0,W,BANKED
	movwf	SysTemp2,ACCESS
	iorwf	TMRPOST,F,ACCESS
;Set TO16BIT
;Set TMRPost.4 OFF '8-bit Timer0
	bcf	TMRPOST,4,ACCESS
;Write the TOCON register
;T0CON0 = TMRPost
	movff	TMRPOST,T0CON0
	banksel	0
	return

;********************************************************************************

;Source: millis.h (270)
INIT_MSCTR_INT
;Add the handler for the interrupt
;On Interrupt Timer0Overflow Call MsCtr_Int_Hdlr
	bsf	PIE8,TMR0IE,ACCESS
;MsCtr_ = 0
	clrf	MSCTR_,ACCESS
	clrf	MSCTR__H,ACCESS
	clrf	MSCTR__U,ACCESS
	clrf	MSCTR__E,ACCESS
;Millis = 0
	rcall	FN_MILLIS
;16bit capable, but running in 8bit mode
;InitTimer0 Osc, PRE0_64 + TMR0_FOSC4 ,  POST0_1
	movlw	1
	movwf	TMRSOURCE,ACCESS
	movlw	70
	movwf	TMRPRES,ACCESS
	clrf	TMRPOST,ACCESS
	rcall	INITTIMER0205
;Call_SetTimer_Millis_macro
;SetTimer_Millis SCRIPT_TMR0INITVAL  + MILLIS_TIMER_VALUE_ADJUST   ' Reset Inital Counter value
;Macro Source: millis.h (523)
;Handle chips with TMR0H
;USe default 8-bit mode
;TMR0L = TMRValueMillis
	movlw	6
	banksel	TMR0L
	movwf	TMR0L,BANKED
;Call_StartTimer_Millis_macro
;StartTimer_Millis
;Macro Source: millis.h (563)
;Set T0EN on
	bsf	T0CON0,T0EN,BANKED
	banksel	0
	return

;********************************************************************************

INTERRUPT
;Use Automatic Context Save for K42 and K83 with MVECEN = OFF.  Interrupt priority not supported
;Store system variables
;On Interrupt handlers
	btfss	PIE8,TMR0IE,ACCESS
	bra	NotTMR0IF
	btfss	PIR8,TMR0IF,ACCESS
	bra	NotTMR0IF
	rcall	MSCTR_INT_HDLR
	bcf	PIR8,TMR0IF,ACCESS
	bra	INTERRUPTDONE
NotTMR0IF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	retfie	1

;********************************************************************************

;Source: millis.h (513)
FN_MILLIS
;dim Millis, MsCtr_ as long
;disable interrupts while we read millis or we might get an
;inconsistent value (e.g. in the middle of a write to millis)
;IntOff
	bcf	SYSINTSTATESAVE0,1,ACCESS
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSINTSTATESAVE0,1,ACCESS
	bcf	INTCON0,GIE,ACCESS
;Millis = MsCtr_
	movff	MSCTR_,MILLIS
	movff	MSCTR__H,MILLIS_H
	movff	MSCTR__U,MILLIS_U
	movff	MSCTR__E,MILLIS_E
;IntOn
	btfss	SYSINTSTATESAVE0,1,ACCESS
	bcf	INTCON0,GIE,ACCESS
	btfsc	SYSINTSTATESAVE0,1,ACCESS
	bsf	INTCON0,GIE,ACCESS
	return

;********************************************************************************

;Source: millis.h (255)
MSCTR_INT_HDLR
;dim MsCtr_ as Long
;Call_SetTimer_Millis_macro
;SetTimer_Millis  SCRIPT_TMR0INITVAL + MILLIS_TIMER_VALUE_ADJUST   ' Reset Inital Counter value
;Macro Source: millis.h (523)
;Handle chips with TMR0H
;USe default 8-bit mode
;TMR0L = TMRValueMillis
	movlw	6
	banksel	TMR0L
	movwf	TMR0L,BANKED
;MsCtr_ = MsCtr_ + 1
	incf	MSCTR_,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	MSCTR__H,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	MSCTR__U,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	MSCTR__E,F,ACCESS
	banksel	0
	return

;********************************************************************************

;Source: system.h (4533)
SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W,ACCESS
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W,ACCESS
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W,ACCESS
;bnc SCLT16True
	bnc	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W,ACCESS
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************


 END
