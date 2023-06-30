;Program compiled by GCBASIC (1.00.00 Release Candidate 2022-10-13 (Windows 64 bit) : Build 1178) for Microchip MPASM/MPLAB-X Assembler
;Need help? 
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   w_cholmondeley at users dot sourceforge dot net
;   evanvennn at users dot sourceforge dot net

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F27Q43, r=DEC
#include <P18F27Q43.inc>
 CONFIG CP = OFF, WRTSAF = OFF, WRTD = OFF, WRTB = OFF, WDTE = OFF, XINST = OFF, LVP = OFF, MVECEN = OFF, MCLRE = INTMCLR, FCMEN = ON, CLKOUTEN = OFF, RSTOSC = HFINTOSC_1MHZ, FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
BCDTODEC_GCB                     EQU    1293          ; 0x50D
BGETC                            EQU    1296          ; 0x510
BUFFER                           EQU    9408          ; 0x24C0
COMPORT                          EQU    1297          ; 0x511
DELAYTEMP                        EQU    1280          ; 0x500
DELAYTEMP2                       EQU    1281          ; 0x501
HSERPRINTCRLFCOUNT               EQU    1298          ; 0x512
ID7                              EQU    1299          ; 0x513
JJ                               EQU    1300          ; 0x514
JJ_E                             EQU    1303          ; 0x517
JJ_H                             EQU    1301          ; 0x515
JJ_U                             EQU    1302          ; 0x516
LAST                             EQU    1304          ; 0x518
LOCAL_NEXT_OUT                   EQU    1305          ; 0x519
NEXT_IN                          EQU    1306          ; 0x51A
NEXT_OUT                         EQU    1307          ; 0x51B
OUTVALUETEMP                     EQU    1308          ; 0x51C
PRINTLEN                         EQU    1309          ; 0x51D
PRINTVALUE                       EQU    1310          ; 0x51E
SAVEFSR0H                        EQU    1311          ; 0x51F
SAVEFSR0L                        EQU    1312          ; 0x520
SAVEFSR1H                        EQU    1313          ; 0x521
SAVEFSR1L                        EQU    1314          ; 0x522
SAVESYSBYTETEMPA                 EQU    1315          ; 0x523
SAVESYSBYTETEMPB                 EQU    1316          ; 0x524
SAVESYSBYTETEMPX                 EQU    1317          ; 0x525
SAVESYSDIVLOOP                   EQU    1318          ; 0x526
SAVESYSSTRINGLENGTH              EQU    1319          ; 0x527
SAVESYSTEMP1                     EQU    1320          ; 0x528
SERDATA                          EQU    1321          ; 0x529
SERPRINTVAL                      EQU    1322          ; 0x52A
STRINGPOINTER                    EQU    1323          ; 0x52B
SYSBITVAR0                       EQU    1324          ; 0x52C
SYSBSR                           EQU    1325          ; 0x52D
SYSBYTETEMPA                     EQU    1285          ; 0x505
SYSBYTETEMPB                     EQU    1289          ; 0x509
SYSBYTETEMPX                     EQU    1280          ; 0x500
SYSCALCTEMPA                     EQU    1285          ; 0x505
SYSCALCTEMPX                     EQU    1280          ; 0x500
SYSDIVLOOP                       EQU    1284          ; 0x504
SYSINTSTATESAVE0                 EQU    1326          ; 0x52E
SYSINVAL                         EQU    1327          ; 0x52F
SYSLONGTEMPA                     EQU    1285          ; 0x505
SYSLONGTEMPA_E                   EQU    1288          ; 0x508
SYSLONGTEMPA_H                   EQU    1286          ; 0x506
SYSLONGTEMPA_U                   EQU    1287          ; 0x507
SYSLONGTEMPB                     EQU    1289          ; 0x509
SYSLONGTEMPB_E                   EQU    1292          ; 0x50C
SYSLONGTEMPB_H                   EQU    1290          ; 0x50A
SYSLONGTEMPB_U                   EQU    1291          ; 0x50B
SYSPRINTDATAHANDLER              EQU    1328          ; 0x530
SYSPRINTDATAHANDLER_H            EQU    1329          ; 0x531
SYSPRINTTEMP                     EQU    1330          ; 0x532
SYSREPEATTEMP1                   EQU    1331          ; 0x533
SYSSTATUS                        EQU    1295          ; 0x50F
SYSSTRINGA                       EQU    1287          ; 0x507
SYSSTRINGA_H                     EQU    1288          ; 0x508
SYSSTRINGLENGTH                  EQU    1286          ; 0x506
SYSSTRINGPARAM1                  EQU    9393          ; 0x24B1
SYSSTRINGPARAM2                  EQU    9378          ; 0x24A2
SYSTEMP1                         EQU    1332          ; 0x534
SYSTEMP2                         EQU    1333          ; 0x535
SYSW                             EQU    1294          ; 0x50E
SYSWAITTEMPMS                    EQU    1282          ; 0x502
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503
SYSWAITTEMPS                     EQU    1284          ; 0x504
TEMPPNT                          EQU    1334          ; 0x536
TMRNUMBER                        EQU    1335          ; 0x537
TMRPRES                          EQU    1336          ; 0x538
TMRSOURCE                        EQU    1337          ; 0x539
TMRVALUE                         EQU    1338          ; 0x53A
TMRVALUE_H                       EQU    1339          ; 0x53B
TRMSOURCE                        EQU    1340          ; 0x53C

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
TIMER1 EQU 796
TIMER1_H EQU 797

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	bra	INTERRUPT

;********************************************************************************

;Start of program memory page 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	rcall	INITSYS
	rcall	INITPPS
	rcall	INITUSART
;Enable interrupts
	bsf	INTCON0,GIE,ACCESS

;Start of the main program
;
;So what about the UK time signals (MSF on 60 kHz)?
;Aliexpress offer a dual frequency (40 and 60 kHz) VLF receiver (the 40 kHz is for the Japanese VLF transmissions).
;The problem (as ever) is there is little to no information supplied.
;I tried all possible combinations of pins high and low and could not get it to work.
;So the solution was to remove the 60kHz crystal and put it onto a DCF77 board (I also swapped the ferrite inductors, but this made little difference).
;UK VLF time signals  used to be broadcast from Rugby - a nice central location.
;Now they are broadcast from Anthorn in Cumbria (almost in Scotland) .
;This is a long way from me in fact the German one is probably nearer (and is definitely more powerful 50kW versus 17kW).
;
;As is to be expected the coding is different. Rather than a missing pulse on the minute MSF60 has an extra long pulse (500ms) on the minute. Other than that it is a mixture of long (200ms) and short pulses (100ms) to give the BCD time (except near the minute there can be 300ms pulses "as a parity check"). The code is below. I used a 12LF1552 (as I have no 12F1840's left). It only has a 8-bit counter (timer0), but with the prescaler (256:1) it is essentially 16-bit (with only the high byte accessible).
;
;
;
;------------PORTA---------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    -------- NC-DIN-MCL-SDA-SCK-PWR--
;
;
;Implies:
;PWR is drawn from the PIC via PortA.0
;I2C to an LCD
;MCLR port.pin is not used
;DataIn (DIN) from clock source
;PortA.5 port.pin is not used/not connected
;
;---DEVICE----------
;Bit#:  ---4---3---2---1---
;IO:    --??--??-0v0--5v0--
;
;Generated by PIC PPS Tool for GCBASIC
;PPS Tool version: 0.0.6.3
;PinManager data: v1.81.8
;Generated for 18F27Q43
;
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;' Define HI2C settings
;#chip HI2C_BAUD_RATE 25
;#chip HI2C_DATA PORTA.2
;#chip HI2C_CLOCK PORTA.1
;Dir HI2C_DATA in
;Dir HI2C_CLOCK in
;HI2CMode Master
;wait 20 ms
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;dir porta.3 in 'mclr pin
	bsf	TRISA,3,ACCESS
;dir porta.0 out 'pon=power on
	bcf	TRISA,0,ACCESS
;dir porta.4 in 'time pulses
	bsf	TRISA,4,ACCESS
;dir porta.5 out 'out n/c
	bcf	TRISA,5,ACCESS
;set porta.0 off 'pon off=on
	bcf	LATA,0,ACCESS
;set porta.5 off
	bcf	LATA,5,ACCESS
;Create the supporting variables
;Dim next_in As Byte
;Dim next_out As Byte
;Dim syncbyte As Byte
;Dim temppnt As Byte
;Constants etc required for Buffer Ring
;Define the Buffer
;Dim buffer( BUFFER_SIZE - 1 ) 'we will use element 0 in the array as part of out buffer
;Call init the buffer
;InitBufferRing
	rcall	INITBUFFERRING
;option_reg=b'00000111'
;wpua=b'00000110' 'HI2C pins
;wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;HserPrintStringCRLF "DCF77 test"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*10
	rcall	HSERPRINTSTRINGCRLF
;Dim jj as Byte
;jj=0
	clrf	JJ,ACCESS
	clrf	JJ_H,ACCESS
	clrf	JJ_U,ACCESS
	clrf	JJ_E,ACCESS
;kmin1=0:kmin=0
;khour1=0:khour=0
;kday1=0:kday=0
;kmonth1=0:kmonth=0
;kyear1=0:kyear=0 'initialize constants
;tmr0=0
;'start of main loop...
;*
;IOCx registers
;
;interrupt on change for group IOCAF - flag
;IOCAF.IOCAF4 = 0;
	banksel	IOCAF
	bcf	IOCAF,IOCAF4,BANKED
;interrupt on change for group IOCAN - negative
;IOCAN.IOCAN4 = 1;
	bsf	IOCAN,IOCAN4,BANKED
;interrupt on change for group IOCAP - positive
;IOCAP.IOCAP4 = 1;
	bsf	IOCAP,IOCAP4,BANKED
;Dim NewPulse as Bit
;NewPulse = 0
	bcf	SYSBITVAR0,0,ACCESS
;InitTimer1 Osc, PS1_2
	movlw	1
	movwf	TMRSOURCE,ACCESS
	movlw	16
	movwf	TMRPRES,ACCESS
	banksel	0
	rcall	INITTIMER1
;starttimer 1
	movlw	1
	movwf	TMRNUMBER,ACCESS
	rcall	STARTTIMER
;Settimer 1,0
	movlw	1
	movwf	TMRNUMBER,ACCESS
	clrf	TMRVALUE,ACCESS
	clrf	TMRVALUE_H,ACCESS
	rcall	SETTIMER181
;wait 3 s
	movlw	3
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;register default IOC callback functions at runtime; use these methods to register a custom function
;On Interrupt PORTABChange Call IOCAF4_DefaultInterruptHandler
	bsf	PIE0,IOCIE,ACCESS
;On Interrupt Timer1Overflow Call iSR1Overflow
	bsf	PIE3,TMR1IE,ACCESS
;Enable IOCI interrupt
;PIE0.IOCIE = 1;
	bsf	PIE0,IOCIE,ACCESS
;dim jj as long
;do
SysDoLoop_S1
;wait While !bkbhit
SysWaitLoop1
	movff	NEXT_IN,SysBYTETempA
	movff	NEXT_OUT,SysBYTETempB
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	comf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfsc	SysTemp2,0,ACCESS
	bra	SysWaitLoop1
;id7 = bgetc
	rcall	FN_BGETC
	movff	BGETC,ID7
;HserPrint hex(jj_u)
;HserPrint hex(jj_e)
;HserPrint hex(jj_h)
;HserPrint hex(jj)
;HSerSend 0x3A
;HserPrint id7/8
	movff	ID7,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	rcall	SYSDIVSUB
	movff	SysBYTETempA,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT312
;HSerSend  13
	movlw	13
	movwf	SERDATA,ACCESS
	rcall	HSERSEND300
;loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;do
SysDoLoop_S2
;do
;if porta.4=1 then
;Settimer 1,0
;exit do 'start of pulse
;end if
;loop
;do
;if porta.4=0 then
;exit do 'end of pulse
;end if
;loop
;wait While !bkbhit
SysWaitLoop2
	movff	NEXT_IN,SysBYTETempA
	movff	NEXT_OUT,SysBYTETempB
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	comf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfsc	SysTemp2,0,ACCESS
	bra	SysWaitLoop2
;id7 = bgetc
	rcall	FN_BGETC
	movff	BGETC,ID7
;dim id7 as byte
;id7=timer1 'id7=37 is about 150 ms
;DIM LAST
;Select Case id7
;Case 150ms to 288ms
SysSelect1Case1
	movlw	37
	subwf	ID7,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysSelect1Case2
	movf	ID7,W,ACCESS
	sublw	72
	btfss	STATUS, C,ACCESS
	bra	SysSelect1Case2
;iF JJ < LAST THEN
	movff	JJ,SysLONGTempA
	movff	JJ_H,SysLONGTempA_H
	movff	JJ_U,SysLONGTempA_U
	movff	JJ_E,SysLONGTempA_E
	movff	LAST,SysLONGTempB
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSCOMPLESSTHAN32
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF1
;HSerPrint id7
	movff	ID7,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT312
;HSerSend 9
	movlw	9
	movwf	SERDATA,ACCESS
	rcall	HSERSEND300
;HserPrint "BCD = "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*6
	rcall	HSERPRINT311
;HSerPrint BcdToDec_GCB ( jj )
	movff	JJ,SYSINVAL
	rcall	FN_BCDTODEC_GCB
	movff	BCDTODEC_GCB,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT312
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;END IF
ENDIF1
;LAST = JJ
	movff	JJ,LAST
;Case 288ms to 440ms
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	72
	subwf	ID7,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysSelect1Case3
	movf	ID7,W,ACCESS
	sublw	110
	btfss	STATUS, C,ACCESS
	bra	SysSelect1Case3
;Case 440ms to timeout
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	110
	subwf	ID7,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysSelect1Case4
	movf	ID7,W,ACCESS
	sublw	255
	btfss	STATUS, C,ACCESS
	bra	SysSelect1Case4
;jj=0
	clrf	JJ,ACCESS
	clrf	JJ_H,ACCESS
	clrf	JJ_U,ACCESS
	clrf	JJ_E,ACCESS
;HserPrint "Minute Marker "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*14
	rcall	HSERPRINT311
;HserPrintByteCRLF id7
	movff	ID7,PRINTVALUE
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTBYTECRLF
;Case Else
	bra	SysSelectEnd1
SysSelect1Case4
;HserPrint "BCD = "
;HSerPrint BcdToDec_GCB ( jj )
;HserPrintCRLF
;End Select
SysSelectEnd1
;if id7<110 then
	movlw	110
	subwf	ID7,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF2
;screen3
;HserPrint timer1
;HserPrintCRLF
;end if
ENDIF2
;if id7>110 then 'found minute marker
	movf	ID7,W,ACCESS
	sublw	110
	btfsc	STATUS, C,ACCESS
	bra	ENDIF3
;jj=0
;khour1=khour 'update on minute roll-over
;kmin1=kmin
;kday1=kday
;kmonth1=kmonth
;kyear1=kyear
;khour=0
;kmin=0
;kday=0
;kmonth=0
;kyear=0
;screen3
;end if
ENDIF3
;binary coded decimal (arrgh!!)
;if id7>37 and id7<72 then
;HSerPrint id7
;HSerSend 9
;HserPrint "BCD = "
;HSerPrint BcdToDec_GCB ( jj )
;HserPrintCRLF
;if jj=51 then kmin=kmin+1
;if jj=50 then kmin=kmin+2
;if jj=49 then kmin=kmin+4
;if jj=48 then kmin=kmin+8
;if jj=47 then kmin=kmin+10
;if jj=46 then kmin=kmin+20
;if jj=45 then kmin=kmin+40
;if jj=44 then khour=khour+1
;if jj=43 then khour=khour+2
;if jj=42 then khour=khour+4
;if jj=41 then khour=khour+8
;if jj=40 then khour=khour+10
;if jj=39 then khour=khour+20
;if jj=35 then kday=kday+1
;if jj=34 then kday=kday+2
;if jj=33 then kday=kday+4
;if jj=32 then kday=kday+8
;if jj=31 then kday=kday+10
;if jj=30 then kday=kday+20
;if jj=29 then kmonth=kmonth+1
;if jj=28 then kmonth=kmonth+2
;if jj=27 then kmonth=kmonth+4
;if jj=26 then kmonth=kmonth+8
;if jj=25 then kmonth=kmonth+10
;if jj=24 then kyear=kyear+1
;if jj=23 then kyear=kyear+2
;if jj=22 then kyear=kyear+4
;if jj=21 then kyear=kyear+8
;if jj=20 then kyear=kyear+10
;if jj=19 then kyear=kyear+20
;if jj=18 then kyear=kyear+40
;if jj=17 then kyear=kyear+80
;end if
;loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;end 'should never get here
	bra	BASPROGRAMEND
;Supporting subroutines
;Convert binary coded decimal to pure decimal
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: stdbasic.h (321)
FN_BCDTODEC_GCB
;BcdToDec_GCB = (SysInVal/16)*10
	movff	SYSINVAL,SysBYTETempA
	movlw	16
	movwf	SysBYTETempB,ACCESS
	rcall	SYSDIVSUB
	movff	SysBYTETempA,SysTemp1
	movf	SysTemp1,W,ACCESS
	mullw	10
	movff	PRODL,BCDTODEC_GCB
;BcdToDec_GCB = BcdToDec_GCB + SysInVal%16
	movff	SYSINVAL,SysBYTETempA
	movlw	16
	movwf	SysBYTETempB,ACCESS
	rcall	SYSDIVSUB
	movf	SysBYTETempX,W,ACCESS
	addwf	BCDTODEC_GCB,F,ACCESS
	return

;********************************************************************************

;Source: DCFprototype.gcb (382)
FN_BGETC
;Dim local_next_out as Byte    'maintain a local copy of the next_out variable to ensure it does not change when an Interrupt happens
;local_next_out = next_out
	movff	NEXT_OUT,LOCAL_NEXT_OUT
;bgetc = buffer(local_next_out)
	lfsr	0,BUFFER
	movf	LOCAL_NEXT_OUT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,BGETC
;local_next_out=(local_next_out+1) % BUFFER_SIZE
	incf	LOCAL_NEXT_OUT,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	movlw	64
	movwf	SysBYTETempB,ACCESS
	rcall	SYSDIVSUB
	movff	SysBYTETempX,LOCAL_NEXT_OUT
;INTOFF
	bcf	SYSINTSTATESAVE0,0,ACCESS
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSINTSTATESAVE0,0,ACCESS
	bcf	INTCON0,GIE,ACCESS
;next_out = local_next_out
	movff	LOCAL_NEXT_OUT,NEXT_OUT
;INTON
	btfss	SYSINTSTATESAVE0,0,ACCESS
	bcf	INTCON0,GIE,ACCESS
	btfsc	SYSINTSTATESAVE0,0,ACCESS
	bsf	INTCON0,GIE,ACCESS
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	17
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	1
	movwf	DELAYTEMP,ACCESS
DMS_INNER
	decfsz	DELAYTEMP, F,ACCESS
	bra	DMS_INNER
	decfsz	DELAYTEMP2, F,ACCESS
	bra	DMS_OUTER
	decfsz	SysWaitTempMS, F,ACCESS
	bra	DMS_START
	decfsz	SysWaitTempMS_H, F,ACCESS
	bra	DMS_START
	return

;********************************************************************************

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	decfsz	SysWaitTempS, F,ACCESS
	bra	DS_START
	return

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (2307)
HSERPRINT311
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF36
;Write Data
;for SysPrintTemp = 1 to PrintLen
	movlw	1
	movwf	SYSPRINTTEMP,ACCESS
SysForLoop2
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND301
;next
;Positive value Step Handler in For-next statement :#4p 
	movf	SYSPRINTTEMP,W,ACCESS
	subwf	PRINTLEN,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF37
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	incf	SYSPRINTTEMP,F,ACCESS
	bra	SysForLoop2
;END IF
ENDIF37
SysForLoopEnd2
;End If
ENDIF36
;CR
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (2330)
HSERPRINT312
;OutValueTemp = 0
	clrf	OUTVALUETEMP,ACCESS
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ENDIF38
;OutValueTemp = SerPrintVal / 100
	movff	SERPRINTVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	rcall	SYSDIVSUB
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,ACCESS
	movwf	SERDATA,ACCESS
	rcall	HSERSEND301
;End If
ENDIF38
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	rcall	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp1
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF39
;OutValueTemp = SerPrintVal / 10
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SYSDIVSUB
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,ACCESS
	movwf	SERDATA,ACCESS
	rcall	HSERSEND301
;End If
ENDIF39
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W,ACCESS
	movwf	SERDATA,ACCESS
	bra	HSERSEND301
;CR

;********************************************************************************

;Source: usart.h (2458)
HSERPRINTBYTECRLF
;HSerPrint(PrintValue)
	movff	PRINTVALUE,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT312
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,ACCESS
	rcall	HSERSEND301
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,ACCESS
	bra	HSERSEND301

;********************************************************************************

;Source: usart.h (2464)
HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd1
SysRepeatLoop1
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,ACCESS
	rcall	HSERSEND301
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,ACCESS
	rcall	HSERSEND301
;end Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

;Source: usart.h (2290)
HSERPRINTSTRINGCRLF
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF34
;Write Data
;for SysPrintTemp = 1 to PrintLen
	movlw	1
	movwf	SYSPRINTTEMP,ACCESS
SysForLoop1
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND301
;next
;Positive value Step Handler in For-next statement :#4p 
	movf	SYSPRINTTEMP,W,ACCESS
	subwf	PRINTLEN,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF35
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	incf	SYSPRINTTEMP,F,ACCESS
	bra	SysForLoop1
;END IF
ENDIF35
SysForLoopEnd1
;End If
ENDIF34
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,ACCESS
	rcall	HSERSEND301
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,ACCESS
	bra	HSERSEND301

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (1356)
HSERSEND300
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop3
	btfss	PIR4,U1TXIF,ACCESS
	bra	SysWaitLoop3
;TXREG = SerData
	movff	SERDATA,U1TXB
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (1458)
HSERSEND301
HSERSENDUSART1HANDLER
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop4
	btfss	PIR4,U1TXIF,ACCESS
	bra	SysWaitLoop4
;TXREG = SerData
	movff	SERDATA,U1TXB
	return

;********************************************************************************

;Source: DCFprototype.gcb (393)
INITBUFFERRING
;Set the buffer to the first address
;next_in = 0
	clrf	NEXT_IN,ACCESS
;next_out = 0
	clrf	NEXT_OUT,ACCESS
	return

;********************************************************************************

;Source: DCFprototype.gcb (53)
INITPPS
;Module: UART pin directions
;Dir PORTC.6 Out    ' Make TX1 pin an output
	bcf	TRISC,6,ACCESS
;Module: UART1
;RC6PPS = 0x0020    'TX1 > RC6
	movlw	32
	banksel	RC6PPS
	movwf	RC6PPS,BANKED
	banksel	0
	return

;********************************************************************************

;Source: system.h (159)
INITSYS
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	movlw	96
	movwf	OSCCON1,BANKED
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	clrf	OSCCON3,BANKED
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	clrf	OSCEN,BANKED
;Default value
;OSCTUNE = 0x00
	clrf	OSCTUNE,BANKED
;asm showdebug The MCU is a chip family ChipFamily
;Section supports many MCUs, 18FxxK40, 18FxxK42 etc that have NDIV3 bit
;asm showdebug OSCCON type is 101
;OSCCON1 = 0x60
	movlw	96
	movwf	OSCCON1,BANKED
;Clear NDIV3:0
;NDIV3 = 0
	bcf	OSCCON1,NDIV3,BANKED
;NDIV2 = 0
	bcf	OSCCON1,NDIV2,BANKED
;NDIV1 = 0
	bcf	OSCCON1,NDIV1,BANKED
;NDIV0 = 0
	bcf	OSCCON1,NDIV0,BANKED
;OSCFRQ = 0b00000000  '0.5mhz
	clrf	OSCFRQ,BANKED
;NDIV0 = 1
	bsf	OSCCON1,NDIV0,BANKED
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Clear BSR on ChipFamily16 MCUs
;BSR = 0
	clrf	BSR,ACCESS
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,BANKED
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;ANSELE = 0
	clrf	ANSELE,BANKED
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2EN,BANKED
;C1EN = 0
	bcf	CM1CON0,C1EN,BANKED
;
;'Turn off all ports
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
	return

;********************************************************************************

;Source: timer.h (1582)
INITTIMER1
;Asummptions
;- Pwr On Reset State of TxCON for 1/3/5/7 is "0"
;- TXCON Timer REGISTER for 1/3/5/7 are NOT the Same on ALL PICS
;- TMRON is Bit0 on all Chips
;- OSCEN & SOSCEN are always TxCON.3 and perform the same function
;but, of course, see Datasheet for Detailed Register Information
;Handle PICs with Timer1 module have T1CON register
;33 Newer Chips have TxCLK Register ( TIMER 1/3/5/7 )
;
;12/16F16xx   Series
;16F153xx     Series
;16F188xx     Series
;18F1xxK40    series
;If TMRPres <> 0 then
	movf	TMRPRES,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF28
;IF TMRPres <> 16 then
	movlw	16
	subwf	TMRPRES,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF31
;IF TMRPres <> 32 then
	movlw	32
	subwf	TMRPRES,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF32
;IF TMRPres <> 48 then
	movlw	48
	subwf	TMRPRES,W,ACCESS
	btfss	STATUS, Z,ACCESS
;TMRPres = 0
	clrf	TMRPRES,ACCESS
;END IF
;END IF
ENDIF32
;END IF
ENDIF31
;END IF
ENDIF28
;IF TMR1ON = 1 then Set TMRPres.0 ON  'The timer running/ Dont Stop !
	banksel	T1CON
	btfsc	T1CON,TMR1ON,BANKED
;IF TMR1ON = 1 then Set TMRPres.0 ON  'The timer running/ Dont Stop !
	bsf	TMRPRES,0,ACCESS
;IF TMR1ON = 1 then Set TMRPres.0 ON  'The timer running/ Dont Stop !
;IF TMRSource > 15 OR TMRSource <0 then TRMSource = 0  'failsafe
	movff	TMRSOURCE,SysBYTETempB
	movlw	15
	movwf	SysBYTETempA,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp1
	movff	TMRSOURCE,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	movf	SysTemp1,W,ACCESS
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfsc	SysTemp2,0,ACCESS
;IF TMRSource > 15 OR TMRSource <0 then TRMSource = 0  'failsafe
	clrf	TRMSOURCE,ACCESS
;IF TMRSource > 15 OR TMRSource <0 then TRMSource = 0  'failsafe
;T1CLK = TMRSource
	movff	TMRSOURCE,T1CLK
;T1CON = TMRPres
	movff	TMRPRES,T1CON
	return

;********************************************************************************

;Source: usart.h (942)
INITUSART
;Set the default value for USART handler - required when more than one USART
;comport = 1
	movlw	1
	movwf	COMPORT,ACCESS
;PIC USART 1 Init
;U1BRGH=SPBRGH_TEMP
	banksel	U1BRGH
	clrf	U1BRGH,BANKED
;U1BRGL=SPBRGL_TEMP
	movlw	12
	movwf	U1BRGL,BANKED
;U1BRGS = BRGS1_SCRIPT
	bsf	U1CON0,U1BRGS,BANKED
;U1TXEN=1   'Enable TX1
	bsf	U1CON0,U1TXEN,BANKED
;U1RXEN=1   'Enable RX1
	bsf	U1CON0,U1RXEN,BANKED
;ON_U1CON1=1 'Enable USART1
	bsf	U1CON1,ON_U1CON1,BANKED
	banksel	0
	return

;********************************************************************************

INTERRUPT
;Use Automatic Context Save for K42 and K83 with MVECEN = OFF.  Interrupt priority not supported
;Store system variables
	movff	FSR0L,SaveFSR0L
	movff	FSR0H,SaveFSR0H
	movff	SysTemp1,SaveSysTemp1
	movff	SysByteTempA,SaveSysByteTempA
	movff	SysByteTempB,SaveSysByteTempB
	movff	SysByteTempX,SaveSysByteTempX
	movff	SysDivLoop,SaveSysDivLoop
	movff	FSR1L,SaveFSR1L
	movff	FSR1H,SaveFSR1H
	movff	SysStringLength,SaveSysStringLength
;On Interrupt handlers
	btfss	PIE0,IOCIE,ACCESS
	bra	NotIOCIF
	btfss	PIR0,IOCIF,ACCESS
	bra	NotIOCIF
	rcall	IOCAF4_DEFAULTINTERRUPTHANDLER
	bcf	PIR0,IOCIF,ACCESS
	bra	INTERRUPTDONE
NotIOCIF
	btfss	PIE3,TMR1IE,ACCESS
	bra	NotTMR1IF
	btfss	PIR3,TMR1IF,ACCESS
	bra	NotTMR1IF
	rcall	ISR1OVERFLOW
	bcf	PIR3,TMR1IF,ACCESS
	bra	INTERRUPTDONE
NotTMR1IF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	movff	SaveFSR0L,FSR0L
	movff	SaveFSR0H,FSR0H
	movff	SaveSysTemp1,SysTemp1
	movff	SaveSysByteTempA,SysByteTempA
	movff	SaveSysByteTempB,SysByteTempB
	movff	SaveSysByteTempX,SysByteTempX
	movff	SaveSysDivLoop,SysDivLoop
	movff	SaveFSR1L,FSR1L
	movff	SaveFSR1H,FSR1H
	movff	SaveSysStringLength,SysStringLength
	retfie	1

;********************************************************************************

;Source: DCFprototype.gcb (145)
IOCAF4_DEFAULTINTERRUPTHANDLER
;IF IOCAF4 = 1 Then
	banksel	IOCAF
	btfss	IOCAF,IOCAF4,BANKED
	bra	ENDIF4
;Select Case SignalInPort
;Case 1
SysSelect2Case1
	btfss	PORTA,4,ACCESS
	bra	SysSelect2Case2
;Settimer 1,0
	movlw	1
	movwf	TMRNUMBER,ACCESS
	clrf	TMRVALUE,ACCESS
	clrf	TMRVALUE_H,ACCESS
	banksel	0
	rcall	SETTIMER181
;StartTimer 1
	movlw	1
	movwf	TMRNUMBER,ACCESS
	rcall	STARTTIMER
;Case 0
	bra	SysSelectEnd2
SysSelect2Case2
	btfsc	PORTA,4,ACCESS
	bra	SysSelectEnd2
;StopTimer 1
	movlw	1
	movwf	TMRNUMBER,ACCESS
	banksel	0
	rcall	STOPTIMER
;buffer(next_in) = timer1
	lfsr	0,BUFFER
	movf	NEXT_IN,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	TIMER1,INDF0
;temppnt = next_in
	movff	NEXT_IN,TEMPPNT
;next_in = ( next_in + 1 ) % BUFFER_SIZE
	incf	NEXT_IN,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	movlw	64
	movwf	SysBYTETempB,ACCESS
	rcall	SYSDIVSUB
	movff	SysBYTETempX,NEXT_IN
;If ( next_in = next_out ) Then  ' buffer is full!!
	movf	NEXT_OUT,W,ACCESS
	subwf	NEXT_IN,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;next_in = temppnt
	movff	TEMPPNT,NEXT_IN
;End If
;jj++
	incf	JJ,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	JJ_H,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	JJ_U,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	JJ_E,F,ACCESS
;End Select
SysSelectEnd2
;IOCAF4 = 0
	banksel	IOCAF
	bcf	IOCAF,IOCAF4,BANKED
;End If
ENDIF4
	banksel	0
	return

;********************************************************************************

;Source: DCFprototype.gcb (166)
ISR1OVERFLOW
;HserPrint "**"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*2
	rcall	HSERPRINT311
;IOCAF4 = 0
	banksel	IOCAF
	bcf	IOCAF,IOCAF4,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:, Source: timer.h (1068)
SETTIMER181
;Dim TMRValue as word
;If TMRNumber = 0 Then
	movf	TMRNUMBER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF13
;TMRValue_H = [byte]TMRValue
	movff	TMRVALUE,TMRVALUE_H
;[byte]TMRValue = 0
	clrf	TMRVALUE,ACCESS
;end if
ENDIF13
;SetTimer ( TMRNumber, [word]TMRValue )
	bra	SETTIMER182

;********************************************************************************

;Overloaded signature: BYTE:WORD:, Source: timer.h (1089)
SETTIMER182
;If TMRNumber = 0 Then
	movf	TMRNUMBER,F,ACCESS
	btfsc	STATUS, Z,ACCESS
;Handle chips with TMR0H
;Use default 8-bit mode therefore _TMR0_16BIT_ not defined
;Added to resolve using 8bit Timer0 with enhance timer
;High byte is timer0 register of interest
;TMR0H = TMRValue_H
	movff	TMRVALUE_H,TMR0H
;End If
;If TMRNumber = 1 then
	decf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF15
;TMR1H = TMRValue_H
	movff	TMRVALUE_H,TMR1H
;TMR1L = TMRValue
	movff	TMRVALUE,TMR1L
;End If
ENDIF15
;If TMRNumber = 2 Then
	movlw	2
	subwf	TMRNUMBER,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;TMR2 = TMRValue
	movff	TMRVALUE,TMR2
;End If
;If TMRNumber = 3 then
	movlw	3
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF17
;TMR3H = TMRValue_H
	movff	TMRVALUE_H,TMR3H
;TMR3L = TMRValue
	movff	TMRVALUE,TMR3L
;End If
ENDIF17
;If TMRNumber = 4 Then
	movlw	4
	subwf	TMRNUMBER,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;TMR4 = TMRValue
	movff	TMRVALUE,TMR4
;End If
;If TMRNumber = 5 then
	movlw	5
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF19
;TMR5H = TMRValue_H
	movff	TMRVALUE_H,TMR5H
;TMR5L = TMRValue
	movff	TMRVALUE,TMR5L
;End If
ENDIF19
;If TMRNumber = 6 Then
	movlw	6
	subwf	TMRNUMBER,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;TMR6 = TMRValue
	movff	TMRVALUE,TMR6
;End If
	return

;********************************************************************************

;Source: timer.h (744)
STARTTIMER
;IF TMRNumber = 0 then Set T0EN on
	movf	TMRNUMBER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF6
;IF TMRNumber = 0 then Set T0EN on
	banksel	T0CON0
	bsf	T0CON0,T0EN,BANKED
;IF TMRNumber = 0 then Set T0EN on
ENDIF6
;IF TMRNumber = 1 then Set TMR1ON on
	decf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF7
;IF TMRNumber = 1 then Set TMR1ON on
	banksel	T1CON
	bsf	T1CON,TMR1ON,BANKED
;IF TMRNumber = 1 then Set TMR1ON on
ENDIF7
;IF TMRNumber = 2 then Set TMR2ON on
	movlw	2
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF8
;IF TMRNumber = 2 then Set TMR2ON on
	banksel	T2CON
	bsf	T2CON,TMR2ON,BANKED
;IF TMRNumber = 2 then Set TMR2ON on
ENDIF8
;IF TMRNumber = 3 then Set TMR3ON on
	movlw	3
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF9
;IF TMRNumber = 3 then Set TMR3ON on
	banksel	T3CON
	bsf	T3CON,TMR3ON,BANKED
;IF TMRNumber = 3 then Set TMR3ON on
ENDIF9
;IF TMRNumber = 4 then Set TMR4ON on
	movlw	4
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF10
;IF TMRNumber = 4 then Set TMR4ON on
	banksel	T4CON
	bsf	T4CON,TMR4ON,BANKED
;IF TMRNumber = 4 then Set TMR4ON on
ENDIF10
;IF TMRNumber = 5 then Set TMR5ON on
	movlw	5
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF11
;IF TMRNumber = 5 then Set TMR5ON on
	banksel	T5CON
	bsf	T5CON,TMR5ON,BANKED
;IF TMRNumber = 5 then Set TMR5ON on
ENDIF11
;IF TMRNumber = 6 then Set TMR6ON on
	movlw	6
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF12
;IF TMRNumber = 6 then Set TMR6ON on
	banksel	T6CON
	bsf	T6CON,TMR6ON,BANKED
;IF TMRNumber = 6 then Set TMR6ON on
ENDIF12
	banksel	0
	return

;********************************************************************************

;Source: timer.h (1265)
STOPTIMER
;Timer 0 always runs
;Note: Not Always!  Timer 0 on 18F Can be stopped/started
;If TMRNumber = 0 Then Set T0EN off
	movf	TMRNUMBER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF21
;If TMRNumber = 0 Then Set T0EN off
	banksel	T0CON0
	bcf	T0CON0,T0EN,BANKED
;If TMRNumber = 0 Then Set T0EN off
ENDIF21
;If TMRNumber = 1 Then Set TMR1ON OFF
	decf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF22
;If TMRNumber = 1 Then Set TMR1ON OFF
	banksel	T1CON
	bcf	T1CON,TMR1ON,BANKED
;If TMRNumber = 1 Then Set TMR1ON OFF
ENDIF22
;If TMRNumber = 2 Then Set TMR2ON OFF
	movlw	2
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF23
;If TMRNumber = 2 Then Set TMR2ON OFF
	banksel	T2CON
	bcf	T2CON,TMR2ON,BANKED
;If TMRNumber = 2 Then Set TMR2ON OFF
ENDIF23
;If TMRNumber = 3 Then Set TMR3ON OFF
	movlw	3
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF24
;If TMRNumber = 3 Then Set TMR3ON OFF
	banksel	T3CON
	bcf	T3CON,TMR3ON,BANKED
;If TMRNumber = 3 Then Set TMR3ON OFF
ENDIF24
;If TMRNumber = 4 Then Set TMR4ON OFF
	movlw	4
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF25
;If TMRNumber = 4 Then Set TMR4ON OFF
	banksel	T4CON
	bcf	T4CON,TMR4ON,BANKED
;If TMRNumber = 4 Then Set TMR4ON OFF
ENDIF25
;If TMRNumber = 5 Then Set TMR5ON OFF
	movlw	5
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF26
;If TMRNumber = 5 Then Set TMR5ON OFF
	banksel	T5CON
	bcf	T5CON,TMR5ON,BANKED
;If TMRNumber = 5 Then Set TMR5ON OFF
ENDIF26
;If TMRNumber = 6 Then Set TMR6ON OFF
	movlw	6
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF27
;If TMRNumber = 6 Then Set TMR6ON OFF
	banksel	T6CON
	bcf	T6CON,TMR6ON,BANKED
;If TMRNumber = 6 Then Set TMR6ON OFF
ENDIF27
	banksel	0
	return

;********************************************************************************

;Source: system.h (3078)
SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfseq SysByteTempA
	cpfseq	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (3383)
SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfslt SysByteTempA
	cpfslt	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (3471)
SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test Exp, exit if more
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W,ACCESS
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W,ACCESS
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W,ACCESS
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W,ACCESS
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLT32TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

;Source: system.h (2793)
SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F,ACCESS
;btfsc STATUS, Z
	btfsc	STATUS, Z,ACCESS
;return
	return
;Main calc routine
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP,ACCESS
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C,ACCESS
;rlf SysByteTempA, F
	rlcf	SYSBYTETEMPA, F,ACCESS
;rlf SysByteTempX, F
	rlcf	SYSBYTETEMPX, F,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F,ACCESS
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0,ACCESS
;btfsc STATUS, C
	btfsc	STATUS, C,ACCESS
;goto Div8NotNeg
	bra	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F,ACCESS
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv8Start
	bra	SYSDIV8START
	return

;********************************************************************************

;Source: system.h (1571)
SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;ChipFamily 16 support
;Get length
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movff	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movff	TABLAT,INDF1
;goto SysStringReadCheck
	bra	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;TBLRD*+
	tblrd*+
;movf TABLAT, W
	movf	TABLAT, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F,ACCESS
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
;Copy
SYSSTRINGREAD
;Copy char
;TBLRD*+
	tblrd*+
;movff TABLAT,PREINC1
	movff	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable1
	db	10,68,67,70,55,55,32,116,101,115,116


StringTable2
	db	2,42,42


StringTable3
	db	6,66,67,68,32,61,32


StringTable4
	db	14,77,105,110,117,116,101,32,77,97,114,107,101,114,32


;********************************************************************************


 END
