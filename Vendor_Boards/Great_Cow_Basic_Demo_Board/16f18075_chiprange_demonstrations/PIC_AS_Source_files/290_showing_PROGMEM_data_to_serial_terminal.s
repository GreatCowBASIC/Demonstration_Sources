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
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18075_chiprange_demonstrations\290_showing_PROGMEM_data_to_serial_terminal.s"
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
GLOBAL	COMPORT
 COMPORT                          EQU 32          ; 0X20
GLOBAL	DATAWORD
 DATAWORD                         EQU 33          ; 0X21
GLOBAL	DATAWORD_H
 DATAWORD_H                       EQU 34          ; 0X22
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 112          ; 0X70
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 113          ; 0X71
GLOBAL	HSERPRINTCRLFCOUNT
 HSERPRINTCRLFCOUNT               EQU 35          ; 0X23
GLOBAL	PRINTLEN
 PRINTLEN                         EQU 36          ; 0X24
GLOBAL	PROGMEMADDRESS
 PROGMEMADDRESS                   EQU 37          ; 0X25
GLOBAL	PROGMEMADDRESS_E
 PROGMEMADDRESS_E                 EQU 40          ; 0X28
GLOBAL	PROGMEMADDRESS_H
 PROGMEMADDRESS_H                 EQU 38          ; 0X26
GLOBAL	PROGMEMADDRESS_U
 PROGMEMADDRESS_U                 EQU 39          ; 0X27
GLOBAL	SERDATA
 SERDATA                          EQU 41          ; 0X29
GLOBAL	STRINGPOINTER
 STRINGPOINTER                    EQU 42          ; 0X2A
GLOBAL	SYSBITVAR2
 SYSBITVAR2                       EQU 43          ; 0X2B
GLOBAL	SYSBYTETEMPA
 SYSBYTETEMPA                     EQU 117          ; 0X75
GLOBAL	SYSBYTETEMPB
 SYSBYTETEMPB                     EQU 121          ; 0X79
GLOBAL	SYSBYTETEMPX
 SYSBYTETEMPX                     EQU 112          ; 0X70
GLOBAL	SYSLONGTEMPA
 SYSLONGTEMPA                     EQU 117          ; 0X75
GLOBAL	SYSLONGTEMPA_E
 SYSLONGTEMPA_E                   EQU 120          ; 0X78
GLOBAL	SYSLONGTEMPA_H
 SYSLONGTEMPA_H                   EQU 118          ; 0X76
GLOBAL	SYSLONGTEMPA_U
 SYSLONGTEMPA_U                   EQU 119          ; 0X77
GLOBAL	SYSLONGTEMPB
 SYSLONGTEMPB                     EQU 121          ; 0X79
GLOBAL	SYSLONGTEMPB_E
 SYSLONGTEMPB_E                   EQU 124          ; 0X7C
GLOBAL	SYSLONGTEMPB_H
 SYSLONGTEMPB_H                   EQU 122          ; 0X7A
GLOBAL	SYSLONGTEMPB_U
 SYSLONGTEMPB_U                   EQU 123          ; 0X7B
GLOBAL	SYSPRINTDATAHANDLER
 SYSPRINTDATAHANDLER              EQU 44          ; 0X2C
GLOBAL	SYSPRINTDATAHANDLER_H
 SYSPRINTDATAHANDLER_H            EQU 45          ; 0X2D
GLOBAL	SYSPRINTTEMP
 SYSPRINTTEMP                     EQU 46          ; 0X2E
GLOBAL	SYSREPEATTEMP1
 SYSREPEATTEMP1                   EQU 47          ; 0X2F
GLOBAL	SYSSTRINGA
 SYSSTRINGA                       EQU 119          ; 0X77
GLOBAL	SYSSTRINGA_H
 SYSSTRINGA_H                     EQU 120          ; 0X78
GLOBAL	SYSSTRINGTEMP
 SYSSTRINGTEMP                    EQU 48          ; 0X30
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 49          ; 0X31
GLOBAL	SYSTEMP2
 SYSTEMP2                         EQU 50          ; 0X32
GLOBAL	SYSVALTEMP
 SYSVALTEMP                       EQU 51          ; 0X33
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73
GLOBAL	SYSWAITTEMPS
 SYSWAITTEMPS                     EQU 116          ; 0X74
GLOBAL	_HEXPICAS
 _HEXPICAS                        EQU 9196          ; 0X23EC

;********************************************************************************

;ALIAS VARIABLES
GLOBAL	AFSR0
 AFSR0                            EQU 4
GLOBAL	AFSR0_H
 AFSR0_H                          EQU 5
GLOBAL	EEADDRESS
 EEADDRESS                        EQU 7308
GLOBAL	EEADDRESS_H
 EEADDRESS_H                      EQU 7309
GLOBAL	EEDATAWORD
 EEDATAWORD                       EQU 7310
GLOBAL	EEDATAWORD_H
 EEDATAWORD_H                     EQU 7311
GLOBAL	SYS_HEXPICAS_0
 SYS_HEXPICAS_0                   EQU 1612
GLOBAL	SYS_HEXPICAS_1
 SYS_HEXPICAS_1                   EQU 1613
GLOBAL	SYS_HEXPICAS_2
 SYS_HEXPICAS_2                   EQU 1614

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
	CALL	INITPPS
	CALL	INITUSART

;START OF THE MAIN PROGRAM
;''
;''  This demonstration shows the PROGMEM on the Serial Terminal.
;''
;'' This shows code for writing and reading values onto the PROGMEM or PFM.
;''
;''
;'' If you read the chip and look at the memory locations 0xFFC0 to 0xFFFE - you will see the correct values.
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.01
;''@date    15/09/2022
;----- Configuration
;Chip Settings.
;Generated by PIC PPS Tool for GCBASIC
;PPS Tool version: 0.0.6.1
;PinManager data: v1.79.0
;Generated for 16F18075
;
;Template comment at the start of the config file
;
;Template comment at the end of the config file
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
;' IO:    ----TX---------------------------
;'-----------------------------------------
;'
;' ------------------PORTE-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ----------------RST--------------
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
;Setup Serial port
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Now assumes Serial Terminal is operational
;Dim  ProgMemAddress as long
;Dim  DataWord as word
;wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;PFMReadWord
;We are reading words, so we send the ProgMemAddress address every two bytes (a word).
;for ProgMemAddress = 0x0000 to 0x001F #IGNOREWARNING
;LEGACY METHOD
	MOVLW	255
	MOVWF	PROGMEMADDRESS
	MOVWF	PROGMEMADDRESS_H
	MOVWF	PROGMEMADDRESS_U
	MOVWF	PROGMEMADDRESS_E
GLOBAL	SYSFORLOOP1
SYSFORLOOP1:
	INCF	PROGMEMADDRESS,F
	BTFSC	STATUS,2
	INCF	PROGMEMADDRESS_H,F
	BTFSC	STATUS,2
	INCF	PROGMEMADDRESS_U,F
	BTFSC	STATUS,2
	INCF	PROGMEMADDRESS_E,F
;Display the value
;HSerPrint "0x"
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrint hex(ProgMemAddress_h)
	MOVF	PROGMEMADDRESS_H,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrint hex(ProgMemAddress)
	MOVF	PROGMEMADDRESS,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerSend 9
	MOVLW	9
	MOVWF	SERDATA
	CALL	HSERSEND293
;HSerSend 9
	MOVLW	9
	MOVWF	SERDATA
	CALL	HSERSEND293
;Read the value of the ProgMem
;ProgramRead  ( ProgMemAddress, DataWord )
	MOVF	PROGMEMADDRESS,W
	BANKSEL	NVMADRL
	MOVWF	NVMADRL
	BANKSEL	PROGMEMADDRESS_H
	MOVF	PROGMEMADDRESS_H,W
	BANKSEL	NVMADRH
	MOVWF	NVMADRH
	BANKSEL	STATUS
	CALL	PROGRAMREAD
	BANKSEL	NVMDATL
	MOVF	NVMDATL,W
	BANKSEL	DATAWORD
	MOVWF	DATAWORD
	BANKSEL	NVMDATH
	MOVF	NVMDATH,W
	BANKSEL	DATAWORD_H
	MOVWF	DATAWORD_H
;Display the received value
;HSerPrint "0x"
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrint hex(DataWord_h)
	MOVF	DATAWORD_H,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrint hex(DataWord)
	MOVF	DATAWORD,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Next
	MOVF	PROGMEMADDRESS,W
	MOVWF	SYSLONGTEMPA
	MOVF	PROGMEMADDRESS_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	PROGMEMADDRESS_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	PROGMEMADDRESS_E,W
	MOVWF	SYSLONGTEMPA_E
	MOVLW	31
	MOVWF	SYSLONGTEMPB
	CLRF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	CALL	SYSCOMPLESSTHAN32
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSFORLOOP1
GLOBAL	SYSFORLOOPEND1
SYSFORLOOPEND1:
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;ProgramWrite
;ProgramWrite ( 0x3FF8, 0x55 )
	MOVLW	248
	BANKSEL	NVMADRL
	MOVWF	NVMADRL
	MOVLW	63
	MOVWF	NVMADRH
	MOVLW	85
	MOVWF	NVMDATL
	CLRF	NVMDATH
	BANKSEL	STATUS
	CALL	PROGRAMWRITE
;ProgramWrite ( 0x3FFC, 0x1234 )
	MOVLW	252
	BANKSEL	NVMADRL
	MOVWF	NVMADRL
	MOVLW	63
	MOVWF	NVMADRH
	MOVLW	52
	MOVWF	NVMDATL
	MOVLW	18
	MOVWF	NVMDATH
	BANKSEL	STATUS
	CALL	PROGRAMWRITE
;We are reading words, so we send the ProgMemAddress address every two bytes (a word).
;for ProgMemAddress = 0x3FF0 to 0x3FFF #IGNOREWARNING
;LEGACY METHOD
	MOVLW	239
	MOVWF	PROGMEMADDRESS
	MOVLW	63
	MOVWF	PROGMEMADDRESS_H
	CLRF	PROGMEMADDRESS_U
	CLRF	PROGMEMADDRESS_E
GLOBAL	SYSFORLOOP2
SYSFORLOOP2:
	INCF	PROGMEMADDRESS,F
	BTFSC	STATUS,2
	INCF	PROGMEMADDRESS_H,F
	BTFSC	STATUS,2
	INCF	PROGMEMADDRESS_U,F
	BTFSC	STATUS,2
	INCF	PROGMEMADDRESS_E,F
;Display the value
;HSerPrint "0x"
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrint hex(ProgMemAddress_h)
	MOVF	PROGMEMADDRESS_H,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrint hex(ProgMemAddress)
	MOVF	PROGMEMADDRESS,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerSend 9
	MOVLW	9
	MOVWF	SERDATA
	CALL	HSERSEND293
;HSerSend 9
	MOVLW	9
	MOVWF	SERDATA
	CALL	HSERSEND293
;Read the value of the ProgMemAddress
;ProgramRead  ( ProgMemAddress, DataWord )
	MOVF	PROGMEMADDRESS,W
	BANKSEL	NVMADRL
	MOVWF	NVMADRL
	BANKSEL	PROGMEMADDRESS_H
	MOVF	PROGMEMADDRESS_H,W
	BANKSEL	NVMADRH
	MOVWF	NVMADRH
	BANKSEL	STATUS
	CALL	PROGRAMREAD
	BANKSEL	NVMDATL
	MOVF	NVMDATL,W
	BANKSEL	DATAWORD
	MOVWF	DATAWORD
	BANKSEL	NVMDATH
	MOVF	NVMDATH,W
	BANKSEL	DATAWORD_H
	MOVWF	DATAWORD_H
;Display the received value
;HSerPrint "0x"
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrint hex(DataWord_h)
	MOVF	DATAWORD_H,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrint hex(DataWord)
	MOVF	DATAWORD,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Next
	MOVF	PROGMEMADDRESS,W
	MOVWF	SYSLONGTEMPA
	MOVF	PROGMEMADDRESS_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	PROGMEMADDRESS_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	PROGMEMADDRESS_E,W
	MOVWF	SYSLONGTEMPA_E
	MOVLW	255
	MOVWF	SYSLONGTEMPB
	MOVLW	63
	MOVWF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	CALL	SYSCOMPLESSTHAN32
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSFORLOOP2
GLOBAL	SYSFORLOOPEND2
SYSFORLOOPEND2:
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;do
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;loop
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

GLOBAL	DELAY_S
DELAY_S:
GLOBAL	DS_START
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

;OVERLOADED SIGNATURE: STRING:BYTE:, SOURCE: USART.H (1526)
GLOBAL	HSERPRINT304
HSERPRINT304:
;PrintLen = PrintData(0)
	MOVF	SYSPRINTDATAHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSPRINTDATAHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	PRINTLEN
;If PrintLen <> 0 then
	MOVF	PRINTLEN,F
	BTFSC	STATUS,2
	GOTO	ENDIF8
;Write Data
;for SysPrintTemp = 1 to PrintLen
	MOVLW	1
	MOVWF	SYSPRINTTEMP
GLOBAL	SYSFORLOOP4
SYSFORLOOP4:
;HSerSend(PrintData(SysPrintTemp),comport )
	MOVF	SYSPRINTTEMP,W
	ADDWF	SYSPRINTDATAHANDLER,W
	MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSPRINTDATAHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SERDATA
	CALL	HSERSEND294
;next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	MOVF	SYSPRINTTEMP,W
	SUBWF	PRINTLEN,W
	MOVWF	SYSTEMP1
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	CALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF9
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	SYSPRINTTEMP,F
	GOTO	SYSFORLOOP4
;END IF
GLOBAL	ENDIF9
ENDIF9:
GLOBAL	SYSFORLOOPEND4
SYSFORLOOPEND4:
;End If
GLOBAL	ENDIF8
ENDIF8:
;CR
	RETURN

;********************************************************************************

;SOURCE: USART.H (1683)
GLOBAL	HSERPRINTCRLF
HSERPRINTCRLF:
;repeat HSerPrintCRLFCount
	MOVF	HSERPRINTCRLFCOUNT,W
	MOVWF	SYSREPEATTEMP1
	BTFSC	STATUS,2
	GOTO	SYSREPEATLOOPEND1
GLOBAL	SYSREPEATLOOP1
SYSREPEATLOOP1:
;HSerSend(13,comport)
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND294
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND294
;end Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
GLOBAL	SYSREPEATLOOPEND1
SYSREPEATLOOPEND1:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: USART.H (871)
GLOBAL	HSERSEND293
HSERSEND293:
;Registers/Bits determined by #samevar at top of library
;USART_TX_BLOCKING
;Wait While TXIF = Off
GLOBAL	SYSWAITLOOP1
SYSWAITLOOP1:
	BANKSEL	PIR3
	BTFSS	PIR3,2
	GOTO	SYSWAITLOOP1
;ensure any previous operation has completed @1
;Wait until TRMT = 1
GLOBAL	SYSWAITLOOP2
SYSWAITLOOP2:
	BANKSEL	TX1STA
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP2
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	BANKSEL	SERDATA
	MOVF	SERDATA,W
	BANKSEL	TX1REG
	MOVWF	TX1REG
;Add USART_DELAY after the byte is sent by the USART module
;Wait USART_DELAY
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	BANKSEL	STATUS
	GOTO	DELAY_MS

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (974)
GLOBAL	HSERSEND294
HSERSEND294:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W
	BTFSS	STATUS,2
	GOTO	ENDIF10
;USART_TX_BLOCKING
;Wait While TXIF = Off
GLOBAL	SYSWAITLOOP3
SYSWAITLOOP3:
	BANKSEL	PIR3
	BTFSS	PIR3,2
	GOTO	SYSWAITLOOP3
;ensure any previous operation has completed
;Wait until TRMT = 1
GLOBAL	SYSWAITLOOP4
SYSWAITLOOP4:
	BANKSEL	TX1STA
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP4
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	BANKSEL	SERDATA
	MOVF	SERDATA,W
	BANKSEL	TX1REG
	MOVWF	TX1REG
;Add USART_DELAY after the byte is sent by the USART module
;Wait USART_DELAY
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	BANKSEL	STATUS
	CALL	DELAY_MS
;end if
GLOBAL	ENDIF10
ENDIF10:
	RETURN

;********************************************************************************

;SOURCE: 290_SHOWING_PROGMEM_DATA_TO_SERIAL_TERMINAL.GCB (32)
GLOBAL	INITPPS
INITPPS:
;Module: EUSART
;RC6PPS = 0x000E    'TX > RC6
	MOVLW	14
	BANKSEL	RC6PPS
	MOVWF	RC6PPS
	BANKSEL	STATUS
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

;SOURCE: USART.H (630)
GLOBAL	INITUSART
INITUSART:
;Set the default value for comport
;comport = 1
	MOVLW	1
	MOVWF	COMPORT
;asm showdebug Values_calculated_in_the_script
;asm showdebug _SPBRGH_TEMP=_ SPBRGH_TEMP
;asm showdebug _SPBRGL_TEMP=_ SPBRGL_TEMP
;asm showdebug _BRG16_TEMP=_ BRG16_TEMP
;asm showdebug _BRGH_TEMP=_ BRGH_TEMP
;Set baud rate for legacy chips
;SPBRG = SPBRGL_TEMP
	MOVLW	64
	BANKSEL	SP1BRGL
	MOVWF	SP1BRGL
;Set baud rate for chips with BRG16 bit
;SPBRGH = SPBRGH_TEMP
	MOVLW	3
	MOVWF	SP1BRGH
;SPBRGL = SPBRGL_TEMP
	MOVLW	64
	MOVWF	SP1BRGL
;BRG16: 16-bit Baud Rate Generator bit
;1 = 16-bit Baud Rate Generator is used
;0 = 8-bit Baud Rate Generator is used
;BRG16 = BRG16_TEMP
	BSF	BAUD1CON,3
;Set High Baud Rate Select bit
;BRGH = BRGH_TEMP
	BSF	TX1STA,2
;Enable async and TX mode for most non K42
;Set SYNC Off
;Set TXEN On
;Changed to canskip to silently exit when no USART
;[canskip]SYNC=0
	BCF	TX1STA,4
;[canskip]TXEN=1
	BSF	TX1STA,5
;SPEN=1
	BSF	RC1STA,7
;Enable TX and RX
;CREN=1
	BSF	RC1STA,4
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (4039)
GLOBAL	PROGRAMREAD
PROGRAMREAD:
;EEDataWord = 0x00
	BANKSEL	NVMDATL
	CLRF	NVMDATL
	CLRF	NVMDATH
;Dim EEAddress As Word Alias PMADRH, PMADRL
;Dim EEDataWord As Word Alias PMDATH, PMDATL
;Dim NVMREGSState as Bit
;Disable Interrupt
;IntOff
;Select program memory
;NVMREGSState = NVMREGS
	BANKSEL	SYSBITVAR2
	BCF	SYSBITVAR2,0
	BANKSEL	NVMCON1
	BTFSS	NVMCON1,6
	GOTO	ENDIF6
	BANKSEL	SYSBITVAR2
	BSF	SYSBITVAR2,0
GLOBAL	ENDIF6
ENDIF6:
;NVMREGS = 0
	BANKSEL	NVMCON1
	BCF	NVMCON1,6
;Set CFGS OFF
	BCF	NVMCON1,6
;Start read, wait for it to finish
;SET RD ON
	BSF	NVMCON1,0
;NOP
	NOP
;NOP
	NOP
;NVMREGS = NVMREGSState
	BCF	NVMCON1,6
	BANKSEL	SYSBITVAR2
	BTFSS	SYSBITVAR2,0
	GOTO	ENDIF7
	BANKSEL	NVMCON1
	BSF	NVMCON1,6
GLOBAL	ENDIF7
ENDIF7:
;Enable interrupt
;IntOn
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3963)
GLOBAL	PROGRAMWRITE
PROGRAMWRITE:
;Dim EEAddress As Word Alias PMADRH, PMADRL
;Dim EEDataWord As Word Alias PMDATH, PMDATL
;Disable Interrupt
;IntOff
;Select program memory
;Set CFGS OFF
	BANKSEL	NVMCON1
	BCF	NVMCON1,6
;Enable write
;SET WREN ON
	BSF	NVMCON1,2
;SET FREE OFF
	BCF	NVMCON1,4
;Write enable code
;PMCON2 = 0x55
	MOVLW	85
	MOVWF	NVMCON2
;PMCON2 = 0xAA
	MOVLW	170
	MOVWF	NVMCON2
;PMCON2 = 0x55
	MOVLW	85
	MOVWF	NVMCON2
;PMCON2 = 0xAA
	MOVLW	170
	MOVWF	NVMCON2
;NVMCON2 = 0x55
	MOVLW	85
	MOVWF	NVMCON2
;NVMCON2 = 0xAA
	MOVLW	170
	MOVWF	NVMCON2
;Start write, wait for it to finish
;SET WR ON
	BSF	NVMCON1,1
;NOP
	NOP
;NOP
	NOP
;NOP
	NOP
;NOP
	NOP
;SET WREN OFF
	BCF	NVMCON1,2
;Enable Interrupt
;IntOn
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3078)
GLOBAL	SYSCOMPEQUAL
SYSCOMPEQUAL:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;movf SysByteTempA, W
	MOVF	SYSBYTETEMPA, W
;subwf SysByteTempB, W
	SUBWF	SYSBYTETEMPB, W
;btfsc STATUS, Z
	BTFSC	STATUS,2
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3471)
GLOBAL	SYSCOMPLESSTHAN32
SYSCOMPLESSTHAN32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test Exp, exit if more
;movf SysLongTempA_E,W
	MOVF	SYSLONGTEMPA_E,W
;subwf SysLongTempB_E,W
	SUBWF	SYSLONGTEMPB_E,W
;btfss STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
	BTFSS	STATUS,2
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	MOVF	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	SUBWF	SYSLONGTEMPB_U,W
;btfss STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
	BTFSS	STATUS,2
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	MOVF	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	SUBWF	SYSLONGTEMPB_H,W
;btfss STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
	BTFSS	STATUS,2
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	MOVF	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	SUBWF	SYSLONGTEMPA,W
;btfsc STATUS,C
	BTFSC	STATUS,0
;return
	RETURN
GLOBAL	SCLT32TRUE
SCLT32TRUE:
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

GLOBAL	SYSSTRINGTABLES
SYSSTRINGTABLES:
	MOVF	SYSSTRINGA_H,W
	MOVWF	PCLATH
	MOVF	SYSSTRINGA,W
	INCF	SYSSTRINGA,F
	BTFSC	STATUS,2
	INCF	SYSSTRINGA_H,F
	MOVWF	PCL

GLOBAL	STRINGTABLE1
STRINGTABLE1:
	RETLW	2
	RETLW	48	;0
	RETLW	120	;X


;********************************************************************************

;SOURCE: PICAS.H (7)
GLOBAL	FN__HEXPICAS
FN__HEXPICAS:
;_HexPICAS(0) = 2
	MOVLW	2
	BANKSEL	SYS_HEXPICAS_0
	MOVWF	SYS_HEXPICAS_0
;dim SysStringTemp as byte
;Low nibble
;SysStringTemp = SysValTemp And 0x0F
	MOVLW	15
	BANKSEL	SYSVALTEMP
	ANDWF	SYSVALTEMP,W
	MOVWF	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
	BTFSC	STATUS,0
	GOTO	ENDIF3
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
GLOBAL	ENDIF3
ENDIF3:
;_HexPICAS(2) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W
	BANKSEL	SYS_HEXPICAS_2
	MOVWF	SYS_HEXPICAS_2
;Get high nibble
;For SysStringTemp = 1 to 4
;LEGACY METHOD
	BANKSEL	SYSSTRINGTEMP
	CLRF	SYSSTRINGTEMP
GLOBAL	SYSFORLOOP3
SYSFORLOOP3:
	INCF	SYSSTRINGTEMP,F
;Rotate SysValTemp Right
	RRF	SYSVALTEMP,F
;Next
	MOVLW	4
	SUBWF	SYSSTRINGTEMP,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP3
GLOBAL	SYSFORLOOPEND3
SYSFORLOOPEND3:
;SysStringTemp = SysValTemp And 0x0F
	MOVLW	15
	ANDWF	SYSVALTEMP,W
	MOVWF	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
	BTFSC	STATUS,0
	GOTO	ENDIF5
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
GLOBAL	ENDIF5
ENDIF5:
;_HexPICAS(1) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W
	BANKSEL	SYS_HEXPICAS_1
	MOVWF	SYS_HEXPICAS_1
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
