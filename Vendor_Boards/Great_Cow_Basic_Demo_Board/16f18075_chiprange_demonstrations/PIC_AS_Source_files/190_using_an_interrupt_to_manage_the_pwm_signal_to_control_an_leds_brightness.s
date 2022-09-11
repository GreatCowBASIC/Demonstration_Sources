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
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18075_chiprange_demonstrations\190_using_an_interrupt_to_manage_the_pwm_signal_to_control_an_leds_brightness.s"
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
 DELAYTEMP                        EQU 112          ; 0X70
 DELAYTEMP2                       EQU 113          ; 0X71
 MOTORSPEED                       EQU 32          ; 0X20
 PWMCOUNTER                       EQU 33          ; 0X21
 SAVEPCLATH                       EQU 34          ; 0X22
 SPEED                            EQU 35          ; 0X23
 SYSBSR                           EQU 36          ; 0X24
 SYSBYTETEMPA                     EQU 117          ; 0X75
 SYSBYTETEMPB                     EQU 121          ; 0X79
 SYSBYTETEMPX                     EQU 112          ; 0X70
 SYSSTATUS                        EQU 127          ; 0X7F
 SYSTEMP1                         EQU 37          ; 0X25
 SYSTEMP2                         EQU 38          ; 0X26
 SYSW                             EQU 126          ; 0X7E
 SYSWAITTEMPMS                    EQU 114          ; 0X72
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73
 SYSWAITTEMPS                     EQU 116          ; 0X74
 TMRNUMBER                        EQU 39          ; 0X27
 TMRPOST                          EQU 40          ; 0X28
 TMRPRES                          EQU 41          ; 0X29
 TMRSOURCE                        EQU 42          ; 0X2A

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
	CALL	PWMHANDLER
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
	CALL	INITMOTORCONTROL
SYSDOLOOP_S1:
	MOVLW	255
	MOVWF	SPEED
SYSFORLOOP1:
	INCF	SPEED,F
	MOVF	SPEED,W
	MOVWF	MOTORSPEED
	MOVLW	25
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
	MOVLW	100
	SUBWF	SPEED,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
SYSFORLOOPEND1:
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
	MOVLW	100
	MOVWF	SPEED
SYSFORLOOP2:
	MOVF	SPEED,W
	MOVWF	MOTORSPEED
	MOVLW	25
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
	MOVF	SPEED,W
	SUBLW	0
	MOVWF	SYSTEMP1
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	CALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF2
	INCF	SPEED,F
	GOTO	SYSFORLOOP2
ENDIF2:
SYSFORLOOPEND2:
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

DELAY_MS:
	INCF	SYSWAITTEMPMS_H, F
DMS_START:
	MOVLW	14
	MOVWF	DELAYTEMP2
DMS_OUTER:
	MOVLW	189
	MOVWF	DELAYTEMP
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

DELAY_S:
DS_START:
	MOVLW	232
	MOVWF	SYSWAITTEMPMS
	MOVLW	3
	MOVWF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
	DECFSZ	SYSWAITTEMPS, F
	GOTO	DS_START
	RETURN

;********************************************************************************

INITMOTORCONTROL:
	CLRF	MOTORSPEED
	CLRF	PWMCOUNTER
	BANKSEL	PIE0
	BSF	PIE0,5
	MOVLW	1
	BANKSEL	TMRSOURCE
	MOVWF	TMRSOURCE
	MOVLW	64
	MOVWF	TMRPRES
	CLRF	TMRPOST
	CALL	INITTIMER0178
	CLRF	TMRNUMBER
	GOTO	STARTTIMER

;********************************************************************************

INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
	BANKSEL	OSCCON2
	CLRF	OSCCON2
	CLRF	OSCCON3
	MOVLW	5
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

INITTIMER0178:
	MOVLW	240
	BANKSEL	T0CON1
	ANDWF	T0CON1,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	IORWF	TMRPRES,F
	DECF	TMRSOURCE,W
	BTFSC	STATUS,2
	GOTO	ELSE11_1
	BSF	TMRPOST,5
	GOTO	ENDIF11
ELSE11_1:
	BCF	TMRPOST,5
ENDIF11:
	MOVF	TMRPRES,W
	BANKSEL	T0CON1
	MOVWF	T0CON1
	MOVLW	224
	ANDWF	T0CON0,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	IORWF	TMRPOST,F
	BCF	TMRPOST,4
	MOVF	TMRPOST,W
	BANKSEL	T0CON0
	MOVWF	T0CON0
	BANKSEL	STATUS
	RETURN

;********************************************************************************

PWMHANDLER:
	MOVF	MOTORSPEED,W
	SUBWF	PWMCOUNTER,W
	BTFSC	STATUS,0
	GOTO	ELSE3_1
	BSF	LATB,1
	GOTO	ENDIF3
ELSE3_1:
	BCF	LATB,1
ENDIF3:
	INCF	PWMCOUNTER,F
	MOVLW	100
	SUBWF	PWMCOUNTER,W
	BTFSC	STATUS,2
	CLRF	PWMCOUNTER
	RETURN

;********************************************************************************

STARTTIMER:
	MOVF	TMRNUMBER,F
	BTFSS	STATUS,2
	GOTO	ENDIF5
	BANKSEL	T0CON0
	BSF	T0CON0,7
ENDIF5:
	BANKSEL	TMRNUMBER
	DECF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF6
	BANKSEL	T1CON
	BSF	T1CON,0
ENDIF6:
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF7
	BANKSEL	T2CON
	BSF	T2CON,7
ENDIF7:
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF8
	BANKSEL	T3CON
	BSF	T3CON,0
ENDIF8:
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF9
	BANKSEL	T4CON
	BSF	T4CON,7
ENDIF9:
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF10
	BANKSEL	T6CON
	BSF	T6CON,7
ENDIF10:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

SYSCOMPEQUAL:
	CLRF	SYSBYTETEMPX
	MOVF	SYSBYTETEMPA, W
	SUBWF	SYSBYTETEMPB, W
	BTFSC	STATUS,2
	COMF	SYSBYTETEMPX,F
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
