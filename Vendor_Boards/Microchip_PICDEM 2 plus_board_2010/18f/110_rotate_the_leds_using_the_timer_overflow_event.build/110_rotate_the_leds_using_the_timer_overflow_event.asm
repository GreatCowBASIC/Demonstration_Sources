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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\110_rotate_the_leds_using_the_timer_overflow_event.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\110_rotate_the_leds_using_the_timer_overflow_event.build\110_rotate_the_leds_using_the_timer_overflow_event.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\110_rotate_the_leds_using_the_timer_overflow_event.gcb"
 SUBTITLE    "08-12-2026 07:42:28"
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
CHR                              EQU    5335          ; 0x14D7
COMPORT                          EQU    1284          ; 0x504 (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
GET                              EQU    1291          ; 0x50B (SA)
HSERPRINTCRLFCOUNT               EQU    1292          ; 0x50C (SA)
LCD2BYTE                         EQU    1293          ; 0x50D (SA)
LCDBYTE                          EQU    1296          ; 0x510 (SA)
LCDCHAR                          EQU    1297          ; 0x511 (SA)
LCDCOLUMN                        EQU    1298          ; 0x512 (SA)
LCDLINE                          EQU    1299          ; 0x513 (SA)
LCDNORMALREADBYTE                EQU    1300          ; 0x514 (SA)
LCDPUTCOLUMN                     EQU    1301          ; 0x515 (SA)
LCDPUTLINE                       EQU    1302          ; 0x516 (SA)
LCDTEMPRWCOUNT                   EQU    1303          ; 0x517 (SA)
LCD_STATE                        EQU    1304          ; 0x518 (SA)
LEDS                             EQU    1305          ; 0x519 (SA)
PRINTLEN                         EQU    1306          ; 0x51A (SA)
ROTATECOUNT                      EQU    1307          ; 0x51B (SA)
SERDATA                          EQU    1308          ; 0x51C (SA)
STRINGPOINTER                    EQU    1309          ; 0x51D (SA)
SYSBSR                           EQU    1310          ; 0x51E (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPA                     EQU    1285          ; 0x505 (SA)
SYSCHAR                          EQU    1311          ; 0x51F (SA)
SYSINTSTATESAVE0                 EQU    1312          ; 0x520 (SA)
SYSLCDTEMP                       EQU    1313          ; 0x521 (SA)
SYSPRINTDATAHANDLER              EQU    1314          ; 0x522 (SA)
SYSPRINTDATAHANDLER_H            EQU    1315          ; 0x523 (SA)
SYSPRINTTEMP                     EQU    1316          ; 0x524 (SA)
SYSREPEATTEMP1                   EQU    1317          ; 0x525 (SA)
SYSSTATUS                        EQU    1295          ; 0x50F (SA)
SYSSTRINGA                       EQU    1287          ; 0x507 (SA)
SYSSTRINGA_H                     EQU    1288          ; 0x508 (SA)
SYSSTRINGLENGTH                  EQU    1286          ; 0x506 (SA)
SYSSTRINGPARAM1                  EQU    5327          ; 0x14CF
SYSTEMP1                         EQU    1318          ; 0x526 (SA)
SYSW                             EQU    1294          ; 0x50E (SA)
SYSWAITTEMP10US                  EQU    1285          ; 0x505 (SA)
SYSWAITTEMPMS                    EQU    1282          ; 0x502 (SA)
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503 (SA)
SYSWAITTEMPUS                    EQU    1285          ; 0x505 (SA)
SYSWAITTEMPUS_H                  EQU    1286          ; 0x506 (SA)
SYSWORDTEMPA                     EQU    1285          ; 0x505 (SA)
SYSWORDTEMPA_H                   EQU    1286          ; 0x506 (SA)
SYSWORDTEMPB                     EQU    1289          ; 0x509 (SA)
SYSWORDTEMPB_H                   EQU    1290          ; 0x50A (SA)
TIMEOUT                          EQU    1319          ; 0x527 (SA)
TIMEOUT_H                        EQU    1320          ; 0x528 (SA)
TMRNUMBER                        EQU    1321          ; 0x529 (SA)
TMRPOST                          EQU    1322          ; 0x52A (SA)
TMRPRES                          EQU    1323          ; 0x52B (SA)
TMRSOURCE                        EQU    1324          ; 0x52C (SA)
TMRVALUE                         EQU    1325          ; 0x52D (SA)
TMRVALUE_H                       EQU    1326          ; 0x52E (SA)

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
SYSCHR_0 EQU 5335
SYSCHR_1 EQU 5336

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	bra	INTERRUPT

;********************************************************************************

;Program_memory_page: 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	rcall	INITSYS
	rcall	INITPPS
	rcall	INITUSART
	rcall	INIT_OCULAR_OM1614_LCD
;Enable interrupts
	bsf	INTCON0,GIE,ACCESS

;Start_of_the_main_program
;
;This demonstration flashes an LED to show the use of a Timer 0 overflow event
;
;Timer0 is a counter implemented in the processor. It may be used to count instruction
;cycles or external events, that occur at or below the instruction cycle rate.
;In thE pic, Timer0 can be used as either an 8-bit or 16-bit counter, or timer. The
;enhanced mid-range core implements only an 8-bit counter.
;This lesson configures Timer0 to count instruction cycles and to set a flag when it rolls
;over. This frees up the processor to do meaningful work rather than wasting instruction
;cycles in a timing loop.
;Using a counter provides a convenient method of measuring time or delay loops as it
;allows the processor to work on other tasks rather than counting instruction cycles.
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
;************************************************************************
;@author  EvanV
;@licence GPL
;@version 1.00
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
;IO:    VDD------------------------------
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
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	rcall	HSERPRINTCRLF
;HSerPrintStringCRLF "Started"
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
;Using SYSSTRINGPARAM1*7
	rcall	HSERPRINTSTRINGCRLF
;! Initialise the timer.
;For this we need the following:
;Prescaler with the FOSC/4
;1:256 which is the constant PRE0_256
;Prescaler with the FOSC/4 with a post scaler
;1:1 which is the constant POST0_1
;InitTimer0 Osc, PRE0_256 + TMR0_FOSC4 ,  POST0_1
	movlw	1
	movwf	TMRSOURCE,ACCESS
	movlw	72
	movwf	TMRPRES,ACCESS
	clrf	TMRPOST,ACCESS
	rcall	INITTIMER0200
;Every 10 msec, we will count 100 to make 1 second
;SetTimer ( 0 , 0x9b  )
	clrf	TMRNUMBER,ACCESS
	movlw	155
	movwf	TMRVALUE,ACCESS
	clrf	TMRVALUE_H,ACCESS
	rcall	SETTIMER197
;Start the Timer
;StartTimer 0
	clrf	TMRNUMBER,ACCESS
	rcall	STARTTIMER
;Support variables
;Create variable as a flag
;Dim TimeOut As Word
;TimeOut = 0
	clrf	TIMEOUT,ACCESS
	clrf	TIMEOUT_H,ACCESS
;Now setup the Interrupt Service Routine
;On Interrupt Timer0Overflow Call ISR
	bsf	PIE8,TMR0IE,ACCESS
;Initialize a variable to hold the LED states
;DIM LEDs AS BYTE
;LEDs = 0B0001  // Start with the first LED on
	movlw	1
	movwf	LEDS,ACCESS
;Initialize a counter for rotations
;DIM RotateCount AS BYTE
;RotateCount = 0
	clrf	ROTATECOUNT,ACCESS
;Initialize a variable for LCD
;DIM LcdChar as Byte
;Do Forever
SysDoLoop_S1
;! We need many interrupts for 1 second!! So, increment and check
;If TimeOut = 100 Then
	movff	TIMEOUT,SysWORDTempA
	movff	TIMEOUT_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF1
;Print on LCD and Terminal - I will let you figure out what GET() does... toggles the character
;LcdChar = Get ( 0,0 )
	clrf	LCDPUTLINE,ACCESS
	clrf	LCDPUTCOLUMN,ACCESS
	rcall	FN_GET
	movff	GET,LCDCHAR
;LcdChar = !LcdChar
	comf	LCDCHAR,F,ACCESS
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print Chr( LcdChar )
	movff	LCDCHAR,SYSCHAR
	rcall	FN_CHR
	movlw	low CHR
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high CHR
	movwf	SysPRINTDATAHandler_H,ACCESS
	rcall	PRINT120
;HSerPrintStringCRLF "."
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
;Using SYSSTRINGPARAM1*1
	rcall	HSERPRINTSTRINGCRLF
;! Same code as previous demo 040
;Output the current state to PORTB
;LATB = LEDs
	movff	LEDS,LATB
;Rotate the LEDs to the left
;Rotate LEDs Left Simple
	rlncf	LEDS,F,ACCESS
;Increment the rotation counter
;RotateCount = RotateCount + 1
	incf	ROTATECOUNT,F,ACCESS
;Reset the LEDs after 4 rotations
;If RotateCount >= 4 Then
	movlw	4
	subwf	ROTATECOUNT,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ENDIF2
;LEDs = 0b0001  // Reset to initial state
	movlw	1
	movwf	LEDS,ACCESS
;RotateCount = 0  // Reset counter
	clrf	ROTATECOUNT,ACCESS
;End If
ENDIF2
;TimeOut= 0
	clrf	TIMEOUT,ACCESS
	clrf	TIMEOUT_H,ACCESS
;End If
ENDIF1
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

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
	nop
	nop
	nop
	nop
;Set LCD_Enable ON
	bsf	LATD,6,BANKED
;wait 1 us
	nop
	nop
	nop
	nop
;SysLCDTemp.7 = SCRIPT_LCD_BF
	bcf	SYSLCDTEMP,7,ACCESS
	btfsc	PORTD,3,BANKED
	bsf	SYSLCDTEMP,7,ACCESS
;Set LCD_Enable OFF
	bcf	LATD,6,BANKED
;Wait 1 us
	nop
	nop
	nop
	nop
;PulseOut LCD_Enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6,BANKED
;WaitL1 Time
	nop
	nop
	nop
;Set Pin Off
	bcf	LATD,6,BANKED
;Wait 1 us
	nop
	nop
	nop
	nop
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

;Source: string.h (1156)
FN_CHR
;Empty input?
;If SysChar < 0 Then
	movlw	0
	subwf	SYSCHAR,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF42
;Chr(0) = 0
	banksel	SYSCHR_0
	clrf	SYSCHR_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF42
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
	movlw	66
	movwf	DELAYTEMP,ACCESS
DelayUS8
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS8
	nop
	return

;********************************************************************************

Delay_10US
D10US_START
	movlw	12
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

;Source: lcd.h (591)
FN_GET
;Sub to get the value of the current LCD GCGRAM
;GET only supported in 8 and 4 bit modes
;Locate LCDPutLine, LCDPutColumn
	movff	LCDPUTLINE,LCDLINE
	movff	LCDPUTCOLUMN,LCDCOLUMN
	rcall	LOCATE
;Set LCD_RS on
	banksel	LATD
	bsf	LATD,4,BANKED
;GET = LCDReadByte
	banksel	0
	rcall	FN_LCDNORMALREADBYTE
	movff	LCDNORMALREADBYTE,GET
	return

;********************************************************************************

;Source: usart.h (3607)
HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd1
SysRepeatLoop1
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,ACCESS
	rcall	HSERSEND346
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,ACCESS
	rcall	HSERSEND346
;end Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

;Source: usart.h (3382)
HSERPRINTSTRINGCRLF
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF43
;Write Data
;for SysPrintTemp = 1 to PrintLen
;Legacy method
	clrf	SYSPRINTTEMP,ACCESS
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
SysForLoop2
	incf	SYSPRINTTEMP,F,ACCESS
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND346
;next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;End If
ENDIF43
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,ACCESS
	rcall	HSERSEND346
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,ACCESS
	bra	HSERSEND346

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (2069)
HSERSEND346
HSERSENDUSART1HANDLER
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop1
	btfss	PIR5,U1TXIF,ACCESS
	bra	SysWaitLoop1
;TXREG = SerData
	movff	SERDATA,U1TXB
	return

;********************************************************************************

;Source: 110_rotate_the_leds_using_the_timer_overflow_event.gcb (76)
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
;OSCFRQ = 0b00000101   '16mhz
	movlw	5
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

;Overloaded signature: BYTE:BYTE:BYTE:, Source: timer.h (1565)
INITTIMER0200
;Equate to      T0CON1 7:5      3:0        T0CON0 3:0
;Assumed for code below Timer0 is 16-bit capable as we have been passed three parameters
;Set prescaler
;T0CON1 Sets up  CLK Source (7:5)  Sync (4) & Prescale 3:0
;T0CON1 POR Val = b'00000000'
;Re-Use TMRPres as T0CON1 Temp register
;Keep T0CON1 7:4 and write bits 3:0 to  register
;Bits therefore will be cleared!
;TMRPres = (T0CON1 And 240 ) OR TMRPres
	movlw	240
	banksel	T0CON1
	andwf	T0CON1,W,BANKED
	movwf	SysTemp1,ACCESS
	iorwf	TMRPRES,F,ACCESS
;Set the Source bit
;IF TMRSource <> OSC  THEN
	decf	TMRSOURCE,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ELSE41_1
;SET TMRPost.5 ON
	bsf	TMRPOST,5,ACCESS
;ELSE
	bra	ENDIF41
ELSE41_1
;SET TMRPost.5 OFF
	bcf	TMRPOST,5,ACCESS
;END IF
ENDIF41
;Write the TOCON register
;T0CON1 = TMRPres
	movff	TMRPRES,T0CON1
;Assumed for code below Timer0 is 16-bit capable
;Set Postscaler
;Re-Use TMRPost as T0CON0 Temp register
;Keep T0CON0 7:5  and write bits 5:0 to register
;Bits therefore will be cleared!
;TMRPost = (T0CON0 And 224) OR TMRPost
	movlw	224
	andwf	T0CON0,W,BANKED
	movwf	SysTemp1,ACCESS
	iorwf	TMRPOST,F,ACCESS
;Set TO16BIT
;Set TMRPost.4 OFF '8-bit Timer0
	bcf	TMRPOST,4,ACCESS
;Write the TOCON register
;T0CON0 = TMRPost
	movff	TMRPOST,T0CON0
	banksel	0
	return

;********************************************************************************

;Source: usart.h (1282)
INITUSART
;Set the default value for USART handler - required when more than one USART
;comport = SCRIPT_DEFAULT_COMPORT
	movlw	1
	movwf	COMPORT,ACCESS
;PIC USART 1 Init
;U1BRGH=SPBRGH_TEMP
	movlw	1
	banksel	U1BRGH
	movwf	U1BRGH,BANKED
;U1BRGL=SPBRGL_TEMP
	movlw	159
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
	movlw	133
	movwf	DELAYTEMP,ACCESS
DelayUS6
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS6
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

INTERRUPT
;Use Automatic Context Save for K42 and K83 with MVECEN = OFF.  Interrupt priority not supported
;Store system variables
;On Interrupt handlers
	btfss	PIE8,TMR0IE,ACCESS
	bra	NotTMR0IF
	btfss	PIR8,TMR0IF,ACCESS
	bra	NotTMR0IF
	rcall	ISR
	bcf	PIR8,TMR0IF,ACCESS
	bra	INTERRUPTDONE
NotTMR0IF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	retfie	1

;********************************************************************************

;Source: 110_rotate_the_leds_using_the_timer_overflow_event.gcb (211)
ISR
;TimeOut = TimeOut + 1
	incf	TIMEOUT,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	TIMEOUT_H,F,ACCESS
	return

;********************************************************************************

;Source: lcd.h (1733)
FN_LCDNORMALREADBYTE
;set LCD_RW ON 'Read mode
	banksel	LATD
	bsf	LATD,5,BANKED
;LCDReadByte = 0
	clrf	LCDNORMALREADBYTE,ACCESS
;Set pins to input
;DIR LCD_DB4 IN
	bsf	TRISD,0,BANKED
;DIR LCD_DB5 IN
	bsf	TRISD,1,BANKED
;DIR LCD_DB6 IN
	bsf	TRISD,2,BANKED
;DIR LCD_DB7 IN
	bsf	TRISD,3,BANKED
;Read upper nibble from input pins
;SET LCD_Enable ON
	bsf	LATD,6,BANKED
;Wait LCD_Write_Delay     '2 us
	movlw	2
	movwf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
	nop
;if LCD_DB7 ON then SET LCDReadByte.7 ON
	btfsc	PORTD,3,BANKED
;if LCD_DB7 ON then SET LCDReadByte.7 ON
	bsf	LCDNORMALREADBYTE,7,ACCESS
;if LCD_DB7 ON then SET LCDReadByte.7 ON
;if LCD_DB6 ON THEN SET LCDReadByte.6 ON
	btfsc	PORTD,2,BANKED
;if LCD_DB6 ON THEN SET LCDReadByte.6 ON
	bsf	LCDNORMALREADBYTE,6,ACCESS
;if LCD_DB6 ON THEN SET LCDReadByte.6 ON
;if LCD_DB5 ON then SET LCDReadByte.5 ON
	btfsc	PORTD,1,BANKED
;if LCD_DB5 ON then SET LCDReadByte.5 ON
	bsf	LCDNORMALREADBYTE,5,ACCESS
;if LCD_DB5 ON then SET LCDReadByte.5 ON
;if LCD_DB4 ON THEN SET LCDReadByte.4 ON
	btfsc	PORTD,0,BANKED
;if LCD_DB4 ON THEN SET LCDReadByte.4 ON
	bsf	LCDNORMALREADBYTE,4,ACCESS
;if LCD_DB4 ON THEN SET LCDReadByte.4 ON
;SET LCD_Enable OFF
	bcf	LATD,6,BANKED
;Wait 5 us
	movlw	6
	movwf	DELAYTEMP,ACCESS
DelayUS3
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS3
	nop
;Read lower nibble from input pins
;SET LCD_Enable ON
	bsf	LATD,6,BANKED
;Wait LCD_Write_Delay
	movlw	2
	movwf	DELAYTEMP,ACCESS
DelayUS4
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS4
	nop
;if LCD_DB7 ON then SET LCDReadByte.3 ON
	btfsc	PORTD,3,BANKED
;if LCD_DB7 ON then SET LCDReadByte.3 ON
	bsf	LCDNORMALREADBYTE,3,ACCESS
;if LCD_DB7 ON then SET LCDReadByte.3 ON
;if LCD_DB6 ON THEN SET LCDReadByte.2 ON
	btfsc	PORTD,2,BANKED
;if LCD_DB6 ON THEN SET LCDReadByte.2 ON
	bsf	LCDNORMALREADBYTE,2,ACCESS
;if LCD_DB6 ON THEN SET LCDReadByte.2 ON
;if LCD_DB5 ON then SET LCDReadByte.1 ON
	btfsc	PORTD,1,BANKED
;if LCD_DB5 ON then SET LCDReadByte.1 ON
	bsf	LCDNORMALREADBYTE,1,ACCESS
;if LCD_DB5 ON then SET LCDReadByte.1 ON
;if LCD_DB4 ON THEN SET LCDReadByte.0 ON
	btfsc	PORTD,0,BANKED
;if LCD_DB4 ON THEN SET LCDReadByte.0 ON
	bsf	LCDNORMALREADBYTE,0,ACCESS
;if LCD_DB4 ON THEN SET LCDReadByte.0 ON
;SET LCD_Enable OFF
	bcf	LATD,6,BANKED
;Wait 5 us
	movlw	6
	movwf	DELAYTEMP,ACCESS
DelayUS5
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS5
	nop
	banksel	0
	return

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
	nop
	nop
	nop
	nop
;PulseOut LCD_enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6,BANKED
;WaitL1 Time
	nop
	nop
	nop
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
	nop
	nop
	nop
	nop
;PulseOut LCD_enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6,BANKED
;WaitL1 Time
	nop
	nop
	nop
;Set Pin Off
	bcf	LATD,6,BANKED
;Set data pins low again
;SET LCD_DB7 OFF
;SET LCD_DB6 OFF
;SET LCD_DB5 OFF
;SET LCD_DB4 OFF
;Wait SCRIPT_LCD_POSTWRITEDELAY
	movlw	101
	movwf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
;If Register Select is low
;IF LCD_RS = 0 then
	btfsc	PORTD,4,BANKED
	bra	ENDIF8
;IF LCDByte < 16 then
	movlw	16
	subwf	LCDBYTE,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF9
;if LCDByte > 7 then
	movf	LCDBYTE,W,ACCESS
	sublw	7
	btfss	STATUS, C,ACCESS
;LCD_State = LCDByte
	movff	LCDBYTE,LCD_STATE
;end if
;END IF
ENDIF9
;END IF
ENDIF8
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
	nop
	nop
	nop
	nop
;LCD_enable = 0
	bcf	LATD,6,BANKED
;Wait SCRIPT_LCD_POSTWRITEDELAY
	movlw	101
	movwf	DELAYTEMP,ACCESS
DelayUS7
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS7
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
	bra	ENDIF3
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F,ACCESS
;LCDColumn = LCDColumn + LCD_WIDTH
	movlw	20
	addwf	LCDCOLUMN,F,ACCESS
;End If
ENDIF3
;LCDWriteByte(0x80 or 0x40 * LCDLine + LCDColumn)
	movf	LCDLINE,W,ACCESS
	mullw	64
	movf	LCDCOLUMN,W,ACCESS
	addwf	PRODL,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	128
	iorwf	SysTemp1,W,ACCESS
	movwf	LCDBYTE,ACCESS
	banksel	0
	rcall	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	bra	Delay_10US

;********************************************************************************

;Overloaded signature: STRING:, Source: lcd.h (1060)
PRINT120
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

;Overloaded signature: BYTE:BYTE:, Source: timer.h (1217)
SETTIMER197
;Dim TMRValue as word
;If TMRNumber = 0 Then
	movf	TMRNUMBER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF35
;TMRValue_H = [byte]TMRValue
	movff	TMRVALUE,TMRVALUE_H
;[byte]TMRValue = 0
	clrf	TMRVALUE,ACCESS
;end if
ENDIF35
;SetTimer ( TMRNumber, [word]TMRValue )
	bra	SETTIMER198

;********************************************************************************

;Overloaded signature: BYTE:WORD:, Source: timer.h (1238)
SETTIMER198
;If TMRNumber = 0 Then
	movf	TMRNUMBER,F,ACCESS
	btfsc	STATUS, Z,ACCESS
;Handle chips with TMR0H
;Use default 8-bit mode therefore _TMR0_16BIT_ not defined
;Added to resolve using 8bit Timer0 with enhance timer
;High byte is timer0 register of interest
;TMR0H = TMRValue_H
	movff	TMRVALUE_H,TMR0H
;End If
;If TMRNumber = 1 then
	decf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF37
;TMR1H = TMRValue_H
	movff	TMRVALUE_H,TMR1H
;TMR1L = TMRValue
	movff	TMRVALUE,TMR1L
;End If
ENDIF37
;If TMRNumber = 2 Then
	movlw	2
	subwf	TMRNUMBER,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;TMR2 = TMRValue
	movff	TMRVALUE,TMR2
;End If
;If TMRNumber = 3 then
	movlw	3
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF39
;TMR3H = TMRValue_H
	movff	TMRVALUE_H,TMR3H
;TMR3L = TMRValue
	movff	TMRVALUE,TMR3L
;End If
ENDIF39
;If TMRNumber = 4 Then
	movlw	4
	subwf	TMRNUMBER,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;TMR4 = TMRValue
	movff	TMRVALUE,TMR4
;End If
	return

;********************************************************************************

;Source: timer.h (886)
STARTTIMER
;IF TMRNumber = 0 then Set T0EN on
	movf	TMRNUMBER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF30
;IF TMRNumber = 0 then Set T0EN on
	banksel	T0CON0
	bsf	T0CON0,T0EN,BANKED
;IF TMRNumber = 0 then Set T0EN on
ENDIF30
;IF TMRNumber = 1 then Set TMR1ON on
	decf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF31
;IF TMRNumber = 1 then Set TMR1ON on
	banksel	T1CON
	bsf	T1CON,TMR1ON,BANKED
;IF TMRNumber = 1 then Set TMR1ON on
ENDIF31
;IF TMRNumber = 2 then Set TMR2ON on
	movlw	2
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF32
;IF TMRNumber = 2 then Set TMR2ON on
	banksel	T2CON
	bsf	T2CON,TMR2ON,BANKED
;IF TMRNumber = 2 then Set TMR2ON on
ENDIF32
;IF TMRNumber = 3 then Set TMR3ON on
	movlw	3
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF33
;IF TMRNumber = 3 then Set TMR3ON on
	banksel	T3CON
	bsf	T3CON,TMR3ON,BANKED
;IF TMRNumber = 3 then Set TMR3ON on
ENDIF33
;IF TMRNumber = 4 then Set TMR4ON on
	movlw	4
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF34
;IF TMRNumber = 4 then Set TMR4ON on
	banksel	T4CON
	bsf	T4CON,TMR4ON,BANKED
;IF TMRNumber = 4 then Set TMR4ON on
ENDIF34
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
	db	7,83,116,97,114,116,101,100


StringTable2
	db	1,46


;********************************************************************************


 END
