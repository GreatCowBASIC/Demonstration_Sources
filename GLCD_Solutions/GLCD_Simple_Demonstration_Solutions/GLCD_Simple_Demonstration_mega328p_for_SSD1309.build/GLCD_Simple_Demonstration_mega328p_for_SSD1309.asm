;Program compiled by GCBASIC (2026.07.24 (Windows 64 bit) : Build 1610) for Microchip AVR Assembler using FreeBASIC 1.07.1/2026-07-24 CRC247
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Simple_Demonstration_Solutions\GLCD_Simple_Demonstration_mega328p_for_SSD1309.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : 
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Simple_Demonstration_Solutions\GLCD_Simple_Demonstration_mega328p_for_SSD1309.build\GLCD_Simple_Demonstration_mega328p_for_SSD1309.asm
;   Float Capability : 1
;********************************************************************************

;Chip Model: MEGA328P
;Assembler header file
.INCLUDE "m328pdef.inc"

;SREG bit names (for AVR Assembler compatibility, GCBASIC uses different names)
#define C 0
#define H 5
#define I 7
#define N 2
#define S 4
#define T 6
#define V 3
;#define Z 1

;********************************************************************************

;Set aside memory locations for variables
.EQU	BYTENUMBER=1393	         ; 0x571
.EQU	CCOUNT=1394	         ; 0x572
.EQU	CHARCODE=1395	         ; 0x573
.EQU	CHARCOL=1396	         ; 0x574
.EQU	CHARCOLS=1398	         ; 0x576
.EQU	CHARCOL_H=1397	         ; 0x575
.EQU	CHARLOCX=1399	         ; 0x577
.EQU	CHARLOCX_H=1400	         ; 0x578
.EQU	CHARLOCY=1401	         ; 0x579
.EQU	CHARLOCY_H=1402	         ; 0x57A
.EQU	CHARROW=1403	         ; 0x57B
.EQU	CHARROWS=1405	         ; 0x57D
.EQU	CHARROW_H=1404	         ; 0x57C
.EQU	COL=1406	         ; 0x57E
.EQU	CURRCHARCOL=1407	         ; 0x57F
.EQU	CURRCHARROW=1408	         ; 0x580
.EQU	CURRCHARVAL=1409	         ; 0x581
.EQU	DDF_X=1410	         ; 0x582
.EQU	DDF_X_H=1411	         ; 0x583
.EQU	DDF_Y=1412	         ; 0x584
.EQU	DDF_Y_H=1413	         ; 0x585
.EQU	DIM_STATE=1414	         ; 0x586
.EQU	DRAWLINE=1415	         ; 0x587
.EQU	DRAWLINE_H=1416	         ; 0x588
.EQU	FF=1417	         ; 0x589
.EQU	FF_H=1418	         ; 0x58A
.EQU	FILLCIRCLEXX=1419	         ; 0x58B
.EQU	FILLCIRCLEYY=1420	         ; 0x58C
.EQU	FIRSTPASS=1421	         ; 0x58D
.EQU	GLCDBACKGROUND=1422	         ; 0x58E
.EQU	GLCDBACKGROUND_H=1423	         ; 0x58F
.EQU	GLCDBITNO=1424	         ; 0x590
.EQU	GLCDCHANGE=1425	         ; 0x591
.EQU	GLCDCOLOUR=1426	         ; 0x592
.EQU	GLCDCOLOUR_H=1427	         ; 0x593
.EQU	GLCDDATATEMP=1428	         ; 0x594
.EQU	GLCDFNTDEFAULT=1429	         ; 0x595
.EQU	GLCDFNTDEFAULTHEIGHT=1430	         ; 0x596
.EQU	GLCDFNTDEFAULTSIZE=1431	         ; 0x597
.EQU	GLCDFONTWIDTH=1432	         ; 0x598
.EQU	GLCDFOREGROUND=1433	         ; 0x599
.EQU	GLCDFOREGROUND_H=1434	         ; 0x59A
.EQU	GLCDPRINTLEN=1435	         ; 0x59B
.EQU	GLCDPRINTLOC=1436	         ; 0x59C
.EQU	GLCDPRINTLOC_H=1437	         ; 0x59D
.EQU	GLCDPRINT_STRING_COUNTER=1438	         ; 0x59E
.EQU	GLCDTEMP=1439	         ; 0x59F
.EQU	GLCDTEMP_H=1440	         ; 0x5A0
.EQU	GLCDX=1441	         ; 0x5A1
.EQU	GLCDY=1442	         ; 0x5A2
.EQU	GLCD_YORDINATE=1443	         ; 0x5A3
.EQU	GLCD_YORDINATE_H=1444	         ; 0x5A4
.EQU	HEIGHTOFPICTURE=1445	         ; 0x5A5
.EQU	I2CACK=1446	         ; 0x5A6
.EQU	I2CACKPOLLSTATE=1447	         ; 0x5A7
.EQU	I2CBYTE=1448	         ; 0x5A8
.EQU	I2CMATCH=1449	         ; 0x5A9
.EQU	I2CSTATE=1450	         ; 0x5AA
.EQU	INXRADIUS=1451	         ; 0x5AB
.EQU	INXRADIUS_H=1452	         ; 0x5AC
.EQU	LCDVALUE=1453	         ; 0x5AD
.EQU	LCDVALUE_E=1456	         ; 0x5B0
.EQU	LCDVALUE_H=1454	         ; 0x5AE
.EQU	LCDVALUE_U=1455	         ; 0x5AF
.EQU	LENGTHOFPICTURE=1457	         ; 0x5B1
.EQU	LENGTHOFPICTURE_H=1458	         ; 0x5B2
.EQU	LINECOLOUR=1459	         ; 0x5B3
.EQU	LINECOLOUR_E=1462	         ; 0x5B6
.EQU	LINECOLOUR_H=1460	         ; 0x5B4
.EQU	LINECOLOUR_U=1461	         ; 0x5B5
.EQU	LINEDIFFX=1463	         ; 0x5B7
.EQU	LINEDIFFX_H=1464	         ; 0x5B8
.EQU	LINEDIFFX_X2=1465	         ; 0x5B9
.EQU	LINEDIFFX_X2_H=1466	         ; 0x5BA
.EQU	LINEDIFFY=1467	         ; 0x5BB
.EQU	LINEDIFFY_H=1468	         ; 0x5BC
.EQU	LINEDIFFY_X2=1469	         ; 0x5BD
.EQU	LINEDIFFY_X2_H=1470	         ; 0x5BE
.EQU	LINEERR=1471	         ; 0x5BF
.EQU	LINEERR_H=1472	         ; 0x5C0
.EQU	LINESTEPX=1473	         ; 0x5C1
.EQU	LINESTEPX_H=1474	         ; 0x5C2
.EQU	LINESTEPY=1475	         ; 0x5C3
.EQU	LINESTEPY_H=1476	         ; 0x5C4
.EQU	LINEX1=1477	         ; 0x5C5
.EQU	LINEX1_H=1478	         ; 0x5C6
.EQU	LINEX2=1479	         ; 0x5C7
.EQU	LINEX2_H=1480	         ; 0x5C8
.EQU	LINEY1=1481	         ; 0x5C9
.EQU	LINEY1_H=1482	         ; 0x5CA
.EQU	LINEY2=1483	         ; 0x5CB
.EQU	LINEY2_H=1484	         ; 0x5CC
.EQU	LOCX=1485	         ; 0x5CD
.EQU	LOCY=1486	         ; 0x5CE
.EQU	LONGNUMBER=1487	         ; 0x5CF
.EQU	LONGNUMBER_E=1490	         ; 0x5D2
.EQU	LONGNUMBER_H=1488	         ; 0x5D0
.EQU	LONGNUMBER_U=1489	         ; 0x5D1
.EQU	ORGCHARLOCX=1491	         ; 0x5D3
.EQU	OUTSTRING=1281	         ; 0x501
.EQU	PAD=1322	         ; 0x52A
.EQU	POSCHARX=1492	         ; 0x5D4
.EQU	POSCHARX_H=1493	         ; 0x5D5
.EQU	POSCHARY=1494	         ; 0x5D6
.EQU	PRINTLOCX=1495	         ; 0x5D7
.EQU	PRINTLOCX_H=1496	         ; 0x5D8
.EQU	PRINTLOCY=1497	         ; 0x5D9
.EQU	PRINTLOCY_H=1498	         ; 0x5DA
.EQU	RADIUSERR=1499	         ; 0x5DB
.EQU	RADIUSERR_H=1500	         ; 0x5DC
.EQU	RAM_INDEX=1501	         ; 0x5DD
.EQU	RAM_INDEX_H=1502	         ; 0x5DE
.EQU	ROW=1503	         ; 0x5DF
.EQU	SSD1309SENDBYTE=1504	         ; 0x5E0
.EQU	SSD1309_BUFFERALIAS=256	         ; 0x100
.EQU	SSD1309_BUFFERLOCATIONCALC=1505	         ; 0x5E1
.EQU	SSD1309_BUFFERLOCATIONCALC_H=1506	         ; 0x5E2
.EQU	SSD1309_SCROLLSPEED=1507	         ; 0x5E3
.EQU	SSD1309_START=1508	         ; 0x5E4
.EQU	SSD1309_STOP=1509	         ; 0x5E5
.EQU	STR=1383	         ; 0x567
.EQU	STRINGLOCX=1510	         ; 0x5E6
.EQU	STRINGPOINTER=1511	         ; 0x5E7
.EQU	SYSARRAYTEMP1=1512	         ; 0x5E8
.EQU	SYSARRAYTEMP2=1513	         ; 0x5E9
.EQU	SYSCHARCOUNT=1514	         ; 0x5EA
.EQU	SYSCHARSHANDLER=1515	         ; 0x5EB
.EQU	SYSCHARSHANDLER_H=1516	         ; 0x5EC
.EQU	SYSFORLOOPABSVALUE14=1517	         ; 0x5ED
.EQU	SYSFORLOOPABSVALUE14_H=1518	         ; 0x5EE
.EQU	SYSFORLOOPSTEP13=1519	         ; 0x5EF
.EQU	SYSFORLOOPSTEP13_H=1520	         ; 0x5F0
.EQU	SYSLCDPRINTDATAHANDLER=1521	         ; 0x5F1
.EQU	SYSLCDPRINTDATAHANDLER_H=1522	         ; 0x5F2
.EQU	SYSLONGDIVMULTA=1523	         ; 0x5F3
.EQU	SYSLONGDIVMULTA_E=1526	         ; 0x5F6
.EQU	SYSLONGDIVMULTA_H=1524	         ; 0x5F4
.EQU	SYSLONGDIVMULTA_U=1525	         ; 0x5F5
.EQU	SYSLONGDIVMULTB=1527	         ; 0x5F7
.EQU	SYSLONGDIVMULTB_E=1530	         ; 0x5FA
.EQU	SYSLONGDIVMULTB_H=1528	         ; 0x5F8
.EQU	SYSLONGDIVMULTB_U=1529	         ; 0x5F9
.EQU	SYSLONGDIVMULTX=1531	         ; 0x5FB
.EQU	SYSLONGDIVMULTX_E=1534	         ; 0x5FE
.EQU	SYSLONGDIVMULTX_H=1532	         ; 0x5FC
.EQU	SYSLONGDIVMULTX_U=1533	         ; 0x5FD
.EQU	SYSPRINTBUFFER=1363	         ; 0x553
.EQU	SYSPRINTBUFFLEN=1535	         ; 0x5FF
.EQU	SYSREPEATTEMP1=1536	         ; 0x600
.EQU	SYSREPEATTEMP4=1537	         ; 0x601
.EQU	SYSREPEATTEMP6=1538	         ; 0x602
.EQU	SYSSTRDATA=1539	         ; 0x603
.EQU	SYSSTRINGPARAM1=1374	         ; 0x55E
.EQU	SYSSTRINGTEMP=1540	         ; 0x604
.EQU	SYSSTRLEN=1541	         ; 0x605
.EQU	SYSSYSINSTRING3HANDLER=1542	         ; 0x606
.EQU	SYSSYSINSTRING3HANDLER_H=1543	         ; 0x607
.EQU	SYSSYSINSTRINGHANDLER=1544	         ; 0x608
.EQU	SYSSYSINSTRINGHANDLER_H=1545	         ; 0x609
.EQU	SYSVALTEMP=1546	         ; 0x60A
.EQU	SYSVALTEMP_H=1547	         ; 0x60B
.EQU	WIDTHOFPICTURE=1548	         ; 0x60C
.EQU	WORDNUMBER=1549	         ; 0x60D
.EQU	WORDNUMBER_H=1550	         ; 0x60E
.EQU	XCHAR=1551	         ; 0x60F
.EQU	XOFFSET=1552	         ; 0x610
.EQU	XOFFSET_H=1553	         ; 0x611
.EQU	XRADIUS=1554	         ; 0x612
.EQU	XRADIUS_H=1555	         ; 0x613
.EQU	YCALC1=1556	         ; 0x614
.EQU	YCALC1_H=1557	         ; 0x615
.EQU	YCALC2=1558	         ; 0x616
.EQU	YCALC2_H=1559	         ; 0x617
.EQU	YOFFSET=1560	         ; 0x618
.EQU	YOFFSET_H=1561	         ; 0x619
.EQU	YORDINATE=1562	         ; 0x61A
.EQU	_HEXPICAS=1389	         ; 0x56D

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
.DEF	SYSCALCTEMPA_U=r24
.DEF	SYSCALCTEMPA_E=r25
.DEF	SYSCALCTEMPB=r28
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
.DEF	SYSWAITTEMPUS=r27
.DEF	SYSWAITTEMPUS_H=r28
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
.DEF	SYSTEMP3=r16
.DEF	SYSTEMP4=r17

;********************************************************************************

;Alias variables
#define	SYSPAD_0	1322
#define	SYSSTR_0	1383
#define	SYS_HEXPICAS_0	1389
#define	SYS_HEXPICAS_1	1390
#define	SYS_HEXPICAS_2	1391

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
	reti	;PCINT0
	.ORG	8
	reti	;PCINT1
	.ORG	10
	reti	;PCINT2
	.ORG	12
	reti	;WDT
	.ORG	14
	reti	;TIMER2_COMPA
	.ORG	16
	reti	;TIMER2_COMPB
	.ORG	18
	reti	;TIMER2_OVF
	.ORG	20
	reti	;TIMER1_CAPT
	.ORG	22
	reti	;TIMER1_COMPA
	.ORG	24
	reti	;TIMER1_COMPB
	.ORG	26
	reti	;TIMER1_OVF
	.ORG	28
	reti	;TIMER0_COMPA
	.ORG	30
	reti	;TIMER0_COMPB
	.ORG	32
	reti	;TIMER0_OVF
	.ORG	34
	reti	;SPI_STC
	.ORG	36
	reti	;USART_RX
	.ORG	38
	reti	;USART_UDRE
	.ORG	40
	reti	;USART_TX
	.ORG	42
	reti	;ADC
	.ORG	44
	reti	;EE_READY
	.ORG	46
	reti	;ANALOG_COMP
	.ORG	48
	reti	;TWI
	.ORG	50
	reti	;SPM_READY

;********************************************************************************

;Program_memory_page: 0
.ORG	52
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	SPL, SysValueCopy
;Call initialisation routines
	call	INITSYS
	call	INITI2C
	call	INITGLCD_SSD1309

;Start_of_the_main_program
;''A demonstration program for GCBASIC.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is a simple GLCD demonstration of the SSD1309 GLCD capabilities.
;''This program draws lines, boxes, circles and prints strings and numbers.
;''The SSD1309 controller a small graphical OLED, suitable for a lot of various projects.
;''The display is 38*35 mm, with an active display surface of 0.96inches , and a 128*64 pixel resolution.
;''The display is easy to interface, using an I2C type of communication.
;''The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;''@author  EvanV
;''@licence GPL
;''@version 1.3
;''@date    08.11.14
;''********************************************************************************
;----- Configuration
;----- Define Software settings
;Define I2C settings - CHANGE PORTS
;'Optionally, you can reduce the I2C timings.
;----- Define Hardware settings
;Define I2C settings
;#define HI2C_BAUD_RATE 400
;#define HI2C_DATA
;HI2CMode Master
;----- Define GLCD Hardware settings
;GLCDCLS
	call	GLCDCLS_SSD1309
;Dim BYTENUMBER, WIDTHOFPICTURE, HEIGHTOFPICTURE, ORGCHARLOCX, CURRCHARVAL, FIRSTPASS, CHARLOCY, CURRCHARROW, CHARLOCX, CCOUNT as Byte
;CCount = 0
	ldi	SysValueCopy,0
	sts	CCOUNT,SysValueCopy
;dim longNumber as long
;longNumber = 123456 ' max value = 4294967290
	ldi	SysValueCopy,64
	sts	LONGNUMBER,SysValueCopy
	ldi	SysValueCopy,226
	sts	LONGNUMBER_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	LONGNUMBER_U,SysValueCopy
	ldi	SysValueCopy,0
	sts	LONGNUMBER_E,SysValueCopy
;dim wordNumber as Word
;dim outstring as string
;wordNumber = 0
	ldi	SysValueCopy,0
	sts	WORDNUMBER,SysValueCopy
	sts	WORDNUMBER_H,SysValueCopy
;byteNumber = 0
	ldi	SysValueCopy,0
	sts	BYTENUMBER,SysValueCopy
;dim lengthofpicture, ram_index as word
;Display a BMP file
;GLCDCLS
	call	GLCDCLS_SSD1309
;Add your own case statement here to handle multiple BMPs, you just  need the variables to be defined
;ReadTable AnobiumFull, 0, lengthofpicture
	ldi	SysValueCopy,250
	sts	LENGTHOFPICTURE,SysValueCopy
	ldi	SysValueCopy,3
	sts	LENGTHOFPICTURE_H,SysValueCopy
;ReadTable AnobiumFull, 1, widthofpicture
	ldi	SysValueCopy,127
	sts	WIDTHOFPICTURE,SysValueCopy
;ReadTable AnobiumFull, 2, heightofpicture
	ldi	SysValueCopy,64
	sts	HEIGHTOFPICTURE,SysValueCopy
;lengthofpicture =  heightofpicture / 8
	lds	SysWORDTempA,HEIGHTOFPICTURE
	ldi	SysWORDTempA_H,0
	ldi	SysWORDTempB,8
	ldi	SysWORDTempB_H,0
	call	SYSDIVSUB16
	sts	LENGTHOFPICTURE,SysWORDTempA
	sts	LENGTHOFPICTURE_H,SysWORDTempA_H
;lengthofpicture = [word]lengthofpicture * widthofpicture
	lds	SysWORDTempA,LENGTHOFPICTURE
	lds	SysWORDTempA_H,LENGTHOFPICTURE_H
	lds	SysWORDTempB,WIDTHOFPICTURE
	ldi	SysWORDTempB_H,0
	call	SYSMULTSUB16
	sts	LENGTHOFPICTURE,SysWORDTempX
	sts	LENGTHOFPICTURE_H,SysWORDTempX_H
;For BMP that fit the display simple write the data to the screen
;CharLocX = 0                       ' specify X pos for BMP
	ldi	SysValueCopy,0
	sts	CHARLOCX,SysValueCopy
;CharLocY = 0                       ' specify Y pos for BMP.  For buffer any valid Y, for non-buffered 0,8,16, 24 etc...
	ldi	SysValueCopy,0
	sts	CHARLOCY,SysValueCopy
;OrgCharLocX = CharLocX              ' specify X orginisal X pos
	lds	SysValueCopy,CHARLOCX
	sts	ORGCHARLOCX,SysValueCopy
;firstpass = true                    ' specify this is the first pass
	ldi	SysValueCopy,255
	sts	FIRSTPASS,SysValueCopy
;for  ram_index =  3 to lengthofpicture + 3         ; start at third byte and finish at the end
;Legacy method
	ldi	SysValueCopy,2
	sts	RAM_INDEX,SysValueCopy
	ldi	SysValueCopy,0
	sts	RAM_INDEX_H,SysValueCopy
	lds	SysTemp2,LENGTHOFPICTURE
	ldi	SysTemp3,3
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,LENGTHOFPICTURE_H
	ldi	SysTemp3,0
	adc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	ldi	SysWORDTempB,3
	ldi	SysWORDTempB_H,0
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	call	SYSCOMPLESSTHAN16
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd1
SysForLoop1:
	lds	SysTemp1,RAM_INDEX
	inc	SysTemp1
	sts	RAM_INDEX,SysTemp1
	lds	SysTemp1,RAM_INDEX_H
	brne	PC + 2
	inc	SysTemp1
	sts	RAM_INDEX_H,SysTemp1
;Add your own case statement here to handle multiple BMPs, you just  need set CurrCharVal to the data value
;ReadTable AnobiumFull,  ( ram_index ), CurrCharVal  ' read data
	lds	SYSSTRINGA,RAM_INDEX
	lds	SYSSTRINGA_H,RAM_INDEX_H
	rcall	ANOBIUMFULL
	sts	CURRCHARVAL,SysByteTempX
;if ( ( ram_index - 3 ) % widthofpicture ) = 0  and firstpass = false then     ' change position for new line of data
	lds	SysTemp2,RAM_INDEX
	ldi	SysTemp3,3
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,RAM_INDEX_H
	ldi	SysTemp3,0
	sbc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	lds	SysWORDTempB,WIDTHOFPICTURE
	ldi	SysWORDTempB_H,0
	call	SYSDIVSUB16
	mov	SysTemp2,SysWORDTempX
	mov	SysTemp2_H,SysWORDTempX_H
	mov	SysWORDTempA,SysTemp2
	mov	SysWORDTempA_H,SysTemp2_H
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,0
	call	SYSCOMPEQUAL16
	mov	SysTemp1,SysByteTempX
	lds	SysBYTETempA,FIRSTPASS
	ldi	SysBYTETempB,0
	call	SYSCOMPEQUAL
	mov	SysTemp3,SysByteTempX
	and	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	sbrs	SysTemp2,0
	rjmp	ENDIF2
;CharLocY = CharLocY + 8
	lds	SysTemp1,CHARLOCY
	ldi	SysTemp3,8
	add	SysTemp1,SysTemp3
	sts	CHARLOCY,SysTemp1
;CharLocX = OrgCharLocX
	lds	SysValueCopy,ORGCHARLOCX
	sts	CHARLOCX,SysValueCopy
;end if
ENDIF2:
;For CurrCharRow = 0 to 7
;Legacy method
	ldi	SysValueCopy,255
	sts	CURRCHARROW,SysValueCopy
SysForLoop2:
	lds	SysTemp1,CURRCHARROW
	inc	SysTemp1
	sts	CURRCHARROW,SysTemp1
;if ( CharLocY + CurrCharRow < GLCD_HEIGHT ) and ( CharLocX < GLCD_WIDTH ) then
	lds	SysTemp2,CHARLOCY
	lds	SysTemp3,CURRCHARROW
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	mov	SysBYTETempA,SysTemp1
	ldi	SysBYTETempB,64
	call	SYSCOMPLESSTHAN
	mov	SysTemp2,SysByteTempX
	lds	SysBYTETempA,CHARLOCX
	ldi	SysBYTETempB,128
	call	SYSCOMPLESSTHAN
	mov	SysTemp1,SysByteTempX
	and	SysTemp1,SysTemp2
	mov	SysTemp3,SysTemp1
	sbrs	SysTemp3,0
	rjmp	ENDIF3
;If CurrCharVal.0 = 0 Then
	lds	SysBitTest,CURRCHARVAL
	sbrc	SysBitTest,0
	rjmp	ELSE7_1
;PSet CharLocX , CharLocY + CurrCharRow, GLCDBackground
	lds	SysValueCopy,CHARLOCX
	sts	GLCDX,SysValueCopy
	lds	SysTemp1,CHARLOCY
	lds	SysTemp2,CURRCHARROW
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,GLCDBACKGROUND
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;Else
	rjmp	ENDIF7
ELSE7_1:
;PSet CharLocX , CharLocY + CurrCharRow, GLCDForeground
	lds	SysValueCopy,CHARLOCX
	sts	GLCDX,SysValueCopy
	lds	SysTemp1,CHARLOCY
	lds	SysTemp2,CURRCHARROW
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,GLCDFOREGROUND
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;End If
ENDIF7:
;end if
ENDIF3:
;Rotate CurrCharVal Right
	lds	SysValueCopy,CURRCHARVAL
	ror	SysValueCopy
	sts	CURRCHARVAL,SysValueCopy
;Next
	lds	SysCalcTempA,CURRCHARROW
	cpi	SysCalcTempA,7
	brsh	ENDIF4
	rjmp	SysForLoop2
ENDIF4:
SysForLoopEnd2:
;firstpass = false                                          ' now this is NOT the first pass
	ldi	SysValueCopy,0
	sts	FIRSTPASS,SysValueCopy
;CharLocX++                                                 ' increment the X pos
	lds	SysTemp1,CHARLOCX
	inc	SysTemp1
	sts	CHARLOCX,SysTemp1
;next
	lds	SysTemp2,LENGTHOFPICTURE
	ldi	SysTemp3,3
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,LENGTHOFPICTURE_H
	ldi	SysTemp3,0
	adc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	lds	SysWORDTempA,RAM_INDEX
	lds	SysWORDTempA_H,RAM_INDEX_H
	mov	SysWORDTempB,SysTemp1
	mov	SysWORDTempB_H,SysTemp1_H
	call	SYSCOMPLESSTHAN16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop1
SysForLoopEnd1:
;wait 2 s
	ldi	SysWaitTempS,2
	rcall	Delay_S
;SetContrast_SSD1309 ( 10 )
	ldi	SysValueCopy,10
	sts	DIM_STATE,SysValueCopy
	call	SETCONTRAST_SSD1309
;wait 2 s
	ldi	SysWaitTempS,2
	rcall	Delay_S
;startscrollright_SSD1309(0x00, 0x0F)
	ldi	SysValueCopy,0
	sts	SSD1309_START,SysValueCopy
	ldi	SysValueCopy,15
	sts	SSD1309_STOP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SSD1309_SCROLLSPEED,SysValueCopy
	call	STARTSCROLLRIGHT_SSD1309
;wait 3 s
	ldi	SysWaitTempS,3
	rcall	Delay_S
;startscrollleft_SSD1309(0x00, 0x0F)
	ldi	SysValueCopy,0
	sts	SSD1309_START,SysValueCopy
	ldi	SysValueCopy,15
	sts	SSD1309_STOP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SSD1309_SCROLLSPEED,SysValueCopy
	call	STARTSCROLLLEFT_SSD1309
;wait 3 s
	ldi	SysWaitTempS,3
	rcall	Delay_S
;startscrolldiagright_SSD1309(0x00, 0x0F)
	ldi	SysValueCopy,0
	sts	SSD1309_START,SysValueCopy
	ldi	SysValueCopy,15
	sts	SSD1309_STOP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SSD1309_SCROLLSPEED,SysValueCopy
	call	STARTSCROLLDIAGRIGHT_SSD1309
;wait 3 s
	ldi	SysWaitTempS,3
	rcall	Delay_S
;startscrolldiagleft_SSD1309(0x00, 0x0F)
	ldi	SysValueCopy,0
	sts	SSD1309_START,SysValueCopy
	ldi	SysValueCopy,15
	sts	SSD1309_STOP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SSD1309_SCROLLSPEED,SysValueCopy
	call	STARTSCROLLDIAGLEFT_SSD1309
;wait 3 s
	ldi	SysWaitTempS,3
	rcall	Delay_S
;stopscroll_SSD1309
	call	STOPSCROLL_SSD1309
;GLCDCLS
	call	GLCDCLS_SSD1309
;Prepare the static components of the screen
;GLCDPrint ( 0,   0, "PrintStr")                                ; Print some text
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable1<<1)
	ldi	SysReadA_H,high(StringTable1<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
;Using SYSSTRINGPARAM1*8
	call	GLCDPRINT4
;GLCDPrint ( 64,  0, "@")                                    ; Print some more text
	ldi	SysValueCopy,64
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
;Using SYSSTRINGPARAM1*1
	call	GLCDPRINT4
;GLCDPrint ( 72,  0, ChipMhz)                                   ; Print chip speed
	ldi	SysValueCopy,72
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysValueCopy,16
	sts	LCDVALUE,SysValueCopy
	ldi	SysValueCopy,0
	sts	LCDVALUE_H,SysValueCopy
	sts	LCDVALUE_U,SysValueCopy
	sts	LCDVALUE_E,SysValueCopy
	call	GLCDPRINT7
;GLCDPrint ( 86, 0, "Mhz")                                     ; Print some text
	ldi	SysValueCopy,86
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
;Using SYSSTRINGPARAM1*3
	call	GLCDPRINT4
;GLCDDrawString( 0,8,"DrawStr")                                 ; Draw some text
	ldi	SysValueCopy,0
	sts	STRINGLOCX,SysValueCopy
	ldi	SysValueCopy,8
	sts	CHARLOCY,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARSHandler_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
;Using SYSSTRINGPARAM1*7
	call	GLCDDRAWSTRING
;box 0,0,GLCD_WIDTH-1, GLCD_HEIGHT-1                            ; Draw a box
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1,SysValueCopy
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,127
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	BOX16
;box GLCD_WIDTH-5, GLCD_HEIGHT-5,GLCD_WIDTH-1, GLCD_HEIGHT-1    ; Draw a box
	ldi	SysValueCopy,123
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,59
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,127
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	BOX16
;Circle( 44,41,15)                                              ; Draw a circle
	ldi	SysValueCopy,44
	sts	XOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	YOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET_H,SysValueCopy
	ldi	SysValueCopy,15
	sts	INXRADIUS,SysValueCopy
	ldi	SysValueCopy,0
	sts	INXRADIUS_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	lds	SysValueCopy,GLCD_YORDINATE
	sts	YORDINATE,SysValueCopy
	rcall	CIRCLE19
;line 64,31,0,31                                                ; Draw a line
	ldi	SysValueCopy,64
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2,SysValueCopy
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	_LINE70
;DO forever
SysDoLoop_S1:
;for CCount = 32 to 127
;Legacy method
	ldi	SysValueCopy,31
	sts	CCOUNT,SysValueCopy
SysForLoop3:
	lds	SysTemp1,CCOUNT
	inc	SysTemp1
	sts	CCOUNT,SysTemp1
;GLCDPrint ( 64 ,  36,  hex(longNumber_E ) )                 ; Print a HEX string
	ldi	SysValueCopy,64
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,36
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,LONGNUMBER_E
	sts	SYSVALTEMP,SysValueCopy
	call	FN__HEXPICAS
	ldi	SysValueCopy,low(_HEXPICAS)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(_HEXPICAS)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 76 ,  36,  hex(longNumber_U ) )                 ; Print a HEX string
	ldi	SysValueCopy,76
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,36
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,LONGNUMBER_U
	sts	SYSVALTEMP,SysValueCopy
	call	FN__HEXPICAS
	ldi	SysValueCopy,low(_HEXPICAS)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(_HEXPICAS)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 88 ,  36,  hex(longNumber_H ) )                 ; Print a HEX string
	ldi	SysValueCopy,88
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,36
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,LONGNUMBER_H
	sts	SYSVALTEMP,SysValueCopy
	call	FN__HEXPICAS
	ldi	SysValueCopy,low(_HEXPICAS)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(_HEXPICAS)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 100 ,  36, hex(longNumber   ) )                 ; Print a HEX string
	ldi	SysValueCopy,100
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,36
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,LONGNUMBER
	sts	SYSVALTEMP,SysValueCopy
	call	FN__HEXPICAS
	ldi	SysValueCopy,low(_HEXPICAS)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(_HEXPICAS)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 112 ,  36, "h" )                                ; Print a HEX string
	ldi	SysValueCopy,112
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,36
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable5<<1)
	ldi	SysReadA_H,high(StringTable5<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
;Using SYSSTRINGPARAM1*1
	call	GLCDPRINT4
;GLCDPrint ( 64 ,  44, pad(str(wordNumber), 5 ) )           ; Print a padded string
	ldi	SysValueCopy,64
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,44
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,WORDNUMBER
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,WORDNUMBER_H
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,5
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable52<<1)
	ldi	SysReadA_H,high(StringTable52<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
;Using SYSSTRINGPARAM1*1
	call	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;GLCDPrint ( 64 ,  52, pad(str(byteNumber), 3 ) )           ; Print a padded string
	ldi	SysValueCopy,64
	sts	PRINTLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCX_H,SysValueCopy
	ldi	SysValueCopy,52
	sts	PRINTLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	PRINTLOCY_H,SysValueCopy
	lds	SysValueCopy,BYTENUMBER
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable52<<1)
	ldi	SysReadA_H,high(StringTable52<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
;Using SYSSTRINGPARAM1*1
	call	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	call	GLCDPRINT4
;box (46,9,56,19)                                           ; Draw a Box
	ldi	SysValueCopy,46
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,9
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,56
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,19
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	BOX16
;GLCDDrawChar(48, 9, CCount )                               ; Draw a character
	ldi	SysValueCopy,48
	sts	CHARLOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	CHARLOCX_H,SysValueCopy
	ldi	SysValueCopy,9
	sts	CHARLOCY,SysValueCopy
	ldi	SysValueCopy,0
	sts	CHARLOCY_H,SysValueCopy
	lds	SysValueCopy,CCOUNT
	sts	CHARCODE,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	GLCDDRAWCHAR_SSD1309
;outString = str( CCount )                                  ; Prepare a string
	lds	SysValueCopy,CCOUNT
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	call	FN_STR
	ldi	SysStringB,low(OUTSTRING)
	ldi	SysStringB_H,high(OUTSTRING)
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	call	SYSCOPYSTRING
;GLCDDrawString(64, 9, pad(outString,3) )                   ; Draw a string
	ldi	SysValueCopy,64
	sts	STRINGLOCX,SysValueCopy
	ldi	SysValueCopy,9
	sts	CHARLOCY,SysValueCopy
	ldi	SysValueCopy,low(OUTSTRING)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(OUTSTRING)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,3
	sts	SYSSTRLEN,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable52<<1)
	ldi	SysReadA_H,high(StringTable52<<1)
	call	SYSREADSTRING
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSYSINSTRING3Handler_H,SysValueCopy
;Using SYSSTRINGPARAM1*1
	call	FN_PAD
	ldi	SysValueCopy,low(PAD)
	sts	SysCHARSHandler,SysValueCopy
	ldi	SysValueCopy,high(PAD)
	sts	SysCHARSHandler_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	GLCDDRAWSTRING
;filledbox 3,43,11,51, wordNumber                           ; Draw a filled box
	ldi	SysValueCopy,3
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,43
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,11
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,51
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,WORDNUMBER
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,WORDNUMBER_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	FILLEDBOX_SSD1309
;FilledCircle( 44,41,9, longNumber xor 1)                   ; Draw a filled box
	ldi	SysValueCopy,44
	sts	XOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	XOFFSET_H,SysValueCopy
	ldi	SysValueCopy,41
	sts	YOFFSET,SysValueCopy
	ldi	SysValueCopy,0
	sts	YOFFSET_H,SysValueCopy
	ldi	SysValueCopy,9
	sts	XRADIUS,SysValueCopy
	ldi	SysValueCopy,0
	sts	XRADIUS_H,SysValueCopy
	ldi	SysTemp3,1
	lds	SysTemp1,LONGNUMBER
	eor	SysTemp1,SysTemp3
	sts	LINECOLOUR,SysTemp1
	lds	SysValueCopy,LONGNUMBER_H
	sts	LINECOLOUR_H,SysValueCopy
	lds	SysValueCopy,LONGNUMBER_U
	sts	LINECOLOUR_U,SysValueCopy
	lds	SysValueCopy,LONGNUMBER_E
	sts	LINECOLOUR_E,SysValueCopy
	rcall	FILLEDCIRCLE22
;line 0,63,64,31                                            ; Draw a line
	ldi	SysValueCopy,0
	sts	LINEX1,SysValueCopy
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,63
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,64
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,31
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	call	_LINE70
;Do some simple maths
;longNumber = longNumber + 7 : wordNumber = wordNumber + 3 : byteNumber++
	lds	SysTemp1,LONGNUMBER
	ldi	SysTemp3,7
	add	SysTemp1,SysTemp3
	sts	LONGNUMBER,SysTemp1
	lds	SysTemp1,LONGNUMBER_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	LONGNUMBER_H,SysTemp1
	lds	SysTemp1,LONGNUMBER_U
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	LONGNUMBER_U,SysTemp1
	lds	SysTemp1,LONGNUMBER_E
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	LONGNUMBER_E,SysTemp1
;longNumber = longNumber + 7 : wordNumber = wordNumber + 3 : byteNumber++
	lds	SysTemp1,WORDNUMBER
	ldi	SysTemp3,3
	add	SysTemp1,SysTemp3
	sts	WORDNUMBER,SysTemp1
	lds	SysTemp1,WORDNUMBER_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	WORDNUMBER_H,SysTemp1
;longNumber = longNumber + 7 : wordNumber = wordNumber + 3 : byteNumber++
	lds	SysTemp1,BYTENUMBER
	inc	SysTemp1
	sts	BYTENUMBER,SysTemp1
;NEXT
	lds	SysCalcTempA,CCOUNT
	cpi	SysCalcTempA,127
	brsh	ENDIF6
	rjmp	SysForLoop3
ENDIF6:
SysForLoopEnd3:
;LOOP
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
;end
	rjmp	BASPROGRAMEND
;GLCD SSD1309 buffer is 1024bytes
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

ANOBIUMFULL:
	mov	SysWORDTempA,SYSSTRINGA
	mov	SysWORDTempA_H,SYSSTRINGA_H
	ldi	SysWORDTempB,184
	ldi	SysWORDTempB_H,3
	call	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	ret
	ldi	SysReadA, low(TABLEANOBIUMFULL<<1)
	ldi	SysReadA_H, high(TABLEANOBIUMFULL<<1)
	add	SysReadA, SysStringA
	adc	SysReadA_H, SysStringA_H
	lpm
	ret
TABLEANOBIUMFULL:
	.DB	250,127,64,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	128,240,156,231,56,14,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,6,13,11,30,52,104,216,240,96,192,128,128,128
	.DB	192,192,64,64,96,96,96,32,32,32,48,48,16,16,16,24,24,8,14,27,126,227,128,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,3,7,12,56,112,192,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,3,6,28,176,224,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,96
	.DB	64,192,128,128,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,192,224,112,24,12
	.DB	6,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,3,2,6,6,4,12,8,24,24,16,48,32,96,96,64
	.DB	96,48,24,12,6,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,192,176,142,129,142,176,192,0,0,248
	.DB	16,8,8,8,240,0,0,240,8,8,8,8,240,0,0,255,16,8,8,8,240,0,0,249,0,0,248,0,0,0,0,248
	.DB	0,0,248,16,8,8,8,240,16,8,8,8,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,6,1,0,0,0,0,0,1,6,0,7,0,0,0,0,7,0,0,3,4,4,4,4,3,0,0,7,2,4,4,4,3
	.DB	0,0,7,0,0,3,4,4,4,2,7,0,0,7,0,0,0,0,7,0,0,0,0,7

;********************************************************************************

ANOBIUMFULL_H:
	mov	SysWORDTempA,SYSSTRINGA
	mov	SysWORDTempA_H,SYSSTRINGA_H
	ldi	SysWORDTempB,1
	ldi	SysWORDTempB_H,0
	call	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	ret
	ldi	SysReadA, low(TABLEANOBIUMFULL_H<<1)
	ldi	SysReadA_H, high(TABLEANOBIUMFULL_H<<1)
	add	SysReadA, SysStringA
	adc	SysReadA_H, SysStringA_H
	lpm
	ret
TABLEANOBIUMFULL_H:
	.DB	3

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (1800)
BOX16:
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	lds	SysWORDTempB,LINEX1
	lds	SysWORDTempB_H,LINEX1_H
	lds	SysWORDTempA,LINEX2
	lds	SysWORDTempA_H,LINEX2_H
	call	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	rjmp	ENDIF15
;GLCDTemp = LineX1
	lds	SysValueCopy,LINEX1
	sts	GLCDTEMP,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	GLCDTEMP_H,SysValueCopy
;LineX1 = LineX2
	lds	SysValueCopy,LINEX2
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,LINEX2_H
	sts	LINEX1_H,SysValueCopy
;LineX2 = GLCDTemp
	lds	SysValueCopy,GLCDTEMP
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,GLCDTEMP_H
	sts	LINEX2_H,SysValueCopy
;End If
ENDIF15:
;If LineY1 > LineY2 Then
	lds	SysWORDTempB,LINEY1
	lds	SysWORDTempB_H,LINEY1_H
	lds	SysWORDTempA,LINEY2
	lds	SysWORDTempA_H,LINEY2_H
	call	SYSCOMPLESSTHAN16
	sbrs	SysByteTempX,0
	rjmp	ENDIF16
;GLCDTemp = LineY1
	lds	SysValueCopy,LINEY1
	sts	GLCDTEMP,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDTEMP_H,SysValueCopy
;LineY1 = LineY2
	lds	SysValueCopy,LINEY2
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,LINEY2_H
	sts	LINEY1_H,SysValueCopy
;LineY2 = GLCDTemp
	lds	SysValueCopy,GLCDTEMP
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,GLCDTEMP_H
	sts	LINEY2_H,SysValueCopy
;End If
ENDIF16:
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
;Legacy method
	lds	SysTemp1,LINEX1
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	DRAWLINE,SysTemp1
	lds	SysTemp1,LINEX1_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	DRAWLINE_H,SysTemp1
	lds	SysWORDTempB,LINEX1
	lds	SysWORDTempB_H,LINEX1_H
	lds	SysWORDTempA,LINEX2
	lds	SysWORDTempA_H,LINEX2_H
	call	SYSCOMPLESSTHAN16
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd7
SysForLoop7:
	lds	SysTemp1,DRAWLINE
	inc	SysTemp1
	sts	DRAWLINE,SysTemp1
	lds	SysTemp1,DRAWLINE_H
	brne	PC + 2
	inc	SysTemp1
	sts	DRAWLINE_H,SysTemp1
;PSet DrawLine, LineY1, LineColour
	lds	SysValueCopy,DRAWLINE
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;PSet DrawLine, LineY2, LineColour
	lds	SysValueCopy,DRAWLINE
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEY2
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;Next
	lds	SysWORDTempA,DRAWLINE
	lds	SysWORDTempA_H,DRAWLINE_H
	lds	SysWORDTempB,LINEX2
	lds	SysWORDTempB_H,LINEX2_H
	call	SYSCOMPLESSTHAN16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop7
SysForLoopEnd7:
;Draw lines going down
;For DrawLine = LineY1 To LineY2
;Legacy method
	lds	SysTemp1,LINEY1
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	DRAWLINE,SysTemp1
	lds	SysTemp1,LINEY1_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	DRAWLINE_H,SysTemp1
	lds	SysWORDTempB,LINEY1
	lds	SysWORDTempB_H,LINEY1_H
	lds	SysWORDTempA,LINEY2
	lds	SysWORDTempA_H,LINEY2_H
	call	SYSCOMPLESSTHAN16
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd8
SysForLoop8:
	lds	SysTemp1,DRAWLINE
	inc	SysTemp1
	sts	DRAWLINE,SysTemp1
	lds	SysTemp1,DRAWLINE_H
	brne	PC + 2
	inc	SysTemp1
	sts	DRAWLINE_H,SysTemp1
;PSet LineX1, DrawLine, LineColour
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,DRAWLINE
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;PSet LineX2, DrawLine, LineColour
	lds	SysValueCopy,LINEX2
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,DRAWLINE
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;Next
	lds	SysWORDTempA,DRAWLINE
	lds	SysWORDTempA_H,DRAWLINE_H
	lds	SysWORDTempB,LINEY2
	lds	SysWORDTempB_H,LINEY2_H
	call	SYSCOMPLESSTHAN16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop8
SysForLoopEnd8:
	ret

;********************************************************************************

;Overloaded signature: WORD:WORD:INTEGER:word:byte:, Source: glcd.h (1876)
CIRCLE19:
;dim  radiusErr, xradius as Integer
;xradius = Inxradius
	lds	SysValueCopy,INXRADIUS
	sts	XRADIUS,SysValueCopy
	lds	SysValueCopy,INXRADIUS_H
	sts	XRADIUS_H,SysValueCopy
;radiusErr = -(xradius/2)
	lds	SysINTEGERTempA,XRADIUS
	lds	SysINTEGERTempA_H,XRADIUS_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	call	SYSDIVSUBINT
	mov	SysTemp1,SysINTEGERTempA
	mov	SysTemp1_H,SysINTEGERTempA_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	sts	RADIUSERR,SysTemp1
	sts	RADIUSERR_H,SysTemp1_H
;Do While xradius >=  yordinate
SysDoLoop_S3:
	lds	SysINTEGERTempA,xradius
	lds	SysINTEGERTempA_H,xradius_H
	lds	SysINTEGERTempB,yordinate
	ldi	SysINTEGERTempB_H,0
	call	SYSCOMPLESSTHANINT
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E3
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,XRADIUS
	add	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,YORDINATE
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,YORDINATE
	add	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,XRADIUS
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,XRADIUS
	sub	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,YORDINATE
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,YORDINATE
	sub	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,XRADIUS
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,XRADIUS
	sub	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,YORDINATE
	sub	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,YORDINATE
	sub	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,XRADIUS
	sub	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,XRADIUS
	add	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,YORDINATE
	sub	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,YORDINATE
	add	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,XRADIUS
	sub	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_SSD1309
;yordinate ++
	lds	SysTemp1,YORDINATE
	inc	SysTemp1
	sts	YORDINATE,SysTemp1
;If radiusErr < 0 Then
	lds	SysINTEGERTempA,RADIUSERR
	lds	SysINTEGERTempA_H,RADIUSERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	call	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE21_1
;radiusErr = radiusErr + 2 * yordinate + 1
	lds	SysTemp2,YORDINATE
	lsl	SysTemp2
	lds	SysTemp3,RADIUSERR
	add	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	lds	SysTemp2,RADIUSERR_H
	ldi	SysTemp3,0
	adc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	ldi	SysTemp3,1
	add	SysTemp1,SysTemp3
	sts	RADIUSERR,SysTemp1
	ldi	SysTemp3,0
	adc	SysTemp1_H,SysTemp3
	sts	RADIUSERR_H,SysTemp1_H
;else
	rjmp	ENDIF21
ELSE21_1:
;xradius --
	lds	SysTemp1,XRADIUS
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	XRADIUS,SysTemp1
	lds	SysTemp1,XRADIUS_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	XRADIUS_H,SysTemp1
;radiusErr = radiusErr + 2 * (yordinate - xradius + 1)
	lds	SysTemp2,YORDINATE
	lds	SysTemp3,XRADIUS
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	ldi	SysTemp3,0
	lds	SysTemp2,XRADIUS_H
	sbc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp3,1
	add	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	ldi	SysTemp3,0
	adc	SysTemp1_H,SysTemp3
	mov	SysTemp2_H,SysTemp1_H
	mov	SysINTEGERTempA,SysTemp2
	mov	SysINTEGERTempA_H,SysTemp2_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	call	SYSMULTSUBINT
	lds	SysTemp1,RADIUSERR
	add	SysTemp1,SysINTEGERTempX
	sts	RADIUSERR,SysTemp1
	lds	SysTemp1,RADIUSERR_H
	adc	SysTemp1,SysINTEGERTempX_H
	sts	RADIUSERR_H,SysTemp1
;end if
ENDIF21:
;Loop
	rjmp	SysDoLoop_S3
SysDoLoop_E3:
	ret

;********************************************************************************

;Source: GLCD_SSD1309.H (1095)
CURSOR_POSITION_SSD1309:
;dim  PosCharX, PosCharX as Word
;PosCharY = LocY / 8
;faster than /8
;PosCharY = LocY
	lds	SysValueCopy,LOCY
	sts	POSCHARY,SysValueCopy
;Repeat 3
	ldi	SysValueCopy,3
	sts	SysRepeatTemp4,SysValueCopy
SysRepeatLoop4:
;Set C Off
	clc
;Rotate PosCharY Right
	lds	SysValueCopy,POSCHARY
	ror	SysValueCopy
	sts	POSCHARY,SysValueCopy
;End Repeat
	lds	SysTemp1,SysRepeatTemp4
	dec	SysTemp1
	sts	SysRepeatTemp4,SysTemp1
	brne	SysRepeatLoop4
SysRepeatLoopEnd4:
;Write_Command_SSD1309( 0xB0 + PosCharY )   ' set page address
	lds	SysTemp1,POSCHARY
	ldi	SysTemp3,176
	add	SysTemp1,SysTemp3
	sts	SSD1309SENDBYTE,SysTemp1
	call	WRITE_COMMAND_SSD1309
;PosCharX = ( LocX  & 0x0f )  ' lower nibble
	ldi	SysTemp3,15
	lds	SysTemp1,LOCX
	and	SysTemp1,SysTemp3
	sts	POSCHARX,SysTemp1
	ldi	SysValueCopy,0
	sts	POSCHARX_H,SysValueCopy
;Write_Command_SSD1309( PosCharX )
	lds	SysValueCopy,POSCHARX
	sts	SSD1309SENDBYTE,SysValueCopy
	call	WRITE_COMMAND_SSD1309
;PosCharX = LocX
	lds	SysValueCopy,LOCX
	sts	POSCHARX,SysValueCopy
	ldi	SysValueCopy,0
	sts	POSCHARX_H,SysValueCopy
;Repeat 4
	ldi	SysValueCopy,4
	sts	SysRepeatTemp4,SysValueCopy
SysRepeatLoop5:
;Set C off
	clc
;Rotate PosCharX Right
	lds	SysValueCopy,POSCHARX_H
	ror	SysValueCopy
	sts	POSCHARX_H,SysValueCopy
	lds	SysValueCopy,POSCHARX
	ror	SysValueCopy
	sts	POSCHARX,SysValueCopy
;End Repeat
	lds	SysTemp1,SysRepeatTemp4
	dec	SysTemp1
	sts	SysRepeatTemp4,SysTemp1
	brne	SysRepeatLoop5
SysRepeatLoopEnd5:
;PosCharX = ( PosCharX & 0x0F ) + 0x10
	ldi	SysTemp3,15
	lds	SysTemp2,POSCHARX
	and	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	ldi	SysValueCopy,0
	mov	SysTemp1_H,SysValueCopy
	ldi	SysTemp3,16
	add	SysTemp1,SysTemp3
	sts	POSCHARX,SysTemp1
	ldi	SysTemp3,0
	adc	SysTemp1_H,SysTemp3
	sts	POSCHARX_H,SysTemp1_H
;Write_Command_SSD1309 ( PosCharX )
	lds	SysValueCopy,POSCHARX
	sts	SSD1309SENDBYTE,SysValueCopy
	jmp	WRITE_COMMAND_SSD1309

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

;Source: GLCD_SSD1309.H (901)
FILLEDBOX_SSD1309:
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	lds	SysCalcTempA,LINEX2
	lds	SysCalcTempB,LINEX1
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF77
;GLCDTemp = LineX1
	lds	SysValueCopy,LINEX1
	sts	GLCDTEMP,SysValueCopy
;LineX1 = LineX2
	lds	SysValueCopy,LINEX2
	sts	LINEX1,SysValueCopy
;LineX2 = GLCDTemp
	lds	SysValueCopy,GLCDTEMP
	sts	LINEX2,SysValueCopy
;End If
ENDIF77:
;If LineY1 > LineY2 Then
	lds	SysCalcTempA,LINEY2
	lds	SysCalcTempB,LINEY1
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF78
;GLCDTemp = LineY1
	lds	SysValueCopy,LINEY1
	sts	GLCDTEMP,SysValueCopy
;LineY1 = LineY2
	lds	SysValueCopy,LINEY2
	sts	LINEY1,SysValueCopy
;LineY2 = GLCDTemp
	lds	SysValueCopy,GLCDTEMP
	sts	LINEY2,SysValueCopy
;End If
ENDIF78:
;Draw lines going across
;For DrawLine = LineX1 To LineX2
;Legacy method
	lds	SysTemp1,LINEX1
	dec	SysTemp1
	sts	DRAWLINE,SysTemp1
	lds	SysCalcTempA,LINEX2
	lds	SysCalcTempB,LINEX1
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoopEnd20
SysForLoop20:
	lds	SysTemp1,DRAWLINE
	inc	SysTemp1
	sts	DRAWLINE,SysTemp1
;For GLCDTemp = LineY1 To LineY2
;Legacy method
	lds	SysTemp1,LINEY1
	dec	SysTemp1
	sts	GLCDTEMP,SysTemp1
	lds	SysCalcTempA,LINEY2
	lds	SysCalcTempB,LINEY1
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoopEnd21
SysForLoop21:
	lds	SysTemp1,GLCDTEMP
	inc	SysTemp1
	sts	GLCDTEMP,SysTemp1
;PSet DrawLine, GLCDTemp, LineColour
	lds	SysValueCopy,DRAWLINE
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,GLCDTEMP
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_SSD1309
;Next
	lds	SysCalcTempA,GLCDTEMP
	lds	SysCalcTempB,LINEY2
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop21
SysForLoopEnd21:
;Next
	lds	SysCalcTempA,DRAWLINE
	lds	SysCalcTempB,LINEX2
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop20
SysForLoopEnd20:
	ret

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:long:, Source: glcd.h (1974)
FILLEDCIRCLE22:
;Circle fill Code is merely a modification of the midpoint
;circle algorithem which is an adaption of Bresenham's line algorithm
;http://en.wikipedia.org/wiki/Midpoint_circle_algorithm
;http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
;dim ff, ddF_x, ddF_y as integer
;dim YCalc2, YCalc1 as word
;ff = 1 - xradius
	ldi	SysTemp3,1
	lds	SysTemp1,XRADIUS
	sub	SysTemp3,SysTemp1
	sts	FF,SysTemp3
	ldi	SysTemp3,0
	lds	SysTemp1,XRADIUS_H
	sbc	SysTemp3,SysTemp1
	sts	FF_H,SysTemp3
;ddF_x = 1
	ldi	SysValueCopy,1
	sts	DDF_X,SysValueCopy
	ldi	SysValueCopy,0
	sts	DDF_X_H,SysValueCopy
;ddF_y = -2 * xradius
	lds	SysINTEGERTempA,XRADIUS
	lds	SysINTEGERTempA_H,XRADIUS_H
	ldi	SysINTEGERTempB,254
	ldi	SysINTEGERTempB_H,255
	call	SYSMULTSUBINT
	sts	DDF_Y,SysINTEGERTempX
	sts	DDF_Y_H,SysINTEGERTempX_H
;FillCircleXX = 0
	ldi	SysValueCopy,0
	sts	FILLCIRCLEXX,SysValueCopy
;FillCircleYY = xradius
	lds	SysValueCopy,XRADIUS
	sts	FILLCIRCLEYY,SysValueCopy
;Fill in the center between the two halves
;YCalc2 = yoffset+xradius
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,XRADIUS
	add	SysTemp1,SysTemp2
	sts	YCALC2,SysTemp1
	lds	SysTemp1,YOFFSET_H
	lds	SysTemp2,XRADIUS_H
	adc	SysTemp1,SysTemp2
	sts	YCALC2_H,SysTemp1
;YCalc1 = yoffset-xradius
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,XRADIUS
	sub	SysTemp1,SysTemp2
	sts	YCALC1,SysTemp1
	lds	SysTemp1,YOFFSET_H
	lds	SysTemp2,XRADIUS_H
	sbc	SysTemp1,SysTemp2
	sts	YCALC1_H,SysTemp1
;Line( xoffset, YCalc1 , xoffset, YCalc2, LineColour)
	lds	SysValueCopy,XOFFSET
	sts	LINEX1,SysValueCopy
	lds	SysValueCopy,XOFFSET_H
	sts	LINEX1_H,SysValueCopy
	lds	SysValueCopy,YCALC1
	sts	LINEY1,SysValueCopy
	lds	SysValueCopy,YCALC1_H
	sts	LINEY1_H,SysValueCopy
	lds	SysValueCopy,XOFFSET
	sts	LINEX2,SysValueCopy
	lds	SysValueCopy,XOFFSET_H
	sts	LINEX2_H,SysValueCopy
	lds	SysValueCopy,YCALC2
	sts	LINEY2,SysValueCopy
	lds	SysValueCopy,YCALC2_H
	sts	LINEY2_H,SysValueCopy
	call	_LINE71
;do while (FillCircleXX < FillCircleYY)
SysDoLoop_S4:
	lds	SysCalcTempA,FILLCIRCLEXX
	lds	SysCalcTempB,FILLCIRCLEYY
	cp	SysCalcTempA,SysCalcTempB
	brlo	PC + 2
	rjmp	SysDoLoop_E4
;if ff >= 0 then
	lds	SysINTEGERTempA,FF
	lds	SysINTEGERTempA_H,FF_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	call	SYSCOMPLESSTHANINT
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF22
;FillCircleYY--
	lds	SysTemp1,FILLCIRCLEYY
	dec	SysTemp1
	sts	FILLCIRCLEYY,SysTemp1
;ddF_y += 2
	lds	SysTemp1,DDF_Y
	ldi	SysTemp3,2
	add	SysTemp1,SysTemp3
	sts	DDF_Y,SysTemp1
	lds	SysTemp1,DDF_Y_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	DDF_Y_H,SysTemp1
;ff += ddF_y
	lds	SysTemp1,FF
	lds	SysTemp2,DDF_Y
	add	SysTemp1,SysTemp2
	sts	FF,SysTemp1
	lds	SysTemp1,FF_H
	lds	SysTemp2,DDF_Y_H
	adc	SysTemp1,SysTemp2
	sts	FF_H,SysTemp1
;end if
ENDIF22:
;FillCircleXX++
	lds	SysTemp1,FILLCIRCLEXX
	inc	SysTemp1
	sts	FILLCIRCLEXX,SysTemp1
;ddF_x += 2
	lds	SysTemp1,DDF_X
	ldi	SysTemp3,2
	add	SysTemp1,SysTemp3
	sts	DDF_X,SysTemp1
	lds	SysTemp1,DDF_X_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	DDF_X_H,SysTemp1
;ff += ddF_x
	lds	SysTemp1,FF
	lds	SysTemp2,DDF_X
	add	SysTemp1,SysTemp2
	sts	FF,SysTemp1
	lds	SysTemp1,FF_H
	lds	SysTemp2,DDF_X_H
	adc	SysTemp1,SysTemp2
	sts	FF_H,SysTemp1
;Now draw vertical lines between the points on the circle rather than
;draw the points of the circle. This draws lines between the
;perimeter points on the upper and lower quadrants of the 2 halves of the circle.
;Line(xoffset+FillCircleXX, yoffset+FillCircleYY, xoffset+FillCircleXX, yoffset-FillCircleYY, LineColour);
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,FILLCIRCLEXX
	add	SysTemp1,SysTemp2
	sts	LINEX1,SysTemp1
	lds	SysTemp1,XOFFSET_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	LINEX1_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,FILLCIRCLEYY
	add	SysTemp1,SysTemp2
	sts	LINEY1,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	LINEY1_H,SysTemp1
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,FILLCIRCLEXX
	add	SysTemp1,SysTemp2
	sts	LINEX2,SysTemp1
	lds	SysTemp1,XOFFSET_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	LINEX2_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,FILLCIRCLEYY
	sub	SysTemp1,SysTemp2
	sts	LINEY2,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	LINEY2_H,SysTemp1
	call	_LINE71
;Line(xoffset-FillCircleXX, yoffset+FillCircleYY, xoffset-FillCircleXX, yoffset-FillCircleYY, LineColour);
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,FILLCIRCLEXX
	sub	SysTemp1,SysTemp2
	sts	LINEX1,SysTemp1
	lds	SysTemp1,XOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	LINEX1_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,FILLCIRCLEYY
	add	SysTemp1,SysTemp2
	sts	LINEY1,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	LINEY1_H,SysTemp1
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,FILLCIRCLEXX
	sub	SysTemp1,SysTemp2
	sts	LINEX2,SysTemp1
	lds	SysTemp1,XOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	LINEX2_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,FILLCIRCLEYY
	sub	SysTemp1,SysTemp2
	sts	LINEY2,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	LINEY2_H,SysTemp1
	call	_LINE71
;Line(xoffset+FillCircleYY, yoffset+FillCircleXX, FillCircleYY+xoffset, yoffset-FillCircleXX, LineColour);
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,FILLCIRCLEYY
	add	SysTemp1,SysTemp2
	sts	LINEX1,SysTemp1
	lds	SysTemp1,XOFFSET_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	LINEX1_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,FILLCIRCLEXX
	add	SysTemp1,SysTemp2
	sts	LINEY1,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	LINEY1_H,SysTemp1
	lds	SysTemp1,FILLCIRCLEYY
	lds	SysTemp2,XOFFSET
	add	SysTemp1,SysTemp2
	sts	LINEX2,SysTemp1
	ldi	SysTemp3,0
	lds	SysTemp1,XOFFSET_H
	adc	SysTemp3,SysTemp1
	sts	LINEX2_H,SysTemp3
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,FILLCIRCLEXX
	sub	SysTemp1,SysTemp2
	sts	LINEY2,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	LINEY2_H,SysTemp1
	call	_LINE71
;Line(xoffset-FillCircleYY, yoffset+FillCircleXX, xoffset-FillCircleYY, yoffset-FillCircleXX, LineColour);
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,FILLCIRCLEYY
	sub	SysTemp1,SysTemp2
	sts	LINEX1,SysTemp1
	lds	SysTemp1,XOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	LINEX1_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,FILLCIRCLEXX
	add	SysTemp1,SysTemp2
	sts	LINEY1,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	LINEY1_H,SysTemp1
	lds	SysTemp1,XOFFSET
	lds	SysTemp2,FILLCIRCLEYY
	sub	SysTemp1,SysTemp2
	sts	LINEX2,SysTemp1
	lds	SysTemp1,XOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	LINEX2_H,SysTemp1
	lds	SysTemp1,YOFFSET
	lds	SysTemp2,FILLCIRCLEXX
	sub	SysTemp1,SysTemp2
	sts	LINEY2,SysTemp1
	lds	SysTemp1,YOFFSET_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	LINEY2_H,SysTemp1
	call	_LINE71
;loop
	rjmp	SysDoLoop_S4
SysDoLoop_E4:
	ret

;********************************************************************************

GLCDCHARCOL3:
	cpi	SysStringA, 113
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TABLEGLCDCHARCOL3<<1)
	ldi	SysReadA_H, high(TABLEGLCDCHARCOL3<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TABLEGLCDCHARCOL3:
	.DB	112,0,16,12,10,136,34,56,32,8,32,16,16,128,128,64,4,0,0,0,40,72,70,108,0,0,0,40
	.DB	16,0,16,0,64,124,0,132,130,48,78,120,6,108,12,0,0,16,40,0,4,100,248,254,124,254
	.DB	254,254,124,254,0,64,254,254,254,254,124,254,124,254,76,2,126,62,126,198,14,194
	.DB	0,4,0,8,128,0,64,254,112,112,112,16,16,254,0,64,254,0,248,248,112,248,16,248
	.DB	144,16,120,56,120,136,24,136,0,0,0,32,120

;********************************************************************************

GLCDCHARCOL4:
	cpi	SysStringA, 113
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TABLEGLCDCHARCOL4<<1)
	ldi	SysReadA_H, high(TABLEGLCDCHARCOL4<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TABLEGLCDCHARCOL4:
	.DB	112,254,56,10,6,204,102,124,112,4,64,16,56,136,162,112,28,0,0,14,254,84,38,146
	.DB	10,56,130,16,16,160,16,192,32,162,132,194,130,40,138,148,2,146,146,108,172,40
	.DB	40,130,2,146,36,146,130,130,146,18,130,16,130,128,16,128,4,8,130,18,130,18,146,2
	.DB	128,64,128,40,16,162,254,8,130,4,128,2,168,144,136,136,168,252,168,16,144,128
	.DB	32,130,8,16,136,40,40,16,168,124,128,64,128,80,160,200,16,0,130,16,68

;********************************************************************************

GLCDCHARCOL5:
	cpi	SysStringA, 113
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TABLEGLCDCHARCOL5<<1)
	ldi	SysReadA_H, high(TABLEGLCDCHARCOL5<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TABLEGLCDCHARCOL5:
	.DB	112,124,124,0,0,238,238,124,168,254,254,84,84,148,148,124,124,0,158,0,40,254,16,170
	.DB	6,68,68,124,124,96,16,192,16,146,254,162,138,36,138,146,226,146,146,108,108,68
	.DB	40,68,162,242,34,146,130,130,146,18,146,16,254,130,40,128,24,16,130,18,162,50
	.DB	146,254,128,128,112,16,224,146,130,16,130,2,128,4,168,136,136,136,168,18,168,8
	.DB	250,136,80,254,240,8,136,40,40,8,168,144,128,128,96,32,160,168,108,254,108,16
	.DB	66

;********************************************************************************

GLCDCHARCOL6:
	cpi	SysStringA, 113
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TABLEGLCDCHARCOL6<<1)
	ldi	SysReadA_H, high(TABLEGLCDCHARCOL6<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TABLEGLCDCHARCOL6:
	.DB	112,56,254,12,10,204,102,124,32,4,64,56,16,162,136,112,28,0,0,14,254,84,200,68
	.DB	0,130,56,16,16,0,16,0,8,138,128,146,150,254,138,146,18,146,82,0,0,130,40,40,18,130
	.DB	36,146,130,68,146,18,146,16,130,126,68,128,4,32,130,18,66,82,146,2,128,64,128,40
	.DB	16,138,130,32,254,4,128,8,168,136,136,144,168,2,168,8,128,122,136,128,8,8,136,40
	.DB	48,8,168,128,64,64,128,80,160,152,130,0,16,32,68

;********************************************************************************

GLCDCHARCOL7:
	cpi	SysStringA, 113
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TABLEGLCDCHARCOL7<<1)
	ldi	SysReadA_H, high(TABLEGLCDCHARCOL7<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TABLEGLCDCHARCOL7:
	.DB	112,16,0,10,6,136,34,56,62,8,32,16,16,128,128,64,4,0,0,0,40,36,196,160,0,0,0,40
	.DB	16,0,16,0,4,124,0,140,98,32,114,96,14,108,60,0,0,0,40,16,12,124,248,108,68,56
	.DB	130,2,244,254,0,2,130,128,254,254,124,12,188,140,100,2,126,62,126,198,14,134,0,64
	.DB	0,8,128,0,240,112,64,254,48,4,120,240,0,0,0,0,240,240,112,16,248,16,64,64,248,56
	.DB	120,136,120,136,0,0,0,16,120

;********************************************************************************

;Source: GLCD_SSD1309.H (474)
GLCDCLS_SSD1309:
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	ldi	SysValueCopy,0
	sts	GLCD_YORDINATE,SysValueCopy
	sts	GLCD_YORDINATE_H,SysValueCopy
;For SSD1309_BufferLocationCalc = 1 to GLCD_HEIGHT * GLCD_WIDTH / 8
;Legacy method
	ldi	SysValueCopy,0
	sts	SSD1309_BUFFERLOCATIONCALC,SysValueCopy
	sts	SSD1309_BUFFERLOCATIONCALC_H,SysValueCopy
SysForLoop13:
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC
	inc	SysTemp1
	sts	SSD1309_BUFFERLOCATIONCALC,SysTemp1
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC_H
	brne	PC + 2
	inc	SysTemp1
	sts	SSD1309_BUFFERLOCATIONCALC_H,SysTemp1
;SSD1309_BufferAlias(SSD1309_BufferLocationCalc) = 0
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC
	ldi	SysTemp3,low(SSD1309_BUFFERALIAS)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC_H
	ldi	SysTemp3,high(SSD1309_BUFFERALIAS)
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	ldi	SysValueCopy,0
	st	X,SysValueCopy
;Next
	lds	SysWORDTempA,SSD1309_BUFFERLOCATIONCALC
	lds	SysWORDTempA_H,SSD1309_BUFFERLOCATIONCALC_H
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,4
	rcall	SYSCOMPLESSTHAN16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop13
SysForLoopEnd13:
;1.14 changed to transaction
;For SSD1309_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	ldi	SysValueCopy,0
	sts	SSD1309_BUFFERLOCATIONCALC,SysValueCopy
	sts	SSD1309_BUFFERLOCATIONCALC_H,SysValueCopy
SysForLoop14:
;Init SysForLoopStep13 :#0
	ldi	SysValueCopy,8
	sts	SysForLoopStep13,SysValueCopy
	ldi	SysValueCopy,0
	sts	SysForLoopStep13_H,SysValueCopy
;Cursor_Position_SSD1309 ( 0 , SSD1309_BufferLocationCalc )
	ldi	SysValueCopy,0
	sts	LOCX,SysValueCopy
	lds	SysValueCopy,SSD1309_BUFFERLOCATIONCALC
	sts	LOCY,SysValueCopy
	rcall	CURSOR_POSITION_SSD1309
;Open_Transaction_SSD1309
;Macro Source: GLCD_SSD1309.H (1282)
;4wire not supported, see Write_Transaction_Data_SSD1309
;I2CStart
	rcall	I2CSTART
;I2CSend GLCD_I2C_Address
	ldi	SysValueCopy,120
	sts	I2CBYTE,SysValueCopy
	rcall	I2CSEND
;I2CSend 0x40
	ldi	SysValueCopy,64
	sts	I2CBYTE,SysValueCopy
	rcall	I2CSEND
;For GLCDTemp = 0 to 127
;Legacy method
	ldi	SysValueCopy,255
	sts	GLCDTEMP,SysValueCopy
SysForLoop15:
	lds	SysTemp1,GLCDTEMP
	inc	SysTemp1
	sts	GLCDTEMP,SysTemp1
;Write_Transaction_Data_SSD1309(GLCDBackground)
;Macro Source: GLCD_SSD1309.H (1313)
;I2CSend SSD1309SendByte
	lds	SysValueCopy,GLCDBACKGROUND
	sts	I2CBYTE,SysValueCopy
	rcall	I2CSEND
;Next
	lds	SysCalcTempA,GLCDTEMP
	cpi	SysCalcTempA,127
	brlo	SysForLoop15
SysForLoopEnd15:
;Close_Transaction_SSD1309
;Macro Source: GLCD_SSD1309.H (1346)
;4wire not supported, see Write_Transaction_Data_SSD1309
;I2CStop
	rcall	I2CSTOP
;Next
;Integer negative Step Handler in For-next statement
	lds	SysBitTest,SYSFORLOOPSTEP13_H
	sbrs	SysBitTest,7
	rjmp	ELSE65_1
;Set SysForLoopABsValue to -StepValue :#1 
	lds	SysTemp2,SYSFORLOOPSTEP13
	lds	SysTemp2_H,SYSFORLOOPSTEP13_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	sts	SysForLoopABsValue14,SysTemp2
	sts	SysForLoopABsValue14_H,SysTemp2_H
;IF ( SSD1309_BUFFERLOCATIONCALC - 64-1) } [WORD]SysForLoopABsValue14 THEN  :#1n 
	lds	SysTemp2,SSD1309_BUFFERLOCATIONCALC
	ldi	SysTemp3,64
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,SSD1309_BUFFERLOCATIONCALC_H
	ldi	SysTemp3,0
	sbc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	ldi	SysTemp3,0
	sbc	SysTemp1_H,SysTemp3
	mov	SysTemp2_H,SysTemp1_H
	mov	SysWORDTempA,SysTemp2
	mov	SysWORDTempA_H,SysTemp2_H
	lds	SysWORDTempB,SYSFORLOOPABSVALUE14
	lds	SysWORDTempB_H,SYSFORLOOPABSVALUE14_H
	rcall	SYSCOMPLESSTHAN16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF66
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC
	lds	SysTemp2,SysForLoopStep13
	add	SysTemp1,SysTemp2
	sts	SSD1309_BUFFERLOCATIONCALC,SysTemp1
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC_H
	lds	SysTemp2,SysForLoopStep13_H
	adc	SysTemp1,SysTemp2
	sts	SSD1309_BUFFERLOCATIONCALC_H,SysTemp1
	rjmp	SysForLoop14
;END IF
ENDIF66:
	rjmp	ENDIF65
ELSE65_1:
;Integer positive Step Handler in For-next statement
;IF ([WORD]64-1 - [WORD]SSD1309_BUFFERLOCATIONCALC) } [WORD]SysForLoopStep13 THEN :#1p 
	ldi	SysTemp3,63
	lds	SysTemp2,SSD1309_BUFFERLOCATIONCALC
	sub	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	ldi	SysTemp3,0
	lds	SysTemp2,SSD1309_BUFFERLOCATIONCALC_H
	sbc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	lds	SysWORDTempB,SYSFORLOOPSTEP13
	lds	SysWORDTempB_H,SYSFORLOOPSTEP13_H
	rcall	SYSCOMPLESSTHAN16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF67
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC
	lds	SysTemp2,SysForLoopStep13
	add	SysTemp1,SysTemp2
	sts	SSD1309_BUFFERLOCATIONCALC,SysTemp1
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC_H
	lds	SysTemp2,SysForLoopStep13_H
	adc	SysTemp1,SysTemp2
	sts	SSD1309_BUFFERLOCATIONCALC_H,SysTemp1
	rjmp	SysForLoop14
;END IF
ENDIF67:
;END IF
ENDIF65:
SysForLoopEnd14:
;Removed at 1.14. Retained for documentation only
;Cursor_Position_SSD1309 ( 0 , 0 )
;for SSD1309_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
;for GLCDTemp = 0 to 127
;Write_Data_SSD1309(GLCDBackground)
;Next
;next
;Cursor_Position_SSD1309 ( 0 , 0 )
	ldi	SysValueCopy,0
	sts	LOCX,SysValueCopy
	ldi	SysValueCopy,0
	sts	LOCY,SysValueCopy
	rcall	CURSOR_POSITION_SSD1309
;PrintLocX =0
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
;PrintLocY =0
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	ret

;********************************************************************************

;Source: GLCD_SSD1309.H (522)
GLCDDRAWCHAR_SSD1309:
;This is now in four parts
;1. Handler for GLCD LM mode
;2. Preamble
;3. GCB Font set handler
;4. OLED Font set handler
;***** Handler for GLCD LM mode
;****** Preamble
;invert colors if required
;if LineColour <> GLCDForeground  then
	lds	SysWORDTempA,LINECOLOUR
	lds	SysWORDTempA_H,LINECOLOUR_H
	lds	SysWORDTempB,GLCDFOREGROUND
	lds	SysWORDTempB_H,GLCDFOREGROUND_H
	rcall	SYSCOMPEQUAL16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF68
;Inverted Colours
;GLCDBackground = 1
	ldi	SysValueCopy,1
	sts	GLCDBACKGROUND,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND_H,SysValueCopy
;GLCDForeground = 0
	ldi	SysValueCopy,0
	sts	GLCDFOREGROUND,SysValueCopy
	sts	GLCDFOREGROUND_H,SysValueCopy
;end if
ENDIF68:
;dim CharCol, CharRow as word
;CharCode -= 15
	lds	SysTemp1,CHARCODE
	ldi	SysTemp3,15
	sub	SysTemp1,SysTemp3
	sts	CHARCODE,SysTemp1
;CharCol=0
	ldi	SysValueCopy,0
	sts	CHARCOL,SysValueCopy
	sts	CHARCOL_H,SysValueCopy
;Cursor_Position_SSD1309 ( CharLocX , CharLocY )
	lds	SysValueCopy,CHARLOCX
	sts	LOCX,SysValueCopy
	lds	SysValueCopy,CHARLOCY
	sts	LOCY,SysValueCopy
	rcall	CURSOR_POSITION_SSD1309
;1.14 Added transaction
;****** GCB Font set handler
;if CharCode>=178 and CharCode<=202 then
	lds	SysBYTETempA,CHARCODE
	ldi	SysBYTETempB,178
	rcall	SYSCOMPLESSTHAN
	com	SysByteTempX
	mov	SysTemp1,SysByteTempX
	lds	SysBYTETempB,CHARCODE
	ldi	SysBYTETempA,202
	rcall	SYSCOMPLESSTHAN
	com	SysByteTempX
	mov	SysTemp3,SysByteTempX
	and	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	sbrs	SysTemp2,0
	rjmp	ENDIF69
;CharLocY=CharLocY-1
	lds	SysTemp1,CHARLOCY
	ldi	SysTemp3,1
	sub	SysTemp1,SysTemp3
	sts	CHARLOCY,SysTemp1
	lds	SysTemp1,CHARLOCY_H
	ldi	SysTemp3,0
	sbc	SysTemp1,SysTemp3
	sts	CHARLOCY_H,SysTemp1
;end if
ENDIF69:
;For CurrCharCol = 1 to 5
;Legacy method
	ldi	SysValueCopy,0
	sts	CURRCHARCOL,SysValueCopy
SysForLoop16:
	lds	SysTemp1,CURRCHARCOL
	inc	SysTemp1
	sts	CURRCHARCOL,SysTemp1
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect1Case1:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,1
	brne	SysSelect1Case2
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL3
	sts	CURRCHARVAL,SysByteTempX
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	rjmp	SysSelectEnd1
SysSelect1Case2:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,2
	brne	SysSelect1Case3
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL4
	sts	CURRCHARVAL,SysByteTempX
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	rjmp	SysSelectEnd1
SysSelect1Case3:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,3
	brne	SysSelect1Case4
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL5
	sts	CURRCHARVAL,SysByteTempX
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	rjmp	SysSelectEnd1
SysSelect1Case4:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,4
	brne	SysSelect1Case5
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL6
	sts	CURRCHARVAL,SysByteTempX
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	rjmp	SysSelectEnd1
SysSelect1Case5:
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,5
	brne	SysSelectEnd1
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	lds	SYSSTRINGA,CHARCODE
	rcall	GLCDCHARCOL7
	sts	CURRCHARVAL,SysByteTempX
;End Select
SysSelectEnd1:
;Full Memory GLCD mode
;CharRow=0
	ldi	SysValueCopy,0
	sts	CHARROW,SysValueCopy
	sts	CHARROW_H,SysValueCopy
;For CurrCharRow = 1 to 8
;Legacy method
	ldi	SysValueCopy,0
	sts	CURRCHARROW,SysValueCopy
SysForLoop17:
	lds	SysTemp1,CURRCHARROW
	inc	SysTemp1
	sts	CURRCHARROW,SysTemp1
;CharColS=0
	ldi	SysValueCopy,0
	sts	CHARCOLS,SysValueCopy
;For Col=1 to GLCDfntDefaultsize
;Legacy method
	ldi	SysValueCopy,0
	sts	COL,SysValueCopy
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,1
	brsh	ENDIF70
	rjmp	SysForLoopEnd18
ENDIF70:
SysForLoop18:
	lds	SysTemp1,COL
	inc	SysTemp1
	sts	COL,SysTemp1
;CharRowS=0
	ldi	SysValueCopy,0
	sts	CHARROWS,SysValueCopy
;For Row=1 to GLCDfntDefaultsize
;Legacy method
	ldi	SysValueCopy,0
	sts	ROW,SysValueCopy
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,1
	brsh	ENDIF71
	rjmp	SysForLoopEnd19
ENDIF71:
SysForLoop19:
	lds	SysTemp1,ROW
	inc	SysTemp1
	sts	ROW,SysTemp1
;if CurrCharVal.0=1 then
	lds	SysBitTest,CURRCHARVAL
	sbrs	SysBitTest,0
	rjmp	ELSE72_1
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, LineColour
	lds	SysTemp2,CHARLOCX
	lds	SysTemp3,CHARCOL
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,CHARCOLS
	add	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp2,CHARLOCY
	lds	SysTemp3,CHARROW
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,CHARROWS
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_SSD1309
;Else
	rjmp	ENDIF72
ELSE72_1:
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, GLCDBackground
	lds	SysTemp2,CHARLOCX
	lds	SysTemp3,CHARCOL
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,CHARCOLS
	add	SysTemp1,SysTemp2
	sts	GLCDX,SysTemp1
	lds	SysTemp2,CHARLOCY
	lds	SysTemp3,CHARROW
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,CHARROWS
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,GLCDBACKGROUND
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_SSD1309
;End if
ENDIF72:
;Put out a white intercharacter pixel/space
;PSet [word]CharLocX + ( GLCDFontWidth * GLCDfntDefaultsize) , [word]CharLocY + CharRow + CharRowS , GLCDBackground
	lds	SysBYTETempA,GLCDFONTWIDTH
	lds	SysBYTETempB,GLCDFNTDEFAULTSIZE
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp1,SysByteTempX
	lds	SysTemp2,CHARLOCX
	add	SysTemp2,SysTemp1
	sts	GLCDX,SysTemp2
	lds	SysTemp2,CHARLOCY
	lds	SysTemp3,CHARROW
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,CHARROWS
	add	SysTemp1,SysTemp2
	sts	GLCDY,SysTemp1
	lds	SysValueCopy,GLCDBACKGROUND
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_SSD1309
;CharRowS +=1
	lds	SysTemp1,CHARROWS
	inc	SysTemp1
	sts	CHARROWS,SysTemp1
;Next Row
	lds	SysCalcTempA,ROW
	lds	SysCalcTempB,GLCDFNTDEFAULTSIZE
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF73
	rjmp	SysForLoop19
ENDIF73:
SysForLoopEnd19:
;CharColS +=1
	lds	SysTemp1,CHARCOLS
	inc	SysTemp1
	sts	CHARCOLS,SysTemp1
;Next Col
	lds	SysCalcTempA,COL
	lds	SysCalcTempB,GLCDFNTDEFAULTSIZE
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF74
	rjmp	SysForLoop18
ENDIF74:
SysForLoopEnd18:
;Rotate CurrCharVal Right
	lds	SysValueCopy,CURRCHARVAL
	ror	SysValueCopy
	sts	CURRCHARVAL,SysValueCopy
;CharRow +=GLCDfntDefaultsize
	lds	SysTemp1,CHARROW
	lds	SysTemp2,GLCDFNTDEFAULTSIZE
	add	SysTemp1,SysTemp2
	sts	CHARROW,SysTemp1
	lds	SysTemp1,CHARROW_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	CHARROW_H,SysTemp1
;Next
	lds	SysCalcTempA,CURRCHARROW
	cpi	SysCalcTempA,8
	brsh	ENDIF75
	rjmp	SysForLoop17
ENDIF75:
SysForLoopEnd17:
;CharCol +=GLCDfntDefaultsize
	lds	SysTemp1,CHARCOL
	lds	SysTemp2,GLCDFNTDEFAULTSIZE
	add	SysTemp1,SysTemp2
	sts	CHARCOL,SysTemp1
	lds	SysTemp1,CHARCOL_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	sts	CHARCOL_H,SysTemp1
;1.14 Low Memory GLCD mode
;1.12 Character GLCD mode
;Handles specific draw sequence. This caters for write only of a bit value. No read operation.
;Next
	lds	SysCalcTempA,CURRCHARCOL
	cpi	SysCalcTempA,5
	brsh	ENDIF76
	rjmp	SysForLoop16
ENDIF76:
SysForLoopEnd16:
;****** OLED Font set handler
;1.14 Added transaction
;Restore
;GLCDBackground = 0
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND,SysValueCopy
	sts	GLCDBACKGROUND_H,SysValueCopy
;GLCDForeground = 1
	ldi	SysValueCopy,1
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDFOREGROUND_H,SysValueCopy
	ret

;********************************************************************************

;Source: glcd.h (1596)
GLCDDRAWSTRING:
;dim GLCDPrintLoc as word
;GLCDPrintLoc = StringLocX
	lds	SysValueCopy,STRINGLOCX
	sts	GLCDPRINTLOC,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDPRINTLOC_H,SysValueCopy
;for xchar = 1 to Chars(0)
;Legacy method
	ldi	SysValueCopy,0
	sts	XCHAR,SysValueCopy
	lds	SysStringA,SysCHARSHandler
	lds	SysStringA_H,SysCHARSHandler_H
	ld	SysCalcTempA,X
	cpi	SysCalcTempA,1
	brsh	ENDIF13
	rjmp	SysForLoopEnd6
ENDIF13:
SysForLoop6:
	lds	SysTemp1,XCHAR
	inc	SysTemp1
	sts	XCHAR,SysTemp1
;GLCDDrawChar GLCDPrintLoc , CharLocY , Chars(xchar), LineColour
	lds	SysValueCopy,GLCDPRINTLOC
	sts	CHARLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	CHARLOCX_H,SysValueCopy
	lds	SysTemp1,SysCHARSHandler
	lds	SysTemp2,XCHAR
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SysCHARSHandler_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	ld	SysValueCopy,X
	sts	CHARCODE,SysValueCopy
	rcall	GLCDDRAWCHAR_SSD1309
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1530)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	lds	SysBYTETempA,GLCDFONTWIDTH
	lds	SysBYTETempB,GLCDFNTDEFAULTSIZE
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp1,SysByteTempX
	lds	SysTemp3,GLCDPRINTLOC
	add	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp1,GLCDPRINTLOC_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	mov	SysTemp2_H,SysTemp1
	ldi	SysTemp3,1
	add	SysTemp2,SysTemp3
	sts	GLCDPRINTLOC,SysTemp2
	ldi	SysTemp3,0
	adc	SysTemp2_H,SysTemp3
	sts	GLCDPRINTLOC_H,SysTemp2_H
;next
	lds	SysStringA,SysCHARSHandler
	lds	SysStringA_H,SysCHARSHandler_H
	lds	SysCalcTempA,XCHAR
	ld	SysCalcTempB,X
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop6
SysForLoopEnd6:
	ret

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (1293)
GLCDPRINT4:
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	lds	SysStringA,SysLCDPRINTDATAHandler
	lds	SysStringA_H,SysLCDPRINTDATAHandler_H
	ld	SysValueCopy,X
	sts	GLCDPRINTLEN,SysValueCopy
;If GLCDPrintLen = 0 Then Exit Sub
	lds	SysCalcTempA,GLCDPRINTLEN
	tst	SysCalcTempA
	brne	ENDIF8
;If GLCDPrintLen = 0 Then Exit Sub
	ret
;If GLCDPrintLen = 0 Then Exit Sub
ENDIF8:
;GLCDPrintLoc = PrintLocX
	lds	SysValueCopy,PRINTLOCX
	sts	GLCDPRINTLOC,SysValueCopy
	lds	SysValueCopy,PRINTLOCX_H
	sts	GLCDPRINTLOC_H,SysValueCopy
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
;Legacy method
	ldi	SysValueCopy,0
	sts	GLCDPRINT_STRING_COUNTER,SysValueCopy
	lds	SysCalcTempA,GLCDPRINTLEN
	cpi	SysCalcTempA,1
	brsh	ENDIF9
	rjmp	SysForLoopEnd4
ENDIF9:
SysForLoop4:
	lds	SysTemp1,GLCDPRINT_STRING_COUNTER
	inc	SysTemp1
	sts	GLCDPRINT_STRING_COUNTER,SysTemp1
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	lds	SysValueCopy,GLCDPRINTLOC
	sts	CHARLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	CHARLOCX_H,SysValueCopy
	lds	SysValueCopy,PRINTLOCY
	sts	CHARLOCY,SysValueCopy
	lds	SysValueCopy,PRINTLOCY_H
	sts	CHARLOCY_H,SysValueCopy
	lds	SysTemp1,SysLCDPRINTDATAHandler
	lds	SysTemp2,GLCDPRINT_STRING_COUNTER
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SysLCDPRINTDATAHandler_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	ld	SysValueCopy,X
	sts	CHARCODE,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	GLCDDRAWCHAR_SSD1309
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1530)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	lds	SysBYTETempA,GLCDFONTWIDTH
	lds	SysBYTETempB,GLCDFNTDEFAULTSIZE
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp1,SysByteTempX
	lds	SysTemp3,GLCDPRINTLOC
	add	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp1,GLCDPRINTLOC_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	mov	SysTemp2_H,SysTemp1
	ldi	SysTemp3,1
	add	SysTemp2,SysTemp3
	sts	GLCDPRINTLOC,SysTemp2
	ldi	SysTemp3,0
	adc	SysTemp2_H,SysTemp3
	sts	GLCDPRINTLOC_H,SysTemp2_H
;Next
	lds	SysCalcTempA,GLCDPRINT_STRING_COUNTER
	lds	SysCalcTempB,GLCDPRINTLEN
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF10
	rjmp	SysForLoop4
ENDIF10:
SysForLoopEnd4:
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	lds	SysValueCopy,GLCDPRINTLOC
	sts	PRINTLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	PRINTLOCX_H,SysValueCopy
	ret

;********************************************************************************

;Overloaded signature: WORD:WORD:LONG:, Source: glcd.h (1405)
GLCDPRINT7:
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	ldi	SysValueCopy,0
	sts	SYSPRINTBUFFLEN,SysValueCopy
;Do
SysDoLoop_S2:
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	lds	SysTemp1,SYSPRINTBUFFLEN
	inc	SysTemp1
	sts	SYSPRINTBUFFLEN,SysTemp1
;SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
	ldi	SysTemp3,low(SYSPRINTBUFFER)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	ldi	SysTemp3,0
	ldi	SysTemp4,high(SYSPRINTBUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysLONGTempA,LCDVALUE
	lds	SysLONGTempA_H,LCDVALUE_H
	lds	SysLONGTempA_U,LCDVALUE_U
	lds	SysLONGTempA_E,LCDVALUE_E
	ldi	SysLONGTempB,10
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	rcall	SYSDIVSUB32
	st	X,SysLONGTempX
;LCDValue = SysCalcTempA
	sts	LCDVALUE,SYSCALCTEMPA
	sts	LCDVALUE_H,SYSCALCTEMPA_H
	sts	LCDVALUE_U,SYSCALCTEMPA_U
	sts	LCDVALUE_E,SYSCALCTEMPA_E
;Loop While LCDValue <> 0
	lds	SysLONGTempA,lcdvalue
	lds	SysLONGTempA_H,lcdvalue_H
	lds	SysLONGTempA_U,lcdvalue_U
	lds	SysLONGTempA_E,lcdvalue_E
	ldi	SysLONGTempB,0
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	rcall	SYSCOMPEQUAL32
	com	SysByteTempX
	sbrc	SysByteTempX,0
	rjmp	SysDoLoop_S2
SysDoLoop_E2:
;Display
;GLCDPrintLoc = PrintLocX
	lds	SysValueCopy,PRINTLOCX
	sts	GLCDPRINTLOC,SysValueCopy
	lds	SysValueCopy,PRINTLOCX_H
	sts	GLCDPRINTLOC_H,SysValueCopy
;For GLCDPrint_String_Counter = SysPrintBuffLen To 1 Step -1
;Legacy method
	lds	SysTemp1,SYSPRINTBUFFLEN
	inc	SysTemp1
	sts	GLCDPRINT_STRING_COUNTER,SysTemp1
	lds	SysCalcTempA,SYSPRINTBUFFLEN
	ldi	SysCalcTempA_H,0
	ldi	SysCalcTempA_U,0
	ldi	SysCalcTempA_E,0
	cpi	SysCalcTempA,1
	brsh	ENDIF11
	rjmp	SysForLoopEnd5
ENDIF11:
SysForLoop5:
	lds	SysTemp1,GLCDPRINT_STRING_COUNTER
	dec	SysTemp1
	sts	GLCDPRINT_STRING_COUNTER,SysTemp1
;GLCDDrawChar GLCDPrintLoc, PrintLocY, SysPrintBuffer(GLCDPrint_String_Counter) + 48
	lds	SysValueCopy,GLCDPRINTLOC
	sts	CHARLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	CHARLOCX_H,SysValueCopy
	lds	SysValueCopy,PRINTLOCY
	sts	CHARLOCY,SysValueCopy
	lds	SysValueCopy,PRINTLOCY_H
	sts	CHARLOCY_H,SysValueCopy
	lds	SysTemp1,GLCDPRINT_STRING_COUNTER
	ldi	SysTemp3,low(SYSPRINTBUFFER)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	ldi	SysTemp3,0
	ldi	SysTemp4,high(SYSPRINTBUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysTemp1,X
	ldi	SysTemp3,48
	add	SysTemp1,SysTemp3
	sts	CHARCODE,SysTemp1
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	GLCDDRAWCHAR_SSD1309
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1530)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	lds	SysBYTETempA,GLCDFONTWIDTH
	lds	SysBYTETempB,GLCDFNTDEFAULTSIZE
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp1,SysByteTempX
	lds	SysTemp3,GLCDPRINTLOC
	add	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp1,GLCDPRINTLOC_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	mov	SysTemp2_H,SysTemp1
	ldi	SysTemp3,1
	add	SysTemp2,SysTemp3
	sts	GLCDPRINTLOC,SysTemp2
	ldi	SysTemp3,0
	adc	SysTemp2_H,SysTemp3
	sts	GLCDPRINTLOC_H,SysTemp2_H
;Next
	ldi	SysCalcTempA,1
	ldi	SysCalcTempA_H,0
	ldi	SysCalcTempA_U,0
	ldi	SysCalcTempA_E,0
	lds	SysCalcTempB,GLCDPRINT_STRING_COUNTER
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF12
	rjmp	SysForLoop5
ENDIF12:
SysForLoopEnd5:
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	lds	SysValueCopy,GLCDPRINTLOC
	sts	PRINTLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	PRINTLOCX_H,SysValueCopy
	ret

;********************************************************************************

;Source: i2c.h (365)
I2CSEND:
;I2C_CLOCK_LOW                 'begin with SCL=0
	sbi	DDRC,5
	cbi	PORTC,5
;wait I2C_END_DELAY            'let port settle
;repeat 8                      '8 data bits
	ldi	SysValueCopy,8
	sts	SysRepeatTemp6,SysValueCopy
SysRepeatLoop6:
;if I2CByte.7 = ON then      'put most significant bit on SDA line
	lds	SysBitTest,I2CBYTE
	sbrs	SysBitTest,7
	rjmp	ELSE86_1
;I2C_DATA_HIGH
	cbi	DDRC,4
;else
	rjmp	ENDIF86
ELSE86_1:
;I2C_DATA_LOW
	sbi	DDRC,4
	cbi	PORTC,4
;end if
ENDIF86:
;rotate I2CByte left         'shift in bit for the next time
	lds	SysValueCopy,I2CBYTE
	rol	SysValueCopy
	sts	I2CBYTE,SysValueCopy
;I2C_CLOCK_HIGH              'now clock it in
	cbi	DDRC,5
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop1:
	sbis	PINC,5
	rjmp	SysWaitLoop1
;wait I2C_CLOCK_DELAY        'clock pulse width given here
;I2C_CLOCK_LOW               'done clocking that bit
	sbi	DDRC,5
	cbi	PORTC,5
;wait I2C_END_DELAY          'time between clock pulses
;end repeat                    'then do next bit
	lds	SysTemp1,SysRepeatTemp6
	dec	SysTemp1
	sts	SysRepeatTemp6,SysTemp1
	brne	SysRepeatLoop6
SysRepeatLoopEnd6:
;wait I2C_BIT_DELAY            'pad timing just a little
;I2C_DATA_HIGH                 'idle SDA to let Slave respond
	cbi	DDRC,4
;wait I2C_END_DELAY            'let SDA port line settle
;I2C_CLOCK_HIGH                'clock for the ACK/NAK bit
	cbi	DDRC,5
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop2:
	sbis	PINC,5
	rjmp	SysWaitLoop2
;restored 'I2CSendState' variable for backwards compatibility
;if I2C_DATA then              'read 9th bit in from Slave
	sbis	PINC,4
	rjmp	ELSE87_1
;I2CAck = FALSE              'return a NAK to the program
	ldi	SysValueCopy,0
	sts	I2CACK,SysValueCopy
;I2CSendState =  FALSE        'state of target device with respect. Retained for backwards compatibility
	ldi	SysValueCopy,0
	sts	I2CACKPOLLSTATE,SysValueCopy
;else
	rjmp	ENDIF87
ELSE87_1:
;I2CAck = TRUE               'else, return an ACK to the program
	ldi	SysValueCopy,255
	sts	I2CACK,SysValueCopy
;I2CSendState =  TRUE        'state of target device with respect. Retained for backwards compatibility
	ldi	SysValueCopy,255
	sts	I2CACKPOLLSTATE,SysValueCopy
;end if
ENDIF87:
;I2C_CLOCK_LOW                 'may be more bytes to clock out
	sbi	DDRC,5
	cbi	PORTC,5
;wait I2C_END_DELAY            'so keep idling both
;I2C_DATA_LOW                  'SCL and SDA low
	sbi	DDRC,4
	cbi	PORTC,4
;wait I2C_BIT_DELAY            'wait the usual bit length
	ret

;********************************************************************************

;Source: i2c.h (227)
I2CSTART:
;Dim I2CINTSTATESAVE as BIT
;I2C_DATA_HIGH                 'SDA and SCL idle high
	cbi	DDRC,4
;I2C_CLOCK_HIGH
	cbi	DDRC,5
;wait I2C_END_DELAY            'let settle a while
;I2C_DATA_LOW                  'then, SDA low while SCL still high
	sbi	DDRC,4
	cbi	PORTC,4
;wait I2C_CLOCK_DELAY          'for this amount of time
;I2C_CLOCK_LOW                 'end with SCL low, ready to clock
	sbi	DDRC,5
	cbi	PORTC,5
	ret

;********************************************************************************

;Source: i2c.h (277)
I2CSTOP:
;Dim I2CINTSTATESAVE as BIT
;I2C_CLOCK_LOW                 'begin with SCL=0 and SDA=0
	sbi	DDRC,5
	cbi	PORTC,5
;I2C_DATA_LOW
	sbi	DDRC,4
	cbi	PORTC,4
;wait I2C_END_DELAY            'let ports settle
;I2C_CLOCK_HIGH                'make SCL=1 first
	cbi	DDRC,5
;wait I2C_CLOCK_DELAY          'hold for normal clock width time
;I2C_DATA_HIGH                 'then make SDA=1 afterwards
	cbi	DDRC,4
;wait I2C_END_DELAY            'hold for normal between-time
;back idling with SCL=1 and SDA=1 at this point
	ret

;********************************************************************************

;Source: GLCD_SSD1309.H (359)
INITGLCD_SSD1309:
;Colours //Set these first
;GLCDBackground = 0
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND,SysValueCopy
	sts	GLCDBACKGROUND_H,SysValueCopy
;GLCDForeground = 1
	ldi	SysValueCopy,1
	sts	GLCDFOREGROUND,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDFOREGROUND_H,SysValueCopy
;GLCDFontWidth = 5
	ldi	SysValueCopy,5
	sts	GLCDFONTWIDTH,SysValueCopy
;GLCDfntDefaultHeight = 7  'used by GLCDPrintString and GLCDPrintStringLn
	ldi	SysValueCopy,7
	sts	GLCDFNTDEFAULTHEIGHT,SysValueCopy
;dim PrintLocX, PrintLocY as word
;GLCDfntDefault = 0
	ldi	SysValueCopy,0
	sts	GLCDFNTDEFAULT,SysValueCopy
;GLCDfntDefaultsize = 1
	ldi	SysValueCopy,1
	sts	GLCDFNTDEFAULTSIZE,SysValueCopy
;wait 255 ms             'added to ensure the charge pump and power is operational.
	ldi	SysWaitTempMS,255
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Setup code for SSD1309 controllers
;Init sequence for 128x64 OLED module
;Write_Command_SSD1309(SSD1309_DISPLAYOFF)                    ' 0xAE
	ldi	SysValueCopy,174
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_DEACTIVATE_SCROLL)
	ldi	SysValueCopy,46
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_SETDISPLAYCLOCKDIV)            ' 0xD5
	ldi	SysValueCopy,213
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0x80)                                  ' the suggested ratio 0x80
	ldi	SysValueCopy,128
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_SETMULTIPLEX)                  ' 0xA8
	ldi	SysValueCopy,168
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0x3f)                                 '64 pixels
	ldi	SysValueCopy,63
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_SETDISPLAYOFFSET)              ' 0xD3
	ldi	SysValueCopy,211
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0x00)                                   ' no offset
	ldi	SysValueCopy,0
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_SETSTARTLINE | 0x00)            ' line #0
	ldi	SysValueCopy,64
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_CHARGEPUMP)                    ' 0x8D
	ldi	SysValueCopy,141
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;if (SSD1309_vccstate = SSD1309_EXTERNALVCC) then
;Write_Command_SSD1309(0x10)
	ldi	SysValueCopy,16
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;else
;Write_Command_SSD1309(SSD1309_MEMORYMODE)                    ' 0x20
	ldi	SysValueCopy,32
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0x10)                                  ' 0x01 act like PCD8544
	ldi	SysValueCopy,16
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_SEGREMAP | 0x1)
	ldi	SysValueCopy,161
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_COMSCANDEC)
	ldi	SysValueCopy,200
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_SETCOMPINS)                    ' 0xDA
	ldi	SysValueCopy,218
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0x12)                                 '64 pixels
	ldi	SysValueCopy,18
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_SETCONTRAST)                   ' 0x81
	ldi	SysValueCopy,129
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;if SSD1309_vccstate = SSD1309_EXTERNALVCC then
;Write_Command_SSD1309(0x9F)
	ldi	SysValueCopy,159
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;else
;Write_Command_SSD1309(SSD1309_SETPRECHARGE)                  ' 0xd9
	ldi	SysValueCopy,217
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;if SSD1309_vccstate = SSD1309_EXTERNALVCC then
;Write_Command_SSD1309(0x22)
	ldi	SysValueCopy,34
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;else
;Write_Command_SSD1309(SSD1309_SETVCOMDETECT)                 ' 0xDB
	ldi	SysValueCopy,219
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0x40)
	ldi	SysValueCopy,64
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_DISPLAYALLON_RESUME)           ' 0xA4
	ldi	SysValueCopy,164
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_NORMALDISPLAY)                 ' 0xA6
	ldi	SysValueCopy,166
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Clear screen Here
;GLCDCLS_SSD1309
	rcall	GLCDCLS_SSD1309
;Write_Command_SSD1309(SSD1309_DISPLAYON)                     '--turn on oled panel
	ldi	SysValueCopy,175
	sts	SSD1309SENDBYTE,SysValueCopy
	rjmp	WRITE_COMMAND_SSD1309

;********************************************************************************

;Source: i2c.h (191)
INITI2C:
;Moved to prevent variable defintion when not required
;dim I2COldState, I2CState, I2CMatch, I2CTemp as byte
;dim I2CCount alias I2CState
;!
;!
;! Key constants not defined. I2C_DATA and I2C_CLOCK are required.
;!
;! Have you called "I2CStart", "I2CSend" or "I2CStop" without correct configuration of these key constants for software I2C?
;!
;!
;I2C_DATA_HIGH                   'release SDA (open drain floats high)
	cbi	DDRC,4
;!
;!
;! Key constants not defined. I2C_DATA and I2C_CLOCK are required.
;!
;! Have you called "I2CStart", "I2CSend" or "I2CStop" without correct configuration of these key constants for software I2C?
;!
;!
;I2C_CLOCK_HIGH                  'release SCL (open drain floats high)
	cbi	DDRC,5
;!
;!
;! Key constants not defined. I2C_DATA and I2C_CLOCK are required.
;!
;! Have you called "I2CStart", "I2CSend" or "I2CStop" without correct configuration of these key constants for software I2C?
;!
;!
;I2CMatch = FALSE                'address doesn't match (Slave mode)
	ldi	SysValueCopy,0
	sts	I2CMATCH,SysValueCopy
	ret

;********************************************************************************

;Source: system.h (201)
INITSYS:
;Turn off all ports
;PORTB = 0
	ldi	SysValueCopy,0
	out	PORTB,SysValueCopy
;PORTC = 0
	ldi	SysValueCopy,0
	out	PORTC,SysValueCopy
;PORTD = 0
	ldi	SysValueCopy,0
	out	PORTD,SysValueCopy
	ret

;********************************************************************************

;Source: string.h (1291)
FN_PAD:
;Check length of SysInString
;If SysInString(0) = longer or equal SysStrLen then
;give back SysInString and exit function
;If SysInString(0) < SysStrLen Then
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysCalcTempA,X
	lds	SysCalcTempB,SYSSTRLEN
	cp	SysCalcTempA,SysCalcTempB
	brlo	PC + 2
	rjmp	ELSE55_1
;SysCharCount = SysInString(0)
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysValueCopy,X
	sts	SYSCHARCOUNT,SysValueCopy
;clear output string
;Pad=""
	ldi	SysStringB,low(PAD)
	ldi	SysStringB_H,high(PAD)
	ldi	SysReadA,low(StringTable93<<1)
	ldi	SysReadA_H,high(StringTable93<<1)
	rcall	SYSREADSTRING
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
;Legacy method
	ldi	SysValueCopy,0
	sts	SYSSTRINGTEMP,SysValueCopy
	lds	SysCalcTempA,SYSCHARCOUNT
	cpi	SysCalcTempA,1
	brlo	SysForLoopEnd10
SysForLoop10:
	lds	SysTemp1,SYSSTRINGTEMP
	inc	SysTemp1
	sts	SYSSTRINGTEMP,SysTemp1
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	lds	SysTemp1,SysSYSINSTRINGHandler
	lds	SysTemp2,SYSSTRINGTEMP
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SysSYSINSTRINGHandler_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	ld	SysValueCopy,X+
	sts	SysArrayTemp1,SysValueCopy
	sts	SysArrayTemp2,SysValueCopy
	lds	SysTemp1,SYSSTRINGTEMP
	ldi	SysTemp3,low(PAD)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	ldi	SysTemp3,0
	ldi	SysTemp4,high(PAD)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysValueCopy,SysArrayTemp2
	st	X+,SysValueCopy
;Next
	lds	SysCalcTempA,SYSSTRINGTEMP
	lds	SysCalcTempB,SYSCHARCOUNT
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop10
SysForLoopEnd10:
;For SysStringTemp = SysCharCount+1 to SysStrLen
;Legacy method
	lds	SysTemp2,SYSCHARCOUNT
	inc	SysTemp2
	dec	SysTemp2
	sts	SYSSTRINGTEMP,SysTemp2
	lds	SysTemp2,SYSCHARCOUNT
	inc	SysTemp2
	mov	SysBYTETempB,SysTemp2
	lds	SysBYTETempA,SYSSTRLEN
	rcall	SYSCOMPLESSTHAN
	sbrc	SysByteTempX,0
	rjmp	SysForLoopEnd11
SysForLoop11:
	lds	SysTemp1,SYSSTRINGTEMP
	inc	SysTemp1
	sts	SYSSTRINGTEMP,SysTemp1
;Pad(SysStringTemp) = SysInString3(1)
	lds	SysTemp1,SysSYSINSTRING3Handler
	ldi	SysTemp3,1
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SysSYSINSTRING3Handler_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	ld	SysValueCopy,X+
	sts	SysArrayTemp2,SysValueCopy
	sts	SysArrayTemp1,SysValueCopy
	lds	SysTemp1,SYSSTRINGTEMP
	ldi	SysTemp3,low(PAD)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	ldi	SysTemp3,0
	ldi	SysTemp4,high(PAD)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysValueCopy,SysArrayTemp1
	st	X+,SysValueCopy
;Next
	lds	SysCalcTempA,SYSSTRINGTEMP
	lds	SysCalcTempB,SYSSTRLEN
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop11
SysForLoopEnd11:
;set new length to PAD
;Pad(0) = SysStrLen
	lds	SysValueCopy,SYSSTRLEN
	sts	SYSPAD_0,SysValueCopy
;else
	rjmp	ENDIF55
ELSE55_1:
;SysInString is equal or longer than SysStrLen
;give back old string; copy SysInString to Pad
;For SysStringTemp = 1 To SysInString(0)
;Legacy method
	ldi	SysValueCopy,0
	sts	SYSSTRINGTEMP,SysValueCopy
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysCalcTempA,X
	cpi	SysCalcTempA,1
	brlo	SysForLoopEnd12
SysForLoop12:
	lds	SysTemp1,SYSSTRINGTEMP
	inc	SysTemp1
	sts	SYSSTRINGTEMP,SysTemp1
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	lds	SysTemp1,SysSYSINSTRINGHandler
	lds	SysTemp2,SYSSTRINGTEMP
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SysSYSINSTRINGHandler_H
	ldi	SysTemp3,0
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	ld	SysValueCopy,X+
	sts	SysArrayTemp1,SysValueCopy
	sts	SysArrayTemp2,SysValueCopy
	lds	SysTemp1,SYSSTRINGTEMP
	ldi	SysTemp3,low(PAD)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	ldi	SysTemp3,0
	ldi	SysTemp4,high(PAD)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysValueCopy,SysArrayTemp2
	st	X+,SysValueCopy
;Next
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	lds	SysCalcTempA,SYSSTRINGTEMP
	ld	SysCalcTempB,X
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop12
SysForLoopEnd12:
;PAD(0) = SysInString(0)
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysValueCopy,X+
	sts	SysArrayTemp1,SysValueCopy
	sts	SYSPAD_0,SysValueCopy
;End If
ENDIF55:
	ret

;********************************************************************************

;Source: GLCD_SSD1309.H (930)
PSET_SSD1309:
;Set pixel at X, Y on LCD to State
;X is 0 to 127
;Y is 0 to 63
;Origin in top left
;1.14 Addresses correct device horizonal page
;don't need to do these calculations for in LOWMEMORY_GLCD_MODE
;SSD1309_BufferLocationCalc = ( GLCDY / 8 )* GLCD_WIDTH
;faster than /8
;SSD1309_BufferLocationCalc = GLCDY
	lds	SysValueCopy,GLCDY
	sts	SSD1309_BUFFERLOCATIONCALC,SysValueCopy
	ldi	SysValueCopy,0
	sts	SSD1309_BUFFERLOCATIONCALC_H,SysValueCopy
;Repeat 3
	ldi	SysValueCopy,3
	sts	SysRepeatTemp1,SysValueCopy
SysRepeatLoop1:
;Set C Off
	clc
;Rotate SSD1309_BufferLocationCalc Right
	lds	SysValueCopy,SSD1309_BUFFERLOCATIONCALC_H
	ror	SysValueCopy
	sts	SSD1309_BUFFERLOCATIONCALC_H,SysValueCopy
	lds	SysValueCopy,SSD1309_BUFFERLOCATIONCALC
	ror	SysValueCopy
	sts	SSD1309_BUFFERLOCATIONCALC,SysValueCopy
;End Repeat
	lds	SysTemp1,SysRepeatTemp1
	dec	SysTemp1
	sts	SysRepeatTemp1,SysTemp1
	brne	SysRepeatLoop1
SysRepeatLoopEnd1:
;faster than * 128
;Set C Off
	clc
;Repeat 7
	ldi	SysValueCopy,7
	sts	SysRepeatTemp1,SysValueCopy
SysRepeatLoop2:
;Rotate SSD1309_BufferLocationCalc Left
	lds	SysValueCopy,SSD1309_BUFFERLOCATIONCALC
	rol	SysValueCopy
	sts	SSD1309_BUFFERLOCATIONCALC,SysValueCopy
	lds	SysValueCopy,SSD1309_BUFFERLOCATIONCALC_H
	rol	SysValueCopy
	sts	SSD1309_BUFFERLOCATIONCALC_H,SysValueCopy
;End Repeat
	lds	SysTemp1,SysRepeatTemp1
	dec	SysTemp1
	sts	SysRepeatTemp1,SysTemp1
	brne	SysRepeatLoop2
SysRepeatLoopEnd2:
;SSD1309_BufferLocationCalc = GLCDX + SSD1309_BufferLocationCalc + 1
	lds	SysTemp2,GLCDX
	lds	SysTemp3,SSD1309_BUFFERLOCATIONCALC
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	ldi	SysTemp3,0
	lds	SysTemp2,SSD1309_BUFFERLOCATIONCALC_H
	adc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp3,1
	add	SysTemp1,SysTemp3
	sts	SSD1309_BUFFERLOCATIONCALC,SysTemp1
	ldi	SysTemp3,0
	adc	SysTemp1_H,SysTemp3
	sts	SSD1309_BUFFERLOCATIONCALC_H,SysTemp1_H
;GLCDDataTemp = SSD1309_BufferAlias(SSD1309_BufferLocationCalc)
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC
	ldi	SysTemp3,low(SSD1309_BUFFERALIAS)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC_H
	ldi	SysTemp3,high(SSD1309_BUFFERALIAS)
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	ld	SysValueCopy,X
	sts	GLCDDATATEMP,SysValueCopy
;Change data to set/clear pixel
;GLCDBitNo = GLCDY And 7
	ldi	SysTemp3,7
	lds	SysTemp1,GLCDY
	and	SysTemp1,SysTemp3
	sts	GLCDBITNO,SysTemp1
;If GLCDColour.0 = 0 Then
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	rjmp	ELSE83_1
;GLCDChange = 254
	ldi	SysValueCopy,254
	sts	GLCDCHANGE,SysValueCopy
;Set C On
	sec
;Else
	rjmp	ENDIF83
ELSE83_1:
;GLCDChange = 1
	ldi	SysValueCopy,1
	sts	GLCDCHANGE,SysValueCopy
;Set C Off
	clc
;End If
ENDIF83:
;Repeat GLCDBitNo
	lds	SysValueCopy,GLCDBITNO
	sts	SysRepeatTemp1,SysValueCopy
	lds	SysCalcTempA,SYSREPEATTEMP1
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd3
SysRepeatLoop3:
;Rotate GLCDChange Left
	lds	SysValueCopy,GLCDCHANGE
	rol	SysValueCopy
	sts	GLCDCHANGE,SysValueCopy
;End Repeat
	lds	SysTemp1,SysRepeatTemp1
	dec	SysTemp1
	sts	SysRepeatTemp1,SysTemp1
	brne	SysRepeatLoop3
SysRepeatLoopEnd3:
;If GLCDColour.0 = 0 Then
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	rjmp	ELSE84_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	lds	SysTemp1,GLCDDATATEMP
	lds	SysTemp2,GLCDCHANGE
	and	SysTemp2,SysTemp1
	sts	GLCDDATATEMP,SysTemp2
;Else
	rjmp	ENDIF84
ELSE84_1:
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	lds	SysTemp1,GLCDDATATEMP
	lds	SysTemp2,GLCDCHANGE
	or	SysTemp2,SysTemp1
	sts	GLCDDATATEMP,SysTemp2
;End If
ENDIF84:
;added 1.14 to isolate from full glcd mode
;revised 1.14 to isolate from low memory mode
;if SSD1309_BufferAlias(SSD1309_BufferLocationCalc) <> GLCDDataTemp then
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC
	ldi	SysTemp3,low(SSD1309_BUFFERALIAS)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC_H
	ldi	SysTemp3,high(SSD1309_BUFFERALIAS)
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	ld	SysCalcTempA,X
	lds	SysCalcTempB,GLCDDATATEMP
	cp	SysCalcTempA,SysCalcTempB
	breq	ENDIF85
;SSD1309_BufferAlias(SSD1309_BufferLocationCalc) = GLCDDataTemp
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC
	ldi	SysTemp3,low(SSD1309_BUFFERALIAS)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SSD1309_BUFFERLOCATIONCALC_H
	ldi	SysTemp3,high(SSD1309_BUFFERALIAS)
	adc	SysTemp1,SysTemp3
	mov	SysStringA_H,SysTemp1
	lds	SysValueCopy,GLCDDATATEMP
	st	X,SysValueCopy
;Cursor_Position_SSD1309 ( GLCDX, GLCDY )
	lds	SysValueCopy,GLCDX
	sts	LOCX,SysValueCopy
	lds	SysValueCopy,GLCDY
	sts	LOCY,SysValueCopy
	call	CURSOR_POSITION_SSD1309
;Write_Data_SSD1309 ( GLCDDataTemp )
	lds	SysValueCopy,GLCDDATATEMP
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_DATA_SSD1309
;end if
ENDIF85:
	ret

;********************************************************************************

;Source: GLCD_SSD1309.H (1218)
SETCONTRAST_SSD1309:
;Write_Command_SSD1309(SSD1309_SETCONTRAST)
	ldi	SysValueCopy,129
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(dim_state)
	lds	SysValueCopy,DIM_STATE
	sts	SSD1309SENDBYTE,SysValueCopy
	rjmp	WRITE_COMMAND_SSD1309

;********************************************************************************

;Source: GLCD_SSD1309.H (1202)
STARTSCROLLDIAGLEFT_SSD1309:
;Write_Command_SSD1309(SSD1309_SET_VERTICAL_SCROLL_AREA)
	ldi	SysValueCopy,163
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0X00)
	ldi	SysValueCopy,0
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(GLCD_HEIGHT)
	ldi	SysValueCopy,64
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_VERTICAL_AND_LEFT_HORIZONTAL_SCROLL)
	ldi	SysValueCopy,42
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_scrollspeed)
	lds	SysValueCopy,SSD1309_SCROLLSPEED
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_start)
	lds	SysValueCopy,SSD1309_START
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0X00)
	ldi	SysValueCopy,0
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_stop)
	lds	SysValueCopy,SSD1309_STOP
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0X01)
	ldi	SysValueCopy,1
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_ACTIVATE_SCROLL)
	ldi	SysValueCopy,47
	sts	SSD1309SENDBYTE,SysValueCopy
	rjmp	WRITE_COMMAND_SSD1309

;********************************************************************************

;Source: GLCD_SSD1309.H (1182)
STARTSCROLLDIAGRIGHT_SSD1309:
;Write_Command_SSD1309(SSD1309_SET_VERTICAL_SCROLL_AREA)
	ldi	SysValueCopy,163
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0X00)
	ldi	SysValueCopy,0
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(GLCD_HEIGHT)
	ldi	SysValueCopy,64
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL)
	ldi	SysValueCopy,41
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_scrollspeed)
	lds	SysValueCopy,SSD1309_SCROLLSPEED
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_start)
	lds	SysValueCopy,SSD1309_START
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0X00)
	ldi	SysValueCopy,0
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_stop)
	lds	SysValueCopy,SSD1309_STOP
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0X01)
	ldi	SysValueCopy,1
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_ACTIVATE_SCROLL)
	ldi	SysValueCopy,47
	sts	SSD1309SENDBYTE,SysValueCopy
	rjmp	WRITE_COMMAND_SSD1309

;********************************************************************************

;Source: GLCD_SSD1309.H (1163)
STARTSCROLLLEFT_SSD1309:
;Write_Command_SSD1309(SSD1309_LEFT_HORIZONTAL_SCROLL)
	ldi	SysValueCopy,39
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0X00)
	ldi	SysValueCopy,0
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_start)
	lds	SysValueCopy,SSD1309_START
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_scrollspeed)
	lds	SysValueCopy,SSD1309_SCROLLSPEED
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_stop)
	lds	SysValueCopy,SSD1309_STOP
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0X00)
	ldi	SysValueCopy,0
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0XFF)
	ldi	SysValueCopy,255
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_ACTIVATE_SCROLL)
	ldi	SysValueCopy,47
	sts	SSD1309SENDBYTE,SysValueCopy
	rjmp	WRITE_COMMAND_SSD1309

;********************************************************************************

;Source: GLCD_SSD1309.H (1144)
STARTSCROLLRIGHT_SSD1309:
;Write_Command_SSD1309(SSD1309_RIGHT_HORIZONTAL_SCROLL)
	ldi	SysValueCopy,38
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0X00)
	ldi	SysValueCopy,0
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_start)
	lds	SysValueCopy,SSD1309_START
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_scrollspeed)
	lds	SysValueCopy,SSD1309_SCROLLSPEED
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_stop)
	lds	SysValueCopy,SSD1309_STOP
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0X00)
	ldi	SysValueCopy,0
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(0XFF)
	ldi	SysValueCopy,255
	sts	SSD1309SENDBYTE,SysValueCopy
	rcall	WRITE_COMMAND_SSD1309
;Write_Command_SSD1309(SSD1309_ACTIVATE_SCROLL)
	ldi	SysValueCopy,47
	sts	SSD1309SENDBYTE,SysValueCopy
	rjmp	WRITE_COMMAND_SSD1309

;********************************************************************************

;Source: GLCD_SSD1309.H (1133)
STOPSCROLL_SSD1309:
;Write_Command_SSD1309(SSD1309_DEACTIVATE_SCROLL)
	ldi	SysValueCopy,46
	sts	SSD1309SENDBYTE,SysValueCopy
	rjmp	WRITE_COMMAND_SSD1309

;********************************************************************************

;Source: string.h (124)
FN_STR:
;SysCharCount = 0
	ldi	SysValueCopy,0
	sts	SYSCHARCOUNT,SysValueCopy
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,39
	rcall	SYSCOMPLESSTHAN16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF51
;SysStrData = SysValTemp / 10000
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,39
	rcall	SYSDIVSUB16
	sts	SYSSTRDATA,SysWORDTempA
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;SysCharCount += 1
	lds	SysTemp1,SYSCHARCOUNT
	inc	SysTemp1
	sts	SYSCHARCOUNT,SysTemp1
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp3,low(STR)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	ldi	SysTemp3,0
	ldi	SysTemp4,high(STR)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysTemp1,SYSSTRDATA
	ldi	SysTemp3,48
	add	SysTemp1,SysTemp3
	st	X,SysTemp1
;Goto SysValThousands
	rjmp	SYSVALTHOUSANDS
;End If
ENDIF51:
;Thousands
;IF SysValTemp >= 1000 then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	rcall	SYSCOMPLESSTHAN16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF52
SYSVALTHOUSANDS:
;SysStrData = SysValTemp / 1000
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	rcall	SYSDIVSUB16
	sts	SYSSTRDATA,SysWORDTempA
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;SysCharCount += 1
	lds	SysTemp1,SYSCHARCOUNT
	inc	SysTemp1
	sts	SYSCHARCOUNT,SysTemp1
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp3,low(STR)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	ldi	SysTemp3,0
	ldi	SysTemp4,high(STR)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysTemp1,SYSSTRDATA
	ldi	SysTemp3,48
	add	SysTemp1,SysTemp3
	st	X,SysTemp1
;Goto SysValHundreds
	rjmp	SYSVALHUNDREDS
;End If
ENDIF52:
;Hundreds
;IF SysValTemp >= 100 then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SYSCOMPLESSTHAN16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF53
SYSVALHUNDREDS:
;SysStrData = SysValTemp / 100
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SYSDIVSUB16
	sts	SYSSTRDATA,SysWORDTempA
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;SysCharCount += 1
	lds	SysTemp1,SYSCHARCOUNT
	inc	SysTemp1
	sts	SYSCHARCOUNT,SysTemp1
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp3,low(STR)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	ldi	SysTemp3,0
	ldi	SysTemp4,high(STR)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysTemp1,SYSSTRDATA
	ldi	SysTemp3,48
	add	SysTemp1,SysTemp3
	st	X,SysTemp1
;Goto SysValTens
	rjmp	SYSVALTENS
;End If
ENDIF53:
;Tens
;IF SysValTemp >= 10 Then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SYSCOMPLESSTHAN16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF54
SYSVALTENS:
;SysStrData = SysValTemp / 10
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SYSDIVSUB16
	sts	SYSSTRDATA,SysWORDTempA
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;SysCharCount += 1
	lds	SysTemp1,SYSCHARCOUNT
	inc	SysTemp1
	sts	SYSCHARCOUNT,SysTemp1
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp3,low(STR)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	ldi	SysTemp3,0
	ldi	SysTemp4,high(STR)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysTemp1,SYSSTRDATA
	ldi	SysTemp3,48
	add	SysTemp1,SysTemp3
	st	X,SysTemp1
;End If
ENDIF54:
;Ones
;SysCharCount += 1
	lds	SysTemp1,SYSCHARCOUNT
	inc	SysTemp1
	sts	SYSCHARCOUNT,SysTemp1
;Str(SysCharCount) = SysValTemp + 48
	ldi	SysTemp3,low(STR)
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	ldi	SysTemp3,0
	ldi	SysTemp4,high(STR)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysTemp1,SYSVALTEMP
	ldi	SysTemp3,48
	add	SysTemp1,SysTemp3
	st	X,SysTemp1
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;Str(0) = SysCharCount
	lds	SysValueCopy,SYSCHARCOUNT
	sts	SYSSTR_0,SysValueCopy
	ret

;********************************************************************************

;Source: system.h (4111)
SYSCOMPEQUAL:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cpse SysByteTempA, SysByteTempB
	cpse	SYSBYTETEMPA, SYSBYTETEMPB
;return
	ret
;com SysByteTempX
	com	SYSBYTETEMPX
	ret

;********************************************************************************

;Source: system.h (4137)
SYSCOMPEQUAL16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cp SysWordTempA, SysWordTempB
	cp	SYSWORDTEMPA, SYSWORDTEMPB
;brne SCE16False
	brne	SCE16FALSE
;cp SysWordTempA_H, SysWordTempB_H
	cp	SYSWORDTEMPA_H, SYSWORDTEMPB_H
;brne SCE16False
	brne	SCE16FALSE
;com SysByteTempX
	com	SYSBYTETEMPX
SCE16FALSE:
	ret

;********************************************************************************

;Source: system.h (4191)
SYSCOMPEQUAL32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cp SysLongTempA, SysLongTempB
	cp	SYSLONGTEMPA, SYSLONGTEMPB
;brne SCE32False
	brne	SCE32FALSE
;cp SysLongTempA_H, SysLongTempB_H
	cp	SYSLONGTEMPA_H, SYSLONGTEMPB_H
;brne SCE32False
	brne	SCE32FALSE
;cp SysLongTempA_U, SysLongTempB_U
	cp	SYSLONGTEMPA_U, SYSLONGTEMPB_U
;brne SCE32False
	brne	SCE32FALSE
;cp SysLongTempA_E, SysLongTempB_E
	cp	SYSLONGTEMPA_E, SYSLONGTEMPB_E
;brne SCE32False
	brne	SCE32FALSE
;com SysByteTempX
	com	SYSBYTETEMPX
SCE32FALSE:
	ret

;********************************************************************************

;Source: system.h (4501)
SYSCOMPLESSTHAN:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cp SysByteTempA,SysByteTempB
	cp	SYSBYTETEMPA,SYSBYTETEMPB
;brlo SCLTTrue
	brlo	SCLTTRUE
;ret
	ret
SCLTTRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
	ret

;********************************************************************************

;Source: system.h (4531)
SYSCOMPLESSTHAN16:
;clr SysByteTempX
	clr	SYSBYTETEMPX
;Test High, exit false if more
;cp SysWordTempB_H,SysWordTempA_H
	cp	SYSWORDTEMPB_H,SYSWORDTEMPA_H
;brlo SCLT16False
	brlo	SCLT16FALSE
;Test high, exit true if less
;cp SysWordTempA_H,SysWordTempB_H
	cp	SYSWORDTEMPA_H,SYSWORDTEMPB_H
;brlo SCLT16True
	brlo	SCLT16TRUE
;Test Low, exit if more or equal
;cp SysWordTempA,SysWordTempB
	cp	SYSWORDTEMPA,SYSWORDTEMPB
;brlo SCLT16True
	brlo	SCLT16TRUE
;ret
	ret
SCLT16TRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
SCLT16FALSE:
	ret

;********************************************************************************

;Source: system.h (4973)
SYSCOMPLESSTHANINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	ldi	SysValueCopy,0
	mov	SYSBYTETEMPX,SysValueCopy
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	sbrs	SYSINTEGERTEMPA_H,7
	rjmp	ELSE48_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	sbrc	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF49
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	mov	SysTemp1,SYSBYTETEMPX
	com	SysTemp1
	mov	SYSBYTETEMPX,SysTemp1
;Exit Sub
	ret
;End If
ENDIF49:
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	mov	SysTemp2,SYSINTEGERTEMPA
	mov	SysTemp2_H,SYSINTEGERTEMPA_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSDIVMULTA,SysTemp2
	mov	SYSDIVMULTA_H,SysTemp2_H
;SysIntegerTempA = -SysIntegerTempB
	mov	SysTemp2,SYSINTEGERTEMPB
	mov	SysTemp2_H,SYSINTEGERTEMPB_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSINTEGERTEMPA,SysTemp2
	mov	SYSINTEGERTEMPA_H,SysTemp2_H
;SysIntegerTempB = SysDivMultA
	mov	SYSINTEGERTEMPB,SYSDIVMULTA
	mov	SYSINTEGERTEMPB_H,SYSDIVMULTA_H
;+A
;Else
	rjmp	ENDIF48
ELSE48_1:
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	sbrc	SYSINTEGERTEMPB_H,7
;Exit Sub
	ret
;End If
;End If
ENDIF48:
;Test High, exit false if more
;cp SysIntegerTempB_H,SysIntegerTempA_H
	cp	SYSINTEGERTEMPB_H,SYSINTEGERTEMPA_H
;brlo SCLTIntFalse
	brlo	SCLTINTFALSE
;Test high, exit true if less
;cp SysIntegerTempA_H,SysIntegerTempB_H
	cp	SYSINTEGERTEMPA_H,SYSINTEGERTEMPB_H
;brlo SCLTIntTrue
	brlo	SCLTINTTRUE
;Test Low, exit if more or equal
;cp SysIntegerTempA,SysIntegerTempB
	cp	SYSINTEGERTEMPA,SYSINTEGERTEMPB
;brlo SCLTIntTrue
	brlo	SCLTINTTRUE
;ret
	ret
SCLTINTTRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
SCLTINTFALSE:
	ret

;********************************************************************************

;Source: system.h (1766)
SYSCOPYSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;SysStringA (X) stores source
;SysStringB (Y) stores destination
;SysStringLength is counter, keeps track of size of destination string
;SysCalcTempA is loop counter
;Dim SysReadA As Byte
;Get and copy length
;ld SysCalcTempA, X+
	ld	SYSCALCTEMPA, X+
;st Y+, SysCalcTempA
	st	Y+, SYSCALCTEMPA
;rjmp SysCopyStringCheck
	rjmp	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART:
;ld SysCalcTempA, X+
	ld	SYSCALCTEMPA, X+
;add SysStringLength, SysCalcTempA
	add	SYSSTRINGLENGTH, SYSCALCTEMPA
SYSCOPYSTRINGCHECK:
;Exit if length = 0
;cpi SysCalcTempA,0
	cpi	SYSCALCTEMPA,0
;brne SysStringCopy
	brne	SYSSTRINGCOPY
;ret
	ret
SYSSTRINGCOPY:
;Copy character
;ld SysReadA, X+
	ld	SYSREADA, X+
;st Y+, SysReadA
	st	Y+, SYSREADA
;dec SysCalcTempA
	dec	SYSCALCTEMPA
;brne SysStringCopy
	brne	SYSSTRINGCOPY
	ret

;********************************************************************************

;Source: system.h (3505)
SYSDIVSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	mov	SYSDIVMULTA,SYSWORDTEMPA
	mov	SYSDIVMULTA_H,SYSWORDTEMPA_H
;SysDivMultB = SysWordTempB
	mov	SYSDIVMULTB,SYSWORDTEMPB
	mov	SYSDIVMULTB_H,SYSWORDTEMPB_H
;SysDivMultX = 0
	ldi	SysValueCopy,0
	mov	SYSDIVMULTX,SysValueCopy
	ldi	SysValueCopy,0
	mov	SYSDIVMULTX_H,SysValueCopy
;Avoid division by zero
;if SysDivMultB = 0 then
	mov	SysWORDTempA,SYSDIVMULTB
	mov	SysWORDTempA_H,SYSDIVMULTB_H
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,0
	rcall	SYSCOMPEQUAL16
	sbrs	SysByteTempX,0
	rjmp	ENDIF41
;SysWordTempA = 0
	ldi	SYSWORDTEMPA,0
	ldi	SYSWORDTEMPA_H,0
;exit sub
	ret
;end if
ENDIF41:
;Main calc routine
;SysDivLoop = 16
	ldi	SysValueCopy,16
	mov	SYSDIVLOOP,SysValueCopy
SYSDIV16START:
;set C off
	clc
;Rotate SysDivMultA Left
	rol	SYSDIVMULTA
	rol	SYSDIVMULTA_H
;Rotate SysDivMultX Left
	rol	SYSDIVMULTX
	rol	SYSDIVMULTX_H
;SysDivMultX = SysDivMultX - SysDivMultB
	mov	SysTemp1,SYSDIVMULTX
	sub	SysTemp1,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp1
	mov	SysTemp1,SYSDIVMULTX_H
	sbc	SysTemp1,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp1
;Set SysDivMultA.0 On
	sbr	 SYSDIVMULTA,1<<0
;If C On Then
	brbc	C,ENDIF42
;Set SysDivMultA.0 Off
	cbr	 SYSDIVMULTA,1<<0
;SysDivMultX = SysDivMultX + SysDivMultB
	mov	SysTemp1,SYSDIVMULTX
	add	SysTemp1,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp1
	mov	SysTemp1,SYSDIVMULTX_H
	adc	SysTemp1,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp1
;End If
ENDIF42:
;dec SysDivLoop
	dec	SYSDIVLOOP
;brne SysDiv16Start
	brne	SYSDIV16START
;SysWordTempA = SysDivMultA
	mov	SYSWORDTEMPA,SYSDIVMULTA
	mov	SYSWORDTEMPA_H,SYSDIVMULTA_H
;SysWordTempX = SysDivMultX
	mov	SYSWORDTEMPX,SYSDIVMULTX
	mov	SYSWORDTEMPX_H,SYSDIVMULTX_H
	ret

;********************************************************************************

;Source: system.h (3581)
SYSDIVSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	sts	SYSLONGDIVMULTA,SYSLONGTEMPA
	sts	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	sts	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	sts	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongDivMultB = SysLongTempB
	sts	SYSLONGDIVMULTB,SYSLONGTEMPB
	sts	SYSLONGDIVMULTB_H,SYSLONGTEMPB_H
	sts	SYSLONGDIVMULTB_U,SYSLONGTEMPB_U
	sts	SYSLONGDIVMULTB_E,SYSLONGTEMPB_E
;SysLongDivMultX = 0
	ldi	SysValueCopy,0
	sts	SYSLONGDIVMULTX,SysValueCopy
	sts	SYSLONGDIVMULTX_H,SysValueCopy
	sts	SYSLONGDIVMULTX_U,SysValueCopy
	sts	SYSLONGDIVMULTX_E,SysValueCopy
;Avoid division by zero
;if SysLongDivMultB = 0 then
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
	rjmp	ENDIF46
;SysLongTempA = 0
	ldi	SYSLONGTEMPA,0
	ldi	SYSLONGTEMPA_H,0
	ldi	SYSLONGTEMPA_U,0
	ldi	SYSLONGTEMPA_E,0
;exit sub
	ret
;end if
ENDIF46:
;Main calc routine
;SysDivLoop = 32
	ldi	SysValueCopy,32
	mov	SYSDIVLOOP,SysValueCopy
SYSDIV32START:
;set C off
	clc
;Rotate SysLongDivMultA Left
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
;Rotate SysLongDivMultX Left
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
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	lds	SysTemp1,SYSLONGDIVMULTX
	lds	SysTemp2,SYSLONGDIVMULTB
	sub	SysTemp1,SysTemp2
	sts	SYSLONGDIVMULTX,SysTemp1
	lds	SysTemp1,SYSLONGDIVMULTX_H
	lds	SysTemp2,SYSLONGDIVMULTB_H
	sbc	SysTemp1,SysTemp2
	sts	SYSLONGDIVMULTX_H,SysTemp1
	lds	SysTemp1,SYSLONGDIVMULTX_U
	lds	SysTemp2,SYSLONGDIVMULTB_U
	sbc	SysTemp1,SysTemp2
	sts	SYSLONGDIVMULTX_U,SysTemp1
	lds	SysTemp1,SYSLONGDIVMULTX_E
	lds	SysTemp2,SYSLONGDIVMULTB_E
	sbc	SysTemp1,SysTemp2
	sts	SYSLONGDIVMULTX_E,SysTemp1
;Set SysLongDivMultA.0 On
	lds	SysValueCopy,SYSLONGDIVMULTA
	sbr	SysValueCopy,1<<0
	sts	SYSLONGDIVMULTA,SysValueCopy
;If C On Then
	brbc	C,ENDIF47
;Set SysLongDivMultA.0 Off
	lds	SysValueCopy,SYSLONGDIVMULTA
	cbr	SysValueCopy,1<<0
	sts	SYSLONGDIVMULTA,SysValueCopy
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	lds	SysTemp1,SYSLONGDIVMULTX
	lds	SysTemp2,SYSLONGDIVMULTB
	add	SysTemp1,SysTemp2
	sts	SYSLONGDIVMULTX,SysTemp1
	lds	SysTemp1,SYSLONGDIVMULTX_H
	lds	SysTemp2,SYSLONGDIVMULTB_H
	adc	SysTemp1,SysTemp2
	sts	SYSLONGDIVMULTX_H,SysTemp1
	lds	SysTemp1,SYSLONGDIVMULTX_U
	lds	SysTemp2,SYSLONGDIVMULTB_U
	adc	SysTemp1,SysTemp2
	sts	SYSLONGDIVMULTX_U,SysTemp1
	lds	SysTemp1,SYSLONGDIVMULTX_E
	lds	SysTemp2,SYSLONGDIVMULTB_E
	adc	SysTemp1,SysTemp2
	sts	SYSLONGDIVMULTX_E,SysTemp1
;End If
ENDIF47:
;dec SysDivLoop
	dec	SYSDIVLOOP
;breq SysDiv32End
	breq	SYSDIV32END
;goto SysDiv32Start
	rjmp	SYSDIV32START
SYSDIV32END:
;SysLongTempA = SysLongDivMultA
	lds	SYSLONGTEMPA,SYSLONGDIVMULTA
	lds	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	lds	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	lds	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongTempX = SysLongDivMultX
	lds	SYSLONGTEMPX,SYSLONGDIVMULTX
	lds	SYSLONGTEMPX_H,SYSLONGDIVMULTX_H
	lds	SYSLONGTEMPX_U,SYSLONGDIVMULTX_U
	lds	SYSLONGTEMPX_E,SYSLONGDIVMULTX_E
	ret

;********************************************************************************

;Source: system.h (3559)
SYSDIVSUBINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	mov	SysTemp1,SYSINTEGERTEMPB_H
	eor	SysTemp1,SYSINTEGERTEMPA_H
	mov	SYSSIGNBYTE,SysTemp1
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	sbrs	SYSINTEGERTEMPA_H,7
	rjmp	ENDIF43
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	mov	SysTemp2,SYSINTEGERTEMPA
	mov	SysTemp2_H,SYSINTEGERTEMPA_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSINTEGERTEMPA,SysTemp2
	mov	SYSINTEGERTEMPA_H,SysTemp2_H
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
ENDIF43:
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	sbrs	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF44
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	mov	SysTemp2,SYSINTEGERTEMPB
	mov	SysTemp2_H,SYSINTEGERTEMPB_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSINTEGERTEMPB,SysTemp2
	mov	SYSINTEGERTEMPB_H,SysTemp2_H
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
ENDIF44:
;Call word divide routine
;SysDivSub16
	rcall	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	sbrs	SYSSIGNBYTE,7
	rjmp	ENDIF45
;SysIntegerTempA = -SysIntegerTempA
	mov	SysTemp2,SYSINTEGERTEMPA
	mov	SysTemp2_H,SYSINTEGERTEMPA_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSINTEGERTEMPA,SysTemp2
	mov	SYSINTEGERTEMPA_H,SysTemp2_H
;SysIntegerTempX = -SysIntegerTempX
	mov	SysTemp2,SYSINTEGERTEMPX
	mov	SysTemp2_H,SYSINTEGERTEMPX_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSINTEGERTEMPX,SysTemp2
	mov	SYSINTEGERTEMPX_H,SysTemp2_H
;End If
ENDIF45:
	ret

;********************************************************************************

;Source: system.h (2971)
SYSMULTSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	mov	SYSDIVMULTA,SYSWORDTEMPA
	mov	SYSDIVMULTA_H,SYSWORDTEMPA_H
;SysDivMultB = SysWordTempB
	mov	SYSDIVMULTB,SYSWORDTEMPB
	mov	SYSDIVMULTB_H,SYSWORDTEMPB_H
;SysDivMultX = 0
	ldi	SysValueCopy,0
	mov	SYSDIVMULTX,SysValueCopy
	ldi	SysValueCopy,0
	mov	SYSDIVMULTX_H,SysValueCopy
MUL16LOOP:
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	sbrs	SYSDIVMULTB,0
	rjmp	ENDIF36
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	mov	SysTemp1,SYSDIVMULTX
	add	SysTemp1,SYSDIVMULTA
	mov	SYSDIVMULTX,SysTemp1
	mov	SysTemp1,SYSDIVMULTX_H
	adc	SysTemp1,SYSDIVMULTA_H
	mov	SYSDIVMULTX_H,SysTemp1
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
ENDIF36:
;Set C Off
	clc
;rotate SysDivMultB right
	ror	SYSDIVMULTB_H
	ror	SYSDIVMULTB
;Set C Off
	clc
;rotate SysDivMultA left
	rol	SYSDIVMULTA
	rol	SYSDIVMULTA_H
;if SysDivMultB > 0 then goto MUL16LOOP
	mov	SysWORDTempB,SYSDIVMULTB
	mov	SysWORDTempB_H,SYSDIVMULTB_H
	ldi	SysWORDTempA,0
	ldi	SysWORDTempA_H,0
	rcall	SYSCOMPLESSTHAN16
	sbrc	SysByteTempX,0
;if SysDivMultB > 0 then goto MUL16LOOP
	rjmp	MUL16LOOP
;if SysDivMultB > 0 then goto MUL16LOOP
;SysWordTempX = SysDivMultX
	mov	SYSWORDTEMPX,SYSDIVMULTX
	mov	SYSWORDTEMPX_H,SYSDIVMULTX_H
	ret

;********************************************************************************

;Source: system.h (3069)
SYSMULTSUBINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	mov	SysTemp1,SYSINTEGERTEMPB_H
	eor	SysTemp1,SYSINTEGERTEMPA_H
	mov	SYSSIGNBYTE,SysTemp1
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	sbrs	SYSINTEGERTEMPA_H,7
	rjmp	ENDIF38
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	mov	SysTemp2,SYSINTEGERTEMPA
	mov	SysTemp2_H,SYSINTEGERTEMPA_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSINTEGERTEMPA,SysTemp2
	mov	SYSINTEGERTEMPA_H,SysTemp2_H
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
ENDIF38:
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	sbrs	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF39
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	mov	SysTemp2,SYSINTEGERTEMPB
	mov	SysTemp2_H,SYSINTEGERTEMPB_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSINTEGERTEMPB,SysTemp2
	mov	SYSINTEGERTEMPB_H,SysTemp2_H
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
ENDIF39:
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	sbrs	SYSSIGNBYTE,7
	rjmp	ENDIF40
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	mov	SysTemp2,SYSINTEGERTEMPX
	mov	SysTemp2_H,SYSINTEGERTEMPX_H
	com	SysTemp2
	com	SysTemp2_H
	inc	SysTemp2
	brne	PC + 2
	inc	SysTemp2_H
	mov	SYSINTEGERTEMPX,SysTemp2
	mov	SYSINTEGERTEMPX_H,SysTemp2_H
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
ENDIF40:
	ret

;********************************************************************************

;Source: system.h (1963)
SYSREADSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Dim SysCalcTempX As Byte
;Get length
;lpm SysCalcTempA, Z+
;lpm
	lpm
;mov SysCalcTempA, SysCalcTempX
	mov	SYSCALCTEMPA, SYSCALCTEMPX
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;st Y+, SysCalcTempA
	st	Y+, SYSCALCTEMPA
;rjmp SysStringReadCheck
	rjmp	SYSSTRINGREADCHECK
SYSREADSTRINGPART:
;lpm SysCalcTempA, Z+
;lpm
	lpm
;mov SysCalcTempA, SysCalcTempX
	mov	SYSCALCTEMPA, SYSCALCTEMPX
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;add SysStringLength, SysCalcTempA
	add	SYSSTRINGLENGTH, SYSCALCTEMPA
;Check length
SYSSTRINGREADCHECK:
;If length is 0, exit
;cpi SysCalcTempA, 0
	cpi	SYSCALCTEMPA, 0
;brne SysStringRead
	brne	SYSSTRINGREAD
;ret
	ret
;Copy
SYSSTRINGREAD:
;Copy char
;lpm SysCalcTempX, Z+
;lpm
	lpm
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;st Y+, SysCalcTempX
	st	Y+, SYSCALCTEMPX
;dec SysCalcTempA
	dec	SYSCALCTEMPA
;brne SysStringRead
	brne	SYSSTRINGREAD
	ret

;********************************************************************************

SysStringTables:

StringTable1:
.DB	8,80,114,105,110,116,83,116,114,0


StringTable2:
.DB	1,64


StringTable3:
.DB	3,77,104,122


StringTable4:
.DB	7,68,114,97,119,83,116,114


StringTable5:
.DB	1,104


StringTable52:
.DB	1,32


StringTable93:
.DB	0,0


;********************************************************************************

;Source: GLCD_SSD1309.H (266)
WRITE_COMMAND_SSD1309:
;I2CStart
	rcall	I2CSTART
;I2CSend GLCD_I2C_Address
	ldi	SysValueCopy,120
	sts	I2CBYTE,SysValueCopy
	rcall	I2CSEND
;I2CSend 0x00
	ldi	SysValueCopy,0
	sts	I2CBYTE,SysValueCopy
	rcall	I2CSEND
;I2CSend SSD1309SendByte
	lds	SysValueCopy,SSD1309SENDBYTE
	sts	I2CBYTE,SysValueCopy
	rcall	I2CSEND
;I2CStop
	rjmp	I2CSTOP

;********************************************************************************

;Source: GLCD_SSD1309.H (312)
WRITE_DATA_SSD1309:
;I2CStart
	rcall	I2CSTART
;I2CSend GLCD_I2C_Address
	ldi	SysValueCopy,120
	sts	I2CBYTE,SysValueCopy
	rcall	I2CSEND
;I2CSend 0x40
	ldi	SysValueCopy,64
	sts	I2CBYTE,SysValueCopy
	rcall	I2CSEND
;I2CSend SSD1309SendByte
	lds	SysValueCopy,SSD1309SENDBYTE
	sts	I2CBYTE,SysValueCopy
	rcall	I2CSEND
;I2CStop
	rjmp	I2CSTOP

;********************************************************************************

;Source: picas.h (7)
FN__HEXPICAS:
;_HexPICAS(0) = 2
	ldi	SysValueCopy,2
	sts	SYS_HEXPICAS_0,SysValueCopy
;dim SysStringTemp as byte
;Low nibble
;SysStringTemp = SysValTemp And 0x0F
	ldi	SysTemp3,15
	lds	SysTemp1,SYSVALTEMP
	and	SysTemp1,SysTemp3
	sts	SYSSTRINGTEMP,SysTemp1
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	ldi	SysCalcTempA,9
	lds	SysCalcTempB,SYSSTRINGTEMP
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF23
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	lds	SysTemp1,SYSSTRINGTEMP
	ldi	SysTemp3,7
	add	SysTemp1,SysTemp3
	sts	SYSSTRINGTEMP,SysTemp1
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
ENDIF23:
;_HexPICAS(2) = SysStringTemp + 48
	lds	SysTemp1,SYSSTRINGTEMP
	ldi	SysTemp3,48
	add	SysTemp1,SysTemp3
	sts	SYS_HEXPICAS_2,SysTemp1
;Get high nibble
;For SysStringTemp = 1 to 4
;Legacy method
	ldi	SysValueCopy,0
	sts	SYSSTRINGTEMP,SysValueCopy
SysForLoop9:
	lds	SysTemp1,SYSSTRINGTEMP
	inc	SysTemp1
	sts	SYSSTRINGTEMP,SysTemp1
;Rotate SysValTemp Right
	lds	SysValueCopy,SYSVALTEMP
	ror	SysValueCopy
	sts	SYSVALTEMP,SysValueCopy
;Next
	lds	SysCalcTempA,SYSSTRINGTEMP
	cpi	SysCalcTempA,4
	brlo	SysForLoop9
SysForLoopEnd9:
;SysStringTemp = SysValTemp And 0x0F
	ldi	SysTemp3,15
	lds	SysTemp1,SYSVALTEMP
	and	SysTemp1,SysTemp3
	sts	SYSSTRINGTEMP,SysTemp1
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	ldi	SysCalcTempA,9
	lds	SysCalcTempB,SYSSTRINGTEMP
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF25
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	lds	SysTemp1,SYSSTRINGTEMP
	ldi	SysTemp3,7
	add	SysTemp1,SysTemp3
	sts	SYSSTRINGTEMP,SysTemp1
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
ENDIF25:
;_HexPICAS(1) = SysStringTemp + 48
	lds	SysTemp1,SYSSTRINGTEMP
	ldi	SysTemp3,48
	add	SysTemp1,SysTemp3
	sts	SYS_HEXPICAS_1,SysTemp1
	ret

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: picas.h (32)
_LINE70:
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFX,SysValueCopy
	sts	LINEDIFFX_H,SysValueCopy
;LineDiffY = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFY,SysValueCopy
	sts	LINEDIFFY_H,SysValueCopy
;LineStepX = 0
	ldi	SysValueCopy,0
	sts	LINESTEPX,SysValueCopy
	sts	LINESTEPX_H,SysValueCopy
;LineStepY = 0
	ldi	SysValueCopy,0
	sts	LINESTEPY,SysValueCopy
	sts	LINESTEPY_H,SysValueCopy
;LineDiffX_x2 = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFX_X2,SysValueCopy
	sts	LINEDIFFX_X2_H,SysValueCopy
;LineDiffY_x2 = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFY_X2,SysValueCopy
	sts	LINEDIFFY_X2_H,SysValueCopy
;LineErr = 0
	ldi	SysValueCopy,0
	sts	LINEERR,SysValueCopy
	sts	LINEERR_H,SysValueCopy
;LineDiffX =  LineX2 -   LineX1
	lds	SysTemp1,LINEX2
	lds	SysTemp2,LINEX1
	sub	SysTemp1,SysTemp2
	sts	LINEDIFFX,SysTemp1
	lds	SysTemp1,LINEX2_H
	lds	SysTemp2,LINEX1_H
	sbc	SysTemp1,SysTemp2
	sts	LINEDIFFX_H,SysTemp1
;LineDiffY =  LineY2 -   LineY1
	lds	SysTemp1,LINEY2
	lds	SysTemp2,LINEY1
	sub	SysTemp1,SysTemp2
	sts	LINEDIFFY,SysTemp1
	lds	SysTemp1,LINEY2_H
	lds	SysTemp2,LINEY1_H
	sbc	SysTemp1,SysTemp2
	sts	LINEDIFFY_H,SysTemp1
;if (LineDiffX > 0) then
	lds	SysINTEGERTempB,LINEDIFFX
	lds	SysINTEGERTempB_H,LINEDIFFX_H
	ldi	SysINTEGERTempA,0
	ldi	SysINTEGERTempA_H,0
	rcall	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE26_1
;LineStepX = 1
	ldi	SysValueCopy,1
	sts	LINESTEPX,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPX_H,SysValueCopy
;else
	rjmp	ENDIF26
ELSE26_1:
;LineStepX = -1
	ldi	SysValueCopy,255
	sts	LINESTEPX,SysValueCopy
	sts	LINESTEPX_H,SysValueCopy
;end if
ENDIF26:
;if (LineDiffY > 0) then
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	ldi	SysINTEGERTempA,0
	ldi	SysINTEGERTempA_H,0
	rcall	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE27_1
;LineStepY = 1
	ldi	SysValueCopy,1
	sts	LINESTEPY,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPY_H,SysValueCopy
;else
	rjmp	ENDIF27
ELSE27_1:
;LineStepY = -1
	ldi	SysValueCopy,255
	sts	LINESTEPY,SysValueCopy
	sts	LINESTEPY_H,SysValueCopy
;end if
ENDIF27:
;LineDiffX = LineStepX * LineDiffX
	lds	SysINTEGERTempA,LINESTEPX
	lds	SysINTEGERTempA_H,LINESTEPX_H
	lds	SysINTEGERTempB,LINEDIFFX
	lds	SysINTEGERTempB_H,LINEDIFFX_H
	rcall	SYSMULTSUBINT
	sts	LINEDIFFX,SysINTEGERTempX
	sts	LINEDIFFX_H,SysINTEGERTempX_H
;LineDiffY = LineStepY * LineDiffY
	lds	SysINTEGERTempA,LINESTEPY
	lds	SysINTEGERTempA_H,LINESTEPY_H
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	rcall	SYSMULTSUBINT
	sts	LINEDIFFY,SysINTEGERTempX
	sts	LINEDIFFY_H,SysINTEGERTempX_H
;LineDiffX_x2 = LineDiffX*2
	lds	SysINTEGERTempA,LINEDIFFX
	lds	SysINTEGERTempA_H,LINEDIFFX_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	rcall	SYSMULTSUBINT
	sts	LINEDIFFX_X2,SysINTEGERTempX
	sts	LINEDIFFX_X2_H,SysINTEGERTempX_H
;LineDiffY_x2 = LineDiffY*2
	lds	SysINTEGERTempA,LINEDIFFY
	lds	SysINTEGERTempA_H,LINEDIFFY_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	rcall	SYSMULTSUBINT
	sts	LINEDIFFY_X2,SysINTEGERTempX
	sts	LINEDIFFY_X2_H,SysINTEGERTempX_H
;if ( LineDiffX >= LineDiffY) then
	lds	SysINTEGERTempA,LINEDIFFX
	lds	SysINTEGERTempA_H,LINEDIFFX_H
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	rcall	SYSCOMPLESSTHANINT
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ELSE28_1
;LineErr = LineDiffY_x2 - LineDiffX
	lds	SysTemp1,LINEDIFFY_X2
	lds	SysTemp2,LINEDIFFX
	sub	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEDIFFY_X2_H
	lds	SysTemp2,LINEDIFFX_H
	sbc	SysTemp1,SysTemp2
	sts	LINEERR_H,SysTemp1
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S5:
	lds	SysWORDTempA,linex1
	lds	SysWORDTempA_H,linex1_H
	lds	SysWORDTempB,linex2
	lds	SysWORDTempB_H,linex2_H
	rcall	SYSCOMPEQUAL16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E5
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_SSD1309
;LineX1 += LineStepX
	lds	SysTemp1,LINEX1
	lds	SysTemp2,LINESTEPX
	add	SysTemp1,SysTemp2
	sts	LINEX1,SysTemp1
	lds	SysTemp1,LINEX1_H
	lds	SysTemp2,LINESTEPX_H
	adc	SysTemp1,SysTemp2
	sts	LINEX1_H,SysTemp1
;if ( LineErr < 0) then
	lds	SysINTEGERTempA,LINEERR
	lds	SysINTEGERTempA_H,LINEERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	rcall	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE29_1
;LineErr += LineDiffY_x2
	lds	SysTemp1,LINEERR
	lds	SysTemp2,LINEDIFFY_X2
	add	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEERR_H
	lds	SysTemp2,LINEDIFFY_X2_H
	adc	SysTemp1,SysTemp2
	sts	LINEERR_H,SysTemp1
;else
	rjmp	ENDIF29
ELSE29_1:
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	lds	SysTemp1,LINEDIFFY_X2
	lds	SysTemp3,LINEDIFFX_X2
	sub	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	lds	SysTemp1,LINEDIFFY_X2_H
	lds	SysTemp3,LINEDIFFX_X2_H
	sbc	SysTemp1,SysTemp3
	mov	SysTemp2_H,SysTemp1
	lds	SysTemp1,LINEERR
	add	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEERR_H
	adc	SysTemp1,SysTemp2_H
	sts	LINEERR_H,SysTemp1
;LineY1 += LineStepY
	lds	SysTemp1,LINEY1
	lds	SysTemp2,LINESTEPY
	add	SysTemp1,SysTemp2
	sts	LINEY1,SysTemp1
	lds	SysTemp1,LINEY1_H
	lds	SysTemp2,LINESTEPY_H
	adc	SysTemp1,SysTemp2
	sts	LINEY1_H,SysTemp1
;end if
ENDIF29:
;loop
	rjmp	SysDoLoop_S5
SysDoLoop_E5:
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_SSD1309
;else
	rjmp	ENDIF28
ELSE28_1:
;LineErr = LineDiffX_x2 - LineDiffY
	lds	SysTemp1,LINEDIFFX_X2
	lds	SysTemp2,LINEDIFFY
	sub	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEDIFFX_X2_H
	lds	SysTemp2,LINEDIFFY_H
	sbc	SysTemp1,SysTemp2
	sts	LINEERR_H,SysTemp1
;do while (   LineY1 <>  LineY2)
SysDoLoop_S6:
	lds	SysWORDTempA,liney1
	lds	SysWORDTempA_H,liney1_H
	lds	SysWORDTempB,liney2
	lds	SysWORDTempB_H,liney2_H
	rcall	SYSCOMPEQUAL16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E6
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_SSD1309
;LineY1 += LineStepY
	lds	SysTemp1,LINEY1
	lds	SysTemp2,LINESTEPY
	add	SysTemp1,SysTemp2
	sts	LINEY1,SysTemp1
	lds	SysTemp1,LINEY1_H
	lds	SysTemp2,LINESTEPY_H
	adc	SysTemp1,SysTemp2
	sts	LINEY1_H,SysTemp1
;if ( LineErr < 0) then
	lds	SysINTEGERTempA,LINEERR
	lds	SysINTEGERTempA_H,LINEERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	rcall	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE30_1
;LineErr += LineDiffX_x2
	lds	SysTemp1,LINEERR
	lds	SysTemp2,LINEDIFFX_X2
	add	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEERR_H
	lds	SysTemp2,LINEDIFFX_X2_H
	adc	SysTemp1,SysTemp2
	sts	LINEERR_H,SysTemp1
;else
	rjmp	ENDIF30
ELSE30_1:
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	lds	SysTemp1,LINEDIFFX_X2
	lds	SysTemp3,LINEDIFFY_X2
	sub	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	lds	SysTemp1,LINEDIFFX_X2_H
	lds	SysTemp3,LINEDIFFY_X2_H
	sbc	SysTemp1,SysTemp3
	mov	SysTemp2_H,SysTemp1
	lds	SysTemp1,LINEERR
	add	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEERR_H
	adc	SysTemp1,SysTemp2_H
	sts	LINEERR_H,SysTemp1
;LineX1 += LineStepX
	lds	SysTemp1,LINEX1
	lds	SysTemp2,LINESTEPX
	add	SysTemp1,SysTemp2
	sts	LINEX1,SysTemp1
	lds	SysTemp1,LINEX1_H
	lds	SysTemp2,LINESTEPX_H
	adc	SysTemp1,SysTemp2
	sts	LINEX1_H,SysTemp1
;end if
ENDIF30:
;loop
	rjmp	SysDoLoop_S6
SysDoLoop_E6:
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_SSD1309
;end if
ENDIF28:
	ret

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:long:, Source: picas.h (110)
_LINE71:
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFX,SysValueCopy
	sts	LINEDIFFX_H,SysValueCopy
;LineDiffY = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFY,SysValueCopy
	sts	LINEDIFFY_H,SysValueCopy
;LineStepX = 0
	ldi	SysValueCopy,0
	sts	LINESTEPX,SysValueCopy
	sts	LINESTEPX_H,SysValueCopy
;LineStepY = 0
	ldi	SysValueCopy,0
	sts	LINESTEPY,SysValueCopy
	sts	LINESTEPY_H,SysValueCopy
;LineDiffX_x2 = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFX_X2,SysValueCopy
	sts	LINEDIFFX_X2_H,SysValueCopy
;LineDiffY_x2 = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFY_X2,SysValueCopy
	sts	LINEDIFFY_X2_H,SysValueCopy
;LineErr = 0
	ldi	SysValueCopy,0
	sts	LINEERR,SysValueCopy
	sts	LINEERR_H,SysValueCopy
;LineDiffX =  LineX2 -   LineX1
	lds	SysTemp1,LINEX2
	lds	SysTemp2,LINEX1
	sub	SysTemp1,SysTemp2
	sts	LINEDIFFX,SysTemp1
	lds	SysTemp1,LINEX2_H
	lds	SysTemp2,LINEX1_H
	sbc	SysTemp1,SysTemp2
	sts	LINEDIFFX_H,SysTemp1
;LineDiffY =  LineY2 -   LineY1
	lds	SysTemp1,LINEY2
	lds	SysTemp2,LINEY1
	sub	SysTemp1,SysTemp2
	sts	LINEDIFFY,SysTemp1
	lds	SysTemp1,LINEY2_H
	lds	SysTemp2,LINEY1_H
	sbc	SysTemp1,SysTemp2
	sts	LINEDIFFY_H,SysTemp1
;if (LineDiffX > 0) then
	lds	SysINTEGERTempB,LINEDIFFX
	lds	SysINTEGERTempB_H,LINEDIFFX_H
	ldi	SysINTEGERTempA,0
	ldi	SysINTEGERTempA_H,0
	rcall	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE31_1
;LineStepX = 1
	ldi	SysValueCopy,1
	sts	LINESTEPX,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPX_H,SysValueCopy
;else
	rjmp	ENDIF31
ELSE31_1:
;LineStepX = -1
	ldi	SysValueCopy,255
	sts	LINESTEPX,SysValueCopy
	sts	LINESTEPX_H,SysValueCopy
;end if
ENDIF31:
;if (LineDiffY > 0) then
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	ldi	SysINTEGERTempA,0
	ldi	SysINTEGERTempA_H,0
	rcall	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE32_1
;LineStepY = 1
	ldi	SysValueCopy,1
	sts	LINESTEPY,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPY_H,SysValueCopy
;else
	rjmp	ENDIF32
ELSE32_1:
;LineStepY = -1
	ldi	SysValueCopy,255
	sts	LINESTEPY,SysValueCopy
	sts	LINESTEPY_H,SysValueCopy
;end if
ENDIF32:
;LineDiffX = LineStepX * LineDiffX
	lds	SysINTEGERTempA,LINESTEPX
	lds	SysINTEGERTempA_H,LINESTEPX_H
	lds	SysINTEGERTempB,LINEDIFFX
	lds	SysINTEGERTempB_H,LINEDIFFX_H
	rcall	SYSMULTSUBINT
	sts	LINEDIFFX,SysINTEGERTempX
	sts	LINEDIFFX_H,SysINTEGERTempX_H
;LineDiffY = LineStepY * LineDiffY
	lds	SysINTEGERTempA,LINESTEPY
	lds	SysINTEGERTempA_H,LINESTEPY_H
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	rcall	SYSMULTSUBINT
	sts	LINEDIFFY,SysINTEGERTempX
	sts	LINEDIFFY_H,SysINTEGERTempX_H
;LineDiffX_x2 = LineDiffX*2
	lds	SysINTEGERTempA,LINEDIFFX
	lds	SysINTEGERTempA_H,LINEDIFFX_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	rcall	SYSMULTSUBINT
	sts	LINEDIFFX_X2,SysINTEGERTempX
	sts	LINEDIFFX_X2_H,SysINTEGERTempX_H
;LineDiffY_x2 = LineDiffY*2
	lds	SysINTEGERTempA,LINEDIFFY
	lds	SysINTEGERTempA_H,LINEDIFFY_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	rcall	SYSMULTSUBINT
	sts	LINEDIFFY_X2,SysINTEGERTempX
	sts	LINEDIFFY_X2_H,SysINTEGERTempX_H
;if ( LineDiffX >= LineDiffY) then
	lds	SysINTEGERTempA,LINEDIFFX
	lds	SysINTEGERTempA_H,LINEDIFFX_H
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	rcall	SYSCOMPLESSTHANINT
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ELSE33_1
;LineErr = LineDiffY_x2 - LineDiffX
	lds	SysTemp1,LINEDIFFY_X2
	lds	SysTemp2,LINEDIFFX
	sub	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEDIFFY_X2_H
	lds	SysTemp2,LINEDIFFX_H
	sbc	SysTemp1,SysTemp2
	sts	LINEERR_H,SysTemp1
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S7:
	lds	SysWORDTempA,linex1
	lds	SysWORDTempA_H,linex1_H
	lds	SysWORDTempB,linex2
	lds	SysWORDTempB_H,linex2_H
	rcall	SYSCOMPEQUAL16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E7
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_SSD1309
;LineX1 += LineStepX
	lds	SysTemp1,LINEX1
	lds	SysTemp2,LINESTEPX
	add	SysTemp1,SysTemp2
	sts	LINEX1,SysTemp1
	lds	SysTemp1,LINEX1_H
	lds	SysTemp2,LINESTEPX_H
	adc	SysTemp1,SysTemp2
	sts	LINEX1_H,SysTemp1
;if ( LineErr < 0) then
	lds	SysINTEGERTempA,LINEERR
	lds	SysINTEGERTempA_H,LINEERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	rcall	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE34_1
;LineErr += LineDiffY_x2
	lds	SysTemp1,LINEERR
	lds	SysTemp2,LINEDIFFY_X2
	add	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEERR_H
	lds	SysTemp2,LINEDIFFY_X2_H
	adc	SysTemp1,SysTemp2
	sts	LINEERR_H,SysTemp1
;else
	rjmp	ENDIF34
ELSE34_1:
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	lds	SysTemp1,LINEDIFFY_X2
	lds	SysTemp3,LINEDIFFX_X2
	sub	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	lds	SysTemp1,LINEDIFFY_X2_H
	lds	SysTemp3,LINEDIFFX_X2_H
	sbc	SysTemp1,SysTemp3
	mov	SysTemp2_H,SysTemp1
	lds	SysTemp1,LINEERR
	add	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEERR_H
	adc	SysTemp1,SysTemp2_H
	sts	LINEERR_H,SysTemp1
;LineY1 += LineStepY
	lds	SysTemp1,LINEY1
	lds	SysTemp2,LINESTEPY
	add	SysTemp1,SysTemp2
	sts	LINEY1,SysTemp1
	lds	SysTemp1,LINEY1_H
	lds	SysTemp2,LINESTEPY_H
	adc	SysTemp1,SysTemp2
	sts	LINEY1_H,SysTemp1
;end if
ENDIF34:
;loop
	rjmp	SysDoLoop_S7
SysDoLoop_E7:
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_SSD1309
;else
	rjmp	ENDIF33
ELSE33_1:
;LineErr = LineDiffX_x2 - LineDiffY
	lds	SysTemp1,LINEDIFFX_X2
	lds	SysTemp2,LINEDIFFY
	sub	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEDIFFX_X2_H
	lds	SysTemp2,LINEDIFFY_H
	sbc	SysTemp1,SysTemp2
	sts	LINEERR_H,SysTemp1
;do while (   LineY1 <>  LineY2)
SysDoLoop_S8:
	lds	SysWORDTempA,liney1
	lds	SysWORDTempA_H,liney1_H
	lds	SysWORDTempB,liney2
	lds	SysWORDTempB_H,liney2_H
	rcall	SYSCOMPEQUAL16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E8
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_SSD1309
;LineY1 += LineStepY
	lds	SysTemp1,LINEY1
	lds	SysTemp2,LINESTEPY
	add	SysTemp1,SysTemp2
	sts	LINEY1,SysTemp1
	lds	SysTemp1,LINEY1_H
	lds	SysTemp2,LINESTEPY_H
	adc	SysTemp1,SysTemp2
	sts	LINEY1_H,SysTemp1
;if ( LineErr < 0) then
	lds	SysINTEGERTempA,LINEERR
	lds	SysINTEGERTempA_H,LINEERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	rcall	SYSCOMPLESSTHANINT
	sbrs	SysByteTempX,0
	rjmp	ELSE35_1
;LineErr += LineDiffX_x2
	lds	SysTemp1,LINEERR
	lds	SysTemp2,LINEDIFFX_X2
	add	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEERR_H
	lds	SysTemp2,LINEDIFFX_X2_H
	adc	SysTemp1,SysTemp2
	sts	LINEERR_H,SysTemp1
;else
	rjmp	ENDIF35
ELSE35_1:
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	lds	SysTemp1,LINEDIFFX_X2
	lds	SysTemp3,LINEDIFFY_X2
	sub	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	lds	SysTemp1,LINEDIFFX_X2_H
	lds	SysTemp3,LINEDIFFY_X2_H
	sbc	SysTemp1,SysTemp3
	mov	SysTemp2_H,SysTemp1
	lds	SysTemp1,LINEERR
	add	SysTemp1,SysTemp2
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEERR_H
	adc	SysTemp1,SysTemp2_H
	sts	LINEERR_H,SysTemp1
;LineX1 += LineStepX
	lds	SysTemp1,LINEX1
	lds	SysTemp2,LINESTEPX
	add	SysTemp1,SysTemp2
	sts	LINEX1,SysTemp1
	lds	SysTemp1,LINEX1_H
	lds	SysTemp2,LINESTEPX_H
	adc	SysTemp1,SysTemp2
	sts	LINEX1_H,SysTemp1
;end if
ENDIF35:
;loop
	rjmp	SysDoLoop_S8
SysDoLoop_E8:
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_SSD1309
;end if
ENDIF33:
	ret

;********************************************************************************


