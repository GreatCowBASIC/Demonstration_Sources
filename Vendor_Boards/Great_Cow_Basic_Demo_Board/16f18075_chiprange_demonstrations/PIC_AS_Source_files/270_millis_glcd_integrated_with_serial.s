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
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18075_chiprange_demonstrations\270_millis_glcd_integrated_with_serial.s"
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
 CONFIG MCLRE=EXTMCLR                            ;C1 Reverselookup MCLRE = EXTMCLR
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
 COMPORT                          EQU 32          ; 0X20
 CURMS                            EQU 33          ; 0X21
 CURMS_H                          EQU 34          ; 0X22
 LSTMS                            EQU 35          ; 0X23
 LSTMS_H                          EQU 36          ; 0X24
 MILLIS                           EQU 37          ; 0X25
 MILLIS_E                         EQU 40          ; 0X28
 MILLIS_H                         EQU 38          ; 0X26
 MILLIS_U                         EQU 39          ; 0X27
 MSCTR_                           EQU 41          ; 0X29
 MSCTR__E                         EQU 44          ; 0X2C
 MSCTR__H                         EQU 42          ; 0X2A
 MSCTR__U                         EQU 43          ; 0X2B
 PRINTLEN                         EQU 45          ; 0X2D
 SAVEPCLATH                       EQU 46          ; 0X2E
 SERDATA                          EQU 47          ; 0X2F
 STRINGPOINTER                    EQU 48          ; 0X30
 SYSBSR                           EQU 49          ; 0X31
 SYSBYTETEMPA                     EQU 117          ; 0X75
 SYSBYTETEMPB                     EQU 121          ; 0X79
 SYSBYTETEMPX                     EQU 112          ; 0X70
 SYSINTSTATESAVE0                 EQU 50          ; 0X32
 SYSPRINTDATAHANDLER              EQU 51          ; 0X33
 SYSPRINTDATAHANDLER_H            EQU 52          ; 0X34
 SYSPRINTTEMP                     EQU 53          ; 0X35
 SYSSTATUS                        EQU 127          ; 0X7F
 SYSSTRINGA                       EQU 119          ; 0X77
 SYSSTRINGA_H                     EQU 120          ; 0X78
 SYSTEMP1                         EQU 54          ; 0X36
 SYSTEMP1_H                       EQU 55          ; 0X37
 SYSTEMP2                         EQU 56          ; 0X38
 SYSW                             EQU 126          ; 0X7E
 SYSWORDTEMPA                     EQU 117          ; 0X75
 SYSWORDTEMPA_H                   EQU 118          ; 0X76
 SYSWORDTEMPB                     EQU 121          ; 0X79
 SYSWORDTEMPB_H                   EQU 122          ; 0X7A
 TMRPOST                          EQU 57          ; 0X39
 TMRPRES                          EQU 58          ; 0X3A
 TMRSOURCE                        EQU 59          ; 0X3B

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 4
 AFSR0_H                          EQU 5

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
	CALL	MSCTR_INT_HDLR
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
	CALL	INITPPS
	CALL	INITUSART
	CALL	INIT_MSCTR_INT
;ENABLE INTERRUPTS
	BSF	INTCON,7
	BSF	INTCON,6

;START OF THE MAIN PROGRAM
	BCF	TRISB,1
	BCF	LATB,1
	CLRF	LSTMS
	CLRF	LSTMS_H
	CLRF	CURMS
	CLRF	CURMS_H
SYSDOLOOP_S1:
	CALL	FN_MILLIS
	MOVF	MILLIS,W
	MOVWF	CURMS
	MOVF	MILLIS_H,W
	MOVWF	CURMS_H
	MOVF	LSTMS,W
	SUBWF	CURMS,W
	MOVWF	SYSTEMP1
	MOVF	LSTMS_H,W
	SUBWFB	CURMS_H,W
	MOVWF	SYSTEMP1_H
	MOVF	SYSTEMP1,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	232
	MOVWF	SYSWORDTEMPB
	MOVLW	3
	MOVWF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF1
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTSTRINGCRLF
	CLRF	SYSTEMP2
	BTFSC	PORTB,1
	INCF	SYSTEMP2,F
	COMF	SYSTEMP2,F
	BCF	LATB,1
	BTFSC	SYSTEMP2,0
	BSF	LATB,1
	MOVF	CURMS,W
	MOVWF	LSTMS
	MOVF	CURMS_H,W
	MOVWF	LSTMS_H
ENDIF1:
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

HSERPRINTSTRINGCRLF:
	MOVF	SYSPRINTDATAHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSPRINTDATAHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	PRINTLEN
	MOVF	PRINTLEN,F
	BTFSC	STATUS,2
	GOTO	ENDIF4
	MOVLW	1
	MOVWF	SYSPRINTTEMP
SYSFORLOOP1:
	MOVF	SYSPRINTTEMP,W
	ADDWF	SYSPRINTDATAHANDLER,W
	MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSPRINTDATAHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SERDATA
	CALL	HSERSEND300
	MOVF	SYSPRINTTEMP,W
	SUBWF	PRINTLEN,W
	MOVWF	SYSTEMP2
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	CALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF5
	INCF	SYSPRINTTEMP,F
	GOTO	SYSFORLOOP1
ENDIF5:
SYSFORLOOPEND1:
ENDIF4:
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND300
	MOVLW	10
	MOVWF	SERDATA
	GOTO	HSERSEND300

;********************************************************************************

HSERSEND300:
	DECF	COMPORT,W
	BTFSS	STATUS,2
	GOTO	ENDIF7
SYSWAITLOOP1:
	BANKSEL	PIR3
	BTFSS	PIR3,2
	GOTO	SYSWAITLOOP1
SYSWAITLOOP2:
	BANKSEL	TX1STA
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP2
	BANKSEL	SERDATA
	MOVF	SERDATA,W
	BANKSEL	TX1REG
	MOVWF	TX1REG
ENDIF7:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

INITPPS:
	MOVLW	14
	BANKSEL	RC6PPS
	MOVWF	RC6PPS
	BANKSEL	STATUS
	RETURN

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

INITTIMER0183:
	MOVLW	240
	BANKSEL	T0CON1
	ANDWF	T0CON1,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	IORWF	TMRPRES,F
	DECF	TMRSOURCE,W
	BTFSC	STATUS,2
	GOTO	ELSE6_1
	BSF	TMRPOST,5
	GOTO	ENDIF6
ELSE6_1:
	BCF	TMRPOST,5
ENDIF6:
	MOVF	TMRPRES,W
	BANKSEL	T0CON1
	MOVWF	T0CON1
	MOVLW	224
	ANDWF	T0CON0,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	IORWF	TMRPOST,F
	BCF	TMRPOST,4
	MOVF	TMRPOST,W
	BANKSEL	T0CON0
	MOVWF	T0CON0
	BANKSEL	STATUS
	RETURN

;********************************************************************************

INITUSART:
	MOVLW	1
	MOVWF	COMPORT
;asm showdebug Values_calculated_in_the_script
;asm showdebug _SPBRGH_TEMP=_ SPBRGH_TEMP
;asm showdebug _SPBRGL_TEMP=_ SPBRGL_TEMP
;asm showdebug _BRG16_TEMP=_ BRG16_TEMP
;asm showdebug _BRGH_TEMP=_ BRGH_TEMP
	MOVLW	64
	BANKSEL	SP1BRGL
	MOVWF	SP1BRGL
	MOVLW	3
	MOVWF	SP1BRGH
	MOVLW	64
	MOVWF	SP1BRGL
	BSF	BAUD1CON,3
	BSF	TX1STA,2
	BCF	TX1STA,4
	BSF	TX1STA,5
	BSF	RC1STA,7
	BSF	RC1STA,4
	BANKSEL	STATUS
	RETURN

;********************************************************************************

INIT_MSCTR_INT:
	BANKSEL	PIE0
	BSF	PIE0,5
	BANKSEL	MSCTR_
	CLRF	MSCTR_
	CLRF	MSCTR__H
	CLRF	MSCTR__U
	CLRF	MSCTR__E
	CALL	FN_MILLIS
;asm ShowDebug 16bit capable, but running in 8bit mode
	MOVLW	1
	MOVWF	TMRSOURCE
	MOVLW	69
	MOVWF	TMRPRES
	CLRF	TMRPOST
	CALL	INITTIMER0183
;asm ShowDebug  Call_SetTimer_Millis_macro
	MOVLW	6
	BANKSEL	TMR0L
	MOVWF	TMR0L
;asm ShowDebug Call_StartTimer_Millis_macro
	BSF	T0CON0,7
	BANKSEL	STATUS
	RETURN

;********************************************************************************

FN_MILLIS:
	BCF	SYSINTSTATESAVE0,0
	BTFSC	INTCON,7
	BSF	SYSINTSTATESAVE0,0
	BCF	INTCON,7
	MOVF	MSCTR_,W
	MOVWF	MILLIS
	MOVF	MSCTR__H,W
	MOVWF	MILLIS_H
	MOVF	MSCTR__U,W
	MOVWF	MILLIS_U
	MOVF	MSCTR__E,W
	MOVWF	MILLIS_E
	BTFSS	SYSINTSTATESAVE0,0
	BCF	INTCON,7
	BTFSC	SYSINTSTATESAVE0,0
	BSF	INTCON,7
	RETURN

;********************************************************************************

MSCTR_INT_HDLR:
;asm ShowDebug Call_SetTimer_Millis_macro
	MOVLW	6
	BANKSEL	TMR0L
	MOVWF	TMR0L
	BANKSEL	MSCTR_
	INCF	MSCTR_,F
	BTFSC	STATUS,2
	INCF	MSCTR__H,F
	BTFSC	STATUS,2
	INCF	MSCTR__U,F
	BTFSC	STATUS,2
	INCF	MSCTR__E,F
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

SYSCOMPLESSTHAN16:
	CLRF	SYSBYTETEMPX
	MOVF	SYSWORDTEMPA_H,W
	SUBWF	SYSWORDTEMPB_H,W
	BTFSS	STATUS,0
	RETURN
	MOVF	SYSWORDTEMPB_H,W
	SUBWF	SYSWORDTEMPA_H,W
	BTFSS	STATUS,0
	GOTO	SCLT16TRUE
	MOVF	SYSWORDTEMPB,W
	SUBWF	SYSWORDTEMPA,W
	BTFSC	STATUS,0
	RETURN
SCLT16TRUE:
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

SYSSTRINGTABLES:
	MOVF	SYSSTRINGA_H,W
	MOVWF	PCLATH
	MOVF	SYSSTRINGA,W
	INCF	SYSSTRINGA,F
	BTFSC	STATUS,2
	INCF	SYSSTRINGA_H,F
	MOVWF	PCL

STRINGTABLE1:
	RETLW	10
	RETLW	84	;T
	RETLW	105	;I
	RETLW	109	;M
	RETLW	101	;E
	RETLW	32	; 
	RETLW	69	;E
	RETLW	118	;V
	RETLW	101	;E
	RETLW	110	;N
	RETLW	116	;T


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
