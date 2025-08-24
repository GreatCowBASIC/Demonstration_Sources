;Program compiled by GCBASIC (2025.05.16 (Windows 32 bit) : Build 1486) for Microchip AVR Assembler using FreeBASIC 1.07.1/2025-05-22 CRC248
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : C:\DDrive\GreatCowBASICGits\Demonstration_Sources\Railway_Level_Crossing_Solutions\LegoTrain\Lego train with points serial crossing v3.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : 
;   Output file      : C:\DDrive\GreatCowBASICGits\Demonstration_Sources\Railway_Level_Crossing_Solutions\LegoTrain\Lego train with points serial crossing v3.asm
;   Float Capability : 0
;********************************************************************************

;Chip Model: MEGA328P
;Assembler header file
.INCLUDE "m328pdef.inc"

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
.EQU	ADDRESSOUT=273	         ; 0x111
.EQU	ADREADPORT=274	         ; 0x112
.EQU	CALVAL1=275	         ; 0x113
.EQU	CALVAL2=276	         ; 0x114
.EQU	CALVAL3=277	         ; 0x115
.EQU	CALVAL4=278	         ; 0x116
.EQU	COMPORT=279	         ; 0x117
.EQU	COUNTPRESSES=280	         ; 0x118
.EQU	DATAOUT=281	         ; 0x119
.EQU	DATAOUT_H=282	         ; 0x11A
.EQU	EMERSONCROSSINGSTATE=283	         ; 0x11B
.EQU	EXTRALAPS=284	         ; 0x11C
.EQU	HSERRECEIVE=285	         ; 0x11D
.EQU	INBYTE=286	         ; 0x11E
.EQU	LAPCOUNTER=287	         ; 0x11F
.EQU	LAPCOUNTER_H=288	         ; 0x120
.EQU	LAPCOUNTREQUEST=289	         ; 0x121
.EQU	LASTSTATE=290	         ; 0x122
.EQU	LNPBYTECOUNT=291	         ; 0x123
.EQU	LNPCHECKSUM=292	         ; 0x124
.EQU	LNPINBUFFER=256	         ; 0x100
.EQU	LNPINBYTES=293	         ; 0x125
.EQU	LNPINCHECKSUM=294	         ; 0x126
.EQU	LNPONECOUNT=295	         ; 0x127
.EQU	LNPOUTBYTE=296	         ; 0x128
.EQU	LNPSENDDELAY=297	         ; 0x129
.EQU	LNPSENDRETRYCOUNT=298	         ; 0x12A
.EQU	LNPSENDTRYCOUNT=299	         ; 0x12B
.EQU	LNPSTATE=300	         ; 0x12C
.EQU	LNPSUCCESSFULSENDCOUNT=301	         ; 0x12D
.EQU	LNPWRITECONFLICT=302	         ; 0x12E
.EQU	LOOPSREMAINING=303	         ; 0x12F
.EQU	NUMBER=304	         ; 0x130
.EQU	NUMOUT=305	         ; 0x131
.EQU	OLDHIGHLAPS=306	         ; 0x132
.EQU	OUTBITMAP=307	         ; 0x133
.EQU	PFCHANNEL=308	         ; 0x134
.EQU	PFCHECKSUM=309	         ; 0x135
.EQU	PFDATA=310	         ; 0x136
.EQU	PFOUTDATA=311	         ; 0x137
.EQU	PFOUTDATA_H=312	         ; 0x138
.EQU	PFOUTPUT=313	         ; 0x139
.EQU	PFRESENDNO=314	         ; 0x13A
.EQU	PFRESENDNUMBER=315	         ; 0x13B
.EQU	PFSENDBUFFER=316	         ; 0x13C
.EQU	PFSENDBUFFER_H=317	         ; 0x13D
.EQU	PFTOGGLE=318	         ; 0x13E
.EQU	POINTCOMMAND=319	         ; 0x13F
.EQU	POINTSSTATE=320	         ; 0x140
.EQU	RANDOM=321	         ; 0x141
.EQU	RANDOMSEED=322	         ; 0x142
.EQU	RANDOMSEED_H=323	         ; 0x143
.EQU	RANDOMTEMP=324	         ; 0x144
.EQU	RANDOMTEMP_H=325	         ; 0x145
.EQU	READAD=326	         ; 0x146
.EQU	REPEATENABLECOUNT=327	         ; 0x147
.EQU	RESENDLAPCOUNTDOWN=328	         ; 0x148
.EQU	SAVESREG=329	         ; 0x149
.EQU	SAVESYSBYTETEMPX=330	         ; 0x14A
.EQU	SAVESYSCALCTEMPA=331	         ; 0x14B
.EQU	SAVESYSCALCTEMPB=332	         ; 0x14C
.EQU	SAVESYSSTRINGA=333	         ; 0x14D
.EQU	SAVESYSSTRINGA_H=334	         ; 0x14E
.EQU	SAVESYSTEMP1=335	         ; 0x14F
.EQU	SAVESYSTEMP2=336	         ; 0x150
.EQU	SAVESYSTEMP3=337	         ; 0x151
.EQU	SAVESYSVALUECOPY=338	         ; 0x152
.EQU	SERDATA=339	         ; 0x153
.EQU	STATE=340	         ; 0x154
.EQU	SYSINTSTATESAVE0=341	         ; 0x155
.EQU	SYSREPEATTEMP1=342	         ; 0x156
.EQU	SYSREPEATTEMP10=343	         ; 0x157
.EQU	SYSREPEATTEMP11=344	         ; 0x158
.EQU	SYSREPEATTEMP3=345	         ; 0x159
.EQU	SYSREPEATTEMP4=346	         ; 0x15A
.EQU	SYSREPEATTEMP8=347	         ; 0x15B
.EQU	SYSREPEATTEMP9=348	         ; 0x15C
.EQU	TIMEOUT=349	         ; 0x15D
.EQU	TIMEOUT_H=350	         ; 0x15E
.EQU	TIMESINCEPRESS=351	         ; 0x15F
.EQU	TIMESINCEPRESS_H=352	         ; 0x160

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSBITTEST=r5
.DEF	SYSBYTETEMPA=r22
.DEF	SYSBYTETEMPB=r28
.DEF	SYSBYTETEMPX=r0
.DEF	SYSCALCTEMPA=r22
.DEF	SYSCALCTEMPB=r28
.DEF	SYSCALCTEMPX=r0
.DEF	SYSDIVLOOP=r5
.DEF	SYSREADA=r30
.DEF	SYSREADA_H=r31
.DEF	SYSSTRINGA=r26
.DEF	SYSSTRINGA_H=r27
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMP10US=r27
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30
.DEF	SYSWAITTEMPS=r31
.DEF	SYSWAITTEMPUS=r27
.DEF	SYSWAITTEMPUS_H=r28
.DEF	SYSWORDTEMPA=r22
.DEF	SYSWORDTEMPA_H=r23
.DEF	SYSWORDTEMPB=r28
.DEF	SYSWORDTEMPB_H=r29
.DEF	SYSTEMP1=r1
.DEF	SYSTEMP1_H=r2
.DEF	SYSTEMP2=r16
.DEF	SYSTEMP2_H=r17
.DEF	SYSTEMP3=r18

;********************************************************************************

;Alias variables
#define	EEADDRESS	33
#define	EEADDRESS_H	34
#define	EEDATAVALUE	32
#define	SWAP4	SYSCALCTEMPX
#define	SWAP4IN	SYSCALCTEMPA
#define	SYSHSERRECEIVEBYTE	285
#define	SYSLNPINBUFFER_1	257
#define	SYSLNPINBUFFER_2	258
#define	SYSREADADBYTE	326

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
	reti	;PCINT0
	.ORG	8
	reti	;PCINT1
	.ORG	10
	reti	;PCINT2
	.ORG	12
	reti	;WDT
	.ORG	14
	reti	;TIMER2_COMPA
	.ORG	16
	reti	;TIMER2_COMPB
	.ORG	18
	reti	;TIMER2_OVF
	.ORG	20
	reti	;TIMER1_CAPT
	.ORG	22
	reti	;TIMER1_COMPA
	.ORG	24
	reti	;TIMER1_COMPB
	.ORG	26
	reti	;TIMER1_OVF
	.ORG	28
	reti	;TIMER0_COMPA
	.ORG	30
	reti	;TIMER0_COMPB
	.ORG	32
	reti	;TIMER0_OVF
	.ORG	34
	reti	;SPI_STC
	.ORG	36
	rjmp	IntUSART_RX ;USART_RX
	.ORG	38
	reti	;USART_UDRE
	.ORG	40
	reti	;USART_TX
	.ORG	42
	reti	;ADC
	.ORG	44
	reti	;EE_READY
	.ORG	46
	reti	;ANALOG_COMP
	.ORG	48
	reti	;TWI
	.ORG	50
	reti	;SPM_READY

;********************************************************************************

;Program_memory_page: 0
.ORG	52
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	SPL, SysValueCopy
;Call initialisation routines
	rcall	INITSYS
	rcall	INITUNO
	rcall	INITUSART
	rcall	LNPINITIALISE
	rcall	INITRANDOM
;Enable interrupts
	sei
;Automatic pin direction setting
	sbi	DDRB,2
	sbi	DDRD,7
	sbi	DDRD,6
	sbi	DDRD,5
	sbi	DDRD,4
	cbi	DDRD,3
	sbi	DDRD,2

;Start_of_the_main_program
;	
;
;	See Lego train with points serial crossing v3.md for documentation
;	
;
;Include files (Libraries)
;Defines (Constants)
;Variables
;Dim PFOutData As word
;Dim PFSendBuffer As word
;Dim calVal1, calVal2, calVal3, calVal4 As byte
;Dim TimeSincePress As word
;Dim EmersonCrossingState As byte
;Dim LapCounter As word
;Dim LapCountRequest As byte
;Dim RepeatEnableCount As byte
;Good speeds: 5 drive, 3 slow
;Sensors:
;Sensor 1 near signal
;Sensor 2 next
;Sensor 3 next
;Sensor 4 before station
;calVal1 = ReadAD(SECTION_1)
	ldi	SysValueCopy,0
	sts	ADREADPORT,SysValueCopy
	rcall	FN_READAD27
	lds	SysValueCopy,SYSREADADBYTE
	sts	CALVAL1,SysValueCopy
;calVal2 = ReadAD(SECTION_2)
	ldi	SysValueCopy,2
	sts	ADREADPORT,SysValueCopy
	rcall	FN_READAD27
	lds	SysValueCopy,SYSREADADBYTE
	sts	CALVAL2,SysValueCopy
;calVal3 = ReadAD(SECTION_3)
	ldi	SysValueCopy,3
	sts	ADREADPORT,SysValueCopy
	rcall	FN_READAD27
	lds	SysValueCopy,SYSREADADBYTE
	sts	CALVAL3,SysValueCopy
;calVal4 = ReadAD(SECTION_4)
	ldi	SysValueCopy,1
	sts	ADREADPORT,SysValueCopy
	rcall	FN_READAD27
	lds	SysValueCopy,SYSREADADBYTE
	sts	CALVAL4,SysValueCopy
;EmersonCrossingState = 0
	ldi	SysValueCopy,0
	sts	EMERSONCROSSINGSTATE,SysValueCopy
;LapCountRequest = 255
	ldi	SysValueCopy,255
	sts	LAPCOUNTREQUEST,SysValueCopy
;RepeatEnableCount = 0
	ldi	SysValueCopy,0
	sts	REPEATENABLECOUNT,SysValueCopy
;ResendLapCountdown = 0
	ldi	SysValueCopy,0
	sts	RESENDLAPCOUNTDOWN,SysValueCopy
;PointsState = 255
	ldi	SysValueCopy,255
	sts	POINTSSTATE,SysValueCopy
;Wait 100 ms
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;ShowNumber 0
	ldi	SysValueCopy,0
	sts	NUMOUT,SysValueCopy
	rcall	SHOWNUMBER
;State = 0
	ldi	SysValueCopy,0
	sts	STATE,SysValueCopy
;LastState = 255
	ldi	SysValueCopy,255
	sts	LASTSTATE,SysValueCopy
;Main loop
;Do Forever
SysDoLoop_S1:
;If State = 0 Then
	lds	SysCalcTempA,STATE
	tst	SysCalcTempA
	breq	PC + 2
	rjmp	ELSE1_1
;If State <> LastState Then
	lds	SysCalcTempA,STATE
	lds	SysCalcTempB,LASTSTATE
	cp	SysCalcTempA,SysCalcTempB
	breq	ENDIF2
;PFSendSingleOutputPWM 4, 1, 0
	ldi	SysValueCopy,4
	sts	PFCHANNEL,SysValueCopy
	ldi	SysValueCopy,1
	sts	PFOUTPUT,SysValueCopy
	ldi	SysValueCopy,0
	sts	PFDATA,SysValueCopy
	rcall	PFSENDSINGLEOUTPUTPWM
;LastState = 0
	ldi	SysValueCopy,0
	sts	LASTSTATE,SysValueCopy
;Try delay before LNP, see if that fixes gate not opening issue 2024-04-20
;Wait 50 ms
	ldi	SysWaitTempMS,50
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SendPointsLNP LIGHT_RED + TRACK_STRAIGHT
	ldi	SysValueCopy,0
	sts	POINTCOMMAND,SysValueCopy
	rcall	SENDPOINTSLNP
;Open Emerson Crossing
;EmersonCrossingOpen
	rcall	EMERSONCROSSINGOPEN
;Clear lap count if LNP button
;If LapCountRequest <> 255 Then
	lds	SysCalcTempA,LAPCOUNTREQUEST
	cpi	SysCalcTempA,255
	breq	ENDIF14
;Repeat 3
	ldi	SysValueCopy,3
	sts	SysRepeatTemp1,SysValueCopy
SysRepeatLoop1:
;UIClearLapCount
	rcall	UICLEARLAPCOUNT
;Wait 10 ms
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;UIEnableCounting
	rcall	UIENABLECOUNTING
;Wait 10 ms
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;End Repeat
	lds	SysTemp1,SysRepeatTemp1
	dec	SysTemp1
	sts	SysRepeatTemp1,SysTemp1
	brne	SysRepeatLoop1
SysRepeatLoopEnd1:
;RepeatEnableCount = 0
	ldi	SysValueCopy,0
	sts	REPEATENABLECOUNT,SysValueCopy
;End If
ENDIF14:
;End If
ENDIF2:
;Signals to red
;SIGNAL_DEPART = RED
	cbi	PORTD,2
;SIGNAL_PASS = RED
	cbi	PORTB,2
;Get lap count from button
;LoopsRemaining = 0
	ldi	SysValueCopy,0
	sts	LOOPSREMAINING,SysValueCopy
;Count locally if no lap count recieved over bus
;If LapCountRequest = 255 Then
	lds	SysCalcTempA,LAPCOUNTREQUEST
	cpi	SysCalcTempA,255
	brne	ELSE3_1
;ShowNumber 0
	ldi	SysValueCopy,0
	sts	NUMOUT,SysValueCopy
	rcall	SHOWNUMBER
;LoopsRemaining = CountPresses
	ldi	SysValueCopy,232
	sts	TIMEOUT,SysValueCopy
	ldi	SysValueCopy,3
	sts	TIMEOUT_H,SysValueCopy
	rcall	FN_COUNTPRESSES
	lds	SysValueCopy,COUNTPRESSES
	sts	LOOPSREMAINING,SysValueCopy
;Else
	rjmp	ENDIF3
ELSE3_1:
;Request count from LNP button
;If RepeatEnableCount > 250 Then
	ldi	SysCalcTempA,250
	lds	SysCalcTempB,REPEATENABLECOUNT
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE15_1
;RepeatEnableCount = 0
	ldi	SysValueCopy,0
	sts	REPEATENABLECOUNT,SysValueCopy
;UIEnableCounting
	rcall	UIENABLECOUNTING
;Else
	rjmp	ENDIF15
ELSE15_1:
;RepeatEnableCount = RepeatEnableCount + 1
	lds	SysTemp1,REPEATENABLECOUNT
	inc	SysTemp1
	sts	REPEATENABLECOUNT,SysTemp1
;End If
ENDIF15:
;If LapCountRequest.7 = 1 Then
	lds	SysBitTest,LAPCOUNTREQUEST
	sbrs	SysBitTest,7
	rjmp	ENDIF16
;LoopsRemaining = LapCountRequest And 127
	ldi	SysTemp2,127
	lds	SysTemp1,LAPCOUNTREQUEST
	and	SysTemp1,SysTemp2
	sts	LOOPSREMAINING,SysTemp1
;End If
ENDIF16:
;End If
ENDIF3:
;Resend lap counter?
;If ResendLapCountdown = 0 Then
	lds	SysCalcTempA,RESENDLAPCOUNTDOWN
	tst	SysCalcTempA
	brne	ELSE4_1
;SendLapCount
	rcall	SENDLAPCOUNT
;If LNP button not present, resend every time
;If LNP button is present, only resend every 250 loops
;If LapCountRequest <> 255 Then
	lds	SysCalcTempA,LAPCOUNTREQUEST
	cpi	SysCalcTempA,255
	breq	ENDIF17
;ResendLapCountdown = 250
	ldi	SysValueCopy,250
	sts	RESENDLAPCOUNTDOWN,SysValueCopy
;End If
ENDIF17:
;Else
	rjmp	ENDIF4
ELSE4_1:
;ResendLapCountdown = ResendLapCountdown - 1
	lds	SysTemp1,RESENDLAPCOUNTDOWN
	dec	SysTemp1
	sts	RESENDLAPCOUNTDOWN,SysTemp1
;End If
ENDIF4:
;If laps requested, time to send train around
;If LoopsRemaining > 0 Then
	ldi	SysCalcTempA,0
	lds	SysCalcTempB,LOOPSREMAINING
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF5
;State = 1
	ldi	SysValueCopy,1
	sts	STATE,SysValueCopy
;IncrementLapCount LoopsRemaining
	lds	SysValueCopy,LOOPSREMAINING
	sts	EXTRALAPS,SysValueCopy
	rcall	INCREMENTLAPCOUNT
;Disable counting if train about to go
;If LapCountRequest <> 255 Then
	lds	SysCalcTempA,LAPCOUNTREQUEST
	cpi	SysCalcTempA,255
	breq	ENDIF18
;UIDisableCounting
	rcall	UIDISABLECOUNTING
;End If
ENDIF18:
;End If
ENDIF5:
;Make loop time at least 1 ms for timing
;Wait 1 ms
	ldi	SysWaitTempMS,1
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Else If State = 1 Then
	rjmp	ENDIF1
ELSE1_1:
	lds	SysCalcTempA,STATE
	cpi	SysCalcTempA,1
	breq	PC + 2
	rjmp	ELSE1_2
;If State <> LastState Then
	lds	SysCalcTempA,STATE
	lds	SysCalcTempB,LASTSTATE
	cp	SysCalcTempA,SysCalcTempB
	breq	ENDIF6
;Activate crossing
;EmersonCrossingClose
	rcall	EMERSONCROSSINGCLOSE
;Wait until gates shut, if crossing present
;If EmersonCrossingState <> 0 Then
	lds	SysCalcTempA,EMERSONCROSSINGSTATE
	tst	SysCalcTempA
	breq	ENDIF19
;Repeat 12
	ldi	SysValueCopy,12
	sts	SysRepeatTemp1,SysValueCopy
SysRepeatLoop2:
;Wait 500 ms
	ldi	SysWaitTempMS,244
	ldi	SysWaitTempMS_H,1
	rcall	Delay_MS
;If EmersonCrossingState = 7 Then
	lds	SysCalcTempA,EMERSONCROSSINGSTATE
	cpi	SysCalcTempA,7
	brne	ENDIF22
;Goto GatesHaveClosed
	rjmp	GATESHAVECLOSED
;End If
ENDIF22:
;EmersonCrossingClose
	rcall	EMERSONCROSSINGCLOSE
;End Repeat
	lds	SysTemp1,SysRepeatTemp1
	dec	SysTemp1
	sts	SysRepeatTemp1,SysTemp1
	brne	SysRepeatLoop2
SysRepeatLoopEnd2:
GATESHAVECLOSED:
;End If
ENDIF19:
;Start train
;SIGNAL_DEPART = GREEN
	sbi	PORTD,2
;Wait 250 ms
	ldi	SysWaitTempMS,250
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;PFSendSingleOutputPWM 4, 1, DRIVE_SPEED
	ldi	SysValueCopy,4
	sts	PFCHANNEL,SysValueCopy
	ldi	SysValueCopy,1
	sts	PFOUTPUT,SysValueCopy
	ldi	SysValueCopy,11
	sts	PFDATA,SysValueCopy
	rcall	PFSENDSINGLEOUTPUTPWM
;Wait 1 s
	ldi	SysWaitTempS,1
	rcall	Delay_S
;LastState = State
	lds	SysValueCopy,STATE
	sts	LASTSTATE,SysValueCopy
;End If
ENDIF6:
;If ReadAD(SECTION_2) < TRAIN_SENSOR_THRESHOLD Then
	ldi	SysValueCopy,2
	sts	ADREADPORT,SysValueCopy
	rcall	FN_READAD27
	lds	SysCalcTempA,SYSREADADBYTE
	cpi	SysCalcTempA,75
	brsh	ENDIF7
;State = 2
	ldi	SysValueCopy,2
	sts	STATE,SysValueCopy
;End If
ENDIF7:
;Else If State = 2 Then
	rjmp	ENDIF1
ELSE1_2:
	lds	SysCalcTempA,STATE
	cpi	SysCalcTempA,2
	brne	ELSE1_3
;If State <> LastState Then
	lds	SysCalcTempA,STATE
	lds	SysCalcTempB,LASTSTATE
	cp	SysCalcTempA,SysCalcTempB
	breq	ENDIF8
;SIGNAL_DEPART = RED
	cbi	PORTD,2
;SIGNAL_PASS = RED
	cbi	PORTB,2
;LoopsRemaining = LoopsRemaining - 1
	lds	SysTemp1,LOOPSREMAINING
	dec	SysTemp1
	sts	LOOPSREMAINING,SysTemp1
;ShowNumber LoopsRemaining
	lds	SysValueCopy,LOOPSREMAINING
	sts	NUMOUT,SysValueCopy
	rcall	SHOWNUMBER
;If LoopsRemaining > 0 Then
	ldi	SysCalcTempA,0
	lds	SysCalcTempB,LOOPSREMAINING
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE20_1
;Set points for main line
;SIGNAL_PASS = GREEN
	sbi	PORTB,2
;SendPointsLNP LIGHT_GREEN + TRACK_STRAIGHT
	ldi	SysValueCopy,3
	sts	POINTCOMMAND,SysValueCopy
	rcall	SENDPOINTSLNP
;Else
	rjmp	ENDIF20
ELSE20_1:
;SIGNAL_PASS = RED
	cbi	PORTB,2
;Set points for loop
;SendPointsLNP LIGHT_FLASHING + TRACK_DIVERGE
	ldi	SysValueCopy,6
	sts	POINTCOMMAND,SysValueCopy
	rcall	SENDPOINTSLNP
;End If
ENDIF20:
;LastState = State
	lds	SysValueCopy,STATE
	sts	LASTSTATE,SysValueCopy
;End If
ENDIF8:
;If ReadAD(SECTION_3) < TRAIN_SENSOR_THRESHOLD Then
	ldi	SysValueCopy,3
	sts	ADREADPORT,SysValueCopy
	rcall	FN_READAD27
	lds	SysCalcTempA,SYSREADADBYTE
	cpi	SysCalcTempA,75
	brsh	ENDIF9
;State = 3
	ldi	SysValueCopy,3
	sts	STATE,SysValueCopy
;End If
ENDIF9:
;Else If State = 3 Then
	rjmp	ENDIF1
ELSE1_3:
	lds	SysCalcTempA,STATE
	cpi	SysCalcTempA,3
	brne	ELSE1_4
;LastState = 3
	ldi	SysValueCopy,3
	sts	LASTSTATE,SysValueCopy
;If ReadAD(SECTION_4) < TRAIN_SENSOR_THRESHOLD Then
	ldi	SysValueCopy,1
	sts	ADREADPORT,SysValueCopy
	rcall	FN_READAD27
	lds	SysCalcTempA,SYSREADADBYTE
	cpi	SysCalcTempA,75
	brsh	ENDIF10
;State = 4
	ldi	SysValueCopy,4
	sts	STATE,SysValueCopy
;End If
ENDIF10:
;Else If State = 4 Then
	rjmp	ENDIF1
ELSE1_4:
	lds	SysCalcTempA,STATE
	cpi	SysCalcTempA,4
	brne	ELSE1_5
;LastState = 4
	ldi	SysValueCopy,4
	sts	LASTSTATE,SysValueCopy
;If LoopsRemaining = 0 Then
	lds	SysCalcTempA,LOOPSREMAINING
	tst	SysCalcTempA
	brne	ELSE11_1
;State = 5
	ldi	SysValueCopy,5
	sts	STATE,SysValueCopy
;Else
	rjmp	ENDIF11
ELSE11_1:
;If ReadAD(SECTION_2) < TRAIN_SENSOR_THRESHOLD Then
	ldi	SysValueCopy,2
	sts	ADREADPORT,SysValueCopy
	rcall	FN_READAD27
	lds	SysCalcTempA,SYSREADADBYTE
	cpi	SysCalcTempA,75
	brsh	ENDIF21
;State = 2
	ldi	SysValueCopy,2
	sts	STATE,SysValueCopy
;End If
ENDIF21:
;End If
ENDIF11:
;Else If State = 5 Then
	rjmp	ENDIF1
ELSE1_5:
	lds	SysCalcTempA,STATE
	cpi	SysCalcTempA,5
	brne	ENDIF1
;If State <> LastState Then
	lds	SysCalcTempA,STATE
	lds	SysCalcTempB,LASTSTATE
	cp	SysCalcTempA,SysCalcTempB
	breq	ENDIF12
;PFSendSingleOutputPWM 4, 1, SLOW_SPEED
	ldi	SysValueCopy,4
	sts	PFCHANNEL,SysValueCopy
	ldi	SysValueCopy,1
	sts	PFOUTPUT,SysValueCopy
	ldi	SysValueCopy,13
	sts	PFDATA,SysValueCopy
	rcall	PFSENDSINGLEOUTPUTPWM
;LastState = State
	lds	SysValueCopy,STATE
	sts	LASTSTATE,SysValueCopy
;Try delay before LNP, see if that fixes gate not opening issue 2024-04-20
;Wait 50 ms
	ldi	SysWaitTempMS,50
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Open Emerson Crossing
;EmersonCrossingOpen
	rcall	EMERSONCROSSINGOPEN
;End If
ENDIF12:
;If ReadAD(SECTION_1) < TRAIN_SENSOR_THRESHOLD Then
	ldi	SysValueCopy,0
	sts	ADREADPORT,SysValueCopy
	rcall	FN_READAD27
	lds	SysCalcTempA,SYSREADADBYTE
	cpi	SysCalcTempA,75
	brsh	ENDIF13
;State = 0
	ldi	SysValueCopy,0
	sts	STATE,SysValueCopy
;End If
ENDIF13:
;End If
ENDIF1:
;Loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
;''Counts button presses
;''@param Timeout Stop counting if there are no more presses after this many milliseconds. Default value is 1000.
;''Send a low level command to the Power Functions receiver
;''@param PFChannel Channel of receiver (1 to 4)
;''@param PFOutput Output to operate (0 or 1)
;''@param PFData Speed to send, 0 = float, 7 = full FWD, 8 = brake, 9 = full REV
;''Add to lap counter in EEPROM
;''@param ExtraLaps Number of laps to add
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (452)
CLEARLAPCOUNT:
;EPWrite 10, 0
	ldi	SysValueCopy,10
	out	EEADDRESS,SysValueCopy
	ldi	SysValueCopy,0
	out	EEADDRESS_H,SysValueCopy
	ldi	SysValueCopy,0
	out	EEDATAVALUE,SysValueCopy
	rcall	EPWRITE
;EPWrite 11, 0
	ldi	SysValueCopy,11
	out	EEADDRESS,SysValueCopy
	ldi	SysValueCopy,0
	out	EEADDRESS_H,SysValueCopy
	ldi	SysValueCopy,0
	out	EEDATAVALUE,SysValueCopy
	rjmp	EPWRITE

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (250)
FN_COUNTPRESSES:
;CountPresses = 0
	ldi	SysValueCopy,0
	sts	COUNTPRESSES,SysValueCopy
;TimeSincePress = 0
	ldi	SysValueCopy,0
	sts	TIMESINCEPRESS,SysValueCopy
	sts	TIMESINCEPRESS_H,SysValueCopy
;Do While TimeSincePress < Timeout
SysDoLoop_S2:
	lds	SysWORDTempA,timesincepress
	lds	SysWORDTempA_H,timesincepress_H
	lds	SysWORDTempB,timeout
	lds	SysWORDTempB_H,timeout_H
	rcall	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E2
;If Button = Pressed Then
	sbis	PIND,3
	rjmp	ENDIF24
;Wait 25 ms
	ldi	SysWaitTempMS,25
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Wait Until Button <> PRESSED
SysWaitLoop1:
	sbic	PIND,3
	rjmp	SysWaitLoop1
;Wait 25 ms
	ldi	SysWaitTempMS,25
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;If CountPresses < MAX_LAPS Then
	lds	SysCalcTempA,COUNTPRESSES
	cpi	SysCalcTempA,3
	brsh	ENDIF25
;CountPresses = CountPresses + 1
	lds	SysTemp1,COUNTPRESSES
	inc	SysTemp1
	sts	COUNTPRESSES,SysTemp1
;End If
ENDIF25:
;ShowNumber CountPresses
	lds	SysValueCopy,COUNTPRESSES
	sts	NUMOUT,SysValueCopy
	rcall	SHOWNUMBER
;TimeSincePress = 0
	ldi	SysValueCopy,0
	sts	TIMESINCEPRESS,SysValueCopy
	sts	TIMESINCEPRESS_H,SysValueCopy
;End If
ENDIF24:
;Wait 1 ms
	ldi	SysWaitTempMS,1
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;TimeSincePress = TimeSincePress + 1
	lds	SysTemp1,TIMESINCEPRESS
	inc	SysTemp1
	sts	TIMESINCEPRESS,SysTemp1
	lds	SysTemp1,TIMESINCEPRESS_H
	brne	PC + 2
	inc	SysTemp1
	sts	TIMESINCEPRESS_H,SysTemp1
;Loop
	rjmp	SysDoLoop_S2
SysDoLoop_E2:
	ret

;********************************************************************************

Delay_10US:
D10US_START:
	ldi	DELAYTEMP,52
DelayUS1:
	dec	DELAYTEMP
	brne	DelayUS1
	nop
	dec	SysWaitTemp10US
	brne	D10US_START
	ret

;********************************************************************************

Delay_MS:
	inc	SysWaitTempMS_H
DMS_START:
	ldi	DELAYTEMP2,254
DMS_OUTER:
	ldi	DELAYTEMP,20
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

;Source: Lego train with points serial crossing v3.gcb (403)
EMERSONCROSSINGCLOSE:
;SendLNPPair 1, 1
	ldi	SysValueCopy,1
	sts	ADDRESSOUT,SysValueCopy
	ldi	SysValueCopy,1
	sts	DATAOUT,SysValueCopy
	rjmp	SENDLNPPAIR

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (407)
EMERSONCROSSINGOPEN:
;SendLNPPair 1, 0
	ldi	SysValueCopy,1
	sts	ADDRESSOUT,SysValueCopy
	ldi	SysValueCopy,0
	sts	DATAOUT,SysValueCopy
	rjmp	SENDLNPPAIR

;********************************************************************************

;Source: eeprom.h (91)
EPWRITE:
;Variable alias
;Dim EEAddress As Word Alias EEARH, EEARL
;Dim EEDataValue Alias EEDR
;Enable write
;Set EEMPE On
	sbi	EECR,EEMPE
;Start write, wait for it to complete
;Set EEPE On
	sbi	EECR,EEPE
;Wait Until EEPE Off
SysWaitLoop3:
	sbic	EECR,EEPE
	rjmp	SysWaitLoop3
	ret

;********************************************************************************

;Overloaded signature: , Source: usart.h (2606)
FN_HSERRECEIVE367:
;HSerReceive( SerData )
	rcall	HSERRECEIVE372
;HSerReceive = SerData
	lds	SysValueCopy,SERDATA
	sts	HSERRECEIVE,SysValueCopy
	ret

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (2639)
HSERRECEIVE372:
;AVR USART 1 receive
;if comport = 1 Then
	lds	SysCalcTempA,COMPORT
	cpi	SysCalcTempA,1
	brne	ENDIF56
;SerData = DEFAULTUSARTRETURNVALUE
	ldi	SysValueCopy,255
	sts	SERDATA,SysValueCopy
;If set up to block, wait for data
;Wait Until USARTHasData
SysWaitLoop4:
	lds	SysBitTest,UCSR0A
	sbrs	SysBitTest,RXC0
	rjmp	SysWaitLoop4
;If USARTHasData Then
	lds	SysBitTest,UCSR0A
	sbrs	SysBitTest,RXC0
	rjmp	ENDIF57
;SerData = UDR0
	lds	SysValueCopy,UDR0
	sts	SERDATA,SysValueCopy
;End If
ENDIF57:
;End If
ENDIF56:
	ret

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (441)
INCREMENTLAPCOUNT:
;EPRead 10, LapCounter
	ldi	SysValueCopy,10
	out	EEADDRESS,SysValueCopy
	ldi	SysValueCopy,0
	out	EEADDRESS_H,SysValueCopy
	rcall	SYSEPREAD
	in	SysValueCopy,EEDATAVALUE
	sts	LAPCOUNTER,SysValueCopy
	ldi	SysValueCopy,0
	sts	LAPCOUNTER_H,SysValueCopy
;EPRead 11, LapCounter_H
	ldi	SysValueCopy,11
	out	EEADDRESS,SysValueCopy
	ldi	SysValueCopy,0
	out	EEADDRESS_H,SysValueCopy
	rcall	SYSEPREAD
	in	SysValueCopy,EEDATAVALUE
	sts	LAPCOUNTER_H,SysValueCopy
;OldHighLaps = LapCounter_H
	sts	OLDHIGHLAPS,SysValueCopy
;LapCounter = LapCounter + ExtraLaps
	lds	SysTemp1,LAPCOUNTER
	lds	SysTemp2,EXTRALAPS
	add	SysTemp1,SysTemp2
	sts	LAPCOUNTER,SysTemp1
	lds	SysTemp1,LAPCOUNTER_H
	ldi	SysTemp2,0
	adc	SysTemp1,SysTemp2
	sts	LAPCOUNTER_H,SysTemp1
;EPWrite 10, LapCounter
	ldi	SysValueCopy,10
	out	EEADDRESS,SysValueCopy
	ldi	SysValueCopy,0
	out	EEADDRESS_H,SysValueCopy
	lds	SysValueCopy,LAPCOUNTER
	out	EEDATAVALUE,SysValueCopy
	rcall	EPWRITE
;If OldHighLaps <> LapCounter_H Then
	lds	SysCalcTempA,OLDHIGHLAPS
	lds	SysCalcTempB,LAPCOUNTER_H
	cp	SysCalcTempA,SysCalcTempB
	breq	ENDIF37
;EPWrite 11, LapCounter_H
	ldi	SysValueCopy,11
	out	EEADDRESS,SysValueCopy
	ldi	SysValueCopy,0
	out	EEADDRESS_H,SysValueCopy
	lds	SysValueCopy,LAPCOUNTER_H
	out	EEDATAVALUE,SysValueCopy
	rcall	EPWRITE
;End If
ENDIF37:
	ret

;********************************************************************************

;Source: random.h (35)
INITRANDOM:
;Dim RandomSeed As Word
;RandomSeed = RandStart
	ldi	SysValueCopy,160
	sts	RANDOMSEED,SysValueCopy
	ldi	SysValueCopy,225
	sts	RANDOMSEED_H,SysValueCopy
	ret

;********************************************************************************

;Source: system.h (198)
INITSYS:
;Turn off all ports
;PORTB = 0
	ldi	SysValueCopy,0
	out	PORTB,SysValueCopy
;PORTC = 0
	ldi	SysValueCopy,0
	out	PORTC,SysValueCopy
;PORTD = 0
	ldi	SysValueCopy,0
	out	PORTD,SysValueCopy
	ret

;********************************************************************************

;Source: uno_mega328p.h (66)
INITUNO:
;Set UART pin directions
;Dir PORTD.0 In
	cbi	DDRD,0
;Dir PORTD.1 Out
	sbi	DDRD,1
	ret

;********************************************************************************

;Source: usart.h (1242)
INITUSART:
;Set baud rate
;U2X0 = U2X0_TEMP        'Set/Clear bit to double USART transmission speed
	lds	SysValueCopy,UCSR0A
	sbr	SysValueCopy,1<<U2X0
	sts	UCSR0A,SysValueCopy
;UBRR0L = UBRRL_TEMP
	ldi	SysValueCopy,103
	sts	UBRR0L,SysValueCopy
;UBRR0H = UBRRH_TEMP
	ldi	SysValueCopy,0
	sts	UBRR0H,SysValueCopy
;Enable TX and RX
;RXEN0 = On
	lds	SysValueCopy,UCSR0B
	sbr	SysValueCopy,1<<RXEN0
	sts	UCSR0B,SysValueCopy
;TXEN0 = On
	sbr	SysValueCopy,1<<TXEN0
	sts	UCSR0B,SysValueCopy
	ret

;********************************************************************************

IntUSART_RX:
	rcall	SysIntContextSave
	rcall	LNPSERININT
	lds	SysValueCopy,UCSR0A
	cbr	SysValueCopy,1<<RXC0
	sts	UCSR0A,SysValueCopy
	rjmp	SysIntContextRestore

;********************************************************************************

;Source: lnp_rxpin.h (23)
LNPINITIALISE:
;LNPState = LNP_STATE_WAITING
	ldi	SysValueCopy,0
	sts	LNPSTATE,SysValueCopy
;LNPInBytes = 0
	ldi	SysValueCopy,0
	sts	LNPINBYTES,SysValueCopy
;Odd parity
;Set UPM00 On
	lds	SysValueCopy,UCSR0C
	sbr	SysValueCopy,1<<UPM00
	sts	UCSR0C,SysValueCopy
;Set UPM01 On
	sbr	SysValueCopy,1<<UPM01
	sts	UCSR0C,SysValueCopy
;On Interrupt UsartRX1Ready Call LNPSerInInt
	lds	SysValueCopy,UCSR0B
	sbr	SysValueCopy,1<<RXCIE0
	sts	UCSR0B,SysValueCopy
	ret

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (385)
LNPRECEIVED:
;Process received LNP message
;Gate sends back pair of 2, status
;Status values: 4 = grey stopped, 2 = blue stopped
;status 7 means all stopped, gates closed ready for train
;If LNPInBytes = 2 and LNPState = LNP_STATE_WAITING Then
	lds	SysBYTETempA,LNPINBYTES
	ldi	SysBYTETempB,2
	rcall	SYSCOMPEQUAL
	mov	SysTemp1,SysByteTempX
	lds	SysBYTETempA,LNPSTATE
	ldi	SysBYTETempB,0
	rcall	SYSCOMPEQUAL
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	sbrs	SysTemp3,0
	rjmp	ENDIF58
;If LNPInBuffer(1) = 2 Then
	lds	SysCalcTempA,SYSLNPINBUFFER_1
	cpi	SysCalcTempA,2
	brne	ELSE59_1
;EmersonCrossingState = LNPInBuffer(2)
	lds	SysValueCopy,SYSLNPINBUFFER_2
	sts	EMERSONCROSSINGSTATE,SysValueCopy
;Else If LNPInBuffer(1) = 4 Then
	rjmp	ENDIF59
ELSE59_1:
	lds	SysCalcTempA,SYSLNPINBUFFER_1
	cpi	SysCalcTempA,4
	brne	ELSE59_2
;PointsState = LNPInBuffer(2)
	lds	SysValueCopy,SYSLNPINBUFFER_2
	sts	POINTSSTATE,SysValueCopy
;Else If LNPInBuffer(1) = 6 Then
	rjmp	ENDIF59
ELSE59_2:
	lds	SysCalcTempA,SYSLNPINBUFFER_1
	cpi	SysCalcTempA,6
	brne	ELSE59_3
;LapCountRequest = LNPInBuffer(2)
	lds	SysValueCopy,SYSLNPINBUFFER_2
	sts	LAPCOUNTREQUEST,SysValueCopy
;Else If LNPInBuffer(1) = 241 Then
	rjmp	ENDIF59
ELSE59_3:
	lds	SysCalcTempA,SYSLNPINBUFFER_1
	cpi	SysCalcTempA,241
	brne	ENDIF59
;ClearLapCount
	rcall	CLEARLAPCOUNT
;End If
ENDIF59:
;End If
ENDIF58:
	ret

;********************************************************************************

;Source: lnp_rxpin.h (34)
LNPSERININT:
;Check parity bit
;If UPE0 Then
	lds	SysBitTest,UCSR0A
	sbrs	SysBitTest,UPE0
	rjmp	ENDIF47
;Parity error occurred, packet will be invalid
;LNPState = LNP_STATE_WAITING
	ldi	SysValueCopy,0
	sts	LNPSTATE,SysValueCopy
;LNPInBytes = 0
	ldi	SysValueCopy,0
	sts	LNPINBYTES,SysValueCopy
;End If
ENDIF47:
;Read byte
;InByte = HSerReceive
	rcall	FN_HSERRECEIVE367
	lds	SysValueCopy,SYSHSERRECEIVEBYTE
	sts	INBYTE,SysValueCopy
;Waiting state (default on startup)
;If 0xF0 received, expect byte count next
;If LNPState = LNP_STATE_WAITING Then
	lds	SysCalcTempA,LNPSTATE
	tst	SysCalcTempA
	brne	ELSE48_1
;If InByte = 0xF0 Then
	lds	SysCalcTempA,INBYTE
	cpi	SysCalcTempA,240
	brne	ENDIF49
;LNPChecksum = InByte - 1
	lds	SysTemp1,INBYTE
	dec	SysTemp1
	sts	LNPCHECKSUM,SysTemp1
;LNPByteCount = 0
	ldi	SysValueCopy,0
	sts	LNPBYTECOUNT,SysValueCopy
;LNPState = LNP_STATE_COUNT
	ldi	SysValueCopy,1
	sts	LNPSTATE,SysValueCopy
;End If
ENDIF49:
;Waiting for byte count, read and start expecting data
;Else If LNPState = LNP_STATE_COUNT Then
	rjmp	ENDIF48
ELSE48_1:
	lds	SysCalcTempA,LNPSTATE
	cpi	SysCalcTempA,1
	brne	ELSE48_2
;LNPInBytes = InByte
	lds	SysValueCopy,INBYTE
	sts	LNPINBYTES,SysValueCopy
;LNPChecksum = LNPChecksum + InByte
	lds	SysTemp1,LNPCHECKSUM
	lds	SysTemp3,INBYTE
	add	SysTemp1,SysTemp3
	sts	LNPCHECKSUM,SysTemp1
;LNPState = LNP_STATE_DATA
	ldi	SysValueCopy,2
	sts	LNPSTATE,SysValueCopy
;Expecting data. Read until expected number of bytes read
;Else If LNPState = LNP_STATE_DATA Then
	rjmp	ENDIF48
ELSE48_2:
	lds	SysCalcTempA,LNPSTATE
	cpi	SysCalcTempA,2
	brne	ELSE48_3
;LNPByteCount = LNPByteCount + 1
	lds	SysTemp1,LNPBYTECOUNT
	inc	SysTemp1
	sts	LNPBYTECOUNT,SysTemp1
;If LNPByteCount <= LNP_BUFFER_SIZE Then
	ldi	SysCalcTempA,16
	lds	SysCalcTempB,LNPBYTECOUNT
	cp	SysCalcTempA,SysCalcTempB
	brlo	ENDIF50
;LNPInBuffer(LNPByteCount) = InByte
	lds	SysTemp1,LNPBYTECOUNT
	ldi	SysTemp3,low(LNPINBUFFER)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	ldi	SysTemp3,0
	ldi	SysTemp2,high(LNPINBUFFER)
	adc	SysTemp3,SysTemp2
	mov	SysStringA_H,SysTemp3
	lds	SysValueCopy,INBYTE
	st	X,SysValueCopy
;End If
ENDIF50:
;LNPChecksum = LNPChecksum + InByte
	lds	SysTemp1,LNPCHECKSUM
	lds	SysTemp3,INBYTE
	add	SysTemp1,SysTemp3
	sts	LNPCHECKSUM,SysTemp1
;If LNPByteCount >= LNPInBytes Then
	lds	SysCalcTempA,LNPBYTECOUNT
	lds	SysCalcTempB,LNPINBYTES
	cp	SysCalcTempA,SysCalcTempB
	brlo	ENDIF51
;LNPState = LNP_STATE_CHECKSUM
	ldi	SysValueCopy,3
	sts	LNPSTATE,SysValueCopy
;End If
ENDIF51:
;All bytes read, expecting checksum
;Else If LNPState = LNP_STATE_CHECKSUM Then
	rjmp	ENDIF48
ELSE48_3:
	lds	SysCalcTempA,LNPSTATE
	cpi	SysCalcTempA,3
	brne	ENDIF48
;LNPInChecksum = InByte
	lds	SysValueCopy,INBYTE
	sts	LNPINCHECKSUM,SysValueCopy
;If received checksum incorrect, throw away data and return to waiting
;If LNPInChecksum <> LNPChecksum Then
	lds	SysCalcTempA,LNPINCHECKSUM
	lds	SysCalcTempB,LNPCHECKSUM
	cp	SysCalcTempA,SysCalcTempB
	breq	ELSE52_1
;LNPInBytes = 0
	ldi	SysValueCopy,0
	sts	LNPINBYTES,SysValueCopy
;LNPState = LNP_STATE_WAITING
	ldi	SysValueCopy,0
	sts	LNPSTATE,SysValueCopy
;If received checksum correct, return to waiting and run callback (if present)
;Else
	rjmp	ENDIF52
ELSE52_1:
;LNPState = LNP_STATE_WAITING
	ldi	SysValueCopy,0
	sts	LNPSTATE,SysValueCopy
;LNP_REC_HANDLER
	rcall	LNPRECEIVED
;End If
ENDIF52:
;End If
ENDIF48:
	ret

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (273)
PFSENDSINGLEOUTPUTPWM:
;Format output data
;Clear all bits that aren't set yet
;PFOutData = 0
	ldi	SysValueCopy,0
	sts	PFOUTDATA,SysValueCopy
	sts	PFOUTDATA_H,SysValueCopy
;Channel bits (2 bits, 1-4)
;PFChannel = PFChannel - 1
	lds	SysTemp1,PFCHANNEL
	dec	SysTemp1
	sts	PFCHANNEL,SysTemp1
;If PFChannel.1 = 1 then
	lds	SysBitTest,PFCHANNEL
	sbrs	SysBitTest,1
	rjmp	ENDIF26
;PFOutData.13 = 1
	lds	SysValueCopy,PFOUTDATA_H
	sbr	SysValueCopy,1<<5
	sts	PFOUTDATA_H,SysValueCopy
;end if
ENDIF26:
;If PFChannel.0 = 1 then
	lds	SysBitTest,PFCHANNEL
	sbrs	SysBitTest,0
	rjmp	ENDIF27
;PFOutData.12 = 1
	lds	SysValueCopy,PFOUTDATA_H
	sbr	SysValueCopy,1<<4
	sts	PFOUTDATA_H,SysValueCopy
;end if
ENDIF27:
;PFOutData.10 = 1
	lds	SysValueCopy,PFOUTDATA_H
	sbr	SysValueCopy,1<<2
	sts	PFOUTDATA_H,SysValueCopy
;Mode PWM selected by default (clear bit 9)
;Select output
;If PFOutput <> 0 Then
	lds	SysCalcTempA,PFOUTPUT
	tst	SysCalcTempA
	breq	ENDIF28
;PFOutData.8 = 1
	lds	SysValueCopy,PFOUTDATA_H
	sbr	SysValueCopy,1<<0
	sts	PFOUTDATA_H,SysValueCopy
;End If
ENDIF28:
;Data bits (4 bits)
;If PFData.3 = 1 then
	lds	SysBitTest,PFDATA
	sbrs	SysBitTest,3
	rjmp	ENDIF29
;PFOutData.7 = 1
	lds	SysValueCopy,PFOUTDATA
	sbr	SysValueCopy,1<<7
	sts	PFOUTDATA,SysValueCopy
;end if
ENDIF29:
;If PFData.2 = 1 then
	lds	SysBitTest,PFDATA
	sbrs	SysBitTest,2
	rjmp	ENDIF30
;PFOutData.6 = 1
	lds	SysValueCopy,PFOUTDATA
	sbr	SysValueCopy,1<<6
	sts	PFOUTDATA,SysValueCopy
;end if
ENDIF30:
;If PFData.1 = 1 then
	lds	SysBitTest,PFDATA
	sbrs	SysBitTest,1
	rjmp	ENDIF31
;PFOutData.5 = 1
	lds	SysValueCopy,PFOUTDATA
	sbr	SysValueCopy,1<<5
	sts	PFOUTDATA,SysValueCopy
;end if
ENDIF31:
;If PFData.0 = 1 then
	lds	SysBitTest,PFDATA
	sbrs	SysBitTest,0
	rjmp	ENDIF32
;PFOutData.4 = 1
	lds	SysValueCopy,PFOUTDATA
	sbr	SysValueCopy,1<<4
	sts	PFOUTDATA,SysValueCopy
;end if
ENDIF32:
;Need to resend message at correct rate
;For PFResendNo = 1 to 5
;Legacy method
	ldi	SysValueCopy,0
	sts	PFRESENDNO,SysValueCopy
SysForLoop1:
	lds	SysTemp1,PFRESENDNO
	inc	SysTemp1
	sts	PFRESENDNO,SysTemp1
;Disable interrupts
;IntOff
	lds	SysValueCopy,SYSINTSTATESAVE0
	cbr	SysValueCopy,1<<0
	brbc	I,PC + 2
	sbr	SysValueCopy,1<<0
	sts	SYSINTSTATESAVE0,SysValueCopy
	cli
;Set Toggle bit
;PFToggle = PFToggle + 1
	lds	SysTemp1,PFTOGGLE
	inc	SysTemp1
	sts	PFTOGGLE,SysTemp1
;PFOutData.15 = PFToggle.0
	lds	SysValueCopy,PFOUTDATA_H
	cbr	SysValueCopy,1<<7
	lds	SysBitTest,PFTOGGLE
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<7
	sts	PFOUTDATA_H,SysValueCopy
;Calc Checksum bits (4 bits)
;PFChecksum = 0x0F XOR Swap4(PFOutData_H)
	lds	SWAP4IN,PFOUTDATA_H
	rcall	FN_SWAP4
	ldi	SysTemp2,15
	mov	SysTemp1,SWAP4
	eor	SysTemp1,SysTemp2
	sts	PFCHECKSUM,SysTemp1
;PFChecksum = PFChecksum XOR PFOutData_H
	lds	SysTemp2,PFOUTDATA_H
	eor	SysTemp2,SysTemp1
	sts	PFCHECKSUM,SysTemp2
;PFChecksum = PFChecksum XOR PFData
	lds	SysTemp1,PFCHECKSUM
	lds	SysTemp2,PFDATA
	eor	SysTemp2,SysTemp1
	sts	PFCHECKSUM,SysTemp2
;PFChecksum = PFChecksum And 0x0F
	ldi	SysTemp2,15
	lds	SysTemp1,PFCHECKSUM
	and	SysTemp1,SysTemp2
	sts	PFCHECKSUM,SysTemp1
;PFOutData = PFOutData And 0xFFF0
	ldi	SysTemp2,240
	lds	SysTemp1,PFOUTDATA
	and	SysTemp1,SysTemp2
	sts	PFOUTDATA,SysTemp1
;PFOutData = PFOutData Or PFChecksum
	lds	SysTemp2,PFCHECKSUM
	or	SysTemp2,SysTemp1
	sts	PFOUTDATA,SysTemp2
;Send command
;Start bit
;Repeat 6
	ldi	SysValueCopy,6
	sts	SysRepeatTemp3,SysValueCopy
SysRepeatLoop3:
;Set IR_OUT On
	sbi	PORTD,4
;Wait 13 us
	ldi	DELAYTEMP,69
DelayUS2:
	dec	DELAYTEMP
	brne	DelayUS2
	nop
;Set IR_OUT Off
	cbi	PORTD,4
;Wait 13 us
	ldi	DELAYTEMP,69
DelayUS3:
	dec	DELAYTEMP
	brne	DelayUS3
	nop
;End Repeat
	lds	SysTemp1,SysRepeatTemp3
	dec	SysTemp1
	sts	SysRepeatTemp3,SysTemp1
	brne	SysRepeatLoop3
SysRepeatLoopEnd3:
;Wait 1026 us
	ldi	DELAYTEMP2,21
DelayUSO4:
	ldi	DELAYTEMP,0
DelayUS4:
	dec	DELAYTEMP
	brne	DelayUS4
	dec	DELAYTEMP2
	brne	DelayUSO4
	ldi	DELAYTEMP,75
DelayUS5:
	dec	DELAYTEMP
	brne	DelayUS5
;Command
;PFSendBuffer = PFOutData
	lds	SysValueCopy,PFOUTDATA
	sts	PFSENDBUFFER,SysValueCopy
	lds	SysValueCopy,PFOUTDATA_H
	sts	PFSENDBUFFER_H,SysValueCopy
;Repeat 16
	ldi	SysValueCopy,16
	sts	SysRepeatTemp3,SysValueCopy
SysRepeatLoop4:
;HPWM 2, 38, 128
;Wait 158 us
;PWMOff 2
;Repeat 6
	ldi	SysValueCopy,6
	sts	SysRepeatTemp4,SysValueCopy
SysRepeatLoop5:
;Set IR_OUT On
	sbi	PORTD,4
;Wait 13 us
	ldi	DELAYTEMP,69
DelayUS6:
	dec	DELAYTEMP
	brne	DelayUS6
	nop
;Set IR_OUT Off
	cbi	PORTD,4
;Wait 13 us
	ldi	DELAYTEMP,69
DelayUS7:
	dec	DELAYTEMP
	brne	DelayUS7
	nop
;End Repeat
	lds	SysTemp1,SysRepeatTemp4
	dec	SysTemp1
	sts	SysRepeatTemp4,SysTemp1
	brne	SysRepeatLoop5
SysRepeatLoopEnd5:
;If PFSendBuffer.15 = 1 Then
	lds	SysBitTest,PFSENDBUFFER_H
	sbrs	SysBitTest,7
	rjmp	ELSE33_1
;Wait 552 us
	ldi	DELAYTEMP2,11
DelayUSO8:
	ldi	DELAYTEMP,0
DelayUS8:
	dec	DELAYTEMP
	brne	DelayUS8
	dec	DELAYTEMP2
	brne	DelayUSO8
	ldi	DELAYTEMP,117
DelayUS9:
	dec	DELAYTEMP
	brne	DelayUS9
;Else
	rjmp	ENDIF33
ELSE33_1:
;Wait 263 us
	ldi	DELAYTEMP2,5
DelayUSO10:
	ldi	DELAYTEMP,0
DelayUS10:
	dec	DELAYTEMP
	brne	DelayUS10
	dec	DELAYTEMP2
	brne	DelayUSO10
	ldi	DELAYTEMP,117
DelayUS11:
	dec	DELAYTEMP
	brne	DelayUS11
	rjmp	PC + 1
;End If
ENDIF33:
;Rotate PFSendBuffer Left
	lds	SysValueCopy,PFSENDBUFFER
	rol	SysValueCopy
	sts	PFSENDBUFFER,SysValueCopy
	lds	SysValueCopy,PFSENDBUFFER_H
	rol	SysValueCopy
	sts	PFSENDBUFFER_H,SysValueCopy
;End Repeat
	lds	SysTemp1,SysRepeatTemp3
	dec	SysTemp1
	sts	SysRepeatTemp3,SysTemp1
	brne	SysRepeatLoop4
SysRepeatLoopEnd4:
;Stop bit
;HPWM 2, 38, 128
;Wait 158 us
;PWMOff 2
;Repeat 6
	ldi	SysValueCopy,6
	sts	SysRepeatTemp3,SysValueCopy
SysRepeatLoop6:
;Set IR_OUT On
	sbi	PORTD,4
;Wait 13 us
	ldi	DELAYTEMP,69
DelayUS12:
	dec	DELAYTEMP
	brne	DelayUS12
	nop
;Set IR_OUT Off
	cbi	PORTD,4
;Wait 13 us
	ldi	DELAYTEMP,69
DelayUS13:
	dec	DELAYTEMP
	brne	DelayUS13
	nop
;End Repeat
	lds	SysTemp1,SysRepeatTemp3
	dec	SysTemp1
	sts	SysRepeatTemp3,SysTemp1
	brne	SysRepeatLoop6
SysRepeatLoopEnd6:
;Wait 1026 us
	ldi	DELAYTEMP2,21
DelayUSO14:
	ldi	DELAYTEMP,0
DelayUS14:
	dec	DELAYTEMP
	brne	DelayUS14
	dec	DELAYTEMP2
	brne	DelayUSO14
	ldi	DELAYTEMP,75
DelayUS15:
	dec	DELAYTEMP
	brne	DelayUS15
;Re-enable interrupts
;IntOn
	lds	SysBitTest,SYSINTSTATESAVE0
	sbrc	SysBitTest,0
	sei
;Calculate appropriate delay
;(Depends on channel and resend count)
;If PFResendNumber < 3 Then
	lds	SysCalcTempA,PFRESENDNUMBER
	cpi	SysCalcTempA,3
	brsh	ELSE34_1
;Wait 80 ms
	ldi	SysWaitTempMS,80
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Else
	rjmp	ENDIF34
ELSE34_1:
;PFChecksum = 8 + 2 * PFChannel
	lds	SysTemp2,PFCHANNEL
	lsl	SysTemp2
	ldi	SysTemp3,8
	add	SysTemp2,SysTemp3
	sts	PFCHECKSUM,SysTemp2
;Repeat PFChecksum
	lds	SysValueCopy,PFCHECKSUM
	sts	SysRepeatTemp3,SysValueCopy
	lds	SysCalcTempA,SYSREPEATTEMP3
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd7
SysRepeatLoop7:
;Wait 16 ms
	ldi	SysWaitTempMS,16
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;End Repeat
	lds	SysTemp1,SysRepeatTemp3
	dec	SysTemp1
	sts	SysRepeatTemp3,SysTemp1
	brne	SysRepeatLoop7
SysRepeatLoopEnd7:
;End If
ENDIF34:
;Next
	lds	SysCalcTempA,PFRESENDNO
	cpi	SysCalcTempA,5
	brsh	ENDIF35
	rjmp	SysForLoop1
ENDIF35:
SysForLoopEnd1:
	ret

;********************************************************************************

;Source: random.h (41)
FN_RANDOM:
;Repeat 7
	ldi	SysValueCopy,7
	sts	SysRepeatTemp10,SysValueCopy
SysRepeatLoop10:
;Dim RandomTemp As Word
;Dim RandomSeed As Word
;RandomTemp = RandomSeed
	lds	SysValueCopy,RANDOMSEED
	sts	RANDOMTEMP,SysValueCopy
	lds	SysValueCopy,RANDOMSEED_H
	sts	RANDOMTEMP_H,SysValueCopy
;Rotate RandomTemp Left Simple
	rol	SysValueCopy
	lds	SysValueCopy,RANDOMTEMP
	rol	SysValueCopy
	sts	RANDOMTEMP,SysValueCopy
	lds	SysValueCopy,RANDOMTEMP_H
	rol	SysValueCopy
	sts	RANDOMTEMP_H,SysValueCopy
;Taps at 16, 15, 13, 11, And with b'1101 0100 0000 0000' = D800
;Expanded below calculation to reduce complexity of calc
;RandomSeed = RandomTemp XOR (Not (RandomSeed And 1) + 1 And 0xB400)
	ldi	SysTemp2,1
	lds	SysTemp3,RANDOMSEED
	and	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	ldi	SysValueCopy,0
	mov	SysTemp1_H,SysValueCopy
	com	SysTemp1
	mov	SysTemp2,SysTemp1
	com	SysTemp1_H
	mov	SysTemp2_H,SysTemp1_H
	ldi	SysTemp3,1
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	ldi	SysTemp3,0
	adc	SysTemp2_H,SysTemp3
	mov	SysTemp1_H,SysTemp2_H
	ldi	SysTemp2,0
	ldi	SysTemp3,180
	and	SysTemp1_H,SysTemp3
	mov	SysTemp2_H,SysTemp1_H
	lds	SysTemp1,RANDOMTEMP
	eor	SysTemp2,SysTemp1
	sts	RANDOMSEED,SysTemp2
	lds	SysTemp1,RANDOMTEMP_H
	eor	SysTemp2_H,SysTemp1
	sts	RANDOMSEED_H,SysTemp2_H
;Expanded below calculation to reduce complexity of calc
;RandomSeed = Not (RandomSeed And 1) + 1
;RandomSeed = RandomSeed And 0xB400
;RandomSeed = RandomTemp XOR RandomSeed
;Random = Random Xor RandomSeed_H
	lds	SysTemp1,RANDOM
	lds	SysTemp3,RANDOMSEED_H
	eor	SysTemp3,SysTemp1
	sts	RANDOM,SysTemp3
;End Repeat
	lds	SysTemp1,SysRepeatTemp10
	dec	SysTemp1
	sts	SysRepeatTemp10,SysTemp1
	breq	PC + 2
	rjmp	SysRepeatLoop10
SysRepeatLoopEnd10:
	ret

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2159)
FN_READAD27:
;ADFM should configured to ensure LEFT justified
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (635)
;Select channel by setting ADMUX
;ADMUX = ADReadPort
	lds	SysValueCopy,ADREADPORT
	sts	ADMUX,SysValueCopy
;ADLAR = ADLeftAdjust
	sbr	SysValueCopy,1<<ADLAR
	sts	ADMUX,SysValueCopy
;Select reference source for chips that DO NOT HAVE Bit(REFS2)
;If AD_REF_SOURCE = AD_REF_AVCC Then
;'Bit(REFS1) does exist, so assume 'VCC used as analog reference' REFS0=b'1'
;[canskip]REFS0=b'1'
	sbr	SysValueCopy,1<<REFS0
	sts	ADMUX,SysValueCopy
;end If
;Set conversion clock to LowSpeed
;SET ADPS2 On
	lds	SysValueCopy,ADCSRA
	sbr	SysValueCopy,1<<ADPS2
	sts	ADCSRA,SysValueCopy
;SET ADPS1 On
	sbr	SysValueCopy,1<<ADPS1
	sts	ADCSRA,SysValueCopy
;SET ADPS0 On
	sbr	SysValueCopy,1<<ADPS0
	sts	ADCSRA,SysValueCopy
;Wait AD_Delay   'Execute the acquisition Delay
	ldi	SysWaitTemp10US,2
	rcall	Delay_10US
;Set ADEN On     'Take reading
	lds	SysValueCopy,ADCSRA
	sbr	SysValueCopy,1<<ADEN
	sts	ADCSRA,SysValueCopy
;Set ADSC On
	sbr	SysValueCopy,1<<ADSC
	sts	ADCSRA,SysValueCopy
;Wait While ADSC On
SysWaitLoop2:
	lds	SysBitTest,ADCSRA
	sbrc	SysBitTest,ADSC
	rjmp	SysWaitLoop2
;Set ADEN Off
	lds	SysValueCopy,ADCSRA
	cbr	SysValueCopy,1<<ADEN
	sts	ADCSRA,SysValueCopy
;ReadAD = ADCH
	lds	SysValueCopy,ADCH
	sts	READAD,SysValueCopy
	ret

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (457)
SENDLAPCOUNT:
;EPRead 10, LapCounter
	ldi	SysValueCopy,10
	out	EEADDRESS,SysValueCopy
	ldi	SysValueCopy,0
	out	EEADDRESS_H,SysValueCopy
	rcall	SYSEPREAD
	in	SysValueCopy,EEDATAVALUE
	sts	LAPCOUNTER,SysValueCopy
	ldi	SysValueCopy,0
	sts	LAPCOUNTER_H,SysValueCopy
;EPRead 11, LapCounter_H
	ldi	SysValueCopy,11
	out	EEADDRESS,SysValueCopy
	ldi	SysValueCopy,0
	out	EEADDRESS_H,SysValueCopy
	rcall	SYSEPREAD
	in	SysValueCopy,EEDATAVALUE
	sts	LAPCOUNTER_H,SysValueCopy
;SendLNPPairWord 240, LapCounter
	ldi	SysValueCopy,240
	sts	ADDRESSOUT,SysValueCopy
	lds	SysValueCopy,LAPCOUNTER
	sts	DATAOUT,SysValueCopy
	lds	SysValueCopy,LAPCOUNTER_H
	sts	DATAOUT_H,SysValueCopy
	rjmp	SENDLNPPAIRWORD

;********************************************************************************

;Source: lnp_rxpin.h (147)
SENDLNPPAIR:
;A pair takes about 3 ms, so make delay a multiple of that
;LNPSendDelay = AddressOut Mod 7 + 1
	lds	SysBYTETempA,ADDRESSOUT
	ldi	SysBYTETempB,7
	rcall	SYSDIVSUB
	inc	SysBYTETempX
	sts	LNPSENDDELAY,SysBYTETempX
;LNPSendDelay = LNPSendDelay * 3
	lds	SysBYTETempA,LNPSENDDELAY
	ldi	SysBYTETempB,3
	mul	SysByteTempA,SysByteTempB
	sts	LNPSENDDELAY,SysByteTempX
;LNPSuccessfulSendCount = 0
	ldi	SysValueCopy,0
	sts	LNPSUCCESSFULSENDCOUNT,SysValueCopy
;LNPSendTryCount = 0
	ldi	SysValueCopy,0
	sts	LNPSENDTRYCOUNT,SysValueCopy
;Do
SysDoLoop_S3:
;If bus busy, wait up to 20 ms for it to become free
;LNPSendRetryCount = 100
	ldi	SysValueCopy,100
	sts	LNPSENDRETRYCOUNT,SysValueCopy
;Do While LNPState <> LNP_STATE_WAITING
SysDoLoop_S4:
	lds	SysCalcTempA,LNPSTATE
	tst	SysCalcTempA
	breq	SysDoLoop_E4
;LNPSendRetryCount -= 1
	lds	SysTemp1,LNPSENDRETRYCOUNT
	dec	SysTemp1
	sts	LNPSENDRETRYCOUNT,SysTemp1
;Wait 200 us
	ldi	DELAYTEMP2,4
DelayUSO16:
	ldi	DELAYTEMP,0
DelayUS16:
	dec	DELAYTEMP
	brne	DelayUS16
	dec	DELAYTEMP2
	brne	DelayUSO16
	ldi	DELAYTEMP,38
DelayUS17:
	dec	DELAYTEMP
	brne	DelayUS17
	rjmp	PC + 1
;If LNPSendRetryCount = 0 Then
	lds	SysCalcTempA,LNPSENDRETRYCOUNT
	tst	SysCalcTempA
	brne	ENDIF38
;LNPState = LNP_STATE_WAITING
	ldi	SysValueCopy,0
	sts	LNPSTATE,SysValueCopy
;Exit Do
	rjmp	SysDoLoop_E4
;End If
ENDIF38:
;Loop
	rjmp	SysDoLoop_S4
SysDoLoop_E4:
;LNPWriteConflict = FALSE
	ldi	SysValueCopy,0
	sts	LNPWRITECONFLICT,SysValueCopy
;SendOnRec 0xF0
	ldi	SysValueCopy,240
	sts	LNPOUTBYTE,SysValueCopy
	rcall	SENDONREC
;If LNPWriteConflict = FALSE Then
	lds	SysCalcTempA,LNPWRITECONFLICT
	tst	SysCalcTempA
	brne	ENDIF39
;SendOnRec 2
	ldi	SysValueCopy,2
	sts	LNPOUTBYTE,SysValueCopy
	rcall	SENDONREC
;If LNPWriteConflict = FALSE Then
	lds	SysCalcTempA,LNPWRITECONFLICT
	tst	SysCalcTempA
	brne	ENDIF42
;SendOnRec AddressOut
	lds	SysValueCopy,ADDRESSOUT
	sts	LNPOUTBYTE,SysValueCopy
	rcall	SENDONREC
;If LNPWriteConflict = FALSE Then
	lds	SysCalcTempA,LNPWRITECONFLICT
	tst	SysCalcTempA
	brne	ENDIF43
;SendOnRec DataOut
	lds	SysValueCopy,DATAOUT
	sts	LNPOUTBYTE,SysValueCopy
	rcall	SENDONREC
;If LNPWriteConflict = FALSE Then
	lds	SysCalcTempA,LNPWRITECONFLICT
	tst	SysCalcTempA
	brne	ENDIF44
;SendOnRec 0xF1 + AddressOut + DataOut
	lds	SysTemp2,ADDRESSOUT
	ldi	SysTemp3,241
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,DATAOUT
	add	SysTemp1,SysTemp2
	sts	LNPOUTBYTE,SysTemp1
	rcall	SENDONREC
;End If
ENDIF44:
;End If
ENDIF43:
;End If
ENDIF42:
;End If
ENDIF39:
;If LNPWriteConflict Then
	lds	SysTemp1,LNPWRITECONFLICT
	tst	SysTemp1
	breq	ELSE40_1
;SendOnRec 0x55
	ldi	SysValueCopy,85
	sts	LNPOUTBYTE,SysValueCopy
	rcall	SENDONREC
;Wait Random And 63 10us
	rcall	FN_RANDOM
	ldi	SysTemp2,63
	lds	SysTemp1,RANDOM
	and	SysTemp1,SysTemp2
	mov	SysWaitTemp10US,SysTemp1
	rcall	Delay_10US
;Else
	rjmp	ENDIF40
ELSE40_1:
;LNPSuccessfulSendCount += 1
	lds	SysTemp1,LNPSUCCESSFULSENDCOUNT
	inc	SysTemp1
	sts	LNPSUCCESSFULSENDCOUNT,SysTemp1
;End If
ENDIF40:
;LNPSendTryCount += 1
	lds	SysTemp1,LNPSENDTRYCOUNT
	inc	SysTemp1
	sts	LNPSENDTRYCOUNT,SysTemp1
;If LNPSendTryCount > 100 Then
	ldi	SysCalcTempA,100
	lds	SysCalcTempB,LNPSENDTRYCOUNT
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF41
;Exit Sub
	ret
;End If
ENDIF41:
;Wait LNPSendDelay ms
	lds	SysWaitTempMS,LNPSENDDELAY
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Loop While LNPSuccessfulSendCount < 2
	lds	SysCalcTempA,LNPSUCCESSFULSENDCOUNT
	cpi	SysCalcTempA,2
	brsh	PC + 2
	rjmp	SysDoLoop_S3
SysDoLoop_E3:
	ret

;********************************************************************************

;Source: lnp_rxpin.h (192)
SENDLNPPAIRWORD:
;LNPSendDelay = AddressOut Mod 4 + 10
	lds	SysBYTETempA,ADDRESSOUT
	ldi	SysBYTETempB,4
	rcall	SYSDIVSUB
	mov	SysTemp1,SysBYTETempX
	ldi	SysTemp2,10
	add	SysTemp1,SysTemp2
	sts	LNPSENDDELAY,SysTemp1
;Repeat 3
	ldi	SysValueCopy,3
	sts	SysRepeatTemp9,SysValueCopy
SysRepeatLoop9:
;LNPSendRetryCount = 100
	ldi	SysValueCopy,100
	sts	LNPSENDRETRYCOUNT,SysValueCopy
;Do While LNPState <> LNP_STATE_WAITING
SysDoLoop_S5:
	lds	SysCalcTempA,LNPSTATE
	tst	SysCalcTempA
	breq	SysDoLoop_E5
;LNPSendRetryCount -= 1
	lds	SysTemp1,LNPSENDRETRYCOUNT
	dec	SysTemp1
	sts	LNPSENDRETRYCOUNT,SysTemp1
;Wait 1 ms
	ldi	SysWaitTempMS,1
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;If LNPSendRetryCount = 0 Then Exit Do
	lds	SysCalcTempA,LNPSENDRETRYCOUNT
	tst	SysCalcTempA
	brne	ENDIF45
;If LNPSendRetryCount = 0 Then Exit Do
	rjmp	SysDoLoop_E5
;If LNPSendRetryCount = 0 Then Exit Do
ENDIF45:
;Loop
	rjmp	SysDoLoop_S5
SysDoLoop_E5:
;SendOnRec 0xF0
	ldi	SysValueCopy,240
	sts	LNPOUTBYTE,SysValueCopy
	rcall	SENDONREC
;SendOnRec 3
	ldi	SysValueCopy,3
	sts	LNPOUTBYTE,SysValueCopy
	rcall	SENDONREC
;SendOnRec AddressOut
	lds	SysValueCopy,ADDRESSOUT
	sts	LNPOUTBYTE,SysValueCopy
	rcall	SENDONREC
;SendOnRec DataOut_H
	lds	SysValueCopy,DATAOUT_H
	sts	LNPOUTBYTE,SysValueCopy
	rcall	SENDONREC
;SendOnRec DataOut
	lds	SysValueCopy,DATAOUT
	sts	LNPOUTBYTE,SysValueCopy
	rcall	SENDONREC
;SendOnRec 0xF2 + AddressOut + [byte]DataOut + DataOut_H
	lds	SysTemp2,ADDRESSOUT
	ldi	SysTemp3,242
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp3,DATAOUT
	add	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	lds	SysTemp1,DATAOUT_H
	add	SysTemp2,SysTemp1
	sts	LNPOUTBYTE,SysTemp2
	rcall	SENDONREC
;Wait LNPSendDelay ms
	lds	SysWaitTempMS,LNPSENDDELAY
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;End Repeat
	lds	SysTemp1,SysRepeatTemp9
	dec	SysTemp1
	sts	SysRepeatTemp9,SysTemp1
	breq	PC + 2
	rjmp	SysRepeatLoop9
SysRepeatLoopEnd9:
	ret

;********************************************************************************

;Source: lnp_rxpin.h (94)
SENDONREC:
;Parity state
;LNPOneCount = 0
	ldi	SysValueCopy,0
	sts	LNPONECOUNT,SysValueCopy
;Start bit
;IntOff
	lds	SysValueCopy,SYSINTSTATESAVE0
	cbr	SysValueCopy,1<<1
	brbc	I,PC + 2
	sbr	SysValueCopy,1<<1
	sts	SYSINTSTATESAVE0,SysValueCopy
	cli
;Set RXEN0 Off
	lds	SysValueCopy,UCSR0B
	cbr	SysValueCopy,1<<RXEN0
	sts	UCSR0B,SysValueCopy
;Dir LNP_RX_PIN Out
	sbi	DDRD,0
;Set LNP_RX_PIN Off
	cbi	PORTD,0
;Wait 52 us
	ldi	DELAYTEMP2,1
DelayUSO18:
	ldi	DELAYTEMP,0
DelayUS18:
	dec	DELAYTEMP
	brne	DelayUS18
	dec	DELAYTEMP2
	brne	DelayUSO18
	ldi	DELAYTEMP,20
DelayUS19:
	dec	DELAYTEMP
	brne	DelayUS19
	nop
;Send 8 data bits
;Repeat 8
	ldi	SysValueCopy,8
	sts	SysRepeatTemp11,SysValueCopy
SysRepeatLoop11:
;If LNPOutByte.0 Then
	lds	SysBitTest,LNPOUTBYTE
	sbrs	SysBitTest,0
	rjmp	ELSE53_1
;Dir LNP_RX_PIN In
	cbi	DDRD,0
;Check for conflict
;Wait 26 us
	ldi	DELAYTEMP,138
DelayUS20:
	dec	DELAYTEMP
	brne	DelayUS20
	rjmp	PC + 1
;If LNP_RX_PIN = 0 Then
	sbic	PIND,0
	rjmp	ENDIF55
;LNPWriteConflict = TRUE
	ldi	SysValueCopy,255
	sts	LNPWRITECONFLICT,SysValueCopy
;End If
ENDIF55:
;Wait 25 us
	ldi	DELAYTEMP,133
DelayUS21:
	dec	DELAYTEMP
	brne	DelayUS21
	nop
;LNPOneCount += 1
	lds	SysTemp1,LNPONECOUNT
	inc	SysTemp1
	sts	LNPONECOUNT,SysTemp1
;Else
	rjmp	ENDIF53
ELSE53_1:
;Dir LNP_RX_PIN Out
	sbi	DDRD,0
;Set LNP_RX_PIN Off
	cbi	PORTD,0
;Wait 52 us
	ldi	DELAYTEMP2,1
DelayUSO22:
	ldi	DELAYTEMP,0
DelayUS22:
	dec	DELAYTEMP
	brne	DelayUS22
	dec	DELAYTEMP2
	brne	DelayUSO22
	ldi	DELAYTEMP,20
DelayUS23:
	dec	DELAYTEMP
	brne	DelayUS23
	nop
;End If
ENDIF53:
;Rotate LNPOutByte Right
	lds	SysValueCopy,LNPOUTBYTE
	ror	SysValueCopy
	sts	LNPOUTBYTE,SysValueCopy
;End Repeat
	lds	SysTemp1,SysRepeatTemp11
	dec	SysTemp1
	sts	SysRepeatTemp11,SysTemp1
	brne	SysRepeatLoop11
SysRepeatLoopEnd11:
;Odd parity. Odd number of ones, send zero
;If LNPOneCount.0 Then
	lds	SysBitTest,LNPONECOUNT
	sbrs	SysBitTest,0
	rjmp	ELSE54_1
;Dir LNP_RX_PIN Out
	sbi	DDRD,0
;Set LNP_RX_PIN Off
	cbi	PORTD,0
;Else
	rjmp	ENDIF54
ELSE54_1:
;Set LNP_RX_PIN On
;Dir LNP_RX_PIN In
	cbi	DDRD,0
;End If
ENDIF54:
;Wait 52 us
	ldi	DELAYTEMP2,1
DelayUSO24:
	ldi	DELAYTEMP,0
DelayUS24:
	dec	DELAYTEMP
	brne	DelayUS24
	dec	DELAYTEMP2
	brne	DelayUSO24
	ldi	DELAYTEMP,20
DelayUS25:
	dec	DELAYTEMP
	brne	DelayUS25
	nop
;Stop bit
;Set LNP_RX_PIN On
;Dir LNP_RX_PIN In
	cbi	DDRD,0
;Wait 52 us
	ldi	DELAYTEMP2,1
DelayUSO26:
	ldi	DELAYTEMP,0
DelayUS26:
	dec	DELAYTEMP
	brne	DelayUS26
	dec	DELAYTEMP2
	brne	DelayUSO26
	ldi	DELAYTEMP,20
DelayUS27:
	dec	DELAYTEMP
	brne	DelayUS27
	nop
TRANSMITABORTED:
;Dir LNP_RX_PIN In
	cbi	DDRD,0
;Set RXEN0 On
	lds	SysValueCopy,UCSR0B
	sbr	SysValueCopy,1<<RXEN0
	sts	UCSR0B,SysValueCopy
;IntOn
	lds	SysBitTest,SYSINTSTATESAVE0
	sbrc	SysBitTest,1
	sei
;Wait 100 us
	ldi	DELAYTEMP2,2
DelayUSO28:
	ldi	DELAYTEMP,0
DelayUS28:
	dec	DELAYTEMP
	brne	DelayUS28
	dec	DELAYTEMP2
	brne	DelayUSO28
	ldi	DELAYTEMP,19
DelayUS29:
	dec	DELAYTEMP
	brne	DelayUS29
	nop
	ret

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (429)
SENDPOINTSLNP:
;Repeat 5
	ldi	SysValueCopy,5
	sts	SysRepeatTemp8,SysValueCopy
SysRepeatLoop8:
;SendLNPPair 3, PointCommand
	ldi	SysValueCopy,3
	sts	ADDRESSOUT,SysValueCopy
	lds	SysValueCopy,POINTCOMMAND
	sts	DATAOUT,SysValueCopy
	rcall	SENDLNPPAIR
;Wait 75 ms
	ldi	SysWaitTempMS,75
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;If PointCommand = PointsState Then
	lds	SysCalcTempA,POINTCOMMAND
	lds	SysCalcTempB,POINTSSTATE
	cp	SysCalcTempA,SysCalcTempB
	brne	ENDIF36
;Exit Sub
	ret
;End If
ENDIF36:
;End Repeat
	lds	SysTemp1,SysRepeatTemp8
	dec	SysTemp1
	sts	SysRepeatTemp8,SysTemp1
	brne	SysRepeatLoop8
SysRepeatLoopEnd8:
	ret

;********************************************************************************

SEVENSEGDISPDIGIT:
	cpi	SysStringA, 17
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TABLESEVENSEGDISPDIGIT<<1)
	ldi	SysReadA_H, high(TABLESEVENSEGDISPDIGIT<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TABLESEVENSEGDISPDIGIT:
	.DB	16,63,6,91,79,102,109,125,7,127,111,119,124,57,94,121,113

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (231)
SHOWNUMBER:
;If LapCountRequest <> 255 Then
	lds	SysCalcTempA,LAPCOUNTREQUEST
	cpi	SysCalcTempA,255
	breq	ELSE23_1
;UIShowNumber numOut
	lds	SysValueCopy,NUMOUT
	sts	NUMBER,SysValueCopy
	rcall	UISHOWNUMBER
;Else
	rjmp	ENDIF23
ELSE23_1:
;DISP_B0 = numOut.0
	cbi	PORTD,5
	lds	SysBitTest,NUMOUT
	sbrc	SysBitTest,0
	sbi	PORTD,5
;DISP_B1 = numOut.1
	cbi	PORTD,6
	lds	SysBitTest,NUMOUT
	sbrc	SysBitTest,1
	sbi	PORTD,6
;DISP_B2 = numOut.2
	cbi	PORTD,7
	lds	SysBitTest,NUMOUT
	sbrc	SysBitTest,2
	sbi	PORTD,7
;End If
ENDIF23:
	ret

;********************************************************************************

;Source: stdbasic.h (303)
FN_SWAP4:
;Dim Swap4In Alias SysCalcTempA
;Dim Swap4 Alias SysCalcTempX
;mov Swap4, Swap4In
	mov	SWAP4, SWAP4IN
;asm swap Swap4
	swaP	SWAP4
	ret

;********************************************************************************

;Source: system.h (4062)
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

;Source: system.h (4482)
SYSCOMPLESSTHAN16:
;clr SysByteTempX
	clr	SYSBYTETEMPX
;Test High, exit false if more
;cp SysWordTempB_H,SysWordTempA_H
	cp	SYSWORDTEMPB_H,SYSWORDTEMPA_H
;brlo SCLT16False
	brlo	SCLT16FALSE
;Test high, exit true if less
;cp SysWordTempA_H,SysWordTempB_H
	cp	SYSWORDTEMPA_H,SYSWORDTEMPB_H
;brlo SCLT16True
	brlo	SCLT16TRUE
;Test Low, exit if more or equal
;cp SysWordTempA,SysWordTempB
	cp	SYSWORDTEMPA,SYSWORDTEMPB
;brlo SCLT16True
	brlo	SCLT16TRUE
;ret
	ret
SCLT16TRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
SCLT16FALSE:
	ret

;********************************************************************************

;Source: system.h (3388)
SYSDIVSUB:
;Check for div/0
;tst SysByteTempB
	tst	SYSBYTETEMPB
;brne DIV8Cont
	brne	DIV8CONT
;ret
	ret
DIV8CONT:
;Main calc routine
;clr SysByteTempX
	clr	SYSBYTETEMPX
;SysDivLoop = 8
	ldi	SysValueCopy,8
	mov	SYSDIVLOOP,SysValueCopy
SYSDIV8START:
;lsl SysByteTempA
	lsl	SYSBYTETEMPA
;rol SysByteTempX
	rol	SYSBYTETEMPX
;asm sub SysByteTempX,SysByteTempB 'asm needed, or else sub will be used as start of sub
	sub	SYSBYTETEMPX,SYSBYTETEMPB
;sbr SysByteTempA,1
	sbr	SYSBYTETEMPA,1
;brsh Div8NotNeg
	brsh	DIV8NOTNEG
;cbr SysByteTempA,1
	cbr	SYSBYTETEMPA,1
;add SysByteTempX,SysByteTempB
	add	SYSBYTETEMPX,SYSBYTETEMPB
DIV8NOTNEG:
;dec SysDivLoop
	dec	SYSDIVLOOP
;brne SysDiv8Start
	brne	SYSDIV8START
	ret

;********************************************************************************

;Source: eeprom.h (192)
SYSEPREAD:
;Variable alias
;Dim EEAddress As Word Alias EEARH, EEARL
;Dim EEDataValue Alias EEDR
;Start read
;Set EERE On
	sbi	EECR,EERE
	ret

;********************************************************************************

SysIntContextRestore:
;Restore registers
	lds	SysCalcTempA,SaveSysCalcTempA
	lds	SysTemp1,SaveSysTemp1
	lds	SysTemp3,SaveSysTemp3
	lds	SysCalcTempB,SaveSysCalcTempB
	lds	SysStringA,SaveSysStringA
	lds	SysTemp2,SaveSysTemp2
	lds	SysStringA_H,SaveSysStringA_H
	lds	SysByteTempX,SaveSysByteTempX
;Restore SREG
	lds	SysValueCopy,SaveSREG
	out	SREG,SysValueCopy
;Restore SysValueCopy
	lds	SysValueCopy,SaveSysValueCopy
	reti

;********************************************************************************

SysIntContextSave:
;Store SysValueCopy
	sts	SaveSysValueCopy,SysValueCopy
;Store SREG
	in	SysValueCopy,SREG
	sts	SaveSREG,SysValueCopy
;Store registers
	sts	SaveSysCalcTempA,SysCalcTempA
	sts	SaveSysTemp1,SysTemp1
	sts	SaveSysTemp3,SysTemp3
	sts	SaveSysCalcTempB,SysCalcTempB
	sts	SaveSysStringA,SysStringA
	sts	SaveSysTemp2,SysTemp2
	sts	SaveSysStringA_H,SysStringA_H
	sts	SaveSysByteTempX,SysByteTempX
	ret

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (419)
UICLEARLAPCOUNT:
;SendLNPPair 5, 0
	ldi	SysValueCopy,5
	sts	ADDRESSOUT,SysValueCopy
	ldi	SysValueCopy,0
	sts	DATAOUT,SysValueCopy
	rjmp	SENDLNPPAIR

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (415)
UIDISABLECOUNTING:
;SendLNPPair 5, 1
	ldi	SysValueCopy,5
	sts	ADDRESSOUT,SysValueCopy
	ldi	SysValueCopy,1
	sts	DATAOUT,SysValueCopy
	rjmp	SENDLNPPAIR

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (411)
UIENABLECOUNTING:
;SendLNPPair 5, 2
	ldi	SysValueCopy,5
	sts	ADDRESSOUT,SysValueCopy
	ldi	SysValueCopy,2
	sts	DATAOUT,SysValueCopy
	rjmp	SENDLNPPAIR

;********************************************************************************

;Source: Lego train with points serial crossing v3.gcb (423)
UISHOWNUMBER:
;ReadTable SevenSegDispDigit, number + 1, OutBitmap
	lds	SysTemp1,NUMBER
	inc	SysTemp1
	mov	SYSSTRINGA,SysTemp1
	rcall	SEVENSEGDISPDIGIT
	sts	OUTBITMAP,SysByteTempX
;OutBitmap.7 = 1
	lds	SysValueCopy,OUTBITMAP
	sbr	SysValueCopy,1<<7
	sts	OUTBITMAP,SysValueCopy
;SendLNPPair 5, OutBitmap
	ldi	SysValueCopy,5
	sts	ADDRESSOUT,SysValueCopy
	lds	SysValueCopy,OUTBITMAP
	sts	DATAOUT,SysValueCopy
	rjmp	SENDLNPPAIR

;********************************************************************************


