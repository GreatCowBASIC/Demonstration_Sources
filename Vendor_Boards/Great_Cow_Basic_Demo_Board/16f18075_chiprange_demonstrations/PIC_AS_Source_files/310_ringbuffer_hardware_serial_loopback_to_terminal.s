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
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18075_chiprange_demonstrations\310_ringbuffer_hardware_serial_loopback_to_terminal.s"
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
 BGETC                            EQU 32          ; 0X20
 BUFFER                           EQU 9136          ; 0X23B0
 COMPORT                          EQU 33          ; 0X21
 DEFAULTUSARTRETURNVALUE          EQU 34          ; 0X22
 DELAYTEMP                        EQU 112          ; 0X70
 DELAYTEMP2                       EQU 113          ; 0X71
 HSERRECEIVE                      EQU 35          ; 0X23
 LOCAL_NEXT_OUT                   EQU 36          ; 0X24
 NEXT_IN                          EQU 37          ; 0X25
 NEXT_OUT                         EQU 38          ; 0X26
 PRINTLEN                         EQU 39          ; 0X27
 SAVEFSR0H                        EQU 40          ; 0X28
 SAVEFSR0L                        EQU 41          ; 0X29
 SAVEPCLATH                       EQU 42          ; 0X2A
 SAVESYSBYTETEMPA                 EQU 43          ; 0X2B
 SAVESYSBYTETEMPB                 EQU 44          ; 0X2C
 SAVESYSBYTETEMPX                 EQU 45          ; 0X2D
 SAVESYSDIVLOOP                   EQU 46          ; 0X2E
 SAVESYSTEMP1                     EQU 47          ; 0X2F
 SERDATA                          EQU 48          ; 0X30
 STRINGPOINTER                    EQU 49          ; 0X31
 SYSBSR                           EQU 50          ; 0X32
 SYSBYTETEMPA                     EQU 117          ; 0X75
 SYSBYTETEMPB                     EQU 121          ; 0X79
 SYSBYTETEMPX                     EQU 112          ; 0X70
 SYSDIVLOOP                       EQU 116          ; 0X74
 SYSINTSTATESAVE0                 EQU 51          ; 0X33
 SYSPRINTDATAHANDLER              EQU 52          ; 0X34
 SYSPRINTDATAHANDLER_H            EQU 53          ; 0X35
 SYSPRINTTEMP                     EQU 54          ; 0X36
 SYSSTATUS                        EQU 127          ; 0X7F
 SYSSTRINGA                       EQU 119          ; 0X77
 SYSSTRINGA_H                     EQU 120          ; 0X78
 SYSTEMP1                         EQU 55          ; 0X37
 SYSTEMP2                         EQU 56          ; 0X38
 SYSW                             EQU 126          ; 0X7E
 SYSWAITTEMPMS                    EQU 114          ; 0X72
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73
 SYSWAITTEMPS                     EQU 116          ; 0X74
 TEMPPNT                          EQU 57          ; 0X39

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 4
 AFSR0_H                          EQU 5
 SYSHSERRECEIVEBYTE               EQU 35

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
	MOVF	FSR0L,W
	MOVWF	SAVEFSR0L
	MOVF	SYSTEMP1,W
	MOVWF	SAVESYSTEMP1
	MOVF	FSR0H,W
	MOVWF	SAVEFSR0H
	MOVF	SYSBYTETEMPA,W
	MOVWF	SAVESYSBYTETEMPA
	MOVF	SYSBYTETEMPB,W
	MOVWF	SAVESYSBYTETEMPB
	MOVF	SYSBYTETEMPX,W
	MOVWF	SAVESYSBYTETEMPX
	MOVF	SYSDIVLOOP,W
	MOVWF	SAVESYSDIVLOOP
	MOVF	PCLATH,W
	MOVWF	SAVEPCLATH
	CLRF	PCLATH
;ON INTERRUPT HANDLERS
	BANKSEL	PIE3
	BTFSS	PIE3,3
	GOTO	NOTRC1IF
	BTFSS	PIR3,3
	GOTO	NOTRC1IF
	BANKSEL	STATUS
	CALL	READUSART
	BANKSEL	PIR3
	BCF	PIR3,3
	GOTO	INTERRUPTDONE
NOTRC1IF:
;USER INTERRUPT ROUTINE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	BANKSEL	SAVEFSR0L
	MOVF	SAVEFSR0L,W
	MOVWF	FSR0L
	MOVF	SAVESYSTEMP1,W
	MOVWF	SYSTEMP1
	MOVF	SAVEFSR0H,W
	MOVWF	FSR0H
	MOVF	SAVESYSBYTETEMPA,W
	MOVWF	SYSBYTETEMPA
	MOVF	SAVESYSBYTETEMPB,W
	MOVWF	SYSBYTETEMPB
	MOVF	SAVESYSBYTETEMPX,W
	MOVWF	SYSBYTETEMPX
	MOVF	SAVESYSDIVLOOP,W
	MOVWF	SYSDIVLOOP
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
	ORG	62
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS
	CALL	INITPPS
	CALL	INITUSART
;ENABLE INTERRUPTS
	BSF	INTCON,7
	BSF	INTCON,6

;START OF THE MAIN PROGRAM
	MOVLW	100
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
	MOVLW	3
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
	CALL	INITBUFFERRING
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND296
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND296
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND296
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND296
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT307
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND296
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND296
SYSDOLOOP_S1:
	MOVF	NEXT_OUT,W
	SUBWF	NEXT_IN,W
	BTFSC	STATUS,2
	GOTO	ENDIF1
	CALL	FN_BGETC
	MOVF	BGETC,W
	MOVWF	SERDATA
	CALL	HSERSEND296
ENDIF1:
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

FN_BGETC:
	MOVF	NEXT_OUT,W
	MOVWF	LOCAL_NEXT_OUT
	MOVLW	LOW(BUFFER)
	ADDWF	LOCAL_NEXT_OUT,W
	MOVWF	FSR0L
	CLRF	SYSTEMP1
	MOVLW	HIGH(BUFFER)
	ADDWFC	SYSTEMP1,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	BGETC
	INCF	LOCAL_NEXT_OUT,W
	MOVWF	SYSTEMP1
	MOVWF	SYSBYTETEMPA
	MOVLW	64
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPX,W
	MOVWF	LOCAL_NEXT_OUT
	BCF	SYSINTSTATESAVE0,0
	BTFSC	INTCON,7
	BSF	SYSINTSTATESAVE0,0
	BCF	INTCON,7
	MOVF	LOCAL_NEXT_OUT,W
	MOVWF	NEXT_OUT
	BTFSS	SYSINTSTATESAVE0,0
	BCF	INTCON,7
	BTFSC	SYSINTSTATESAVE0,0
	BSF	INTCON,7
	RETURN

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

HSERPRINT307:
	MOVF	SYSPRINTDATAHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSPRINTDATAHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	PRINTLEN
	MOVF	PRINTLEN,F
	BTFSC	STATUS,2
	GOTO	ENDIF2
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
	CALL	HSERSEND297
	MOVF	SYSPRINTTEMP,W
	SUBWF	PRINTLEN,W
	MOVWF	SYSTEMP1
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	CALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF3
	INCF	SYSPRINTTEMP,F
	GOTO	SYSFORLOOP1
ENDIF3:
SYSFORLOOPEND1:
ENDIF2:
	RETURN

;********************************************************************************

FN_HSERRECEIVE298:
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERRECEIVE302
	MOVF	SERDATA,W
	MOVWF	HSERRECEIVE
	RETURN

;********************************************************************************

HSERRECEIVE302:
	DECF	COMPORT,W
	BTFSS	STATUS,2
	GOTO	ENDIF6
	MOVF	DEFAULTUSARTRETURNVALUE,W
	MOVWF	SERDATA
SYSWAITLOOP5:
	BANKSEL	PIR3
	BTFSS	PIR3,3
	GOTO	SYSWAITLOOP5
	BTFSS	PIR3,3
	GOTO	ENDIF7
	BANKSEL	RC1REG
	MOVF	RC1REG,W
	BANKSEL	SERDATA
	MOVWF	SERDATA
ENDIF7:
	BANKSEL	RC1STA
	BTFSS	RC1STA,1
	GOTO	ENDIF8
	BCF	RC1STA,4
	BSF	RC1STA,4
ENDIF8:
ENDIF6:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

HSERSEND296:
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
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	BANKSEL	STATUS
	GOTO	DELAY_MS

;********************************************************************************

HSERSEND297:
	DECF	COMPORT,W
	BTFSS	STATUS,2
	GOTO	ENDIF5
SYSWAITLOOP3:
	BANKSEL	PIR3
	BTFSS	PIR3,2
	GOTO	SYSWAITLOOP3
SYSWAITLOOP4:
	BANKSEL	TX1STA
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP4
	BANKSEL	SERDATA
	MOVF	SERDATA,W
	BANKSEL	TX1REG
	MOVWF	TX1REG
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	BANKSEL	STATUS
	CALL	DELAY_MS
ENDIF5:
	RETURN

;********************************************************************************

INITBUFFERRING:
	CLRF	NEXT_IN
	CLRF	NEXT_OUT
	BANKSEL	PIE3
	BSF	PIE3,3
	BANKSEL	STATUS
	RETURN

;********************************************************************************

INITPPS:
	MOVLW	23
	BANKSEL	RX1PPS
	MOVWF	RX1PPS
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

READUSART:
	CALL	FN_HSERRECEIVE298
	MOVLW	LOW(BUFFER)
	ADDWF	NEXT_IN,W
	MOVWF	FSR0L
	CLRF	SYSTEMP1
	MOVLW	HIGH(BUFFER)
	ADDWFC	SYSTEMP1,W
	MOVWF	FSR0H
	MOVF	SYSHSERRECEIVEBYTE,W
	MOVWF	INDF0
	MOVF	NEXT_IN,W
	MOVWF	TEMPPNT
	INCF	NEXT_IN,W
	MOVWF	SYSTEMP1
	MOVWF	SYSBYTETEMPA
	MOVLW	64
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPX,W
	MOVWF	NEXT_IN
	MOVF	NEXT_OUT,W
	SUBWF	NEXT_IN,W
	BTFSS	STATUS,2
	GOTO	ENDIF4
	MOVF	TEMPPNT,W
	MOVWF	NEXT_IN
ENDIF4:
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

SYSDIVSUB:
	MOVF	SYSBYTETEMPB, F
	BTFSC	STATUS,2
	RETURN
	CLRF	SYSBYTETEMPX
	MOVLW	8
	MOVWF	SYSDIVLOOP
SYSDIV8START:
	BCF	STATUS,0
	RLF	SYSBYTETEMPA, F
	RLF	SYSBYTETEMPX, F
	MOVF	SYSBYTETEMPB, W
	SUBWF	SYSBYTETEMPX, F
	BSF	SYSBYTETEMPA, 0
	BTFSC	STATUS,0
	GOTO	DIV8NOTNEG
	BCF	SYSBYTETEMPA, 0
	MOVF	SYSBYTETEMPB, W
	ADDWF	SYSBYTETEMPX, F
DIV8NOTNEG:
	DECFSZ	SYSDIVLOOP, F
	GOTO	SYSDIV8START
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
	RETLW	35
	RETLW	83	;S
	RETLW	116	;T
	RETLW	97	;A
	RETLW	114	;R
	RETLW	116	;T
	RETLW	101	;E
	RETLW	100	;D
	RETLW	58	;:
	RETLW	32	; 
	RETLW	83	;S
	RETLW	101	;E
	RETLW	114	;R
	RETLW	105	;I
	RETLW	97	;A
	RETLW	108	;L
	RETLW	32	; 
	RETLW	98	;B
	RETLW	101	;E
	RETLW	116	;T
	RETLW	119	;W
	RETLW	101	;E
	RETLW	101	;E
	RETLW	110	;N
	RETLW	32	; 
	RETLW	116	;T
	RETLW	119	;W
	RETLW	111	;O
	RETLW	32	; 
	RETLW	100	;D
	RETLW	101	;E
	RETLW	118	;V
	RETLW	105	;I
	RETLW	99	;C
	RETLW	101	;E
	RETLW	115	;S


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
