;Program compiled by Great Cow BASIC (1.00.00 Release Candidate 2022-09-11 (Windows 64 bit) : Build 1168x) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18075
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18075_chiprange_demonstrations\140_rotate_the_leds_using_the_timer_overflow_event.s"
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
 SAVEPCLATH                       EQU 32          ; 0X20
 SYSBSR                           EQU 33          ; 0X21
 SYSSTATUS                        EQU 127          ; 0X7F
 SYSTEMP1                         EQU 34          ; 0X22
 SYSW                             EQU 126          ; 0X7E
 TIMEOUT                          EQU 35          ; 0X23
 TMRNUMBER                        EQU 36          ; 0X24
 TMRPOST                          EQU 37          ; 0X25
 TMRPRES                          EQU 38          ; 0X26
 TMRSOURCE                        EQU 39          ; 0X27
 TMRVALUE                         EQU 40          ; 0X28
 TMRVALUE_H                       EQU 41          ; 0X29

;********************************************************************************

 PSECT   PROGMEM0,delta=2, abs
 RESETVEC:
;VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	GOTO	BASPROGRAMSTART
	ORG	4
INTERRUPT:

;********************************************************************************

;SAVE CONTEXT
	MOVWF	SYSW
	SWAPF	STATUS,W
	MOVWF	SYSSTATUS
	MOVF	BSR,W
	BANKSEL	STATUS
	MOVWF	SYSBSR
;STORE SYSTEM VARIABLES
	MOVF	PCLATH,W
	MOVWF	SAVEPCLATH
	CLRF	PCLATH
;ON INTERRUPT HANDLERS
	BANKSEL	PIE0
	BTFSS	PIE0,5
	GOTO	NOTTMR0IF
	BTFSS	PIR0,5
	GOTO	NOTTMR0IF
	BANKSEL	STATUS
	CALL	BLINK
	BANKSEL	PIR0
	BCF	PIR0,5
	GOTO	INTERRUPTDONE
NOTTMR0IF:
;USER INTERRUPT ROUTINE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	BANKSEL	SAVEPCLATH
	MOVF	SAVEPCLATH,W
	MOVWF	PCLATH
	MOVF	SYSBSR,W
	MOVWF	BSR
	SWAPF	SYSSTATUS,W
	MOVWF	STATUS
	SWAPF	SYSW,F
	SWAPF	SYSW,W
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	34
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS
;ENABLE INTERRUPTS
	BSF	INTCON,7
	BSF	INTCON,6

;START OF THE MAIN PROGRAM
	BCF	TRISB,1
	BCF	TRISB,2
	BCF	TRISB,3
	BCF	TRISB,4
	BSF	TRISA,0
	BSF	TRISB,5
	MOVLW	1
	MOVWF	TMRSOURCE
	MOVLW	70
	MOVWF	TMRPRES
	CLRF	TMRPOST
	CALL	INITTIMER0177
	CLRF	TMRNUMBER
	MOVLW	220
	MOVWF	TMRVALUE
	MOVLW	11
	MOVWF	TMRVALUE_H
	CALL	SETTIMER175
	BANKSEL	PIE0
	BSF	PIE0,5
	BANKSEL	TMRNUMBER
	CLRF	TMRNUMBER
	CALL	STARTTIMER
	BCF	LATB,1
	BCF	LATB,2
	BCF	LATB,3
	BSF	LATB,4
SYSDOLOOP_S1:
	DECF	TIMEOUT,W
	BTFSS	STATUS,2
	GOTO	ENDIF1
	BCF	STATUS,0
	RRF	LATB,F
	BTFSS	LATB,0
	GOTO	ENDIF2
	BCF	LATB,1
	BCF	LATB,2
	BCF	LATB,3
	BSF	LATB,4
	MOVLW	30
	ANDWF	LATB,F
ENDIF2:
	CLRF	TIMEOUT
	CLRF	TMRNUMBER
	MOVLW	220
	MOVWF	TMRVALUE
	MOVLW	11
	MOVWF	TMRVALUE_H
	CALL	SETTIMER175
ENDIF1:
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

BLINK:
	MOVLW	1
	MOVWF	TIMEOUT
	BANKSEL	PIR0
	BCF	PIR0,5
	BANKSEL	STATUS
	RETURN

;********************************************************************************

INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
	BANKSEL	OSCCON2
	CLRF	OSCCON2
	CLRF	OSCCON3
	MOVLW	4
	MOVWF	OSCFRQ
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
	BANKSEL	ADCON0
	BCF	ADCON0,2
	BCF	ADCON0,7
	BANKSEL	ANSELA
	CLRF	ANSELA
	CLRF	ANSELB
	CLRF	ANSELC
	CLRF	ANSELD
	CLRF	ANSELE
	BANKSEL	CM1CON0
	BCF	CM1CON0,7
	BANKSEL	PORTA
	CLRF	PORTA
	CLRF	PORTB
	CLRF	PORTC
	CLRF	PORTD
	CLRF	PORTE
	RETURN

;********************************************************************************

INITTIMER0177:
	MOVLW	240
	BANKSEL	T0CON1
	ANDWF	T0CON1,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	IORWF	TMRPRES,F
	DECF	TMRSOURCE,W
	BTFSC	STATUS,2
	GOTO	ELSE15_1
	BSF	TMRPOST,5
	GOTO	ENDIF15
ELSE15_1:
	BCF	TMRPOST,5
ENDIF15:
	MOVF	TMRPRES,W
	BANKSEL	T0CON1
	MOVWF	T0CON1
	MOVLW	224
	ANDWF	T0CON0,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	IORWF	TMRPOST,F
	BSF	TMRPOST,4
	MOVF	TMRPOST,W
	BANKSEL	T0CON0
	MOVWF	T0CON0
	BANKSEL	STATUS
	RETURN

;********************************************************************************

SETTIMER175:
	MOVF	TMRNUMBER,F
	BTFSS	STATUS,2
	GOTO	ENDIF9
	MOVF	TMRVALUE_H,W
	BANKSEL	TMR0H
	MOVWF	TMR0H
	BANKSEL	TMRVALUE
	MOVF	TMRVALUE,W
	BANKSEL	TMR0L
	MOVWF	TMR0L
	BANKSEL	STATUS
	RETURN
ENDIF9:
	DECF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF10
	MOVF	TMRVALUE_H,W
	BANKSEL	TMR1H
	MOVWF	TMR1H
	BANKSEL	TMRVALUE
	MOVF	TMRVALUE,W
	BANKSEL	TMR1L
	MOVWF	TMR1L
ENDIF10:
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF11
	MOVF	TMRVALUE,W
	BANKSEL	T2TMR
	MOVWF	T2TMR
ENDIF11:
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF12
	MOVF	TMRVALUE_H,W
	BANKSEL	TMR3H
	MOVWF	TMR3H
	BANKSEL	TMRVALUE
	MOVF	TMRVALUE,W
	BANKSEL	TMR3L
	MOVWF	TMR3L
ENDIF12:
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF13
	MOVF	TMRVALUE,W
	BANKSEL	T4TMR
	MOVWF	T4TMR
ENDIF13:
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF14
	MOVF	TMRVALUE,W
	BANKSEL	T6TMR
	MOVWF	T6TMR
ENDIF14:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

STARTTIMER:
	MOVF	TMRNUMBER,F
	BTFSS	STATUS,2
	GOTO	ENDIF3
	BANKSEL	T0CON0
	BSF	T0CON0,7
ENDIF3:
	BANKSEL	TMRNUMBER
	DECF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF4
	BANKSEL	T1CON
	BSF	T1CON,0
ENDIF4:
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF5
	BANKSEL	T2CON
	BSF	T2CON,7
ENDIF5:
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF6
	BANKSEL	T3CON
	BSF	T3CON,0
ENDIF6:
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF7
	BANKSEL	T4CON
	BSF	T4CON,7
ENDIF7:
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF8
	BANKSEL	T6CON
	BSF	T6CON,7
ENDIF8:
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
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
