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
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18075_chiprange_demonstrations\300_basic_hardware_serial_loopback_to_terminal.s"
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
 COMPORT                          EQU 32          ; 0X20
 DEFAULTUSARTRETURNVALUE          EQU 33          ; 0X21
 DELAYTEMP                        EQU 112          ; 0X70
 DELAYTEMP2                       EQU 113          ; 0X71
 HSERPRINTCRLFCOUNT               EQU 34          ; 0X22
 HSERRECEIVE                      EQU 35          ; 0X23
 INCHAR                           EQU 36          ; 0X24
 PRINTLEN                         EQU 37          ; 0X25
 SERDATA                          EQU 38          ; 0X26
 STRINGPOINTER                    EQU 39          ; 0X27
 SYSBYTETEMPA                     EQU 117          ; 0X75
 SYSBYTETEMPB                     EQU 121          ; 0X79
 SYSBYTETEMPX                     EQU 112          ; 0X70
 SYSPRINTDATAHANDLER              EQU 40          ; 0X28
 SYSPRINTDATAHANDLER_H            EQU 41          ; 0X29
 SYSPRINTTEMP                     EQU 42          ; 0X2A
 SYSREPEATTEMP1                   EQU 43          ; 0X2B
 SYSSTRINGA                       EQU 119          ; 0X77
 SYSSTRINGA_H                     EQU 120          ; 0X78
 SYSTEMP1                         EQU 44          ; 0X2C
 SYSTEMP2                         EQU 45          ; 0X2D
 SYSWAITTEMPMS                    EQU 114          ; 0X72
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73

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
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	5
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS
	CALL	INITPPS
	CALL	INITUSART

;START OF THE MAIN PROGRAM
	MOVLW	100
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
	MOVLW	LOW STRINGTABLE67
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE67) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
SYSDOLOOP_S1:
	CALL	HSERRECEIVE299
	MOVF	SERDATA,W
	MOVWF	INCHAR
	MOVWF	SERDATA
	CALL	HSERSEND293
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
	GOTO	BASPROGRAMEND
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

HSERPRINT304:
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
	CALL	HSERSEND294
	MOVF	SYSPRINTTEMP,W
	SUBWF	PRINTLEN,W
	MOVWF	SYSTEMP1
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
	RETURN

;********************************************************************************

HSERPRINTCRLF:
	MOVF	HSERPRINTCRLFCOUNT,W
	MOVWF	SYSREPEATTEMP1
	BTFSC	STATUS,2
	GOTO	SYSREPEATLOOPEND1
SYSREPEATLOOP1:
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND294
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND294
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
	RETURN

;********************************************************************************

HSERRECEIVE299:
	DECF	COMPORT,W
	BTFSS	STATUS,2
	GOTO	ENDIF1
	MOVF	DEFAULTUSARTRETURNVALUE,W
	MOVWF	SERDATA
SYSWAITLOOP3:
	BANKSEL	PIR3
	BTFSS	PIR3,3
	GOTO	SYSWAITLOOP3
	BTFSS	PIR3,3
	GOTO	ENDIF2
	BANKSEL	RC1REG
	MOVF	RC1REG,W
	BANKSEL	SERDATA
	MOVWF	SERDATA
ENDIF2:
	BANKSEL	RC1STA
	BTFSS	RC1STA,1
	GOTO	ENDIF3
	BCF	RC1STA,4
	BSF	RC1STA,4
ENDIF3:
ENDIF1:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

HSERSEND293:
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

HSERSEND294:
	DECF	COMPORT,W
	BTFSS	STATUS,2
	GOTO	ENDIF6
SYSWAITLOOP4:
	BANKSEL	PIR3
	BTFSS	PIR3,2
	GOTO	SYSWAITLOOP4
SYSWAITLOOP5:
	BANKSEL	TX1STA
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP5
	BANKSEL	SERDATA
	MOVF	SERDATA,W
	BANKSEL	TX1REG
	MOVWF	TX1REG
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	BANKSEL	STATUS
	CALL	DELAY_MS
ENDIF6:
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

SYSCOMPEQUAL:
	CLRF	SYSBYTETEMPX
	MOVF	SYSBYTETEMPA, W
	SUBWF	SYSBYTETEMPB, W
	BTFSC	STATUS,2
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

STRINGTABLE67:
	RETLW	8
	RETLW	49	;1
	RETLW	54	;6
	RETLW	70	;F
	RETLW	49	;1
	RETLW	56	;8
	RETLW	48	;0
	RETLW	55	;7
	RETLW	53	;5


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
