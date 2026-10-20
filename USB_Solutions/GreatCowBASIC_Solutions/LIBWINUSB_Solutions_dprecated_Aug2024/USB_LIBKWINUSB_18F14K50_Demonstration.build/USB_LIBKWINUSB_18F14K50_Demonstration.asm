;Program compiled by GCBASIC (2026.10.17 (Windows 64 bit) : Build 1660) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-10-17 CRC170
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\USB_Solutions\GreatCowBASIC_Solutions\LIBWINUSB_Solutions_dprecated_Aug2024\USB_LIBKWINUSB_18F14K50_Demonstration.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\USB_Solutions\GreatCowBASIC_Solutions\LIBWINUSB_Solutions_dprecated_Aug2024\USB_LIBKWINUSB_18F14K50_Demonstration.build\USB_LIBKWINUSB_18F14K50_Demonstration.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F14K50, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\USB_Solutions\GreatCowBASIC_Solutions\LIBWINUSB_Solutions_dprecated_Aug2024\USB_LIBKWINUSB_18F14K50_Demonstration.gcb"
 SUBTITLE    "10-20-2026 13:03:14"
#include <P18F14K50.inc>
 CONFIG WRTD = OFF, WRTB = OFF, CPD = OFF, XINST = OFF, LVP = OFF, MCLRE = OFF, WDTEN = OFF, FCMEN = ON, PLLEN = ON, FOSC = HS, CPUDIV = NOCLKDIV

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
COMPORT                          EQU      10          ; 0xA (SA)
DELAYTEMP                        EQU       0          ; 0x0 (SA)
DELAYTEMP2                       EQU       1          ; 0x1 (SA)
GCBBUILDSTR                      EQU     369          ; 0x171
GCBBUILDTIMESTR                  EQU     410          ; 0x19A
HSERPRINTCRLFCOUNT               EQU      11          ; 0xB (SA)
MEMDATA                          EQU      12          ; 0xC (SA)
OUTVALUETEMP                     EQU      13          ; 0xD (SA)
PEEK                             EQU      16          ; 0x10 (SA)
PRINTLEN                         EQU      17          ; 0x11 (SA)
SAVEDELAYTEMP2                   EQU      18          ; 0x12 (SA)
SAVEFSR0H                        EQU      19          ; 0x13 (SA)
SAVEFSR0L                        EQU      20          ; 0x14 (SA)
SAVEFSR1H                        EQU      21          ; 0x15 (SA)
SAVEFSR1L                        EQU      22          ; 0x16 (SA)
SAVESYSBYTETEMPA                 EQU      23          ; 0x17 (SA)
SAVESYSBYTETEMPB                 EQU      24          ; 0x18 (SA)
SAVESYSBYTETEMPX                 EQU      25          ; 0x19 (SA)
SAVESYSDIVLOOP                   EQU      26          ; 0x1A (SA)
SAVESYSSTRINGA                   EQU      27          ; 0x1B (SA)
SAVESYSSTRINGLENGTH              EQU      28          ; 0x1C (SA)
SAVESYSTEMP1                     EQU      29          ; 0x1D (SA)
SAVESYSTEMP2                     EQU      30          ; 0x1E (SA)
SAVESYSWAITTEMPMS                EQU      31          ; 0x1F (SA)
SAVESYSWAITTEMPMS_H              EQU      32          ; 0x20 (SA)
SERDATA                          EQU      33          ; 0x21 (SA)
SERPRINTVAL                      EQU      34          ; 0x22 (SA)
STRINGPOINTER                    EQU      35          ; 0x23 (SA)
SYSBSR                           EQU      36          ; 0x24 (SA)
SYSBYTETEMPA                     EQU       5          ; 0x5 (SA)
SYSBYTETEMPB                     EQU       9          ; 0x9 (SA)
SYSBYTETEMPX                     EQU       0          ; 0x0 (SA)
SYSCALCTEMPA                     EQU       5          ; 0x5 (SA)
SYSCALCTEMPX                     EQU       0          ; 0x0 (SA)
SYSDIVLOOP                       EQU       4          ; 0x4 (SA)
SYSINTSTATESAVE0                 EQU      37          ; 0x25 (SA)
SYSPRINTDATAHANDLER              EQU      38          ; 0x26 (SA)
SYSPRINTDATAHANDLER_H            EQU      39          ; 0x27 (SA)
SYSPRINTTEMP                     EQU      40          ; 0x28 (SA)
SYSREPEATTEMP1                   EQU      41          ; 0x29 (SA)
SYSSTATUS                        EQU      15          ; 0xF (SA)
SYSSTRINGA                       EQU       7          ; 0x7 (SA)
SYSSTRINGA_H                     EQU       8          ; 0x8 (SA)
SYSSTRINGLENGTH                  EQU       6          ; 0x6 (SA)
SYSSTRINGPARAM1                  EQU     383          ; 0x17F
SYSSTRINGPARAM2                  EQU     375          ; 0x177
SYSSTRINGTEMP                    EQU      42          ; 0x2A
SYSTEMP1                         EQU      43          ; 0x2B (SA)
SYSTEMP1_H                       EQU      44          ; 0x2C (SA)
SYSTEMP2                         EQU      45          ; 0x2D (SA)
SYSVALTEMP                       EQU      46          ; 0x2E (SA)
SYSW                             EQU      14          ; 0xE (SA)
SYSWAITTEMPMS                    EQU       2          ; 0x2 (SA)
SYSWAITTEMPMS_H                  EQU       3          ; 0x3 (SA)
USBBMREQUESTTYPE                 EQU      47          ; 0x2F (SA)
USBBUFFERSTAT                    EQU      48          ; 0x30 (SA)
USBCURRBYTE                      EQU      49          ; 0x31 (SA)
USBCURRCONFIGURATION             EQU      50          ; 0x32 (SA)
USBCURRENDPOINT                  EQU      51          ; 0x33 (SA)
USBDESCINDEX                     EQU      52          ; 0x34 (SA)
USBDESCSIZEIN                    EQU      53          ; 0x35 (SA)
USBDESCSTART                     EQU      54          ; 0x36 (SA)
USBDESCTYPE                      EQU      55          ; 0x37 (SA)
USBHASDATA                       EQU      56          ; 0x38 (SA)
USBLASTCONTROL                   EQU      57          ; 0x39 (SA)
USBNEWADDRESS                    EQU      58          ; 0x3A (SA)
USBPID                           EQU      59          ; 0x3B (SA)
USBRAM                           EQU     512          ; 0x200
USBSIZE                          EQU      60          ; 0x3C (SA)
USBSTATE                         EQU      61          ; 0x3D (SA)
USBTEMPBUFFER                    EQU     393          ; 0x189
USBTEMPBYTE                      EQU      62          ; 0x3E (SA)
USBTEMPSTRING                    EQU     471          ; 0x1D7
USB_CNT_POINTER                  EQU      63          ; 0x3F (SA)
VERSIONSTRING                    EQU     430          ; 0x1AE
_HEXPICAS                        EQU     365          ; 0x16D
_USBINVALUE                      EQU      64          ; 0x40 (SA)

;STRING LENGTHS
GCBBUILDSTR_STRING_LENGTH        EQU       5
GCBBUILDTIMESTR_STRING_LENGTH    EQU      19
SYSSTRINGPARAM1_STRING_LENGTH    EQU       9
SYSSTRINGPARAM2_STRING_LENGTH    EQU       7
USBTEMPSTRING_STRING_LENGTH      EQU      40
VERSIONSTRING_STRING_LENGTH      EQU      40
_HEXPICAS_STRING_LENGTH          EQU       3

;********************************************************************************

;Alias variables
AFSR0 EQU 4073
AFSR0_H EQU 4074
MEMADR EQU 4073
MEMADR_H EQU 4074
SYSUSBTEMPBUFFER_0 EQU 393
SYSUSBTEMPBUFFER_1 EQU 394
SYSUSBTEMPBUFFER_2 EQU 395
SYSUSBTEMPBUFFER_3 EQU 396
SYSUSBTEMPBUFFER_6 EQU 399
SYSUSBTEMPSTRING_0 EQU 471
SYS_HEXPICAS_0 EQU 365
SYS_HEXPICAS_1 EQU 366
SYS_HEXPICAS_2 EQU 367
USBREQUEST EQU 394
USB_IN0_ADDR EQU 518
USB_IN0_ADDR_H EQU 519
USB_IN0_CNT EQU 517
USB_IN0_STAT EQU 516
USB_OUT0_ADDR EQU 514
USB_OUT0_ADDR_H EQU 515
USB_OUT0_CNT EQU 513
USB_OUT0_STAT EQU 512

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
	rcall	INITUSART
	rcall	INITUSB
;Enable interrupts
	bsf	INTCON,GIE,ACCESS
	bsf	INTCON,PEIE,ACCESS

;Start_of_the_main_program
;''A program  for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''
;''Demonstration of the GCBASIC capabilities for LibK/WinUSB library
;''
;''Connect the 18F14K50 to the USB
;''
;'' Use the Windows application to control!
;''
;''
;''
;''
;''@author     HughC and EvanV
;''@licence    GPL
;''@version    1.0
;''@date       29/10/2018
;''********************************************************************************
;----- Configuration
;;configuration flag 48 MHZ
;----- Constants for the usb.h
;Define a name - 30 chars max long
;#define USB_PRODUCT_NAME versionString
;Constants that match the codes in the PC application - these are numeric messages
;------ Version Control - optional
;Include the GCBVersionNumber.cnt to increment versionString and create the build time string called GCBBuildTimeStr.
;versionString a string is created automatically.
;GCBBuildTimeStr is a string that is also created automatically.
;use "GCBVersionNumber.cnt" as this will create a local copy of the versionString tracker.
;if you use <GCBVersionNumber.cnt> this is a system wide versionString tracker.
;dim versionString as string * 40
;versionString = "Build"+GCBBuildStr
	rcall	FN_GCBBUILDSTR
	lfsr	1,VERSIONSTRING
	clrf	SysStringLength,ACCESS
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,GCBBUILDSTR
	rcall	SYSCOPYSTRINGPART
	lfsr	0,VERSIONSTRING
	movff	SysStringLength, INDF0
;versionString = versionString + "@"+GCBBuildTimeStr
	rcall	FN_GCBBUILDTIMESTR
	lfsr	1,VERSIONSTRING
	clrf	SysStringLength,ACCESS
	lfsr	0,VERSIONSTRING
	rcall	SYSCOPYSTRINGPART
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,GCBBUILDTIMESTR
	rcall	SYSCOPYSTRINGPART
	lfsr	0,VERSIONSTRING
	movff	SysStringLength, INDF0
;HSerPrint "USB CGB  "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*9
	rcall	HSERPRINT375
;HSerPrint versionString
	movlw	low VERSIONSTRING
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high VERSIONSTRING
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT375
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;------ End of Version Control - optional
;Define USB specific callback handlers
;MANDATED to handle you solution
;optional callback handlers for error and descriptor call.
;Solution specific configuration
;----- Define Hardware settings
;USART
;ADC
;------ Ports
;Dir KEEPALIVELED      OUT
	bcf	TRISC,0,ACCESS
;Dir REDLED            OUT
	bcf	TRISC,1,ACCESS
;Dir YELLOWLED         OUT
	bcf	TRISC,2,ACCESS
;Dir GREENLED          OUT
	bcf	TRISC,3,ACCESS
;Dir INPUT1            IN
	bsf	TRISB,4,ACCESS
;Dir INPUT2            IN
	bsf	TRISA,3,ACCESS
;Dir INPUT3            IN
	bsf	TRISA,4,ACCESS
;Dir INPUT4            IN
	bsf	TRISA,5,ACCESS
;----- Main body of program commences here
;Do
SysDoLoop_S1
;Do nothing just wait for the USB Interrupt
;Do not sleep the MCU!!
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;end
	bra	BASPROGRAMEND
;----- Support methods.  User call backs
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: USB_LIBKWINUSB_18F14K50_Demonstration.gcb (203)
DESCRIPTORHANDLER_CALLBACK
;HSerPrint "Desc: "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*6
	rcall	HSERPRINT375
;HSerPrint USBDescType
	movff	USBDESCTYPE,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT377
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	bra	HSERPRINTCRLF

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	179
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	21
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

;Source: USB_LIBKWINUSB_18F14K50_Demonstration.gcb (128)
ERRORHANDLER_CALLBACK
;HSerPrint "Error: "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*7
	rcall	HSERPRINT375
;HSerPrint Hex(UEIR)
	movff	UEIR,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT375
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	bra	HSERPRINTCRLF

;********************************************************************************

;Source: gcbversionnumber.gcb (2)
FN_GCBBUILDSTR
;GCBBuildStr="57"
	lfsr	1,GCBBUILDSTR
	movlw	low StringTable23
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable23
	movwf	TBLPTRH,ACCESS
	bra	SYSREADSTRING

;********************************************************************************

;Source: gcbversionnumber.gcb (5)
FN_GCBBUILDTIMESTR
;GCBBuildTimeStr="10-20-2026 13:03:12"
	lfsr	1,GCBBUILDTIMESTR
	movlw	low StringTable24
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable24
	movwf	TBLPTRH,ACCESS
	bra	SYSREADSTRING

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (3402)
HSERPRINT375
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF33
;Write Data
;for SysPrintTemp = 1 to PrintLen
;Legacy method
	clrf	SYSPRINTTEMP,ACCESS
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
	incf	SYSPRINTTEMP,F,ACCESS
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND363
;next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;End If
ENDIF33
;CR
;All Usarts
;--------------------------
;Specific USARTs
;------------------
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (3476)
HSERPRINT377
;OutValueTemp = 0
	clrf	OUTVALUETEMP,ACCESS
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ENDIF55
;OutValueTemp = SerPrintVal / 100
	movff	SERPRINTVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	rcall	SYSDIVSUB
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,ACCESS
	movwf	SERDATA,ACCESS
	rcall	HSERSEND363
;End If
ENDIF55
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	rcall	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp2
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp2,W,ACCESS
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,ACCESS
	btfss	SysTemp1,0,ACCESS
	bra	ENDIF56
;OutValueTemp = SerPrintVal / 10
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SYSDIVSUB
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,ACCESS
	movwf	SERDATA,ACCESS
	rcall	HSERSEND363
;End If
ENDIF56
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W,ACCESS
	movwf	SERDATA,ACCESS
	bra	HSERSEND363
;CR

;********************************************************************************

;Source: usart.h (3610)
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
	rcall	HSERSEND363
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,ACCESS
	rcall	HSERSEND363
;end Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (2071)
HSERSEND363
HSERSENDUSART1HANDLER
;USART_BLOCKING and NOT USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop2
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop2
;Wait until TRMT = 1
SysWaitLoop3
	btfss	TXSTA,TRMT,ACCESS
	bra	SysWaitLoop3
;TXREG = SerData
	movff	SERDATA,TXREG
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	bra	Delay_MS

;********************************************************************************

;Source: system.h (211)
INITSYS
;_For_selected_frequency_-_the_external_oscillator_has_been_selected_by_compiler ChipMHz
;Clear BSR on ChipFamily16 MCUs
;MOVLB 0
	movlb	0
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;ANSEL = 0
	clrf	ANSEL,ACCESS
;ANSELH = 0
	clrf	ANSELH,ACCESS
;Set comparator register bits for many MCUs with register CM2CON0
;C2ON = 0
	bcf	CM2CON0,C2ON,ACCESS
;C1ON = 0
	bcf	CM1CON0,C1ON,ACCESS
;Turn off all ports
;PORTA = 0
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
;ClearRAM
;Macro Source: system.h (1838)
;No code. User has not included <clearram.h>
	return

;********************************************************************************

;Source: usart.h (1284)
INITUSART
;PIC USART 1 Init
;Set baud rate for chips with BRG16 bit
;SPBRGH = SPBRGH_TEMP
	clrf	SPBRGH,ACCESS
;SPBRG = SPBRGL_TEMP
	movlw	103
	movwf	SPBRG,ACCESS
;BRG16 = BRG16_TEMP
	bsf	BAUDCON,BRG16,ACCESS
;BRGH = BRGH_TEMP
	bsf	TXSTA,BRGH,ACCESS
;SYNC=0
	bcf	TXSTA,SYNC,ACCESS
;TXEN=1
	bsf	TXSTA,TXEN,ACCESS
;SPEN=1
	bsf	RCSTA,SPEN,ACCESS
;CREN=1
	bsf	RCSTA,CREN,ACCESS
;CREN=1
	bsf	RCSTA,CREN,ACCESS
	return

;********************************************************************************

;Source: usb.h (288)
INITUSB
;Time for PLL to stabilise
;Wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Add interrupt handlers
;UIE = 127
	movlw	127
	movwf	UIE,ACCESS
;UEIE = b'10011111'
	movlw	159
	banksel	UEIE
	movwf	UEIE,BANKED
;On Interrupt USB Call USBInterruptHandler
	bsf	PIE2,USBIE,ACCESS
;Set up USB module
;Set UCFG.FSEN On
	bsf	UCFG,FSEN,ACCESS
;Set UCFG.UPUEN On
	bsf	UCFG,UPUEN,ACCESS
;USBResetEndpoints
;Macro Source: usb.h (323)
;Take ownership of all endpoints
;USB_OUT0_STAT = 8
	movlw	8
	banksel	USB_OUT0_STAT
	movwf	USB_OUT0_STAT,BANKED
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT,BANKED
;Clear transmission complete flag
;Do While TRNIF
SysDoLoop_S2
	btfss	UIR,TRNIF,ACCESS
	bra	SysDoLoop_E2
;TRNIF = 0
	bcf	UIR,TRNIF,ACCESS
;Loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;Disable endpoints
;UEP0 = 0
	banksel	UEP0
	clrf	UEP0,BANKED
;USB_IN0_ADDR = USB_RAM_START + 64
	movlw	64
	banksel	USB_IN0_ADDR
	movwf	USB_IN0_ADDR,BANKED
	movlw	2
	movwf	USB_IN0_ADDR_H,BANKED
;USB_OUT0_ADDR = USB_RAM_START + 64 + USB_MAX_PACKET
	movlw	192
	movwf	USB_OUT0_ADDR,BANKED
	movlw	2
	movwf	USB_OUT0_ADDR_H,BANKED
;Set buffer data counts to 0
;USB_IN0_CNT = 0
	clrf	USB_IN0_CNT,BANKED
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	movwf	USB_OUT0_CNT,BANKED
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT,BANKED
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
;Set up endpoint 0 for handshaking, setup, in and out, but not stalled
;PKTDIS = 0
	bcf	UCON,PKTDIS,ACCESS
;UEP0 = b'00010110'
	movlw	22
	banksel	UEP0
	movwf	UEP0,BANKED
;Clear interrupt flags
;UIR = 0
	clrf	UIR,ACCESS
;UEIR = 0
	clrf	UEIR,BANKED
;UADDR = 0
	clrf	UADDR,BANKED
;USBState = USB_STATE_POWERED
	clrf	USBSTATE,ACCESS
;USBCurrConfiguration = 0
	clrf	USBCURRCONFIGURATION,ACCESS
;Enable
;Set UCON.USBEN On
	bsf	UCON,USBEN,ACCESS
	banksel	0
	return

;********************************************************************************

INTERRUPT
;Save Context
	movff	WREG,SysW
	movff	STATUS,SysSTATUS
	movff	BSR,SysBSR
;Store system variables
	movff	SysTemp1,SaveSysTemp1
	movff	SysByteTempA,SaveSysByteTempA
	movff	SysByteTempB,SaveSysByteTempB
	movff	FSR0L,SaveFSR0L
	movff	FSR0H,SaveFSR0H
	movff	SysByteTempX,SaveSysByteTempX
	movff	SysDivLoop,SaveSysDivLoop
	movff	SysTemp2,SaveSysTemp2
	movff	FSR1L,SaveFSR1L
	movff	FSR1H,SaveFSR1H
	movff	SysStringLength,SaveSysStringLength
	movff	SysWaitTempMS,SaveSysWaitTempMS
	movff	SysWaitTempMS_H,SaveSysWaitTempMS_H
	movff	DelayTemp2,SaveDelayTemp2
	movff	SysStringA,SaveSysStringA
;On Interrupt handlers
	btfss	PIE2,USBIE,ACCESS
	bra	NotUSBIF
	btfss	PIR2,USBIF,ACCESS
	bra	NotUSBIF
	rcall	USBINTERRUPTHANDLER
	bcf	PIR2,USBIF,ACCESS
	bra	INTERRUPTDONE
NotUSBIF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	movff	SaveSysTemp1,SysTemp1
	movff	SaveSysByteTempA,SysByteTempA
	movff	SaveSysByteTempB,SysByteTempB
	movff	SaveFSR0L,FSR0L
	movff	SaveFSR0H,FSR0H
	movff	SaveSysByteTempX,SysByteTempX
	movff	SaveSysDivLoop,SysDivLoop
	movff	SaveSysTemp2,SysTemp2
	movff	SaveFSR1L,FSR1L
	movff	SaveFSR1H,FSR1H
	movff	SaveSysStringLength,SysStringLength
	movff	SaveSysWaitTempMS,SysWaitTempMS
	movff	SaveSysWaitTempMS_H,SysWaitTempMS_H
	movff	SaveDelayTemp2,DelayTemp2
	movff	SaveSysStringA,SysStringA
	movff	SysW,WREG
	movff	SysSTATUS,STATUS
	movff	SysBSR,BSR
	retfie	0

;********************************************************************************

;Source: stdbasic.h (124)
FN_PEEK
;FSR0H = MemAdr_H
	movff	MEMADR_H,FSR0H
;FSR0L = MemAdr
	movff	MEMADR,FSR0L
;PEEK = INDF0
	movff	INDF0,PEEK
	return

;********************************************************************************

;Source: stdbasic.h (102)
POKE
;Dim MemAdr As Word Alias FSR0H, FSR0L
;FSR0H = MemAdr_H
;FSR0L = MemAdr
;INDF0 = MemData
	movff	MEMDATA,INDF0
	return

;********************************************************************************

;Source: USB_LIBKWINUSB_18F14K50_Demonstration.gcb (134)
SETUPHANDLER_CALLBACK
;Select Case USBRequest
;Red LED handler
;Response to control request: Transfer USBDEVICEREADREDLEDSTATUS, send status of port
;Case USBDEVICEREADREDLEDSTATUS
SysSelect6Case1
	movlw	130
	banksel	USBREQUEST
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case2
;USBBufferWrite( REDLED_LAT )
	clrf	_USBINVALUE,ACCESS
	btfsc	LATC,1,ACCESS
	incf	_USBINVALUE,F,ACCESS
	banksel	0
	rcall	USBBUFFERWRITE14
	bcf	LATC,1,ACCESS
	btfsc	_USBINVALUE,0,ACCESS
	bsf	LATC,1,ACCESS
;Response to control request: Transfer USBDEVICESETREDLEDON, turn on LED
;Case USBDEVICESETREDLEDON
	bra	SysSelectEnd6
SysSelect6Case2
	movlw	131
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case3
;Set REDLED On
	bsf	LATC,1,ACCESS
;Response to control request: Transfer USBDEVICESETREDLEDOFF, turn off LED
;Case USBDEVICESETREDLEDOFF
	bra	SysSelectEnd6
SysSelect6Case3
	movlw	132
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case4
;Set REDLED Off
	bcf	LATC,1,ACCESS
;Yellow LED handler
;Response to control request: Transfer USBDEVICEREADYELLOWLEDSTATUS, send status of port
;Case USBDEVICEREADYELLOWLEDSTATUS
	bra	SysSelectEnd6
SysSelect6Case4
	movlw	133
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case5
;USBBufferWrite( YELLOWLED_LAT )
	clrf	_USBINVALUE,ACCESS
	btfsc	LATC,2,ACCESS
	incf	_USBINVALUE,F,ACCESS
	banksel	0
	rcall	USBBUFFERWRITE14
	bcf	LATC,2,ACCESS
	btfsc	_USBINVALUE,0,ACCESS
	bsf	LATC,2,ACCESS
;Response to control request: Transfer USBDEVICESETYELLOWLEDON, turn on LED
;Case USBDEVICESETYELLOWLEDON
	bra	SysSelectEnd6
SysSelect6Case5
	movlw	134
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case6
;Set YELLOWLED On
	bsf	LATC,2,ACCESS
;Response to control request: Transfer USBDEVICESETYELLOWLEDOFF, turn off LED
;Case USBDEVICESETYELLOWLEDOFF
	bra	SysSelectEnd6
SysSelect6Case6
	movlw	135
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case7
;Set YELLOWLED Off
	bcf	LATC,2,ACCESS
;Green LED handler
;Response to control request: Transfer USBDEVICEREADGREENLEDSTATUS, send status of port
;Case USBDEVICEREADGREENLEDSTATUS
	bra	SysSelectEnd6
SysSelect6Case7
	movlw	136
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case8
;USBBufferWrite( GREENLED_LAT )
	clrf	_USBINVALUE,ACCESS
	btfsc	LATC,3,ACCESS
	incf	_USBINVALUE,F,ACCESS
	banksel	0
	rcall	USBBUFFERWRITE14
	bcf	LATC,3,ACCESS
	btfsc	_USBINVALUE,0,ACCESS
	bsf	LATC,3,ACCESS
;Response to control request: Transfer USBDEVICESETGREENLEDON, turn on LED
;Case USBDEVICESETGREENLEDON
	bra	SysSelectEnd6
SysSelect6Case8
	movlw	137
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case9
;Set GREENLED On
	bsf	LATC,3,ACCESS
;Response to control request: Transfer USBDEVICESETGREENLEDOFF, turn off LED
;Case USBDEVICESETGREENLEDOFF
	bra	SysSelectEnd6
SysSelect6Case9
	movlw	138
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case10
;Set GREENLED Off
	bcf	LATC,3,ACCESS
;Switches: I/O 5 to 8
;Case USBDEVICERPORTSTATUS
	bra	SysSelectEnd6
SysSelect6Case10
	movlw	140
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case11
;USBBufferWrite( INPUT1 )
	clrf	_USBINVALUE,ACCESS
	btfsc	PORTB,4,ACCESS
	incf	_USBINVALUE,F,ACCESS
	banksel	0
	rcall	USBBUFFERWRITE14
	bcf	LATB,4,ACCESS
	btfsc	_USBINVALUE,0,ACCESS
	bsf	LATB,4,ACCESS
;USBBufferWrite( INPUT2 )
	clrf	_USBINVALUE,ACCESS
	btfsc	PORTA,3,ACCESS
	incf	_USBINVALUE,F,ACCESS
	rcall	USBBUFFERWRITE14
	bcf	LATA,3,ACCESS
	btfsc	_USBINVALUE,0,ACCESS
	bsf	LATA,3,ACCESS
;USBBufferWrite( INPUT3 )
	clrf	_USBINVALUE,ACCESS
	btfsc	PORTA,4,ACCESS
	incf	_USBINVALUE,F,ACCESS
	rcall	USBBUFFERWRITE14
	bcf	LATA,4,ACCESS
	btfsc	_USBINVALUE,0,ACCESS
	bsf	LATA,4,ACCESS
;USBBufferWrite( INPUT4 )
	clrf	_USBINVALUE,ACCESS
	btfsc	PORTA,5,ACCESS
	incf	_USBINVALUE,F,ACCESS
	rcall	USBBUFFERWRITE14
	bcf	LATA,5,ACCESS
	btfsc	_USBINVALUE,0,ACCESS
	bsf	LATA,5,ACCESS
;Response to control request: Transfer 255, keep alive
;Case USBDEVICEKEEPALIVE
	bra	SysSelectEnd6
SysSelect6Case11
	incf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case12
;USBBufferWrite( USBDEVICEKEEPALIVE )
	setf	_USBINVALUE,ACCESS
	banksel	0
	rcall	USBBUFFERWRITE14
;KEEPALIVELED = !KEEPALIVELED
	clrf	SysTemp2,ACCESS
	btfsc	PORTC,0,ACCESS
	incf	SysTemp2,F,ACCESS
	comf	SysTemp2,F,ACCESS
	bcf	LATC,0,ACCESS
	btfsc	SysTemp2,0,ACCESS
	bsf	LATC,0,ACCESS
;Handle the others via the serial port as we do not know what they are
;Case Else
	bra	SysSelectEnd6
SysSelect6Case12
;HSerPrint "Req "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*4
	rcall	HSERPRINT375
;HSerPrint USBTempBuffer(1)
	movff	SYSUSBTEMPBUFFER_1,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT377
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;End Select
SysSelectEnd6
	banksel	0
	return

;********************************************************************************

;Source: system.h (4588)
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

;Source: system.h (1853)
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

;Source: system.h (3524)
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

;Source: system.h (2050)
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

StringTable3
	db	14,71,67,66,32,85,83,66,32,118,49,46,52,46,50


StringTable5
	db	5,66,117,105,108,100


StringTable6
	db	1,64


StringTable7
	db	9,85,83,66,32,67,71,66,32,32


StringTable8
	db	7,69,114,114,111,114,58,32


StringTable9
	db	4,82,101,113,32


StringTable10
	db	6,68,101,115,99,58,32


StringTable11
	db	7,71,67,66,65,83,73,67


StringTable16
	db	0


StringTable23
	db	2,53,55


StringTable24
	db	19,49,48,45,50,48,45,50,48,50,54,32,49,51,58,48,51,58,49,50


;********************************************************************************

;Overloaded signature: BYTE:, Source: usb.h (968)
USBBUFFERWRITE14
;Increment the buffer counter
;USB_IN0_CNT++
	banksel	USB_IN0_CNT
	incf	USB_IN0_CNT,F,BANKED
;Poke USB_IN0_ADDR+USB_CNT_POINTER, _USBinValue
	movf	USB_CNT_POINTER,W,ACCESS
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	_USBINVALUE,MEMDATA
	banksel	0
	rcall	POKE
;Increment the data pointer
;USB_CNT_POINTER++
	incf	USB_CNT_POINTER,F,ACCESS
	return

;********************************************************************************

USBCONFIGDESCRIPTOR
	movlw	18
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEUSBCONFIGDESCRIPTOR
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEUSBCONFIGDESCRIPTOR
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEUSBCONFIGDESCRIPTOR
	db	18,9,2,18,0,1,1,0,128,25,9,4,0,0,0,255,0,255

;********************************************************************************

USBDEVICEDESCRIPTOR
	movlw	19
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEUSBDEVICEDESCRIPTOR
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEUSBDEVICEDESCRIPTOR
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEUSBDEVICEDESCRIPTOR
	db	18,18,1,0,2,0,0,0,64,9,18,6,32,0,0,1,2,0,1

;********************************************************************************

USBDEVICEQUALDESCRIPTOR
	movlw	10
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEUSBDEVICEQUALDESCRIPTOR
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEUSBDEVICEQUALDESCRIPTOR
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEUSBDEVICEQUALDESCRIPTOR
	db	10,10,6,0,2,0,0,0,64,1

;********************************************************************************

;Source: usb.h (353)
USBINTERRUPTHANDLER
;PIC18: select bank 0 first. GCBASIC's interrupt saves BSR but does not set it, and this code is compiled on the
;assumption that BSR = 0 (its first banked accesses have no BANKSEL). Without this, an interrupt taken while the
;main program had another bank selected (a GLCD program drawing, for example) wrote into that bank, and the device
;did not answer: "Device Descriptor Request Failed" on the PIC18F Starter Kit (as usb_cdc.h's fix of 28/09/2026).
;BSR = 0
	clrf	BSR,ACCESS
;Event that should be handled by library?
;Reset
;If URSTIF Then
	btfss	UIR,URSTIF,ACCESS
	bra	ENDIF2
;USBResetEndpoints
;Macro Source: usb.h (323)
;Take ownership of all endpoints
;USB_OUT0_STAT = 8
	movlw	8
	banksel	USB_OUT0_STAT
	movwf	USB_OUT0_STAT,BANKED
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT,BANKED
;Clear transmission complete flag
;Do While TRNIF
SysDoLoop_S3
	btfss	UIR,TRNIF,ACCESS
	bra	SysDoLoop_E3
;TRNIF = 0
	bcf	UIR,TRNIF,ACCESS
;Loop
	bra	SysDoLoop_S3
SysDoLoop_E3
;Disable endpoints
;UEP0 = 0
	banksel	UEP0
	clrf	UEP0,BANKED
;USB_IN0_ADDR = USB_RAM_START + 64
	movlw	64
	banksel	USB_IN0_ADDR
	movwf	USB_IN0_ADDR,BANKED
	movlw	2
	movwf	USB_IN0_ADDR_H,BANKED
;USB_OUT0_ADDR = USB_RAM_START + 64 + USB_MAX_PACKET
	movlw	192
	movwf	USB_OUT0_ADDR,BANKED
	movlw	2
	movwf	USB_OUT0_ADDR_H,BANKED
;Set buffer data counts to 0
;USB_IN0_CNT = 0
	clrf	USB_IN0_CNT,BANKED
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	movwf	USB_OUT0_CNT,BANKED
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT,BANKED
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
;Set up endpoint 0 for handshaking, setup, in and out, but not stalled
;PKTDIS = 0
	bcf	UCON,PKTDIS,ACCESS
;UEP0 = b'00010110'
	movlw	22
	banksel	UEP0
	movwf	UEP0,BANKED
;UADDR = 0
	clrf	UADDR,BANKED
;Clear interrupt flags
;UEIR = 0
	clrf	UEIR,BANKED
;UIR = 0
	clrf	UIR,ACCESS
;SUSPND = 0
	bcf	UCON,SUSPND,ACCESS
;Wait for single ended zero to clear
;Wait While UCON.SE0
SysWaitLoop1
	btfsc	UCON,SE0,ACCESS
	bra	SysWaitLoop1
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,ACCESS
;USBState = USB_STATE_DEFAULT
	movlw	1
	movwf	USBSTATE,ACCESS
;USBCurrConfiguration = 0
	clrf	USBCURRCONFIGURATION,ACCESS
;End If
ENDIF2
;Error
;If UERRIF Then
	btfss	UIR,UERRIF,ACCESS
	bra	ENDIF3
;USB_ERROR_HANDLER
	banksel	0
	rcall	ERRORHANDLER_CALLBACK
;UEIR = 0
	banksel	UEIR
	clrf	UEIR,BANKED
;UERRIF = 0
	bcf	UIR,UERRIF,ACCESS
;End If
ENDIF3
;Activity on D+/D-
;If ACTVIF Then
	btfss	UIR,ACTVIF,ACCESS
	bra	ENDIF4
;If activity detected, switch from suspend to normal
;SUSPND = 0
	bcf	UCON,SUSPND,ACCESS
;Clear ACTVIF
;Do While ACTVIF
;Set ACTVIF Off
	bcf	UIR,ACTVIF,ACCESS
;Loop
;End If
ENDIF4
;Transfer complete
;If TRNIF Then
	btfss	UIR,TRNIF,ACCESS
	bra	ENDIF5
;Determine transfer that has occurred
;USBCurrEndpoint = (USTAT And 0x78) / 8
	movlw	120
	andwf	USTAT,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	banksel	0
	rcall	SYSDIVSUB
	movff	SysBYTETempA,USBCURRENDPOINT
;If USTAT.DIR Then
	btfss	USTAT,DIR,ACCESS
	bra	ELSE9_1
;In
;USBBufferStat = USB_IN0_STAT
	movff	USB_IN0_STAT,USBBUFFERSTAT
;Else
	bra	ENDIF9
ELSE9_1
;Setup/Out
;USBBufferStat = USB_OUT0_STAT
	movff	USB_OUT0_STAT,USBBUFFERSTAT
;USB_OUT0_STAT.UOWN = 0
	banksel	USB_OUT0_STAT
	bcf	USB_OUT0_STAT,7,BANKED
;End If
ENDIF9
;Get PID (is multiplied by 4)
;USBPID = USBBufferStat And 0x3C
	movlw	60
	andwf	USBBUFFERSTAT,W,ACCESS
	movwf	USBPID,ACCESS
;Select Case USBPID
;Case USB_PID_OUT
SysSelect1Case1
	movlw	4
	subwf	USBPID,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;Out transfer
;HSerPrint "OUT"
;HSerPrintCRLF
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	banksel	USB_OUT0_CNT
	movwf	USB_OUT0_CNT,BANKED
;USB_OUT0_STAT.UOWN = 1
	bsf	USB_OUT0_STAT,7,BANKED
;Case USB_PID_IN
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	36
	subwf	USBPID,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;In transfer completed
;HSerPrint "IN"
;HSerPrintCRLF
;Select Case USBLastControl
;Set address completed
;Case USB_SET_ADDRESS
SysSelect2Case1
	movlw	5
	subwf	USBLASTCONTROL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;UADDR = USBNewAddress
	movff	USBNEWADDRESS,UADDR
;USBState = USB_STATE_ADDRESS
	movlw	2
	movwf	USBSTATE,ACCESS
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,ACCESS
;Continue responding to Get Descriptor
;Case USB_GET_DESCRIPTOR
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	6
	subwf	USBLASTCONTROL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
;USBSendDescriptor
	banksel	0
	rcall	USBSENDDESCRIPTOR
;Case Else
	bra	SysSelectEnd2
SysSelect2Case3
;Prepare incoming buffer again
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	banksel	USB_OUT0_CNT
	movwf	USB_OUT0_CNT,BANKED
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
;End Select
SysSelectEnd2
;Case USB_PID_SETUP
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	52
	subwf	USBPID,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;Setup transfer
;Copy data to buffer
;For USBCurrByte = 0 to 7
;Legacy method
	setf	USBCURRBYTE,ACCESS
SysForLoop1
	incf	USBCURRBYTE,F,ACCESS
;USBTempBuffer(USBCurrByte) = Peek(USB_OUT0_ADDR + USBCurrByte)
	movf	USBCURRBYTE,W,ACCESS
	banksel	USB_OUT0_ADDR
	addwf	USB_OUT0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_OUT0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	banksel	0
	rcall	FN_PEEK
	lfsr	0,USBTEMPBUFFER
	movf	USBCURRBYTE,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	PEEK,INDF0
;Next
	movlw	7
	subwf	USBCURRBYTE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;Stop any outgoing transmissions
;USB_IN0_STAT = 8
	movlw	8
	banksel	USB_IN0_STAT
	movwf	USB_IN0_STAT,BANKED
;Prepare incoming buffer again
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	movwf	USB_OUT0_CNT,BANKED
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
;USBProcessSetup
	banksel	0
	rcall	USBPROCESSSETUP
;USBDumpControlIn
;HSerPrint "S"
;HSerPrintCRLF
;Case Else
	bra	SysSelectEnd1
SysSelect1Case4
;HSerPrint "PID Err "
;HSerPrint USBPID
;HSerPrintCRLF
;End Select
SysSelectEnd1
;USBHasData = True
	setf	USBHASDATA,ACCESS
;TRNIF = 0
	bcf	UIR,TRNIF,ACCESS
;End If
ENDIF5
;Idle
;If IDLEIF Then
	btfsc	UIR,IDLEIF,ACCESS
;IDLEIF = 0
	bcf	UIR,IDLEIF,ACCESS
;End If
;Stalled
;If STALLIF Then
	btfsc	UIR,STALLIF,ACCESS
;STALLIF = 0
	bcf	UIR,STALLIF,ACCESS
;End If
;Start of frame
;If SOFIF Then
	btfsc	UIR,SOFIF,ACCESS
;SOFIF = 0
	bcf	UIR,SOFIF,ACCESS
;End If
	banksel	0
	return

;********************************************************************************

;Source: usb.h (506)
USBPROCESSSETUP
;Buffer format:
;0:bmRequestType 1:bRequest 3-2:wValue 5-4:wIndex 7-6:wLength
;USBbmRequestType = USBTempBuffer(0) And 0x7F
	movlw	127
	banksel	SYSUSBTEMPBUFFER_0
	andwf	SYSUSBTEMPBUFFER_0,W,BANKED
	movwf	USBBMREQUESTTYPE,ACCESS
;Re-enable input processing
;PKTDIS = 0
	bcf	UCON,PKTDIS,ACCESS
;Device requests
;If USBbmRequestType = 0 Then
	movf	USBBMREQUESTTYPE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE11_1
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,ACCESS
;Select Case USBTempBuffer(1)
;Case USB_GET_STATUS
;Case USB_CLEAR_FEATURE
;Case USB_SET_FEATURE
;Case USB_SET_ADDRESS
SysSelect3Case1
	movlw	5
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;USBLastControl = USB_SET_ADDRESS
	movlw	5
	movwf	USBLASTCONTROL,ACCESS
;USBNewAddress = USBTempBuffer(2)
	movff	SYSUSBTEMPBUFFER_2,USBNEWADDRESS
;Send empty DATA1 packet
;USBSendDATA1Ack
	banksel	0
	rcall	USBSENDDATA1ACK
;Case USB_GET_DESCRIPTOR
	bra	SysSelectEnd3
SysSelect3Case2
	movlw	6
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case3
;USBLastControl = USB_GET_DESCRIPTOR
	movlw	6
	movwf	USBLASTCONTROL,ACCESS
;USBDescType = USBTempBuffer(3)
	movff	SYSUSBTEMPBUFFER_3,USBDESCTYPE
;USBDescIndex = USBTempBuffer(2)
	movff	SYSUSBTEMPBUFFER_2,USBDESCINDEX
;USBDescSizeIn = USBTempBuffer(6)
	movff	SYSUSBTEMPBUFFER_6,USBDESCSIZEIN
;USBDescStart = 0
	clrf	USBDESCSTART,ACCESS
;USBSendDescriptor
	banksel	0
	rcall	USBSENDDESCRIPTOR
;Case USB_SET_DESCRIPTOR
;Case USB_GET_CONFIGURATION
;Case USB_SET_CONFIGURATION
	bra	SysSelectEnd3
SysSelect3Case3
	movlw	9
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case4
;USBCurrConfiguration = USBTempBuffer(2)
	movff	SYSUSBTEMPBUFFER_2,USBCURRCONFIGURATION
;If USBCurrConfiguration = 0 Then
	movf	USBCURRCONFIGURATION,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE12_1
;USBState = USB_STATE_ADDRESS
	movlw	2
	movwf	USBSTATE,ACCESS
;Else
	bra	ENDIF12
ELSE12_1
;USBState = USB_STATE_CONFIGURED
	movlw	3
	movwf	USBSTATE,ACCESS
;End If
ENDIF12
;USBSendData1Ack
	banksel	0
	rcall	USBSENDDATA1ACK
;Unknown case - send to the User Handler
;Case Else
	bra	SysSelectEnd3
SysSelect3Case4
;Call the user callback
;USB_SETUP_HANDLER
	banksel	0
	rcall	SETUPHANDLER_CALLBACK
;End Select
SysSelectEnd3
;Else
	bra	ENDIF11
ELSE11_1
;USBDumpControlIn    'method to assist in debuggin
;clear the pointer.  If the pointer has been incremented then we know what to do!
;the is the number of buffer bytes to be sent
;USB_IN0_CNT = 0
	banksel	USB_IN0_CNT
	clrf	USB_IN0_CNT,BANKED
;point to the output buffer
;USB_CNT_POINTER = 0
	clrf	USB_CNT_POINTER,ACCESS
;Call the user callback
;USB_SETUP_HANDLER
	banksel	0
	rcall	SETUPHANDLER_CALLBACK
;if USB_IN0_CNT = 0 then
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE13_1
;No data added to the output buffer - just send an ACK
;USBSendData1Ack
	banksel	0
	rcall	USBSENDDATA1ACK
;else
	bra	ENDIF13
ELSE13_1
;Data is thee output buffer - send the data
;USBStartSend
;Macro Source: usb.h (813)
;If USB_IN0_STAT.6 Then
	btfss	USB_IN0_STAT,6,BANKED
	bra	ELSE14_1
;USB_IN0_STAT = b'10001000'
	movlw	136
	movwf	USB_IN0_STAT,BANKED
;Else
	bra	ENDIF14
ELSE14_1
;USB_IN0_STAT = b'11001000'
	movlw	200
	movwf	USB_IN0_STAT,BANKED
;End If
ENDIF14
;end if
ENDIF13
;End If
ENDIF11
	banksel	0
	return

;********************************************************************************

;Source: usb.h (823)
USBSENDDATA1ACK
;USB_IN0_CNT = 0
	banksel	USB_IN0_CNT
	clrf	USB_IN0_CNT,BANKED
;USB_IN0_STAT = 0xC8
	movlw	200
	movwf	USB_IN0_STAT,BANKED
	banksel	0
	return

;********************************************************************************

;Source: usb.h (615)
USBSENDDESCRIPTOR
;Descriptor types:
;1: Device
;2: Configuration
;4: Interface
;5: Endpoint
;3: String
;To send, need to copy into EP0 IN buffer
;Take ownership
;USB_IN0_STAT.UOWN = 0
	banksel	USB_IN0_STAT
	bcf	USB_IN0_STAT,7,BANKED
;Select Case USBDescType
;Device
;Case 1
SysSelect4Case1
	decf	USBDESCTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
;Copy bytes into buffer
;ReadTable USB_DEVICE_DESCRIPTOR, 1, USBSize
	movlw	18
	movwf	USBSIZE,ACCESS
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	subwf	USBDESCSIZEIN,W,ACCESS
	btfss	STATUS, C,ACCESS
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	movff	USBDESCSIZEIN,USBSIZE
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
;If USBDescStart >= USBSize Then
	movf	USBSIZE,W,ACCESS
	subwf	USBDESCSTART,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ELSE16_1
;USBSize = 0
	clrf	USBSIZE,ACCESS
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,ACCESS
;Else
	bra	ENDIF16
ELSE16_1
;USBSize -= USBDescStart
	movf	USBDESCSTART,W,ACCESS
	subwf	USBSIZE,F,ACCESS
;End If
ENDIF16
;For USBCurrByte = 1 To USBSize
;Legacy method
	clrf	USBCURRBYTE,ACCESS
	movlw	1
	subwf	USBSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
SysForLoop2
	incf	USBCURRBYTE,F,ACCESS
;ReadTable USB_DEVICE_DESCRIPTOR, USBCurrByte + USBDescStart, USBTempByte
	movf	USBDESCSTART,W,ACCESS
	addwf	USBCURRBYTE,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	banksel	0
	rcall	USBDEVICEDESCRIPTOR
	movwf	USBTEMPBYTE,ACCESS
;Poke USB_IN0_ADDR + (USBCurrByte - 1), USBTempByte
	decf	USBCURRBYTE,W,ACCESS
	movwf	SysTemp1,ACCESS
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
;Next
	movf	USBSIZE,W,ACCESS
	subwf	USBCURRBYTE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;USB_IN0_CNT = USBSize
	movff	USBSIZE,USB_IN0_CNT
;USBDescStart += USBSize
	movf	USBSIZE,W,ACCESS
	addwf	USBDESCSTART,F,ACCESS
;Configuration
;Case 2
	bra	SysSelectEnd4
SysSelect4Case2
	movlw	2
	subwf	USBDESCTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
;Copy bytes into buffer
;ReadTable USB_CONFIG_DESCRIPTOR, 0, USBSize
	movlw	18
	movwf	USBSIZE,ACCESS
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	subwf	USBDESCSIZEIN,W,ACCESS
	btfss	STATUS, C,ACCESS
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	movff	USBDESCSIZEIN,USBSIZE
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
;If USBDescStart >= USBSize Then
	movf	USBSIZE,W,ACCESS
	subwf	USBDESCSTART,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ELSE20_1
;USBSize = 0
	clrf	USBSIZE,ACCESS
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,ACCESS
;Else
	bra	ENDIF20
ELSE20_1
;USBSize -= USBDescStart
	movf	USBDESCSTART,W,ACCESS
	subwf	USBSIZE,F,ACCESS
;End If
ENDIF20
;For USBCurrByte = 1 To USBSize
;Legacy method
	clrf	USBCURRBYTE,ACCESS
	movlw	1
	subwf	USBSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
SysForLoop3
	incf	USBCURRBYTE,F,ACCESS
;ReadTable USB_CONFIG_DESCRIPTOR, USBCurrByte + USBDescStart, USBTempByte
	movf	USBDESCSTART,W,ACCESS
	addwf	USBCURRBYTE,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	banksel	0
	rcall	USBCONFIGDESCRIPTOR
	movwf	USBTEMPBYTE,ACCESS
;Poke USB_IN0_ADDR + (USBCurrByte - 1), USBTempByte
	decf	USBCURRBYTE,W,ACCESS
	movwf	SysTemp1,ACCESS
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
;Next
	movf	USBSIZE,W,ACCESS
	subwf	USBCURRBYTE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;USB_IN0_CNT = USBSize
	movff	USBSIZE,USB_IN0_CNT
;USBDescStart += USBSize
	movf	USBSIZE,W,ACCESS
	addwf	USBDESCSTART,F,ACCESS
;Device Qualifier
;Case 6
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	6
	subwf	USBDESCTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case4
;Copy bytes into buffer
;ReadTable USBDeviceQualDescriptor, 0, USBSize
	movlw	10
	movwf	USBSIZE,ACCESS
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	subwf	USBDESCSIZEIN,W,ACCESS
	btfss	STATUS, C,ACCESS
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	movff	USBDESCSIZEIN,USBSIZE
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
;If USBDescStart >= USBSize Then
	movf	USBSIZE,W,ACCESS
	subwf	USBDESCSTART,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ELSE24_1
;USBSize = 0
	clrf	USBSIZE,ACCESS
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,ACCESS
;Else
	bra	ENDIF24
ELSE24_1
;USBSize -= USBDescStart
	movf	USBDESCSTART,W,ACCESS
	subwf	USBSIZE,F,ACCESS
;End If
ENDIF24
;For USBCurrByte = 1 To USBSize
;Legacy method
	clrf	USBCURRBYTE,ACCESS
	movlw	1
	subwf	USBSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
	incf	USBCURRBYTE,F,ACCESS
;ReadTable USBDeviceQualDescriptor, USBCurrByte + USBDescStart, USBTempByte
	movf	USBDESCSTART,W,ACCESS
	addwf	USBCURRBYTE,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	banksel	0
	rcall	USBDEVICEQUALDESCRIPTOR
	movwf	USBTEMPBYTE,ACCESS
;Poke USB_IN0_ADDR + (USBCurrByte - 1), USBTempByte
	decf	USBCURRBYTE,W,ACCESS
	movwf	SysTemp1,ACCESS
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
;Next
	movf	USBSIZE,W,ACCESS
	subwf	USBCURRBYTE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;USB_IN0_CNT = USBSize
	movff	USBSIZE,USB_IN0_CNT
;USBDescStart += USBSize
	movf	USBSIZE,W,ACCESS
	addwf	USBDESCSTART,F,ACCESS
;String
;Case 3
	bra	SysSelectEnd4
SysSelect4Case4
	movlw	3
	subwf	USBDESCTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case5
;If USBDescIndex = 0 Then
	movf	USBDESCINDEX,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE27_1
;Assume that these aren't continued over
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,ACCESS
;Language ID
;Poke USB_IN0_ADDR, 4
	movff	USB_IN0_ADDR,MEMADR
	movff	USB_IN0_ADDR_H,MEMADR_H
	movlw	4
	movwf	MEMDATA,ACCESS
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + 1, 3
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	3
	movwf	MEMDATA,ACCESS
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + 2, 0x09
	movlw	2
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	9
	movwf	MEMDATA,ACCESS
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + 3, 0x04
	movlw	3
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	4
	movwf	MEMDATA,ACCESS
	banksel	0
	rcall	POKE
;USB_IN0_CNT = 4
	movlw	4
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT,BANKED
;Else
	bra	ENDIF27
ELSE27_1
;Get requested string
;Select Case USBDescIndex
;Vendor name
;Case 1: USBTempString = USB_VENDOR_NAME
SysSelect5Case1
	decf	USBDESCINDEX,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case2
;Case 1: USBTempString = USB_VENDOR_NAME
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SYSREADSTRING
;Product name
;Case 2: USBTempString = USB_PRODUCT_NAME
	bra	SysSelectEnd5
SysSelect5Case2
	movlw	2
	subwf	USBDESCINDEX,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case3
;Case 2: USBTempString = USB_PRODUCT_NAME
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SYSREADSTRING
;Other
;Case Else: USBTempString = ""
	bra	SysSelectEnd5
SysSelect5Case3
;Case Else: USBTempString = ""
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable16
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable16
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SYSREADSTRING
;End Select
SysSelectEnd5
;Format string into unicode string descriptor
;USB_IN0_CNT = 2 + (USBTempString(0) * 2)
	banksel	SYSUSBTEMPSTRING_0
	movf	SYSUSBTEMPSTRING_0,W,BANKED
	mullw	2
	movff	PRODL,SysTemp1
	movlw	2
	addwf	SysTemp1,W,ACCESS
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT,BANKED
;If USBDescStart > USB_IN0_CNT Then
	movf	USBDESCSTART,W,ACCESS
	subwf	USB_IN0_CNT,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ELSE29_1
;USB_IN0_CNT = 0
	clrf	USB_IN0_CNT,BANKED
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,ACCESS
;Else
	bra	ENDIF29
ELSE29_1
;USB_IN0_CNT -= USBDescStart
	movf	USBDESCSTART,W,ACCESS
	subwf	USB_IN0_CNT,F,BANKED
;End If
ENDIF29
;Poke USB_IN0_ADDR, USB_IN0_CNT
	movff	USB_IN0_ADDR,MEMADR
	movff	USB_IN0_ADDR_H,MEMADR_H
	movff	USB_IN0_CNT,MEMDATA
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + 1, 3
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	3
	movwf	MEMDATA,ACCESS
	banksel	0
	rcall	POKE
;For USBCurrByte = 1 to USBTempString(0)
;Legacy method
	clrf	USBCURRBYTE,ACCESS
	movlw	1
	banksel	SYSUSBTEMPSTRING_0
	subwf	SYSUSBTEMPSTRING_0,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
	incf	USBCURRBYTE,F,ACCESS
;USBTempByte = USBTempString(USBCurrByte)
	lfsr	0,USBTEMPSTRING
	movf	USBCURRBYTE,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,USBTEMPBYTE
;Poke USB_IN0_ADDR + (USBCurrByte * 2), USBTempByte
	movf	USBCURRBYTE,W,ACCESS
	mullw	2
	movff	PRODL,SysTemp1
	movf	SysTemp1,W,ACCESS
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + (USBCurrByte * 2 + 1), 0
	movf	USBCURRBYTE,W,ACCESS
	mullw	2
	movff	PRODL,SysTemp1
	incf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	clrf	MEMDATA,ACCESS
	banksel	0
	rcall	POKE
;Next
	banksel	SYSUSBTEMPSTRING_0
	movf	SYSUSBTEMPSTRING_0,W,BANKED
	subwf	USBCURRBYTE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;If USB_IN0_CNT > USBDescSizeIn Then USB_IN0_CNT = USBDescSizeIn
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W,BANKED
	subwf	USBDESCSIZEIN,W,ACCESS
	btfss	STATUS, C,ACCESS
;If USB_IN0_CNT > USBDescSizeIn Then USB_IN0_CNT = USBDescSizeIn
	movff	USBDESCSIZEIN,USB_IN0_CNT
;If USB_IN0_CNT > USBDescSizeIn Then USB_IN0_CNT = USBDescSizeIn
;USBDescStart += USB_IN0_CNT
	movf	USB_IN0_CNT,W,BANKED
	addwf	USBDESCSTART,F,ACCESS
;End If
ENDIF27
;Interface
;Case 4
;Endpoint
;Case 5
;Other
;Case Else
	bra	SysSelectEnd4
SysSelect4Case5
;USB_DESCRIPTOR_HANDLER
	banksel	0
	call	DESCRIPTORHANDLER_CALLBACK
;Exit Sub
	return
;End Select
SysSelectEnd4
;USBStartSend
;Macro Source: usb.h (813)
;If USB_IN0_STAT.6 Then
	banksel	USB_IN0_STAT
	btfss	USB_IN0_STAT,6,BANKED
	bra	ELSE28_1
;USB_IN0_STAT = b'10001000'
	movlw	136
	movwf	USB_IN0_STAT,BANKED
;Else
	bra	ENDIF28
ELSE28_1
;USB_IN0_STAT = b'11001000'
	movlw	200
	movwf	USB_IN0_STAT,BANKED
;End If
ENDIF28
	banksel	0
	return

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
	bra	ENDIF52
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
ENDIF52
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
SysForLoop7
	incf	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	rrcf	SYSVALTEMP,F,ACCESS
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,ACCESS
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF54
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
ENDIF54
;_HexPICAS(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYS_HEXPICAS_1
	movwf	SYS_HEXPICAS_1,BANKED
	banksel	0
	return

;********************************************************************************


 END
