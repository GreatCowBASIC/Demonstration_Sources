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
;   Source file      : \\192.168.0.104\d\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_Body_Wait10_tiny202.gcb
;   Setting file     : C:\temp\probe\use.ini
;   Preserve mode    : 2
;   Assembler        : gcasm
;   Programmer       : 
;   Output file      : \\192.168.0.104\d\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1654\RepeatFor_Body_Wait10_tiny202.build\RepeatFor_Body_Wait10_tiny202.asm
;   Float Capability : 1
;********************************************************************************

;Chip Model: TINY202
;Assembler header file
.INCLUDE "tn202def.inc"

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
.EQU	SYSREPEATFORCMP1=16256	         ; 0x3F80
.EQU	SYSREPEATFORCOUNTER1=16257	         ; 0x3F81
.EQU	SYSREPEATFORCOUNTER1_H=16258	         ; 0x3F82
.EQU	X=16259	         ; 0x3F83

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMPUS=r27
.DEF	SYSWAITTEMPUS_H=r28
.DEF	SYSTEMP1=r16
.DEF	SYSTEMP2=r17
.DEF	SYSTEMP2_H=r18

;********************************************************************************

;Vectors
;Interrupt vectors
	.ORG	0
	rjmp	BASPROGRAMSTART ;Reset
	.ORG	1
	reti	;NMI
	.ORG	2
	reti	;BOD_VLM
	.ORG	3
	reti	;PORTA_PORT
	.ORG	6
	reti	;RTC_CNT
	.ORG	7
	reti	;RTC_PIT
	.ORG	8
	reti	;TCA0_LUNF
	.ORG	9
	reti	;TCA0_HUNF
	.ORG	10
	reti	;TCA0_CMP0
	.ORG	11
	reti	;TCA0_CMP1
	.ORG	12
	reti	;TCA0_CMP2
	.ORG	13
	reti	;TCB0_INT
	.ORG	16
	reti	;AC0_AC
	.ORG	17
	reti	;ADC0_RESRDY
	.ORG	18
	reti	;ADC0_WCOMP
	.ORG	19
	reti	;TWI0_TWIS
	.ORG	20
	reti	;TWI0_TWIM
	.ORG	21
	reti	;SPI0_INT
	.ORG	22
	reti	;USART0_RXC
	.ORG	23
	reti	;USART0_DRE
	.ORG	24
	reti	;USART0_TXC
	.ORG	25
	reti	;NVMCTRL_EE

;********************************************************************************

;Program_memory_page: 0
.ORG	27
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	CPU_SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	CPU_SPL, SysValueCopy
;Call initialisation routines
	rcall	INITSYS

;Start_of_the_main_program
;Repeat For test (Change 1654): Loop body: one constant 'Wait 10 us', on tiny202
;Expect: compiles, and the whole Repeat For construct runs exactly 400,000 clock cycles
;(checked by simulating the generated assembly instruction by instruction)
;Dim Flag As Bit
;Dim Cnt As Byte
;Dim X As Byte
;Dim Y As Byte
;Dim W1 As Word
;Dim W2 As Word
;Repeat For 20 ms
SysRepeatForSetup1:
	ldi	SysValueCopy,0
	sts	SysRepeatForCounter1,SysValueCopy
	ldi	SysValueCopy,0
	sts	SysRepeatForCounter1_H,SysValueCopy
SysRepeatForLoop1:
;Wait 10 us
	ldi	DELAYTEMP,66
DelayUS2:
	dec	DELAYTEMP
	brne	DelayUS2
	rjmp	PC + 1
;End Repeat
SysRepeatForPad1:
SysRepeatForTail1:
	lds	SysTemp2,SysRepeatForCounter1
	lds	SysTemp2_H,SysRepeatForCounter1_H
	subi	SysTemp2,255
	sbci	SysTemp2_H,255
	sts	SysRepeatForCounter1,SysTemp2
	sts	SysRepeatForCounter1_H,SysTemp2_H
	ldi	SysTemp1,7
	cpi	SysTemp2,51
	cpc	SysTemp2_H,SysTemp1
	brne	SysRepeatForLoop1
SysRepeatForLoopEnd1:
	ldi	DELAYTEMP,21
DelayUS3:
	dec	DELAYTEMP
	brne	DelayUS3
	nop
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

;Source: system.h (211)
INITSYS:
;'CLKCTRL_MCLKCTRLB with ChipMaxMHz 20
;Proven on ATtiny212/214/412/414/416, ATtiny3216/3217, ATtiny1624/1626/1627
;Internal ChipMHz 20
;AVRDX_PROTECTWRITECPP( CLKCTRL_MCLKCTRLA, 0)
;Macro Source: system.h (6032)
;CPU_CCP = 216
	ldi	SysValueCopy,216
	out	CPU_CCP,SysValueCopy
;PROTECTED_REG= REG_VALuE
	ldi	SysValueCopy,0
	sts	CLKCTRL_MCLKCTRLA,SysValueCopy
;AVRDX_PROTECTWRITECPP( CLKCTRL_MCLKCTRLB, 0)
;Macro Source: system.h (6032)
;CPU_CCP = 216
	ldi	SysValueCopy,216
	out	CPU_CCP,SysValueCopy
;PROTECTED_REG= REG_VALuE
	ldi	SysValueCopy,0
	sts	CLKCTRL_MCLKCTRLB,SysValueCopy
;AVR DX - clear down the ram to 0x00
;Reserve the top 2 bytes of RAM: InitSys is reached via rcall, so the
;return address is already sitting at RAMEND-1:RAMEND by the time this
;runs - clearing through RAMEND itself would zero that return address
;and send the following ret to address 0.
;eor r1, r1
	eor	R1, R1
;ldi r18, HIGH(RAMEND - 2)
	ldi	R18, HIGH(RAMEND - 2)
;ldi r26, LOW(SRAM_START )
	ldi	R26, LOW( 16256 )
;ldi r27, HIGH(SRAM_START )
	ldi	R27, HIGH( 16256 )
;rjmp InitSysClearRAMStart
	rjmp	INITSYSCLEARRAMSTART
INITSYSCLEARRAMLOOP:
;st  X+, r1
	st	X+, R1
INITSYSCLEARRAMSTART:
;cpi r26, LOW(RAMEND - 2)
	cpi	R26, LOW(RAMEND - 2)
;cpc r27, r18
	cpc	R27, R18
;brne  InitSysClearRAMLoop
	brne	INITSYSCLEARRAMLOOP
;st  X+, r1
	st	X+, R1
;DDRA = 0
	ldi	SysValueCopy,0
	sts	PORTA_DIR,SysValueCopy
;PORTA = 0
	ldi	SysValueCopy,0
	sts	PORTA_OUT,SysValueCopy
	ret

;********************************************************************************


