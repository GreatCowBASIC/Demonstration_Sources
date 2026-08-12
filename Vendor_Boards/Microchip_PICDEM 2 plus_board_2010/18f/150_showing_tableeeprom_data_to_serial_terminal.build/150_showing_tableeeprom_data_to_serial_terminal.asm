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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\150_showing_tableeeprom_data_to_serial_terminal.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\150_showing_tableeeprom_data_to_serial_terminal.build\150_showing_tableeeprom_data_to_serial_terminal.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\150_showing_tableeeprom_data_to_serial_terminal.gcb"
 SUBTITLE    "08-12-2026 08:02:12"
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
COMPORT                          EQU    1293          ; 0x50D (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
DISPLAYNEWLINE                   EQU    1294          ; 0x50E (SA)
EEDATAVALUE                      EQU    1295          ; 0x50F (SA)
EEPROMADDRESS                    EQU    1296          ; 0x510 (SA)
EEPROMADDRESS_H                  EQU    1297          ; 0x511 (SA)
HSERPRINTCRLFCOUNT               EQU    1298          ; 0x512 (SA)
INDATA                           EQU    1299          ; 0x513 (SA)
PRINTLEN                         EQU    1300          ; 0x514 (SA)
RIGHT                            EQU    5335          ; 0x14D7
SERDATA                          EQU    1301          ; 0x515 (SA)
STRINGPOINTER                    EQU    1302          ; 0x516 (SA)
SYSARRAYTEMP1                    EQU    1303          ; 0x517 (SA)
SYSARRAYTEMP2                    EQU    1304          ; 0x518 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPA                     EQU    1285          ; 0x505 (SA)
SYSCHARCOUNT                     EQU    1305          ; 0x519 (SA)
SYSCHARSTART                     EQU    1306          ; 0x51A (SA)
SYSDIVLOOP                       EQU    1284          ; 0x504 (SA)
SYSDIVMULTA                      EQU    1287          ; 0x507 (SA)
SYSDIVMULTA_H                    EQU    1288          ; 0x508 (SA)
SYSDIVMULTB                      EQU    1291          ; 0x50B (SA)
SYSDIVMULTB_H                    EQU    1292          ; 0x50C (SA)
SYSDIVMULTX                      EQU    1282          ; 0x502 (SA)
SYSDIVMULTX_H                    EQU    1283          ; 0x503 (SA)
SYSEEADDRESS                     EQU    1307          ; 0x51B (SA)
SYSEEADDRESS_H                   EQU    1308          ; 0x51C (SA)
SYSPRINTDATAHANDLER              EQU    1309          ; 0x51D (SA)
SYSPRINTDATAHANDLER_H            EQU    1310          ; 0x51E (SA)
SYSPRINTTEMP                     EQU    1311          ; 0x51F (SA)
SYSREPEATTEMP1                   EQU    1312          ; 0x520 (SA)
SYSSTRINGA                       EQU    1287          ; 0x507 (SA)
SYSSTRINGA_H                     EQU    1288          ; 0x508 (SA)
SYSSTRINGLENGTH                  EQU    1286          ; 0x506 (SA)
SYSSTRINGPARAM1                  EQU    5328          ; 0x14D0
SYSSTRINGTEMP                    EQU    1313          ; 0x521
SYSSYSINSTRINGHANDLER            EQU    1314          ; 0x522 (SA)
SYSSYSINSTRINGHANDLER_H          EQU    1315          ; 0x523 (SA)
SYSTEMP1                         EQU    1316          ; 0x524 (SA)
SYSTEMP1_H                       EQU    1317          ; 0x525 (SA)
SYSTEMP2                         EQU    1318          ; 0x526 (SA)
SYSVALTEMP                       EQU    1319          ; 0x527 (SA)
SYSWAITTEMPMS                    EQU    1282          ; 0x502 (SA)
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503 (SA)
SYSWAITTEMPS                     EQU    1284          ; 0x504 (SA)
SYSWORDTEMPA                     EQU    1285          ; 0x505 (SA)
SYSWORDTEMPA_H                   EQU    1286          ; 0x506 (SA)
SYSWORDTEMPB                     EQU    1289          ; 0x509 (SA)
SYSWORDTEMPB_H                   EQU    1290          ; 0x50A (SA)
SYSWORDTEMPX                     EQU    1280          ; 0x500 (SA)
SYSWORDTEMPX_H                   EQU    1281          ; 0x501 (SA)
_HEXPICAS                        EQU    5324          ; 0x14CC

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
SYSRIGHT_0 EQU 5335
SYS_HEXPICAS_0 EQU 5324
SYS_HEXPICAS_1 EQU 5325
SYS_HEXPICAS_2 EQU 5326

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

;Start_of_the_main_program
;
;This demonstration shows the use of EEProm values created from a Table..
;
;This will show the value of the EEPROM on the serial Terminal.
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
;IO:    -----TX--------------------------
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
;Wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	banksel	0
	rcall	Delay_S
;Read EEPROM items
;ShowEEProm()
	rcall	SHOWEEPROM
;Do
SysDoLoop_S1
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;Table of values to write to EEPROM
;EEPROM location is specified
;Subsequent locations will each store a value
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

;Overloaded signature: STRING:byte:, Source: usart.h (3399)
HSERPRINT358
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF14
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
	rcall	HSERSEND346
;next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;End If
ENDIF14
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

;Source: 150_showing_tableeeprom_data_to_serial_terminal.gcb (70)
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

;Source: eeprom.h (508)
NVMADR_EPREAD
;Select DATA EE section (0x380000 - 0x3803FF) for ChipFamily18FxxQ35
;NVMADRU = 0x38
	movlw	56
	movwf	NVMADRU,BANKED
;NVMADRH =SysEEAddress_h
	movff	SYSEEADDRESS_H,NVMADRH
;NVMADRL =SysEEAddress
	movff	SYSEEADDRESS,NVMADRL
;Set the NVMCMD control bits for DFM Byte Read operation by clearing NVMCMD[2:0] NVM Command bits
;NVMCON1 = 0
	clrf	NVMCON1,BANKED
;GO_NVMCON0 = 1
	bsf	NVMCON0,GO_NVMCON0,BANKED
;EEDataValue = NVMDATL
	movff	NVMDATL,EEDATAVALUE
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
	bra	ENDIF10
;Right(0) = 0
	banksel	SYSRIGHT_0
	clrf	SYSRIGHT_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF10
;Input length too high?
;If SysInString(0) < SysCharCount Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF11
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;End If
ENDIF11
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
	bra	SysForLoopEnd4
SysForLoop4
	incf	SYSSTRINGTEMP,F,BANKED
;Right(SysStringTemp) = SysInString(SysCharStart + SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SYSCHARSTART,W,ACCESS
	movwf	SysTemp1,ACCESS
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
	bra	SysForLoop4
SysForLoopEnd4
;Right(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSRIGHT_0
	banksel	0
	return

;********************************************************************************

;Source: 150_showing_tableeeprom_data_to_serial_terminal.gcb (168)
SHOWEEPROM
;Dim DisplayNewLine, Outdata, Indata  As Byte
;Dim EEPromAddress as Word
;HserPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HserPrint "      "
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
;Using SYSSTRINGPARAM1*6
	rcall	HSERPRINT358
;For EEPromAddress = 0 To 15
;Legacy method
	setf	EEPROMADDRESS,ACCESS
	setf	EEPROMADDRESS_H,ACCESS
SysForLoop1
	incf	EEPROMADDRESS,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EEPROMADDRESS_H,F,ACCESS
;HSerPrint Hex(EEPromAddress)
	movff	EEPROMADDRESS,SYSVALTEMP
	rcall	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT358
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
	rcall	HSERPRINT358
;Next
	movff	EEPROMADDRESS,SysWORDTempA
	movff	EEPROMADDRESS_H,SysWORDTempA_H
	movlw	15
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;For EEPromAddress = 0 To ChipEEProm -1
;Legacy method
	setf	EEPROMADDRESS,ACCESS
	setf	EEPROMADDRESS_H,ACCESS
SysForLoop2
	incf	EEPROMADDRESS,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EEPROMADDRESS_H,F,ACCESS
;DisplayNewLine = EEPromAddress % 16
	movff	EEPROMADDRESS,SysWORDTempA
	movff	EEPROMADDRESS_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempX,DISPLAYNEWLINE
;If DisplayNewLine = 0 Then
	movf	DISPLAYNEWLINE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF3
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint right(Hex(EEPromAddress_H),1)
	movff	EEPROMADDRESS_H,SYSVALTEMP
	rcall	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high _HEXPICAS
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	1
	movwf	SYSCHARCOUNT,ACCESS
	rcall	FN_RIGHT
	movlw	low RIGHT
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high RIGHT
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT358
;HSerPrint Hex(EEPromAddress)
	movff	EEPROMADDRESS,SYSVALTEMP
	rcall	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT358
;HSerPrint ": "
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
	rcall	HSERPRINT358
;End If
ENDIF3
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
	rcall	HSERPRINT358
;Read EEPROM at specific address
;Indata = 1
	movlw	1
	movwf	INDATA,ACCESS
;EPRead  ( EEPromAddress, Indata )
	movff	EEPROMADDRESS,SYSEEADDRESS
	movff	EEPROMADDRESS_H,SYSEEADDRESS_H
	rcall	NVMADR_EPREAD
	movff	EEDATAVALUE,INDATA
;HSerPrint  Hex(Indata)
	movff	INDATA,SYSVALTEMP
	rcall	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT358
;Next
	movff	EEPROMADDRESS,SysWORDTempA
	movff	EEPROMADDRESS_H,SysWORDTempA_H
	setf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
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
	bra	ENDIF8
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF8
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
	bra	ENDIF9
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF9
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
	db	6,32,32,32,32,32,32


StringTable2
	db	1,32


StringTable3
	db	2,58,32


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
	bra	ENDIF5
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
ENDIF5
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
	bra	ENDIF7
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
ENDIF7
;_HexPICAS(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYS_HEXPICAS_1
	movwf	SYS_HEXPICAS_1,BANKED
	banksel	0
	return

;********************************************************************************

;********************************************************************************

; Data Tables (ChipFamily18FxxQ35 EEPROM Address 0x380000)
ORG	0x380010
DATATESTDATASOURCE	equ	0
		de 0x01, 0x02, 0x03, 0x04, 0x05, 0x06
ORG	0x380016
DATATESTDATASOURCE2	equ	8
		de 0x11, 0x12, 0x13, 0x14, 0x15, 0x16
ORG	0x380040
DATATESTDATASOURCE3	equ	16
		de 0x41, 0x42, 0x43, 0x44, 0x45, 0x00, 0xEB, 0x00

 END
