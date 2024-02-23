;Program compiled by GCBASIC (2024.2.13 (Windows 64 bit) : Build 1335) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2024-02-13 CRC247
;Need help? 
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   w_cholmondeley at users dot sourceforge dot net
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Source file    : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\18Fx6q20_ChipRange_Demonstrations\160_ensuring_program_matches_chip_specfiied_to_serial_terminal.gcb
;   Setting file   : C:\GCstudio\gcbasic\use.ini
;   Preserve mode  : 0
;   Assembler      : GCASM
;   Programmer     : 
;   Output file    : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\18Fx6q20_ChipRange_Demonstrations\160_ensuring_program_matches_chip_specfiied_to_serial_terminal.asm
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F16Q20, r=DEC
#include <P18F16Q20.inc>
 CONFIG  CPD = OFF
 CONFIG  CP = OFF
 CONFIG  WRTSAF = OFF
 CONFIG  WRTD = OFF
 CONFIG  WRTB = OFF
 CONFIG  VDDIO2MD = STANDARD_RANGE
 CONFIG  WDTE = OFF
 CONFIG  XINST = OFF
 CONFIG  LVP = OFF
 CONFIG  MVECEN = OFF
 CONFIG  MCLRE = INTMCLR
 CONFIG  FCMEN = ON
 CONFIG  CLKOUTEN = OFF
 CONFIG  RSTOSC = HFINTOSC_1MHZ
 CONFIG  FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
ASC                              EQU    1291          ; 0x50B
COMPORT                          EQU    1292          ; 0x50C
DELAYTEMP                        EQU    1280          ; 0x500
DELAYTEMP2                       EQU    1281          ; 0x501
HSERPRINTCRLFCOUNT               EQU    1293          ; 0x50D
LTRIM                            EQU    5270          ; 0x1496
MID                              EQU    5229          ; 0x146D
PRINTLEN                         EQU    1294          ; 0x50E
RTRIM                            EQU    5188          ; 0x1444
SERDATA                          EQU    1295          ; 0x50F
STRINGPOINTER                    EQU    1296          ; 0x510
SYSARRAYTEMP1                    EQU    1297          ; 0x511
SYSARRAYTEMP2                    EQU    1298          ; 0x512
SYSBYTETEMPA                     EQU    1285          ; 0x505
SYSBYTETEMPB                     EQU    1289          ; 0x509
SYSBYTETEMPX                     EQU    1280          ; 0x500
SYSCALCTEMPA                     EQU    1285          ; 0x505
SYSCHAR                          EQU    1299          ; 0x513
SYSCHARCOUNT                     EQU    1300          ; 0x514
SYSCHARLT                        EQU    1301          ; 0x515
SYSCHARLTCOUNT                   EQU    1302          ; 0x516
SYSCHARRT                        EQU    1303          ; 0x517
SYSCHARRTCOUNT                   EQU    1304          ; 0x518
SYSCHARSTART                     EQU    1305          ; 0x519
SYSDIVMULTA                      EQU    1287          ; 0x507
SYSDIVMULTA_H                    EQU    1288          ; 0x508
SYSFORLOOPSTEP4                  EQU    1306          ; 0x51A
SYSFORLOOPSTEP4_H                EQU    1307          ; 0x51B
SYSINTEGERTEMPA                  EQU    1285          ; 0x505
SYSINTEGERTEMPA_H                EQU    1286          ; 0x506
SYSINTEGERTEMPB                  EQU    1289          ; 0x509
SYSINTEGERTEMPB_H                EQU    1290          ; 0x50A
SYSPRINTDATAHANDLER              EQU    1308          ; 0x51C
SYSPRINTDATAHANDLER_H            EQU    1309          ; 0x51D
SYSPRINTTEMP                     EQU    1310          ; 0x51E
SYSREPEATTEMP1                   EQU    1311          ; 0x51F
SYSSTRDATA                       EQU    1312          ; 0x520
SYSSTRINGA                       EQU    1287          ; 0x507
SYSSTRINGA_H                     EQU    1288          ; 0x508
SYSSTRINGLENGTH                  EQU    1286          ; 0x506
SYSSTRINGPARAM1                  EQU    5311          ; 0x14BF
SYSSTRINGTEMP                    EQU    1313          ; 0x521
SYSSYSINSTRING2HANDLER           EQU    1314          ; 0x522
SYSSYSINSTRING2HANDLER_H         EQU    1315          ; 0x523
SYSSYSINSTRING3HANDLER           EQU    1316          ; 0x524
SYSSYSINSTRING3HANDLER_H         EQU    1317          ; 0x525
SYSSYSINSTRINGAHANDLER           EQU    1318          ; 0x526
SYSSYSINSTRINGAHANDLER_H         EQU    1319          ; 0x527
SYSSYSINSTRINGHANDLER            EQU    1320          ; 0x528
SYSSYSINSTRINGHANDLER_H          EQU    1321          ; 0x529
SYSTEMP1                         EQU    1322          ; 0x52A
SYSTEMP2                         EQU    1323          ; 0x52B
SYSTEMP2_H                       EQU    1324          ; 0x52C
SYSTEMP3                         EQU    1325          ; 0x52D
SYSTEMPARRAY                     EQU    5147          ; 0x141B
SYSTEMPLT                        EQU    1326          ; 0x52E
SYSTEMPRT                        EQU    1327          ; 0x52F
SYSWAITTEMPMS                    EQU    1282          ; 0x502
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503
SYSWAITTEMPS                     EQU    1284          ; 0x504
TARGETCHIP                       EQU    5106          ; 0x13F2
TRIM                             EQU    5065          ; 0x13C9
UCASE                            EQU    5024          ; 0x13A0

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
SYSMID_0 EQU 5229
SYSUCASE_0 EQU 5024

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
	rcall	INITPPS
	rcall	INITUSART

;Start_of_the_main_program
	bcf	TRISC,7,ACCESS
	bcf	TRISC,6,ACCESS
	bcf	TRISC,5,ACCESS
	bcf	TRISC,4,ACCESS
	bsf	TRISA,0,ACCESS
	bsf	TRISA,3,ACCESS
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable97
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable97
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable97
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT314
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	movlw	1
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
	lfsr	1,TARGETCHIP
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low TARGETCHIP
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high TARGETCHIP
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	rcall	FN_UCASE
	movlw	low UCASE
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high UCASE
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	rcall	FN_TRIM
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable97
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable97
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable97
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	lfsr	0,TRIM
	lfsr	1,SYSTEMPARRAY
	rcall	SYSCOMPEQUALSTRING
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE1_1
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,TARGETCHIP
	rcall	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT314
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	movlw	low StringTable97
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable97
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable97
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT314
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
SysWaitLoop1
	bra	SysWaitLoop1
	bra	ENDIF1
ELSE1_1
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	movlw	low StringTable97
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable97
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable97
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT314
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
SysWaitLoop2
	bra	SysWaitLoop2
ENDIF1
	bra	BASPROGRAMEND
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

FN_ASC
	clrf	ASC,ACCESS
	movff	SysSYSINSTRINGAHandler,AFSR0
	movff	SysSYSINSTRINGAHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
	movf	SYSCHARCOUNT,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	return
	movf	SYSCHAR,W,ACCESS
	subwf	SYSCHARCOUNT,W,ACCESS
	btfss	STATUS, C,ACCESS
	return
	movf	SYSCHAR,W,ACCESS
	addwf	SysSYSINSTRINGAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ASC
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	129
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	40
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

HSERPRINT314
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF12
	movlw	1
	movwf	SYSPRINTTEMP,ACCESS
SysForLoop3
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND304
	movf	SYSPRINTTEMP,W,ACCESS
	subwf	PRINTLEN,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF13
	incf	SYSPRINTTEMP,F,ACCESS
	bra	SysForLoop3
ENDIF13
SysForLoopEnd3
ENDIF12
	return

;********************************************************************************

HSERPRINTCRLF
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd1
SysRepeatLoop1
	movlw	13
	movwf	SERDATA,ACCESS
	rcall	HSERSEND304
	movlw	10
	movwf	SERDATA,ACCESS
	rcall	HSERSEND304
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

HSERSEND304
HSERSENDUSART1HANDLER
SysWaitLoop3
	btfss	PIR6,U1TXIF,ACCESS
	bra	SysWaitLoop3
	movff	SERDATA,U1TXB
	return

;********************************************************************************

INITPPS
	bcf	TRISB,7,ACCESS
	movlw	19
	banksel	RB7PPS
	movwf	RB7PPS,BANKED
	banksel	0
	return

;********************************************************************************

INITSYS
	movlb	0
;asm showdebug Default settings for microcontrollers with _OSCCON1_
	movlw	96
	movwf	OSCCON1,BANKED
	clrf	OSCCON3,BANKED
	clrf	OSCEN,BANKED
	clrf	OSCTUNE,BANKED
;asm showdebug The MCU is a chip family 16
;asm showdebug OSCCON type is 101
	movlw	96
	movwf	OSCCON1,BANKED
	movlw	8
	movwf	OSCFRQ,BANKED
;asm showdebug _Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
	clrf	TBLPTRU,ACCESS
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
	bcf	ADCON0,ADON,BANKED
	banksel	ANSELA
	clrf	ANSELA,BANKED
	clrf	ANSELB,BANKED
	clrf	ANSELC,BANKED
	clrf	PORTA,ACCESS
	clrf	PORTB,ACCESS
	clrf	PORTC,ACCESS
	banksel	0
	return

;********************************************************************************

INITUSART
	movlw	1
	movwf	COMPORT,ACCESS
	movlw	6
	banksel	U1BRGH
	movwf	U1BRGH,BANKED
	movlw	129
	movwf	U1BRGL,BANKED
	bsf	U1CON0,U1BRGS,BANKED
	bsf	U1CON0,U1TXEN,BANKED
	bsf	U1CON0,U1RXEN,BANKED
	bsf	U1CON1,ON_U1CON1,BANKED
	banksel	I3C1EC
	bsf	I3C1EC,CREN,BANKED
	return

;********************************************************************************

FN_LTRIM
	lfsr	1,LTRIM
	movlw	low StringTable50
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable50
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable50
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movff	SysSYSINSTRING2Handler,AFSR0
	movff	SysSYSINSTRING2Handler_H,AFSR0_H
	movff	INDF0,SYSCHARLTCOUNT
	movf	SYSCHARLTCOUNT,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	return
	clrf	SYSCHARLT,ACCESS
	movlw	1
	movwf	SYSTEMPLT,ACCESS
SysForLoop1
	movff	SysSYSINSTRING2Handler,SysSYSINSTRINGHandler
	movff	SysSYSINSTRING2Handler_H,SysSYSINSTRINGHandler_H
	movff	SYSTEMPLT,SYSCHARSTART
	movlw	1
	movwf	SYSCHARCOUNT,ACCESS
	rcall	FN_MID
	movlw	low MID
	movwf	SysSYSINSTRINGAHandler,ACCESS
	movlw	high MID
	movwf	SysSYSINSTRINGAHandler_H,ACCESS
	movlw	1
	movwf	SYSCHAR,ACCESS
	rcall	FN_ASC
	movlw	32
	subwf	ASC,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF3
	movff	SYSTEMPLT,SYSCHARLT
	bra	FOUNDNONSPACECHAR1
ENDIF3
	movf	SYSTEMPLT,W,ACCESS
	subwf	SYSCHARLTCOUNT,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF4
	incf	SYSTEMPLT,F,ACCESS
	bra	SysForLoop1
ENDIF4
SysForLoopEnd1
FOUNDNONSPACECHAR1
	movf	SYSCHARLT,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF5
	movff	SysSYSINSTRING2Handler,SysSYSINSTRINGHandler
	movff	SysSYSINSTRING2Handler_H,SysSYSINSTRINGHandler_H
	movff	SYSCHARLT,SYSCHARSTART
	setf	SYSCHARCOUNT,ACCESS
	rcall	FN_MID
	lfsr	1,LTRIM
	lfsr	0,MID
	rcall	SYSCOPYSTRING
	return
ENDIF5
	return

;********************************************************************************

FN_MID
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF14
	banksel	SYSMID_0
	clrf	SYSMID_0,BANKED
	banksel	0
	return
ENDIF14
	movlw	1
	subwf	SYSCHARSTART,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF15
	movlw	1
	movwf	SYSCHARSTART,ACCESS
ENDIF15
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARSTART,W,ACCESS
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF16
	banksel	SYSMID_0
	clrf	SYSMID_0,BANKED
	banksel	0
	return
ENDIF16
	decf	SYSCHARSTART,F,ACCESS
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARSTART,W,ACCESS
	subwf	INDF0,W,ACCESS
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP,BANKED
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	SYSSTRINGTEMP,SYSCHARCOUNT
	movlw	1
	movwf	SYSSTRINGTEMP,BANKED
SysForLoop4
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SYSCHARSTART,W,ACCESS
	movwf	SysTemp1,ACCESS
	addwf	SysSYSINSTRINGHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,MID
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp2,POSTINC0
	movf	SYSSTRINGTEMP,W,BANKED
	subwf	SYSCHARCOUNT,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	banksel	0
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF18
	banksel	SYSSTRINGTEMP
	incf	SYSSTRINGTEMP,F,BANKED
	bra	SysForLoop4
ENDIF18
SysForLoopEnd4
	movffl	SYSCHARCOUNT,SYSMID_0
	return

;********************************************************************************

FN_RTRIM
	lfsr	1,RTRIM
	movlw	low StringTable50
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable50
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable50
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movff	SysSYSINSTRING3Handler,AFSR0
	movff	SysSYSINSTRING3Handler_H,AFSR0_H
	movff	INDF0,SYSCHARRTCOUNT
	movf	SYSCHARRTCOUNT,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	return
	clrf	SYSCHARRT,ACCESS
	movff	SYSCHARRTCOUNT,SYSTEMPRT
SysForLoop5
;Init SysForLoopStep4 :#0
	setf	SysForLoopStep4,ACCESS
	setf	SysForLoopStep4_H,ACCESS
	movf	SYSTEMPRT,W,ACCESS
	addwf	SysSYSINSTRING3Handler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRING3Handler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movlw	32
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF20
	movff	SYSTEMPRT,SYSCHARRT
	bra	FOUNDNONSPACECHAR2
ENDIF20
	btfss	SYSFORLOOPSTEP4_H,7,ACCESS
	bra	ELSE21_1
	decf	SYSTEMPRT,W,ACCESS
	movwf	SysTemp1,ACCESS
	comf	SysForLoopStep4,W,ACCESS
	movwf	SysTemp2,ACCESS
	comf	SysForLoopStep4_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	incf	SysTemp2,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SysTemp2_H,F,ACCESS
	movff	SysTemp1,SysINTEGERTempA
	clrf	SysINTEGERTempA_H,ACCESS
	movff	SysTemp2,SysINTEGERTempB
	movff	SysTemp2_H,SysINTEGERTempB_H
	rcall	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF23
	movf	SysForLoopStep4,W,ACCESS
	addwf	SYSTEMPRT,F,ACCESS
	bra	SysForLoop5
ENDIF23
	bra	ENDIF21
ELSE21_1
	movf	SYSTEMPRT,W,ACCESS
	sublw	1
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysINTEGERTempA
	clrf	SysINTEGERTempA_H,ACCESS
	movff	SysForLoopStep4,SysINTEGERTempB
	movff	SysForLoopStep4_H,SysINTEGERTempB_H
	rcall	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF24
	movf	SysForLoopStep4,W,ACCESS
	addwf	SYSTEMPRT,F,ACCESS
	bra	SysForLoop5
ENDIF24
ENDIF21
SysForLoopEnd5
FOUNDNONSPACECHAR2
	movf	SYSCHARRT,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF22
	movff	SysSYSINSTRING3Handler,SysSYSINSTRINGHandler
	movff	SysSYSINSTRING3Handler_H,SysSYSINSTRINGHandler_H
	movlw	1
	movwf	SYSCHARSTART,ACCESS
	movff	SYSCHARRT,SYSCHARCOUNT
	rcall	FN_MID
	lfsr	1,RTRIM
	lfsr	0,MID
	rcall	SYSCOPYSTRING
	return
ENDIF22
	return

;********************************************************************************

SYSCOMPEQUAL
	setf	SYSBYTETEMPX,ACCESS
	movf	SYSBYTETEMPB, W,ACCESS
	cpfseq	SYSBYTETEMPA,ACCESS
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOMPEQUALSTRING
	clrf	SYSBYTETEMPX,ACCESS
	movf	INDF0, W,ACCESS
	cpfseq	POSTINC1,ACCESS
	return
	movf	INDF0, F,ACCESS
	bz	SCESTRTRUE
	movff	POSTINC0, SYSBYTETEMPA
SYSSTRINGCOMP
	movf	POSTINC0, W,ACCESS
	cpfseq	POSTINC1,ACCESS
	return
	decfsz	SYSBYTETEMPA, F,ACCESS
	bra	SYSSTRINGCOMP
SCESTRTRUE
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOMPLESSTHANINT
	clrf	SYSBYTETEMPX,ACCESS
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ELSE25_1
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF26
	comf	SYSBYTETEMPX,F,ACCESS
	return
ENDIF26
	comf	SYSINTEGERTEMPA,W,ACCESS
	movwf	SYSDIVMULTA,ACCESS
	comf	SYSINTEGERTEMPA_H,W,ACCESS
	movwf	SYSDIVMULTA_H,ACCESS
	incf	SYSDIVMULTA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSDIVMULTA_H,F,ACCESS
	comf	SYSINTEGERTEMPB,W,ACCESS
	movwf	SYSINTEGERTEMPA,ACCESS
	comf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSINTEGERTEMPA_H,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
	movff	SYSDIVMULTA,SYSINTEGERTEMPB
	movff	SYSDIVMULTA_H,SYSINTEGERTEMPB_H
	bra	ENDIF25
ELSE25_1
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	return
ENDIF25
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	subwf	SYSINTEGERTEMPB_H,W,ACCESS
	btfss	STATUS,C,ACCESS
	return
	movf	SYSINTEGERTEMPB_H,W,ACCESS
	subwf	SYSINTEGERTEMPA_H,W,ACCESS
	bnc	SCLTINTTRUE
	movf	SYSINTEGERTEMPB,W,ACCESS
	subwf	SYSINTEGERTEMPA,W,ACCESS
	btfsc	STATUS,C,ACCESS
	return
SCLTINTTRUE
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

SYSCOPYSTRING
	movff	INDF0, SYSCALCTEMPA
	movff	SYSCALCTEMPA, INDF1
	bra	SYSCOPYSTRINGCHECK
SYSCOPYSTRINGPART
	movf	INDF0, W,ACCESS
	movwf	SYSCALCTEMPA,ACCESS
	addwf	SYSSTRINGLENGTH, F,ACCESS
SYSCOPYSTRINGCHECK
	movf	SYSCALCTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	return
SYSSTRINGCOPY
	movff	PREINC0, PREINC1
	decfsz	SYSCALCTEMPA, F,ACCESS
	bra	SYSSTRINGCOPY
	return

;********************************************************************************

SYSREADSTRING
	tblrd*+
	movff	TABLAT,SYSCALCTEMPA
	movff	TABLAT,INDF1
	bra	SYSSTRINGREADCHECK
SYSREADSTRINGPART
	tblrd*+
	movf	TABLAT, W,ACCESS
	movwf	SYSCALCTEMPA,ACCESS
	addwf	SYSSTRINGLENGTH,F,ACCESS
SYSSTRINGREADCHECK
	movf	SYSCALCTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	return
SYSSTRINGREAD
	tblrd*+
	movff	TABLAT,PREINC1
	decfsz	SYSCALCTEMPA, F,ACCESS
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable1
	db	13,32,71,67,66,65,83,73,67,32,68,101,109,111


StringTable2
	db	8,49,56,70,49,54,81,50,48


StringTable3
	db	43,87,114,111,110,103,32,77,105,99,114,111,99,111,110,116,114,111,108,108,101,114
	db	32,112,114,111,103,114,97,109,32,105,110,116,101,110,100,101,100,32,102,111,114,32


StringTable4
	db	25,84,104,101,32,77,105,99,114,111,99,111,110,116,114,111,108,108,101,114,32,105
	db	115,32,97,32


StringTable5
	db	58,84,104,101,32,77,105,99,114,111,99,111,110,116,114,111,108,108,101,114,32,105
	db	115,32,99,111,114,114,101,99,116,32,45,32,112,114,111,103,114,97,109,32,105,110
	db	116,101,110,100,101,100,32,102,111,114,32,116,104,101,32


StringTable50
	db	0


StringTable97
	db	8,49,56,70,49,54,81,50,48


;********************************************************************************

FN_TRIM
	movff	SysSYSINSTRINGHandler,SysSYSINSTRING2Handler
	movff	SysSYSINSTRINGHandler_H,SysSYSINSTRING2Handler_H
	rcall	FN_LTRIM
	movlw	low LTRIM
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high LTRIM
	movwf	SysSYSINSTRING3Handler_H,ACCESS
	rcall	FN_RTRIM
	lfsr	1,TRIM
	lfsr	0,RTRIM
	bra	SYSCOPYSTRING

;********************************************************************************

FN_UCASE
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
	movffl	SYSCHARCOUNT,SYSUCASE_0
	movf	SYSCHARCOUNT,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	return
	movlw	1
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP,BANKED
SysForLoop2
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SYSSTRDATA
	movlw	97
	subwf	SYSSTRDATA,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ENDIF7
	movf	SYSSTRDATA,W,ACCESS
	sublw	122
	btfss	STATUS, C,ACCESS
	bra	ENDIF9
	movlw	32
	subwf	SYSSTRDATA,F,ACCESS
ENDIF9
ENDIF7
	lfsr	0,UCASE
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SYSSTRDATA,INDF0
	movf	SYSSTRINGTEMP,W,BANKED
	subwf	SYSCHARCOUNT,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	banksel	0
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF8
	banksel	SYSSTRINGTEMP
	incf	SYSSTRINGTEMP,F,BANKED
	bra	SysForLoop2
ENDIF8
SysForLoopEnd2
	return

;********************************************************************************


 END
