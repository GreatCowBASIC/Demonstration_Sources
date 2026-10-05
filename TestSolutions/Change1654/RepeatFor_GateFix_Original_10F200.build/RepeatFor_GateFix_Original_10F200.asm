;Program compiled by GCBASIC (2026.10.01 (Windows 64 bit) : Build 1654) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-10-04 CRC170
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_GateFix_Original_10F200.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : "C:\GCstudio\picas\pic-as\bin\pic-as.exe"
;   Programmer       : 
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_GateFix_Original_10F200.build\RepeatFor_GateFix_Original_10F200.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=10F200, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_GateFix_Original_10F200.gcb"
 SUBTITLE    "10-05-2026 12:42:35"
#include <P10F200.inc>
 __CONFIG _MCLRE_OFF & _CP_OFF & _WDTE_OFF & _OSC_INTRC

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
DELAYTEMP                        EQU      16          ; 0X10 (SA)
DELAYTEMP2                       EQU      17          ; 0X11 (SA)
OPTION_REG                       EQU      18          ; 0X12 (SA)
OVERFLOWS                        EQU      19          ; 0X13 (SA)
SYSBITVAR0                       EQU      20          ; 0X14 (SA)
SYSREPEATFORCMP1                 EQU      23          ; 0X17 (SA)
SYSREPEATFORCOUNTER1             EQU      24          ; 0X18 (SA)
SYSREPEATFORCOUNTER1_H           EQU      25          ; 0X19 (SA)
SYSWAITTEMPUS                    EQU      21          ; 0X15 (SA)
SYSWAITTEMPUS_H                  EQU      22          ; 0X16 (SA)

;********************************************************************************

;VECTORS
;PROGRAM_MEMORY_PAGE: 0
	ORG	0
;INDIRECT JUMPS TO ALLOW CALLS TO SECOND HALF OF PAGE
	GOTO	BASPROGRAMSTART
INITSYS
	GOTO	SYSIND_INITSYS

BASPROGRAMSTART
;CALL INITIALISATION ROUTINES
	CALL	INITSYS

;START_OF_THE_MAIN_PROGRAM
;Repeat For test (Change 1654): The original GATE FIX example, unmodified, on 10F200
;Expect: compiles, and the Repeat For construct runs exactly the requested 790,047 microseconds worth of clock cycles
;(checked by simulating the generated assembly instruction by instruction)
;Dim Overflows As Byte
;Dim TMR1IF As Bit
;Repeat For 790047 us
SYSREPEATFORSETUP1
	CLRF	SYSREPEATFORCOUNTER1
	CLRF	SYSREPEATFORCOUNTER1_H
SYSREPEATFORLOOP1
;Wait 1009 us
	MOVLW	1
	MOVWF	DELAYTEMP2
DELAYUSO1
	CLRF	DELAYTEMP
DELAYUS1
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS1
	DECFSZ	DELAYTEMP2,F
	GOTO	DELAYUSO1
	MOVLW	79
	MOVWF	DELAYTEMP
DELAYUS2
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS2
;nop
	NOP
;If TMR1IF = 1 Then
	BTFSS	SYSBITVAR0,0
	GOTO	ENDIF1
;Overflows = Overflows + 1
	INCF	OVERFLOWS,F
;TMR1IF = 0
	BCF	SYSBITVAR0,0
;End If
ENDIF1
;End Repeat
SYSREPEATFORPAD1
	NOP
SYSREPEATFORTAIL1
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
	BTFSS	STATUS,Z
	GOTO	SYSREPEATFORLOOP1
SYSREPEATFORLOOPEND1
	MOVLW	11
	MOVWF	DELAYTEMP
DELAYUS4
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS4
	NOP
	NOP
SYSREPEATFORDONE1
;Do
SYSDOLOOP_S1
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1
BASPROGRAMEND
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: SYSTEM.H (211)
SYSIND_INITSYS
;This loads the saved calibration data from the last flash memory location at POR or any time the chip is reset.
;movwf osccal
	MOVWF	OSCCAL
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
;The MCU is a chip family ChipNameStr, so, set GPIO.2 to digital by clear T0CS bit
;Dim option_reg
;movlw b'11000111'
	MOVLW	199
;option
	OPTION
;option_reg = b'11000111'
	MOVLW	199
	MOVWF	OPTION_REG
;Turn off all ports
;GPIO = 0
	CLRF	GPIO
;ClearRAM
;Macro Source: system.h (1838)
;No code. User has not included <clearram.h>
	RETLW	0

;********************************************************************************


 END
