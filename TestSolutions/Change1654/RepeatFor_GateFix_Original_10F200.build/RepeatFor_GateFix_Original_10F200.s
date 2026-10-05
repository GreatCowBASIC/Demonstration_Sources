;'Program compiled by GCBASIC (2026.10.01 (Windows 64 bit) : Build 1654) for Microchip PIC-AS using FreeBASIC 1.07.1/2026-10-04 CRC170
;'  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;'  
;'  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;'  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;'or, email:
;'   evanvennn at users dot sourceforge dot net
;'********************************************************************************
;'   Installation Dir : C:\GCstudio\gcbasic
;'   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_GateFix_Original_10F200.gcb
;'   Setting file     : C:\GCstudio\gcbasic\use.ini
;'   Preserve mode    : 2
;'   Assembler        : "C:\GCstudio\picas\pic-as\bin\pic-as.exe"
;'   Programmer       : 
;'   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_GateFix_Original_10F200.build\RepeatFor_GateFix_Original_10F200.asm
;'   Float Capability : 1
;'********************************************************************************

;'Set up the assembler options (Chip specs and other options)
;'PROCESSOR  10F200
;'PROG       256
;'RAM        16
;'EEPROM     0
;'HWBPCOUNT  1
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_GateFix_Original_10F200.gcb"
 SUBTITLE    "10-05-2026 12:42:38"

;' DPF Reverse lookup file(s)
;' C:\Users\admin\.mchp_packs\8bit PIC\PIC10-12Fxxx_DFP\1.9.189\xc8\pic\include\proc\pic10f200.inc
;' C:\Users\admin\.mchp_packs\8bit PIC\PIC10-12Fxxx_DFP\1.9.189\xc8\pic\dat\cfgdata\10f200.cfgdata
;' DPF PIC file
;'   C:\Users\admin\.mchp_packs\8bit PIC\PIC10-12Fxxx_DFP\1.9.189\edc\PIC10F200.PIC

;'********************************************************************************

;'********************************************************************************
;'Explicit CONFIG
 CONFIG MCLRE=OFF                                ;C1 Reverselookup MCLRE = OFF
 CONFIG CP=OFF                                   ;C1 Reverselookup CP = OFF
 CONFIG WDTE=OFF                                 ;C1 Reverselookup WDTE = OFF
 CONFIG OSC=IntRC                                ;C1 Reverselookup OSC = INTRC
;'Inferred CONFIG


;'********************************************************************************
;' The XC8 xc.inc include file.  This MUST be placed after the CONFIG statements.

 #include <xc.inc>

;'********************************************************************************

;'Set aside RAM memory locations for variables. All variables are global.
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 16          ; 0X10 (SA)
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 17          ; 0X11 (SA)
GLOBAL	OPTION_REG
 OPTION_REG                       EQU 18          ; 0X12 (SA)
GLOBAL	OVERFLOWS
 OVERFLOWS                        EQU 19          ; 0X13 (SA)
GLOBAL	SYSBITVAR0
 SYSBITVAR0                       EQU 20          ; 0X14 (SA)
GLOBAL	SYSREPEATFORCMP1
 SYSREPEATFORCMP1                 EQU 23          ; 0X17 (SA)
GLOBAL	SYSREPEATFORCOUNTER1
 SYSREPEATFORCOUNTER1             EQU 24          ; 0X18 (SA)
GLOBAL	SYSREPEATFORCOUNTER1_H
 SYSREPEATFORCOUNTER1_H           EQU 25          ; 0X19 (SA)
GLOBAL	SYSWAITTEMPUS
 SYSWAITTEMPUS                    EQU 21          ; 0X15 (SA)
GLOBAL	SYSWAITTEMPUS_H
 SYSWAITTEMPUS_H                  EQU 22          ; 0X16 (SA)

;'********************************************************************************

 PSECT   PROGMEM0,delta=2, abs
 RESETVEC:
;'VECTORS
;'PROGRAM_MEMORY_PAGE: 0
	ORG	0
;'INDIRECT JUMPS TO ALLOW CALLS TO SECOND HALF OF PAGE
	GOTO	BASPROGRAMSTART
GLOBAL	INITSYS
INITSYS:
	GOTO	SYSIND_INITSYS

GLOBAL	BASPROGRAMSTART
BASPROGRAMSTART:
;'CALL INITIALISATION ROUTINES
	CALL	INITSYS

;'START_OF_THE_MAIN_PROGRAM
;'REPEAT FOR TEST (CHANGE 1654): THE ORIGINAL GATE FIX EXAMPLE, UNMODIFIED, ON 10F200
;'EXPECT: COMPILES, AND THE REPEAT FOR CONSTRUCT RUNS EXACTLY THE REQUESTED 790,047 MICROSECONDS WORTH OF CLOCK CYCLES
;'(CHECKED BY SIMULATING THE GENERATED ASSEMBLY INSTRUCTION BY INSTRUCTION)
;'DIM OVERFLOWS AS BYTE
;'DIM TMR1IF AS BIT
;'REPEAT FOR 790047 US
GLOBAL	SYSREPEATFORSETUP1
SYSREPEATFORSETUP1:
	CLRF	SYSREPEATFORCOUNTER1
	CLRF	SYSREPEATFORCOUNTER1_H
GLOBAL	SYSREPEATFORLOOP1
SYSREPEATFORLOOP1:
;'WAIT 1009 US
	MOVLW	1
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
	MOVLW	79
	MOVWF	DELAYTEMP
GLOBAL	DELAYUS2
DELAYUS2:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS2
;'NOP
	NOP
;'IF TMR1IF = 1 THEN
	BTFSS	SYSBITVAR0,0
	GOTO	ENDIF1
;'OVERFLOWS = OVERFLOWS + 1
	INCF	OVERFLOWS,F
;'TMR1IF = 0
	BCF	SYSBITVAR0,0
;'END IF
GLOBAL	ENDIF1
ENDIF1:
;'END REPEAT
GLOBAL	SYSREPEATFORPAD1
SYSREPEATFORPAD1:
	NOP
GLOBAL	SYSREPEATFORTAIL1
SYSREPEATFORTAIL1:
	MOVLW	1
	ADDWF	SYSREPEATFORCOUNTER1,F
	CLRF	SYSREPEATFORCMP1
	RLF	SYSREPEATFORCMP1,F
	MOVF	SYSREPEATFORCMP1,W
	ADDWF	SYSREPEATFORCOUNTER1_H,F
	MOVF	SYSREPEATFORCOUNTER1,W
	XORLW	255
	MOVWF	SYSREPEATFORCMP1
	MOVF	SYSREPEATFORCOUNTER1_H,W
	XORLW	2
	IORWF	SYSREPEATFORCMP1,F
	BTFSS	STATUS,2
	GOTO	SYSREPEATFORLOOP1
GLOBAL	SYSREPEATFORLOOPEND1
SYSREPEATFORLOOPEND1:
	MOVLW	11
	MOVWF	DELAYTEMP
GLOBAL	DELAYUS4
DELAYUS4:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS4
	NOP
	NOP
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
GLOBAL	SYSIND_INITSYS
SYSIND_INITSYS:
;'THIS LOADS THE SAVED CALIBRATION DATA FROM THE LAST FLASH MEMORY LOCATION AT POR OR ANY TIME THE CHIP IS RESET.
;'MOVWF OSCCAL
	MOVWF	OSCCAL
;'_COMPLETE_THE_CHIP_SETUP_OF_BSR_ADCS_ANSEL_AND_OTHER_KEY_SETUP_REGISTERS_OR_REGISTER_BITS
;'THE MCU IS A CHIP FAMILY CHIPNAMESTR, SO, SET GPIO.2 TO DIGITAL BY CLEAR T0CS BIT
;'DIM OPTION_REG
;'MOVLW B'11000111'
	MOVLW	199
;'OPTION
	OPTION
;'OPTION_REG = B'11000111'
	MOVLW	199
	MOVWF	OPTION_REG
;'TURN OFF ALL PORTS
;'GPIO = 0
	CLRF	GPIO
;'CLEARRAM
;'MACRO SOURCE: SYSTEM.H (1838)
;'NO CODE. USER HAS NOT INCLUDED <CLEARRAM.H>
	RETLW	0

;'********************************************************************************

;'
;' Declare Power-On-Reset entry point
;'
 END     RESETVEC
