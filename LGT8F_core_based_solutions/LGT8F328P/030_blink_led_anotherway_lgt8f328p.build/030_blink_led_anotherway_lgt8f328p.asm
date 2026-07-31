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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\LGT8F_core_based_solutions\LGT8F328P\030_blink_led_anotherway_lgt8f328p.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\avrdude\avrdude.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\LGT8F_core_based_solutions\LGT8F328P\030_blink_led_anotherway_lgt8f328p.build\030_blink_led_anotherway_lgt8f328p.asm
;   Float Capability : 1
;********************************************************************************

;Chip Model: LGT8F328P
;Assembler header file
.INCLUDE "lgt8f328pdef.inc"

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

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30
.DEF	SYSWAITTEMPUS=r27
.DEF	SYSWAITTEMPUS_H=r28
.DEF	SYSTEMP1=r0
.DEF	SYSTEMP2=r16

;********************************************************************************

;Alias variables
#define	_BTMP	DELAYTEMP

;********************************************************************************

;Vectors
;Interrupt vectors
	.ORG	0
	jmp	BASPROGRAMSTART ;Reset  f122 jmp
	.ORG	2
	jmp	0  ;INT0                f122 jmp
	.ORG	4
	jmp	0  ;INT1                f122 jmp
	.ORG	6
	jmp	0  ;PCINT0              f122 jmp
	.ORG	8
	jmp	0  ;PCINT1              f122 jmp
	.ORG	10
	jmp	0  ;PCINT2              f122 jmp
	.ORG	12
	jmp	0  ;WDT                 f122 jmp
	.ORG	14
	jmp	0  ;TIMER2_COMPA        f122 jmp
	.ORG	16
	jmp	0  ;TIMER2_COMPB        f122 jmp
	.ORG	18
	jmp	0  ;TIMER2_OVF          f122 jmp
	.ORG	20
	jmp	0  ;TIMER1_CAPT         f122 jmp
	.ORG	22
	jmp	0  ;TIMER1_COMPA        f122 jmp
	.ORG	24
	jmp	0  ;TIMER1_COMPB        f122 jmp
	.ORG	26
	jmp	0  ;TIMER1_OVF          f122 jmp
	.ORG	28
	jmp	0  ;TIMER0_COMPA        f122 jmp
	.ORG	30
	jmp	0  ;TIMER0_COMPB        f122 jmp
	.ORG	32
	jmp	0  ;TIMER0_OVF          f122 jmp
	.ORG	34
	jmp	0  ;SPI_STC             f122 jmp
	.ORG	36
	jmp	0  ;USART_RX            f122 jmp
	.ORG	38
	jmp	0  ;USART_UDRE          f122 jmp
	.ORG	40
	jmp	0  ;USART_TX            f122 jmp
	.ORG	42
	jmp	0  ;ADC                 f122 jmp
	.ORG	44
	jmp	0  ;EE_READY            f122 jmp
	.ORG	46
	jmp	0  ;ANALOG_COMP         f122 jmp
	.ORG	48
	jmp	0  ;TWI                 f122 jmp
	.ORG	50
	jmp	0  ;SPM_READY           f122 jmp
	.ORG	54
	jmp	0  ;PICI3_READY         f122 jmp
	.ORG	56
	jmp	0  ;PICI4_READY         f122 jmp
	.ORG	58
	jmp	0  ;TIMER3_INT          f122 jmp

;********************************************************************************

;Program_memory_page: 0
.ORG	60
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	SPL, SysValueCopy
;Call initialisation routines
	rcall	INITSYS

;Start_of_the_main_program
;''A demonstration program for GCBASIC
;''---------------------------------------------------------------------------------
;'' This demonstration simply turns the LED on and off with a wait of 500 ms.
;''
;'' This shows how you can use the logic of NOT to toggle an LED.
;''
;'' GCBASIC will read the state of the port controlling the LED,
;'' then, it will change the state of the port, using the NOT logic,
;'' then, it will automatically update the state of the port with this new state.
;''
;''@author  Evan Venn
;''@licence GPL
;''@version 1.0
;''@date    08/10/2020
;''********************************************************************************
;----- Configuration
;GCBASIC simplifies the configuration by setting the frequency and the configuration for you.   'Set a constant to refer to the LED.
;Set LED as an output
;Dir LED0 Out
	sbi	DDRB,5
;'' Most programs run in a loop such as this one
;Start here
;Do
SysDoLoop_S1:
;Toggle LED off
;LED0 = NOT LED0
	clr	SysTemp1
	sbic	PINB,5
	inc	SysTemp1
	com	SysTemp1
	cbi	PORTB,5
	sbrc	SYSTEMP1,0
	sbi	PORTB,5
;Wait in a timer loop for a while
;Wait 500 ms
	ldi	SysWaitTempMS,244
	ldi	SysWaitTempMS_H,1
	rcall	Delay_MS
;Return to the top and do it again
;Loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
;The program should never get to this line
;
;End execution and put the device into low power sleep mode.
;End
	rjmp	BASPROGRAMEND
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

Delay_MS:
	inc	SysWaitTempMS_H
DMS_START:
	ldi	DELAYTEMP2,254
DMS_OUTER:
	ldi	DELAYTEMP,41
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

;Source: system.h (200)
INITSYS:
;Clear down the ram
;eor r1, r1
	eor	R1, R1
;ldi r18, HIGH(RAMEND) -1
	ldi	R18, HIGH(RAMEND) -1
;ldi r26, 0x00 ; 0
	ldi	R26, 0
;ldi r27, 0x01 ; 1
	ldi	R27, 1
;rjmp IniySysClearRAMStart
	rjmp	INIYSYSCLEARRAMSTART
INITSYSCLEARRAMLOOP:
;st  X+, r1
	st	X+, R1
INIYSYSCLEARRAMSTART:
;cpi r26, LOW(RAMEND)
	cpi	R26, LOW(RAMEND)
;cpc r27, r18
	cpc	R27, R18
;brne  InitSysClearRAMLoop
	brne	INITSYSCLEARRAMLOOP
;st  X+, r1
	st	X+, R1
;MCUSR - IO Special Function Registers Control
;MCUSR = 0xFF
	ldi	SysValueCopy,255
	out	MCUSR,SysValueCopy
;MCUSR = 0xFF
	ldi	SysValueCopy,255
	out	MCUSR,SysValueCopy
;step 1. enable clock sources
;Dim _btmp as Byte alias DELAYTEMP
;_btmp = PMCR | 0x0F
	ldi	SysTemp2,15
	lds	SysTemp1,PMCR
	or	SysTemp1,SysTemp2
	mov	_BTMP,SysTemp1
;PMCR = 0x80
	ldi	SysValueCopy,128
	sts	PMCR,SysValueCopy
;PMCR = _btmp
	sts	PMCR,_BTMP
;wait for clock stable
;wait 20 us
	ldi	DELAYTEMP,213
DelayUS2:
	dec	DELAYTEMP
	brne	DelayUS2
	nop
;step 2. configure main clock
;_btmp = ( PMCR & 0x9f)
	ldi	SysTemp2,159
	lds	SysTemp1,PMCR
	and	SysTemp1,SysTemp2
	mov	_BTMP,SysTemp1
;PMCR = 0x80
	ldi	SysValueCopy,128
	sts	PMCR,SysValueCopy
;PMCR = _btmp
	sts	PMCR,_BTMP
;NOP
	nop
;NOP
	nop
;Set the frequency - assumes internal OSC
;CLKPR = 0x80
	ldi	SysValueCopy,128
	sts	CLKPR,SysValueCopy
;CLKPR = 0            '32mhz
	ldi	SysValueCopy,0
	sts	CLKPR,SysValueCopy
;NOP
	nop
;NOP
	nop
;enable EEPROM for LGT8F328P
;ECCR = 0x80
	ldi	SysValueCopy,128
	out	ECCR,SysValueCopy
;ECCR = 0x40 '1K EEPROM
	ldi	SysValueCopy,64
	out	ECCR,SysValueCopy
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
;PORTE = 0
	ldi	SysValueCopy,0
	out	PORTE,SysValueCopy
	ret

;********************************************************************************


