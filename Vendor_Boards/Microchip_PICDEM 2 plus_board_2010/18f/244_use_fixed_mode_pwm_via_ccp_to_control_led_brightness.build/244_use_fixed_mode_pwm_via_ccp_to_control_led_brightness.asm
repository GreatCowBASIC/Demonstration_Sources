;Program compiled by GCBASIC (2026.08.07 (Windows 64 bit) : Build 1617) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-08-15 CRC247
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\244_use_fixed_mode_pwm_via_ccp_to_control_led_brightness.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\244_use_fixed_mode_pwm_via_ccp_to_control_led_brightness.build\244_use_fixed_mode_pwm_via_ccp_to_control_led_brightness.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\244_use_fixed_mode_pwm_via_ccp_to_control_led_brightness.gcb"
 SUBTITLE    "08-17-2026 12:35:32"
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
CCPCONCACHE                      EQU    1280          ; 0x500 (SA)
_PWMTIMERSELECTED                EQU    1281          ; 0x501 (SA)

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
	rcall	INITPWM

;Start_of_the_main_program
;
;This demonstration flashes an LED to show the use of CCP PWM operations
;
;Uses fixed mode PWM operations
;
;This program will enable a 38 kHz PWM signal, with a duty cycle
;of 50%. It will emit the signal for 10 seconds, then stop.
;#define PWM_Freq 38    'Set frequency in KHz
;#define PWM_Duty 50    'Set duty cycle to 50 %
;
;************************************************************************
;@author  EvanV
;@licence GPL
;@version 1.00
;@date    02-08-2026
;
;----- Configuration
;Chip Settings.
;PIC PPS Tool version: 0.0.6.5
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
;------------------PORTC-----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    --------------------CCP1---------
;----------------------------------------
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
;Dir     RSTBUTTON     In  // this is set automatically - and, you cannot set as an output
	bsf	TRISE,3,BANKED
;! Specify explicit OCULAR_OM1614 support!!
;Setup LCD Parameters
;Define LCD Hardware settings
;! Required for OCULAR LCD driver
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;PWMOn
	banksel	0
	rcall	PWMON23
;Uncomment to review the paramaters, registers etc
;ShowDetails
;Do
SysDoLoop_S1
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;GCBASIC Optimisation file - this will optimise PWM operations by disabling the PWM operations on the PWM channel and Timer that is set to FALSE
;to enable PWM and Timer operations set to FALSE
;
;Optimise CCP/PWM
;
;Optimise PWM
;Optimise Timers associated with PWM operations
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: 244_use_fixed_mode_pwm_via_ccp_to_control_led_brightness.gcb (28)
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
;Modile: CCP1
;RB0PPS = 0x0D;  //RB0->CCP1:CCP1;
	movlw	13
	movwf	RB0PPS,BANKED
;RB1PPS = 0x0D;  //RB1->CCP1:CCP1;
	movlw	13
	movwf	RB1PPS,BANKED
;RB2PPS = 0x0D;  //RB2->CCP1:CCP1;
	movlw	13
	movwf	RB2PPS,BANKED
;RB3PPS = 0x0D;  //RB3->CCP1:CCP1;
	movlw	13
	movwf	RB3PPS,BANKED
	banksel	0
	return

;********************************************************************************

;Source: pwm.h (266)
INITPWM
;_PWMTimerSelected = 2
	movlw	2
	movwf	_PWMTIMERSELECTED,ACCESS
;Dim PRx_Temp as LONG
LEGACY_STARTOFFIXEDCCPPWMMODECODE
;DIM CCPCONCache as BYTE
;CCPCONCache = 0
	clrf	CCPCONCACHE,ACCESS
;Set PWM Period
;PR2 = PR2_CPP_PWM_Temp
	movlw	105
	banksel	PR2
	movwf	PR2,BANKED
;SET T2CON.T2CKPS0 OFF
	bcf	T2CON,T2CKPS0,BANKED
;SET T2CON.T2CKPS1 ON
	bsf	T2CON,T2CKPS1,BANKED
;SET T2CON.T2CKPS2 OFF
	bcf	T2CON,T2CKPS2,BANKED
;Set Duty cycle
;CCPCONCache.CCP1FMT = 1
	bsf	CCPCONCACHE,CCP1FMT,ACCESS
;CCPR1H = DutyCycleH
	movlw	53
	movwf	CCPR1H,BANKED
;CCPR1L = DutyCycleL*64
	clrf	CCPR1L,BANKED
;[canskip]T2CLKCON = 1
	movlw	1
	movwf	T2CLKCON,BANKED
;set the enable bit in the Fixed Mode cache variable
;CCPCONCache.CCP1CON_EN = 1
	bsf	CCPCONCACHE,CCP1CON_EN,ACCESS
;CCPCONCache.CCP1M3, CCPCONCache.CCP1M2, CCPCONCache.CCP1M1, CCPCONCache.CCP1M0 = b'1100'
	bsf	CCPCONCACHE,CCP1MODE3,ACCESS
	bsf	CCPCONCACHE,CCP1MODE2,ACCESS
	bcf	CCPCONCACHE,CCP1MODE1,ACCESS
	bcf	CCPCONCACHE,CCP1MODE0,ACCESS
;Enable Timer 2
;SET T2CON.TMR2ON ON
	bsf	T2CON,TMR2ON,BANKED
STARTOFFIXEDPWMMODECODE
SETPWMDUTYCODE
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

;Overloaded signature: , Source: pwm.h (2374)
PWMON23
;CCP1CON = CCPCONCache
	movff	CCPCONCACHE,CCP1CON
	return

;********************************************************************************


 END
