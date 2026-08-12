;'Program compiled by GCBASIC (2026.08.07 (Windows 64 bit) : Build 1617) for Microchip PIC-AS using FreeBASIC 1.07.1/2026-08-08 CRC247
;'  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;'  
;'  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;'  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;'or, email:
;'   evanvennn at users dot sourceforge dot net
;'********************************************************************************
;'   Installation Dir : C:\GCstudio\gcbasic
;'   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\010_hello_world.gcb
;'   Setting file     : C:\GCstudio\gcbasic\use.ini
;'   Preserve mode    : 2
;'   Assembler        : "C:\GCstudio\picas\v4.00\pic-as\bin\pic-as.exe"
;'   Programmer       : 
;'   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\010_hello_world.build\010_hello_world.asm
;'   Float Capability : 1
;'********************************************************************************

;'Set up the assembler options (Chip specs and other options)
;'PROCESSOR  18F46Q35
;'PROG       32768
;'RAM        4096
;'EEPROM     256
;'HWBPCOUNT  3
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\010_hello_world.gcb"
 SUBTITLE    "08-08-2026 18:51:55"

;' DPF Reverse lookup file(s)
;' C:\Users\admin\.mchp_packs\Microchip\PIC18F-Q_DFP\1.30.487\xc8\pic\include\proc\pic18f46q35.inc
;' C:\Users\admin\.mchp_packs\Microchip\PIC18F-Q_DFP\1.30.487\xc8\pic\dat\cfgdata\18f46q35.cfgdata
;' DPF PIC file
;'   C:\Users\admin\.mchp_packs\Microchip\PIC18F-Q_DFP\1.30.487\edc\PIC18F46Q35.PIC

;'********************************************************************************
;'Explicit PIC-AS constants to resolve the crazyness of the PIC-AS syntax
;'These are therefore the same as MPASM
#define BANKED b
#define ACCESS a
#define UPPER low highword

;'********************************************************************************
;'Explicit CONFIG
 CONFIG CPD=OFF                                  ;C1 Reverselookup  CPD = OFF
 CONFIG CP=OFF                                   ;C1 Reverselookup  CP = OFF
 CONFIG WRTSAF=OFF                               ;C1 Reverselookup  WRTSAF = OFF
 CONFIG WRTD=OFF                                 ;C1 Reverselookup  WRTD = OFF
 CONFIG WRTB=OFF                                 ;C1 Reverselookup  WRTB = OFF
 CONFIG WDTE=OFF                                 ;C1 Reverselookup  WDTE = OFF
 CONFIG XINST=OFF                                ;C1 Reverselookup  XINST = OFF
 CONFIG LVP=OFF                                  ;C1 Reverselookup  LVP = OFF
 CONFIG MVECEN=OFF                               ;C1 Reverselookup  MVECEN = OFF
 CONFIG MCLRE=INTMCLR                            ;C1 Reverselookup  MCLRE = INTMCLR
 CONFIG FCMEN=ON                                 ;C1 Reverselookup  FCMEN = ON
 CONFIG CLKOUTEN=OFF                             ;C1 Reverselookup  CLKOUTEN = OFF
 CONFIG RSTOSC=HFINTOSC_1MHZ                     ;C1 Reverselookup  RSTOSC = HFINTOSC_1MHZ
 CONFIG FEXTOSC=OFF                              ;C1 Reverselookup  FEXTOSC = OFF
;'Inferred CONFIG
 CONFIG BBEN=OFF                                 ;C1 Reverselookup BBEN=OFF
 CONFIG BBSIZE=BBSIZE_128                        ;C1 Reverselookup BBSIZE=BBSIZE_128
 CONFIG BOREN=OFF                                ;C1 Reverselookup BOREN=OFF
 CONFIG BORV=VBOR_2P85                           ;C1 Reverselookup BORV=VBOR_2P85
 CONFIG CLBSA=MIN                                ;C1 Reverselookup CLBSA=MIN
 CONFIG CLBSU=ON                                 ;C1 Reverselookup CLBSU=ON
 CONFIG CPUHALT=OFF                              ;C1 Reverselookup CPUHALT=OFF
 CONFIG CSWEN=ON                                 ;C1 Reverselookup CSWEN=ON
 CONFIG DEBUG=OFF                                ;C1 Reverselookup DEBUG=OFF
 CONFIG FCMENP=OFF                               ;C1 Reverselookup FCMENP=OFF
 CONFIG FCMENS=OFF                               ;C1 Reverselookup FCMENS=OFF
 CONFIG ICSPDIS=ON                               ;C1 Reverselookup ICSPDIS=ON
 CONFIG IVT1WAY=OFF                              ;C1 Reverselookup IVT1WAY=OFF
 CONFIG LPBOREN=OFF                              ;C1 Reverselookup LPBOREN=OFF
 CONFIG PPS1WAY=OFF                              ;C1 Reverselookup PPS1WAY=OFF
 CONFIG PR1WAY=OFF                               ;C1 Reverselookup PR1WAY=OFF
 CONFIG PWRTS=PWRT_OFF                           ;C1 Reverselookup PWRTS=PWRT_OFF
 CONFIG STVREN=OFF                               ;C1 Reverselookup STVREN=OFF
 CONFIG WDTCCS=LFINTOSC                          ;C1 Reverselookup WDTCCS=LFINTOSC
 CONFIG WDTCPS=WDTCPS_0                          ;C1 Reverselookup WDTCPS=WDTCPS_0
 CONFIG WDTCWS=WDTCWS_0                          ;C1 Reverselookup WDTCWS=WDTCWS_0
 CONFIG WRTAPP=OFF                               ;C1 Reverselookup WRTAPP=OFF
 CONFIG WRTC=OFF                                 ;C1 Reverselookup WRTC=OFF
 CONFIG ZCD1=ON                                  ;C1 Reverselookup ZCD1=ON


;'********************************************************************************
;' The XC8 xc.inc include file.  This MUST be placed after the CONFIG statements.

 #include <xc.inc>


;'********************************************************************************

 PSECT   RESETVEC,delta=1, abs
 RESETVEC:
;'VECTORS
	ORG	0
	GOTO	BASPROGRAMSTART
	ORG	8
	RETFIE

;'********************************************************************************

;'PROGRAM_MEMORY_PAGE: 0
	ORG	12
GLOBAL	BASPROGRAMSTART
BASPROGRAMSTART:
;'CALL INITIALISATION ROUTINES
	RCALL	INITSYS

;'START_OF_THE_MAIN_PROGRAM
;'
;'A DEMONSTRATION PROGRAM FOR GCBASIC.
;'--------------------------------------------------------------------------------------------------------------------------------
;'THIS PROGRAM DEMONSTRATES THE CAPABILITIES OF A PICDEM 2 BOARD
;'
;'------------------------------------------------------------------------
;'IMPORTANT - POWER CONFIGURATION
;'------------------------------------------------------------------------
;'!! VDDIO2 IS CRITICAL FOR OPERATION !!
;'ON THIS DEVICE FAMILY, VDDIO2 SUPPLIES POWER TO A SECONDARY I/O BANK.
;'IF VDDIO2 IS NOT CORRECTLY CONNECTED TO THE SUPPLY RAIL (PER THE
;'DATASHEET ELECTRICAL AND PIN-OUT SPECIFICATIONS), THE ASSOCIATED I/O
;'PINS WILL NOT FUNCTION CORRECTLY, AND THE CHIP MAY NOT OPERATE
;'RELIABLY EVEN THOUGH THE PRIMARY VDD/VSS PINS ARE POWERED CORRECTLY.
;'ALWAYS VERIFY VDDIO2 IS WIRED TO VDD (OR THE CORRECT SUPPLY LEVEL) ON
;'YOUR BOARD BEFORE TROUBLESHOOTING "DEAD" I/O OR UNEXPECTED RESETS.
;'------------------------------------------------------------------------
;'
;'AUTHOR 	EVANV
;'LICENCE	GPL
;'VERSION	1.0A
;'DATE   	01/02/2026
;'*******************************************************************************
;'SET MICROCONTROLLER REQUIRED
;'
;'------------PORTA---------------
;'BIT#:  -7---6---5---4---3---2---1---0---
;'IO:    ---------------------------------
;'IO:    ---------------------------------
;'
;'------------PORTB----------------
;'BIT#:  -7---6---5---4---3---2---1---0---
;'IO:    ----------------LED-LED-LED-LED--
;'IO:    ---------------------------------
;'
;'------------PORTC----------------
;'BIT#:  -7---6---5---4---3---2---1---0---
;'IO:    ---------------------------------
;'IO:    ---------------------------------
;'
;'------------PORTD----------------
;'BIT#:  -7---6---5---4---3---2---1---0---
;'IO:    ---------------------------------
;'IO:    ---------------------------------
;'
;'----- MAIN BODY OF PROGRAM COMMENCES HERE.
;'DIR PORTB.0 OUT
	BANKSEL	TRISB
	BCF	TRISB,0,BANKED
;'DIR PORTB.1 OUT
	BCF	TRISB,1,BANKED
;'DIR PORTB.2 OUT
	BCF	TRISB,2,BANKED
;'DIR PORTB.3 OUT
	BCF	TRISB,3,BANKED
;'PORTB.0 = 1
	BSF	LATB,0,BANKED
;'PORTB.1 = 1
	BSF	LATB,1,BANKED
;'PORTB.2 = 1
	BSF	LATB,2,BANKED
;'PORTB.3 = 1
	BSF	LATB,3,BANKED
;'END
	BRA	BASPROGRAMEND
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	BRA	BASPROGRAMEND

;'********************************************************************************

;'SOURCE: SYSTEM.H (201)
GLOBAL	INITSYS
INITSYS:
;'CLEAR BSR ON CHIPFAMILY16 MCUS
;'MOVLB 0
	MOVLB	0
;'DEFAULT SETTINGS FOR MICROCONTROLLERS WITH _OSCCON1_
	;DEFAULT	OSCCON1,NOSC HFINTOSC; NDIV 1 - COMMON AS THIS SIMPLY SETS THE HFINTOSC
;'OSCCON1 = 0X60
	MOVLW	96
	MOVWF	OSCCON1,BANKED
;'DEFAULT VALUE TYPICALLY, CSWHOLD MAY PROCEED; SOSCPWR LOW POWER
;'OSCCON3 = 0X00
	CLRF	OSCCON3,BANKED
;'DEFAULT VALUE TYPICALLY, MFOEN DISABLED; LFOEN DISABLED; ADOEN DISABLED; SOSCEN DISABLED; EXTOEN DISABLED; HFOEN DISABLED
;'OSCEN = 0X00
	CLRF	OSCEN,BANKED
;'DEFAULT VALUE
;'OSCTUNE = 0X00
	CLRF	OSCTUNE,BANKED
;'THE MCU IS A CHIP FAMILY 16
;'SECTION SUPPORTS MANY MCUS, 18FXXK40, 18FXXK42 ETC THAT HAVE NDIV3 BIT
;'OSCCON TYPE IS 101
;'OSCCON1 = 0X60          // SETTING OSCCON1 IMPLIES CLEARING CLEAR NDIV3:0
	MOVLW	96
	MOVWF	OSCCON1,BANKED
;'OSCFRQ = 0B00001000  '64MHZ
	MOVLW	8
	MOVWF	OSCFRQ,BANKED
;'_COMPLETE_THE_CHIP_SETUP_OF_BSR_ADCS_ANSEL_AND_OTHER_KEY_SETUP_REGISTERS_OR_REGISTER_BITS
;'CLEAR TBLPTRU ON MCUS WITH THIS BIT AS THIS MUST BE ZERO
;'TBLPTRU = 0
	CLRF	TBLPTRU,ACCESS
;'ENSURE ALL PORTS ARE SET FOR DIGITAL I/O AND, TURN OFF A/D
;'SET ADFM OFF
	BANKSEL	ADCON0
	BCF	ADCON0,2,BANKED
;'SWITCH OFF A/D VAR(ADCON0)
;'SET ADCON0.ADON OFF
	BCF	ADCON0,7,BANKED
;'ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA,BANKED
;'ANSELB = 0
	CLRF	ANSELB,BANKED
;'ANSELC = 0
	CLRF	ANSELC,BANKED
;'ANSELE = 0
	CLRF	ANSELE,BANKED
;'SET COMPARATOR REGISTER BITS FOR MANY MCUS WITH REGISTER CM2CON0
;'C2EN = 0
	BANKSEL	CM2CON0
	BCF	CM2CON0,7,BANKED
;'C1EN = 0
	BCF	CM1CON0,7,BANKED
;'TURN OFF ALL PORTS
;'PORTA = 0
	BANKSEL	PORTA
	CLRF	PORTA,BANKED
;'PORTB = 0
	CLRF	PORTB,BANKED
;'PORTC = 0
	CLRF	PORTC,BANKED
;'PORTD = 0
	CLRF	PORTD,BANKED
;'PORTE = 0
	CLRF	PORTE,BANKED
	BANKSEL	0
	RETURN

;'********************************************************************************

;'
;' Declare Power-On-Reset entry point
;'
 END     RESETVEC
