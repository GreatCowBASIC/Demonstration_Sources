;Program compiled by GCBASIC (2025.11.12 (Windows 64 bit) : Build 1527) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2025-11-12 CRC248
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17556_chiprange_demonstrations\010_hello_world.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17556_chiprange_demonstrations\010_hello_world.asm
;   Float Capability : 255
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F17556, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17556_chiprange_demonstrations\010_hello_world.gcb"
 SUBTITLE    "11-13-2025 10:23:14"
#include <P16F17556.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _RSTOSC_HFINTOSC_32MHZ & _FEXTOSC_OFF
 __CONFIG _CONFIG2, _MCLRE_INTMCLR
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF & _WRTSAF_OFF & _WRTD_OFF & _WRTB_OFF
 __CONFIG _CONFIG5, _CPD_OFF & _CP_OFF

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
	retfie

;********************************************************************************

;Program_memory_page: 0
	ORG	5
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS

;Start_of_the_main_program
;
;* An example program for GCBASIC.
;* This simply sets an LED on. The LED is attached to PORTB.0 via a suitable resistor to 0V.
;*
;* **********************************************************************
;* @author  EvanV
;* @licence GPL
;* @version 1.00
;* @date    12.11.2025
;
;----- Configuration
;Chip Settings.
;
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Set the port as an output, we will use only one bit to connect to the LED
;Dir PORTB.0 Out
	bcf	TRISB,0
;Set one bit of the port on.
;You can try set PORTB.1 - another LED, remember you will need a resistor!
;PORTB.0 = 1
	bsf	LATB,0
;End
;
;Key GCBASIC Concepts Demonstrated:
;
;#CHIP Directive: Tells the compiler to target the PIC16F17556's registers and features (e.g., 28 pins, PORTB available on pins 15–22).
;#Option Explicit: Prevents undeclared variables—essential for debugging in tutorials.
;Dir Statement: Sets I/O direction. Syntax: Dir port.bit {In | Out}. For the whole port: Dir PORTB Out.
;Port Assignment: PORTB.0 = 1 sets the pin high. GCB handles latching safely (uses LATC equivalent).
;
;Verification Against PIC16F17556 Datasheet
;Based on the official Microchip datasheet (DS40002614), your code will align perfectly:
;
;PORTB Details: 8-bit bidirectional port (RC0–RC7). RC0 is a general-purpose I/O pin (no special analog/default functions blocking it).
;Configuration Registers:RegisterRoleYour Code's EffectDatasheet DefaultTRISCData direction (0 = output, 1 = input)Dir PORTB.0 Out → TRISC.0 = 00xFF (all inputs)LATCOutput latch (write-only for safe updates)PORTB.0 = 1 → LATC.0 = 1 (drives ~VDD)0x00 (low)PORTBPin state read/writeIndirectly used; read would confirm high (0x01)N/A
;Best Practices Confirmed: Use LATC (GCB does this automatically) to avoid read-modify-write hazards when toggling bits.
;Electrical Specs: RC0 can source/sink up to 25mA (plenty for an LED + resistor). High state = VDD (3.0–5.5V).
;
;No errata affect this basic setup (per latest silicon errata, DS80001152).
;
;How to Test It
;
;Compile: Open in GCB IDE → Compile → Generate .hex file. (Free download: sourceforge.net/projects/gcbasic.)
;Program the PIC: Use PICKit2  or a standalone programmer. Flash the .hex.
;Power On: Connect hardware as described. The LED should illuminate immediately.
;
;Troubleshooting:
;LED off? Check wiring, resistor value, or if RC0 is multiplexed (unlikely here).
;Compiler error? Ensure #CHIP matches your device.
;No light? Add a multimeter: Measure ~VDD at RC0.
;
;
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Source: system.h (198)
INITSYS
;Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	clrf	OSCCON3
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	clrf	OSCEN
;Default value
;OSCTUNE = 0x00
	clrf	OSCTUNE
;The MCU is a chip family ChipFamily
;OSCCON type is 102
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F188xx MCU family - the default case
;OSCFRQ = 0b00000110
	movlw	6
	movwf	OSCFRQ
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;Set comparator register bits for many MCUs with register CM2CON0
;C1EN = 0
	banksel	CM1CON0
	bcf	CM1CON0,C1EN
;Turn off all ports
;PORTA = 0
	banksel	PORTA
	clrf	PORTA
;PORTB = 0
	clrf	PORTB
;PORTC = 0
	clrf	PORTC
;PORTE = 0
	clrf	PORTE
	return

;********************************************************************************

;Program_memory_page: 1
	ORG	2048
;Program_memory_page: 2
	ORG	4096
;Program_memory_page: 3
	ORG	6144
;Program_memory_page: 4
	ORG	8192
;Program_memory_page: 5
	ORG	10240
;Program_memory_page: 6
	ORG	12288
;Program_memory_page: 7
	ORG	14336

 END
