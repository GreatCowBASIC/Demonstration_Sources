;Program compiled by Great Cow BASIC (1.00.00 Release Candidate 2022-08-27 (Windows 64 bit) : Build 1163) for Microchip MPASM/MPLAB-X Assembler
;Need help? 
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   w_cholmondeley at users dot sourceforge dot net
;   evanvennn at users dot sourceforge dot net

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1829, r=DEC
#include <P16F1829.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _CPD_OFF & _CP_OFF & _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF & _WRT_OFF

;********************************************************************************

;Set aside memory locations for variables
BRI                              EQU      32          ; 0x20
BRIGHT                           EQU      33          ; 0x21
BRIGHTNESS                       EQU      34          ; 0x22
CHR                              EQU    9159          ; 0x23C7
COLONON                          EQU      35          ; 0x23
DATA                             EQU      36          ; 0x24
DELAYTEMP                        EQU     112          ; 0x70
DELAYTEMP2                       EQU     113          ; 0x71
FNLSR                            EQU      37          ; 0x25
FNLSR_E                          EQU      40          ; 0x28
FNLSR_H                          EQU      38          ; 0x26
FNLSR_U                          EQU      39          ; 0x27
LETTER                           EQU      41          ; 0x29
NUMBITS                          EQU      42          ; 0x2A
SMALL_CHR                        EQU      43          ; 0x2B
STRINGPOINTER                    EQU      44          ; 0x2C
SYSBYTETEMPA                     EQU     117          ; 0x75
SYSBYTETEMPB                     EQU     121          ; 0x79
SYSBYTETEMPX                     EQU     112          ; 0x70
SYSCHAR                          EQU      45          ; 0x2D
SYSDIVLOOP                       EQU     116          ; 0x74
SYSDIVMULTA                      EQU     119          ; 0x77
SYSDIVMULTA_H                    EQU     120          ; 0x78
SYSDIVMULTB                      EQU     123          ; 0x7B
SYSDIVMULTB_H                    EQU     124          ; 0x7C
SYSDIVMULTX                      EQU     114          ; 0x72
SYSDIVMULTX_H                    EQU     115          ; 0x73
SYSFORLOOPSTEP2                  EQU      46          ; 0x2E
SYSFORLOOPSTEP2_H                EQU      47          ; 0x2F
SYSFORLOOPSTEP4                  EQU      48          ; 0x30
SYSFORLOOPSTEP4_H                EQU      49          ; 0x31
SYSINTEGERTEMPA                  EQU     117          ; 0x75
SYSINTEGERTEMPA_H                EQU     118          ; 0x76
SYSINTEGERTEMPB                  EQU     121          ; 0x79
SYSINTEGERTEMPB_H                EQU     122          ; 0x7A
SYSREPEATTEMP1                   EQU      50          ; 0x32
SYSREPEATTEMP3                   EQU      51          ; 0x33
SYSREPEATTEMP4                   EQU      52          ; 0x34
SYSSTRINGA                       EQU     119          ; 0x77
SYSSTRINGA_H                     EQU     120          ; 0x78
SYSTEMP1                         EQU      53          ; 0x35
SYSTEMP2                         EQU      54          ; 0x36
SYSTEMP2_H                       EQU      55          ; 0x37
SYSTEMP3                         EQU      56          ; 0x38
SYSWAITTEMPMS                    EQU     114          ; 0x72
SYSWAITTEMPMS_H                  EQU     115          ; 0x73
SYSWAITTEMPS                     EQU     116          ; 0x74
SYSWAITTEMPUS                    EQU     117          ; 0x75
SYSWAITTEMPUS_H                  EQU     118          ; 0x76
SYSWORDTEMPA                     EQU     117          ; 0x75
SYSWORDTEMPA_H                   EQU     118          ; 0x76
SYSWORDTEMPB                     EQU     121          ; 0x79
SYSWORDTEMPB_H                   EQU     122          ; 0x7A
SYSWORDTEMPX                     EQU     112          ; 0x70
SYSWORDTEMPX_H                   EQU     113          ; 0x71
TM1638_COLON                     EQU      57          ; 0x39
TM1638_ZERO                      EQU      58          ; 0x3A
TMADDR                           EQU      59          ; 0x3B
TMCHAR                           EQU      60          ; 0x3C
TMCHAR_BRIGHT                    EQU      61          ; 0x3D
TMDIG1                           EQU      62          ; 0x3E
TMDIG2                           EQU      63          ; 0x3F
TMDIG3                           EQU      64          ; 0x40
TMDIG4                           EQU      65          ; 0x41
TMEVAL                           EQU      66          ; 0x42
TMHVAL                           EQU      67          ; 0x43
TMLVAL                           EQU      68          ; 0x44
TMSEG1                           EQU      69          ; 0x45
TMSEG2                           EQU      70          ; 0x46
TMSEG3                           EQU      71          ; 0x47
TMSEG4                           EQU      72          ; 0x48
TMSVAL                           EQU      73          ; 0x49
TMVALUE                          EQU      74          ; 0x4A
TMVALUE_H                        EQU      75          ; 0x4B
VALUE                            EQU      76          ; 0x4C
YY                               EQU      77          ; 0x4D

;********************************************************************************

;Alias variables
SYSCHR_0 EQU 1575
SYSCHR_1 EQU 1576
SYSFNLSRBYTE EQU 37

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	5
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITTM1638
;Automatic pin direction setting
	banksel	TRISC
	bcf	TRISC,2

;Start of the main program
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program will show the functionality of the TM1637a.h library.
;''The TM1637 module is connected to PortD.2 CLK and PortD.3 DIO
;''@author  Friderik Back
;''@licence GPL
;''@version 2.0a
;''@date    9.9.2020
;''********************************************************************************
;----- Configuration
;
;Dim letter,small_chr, dig, Num0, Num1 as byte
;TMchar_Bright = 10
	movlw	10
	banksel	TMCHAR_BRIGHT
	movwf	TMCHAR_BRIGHT
;---- main program --------
;Do
SysDoLoop_S1
;TM_reset
	call	TM_RESET
;Write4Dig (17, 16, 17, 16, 0) 'clear display
	movlw	17
	movwf	TMDIG1
	movlw	16
	movwf	TMDIG2
	movlw	17
	movwf	TMDIG3
	movlw	16
	movwf	TMDIG4
	clrf	BRIGHT
	clrf	COLONON
	call	WRITE4DIG
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;Write4Dig (17, 16, 17, 16, 10,0) '- -
	movlw	17
	movwf	TMDIG1
	movlw	16
	movwf	TMDIG2
	movlw	17
	movwf	TMDIG3
	movlw	16
	movwf	TMDIG4
	movlw	10
	movwf	BRIGHT
	clrf	COLONON
	call	WRITE4DIG
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;All segments Fade in test
;For bri = 8 to 15
;Legacy method
	movlw	7
	movwf	BRI
SysForLoop1
	incf	BRI,F
;Write4Dig(8,8,8,8,bri,1) 'All segments test
	movlw	8
	movwf	TMDIG1
	movlw	8
	movwf	TMDIG2
	movlw	8
	movwf	TMDIG3
	movlw	8
	movwf	TMDIG4
	movf	BRI,W
	movwf	BRIGHT
	movlw	1
	movwf	COLONON
	call	WRITE4DIG
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;Next bri
	movlw	15
	subwf	BRI,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
;Letters Fade in
;For TMchar_Bright = 8 to 15
;Legacy method
	movlw	7
	movwf	TMCHAR_BRIGHT
SysForLoop2
	incf	TMCHAR_BRIGHT,F
;WriteChar (0 , "G")
	clrf	TMADDR
	movlw	71
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (1 , "c")
	movlw	1
	movwf	TMADDR
	movlw	99
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (2 , "b")
	movlw	2
	movwf	TMADDR
	movlw	98
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (3 , " ")
	movlw	3
	movwf	TMADDR
	movlw	32
	movwf	TMCHAR
	call	WRITECHAR
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;Next TMchar_Bright
	movlw	15
	subwf	TMCHAR_BRIGHT,W
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
;
;TM_reset
	call	TM_RESET
;Fade out demo
;For TMchar_Bright = 15 to 7 step -1
	movlw	15
	movwf	TMCHAR_BRIGHT
SysForLoop3
;Init SysForLoopStep2 :#0
	movlw	255
	movwf	SysForLoopStep2
	movwf	SysForLoopStep2_H
;WriteChar (0 , "d")
	clrf	TMADDR
	movlw	100
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (1 , "e")
	movlw	1
	movwf	TMADDR
	movlw	101
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (2 , "m")
	movlw	2
	movwf	TMADDR
	movlw	109
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (3 , "o")
	movlw	3
	movwf	TMADDR
	movlw	111
	movwf	TMCHAR
	call	WRITECHAR
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;Next TMchar_Bright
;Integer negative Step Handler in For-next statement
	btfss	SYSFORLOOPSTEP2_H,7
	goto	ELSE3_1
;IF ( TMCHAR_BRIGHT - 7) } -SysForLoopStep2 THEN :#3n
	movlw	7
	subwf	TMCHAR_BRIGHT,W
	movwf	SysTemp1
	comf	SysForLoopStep2,W
	movwf	SysTemp2
	comf	SysForLoopStep2_H,W
	movwf	SysTemp2_H
	incf	SysTemp2,F
	btfsc	STATUS,Z
	incf	SysTemp2_H,F
	movf	SysTemp1,W
	movwf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	movf	SysTemp2,W
	movwf	SysINTEGERTempB
	movf	SysTemp2_H,W
	movwf	SysINTEGERTempB_H
	call	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF6
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	movf	SysForLoopStep2,W
	addwf	TMCHAR_BRIGHT,F
	goto	SysForLoop3
;END IF
ENDIF6
	goto	ENDIF3
ELSE3_1
;Integer positive Step Handler in For-next statement
;IF (7 - TMCHAR_BRIGHT) } SysForLoopStep2 THEN :#3p
	movf	TMCHAR_BRIGHT,W
	sublw	7
	movwf	SysTemp1
	movwf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	movf	SysForLoopStep2,W
	movwf	SysINTEGERTempB
	movf	SysForLoopStep2_H,W
	movwf	SysINTEGERTempB_H
	call	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF7
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	movf	SysForLoopStep2,W
	addwf	TMCHAR_BRIGHT,F
	goto	SysForLoop3
;END IF
ENDIF7
;END IF
ENDIF3
SysForLoopEnd3
;TM_reset
	call	TM_RESET
;Letters demo
;TMchar_Bright = 10
	movlw	10
	movwf	TMCHAR_BRIGHT
;WriteChar (0 , "C")
	clrf	TMADDR
	movlw	67
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (1 , "h")
	movlw	1
	movwf	TMADDR
	movlw	104
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (2 , "a")
	movlw	2
	movwf	TMADDR
	movlw	97
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (3 , "r")
	movlw	3
	movwf	TMADDR
	movlw	114
	movwf	TMCHAR
	call	WRITECHAR
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TM_reset
	call	TM_RESET
;All letters demo
;For letter = 65 to 90
;Legacy method
	movlw	64
	movwf	LETTER
SysForLoop4
	incf	LETTER,F
;small_chr = letter + 32 'Siekoo a�phabet
	movlw	32
	addwf	LETTER,W
	movwf	SMALL_CHR
;WriteChar (0 , letter)
	clrf	TMADDR
	movf	LETTER,W
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (1 , " ")
	movlw	1
	movwf	TMADDR
	movlw	32
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (2 , small_chr)
	movlw	2
	movwf	TMADDR
	movf	SMALL_CHR,W
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (3 , " ")
	movlw	3
	movwf	TMADDR
	movlw	32
	movwf	TMCHAR
	call	WRITECHAR
;wait 1 s
	movlw	1
	movwf	SysWaitTempS
	call	Delay_S
;Next letter
	movlw	90
	subwf	LETTER,W
	btfss	STATUS, C
	goto	SysForLoop4
SysForLoopEnd4
;TM_reset
	call	TM_RESET
;Special signs
;WriteChar (0 , "S")
	clrf	TMADDR
	movlw	83
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (1 , "P")
	movlw	1
	movwf	TMADDR
	movlw	80
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (2 , "E")
	movlw	2
	movwf	TMADDR
	movlw	69
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (3 , "C")
	movlw	3
	movwf	TMADDR
	movlw	67
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (4 , "I")
	movlw	4
	movwf	TMADDR
	movlw	73
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (5 , "A")
	movlw	5
	movwf	TMADDR
	movlw	65
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (6 , "L")
	movlw	6
	movwf	TMADDR
	movlw	76
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (7 , " ")
	movlw	7
	movwf	TMADDR
	movlw	32
	movwf	TMCHAR
	call	WRITECHAR
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TM_reset
	call	TM_RESET
;Write4Dig(17,18,19,20,10,0)
	movlw	17
	movwf	TMDIG1
	movlw	18
	movwf	TMDIG2
	movlw	19
	movwf	TMDIG3
	movlw	20
	movwf	TMDIG4
	movlw	10
	movwf	BRIGHT
	clrf	COLONON
	call	WRITE4DIG
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;Alternative command
;WriteChar (0 , "?")
	clrf	TMADDR
	movlw	63
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (1 , "-")
	movlw	1
	movwf	TMADDR
	movlw	45
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (2 , CHR(176))
	movlw	2
	movwf	TMADDR
	movlw	176
	movwf	SYSCHAR
	call	FN_CHR
	call	WRITECHAR
;WriteChar (3 , ")")
	movlw	3
	movwf	TMADDR
	movlw	41
	movwf	TMCHAR
	call	WRITECHAR
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;Hex number demo
;WriteChar (0 , "H")
	clrf	TMADDR
	movlw	72
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (1 , "e")
	movlw	1
	movwf	TMADDR
	movlw	101
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (2 , "x")
	movlw	2
	movwf	TMADDR
	movlw	120
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (3 , "a")
	movlw	3
	movwf	TMADDR
	movlw	97
	movwf	TMCHAR
	call	WRITECHAR
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMhex(255) '00FF
	movlw	255
	movwf	TMVALUE
	clrf	TMVALUE_H
	call	TMHEX
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMhex(65535) 'FFFF
	movlw	255
	movwf	TMVALUE
	movwf	TMVALUE_H
	call	TMHEX
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMhex(0xABCD) 'ABCD
	movlw	205
	movwf	TMVALUE
	movlw	171
	movwf	TMVALUE_H
	call	TMHEX
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;decimal numbers
;decimal numbers without leading zeroes
;WriteChar (0 , "D")
	clrf	TMADDR
	movlw	68
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (1 , "e")
	movlw	1
	movwf	TMADDR
	movlw	101
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (2 , "c")
	movlw	2
	movwf	TMADDR
	movlw	99
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (3 , " ")
	movlw	3
	movwf	TMADDR
	movlw	32
	movwf	TMCHAR
	call	WRITECHAR
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMdec(8095) '8095
	movlw	159
	movwf	TMVALUE
	movlw	31
	movwf	TMVALUE_H
	clrf	TM1638_ZERO
	call	TMDEC
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMdec(2,0) '   2
	movlw	2
	movwf	TMVALUE
	clrf	TMVALUE_H
	clrf	TM1638_ZERO
	call	TMDEC
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMdec(134) ' 134
	movlw	134
	movwf	TMVALUE
	clrf	TMVALUE_H
	clrf	TM1638_ZERO
	call	TMDEC
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;WriteChar (0 , "-")'-134
	clrf	TMADDR
	movlw	45
	movwf	TMCHAR
	call	WRITECHAR
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMdec(134,2) ' 1:34
	movlw	134
	movwf	TMVALUE
	clrf	TMVALUE_H
	movlw	2
	movwf	TM1638_ZERO
	call	TMDEC
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMdec(67) '  67
	movlw	67
	movwf	TMVALUE
	clrf	TMVALUE_H
	clrf	TM1638_ZERO
	call	TMDEC
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMdec(12345) '----
	movlw	57
	movwf	TMVALUE
	movlw	48
	movwf	TMVALUE_H
	clrf	TM1638_ZERO
	call	TMDEC
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;decimal numbers with leading zeroes
;WriteChar (0 , "Z")
	clrf	TMADDR
	movlw	90
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (1 , "e")
	movlw	1
	movwf	TMADDR
	movlw	101
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (2 , "r")
	movlw	2
	movwf	TMADDR
	movlw	114
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (3 , "o")
	movlw	3
	movwf	TMADDR
	movlw	111
	movwf	TMCHAR
	call	WRITECHAR
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMdec(8095,1) '8095
	movlw	159
	movwf	TMVALUE
	movlw	31
	movwf	TMVALUE_H
	movlw	1
	movwf	TM1638_ZERO
	call	TMDEC
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMdec(2,1) '0002
	movlw	2
	movwf	TMVALUE
	clrf	TMVALUE_H
	movlw	1
	movwf	TM1638_ZERO
	call	TMDEC
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMdec(134,1) '0134
	movlw	134
	movwf	TMVALUE
	clrf	TMVALUE_H
	movlw	1
	movwf	TM1638_ZERO
	call	TMDEC
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMdec(67,1) '0067
	movlw	67
	movwf	TMVALUE
	clrf	TMVALUE_H
	movlw	1
	movwf	TM1638_ZERO
	call	TMDEC
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;TMdec(12345,1) '----
	movlw	57
	movwf	TMVALUE
	movlw	48
	movwf	TMVALUE_H
	movlw	1
	movwf	TM1638_ZERO
	call	TMDEC
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;Thermometer demo
;WriteChar (0 , "T")
	clrf	TMADDR
	movlw	84
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (1 , "e")
	movlw	1
	movwf	TMADDR
	movlw	101
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (2 , "r")
	movlw	2
	movwf	TMADDR
	movlw	114
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (3 , "m")
	movlw	3
	movwf	TMADDR
	movlw	109
	movwf	TMCHAR
	call	WRITECHAR
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;Write4Dig(2,2,18,12,10,0)  ' 22�C
	movlw	2
	movwf	TMDIG1
	movlw	2
	movwf	TMDIG2
	movlw	18
	movwf	TMDIG3
	movlw	12
	movwf	TMDIG4
	movlw	10
	movwf	BRIGHT
	clrf	COLONON
	call	WRITE4DIG
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;Write4Dig(9,3,18,15,11,0)  ' 93�F
	movlw	9
	movwf	TMDIG1
	movlw	3
	movwf	TMDIG2
	movlw	18
	movwf	TMDIG3
	movlw	15
	movwf	TMDIG4
	movlw	11
	movwf	BRIGHT
	clrf	COLONON
	call	WRITE4DIG
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;Write4Dig(16,9,18,12,10,0)  ' 3�C
	movlw	16
	movwf	TMDIG1
	movlw	9
	movwf	TMDIG2
	movlw	18
	movwf	TMDIG3
	movlw	12
	movwf	TMDIG4
	movlw	10
	movwf	BRIGHT
	clrf	COLONON
	call	WRITE4DIG
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;Write4Dig(17,7,18,12,9,0)  ' -7�C
	movlw	17
	movwf	TMDIG1
	movlw	7
	movwf	TMDIG2
	movlw	18
	movwf	TMDIG3
	movlw	12
	movwf	TMDIG4
	movlw	9
	movwf	BRIGHT
	clrf	COLONON
	call	WRITE4DIG
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;Clock demo
;WriteChar (0 , "C")
	clrf	TMADDR
	movlw	67
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (1 , "l")
	movlw	1
	movwf	TMADDR
	movlw	108
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (2 , "o")
	movlw	2
	movwf	TMADDR
	movlw	111
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (3 , "C")
	movlw	3
	movwf	TMADDR
	movlw	67
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (4 , "k")
	movlw	4
	movwf	TMADDR
	movlw	107
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (5 , " ")
	movlw	5
	movwf	TMADDR
	movlw	32
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (6 , " ")
	movlw	6
	movwf	TMADDR
	movlw	32
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (7 , " ")
	movlw	7
	movwf	TMADDR
	movlw	32
	movwf	TMCHAR
	call	WRITECHAR
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;WriteChar (4 , " ")
	movlw	4
	movwf	TMADDR
	movlw	32
	movwf	TMCHAR
	call	WRITECHAR
;Repeat 3
	movlw	3
	movwf	SysRepeatTemp1
SysRepeatLoop1
;Write4Dig(1,1,5,9,10,1)  ' clock disp , no leading zero, minimum brightness, Colon On
	movlw	1
	movwf	TMDIG1
	movlw	1
	movwf	TMDIG2
	movlw	5
	movwf	TMDIG3
	movlw	9
	movwf	TMDIG4
	movlw	10
	movwf	BRIGHT
	movlw	1
	movwf	COLONON
	call	WRITE4DIG
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;Write4Dig(1,1,5,9,10,0)  ' clock disp , no leading zero, minimum brightness, Colon Off
	movlw	1
	movwf	TMDIG1
	movlw	1
	movwf	TMDIG2
	movlw	5
	movwf	TMDIG3
	movlw	9
	movwf	TMDIG4
	movlw	10
	movwf	BRIGHT
	clrf	COLONON
	call	WRITE4DIG
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;End Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;Repeat 3
	movlw	3
	movwf	SysRepeatTemp1
SysRepeatLoop2
;Write4Dig(1,2,0,0,10,1)  ' clock disp , no leading zero, minimum brightness, Colon On
	movlw	1
	movwf	TMDIG1
	movlw	2
	movwf	TMDIG2
	clrf	TMDIG3
	clrf	TMDIG4
	movlw	10
	movwf	BRIGHT
	movlw	1
	movwf	COLONON
	call	WRITE4DIG
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;Write4Dig(1,2,0,0,10,0)  ' clock disp , no leading zero, minimum brightness, Colon Off
	movlw	1
	movwf	TMDIG1
	movlw	2
	movwf	TMDIG2
	clrf	TMDIG3
	clrf	TMDIG4
	movlw	10
	movwf	BRIGHT
	clrf	COLONON
	call	WRITE4DIG
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;End Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;Countdown demo
;WriteChar (0 , "C")
	clrf	TMADDR
	movlw	67
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (1 , "O")
	movlw	1
	movwf	TMADDR
	movlw	79
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (2 , "U")
	movlw	2
	movwf	TMADDR
	movlw	85
	movwf	TMCHAR
	call	WRITECHAR
;WriteChar (3 , "n")
	movlw	3
	movwf	TMADDR
	movlw	110
	movwf	TMCHAR
	call	WRITECHAR
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;For bri = 123 to 117 step -1
	movlw	123
	movwf	BRI
SysForLoop5
;Init SysForLoopStep4 :#0
	movlw	255
	movwf	SysForLoopStep4
	movwf	SysForLoopStep4_H
;TMdec(bri,1)
	movf	BRI,W
	movwf	TMVALUE
	clrf	TMVALUE_H
	movlw	1
	movwf	TM1638_ZERO
	call	TMDEC
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;TMdec(bri,3)
	movf	BRI,W
	movwf	TMVALUE
	clrf	TMVALUE_H
	movlw	3
	movwf	TM1638_ZERO
	call	TMDEC
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;next bri
;Integer negative Step Handler in For-next statement
	btfss	SYSFORLOOPSTEP4_H,7
	goto	ELSE5_1
;IF ( BRI - 117) } -SysForLoopStep4 THEN :#3n
	movlw	117
	subwf	BRI,W
	movwf	SysTemp1
	comf	SysForLoopStep4,W
	movwf	SysTemp2
	comf	SysForLoopStep4_H,W
	movwf	SysTemp2_H
	incf	SysTemp2,F
	btfsc	STATUS,Z
	incf	SysTemp2_H,F
	movf	SysTemp1,W
	movwf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	movf	SysTemp2,W
	movwf	SysINTEGERTempB
	movf	SysTemp2_H,W
	movwf	SysINTEGERTempB_H
	call	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF8
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	movf	SysForLoopStep4,W
	addwf	BRI,F
	goto	SysForLoop5
;END IF
ENDIF8
	goto	ENDIF5
ELSE5_1
;Integer positive Step Handler in For-next statement
;IF (117 - BRI) } SysForLoopStep4 THEN :#3p
	movf	BRI,W
	sublw	117
	movwf	SysTemp1
	movwf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	movf	SysForLoopStep4,W
	movwf	SysINTEGERTempB
	movf	SysForLoopStep4_H,W
	movwf	SysINTEGERTempB_H
	call	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF9
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	movf	SysForLoopStep4,W
	addwf	BRI,F
	goto	SysForLoop5
;END IF
ENDIF9
;END IF
ENDIF5
SysForLoopEnd5
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Source: string.h (537)
FN_CHR
;Empty input?
;If SysChar < 0 Then
	movlw	0
	subwf	SYSCHAR,W
	btfsc	STATUS, C
	goto	ENDIF39
;Chr(0) = 0
	banksel	SYSCHR_0
	clrf	SYSCHR_0
;Exit Function
	banksel	STATUS
	return
;End If
ENDIF39
;Chr(0) = 1
	movlw	1
	banksel	SYSCHR_0
	movwf	SYSCHR_0
;Copy characters
;Chr(1) = SysChar
	banksel	SYSCHAR
	movf	SYSCHAR,W
	banksel	SYSCHR_1
	movwf	SYSCHR_1
	banksel	STATUS
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	4
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	165
	movwf	DELAYTEMP
DMS_INNER
	decfsz	DELAYTEMP, F
	goto	DMS_INNER
	decfsz	DELAYTEMP2, F
	goto	DMS_OUTER
	decfsz	SysWaitTempMS, F
	goto	DMS_START
	decfsz	SysWaitTempMS_H, F
	goto	DMS_START
	return

;********************************************************************************

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS
	movlw	3
	movwf	SysWaitTempMS_H
	call	Delay_MS
	decfsz	SysWaitTempS, F
	goto	DS_START
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:, Source: stdbasic.h (396)
FN_FNLSR99
;Repeat NumBits
	movf	NUMBITS,W
	movwf	SysRepeatTemp4
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd4
SysRepeatLoop4
;Set C Off
	bcf	STATUS,C
;Rotate SysByteTempB Right
	rrf	SYSBYTETEMPB,F
;End Repeat
	decfsz	SysRepeatTemp4,F
	goto	SysRepeatLoop4
SysRepeatLoopEnd4
;FnLSR = SysByteTempB
	movf	SYSBYTETEMPB,W
	movwf	FNLSR
	return

;********************************************************************************

;Source: system.h (159)
INITSYS
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;equates to OSCCON = OSCCON AND b'10000111' &  OSCCON = OSCCON OR b'01110000'
;= 8Mhz
;Set IRCF3 On
	banksel	OSCCON
	bsf	OSCCON,IRCF3
;Set IRCF2 On
	bsf	OSCCON,IRCF2
;Set IRCF1 On
	bsf	OSCCON,IRCF1
;Set IRCF0 Off
	bcf	OSCCON,IRCF0
;Set SPLLEN Off
	bcf	OSCCON,SPLLEN
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON1,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;Set comparator register bits for many MCUs with register CM2CON0
;C2ON = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
;C1ON = 0
	bcf	CM1CON0,C1ON
;
;'Turn off all ports
;PORTA = 0
	banksel	PORTA
	clrf	PORTA
;PORTB = 0
	clrf	PORTB
;PORTC = 0
	clrf	PORTC
	return

;********************************************************************************

;Source: TM1638.h (107)
INITTM1638
;dim DispTemp as Byte
;dim Bright as Byte
;Dim buttons as byte
;Dim butVal as byte
;Dim temp as byte
;Dim ButArray(4)
;set TM1638_STB on
	banksel	LATC
	bsf	LATC,2
;Brightness = 15  'full brightness and turn on display
	movlw	15
	banksel	BRIGHTNESS
	movwf	BRIGHTNESS
;Dir TM1638_DIO Out
	banksel	TRISC
	bcf	TRISC,0
;Dir TM1638_CLK Out
	bcf	TRISC,1
;sendCommand(TM_ACTIVATE)
	movlw	143
	banksel	VALUE
	movwf	VALUE
	call	SENDCOMMAND
;value = TM_BRIGHT_ADR + (TM_BRIGHT_MASK & brightness)
	movlw	7
	andwf	BRIGHTNESS,W
	movwf	SysTemp1
	movlw	136
	addwf	SysTemp1,W
	movwf	VALUE
;SendCommand(value)
	call	SENDCOMMAND
;TM_reset()                'clears display
	goto	TM_RESET

;********************************************************************************

;Source: TM1638.h (131)
SENDCOMMAND
;set TM1638_STB off
	banksel	LATC
	bcf	LATC,2
;sendData(value)
	banksel	VALUE
	movf	VALUE,W
	movwf	DATA
	call	SENDDATA
	movf	DATA,W
	movwf	VALUE
;set TM1638_STB on
	banksel	LATC
	bsf	LATC,2
	banksel	STATUS
	return

;********************************************************************************

;Source: TM1638.h (138)
SENDDATA
;for yy = 1 to 8
;Legacy method
	clrf	YY
SysForLoop6
	incf	YY,F
;set TM1638_CLK off
	banksel	LATC
	bcf	LATC,1
;wait 5 us
	movlw	3
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
;if data & 1 = 1 then
	banksel	DATA
	movf	DATA,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ELSE40_1
;set TM1638_DIO on
	banksel	LATC
	bsf	LATC,0
;else
	goto	ENDIF40
ELSE40_1
;set TM1638_DIO off
	banksel	LATC
	bcf	LATC,0
;end if
ENDIF40
;wait 5 us
	movlw	3
	movwf	DELAYTEMP
DelayUS2
	decfsz	DELAYTEMP,F
	goto	DelayUS2
;set TM1638_CLK on
	bsf	LATC,1
;wait 5 us
	movlw	3
	movwf	DELAYTEMP
DelayUS3
	decfsz	DELAYTEMP,F
	goto	DelayUS3
;data = FnLSR(data, 1)
	banksel	DATA
	movf	DATA,W
	movwf	SYSBYTETEMPB
	movlw	1
	movwf	NUMBITS
	call	FN_FNLSR99
	movf	SYSFNLSRBYTE,W
	movwf	DATA
;next yy
	movlw	8
	subwf	YY,W
	btfss	STATUS, C
	goto	SysForLoop6
SysForLoopEnd6
	return

;********************************************************************************

SEVENSEGDISPDIGIT
	movlw	22
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLESEVENSEGDISPDIGIT
	movwf	SysStringA
	movlw	(high TABLESEVENSEGDISPDIGIT) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLESEVENSEGDISPDIGIT
	retlw	21
	retlw	63
	retlw	6
	retlw	91
	retlw	79
	retlw	102
	retlw	109
	retlw	125
	retlw	7
	retlw	127
	retlw	111
	retlw	119
	retlw	124
	retlw	57
	retlw	94
	retlw	121
	retlw	113
	retlw	0
	retlw	64
	retlw	99
	retlw	15
	retlw	83

;********************************************************************************

SEVENSEGDISPLETTER
	movlw	53
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLESEVENSEGDISPLETTER
	movwf	SysStringA
	movlw	(high TABLESEVENSEGDISPLETTER) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLESEVENSEGDISPLETTER
	retlw	52
	retlw	119
	retlw	124
	retlw	57
	retlw	94
	retlw	121
	retlw	113
	retlw	61
	retlw	118
	retlw	6
	retlw	14
	retlw	118
	retlw	56
	retlw	55
	retlw	55
	retlw	63
	retlw	115
	retlw	103
	retlw	80
	retlw	109
	retlw	7
	retlw	62
	retlw	62
	retlw	62
	retlw	118
	retlw	110
	retlw	27
	retlw	95
	retlw	124
	retlw	88
	retlw	94
	retlw	121
	retlw	113
	retlw	61
	retlw	116
	retlw	4
	retlw	13
	retlw	117
	retlw	56
	retlw	85
	retlw	84
	retlw	92
	retlw	115
	retlw	103
	retlw	80
	retlw	45
	retlw	120
	retlw	28
	retlw	42
	retlw	106
	retlw	20
	retlw	110
	retlw	27

;********************************************************************************

;Source: system.h (3078)
SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;subwf SysByteTempB, W
	subwf	SYSBYTETEMPB, W
;btfsc STATUS, Z
	btfsc	STATUS, Z
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (3104)
SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	subwf	SYSWORDTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	subwf	SYSWORDTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (3383)
SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;bsf STATUS, C
	bsf	STATUS, C
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;subwf SysByteTempA, W
	subwf	SYSBYTETEMPA, W
;btfss STATUS, C
	btfss	STATUS, C
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (3413)
SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLT16True
	goto	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (3714)
SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7
	goto	ELSE36_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7
	goto	ENDIF37
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F
;Exit Sub
	return
;End If
ENDIF37
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,W
	movwf	SYSDIVMULTA
	comf	SYSINTEGERTEMPA_H,W
	movwf	SYSDIVMULTA_H
	incf	SYSDIVMULTA,F
	btfsc	STATUS,Z
	incf	SYSDIVMULTA_H,F
;SysIntegerTempA = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,W
	movwf	SYSINTEGERTEMPA
	comf	SYSINTEGERTEMPB_H,W
	movwf	SYSINTEGERTEMPA_H
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
;SysIntegerTempB = SysDivMultA
	movf	SYSDIVMULTA,W
	movwf	SYSINTEGERTEMPB
	movf	SYSDIVMULTA_H,W
	movwf	SYSINTEGERTEMPB_H
;+A
;Else
	goto	ENDIF36
ELSE36_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7
;Exit Sub
	return
;End If
;End If
ENDIF36
;Test High, exit if more
;movf SysIntegerTempA_H,W
	movf	SYSINTEGERTEMPA_H,W
;subwf SysIntegerTempB_H,W
	subwf	SYSINTEGERTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	movf	SYSINTEGERTEMPB_H,W
;subwf SysIntegerTempA_H,W
	subwf	SYSINTEGERTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLTIntTrue
	goto	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	movf	SYSINTEGERTEMPB,W
;subwf SysIntegerTempA,W
	subwf	SYSINTEGERTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLTINTTRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (2861)
SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movf	SYSWORDTEMPA,W
	movwf	SYSDIVMULTA
	movf	SYSWORDTEMPA_H,W
	movwf	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movf	SYSWORDTEMPB,W
	movwf	SYSDIVMULTB
	movf	SYSWORDTEMPB_H,W
	movwf	SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX
	clrf	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempA
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0
	goto	ENDIF34
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF34
;Main calc routine
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP
SYSDIV16START
;set C off
	bcf	STATUS,C
;Rotate SysDivMultA Left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	rlf	SYSDIVMULTX,F
	rlf	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W
	subwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	subwfb	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF35
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF35
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv16Start
	goto	SYSDIV16START
;SysWordTempA = SysDivMultA
	movf	SYSDIVMULTA,W
	movwf	SYSWORDTEMPA
	movf	SYSDIVMULTA_H,W
	movwf	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable2
	retlw	1
	retlw	71	;G


StringTable3
	retlw	1
	retlw	99	;c


StringTable4
	retlw	1
	retlw	98	;b


StringTable5
	retlw	1
	retlw	32	; 


StringTable6
	retlw	1
	retlw	100	;d


StringTable7
	retlw	1
	retlw	101	;e


StringTable8
	retlw	1
	retlw	109	;m


StringTable9
	retlw	1
	retlw	111	;o


StringTable10
	retlw	1
	retlw	67	;C


StringTable11
	retlw	1
	retlw	104	;h


StringTable12
	retlw	1
	retlw	97	;a


StringTable13
	retlw	1
	retlw	114	;r


StringTable14
	retlw	1
	retlw	83	;S


StringTable15
	retlw	1
	retlw	80	;P


StringTable16
	retlw	1
	retlw	69	;E


StringTable17
	retlw	1
	retlw	73	;I


StringTable18
	retlw	1
	retlw	65	;A


StringTable19
	retlw	1
	retlw	76	;L


StringTable20
	retlw	1
	retlw	63	;?


StringTable21
	retlw	1
	retlw	45	;-


StringTable22
	retlw	1
	retlw	41	;)


StringTable23
	retlw	1
	retlw	72	;H


StringTable24
	retlw	1
	retlw	120	;x


StringTable25
	retlw	1
	retlw	68	;D


StringTable26
	retlw	1
	retlw	90	;Z


StringTable27
	retlw	1
	retlw	84	;T


StringTable28
	retlw	1
	retlw	108	;l


StringTable29
	retlw	1
	retlw	107	;k


StringTable30
	retlw	1
	retlw	79	;O


StringTable31
	retlw	1
	retlw	85	;U


StringTable32
	retlw	1
	retlw	110	;n


;********************************************************************************

;Source: TM1638.h (370)
TMDEC
;TM_reset
;TMValue must be in the range of 0 to 65535 (Dec)
;TMValue can be entered as dec, binary or hex
;TMsVal = 0
	clrf	TMSVAL
;TMeVal = 0
	clrf	TMEVAL
;TMhVal = 0
	clrf	TMHVAL
;TMlVal = 0
	clrf	TMLVAL
;TM1638_Colon = 0
	clrf	TM1638_COLON
;IF TMValue >= 10000 Then
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF21
;TMsVal = 17
	movlw	17
	movwf	TMSVAL
;TMeVal = 17
	movlw	17
	movwf	TMEVAL
;TMhVal = 17
	movlw	17
	movwf	TMHVAL
;TMlVal = 17
	movlw	17
	movwf	TMLVAL
;Goto TMWord1
	goto	TMWORD1
;End if
ENDIF21
TMWORD1000
;IF TMValue >= 1000 Then
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF22
;TMsVal = TMsVal + 1
	incf	TMSVAL,F
;TMValue = TMValue -1000
	movlw	232
	subwf	TMVALUE,F
	movlw	3
	subwfb	TMVALUE_H,F
;Goto TMWord1000
	goto	TMWORD1000
;End If
ENDIF22
TMWORD100
;IF TMValue >= 100 Then
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF23
;TMeVal = TMeVal + 1
	incf	TMEVAL,F
;TMValue = TMValue - 100
	movlw	100
	subwf	TMVALUE,F
	movlw	0
	subwfb	TMVALUE_H,F
;Goto TMWord100
	goto	TMWORD100
;End If
ENDIF23
TMWORD10
;IF TMValue >= 10 Then
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF24
;TMhVal = TMhVal + 1
	incf	TMHVAL,F
;TMValue = TMValue - 10
	movlw	10
	subwf	TMVALUE,F
	movlw	0
	subwfb	TMVALUE_H,F
;Goto TMWord10
	goto	TMWORD10
;End if
ENDIF24
;TMlVal = TMValue
	movf	TMVALUE,W
	movwf	TMLVAL
;if TM1638_Zero > 3 Then TM1638_Zero = 0
	movf	TM1638_ZERO,W
	sublw	3
	btfss	STATUS, C
;if TM1638_Zero > 3 Then TM1638_Zero = 0
	clrf	TM1638_ZERO
;if TM1638_Zero > 3 Then TM1638_Zero = 0
;if TM1638_Zero = 0 Or TM1638_Zero = 2 Then
	movf	TM1638_ZERO,W
	movwf	SysBYTETempA
	clrf	SysBYTETempB
	call	SYSCOMPEQUAL
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	TM1638_ZERO,W
	movwf	SysBYTETempA
	movlw	2
	movwf	SysBYTETempB
	call	SYSCOMPEQUAL
	movf	SysTemp1,W
	iorwf	SysByteTempX,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ENDIF26
;if TMsVal = 0 Then TMsVal = 16
	movf	TMSVAL,F
	btfss	STATUS, Z
	goto	ENDIF28
;if TMsVal = 0 Then TMsVal = 16
	movlw	16
	movwf	TMSVAL
;if TMsVal = 0 Then TMsVal = 16
ENDIF28
;if TMsVal = 16 And TMeVal = 0 Then TMeVal = 16
	movf	TMSVAL,W
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	call	SYSCOMPEQUAL
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	TMEVAL,W
	movwf	SysBYTETempA
	clrf	SysBYTETempB
	call	SYSCOMPEQUAL
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ENDIF29
;if TMsVal = 16 And TMeVal = 0 Then TMeVal = 16
	movlw	16
	movwf	TMEVAL
;if TMsVal = 16 And TMeVal = 0 Then TMeVal = 16
ENDIF29
;if TMeVal = 16 And TMhVal = 0 Then TMhVal = 16
	movf	TMEVAL,W
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	call	SYSCOMPEQUAL
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	TMHVAL,W
	movwf	SysBYTETempA
	clrf	SysBYTETempB
	call	SYSCOMPEQUAL
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ENDIF30
;if TMeVal = 16 And TMhVal = 0 Then TMhVal = 16
	movlw	16
	movwf	TMHVAL
;if TMeVal = 16 And TMhVal = 0 Then TMhVal = 16
ENDIF30
;End if
ENDIF26
;if TM1638_Zero > 1 Then TM1638_Colon = 1
	movf	TM1638_ZERO,W
	sublw	1
	btfsc	STATUS, C
	goto	ENDIF27
;if TM1638_Zero > 1 Then TM1638_Colon = 1
	movlw	1
	movwf	TM1638_COLON
;if TM1638_Zero > 1 Then TM1638_Colon = 1
ENDIF27
TMWORD1
;Write4Dig ( TMsVal, TMeVal, TMhVal, TMlVal,TMchar_Bright, TM1638_Colon)
	movf	TMSVAL,W
	movwf	TMDIG1
	movf	TMEVAL,W
	movwf	TMDIG2
	movf	TMHVAL,W
	movwf	TMDIG3
	movf	TMLVAL,W
	movwf	TMDIG4
	movf	TMCHAR_BRIGHT,W
	movwf	BRIGHT
	movf	TM1638_COLON,W
	movwf	COLONON
	goto	WRITE4DIG

;********************************************************************************

;Source: TM1638.h (421)
TMHEX
;TM_reset
;TMValue must be in the range of 0 to 65535 (Dec)
;TMValue can be entered as dec, binary or hex
;TMsVal = 0
	clrf	TMSVAL
;TMeVal = 0
	clrf	TMEVAL
;TMhVal = 0
	clrf	TMHVAL
;TMlVal = 0
	clrf	TMLVAL
;IF TMValue >= 4096 Then
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	movlw	16
	movwf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF31
;TMsVal = TMValue / 4096
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	movlw	16
	movwf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	TMSVAL
;TMValue = TMValue % 4096
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	movlw	16
	movwf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempX,W
	movwf	TMVALUE
	movf	SysWORDTempX_H,W
	movwf	TMVALUE_H
;End If
ENDIF31
;IF TMValue >= 256 Then
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF32
;TMeVal = TMValue / 256
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	TMEVAL
;TMValue = TMValue % 256
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempX,W
	movwf	TMVALUE
	movf	SysWORDTempX_H,W
	movwf	TMVALUE_H
;End If
ENDIF32
;IF TMValue >= 16 Then
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF33
;TMhVal = TMValue / 16
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	TMHVAL
;TMlVal = TMValue % 16
	movf	TMVALUE,W
	movwf	SysWORDTempA
	movf	TMVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempX,W
	movwf	TMLVAL
;End If
ENDIF33
;Write4Dig ( TMsVal, TMeVal, TMhVal, TMlVal,TMchar_Bright,0)
	movf	TMSVAL,W
	movwf	TMDIG1
	movf	TMEVAL,W
	movwf	TMDIG2
	movf	TMHVAL,W
	movwf	TMDIG3
	movf	TMLVAL,W
	movwf	TMDIG4
	movf	TMCHAR_BRIGHT,W
	movwf	BRIGHT
	clrf	COLONON
	goto	WRITE4DIG

;********************************************************************************

;Source: TM1638.h (298)
TM_DISPLAY7SEG
;sendCommand(TM_WRITE_LOC)
	movlw	68
	movwf	VALUE
	call	SENDCOMMAND
;set TM1638_STB off
	banksel	LATC
	bcf	LATC,2
;sendData(TM_SEG_ADR + (TMaddr *2))
	bcf	STATUS,C
	banksel	TMADDR
	rlf	TMADDR,W
	movwf	SysTemp1
	movlw	192
	addwf	SysTemp1,W
	movwf	DATA
	call	SENDDATA
;sendData(TMseg1)
	movf	TMSEG1,W
	movwf	DATA
	call	SENDDATA
	movf	DATA,W
	movwf	TMSEG1
;set TM1638_STB on
	banksel	LATC
	bsf	LATC,2
	banksel	STATUS
	return

;********************************************************************************

;Source: TM1638.h (157)
TM_RESET
;sendCommand(TM_WRITE_INC)' set auto increment mode
	movlw	64
	movwf	VALUE
	call	SENDCOMMAND
;set TM1638_STB off
	banksel	LATC
	bcf	LATC,2
;sendData(TM_SEG_ADR)  ' set starting address to
	movlw	192
	banksel	DATA
	movwf	DATA
	call	SENDDATA
;repeat 16
	movlw	16
	movwf	SysRepeatTemp3
SysRepeatLoop3
;sendData(0x00)  'sendData(0x00)
	clrf	DATA
	call	SENDDATA
;end repeat
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
;set TM1638_STB on
	banksel	LATC
	bsf	LATC,2
	banksel	STATUS
	return

;********************************************************************************

;Source: TM1638.h (275)
WRITE4DIG
;TMdigx is number 0 -15 , 16 =sp , 17 = -
;convert digit number to 7segments
;ReadTable SevenSegDispDigit, TMdig1 + 1, TMseg1
	incf	TMDIG1,W
	movwf	SYSSTRINGA
	call	SEVENSEGDISPDIGIT
	movwf	TMSEG1
;ReadTable SevenSegDispDigit, TMdig2 + 1, TMseg2
	incf	TMDIG2,W
	movwf	SYSSTRINGA
	call	SEVENSEGDISPDIGIT
	movwf	TMSEG2
;ReadTable SevenSegDispDigit, TMdig3 + 1, TMseg3
	incf	TMDIG3,W
	movwf	SYSSTRINGA
	call	SEVENSEGDISPDIGIT
	movwf	TMSEG3
;ReadTable SevenSegDispDigit, TMdig4 + 1, TMseg4
	incf	TMDIG4,W
	movwf	SYSSTRINGA
	call	SEVENSEGDISPDIGIT
	movwf	TMSEG4
;If ColonON = 1 then
	decf	COLONON,W
	btfss	STATUS, Z
	goto	ENDIF10
;TMseg2 = TMseg2 | 0B10000000   'turns on the colon
	movlw	128
	iorwf	TMSEG2,F
;End if
ENDIF10
;sendCommand(0x44)
	movlw	68
	movwf	VALUE
	call	SENDCOMMAND
;TMchar_Bright = Bright
	movf	BRIGHT,W
	movwf	TMCHAR_BRIGHT
;value = TM_BRIGHT_ADR +  TMchar_Bright   'brightness
;SendCommand( TM_BRIGHT_ADR + (TM_BRIGHT_MASK & Bright))
	movlw	7
	andwf	BRIGHT,W
	movwf	SysTemp1
	movlw	136
	addwf	SysTemp1,W
	movwf	VALUE
	call	SENDCOMMAND
;WriteChar(0,TMdig1)
;wait 2 s
;TM_display7Seg (0,TMseg1)
	clrf	TMADDR
	call	TM_DISPLAY7SEG
;TM_display7Seg (1,TMseg2)
	movlw	1
	movwf	TMADDR
	movf	TMSEG2,W
	movwf	TMSEG1
	call	TM_DISPLAY7SEG
	movf	TMSEG1,W
	movwf	TMSEG2
;TM_display7Seg (2,TMseg3)
	movlw	2
	movwf	TMADDR
	movf	TMSEG3,W
	movwf	TMSEG1
	call	TM_DISPLAY7SEG
	movf	TMSEG1,W
	movwf	TMSEG3
;TM_display7Seg (3,TMseg4)
	movlw	3
	movwf	TMADDR
	movf	TMSEG4,W
	movwf	TMSEG1
	call	TM_DISPLAY7SEG
	movf	TMSEG1,W
	movwf	TMSEG4
	return

;********************************************************************************

;Source: TM1638.h (313)
WRITECHAR
;TMaddr  0 ,1, 2 ,3    digit postion to display
;TMchar   ascii character  to display
;if TMchar_Bright > 15 then TMchar_Bright = 15
	movf	TMCHAR_BRIGHT,W
	sublw	15
	btfsc	STATUS, C
	goto	ENDIF11
;if TMchar_Bright > 15 then TMchar_Bright = 15
	movlw	15
	movwf	TMCHAR_BRIGHT
;if TMchar_Bright > 15 then TMchar_Bright = 15
ENDIF11
;value = TM_BRIGHT_ADR + (TM_BRIGHT_MASK & TMchar_Bright)   'brightness
	movlw	7
	andwf	TMCHAR_BRIGHT,W
	movwf	SysTemp1
	movlw	136
	addwf	SysTemp1,W
	movwf	VALUE
;SendCommand(value)
	call	SENDCOMMAND
;write ascii letter or number or sp or -
;If TMchar = 32 Then     ' space?
	movlw	32
	subwf	TMCHAR,W
	btfss	STATUS, Z
	goto	ENDIF12
;TMseg1 = 0
	clrf	TMSEG1
;Goto ShowChar
	goto	SHOWCHAR
;End if
ENDIF12
;-
;If TMchar = 45 Then      'minus -
	movlw	45
	subwf	TMCHAR,W
	btfss	STATUS, Z
	goto	ENDIF13
;TMseg1 = 64
	movlw	64
	movwf	TMSEG1
;Goto ShowChar
	goto	SHOWCHAR
;End if
ENDIF13
;If TMchar = 41 Then     ' )
	movlw	41
	subwf	TMCHAR,W
	btfss	STATUS, Z
	goto	ENDIF14
;TMseg1 = 15
	movlw	15
	movwf	TMSEG1
;Goto ShowChar
	goto	SHOWCHAR
;End if
ENDIF14
;If TMchar = 176 Then     '
	movlw	176
	subwf	TMCHAR,W
	btfss	STATUS, Z
	goto	ENDIF15
;TMseg1 = 99
	movlw	99
	movwf	TMSEG1
;Goto ShowChar
	goto	SHOWCHAR
;End if
ENDIF15
;If TMchar = 63 Then     ' ?
	movlw	63
	subwf	TMCHAR,W
	btfss	STATUS, Z
	goto	ENDIF16
;TMseg1 = 83
	movlw	83
	movwf	TMSEG1
;Goto ShowChar
	goto	SHOWCHAR
;End if
ENDIF16
;Numbers
;If TMchar >= 48 And TMchar <= 57 Then
	movf	TMCHAR,W
	movwf	SysBYTETempA
	movlw	48
	movwf	SysBYTETempB
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	TMCHAR,W
	movwf	SysBYTETempB
	movlw	57
	movwf	SysBYTETempA
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ENDIF17
;ReadTable SevenSegDispDigit,  TMchar-47, TMseg1
	movlw	47
	subwf	TMCHAR,W
	movwf	SYSSTRINGA
	call	SEVENSEGDISPDIGIT
	movwf	TMSEG1
;Goto ShowChar
	goto	SHOWCHAR
;End If
ENDIF17
;If TMchar < 65 Then Exit Sub    'should have been covered as number and space and -
	movlw	65
	subwf	TMCHAR,W
	btfss	STATUS, C
;If TMchar < 65 Then Exit Sub    'should have been covered as number and space and -
	return
;If TMchar < 65 Then Exit Sub    'should have been covered as number and space and -
;Convert to upper case
;If TMchar > 96 Then           ' small case letter use Siekoo alphabet
	movf	TMCHAR,W
	sublw	96
	btfsc	STATUS, C
	goto	ENDIF19
;TMchar = TMchar - 6
	movlw	6
	subwf	TMCHAR,F
;End if
ENDIF19
;Exit if not a letter
;If TMchar > 116 Then Exit Sub
	movf	TMCHAR,W
	sublw	116
	btfss	STATUS, C
;If TMchar > 116 Then Exit Sub
	return
;If TMchar > 116 Then Exit Sub
;Convert to code for output
;ReadTable SevenSegDispLetter, TMchar -64, TMseg1
	movlw	64
	subwf	TMCHAR,W
	movwf	SYSSTRINGA
	call	SEVENSEGDISPLETTER
	movwf	TMSEG1
SHOWCHAR
;TM_display7Seg(TMaddr,  TMseg1)
	goto	TM_DISPLAY7SEG

;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144

 END
