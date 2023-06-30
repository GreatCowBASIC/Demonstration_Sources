;Program compiled by GCBASIC (1.00.00 Release Candidate 2022-11-06 (Windows 64 bit) : Build 1189) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F17126
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17126_chiprange_demonstrations\050_show_a2d_value_on_leds.s"
 SUBTITLE    "11-14-2022"

; Reverse lookup file(s)
; C:\Program Files\Microchip\xc8\v2.40\pic\include\proc\pic16f17126.inc
; C:\Program Files\Microchip\xc8\v2.40\pic\dat\cfgmap\16f17126.cfgmap
; Alternative CONFIG file is to be found at C:\Program Files\Microchip\xc8\vX.YY\pic\dat\cfgdata as per Microchip support ticket #00730936 

;********************************************************************************

;********************************************************************************
;Explicit CONFIG
 CONFIG FCMEN=ON                                 ;C1 Reverselookup FCMEN = ON
 CONFIG CLKOUTEN=OFF                             ;C1 Reverselookup CLKOUTEN = OFF
 CONFIG RSTOSC=HFINTOSC_32MHz                    ;C1 Reverselookup RSTOSC = HFINTOSC_32MHZ
 CONFIG FEXTOSC=OFF                              ;C1 Reverselookup FEXTOSC = OFF
 CONFIG MCLRE=INTMCLR                            ;C1 Reverselookup MCLRE = INTMCLR
 CONFIG WDTE=OFF                                 ;C1 Reverselookup WDTE = OFF
 CONFIG LVP=OFF                                  ;C1 Reverselookup LVP = OFF
 CONFIG WRTSAF=OFF                               ;C1 Reverselookup WRTSAF = OFF
 CONFIG WRTD=OFF                                 ;C1 Reverselookup WRTD = OFF
 CONFIG WRTB=OFF                                 ;C1 Reverselookup WRTB = OFF
 CONFIG CPD=OFF                                  ;C1 Reverselookup CPD = OFF
 CONFIG CP=OFF                                   ;C1 Reverselookup CP = OFF
;Inferred CONFIG


;********************************************************************************
; The XC8 xc.inc include file.  This MUST be placed after the CONFIG statements.

 #include <xc.inc>

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
GLOBAL	ADCVAL
 ADCVAL                           EQU 32          ; 0X20
GLOBAL	ADREADPORT
 ADREADPORT                       EQU 33          ; 0X21
GLOBAL	ANSELB
 ANSELB                           EQU 34          ; 0X22
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 112          ; 0X70
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 113          ; 0X71
GLOBAL	READAD
 READAD                           EQU 35          ; 0X23
GLOBAL	SYSWAITTEMP10US
 SYSWAITTEMP10US                  EQU 117          ; 0X75
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73

;********************************************************************************

;ALIAS VARIABLES
GLOBAL	SYSREADADBYTE
 SYSREADADBYTE                    EQU 35

;********************************************************************************

 PSECT   PROGMEM0,delta=2, abs
 RESETVEC:
;VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	GOTO	BASPROGRAMSTART
	ORG	4
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	5
GLOBAL	BASPROGRAMSTART
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS

;START OF THE MAIN PROGRAM
;
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
;************************************************************************
;@author  EvanV
;@licence GPL
;@version 1.00
;@date    31.10.2022
;
;----- Configuration
;Chip Settings.
;-------------------PORTA----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:   -----------------------------ADC--
;-----------------------------------------
;-------------------PORTB----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ---------------------------------
;-----------------------------------------
;------------------PORTC-----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ---------------LED--LED-LED-LED--
;-----------------------------------------
;Define constants to make things easier. We can reuse these at any time.
;Dir     RC0         Out
	BCF	TRISC,0
;Dir     RC1         Out
	BCF	TRISC,1
;Dir     RC2         Out
	BCF	TRISC,2
;Dir     RC3         Out
	BCF	TRISC,3
;This is the PORTA.0 port
;Dir     POTENTIOMETER In
	BSF	TRISA,0
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim adcVal As Byte
;Do
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;adcVal =  ReadAD ( ANA0 )
	CLRF	ADREADPORT
	CALL	FN_READAD4
	MOVF	SYSREADADBYTE,W
	MOVWF	ADCVAL
;Select Case adcVal
;Case 0 to 49
GLOBAL	SYSSELECT1CASE1
SYSSELECT1CASE1:
	MOVLW	0
	SUBWF	ADCVAL,W
	BTFSS	STATUS,0
	GOTO	SYSSELECT1CASE2
	MOVF	ADCVAL,W
	SUBLW	49
	BTFSS	STATUS,0
	GOTO	SYSSELECT1CASE2
;RC0 = 0
	BCF	LATC,0
;RC1 = 0
	BCF	LATC,1
;RC2 = 0
	BCF	LATC,2
;RC3 = 0
	BCF	LATC,3
;Case 50 to 99
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE2
SYSSELECT1CASE2:
	MOVLW	50
	SUBWF	ADCVAL,W
	BTFSS	STATUS,0
	GOTO	SYSSELECT1CASE3
	MOVF	ADCVAL,W
	SUBLW	99
	BTFSS	STATUS,0
	GOTO	SYSSELECT1CASE3
;RC0 = 1
	BSF	LATC,0
;RC1 = 0
	BCF	LATC,1
;RC2 = 0
	BCF	LATC,2
;RC3 = 0
	BCF	LATC,3
;Case 100 to 149
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE3
SYSSELECT1CASE3:
	MOVLW	100
	SUBWF	ADCVAL,W
	BTFSS	STATUS,0
	GOTO	SYSSELECT1CASE4
	MOVF	ADCVAL,W
	SUBLW	149
	BTFSS	STATUS,0
	GOTO	SYSSELECT1CASE4
;RC0 = 1
	BSF	LATC,0
;RC1 = 1
	BSF	LATC,1
;RC2 = 0
	BCF	LATC,2
;RC3 = 0
	BCF	LATC,3
;Case 150 to 200
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE4
SYSSELECT1CASE4:
	MOVLW	150
	SUBWF	ADCVAL,W
	BTFSS	STATUS,0
	GOTO	SYSSELECT1CASE5
	MOVF	ADCVAL,W
	SUBLW	200
	BTFSS	STATUS,0
	GOTO	SYSSELECT1CASE5
;RC0 = 1
	BSF	LATC,0
;RC1 = 1
	BSF	LATC,1
;RC2 = 1
	BSF	LATC,2
;RC3 = 0
	BCF	LATC,3
;Case Else
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE5
SYSSELECT1CASE5:
;RC0 = 1
	BSF	LATC,0
;RC1 = 1
	BSF	LATC,1
;RC2 = 1
	BSF	LATC,2
;RC3 = 1
	BSF	LATC,3
;End Select
GLOBAL	SYSSELECTEND1
SYSSELECTEND1:
;Or, another way
;
;If adcVal < 49 then
;RC1 = 0
;RC2 = 0
;RC3 = 0
;RC4 = 0
;
;else if adcVal > 49 and adcVal < 100 then
;RC1 = 1
;RC2 = 0
;RC3 = 0
;RC4 = 0
;
;else if adcVal > 100 and adcVal < 150 then
;RC1 = 1
;RC2 = 1
;RC3 = 0
;RC4 = 0
;
;else if adcVal > 150 and adcVal < 200 then
;RC1 = 1
;RC2 = 1
;RC3 = 1
;RC4 = 0
;
;else if adcVal > 200 then
;RC1 = 1
;RC2 = 1
;RC3 = 1
;RC4 = 1
;End if
;
;wait 100 ms
	MOVLW	100
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;Loop
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

GLOBAL	DELAY_10US
DELAY_10US:
GLOBAL	D10US_START
D10US_START:
	MOVLW	25
	MOVWF	DELAYTEMP
GLOBAL	DELAYUS0
DELAYUS0:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS0
	NOP
	DECFSZ	SYSWAITTEMP10US, F
	GOTO	D10US_START
	RETURN

;********************************************************************************

GLOBAL	DELAY_MS
DELAY_MS:
	INCF	SYSWAITTEMPMS_H, F
GLOBAL	DMS_START
DMS_START:
	MOVLW	14
	MOVWF	DELAYTEMP2
GLOBAL	DMS_OUTER
DMS_OUTER:
	MOVLW	189
	MOVWF	DELAYTEMP
GLOBAL	DMS_INNER
DMS_INNER:
	DECFSZ	DELAYTEMP, F
	GOTO	DMS_INNER
	DECFSZ	DELAYTEMP2, F
	GOTO	DMS_OUTER
	DECFSZ	SYSWAITTEMPMS, F
	GOTO	DMS_START
	DECFSZ	SYSWAITTEMPMS_H, F
	GOTO	DMS_START
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (159)
GLOBAL	INITSYS
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	MOVLW	96
	BANKSEL	OSCCON1
	MOVWF	OSCCON1
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	CLRF	OSCCON3
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	CLRF	OSCEN
;Default value
;OSCTUNE = 0x00
	CLRF	OSCTUNE
;asm showdebug The MCU is a chip family ChipFamily
;asm showdebug OSCCON type is 102
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F171xx MCU family
;OSCFRQ = 0b00000101
	MOVLW	5
	MOVWF	OSCFRQ
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	BANKSEL	ADCON0
	BCF	ADCON0,2
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	BCF	ADCON0,7
;ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA
;ANSELC = 0
	CLRF	ANSELC
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	BANKSEL	CM2CON0
	BCF	CM2CON0,7
;C1EN = 0
	BCF	CM1CON0,7
;
;'Turn off all ports
;PORTA = 0
	BANKSEL	PORTA
	CLRF	PORTA
;PORTC = 0
	CLRF	PORTC
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2091)
GLOBAL	FN_READAD4
FN_READAD4:
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	BANKSEL	ADCON0
	BCF	ADCON0,2
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,W
	BANKSEL	ADPCH
	MOVWF	ADPCH
;SetNegativeChannelSelectbits
;Macro Source: a-d.h (2867)
;ADCON0.ADIC = 0
	BCF	ADCON0,1
;ADNCH = 0x00
	CLRF	ADNCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (567)
;Configure ANSELA/B/C/D @DebugADC_H
;Select Case ADReadPort
;Case 0: Set ANSELA.0 On
GLOBAL	SYSSELECT2CASE1
SYSSELECT2CASE1:
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,F
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE2
;Case 0: Set ANSELA.0 On
	BANKSEL	ANSELA
	BSF	ANSELA,0
;Case 1: Set ANSELA.1 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE2
SYSSELECT2CASE2:
	DECF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE3
;Case 1: Set ANSELA.1 On
	BANKSEL	ANSELA
	BSF	ANSELA,1
;Case 2: Set ANSELA.2 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE3
SYSSELECT2CASE3:
	MOVLW	2
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE4
;Case 2: Set ANSELA.2 On
	BANKSEL	ANSELA
	BSF	ANSELA,2
;Case 3: Set ANSELA.3 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE4
SYSSELECT2CASE4:
	MOVLW	3
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE5
;Case 3: Set ANSELA.3 On
	BANKSEL	ANSELA
	BSF	ANSELA,3
;Case 4: Set ANSELA.4 ON
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE5
SYSSELECT2CASE5:
	MOVLW	4
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE6
;Case 4: Set ANSELA.4 ON
	BANKSEL	ANSELA
	BSF	ANSELA,4
;Case 5: Set ANSELA.5 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE6
SYSSELECT2CASE6:
	MOVLW	5
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE7
;Case 5: Set ANSELA.5 On
	BANKSEL	ANSELA
	BSF	ANSELA,5
;Case 6: Set ANSELA.6 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE7
SYSSELECT2CASE7:
	MOVLW	6
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE8
;Case 6: Set ANSELA.6 On
	BANKSEL	ANSELA
	BSF	ANSELA,6
;Case 7: Set ANSELA.7 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE8
SYSSELECT2CASE8:
	MOVLW	7
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE9
;Case 7: Set ANSELA.7 On
	BANKSEL	ANSELA
	BSF	ANSELA,7
;Case 8: Set ANSELB.0 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE9
SYSSELECT2CASE9:
	MOVLW	8
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE10
;Case 8: Set ANSELB.0 On
	BSF	ANSELB,0
;Case 9: Set ANSELB.1 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE10
SYSSELECT2CASE10:
	MOVLW	9
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE11
;Case 9: Set ANSELB.1 On
	BSF	ANSELB,1
;Case 10: Set ANSELB.2 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE11
SYSSELECT2CASE11:
	MOVLW	10
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE12
;Case 10: Set ANSELB.2 On
	BSF	ANSELB,2
;Case 11: Set ANSELB.3 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE12
SYSSELECT2CASE12:
	MOVLW	11
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE13
;Case 11: Set ANSELB.3 On
	BSF	ANSELB,3
;Case 12: Set ANSELB.4 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE13
SYSSELECT2CASE13:
	MOVLW	12
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE14
;Case 12: Set ANSELB.4 On
	BSF	ANSELB,4
;Case 13: Set ANSELB.5 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE14
SYSSELECT2CASE14:
	MOVLW	13
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE15
;Case 13: Set ANSELB.5 On
	BSF	ANSELB,5
;Case 14: Set ANSELB.6 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE15
SYSSELECT2CASE15:
	MOVLW	14
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE16
;Case 14: Set ANSELB.6 On
	BSF	ANSELB,6
;Case 15: Set ANSELB.7 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE16
SYSSELECT2CASE16:
	MOVLW	15
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE17
;Case 15: Set ANSELB.7 On
	BSF	ANSELB,7
;Case 16: Set ANSELC.0 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE17
SYSSELECT2CASE17:
	MOVLW	16
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE18
;Case 16: Set ANSELC.0 On
	BANKSEL	ANSELC
	BSF	ANSELC,0
;Case 17: Set ANSELC.1 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE18
SYSSELECT2CASE18:
	MOVLW	17
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE19
;Case 17: Set ANSELC.1 On
	BANKSEL	ANSELC
	BSF	ANSELC,1
;Case 18: Set ANSELC.2 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE19
SYSSELECT2CASE19:
	MOVLW	18
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE20
;Case 18: Set ANSELC.2 On
	BANKSEL	ANSELC
	BSF	ANSELC,2
;Case 19: Set ANSELC.3 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE20
SYSSELECT2CASE20:
	MOVLW	19
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE21
;Case 19: Set ANSELC.3 On
	BANKSEL	ANSELC
	BSF	ANSELC,3
;Case 20: Set ANSELC.4 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE21
SYSSELECT2CASE21:
	MOVLW	20
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE22
;Case 20: Set ANSELC.4 On
	BANKSEL	ANSELC
	BSF	ANSELC,4
;Case 21: Set ANSELC.5 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE22
SYSSELECT2CASE22:
	MOVLW	21
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE23
;Case 21: Set ANSELC.5 On
	BANKSEL	ANSELC
	BSF	ANSELC,5
;Case 22: Set ANSELC.6 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE23
SYSSELECT2CASE23:
	MOVLW	22
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE24
;Case 22: Set ANSELC.6 On
	BANKSEL	ANSELC
	BSF	ANSELC,6
;Case 23: Set ANSELC.7 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE24
SYSSELECT2CASE24:
	MOVLW	23
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND2
;Case 23: Set ANSELC.7 On
	BANKSEL	ANSELC
	BSF	ANSELC,7
;End Select  '*** ANSEL Bits should now be set ***
GLOBAL	SYSSELECTEND2
SYSSELECTEND2:
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
	BANKSEL	ADCON0
	BCF	ADCON0,4
;ADCLK = 1 ' default to FOSC/2
	MOVLW	1
	MOVWF	ADCLK
;Conversion Clock Speed
;SET ADCS OFF  'ADCON0.4
	BCF	ADCON0,4
;ADCLK = 15    'FOSC/16
	MOVLW	15
	MOVWF	ADCLK
;Result formatting
;if ADLeftadjust = 0 then
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
	BCF	ADCON0,2
;Set ADFM0 OFF
	BCF	ADCON0,2
;End if
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,W
	BANKSEL	ADPCH
	MOVWF	ADPCH
;Enable AD Operations
;SET ADON ON
	BSF	ADCON0,7
;Acquisition Delay
;Wait AD_Delay
	MOVLW	2
	MOVWF	SYSWAITTEMP10US
	BANKSEL	STATUS
	CALL	DELAY_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	BANKSEL	ADCON0
	BSF	ADCON0,0
;nop
	NOP
;Wait While GO_NOT_DONE ON
GLOBAL	SYSWAITLOOP1
SYSWAITLOOP1:
	BTFSC	ADCON0,0
	GOTO	SYSWAITLOOP1
;Switch off A/D
;SET ADCON0.ADON OFF
	BCF	ADCON0,7
;ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA
;ANSELC = 0
	CLRF	ANSELC
;ReadAD = ADRESH
	BANKSEL	ADRESH
	MOVF	ADRESH,W
	BANKSEL	READAD
	MOVWF	READAD
;SET ADFM OFF
	BANKSEL	ADCON0
	BCF	ADCON0,2
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 1
	PSECT	PROGMEM1,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	2048
;START OF PROGRAM MEMORY PAGE 2
	PSECT	PROGMEM2,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	4096
;START OF PROGRAM MEMORY PAGE 3
	PSECT	PROGMEM3,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	6144
;START OF PROGRAM MEMORY PAGE 4
	PSECT	PROGMEM4,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	8192
;START OF PROGRAM MEMORY PAGE 5
	PSECT	PROGMEM5,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	10240
;START OF PROGRAM MEMORY PAGE 6
	PSECT	PROGMEM6,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	12288
;START OF PROGRAM MEMORY PAGE 7
	PSECT	PROGMEM7,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	14336
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
