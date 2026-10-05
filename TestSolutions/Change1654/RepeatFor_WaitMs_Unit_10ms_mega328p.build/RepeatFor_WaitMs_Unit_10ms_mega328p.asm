;Program compiled by GCBASIC (2026.10.01 (Windows 64 bit) : Build 1654) for Microchip AVR Assembler using FreeBASIC 1.07.1/2026-10-04 CRC170
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : \\192.168.0.104\d\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_WaitMs_Unit_10ms_mega328p.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : 
;   Output file      : \\192.168.0.104\d\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_WaitMs_Unit_10ms_mega328p.build\RepeatFor_WaitMs_Unit_10ms_mega328p.asm
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
.EQU	SYSREPEATFORCMP1=256	         ; 0x100
.EQU	SYSREPEATFORCOUNTER1=257	         ; 0x101
.EQU	SYSREPEATFORCOUNTER1_H=258	         ; 0x102

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30
.DEF	SYSTEMP1=r0
.DEF	SYSTEMP2=r16
.DEF	SYSTEMP3=r17
.DEF	SYSTEMP3_H=r18

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
	rcall	INITSYS

;Start_of_the_main_program
;Repeat For test (Change 1654): Wait 3 10ms (tens of milliseconds) in a 100 ms loop
;Expect: compiles, and the whole Repeat For construct runs exactly 1,600,000 clock cycles
;(checked by simulating the generated assembly instruction by instruction)
;Repeat for 100 ms
SysRepeatForSetup1:
	ldi	SysValueCopy,0
	sts	SysRepeatForCounter1,SysValueCopy
	ldi	SysValueCopy,0
	sts	SysRepeatForCounter1_H,SysValueCopy
SysRepeatForLoop1:
;Wait 3 10ms
	ldi	DELAYTEMP2,255
DelayUSO2:
	ldi	DELAYTEMP,0
DelayUS2:
	dec	DELAYTEMP
	brne	DelayUS2
	dec	DELAYTEMP2
	brne	DelayUSO2
	ldi	DELAYTEMP2,255
DelayUSO3:
	ldi	DELAYTEMP,0
DelayUS3:
	dec	DELAYTEMP
	brne	DelayUS3
	dec	DELAYTEMP2
	brne	DelayUSO3
	ldi	DELAYTEMP2,112
DelayUSO4:
	ldi	DELAYTEMP,0
DelayUS4:
	dec	DELAYTEMP
	brne	DelayUS4
	dec	DELAYTEMP2
	brne	DelayUSO4
	ldi	DELAYTEMP,146
DelayUS5:
	dec	DELAYTEMP
	brne	DelayUS5
;PORTB = !PORTB
	in	SysTemp1,PORTB
	com	SysTemp1
	out	PORTB,SysTemp1
;End Repeat
SysRepeatForPad1:
	ldi	DELAYTEMP2,69
DelayUSO6:
	ldi	DELAYTEMP,0
DelayUS6:
	dec	DELAYTEMP
	brne	DelayUS6
	dec	DELAYTEMP2
	brne	DelayUSO6
	ldi	DELAYTEMP,38
DelayUS7:
	dec	DELAYTEMP
	brne	DelayUS7
SysRepeatForTail1:
	lds	SysTemp3,SysRepeatForCounter1
	lds	SysTemp3_H,SysRepeatForCounter1_H
	subi	SysTemp3,255
	sbci	SysTemp3_H,255
	sts	SysRepeatForCounter1,SysTemp3
	sts	SysRepeatForCounter1_H,SysTemp3_H
	ldi	SysTemp2,0
	cpi	SysTemp3,3
	cpc	SysTemp3_H,SysTemp2
	brne	SysRepeatForLoop1
SysRepeatForLoopEnd1:
	rjmp	PC + 1
SysRepeatForDone1:
;Do
SysDoLoop_S1:
;Loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

Delay_10MS:
D10MS_START:
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
	dec	SysWaitTemp10MS
	brne	D10MS_START
	ret

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

;Source: system.h (211)
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


