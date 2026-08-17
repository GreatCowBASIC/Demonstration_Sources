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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\130_rotate_the_leds_using_16bit_timer0_.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\130_rotate_the_leds_using_16bit_timer0_.build\130_rotate_the_leds_using_16bit_timer0_.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\130_rotate_the_leds_using_16bit_timer0_.gcb"
 SUBTITLE    "08-14-2026 10:59:44"
#include <P18F46Q35.inc>
 CONFIG CPD = OFF, CP = OFF, WRTSAF = OFF, WRTD = OFF, WRTB = OFF, WDTE = OFF, XINST = OFF, LVP = OFF, MVECEN = OFF, MCLRE = INTMCLR, FCMEN = ON, CLKOUTEN = OFF, RSTOSC = EXTOSC, FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
COMPORT                          EQU    1280          ; 0x500 (SA)
LEDS                             EQU    1281          ; 0x501 (SA)
PRINTLEN                         EQU    1282          ; 0x502 (SA)
ROTATECOUNT                      EQU    1283          ; 0x503 (SA)
SERDATA                          EQU    1284          ; 0x504 (SA)
STRINGPOINTER                    EQU    1289          ; 0x509 (SA)
SYSCALCTEMPA                     EQU    1285          ; 0x505 (SA)
SYSPRINTDATAHANDLER              EQU    1290          ; 0x50A (SA)
SYSPRINTDATAHANDLER_H            EQU    1291          ; 0x50B (SA)
SYSPRINTTEMP                     EQU    1292          ; 0x50C (SA)
SYSSTRINGA                       EQU    1287          ; 0x507 (SA)
SYSSTRINGA_H                     EQU    1288          ; 0x508 (SA)
SYSSTRINGLENGTH                  EQU    1286          ; 0x506 (SA)
SYSSTRINGPARAM1                  EQU    5373          ; 0x14FD
SYSTEMP1                         EQU    1293          ; 0x50D (SA)
TMRNUMBER                        EQU    1294          ; 0x50E (SA)
TMRPOST                          EQU    1295          ; 0x50F (SA)
TMRPRES                          EQU    1296          ; 0x510 (SA)
TMRSOURCE                        EQU    1297          ; 0x511 (SA)
TMRVALUE                         EQU    1298          ; 0x512 (SA)
TMRVALUE_H                       EQU    1299          ; 0x513 (SA)

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
	rcall	INITSYS
	rcall	INITPPS
	rcall	INITUSART

;Start_of_the_main_program
;
;This demonstration flashes an LED to show the use of a 16Bit Timer 1
;
;This lesson configures Timer0 to count instruction cycles and to set a flag when it rolls
;over. This frees up the processor to do meaningful work rather than wasting instruction
;cycles in a timing loop using a 16bit timer.
;Using a counter provides a convenient method of measuring time or delay loops as it
;allows the processor to work on other tasks rather than counting instruction cycles.
;
;LEDs should flash  ~1 second.
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
;Chip Settings
;! The timer calculations are based on 16mHz.
;! You would need to recalculate the timer values if 16mHz is not used
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
;Initialise the timer.
;Firstly tell the compiler to use a 16bit timer for this program
;For this we need the following for timer0
;Prescaler with the FOSC/4 with no post scaler
;1:64
;
;Fosc = 16 MHz → instruction clock = Fosc/4 = 4 MHz → Tcy = 250 ns
;Prescaler 1:64 → each Timer0 tick = 64 × 250 ns = 16 µs
;16-bit mode, preload = 3036 (0x0BDC)
;Counts to overflow = 65536 − 3036 = 62,500
;Period = 62,500 × 16 µs = 1,000,000 µs = 1.000 s
;InitTimer0 Osc, PRE0_64 + TMR0_FOSC4 ,  POST0_1
	movlw	1
	movwf	TMRSOURCE,ACCESS
	movlw	70
	movwf	TMRPRES,ACCESS
	clrf	TMRPOST,ACCESS
	banksel	0
	rcall	INITTIMER0199
;Every 1 sec.  0x0bdc is calculated value using a tool like Mr E. Timer Helper
;SetTimer ( 0 , 3036  )
	clrf	TMRNUMBER,ACCESS
	movlw	220
	movwf	TMRVALUE,ACCESS
	movlw	11
	movwf	TMRVALUE_H,ACCESS
	rcall	SETTIMER197
;Start the Timer
;StartTimer 0
	clrf	TMRNUMBER,ACCESS
	rcall	STARTTIMER
;Create byte variable as a flag
;Dim TIMEOUT As Bit
;Initialize a variable to hold the LED states
;DIM LEDs AS BYTE
;LEDs = 0B0001  // Start with the first LED on
	movlw	1
	movwf	LEDS,ACCESS
;Initialize a counter for rotations
;DIM RotateCount AS BYTE
;RotateCount = 0
	clrf	ROTATECOUNT,ACCESS
;Do
SysDoLoop_S1
;wait for the event
;Wait While TMR0IF = 0
SysWaitLoop1
	btfss	PIR8,TMR0IF,ACCESS
	bra	SysWaitLoop1
;Clearing Timer 0 flag will reset event
;TMR0IF = 0
	bcf	PIR8,TMR0IF,ACCESS
;HSerPrintStringCRLF "."
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
;Using SYSSTRINGPARAM1*1
	rcall	HSERPRINTSTRINGCRLF
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
	bra	ENDIF1
;LEDs = 0B0001  // Reset to initial state
	movlw	1
	movwf	LEDS,ACCESS
;RotateCount = 0  // Reset counter
	clrf	ROTATECOUNT,ACCESS
;End If
ENDIF1
;Set timer. This value as close as you can get to 1s
;SetTimer ( 0 , 3036 )
	clrf	TMRNUMBER,ACCESS
	movlw	220
	movwf	TMRVALUE,ACCESS
	movlw	11
	movwf	TMRVALUE_H,ACCESS
	rcall	SETTIMER197
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

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
	bra	ENDIF13
;Write Data
;for SysPrintTemp = 1 to PrintLen
;Legacy method
	clrf	SYSPRINTTEMP,ACCESS
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
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
	bra	SysForLoop1
SysForLoopEnd1
;End If
ENDIF13
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,ACCESS
	rcall	HSERSEND345
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,ACCESS
	bra	HSERSEND345

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (2069)
HSERSEND345
HSERSENDUSART1HANDLER
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop2
	btfss	PIR5,U1TXIF,ACCESS
	bra	SysWaitLoop2
;TXREG = SerData
	movff	SERDATA,U1TXB
	return

;********************************************************************************

;Source: 130_rotate_the_leds_using_16bit_timer0_.gcb (88)
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
;OSCFRQ = 0b00000010    '4mhz
	movlw	2
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
INITTIMER0199
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
	bra	ELSE12_1
;SET TMRPost.5 ON
	bsf	TMRPOST,5,ACCESS
;ELSE
	bra	ENDIF12
ELSE12_1
;SET TMRPost.5 OFF
	bcf	TMRPOST,5,ACCESS
;END IF
ENDIF12
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
;Set TMRPost.4 ON '16-bit Timer0
	bsf	TMRPOST,4,ACCESS
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
	banksel	U1BRGH
	clrf	U1BRGH,BANKED
;U1BRGL=SPBRGL_TEMP
	movlw	103
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

;Overloaded signature: BYTE:WORD:, Source: timer.h (1238)
SETTIMER197
;If TMRNumber = 0 Then
	movf	TMRNUMBER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF7
;Handle chips with TMR0H
;TMR0H = TMRValue_H
	movff	TMRVALUE_H,TMR0H
;TMR0L = TMRValue
	movff	TMRVALUE,TMR0L
;exit to prevent default setting TMR0L = TMRValue
;exit sub
	return
;End If
ENDIF7
;If TMRNumber = 1 then
	decf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF8
;TMR1H = TMRValue_H
	movff	TMRVALUE_H,TMR1H
;TMR1L = TMRValue
	movff	TMRVALUE,TMR1L
;End If
ENDIF8
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
	bra	ENDIF10
;TMR3H = TMRValue_H
	movff	TMRVALUE_H,TMR3H
;TMR3L = TMRValue
	movff	TMRVALUE,TMR3L
;End If
ENDIF10
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
	bra	ENDIF2
;IF TMRNumber = 0 then Set T0EN on
	banksel	T0CON0
	bsf	T0CON0,T0EN,BANKED
;IF TMRNumber = 0 then Set T0EN on
ENDIF2
;IF TMRNumber = 1 then Set TMR1ON on
	decf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF3
;IF TMRNumber = 1 then Set TMR1ON on
	banksel	T1CON
	bsf	T1CON,TMR1ON,BANKED
;IF TMRNumber = 1 then Set TMR1ON on
ENDIF3
;IF TMRNumber = 2 then Set TMR2ON on
	movlw	2
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF4
;IF TMRNumber = 2 then Set TMR2ON on
	banksel	T2CON
	bsf	T2CON,TMR2ON,BANKED
;IF TMRNumber = 2 then Set TMR2ON on
ENDIF4
;IF TMRNumber = 3 then Set TMR3ON on
	movlw	3
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF5
;IF TMRNumber = 3 then Set TMR3ON on
	banksel	T3CON
	bsf	T3CON,TMR3ON,BANKED
;IF TMRNumber = 3 then Set TMR3ON on
ENDIF5
;IF TMRNumber = 4 then Set TMR4ON on
	movlw	4
	subwf	TMRNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF6
;IF TMRNumber = 4 then Set TMR4ON on
	banksel	T4CON
	bsf	T4CON,TMR4ON,BANKED
;IF TMRNumber = 4 then Set TMR4ON on
ENDIF6
	banksel	0
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
	db	1,46


;********************************************************************************


 END
