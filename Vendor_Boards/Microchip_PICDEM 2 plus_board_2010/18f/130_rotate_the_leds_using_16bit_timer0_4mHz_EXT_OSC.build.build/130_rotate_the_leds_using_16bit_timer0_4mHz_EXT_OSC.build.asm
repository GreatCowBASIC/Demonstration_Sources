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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\130_rotate_the_leds_using_16bit_timer0_4mHz_EXT_OSC.build.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : "C:\GCstudio\picas\v4.00\pic-as\bin\pic-as.exe"
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\130_rotate_the_leds_using_16bit_timer0_4mHz_EXT_OSC.build.build\130_rotate_the_leds_using_16bit_timer0_4mHz_EXT_OSC.build.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\130_rotate_the_leds_using_16bit_timer0_4mHz_EXT_OSC.build.gcb"
 SUBTITLE    "08-14-2026 11:06:04"
#include <P18F46Q35.inc>
 CONFIG CPD = OFF, CP = OFF, WRTSAF = OFF, WRTD = OFF, WRTB = OFF, WDTE = OFF, XINST = OFF, LVP = OFF, MVECEN = OFF, MCLRE = INTMCLR, FCMEN = ON, CLKOUTEN = OFF, RSTOSC = EXTOSC, FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
COMPORT                          EQU    1280          ; 0X500 (SA)
LEDS                             EQU    1281          ; 0X501 (SA)
PRINTLEN                         EQU    1282          ; 0X502 (SA)
ROTATECOUNT                      EQU    1283          ; 0X503 (SA)
SERDATA                          EQU    1284          ; 0X504 (SA)
STRINGPOINTER                    EQU    1289          ; 0X509 (SA)
SYSCALCTEMPA                     EQU    1285          ; 0X505 (SA)
SYSPRINTDATAHANDLER              EQU    1290          ; 0X50A (SA)
SYSPRINTDATAHANDLER_H            EQU    1291          ; 0X50B (SA)
SYSPRINTTEMP                     EQU    1292          ; 0X50C (SA)
SYSSTRINGA                       EQU    1287          ; 0X507 (SA)
SYSSTRINGA_H                     EQU    1288          ; 0X508 (SA)
SYSSTRINGLENGTH                  EQU    1286          ; 0X506 (SA)
SYSSTRINGPARAM1                  EQU    5373          ; 0X14FD
SYSTEMP1                         EQU    1293          ; 0X50D (SA)
TMRNUMBER                        EQU    1294          ; 0X50E (SA)
TMRPOST                          EQU    1295          ; 0X50F (SA)
TMRPRES                          EQU    1296          ; 0X510 (SA)
TMRSOURCE                        EQU    1297          ; 0X511 (SA)
TMRVALUE                         EQU    1298          ; 0X512 (SA)
TMRVALUE_H                       EQU    1299          ; 0X513 (SA)

;********************************************************************************

;ALIAS VARIABLES
AFSR0                            EQU 1257
AFSR0_H                          EQU 1258

;********************************************************************************

;VECTORS
	ORG	0
	GOTO	BASPROGRAMSTART
	ORG	8
	RETFIE

;********************************************************************************

;PROGRAM_MEMORY_PAGE: 0
	ORG	12
BASPROGRAMSTART
;CALL INITIALISATION ROUTINES
	RCALL	INITSYS
	RCALL	INITPPS
	RCALL	INITUSART

;START_OF_THE_MAIN_PROGRAM
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
;! The timer calculations are based on 4mHz external oscillator
;! You would need to recalculate the timer values if 4mHz is not used
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
	BANKSEL	TRISB
	BCF	TRISB,0,BANKED
;Dir     LEDD1 Out
	BCF	TRISB,1,BANKED
;Dir     LEDD2 Out
	BCF	TRISB,2,BANKED
;Dir     LEDD3 Out
	BCF	TRISB,3,BANKED
;This is the PORTA.0 port
;Dir POTENTIOMETER In
	BSF	TRISA,0,BANKED
;Dir     SWITCHIN      In
	BSF	TRISA,4,BANKED
;Dir     RSTBUTTON     In  // this is set automatically - and, you cannot set as an output
	BSF	TRISE,3,BANKED
;! Specify explicit OCULAR_OM1614 support!!
;Setup LCD Parameters
;Define LCD Hardware settings
;! Required for OCULAR LCD driver
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Initialise the timer.
;Firstly tell the compiler to use a 16bit timer for this program
;For this we need the following for timer0
;Fosc = 4 MHz → instruction clock = Fosc/4 = 1 MHz → Tcy = 1 µs
;Prescaler 1:64 → each Timer0 tick = 64 × 1 µs = 64 µs
;16-bit mode, preload = 49911 (0xC2B7)
;Counts to overflow = 65536 − 49911 = 15,625
;Period = 15,625 × 64 µs = 1,000,000 µs = 1.000 s
;InitTimer0 Osc, PRE0_64 + TMR0_FOSC4 ,  POST0_1
	MOVLW	1
	MOVWF	TMRSOURCE,ACCESS
	MOVLW	70
	MOVWF	TMRPRES,ACCESS
	CLRF	TMRPOST,ACCESS
	BANKSEL	0
	RCALL	INITTIMER0199
;Every 1 sec.
;SetTimer ( 0 , 49911  )
	CLRF	TMRNUMBER,ACCESS
	MOVLW	247
	MOVWF	TMRVALUE,ACCESS
	MOVLW	194
	MOVWF	TMRVALUE_H,ACCESS
	RCALL	SETTIMER197
;Start the Timer
;StartTimer 0
	CLRF	TMRNUMBER,ACCESS
	RCALL	STARTTIMER
;Create byte variable as a flag
;Dim TIMEOUT As Bit
;Initialize a variable to hold the LED states
;DIM LEDs AS BYTE
;LEDs = 0B0001  // Start with the first LED on
	MOVLW	1
	MOVWF	LEDS,ACCESS
;Initialize a counter for rotations
;DIM RotateCount AS BYTE
;RotateCount = 0
	CLRF	ROTATECOUNT,ACCESS
;Do
SYSDOLOOP_S1
;wait for the event
;Wait While TMR0IF = 0
SYSWAITLOOP1
	BTFSS	PIR8,TMR0IF,ACCESS
	BRA	SYSWAITLOOP1
;Clearing Timer 0 flag will reset event
;TMR0IF = 0
	BCF	PIR8,TMR0IF,ACCESS
;HSerPrintStringCRLF "."
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE1
	MOVWF	TBLPTRL,ACCESS
	MOVLW	HIGH STRINGTABLE1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE1
	MOVWF	TBLPTRU,ACCESS
	RCALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
;USING SYSSTRINGPARAM1*1
	RCALL	HSERPRINTSTRINGCRLF
;Output the current state to PORTB
;LATB = LEDs
	MOVFF	LEDS,LATB
;Rotate the LEDs to the left
;Rotate LEDs Left Simple
	RLNCF	LEDS,F,ACCESS
;Increment the rotation counter
;RotateCount = RotateCount + 1
	INCF	ROTATECOUNT,F,ACCESS
;Reset the LEDs after 4 rotations
;If RotateCount >= 4 Then
	MOVLW	4
	SUBWF	ROTATECOUNT,W,ACCESS
	BTFSS	STATUS, C,ACCESS
	BRA	ENDIF1
;LEDs = 0B0001  // Reset to initial state
	MOVLW	1
	MOVWF	LEDS,ACCESS
;RotateCount = 0  // Reset counter
	CLRF	ROTATECOUNT,ACCESS
;End If
ENDIF1
;Set timer. This value as close as you can get to 1s
;SetTimer ( 0 , 49911 )
	CLRF	TMRNUMBER,ACCESS
	MOVLW	247
	MOVWF	TMRVALUE,ACCESS
	MOVLW	194
	MOVWF	TMRVALUE_H,ACCESS
	RCALL	SETTIMER197
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1
BASPROGRAMEND
	SLEEP
	BRA	BASPROGRAMEND

;********************************************************************************

;SOURCE: USART.H (3382)
HSERPRINTSTRINGCRLF
;PrintLen = PrintData(0)
	MOVFF	SYSPRINTDATAHANDLER,AFSR0
	MOVFF	SYSPRINTDATAHANDLER_H,AFSR0_H
	MOVFF	INDF0,PRINTLEN
;If PrintLen <> 0 then
	MOVF	PRINTLEN,F,ACCESS
	BTFSC	STATUS, Z,ACCESS
	BRA	ENDIF13
;Write Data
;for SysPrintTemp = 1 to PrintLen
;LEGACY METHOD
	CLRF	SYSPRINTTEMP,ACCESS
	MOVLW	1
	SUBWF	PRINTLEN,W,ACCESS
	BTFSS	STATUS, C,ACCESS
	BRA	SYSFORLOOPEND1
SYSFORLOOP1
	INCF	SYSPRINTTEMP,F,ACCESS
;HSerSend(PrintData(SysPrintTemp),comport )
	MOVF	SYSPRINTTEMP,W,ACCESS
	ADDWF	SYSPRINTDATAHANDLER,W,ACCESS
	MOVWF	AFSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSPRINTDATAHANDLER_H,W,ACCESS
	MOVWF	AFSR0_H,ACCESS
	MOVFF	INDF0,SERDATA
	RCALL	HSERSEND345
;next
	MOVF	PRINTLEN,W,ACCESS
	SUBWF	SYSPRINTTEMP,W,ACCESS
	BTFSS	STATUS, C,ACCESS
	BRA	SYSFORLOOP1
SYSFORLOOPEND1
;End If
ENDIF13
;HSerSend(13,comport)
	MOVLW	13
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND345
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA,ACCESS
	BRA	HSERSEND345

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (2069)
HSERSEND345
HSERSENDUSART1HANDLER
;USART_TX_BLOCKING
;Wait While TXIF = Off
SYSWAITLOOP2
	BTFSS	PIR5,U1TXIF,ACCESS
	BRA	SYSWAITLOOP2
;TXREG = SerData
	MOVFF	SERDATA,U1TXB
	RETURN

;********************************************************************************

;SOURCE: 130_ROTATE_THE_LEDS_USING_16BIT_TIMER0_4MHZ_EXT_OSC.BUILD.GCB (88)
INITPPS
;Module: UART pin directions
;Dir PORTC.6 Out    ' Make TX1 pin an output
	BANKSEL	TRISC
	BCF	TRISC,6,BANKED
;Module: UART1
;U1RXPPS = 0x15; //RC5->UART1:RX1;
	MOVLW	21
	BANKSEL	U1RXPPS
	MOVWF	U1RXPPS,BANKED
;RC6PPS = 0x12;  //RC6->UART1:TX1;
	MOVLW	18
	MOVWF	RC6PPS,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (201)
INITSYS
;Clear BSR on ChipFamily16 MCUs
;MOVLB 0
	MOVLB	0
;Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	MOVLW	96
	MOVWF	OSCCON1,BANKED
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	CLRF	OSCCON3,BANKED
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	CLRF	OSCEN,BANKED
;Default value
;OSCTUNE = 0x00
	CLRF	OSCTUNE,BANKED
;The MCU is a chip family 16
;Section supports many MCUs, 18FxxK40, 18FxxK42 etc that have NDIV3 bit
;OSCCON type is 101
;OSCCON1 = 0x60          // Setting OSCCON1 implies clearing Clear NDIV3:0
	MOVLW	96
	MOVWF	OSCCON1,BANKED
;OSCFRQ = 0b00000010    '4mhz
	MOVLW	2
	MOVWF	OSCFRQ,BANKED
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	CLRF	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	BANKSEL	ADCON0
	BCF	ADCON0,ADFM0,BANKED
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	BCF	ADCON0,ADON,BANKED
;ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA,BANKED
;ANSELB = 0
	CLRF	ANSELB,BANKED
;ANSELC = 0
	CLRF	ANSELC,BANKED
;ANSELE = 0
	CLRF	ANSELE,BANKED
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	BANKSEL	CM2CON0
	BCF	CM2CON0,C2EN,BANKED
;C1EN = 0
	BCF	CM1CON0,C1EN,BANKED
;Turn off all ports
;PORTA = 0
	BANKSEL	PORTA
	CLRF	PORTA,BANKED
;PORTB = 0
	CLRF	PORTB,BANKED
;PORTC = 0
	CLRF	PORTC,BANKED
;PORTD = 0
	CLRF	PORTD,BANKED
;PORTE = 0
	CLRF	PORTE,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:BYTE:, SOURCE: TIMER.H (1565)
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
	MOVLW	240
	BANKSEL	T0CON1
	ANDWF	T0CON1,W,BANKED
	MOVWF	SYSTEMP1,ACCESS
	IORWF	TMRPRES,F,ACCESS
;Set the Source bit
;IF TMRSource <> OSC  THEN
	DECF	TMRSOURCE,W,ACCESS
	BTFSC	STATUS, Z,ACCESS
	BRA	ELSE12_1
;SET TMRPost.5 ON
	BSF	TMRPOST,5,ACCESS
;ELSE
	BRA	ENDIF12
ELSE12_1
;SET TMRPost.5 OFF
	BCF	TMRPOST,5,ACCESS
;END IF
ENDIF12
;Write the TOCON register
;T0CON1 = TMRPres
	MOVFF	TMRPRES,T0CON1
;Assumed for code below Timer0 is 16-bit capable
;Set Postscaler
;Re-Use TMRPost as T0CON0 Temp register
;Keep T0CON0 7:5  and write bits 5:0 to register
;Bits therefore will be cleared!
;TMRPost = (T0CON0 And 224) OR TMRPost
	MOVLW	224
	ANDWF	T0CON0,W,BANKED
	MOVWF	SYSTEMP1,ACCESS
	IORWF	TMRPOST,F,ACCESS
;Set TO16BIT
;Set TMRPost.4 ON '16-bit Timer0
	BSF	TMRPOST,4,ACCESS
;Write the TOCON register
;T0CON0 = TMRPost
	MOVFF	TMRPOST,T0CON0
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: USART.H (1282)
INITUSART
;Set the default value for USART handler - required when more than one USART
;comport = SCRIPT_DEFAULT_COMPORT
	MOVLW	1
	MOVWF	COMPORT,ACCESS
;PIC USART 1 Init
;U1BRGH=SPBRGH_TEMP
	BANKSEL	U1BRGH
	CLRF	U1BRGH,BANKED
;U1BRGL=SPBRGL_TEMP
	MOVLW	103
	MOVWF	U1BRGL,BANKED
;U1BRGS = BRGS1_SCRIPT
	BSF	U1CON0,U1BRGS,BANKED
;U1TXEN=1   'Enable TX1
	BSF	U1CON0,U1TXEN,BANKED
;U1RXEN=1   'Enable RX1
	BSF	U1CON0,U1RXEN,BANKED
;ON_U1CON1=1 'Enable USART1
	BSF	U1CON1,ON_U1CON1,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:WORD:, SOURCE: TIMER.H (1238)
SETTIMER197
;If TMRNumber = 0 Then
	MOVF	TMRNUMBER,F,ACCESS
	BTFSS	STATUS, Z,ACCESS
	BRA	ENDIF7
;Handle chips with TMR0H
;TMR0H = TMRValue_H
	MOVFF	TMRVALUE_H,TMR0H
;TMR0L = TMRValue
	MOVFF	TMRVALUE,TMR0L
;exit to prevent default setting TMR0L = TMRValue
;exit sub
	RETURN
;End If
ENDIF7
;If TMRNumber = 1 then
	DECF	TMRNUMBER,W,ACCESS
	BTFSS	STATUS, Z,ACCESS
	BRA	ENDIF8
;TMR1H = TMRValue_H
	MOVFF	TMRVALUE_H,TMR1H
;TMR1L = TMRValue
	MOVFF	TMRVALUE,TMR1L
;End If
ENDIF8
;If TMRNumber = 2 Then
	MOVLW	2
	SUBWF	TMRNUMBER,W,ACCESS
	BTFSC	STATUS, Z,ACCESS
;TMR2 = TMRValue
	MOVFF	TMRVALUE,TMR2
;End If
;If TMRNumber = 3 then
	MOVLW	3
	SUBWF	TMRNUMBER,W,ACCESS
	BTFSS	STATUS, Z,ACCESS
	BRA	ENDIF10
;TMR3H = TMRValue_H
	MOVFF	TMRVALUE_H,TMR3H
;TMR3L = TMRValue
	MOVFF	TMRVALUE,TMR3L
;End If
ENDIF10
;If TMRNumber = 4 Then
	MOVLW	4
	SUBWF	TMRNUMBER,W,ACCESS
	BTFSC	STATUS, Z,ACCESS
;TMR4 = TMRValue
	MOVFF	TMRVALUE,TMR4
;End If
	RETURN

;********************************************************************************

;SOURCE: TIMER.H (886)
STARTTIMER
;IF TMRNumber = 0 then Set T0EN on
	MOVF	TMRNUMBER,F,ACCESS
	BTFSS	STATUS, Z,ACCESS
	BRA	ENDIF2
;IF TMRNumber = 0 then Set T0EN on
	BANKSEL	T0CON0
	BSF	T0CON0,T0EN,BANKED
;IF TMRNumber = 0 then Set T0EN on
ENDIF2
;IF TMRNumber = 1 then Set TMR1ON on
	DECF	TMRNUMBER,W,ACCESS
	BTFSS	STATUS, Z,ACCESS
	BRA	ENDIF3
;IF TMRNumber = 1 then Set TMR1ON on
	BANKSEL	T1CON
	BSF	T1CON,TMR1ON,BANKED
;IF TMRNumber = 1 then Set TMR1ON on
ENDIF3
;IF TMRNumber = 2 then Set TMR2ON on
	MOVLW	2
	SUBWF	TMRNUMBER,W,ACCESS
	BTFSS	STATUS, Z,ACCESS
	BRA	ENDIF4
;IF TMRNumber = 2 then Set TMR2ON on
	BANKSEL	T2CON
	BSF	T2CON,TMR2ON,BANKED
;IF TMRNumber = 2 then Set TMR2ON on
ENDIF4
;IF TMRNumber = 3 then Set TMR3ON on
	MOVLW	3
	SUBWF	TMRNUMBER,W,ACCESS
	BTFSS	STATUS, Z,ACCESS
	BRA	ENDIF5
;IF TMRNumber = 3 then Set TMR3ON on
	BANKSEL	T3CON
	BSF	T3CON,TMR3ON,BANKED
;IF TMRNumber = 3 then Set TMR3ON on
ENDIF5
;IF TMRNumber = 4 then Set TMR4ON on
	MOVLW	4
	SUBWF	TMRNUMBER,W,ACCESS
	BTFSS	STATUS, Z,ACCESS
	BRA	ENDIF6
;IF TMRNumber = 4 then Set TMR4ON on
	BANKSEL	T4CON
	BSF	T4CON,TMR4ON,BANKED
;IF TMRNumber = 4 then Set TMR4ON on
ENDIF6
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (1963)
SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;ChipFamily 16 support
;Get length
;TBLRD*+
	TBLRD*+
;movff TABLAT,SysCalcTempA
	MOVFF	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	MOVFF	TABLAT,INDF1
;goto SysStringReadCheck
	BRA	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;TBLRD*+
	TBLRD*+
;movf TABLAT, W
	MOVF	TABLAT, W,ACCESS
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA,ACCESS
;addwf SysStringLength,F
	ADDWF	SYSSTRINGLENGTH,F,ACCESS
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	MOVF	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	BTFSC	STATUS,Z,ACCESS
;return
	RETURN
;Copy
SYSSTRINGREAD
;Copy char
;TBLRD*+
	TBLRD*+
;movff TABLAT,PREINC1
	MOVFF	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	DECFSZ	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	BRA	SYSSTRINGREAD
	RETURN

;********************************************************************************

SYSSTRINGTABLES

STRINGTABLE1
	DB	1,46


;********************************************************************************


 END
