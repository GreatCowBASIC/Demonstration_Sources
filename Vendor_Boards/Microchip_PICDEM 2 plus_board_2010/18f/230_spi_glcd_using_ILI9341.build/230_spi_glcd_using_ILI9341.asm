;Program compiled by GCBASIC (2026.08.07 (Windows 64 bit) : Build 1617) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-08-15 CRC247
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\230_spi_glcd_using_ILI9341.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\230_spi_glcd_using_ILI9341.build\230_spi_glcd_using_ILI9341.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\230_spi_glcd_using_ILI9341.gcb"
 SUBTITLE    "08-16-2026 17:02:13"
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
 CONFIG  MCLRE = INTMCLR
 CONFIG  FCMEN = ON
 CONFIG  CLKOUTEN = OFF
 CONFIG  RSTOSC = HFINTOSC_1MHZ
 CONFIG  FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
BYTENUMBER                       EQU    1294          ; 0x50E (SA)
CCOUNT                           EQU    1295          ; 0x50F (SA)
CHARCODE                         EQU    1296          ; 0x510 (SA)
CHARCOL                          EQU    1297          ; 0x511 (SA)
CHARCOLS                         EQU    1299          ; 0x513 (SA)
CHARCOL_H                        EQU    1298          ; 0x512 (SA)
CHARLOCX                         EQU    1300          ; 0x514 (SA)
CHARLOCX_H                       EQU    1301          ; 0x515 (SA)
CHARLOCY                         EQU    1302          ; 0x516 (SA)
CHARLOCY_H                       EQU    1303          ; 0x517 (SA)
CHARROW                          EQU    1304          ; 0x518 (SA)
CHARROWS                         EQU    1306          ; 0x51A (SA)
CHARROW_H                        EQU    1305          ; 0x519 (SA)
COL                              EQU    1307          ; 0x51B (SA)
COLOR                            EQU    1308          ; 0x51C (SA)
COLOR_H                          EQU    1309          ; 0x51D (SA)
CURRCHARCOL                      EQU    1310          ; 0x51E (SA)
CURRCHARROW                      EQU    1311          ; 0x51F (SA)
CURRCHARVAL                      EQU    1312          ; 0x520 (SA)
CURRCOL                          EQU    1313          ; 0x521 (SA)
CURRCOL_H                        EQU    1314          ; 0x522 (SA)
DDF_X                            EQU    1315          ; 0x523 (SA)
DDF_X_H                          EQU    1316          ; 0x524 (SA)
DDF_Y                            EQU    1317          ; 0x525 (SA)
DDF_Y_H                          EQU    1318          ; 0x526 (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
DRAWLINE                         EQU    1319          ; 0x527 (SA)
DRAWLINE_H                       EQU    1320          ; 0x528 (SA)
FF                               EQU    1321          ; 0x529 (SA)
FF_H                             EQU    1322          ; 0x52A (SA)
FILLCIRCLEXX                     EQU    1323          ; 0x52B (SA)
FILLCIRCLEYY                     EQU    1324          ; 0x52C (SA)
GLCDBACKGROUND                   EQU    1325          ; 0x52D (SA)
GLCDBACKGROUND_H                 EQU    1326          ; 0x52E (SA)
GLCDCOLOUR                       EQU    1327          ; 0x52F (SA)
GLCDCOLOUR_H                     EQU    1328          ; 0x530 (SA)
GLCDDEVICEHEIGHT                 EQU    1329          ; 0x531 (SA)
GLCDDEVICEHEIGHT_H               EQU    1330          ; 0x532 (SA)
GLCDDEVICEWIDTH                  EQU    1331          ; 0x533 (SA)
GLCDDEVICEWIDTH_H                EQU    1332          ; 0x534 (SA)
GLCDFNTDEFAULT                   EQU    1333          ; 0x535 (SA)
GLCDFNTDEFAULTHEIGHT             EQU    1334          ; 0x536 (SA)
GLCDFNTDEFAULTSIZE               EQU    1335          ; 0x537 (SA)
GLCDFONTWIDTH                    EQU    1336          ; 0x538 (SA)
GLCDFOREGROUND                   EQU    1337          ; 0x539 (SA)
GLCDFOREGROUND_H                 EQU    1338          ; 0x53A (SA)
GLCDPIXELCOUNT                   EQU    1339          ; 0x53B (SA)
GLCDPIXELCOUNT_E                 EQU    1342          ; 0x53E (SA)
GLCDPIXELCOUNT_H                 EQU    1340          ; 0x53C (SA)
GLCDPIXELCOUNT_U                 EQU    1341          ; 0x53D (SA)
GLCDPRINTLEN                     EQU    1343          ; 0x53F (SA)
GLCDPRINTLOC                     EQU    1344          ; 0x540 (SA)
GLCDPRINTLOC_H                   EQU    1345          ; 0x541 (SA)
GLCDPRINT_STRING_COUNTER         EQU    1346          ; 0x542 (SA)
GLCDROTATESTATE                  EQU    1347          ; 0x543 (SA)
GLCDTEMP                         EQU    1348          ; 0x544 (SA)
GLCDTEMP_H                       EQU    1349          ; 0x545 (SA)
GLCDX                            EQU    1350          ; 0x546 (SA)
GLCDX_H                          EQU    1351          ; 0x547 (SA)
GLCDY                            EQU    1352          ; 0x548 (SA)
GLCDY_H                          EQU    1353          ; 0x549 (SA)
GLCD_YORDINATE                   EQU    1354          ; 0x54A (SA)
GLCD_YORDINATE_H                 EQU    1355          ; 0x54B (SA)
ILI9341SENDBYTE                  EQU    1356          ; 0x54C (SA)
ILI9341SENDWORD                  EQU    1357          ; 0x54D (SA)
ILI9341SENDWORD_H                EQU    1358          ; 0x54E (SA)
ILI9341TEMPOUT                   EQU    1359          ; 0x54F (SA)
INXRADIUS                        EQU    1360          ; 0x550 (SA)
INXRADIUS_H                      EQU    1361          ; 0x551 (SA)
LCDVALUE                         EQU    1362          ; 0x552 (SA)
LCDVALUE_E                       EQU    1365          ; 0x555 (SA)
LCDVALUE_H                       EQU    1363          ; 0x553 (SA)
LCDVALUE_U                       EQU    1364          ; 0x554 (SA)
LINECOLOUR                       EQU    1366          ; 0x556 (SA)
LINECOLOUR_H                     EQU    1367          ; 0x557 (SA)
LINEDIFFX                        EQU    1368          ; 0x558 (SA)
LINEDIFFX_H                      EQU    1369          ; 0x559 (SA)
LINEDIFFX_X2                     EQU    1370          ; 0x55A (SA)
LINEDIFFX_X2_H                   EQU    1371          ; 0x55B (SA)
LINEDIFFY                        EQU    1372          ; 0x55C (SA)
LINEDIFFY_H                      EQU    1373          ; 0x55D (SA)
LINEDIFFY_X2                     EQU    1374          ; 0x55E (SA)
LINEDIFFY_X2_H                   EQU    1375          ; 0x55F (SA)
LINEERR                          EQU    1376          ; 0x560
LINEERR_H                        EQU    1377          ; 0x561
LINESTEPX                        EQU    1378          ; 0x562
LINESTEPX_H                      EQU    1379          ; 0x563
LINESTEPY                        EQU    1380          ; 0x564
LINESTEPY_H                      EQU    1381          ; 0x565
LINEX1                           EQU    1382          ; 0x566
LINEX1_H                         EQU    1383          ; 0x567
LINEX2                           EQU    1384          ; 0x568
LINEX2_H                         EQU    1385          ; 0x569
LINEY1                           EQU    1386          ; 0x56A
LINEY1_H                         EQU    1387          ; 0x56B
LINEY2                           EQU    1388          ; 0x56C
LINEY2_H                         EQU    1389          ; 0x56D
LOCX                             EQU    1390          ; 0x56E
LOCX_H                           EQU    1391          ; 0x56F
LOCY                             EQU    1392          ; 0x570
LOCY_H                           EQU    1393          ; 0x571
LONGNUMBER                       EQU    1394          ; 0x572
LONGNUMBER_E                     EQU    1397          ; 0x575
LONGNUMBER_H                     EQU    1395          ; 0x573
LONGNUMBER_U                     EQU    1396          ; 0x574
OLDFONT                          EQU    1398          ; 0x576
PAD                              EQU    5335          ; 0x14D7
PRINTLEN                         EQU    1399          ; 0x577
PRINTLOCX                        EQU    1400          ; 0x578
PRINTLOCX_H                      EQU    1401          ; 0x579
PRINTLOCY                        EQU    1402          ; 0x57A
PRINTLOCY_H                      EQU    1403          ; 0x57B
RADIUSERR                        EQU    1404          ; 0x57C
RADIUSERR_H                      EQU    1405          ; 0x57D
ROW                              EQU    1406          ; 0x57E
SPICLOCKMODE                     EQU    1407          ; 0x57F
SPICURRENTMODE                   EQU    1408          ; 0x580
SPIRXDATA                        EQU    1409          ; 0x581
SPITXDATA                        EQU    1410          ; 0x582
STR                              EQU    5284          ; 0x14A4
STRINGLOCX                       EQU    1411          ; 0x583
STRINGLOCX_H                     EQU    1412          ; 0x584
STRINGPOINTER                    EQU    1413          ; 0x585
SYSARRAYTEMP1                    EQU    1414          ; 0x586
SYSARRAYTEMP2                    EQU    1415          ; 0x587
SYSBYTETEMPA                     EQU    1285          ; 0x505 (SA)
SYSBYTETEMPB                     EQU    1289          ; 0x509 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPA                     EQU    1285          ; 0x505 (SA)
SYSCALCTEMPA_E                   EQU    1288          ; 0x508 (SA)
SYSCALCTEMPA_H                   EQU    1286          ; 0x506 (SA)
SYSCALCTEMPA_U                   EQU    1287          ; 0x507 (SA)
SYSCALCTEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPX_H                   EQU    1281          ; 0x501 (SA)
SYSCHARCOUNT                     EQU    1416          ; 0x588
SYSCHARSHANDLER                  EQU    1417          ; 0x589
SYSCHARSHANDLER_H                EQU    1418          ; 0x58A
SYSDIVLOOP                       EQU    1284          ; 0x504 (SA)
SYSDIVMULTA                      EQU    1287          ; 0x507 (SA)
SYSDIVMULTA_H                    EQU    1288          ; 0x508 (SA)
SYSDIVMULTB                      EQU    1291          ; 0x50B (SA)
SYSDIVMULTB_H                    EQU    1292          ; 0x50C (SA)
SYSDIVMULTX                      EQU    1282          ; 0x502 (SA)
SYSDIVMULTX_H                    EQU    1283          ; 0x503 (SA)
SYSINTEGERTEMPA                  EQU    1285          ; 0x505 (SA)
SYSINTEGERTEMPA_H                EQU    1286          ; 0x506 (SA)
SYSINTEGERTEMPB                  EQU    1289          ; 0x509 (SA)
SYSINTEGERTEMPB_H                EQU    1290          ; 0x50A (SA)
SYSINTEGERTEMPX                  EQU    1280          ; 0x500 (SA)
SYSINTEGERTEMPX_H                EQU    1281          ; 0x501 (SA)
SYSLCDPRINTDATAHANDLER           EQU    1419          ; 0x58B
SYSLCDPRINTDATAHANDLER_H         EQU    1420          ; 0x58C
SYSLONGDIVMULTA                  EQU    1421          ; 0x58D
SYSLONGDIVMULTA_E                EQU    1424          ; 0x590
SYSLONGDIVMULTA_H                EQU    1422          ; 0x58E
SYSLONGDIVMULTA_U                EQU    1423          ; 0x58F
SYSLONGDIVMULTB                  EQU    1425          ; 0x591
SYSLONGDIVMULTB_E                EQU    1428          ; 0x594
SYSLONGDIVMULTB_H                EQU    1426          ; 0x592
SYSLONGDIVMULTB_U                EQU    1427          ; 0x593
SYSLONGDIVMULTX                  EQU    1429          ; 0x595
SYSLONGDIVMULTX_E                EQU    1432          ; 0x598
SYSLONGDIVMULTX_H                EQU    1430          ; 0x596
SYSLONGDIVMULTX_U                EQU    1431          ; 0x597
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
SYSPRINTBUFFER                   EQU    5290          ; 0x14AA
SYSPRINTBUFFLEN                  EQU    1433          ; 0x599
SYSPRINTDATAHANDLER              EQU    1434          ; 0x59A
SYSPRINTDATAHANDLER_H            EQU    1435          ; 0x59B
SYSPRINTTEMP                     EQU    1436          ; 0x59C
SYSREPEATTEMP1                   EQU    1437          ; 0x59D
SYSREPEATTEMP2                   EQU    1438          ; 0x59E
SYSREPEATTEMP3                   EQU    1439          ; 0x59F
SYSREPEATTEMP3_H                 EQU    1440          ; 0x5A0
SYSREPEATTEMP4                   EQU    1441          ; 0x5A1
SYSREPEATTEMP4_E                 EQU    1444          ; 0x5A4
SYSREPEATTEMP4_H                 EQU    1442          ; 0x5A2
SYSREPEATTEMP4_U                 EQU    1443          ; 0x5A3
SYSSIGNBYTE                      EQU    1293          ; 0x50D (SA)
SYSSTRDATA                       EQU    1445          ; 0x5A5
SYSSTRINGA                       EQU    1287          ; 0x507 (SA)
SYSSTRINGA_H                     EQU    1288          ; 0x508 (SA)
SYSSTRINGLENGTH                  EQU    1286          ; 0x506 (SA)
SYSSTRINGPARAM1                  EQU    5318          ; 0x14C6
SYSSTRINGPARAM2                  EQU    5301          ; 0x14B5
SYSSTRINGTEMP                    EQU    1446          ; 0x5A6
SYSSTRLEN                        EQU    1447          ; 0x5A7
SYSSYSINSTRING3HANDLER           EQU    1448          ; 0x5A8
SYSSYSINSTRING3HANDLER_H         EQU    1449          ; 0x5A9
SYSSYSINSTRINGHANDLER            EQU    1450          ; 0x5AA
SYSSYSINSTRINGHANDLER_H          EQU    1451          ; 0x5AB
SYSTEMP1                         EQU    1452          ; 0x5AC
SYSTEMP1_E                       EQU    1455          ; 0x5AF
SYSTEMP1_H                       EQU    1453          ; 0x5AD
SYSTEMP1_U                       EQU    1454          ; 0x5AE
SYSTEMP2                         EQU    1456          ; 0x5B0
SYSTEMP2_H                       EQU    1457          ; 0x5B1
SYSTEMP3                         EQU    1458          ; 0x5B2
SYSTEMP3_H                       EQU    1459          ; 0x5B3
SYSVALTEMP                       EQU    1460          ; 0x5B4
SYSVALTEMP_H                     EQU    1461          ; 0x5B5
SYSWAITTEMPMS                    EQU    1282          ; 0x502 (SA)
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503 (SA)
SYSWAITTEMPS                     EQU    1284          ; 0x504 (SA)
SYSWAITTEMPUS                    EQU    1285          ; 0x505 (SA)
SYSWAITTEMPUS_H                  EQU    1286          ; 0x506 (SA)
SYSWORDTEMPA                     EQU    1285          ; 0x505 (SA)
SYSWORDTEMPA_H                   EQU    1286          ; 0x506 (SA)
SYSWORDTEMPB                     EQU    1289          ; 0x509 (SA)
SYSWORDTEMPB_H                   EQU    1290          ; 0x50A (SA)
SYSWORDTEMPX                     EQU    1280          ; 0x500 (SA)
SYSWORDTEMPX_H                   EQU    1281          ; 0x501 (SA)
WORDNUMBER                       EQU    1462          ; 0x5B6
WORDNUMBER_H                     EQU    1463          ; 0x5B7
XCHAR                            EQU    1464          ; 0x5B8
XOFFSET                          EQU    1465          ; 0x5B9
XOFFSET_H                        EQU    1466          ; 0x5BA
XRADIUS                          EQU    1467          ; 0x5BB
XRADIUS_H                        EQU    1468          ; 0x5BC
YCALC1                           EQU    1469          ; 0x5BD
YCALC1_H                         EQU    1470          ; 0x5BE
YCALC2                           EQU    1471          ; 0x5BF
YCALC2_H                         EQU    1472          ; 0x5C0
YOFFSET                          EQU    1473          ; 0x5C1
YOFFSET_H                        EQU    1474          ; 0x5C2
YORDINATE                        EQU    1475          ; 0x5C3
_X1                              EQU    1476          ; 0x5C4
_X1_H                            EQU    1477          ; 0x5C5
_X2                              EQU    1478          ; 0x5C6
_X2_H                            EQU    1479          ; 0x5C7
_Y1                              EQU    1480          ; 0x5C8
_Y1_H                            EQU    1481          ; 0x5C9
_Y2                              EQU    1482          ; 0x5CA
_Y2_H                            EQU    1483          ; 0x5CB

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
SYSPAD_0 EQU 5335
SYSSTR_0 EQU 5284

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
	call	INITGLCD_ILI9341

;Start_of_the_main_program
;
;A demonstration program for GCBASIC.
;--------------------------------------------------------------------------------------------------------------------------------
;This program is a simple GLCD demonstration of the ILI9341 GLCD capabilities.
;It is a nice graphical LCD, suitable for a lot of various projects.
;This program draws lines, boxes, circles and prints strings and numbers.
;The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;
;This has been tested using the hardware and software SPI option.
;
;!!Software ILI9341 are 3v3 operating voltage. Just be careful.
;
;------------------------------------------------------------------------
;IMPORTANT - Power configuration
;------------------------------------------------------------------------
;!! VDDIO2 IS CRITICAL FOR OPERATION !!
;On this device family, VDDIO2 supplies power to a secondary I/O bank.
;If VDDIO2 is not correctly connected to the supply rail (per the
;datasheet electrical and pin-out specifications), the associated I/O
;pins will not function correctly, and the chip may not operate
;reliably even though the primary VDD/VSS pins are powered correctly.
;Always verify VDDIO2 is wired to VDD (or the correct supply level) on
;your board before troubleshooting "dead" I/O or unexpected resets.
;------------------------------------------------------------------------
;
;----- Configuration
;Set microcontroller required
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
;------------------PORTC-----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    VDD-TX------SDO-SCK-RST--CS--DC--
;----------------------------------------
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
;PIC PPS Tool version: 0.0.6.5
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
;********************** DEMO REALLY STARTS HERE ************************************************
;! Uncomment out the next line... and, enable the hardware SPI!!! or comment out to use software SPI
;#DEFINE HWSPIClockMode 1          ' specify mode 1 for this GLCD device [0/1/2/3]
;Pin mappings for ILI9341
;Control lines
;GLCD selected extension font set. ASCII characters 31-254, the extended font uses 1358 bytes of program memory
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDCLS  supports GLCDBackground as default
;GLCDCLS  also support passing color parameter.
;GLCDCLS [color]
;GLCDRotate ( Landscape_rev )     ' optionally you can rotate the screen.
	movlw	3
	movwf	GLCDROTATESTATE,ACCESS
	banksel	0
	call	GLCDROTATE_ILI9341
;Available colors
;ILI9341_BLACK
;ILI9341_RED
;ILI9341_GREEN
;ILI9341_BLUE
;ILI9341_WHITE
;ILI9341_PURPLE
;ILI9341_YELLOW
;ILI9341_CYAN
;ILI9341_D_GRAY
;ILI9341_L_GRAY
;ILI9341_SILVER
;ILI9341_MAROON
;ILI9341_OLIVE
;ILI9341_LIME
;ILI9341_AQUA
;ILI9341_TEAL
;ILI9341_NAVY
;ILI9341_FUCHSIA
;Dim CCOUNT, BYTENUMBER, OLDFONT, OLDFONT as Byte
;CCount = 31
	movlw	31
	movwf	CCOUNT,ACCESS
;dim longNumber as long
;longNumber = 0 ' max value = 4294967290
	banksel	LONGNUMBER
	clrf	LONGNUMBER,BANKED
	clrf	LONGNUMBER_H,BANKED
	clrf	LONGNUMBER_U,BANKED
	clrf	LONGNUMBER_E,BANKED
;dim wordNumber as Word
;wordNumber = 0
	clrf	WORDNUMBER,BANKED
	clrf	WORDNUMBER_H,BANKED
;byteNumber = 0
	clrf	BYTENUMBER,ACCESS
;repeat 2
	movlw	2
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
;GLCDRotate ( Landscape_rev )
	movlw	3
	movwf	GLCDROTATESTATE,ACCESS
	banksel	0
	call	GLCDROTATE_ILI9341
;GLCDCLS ILI9341_BLUE
	movlw	31
	movwf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
	call	GLCDCLS_ILI9341
;GLCDForeground = ILI9341_MAROON
	clrf	GLCDFOREGROUND,ACCESS
	movlw	128
	movwf	GLCDFOREGROUND_H,ACCESS
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDPrint ( 2, 2, "GLCDPrint String" )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	2
	movwf	PRINTLOCY,BANKED
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
;Using SYSSTRINGPARAM1*16
	banksel	0
	call	GLCDPRINT7
;GLCDForeground = ILI9341_WHITE
	setf	GLCDFOREGROUND,ACCESS
	setf	GLCDFOREGROUND_H,ACCESS
;GLCDfntDefaultsize = 2
	movlw	2
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDPrint ( 2, 12, "GLCDPrint String" )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	12
	movwf	PRINTLOCY,BANKED
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
;Using SYSSTRINGPARAM1*16
	banksel	0
	call	GLCDPRINT7
;GLCDForeground = ILI9341_YELLOW
	movlw	224
	movwf	GLCDFOREGROUND,ACCESS
	setf	GLCDFOREGROUND_H,ACCESS
;GLCDfntDefaultsize = 3
	movlw	3
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDPrint ( 2,30, "GLCDPrint String" )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	30
	movwf	PRINTLOCY,BANKED
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
;Using SYSSTRINGPARAM1*16
	banksel	0
	call	GLCDPRINT7
;longNumber = 0xFFFFFFFF
	banksel	LONGNUMBER
	setf	LONGNUMBER,BANKED
	setf	LONGNUMBER_H,BANKED
	setf	LONGNUMBER_U,BANKED
	setf	LONGNUMBER_E,BANKED
;wordNumber = 0xFFFF
	setf	WORDNUMBER,BANKED
	setf	WORDNUMBER_H,BANKED
;byteNumber = 0xFF
	setf	BYTENUMBER,ACCESS
;GLCDRotate ( Portrait )
	movlw	4
	movwf	GLCDROTATESTATE,ACCESS
	banksel	0
	call	GLCDROTATE_ILI9341
;GLCDCLS ILI9341_WHITE
	setf	GLCDBACKGROUND,ACCESS
	setf	GLCDBACKGROUND_H,ACCESS
	call	GLCDCLS_ILI9341
;GLCDForeground = ILI9341_MAROON
	clrf	GLCDFOREGROUND,ACCESS
	movlw	128
	movwf	GLCDFOREGROUND_H,ACCESS
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDPrint ( 2, 2, bytenumber )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	2
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	BYTENUMBER,LCDVALUE
	clrf	LCDVALUE_H,ACCESS
	clrf	LCDVALUE_U,ACCESS
	clrf	LCDVALUE_E,ACCESS
	banksel	0
	call	GLCDPRINT10
;GLCDForeground = ILI9341_BLACK
	clrf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;GLCDfntDefaultsize = 2
	movlw	2
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDPrint ( 2, 12, wordNumber )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	12
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	WORDNUMBER,LCDVALUE
	movff	WORDNUMBER_H,LCDVALUE_H
	clrf	LCDVALUE_U,ACCESS
	clrf	LCDVALUE_E,ACCESS
	banksel	0
	call	GLCDPRINT10
;GLCDForeground = ILI9341_CYAN
	setf	GLCDFOREGROUND,ACCESS
	movlw	7
	movwf	GLCDFOREGROUND_H,ACCESS
;GLCDfntDefaultsize = 3
	movlw	3
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDPrint ( 2,30, longnumber )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	30
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	LONGNUMBER,LCDVALUE
	movff	LONGNUMBER_H,LCDVALUE_H
	movff	LONGNUMBER_U,LCDVALUE_U
	movff	LONGNUMBER_E,LCDVALUE_E
	banksel	0
	call	GLCDPRINT10
;wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;end Repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;GLCDCLS ILI9341_BLUE
	movlw	31
	movwf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
	banksel	0
	call	GLCDCLS_ILI9341
;Set font size.
;GLCDfntDefaultsize = 2
	movlw	2
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;longNumber = 0 ' max value = 4294967290
	banksel	LONGNUMBER
	clrf	LONGNUMBER,BANKED
	clrf	LONGNUMBER_H,BANKED
	clrf	LONGNUMBER_U,BANKED
	clrf	LONGNUMBER_E,BANKED
;wordNumber = 0
	clrf	WORDNUMBER,BANKED
	clrf	WORDNUMBER_H,BANKED
;byteNumber = 0
	clrf	BYTENUMBER,ACCESS
;Using the global variable GLCDfntDefaultsize to show the different capabilities
;Select Case GLCDfntDefaultsize
;Case 1
SysSelect1Case1
	decf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;ShowCase1
	banksel	0
	call	SHOWCASE1
;Case 2
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;ShowCase2
	banksel	0
	call	SHOWCASE2
;Case 3
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
;GLCDDrawString (2, 1, "GLCD font")
	movlw	2
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	1
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
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
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
;Using SYSSTRINGPARAM1*9
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDDrawString (2, 25, "size = 3")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	25
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
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
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
;Using SYSSTRINGPARAM1*8
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;box 0,0,ILI9341_GLCD_WIDTH-1, ILI9341_GLCD_HEIGHT-1, ILI9341_BLUE
	banksel	LINEX1
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	1
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	LINEX2_H,BANKED
	movlw	1
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	LINEY2_H,BANKED
	movlw	31
	movwf	LINECOLOUR,ACCESS
	clrf	LINECOLOUR_H,ACCESS
	banksel	0
	call	BOX19
;box ILI9341_GLCD_WIDTH-5, ILI9341_GLCD_HEIGHT-5,ILI9341_GLCD_WIDTH-1, ILI9341_GLCD_HEIGHT-1, ILI9341_WHITE
	movlw	5
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	banksel	LINEX1
	movwf	LINEX1,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	LINEX1_H,BANKED
	movlw	5
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	LINEY1,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	LINEY1_H,BANKED
	movlw	1
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	LINEX2_H,BANKED
	movlw	1
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	LINEY2_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
	banksel	0
	call	BOX19
;End Select
SysSelectEnd1
;end
	bra	BASPROGRAMEND
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

BIGFONT102_111
	movlw	239
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT102_111
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT102_111
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT102_111
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT102_111
	db	240,0,128,128,248,252,252,132,156,156,24,0,0,0,33,33,63,63,63,33,33,1,0,0,0,0
	db	128,192,192,64,64,64,192,128,192,64,0,0,71,207,223,152,152,152,255,255,127,0,0,0
	db	4,252,252,252,128,64,64,192,192,128,0,0,32,63,63,63,1,0,0,63,63,63,0,0,0,64,64,64
	db	220,220,220,0,0,0,0,0,0,32,32,32,63,63,63,32,32,32,0,0,0,0,0,64,64,64,220,220
	db	220,0,0,0,32,96,224,128,128,192,255,255,127,0,0,0,4,252,252,252,0,0,128,192,192,64
	db	0,0,32,63,63,63,2,7,15,61,56,48,0,0,0,4,4,4,252,252,252,0,0,0,0,0,0,32,32,32,63,63
	db	63,32,32,32,0,0,192,192,192,64,64,192,64,64,192,192,128,0,63,63,63,0,0,63,0,0
	db	63,63,63,0,192,192,192,64,64,64,192,192,128,0,0,0,63,63,63,0,0,0,63,63,63,0,0,0
	db	128,192,192,64,64,64,192,192,128,0,0,0,31,63,63,32,32,32,63,63,31

;********************************************************************************

BIGFONT112_121
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT112_121
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT112_121
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT112_121
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT112_121
	db	240,0,64,192,128,192,64,64,64,192,192,128,0,0,128,255,255,255,144,16,16,31,31,15
	db	0,128,192,192,64,64,64,192,128,192,64,0,0,15,31,31,16,16,144,255,255,255,128,0
	db	0,0,64,192,192,192,128,192,192,192,192,128,0,0,32,63,63,63,33,0,0,1,1,1,0,0,128,192
	db	192,64,64,64,64,192,128,0,0,0,25,59,35,38,38,38,60,61,25,0,0,0,64,64,224,240
	db	248,64,64,64,64,0,0,0,0,0,31,63,63,32,56,56,24,0,0,0,192,192,192,0,0,0,192,192
	db	192,0,0,0,31,63,63,32,32,32,63,31,63,32,0,0,192,192,192,0,0,0,192,192,192,0,0,0
	db	7,15,31,56,48,56,31,15,7,0,0,0,192,192,192,0,0,0,0,0,192,192,192,0,7,15,63,56
	db	56,14,56,56,63,15,7,0,192,192,192,0,0,192,192,192,0,0,0,0,48,57,63,15,15,63,57,48
	db	0,0,0,0,0,192,192,192,0,0,0,192,192,192,0,0,128,135,143,159,216,248,120,63,15,7

;********************************************************************************

BIGFONT122_126
	movlw	109
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT122_126
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT122_126
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT122_126
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT122_126
	db	120,0,192,192,64,64,64,192,192,192,0,0,0,0,49,56,60,46,39,35,49,56,0,0,0,0,128,128
	db	192,120,124,60,4,4,4,4,0,0,1,1,3,30,62,60,32,32,32,32,0,0,0,0,0,0,254,254,254,0
	db	0,0,0,0,0,0,0,0,127,127,127,0,0,0,0,0,4,4,4,4,60,124,120,192,128,128,0,0,32,32
	db	32,32,60,62,30,3,1,1,0,56,60,60,4,12,28,56,48,32,60,60,28

;********************************************************************************

BIGFONT193_202
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT193_202
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT193_202
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT193_202
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT193_202
	db	240,0,224,240,248,28,12,12,28,248,240,224,0,0,63,63,63,2,2,2,2,63,63,63,0,0,4,252
	db	252,252,132,132,132,252,252,120,0,0,32,63,63,63,36,36,36,63,63,30,0,0,0,252,252,252
	db	12,12,12,12,12,0,0,0,0,63,63,63,0,0,0,0,0,0,0,0,224,240,248,28,12,12,28,248,240,224
	db	0,0,63,63,63,48,48,48,48,63,63,63,0,0,4,252,252,252,132,132,132,196,204,28,0,0
	db	32,63,63,63,36,36,36,35,51,56,0,0,60,28,12,4,132,196,228,124,60,28,0,0,56,60,62,39
	db	35,36,32,48,56,60,0,0,252,252,252,128,128,128,252,252,252,0,0,0,63,63,63,1,1,1
	db	63,63,63,0,0,0,224,240,248,156,140,140,140,156,248,240,224,0,7,15,31,57,49,49
	db	49,57,31,15,7,0,0,4,4,252,252,252,4,4,0,0,0,0,0,32,32,63,63,63,32,32,0,0,0,0,4,252
	db	252,252,192,224,112,60,28,12,0,0,32,63,63,63,3,7,14,60,56,48

;********************************************************************************

BIGFONT203_212
	movlw	238
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT203_212
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT203_212
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT203_212
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT203_212
	db	240,0,224,240,248,28,12,12,28,248,240,224,0,0,63,63,63,0,0,0,0,63,63,63,0,0,252,252
	db	252,120,240,224,240,120,252,252,252,0,63,63,63,0,0,1,0,0,63,63,63,0,252,252,252,112
	db	224,192,128,0,252,252,252,0,63,63,63,0,0,1,3,7,63,63,63,0,0,28,28,156,156,156
	db	156,156,28,28,0,0,0,56,56,57,57,57,57,57,56,56,0,0,224,240,248,28,12,12,12,28
	db	248,240,224,0,7,15,31,56,48,48,48,56,31,15,7,0,252,252,252,28,28,28,28,252,252,252
	db	0,0,63,63,63,0,0,0,0,63,63,63,0,0,4,252,252,252,132,132,132,252,252,120,0,0,32,63
	db	63,63,36,1,1,1,1,0,0,0,0,60,124,252,220,156,156,28,28,28,0,0,0,60,62,63,59,57
	db	57,56,56,56,0,0,28,12,4,4,252,252,252,4,4,12,28,0,0,0,32,32,63,63,63,32,32,0,0,0
	db	124,252,252,128,0,128,252,252,124,0,0,0,0,32,36,63,63,63,36,32

;********************************************************************************

BIGFONT213_216
	movlw	95
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT213_216
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT213_216
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT213_216
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT213_216
	db	96,224,240,248,56,24,252,252,24,56,248,240,224,7,15,31,28,24,63,63,24,28,31,15
	db	7,0,28,60,124,224,192,224,124,60,28,0,0,0,56,60,62,7,3,7,62,60,56,0,0,0,252,252
	db	252,128,248,248,248,128,252,252,252,0,0,1,3,35,63,63,63,35,3,1,0,0,0,112,252,252
	db	140,140,140,252,252,112,0,0,0,0,49,51,51,51,51,51,49

;********************************************************************************

BIGFONT32_41
	movlw	239
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT32_41
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT32_41
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT32_41
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT32_41
	db	240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,248,252,252,252,248,0,0
	db	0,0,0,0,0,0,115,115,115,0,0,0,0,0,0,0,0,30,62,62,0,0,0,62,62,30,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,48,48,254,254,48,48,48,48,254,254,48,48,12,12,127,127,12,12,12,12,127
	db	127,12,12,0,240,248,152,254,152,152,254,152,152,24,0,0,24,25,25,127,25,25,127,25
	db	31,15,0,0,0,56,56,56,128,192,224,112,56,0,0,0,0,28,14,7,3,1,28,28,28,0,0,0,56,252
	db	196,196,252,56,0,0,0,128,0,0,30,63,33,33,51,63,30,30,55,35,0,0,0,32,60,60,28,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,192,224,240,56,28,12,4,4,0,0,0,0,3,7,15
	db	28,56,48,32,32,0,0,0,0,4,4,12,28,56,240,224,192,0,0,0,0,32,32,48,56,28,15,7,3

;********************************************************************************

BIGFONT42_51
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT42_51
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT42_51
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT42_51
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT42_51
	db	240,128,136,144,224,224,252,252,224,224,144,136,128,1,17,9,7,7,63,63,7,7,9,17,1,0
	db	0,128,128,128,240,240,128,128,128,0,0,0,0,1,1,1,15,15,1,1,1,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,64,120,120,56,0,0,0,0,0,0,0,128,128,128,128,128,128,128,128,128,128,0,0
	db	1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,56,56,56,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,128,192,224,112,56,0,32,48,56,28,14,7,3,1,0,0,0,0,248,252,252,4,4,4,4,252
	db	252,248,0,0,31,63,63,32,32,32,32,63,63,31,0,0,96,96,96,240,252,252,0,0,0,0,0,0
	db	32,32,32,63,63,63,32,32,32,0,0,0,24,28,28,4,4,132,204,252,120,48,0,0,48,56,60,46
	db	39,35,33,56,56,56,0,0,24,28,28,132,132,132,204,124,120,48,0,0,24,56,56,36,33,33
	db	51,62,30,12

;********************************************************************************

BIGFONT52_61
	movlw	241
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT52_61
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT52_61
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT52_61
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT52_61
	db	240,0,128,192,96,48,24,252,252,252,0,0,0,0,3,3,3,35,35,63,63,63,35,35,0,0,252,252
	db	252,132,132,132,132,132,4,4,0,0,25,57,57,36,33,33,51,63,31,14,0,0,224,240,248,156
	db	140,132,132,132,128,0,0,0,31,63,63,36,36,33,33,63,63,31,0,0,60,60,60,4,4,4,4,132
	db	252,252,124,0,0,0,0,56,60,62,7,3,1,0,0,0,120,124,252,196,196,132,132,252,124,120
	db	0,0,30,62,63,33,33,35,35,63,62,30,0,0,248,252,252,132,132,132,132,252,252,248,0,0
	db	0,1,36,33,33,49,57,31,15,7,0,0,0,0,0,112,112,112,0,0,0,0,0,0,0,0,0,14,14,14,0,0
	db	0,0,0,0,0,0,0,112,112,112,0,0,0,0,0,0,0,0,16,30,30,14,0,0,0,0,0,0,128,192,224,112
	db	56,28,14,6,2,0,0,0,1,3,7,14,28,56,112,96,64,0,0,96,96,96,96,96,96,96,96,96,96,96
	db	96,6,6,6,6,6,6,6,6,6,6,6,6

;********************************************************************************

BIGFONT62_71
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT62_71
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT62_71
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT62_71
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT62_71
	db	240,0,2,6,14,28,56,112,224,192,128,0,0,0,64,96,112,56,28,14,7,3,1,0,0,0,24,28
	db	12,14,6,134,206,252,124,56,0,0,0,0,0,0,115,115,115,0,0,0,0,0,252,254,254,2,2,194
	db	194,194,254,254,252,0,63,63,127,96,96,99,99,99,99,67,3,0,224,240,248,28,12,12
	db	28,248,240,224,0,0,63,63,63,2,2,2,2,63,63,63,0,0,4,252,252,252,132,132,132,252
	db	252,120,0,0,32,63,63,63,36,33,33,63,63,30,0,0,240,248,252,12,4,4,4,28,28,24,0,0
	db	15,31,63,48,32,32,32,56,56,24,0,0,4,252,252,252,4,4,12,252,248,240,0,0,32,63,63,63
	db	32,32,48,63,31,15,0,0,4,252,252,252,132,132,132,196,204,28,0,0,32,63,63,63,36,33
	db	33,35,51,56,0,0,4,252,252,252,132,132,132,196,204,28,0,0,32,63,63,63,33,1,1,3,3,0
	db	0,0,240,248,252,12,4,4,4,60,60,56,0,0,15,31,63,48,32,34,34,62,62,62

;********************************************************************************

BIGFONT72_81
	movlw	241
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT72_81
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT72_81
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT72_81
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT72_81
	db	240,0,252,252,252,128,128,128,252,252,252,0,0,0,63,63,63,1,1,1,63,63,63,0,0,0,0,4
	db	4,252,252,252,4,4,0,0,0,0,0,32,32,63,63,63,32,32,0,0,0,0,0,0,0,0,4,4,252,252
	db	252,4,4,30,30,62,32,32,32,32,63,63,31,0,0,0,4,252,252,252,192,224,112,60,28,12
	db	0,0,32,63,63,63,3,7,14,60,56,48,0,0,4,252,252,252,4,0,0,0,0,0,0,0,32,63,63,63
	db	32,32,32,48,56,60,0,0,252,252,252,120,240,224,240,120,252,252,252,0,63,63,63,0
	db	0,1,0,0,63,63,63,0,252,252,252,112,224,192,128,0,252,252,252,0,63,63,63,0,0,1,3,7
	db	63,63,63,0,224,240,248,28,12,12,12,28,248,240,224,0,7,15,31,56,48,48,48,56,31,15
	db	7,0,4,252,252,252,132,132,132,252,252,120,0,0,32,63,63,63,33,1,1,1,1,0,0,0,224,248
	db	248,28,12,4,12,28,248,248,224,0,7,31,31,24,24,92,94,126,127,127,71

;********************************************************************************

BIGFONT82_91
	movlw	239
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT82_91
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT82_91
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT82_91
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT82_91
	db	240,0,4,252,252,252,132,132,132,252,252,120,0,0,32,63,63,63,1,1,3,63,63,60,0,0
	db	120,252,252,132,132,132,132,188,60,56,0,0,28,60,61,36,36,33,33,63,63,30,0,0,28,12
	db	4,4,252,252,252,4,4,12,28,0,0,0,32,32,63,63,63,32,32,0,0,0,252,252,252,0,0,0
	db	252,252,252,0,0,0,31,63,63,32,32,32,63,63,31,0,0,0,252,252,252,0,0,0,252,252
	db	252,0,0,0,7,15,31,56,48,56,31,15,7,0,0,0,252,252,252,0,0,128,0,0,252,252,252,0
	db	3,15,63,60,60,15,60,60,63,15,3,0,28,60,124,224,192,224,124,60,28,0,0,0,56,60,62,7
	db	3,7,62,60,56,0,0,0,124,252,252,128,0,128,252,252,124,0,0,0,0,32,33,63,63,63,33,32
	db	0,0,0,0,60,28,12,4,132,196,228,124,60,28,0,0,56,60,62,39,35,33,32,48,56,60,0,0
	db	0,0,252,252,252,4,4,4,4,0,0,0,0,0,63,63,63,32,32,32,32

;********************************************************************************

BIGFONT92_101
	movlw	239
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEBIGFONT92_101
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEBIGFONT92_101
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEBIGFONT92_101
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEBIGFONT92_101
	db	240,0,28,56,112,224,192,128,0,0,0,0,0,0,0,0,0,0,1,3,7,14,28,24,48,0,0,0,4,4,4,4
	db	252,252,252,0,0,0,0,0,32,32,32,32,63,63,63,0,0,0,32,48,56,28,14,14,28,56,48,32
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,192,192,192,192,192,192,192
	db	192,192,192,192,192,0,12,12,60,48,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64
	db	64,64,64,64,192,192,128,0,0,0,28,62,62,34,34,34,63,31,63,32,0,0,4,252,252,252
	db	64,64,64,192,192,128,0,0,32,63,31,63,32,32,32,63,63,31,0,0,128,192,192,64,64,64
	db	192,192,128,0,0,0,31,63,63,32,32,32,57,57,25,0,0,0,128,192,192,64,64,68,252,252
	db	252,4,0,0,31,63,63,32,32,32,63,31,63,32,0,0,128,192,192,64,64,64,192,192,128,0
	db	0,0,31,63,63,34,34,34,59,59,27

;********************************************************************************

;Source: GLCD_ILI9341.H (1400)
BIGPRINT_ILI9341
;Dim GLCDPrintLoc as word
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen = 0 Then Exit Sub
	banksel	PRINTLEN
	movf	PRINTLEN,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF62
;If PrintLen = 0 Then Exit Sub
	banksel	0
	return
;If PrintLen = 0 Then Exit Sub
ENDIF62
;GLCDPrintLoc = PrintLocX
	movff	PRINTLOCX,GLCDPRINTLOC
	movff	PRINTLOCX_H,GLCDPRINTLOC_H
;For SysPrintTemp = 1 To PrintLen
;Legacy method
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd13
SysForLoop13
	incf	SYSPRINTTEMP,F,BANKED
;DrawBigChar_ILI9341 GLCDPrintLoc, PrintLocY, PrintData(SysPrintTemp), Color
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movff	PRINTLOCY,CHARLOCY
	movff	PRINTLOCY_H,CHARLOCY_H
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,CHARCODE
	banksel	0
	rcall	DRAWBIGCHAR_ILI9341
;GLCDPrintLoc += 13
	movlw	13
	addwf	GLCDPRINTLOC,F,ACCESS
	movlw	0
	addwfc	GLCDPRINTLOC_H,F,ACCESS
;Next
	banksel	PRINTLEN
	movf	PRINTLEN,W,BANKED
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop13
SysForLoopEnd13
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (1779)
BOX19
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
	bra	SysForLoopEnd3
SysForLoop3
	incf	DRAWLINE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,ACCESS
;PSet DrawLine, LineY1, LineColour
	movff	DRAWLINE,GLCDX
	movff	DRAWLINE_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_ILI9341
;PSet DrawLine, LineY2, LineColour
	movff	DRAWLINE,GLCDX
	movff	DRAWLINE_H,GLCDX_H
	movff	LINEY2,GLCDY
	movff	LINEY2_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_ILI9341
;Next
	movff	DRAWLINE,SysWORDTempA
	movff	DRAWLINE_H,SysWORDTempA_H
	movff	LINEX2,SysWORDTempB
	movff	LINEX2_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
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
	bra	SysForLoopEnd4
SysForLoop4
	incf	DRAWLINE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,ACCESS
;PSet LineX1, DrawLine, LineColour
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	DRAWLINE,GLCDY
	movff	DRAWLINE_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_ILI9341
;PSet LineX2, DrawLine, LineColour
	movff	LINEX2,GLCDX
	movff	LINEX2_H,GLCDX_H
	movff	DRAWLINE,GLCDY
	movff	DRAWLINE_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_ILI9341
;Next
	movff	DRAWLINE,SysWORDTempA
	movff	DRAWLINE_H,SysWORDTempA_H
	movff	LINEY2,SysWORDTempB
	movff	LINEY2_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:INTEGER:word:byte:, Source: glcd.h (1855)
CIRCLE22
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
SysDoLoop_S4
	movff	xradius,SysINTEGERTempA
	movff	xradius_H,SysINTEGERTempA_H
	movff	yordinate,SysINTEGERTempB
	clrf	SysINTEGERTempB_H,ACCESS
	banksel	0
	call	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E4
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	XRADIUS_H,W,BANKED
	addwfc	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	YORDINATE,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	addwfc	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_ILI9341
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	XRADIUS,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movf	XRADIUS_H,W,BANKED
	addwfc	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_ILI9341
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	XRADIUS_H,W,BANKED
	subwfb	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	YORDINATE,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	addwfc	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_ILI9341
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	XRADIUS,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movf	XRADIUS_H,W,BANKED
	addwfc	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_ILI9341
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	XRADIUS_H,W,BANKED
	subwfb	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	YORDINATE,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_ILI9341
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	XRADIUS,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movf	XRADIUS_H,W,BANKED
	subwfb	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_ILI9341
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movf	XRADIUS_H,W,BANKED
	addwfc	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	YORDINATE,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_ILI9341
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	XRADIUS,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,ACCESS
	movf	XRADIUS_H,W,BANKED
	subwfb	YOFFSET_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_ILI9341
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
	bra	SysDoLoop_S4
SysDoLoop_E4
	return

;********************************************************************************

;Source: GLCD_ILI9341.H (1416)
DRAWBIGCHAR_ILI9341
;dim Locx, Locy, CurrCol as Word
;if CharCode <=126 Then
	movf	CHARCODE,W,ACCESS
	sublw	126
	btfss	STATUS, C,ACCESS
	bra	ENDIF65
;CharCode -=32
	movlw	32
	subwf	CHARCODE,F,ACCESS
;Goto GCBBigTables
	bra	GCBBIGTABLES
;end if
ENDIF65
;if CharCode <=210 Then
	movf	CHARCODE,W,ACCESS
	sublw	210
	btfss	STATUS, C,ACCESS
	bra	ENDIF66
;CharCode -=33
	movlw	33
	subwf	CHARCODE,F,ACCESS
;Goto GCBBigTables
	bra	GCBBIGTABLES
;end if
ENDIF66
;if CharCode <= 250 Then
	movf	CHARCODE,W,ACCESS
	sublw	250
	btfss	STATUS, C,ACCESS
	bra	ENDIF67
;CharCode -=34
	movlw	34
	subwf	CHARCODE,F,ACCESS
;Goto GCBBigTables
	bra	GCBBIGTABLES
;end if
ENDIF67
GCBBIGTABLES
;For CurrCharCol = 1 to 24
;Legacy method
	clrf	CURRCHARCOL,ACCESS
SysForLoop14
	incf	CURRCHARCOL,F,ACCESS
;CurrCol=CurrCharCol+CharCode*24-(CharCode/10)*240
	movff	CHARCODE,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSDIVSUB
	movff	SysBYTETempA,SysTemp1
	movf	CHARCODE,W,ACCESS
	mullw	24
	movff	PRODL,SysTemp2
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	mullw	240
	movf	SysTemp2,W,BANKED
	addwf	CURRCHARCOL,W,ACCESS
	movwf	SysTemp1,BANKED
	clrf	SysTemp1_H,BANKED
	btfsc	STATUS,C,ACCESS
	incf	SysTemp1_H,F,BANKED
	movf	PRODL,W,ACCESS
	subwf	SysTemp1,W,BANKED
	movwf	CURRCOL,ACCESS
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	CURRCOL_H,ACCESS
;if CharCode>=0 and CharCode<=9 then ReadTable BigFont32_41 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	9
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF68
;if CharCode>=0 and CharCode<=9 then ReadTable BigFont32_41 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	call	BIGFONT32_41
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=0 and CharCode<=9 then ReadTable BigFont32_41 , CurrCol, CurrCharVal
ENDIF68
;if CharCode>=10 and CharCode<=19 then ReadTable BigFont42_51 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	19
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF69
;if CharCode>=10 and CharCode<=19 then ReadTable BigFont42_51 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	call	BIGFONT42_51
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=10 and CharCode<=19 then ReadTable BigFont42_51 , CurrCol, CurrCharVal
ENDIF69
;if CharCode>=20 and CharCode<=29 then ReadTable BigFont52_61 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	20
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	29
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF70
;if CharCode>=20 and CharCode<=29 then ReadTable BigFont52_61 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	call	BIGFONT52_61
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=20 and CharCode<=29 then ReadTable BigFont52_61 , CurrCol, CurrCharVal
ENDIF70
;if CharCode>=30 and CharCode<=39 then ReadTable BigFont62_71 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	30
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	39
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF71
;if CharCode>=30 and CharCode<=39 then ReadTable BigFont62_71 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	call	BIGFONT62_71
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=30 and CharCode<=39 then ReadTable BigFont62_71 , CurrCol, CurrCharVal
ENDIF71
;if CharCode>=40 and CharCode<=49 then ReadTable BigFont72_81 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	40
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	49
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF72
;if CharCode>=40 and CharCode<=49 then ReadTable BigFont72_81 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	call	BIGFONT72_81
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=40 and CharCode<=49 then ReadTable BigFont72_81 , CurrCol, CurrCharVal
ENDIF72
;if CharCode>=50 and CharCode<=59 then ReadTable BigFont82_91 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	50
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	59
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF73
;if CharCode>=50 and CharCode<=59 then ReadTable BigFont82_91 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	rcall	BIGFONT82_91
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=50 and CharCode<=59 then ReadTable BigFont82_91 , CurrCol, CurrCharVal
ENDIF73
;if CharCode>=60 and CharCode<=69 then ReadTable BigFont92_101 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	60
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	69
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF74
;if CharCode>=60 and CharCode<=69 then ReadTable BigFont92_101 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	rcall	BIGFONT92_101
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=60 and CharCode<=69 then ReadTable BigFont92_101 , CurrCol, CurrCharVal
ENDIF74
;if CharCode>=70 and CharCode<=79 then ReadTable BigFont102_111 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	70
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	79
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF75
;if CharCode>=70 and CharCode<=79 then ReadTable BigFont102_111 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	call	BIGFONT102_111
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=70 and CharCode<=79 then ReadTable BigFont102_111 , CurrCol, CurrCharVal
ENDIF75
;if CharCode>=80 and CharCode<=89 then ReadTable BigFont112_121 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	80
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	89
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF76
;if CharCode>=80 and CharCode<=89 then ReadTable BigFont112_121 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	call	BIGFONT112_121
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=80 and CharCode<=89 then ReadTable BigFont112_121 , CurrCol, CurrCharVal
ENDIF76
;if CharCode>=90 and CharCode<=99 then ReadTable BigFont122_126 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	90
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	99
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF77
;if CharCode>=90 and CharCode<=99 then ReadTable BigFont122_126 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	call	BIGFONT122_126
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=90 and CharCode<=99 then ReadTable BigFont122_126 , CurrCol, CurrCharVal
ENDIF77
;if CharCode>=160 and CharCode<=169 then ReadTable BigFont193_202 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	160
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	169
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF78
;if CharCode>=160 and CharCode<=169 then ReadTable BigFont193_202 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	call	BIGFONT193_202
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=160 and CharCode<=169 then ReadTable BigFont193_202 , CurrCol, CurrCharVal
ENDIF78
;if CharCode>=170 and CharCode<=179 then ReadTable BigFont203_212 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	170
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	179
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF79
;if CharCode>=170 and CharCode<=179 then ReadTable BigFont203_212 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	call	BIGFONT203_212
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=170 and CharCode<=179 then ReadTable BigFont203_212 , CurrCol, CurrCharVal
ENDIF79
;if CharCode>=180 and CharCode<=183 then ReadTable BigFont213_216 , CurrCol, CurrCharVal
	movff	CHARCODE,SysBYTETempA
	movlw	180
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	183
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF80
;if CharCode>=180 and CharCode<=183 then ReadTable BigFont213_216 , CurrCol, CurrCharVal
	movff	CURRCOL,SYSSTRINGA
	banksel	0
	call	BIGFONT213_216
	movwf	CURRCHARVAL,ACCESS
;if CharCode>=180 and CharCode<=183 then ReadTable BigFont213_216 , CurrCol, CurrCharVal
ENDIF80
;if CurrCharVal=36 then CurrCharVal=33
	movlw	36
	subwf	CURRCHARVAL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF81
;if CurrCharVal=36 then CurrCharVal=33
	movlw	33
	movwf	CURRCHARVAL,ACCESS
;if CurrCharVal=36 then CurrCharVal=33
ENDIF81
;For CurrCharRow = 1 to 8
;Legacy method
	clrf	CURRCHARROW,ACCESS
SysForLoop15
	incf	CURRCHARROW,F,ACCESS
;LocX=[word]CharLocX+CurrCharCol
	movf	CURRCHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	banksel	LOCX
	movwf	LOCX,BANKED
	movlw	0
	addwfc	CHARLOCX_H,W,ACCESS
	movwf	LOCX_H,BANKED
;LocY=[Word]CharLocY+CurrCharRow
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	LOCY,BANKED
	movlw	0
	addwfc	CHARLOCY_H,W,ACCESS
	movwf	LOCY_H,BANKED
;if CurrCharCol>12 then
	movf	CURRCHARCOL,W,ACCESS
	sublw	12
	btfsc	STATUS, C,ACCESS
	bra	ENDIF82
;LocX= LocX - 12
	movlw	12
	subwf	LOCX,F,BANKED
	movlw	0
	subwfb	LOCX_H,F,BANKED
;LocY= LocY + 8
	movlw	8
	addwf	LOCY,F,BANKED
	movlw	0
	addwfc	LOCY_H,F,BANKED
;end if
ENDIF82
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0,ACCESS
	bra	ENDIF83
;PSet_ILI9341 LocX , LocY , Color
	movff	LOCX,GLCDX
	movff	LOCX_H,GLCDX_H
	movff	LOCY,GLCDY
	movff	LOCY_H,GLCDY_H
	movff	COLOR,GLCDCOLOUR
	movff	COLOR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_ILI9341
;end if
ENDIF83
;Rotate CurrCharVal Right
	rrcf	CURRCHARVAL,F,ACCESS
;Next
	movlw	8
	subwf	CURRCHARROW,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop15
SysForLoopEnd15
;Next
	movlw	24
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop14
SysForLoopEnd14
	banksel	0
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

;Source: hwspi.h (979)
FASTHWSPITRANSFER
;Master mode only
;One byte transfer count
;SPI1TCNTL = 1
	movlw	1
	movwf	SPI1TCNTL,BANKED
;SPI1TXB = SPITxData
	movff	SPITXDATA,SPI1TXB
;wait while SPI1RXIF = SPI_RX_IN_PROGRESS
SysWaitLoop2
	btfss	PIR6,SPI1RXIF,ACCESS
	bra	SysWaitLoop2
;SPIRxData = SPI1RXB
	movff	SPI1RXB,SPIRXDATA
	return

;********************************************************************************

;Source: GLCD_ILI9341.H (1067)
FILLEDBOX_ILI9341
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF57
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
ENDIF57
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF58
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
ENDIF58
;Set address window
;SetAddress_ILI9341 ILI9341_COLUMN, LineX1, LineX2
;SetAddress_ILI9341 ILI9341_ROW, LineY1, LineY2
;SetAddressWindow_ILI9341 (  LineX1, LineY1, LineX2, LineY2 )
	movff	LINEX1,_X1
	movff	LINEX1_H,_X1_H
	movff	LINEY1,_Y1
	movff	LINEY1_H,_Y1_H
	movff	LINEX2,_X2
	movff	LINEX2_H,_X2_H
	movff	LINEY2,_Y2
	movff	LINEY2_H,_Y2_H
	call	SETADDRESSWINDOW_ILI9341
;Fill with colour
;Dim GLCDPixelCount As Long
;GLCDPixelCount = (LineX2 - LineX1 + 1) * (LineY2 - LineY1 + 1)
	banksel	LINEX1
	movf	LINEX1,W,BANKED
	subwf	LINEX2,W,BANKED
	movwf	SysTemp2,BANKED
	movf	LINEX1_H,W,BANKED
	subwfb	LINEX2_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movf	LINEY1,W,BANKED
	subwf	LINEY2,W,BANKED
	movwf	SysTemp2,BANKED
	movf	LINEY1_H,W,BANKED
	subwfb	LINEY2_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	SysTemp3,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	SysTemp3_H,BANKED
	movff	SysTemp1,SysLONGTempA
	movff	SysTemp1_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	SysTemp3,SysLONGTempB
	movff	SysTemp3_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	call	SYSMULTSUB32
	movff	SysLONGTempX,GLCDPIXELCOUNT
	movff	SysLONGTempX_H,GLCDPIXELCOUNT_H
	movff	SysLONGTempX_U,GLCDPIXELCOUNT_U
	movff	SysLONGTempX_E,GLCDPIXELCOUNT_E
;Repeat GLCDPixelCount
	movff	GLCDPIXELCOUNT,SysRepeatTemp4
	movff	GLCDPIXELCOUNT_H,SysRepeatTemp4_H
	movff	GLCDPIXELCOUNT_U,SysRepeatTemp4_U
	movff	GLCDPIXELCOUNT_E,SysRepeatTemp4_E
	movff	SYSREPEATTEMP4,SysLONGTempA
	movff	SYSREPEATTEMP4_H,SysLONGTempA_H
	movff	SYSREPEATTEMP4_U,SysLONGTempA_U
	movff	SYSREPEATTEMP4_E,SysLONGTempA_E
	movlw	1
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSCOMPLESSTHAN32
	btfsc	SysByteTempX,0,ACCESS
	bra	SysRepeatLoopEnd4
	banksel	SYSREPEATTEMP4
	movf	SYSREPEATTEMP4,F,BANKED
	btfss	STATUS, Z,ACCESS
	incf	SysRepeatTemp4_H,F,BANKED
	movf	SYSREPEATTEMP4_H,F,BANKED
	btfss	STATUS, Z,ACCESS
	incf	SysRepeatTemp4_U,F,BANKED
	movf	SYSREPEATTEMP4_U,F,BANKED
	btfss	STATUS, Z,ACCESS
	incf	SysRepeatTemp4_E,F,BANKED
SysRepeatLoop4
;SendWord_ILI9341 LineColour
	movff	LINECOLOUR,ILI9341SENDWORD
	movff	LINECOLOUR_H,ILI9341SENDWORD_H
	banksel	0
	call	SENDWORD_ILI9341
;End Repeat
	banksel	SYSREPEATTEMP4
	decfsz	SysRepeatTemp4,F,BANKED
	bra	SysRepeatLoop4
	decfsz	SysRepeatTemp4_H,F,BANKED
	bra	SysRepeatLoop4
	decfsz	SysRepeatTemp4_U,F,BANKED
	bra	SysRepeatLoop4
	decfsz	SysRepeatTemp4_E,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:word:, Source: glcd.h (1913)
FILLEDCIRCLE24
;Circle fill Code is merely a modification of the midpoint
;circle algorithem which is an adaption of Bresenham's line algorithm
;http://en.wikipedia.org/wiki/Midpoint_circle_algorithm
;http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
;dim ff, ddF_x, ddF_y as integer
;dim YCalc2, YCalc1 as word
;ff = 1 - xradius
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	sublw	1
	movwf	FF,ACCESS
	clrf	SysTemp1,BANKED
	movf	XRADIUS_H,W,BANKED
	subwfb	SysTemp1,W,BANKED
	movwf	FF_H,ACCESS
;ddF_x = 1
	movlw	1
	movwf	DDF_X,ACCESS
	clrf	DDF_X_H,ACCESS
;ddF_y = -2 * xradius
	movff	XRADIUS,SysINTEGERTempA
	movff	XRADIUS_H,SysINTEGERTempA_H
	movlw	254
	movwf	SysINTEGERTempB,ACCESS
	setf	SysINTEGERTempB_H,ACCESS
	banksel	0
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,DDF_Y
	movff	SysINTEGERTempX_H,DDF_Y_H
;FillCircleXX = 0
	clrf	FILLCIRCLEXX,ACCESS
;FillCircleYY = xradius
	movff	XRADIUS,FILLCIRCLEYY
;Fill in the center between the two halves
;YCalc2 = yoffset+xradius
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	YCALC2,BANKED
	movf	XRADIUS_H,W,BANKED
	addwfc	YOFFSET_H,W,BANKED
	movwf	YCALC2_H,BANKED
;YCalc1 = yoffset-xradius
	movf	XRADIUS,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	YCALC1,BANKED
	movf	XRADIUS_H,W,BANKED
	subwfb	YOFFSET_H,W,BANKED
	movwf	YCALC1_H,BANKED
;Line( xoffset, YCalc1 , xoffset, YCalc2, LineColour)
	movff	XOFFSET,LINEX1
	movff	XOFFSET_H,LINEX1_H
	movff	YCALC1,LINEY1
	movff	YCALC1_H,LINEY1_H
	movff	XOFFSET,LINEX2
	movff	XOFFSET_H,LINEX2_H
	movff	YCALC2,LINEY2
	movff	YCALC2_H,LINEY2_H
	banksel	0
	call	_LINE73
;do while (FillCircleXX < FillCircleYY)
SysDoLoop_S5
	movf	FILLCIRCLEYY,W,ACCESS
	subwf	FILLCIRCLEXX,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	SysDoLoop_E5
;if ff >= 0 then
	movff	FF,SysINTEGERTempA
	movff	FF_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF17
;FillCircleYY--
	decf	FILLCIRCLEYY,F,ACCESS
;ddF_y += 2
	movlw	2
	addwf	DDF_Y,F,ACCESS
	movlw	0
	addwfc	DDF_Y_H,F,ACCESS
;ff += ddF_y
	movf	DDF_Y,W,ACCESS
	addwf	FF,F,ACCESS
	movf	DDF_Y_H,W,ACCESS
	addwfc	FF_H,F,ACCESS
;end if
ENDIF17
;FillCircleXX++
	incf	FILLCIRCLEXX,F,ACCESS
;ddF_x += 2
	movlw	2
	addwf	DDF_X,F,ACCESS
	movlw	0
	addwfc	DDF_X_H,F,ACCESS
;ff += ddF_x
	movf	DDF_X,W,ACCESS
	addwf	FF,F,ACCESS
	movf	DDF_X_H,W,ACCESS
	addwfc	FF_H,F,ACCESS
;Now draw vertical lines between the points on the circle rather than
;draw the points of the circle. This draws lines between the
;perimeter points on the upper and lower quadrants of the 2 halves of the circle.
;Line(xoffset+FillCircleXX, yoffset+FillCircleYY, xoffset+FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W,ACCESS
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movf	FILLCIRCLEYY,W,ACCESS
	addwf	YOFFSET,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	addwfc	YOFFSET_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movf	FILLCIRCLEXX,W,ACCESS
	addwf	XOFFSET,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movf	FILLCIRCLEYY,W,ACCESS
	subwf	YOFFSET,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	LINEY2_H,BANKED
	banksel	0
	call	_LINE73
;Line(xoffset-FillCircleXX, yoffset+FillCircleYY, xoffset-FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W,ACCESS
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movf	FILLCIRCLEYY,W,ACCESS
	addwf	YOFFSET,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	addwfc	YOFFSET_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movf	FILLCIRCLEXX,W,ACCESS
	subwf	XOFFSET,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movf	FILLCIRCLEYY,W,ACCESS
	subwf	YOFFSET,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	LINEY2_H,BANKED
	banksel	0
	call	_LINE73
;Line(xoffset+FillCircleYY, yoffset+FillCircleXX, FillCircleYY+xoffset, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W,ACCESS
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movf	FILLCIRCLEXX,W,ACCESS
	addwf	YOFFSET,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	addwfc	YOFFSET_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movf	XOFFSET,W,BANKED
	addwf	FILLCIRCLEYY,W,ACCESS
	movwf	LINEX2,BANKED
	clrf	SysTemp1,BANKED
	movf	XOFFSET_H,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	LINEX2_H,BANKED
	movf	FILLCIRCLEXX,W,ACCESS
	subwf	YOFFSET,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	LINEY2_H,BANKED
	banksel	0
	call	_LINE73
;Line(xoffset-FillCircleYY, yoffset+FillCircleXX, xoffset-FillCircleYY, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W,ACCESS
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movf	FILLCIRCLEXX,W,ACCESS
	addwf	YOFFSET,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	addwfc	YOFFSET_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movf	FILLCIRCLEYY,W,ACCESS
	subwf	XOFFSET,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movf	FILLCIRCLEXX,W,ACCESS
	subwf	YOFFSET,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	LINEY2_H,BANKED
	banksel	0
	call	_LINE73
;loop
	bra	SysDoLoop_S5
SysDoLoop_E5
	return

;********************************************************************************

GLCDCHARCOL3EXTENDED1
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL3EXTENDED1
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL3EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL3EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL3EXTENDED1
	db	239,0,16,12,10,136,34,56,32,8,32,16,16,128,128,64,4,0,0,0,40,72,70,108,0,0,0,40
	db	16,0,16,0,64,124,0,132,130,48,78,120,6,108,12,0,0,16,40,0,4,100,248,254,124,254
	db	254,254,124,254,0,64,254,254,254,254,124,254,124,254,76,2,126,62,126,198,14,194
	db	0,4,0,8,128,0,64,254,112,112,112,16,16,254,0,64,254,0,248,248,112,248,16,248
	db	144,16,120,56,120,136,24,136,0,0,0,32,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,248,254,254,248,254,194,254,124,0,254,248,254,254,130,124,254,254,0
	db	198,2,14,56,198,14,188,0,0,56,40,124,0,0,56,254,4,48,40,1,124,48,0,124,64,252
	db	28,0,56,4,248,24,56,4,60,56,68,60,60,0,60,56,60,60

;********************************************************************************

GLCDCHARCOL4EXTENDED1
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL4EXTENDED1
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL4EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL4EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL4EXTENDED1
	db	239,254,56,10,6,204,102,124,112,4,64,16,56,136,162,112,28,0,0,14,254,84,38,146
	db	10,56,130,16,16,160,16,192,32,162,132,194,130,40,138,148,2,146,146,108,172,40
	db	40,130,2,146,36,146,130,130,146,18,130,16,130,128,16,128,4,8,130,18,130,18,146,2
	db	128,64,128,40,16,162,254,8,130,4,128,2,168,144,136,136,168,252,168,16,144,128
	db	32,130,8,16,136,40,40,16,168,124,128,64,128,80,160,200,16,0,130,16,68,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,36,146,2,132,146,162,16,146,130,16,4,4
	db	8,146,130,2,18,0,170,2,16,68,40,16,194,0,0,68,84,8,0,0,68,73,104,73,84,25,8,74
	db	0,16,50,64,32,1,68,124,36,36,68,4,64,68,40,64,64,1,65,68,64,64

;********************************************************************************

GLCDCHARCOL5EXTENDED1
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL5EXTENDED1
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL5EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL5EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL5EXTENDED1
	db	239,124,124,0,0,238,238,124,168,254,254,84,84,148,148,124,124,0,158,0,40,254,16,170
	db	6,68,68,124,124,96,16,192,16,146,254,162,138,36,138,146,226,146,146,108,108,68
	db	40,68,162,242,34,146,130,130,146,18,146,16,254,130,40,128,24,16,130,18,162,50
	db	146,254,128,128,112,16,224,146,130,16,130,2,128,4,168,136,136,136,168,18,168,8
	db	250,136,80,254,240,8,136,40,40,8,168,144,128,128,96,32,160,168,108,254,108,16
	db	66,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34,146,2,130,146,146,16,146
	db	254,40,2,24,16,146,130,2,18,0,146,254,224,254,16,254,2,0,0,69,84,5,61,0,68,73
	db	144,75,84,165,4,77,60,40,9,64,64,149,68,4,36,164,68,124,64,254,16,248,56,60,64,69
	db	66,58

;********************************************************************************

GLCDCHARCOL6EXTENDED1
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL6EXTENDED1
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL6EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL6EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL6EXTENDED1
	db	239,56,254,12,10,204,102,124,32,4,64,56,16,162,136,112,28,0,0,14,254,84,200,68
	db	0,130,56,16,16,0,16,0,8,138,128,146,150,254,138,146,18,146,82,0,0,130,40,40,18,130
	db	36,146,130,68,146,18,146,16,130,126,68,128,4,32,130,18,66,82,146,2,128,64,128,40
	db	16,138,130,32,254,4,128,8,168,136,136,144,168,2,168,8,128,122,136,128,8,8,136,40
	db	48,8,168,128,64,64,128,80,160,152,130,0,16,32,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,36,146,2,132,146,138,16,146,130,68,4,4,32,146,130,2,18,0
	db	130,2,16,68,40,16,194,0,0,56,85,4,64,0,56,78,104,77,84,67,4,73,64,68,9,32,32,171
	db	68,124,36,164,76,4,64,68,40,64,64,65,65,68,65,65

;********************************************************************************

GLCDCHARCOL7EXTENDED1
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL7EXTENDED1
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL7EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL7EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL7EXTENDED1
	db	239,16,0,10,6,136,34,56,62,8,32,16,16,128,128,64,4,0,0,0,40,36,196,160,0,0,0,40
	db	16,0,16,0,4,124,0,140,98,32,114,96,14,108,60,0,0,0,40,16,12,124,248,108,68,56
	db	130,2,244,254,0,2,130,128,254,254,124,12,188,140,100,2,126,62,126,198,14,134,0,64
	db	0,8,128,0,240,112,64,254,48,4,120,240,0,0,0,0,240,240,112,16,248,16,64,64,248,56
	db	120,136,120,136,0,0,0,16,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	248,108,2,248,130,134,254,124,0,130,248,254,254,130,124,254,12,0,130,2,14,56
	db	198,14,188,0,0,68,68,120,32,0,68,48,4,49,68,1,120,62,32,0,126,124,28,65,56,4,24,72
	db	52,4,60,56,68,60,60,32,60,56,60,60

;********************************************************************************

;Source: GLCD_ILI9341.H (691)
GLCDCLS_ILI9341
;dim ILI9341SendWord as word
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,ACCESS
	clrf	GLCD_YORDINATE_H,ACCESS
;SetAddressWindow_ILI9341 ( 0, 0, ILI9341_GLCD_WIDTH -1 , ILI9341_GLCD_HEIGHT-1 )
	banksel	_X1
	clrf	_X1,BANKED
	clrf	_X1_H,BANKED
	clrf	_Y1,BANKED
	clrf	_Y1_H,BANKED
	movlw	1
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	movwf	_X2,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	_X2_H,BANKED
	movlw	1
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	_Y2,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	_Y2_H,BANKED
	banksel	0
	call	SETADDRESSWINDOW_ILI9341
;ILI9341SendWord = GLCDBACKGROUND
	movff	GLCDBACKGROUND,ILI9341SENDWORD
	movff	GLCDBACKGROUND_H,ILI9341SENDWORD_H
;ILI9341_CS=0
	banksel	LATC
	bcf	LATC,1,BANKED
;SPI mode
;set ILI9341_DC ON
	bsf	LATC,0,BANKED
;repeat 320*240 times... this is faster!
;repeat 2 ' ILI9341_GLCD_WIDTH
	movlw	2
	banksel	SYSREPEATTEMP2
	movwf	SysRepeatTemp2,BANKED
SysRepeatLoop2
;repeat 38400  'ILI9341_GLCD_HEIGHT
	clrf	SysRepeatTemp3,BANKED
	movlw	150
	movwf	SysRepeatTemp3_H,BANKED
SysRepeatLoop3
;SPI handler
;FastHWSPITransfer  ILI9341SendWord_h
	movff	ILI9341SENDWORD_H,SPITXDATA
	banksel	0
	call	FASTHWSPITRANSFER
;FastHWSPITransfer  ILI9341SendWord
	movff	ILI9341SENDWORD,SPITXDATA
	call	FASTHWSPITRANSFER
;end of SPI
;end repeat
	banksel	SYSREPEATTEMP3
	decfsz	SysRepeatTemp3,F,BANKED
	bra	SysRepeatLoop3
	decfsz	SysRepeatTemp3_H,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;end repeat
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;ILI9341_CS = 1
	banksel	LATC
	bsf	LATC,1,BANKED
	banksel	0
	return

;********************************************************************************

;Source: GLCD_ILI9341.H (916)
GLCDDRAWCHAR_ILI9341
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;dim CharCol, CharRow, GLCDTemp as word
;CharCode -= 15
	movlw	15
	subwf	CHARCODE,F,ACCESS
;CharCol=0
	clrf	CHARCOL,ACCESS
	clrf	CHARCOL_H,ACCESS
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
	bra	ENDIF49
;CharLocY=CharLocY-1
	movlw	1
	subwf	CHARLOCY,F,ACCESS
	movlw	0
	subwfb	CHARLOCY_H,F,ACCESS
;end if
ENDIF49
;For CurrCharCol = 1 to 5
;Legacy method
	clrf	CURRCHARCOL,ACCESS
SysForLoop9
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
	rcall	GLCDCHARCOL3EXTENDED1
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
	rcall	GLCDCHARCOL4EXTENDED1
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
	rcall	GLCDCHARCOL5EXTENDED1
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
	rcall	GLCDCHARCOL6EXTENDED1
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
	rcall	GLCDCHARCOL7EXTENDED1
	movwf	CURRCHARVAL,ACCESS
;End Select
SysSelectEnd2
;CharRow=0
	clrf	CHARROW,ACCESS
	clrf	CHARROW_H,ACCESS
;For CurrCharRow = 1 to 8
;Legacy method
	clrf	CURRCHARROW,ACCESS
SysForLoop10
	incf	CURRCHARROW,F,ACCESS
;CharColS=0
	clrf	CHARCOLS,ACCESS
;For Col=1 to GLCDfntDefaultsize
;Legacy method
	clrf	COL,ACCESS
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd11
SysForLoop11
	incf	COL,F,ACCESS
;CharColS +=1
	incf	CHARCOLS,F,ACCESS
;CharRowS=0
	clrf	CHARROWS,ACCESS
;For Row=1 to GLCDfntDefaultsize
;Legacy method
	banksel	ROW
	clrf	ROW,BANKED
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd12
SysForLoop12
	incf	ROW,F,BANKED
;CharRowS +=1
	incf	CHARROWS,F,ACCESS
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0,ACCESS
	bra	ELSE52_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, LineColour
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	CHARCOL_H,W,ACCESS
	addwfc	CHARLOCX_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp2,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	CHARROW_H,W,ACCESS
	addwfc	CHARLOCY_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp2,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	rcall	PSET_ILI9341
;Else
	bra	ENDIF52
ELSE52_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, GLCDBACKGROUND
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	CHARCOL_H,W,ACCESS
	addwfc	CHARLOCX_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp2,W,BANKED
	movwf	GLCDX,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	GLCDX_H,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	CHARROW_H,W,ACCESS
	addwfc	CHARLOCY_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp2,W,BANKED
	movwf	GLCDY,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	GLCDY_H,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	banksel	0
	rcall	PSET_ILI9341
;End if
ENDIF52
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	banksel	ROW
	subwf	ROW,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop12
SysForLoopEnd12
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	subwf	COL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop11
SysForLoopEnd11
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
	bra	SysForLoop10
SysForLoopEnd10
;CharCol +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	addwf	CHARCOL,F,ACCESS
	movlw	0
	addwfc	CHARCOL_H,F,ACCESS
;Next
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
	banksel	0
	return

;********************************************************************************

;Source: GLCD_ILI9341.H (886)
GLCDDRAWSTRING_ILI9341
;dim GLCDPrintLoc as word
;GLCDPrintLoc = StringLocX
	movff	STRINGLOCX,GLCDPRINTLOC
	movff	STRINGLOCX_H,GLCDPRINTLOC_H
;for xchar = 1 to Chars(0)
;Legacy method
	banksel	XCHAR
	clrf	XCHAR,BANKED
	movff	SysCHARSHandler,AFSR0
	movff	SysCHARSHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd8
SysForLoop8
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
	rcall	GLCDDRAWCHAR_ILI9341
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1509)
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
	bra	SysForLoop8
SysForLoopEnd8
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (1272)
GLCDPRINT7
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
	bra	SysForLoopEnd1
SysForLoop1
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
	rcall	GLCDDRAWCHAR_ILI9341
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1509)
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

;Overloaded signature: WORD:WORD:LONG:, Source: glcd.h (1384)
GLCDPRINT10
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	banksel	SYSPRINTBUFFLEN
	clrf	SYSPRINTBUFFLEN,BANKED
;Do
SysDoLoop_S3
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
	bra	SysDoLoop_S3
SysDoLoop_E3
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
	bra	SysForLoopEnd2
SysForLoop2
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
	rcall	GLCDDRAWCHAR_ILI9341
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1509)
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
	bra	SysForLoop2
SysForLoopEnd2
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
	banksel	0
	return

;********************************************************************************

;Source: GLCD_ILI9341.H (1363)
GLCDROTATE_ILI9341
;SendCommand_ILI9341 ( ILI9341_MADCTL )
	movlw	54
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;select case GLCDRotateState
;case PORTRAIT
SysSelect3Case1
	movlw	4
	subwf	GLCDROTATESTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;ILI9341_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;ILI9341_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT,ACCESS
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H,ACCESS
;SendData_ILI9341( ILI9341_MADCTL_MX | ILI9341_MADCTL_BGR)
	movlw	72
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;case LANDSCAPE
	bra	SysSelectEnd3
SysSelect3Case2
	decf	GLCDROTATESTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case3
;ILI9341_GLCD_WIDTH = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEWIDTH,ACCESS
	movlw	1
	movwf	GLCDDEVICEWIDTH_H,ACCESS
;ILI9341_GLCD_HEIGHT = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;SendData_ILI9341( ILI9341_MADCTL_MV | ILI9341_MADCTL_BGR )
	movlw	40
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;case PORTRAIT_REV
	bra	SysSelectEnd3
SysSelect3Case3
	movlw	2
	subwf	GLCDROTATESTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case4
;ILI9341_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;ILI9341_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT,ACCESS
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H,ACCESS
;SendData_ILI9341( ILI9341_MADCTL_MY | ILI9341_MADCTL_BGR)
	movlw	136
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;case LANDSCAPE_REV
	bra	SysSelectEnd3
SysSelect3Case4
	movlw	3
	subwf	GLCDROTATESTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case5
;ILI9341_GLCD_WIDTH = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEWIDTH,ACCESS
	movlw	1
	movwf	GLCDDEVICEWIDTH_H,ACCESS
;ILI9341_GLCD_HEIGHT = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEHEIGHT,ACCESS
	clrf	GLCDDEVICEHEIGHT_H,ACCESS
;SendData_ILI9341(  ILI9341_MADCTL_MV | ILI9341_MADCTL_MY | ILI9341_MADCTL_MX | ILI9341_MADCTL_BGR )
	movlw	232
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;case else
	bra	SysSelectEnd3
SysSelect3Case5
;ILI9341_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;ILI9341_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT,ACCESS
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H,ACCESS
;SendData_ILI9341( ILI9341_MADCTL_MX | ILI9341_MADCTL_BGR )
	movlw	72
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;end select
SysSelectEnd3
	return

;********************************************************************************

;Source: hwspi.h (862)
HWSPITRANSFER
;One byte transfer count
;SPI1TCNTL = 1
	movlw	1
	movwf	SPI1TCNTL,BANKED
;SPI1TXB = SPITxData
	movff	SPITXDATA,SPI1TXB
;wait while SPI1RXIF = SPI_RX_IN_PROGRESS
SysWaitLoop1
	btfss	PIR6,SPI1RXIF,ACCESS
	bra	SysWaitLoop1
;SPIRxData = SPI1RXB
	movff	SPI1RXB,SPIRXDATA
	return

;********************************************************************************

;Source: GLCD_ILI9341.H (240)
INITGLCD_ILI9341
;Mapped to global variables to same RAM
;dim ILI9341_GLCD_HEIGHT, ILI9341_GLCD_WIDTH as word
;Setup code for ILI9341 controllers
;SPI
;ILI9341_SPI_MODE_SCRIPT
;8BIT mode
;ILI9341_8BIT_MODE_SCRIPT
;SPI mode!!!
;Pin directions
;Dir ILI9341_CS Out
	banksel	TRISC
	bcf	TRISC,1,BANKED
;Dir ILI9341_DC Out
	bcf	TRISC,0,BANKED
;Dir ILI9341_RST Out
	bcf	TRISC,2,BANKED
;Dir ILI9341_DO Out
	bcf	TRISC,4,BANKED
;Dir ILI9341_SCK Out
	bcf	TRISC,3,BANKED
;harware SPI mode
;SPI constant used equates to HWSPIMODESCRIPT
;SPIMode HWSPIMODESCRIPT, HWSPIClockModeSCRIPT
	movlw	12
	banksel	SPICURRENTMODE
	movwf	SPICURRENTMODE,BANKED
	clrf	SPICLOCKMODE,BANKED
	banksel	0
	call	SPIMODE358
;Set ILI9341_CS On
	banksel	LATC
	bsf	LATC,1,BANKED
;Set ILI9341_DC On
	bsf	LATC,0,BANKED
;Reset display
;Wait 50 ms
	movlw	50
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	banksel	0
	call	Delay_MS
;Set ILI9341_RST On
	banksel	LATC
	bsf	LATC,2,BANKED
;Wait 15 ms
	movlw	15
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	banksel	0
	call	Delay_MS
;Reset sequence (lower line for at least 10 us)
;Set ILI9341_RST Off
	banksel	LATC
	bcf	LATC,2,BANKED
;Wait 15 us
	movlw	80
	movwf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
;Set ILI9341_RST On
	bsf	LATC,2,BANKED
;Wait 15 ms
	movlw	15
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	banksel	0
	call	Delay_MS
;SendCommand_ILI9341(0xEF)
	movlw	239
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x03)
	movlw	3
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x80)
	movlw	128
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x02)
	movlw	2
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(0xCF)
	movlw	207
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x00)
	clrf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0XC1)
	movlw	193
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0X30)
	movlw	48
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(0xED)
	movlw	237
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x64)
	movlw	100
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x03)
	movlw	3
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0X12)
	movlw	18
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0X81)
	movlw	129
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(0xE8)
	movlw	232
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x85)
	movlw	133
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x00)
	clrf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x78)
	movlw	120
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(0xCB)
	movlw	203
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x39)
	movlw	57
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x2C)
	movlw	44
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x00)
	clrf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x34)
	movlw	52
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x02)
	movlw	2
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(0xF7)
	movlw	247
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x20)
	movlw	32
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(0xEA)
	movlw	234
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x00)
	clrf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x00)
	clrf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_PWCTR1)    'Power control
	movlw	192
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x2B)   'VRH[5:0]
	movlw	43
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_PWCTR2)    'Power control
	movlw	193
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x10)   'SAP[2:0];BT[3:0]
	movlw	16
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_VMCTR1)    'VCM control
	movlw	197
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x3e) '???????
	movlw	62
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x28)
	movlw	40
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_VMCTR2)    'VCM control2
	movlw	199
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x86)  '--
	movlw	134
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_MADCTL)    ' Memory Access Control
	movlw	54
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(ILI9341_MADCTL_MX | ILI9341_MADCTL_BGR)
	movlw	72
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_PIXFMT)
	movlw	58
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x55)
	movlw	85
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_FRMCTR1)
	movlw	177
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x00)
	clrf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x18)
	movlw	24
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_DFUNCTR)    ' Display Function Control
	movlw	182
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x08)
	movlw	8
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x82)
	movlw	130
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x27)
	movlw	39
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(0xF2)    ' 3Gamma Function Disable
	movlw	242
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x00)
	clrf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_GAMMASET)    'Gamma curve selected
	movlw	38
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x01)
	movlw	1
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_GMCTRP1)    'Set Gamma
	movlw	224
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x0F)
	movlw	15
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x31)
	movlw	49
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x2B)
	movlw	43
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x0C)
	movlw	12
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x0E)
	movlw	14
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x08)
	movlw	8
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x4E)
	movlw	78
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0xF1)
	movlw	241
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x37)
	movlw	55
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x07)
	movlw	7
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x10)
	movlw	16
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x03)
	movlw	3
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x0E)
	movlw	14
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x09)
	movlw	9
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x00)
	clrf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_GMCTRN1)    'Set Gamma
	movlw	225
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341(0x00)
	clrf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x0E)
	movlw	14
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x14)
	movlw	20
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x03)
	movlw	3
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x11)
	movlw	17
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x07)
	movlw	7
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x31)
	movlw	49
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0xC1)
	movlw	193
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x48)
	movlw	72
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x08)
	movlw	8
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x0F)
	movlw	15
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x0C)
	movlw	12
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x31)
	movlw	49
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x36)
	movlw	54
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendData_ILI9341(0x0F)
	movlw	15
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_SLPOUT)    'Exit Sleep
	movlw	17
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;wait 150 ms
	movlw	150
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SendCommand_ILI9341(ILI9341_DISPON)    'Display on
	movlw	41
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;Default Colours
;GLCDBACKGROUND = ILI9341_BLACK
	clrf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = ILI9341_WHITE
	setf	GLCDFOREGROUND,ACCESS
	setf	GLCDFOREGROUND_H,ACCESS
;Variables required for device
;ILI9341_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH,ACCESS
	clrf	GLCDDEVICEWIDTH_H,ACCESS
;ILI9341_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT,ACCESS
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDFontWidth = 6
	movlw	6
	movwf	GLCDFONTWIDTH,ACCESS
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT,ACCESS
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDfntDefaultHeight = 7  'used by GLCDPrintString and GLCDPrintStringLn
	movlw	7
	movwf	GLCDFNTDEFAULTHEIGHT,ACCESS
;GLCDRotateState = Portrait
	movlw	4
	movwf	GLCDROTATESTATE,ACCESS
;Clear screen
;GLCDCLS  // use standard CLS
	rcall	GLCDCLS_ILI9341
;SendCommand_ILI9341(ILI9341_DISPON)    'Display on
	movlw	41
	movwf	ILI9341SENDBYTE,ACCESS
	bra	SENDCOMMAND_ILI9341

;********************************************************************************

;Source: 230_spi_glcd_using_ILI9341.gcb (69)
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
;Module: SPI
;RC4PPS = 0x1B;  //RC4->SPI1:SDO1;
	movlw	27
	movwf	RC4PPS,BANKED
;SPI1SCKPPS = 0x13;  //RC3->SPI1:SCK1;
	movlw	19
	movwf	SPI1SCKPPS,BANKED
;RC3PPS = 0x1A;  //RC3->SPI1:SCK1;
	movlw	26
	movwf	RC3PPS,BANKED
	banksel	0
	return

;********************************************************************************

;Source: system.h (201)
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
	bra	ELSE40_1
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;clear output string
;Pad=""
	lfsr	1,PAD
	movlw	low StringTable107
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable107
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable107
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
	bra	SysForLoopEnd5
SysForLoop5
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
	bra	SysForLoop5
SysForLoopEnd5
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
	call	SYSCOMPLESSTHAN
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
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
	bra	SysForLoop6
SysForLoopEnd6
;set new length to PAD
;Pad(0) = SysStrLen
	movffl	SYSSTRLEN,SYSPAD_0
;else
	bra	ENDIF40
ELSE40_1
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
	bra	SysForLoopEnd7
SysForLoop7
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
	bra	SysForLoop7
SysForLoopEnd7
;PAD(0) = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	POSTINC0,SysArrayTemp1
	movffl	SysArrayTemp1,SYSPAD_0
;End If
ENDIF40
	banksel	0
	return

;********************************************************************************

;Source: GLCD_ILI9341.H (1099)
PSET_ILI9341
;SetAddressWindow_ILI9341 ( GLCDX, GLCDY, GLCDX, GLCDY )
	movff	GLCDX,_X1
	movff	GLCDX_H,_X1_H
	movff	GLCDY,_Y1
	movff	GLCDY_H,_Y1_H
	movff	GLCDX,_X2
	movff	GLCDX_H,_X2_H
	movff	GLCDY,_Y2
	movff	GLCDY_H,_Y2_H
	rcall	SETADDRESSWINDOW_ILI9341
;SendWord_ILI9341 GLCDColour
	movff	GLCDCOLOUR,ILI9341SENDWORD
	movff	GLCDCOLOUR_H,ILI9341SENDWORD_H
	bra	SENDWORD_ILI9341

;********************************************************************************

;Source: GLCD_ILI9341.H (1111)
SENDCOMMAND_ILI9341
;SPI mode
;set ILI9341_CS OFF;
	banksel	LATC
	bcf	LATC,1,BANKED
;set ILI9341_DC OFF;
	bcf	LATC,0,BANKED
;SPITransfer  ILI9341SendByte,  ILI9341TempOut
	movff	ILI9341SENDBYTE,SPITXDATA
	banksel	0
	rcall	HWSPITRANSFER
	movff	SPIRXDATA,ILI9341TEMPOUT
;set ILI9341_CS ON;
	banksel	LATC
	bsf	LATC,1,BANKED
;exit sub
	banksel	0
	return
	return

;********************************************************************************

;Source: GLCD_ILI9341.H (1177)
SENDDATA_ILI9341
;SPI mode
;set ILI9341_CS OFF;
	banksel	LATC
	bcf	LATC,1,BANKED
;set ILI9341_DC ON;
	bsf	LATC,0,BANKED
;SPITransfer  ILI9341SendByte,  ILI9341TempOut
	movff	ILI9341SENDBYTE,SPITXDATA
	banksel	0
	rcall	HWSPITRANSFER
	movff	SPIRXDATA,ILI9341TEMPOUT
;set ILI9341_CS ON;
	banksel	LATC
	bsf	LATC,1,BANKED
;exit sub
	banksel	0
	return
	return

;********************************************************************************

;Source: GLCD_ILI9341.H (1243)
SENDWORD_ILI9341
;dim ILI9341SendWord as word
;SPI mode
;set ILI9341_CS OFF;
	banksel	LATC
	bcf	LATC,1,BANKED
;set ILI9341_DC ON;
	bsf	LATC,0,BANKED
;SPITransfer  ILI9341SendWord_H,  ILI9341TempOut
	movff	ILI9341SENDWORD_H,SPITXDATA
	banksel	0
	rcall	HWSPITRANSFER
	movff	SPIRXDATA,ILI9341TEMPOUT
;SPITransfer  ILI9341SendWord,  ILI9341TempOut
	movff	ILI9341SENDWORD,SPITXDATA
	rcall	HWSPITRANSFER
	movff	SPIRXDATA,ILI9341TEMPOUT
;set ILI9341_CS ON;
	banksel	LATC
	bsf	LATC,1,BANKED
;exit sub
	banksel	0
	return
	return

;********************************************************************************

;Source: GLCD_ILI9341.H (1326)
SETADDRESSWINDOW_ILI9341
;SendCommand_ILI9341(ILI9341_CASET); // Column addr set
	movlw	42
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341 _x1_H
	movff	_X1_H,ILI9341SENDBYTE
	rcall	SENDDATA_ILI9341
;SendData_ILI9341 _x1
	movff	_X1,ILI9341SENDBYTE
	rcall	SENDDATA_ILI9341
;SendData_ILI9341 _x2_H
	movff	_X2_H,ILI9341SENDBYTE
	rcall	SENDDATA_ILI9341
;SendData_ILI9341 _x2
	movff	_X2,ILI9341SENDBYTE
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_PASET); // Row addr set
	movlw	43
	movwf	ILI9341SENDBYTE,ACCESS
	rcall	SENDCOMMAND_ILI9341
;SendData_ILI9341 _y1_H
	movff	_Y1_H,ILI9341SENDBYTE
	rcall	SENDDATA_ILI9341
;SendData_ILI9341 _y1
	movff	_Y1,ILI9341SENDBYTE
	rcall	SENDDATA_ILI9341
;SendData_ILI9341 _y2_H
	movff	_Y2_H,ILI9341SENDBYTE
	rcall	SENDDATA_ILI9341
;SendData_ILI9341 _y2
	movff	_Y2,ILI9341SENDBYTE
	rcall	SENDDATA_ILI9341
;SendCommand_ILI9341(ILI9341_RAMWR); // write to RAM
	movlw	44
	movwf	ILI9341SENDBYTE,ACCESS
	bra	SENDCOMMAND_ILI9341

;********************************************************************************

;Source: 230_spi_glcd_using_ILI9341.gcb (278)
SHOWCASE1
;GLCDRotate ( Portrait )
	movlw	4
	movwf	GLCDROTATESTATE,ACCESS
	rcall	GLCDROTATE_ILI9341
;GLCDDrawString (2, 1, "GCB", ILI9341_WHITE )
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	1
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
;Using SYSSTRINGPARAM2*3
	banksel	0
	rcall	GLCDDRAWSTRING_ILI9341
;GLCDDrawString (56,1,"v1.xx", ILI9341_YELLOW )
	movlw	56
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	1
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	movlw	224
	movwf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
;Using SYSSTRINGPARAM2*5
	banksel	0
	rcall	GLCDDRAWSTRING_ILI9341
;GLCDDrawString (2, 16, "DrawStr", ILI9341_WHITE )
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	16
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable6
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
;Using SYSSTRINGPARAM2*7
	banksel	0
	rcall	GLCDDRAWSTRING_ILI9341
;GLCDDrawString ( 60, 31, "Long Number" )
	movlw	60
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	31
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable7
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
;Using SYSSTRINGPARAM2*11
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDDrawString ( 60, 39, "Word Number" )
	movlw	60
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	39
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable8
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
;Using SYSSTRINGPARAM2*11
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDDrawString ( 60, 47, "Byte Number" )
	movlw	60
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	47
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable9
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
;Using SYSSTRINGPARAM2*11
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDDrawString ( 74, 16, "Asc:" )
	movlw	74
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	16
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable10
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
;Using SYSSTRINGPARAM2*4
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;box 0,0,ILI9341_GLCD_WIDTH-1, ILI9341_GLCD_HEIGHT-1, ILI9341_YELLOW
	banksel	LINEX1
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	1
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	LINEX2_H,BANKED
	movlw	1
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	LINEY2_H,BANKED
	movlw	224
	movwf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
	banksel	0
	call	BOX19
;box ILI9341_GLCD_WIDTH-5, ILI9341_GLCD_HEIGHT-5,ILI9341_GLCD_WIDTH-1, ILI9341_GLCD_HEIGHT-1, ILI9341_WHITE
	movlw	5
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	banksel	LINEX1
	movwf	LINEX1,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	LINEX1_H,BANKED
	movlw	5
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	LINEY1,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	LINEY1_H,BANKED
	movlw	1
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	LINEX2_H,BANKED
	movlw	1
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	LINEY2_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
	banksel	0
	call	BOX19
;Circle( ILI9341_GLCD_WIDTH/2, ILI9341_GLCD_HEIGHT/2, 50, ILI9341_SILVER )            ;center
	movff	GLCDDEVICEWIDTH,SysWORDTempA
	movff	GLCDDEVICEWIDTH_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempA,XOFFSET
	movff	SysWORDTempA_H,XOFFSET_H
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempA,YOFFSET
	movff	SysWORDTempA_H,YOFFSET_H
	movlw	50
	movwf	INXRADIUS,ACCESS
	clrf	INXRADIUS_H,ACCESS
	movlw	24
	movwf	LINECOLOUR,ACCESS
	movlw	198
	movwf	LINECOLOUR_H,ACCESS
	movff	GLCD_YORDINATE,YORDINATE
	call	CIRCLE22
;FilledCircle( ILI9341_GLCD_WIDTH/2, ILI9341_GLCD_HEIGHT/2, 25, ILI9341_D_GRAY  )
	movff	GLCDDEVICEWIDTH,SysWORDTempA
	movff	GLCDDEVICEWIDTH_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempA,XOFFSET
	movff	SysWORDTempA_H,XOFFSET_H
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempA,YOFFSET
	movff	SysWORDTempA_H,YOFFSET_H
	movlw	25
	banksel	XRADIUS
	movwf	XRADIUS,BANKED
	clrf	XRADIUS_H,BANKED
	movlw	138
	movwf	LINECOLOUR,ACCESS
	movlw	82
	movwf	LINECOLOUR_H,ACCESS
	banksel	0
	call	FILLEDCIRCLE24
;line 0,  ILI9341_GLCD_HEIGHT-1 , ILI9341_GLCD_WIDTH/2 +100,  (ILI9341_GLCD_HEIGHT /2) - 50, ILI9341_CYAN
	banksel	LINEX1
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	1
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	LINEY1,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	LINEY1_H,BANKED
	movff	GLCDDEVICEWIDTH,SysWORDTempA
	movff	GLCDDEVICEWIDTH_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SYSDIVSUB16
	movlw	100
	addwf	SysWORDTempA,W,ACCESS
	banksel	LINEX2
	movwf	LINEX2,BANKED
	movlw	0
	addwfc	SysWORDTempA_H,W,ACCESS
	movwf	LINEX2_H,BANKED
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movlw	50
	banksel	SYSTEMP1
	subwf	SysTemp1,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	LINEY2_H,BANKED
	setf	LINECOLOUR,ACCESS
	movlw	7
	movwf	LINECOLOUR_H,ACCESS
	banksel	0
	call	_LINE73
;line  0, (ILI9341_GLCD_HEIGHT /2) - 50, ILI9341_GLCD_WIDTH/2 +100, (ILI9341_GLCD_HEIGHT /2) - 50, ILI9341_CYAN
	banksel	LINEX1
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movlw	50
	banksel	SYSTEMP1
	subwf	SysTemp1,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movff	GLCDDEVICEWIDTH,SysWORDTempA
	movff	GLCDDEVICEWIDTH_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SYSDIVSUB16
	movlw	100
	addwf	SysWORDTempA,W,ACCESS
	banksel	LINEX2
	movwf	LINEX2,BANKED
	movlw	0
	addwfc	SysWORDTempA_H,W,ACCESS
	movwf	LINEX2_H,BANKED
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movlw	50
	banksel	SYSTEMP1
	subwf	SysTemp1,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	LINEY2_H,BANKED
	setf	LINECOLOUR,ACCESS
	movlw	7
	movwf	LINECOLOUR_H,ACCESS
	banksel	0
	call	_LINE73
;filledbox 2,ILI9341_GLCD_HEIGHT/2+10,42,ILI9341_GLCD_HEIGHT/2+50, ILI9341_RED
	movlw	2
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SYSDIVSUB16
	movlw	10
	addwf	SysWORDTempA,W,ACCESS
	banksel	LINEY1
	movwf	LINEY1,BANKED
	movlw	0
	addwfc	SysWORDTempA_H,W,ACCESS
	movwf	LINEY1_H,BANKED
	movlw	42
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SYSDIVSUB16
	movlw	50
	addwf	SysWORDTempA,W,ACCESS
	banksel	LINEY2
	movwf	LINEY2,BANKED
	movlw	0
	addwfc	SysWORDTempA_H,W,ACCESS
	movwf	LINEY2_H,BANKED
	clrf	LINECOLOUR,ACCESS
	movlw	248
	movwf	LINECOLOUR_H,ACCESS
	banksel	0
	call	FILLEDBOX_ILI9341
;oldfont = GLCDfntDefaultsize
	movff	GLCDFNTDEFAULTSIZE,OLDFONT
;GLCDfntDefaultsize = 3
	movlw	3
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDDrawString ( 42, ILI9341_GLCD_HEIGHT - 30 , "ILI9341 Driver" , ILI9341_WHITE )
	movlw	42
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	30
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	CHARLOCY,ACCESS
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable11
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
;Using SYSSTRINGPARAM2*14
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDDrawString ( ILI9341_GLCD_WIDTH - 64, 2 , " Aug 2026" , ILI9341_WHITE )
	movlw	64
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	STRINGLOCX_H,BANKED
	movlw	2
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
;Using SYSSTRINGPARAM2*9
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDDrawString ( ILI9341_GLCD_WIDTH - 44, 10 , "HW SPI" , ILI9341_WHITE )
	movlw	44
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	STRINGLOCX_H,BANKED
	movlw	10
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable13
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable13
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable13
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
;Using SYSSTRINGPARAM2*6
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;Revert the font size
;GLCDfntDefaultsize = oldfont
	movff	OLDFONT,GLCDFNTDEFAULTSIZE
;GLCDForeground = ILI9341_WHITE
	setf	GLCDFOREGROUND,ACCESS
	setf	GLCDFOREGROUND_H,ACCESS
;DO forever
SysDoLoop_S1
;GLCDPrint ( 144 , 31, longNumber)
	movlw	144
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	31
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	LONGNUMBER,LCDVALUE
	movff	LONGNUMBER_H,LCDVALUE_H
	movff	LONGNUMBER_U,LCDVALUE_U
	movff	LONGNUMBER_E,LCDVALUE_E
	banksel	0
	call	GLCDPRINT10
;GLCDPrint ( 144 , 39, pad( str(wordnumber),5))
	movlw	144
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	39
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	WORDNUMBER,SYSVALTEMP
	movff	WORDNUMBER_H,SYSVALTEMP_H
	banksel	0
	call	FN_STR
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	5
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable65
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable65
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable65
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSSYSINSTRING3HANDLER
	movwf	SysSYSINSTRING3Handler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING3Handler_H,BANKED
;Using SYSSTRINGPARAM2*1
	banksel	0
	rcall	FN_PAD
	movlw	low PAD
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high PAD
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINT7
;GLCDPrint ( 144 , 47, pad( str(bytenumber),3))
	movlw	144
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	47
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	BYTENUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	banksel	0
	call	FN_STR
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	3
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable65
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable65
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable65
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSSYSINSTRING3HANDLER
	movwf	SysSYSINSTRING3Handler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING3Handler_H,BANKED
;Using SYSSTRINGPARAM2*1
	banksel	0
	rcall	FN_PAD
	movlw	low PAD
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high PAD
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINT7
;GLCDDrawChar(54, 16, CCount )
	movlw	54
	movwf	CHARLOCX,ACCESS
	clrf	CHARLOCX_H,ACCESS
	movlw	16
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	movff	CCOUNT,CHARCODE
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	GLCDDRAWCHAR_ILI9341
;Box 52,15,62,26, ILI9341_WHITE                'Draw a box around the Char below
	movlw	52
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	15
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	62
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	26
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
	banksel	0
	call	BOX19
;GLCDDrawString ( 104, 18 , pad( str(CCount),3) )
	movlw	104
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	18
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	movff	CCOUNT,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	banksel	0
	rcall	FN_STR
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	3
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable65
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable65
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable65
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSSYSINSTRING3HANDLER
	movwf	SysSYSINSTRING3Handler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING3Handler_H,BANKED
;Using SYSSTRINGPARAM2*1
	banksel	0
	call	FN_PAD
	movlw	low PAD
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high PAD
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;CCount++
	incf	CCOUNT,F,ACCESS
;if CCount = 0 then CCount = 31
	movf	CCOUNT,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF1
;if CCount = 0 then CCount = 31
	movlw	31
	movwf	CCOUNT,ACCESS
;if CCount = 0 then CCount = 31
ENDIF1
;if CCount = 128 then CCount = 192
	movlw	128
	subwf	CCOUNT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF2
;if CCount = 128 then CCount = 192
	movlw	192
	movwf	CCOUNT,ACCESS
;if CCount = 128 then CCount = 192
ENDIF2
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
;wordNumber = wordNumber + 3
	movlw	3
	addwf	WORDNUMBER,F,BANKED
	movlw	0
	addwfc	WORDNUMBER_H,F,BANKED
;byteNumber++
	incf	BYTENUMBER,F,ACCESS
;LOOP
	bra	SysDoLoop_S1
SysDoLoop_E1
	return

;********************************************************************************

;Source: 230_spi_glcd_using_ILI9341.gcb (344)
SHOWCASE2
;GLCDRotate ( Landscape_rev )
	movlw	3
	movwf	GLCDROTATESTATE,ACCESS
	call	GLCDROTATE_ILI9341
;GLCDDrawString (2, 1, "GCB",ILI9341_WHITE)
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	1
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
;Using SYSSTRINGPARAM2*3
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDDrawString (56,1,"v1.xx",ILI9341_YELLOW)
	movlw	56
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	1
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	movlw	224
	movwf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
;Using SYSSTRINGPARAM2*5
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDDrawString (2, 18, "DrawStr",ILI9341_WHITE)
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	18
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable6
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
;Using SYSSTRINGPARAM2*7
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDDrawString ( 2, 52, "Long:" )
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	52
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable15
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
;Using SYSSTRINGPARAM2*5
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDDrawString ( 2, 70, "Word:" )
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	70
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable16
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable16
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable16
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
;Using SYSSTRINGPARAM2*5
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDDrawString ( 2, 88, "Byte:" )
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	88
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable17
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable17
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable17
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
;Using SYSSTRINGPARAM2*5
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDDrawString ( 128, 18, "Asc:"+"  " )
	movlw	128
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	18
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable10
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRINGPART
	movlw	low StringTable18
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable18
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable18
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
;Using SYSSTRINGPARAM2*4
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;box 0,0,ILI9341_GLCD_WIDTH-1, ILI9341_GLCD_HEIGHT-1, ILI9341_YELLOW
	banksel	LINEX1
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	1
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	LINEX2_H,BANKED
	movlw	1
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	LINEY2_H,BANKED
	movlw	224
	movwf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
	banksel	0
	call	BOX19
;box ILI9341_GLCD_WIDTH-5, ILI9341_GLCD_HEIGHT-5,ILI9341_GLCD_WIDTH-1, ILI9341_GLCD_HEIGHT-1, ILI9341_WHITE
	movlw	5
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	banksel	LINEX1
	movwf	LINEX1,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	LINEX1_H,BANKED
	movlw	5
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	LINEY1,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	LINEY1_H,BANKED
	movlw	1
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	LINEX2_H,BANKED
	movlw	1
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	LINEY2_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
	banksel	0
	call	BOX19
;Circle( ILI9341_GLCD_WIDTH/2, ILI9341_GLCD_HEIGHT/2, 50, ILI9341_SILVER )            ;center
	movff	GLCDDEVICEWIDTH,SysWORDTempA
	movff	GLCDDEVICEWIDTH_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,XOFFSET
	movff	SysWORDTempA_H,XOFFSET_H
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,YOFFSET
	movff	SysWORDTempA_H,YOFFSET_H
	movlw	50
	movwf	INXRADIUS,ACCESS
	clrf	INXRADIUS_H,ACCESS
	movlw	24
	movwf	LINECOLOUR,ACCESS
	movlw	198
	movwf	LINECOLOUR_H,ACCESS
	movff	GLCD_YORDINATE,YORDINATE
	call	CIRCLE22
;FilledCircle( ILI9341_GLCD_WIDTH/2, ILI9341_GLCD_HEIGHT/2, 25, ILI9341_D_GRAY  )
	movff	GLCDDEVICEWIDTH,SysWORDTempA
	movff	GLCDDEVICEWIDTH_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,XOFFSET
	movff	SysWORDTempA_H,XOFFSET_H
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,YOFFSET
	movff	SysWORDTempA_H,YOFFSET_H
	movlw	25
	banksel	XRADIUS
	movwf	XRADIUS,BANKED
	clrf	XRADIUS_H,BANKED
	movlw	138
	movwf	LINECOLOUR,ACCESS
	movlw	82
	movwf	LINECOLOUR_H,ACCESS
	banksel	0
	call	FILLEDCIRCLE24
;line 0,  ILI9341_GLCD_HEIGHT-1 , ILI9341_GLCD_WIDTH/2 +100,  (ILI9341_GLCD_HEIGHT /2) - 50, ILI9341_CYAN
	banksel	LINEX1
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	1
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	LINEY1,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	LINEY1_H,BANKED
	movff	GLCDDEVICEWIDTH,SysWORDTempA
	movff	GLCDDEVICEWIDTH_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSDIVSUB16
	movlw	100
	addwf	SysWORDTempA,W,ACCESS
	banksel	LINEX2
	movwf	LINEX2,BANKED
	movlw	0
	addwfc	SysWORDTempA_H,W,ACCESS
	movwf	LINEX2_H,BANKED
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movlw	50
	banksel	SYSTEMP1
	subwf	SysTemp1,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	LINEY2_H,BANKED
	setf	LINECOLOUR,ACCESS
	movlw	7
	movwf	LINECOLOUR_H,ACCESS
	banksel	0
	call	_LINE73
;line  0, (ILI9341_GLCD_HEIGHT /2) - 50, ILI9341_GLCD_WIDTH/2 +100, (ILI9341_GLCD_HEIGHT /2) - 50, ILI9341_CYAN
	banksel	LINEX1
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movlw	50
	banksel	SYSTEMP1
	subwf	SysTemp1,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movff	GLCDDEVICEWIDTH,SysWORDTempA
	movff	GLCDDEVICEWIDTH_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSDIVSUB16
	movlw	100
	addwf	SysWORDTempA,W,ACCESS
	banksel	LINEX2
	movwf	LINEX2,BANKED
	movlw	0
	addwfc	SysWORDTempA_H,W,ACCESS
	movwf	LINEX2_H,BANKED
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movlw	50
	banksel	SYSTEMP1
	subwf	SysTemp1,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	LINEY2_H,BANKED
	setf	LINECOLOUR,ACCESS
	movlw	7
	movwf	LINECOLOUR_H,ACCESS
	banksel	0
	call	_LINE73
;filledbox 2,ILI9341_GLCD_HEIGHT/2+10,42,ILI9341_GLCD_HEIGHT/2+50, ILI9341_RED
	movlw	2
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSDIVSUB16
	movlw	10
	addwf	SysWORDTempA,W,ACCESS
	banksel	LINEY1
	movwf	LINEY1,BANKED
	movlw	0
	addwfc	SysWORDTempA_H,W,ACCESS
	movwf	LINEY1_H,BANKED
	movlw	42
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movff	GLCDDEVICEHEIGHT,SysWORDTempA
	movff	GLCDDEVICEHEIGHT_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSDIVSUB16
	movlw	50
	addwf	SysWORDTempA,W,ACCESS
	banksel	LINEY2
	movwf	LINEY2,BANKED
	movlw	0
	addwfc	SysWORDTempA_H,W,ACCESS
	movwf	LINEY2_H,BANKED
	clrf	LINECOLOUR,ACCESS
	movlw	248
	movwf	LINECOLOUR_H,ACCESS
	banksel	0
	call	FILLEDBOX_ILI9341
;oldfont = GLCDfntDefaultsize
	movff	GLCDFNTDEFAULTSIZE,OLDFONT
;GLCDfntDefaultsize = 3
	movlw	3
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDDrawString ( 50, ILI9341_GLCD_HEIGHT - 30 , "ILI9341 Driver" , ILI9341_WHITE )
	movlw	50
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	30
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	CHARLOCY,ACCESS
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable11
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
;Using SYSSTRINGPARAM2*14
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDDrawString ( ILI9341_GLCD_WIDTH - 64, 2 , " Aug 2026" , ILI9341_WHITE )
	movlw	64
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	STRINGLOCX_H,BANKED
	movlw	2
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
;Using SYSSTRINGPARAM2*9
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;GLCDDrawString ( ILI9341_GLCD_WIDTH - 42, 10 , "HW SPI" , ILI9341_WHITE )
	movlw	42
	subwf	GLCDDEVICEWIDTH,W,ACCESS
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,ACCESS
	movwf	STRINGLOCX_H,BANKED
	movlw	10
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable13
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable13
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable13
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysCHARSHandler_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
;Using SYSSTRINGPARAM2*6
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;Revert the font size
;GLCDfntDefaultsize = oldfont
	movff	OLDFONT,GLCDFNTDEFAULTSIZE
;GLCDForeground = ILI9341_WHITE
	setf	GLCDFOREGROUND,ACCESS
	setf	GLCDFOREGROUND_H,ACCESS
;BigPrint_ILI9341 ( 100 , ILI9341_GLCD_HEIGHT - 60 , "GCBASIC" )
	movlw	100
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	60
	subwf	GLCDDEVICEHEIGHT,W,ACCESS
	movwf	PRINTLOCY,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,ACCESS
	movwf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable19
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movff	GLCDFOREGROUND,COLOR
	movff	GLCDFOREGROUND_H,COLOR_H
;Using SYSSTRINGPARAM2*7
	banksel	0
	call	BIGPRINT_ILI9341
;DO forever
SysDoLoop_S2
;GLCDPrint ( 64 , 52, longNumber)
	movlw	64
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	52
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	LONGNUMBER,LCDVALUE
	movff	LONGNUMBER_H,LCDVALUE_H
	movff	LONGNUMBER_U,LCDVALUE_U
	movff	LONGNUMBER_E,LCDVALUE_E
	banksel	0
	call	GLCDPRINT10
;GLCDPrint ( 64 , 70, pad( str(wordnumber),5))
	movlw	64
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	70
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	WORDNUMBER,SYSVALTEMP
	movff	WORDNUMBER_H,SYSVALTEMP_H
	banksel	0
	rcall	FN_STR
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	5
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable65
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable65
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable65
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSSYSINSTRING3HANDLER
	movwf	SysSYSINSTRING3Handler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING3Handler_H,BANKED
;Using SYSSTRINGPARAM2*1
	banksel	0
	call	FN_PAD
	movlw	low PAD
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high PAD
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINT7
;GLCDPrint ( 64 , 88, pad( str(bytenumber),3))
	movlw	64
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	88
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	BYTENUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	banksel	0
	rcall	FN_STR
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	3
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable65
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable65
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable65
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSSYSINSTRING3HANDLER
	movwf	SysSYSINSTRING3Handler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING3Handler_H,BANKED
;Using SYSSTRINGPARAM2*1
	banksel	0
	call	FN_PAD
	movlw	low PAD
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high PAD
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINT7
;GLCDDrawChar(104, 20, CCount )
	movlw	104
	movwf	CHARLOCX,ACCESS
	clrf	CHARLOCX_H,ACCESS
	movlw	20
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	movff	CCOUNT,CHARCODE
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	GLCDDRAWCHAR_ILI9341
;Box 98,18,117,42, ILI9341_WHITE               'Draw a box around the Char below
	movlw	98
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	18
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	117
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	42
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	setf	LINECOLOUR,ACCESS
	setf	LINECOLOUR_H,ACCESS
	banksel	0
	call	BOX19
;GLCDDrawString ( 180, 18 , pad( str(CCount),3) )
	movlw	180
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	18
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	movff	CCOUNT,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	banksel	0
	rcall	FN_STR
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	3
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable65
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable65
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable65
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	banksel	SYSSYSINSTRING3HANDLER
	movwf	SysSYSINSTRING3Handler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING3Handler_H,BANKED
;Using SYSSTRINGPARAM2*1
	banksel	0
	call	FN_PAD
	movlw	low PAD
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high PAD
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	GLCDDRAWSTRING_ILI9341
;CCount++
	incf	CCOUNT,F,ACCESS
;if CCount = 0 then CCount = 31
	movf	CCOUNT,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF3
;if CCount = 0 then CCount = 31
	movlw	31
	movwf	CCOUNT,ACCESS
;if CCount = 0 then CCount = 31
ENDIF3
;if CCount = 128 then CCount = 192
	movlw	128
	subwf	CCOUNT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF4
;if CCount = 128 then CCount = 192
	movlw	192
	movwf	CCOUNT,ACCESS
;if CCount = 128 then CCount = 192
ENDIF4
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
;wordNumber = wordNumber + 3
	movlw	3
	addwf	WORDNUMBER,F,BANKED
	movlw	0
	addwfc	WORDNUMBER_H,F,BANKED
;byteNumber++
	incf	BYTENUMBER,F,ACCESS
;LOOP
	bra	SysDoLoop_S2
SysDoLoop_E2
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:, Source: hwspi.h (484)
SPIMODE358
;Supports newer SPI module using the specific SPI module
;SPI1CON0_EN = 0
	bcf	SPI1CON0,EN,BANKED
;SPI1CON1 = 0x00
	clrf	SPI1CON1,BANKED
;If SPIClockMode.0 = Off Then
	banksel	SPICLOCKMODE
	btfsc	SPICLOCKMODE,0,BANKED
	bra	ENDIF88
;SPI1CON1.CKE = 1
	banksel	SPI1CON1
	bsf	SPI1CON1,CKE,BANKED
;End If
ENDIF88
;If SPIClockMode.1 = On Then
	banksel	SPICLOCKMODE
	btfss	SPICLOCKMODE,1,BANKED
	bra	ENDIF89
;SPI1CON1.CKP = 1
	banksel	SPI1CON1
	bsf	SPI1CON1,CKP,BANKED
;End If
ENDIF89
;If SPIClockMode.2 = On Then
	banksel	SPICLOCKMODE
	btfss	SPICLOCKMODE,2,BANKED
	bra	ENDIF90
;SPI1CON1.SSP = 1
	banksel	SPI1CON1
	bsf	SPI1CON1,SSP,BANKED
;End If
ENDIF90
;Transfer
;SPI1CON2 = SPI1CON2 or 3
	movlw	3
	banksel	SPI1CON2
	iorwf	SPI1CON2,F,BANKED
;Select clock source
;SPI1CLK = SSP1_FOSC
	clrf	SPI1CLK,BANKED
;Supports newer SPI module using the specific SPI module
;Select Case SPICurrentMode
;Case MasterUltraFast
SysSelect4Case1
	movlw	14
	banksel	SPICURRENTMODE
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
;assumed that 0 is fastest
;SPI1BAUD = 0
	banksel	SPI1BAUD
	clrf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case MasterFast
	bra	SysSelectEnd4
SysSelect4Case2
	movlw	13
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
;see CDF file for SPIBAUDRATE_SCRIPT
;SPI1BAUD = SPIBAUDRATE_SCRIPT
	movlw	3
	banksel	SPI1BAUD
	movwf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case Master
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	12
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case4
;see CDF file for SPIBAUDRATE_SCRIPT_MASTER
;SPI1BAUD = SPIBAUDRATE_SCRIPT_MASTER
	movlw	9
	banksel	SPI1BAUD
	movwf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case MasterSlow
	bra	SysSelectEnd4
SysSelect4Case4
	movlw	11
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case5
;see CDF file for SPIBAUDRATE_SCRIPT_MASTERSLOW
;SPI1BAUD = SPIBAUDRATE_SCRIPT_MASTERSLOW
	movlw	33
	banksel	SPI1BAUD
	movwf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case Slave
	bra	SysSelectEnd4
SysSelect4Case5
	movf	SPICURRENTMODE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case6
;SPI1CON0.MST = 0
	banksel	SPI1CON0
	bcf	SPI1CON0,MST,BANKED
;Case SlaveSS
	bra	SysSelectEnd4
SysSelect4Case6
	decf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd4
;SPI1CON0.MST = 0
	banksel	SPI1CON0
	bcf	SPI1CON0,MST,BANKED
;End Select
SysSelectEnd4
;Enable SPI
;SPI1CON0_EN = 1
	banksel	SPI1CON0
	bsf	SPI1CON0,EN,BANKED
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
	bra	ENDIF36
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
ENDIF36
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
	bra	ENDIF37
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
ENDIF37
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
	bra	ENDIF38
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
ENDIF38
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
	bra	ENDIF39
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
ENDIF39
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

;Source: system.h (4137)
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

;Source: system.h (4191)
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

;Source: system.h (4501)
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

;Source: system.h (4531)
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

;Source: system.h (4589)
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

;Source: system.h (4973)
SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ELSE33_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF34
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	return
;End If
ENDIF34
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
	bra	ENDIF33
ELSE33_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	return
;End If
;End If
ENDIF33
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

;Source: system.h (3437)
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

;Source: system.h (3505)
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
	bra	ENDIF26
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF26
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
	bra	ENDIF27
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF27
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

;Source: system.h (3581)
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
	bra	ENDIF31
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF31
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
	bra	ENDIF32
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
ENDIF32
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

;Source: system.h (3559)
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
	bra	ENDIF28
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
ENDIF28
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF29
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
ENDIF29
;Call word divide routine
;SysDivSub16
	rcall	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF30
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
ENDIF30
	return

;********************************************************************************

;Source: system.h (2971)
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

;Source: system.h (3088)
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
	bra	ENDIF86
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
ENDIF86
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

;Source: system.h (3069)
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
	bra	ENDIF23
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
ENDIF23
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF24
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
ENDIF24
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF25
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
ENDIF25
	return

;********************************************************************************

;Source: system.h (1963)
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
	db	16,71,76,67,68,80,114,105,110,116,32,83,116,114,105,110,103


StringTable2
	db	9,71,76,67,68,32,102,111,110,116


StringTable3
	db	8,115,105,122,101,32,61,32,51


StringTable4
	db	3,71,67,66


StringTable5
	db	5,118,49,46,120,120


StringTable6
	db	7,68,114,97,119,83,116,114


StringTable7
	db	11,76,111,110,103,32,78,117,109,98,101,114


StringTable8
	db	11,87,111,114,100,32,78,117,109,98,101,114


StringTable9
	db	11,66,121,116,101,32,78,117,109,98,101,114


StringTable10
	db	4,65,115,99,58


StringTable11
	db	14,73,76,73,57,51,52,49,32,68,114,105,118,101,114


StringTable12
	db	9,32,65,117,103,32,50,48,50,54


StringTable13
	db	6,72,87,32,83,80,73


StringTable15
	db	5,76,111,110,103,58


StringTable16
	db	5,87,111,114,100,58


StringTable17
	db	5,66,121,116,101,58


StringTable18
	db	2,32,32


StringTable19
	db	7,71,67,66,65,83,73,67


StringTable65
	db	1,32


StringTable107
	db	0


;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: picas.h (32)
_LINE73
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
	banksel	LINESTEPX
	clrf	LINESTEPX,BANKED
	clrf	LINESTEPX_H,BANKED
;LineStepY = 0
	clrf	LINESTEPY,BANKED
	clrf	LINESTEPY_H,BANKED
;LineDiffX_x2 = 0
	clrf	LINEDIFFX_X2,ACCESS
	clrf	LINEDIFFX_X2_H,ACCESS
;LineDiffY_x2 = 0
	clrf	LINEDIFFY_X2,ACCESS
	clrf	LINEDIFFY_X2_H,ACCESS
;LineErr = 0
	clrf	LINEERR,BANKED
	clrf	LINEERR_H,BANKED
;LineDiffX =  LineX2 -   LineX1
	movf	LINEX1,W,BANKED
	subwf	LINEX2,W,BANKED
	movwf	LINEDIFFX,ACCESS
	movf	LINEX1_H,W,BANKED
	subwfb	LINEX2_H,W,BANKED
	movwf	LINEDIFFX_H,ACCESS
;LineDiffY =  LineY2 -   LineY1
	movf	LINEY1,W,BANKED
	subwf	LINEY2,W,BANKED
	movwf	LINEDIFFY,ACCESS
	movf	LINEY1_H,W,BANKED
	subwfb	LINEY2_H,W,BANKED
	movwf	LINEDIFFY_H,ACCESS
;if (LineDiffX > 0) then
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE18_1
;LineStepX = 1
	movlw	1
	banksel	LINESTEPX
	movwf	LINESTEPX,BANKED
	clrf	LINESTEPX_H,BANKED
;else
	bra	ENDIF18
ELSE18_1
;LineStepX = -1
	banksel	LINESTEPX
	setf	LINESTEPX,BANKED
	setf	LINESTEPX_H,BANKED
;end if
ENDIF18
;if (LineDiffY > 0) then
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE19_1
;LineStepY = 1
	movlw	1
	banksel	LINESTEPY
	movwf	LINESTEPY,BANKED
	clrf	LINESTEPY_H,BANKED
;else
	bra	ENDIF19
ELSE19_1
;LineStepY = -1
	banksel	LINESTEPY
	setf	LINESTEPY,BANKED
	setf	LINESTEPY_H,BANKED
;end if
ENDIF19
;LineDiffX = LineStepX * LineDiffX
	movff	LINESTEPX,SysINTEGERTempA
	movff	LINESTEPX_H,SysINTEGERTempA_H
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	banksel	0
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
	banksel	LINEERR
	movwf	LINEERR,BANKED
	movf	LINEDIFFX_H,W,ACCESS
	subwfb	LINEDIFFY_X2_H,W,ACCESS
	movwf	LINEERR_H,BANKED
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S6
	movff	linex1,SysWORDTempA
	movff	linex1_H,SysWORDTempA_H
	movff	linex2,SysWORDTempB
	movff	linex2_H,SysWORDTempB_H
	banksel	0
	rcall	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E6
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_ILI9341
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
	bra	ELSE21_1
;LineErr += LineDiffY_x2
	movf	LINEDIFFY_X2,W,ACCESS
	banksel	LINEERR
	addwf	LINEERR,F,BANKED
	movf	LINEDIFFY_X2_H,W,ACCESS
	addwfc	LINEERR_H,F,BANKED
;else
	bra	ENDIF21
ELSE21_1
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	movf	LINEDIFFX_X2,W,ACCESS
	subwf	LINEDIFFY_X2,W,ACCESS
	banksel	SYSTEMP3
	movwf	SysTemp3,BANKED
	movf	LINEDIFFX_X2_H,W,ACCESS
	subwfb	LINEDIFFY_X2_H,W,ACCESS
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
ENDIF21
;loop
	bra	SysDoLoop_S6
SysDoLoop_E6
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_ILI9341
;else
	bra	ENDIF20
ELSE20_1
;LineErr = LineDiffX_x2 - LineDiffY
	movf	LINEDIFFY,W,ACCESS
	subwf	LINEDIFFX_X2,W,ACCESS
	banksel	LINEERR
	movwf	LINEERR,BANKED
	movf	LINEDIFFY_H,W,ACCESS
	subwfb	LINEDIFFX_X2_H,W,ACCESS
	movwf	LINEERR_H,BANKED
;do while (   LineY1 <>  LineY2)
SysDoLoop_S7
	movff	liney1,SysWORDTempA
	movff	liney1_H,SysWORDTempA_H
	movff	liney2,SysWORDTempB
	movff	liney2_H,SysWORDTempB_H
	banksel	0
	rcall	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E7
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_ILI9341
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
	bra	ELSE22_1
;LineErr += LineDiffX_x2
	movf	LINEDIFFX_X2,W,ACCESS
	banksel	LINEERR
	addwf	LINEERR,F,BANKED
	movf	LINEDIFFX_X2_H,W,ACCESS
	addwfc	LINEERR_H,F,BANKED
;else
	bra	ENDIF22
ELSE22_1
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	movf	LINEDIFFY_X2,W,ACCESS
	subwf	LINEDIFFX_X2,W,ACCESS
	banksel	SYSTEMP3
	movwf	SysTemp3,BANKED
	movf	LINEDIFFY_X2_H,W,ACCESS
	subwfb	LINEDIFFX_X2_H,W,ACCESS
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
ENDIF22
;loop
	bra	SysDoLoop_S7
SysDoLoop_E7
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_ILI9341
;end if
ENDIF20
	return

;********************************************************************************


 END
