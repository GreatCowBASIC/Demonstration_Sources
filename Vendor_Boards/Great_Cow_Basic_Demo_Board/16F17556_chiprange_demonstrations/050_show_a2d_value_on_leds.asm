;Program compiled by GCBASIC (2025.11.16 (Windows 64 bit) : Build 1530) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2025-11-17 CRC248
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17556_chiprange_demonstrations\050_show_a2d_value_on_leds.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 0
;   Assembler        : GCASM
;   Programmer       : 
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17556_chiprange_demonstrations\050_show_a2d_value_on_leds.asm
;   Float Capability : 0
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F17556, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17556_chiprange_demonstrations\050_show_a2d_value_on_leds.gcb"
 SUBTITLE    "11-17-2025 15:00:54"
#include <P16F17556.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _RSTOSC_HFINTOSC_32MHZ & _FEXTOSC_OFF
 __CONFIG _CONFIG2, _MCLRE_INTMCLR
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF & _WRTSAF_OFF & _WRTD_OFF & _WRTB_OFF
 __CONFIG _CONFIG5, _CPD_OFF & _CP_OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
ADCVAL                           EQU      32          ; 0x20
ADREADPORT                       EQU      33          ; 0x21
DELAYTEMP                        EQU     112          ; 0x70 (SA)
DELAYTEMP2                       EQU     113          ; 0x71 (SA)
READAD                           EQU      34          ; 0x22
SYSWAITTEMP10US                  EQU     117          ; 0x75 (SA)
SYSWAITTEMPMS                    EQU     114          ; 0x72 (SA)
SYSWAITTEMPMS_H                  EQU     115          ; 0x73 (SA)

;********************************************************************************

;Alias variables
SYSREADADBYTE EQU 34

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

;Start_of_the_main_program
	bcf	TRISC,0
	bcf	TRISC,1
	bcf	TRISC,2
	bcf	TRISC,3
	bsf	TRISA,0
SysDoLoop_S1
	clrf	ADREADPORT
	call	FN_READAD5
	movf	SYSREADADBYTE,W
	movwf	ADCVAL
SysSelect1Case1
	movlw	0
	subwf	ADCVAL,W
	btfss	STATUS, C
	goto	SysSelect1Case2
	movf	ADCVAL,W
	sublw	49
	btfss	STATUS, C
	goto	SysSelect1Case2
	bcf	LATC,RC0
	bcf	LATC,RC1
	bcf	LATC,RC2
	bcf	LATC,RC3
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	50
	subwf	ADCVAL,W
	btfss	STATUS, C
	goto	SysSelect1Case3
	movf	ADCVAL,W
	sublw	99
	btfss	STATUS, C
	goto	SysSelect1Case3
	bsf	LATC,RC0
	bcf	LATC,RC1
	bcf	LATC,RC2
	bcf	LATC,RC3
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	100
	subwf	ADCVAL,W
	btfss	STATUS, C
	goto	SysSelect1Case4
	movf	ADCVAL,W
	sublw	149
	btfss	STATUS, C
	goto	SysSelect1Case4
	bsf	LATC,RC0
	bsf	LATC,RC1
	bcf	LATC,RC2
	bcf	LATC,RC3
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	150
	subwf	ADCVAL,W
	btfss	STATUS, C
	goto	SysSelect1Case5
	movf	ADCVAL,W
	sublw	200
	btfss	STATUS, C
	goto	SysSelect1Case5
	bsf	LATC,RC0
	bsf	LATC,RC1
	bsf	LATC,RC2
	bcf	LATC,RC3
	goto	SysSelectEnd1
SysSelect1Case5
	bsf	LATC,RC0
	bsf	LATC,RC1
	bsf	LATC,RC2
	bsf	LATC,RC3
SysSelectEnd1
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	goto	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

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

INITSYS
;Default settings for microcontrollers with _OSCCON1_
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1
	clrf	OSCCON3
	clrf	OSCEN
	clrf	OSCTUNE
;The MCU is a chip family ChipFamily
;OSCCON type is 102
	movlw	6
	movwf	OSCFRQ
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
	banksel	ADCON0
	bcf	ADCON0,ADFM0
	bcf	ADCON0,ADON
	banksel	ANSELA
	clrf	ANSELA
	clrf	ANSELB
	clrf	ANSELC
	banksel	CM1CON0
	bcf	CM1CON0,C1EN
	banksel	PORTA
	clrf	PORTA
	clrf	PORTB
	clrf	PORTC
	clrf	PORTE
	return

;********************************************************************************

FN_READAD5
	banksel	ADCON0
	bcf	ADCON0,ADFM0
	banksel	ADREADPORT
	movf	ADREADPORT,W
	banksel	ADPCH
	movwf	ADPCH
	bcf	ADCON0,ADIC
	clrf	ADNCH
SysSelect2Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect2Case2
	banksel	ANSELA
	bsf	ANSELA,0
	goto	SysSelectEnd2
SysSelect2Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
	banksel	ANSELA
	bsf	ANSELA,1
	goto	SysSelectEnd2
SysSelect2Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case4
	banksel	ANSELA
	bsf	ANSELA,2
	goto	SysSelectEnd2
SysSelect2Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case5
	banksel	ANSELA
	bsf	ANSELA,3
	goto	SysSelectEnd2
SysSelect2Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case6
	banksel	ANSELA
	bsf	ANSELA,4
	goto	SysSelectEnd2
SysSelect2Case6
	movlw	5
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case7
	banksel	ANSELA
	bsf	ANSELA,5
	goto	SysSelectEnd2
SysSelect2Case7
	movlw	6
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case8
	banksel	ANSELA
	bsf	ANSELA,6
	goto	SysSelectEnd2
SysSelect2Case8
	movlw	7
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case9
	banksel	ANSELA
	bsf	ANSELA,7
	goto	SysSelectEnd2
SysSelect2Case9
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case10
	banksel	ANSELB
	bsf	ANSELB,0
	goto	SysSelectEnd2
SysSelect2Case10
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case11
	banksel	ANSELB
	bsf	ANSELB,1
	goto	SysSelectEnd2
SysSelect2Case11
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case12
	banksel	ANSELB
	bsf	ANSELB,2
	goto	SysSelectEnd2
SysSelect2Case12
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case13
	banksel	ANSELB
	bsf	ANSELB,3
	goto	SysSelectEnd2
SysSelect2Case13
	movlw	12
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case14
	banksel	ANSELB
	bsf	ANSELB,4
	goto	SysSelectEnd2
SysSelect2Case14
	movlw	13
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case15
	banksel	ANSELB
	bsf	ANSELB,5
	goto	SysSelectEnd2
SysSelect2Case15
	movlw	14
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case16
	banksel	ANSELB
	bsf	ANSELB,6
	goto	SysSelectEnd2
SysSelect2Case16
	movlw	15
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case17
	banksel	ANSELB
	bsf	ANSELB,7
	goto	SysSelectEnd2
SysSelect2Case17
	movlw	16
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case18
	banksel	ANSELC
	bsf	ANSELC,0
	goto	SysSelectEnd2
SysSelect2Case18
	movlw	17
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case19
	banksel	ANSELC
	bsf	ANSELC,1
	goto	SysSelectEnd2
SysSelect2Case19
	movlw	18
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case20
	banksel	ANSELC
	bsf	ANSELC,2
	goto	SysSelectEnd2
SysSelect2Case20
	movlw	19
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case21
	banksel	ANSELC
	bsf	ANSELC,3
	goto	SysSelectEnd2
SysSelect2Case21
	movlw	20
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case22
	banksel	ANSELC
	bsf	ANSELC,4
	goto	SysSelectEnd2
SysSelect2Case22
	movlw	21
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case23
	banksel	ANSELC
	bsf	ANSELC,5
	goto	SysSelectEnd2
SysSelect2Case23
	movlw	22
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case24
	banksel	ANSELC
	bsf	ANSELC,6
	goto	SysSelectEnd2
SysSelect2Case24
	movlw	23
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd2
	banksel	ANSELC
	bsf	ANSELC,7
SysSelectEnd2
	movlw	1
	banksel	ADCLK
	movwf	ADCLK
	movlw	15
	movwf	ADCLK
	bcf	ADCON0,ADFM0
	bcf	ADCON0,ADFM0
	banksel	ADREADPORT
	movf	ADREADPORT,W
	banksel	ADPCH
	movwf	ADPCH
	bsf	ADCON0,ADON
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	call	Delay_10US
	banksel	ADCON0
	bsf	ADCON0,ADGO
	nop
SysWaitLoop1
	btfsc	ADCON0,ADGO
	goto	SysWaitLoop1
	bcf	ADCON0,ADON
	banksel	ANSELA
	clrf	ANSELA
	clrf	ANSELB
	clrf	ANSELC
	banksel	ADRESH
	movf	ADRESH,W
	banksel	READAD
	movwf	READAD
	banksel	ADCON0
	bcf	ADCON0,ADFM0
	banksel	STATUS
	return

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
