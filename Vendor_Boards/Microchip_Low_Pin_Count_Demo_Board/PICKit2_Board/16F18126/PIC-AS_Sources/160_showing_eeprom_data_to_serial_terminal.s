;Program compiled by GCBASIC (1.00.00 Release Candidate 2022-11-06 (Windows 64 bit) : Build 1189) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18126
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Microchip_Low_Pin_Count_Demo_Board\PICKit2_Board\16F18126\160_showing_eeprom_data_to_serial_terminal.s"
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
GLOBAL	COMPORT
 COMPORT                          EQU 32          ; 0X20
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 112          ; 0X70
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 113          ; 0X71
GLOBAL	DISPLAYNEWLINE
 DISPLAYNEWLINE                   EQU 33          ; 0X21
GLOBAL	EEDATA
 EEDATA                           EQU 34          ; 0X22
GLOBAL	EEDATAVALUE
 EEDATAVALUE                      EQU 35          ; 0X23
GLOBAL	EEPROMADDRESS
 EEPROMADDRESS                    EQU 36          ; 0X24
GLOBAL	EEPROMADDRESS_H
 EEPROMADDRESS_H                  EQU 37          ; 0X25
GLOBAL	HSERPRINTCRLFCOUNT
 HSERPRINTCRLFCOUNT               EQU 38          ; 0X26
GLOBAL	INDATA
 INDATA                           EQU 39          ; 0X27
GLOBAL	OUTDATA
 OUTDATA                          EQU 40          ; 0X28
GLOBAL	PRINTLEN
 PRINTLEN                         EQU 41          ; 0X29
GLOBAL	RIGHT
 RIGHT                            EQU 10183          ; 0X27C7
GLOBAL	SERDATA
 SERDATA                          EQU 42          ; 0X2A
GLOBAL	STRINGPOINTER
 STRINGPOINTER                    EQU 43          ; 0X2B
GLOBAL	SYSARRAYTEMP1
 SYSARRAYTEMP1                    EQU 44          ; 0X2C
GLOBAL	SYSARRAYTEMP2
 SYSARRAYTEMP2                    EQU 45          ; 0X2D
GLOBAL	SYSBITVAR0
 SYSBITVAR0                       EQU 46          ; 0X2E
GLOBAL	SYSBYTETEMPA
 SYSBYTETEMPA                     EQU 117          ; 0X75
GLOBAL	SYSBYTETEMPB
 SYSBYTETEMPB                     EQU 121          ; 0X79
GLOBAL	SYSBYTETEMPX
 SYSBYTETEMPX                     EQU 112          ; 0X70
GLOBAL	SYSCHARCOUNT
 SYSCHARCOUNT                     EQU 47          ; 0X2F
GLOBAL	SYSCHARSTART
 SYSCHARSTART                     EQU 48          ; 0X30
GLOBAL	SYSDIVLOOP
 SYSDIVLOOP                       EQU 116          ; 0X74
GLOBAL	SYSDIVMULTA
 SYSDIVMULTA                      EQU 119          ; 0X77
GLOBAL	SYSDIVMULTA_H
 SYSDIVMULTA_H                    EQU 120          ; 0X78
GLOBAL	SYSDIVMULTB
 SYSDIVMULTB                      EQU 123          ; 0X7B
GLOBAL	SYSDIVMULTB_H
 SYSDIVMULTB_H                    EQU 124          ; 0X7C
GLOBAL	SYSDIVMULTX
 SYSDIVMULTX                      EQU 114          ; 0X72
GLOBAL	SYSDIVMULTX_H
 SYSDIVMULTX_H                    EQU 115          ; 0X73
GLOBAL	SYSEEADDRESS
 SYSEEADDRESS                     EQU 49          ; 0X31
GLOBAL	SYSEEADDRESS_H
 SYSEEADDRESS_H                   EQU 50          ; 0X32
GLOBAL	SYSEEPROMADDRESS
 SYSEEPROMADDRESS                 EQU 51          ; 0X33
GLOBAL	SYSEEPROMADDRESS_H
 SYSEEPROMADDRESS_H               EQU 52          ; 0X34
GLOBAL	SYSPRINTDATAHANDLER
 SYSPRINTDATAHANDLER              EQU 53          ; 0X35
GLOBAL	SYSPRINTDATAHANDLER_H
 SYSPRINTDATAHANDLER_H            EQU 54          ; 0X36
GLOBAL	SYSPRINTTEMP
 SYSPRINTTEMP                     EQU 55          ; 0X37
GLOBAL	SYSREPEATTEMP1
 SYSREPEATTEMP1                   EQU 56          ; 0X38
GLOBAL	SYSSTRINGA
 SYSSTRINGA                       EQU 119          ; 0X77
GLOBAL	SYSSTRINGA_H
 SYSSTRINGA_H                     EQU 120          ; 0X78
GLOBAL	SYSSTRINGTEMP
 SYSSTRINGTEMP                    EQU 57          ; 0X39
GLOBAL	SYSSYSINSTRINGHANDLER
 SYSSYSINSTRINGHANDLER            EQU 58          ; 0X3A
GLOBAL	SYSSYSINSTRINGHANDLER_H
 SYSSYSINSTRINGHANDLER_H          EQU 59          ; 0X3B
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 60          ; 0X3C
GLOBAL	SYSTEMP1_H
 SYSTEMP1_H                       EQU 61          ; 0X3D
GLOBAL	SYSTEMP2
 SYSTEMP2                         EQU 62          ; 0X3E
GLOBAL	SYSTEMP3
 SYSTEMP3                         EQU 63          ; 0X3F
GLOBAL	SYSVALTEMP
 SYSVALTEMP                       EQU 64          ; 0X40
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73
GLOBAL	SYSWAITTEMPS
 SYSWAITTEMPS                     EQU 116          ; 0X74
GLOBAL	SYSWORDTEMPA
 SYSWORDTEMPA                     EQU 117          ; 0X75
GLOBAL	SYSWORDTEMPA_H
 SYSWORDTEMPA_H                   EQU 118          ; 0X76
GLOBAL	SYSWORDTEMPB
 SYSWORDTEMPB                     EQU 121          ; 0X79
GLOBAL	SYSWORDTEMPB_H
 SYSWORDTEMPB_H                   EQU 122          ; 0X7A
GLOBAL	SYSWORDTEMPX
 SYSWORDTEMPX                     EQU 112          ; 0X70
GLOBAL	SYSWORDTEMPX_H
 SYSWORDTEMPX_H                   EQU 113          ; 0X71
GLOBAL	_HEXPICAS
 _HEXPICAS                        EQU 10179          ; 0X27C3

;********************************************************************************

;ALIAS VARIABLES
GLOBAL	AFSR0
 AFSR0                            EQU 4
GLOBAL	AFSR0_H
 AFSR0_H                          EQU 5
GLOBAL	SYSRIGHT_0
 SYSRIGHT_0                       EQU 3175
GLOBAL	SYS_HEXPICAS_0
 SYS_HEXPICAS_0                   EQU 3171
GLOBAL	SYS_HEXPICAS_1
 SYS_HEXPICAS_1                   EQU 3172
GLOBAL	SYS_HEXPICAS_2
 SYS_HEXPICAS_2                   EQU 3173

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
;''  This demonstration shows the EEProm values on the Serial Terminal.
;''
;'' This lesson will provide code for writing and reading a single byte onto
;'' the on-board EEPROM. EEPROM is non-volatile memory, meaning that it does
;'' not lose its value when power is shut off. This is unlike RAM, which will
;'' lose its value when no power is applied. The EEPROM is useful for storing
;'' variables that must still be present during no power.
;'' It is also convenient to use if the entire RAM space is used up.
;'' Writes and reads to the EEPROM are practically instant and are much faster
;'' than program memory operations.
;'' This will show the value of the EEPROM on the serial Terminal.
;'' You can experiment by changing the variable 'Outdata' from Random function to a specific range.  Enjoy.
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.00
;''@date    31.11.2022
;----- Configuration
;Chip Settings.
;Generated by PIC PPS Tool for GCBASIC
;PPS Tool version: 0.0.6.3
;PinManager data: Not available (3)
;Generated for 16f18126
;
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:   -----------------SW----------ADC--
;'-----------------------------------------
;'
;' -------------------PORTB----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------------------------
;'-----------------------------------------
;'
;' ------------------PORTC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ------------TX-LED--LED-LED LED--
;'-----------------------------------------
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
;Setup Serial port
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Now assumes Serial Terminal is operational
;Dim DisplayNewLine, Outdata, Indata  As Byte
;Dim EEPromAddress as Word
;Wait 3 s
	MOVLW	3
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;Do Forever
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "EEPROM Test and Show Results "
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "      "
	MOVLW	LOW STRINGTABLE2
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE2) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;For EEPromAddress = 0 To 15
;LEGACY METHOD
	MOVLW	255
	MOVWF	EEPROMADDRESS
	MOVWF	EEPROMADDRESS_H
GLOBAL	SYSFORLOOP1
SYSFORLOOP1:
	INCF	EEPROMADDRESS,F
	BTFSC	STATUS,2
	INCF	EEPROMADDRESS_H,F
;HSerPrint Hex(EEPromAddress)
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrint " "
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;Next
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSWORDTEMPA
	MOVF	EEPROMADDRESS_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	15
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSFORLOOP1
GLOBAL	SYSFORLOOPEND1
SYSFORLOOPEND1:
;For EEPromAddress = 0 To ChipEEProm -1
	CLRF	EEPROMADDRESS
	CLRF	EEPROMADDRESS_H
GLOBAL	SYSFORLOOP2
SYSFORLOOP2:
;DisplayNewLine = EEPromAddress % 16
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSWORDTEMPA
	MOVF	EEPROMADDRESS_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	16
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPX,W
	MOVWF	DISPLAYNEWLINE
;If DisplayNewLine = 0 Then
	MOVF	DISPLAYNEWLINE,F
	BTFSS	STATUS,2
	GOTO	ENDIF2
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint right(Hex(EEPromAddress_H),1)
	MOVF	EEPROMADDRESS_H,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSSYSINSTRINGHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSSYSINSTRINGHANDLER_H
	MOVLW	1
	MOVWF	SYSCHARCOUNT
	CALL	FN_RIGHT
	MOVLW	LOW RIGHT
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH RIGHT
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrint Hex(EEPromAddress)
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrint ": "
	MOVLW	LOW STRINGTABLE4
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE4) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;End If
GLOBAL	ENDIF2
ENDIF2:
;HSerPrint " "
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;Outdata = Random
;Outdata = 0x55    'If you DON'T believe put your own value here!
;Outdata = 255 - EEPromAddress    'If you DON'T believe put your own value here!
	MOVF	EEPROMADDRESS,W
	SUBLW	255
	MOVWF	OUTDATA
;Writes
;EPWrite ( EEPromAddress, Outdata )
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSEEADDRESS
	MOVF	EEPROMADDRESS_H,W
	MOVWF	SYSEEADDRESS_H
	MOVF	OUTDATA,W
	MOVWF	EEDATA
	CALL	NVMADR_EPWRITE
;Reads
;Indata = 0
	CLRF	INDATA
;EPRead  ( EEPromAddress, Indata )
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSEEADDRESS
	MOVF	EEPROMADDRESS_H,W
	MOVWF	SYSEEADDRESS_H
	CALL	NVMADR_EPREAD
	MOVF	EEDATAVALUE,W
	MOVWF	INDATA
;If Outdata = Indata Then
	SUBWF	OUTDATA,W
	BTFSS	STATUS,2
	GOTO	ELSE3_1
;HSerPrint  Hex(Indata)
	MOVF	INDATA,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;Else
	GOTO	ENDIF3
GLOBAL	ELSE3_1
ELSE3_1:
;HSerPrint  "--"
	MOVLW	LOW STRINGTABLE5
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE5) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;End If
GLOBAL	ENDIF3
ENDIF3:
;Next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	MOVF	EEPROMADDRESS,W
	SUBLW	255
	MOVWF	SYSTEMP1
	CLRF	SYSTEMP2
	MOVF	EEPROMADDRESS_H,W
	SUBWFB	SYSTEMP2,W
	MOVWF	SYSTEMP1_H
	MOVF	SYSTEMP1,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF4
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	EEPROMADDRESS,F
	BTFSC	STATUS,2
	INCF	EEPROMADDRESS_H,F
	GOTO	SYSFORLOOP2
;END IF
GLOBAL	ENDIF4
ENDIF4:
GLOBAL	SYSFORLOOPEND2
SYSFORLOOPEND2:
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint   "End of EEProm Program and Display"
	MOVLW	LOW STRINGTABLE6
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE6) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Wait While SwitchIn <> DOWN
GLOBAL	SYSWAITLOOP1
SYSWAITLOOP1:
	BTFSC	PORTA,3
	GOTO	SYSWAITLOOP1
;Loop
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
;End
	GOTO	BASPROGRAMEND
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

;OVERLOADED SIGNATURE: STRING:BYTE:, SOURCE: USART.H (2317)
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
	GOTO	ENDIF16
;Write Data
;for SysPrintTemp = 1 to PrintLen
	MOVLW	1
	MOVWF	SYSPRINTTEMP
GLOBAL	SYSFORLOOP5
SYSFORLOOP5:
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
	MOVWF	SYSTEMP2
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	CALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF17
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	SYSPRINTTEMP,F
	GOTO	SYSFORLOOP5
;END IF
GLOBAL	ENDIF17
ENDIF17:
GLOBAL	SYSFORLOOPEND5
SYSFORLOOPEND5:
;End If
GLOBAL	ENDIF16
ENDIF16:
;CR
;All Usarts
;--------------------------
;Specific USARTs
;------------------
	RETURN

;********************************************************************************

;SOURCE: USART.H (2525)
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

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (1468)
GLOBAL	HSERSEND294
HSERSEND294:
GLOBAL	HSERSENDUSART1HANDLER
HSERSENDUSART1HANDLER:
;USART_TX_BLOCKING
;Wait While TXIF = Off
GLOBAL	SYSWAITLOOP3
SYSWAITLOOP3:
	BANKSEL	PIR4
	BTFSS	PIR4,6
	GOTO	SYSWAITLOOP3
;Wait until TRMT = 1
GLOBAL	SYSWAITLOOP4
SYSWAITLOOP4:
	BANKSEL	TX1STA
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP4
;TXREG = SerData
	BANKSEL	SERDATA
	MOVF	SERDATA,W
	BANKSEL	TX1REG
	MOVWF	TX1REG
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: 160_SHOWING_EEPROM_DATA_TO_SERIAL_TERMINAL.GCB (37)
GLOBAL	INITPPS
INITPPS:
;Module: Error
;RC4PPS = 0x0013    'TX1 > RC4
	MOVLW	19
	BANKSEL	RC4PPS
	MOVWF	RC4PPS
	BANKSEL	STATUS
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

;SOURCE: USART.H (945)
GLOBAL	INITUSART
INITUSART:
;Set the default value for USART handler - required when more than one USART
;comport = 1
	MOVLW	1
	MOVWF	COMPORT
;PIC USART 1 Init
;Set baud rate for chips with BRG16 bit
;SPBRGH = SPBRGH_TEMP
	MOVLW	3
	BANKSEL	SP1BRGH
	MOVWF	SP1BRGH
;SPBRGL = SPBRGL_TEMP
	MOVLW	64
	MOVWF	SP1BRGL
;BRG16: 16-bit Baud Rate Generator bit
;1 = bsf - 16-bit Baud Rate Generator is used
;0 = bcf - 8-bit Baud Rate Generator is used
;BRG16 = BRG16_TEMP
	BSF	BAUD1CON,3
;Set High Baud Rate Select bit
;BRGH = BRGH_TEMP
	BSF	TX1STA,2
;Enable async and TX mode
;[canskip]SYNC=0
	BCF	TX1STA,4
;[canskip]TXEN=1
	BSF	TX1STA,5
;SPEN=1
	BSF	RC1STA,7
;CREN=1
	BSF	RC1STA,4
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: EEPROM.H (453)
GLOBAL	NVMADR_EPREAD
NVMADR_EPREAD:
;Dim SysEEPromAddress As Word
;SysEEPromAddress = SysEEAddress + 0x7000
	MOVLW	0
	ADDWF	SYSEEADDRESS,W
	MOVWF	SYSEEPROMADDRESS
	MOVLW	112
	ADDWFC	SYSEEADDRESS_H,W
	MOVWF	SYSEEPROMADDRESS_H
;NVMADRH = SysEEPromAddress_h
	BANKSEL	NVMADRH
	MOVWF	NVMADRH
;NVMADRL = SysEEPromAddress
	BANKSEL	SYSEEPROMADDRESS
	MOVF	SYSEEPROMADDRESS,W
	BANKSEL	NVMADRL
	MOVWF	NVMADRL
;NVMREGS = 1
	BSF	NVMCON1,6
;RD = 1
	BSF	NVMCON1,0
;NOP     ' NOPs may be required for latency at high frequencies
	NOP
;NOP
	NOP
;NOP
	NOP
;NOP
	NOP
;EEDataValue = NVMDATL
	MOVF	NVMDATL,W
	BANKSEL	EEDATAVALUE
	MOVWF	EEDATAVALUE
	RETURN

;********************************************************************************

;SOURCE: EEPROM.H (288)
GLOBAL	NVMADR_EPWRITE
NVMADR_EPWRITE:
;dim IntState as bit
;IntState = GIE
	BCF	SYSBITVAR0,1
	BTFSC	INTCON,7
	BSF	SYSBITVAR0,1
;Dim SysEEPromAddress As Word
;ALL 16F NVMREGS Devices Except 18FxxK40/K42
;SysEEPromAddress = SysEEAddress + 0x7000
	MOVLW	0
	ADDWF	SYSEEADDRESS,W
	MOVWF	SYSEEPROMADDRESS
	MOVLW	112
	ADDWFC	SYSEEADDRESS_H,W
	MOVWF	SYSEEPROMADDRESS_H
;NVMADRH =SysEEPromAddress_h
	BANKSEL	NVMADRH
	MOVWF	NVMADRH
;NVMADRL =SysEEPromAddress
	BANKSEL	SYSEEPROMADDRESS
	MOVF	SYSEEPROMADDRESS,W
	BANKSEL	NVMADRL
	MOVWF	NVMADRL
;NVMDATL = EEData
	BANKSEL	EEDATA
	MOVF	EEDATA,W
	BANKSEL	NVMDATL
	MOVWF	NVMDATL
;NVMREGS = 1
	BSF	NVMCON1,6
;FREE =0b'0'
	BCF	NVMCON1,4
;WREN= 0b'1'
	BSF	NVMCON1,2
;GIE = 0
	BCF	INTCON,7
;NVMCON2 = 0x55
	MOVLW	85
	MOVWF	NVMCON2
;NVMCON2 = 0xAA
	MOVLW	170
	MOVWF	NVMCON2
;WR = 1
	BSF	NVMCON1,1
;NOP     ' NOPs may be required for latency at high frequencies
	NOP
;NOP
	NOP
;NOP
	NOP
;NOP
	NOP
;NOP
	NOP
;wait while WR = 1
GLOBAL	SYSWAITLOOP2
SYSWAITLOOP2:
	BTFSC	NVMCON1,1
	GOTO	SYSWAITLOOP2
;WREN= 0b'0'
	BCF	NVMCON1,2
;Restore interrupt to initial  State
;GIE = IntState
	BANKSEL	SYSBITVAR0
	BTFSS	SYSBITVAR0,1
	BCF	INTCON,7
	BTFSC	SYSBITVAR0,1
	BSF	INTCON,7
	RETURN

;********************************************************************************

;SOURCE: STRING.H (374)
GLOBAL	FN_RIGHT
FN_RIGHT:
;Empty input?
;If SysInString(0) = 0 Then
	MOVF	SYSSYSINSTRINGHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,F
	BTFSS	STATUS,2
	GOTO	ENDIF13
;Right(0) = 0
	BANKSEL	SYSRIGHT_0
	CLRF	SYSRIGHT_0
;Exit Function
	BANKSEL	STATUS
	RETURN
;End If
GLOBAL	ENDIF13
ENDIF13:
;Input length too high?
;If SysInString(0) < SysCharCount Then
	MOVF	SYSSYSINSTRINGHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
	MOVWF	FSR0H
	MOVF	SYSCHARCOUNT,W
	SUBWF	INDF0,W
	BTFSC	STATUS,0
	GOTO	ENDIF14
;SysCharCount = SysInString(0)
	MOVF	SYSSYSINSTRINGHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SYSCHARCOUNT
;End If
GLOBAL	ENDIF14
ENDIF14:
;Copy rightmost characters
;SysCharStart = SysInString(0) - SysCharCount
	MOVF	SYSSYSINSTRINGHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
	MOVWF	FSR0H
	MOVF	SYSCHARCOUNT,W
	SUBWF	INDF0,W
	MOVWF	SYSCHARSTART
;For SysStringTemp = 1 To SysCharCount
	MOVLW	1
	MOVWF	SYSSTRINGTEMP
GLOBAL	SYSFORLOOP4
SYSFORLOOP4:
;Right(SysStringTemp) = SysInString(SysCharStart + SysStringTemp)
	MOVF	SYSSTRINGTEMP,W
	ADDWF	SYSCHARSTART,W
	MOVWF	SYSTEMP2
	ADDWF	SYSSYSINSTRINGHANDLER,W
	MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSSYSINSTRINGHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SYSARRAYTEMP2
	MOVWF	SYSARRAYTEMP1
	MOVLW	LOW(RIGHT)
	ADDWF	SYSSTRINGTEMP,W
	MOVWF	FSR0L
	CLRF	SYSTEMP2
	MOVLW	HIGH(RIGHT)
	ADDWFC	SYSTEMP2,W
	MOVWF	FSR0H
	MOVF	SYSARRAYTEMP1,W
	MOVWF	INDF0
;Next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	MOVF	SYSSTRINGTEMP,W
	SUBWF	SYSCHARCOUNT,W
	MOVWF	SYSTEMP2
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	CALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF15
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	SYSSTRINGTEMP,F
	GOTO	SYSFORLOOP4
;END IF
GLOBAL	ENDIF15
ENDIF15:
GLOBAL	SYSFORLOOPEND4
SYSFORLOOPEND4:
;Right(0) = SysCharCount
	MOVF	SYSCHARCOUNT,W
	BANKSEL	SYSRIGHT_0
	MOVWF	SYSRIGHT_0
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

;SOURCE: SYSTEM.H (3104)
GLOBAL	SYSCOMPEQUAL16
SYSCOMPEQUAL16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	MOVF	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	SUBWF	SYSWORDTEMPB, W
;btfss STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test high, exit if false
;movf SysWordTempA_H, W
	MOVF	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	SUBWF	SYSWORDTEMPB_H, W
;btfss STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3413)
GLOBAL	SYSCOMPLESSTHAN16
SYSCOMPLESSTHAN16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	MOVF	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	SUBWF	SYSWORDTEMPB_H,W
;btfss STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;Test high, exit true if less
;movf SysWordTempB_H,W
	MOVF	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	SUBWF	SYSWORDTEMPA_H,W
;btfss STATUS,C
	BTFSS	STATUS,0
;goto SCLT16True
	GOTO	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	MOVF	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	SUBWF	SYSWORDTEMPA,W
;btfsc STATUS,C
	BTFSC	STATUS,0
;return
	RETURN
GLOBAL	SCLT16TRUE
SCLT16TRUE:
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2861)
GLOBAL	SYSDIVSUB16
SYSDIVSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSDIVMULTA
	MOVF	SYSWORDTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	MOVF	SYSWORDTEMPB,W
	MOVWF	SYSDIVMULTB
	MOVF	SYSWORDTEMPB_H,W
	MOVWF	SYSDIVMULTB_H
;SysDivMultX = 0
	CLRF	SYSDIVMULTX
	CLRF	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	MOVF	SYSDIVMULTB,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTB_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF11
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
;exit sub
	RETURN
;end if
GLOBAL	ENDIF11
ENDIF11:
;Main calc routine
;SysDivLoop = 16
	MOVLW	16
	MOVWF	SYSDIVLOOP
GLOBAL	SYSDIV16START
SYSDIV16START:
;set C off
	BCF	STATUS,0
;Rotate SysDivMultA Left
	RLF	SYSDIVMULTA,F
	RLF	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	RLF	SYSDIVMULTX,F
	RLF	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	MOVF	SYSDIVMULTB,W
	SUBWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	SUBWFB	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	BSF	SYSDIVMULTA,0
;If C Off Then
	BTFSC	STATUS,0
	GOTO	ENDIF12
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	ADDWFC	SYSDIVMULTX_H,F
;End If
GLOBAL	ENDIF12
ENDIF12:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv16Start
	GOTO	SYSDIV16START
;SysWordTempA = SysDivMultA
	MOVF	SYSDIVMULTA,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTA_H,W
	MOVWF	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	MOVF	SYSDIVMULTX,W
	MOVWF	SYSWORDTEMPX
	MOVF	SYSDIVMULTX_H,W
	MOVWF	SYSWORDTEMPX_H
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
	RETLW	29
	RETLW	69	;E
	RETLW	69	;E
	RETLW	80	;P
	RETLW	82	;R
	RETLW	79	;O
	RETLW	77	;M
	RETLW	32	; 
	RETLW	84	;T
	RETLW	101	;E
	RETLW	115	;S
	RETLW	116	;T
	RETLW	32	; 
	RETLW	97	;A
	RETLW	110	;N
	RETLW	100	;D
	RETLW	32	; 
	RETLW	83	;S
	RETLW	104	;H
	RETLW	111	;O
	RETLW	119	;W
	RETLW	32	; 
	RETLW	82	;R
	RETLW	101	;E
	RETLW	115	;S
	RETLW	117	;U
	RETLW	108	;L
	RETLW	116	;T
	RETLW	115	;S
	RETLW	32	; 


GLOBAL	STRINGTABLE2
STRINGTABLE2:
	RETLW	6
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 


GLOBAL	STRINGTABLE3
STRINGTABLE3:
	RETLW	1
	RETLW	32	; 


GLOBAL	STRINGTABLE4
STRINGTABLE4:
	RETLW	2
	RETLW	58	;:
	RETLW	32	; 


GLOBAL	STRINGTABLE5
STRINGTABLE5:
	RETLW	2
	RETLW	45	;-
	RETLW	45	;-


GLOBAL	STRINGTABLE6
STRINGTABLE6:
	RETLW	33
	RETLW	69	;E
	RETLW	110	;N
	RETLW	100	;D
	RETLW	32	; 
	RETLW	111	;O
	RETLW	102	;F
	RETLW	32	; 
	RETLW	69	;E
	RETLW	69	;E
	RETLW	80	;P
	RETLW	114	;R
	RETLW	111	;O
	RETLW	109	;M
	RETLW	32	; 
	RETLW	80	;P
	RETLW	114	;R
	RETLW	111	;O
	RETLW	103	;G
	RETLW	114	;R
	RETLW	97	;A
	RETLW	109	;M
	RETLW	32	; 
	RETLW	97	;A
	RETLW	110	;N
	RETLW	100	;D
	RETLW	32	; 
	RETLW	68	;D
	RETLW	105	;I
	RETLW	115	;S
	RETLW	112	;P
	RETLW	108	;L
	RETLW	97	;A
	RETLW	121	;Y


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
	GOTO	ENDIF5
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
GLOBAL	ENDIF5
ENDIF5:
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
	GOTO	ENDIF7
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
GLOBAL	ENDIF7
ENDIF7:
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
