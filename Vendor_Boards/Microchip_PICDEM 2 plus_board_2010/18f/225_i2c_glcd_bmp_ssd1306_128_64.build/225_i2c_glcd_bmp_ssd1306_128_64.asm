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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\225_i2c_glcd_bmp_ssd1306_128_64.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\225_i2c_glcd_bmp_ssd1306_128_64.build\225_i2c_glcd_bmp_ssd1306_128_64.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\225_i2c_glcd_bmp_ssd1306_128_64.gcb"
 SUBTITLE    "08-15-2026 08:41:32"
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
CHARCODE                         EQU    1293          ; 0x50D (SA)
CHARCOL                          EQU    1294          ; 0x50E (SA)
CHARCOLS                         EQU    1296          ; 0x510 (SA)
CHARCOL_H                        EQU    1295          ; 0x50F (SA)
CHARLOCX                         EQU    1297          ; 0x511 (SA)
CHARLOCX_H                       EQU    1298          ; 0x512 (SA)
CHARLOCY                         EQU    1299          ; 0x513 (SA)
CHARLOCY_H                       EQU    1300          ; 0x514 (SA)
CHARROW                          EQU    1301          ; 0x515 (SA)
CHARROWS                         EQU    1303          ; 0x517 (SA)
CHARROW_H                        EQU    1302          ; 0x516 (SA)
COL                              EQU    1304          ; 0x518 (SA)
CURRCHARCOL                      EQU    1305          ; 0x519 (SA)
CURRCHARROW                      EQU    1306          ; 0x51A (SA)
CURRCHARVAL                      EQU    1307          ; 0x51B (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
FIRSTPASS                        EQU    1308          ; 0x51C (SA)
GLCDBACKGROUND                   EQU    1309          ; 0x51D (SA)
GLCDBACKGROUND_H                 EQU    1310          ; 0x51E (SA)
GLCDBITNO                        EQU    1311          ; 0x51F (SA)
GLCDCHANGE                       EQU    1312          ; 0x520 (SA)
GLCDCOLOUR                       EQU    1313          ; 0x521 (SA)
GLCDCOLOUR_H                     EQU    1314          ; 0x522 (SA)
GLCDDATATEMP                     EQU    1315          ; 0x523 (SA)
GLCDFNTDEFAULT                   EQU    1316          ; 0x524 (SA)
GLCDFNTDEFAULTHEIGHT             EQU    1317          ; 0x525 (SA)
GLCDFNTDEFAULTSIZE               EQU    1318          ; 0x526 (SA)
GLCDFONTWIDTH                    EQU    1319          ; 0x527 (SA)
GLCDFOREGROUND                   EQU    1320          ; 0x528 (SA)
GLCDFOREGROUND_H                 EQU    1321          ; 0x529 (SA)
GLCDPRINTLEN                     EQU    1322          ; 0x52A (SA)
GLCDPRINTLOC                     EQU    1323          ; 0x52B (SA)
GLCDPRINTLOC_H                   EQU    1324          ; 0x52C (SA)
GLCDPRINT_STRING_COUNTER         EQU    1325          ; 0x52D (SA)
GLCDTEMP                         EQU    1326          ; 0x52E (SA)
GLCDX                            EQU    1327          ; 0x52F (SA)
GLCDY                            EQU    1328          ; 0x530 (SA)
GLCD_YORDINATE                   EQU    1329          ; 0x531 (SA)
GLCD_YORDINATE_H                 EQU    1330          ; 0x532 (SA)
HEIGHTOFPICTURE                  EQU    1331          ; 0x533 (SA)
HI2C1LASTERROR                   EQU    1332          ; 0x534 (SA)
HI2C1STATEMACHINE                EQU    1333          ; 0x535 (SA)
HI2CACKPOLLSTATE                 EQU    1334          ; 0x536 (SA)
HI2CCURRENTMODE                  EQU    1335          ; 0x537 (SA)
HI2CWAITMSSPTIMEOUT              EQU    1336          ; 0x538 (SA)
HWI2C_BUFFER                     EQU    4316          ; 0x10DC
HWI2C_BUFFERLOCATIONCOUNTER      EQU    1337          ; 0x539 (SA)
HWI2C_BUFFERLOCATIONCOUNTERINDEX EQU    1339          ; 0x53B (SA)
HWI2C_BUFFERLOCATIONCOUNTERINDEX EQU    1340          ; 0x53C (SA)
HWI2C_BUFFERLOCATIONCOUNTER_H    EQU    1338          ; 0x53A (SA)
I2CBYTE                          EQU    1341          ; 0x53D (SA)
LENGTHOFPICTURE                  EQU    1342          ; 0x53E (SA)
LENGTHOFPICTURE_H                EQU    1343          ; 0x53F (SA)
LINECOLOUR                       EQU    1344          ; 0x540 (SA)
LINECOLOUR_H                     EQU    1345          ; 0x541 (SA)
LOCX                             EQU    1346          ; 0x542 (SA)
LOCY                             EQU    1347          ; 0x543 (SA)
ORGCHARLOCX                      EQU    1348          ; 0x544 (SA)
POSCHARX                         EQU    1349          ; 0x545 (SA)
POSCHARX_H                       EQU    1350          ; 0x546 (SA)
POSCHARY                         EQU    1351          ; 0x547 (SA)
PRINTLOCX                        EQU    1352          ; 0x548 (SA)
PRINTLOCX_H                      EQU    1353          ; 0x549 (SA)
PRINTLOCY                        EQU    1354          ; 0x54A (SA)
PRINTLOCY_H                      EQU    1355          ; 0x54B (SA)
RAM_INDEX                        EQU    1356          ; 0x54C (SA)
RAM_INDEX_H                      EQU    1357          ; 0x54D (SA)
ROW                              EQU    1358          ; 0x54E (SA)
SSD1306SENDBYTE                  EQU    1359          ; 0x54F (SA)
SSD1306_BUFFERALIAS              EQU    4351          ; 0x10FF
SSD1306_BUFFERLOCATIONCALC       EQU    1360          ; 0x550 (SA)
SSD1306_BUFFERLOCATIONCALC_H     EQU    1361          ; 0x551 (SA)
STRINGPOINTER                    EQU    1362          ; 0x552 (SA)
SYSBYTETEMPA                     EQU    1285          ; 0x505 (SA)
SYSBYTETEMPB                     EQU    1289          ; 0x509 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPA                     EQU    1285          ; 0x505 (SA)
SYSDIVLOOP                       EQU    1284          ; 0x504 (SA)
SYSDIVMULTA                      EQU    1287          ; 0x507 (SA)
SYSDIVMULTA_H                    EQU    1288          ; 0x508 (SA)
SYSDIVMULTB                      EQU    1291          ; 0x50B (SA)
SYSDIVMULTB_H                    EQU    1292          ; 0x50C (SA)
SYSDIVMULTX                      EQU    1282          ; 0x502 (SA)
SYSDIVMULTX_H                    EQU    1283          ; 0x503 (SA)
SYSFORLOOPABSVALUE5              EQU    1363          ; 0x553 (SA)
SYSFORLOOPABSVALUE5_H            EQU    1364          ; 0x554 (SA)
SYSFORLOOPSTEP4                  EQU    1365          ; 0x555 (SA)
SYSFORLOOPSTEP4_H                EQU    1366          ; 0x556 (SA)
SYSLCDPRINTDATAHANDLER           EQU    1367          ; 0x557 (SA)
SYSLCDPRINTDATAHANDLER_H         EQU    1368          ; 0x558 (SA)
SYSREPEATTEMP1                   EQU    1369          ; 0x559 (SA)
SYSREPEATTEMP4                   EQU    1370          ; 0x55A (SA)
SYSSTRINGA                       EQU    1287          ; 0x507 (SA)
SYSSTRINGA_H                     EQU    1288          ; 0x508 (SA)
SYSSTRINGLENGTH                  EQU    1286          ; 0x506 (SA)
SYSSTRINGPARAM1                  EQU    4333          ; 0x10ED
SYSTEMP1                         EQU    1371          ; 0x55B (SA)
SYSTEMP1_H                       EQU    1372          ; 0x55C (SA)
SYSTEMP2                         EQU    1373          ; 0x55D (SA)
SYSTEMP2_H                       EQU    1374          ; 0x55E (SA)
SYSTEMP3                         EQU    1375          ; 0x55F (SA)
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
WIDTHOFPICTURE                   EQU    1376          ; 0x560

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
	call	HI2CQ24Q35INIT
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
;@date    02-08-2026
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
;These constants allow you to change the GLCD memory usage.
;We have set this demonstration to use only 128bytes of RAM for GLCD operations.
;#DEFINE GLCD_TYPE_SSD1306_LOWMEMORY_GLCD_MODE
;#DEFINE GLCD_TYPE_SSD1306_CHARACTER_MODE_ONLY
;! Include a BMP file.  This will automatically convert to a table called ANOBIUMFULL
;Dim lengthofpicture, ram_index as word
;Dim bytenumber, widthofpicture, heightofpicture, orgcharlocx, currcharval, firstpass, charlocy, currcharrow, charlocx, ccount as Byte
;GLCDCLS
	call	GLCDCLS_SSD1306
;GLCD_Open_PageTransaction 0,7
;Macro Source: GLCD_SSD1306.H (1234)
;GLCDPrint 0,0, "About to load BMP"
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	clrf	PRINTLOCY,ACCESS
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
	movwf	SysLCDPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,ACCESS
;Using SYSSTRINGPARAM1*17
	call	GLCDPRINT5
;GLCD_Close_PageTransaction
;Macro Source: GLCD_SSD1306.H (1246)
;Wait 4 s
	movlw	4
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;Display a BMP file
;Add your own case statement here to handle multiple BMPs, you just  need the variables to be defined
;ReadTable AnobiumFull, 0, lengthofpicture
	movlw	2
	movwf	LENGTHOFPICTURE,ACCESS
	movlw	4
	movwf	LENGTHOFPICTURE_H,ACCESS
;ReadTable AnobiumFull, 1, widthofpicture
	movlw	128
	banksel	WIDTHOFPICTURE
	movwf	WIDTHOFPICTURE,BANKED
;ReadTable AnobiumFull, 2, heightofpicture
	movlw	64
	movwf	HEIGHTOFPICTURE,ACCESS
;lengthofpicture =  heightofpicture / 8
	movff	HEIGHTOFPICTURE,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	movlw	8
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SYSDIVSUB16
	movff	SysWORDTempA,LENGTHOFPICTURE
	movff	SysWORDTempA_H,LENGTHOFPICTURE_H
;lengthofpicture = [word]lengthofpicture * widthofpicture
	movff	LENGTHOFPICTURE,SysWORDTempA
	movff	LENGTHOFPICTURE_H,SysWORDTempA_H
	movff	WIDTHOFPICTURE,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	call	SYSMULTSUB16
	movff	SysWORDTempX,LENGTHOFPICTURE
	movff	SysWORDTempX_H,LENGTHOFPICTURE_H
;For BMP that fit the display simple write the data to the screen
;GLCD_Open_PageTransaction 0,7
;Macro Source: GLCD_SSD1306.H (1234)
;CharLocX = 0                      // specify X pos for BMP
	clrf	CHARLOCX,ACCESS
;CharLocY = 0                      // specify Y pos for BMP.  For buffer any valid Y, for non-buffered 0,8,16, 24 etc...
	clrf	CHARLOCY,ACCESS
;OrgCharLocX = CharLocX             // specify X orginisal X pos
	movff	CHARLOCX,ORGCHARLOCX
;firstpass = true                   // specify this is the first pass
	setf	FIRSTPASS,ACCESS
;for  ram_index =  3 to lengthofpicture + 3         ; start at third byte and finish at the end
;Legacy method
	movlw	2
	movwf	RAM_INDEX,ACCESS
	clrf	RAM_INDEX_H,ACCESS
	movlw	3
	addwf	LENGTHOFPICTURE,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	addwfc	LENGTHOFPICTURE_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movlw	3
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
	incf	RAM_INDEX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	RAM_INDEX_H,F,ACCESS
;Add your own case statement here to handle multiple BMPs, you just  need set CurrCharVal to the data value
;ReadTable AnobiumFull,  ( ram_index ), CurrCharVal // read data
	movff	RAM_INDEX,SYSSTRINGA
	movff	RAM_INDEX_H,SYSSTRINGA_H
	rcall	ANOBIUMFULL
	movwf	CURRCHARVAL,ACCESS
;if ( ( ram_index - 3 ) % widthofpicture ) = 0  and firstpass = false then    // change position for new line of data
	movlw	3
	subwf	RAM_INDEX,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	subwfb	RAM_INDEX_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movff	WIDTHOFPICTURE,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempX,SysTemp2
	movff	SysWORDTempX_H,SysTemp2_H
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	movff	SysByteTempX,SysTemp1
	movff	FIRSTPASS,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	call	SYSCOMPEQUAL
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	ENDIF2
;CharLocY = CharLocY + 8
	movlw	8
	addwf	CHARLOCY,F,ACCESS
;CharLocX = OrgCharLocX
	movff	ORGCHARLOCX,CHARLOCX
;end if
ENDIF2
;For CurrCharRow = 0 to 7
;Legacy method
	setf	CURRCHARROW,ACCESS
SysForLoop2
	incf	CURRCHARROW,F,ACCESS
;if ( CharLocY + CurrCharRow < GLCD_HEIGHT ) and ( CharLocX < GLCD_WIDTH ) then
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	movlw	64
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp2
	movff	CHARLOCX,SysBYTETempA
	movlw	128
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp1
	movf	SysTemp2,W,ACCESS
	andwf	SysTemp1,W,ACCESS
	movwf	SysTemp3,ACCESS
	btfss	SysTemp3,0,ACCESS
	bra	ENDIF3
;If CurrCharVal.0 = 0 Then
	btfsc	CURRCHARVAL,0,ACCESS
	bra	ELSE6_1
;PSet CharLocX , CharLocY + CurrCharRow, GLCDBackground
	movff	CHARLOCX,GLCDX
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	call	PSET_SSD1306
;Else
	bra	ENDIF6
ELSE6_1
;PSet CharLocX , CharLocY + CurrCharRow, GLCDForeground
	movff	CHARLOCX,GLCDX
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	GLCDY,ACCESS
	movff	GLCDFOREGROUND,GLCDCOLOUR
	movff	GLCDFOREGROUND_H,GLCDCOLOUR_H
	call	PSET_SSD1306
;End If
ENDIF6
;end if
ENDIF3
;Rotate CurrCharVal Right
	rrcf	CURRCHARVAL,F,ACCESS
;Next
	movlw	7
	subwf	CURRCHARROW,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;firstpass = false                                         // now this is NOT the first pass
	clrf	FIRSTPASS,ACCESS
;CharLocX++                                                // increment the X pos
	incf	CHARLOCX,F,ACCESS
;next
	movlw	3
	addwf	LENGTHOFPICTURE,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	addwfc	LENGTHOFPICTURE_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movff	RAM_INDEX,SysWORDTempA
	movff	RAM_INDEX_H,SysWORDTempA_H
	movff	SysTemp1,SysWORDTempB
	movff	SysTemp1_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;GLCD_Close_PageTransaction
;Macro Source: GLCD_SSD1306.H (1246)
;GLCD SSD1306 buffer is 1024bytes
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

ANOBIUMFULL
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	191
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEANOBIUMFULL
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEANOBIUMFULL
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEANOBIUMFULL
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEANOBIUMFULL
	db	2,128,64,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	128,240,156,231,56,14,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,6,13,11,30,52,104,216,240,96,192,128,128
	db	128,192,192,64,64,96,96,96,32,32,32,48,48,16,16,16,24,24,8,14,27,126,227,128,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,3,7,12,56,112,192,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,3,6,28,176,224,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	63,96,64,192,128,128,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,192,224,112
	db	24,12,6,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,3,2,6,6,4,12,8,24,24,16,48,32
	db	96,96,64,96,48,24,12,6,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,192,176,142,129,142,176
	db	192,0,0,248,16,8,8,8,240,0,0,240,8,8,8,8,240,0,0,255,16,8,8,8,240,0,0,249,0,0
	db	248,0,0,0,0,248,0,0,248,16,8,8,8,240,16,8,8,8,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,1,0,0,0,0,0,1,6,0,7,0,0,0,0,7,0,0,3,4,4,4,4
	db	3,0,0,7,2,4,4,4,3,0,0,7,0,0,3,4,4,4,2,7,0,0,7,0,0,0,0,7,0,0,0,0,7

;********************************************************************************

ANOBIUMFULL_H
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEANOBIUMFULL_H
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEANOBIUMFULL_H
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEANOBIUMFULL_H
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEANOBIUMFULL_H
	db	4

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
	movwf	SysRepeatTemp4,ACCESS
SysRepeatLoop4
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate PosCharY Right
	rrcf	POSCHARY,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp4,F,ACCESS
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
;Write_Command_SSD1306( 0xB0 + PosCharY )   ' set page address
	movlw	176
	addwf	POSCHARY,W,ACCESS
	movwf	SSD1306SENDBYTE,ACCESS
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
	movwf	SysRepeatTemp4,ACCESS
SysRepeatLoop5
;Set C off
	bcf	STATUS,C,ACCESS
;Rotate PosCharX Right
	rrcf	POSCHARX_H,F,ACCESS
	rrcf	POSCHARX,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp4,F,ACCESS
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
;PosCharX = ( PosCharX & 0x0F ) + 0x10
	movlw	15
	andwf	POSCHARX,W,ACCESS
	movwf	SysTemp1,ACCESS
	clrf	SysTemp1_H,ACCESS
	movlw	16
	addwf	SysTemp1,W,ACCESS
	movwf	POSCHARX,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,ACCESS
	movwf	POSCHARX_H,ACCESS
;Write_Command_SSD1306 ( PosCharX )
	movff	POSCHARX,SSD1306SENDBYTE
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

;Source: GLCD_SSD1306.H (464)
GLCDCLS_SSD1306
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,ACCESS
	clrf	GLCD_YORDINATE_H,ACCESS
;For SSD1306_BufferLocationCalc = 1 to GLCD_HEIGHT * GLCD_WIDTH / 8
;Legacy method
	clrf	SSD1306_BUFFERLOCATIONCALC,ACCESS
	clrf	SSD1306_BUFFERLOCATIONCALC_H,ACCESS
SysForLoop4
	incf	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	lfsr	0,SSD1306_BUFFERALIAS
	movf	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	clrf	INDF0,ACCESS
;Next
	movff	SSD1306_BUFFERLOCATIONCALC,SysWORDTempA
	movff	SSD1306_BUFFERLOCATIONCALC_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	movlw	4
	movwf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	clrf	SSD1306_BUFFERLOCATIONCALC,ACCESS
	clrf	SSD1306_BUFFERLOCATIONCALC_H,ACCESS
SysForLoop5
;Init SysForLoopStep4 :#0
	movlw	8
	movwf	SysForLoopStep4,ACCESS
	clrf	SysForLoopStep4_H,ACCESS
;Cursor_Position_SSD1306 ( 0 , SSD1306_BufferLocationCalc )
	clrf	LOCX,ACCESS
	movff	SSD1306_BUFFERLOCATIONCALC,LOCY
	rcall	CURSOR_POSITION_SSD1306
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1272)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	rcall	SI2CSTART
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
SysForLoop6
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
	bra	SysForLoop6
SysForLoopEnd6
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1336)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	rcall	HI2CQ24Q35STOP
;Next
;Integer negative Step Handler in For-next statement
	btfss	SYSFORLOOPSTEP4_H,7,ACCESS
	bra	ELSE15_1
;Set SysForLoopABsValue to -StepValue :#1 
	comf	SYSFORLOOPSTEP4,W,ACCESS
	movwf	SysForLoopABsValue5,ACCESS
	comf	SYSFORLOOPSTEP4_H,W,ACCESS
	movwf	SysForLoopABsValue5_H,ACCESS
	incf	SysForLoopABsValue5,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SysForLoopABsValue5_H,F,ACCESS
;IF ( SSD1306_BUFFERLOCATIONCALC - 64-1) } [WORD]SysForLoopABsValue5 THEN  :#1n 
	movlw	64
	subwf	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	subwfb	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movlw	1
	subwf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	movlw	0
	subwfb	SysTemp1_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movff	SYSFORLOOPABSVALUE5,SysWORDTempB
	movff	SYSFORLOOPABSVALUE5_H,SysWORDTempB_H
	rcall	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF16
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	movf	SysForLoopStep4,W,ACCESS
	addwf	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
	movf	SysForLoopStep4_H,W,ACCESS
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
	bra	SysForLoop5
;END IF
ENDIF16
	bra	ENDIF15
ELSE15_1
;Integer positive Step Handler in For-next statement
;IF ([WORD]64-1 - [WORD]SSD1306_BUFFERLOCATIONCALC) } [WORD]SysForLoopStep4 THEN :#1p 
	movf	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
	sublw	63
	movwf	SysTemp1,ACCESS
	clrf	SysTemp3,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
	subwfb	SysTemp3,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movff	SYSFORLOOPSTEP4,SysWORDTempB
	movff	SYSFORLOOPSTEP4_H,SysWORDTempB_H
	rcall	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF17
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	movf	SysForLoopStep4,W,ACCESS
	addwf	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
	movf	SysForLoopStep4_H,W,ACCESS
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
	bra	SysForLoop5
;END IF
ENDIF17
;END IF
ENDIF15
SysForLoopEnd5
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
	rcall	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF18
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 0
	clrf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;end if
ENDIF18
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
	rcall	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp3
	movff	CHARCODE,SysBYTETempB
	movlw	202
	movwf	SysBYTETempA,ACCESS
	rcall	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp3,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,ACCESS
	btfss	SysTemp1,0,ACCESS
	bra	ENDIF19
;CharLocY=CharLocY-1
	movlw	1
	subwf	CHARLOCY,F,ACCESS
	movlw	0
	subwfb	CHARLOCY_H,F,ACCESS
;end if
ENDIF19
;For CurrCharCol = 1 to 5
;Legacy method
	clrf	CURRCHARCOL,ACCESS
SysForLoop7
	incf	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect1Case1
	decf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL3
	movwf	CURRCHARVAL,ACCESS
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL4
	movwf	CURRCHARVAL,ACCESS
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL5
	movwf	CURRCHARVAL,ACCESS
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL6
	movwf	CURRCHARVAL,ACCESS
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case5
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL7
	movwf	CURRCHARVAL,ACCESS
;End Select
SysSelectEnd1
;Full Memory GLCD mode
;CharRow=0
	clrf	CHARROW,ACCESS
	clrf	CHARROW_H,ACCESS
;For CurrCharRow = 1 to 8
;Legacy method
	clrf	CURRCHARROW,ACCESS
SysForLoop8
	incf	CURRCHARROW,F,ACCESS
;CharColS=0
	clrf	CHARCOLS,ACCESS
;For Col=1 to GLCDfntDefaultsize
;Legacy method
	clrf	COL,ACCESS
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd9
SysForLoop9
	incf	COL,F,ACCESS
;CharRowS=0
	clrf	CHARROWS,ACCESS
;For Row=1 to GLCDfntDefaultsize
;Legacy method
	clrf	ROW,ACCESS
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd10
SysForLoop10
	incf	ROW,F,ACCESS
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0,ACCESS
	bra	ELSE22_1
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, LineColour
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	SysTemp3,ACCESS
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp3,W,ACCESS
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp3,ACCESS
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp3,W,ACCESS
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	rcall	PSET_SSD1306
;Else
	bra	ENDIF22
ELSE22_1
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, GLCDBackground
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	SysTemp3,ACCESS
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp3,W,ACCESS
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp3,ACCESS
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp3,W,ACCESS
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	rcall	PSET_SSD1306
;End if
ENDIF22
;Put out a white intercharacter pixel/space
;PSet [word]CharLocX + ( GLCDFontWidth * GLCDfntDefaultsize) , [word]CharLocY + CharRow + CharRowS , GLCDBackground
	movf	GLCDFONTWIDTH,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movff	PRODL,SysTemp3
	movf	SysTemp3,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp3,ACCESS
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp3,W,ACCESS
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	rcall	PSET_SSD1306
;CharRowS +=1
	incf	CHARROWS,F,ACCESS
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	subwf	ROW,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;CharColS +=1
	incf	CHARCOLS,F,ACCESS
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	subwf	COL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
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
	bra	SysForLoop8
SysForLoopEnd8
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
	bra	SysForLoop7
SysForLoopEnd7
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
	bra	SysForLoopEnd3
SysForLoop3
	incf	GLCDPRINT_STRING_COUNTER,F,ACCESS
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movff	PRINTLOCY,CHARLOCY
	movff	PRINTLOCY_H,CHARLOCY_H
	movf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	addwf	SysLCDPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,CHARCODE
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	GLCDDRAWCHAR_SSD1306
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1528)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	movf	GLCDFONTWIDTH,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movff	PRODL,SysTemp3
	movf	SysTemp3,W,ACCESS
	addwf	GLCDPRINTLOC,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	addwfc	GLCDPRINTLOC_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movlw	1
	addwf	SysTemp1,W,ACCESS
	movwf	GLCDPRINTLOC,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,ACCESS
	movwf	GLCDPRINTLOC_H,ACCESS
;Next
	movf	GLCDPRINTLEN,W,ACCESS
	subwf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
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
SysSelect2Case1
	movlw	2
	subwf	HI2C1STATEMACHINE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
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
	bra	SysSelectEnd2
SysSelect2Case2
	decf	HI2C1STATEMACHINE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
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
	bra	SysSelectEnd2
SysSelect2Case3
	movlw	3
	subwf	HI2C1STATEMACHINE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
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
SysSelectEnd2
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
SysDoLoop_S1
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E1
;If I2C1STAT0.BFRE  = 0 Then Exit Do
	btfss	I2C1STAT0,BFRE,BANKED
;If I2C1STAT0.BFRE  = 0 Then Exit Do
	bra	SysDoLoop_E1
;If I2C1STAT0.BFRE  = 0 Then Exit Do
;HI2CWaitMSSPTimeout++
	incf	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;If HI2CWaitMSSPTimeout <> 255 Then
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF33
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
	bra	SysForLoopEnd11
SysForLoop11
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
;Goto HI2CQ24Q35StopExit
	bra	HI2CQ24Q35STOPEXIT
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
	bra	SysForLoop11
SysForLoopEnd11
;Wait for a stop bit to complete
;Do while I2C1STAT0.MMA = 1 and HI2CWaitMSSPTimeout <> 255
SysDoLoop_S4
	clrf	SysByteTempX,ACCESS
	banksel	I2C1STAT0
	btfsc	i2c1stat0,mma,BANKED
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp3
	movff	hi2cwaitmssptimeout,SysBYTETempA
	setf	SysBYTETempB,ACCESS
	banksel	0
	rcall	SYSCOMPEQUAL
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp3,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,ACCESS
	btfss	SysTemp1,0,ACCESS
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
;End If
ENDIF33
HI2CQ24Q35STOPEXIT
;If I2C1PIR.7 = 1 then
	banksel	I2C1PIR
	btfss	I2C1PIR,7,BANKED
	bra	ELSE34_1
;HI2CAckpollState = False
	clrf	HI2CACKPOLLSTATE,ACCESS
;Else
	bra	ENDIF34
ELSE34_1
;HI2CAckpollState = True
	setf	HI2CACKPOLLSTATE,ACCESS
;End If
ENDIF34
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
	rcall	GLCDCLS_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYON)                     '--turn on oled panel
	movlw	175
	movwf	SSD1306SENDBYTE,ACCESS
	bra	WRITE_COMMAND_SSD1306

;********************************************************************************

;Source: 225_i2c_glcd_bmp_ssd1306_128_64.gcb (62)
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
	movff	SysByteTempX,SysTemp3
	movff	GLCDY,SysBYTETempA
	movlw	64
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp3,W,ACCESS
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,ACCESS
	btfsc	SysTemp1,0,ACCESS
;exit sub
	return
;end if
;1.14 Addresses correct device horizonal page
;don't need to do these calculations for in LOWMEMORY_GLCD_MODE
;SSD1306_BufferLocationCalc = ( GLCDY / 8 )* GLCD_WIDTH
;faster than /8
;SSD1306_BufferLocationCalc = GLCDY
	movff	GLCDY,SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H,ACCESS
;Repeat 3
	movlw	3
	movwf	SysRepeatTemp1,ACCESS
SysRepeatLoop1
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SSD1306_BufferLocationCalc Right
	rrcf	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
	rrcf	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;faster than * 128
;Set C Off
	bcf	STATUS,C,ACCESS
;Repeat 7
	movlw	7
	movwf	SysRepeatTemp1,ACCESS
SysRepeatLoop2
;Rotate SSD1306_BufferLocationCalc Left
	rlcf	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
	rlcf	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;SSD1306_BufferLocationCalc = GLCDX + SSD1306_BufferLocationCalc + 1
	movf	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
	addwf	GLCDX,W,ACCESS
	movwf	SysTemp1,ACCESS
	clrf	SysTemp3,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
	addwfc	SysTemp3,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movlw	1
	addwf	SysTemp1,W,ACCESS
	movwf	SSD1306_BUFFERLOCATIONCALC,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,ACCESS
	movwf	SSD1306_BUFFERLOCATIONCALC_H,ACCESS
;anything beyond buffer boundary?
;why? X = 127 and Y = 64 (Y is over 63!) will have passed first check....
;if SSD1306_BufferLocationCalc > GLCD_HEIGHT * GLCD_WIDTH Then
	movff	SSD1306_BUFFERLOCATIONCALC,SysWORDTempB
	movff	SSD1306_BUFFERLOCATIONCALC_H,SysWORDTempB_H
	clrf	SysWORDTempA,ACCESS
	movlw	32
	movwf	SysWORDTempA_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
;exit sub
	return
;end if
;GLCDDataTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
	lfsr	0,SSD1306_BUFFERALIAS
	movf	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,GLCDDATATEMP
;Change data to set/clear pixel
;GLCDBitNo = GLCDY And 7
	movlw	7
	andwf	GLCDY,W,ACCESS
	movwf	GLCDBITNO,ACCESS
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,ACCESS
	bra	ELSE29_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE,ACCESS
;Set C On
	bsf	STATUS,C,ACCESS
;Else
	bra	ENDIF29
ELSE29_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE,ACCESS
;Set C Off
	bcf	STATUS,C,ACCESS
;End If
ENDIF29
;Repeat GLCDBitNo
	movff	GLCDBITNO,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd3
SysRepeatLoop3
;Rotate GLCDChange Left
	rlcf	GLCDCHANGE,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,ACCESS
	bra	ELSE30_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	movf	GLCDDATATEMP,W,ACCESS
	andwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;Else
	bra	ENDIF30
ELSE30_1
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	movf	GLCDDATATEMP,W,ACCESS
	iorwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;End If
ENDIF30
;added 1.14 to isolate from full glcd mode
;revised 1.14 to isolate from low memory mode
;if SSD1306_BufferAlias(SSD1306_BufferLocationCalc) <> GLCDDataTemp then
	lfsr	0,SSD1306_BUFFERALIAS
	movf	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movf	GLCDDATATEMP,W,ACCESS
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF31
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDDataTemp
	lfsr	0,SSD1306_BUFFERALIAS
	movf	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movff	GLCDDATATEMP,INDF0
;Cursor_Position_SSD1306 ( GLCDX, GLCDY )
	movff	GLCDX,LOCX
	movff	GLCDY,LOCY
	call	CURSOR_POSITION_SSD1306
;Write_Data_SSD1306 ( GLCDDataTemp )
	movff	GLCDDATATEMP,SSD1306SENDBYTE
	rcall	WRITE_DATA_SSD1306
;end if
ENDIF31
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
	bra	ENDIF10
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF10
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
	bra	ENDIF11
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF11
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

StringTable2
	db	17,65,98,111,117,116,32,116,111,32,108,111,97,100,32,66,77,80


;********************************************************************************

;Source: GLCD_SSD1306.H (256)
WRITE_COMMAND_SSD1306
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24Q35SEND
;HI2CSend 0x00
	clrf	I2CBYTE,ACCESS
	rcall	HI2CQ24Q35SEND
;HI2CSend SSD1306SendByte
	movff	SSD1306SENDBYTE,I2CBYTE
	rcall	HI2CQ24Q35SEND
;HI2CStop
	bra	HI2CQ24Q35STOP

;********************************************************************************

;Source: GLCD_SSD1306.H (302)
WRITE_DATA_SSD1306
;HI2CStart
	rcall	SI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24Q35SEND
;HI2CSend 0x40
	movlw	64
	movwf	I2CBYTE,ACCESS
	rcall	HI2CQ24Q35SEND
;HI2CSend SSD1306SendByte
	movff	SSD1306SENDBYTE,I2CBYTE
	rcall	HI2CQ24Q35SEND
;HI2CStop
	bra	HI2CQ24Q35STOP

;********************************************************************************


 END
