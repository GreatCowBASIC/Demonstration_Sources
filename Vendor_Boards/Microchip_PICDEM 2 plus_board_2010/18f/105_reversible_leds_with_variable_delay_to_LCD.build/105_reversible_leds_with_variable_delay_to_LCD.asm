;Program compiled by GCBASIC (2026.08.07 (Windows 64 bit) : Build 1617) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-08-07 CRC247
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\105_reversible_leds_with_variable_delay_to_LCD.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\105_reversible_leds_with_variable_delay_to_LCD.build\105_reversible_leds_with_variable_delay_to_LCD.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\105_reversible_leds_with_variable_delay_to_LCD.gcb"
 SUBTITLE    "08-12-2026 07:19:34"
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
ADREADPORT                       EQU    1293          ; 0x50D (SA)
BYTENUM                          EQU    1294          ; 0x50E (SA)
BYTETOBIN                        EQU    5272          ; 0x1498
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
LCD2BYTE                         EQU    1295          ; 0x50F (SA)
LCDBYTE                          EQU    1296          ; 0x510 (SA)
LCDCOLUMN                        EQU    1297          ; 0x511 (SA)
LCDLINE                          EQU    1298          ; 0x512 (SA)
LCDTEMPRWCOUNT                   EQU    1299          ; 0x513 (SA)
LCDVALUE                         EQU    1300          ; 0x514 (SA)
LCDVALUETEMP                     EQU    1301          ; 0x515 (SA)
LCD_STATE                        EQU    1302          ; 0x516 (SA)
LEDPORTSTATE                     EQU    1303          ; 0x517 (SA)
LEFT                             EQU    5335          ; 0x14D7
L_CALIBRATE                      EQU    1304          ; 0x518 (SA)
L_CALIBRATE_H                    EQU    1305          ; 0x519 (SA)
L_FROMHIGH                       EQU    1306          ; 0x51A (SA)
L_FROMHIGH_H                     EQU    1307          ; 0x51B (SA)
L_FROMLOW                        EQU    1308          ; 0x51C (SA)
L_FROMLOW_H                      EQU    1309          ; 0x51D (SA)
L_MAP                            EQU    1310          ; 0x51E (SA)
L_MAP_H                          EQU    1311          ; 0x51F (SA)
L_SYSCALC                        EQU    1312          ; 0x520 (SA)
L_SYSCALCF                       EQU    1314          ; 0x522 (SA)
L_SYSCALCF_E                     EQU    1317          ; 0x525 (SA)
L_SYSCALCF_H                     EQU    1315          ; 0x523 (SA)
L_SYSCALCF_U                     EQU    1316          ; 0x524 (SA)
L_SYSCALC_H                      EQU    1313          ; 0x521 (SA)
L_TOHIGH                         EQU    1318          ; 0x526 (SA)
L_TOHIGH_H                       EQU    1319          ; 0x527 (SA)
L_TOLOW                          EQU    1320          ; 0x528 (SA)
L_TOLOW_H                        EQU    1321          ; 0x529 (SA)
MYDELAY                          EQU    1322          ; 0x52A (SA)
MYDELAY_H                        EQU    1323          ; 0x52B (SA)
PRINTLEN                         EQU    1324          ; 0x52C (SA)
READAD                           EQU    1325          ; 0x52D (SA)
RIGHT                            EQU    5294          ; 0x14AE
SCALE                            EQU    1326          ; 0x52E (SA)
SCALE_H                          EQU    1327          ; 0x52F (SA)
STR                              EQU    5266          ; 0x1492
STRINGPOINTER                    EQU    1328          ; 0x530 (SA)
SYSARRAYTEMP1                    EQU    1329          ; 0x531 (SA)
SYSARRAYTEMP2                    EQU    1330          ; 0x532 (SA)
SYSBITVAR0                       EQU    1331          ; 0x533 (SA)
SYSBYTETEMPA                     EQU    1285          ; 0x505 (SA)
SYSBYTETEMPB                     EQU    1289          ; 0x509 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPA                     EQU    1285          ; 0x505 (SA)
SYSCALCTEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPX_H                   EQU    1281          ; 0x501 (SA)
SYSCHARCOUNT                     EQU    1332          ; 0x534 (SA)
SYSCHARSTART                     EQU    1333          ; 0x535 (SA)
SYSDIVLOOP                       EQU    1284          ; 0x504 (SA)
SYSDIVMULTA                      EQU    1287          ; 0x507 (SA)
SYSDIVMULTA_H                    EQU    1288          ; 0x508 (SA)
SYSDIVMULTB                      EQU    1291          ; 0x50B (SA)
SYSDIVMULTB_H                    EQU    1292          ; 0x50C (SA)
SYSDIVMULTX                      EQU    1282          ; 0x502 (SA)
SYSDIVMULTX_H                    EQU    1283          ; 0x503 (SA)
SYSLCDTEMP                       EQU    1334          ; 0x536 (SA)
SYSLONGDIVMULTA                  EQU    1335          ; 0x537 (SA)
SYSLONGDIVMULTA_E                EQU    1338          ; 0x53A (SA)
SYSLONGDIVMULTA_H                EQU    1336          ; 0x538 (SA)
SYSLONGDIVMULTA_U                EQU    1337          ; 0x539 (SA)
SYSLONGDIVMULTB                  EQU    1339          ; 0x53B (SA)
SYSLONGDIVMULTB_E                EQU    1342          ; 0x53E (SA)
SYSLONGDIVMULTB_H                EQU    1340          ; 0x53C (SA)
SYSLONGDIVMULTB_U                EQU    1341          ; 0x53D (SA)
SYSLONGDIVMULTX                  EQU    1343          ; 0x53F (SA)
SYSLONGDIVMULTX_E                EQU    1346          ; 0x542 (SA)
SYSLONGDIVMULTX_H                EQU    1344          ; 0x540 (SA)
SYSLONGDIVMULTX_U                EQU    1345          ; 0x541 (SA)
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
SYSPRINTDATAHANDLER              EQU    1347          ; 0x543 (SA)
SYSPRINTDATAHANDLER_H            EQU    1348          ; 0x544 (SA)
SYSPRINTTEMP                     EQU    1349          ; 0x545 (SA)
SYSREPEATTEMP1                   EQU    1350          ; 0x546 (SA)
SYSSTRDATA                       EQU    1351          ; 0x547 (SA)
SYSSTRINGA                       EQU    1287          ; 0x507 (SA)
SYSSTRINGA_H                     EQU    1288          ; 0x508 (SA)
SYSSTRINGLENGTH                  EQU    1286          ; 0x506 (SA)
SYSSTRINGPARAM1                  EQU    5281          ; 0x14A1
SYSSTRINGTEMP                    EQU    1352          ; 0x548
SYSSYSINSTRINGHANDLER            EQU    1353          ; 0x549 (SA)
SYSSYSINSTRINGHANDLER_H          EQU    1354          ; 0x54A (SA)
SYSTEMP1                         EQU    1355          ; 0x54B (SA)
SYSTEMP1_E                       EQU    1358          ; 0x54E (SA)
SYSTEMP1_H                       EQU    1356          ; 0x54C (SA)
SYSTEMP1_U                       EQU    1357          ; 0x54D (SA)
SYSTEMP2                         EQU    1359          ; 0x54F (SA)
SYSTEMP2_H                       EQU    1360          ; 0x550 (SA)
SYSTEMP3                         EQU    1361          ; 0x551 (SA)
SYSVALTEMP                       EQU    1362          ; 0x552 (SA)
SYSVALTEMP_H                     EQU    1363          ; 0x553 (SA)
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

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
SYSLEFT_0 EQU 5335
SYSREADADBYTE EQU 1325
SYSRIGHT_0 EQU 5294
SYSSCALEWORD EQU 1326
SYSSCALEWORD_H EQU 1327
SYSSTR_0 EQU 5266

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
	rcall	INIT_OCULAR_OM1614_LCD

;Start_of_the_main_program
;
;************************************************************************
;Q35 Series LCD LED Chaser Demonstration
;************************************************************************
;
;A demonstration program for GCBASIC.
;
;This program demonstrates the capabilities of the board. This is the
;basic test - it drives a 4-bit LED "chaser" pattern (left/right shift)
;on PORTB, with direction controlled by a push-button input and speed
;controlled by a potentiometer on the ADC input, while showing status
;and values on an attached character LCD (Ocular OM1614, 4-bit mode).
;
;Target device : PIC18F46Q35 (Q35 family)
;Compiler      : GCBASIC 2026 (or later)
;
;------------------------------------------------------------------------
;Hardware summary
;------------------------------------------------------------------------
;- PORTA.0        : Potentiometer (ADC input, speed control)
;- PORTA.4        : Direction switch input (active low)
;- PORTB.0..3     : LEDs (chaser output)
;- PORTC.6        : UART1 TX (reference only, unused by this demo)
;- PORTC.7        : VDD reference marker (see pin map below)
;- PORTD.0..3     : LCD data lines DB4-DB7 (4-bit mode)
;- PORTD.4        : LCD RS
;- PORTD.5        : LCD RW
;- PORTD.6        : LCD Enable
;- PORTD.7        : LCD Power enable
;- PORTE.3        : Reset button input (input only pin)
;
;------------------------------------------------------------------------
;IMPORTANT - Power configuration
;------------------------------------------------------------------------
;!! VDDIO2 IS CRITICAL FOR OPERATION !!
;On the PIC18F46Q35 (and related Q43/Q35 family parts), the VDDIO2 pin
;supplies power to a secondary I/O bank on the device. If VDDIO2 is not
;correctly connected to the supply rail (per the datasheet electrical
;and pin-out specifications), the associated I/O pins - including those
;used here for the LCD and LED interfaces - will not function correctly,
;and the chip may not operate reliably even though the primary VDD/VSS
;pins are powered correctly.
;Always verify VDDIO2 is wired to VDD (or the correct supply level) on
;your board before troubleshooting "dead" I/O, a blank LCD, or
;unexpected resets.
;
;------------------------------------------------------------------------
;@author 	EvanV
;@licence	GPL
;@version	1.01
;@date   	09.08.2026
;------------------------------------------------------------------------
;*******************************************************************************
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
;IO:    VDD-TX---------------------------
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
;------------------------------------------------------------------------
;IMPORTANT - Switch polarity
;------------------------------------------------------------------------
;DOWN must equal whatever SWITCHIN reads WHEN THE BUTTON IS PHYSICALLY
;PRESSED, not when it's at rest. Get this backwards and the "press" edge
;detection in funcKeyPressed() will fire on release instead of on press,
;even though the debounce/edge-detection logic itself is correct.
;
;Most switch circuits use a pull-up resistor to VDD with the switch
;connecting the pin to ground when pressed. In that layout:
;- At rest (not pressed):  SWITCHIN reads 1 (HIGH)
;- Pressed:                SWITCHIN reads 0 (LOW)
;That is the wiring assumed below (DOWN = 0), and matches the "active
;low" note in the hardware summary above.
;
;If your circuit instead pulls the pin LOW at rest and the switch pulls
;it HIGH when pressed, change this to #DEFINE DOWN 1.
;
;To verify: probe PORTA.4 with a meter, or just try one polarity - if
;direction reverses on release instead of press, flip this value.
;------------------------------------------------------------------------
;Dir     RSTBUTTON     In  // this is set automatically - and, you cannot set as an output
	bsf	TRISE,3,BANKED
;Setup LCD Parameters
;! Specify explicit OCULAR_OM1614 support!!
;! Required for OCULAR LCD driver
;Define LCD Hardware settings
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Print "GCBASIC 2026"
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
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
;Using SYSSTRINGPARAM1*12
	rcall	PRINT119
;Wait 2 s: CLS
	movlw	2
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;Wait 2 s: CLS
	rcall	CLS
;Print ChipNameStr
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable153
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable153
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable153
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
;Using SYSSTRINGPARAM1*8
	rcall	PRINT119
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print ChipMHz
	movlw	64
	movwf	LCDVALUE,ACCESS
	rcall	PRINT120
;Print "mHz"
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
;Using SYSSTRINGPARAM1*3
	rcall	PRINT119
;Wait 1 s: CLS
	movlw	1
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;Wait 1 s: CLS
	rcall	CLS
;Dim direction As Bit
;Dim mydelay As Word
;Dim LEDportState as Byte
;Declare LastSwitchState globally so it persists between calls to
;funcKeyPressed().
;Dim LastSwitchState As Bit
;LastSwitchState = FALSE
	bcf	SYSBITVAR0,1,ACCESS
;Control Constants
;Start from left direction
;direction = LED_LEFT
	bsf	SYSBITVAR0,0,ACCESS
;Set the initial LED states - change to suit your configuration
;LEDportState = 1
	movlw	1
	movwf	LEDPORTSTATE,ACCESS
;Main loop
;Do
SysDoLoop_S1
;Locate 0, 0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Get a value for the ADC port
;mydelay = ReadAD( ANA0 )
	clrf	ADREADPORT,ACCESS
	rcall	FN_READAD6
	movff	SYSREADADBYTE,MYDELAY
	clrf	MYDELAY_H,ACCESS
;mydelay = scale( mydelay, 0, 255, 50, 1000 )
	movff	MYDELAY,L_MAP
	movff	MYDELAY_H,L_MAP_H
	clrf	L_FROMLOW,ACCESS
	clrf	L_FROMLOW_H,ACCESS
	setf	L_FROMHIGH,ACCESS
	clrf	L_FROMHIGH_H,ACCESS
	movlw	50
	movwf	L_TOLOW,ACCESS
	clrf	L_TOLOW_H,ACCESS
	movlw	232
	movwf	L_TOHIGH,ACCESS
	movlw	3
	movwf	L_TOHIGH_H,ACCESS
	clrf	L_CALIBRATE,ACCESS
	clrf	L_CALIBRATE_H,ACCESS
	rcall	FN_SCALE79
	movff	SYSSCALEWORD,MYDELAY
	movff	SYSSCALEWORD_H,MYDELAY_H
;Set the port and only the state of our LEDs
;LATB = LEDportState AND 0b00001111
	movlw	15
	andwf	LEDPORTSTATE,W,ACCESS
	banksel	LATB
	movwf	LATB,BANKED
;Show state on LCD
;Locate 0,5
	clrf	LCDLINE,ACCESS
	movlw	5
	movwf	LCDCOLUMN,ACCESS
	banksel	0
	rcall	LOCATE
;Print Right(ByteToBin ( LEDportState ),4)
	movff	LEDPORTSTATE,BYTENUM
	rcall	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	4
	movwf	SYSCHARCOUNT,ACCESS
	rcall	FN_RIGHT
	movlw	low RIGHT
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high RIGHT
	movwf	SysPRINTDATAHandler_H,ACCESS
	rcall	PRINT119
;Print " "
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
;Using SYSSTRINGPARAM1*1
	rcall	PRINT119
;Print Left( Str(mydelay)+"    ",4)
	movff	MYDELAY,SYSVALTEMP
	movff	MYDELAY_H,SYSVALTEMP_H
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	4
	movwf	SYSCHARCOUNT,ACCESS
;Using SYSSTRINGPARAM1*0
	rcall	FN_LEFT
	lfsr	1,SYSSTRINGPARAM1
	lfsr	0,LEFT
	call	SYSCOPYSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
;Using SYSSTRINGPARAM1*0
	rcall	PRINT119
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Wait, and then check the switch has been pressed
;Wait mydelay ms
	movff	MYDELAY,SysWaitTempMS
	movff	MYDELAY_H,SysWaitTempMS_H
	rcall	Delay_MS
;Manage the direction
;funcKeyPressed() returns TRUE only once per press - at the instant
;the switch transitions from released to pressed (the rising edge).
;It will not re-trigger while the switch is held down, and it
;never triggers on release.
;If  funcKeyPressed() = TRUE Then
	rcall	FN_FUNCKEYPRESSED
	btfss	SYSBITVAR0,2,ACCESS
	bra	ENDIF1
;change the direction
;direction = !direction
	clrf	SysTemp1,ACCESS
	btfsc	SYSBITVAR0,0,ACCESS
	incf	SysTemp1,F,ACCESS
	comf	SysTemp1,F,ACCESS
	bcf	SYSBITVAR0,0,ACCESS
	btfsc	SysTemp1,0,ACCESS
	bsf	SYSBITVAR0,0,ACCESS
;End If
ENDIF1
;Set the LEDs
;If  direction = LED_LEFT  Then
	btfss	SYSBITVAR0,0,ACCESS
	bra	ELSE2_1
;Print "<L:"
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
;Using SYSSTRINGPARAM1*3
	rcall	PRINT119
;If LEDportState.3 = 1 then
	btfss	LEDPORTSTATE,3,ACCESS
	bra	ELSE3_1
;LEDportState = 0
	clrf	LEDPORTSTATE,ACCESS
;C = 1
	bsf	STATUS,C,ACCESS
;Else
	bra	ENDIF3
ELSE3_1
;C = 0
	bcf	STATUS,C,ACCESS
;End If
ENDIF3
;shift the contents of LEDportState
;Rotate LEDportState Left
	rlcf	LEDPORTSTATE,F,ACCESS
;Else
	bra	ENDIF2
ELSE2_1
;Print ">R:"
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
;Using SYSSTRINGPARAM1*3
	rcall	PRINT119
;shift the contents of LEDportState
;C = 0
	bcf	STATUS,C,ACCESS
;Rotate LEDportState Right
	rrcf	LEDPORTSTATE,F,ACCESS
;If C = 1 Then LEDportState.3 = 1
	btfsc	STATUS,C,ACCESS
;If C = 1 Then LEDportState.3 = 1
	bsf	LEDPORTSTATE,3,ACCESS
;If C = 1 Then LEDportState.3 = 1
;End If
ENDIF2
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;
;Explanation:
;
;Variable Definition:
;`CurrentSwitchState` is declared locally as a Bit to store the current state.
;`LastSwitchState` is declared globally, above the main Do loop, so it retains
;its value between function calls (GCBASIC local variables do NOT persist
;between calls - declaring it inside the function, as in earlier versions of
;this code, caused it to reset to FALSE every time and re-trigger on every
;iteration while the button was held down).
;
;Debouncing:
;A small delay (wait 1 ms) is introduced to debounce the switch,
;filtering out mechanical contact bounce before the pin is sampled.
;
;Switch State Reading:
;The state of the switch is read using SWITCHIN = DOWN.
;If the switch is pressed, CurrentSwitchState is set to TRUE; otherwise, it is set to FALSE.
;
;Press (Rising-Edge) Detection:
;The function only reports TRUE at the exact moment the switch goes
;from released (FALSE) to pressed (TRUE) - i.e. CurrentSwitchState = TRUE
;AND LastSwitchState = FALSE. This means a press is detected once, and
;once only, when it happens: never on release, and never repeatedly
;while the switch is held down.
;
;State Tracking:
;LastSwitchState is updated on every call (whether or not a press was
;detected) so the next call always has an accurate previous state to
;compare against.
;
;This function returns TRUE only at the instant the switch is pressed
;(i.e. on the rising edge, when the switch transitions from released to
;pressed). It ignores the release transition entirely, and requires
;LastSwitchState to be declared globally (see above) to work correctly.
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: string.h (1171)
FN_BYTETOBIN
;ByteToBin = ""
	lfsr	1,BYTETOBIN
	movlw	low StringTable63
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable63
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable63
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
;Repeat 8
	movlw	8
	movwf	SysRepeatTemp1,ACCESS
SysRepeatLoop1
;If ByteNum.7 = 1 Then
	btfss	BYTENUM,7,ACCESS
	bra	ELSE48_1
;ByteToBin = ByteToBin +"1"
	lfsr	1,BYTETOBIN
	clrf	SysStringLength,ACCESS
	lfsr	0,BYTETOBIN
	call	SYSCOPYSTRINGPART
	movlw	low StringTable67
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable67
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable67
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,BYTETOBIN
	movff	SysStringLength, INDF0
;Else
	bra	ENDIF48
ELSE48_1
;ByteToBin = ByteToBin +"0"
	lfsr	1,BYTETOBIN
	clrf	SysStringLength,ACCESS
	lfsr	0,BYTETOBIN
	call	SYSCOPYSTRINGPART
	movlw	low StringTable68
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable68
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable68
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,BYTETOBIN
	movff	SysStringLength, INDF0
;End If
ENDIF48
;Rotate ByteNum Left
	rlcf	BYTENUM,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

;Source: lcd.h (1231)
CHECKBUSYFLAG
;Sub that waits until LCD controller busy flag goes low (ready)
;Only used by LCD_IO 4,8 and only when LCD_NO_RW is NOT Defined
;Called by sub LCDNOrmalWriteByte
;Dim LCDTEMPRWCount
;LCD_RSTemp = LCD_RS
	bcf	SYSLCDTEMP,2,ACCESS
	banksel	PORTD
	btfsc	PORTD,4,BANKED
	bsf	SYSLCDTEMP,2,ACCESS
;DIR SCRIPT_LCD_BF IN
	bsf	TRISD,3,BANKED
;SET LCD_RS OFF
	bcf	LATD,4,BANKED
;SET LCD_RW ON
	bsf	LATD,5,BANKED
;LCDTEMPRWCount = 0
	clrf	LCDTEMPRWCOUNT,ACCESS
;Do
SysDoLoop_S2
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS14
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS14
;Set LCD_Enable ON
	bsf	LATD,6,BANKED
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS15
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS15
;SysLCDTemp.7 = SCRIPT_LCD_BF
	bcf	SYSLCDTEMP,7,ACCESS
	btfsc	PORTD,3,BANKED
	bsf	SYSLCDTEMP,7,ACCESS
;Set LCD_Enable OFF
	bcf	LATD,6,BANKED
;Wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS16
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS16
;PulseOut LCD_Enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6,BANKED
;WaitL1 Time
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS17
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS17
;Set Pin Off
	bcf	LATD,6,BANKED
;Wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS18
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS18
;if LCDTEMPRWCount = 255 Then SysLCDTemp.7 = 0
	incf	LCDTEMPRWCOUNT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;if LCDTEMPRWCount = 255 Then SysLCDTemp.7 = 0
	bcf	SYSLCDTEMP,7,ACCESS
;if LCDTEMPRWCount = 255 Then SysLCDTemp.7 = 0
;LCDTEMPRWCount++
	incf	LCDTEMPRWCOUNT,F,ACCESS
;Loop While SysLCDTemp.7 <> 0
	btfsc	SYSLCDTEMP,7,ACCESS
	bra	SysDoLoop_S2
SysDoLoop_E2
;LCD_RS = LCD_RSTemp
	bcf	LATD,4,BANKED
	btfsc	SYSLCDTEMP,2,ACCESS
	bsf	LATD,4,BANKED
	banksel	0
	return

;********************************************************************************

;Source: lcd.h (614)
CLS
;Sub to clear the LCD
;SET LCD_RS OFF
	banksel	LATD
	bcf	LATD,4,BANKED
;Clear screen
;LCDWriteByte (0b00000001)
	movlw	1
	movwf	LCDBYTE,ACCESS
	banksel	0
	rcall	LCDNORMALWRITEBYTE
;Wait 4 ms
	movlw	4
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Move to start of visible DDRAM
;LCDWriteByte(0x80)
	movlw	128
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;Wait 50 us
	movlw	1
	movwf	DELAYTEMP2,ACCESS
DelayUSO1
	clrf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
	decfsz	DELAYTEMP2,F,ACCESS
	bra	DelayUSO1
	movlw	9
	movwf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
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

;Source: 105_reversible_leds_with_variable_delay_to_LCD.gcb (280)
FN_FUNCKEYPRESSED
;Define local variable
;Dim CurrentSwitchState As Bit
;wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Is the switch pressed down ?
;If ( SWITCHIN = DOWN ) Then
	banksel	PORTA
	btfsc	PORTA,4,BANKED
	bra	ELSE7_1
;Set the state
;CurrentSwitchState = TRUE
	bsf	SYSBITVAR0,3,ACCESS
;Else
	bra	ENDIF7
ELSE7_1
;So, switch is therefore UP/released
;CurrentSwitchState = FALSE
	bcf	SYSBITVAR0,3,ACCESS
;End If
ENDIF7
;Only report a "press" on the rising edge: switch was up last time,
;and is down now. This deliberately excludes the release transition
;(down -> up), so direction changes on press, not on release.
;If ( CurrentSwitchState = TRUE ) AND ( LastSwitchState = FALSE ) Then
	clrf	SysByteTempX,ACCESS
	btfsc	SYSBITVAR0,3,ACCESS
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	clrf	SysByteTempX,ACCESS
	btfss	SYSBITVAR0,1,ACCESS
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp2
	movf	SysTemp1,W,ACCESS
	andwf	SysTemp2,W,ACCESS
	movwf	SysTemp3,ACCESS
	btfss	SysTemp3,0,ACCESS
	bra	ELSE8_1
;Return the state value - returns TRUE
;funcKeyPressed = TRUE
	bsf	SYSBITVAR0,2,ACCESS
;Else
	bra	ENDIF8
ELSE8_1
;Switch is not newly pressed
;funcKeyPressed = FALSE
	bcf	SYSBITVAR0,2,ACCESS
;End If
ENDIF8
;Always update the last known state so the next call can correctly
;detect the next press edge.
;LastSwitchState = CurrentSwitchState
	bcf	SYSBITVAR0,1,ACCESS
	btfsc	SYSBITVAR0,3,ACCESS
	bsf	SYSBITVAR0,1,ACCESS
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

;Source: lcd.h (3032)
INIT_OCULAR_OM1614_LCD
;`LCD_Speed is SLOW`
;`OPTIMAL is set to ` OPTIMAL
;`LCD_Speed is set to ` LCD_Speed
;Dir LCD_POWER OUT
	banksel	TRISD
	bcf	TRISD,7,BANKED
;Set LCD_POWER ON
	bsf	LATD,7,BANKED
;Wait 50 ms
	movlw	50
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	banksel	0
	rcall	Delay_MS
;Dir LCD_RW OUT
	banksel	TRISD
	bcf	TRISD,5,BANKED
;Set LCD_RW OFF
	bcf	LATD,5,BANKED
;Dir LCD_DB4 OUT
	bcf	TRISD,0,BANKED
;Dir LCD_DB5 OUT
	bcf	TRISD,1,BANKED
;Dir LCD_DB6 OUT
	bcf	TRISD,2,BANKED
;Dir LCD_DB7 OUT
	bcf	TRISD,3,BANKED
;Dir LCD_RS      OUT
	bcf	TRISD,4,BANKED
;Dir LCD_Enable  OUT
	bcf	TRISD,6,BANKED
;Set LCD_RS      OFF
	bcf	LATD,4,BANKED
;Set LCD_Enable  OFF
	bcf	LATD,6,BANKED
;LCDWrite_Nibble HD44780_LCD_RESET
	movlw	48
	movwf	LCD2BYTE,ACCESS
	banksel	0
	rcall	LCDWRITE_NIBBLE
;Wait 5 ms
	movlw	5
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;LCDWrite_Nibble HD44780_LCD_RESET
	movlw	48
	movwf	LCD2BYTE,ACCESS
	rcall	LCDWRITE_NIBBLE
;Wait 100 us
	movlw	2
	movwf	DELAYTEMP2,ACCESS
DelayUSO9
	clrf	DELAYTEMP,ACCESS
DelayUS9
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS9
	decfsz	DELAYTEMP2,F,ACCESS
	bra	DelayUSO9
	movlw	19
	movwf	DELAYTEMP,ACCESS
DelayUS10
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS10
;LCDWrite_Nibble HD44780_LCD_RESET
	movlw	48
	movwf	LCD2BYTE,ACCESS
	rcall	LCDWRITE_NIBBLE
;CheckBusyFlag
	rcall	CHECKBUSYFLAG
;LCDWrite_Nibble HD44780_FOUR_BIT
	movlw	32
	movwf	LCD2BYTE,ACCESS
	rcall	LCDWRITE_NIBBLE
;CheckBusyFlag
	rcall	CHECKBUSYFLAG
;LCDWriteByte(HD44780_FOUR_BIT_TWO_LINE)
	movlw	40
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;LCDWriteByte(HD44780_DISPLAY_CTRL + HD44780_DISPLAY_ON)
	movlw	12
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;LCDWriteByte(HD44780_ENTRY_MODE + HD44780_CURSOR_INC + HD44780_DSHIFT_OFF)
	movlw	6
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;CLS
	bra	CLS

;********************************************************************************

;Source: lcd.h (1289)
LCDNORMALWRITEBYTE
;Sub to write a byte to the LCD
;Dim LCD_I2C_Address_Current
;CheckBusyFlag         'WaitForReady
	rcall	CHECKBUSYFLAG
;set LCD_RW OFF
	banksel	LATD
	bcf	LATD,5,BANKED
;Dim Temp as Byte
;Pins must be outputs if returning from WaitForReady, or after LCDReadByte or GET subs
;DIR LCD_DB4 OUT
	bcf	TRISD,0,BANKED
;DIR LCD_DB5 OUT
	bcf	TRISD,1,BANKED
;DIR LCD_DB6 OUT
	bcf	TRISD,2,BANKED
;DIR LCD_DB7 OUT
	bcf	TRISD,3,BANKED
;Write upper nibble to output pins
;set LCD_DB4 OFF
;set LCD_DB5 OFF
;set LCD_DB6 OFF
;set LCD_DB7 OFF
;if LCDByte.7 ON THEN SET LCD_DB7 ON
;if LCDByte.6 ON THEN SET LCD_DB6 ON
;if LCDByte.5 ON THEN SET LCD_DB5 ON
;if LCDByte.4 ON THEN SET LCD_DB4 ON
;LCD_DB7 = LCDByte.7
	bcf	LATD,3,BANKED
	btfsc	LCDBYTE,7,ACCESS
	bsf	LATD,3,BANKED
;LCD_DB6 = LCDByte.6
	bcf	LATD,2,BANKED
	btfsc	LCDBYTE,6,ACCESS
	bsf	LATD,2,BANKED
;LCD_DB5 = LCDByte.5
	bcf	LATD,1,BANKED
	btfsc	LCDBYTE,5,ACCESS
	bsf	LATD,1,BANKED
;LCD_DB4 = LCDByte.4
	bcf	LATD,0,BANKED
	btfsc	LCDBYTE,4,ACCESS
	bsf	LATD,0,BANKED
;Wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS3
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS3
;PulseOut LCD_enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6,BANKED
;WaitL1 Time
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS4
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS4
;Set Pin Off
	bcf	LATD,6,BANKED
;All data pins low
;set LCD_DB4 OFF
;set LCD_DB5 OFF
;set LCD_DB6 OFF
;set LCD_DB7 OFF
	bcf	LATD,3,BANKED
;
;'Write lower nibble to output pins
;if LCDByte.3 ON THEN SET LCD_DB7 ON
	btfsc	LCDBYTE,3,ACCESS
;if LCDByte.3 ON THEN SET LCD_DB7 ON
	bsf	LATD,3,BANKED
;if LCDByte.3 ON THEN SET LCD_DB7 ON
;if LCDByte.2 ON THEN SET LCD_DB6 ON
;if LCDByte.1 ON THEN SET LCD_DB5 ON
;if LCDByte.0 ON THEN SET LCD_DB4 ON
;LCD_DB7 = LCDByte.3
;LCD_DB6 = LCDByte.2
	bcf	LATD,2,BANKED
	btfsc	LCDBYTE,2,ACCESS
	bsf	LATD,2,BANKED
;LCD_DB5 = LCDByte.1
	bcf	LATD,1,BANKED
	btfsc	LCDBYTE,1,ACCESS
	bsf	LATD,1,BANKED
;LCD_DB4 = LCDByte.0
	bcf	LATD,0,BANKED
	btfsc	LCDBYTE,0,ACCESS
	bsf	LATD,0,BANKED
;Wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS5
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS5
;PulseOut LCD_enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6,BANKED
;WaitL1 Time
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS6
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS6
;Set Pin Off
	bcf	LATD,6,BANKED
;Set data pins low again
;SET LCD_DB7 OFF
;SET LCD_DB6 OFF
;SET LCD_DB5 OFF
;SET LCD_DB4 OFF
;Wait SCRIPT_LCD_POSTWRITEDELAY
	movlw	1
	movwf	DELAYTEMP2,ACCESS
DelayUSO7
	clrf	DELAYTEMP,ACCESS
DelayUS7
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS7
	decfsz	DELAYTEMP2,F,ACCESS
	bra	DelayUSO7
	movlw	222
	movwf	DELAYTEMP,ACCESS
DelayUS8
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS8
	nop
;If Register Select is low
;IF LCD_RS = 0 then
	btfsc	PORTD,4,BANKED
	bra	ENDIF18
;IF LCDByte < 16 then
	movlw	16
	subwf	LCDBYTE,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF19
;if LCDByte > 7 then
	movf	LCDBYTE,W,ACCESS
	sublw	7
	btfss	STATUS, C,ACCESS
;LCD_State = LCDByte
	movff	LCDBYTE,LCD_STATE
;end if
;END IF
ENDIF19
;END IF
ENDIF18
	banksel	0
	return

;********************************************************************************

;Source: lcd.h (3116)
LCDWRITE_NIBBLE
;set LCD_RS OFF
	banksel	LATD
	bcf	LATD,4,BANKED
;CheckBusyFlag         'WaitForReady
	banksel	0
	rcall	CHECKBUSYFLAG
;set LCD_RW OFF
	banksel	LATD
	bcf	LATD,5,BANKED
;Pins must be outputs if returning from WaitForReady, or after LCDReadByte or GET subs
;DIR LCD_DB4 OUT
	bcf	TRISD,0,BANKED
;DIR LCD_DB5 OUT
	bcf	TRISD,1,BANKED
;DIR LCD_DB6 OUT
	bcf	TRISD,2,BANKED
;DIR LCD_DB7 OUT
	bcf	TRISD,3,BANKED
;Write upper nibble to output pins
;LCD_DB4 = LCDByte.4
	bcf	LATD,0,BANKED
	btfsc	LCDBYTE,4,ACCESS
	bsf	LATD,0,BANKED
;LCD_DB5 = LCDByte.5
	bcf	LATD,1,BANKED
	btfsc	LCDBYTE,5,ACCESS
	bsf	LATD,1,BANKED
;LCD_DB6 = LCDByte.6
	bcf	LATD,2,BANKED
	btfsc	LCDBYTE,6,ACCESS
	bsf	LATD,2,BANKED
;LCD_DB7 = LCDByte.7
	bcf	LATD,3,BANKED
	btfsc	LCDBYTE,7,ACCESS
	bsf	LATD,3,BANKED
;LCD_enable = 1
	bsf	LATD,6,BANKED
;Wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS11
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS11
;LCD_enable = 0
	bcf	LATD,6,BANKED
;Wait SCRIPT_LCD_POSTWRITEDELAY
	movlw	1
	movwf	DELAYTEMP2,ACCESS
DelayUSO12
	clrf	DELAYTEMP,ACCESS
DelayUS12
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS12
	decfsz	DELAYTEMP2,F,ACCESS
	bra	DelayUSO12
	movlw	222
	movwf	DELAYTEMP,ACCESS
DelayUS13
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS13
	nop
	banksel	0
	return

;********************************************************************************

;Source: string.h (961)
FN_LEFT
;Empty input?
;If SysInString(0) = 0 Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF40
;Left(0) = 0
	banksel	SYSLEFT_0
	clrf	SYSLEFT_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF40
;Input length too high?
;If SysInString(0) < SysCharCount Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF41
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;End If
ENDIF41
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
;Legacy method
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
SysForLoop2
	incf	SYSSTRINGTEMP,F,BANKED
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
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;Left(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSLEFT_0
	banksel	0
	return

;********************************************************************************

;Source: lcd.h (600)
LOCATE
;Sub to locate the cursor
;Where LCDColumn is 0 to screen width-1, LCDLine is 0 to screen height-1
;Set LCD_RS Off
	banksel	LATD
	bcf	LATD,4,BANKED
;If LCDLine > 1 Then
	movf	LCDLINE,W,ACCESS
	sublw	1
	btfsc	STATUS, C,ACCESS
	bra	ENDIF11
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F,ACCESS
;LCDColumn = LCDColumn + LCD_WIDTH
	movlw	20
	addwf	LCDCOLUMN,F,ACCESS
;End If
ENDIF11
;LCDWriteByte(0x80 or 0x40 * LCDLine + LCDColumn)
	movf	LCDLINE,W,ACCESS
	mullw	64
	movf	LCDCOLUMN,W,ACCESS
	addwf	PRODL,W,ACCESS
	movwf	SysTemp3,ACCESS
	movlw	128
	iorwf	SysTemp3,W,ACCESS
	movwf	LCDBYTE,ACCESS
	banksel	0
	rcall	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	bra	Delay_10US

;********************************************************************************

;Overloaded signature: STRING:, Source: lcd.h (1060)
PRINT119
;Sub to print a string variable on the LCD
;Dim SysPrintTemp
;Dim PrintLen
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
;If PrintLen = 0 Then Exit Sub
	return
;If PrintLen = 0 Then Exit Sub
;Set LCD_RS On
	banksel	LATD
	bsf	LATD,4,BANKED
;Write Data
;For SysPrintTemp = 1 To PrintLen
;Legacy method
	clrf	SYSPRINTTEMP,ACCESS
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
	incf	SYSPRINTTEMP,F,ACCESS
;LCDWriteByte PrintData(SysPrintTemp)
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,LCDBYTE
	banksel	0
	rcall	LCDNORMALWRITEBYTE
;Next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: lcd.h (1076)
PRINT120
;Sub to print a byte variable on the LCD
;LCDValueTemp = 0
	clrf	LCDVALUETEMP,ACCESS
;Set LCD_RS On
	banksel	LATD
	bsf	LATD,4,BANKED
;IF LCDValue >= 100 Then
	movlw	100
	subwf	LCDVALUE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ENDIF15
;LCDValueTemp = LCDValue / 100
	movff	LCDVALUE,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	banksel	0
	rcall	SYSDIVSUB
	movff	SysBYTETempA,LCDVALUETEMP
;LCDValue = SysCalcTempX
	movff	SYSCALCTEMPX,LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;End If
ENDIF15
;If LCDValueTemp > 0 Or LCDValue >= 10 Then
	movff	LCDVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp3
	movff	LCDVALUE,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp3,W,ACCESS
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,ACCESS
	btfss	SysTemp1,0,ACCESS
	bra	ENDIF16
;LCDValueTemp = LCDValue / 10
	movff	LCDVALUE,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SYSDIVSUB
	movff	SysBYTETempA,LCDVALUETEMP
;LCDValue = SysCalcTempX
	movff	SYSCALCTEMPX,LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;End If
ENDIF16
;LCDWriteByte (LCDValue + 48)
	movlw	48
	addwf	LCDVALUE,W,ACCESS
	movwf	LCDBYTE,ACCESS
	bra	LCDNORMALWRITEBYTE

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2170)
FN_READAD6
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
	rcall	Delay_10US
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

;Source: string.h (980)
FN_RIGHT
;Empty input?
;If SysInString(0) = 0 Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF44
;Right(0) = 0
	banksel	SYSRIGHT_0
	clrf	SYSRIGHT_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF44
;Input length too high?
;If SysInString(0) < SysCharCount Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF45
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;End If
ENDIF45
;Copy rightmost characters
;SysCharStart = SysInString(0) - SysCharCount
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	INDF0,W,ACCESS
	movwf	SYSCHARSTART,ACCESS
;For SysStringTemp = 1 To SysCharCount
;Legacy method
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
SysForLoop3
	incf	SYSSTRINGTEMP,F,BANKED
;Right(SysStringTemp) = SysInString(SysCharStart + SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SYSCHARSTART,W,ACCESS
	movwf	SysTemp3,ACCESS
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
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;Right(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSRIGHT_0
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:integer:, Source: stdbasic.h (266)
FN_SCALE79
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	movf	L_FROMLOW,W,ACCESS
	subwf	L_MAP,W,ACCESS
	movwf	SysTemp1,ACCESS
	movf	L_FROMLOW_H,W,ACCESS
	subwfb	L_MAP_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movf	L_TOLOW,W,ACCESS
	subwf	L_TOHIGH,W,ACCESS
	movwf	SysTemp2,ACCESS
	movf	L_TOLOW_H,W,ACCESS
	subwfb	L_TOHIGH_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	movff	SYSTEMP1,SysLONGTempA
	movff	SYSTEMP1_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	SYSTEMP2,SysLONGTempB
	movff	SYSTEMP2_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSMULTSUB32
	movff	SysLONGTempX,L_SYSCALCF
	movff	SysLONGTempX_H,L_SYSCALCF_H
	movff	SysLONGTempX_U,L_SYSCALCF_U
	movff	SysLONGTempX_E,L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	movf	L_FROMLOW,W,ACCESS
	subwf	L_FROMHIGH,W,ACCESS
	movwf	L_SYSCALC,ACCESS
	movf	L_FROMLOW_H,W,ACCESS
	subwfb	L_FROMHIGH_H,W,ACCESS
	movwf	L_SYSCALC_H,ACCESS
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
	movff	L_SYSCALCF,SysLONGTempA
	movff	L_SYSCALCF_H,SysLONGTempA_H
	movff	L_SYSCALCF_U,SysLONGTempA_U
	movff	L_SYSCALCF_E,SysLONGTempA_E
	movff	L_SYSCALC,SysLONGTempB
	movff	L_SYSCALC_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSDIVSUB32
	movff	SysLONGTempA,SysTemp1
	movff	SysLONGTempA_H,SysTemp1_H
	movff	SysLONGTempA_U,SysTemp1_U
	movff	SysLONGTempA_E,SysTemp1_E
	movf	L_TOLOW,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	movf	L_TOLOW_H,W,ACCESS
	addwfc	SysTemp1_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	movf	L_CALIBRATE,W,ACCESS
	addwf	SysTemp2,W,ACCESS
	movwf	SCALE,ACCESS
	movf	L_CALIBRATE_H,W,ACCESS
	addwfc	SysTemp2_H,W,ACCESS
	movwf	SCALE_H,ACCESS
	return

;********************************************************************************

;Source: string.h (124)
FN_STR
;SysCharCount = 0
	clrf	SYSCHARCOUNT,ACCESS
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
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
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,ACCESS
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
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,ACCESS
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
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,ACCESS
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
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,ACCESS
	movwf	INDF0,ACCESS
;End If
ENDIF39
;Ones
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysValTemp + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSVALTEMP,W,ACCESS
	movwf	INDF0,ACCESS
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;Str(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSSTR_0
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

;Source: system.h (1766)
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
	bra	ENDIF53
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF53
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
	bra	ENDIF54
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF54
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
	clrf	SYSLONGDIVMULTX,ACCESS
	clrf	SYSLONGDIVMULTX_H,ACCESS
	clrf	SYSLONGDIVMULTX_U,ACCESS
	clrf	SYSLONGDIVMULTX_E,ACCESS
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
	rlcf	SYSLONGDIVMULTA,F,ACCESS
	rlcf	SYSLONGDIVMULTA_H,F,ACCESS
	rlcf	SYSLONGDIVMULTA_U,F,ACCESS
	rlcf	SYSLONGDIVMULTA_E,F,ACCESS
;Rotate SysLongDivMultX Left
	rlcf	SYSLONGDIVMULTX,F,ACCESS
	rlcf	SYSLONGDIVMULTX_H,F,ACCESS
	rlcf	SYSLONGDIVMULTX_U,F,ACCESS
	rlcf	SYSLONGDIVMULTX_E,F,ACCESS
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,ACCESS
	subwf	SYSLONGDIVMULTX,F,ACCESS
	movf	SYSLONGDIVMULTB_H,W,ACCESS
	subwfb	SYSLONGDIVMULTX_H,F,ACCESS
	movf	SYSLONGDIVMULTB_U,W,ACCESS
	subwfb	SYSLONGDIVMULTX_U,F,ACCESS
	movf	SYSLONGDIVMULTB_E,W,ACCESS
	subwfb	SYSLONGDIVMULTX_E,F,ACCESS
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0,ACCESS
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF35
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0,ACCESS
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,ACCESS
	addwf	SYSLONGDIVMULTX,F,ACCESS
	movf	SYSLONGDIVMULTB_H,W,ACCESS
	addwfc	SYSLONGDIVMULTX_H,F,ACCESS
	movf	SYSLONGDIVMULTB_U,W,ACCESS
	addwfc	SYSLONGDIVMULTX_U,F,ACCESS
	movf	SYSLONGDIVMULTB_E,W,ACCESS
	addwfc	SYSLONGDIVMULTX_E,F,ACCESS
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
	clrf	SYSLONGDIVMULTX,ACCESS
	clrf	SYSLONGDIVMULTX_H,ACCESS
	clrf	SYSLONGDIVMULTX_U,ACCESS
	clrf	SYSLONGDIVMULTX_E,ACCESS
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	btfss	SYSLONGDIVMULTB,0,ACCESS
	bra	ENDIF32
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	movf	SYSLONGDIVMULTA,W,ACCESS
	addwf	SYSLONGDIVMULTX,F,ACCESS
	movf	SYSLONGDIVMULTA_H,W,ACCESS
	addwfc	SYSLONGDIVMULTX_H,F,ACCESS
	movf	SYSLONGDIVMULTA_U,W,ACCESS
	addwfc	SYSLONGDIVMULTX_U,F,ACCESS
	movf	SYSLONGDIVMULTA_E,W,ACCESS
	addwfc	SYSLONGDIVMULTX_E,F,ACCESS
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
ENDIF32
;set STATUS.C OFF
	bcf	STATUS,C,ACCESS
;rotate SysLongDivMultB right
	rrcf	SYSLONGDIVMULTB_E,F,ACCESS
	rrcf	SYSLONGDIVMULTB_U,F,ACCESS
	rrcf	SYSLONGDIVMULTB_H,F,ACCESS
	rrcf	SYSLONGDIVMULTB,F,ACCESS
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate SysLongDivMultA left
	rlcf	SYSLONGDIVMULTA,F,ACCESS
	rlcf	SYSLONGDIVMULTA_H,F,ACCESS
	rlcf	SYSLONGDIVMULTA_U,F,ACCESS
	rlcf	SYSLONGDIVMULTA_E,F,ACCESS
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movff	SYSLONGDIVMULTB,SysLONGTempB
	movff	SYSLONGDIVMULTB_H,SysLONGTempB_H
	movff	SYSLONGDIVMULTB_U,SysLONGTempB_U
	movff	SYSLONGDIVMULTB_E,SysLONGTempB_E
	clrf	SysLONGTempA,ACCESS
	clrf	SysLONGTempA_H,ACCESS
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
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
	db	12,71,67,66,65,83,73,67,32,50,48,50,54


StringTable2
	db	3,109,72,122


StringTable3
	db	1,32


StringTable4
	db	4,32,32,32,32


StringTable5
	db	3,60,76,58


StringTable6
	db	3,62,82,58


StringTable63
	db	0


StringTable67
	db	1,49


StringTable68
	db	1,48


StringTable153
	db	8,49,56,70,52,54,81,51,53


;********************************************************************************


 END
