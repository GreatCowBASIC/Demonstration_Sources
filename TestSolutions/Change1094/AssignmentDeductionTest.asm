;Program compiled by Great Cow BASIC (0.99.02 2022-08-03 (Windows 32 bit) : Build 1094) for Microchip MPASM/MPLAB-X Assembler
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F877A, r=DEC
#include <P16F877A.inc>
 __CONFIG _CP_OFF & _WRT_OFF & _CPD_OFF & _LVP_OFF & _WDTE_OFF & _FOSC_XT

;********************************************************************************

;Set aside memory locations for variables
COMPORT                          EQU 32
DELAY_TIME_B                     EQU 33
DELAY_TIME_I                     EQU 34
DELAY_TIME_I_H                   EQU 35
DELAY_TIME_L                     EQU 36
DELAY_TIME_L_E                   EQU 39
DELAY_TIME_L_H                   EQU 37
DELAY_TIME_L_U                   EQU 38
DELAY_TIME_W                     EQU 40
DELAY_TIME_W_H                   EQU 41
DESCEND_START_B                  EQU 42
DESCEND_START_I                  EQU 43
DESCEND_START_I_H                EQU 44
DESCEND_START_L                  EQU 45
DESCEND_START_L_E                EQU 48
DESCEND_START_L_H                EQU 46
DESCEND_START_L_U                EQU 47
DESCEND_START_W                  EQU 49
DESCEND_START_W_H                EQU 50
HSERPRINTCRLFCOUNT               EQU 51
OUTVALUETEMP                     EQU 52
PRINTLEN                         EQU 53
SERDATA                          EQU 54
SERPRINTVAL                      EQU 55
SERPRINTVALINT                   EQU 59
SERPRINTVALINT_H                 EQU 60
SERPRINTVAL_E                    EQU 58
SERPRINTVAL_H                    EQU 56
SERPRINTVAL_U                    EQU 57
STRINGPOINTER                    EQU 61
SYSBYTETEMPA                     EQU 117
SYSBYTETEMPB                     EQU 121
SYSBYTETEMPX                     EQU 112
SYSCALCTEMPA                     EQU 117
SYSCALCTEMPA_E                   EQU 120
SYSCALCTEMPA_H                   EQU 118
SYSCALCTEMPA_U                   EQU 119
SYSCALCTEMPX                     EQU 112
SYSCALCTEMPX_H                   EQU 113
SYSDIVLOOP                       EQU 116
SYSDIVMULTA                      EQU 119
SYSDIVMULTA_H                    EQU 120
SYSDIVMULTB                      EQU 123
SYSDIVMULTB_H                    EQU 124
SYSDIVMULTX                      EQU 114
SYSDIVMULTX_H                    EQU 115
SYSFORLOOPSTEP1                  EQU 62
SYSFORLOOPSTEP1_H                EQU 63
SYSINTEGERTEMPA                  EQU 117
SYSINTEGERTEMPA_H                EQU 118
SYSINTEGERTEMPB                  EQU 121
SYSINTEGERTEMPB_H                EQU 122
SYSLONGDIVMULTA                  EQU 64
SYSLONGDIVMULTA_E                EQU 67
SYSLONGDIVMULTA_H                EQU 65
SYSLONGDIVMULTA_U                EQU 66
SYSLONGDIVMULTB                  EQU 68
SYSLONGDIVMULTB_E                EQU 71
SYSLONGDIVMULTB_H                EQU 69
SYSLONGDIVMULTB_U                EQU 70
SYSLONGDIVMULTX                  EQU 72
SYSLONGDIVMULTX_E                EQU 75
SYSLONGDIVMULTX_H                EQU 73
SYSLONGDIVMULTX_U                EQU 74
SYSLONGTEMPA                     EQU 117
SYSLONGTEMPA_E                   EQU 120
SYSLONGTEMPA_H                   EQU 118
SYSLONGTEMPA_U                   EQU 119
SYSLONGTEMPB                     EQU 121
SYSLONGTEMPB_E                   EQU 124
SYSLONGTEMPB_H                   EQU 122
SYSLONGTEMPB_U                   EQU 123
SYSLONGTEMPX                     EQU 112
SYSLONGTEMPX_E                   EQU 115
SYSLONGTEMPX_H                   EQU 113
SYSLONGTEMPX_U                   EQU 114
SYSPRINTBUFFER                   EQU 485
SYSPRINTBUFFLEN                  EQU 76
SYSPRINTDATAHANDLER              EQU 77
SYSPRINTDATAHANDLER_H            EQU 78
SYSPRINTTEMP                     EQU 79
SYSREPEATTEMP1                   EQU 80
SYSSTRINGA                       EQU 119
SYSSTRINGA_H                     EQU 120
SYSSTRINGB                       EQU 114
SYSSTRINGB_H                     EQU 115
SYSSTRINGLENGTH                  EQU 118
SYSSTRINGPARAM1                  EQU 481
SYSTEMP1                         EQU 81
SYSTEMP1_E                       EQU 84
SYSTEMP1_H                       EQU 82
SYSTEMP1_U                       EQU 83
SYSTEMP2                         EQU 85
SYSTEMP3                         EQU 86
SYSWORDTEMPA                     EQU 117
SYSWORDTEMPA_H                   EQU 118
SYSWORDTEMPB                     EQU 121
SYSWORDTEMPB_H                   EQU 122
SYSWORDTEMPX                     EQU 112
SYSWORDTEMPX_H                   EQU 113

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
	call	INITUSART

;Start of the main program
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------
;''This program verifies the compiler correctly assigns a calculated value.
;''
;''
;''@author    Evan
;''@license   GPL
;''@version   1.00
;''@date      2022-03-08
;''********************************************************************************
;#DEFINE DISABLE1094
;#DEFINE USART_BAUD_RATE 9600
;#DEFINE USART_TX_BLOCKING
;#DEFINE USART_DELAY OFF
;Dim Descend_start_i as Integer
;Dim Delay_time_i as Integer
;Dim Delay_result_i as Integer
;Calc is
;291-134 = 157
;Descend_start_i   = 291
	movlw	35
	movwf	DESCEND_START_I
	movlw	1
	movwf	DESCEND_START_I_H
;Delay_time_i      = 134
	movlw	134
	movwf	DELAY_TIME_I
	clrf	DELAY_TIME_I_H
;Delay_time_i = (Descend_start_i - Delay_time_i)
	movf	DELAY_TIME_I,W
	subwf	DESCEND_START_I,W
	movwf	SysTemp1
	movf	DESCEND_START_I_H,W
	movwf	SysTemp1_H
	movf	DELAY_TIME_I_H,W
	btfss	STATUS,C
	incfsz	DELAY_TIME_I_H,W
	subwf	SysTemp1_H,F
	movf	SysTemp1,W
	movwf	DELAY_TIME_I
	movf	SysTemp1_H,W
	movwf	DELAY_TIME_I_H
;HSerPrint Delay_time_i
	movf	DELAY_TIME_I,W
	movwf	SERPRINTVALINT
	movf	DELAY_TIME_I_H,W
	movwf	SERPRINTVALINT_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT306
;HSerPrint " : "
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	high StringTable1
	movwf	SysStringA_H
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
;SYSSTRINGPARAM*1
	call	HSERPRINT303
;Descend_start_i   = 291
	movlw	35
	movwf	DESCEND_START_I
	movlw	1
	movwf	DESCEND_START_I_H
;Delay_time_i      = 134
	movlw	134
	movwf	DELAY_TIME_I
	clrf	DELAY_TIME_I_H
;Delay_time_i = (Descend_start_i - Delay_time_i)*1
	movf	DELAY_TIME_I,W
	subwf	DESCEND_START_I,W
	movwf	SysTemp1
	movf	DESCEND_START_I_H,W
	movwf	SysTemp1_H
	movf	DELAY_TIME_I_H,W
	btfss	STATUS,C
	incfsz	DELAY_TIME_I_H,W
	subwf	SysTemp1_H,F
	movf	SysTemp1,W
	movwf	DELAY_TIME_I
	movf	SysTemp1_H,W
	movwf	DELAY_TIME_I_H
;HSerPrint Delay_time_i
	movf	DELAY_TIME_I,W
	movwf	SERPRINTVALINT
	movf	DELAY_TIME_I_H,W
	movwf	SERPRINTVALINT_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT306
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;Dim Descend_start_b as byte
;Dim Delay_time_b as byte
;Dim Delay_result_b as byte
;Calc is
;191-34 = 57
;Descend_start_b   = 191
	movlw	191
	movwf	DESCEND_START_B
;Delay_time_b      = 34
	movlw	34
	movwf	DELAY_TIME_B
;Delay_time_b = (Descend_start_b - Delay_time_b)
	subwf	DESCEND_START_B,W
	movwf	DELAY_TIME_B
;HSerPrint Delay_time_b
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	call	HSERPRINT304
;HSerPrint " : "
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	high StringTable1
	movwf	SysStringA_H
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
;SYSSTRINGPARAM*1
	call	HSERPRINT303
;Descend_start_b   = 191
	movlw	191
	movwf	DESCEND_START_B
;Delay_time_b      = 34
	movlw	34
	movwf	DELAY_TIME_B
;Delay_time_b = (Descend_start_b - Delay_time_b)*1
	subwf	DESCEND_START_B,W
	movwf	SysTemp1
	movwf	DELAY_TIME_B
;HSerPrint Delay_time_b
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	call	HSERPRINT304
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;Dim Descend_start_w as Word
;Dim Delay_time_w as Word
;Dim Delay_result_w as Word
;Calc is
;291-134 = 157
;Descend_start_w   = 291
	movlw	35
	movwf	DESCEND_START_W
	movlw	1
	movwf	DESCEND_START_W_H
;Delay_time_w      = 134
	movlw	134
	movwf	DELAY_TIME_W
	clrf	DELAY_TIME_W_H
;Delay_time_w = (Descend_start_w - Delay_time_w)
	movf	DELAY_TIME_W,W
	subwf	DESCEND_START_W,W
	movwf	SysTemp1
	movf	DESCEND_START_W_H,W
	movwf	SysTemp1_H
	movf	DELAY_TIME_W_H,W
	btfss	STATUS,C
	incfsz	DELAY_TIME_W_H,W
	subwf	SysTemp1_H,F
	movf	SysTemp1,W
	movwf	DELAY_TIME_W
	movf	SysTemp1_H,W
	movwf	DELAY_TIME_W_H
;HSerPrint Delay_time_w
	movf	DELAY_TIME_W,W
	movwf	SERPRINTVAL
	movf	DELAY_TIME_W_H,W
	movwf	SERPRINTVAL_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT305
;HSerPrint " : "
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	high StringTable1
	movwf	SysStringA_H
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
;SYSSTRINGPARAM*1
	call	HSERPRINT303
;Descend_start_w   = 291
	movlw	35
	movwf	DESCEND_START_W
	movlw	1
	movwf	DESCEND_START_W_H
;Delay_time_w      = 134
	movlw	134
	movwf	DELAY_TIME_W
	clrf	DELAY_TIME_W_H
;Delay_time_w = (Descend_start_w - Delay_time_w)*1
	movf	DELAY_TIME_W,W
	subwf	DESCEND_START_W,W
	movwf	SysTemp1
	movf	DESCEND_START_W_H,W
	movwf	SysTemp1_H
	movf	DELAY_TIME_W_H,W
	btfss	STATUS,C
	incfsz	DELAY_TIME_W_H,W
	subwf	SysTemp1_H,F
	movf	SysTemp1,W
	movwf	DELAY_TIME_W
	movf	SysTemp1_H,W
	movwf	DELAY_TIME_W_H
;HSerPrint Delay_time_w
	movf	DELAY_TIME_W,W
	movwf	SERPRINTVAL
	movf	DELAY_TIME_W_H,W
	movwf	SERPRINTVAL_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT305
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;Dim Descend_start_l as Long
;Dim Delay_time_l as Long
;Dim Delay_result_l as Long
;Calc is
;291-134 = 157
;Descend_start_l   = 291
	movlw	35
	movwf	DESCEND_START_L
	movlw	1
	movwf	DESCEND_START_L_H
	clrf	DESCEND_START_L_U
	clrf	DESCEND_START_L_E
;Delay_time_l      = 134
	movlw	134
	movwf	DELAY_TIME_L
	clrf	DELAY_TIME_L_H
	clrf	DELAY_TIME_L_U
	clrf	DELAY_TIME_L_E
;Delay_time_l = (Descend_start_l - Delay_time_l)
	movf	DELAY_TIME_L,W
	subwf	DESCEND_START_L,W
	movwf	SysTemp1
	movf	DESCEND_START_L_H,W
	movwf	SysTemp1_H
	movf	DELAY_TIME_L_H,W
	btfss	STATUS,C
	incfsz	DELAY_TIME_L_H,W
	subwf	SysTemp1_H,F
	movf	DESCEND_START_L_U,W
	movwf	SysTemp1_U
	movf	DELAY_TIME_L_U,W
	btfss	STATUS,C
	incfsz	DELAY_TIME_L_U,W
	subwf	SysTemp1_U,F
	movf	DESCEND_START_L_E,W
	movwf	SysTemp1_E
	movf	DELAY_TIME_L_E,W
	btfss	STATUS,C
	incfsz	DELAY_TIME_L_E,W
	subwf	SysTemp1_E,F
	movf	SysTemp1,W
	movwf	DELAY_TIME_L
	movf	SysTemp1_H,W
	movwf	DELAY_TIME_L_H
	movf	SysTemp1_U,W
	movwf	DELAY_TIME_L_U
	movf	SysTemp1_E,W
	movwf	DELAY_TIME_L_E
;HSerPrint Delay_time_l
	movf	DELAY_TIME_L,W
	movwf	SERPRINTVAL
	movf	DELAY_TIME_L_H,W
	movwf	SERPRINTVAL_H
	movf	DELAY_TIME_L_U,W
	movwf	SERPRINTVAL_U
	movf	DELAY_TIME_L_E,W
	movwf	SERPRINTVAL_E
	movlw	1
	movwf	COMPORT
	call	HSERPRINT307
;HSerPrint " : "
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	high StringTable1
	movwf	SysStringA_H
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
;SYSSTRINGPARAM*1
	call	HSERPRINT303
;Descend_start_l   = 291
	movlw	35
	movwf	DESCEND_START_L
	movlw	1
	movwf	DESCEND_START_L_H
	clrf	DESCEND_START_L_U
	clrf	DESCEND_START_L_E
;Delay_time_l      = 134
	movlw	134
	movwf	DELAY_TIME_L
	clrf	DELAY_TIME_L_H
	clrf	DELAY_TIME_L_U
	clrf	DELAY_TIME_L_E
;Delay_time_l = (Descend_start_l - Delay_time_l)*1
	movf	DELAY_TIME_L,W
	subwf	DESCEND_START_L,W
	movwf	SysTemp1
	movf	DESCEND_START_L_H,W
	movwf	SysTemp1_H
	movf	DELAY_TIME_L_H,W
	btfss	STATUS,C
	incfsz	DELAY_TIME_L_H,W
	subwf	SysTemp1_H,F
	movf	DESCEND_START_L_U,W
	movwf	SysTemp1_U
	movf	DELAY_TIME_L_U,W
	btfss	STATUS,C
	incfsz	DELAY_TIME_L_U,W
	subwf	SysTemp1_U,F
	movf	DESCEND_START_L_E,W
	movwf	SysTemp1_E
	movf	DELAY_TIME_L_E,W
	btfss	STATUS,C
	incfsz	DELAY_TIME_L_E,W
	subwf	SysTemp1_E,F
	movf	SysTemp1,W
	movwf	DELAY_TIME_L
	movf	SysTemp1_H,W
	movwf	DELAY_TIME_L_H
	movf	SysTemp1_U,W
	movwf	DELAY_TIME_L_U
	movf	SysTemp1_E,W
	movwf	DELAY_TIME_L_E
;HSerPrint Delay_time_l
	movf	DELAY_TIME_L,W
	movwf	SERPRINTVAL
	movf	DELAY_TIME_L_H,W
	movwf	SERPRINTVAL_H
	movf	DELAY_TIME_L_U,W
	movwf	SERPRINTVAL_U
	movf	DELAY_TIME_L_E,W
	movwf	SERPRINTVAL_E
	movlw	1
	movwf	COMPORT
	call	HSERPRINT307
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (1467)
HSERPRINT303
;PrintLen = PrintData(0)
	movf	SysPRINTDATAHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysPRINTDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	goto	ENDIF11
;Write Data
;for SysPrintTemp = 1 to PrintLen
	movlw	1
	movwf	SYSPRINTTEMP
SysForLoop1
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysPRINTDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	SERDATA
	call	HSERSEND293
;next
;#4p Positive value Step Handler in For-next statement
	movf	SYSPRINTTEMP,W
	subwf	PRINTLEN,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	clrf	SysBYTETempB
	call	SYSCOMPEQUAL
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF12
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	incf	SYSPRINTTEMP,F
	goto	SysForLoop1
;END IF
ENDIF12
SysForLoopEnd1
;End If
ENDIF11
;CR
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (1490)
HSERPRINT304
;OutValueTemp = 0
	clrf	OUTVALUETEMP
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W
	btfss	STATUS, C
	goto	ENDIF13
;OutValueTemp = SerPrintVal / 100
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	100
	movwf	SysBYTETempB
	call	SYSDIVSUB
	movf	SysBYTETempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	call	HSERSEND293
;End If
ENDIF13
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movf	OUTVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	call	SYSCOMPLESSTHAN
	movf	SysByteTempX,W
	movwf	SysTemp2
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F
	movf	SysTemp2,W
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF14
;OutValueTemp = SerPrintVal / 10
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SYSDIVSUB
	movf	SysBYTETempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	call	HSERSEND293
;End If
ENDIF14
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W
	movwf	SERDATA
	goto	HSERSEND293
;CR

;********************************************************************************

;Overloaded signature: WORD:byte:, Source: usart.h (1519)
HSERPRINT305
;Dim SysCalcTempX As Word
;OutValueTemp = 0
	clrf	OUTVALUETEMP
;If SerPrintVal >= 10000 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF15
;OutValueTemp = SerPrintVal / 10000 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	call	HSERSEND293
;Goto HSerPrintWord1000
	goto	HSERPRINTWORD1000
;End If
ENDIF15
;If SerPrintVal >= 1000 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF16
HSERPRINTWORD1000
;OutValueTemp = SerPrintVal / 1000 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport  )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	call	HSERSEND293
;Goto HSerPrintWord100
	goto	HSERPRINTWORD100
;End If
ENDIF16
;If SerPrintVal >= 100 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF17
HSERPRINTWORD100
;OutValueTemp = SerPrintVal / 100 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	call	HSERSEND293
;Goto HSerPrintWord10
	goto	HSERPRINTWORD10
;End If
ENDIF17
;If SerPrintVal >= 10 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF18
HSERPRINTWORD10
;OutValueTemp = SerPrintVal / 10 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	call	HSERSEND293
;End If
ENDIF18
;HSerSend(SerPrintVal + 48 ,comport  )
	movlw	48
	addwf	SERPRINTVAL,W
	movwf	SERDATA
	goto	HSERSEND292
;CR

;********************************************************************************

;Overloaded signature: INTEGER:byte:, Source: usart.h (1568)
HSERPRINT306
;Dim SerPrintVal As Word
;If sign bit is on, print - sign and then negate
;If SerPrintValInt.15 = On Then
	btfss	SERPRINTVALINT_H,7
	goto	ELSE19_1
;HSerSend("-",comport )
	movlw	45
	movwf	SERDATA
	call	HSERSEND292
;SerPrintVal = -SerPrintValInt
	comf	SERPRINTVALINT,W
	movwf	SERPRINTVAL
	comf	SERPRINTVALINT_H,W
	movwf	SERPRINTVAL_H
	incf	SERPRINTVAL,F
	btfsc	STATUS,Z
	incf	SERPRINTVAL_H,F
;Sign bit off, so just copy value
;Else
	goto	ENDIF19
ELSE19_1
;SerPrintVal = SerPrintValInt
	movf	SERPRINTVALINT,W
	movwf	SERPRINTVAL
	movf	SERPRINTVALINT_H,W
	movwf	SERPRINTVAL_H
;End If
ENDIF19
;Use Print(word) to display value
;HSerPrint SerPrintVal,comport
	goto	HSERPRINT305

;********************************************************************************

;Overloaded signature: LONG:byte:, Source: usart.h (1587)
HSERPRINT307
;Dim SysCalcTempA As Long
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	clrf	SYSPRINTBUFFLEN
;Do
SysDoLoop_S1
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	incf	SYSPRINTBUFFLEN,F
;SysPrintBuffer(SysPrintBuffLen) = SerPrintVal % 10
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTBUFFLEN,W
	movwf	FSR
	bankisel	SYSPRINTBUFFER
	movf	SERPRINTVAL,W
	movwf	SysLONGTempA
	movf	SERPRINTVAL_H,W
	movwf	SysLONGTempA_H
	movf	SERPRINTVAL_U,W
	movwf	SysLONGTempA_U
	movf	SERPRINTVAL_E,W
	movwf	SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SYSDIVSUB32
	movf	SysLONGTempX,W
	movwf	INDF
;SerPrintVal = SysCalcTempA
	movf	SYSCALCTEMPA,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPA_H,W
	movwf	SERPRINTVAL_H
	movf	SYSCALCTEMPA_U,W
	movwf	SERPRINTVAL_U
	movf	SYSCALCTEMPA_E,W
	movwf	SERPRINTVAL_E
;Loop While SerPrintVal <> 0
	movf	serprintval,W
	movwf	SysLONGTempA
	movf	serprintval_H,W
	movwf	SysLONGTempA_H
	movf	serprintval_U,W
	movwf	SysLONGTempA_U
	movf	serprintval_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SYSCOMPEQUAL32
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysDoLoop_S1
SysDoLoop_E1
;Display
;For SysPrintTemp = SysPrintBuffLen To 1 Step -1
	movf	SYSPRINTBUFFLEN,W
	movwf	SYSPRINTTEMP
SysForLoop2
;#0 Init SysForLoopStep1
	movlw	255
	movwf	SysForLoopStep1
	movwf	SysForLoopStep1_H
;HSerSend(SysPrintBuffer(SysPrintTemp) + 48, comport  )
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTTEMP,W
	movwf	FSR
	bankisel	SYSPRINTBUFFER
	movlw	48
	addwf	INDF,W
	movwf	SERDATA
	call	HSERSEND293
;Next
;Integer negative Step Handler in For-next statement
	btfss	SYSFORLOOPSTEP1_H,7
	goto	ELSE20_1
;#3n IF ( SYSPRINTTEMP - 1) } -SysForLoopStep1 THEN 
	decf	SYSPRINTTEMP,W
	movwf	SysTemp2
	comf	SysForLoopStep1,W
	movwf	SysTemp1
	comf	SysForLoopStep1_H,W
	movwf	SysTemp1_H
	incf	SysTemp1,F
	btfsc	STATUS,Z
	incf	SysTemp1_H,F
	movf	SysTemp2,W
	movwf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	movf	SysTemp1,W
	movwf	SysINTEGERTempB
	movf	SysTemp1_H,W
	movwf	SysINTEGERTempB_H
	call	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF21
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	movf	SysForLoopStep1,W
	addwf	SYSPRINTTEMP,F
	goto	SysForLoop2
;END IF
ENDIF21
	goto	ENDIF20
ELSE20_1
;Integer positive Step Handler in For-next statement
;#3p IF (1 - SYSPRINTTEMP) } SysForLoopStep1 THEN
	movf	SYSPRINTTEMP,W
	sublw	1
	movwf	SysTemp2
	movwf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	movf	SysForLoopStep1,W
	movwf	SysINTEGERTempB
	movf	SysForLoopStep1_H,W
	movwf	SysINTEGERTempB_H
	call	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF22
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	movf	SysForLoopStep1,W
	addwf	SYSPRINTTEMP,F
	goto	SysForLoop2
;END IF
ENDIF22
;END IF
ENDIF20
SysForLoopEnd2
;CR
	return

;********************************************************************************

;Source: usart.h (1623)
HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movf	HSERPRINTCRLFCOUNT,W
	movwf	SysRepeatTemp1
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd1
SysRepeatLoop1
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA
	call	HSERSEND293
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA
	call	HSERSEND293
;end Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (815)
HSERSEND292
;Registers/Bits determined by #samevar at top of library
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop1
	btfss	PIR1,TXIF
	goto	SysWaitLoop1
;ensure any previous operation has completed @1
;Wait until TRMT = 1
SysWaitLoop2
	banksel	TXSTA
	btfss	TXSTA,TRMT
	goto	SysWaitLoop2
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	banksel	SERDATA
	movf	SERDATA,W
	movwf	TXREG
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (918)
HSERSEND293
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF38
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop3
	btfss	PIR1,TXIF
	goto	SysWaitLoop3
;ensure any previous operation has completed
;Wait until TRMT = 1
SysWaitLoop4
	banksel	TXSTA
	btfss	TXSTA,TRMT
	goto	SysWaitLoop4
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	banksel	SERDATA
	movf	SERDATA,W
	movwf	TXREG
;end if
ENDIF38
	return

;********************************************************************************

;Source: system.h (158)
INITSYS
;asm showdebug _For_selected_frequency_-_the_external_oscillator_has_been_selected_by_compiler ChipMHz
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	banksel	ADCON0
	bcf	ADCON0,ADON
;[canskip] PCFG3, PCFG2, PCFG1, PCFG0 = b'0110'
	banksel	ADCON1
	bcf	ADCON1,PCFG3
	bsf	ADCON1,PCFG2
	bsf	ADCON1,PCFG1
	bcf	ADCON1,PCFG0
;Turn off comparator - this is the default setting
;CMCON = 7
	movlw	7
	movwf	CMCON
;
;'Turn off all ports
;PORTA = 0
	banksel	PORTA
	clrf	PORTA
;PORTB = 0
	clrf	PORTB
;PORTC = 0
	clrf	PORTC
;PORTD = 0
	clrf	PORTD
;PORTE = 0
	clrf	PORTE
	return

;********************************************************************************

;Source: usart.h (583)
INITUSART
;asm showdebug Values_calculated_in_the_script
;asm showdebug _SPBRGH_TEMP=_ SPBRGH_TEMP
;asm showdebug _SPBRGL_TEMP=_ SPBRGL_TEMP
;asm showdebug _BRG16_TEMP=_ BRG16_TEMP
;asm showdebug _BRGH_TEMP=_ BRGH_TEMP
;Set baud rate for legacy chips
;SPBRG = SPBRGL_TEMP
	movlw	25
	banksel	SPBRG
	movwf	SPBRG
;Set High Baud Rate Select bit
;BRGH = BRGH_TEMP
	bsf	TXSTA,BRGH
;Enable async and TX mode for most non K42
;Set SYNC Off
;Set TXEN On
;Changed to canskip to silently exit when no USART
;[canskip]SYNC=0
	bcf	TXSTA,SYNC
;[canskip]TXEN=1
	bsf	TXSTA,TXEN
;SPEN=1
	banksel	RCSTA
	bsf	RCSTA,SPEN
;Enable TX and RX
;CREN=1
	bsf	RCSTA,CREN
	return

;********************************************************************************

;Source: system.h (2999)
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

;Source: system.h (3025)
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

;Source: system.h (3079)
SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysLongTempA, W
	movf	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	subwf	SYSLONGTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysLongTempA_H, W
	movf	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	subwf	SYSLONGTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test upper, exit if false
;movf SysLongTempA_U, W
	movf	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	subwf	SYSLONGTEMPB_U, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test exp, exit if false
;movf SysLongTempA_E, W
	movf	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	subwf	SYSLONGTEMPB_E, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (3304)
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

;Source: system.h (3334)
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

;Source: system.h (3635)
SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7
	goto	ELSE35_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7
	goto	ENDIF36
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F
;Exit Sub
	return
;End If
ENDIF36
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
	goto	ENDIF35
ELSE35_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7
;Exit Sub
	return
;End If
;End If
ENDIF35
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

;Source: system.h (2714)
SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfsc STATUS, Z
	btfsc	STATUS, Z
;return
	return
;Main calc routine
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C
;rlf SysByteTempA, F
	rlf	SYSBYTETEMPA, F
;rlf SysByteTempX, F
	rlf	SYSBYTETEMPX, F
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0
;btfsc STATUS, C
	btfsc	STATUS, C
;goto Div8NotNeg
	goto	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv8Start
	goto	SYSDIV8START
	return

;********************************************************************************

;Source: system.h (2782)
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
	goto	ENDIF23
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF23
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
	btfss	STATUS,C
	incfsz	SYSDIVMULTB_H,W
	subwf	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF24
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	btfsc	STATUS,C
	incfsz	SYSDIVMULTB_H,W
	addwf	SYSDIVMULTX_H,F
;End If
ENDIF24
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

;Source: system.h (2858)
SYSDIVSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	movf	SYSLONGTEMPA,W
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempA
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempA_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempA_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SYSCOMPEQUAL32
	btfss	SysByteTempX,0
	goto	ENDIF27
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF27
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP
SYSDIV32START
;set C off
	bcf	STATUS,C
;Rotate SysLongDivMultA Left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;Rotate SysLongDivMultX Left
	rlf	SYSLONGDIVMULTX,F
	rlf	SYSLONGDIVMULTX_H,F
	rlf	SYSLONGDIVMULTX_U,F
	rlf	SYSLONGDIVMULTX_E,F
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	subwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	btfss	STATUS,C
	incfsz	SYSLONGDIVMULTB_H,W
	subwf	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	btfss	STATUS,C
	incfsz	SYSLONGDIVMULTB_U,W
	subwf	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	btfss	STATUS,C
	incfsz	SYSLONGDIVMULTB_E,W
	subwf	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF28
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	btfsc	STATUS,C
	incfsz	SYSLONGDIVMULTB_H,W
	addwf	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	btfsc	STATUS,C
	incfsz	SYSLONGDIVMULTB_U,W
	addwf	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	btfsc	STATUS,C
	incfsz	SYSLONGDIVMULTB_E,W
	addwf	SYSLONGDIVMULTX_E,F
;End If
ENDIF28
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv32Start
	goto	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movf	SYSLONGDIVMULTA,W
	movwf	SYSLONGTEMPA
	movf	SYSLONGDIVMULTA_H,W
	movwf	SYSLONGTEMPA_H
	movf	SYSLONGDIVMULTA_U,W
	movwf	SYSLONGTEMPA_U
	movf	SYSLONGDIVMULTA_E,W
	movwf	SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	return

;********************************************************************************

;Source: system.h (1492)
SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Set pointer
;movf SysStringB, W
	movf	SYSSTRINGB, W
;movwf FSR
	movwf	FSR
;bcf STATUS, IRP
	bcf	STATUS, IRP
;btfsc SysStringB_H, 0
	btfsc	SYSSTRINGB_H, 0
;bsf STATUS, IRP
	bsf	STATUS, IRP
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF
	movwf	INDF
;addwf SysStringB, F
	addwf	SYSSTRINGB, F
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;Set pointer
;movf SysStringB, W
	movf	SYSSTRINGB, W
;movwf FSR
	movwf	FSR
;decf FSR,F
;bcf STATUS, IRP
	bcf	STATUS, IRP
;btfsc SysStringB_H, 0
	btfsc	SYSSTRINGB_H, 0
;bsf STATUS, IRP
	bsf	STATUS, IRP
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F
;addwf SysStringB,F
	addwf	SYSSTRINGB,F
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
;Copy
SYSSTRINGREAD
;Get char
;call SysStringTables
	call	SYSSTRINGTABLES
;Set char
;incf FSR, F
	incf	FSR, F
;movwf INDF
	movwf	INDF
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F
;goto SysStringRead
	goto	SYSSTRINGREAD
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

StringTable1
	retlw	3
	retlw	32	; 
	retlw	58	;:
	retlw	32	; 


StringTable2
	retlw	1
	retlw	45	;-


;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144

 END
