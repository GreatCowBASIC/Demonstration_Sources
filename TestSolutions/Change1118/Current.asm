;Program compiled by GCBASIC (0.99.02 2022-04-27 (Windows 64 bit) : Build 1113) for Microchip AVR Assembler
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Chip Model: MEGA162
;Assembler header file
.INCLUDE "m162def.inc"

;SREG bit names (for AVR Assembler compatibility, GCBASIC uses different names)
#define C 0
#define H 5
#define I 7
#define N 2
#define S 4
#define T 6
#define V 3
#define Z 1

;********************************************************************************

;Set aside memory locations for variables
.EQU	CHAINE_COMMANDE=297
.EQU	CHR=256
.EQU	COMMANDE=325
.EQU	COMPORT=326
.EQU	COMPTEUR_LOC=327
.EQU	ENABLE_LOC=328
.EQU	ERROR_LOC=329
.EQU	ETAT=320
.EQU	HSERRECEIVE=330
.EQU	HSERRECEIVE1=331
.EQU	HSERRECEIVE2=332
.EQU	MODE_PASSAGE_INTERACTIF=333
.EQU	NUMERO_EXPRESSION_LOC=334
.EQU	NUMERO_TRAIN_INTERACTIF=335
.EQU	PRINTLEN=336
.EQU	RECONNU_LOC=337
.EQU	REPONSE_LOC=338
.EQU	SERDATA=339
.EQU	STRINGPOINTER=340
.EQU	SYSCHAR=341
.EQU	SYSPRINTDATAHANDLER=342
.EQU	SYSPRINTDATAHANDLER_H=343
.EQU	SYSPRINTTEMP=344
.EQU	TAMPON_REPONSE=311
.EQU	TRAVAIL_LOC=345
.EQU	VOCABULAIRE_LOC=346

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSBYTETEMPA=r22
.DEF	SYSBYTETEMPB=r28
.DEF	SYSBYTETEMPX=r0
.DEF	SYSCALCTEMPA=r22
.DEF	SYSCALCTEMPX=r0
.DEF	SYSREADA=r30
.DEF	SYSREADA_H=r31
.DEF	SYSSTRINGA=r26
.DEF	SYSSTRINGA_H=r27
.DEF	SYSSTRINGB=r28
.DEF	SYSSTRINGB_H=r29
.DEF	SYSSTRINGLENGTH=r25
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30
.DEF	SYSWAITTEMPS=r31
.DEF	SYSTEMP1=r1
.DEF	SYSTEMP2=r2
.DEF	SYSTEMP3=r3
.DEF	SYSTEMP4=r16
.DEF	SYSTEMP5=r17

;********************************************************************************

;Alias variables
#define	SYSCHR_0	256
#define	SYSCHR_1	257
#define	SYSETAT_1	321
#define	SYSETAT_2	322
#define	SYSETAT_3	323
#define	SYSETAT_4	324
#define	SYSTAMPON_REPONSE_5	316

;********************************************************************************

;Vectors
;Interrupt vectors
.ORG	0
	rjmp	BASPROGRAMSTART ;Reset
.ORG	2
	reti	;INT0
.ORG	4
	reti	;INT1
.ORG	6
	reti	;INT2
.ORG	8
	reti	;PCINT0
.ORG	10
	reti	;PCINT1
.ORG	12
	reti	;TIMER3_CAPT
.ORG	14
	reti	;TIMER3_COMPA
.ORG	16
	reti	;TIMER3_COMPB
.ORG	18
	reti	;TIMER3_OVF
.ORG	20
	reti	;TIMER2_COMP
.ORG	22
	reti	;TIMER2_OVF
.ORG	24
	reti	;TIMER1_CAPT
.ORG	26
	reti	;TIMER1_COMPA
.ORG	28
	reti	;TIMER1_COMPB
.ORG	30
	reti	;TIMER1_OVF
.ORG	32
	reti	;TIMER0_COMP
.ORG	34
	reti	;TIMER0_OVF
.ORG	36
	reti	;SPI_STC
.ORG	38
	reti	;USART0_RXC
.ORG	40
	reti	;USART1_RXC
.ORG	42
	reti	;USART0_UDRE
.ORG	44
	reti	;USART1_UDRE
.ORG	46
	reti	;USART0_TXC
.ORG	48
	reti	;USART1_TXC
.ORG	50
	reti	;EE_RDY
.ORG	52
	reti	;ANA_COMP
.ORG	54
	reti	;SPM_RDY

;********************************************************************************

;Start of program memory page 0
.ORG	56
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	SPL, SysValueCopy
;Call initialisation routines
	rcall	INITSYS
	rcall	INITUSART
;Automatic pin direction setting
	ldi	SysValueCopy,255
	out	DDRB,SysValueCopy

;Start of the main program
;----- Configuration
;#Define USART1_BAUD_RATE 9600
;#Define USART1_TX_BLOCKING
;#Define USART1_DELAY OFF
;#Define USART1_Ready PinD.0 = 0
;#Define USART2_BAUD_RATE 9600
;#Define USART2_TX_BLOCKING
;#Define USART2_DELAY OFF
;#Define E_normal 0xFF
;#Define E_special 0xFE
;#Define I_special 1
;#Define I_interrompu 2
;#Define I_continu 3
;Constantes et variables
;Dim Chaine_commande As String * 13
;Dim Commande, Compteur, Travail, Vocabulaire As Byte
;Dim Etat (4) As Byte
;Dim Numero_train_interactif, Mode_passage_interactif As Byte
;Dim Tampon_reponse (8) As Byte
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;PortD = 0b00000010
	ldi	SysValueCopy,2
	out	PORTD,SysValueCopy
;DdrD = 0b00000010
	ldi	SysValueCopy,2
	out	DDRD,SysValueCopy
;PortB = 0b00001000
	ldi	SysValueCopy,8
	out	PORTB,SysValueCopy
;DdrB = 0b00001000
	ldi	SysValueCopy,8
	out	DDRB,SysValueCopy
;Wait 3 s
	ldi	SysWaitTempS,3
	rcall	Delay_S
;Etat (1) = E_Normal
	ldi	SysValueCopy,255
	sts	SYSETAT_1,SysValueCopy
;Etat (2) = E_Special
	ldi	SysValueCopy,254
	sts	SYSETAT_2,SysValueCopy
;Etat (3) = E_Normal
	ldi	SysValueCopy,255
	sts	SYSETAT_3,SysValueCopy
;Etat (4) = E_Normal
	ldi	SysValueCopy,255
	sts	SYSETAT_4,SysValueCopy
BOUCLE_PAROLE:
;Recevoir_train ()
	rcall	RECEVOIR_TRAIN
;If (Numero_train_interactif = 6) Then GoTo Automatique
	lds	SysCalcTempA,NUMERO_TRAIN_INTERACTIF
	cpi	SysCalcTempA,6
	brne	ENDIF1
	rjmp	AUTOMATIQUE
ENDIF1:
;Recevoir_passage ()
	rcall	RECEVOIR_PASSAGE
;If (Mode_passage_interactif = 7) Then GoTo Automatique
	lds	SysCalcTempA,MODE_PASSAGE_INTERACTIF
	cpi	SysCalcTempA,7
	brne	ENDIF2
	rjmp	AUTOMATIQUE
ENDIF2:
BOUCLE3:
;Annoncer_selection ()
	rcall	ANNONCER_SELECTION
;If ((Etat (Numero_train_interactif + 1) = E_special) And (Mode_passage_interactif <> I_interrompu)) Then
	lds	SysTemp2,NUMERO_TRAIN_INTERACTIF
	inc	SysTemp2
	mov	SysTemp1,SysTemp2
	ldi	SysTemp4,low(ETAT)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,0
	ldi	SysTemp5,high(ETAT)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	ld	SysBYTETempA,X
	ldi	SysBYTETempB,254
	rcall	SYSCOMPEQUAL
	mov	SysTemp1,SysByteTempX
	lds	SysBYTETempA,MODE_PASSAGE_INTERACTIF
	ldi	SysBYTETempB,2
	rcall	SYSCOMPEQUAL
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	sbrs	SysTemp3,0
	rjmp	ENDIF3
;Dire_expression (16)
	ldi	SysValueCopy,16
	sts	NUMERO_EXPRESSION_LOC,SysValueCopy
	rcall	DIRE_EXPRESSION
;Wait 750 ms
	ldi	SysWaitTempMS,238
	ldi	SysWaitTempMS_H,2
	rcall	Delay_MS
;Recevoir_passage ()
	rcall	RECEVOIR_PASSAGE
;If (Mode_passage_interactif = 7) Then
	lds	SysCalcTempA,MODE_PASSAGE_INTERACTIF
	cpi	SysCalcTempA,7
	brne	ELSE8_1
;GoTo Automatique
	rjmp	AUTOMATIQUE
;Else
	rjmp	ENDIF8
ELSE8_1:
;GoTo Boucle3
	rjmp	BOUCLE3
;End If
ENDIF8:
;End If
ENDIF3:
;Select_vocabulaire (3)
	ldi	SysValueCopy,3
	sts	VOCABULAIRE_LOC,SysValueCopy
	rcall	SELECT_VOCABULAIRE
;Dire_expression (15)
	ldi	SysValueCopy,15
	sts	NUMERO_EXPRESSION_LOC,SysValueCopy
	rcall	DIRE_EXPRESSION
;Recevoir_reponse (Commande)
	lds	SysValueCopy,COMMANDE
	sts	REPONSE_LOC,SysValueCopy
	rcall	RECEVOIR_REPONSE
	lds	SysValueCopy,REPONSE_LOC
	sts	COMMANDE,SysValueCopy
;If (Commande = 7) Then GoTo Automatique
	lds	SysCalcTempA,COMMANDE
	cpi	SysCalcTempA,7
	breq	AUTOMATIQUE
;If (Commande = 1) Then
	lds	SysCalcTempA,COMMANDE
	cpi	SysCalcTempA,1
	brne	ENDIF5
;Dire_expression (8)
	ldi	SysValueCopy,8
	sts	NUMERO_EXPRESSION_LOC,SysValueCopy
	rcall	DIRE_EXPRESSION
;Wait 500 ms
	ldi	SysWaitTempMS,244
	ldi	SysWaitTempMS_H,1
	rcall	Delay_MS
;GoTo Boucle_parole
	rjmp	BOUCLE_PAROLE
;End If
ENDIF5:
;If (Commande = 2) Then
	lds	SysCalcTempA,COMMANDE
	cpi	SysCalcTempA,2
	brne	ENDIF6
;Recevoir_train ()
	rcall	RECEVOIR_TRAIN
;Wait 500 ms
	ldi	SysWaitTempMS,244
	ldi	SysWaitTempMS_H,1
	rcall	Delay_MS
;GoTo Boucle3
	rjmp	BOUCLE3
;End If
ENDIF6:
;If (Commande = 3) Then
	lds	SysCalcTempA,COMMANDE
	cpi	SysCalcTempA,3
	brne	ENDIF7
;Recevoir_passage ()
	rcall	RECEVOIR_PASSAGE
;Wait 500 ms
	ldi	SysWaitTempMS,244
	ldi	SysWaitTempMS_H,1
	rcall	Delay_MS
;GoTo Boucle3
	rjmp	BOUCLE3
;End If
ENDIF7:
AUTOMATIQUE:
;Dire_expression (12)
	ldi	SysValueCopy,12
	sts	NUMERO_EXPRESSION_LOC,SysValueCopy
	rcall	DIRE_EXPRESSION
;Do
SysDoLoop_S1:
;Loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
;---------------------------------------------------------------------
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

;Source: Parole.gcb (127)
ANNONCER_SELECTION:
;Wait 250 ms
	ldi	SysWaitTempMS,250
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Dire_expression (Numero_train_interactif + 1)
	lds	SysTemp1,NUMERO_TRAIN_INTERACTIF
	inc	SysTemp1
	sts	NUMERO_EXPRESSION_LOC,SysTemp1
	rcall	DIRE_EXPRESSION
;Wait 500 ms
	ldi	SysWaitTempMS,244
	ldi	SysWaitTempMS_H,1
	rcall	Delay_MS
;Dire_expression (Mode_passage_interactif + 4)
	lds	SysTemp1,MODE_PASSAGE_INTERACTIF
	ldi	SysTemp4,4
	add	SysTemp1,SysTemp4
	sts	NUMERO_EXPRESSION_LOC,SysTemp1
	rcall	DIRE_EXPRESSION
;Wait 500 ms
	ldi	SysWaitTempMS,244
	ldi	SysWaitTempMS_H,1
	rjmp	Delay_MS

;********************************************************************************

;Source: Parole.gcb (31)
ATTENDRE_OK:
;Do
SysDoLoop_S10:
;Loop Until (HSerReceive1 = 0x0A)
	rcall	FN_HSERRECEIVE1
	lds	SysCalcTempA,HSERRECEIVE1
	cpi	SysCalcTempA,10
	brne	SysDoLoop_S10
SysDoLoop_E10:
	ret

;********************************************************************************

;Source: string.h (537)
FN_CHR:
;Empty input?
;If SysChar < 0 Then
	lds	SysCalcTempA,SYSCHAR
	cpi	SysCalcTempA,0
	brsh	ENDIF17
;Chr(0) = 0
	ldi	SysValueCopy,0
	sts	SYSCHR_0,SysValueCopy
;Exit Function
	ret
;End If
ENDIF17:
;Chr(0) = 1
	ldi	SysValueCopy,1
	sts	SYSCHR_0,SysValueCopy
;Copy characters
;Chr(1) = SysChar
	lds	SysValueCopy,SYSCHAR
	sts	SYSCHR_1,SysValueCopy
	ret

;********************************************************************************

;Source: Parole.gcb (112)
DIRE_EXPRESSION:
;Chaine_commande = "PMESSAGE" +chr (64 + numero_expression_loc)
	lds	SysTemp1,NUMERO_EXPRESSION_LOC
	ldi	SysTemp4,64
	add	SysTemp1,SysTemp4
	sts	SYSCHAR,SysTemp1
	rcall	FN_CHR
	ldi	SysStringB,low(CHAINE_COMMANDE)
	ldi	SysStringB_H,high(CHAINE_COMMANDE)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable1<<1)
	ldi	SysReadA_H,high(StringTable1<<1)
	rcall	SYSREADSTRINGPART
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	rcall	SYSCOPYSTRINGPART
	ldi	SysStringA,low(CHAINE_COMMANDE)
	ldi	SysStringA_H,high(CHAINE_COMMANDE)
	st	X, SysStringLength
;Chaine_commande = Chaine_commande + "WAV"
	ldi	SysStringB,low(CHAINE_COMMANDE)
	ldi	SysStringB_H,high(CHAINE_COMMANDE)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(CHAINE_COMMANDE)
	ldi	SysStringA_H,high(CHAINE_COMMANDE)
	rcall	SYSCOPYSTRINGPART
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	rcall	SYSREADSTRINGPART
	ldi	SysStringA,low(CHAINE_COMMANDE)
	ldi	SysStringA_H,high(CHAINE_COMMANDE)
	st	X, SysStringLength
;Chaine_commande = Chaine_commande + chr (0x0A)
	ldi	SysValueCopy,10
	sts	SYSCHAR,SysValueCopy
	rcall	FN_CHR
	ldi	SysStringB,low(CHAINE_COMMANDE)
	ldi	SysStringB_H,high(CHAINE_COMMANDE)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(CHAINE_COMMANDE)
	ldi	SysStringA_H,high(CHAINE_COMMANDE)
	rcall	SYSCOPYSTRINGPART
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	rcall	SYSCOPYSTRINGPART
	ldi	SysStringA,low(CHAINE_COMMANDE)
	ldi	SysStringA_H,high(CHAINE_COMMANDE)
	st	X, SysStringLength
;HSerPrint Chaine_commande, 2
	ldi	SysValueCopy,low(CHAINE_COMMANDE)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(CHAINE_COMMANDE)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT311
;Do
SysDoLoop_S6:
;Loop Until (HSerReceive2 = 0x65)
	rcall	FN_HSERRECEIVE2
	lds	SysCalcTempA,HSERRECEIVE2
	cpi	SysCalcTempA,101
	brne	SysDoLoop_S6
SysDoLoop_E6:
;Do
SysDoLoop_S7:
;Loop Until (HSerReceive2 = 0x0A)
	rcall	FN_HSERRECEIVE2
	lds	SysCalcTempA,HSERRECEIVE2
	cpi	SysCalcTempA,10
	brne	SysDoLoop_S7
SysDoLoop_E7:
	ret

;********************************************************************************

Delay_MS:
	inc	SysWaitTempMS_H
DMS_START:
	ldi	DELAYTEMP2,43
DMS_OUTER:
	ldi	DELAYTEMP,30
DMS_INNER:
	dec	DELAYTEMP
	brne	DMS_INNER
	dec	DELAYTEMP2
	brne	DMS_OUTER
	dec	SysWaitTempMS
	brne	DMS_START
	dec	SysWaitTempMS_H
	brne	DMS_START
	ret

;********************************************************************************

Delay_S:
DS_START:
	ldi	SysWaitTempMS,232
	ldi	SysWaitTempMS_H,3
	rcall	Delay_MS
	dec	SysWaitTempS
	brne	DS_START
	ret

;********************************************************************************

;Source: Parole.gcb (40)
ENABLE:
;HSerSend 0xAA, 1
	ldi	SysValueCopy,170
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;HSerSend 0x02, 1
	ldi	SysValueCopy,2
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;If (enable_loc = 1) Then
	lds	SysCalcTempA,ENABLE_LOC
	cpi	SysCalcTempA,1
	brne	ELSE26_1
;HSerSend 0x01, 1
	ldi	SysValueCopy,1
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;Else
	rjmp	ENDIF26
ELSE26_1:
;HSerSend 0x02, 1
	ldi	SysValueCopy,2
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;End If
ENDIF26:
;HSerSend 0x0A, 1
	ldi	SysValueCopy,10
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;Attendre_OK ()
	rjmp	ATTENDRE_OK

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (1467)
HSERPRINT311:
;PrintLen = PrintData(0)
	lds	SysStringA,SysPRINTDATAHandler
	lds	SysStringA_H,SysPRINTDATAHandler_H
	ld	SysValueCopy,X
	sts	PRINTLEN,SysValueCopy
;If PrintLen <> 0 then
	lds	SysCalcTempA,PRINTLEN
	tst	SysCalcTempA
	breq	ENDIF24
;Write Data
;for SysPrintTemp = 1 to PrintLen
	ldi	SysValueCopy,1
	sts	SYSPRINTTEMP,SysValueCopy
SysForLoop1:
;HSerSend(PrintData(SysPrintTemp),comport )
	lds	SysTemp1,SysPRINTDATAHandler
	lds	SysTemp2,SYSPRINTTEMP
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SysPRINTDATAHandler_H
	ldi	SysTemp4,0
	adc	SysTemp1,SysTemp4
	mov	SysStringA_H,SysTemp1
	ld	SysValueCopy,X
	sts	SERDATA,SysValueCopy
	rcall	HSERSEND301
;next
;#4p Positive value Step Handler in For-next statement
	lds	SysTemp2,PRINTLEN
	lds	SysTemp3,SYSPRINTTEMP
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	mov	SysBYTETempA,SysTemp1
	ldi	SysBYTETempB,0
	rcall	SYSCOMPEQUAL
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF25
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	lds	SysTemp1,SYSPRINTTEMP
	inc	SysTemp1
	sts	SYSPRINTTEMP,SysTemp1
	rjmp	SysForLoop1
;END IF
ENDIF25:
SysForLoopEnd1:
;End If
ENDIF24:
;CR
	ret

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (1159)
HSERRECEIVE306:
;Needs comport to be set first by calling routines
;AVR USART 1 receive
;if comport = 1 Then
	lds	SysCalcTempA,COMPORT
	cpi	SysCalcTempA,1
	brne	ENDIF20
;SerData = DefaultUsartReturnValue
	ldi	SysValueCopy,255
	sts	SERDATA,SysValueCopy
;If set up to block, wait for data
;Wait Until USARTHasData
SysWaitLoop4:
	sbis	UCSR0A,RXC0
	rjmp	SysWaitLoop4
;If USARTHasData Then
	sbis	UCSR0A,RXC0
	rjmp	ENDIF22
;SerData = UDR0
	in	SysValueCopy,UDR0
	sts	SERDATA,SysValueCopy
;End If
ENDIF22:
;End If
ENDIF20:
;AVR USART 2 receive
;if comport = 2 Then
	lds	SysCalcTempA,COMPORT
	cpi	SysCalcTempA,2
	brne	ENDIF21
;SerData = DefaultUsartReturnValue
	ldi	SysValueCopy,255
	sts	SERDATA,SysValueCopy
;If set up to block, wait for data
;If USART2HasData Then
	sbis	UCSR1A,RXC1
	rjmp	ENDIF23
;SerData = UDR1
	in	SysValueCopy,UDR1
	sts	SERDATA,SysValueCopy
;End If
ENDIF23:
;End If
ENDIF21:
	ret

;********************************************************************************

;Source: usart.h (1138)
FN_HSERRECEIVE1:
;Comport = 1
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
;HSerReceive( SerData )
	rcall	HSERRECEIVE306
;HSerReceive1 = SerData
	lds	SysValueCopy,SERDATA
	sts	HSERRECEIVE1,SysValueCopy
	ret

;********************************************************************************

;Source: usart.h (1145)
FN_HSERRECEIVE2:
;Comport = 2
	ldi	SysValueCopy,2
	sts	COMPORT,SysValueCopy
;HSerReceive( SerData )
	rcall	HSERRECEIVE306
;HSerReceive2 = SerData
	lds	SysValueCopy,SERDATA
	sts	HSERRECEIVE2,SysValueCopy
	ret

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (918)
HSERSEND301:
;AVR USART1 Send
;if comport = 1 Then
	lds	SysCalcTempA,COMPORT
	cpi	SysCalcTempA,1
	brne	ENDIF18
;Wait While UDRE0 = Off    'Blocking Both Transmit buffer empty ,ready for data
SysWaitLoop1:
	sbis	UCSR0A,UDRE0
	rjmp	SysWaitLoop1
;Wait While UDRE0 = Off    'Blocking Transmit buffer empty ,ready for data
SysWaitLoop2:
	sbis	UCSR0A,UDRE0
	rjmp	SysWaitLoop2
;UDR = SerData
	lds	SysValueCopy,SERDATA
	out	UDR,SysValueCopy
;UDR0 = SerData ' *******************
	lds	SysValueCopy,SERDATA
	out	UDR0,SysValueCopy
;End If
ENDIF18:
;----------------------------------------------------
;AVR USART 2 send
;if comport = 2 Then
	lds	SysCalcTempA,COMPORT
	cpi	SysCalcTempA,2
	brne	ENDIF19
;Wait While UDRE1 = Off    'Transmit buffer empty ,ready for data
SysWaitLoop3:
	sbis	UCSR1A,UDRE1
	rjmp	SysWaitLoop3
;UDR1 = SerData ' *****************
	lds	SysValueCopy,SERDATA
	out	UDR1,SysValueCopy
;End If
ENDIF19:
	ret

;********************************************************************************

;Source: system.h (158)
INITSYS:
;
;'Turn off all ports
;PORTA = 0
	ldi	SysValueCopy,0
	out	PORTA,SysValueCopy
;PORTB = 0
	ldi	SysValueCopy,0
	out	PORTB,SysValueCopy
;PORTC = 0
	ldi	SysValueCopy,0
	out	PORTC,SysValueCopy
;PORTD = 0
	ldi	SysValueCopy,0
	out	PORTD,SysValueCopy
;PORTE = 0
	ldi	SysValueCopy,0
	out	PORTE,SysValueCopy
	ret

;********************************************************************************

;Source: usart.h (583)
INITUSART:
;Set baud rate
;U2X0 = U2X0_TEMP        'Set/Clear bit to double USART transmission speed
	sbi	UCSR0A,U2X0
;UBRR0L = UBRRL_TEMP
	ldi	SysValueCopy,51
	out	UBRR0L,SysValueCopy
;UBRR0H = UBRRH_TEMP
	ldi	SysValueCopy,0
	out	UBRR0H,SysValueCopy
;Enable TX and RX
;RXEN0 = On
	sbi	UCSR0B,RXEN0
;TXEN0 = On
	sbi	UCSR0B,TXEN0
;set baud reg
;U2X1 = U2X02_TEMP     'speed doubling bit ex:Mega 128,2560
	sbi	UCSR1A,U2X1
;UBRR1L = UBRRL2_TEMP    'baudrate register low
	ldi	SysValueCopy,51
	out	UBRR1L,SysValueCopy
;UBRR1H = UBRRH2_TEMP    'baudrate register h
	ldi	SysValueCopy,0
	out	UBRR1H,SysValueCopy
;Enable TX and RX
;RXEN1 = On
	sbi	UCSR1B,RXEN1
;TXEN1 = On
	sbi	UCSR1B,TXEN1
	ret

;********************************************************************************

;Source: Parole.gcb (166)
RECEVOIR_PASSAGE:
;Dim error_loc As Byte
;Select_vocabulaire (2)
	ldi	SysValueCopy,2
	sts	VOCABULAIRE_LOC,SysValueCopy
	rcall	SELECT_VOCABULAIRE
;Do
SysDoLoop_S9:
;Dire_expression (14)
	ldi	SysValueCopy,14
	sts	NUMERO_EXPRESSION_LOC,SysValueCopy
	rcall	DIRE_EXPRESSION
;Recevoir_reponse (Mode_passage_interactif)
	lds	SysValueCopy,MODE_PASSAGE_INTERACTIF
	sts	REPONSE_LOC,SysValueCopy
	rcall	RECEVOIR_REPONSE
	lds	SysValueCopy,REPONSE_LOC
	sts	MODE_PASSAGE_INTERACTIF,SysValueCopy
;error_loc = 0
	ldi	SysValueCopy,0
	sts	ERROR_LOC,SysValueCopy
;If (MOde_passage_interactif < 7) Then
	lds	SysCalcTempA,MODE_PASSAGE_INTERACTIF
	cpi	SysCalcTempA,7
	brsh	ENDIF15
;If ((Etat (Numero_train_interactif + 1) = E_special) And (Mode_passage_interactif <> I_interrompu)) Then
	lds	SysTemp2,NUMERO_TRAIN_INTERACTIF
	inc	SysTemp2
	mov	SysTemp1,SysTemp2
	ldi	SysTemp4,low(ETAT)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,0
	ldi	SysTemp5,high(ETAT)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	ld	SysBYTETempA,X
	ldi	SysBYTETempB,254
	rcall	SYSCOMPEQUAL
	mov	SysTemp1,SysByteTempX
	lds	SysBYTETempA,MODE_PASSAGE_INTERACTIF
	ldi	SysBYTETempB,2
	rcall	SYSCOMPEQUAL
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	sbrs	SysTemp3,0
	rjmp	ENDIF16
;error_loc = 1
	ldi	SysValueCopy,1
	sts	ERROR_LOC,SysValueCopy
;Annoncer_selection ()
	rcall	ANNONCER_SELECTION
;Wait 250 ms
	ldi	SysWaitTempMS,250
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Dire_expression (16)
	ldi	SysValueCopy,16
	sts	NUMERO_EXPRESSION_LOC,SysValueCopy
	rcall	DIRE_EXPRESSION
;Wait 1 s
	ldi	SysWaitTempS,1
	rcall	Delay_S
;End If
ENDIF16:
;End If
ENDIF15:
;Loop Until (error_loc = 0)
	lds	SysCalcTempA,ERROR_LOC
	tst	SysCalcTempA
	breq	PC + 2
	rjmp	SysDoLoop_S9
SysDoLoop_E9:
	ret

;********************************************************************************

;Source: Parole.gcb (77)
RECEVOIR_REPONSE:
;Dim compteur_loc, reconnu_loc, travail_loc As Byte
;compteur_loc = 0
	ldi	SysValueCopy,0
	sts	COMPTEUR_LOC,SysValueCopy
;reconnu_loc = 0
	ldi	SysValueCopy,0
	sts	RECONNU_LOC,SysValueCopy
;travail_loc = 0xFF
	ldi	SysValueCopy,255
	sts	TRAVAIL_LOC,SysValueCopy
;Do
SysDoLoop_S2:
;Do
SysDoLoop_S3:
;If (USART1_Ready) Then travail_loc = HSerReceive1
	sbic	PIND,0
	rjmp	ENDIF9
	rcall	FN_HSERRECEIVE1
	lds	SysValueCopy,HSERRECEIVE1
	sts	TRAVAIL_LOC,SysValueCopy
ENDIF9:
;If (PinD.4 = 0) Then
	sbic	PIND,4
	rjmp	ENDIF10
;reponse_loc = 7
	ldi	SysValueCopy,7
	sts	REPONSE_LOC,SysValueCopy
;reconnu_loc = 1
	ldi	SysValueCopy,1
	sts	RECONNU_LOC,SysValueCopy
;End If
ENDIF10:
;Loop Until ((travail_loc = 0xAA) Or (reconnu_loc = 1))
	lds	SysBYTETempA,travail_loc
	ldi	SysBYTETempB,170
	rcall	SYSCOMPEQUAL
	mov	SysTemp1,SysByteTempX
	lds	SysBYTETempA,reconnu_loc
	ldi	SysBYTETempB,1
	rcall	SYSCOMPEQUAL
	mov	SysTemp2,SysByteTempX
	or	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	sbrs	SysTemp3,0
	rjmp	SysDoLoop_S3
SysDoLoop_E3:
;If (travail_loc = 0xAA) Then
	lds	SysCalcTempA,TRAVAIL_LOC
	cpi	SysCalcTempA,170
	brne	ENDIF11
;Do
SysDoLoop_S4:
;Do
SysDoLoop_S5:
;Loop Until (USART1_Ready)
	sbic	PIND,0
	rjmp	SysDoLoop_S5
SysDoLoop_E5:
;travail_loc = HSerReceive1
	rcall	FN_HSERRECEIVE1
	lds	SysValueCopy,HSERRECEIVE1
	sts	TRAVAIL_LOC,SysValueCopy
;compteur_loc = compteur_loc + 1
	lds	SysTemp1,COMPTEUR_LOC
	inc	SysTemp1
	sts	COMPTEUR_LOC,SysTemp1
;Tampon_reponse (compteur_loc) = travail_loc
	ldi	SysTemp4,low(TAMPON_REPONSE)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,0
	ldi	SysTemp5,high(TAMPON_REPONSE)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysValueCopy,TRAVAIL_LOC
	st	X,SysValueCopy
;Loop Until ((travail_loc = 0x0A) Or (compteur_loc = 8))
	lds	SysBYTETempA,travail_loc
	ldi	SysBYTETempB,10
	rcall	SYSCOMPEQUAL
	mov	SysTemp1,SysByteTempX
	lds	SysBYTETempA,compteur_loc
	ldi	SysBYTETempB,8
	rcall	SYSCOMPEQUAL
	mov	SysTemp2,SysByteTempX
	or	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	sbrs	SysTemp3,0
	rjmp	SysDoLoop_S4
SysDoLoop_E4:
;End If
ENDIF11:
;If ((travail_loc =0x0A) And (compteur_loc = 8)) Then
	lds	SysBYTETempA,TRAVAIL_LOC
	ldi	SysBYTETempB,10
	rcall	SYSCOMPEQUAL
	mov	SysTemp1,SysByteTempX
	lds	SysBYTETempA,COMPTEUR_LOC
	ldi	SysBYTETempB,8
	rcall	SYSCOMPEQUAL
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	sbrs	SysTemp3,0
	rjmp	ENDIF12
;reponse_loc = Tampon_reponse (5)
	lds	SysValueCopy,SYSTAMPON_REPONSE_5
	sts	REPONSE_LOC,SysValueCopy
;reconnu_loc = 1
	ldi	SysValueCopy,1
	sts	RECONNU_LOC,SysValueCopy
;End If
ENDIF12:
;Loop Until (reconnu_loc = 1)
	lds	SysCalcTempA,RECONNU_LOC
	cpi	SysCalcTempA,1
	breq	PC + 2
	rjmp	SysDoLoop_S2
SysDoLoop_E2:
	ret

;********************************************************************************

;Source: Parole.gcb (139)
RECEVOIR_TRAIN:
;Dim error_loc As Byte
;Select_vocabulaire (1)
	ldi	SysValueCopy,1
	sts	VOCABULAIRE_LOC,SysValueCopy
	rcall	SELECT_VOCABULAIRE
;Do
SysDoLoop_S8:
;Dire_expression (13)
	ldi	SysValueCopy,13
	sts	NUMERO_EXPRESSION_LOC,SysValueCopy
	rcall	DIRE_EXPRESSION
;Recevoir_reponse (Numero_train_interactif)
	lds	SysValueCopy,NUMERO_TRAIN_INTERACTIF
	sts	REPONSE_LOC,SysValueCopy
	rcall	RECEVOIR_REPONSE
	lds	SysValueCopy,REPONSE_LOC
	sts	NUMERO_TRAIN_INTERACTIF,SysValueCopy
;error_loc = 0
	ldi	SysValueCopy,0
	sts	ERROR_LOC,SysValueCopy
;If (Numero_train_interactif <> 7) Then
	lds	SysCalcTempA,NUMERO_TRAIN_INTERACTIF
	cpi	SysCalcTempA,7
	brne	PC + 2
	rjmp	ENDIF13
;If ((Numero_train_interactif < 3 ) And (Etat (3 - Numero_train_interactif) = E_Special)) Then
	ldi	SysTemp4,3
	lds	SysTemp2,NUMERO_TRAIN_INTERACTIF
	sub	SysTemp4,SysTemp2
	mov	SysTemp1,SysTemp4
	ldi	SysTemp4,low(ETAT)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,0
	ldi	SysTemp5,high(ETAT)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysBYTETempA,NUMERO_TRAIN_INTERACTIF
	ldi	SysBYTETempB,3
	rcall	SYSCOMPLESSTHAN
	mov	SysTemp1,SysByteTempX
	ld	SysBYTETempA,X
	ldi	SysBYTETempB,254
	rcall	SYSCOMPEQUAL
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	sbrs	SysTemp3,0
	rjmp	ENDIF14
;error_loc = 1
	ldi	SysValueCopy,1
	sts	ERROR_LOC,SysValueCopy
;Wait 250 ms
	ldi	SysWaitTempMS,250
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Dire_expression (Numero_train_interactif)
	lds	SysValueCopy,NUMERO_TRAIN_INTERACTIF
	sts	NUMERO_EXPRESSION_LOC,SysValueCopy
	rcall	DIRE_EXPRESSION
;Wait 250 ms
	ldi	SysWaitTempMS,250
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Dire_expression (16)
	ldi	SysValueCopy,16
	sts	NUMERO_EXPRESSION_LOC,SysValueCopy
	rcall	DIRE_EXPRESSION
;Wait 1 s
	ldi	SysWaitTempS,1
	rcall	Delay_S
;End If
ENDIF14:
;End If
ENDIF13:
;Loop Until  (error_loc = 0)
	lds	SysCalcTempA,ERROR_LOC
	tst	SysCalcTempA
	breq	PC + 2
	rjmp	SysDoLoop_S8
SysDoLoop_E8:
;Numero_train_interactif = Numero_train_interactif - 1
	lds	SysTemp1,NUMERO_TRAIN_INTERACTIF
	dec	SysTemp1
	sts	NUMERO_TRAIN_INTERACTIF,SysTemp1
	ret

;********************************************************************************

;Source: Parole.gcb (56)
SELECT_VOCABULAIRE:
;HSerSend 0xAA, 1
	ldi	SysValueCopy,170
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;HSerSend 0x02, 1
	ldi	SysValueCopy,2
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;HSerSend 0x00, 1
	ldi	SysValueCopy,0
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;HSerSend 0x0A, 1
	ldi	SysValueCopy,10
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;Attendre_OK ()
	rcall	ATTENDRE_OK
;Enable (0)
	ldi	SysValueCopy,0
	sts	ENABLE_LOC,SysValueCopy
	rcall	ENABLE
;HSerSend 0xAA, 1
	ldi	SysValueCopy,170
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;HSerSend 0x03, 1
	ldi	SysValueCopy,3
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;HSerSend 0x03, 1
	ldi	SysValueCopy,3
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;HSerSend vocabulaire_loc, 1
	lds	SysValueCopy,VOCABULAIRE_LOC
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;HSerSend 0x0A, 1
	ldi	SysValueCopy,10
	sts	SERDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERSEND301
;Attendre_OK ()
	rcall	ATTENDRE_OK
;Enable (1)
	ldi	SysValueCopy,1
	sts	ENABLE_LOC,SysValueCopy
	rjmp	ENABLE

;********************************************************************************

;Source: system.h (3020)
SYSCOMPEQUAL:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cpse SysByteTempA, SysByteTempB
	cpse	SYSBYTETEMPA, SYSBYTETEMPB
;return
	ret
;com SysByteTempX
	com	SYSBYTETEMPX
	ret

;********************************************************************************

;Source: system.h (3325)
SYSCOMPLESSTHAN:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cp SysByteTempA,SysByteTempB
	cp	SYSBYTETEMPA,SYSBYTETEMPB
;brlo SCLTTrue
	brlo	SCLTTRUE
;ret
	ret
SCLTTRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
	ret

;********************************************************************************

;Source: system.h (1316)
SYSCOPYSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;SysStringA (X) stores source
;SysStringB (Y) stores destination
;SysStringLength is counter, keeps track of size of destination string
;SysCalcTempA is loop counter
;Dim SysReadA As Byte
;Get and copy length
;ld SysCalcTempA, X+
	ld	SYSCALCTEMPA, X+
;st Y+, SysCalcTempA
	st	Y+, SYSCALCTEMPA
;rjmp SysCopyStringCheck
	rjmp	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART:
;ld SysCalcTempA, X+
	ld	SYSCALCTEMPA, X+
;add SysStringLength, SysCalcTempA
	add	SYSSTRINGLENGTH, SYSCALCTEMPA
SYSCOPYSTRINGCHECK:
;Exit if length = 0
;cpi SysCalcTempA,0
	cpi	SYSCALCTEMPA,0
;brne SysStringCopy
	brne	SYSSTRINGCOPY
;ret
	ret
SYSSTRINGCOPY:
;Copy character
;ld SysReadA, X+
	ld	SYSREADA, X+
;st Y+, SysReadA
	st	Y+, SYSREADA
;dec SysCalcTempA
	dec	SYSCALCTEMPA
;brne SysStringCopy
	brne	SYSSTRINGCOPY
	ret

;********************************************************************************

;Source: system.h (1513)
SYSREADSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Dim SysCalcTempX As Byte
;Get length
;lpm SysCalcTempA, Z+
;lpm
	lpm
;mov SysCalcTempA, SysCalcTempX
	mov	SYSCALCTEMPA, SYSCALCTEMPX
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;st Y+, SysCalcTempA
	st	Y+, SYSCALCTEMPA
;rjmp SysStringReadCheck
	rjmp	SYSSTRINGREADCHECK
SYSREADSTRINGPART:
;lpm SysCalcTempA, Z+
;lpm
	lpm
;mov SysCalcTempA, SysCalcTempX
	mov	SYSCALCTEMPA, SYSCALCTEMPX
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;add SysStringLength, SysCalcTempA
	add	SYSSTRINGLENGTH, SYSCALCTEMPA
;Check length
SYSSTRINGREADCHECK:
;If length is 0, exit
;cpi SysCalcTempA, 0
	cpi	SYSCALCTEMPA, 0
;brne SysStringRead
	brne	SYSSTRINGREAD
;ret
	ret
;Copy
SYSSTRINGREAD:
;Copy char
;lpm SysCalcTempX, Z+
;lpm
	lpm
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;st Y+, SysCalcTempX
	st	Y+, SYSCALCTEMPX
;dec SysCalcTempA
	dec	SYSCALCTEMPA
;brne SysStringRead
	brne	SYSSTRINGREAD
	ret

;********************************************************************************

SysStringTables:

StringTable1:
.DB	8,80,77,69,83,83,65,71,69,0


StringTable2:
.DB	3,87,65,86


;********************************************************************************


