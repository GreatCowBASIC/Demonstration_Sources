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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\170_show_i2c_devices_to_serial_terminal.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\170_show_i2c_devices_to_serial_terminal.build\170_show_i2c_devices_to_serial_terminal.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\170_show_i2c_devices_to_serial_terminal.gcb"
 SUBTITLE    "08-15-2026 08:28:39"
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
COMPORT                          EQU    1291          ; 0x50B (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
DEVICEID                         EQU    1292          ; 0x50C (SA)
DISPLAYNEWLINE                   EQU    1293          ; 0x50D (SA)
HI2C1LASTERROR                   EQU    1294          ; 0x50E (SA)
HI2C1STATEMACHINE                EQU    1295          ; 0x50F (SA)
HI2CACKPOLLSTATE                 EQU    1296          ; 0x510 (SA)
HI2CCURRENTMODE                  EQU    1297          ; 0x511 (SA)
HI2CWAITMSSPTIMEOUT              EQU    1298          ; 0x512 (SA)
HSERPRINTCRLFCOUNT               EQU    1299          ; 0x513 (SA)
HWI2C_BUFFER                     EQU    5359          ; 0x14EF
HWI2C_BUFFERLOCATIONCOUNTER      EQU    1300          ; 0x514 (SA)
HWI2C_BUFFERLOCATIONCOUNTERINDEX EQU    1302          ; 0x516 (SA)
HWI2C_BUFFERLOCATIONCOUNTERINDEX EQU    1303          ; 0x517 (SA)
HWI2C_BUFFERLOCATIONCOUNTER_H    EQU    1301          ; 0x515 (SA)
I2CBYTE                          EQU    1304          ; 0x518 (SA)
PRINTLEN                         EQU    1305          ; 0x519 (SA)
SERDATA                          EQU    1306          ; 0x51A (SA)
STRINGPOINTER                    EQU    1307          ; 0x51B (SA)
SYSBYTETEMPA                     EQU    1285          ; 0x505 (SA)
SYSBYTETEMPB                     EQU    1289          ; 0x509 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPA                     EQU    1285          ; 0x505 (SA)
SYSDIVLOOP                       EQU    1284          ; 0x504 (SA)
SYSPRINTDATAHANDLER              EQU    1308          ; 0x51C (SA)
SYSPRINTDATAHANDLER_H            EQU    1309          ; 0x51D (SA)
SYSPRINTTEMP                     EQU    1310          ; 0x51E (SA)
SYSREPEATTEMP1                   EQU    1311          ; 0x51F (SA)
SYSSTRINGA                       EQU    1287          ; 0x507 (SA)
SYSSTRINGA_H                     EQU    1288          ; 0x508 (SA)
SYSSTRINGLENGTH                  EQU    1286          ; 0x506 (SA)
SYSSTRINGPARAM1                  EQU    5345          ; 0x14E1
SYSSTRINGTEMP                    EQU    1312          ; 0x520
SYSTEMP1                         EQU    1313          ; 0x521 (SA)
SYSTEMP2                         EQU    1314          ; 0x522 (SA)
SYSVALTEMP                       EQU    1315          ; 0x523 (SA)
SYSWAITTEMPMS                    EQU    1282          ; 0x502 (SA)
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503 (SA)
SYSWAITTEMPS                     EQU    1284          ; 0x504 (SA)
SYSWAITTEMPUS                    EQU    1285          ; 0x505 (SA)
SYSWAITTEMPUS_H                  EQU    1286          ; 0x506 (SA)
SYSWORDTEMPA                     EQU    1285          ; 0x505 (SA)
SYSWORDTEMPA_H                   EQU    1286          ; 0x506 (SA)
SYSWORDTEMPB                     EQU    1289          ; 0x509 (SA)
SYSWORDTEMPB_H                   EQU    1290          ; 0x50A (SA)
_HEXPICAS                        EQU    5341          ; 0x14DD

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
SYS_HEXPICAS_0 EQU 5341
SYS_HEXPICAS_1 EQU 5342
SYS_HEXPICAS_2 EQU 5343

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
	rcall	HI2CQ24Q35INIT

;Start_of_the_main_program
;
;This demonstration shows the I2C devices attached the microcontroller, this program supports the Microchip I2C module.
;
;I2C device required a data bus and a clock bus, devices also required an input voltage and 0v.
;I2C data bus is connected to PortC.4
;I2C clock bus is connected to PortC.3
;Serial output is connected, as previously, to PortC.6
;
;Connect your IC2 devices and see the results on the serial terminal.
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
;IO:    VDD-TX-----SDA-SCL---------------
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
;Add this code segment to your GCBASIC source program
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
	rcall	HI2CMODE
;I2C Controls specific to 18FxxQ2x and Q35 chips
;! Optional the default is 128
;! Optional the default is to issue a warning
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim DeviceID As Byte
;Dim DISPLAYNEWLINE As Byte
;Dim HI2CWaitMSSPTimeout As Byte
;Dim DumpI2CRead as Byte
;Wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;HserSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND344
;Do
SysDoLoop_S1
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	rcall	HSERPRINTCRLF
;Now assumes Serial Terminal is operational
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint "   "
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
;Using SYSSTRINGPARAM1*3
	rcall	HSERPRINT357
;Create a horizontal row of numbers
;For DeviceID = 0 To 15
;Legacy method
	setf	DEVICEID,ACCESS
SysForLoop1
	incf	DEVICEID,F,ACCESS
;HSerPrint Hex(deviceID)
	movff	DEVICEID,SYSVALTEMP
	rcall	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT357
;HSerPrint " "
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
	rcall	HSERPRINT357
;Next
	movlw	15
	subwf	DEVICEID,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;Create a vertical column of numbers
;For DeviceID = 0 to 255
;Legacy method
	setf	DEVICEID,ACCESS
SysForLoop2
	incf	DEVICEID,F,ACCESS
;DisplayNewLine = DeviceID % 16
	movff	DEVICEID,SysBYTETempA
	movlw	16
	movwf	SysBYTETempB,ACCESS
	rcall	SYSDIVSUB
	movff	SysBYTETempX,DISPLAYNEWLINE
;If DisplayNewLine = 0 Then
	movf	DISPLAYNEWLINE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF2
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint Hex(DeviceID)
	movff	DEVICEID,SYSVALTEMP
	rcall	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT357
;If DisplayNewLine > 0 Then
	movf	DISPLAYNEWLINE,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF5
;HSerPrint " "
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
	rcall	HSERPRINT357
;End If
ENDIF5
;End If
ENDIF2
;HSerPrint " "
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
	rcall	HSERPRINT357
;Do an initial Start
;HI2CStart
	rcall	SI2CSTART
;Send address
;HI2CSend ( DeviceID )
	movff	DEVICEID,I2CBYTE
	rcall	HI2CQ24Q35SEND
;Send a byte to prevent any potential read address lockup
;HI2CSend ( 0x00 )
	clrf	I2CBYTE,ACCESS
	rcall	HI2CQ24Q35SEND
;Stop the I2C
;HI2CStop
	rcall	HI2CQ24Q35STOP
;Did device fail to respond?
;If HI2CAckpollState = FALSE Then
	movf	HI2CACKPOLLSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE3_1
;HSerPrint Hex(DeviceID)
	movff	DEVICEID,SYSVALTEMP
	rcall	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT357
;Else
	bra	ENDIF3
ELSE3_1
;HSerPrint "--"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*2
	rcall	HSERPRINT357
;End If
ENDIF3
;Next
	movlw	255
	subwf	DEVICEID,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrintStringCRLF   "End of Search"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*13
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;Wait While SwitchIn <> DOWN
SysWaitLoop1
	banksel	PORTA
	btfsc	PORTA,4,BANKED
	bra	SysWaitLoop1
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
SysSelect1Case1
	movlw	2
	subwf	HI2C1STATEMACHINE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
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
	bra	SysSelectEnd1
SysSelect1Case2
	decf	HI2C1STATEMACHINE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
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
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	HI2C1STATEMACHINE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
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
SysSelectEnd1
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
SysDoLoop_S2
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
;If I2C1STAT0.BFRE  = 0 Then Exit Do
	btfss	I2C1STAT0,BFRE,BANKED
;If I2C1STAT0.BFRE  = 0 Then Exit Do
	bra	SysDoLoop_E2
;If I2C1STAT0.BFRE  = 0 Then Exit Do
;HI2CWaitMSSPTimeout++
	incf	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;If HI2CWaitMSSPTimeout <> 255 Then
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF16
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
SysDoLoop_S3
	btfss	I2C1CON0,S,BANKED
	bra	SysDoLoop_E3
;Wait for start
;NOP
	nop
;Loop
	bra	SysDoLoop_S3
SysDoLoop_E3
;Dim HWI2C_BufferLocationCounterIndex as Word
;For HWI2C_BufferLocationCounterIndex = 1 to HWI2C_BufferLocationCounter
;Legacy method
	clrf	HWI2C_BUFFERLOCATIONCOUNTERINDEX,ACCESS
	clrf	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,ACCESS
	movlw	1
	subwf	HWI2C_BUFFERLOCATIONCOUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
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
SysDoLoop_S4
	banksel	I2C1STAT1
	btfsc	I2C1STAT1,TXBE,BANKED
	bra	SysDoLoop_E4
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
	bra	SysDoLoop_S4
SysDoLoop_E4
;Next
	movff	HWI2C_BUFFERLOCATIONCOUNTERINDEX,SysWORDTempA
	movff	HWI2C_BUFFERLOCATIONCOUNTERINDEX_H,SysWORDTempA_H
	movff	HWI2C_BUFFERLOCATIONCOUNTER,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;Wait for a stop bit to complete
;Do while I2C1STAT0.MMA = 1 and HI2CWaitMSSPTimeout <> 255
SysDoLoop_S5
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
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfss	SysTemp2,0,ACCESS
	bra	SysDoLoop_E5
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
;Loop
	bra	SysDoLoop_S5
SysDoLoop_E5
;End If
ENDIF16
HI2CQ24Q35STOPEXIT
;If I2C1PIR.7 = 1 then
	banksel	I2C1PIR
	btfss	I2C1PIR,7,BANKED
	bra	ELSE17_1
;HI2CAckpollState = False
	clrf	HI2CACKPOLLSTATE,ACCESS
;Else
	bra	ENDIF17
ELSE17_1
;HI2CAckpollState = True
	setf	HI2CACKPOLLSTATE,ACCESS
;End If
ENDIF17
;I2C1CON0.I2CEN=0
	bcf	I2C1CON0,I2CEN,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (3399)
HSERPRINT357
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF12
;Write Data
;for SysPrintTemp = 1 to PrintLen
;Legacy method
	clrf	SYSPRINTTEMP,ACCESS
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
	incf	SYSPRINTTEMP,F,ACCESS
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND345
;next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;End If
ENDIF12
;CR
;All Usarts
;--------------------------
;Specific USARTs
;------------------
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
	rcall	HSERSEND345
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,ACCESS
	rcall	HSERSEND345
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
	bra	ENDIF9
;Write Data
;for SysPrintTemp = 1 to PrintLen
;Legacy method
	clrf	SYSPRINTTEMP,ACCESS
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
	incf	SYSPRINTTEMP,F,ACCESS
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND345
;next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;End If
ENDIF9
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,ACCESS
	rcall	HSERSEND345
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,ACCESS
	bra	HSERSEND345

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (1950)
HSERSEND344
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop2
	btfss	PIR5,U1TXIF,ACCESS
	bra	SysWaitLoop2
;TXREG = SerData
	movff	SERDATA,U1TXB
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (2069)
HSERSEND345
HSERSENDUSART1HANDLER
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop3
	btfss	PIR5,U1TXIF,ACCESS
	bra	SysWaitLoop3
;TXREG = SerData
	movff	SERDATA,U1TXB
	return

;********************************************************************************

;Source: 170_show_i2c_devices_to_serial_terminal.gcb (73)
INITPPS
;Module: I2C1
;RC3PPS = 0x001D    // SCL1 > RC3
	movlw	29
	banksel	RC3PPS
	movwf	RC3PPS,BANKED
;I2C1SCLPPS = 0x0013    // RC3 > SCL1 (bi-directional)
	movlw	19
	movwf	I2C1SCLPPS,BANKED
;RC4PPS = 0x001E    // SDA1 > RC4
	movlw	30
	movwf	RC4PPS,BANKED
;I2C1SDAPPS = 0x0014    // RC4 > SDA1 (bi-directional)
	movlw	20
	movwf	I2C1SDAPPS,BANKED
;Module: UART pin directions
;Dir PORTC.6 Out    ' Make TX1 pin an output
	banksel	TRISC
	bcf	TRISC,6,BANKED
;Module: UART1
;RC6PPS = 0x0012    // TX1 > RC6
	movlw	18
	banksel	RC6PPS
	movwf	RC6PPS,BANKED
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

;Source: usart.h (1282)
INITUSART
;Set the default value for USART handler - required when more than one USART
;comport = SCRIPT_DEFAULT_COMPORT
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

;Source: system.h (3439)
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
	db	3,32,32,32


StringTable2
	db	1,32


StringTable3
	db	2,45,45


StringTable4
	db	13,69,110,100,32,111,102,32,83,101,97,114,99,104


;********************************************************************************

;Source: picas.h (7)
FN__HEXPICAS
;_HexPICAS(0) = 2
	movlw	2
	banksel	SYS_HEXPICAS_0
	movwf	SYS_HEXPICAS_0,BANKED
;dim SysStringTemp as byte
;Low nibble
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,ACCESS
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF6
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
ENDIF6
;_HexPICAS(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYS_HEXPICAS_2
	movwf	SYS_HEXPICAS_2,BANKED
;Get high nibble
;For SysStringTemp = 1 to 4
;Legacy method
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop3
	incf	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	rrcf	SYSVALTEMP,F,ACCESS
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,ACCESS
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF8
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
ENDIF8
;_HexPICAS(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYS_HEXPICAS_1
	movwf	SYS_HEXPICAS_1,BANKED
	banksel	0
	return

;********************************************************************************


 END
