;Program compiled by GCBASIC (2024.2.7 (Windows 64 bit) : Build 1332) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2024-02-09 CRC247
;Need help? 
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   w_cholmondeley at users dot sourceforge dot net
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Source file    : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\18Fx6q20_ChipRange_Demonstrations\040_rotate_the_leds.gcb
;   Setting file   : C:\GCstudio\gcbasic\use.ini
;   Preserve mode  : 0
;   Assembler      : GCASM
;   Programmer     : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file    : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\18Fx6q20_ChipRange_Demonstrations\040_rotate_the_leds.asm
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
DELAYTEMP                        EQU    1280          ; 0x500
DELAYTEMP2                       EQU    1281          ; 0x501
SYSWAITTEMPMS                    EQU    1282          ; 0x502
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503
SYSWAITTEMPS                     EQU    1284          ; 0x504

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	retfie

;********************************************************************************

;Program_memory_page: 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	rcall	INITSYS

;Start_of_the_main_program
	bcf	TRISC,7,ACCESS
	bcf	TRISC,6,ACCESS
	bcf	TRISC,5,ACCESS
	bcf	TRISC,4,ACCESS
	bsf	LATC,4,ACCESS
SysDoLoop_S1
	movlw	1
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
	bcf	STATUS,C,ACCESS
	rlcf	LATC,F,ACCESS
	btfsc	STATUS,C,ACCESS
	bsf	LATC,4,ACCESS
	bra	SysDoLoop_S1
SysDoLoop_E1
	bra	BASPROGRAMEND
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	4
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	165
	movwf	DELAYTEMP,ACCESS
DMS_INNER
	decfsz	DELAYTEMP, F,ACCESS
	bra	DMS_INNER
	decfsz	DELAYTEMP2, F,ACCESS
	bra	DMS_OUTER
	decfsz	SysWaitTempMS, F,ACCESS
	bra	DMS_START
	decfsz	SysWaitTempMS_H, F,ACCESS
	bra	DMS_START
	return

;********************************************************************************

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	decfsz	SysWaitTempS, F,ACCESS
	bra	DS_START
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
	movlw	3
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


 END
