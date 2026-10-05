;'Program compiled by GCBASIC (2026.10.01 (Windows 64 bit) : Build 1654) for Microchip PIC-AS using FreeBASIC 1.07.1/2026-10-04 CRC170
;'  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;'  
;'  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;'  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;'or, email:
;'   evanvennn at users dot sourceforge dot net
;'********************************************************************************
;'   Installation Dir : C:\GCstudio\gcbasic
;'   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_GateFix_Original_12F1822.gcb
;'   Setting file     : C:\GCstudio\gcbasic\use.ini
;'   Preserve mode    : 2
;'   Assembler        : "C:\GCstudio\picas\pic-as\bin\pic-as.exe"
;'   Programmer       : 
;'   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_GateFix_Original_12F1822.build\RepeatFor_GateFix_Original_12F1822.asm
;'   Float Capability : 1
;'********************************************************************************

;'Set up the assembler options (Chip specs and other options)
;'PROCESSOR  12F1822
;'PROG       2048
;'RAM        128
;'EEPROM     256
;'HWBPCOUNT  1
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_GateFix_Original_12F1822.gcb"
 SUBTITLE    "10-05-2026 12:42:11"

;' DPF Reverse lookup file(s)
;' C:\Users\admin\.mchp_packs\8bit PIC\PIC12-16F1xxx_DFP\1.9.258\xc8\pic\include\proc\pic12f1822.inc
;' C:\Users\admin\.mchp_packs\8bit PIC\PIC12-16F1xxx_DFP\1.9.258\xc8\pic\dat\cfgdata\12f1822.cfgdata
;' DPF PIC file
;'   C:\Users\admin\.mchp_packs\8bit PIC\PIC12-16F1xxx_DFP\1.9.258\edc\PIC12F1822.PIC

;'********************************************************************************

;'********************************************************************************
;'Explicit CONFIG
 CONFIG FCMEN=ON                                 ;C1 Reverselookup FCMEN = ON
 CONFIG CLKOUTEN=OFF                             ;C1 Reverselookup CLKOUTEN = OFF
 CONFIG CPD=OFF                                  ;C1 Reverselookup CPD = OFF
 CONFIG CP=OFF                                   ;C1 Reverselookup CP = OFF
 CONFIG MCLRE=OFF                                ;C1 Reverselookup MCLRE = OFF
 CONFIG WDTE=OFF                                 ;C1 Reverselookup WDTE = OFF
 CONFIG FOSC=INTOSC                              ;C1 Reverselookup FOSC = INTOSC
 CONFIG LVP=OFF                                  ;C1 Reverselookup LVP = OFF
 CONFIG PLLEN=OFF                                ;C1 Reverselookup PLLEN = OFF
 CONFIG WRT=OFF                                  ;C1 Reverselookup WRT = OFF
;'Inferred CONFIG


;'********************************************************************************
;' The XC8 xc.inc include file.  This MUST be placed after the CONFIG statements.

 #include <xc.inc>

;'********************************************************************************

;'Set aside RAM memory locations for variables. All variables are global.
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 112          ; 0X70 (SA)
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 113          ; 0X71 (SA)
GLOBAL	OVERFLOWS
 OVERFLOWS                        EQU 32          ; 0X20
GLOBAL	SYSREPEATFORCMP1
 SYSREPEATFORCMP1                 EQU 33          ; 0X21
GLOBAL	SYSREPEATFORCOUNTER1
 SYSREPEATFORCOUNTER1             EQU 34          ; 0X22
GLOBAL	SYSREPEATFORCOUNTER1_H
 SYSREPEATFORCOUNTER1_H           EQU 35          ; 0X23
GLOBAL	SYSWAITTEMPUS
 SYSWAITTEMPUS                    EQU 117          ; 0X75 (SA)
GLOBAL	SYSWAITTEMPUS_H
 SYSWAITTEMPUS_H                  EQU 118          ; 0X76 (SA)

;'********************************************************************************

 PSECT   PROGMEM0,delta=2, abs
 RESETVEC:
;'VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	GOTO	BASPROGRAMSTART
	ORG	4
	RETFIE

;'********************************************************************************

;'PROGRAM_MEMORY_PAGE: 0
	ORG	5
GLOBAL	BASPROGRAMSTART
BASPROGRAMSTART:
;'CALL INITIALISATION ROUTINES
	CALL	INITSYS

;'START_OF_THE_MAIN_PROGRAM
;'REPEAT FOR TEST (CHANGE 1654): THE ORIGINAL GATE FIX EXAMPLE, UNMODIFIED, ON 12F1822
;'EXPECT: COMPILES, AND THE REPEAT FOR CONSTRUCT RUNS EXACTLY THE REQUESTED 790,047 MICROSECONDS WORTH OF CLOCK CYCLES
;'(CHECKED BY SIMULATING THE GENERATED ASSEMBLY INSTRUCTION BY INSTRUCTION)
;'DIM OVERFLOWS AS BYTE
;'REPEAT FOR 790047 US
GLOBAL	SYSREPEATFORSETUP1
SYSREPEATFORSETUP1:
	CLRF	SYSREPEATFORCOUNTER1
	CLRF	SYSREPEATFORCOUNTER1_H
GLOBAL	SYSREPEATFORLOOP1
SYSREPEATFORLOOP1:
;'WAIT 1009 US
	MOVLW	2
	MOVWF	DELAYTEMP2
GLOBAL	DELAYUSO1
DELAYUSO1:
	CLRF	DELAYTEMP
GLOBAL	DELAYUS1
DELAYUS1:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS1
	DECFSZ	DELAYTEMP2,F
	GOTO	DELAYUSO1
	MOVLW	158
	MOVWF	DELAYTEMP
GLOBAL	DELAYUS2
DELAYUS2:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS2
;'IF TMR1IF = 1 THEN
	BTFSS	PIR1,0
	GOTO	ENDIF1
;'OVERFLOWS = OVERFLOWS + 1
	INCF	OVERFLOWS,F
;'TMR1IF = 0
	BCF	PIR1,0
;'END IF
GLOBAL	ENDIF1
ENDIF1:
;'END REPEAT
GLOBAL	SYSREPEATFORPAD1
SYSREPEATFORPAD1:
	GOTO	$+1
GLOBAL	SYSREPEATFORTAIL1
SYSREPEATFORTAIL1:
	MOVLW	1
	ADDWF	SYSREPEATFORCOUNTER1,F
	MOVLW	0
	ADDWFC	SYSREPEATFORCOUNTER1_H,F
	MOVF	SYSREPEATFORCOUNTER1,W
	XORLW	8
	MOVWF	SYSREPEATFORCMP1
	MOVF	SYSREPEATFORCOUNTER1_H,W
	XORLW	3
	IORWF	SYSREPEATFORCMP1,F
	BTFSS	STATUS,2
	GOTO	SYSREPEATFORLOOP1
GLOBAL	SYSREPEATFORLOOPEND1
SYSREPEATFORLOOPEND1:
	MOVLW	52
	MOVWF	DELAYTEMP
GLOBAL	DELAYUS3
DELAYUS3:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS3
GLOBAL	SYSREPEATFORDONE1
SYSREPEATFORDONE1:
;'DO
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;'LOOP
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;'********************************************************************************

;'SOURCE: SYSTEM.H (211)
GLOBAL	INITSYS
INITSYS:
;'HANDLE CHIPS WITH ONLY 2 IRCF BITS (IRCF1, IRCF0) LIKE 16F720/721 AND ITS LF SIBLINGS
;'16F72X HAS 500KHZ INTOSC WITH 32X PLL OPTION AND POSTSCALER (÷1,2,4,8)
;'CHIPSUBFAMILY 15001 (16F152XX) HAS OSCCON WITH NOSC/NDIV BITS BUT NO IRCF BITS,
;'SO IT MUST BE HANDLED OUTSIDE THE IRCF BASED TYPE 103 SECTION
;'TYPE 103: CHIPS WITHOUT SPLLEN, IRCF3, BUT MUST HAVE AT LEAST IRCF2 (EXCLUDE 2-BIT IRCF CHIPS)
;'OSCCON TYPE IS 105 'BIT(SPLLEN) OR BIT(IRCF3) AND NOBIT(INTSRC) AND IFDEF BIT(IRCF3)
;'EQUATES TO OSCCON = OSCCON AND B'10000111' &  OSCCON = OSCCON OR B'01110000'
;'= 8MHZ
;'SET IRCF3 ON
	BANKSEL	OSCCON
	BSF	OSCCON,6
;'SET IRCF2 ON
	BSF	OSCCON,5
;'SET IRCF1 ON
	BSF	OSCCON,4
;'SET IRCF0 OFF
	BCF	OSCCON,3
;'SET SPLLEN OFF
	BCF	OSCCON,7
;'_COMPLETE_THE_CHIP_SETUP_OF_BSR_ADCS_ANSEL_AND_OTHER_KEY_SETUP_REGISTERS_OR_REGISTER_BITS
;'ENSURE ALL PORTS ARE SET FOR DIGITAL I/O AND, TURN OFF A/D
;'SET ADFM OFF
	BCF	ADCON1,7
;'SWITCH OFF A/D VAR(ADCON0)
;'SET ADCON0.ADON OFF
	BCF	ADCON0,0
;'ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA
;'SET COMPARATOR REGISTER BITS FOR MANY MCUS WITH REGISTER CM2CON0
;'C1ON = 0
	BANKSEL	CM1CON0
	BCF	CM1CON0,7
;'TURN OFF ALL PORTS
;'GPIO = 0
	BANKSEL	PORTA
	CLRF	PORTA
;'PORTA = 0
	CLRF	PORTA
;'CLEARRAM
;'MACRO SOURCE: SYSTEM.H (1838)
;'NO CODE. USER HAS NOT INCLUDED <CLEARRAM.H>
	RETURN

;'********************************************************************************

;'
;' Declare Power-On-Reset entry point
;'
 END     RESETVEC
