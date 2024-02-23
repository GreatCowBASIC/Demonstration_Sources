;Program compiled by GCBASIC (2024.2.7 (Windows 64 bit) : Build 1332) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2024-02-09 CRC247
;Need help? 
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   w_cholmondeley at users dot sourceforge dot net
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Source file    : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\18Fx6q20_ChipRange_Demonstrations\110_rotate_the_leds_using_the_timer_overflow_event.gcb
;   Setting file   : C:\GCstudio\gcbasic\use.ini
;   Preserve mode  : 0
;   Assembler      : GCASM
;   Programmer     : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file    : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\18Fx6q20_ChipRange_Demonstrations\110_rotate_the_leds_using_the_timer_overflow_event.asm
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F16Q20, r=DEC
#include <P18F16Q20.inc>
 CONFIG  CPD = OFF
 CONFIG  CP = OFF
 CONFIG  WRTSAF = OFF
 CONFIG  WRTD = OFF
 CONFIG  WRTB = OFF
 CONFIG  VDDIO2MD = STANDARD_RANGE
 CONFIG  WDTE = OFF
 CONFIG  XINST = OFF
 CONFIG  LVP = OFF
 CONFIG  MVECEN = OFF
 CONFIG  MCLRE = INTMCLR
 CONFIG  FCMEN = ON
 CONFIG  CLKOUTEN = OFF
 CONFIG  RSTOSC = HFINTOSC_1MHZ
 CONFIG  FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
SYSBSR                           EQU    1280          ; 0x500
SYSSTATUS                        EQU    1295          ; 0x50F
SYSTEMP1                         EQU    1281          ; 0x501
SYSW                             EQU    1294          ; 0x50E
TIMEOUT                          EQU    1282          ; 0x502
TMRNUMBER                        EQU    1283          ; 0x503
TMRPOST                          EQU    1284          ; 0x504
TMRPRES                          EQU    1285          ; 0x505
TMRSOURCE                        EQU    1286          ; 0x506
TMRVALUE                         EQU    1287          ; 0x507
TMRVALUE_H                       EQU    1288          ; 0x508

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
;Enable interrupts
	bsf	INTCON0,GIE,ACCESS

;Start_of_the_main_program
	bcf	TRISC,7,ACCESS
	bcf	TRISC,6,ACCESS
	bcf	TRISC,5,ACCESS
	bcf	TRISC,4,ACCESS
	bsf	TRISA,0,ACCESS
	bsf	TRISA,3,ACCESS
	movlw	1
	movwf	TMRSOURCE,ACCESS
	movlw	70
	movwf	TMRPRES,ACCESS
	clrf	TMRPOST,ACCESS
	rcall	INITTIMER0184
	clrf	TMRNUMBER,ACCESS
	movlw	220
	movwf	TMRVALUE,ACCESS
	movlw	11
	movwf	TMRVALUE_H,ACCESS
	rcall	SETTIMER182
	bsf	PIE3,TMR0IE,ACCESS
	clrf	TMRNUMBER,ACCESS
	rcall	STARTTIMER
	bsf	LATC,4,ACCESS
SysDoLoop_S1
	decf	TIMEOUT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF1
	bcf	STATUS,C,ACCESS
	rlcf	LATC,F,ACCESS
	btfsc	STATUS,C,ACCESS
	bsf	LATC,4,ACCESS
	clrf	TIMEOUT,ACCESS
	clrf	TMRNUMBER,ACCESS
	movlw	220
	movwf	TMRVALUE,ACCESS
	movlw	11
	movwf	TMRVALUE_H,ACCESS
	rcall	SETTIMER182
ENDIF1
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

BLINK
	movlw	1
	movwf	TIMEOUT,ACCESS
	bcf	PIR3,TMR0IF,ACCESS
	return

;********************************************************************************

INITSYS
	movlb	0
;asm showdebug Default settings for microcontrollers with _OSCCON1_
	movlw	96
	movwf	OSCCON1,BANKED
	clrf	OSCCON3,BANKED
	clrf	OSCEN,BANKED
	clrf	OSCTUNE,BANKED
;asm showdebug The MCU is a chip family 16
;asm showdebug OSCCON type is 101
	movlw	96
	movwf	OSCCON1,BANKED
	movlw	5
	movwf	OSCFRQ,BANKED
;asm showdebug _Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
	clrf	TBLPTRU,ACCESS
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
	bcf	ADCON0,ADON,BANKED
	banksel	ANSELA
	clrf	ANSELA,BANKED
	clrf	ANSELB,BANKED
	clrf	ANSELC,BANKED
	clrf	PORTA,ACCESS
	clrf	PORTB,ACCESS
	clrf	PORTC,ACCESS
	banksel	0
	return

;********************************************************************************

INITTIMER0184
	movlw	240
	banksel	T0CON1
	andwf	T0CON1,W,BANKED
	movwf	SysTemp1,ACCESS
	iorwf	TMRPRES,F,ACCESS
	decf	TMRSOURCE,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ELSE11_1
	bsf	TMRPOST,5,ACCESS
	bra	ENDIF11
ELSE11_1
	bcf	TMRPOST,5,ACCESS
ENDIF11
	movff	TMRPRES,T0CON1
	movlw	224
	andwf	T0CON0,W,BANKED
	movwf	SysTemp1,ACCESS
	iorwf	TMRPOST,F,ACCESS
	bsf	TMRPOST,4,ACCESS
	movff	TMRPOST,T0CON0
	banksel	0
	return

;********************************************************************************

INTERRUPT
;Use Automatic Context Save for K42 and K83 with MVECEN = OFF.  Interrupt priority not supported
;Store system variables
;On Interrupt handlers
	btfss	PIE3,TMR0IE,ACCESS
	bra	NotTMR0IF
	btfss	PIR3,TMR0IF,ACCESS
	bra	NotTMR0IF
	rcall	BLINK
	bcf	PIR3,TMR0IF,ACCESS
	bra	INTERRUPTDONE
NotTMR0IF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	retfie	1

;********************************************************************************

SETTIMER182
	movf	TMRNUMBER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF7
	movff	TMRVALUE_H,TMR0H
	movff	TMRVALUE,TMR0L
	return
ENDIF7
	decf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF8
	movff	TMRVALUE_H,TMR1H
	movff	TMRVALUE,TMR1L
ENDIF8
	movlw	2
	subwf	TMRNUMBER,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	movff	TMRVALUE,TMR2
	movlw	4
	subwf	TMRNUMBER,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	movff	TMRVALUE,TMR4
	return

;********************************************************************************

STARTTIMER
	movf	TMRNUMBER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF3
	banksel	T0CON0
	bsf	T0CON0,T0EN,BANKED
ENDIF3
	decf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF4
	banksel	T1CON
	bsf	T1CON,TMR1ON,BANKED
ENDIF4
	movlw	2
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF5
	banksel	T2CON
	bsf	T2CON,TMR2ON,BANKED
ENDIF5
	movlw	4
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF6
	banksel	T4CON
	bsf	T4CON,TMR4ON,BANKED
ENDIF6
	banksel	0
	return

;********************************************************************************


 END
