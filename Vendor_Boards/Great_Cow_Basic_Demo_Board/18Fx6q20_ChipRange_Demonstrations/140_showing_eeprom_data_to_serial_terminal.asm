;Program compiled by GCBASIC (2024.2.13 (Windows 64 bit) : Build 1335) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2024-02-13 CRC247
;Need help? 
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   w_cholmondeley at users dot sourceforge dot net
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Source file    : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\18Fx6q20_ChipRange_Demonstrations\140_showing_eeprom_data_to_serial_terminal.gcb
;   Setting file   : C:\GCstudio\gcbasic\use.ini
;   Preserve mode  : 0
;   Assembler      : GCASM
;   Programmer     : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file    : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\18Fx6q20_ChipRange_Demonstrations\140_showing_eeprom_data_to_serial_terminal.asm
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
COMPORT                          EQU    1293          ; 0x50D
DELAYTEMP                        EQU    1280          ; 0x500
DELAYTEMP2                       EQU    1281          ; 0x501
DISPLAYNEWLINE                   EQU    1294          ; 0x50E
EEDATA                           EQU    1295          ; 0x50F
EEDATAVALUE                      EQU    1296          ; 0x510
EEPROMADDRESS                    EQU    1297          ; 0x511
EEPROMADDRESS_H                  EQU    1298          ; 0x512
HSERPRINTCRLFCOUNT               EQU    1299          ; 0x513
INDATA                           EQU    1300          ; 0x514
OUTDATA                          EQU    1301          ; 0x515
PRINTLEN                         EQU    1302          ; 0x516
RIGHT                            EQU    5335          ; 0x14D7
SERDATA                          EQU    1303          ; 0x517
STRINGPOINTER                    EQU    1304          ; 0x518
SYSARRAYTEMP1                    EQU    1305          ; 0x519
SYSARRAYTEMP2                    EQU    1306          ; 0x51A
SYSBITVAR0                       EQU    1307          ; 0x51B
SYSBYTETEMPA                     EQU    1285          ; 0x505
SYSBYTETEMPB                     EQU    1289          ; 0x509
SYSBYTETEMPX                     EQU    1280          ; 0x500
SYSCALCTEMPA                     EQU    1285          ; 0x505
SYSCHARCOUNT                     EQU    1308          ; 0x51C
SYSCHARSTART                     EQU    1309          ; 0x51D
SYSDIVLOOP                       EQU    1284          ; 0x504
SYSDIVMULTA                      EQU    1287          ; 0x507
SYSDIVMULTA_H                    EQU    1288          ; 0x508
SYSDIVMULTB                      EQU    1291          ; 0x50B
SYSDIVMULTB_H                    EQU    1292          ; 0x50C
SYSDIVMULTX                      EQU    1282          ; 0x502
SYSDIVMULTX_H                    EQU    1283          ; 0x503
SYSEEADDRESS                     EQU    1310          ; 0x51E
SYSEEADDRESS_H                   EQU    1311          ; 0x51F
SYSPRINTDATAHANDLER              EQU    1312          ; 0x520
SYSPRINTDATAHANDLER_H            EQU    1313          ; 0x521
SYSPRINTTEMP                     EQU    1314          ; 0x522
SYSREPEATTEMP1                   EQU    1315          ; 0x523
SYSSTRINGA                       EQU    1287          ; 0x507
SYSSTRINGA_H                     EQU    1288          ; 0x508
SYSSTRINGLENGTH                  EQU    1286          ; 0x506
SYSSTRINGPARAM1                  EQU    5301          ; 0x14B5
SYSSTRINGTEMP                    EQU    1316          ; 0x524
SYSSYSINSTRINGHANDLER            EQU    1317          ; 0x525
SYSSYSINSTRINGHANDLER_H          EQU    1318          ; 0x526
SYSTEMP1                         EQU    1319          ; 0x527
SYSTEMP1_H                       EQU    1320          ; 0x528
SYSTEMP2                         EQU    1321          ; 0x529
SYSTEMP3                         EQU    1322          ; 0x52A
SYSVALTEMP                       EQU    1323          ; 0x52B
SYSWAITTEMPMS                    EQU    1282          ; 0x502
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503
SYSWAITTEMPS                     EQU    1284          ; 0x504
SYSWORDTEMPA                     EQU    1285          ; 0x505
SYSWORDTEMPA_H                   EQU    1286          ; 0x506
SYSWORDTEMPB                     EQU    1289          ; 0x509
SYSWORDTEMPB_H                   EQU    1290          ; 0x50A
SYSWORDTEMPX                     EQU    1280          ; 0x500
SYSWORDTEMPX_H                   EQU    1281          ; 0x501
_HEXPICAS                        EQU    5297          ; 0x14B1

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
SYSRIGHT_0 EQU 5335
SYS_HEXPICAS_0 EQU 5297
SYS_HEXPICAS_1 EQU 5298
SYS_HEXPICAS_2 EQU 5299

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
	movlw	3
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
SysDoLoop_S1
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
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
	rcall	HSERPRINT314
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT314
	setf	EEPROMADDRESS,ACCESS
	setf	EEPROMADDRESS_H,ACCESS
SysForLoop1
	incf	EEPROMADDRESS,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EEPROMADDRESS_H,F,ACCESS
	movff	EEPROMADDRESS,SYSVALTEMP
	rcall	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT314
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
	rcall	HSERPRINT314
	movff	EEPROMADDRESS,SysWORDTempA
	movff	EEPROMADDRESS_H,SysWORDTempA_H
	movlw	15
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
	clrf	EEPROMADDRESS,ACCESS
	clrf	EEPROMADDRESS_H,ACCESS
SysForLoop2
	movff	EEPROMADDRESS,SysWORDTempA
	movff	EEPROMADDRESS_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempX,DISPLAYNEWLINE
	movf	DISPLAYNEWLINE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF2
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	movff	EEPROMADDRESS_H,SYSVALTEMP
	rcall	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high _HEXPICAS
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	1
	movwf	SYSCHARCOUNT,ACCESS
	rcall	FN_RIGHT
	movlw	low RIGHT
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high RIGHT
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT314
	movff	EEPROMADDRESS,SYSVALTEMP
	rcall	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT314
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
	rcall	HSERPRINT314
ENDIF2
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
	rcall	HSERPRINT314
	movlw	85
	movwf	OUTDATA,ACCESS
	movff	EEPROMADDRESS,SYSEEADDRESS
	movff	EEPROMADDRESS_H,SYSEEADDRESS_H
	movff	OUTDATA,EEDATA
	rcall	NVMADR_EPWRITE
	clrf	INDATA,ACCESS
	movff	EEPROMADDRESS,SYSEEADDRESS
	movff	EEPROMADDRESS_H,SYSEEADDRESS_H
	rcall	NVMADR_EPREAD
	movff	EEDATAVALUE,INDATA
	movf	INDATA,W,ACCESS
	subwf	OUTDATA,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE3_1
	movff	INDATA,SYSVALTEMP
	rcall	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT314
	bra	ENDIF3
ELSE3_1
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT314
ENDIF3
	movf	EEPROMADDRESS,W,ACCESS
	sublw	255
	movwf	SysTemp1,ACCESS
	clrf	SysTemp2,ACCESS
	movf	EEPROMADDRESS_H,W,ACCESS
	subwfb	SysTemp2,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF4
	incf	EEPROMADDRESS,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EEPROMADDRESS_H,F,ACCESS
	bra	SysForLoop2
ENDIF4
SysForLoopEnd2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable6
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT314
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
SysWaitLoop1
	btfsc	PORTA,3,ACCESS
	bra	SysWaitLoop1
	bra	SysDoLoop_S1
SysDoLoop_E1
	bra	BASPROGRAMEND
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	108
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	11
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
	bra	ENDIF22
	movlw	1
	movwf	SYSPRINTTEMP,ACCESS
SysForLoop5
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
	movwf	SysTemp2,ACCESS
	movff	SysTemp2,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF23
	incf	SYSPRINTTEMP,F,ACCESS
	bra	SysForLoop5
ENDIF23
SysForLoopEnd5
ENDIF22
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
	movlw	5
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
	movlw	1
	banksel	U1BRGH
	movwf	U1BRGH,BANKED
	movlw	159
	movwf	U1BRGL,BANKED
	bsf	U1CON0,U1BRGS,BANKED
	bsf	U1CON0,U1TXEN,BANKED
	bsf	U1CON0,U1RXEN,BANKED
	bsf	U1CON1,ON_U1CON1,BANKED
	banksel	I3C1EC
	bsf	I3C1EC,CREN,BANKED
	return

;********************************************************************************

NVMADR_EPREAD
	movlw	56
	movwf	NVMADRU,BANKED
	movff	SYSEEADDRESS_H,NVMADRH
	movff	SYSEEADDRESS,NVMADRL
	clrf	NVMCON1,BANKED
	bsf	NVMCON0,GO_NVMCON0,BANKED
	movff	NVMDATL,EEDATAVALUE
	return

;********************************************************************************

NVMADR_EPWRITE
	bcf	SYSBITVAR0,1,ACCESS
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSBITVAR0,1,ACCESS
	bcf	SYSBITVAR0,4,ACCESS
	btfsc	NVMCON1,0,BANKED
	bsf	SYSBITVAR0,4,ACCESS
	bcf	SYSBITVAR0,5,ACCESS
	btfsc	NVMCON1,1,BANKED
	bsf	SYSBITVAR0,5,ACCESS
	bcf	SYSBITVAR0,6,ACCESS
	btfsc	NVMCON1,2,BANKED
	bsf	SYSBITVAR0,6,ACCESS
	movlw	56
	movwf	NVMADRU,BANKED
	movlw	248
	andwf	NVMCON1,W,BANKED
	movwf	SysTemp2,ACCESS
	movlw	3
	iorwf	SysTemp2,W,ACCESS
	movwf	NVMCON1,BANKED
	movff	SYSEEADDRESS_H,NVMADRH
	movff	SYSEEADDRESS,NVMADRL
	movff	EEDATA,NVMDATL
	bcf	INTCON0,GIE,ACCESS
	movlw	85
	movwf	NVMLOCK,BANKED
	movlw	170
	movwf	NVMLOCK,BANKED
	bsf	NVMCON0,GO_NVMCON0,BANKED
SysWaitLoop2
	btfsc	NVMCON0,GO_NVMCON0,BANKED
	bra	SysWaitLoop2
	movlw	248
	andwf	NVMCON1,F,BANKED
	nop
	nop
	nop
	nop
	nop
	bcf	NVMCON1,0,BANKED
	btfsc	SYSBITVAR0,4,ACCESS
	bsf	NVMCON1,0,BANKED
	bcf	NVMCON1,1,BANKED
	btfsc	SYSBITVAR0,5,ACCESS
	bsf	NVMCON1,1,BANKED
	bcf	NVMCON1,2,BANKED
	btfsc	SYSBITVAR0,6,ACCESS
	bsf	NVMCON1,2,BANKED
	btfss	SYSBITVAR0,1,ACCESS
	bcf	INTCON0,GIE,ACCESS
	btfsc	SYSBITVAR0,1,ACCESS
	bsf	INTCON0,GIE,ACCESS
	return

;********************************************************************************

FN_RIGHT
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF19
	banksel	SYSRIGHT_0
	clrf	SYSRIGHT_0,BANKED
	banksel	0
	return
ENDIF19
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF20
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
ENDIF20
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	INDF0,W,ACCESS
	movwf	SYSCHARSTART,ACCESS
	movlw	1
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP,BANKED
SysForLoop4
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SYSCHARSTART,W,ACCESS
	movwf	SysTemp2,ACCESS
	addwf	SysSYSINSTRINGHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,RIGHT
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp1,POSTINC0
	movf	SYSSTRINGTEMP,W,BANKED
	subwf	SYSCHARCOUNT,W,ACCESS
	movwf	SysTemp2,ACCESS
	movff	SysTemp2,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	banksel	0
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF21
	banksel	SYSSTRINGTEMP
	incf	SYSSTRINGTEMP,F,BANKED
	bra	SysForLoop4
ENDIF21
SysForLoopEnd4
	movffl	SYSCHARCOUNT,SYSRIGHT_0
	return

;********************************************************************************

SYSCOMPEQUAL
	setf	SYSBYTETEMPX,ACCESS
	movf	SYSBYTETEMPB, W,ACCESS
	cpfseq	SYSBYTETEMPA,ACCESS
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOMPEQUAL16
	clrf	SYSBYTETEMPX,ACCESS
	movf	SYSWORDTEMPB, W,ACCESS
	cpfseq	SYSWORDTEMPA,ACCESS
	return
	movf	SYSWORDTEMPB_H, W,ACCESS
	cpfseq	SYSWORDTEMPA_H,ACCESS
	return
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOMPLESSTHAN16
	clrf	SYSBYTETEMPX,ACCESS
	movf	SYSWORDTEMPA_H,W,ACCESS
	subwf	SYSWORDTEMPB_H,W,ACCESS
	btfss	STATUS,C,ACCESS
	return
	movf	SYSWORDTEMPB_H,W,ACCESS
	subwf	SYSWORDTEMPA_H,W,ACCESS
	bnc	SCLT16TRUE
	movf	SYSWORDTEMPB,W,ACCESS
	subwf	SYSWORDTEMPA,W,ACCESS
	btfsc	STATUS,C,ACCESS
	return
SCLT16TRUE
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

SYSDIVSUB16
	movff	SYSWORDTEMPA,SYSDIVMULTA
	movff	SYSWORDTEMPA_H,SYSDIVMULTA_H
	movff	SYSWORDTEMPB,SYSDIVMULTB
	movff	SYSWORDTEMPB_H,SYSDIVMULTB_H
	clrf	SYSDIVMULTX,ACCESS
	clrf	SYSDIVMULTX_H,ACCESS
	movff	SYSDIVMULTB,SysWORDTempA
	movff	SYSDIVMULTB_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF17
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
	return
ENDIF17
	movlw	16
	movwf	SYSDIVLOOP,ACCESS
SYSDIV16START
	bcf	STATUS,C,ACCESS
	rlcf	SYSDIVMULTA,F,ACCESS
	rlcf	SYSDIVMULTA_H,F,ACCESS
	rlcf	SYSDIVMULTX,F,ACCESS
	rlcf	SYSDIVMULTX_H,F,ACCESS
	movf	SYSDIVMULTB,W,ACCESS
	subwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	subwfb	SYSDIVMULTX_H,F,ACCESS
	bsf	SYSDIVMULTA,0,ACCESS
	btfsc	STATUS,C,ACCESS
	bra	ENDIF18
	bcf	SYSDIVMULTA,0,ACCESS
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
ENDIF18
	decfsz	SYSDIVLOOP, F,ACCESS
	bra	SYSDIV16START
	movff	SYSDIVMULTA,SYSWORDTEMPA
	movff	SYSDIVMULTA_H,SYSWORDTEMPA_H
	movff	SYSDIVMULTX,SYSWORDTEMPX
	movff	SYSDIVMULTX_H,SYSWORDTEMPX_H
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
	db	29,69,69,80,82,79,77,32,84,101,115,116,32,97,110,100,32,83,104,111,119,32,82,101
	db	115,117,108,116,115,32


StringTable2
	db	6,32,32,32,32,32,32


StringTable3
	db	1,32


StringTable4
	db	2,58,32


StringTable5
	db	2,45,45


StringTable6
	db	33,69,110,100,32,111,102,32,69,69,80,114,111,109,32,80,114,111,103,114,97,109
	db	32,97,110,100,32,68,105,115,112,108,97,121


;********************************************************************************

FN__HEXPICAS
	movlw	2
	banksel	SYS_HEXPICAS_0
	movwf	SYS_HEXPICAS_0,BANKED
	movlw	15
	andwf	SYSVALTEMP,W,ACCESS
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP,BANKED
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF5
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF5
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYS_HEXPICAS_2
	movwf	SYS_HEXPICAS_2,BANKED
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop3
	incf	SYSSTRINGTEMP,F,BANKED
	rrcf	SYSVALTEMP,F,ACCESS
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
	movlw	15
	andwf	SYSVALTEMP,W,ACCESS
	movwf	SYSSTRINGTEMP,BANKED
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF7
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF7
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYS_HEXPICAS_1
	movwf	SYS_HEXPICAS_1,BANKED
	banksel	0
	return

;********************************************************************************


 END
