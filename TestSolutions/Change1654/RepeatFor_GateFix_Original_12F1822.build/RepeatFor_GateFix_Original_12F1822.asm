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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_GateFix_Original_12F1822.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : "C:\GCstudio\picas\pic-as\bin\pic-as.exe"
;   Programmer       : 
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_GateFix_Original_12F1822.build\RepeatFor_GateFix_Original_12F1822.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=12F1822, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_GateFix_Original_12F1822.gcb"
 SUBTITLE    "10-05-2026 12:42:08"
#include <P12F1822.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _CPD_OFF & _CP_OFF & _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF & _WRT_OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
DELAYTEMP                        EQU     112          ; 0X70 (SA)
DELAYTEMP2                       EQU     113          ; 0X71 (SA)
OVERFLOWS                        EQU      32          ; 0X20
SYSREPEATFORCMP1                 EQU      33          ; 0X21
SYSREPEATFORCOUNTER1             EQU      34          ; 0X22
SYSREPEATFORCOUNTER1_H           EQU      35          ; 0X23
SYSWAITTEMPUS                    EQU     117          ; 0X75 (SA)
SYSWAITTEMPUS_H                  EQU     118          ; 0X76 (SA)

;********************************************************************************

;VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	GOTO	BASPROGRAMSTART
	ORG	4
	RETFIE

;********************************************************************************

;PROGRAM_MEMORY_PAGE: 0
	ORG	5
BASPROGRAMSTART
;CALL INITIALISATION ROUTINES
	CALL	INITSYS

;START_OF_THE_MAIN_PROGRAM
;Repeat For test (Change 1654): The original GATE FIX example, unmodified, on 12F1822
;Expect: compiles, and the Repeat For construct runs exactly the requested 790,047 microseconds worth of clock cycles
;(checked by simulating the generated assembly instruction by instruction)
;Dim Overflows As Byte
;Repeat For 790047 us
SYSREPEATFORSETUP1
	CLRF	SYSREPEATFORCOUNTER1
	CLRF	SYSREPEATFORCOUNTER1_H
SYSREPEATFORLOOP1
;Wait 1009 us
	MOVLW	2
	MOVWF	DELAYTEMP2
DELAYUSO1
	CLRF	DELAYTEMP
DELAYUS1
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS1
	DECFSZ	DELAYTEMP2,F
	GOTO	DELAYUSO1
	MOVLW	158
	MOVWF	DELAYTEMP
DELAYUS2
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS2
;If TMR1IF = 1 Then
	BTFSS	PIR1,TMR1IF
	GOTO	ENDIF1
;Overflows = Overflows + 1
	INCF	OVERFLOWS,F
;TMR1IF = 0
	BCF	PIR1,TMR1IF
;End If
ENDIF1
;End Repeat
SYSREPEATFORPAD1
	GOTO	$+1
SYSREPEATFORTAIL1
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
	BTFSS	STATUS,Z
	GOTO	SYSREPEATFORLOOP1
SYSREPEATFORLOOPEND1
	MOVLW	52
	MOVWF	DELAYTEMP
DELAYUS3
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS3
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
INITSYS
;Handle chips with only 2 IRCF bits (IRCF1, IRCF0) like 16F720/721 and its LF siblings
;16F72x has 500kHz INTOSC with 32x PLL option and postscaler (÷1,2,4,8)
;ChipSubFamily 15001 (16F152xx) has OSCCON with NOSC/NDIV bits but no IRCF bits,
;so it must be handled outside the IRCF based type 103 section
;Type 103: Chips without SPLLEN, IRCF3, but must have at least IRCF2 (exclude 2-bit IRCF chips)
;OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;equates to OSCCON = OSCCON AND b'10000111' &  OSCCON = OSCCON OR b'01110000'
;= 8Mhz
;Set IRCF3 On
	BANKSEL	OSCCON
	BSF	OSCCON,IRCF3
;Set IRCF2 On
	BSF	OSCCON,IRCF2
;Set IRCF1 On
	BSF	OSCCON,IRCF1
;Set IRCF0 Off
	BCF	OSCCON,IRCF0
;Set SPLLEN Off
	BCF	OSCCON,SPLLEN
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	BCF	ADCON1,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	BCF	ADCON0,ADON
;ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA
;Set comparator register bits for many MCUs with register CM2CON0
;C1ON = 0
	BANKSEL	CM1CON0
	BCF	CM1CON0,C1ON
;Turn off all ports
;GPIO = 0
	BANKSEL	PORTA
	CLRF	PORTA
;PORTA = 0
	CLRF	PORTA
;ClearRAM
;Macro Source: system.h (1838)
;No code. User has not included <clearram.h>
	RETURN

;********************************************************************************


 END
