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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\18FxxQ24_Chiprange_Demonstrations\210_i2c_glcd_sprites_using_ssd1306.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\18FxxQ24_Chiprange_Demonstrations\210_i2c_glcd_sprites_using_ssd1306.asm
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
CHARCODE                         EQU    1291          ; 0x50B
CHARCOL                          EQU    1292          ; 0x50C
CHARCOLS                         EQU    1294          ; 0x50E
CHARCOL_H                        EQU    1293          ; 0x50D
CHARLOCX                         EQU    1295          ; 0x50F
CHARLOCX_H                       EQU    1296          ; 0x510
CHARLOCY                         EQU    1297          ; 0x511
CHARLOCY_H                       EQU    1298          ; 0x512
CHARROW                          EQU    1299          ; 0x513
CHARROWS                         EQU    1301          ; 0x515
CHARROW_H                        EQU    1300          ; 0x514
COL                              EQU    1302          ; 0x516
CURRCHARCOL                      EQU    1303          ; 0x517
CURRCHARROW                      EQU    1304          ; 0x518
CURRCHARVAL                      EQU    1305          ; 0x519
CURX                             EQU    1306          ; 0x51A
CURY                             EQU    1307          ; 0x51B
DELAYTEMP                        EQU    1280          ; 0x500
DELAYTEMP2                       EQU    1281          ; 0x501
DIRX                             EQU    1308          ; 0x51C
DIRY                             EQU    1309          ; 0x51D
DRAWLINE                         EQU    1310          ; 0x51E
DRAWLINE_H                       EQU    1311          ; 0x51F
GLCDBACKGROUND                   EQU    1312          ; 0x520
GLCDBACKGROUND_H                 EQU    1313          ; 0x521
GLCDBITNO                        EQU    1314          ; 0x522
GLCDCHANGE                       EQU    1315          ; 0x523
GLCDCOLOUR                       EQU    1316          ; 0x524
GLCDCOLOUR_H                     EQU    1317          ; 0x525
GLCDDATATEMP                     EQU    1318          ; 0x526
GLCDFNTDEFAULT                   EQU    1319          ; 0x527
GLCDFNTDEFAULTHEIGHT             EQU    1320          ; 0x528
GLCDFNTDEFAULTSIZE               EQU    1321          ; 0x529
GLCDFONTWIDTH                    EQU    1322          ; 0x52A
GLCDFOREGROUND                   EQU    1323          ; 0x52B
GLCDFOREGROUND_H                 EQU    1324          ; 0x52C
GLCDHICHANGE                     EQU    1325          ; 0x52D
GLCDLOCHANGE                     EQU    1326          ; 0x52E
GLCDPRINTLEN                     EQU    1327          ; 0x52F
GLCDPRINTLOC                     EQU    1328          ; 0x530
GLCDPRINTLOC_H                   EQU    1329          ; 0x531
GLCDPRINT_STRING_COUNTER         EQU    1330          ; 0x532
GLCDROTATEBITS                   EQU    1331          ; 0x533
GLCDTEMP                         EQU    1332          ; 0x534
GLCDTEMP_H                       EQU    1333          ; 0x535
GLCDX                            EQU    1334          ; 0x536
GLCDY                            EQU    1335          ; 0x537
GLCD_YORDINATE                   EQU    1336          ; 0x538
GLCD_YORDINATE_H                 EQU    1337          ; 0x539
HI2C1LASTERROR                   EQU    1338          ; 0x53A
HI2C1STATEMACHINE                EQU    1339          ; 0x53B
HI2CACKPOLLSTATE                 EQU    1340          ; 0x53C
HI2CCURRENTMODE                  EQU    1341          ; 0x53D
HI2CWAITMSSPTIMEOUT              EQU    1342          ; 0x53E
HWI2C_BUFFER                     EQU    4222          ; 0x107E
HWI2C_BUFFERLOCATIONCOUNTER      EQU    1343          ; 0x53F
HWI2C_BUFFERLOCATIONCOUNTERINDEX EQU    1345          ; 0x541
HWI2C_BUFFERLOCATIONCOUNTERINDEX EQU    1346          ; 0x542
HWI2C_BUFFERLOCATIONCOUNTER_H    EQU    1344          ; 0x540
I2CBYTE                          EQU    1347          ; 0x543
LINECOLOUR                       EQU    1348          ; 0x544
LINECOLOUR_H                     EQU    1349          ; 0x545
LINEX1                           EQU    1350          ; 0x546
LINEX1_H                         EQU    1351          ; 0x547
LINEX2                           EQU    1352          ; 0x548
LINEX2_H                         EQU    1353          ; 0x549
LINEY1                           EQU    1354          ; 0x54A
LINEY1_H                         EQU    1355          ; 0x54B
LINEY2                           EQU    1356          ; 0x54C
LINEY2_H                         EQU    1357          ; 0x54D
LOCX                             EQU    1358          ; 0x54E
LOCY                             EQU    1359          ; 0x54F
OLDX                             EQU    1360          ; 0x550
OLDY                             EQU    1361          ; 0x551
POSCHARX                         EQU    1362          ; 0x552
POSCHARX_H                       EQU    1363          ; 0x553
POSCHARY                         EQU    1364          ; 0x554
PRINTLOCX                        EQU    1365          ; 0x555
PRINTLOCX_H                      EQU    1366          ; 0x556
PRINTLOCY                        EQU    1367          ; 0x557
PRINTLOCY_H                      EQU    1368          ; 0x558
RANDOM                           EQU    1369          ; 0x559
RANDOMSEED                       EQU    1370          ; 0x55A
RANDOMSEED_H                     EQU    1371          ; 0x55B
RANDOMTEMP                       EQU    1372          ; 0x55C
RANDOMTEMP_H                     EQU    1373          ; 0x55D
ROW                              EQU    1374          ; 0x55E
SSD1306SENDBYTE                  EQU    1375          ; 0x55F
SSD1306_BUFFERALIAS              EQU    4351          ; 0x10FF
SSD1306_BUFFERLOCATIONCALC       EQU    1376          ; 0x560
SSD1306_BUFFERLOCATIONCALC_H     EQU    1377          ; 0x561
SSD1306_PAGE                     EQU    1378          ; 0x562
STRINGPOINTER                    EQU    1379          ; 0x563
SWAP4                            EQU    1380          ; 0x564
SWAP4IN                          EQU    1381          ; 0x565
SYSBYTETEMPA                     EQU    1285          ; 0x505
SYSBYTETEMPB                     EQU    1289          ; 0x509
SYSBYTETEMPX                     EQU    1280          ; 0x500
SYSCALCTEMPA                     EQU    1285          ; 0x505
SYSDIVLOOP                       EQU    1284          ; 0x504
SYSFORLOOPABSVALUE9              EQU    1382          ; 0x566
SYSFORLOOPABSVALUE9_H            EQU    1383          ; 0x567
SYSFORLOOPSTEP8                  EQU    1384          ; 0x568
SYSFORLOOPSTEP8_H                EQU    1385          ; 0x569
SYSLCDPRINTDATAHANDLER           EQU    1386          ; 0x56A
SYSLCDPRINTDATAHANDLER_H         EQU    1387          ; 0x56B
SYSREPEATTEMP1                   EQU    1388          ; 0x56C
SYSREPEATTEMP5                   EQU    1389          ; 0x56D
SYSREPEATTEMP6                   EQU    1390          ; 0x56E
SYSREPEATTEMP9                   EQU    1391          ; 0x56F
SYSSTRINGA                       EQU    1287          ; 0x507
SYSSTRINGA_H                     EQU    1288          ; 0x508
SYSSTRINGLENGTH                  EQU    1286          ; 0x506
SYSSTRINGPARAM1                  EQU    4204          ; 0x106C
SYSTEMP1                         EQU    1392          ; 0x570
SYSTEMP1_H                       EQU    1393          ; 0x571
SYSTEMP2                         EQU    1394          ; 0x572
SYSTEMP2_H                       EQU    1395          ; 0x573
SYSTEMP3                         EQU    1396          ; 0x574
SYSWAITTEMPMS                    EQU    1282          ; 0x502
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503
SYSWAITTEMPS                     EQU    1284          ; 0x504
SYSWAITTEMPUS                    EQU    1285          ; 0x505
SYSWAITTEMPUS_H                  EQU    1286          ; 0x506
SYSWORDTEMPA                     EQU    1285          ; 0x505
SYSWORDTEMPA_H                   EQU    1286          ; 0x506
SYSWORDTEMPB                     EQU    1289          ; 0x509
SYSWORDTEMPB_H                   EQU    1290          ; 0x50A

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258

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
	call	INITRANDOM
	call	INITGLCD_SSD1306

;Start_of_the_main_program
;
;This demonstration program is a simple GLCD demonstration of the SSD1306 GLCD capabilities.
;
;This program shows how to draw sprites on an SSD1306 I2C device.
;Only support I2C and Full GLCD Mode - supported from v1.xx onwards
;
;The #define 'spritechoice' defines the sprite to be managed.
;You can define your own in the sprite tables. Each table is 8 pixles vertical - col1 to col8 in each table.
;
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
	movwf	HI2CCURRENTMODE,ACCESS
	banksel	0
	call	HI2CMODE
;I2C Controls specific to 18FxxQ2x chips
;! Optional the default is 128
;! Optional the default is to issue a warning
;#DEFINE MUTE_HIC2Q2XBUFFERSIZE_WARNING
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Select the sprite and the user delay
;2ms is the lower limit of user visual perception
;*******************************************************************************************
;Draw initial screen
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
	rcall	BOX19
;GLCDPrint ( 2, 36, "GCBASIC")
	movlw	2
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	36
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*7
	banksel	0
	call	GLCDPRINT7
;GLCDPrint ( 2, 46, "GLCD Library 2024")
	movlw	2
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	46
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*17
	banksel	0
	call	GLCDPRINT7
;GLCDPrint ( 2, 54, "Sprite Support")
	movlw	2
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	54
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*14
	banksel	0
	call	GLCDPRINT7
;Wait 3 s
	movlw	3
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;GLCDCLS
	rcall	GLCDCLS_SSD1306
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
	rcall	BOX19
;dimension and initialise variables
;Dim oldx, oldy As Byte
;Dim curx, cury As Byte
;Dim dirx, diry As Byte
;curx = 63
	movlw	63
	movwf	CURX,ACCESS
;cury = 31
	movlw	31
	movwf	CURY,ACCESS
;oldx = curx
	movff	CURX,OLDX
;oldy = cury
	movff	CURY,OLDY
;Draw initial sprite
;GLCDDrawSprite_SSD1306 curx,cury, spritechoice, GLCDForeground
	movff	CURX,GLCDX
	movff	CURY,GLCDY
	movlw	2
	movwf	CHARCODE,ACCESS
	call	GLCDDRAWSPRITE_SSD1306
;Set initial direction
;If Random > 127 Then
	call	FN_RANDOM
	movf	RANDOM,W,ACCESS
	sublw	127
	btfsc	STATUS, C,ACCESS
	bra	ELSE1_1
;dirx=1
	movlw	1
	movwf	DIRX,ACCESS
;Else
	bra	ENDIF1
ELSE1_1
;dirx=255
	setf	DIRX,ACCESS
;End If
ENDIF1
;If Random > 127 Then
	call	FN_RANDOM
	movf	RANDOM,W,ACCESS
	sublw	127
	btfsc	STATUS, C,ACCESS
	bra	ELSE2_1
;diry=1
	movlw	1
	movwf	DIRY,ACCESS
;Else
	bra	ENDIF2
ELSE2_1
;diry=255
	setf	DIRY,ACCESS
;End If
ENDIF2
;Do
SysDoLoop_S1
;handle bounce
;If  curx>0 AND curx<119  Then
	movff	CURX,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp1
	movff	CURX,SysBYTETempA
	movlw	119
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ELSE3_1
;oldx = curx
	movff	CURX,OLDX
;curx=curx+dirx
	movf	DIRX,W,ACCESS
	addwf	CURX,F,ACCESS
;Else
	bra	ENDIF3
ELSE3_1
;If dirx = 1 Then
	decf	DIRX,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE5_1
;dirx=255
	setf	DIRX,ACCESS
;Else
	bra	ENDIF5
ELSE5_1
;dirx=1
	movlw	1
	movwf	DIRX,ACCESS
;End If
ENDIF5
;oldx = curx
	movff	CURX,OLDX
;curx=curx+dirx
	movf	DIRX,W,ACCESS
	addwf	CURX,F,ACCESS
;End If
ENDIF3
;If cury >1 AND cury<55 Then
	movff	CURY,SysBYTETempB
	movlw	1
	movwf	SysBYTETempA,ACCESS
	banksel	0
	call	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp1
	movff	CURY,SysBYTETempA
	movlw	55
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ELSE4_1
;oldy = cury
	movff	CURY,OLDY
;cury=cury+diry
	movf	DIRY,W,ACCESS
	addwf	CURY,F,ACCESS
;Else
	bra	ENDIF4
ELSE4_1
;If diry = 1 Then
	decf	DIRY,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE6_1
;diry=255
	setf	DIRY,ACCESS
;Else
	bra	ENDIF6
ELSE6_1
;diry=1
	movlw	1
	movwf	DIRY,ACCESS
;End If
ENDIF6
;oldy = cury
	movff	CURY,OLDY
;cury=cury+diry
	movf	DIRY,W,ACCESS
	addwf	CURY,F,ACCESS
;End If
ENDIF4
;end of handle bounce
;draw sprite
;GLCDDrawSprite_SSD1306 oldx,oldy, spritechoice
	movff	OLDX,GLCDX
	movff	OLDY,GLCDY
	movlw	2
	movwf	CHARCODE,ACCESS
	banksel	0
	rcall	GLCDDRAWSPRITE_SSD1306
;GLCDDrawSprite_SSD1306 curx,cury, spritechoice
	movff	CURX,GLCDX
	movff	CURY,GLCDY
	movlw	2
	movwf	CHARCODE,ACCESS
	rcall	GLCDDRAWSPRITE_SSD1306
;user delay
;so you can see it!
;Wait SPRITEDELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;End
	bra	BASPROGRAMEND
;sprite shape data
;sprite shape data
;sprite shape data
;sprite shape data
;sprite shape data
;sprite shape data
;sprite shape data
;sprite shape data
;GGLCD SSD1306 buffer is 1024bytes
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (1732)
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
	bra	ENDIF14
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
ENDIF14
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF15
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
ENDIF15
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

;Source: GLCD_SSD1306.H (1063)
CURSOR_POSITION_SSD1306
;dim  PosCharX, PosCharX as Word
;PosCharY = LocY / 8
;faster than /8
;PosCharY = LocY
	movff	LOCY,POSCHARY
;Repeat 3
	movlw	3
	banksel	SYSREPEATTEMP9
	movwf	SysRepeatTemp9,BANKED
SysRepeatLoop9
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate PosCharY Right
	rrcf	POSCHARY,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp9,F,BANKED
	bra	SysRepeatLoop9
SysRepeatLoopEnd9
;Write_Command_SSD1306( 0xB0 + PosCharY )   ' set page address
	movlw	176
	addwf	POSCHARY,W,ACCESS
	movwf	SSD1306SENDBYTE,ACCESS
	banksel	0
	call	WRITE_COMMAND_SSD1306
;PosCharX = ( LocX  & 0x0f )  ' lower nibble
	movlw	15
	andwf	LOCX,W,ACCESS
	movwf	POSCHARX,ACCESS
	clrf	POSCHARX_H,ACCESS
;Write_Command_SSD1306( PosCharX )
	movff	POSCHARX,SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;PosCharX = LocX
	movff	LOCX,POSCHARX
	clrf	POSCHARX_H,ACCESS
;Repeat 4
	movlw	4
	banksel	SYSREPEATTEMP9
	movwf	SysRepeatTemp9,BANKED
SysRepeatLoop10
;Set C off
	bcf	STATUS,C,ACCESS
;Rotate PosCharX Right
	rrcf	POSCHARX_H,F,ACCESS
	rrcf	POSCHARX,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp9,F,BANKED
	bra	SysRepeatLoop10
SysRepeatLoopEnd10
;PosCharX = ( PosCharX & 0x0F ) + 0x10
	movlw	15
	andwf	POSCHARX,W,ACCESS
	movwf	SysTemp1,BANKED
	clrf	SysTemp1_H,BANKED
	movlw	16
	addwf	SysTemp1,W,BANKED
	movwf	POSCHARX,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	POSCHARX_H,ACCESS
;Write_Command_SSD1306 ( PosCharX )
	movff	POSCHARX,SSD1306SENDBYTE
	banksel	0
	goto	WRITE_COMMAND_SSD1306

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

;Source: GLCD_SSD1306.H (442)
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
SysForLoop8
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
	bra	SysForLoop8
SysForLoopEnd8
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	banksel	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC,BANKED
	clrf	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SysForLoop9
;Init SysForLoopStep8 :#0
	movlw	8
	movwf	SysForLoopStep8,BANKED
	clrf	SysForLoopStep8_H,BANKED
;Cursor_Position_SSD1306 ( 0 , SSD1306_BufferLocationCalc )
	clrf	LOCX,ACCESS
	movff	SSD1306_BUFFERLOCATIONCALC,LOCY
	banksel	0
	rcall	CURSOR_POSITION_SSD1306
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1241)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	call	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x40
	movlw	64
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;For GLCDTemp = 0 to 127
;Legacy method
	setf	GLCDTEMP,ACCESS
SysForLoop10
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
	bra	SysForLoop10
SysForLoopEnd10
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1305)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	rcall	HI2CQ24STOP
;Next
;Integer negative Step Handler in For-next statement
	banksel	SYSFORLOOPSTEP8_H
	btfss	SYSFORLOOPSTEP8_H,7,BANKED
	bra	ELSE27_1
;Set SysForLoopABsValue to -StepValue :#1 
	comf	SYSFORLOOPSTEP8,W,BANKED
	movwf	SysForLoopABsValue9,BANKED
	comf	SYSFORLOOPSTEP8_H,W,BANKED
	movwf	SysForLoopABsValue9_H,BANKED
	incf	SysForLoopABsValue9,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SysForLoopABsValue9_H,F,BANKED
;IF ( SSD1306_BUFFERLOCATIONCALC - 64-1) } [WORD]SysForLoopABsValue9 THEN  :#1n 
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
	movff	SYSFORLOOPABSVALUE9,SysWORDTempB
	movff	SYSFORLOOPABSVALUE9_H,SysWORDTempB_H
	banksel	0
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF28
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	banksel	SYSFORLOOPSTEP8
	movf	SysForLoopStep8,W,BANKED
	addwf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	movf	SysForLoopStep8_H,W,BANKED
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
	bra	SysForLoop9
;END IF
ENDIF28
	bra	ENDIF27
ELSE27_1
;Integer positive Step Handler in For-next statement
;IF ([WORD]64-1 - [WORD]SSD1306_BUFFERLOCATIONCALC) } [WORD]SysForLoopStep8 THEN :#1p 
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	sublw	63
	movwf	SysTemp1,BANKED
	clrf	SysTemp2,BANKED
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	subwfb	SysTemp2,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movff	SYSFORLOOPSTEP8,SysWORDTempB
	movff	SYSFORLOOPSTEP8_H,SysWORDTempB_H
	banksel	0
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF29
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	banksel	SYSFORLOOPSTEP8
	movf	SysForLoopStep8,W,BANKED
	addwf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	movf	SysForLoopStep8_H,W,BANKED
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
	bra	SysForLoop9
;END IF
ENDIF29
;END IF
ENDIF27
SysForLoopEnd9
;Removed at 1.14. Retained for documentation only
;Cursor_Position_SSD1306 ( 0 , 0 )
;for SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
;for GLCDTemp = 0 to 127
;Write_Data_SSD1306(GLCDBackground)
;Next
;next
;Cursor_Position_SSD1306 ( 0 , 0 )
	clrf	LOCX,ACCESS
	clrf	LOCY,ACCESS
	rcall	CURSOR_POSITION_SSD1306
;PrintLocX =0
	clrf	PRINTLOCX,ACCESS
;PrintLocY =0
	clrf	PRINTLOCY,ACCESS
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
	bra	ENDIF30
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 0
	clrf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;end if
ENDIF30
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
	movff	SysByteTempX,SysTemp3
	movff	CHARCODE,SysBYTETempB
	movlw	202
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	ENDIF31
;CharLocY=CharLocY-1
	movlw	1
	subwf	CHARLOCY,F,ACCESS
	movlw	0
	subwfb	CHARLOCY_H,F,ACCESS
;end if
ENDIF31
;For CurrCharCol = 1 to 5
;Legacy method
	clrf	CURRCHARCOL,ACCESS
SysForLoop11
	incf	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect5Case1
	decf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case2
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	GLCDCHARCOL3
	movwf	CURRCHARVAL,ACCESS
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	bra	SysSelectEnd5
SysSelect5Case2
	movlw	2
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case3
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	GLCDCHARCOL4
	movwf	CURRCHARVAL,ACCESS
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	bra	SysSelectEnd5
SysSelect5Case3
	movlw	3
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case4
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	GLCDCHARCOL5
	movwf	CURRCHARVAL,ACCESS
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	bra	SysSelectEnd5
SysSelect5Case4
	movlw	4
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case5
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	GLCDCHARCOL6
	movwf	CURRCHARVAL,ACCESS
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	bra	SysSelectEnd5
SysSelect5Case5
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd5
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	GLCDCHARCOL7
	movwf	CURRCHARVAL,ACCESS
;End Select
SysSelectEnd5
;Full Memory GLCD mode
;CharRow=0
	clrf	CHARROW,ACCESS
	clrf	CHARROW_H,ACCESS
;For CurrCharRow = 1 to 8
;Legacy method
	clrf	CURRCHARROW,ACCESS
SysForLoop12
	incf	CURRCHARROW,F,ACCESS
;CharColS=0
	clrf	CHARCOLS,ACCESS
;For Col=1 to GLCDfntDefaultsize
;Legacy method
	clrf	COL,ACCESS
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd13
SysForLoop13
	incf	COL,F,ACCESS
;CharRowS=0
	clrf	CHARROWS,ACCESS
;For Row=1 to GLCDfntDefaultsize
;Legacy method
	clrf	ROW,ACCESS
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd14
SysForLoop14
	incf	ROW,F,ACCESS
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0,ACCESS
	bra	ELSE34_1
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, LineColour
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	banksel	SYSTEMP3
	movwf	SysTemp3,BANKED
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp3,W,BANKED
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp3,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp3,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_SSD1306
;Else
	bra	ENDIF34
ELSE34_1
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, GLCDBackground
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	banksel	SYSTEMP3
	movwf	SysTemp3,BANKED
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp3,W,BANKED
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp3,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp3,W,BANKED
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	banksel	0
	rcall	PSET_SSD1306
;End if
ENDIF34
;Put out a white intercharacter pixel/space
;PSet [word]CharLocX + ( GLCDFontWidth * GLCDfntDefaultsize) , [word]CharLocY + CharRow + CharRowS , GLCDBackground
	movf	GLCDFONTWIDTH,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movff	PRODL,SysTemp3
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp3,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp3,W,BANKED
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	banksel	0
	rcall	PSET_SSD1306
;CharRowS +=1
	incf	CHARROWS,F,ACCESS
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	subwf	ROW,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop14
SysForLoopEnd14
;CharColS +=1
	incf	CHARCOLS,F,ACCESS
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	subwf	COL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop13
SysForLoopEnd13
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
	bra	SysForLoop12
SysForLoopEnd12
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
	bra	SysForLoop11
SysForLoopEnd11
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

;Source: 210_i2c_glcd_sprites_using_ssd1306.gcb (222)
GLCDDRAWSPRITE_SSD1306
;Dim CurrCharVal, CurrCharCol, SSD1306_Page, GLCDHiChange, GLCDLoChange, GLCDRotateBits, GLCDTemp As Byte
;Calculate device row
;SSD1306_Page = GLCDY
	movff	GLCDY,SSD1306_PAGE
;Repeat 3
	movlw	3
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SSD1306_Page Right
	rrcf	SSD1306_PAGE,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;SSD1306_Page is now the correct ROW
;Calculate buffer element
;SSD1306_BufferLocationCalc = GLCDY AND 0xF8
	movlw	248
	andwf	GLCDY,W,ACCESS
	movwf	SSD1306_BUFFERLOCATIONCALC,BANKED
	clrf	SSD1306_BUFFERLOCATIONCALC_H,BANKED
;Repeat 4
	movlw	4
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop2
;Set c Off
	bcf	STATUS,C,ACCESS
;Rotate SSD1306_BufferLocationCalc Left
	rlcf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	rlcf	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;SSD1306_BufferLocationCalc = (SSD1306_BufferLocationCalc OR GLCDX)
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	iorwf	GLCDX,W,ACCESS
	movwf	SSD1306_BUFFERLOCATIONCALC,BANKED
;Increment as we do not use element 0 in the array
;SSD1306_BufferLocationCalc++
	incf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;SSD1306_BufferLocationCalc is now the correct buffer element
;is the y position of Sprite on a ROW positin 0?
;If ( GLCDY mod 8 ) = 0 Then
	movff	GLCDY,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSDIVSUB
	movff	SysBYTETempX,SysTemp1
	movff	SysTemp1,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	call	SYSCOMPEQUAL
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE7_1
;uses GLDX and SS1306_Page variables
;Cursor_Position_SSD1306_Fast
;Macro Source: 210_i2c_glcd_sprites_using_ssd1306.gcb (451)
;Dim I2CByte As Byte
;HI2CStart
	call	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x00
	clrf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0xB0 + SSD1306_Page
	movlw	176
	banksel	SSD1306_PAGE
	addwf	SSD1306_PAGE,W,BANKED
	movwf	I2CBYTE,ACCESS
	banksel	0
	rcall	HI2CQ24SEND
;HI2CStop
	rcall	HI2CQ24STOP
;HI2CStart
	call	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x00
	clrf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;lower nibble
;I2CByte = ( GLCDX  & 0x0f )
	movlw	15
	andwf	GLCDX,W,ACCESS
	movwf	I2CBYTE,ACCESS
;HI2CSend I2CByte
	rcall	HI2CQ24SEND
;HI2CStop
	rcall	HI2CQ24STOP
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x00
	clrf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;I2CByte = ( SWAP4(GLCDX) & 0x0F ) + 0x10
	movff	GLCDX,SWAP4IN
	call	FN_SWAP4
	movlw	15
	banksel	SWAP4
	andwf	SWAP4,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	16
	addwf	SysTemp1,W,BANKED
	movwf	I2CBYTE,ACCESS
;HI2CSend I2CByte
	banksel	0
	rcall	HI2CQ24SEND
;HI2CStop
	rcall	HI2CQ24STOP
;Read 8 pixels value into CurrCharVal then write to display
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1241)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x40
	movlw	64
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;For CurrCharCol = 1 To 8
;Legacy method
	clrf	CURRCHARCOL,ACCESS
SysForLoop1
	incf	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable sprite1, CharCode, CurrCharVal
SysSelect1Case1
	decf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;Case 1: ReadTable sprite1, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE1
	movwf	CURRCHARVAL,ACCESS
;Case 2: ReadTable sprite2, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;Case 2: ReadTable sprite2, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE2
	movwf	CURRCHARVAL,ACCESS
;Case 3: ReadTable sprite3, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;Case 3: ReadTable sprite3, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE3
	movwf	CURRCHARVAL,ACCESS
;Case 4: ReadTable sprite4, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
;Case 4: ReadTable sprite4, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	call	SPRITE4
	movwf	CURRCHARVAL,ACCESS
;Case 5: ReadTable sprite5, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case5
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case6
;Case 5: ReadTable sprite5, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	call	SPRITE5
	movwf	CURRCHARVAL,ACCESS
;Case 6: ReadTable sprite6, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case6
	movlw	6
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case7
;Case 6: ReadTable sprite6, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	call	SPRITE6
	movwf	CURRCHARVAL,ACCESS
;Case 7: ReadTable sprite7, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case7
	movlw	7
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case8
;Case 7: ReadTable sprite7, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	call	SPRITE7
	movwf	CURRCHARVAL,ACCESS
;Case 8: ReadTable sprite8, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case8
	movlw	8
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
;Case 8: ReadTable sprite8, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	call	SPRITE8
	movwf	CURRCHARVAL,ACCESS
;End Select
SysSelectEnd1
;Xor pixels into buffer
;GLCDTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc) XOR CurrCharVal
	lfsr	0,SSD1306_BUFFERALIAS
	banksel	SSD1306_BUFFERLOCATIONCALC
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movf	INDF0,W,ACCESS
	xorwf	CURRCHARVAL,W,ACCESS
	movwf	GLCDTEMP,ACCESS
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDTemp
	lfsr	0,SSD1306_BUFFERALIAS
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	GLCDTEMP,INDF0
;Write buffer this will Increment the device point as part of the write operation
;Write_Transaction_Data_SSD1306(GLCDTemp)
;Macro Source: GLCD_SSD1306.H (1272)
;HI2CSend SSD1306SendByte
	movff	GLCDTEMP,I2CBYTE
	banksel	0
	rcall	HI2CQ24SEND
;Increment buffer by 1 to match device Increment
;SSD1306_BufferLocationCalc++
	banksel	SSD1306_BUFFERLOCATIONCALC
	incf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;Next
	movlw	8
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1305)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	banksel	0
	rcall	HI2CQ24STOP
;Else
	bra	ENDIF7
ELSE7_1
;handle TOP portion of the sprite as we are NOT at 0 pixel of a ROW
;send the TOP pixels
;Cursor_Position_SSD1306_Fast
;Macro Source: 210_i2c_glcd_sprites_using_ssd1306.gcb (451)
;Dim I2CByte As Byte
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x00
	clrf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0xB0 + SSD1306_Page
	movlw	176
	banksel	SSD1306_PAGE
	addwf	SSD1306_PAGE,W,BANKED
	movwf	I2CBYTE,ACCESS
	banksel	0
	rcall	HI2CQ24SEND
;HI2CStop
	rcall	HI2CQ24STOP
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x00
	clrf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;lower nibble
;I2CByte = ( GLCDX  & 0x0f )
	movlw	15
	andwf	GLCDX,W,ACCESS
	movwf	I2CBYTE,ACCESS
;HI2CSend I2CByte
	rcall	HI2CQ24SEND
;HI2CStop
	rcall	HI2CQ24STOP
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x00
	clrf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;I2CByte = ( SWAP4(GLCDX) & 0x0F ) + 0x10
	movff	GLCDX,SWAP4IN
	call	FN_SWAP4
	movlw	15
	banksel	SWAP4
	andwf	SWAP4,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	16
	addwf	SysTemp1,W,BANKED
	movwf	I2CBYTE,ACCESS
;HI2CSend I2CByte
	banksel	0
	rcall	HI2CQ24SEND
;HI2CStop
	rcall	HI2CQ24STOP
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1241)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x40
	movlw	64
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;For CurrCharCol = 1 To 8
;Legacy method
	clrf	CURRCHARCOL,ACCESS
SysForLoop2
	incf	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable sprite1, CharCode, GLCDHiChange
SysSelect2Case1
	decf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;Case 1: ReadTable sprite1, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE1
	movwf	GLCDHICHANGE,ACCESS
;Case 2: ReadTable sprite2, CharCode, GLCDHiChange
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
;Case 2: ReadTable sprite2, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE2
	movwf	GLCDHICHANGE,ACCESS
;Case 3: ReadTable sprite3, CharCode, GLCDHiChange
	bra	SysSelectEnd2
SysSelect2Case3
	movlw	3
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case4
;Case 3: ReadTable sprite3, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE3
	movwf	GLCDHICHANGE,ACCESS
;Case 4: ReadTable sprite4, CharCode, GLCDHiChange
	bra	SysSelectEnd2
SysSelect2Case4
	movlw	4
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case5
;Case 4: ReadTable sprite4, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE4
	movwf	GLCDHICHANGE,ACCESS
;Case 5: ReadTable sprite5, CharCode, GLCDHiChange
	bra	SysSelectEnd2
SysSelect2Case5
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case6
;Case 5: ReadTable sprite5, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE5
	movwf	GLCDHICHANGE,ACCESS
;Case 6: ReadTable sprite6, CharCode, GLCDHiChange
	bra	SysSelectEnd2
SysSelect2Case6
	movlw	6
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case7
;Case 6: ReadTable sprite6, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE6
	movwf	GLCDHICHANGE,ACCESS
;Case 7: ReadTable sprite7, CharCode, GLCDHiChange
	bra	SysSelectEnd2
SysSelect2Case7
	movlw	7
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case8
;Case 7: ReadTable sprite7, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE7
	movwf	GLCDHICHANGE,ACCESS
;Case 8: ReadTable sprite8, CharCode, GLCDHiChange
	bra	SysSelectEnd2
SysSelect2Case8
	movlw	8
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
;Case 8: ReadTable sprite8, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE8
	movwf	GLCDHICHANGE,ACCESS
;End Select
SysSelectEnd2
;handle top row
;GLCDRotateBits = GLCDY AND 7
	movlw	7
	andwf	GLCDY,W,ACCESS
	movwf	GLCDROTATEBITS,ACCESS
;Repeat GLCDRotateBits
	movff	GLCDROTATEBITS,SysRepeatTemp1
	banksel	SYSREPEATTEMP1
	movf	SYSREPEATTEMP1,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd3
SysRepeatLoop3
;Set c Off
	bcf	STATUS,C,ACCESS
;Rotate GLCDHiChange Left
	rlcf	GLCDHICHANGE,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;GLCDTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc) XOR GLCDHiChange
	lfsr	0,SSD1306_BUFFERALIAS
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movf	INDF0,W,ACCESS
	xorwf	GLCDHICHANGE,W,ACCESS
	movwf	GLCDTEMP,ACCESS
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDTemp
	lfsr	0,SSD1306_BUFFERALIAS
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	GLCDTEMP,INDF0
;Write_Transaction_Data_SSD1306(GLCDTemp)
;Macro Source: GLCD_SSD1306.H (1272)
;HI2CSend SSD1306SendByte
	movff	GLCDTEMP,I2CBYTE
	banksel	0
	rcall	HI2CQ24SEND
;SSD1306_BufferLocationCalc++
	banksel	SSD1306_BUFFERLOCATIONCALC
	incf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;Next
	movlw	8
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1305)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	banksel	0
	rcall	HI2CQ24STOP
;handle BOTTOM pixels of the sprite
;Increment to the next ROW
;SSD1306_Page++
	banksel	SSD1306_PAGE
	incf	SSD1306_PAGE,F,BANKED
;Cursor_Position_SSD1306_Fast
;Macro Source: 210_i2c_glcd_sprites_using_ssd1306.gcb (451)
;Dim I2CByte As Byte
;HI2CStart
	banksel	0
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x00
	clrf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0xB0 + SSD1306_Page
	movlw	176
	banksel	SSD1306_PAGE
	addwf	SSD1306_PAGE,W,BANKED
	movwf	I2CBYTE,ACCESS
	banksel	0
	rcall	HI2CQ24SEND
;HI2CStop
	rcall	HI2CQ24STOP
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x00
	clrf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;lower nibble
;I2CByte = ( GLCDX  & 0x0f )
	movlw	15
	andwf	GLCDX,W,ACCESS
	movwf	I2CBYTE,ACCESS
;HI2CSend I2CByte
	rcall	HI2CQ24SEND
;HI2CStop
	rcall	HI2CQ24STOP
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x00
	clrf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;I2CByte = ( SWAP4(GLCDX) & 0x0F ) + 0x10
	movff	GLCDX,SWAP4IN
	rcall	FN_SWAP4
	movlw	15
	banksel	SWAP4
	andwf	SWAP4,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	16
	addwf	SysTemp1,W,BANKED
	movwf	I2CBYTE,ACCESS
;HI2CSend I2CByte
	banksel	0
	rcall	HI2CQ24SEND
;HI2CStop
	rcall	HI2CQ24STOP
;Move buffer pointet to the next row/buffer which is 128 bytes, but, the top half of the buffer has been write... 8 bytes.
;So 128-8 = 120
;SSD1306_BufferLocationCalc = SSD1306_BufferLocationCalc  + 120
	movlw	120
	banksel	SSD1306_BUFFERLOCATIONCALC
	addwf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	movlw	0
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1241)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	banksel	0
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x40
	movlw	64
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;For CurrCharCol = 1 To 8
;Legacy method
	clrf	CURRCHARCOL,ACCESS
SysForLoop3
	incf	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable sprite1, CharCode, GLCDHiChange
SysSelect3Case1
	decf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;Case 1: ReadTable sprite1, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE1
	movwf	GLCDHICHANGE,ACCESS
;Case 2: ReadTable sprite2, CharCode, GLCDHiChange
	bra	SysSelectEnd3
SysSelect3Case2
	movlw	2
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case3
;Case 2: ReadTable sprite2, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE2
	movwf	GLCDHICHANGE,ACCESS
;Case 3: ReadTable sprite3, CharCode, GLCDHiChange
	bra	SysSelectEnd3
SysSelect3Case3
	movlw	3
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case4
;Case 3: ReadTable sprite3, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE3
	movwf	GLCDHICHANGE,ACCESS
;Case 4: ReadTable sprite4, CharCode, GLCDHiChange
	bra	SysSelectEnd3
SysSelect3Case4
	movlw	4
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case5
;Case 4: ReadTable sprite4, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE4
	movwf	GLCDHICHANGE,ACCESS
;Case 5: ReadTable sprite5, CharCode, GLCDHiChange
	bra	SysSelectEnd3
SysSelect3Case5
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case6
;Case 5: ReadTable sprite5, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE5
	movwf	GLCDHICHANGE,ACCESS
;Case 6: ReadTable sprite6, CharCode, GLCDHiChange
	bra	SysSelectEnd3
SysSelect3Case6
	movlw	6
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case7
;Case 6: ReadTable sprite6, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE6
	movwf	GLCDHICHANGE,ACCESS
;Case 7: ReadTable sprite7, CharCode, GLCDHiChange
	bra	SysSelectEnd3
SysSelect3Case7
	movlw	7
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case8
;Case 7: ReadTable sprite7, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE7
	movwf	GLCDHICHANGE,ACCESS
;Case 8: ReadTable sprite8, CharCode, GLCDHiChange
	bra	SysSelectEnd3
SysSelect3Case8
	movlw	8
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd3
;Case 8: ReadTable sprite8, CharCode, GLCDHiChange
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	rcall	SPRITE8
	movwf	GLCDHICHANGE,ACCESS
;End Select
SysSelectEnd3
;GLCDLoChange = 0
	clrf	GLCDLOCHANGE,ACCESS
;Repeat GLCDRotateBits
	movff	GLCDROTATEBITS,SysRepeatTemp1
	banksel	SYSREPEATTEMP1
	movf	SYSREPEATTEMP1,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd4
SysRepeatLoop4
;Set c Off
	bcf	STATUS,C,ACCESS
;as bits move to left C is set... moving in GLCDLoChange in the next command
;Rotate GLCDHiChange Left
	rlcf	GLCDHICHANGE,F,ACCESS
;Rotate GLCDLoChange Left
	rlcf	GLCDLOCHANGE,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
;GLCDTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc) XOR GLCDLoChange
	lfsr	0,SSD1306_BUFFERALIAS
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movf	INDF0,W,ACCESS
	xorwf	GLCDLOCHANGE,W,ACCESS
	movwf	GLCDTEMP,ACCESS
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDTemp
	lfsr	0,SSD1306_BUFFERALIAS
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	GLCDTEMP,INDF0
;Write_Transaction_Data_SSD1306(GLCDTemp)
;Macro Source: GLCD_SSD1306.H (1272)
;HI2CSend SSD1306SendByte
	movff	GLCDTEMP,I2CBYTE
	banksel	0
	rcall	HI2CQ24SEND
;SSD1306_BufferLocationCalc++
	banksel	SSD1306_BUFFERLOCATIONCALC
	incf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;Next
	movlw	8
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1305)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	banksel	0
	rcall	HI2CQ24STOP
;End If
ENDIF7
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (1225)
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
	bra	SysForLoopEnd4
SysForLoop4
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
	bra	SysForLoop4
SysForLoopEnd4
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
	clrf	HI2CCURRENTMODE,ACCESS
;Initialise the I2C module
;SI2CInit
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
SysSelect4Case1
	movlw	2
	subwf	HI2C1STATEMACHINE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
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
	bra	SysSelectEnd4
SysSelect4Case2
	decf	HI2C1STATEMACHINE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
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
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	3
	subwf	HI2C1STATEMACHINE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd4
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
SysSelectEnd4
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
SysDoLoop_S2
	btfss	I2C1CON0,S,BANKED
	bra	SysDoLoop_E2
;Wait for start
;NOP
	nop
;Loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;Dim HWI2C_BufferLocationCounterIndex as Word
;For HWI2C_BufferLocationCounterIndex = 1 to HWI2C_BufferLocationCounter
;Legacy method
	clrf	HWI2C_BUFFERLOCATIONCOUNTERINDEX,ACCESS
	clrf	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,ACCESS
	movlw	1
	subwf	HWI2C_BUFFERLOCATIONCOUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd7
SysForLoop7
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
SysDoLoop_S3
	banksel	I2C1STAT1
	btfsc	I2C1STAT1,TXBE,BANKED
	bra	SysDoLoop_E3
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
;Goto HI2CQ24StopExit
	bra	HI2CQ24STOPEXIT
;End If
;Loop
	bra	SysDoLoop_S3
SysDoLoop_E3
;Next
	movff	HWI2C_BUFFERLOCATIONCOUNTERINDEX,SysWORDTempA
	movff	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,SysWORDTempA_H
	movff	HWI2C_BUFFERLOCATIONCOUNTER,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
;Wait for a stop bit to complete
;Do while I2C1STAT0.MMA = 1 and HI2CWaitMSSPTimeout <> 255
SysDoLoop_S4
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
	bra	SysDoLoop_E4
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
;Loop
	bra	SysDoLoop_S4
SysDoLoop_E4
HI2CQ24STOPEXIT
;If I2C1PIR.7 = 1 then
	banksel	I2C1PIR
	btfss	I2C1PIR,7,BANKED
	bra	ELSE23_1
;HI2CAckpollState = False
	clrf	HI2CACKPOLLSTATE,ACCESS
;Else
	bra	ENDIF23
ELSE23_1
;HI2CAckpollState = True
	setf	HI2CACKPOLLSTATE,ACCESS
;End If
ENDIF23
;I2C1CON0.I2CEN=0
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
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DEACTIVATE_SCROLL)
	movlw	46
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYCLOCKDIV)            ' 0xD5
	movlw	213
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x80)                                  ' the suggested ratio 0x80
	movlw	128
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETMULTIPLEX)                  ' 0xA8
	movlw	168
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x3f)                                 '64 pixels
	movlw	63
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYOFFSET)              ' 0xD3
	movlw	211
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x00)                                   ' no offset
	clrf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETSTARTLINE | 0x00)            ' line #0
	movlw	64
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_CHARGEPUMP)                    ' 0x8D
	movlw	141
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;if (SSD1306_vccstate = SSD1306_EXTERNALVCC) then
;Write_Command_SSD1306(0x14)
	movlw	20
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_MEMORYMODE)                    ' 0x20
	movlw	32
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x00)                                  ' 0x00 act like ks0108 - DO NOT SELECT!!
;Write_Command_SSD1306(0x10)                                  ' 0x01 act like PCD8544
	movlw	16
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SEGREMAP | 0x1)
	movlw	161
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_COMSCANDEC)
	movlw	200
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCOMPINS)                    ' 0xDA
	movlw	218
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x12)                                 '64 pixels
	movlw	18
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCONTRAST)                   ' 0x81
	movlw	129
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xCF)
	movlw	207
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETPRECHARGE)                  ' 0xd9
	movlw	217
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xF1)
	movlw	241
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETVCOMDETECT)                 ' 0xDB
	movlw	219
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x40)
	movlw	64
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYALLON_RESUME)           ' 0xA4
	movlw	164
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_NORMALDISPLAY)                 ' 0xA6
	movlw	166
	movwf	SSD1306SENDBYTE,ACCESS
	rcall	WRITE_COMMAND_SSD1306
;Clear screen Here
;GLCDCLS_SSD1306
	call	GLCDCLS_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYON)                     '--turn on oled panel
	movlw	175
	movwf	SSD1306SENDBYTE,ACCESS
	bra	WRITE_COMMAND_SSD1306

;********************************************************************************

;Source: 210_i2c_glcd_sprites_using_ssd1306.gcb (28)
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

;Source: random.h (35)
INITRANDOM
;Dim RandomSeed As Word
;RandomSeed = RandStart
	movlw	94
	movwf	RANDOMSEED,ACCESS
	movlw	145
	movwf	RANDOMSEED_H,ACCESS
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

;Source: GLCD_SSD1306.H (898)
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
	movwf	SysRepeatTemp6,BANKED
SysRepeatLoop6
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SSD1306_BufferLocationCalc Right
	rrcf	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
	rrcf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp6,F,BANKED
	bra	SysRepeatLoop6
SysRepeatLoopEnd6
;faster than * 128
;Set C Off
	bcf	STATUS,C,ACCESS
;Repeat 7
	movlw	7
	movwf	SysRepeatTemp6,BANKED
SysRepeatLoop7
;Rotate SSD1306_BufferLocationCalc Left
	rlcf	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	rlcf	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp6,F,BANKED
	bra	SysRepeatLoop7
SysRepeatLoopEnd7
;SSD1306_BufferLocationCalc = GLCDX + SSD1306_BufferLocationCalc + 1
	movf	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	addwf	GLCDX,W,ACCESS
	movwf	SysTemp1,BANKED
	clrf	SysTemp3,BANKED
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	addwfc	SysTemp3,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	SSD1306_BUFFERLOCATIONCALC,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
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
	bra	ELSE39_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE,ACCESS
;Set C On
	bsf	STATUS,C,ACCESS
;Else
	bra	ENDIF39
ELSE39_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE,ACCESS
;Set C Off
	bcf	STATUS,C,ACCESS
;End If
ENDIF39
;Repeat GLCDBitNo
	movff	GLCDBITNO,SysRepeatTemp6
	movf	SYSREPEATTEMP6,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd8
SysRepeatLoop8
;Rotate GLCDChange Left
	rlcf	GLCDCHANGE,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp6,F,BANKED
	bra	SysRepeatLoop8
SysRepeatLoopEnd8
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,ACCESS
	bra	ELSE40_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	movf	GLCDDATATEMP,W,ACCESS
	andwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;Else
	bra	ENDIF40
ELSE40_1
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	movf	GLCDDATATEMP,W,ACCESS
	iorwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;End If
ENDIF40
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
	bra	ENDIF41
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
ENDIF41
	banksel	0
	return

;********************************************************************************

;Source: random.h (41)
FN_RANDOM
;Repeat 7
	movlw	7
	banksel	SYSREPEATTEMP5
	movwf	SysRepeatTemp5,BANKED
SysRepeatLoop5
;Dim RandomTemp As Word
;Dim RandomSeed As Word
;RandomTemp = RandomSeed
	movff	RANDOMSEED,RANDOMTEMP
	movff	RANDOMSEED_H,RANDOMTEMP_H
;Rotate RandomTemp Left Simple
	rlcf	RANDOMTEMP_H,W,ACCESS
	rlcf	RANDOMTEMP,F,ACCESS
	rlcf	RANDOMTEMP_H,F,ACCESS
;Taps at 16, 15, 13, 11, And with b'1101 0100 0000 0000' = D800
;Expanded below calculation to reduce complexity of calc
;RandomSeed = RandomTemp XOR (Not (RandomSeed And 1) + 1 And 0xB400)
	movlw	1
	andwf	RANDOMSEED,W,ACCESS
	movwf	SysTemp2,BANKED
	clrf	SysTemp2_H,BANKED
	comf	SysTemp2,W,BANKED
	movwf	SysTemp1,BANKED
	comf	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	clrf	SysTemp1,BANKED
	movlw	180
	andwf	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movf	RANDOMTEMP,W,ACCESS
	xorwf	SysTemp1,W,BANKED
	movwf	RANDOMSEED,ACCESS
	movf	RANDOMTEMP_H,W,ACCESS
	xorwf	SysTemp1_H,W,BANKED
	movwf	RANDOMSEED_H,ACCESS
;Expanded below calculation to reduce complexity of calc
;RandomSeed = Not (RandomSeed And 1) + 1
;RandomSeed = RandomSeed And 0xB400
;RandomSeed = RandomTemp XOR RandomSeed
;Random = Random Xor RandomSeed_H
	movf	RANDOM,W,ACCESS
	xorwf	RANDOMSEED_H,W,ACCESS
	movwf	RANDOM,ACCESS
;End Repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
	banksel	0
	return

;********************************************************************************

;Source: hwi2c.h (930)
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

SPRITE1
	movlw	9
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLESPRITE1
	movwf	TBLPTRL,ACCESS
	movlw	high TABLESPRITE1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLESPRITE1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLESPRITE1
	db	8,0,0,128,255,56,0,0,255

;********************************************************************************

SPRITE2
	movlw	9
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLESPRITE2
	movwf	TBLPTRL,ACCESS
	movlw	high TABLESPRITE2
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLESPRITE2
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLESPRITE2
	db	8,0,60,64,255,68,0,60,195

;********************************************************************************

SPRITE3
	movlw	9
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLESPRITE3
	movwf	TBLPTRL,ACCESS
	movlw	high TABLESPRITE3
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLESPRITE3
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLESPRITE3
	db	8,0,90,32,255,130,60,102,165

;********************************************************************************

SPRITE4
	movlw	9
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLESPRITE4
	movwf	TBLPTRL,ACCESS
	movlw	high TABLESPRITE4
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLESPRITE4
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLESPRITE4
	db	8,0,90,16,255,24,60,90,165

;********************************************************************************

SPRITE5
	movlw	9
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLESPRITE5
	movwf	TBLPTRL,ACCESS
	movlw	high TABLESPRITE5
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLESPRITE5
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLESPRITE5
	db	8,0,90,8,255,130,60,90,165

;********************************************************************************

SPRITE6
	movlw	9
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLESPRITE6
	movwf	TBLPTRL,ACCESS
	movlw	high TABLESPRITE6
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLESPRITE6
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLESPRITE6
	db	8,0,90,4,255,68,60,102,165

;********************************************************************************

SPRITE7
	movlw	9
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLESPRITE7
	movwf	TBLPTRL,ACCESS
	movlw	high TABLESPRITE7
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLESPRITE7
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLESPRITE7
	db	8,0,60,2,255,56,0,60,195

;********************************************************************************

SPRITE8
	movlw	9
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLESPRITE8
	movwf	TBLPTRL,ACCESS
	movlw	high TABLESPRITE8
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLESPRITE8
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLESPRITE8
	db	8,0,0,1,255,0,0,0,255

;********************************************************************************

;Source: stdbasic.h (303)
FN_SWAP4
;swapf Swap4In, W
	banksel	SWAP4IN
	swapf	SWAP4IN, W,BANKED
;movwf swap4
	movwf	SWAP4,BANKED
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

;Source: system.h (3387)
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
	db	17,71,76,67,68,32,76,105,98,114,97,114,121,32,50,48,50,52


StringTable3
	db	14,83,112,114,105,116,101,32,83,117,112,112,111,114,116


;********************************************************************************

;Source: GLCD_SSD1306.H (239)
WRITE_COMMAND_SSD1306
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x00
	clrf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend SSD1306SendByte
	movff	SSD1306SENDBYTE,I2CBYTE
	rcall	HI2CQ24SEND
;HI2CStop
	bra	HI2CQ24STOP

;********************************************************************************

;Source: GLCD_SSD1306.H (285)
WRITE_DATA_SSD1306
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend 0x40
	movlw	64
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24SEND
;HI2CSend SSD1306SendByte
	movff	SSD1306SENDBYTE,I2CBYTE
	rcall	HI2CQ24SEND
;HI2CStop
	bra	HI2CQ24STOP

;********************************************************************************


 END
