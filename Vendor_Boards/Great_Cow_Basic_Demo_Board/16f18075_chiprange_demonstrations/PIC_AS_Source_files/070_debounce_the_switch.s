;Program compiled by GCBASIC (1.00.00 Release Candidate 2022-09-11 (Windows 64 bit) : Build 1168x) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18075
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18075_chiprange_demonstrations\070_debounce_the_switch.s"
 SUBTITLE    "09-11-2022"

; Reverse lookup file(s)
; C:\Program Files\Microchip\xc8\v2.40\pic\include\proc\pic16f18075.inc
; C:\Program Files\Microchip\xc8\v2.40\pic\dat\cfgmap\16f18075.cfgmap
; Alternative CONFIG file is to be found at C:\Program Files\Microchip\xc8\vX.YY\pic\dat\cfgdata as per Microchip support ticket #00730936 

;********************************************************************************

;********************************************************************************
;Explicit CONFIG
 CONFIG CLKOUTEN=OFF                             ;C1 Reverselookup CLKOUTEN = OFF
 CONFIG RSTOSC=HFINTOSC_32MHz                    ;C1 Reverselookup RSTOSC = HFINTOSC_32MHZ
 CONFIG FEXTOSC=OFF                              ;C1 Reverselookup FEXTOSC = OFF
 CONFIG WDTE=OFF                                 ;C1 Reverselookup WDTE = OFF
 CONFIG MCLRE=INTMCLR                            ;C1 Reverselookup MCLRE = INTMCLR
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
GLOBAL	ACTKEYDOWN
 ACTKEYDOWN                       EQU 32          ; 0X20
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 112          ; 0X70
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 113          ; 0X71
GLOBAL	KEYPRESSED
 KEYPRESSED                       EQU 33          ; 0X21
GLOBAL	LASTKEYDOWN
 LASTKEYDOWN                      EQU 34          ; 0X22
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 35          ; 0X23
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
;''
;'' This demonstration uses a simple software routine to avoid the initial noise on the switch
;'' pin. The code will inspect the switch status, but should overcome most of the noise from a switch.
;''
;'' Some switches are worse than others.
;''
;'' When the switch is held down and released, one LED will toggle.
;''
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.01
;''@date    15/09/2022
;----- Configuration
;Chip Settings.
;This Configuration change is needed to enable programming in Low Voltage Programming Mode
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------------------------
;'-----------------------------------------
;'
;' -------------------PORTB----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    --------IN-LED--LED-LED LED -----
;'-----------------------------------------
;'
;' ------------------PORTC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------------------------
;'-----------------------------------------
;'
;Define constants to make things easier. We can reuse these at any time.
;Dir     LEDD1         Out
	BCF	TRISB,1
;Dir     LEDD2         Out
	BCF	TRISB,2
;Dir     LEDD3         Out
	BCF	TRISB,3
;Dir     LEDD4         Out
	BCF	TRISB,4
;Dir     POTENTIOMETER In
	BSF	TRISA,0
;Dir     SWITCHIN      In
	BSF	TRISB,5
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim lastKeyDown As Byte
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
;If  keyPressed( lastKeyDown ) = TRUE Then
	CALL	FN_KEYPRESSED
	INCF	KEYPRESSED,W
	BTFSS	STATUS,2
	GOTO	ENDIF1
;push button pressed
;LEDD1 = !LEDD1
	CLRF	SYSTEMP1
	BTFSC	PORTB,1
	INCF	SYSTEMP1,F
	COMF	SYSTEMP1,F
	BCF	LATB,1
	BTFSC	SYSTEMP1,0
	BSF	LATB,1
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

;SOURCE: SYSTEM.H (159)
GLOBAL	INITSYS
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;OSCCON2 = 0
	BANKSEL	OSCCON2
	CLRF	OSCCON2
;OSCCON3 = 0
	CLRF	OSCCON3
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F180xx MCU family 32 mhz
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
;ANSELB = 0
	CLRF	ANSELB
;ANSELC = 0
	CLRF	ANSELC
;ANSELD = 0
	CLRF	ANSELD
;ANSELE = 0
	CLRF	ANSELE
;Set comparator register bits for many MCUs with register CM2CON0
;C1EN = 0
	BANKSEL	CM1CON0
	BCF	CM1CON0,7
;
;'Turn off all ports
;PORTA = 0
	BANKSEL	PORTA
	CLRF	PORTA
;PORTB = 0
	CLRF	PORTB
;PORTC = 0
	CLRF	PORTC
;PORTD = 0
	CLRF	PORTD
;PORTE = 0
	CLRF	PORTE
	RETURN

;********************************************************************************

;SOURCE: 070_DEBOUNCE_THE_SWITCH.GCB (80)
GLOBAL	FN_KEYPRESSED
FN_KEYPRESSED:
;Dim actKeyDown As Byte
;If ( !SWITCHIN ) Then
	CLRF	SYSTEMP1
	BTFSC	PORTB,5
	INCF	SYSTEMP1,F
	COMF	SYSTEMP1,F
	BTFSS	SYSTEMP1,0
	GOTO	ELSE4_1
;actKeyDown = TRUE
	MOVLW	255
	MOVWF	ACTKEYDOWN
;Else
	GOTO	ENDIF4
GLOBAL	ELSE4_1
ELSE4_1:
;actKeyDown = FALSE
	CLRF	ACTKEYDOWN
;End If
GLOBAL	ENDIF4
ENDIF4:
;If (actKeyDown <> lastKeyDown) Then
	MOVF	LASTKEYDOWN,W
	SUBWF	ACTKEYDOWN,W
	BTFSC	STATUS,2
	GOTO	ELSE6_1
;lastKeyDown = actKeyDown
	MOVF	ACTKEYDOWN,W
	MOVWF	LASTKEYDOWN
;keyPressed =  actKeyDown
	MOVF	ACTKEYDOWN,W
	MOVWF	KEYPRESSED
;Else
	GOTO	ENDIF6
GLOBAL	ELSE6_1
ELSE6_1:
;keyPressed = FALSE
	CLRF	KEYPRESSED
;End If
GLOBAL	ENDIF6
ENDIF6:
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
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
