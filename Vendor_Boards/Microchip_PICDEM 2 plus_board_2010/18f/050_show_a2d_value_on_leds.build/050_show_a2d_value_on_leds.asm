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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\050_show_a2d_value_on_leds.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\050_show_a2d_value_on_leds.build\050_show_a2d_value_on_leds.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\050_show_a2d_value_on_leds.gcb"
 SUBTITLE    "08-07-2026 09:25:10"
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
 CONFIG  MCLRE = INTMCLR
 CONFIG  FCMEN = ON
 CONFIG  CLKOUTEN = OFF
 CONFIG  RSTOSC = HFINTOSC_1MHZ
 CONFIG  FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
ADCVAL                           EQU    1284          ; 0x504 (SA)
ADREADPORT                       EQU    1286          ; 0x506 (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
READAD                           EQU    1287          ; 0x507 (SA)
SYSBYTETEMPA                     EQU    1285          ; 0x505 (SA)
SYSBYTETEMPB                     EQU    1289          ; 0x509 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSTEMP1                         EQU    1288          ; 0x508 (SA)
SYSTEMP2                         EQU    1290          ; 0x50A (SA)
SYSWAITTEMP10US                  EQU    1285          ; 0x505 (SA)
SYSWAITTEMPMS                    EQU    1282          ; 0x502 (SA)
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503 (SA)

;********************************************************************************

;Alias variables
SYSREADADBYTE EQU 1287

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
;
;A demonstration program for GCBASIC
;--------------------------------------------------------------------------------
;This shows how to read the A2D converter and display the a proportioanal value on the LEDs.
;The pot on the board varies the voltage coming in on the microcontroller.
;
;Rotate the POT to see the LEDs change.
;
;The A2D is referenced to the same Vdd as the device, which
;is nominally is 5V.  The A2D returns the ratio of the voltage
;on Pin RA0 to 5V.  The A2D has a resolution of 8 bits, with 255
;representing 5V and 0 representing 0V.
;
;
;Rotate the potentiometer to change the LEDs displayed.
;
;------------------------------------------------------------------------
;IMPORTANT - Power configuration
;------------------------------------------------------------------------
;!! VDDIO2 IS CRITICAL FOR OPERATION !!
;On this device family, VDDIO2 supplies power to a secondary I/O bank.
;If VDDIO2 is not correctly connected to the supply rail (per the
;datasheet electrical and pin-out specifications), the associated I/O
;pins will not function correctly, and the chip may not operate
;reliably even though the primary VDD/VSS pins are powered correctly.
;Always verify VDDIO2 is wired to VDD (or the correct supply level) on
;your board before troubleshooting "dead" I/O or unexpected resets.
;------------------------------------------------------------------------
;
;
;@author 	EvanV
;@licence	GPL
;@version	1.0a
;@date   	01.08.2026
;*******************************************************************************
;Set microcontroller required
;
;------------PORTA---------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ----------------------------ADC--
;IO:    ---------------------------------
;
;------------PORTB----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ----------------LED-LED-LED-LED--
;IO:    ---------------------------------
;
;------------PORTC----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ---------------------------------
;IO:    ---------------------------------
;
;------------PORTD----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ---------------------------------
;IO:    ---------------------------------
;
;Define constants to make things easier. We can reuse a constant at any time.
;#OPTION Volatile LEDD3
;Dir     LEDD0 Out
	banksel	TRISB
	bcf	TRISB,0,BANKED
;Dir     LEDD1 Out
	bcf	TRISB,1,BANKED
;Dir     LEDD2 Out
	bcf	TRISB,2,BANKED
;Dir     LEDD3 Out
	bcf	TRISB,3,BANKED
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim adcVal As Byte
;Do
SysDoLoop_S1
;adcVal =  ReadAD ( ANA0 )
	clrf	ADREADPORT,ACCESS
	banksel	0
	rcall	FN_READAD5
	movff	SYSREADADBYTE,ADCVAL
;One method
;Select Case adcVal
;Case 0 to 49
;LEDD0 = 0
;LEDD1 = 0
;LEDD2 = 0
;LEDD3 = 0
;Case 50 to 99
;LEDD0 = 1
;LEDD1 = 0
;LEDD2 = 0
;LEDD3 = 0
;Case 100 to 149
;LEDD0 = 1
;LEDD1 = 1
;LEDD2 = 0
;LEDD3 = 0
;Case 150 to 200
;LEDD0 = 1
;LEDD1 = 1
;LEDD2 = 1
;LEDD3 = 0
;Case Else
;LEDD0 = 1
;LEDD1 = 1
;LEDD2 = 1
;LEDD3 = 1
;End Select
;Or, another way
;Another method
;If adcVal < 50 then
	movlw	50
	subwf	ADCVAL,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ELSE1_1
;LEDD0 = 0
	banksel	LATB
	bcf	LATB,0,BANKED
;LEDD1 = 0
	bcf	LATB,1,BANKED
;LEDD2 = 0
	bcf	LATB,2,BANKED
;LEDD3 = 0
	bcf	LATB,3,BANKED
;else if adcVal > 49 and adcVal < 100 then
	bra	ENDIF1
ELSE1_1
	movff	ADCVAL,SysBYTETempB
	movlw	49
	movwf	SysBYTETempA,ACCESS
	rcall	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp1
	movff	ADCVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ELSE1_2
;LEDD0 = 1
	banksel	LATB
	bsf	LATB,0,BANKED
;LEDD1 = 0
	bcf	LATB,1,BANKED
;LEDD2 = 0
	bcf	LATB,2,BANKED
;LEDD3 = 0
	bcf	LATB,3,BANKED
;else if adcVal > 99 and adcVal < 150 then
	bra	ENDIF1
ELSE1_2
	movff	ADCVAL,SysBYTETempB
	movlw	99
	movwf	SysBYTETempA,ACCESS
	rcall	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp1
	movff	ADCVAL,SysBYTETempA
	movlw	150
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ELSE1_3
;LEDD0 = 1
	banksel	LATB
	bsf	LATB,0,BANKED
;LEDD1 = 1
	bsf	LATB,1,BANKED
;LEDD2 = 0
	bcf	LATB,2,BANKED
;LEDD3 = 0
	bcf	LATB,3,BANKED
;else if adcVal > 149 and adcVal < 200 then
	bra	ENDIF1
ELSE1_3
	movff	ADCVAL,SysBYTETempB
	movlw	149
	movwf	SysBYTETempA,ACCESS
	rcall	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp1
	movff	ADCVAL,SysBYTETempA
	movlw	200
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ELSE1_4
;LEDD0 = 1
	banksel	LATB
	bsf	LATB,0,BANKED
;LEDD1 = 1
	bsf	LATB,1,BANKED
;LEDD2 = 1
	bsf	LATB,2,BANKED
;LEDD3 = 0
	bcf	LATB,3,BANKED
;else if adcVal > 200 then
	bra	ENDIF1
ELSE1_4
	movf	ADCVAL,W,ACCESS
	sublw	200
	btfsc	STATUS, C,ACCESS
	bra	ENDIF1
;LEDD0 = 1
	banksel	LATB
	bsf	LATB,0,BANKED
;LEDD1 = 1
	bsf	LATB,1,BANKED
;LEDD2 = 1
	bsf	LATB,2,BANKED
;LEDD3 = 1
	bsf	LATB,3,BANKED
;End if
ENDIF1
;wait 100 ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	banksel	0
	rcall	Delay_MS
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;GCBASIC Optimisation file - this will optimise ADC operations by disabling the ADC operations on the AD channel that is set to FALSE
;to enable ADC operations on a specific AD channel set to TRUE
;
;Legacy chip Constants for ADC
;
;Recent chip Constants for ADC
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

Delay_10US
D10US_START
	movlw	52
	movwf	DELAYTEMP,ACCESS
DelayUS0
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	decfsz	SysWaitTemp10US, F,ACCESS
	bra	D10US_START
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	129
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	40
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

;Source: system.h (201)
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

;Overloaded signature: BYTE:, Source: a-d.h (2170)
FN_READAD5
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	movff	ADREADPORT,ADPCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (637)
;Configure ANSELA/B/C/D @DebugADC_H
;Select Case ADReadPort
;Case 0: Set ANSELA.0 On
SysSelect1Case1
	movf	ADREADPORT,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
;Case 0: Set ANSELA.0 On
	banksel	ANSELA
	bsf	ANSELA,0,BANKED
;End Select  '*** ANSEL Bits should now be set ***
SysSelectEnd1
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
	banksel	ADCON0
	bcf	ADCON0,ADCS,BANKED
;ADCLK = 1 ' default to FOSC/2
	movlw	1
	movwf	ADCLK,BANKED
;Conversion Clock Speed
;SET ADCS OFF  'ADCON0.4
	bcf	ADCON0,ADCS,BANKED
;ADCLK = 15    'FOSC/16
	movlw	15
	movwf	ADCLK,BANKED
;Configure AD clock defaults fpr older 18F that do not have ADCLK
;SET ADCS2 OFF
	bcf	ADCLK,ADCS2,BANKED
;SET ADCS1 OFF
	bcf	ADCLK,ADCS1,BANKED
;SET ADCS0 ON
	bsf	ADCLK,ADCS0,BANKED
;Result formatting
;if ADLeftadjust = 0 then
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
	bcf	ADCON0,ADFM0,BANKED
;Set ADFM0 OFF
	bcf	ADCON0,ADFM0,BANKED
;End if
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	movff	ADREADPORT,ADPCH
;Enable AD Operations
;SET ADON ON
	bsf	ADCON0,ADON,BANKED
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US,ACCESS
	banksel	0
	rcall	Delay_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE,BANKED
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop1
	btfsc	ADCON0,GO_NOT_DONE,BANKED
	bra	SysWaitLoop1
;Switch off A/D
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
;ReadAD = ADRESH
	movff	ADRESH,READAD
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
	banksel	0
	return

;********************************************************************************

;Source: system.h (4501)
SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfslt SysByteTempA
	cpfslt	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************


 END
