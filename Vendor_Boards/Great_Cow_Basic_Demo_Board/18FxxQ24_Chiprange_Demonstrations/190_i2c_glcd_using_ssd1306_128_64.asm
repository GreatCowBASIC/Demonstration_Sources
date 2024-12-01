;Program compiled by GCBASIC (2024.11.30 (Windows 64 bit) : Build 1445) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2024-12-01 CRC248
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\18FxxQ24_Chiprange_Demonstrations\190_i2c_glcd_using_ssd1306_128_64.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\18FxxQ24_Chiprange_Demonstrations\190_i2c_glcd_using_ssd1306_128_64.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F26Q24, r=DEC
#include <P18F26Q24.inc>
 CONFIG  CPD = OFF
 CONFIG  CP = OFF
 CONFIG  WRTSAF = OFF
 CONFIG  WRTD = OFF
 CONFIG  WRTB = OFF
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
ADCVAL                           EQU    1294          ; 0x50E
ADCVAL_H                         EQU    1295          ; 0x50F
ADREADPORT                       EQU    1296          ; 0x510
BYTENUMBER                       EQU    1297          ; 0x511
CCOUNT                           EQU    1298          ; 0x512
CHARCODE                         EQU    1299          ; 0x513
CHARCOL                          EQU    1300          ; 0x514
CHARCOLS                         EQU    1302          ; 0x516
CHARCOL_H                        EQU    1301          ; 0x515
CHARLOCX                         EQU    1303          ; 0x517
CHARLOCX_H                       EQU    1304          ; 0x518
CHARLOCY                         EQU    1305          ; 0x519
CHARLOCY_H                       EQU    1306          ; 0x51A
CHARROW                          EQU    1307          ; 0x51B
CHARROWS                         EQU    1309          ; 0x51D
CHARROW_H                        EQU    1308          ; 0x51C
CHR                              EQU    4310          ; 0x10D6
COL                              EQU    1310          ; 0x51E
CURRCHARCOL                      EQU    1311          ; 0x51F
CURRCHARROW                      EQU    1312          ; 0x520
CURRCHARVAL                      EQU    1313          ; 0x521
DELAYTEMP                        EQU    1280          ; 0x500
DELAYTEMP2                       EQU    1281          ; 0x501
DRAWLINE                         EQU    1314          ; 0x522
DRAWLINE_H                       EQU    1315          ; 0x523
FILLED_ELLIPSE                   EQU    1316          ; 0x524
GLCDBACKGROUND                   EQU    1317          ; 0x525
GLCDBACKGROUND_H                 EQU    1318          ; 0x526
GLCDBITNO                        EQU    1319          ; 0x527
GLCDCHANGE                       EQU    1320          ; 0x528
GLCDCOLOUR                       EQU    1321          ; 0x529
GLCDCOLOUR_H                     EQU    1322          ; 0x52A
GLCDDATATEMP                     EQU    1323          ; 0x52B
GLCDFNTDEFAULT                   EQU    1324          ; 0x52C
GLCDFNTDEFAULTHEIGHT             EQU    1325          ; 0x52D
GLCDFNTDEFAULTSIZE               EQU    1326          ; 0x52E
GLCDFONTWIDTH                    EQU    1327          ; 0x52F
GLCDFOREGROUND                   EQU    1328          ; 0x530
GLCDFOREGROUND_H                 EQU    1329          ; 0x531
GLCDPRINTLEN                     EQU    1330          ; 0x532
GLCDPRINTLOC                     EQU    1331          ; 0x533
GLCDPRINTLOC_H                   EQU    1332          ; 0x534
GLCDPRINT_STRING_COUNTER         EQU    1333          ; 0x535
GLCDTEMP                         EQU    1334          ; 0x536
GLCDTEMP_H                       EQU    1335          ; 0x537
GLCDX                            EQU    1336          ; 0x538
GLCDY                            EQU    1337          ; 0x539
GLCD_EX2                         EQU    1338          ; 0x53A
GLCD_EX2_E                       EQU    1341          ; 0x53D
GLCD_EX2_H                       EQU    1339          ; 0x53B
GLCD_EX2_U                       EQU    1340          ; 0x53C
GLCD_EY2                         EQU    1342          ; 0x53E
GLCD_EY2_E                       EQU    1345          ; 0x541
GLCD_EY2_H                       EQU    1343          ; 0x53F
GLCD_EY2_U                       EQU    1344          ; 0x540
GLCD_FX2                         EQU    1346          ; 0x542
GLCD_FX2_E                       EQU    1349          ; 0x545
GLCD_FX2_H                       EQU    1347          ; 0x543
GLCD_FX2_U                       EQU    1348          ; 0x544
GLCD_FY2                         EQU    1350          ; 0x546
GLCD_FY2_E                       EQU    1353          ; 0x549
GLCD_FY2_H                       EQU    1351          ; 0x547
GLCD_FY2_U                       EQU    1352          ; 0x548
GLCD_PP                          EQU    1354          ; 0x54A
GLCD_PP_E                        EQU    1357          ; 0x54D
GLCD_PP_H                        EQU    1355          ; 0x54B
GLCD_PP_TEMP                     EQU    1358          ; 0x54E
GLCD_PP_TEMP_E                   EQU    1361          ; 0x551
GLCD_PP_TEMP_H                   EQU    1359          ; 0x54F
GLCD_PP_TEMP_U                   EQU    1360          ; 0x550
GLCD_PP_U                        EQU    1356          ; 0x54C
GLCD_PX                          EQU    1362          ; 0x552
GLCD_PX_E                        EQU    1365          ; 0x555
GLCD_PX_H                        EQU    1363          ; 0x553
GLCD_PX_U                        EQU    1364          ; 0x554
GLCD_PY                          EQU    1366          ; 0x556
GLCD_PY_E                        EQU    1369          ; 0x559
GLCD_PY_H                        EQU    1367          ; 0x557
GLCD_PY_U                        EQU    1368          ; 0x558
GLCD_RX2                         EQU    1370          ; 0x55A
GLCD_RX2_H                       EQU    1371          ; 0x55B
GLCD_RY2                         EQU    1372          ; 0x55C
GLCD_RY2_H                       EQU    1373          ; 0x55D
GLCD_XX                          EQU    1374          ; 0x55E
GLCD_XX_H                        EQU    1375          ; 0x55F
GLCD_YORDINATE                   EQU    1376          ; 0x560
GLCD_YORDINATE_H                 EQU    1377          ; 0x561
GLCD_YY                          EQU    1378          ; 0x562
GLCD_YY1                         EQU    1380          ; 0x564
GLCD_YY_H                        EQU    1379          ; 0x563
HI2C1LASTERROR                   EQU    1381          ; 0x565
HI2C1STATEMACHINE                EQU    1382          ; 0x566
HI2CACKPOLLSTATE                 EQU    1383          ; 0x567
HI2CCURRENTMODE                  EQU    1384          ; 0x568
HI2CWAITMSSPTIMEOUT              EQU    1385          ; 0x569
HWI2C_BUFFER                     EQU    4211          ; 0x1073
HWI2C_BUFFERLOCATIONCOUNTER      EQU    1386          ; 0x56A
HWI2C_BUFFERLOCATIONCOUNTERINDEX EQU    1388          ; 0x56C
HWI2C_BUFFERLOCATIONCOUNTERINDEX EQU    1389          ; 0x56D
HWI2C_BUFFERLOCATIONCOUNTER_H    EQU    1387          ; 0x56B
I2CBYTE                          EQU    1390          ; 0x56E
INXRADIUS                        EQU    1391          ; 0x56F
INXRADIUS_H                      EQU    1392          ; 0x570
INYRADIUS                        EQU    1393          ; 0x571
INYRADIUS_H                      EQU    1394          ; 0x572
LCDVALUE                         EQU    1395          ; 0x573
LCDVALUE_E                       EQU    1398          ; 0x576
LCDVALUE_H                       EQU    1396          ; 0x574
LCDVALUE_U                       EQU    1397          ; 0x575
LINECOLOUR                       EQU    1399          ; 0x577
LINECOLOUR_E                     EQU    1402          ; 0x57A
LINECOLOUR_H                     EQU    1400          ; 0x578
LINECOLOUR_U                     EQU    1401          ; 0x579
LINEDIFFX                        EQU    1403          ; 0x57B
LINEDIFFX_H                      EQU    1404          ; 0x57C
LINEDIFFX_X2                     EQU    1405          ; 0x57D
LINEDIFFX_X2_H                   EQU    1406          ; 0x57E
LINEDIFFY                        EQU    1407          ; 0x57F
LINEDIFFY_H                      EQU    1408          ; 0x580
LINEDIFFY_X2                     EQU    1409          ; 0x581
LINEDIFFY_X2_H                   EQU    1410          ; 0x582
LINEERR                          EQU    1411          ; 0x583
LINEERR_H                        EQU    1412          ; 0x584
LINESTEPX                        EQU    1413          ; 0x585
LINESTEPX_H                      EQU    1414          ; 0x586
LINESTEPY                        EQU    1415          ; 0x587
LINESTEPY_H                      EQU    1416          ; 0x588
LINEX1                           EQU    1417          ; 0x589
LINEX1_H                         EQU    1418          ; 0x58A
LINEX2                           EQU    1419          ; 0x58B
LINEX2_H                         EQU    1420          ; 0x58C
LINEY1                           EQU    1421          ; 0x58D
LINEY1_H                         EQU    1422          ; 0x58E
LINEY2                           EQU    1423          ; 0x58F
LINEY2_H                         EQU    1424          ; 0x590
LOCX                             EQU    1425          ; 0x591
LOCY                             EQU    1426          ; 0x592
LONGNUMBER                       EQU    1427          ; 0x593
LONGNUMBER_E                     EQU    1430          ; 0x596
LONGNUMBER_H                     EQU    1428          ; 0x594
LONGNUMBER_U                     EQU    1429          ; 0x595
OUTSTRING                        EQU    4269          ; 0x10AD
PAD                              EQU    4228          ; 0x1084
POSCHARX                         EQU    1431          ; 0x597
POSCHARX_H                       EQU    1432          ; 0x598
POSCHARY                         EQU    1433          ; 0x599
PRINTLOCX                        EQU    1434          ; 0x59A
PRINTLOCX_H                      EQU    1435          ; 0x59B
PRINTLOCY                        EQU    1436          ; 0x59C
PRINTLOCY_H                      EQU    1437          ; 0x59D
RADIUSERR                        EQU    1438          ; 0x59E
RADIUSERR_H                      EQU    1439          ; 0x59F
READAD                           EQU    1440          ; 0x5A0
ROW                              EQU    1441          ; 0x5A1
SSD1306SENDBYTE                  EQU    1442          ; 0x5A2
SSD1306_BUFFERALIAS              EQU    4351          ; 0x10FF
SSD1306_BUFFERLOCATIONCALC       EQU    1443          ; 0x5A3
SSD1306_BUFFERLOCATIONCALC_H     EQU    1444          ; 0x5A4
STR                              EQU    4178          ; 0x1052
STRINGLOCX                       EQU    1445          ; 0x5A5
STRINGPOINTER                    EQU    1446          ; 0x5A6
SYSARRAYTEMP1                    EQU    1447          ; 0x5A7
SYSARRAYTEMP2                    EQU    1448          ; 0x5A8
SYSBYTETEMPA                     EQU    1285          ; 0x505
SYSBYTETEMPB                     EQU    1289          ; 0x509
SYSBYTETEMPX                     EQU    1280          ; 0x500
SYSCALCTEMPA                     EQU    1285          ; 0x505
SYSCALCTEMPA_E                   EQU    1288          ; 0x508
SYSCALCTEMPA_H                   EQU    1286          ; 0x506
SYSCALCTEMPA_U                   EQU    1287          ; 0x507
SYSCALCTEMPX                     EQU    1280          ; 0x500
SYSCALCTEMPX_H                   EQU    1281          ; 0x501
SYSCHAR                          EQU    1449          ; 0x5A9
SYSCHARCOUNT                     EQU    1450          ; 0x5AA
SYSCHARSHANDLER                  EQU    1451          ; 0x5AB
SYSCHARSHANDLER_H                EQU    1452          ; 0x5AC
SYSDIVLOOP                       EQU    1284          ; 0x504
SYSDIVMULTA                      EQU    1287          ; 0x507
SYSDIVMULTA_H                    EQU    1288          ; 0x508
SYSDIVMULTB                      EQU    1291          ; 0x50B
SYSDIVMULTB_H                    EQU    1292          ; 0x50C
SYSDIVMULTX                      EQU    1282          ; 0x502
SYSDIVMULTX_H                    EQU    1283          ; 0x503
SYSFORLOOPABSVALUE12             EQU    1453          ; 0x5AD
SYSFORLOOPABSVALUE12_H           EQU    1454          ; 0x5AE
SYSFORLOOPSTEP11                 EQU    1455          ; 0x5AF
SYSFORLOOPSTEP11_H               EQU    1456          ; 0x5B0
SYSINTEGERTEMPA                  EQU    1285          ; 0x505
SYSINTEGERTEMPA_H                EQU    1286          ; 0x506
SYSINTEGERTEMPB                  EQU    1289          ; 0x509
SYSINTEGERTEMPB_H                EQU    1290          ; 0x50A
SYSINTEGERTEMPX                  EQU    1280          ; 0x500
SYSINTEGERTEMPX_H                EQU    1281          ; 0x501
SYSLCDPRINTDATAHANDLER           EQU    1457          ; 0x5B1
SYSLCDPRINTDATAHANDLER_H         EQU    1458          ; 0x5B2
SYSLONGDIVMULTA                  EQU    1459          ; 0x5B3
SYSLONGDIVMULTA_E                EQU    1462          ; 0x5B6
SYSLONGDIVMULTA_H                EQU    1460          ; 0x5B4
SYSLONGDIVMULTA_U                EQU    1461          ; 0x5B5
SYSLONGDIVMULTB                  EQU    1463          ; 0x5B7
SYSLONGDIVMULTB_E                EQU    1466          ; 0x5BA
SYSLONGDIVMULTB_H                EQU    1464          ; 0x5B8
SYSLONGDIVMULTB_U                EQU    1465          ; 0x5B9
SYSLONGDIVMULTX                  EQU    1467          ; 0x5BB
SYSLONGDIVMULTX_E                EQU    1470          ; 0x5BE
SYSLONGDIVMULTX_H                EQU    1468          ; 0x5BC
SYSLONGDIVMULTX_U                EQU    1469          ; 0x5BD
SYSLONGTEMPA                     EQU    1285          ; 0x505
SYSLONGTEMPA_E                   EQU    1288          ; 0x508
SYSLONGTEMPA_H                   EQU    1286          ; 0x506
SYSLONGTEMPA_U                   EQU    1287          ; 0x507
SYSLONGTEMPB                     EQU    1289          ; 0x509
SYSLONGTEMPB_E                   EQU    1292          ; 0x50C
SYSLONGTEMPB_H                   EQU    1290          ; 0x50A
SYSLONGTEMPB_U                   EQU    1291          ; 0x50B
SYSLONGTEMPX                     EQU    1280          ; 0x500
SYSLONGTEMPX_E                   EQU    1283          ; 0x503
SYSLONGTEMPX_H                   EQU    1281          ; 0x501
SYSLONGTEMPX_U                   EQU    1282          ; 0x502
SYSPRINTBUFFER                   EQU    4184          ; 0x1058
SYSPRINTBUFFLEN                  EQU    1471          ; 0x5BF
SYSREPEATTEMP1                   EQU    1472          ; 0x5C0
SYSREPEATTEMP4                   EQU    1473          ; 0x5C1
SYSSIGNBYTE                      EQU    1293          ; 0x50D
SYSSTRDATA                       EQU    1474          ; 0x5C2
SYSSTRINGA                       EQU    1287          ; 0x507
SYSSTRINGA_H                     EQU    1288          ; 0x508
SYSSTRINGLENGTH                  EQU    1286          ; 0x506
SYSSTRINGPARAM1                  EQU    4195          ; 0x1063
SYSSTRINGTEMP                    EQU    1475          ; 0x5C3
SYSSTRLEN                        EQU    1476          ; 0x5C4
SYSSYSINSTRING3HANDLER           EQU    1477          ; 0x5C5
SYSSYSINSTRING3HANDLER_H         EQU    1478          ; 0x5C6
SYSSYSINSTRINGHANDLER            EQU    1479          ; 0x5C7
SYSSYSINSTRINGHANDLER_H          EQU    1480          ; 0x5C8
SYSTEMP1                         EQU    1481          ; 0x5C9
SYSTEMP1_E                       EQU    1484          ; 0x5CC
SYSTEMP1_H                       EQU    1482          ; 0x5CA
SYSTEMP1_U                       EQU    1483          ; 0x5CB
SYSTEMP2                         EQU    1485          ; 0x5CD
SYSTEMP2_H                       EQU    1486          ; 0x5CE
SYSTEMP3                         EQU    1487          ; 0x5CF
SYSTEMP3_H                       EQU    1488          ; 0x5D0
SYSVALTEMP                       EQU    1489          ; 0x5D1
SYSVALTEMP_H                     EQU    1490          ; 0x5D2
SYSWAITTEMP10US                  EQU    1285          ; 0x505
SYSWAITTEMPMS                    EQU    1282          ; 0x502
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503
SYSWAITTEMPS                     EQU    1284          ; 0x504
SYSWAITTEMPUS                    EQU    1285          ; 0x505
SYSWAITTEMPUS_H                  EQU    1286          ; 0x506
SYSWORDTEMPA                     EQU    1285          ; 0x505
SYSWORDTEMPA_H                   EQU    1286          ; 0x506
SYSWORDTEMPB                     EQU    1289          ; 0x509
SYSWORDTEMPB_H                   EQU    1290          ; 0x50A
SYSWORDTEMPX                     EQU    1280          ; 0x500
SYSWORDTEMPX_H                   EQU    1281          ; 0x501
WORDNUMBER                       EQU    1491          ; 0x5D3
WORDNUMBER_H                     EQU    1492          ; 0x5D4
XCHAR                            EQU    1493          ; 0x5D5
XOFFSET                          EQU    1494          ; 0x5D6
XOFFSET_H                        EQU    1495          ; 0x5D7
XRADIUS                          EQU    1496          ; 0x5D8
XRADIUS_H                        EQU    1497          ; 0x5D9
YOFFSET                          EQU    1498          ; 0x5DA
YOFFSET_H                        EQU    1499          ; 0x5DB
YORDINATE                        EQU    1500          ; 0x5DC

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
SYSCHR_0 EQU 4310
SYSCHR_1 EQU 4311
SYSPAD_0 EQU 4228
SYSREADADBYTE EQU 1440
SYSSTR_0 EQU 4178

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
	call	HI2CINIT
	call	INITGLCD_SSD1306

;Start_of_the_main_program
;
;This demonstration program is a simple GLCD demonstration of the SSD1306 GLCD capabilities.
;
;This program is a simple GLCD demonstration of the SSD1306 GLCD capabilities.
;This program draws lines, boxes, circles and prints strings and numbers.
;The SSD1306 controller a small graphical OLED, suitable for a lot of various projects.
;The display is 38*35 mm, with an active display surface of 0.96inches, and a 128*64 pixel resolution.
;The display is easy to interface, using an I2C type of communication.
;The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;
;This version is compatible will all version of GCBASIC as this demonstration uses Full Memory GLCD mode only.  This can be adapted to Low Memory GLCD mode.
;
;************************************************************************
;@author  EvanV
;@licence GPL
;@version 1.02
;@date    01-12-2024
;
;----- Configuration
;Chip Settings.
;PIC PPS Tool version: 0.0.6.5
;Add this code segment to your GCBASIC source program
;! Optional verification of auto baud rate calculation
;! #DEFINE ISSUE_CHECK_USART_BAUD_RATE_WARNING
;
;Hardware
;-------------------PORTA----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ----------------SW----------ADC--
;----------------------------------------
;
;-------------------PORTB----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ----------------LED-LED-LED-LED--
;----------------------------------------
;
;------------------PORTC-----------------
;Bit#:  -X---6---5---4---3---2---1---0---
;IO:    -^--TX------SDA-SCL--------------
;-----VDDIO2----------------------------- You must apply correct Voltage
;
;-------------------PORTE----------------
;Bit#:  -----------------3---------------
;IO:---------------------SW-------------- INTMCLR or EXTMCLR
;
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
;Dir     RSTBUTTON     In  // this is set automatically - and, you cannot set as an output
	bsf	TRISE,3,BANKED
;Dir     SWITCHIN      In
	bsf	TRISA,3,BANKED
;Dir     RSTBUTTON     In  // this is set automatically - and, you cannot set as an output
	bsf	TRISE,3,BANKED
;Define I2C settings
;HI2CMode (Master)
	movlw	12
	banksel	HI2CCURRENTMODE
	movwf	HI2CCURRENTMODE,BANKED
	banksel	0
	call	HI2CMODE
;I2C Controls specific to 18FxxQ2x chips
;! Optional the default is 128
;! Optional the default is to issue a warning
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;----- Define variables
;These constants allow you to change the GLCD memory usage.
;We have set this demonstration to use only 128bytes of RAM for GLCD operations.
;#DEFINE GLCD_TYPE_SSD1306_LOWMEMORY_GLCD_MODE
;#DEFINE GLCD_TYPE_SSD1306_CHARACTER_MODE_ONLY
;Dim BYTENUMBER, CCOUNT As Byte
;CCount = 0
	clrf	CCOUNT,ACCESS
;Dim longNumber As Long
;max value = 4294967290
;longNumber = 0
	banksel	LONGNUMBER
	clrf	LONGNUMBER,BANKED
	clrf	LONGNUMBER_H,BANKED
	clrf	LONGNUMBER_U,BANKED
	clrf	LONGNUMBER_E,BANKED
;Dim wordNumber, adcval, ldrval As Word
;Dim outstring As String
;wordNumber = 0
	clrf	WORDNUMBER,BANKED
	clrf	WORDNUMBER_H,BANKED
;byteNumber = 0
	clrf	BYTENUMBER,ACCESS
;----- Main program
;GLCDPrint 0, 0,   "GCBASIC"
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*7
	banksel	0
	call	GLCDPRINT5
;GLCDPrint (0, 16, "Anobium 2024")
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	16
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*12
	banksel	0
	call	GLCDPRINT5
;GLCDPrint (76, 16, GLCD_WIDTH )
	movlw	76
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	16
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movlw	128
	movwf	LCDVALUE,BANKED
	clrf	LCDVALUE_H,BANKED
	clrf	LCDVALUE_U,BANKED
	clrf	LCDVALUE_E,BANKED
	banksel	0
	call	GLCDPRINT8
;GLCDPrint (96, 16, "*" )
	movlw	96
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	16
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*1
	banksel	0
	call	GLCDPRINT5
;GLCDPrint (104, 16, GLCD_HEIGHT )
	movlw	104
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	16
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movlw	64
	movwf	LCDVALUE,BANKED
	clrf	LCDVALUE_H,BANKED
	clrf	LCDVALUE_U,BANKED
	clrf	LCDVALUE_E,BANKED
	banksel	0
	call	GLCDPRINT8
;Wait 3 s
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;GLCDCLS
	call	GLCDCLS_SSD1306
;GLCDPrint 0, 0,   "Version 1.xx.xx"
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*15
	banksel	0
	call	GLCDPRINT5
;GLCDPrint (0, 16, "FULL GLCD MODE")
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	16
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable6
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*14
	banksel	0
	call	GLCDPRINT5
;Wait 3 s
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;GLCDCLS
	call	GLCDCLS_SSD1306
;Do Forever
SysDoLoop_S1
;For CCount = 31 To 127
;Legacy method
	movlw	30
	movwf	CCOUNT,ACCESS
SysForLoop1
	incf	CCOUNT,F,ACCESS
;Prepare a string
;outString = Str( CCount )
	movff	CCOUNT,SYSVALTEMP
	banksel	SYSVALTEMP_H
	clrf	SYSVALTEMP_H,BANKED
	banksel	0
	call	FN_STR
	lfsr	1,OUTSTRING
	lfsr	0,STR
	call	SYSCOPYSTRING
;adcval = ReadAD ( ANA0 )
	clrf	ADREADPORT,ACCESS
	call	FN_READAD72
	movff	SYSREADADBYTE,ADCVAL
	clrf	ADCVAL_H,ACCESS
;Prepare the static components of the screen
;Print some text
;GLCDPrint ( 1,   1, "PrintStr")
	movlw	1
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	1
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable7
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*8
	banksel	0
	call	GLCDPRINT5
;Print some more text
;GLCDPrint ( 64,  1, "@")
	movlw	64
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	1
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable8
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*1
	banksel	0
	call	GLCDPRINT5
;Print chip speed
;GLCDPrint ( 72,  1, ChipMHz)
	movlw	72
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	1
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movlw	64
	movwf	LCDVALUE,BANKED
	clrf	LCDVALUE_H,BANKED
	clrf	LCDVALUE_U,BANKED
	clrf	LCDVALUE_E,BANKED
	banksel	0
	call	GLCDPRINT8
;Print some text
;GLCDPrint ( 86, 1, "Mhz")
	movlw	86
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	1
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable9
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*3
	banksel	0
	call	GLCDPRINT5
;Draw some text
;GLCDDrawString( 1,11,"DrawStr")
	movlw	1
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	movlw	11
	movwf	CHARLOCY,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable10
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
;Using SYSSTRINGPARAM1*7
	banksel	0
	call	GLCDDRAWSTRING
;Draw a box
;Box 0,0,GLCD_WIDTH-1, GLCD_HEIGHT-1
	banksel	LINEX1
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	127
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	63
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	rcall	BOX17
;Draw a box
;Box GLCD_WIDTH-5, GLCD_HEIGHT-5,GLCD_WIDTH-1, GLCD_HEIGHT-1
	movlw	123
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	59
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	127
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	63
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	rcall	BOX17
;Draw a circle
;Circle( 44,24,5)
	movlw	44
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	24
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	5
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	movff	GLCD_YORDINATE,YORDINATE
	banksel	0
	rcall	CIRCLE20
;Draw a line
;Line 0,GLCD_HEIGHT-1,44,19
	banksel	LINEX1
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	63
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	44
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	19
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	LINE
;GLCDPrint ( 75 ,  20,  "ADC:"+Pad(Str(adcval),4 ) )
	movlw	75
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	20
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	ADCVAL,SYSVALTEMP
	movff	ADCVAL_H,SYSVALTEMP_H
	banksel	0
	call	FN_STR
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	4
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable57
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable57
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable57
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSYSINSTRING3HANDLER
	movwf	SysSYSINSTRING3Handler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRING3Handler_H,BANKED
;Using SYSSTRINGPARAM1*1
	banksel	0
	call	FN_PAD
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable11
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,PAD
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*4
	banksel	0
	call	GLCDPRINT5
;Draw a Box
;Box (3,24,6,27)
	movlw	3
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	24
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	6
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	27
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	rcall	BOX17
;Draw a string
;GLCDDrawString(44, 11, CHR(CCount)+"="+Pad(outString,3) )
	movlw	44
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	movlw	11
	movwf	CHARLOCY,ACCESS
	movff	CCOUNT,SYSCHAR
	banksel	0
	rcall	FN_CHR
	movlw	low OUTSTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high OUTSTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	3
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable57
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable57
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable57
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSYSINSTRING3HANDLER
	movwf	SysSYSINSTRING3Handler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRING3Handler_H,BANKED
;Using SYSSTRINGPARAM1*1
	banksel	0
	call	FN_PAD
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,PAD
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
;Using SYSSTRINGPARAM1*0
	banksel	0
	call	GLCDDRAWSTRING
;Ellipse 118, 6, 7, 4
	movlw	118
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	6
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	7
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movlw	4
	movwf	INYRADIUS,BANKED
	clrf	INYRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	ELLIPSE37
;If adcval > 127 Then
	movff	ADCVAL,SysWORDTempB
	movff	ADCVAL_H,SysWORDTempB_H
	movlw	127
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE1_1
;FilledEllipse 118, 6, 5, 2
	movlw	118
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	6
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	5
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movlw	2
	movwf	INYRADIUS,BANKED
	clrf	INYRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	FILLEDELLIPSE39
;Else
	bra	ENDIF1
ELSE1_1
;FilledEllipse 118, 6, 5, 2, GLCDBackground
	movlw	118
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	6
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	5
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movlw	2
	movwf	INYRADIUS,BANKED
	clrf	INYRADIUS_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	banksel	0
	call	FILLEDELLIPSE39
;End If
ENDIF1
;longNumber = longNumber + 7
	movlw	7
	banksel	LONGNUMBER
	addwf	LONGNUMBER,F,BANKED
	movlw	0
	addwfc	LONGNUMBER_H,F,BANKED
	movlw	0
	addwfc	LONGNUMBER_U,F,BANKED
	movlw	0
	addwfc	LONGNUMBER_E,F,BANKED
;Next
	movlw	127
	subwf	CCOUNT,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;End
	bra	BASPROGRAMEND
;GGLCD SSD1306 buffer is 1024bytes
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (1732)
BOX17
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF10
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
ENDIF10
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF11
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
ENDIF11
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
;Legacy method
	movlw	1
	banksel	LINEX1
	subwf	LINEX1,W,BANKED
	movwf	DRAWLINE,ACCESS
	movlw	0
	subwfb	LINEX1_H,W,BANKED
	movwf	DRAWLINE_H,ACCESS
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	banksel	0
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
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
	bra	SysForLoop5
SysForLoopEnd5
;Draw lines going down
;For DrawLine = LineY1 To LineY2
;Legacy method
	movlw	1
	banksel	LINEY1
	subwf	LINEY1,W,BANKED
	movwf	DRAWLINE,ACCESS
	movlw	0
	subwfb	LINEY1_H,W,BANKED
	movwf	DRAWLINE_H,ACCESS
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	banksel	0
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
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
	bra	SysForLoop6
SysForLoopEnd6
	return

;********************************************************************************

;Source: string.h (1156)
FN_CHR
;Empty input?
;If SysChar < 0 Then
	movlw	0
	banksel	SYSCHAR
	subwf	SYSCHAR,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF49
;Chr(0) = 0
	banksel	SYSCHR_0
	clrf	SYSCHR_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF49
;Chr(0) = 1
	movlw	1
	banksel	SYSCHR_0
	movwf	SYSCHR_0,BANKED
;Copy characters
;Chr(1) = SysChar
	movffl	SYSCHAR,SYSCHR_1
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:INTEGER:word:byte:, Source: glcd.h (1808)
CIRCLE20
;dim  radiusErr, xradius as Integer
;xradius = Inxradius
	movff	INXRADIUS,XRADIUS
	movff	INXRADIUS_H,XRADIUS_H
;radiusErr = -(xradius/2)
	movff	XRADIUS,SysINTEGERTempA
	movff	XRADIUS_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSDIVSUBINT
	movff	SysINTEGERTempA,SysTemp1
	movff	SysINTEGERTempA_H,SysTemp1_H
	banksel	SYSTEMP1
	comf	SysTemp1,W,BANKED
	movwf	RADIUSERR,BANKED
	comf	SysTemp1_H,W,BANKED
	movwf	RADIUSERR_H,BANKED
	incf	RADIUSERR,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	RADIUSERR_H,F,BANKED
;Do While xradius >=  yordinate
SysDoLoop_S3
	movff	xradius,SysINTEGERTempA
	movff	xradius_H,SysINTEGERTempA_H
	movff	yordinate,SysINTEGERTempB
	clrf	SysINTEGERTempB_H,ACCESS
	banksel	0
	call	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E3
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	YORDINATE,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	XRADIUS,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	YORDINATE,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	XRADIUS,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	YORDINATE,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	XRADIUS,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	YORDINATE,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	XRADIUS,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;yordinate ++
	banksel	YORDINATE
	incf	YORDINATE,F,BANKED
;If radiusErr < 0 Then
	movff	RADIUSERR,SysINTEGERTempA
	movff	RADIUSERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	banksel	0
	call	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE16_1
;radiusErr = radiusErr + 2 * yordinate + 1
	banksel	YORDINATE
	movf	YORDINATE,W,BANKED
	mullw	2
	movf	PRODL,W,ACCESS
	addwf	RADIUSERR,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	RADIUSERR_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	RADIUSERR,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	RADIUSERR_H,BANKED
;else
	bra	ENDIF16
ELSE16_1
;xradius --
	movlw	1
	banksel	XRADIUS
	subwf	XRADIUS,F,BANKED
	movlw	0
	subwfb	XRADIUS_H,F,BANKED
;radiusErr = radiusErr + 2 * (yordinate - xradius + 1)
	movf	XRADIUS,W,BANKED
	subwf	YORDINATE,W,BANKED
	movwf	SysTemp1,BANKED
	clrf	SysTemp2,BANKED
	movf	XRADIUS_H,W,BANKED
	subwfb	SysTemp2,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp3,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp3_H,BANKED
	movff	SysTemp3,SysINTEGERTempA
	movff	SysTemp3_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	banksel	0
	call	SYSMULTSUBINT
	movf	SysINTEGERTempX,W,ACCESS
	banksel	RADIUSERR
	addwf	RADIUSERR,F,BANKED
	movf	SysINTEGERTempX_H,W,ACCESS
	addwfc	RADIUSERR_H,F,BANKED
;end if
ENDIF16
;Loop
	bra	SysDoLoop_S3
SysDoLoop_E3
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (1063)
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
	movwf	SysTemp2,BANKED
	clrf	SysTemp2_H,BANKED
	movlw	16
	addwf	SysTemp2,W,BANKED
	movwf	POSCHARX,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	POSCHARX_H,BANKED
;Write_Command_SSD1306 ( PosCharX )
	movff	POSCHARX,SSD1306SENDBYTE
	banksel	0
	goto	WRITE_COMMAND_SSD1306

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (4111)
DRAWELLIPSEROUTINE41
;Version 1.00 (08/20/2017) by Joseph Realmuto
;Version 1.01 (14/04/2019) by Giuseppe D'Elia
;draws an ellipse outline at location (xoffset, yoffset) if filled_ellipse = 0
;draws a filled ellipse at location (xoffset, yoffset) if filled_ellipse = 1
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;IF Inxradius = Inyradius THEN
;IF filled_ellipse = 0 THEN
;Circle Xoffset, Yoffset, Inxradius, LineColour
;ELSE
;FilledCircle Xoffset, Yoffset, Inxradius, LineColour
;END IF
;GLCD_exit sub
;END IF
;IF Inxradius<2 THEN exit sub
	movff	INXRADIUS,SysWORDTempA
	movff	INXRADIUS_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
;IF Inxradius<2 THEN exit sub
	return
;IF Inxradius<2 THEN exit sub
;IF Inyradius<2 THEN exit sub
	movff	INYRADIUS,SysWORDTempA
	movff	INYRADIUS_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
;IF Inyradius<2 THEN exit sub
	return
;IF Inyradius<2 THEN exit sub
;dim GLCD_xx, GLCD_yy, GLCD_rx2, GLCD_ry2 as Word
;dim  GLCD_fx2, GLCD_fy2, GLCD_ex2, GLCD_ey2 as Long
;dim GLCD_px, GLCD_py, GLCD_pp, GLCD_pp_temp as Long
;GLCD_rx2 = Inxradius * Inxradius
	movff	INXRADIUS,SysWORDTempA
	movff	INXRADIUS_H,SysWORDTempA_H
	movff	INXRADIUS,SysWORDTempB
	movff	INXRADIUS_H,SysWORDTempB_H
	call	SYSMULTSUB16
	movff	SysWORDTempX,GLCD_RX2
	movff	SysWORDTempX_H,GLCD_RX2_H
;GLCD_ry2 = Inyradius * Inyradius
	movff	INYRADIUS,SysWORDTempA
	movff	INYRADIUS_H,SysWORDTempA_H
	movff	INYRADIUS,SysWORDTempB
	movff	INYRADIUS_H,SysWORDTempB_H
	call	SYSMULTSUB16
	movff	SysWORDTempX,GLCD_RY2
	movff	SysWORDTempX_H,GLCD_RY2_H
;GLCD_fx2 = 4 * GLCD_rx2
;GLCD_fx2 = GLCD_rx2 + GLCD_rx2
	movf	GLCD_RX2,W,ACCESS
	addwf	GLCD_RX2,W,ACCESS
	movwf	GLCD_FX2,ACCESS
	movf	GLCD_RX2_H,W,ACCESS
	addwfc	GLCD_RX2_H,W,ACCESS
	movwf	GLCD_FX2_H,ACCESS
	clrf	GLCD_FX2_U,ACCESS
	btfsc	STATUS,C,ACCESS
	incf	GLCD_FX2_U,F,ACCESS
	clrf	GLCD_FX2_E,ACCESS
;GLCD_fx2 = GLCD_fx2 + GLCD_fx2
	movf	GLCD_FX2,W,ACCESS
	addwf	GLCD_FX2,F,ACCESS
	movf	GLCD_FX2_H,W,ACCESS
	addwfc	GLCD_FX2_H,F,ACCESS
	movf	GLCD_FX2_U,W,ACCESS
	addwfc	GLCD_FX2_U,F,ACCESS
	movf	GLCD_FX2_E,W,ACCESS
	addwfc	GLCD_FX2_E,F,ACCESS
;GLCD_fy2 = 4 * GLCD_ry2
;GLCD_fy2 = GLCD_ry2 + GLCD_ry2
	movf	GLCD_RY2,W,ACCESS
	addwf	GLCD_RY2,W,ACCESS
	movwf	GLCD_FY2,ACCESS
	movf	GLCD_RY2_H,W,ACCESS
	addwfc	GLCD_RY2_H,W,ACCESS
	movwf	GLCD_FY2_H,ACCESS
	clrf	GLCD_FY2_U,ACCESS
	btfsc	STATUS,C,ACCESS
	incf	GLCD_FY2_U,F,ACCESS
	clrf	GLCD_FY2_E,ACCESS
;GLCD_fy2 = GLCD_fy2 + GLCD_fy2
	movf	GLCD_FY2,W,ACCESS
	addwf	GLCD_FY2,F,ACCESS
	movf	GLCD_FY2_H,W,ACCESS
	addwfc	GLCD_FY2_H,F,ACCESS
	movf	GLCD_FY2_U,W,ACCESS
	addwfc	GLCD_FY2_U,F,ACCESS
	movf	GLCD_FY2_E,W,ACCESS
	addwfc	GLCD_FY2_E,F,ACCESS
;GLCD_ex2 = 2 * GLCD_fx2
;GLCD_ex2 = GLCD_fx2 + GLCD_fx2
	movf	GLCD_FX2,W,ACCESS
	addwf	GLCD_FX2,W,ACCESS
	movwf	GLCD_EX2,ACCESS
	movf	GLCD_FX2_H,W,ACCESS
	addwfc	GLCD_FX2_H,W,ACCESS
	movwf	GLCD_EX2_H,ACCESS
	movf	GLCD_FX2_U,W,ACCESS
	addwfc	GLCD_FX2_U,W,ACCESS
	movwf	GLCD_EX2_U,ACCESS
	movf	GLCD_FX2_E,W,ACCESS
	addwfc	GLCD_FX2_E,W,ACCESS
	movwf	GLCD_EX2_E,ACCESS
;GLCD_ey2 = 2 * GLCD_fy2
;GLCD_ey2 = GLCD_fy2 + GLCD_fy2
	movf	GLCD_FY2,W,ACCESS
	addwf	GLCD_FY2,W,ACCESS
	movwf	GLCD_EY2,ACCESS
	movf	GLCD_FY2_H,W,ACCESS
	addwfc	GLCD_FY2_H,W,ACCESS
	movwf	GLCD_EY2_H,ACCESS
	movf	GLCD_FY2_U,W,ACCESS
	addwfc	GLCD_FY2_U,W,ACCESS
	movwf	GLCD_EY2_U,ACCESS
	movf	GLCD_FY2_E,W,ACCESS
	addwfc	GLCD_FY2_E,W,ACCESS
	movwf	GLCD_EY2_E,ACCESS
;GLCD_xx = 0
	clrf	GLCD_XX,ACCESS
	clrf	GLCD_XX_H,ACCESS
;GLCD_yy = Inyradius
	movff	INYRADIUS,GLCD_YY
	movff	INYRADIUS_H,GLCD_YY_H
;GLCD_px = 0
	clrf	GLCD_PX,ACCESS
	clrf	GLCD_PX_H,ACCESS
	clrf	GLCD_PX_U,ACCESS
	clrf	GLCD_PX_E,ACCESS
;GLCD_py = GLCD_ex2 * GLCD_yy
	movff	GLCD_EX2,SysLONGTempA
	movff	GLCD_EX2_H,SysLONGTempA_H
	movff	GLCD_EX2_U,SysLONGTempA_U
	movff	GLCD_EX2_E,SysLONGTempA_E
	movff	GLCD_YY,SysLONGTempB
	movff	GLCD_YY_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSMULTSUB32
	movff	SysLONGTempX,GLCD_PY
	movff	SysLONGTempX_H,GLCD_PY_H
	movff	SysLONGTempX_U,GLCD_PY_U
	movff	SysLONGTempX_E,GLCD_PY_E
;GLCD_pp = 2 + GLCD_fy2 -  GLCD_fx2 * Inyradius + GLCD_rx2
;GLCD_pp_temp = GLCD_fx2 * Inyradius
	movff	GLCD_FX2,SysLONGTempA
	movff	GLCD_FX2_H,SysLONGTempA_H
	movff	GLCD_FX2_U,SysLONGTempA_U
	movff	GLCD_FX2_E,SysLONGTempA_E
	movff	INYRADIUS,SysLONGTempB
	movff	INYRADIUS_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSMULTSUB32
	movff	SysLONGTempX,GLCD_PP_TEMP
	movff	SysLONGTempX_H,GLCD_PP_TEMP_H
	movff	SysLONGTempX_U,GLCD_PP_TEMP_U
	movff	SysLONGTempX_E,GLCD_PP_TEMP_E
;GLCD_pp = 2 + GLCD_fy2
	movlw	2
	addwf	GLCD_FY2,W,ACCESS
	movwf	GLCD_PP,ACCESS
	movlw	0
	addwfc	GLCD_FY2_H,W,ACCESS
	movwf	GLCD_PP_H,ACCESS
	movlw	0
	addwfc	GLCD_FY2_U,W,ACCESS
	movwf	GLCD_PP_U,ACCESS
	movlw	0
	addwfc	GLCD_FY2_E,W,ACCESS
	movwf	GLCD_PP_E,ACCESS
;GLCD_pp = GLCD_pp + GLCD_rx2
	movf	GLCD_RX2,W,ACCESS
	addwf	GLCD_PP,F,ACCESS
	movf	GLCD_RX2_H,W,ACCESS
	addwfc	GLCD_PP_H,F,ACCESS
	movlw	0
	addwfc	GLCD_PP_U,F,ACCESS
	movlw	0
	addwfc	GLCD_PP_E,F,ACCESS
;GLCD_pp = GLCD_pp - GLCD_pp_temp
	movf	GLCD_PP_TEMP,W,ACCESS
	subwf	GLCD_PP,F,ACCESS
	movf	GLCD_PP_TEMP_H,W,ACCESS
	subwfb	GLCD_PP_H,F,ACCESS
	movf	GLCD_PP_TEMP_U,W,ACCESS
	subwfb	GLCD_PP_U,F,ACCESS
	movf	GLCD_PP_TEMP_E,W,ACCESS
	subwfb	GLCD_PP_E,F,ACCESS
;IF filled_ellipse = 0 THEN
	movf	FILLED_ELLIPSE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE24_1
;Draw_Ellipse_Points
	rcall	DRAW_ELLIPSE_POINTS
;ELSE
	bra	ENDIF24
ELSE24_1
;Draw_Filled_Ellipse_Points
	rcall	DRAW_FILLED_ELLIPSE_POINTS
;END IF
ENDIF24
;DO WHILE GLCD_px < GLCD_py
SysDoLoop_S6
	movff	glcd_px,SysLONGTempA
	movff	glcd_px_H,SysLONGTempA_H
	movff	glcd_px_U,SysLONGTempA_U
	movff	glcd_px_E,SysLONGTempA_E
	movff	glcd_py,SysLONGTempB
	movff	glcd_py_H,SysLONGTempB_H
	movff	glcd_py_U,SysLONGTempB_U
	movff	glcd_py_E,SysLONGTempB_E
	call	SYSCOMPLESSTHAN32
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E6
;GLCD_xx++
	incf	GLCD_XX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	GLCD_XX_H,F,ACCESS
;GLCD_px = GLCD_px + GLCD_ey2
	movf	GLCD_EY2,W,ACCESS
	addwf	GLCD_PX,F,ACCESS
	movf	GLCD_EY2_H,W,ACCESS
	addwfc	GLCD_PX_H,F,ACCESS
	movf	GLCD_EY2_U,W,ACCESS
	addwfc	GLCD_PX_U,F,ACCESS
	movf	GLCD_EY2_E,W,ACCESS
	addwfc	GLCD_PX_E,F,ACCESS
;IF GLCD_pp_E.7 = 0 THEN
	btfsc	GLCD_PP_E,7,ACCESS
	bra	ENDIF25
;GLCD_yy--
	movlw	1
	banksel	GLCD_YY
	subwf	GLCD_YY,F,BANKED
	movlw	0
	subwfb	GLCD_YY_H,F,BANKED
;GLCD_py = GLCD_py - GLCD_ex2
	movf	GLCD_EX2,W,ACCESS
	subwf	GLCD_PY,F,ACCESS
	movf	GLCD_EX2_H,W,ACCESS
	subwfb	GLCD_PY_H,F,ACCESS
	movf	GLCD_EX2_U,W,ACCESS
	subwfb	GLCD_PY_U,F,ACCESS
	movf	GLCD_EX2_E,W,ACCESS
	subwfb	GLCD_PY_E,F,ACCESS
;GLCD_pp = GLCD_pp - GLCD_py
	movf	GLCD_PY,W,ACCESS
	subwf	GLCD_PP,F,ACCESS
	movf	GLCD_PY_H,W,ACCESS
	subwfb	GLCD_PP_H,F,ACCESS
	movf	GLCD_PY_U,W,ACCESS
	subwfb	GLCD_PP_U,F,ACCESS
	movf	GLCD_PY_E,W,ACCESS
	subwfb	GLCD_PP_E,F,ACCESS
;END IF
ENDIF25
;GLCD_pp = GLCD_pp + GLCD_fy2 + GLCD_px
;GLCD_pp = GLCD_pp + GLCD_fy2
	movf	GLCD_FY2,W,ACCESS
	addwf	GLCD_PP,F,ACCESS
	movf	GLCD_FY2_H,W,ACCESS
	addwfc	GLCD_PP_H,F,ACCESS
	movf	GLCD_FY2_U,W,ACCESS
	addwfc	GLCD_PP_U,F,ACCESS
	movf	GLCD_FY2_E,W,ACCESS
	addwfc	GLCD_PP_E,F,ACCESS
;GLCD_pp = GLCD_pp + GLCD_px
	movf	GLCD_PX,W,ACCESS
	addwf	GLCD_PP,F,ACCESS
	movf	GLCD_PX_H,W,ACCESS
	addwfc	GLCD_PP_H,F,ACCESS
	movf	GLCD_PX_U,W,ACCESS
	addwfc	GLCD_PP_U,F,ACCESS
	movf	GLCD_PX_E,W,ACCESS
	addwfc	GLCD_PP_E,F,ACCESS
;IF filled_ellipse = 0 THEN
	movf	FILLED_ELLIPSE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE26_1
;Draw_Ellipse_Points
	banksel	0
	rcall	DRAW_ELLIPSE_POINTS
;ELSE
	bra	ENDIF26
ELSE26_1
;Draw_Filled_Ellipse_Points
	banksel	0
	rcall	DRAW_FILLED_ELLIPSE_POINTS
;END IF
ENDIF26
;LOOP
	bra	SysDoLoop_S6
SysDoLoop_E6
;GLCD_pp = 2 + GLCD_ry2 * (2 * GLCD_xx + 1) * (2 * GLCD_xx + 1) + GLCD_fx2 * (GLCD_yy - 1) * (GLCD_yy - 1) -  GLCD_fx2 * GLCD_ry2
;change GLCD_xx and GLCD_yy to do calculation
;GLCD_xx = GLCD_xx + GLCD_xx
	movf	GLCD_XX,W,ACCESS
	addwf	GLCD_XX,F,ACCESS
	movf	GLCD_XX_H,W,ACCESS
	addwfc	GLCD_XX_H,F,ACCESS
;GLCD_xx++
	incf	GLCD_XX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	GLCD_XX_H,F,ACCESS
;GLCD_yy--
	movlw	1
	banksel	GLCD_YY
	subwf	GLCD_YY,F,BANKED
	movlw	0
	subwfb	GLCD_YY_H,F,BANKED
;GLCD_pp_temp = GLCD_xx * GLCD_xx
	movff	GLCD_XX,SysLONGTempA
	movff	GLCD_XX_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	GLCD_XX,SysLONGTempB
	movff	GLCD_XX_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	call	SYSMULTSUB32
	movff	SysLONGTempX,GLCD_PP_TEMP
	movff	SysLONGTempX_H,GLCD_PP_TEMP_H
	movff	SysLONGTempX_U,GLCD_PP_TEMP_U
	movff	SysLONGTempX_E,GLCD_PP_TEMP_E
;GLCD_pp_temp = GLCD_ry2 * GLCD_pp_temp
	movff	GLCD_RY2,SysLONGTempA
	movff	GLCD_RY2_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	GLCD_PP_TEMP,SysLONGTempB
	movff	GLCD_PP_TEMP_H,SysLONGTempB_H
	movff	GLCD_PP_TEMP_U,SysLONGTempB_U
	movff	GLCD_PP_TEMP_E,SysLONGTempB_E
	call	SYSMULTSUB32
	movff	SysLONGTempX,GLCD_PP_TEMP
	movff	SysLONGTempX_H,GLCD_PP_TEMP_H
	movff	SysLONGTempX_U,GLCD_PP_TEMP_U
	movff	SysLONGTempX_E,GLCD_PP_TEMP_E
;GLCD_pp = 2 + GLCD_pp_temp
	movlw	2
	addwf	GLCD_PP_TEMP,W,ACCESS
	movwf	GLCD_PP,ACCESS
	movlw	0
	addwfc	GLCD_PP_TEMP_H,W,ACCESS
	movwf	GLCD_PP_H,ACCESS
	movlw	0
	addwfc	GLCD_PP_TEMP_U,W,ACCESS
	movwf	GLCD_PP_U,ACCESS
	movlw	0
	addwfc	GLCD_PP_TEMP_E,W,ACCESS
	movwf	GLCD_PP_E,ACCESS
;GLCD_pp_temp = GLCD_yy * GLCD_yy
	movff	GLCD_YY,SysLONGTempA
	movff	GLCD_YY_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	GLCD_YY,SysLONGTempB
	movff	GLCD_YY_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSMULTSUB32
	movff	SysLONGTempX,GLCD_PP_TEMP
	movff	SysLONGTempX_H,GLCD_PP_TEMP_H
	movff	SysLONGTempX_U,GLCD_PP_TEMP_U
	movff	SysLONGTempX_E,GLCD_PP_TEMP_E
;GLCD_pp_temp = GLCD_fx2 * GLCD_pp_temp
	movff	GLCD_FX2,SysLONGTempA
	movff	GLCD_FX2_H,SysLONGTempA_H
	movff	GLCD_FX2_U,SysLONGTempA_U
	movff	GLCD_FX2_E,SysLONGTempA_E
	movff	GLCD_PP_TEMP,SysLONGTempB
	movff	GLCD_PP_TEMP_H,SysLONGTempB_H
	movff	GLCD_PP_TEMP_U,SysLONGTempB_U
	movff	GLCD_PP_TEMP_E,SysLONGTempB_E
	call	SYSMULTSUB32
	movff	SysLONGTempX,GLCD_PP_TEMP
	movff	SysLONGTempX_H,GLCD_PP_TEMP_H
	movff	SysLONGTempX_U,GLCD_PP_TEMP_U
	movff	SysLONGTempX_E,GLCD_PP_TEMP_E
;GLCD_pp = GLCD_pp + GLCD_pp_temp
	movf	GLCD_PP_TEMP,W,ACCESS
	addwf	GLCD_PP,F,ACCESS
	movf	GLCD_PP_TEMP_H,W,ACCESS
	addwfc	GLCD_PP_H,F,ACCESS
	movf	GLCD_PP_TEMP_U,W,ACCESS
	addwfc	GLCD_PP_U,F,ACCESS
	movf	GLCD_PP_TEMP_E,W,ACCESS
	addwfc	GLCD_PP_E,F,ACCESS
;GLCD_pp_temp = GLCD_fx2 * GLCD_ry2
	movff	GLCD_FX2,SysLONGTempA
	movff	GLCD_FX2_H,SysLONGTempA_H
	movff	GLCD_FX2_U,SysLONGTempA_U
	movff	GLCD_FX2_E,SysLONGTempA_E
	movff	GLCD_RY2,SysLONGTempB
	movff	GLCD_RY2_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSMULTSUB32
	movff	SysLONGTempX,GLCD_PP_TEMP
	movff	SysLONGTempX_H,GLCD_PP_TEMP_H
	movff	SysLONGTempX_U,GLCD_PP_TEMP_U
	movff	SysLONGTempX_E,GLCD_PP_TEMP_E
;GLCD_pp = GLCD_pp - GLCD_pp_temp
	movf	GLCD_PP_TEMP,W,ACCESS
	subwf	GLCD_PP,F,ACCESS
	movf	GLCD_PP_TEMP_H,W,ACCESS
	subwfb	GLCD_PP_H,F,ACCESS
	movf	GLCD_PP_TEMP_U,W,ACCESS
	subwfb	GLCD_PP_U,F,ACCESS
	movf	GLCD_PP_TEMP_E,W,ACCESS
	subwfb	GLCD_PP_E,F,ACCESS
;restore original GLCD_xx and GLCD_yy values
;GLCD_xx--
	movlw	1
	subwf	GLCD_XX,F,ACCESS
	movlw	0
	subwfb	GLCD_XX_H,F,ACCESS
;GLCD_xx/2
;set C off
	bcf	STATUS,C,ACCESS
;rotate GLCD_xx_H right
	rrcf	GLCD_XX_H,F,ACCESS
;rotate GLCD_xx right
	rrcf	GLCD_XX_H,F,ACCESS
	rrcf	GLCD_XX,F,ACCESS
;GLCD_yy++
	banksel	GLCD_YY
	incf	GLCD_YY,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	GLCD_YY_H,F,BANKED
;DO WHILE GLCD_yy > 0
SysDoLoop_S7
	movff	glcd_yy,SysWORDTempB
	movff	glcd_yy_H,SysWORDTempB_H
	clrf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E7
;GLCD_yy--
	movlw	1
	banksel	GLCD_YY
	subwf	GLCD_YY,F,BANKED
	movlw	0
	subwfb	GLCD_YY_H,F,BANKED
;GLCD_py = GLCD_py - GLCD_ex2
	movf	GLCD_EX2,W,ACCESS
	subwf	GLCD_PY,F,ACCESS
	movf	GLCD_EX2_H,W,ACCESS
	subwfb	GLCD_PY_H,F,ACCESS
	movf	GLCD_EX2_U,W,ACCESS
	subwfb	GLCD_PY_U,F,ACCESS
	movf	GLCD_EX2_E,W,ACCESS
	subwfb	GLCD_PY_E,F,ACCESS
;IF GLCD_pp_E.7 = 1 THEN
	btfss	GLCD_PP_E,7,ACCESS
	bra	ENDIF27
;GLCD_xx++
	incf	GLCD_XX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	GLCD_XX_H,F,ACCESS
;GLCD_px = GLCD_px + GLCD_ey2
	movf	GLCD_EY2,W,ACCESS
	addwf	GLCD_PX,F,ACCESS
	movf	GLCD_EY2_H,W,ACCESS
	addwfc	GLCD_PX_H,F,ACCESS
	movf	GLCD_EY2_U,W,ACCESS
	addwfc	GLCD_PX_U,F,ACCESS
	movf	GLCD_EY2_E,W,ACCESS
	addwfc	GLCD_PX_E,F,ACCESS
;GLCD_pp = GLCD_pp + GLCD_px
	movf	GLCD_PX,W,ACCESS
	addwf	GLCD_PP,F,ACCESS
	movf	GLCD_PX_H,W,ACCESS
	addwfc	GLCD_PP_H,F,ACCESS
	movf	GLCD_PX_U,W,ACCESS
	addwfc	GLCD_PP_U,F,ACCESS
	movf	GLCD_PX_E,W,ACCESS
	addwfc	GLCD_PP_E,F,ACCESS
;END IF
ENDIF27
;GLCD_pp = GLCD_pp + GLCD_fx2 - GLCD_py
;GLCD_pp = GLCD_pp + GLCD_fx2
	movf	GLCD_FX2,W,ACCESS
	addwf	GLCD_PP,F,ACCESS
	movf	GLCD_FX2_H,W,ACCESS
	addwfc	GLCD_PP_H,F,ACCESS
	movf	GLCD_FX2_U,W,ACCESS
	addwfc	GLCD_PP_U,F,ACCESS
	movf	GLCD_FX2_E,W,ACCESS
	addwfc	GLCD_PP_E,F,ACCESS
;GLCD_pp = GLCD_pp - GLCD_py
	movf	GLCD_PY,W,ACCESS
	subwf	GLCD_PP,F,ACCESS
	movf	GLCD_PY_H,W,ACCESS
	subwfb	GLCD_PP_H,F,ACCESS
	movf	GLCD_PY_U,W,ACCESS
	subwfb	GLCD_PP_U,F,ACCESS
	movf	GLCD_PY_E,W,ACCESS
	subwfb	GLCD_PP_E,F,ACCESS
;IF filled_ellipse = 0 THEN
	movf	FILLED_ELLIPSE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE28_1
;Draw_Ellipse_Points
	banksel	0
	rcall	DRAW_ELLIPSE_POINTS
;ELSE
	bra	ENDIF28
ELSE28_1
;Draw_Filled_Ellipse_Points
	banksel	0
	rcall	DRAW_FILLED_ELLIPSE_POINTS
;END IF
ENDIF28
;LOOP
	bra	SysDoLoop_S7
SysDoLoop_E7
	return

;********************************************************************************

;Source: glcd.h (4378)
DRAW_ELLIPSE_POINTS
;dim LineColour as Long
;Pset ((xoffset + GLCD_xx), (yoffset + GLCD_yy), LineColour)
	movf	GLCD_XX,W,ACCESS
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	GLCD_YY,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;Pset ((xoffset - GLCD_xx), (yoffset + GLCD_yy), LineColour)
	movf	GLCD_XX,W,ACCESS
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	GLCD_YY,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;Pset ((xoffset - GLCD_xx), (yoffset - GLCD_yy), LineColour)
	movf	GLCD_XX,W,ACCESS
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	GLCD_YY,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;Pset ((xoffset + GLCD_xx), (yoffset - GLCD_yy), LineColour)
	movf	GLCD_XX,W,ACCESS
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	GLCD_YY,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	goto	PSET_SSD1306

;********************************************************************************

;Source: glcd.h (4387)
DRAW_FILLED_ELLIPSE_POINTS
;dim LineColour as Long
;FOR GLCD_yy1 = (yoffset) to (yoffset + 2 * GLCD_yy)
;Legacy method
	banksel	YOFFSET
	decf	YOFFSET,W,BANKED
	movwf	GLCD_YY1,BANKED
	movf	GLCD_YY,W,BANKED
	mullw	2
	movff	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	SysTemp2,BANKED
	movff	YOFFSET,SysBYTETempB
	movff	SysTemp2,SysBYTETempA
	banksel	0
	call	SYSCOMPLESSTHAN
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd7
SysForLoop7
	banksel	GLCD_YY1
	incf	GLCD_YY1,F,BANKED
;Pset ((xoffset + GLCD_xx), (GLCD_yy1 - GLCD_yy), LineColour)
	movf	GLCD_XX,W,ACCESS
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	GLCD_YY,W,BANKED
	subwf	GLCD_YY1,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;Pset ((xoffset - GLCD_xx), (GLCD_yy1 - GLCD_yy), LineColour)
	movf	GLCD_XX,W,ACCESS
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	GLCD_YY,W,BANKED
	subwf	GLCD_YY1,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;NEXT
	banksel	GLCD_YY
	movf	GLCD_YY,W,BANKED
	mullw	2
	movff	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	SysTemp2,BANKED
	movff	GLCD_YY1,SysBYTETempA
	movff	SysTemp2,SysBYTETempB
	banksel	0
	call	SYSCOMPLESSTHAN
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
	return

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

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (4063)
ELLIPSE37
;Version 1.00 (08/20/2017) by Joseph Realmuto
;draws an ellipse outline at location (xoffset, yoffset)
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;filled_ellipse = 0
	clrf	FILLED_ELLIPSE,ACCESS
;DrawEllipseRoutine( xoffset, yoffset, Inxradius, Inyradius, LineColour )
	bra	DRAWELLIPSEROUTINE41

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (4087)
FILLEDELLIPSE39
;Version 1.00 (08/20/2017) by Joseph Realmuto
;draws a filled ellipse at location (xoffset, yoffset)
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;filled_ellipse = 1
	movlw	1
	movwf	FILLED_ELLIPSE,ACCESS
;DrawEllipseRoutine( xoffset, yoffset, Inxradius, Inyradius, LineColour )
	bra	DRAWELLIPSEROUTINE41

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

;Source: GLCD_SSD1306.H (442)
GLCDCLS_SSD1306
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	banksel	GLCD_YORDINATE
	clrf	GLCD_YORDINATE,BANKED
	clrf	GLCD_YORDINATE_H,BANKED
;For SSD1306_BufferLocationCalc = 1 to GLCD_HEIGHT * GLCD_WIDTH / 8
;Legacy method
	clrf	SSD1306_BUFFERLOCATIONCALC,BANKED
	clrf	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SysForLoop11
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
	bra	SysForLoop11
SysForLoopEnd11
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	banksel	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC,BANKED
	clrf	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SysForLoop12
;Init SysForLoopStep11 :#0
	movlw	8
	movwf	SysForLoopStep11,BANKED
	clrf	SysForLoopStep11_H,BANKED
;Cursor_Position_SSD1306 ( 0 , SSD1306_BufferLocationCalc )
	clrf	LOCX,BANKED
	movff	SSD1306_BUFFERLOCATIONCALC,LOCY
	banksel	0
	call	CURSOR_POSITION_SSD1306
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1241)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	call	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	banksel	I2CBYTE
	movwf	I2CBYTE,BANKED
	banksel	0
	rcall	HI2CQ24SEND
;HI2CSend 0x40
	movlw	64
	banksel	I2CBYTE
	movwf	I2CBYTE,BANKED
	banksel	0
	rcall	HI2CQ24SEND
;For GLCDTemp = 0 to 127
;Legacy method
	setf	GLCDTEMP,ACCESS
SysForLoop13
	incf	GLCDTEMP,F,ACCESS
;Write_Transaction_Data_SSD1306(GLCDBackground)
;Macro Source: GLCD_SSD1306.H (1272)
;HI2CSend SSD1306SendByte
	movff	GLCDBACKGROUND,I2CBYTE
	rcall	HI2CQ24SEND
;Next
	movlw	127
	subwf	GLCDTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop13
SysForLoopEnd13
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1305)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	rcall	HI2CQ24STOP
;Next
;Integer negative Step Handler in For-next statement
	banksel	SYSFORLOOPSTEP11_H
	btfss	SYSFORLOOPSTEP11_H,7,BANKED
	bra	ELSE60_1
;Set SysForLoopABsValue to -StepValue :#1 
	comf	SYSFORLOOPSTEP11,W,BANKED
	movwf	SysForLoopABsValue12,BANKED
	comf	SYSFORLOOPSTEP11_H,W,BANKED
	movwf	SysForLoopABsValue12_H,BANKED
	incf	SysForLoopABsValue12,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SysForLoopABsValue12_H,F,BANKED
;IF ( SSD1306_BUFFERLOCATIONCALC - 64-1) } [WORD]SysForLoopABsValue12 THEN  :#1n 
	movlw	64
	subwf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	subwfb	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	subwf	SysTemp2,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	subwfb	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movff	SYSFORLOOPABSVALUE12,SysWORDTempB
	movff	SYSFORLOOPABSVALUE12_H,SysWORDTempB_H
	banksel	0
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF61
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	banksel	SYSFORLOOPSTEP11
	movf	SysForLoopStep11,W,BANKED
	addwf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	movf	SysForLoopStep11_H,W,BANKED
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
	bra	SysForLoop12
;END IF
ENDIF61
	bra	ENDIF60
ELSE60_1
;Integer positive Step Handler in For-next statement
;IF ([WORD]64-1 - [WORD]SSD1306_BUFFERLOCATIONCALC) } [WORD]SysForLoopStep11 THEN :#1p 
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	sublw	63
	movwf	SysTemp2,BANKED
	clrf	SysTemp1,BANKED
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	subwfb	SysTemp1,W,BANKED
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movff	SYSFORLOOPSTEP11,SysWORDTempB
	movff	SYSFORLOOPSTEP11_H,SysWORDTempB_H
	banksel	0
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF62
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	banksel	SYSFORLOOPSTEP11
	movf	SysForLoopStep11,W,BANKED
	addwf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	movf	SysForLoopStep11_H,W,BANKED
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
	bra	SysForLoop12
;END IF
ENDIF62
;END IF
ENDIF60
SysForLoopEnd12
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
	call	CURSOR_POSITION_SSD1306
;PrintLocX =0
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
;PrintLocY =0
	clrf	PRINTLOCY,BANKED
	banksel	0
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (490)
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
	bra	ENDIF63
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 0
	clrf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;end if
ENDIF63
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
	call	CURSOR_POSITION_SSD1306
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
	bra	ENDIF64
;CharLocY=CharLocY-1
	movlw	1
	subwf	CHARLOCY,F,ACCESS
	movlw	0
	subwfb	CHARLOCY_H,F,ACCESS
;end if
ENDIF64
;For CurrCharCol = 1 to 5
;Legacy method
	clrf	CURRCHARCOL,ACCESS
SysForLoop14
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
SysForLoop15
	incf	CURRCHARROW,F,ACCESS
;CharColS=0
	clrf	CHARCOLS,ACCESS
;For Col=1 to GLCDfntDefaultsize
;Legacy method
	clrf	COL,ACCESS
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd16
SysForLoop16
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
	bra	SysForLoopEnd17
SysForLoop17
	incf	ROW,F,BANKED
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0,ACCESS
	bra	ELSE67_1
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
	call	PSET_SSD1306
;Else
	bra	ENDIF67
ELSE67_1
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
	call	PSET_SSD1306
;End if
ENDIF67
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
	call	PSET_SSD1306
;CharRowS +=1
	incf	CHARROWS,F,ACCESS
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	banksel	ROW
	subwf	ROW,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop17
SysForLoopEnd17
;CharColS +=1
	incf	CHARCOLS,F,ACCESS
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	subwf	COL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop16
SysForLoopEnd16
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
	bra	SysForLoop15
SysForLoopEnd15
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
	bra	SysForLoop14
SysForLoopEnd14
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

;Source: glcd.h (1528)
GLCDDRAWSTRING
;dim GLCDPrintLoc as word
;GLCDPrintLoc = StringLocX
	movff	STRINGLOCX,GLCDPRINTLOC
	clrf	GLCDPRINTLOC_H,ACCESS
;for xchar = 1 to Chars(0)
;Legacy method
	banksel	XCHAR
	clrf	XCHAR,BANKED
	movff	SysCHARSHandler,AFSR0
	movff	SysCHARSHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
	incf	XCHAR,F,BANKED
;GLCDDrawChar GLCDPrintLoc , CharLocY , Chars(xchar), LineColour
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movf	XCHAR,W,BANKED
	addwf	SysCHARSHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysCHARSHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,CHARCODE
	banksel	0
	rcall	GLCDDRAWCHAR_SSD1306
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1462)
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
;next
	movff	SysCHARSHandler,AFSR0
	movff	SysCHARSHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	XCHAR,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (1225)
GLCDPRINT5
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
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
	bra	SysForLoopEnd2
SysForLoop2
	incf	GLCDPRINT_STRING_COUNTER,F,ACCESS
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
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
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	rcall	GLCDDRAWCHAR_SSD1306
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1462)
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
	bra	SysForLoop2
SysForLoopEnd2
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:LONG:, Source: glcd.h (1337)
GLCDPRINT8
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	banksel	SYSPRINTBUFFLEN
	clrf	SYSPRINTBUFFLEN,BANKED
;Do
SysDoLoop_S2
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	banksel	SYSPRINTBUFFLEN
	incf	SYSPRINTBUFFLEN,F,BANKED
;SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
	lfsr	0,SYSPRINTBUFFER
	movf	SYSPRINTBUFFLEN,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	LCDVALUE,SysLONGTempA
	movff	LCDVALUE_H,SysLONGTempA_H
	movff	LCDVALUE_U,SysLONGTempA_U
	movff	LCDVALUE_E,SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	call	SYSDIVSUB32
	movff	SysLONGTempX,INDF0
;LCDValue = SysCalcTempA
	movff	SYSCALCTEMPA,LCDVALUE
	movff	SYSCALCTEMPA_H,LCDVALUE_H
	movff	SYSCALCTEMPA_U,LCDVALUE_U
	movff	SYSCALCTEMPA_E,LCDVALUE_E
;Loop While LCDValue <> 0
	movff	lcdvalue,SysLONGTempA
	movff	lcdvalue_H,SysLONGTempA_H
	movff	lcdvalue_U,SysLONGTempA_U
	movff	lcdvalue_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSCOMPEQUAL32
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
	bra	SysDoLoop_S2
SysDoLoop_E2
;Display
;GLCDPrintLoc = PrintLocX
	movff	PRINTLOCX,GLCDPRINTLOC
	movff	PRINTLOCX_H,GLCDPRINTLOC_H
;For GLCDPrint_String_Counter = SysPrintBuffLen To 1 Step -1
;Legacy method
	banksel	SYSPRINTBUFFLEN
	incf	SYSPRINTBUFFLEN,W,BANKED
	movwf	GLCDPRINT_STRING_COUNTER,ACCESS
	movlw	1
	subwf	SYSPRINTBUFFLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
SysForLoop3
	decf	GLCDPRINT_STRING_COUNTER,F,ACCESS
;GLCDDrawChar GLCDPrintLoc, PrintLocY, SysPrintBuffer(GLCDPrint_String_Counter) + 48
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movff	PRINTLOCY,CHARLOCY
	movff	PRINTLOCY_H,CHARLOCY_H
	lfsr	0,SYSPRINTBUFFER
	movf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	INDF0,W,ACCESS
	movwf	CHARCODE,ACCESS
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	rcall	GLCDDRAWCHAR_SSD1306
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1462)
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
	movf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	sublw	1
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
	banksel	0
	return

;********************************************************************************

;Source: hwi2c.h (820)
HI2CINIT
;Dim HI2C1StateMachine as byte
;Dim HI2CACKPOLLSTATE  as Byte
;Dim TWI0ACKPOLLSTATE  as Byte Alias HI2CACKPOLLSTATE
;Dim HI2C1lastError as Byte
;This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K-Mode family chips
;HI2CCurrentMode = 0
	banksel	HI2CCURRENTMODE
	clrf	HI2CCURRENTMODE,BANKED
;Initialise the I2C module
;SI2CInit
	banksel	0
	bra	HI2CQ24INIT

;********************************************************************************

;Source: hwi2c.h (358)
HI2CMODE
;This method sets the variable `HI2CCurrentMode`, and, if required, sets the SSPCON1.bits
	return

;********************************************************************************

;Source: hwi2c.h (1682)
HI2CQ24INIT
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
DelayUS3
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS3
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

;Source: hwi2c.h (1642)
HI2CQ24SEND
;Dim HWI2C_Buffer( SCRIPT_HIC2Q2XBUFFERSIZE )
;Dim HWI2C_BufferLocationCounter as Word
;Redirected for Q2x-mode family probalby called HI2CSend
;This is a state Machine to cater for the new approach with the I2C module
;Select Case HI2C1StateMachine
;case 2  'send data
SysSelect3Case1
	movlw	2
	banksel	HI2C1STATEMACHINE
	subwf	HI2C1STATEMACHINE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;HWI2C_BufferLocationCounter++
	incf	HWI2C_BUFFERLOCATIONCOUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	HWI2C_BUFFERLOCATIONCOUNTER_H,F,BANKED
;HWI2C_Buffer(HWI2C_BufferLocationCounter)=I2Cbyte
	lfsr	0,HWI2C_BUFFER
	movf	HWI2C_BUFFERLOCATIONCOUNTER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	HWI2C_BUFFERLOCATIONCOUNTER_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	I2CBYTE,INDF0
;exit Sub
	banksel	0
	return
;case 1  'A start
	bra	SysSelectEnd3
SysSelect3Case2
	decf	HI2C1STATEMACHINE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case3
;HWI2C_BufferLocationCounter = 0
	clrf	HWI2C_BUFFERLOCATIONCOUNTER,BANKED
	clrf	HWI2C_BUFFERLOCATIONCOUNTER_H,BANKED
;I2C1ADB1 = I2Cbyte
	movff	I2CBYTE,I2C1ADB1
;HI2C1StateMachine = 2  'Set state Machine to send data
	movlw	2
	movwf	HI2C1STATEMACHINE,BANKED
;Exit Sub
	banksel	0
	return
;case 3  'A restart
	bra	SysSelectEnd3
SysSelect3Case3
	movlw	3
	subwf	HI2C1STATEMACHINE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd3
;HWI2C_BufferLocationCounter = 0
	clrf	HWI2C_BUFFERLOCATIONCOUNTER,BANKED
	clrf	HWI2C_BUFFERLOCATIONCOUNTER_H,BANKED
;I2C1ADB1 = I2Cbyte
	movff	I2CBYTE,I2C1ADB1
;HI2C1StateMachine = 2  'Set state Machine to send data
	movlw	2
	movwf	HI2C1STATEMACHINE,BANKED
;Exit Sub
	banksel	0
	return
;end select
SysSelectEnd3
	banksel	0
	return

;********************************************************************************

;Source: hwi2c.h (1580)
HI2CQ24STOP
;This routine handles the full transaction.
;1. Enables and loads the key registers
;2. Send IC2START
;3. Send data.. using I2CSEND
;4. Set  HI2CWaitMSSPTimeout and HI2CAckpollState for public use.
;ReStart I2C this prevent lock ups
;I2C1CON0.I2CEN=1
	banksel	I2C1CON0
	bsf	I2C1CON0,I2CEN,BANKED
;Clear the test bit
;I2C1PIR.7 = 0
	bcf	I2C1PIR,7,BANKED
;Number of bytes excluding address
;I2C1CNTH = HWI2C_BufferLocationCounter_H
	movff	HWI2C_BUFFERLOCATIONCOUNTER_H,I2C1CNTH
;I2C1CNT = HWI2C_BufferLocationCounter
	movff	HWI2C_BUFFERLOCATIONCOUNTER,I2C1CNTL
;Start
;I2C1CON0.S = 1
	bsf	I2C1CON0,S,BANKED
;Do while I2C1CON0.S = 1
SysDoLoop_S8
	btfss	I2C1CON0,S,BANKED
	bra	SysDoLoop_E8
;Wait for start
;NOP
	nop
;Loop
	bra	SysDoLoop_S8
SysDoLoop_E8
;Dim HWI2C_BufferLocationCounterIndex as Word
;For HWI2C_BufferLocationCounterIndex = 1 to HWI2C_BufferLocationCounter
;Legacy method
	banksel	HWI2C_BUFFERLOCATIONCOUNTERINDEX
	clrf	HWI2C_BUFFERLOCATIONCOUNTERINDEX,BANKED
	clrf	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,BANKED
	movlw	1
	subwf	HWI2C_BUFFERLOCATIONCOUNTER,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd18
SysForLoop18
	banksel	HWI2C_BUFFERLOCATIONCOUNTERINDEX
	incf	HWI2C_BUFFERLOCATIONCOUNTERINDEX,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,F,BANKED
;HI2CWaitMSSPTimeout = 0
	clrf	HI2CWAITMSSPTIMEOUT,BANKED
;Send/Clock data out
;I2C1TXB = HWI2C_Buffer ( HWI2C_BufferLocationCounterIndex )
	lfsr	0,HWI2C_BUFFER
	movf	HWI2C_BUFFERLOCATIONCOUNTERINDEX,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,I2C1TXB
;Do while I2C1STAT1.TXBE = 0
SysDoLoop_S9
	banksel	I2C1STAT1
	btfsc	I2C1STAT1,TXBE,BANKED
	bra	SysDoLoop_E9
;Wait for Transmit Buffer to Empty
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
;HI2CWaitMSSPTimeout++
	banksel	HI2CWAITMSSPTIMEOUT
	incf	HI2CWAITMSSPTIMEOUT,F,BANKED
;If HI2CWaitMSSPTimeout = 255 Then
	incf	HI2CWAITMSSPTIMEOUT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Transmission failure, exit.
;Goto HI2CQ24StopExit
	bra	HI2CQ24STOPEXIT
;End If
;Loop
	bra	SysDoLoop_S9
SysDoLoop_E9
;Next
	movff	HWI2C_BUFFERLOCATIONCOUNTERINDEX,SysWORDTempA
	movff	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,SysWORDTempA_H
	movff	HWI2C_BUFFERLOCATIONCOUNTER,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop18
SysForLoopEnd18
;Wait for a stop bit to complete
;Do while I2C1STAT0.MMA = 1 and HI2CWaitMSSPTimeout <> 255
SysDoLoop_S10
	clrf	SysByteTempX,ACCESS
	banksel	I2C1STAT0
	btfsc	i2c1stat0,mma,BANKED
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	hi2cwaitmssptimeout,SysBYTETempA
	setf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	SysDoLoop_E10
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
;Loop
	bra	SysDoLoop_S10
SysDoLoop_E10
HI2CQ24STOPEXIT
;If I2C1PIR.7 = 1 then
	banksel	I2C1PIR
	btfss	I2C1PIR,7,BANKED
	bra	ELSE82_1
;HI2CAckpollState = False
	banksel	HI2CACKPOLLSTATE
	clrf	HI2CACKPOLLSTATE,BANKED
;Else
	bra	ENDIF82
ELSE82_1
;HI2CAckpollState = True
	banksel	HI2CACKPOLLSTATE
	setf	HI2CACKPOLLSTATE,BANKED
;End If
ENDIF82
;I2C1CON0.I2CEN=0
	banksel	I2C1CON0
	bcf	I2C1CON0,I2CEN,BANKED
	banksel	0
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (332)
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
	call	Delay_MS
;HI2CMode Master
	movlw	12
	banksel	HI2CCURRENTMODE
	movwf	HI2CCURRENTMODE,BANKED
	banksel	0
	rcall	HI2CMODE
;Wait 15 ms  'wait for power-up and reset
	movlw	15
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
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
;Write_Command_SSD1306(0x00)                                  ' 0x00 act like ks0108 - DO NOT SELECT!!
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

;Source: 190_i2c_glcd_using_ssd1306_128_64.gcb (30)
INITPPS
;Dir PORTC.6 Out    ' Make TX1 pin an output
	banksel	TRISC
	bcf	TRISC,6,BANKED
;Module: UART1
;RC6PPS = 0x0015    // TX1 > RC6
	movlw	21
	banksel	RC6PPS
	movwf	RC6PPS,BANKED
;RC3PPS=0x23; // 0x23 => SCL1
	movlw	35
	movwf	RC3PPS,BANKED
;I2C1SCLPPS=0x13; // 0x13 => RC3
	movlw	19
	movwf	I2C1SCLPPS,BANKED
;RC4PPS=0x24; // 0x24 => SDA1
	movlw	36
	movwf	RC4PPS,BANKED
;I2C1SDAPPS=0x14;// 0x14 => RC4
	movlw	20
	movwf	I2C1SDAPPS,BANKED
	banksel	0
	return

;********************************************************************************

;Source: system.h (197)
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
;PORTE = 0
	clrf	PORTE,BANKED
	banksel	0
	return

;********************************************************************************

;Source: glcd.h (2032)
LINE
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	banksel	LINEDIFFX
	clrf	LINEDIFFX,BANKED
	clrf	LINEDIFFX_H,BANKED
;LineDiffY = 0
	clrf	LINEDIFFY,BANKED
	clrf	LINEDIFFY_H,BANKED
;LineStepX = 0
	clrf	LINESTEPX,BANKED
	clrf	LINESTEPX_H,BANKED
;LineStepY = 0
	clrf	LINESTEPY,BANKED
	clrf	LINESTEPY_H,BANKED
;LineDiffX_x2 = 0
	clrf	LINEDIFFX_X2,BANKED
	clrf	LINEDIFFX_X2_H,BANKED
;LineDiffY_x2 = 0
	clrf	LINEDIFFY_X2,BANKED
	clrf	LINEDIFFY_X2_H,BANKED
;LineErr = 0
	clrf	LINEERR,BANKED
	clrf	LINEERR_H,BANKED
;LineDiffX =  LineX2 -   LineX1
	movf	LINEX1,W,BANKED
	subwf	LINEX2,W,BANKED
	movwf	LINEDIFFX,BANKED
	movf	LINEX1_H,W,BANKED
	subwfb	LINEX2_H,W,BANKED
	movwf	LINEDIFFX_H,BANKED
;LineDiffY =  LineY2 -   LineY1
	movf	LINEY1,W,BANKED
	subwf	LINEY2,W,BANKED
	movwf	LINEDIFFY,BANKED
	movf	LINEY1_H,W,BANKED
	subwfb	LINEY2_H,W,BANKED
	movwf	LINEDIFFY_H,BANKED
;if (LineDiffX > 0) then
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE17_1
;LineStepX = 1
	movlw	1
	banksel	LINESTEPX
	movwf	LINESTEPX,BANKED
	clrf	LINESTEPX_H,BANKED
;else
	bra	ENDIF17
ELSE17_1
;LineStepX = -1
	banksel	LINESTEPX
	setf	LINESTEPX,BANKED
	setf	LINESTEPX_H,BANKED
;end if
ENDIF17
;if (LineDiffY > 0) then
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE18_1
;LineStepY = 1
	movlw	1
	banksel	LINESTEPY
	movwf	LINESTEPY,BANKED
	clrf	LINESTEPY_H,BANKED
;else
	bra	ENDIF18
ELSE18_1
;LineStepY = -1
	banksel	LINESTEPY
	setf	LINESTEPY,BANKED
	setf	LINESTEPY_H,BANKED
;end if
ENDIF18
;LineDiffX = LineStepX * LineDiffX
	movff	LINESTEPX,SysINTEGERTempA
	movff	LINESTEPX_H,SysINTEGERTempA_H
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	banksel	0
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,LINEDIFFX
	movff	SysINTEGERTempX_H,LINEDIFFX_H
;LineDiffY = LineStepY * LineDiffY
	movff	LINESTEPY,SysINTEGERTempA
	movff	LINESTEPY_H,SysINTEGERTempA_H
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,LINEDIFFY
	movff	SysINTEGERTempX_H,LINEDIFFY_H
;LineDiffX_x2 = LineDiffX*2
	movff	LINEDIFFX,SysINTEGERTempA
	movff	LINEDIFFX_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,LINEDIFFX_X2
	movff	SysINTEGERTempX_H,LINEDIFFX_X2_H
;LineDiffY_x2 = LineDiffY*2
	movff	LINEDIFFY,SysINTEGERTempA
	movff	LINEDIFFY_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSMULTSUBINT
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
	bra	ELSE19_1
;LineErr = LineDiffY_x2 - LineDiffX
	banksel	LINEDIFFX
	movf	LINEDIFFX,W,BANKED
	subwf	LINEDIFFY_X2,W,BANKED
	movwf	LINEERR,BANKED
	movf	LINEDIFFX_H,W,BANKED
	subwfb	LINEDIFFY_X2_H,W,BANKED
	movwf	LINEERR_H,BANKED
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S4
	movff	linex1,SysWORDTempA
	movff	linex1_H,SysWORDTempA_H
	movff	linex2,SysWORDTempB
	movff	linex2_H,SysWORDTempB_H
	banksel	0
	rcall	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E4
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	rcall	PSET_SSD1306
;LineX1 += LineStepX
	banksel	LINESTEPX
	movf	LINESTEPX,W,BANKED
	addwf	LINEX1,F,BANKED
	movf	LINESTEPX_H,W,BANKED
	addwfc	LINEX1_H,F,BANKED
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE20_1
;LineErr += LineDiffY_x2
	banksel	LINEDIFFY_X2
	movf	LINEDIFFY_X2,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	LINEDIFFY_X2_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;else
	bra	ENDIF20
ELSE20_1
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	banksel	LINEDIFFX_X2
	movf	LINEDIFFX_X2,W,BANKED
	subwf	LINEDIFFY_X2,W,BANKED
	movwf	SysTemp3,BANKED
	movf	LINEDIFFX_X2_H,W,BANKED
	subwfb	LINEDIFFY_X2_H,W,BANKED
	movwf	SysTemp3_H,BANKED
	movf	SysTemp3,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	SysTemp3_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;LineY1 += LineStepY
	movf	LINESTEPY,W,BANKED
	addwf	LINEY1,F,BANKED
	movf	LINESTEPY_H,W,BANKED
	addwfc	LINEY1_H,F,BANKED
;end if
ENDIF20
;loop
	bra	SysDoLoop_S4
SysDoLoop_E4
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	rcall	PSET_SSD1306
;else
	bra	ENDIF19
ELSE19_1
;LineErr = LineDiffX_x2 - LineDiffY
	banksel	LINEDIFFY
	movf	LINEDIFFY,W,BANKED
	subwf	LINEDIFFX_X2,W,BANKED
	movwf	LINEERR,BANKED
	movf	LINEDIFFY_H,W,BANKED
	subwfb	LINEDIFFX_X2_H,W,BANKED
	movwf	LINEERR_H,BANKED
;do while (   LineY1 <>  LineY2)
SysDoLoop_S5
	movff	liney1,SysWORDTempA
	movff	liney1_H,SysWORDTempA_H
	movff	liney2,SysWORDTempB
	movff	liney2_H,SysWORDTempB_H
	banksel	0
	rcall	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E5
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	rcall	PSET_SSD1306
;LineY1 += LineStepY
	banksel	LINESTEPY
	movf	LINESTEPY,W,BANKED
	addwf	LINEY1,F,BANKED
	movf	LINESTEPY_H,W,BANKED
	addwfc	LINEY1_H,F,BANKED
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE21_1
;LineErr += LineDiffX_x2
	banksel	LINEDIFFX_X2
	movf	LINEDIFFX_X2,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	LINEDIFFX_X2_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;else
	bra	ENDIF21
ELSE21_1
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	banksel	LINEDIFFY_X2
	movf	LINEDIFFY_X2,W,BANKED
	subwf	LINEDIFFX_X2,W,BANKED
	movwf	SysTemp3,BANKED
	movf	LINEDIFFY_X2_H,W,BANKED
	subwfb	LINEDIFFX_X2_H,W,BANKED
	movwf	SysTemp3_H,BANKED
	movf	SysTemp3,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	SysTemp3_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;LineX1 += LineStepX
	movf	LINESTEPX,W,BANKED
	addwf	LINEX1,F,BANKED
	movf	LINESTEPX_H,W,BANKED
	addwfc	LINEX1_H,F,BANKED
;end if
ENDIF21
;loop
	bra	SysDoLoop_S5
SysDoLoop_E5
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	rcall	PSET_SSD1306
;end if
ENDIF19
	return

;********************************************************************************

;Source: string.h (1291)
FN_PAD
;Check length of SysInString
;If SysInString(0) = longer or equal SysStrLen then
;give back SysInString and exit function
;If SysInString(0) < SysStrLen Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	banksel	SYSSTRLEN
	movf	SYSSTRLEN,W,BANKED
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ELSE50_1
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;clear output string
;Pad=""
	lfsr	1,PAD
	movlw	low StringTable96
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable96
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable96
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
;Legacy method
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd8
SysForLoop8
	incf	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,PAD
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp2,POSTINC0
;Next
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop8
SysForLoopEnd8
;For SysStringTemp = SysCharCount+1 to SysStrLen
;Legacy method
	incf	SYSCHARCOUNT,W,BANKED
	movwf	SysTemp1,BANKED
	decf	SysTemp1,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
	incf	SYSCHARCOUNT,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movff	SYSSTRLEN,SysBYTETempA
	banksel	0
	rcall	SYSCOMPLESSTHAN
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd9
SysForLoop9
	banksel	SYSSTRINGTEMP
	incf	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString3(1)
	movlw	1
	addwf	SysSYSINSTRING3Handler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRING3Handler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,PAD
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp1,POSTINC0
;Next
	movf	SYSSTRLEN,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
;set new length to PAD
;Pad(0) = SysStrLen
	movffl	SYSSTRLEN,SYSPAD_0
;else
	bra	ENDIF50
ELSE50_1
;SysInString is equal or longer than SysStrLen
;give back old string; copy SysInString to Pad
;For SysStringTemp = 1 To SysInString(0)
;Legacy method
	clrf	SYSSTRINGTEMP,BANKED
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd10
SysForLoop10
	incf	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,PAD
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp2,POSTINC0
;Next
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;PAD(0) = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	POSTINC0,SysArrayTemp1
	movffl	SysArrayTemp1,SYSPAD_0
;End If
ENDIF50
	banksel	0
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (898)
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
	bra	ENDIF72
;exit sub
	banksel	0
	return
;end if
ENDIF72
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
	movwf	SysTemp2,BANKED
	clrf	SysTemp1,BANKED
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	SSD1306_BUFFERLOCATIONCALC,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
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
	bra	ELSE74_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE,ACCESS
;Set C On
	bsf	STATUS,C,ACCESS
;Else
	bra	ENDIF74
ELSE74_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE,ACCESS
;Set C Off
	bcf	STATUS,C,ACCESS
;End If
ENDIF74
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
	bra	ELSE75_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	movf	GLCDDATATEMP,W,ACCESS
	andwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;Else
	bra	ENDIF75
ELSE75_1
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	movf	GLCDDATATEMP,W,ACCESS
	iorwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;End If
ENDIF75
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
	bra	ENDIF76
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
	rcall	WRITE_DATA_SSD1306
;end if
ENDIF76
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2159)
FN_READAD72
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	movff	ADREADPORT,ADPCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (635)
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
	bra	SysSelectEnd1
;Case 23: Set ANSELC.7 On
	banksel	ANSELC
	bsf	ANSELC,7,BANKED
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
;SET ADCS OFF  'ADCON0.4
	bcf	ADCON0,ADCS,BANKED
;ADCLK = 15    'FOSC/16
	movlw	15
	movwf	ADCLK,BANKED
;Configure AD clock defaults fpr older 18F that do not have ADCLK
;SET ADCS2 OFF
	bcf	ADCLK,ADCS2,BANKED
;SET ADCS1 OFF
	bcf	ADCLK,ADCS1,BANKED
;SET ADCS0 ON
	bsf	ADCLK,ADCS0,BANKED
;Result formatting
;if ADLeftadjust = 0 then
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
	bcf	ADCON0,ADFM0,BANKED
;Set ADFM0 OFF
	bcf	ADCON0,ADFM0,BANKED
;End if
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
;ReadAD = ADRESH
	movff	ADRESH,READAD
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
	banksel	0
	return

;********************************************************************************

;Source: hwi2c.h (930)
SI2CSTART
;Redirected for K-Mode family probalby called HI2CStart
;This method sets the registers and register bits to generate the I2C  START signal. Master_mode only.
;HI2C1StateMachine = 1
	movlw	1
	banksel	HI2C1STATEMACHINE
	movwf	HI2C1STATEMACHINE,BANKED
;HI2CWaitMSSPTimeout = false
	clrf	HI2CWAITMSSPTIMEOUT,BANKED
;Clear the error state variable
;HI2C1lastError = I2C1_GOOD
	clrf	HI2C1LASTERROR,BANKED
	banksel	0
	return

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
	bra	ENDIF45
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
ENDIF45
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
	bra	ENDIF46
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
ENDIF46
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
	bra	ENDIF47
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
ENDIF47
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
	bra	ENDIF48
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
ENDIF48
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

;Source: system.h (4061)
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

;Source: system.h (4087)
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

;Source: system.h (4141)
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

;Source: system.h (4451)
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

;Source: system.h (4481)
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

;Source: system.h (4539)
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

;Source: system.h (4919)
SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ELSE42_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF43
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	return
;End If
ENDIF43
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
	bra	ENDIF42
ELSE42_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	return
;End If
;End If
ENDIF42
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

;Source: system.h (1716)
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

;Source: system.h (3455)
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
	bra	ENDIF77
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF77
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
	bra	ENDIF78
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF78
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

;Source: system.h (3531)
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
	bra	ENDIF40
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF40
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
	bra	ENDIF41
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
ENDIF41
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

;Source: system.h (3509)
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
	bra	ENDIF37
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
ENDIF37
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF38
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
ENDIF38
;Call word divide routine
;SysDivSub16
	rcall	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF39
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
ENDIF39
	return

;********************************************************************************

;Source: system.h (2921)
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

;Source: system.h (3038)
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
	bra	ENDIF35
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
ENDIF35
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

;Source: system.h (3019)
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
	bra	ENDIF32
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
ENDIF32
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF33
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
ENDIF33
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF34
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
ENDIF34
	return

;********************************************************************************

;Source: system.h (1913)
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
	db	7,71,67,66,65,83,73,67


StringTable2
	db	12,65,110,111,98,105,117,109,32,50,48,50,52


StringTable3
	db	1,42


StringTable4
	db	15,86,101,114,115,105,111,110,32,49,46,120,120,46,120,120


StringTable6
	db	14,70,85,76,76,32,71,76,67,68,32,77,79,68,69


StringTable7
	db	8,80,114,105,110,116,83,116,114


StringTable8
	db	1,64


StringTable9
	db	3,77,104,122


StringTable10
	db	7,68,114,97,119,83,116,114


StringTable11
	db	4,65,68,67,58


StringTable12
	db	1,61


StringTable57
	db	1,32


StringTable96
	db	0


;********************************************************************************

;Source: GLCD_SSD1306.H (239)
WRITE_COMMAND_SSD1306
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	banksel	I2CBYTE
	movwf	I2CBYTE,BANKED
	banksel	0
	call	HI2CQ24SEND
;HI2CSend 0x00
	banksel	I2CBYTE
	clrf	I2CBYTE,BANKED
	banksel	0
	call	HI2CQ24SEND
;HI2CSend SSD1306SendByte
	movff	SSD1306SENDBYTE,I2CBYTE
	call	HI2CQ24SEND
;HI2CStop
	goto	HI2CQ24STOP

;********************************************************************************

;Source: GLCD_SSD1306.H (285)
WRITE_DATA_SSD1306
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	banksel	I2CBYTE
	movwf	I2CBYTE,BANKED
	banksel	0
	call	HI2CQ24SEND
;HI2CSend 0x40
	movlw	64
	banksel	I2CBYTE
	movwf	I2CBYTE,BANKED
	banksel	0
	call	HI2CQ24SEND
;HI2CSend SSD1306SendByte
	movff	SSD1306SENDBYTE,I2CBYTE
	call	HI2CQ24SEND
;HI2CStop
	goto	HI2CQ24STOP

;********************************************************************************


 END
