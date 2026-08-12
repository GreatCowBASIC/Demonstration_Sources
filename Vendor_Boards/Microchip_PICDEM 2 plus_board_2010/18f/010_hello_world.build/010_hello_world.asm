;Program compiled by GCBASIC (2026.08.07 (Windows 64 bit) : Build 1617) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-08-08 CRC247
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\010_hello_world.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : "C:\GCstudio\picas\v4.00\pic-as\bin\pic-as.exe"
;   Programmer       : 
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\010_hello_world.build\010_hello_world.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\010_hello_world.gcb"
 SUBTITLE    "08-08-2026 18:51:53"
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
 CONFIG  MCLRE = INTMCLR
 CONFIG  FCMEN = ON
 CONFIG  CLKOUTEN = OFF
 CONFIG  RSTOSC = HFINTOSC_1MHZ
 CONFIG  FEXTOSC = OFF

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

;START_OF_THE_MAIN_PROGRAM
;
;A demonstration program for GCBASIC.
;--------------------------------------------------------------------------------------------------------------------------------
;This program demonstrates the capabilities of a PICDEM 2 Board
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
;@author 	EvanV
;@licence	GPL
;@version	1.0a
;@date   	01/02/2026
;*******************************************************************************
;Set microcontroller required
;
;------------PORTA---------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ---------------------------------
;IO:    ---------------------------------
;
;------------PORTB----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ----------------LED-LED-LED-LED--
;IO:    ---------------------------------
;
;------------PORTC----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ---------------------------------
;IO:    ---------------------------------
;
;------------PORTD----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ---------------------------------
;IO:    ---------------------------------
;
;----- Main body of program commences here.
;DIR PORTB.0 OUT
	BANKSEL	TRISB
	BCF	TRISB,0,BANKED
;DIR PORTB.1 OUT
	BCF	TRISB,1,BANKED
;DIR PORTB.2 OUT
	BCF	TRISB,2,BANKED
;DIR PORTB.3 OUT
	BCF	TRISB,3,BANKED
;PORTB.0 = 1
	BSF	LATB,0,BANKED
;PORTB.1 = 1
	BSF	LATB,1,BANKED
;PORTB.2 = 1
	BSF	LATB,2,BANKED
;PORTB.3 = 1
	BSF	LATB,3,BANKED
;End
	BRA	BASPROGRAMEND
BASPROGRAMEND
	SLEEP
	BRA	BASPROGRAMEND

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
;OSCFRQ = 0b00001000  '64mhz
	MOVLW	8
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


 END
