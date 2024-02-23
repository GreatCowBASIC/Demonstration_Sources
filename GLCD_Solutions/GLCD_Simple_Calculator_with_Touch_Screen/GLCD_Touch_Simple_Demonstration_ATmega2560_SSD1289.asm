;Program compiled by GCBASIC (2024.2.13 (Windows 64 bit) : Build 1335) for Microchip AVR Assembler using FreeBASIC 1.07.1/2024-02-14 CRC247
;Need help? 
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   w_cholmondeley at users dot sourceforge dot net
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Source file    : D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Simple_Calculator_with_Touch_Screen\GLCD_Touch_Simple_Demonstration_ATmega2560_SSD1289.gcb
;   Setting file   : C:\GCstudio\gcbasic\use.ini
;   Preserve mode  : 0
;   Assembler      : C:\GCstudio\gcbasic\AVRASM
;   Programmer     : 
;   Output file    : D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Simple_Calculator_with_Touch_Screen\GLCD_Touch_Simple_Demonstration_ATmega2560_SSD1289.asm
;********************************************************************************

;Chip Model: MEGA2560
;Assembler header file
.INCLUDE "m2560def.inc"

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
.EQU	ADS7843_COUNT=744	         ; 0x2E8
.EQU	ADS7843_DATA=745	         ; 0x2E9
.EQU	ADS7843_DATA_H=746	         ; 0x2EA
.EQU	ADS7843_READ=747	         ; 0x2EB
.EQU	ADS7843_READ_H=748	         ; 0x2EC
.EQU	BORDERCOLOR=749	         ; 0x2ED
.EQU	BORDERCOLOR_H=750	         ; 0x2EE
.EQU	BX1=751	         ; 0x2EF
.EQU	BX1_H=752	         ; 0x2F0
.EQU	BX2=753	         ; 0x2F1
.EQU	BX2_H=754	         ; 0x2F2
.EQU	BY1=755	         ; 0x2F3
.EQU	BY1_H=756	         ; 0x2F4
.EQU	BY2=757	         ; 0x2F5
.EQU	BY2_H=758	         ; 0x2F6
.EQU	CALC=759	         ; 0x2F7
.EQU	CHARCODE=760	         ; 0x2F8
.EQU	CHARCOL=761	         ; 0x2F9
.EQU	CHARCOLS=763	         ; 0x2FB
.EQU	CHARCOL_H=762	         ; 0x2FA
.EQU	CHARLOCX=764	         ; 0x2FC
.EQU	CHARLOCX_H=765	         ; 0x2FD
.EQU	CHARLOCY=766	         ; 0x2FE
.EQU	CHARLOCY_H=767	         ; 0x2FF
.EQU	CHARROW=768	         ; 0x300
.EQU	CHARROWS=770	         ; 0x302
.EQU	CHARROW_H=769	         ; 0x301
.EQU	COL=771	         ; 0x303
.EQU	COLOR=772	         ; 0x304
.EQU	COLOR_H=773	         ; 0x305
.EQU	CONTROLBYTE=774	         ; 0x306
.EQU	COUNTI=775	         ; 0x307
.EQU	COUNTI_H=776	         ; 0x308
.EQU	COUNTJ=777	         ; 0x309
.EQU	COUNTJ_H=778	         ; 0x30A
.EQU	CURRCHARCOL=779	         ; 0x30B
.EQU	CURRCHARROW=780	         ; 0x30C
.EQU	CURRCHARVAL=781	         ; 0x30D
.EQU	DATAVAL=782	         ; 0x30E
.EQU	DATAVAL_H=783	         ; 0x30F
.EQU	DIG=784	         ; 0x310
.EQU	DRAWLINE=785	         ; 0x311
.EQU	DRAWLINE_H=786	         ; 0x312
.EQU	FCOLOR=787	         ; 0x313
.EQU	FCOLOR_H=788	         ; 0x314
.EQU	FILLCOLOR=789	         ; 0x315
.EQU	FILLCOLOR_H=790	         ; 0x316
.EQU	FRI=791	         ; 0x317
.EQU	FRI_H=792	         ; 0x318
.EQU	GLCDBACKGROUND=793	         ; 0x319
.EQU	GLCDBACKGROUND_H=794	         ; 0x31A
.EQU	GLCDDEVICEHEIGHT=795	         ; 0x31B
.EQU	GLCDDEVICEHEIGHT_H=796	         ; 0x31C
.EQU	GLCDDEVICEWIDTH=797	         ; 0x31D
.EQU	GLCDDEVICEWIDTH_H=798	         ; 0x31E
.EQU	GLCDFNTDEFAULTHEIGHT=799	         ; 0x31F
.EQU	GLCDFNTDEFAULTSIZE=800	         ; 0x320
.EQU	GLCDFONTWIDTH=801	         ; 0x321
.EQU	GLCDFOREGROUND=802	         ; 0x322
.EQU	GLCDFOREGROUND_H=803	         ; 0x323
.EQU	GLCDPRINTLOC=804	         ; 0x324
.EQU	GLCDPRINTLOC_H=805	         ; 0x325
.EQU	GLCDTEMP=806	         ; 0x326
.EQU	GLCDTEMPXY=808	         ; 0x328
.EQU	GLCDTEMP_H=807	         ; 0x327
.EQU	LEN=809	         ; 0x329
.EQU	LINECOLOUR=810	         ; 0x32A
.EQU	LINECOLOUR_H=811	         ; 0x32B
.EQU	LINEDIFFX=812	         ; 0x32C
.EQU	LINEDIFFX_H=813	         ; 0x32D
.EQU	LINEDIFFX_X2=814	         ; 0x32E
.EQU	LINEDIFFX_X2_H=815	         ; 0x32F
.EQU	LINEDIFFY=816	         ; 0x330
.EQU	LINEDIFFY_H=817	         ; 0x331
.EQU	LINEDIFFY_X2=818	         ; 0x332
.EQU	LINEDIFFY_X2_H=819	         ; 0x333
.EQU	LINEERR=820	         ; 0x334
.EQU	LINEERR_H=821	         ; 0x335
.EQU	LINESTEPX=822	         ; 0x336
.EQU	LINESTEPX_H=823	         ; 0x337
.EQU	LINESTEPY=824	         ; 0x338
.EQU	LINESTEPY_H=825	         ; 0x339
.EQU	LINEX1=826	         ; 0x33A
.EQU	LINEX1_H=827	         ; 0x33B
.EQU	LINEX2=828	         ; 0x33C
.EQU	LINEX2_H=829	         ; 0x33D
.EQU	LINEY1=830	         ; 0x33E
.EQU	LINEY1_H=831	         ; 0x33F
.EQU	LINEY2=832	         ; 0x340
.EQU	LINEY2_H=833	         ; 0x341
.EQU	ORIENTATION_SSD1289=834	         ; 0x342
.EQU	PREC=835	         ; 0x343
.EQU	PRECISION=836	         ; 0x344
.EQU	PRINTLEN=837	         ; 0x345
.EQU	PRINTLOCX=838	         ; 0x346
.EQU	PRINTLOCX_H=839	         ; 0x347
.EQU	PRINTLOCY=840	         ; 0x348
.EQU	PRINTLOCY_H=841	         ; 0x349
.EQU	PX1=842	         ; 0x34A
.EQU	PX1_H=843	         ; 0x34B
.EQU	PX2=844	         ; 0x34C
.EQU	PX2_H=845	         ; 0x34D
.EQU	PY1=846	         ; 0x34E
.EQU	PY1_H=847	         ; 0x34F
.EQU	PY2=848	         ; 0x350
.EQU	PY2_H=849	         ; 0x351
.EQU	RESTEXT=512	         ; 0x200
.EQU	RESVAL=850	         ; 0x352
.EQU	RESVAL_E=853	         ; 0x355
.EQU	RESVAL_H=851	         ; 0x353
.EQU	RESVAL_U=852	         ; 0x354
.EQU	RIGHT=553	         ; 0x229
.EQU	ROW=854	         ; 0x356
.EQU	RX1=855	         ; 0x357
.EQU	RX1_H=856	         ; 0x358
.EQU	RX2=857	         ; 0x359
.EQU	RX2_H=858	         ; 0x35A
.EQU	RY1=859	         ; 0x35B
.EQU	RY1_H=860	         ; 0x35C
.EQU	RY2=861	         ; 0x35D
.EQU	RY2_H=862	         ; 0x35E
.EQU	SIZE=863	         ; 0x35F
.EQU	STR=738	         ; 0x2E2
.EQU	STRINGPOINTER=864	         ; 0x360
.EQU	SX=865	         ; 0x361
.EQU	SX_E=868	         ; 0x364
.EQU	SX_H=866	         ; 0x362
.EQU	SX_U=867	         ; 0x363
.EQU	SY=869	         ; 0x365
.EQU	SYSARRAYTEMP1=873	         ; 0x369
.EQU	SYSARRAYTEMP2=874	         ; 0x36A
.EQU	SYSCHARCOUNT=875	         ; 0x36B
.EQU	SYSCHARSTART=876	         ; 0x36C
.EQU	SYSLENTEMPHANDLER=877	         ; 0x36D
.EQU	SYSLENTEMPHANDLER_H=878	         ; 0x36E
.EQU	SYSLONGDIVMULTA=879	         ; 0x36F
.EQU	SYSLONGDIVMULTA_E=882	         ; 0x372
.EQU	SYSLONGDIVMULTA_H=880	         ; 0x370
.EQU	SYSLONGDIVMULTA_U=881	         ; 0x371
.EQU	SYSLONGDIVMULTB=883	         ; 0x373
.EQU	SYSLONGDIVMULTB_E=886	         ; 0x376
.EQU	SYSLONGDIVMULTB_H=884	         ; 0x374
.EQU	SYSLONGDIVMULTB_U=885	         ; 0x375
.EQU	SYSLONGDIVMULTX=887	         ; 0x377
.EQU	SYSLONGDIVMULTX_E=890	         ; 0x37A
.EQU	SYSLONGDIVMULTX_H=888	         ; 0x378
.EQU	SYSLONGDIVMULTX_U=889	         ; 0x379
.EQU	SYSPRINTDATAHANDLER=891	         ; 0x37B
.EQU	SYSPRINTDATAHANDLER_H=892	         ; 0x37C
.EQU	SYSPRINTTEMP=893	         ; 0x37D
.EQU	SYSREPEATTEMP1=894	         ; 0x37E
.EQU	SYSREPEATTEMP2=895	         ; 0x37F
.EQU	SYSREPEATTEMP3=896	         ; 0x380
.EQU	SYSREPEATTEMP4=897	         ; 0x381
.EQU	SYSSTRDATA=898	         ; 0x382
.EQU	SYSSTRINGPARAM1=717	         ; 0x2CD
.EQU	SYSSTRINGTEMP=899	         ; 0x383
.EQU	SYSSYSINSTRINGHANDLER=900	         ; 0x384
.EQU	SYSSYSINSTRINGHANDLER_H=901	         ; 0x385
.EQU	SYSVALTEMP=902	         ; 0x386
.EQU	SYSVALTEMP_H=903	         ; 0x387
.EQU	SY_E=872	         ; 0x368
.EQU	SY_H=870	         ; 0x366
.EQU	SY_U=871	         ; 0x367
.EQU	TEMPCOLOR1=904	         ; 0x388
.EQU	TEMPCOLOR1_H=905	         ; 0x389
.EQU	TEMPCOLOR2=906	         ; 0x38A
.EQU	TEMPCOLOR2_H=907	         ; 0x38B
.EQU	TEMPTEXT=594	         ; 0x252
.EQU	TEXT1=635	         ; 0x27B
.EQU	TEXT2=676	         ; 0x2A4
.EQU	TP_X=908	         ; 0x38C
.EQU	TP_X_H=909	         ; 0x38D
.EQU	TP_Y=910	         ; 0x38E
.EQU	TP_Y_H=911	         ; 0x38F
.EQU	T_X=912	         ; 0x390
.EQU	T_X_H=913	         ; 0x391
.EQU	T_Y=914	         ; 0x392
.EQU	T_Y_H=915	         ; 0x393
.EQU	VAL=916	         ; 0x394
.EQU	VAL1=918	         ; 0x396
.EQU	VAL1_E=921	         ; 0x399
.EQU	VAL1_H=919	         ; 0x397
.EQU	VAL1_U=920	         ; 0x398
.EQU	VAL2=922	         ; 0x39A
.EQU	VAL2_E=925	         ; 0x39D
.EQU	VAL2_H=923	         ; 0x39B
.EQU	VAL2_U=924	         ; 0x39C
.EQU	VAL_H=917	         ; 0x395
.EQU	WCOMMAND=926	         ; 0x39E
.EQU	WCOMMAND_H=927	         ; 0x39F
.EQU	WDATA=928	         ; 0x3A0
.EQU	WDATA_H=929	         ; 0x3A1
.EQU	XCALC1=930	         ; 0x3A2
.EQU	XCALC1_H=931	         ; 0x3A3
.EQU	XOFFSET=932	         ; 0x3A4
.EQU	XOFFSET_H=933	         ; 0x3A5
.EQU	YCALC1=934	         ; 0x3A6
.EQU	YCALC1_H=935	         ; 0x3A7
.EQU	YOFFSET=936	         ; 0x3A8
.EQU	YOFFSET_H=937	         ; 0x3A9

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSBITTEST=r5
.DEF	SYSBYTETEMPA=r22
.DEF	SYSBYTETEMPB=r28
.DEF	SYSBYTETEMPX=r0
.DEF	SYSCALCTEMPA=r22
.DEF	SYSCALCTEMPA_H=r23
.DEF	SYSCALCTEMPB=r28
.DEF	SYSCALCTEMPB_H=r29
.DEF	SYSCALCTEMPX=r0
.DEF	SYSCALCTEMPX_H=r1
.DEF	SYSDIVLOOP=r5
.DEF	SYSDIVMULTA=r24
.DEF	SYSDIVMULTA_H=r25
.DEF	SYSDIVMULTB=r30
.DEF	SYSDIVMULTB_H=r31
.DEF	SYSDIVMULTX=r2
.DEF	SYSDIVMULTX_H=r3
.DEF	SYSINTEGERTEMPA=r22
.DEF	SYSINTEGERTEMPA_H=r23
.DEF	SYSINTEGERTEMPB=r28
.DEF	SYSINTEGERTEMPB_H=r29
.DEF	SYSINTEGERTEMPX=r0
.DEF	SYSINTEGERTEMPX_H=r1
.DEF	SYSLONGTEMPA=r22
.DEF	SYSLONGTEMPA_H=r23
.DEF	SYSLONGTEMPA_U=r24
.DEF	SYSLONGTEMPA_E=r25
.DEF	SYSLONGTEMPB=r28
.DEF	SYSLONGTEMPB_H=r29
.DEF	SYSLONGTEMPB_U=r30
.DEF	SYSLONGTEMPB_E=r31
.DEF	SYSLONGTEMPX=r0
.DEF	SYSLONGTEMPX_H=r1
.DEF	SYSLONGTEMPX_U=r2
.DEF	SYSLONGTEMPX_E=r3
.DEF	SYSREADA=r30
.DEF	SYSREADA_H=r31
.DEF	SYSSIGNBYTE=r4
.DEF	SYSSTRINGA=r26
.DEF	SYSSTRINGA_H=r27
.DEF	SYSSTRINGB=r28
.DEF	SYSSTRINGB_H=r29
.DEF	SYSSTRINGLENGTH=r25
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30
.DEF	SYSWAITTEMPS=r31
.DEF	SYSWORDTEMPA=r22
.DEF	SYSWORDTEMPA_H=r23
.DEF	SYSWORDTEMPB=r28
.DEF	SYSWORDTEMPB_H=r29
.DEF	SYSWORDTEMPX=r0
.DEF	SYSWORDTEMPX_H=r1
.DEF	SYSTEMP1=r6
.DEF	SYSTEMP1_H=r7
.DEF	SYSTEMP1_U=r8
.DEF	SYSTEMP1_E=r9
.DEF	SYSTEMP2=r10
.DEF	SYSTEMP2_H=r11
.DEF	SYSTEMP2_U=r12
.DEF	SYSTEMP2_E=r13
.DEF	SYSTEMP3=r14
.DEF	SYSTEMP4=r15
.DEF	SYSTEMP5=r16
.DEF	SYSTEMP6=r17

;********************************************************************************

;Alias variables
#define	SYSRESTEXT_0	512
#define	SYSRIGHT_0	553
#define	SYSSTR_0	738

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
	reti	;INT3
.ORG	10
	reti	;INT4
.ORG	12
	reti	;INT5
.ORG	14
	reti	;INT6
.ORG	16
	reti	;INT7
.ORG	18
	reti	;PCINT0
.ORG	20
	reti	;PCINT1
.ORG	22
	reti	;PCINT2
.ORG	24
	reti	;WDT
.ORG	26
	reti	;TIMER2_COMPA
.ORG	28
	reti	;TIMER2_COMPB
.ORG	30
	reti	;TIMER2_OVF
.ORG	32
	reti	;TIMER1_CAPT
.ORG	34
	reti	;TIMER1_COMPA
.ORG	36
	reti	;TIMER1_COMPB
.ORG	38
	reti	;TIMER1_COMPC
.ORG	40
	reti	;TIMER1_OVF
.ORG	42
	reti	;TIMER0_COMPA
.ORG	44
	reti	;TIMER0_COMPB
.ORG	46
	reti	;TIMER0_OVF
.ORG	48
	reti	;SPI_STC
.ORG	50
	reti	;USART0_RX
.ORG	52
	reti	;USART0_UDRE
.ORG	54
	reti	;USART0_TX
.ORG	56
	reti	;ANALOG_COMP
.ORG	58
	reti	;ADC
.ORG	60
	reti	;EE_READY
.ORG	62
	reti	;TIMER3_CAPT
.ORG	64
	reti	;TIMER3_COMPA
.ORG	66
	reti	;TIMER3_COMPB
.ORG	68
	reti	;TIMER3_COMPC
.ORG	70
	reti	;TIMER3_OVF
.ORG	72
	reti	;USART1_RX
.ORG	74
	reti	;USART1_UDRE
.ORG	76
	reti	;USART1_TX
.ORG	78
	reti	;TWI
.ORG	80
	reti	;SPM_READY
.ORG	82
	reti	;TIMER4_CAPT
.ORG	84
	reti	;TIMER4_COMPA
.ORG	86
	reti	;TIMER4_COMPB
.ORG	88
	reti	;TIMER4_COMPC
.ORG	90
	reti	;TIMER4_OVF
.ORG	92
	reti	;TIMER5_CAPT
.ORG	94
	reti	;TIMER5_COMPA
.ORG	96
	reti	;TIMER5_COMPB
.ORG	98
	reti	;TIMER5_COMPC
.ORG	100
	reti	;TIMER5_OVF
.ORG	102
	reti	;USART2_RX
.ORG	104
	reti	;USART2_UDRE
.ORG	106
	reti	;USART2_TX
.ORG	108
	reti	;USART3_RX
.ORG	110
	reti	;USART3_UDRE
.ORG	112
	reti	;USART3_TX

;********************************************************************************

;Program_memory_page: 0
.ORG	114
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	SPL, SysValueCopy
;Call initialisation routines
	call	INITSYS
	call	ADS7843_INIT
	call	INITGLCD_SSD1289

;Start_of_the_main_program
	ldi	SysValueCopy,31
	sts	GLCDBACKGROUND,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	ORIENTATION_SSD1289,SysValueCopy
	call	GLCDROTATE_SSD1289
	ldi	SysValueCopy,20
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,10
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	lds	SysTemp1,GLCDDEVICEWIDTH
	ldi	SysTemp5,20
	sub	SysTemp1,SysTemp5
	sts	BX2,SysTemp1
	lds	SysTemp1,GLCDDEVICEWIDTH_H
	ldi	SysTemp5,0
	sbc	SysTemp1,SysTemp5
	sts	BX2_H,SysTemp1
	ldi	SysValueCopy,50
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable1<<1)
	ldi	SysReadA_H,high(StringTable1<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,20
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,70
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,80
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,140
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,190
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,200
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,250
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable5<<1)
	ldi	SysReadA_H,high(StringTable5<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,20
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,100
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,70
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable6<<1)
	ldi	SysReadA_H,high(StringTable6<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,80
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,100
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable7<<1)
	ldi	SysReadA_H,high(StringTable7<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,140
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,100
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,190
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable8<<1)
	ldi	SysReadA_H,high(StringTable8<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,200
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,100
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,250
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable9<<1)
	ldi	SysReadA_H,high(StringTable9<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,20
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,70
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,170
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,80
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,170
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable11<<1)
	ldi	SysReadA_H,high(StringTable11<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,140
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,190
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,170
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable12<<1)
	ldi	SysReadA_H,high(StringTable12<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,200
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,250
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,170
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable13<<1)
	ldi	SysReadA_H,high(StringTable13<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,20
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,180
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,210
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable14<<1)
	ldi	SysReadA_H,high(StringTable14<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,140
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,180
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,190
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,210
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable15<<1)
	ldi	SysReadA_H,high(StringTable15<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,200
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,180
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,250
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,210
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable16<<1)
	ldi	SysReadA_H,high(StringTable16<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,4
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,1
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,43
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable17<<1)
	ldi	SysReadA_H,high(StringTable17<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,4
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,1
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	ldi	SysValueCopy,43
	sts	BX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	BX2_H,SysValueCopy
	ldi	SysValueCopy,210
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable18<<1)
	ldi	SysReadA_H,high(StringTable18<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,20
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,10
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	lds	SysTemp1,GLCDDEVICEWIDTH
	ldi	SysTemp5,20
	sub	SysTemp1,SysTemp5
	sts	BX2,SysTemp1
	lds	SysTemp1,GLCDDEVICEWIDTH_H
	ldi	SysTemp5,0
	sbc	SysTemp1,SysTemp5
	sts	BX2_H,SysTemp1
	ldi	SysValueCopy,50
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable19<<1)
	ldi	SysReadA_H,high(StringTable19<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysWaitTempS,1
	call	Delay_S
	ldi	SysValueCopy,20
	sts	BX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BX1_H,SysValueCopy
	ldi	SysValueCopy,10
	sts	BY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY1_H,SysValueCopy
	lds	SysTemp1,GLCDDEVICEWIDTH
	ldi	SysTemp5,20
	sub	SysTemp1,SysTemp5
	sts	BX2,SysTemp1
	lds	SysTemp1,GLCDDEVICEWIDTH_H
	ldi	SysTemp5,0
	sbc	SysTemp1,SysTemp5
	sts	BX2_H,SysTemp1
	ldi	SysValueCopy,50
	sts	BY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	BY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	FILLCOLOR,SysValueCopy
	ldi	SysValueCopy,0
	sts	FILLCOLOR_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	BORDERCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	BORDERCOLOR_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable20<<1)
	ldi	SysReadA_H,high(StringTable20<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	FCOLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	FCOLOR_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	CREATEBUTTON
	ldi	SysValueCopy,0
	sts	DIG,SysValueCopy
	ldi	SysValueCopy,0
	sts	CALC,SysValueCopy
	ldi	SysStringB,low(RESTEXT)
	ldi	SysStringB_H,high(RESTEXT)
	ldi	SysReadA,low(StringTable21<<1)
	ldi	SysReadA_H,high(StringTable21<<1)
	call	SYSREADSTRING
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SYSREADSTRING
SysDoLoop_S1:
	sbic	PINE,4
	jmp	ENDIF1
	call	ADS7843_GETXY
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,20
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,70
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,60
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,90
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF2
	ldi	SysValueCopy,20
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,70
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,20
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,70
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	call	SYSREADSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	lds	SysTemp1,DIG
	inc	SysTemp1
	sts	DIG,SysTemp1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
ENDIF2:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,80
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,130
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,60
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,90
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF3
	ldi	SysValueCopy,80
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,80
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	call	SYSREADSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	lds	SysTemp1,DIG
	inc	SysTemp1
	sts	DIG,SysTemp1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
ENDIF3:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,140
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,190
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,60
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,90
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF4
	ldi	SysValueCopy,140
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,190
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,140
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,190
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	call	SYSREADSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	lds	SysTemp1,DIG
	inc	SysTemp1
	sts	DIG,SysTemp1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
ENDIF4:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,20
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,70
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,130
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF5
	ldi	SysValueCopy,20
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,100
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,70
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,20
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,100
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,70
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysReadA,low(StringTable6<<1)
	ldi	SysReadA_H,high(StringTable6<<1)
	call	SYSREADSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	lds	SysTemp1,DIG
	inc	SysTemp1
	sts	DIG,SysTemp1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
ENDIF5:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,80
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,130
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,130
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF6
	ldi	SysValueCopy,80
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,100
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,80
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,100
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysReadA,low(StringTable7<<1)
	ldi	SysReadA_H,high(StringTable7<<1)
	call	SYSREADSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	lds	SysTemp1,DIG
	inc	SysTemp1
	sts	DIG,SysTemp1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
ENDIF6:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,140
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,190
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,130
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF7
	ldi	SysValueCopy,140
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,100
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,190
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,140
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,100
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,190
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysReadA,low(StringTable8<<1)
	ldi	SysReadA_H,high(StringTable8<<1)
	call	SYSREADSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	lds	SysTemp1,DIG
	inc	SysTemp1
	sts	DIG,SysTemp1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
ENDIF7:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,20
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,70
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,140
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,170
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF8
	ldi	SysValueCopy,20
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,70
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,170
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,20
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,70
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,170
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SYSREADSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	lds	SysTemp1,DIG
	inc	SysTemp1
	sts	DIG,SysTemp1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
ENDIF8:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,80
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,130
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,140
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,170
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF9
	ldi	SysValueCopy,80
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,170
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,80
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,170
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysReadA,low(StringTable11<<1)
	ldi	SysReadA_H,high(StringTable11<<1)
	call	SYSREADSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	lds	SysTemp1,DIG
	inc	SysTemp1
	sts	DIG,SysTemp1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
ENDIF9:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,140
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,190
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,140
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,170
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF10
	ldi	SysValueCopy,140
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,190
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,170
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,140
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,190
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,170
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysReadA,low(StringTable12<<1)
	ldi	SysReadA_H,high(StringTable12<<1)
	call	SYSREADSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	lds	SysTemp1,DIG
	inc	SysTemp1
	sts	DIG,SysTemp1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
ENDIF10:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,20
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,130
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,180
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,210
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF11
	ldi	SysValueCopy,20
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,180
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,210
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,20
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,180
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,210
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysReadA,low(StringTable14<<1)
	ldi	SysReadA_H,high(StringTable14<<1)
	call	SYSREADSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	lds	SysTemp1,DIG
	inc	SysTemp1
	sts	DIG,SysTemp1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	call	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
ENDIF11:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,200
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,250
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,180
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,210
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF12
	ldi	SysValueCopy,200
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,180
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,250
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,210
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,200
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,180
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,250
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,210
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	lds	SysCalcTempA,CALC
	tst	SysCalcTempA
	brne	ENDIF18
	ldi	SysValueCopy,low(RESTEXT)
	sts	SysLENTEMPHandler,SysValueCopy
	ldi	SysValueCopy,high(RESTEXT)
	sts	SysLENTEMPHandler_H,SysValueCopy
	call	FN_LEN
	lds	SysCalcTempA,LEN
	tst	SysCalcTempA
	brne	ELSE23_1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	lds	SysValueCopy,DIG
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEXT1)
	ldi	SysStringB_H,high(TEXT1)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,0
	sts	DIG,SysValueCopy
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SYSREADSTRING
	rjmp	ENDIF23
ELSE23_1:
	ldi	SysStringB,low(TEXT1)
	ldi	SysStringB_H,high(TEXT1)
	ldi	SysStringA,low(RESTEXT)
	ldi	SysStringA_H,high(RESTEXT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,0
	sts	SYSRESTEXT_0,SysValueCopy
ENDIF23:
	ldi	SysValueCopy,1
	sts	CALC,SysValueCopy
ENDIF18:
ENDIF12:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,200
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,250
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,140
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,170
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF13
	ldi	SysValueCopy,200
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,250
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,170
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,200
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,250
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,170
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	lds	SysCalcTempA,CALC
	tst	SysCalcTempA
	brne	ENDIF19
	ldi	SysValueCopy,low(RESTEXT)
	sts	SysLENTEMPHandler,SysValueCopy
	ldi	SysValueCopy,high(RESTEXT)
	sts	SysLENTEMPHandler_H,SysValueCopy
	call	FN_LEN
	lds	SysCalcTempA,LEN
	tst	SysCalcTempA
	brne	ELSE24_1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	lds	SysValueCopy,DIG
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEXT1)
	ldi	SysStringB_H,high(TEXT1)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,0
	sts	DIG,SysValueCopy
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SYSREADSTRING
	rjmp	ENDIF24
ELSE24_1:
	ldi	SysStringB,low(TEXT1)
	ldi	SysStringB_H,high(TEXT1)
	ldi	SysStringA,low(RESTEXT)
	ldi	SysStringA_H,high(RESTEXT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,0
	sts	SYSRESTEXT_0,SysValueCopy
ENDIF24:
	ldi	SysValueCopy,2
	sts	CALC,SysValueCopy
ENDIF19:
ENDIF13:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,200
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,250
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,130
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF14
	ldi	SysValueCopy,200
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,100
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,250
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,200
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,100
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,250
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	lds	SysCalcTempA,CALC
	tst	SysCalcTempA
	brne	ENDIF20
	ldi	SysValueCopy,low(RESTEXT)
	sts	SysLENTEMPHandler,SysValueCopy
	ldi	SysValueCopy,high(RESTEXT)
	sts	SysLENTEMPHandler_H,SysValueCopy
	call	FN_LEN
	lds	SysCalcTempA,LEN
	tst	SysCalcTempA
	brne	ELSE25_1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	lds	SysValueCopy,DIG
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEXT1)
	ldi	SysStringB_H,high(TEXT1)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,0
	sts	DIG,SysValueCopy
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SYSREADSTRING
	rjmp	ENDIF25
ELSE25_1:
	ldi	SysStringB,low(TEXT1)
	ldi	SysStringB_H,high(TEXT1)
	ldi	SysStringA,low(RESTEXT)
	ldi	SysStringA_H,high(RESTEXT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,0
	sts	SYSRESTEXT_0,SysValueCopy
ENDIF25:
	ldi	SysValueCopy,3
	sts	CALC,SysValueCopy
ENDIF20:
ENDIF14:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,200
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,250
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,60
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,90
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF15
	ldi	SysValueCopy,200
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,250
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	ldi	SysValueCopy,200
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,250
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,90
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	lds	SysCalcTempA,CALC
	tst	SysCalcTempA
	brne	ENDIF21
	ldi	SysValueCopy,low(RESTEXT)
	sts	SysLENTEMPHandler,SysValueCopy
	ldi	SysValueCopy,high(RESTEXT)
	sts	SysLENTEMPHandler_H,SysValueCopy
	call	FN_LEN
	lds	SysCalcTempA,LEN
	tst	SysCalcTempA
	brne	ELSE26_1
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	lds	SysValueCopy,DIG
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEXT1)
	ldi	SysStringB_H,high(TEXT1)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,0
	sts	DIG,SysValueCopy
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SYSREADSTRING
	rjmp	ENDIF26
ELSE26_1:
	ldi	SysStringB,low(TEXT1)
	ldi	SysStringB_H,high(TEXT1)
	ldi	SysStringA,low(RESTEXT)
	ldi	SysStringA_H,high(RESTEXT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,0
	sts	SYSRESTEXT_0,SysValueCopy
ENDIF26:
	ldi	SysValueCopy,4
	sts	CALC,SysValueCopy
ENDIF21:
ENDIF15:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,4
	ldi	SysWORDTempB_H,1
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,43
	ldi	SysWORDTempA_H,1
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,60
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,130
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF16
	ldi	SysValueCopy,4
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,1
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,43
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
	ldi	SysValueCopy,4
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,1
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,60
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,43
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,130
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysStringB,low(TEXT1)
	ldi	SysStringB_H,high(TEXT1)
	ldi	SysReadA,low(StringTable21<<1)
	ldi	SysReadA_H,high(StringTable21<<1)
	call	SYSREADSTRING
	ldi	SysStringB,low(TEXT2)
	ldi	SysStringB_H,high(TEXT2)
	ldi	SysReadA,low(StringTable21<<1)
	ldi	SysReadA_H,high(StringTable21<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,0
	sts	CALC,SysValueCopy
	ldi	SysValueCopy,0
	sts	DIG,SysValueCopy
	ldi	SysValueCopy,0
	sts	VAL1,SysValueCopy
	sts	VAL1_H,SysValueCopy
	sts	VAL1_U,SysValueCopy
	sts	VAL1_E,SysValueCopy
	ldi	SysValueCopy,0
	sts	VAL2,SysValueCopy
	sts	VAL2_H,SysValueCopy
	sts	VAL2_U,SysValueCopy
	sts	VAL2_E,SysValueCopy
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysReadA,low(StringTable23<<1)
	ldi	SysReadA_H,high(StringTable23<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,0
	sts	SYSRESTEXT_0,SysValueCopy
ENDIF16:
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,4
	ldi	SysWORDTempB_H,1
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,43
	ldi	SysWORDTempA_H,1
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp3,SysTemp2
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,140
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,210
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp1
	mov	SysTemp4,SysTemp2
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF17
	ldi	SysValueCopy,4
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,1
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,43
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,210
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,248
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
	ldi	SysValueCopy,4
	sts	RX1,SysValueCopy
	ldi	SysValueCopy,1
	sts	RX1_H,SysValueCopy
	ldi	SysValueCopy,140
	sts	RY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY1_H,SysValueCopy
	ldi	SysValueCopy,43
	sts	RX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	RX2_H,SysValueCopy
	ldi	SysValueCopy,210
	sts	RY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	RY2_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	COLOR,SysValueCopy
	ldi	SysValueCopy,255
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	lds	SysCalcTempA,CALC
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	ENDIF22
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	lds	SysValueCopy,DIG
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEXT2)
	ldi	SysStringB_H,high(TEXT2)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,0
	sts	DIG,SysValueCopy
	ldi	SysValueCopy,low(TEXT1)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEXT1)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	call	FN_VAL
	lds	SysValueCopy,VAL
	sts	VAL1,SysValueCopy
	lds	SysValueCopy,VAL_H
	sts	VAL1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	VAL1_U,SysValueCopy
	sts	VAL1_E,SysValueCopy
	ldi	SysValueCopy,low(TEXT2)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEXT2)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	call	FN_VAL
	lds	SysValueCopy,VAL
	sts	VAL2,SysValueCopy
	lds	SysValueCopy,VAL_H
	sts	VAL2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	VAL2_U,SysValueCopy
	sts	VAL2_E,SysValueCopy
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SYSREADSTRING
SysSelect1Case1:
	lds	SysCalcTempA,CALC
	cpi	SysCalcTempA,1
	breq	PC + 2
	rjmp	SysSelect1Case2
	lds	SysTemp1,VAL1
	lds	SysTemp2,VAL2
	add	SysTemp1,SysTemp2
	sts	RESVAL,SysTemp1
	lds	SysTemp1,VAL1_H
	lds	SysTemp2,VAL2_H
	adc	SysTemp1,SysTemp2
	sts	RESVAL_H,SysTemp1
	lds	SysTemp1,VAL1_U
	lds	SysTemp2,VAL2_U
	adc	SysTemp1,SysTemp2
	sts	RESVAL_U,SysTemp1
	lds	SysTemp1,VAL1_E
	lds	SysTemp2,VAL2_E
	adc	SysTemp1,SysTemp2
	sts	RESVAL_E,SysTemp1
	lds	SysValueCopy,RESVAL
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,RESVAL_H
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysStringB,low(RESTEXT)
	ldi	SysStringB_H,high(RESTEXT)
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	call	SYSCOPYSTRING
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysStringA,low(RESTEXT)
	ldi	SysStringA_H,high(RESTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
	rjmp	SysSelectEnd1
SysSelect1Case2:
	lds	SysCalcTempA,CALC
	cpi	SysCalcTempA,2
	breq	PC + 2
	rjmp	SysSelect1Case3
	lds	SysLONGTempB,VAL1
	lds	SysLONGTempB_H,VAL1_H
	lds	SysLONGTempB_U,VAL1_U
	lds	SysLONGTempB_E,VAL1_E
	lds	SysLONGTempA,VAL2
	lds	SysLONGTempA_H,VAL2_H
	lds	SysLONGTempA_U,VAL2_U
	lds	SysLONGTempA_E,VAL2_E
	call	SYSCOMPLESSTHAN32
	sbrs	SysByteTempX,0
	rjmp	ELSE27_1
	lds	SysTemp1,VAL1
	lds	SysTemp2,VAL2
	sub	SysTemp1,SysTemp2
	sts	RESVAL,SysTemp1
	lds	SysTemp1,VAL1_H
	lds	SysTemp2,VAL2_H
	sbc	SysTemp1,SysTemp2
	sts	RESVAL_H,SysTemp1
	lds	SysTemp1,VAL1_U
	lds	SysTemp2,VAL2_U
	sbc	SysTemp1,SysTemp2
	sts	RESVAL_U,SysTemp1
	lds	SysTemp1,VAL1_E
	lds	SysTemp2,VAL2_E
	sbc	SysTemp1,SysTemp2
	sts	RESVAL_E,SysTemp1
	lds	SysValueCopy,RESVAL
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,RESVAL_H
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysStringB,low(RESTEXT)
	ldi	SysStringB_H,high(RESTEXT)
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	call	SYSCOPYSTRING
	rjmp	ENDIF27
ELSE27_1:
	lds	SysTemp1,VAL2
	lds	SysTemp2,VAL1
	sub	SysTemp1,SysTemp2
	sts	RESVAL,SysTemp1
	lds	SysTemp1,VAL2_H
	lds	SysTemp2,VAL1_H
	sbc	SysTemp1,SysTemp2
	sts	RESVAL_H,SysTemp1
	lds	SysTemp1,VAL2_U
	lds	SysTemp2,VAL1_U
	sbc	SysTemp1,SysTemp2
	sts	RESVAL_U,SysTemp1
	lds	SysTemp1,VAL2_E
	lds	SysTemp2,VAL1_E
	sbc	SysTemp1,SysTemp2
	sts	RESVAL_E,SysTemp1
	lds	SysValueCopy,RESVAL
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,RESVAL_H
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysStringB,low(RESTEXT)
	ldi	SysStringB_H,high(RESTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable13<<1)
	ldi	SysReadA_H,high(StringTable13<<1)
	call	SYSREADSTRINGPART
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	call	SYSCOPYSTRINGPART
	ldi	SysStringA,low(RESTEXT)
	ldi	SysStringA_H,high(RESTEXT)
	st	X, SysStringLength
ENDIF27:
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysStringA,low(RESTEXT)
	ldi	SysStringA_H,high(RESTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
	rjmp	SysSelectEnd1
SysSelect1Case3:
	lds	SysCalcTempA,CALC
	cpi	SysCalcTempA,3
	breq	PC + 2
	rjmp	SysSelect1Case4
	lds	SysLONGTempA,VAL1
	lds	SysLONGTempA_H,VAL1_H
	lds	SysLONGTempA_U,VAL1_U
	lds	SysLONGTempA_E,VAL1_E
	lds	SysLONGTempB,VAL2
	lds	SysLONGTempB_H,VAL2_H
	lds	SysLONGTempB_U,VAL2_U
	lds	SysLONGTempB_E,VAL2_E
	call	SYSMULTSUB32
	sts	RESVAL,SysLONGTempX
	sts	RESVAL_H,SysLONGTempX_H
	sts	RESVAL_U,SysLONGTempX_U
	sts	RESVAL_E,SysLONGTempX_E
	lds	SysValueCopy,RESVAL
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,RESVAL_H
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysStringB,low(RESTEXT)
	ldi	SysStringB_H,high(RESTEXT)
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	call	SYSCOPYSTRING
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysStringA,low(RESTEXT)
	ldi	SysStringA_H,high(RESTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
	rjmp	SysSelectEnd1
SysSelect1Case4:
	lds	SysCalcTempA,CALC
	cpi	SysCalcTempA,4
	breq	PC + 2
	rjmp	SysSelectEnd1
	lds	SysLONGTempA,VAL1
	lds	SysLONGTempA_H,VAL1_H
	lds	SysLONGTempA_U,VAL1_U
	lds	SysLONGTempA_E,VAL1_E
	lds	SysLONGTempB,VAL2
	lds	SysLONGTempB_H,VAL2_H
	lds	SysLONGTempB_U,VAL2_U
	lds	SysLONGTempB_E,VAL2_E
	call	SYSDIVSUB32
	sts	RESVAL,SysLONGTempA
	sts	RESVAL_H,SysLONGTempA_H
	sts	RESVAL_U,SysLONGTempA_U
	sts	RESVAL_E,SysLONGTempA_E
	lds	SysValueCopy,RESVAL
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,RESVAL_H
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysStringB,low(RESTEXT)
	ldi	SysStringB_H,high(RESTEXT)
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	call	SYSCOPYSTRING
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysStringA,low(RESTEXT)
	ldi	SysStringA_H,high(RESTEXT)
	call	SYSCOPYSTRINGPART
	ldi	SysStringA,low(TEMPTEXT)
	ldi	SysStringA_H,high(TEMPTEXT)
	st	X, SysStringLength
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_RIGHT
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysStringA,low(RIGHT)
	ldi	SysStringA_H,high(RIGHT)
	call	SYSCOPYSTRING
	ldi	SysValueCopy,22
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,1
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,48
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINECOLOUR,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDBOX_SSD1289
	ldi	SysValueCopy,42
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,20
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,low(TEMPTEXT)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(TEMPTEXT)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,224
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	SIZE,SysValueCopy
	call	PRINT_SSD1289513
SysSelectEnd1:
	ldi	SysStringB,low(TEMPTEXT)
	ldi	SysStringB_H,high(TEMPTEXT)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,0
	sts	CALC,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSRESTEXT_0,SysValueCopy
ENDIF22:
ENDIF17:
ENDIF1:
	ldi	SysWaitTempMS,1
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
	jmp	SysDoLoop_S1
SysDoLoop_E1:
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

ADS7843_GETXY:
	ldi	SysValueCopy,0
	sts	SX,SysValueCopy
	sts	SX_H,SysValueCopy
	sts	SX_U,SysValueCopy
	sts	SX_E,SysValueCopy
	ldi	SysValueCopy,0
	sts	SY,SysValueCopy
	sts	SY_H,SysValueCopy
	sts	SY_U,SysValueCopy
	sts	SY_E,SysValueCopy
	lds	SysValueCopy,PREC
	sts	SysRepeatTemp1,SysValueCopy
	lds	SysCalcTempA,SYSREPEATTEMP1
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd1
SysRepeatLoop1:
	ldi	SysValueCopy,0
	sts	ADS7843_COUNT,SysValueCopy
	ldi	SysValueCopy,0
	sts	T_X,SysValueCopy
	sts	T_X_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	T_Y,SysValueCopy
	sts	T_Y_H,SysValueCopy
	cbi	PORTE,3
	ldi	SysValueCopy,144
	sts	CONTROLBYTE,SysValueCopy
	rcall	ADS7843_WRITE
	lds	SysValueCopy,PORTH
	sbr	SysValueCopy,1<<3
	sts	PORTH,SysValueCopy
	lds	SysTemp3,ADS7843_COUNT
	inc	SysTemp3
	sts	ADS7843_COUNT,SysTemp3
	lds	SysValueCopy,PORTH
	cbr	SysValueCopy,1<<3
	sts	PORTH,SysValueCopy
	lds	SysTemp3,ADS7843_COUNT
	inc	SysTemp3
	sts	ADS7843_COUNT,SysTemp3
	rcall	FN_ADS7843_READ
	lds	SysValueCopy,ADS7843_READ
	sts	T_Y,SysValueCopy
	lds	SysValueCopy,ADS7843_READ_H
	sts	T_Y_H,SysValueCopy
	ldi	SysValueCopy,208
	sts	CONTROLBYTE,SysValueCopy
	rcall	ADS7843_WRITE
	lds	SysValueCopy,PORTH
	sbr	SysValueCopy,1<<3
	sts	PORTH,SysValueCopy
	lds	SysTemp3,ADS7843_COUNT
	inc	SysTemp3
	sts	ADS7843_COUNT,SysTemp3
	lds	SysValueCopy,PORTH
	cbr	SysValueCopy,1<<3
	sts	PORTH,SysValueCopy
	lds	SysTemp3,ADS7843_COUNT
	inc	SysTemp3
	sts	ADS7843_COUNT,SysTemp3
	rcall	FN_ADS7843_READ
	lds	SysValueCopy,ADS7843_READ
	sts	T_X,SysValueCopy
	lds	SysValueCopy,ADS7843_READ_H
	sts	T_X_H,SysValueCopy
	sbi	PORTE,3
	lds	SysTemp3,SX
	lds	SysTemp4,T_X
	add	SysTemp3,SysTemp4
	sts	SX,SysTemp3
	lds	SysTemp3,SX_H
	lds	SysTemp4,T_X_H
	adc	SysTemp3,SysTemp4
	sts	SX_H,SysTemp3
	lds	SysTemp3,SX_U
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	SX_U,SysTemp3
	lds	SysTemp3,SX_E
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	SX_E,SysTemp3
	lds	SysTemp3,SY
	lds	SysTemp4,T_Y
	add	SysTemp3,SysTemp4
	sts	SY,SysTemp3
	lds	SysTemp3,SY_H
	lds	SysTemp4,T_Y_H
	adc	SysTemp3,SysTemp4
	sts	SY_H,SysTemp3
	lds	SysTemp3,SY_U
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	SY_U,SysTemp3
	lds	SysTemp3,SY_E
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	SY_E,SysTemp3
	lds	SysTemp3,SysRepeatTemp1
	dec	SysTemp3
	sts	SysRepeatTemp1,SysTemp3
	breq	PC + 2
	rjmp	SysRepeatLoop1
SysRepeatLoopEnd1:
	lds	SysLONGTempA,SX
	lds	SysLONGTempA_H,SX_H
	lds	SysLONGTempA_U,SX_U
	lds	SysLONGTempA_E,SX_E
	lds	SysLONGTempB,PREC
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	call	SYSDIVSUB32
	mov	SysTemp1,SysLONGTempA
	mov	SysTemp1_H,SysLONGTempA_H
	mov	SysTemp1_U,SysLONGTempA_U
	mov	SysTemp1_E,SysLONGTempA_E
	mov	SysLONGTempA,SysTemp1
	mov	SysLONGTempA_H,SysTemp1_H
	mov	SysLONGTempA_U,SysTemp1_U
	mov	SysLONGTempA_E,SysTemp1_E
	ldi	SysLONGTempB,17
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	call	SYSDIVSUB32
	sts	TP_X,SysLONGTempA
	sts	TP_X_H,SysLONGTempA_H
	ldi	SysTemp5,120
	lds	SysTemp3,TP_X
	sub	SysTemp5,SysTemp3
	mov	SysTemp1,SysTemp5
	ldi	SysTemp5,0
	lds	SysTemp3,TP_X_H
	sbc	SysTemp5,SysTemp3
	mov	SysTemp1_H,SysTemp5
	mov	SysINTEGERTempA,SysTemp1
	mov	SysINTEGERTempA_H,SysTemp1_H
	ldi	SysINTEGERTempB,9
	ldi	SysINTEGERTempB_H,0
	call	SYSDIVSUBINT
	sts	XOFFSET,SysINTEGERTempA
	sts	XOFFSET_H,SysINTEGERTempA_H
	lds	SysTemp3,TP_X
	lds	SysTemp4,XOFFSET
	sub	SysTemp3,SysTemp4
	sts	TP_X,SysTemp3
	lds	SysTemp3,TP_X_H
	lds	SysTemp4,XOFFSET_H
	sbc	SysTemp3,SysTemp4
	sts	TP_X_H,SysTemp3
	lds	SysWORDTempB,TP_X
	lds	SysWORDTempB_H,TP_X_H
	ldi	SysWORDTempA,239
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	rjmp	ENDIF31
	ldi	SysValueCopy,239
	sts	TP_X,SysValueCopy
	ldi	SysValueCopy,0
	sts	TP_X_H,SysValueCopy
ENDIF31:
	lds	SysLONGTempA,SY
	lds	SysLONGTempA_H,SY_H
	lds	SysLONGTempA_U,SY_U
	lds	SysLONGTempA_E,SY_E
	lds	SysLONGTempB,PREC
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	call	SYSDIVSUB32
	mov	SysTemp1,SysLONGTempA
	mov	SysTemp1_H,SysLONGTempA_H
	mov	SysTemp1_U,SysLONGTempA_U
	mov	SysTemp1_E,SysLONGTempA_E
	mov	SysLONGTempA,SysTemp1
	mov	SysLONGTempA_H,SysTemp1_H
	mov	SysLONGTempA_U,SysTemp1_U
	mov	SysLONGTempA_E,SysTemp1_E
	ldi	SysLONGTempB,12
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	call	SYSDIVSUB32
	sts	TP_Y,SysLONGTempA
	sts	TP_Y_H,SysLONGTempA_H
	lds	SysWORDTempB,TP_Y
	lds	SysWORDTempB_H,TP_Y_H
	ldi	SysWORDTempA,63
	ldi	SysWORDTempA_H,1
	call	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	rjmp	ENDIF32
	ldi	SysValueCopy,63
	sts	TP_Y,SysValueCopy
	ldi	SysValueCopy,1
	sts	TP_Y_H,SysValueCopy
ENDIF32:
SysSelect2Case1:
	lds	SysCalcTempA,ORIENTATION_SSD1289
	cpi	SysCalcTempA,4
	brne	SysSelect2Case2
	ldi	SysTemp5,63
	lds	SysTemp3,TP_Y
	sub	SysTemp5,SysTemp3
	sts	TP_Y,SysTemp5
	ldi	SysTemp5,1
	lds	SysTemp3,TP_Y_H
	sbc	SysTemp5,SysTemp3
	sts	TP_Y_H,SysTemp5
	lds	SysINTEGERTempA,TP_Y
	lds	SysINTEGERTempA_H,TP_Y_H
	ldi	SysINTEGERTempB,14
	ldi	SysINTEGERTempB_H,0
	call	SYSDIVSUBINT
	sts	YOFFSET,SysINTEGERTempA
	sts	YOFFSET_H,SysINTEGERTempA_H
	lds	SysTemp3,TP_Y
	lds	SysTemp4,YOFFSET
	add	SysTemp3,SysTemp4
	sts	TP_Y,SysTemp3
	lds	SysTemp3,TP_Y_H
	lds	SysTemp4,YOFFSET_H
	adc	SysTemp3,SysTemp4
	sts	TP_Y_H,SysTemp3
	rjmp	SysSelectEnd2
SysSelect2Case2:
	lds	SysCalcTempA,ORIENTATION_SSD1289
	cpi	SysCalcTempA,2
	brne	SysSelect2Case3
	ldi	SysTemp5,239
	lds	SysTemp3,TP_X
	sub	SysTemp5,SysTemp3
	sts	TP_X,SysTemp5
	ldi	SysTemp5,0
	lds	SysTemp3,TP_X_H
	sbc	SysTemp5,SysTemp3
	sts	TP_X_H,SysTemp5
	lds	SysWORDTempA,TP_Y
	lds	SysWORDTempA_H,TP_Y_H
	ldi	SysWORDTempB,30
	ldi	SysWORDTempB_H,0
	call	SYSMULTSUB16
	mov	SysTemp1,SysWORDTempX
	mov	SysTemp1_H,SysWORDTempX_H
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,63
	ldi	SysWORDTempB_H,1
	call	SYSDIVSUB16
	mov	SysTemp2,SysWORDTempA
	mov	SysTemp2_H,SysWORDTempA_H
	ldi	SysTemp5,30
	sub	SysTemp5,SysTemp2
	mov	SysTemp1,SysTemp5
	ldi	SysTemp5,0
	sbc	SysTemp5,SysTemp2_H
	mov	SysTemp1_H,SysTemp5
	lds	SysTemp3,TP_Y
	sub	SysTemp3,SysTemp1
	sts	TP_Y,SysTemp3
	lds	SysTemp3,TP_Y_H
	sbc	SysTemp3,SysTemp1_H
	sts	TP_Y_H,SysTemp3
	rjmp	SysSelectEnd2
SysSelect2Case3:
	lds	SysCalcTempA,ORIENTATION_SSD1289
	cpi	SysCalcTempA,1
	brne	SysSelect2Case4
	lds	SYSCALCTEMPA,TP_X
	lds	SYSCALCTEMPA_H,TP_X_H
	lds	SYSCALCTEMPB,TP_Y
	lds	SYSCALCTEMPB_H,TP_Y_H
	call	SWAP149
	sts	TP_X,SYSCALCTEMPA
	sts	TP_X_H,SYSCALCTEMPA_H
	sts	TP_Y,SYSCALCTEMPB
	sts	TP_Y_H,SYSCALCTEMPB_H
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,30
	ldi	SysWORDTempB_H,0
	call	SYSMULTSUB16
	mov	SysTemp1,SysWORDTempX
	mov	SysTemp1_H,SysWORDTempX_H
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,63
	ldi	SysWORDTempB_H,1
	call	SYSDIVSUB16
	mov	SysTemp2,SysWORDTempA
	mov	SysTemp2_H,SysWORDTempA_H
	ldi	SysTemp5,30
	sub	SysTemp5,SysTemp2
	mov	SysTemp1,SysTemp5
	ldi	SysTemp5,0
	sbc	SysTemp5,SysTemp2_H
	mov	SysTemp1_H,SysTemp5
	lds	SysTemp3,TP_X
	sub	SysTemp3,SysTemp1
	sts	TP_X,SysTemp3
	lds	SysTemp3,TP_X_H
	sbc	SysTemp3,SysTemp1_H
	sts	TP_X_H,SysTemp3
	rjmp	SysSelectEnd2
SysSelect2Case4:
	lds	SysCalcTempA,ORIENTATION_SSD1289
	cpi	SysCalcTempA,3
	breq	PC + 2
	rjmp	SysSelectEnd2
	lds	SYSCALCTEMPA,TP_X
	lds	SYSCALCTEMPA_H,TP_X_H
	lds	SYSCALCTEMPB,TP_Y
	lds	SYSCALCTEMPB_H,TP_Y_H
	call	SWAP149
	sts	TP_X,SYSCALCTEMPA
	sts	TP_X_H,SYSCALCTEMPA_H
	sts	TP_Y,SYSCALCTEMPB
	sts	TP_Y_H,SYSCALCTEMPB_H
	ldi	SysTemp5,63
	lds	SysTemp3,TP_X
	sub	SysTemp5,SysTemp3
	sts	TP_X,SysTemp5
	ldi	SysTemp5,1
	lds	SysTemp3,TP_X_H
	sbc	SysTemp5,SysTemp3
	sts	TP_X_H,SysTemp5
	ldi	SysTemp5,239
	lds	SysTemp3,TP_Y
	sub	SysTemp5,SysTemp3
	sts	TP_Y,SysTemp5
	ldi	SysTemp5,0
	lds	SysTemp3,TP_Y_H
	sbc	SysTemp5,SysTemp3
	sts	TP_Y_H,SysTemp5
	lds	SysWORDTempA,TP_X
	lds	SysWORDTempA_H,TP_X_H
	ldi	SysWORDTempB,32
	ldi	SysWORDTempB_H,0
	call	SYSMULTSUB16
	mov	SysTemp1,SysWORDTempX
	mov	SysTemp1_H,SysWORDTempX_H
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,63
	ldi	SysWORDTempB_H,1
	call	SYSDIVSUB16
	mov	SysTemp2,SysWORDTempA
	mov	SysTemp2_H,SysWORDTempA_H
	lds	SysTemp3,TP_X
	add	SysTemp3,SysTemp2
	sts	TP_X,SysTemp3
	lds	SysTemp3,TP_X_H
	adc	SysTemp3,SysTemp2_H
	sts	TP_X_H,SysTemp3
SysSelectEnd2:
	ret

;********************************************************************************

ADS7843_INIT:
	cbi	DDRE,5
	cbi	DDRE,4
	sbi	DDRE,3
	lds	SysValueCopy,DDRH
	sbr	SysValueCopy,1<<3
	sts	DDRH,SysValueCopy
	sbi	DDRG,5
	sbi	PORTE,3
	lds	SysValueCopy,PORTH
	sbr	SysValueCopy,1<<3
	sts	PORTH,SysValueCopy
	sbi	PORTG,5
	ldi	SysValueCopy,0
	sts	TP_X,SysValueCopy
	sts	TP_X_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	TP_Y,SysValueCopy
	sts	TP_Y_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	T_X,SysValueCopy
	sts	T_X_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	T_Y,SysValueCopy
	sts	T_Y_H,SysValueCopy
	rjmp	ADS7843_SETPRECISION

;********************************************************************************

FN_ADS7843_READ:
	ldi	SysValueCopy,0
	sts	ADS7843_COUNT,SysValueCopy
	ldi	SysValueCopy,0
	sts	ADS7843_DATA,SysValueCopy
	sts	ADS7843_DATA_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	SysRepeatTemp3,SysValueCopy
SysRepeatLoop3:
	lds	SysValueCopy,ADS7843_DATA
	rol	SysValueCopy
	sts	ADS7843_DATA,SysValueCopy
	lds	SysValueCopy,ADS7843_DATA_H
	rol	SysValueCopy
	sts	ADS7843_DATA_H,SysValueCopy
	lds	SysValueCopy,PORTH
	sbr	SysValueCopy,1<<3
	sts	PORTH,SysValueCopy
	lds	SysTemp3,ADS7843_COUNT
	inc	SysTemp3
	sts	ADS7843_COUNT,SysTemp3
	lds	SysValueCopy,PORTH
	cbr	SysValueCopy,1<<3
	sts	PORTH,SysValueCopy
	lds	SysTemp3,ADS7843_COUNT
	inc	SysTemp3
	sts	ADS7843_COUNT,SysTemp3
	sbis	PINE,5
	rjmp	ENDIF80
	lds	SysTemp3,ADS7843_DATA
	inc	SysTemp3
	sts	ADS7843_DATA,SysTemp3
	lds	SysTemp3,ADS7843_DATA_H
	brne	PC + 2
	inc	SysTemp3
	sts	ADS7843_DATA_H,SysTemp3
ENDIF80:
	lds	SysTemp3,SysRepeatTemp3
	dec	SysTemp3
	sts	SysRepeatTemp3,SysTemp3
	brne	SysRepeatLoop3
SysRepeatLoopEnd3:
	lds	SysValueCopy,ADS7843_DATA
	sts	ADS7843_READ,SysValueCopy
	lds	SysValueCopy,ADS7843_DATA_H
	sts	ADS7843_READ_H,SysValueCopy
	ret

;********************************************************************************

ADS7843_SETPRECISION:
SysSelect7Case1:
	lds	SysCalcTempA,PRECISION
	cpi	SysCalcTempA,1
	brne	SysSelect7Case2
	ldi	SysValueCopy,1
	sts	PREC,SysValueCopy
	rjmp	SysSelectEnd7
SysSelect7Case2:
	lds	SysCalcTempA,PRECISION
	cpi	SysCalcTempA,2
	brne	SysSelect7Case3
	ldi	SysValueCopy,12
	sts	PREC,SysValueCopy
	rjmp	SysSelectEnd7
SysSelect7Case3:
	lds	SysCalcTempA,PRECISION
	cpi	SysCalcTempA,3
	brne	SysSelect7Case4
	ldi	SysValueCopy,27
	sts	PREC,SysValueCopy
	rjmp	SysSelectEnd7
SysSelect7Case4:
	lds	SysCalcTempA,PRECISION
	cpi	SysCalcTempA,4
	brne	SysSelect7Case5
	ldi	SysValueCopy,102
	sts	PREC,SysValueCopy
	rjmp	SysSelectEnd7
SysSelect7Case5:
	ldi	SysValueCopy,12
	sts	PREC,SysValueCopy
SysSelectEnd7:
	ret

;********************************************************************************

ADS7843_WRITE:
	ldi	SysValueCopy,0
	sts	ADS7843_COUNT,SysValueCopy
	lds	SysValueCopy,PORTH
	cbr	SysValueCopy,1<<3
	sts	PORTH,SysValueCopy
	ldi	SysValueCopy,8
	sts	SysRepeatTemp2,SysValueCopy
SysRepeatLoop2:
	lds	SysBitTest,CONTROLBYTE
	sbrs	SysBitTest,7
	rjmp	ELSE79_1
	sbi	PORTG,5
	rjmp	ENDIF79
ELSE79_1:
	cbi	PORTG,5
ENDIF79:
	lds	SysValueCopy,CONTROLBYTE
	rol	SysValueCopy
	sts	CONTROLBYTE,SysValueCopy
	lds	SysValueCopy,PORTH
	cbr	SysValueCopy,1<<3
	sts	PORTH,SysValueCopy
	lds	SysTemp3,ADS7843_COUNT
	inc	SysTemp3
	sts	ADS7843_COUNT,SysTemp3
	lds	SysValueCopy,PORTH
	sbr	SysValueCopy,1<<3
	sts	PORTH,SysValueCopy
	lds	SysTemp3,ADS7843_COUNT
	inc	SysTemp3
	sts	ADS7843_COUNT,SysTemp3
	lds	SysTemp3,SysRepeatTemp2
	dec	SysTemp3
	sts	SysRepeatTemp2,SysTemp3
	brne	SysRepeatLoop2
SysRepeatLoopEnd2:
	ret

;********************************************************************************

CREATEBUTTON:
	lds	SysValueCopy,BX1
	sts	RX1,SysValueCopy
	lds	SysValueCopy,BX1_H
	sts	RX1_H,SysValueCopy
	lds	SysValueCopy,BY1
	sts	RY1,SysValueCopy
	lds	SysValueCopy,BY1_H
	sts	RY1_H,SysValueCopy
	lds	SysValueCopy,BX2
	sts	RX2,SysValueCopy
	lds	SysValueCopy,BX2_H
	sts	RX2_H,SysValueCopy
	lds	SysValueCopy,BY2
	sts	RY2,SysValueCopy
	lds	SysValueCopy,BY2_H
	sts	RY2_H,SysValueCopy
	lds	SysValueCopy,FILLCOLOR
	sts	COLOR,SysValueCopy
	lds	SysValueCopy,FILLCOLOR_H
	sts	COLOR_H,SysValueCopy
	rcall	FILLROUNDRECT33
	lds	SysValueCopy,BX1
	sts	RX1,SysValueCopy
	lds	SysValueCopy,BX1_H
	sts	RX1_H,SysValueCopy
	lds	SysValueCopy,BY1
	sts	RY1,SysValueCopy
	lds	SysValueCopy,BY1_H
	sts	RY1_H,SysValueCopy
	lds	SysValueCopy,BX2
	sts	RX2,SysValueCopy
	lds	SysValueCopy,BX2_H
	sts	RX2_H,SysValueCopy
	lds	SysValueCopy,BY2
	sts	RY2,SysValueCopy
	lds	SysValueCopy,BY2_H
	sts	RY2_H,SysValueCopy
	lds	SysValueCopy,BORDERCOLOR
	sts	COLOR,SysValueCopy
	lds	SysValueCopy,BORDERCOLOR_H
	sts	COLOR_H,SysValueCopy
	call	ROUNDRECT31
	lds	SysStringA,SysPRINTDATAHandler
	lds	SysStringA_H,SysPRINTDATAHandler_H
	lds	SysTemp2,BX1
	lds	SysTemp3,BX2
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,BX1_H
	lds	SysTemp3,BX2_H
	adc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SYSDIVSUB16
	mov	SysTemp2,SysWORDTempA
	mov	SysTemp2_H,SysWORDTempA_H
	ld	SysBYTETempA,X
	ldi	SysBYTETempB,6
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp3,SysByteTempX
	mov	SysBYTETempA,SysTemp3
	lds	SysBYTETempB,SIZE
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp4,SysByteTempX
	mov	SysTemp1,SysTemp4
	lsr	SysTemp1
	sub	SysTemp2,SysTemp1
	sts	XCALC1,SysTemp2
	ldi	SysTemp5,0
	sbc	SysTemp2_H,SysTemp5
	sts	XCALC1_H,SysTemp2_H
	lds	SysTemp3,BY1
	lds	SysTemp4,BY2
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,BY1_H
	lds	SysTemp4,BY2_H
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SYSDIVSUB16
	mov	SysTemp2,SysWORDTempA
	mov	SysTemp2_H,SysWORDTempA_H
	lds	SysBYTETempA,SIZE
	ldi	SysBYTETempB,4
	mul	SysByteTempA,SysByteTempB
	sub	SysTemp2,SysByteTempX
	sts	YCALC1,SysTemp2
	ldi	SysTemp5,0
	sbc	SysTemp2_H,SysTemp5
	sts	YCALC1_H,SysTemp2_H
	lds	SysValueCopy,GLCDBACKGROUND
	sts	TEMPCOLOR1,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	TEMPCOLOR1_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	TEMPCOLOR2,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	TEMPCOLOR2_H,SysValueCopy
	lds	SysValueCopy,FILLCOLOR
	sts	GLCDBACKGROUND,SysValueCopy
	lds	SysValueCopy,FILLCOLOR_H
	sts	GLCDBACKGROUND_H,SysValueCopy
	lds	SysValueCopy,XCALC1
	sts	PRINTLOCX,SysValueCopy
	lds	SysValueCopy,XCALC1_H
	sts	PRINTLOCX_H,SysValueCopy
	lds	SysValueCopy,YCALC1
	sts	PRINTLOCY,SysValueCopy
	lds	SysValueCopy,YCALC1_H
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,SysPRINTDATAHandler
	sts	SysPRINTDATAHandler,SysValueCopy
	lds	SysValueCopy,SysPRINTDATAHandler_H
	sts	SysPRINTDATAHandler_H,SysValueCopy
	lds	SysValueCopy,FCOLOR
	sts	GLCDFOREGROUND,SysValueCopy
	lds	SysValueCopy,FCOLOR_H
	sts	GLCDFOREGROUND_H,SysValueCopy
	call	PRINT_SSD1289513
	lds	SysValueCopy,TEMPCOLOR1
	sts	GLCDBACKGROUND,SysValueCopy
	lds	SysValueCopy,TEMPCOLOR1_H
	sts	GLCDBACKGROUND_H,SysValueCopy
	lds	SysValueCopy,TEMPCOLOR2
	sts	GLCDFOREGROUND,SysValueCopy
	lds	SysValueCopy,TEMPCOLOR2_H
	sts	GLCDFOREGROUND_H,SysValueCopy
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

FILLEDBOX_SSD1289:
	lds	SysWORDTempB,LINEX1
	lds	SysWORDTempB_H,LINEX1_H
	lds	SysWORDTempA,LINEX2
	lds	SysWORDTempA_H,LINEX2_H
	call	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	rjmp	ENDIF57
	lds	SysValueCopy,LINEX1
	sts	GLCDTEMP,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	GLCDTEMP_H,SysValueCopy
	lds	SysValueCopy,LINEX2
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,LINEX2_H
	sts	LINEX1_H,SysValueCopy
	lds	SysValueCopy,GLCDTEMP
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDTEMP_H
	sts	LINEX2_H,SysValueCopy
ENDIF57:
	lds	SysWORDTempB,LINEY1
	lds	SysWORDTempB_H,LINEY1_H
	lds	SysWORDTempA,LINEY2
	lds	SysWORDTempA_H,LINEY2_H
	call	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	rjmp	ENDIF58
	lds	SysValueCopy,LINEY1
	sts	GLCDTEMP,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDTEMP_H,SysValueCopy
	lds	SysValueCopy,LINEY2
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,LINEY2_H
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,GLCDTEMP
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDTEMP_H
	sts	LINEY2_H,SysValueCopy
ENDIF58:
	lds	SysValueCopy,LINEX1
	sts	DRAWLINE,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	DRAWLINE_H,SysValueCopy
SysForLoop5:
	lds	SysValueCopy,LINEY1
	sts	GLCDTEMP,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDTEMP_H,SysValueCopy
SysForLoop6:
	lds	SysValueCopy,DRAWLINE
	sts	PX1,SysValueCopy
	lds	SysValueCopy,DRAWLINE_H
	sts	PX1_H,SysValueCopy
	lds	SysValueCopy,GLCDTEMP
	sts	PY1,SysValueCopy
	lds	SysValueCopy,GLCDTEMP_H
	sts	PY1_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	COLOR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	COLOR_H,SysValueCopy
	call	PSET_SSD1289
	lds	SysTemp3,LINEY2
	lds	SysTemp4,GLCDTEMP
	sub	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,LINEY2_H
	lds	SysTemp4,GLCDTEMP_H
	sbc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,0
	call	SYSCOMPEQUAL16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF59
	lds	SysTemp3,GLCDTEMP
	inc	SysTemp3
	sts	GLCDTEMP,SysTemp3
	lds	SysTemp3,GLCDTEMP_H
	brne	PC + 2
	inc	SysTemp3
	sts	GLCDTEMP_H,SysTemp3
	rjmp	SysForLoop6
ENDIF59:
SysForLoopEnd6:
	lds	SysTemp3,LINEX2
	lds	SysTemp4,DRAWLINE
	sub	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,LINEX2_H
	lds	SysTemp4,DRAWLINE_H
	sbc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,0
	call	SYSCOMPEQUAL16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF60
	lds	SysTemp3,DRAWLINE
	inc	SysTemp3
	sts	DRAWLINE,SysTemp3
	lds	SysTemp3,DRAWLINE_H
	brne	PC + 2
	inc	SysTemp3
	sts	DRAWLINE_H,SysTemp3
	rjmp	SysForLoop5
ENDIF60:
SysForLoopEnd5:
	ret

;********************************************************************************

FILLROUNDRECT33:
	lds	SysWORDTempB,RX1
	lds	SysWORDTempB_H,RX1_H
	lds	SysWORDTempA,RX2
	lds	SysWORDTempA_H,RX2_H
	call	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	rjmp	ENDIF75
	lds	SYSCALCTEMPA,RX1
	lds	SYSCALCTEMPA_H,RX1_H
	lds	SYSCALCTEMPB,RX2
	lds	SYSCALCTEMPB_H,RX2_H
	call	SWAP149
	sts	RX1,SYSCALCTEMPA
	sts	RX1_H,SYSCALCTEMPA_H
	sts	RX2,SYSCALCTEMPB
	sts	RX2_H,SYSCALCTEMPB_H
ENDIF75:
	lds	SysWORDTempB,RY1
	lds	SysWORDTempB_H,RY1_H
	lds	SysWORDTempA,RY2
	lds	SysWORDTempA_H,RY2_H
	call	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	rjmp	ENDIF76
	lds	SYSCALCTEMPA,RY1
	lds	SYSCALCTEMPA_H,RY1_H
	lds	SYSCALCTEMPB,RY2
	lds	SYSCALCTEMPB_H,RY2_H
	call	SWAP149
	sts	RY1,SYSCALCTEMPA
	sts	RY1_H,SYSCALCTEMPA_H
	sts	RY2,SYSCALCTEMPB
	sts	RY2_H,SYSCALCTEMPB_H
ENDIF76:
	lds	SysTemp3,RX2
	lds	SysTemp4,RX1
	sub	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,RX2_H
	lds	SysTemp4,RX1_H
	sbc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	mov	SysWORDTempB,SysTemp1
	mov	SysWORDTempB_H,SysTemp1_H
	ldi	SysWORDTempA,4
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	mov	SysTemp3,SysByteTempX
	lds	SysTemp4,RY2
	lds	SysTemp2,RY1
	sub	SysTemp4,SysTemp2
	mov	SysTemp1,SysTemp4
	lds	SysTemp4,RY2_H
	lds	SysTemp2,RY1_H
	sbc	SysTemp4,SysTemp2
	mov	SysTemp1_H,SysTemp4
	mov	SysWORDTempB,SysTemp1
	mov	SysWORDTempB_H,SysTemp1_H
	ldi	SysWORDTempA,4
	ldi	SysWORDTempA_H,0
	call	SYSCOMPLESSTHAN16
	mov	SysTemp4,SysByteTempX
	and	SysTemp4,SysTemp3
	mov	SysTemp1,SysTemp4
	sbrs	SysTemp1,0
	rjmp	ENDIF77
	ldi	SysValueCopy,0
	sts	FRI,SysValueCopy
	sts	FRI_H,SysValueCopy
SysForLoop12:
SysSelect6Case1:
	lds	SysWORDTempA,FRI
	lds	SysWORDTempA_H,FRI_H
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,0
	call	SYSCOMPEQUAL16
	sbrs	SysByteTempX,0
	rjmp	SysSelect6Case2
	lds	SysTemp3,RX1
	ldi	SysTemp5,3
	add	SysTemp3,SysTemp5
	sts	LINEX1,SysTemp3
	lds	SysTemp3,RX1_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	LINEX1_H,SysTemp3
	lds	SysValueCopy,RY1
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,RY1_H
	sts	LINEY1_H,SysValueCopy
	lds	SysTemp3,RX2
	ldi	SysTemp5,3
	sub	SysTemp3,SysTemp5
	sts	LINEX2,SysTemp3
	lds	SysTemp3,RX2_H
	ldi	SysTemp5,0
	sbc	SysTemp3,SysTemp5
	sts	LINEX2_H,SysTemp3
	lds	SysValueCopy,RY1
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,RY1_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,COLOR
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
	lds	SysTemp3,RX1
	ldi	SysTemp5,3
	add	SysTemp3,SysTemp5
	sts	LINEX1,SysTemp3
	lds	SysTemp3,RX1_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	LINEX1_H,SysTemp3
	lds	SysValueCopy,RY2
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,RY2_H
	sts	LINEY1_H,SysValueCopy
	lds	SysTemp3,RX2
	ldi	SysTemp5,3
	sub	SysTemp3,SysTemp5
	sts	LINEX2,SysTemp3
	lds	SysTemp3,RX2_H
	ldi	SysTemp5,0
	sbc	SysTemp3,SysTemp5
	sts	LINEX2_H,SysTemp3
	lds	SysValueCopy,RY2
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,RY2_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,COLOR
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
	rjmp	SysSelectEnd6
SysSelect6Case2:
	lds	SysWORDTempA,FRI
	lds	SysWORDTempA_H,FRI_H
	ldi	SysWORDTempB,1
	ldi	SysWORDTempB_H,0
	call	SYSCOMPEQUAL16
	sbrs	SysByteTempX,0
	rjmp	SysSelect6Case3
	lds	SysTemp3,RX1
	ldi	SysTemp5,2
	add	SysTemp3,SysTemp5
	sts	LINEX1,SysTemp3
	lds	SysTemp3,RX1_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	LINEX1_H,SysTemp3
	lds	SysTemp3,RY1
	ldi	SysTemp5,1
	add	SysTemp3,SysTemp5
	sts	LINEY1,SysTemp3
	lds	SysTemp3,RY1_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	LINEY1_H,SysTemp3
	lds	SysTemp3,RX2
	ldi	SysTemp5,2
	sub	SysTemp3,SysTemp5
	sts	LINEX2,SysTemp3
	lds	SysTemp3,RX2_H
	ldi	SysTemp5,0
	sbc	SysTemp3,SysTemp5
	sts	LINEX2_H,SysTemp3
	lds	SysTemp3,RY1
	ldi	SysTemp5,1
	add	SysTemp3,SysTemp5
	sts	LINEY2,SysTemp3
	lds	SysTemp3,RY1_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	LINEY2_H,SysTemp3
	lds	SysValueCopy,COLOR
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
	lds	SysTemp3,RX1
	ldi	SysTemp5,2
	add	SysTemp3,SysTemp5
	sts	LINEX1,SysTemp3
	lds	SysTemp3,RX1_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	LINEX1_H,SysTemp3
	lds	SysTemp3,RY2
	ldi	SysTemp5,1
	sub	SysTemp3,SysTemp5
	sts	LINEY1,SysTemp3
	lds	SysTemp3,RY2_H
	ldi	SysTemp5,0
	sbc	SysTemp3,SysTemp5
	sts	LINEY1_H,SysTemp3
	lds	SysTemp3,RX2
	ldi	SysTemp5,1
	sub	SysTemp3,SysTemp5
	sts	LINEX2,SysTemp3
	lds	SysTemp3,RX2_H
	ldi	SysTemp5,0
	sbc	SysTemp3,SysTemp5
	sts	LINEX2_H,SysTemp3
	lds	SysTemp3,RY2
	ldi	SysTemp5,1
	sub	SysTemp3,SysTemp5
	sts	LINEY2,SysTemp3
	lds	SysTemp3,RY2_H
	ldi	SysTemp5,0
	sbc	SysTemp3,SysTemp5
	sts	LINEY2_H,SysTemp3
	lds	SysValueCopy,COLOR
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
	rjmp	SysSelectEnd6
SysSelect6Case3:
	lds	SysWORDTempA,FRI
	lds	SysWORDTempA_H,FRI_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SYSCOMPEQUAL16
	sbrs	SysByteTempX,0
	rjmp	SysSelect6Case4
	lds	SysTemp3,RX1
	ldi	SysTemp5,1
	add	SysTemp3,SysTemp5
	sts	LINEX1,SysTemp3
	lds	SysTemp3,RX1_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	LINEX1_H,SysTemp3
	lds	SysTemp3,RY1
	ldi	SysTemp5,2
	add	SysTemp3,SysTemp5
	sts	LINEY1,SysTemp3
	lds	SysTemp3,RY1_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	LINEY1_H,SysTemp3
	lds	SysTemp3,RX2
	ldi	SysTemp5,1
	sub	SysTemp3,SysTemp5
	sts	LINEX2,SysTemp3
	lds	SysTemp3,RX2_H
	ldi	SysTemp5,0
	sbc	SysTemp3,SysTemp5
	sts	LINEX2_H,SysTemp3
	lds	SysTemp3,RY1
	ldi	SysTemp5,2
	add	SysTemp3,SysTemp5
	sts	LINEY2,SysTemp3
	lds	SysTemp3,RY1_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	LINEY2_H,SysTemp3
	lds	SysValueCopy,COLOR
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
	lds	SysTemp3,RX1
	ldi	SysTemp5,1
	add	SysTemp3,SysTemp5
	sts	LINEX1,SysTemp3
	lds	SysTemp3,RX1_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	LINEX1_H,SysTemp3
	lds	SysTemp3,RY2
	ldi	SysTemp5,2
	sub	SysTemp3,SysTemp5
	sts	LINEY1,SysTemp3
	lds	SysTemp3,RY2_H
	ldi	SysTemp5,0
	sbc	SysTemp3,SysTemp5
	sts	LINEY1_H,SysTemp3
	lds	SysTemp3,RX2
	ldi	SysTemp5,1
	sub	SysTemp3,SysTemp5
	sts	LINEX2,SysTemp3
	lds	SysTemp3,RX2_H
	ldi	SysTemp5,0
	sbc	SysTemp3,SysTemp5
	sts	LINEX2_H,SysTemp3
	lds	SysTemp3,RY2
	ldi	SysTemp5,2
	sub	SysTemp3,SysTemp5
	sts	LINEY2,SysTemp3
	lds	SysTemp3,RY2_H
	ldi	SysTemp5,0
	sbc	SysTemp3,SysTemp5
	sts	LINEY2_H,SysTemp3
	lds	SysValueCopy,COLOR
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
	rjmp	SysSelectEnd6
SysSelect6Case4:
	lds	SysValueCopy,RX1
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,RX1_H
	sts	LINEX1_H,SysValueCopy
	lds	SysTemp3,RY1
	lds	SysTemp4,FRI
	add	SysTemp3,SysTemp4
	sts	LINEY1,SysTemp3
	lds	SysTemp3,RY1_H
	lds	SysTemp4,FRI_H
	adc	SysTemp3,SysTemp4
	sts	LINEY1_H,SysTemp3
	lds	SysValueCopy,RX2
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,RX2_H
	sts	LINEX2_H,SysValueCopy
	lds	SysTemp3,RY1
	lds	SysTemp4,FRI
	add	SysTemp3,SysTemp4
	sts	LINEY2,SysTemp3
	lds	SysTemp3,RY1_H
	lds	SysTemp4,FRI_H
	adc	SysTemp3,SysTemp4
	sts	LINEY2_H,SysTemp3
	lds	SysValueCopy,COLOR
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
	lds	SysValueCopy,RX1
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,RX1_H
	sts	LINEX1_H,SysValueCopy
	lds	SysTemp3,RY2
	lds	SysTemp4,FRI
	sub	SysTemp3,SysTemp4
	sts	LINEY1,SysTemp3
	lds	SysTemp3,RY2_H
	lds	SysTemp4,FRI_H
	sbc	SysTemp3,SysTemp4
	sts	LINEY1_H,SysTemp3
	lds	SysValueCopy,RX2
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,RX2_H
	sts	LINEX2_H,SysValueCopy
	lds	SysTemp3,RY2
	lds	SysTemp4,FRI
	sub	SysTemp3,SysTemp4
	sts	LINEY2,SysTemp3
	lds	SysTemp3,RY2_H
	lds	SysTemp4,FRI_H
	sbc	SysTemp3,SysTemp4
	sts	LINEY2_H,SysTemp3
	lds	SysValueCopy,COLOR
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	LINECOLOUR_H,SysValueCopy
	call	LINE
SysSelectEnd6:
	lds	SysTemp3,RY2
	lds	SysTemp4,RY1
	sub	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,RY2_H
	lds	SysTemp4,RY1_H
	sbc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SYSDIVSUB16
	mov	SysTemp2,SysWORDTempA
	mov	SysTemp2_H,SysWORDTempA_H
	lds	SysTemp3,FRI
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp3,FRI_H
	sbc	SysTemp2_H,SysTemp3
	mov	SysTemp1_H,SysTemp2_H
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,0
	call	SYSCOMPEQUAL16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF78
	lds	SysTemp3,FRI
	inc	SysTemp3
	sts	FRI,SysTemp3
	lds	SysTemp3,FRI_H
	brne	PC + 2
	inc	SysTemp3
	sts	FRI_H,SysTemp3
	rjmp	SysForLoop12
ENDIF78:
SysForLoopEnd12:
ENDIF77:
	ret

;********************************************************************************

GLCDCHARCOL3EXTENDED1:
	cpi	SysStringA, 240
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TABLEGLCDCHARCOL3EXTENDED1<<1)
	ldi	SysReadA_H, high(TABLEGLCDCHARCOL3EXTENDED1<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TABLEGLCDCHARCOL3EXTENDED1:
	.DB	239,0,16,12,10,136,34,56,32,8,32,16,16,128,128,64,4,0,0,0,40,72,70,108,0,0,0,40
	.DB	16,0,16,0,64,124,0,132,130,48,78,120,6,108,12,0,0,16,40,0,4,100,248,254,124,254
	.DB	254,254,124,254,0,64,254,254,254,254,124,254,124,254,76,2,126,62,126,198,14,194
	.DB	0,4,0,8,128,0,64,254,112,112,112,16,16,254,0,64,254,0,248,248,112,248,16,248
	.DB	144,16,120,56,120,136,24,136,0,0,0,32,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,248,254,254,248,254,194,254,124,0,254,248,254,254,130,124,254,254,0
	.DB	198,2,14,56,198,14,188,0,0,56,40,124,0,0,56,254,4,48,40,1,124,48,0,124,64,252
	.DB	28,0,56,4,248,24,56,4,60,56,68,60,60,0,60,56,60,60

;********************************************************************************

GLCDCHARCOL4EXTENDED1:
	cpi	SysStringA, 240
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TABLEGLCDCHARCOL4EXTENDED1<<1)
	ldi	SysReadA_H, high(TABLEGLCDCHARCOL4EXTENDED1<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TABLEGLCDCHARCOL4EXTENDED1:
	.DB	239,254,56,10,6,204,102,124,112,4,64,16,56,136,162,112,28,0,0,14,254,84,38,146
	.DB	10,56,130,16,16,160,16,192,32,162,132,194,130,40,138,148,2,146,146,108,172,40
	.DB	40,130,2,146,36,146,130,130,146,18,130,16,130,128,16,128,4,8,130,18,130,18,146,2
	.DB	128,64,128,40,16,162,254,8,130,4,128,2,168,144,136,136,168,252,168,16,144,128
	.DB	32,130,8,16,136,40,40,16,168,124,128,64,128,80,160,200,16,0,130,16,68,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,36,146,2,132,146,162,16,146,130,16,4,4
	.DB	8,146,130,2,18,0,170,2,16,68,40,16,194,0,0,68,84,8,0,0,68,73,104,73,84,25,8,74
	.DB	0,16,50,64,32,1,68,124,36,36,68,4,64,68,40,64,64,1,65,68,64,64

;********************************************************************************

GLCDCHARCOL5EXTENDED1:
	cpi	SysStringA, 240
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TABLEGLCDCHARCOL5EXTENDED1<<1)
	ldi	SysReadA_H, high(TABLEGLCDCHARCOL5EXTENDED1<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TABLEGLCDCHARCOL5EXTENDED1:
	.DB	239,124,124,0,0,238,238,124,168,254,254,84,84,148,148,124,124,0,158,0,40,254,16,170
	.DB	6,68,68,124,124,96,16,192,16,146,254,162,138,36,138,146,226,146,146,108,108,68
	.DB	40,68,162,242,34,146,130,130,146,18,146,16,254,130,40,128,24,16,130,18,162,50
	.DB	146,254,128,128,112,16,224,146,130,16,130,2,128,4,168,136,136,136,168,18,168,8
	.DB	250,136,80,254,240,8,136,40,40,8,168,144,128,128,96,32,160,168,108,254,108,16
	.DB	66,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34,146,2,130,146,146,16,146
	.DB	254,40,2,24,16,146,130,2,18,0,146,254,224,254,16,254,2,0,0,69,84,5,61,0,68,73
	.DB	144,75,84,165,4,77,60,40,9,64,64,149,68,4,36,164,68,124,64,254,16,248,56,60,64,69
	.DB	66,58

;********************************************************************************

GLCDCHARCOL6EXTENDED1:
	cpi	SysStringA, 240
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TABLEGLCDCHARCOL6EXTENDED1<<1)
	ldi	SysReadA_H, high(TABLEGLCDCHARCOL6EXTENDED1<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TABLEGLCDCHARCOL6EXTENDED1:
	.DB	239,56,254,12,10,204,102,124,32,4,64,56,16,162,136,112,28,0,0,14,254,84,200,68
	.DB	0,130,56,16,16,0,16,0,8,138,128,146,150,254,138,146,18,146,82,0,0,130,40,40,18,130
	.DB	36,146,130,68,146,18,146,16,130,126,68,128,4,32,130,18,66,82,146,2,128,64,128,40
	.DB	16,138,130,32,254,4,128,8,168,136,136,144,168,2,168,8,128,122,136,128,8,8,136,40
	.DB	48,8,168,128,64,64,128,80,160,152,130,0,16,32,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,36,146,2,132,146,138,16,146,130,68,4,4,32,146,130,2,18,0
	.DB	130,2,16,68,40,16,194,0,0,56,85,4,64,0,56,78,104,77,84,67,4,73,64,68,9,32,32,171
	.DB	68,124,36,164,76,4,64,68,40,64,64,65,65,68,65,65

;********************************************************************************

GLCDCHARCOL7EXTENDED1:
	cpi	SysStringA, 240
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TABLEGLCDCHARCOL7EXTENDED1<<1)
	ldi	SysReadA_H, high(TABLEGLCDCHARCOL7EXTENDED1<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TABLEGLCDCHARCOL7EXTENDED1:
	.DB	239,16,0,10,6,136,34,56,62,8,32,16,16,128,128,64,4,0,0,0,40,36,196,160,0,0,0,40
	.DB	16,0,16,0,4,124,0,140,98,32,114,96,14,108,60,0,0,0,40,16,12,124,248,108,68,56
	.DB	130,2,244,254,0,2,130,128,254,254,124,12,188,140,100,2,126,62,126,198,14,134,0,64
	.DB	0,8,128,0,240,112,64,254,48,4,120,240,0,0,0,0,240,240,112,16,248,16,64,64,248,56
	.DB	120,136,120,136,0,0,0,16,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	248,108,2,248,130,134,254,124,0,130,248,254,254,130,124,254,12,0,130,2,14,56
	.DB	198,14,188,0,0,68,68,120,32,0,68,48,4,49,68,1,120,62,32,0,126,124,28,65,56,4,24,72
	.DB	52,4,60,56,68,60,60,32,60,56,60,60

;********************************************************************************

GLCDCLS_SSD1289:
	cbi	PORTG,1
	ldi	SysValueCopy,68
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,239
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,69
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,70
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,78
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,79
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,34
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	call	WRITE_COMMAND_SSD1289
	lds	SysValueCopy,GLCDBACKGROUND
	sts	WDATA,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	WDATA_H,SysValueCopy
	call	WRITE_DATA_SSD1289
	ldi	SysValueCopy,255
	sts	COUNTI,SysValueCopy
	sts	COUNTI_H,SysValueCopy
SysForLoop3:
	lds	SysTemp3,COUNTI
	inc	SysTemp3
	sts	COUNTI,SysTemp3
	lds	SysTemp3,COUNTI_H
	brne	PC + 2
	inc	SysTemp3
	sts	COUNTI_H,SysTemp3
	ldi	SysValueCopy,255
	sts	COUNTJ,SysValueCopy
	sts	COUNTJ_H,SysValueCopy
SysForLoop4:
	lds	SysTemp3,COUNTJ
	inc	SysTemp3
	sts	COUNTJ,SysTemp3
	lds	SysTemp3,COUNTJ_H
	brne	PC + 2
	inc	SysTemp3
	sts	COUNTJ_H,SysTemp3
	cbi	PORTG,2
	sbi	PORTG,2
	lds	SysWORDTempA,COUNTJ
	lds	SysWORDTempA_H,COUNTJ_H
	ldi	SysWORDTempB,239
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop4
SysForLoopEnd4:
	lds	SysWORDTempA,COUNTI
	lds	SysWORDTempA_H,COUNTI_H
	ldi	SysWORDTempB,63
	ldi	SysWORDTempB_H,1
	call	SYSCOMPLESSTHAN16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop3
SysForLoopEnd3:
	sbi	PORTG,1
	ret

;********************************************************************************

GLCDDRAWCHAR_SSD1289:
	lds	SysTemp3,CHARCODE
	ldi	SysTemp5,15
	sub	SysTemp3,SysTemp5
	sts	CHARCODE,SysTemp3
	ldi	SysValueCopy,0
	sts	CHARCOL,SysValueCopy
	sts	CHARCOL_H,SysValueCopy
	lds	SysBYTETempA,CHARCODE
	ldi	SysBYTETempB,178
	call	SYSCOMPLESSTHAN
	com	SysByteTempX
	mov	SysTemp3,SysByteTempX
	lds	SysBYTETempB,CHARCODE
	ldi	SysBYTETempA,202
	call	SYSCOMPLESSTHAN
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	and	SysTemp1,SysTemp3
	mov	SysTemp4,SysTemp1
	sbrs	SysTemp4,0
	rjmp	ENDIF64
	lds	SysTemp3,CHARLOCY
	ldi	SysTemp5,1
	sub	SysTemp3,SysTemp5
	sts	CHARLOCY,SysTemp3
	lds	SysTemp3,CHARLOCY_H
	ldi	SysTemp5,0
	sbc	SysTemp3,SysTemp5
	sts	CHARLOCY_H,SysTemp3
ENDIF64:
	ldi	SysValueCopy,0
	sts	CURRCHARCOL,SysValueCopy
SysForLoop8:
	lds	SysTemp3,CURRCHARCOL
	inc	SysTemp3
	sts	CURRCHARCOL,SysTemp3
SysSelect5Case1:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,1
	brne	SysSelect5Case2
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL3EXTENDED1
	sts	CURRCHARVAL,SysByteTempX
	rjmp	SysSelectEnd5
SysSelect5Case2:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,2
	brne	SysSelect5Case3
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL4EXTENDED1
	sts	CURRCHARVAL,SysByteTempX
	rjmp	SysSelectEnd5
SysSelect5Case3:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,3
	brne	SysSelect5Case4
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL5EXTENDED1
	sts	CURRCHARVAL,SysByteTempX
	rjmp	SysSelectEnd5
SysSelect5Case4:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,4
	brne	SysSelect5Case5
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL6EXTENDED1
	sts	CURRCHARVAL,SysByteTempX
	rjmp	SysSelectEnd5
SysSelect5Case5:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,5
	brne	SysSelectEnd5
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL7EXTENDED1
	sts	CURRCHARVAL,SysByteTempX
SysSelectEnd5:
	ldi	SysValueCopy,0
	sts	CHARROW,SysValueCopy
	sts	CHARROW_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CURRCHARROW,SysValueCopy
SysForLoop9:
	lds	SysTemp3,CURRCHARROW
	inc	SysTemp3
	sts	CURRCHARROW,SysTemp3
	ldi	SysValueCopy,0
	sts	CHARCOLS,SysValueCopy
	ldi	SysValueCopy,1
	sts	COL,SysValueCopy
SysForLoop10:
	lds	SysTemp3,CHARCOLS
	inc	SysTemp3
	sts	CHARCOLS,SysTemp3
	ldi	SysValueCopy,0
	sts	CHARROWS,SysValueCopy
	ldi	SysValueCopy,1
	sts	ROW,SysValueCopy
SysForLoop11:
	lds	SysTemp3,CHARROWS
	inc	SysTemp3
	sts	CHARROWS,SysTemp3
	lds	SysBitTest,CURRCHARVAL
	sbrs	SysBitTest,0
	rjmp	ELSE65_1
	lds	SysTemp3,CHARLOCX
	lds	SysTemp4,CHARCOL
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,CHARLOCX_H
	lds	SysTemp4,CHARCOL_H
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,CHARCOLS
	add	SysTemp1,SysTemp3
	sts	PX1,SysTemp1
	ldi	SysTemp5,0
	adc	SysTemp1_H,SysTemp5
	sts	PX1_H,SysTemp1_H
	lds	SysTemp3,CHARLOCY
	lds	SysTemp4,CHARROW
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,CHARLOCY_H
	lds	SysTemp4,CHARROW_H
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,CHARROWS
	add	SysTemp1,SysTemp3
	sts	PY1,SysTemp1
	ldi	SysTemp5,0
	adc	SysTemp1_H,SysTemp5
	sts	PY1_H,SysTemp1_H
	lds	SysValueCopy,LINECOLOUR
	sts	COLOR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	COLOR_H,SysValueCopy
	rcall	PSET_SSD1289
	rjmp	ENDIF65
ELSE65_1:
	lds	SysTemp3,CHARLOCX
	lds	SysTemp4,CHARCOL
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,CHARLOCX_H
	lds	SysTemp4,CHARCOL_H
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,CHARCOLS
	add	SysTemp1,SysTemp3
	sts	PX1,SysTemp1
	ldi	SysTemp5,0
	adc	SysTemp1_H,SysTemp5
	sts	PX1_H,SysTemp1_H
	lds	SysTemp3,CHARLOCY
	lds	SysTemp4,CHARROW
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,CHARLOCY_H
	lds	SysTemp4,CHARROW_H
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,CHARROWS
	add	SysTemp1,SysTemp3
	sts	PY1,SysTemp1
	ldi	SysTemp5,0
	adc	SysTemp1_H,SysTemp5
	sts	PY1_H,SysTemp1_H
	lds	SysValueCopy,GLCDBACKGROUND
	sts	COLOR,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	COLOR_H,SysValueCopy
	rcall	PSET_SSD1289
ENDIF65:
	lds	SysTemp4,GLCDFNTDEFAULTSIZE
	lds	SysTemp1,ROW
	sub	SysTemp4,SysTemp1
	mov	SysTemp3,SysTemp4
	mov	SysBYTETempA,SysTemp3
	ldi	SysBYTETempB,0
	call	SYSCOMPEQUAL
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF66
	lds	SysTemp3,ROW
	inc	SysTemp3
	sts	ROW,SysTemp3
	rjmp	SysForLoop11
ENDIF66:
SysForLoopEnd11:
	lds	SysTemp4,GLCDFNTDEFAULTSIZE
	lds	SysTemp1,COL
	sub	SysTemp4,SysTemp1
	mov	SysTemp3,SysTemp4
	mov	SysBYTETempA,SysTemp3
	ldi	SysBYTETempB,0
	call	SYSCOMPEQUAL
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF67
	lds	SysTemp3,COL
	inc	SysTemp3
	sts	COL,SysTemp3
	rjmp	SysForLoop10
ENDIF67:
SysForLoopEnd10:
	lds	SysValueCopy,CURRCHARVAL
	ror	SysValueCopy
	sts	CURRCHARVAL,SysValueCopy
	lds	SysTemp3,CHARROW
	lds	SysTemp4,GLCDFNTDEFAULTSIZE
	add	SysTemp3,SysTemp4
	sts	CHARROW,SysTemp3
	lds	SysTemp3,CHARROW_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	CHARROW_H,SysTemp3
	lds	SysCalcTempA,CURRCHARROW
	cpi	SysCalcTempA,8
	brsh	ENDIF68
	rjmp	SysForLoop9
ENDIF68:
SysForLoopEnd9:
	lds	SysTemp3,CHARCOL
	lds	SysTemp4,GLCDFNTDEFAULTSIZE
	add	SysTemp3,SysTemp4
	sts	CHARCOL,SysTemp3
	lds	SysTemp3,CHARCOL_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	CHARCOL_H,SysTemp3
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,5
	brsh	ENDIF69
	rjmp	SysForLoop8
ENDIF69:
SysForLoopEnd8:
	ret

;********************************************************************************

GLCDROTATE_SSD1289:
SysSelect4Case1:
	lds	SysCalcTempA,ORIENTATION_SSD1289
	cpi	SysCalcTempA,1
	brne	SysSelect4Case2
	ldi	SysValueCopy,63
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
	ldi	SysValueCopy,239
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
	cbi	PORTG,1
	ldi	SysValueCopy,1
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,105
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,17
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,112
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,96
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	sbi	PORTG,1
	ldi	SysWaitTempMS,1
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
	rjmp	SysSelectEnd4
SysSelect4Case2:
	lds	SysCalcTempA,ORIENTATION_SSD1289
	cpi	SysCalcTempA,2
	brne	SysSelect4Case3
	ldi	SysValueCopy,239
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
	cbi	PORTG,1
	ldi	SysValueCopy,1
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,105
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,17
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,112
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,96
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	sbi	PORTG,1
	ldi	SysWaitTempMS,1
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
	rjmp	SysSelectEnd4
SysSelect4Case3:
	lds	SysCalcTempA,ORIENTATION_SSD1289
	cpi	SysCalcTempA,3
	brne	SysSelect4Case4
	ldi	SysValueCopy,63
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
	ldi	SysValueCopy,239
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
	cbi	PORTG,1
	ldi	SysValueCopy,1
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,43
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,17
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,112
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,96
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	sbi	PORTG,1
	ldi	SysWaitTempMS,1
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	rjmp	SysSelectEnd4
SysSelect4Case4:
	ldi	SysValueCopy,239
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
	cbi	PORTG,1
	ldi	SysValueCopy,1
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,43
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,17
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,112
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,96
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	sbi	PORTG,1
	ldi	SysWaitTempMS,1
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
SysSelectEnd4:
	ret

;********************************************************************************

INITGLCD_SSD1289:
	ldi	SysValueCopy,4
	sts	ORIENTATION_SSD1289,SysValueCopy
	sbi	DDRG,2
	sbi	DDRG,1
	sbi	DDRD,7
	sbi	DDRG,0
	sbi	DDRC,0
	sbi	DDRC,1
	sbi	DDRC,2
	sbi	DDRC,3
	sbi	DDRC,4
	sbi	DDRC,5
	sbi	DDRC,6
	sbi	DDRC,7
	sbi	DDRA,0
	sbi	DDRA,1
	sbi	DDRA,2
	sbi	DDRA,3
	sbi	DDRA,4
	sbi	DDRA,5
	sbi	DDRA,6
	sbi	DDRA,7
	sbi	PORTG,1
	sbi	PORTG,0
	ldi	SysWaitTempMS,5
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	cbi	PORTG,0
	ldi	SysWaitTempMS,15
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	sbi	PORTG,0
	ldi	SysWaitTempMS,15
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
	cbi	PORTG,1
	ldi	SysValueCopy,0
	sts	WCOMMAND,SysValueCopy
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,3
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,164
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,168
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,12
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,13
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,12
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,128
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,14
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,43
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,30
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,183
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,2
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,6
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,16
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
SysSelect3Case1:
	lds	SysCalcTempA,ORIENTATION_SSD1289
	cpi	SysCalcTempA,3
	brne	SysSelect3Case2
	ldi	SysValueCopy,63
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
	ldi	SysValueCopy,239
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,43
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,17
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,112
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,96
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	rjmp	SysSelectEnd3
SysSelect3Case2:
	lds	SysCalcTempA,ORIENTATION_SSD1289
	cpi	SysCalcTempA,1
	brne	SysSelect3Case3
	ldi	SysValueCopy,63
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
	ldi	SysValueCopy,239
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,105
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,17
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,112
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,96
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	rjmp	SysSelectEnd3
SysSelect3Case3:
	lds	SysCalcTempA,ORIENTATION_SSD1289
	cpi	SysCalcTempA,2
	brne	SysSelect3Case4
	ldi	SysValueCopy,239
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,105
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,17
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,112
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,96
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	rjmp	SysSelectEnd3
SysSelect3Case4:
	ldi	SysValueCopy,239
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,43
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,17
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,112
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,96
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
SysSelectEnd3:
	ldi	SysValueCopy,5
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,6
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,22
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,28
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,239
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,23
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,7
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,51
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,2
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,11
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,15
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,65
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,66
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,72
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,73
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,74
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,75
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,68
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,149
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,239
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,69
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,70
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,1
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,48
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,7
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,49
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,4
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,2
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,50
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,4
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,2
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,51
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,5
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,52
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,7
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,5
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,53
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,4
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,2
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,54
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,4
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,2
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,55
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,5
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,58
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,3
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,59
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,2
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,3
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,35
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,36
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,37
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	ldi	SysValueCopy,128
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,79
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,78
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	WDATA,SysValueCopy
	sts	WDATA_H,SysValueCopy
	call	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,34
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	call	WRITE_COMMAND_SSD1289
	sbi	PORTG,1
	ldi	SysValueCopy,6
	sts	GLCDFONTWIDTH,SysValueCopy
	ldi	SysValueCopy,2
	sts	GLCDFNTDEFAULTSIZE,SysValueCopy
	ldi	SysValueCopy,7
	sts	GLCDFNTDEFAULTHEIGHT,SysValueCopy
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND,SysValueCopy
	sts	GLCDFOREGROUND_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND,SysValueCopy
	sts	GLCDBACKGROUND_H,SysValueCopy
	rjmp	GLCDCLS_SSD1289

;********************************************************************************

INITSYS:
	ldi	SysValueCopy,0
	out	PORTA,SysValueCopy
	ldi	SysValueCopy,0
	out	PORTB,SysValueCopy
	ldi	SysValueCopy,0
	out	PORTC,SysValueCopy
	ldi	SysValueCopy,0
	out	PORTD,SysValueCopy
	ldi	SysValueCopy,0
	out	PORTE,SysValueCopy
	ldi	SysValueCopy,0
	out	PORTF,SysValueCopy
	ldi	SysValueCopy,0
	out	PORTG,SysValueCopy
	ldi	SysValueCopy,0
	sts	PORTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	PORTJ,SysValueCopy
	ret

;********************************************************************************

FN_LEN:
	lds	SysStringA,SysLENTEMPHandler
	lds	SysStringA_H,SysLENTEMPHandler_H
	ld	SysValueCopy,X
	sts	LEN,SysValueCopy
	ret

;********************************************************************************

LINE:
	ldi	SysValueCopy,0
	sts	LINEDIFFX,SysValueCopy
	sts	LINEDIFFX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEDIFFY,SysValueCopy
	sts	LINEDIFFY_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPX,SysValueCopy
	sts	LINESTEPX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPY,SysValueCopy
	sts	LINESTEPY_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEDIFFX_X2,SysValueCopy
	sts	LINEDIFFX_X2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEDIFFY_X2,SysValueCopy
	sts	LINEDIFFY_X2_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEERR,SysValueCopy
	sts	LINEERR_H,SysValueCopy
	lds	SysTemp3,LINEX2
	lds	SysTemp4,LINEX1
	sub	SysTemp3,SysTemp4
	sts	LINEDIFFX,SysTemp3
	lds	SysTemp3,LINEX2_H
	lds	SysTemp4,LINEX1_H
	sbc	SysTemp3,SysTemp4
	sts	LINEDIFFX_H,SysTemp3
	lds	SysTemp3,LINEY2
	lds	SysTemp4,LINEY1
	sub	SysTemp3,SysTemp4
	sts	LINEDIFFY,SysTemp3
	lds	SysTemp3,LINEY2_H
	lds	SysTemp4,LINEY1_H
	sbc	SysTemp3,SysTemp4
	sts	LINEDIFFY_H,SysTemp3
	lds	SysINTEGERTempB,LINEDIFFX
	lds	SysINTEGERTempB_H,LINEDIFFX_H
	ldi	SysINTEGERTempA,0
	ldi	SysINTEGERTempA_H,0
	rcall	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE70_1
	ldi	SysValueCopy,1
	sts	LINESTEPX,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPX_H,SysValueCopy
	rjmp	ENDIF70
ELSE70_1:
	ldi	SysValueCopy,255
	sts	LINESTEPX,SysValueCopy
	sts	LINESTEPX_H,SysValueCopy
ENDIF70:
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	ldi	SysINTEGERTempA,0
	ldi	SysINTEGERTempA_H,0
	rcall	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE71_1
	ldi	SysValueCopy,1
	sts	LINESTEPY,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPY_H,SysValueCopy
	rjmp	ENDIF71
ELSE71_1:
	ldi	SysValueCopy,255
	sts	LINESTEPY,SysValueCopy
	sts	LINESTEPY_H,SysValueCopy
ENDIF71:
	lds	SysINTEGERTempA,LINESTEPX
	lds	SysINTEGERTempA_H,LINESTEPX_H
	lds	SysINTEGERTempB,LINEDIFFX
	lds	SysINTEGERTempB_H,LINEDIFFX_H
	call	SYSMULTSUBINT
	sts	LINEDIFFX,SysINTEGERTempX
	sts	LINEDIFFX_H,SysINTEGERTempX_H
	lds	SysINTEGERTempA,LINESTEPY
	lds	SysINTEGERTempA_H,LINESTEPY_H
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	call	SYSMULTSUBINT
	sts	LINEDIFFY,SysINTEGERTempX
	sts	LINEDIFFY_H,SysINTEGERTempX_H
	lds	SysINTEGERTempA,LINEDIFFX
	lds	SysINTEGERTempA_H,LINEDIFFX_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	call	SYSMULTSUBINT
	sts	LINEDIFFX_X2,SysINTEGERTempX
	sts	LINEDIFFX_X2_H,SysINTEGERTempX_H
	lds	SysINTEGERTempA,LINEDIFFY
	lds	SysINTEGERTempA_H,LINEDIFFY_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	call	SYSMULTSUBINT
	sts	LINEDIFFY_X2,SysINTEGERTempX
	sts	LINEDIFFY_X2_H,SysINTEGERTempX_H
	lds	SysINTEGERTempA,LINEDIFFX
	lds	SysINTEGERTempA_H,LINEDIFFX_H
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	rcall	SYSCOMPLESSTHANINT
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ELSE72_1
	lds	SysTemp3,LINEDIFFY_X2
	lds	SysTemp4,LINEDIFFX
	sub	SysTemp3,SysTemp4
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEDIFFY_X2_H
	lds	SysTemp4,LINEDIFFX_H
	sbc	SysTemp3,SysTemp4
	sts	LINEERR_H,SysTemp3
SysDoLoop_S2:
	lds	SysWORDTempA,linex1
	lds	SysWORDTempA_H,linex1_H
	lds	SysWORDTempB,linex2
	lds	SysWORDTempB_H,linex2_H
	rcall	SYSCOMPEQUAL16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E2
	lds	SysValueCopy,LINEX1
	sts	PX1,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	PX1_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	PY1,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	PY1_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	COLOR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	COLOR_H,SysValueCopy
	rcall	PSET_SSD1289
	lds	SysTemp3,LINEX1
	lds	SysTemp4,LINESTEPX
	add	SysTemp3,SysTemp4
	sts	LINEX1,SysTemp3
	lds	SysTemp3,LINEX1_H
	lds	SysTemp4,LINESTEPX_H
	adc	SysTemp3,SysTemp4
	sts	LINEX1_H,SysTemp3
	lds	SysINTEGERTempA,LINEERR
	lds	SysINTEGERTempA_H,LINEERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	rcall	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE73_1
	lds	SysTemp3,LINEERR
	lds	SysTemp4,LINEDIFFY_X2
	add	SysTemp3,SysTemp4
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEERR_H
	lds	SysTemp4,LINEDIFFY_X2_H
	adc	SysTemp3,SysTemp4
	sts	LINEERR_H,SysTemp3
	rjmp	ENDIF73
ELSE73_1:
	lds	SysTemp3,LINEDIFFY_X2
	lds	SysTemp4,LINEDIFFX_X2
	sub	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,LINEDIFFY_X2_H
	lds	SysTemp4,LINEDIFFX_X2_H
	sbc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,LINEERR
	add	SysTemp3,SysTemp1
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEERR_H
	adc	SysTemp3,SysTemp1_H
	sts	LINEERR_H,SysTemp3
	lds	SysTemp3,LINEY1
	lds	SysTemp4,LINESTEPY
	add	SysTemp3,SysTemp4
	sts	LINEY1,SysTemp3
	lds	SysTemp3,LINEY1_H
	lds	SysTemp4,LINESTEPY_H
	adc	SysTemp3,SysTemp4
	sts	LINEY1_H,SysTemp3
ENDIF73:
	rjmp	SysDoLoop_S2
SysDoLoop_E2:
	lds	SysValueCopy,LINEX1
	sts	PX1,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	PX1_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	PY1,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	PY1_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	COLOR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	COLOR_H,SysValueCopy
	rcall	PSET_SSD1289
	rjmp	ENDIF72
ELSE72_1:
	lds	SysTemp3,LINEDIFFX_X2
	lds	SysTemp4,LINEDIFFY
	sub	SysTemp3,SysTemp4
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEDIFFX_X2_H
	lds	SysTemp4,LINEDIFFY_H
	sbc	SysTemp3,SysTemp4
	sts	LINEERR_H,SysTemp3
SysDoLoop_S3:
	lds	SysWORDTempA,liney1
	lds	SysWORDTempA_H,liney1_H
	lds	SysWORDTempB,liney2
	lds	SysWORDTempB_H,liney2_H
	rcall	SYSCOMPEQUAL16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E3
	lds	SysValueCopy,LINEX1
	sts	PX1,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	PX1_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	PY1,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	PY1_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	COLOR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	COLOR_H,SysValueCopy
	rcall	PSET_SSD1289
	lds	SysTemp3,LINEY1
	lds	SysTemp4,LINESTEPY
	add	SysTemp3,SysTemp4
	sts	LINEY1,SysTemp3
	lds	SysTemp3,LINEY1_H
	lds	SysTemp4,LINESTEPY_H
	adc	SysTemp3,SysTemp4
	sts	LINEY1_H,SysTemp3
	lds	SysINTEGERTempA,LINEERR
	lds	SysINTEGERTempA_H,LINEERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	rcall	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE74_1
	lds	SysTemp3,LINEERR
	lds	SysTemp4,LINEDIFFX_X2
	add	SysTemp3,SysTemp4
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEERR_H
	lds	SysTemp4,LINEDIFFX_X2_H
	adc	SysTemp3,SysTemp4
	sts	LINEERR_H,SysTemp3
	rjmp	ENDIF74
ELSE74_1:
	lds	SysTemp3,LINEDIFFX_X2
	lds	SysTemp4,LINEDIFFY_X2
	sub	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,LINEDIFFX_X2_H
	lds	SysTemp4,LINEDIFFY_X2_H
	sbc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,LINEERR
	add	SysTemp3,SysTemp1
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEERR_H
	adc	SysTemp3,SysTemp1_H
	sts	LINEERR_H,SysTemp3
	lds	SysTemp3,LINEX1
	lds	SysTemp4,LINESTEPX
	add	SysTemp3,SysTemp4
	sts	LINEX1,SysTemp3
	lds	SysTemp3,LINEX1_H
	lds	SysTemp4,LINESTEPX_H
	adc	SysTemp3,SysTemp4
	sts	LINEX1_H,SysTemp3
ENDIF74:
	rjmp	SysDoLoop_S3
SysDoLoop_E3:
	lds	SysValueCopy,LINEX1
	sts	PX1,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	PX1_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	PY1,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	PY1_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	COLOR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	COLOR_H,SysValueCopy
	rcall	PSET_SSD1289
ENDIF72:
	ret

;********************************************************************************

PRINT_SSD1289513:
	lds	SysStringA,SysPRINTDATAHandler
	lds	SysStringA_H,SysPRINTDATAHandler_H
	ld	SysValueCopy,X
	sts	PRINTLEN,SysValueCopy
	lds	SysCalcTempA,PRINTLEN
	tst	SysCalcTempA
	brne	ENDIF62
	ret
ENDIF62:
	lds	SysValueCopy,PRINTLOCX
	sts	GLCDPRINTLOC,SysValueCopy
	lds	SysValueCopy,PRINTLOCX_H
	sts	GLCDPRINTLOC_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	SYSPRINTTEMP,SysValueCopy
SysForLoop7:
	lds	SysValueCopy,GLCDPRINTLOC
	sts	CHARLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	CHARLOCX_H,SysValueCopy
	lds	SysValueCopy,PRINTLOCY
	sts	CHARLOCY,SysValueCopy
	lds	SysValueCopy,PRINTLOCY_H
	sts	CHARLOCY_H,SysValueCopy
	lds	SysTemp3,SysPRINTDATAHandler
	lds	SysTemp4,SYSPRINTTEMP
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SysPRINTDATAHandler_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	CHARCODE,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	GLCDDRAWCHAR_SSD1289
	lds	SysBYTETempA,GLCDFONTWIDTH
	lds	SysBYTETempB,SIZE
	mul	SysByteTempA,SysByteTempB
	lds	SysTemp3,GLCDPRINTLOC
	add	SysTemp3,SysByteTempX
	sts	GLCDPRINTLOC,SysTemp3
	lds	SysTemp3,GLCDPRINTLOC_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	sts	GLCDPRINTLOC_H,SysTemp3
	lds	SysTemp4,PRINTLEN
	lds	SysTemp1,SYSPRINTTEMP
	sub	SysTemp4,SysTemp1
	mov	SysTemp3,SysTemp4
	mov	SysBYTETempA,SysTemp3
	ldi	SysBYTETempB,0
	rcall	SYSCOMPEQUAL
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF63
	lds	SysTemp3,SYSPRINTTEMP
	inc	SysTemp3
	sts	SYSPRINTTEMP,SysTemp3
	rjmp	SysForLoop7
ENDIF63:
SysForLoopEnd7:
	ret

;********************************************************************************

PSET_SSD1289:
	lds	SysWORDTempB,PX1
	lds	SysWORDTempB_H,PX1_H
	lds	SysWORDTempA,GLCDDEVICEWIDTH
	lds	SysWORDTempA_H,GLCDDEVICEWIDTH_H
	rcall	SYSCOMPLESSTHAN16
	mov	SysTemp3,SysByteTempX
	lds	SysWORDTempB,PY1
	lds	SysWORDTempB_H,PY1_H
	lds	SysWORDTempA,GLCDDEVICEHEIGHT
	lds	SysWORDTempA_H,GLCDDEVICEHEIGHT_H
	rcall	SYSCOMPLESSTHAN16
	mov	SysTemp1,SysByteTempX
	or	SysTemp1,SysTemp3
	mov	SysTemp4,SysTemp1
	sbrc	SysTemp4,0
	ret
	cbi	PORTG,1
	lds	SysValueCopy,PX1
	sts	PX2,SysValueCopy
	lds	SysValueCopy,PX1_H
	sts	PX2_H,SysValueCopy
	lds	SysValueCopy,PY1
	sts	PY2,SysValueCopy
	lds	SysValueCopy,PY1_H
	sts	PY2_H,SysValueCopy
	rcall	SET_ADDRESS_SSD1289
	lds	SysValueCopy,COLOR
	sts	WDATA,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	WDATA_H,SysValueCopy
	rcall	WRITE_DATA_SSD1289
	sbi	PORTG,1
	ret

;********************************************************************************

FN_RIGHT:
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysCalcTempA,X
	tst	SysCalcTempA
	brne	ENDIF52
	ldi	SysValueCopy,0
	sts	SYSRIGHT_0,SysValueCopy
	ret
ENDIF52:
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysCalcTempA,X
	lds	SysCalcTempB,SYSCHARCOUNT
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF53
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysValueCopy,X
	sts	SYSCHARCOUNT,SysValueCopy
ENDIF53:
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysTemp3,X
	lds	SysTemp4,SYSCHARCOUNT
	sub	SysTemp3,SysTemp4
	sts	SYSCHARSTART,SysTemp3
	ldi	SysValueCopy,1
	sts	SYSSTRINGTEMP,SysValueCopy
SysForLoop2:
	lds	SysTemp4,SYSCHARSTART
	lds	SysTemp1,SYSSTRINGTEMP
	add	SysTemp4,SysTemp1
	mov	SysTemp3,SysTemp4
	lds	SysTemp4,SysSYSINSTRINGHandler
	add	SysTemp4,SysTemp3
	mov	SysStringA,SysTemp4
	lds	SysTemp3,SysSYSINSTRINGHandler_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X+
	sts	SysArrayTemp2,SysValueCopy
	sts	SysArrayTemp1,SysValueCopy
	lds	SysTemp3,SYSSTRINGTEMP
	ldi	SysTemp5,low(RIGHT)
	add	SysTemp3,SysTemp5
	mov	SysStringA,SysTemp3
	ldi	SysTemp5,0
	ldi	SysTemp6,high(RIGHT)
	adc	SysTemp5,SysTemp6
	mov	SysStringA_H,SysTemp5
	lds	SysValueCopy,SysArrayTemp1
	st	X+,SysValueCopy
	lds	SysTemp4,SYSCHARCOUNT
	lds	SysTemp1,SYSSTRINGTEMP
	sub	SysTemp4,SysTemp1
	mov	SysTemp3,SysTemp4
	mov	SysBYTETempA,SysTemp3
	ldi	SysBYTETempB,0
	rcall	SYSCOMPEQUAL
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF54
	lds	SysTemp3,SYSSTRINGTEMP
	inc	SysTemp3
	sts	SYSSTRINGTEMP,SysTemp3
	rjmp	SysForLoop2
ENDIF54:
SysForLoopEnd2:
	lds	SysValueCopy,SYSCHARCOUNT
	sts	SYSRIGHT_0,SysValueCopy
	ret

;********************************************************************************

ROUNDRECT31:
	lds	SysWORDTempB,RX1
	lds	SysWORDTempB_H,RX1_H
	lds	SysWORDTempA,RX2
	lds	SysWORDTempA_H,RX2_H
	rcall	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	rjmp	ENDIF28
	lds	SYSCALCTEMPA,RX1
	lds	SYSCALCTEMPA_H,RX1_H
	lds	SYSCALCTEMPB,RX2
	lds	SYSCALCTEMPB_H,RX2_H
	rcall	SWAP149
	sts	RX1,SYSCALCTEMPA
	sts	RX1_H,SYSCALCTEMPA_H
	sts	RX2,SYSCALCTEMPB
	sts	RX2_H,SYSCALCTEMPB_H
ENDIF28:
	lds	SysWORDTempB,RY1
	lds	SysWORDTempB_H,RY1_H
	lds	SysWORDTempA,RY2
	lds	SysWORDTempA_H,RY2_H
	rcall	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	rjmp	ENDIF29
	lds	SYSCALCTEMPA,RY1
	lds	SYSCALCTEMPA_H,RY1_H
	lds	SYSCALCTEMPB,RY2
	lds	SYSCALCTEMPB_H,RY2_H
	rcall	SWAP149
	sts	RY1,SYSCALCTEMPA
	sts	RY1_H,SYSCALCTEMPA_H
	sts	RY2,SYSCALCTEMPB
	sts	RY2_H,SYSCALCTEMPB_H
ENDIF29:
	lds	SysTemp2,RX2
	lds	SysTemp3,RX1
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,RX2_H
	lds	SysTemp3,RX1_H
	sbc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	mov	SysWORDTempB,SysTemp1
	mov	SysWORDTempB_H,SysTemp1_H
	ldi	SysWORDTempA,4
	ldi	SysWORDTempA_H,0
	rcall	SYSCOMPLESSTHAN16
	mov	SysTemp2,SysByteTempX
	lds	SysTemp3,RY2
	lds	SysTemp4,RY1
	sub	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,RY2_H
	lds	SysTemp4,RY1_H
	sbc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	mov	SysWORDTempB,SysTemp1
	mov	SysWORDTempB_H,SysTemp1_H
	ldi	SysWORDTempA,4
	ldi	SysWORDTempA_H,0
	rcall	SYSCOMPLESSTHAN16
	mov	SysTemp3,SysByteTempX
	and	SysTemp3,SysTemp2
	mov	SysTemp4,SysTemp3
	sbrs	SysTemp4,0
	rjmp	ENDIF30
	lds	SysTemp2,RX1
	ldi	SysTemp5,1
	add	SysTemp2,SysTemp5
	sts	PX1,SysTemp2
	lds	SysTemp2,RX1_H
	ldi	SysTemp5,0
	adc	SysTemp2,SysTemp5
	sts	PX1_H,SysTemp2
	lds	SysTemp2,RY1
	ldi	SysTemp5,2
	add	SysTemp2,SysTemp5
	sts	PY1,SysTemp2
	lds	SysTemp2,RY1_H
	ldi	SysTemp5,0
	adc	SysTemp2,SysTemp5
	sts	PY1_H,SysTemp2
	rcall	PSET_SSD1289
	lds	SysTemp2,RX1
	ldi	SysTemp5,2
	add	SysTemp2,SysTemp5
	sts	PX1,SysTemp2
	lds	SysTemp2,RX1_H
	ldi	SysTemp5,0
	adc	SysTemp2,SysTemp5
	sts	PX1_H,SysTemp2
	lds	SysTemp2,RY1
	ldi	SysTemp5,1
	add	SysTemp2,SysTemp5
	sts	PY1,SysTemp2
	lds	SysTemp2,RY1_H
	ldi	SysTemp5,0
	adc	SysTemp2,SysTemp5
	sts	PY1_H,SysTemp2
	rcall	PSET_SSD1289
	lds	SysTemp2,RX2
	ldi	SysTemp5,2
	sub	SysTemp2,SysTemp5
	sts	PX1,SysTemp2
	lds	SysTemp2,RX2_H
	ldi	SysTemp5,0
	sbc	SysTemp2,SysTemp5
	sts	PX1_H,SysTemp2
	lds	SysTemp2,RY1
	ldi	SysTemp5,1
	add	SysTemp2,SysTemp5
	sts	PY1,SysTemp2
	lds	SysTemp2,RY1_H
	ldi	SysTemp5,0
	adc	SysTemp2,SysTemp5
	sts	PY1_H,SysTemp2
	rcall	PSET_SSD1289
	lds	SysTemp2,RX2
	ldi	SysTemp5,1
	sub	SysTemp2,SysTemp5
	sts	PX1,SysTemp2
	lds	SysTemp2,RX2_H
	ldi	SysTemp5,0
	sbc	SysTemp2,SysTemp5
	sts	PX1_H,SysTemp2
	lds	SysTemp2,RY1
	ldi	SysTemp5,2
	add	SysTemp2,SysTemp5
	sts	PY1,SysTemp2
	lds	SysTemp2,RY1_H
	ldi	SysTemp5,0
	adc	SysTemp2,SysTemp5
	sts	PY1_H,SysTemp2
	rcall	PSET_SSD1289
	lds	SysTemp2,RX1
	ldi	SysTemp5,1
	add	SysTemp2,SysTemp5
	sts	PX1,SysTemp2
	lds	SysTemp2,RX1_H
	ldi	SysTemp5,0
	adc	SysTemp2,SysTemp5
	sts	PX1_H,SysTemp2
	lds	SysTemp2,RY2
	ldi	SysTemp5,2
	sub	SysTemp2,SysTemp5
	sts	PY1,SysTemp2
	lds	SysTemp2,RY2_H
	ldi	SysTemp5,0
	sbc	SysTemp2,SysTemp5
	sts	PY1_H,SysTemp2
	rcall	PSET_SSD1289
	lds	SysTemp2,RX1
	ldi	SysTemp5,2
	add	SysTemp2,SysTemp5
	sts	PX1,SysTemp2
	lds	SysTemp2,RX1_H
	ldi	SysTemp5,0
	adc	SysTemp2,SysTemp5
	sts	PX1_H,SysTemp2
	lds	SysTemp2,RY2
	ldi	SysTemp5,1
	sub	SysTemp2,SysTemp5
	sts	PY1,SysTemp2
	lds	SysTemp2,RY2_H
	ldi	SysTemp5,0
	sbc	SysTemp2,SysTemp5
	sts	PY1_H,SysTemp2
	rcall	PSET_SSD1289
	lds	SysTemp2,RX2
	ldi	SysTemp5,2
	sub	SysTemp2,SysTemp5
	sts	PX1,SysTemp2
	lds	SysTemp2,RX2_H
	ldi	SysTemp5,0
	sbc	SysTemp2,SysTemp5
	sts	PX1_H,SysTemp2
	lds	SysTemp2,RY2
	ldi	SysTemp5,1
	sub	SysTemp2,SysTemp5
	sts	PY1,SysTemp2
	lds	SysTemp2,RY2_H
	ldi	SysTemp5,0
	sbc	SysTemp2,SysTemp5
	sts	PY1_H,SysTemp2
	rcall	PSET_SSD1289
	lds	SysTemp2,RX2
	ldi	SysTemp5,1
	sub	SysTemp2,SysTemp5
	sts	PX1,SysTemp2
	lds	SysTemp2,RX2_H
	ldi	SysTemp5,0
	sbc	SysTemp2,SysTemp5
	sts	PX1_H,SysTemp2
	lds	SysTemp2,RY2
	ldi	SysTemp5,2
	sub	SysTemp2,SysTemp5
	sts	PY1,SysTemp2
	lds	SysTemp2,RY2_H
	ldi	SysTemp5,0
	sbc	SysTemp2,SysTemp5
	sts	PY1_H,SysTemp2
	rcall	PSET_SSD1289
	lds	SysTemp2,RX1
	ldi	SysTemp5,3
	add	SysTemp2,SysTemp5
	sts	LINEX1,SysTemp2
	lds	SysTemp2,RX1_H
	ldi	SysTemp5,0
	adc	SysTemp2,SysTemp5
	sts	LINEX1_H,SysTemp2
	lds	SysValueCopy,RY1
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,RY1_H
	sts	LINEY1_H,SysValueCopy
	lds	SysTemp2,RX2
	ldi	SysTemp5,3
	sub	SysTemp2,SysTemp5
	sts	LINEX2,SysTemp2
	lds	SysTemp2,RX2_H
	ldi	SysTemp5,0
	sbc	SysTemp2,SysTemp5
	sts	LINEX2_H,SysTemp2
	lds	SysValueCopy,RY1
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,RY1_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,COLOR
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	LINE
	lds	SysTemp2,RX1
	ldi	SysTemp5,3
	add	SysTemp2,SysTemp5
	sts	LINEX1,SysTemp2
	lds	SysTemp2,RX1_H
	ldi	SysTemp5,0
	adc	SysTemp2,SysTemp5
	sts	LINEX1_H,SysTemp2
	lds	SysValueCopy,RY2
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,RY2_H
	sts	LINEY1_H,SysValueCopy
	lds	SysTemp2,RX2
	ldi	SysTemp5,3
	sub	SysTemp2,SysTemp5
	sts	LINEX2,SysTemp2
	lds	SysTemp2,RX2_H
	ldi	SysTemp5,0
	sbc	SysTemp2,SysTemp5
	sts	LINEX2_H,SysTemp2
	lds	SysValueCopy,RY2
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,RY2_H
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,COLOR
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	LINE
	lds	SysValueCopy,RX1
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,RX1_H
	sts	LINEX1_H,SysValueCopy
	lds	SysTemp2,RY1
	ldi	SysTemp5,3
	add	SysTemp2,SysTemp5
	sts	LINEY1,SysTemp2
	lds	SysTemp2,RY1_H
	ldi	SysTemp5,0
	adc	SysTemp2,SysTemp5
	sts	LINEY1_H,SysTemp2
	lds	SysValueCopy,RX1
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,RX1_H
	sts	LINEX2_H,SysValueCopy
	lds	SysTemp2,RY2
	ldi	SysTemp5,3
	sub	SysTemp2,SysTemp5
	sts	LINEY2,SysTemp2
	lds	SysTemp2,RY2_H
	ldi	SysTemp5,0
	sbc	SysTemp2,SysTemp5
	sts	LINEY2_H,SysTemp2
	lds	SysValueCopy,COLOR
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	LINE
	lds	SysValueCopy,RX2
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,RX2_H
	sts	LINEX1_H,SysValueCopy
	lds	SysTemp2,RY1
	ldi	SysTemp5,3
	add	SysTemp2,SysTemp5
	sts	LINEY1,SysTemp2
	lds	SysTemp2,RY1_H
	ldi	SysTemp5,0
	adc	SysTemp2,SysTemp5
	sts	LINEY1_H,SysTemp2
	lds	SysValueCopy,RX2
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,RX2_H
	sts	LINEX2_H,SysValueCopy
	lds	SysTemp2,RY2
	ldi	SysTemp5,3
	sub	SysTemp2,SysTemp5
	sts	LINEY2,SysTemp2
	lds	SysTemp2,RY2_H
	ldi	SysTemp5,0
	sbc	SysTemp2,SysTemp5
	sts	LINEY2_H,SysTemp2
	lds	SysValueCopy,COLOR
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,COLOR_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	LINE
ENDIF30:
	ret

;********************************************************************************

SETBUS_SSD1289:
	cbi	PORTC,0
	lds	SysBitTest,DATAVAL
	sbrc	SysBitTest,0
	sbi	PORTC,0
	cbi	PORTC,1
	lds	SysBitTest,DATAVAL
	sbrc	SysBitTest,1
	sbi	PORTC,1
	cbi	PORTC,2
	lds	SysBitTest,DATAVAL
	sbrc	SysBitTest,2
	sbi	PORTC,2
	cbi	PORTC,3
	lds	SysBitTest,DATAVAL
	sbrc	SysBitTest,3
	sbi	PORTC,3
	cbi	PORTC,4
	lds	SysBitTest,DATAVAL
	sbrc	SysBitTest,4
	sbi	PORTC,4
	cbi	PORTC,5
	lds	SysBitTest,DATAVAL
	sbrc	SysBitTest,5
	sbi	PORTC,5
	cbi	PORTC,6
	lds	SysBitTest,DATAVAL
	sbrc	SysBitTest,6
	sbi	PORTC,6
	cbi	PORTC,7
	lds	SysBitTest,DATAVAL
	sbrc	SysBitTest,7
	sbi	PORTC,7
	cbi	PORTA,0
	lds	SysBitTest,DATAVAL_H
	sbrc	SysBitTest,0
	sbi	PORTA,0
	cbi	PORTA,1
	lds	SysBitTest,DATAVAL_H
	sbrc	SysBitTest,1
	sbi	PORTA,1
	cbi	PORTA,2
	lds	SysBitTest,DATAVAL_H
	sbrc	SysBitTest,2
	sbi	PORTA,2
	cbi	PORTA,3
	lds	SysBitTest,DATAVAL_H
	sbrc	SysBitTest,3
	sbi	PORTA,3
	cbi	PORTA,4
	lds	SysBitTest,DATAVAL_H
	sbrc	SysBitTest,4
	sbi	PORTA,4
	cbi	PORTA,5
	lds	SysBitTest,DATAVAL_H
	sbrc	SysBitTest,5
	sbi	PORTA,5
	cbi	PORTA,6
	lds	SysBitTest,DATAVAL_H
	sbrc	SysBitTest,6
	sbi	PORTA,6
	cbi	PORTA,7
	lds	SysBitTest,DATAVAL_H
	sbrc	SysBitTest,7
	sbi	PORTA,7
	ret

;********************************************************************************

SET_ADDRESS_SSD1289:
	lds	SysBYTETempA,ORIENTATION_SSD1289
	ldi	SysBYTETempB,1
	rcall	SYSCOMPEQUAL
	mov	SysTemp3,SysByteTempX
	lds	SysBYTETempA,ORIENTATION_SSD1289
	ldi	SysBYTETempB,3
	rcall	SYSCOMPEQUAL
	mov	SysTemp1,SysByteTempX
	or	SysTemp1,SysTemp3
	mov	SysTemp4,SysTemp1
	sbrs	SysTemp4,0
	rjmp	ENDIF87
	lds	SYSCALCTEMPA,PX1
	lds	SYSCALCTEMPA_H,PX1_H
	lds	SYSCALCTEMPB,PY1
	lds	SYSCALCTEMPB_H,PY1_H
	rcall	SWAP149
	sts	PX1,SYSCALCTEMPA
	sts	PX1_H,SYSCALCTEMPA_H
	sts	PY1,SYSCALCTEMPB
	sts	PY1_H,SYSCALCTEMPB_H
	lds	SYSCALCTEMPA,PX2
	lds	SYSCALCTEMPA_H,PX2_H
	lds	SYSCALCTEMPB,PY2
	lds	SYSCALCTEMPB_H,PY2_H
	rcall	SWAP149
	sts	PX2,SYSCALCTEMPA
	sts	PX2_H,SYSCALCTEMPA_H
	sts	PY2,SYSCALCTEMPB
	sts	PY2_H,SYSCALCTEMPB_H
	lds	SysTemp3,GLCDDEVICEHEIGHT
	lds	SysTemp4,PX1
	sub	SysTemp3,SysTemp4
	sts	PX1,SysTemp3
	lds	SysTemp3,GLCDDEVICEHEIGHT_H
	lds	SysTemp4,PX1_H
	sbc	SysTemp3,SysTemp4
	sts	PX1_H,SysTemp3
	lds	SysTemp3,GLCDDEVICEHEIGHT
	lds	SysTemp4,PX2
	sub	SysTemp3,SysTemp4
	sts	PX2,SysTemp3
	lds	SysTemp3,GLCDDEVICEHEIGHT_H
	lds	SysTemp4,PX2_H
	sbc	SysTemp3,SysTemp4
	sts	PX2_H,SysTemp3
	lds	SYSCALCTEMPA,PX1
	lds	SYSCALCTEMPA_H,PX1_H
	lds	SYSCALCTEMPB,PX2
	lds	SYSCALCTEMPB_H,PX2_H
	rcall	SWAP149
	sts	PX1,SYSCALCTEMPA
	sts	PX1_H,SYSCALCTEMPA_H
	sts	PX2,SYSCALCTEMPB
	sts	PX2_H,SYSCALCTEMPB_H
ENDIF87:
	lds	SysValueCopy,PX2
	sts	GLCDTEMPXY,SysValueCopy
	ldi	SysValueCopy,8
	sts	SysRepeatTemp4,SysValueCopy
SysRepeatLoop4:
	lds	SysValueCopy,PX2
	rol	SysValueCopy
	sts	PX2,SysValueCopy
	lds	SysValueCopy,PX2_H
	rol	SysValueCopy
	sts	PX2_H,SysValueCopy
	lds	SysTemp3,SysRepeatTemp4
	dec	SysTemp3
	sts	SysRepeatTemp4,SysTemp3
	brne	SysRepeatLoop4
SysRepeatLoopEnd4:
	lds	SysTemp3,PX2
	lds	SysTemp4,PX1
	add	SysTemp3,SysTemp4
	sts	PX2,SysTemp3
	lds	SysTemp3,PX2_H
	lds	SysTemp4,PX1_H
	adc	SysTemp3,SysTemp4
	sts	PX2_H,SysTemp3
	ldi	SysValueCopy,68
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	lds	SysValueCopy,PX2
	sts	WDATA,SysValueCopy
	lds	SysValueCopy,PX2_H
	sts	WDATA_H,SysValueCopy
	rcall	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,69
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	lds	SysValueCopy,PY1
	sts	WDATA,SysValueCopy
	lds	SysValueCopy,PY1_H
	sts	WDATA_H,SysValueCopy
	rcall	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,70
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	lds	SysValueCopy,PY2
	sts	WDATA,SysValueCopy
	lds	SysValueCopy,PY2_H
	sts	WDATA_H,SysValueCopy
	rcall	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,78
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	lds	SysValueCopy,PX1
	sts	WDATA,SysValueCopy
	lds	SysValueCopy,PX1_H
	sts	WDATA_H,SysValueCopy
	rcall	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,79
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	lds	SysValueCopy,PY1
	sts	WDATA,SysValueCopy
	lds	SysValueCopy,PY1_H
	sts	WDATA_H,SysValueCopy
	rcall	WRITE_COMMAND_DATA_SSD1289
	ldi	SysValueCopy,34
	sts	WCOMMAND,SysValueCopy
	ldi	SysValueCopy,0
	sts	WCOMMAND_H,SysValueCopy
	rcall	WRITE_COMMAND_SSD1289
	lds	SysValueCopy,GLCDTEMPXY
	sts	PX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	PX2_H,SysValueCopy
	ret

;********************************************************************************

FN_STR:
	ldi	SysValueCopy,0
	sts	SYSCHARCOUNT,SysValueCopy
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,39
	rcall	SYSCOMPLESSTHAN16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF44
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,39
	rcall	SYSDIVSUB16
	sts	SYSSTRDATA,SysWORDTempA
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
	ldi	SysTemp5,low(STR)
	add	SysTemp3,SysTemp5
	mov	SysStringA,SysTemp3
	ldi	SysTemp5,0
	ldi	SysTemp6,high(STR)
	adc	SysTemp5,SysTemp6
	mov	SysStringA_H,SysTemp5
	lds	SysTemp3,SYSSTRDATA
	ldi	SysTemp5,48
	add	SysTemp3,SysTemp5
	st	X,SysTemp3
	rjmp	SYSVALTHOUSANDS
ENDIF44:
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	rcall	SYSCOMPLESSTHAN16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF45
SYSVALTHOUSANDS:
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	rcall	SYSDIVSUB16
	sts	SYSSTRDATA,SysWORDTempA
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
	ldi	SysTemp5,low(STR)
	add	SysTemp3,SysTemp5
	mov	SysStringA,SysTemp3
	ldi	SysTemp5,0
	ldi	SysTemp6,high(STR)
	adc	SysTemp5,SysTemp6
	mov	SysStringA_H,SysTemp5
	lds	SysTemp3,SYSSTRDATA
	ldi	SysTemp5,48
	add	SysTemp3,SysTemp5
	st	X,SysTemp3
	rjmp	SYSVALHUNDREDS
ENDIF45:
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SYSCOMPLESSTHAN16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF46
SYSVALHUNDREDS:
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SYSDIVSUB16
	sts	SYSSTRDATA,SysWORDTempA
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
	ldi	SysTemp5,low(STR)
	add	SysTemp3,SysTemp5
	mov	SysStringA,SysTemp3
	ldi	SysTemp5,0
	ldi	SysTemp6,high(STR)
	adc	SysTemp5,SysTemp6
	mov	SysStringA_H,SysTemp5
	lds	SysTemp3,SYSSTRDATA
	ldi	SysTemp5,48
	add	SysTemp3,SysTemp5
	st	X,SysTemp3
	rjmp	SYSVALTENS
ENDIF46:
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SYSCOMPLESSTHAN16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF47
SYSVALTENS:
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SYSDIVSUB16
	sts	SYSSTRDATA,SysWORDTempA
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
	ldi	SysTemp5,low(STR)
	add	SysTemp3,SysTemp5
	mov	SysStringA,SysTemp3
	ldi	SysTemp5,0
	ldi	SysTemp6,high(STR)
	adc	SysTemp5,SysTemp6
	mov	SysStringA_H,SysTemp5
	lds	SysTemp3,SYSSTRDATA
	ldi	SysTemp5,48
	add	SysTemp3,SysTemp5
	st	X,SysTemp3
ENDIF47:
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
	ldi	SysTemp5,low(STR)
	add	SysTemp3,SysTemp5
	mov	SysStringA,SysTemp3
	ldi	SysTemp5,0
	ldi	SysTemp6,high(STR)
	adc	SysTemp5,SysTemp6
	mov	SysStringA_H,SysTemp5
	lds	SysTemp3,SYSVALTEMP
	ldi	SysTemp5,48
	add	SysTemp3,SysTemp5
	st	X,SysTemp3
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
	lds	SysValueCopy,SYSCHARCOUNT
	sts	SYSSTR_0,SysValueCopy
	ret

;********************************************************************************

SWAP149:
	mov	SYSCALCTEMPX,SYSCALCTEMPA
	mov	SYSCALCTEMPX_H,SYSCALCTEMPA_H
	mov	SYSCALCTEMPA,SYSCALCTEMPB
	mov	SYSCALCTEMPA_H,SYSCALCTEMPB_H
	mov	SYSCALCTEMPB,SYSCALCTEMPX
	mov	SYSCALCTEMPB_H,SYSCALCTEMPX_H
	ret

;********************************************************************************

SYSCOMPEQUAL:
	clr	SYSBYTETEMPX
	cpse	SYSBYTETEMPA, SYSBYTETEMPB
	ret
	com	SYSBYTETEMPX
	ret

;********************************************************************************

SYSCOMPEQUAL16:
	clr	SYSBYTETEMPX
	cp	SYSWORDTEMPA, SYSWORDTEMPB
	brne	SCE16FALSE
	cp	SYSWORDTEMPA_H, SYSWORDTEMPB_H
	brne	SCE16FALSE
	com	SYSBYTETEMPX
SCE16FALSE:
	ret

;********************************************************************************

SYSCOMPEQUAL32:
	clr	SYSBYTETEMPX
	cp	SYSLONGTEMPA, SYSLONGTEMPB
	brne	SCE32FALSE
	cp	SYSLONGTEMPA_H, SYSLONGTEMPB_H
	brne	SCE32FALSE
	cp	SYSLONGTEMPA_U, SYSLONGTEMPB_U
	brne	SCE32FALSE
	cp	SYSLONGTEMPA_E, SYSLONGTEMPB_E
	brne	SCE32FALSE
	com	SYSBYTETEMPX
SCE32FALSE:
	ret

;********************************************************************************

SYSCOMPLESSTHAN:
	clr	SYSBYTETEMPX
	cp	SYSBYTETEMPA,SYSBYTETEMPB
	brlo	SCLTTRUE
	ret
SCLTTRUE:
	com	SYSBYTETEMPX
	ret

;********************************************************************************

SYSCOMPLESSTHAN16:
	clr	SYSBYTETEMPX
	cp	SYSWORDTEMPB_H,SYSWORDTEMPA_H
	brlo	SCLT16FALSE
	cp	SYSWORDTEMPA_H,SYSWORDTEMPB_H
	brlo	SCLT16TRUE
	cp	SYSWORDTEMPA,SYSWORDTEMPB
	brlo	SCLT16TRUE
	ret
SCLT16TRUE:
	com	SYSBYTETEMPX
SCLT16FALSE:
	ret

;********************************************************************************

SYSCOMPLESSTHAN32:
	clr	SYSBYTETEMPX
	cp	SYSLONGTEMPB_E,SYSLONGTEMPA_E
	brlo	SCLT32FALSE
	brne	SCLT32TRUE
	cp	SYSLONGTEMPB_U,SYSLONGTEMPA_U
	brlo	SCLT32FALSE
	brne	SCLT32TRUE
	cp	SYSLONGTEMPB_H,SYSLONGTEMPA_H
	brlo	SCLT32FALSE
	brne	SCLT32TRUE
	cp	SYSLONGTEMPA,SYSLONGTEMPB
	brlo	SCLT32TRUE
	ret
SCLT32TRUE:
	com	SYSBYTETEMPX
SCLT32FALSE:
	ret

;********************************************************************************

SYSCOMPLESSTHANINT:
	ldi	SysValueCopy,0
	mov	SYSBYTETEMPX,SysValueCopy
	sbrs	SYSINTEGERTEMPA_H,7
	rjmp	ELSE84_1
	sbrc	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF85
	mov	SysTemp3,SYSBYTETEMPX
	com	SysTemp3
	mov	SYSBYTETEMPX,SysTemp3
	ret
ENDIF85:
	mov	SysTemp1,SYSINTEGERTEMPA
	mov	SysTemp1_H,SYSINTEGERTEMPA_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSDIVMULTA,SysTemp1
	mov	SYSDIVMULTA_H,SysTemp1_H
	mov	SysTemp1,SYSINTEGERTEMPB
	mov	SysTemp1_H,SYSINTEGERTEMPB_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPA,SysTemp1
	mov	SYSINTEGERTEMPA_H,SysTemp1_H
	mov	SYSINTEGERTEMPB,SYSDIVMULTA
	mov	SYSINTEGERTEMPB_H,SYSDIVMULTA_H
	rjmp	ENDIF84
ELSE84_1:
	sbrc	SYSINTEGERTEMPB_H,7
	ret
ENDIF84:
	cp	SYSINTEGERTEMPB_H,SYSINTEGERTEMPA_H
	brlo	SCLTINTFALSE
	cp	SYSINTEGERTEMPA_H,SYSINTEGERTEMPB_H
	brlo	SCLTINTTRUE
	cp	SYSINTEGERTEMPA,SYSINTEGERTEMPB
	brlo	SCLTINTTRUE
	ret
SCLTINTTRUE:
	com	SYSBYTETEMPX
SCLTINTFALSE:
	ret

;********************************************************************************

SYSCOPYSTRING:
	ld	SYSCALCTEMPA, X+
	st	Y+, SYSCALCTEMPA
	rjmp	SYSCOPYSTRINGCHECK
SYSCOPYSTRINGPART:
	ld	SYSCALCTEMPA, X+
	add	SYSSTRINGLENGTH, SYSCALCTEMPA
SYSCOPYSTRINGCHECK:
	cpi	SYSCALCTEMPA,0
	brne	SYSSTRINGCOPY
	ret
SYSSTRINGCOPY:
	ld	SYSREADA, X+
	st	Y+, SYSREADA
	dec	SYSCALCTEMPA
	brne	SYSSTRINGCOPY
	ret

;********************************************************************************

SYSDIVSUB16:
	mov	SYSDIVMULTA,SYSWORDTEMPA
	mov	SYSDIVMULTA_H,SYSWORDTEMPA_H
	mov	SYSDIVMULTB,SYSWORDTEMPB
	mov	SYSDIVMULTB_H,SYSWORDTEMPB_H
	ldi	SysValueCopy,0
	mov	SYSDIVMULTX,SysValueCopy
	ldi	SysValueCopy,0
	mov	SYSDIVMULTX_H,SysValueCopy
	mov	SysWORDTempA,SYSDIVMULTB
	mov	SysWORDTempA_H,SYSDIVMULTB_H
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,0
	rcall	SYSCOMPEQUAL16
	sbrs	SysByteTempX,0
	rjmp	ENDIF37
	ldi	SYSWORDTEMPA,0
	ldi	SYSWORDTEMPA_H,0
	ret
ENDIF37:
	ldi	SysValueCopy,16
	mov	SYSDIVLOOP,SysValueCopy
SYSDIV16START:
	clc
	rol	SYSDIVMULTA
	rol	SYSDIVMULTA_H
	rol	SYSDIVMULTX
	rol	SYSDIVMULTX_H
	mov	SysTemp3,SYSDIVMULTX
	sub	SysTemp3,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp3
	mov	SysTemp3,SYSDIVMULTX_H
	sbc	SysTemp3,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp3
	sbr	 SYSDIVMULTA,1<<0
	brbc	C,ENDIF38
	cbr	 SYSDIVMULTA,1<<0
	mov	SysTemp3,SYSDIVMULTX
	add	SysTemp3,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp3
	mov	SysTemp3,SYSDIVMULTX_H
	adc	SysTemp3,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp3
ENDIF38:
	dec	SYSDIVLOOP
	brne	SYSDIV16START
	mov	SYSWORDTEMPA,SYSDIVMULTA
	mov	SYSWORDTEMPA_H,SYSDIVMULTA_H
	mov	SYSWORDTEMPX,SYSDIVMULTX
	mov	SYSWORDTEMPX_H,SYSDIVMULTX_H
	ret

;********************************************************************************

SYSDIVSUB32:
	sts	SYSLONGDIVMULTA,SYSLONGTEMPA
	sts	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	sts	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	sts	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
	sts	SYSLONGDIVMULTB,SYSLONGTEMPB
	sts	SYSLONGDIVMULTB_H,SYSLONGTEMPB_H
	sts	SYSLONGDIVMULTB_U,SYSLONGTEMPB_U
	sts	SYSLONGDIVMULTB_E,SYSLONGTEMPB_E
	ldi	SysValueCopy,0
	sts	SYSLONGDIVMULTX,SysValueCopy
	sts	SYSLONGDIVMULTX_H,SysValueCopy
	sts	SYSLONGDIVMULTX_U,SysValueCopy
	sts	SYSLONGDIVMULTX_E,SysValueCopy
	lds	SysLONGTempA,SYSLONGDIVMULTB
	lds	SysLONGTempA_H,SYSLONGDIVMULTB_H
	lds	SysLONGTempA_U,SYSLONGDIVMULTB_U
	lds	SysLONGTempA_E,SYSLONGDIVMULTB_E
	ldi	SysLONGTempB,0
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	rcall	SYSCOMPEQUAL32
	sbrs	SysByteTempX,0
	rjmp	ENDIF42
	ldi	SYSLONGTEMPA,0
	ldi	SYSLONGTEMPA_H,0
	ldi	SYSLONGTEMPA_U,0
	ldi	SYSLONGTEMPA_E,0
	ret
ENDIF42:
	ldi	SysValueCopy,32
	mov	SYSDIVLOOP,SysValueCopy
SYSDIV32START:
	clc
	lds	SysValueCopy,SYSLONGDIVMULTA
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_H
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_H,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_U
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_U,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_E
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_E,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTX
	rol	SysValueCopy
	sts	SYSLONGDIVMULTX,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTX_H
	rol	SysValueCopy
	sts	SYSLONGDIVMULTX_H,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTX_U
	rol	SysValueCopy
	sts	SYSLONGDIVMULTX_U,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTX_E
	rol	SysValueCopy
	sts	SYSLONGDIVMULTX_E,SysValueCopy
	lds	SysTemp3,SYSLONGDIVMULTX
	lds	SysTemp4,SYSLONGDIVMULTB
	sub	SysTemp3,SysTemp4
	sts	SYSLONGDIVMULTX,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_H
	lds	SysTemp4,SYSLONGDIVMULTB_H
	sbc	SysTemp3,SysTemp4
	sts	SYSLONGDIVMULTX_H,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_U
	lds	SysTemp4,SYSLONGDIVMULTB_U
	sbc	SysTemp3,SysTemp4
	sts	SYSLONGDIVMULTX_U,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_E
	lds	SysTemp4,SYSLONGDIVMULTB_E
	sbc	SysTemp3,SysTemp4
	sts	SYSLONGDIVMULTX_E,SysTemp3
	lds	SysValueCopy,SYSLONGDIVMULTA
	sbr	SysValueCopy,1<<0
	sts	SYSLONGDIVMULTA,SysValueCopy
	brbc	C,ENDIF43
	lds	SysValueCopy,SYSLONGDIVMULTA
	cbr	SysValueCopy,1<<0
	sts	SYSLONGDIVMULTA,SysValueCopy
	lds	SysTemp3,SYSLONGDIVMULTX
	lds	SysTemp4,SYSLONGDIVMULTB
	add	SysTemp3,SysTemp4
	sts	SYSLONGDIVMULTX,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_H
	lds	SysTemp4,SYSLONGDIVMULTB_H
	adc	SysTemp3,SysTemp4
	sts	SYSLONGDIVMULTX_H,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_U
	lds	SysTemp4,SYSLONGDIVMULTB_U
	adc	SysTemp3,SysTemp4
	sts	SYSLONGDIVMULTX_U,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_E
	lds	SysTemp4,SYSLONGDIVMULTB_E
	adc	SysTemp3,SysTemp4
	sts	SYSLONGDIVMULTX_E,SysTemp3
ENDIF43:
	dec	SYSDIVLOOP
	breq	SYSDIV32END
	rjmp	SYSDIV32START
SYSDIV32END:
	lds	SYSLONGTEMPA,SYSLONGDIVMULTA
	lds	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	lds	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	lds	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
	lds	SYSLONGTEMPX,SYSLONGDIVMULTX
	lds	SYSLONGTEMPX_H,SYSLONGDIVMULTX_H
	lds	SYSLONGTEMPX_U,SYSLONGDIVMULTX_U
	lds	SYSLONGTEMPX_E,SYSLONGDIVMULTX_E
	ret

;********************************************************************************

SYSDIVSUBINT:
	mov	SysTemp3,SYSINTEGERTEMPB_H
	eor	SysTemp3,SYSINTEGERTEMPA_H
	mov	SYSSIGNBYTE,SysTemp3
	sbrs	SYSINTEGERTEMPA_H,7
	rjmp	ENDIF39
	mov	SysTemp1,SYSINTEGERTEMPA
	mov	SysTemp1_H,SYSINTEGERTEMPA_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPA,SysTemp1
	mov	SYSINTEGERTEMPA_H,SysTemp1_H
ENDIF39:
	sbrs	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF40
	mov	SysTemp1,SYSINTEGERTEMPB
	mov	SysTemp1_H,SYSINTEGERTEMPB_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPB,SysTemp1
	mov	SYSINTEGERTEMPB_H,SysTemp1_H
ENDIF40:
	rcall	SYSDIVSUB16
	sbrs	SYSSIGNBYTE,7
	rjmp	ENDIF41
	mov	SysTemp1,SYSINTEGERTEMPA
	mov	SysTemp1_H,SYSINTEGERTEMPA_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPA,SysTemp1
	mov	SYSINTEGERTEMPA_H,SysTemp1_H
	mov	SysTemp1,SYSINTEGERTEMPX
	mov	SysTemp1_H,SYSINTEGERTEMPX_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPX,SysTemp1
	mov	SYSINTEGERTEMPX_H,SysTemp1_H
ENDIF41:
	ret

;********************************************************************************

SYSMULTSUB16:
	mov	SYSDIVMULTA,SYSWORDTEMPA
	mov	SYSDIVMULTA_H,SYSWORDTEMPA_H
	mov	SYSDIVMULTB,SYSWORDTEMPB
	mov	SYSDIVMULTB_H,SYSWORDTEMPB_H
	ldi	SysValueCopy,0
	mov	SYSDIVMULTX,SysValueCopy
	ldi	SysValueCopy,0
	mov	SYSDIVMULTX_H,SysValueCopy
MUL16LOOP:
	sbrs	SYSDIVMULTB,0
	rjmp	ENDIF33
	mov	SysTemp3,SYSDIVMULTX
	add	SysTemp3,SYSDIVMULTA
	mov	SYSDIVMULTX,SysTemp3
	mov	SysTemp3,SYSDIVMULTX_H
	adc	SysTemp3,SYSDIVMULTA_H
	mov	SYSDIVMULTX_H,SysTemp3
ENDIF33:
	clc
	ror	SYSDIVMULTB_H
	ror	SYSDIVMULTB
	clc
	rol	SYSDIVMULTA
	rol	SYSDIVMULTA_H
	mov	SysWORDTempB,SYSDIVMULTB
	mov	SysWORDTempB_H,SYSDIVMULTB_H
	ldi	SysWORDTempA,0
	ldi	SysWORDTempA_H,0
	rcall	SYSCOMPLESSTHAN16
	sbrc	SysByteTempX,0
	rjmp	MUL16LOOP
	mov	SYSWORDTEMPX,SYSDIVMULTX
	mov	SYSWORDTEMPX_H,SYSDIVMULTX_H
	ret

;********************************************************************************

SYSMULTSUB32:
	sts	SYSLONGDIVMULTA,SYSLONGTEMPA
	sts	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	sts	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	sts	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
	sts	SYSLONGDIVMULTB,SYSLONGTEMPB
	sts	SYSLONGDIVMULTB_H,SYSLONGTEMPB_H
	sts	SYSLONGDIVMULTB_U,SYSLONGTEMPB_U
	sts	SYSLONGDIVMULTB_E,SYSLONGTEMPB_E
	ldi	SysValueCopy,0
	sts	SYSLONGDIVMULTX,SysValueCopy
	sts	SYSLONGDIVMULTX_H,SysValueCopy
	sts	SYSLONGDIVMULTX_U,SysValueCopy
	sts	SYSLONGDIVMULTX_E,SysValueCopy
MUL32LOOP:
	lds	SysBitTest,SYSLONGDIVMULTB
	sbrs	SysBitTest,0
	rjmp	ENDIF35
	lds	SysTemp3,SYSLONGDIVMULTX
	lds	SysTemp4,SYSLONGDIVMULTA
	add	SysTemp3,SysTemp4
	sts	SYSLONGDIVMULTX,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_H
	lds	SysTemp4,SYSLONGDIVMULTA_H
	adc	SysTemp3,SysTemp4
	sts	SYSLONGDIVMULTX_H,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_U
	lds	SysTemp4,SYSLONGDIVMULTA_U
	adc	SysTemp3,SysTemp4
	sts	SYSLONGDIVMULTX_U,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_E
	lds	SysTemp4,SYSLONGDIVMULTA_E
	adc	SysTemp3,SysTemp4
	sts	SYSLONGDIVMULTX_E,SysTemp3
ENDIF35:
	clc
	lds	SysValueCopy,SYSLONGDIVMULTB_E
	ror	SysValueCopy
	sts	SYSLONGDIVMULTB_E,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTB_U
	ror	SysValueCopy
	sts	SYSLONGDIVMULTB_U,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTB_H
	ror	SysValueCopy
	sts	SYSLONGDIVMULTB_H,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTB
	ror	SysValueCopy
	sts	SYSLONGDIVMULTB,SysValueCopy
	clc
	lds	SysValueCopy,SYSLONGDIVMULTA
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_H
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_H,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_U
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_U,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_E
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_E,SysValueCopy
	lds	SysLONGTempB,SYSLONGDIVMULTB
	lds	SysLONGTempB_H,SYSLONGDIVMULTB_H
	lds	SysLONGTempB_U,SYSLONGDIVMULTB_U
	lds	SysLONGTempB_E,SYSLONGDIVMULTB_E
	ldi	SysLONGTempA,0
	ldi	SysLONGTempA_H,0
	ldi	SysLONGTempA_U,0
	ldi	SysLONGTempA_E,0
	rcall	SYSCOMPLESSTHAN32
	sbrc	SysByteTempX,0
	rjmp	MUL32LOOP
	lds	SYSLONGTEMPX,SYSLONGDIVMULTX
	lds	SYSLONGTEMPX_H,SYSLONGDIVMULTX_H
	lds	SYSLONGTEMPX_U,SYSLONGDIVMULTX_U
	lds	SYSLONGTEMPX_E,SYSLONGDIVMULTX_E
	ret

;********************************************************************************

SYSMULTSUBINT:
	mov	SysTemp3,SYSINTEGERTEMPB_H
	eor	SysTemp3,SYSINTEGERTEMPA_H
	mov	SYSSIGNBYTE,SysTemp3
	sbrs	SYSINTEGERTEMPA_H,7
	rjmp	ENDIF81
	mov	SysTemp1,SYSINTEGERTEMPA
	mov	SysTemp1_H,SYSINTEGERTEMPA_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPA,SysTemp1
	mov	SYSINTEGERTEMPA_H,SysTemp1_H
ENDIF81:
	sbrs	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF82
	mov	SysTemp1,SYSINTEGERTEMPB
	mov	SysTemp1_H,SYSINTEGERTEMPB_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPB,SysTemp1
	mov	SYSINTEGERTEMPB_H,SysTemp1_H
ENDIF82:
	rcall	SYSMULTSUB16
	sbrs	SYSSIGNBYTE,7
	rjmp	ENDIF83
	mov	SysTemp1,SYSINTEGERTEMPX
	mov	SysTemp1_H,SYSINTEGERTEMPX_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPX,SysTemp1
	mov	SYSINTEGERTEMPX_H,SysTemp1_H
ENDIF83:
	ret

;********************************************************************************

SYSREADSTRING:
	lpm
	mov	SYSCALCTEMPA, SYSCALCTEMPX
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
	st	Y+, SYSCALCTEMPA
	rjmp	SYSSTRINGREADCHECK
SYSREADSTRINGPART:
	lpm
	mov	SYSCALCTEMPA, SYSCALCTEMPX
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
	add	SYSSTRINGLENGTH, SYSCALCTEMPA
SYSSTRINGREADCHECK:
	cpi	SYSCALCTEMPA, 0
	brne	SYSSTRINGREAD
	ret
SYSSTRINGREAD:
	lpm
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
	st	Y+, SYSCALCTEMPX
	dec	SYSCALCTEMPA
	brne	SYSSTRINGREAD
	ret

;********************************************************************************

SysStringTables:

StringTable1:
.DB	13,71,67,66,65,83,73,67,32,118,49,46,120,120


StringTable2:
.DB	1,55


StringTable3:
.DB	1,56


StringTable4:
.DB	1,57


StringTable5:
.DB	1,47


StringTable6:
.DB	1,52


StringTable7:
.DB	1,53


StringTable8:
.DB	1,54


StringTable9:
.DB	1,42


StringTable10:
.DB	1,49


StringTable11:
.DB	1,50


StringTable12:
.DB	1,51


StringTable13:
.DB	1,45


StringTable14:
.DB	1,48


StringTable15:
.DB	1,46


StringTable16:
.DB	1,43


StringTable17:
.DB	1,67


StringTable18:
.DB	1,61


StringTable19:
.DB	20,64,68,105,109,105,116,114,105,115,32,75,97,116,115,97,111,117,110,105,115,0


StringTable20:
.DB	18,71,67,66,97,115,105,99,32,67,97,108,99,117,108,97,116,111,114,0


StringTable21:
.DB	0,0


StringTable22:
.DB	20,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,0


StringTable23:
.DB	20,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,48,0


;********************************************************************************

FN_VAL:
	ldi	SysValueCopy,0
	sts	VAL,SysValueCopy
	sts	VAL_H,SysValueCopy
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysValueCopy,X
	sts	SYSCHARCOUNT,SysValueCopy
	lds	SysCalcTempA,SYSCHARCOUNT
	tst	SysCalcTempA
	brne	ENDIF48
	ret
ENDIF48:
	ldi	SysValueCopy,1
	sts	SYSSTRINGTEMP,SysValueCopy
SysForLoop1:
	lds	SysTemp3,SysSYSINSTRINGHandler
	lds	SysTemp4,SYSSTRINGTEMP
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SysSYSINSTRINGHandler_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	SYSSTRDATA,SysValueCopy
	lds	SysCalcTempA,SYSSTRDATA
	cpi	SysCalcTempA,48
	brsh	ENDIF49
	ret
ENDIF49:
	ldi	SysCalcTempA,57
	lds	SysCalcTempB,SYSSTRDATA
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF50
	ret
ENDIF50:
	lds	SysWORDTempA,VAL
	lds	SysWORDTempA_H,VAL_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SYSMULTSUB16
	mov	SysTemp3,SysWORDTempX
	lds	SysTemp4,SYSSTRDATA
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	mov	SysTemp3,SysWORDTempX_H
	ldi	SysTemp5,0
	adc	SysTemp3,SysTemp5
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp5,48
	sub	SysTemp1,SysTemp5
	sts	VAL,SysTemp1
	ldi	SysTemp5,0
	sbc	SysTemp1_H,SysTemp5
	sts	VAL_H,SysTemp1_H
	lds	SysTemp4,SYSCHARCOUNT
	lds	SysTemp1,SYSSTRINGTEMP
	sub	SysTemp4,SysTemp1
	mov	SysTemp3,SysTemp4
	mov	SysBYTETempA,SysTemp3
	ldi	SysBYTETempB,0
	rcall	SYSCOMPEQUAL
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF51
	lds	SysTemp3,SYSSTRINGTEMP
	inc	SysTemp3
	sts	SYSSTRINGTEMP,SysTemp3
	rjmp	SysForLoop1
ENDIF51:
SysForLoopEnd1:
	ret

;********************************************************************************

WRITE_COMMAND_DATA_SSD1289:
	rcall	WRITE_COMMAND_SSD1289
	rjmp	WRITE_DATA_SSD1289

;********************************************************************************

WRITE_COMMAND_SSD1289:
	cbi	PORTD,7
	lds	SysValueCopy,WCOMMAND
	sts	DATAVAL,SysValueCopy
	lds	SysValueCopy,WCOMMAND_H
	sts	DATAVAL_H,SysValueCopy
	rcall	SETBUS_SSD1289
	cbi	PORTG,2
	sbi	PORTG,2
	ret

;********************************************************************************

WRITE_DATA_SSD1289:
	sbi	PORTD,7
	lds	SysValueCopy,WDATA
	sts	DATAVAL,SysValueCopy
	lds	SysValueCopy,WDATA_H
	sts	DATAVAL_H,SysValueCopy
	rcall	SETBUS_SSD1289
	cbi	PORTG,2
	sbi	PORTG,2
	ret

;********************************************************************************


