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
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18075_chiprange_demonstrations\160_showing_eeprom_data_to_serial_terminal.s"
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
GLOBAL	HSERPRINTCRLFCOUNT
 HSERPRINTCRLFCOUNT               EQU 37          ; 0X25
GLOBAL	INDATA
 INDATA                           EQU 38          ; 0X26
GLOBAL	OUTDATA
 OUTDATA                          EQU 39          ; 0X27
GLOBAL	PRINTLEN
 PRINTLEN                         EQU 40          ; 0X28
GLOBAL	SERDATA
 SERDATA                          EQU 41          ; 0X29
GLOBAL	STRINGPOINTER
 STRINGPOINTER                    EQU 42          ; 0X2A
GLOBAL	SYSBITVAR0
 SYSBITVAR0                       EQU 43          ; 0X2B
GLOBAL	SYSBYTETEMPA
 SYSBYTETEMPA                     EQU 117          ; 0X75
GLOBAL	SYSBYTETEMPB
 SYSBYTETEMPB                     EQU 121          ; 0X79
GLOBAL	SYSBYTETEMPX
 SYSBYTETEMPX                     EQU 112          ; 0X70
GLOBAL	SYSDIVLOOP
 SYSDIVLOOP                       EQU 116          ; 0X74
GLOBAL	SYSEEADDRESS
 SYSEEADDRESS                     EQU 44          ; 0X2C
GLOBAL	SYSEEADDRESS_H
 SYSEEADDRESS_H                   EQU 45          ; 0X2D
GLOBAL	SYSEEPROMADDRESS
 SYSEEPROMADDRESS                 EQU 46          ; 0X2E
GLOBAL	SYSEEPROMADDRESS_H
 SYSEEPROMADDRESS_H               EQU 47          ; 0X2F
GLOBAL	SYSPRINTDATAHANDLER
 SYSPRINTDATAHANDLER              EQU 48          ; 0X30
GLOBAL	SYSPRINTDATAHANDLER_H
 SYSPRINTDATAHANDLER_H            EQU 49          ; 0X31
GLOBAL	SYSPRINTTEMP
 SYSPRINTTEMP                     EQU 50          ; 0X32
GLOBAL	SYSREPEATTEMP1
 SYSREPEATTEMP1                   EQU 51          ; 0X33
GLOBAL	SYSSTRINGA
 SYSSTRINGA                       EQU 119          ; 0X77
GLOBAL	SYSSTRINGA_H
 SYSSTRINGA_H                     EQU 120          ; 0X78
GLOBAL	SYSSTRINGTEMP
 SYSSTRINGTEMP                    EQU 52          ; 0X34
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 53          ; 0X35
GLOBAL	SYSTEMP2
 SYSTEMP2                         EQU 54          ; 0X36
GLOBAL	SYSVALTEMP
 SYSVALTEMP                       EQU 55          ; 0X37
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73
GLOBAL	_HEXPICAS
 _HEXPICAS                        EQU 124          ; 0X7C

;********************************************************************************

;ALIAS VARIABLES
GLOBAL	AFSR0
 AFSR0                            EQU 4
GLOBAL	AFSR0_H
 AFSR0_H                          EQU 5
GLOBAL	SYS_HEXPICAS_0
 SYS_HEXPICAS_0                   EQU 124
GLOBAL	SYS_HEXPICAS_1
 SYS_HEXPICAS_1                   EQU 125
GLOBAL	SYS_HEXPICAS_2
 SYS_HEXPICAS_2                   EQU 126

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
;''@version 1.01
;''@date    15/09/2022
;----- Configuration
;Chip Settings.
;Generated by PIC PPS Tool for GCBASIC
;PPS Tool version: 0.0.6.2
;PinManager data: Not available (3)
;Generated for 16F18075
;
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ----------------------------ADC--
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
;Dim EEPromAddress, DisplayNewLine, Outdata, Indata  As Byte
;Do Forever
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "EEPROM Test and Show first 128 bytes EEProm Results"
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
;Set LEDD1 Off
	BCF	LATB,1
;Set LEDD2 Off
	BCF	LATB,2
;HSerPrint "     "
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
GLOBAL	SYSFORLOOP1
SYSFORLOOP1:
	INCF	EEPROMADDRESS,F
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
	MOVLW	15
	SUBWF	EEPROMADDRESS,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
GLOBAL	SYSFORLOOPEND1
SYSFORLOOPEND1:
;For EEPromAddress = 0 To 127
;LEGACY METHOD
	MOVLW	255
	MOVWF	EEPROMADDRESS
GLOBAL	SYSFORLOOP2
SYSFORLOOP2:
	INCF	EEPROMADDRESS,F
;DisplayNewLine = EEPromAddress % 16
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSBYTETEMPA
	MOVLW	16
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPX,W
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
	CLRF	SYSEEADDRESS_H
	MOVF	OUTDATA,W
	MOVWF	EEDATA
	CALL	NVMADR_EPWRITE
;Reads
;EPRead  ( EEPromAddress, Indata )
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSEEADDRESS
	CLRF	SYSEEADDRESS_H
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
;HSerPrint  "??"
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
	MOVLW	127
	SUBWF	EEPROMADDRESS,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP2
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
;Set LEDD2 On
	BSF	LATB,2
;Set LEDD1 On
	BSF	LATB,1
;Wait While SwitchIn = On
GLOBAL	SYSWAITLOOP1
SYSWAITLOOP1:
	BTFSC	PORTB,5
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
	GOTO	ENDIF11
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
	GOTO	ENDIF12
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	SYSPRINTTEMP,F
	GOTO	SYSFORLOOP4
;END IF
GLOBAL	ENDIF12
ENDIF12:
GLOBAL	SYSFORLOOPEND4
SYSFORLOOPEND4:
;End If
GLOBAL	ENDIF11
ENDIF11:
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

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (974)
GLOBAL	HSERSEND294
HSERSEND294:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W
	BTFSS	STATUS,2
	GOTO	ENDIF13
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
GLOBAL	ENDIF13
ENDIF13:
	RETURN

;********************************************************************************

;SOURCE: 160_SHOWING_EEPROM_DATA_TO_SERIAL_TERMINAL.GCB (37)
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

;SOURCE: SYSTEM.H (2793)
GLOBAL	SYSDIVSUB
SYSDIVSUB:
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	MOVF	SYSBYTETEMPB, F
;btfsc STATUS, Z
	BTFSC	STATUS,2
;return
	RETURN
;Main calc routine
;SysByteTempX = 0
	CLRF	SYSBYTETEMPX
;SysDivLoop = 8
	MOVLW	8
	MOVWF	SYSDIVLOOP
GLOBAL	SYSDIV8START
SYSDIV8START:
;bcf STATUS, C
	BCF	STATUS,0
;rlf SysByteTempA, F
	RLF	SYSBYTETEMPA, F
;rlf SysByteTempX, F
	RLF	SYSBYTETEMPX, F
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;subwf SysByteTempX, F
	SUBWF	SYSBYTETEMPX, F
;bsf SysByteTempA, 0
	BSF	SYSBYTETEMPA, 0
;btfsc STATUS, C
	BTFSC	STATUS,0
;goto Div8NotNeg
	GOTO	DIV8NOTNEG
;bcf SysByteTempA, 0
	BCF	SYSBYTETEMPA, 0
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;addwf SysByteTempX, F
	ADDWF	SYSBYTETEMPX, F
GLOBAL	DIV8NOTNEG
DIV8NOTNEG:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv8Start
	GOTO	SYSDIV8START
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
	RETLW	51
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
	RETLW	102	;F
	RETLW	105	;I
	RETLW	114	;R
	RETLW	115	;S
	RETLW	116	;T
	RETLW	32	; 
	RETLW	49	;1
	RETLW	50	;2
	RETLW	56	;8
	RETLW	32	; 
	RETLW	98	;B
	RETLW	121	;Y
	RETLW	116	;T
	RETLW	101	;E
	RETLW	115	;S
	RETLW	32	; 
	RETLW	69	;E
	RETLW	69	;E
	RETLW	80	;P
	RETLW	114	;R
	RETLW	111	;O
	RETLW	109	;M
	RETLW	32	; 
	RETLW	82	;R
	RETLW	101	;E
	RETLW	115	;S
	RETLW	117	;U
	RETLW	108	;L
	RETLW	116	;T
	RETLW	115	;S


GLOBAL	STRINGTABLE2
STRINGTABLE2:
	RETLW	5
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
	RETLW	63	;?
	RETLW	63	;?


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
	MOVWF	SYS_HEXPICAS_0
;dim SysStringTemp as byte
;Low nibble
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
;_HexPICAS(2) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W
	MOVWF	SYS_HEXPICAS_2
;Get high nibble
;For SysStringTemp = 1 to 4
;LEGACY METHOD
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
	MOVWF	SYS_HEXPICAS_1
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
