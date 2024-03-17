;Program compiled by GCBASIC (2024.3.14 (Windows 64 bit) : Build 1368) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2024-03-14 CRC248
;Need help? 
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   w_cholmondeley at users dot sourceforge dot net
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\AdvancedVariableSolutions\SingleVariableType_Solutions\014-SingleToString.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\AdvancedVariableSolutions\SingleVariableType_Solutions\014-SingleToString.asm
;   Float Capability : 3
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F16Q20, r=DEC
#include <P18F16Q20.inc>
 CONFIG  CPD = OFF
 CONFIG  CP = OFF
 CONFIG  WRTSAF = OFF
 CONFIG  WRTD = OFF
 CONFIG  WRTB = OFF
 CONFIG  VDDIO3MD = STANDARD_RANGE
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
HSERPRINTCRLFCOUNT               EQU    1294          ; 0x50E
LEFT                             EQU    5335          ; 0x14D7
PI                               EQU    1295          ; 0x50F
PI_E                             EQU    1298          ; 0x512
PI_H                             EQU    1296          ; 0x510
PI_U                             EQU    1297          ; 0x511
PRINTLEN                         EQU    1299          ; 0x513
RIGHT                            EQU    5294          ; 0x14AE
SERDATA                          EQU    1300          ; 0x514
SINGLENUM                        EQU    1301          ; 0x515
SINGLENUM_E                      EQU    1304          ; 0x518
SINGLENUM_H                      EQU    1302          ; 0x516
SINGLENUM_U                      EQU    1303          ; 0x517
SINGLETOSTRING                   EQU    5273          ; 0x1499
STRINGPOINTER                    EQU    1305          ; 0x519
SYSARRAYTEMP1                    EQU    1306          ; 0x51A
SYSARRAYTEMP2                    EQU    1307          ; 0x51B
SYSBYTETEMPA                     EQU    1285          ; 0x505
SYSBYTETEMPB                     EQU    1289          ; 0x509
SYSBYTETEMPX                     EQU    1280          ; 0x500
SYSBYTE_STS_BIN                  EQU    1308          ; 0x51C
SYSBYTE_STS_ERR                  EQU    1309          ; 0x51D
SYSBYTE_STS_EXP                  EQU    1310          ; 0x51E
SYSBYTE_STS_PTR                  EQU    1311          ; 0x51F
SYSBYTE_STS_SGN                  EQU    1312          ; 0x520
SYSCALCTEMPA                     EQU    1285          ; 0x505
SYSCHARCOUNT                     EQU    1313          ; 0x521
SYSCHARSTART                     EQU    1314          ; 0x522
SYSDIVLOOP                       EQU    1284          ; 0x504
SYSLONGTEMPA                     EQU    1285          ; 0x505
SYSLONGTEMPA_E                   EQU    1288          ; 0x508
SYSLONGTEMPA_H                   EQU    1286          ; 0x506
SYSLONGTEMPA_U                   EQU    1287          ; 0x507
SYSLONGTEMPB                     EQU    1289          ; 0x509
SYSLONGTEMPB_E                   EQU    1292          ; 0x50C
SYSLONGTEMPB_H                   EQU    1290          ; 0x50A
SYSLONGTEMPB_U                   EQU    1291          ; 0x50B
SYSLONG_STS_MANTISSA             EQU    1315          ; 0x523
SYSLONG_STS_MANTISSA_E           EQU    1318          ; 0x526
SYSLONG_STS_MANTISSA_H           EQU    1316          ; 0x524
SYSLONG_STS_MANTISSA_U           EQU    1317          ; 0x525
SYSPRINTDATAHANDLER              EQU    1319          ; 0x527
SYSPRINTDATAHANDLER_H            EQU    1320          ; 0x528
SYSPRINTTEMP                     EQU    1321          ; 0x529
SYSREPEATTEMP1                   EQU    1322          ; 0x52A
SYSREPEATTEMP4                   EQU    1323          ; 0x52B
SYSSTRINGA                       EQU    1287          ; 0x507
SYSSTRINGA_H                     EQU    1288          ; 0x508
SYSSTRINGLENGTH                  EQU    1286          ; 0x506
SYSSTRINGPARAM1                  EQU    5253          ; 0x1485
SYSSTRINGTEMP                    EQU    1324          ; 0x52C
SYSSYSINSTRINGHANDLER            EQU    1325          ; 0x52D
SYSSYSINSTRINGHANDLER_H          EQU    1326          ; 0x52E
SYSTEMP1                         EQU    1327          ; 0x52F
SYSTEMP1_H                       EQU    1328          ; 0x530
SYSTEMP2                         EQU    1329          ; 0x531
SYSTEMP2_H                       EQU    1330          ; 0x532
SYSTOTALTEMP                     EQU    1331          ; 0x533
SYSTOTALTEMP_H                   EQU    1332          ; 0x534
SYSULONGINTDIVMULTA              EQU    1333          ; 0x535
SYSULONGINTDIVMULTA_A            EQU    1337          ; 0x539
SYSULONGINTDIVMULTA_B            EQU    1338          ; 0x53A
SYSULONGINTDIVMULTA_C            EQU    1339          ; 0x53B
SYSULONGINTDIVMULTA_D            EQU    1340          ; 0x53C
SYSULONGINTDIVMULTA_E            EQU    1336          ; 0x538
SYSULONGINTDIVMULTA_H            EQU    1334          ; 0x536
SYSULONGINTDIVMULTA_U            EQU    1335          ; 0x537
SYSULONGINTDIVMULTB              EQU    1341          ; 0x53D
SYSULONGINTDIVMULTB_A            EQU    1345          ; 0x541
SYSULONGINTDIVMULTB_B            EQU    1346          ; 0x542
SYSULONGINTDIVMULTB_C            EQU    1347          ; 0x543
SYSULONGINTDIVMULTB_D            EQU    1348          ; 0x544
SYSULONGINTDIVMULTB_E            EQU    1344          ; 0x540
SYSULONGINTDIVMULTB_H            EQU    1342          ; 0x53E
SYSULONGINTDIVMULTB_U            EQU    1343          ; 0x53F
SYSULONGINTDIVMULTX              EQU    1349          ; 0x545
SYSULONGINTDIVMULTX_A            EQU    1353          ; 0x549
SYSULONGINTDIVMULTX_B            EQU    1354          ; 0x54A
SYSULONGINTDIVMULTX_C            EQU    1355          ; 0x54B
SYSULONGINTDIVMULTX_D            EQU    1356          ; 0x54C
SYSULONGINTDIVMULTX_E            EQU    1352          ; 0x548
SYSULONGINTDIVMULTX_H            EQU    1350          ; 0x546
SYSULONGINTDIVMULTX_U            EQU    1351          ; 0x547
SYSULONGINTTEMPA                 EQU    1357          ; 0x54D
SYSULONGINTTEMPA_A               EQU    1361          ; 0x551
SYSULONGINTTEMPA_B               EQU    1362          ; 0x552
SYSULONGINTTEMPA_C               EQU    1363          ; 0x553
SYSULONGINTTEMPA_D               EQU    1364          ; 0x554
SYSULONGINTTEMPA_E               EQU    1360          ; 0x550
SYSULONGINTTEMPA_H               EQU    1358          ; 0x54E
SYSULONGINTTEMPA_U               EQU    1359          ; 0x54F
SYSULONGINTTEMPB                 EQU    1365          ; 0x555
SYSULONGINTTEMPB_A               EQU    1369          ; 0x559
SYSULONGINTTEMPB_B               EQU    1370          ; 0x55A
SYSULONGINTTEMPB_C               EQU    1371          ; 0x55B
SYSULONGINTTEMPB_D               EQU    1372          ; 0x55C
SYSULONGINTTEMPB_E               EQU    1368          ; 0x558
SYSULONGINTTEMPB_H               EQU    1366          ; 0x556
SYSULONGINTTEMPB_U               EQU    1367          ; 0x557
SYSULONGINTTEMPX                 EQU    1373          ; 0x55D
SYSULONGINTTEMPX_A               EQU    1377          ; 0x561
SYSULONGINTTEMPX_B               EQU    1378          ; 0x562
SYSULONGINTTEMPX_C               EQU    1379          ; 0x563
SYSULONGINTTEMPX_D               EQU    1380          ; 0x564
SYSULONGINTTEMPX_E               EQU    1376          ; 0x560
SYSULONGINTTEMPX_H               EQU    1374          ; 0x55E
SYSULONGINTTEMPX_U               EQU    1375          ; 0x55F
SYSULONGINT_STS_NUM              EQU    1381          ; 0x565
SYSULONGINT_STS_NUM_A            EQU    1385          ; 0x569
SYSULONGINT_STS_NUM_B            EQU    1386          ; 0x56A
SYSULONGINT_STS_NUM_C            EQU    1387          ; 0x56B
SYSULONGINT_STS_NUM_D            EQU    1388          ; 0x56C
SYSULONGINT_STS_NUM_E            EQU    1384          ; 0x568
SYSULONGINT_STS_NUM_H            EQU    1382          ; 0x566
SYSULONGINT_STS_NUM_U            EQU    1383          ; 0x567
SYSWAITTEMPMS                    EQU    1282          ; 0x502
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503
SYSWORDTEMPA                     EQU    1285          ; 0x505
SYSWORDTEMPA_H                   EQU    1286          ; 0x506
SYSWORDTEMPB                     EQU    1289          ; 0x509
SYSWORDTEMPB_H                   EQU    1290          ; 0x50A
SYSWORDTEMPX                     EQU    1280          ; 0x500
SYSWORDTEMPX_H                   EQU    1281          ; 0x501

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
SYSLEFT_0 EQU 5335
SYSRIGHT_0 EQU 5294
SYSSINGLETOSTRING_0 EQU 5273
SYSSINGLETOSTRING_1 EQU 5274

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
;
;
;See https://www.h-schmidt.net/FloatConverter/IEEE754.html
;
;
;Chip Settings
;PIC PPS Tool version: 0.0.6.5
;Add this code segment to your GCBASIC source program
;
;Hardware
;-------------------PORTA----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:---------------------SW---------ADC--
;-----------------------------------------
;
;
;-------------------PORTB----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:----TX-------------------------------
;----------------------------------------
;
;------------------PORTC-----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:LED-LED-LED-LED------------------
;----------------------------------------
;
;Define constants to make things easier. We can reuse these at any time.
;Set the ports as an output
;Dir LEDD7 Out
	bcf	TRISC,7,ACCESS
;Dir LEDD6 Out
	bcf	TRISC,6,ACCESS
;Dir LEDD5 Out
	bcf	TRISC,5,ACCESS
;Dir LEDD4 Out
	bcf	TRISC,4,ACCESS
;This is the PORTA.0 port
;Dir POTENTIOMETER In
	bsf	TRISA,0,ACCESS
;Dir     SWITCHIN      In
	bsf	TRISA,3,ACCESS
;*****************************************************************************************************
;! Wait 200 ms to permit any remote serial terminal to settle.
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;! Clear the terminal
;HserSend    0x01
	movlw	1
	movwf	SERDATA,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERSEND328
;---------- Variable definition and main program ---------------------------------
;!  Convert constant and variable to single then to a string.
;---------- misc variable definition ---------------------------------
;dim Pi as Single
;---------------------------------------------------------------------
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint "1 0.0 '"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*7
	rcall	HSERPRINT338
;HSerPrint SingleToString([Single]0.0)
	clrf	SINGLENUM,ACCESS
	clrf	SINGLENUM_H,ACCESS
	clrf	SINGLENUM_U,ACCESS
	clrf	SINGLENUM_E,ACCESS
	rcall	FN_SINGLETOSTRING
	movlw	low SINGLETOSTRING
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SINGLETOSTRING
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT338
;HSerPrint "'"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*1
	rcall	HSERPRINT338
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint "2 0.05 '"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*8
	rcall	HSERPRINT338
;HSerPrint SingleToString([Single]0.05)
	movlw	205
	movwf	SINGLENUM,ACCESS
	movlw	204
	movwf	SINGLENUM_H,ACCESS
	movlw	76
	movwf	SINGLENUM_U,ACCESS
	movlw	61
	movwf	SINGLENUM_E,ACCESS
	rcall	FN_SINGLETOSTRING
	movlw	low SINGLETOSTRING
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SINGLETOSTRING
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT338
;HSerPrint "'"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*1
	rcall	HSERPRINT338
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint "3 0.5 '"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*7
	rcall	HSERPRINT338
;HSerPrint SingleToString([Single]0.5)
	clrf	SINGLENUM,ACCESS
	clrf	SINGLENUM_H,ACCESS
	clrf	SINGLENUM_U,ACCESS
	movlw	63
	movwf	SINGLENUM_E,ACCESS
	rcall	FN_SINGLETOSTRING
	movlw	low SINGLETOSTRING
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SINGLETOSTRING
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT338
;HSerPrint "'"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*1
	rcall	HSERPRINT338
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint "4 1.5 '"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*7
	rcall	HSERPRINT338
;HSerPrint SingleToString([Single]1.5)
	clrf	SINGLENUM,ACCESS
	clrf	SINGLENUM_H,ACCESS
	movlw	192
	movwf	SINGLENUM_U,ACCESS
	movlw	63
	movwf	SINGLENUM_E,ACCESS
	rcall	FN_SINGLETOSTRING
	movlw	low SINGLETOSTRING
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SINGLETOSTRING
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT338
;HSerPrint "'"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*1
	rcall	HSERPRINT338
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;Pi = 3.14159265
	movlw	219
	movwf	PI,ACCESS
	movlw	15
	movwf	PI_H,ACCESS
	movlw	73
	movwf	PI_U,ACCESS
	movlw	64
	movwf	PI_E,ACCESS
;HSerPrint "5 3.14159265 '"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable6
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*14
	rcall	HSERPRINT338
;HSerPrint SingleToString(Pi)
	movff	PI,SINGLENUM
	movff	PI_H,SINGLENUM_H
	movff	PI_U,SINGLENUM_U
	movff	PI_E,SINGLENUM_E
	rcall	FN_SINGLETOSTRING
	movlw	low SINGLETOSTRING
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SINGLETOSTRING
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT338
;HSerPrint "'"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*1
	rcall	HSERPRINT338
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint "6 999999.99999999 '"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable7
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*19
	rcall	HSERPRINT338
;HSerPrint SingleToString([Single]999999.99999999)
	clrf	SINGLENUM,ACCESS
	movlw	36
	movwf	SINGLENUM_H,ACCESS
	movlw	116
	movwf	SINGLENUM_U,ACCESS
	movlw	73
	movwf	SINGLENUM_E,ACCESS
	rcall	FN_SINGLETOSTRING
	movlw	low SINGLETOSTRING
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SINGLETOSTRING
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT338
;HSerPrint "'"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*1
	rcall	HSERPRINT338
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint "Done"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable8
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*4
	rcall	HSERPRINT338
;Do
SysDoLoop_S1
;loop forever
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

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

;Overloaded signature: STRING:byte:, Source: usart.h (2458)
HSERPRINT338
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF11
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
	rcall	HSERSEND328
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
	bra	ENDIF12
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	incf	SYSPRINTTEMP,F,ACCESS
	bra	SysForLoop1
;END IF
ENDIF12
SysForLoopEnd1
;End If
ENDIF11
;CR
;All Usarts
;--------------------------
;Specific USARTs
;------------------
	return

;********************************************************************************

;Source: usart.h (2666)
HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp4
	movf	SYSREPEATTEMP4,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd4
SysRepeatLoop4
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,ACCESS
	rcall	HSERSEND328
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,ACCESS
	rcall	HSERSEND328
;end Repeat
	decfsz	SysRepeatTemp4,F,ACCESS
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (1570)
HSERSEND328
HSERSENDUSART1HANDLER
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop1
	btfss	PIR6,U1TXIF,ACCESS
	bra	SysWaitLoop1
;TXREG = SerData
	movff	SERDATA,U1TXB
	return

;********************************************************************************

;Source: 014-SingleToString.gcb (20)
INITPPS
;Module: UART pin directions
;Dir PORTB.7 Out    ' Make TX1 pin an output
	bcf	TRISB,7,ACCESS
;Module: UART1
;RB7PPS =    0x0013    // TX1 > RB7
	movlw	19
	banksel	RB7PPS
	movwf	RB7PPS,BANKED
	banksel	0
	return

;********************************************************************************

;Source: system.h (184)
INITSYS
;Clear BSR on ChipFamily16 MCUs
;MOVLB 0
	movlb	0
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
;asm showdebug The MCU is a chip family 16
;Section supports many MCUs, 18FxxK40, 18FxxK42 etc that have NDIV3 bit
;asm showdebug OSCCON type is 101
;OSCCON1 = 0x60          // Setting OSCCON1 implies clearing Clear NDIV3:0
	movlw	96
	movwf	OSCCON1,BANKED
;OSCFRQ = 0b00001000  '64mhz
	movlw	8
	movwf	OSCFRQ,BANKED
;asm showdebug _Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
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
;Turn off all ports
;PORTA = 0
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
	banksel	0
	return

;********************************************************************************

;Source: usart.h (1014)
INITUSART
;Set the default value for USART handler - required when more than one USART
;comport = 1
	movlw	1
	movwf	COMPORT,ACCESS
;PIC USART 1 Init
;U1BRGH=SPBRGH_TEMP
	movlw	6
	banksel	U1BRGH
	movwf	U1BRGH,BANKED
;U1BRGL=SPBRGL_TEMP
	movlw	129
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

;Source: string.h (718)
FN_LEFT
;Empty input?
;If SysInString(0) = 0 Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF17
;Left(0) = 0
	banksel	SYSLEFT_0
	clrf	SYSLEFT_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF17
;Input length too high?
;If SysInString(0) < SysCharCount Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF18
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;End If
ENDIF18
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
	movlw	1
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP,BANKED
SysForLoop2
;Left(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,LEFT
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp1,POSTINC0
;Next
;Positive value Step Handler in For-next statement :#4p 
	movf	SYSSTRINGTEMP,W,BANKED
	subwf	SYSCHARCOUNT,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	banksel	0
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF19
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	banksel	SYSSTRINGTEMP
	incf	SYSSTRINGTEMP,F,BANKED
	bra	SysForLoop2
;END IF
ENDIF19
SysForLoopEnd2
;Left(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSLEFT_0
	return

;********************************************************************************

;Source: string.h (737)
FN_RIGHT
;Empty input?
;If SysInString(0) = 0 Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF20
;Right(0) = 0
	banksel	SYSRIGHT_0
	clrf	SYSRIGHT_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF20
;Input length too high?
;If SysInString(0) < SysCharCount Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF21
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;End If
ENDIF21
;Copy rightmost characters
;SysCharStart = SysInString(0) - SysCharCount
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	INDF0,W,ACCESS
	movwf	SYSCHARSTART,ACCESS
;For SysStringTemp = 1 To SysCharCount
	movlw	1
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP,BANKED
SysForLoop3
;Right(SysStringTemp) = SysInString(SysCharStart + SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SYSCHARSTART,W,ACCESS
	movwf	SysTemp1,ACCESS
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
;Next
;Positive value Step Handler in For-next statement :#4p 
	movf	SYSSTRINGTEMP,W,BANKED
	subwf	SYSCHARCOUNT,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	banksel	0
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF22
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	banksel	SYSSTRINGTEMP
	incf	SYSSTRINGTEMP,F,BANKED
	bra	SysForLoop3
;END IF
ENDIF22
SysForLoopEnd3
;Right(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSRIGHT_0
	return

;********************************************************************************

;Source: string.h (1141)
FN_SINGLETOSTRING
;Source from Clint Koehn 14/03/2024
;-----------------------------------------------------------
;SingleNum = Single variable or constant to HSerPrint
;
;SysByte_STS_Err = 0 if no error
;SysByte_STS_Err.0 = 1 good - 0 - bad
;SysByte_STS_Err.1 = 1 decimals places to many chars,  0 = ok
;SysByte_STS_Err.2 = 1 integer places to many chars-out of range,   0 = ok
;SysByte_STS_Err.3 = 1 no decimal point, info only
;SysByte_STS_Err.4 = non numeric chars found
;
;-----------------------------------------------------------
;dim SysULongIntTempA as ULongInt
;dim SysULongIntTempB as ULongInt
;dim SysULongIntTempX as ULongInt
;dim SysLongTempA as Long
;dim SysLongTempB as Long
;dim SysLongTempX as Long
;dim SysULongInt_STS_Num as ULongInt
;dim SysLong_STS_Mantissa as Long
;dim SysByte_STS_Sgn as Byte
;dim SysByte_STS_Exp as Byte
;dim SysByte_STS_Bin as Byte
;dim SysByte_STS_Ptr as Byte
;dim SysByte_STS_Err as Byte
;ExtractSingleParts
;SysLongTempB = [byte]SingleNum: SysLongTempB_H = [byte]SingleNum_H: SysLongTempB_U = [byte]SingleNum_U: SysLongTempB_E = [byte]SingleNum_E
	movff	SINGLENUM,SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H,ACCESS
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
;SysLongTempB = [byte]SingleNum: SysLongTempB_H = [byte]SingleNum_H: SysLongTempB_U = [byte]SingleNum_U: SysLongTempB_E = [byte]SingleNum_E
	movff	SINGLENUM_H,SYSLONGTEMPB_H
;SysLongTempB = [byte]SingleNum: SysLongTempB_H = [byte]SingleNum_H: SysLongTempB_U = [byte]SingleNum_U: SysLongTempB_E = [byte]SingleNum_E
	movff	SINGLENUM_U,SYSLONGTEMPB_U
;SysLongTempB = [byte]SingleNum: SysLongTempB_H = [byte]SingleNum_H: SysLongTempB_U = [byte]SingleNum_U: SysLongTempB_E = [byte]SingleNum_E
	movff	SINGLENUM_E,SYSLONGTEMPB_E
;SysByte_STS_Sgn = SysLongTempB.31
	clrf	SYSBYTE_STS_SGN,ACCESS
	btfsc	SYSLONGTEMPB_E,7,ACCESS
	incf	SYSBYTE_STS_SGN,F,ACCESS
;SysLong_STS_Mantissa = SysLongTempB & 0x7FFFFF
	movff	SYSLONGTEMPB,SYSLONG_STS_MANTISSA
	movff	SYSLONGTEMPB_H,SYSLONG_STS_MANTISSA_H
	movlw	127
	andwf	SYSLONGTEMPB_U,W,ACCESS
	movwf	SYSLONG_STS_MANTISSA_U,ACCESS
	clrf	SYSLONG_STS_MANTISSA_E,ACCESS
;Rotate SysLongTempB Left
	rlcf	SYSLONGTEMPB,F,ACCESS
	rlcf	SYSLONGTEMPB_H,F,ACCESS
	rlcf	SYSLONGTEMPB_U,F,ACCESS
	rlcf	SYSLONGTEMPB_E,F,ACCESS
;SysByte_STS_Exp = [byte]SysLongTempB_E
	movff	SYSLONGTEMPB_E,SYSBYTE_STS_EXP
;SysLong_STS_Mantissa.23 = 1      'add hidden Bit
	bsf	SYSLONG_STS_MANTISSA_U,7,ACCESS
;SysULongInt_STS_Num = 0
	banksel	SYSULONGINT_STS_NUM
	clrf	SYSULONGINT_STS_NUM,BANKED
	clrf	SYSULONGINT_STS_NUM_H,BANKED
	clrf	SYSULONGINT_STS_NUM_U,BANKED
	clrf	SYSULONGINT_STS_NUM_E,BANKED
	clrf	SYSULONGINT_STS_NUM_A,BANKED
	clrf	SYSULONGINT_STS_NUM_B,BANKED
	clrf	SYSULONGINT_STS_NUM_C,BANKED
	clrf	SYSULONGINT_STS_NUM_D,BANKED
;Repeat 8   ' align 24 bit mantissa to left 32
	movlw	8
	movwf	SysRepeatTemp1,ACCESS
SysRepeatLoop1
;Set C Off
	bcf	STATUS,C,ACCESS
;rotate SysLong_STS_Mantissa Left
	rlcf	SYSLONG_STS_MANTISSA,F,ACCESS
	rlcf	SYSLONG_STS_MANTISSA_H,F,ACCESS
	rlcf	SYSLONG_STS_MANTISSA_U,F,ACCESS
	rlcf	SYSLONG_STS_MANTISSA_E,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;If SysByte_STS_Exp >= 127 Then            'number is > 0
	movlw	127
	subwf	SYSBYTE_STS_EXP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ELSE1_1
;SysByte_STS_Bin = SysByte_STS_Exp - 126 'needed because I'm including the 1.
	movlw	126
	subwf	SYSBYTE_STS_EXP,W,ACCESS
	movwf	SYSBYTE_STS_BIN,ACCESS
;SysULongInt_STS_Num = 0
	clrf	SYSULONGINT_STS_NUM,BANKED
	clrf	SYSULONGINT_STS_NUM_H,BANKED
	clrf	SYSULONGINT_STS_NUM_U,BANKED
	clrf	SYSULONGINT_STS_NUM_E,BANKED
	clrf	SYSULONGINT_STS_NUM_A,BANKED
	clrf	SYSULONGINT_STS_NUM_B,BANKED
	clrf	SYSULONGINT_STS_NUM_C,BANKED
	clrf	SYSULONGINT_STS_NUM_D,BANKED
;Set C Off
	bcf	STATUS,C,ACCESS
;Repeat SysByte_STS_Bin              'move integer into Num3
	movff	SYSBYTE_STS_BIN,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd2
SysRepeatLoop2
;rotate SysLong_STS_Mantissa Left  'when finished will be remainder
	rlcf	SYSLONG_STS_MANTISSA,F,ACCESS
	rlcf	SYSLONG_STS_MANTISSA_H,F,ACCESS
	rlcf	SYSLONG_STS_MANTISSA_U,F,ACCESS
	rlcf	SYSLONG_STS_MANTISSA_E,F,ACCESS
;rotate SysULongInt_STS_Num Left
	rlcf	SYSULONGINT_STS_NUM,F,BANKED
	rlcf	SYSULONGINT_STS_NUM_H,F,BANKED
	rlcf	SYSULONGINT_STS_NUM_U,F,BANKED
	rlcf	SYSULONGINT_STS_NUM_E,F,BANKED
	rlcf	SYSULONGINT_STS_NUM_A,F,BANKED
	rlcf	SYSULONGINT_STS_NUM_B,F,BANKED
	rlcf	SYSULONGINT_STS_NUM_C,F,BANKED
	rlcf	SYSULONGINT_STS_NUM_D,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;else if SysByte_STS_Exp = 0 Then      'if Exp is 0 then answer is 0
	bra	ENDIF1
ELSE1_1
	movf	SYSBYTE_STS_EXP,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE1_2
;SingleToString = "0.0"
	lfsr	1,SINGLETOSTRING
	movlw	low StringTable70
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable70
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable70
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SYSREADSTRING
;SysByte_STS_Err = 0
	clrf	SYSBYTE_STS_ERR,ACCESS
;SysByte_STS_Err.0 = 1     '1 good - 0 - bad
	bsf	SYSBYTE_STS_ERR,0,ACCESS
;exit Function
	return
;else '<127 - move decimal place to the left  answer is < 0
	bra	ENDIF1
ELSE1_2
;SysByte_STS_Bin = (126 - SysByte_STS_Exp)
	movf	SYSBYTE_STS_EXP,W,ACCESS
	sublw	126
	movwf	SYSBYTE_STS_BIN,ACCESS
;if (SysByte_STS_Bin > 23) Then ' resulting number will be less than 0.00000001
	sublw	23
	btfsc	STATUS, C,ACCESS
	bra	ENDIF8
;SingleToString = "Error "
	lfsr	1,SINGLETOSTRING
	movlw	low StringTable71
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable71
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable71
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SYSREADSTRING
;SysByte_STS_Err = 0
	clrf	SYSBYTE_STS_ERR,ACCESS
;SysByte_STS_Err.0 = 0     '1 good - 0 - bad
	bcf	SYSBYTE_STS_ERR,0,ACCESS
;SysByte_STS_Err.1 = 1     '1 decimals places to many chars,  0 = ok
	bsf	SYSBYTE_STS_ERR,1,ACCESS
;exit Function
	return
;end If
ENDIF8
;SysULongInt_STS_Num = 0
	clrf	SYSULONGINT_STS_NUM,BANKED
	clrf	SYSULONGINT_STS_NUM_H,BANKED
	clrf	SYSULONGINT_STS_NUM_U,BANKED
	clrf	SYSULONGINT_STS_NUM_E,BANKED
	clrf	SYSULONGINT_STS_NUM_A,BANKED
	clrf	SYSULONGINT_STS_NUM_B,BANKED
	clrf	SYSULONGINT_STS_NUM_C,BANKED
	clrf	SYSULONGINT_STS_NUM_D,BANKED
;End If
ENDIF1
;init string to receive number
;SysByte_STS_Ptr = 20
	movlw	20
	movwf	SYSBYTE_STS_PTR,ACCESS
;SingleToString = "          0.00000000"
	lfsr	1,SINGLETOSTRING
	movlw	low StringTable72
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable72
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable72
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SYSREADSTRING
;If SysLong_STS_Mantissa > 0 Then
	movff	SYSLONG_STS_MANTISSA,SysLONGTempB
	movff	SYSLONG_STS_MANTISSA_H,SysLONGTempB_H
	movff	SYSLONG_STS_MANTISSA_U,SysLONGTempB_U
	movff	SYSLONG_STS_MANTISSA_E,SysLONGTempB_E
	clrf	SysLONGTempA,ACCESS
	clrf	SysLONGTempA_H,ACCESS
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	rcall	SYSCOMPLESSTHAN32
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF2
;m * 100,000,000 >> 32 bits results in 8 digit accuracy
;SysULongIntTempA = SysLong_STS_Mantissa
	movff	SYSLONG_STS_MANTISSA,SYSULONGINTTEMPA
	movff	SYSLONG_STS_MANTISSA_H,SYSULONGINTTEMPA_H
	movff	SYSLONG_STS_MANTISSA_U,SYSULONGINTTEMPA_U
	movff	SYSLONG_STS_MANTISSA_E,SYSULONGINTTEMPA_E
	clrf	SYSULONGINTTEMPA_A,ACCESS
	clrf	SYSULONGINTTEMPA_B,ACCESS
	clrf	SYSULONGINTTEMPA_C,ACCESS
	clrf	SYSULONGINTTEMPA_D,ACCESS
;SysULongIntTempB = 100000000
	clrf	SYSULONGINTTEMPB,ACCESS
	movlw	225
	movwf	SYSULONGINTTEMPB_H,ACCESS
	movlw	245
	movwf	SYSULONGINTTEMPB_U,ACCESS
	movlw	5
	movwf	SYSULONGINTTEMPB_E,ACCESS
	clrf	SYSULONGINTTEMPB_A,ACCESS
	clrf	SYSULONGINTTEMPB_B,ACCESS
	clrf	SYSULONGINTTEMPB_C,ACCESS
	clrf	SYSULONGINTTEMPB_D,ACCESS
;SysMultSub64
	rcall	SYSMULTSUB64
;Repeat 32
	movlw	32
	movwf	SysRepeatTemp1,ACCESS
SysRepeatLoop3
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysULongIntTempX Right
	banksel	SYSULONGINTTEMPX_D
	rrcf	SYSULONGINTTEMPX_D,F,BANKED
	rrcf	SYSULONGINTTEMPX_C,F,BANKED
	rrcf	SYSULONGINTTEMPX_B,F,BANKED
	rrcf	SYSULONGINTTEMPX_A,F,BANKED
	rrcf	SYSULONGINTTEMPX_E,F,BANKED
	rrcf	SYSULONGINTTEMPX_U,F,ACCESS
	rrcf	SYSULONGINTTEMPX_H,F,ACCESS
	rrcf	SYSULONGINTTEMPX,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;SysLong_STS_Mantissa = SysULongIntTempX 'load m with fractional for safe keeping
	movff	SYSULONGINTTEMPX,SYSLONG_STS_MANTISSA
	movff	SYSULONGINTTEMPX_H,SYSLONG_STS_MANTISSA_H
	movff	SYSULONGINTTEMPX_U,SYSLONG_STS_MANTISSA_U
	movff	SYSULONGINTTEMPX_E,SYSLONG_STS_MANTISSA_E
;SysULongIntTempA = SysULongIntTempX
	movff	SYSULONGINTTEMPX,SYSULONGINTTEMPA
	movff	SYSULONGINTTEMPX_H,SYSULONGINTTEMPA_H
	movff	SYSULONGINTTEMPX_U,SYSULONGINTTEMPA_U
	movff	SYSULONGINTTEMPX_E,SYSULONGINTTEMPA_E
	movff	SYSULONGINTTEMPX_A,SYSULONGINTTEMPA_A
	movff	SYSULONGINTTEMPX_B,SYSULONGINTTEMPA_B
	movff	SYSULONGINTTEMPX_C,SYSULONGINTTEMPA_C
	movff	SYSULONGINTTEMPX_D,SYSULONGINTTEMPA_D
;Starting with fraction
;SysULongIntTempA = SysLong_STS_Mantissa
	movff	SYSLONG_STS_MANTISSA,SYSULONGINTTEMPA
	movff	SYSLONG_STS_MANTISSA_H,SYSULONGINTTEMPA_H
	movff	SYSLONG_STS_MANTISSA_U,SYSULONGINTTEMPA_U
	movff	SYSLONG_STS_MANTISSA_E,SYSULONGINTTEMPA_E
	clrf	SYSULONGINTTEMPA_A,ACCESS
	clrf	SYSULONGINTTEMPA_B,ACCESS
	clrf	SYSULONGINTTEMPA_C,ACCESS
	clrf	SYSULONGINTTEMPA_D,ACCESS
;SysULongIntTempB = 0
	clrf	SYSULONGINTTEMPB,ACCESS
	clrf	SYSULONGINTTEMPB_H,ACCESS
	clrf	SYSULONGINTTEMPB_U,ACCESS
	clrf	SYSULONGINTTEMPB_E,ACCESS
	clrf	SYSULONGINTTEMPB_A,ACCESS
	clrf	SYSULONGINTTEMPB_B,ACCESS
	clrf	SYSULONGINTTEMPB_C,ACCESS
	clrf	SYSULONGINTTEMPB_D,ACCESS
;SysCompEqual64
	banksel	0
	rcall	SYSCOMPEQUAL64
;do while SysByteTempX = False
SysDoLoop_S2
	movf	SYSBYTETEMPX,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
;SysULongIntTempB = 10	'divide SysULongIntTempA by 10 till SysULongIntTempA = 0
	movlw	10
	movwf	SYSULONGINTTEMPB,ACCESS
	clrf	SYSULONGINTTEMPB_H,ACCESS
	clrf	SYSULONGINTTEMPB_U,ACCESS
	clrf	SYSULONGINTTEMPB_E,ACCESS
	clrf	SYSULONGINTTEMPB_A,ACCESS
	clrf	SYSULONGINTTEMPB_B,ACCESS
	clrf	SYSULONGINTTEMPB_C,ACCESS
	clrf	SYSULONGINTTEMPB_D,ACCESS
;SysDivSub64
	rcall	SYSDIVSUB64
;SysByte_STS_Bin = [byte]SysULongIntTempX 	'remainder hold 0-9
	movff	SYSULONGINTTEMPX,SYSBYTE_STS_BIN
;SingleToString(SysByte_STS_Ptr) = (SysByte_STS_Bin + 48)	'add 48 gives tha ASC value of 0 - 9
	lfsr	0,SINGLETOSTRING
	movf	SYSBYTE_STS_PTR,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSBYTE_STS_BIN,W,ACCESS
	movwf	INDF0,ACCESS
;SysByte_STS_Ptr --
	decf	SYSBYTE_STS_PTR,F,ACCESS
;SysULongIntTempB = 0
	clrf	SYSULONGINTTEMPB,ACCESS
	clrf	SYSULONGINTTEMPB_H,ACCESS
	clrf	SYSULONGINTTEMPB_U,ACCESS
	clrf	SYSULONGINTTEMPB_E,ACCESS
	clrf	SYSULONGINTTEMPB_A,ACCESS
	clrf	SYSULONGINTTEMPB_B,ACCESS
	clrf	SYSULONGINTTEMPB_C,ACCESS
	clrf	SYSULONGINTTEMPB_D,ACCESS
;SysCompEqual64
	rcall	SYSCOMPEQUAL64
;loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;End If
ENDIF2
;If SysByte_STS_Ptr < 12 Then
	movlw	12
	subwf	SYSBYTE_STS_PTR,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ELSE3_1
;SingleToString(SysByte_STS_Ptr) = "."
	lfsr	0,SINGLETOSTRING
	movf	SYSBYTE_STS_PTR,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	46
	movwf	INDF0,ACCESS
;SysByte_STS_Ptr --
	decf	SYSBYTE_STS_PTR,F,ACCESS
;else
	bra	ENDIF3
ELSE3_1
;If SysLong_STS_Mantissa = 0 then
	movff	SYSLONG_STS_MANTISSA,SysLONGTempA
	movff	SYSLONG_STS_MANTISSA_H,SysLONGTempA_H
	movff	SYSLONG_STS_MANTISSA_U,SysLONGTempA_U
	movff	SYSLONG_STS_MANTISSA_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSCOMPEQUAL32
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE9_1
;SingleToString = "                  .0"
	lfsr	1,SINGLETOSTRING
	movlw	low StringTable73
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable73
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable73
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
;SysByte_STS_Ptr = 18
	movlw	18
	movwf	SYSBYTE_STS_PTR,ACCESS
;else
	bra	ENDIF9
ELSE9_1
;SysByte_STS_Ptr = 11
	movlw	11
	movwf	SYSBYTE_STS_PTR,ACCESS
;end if
ENDIF9
;End If
ENDIF3
;SysULongIntTempA = SysULongInt_STS_Num
	movff	SYSULONGINT_STS_NUM,SYSULONGINTTEMPA
	movff	SYSULONGINT_STS_NUM_H,SYSULONGINTTEMPA_H
	movff	SYSULONGINT_STS_NUM_U,SYSULONGINTTEMPA_U
	movff	SYSULONGINT_STS_NUM_E,SYSULONGINTTEMPA_E
	movff	SYSULONGINT_STS_NUM_A,SYSULONGINTTEMPA_A
	movff	SYSULONGINT_STS_NUM_B,SYSULONGINTTEMPA_B
	movff	SYSULONGINT_STS_NUM_C,SYSULONGINTTEMPA_C
	movff	SYSULONGINT_STS_NUM_D,SYSULONGINTTEMPA_D
;SysULongIntTempB = 0
	clrf	SYSULONGINTTEMPB,ACCESS
	clrf	SYSULONGINTTEMPB_H,ACCESS
	clrf	SYSULONGINTTEMPB_U,ACCESS
	clrf	SYSULONGINTTEMPB_E,ACCESS
	clrf	SYSULONGINTTEMPB_A,ACCESS
	clrf	SYSULONGINTTEMPB_B,ACCESS
	clrf	SYSULONGINTTEMPB_C,ACCESS
	clrf	SYSULONGINTTEMPB_D,ACCESS
;SysCompEqual64
	rcall	SYSCOMPEQUAL64
;do while SysByteTempX = False
SysDoLoop_S3
	movf	SYSBYTETEMPX,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysDoLoop_E3
;if SysByte_STS_Ptr < 1 Then
	movlw	1
	subwf	SYSBYTE_STS_PTR,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF4
;ERROR too big of number
;SingleToString = "Error "
	lfsr	1,SINGLETOSTRING
	movlw	low StringTable71
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable71
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable71
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
;SysByte_STS_Err = 0
	clrf	SYSBYTE_STS_ERR,ACCESS
;SysByte_STS_Err.0 = 0     '1 good - 0 - bad
	bcf	SYSBYTE_STS_ERR,0,ACCESS
;SysByte_STS_Err.2 = 1     '1 integer places to many chars-out of range,   0 = ok
	bsf	SYSBYTE_STS_ERR,2,ACCESS
;Exit Function
	return
;end If
ENDIF4
;SysULongIntTempB = 10
	movlw	10
	movwf	SYSULONGINTTEMPB,ACCESS
	clrf	SYSULONGINTTEMPB_H,ACCESS
	clrf	SYSULONGINTTEMPB_U,ACCESS
	clrf	SYSULONGINTTEMPB_E,ACCESS
	clrf	SYSULONGINTTEMPB_A,ACCESS
	clrf	SYSULONGINTTEMPB_B,ACCESS
	clrf	SYSULONGINTTEMPB_C,ACCESS
	clrf	SYSULONGINTTEMPB_D,ACCESS
;SysDivSub64
	rcall	SYSDIVSUB64
;SysByte_STS_Bin = [byte]SysULongIntTempX 	'remainder hold 0-9
	movff	SYSULONGINTTEMPX,SYSBYTE_STS_BIN
;SingleToString(SysByte_STS_Ptr) = (SysByte_STS_Bin + 48)	'add 48 gives tha ASC value of 0 - 9
	lfsr	0,SINGLETOSTRING
	movf	SYSBYTE_STS_PTR,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSBYTE_STS_BIN,W,ACCESS
	movwf	INDF0,ACCESS
;SysByte_STS_Ptr --
	decf	SYSBYTE_STS_PTR,F,ACCESS
;SysULongIntTempB = 0
	clrf	SYSULONGINTTEMPB,ACCESS
	clrf	SYSULONGINTTEMPB_H,ACCESS
	clrf	SYSULONGINTTEMPB_U,ACCESS
	clrf	SYSULONGINTTEMPB_E,ACCESS
	clrf	SYSULONGINTTEMPB_A,ACCESS
	clrf	SYSULONGINTTEMPB_B,ACCESS
	clrf	SYSULONGINTTEMPB_C,ACCESS
	clrf	SYSULONGINTTEMPB_D,ACCESS
;SysCompEqual64
	rcall	SYSCOMPEQUAL64
;loop
	bra	SysDoLoop_S3
SysDoLoop_E3
;SingleToString = Right(SingleToString, (21 - SysByte_STS_Ptr))	'remove leading spaces
	movlw	low SINGLETOSTRING
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high SINGLETOSTRING
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movf	SYSBYTE_STS_PTR,W,ACCESS
	sublw	21
	movwf	SYSCHARCOUNT,ACCESS
	rcall	FN_RIGHT
	lfsr	1,SINGLETOSTRING
	lfsr	0,RIGHT
	rcall	SYSCOPYSTRING
;SysByte_STS_Ptr = SingleToString(0) 'remove trailing 0's except .0
	movffl	SYSSINGLETOSTRING_0,SYSBYTE_STS_PTR
;Do While SysByte_STS_Ptr > 4  ' 0.0
SysDoLoop_S4
	movf	SYSBYTE_STS_PTR,W,ACCESS
	sublw	4
	btfsc	STATUS, C,ACCESS
	bra	SysDoLoop_E4
;If SingleToString(SysByte_STS_Ptr-1) ="." then
	lfsr	0,SINGLETOSTRING
	movf	SYSBYTE_STS_PTR,W,ACCESS
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movlw	1
	subwf	SysTemp1,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	subwfb	SysTemp1_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movlw	46
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;exit Do
	bra	SysDoLoop_E4
;end If
;If SingleToString(SysByte_STS_Ptr) <> "0" then
	lfsr	0,SINGLETOSTRING
	movf	SYSBYTE_STS_PTR,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SysBYTETempA
	movlw	48
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;exit do
	bra	SysDoLoop_E4
;end If
;SysByte_STS_Ptr --
	decf	SYSBYTE_STS_PTR,F,ACCESS
;loop
	bra	SysDoLoop_S4
SysDoLoop_E4
;SingleToString = Left(SingleToString, SysByte_STS_Ptr)
	movlw	low SINGLETOSTRING
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high SINGLETOSTRING
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movff	SYSBYTE_STS_PTR,SYSCHARCOUNT
	rcall	FN_LEFT
	lfsr	1,SINGLETOSTRING
	lfsr	0,LEFT
	rcall	SYSCOPYSTRING
;If SysByte_STS_Sgn = 1 then
	decf	SYSBYTE_STS_SGN,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF7
;negative
;SingleToString(1) = "-"
	movlw	45
	banksel	SYSSINGLETOSTRING_1
	movwf	SYSSINGLETOSTRING_1,BANKED
;End If
ENDIF7
;SysByte_STS_Err = 0
	clrf	SYSBYTE_STS_ERR,ACCESS
;SysByte_STS_Err.0 = 1     '1 good - 0 - bad
	bsf	SYSBYTE_STS_ERR,0,ACCESS
	banksel	0
	return

;********************************************************************************

;Source: system.h (3779)
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

;Source: system.h (3805)
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

;Source: system.h (3859)
SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysLongTempB, W
	movf	SYSLONGTEMPB, W,ACCESS
;cpfseq SysLongTempA
	cpfseq	SYSLONGTEMPA,ACCESS
;return
	return
;Test high, exit if false
;movf SysLongTempB_H, W
	movf	SYSLONGTEMPB_H, W,ACCESS
;cpfseq SysLongTempA_H
	cpfseq	SYSLONGTEMPA_H,ACCESS
;return
	return
;Test upper, exit if false
;movf SysLongTempB_U, W
	movf	SYSLONGTEMPB_U, W,ACCESS
;cpfseq SysLongTempA_U
	cpfseq	SYSLONGTEMPA_U,ACCESS
;return
	return
;Test exp, exit if false
;movf SysLongTempB_E, W
	movf	SYSLONGTEMPB_E, W,ACCESS
;cpfseq SysLongTempA_E
	cpfseq	SYSLONGTEMPA_E,ACCESS
;return
	return
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (4026)
SYSCOMPEQUAL64
;dim SysULongIntTempA as long
;dim SysULongIntTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysULongIntTempB, W
	movf	SYSULONGINTTEMPB, W,ACCESS
;cpfseq SysULongIntTempA
	cpfseq	SYSULONGINTTEMPA,ACCESS
;return
	return
;Test high, exit if false
;movf SysULongIntTempB_H, W
	movf	SYSULONGINTTEMPB_H, W,ACCESS
;cpfseq SysULongIntTempA_H
	cpfseq	SYSULONGINTTEMPA_H,ACCESS
;return
	return
;Test upper, exit if false
;movf SysULongIntTempB_U, W
	movf	SYSULONGINTTEMPB_U, W,ACCESS
;cpfseq SysULongIntTempA_U
	cpfseq	SYSULONGINTTEMPA_U,ACCESS
;return
	return
;Test exp, exit if false
;movf SysULongIntTempB_E, W
	movf	SYSULONGINTTEMPB_E, W,ACCESS
;cpfseq SysULongIntTempA_E
	cpfseq	SYSULONGINTTEMPA_E,ACCESS
;return
	return
;Test A, exit if false
;movf SysULongIntTempB_A, W
	movf	SYSULONGINTTEMPB_A, W,ACCESS
;cpfseq SysULongIntTempA_A
	cpfseq	SYSULONGINTTEMPA_A,ACCESS
;return
	return
;Test B, exit if false
;movf SysULongIntTempB_B, W
	movf	SYSULONGINTTEMPB_B, W,ACCESS
;cpfseq SysULongIntTempA_B
	cpfseq	SYSULONGINTTEMPA_B,ACCESS
;return
	return
;Test C, exit if false
;movf SysULongIntTempB_C, W
	movf	SYSULONGINTTEMPB_C, W,ACCESS
;cpfseq SysULongIntTempA_C
	cpfseq	SYSULONGINTTEMPA_C,ACCESS
;return
	return
;Test D, exit if false
;movf SysULongIntTempB_D, W
	movf	SYSULONGINTTEMPB_D, W,ACCESS
;cpfseq SysULongIntTempA_D
	cpfseq	SYSULONGINTTEMPA_D,ACCESS
;return
	return
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (4199)
SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W,ACCESS
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W,ACCESS
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W,ACCESS
;bnc SCLT16True
	bnc	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W,ACCESS
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

;Source: system.h (4257)
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

;Source: system.h (1457)
SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length for ChipFamily 16 support
;movff INDF0, SysCalcTempA
	movff	INDF0, SYSCALCTEMPA
;movff SysCalcTempA, INDF1
	movff	SYSCALCTEMPA, INDF1
;goto SysCopyStringCheck
	bra	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART
;movf INDF0, W
	movf	INDF0, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F,ACCESS
SYSCOPYSTRINGCHECK
;Exit if length = 0
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
SYSSTRINGCOPY
;Copy character
;movff PREINC0, PREINC1
	movff	PREINC0, PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringCopy
	bra	SYSSTRINGCOPY
	return

;********************************************************************************

;Source: system.h (3318)
SYSDIVSUB64
;dim SysTotalTemp as Word
;dim SysULongIntTempA as ulongint
;dim SysULongIntTempB as ulongint
;dim SysULongIntTempX as ulongint
;#ifdef PIC
;dim SysULongIntDivMultA as ulongint
;dim SysULongIntDivMultB as ulongint
;dim SysULongIntDivMultX as ulongint
;#endif
;SysULongIntDivMultA = SysULongIntTempA
	movff	SYSULONGINTTEMPA,SYSULONGINTDIVMULTA
	movff	SYSULONGINTTEMPA_H,SYSULONGINTDIVMULTA_H
	movff	SYSULONGINTTEMPA_U,SYSULONGINTDIVMULTA_U
	movff	SYSULONGINTTEMPA_E,SYSULONGINTDIVMULTA_E
	movff	SYSULONGINTTEMPA_A,SYSULONGINTDIVMULTA_A
	movff	SYSULONGINTTEMPA_B,SYSULONGINTDIVMULTA_B
	movff	SYSULONGINTTEMPA_C,SYSULONGINTDIVMULTA_C
	movff	SYSULONGINTTEMPA_D,SYSULONGINTDIVMULTA_D
;SysULongIntDivMultB = SysULongIntTempB
	movff	SYSULONGINTTEMPB,SYSULONGINTDIVMULTB
	movff	SYSULONGINTTEMPB_H,SYSULONGINTDIVMULTB_H
	movff	SYSULONGINTTEMPB_U,SYSULONGINTDIVMULTB_U
	movff	SYSULONGINTTEMPB_E,SYSULONGINTDIVMULTB_E
	movff	SYSULONGINTTEMPB_A,SYSULONGINTDIVMULTB_A
	movff	SYSULONGINTTEMPB_B,SYSULONGINTDIVMULTB_B
	movff	SYSULONGINTTEMPB_C,SYSULONGINTDIVMULTB_C
	movff	SYSULONGINTTEMPB_D,SYSULONGINTDIVMULTB_D
;SysULongIntDivMultX = 0
	clrf	SYSULONGINTDIVMULTX,ACCESS
	clrf	SYSULONGINTDIVMULTX_H,ACCESS
	clrf	SYSULONGINTDIVMULTX_U,ACCESS
	clrf	SYSULONGINTDIVMULTX_E,ACCESS
	clrf	SYSULONGINTDIVMULTX_A,ACCESS
	clrf	SYSULONGINTDIVMULTX_B,ACCESS
	clrf	SYSULONGINTDIVMULTX_C,ACCESS
	clrf	SYSULONGINTDIVMULTX_D,ACCESS
;Avoid division by zero
;Have to do it this way because there are no comparison routines for ULongInt
;SysTotalTemp = SysULongIntDivMultB + SysULongIntDivMultB_U + SysULongIntDivMultB_E + SysULongIntDivMultB_A + SysULongIntDivMultB_B + SysULongIntDivMultB_C + SysULongIntDivMultB_D
	movf	SYSULONGINTDIVMULTB_U,W,ACCESS
	addwf	SYSULONGINTDIVMULTB,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	addwfc	SYSULONGINTDIVMULTB_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movf	SYSULONGINTDIVMULTB_E,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	movf	SYSULONGINTDIVMULTB_A,W,ACCESS
	addwf	SysTemp2,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movf	SYSULONGINTDIVMULTB_B,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	movf	SYSULONGINTDIVMULTB_C,W,ACCESS
	addwf	SysTemp2,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movf	SYSULONGINTDIVMULTB_D,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	SYSTOTALTEMP,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,ACCESS
	movwf	SYSTOTALTEMP_H,ACCESS
;if SysTotalTemp = 0 then
	movff	SYSTOTALTEMP,SysWORDTempA
	movff	SYSTOTALTEMP_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF15
;SysULongIntTempA = 0
	clrf	SYSULONGINTTEMPA,ACCESS
	clrf	SYSULONGINTTEMPA_H,ACCESS
	clrf	SYSULONGINTTEMPA_U,ACCESS
	clrf	SYSULONGINTTEMPA_E,ACCESS
	clrf	SYSULONGINTTEMPA_A,ACCESS
	clrf	SYSULONGINTTEMPA_B,ACCESS
	clrf	SYSULONGINTTEMPA_C,ACCESS
	clrf	SYSULONGINTTEMPA_D,ACCESS
;exit sub
	return
;end if
ENDIF15
;Main calc routine
;SysDivLoop = 64
	movlw	64
	movwf	SYSDIVLOOP,ACCESS
SYSDIV64START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysULongIntDivMultA Left
	rlcf	SYSULONGINTDIVMULTA,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_H,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_U,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_E,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_A,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_B,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_C,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_D,F,ACCESS
;Rotate SysULongIntDivMultX Left
	rlcf	SYSULONGINTDIVMULTX,F,ACCESS
	rlcf	SYSULONGINTDIVMULTX_H,F,ACCESS
	rlcf	SYSULONGINTDIVMULTX_U,F,ACCESS
	rlcf	SYSULONGINTDIVMULTX_E,F,ACCESS
	rlcf	SYSULONGINTDIVMULTX_A,F,ACCESS
	rlcf	SYSULONGINTDIVMULTX_B,F,ACCESS
	rlcf	SYSULONGINTDIVMULTX_C,F,ACCESS
	rlcf	SYSULONGINTDIVMULTX_D,F,ACCESS
;SysULongIntDivMultX = SysULongIntDivMultX - SysULongIntDivMultB
	movf	SYSULONGINTDIVMULTB,W,ACCESS
	subwf	SYSULONGINTDIVMULTX,F,ACCESS
	movf	SYSULONGINTDIVMULTB_H,W,ACCESS
	subwfb	SYSULONGINTDIVMULTX_H,F,ACCESS
	movf	SYSULONGINTDIVMULTB_U,W,ACCESS
	subwfb	SYSULONGINTDIVMULTX_U,F,ACCESS
	movf	SYSULONGINTDIVMULTB_E,W,ACCESS
	subwfb	SYSULONGINTDIVMULTX_E,F,ACCESS
	movf	SYSULONGINTDIVMULTB_A,W,ACCESS
	subwfb	SYSULONGINTDIVMULTX_A,F,ACCESS
	movf	SYSULONGINTDIVMULTB_B,W,ACCESS
	subwfb	SYSULONGINTDIVMULTX_B,F,ACCESS
	movf	SYSULONGINTDIVMULTB_C,W,ACCESS
	subwfb	SYSULONGINTDIVMULTX_C,F,ACCESS
	movf	SYSULONGINTDIVMULTB_D,W,ACCESS
	subwfb	SYSULONGINTDIVMULTX_D,F,ACCESS
;Set SysULongIntDivMultA.0 On
	bsf	SYSULONGINTDIVMULTA,0,ACCESS
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF16
;Set SysULongIntDivMultA.0 Off
	bcf	SYSULONGINTDIVMULTA,0,ACCESS
;SysULongIntDivMultX = SysULongIntDivMultX + SysULongIntDivMultB
	movf	SYSULONGINTDIVMULTB,W,ACCESS
	addwf	SYSULONGINTDIVMULTX,F,ACCESS
	movf	SYSULONGINTDIVMULTB_H,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_H,F,ACCESS
	movf	SYSULONGINTDIVMULTB_U,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_U,F,ACCESS
	movf	SYSULONGINTDIVMULTB_E,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_E,F,ACCESS
	movf	SYSULONGINTDIVMULTB_A,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_A,F,ACCESS
	movf	SYSULONGINTDIVMULTB_B,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_B,F,ACCESS
	movf	SYSULONGINTDIVMULTB_C,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_C,F,ACCESS
	movf	SYSULONGINTDIVMULTB_D,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_D,F,ACCESS
;End If
ENDIF16
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv64Start
	bra	SYSDIV64START
;SysULongIntTempA = SysULongIntDivMultA
	movff	SYSULONGINTDIVMULTA,SYSULONGINTTEMPA
	movff	SYSULONGINTDIVMULTA_H,SYSULONGINTTEMPA_H
	movff	SYSULONGINTDIVMULTA_U,SYSULONGINTTEMPA_U
	movff	SYSULONGINTDIVMULTA_E,SYSULONGINTTEMPA_E
	movff	SYSULONGINTDIVMULTA_A,SYSULONGINTTEMPA_A
	movff	SYSULONGINTDIVMULTA_B,SYSULONGINTTEMPA_B
	movff	SYSULONGINTDIVMULTA_C,SYSULONGINTTEMPA_C
	movff	SYSULONGINTDIVMULTA_D,SYSULONGINTTEMPA_D
;SysULongIntTempX = SysULongIntDivMultX
	movff	SYSULONGINTDIVMULTX,SYSULONGINTTEMPX
	movff	SYSULONGINTDIVMULTX_H,SYSULONGINTTEMPX_H
	movff	SYSULONGINTDIVMULTX_U,SYSULONGINTTEMPX_U
	movff	SYSULONGINTDIVMULTX_E,SYSULONGINTTEMPX_E
	movff	SYSULONGINTDIVMULTX_A,SYSULONGINTTEMPX_A
	movff	SYSULONGINTDIVMULTX_B,SYSULONGINTTEMPX_B
	movff	SYSULONGINTDIVMULTX_C,SYSULONGINTTEMPX_C
	movff	SYSULONGINTDIVMULTX_D,SYSULONGINTTEMPX_D
	return

;********************************************************************************

;Source: system.h (2836)
SYSMULTSUB64
;dim SysWordTempX as Word
;dim SysULongIntTempA as ulongint
;dim SysULongIntTempB as ulongint
;dim SysULongIntTempX as ulongint
;dim SysULongIntDivMultA as ulongint
;dim SysULongIntDivMultB as ulongint
;dim SysULongIntDivMultX as ulongint
;SysULongIntDivMultA = SysULongIntTempA
	movff	SYSULONGINTTEMPA,SYSULONGINTDIVMULTA
	movff	SYSULONGINTTEMPA_H,SYSULONGINTDIVMULTA_H
	movff	SYSULONGINTTEMPA_U,SYSULONGINTDIVMULTA_U
	movff	SYSULONGINTTEMPA_E,SYSULONGINTDIVMULTA_E
	movff	SYSULONGINTTEMPA_A,SYSULONGINTDIVMULTA_A
	movff	SYSULONGINTTEMPA_B,SYSULONGINTDIVMULTA_B
	movff	SYSULONGINTTEMPA_C,SYSULONGINTDIVMULTA_C
	movff	SYSULONGINTTEMPA_D,SYSULONGINTDIVMULTA_D
;SysULongIntDivMultB = SysULongIntTempB
	movff	SYSULONGINTTEMPB,SYSULONGINTDIVMULTB
	movff	SYSULONGINTTEMPB_H,SYSULONGINTDIVMULTB_H
	movff	SYSULONGINTTEMPB_U,SYSULONGINTDIVMULTB_U
	movff	SYSULONGINTTEMPB_E,SYSULONGINTDIVMULTB_E
	movff	SYSULONGINTTEMPB_A,SYSULONGINTDIVMULTB_A
	movff	SYSULONGINTTEMPB_B,SYSULONGINTDIVMULTB_B
	movff	SYSULONGINTTEMPB_C,SYSULONGINTDIVMULTB_C
	movff	SYSULONGINTTEMPB_D,SYSULONGINTDIVMULTB_D
;SysULongIntDivMultX = 0
	clrf	SYSULONGINTDIVMULTX,ACCESS
	clrf	SYSULONGINTDIVMULTX_H,ACCESS
	clrf	SYSULONGINTDIVMULTX_U,ACCESS
	clrf	SYSULONGINTDIVMULTX_E,ACCESS
	clrf	SYSULONGINTDIVMULTX_A,ACCESS
	clrf	SYSULONGINTDIVMULTX_B,ACCESS
	clrf	SYSULONGINTDIVMULTX_C,ACCESS
	clrf	SYSULONGINTDIVMULTX_D,ACCESS
MUL64LOOP
;IF SysULongIntDivMultB.0 ON then SysULongIntDivMultX += SysULongIntDivMultA
	btfss	SYSULONGINTDIVMULTB,0,ACCESS
	bra	ENDIF13
;IF SysULongIntDivMultB.0 ON then SysULongIntDivMultX += SysULongIntDivMultA
	movf	SYSULONGINTDIVMULTA,W,ACCESS
	addwf	SYSULONGINTDIVMULTX,F,ACCESS
	movf	SYSULONGINTDIVMULTA_H,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_H,F,ACCESS
	movf	SYSULONGINTDIVMULTA_U,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_U,F,ACCESS
	movf	SYSULONGINTDIVMULTA_E,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_E,F,ACCESS
	movf	SYSULONGINTDIVMULTA_A,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_A,F,ACCESS
	movf	SYSULONGINTDIVMULTA_B,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_B,F,ACCESS
	movf	SYSULONGINTDIVMULTA_C,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_C,F,ACCESS
	movf	SYSULONGINTDIVMULTA_D,W,ACCESS
	addwfc	SYSULONGINTDIVMULTX_D,F,ACCESS
;IF SysULongIntDivMultB.0 ON then SysULongIntDivMultX += SysULongIntDivMultA
ENDIF13
;set STATUS.C OFF
	bcf	STATUS,C,ACCESS
;rotate SysULongIntDivMultB right
	rrcf	SYSULONGINTDIVMULTB_D,F,ACCESS
	rrcf	SYSULONGINTDIVMULTB_C,F,ACCESS
	rrcf	SYSULONGINTDIVMULTB_B,F,ACCESS
	rrcf	SYSULONGINTDIVMULTB_A,F,ACCESS
	rrcf	SYSULONGINTDIVMULTB_E,F,ACCESS
	rrcf	SYSULONGINTDIVMULTB_U,F,ACCESS
	rrcf	SYSULONGINTDIVMULTB_H,F,ACCESS
	rrcf	SYSULONGINTDIVMULTB,F,ACCESS
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate SysULongIntDivMultA left
	rlcf	SYSULONGINTDIVMULTA,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_H,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_U,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_E,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_A,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_B,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_C,F,ACCESS
	rlcf	SYSULONGINTDIVMULTA_D,F,ACCESS
;SysWordTempX = SysULongIntDivMultB + SysULongIntDivMultB_H + SysULongIntDivMultB_U + SysULongIntDivMultB_E + SysULongIntDivMultB_A + SysULongIntDivMultB_B + SysULongIntDivMultB_C + SysULongIntDivMultB_D
	movf	SYSULONGINTDIVMULTB_H,W,ACCESS
	addwf	SYSULONGINTDIVMULTB,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	addwfc	SYSULONGINTDIVMULTB_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movf	SYSULONGINTDIVMULTB_U,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	movf	SYSULONGINTDIVMULTB_E,W,ACCESS
	addwf	SysTemp2,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movf	SYSULONGINTDIVMULTB_A,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	movf	SYSULONGINTDIVMULTB_B,W,ACCESS
	addwf	SysTemp2,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movf	SYSULONGINTDIVMULTB_C,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	movf	SYSULONGINTDIVMULTB_D,W,ACCESS
	addwf	SysTemp2,W,ACCESS
	movwf	SYSWORDTEMPX,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,ACCESS
	movwf	SYSWORDTEMPX_H,ACCESS
;if SysWordTempX > 0 then goto MUL64LOOP
	movff	SYSWORDTEMPX,SysWORDTempB
	movff	SYSWORDTEMPX_H,SysWORDTempB_H
	clrf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
;if SysWordTempX > 0 then goto MUL64LOOP
	bra	MUL64LOOP
;if SysWordTempX > 0 then goto MUL64LOOP
;if SysULongIntDivMultB > 0 then goto MUL64LOOP
;SysULongIntTempX = SysULongIntDivMultX
	movff	SYSULONGINTDIVMULTX,SYSULONGINTTEMPX
	movff	SYSULONGINTDIVMULTX_H,SYSULONGINTTEMPX_H
	movff	SYSULONGINTDIVMULTX_U,SYSULONGINTTEMPX_U
	movff	SYSULONGINTDIVMULTX_E,SYSULONGINTTEMPX_E
	movff	SYSULONGINTDIVMULTX_A,SYSULONGINTTEMPX_A
	movff	SYSULONGINTDIVMULTX_B,SYSULONGINTTEMPX_B
	movff	SYSULONGINTDIVMULTX_C,SYSULONGINTTEMPX_C
	movff	SYSULONGINTDIVMULTX_D,SYSULONGINTTEMPX_D
	return

;********************************************************************************

;Source: system.h (1654)
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
	db	7,49,32,48,46,48,32,39


StringTable2
	db	1,39


StringTable3
	db	8,50,32,48,46,48,53,32,39


StringTable4
	db	7,51,32,48,46,53,32,39


StringTable5
	db	7,52,32,49,46,53,32,39


StringTable6
	db	14,53,32,51,46,49,52,49,53,57,50,54,53,32,39


StringTable7
	db	19,54,32,57,57,57,57,57,57,46,57,57,57,57,57,57,57,57,32,39


StringTable8
	db	4,68,111,110,101


StringTable22
	db	1,45


StringTable65
	db	1,46


StringTable69
	db	1,48


StringTable70
	db	3,48,46,48


StringTable71
	db	6,69,114,114,111,114,32


StringTable72
	db	20,32,32,32,32,32,32,32,32,32,32,48,46,48,48,48,48,48,48,48,48


StringTable73
	db	20,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,46,48


;********************************************************************************


 END
