;Program compiled by GCBASIC (2026.10.27 (Windows 64 bit) : Build 1663) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-10-27 CRC170
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1663\FunctionTwiceInSub.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : 
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1663\FunctionTwiceInSub.build\FunctionTwiceInSub.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46J50, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1663\FunctionTwiceInSub.gcb"
 SUBTITLE    "10-27-2026 11:35:45"
#include <P18F46J50.inc>
 CONFIG FCMEN = ON, OSC = HS, XINST = OFF, WDTEN = OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
HALF                             EQU      14          ; 0xE (SA)
HALFIN                           EQU      16          ; 0x10 (SA)
HALFIN_H                         EQU      17          ; 0x11 (SA)
HALF_H                           EQU      15          ; 0xF (SA)
RESULT                           EQU      18          ; 0x12 (SA)
RESULT_H                         EQU      19          ; 0x13 (SA)
SYSBYTETEMPX                     EQU       0          ; 0x0 (SA)
SYSDIVLOOP                       EQU       4          ; 0x4 (SA)
SYSDIVMULTA                      EQU       7          ; 0x7 (SA)
SYSDIVMULTA_H                    EQU       8          ; 0x8 (SA)
SYSDIVMULTB                      EQU      11          ; 0xB (SA)
SYSDIVMULTB_H                    EQU      12          ; 0xC (SA)
SYSDIVMULTX                      EQU       2          ; 0x2 (SA)
SYSDIVMULTX_H                    EQU       3          ; 0x3 (SA)
SYSFNINTEGER1                    EQU      20          ; 0x14 (SA)
SYSFNINTEGER1_H                  EQU      21          ; 0x15 (SA)
SYSINTEGERTEMPA                  EQU       5          ; 0x5 (SA)
SYSINTEGERTEMPA_H                EQU       6          ; 0x6 (SA)
SYSINTEGERTEMPB                  EQU       9          ; 0x9 (SA)
SYSINTEGERTEMPB_H                EQU      10          ; 0xA (SA)
SYSINTEGERTEMPX                  EQU       0          ; 0x0 (SA)
SYSINTEGERTEMPX_H                EQU       1          ; 0x1 (SA)
SYSSIGNBYTE                      EQU      13          ; 0xD (SA)
SYSTEMP1                         EQU      22          ; 0x16 (SA)
SYSWORDTEMPA                     EQU       5          ; 0x5 (SA)
SYSWORDTEMPA_H                   EQU       6          ; 0x6 (SA)
SYSWORDTEMPB                     EQU       9          ; 0x9 (SA)
SYSWORDTEMPB_H                   EQU      10          ; 0xA (SA)
SYSWORDTEMPX                     EQU       0          ; 0x0 (SA)
SYSWORDTEMPX_H                   EQU       1          ; 0x1 (SA)

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	retfie

;********************************************************************************

;Program_memory_page: 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	rcall	INITSYS

;Start_of_the_main_program
;Change 1663: two calls of an Integer function in one line inside a sub.
;The compiler keeps the first result in a temporary (SysFnINTEGER1) while it makes the second call. Build 1662
;compiled that copy as part of the main program, where the temporary is not known, so only its low byte was copied:
;movff HALF,SysFnINTEGER1        (and no movff HALF_H,SysFnINTEGER1_H)
;and Result was wrong. Word and Long functions had the same fault; the same line in the main program was right.
;Expected (build 1663): movff HALF,SysFnINTEGER1 and movff HALF_H,SysFnINTEGER1_H; Result = -200.
;Dim Result As Integer
;Calc
	rcall	CALC
;Do
SysDoLoop_S1
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: FunctionTwiceInSub.gcb (14)
CALC
;Result = Half(-300) + Half(-100)       ' -150 + -50 = -200
	movlw	212
	movwf	HALFIN,ACCESS
	movlw	254
	movwf	HALFIN_H,ACCESS
	rcall	FN_HALF
	movff	HALF,SysFnINTEGER1
	movff	HALF_H,SysFnINTEGER1_H
	movlw	156
	movwf	HALFIN,ACCESS
	setf	HALFIN_H,ACCESS
	rcall	FN_HALF
	movf	HALF,W,ACCESS
	addwf	SysFnINTEGER1,W,ACCESS
	movwf	RESULT,ACCESS
	movf	HALF_H,W,ACCESS
	addwfc	SysFnINTEGER1_H,W,ACCESS
	movwf	RESULT_H,ACCESS
	return

;********************************************************************************

;Source: FunctionTwiceInSub.gcb (18)
FN_HALF
;Half = HalfIn / 2
	movff	HALFIN,SysINTEGERTempA
	movff	HALFIN_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	rcall	SYSDIVSUBINT
	movff	SysINTEGERTempA,HALF
	movff	SysINTEGERTempA_H,HALF_H
	return

;********************************************************************************

;Source: system.h (211)
INITSYS
;_For_selected_frequency_-_the_external_oscillator_has_been_selected_by_compiler ChipMHz
;Clear BSR on ChipFamily16 MCUs
;MOVLB 0
	movlb	0
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON1,ADFM,ACCESS
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;For 18F1320, which uses ADCON1 as an ANSEL register
;ADCON1 = 255
	setf	ADCON1,ACCESS
;Set PCFG0 on
	banksel	ANCON0
	bsf	ANCON0,PCFG0,BANKED
;Set PCFG1 on
	bsf	ANCON0,PCFG1,BANKED
;Set PCFG2 on
	bsf	ANCON0,PCFG2,BANKED
;Set PCFG3 on
	bsf	ANCON0,PCFG3,BANKED
;Set PCFG4 on
	bsf	ANCON0,PCFG4,BANKED
;Set PCFG5 on
	bsf	ANCON0,PCFG5,BANKED
;Set PCFG6 on
	bsf	ANCON0,PCFG6,BANKED
;Set PCFG7 on
	bsf	ANCON0,PCFG7,BANKED
;Set PCFG8 on
	bsf	ANCON1,PCFG8,BANKED
;Set PCFG9 on
	bsf	ANCON1,PCFG9,BANKED
;Set PCFG10 on
	bsf	ANCON1,PCFG10,BANKED
;Set PCFG11 on
	bsf	ANCON1,PCFG11,BANKED
;Set PCFG12 on
	bsf	ANCON1,PCFG12,BANKED
;Turn off all ports
;PORTA = 0
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
;PORTD = 0
	clrf	PORTD,ACCESS
;PORTE = 0
	clrf	PORTE,ACCESS
;ClearRAM
;Macro Source: system.h (1838)
;No code. User has not included <clearram.h>
	banksel	0
	return

;********************************************************************************

;Source: system.h (4224)
SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysWordTempB, W
	movf	SYSWORDTEMPB, W,ACCESS
;cpfseq SysWordTempA
	cpfseq	SYSWORDTEMPA,ACCESS
;return
	return
;Test high, exit if false
;movf SysWordTempB_H, W
	movf	SYSWORDTEMPB_H, W,ACCESS
;cpfseq SysWordTempA_H
	cpfseq	SYSWORDTEMPA_H,ACCESS
;return
	return
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (3592)
SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movff	SYSWORDTEMPA,SYSDIVMULTA
	movff	SYSWORDTEMPA_H,SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movff	SYSWORDTEMPB,SYSDIVMULTB
	movff	SYSWORDTEMPB_H,SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX,ACCESS
	clrf	SYSDIVMULTX_H,ACCESS
;Avoid division by zero
;if SysDivMultB = 0 then
	movff	SYSDIVMULTB,SysWORDTempA
	movff	SYSDIVMULTB_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF4
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF4
;Main calc routine
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP,ACCESS
SYSDIV16START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysDivMultA Left
	rlcf	SYSDIVMULTA,F,ACCESS
	rlcf	SYSDIVMULTA_H,F,ACCESS
;Rotate SysDivMultX Left
	rlcf	SYSDIVMULTX,F,ACCESS
	rlcf	SYSDIVMULTX_H,F,ACCESS
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	subwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	subwfb	SYSDIVMULTX_H,F,ACCESS
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0,ACCESS
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF5
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF5
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv16Start
	bra	SYSDIV16START
;SysWordTempA = SysDivMultA
	movff	SYSDIVMULTA,SYSWORDTEMPA
	movff	SYSDIVMULTA_H,SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movff	SYSDIVMULTX,SYSWORDTEMPX
	movff	SYSDIVMULTX_H,SYSWORDTEMPX_H
	return

;********************************************************************************

;Source: system.h (3646)
SYSDIVSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	xorwf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSSIGNBYTE,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ENDIF1
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
ENDIF1
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF2
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
ENDIF2
;Call word divide routine
;SysDivSub16
	rcall	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF3
;SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
;End If
ENDIF3
	return

;********************************************************************************


 END
