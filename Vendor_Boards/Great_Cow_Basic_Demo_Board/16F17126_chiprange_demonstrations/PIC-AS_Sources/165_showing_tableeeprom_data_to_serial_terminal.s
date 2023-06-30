;Program compiled by GCBASIC (1.00.00 Release Candidate 2022-11-06 (Windows 64 bit) : Build 1189) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F17126
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17126_chiprange_demonstrations\165_showing_tableeeprom_data_to_serial_terminal.s"
 SUBTITLE    "11-14-2022"

; Reverse lookup file(s)
; C:\Program Files\Microchip\xc8\v2.40\pic\include\proc\pic16f17126.inc
; C:\Program Files\Microchip\xc8\v2.40\pic\dat\cfgmap\16f17126.cfgmap
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
GLOBAL	EEADDRESS
 EEADDRESS                        EQU 32          ; 0X20
GLOBAL	EEDATA
 EEDATA                           EQU 33          ; 0X21
GLOBAL	EEDATAVALUE
 EEDATAVALUE                      EQU 34          ; 0X22
GLOBAL	SOMEVAR
 SOMEVAR                          EQU 35          ; 0X23
GLOBAL	SYSBITVAR0
 SYSBITVAR0                       EQU 36          ; 0X24
GLOBAL	SYSEEADDRESS
 SYSEEADDRESS                     EQU 37          ; 0X25
GLOBAL	SYSEEADDRESS_H
 SYSEEADDRESS_H                   EQU 38          ; 0X26
GLOBAL	SYSEEPROMADDRESS
 SYSEEPROMADDRESS                 EQU 39          ; 0X27
GLOBAL	SYSEEPROMADDRESS_H
 SYSEEPROMADDRESS_H               EQU 40          ; 0X28
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73
GLOBAL	SYSWAITTEMPS
 SYSWAITTEMPS                     EQU 116          ; 0X74
GLOBAL	TABLELOC
 TABLELOC                         EQU 41          ; 0X29

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
;''  This demonstration shows the use of EEProm values created from a Table..
;''
;'' This will show the value of the EEPROM on the serial Terminal.
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.00
;''@date    31.10.2022
;----- Configuration
;Chip Settings.
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
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim DisplayNewLine, Outdata, Indata  As Byte
;Dim EEPromAddress as Word
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;Read table item
;Must use ReadTable and a variable for the index, or the table will not be downloaded to EEPROM
;Dim TableLoc, SomeVar as Byte
;TableLoc = 2
	MOVLW	2
	MOVWF	TABLELOC
;ReadTable TestDataSource, TableLoc, SomeVar
	MOVLW	LOW(TABLETESTDATASOURCE)
	ADDWF	TABLELOC,W
	MOVWF	EEADDRESS
	CALL	NVMADR_EPREAD
	MOVF	EEDATAVALUE,W
	MOVWF	SOMEVAR
;Write to table , this is not required
;EPWrite 0x08, 0x55
	MOVLW	8
	MOVWF	SYSEEADDRESS
	CLRF	SYSEEADDRESS_H
	MOVLW	85
	MOVWF	EEDATA
	CALL	NVMADR_EPWRITE
;Table of values to write to EEPROM
;EEPROM location 0 will store length of table
;Subsequent locations will each store a value
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
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F171xx MCU family
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
GLOBAL	SYSWAITLOOP1
SYSWAITLOOP1:
	BTFSC	NVMCON1,1
	GOTO	SYSWAITLOOP1
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
;********************************************************************************

; DATA LOOKUP TABLES (DATA MEMORY)
	ORG	0XF000
GLOBAL	TABLETESTDATASOURCE
TABLETESTDATASOURCE:
	DB	7, 1, 2, 3, 4, 5, 6, 7
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
