;Program compiled by GCBASIC (2026.08.07 (Windows 64 bit) : Build 1617) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-08-13 CRC247
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\220_i2c_glcd_voltmeter_using_ssd1306.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\220_i2c_glcd_voltmeter_using_ssd1306.build\220_i2c_glcd_voltmeter_using_ssd1306.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\220_i2c_glcd_voltmeter_using_ssd1306.gcb"
 SUBTITLE    "08-15-2026 08:39:54"
#include <P18F46Q35.inc>
 CONFIG  CPD = OFF
 CONFIG  CP = OFF
 CONFIG  WRTSAF = OFF
 CONFIG  WRTD = OFF
 CONFIG  WRTB = OFF
 CONFIG  WDTE = OFF
 CONFIG  XINST = OFF
 CONFIG  LVP = OFF
 CONFIG  MVECEN = OFF
 CONFIG  MCLRE = EXTMCLR
 CONFIG  FCMEN = ON
 CONFIG  CLKOUTEN = OFF
 CONFIG  RSTOSC = HFINTOSC_1MHZ
 CONFIG  FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
ADCVAL                           EQU    1294          ; 0x50E (SA)
ADCVAL_H                         EQU    1295          ; 0x50F (SA)
ADREADPORT                       EQU    1296          ; 0x510 (SA)
ANGLE                            EQU    1297          ; 0x511 (SA)
ANGLE_H                          EQU    1298          ; 0x512 (SA)
ASC                              EQU    1299          ; 0x513 (SA)
CHARCODE                         EQU    1300          ; 0x514 (SA)
CHARCOL                          EQU    1301          ; 0x515 (SA)
CHARCOLS                         EQU    1303          ; 0x517 (SA)
CHARCOL_H                        EQU    1302          ; 0x516 (SA)
CHARLOCX                         EQU    1304          ; 0x518 (SA)
CHARLOCX_H                       EQU    1305          ; 0x519 (SA)
CHARLOCY                         EQU    1306          ; 0x51A (SA)
CHARLOCY_H                       EQU    1307          ; 0x51B (SA)
CHARROW                          EQU    1308          ; 0x51C (SA)
CHARROWS                         EQU    1310          ; 0x51E (SA)
CHARROW_H                        EQU    1309          ; 0x51D (SA)
COL                              EQU    1311          ; 0x51F (SA)
COS                              EQU    1312          ; 0x520 (SA)
COS_H                            EQU    1313          ; 0x521 (SA)
CURRCHARCOL                      EQU    1314          ; 0x522 (SA)
CURRCHARROW                      EQU    1315          ; 0x523 (SA)
CURRCHARVAL                      EQU    1316          ; 0x524 (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
DRAWLINE                         EQU    1317          ; 0x525 (SA)
DRAWLINE_H                       EQU    1318          ; 0x526 (SA)
GLCDBACKGROUND                   EQU    1319          ; 0x527 (SA)
GLCDBACKGROUND_H                 EQU    1320          ; 0x528 (SA)
GLCDBITNO                        EQU    1321          ; 0x529 (SA)
GLCDCHANGE                       EQU    1322          ; 0x52A (SA)
GLCDCOLOUR                       EQU    1323          ; 0x52B (SA)
GLCDCOLOUR_H                     EQU    1324          ; 0x52C (SA)
GLCDDATATEMP                     EQU    1325          ; 0x52D (SA)
GLCDFNTDEFAULT                   EQU    1326          ; 0x52E (SA)
GLCDFNTDEFAULTHEIGHT             EQU    1327          ; 0x52F (SA)
GLCDFNTDEFAULTSIZE               EQU    1328          ; 0x530 (SA)
GLCDFONTWIDTH                    EQU    1329          ; 0x531 (SA)
GLCDFOREGROUND                   EQU    1330          ; 0x532 (SA)
GLCDFOREGROUND_H                 EQU    1331          ; 0x533 (SA)
GLCDPRINTLEN                     EQU    1332          ; 0x534 (SA)
GLCDPRINTLOC                     EQU    1333          ; 0x535 (SA)
GLCDPRINTLOC_H                   EQU    1334          ; 0x536 (SA)
GLCDPRINT_STRING_COUNTER         EQU    1335          ; 0x537 (SA)
GLCDTEMP                         EQU    1336          ; 0x538 (SA)
GLCDTEMP_H                       EQU    1337          ; 0x539 (SA)
GLCDX                            EQU    1338          ; 0x53A (SA)
GLCDY                            EQU    1339          ; 0x53B (SA)
GLCD_YORDINATE                   EQU    1340          ; 0x53C (SA)
GLCD_YORDINATE_H                 EQU    1341          ; 0x53D (SA)
HI2C1LASTERROR                   EQU    1342          ; 0x53E (SA)
HI2C1STATEMACHINE                EQU    1343          ; 0x53F (SA)
HI2CACKPOLLSTATE                 EQU    1344          ; 0x540 (SA)
HI2CCURRENTMODE                  EQU    1345          ; 0x541 (SA)
HI2CWAITMSSPTIMEOUT              EQU    1346          ; 0x542 (SA)
HWI2C_BUFFER                     EQU    4252          ; 0x109C
HWI2C_BUFFERLOCATIONCOUNTER      EQU    1347          ; 0x543 (SA)
HWI2C_BUFFERLOCATIONCOUNTERINDEX EQU    1349          ; 0x545 (SA)
HWI2C_BUFFERLOCATIONCOUNTERINDEX EQU    1350          ; 0x546 (SA)
HWI2C_BUFFERLOCATIONCOUNTER_H    EQU    1348          ; 0x544 (SA)
I2CBYTE                          EQU    1351          ; 0x547 (SA)
LEFT                             EQU    4310          ; 0x10D6
LINECOLOUR                       EQU    1352          ; 0x548 (SA)
LINECOLOUR_H                     EQU    1353          ; 0x549 (SA)
LINEDIFFX                        EQU    1354          ; 0x54A (SA)
LINEDIFFX_H                      EQU    1355          ; 0x54B (SA)
LINEDIFFX_X2                     EQU    1356          ; 0x54C (SA)
LINEDIFFX_X2_H                   EQU    1357          ; 0x54D (SA)
LINEDIFFY                        EQU    1358          ; 0x54E (SA)
LINEDIFFY_H                      EQU    1359          ; 0x54F (SA)
LINEDIFFY_X2                     EQU    1360          ; 0x550 (SA)
LINEDIFFY_X2_H                   EQU    1361          ; 0x551 (SA)
LINEERR                          EQU    1362          ; 0x552 (SA)
LINEERR_H                        EQU    1363          ; 0x553 (SA)
LINESTEPX                        EQU    1364          ; 0x554 (SA)
LINESTEPX_H                      EQU    1365          ; 0x555 (SA)
LINESTEPY                        EQU    1366          ; 0x556 (SA)
LINESTEPY_H                      EQU    1367          ; 0x557 (SA)
LINEX1                           EQU    1368          ; 0x558 (SA)
LINEX1_H                         EQU    1369          ; 0x559 (SA)
LINEX2                           EQU    1370          ; 0x55A (SA)
LINEX2_H                         EQU    1371          ; 0x55B (SA)
LINEY1                           EQU    1372          ; 0x55C (SA)
LINEY1_H                         EQU    1373          ; 0x55D (SA)
LINEY2                           EQU    1374          ; 0x55E (SA)
LINEY2_H                         EQU    1375          ; 0x55F (SA)
LOCX                             EQU    1376          ; 0x560
LOCY                             EQU    1377          ; 0x561
L_CALIBRATE                      EQU    1378          ; 0x562
L_CALIBRATE_H                    EQU    1379          ; 0x563
L_FROMHIGH                       EQU    1380          ; 0x564
L_FROMHIGH_H                     EQU    1381          ; 0x565
L_FROMLOW                        EQU    1382          ; 0x566
L_FROMLOW_H                      EQU    1383          ; 0x567
L_MAP                            EQU    1384          ; 0x568
L_MAP_H                          EQU    1385          ; 0x569
L_SYSCALC                        EQU    1386          ; 0x56A
L_SYSCALCF                       EQU    1388          ; 0x56C
L_SYSCALCF_E                     EQU    1391          ; 0x56F
L_SYSCALCF_H                     EQU    1389          ; 0x56D
L_SYSCALCF_U                     EQU    1390          ; 0x56E
L_SYSCALC_H                      EQU    1387          ; 0x56B
L_TOHIGH                         EQU    1392          ; 0x570
L_TOHIGH_H                       EQU    1393          ; 0x571
L_TOLOW                          EQU    1394          ; 0x572
L_TOLOW_H                        EQU    1395          ; 0x573
MID                              EQU    4269          ; 0x10AD
OLD_ANGLE                        EQU    1396          ; 0x574
OLD_ANGLE_H                      EQU    1397          ; 0x575
OLD_XEND                         EQU    1398          ; 0x576
OLD_YEND                         EQU    1399          ; 0x577
POSCHARX                         EQU    1400          ; 0x578
POSCHARX_H                       EQU    1401          ; 0x579
POSCHARY                         EQU    1402          ; 0x57A
PRINTLOCX                        EQU    1403          ; 0x57B
PRINTLOCX_H                      EQU    1404          ; 0x57C
PRINTLOCY                        EQU    1405          ; 0x57D
PRINTLOCY_H                      EQU    1406          ; 0x57E
RADIUS                           EQU    1407          ; 0x57F
READAD10                         EQU    1408          ; 0x580
READAD10_H                       EQU    1409          ; 0x581
ROW                              EQU    1410          ; 0x582
SCALE                            EQU    1411          ; 0x583
SCALE_H                          EQU    1412          ; 0x584
SIN                              EQU    1413          ; 0x585
SIN_H                            EQU    1414          ; 0x586
SSD1306SENDBYTE                  EQU    1415          ; 0x587
SSD1306_BUFFERALIAS              EQU    4351          ; 0x10FF
SSD1306_BUFFERLOCATIONCALC       EQU    1416          ; 0x588
SSD1306_BUFFERLOCATIONCALC_H     EQU    1417          ; 0x589
STR                              EQU    4246          ; 0x1096
STRINGPOINTER                    EQU    1418          ; 0x58A
SYSARRAYTEMP1                    EQU    1419          ; 0x58B
SYSARRAYTEMP2                    EQU    1420          ; 0x58C
SYSBYTETEMPA                     EQU    1285          ; 0x505 (SA)
SYSBYTETEMPB                     EQU    1289          ; 0x509 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPA                     EQU    1285          ; 0x505 (SA)
SYSCALCTEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPX_H                   EQU    1281          ; 0x501 (SA)
SYSCHAR                          EQU    1421          ; 0x58D
SYSCHARCOUNT                     EQU    1422          ; 0x58E
SYSCHARSTART                     EQU    1423          ; 0x58F
SYSDIVLOOP                       EQU    1284          ; 0x504 (SA)
SYSDIVMULTA                      EQU    1287          ; 0x507 (SA)
SYSDIVMULTA_H                    EQU    1288          ; 0x508 (SA)
SYSDIVMULTB                      EQU    1291          ; 0x50B (SA)
SYSDIVMULTB_H                    EQU    1292          ; 0x50C (SA)
SYSDIVMULTX                      EQU    1282          ; 0x502 (SA)
SYSDIVMULTX_H                    EQU    1283          ; 0x503 (SA)
SYSFORLOOPABSVALUE11             EQU    1424          ; 0x590
SYSFORLOOPABSVALUE11_H           EQU    1425          ; 0x591
SYSFORLOOPSTEP10                 EQU    1426          ; 0x592
SYSFORLOOPSTEP10_H               EQU    1427          ; 0x593
SYSINTEGERTEMPA                  EQU    1285          ; 0x505 (SA)
SYSINTEGERTEMPA_H                EQU    1286          ; 0x506 (SA)
SYSINTEGERTEMPB                  EQU    1289          ; 0x509 (SA)
SYSINTEGERTEMPB_H                EQU    1290          ; 0x50A (SA)
SYSINTEGERTEMPX                  EQU    1280          ; 0x500 (SA)
SYSINTEGERTEMPX_H                EQU    1281          ; 0x501 (SA)
SYSLCDPRINTDATAHANDLER           EQU    1428          ; 0x594
SYSLCDPRINTDATAHANDLER_H         EQU    1429          ; 0x595
SYSLONGDIVMULTA                  EQU    1430          ; 0x596
SYSLONGDIVMULTA_E                EQU    1433          ; 0x599
SYSLONGDIVMULTA_H                EQU    1431          ; 0x597
SYSLONGDIVMULTA_U                EQU    1432          ; 0x598
SYSLONGDIVMULTB                  EQU    1434          ; 0x59A
SYSLONGDIVMULTB_E                EQU    1437          ; 0x59D
SYSLONGDIVMULTB_H                EQU    1435          ; 0x59B
SYSLONGDIVMULTB_U                EQU    1436          ; 0x59C
SYSLONGDIVMULTX                  EQU    1438          ; 0x59E
SYSLONGDIVMULTX_E                EQU    1441          ; 0x5A1
SYSLONGDIVMULTX_H                EQU    1439          ; 0x59F
SYSLONGDIVMULTX_U                EQU    1440          ; 0x5A0
SYSLONGTEMPA                     EQU    1285          ; 0x505 (SA)
SYSLONGTEMPA_E                   EQU    1288          ; 0x508 (SA)
SYSLONGTEMPA_H                   EQU    1286          ; 0x506 (SA)
SYSLONGTEMPA_U                   EQU    1287          ; 0x507 (SA)
SYSLONGTEMPB                     EQU    1289          ; 0x509 (SA)
SYSLONGTEMPB_E                   EQU    1292          ; 0x50C (SA)
SYSLONGTEMPB_H                   EQU    1290          ; 0x50A (SA)
SYSLONGTEMPB_U                   EQU    1291          ; 0x50B (SA)
SYSLONGTEMPX                     EQU    1280          ; 0x500 (SA)
SYSLONGTEMPX_E                   EQU    1283          ; 0x503 (SA)
SYSLONGTEMPX_H                   EQU    1281          ; 0x501 (SA)
SYSLONGTEMPX_U                   EQU    1282          ; 0x502 (SA)
SYSREPEATTEMP1                   EQU    1442          ; 0x5A2
SYSREPEATTEMP4                   EQU    1443          ; 0x5A3
SYSSIGNBYTE                      EQU    1293          ; 0x50D (SA)
SYSSTRDATA                       EQU    1444          ; 0x5A4
SYSSTRINGA                       EQU    1287          ; 0x507 (SA)
SYSSTRINGA_H                     EQU    1288          ; 0x508 (SA)
SYSSTRINGLENGTH                  EQU    1286          ; 0x506 (SA)
SYSSTRINGPARAM1                  EQU    4238          ; 0x108E
SYSSTRINGTEMP                    EQU    1445          ; 0x5A5
SYSSYSINSTRINGAHANDLER           EQU    1446          ; 0x5A6
SYSSYSINSTRINGAHANDLER_H         EQU    1447          ; 0x5A7
SYSSYSINSTRINGHANDLER            EQU    1448          ; 0x5A8
SYSSYSINSTRINGHANDLER_H          EQU    1449          ; 0x5A9
SYSTEMP1                         EQU    1450          ; 0x5AA
SYSTEMP1_E                       EQU    1453          ; 0x5AD
SYSTEMP1_H                       EQU    1451          ; 0x5AB
SYSTEMP1_U                       EQU    1452          ; 0x5AC
SYSTEMP2                         EQU    1454          ; 0x5AE
SYSTEMP2_H                       EQU    1455          ; 0x5AF
SYSTEMP3                         EQU    1456          ; 0x5B0
SYSVALTEMP                       EQU    1457          ; 0x5B1
SYSVALTEMP_H                     EQU    1458          ; 0x5B2
SYSWAITTEMP10US                  EQU    1285          ; 0x505 (SA)
SYSWAITTEMPMS                    EQU    1282          ; 0x502 (SA)
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503 (SA)
SYSWAITTEMPUS                    EQU    1285          ; 0x505 (SA)
SYSWAITTEMPUS_H                  EQU    1286          ; 0x506 (SA)
SYSWORDTEMPA                     EQU    1285          ; 0x505 (SA)
SYSWORDTEMPA_H                   EQU    1286          ; 0x506 (SA)
SYSWORDTEMPB                     EQU    1289          ; 0x509 (SA)
SYSWORDTEMPB_H                   EQU    1290          ; 0x50A (SA)
SYSWORDTEMPX                     EQU    1280          ; 0x500 (SA)
SYSWORDTEMPX_H                   EQU    1281          ; 0x501 (SA)
TRIG_ARG1                        EQU    1459          ; 0x5B3
TRIG_ARG1_H                      EQU    1460          ; 0x5B4
TRIG_ARG2                        EQU    1461          ; 0x5B5
TRIG_ARG2_H                      EQU    1462          ; 0x5B6
TRIG_I                           EQU    1463          ; 0x5B7
TRIG_REF                         EQU    1464          ; 0x5B8
TRIG_REF_H                       EQU    1465          ; 0x5B9
TRIG_SIGN                        EQU    1466          ; 0x5BA
TRIG_SIGN_H                      EQU    1467          ; 0x5BB
TRIG_VAL                         EQU    1468          ; 0x5BC
TRIG_VAL_H                       EQU    1469          ; 0x5BD
VOLTS                            EQU    4241          ; 0x1091
XCENTRE                          EQU    1470          ; 0x5BE
XEND                             EQU    1471          ; 0x5BF
YCENTRE                          EQU    1472          ; 0x5C0
YEND                             EQU    1473          ; 0x5C1

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
SYSLEFT_0 EQU 4310
SYSMID_0 EQU 4269
SYSREADAD10WORD EQU 1408
SYSREADAD10WORD_H EQU 1409
SYSSCALEWORD EQU 1411
SYSSCALEWORD_H EQU 1412
SYSSTR_0 EQU 4246

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
	call	INITSYS
	call	INITPPS
	call	HI2CQ24Q35INIT
	call	INITGLCD_SSD1306

;Start_of_the_main_program
;
;This demonstration program is a simple GLCD demonstration of the SSD1306 GLCD capabilities and Maths/Trig capabilities.
;
;This program demonstrates theGCBASIC primatives a voltmeter on a Graphical LCD (GLCD)
;:
;You can change the microcontroller, the GLCD and the analogue port.
;
;To change the microcontroller simply change the #chip statement
;To change the GLCD replace GLCD definition
;To change the analogue port change the ADCChannelSelected constant
;
;************************************************************************
;@author  EvanV
;@licence GPL
;@version 1.02
;@date    02-08-2026
;
;----- Configuration
;Set microcontroller required
;PIC PPS Tool version: 0.0.6.5
;
;------------PORTA---------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ------------SW--------------ADC--
;IO:    ---------------------------------
;
;------------PORTB----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ----------------LED-LED-LED-LED--
;IO:    ---------------------------------
;
;------------PORTC----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    VDD--TX-----SDA-SCL---------------
;IO:    ---------------------------------
;
;------------PORTD----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    PWR-EN--RW--RS--DB7-DB6-DB5-DB4--
;IO:    ---------------------------------
;
;------------PORTE----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ----------------RST---------------
;IO:    ---------------------------------
;
;Define constants to make things easier. We can reuse a constant at any time.
;Dir     LEDD0 Out
	banksel	TRISB
	bcf	TRISB,0,BANKED
;Dir     LEDD1 Out
	bcf	TRISB,1,BANKED
;Dir     LEDD2 Out
	bcf	TRISB,2,BANKED
;Dir     LEDD3 Out
	bcf	TRISB,3,BANKED
;This is the PORTA.0 port
;Dir POTENTIOMETER In
	bsf	TRISA,0,BANKED
;Dir     SWITCHIN      In
	bsf	TRISA,4,BANKED
;Dir     RSTBUTTON     In  // this is set automatically - and, you cannot set as an output
	bsf	TRISE,3,BANKED
;! Specify explicit OCULAR_OM1614 support!!
;Setup LCD Parameters
;Define LCD Hardware settings
;! Required for OCULAR LCD driver
;Define I2C settings
;HI2CMode (Master)
	movlw	12
	movwf	HI2CCURRENTMODE,ACCESS
	banksel	0
	call	HI2CMODE
;I2C Controls specific to 18FxxQ2x and Q35 chips
;! Optional the default is 128
;! Optional the default is to issue a warning
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;analogue port selection
;*******************************************************************************************
;Dim radius,xcentre,ycentre,xend,old_xend,yend,old_yend As Byte
;Dim angle,old_angle,adcval As Word
;Dim volts As String * 4
;xcentre=63
	movlw	63
	banksel	XCENTRE
	movwf	XCENTRE,BANKED
;ycentre=58
	movlw	58
	movwf	YCENTRE,BANKED
;radius=120
	movlw	120
	movwf	RADIUS,BANKED
;angle=1
	movlw	1
	movwf	ANGLE,ACCESS
	clrf	ANGLE_H,ACCESS
;anglecheck
	banksel	0
	rcall	ANGLECHECK
;Do
SysDoLoop_S1
;old_angle=angle
	movff	ANGLE,OLD_ANGLE
	movff	ANGLE_H,OLD_ANGLE_H
;--- DVM
;adcval=ReadAD10(ADCChannelSelected)
	clrf	ADREADPORT,ACCESS
	call	FN_READAD1083
	movff	SYSREADAD10WORD,ADCVAL
	movff	SYSREADAD10WORD_H,ADCVAL_H
;Calicabrate to 4.08V
;adcval = scale( adcval, 0, 1023, 0, 255 )
	movff	ADCVAL,L_MAP
	movff	ADCVAL_H,L_MAP_H
	banksel	L_FROMLOW
	clrf	L_FROMLOW,BANKED
	clrf	L_FROMLOW_H,BANKED
	setf	L_FROMHIGH,BANKED
	movlw	3
	movwf	L_FROMHIGH_H,BANKED
	clrf	L_TOLOW,BANKED
	clrf	L_TOLOW_H,BANKED
	setf	L_TOHIGH,BANKED
	clrf	L_TOHIGH_H,BANKED
	clrf	L_CALIBRATE,BANKED
	clrf	L_CALIBRATE_H,BANKED
	banksel	0
	call	FN_SCALE154
	movff	SYSSCALEWORD,ADCVAL
	movff	SYSSCALEWORD_H,ADCVAL_H
;angle=adcval/2
	movff	ADCVAL,SysWORDTempA
	movff	ADCVAL_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempA,ANGLE
	movff	SysWORDTempA_H,ANGLE_H
;
;adcval=adcval*100
	movff	ADCVAL,SysWORDTempA
	movff	ADCVAL_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSMULTSUB16
	movff	SysWORDTempX,ADCVAL
	movff	SysWORDTempX_H,ADCVAL_H
;adcval=adcval/51
	movff	ADCVAL,SysWORDTempA
	movff	ADCVAL_H,SysWORDTempA_H
	movlw	51
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempA,ADCVAL
	movff	SysWORDTempA_H,ADCVAL_H
;volts=Str(adcval)
	movff	ADCVAL,SYSVALTEMP
	movff	ADCVAL_H,SYSVALTEMP_H
	call	FN_STR
	lfsr	1,VOLTS
	lfsr	0,STR
	call	SYSCOPYSTRING
;If adcval<10 Then
	movff	ADCVAL,SysWORDTempA
	movff	ADCVAL_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF1
;volts="0.0"+Left(volts,1,1)
	movlw	low VOLTS
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high VOLTS
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	1
	movwf	SYSCHARCOUNT,BANKED
	banksel	0
	call	FN_LEFT
	lfsr	1,VOLTS
	clrf	SysStringLength,ACCESS
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,LEFT
	call	SYSCOPYSTRINGPART
	lfsr	0,VOLTS
	movff	SysStringLength, INDF0
;Goto volt_format_done
	bra	VOLT_FORMAT_DONE
;End If
ENDIF1
;If adcval<100 Then
	movff	ADCVAL,SysWORDTempA
	movff	ADCVAL_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE2_1
;volts="0."+Mid(volts,1,2)
	movlw	low VOLTS
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high VOLTS
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	1
	movwf	SYSCHARSTART,BANKED
	movlw	2
	movwf	SYSCHARCOUNT,BANKED
	banksel	0
	call	FN_MID
	lfsr	1,VOLTS
	clrf	SysStringLength,ACCESS
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,MID
	call	SYSCOPYSTRINGPART
	lfsr	0,VOLTS
	movff	SysStringLength, INDF0
;Else
	bra	ENDIF2
ELSE2_1
;volts=Left(volts,1,1)+"."+Mid(volts,2,2)
	movlw	low VOLTS
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high VOLTS
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	1
	movwf	SYSCHARCOUNT,BANKED
	banksel	0
	call	FN_LEFT
	movlw	low VOLTS
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high VOLTS
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	2
	movwf	SYSCHARSTART,BANKED
	movlw	2
	movwf	SYSCHARCOUNT,BANKED
	banksel	0
	call	FN_MID
	lfsr	1,VOLTS
	clrf	SysStringLength,ACCESS
	lfsr	0,LEFT
	call	SYSCOPYSTRINGPART
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,MID
	call	SYSCOPYSTRINGPART
	lfsr	0,VOLTS
	movff	SysStringLength, INDF0
;End If
ENDIF2
VOLT_FORMAT_DONE
;---
;anglecheck
	rcall	ANGLECHECK
;old_xend = xcentre + radius  * sin (old_angle)/255
	movff	OLD_ANGLE,TRIG_ARG2
	movff	OLD_ANGLE_H,TRIG_ARG2_H
	call	FN_SIN
	movff	RADIUS,SysINTEGERTempA
	clrf	SysINTEGERTempA_H,ACCESS
	movff	SIN,SysINTEGERTempB
	movff	SIN_H,SysINTEGERTempB_H
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,SysTemp1
	movff	SysINTEGERTempX_H,SysTemp1_H
	movff	SysTemp1,SysINTEGERTempA
	movff	SysTemp1_H,SysINTEGERTempA_H
	setf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSDIVSUBINT
	movf	SysINTEGERTempA,W,ACCESS
	banksel	XCENTRE
	addwf	XCENTRE,W,BANKED
	movwf	OLD_XEND,BANKED
;old_yend = ycentre - radius  * cos (old_angle)/255
	movff	OLD_ANGLE,TRIG_ARG2
	movff	OLD_ANGLE_H,TRIG_ARG2_H
	banksel	0
	rcall	FN_COS
	movff	RADIUS,SysINTEGERTempA
	clrf	SysINTEGERTempA_H,ACCESS
	movff	COS,SysINTEGERTempB
	movff	COS_H,SysINTEGERTempB_H
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,SysTemp1
	movff	SysINTEGERTempX_H,SysTemp1_H
	movff	SysTemp1,SysINTEGERTempA
	movff	SysTemp1_H,SysINTEGERTempA_H
	setf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSDIVSUBINT
	movf	SysINTEGERTempA,W,ACCESS
	banksel	YCENTRE
	subwf	YCENTRE,W,BANKED
	movwf	OLD_YEND,BANKED
;xend = xcentre + radius  * sin (angle)/255
	movff	ANGLE,TRIG_ARG2
	movff	ANGLE_H,TRIG_ARG2_H
	banksel	0
	call	FN_SIN
	movff	RADIUS,SysINTEGERTempA
	clrf	SysINTEGERTempA_H,ACCESS
	movff	SIN,SysINTEGERTempB
	movff	SIN_H,SysINTEGERTempB_H
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,SysTemp1
	movff	SysINTEGERTempX_H,SysTemp1_H
	movff	SysTemp1,SysINTEGERTempA
	movff	SysTemp1_H,SysINTEGERTempA_H
	setf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSDIVSUBINT
	movf	SysINTEGERTempA,W,ACCESS
	banksel	XCENTRE
	addwf	XCENTRE,W,BANKED
	movwf	XEND,BANKED
;yend = ycentre - radius  * cos (angle)/255
	movff	ANGLE,TRIG_ARG2
	movff	ANGLE_H,TRIG_ARG2_H
	banksel	0
	rcall	FN_COS
	movff	RADIUS,SysINTEGERTempA
	clrf	SysINTEGERTempA_H,ACCESS
	movff	COS,SysINTEGERTempB
	movff	COS_H,SysINTEGERTempB_H
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,SysTemp1
	movff	SysINTEGERTempX_H,SysTemp1_H
	movff	SysTemp1,SysINTEGERTempA
	movff	SysTemp1_H,SysINTEGERTempA_H
	setf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSDIVSUBINT
	movf	SysINTEGERTempA,W,ACCESS
	banksel	YCENTRE
	subwf	YCENTRE,W,BANKED
	movwf	YEND,BANKED
;If old_angle<>angle Then
	movff	OLD_ANGLE,SysWORDTempA
	movff	OLD_ANGLE_H,SysWORDTempA_H
	movff	ANGLE,SysWORDTempB
	movff	ANGLE_H,SysWORDTempB_H
	banksel	0
	call	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF3
;-- update screen if volts has changed
;erase old needle
;Box 0,0,127,63
	clrf	LINEX1,ACCESS
	clrf	LINEX1_H,ACCESS
	clrf	LINEY1,ACCESS
	clrf	LINEY1_H,ACCESS
	movlw	127
	movwf	LINEX2,ACCESS
	clrf	LINEX2_H,ACCESS
	movlw	63
	movwf	LINEY2,ACCESS
	clrf	LINEY2_H,ACCESS
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	BOX20
;GLCDDrawChar (5,40,Asc("0")):GLCDDrawChar (115,40,Asc("5"))
	movlw	5
	movwf	CHARLOCX,ACCESS
	clrf	CHARLOCX_H,ACCESS
	movlw	40
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSYSINSTRINGAHANDLER
	movwf	SysSYSINSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRINGAHandler_H,BANKED
	movlw	1
	movwf	SYSCHAR,BANKED
;Using SYSSTRINGPARAM1*1
	banksel	0
	rcall	FN_ASC
	movff	ASC,CHARCODE
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	GLCDDRAWCHAR_SSD1306
;GLCDDrawChar (5,40,Asc("0")):GLCDDrawChar (115,40,Asc("5"))
	movlw	115
	movwf	CHARLOCX,ACCESS
	clrf	CHARLOCX_H,ACCESS
	movlw	40
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSYSINSTRINGAHANDLER
	movwf	SysSYSINSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRINGAHandler_H,BANKED
	movlw	1
	movwf	SYSCHAR,BANKED
;Using SYSSTRINGPARAM1*1
	banksel	0
	rcall	FN_ASC
	movff	ASC,CHARCODE
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	GLCDDRAWCHAR_SSD1306
;Line (xcentre,ycentre,old_xend,old_yend,0)
	movff	XCENTRE,LINEX1
	clrf	LINEX1_H,ACCESS
	movff	YCENTRE,LINEY1
	clrf	LINEY1_H,ACCESS
	movff	OLD_XEND,LINEX2
	clrf	LINEX2_H,ACCESS
	movff	OLD_YEND,LINEY2
	clrf	LINEY2_H,ACCESS
	clrf	LINECOLOUR,ACCESS
	clrf	LINECOLOUR_H,ACCESS
	call	_LINE78
;draw V
;Line (55,22,63,38):Line (63,38,71,22)
	movlw	55
	movwf	LINEX1,ACCESS
	clrf	LINEX1_H,ACCESS
	movlw	22
	movwf	LINEY1,ACCESS
	clrf	LINEY1_H,ACCESS
	movlw	63
	movwf	LINEX2,ACCESS
	clrf	LINEX2_H,ACCESS
	movlw	38
	movwf	LINEY2,ACCESS
	clrf	LINEY2_H,ACCESS
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	_LINE78
;Line (55,22,63,38):Line (63,38,71,22)
	movlw	63
	movwf	LINEX1,ACCESS
	clrf	LINEX1_H,ACCESS
	movlw	38
	movwf	LINEY1,ACCESS
	clrf	LINEY1_H,ACCESS
	movlw	71
	movwf	LINEX2,ACCESS
	clrf	LINEX2_H,ACCESS
	movlw	22
	movwf	LINEY2,ACCESS
	clrf	LINEY2_H,ACCESS
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	_LINE78
;print new voltage
;print Voltage
;GLCDPrint (50,10,volts,1)
	movlw	50
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	10
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movlw	low VOLTS
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high VOLTS
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	LINECOLOUR,ACCESS
	clrf	LINECOLOUR_H,ACCESS
	banksel	0
	call	GLCDPRINT9
;draw new needle
;Line (xcentre,ycentre,xend,yend,1)
	movff	XCENTRE,LINEX1
	clrf	LINEX1_H,ACCESS
	movff	YCENTRE,LINEY1
	clrf	LINEY1_H,ACCESS
	movff	XEND,LINEX2
	clrf	LINEX2_H,ACCESS
	movff	YEND,LINEY2
	clrf	LINEY2_H,ACCESS
	movlw	1
	movwf	LINECOLOUR,ACCESS
	clrf	LINECOLOUR_H,ACCESS
	call	_LINE78
;Wait 20 ms
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;End If
ENDIF3
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;end main
;
;
;GLCD SSD1306 buffer is 1024bytes
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: 220_i2c_glcd_voltmeter_using_ssd1306.gcb (238)
ANGLECHECK
;If angle>127 Then
	movff	ANGLE,SysWORDTempB
	movff	ANGLE_H,SysWORDTempB_H
	movlw	127
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE4_1
;angle =angle-127
	movlw	127
	subwf	ANGLE,F,ACCESS
	movlw	0
	subwfb	ANGLE_H,F,ACCESS
;Else
	bra	ENDIF4
ELSE4_1
;angle =296+angle
	movlw	40
	addwf	ANGLE,F,ACCESS
	movlw	1
	addwfc	ANGLE_H,F,ACCESS
;End If
ENDIF4
	return

;********************************************************************************

;Source: string.h (1174)
FN_ASC
;Asc = 0
	clrf	ASC,ACCESS
;Get length of string, don't try _asc ing if it's empty
;SysCharCount = SysInStringA(0)
	movff	SysSYSINSTRINGAHandler,AFSR0
	movff	SysSYSINSTRINGAHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;If SysCharCount = 0 Then Exit Function
	banksel	SYSCHARCOUNT
	movf	SYSCHARCOUNT,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF53
;If SysCharCount = 0 Then Exit Function
	banksel	0
	return
;If SysCharCount = 0 Then Exit Function
ENDIF53
;if Syschar > SysCharCount Then Exit Function
	movf	SYSCHAR,W,BANKED
	subwf	SYSCHARCOUNT,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF54
;if Syschar > SysCharCount Then Exit Function
	banksel	0
	return
;if Syschar > SysCharCount Then Exit Function
ENDIF54
;Get first char of string, only first character is of interest, Syschar if provided
;Asc = SysInStringA( Syschar )
	movf	SYSCHAR,W,BANKED
	addwf	SysSYSINSTRINGAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ASC
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (1798)
BOX20
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF8
;GLCDTemp = LineX1
	movff	LINEX1,GLCDTEMP
	movff	LINEX1_H,GLCDTEMP_H
;LineX1 = LineX2
	movff	LINEX2,LINEX1
	movff	LINEX2_H,LINEX1_H
;LineX2 = GLCDTemp
	movff	GLCDTEMP,LINEX2
	movff	GLCDTEMP_H,LINEX2_H
;End If
ENDIF8
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF9
;GLCDTemp = LineY1
	movff	LINEY1,GLCDTEMP
	movff	LINEY1_H,GLCDTEMP_H
;LineY1 = LineY2
	movff	LINEY2,LINEY1
	movff	LINEY2_H,LINEY1_H
;LineY2 = GLCDTemp
	movff	GLCDTEMP,LINEY2
	movff	GLCDTEMP_H,LINEY2_H
;End If
ENDIF9
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
;Legacy method
	movlw	1
	subwf	LINEX1,W,ACCESS
	movwf	DRAWLINE,ACCESS
	movlw	0
	subwfb	LINEX1_H,W,ACCESS
	movwf	DRAWLINE_H,ACCESS
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd2
SysForLoop2
	incf	DRAWLINE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,ACCESS
;PSet DrawLine, LineY1, LineColour
	movff	DRAWLINE,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_SSD1306
;PSet DrawLine, LineY2, LineColour
	movff	DRAWLINE,GLCDX
	movff	LINEY2,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_SSD1306
;Next
	movff	DRAWLINE,SysWORDTempA
	movff	DRAWLINE_H,SysWORDTempA_H
	movff	LINEX2,SysWORDTempB
	movff	LINEX2_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;Draw lines going down
;For DrawLine = LineY1 To LineY2
;Legacy method
	movlw	1
	subwf	LINEY1,W,ACCESS
	movwf	DRAWLINE,ACCESS
	movlw	0
	subwfb	LINEY1_H,W,ACCESS
	movwf	DRAWLINE_H,ACCESS
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd3
SysForLoop3
	incf	DRAWLINE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,ACCESS
;PSet LineX1, DrawLine, LineColour
	movff	LINEX1,GLCDX
	movff	DRAWLINE,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_SSD1306
;PSet LineX2, DrawLine, LineColour
	movff	LINEX2,GLCDX
	movff	DRAWLINE,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_SSD1306
;Next
	movff	DRAWLINE,SysWORDTempA
	movff	DRAWLINE_H,SysWORDTempA_H
	movff	LINEY2,SysWORDTempB
	movff	LINEY2_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
	return

;********************************************************************************

;Source: trig2places.h (74)
FN_COS
;return cosine of angle
;if trig_arg2 < 0 then               ;cosine is an even function,
	movff	TRIG_ARG2,SysINTEGERTempA
	movff	TRIG_ARG2_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF16
;trig_arg2 = -1 * trig_arg2        ;so negate negative angle
	movff	TRIG_ARG2,SysINTEGERTempA
	movff	TRIG_ARG2_H,SysINTEGERTempA_H
	setf	SysINTEGERTempB,ACCESS
	setf	SysINTEGERTempB_H,ACCESS
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,TRIG_ARG2
	movff	SysINTEGERTempX_H,TRIG_ARG2_H
;end if
ENDIF16
;trig_arg2 = trig_arg2 mod 360       ;reduce to 0 to 359 degrees
	movff	TRIG_ARG2,SysINTEGERTempA
	movff	TRIG_ARG2_H,SysINTEGERTempA_H
	movlw	104
	movwf	SysINTEGERTempB,ACCESS
	movlw	1
	movwf	SysINTEGERTempB_H,ACCESS
	call	SYSDIVSUBINT
	movff	SysINTEGERTempX,TRIG_ARG2
	movff	SysINTEGERTempX_H,TRIG_ARG2_H
;trig_sign = 1                       ;assume result is positive
	movlw	1
	banksel	TRIG_SIGN
	movwf	TRIG_SIGN,BANKED
	clrf	TRIG_SIGN_H,BANKED
;if trig_arg2>90 and trig_arg2<270 then
	movff	TRIG_ARG2,SysINTEGERTempB
	movff	TRIG_ARG2_H,SysINTEGERTempB_H
	movlw	90
	movwf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	banksel	0
	call	SYSCOMPLESSTHANINT
	movff	SysByteTempX,SysTemp1
	movff	TRIG_ARG2,SysINTEGERTempA
	movff	TRIG_ARG2_H,SysINTEGERTempA_H
	movlw	14
	movwf	SysINTEGERTempB,ACCESS
	movlw	1
	movwf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPLESSTHANINT
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF17
;trig_sign = -1                    ;but negative in II and III
	setf	TRIG_SIGN,BANKED
	setf	TRIG_SIGN_H,BANKED
;end if
ENDIF17
;trig_arg2 = trig_ref(trig_arg2)     ;get the trig_reference angle
	movff	TRIG_ARG2,TRIG_ARG1
	movff	TRIG_ARG2_H,TRIG_ARG1_H
	banksel	0
	call	FN_TRIG_REF
	movff	TRIG_REF,TRIG_ARG2
	movff	TRIG_REF_H,TRIG_ARG2_H
;trig_arg2 = [integer]90 - trig_arg2 ;use cofunction identity
	banksel	TRIG_ARG2
	movf	TRIG_ARG2,W,BANKED
	sublw	90
	movwf	TRIG_ARG2,BANKED
	clrf	SysTemp1,BANKED
	movf	TRIG_ARG2_H,W,BANKED
	subwfb	SysTemp1,W,BANKED
	movwf	TRIG_ARG2_H,BANKED
;trig_i = [byte]trig_arg2+1          ;index into the table
	incf	TRIG_ARG2,W,BANKED
	movwf	TRIG_I,BANKED
;readTable sineTab, trig_i, trig_val
	movff	TRIG_I,SYSSTRINGA
	banksel	0
	call	SINETAB
	banksel	TRIG_VAL
	movwf	TRIG_VAL,BANKED
	clrf	TRIG_VAL_H,BANKED
;cos = trig_sign * [integer]trig_val  ;create final result
	movff	TRIG_SIGN,SysINTEGERTempA
	movff	TRIG_SIGN_H,SysINTEGERTempA_H
	movff	TRIG_VAL,SysINTEGERTempB
	movff	TRIG_VAL_H,SysINTEGERTempB_H
	banksel	0
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,COS
	movff	SysINTEGERTempX_H,COS_H
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (1085)
CURSOR_POSITION_SSD1306
;dim  PosCharX, PosCharX as Word
;PosCharY = LocY / 8
;faster than /8
;PosCharY = LocY
	movff	LOCY,POSCHARY
;Repeat 3
	movlw	3
	banksel	SYSREPEATTEMP4
	movwf	SysRepeatTemp4,BANKED
SysRepeatLoop4
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate PosCharY Right
	rrcf	POSCHARY,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp4,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
;Write_Command_SSD1306( 0xB0 + PosCharY )   ' set page address
	movlw	176
	addwf	POSCHARY,W,BANKED
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;PosCharX = ( LocX  & 0x0f )  ' lower nibble
	movlw	15
	banksel	LOCX
	andwf	LOCX,W,BANKED
	movwf	POSCHARX,BANKED
	clrf	POSCHARX_H,BANKED
;Write_Command_SSD1306( PosCharX )
	movff	POSCHARX,SSD1306SENDBYTE
	banksel	0
	call	WRITE_COMMAND_SSD1306
;PosCharX = LocX
	movff	LOCX,POSCHARX
	banksel	POSCHARX_H
	clrf	POSCHARX_H,BANKED
;Repeat 4
	movlw	4
	movwf	SysRepeatTemp4,BANKED
SysRepeatLoop5
;Set C off
	bcf	STATUS,C,ACCESS
;Rotate PosCharX Right
	rrcf	POSCHARX_H,F,BANKED
	rrcf	POSCHARX,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp4,F,BANKED
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
;PosCharX = ( PosCharX & 0x0F ) + 0x10
	movlw	15
	andwf	POSCHARX,W,BANKED
	movwf	SysTemp1,BANKED
	clrf	SysTemp1_H,BANKED
	movlw	16
	addwf	SysTemp1,W,BANKED
	movwf	POSCHARX,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	POSCHARX_H,BANKED
;Write_Command_SSD1306 ( PosCharX )
	movff	POSCHARX,SSD1306SENDBYTE
	banksel	0
	goto	WRITE_COMMAND_SSD1306

;********************************************************************************

Delay_10US
D10US_START
	movlw	52
	movwf	DELAYTEMP,ACCESS
DelayUS0
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	decfsz	SysWaitTemp10US, F,ACCESS
	bra	D10US_START
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

GLCDCHARCOL3
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL3
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL3
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL3
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL3
	db	112,0,16,12,10,136,34,56,32,8,32,16,16,128,128,64,4,0,0,0,40,72,70,108,0,0,0,40
	db	16,0,16,0,64,124,0,132,130,48,78,120,6,108,12,0,0,16,40,0,4,100,248,254,124,254
	db	254,254,124,254,0,64,254,254,254,254,124,254,124,254,76,2,126,62,126,198,14,194
	db	0,4,0,8,128,0,64,254,112,112,112,16,16,254,0,64,254,0,248,248,112,248,16,248
	db	144,16,120,56,120,136,24,136,0,0,0,32,120

;********************************************************************************

GLCDCHARCOL4
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL4
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL4
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL4
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL4
	db	112,254,56,10,6,204,102,124,112,4,64,16,56,136,162,112,28,0,0,14,254,84,38,146
	db	10,56,130,16,16,160,16,192,32,162,132,194,130,40,138,148,2,146,146,108,172,40
	db	40,130,2,146,36,146,130,130,146,18,130,16,130,128,16,128,4,8,130,18,130,18,146,2
	db	128,64,128,40,16,162,254,8,130,4,128,2,168,144,136,136,168,252,168,16,144,128
	db	32,130,8,16,136,40,40,16,168,124,128,64,128,80,160,200,16,0,130,16,68

;********************************************************************************

GLCDCHARCOL5
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL5
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL5
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL5
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL5
	db	112,124,124,0,0,238,238,124,168,254,254,84,84,148,148,124,124,0,158,0,40,254,16,170
	db	6,68,68,124,124,96,16,192,16,146,254,162,138,36,138,146,226,146,146,108,108,68
	db	40,68,162,242,34,146,130,130,146,18,146,16,254,130,40,128,24,16,130,18,162,50
	db	146,254,128,128,112,16,224,146,130,16,130,2,128,4,168,136,136,136,168,18,168,8
	db	250,136,80,254,240,8,136,40,40,8,168,144,128,128,96,32,160,168,108,254,108,16
	db	66

;********************************************************************************

GLCDCHARCOL6
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL6
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL6
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL6
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL6
	db	112,56,254,12,10,204,102,124,32,4,64,56,16,162,136,112,28,0,0,14,254,84,200,68
	db	0,130,56,16,16,0,16,0,8,138,128,146,150,254,138,146,18,146,82,0,0,130,40,40,18,130
	db	36,146,130,68,146,18,146,16,130,126,68,128,4,32,130,18,66,82,146,2,128,64,128,40
	db	16,138,130,32,254,4,128,8,168,136,136,144,168,2,168,8,128,122,136,128,8,8,136,40
	db	48,8,168,128,64,64,128,80,160,152,130,0,16,32,68

;********************************************************************************

GLCDCHARCOL7
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL7
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL7
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL7
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL7
	db	112,16,0,10,6,136,34,56,62,8,32,16,16,128,128,64,4,0,0,0,40,36,196,160,0,0,0,40
	db	16,0,16,0,4,124,0,140,98,32,114,96,14,108,60,0,0,0,40,16,12,124,248,108,68,56
	db	130,2,244,254,0,2,130,128,254,254,124,12,188,140,100,2,126,62,126,198,14,134,0,64
	db	0,8,128,0,240,112,64,254,48,4,120,240,0,0,0,0,240,240,112,16,248,16,64,64,248,56
	db	120,136,120,136,0,0,0,16,120

;********************************************************************************

;Source: GLCD_SSD1306.H (464)
GLCDCLS_SSD1306
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,ACCESS
	clrf	GLCD_YORDINATE_H,ACCESS
;For SSD1306_BufferLocationCalc = 1 to GLCD_HEIGHT * GLCD_WIDTH / 8
;Legacy method
	banksel	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC,BANKED
	clrf	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SysForLoop10
	banksel	SSD1306_BUFFERLOCATIONCALC
	incf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	lfsr	0,SSD1306_BUFFERALIAS
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	clrf	INDF0,ACCESS
;Next
	movff	SSD1306_BUFFERLOCATIONCALC,SysWORDTempA
	movff	SSD1306_BUFFERLOCATIONCALC_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	movlw	4
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	banksel	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC,BANKED
	clrf	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SysForLoop11
;Init SysForLoopStep10 :#0
	movlw	8
	movwf	SysForLoopStep10,BANKED
	clrf	SysForLoopStep10_H,BANKED
;Cursor_Position_SSD1306 ( 0 , SSD1306_BufferLocationCalc )
	clrf	LOCX,BANKED
	movff	SSD1306_BUFFERLOCATIONCALC,LOCY
	banksel	0
	rcall	CURSOR_POSITION_SSD1306
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1272)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	call	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24Q35SEND
;HI2CSend 0x40
	movlw	64
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24Q35SEND
;For GLCDTemp = 0 to 127
;Legacy method
	setf	GLCDTEMP,ACCESS
SysForLoop12
	incf	GLCDTEMP,F,ACCESS
;Write_Transaction_Data_SSD1306(GLCDBackground)
;Macro Source: GLCD_SSD1306.H (1303)
;HI2CSend SSD1306SendByte
	movff	GLCDBACKGROUND,I2CBYTE
	rcall	HI2CQ24Q35SEND
;Next
	movlw	127
	subwf	GLCDTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop12
SysForLoopEnd12
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1336)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	rcall	HI2CQ24Q35STOP
;Next
;Integer negative Step Handler in For-next statement
	banksel	SYSFORLOOPSTEP10_H
	btfss	SYSFORLOOPSTEP10_H,7,BANKED
	bra	ELSE78_1
;Set SysForLoopABsValue to -StepValue :#1 
	comf	SYSFORLOOPSTEP10,W,BANKED
	movwf	SysForLoopABsValue11,BANKED
	comf	SYSFORLOOPSTEP10_H,W,BANKED
	movwf	SysForLoopABsValue11_H,BANKED
	incf	SysForLoopABsValue11,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SysForLoopABsValue11_H,F,BANKED
;IF ( SSD1306_BUFFERLOCATIONCALC - 64-1) } [WORD]SysForLoopABsValue11 THEN  :#1n 
	movlw	64
	subwf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	subwfb	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movff	SYSFORLOOPABSVALUE11,SysWORDTempB
	movff	SYSFORLOOPABSVALUE11_H,SysWORDTempB_H
	banksel	0
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF79
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	banksel	SYSFORLOOPSTEP10
	movf	SysForLoopStep10,W,BANKED
	addwf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	movf	SysForLoopStep10_H,W,BANKED
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
	bra	SysForLoop11
;END IF
ENDIF79
	bra	ENDIF78
ELSE78_1
;Integer positive Step Handler in For-next statement
;IF ([WORD]64-1 - [WORD]SSD1306_BUFFERLOCATIONCALC) } [WORD]SysForLoopStep10 THEN :#1p 
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	sublw	63
	movwf	SysTemp1,BANKED
	clrf	SysTemp2,BANKED
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	subwfb	SysTemp2,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movff	SYSFORLOOPSTEP10,SysWORDTempB
	movff	SYSFORLOOPSTEP10_H,SysWORDTempB_H
	banksel	0
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF80
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	banksel	SYSFORLOOPSTEP10
	movf	SysForLoopStep10,W,BANKED
	addwf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	movf	SysForLoopStep10_H,W,BANKED
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
	bra	SysForLoop11
;END IF
ENDIF80
;END IF
ENDIF78
SysForLoopEnd11
;Removed at 1.14. Retained for documentation only
;Cursor_Position_SSD1306 ( 0 , 0 )
;for SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
;for GLCDTemp = 0 to 127
;Write_Data_SSD1306(GLCDBackground)
;Next
;next
;Cursor_Position_SSD1306 ( 0 , 0 )
	banksel	LOCX
	clrf	LOCX,BANKED
	clrf	LOCY,BANKED
	banksel	0
	rcall	CURSOR_POSITION_SSD1306
;PrintLocX =0
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
;PrintLocY =0
	clrf	PRINTLOCY,BANKED
	banksel	0
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (512)
GLCDDRAWCHAR_SSD1306
;This is now in four parts
;1. Handler for GLCD LM mode
;2. Preamble
;3. GCB Font set handler
;4. OLED Font set handler
;***** Handler for GLCD LM mode
;****** Preamble
;invert colors if required
;if LineColour <> GLCDForeground  then
	movff	LINECOLOUR,SysWORDTempA
	movff	LINECOLOUR_H,SysWORDTempA_H
	movff	GLCDFOREGROUND,SysWORDTempB
	movff	GLCDFOREGROUND_H,SysWORDTempB_H
	call	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF55
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 0
	clrf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;end if
ENDIF55
;dim CharCol, CharRow as word
;CharCode -= 15
	movlw	15
	subwf	CHARCODE,F,ACCESS
;CharCol=0
	clrf	CHARCOL,ACCESS
	clrf	CHARCOL_H,ACCESS
;Cursor_Position_SSD1306 ( CharLocX , CharLocY )
	movff	CHARLOCX,LOCX
	movff	CHARLOCY,LOCY
	rcall	CURSOR_POSITION_SSD1306
;1.14 Added transaction
;****** GCB Font set handler
;if CharCode>=178 and CharCode<=202 then
	movff	CHARCODE,SysBYTETempA
	movlw	178
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	202
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF56
;CharLocY=CharLocY-1
	movlw	1
	subwf	CHARLOCY,F,ACCESS
	movlw	0
	subwfb	CHARLOCY_H,F,ACCESS
;end if
ENDIF56
;For CurrCharCol = 1 to 5
;Legacy method
	clrf	CURRCHARCOL,ACCESS
SysForLoop6
	incf	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect2Case1
	decf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	GLCDCHARCOL3
	movwf	CURRCHARVAL,ACCESS
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	GLCDCHARCOL4
	movwf	CURRCHARVAL,ACCESS
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	bra	SysSelectEnd2
SysSelect2Case3
	movlw	3
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case4
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	GLCDCHARCOL5
	movwf	CURRCHARVAL,ACCESS
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	bra	SysSelectEnd2
SysSelect2Case4
	movlw	4
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case5
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	GLCDCHARCOL6
	movwf	CURRCHARVAL,ACCESS
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	bra	SysSelectEnd2
SysSelect2Case5
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	GLCDCHARCOL7
	movwf	CURRCHARVAL,ACCESS
;End Select
SysSelectEnd2
;Full Memory GLCD mode
;CharRow=0
	clrf	CHARROW,ACCESS
	clrf	CHARROW_H,ACCESS
;For CurrCharRow = 1 to 8
;Legacy method
	clrf	CURRCHARROW,ACCESS
SysForLoop7
	incf	CURRCHARROW,F,ACCESS
;CharColS=0
	clrf	CHARCOLS,ACCESS
;For Col=1 to GLCDfntDefaultsize
;Legacy method
	clrf	COL,ACCESS
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd8
SysForLoop8
	incf	COL,F,ACCESS
;CharRowS=0
	clrf	CHARROWS,ACCESS
;For Row=1 to GLCDfntDefaultsize
;Legacy method
	banksel	ROW
	clrf	ROW,BANKED
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd9
SysForLoop9
	incf	ROW,F,BANKED
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0,ACCESS
	bra	ELSE59_1
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, LineColour
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	rcall	PSET_SSD1306
;Else
	bra	ENDIF59
ELSE59_1
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, GLCDBackground
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	banksel	0
	rcall	PSET_SSD1306
;End if
ENDIF59
;Put out a white intercharacter pixel/space
;PSet [word]CharLocX + ( GLCDFontWidth * GLCDfntDefaultsize) , [word]CharLocY + CharRow + CharRowS , GLCDBackground
	movf	GLCDFONTWIDTH,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movff	PRODL,SysTemp1
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	banksel	0
	rcall	PSET_SSD1306
;CharRowS +=1
	incf	CHARROWS,F,ACCESS
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	banksel	ROW
	subwf	ROW,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
;CharColS +=1
	incf	CHARCOLS,F,ACCESS
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	subwf	COL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop8
SysForLoopEnd8
;Rotate CurrCharVal Right
	rrcf	CURRCHARVAL,F,ACCESS
;CharRow +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	addwf	CHARROW,F,ACCESS
	movlw	0
	addwfc	CHARROW_H,F,ACCESS
;Next
	movlw	8
	subwf	CURRCHARROW,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
;CharCol +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	addwf	CHARCOL,F,ACCESS
	movlw	0
	addwfc	CHARCOL_H,F,ACCESS
;1.14 Low Memory GLCD mode
;1.12 Character GLCD mode
;Handles specific draw sequence. This caters for write only of a bit value. No read operation.
;Next
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;****** OLED Font set handler
;1.14 Added transaction
;Restore
;GLCDBackground = 0
	clrf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 1
	movlw	1
	movwf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:WORD:, Source: glcd.h (1320)
GLCDPRINT9
;Dim GLCDPrintLoc as word
;GLCDPrintLen = LCDPrintData(0)
	movff	SysLCDPRINTDATAHandler,AFSR0
	movff	SysLCDPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	movf	GLCDPRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
;If GLCDPrintLen = 0 Then Exit Sub
	return
;If GLCDPrintLen = 0 Then Exit Sub
;GLCDPrintLoc = PrintLocX
	movff	PRINTLOCX,GLCDPRINTLOC
	movff	PRINTLOCX_H,GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
;Legacy method
	clrf	GLCDPRINT_STRING_COUNTER,ACCESS
	movlw	1
	subwf	GLCDPRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
	incf	GLCDPRINT_STRING_COUNTER,F,ACCESS
;GLCDDrawChar GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter), LineColour
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movff	PRINTLOCY,CHARLOCY
	movff	PRINTLOCY_H,CHARLOCY_H
	movf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	banksel	SYSLCDPRINTDATAHANDLER
	addwf	SysLCDPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,CHARCODE
	banksel	0
	rcall	GLCDDRAWCHAR_SSD1306
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1528)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	movf	GLCDFONTWIDTH,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movff	PRODL,SysTemp1
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	addwf	GLCDPRINTLOC,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	GLCDPRINTLOC_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	GLCDPRINTLOC,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	GLCDPRINTLOC_H,ACCESS
;Next
	movf	GLCDPRINTLEN,W,ACCESS
	subwf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
	banksel	0
	return

;********************************************************************************

;Source: hwi2c.h (436)
HI2CMODE
;This method sets the variable `HI2CCurrentMode`, and, if required, sets the SSPCON1.bits
	return

;********************************************************************************

;Source: hwi2c.h (1784)
HI2CQ24Q35INIT
;SCL pin
;HI2C_CLOCK = 1
	banksel	LATC
	bsf	LATC,3,BANKED
;DIR HI2C_CLOCK Out
	bcf	TRISC,3,BANKED
;SDA pin
;HI2C_DATA = 1
	bsf	LATC,4,BANKED
;DIR HI2C_DATA Out
	bcf	TRISC,4,BANKED
;Configure the peripheral itself
;I2C1CON0.MODE0=0; // 0b100 => I2C Host mode, 7-bit address
	banksel	I2C1CON0
	bcf	I2C1CON0,MODE0,BANKED
;I2C1CON0.MODE1=0; // 0b100 => I2C Host mode, 7-bit address
	bcf	I2C1CON0,MODE1,BANKED
;I2C1CON0.MODE2=1; // 0b100 => I2C Host mode, 7-bit address
	bsf	I2C1CON0,MODE2,BANKED
;I2C1CON1.ACKCNT=1; // 1 => I2CxCNT == 0 => Not Acknowledge (NACK) copied to SDA output
	bsf	I2C1CON1,ACKCNT,BANKED
;I2C1CON1.ACKDT=0; // 0 => I2CxCNT != 0 => Acknowledge (ACK) copied to SDA output
	bcf	I2C1CON1,ACKDT,BANKED
;I2C1CON3.FME0=0b0; // 0b00 => SCL frequency (FSCL) = FI2CxCLK/5 // Q24 specific
	bcf	I2C1CON3,FME0,BANKED
;I2C1CON3.FME1=0b0; // 0b00 => SCL frequency (FSCL) = FI2CxCLK/5 // Q24 specific
	bcf	I2C1CON3,FME1,BANKED
;I2C1CON2.BFRET0=0b0; // 0b00 => Minimum stop time 8 I2CxCLK pulses
	bcf	I2C1CON2,BFRET0,BANKED
;I2C1CON2.BFRET1=0b0; // 0b00 => Minimum stop time 8 I2CxCLK pulses
	bcf	I2C1CON2,BFRET1,BANKED
;I2C1CON2.ABD=0; // 0 => Address buffers are enabled.
	bcf	I2C1CON2,ABD,BANKED
;I2C1CLK=0b0011; // 0b0011 => MFINTOSC (500kHz): gives 100kHz with FME=0. 125kHz with FME=1
	movlw	3
	movwf	I2C1CLK,BANKED
;I2C1BAUD=0; // 0 => div-by-1. // **** New for Q24 devices
	clrf	I2C1BAUD,BANKED
;I2C1CON0.I2CEN=1;
	bsf	I2C1CON0,I2CEN,BANKED
;This is the workaround as stated in the errata
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
;nop
	nop
;nop
	nop
;nop
	nop
;nop
	nop
;nop
	nop
;nop
	nop
	banksel	0
	return

;********************************************************************************

;Source: hwi2c.h (1744)
HI2CQ24Q35SEND
;Dim HWI2C_Buffer( SCRIPT_HIC2Q2XBUFFERSIZE )
;Dim HWI2C_BufferLocationCounter as Word
;Redirected for Q2x-mode family probalby called HI2CSend
;This is a state Machine to cater for the new approach with the I2C module
;Select Case HI2C1StateMachine
;case 2  'send data
SysSelect3Case1
	movlw	2
	subwf	HI2C1STATEMACHINE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;HWI2C_BufferLocationCounter++
	incf	HWI2C_BUFFERLOCATIONCOUNTER,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	HWI2C_BUFFERLOCATIONCOUNTER_H,F,ACCESS
;HWI2C_Buffer(HWI2C_BufferLocationCounter)=I2Cbyte
	lfsr	0,HWI2C_BUFFER
	movf	HWI2C_BUFFERLOCATIONCOUNTER,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	HWI2C_BUFFERLOCATIONCOUNTER_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movff	I2CBYTE,INDF0
;exit Sub
	return
;case 1  'A start
	bra	SysSelectEnd3
SysSelect3Case2
	decf	HI2C1STATEMACHINE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case3
;HWI2C_BufferLocationCounter = 0
	clrf	HWI2C_BUFFERLOCATIONCOUNTER,ACCESS
	clrf	HWI2C_BUFFERLOCATIONCOUNTER_H,ACCESS
;I2C1ADB1 = I2Cbyte
	movff	I2CBYTE,I2C1ADB1
;HI2C1StateMachine = 2  'Set state Machine to send data
	movlw	2
	movwf	HI2C1STATEMACHINE,ACCESS
;Exit Sub
	return
;case 3  'A restart
	bra	SysSelectEnd3
SysSelect3Case3
	movlw	3
	subwf	HI2C1STATEMACHINE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd3
;HWI2C_BufferLocationCounter = 0
	clrf	HWI2C_BUFFERLOCATIONCOUNTER,ACCESS
	clrf	HWI2C_BUFFERLOCATIONCOUNTER_H,ACCESS
;I2C1ADB1 = I2Cbyte
	movff	I2CBYTE,I2C1ADB1
;HI2C1StateMachine = 2  'Set state Machine to send data
	movlw	2
	movwf	HI2C1STATEMACHINE,ACCESS
;Exit Sub
	return
;end select
SysSelectEnd3
	return

;********************************************************************************

;Source: hwi2c.h (1671)
HI2CQ24Q35STOP
;This routine handles the full transaction.
;1. Enables and loads the key registers
;2. Send IC2START
;3. Send data.. using I2CSEND
;4. Set  HI2CWaitMSSPTimeout and HI2CAckpollState for public use.
;Clear the test bit
;I2C1PIR.7 = 0
	banksel	I2C1PIR
	bcf	I2C1PIR,7,BANKED
;Wait for bus to be available
;HI2CWaitMSSPTimeout = 0
	clrf	HI2CWAITMSSPTIMEOUT,ACCESS
;Do While HI2CWaitMSSPTimeout <> 255
SysDoLoop_S4
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E4
;If I2C1STAT0.BFRE  = 0 Then Exit Do
	btfss	I2C1STAT0,BFRE,BANKED
;If I2C1STAT0.BFRE  = 0 Then Exit Do
	bra	SysDoLoop_E4
;If I2C1STAT0.BFRE  = 0 Then Exit Do
;HI2CWaitMSSPTimeout++
	incf	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Loop
	bra	SysDoLoop_S4
SysDoLoop_E4
;If HI2CWaitMSSPTimeout <> 255 Then
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF82
;Number of bytes excluding address
;I2C1CNTH = HWI2C_BufferLocationCounter_H
	movff	HWI2C_BUFFERLOCATIONCOUNTER_H,I2C1CNTH
;I2C1CNT = HWI2C_BufferLocationCounter
	movff	HWI2C_BUFFERLOCATIONCOUNTER,I2C1CNT
;I2C1CON0.I2CEN=0
	bcf	I2C1CON0,I2CEN,BANKED
;Start I2C this prevent lock ups
;I2C1CON0.I2CEN=1
	bsf	I2C1CON0,I2CEN,BANKED
;Start
;I2C1CON0.S = 1
	bsf	I2C1CON0,S,BANKED
;Do while I2C1CON0.S = 1
SysDoLoop_S5
	btfss	I2C1CON0,S,BANKED
	bra	SysDoLoop_E5
;Wait for start
;NOP
	nop
;Loop
	bra	SysDoLoop_S5
SysDoLoop_E5
;Dim HWI2C_BufferLocationCounterIndex as Word
;For HWI2C_BufferLocationCounterIndex = 1 to HWI2C_BufferLocationCounter
;Legacy method
	clrf	HWI2C_BUFFERLOCATIONCOUNTERINDEX,ACCESS
	clrf	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,ACCESS
	movlw	1
	subwf	HWI2C_BUFFERLOCATIONCOUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd13
SysForLoop13
	incf	HWI2C_BUFFERLOCATIONCOUNTERINDEX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,F,ACCESS
;HI2CWaitMSSPTimeout = 0
	clrf	HI2CWAITMSSPTIMEOUT,ACCESS
;Send/Clock data out
;I2C1TXB = HWI2C_Buffer ( HWI2C_BufferLocationCounterIndex )
	lfsr	0,HWI2C_BUFFER
	movf	HWI2C_BUFFERLOCATIONCOUNTERINDEX,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,I2C1TXB
;Do while I2C1STAT1.TXBE = 0
SysDoLoop_S6
	banksel	I2C1STAT1
	btfsc	I2C1STAT1,TXBE,BANKED
	bra	SysDoLoop_E6
;Wait for Transmit Buffer to Empty
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
;HI2CWaitMSSPTimeout++
	incf	HI2CWAITMSSPTIMEOUT,F,ACCESS
;If HI2CWaitMSSPTimeout = 255 Then
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;Transmission failure, exit.
;Goto HI2CQ24Q35StopExit
	bra	HI2CQ24Q35STOPEXIT
;End If
;Loop
	bra	SysDoLoop_S6
SysDoLoop_E6
;Next
	movff	HWI2C_BUFFERLOCATIONCOUNTERINDEX,SysWORDTempA
	movff	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,SysWORDTempA_H
	movff	HWI2C_BUFFERLOCATIONCOUNTER,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop13
SysForLoopEnd13
;Wait for a stop bit to complete
;Do while I2C1STAT0.MMA = 1 and HI2CWaitMSSPTimeout <> 255
SysDoLoop_S7
	clrf	SysByteTempX,ACCESS
	banksel	I2C1STAT0
	btfsc	i2c1stat0,mma,BANKED
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp3
	movff	hi2cwaitmssptimeout,SysBYTETempA
	setf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	SysDoLoop_E7
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS3
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS3
;Loop
	bra	SysDoLoop_S7
SysDoLoop_E7
;End If
ENDIF82
HI2CQ24Q35STOPEXIT
;If I2C1PIR.7 = 1 then
	banksel	I2C1PIR
	btfss	I2C1PIR,7,BANKED
	bra	ELSE83_1
;HI2CAckpollState = False
	clrf	HI2CACKPOLLSTATE,ACCESS
;Else
	bra	ENDIF83
ELSE83_1
;HI2CAckpollState = True
	setf	HI2CACKPOLLSTATE,ACCESS
;End If
ENDIF83
;I2C1CON0.I2CEN=0
	bcf	I2C1CON0,I2CEN,BANKED
	banksel	0
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (349)
INITGLCD_SSD1306
;Colours //Set these first
;GLCDBackground = 0
	clrf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 1
	movlw	1
	movwf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;GLCDFontWidth = 5
	movlw	5
	movwf	GLCDFONTWIDTH,ACCESS
;GLCDfntDefaultHeight = 7  'used by GLCDPrintString and GLCDPrintStringLn
	movlw	7
	movwf	GLCDFNTDEFAULTHEIGHT,ACCESS
;dim PrintLocX, PrintLocY as word
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT,ACCESS
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;wait 255 ms             'added to ensure the charge pump and power is operational.
	setf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;HI2CMode Master
	movlw	12
	movwf	HI2CCURRENTMODE,ACCESS
	rcall	HI2CMODE
;Wait 15 ms  'wait for power-up and reset
	movlw	15
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Setup code for SSD1306 controllers
;Init sequence for 128x64 OLED module
;Write_Command_SSD1306(SSD1306_DISPLAYOFF)                    ' 0xAE
	movlw	174
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DEACTIVATE_SCROLL)
	movlw	46
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYCLOCKDIV)            ' 0xD5
	movlw	213
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x80)                                  ' the suggested ratio 0x80
	movlw	128
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETMULTIPLEX)                  ' 0xA8
	movlw	168
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x3f)                                 '64 pixels
	movlw	63
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYOFFSET)              ' 0xD3
	movlw	211
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x00)                                   ' no offset
	banksel	SSD1306SENDBYTE
	clrf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETSTARTLINE | 0x00)            ' line #0
	movlw	64
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_CHARGEPUMP)                    ' 0x8D
	movlw	141
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;if (SSD1306_vccstate = SSD1306_EXTERNALVCC) then
;Write_Command_SSD1306(0x14)
	movlw	20
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_MEMORYMODE)                    ' 0x20
	movlw	32
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x10)                                  ' 0x01 act like PCD8544
	movlw	16
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SEGREMAP | 0x1)
	movlw	161
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_COMSCANDEC)
	movlw	200
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCOMPINS)                    ' 0xDA
	movlw	218
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x12)                                 '64 pixels
	movlw	18
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCONTRAST)                   ' 0x81
	movlw	129
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xCF)
	movlw	207
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETPRECHARGE)                  ' 0xd9
	movlw	217
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xF1)
	movlw	241
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETVCOMDETECT)                 ' 0xDB
	movlw	219
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x40)
	movlw	64
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYALLON_RESUME)           ' 0xA4
	movlw	164
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_NORMALDISPLAY)                 ' 0xA6
	movlw	166
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	call	WRITE_COMMAND_SSD1306
;Clear screen Here
;GLCDCLS_SSD1306
	rcall	GLCDCLS_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYON)                     '--turn on oled panel
	movlw	175
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	goto	WRITE_COMMAND_SSD1306

;********************************************************************************

;Source: 220_i2c_glcd_voltmeter_using_ssd1306.gcb (29)
INITPPS
;Module: UART pin directions
;Dir PORTC.6 Out    ' Make TX1 pin an output
	banksel	TRISC
	bcf	TRISC,6,BANKED
;Module: UART1
;U1RXPPS = 0x15; //RC5->UART1:RX1;
	movlw	21
	banksel	U1RXPPS
	movwf	U1RXPPS,BANKED
;RC6PPS = 0x12;  //RC6->UART1:TX1;
	movlw	18
	movwf	RC6PPS,BANKED
;Module: I2C1
;I2C1SCLPPS = 0x13;  //RC3->I2C1:SCL1;
	movlw	19
	movwf	I2C1SCLPPS,BANKED
;RC3PPS = 0x1D;  //RC3->I2C1:SCL1;
	movlw	29
	movwf	RC3PPS,BANKED
;I2C1SDAPPS = 0x14;  //RC4->I2C1:SDA1;
	movlw	20
	movwf	I2C1SDAPPS,BANKED
;RC4PPS = 0x1E;  //RC4->I2C1:SDA1;
	movlw	30
	movwf	RC4PPS,BANKED
	banksel	0
	return

;********************************************************************************

;Source: system.h (203)
INITSYS
;Clear BSR on ChipFamily16 MCUs
;MOVLB 0
	movlb	0
;Default settings for microcontrollers with _OSCCON1_
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
;The MCU is a chip family 16
;Section supports many MCUs, 18FxxK40, 18FxxK42 etc that have NDIV3 bit
;OSCCON type is 101
;OSCCON1 = 0x60          // Setting OSCCON1 implies clearing Clear NDIV3:0
	movlw	96
	movwf	OSCCON1,BANKED
;OSCFRQ = 0b00001000  '64mhz
	movlw	8
	movwf	OSCFRQ,BANKED
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
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
;Turn off all ports
;PORTA = 0
	banksel	PORTA
	clrf	PORTA,BANKED
;PORTB = 0
	clrf	PORTB,BANKED
;PORTC = 0
	clrf	PORTC,BANKED
;PORTD = 0
	clrf	PORTD,BANKED
;PORTE = 0
	clrf	PORTE,BANKED
	banksel	0
	return

;********************************************************************************

;Source: string.h (992)
FN_LEFT
;Empty input?
;If SysInString(0) = 0 Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF43
;Left(0) = 0
	banksel	SYSLEFT_0
	clrf	SYSLEFT_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF43
;Input length too high?
;If SysInString(0) < SysCharCount Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	banksel	SYSCHARCOUNT
	movf	SYSCHARCOUNT,W,BANKED
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF44
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;End If
ENDIF44
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
;Legacy method
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
	incf	SYSSTRINGTEMP,F,BANKED
;Left(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
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
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;Left(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSLEFT_0
	banksel	0
	return

;********************************************************************************

;Source: string.h (1031)
FN_MID
;Empty input?
;If SysInString(0) = 0 Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF47
;Mid(0) = 0
	banksel	SYSMID_0
	clrf	SYSMID_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF47
;Starting position too low?
;If SysCharStart < 1 Then SysCharStart = 1
	movlw	1
	banksel	SYSCHARSTART
	subwf	SYSCHARSTART,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF48
;If SysCharStart < 1 Then SysCharStart = 1
	movlw	1
	movwf	SYSCHARSTART,BANKED
;If SysCharStart < 1 Then SysCharStart = 1
ENDIF48
;Starting position too high?
;If SysCharStart > SysInString(0) Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARSTART,W,BANKED
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF49
;Mid(0) = 0
	banksel	SYSMID_0
	clrf	SYSMID_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF49
;Input length too high?
;SysCharStart -= 1
	decf	SYSCHARSTART,F,BANKED
;SysStringTemp = SysInString(0) - SysCharStart 'Max number of characters
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARSTART,W,BANKED
	subwf	INDF0,W,ACCESS
	movwf	SYSSTRINGTEMP,BANKED
;If SysCharCount > SysStringTemp Then
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
;SysCharCount = SysStringTemp
	movff	SYSSTRINGTEMP,SYSCHARCOUNT
;End If
;Copy characters
;For SysStringTemp = 1 To SysCharCount
;Legacy method
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
	incf	SYSSTRINGTEMP,F,BANKED
;Mid(SysStringTemp) = SysInString(SysCharStart + SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SYSCHARSTART,W,BANKED
	movwf	SysTemp1,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,MID
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp2,POSTINC0
;Next
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;Mid(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSMID_0
	banksel	0
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (920)
PSET_SSD1306
;Set pixel at X, Y on LCD to State
;X is 0 to 127
;Y is 0 to 63
;Origin in top left
;anything off screen with be rejected
;if GLCDX => GLCD_WIDTH OR GLCDY => GLCD_HEIGHT Then
	movff	GLCDX,SysBYTETempA
	movlw	128
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	GLCDY,SysBYTETempA
	movlw	64
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF64
;exit sub
	banksel	0
	return
;end if
ENDIF64
;1.14 Addresses correct device horizonal page
;don't need to do these calculations for in LOWMEMORY_GLCD_MODE
;SSD1306_BufferLocationCalc = ( GLCDY / 8 )* GLCD_WIDTH
;faster than /8
;SSD1306_BufferLocationCalc = GLCDY
	movff	GLCDY,SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H,BANKED
;Repeat 3
	movlw	3
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SSD1306_BufferLocationCalc Right
	rrcf	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
	rrcf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;faster than * 128
;Set C Off
	bcf	STATUS,C,ACCESS
;Repeat 7
	movlw	7
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop2
;Rotate SSD1306_BufferLocationCalc Left
	rlcf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	rlcf	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;SSD1306_BufferLocationCalc = GLCDX + SSD1306_BufferLocationCalc + 1
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	addwf	GLCDX,W,ACCESS
	movwf	SysTemp1,BANKED
	clrf	SysTemp2,BANKED
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	SSD1306_BUFFERLOCATIONCALC,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	SSD1306_BUFFERLOCATIONCALC_H,BANKED
;anything beyond buffer boundary?
;why? X = 127 and Y = 64 (Y is over 63!) will have passed first check....
;if SSD1306_BufferLocationCalc > GLCD_HEIGHT * GLCD_WIDTH Then
	movff	SSD1306_BUFFERLOCATIONCALC,SysWORDTempB
	movff	SSD1306_BUFFERLOCATIONCALC_H,SysWORDTempB_H
	clrf	SysWORDTempA,ACCESS
	movlw	32
	movwf	SysWORDTempA_H,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
;exit sub
	return
;end if
;GLCDDataTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
	lfsr	0,SSD1306_BUFFERALIAS
	banksel	SSD1306_BUFFERLOCATIONCALC
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,GLCDDATATEMP
;Change data to set/clear pixel
;GLCDBitNo = GLCDY And 7
	movlw	7
	andwf	GLCDY,W,ACCESS
	movwf	GLCDBITNO,ACCESS
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,ACCESS
	bra	ELSE66_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE,ACCESS
;Set C On
	bsf	STATUS,C,ACCESS
;Else
	bra	ENDIF66
ELSE66_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE,ACCESS
;Set C Off
	bcf	STATUS,C,ACCESS
;End If
ENDIF66
;Repeat GLCDBitNo
	movff	GLCDBITNO,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd3
SysRepeatLoop3
;Rotate GLCDChange Left
	rlcf	GLCDCHANGE,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,ACCESS
	bra	ELSE67_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	movf	GLCDDATATEMP,W,ACCESS
	andwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;Else
	bra	ENDIF67
ELSE67_1
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	movf	GLCDDATATEMP,W,ACCESS
	iorwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;End If
ENDIF67
;added 1.14 to isolate from full glcd mode
;revised 1.14 to isolate from low memory mode
;if SSD1306_BufferAlias(SSD1306_BufferLocationCalc) <> GLCDDataTemp then
	lfsr	0,SSD1306_BUFFERALIAS
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movf	GLCDDATATEMP,W,ACCESS
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF68
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDDataTemp
	lfsr	0,SSD1306_BUFFERALIAS
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	GLCDDATATEMP,INDF0
;Cursor_Position_SSD1306 ( GLCDX, GLCDY )
	movff	GLCDX,LOCX
	movff	GLCDY,LOCY
	banksel	0
	call	CURSOR_POSITION_SSD1306
;Write_Data_SSD1306 ( GLCDDataTemp )
	movff	GLCDDATATEMP,SSD1306SENDBYTE
	call	WRITE_DATA_SSD1306
;end if
ENDIF68
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2457)
FN_READAD1083
;Always RIGHT justified
;SET ADFM ON
	banksel	ADCON0
	bsf	ADCON0,ADFM0,BANKED
;ADPCH = ADReadPort
	movff	ADREADPORT,ADPCH
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (637)
;Configure ANSELA/B/C/D @DebugADC_H
;Select Case ADReadPort
;Case 0: Set ANSELA.0 On
SysSelect1Case1
	movf	ADREADPORT,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;Case 0: Set ANSELA.0 On
	banksel	ANSELA
	bsf	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	bra	SysSelectEnd1
SysSelect1Case2
	decf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;Case 1: Set ANSELA.1 On
	banksel	ANSELA
	bsf	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	2
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;Case 2: Set ANSELA.2 On
	banksel	ANSELA
	bsf	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
;Case 3: Set ANSELA.3 On
	banksel	ANSELA
	bsf	ANSELA,3,BANKED
;Case 4: Set ANSELA.4 ON
	bra	SysSelectEnd1
SysSelect1Case5
	movlw	4
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case6
;Case 4: Set ANSELA.4 ON
	banksel	ANSELA
	bsf	ANSELA,4,BANKED
;Case 5: Set ANSELA.5 On
	bra	SysSelectEnd1
SysSelect1Case6
	movlw	5
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case7
;Case 5: Set ANSELA.5 On
	banksel	ANSELA
	bsf	ANSELA,5,BANKED
;Case 6: Set ANSELA.6 On
	bra	SysSelectEnd1
SysSelect1Case7
	movlw	6
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case8
;Case 6: Set ANSELA.6 On
	banksel	ANSELA
	bsf	ANSELA,6,BANKED
;Case 7: Set ANSELA.7 On
	bra	SysSelectEnd1
SysSelect1Case8
	movlw	7
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case9
;Case 7: Set ANSELA.7 On
	banksel	ANSELA
	bsf	ANSELA,7,BANKED
;Case 8: Set ANSELB.0 On
	bra	SysSelectEnd1
SysSelect1Case9
	movlw	8
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case10
;Case 8: Set ANSELB.0 On
	banksel	ANSELB
	bsf	ANSELB,0,BANKED
;Case 9: Set ANSELB.1 On
	bra	SysSelectEnd1
SysSelect1Case10
	movlw	9
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case11
;Case 9: Set ANSELB.1 On
	banksel	ANSELB
	bsf	ANSELB,1,BANKED
;Case 10: Set ANSELB.2 On
	bra	SysSelectEnd1
SysSelect1Case11
	movlw	10
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case12
;Case 10: Set ANSELB.2 On
	banksel	ANSELB
	bsf	ANSELB,2,BANKED
;Case 11: Set ANSELB.3 On
	bra	SysSelectEnd1
SysSelect1Case12
	movlw	11
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case13
;Case 11: Set ANSELB.3 On
	banksel	ANSELB
	bsf	ANSELB,3,BANKED
;Case 12: Set ANSELB.4 On
	bra	SysSelectEnd1
SysSelect1Case13
	movlw	12
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case14
;Case 12: Set ANSELB.4 On
	banksel	ANSELB
	bsf	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	bra	SysSelectEnd1
SysSelect1Case14
	movlw	13
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case15
;Case 13: Set ANSELB.5 On
	banksel	ANSELB
	bsf	ANSELB,5,BANKED
;Case 14: Set ANSELB.6 On
	bra	SysSelectEnd1
SysSelect1Case15
	movlw	14
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case16
;Case 14: Set ANSELB.6 On
	banksel	ANSELB
	bsf	ANSELB,6,BANKED
;Case 15: Set ANSELB.7 On
	bra	SysSelectEnd1
SysSelect1Case16
	movlw	15
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case17
;Case 15: Set ANSELB.7 On
	banksel	ANSELB
	bsf	ANSELB,7,BANKED
;Case 16: Set ANSELC.0 On
	bra	SysSelectEnd1
SysSelect1Case17
	movlw	16
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case18
;Case 16: Set ANSELC.0 On
	banksel	ANSELC
	bsf	ANSELC,0,BANKED
;Case 17: Set ANSELC.1 On
	bra	SysSelectEnd1
SysSelect1Case18
	movlw	17
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case19
;Case 17: Set ANSELC.1 On
	banksel	ANSELC
	bsf	ANSELC,1,BANKED
;Case 18: Set ANSELC.2 On
	bra	SysSelectEnd1
SysSelect1Case19
	movlw	18
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case20
;Case 18: Set ANSELC.2 On
	banksel	ANSELC
	bsf	ANSELC,2,BANKED
;Case 19: Set ANSELC.3 On
	bra	SysSelectEnd1
SysSelect1Case20
	movlw	19
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case21
;Case 19: Set ANSELC.3 On
	banksel	ANSELC
	bsf	ANSELC,3,BANKED
;Case 20: Set ANSELC.4 On
	bra	SysSelectEnd1
SysSelect1Case21
	movlw	20
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case22
;Case 20: Set ANSELC.4 On
	banksel	ANSELC
	bsf	ANSELC,4,BANKED
;Case 21: Set ANSELC.5 On
	bra	SysSelectEnd1
SysSelect1Case22
	movlw	21
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case23
;Case 21: Set ANSELC.5 On
	banksel	ANSELC
	bsf	ANSELC,5,BANKED
;Case 22: Set ANSELC.6 On
	bra	SysSelectEnd1
SysSelect1Case23
	movlw	22
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case24
;Case 22: Set ANSELC.6 On
	banksel	ANSELC
	bsf	ANSELC,6,BANKED
;Case 23: Set ANSELC.7 On
	bra	SysSelectEnd1
SysSelect1Case24
	movlw	23
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case25
;Case 23: Set ANSELC.7 On
	banksel	ANSELC
	bsf	ANSELC,7,BANKED
;Case 32: Set ANSELE.0 On
	bra	SysSelectEnd1
SysSelect1Case25
	movlw	32
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case26
;Case 32: Set ANSELE.0 On
	banksel	ANSELE
	bsf	ANSELE,0,BANKED
;Case 33: Set ANSELE.1 On
	bra	SysSelectEnd1
SysSelect1Case26
	movlw	33
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case27
;Case 33: Set ANSELE.1 On
	banksel	ANSELE
	bsf	ANSELE,1,BANKED
;Case 34: Set ANSELE.2 On
	bra	SysSelectEnd1
SysSelect1Case27
	movlw	34
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
;Case 34: Set ANSELE.2 On
	banksel	ANSELE
	bsf	ANSELE,2,BANKED
;End Select  '*** ANSEL Bits should now be set ***
SysSelectEnd1
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
	banksel	ADCON0
	bcf	ADCON0,ADCS,BANKED
;ADCLK = 1 ' default to FOSC/2
	movlw	1
	movwf	ADCLK,BANKED
;Conversion Clock Speed
;SET ADCS OFF  ' ADCON0.4
	bcf	ADCON0,ADCS,BANKED
;ADCLK = 31    ' FOSC/32
	movlw	31
	movwf	ADCLK,BANKED
;Configure AD clock defaults fpr older 18F that do not have ADCLK
;SET ADCS2 OFF
	bcf	ADCLK,ADCS2,BANKED
;SET ADCS1 ON
	bsf	ADCLK,ADCS1,BANKED
;SET ADCS0 OFF
	bcf	ADCLK,ADCS0,BANKED
;Result formatting
;if ADLeftadjust = 0 then
;Set ADCON0.2 ON
;Set ADFM ON
	bsf	ADCON0,ADFM0,BANKED
;Set ADFM0 ON
	bsf	ADCON0,ADFM0,BANKED
;Else
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	movff	ADREADPORT,ADPCH
;Enable AD Operations
;SET ADON ON
	bsf	ADCON0,ADON,BANKED
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US,ACCESS
	banksel	0
	call	Delay_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE,BANKED
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop1
	btfsc	ADCON0,GO_NOT_DONE,BANKED
	bra	SysWaitLoop1
;Switch off A/D
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
;Write output
;ReadAD10 = ADRESL
	movff	ADRESL,READAD10
	banksel	READAD10_H
	clrf	READAD10_H,BANKED
;ReadAD10_H = ADRESH
	movff	ADRESH,READAD10_H
;Put A/D format back to normal
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:integer:, Source: stdbasic.h (266)
FN_SCALE154
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	banksel	L_FROMLOW
	movf	L_FROMLOW,W,BANKED
	subwf	L_MAP,W,BANKED
	movwf	SysTemp1,BANKED
	movf	L_FROMLOW_H,W,BANKED
	subwfb	L_MAP_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movf	L_TOLOW,W,BANKED
	subwf	L_TOHIGH,W,BANKED
	movwf	SysTemp2,BANKED
	movf	L_TOLOW_H,W,BANKED
	subwfb	L_TOHIGH_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movff	SYSTEMP1,SysLONGTempA
	movff	SYSTEMP1_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	SYSTEMP2,SysLONGTempB
	movff	SYSTEMP2_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	rcall	SYSMULTSUB32
	movff	SysLONGTempX,L_SYSCALCF
	movff	SysLONGTempX_H,L_SYSCALCF_H
	movff	SysLONGTempX_U,L_SYSCALCF_U
	movff	SysLONGTempX_E,L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	banksel	L_FROMLOW
	movf	L_FROMLOW,W,BANKED
	subwf	L_FROMHIGH,W,BANKED
	movwf	L_SYSCALC,BANKED
	movf	L_FROMLOW_H,W,BANKED
	subwfb	L_FROMHIGH_H,W,BANKED
	movwf	L_SYSCALC_H,BANKED
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
	movff	L_SYSCALCF,SysLONGTempA
	movff	L_SYSCALCF_H,SysLONGTempA_H
	movff	L_SYSCALCF_U,SysLONGTempA_U
	movff	L_SYSCALCF_E,SysLONGTempA_E
	movff	L_SYSCALC,SysLONGTempB
	movff	L_SYSCALC_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	rcall	SYSDIVSUB32
	movff	SysLONGTempA,SysTemp1
	movff	SysLONGTempA_H,SysTemp1_H
	movff	SysLONGTempA_U,SysTemp1_U
	movff	SysLONGTempA_E,SysTemp1_E
	banksel	L_TOLOW
	movf	L_TOLOW,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movf	L_TOLOW_H,W,BANKED
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movf	L_CALIBRATE,W,BANKED
	addwf	SysTemp2,W,BANKED
	movwf	SCALE,BANKED
	movf	L_CALIBRATE_H,W,BANKED
	addwfc	SysTemp2_H,W,BANKED
	movwf	SCALE_H,BANKED
	banksel	0
	return

;********************************************************************************

;Source: hwi2c.h (1008)
SI2CSTART
;Redirected for K-Mode family probalby called HI2CStart
;This method sets the registers and register bits to generate the I2C  START signal. Master_mode only.
;HI2C1StateMachine = 1
	movlw	1
	movwf	HI2C1STATEMACHINE,ACCESS
;HI2CWaitMSSPTimeout = false
	clrf	HI2CWAITMSSPTIMEOUT,ACCESS
;Clear the error state variable
;HI2C1lastError = I2C1_GOOD
	clrf	HI2C1LASTERROR,ACCESS
	return

;********************************************************************************

;Source: trig2places.h (49)
FN_SIN
;return sine of angle
;if trig_arg2 < 0 then               ;sine is an odd function,
	movff	TRIG_ARG2,SysINTEGERTempA
	movff	TRIG_ARG2_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE14_1
;trig_sign = -1                    ;so change sign of result
	banksel	TRIG_SIGN
	setf	TRIG_SIGN,BANKED
	setf	TRIG_SIGN_H,BANKED
;trig_arg2 = -1 * trig_arg2        ;and negate negative angle
	movff	TRIG_ARG2,SysINTEGERTempA
	movff	TRIG_ARG2_H,SysINTEGERTempA_H
	setf	SysINTEGERTempB,ACCESS
	setf	SysINTEGERTempB_H,ACCESS
	banksel	0
	rcall	SYSMULTSUBINT
	movff	SysINTEGERTempX,TRIG_ARG2
	movff	SysINTEGERTempX_H,TRIG_ARG2_H
;else
	bra	ENDIF14
ELSE14_1
;trig_sign = 1                     ;else a positive angle
	movlw	1
	banksel	TRIG_SIGN
	movwf	TRIG_SIGN,BANKED
	clrf	TRIG_SIGN_H,BANKED
;end if
ENDIF14
;trig_arg2 = trig_arg2 mod 360       ;reduce to 0 to 359 degrees
	movff	TRIG_ARG2,SysINTEGERTempA
	movff	TRIG_ARG2_H,SysINTEGERTempA_H
	movlw	104
	movwf	SysINTEGERTempB,ACCESS
	movlw	1
	movwf	SysINTEGERTempB_H,ACCESS
	banksel	0
	rcall	SYSDIVSUBINT
	movff	SysINTEGERTempX,TRIG_ARG2
	movff	SysINTEGERTempX_H,TRIG_ARG2_H
;if trig_arg2 > 180 then
	movff	TRIG_ARG2,SysINTEGERTempB
	movff	TRIG_ARG2_H,SysINTEGERTempB_H
	movlw	180
	movwf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF15
;trig_sign = -1 * trig_sign        ;negative in III and IV
	movff	TRIG_SIGN,SysINTEGERTempA
	movff	TRIG_SIGN_H,SysINTEGERTempA_H
	setf	SysINTEGERTempB,ACCESS
	setf	SysINTEGERTempB_H,ACCESS
	rcall	SYSMULTSUBINT
	movff	SysINTEGERTempX,TRIG_SIGN
	movff	SysINTEGERTempX_H,TRIG_SIGN_H
;end if
ENDIF15
;trig_arg2 = trig_ref(trig_arg2)     ;get the reference angle
	movff	TRIG_ARG2,TRIG_ARG1
	movff	TRIG_ARG2_H,TRIG_ARG1_H
	rcall	FN_TRIG_REF
	movff	TRIG_REF,TRIG_ARG2
	movff	TRIG_REF_H,TRIG_ARG2_H
;trig_i = [byte]trig_arg2+1          ;index into the table
	banksel	TRIG_ARG2
	incf	TRIG_ARG2,W,BANKED
	movwf	TRIG_I,BANKED
;readTable sineTab, trig_i, trig_val
	movff	TRIG_I,SYSSTRINGA
	banksel	0
	rcall	SINETAB
	banksel	TRIG_VAL
	movwf	TRIG_VAL,BANKED
	clrf	TRIG_VAL_H,BANKED
;sin = trig_sign * [integer]trig_val ;create final result
	movff	TRIG_SIGN,SysINTEGERTempA
	movff	TRIG_SIGN_H,SysINTEGERTempA_H
	movff	TRIG_VAL,SysINTEGERTempB
	movff	TRIG_VAL_H,SysINTEGERTempB_H
	banksel	0
	rcall	SYSMULTSUBINT
	movff	SysINTEGERTempX,SIN
	movff	SysINTEGERTempX_H,SIN_H
	return

;********************************************************************************

SINETAB
	movlw	92
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLESINETAB
	movwf	TBLPTRL,ACCESS
	movlw	high TABLESINETAB
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLESINETAB
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLESINETAB
	db	91,0,2,3,5,7,9,10,12,14,16,17,19,21,22,24,26,28,29,31,33,34,36,37,39,41,42,44
	db	45,47,48,50,52,53,54,56,57,59,60,62,63,64,66,67,68,69,71,72,73,74,75,77,78,79
	db	80,81,82,83,84,85,86,87,87,88,89,90,91,91,92,93,93,94,95,95,96,96,97,97,97,98
	db	98,98,99,99,99,99,100,100,100,100,100,100

;********************************************************************************

;Source: string.h (124)
FN_STR
;SysCharCount = 0
	banksel	SYSCHARCOUNT
	clrf	SYSCHARCOUNT,BANKED
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF39
;SysStrData = SysValTemp / 10000
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValThousands
	bra	SYSVALTHOUSANDS
;End If
ENDIF39
;Thousands
;IF SysValTemp >= 1000 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF40
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValHundreds
	bra	SYSVALHUNDREDS
;End If
ENDIF40
;Hundreds
;IF SysValTemp >= 100 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF41
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValTens
	bra	SYSVALTENS
;End If
ENDIF41
;Tens
;IF SysValTemp >= 10 Then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF42
SYSVALTENS
;SysStrData = SysValTemp / 10
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;End If
ENDIF42
;Ones
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysValTemp + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSVALTEMP,W,BANKED
	movwf	INDF0,ACCESS
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;Str(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSSTR_0
	banksel	0
	return

;********************************************************************************

;Source: system.h (4113)
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

;Source: system.h (4139)
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

;Source: system.h (4193)
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

;Source: system.h (4503)
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

;Source: system.h (4533)
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

;Source: system.h (4591)
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

;Source: system.h (4975)
SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ELSE36_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF37
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	return
;End If
ENDIF37
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,W,ACCESS
	movwf	SYSDIVMULTA,ACCESS
	comf	SYSINTEGERTEMPA_H,W,ACCESS
	movwf	SYSDIVMULTA_H,ACCESS
	incf	SYSDIVMULTA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSDIVMULTA_H,F,ACCESS
;SysIntegerTempA = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,W,ACCESS
	movwf	SYSINTEGERTEMPA,ACCESS
	comf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSINTEGERTEMPA_H,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempB = SysDivMultA
	movff	SYSDIVMULTA,SYSINTEGERTEMPB
	movff	SYSDIVMULTA_H,SYSINTEGERTEMPB_H
;+A
;Else
	bra	ENDIF36
ELSE36_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	return
;End If
;End If
ENDIF36
;Test High, exit if more
;movf SysIntegerTempA_H,W
	movf	SYSINTEGERTEMPA_H,W,ACCESS
;subwf SysIntegerTempB_H,W
	subwf	SYSINTEGERTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	movf	SYSINTEGERTEMPB_H,W,ACCESS
;subwf SysIntegerTempA_H,W
	subwf	SYSINTEGERTEMPA_H,W,ACCESS
;bnc SCLTIntTrue
	bnc	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	movf	SYSINTEGERTEMPB,W,ACCESS
;subwf SysIntegerTempA,W
	subwf	SYSINTEGERTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLTINTTRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

;Source: system.h (1768)
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

;Source: system.h (3507)
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
	bra	ENDIF29
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF29
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
	bra	ENDIF30
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF30
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

;Source: system.h (3583)
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
	movff	SYSLONGTEMPA,SYSLONGDIVMULTA
	movff	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	movff	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	movff	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movff	SYSLONGTEMPB,SYSLONGDIVMULTB
	movff	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	movff	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	movff	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	banksel	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX,BANKED
	clrf	SYSLONGDIVMULTX_H,BANKED
	clrf	SYSLONGDIVMULTX_U,BANKED
	clrf	SYSLONGDIVMULTX_E,BANKED
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movff	SYSLONGDIVMULTB,SysLONGTempA
	movff	SYSLONGDIVMULTB_H,SysLONGTempA_H
	movff	SYSLONGDIVMULTB_U,SysLONGTempA_U
	movff	SYSLONGDIVMULTB_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	rcall	SYSCOMPEQUAL32
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF34
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF34
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP,ACCESS
SYSDIV32START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysLongDivMultA Left
	banksel	SYSLONGDIVMULTA
	rlcf	SYSLONGDIVMULTA,F,BANKED
	rlcf	SYSLONGDIVMULTA_H,F,BANKED
	rlcf	SYSLONGDIVMULTA_U,F,BANKED
	rlcf	SYSLONGDIVMULTA_E,F,BANKED
;Rotate SysLongDivMultX Left
	rlcf	SYSLONGDIVMULTX,F,BANKED
	rlcf	SYSLONGDIVMULTX_H,F,BANKED
	rlcf	SYSLONGDIVMULTX_U,F,BANKED
	rlcf	SYSLONGDIVMULTX_E,F,BANKED
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,BANKED
	subwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTB_H,W,BANKED
	subwfb	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTB_U,W,BANKED
	subwfb	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTB_E,W,BANKED
	subwfb	SYSLONGDIVMULTX_E,F,BANKED
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0,BANKED
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF35
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0,BANKED
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,BANKED
	addwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTB_H,W,BANKED
	addwfc	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTB_U,W,BANKED
	addwfc	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTB_E,W,BANKED
	addwfc	SYSLONGDIVMULTX_E,F,BANKED
;End If
ENDIF35
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv32Start
	bra	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movff	SYSLONGDIVMULTA,SYSLONGTEMPA
	movff	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	movff	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	movff	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	banksel	0
	return

;********************************************************************************

;Source: system.h (3561)
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
	bra	ENDIF31
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
ENDIF31
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF32
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
ENDIF32
;Call word divide routine
;SysDivSub16
	rcall	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF33
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
ENDIF33
	return

;********************************************************************************

;Source: system.h (2973)
SYSMULTSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;X = LowA * LowB
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movff PRODL, SysWordTempX
	movff	PRODL, SYSWORDTEMPX
;movff PRODH, SysWordTempX_H
	movff	PRODH, SYSWORDTEMPX_H
;HighX += LowA * HighB
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;HighX += HighA * LowB
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;PRODL = HighA * HighB
;movf SysWordTempA_H, F
	movf	SYSWORDTEMPA_H, F,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
	return

;********************************************************************************

;Source: system.h (3090)
SYSMULTSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;Can't use normal SysDivMult variables for 32 bit, they overlap with
;SysLongTemp variables
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	movff	SYSLONGTEMPA,SYSLONGDIVMULTA
	movff	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	movff	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	movff	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movff	SYSLONGTEMPB,SYSLONGDIVMULTB
	movff	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	movff	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	movff	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	banksel	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX,BANKED
	clrf	SYSLONGDIVMULTX_H,BANKED
	clrf	SYSLONGDIVMULTX_U,BANKED
	clrf	SYSLONGDIVMULTX_E,BANKED
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	banksel	SYSLONGDIVMULTB
	btfss	SYSLONGDIVMULTB,0,BANKED
	bra	ENDIF27
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	movf	SYSLONGDIVMULTA,W,BANKED
	addwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTA_H,W,BANKED
	addwfc	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTA_U,W,BANKED
	addwfc	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTA_E,W,BANKED
	addwfc	SYSLONGDIVMULTX_E,F,BANKED
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
ENDIF27
;set STATUS.C OFF
	bcf	STATUS,C,ACCESS
;rotate SysLongDivMultB right
	rrcf	SYSLONGDIVMULTB_E,F,BANKED
	rrcf	SYSLONGDIVMULTB_U,F,BANKED
	rrcf	SYSLONGDIVMULTB_H,F,BANKED
	rrcf	SYSLONGDIVMULTB,F,BANKED
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate SysLongDivMultA left
	rlcf	SYSLONGDIVMULTA,F,BANKED
	rlcf	SYSLONGDIVMULTA_H,F,BANKED
	rlcf	SYSLONGDIVMULTA_U,F,BANKED
	rlcf	SYSLONGDIVMULTA_E,F,BANKED
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movff	SYSLONGDIVMULTB,SysLONGTempB
	movff	SYSLONGDIVMULTB_H,SysLONGTempB_H
	movff	SYSLONGDIVMULTB_U,SysLONGTempB_U
	movff	SYSLONGDIVMULTB_E,SysLONGTempB_E
	clrf	SysLONGTempA,ACCESS
	clrf	SysLONGTempA_H,ACCESS
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHAN32
	btfsc	SysByteTempX,0,ACCESS
;if SysLongDivMultB > 0 then goto MUL32LOOP
	bra	MUL32LOOP
;if SysLongDivMultB > 0 then goto MUL32LOOP
;SysLongTempX = SysLongDivMultX
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	return

;********************************************************************************

;Source: system.h (3071)
SYSMULTSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	xorwf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSSIGNBYTE,ACCESS
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ENDIF24
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
ENDIF24
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF25
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
ENDIF25
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF26
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
ENDIF26
	return

;********************************************************************************

;Source: system.h (1965)
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
	db	3,48,46,48


StringTable2
	db	2,48,46


StringTable3
	db	1,46


StringTable4
	db	1,48


StringTable5
	db	1,53


;********************************************************************************

;Source: trig2places.h (29)
FN_TRIG_REF
;create reference angle (0 to 90) for the argument
;if (trig_arg1 > 270) then           ;Quadrant IV
	movff	TRIG_ARG1,SysINTEGERTempB
	movff	TRIG_ARG1_H,SysINTEGERTempB_H
	movlw	14
	movwf	SysINTEGERTempA,ACCESS
	movlw	1
	movwf	SysINTEGERTempA_H,ACCESS
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE69_1
;trig_ref = 360 - trig_arg1
	banksel	TRIG_ARG1
	movf	TRIG_ARG1,W,BANKED
	sublw	104
	movwf	TRIG_REF,BANKED
	movlw	1
	movwf	SysTemp1,BANKED
	movf	TRIG_ARG1_H,W,BANKED
	subwfb	SysTemp1,W,BANKED
	movwf	TRIG_REF_H,BANKED
;else
	bra	ENDIF69
ELSE69_1
;if (trig_arg1 > 180) then         ;Quadrant III
	movff	TRIG_ARG1,SysINTEGERTempB
	movff	TRIG_ARG1_H,SysINTEGERTempB_H
	movlw	180
	movwf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE70_1
;trig_ref = trig_arg1 - 180
	movlw	180
	banksel	TRIG_ARG1
	subwf	TRIG_ARG1,W,BANKED
	movwf	TRIG_REF,BANKED
	movlw	0
	subwfb	TRIG_ARG1_H,W,BANKED
	movwf	TRIG_REF_H,BANKED
;else                              ;Quadrant II
	bra	ENDIF70
ELSE70_1
;if (trig_arg1 > 90) then
	movff	TRIG_ARG1,SysINTEGERTempB
	movff	TRIG_ARG1_H,SysINTEGERTempB_H
	movlw	90
	movwf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE71_1
;trig_ref = 180 - trig_arg1
	banksel	TRIG_ARG1
	movf	TRIG_ARG1,W,BANKED
	sublw	180
	movwf	TRIG_REF,BANKED
	clrf	SysTemp1,BANKED
	movf	TRIG_ARG1_H,W,BANKED
	subwfb	SysTemp1,W,BANKED
	movwf	TRIG_REF_H,BANKED
;else
	bra	ENDIF71
ELSE71_1
;trig_ref = trig_arg1          ;Quadrant I by default
	movff	TRIG_ARG1,TRIG_REF
	movff	TRIG_ARG1_H,TRIG_REF_H
;end if
ENDIF71
;end if
ENDIF70
;end if
ENDIF69
	banksel	0
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (256)
WRITE_COMMAND_SSD1306
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	call	HI2CQ24Q35SEND
;HI2CSend 0x00
	clrf	I2CBYTE,ACCESS
	call	HI2CQ24Q35SEND
;HI2CSend SSD1306SendByte
	movff	SSD1306SENDBYTE,I2CBYTE
	call	HI2CQ24Q35SEND
;HI2CStop
	goto	HI2CQ24Q35STOP

;********************************************************************************

;Source: GLCD_SSD1306.H (302)
WRITE_DATA_SSD1306
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	call	HI2CQ24Q35SEND
;HI2CSend 0x40
	movlw	64
	movwf	I2CBYTE,ACCESS
	call	HI2CQ24Q35SEND
;HI2CSend SSD1306SendByte
	movff	SSD1306SENDBYTE,I2CBYTE
	call	HI2CQ24Q35SEND
;HI2CStop
	goto	HI2CQ24Q35STOP

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: picas.h (32)
_LINE78
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	clrf	LINEDIFFX,ACCESS
	clrf	LINEDIFFX_H,ACCESS
;LineDiffY = 0
	clrf	LINEDIFFY,ACCESS
	clrf	LINEDIFFY_H,ACCESS
;LineStepX = 0
	clrf	LINESTEPX,ACCESS
	clrf	LINESTEPX_H,ACCESS
;LineStepY = 0
	clrf	LINESTEPY,ACCESS
	clrf	LINESTEPY_H,ACCESS
;LineDiffX_x2 = 0
	clrf	LINEDIFFX_X2,ACCESS
	clrf	LINEDIFFX_X2_H,ACCESS
;LineDiffY_x2 = 0
	clrf	LINEDIFFY_X2,ACCESS
	clrf	LINEDIFFY_X2_H,ACCESS
;LineErr = 0
	clrf	LINEERR,ACCESS
	clrf	LINEERR_H,ACCESS
;LineDiffX =  LineX2 -   LineX1
	movf	LINEX1,W,ACCESS
	subwf	LINEX2,W,ACCESS
	movwf	LINEDIFFX,ACCESS
	movf	LINEX1_H,W,ACCESS
	subwfb	LINEX2_H,W,ACCESS
	movwf	LINEDIFFX_H,ACCESS
;LineDiffY =  LineY2 -   LineY1
	movf	LINEY1,W,ACCESS
	subwf	LINEY2,W,ACCESS
	movwf	LINEDIFFY,ACCESS
	movf	LINEY1_H,W,ACCESS
	subwfb	LINEY2_H,W,ACCESS
	movwf	LINEDIFFY_H,ACCESS
;if (LineDiffX > 0) then
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE18_1
;LineStepX = 1
	movlw	1
	movwf	LINESTEPX,ACCESS
	clrf	LINESTEPX_H,ACCESS
;else
	bra	ENDIF18
ELSE18_1
;LineStepX = -1
	setf	LINESTEPX,ACCESS
	setf	LINESTEPX_H,ACCESS
;end if
ENDIF18
;if (LineDiffY > 0) then
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE19_1
;LineStepY = 1
	movlw	1
	movwf	LINESTEPY,ACCESS
	clrf	LINESTEPY_H,ACCESS
;else
	bra	ENDIF19
ELSE19_1
;LineStepY = -1
	setf	LINESTEPY,ACCESS
	setf	LINESTEPY_H,ACCESS
;end if
ENDIF19
;LineDiffX = LineStepX * LineDiffX
	movff	LINESTEPX,SysINTEGERTempA
	movff	LINESTEPX_H,SysINTEGERTempA_H
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	rcall	SYSMULTSUBINT
	movff	SysINTEGERTempX,LINEDIFFX
	movff	SysINTEGERTempX_H,LINEDIFFX_H
;LineDiffY = LineStepY * LineDiffY
	movff	LINESTEPY,SysINTEGERTempA
	movff	LINESTEPY_H,SysINTEGERTempA_H
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	rcall	SYSMULTSUBINT
	movff	SysINTEGERTempX,LINEDIFFY
	movff	SysINTEGERTempX_H,LINEDIFFY_H
;LineDiffX_x2 = LineDiffX*2
	movff	LINEDIFFX,SysINTEGERTempA
	movff	LINEDIFFX_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	rcall	SYSMULTSUBINT
	movff	SysINTEGERTempX,LINEDIFFX_X2
	movff	SysINTEGERTempX_H,LINEDIFFX_X2_H
;LineDiffY_x2 = LineDiffY*2
	movff	LINEDIFFY,SysINTEGERTempA
	movff	LINEDIFFY_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	rcall	SYSMULTSUBINT
	movff	SysINTEGERTempX,LINEDIFFY_X2
	movff	SysINTEGERTempX_H,LINEDIFFY_X2_H
;if ( LineDiffX >= LineDiffY) then
	movff	LINEDIFFX,SysINTEGERTempA
	movff	LINEDIFFX_H,SysINTEGERTempA_H
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	rcall	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE20_1
;LineErr = LineDiffY_x2 - LineDiffX
	movf	LINEDIFFX,W,ACCESS
	subwf	LINEDIFFY_X2,W,ACCESS
	movwf	LINEERR,ACCESS
	movf	LINEDIFFX_H,W,ACCESS
	subwfb	LINEDIFFY_X2_H,W,ACCESS
	movwf	LINEERR_H,ACCESS
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S2
	movff	linex1,SysWORDTempA
	movff	linex1_H,SysWORDTempA_H
	movff	linex2,SysWORDTempB
	movff	linex2_H,SysWORDTempB_H
	banksel	0
	rcall	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E2
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_SSD1306
;LineX1 += LineStepX
	movf	LINESTEPX,W,ACCESS
	addwf	LINEX1,F,ACCESS
	movf	LINESTEPX_H,W,ACCESS
	addwfc	LINEX1_H,F,ACCESS
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE21_1
;LineErr += LineDiffY_x2
	movf	LINEDIFFY_X2,W,ACCESS
	addwf	LINEERR,F,ACCESS
	movf	LINEDIFFY_X2_H,W,ACCESS
	addwfc	LINEERR_H,F,ACCESS
;else
	bra	ENDIF21
ELSE21_1
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	movf	LINEDIFFX_X2,W,ACCESS
	subwf	LINEDIFFY_X2,W,ACCESS
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movf	LINEDIFFX_X2_H,W,ACCESS
	subwfb	LINEDIFFY_X2_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	SysTemp1,W,BANKED
	addwf	LINEERR,F,ACCESS
	movf	SysTemp1_H,W,BANKED
	addwfc	LINEERR_H,F,ACCESS
;LineY1 += LineStepY
	movf	LINESTEPY,W,ACCESS
	addwf	LINEY1,F,ACCESS
	movf	LINESTEPY_H,W,ACCESS
	addwfc	LINEY1_H,F,ACCESS
;end if
ENDIF21
;loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_SSD1306
;else
	bra	ENDIF20
ELSE20_1
;LineErr = LineDiffX_x2 - LineDiffY
	movf	LINEDIFFY,W,ACCESS
	subwf	LINEDIFFX_X2,W,ACCESS
	movwf	LINEERR,ACCESS
	movf	LINEDIFFY_H,W,ACCESS
	subwfb	LINEDIFFX_X2_H,W,ACCESS
	movwf	LINEERR_H,ACCESS
;do while (   LineY1 <>  LineY2)
SysDoLoop_S3
	movff	liney1,SysWORDTempA
	movff	liney1_H,SysWORDTempA_H
	movff	liney2,SysWORDTempB
	movff	liney2_H,SysWORDTempB_H
	banksel	0
	rcall	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E3
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_SSD1306
;LineY1 += LineStepY
	movf	LINESTEPY,W,ACCESS
	addwf	LINEY1,F,ACCESS
	movf	LINESTEPY_H,W,ACCESS
	addwfc	LINEY1_H,F,ACCESS
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE22_1
;LineErr += LineDiffX_x2
	movf	LINEDIFFX_X2,W,ACCESS
	addwf	LINEERR,F,ACCESS
	movf	LINEDIFFX_X2_H,W,ACCESS
	addwfc	LINEERR_H,F,ACCESS
;else
	bra	ENDIF22
ELSE22_1
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	movf	LINEDIFFY_X2,W,ACCESS
	subwf	LINEDIFFX_X2,W,ACCESS
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movf	LINEDIFFY_X2_H,W,ACCESS
	subwfb	LINEDIFFX_X2_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	SysTemp1,W,BANKED
	addwf	LINEERR,F,ACCESS
	movf	SysTemp1_H,W,BANKED
	addwfc	LINEERR_H,F,ACCESS
;LineX1 += LineStepX
	movf	LINESTEPX,W,ACCESS
	addwf	LINEX1,F,ACCESS
	movf	LINESTEPX_H,W,ACCESS
	addwfc	LINEX1_H,F,ACCESS
;end if
ENDIF22
;loop
	bra	SysDoLoop_S3
SysDoLoop_E3
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_SSD1306
;end if
ENDIF20
	return

;********************************************************************************


 END
