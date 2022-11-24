;Program compiled by Great Cow BASIC (1.00.00 Release Candidate 2022-11-06 (Windows 64 bit) : Build 1189) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18126
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Microchip_Low_Pin_Count_Demo_Board\PICKit2_Board\16F18126\070_debounce_the_switch.s"
 SUBTITLE    "11-24-2022"

; Reverse lookup file(s)
; C:\Program Files\Microchip\xc8\v2.40\pic\include\proc\pic16f18126.inc
; C:\Program Files\Microchip\xc8\v2.40\pic\dat\cfgmap\16f18126.cfgmap
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
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 112          ; 0X70
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 113          ; 0X71
GLOBAL	SYSBITVAR0
 SYSBITVAR0                       EQU 32          ; 0X20
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 33          ; 0X21
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73

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
;This demonstration uses a simple software routine to avoid the initial noise on the switch
;pin. The code will inspect the switch status, but should overcome most of the noise from a switch.
;
;Some switches are worse than others.
;
;When the switch is held down and released, one LED will toggle.
;
;
;************************************************************************
;@author  EvanV
;@licence GPL
;@version 1.00
;@date    31.11.2022
;
;----- Configuration
;Chip Settings.
;-------------------PORTA----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:   ------------------SW---------ADC--
;-----------------------------------------
;-------------------PORTB----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ---------------------------------
;-----------------------------------------
;
;------------------PORTC-----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ---------------LED--LED-LED LED--
;-----------------------------------------
;
;Define constants to make things easier. We can reuse these at any time.
;Dir     RC0         Out
	BCF	TRISC,0
;Dir     RC1         Out
	BCF	TRISC,1
;Dir     RC2         Out
	BCF	TRISC,2
;Dir     RC3         Out
	BCF	TRISC,3
;Dir     POTENTIOMETER In
	BSF	TRISA,0
;Dir     SWITCHIN      In
	BSF	TRISA,3
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Debouncing a switch
;Do Forever
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;Wait 10 ms
	MOVLW	10
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;keyPressed is a Function that returns the state
;If  funcKeyPressed() = TRUE Then
	CALL	FN_FUNCKEYPRESSED
	BTFSS	SYSBITVAR0,0
	GOTO	ENDIF1
;push button pressed
;RC0 = !RC0
	CLRF	SYSTEMP1
	BTFSC	PORTC,0
	INCF	SYSTEMP1,F
	COMF	SYSTEMP1,F
	BCF	LATC,0
	BTFSC	SYSTEMP1,0
	BSF	LATC,0
;RC1 = !RC1
	CLRF	SYSTEMP1
	BTFSC	PORTC,1
	INCF	SYSTEMP1,F
	COMF	SYSTEMP1,F
	BCF	LATC,1
	BTFSC	SYSTEMP1,0
	BSF	LATC,1
;RC2 = !RC2
	CLRF	SYSTEMP1
	BTFSC	PORTC,2
	INCF	SYSTEMP1,F
	COMF	SYSTEMP1,F
	BCF	LATC,2
	BTFSC	SYSTEMP1,0
	BSF	LATC,2
;RC3 = !RC3
	CLRF	SYSTEMP1
	BTFSC	PORTC,3
	INCF	SYSTEMP1,F
	COMF	SYSTEMP1,F
	BCF	LATC,3
	BTFSC	SYSTEMP1,0
	BSF	LATC,3
;End If
GLOBAL	ENDIF1
ENDIF1:
;Loop
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

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

;SOURCE: 070_DEBOUNCE_THE_SWITCH.GCB (81)
GLOBAL	FN_FUNCKEYPRESSED
FN_FUNCKEYPRESSED:
;Dim CurrentSwitchState As Bit
;Dim LastSwitchState As Bit
;wait 1 ms
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;If ( SWITCHIN = DOWN ) Then
	BTFSS	PORTA,3
	GOTO	ELSE10_1
;CurrentSwitchState = TRUE
	BSF	SYSBITVAR0,1
;Else
	GOTO	ENDIF10
GLOBAL	ELSE10_1
ELSE10_1:
;CurrentSwitchState = FALSE
	BCF	SYSBITVAR0,1
;End If
GLOBAL	ENDIF10
ENDIF10:
;This condition ensures the state of the switch has changed
;If (CurrentSwitchState <> LastSwitchState) Then
	CLRW
	BTFSC	SYSBITVAR0,1
	XORLW	255
	BTFSC	SYSBITVAR0,2
	XORLW	255
	BTFSC	STATUS,2
	GOTO	ELSE11_1
;Set the last state
;LastSwitchState = CurrentSwitchState
	BCF	SYSBITVAR0,2
	BTFSC	SYSBITVAR0,1
	BSF	SYSBITVAR0,2
;Return the state value - returns either TRUE or FALSE
;funcKeyPressed =  CurrentSwitchState
	BCF	SYSBITVAR0,0
	BTFSC	SYSBITVAR0,1
	BSF	SYSBITVAR0,0
;Else
	GOTO	ENDIF11
GLOBAL	ELSE11_1
ELSE11_1:
;funcKeyPressed = FALSE
	BCF	SYSBITVAR0,0
;End If
GLOBAL	ENDIF11
ENDIF11:
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
