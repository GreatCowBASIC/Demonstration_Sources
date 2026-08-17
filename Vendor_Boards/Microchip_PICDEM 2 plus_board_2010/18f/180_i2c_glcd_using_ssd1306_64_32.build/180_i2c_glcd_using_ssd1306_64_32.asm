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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\180_i2c_glcd_using_ssd1306_64_32.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\180_i2c_glcd_using_ssd1306_64_32.build\180_i2c_glcd_using_ssd1306_64_32.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\180_i2c_glcd_using_ssd1306_64_32.gcb"
 SUBTITLE    "08-15-2026 08:32:15"
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
BYTENUMBER                       EQU    1297          ; 0x511 (SA)
CCOUNT                           EQU    1298          ; 0x512 (SA)
CHARCODE                         EQU    1299          ; 0x513 (SA)
CHARCOL                          EQU    1300          ; 0x514 (SA)
CHARCOLS                         EQU    1302          ; 0x516 (SA)
CHARCOL_H                        EQU    1301          ; 0x515 (SA)
CHARLOCX                         EQU    1303          ; 0x517 (SA)
CHARLOCX_H                       EQU    1304          ; 0x518 (SA)
CHARLOCY                         EQU    1305          ; 0x519 (SA)
CHARLOCY_H                       EQU    1306          ; 0x51A (SA)
CHARROW                          EQU    1307          ; 0x51B (SA)
CHARROWS                         EQU    1309          ; 0x51D (SA)
CHARROW_H                        EQU    1308          ; 0x51C (SA)
COL                              EQU    1310          ; 0x51E (SA)
CURRCHARCOL                      EQU    1311          ; 0x51F (SA)
CURRCHARROW                      EQU    1312          ; 0x520 (SA)
CURRCHARVAL                      EQU    1313          ; 0x521 (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
DRAWLINE                         EQU    1314          ; 0x522 (SA)
DRAWLINE_H                       EQU    1315          ; 0x523 (SA)
GLCDBACKGROUND                   EQU    1316          ; 0x524 (SA)
GLCDBACKGROUND_H                 EQU    1317          ; 0x525 (SA)
GLCDBITNO                        EQU    1318          ; 0x526 (SA)
GLCDCHANGE                       EQU    1319          ; 0x527 (SA)
GLCDCOLOUR                       EQU    1320          ; 0x528 (SA)
GLCDCOLOUR_H                     EQU    1321          ; 0x529 (SA)
GLCDDATATEMP                     EQU    1322          ; 0x52A (SA)
GLCDFNTDEFAULT                   EQU    1323          ; 0x52B (SA)
GLCDFNTDEFAULTHEIGHT             EQU    1324          ; 0x52C (SA)
GLCDFNTDEFAULTSIZE               EQU    1325          ; 0x52D (SA)
GLCDFONTWIDTH                    EQU    1326          ; 0x52E (SA)
GLCDFOREGROUND                   EQU    1327          ; 0x52F (SA)
GLCDFOREGROUND_H                 EQU    1328          ; 0x530 (SA)
GLCDPRINTLEN                     EQU    1329          ; 0x531 (SA)
GLCDPRINTLOC                     EQU    1330          ; 0x532 (SA)
GLCDPRINTLOC_H                   EQU    1331          ; 0x533 (SA)
GLCDPRINT_STRING_COUNTER         EQU    1332          ; 0x534 (SA)
GLCDTEMP                         EQU    1333          ; 0x535 (SA)
GLCDTEMP_H                       EQU    1334          ; 0x536 (SA)
GLCDX                            EQU    1335          ; 0x537 (SA)
GLCDY                            EQU    1336          ; 0x538 (SA)
GLCD_YORDINATE                   EQU    1337          ; 0x539 (SA)
GLCD_YORDINATE_H                 EQU    1338          ; 0x53A (SA)
HI2C1LASTERROR                   EQU    1339          ; 0x53B (SA)
HI2C1STATEMACHINE                EQU    1340          ; 0x53C (SA)
HI2CACKPOLLSTATE                 EQU    1341          ; 0x53D (SA)
HI2CCURRENTMODE                  EQU    1342          ; 0x53E (SA)
HI2CWAITMSSPTIMEOUT              EQU    1343          ; 0x53F (SA)
HWI2C_BUFFER                     EQU    5061          ; 0x13C5
HWI2C_BUFFERLOCATIONCOUNTER      EQU    1344          ; 0x540 (SA)
HWI2C_BUFFERLOCATIONCOUNTERINDEX EQU    1346          ; 0x542 (SA)
HWI2C_BUFFERLOCATIONCOUNTERINDEX EQU    1347          ; 0x543 (SA)
HWI2C_BUFFERLOCATIONCOUNTER_H    EQU    1345          ; 0x541 (SA)
I2CBYTE                          EQU    1348          ; 0x544 (SA)
INXRADIUS                        EQU    1349          ; 0x545 (SA)
INXRADIUS_H                      EQU    1350          ; 0x546 (SA)
LCDVALUE                         EQU    1351          ; 0x547 (SA)
LCDVALUE_E                       EQU    1354          ; 0x54A (SA)
LCDVALUE_H                       EQU    1352          ; 0x548 (SA)
LCDVALUE_U                       EQU    1353          ; 0x549 (SA)
LINECOLOUR                       EQU    1355          ; 0x54B (SA)
LINECOLOUR_H                     EQU    1356          ; 0x54C (SA)
LINEDIFFX                        EQU    1357          ; 0x54D (SA)
LINEDIFFX_H                      EQU    1358          ; 0x54E (SA)
LINEDIFFX_X2                     EQU    1359          ; 0x54F (SA)
LINEDIFFX_X2_H                   EQU    1360          ; 0x550 (SA)
LINEDIFFY                        EQU    1361          ; 0x551 (SA)
LINEDIFFY_H                      EQU    1362          ; 0x552 (SA)
LINEDIFFY_X2                     EQU    1363          ; 0x553 (SA)
LINEDIFFY_X2_H                   EQU    1364          ; 0x554 (SA)
LINEERR                          EQU    1365          ; 0x555 (SA)
LINEERR_H                        EQU    1366          ; 0x556 (SA)
LINESTEPX                        EQU    1367          ; 0x557 (SA)
LINESTEPX_H                      EQU    1368          ; 0x558 (SA)
LINESTEPY                        EQU    1369          ; 0x559 (SA)
LINESTEPY_H                      EQU    1370          ; 0x55A (SA)
LINEX1                           EQU    1371          ; 0x55B (SA)
LINEX1_H                         EQU    1372          ; 0x55C (SA)
LINEX2                           EQU    1373          ; 0x55D (SA)
LINEX2_H                         EQU    1374          ; 0x55E (SA)
LINEY1                           EQU    1375          ; 0x55F (SA)
LINEY1_H                         EQU    1376          ; 0x560
LINEY2                           EQU    1377          ; 0x561
LINEY2_H                         EQU    1378          ; 0x562
LOCX                             EQU    1379          ; 0x563
LOCY                             EQU    1380          ; 0x564
PAD                              EQU    5078          ; 0x13D6
POSCHARX                         EQU    1381          ; 0x565
POSCHARX_H                       EQU    1382          ; 0x566
POSCHARY                         EQU    1383          ; 0x567
PRINTLOCX                        EQU    1384          ; 0x568
PRINTLOCX_H                      EQU    1385          ; 0x569
PRINTLOCY                        EQU    1386          ; 0x56A
PRINTLOCY_H                      EQU    1387          ; 0x56B
RADIUSERR                        EQU    1388          ; 0x56C
RADIUSERR_H                      EQU    1389          ; 0x56D
READAD                           EQU    1390          ; 0x56E
ROW                              EQU    1391          ; 0x56F
SSD1306SENDBYTE                  EQU    1392          ; 0x570
SSD1306_BUFFERALIAS              EQU    5119          ; 0x13FF
SSD1306_BUFFERLOCATIONCALC       EQU    1393          ; 0x571
SSD1306_BUFFERLOCATIONCALC_H     EQU    1394          ; 0x572
STR                              EQU    5034          ; 0x13AA
STRINGPOINTER                    EQU    1395          ; 0x573
SYSARRAYTEMP1                    EQU    1396          ; 0x574
SYSARRAYTEMP2                    EQU    1397          ; 0x575
SYSBYTETEMPA                     EQU    1285          ; 0x505 (SA)
SYSBYTETEMPB                     EQU    1289          ; 0x509 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPA                     EQU    1285          ; 0x505 (SA)
SYSCALCTEMPA_E                   EQU    1288          ; 0x508 (SA)
SYSCALCTEMPA_H                   EQU    1286          ; 0x506 (SA)
SYSCALCTEMPA_U                   EQU    1287          ; 0x507 (SA)
SYSCALCTEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPX_H                   EQU    1281          ; 0x501 (SA)
SYSCHARCOUNT                     EQU    1398          ; 0x576
SYSDIVLOOP                       EQU    1284          ; 0x504 (SA)
SYSDIVMULTA                      EQU    1287          ; 0x507 (SA)
SYSDIVMULTA_H                    EQU    1288          ; 0x508 (SA)
SYSDIVMULTB                      EQU    1291          ; 0x50B (SA)
SYSDIVMULTB_H                    EQU    1292          ; 0x50C (SA)
SYSDIVMULTX                      EQU    1282          ; 0x502 (SA)
SYSDIVMULTX_H                    EQU    1283          ; 0x503 (SA)
SYSFORLOOPABSVALUE10             EQU    1399          ; 0x577
SYSFORLOOPABSVALUE10_H           EQU    1400          ; 0x578
SYSFORLOOPSTEP9                  EQU    1401          ; 0x579
SYSFORLOOPSTEP9_H                EQU    1402          ; 0x57A
SYSINTEGERTEMPA                  EQU    1285          ; 0x505 (SA)
SYSINTEGERTEMPA_H                EQU    1286          ; 0x506 (SA)
SYSINTEGERTEMPB                  EQU    1289          ; 0x509 (SA)
SYSINTEGERTEMPB_H                EQU    1290          ; 0x50A (SA)
SYSINTEGERTEMPX                  EQU    1280          ; 0x500 (SA)
SYSINTEGERTEMPX_H                EQU    1281          ; 0x501 (SA)
SYSLCDPRINTDATAHANDLER           EQU    1403          ; 0x57B
SYSLCDPRINTDATAHANDLER_H         EQU    1404          ; 0x57C
SYSLONGDIVMULTA                  EQU    1405          ; 0x57D
SYSLONGDIVMULTA_E                EQU    1408          ; 0x580
SYSLONGDIVMULTA_H                EQU    1406          ; 0x57E
SYSLONGDIVMULTA_U                EQU    1407          ; 0x57F
SYSLONGDIVMULTB                  EQU    1409          ; 0x581
SYSLONGDIVMULTB_E                EQU    1412          ; 0x584
SYSLONGDIVMULTB_H                EQU    1410          ; 0x582
SYSLONGDIVMULTB_U                EQU    1411          ; 0x583
SYSLONGDIVMULTX                  EQU    1413          ; 0x585
SYSLONGDIVMULTX_E                EQU    1416          ; 0x588
SYSLONGDIVMULTX_H                EQU    1414          ; 0x586
SYSLONGDIVMULTX_U                EQU    1415          ; 0x587
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
SYSPRINTBUFFER                   EQU    5050          ; 0x13BA
SYSPRINTBUFFLEN                  EQU    1417          ; 0x589
SYSREPEATTEMP1                   EQU    1418          ; 0x58A
SYSREPEATTEMP3                   EQU    1419          ; 0x58B
SYSSIGNBYTE                      EQU    1293          ; 0x50D (SA)
SYSSTRDATA                       EQU    1420          ; 0x58C
SYSSTRINGA                       EQU    1287          ; 0x507 (SA)
SYSSTRINGA_H                     EQU    1288          ; 0x508 (SA)
SYSSTRINGLENGTH                  EQU    1286          ; 0x506 (SA)
SYSSTRINGPARAM1                  EQU    5040          ; 0x13B0
SYSSTRINGTEMP                    EQU    1421          ; 0x58D
SYSSTRLEN                        EQU    1422          ; 0x58E
SYSSYSINSTRING3HANDLER           EQU    1423          ; 0x58F
SYSSYSINSTRING3HANDLER_H         EQU    1424          ; 0x590
SYSSYSINSTRINGHANDLER            EQU    1425          ; 0x591
SYSSYSINSTRINGHANDLER_H          EQU    1426          ; 0x592
SYSTEMP1                         EQU    1427          ; 0x593
SYSTEMP1_E                       EQU    1430          ; 0x596
SYSTEMP1_H                       EQU    1428          ; 0x594
SYSTEMP1_U                       EQU    1429          ; 0x595
SYSTEMP2                         EQU    1431          ; 0x597
SYSTEMP2_H                       EQU    1432          ; 0x598
SYSTEMP3                         EQU    1433          ; 0x599
SYSTEMP3_H                       EQU    1434          ; 0x59A
SYSVALTEMP                       EQU    1435          ; 0x59B
SYSVALTEMP_H                     EQU    1436          ; 0x59C
SYSWAITTEMP10US                  EQU    1285          ; 0x505 (SA)
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
WORDNUMBER                       EQU    1437          ; 0x59D
WORDNUMBER_H                     EQU    1438          ; 0x59E
XOFFSET                          EQU    1439          ; 0x59F
XOFFSET_H                        EQU    1440          ; 0x5A0
XRADIUS                          EQU    1441          ; 0x5A1
XRADIUS_H                        EQU    1442          ; 0x5A2
YOFFSET                          EQU    1443          ; 0x5A3
YOFFSET_H                        EQU    1444          ; 0x5A4
YORDINATE                        EQU    1445          ; 0x5A5

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
SYSPAD_0 EQU 5078
SYSREADADBYTE EQU 1390
SYSSTR_0 EQU 5034

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
;
;This demonstration program is a simple GLCD demonstration of the SSD1306 GLCD capabilities.
;
;This program draws lines, boxes, circles and prints strings and numbers.
;The SSD1306 controller a small graphical OLED, suitable for a lot of various projects.
;The display is 19*17 mm, with an active display surface of 0.48inches , and a 64*32 pixel resolution.
;The display is easy to interface, using an I2C type of communication.
;The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;
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
;
;************************************************************************
;@author  EvanV
;@licence GPL
;@version 1.02
;@date    09-01-2026
;
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
;----- Main program
;Dim BYTENUMBER, CCOUNT As Byte
;CCount = 0
	clrf	CCOUNT,ACCESS
;Dim wordNumber, adcval, ldrval As Word
;wordNumber = 0
	banksel	WORDNUMBER
	clrf	WORDNUMBER,BANKED
	clrf	WORDNUMBER_H,BANKED
;byteNumber = 0
	clrf	BYTENUMBER,ACCESS
;GLCDPrint (10, 0,   "GCBASIC")
	movlw	10
	movwf	PRINTLOCX,BANKED
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
;GLCDPrint (10, 8,  "Anobium")
	movlw	10
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	8
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
;Using SYSSTRINGPARAM1*7
	banksel	0
	call	GLCDPRINT5
;GLCDPrint (20, 16, "2026")
	movlw	20
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
;Using SYSSTRINGPARAM1*4
	banksel	0
	call	GLCDPRINT5
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;GLCDCLS
	call	GLCDCLS_SSD1306
;GLCDPrint (20, 0, GLCD_WIDTH )
	movlw	20
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movlw	64
	movwf	LCDVALUE,ACCESS
	clrf	LCDVALUE_H,ACCESS
	clrf	LCDVALUE_U,ACCESS
	clrf	LCDVALUE_E,ACCESS
	banksel	0
	call	GLCDPRINT8
;GLCDPrint (23, 8, "*" )
	movlw	23
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	8
	movwf	PRINTLOCY,BANKED
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
;Using SYSSTRINGPARAM1*1
	banksel	0
	call	GLCDPRINT5
;GLCDPrint (20, 16, GLCD_HEIGHT )
	movlw	20
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	16
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movlw	32
	movwf	LCDVALUE,ACCESS
	clrf	LCDVALUE_H,ACCESS
	clrf	LCDVALUE_U,ACCESS
	clrf	LCDVALUE_E,ACCESS
	banksel	0
	call	GLCDPRINT8
;Wait 3 s
	movlw	3
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;GLCDCLS
	call	GLCDCLS_SSD1306
;GLCDPrint 0, 0,   "Version 1"
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*9
	banksel	0
	call	GLCDPRINT5
;GLCDPrint (0, 8, "Full Mem.")
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	8
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
;Using SYSSTRINGPARAM1*9
	banksel	0
	call	GLCDPRINT5
;GLCDPrint (0, 16, "GLCD mode")
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	16
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
;Using SYSSTRINGPARAM1*9
	banksel	0
	call	GLCDPRINT5
;Wait 3 s
	movlw	3
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
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
;adcval = ReadAD ( ANA0 )
	clrf	ADREADPORT,ACCESS
	call	FN_READAD74
	movff	SYSREADADBYTE,ADCVAL
	clrf	ADCVAL_H,ACCESS
;Draw a box
;Box 0,0,GLCD_WIDTH-1, GLCD_HEIGHT-1
	clrf	LINEX1,ACCESS
	clrf	LINEX1_H,ACCESS
	clrf	LINEY1,ACCESS
	banksel	LINEY1_H
	clrf	LINEY1_H,BANKED
	movlw	63
	movwf	LINEX2,ACCESS
	clrf	LINEX2_H,ACCESS
	movlw	31
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	rcall	BOX17
;Draw a box
;Box GLCD_WIDTH-5, GLCD_HEIGHT-5,GLCD_WIDTH-1, GLCD_HEIGHT-1
	movlw	59
	movwf	LINEX1,ACCESS
	clrf	LINEX1_H,ACCESS
	movlw	27
	movwf	LINEY1,ACCESS
	banksel	LINEY1_H
	clrf	LINEY1_H,BANKED
	movlw	63
	movwf	LINEX2,ACCESS
	clrf	LINEX2_H,ACCESS
	movlw	31
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
	movwf	INXRADIUS,ACCESS
	clrf	INXRADIUS_H,ACCESS
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	movff	GLCD_YORDINATE,YORDINATE
	banksel	0
	rcall	CIRCLE20
;Draw a line
;Line 0,GLCD_HEIGHT-1,44,19
	clrf	LINEX1,ACCESS
	clrf	LINEX1_H,ACCESS
	movlw	31
	movwf	LINEY1,ACCESS
	banksel	LINEY1_H
	clrf	LINEY1_H,BANKED
	movlw	44
	movwf	LINEX2,ACCESS
	clrf	LINEX2_H,ACCESS
	movlw	19
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	_LINE71
;GLCDPrint ( 2 , 2,  "ADC:"+Pad(Str(adcval),4 ) )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	2
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
	movlw	low StringTable55
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable55
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable55
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
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable8
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
;Draw a string
;GLCDPrint(2, 10, Pad(Str(CCount),4 ))
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	10
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	CCOUNT,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
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
	movlw	low StringTable55
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable55
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable55
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
	movlw	low PAD
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high PAD
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINT5
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
;GCBASIC Optimisation file - this will optimise ADC operations by disabling the ADC operations on the AD channel that is set to FALSE
;to enable ADC operations on a specific AD channel set to TRUE
;
;Legacy chip Constants for ADC
;
;Recent chip Constants for ADC
;GLCD SSD1306 buffer is 256bytes
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (1798)
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
	bra	ENDIF7
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
ENDIF7
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF8
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
ENDIF8
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
	bra	SysForLoopEnd4
SysForLoop4
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
	bra	SysForLoop4
SysForLoopEnd4
;Draw lines going down
;For DrawLine = LineY1 To LineY2
;Legacy method
	movlw	1
	subwf	LINEY1,W,ACCESS
	movwf	DRAWLINE,ACCESS
	movlw	0
	banksel	LINEY1_H
	subwfb	LINEY1_H,W,BANKED
	movwf	DRAWLINE_H,ACCESS
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	banksel	0
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
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
	bra	SysForLoop5
SysForLoopEnd5
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:INTEGER:word:byte:, Source: glcd.h (1874)
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
	bra	ELSE13_1
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
	bra	ENDIF13
ELSE13_1
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
ENDIF13
;Loop
	bra	SysDoLoop_S3
SysDoLoop_E3
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
	banksel	SYSREPEATTEMP3
	movwf	SysRepeatTemp3,BANKED
SysRepeatLoop3
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate PosCharY Right
	rrcf	POSCHARY,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp3,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;LocX = LocX + GLCD_TYPE_SSD1306_64x32_XOFFSET
	movlw	32
	addwf	LOCX,F,BANKED
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
	movwf	SysRepeatTemp3,BANKED
SysRepeatLoop4
;Set C off
	bcf	STATUS,C,ACCESS
;Rotate PosCharX Right
	rrcf	POSCHARX_H,F,BANKED
	rrcf	POSCHARX,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp3,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
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
SysForLoop9
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
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	banksel	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC,BANKED
	clrf	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SysForLoop10
;Init SysForLoopStep9 :#0
	movlw	8
	movwf	SysForLoopStep9,BANKED
	clrf	SysForLoopStep9_H,BANKED
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
SysForLoop11
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
	bra	SysForLoop11
SysForLoopEnd11
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1336)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	rcall	HI2CQ24Q35STOP
;Next
;Integer negative Step Handler in For-next statement
	banksel	SYSFORLOOPSTEP9_H
	btfss	SYSFORLOOPSTEP9_H,7,BANKED
	bra	ELSE45_1
;Set SysForLoopABsValue to -StepValue :#1 
	comf	SYSFORLOOPSTEP9,W,BANKED
	movwf	SysForLoopABsValue10,BANKED
	comf	SYSFORLOOPSTEP9_H,W,BANKED
	movwf	SysForLoopABsValue10_H,BANKED
	incf	SysForLoopABsValue10,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SysForLoopABsValue10_H,F,BANKED
;IF ( SSD1306_BUFFERLOCATIONCALC - 32-1) } [WORD]SysForLoopABsValue10 THEN  :#1n 
	movlw	32
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
	movff	SYSFORLOOPABSVALUE10,SysWORDTempB
	movff	SYSFORLOOPABSVALUE10_H,SysWORDTempB_H
	banksel	0
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF46
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	banksel	SYSFORLOOPSTEP9
	movf	SysForLoopStep9,W,BANKED
	addwf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	movf	SysForLoopStep9_H,W,BANKED
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
	bra	SysForLoop10
;END IF
ENDIF46
	bra	ENDIF45
ELSE45_1
;Integer positive Step Handler in For-next statement
;IF ([WORD]32-1 - [WORD]SSD1306_BUFFERLOCATIONCALC) } [WORD]SysForLoopStep9 THEN :#1p 
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	sublw	31
	movwf	SysTemp2,BANKED
	clrf	SysTemp1,BANKED
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	subwfb	SysTemp1,W,BANKED
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movff	SYSFORLOOPSTEP9,SysWORDTempB
	movff	SYSFORLOOPSTEP9_H,SysWORDTempB_H
	banksel	0
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF47
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	banksel	SYSFORLOOPSTEP9
	movf	SysForLoopStep9,W,BANKED
	addwf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	movf	SysForLoopStep9_H,W,BANKED
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
	bra	SysForLoop10
;END IF
ENDIF47
;END IF
ENDIF45
SysForLoopEnd10
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
	bra	ENDIF48
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 0
	clrf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;end if
ENDIF48
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
SysForLoop12
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
SysForLoop13
	incf	CURRCHARROW,F,ACCESS
;CharColS=0
	clrf	CHARCOLS,ACCESS
;For Col=1 to GLCDfntDefaultsize
;Legacy method
	clrf	COL,ACCESS
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd14
SysForLoop14
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
	bra	SysForLoopEnd15
SysForLoop15
	incf	ROW,F,BANKED
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0,ACCESS
	bra	ELSE52_1
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
	bra	ENDIF52
ELSE52_1
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
ENDIF52
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
	bra	SysForLoop15
SysForLoopEnd15
;CharColS +=1
	incf	CHARCOLS,F,ACCESS
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	subwf	COL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop14
SysForLoopEnd14
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
	bra	SysForLoop13
SysForLoopEnd13
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
	bra	SysForLoop12
SysForLoopEnd12
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

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (1291)
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
	bra	SysForLoop2
SysForLoopEnd2
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:LONG:, Source: glcd.h (1403)
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
	rcall	SYSCOMPEQUAL32
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
SysDoLoop_S6
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E6
;If I2C1STAT0.BFRE  = 0 Then Exit Do
	btfss	I2C1STAT0,BFRE,BANKED
;If I2C1STAT0.BFRE  = 0 Then Exit Do
	bra	SysDoLoop_E6
;If I2C1STAT0.BFRE  = 0 Then Exit Do
;HI2CWaitMSSPTimeout++
	incf	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Loop
	bra	SysDoLoop_S6
SysDoLoop_E6
;If HI2CWaitMSSPTimeout <> 255 Then
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF63
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
SysDoLoop_S7
	btfss	I2C1CON0,S,BANKED
	bra	SysDoLoop_E7
;Wait for start
;NOP
	nop
;Loop
	bra	SysDoLoop_S7
SysDoLoop_E7
;Dim HWI2C_BufferLocationCounterIndex as Word
;For HWI2C_BufferLocationCounterIndex = 1 to HWI2C_BufferLocationCounter
;Legacy method
	clrf	HWI2C_BUFFERLOCATIONCOUNTERINDEX,ACCESS
	clrf	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,ACCESS
	movlw	1
	subwf	HWI2C_BUFFERLOCATIONCOUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd16
SysForLoop16
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
SysDoLoop_S8
	banksel	I2C1STAT1
	btfsc	I2C1STAT1,TXBE,BANKED
	bra	SysDoLoop_E8
;Wait for Transmit Buffer to Empty
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
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
	bra	SysDoLoop_S8
SysDoLoop_E8
;Next
	movff	HWI2C_BUFFERLOCATIONCOUNTERINDEX,SysWORDTempA
	movff	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,SysWORDTempA_H
	movff	HWI2C_BUFFERLOCATIONCOUNTER,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop16
SysForLoopEnd16
;Wait for a stop bit to complete
;Do while I2C1STAT0.MMA = 1 and HI2CWaitMSSPTimeout <> 255
SysDoLoop_S9
	clrf	SysByteTempX,ACCESS
	banksel	I2C1STAT0
	btfsc	i2c1stat0,mma,BANKED
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	hi2cwaitmssptimeout,SysBYTETempA
	setf	SysBYTETempB,ACCESS
	banksel	0
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	SysDoLoop_E9
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
;Loop
	bra	SysDoLoop_S9
SysDoLoop_E9
;End If
ENDIF63
HI2CQ24Q35STOPEXIT
;If I2C1PIR.7 = 1 then
	banksel	I2C1PIR
	btfss	I2C1PIR,7,BANKED
	bra	ELSE64_1
;HI2CAckpollState = False
	clrf	HI2CACKPOLLSTATE,ACCESS
;Else
	bra	ENDIF64
ELSE64_1
;HI2CAckpollState = True
	setf	HI2CACKPOLLSTATE,ACCESS
;End If
ENDIF64
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
	call	Delay_MS
;HI2CMode Master
	movlw	12
	movwf	HI2CCURRENTMODE,ACCESS
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
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DEACTIVATE_SCROLL)
	movlw	46
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYCLOCKDIV)            ' 0xD5
	movlw	213
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x80)                                  ' the suggested ratio 0x80
	movlw	128
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETMULTIPLEX)                  ' 0xA8
	movlw	168
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x1f)                                 '32 pixels
	movlw	31
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYOFFSET)              ' 0xD3
	movlw	211
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x00)                                   ' no offset
	banksel	SSD1306SENDBYTE
	clrf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;if(geometry == GEOMETRY_64_32)
;Write_Command_SSD1306(0x00)
	banksel	SSD1306SENDBYTE
	clrf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_CHARGEPUMP)                    ' 0x8D
	movlw	141
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;if (SSD1306_vccstate = SSD1306_EXTERNALVCC) then
;Write_Command_SSD1306(0x14)
	movlw	20
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_MEMORYMODE)                    ' 0x20
	movlw	32
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x10)                                  ' 0x01 act like PCD8544
	movlw	16
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SEGREMAP | 0x1)
	movlw	161
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_COMSCANDEC)
	movlw	200
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCOMPINS)                    ' 0xDA
	movlw	218
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x12)                                 '64 pixels
	movlw	18
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCONTRAST)                   ' 0x81
	movlw	129
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xCF)
	movlw	207
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETPRECHARGE)                  ' 0xd9
	movlw	217
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xF1)
	movlw	241
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETVCOMDETECT)                 ' 0xDB
	movlw	219
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x40)
	movlw	64
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYALLON_RESUME)           ' 0xA4
	movlw	164
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_NORMALDISPLAY)                 ' 0xA6
	movlw	166
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	rcall	WRITE_COMMAND_SSD1306
;Clear screen Here
;GLCDCLS_SSD1306
	rcall	GLCDCLS_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYON)                     '--turn on oled panel
	movlw	175
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE,BANKED
	banksel	0
	bra	WRITE_COMMAND_SSD1306

;********************************************************************************

;Source: 180_i2c_glcd_using_ssd1306_64_32.gcb (78)
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

;Source: string.h (1322)
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
	bra	ELSE35_1
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;clear output string
;Pad=""
	lfsr	1,PAD
	movlw	low StringTable97
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable97
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable97
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SYSREADSTRING
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
;Legacy method
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
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
	bra	SysForLoop6
SysForLoopEnd6
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
	bra	SysForLoopEnd7
SysForLoop7
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
	bra	SysForLoop7
SysForLoopEnd7
;set new length to PAD
;Pad(0) = SysStrLen
	movffl	SYSSTRLEN,SYSPAD_0
;else
	bra	ENDIF35
ELSE35_1
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
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop8
SysForLoopEnd8
;PAD(0) = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	POSTINC0,SysArrayTemp1
	movffl	SysArrayTemp1,SYSPAD_0
;End If
ENDIF35
	banksel	0
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (920)
PSET_SSD1306
;Set pixel at X, Y on LCD to State
;X is 0 to 127
;Y is 0 to 63
;Origin in top left
;1.14 Addresses correct device horizonal page
;don't need to do these calculations for in LOWMEMORY_GLCD_MODE
;SSD1306_BufferLocationCalc = ( GLCDY / 8 )* GLCD_WIDTH
;faster than /8
;SSD1306_BufferLocationCalc = GLCDY
	movff	GLCDY,SSD1306_BUFFERLOCATIONCALC
	banksel	SSD1306_BUFFERLOCATIONCALC_H
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
;SSD1306_BufferLocationCalc = SSD1306_BufferLocationCalc * GLCD_WIDTH
	movff	SSD1306_BUFFERLOCATIONCALC,SysWORDTempA
	movff	SSD1306_BUFFERLOCATIONCALC_H,SysWORDTempA_H
	movlw	64
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSMULTSUB16
	movff	SysWORDTempX,SSD1306_BUFFERLOCATIONCALC
	movff	SysWORDTempX_H,SSD1306_BUFFERLOCATIONCALC_H
;SSD1306_BufferLocationCalc = GLCDX + SSD1306_BufferLocationCalc + 1
	banksel	SSD1306_BUFFERLOCATIONCALC
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
;GLCDDataTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
	lfsr	0,SSD1306_BUFFERALIAS
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
	bra	ELSE57_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE,ACCESS
;Set C On
	bsf	STATUS,C,ACCESS
;Else
	bra	ENDIF57
ELSE57_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE,ACCESS
;Set C Off
	bcf	STATUS,C,ACCESS
;End If
ENDIF57
;Repeat GLCDBitNo
	movff	GLCDBITNO,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd2
SysRepeatLoop2
;Rotate GLCDChange Left
	rlcf	GLCDCHANGE,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,ACCESS
	bra	ELSE58_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	movf	GLCDDATATEMP,W,ACCESS
	andwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;Else
	bra	ENDIF58
ELSE58_1
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	movf	GLCDDATATEMP,W,ACCESS
	iorwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;End If
ENDIF58
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
	bra	ENDIF59
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
ENDIF59
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2170)
FN_READAD74
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
;Macro Source: a-d.h (637)
;Configure ANSELA/B/C/D @DebugADC_H
;Select Case ADReadPort
;End Select  '*** ANSEL Bits should now be set ***
SysSelectEnd1
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
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
;ANSELE = 0
	clrf	ANSELE,BANKED
;ReadAD = ADRESH
	movff	ADRESH,READAD
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
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
	bra	ENDIF31
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
ENDIF31
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
	bra	ENDIF32
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
ENDIF32
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
	bra	ENDIF33
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
ENDIF33
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
	bra	ENDIF34
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
ENDIF34
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
	bra	ELSE28_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF29
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	return
;End If
ENDIF29
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
	bra	ENDIF28
ELSE28_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	return
;End If
;End If
ENDIF28
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
	bra	ENDIF60
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF60
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
	bra	ENDIF61
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF61
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
	bra	ENDIF26
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF26
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
	bra	ENDIF27
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
ENDIF27
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
	bra	ENDIF23
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
ENDIF23
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF24
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
ENDIF24
;Call word divide routine
;SysDivSub16
	rcall	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF25
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
ENDIF25
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
	bra	ENDIF20
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
ENDIF20
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF21
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
ENDIF21
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF22
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
ENDIF22
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
	db	7,71,67,66,65,83,73,67


StringTable2
	db	7,65,110,111,98,105,117,109


StringTable3
	db	4,50,48,50,54


StringTable4
	db	1,42


StringTable5
	db	9,86,101,114,115,105,111,110,32,49


StringTable6
	db	9,70,117,108,108,32,77,101,109,46


StringTable7
	db	9,71,76,67,68,32,109,111,100,101


StringTable8
	db	4,65,68,67,58


StringTable55
	db	1,32


StringTable97
	db	0


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
_LINE71
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
	banksel	LINEY2
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
	bra	ELSE14_1
;LineStepX = 1
	movlw	1
	movwf	LINESTEPX,ACCESS
	clrf	LINESTEPX_H,ACCESS
;else
	bra	ENDIF14
ELSE14_1
;LineStepX = -1
	setf	LINESTEPX,ACCESS
	setf	LINESTEPX_H,ACCESS
;end if
ENDIF14
;if (LineDiffY > 0) then
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE15_1
;LineStepY = 1
	movlw	1
	movwf	LINESTEPY,ACCESS
	clrf	LINESTEPY_H,ACCESS
;else
	bra	ENDIF15
ELSE15_1
;LineStepY = -1
	setf	LINESTEPY,ACCESS
	setf	LINESTEPY_H,ACCESS
;end if
ENDIF15
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
	bra	ELSE16_1
;LineErr = LineDiffY_x2 - LineDiffX
	movf	LINEDIFFX,W,ACCESS
	subwf	LINEDIFFY_X2,W,ACCESS
	movwf	LINEERR,ACCESS
	movf	LINEDIFFX_H,W,ACCESS
	subwfb	LINEDIFFY_X2_H,W,ACCESS
	movwf	LINEERR_H,ACCESS
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
	bra	ELSE17_1
;LineErr += LineDiffY_x2
	movf	LINEDIFFY_X2,W,ACCESS
	addwf	LINEERR,F,ACCESS
	movf	LINEDIFFY_X2_H,W,ACCESS
	addwfc	LINEERR_H,F,ACCESS
;else
	bra	ENDIF17
ELSE17_1
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	movf	LINEDIFFX_X2,W,ACCESS
	subwf	LINEDIFFY_X2,W,ACCESS
	banksel	SYSTEMP3
	movwf	SysTemp3,BANKED
	movf	LINEDIFFX_X2_H,W,ACCESS
	subwfb	LINEDIFFY_X2_H,W,ACCESS
	movwf	SysTemp3_H,BANKED
	movf	SysTemp3,W,BANKED
	addwf	LINEERR,F,ACCESS
	movf	SysTemp3_H,W,BANKED
	addwfc	LINEERR_H,F,ACCESS
;LineY1 += LineStepY
	movf	LINESTEPY,W,ACCESS
	addwf	LINEY1,F,ACCESS
	movf	LINESTEPY_H,W,ACCESS
	addwfc	LINEY1_H,F,BANKED
;end if
ENDIF17
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
	bra	ENDIF16
ELSE16_1
;LineErr = LineDiffX_x2 - LineDiffY
	movf	LINEDIFFY,W,ACCESS
	subwf	LINEDIFFX_X2,W,ACCESS
	movwf	LINEERR,ACCESS
	movf	LINEDIFFY_H,W,ACCESS
	subwfb	LINEDIFFX_X2_H,W,ACCESS
	movwf	LINEERR_H,ACCESS
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
	movf	LINESTEPY,W,ACCESS
	addwf	LINEY1,F,ACCESS
	movf	LINESTEPY_H,W,ACCESS
	banksel	LINEY1_H
	addwfc	LINEY1_H,F,BANKED
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE18_1
;LineErr += LineDiffX_x2
	movf	LINEDIFFX_X2,W,ACCESS
	addwf	LINEERR,F,ACCESS
	movf	LINEDIFFX_X2_H,W,ACCESS
	addwfc	LINEERR_H,F,ACCESS
;else
	bra	ENDIF18
ELSE18_1
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	movf	LINEDIFFY_X2,W,ACCESS
	subwf	LINEDIFFX_X2,W,ACCESS
	banksel	SYSTEMP3
	movwf	SysTemp3,BANKED
	movf	LINEDIFFY_X2_H,W,ACCESS
	subwfb	LINEDIFFX_X2_H,W,ACCESS
	movwf	SysTemp3_H,BANKED
	movf	SysTemp3,W,BANKED
	addwf	LINEERR,F,ACCESS
	movf	SysTemp3_H,W,BANKED
	addwfc	LINEERR_H,F,ACCESS
;LineX1 += LineStepX
	movf	LINESTEPX,W,ACCESS
	addwf	LINEX1,F,ACCESS
	movf	LINESTEPX_H,W,ACCESS
	addwfc	LINEX1_H,F,ACCESS
;end if
ENDIF18
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
ENDIF16
	return

;********************************************************************************


 END
