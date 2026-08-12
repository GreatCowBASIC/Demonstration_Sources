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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\070_debounce_the_switch.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\070_debounce_the_switch.build\070_debounce_the_switch.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\070_debounce_the_switch.gcb"
 SUBTITLE    "08-09-2026 15:17:36"
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

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
SYSBITVAR0                       EQU    1284          ; 0x504 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSTEMP1                         EQU    1285          ; 0x505 (SA)
SYSTEMP2                         EQU    1286          ; 0x506 (SA)
SYSTEMP3                         EQU    1287          ; 0x507 (SA)
SYSWAITTEMPMS                    EQU    1282          ; 0x502 (SA)
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503 (SA)

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

;Start_of_the_main_program
;
;This demonstration uses a simple software routine to avoid the initial noise on the switch
;pin. The code will inspect the switch status, but should overcome most of the noise from a switch.
;
;Some switches are worse than others.
;
;When the switch is pressed down, LEDs will toggle immediately. Releasing the
;switch has no effect - only the moment the switch transitions from "up" to
;"down" (the press itself) triggers the toggle.
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
;************************************************************************
;@author  EvanV
;@licence GPL
;@version 1.01
;@date    09.08.2026
;
;----- Configuration
;Chip Settings.
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
;IO:    ---------------------------------
;IO:    ---------------------------------
;
;------------PORTD----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ---------------------------------
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
;------------------------------------------------------------------------
;IMPORTANT - Switch polarity
;------------------------------------------------------------------------
;DOWN must equal whatever SWITCHIN reads WHEN THE BUTTON IS PHYSICALLY
;PRESSED, not when it's at rest. Get this backwards and the "press" edge
;detection in funcKeyPressed() will fire on release instead of on press,
;even though the debounce/edge-detection logic itself is correct.
;
;Most switch circuits use a pull-up resistor to VDD with the switch
;connecting the pin to ground when pressed. In that layout:
;- At rest (not pressed):  SWITCHIN reads 1 (HIGH)
;- Pressed:                SWITCHIN reads 0 (LOW)
;That is the wiring assumed below (DOWN = 0).
;
;If your circuit instead pulls the pin LOW at rest and the switch pulls
;it HIGH when pressed, change this to #DEFINE DOWN 1.
;
;To verify: probe PORTA.4 with a meter, or just try one polarity - if the
;LEDs toggle on release instead of press, flip this value.
;------------------------------------------------------------------------
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Declare LastSwitchState globally so it persists between calls
;Dim LastSwitchState As Bit
;LastSwitchState = FALSE
	bcf	SYSBITVAR0,0,ACCESS
;Do Forever
SysDoLoop_S1
;funcKeyPressed is a Function that returns TRUE only at the instant
;the switch is pressed down (the rising edge). It returns FALSE for
;every other call, including the moment the switch is released.
;If  funcKeyPressed() = TRUE Then
	banksel	0
	rcall	FN_FUNCKEYPRESSED
	btfss	SYSBITVAR0,1,ACCESS
	bra	ENDIF1
;push button pressed
;LEDD0 = !LEDD0
	clrf	SysTemp1,ACCESS
	banksel	PORTB
	btfsc	PORTB,0,BANKED
	incf	SysTemp1,F,ACCESS
	comf	SysTemp1,F,ACCESS
	bcf	LATB,0,BANKED
	btfsc	SysTemp1,0,ACCESS
	bsf	LATB,0,BANKED
;LEDD1 = !LEDD1
	clrf	SysTemp1,ACCESS
	btfsc	PORTB,1,BANKED
	incf	SysTemp1,F,ACCESS
	comf	SysTemp1,F,ACCESS
	bcf	LATB,1,BANKED
	btfsc	SysTemp1,0,ACCESS
	bsf	LATB,1,BANKED
;LEDD2 = !LEDD2
	clrf	SysTemp1,ACCESS
	btfsc	PORTB,2,BANKED
	incf	SysTemp1,F,ACCESS
	comf	SysTemp1,F,ACCESS
	bcf	LATB,2,BANKED
	btfsc	SysTemp1,0,ACCESS
	bsf	LATB,2,BANKED
;LEDD3 = !LEDD3
	clrf	SysTemp1,ACCESS
	btfsc	PORTB,3,BANKED
	incf	SysTemp1,F,ACCESS
	comf	SysTemp1,F,ACCESS
	bcf	LATB,3,BANKED
	btfsc	SysTemp1,0,ACCESS
	bsf	LATB,3,BANKED
;End If
ENDIF1
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;
;Explanation:
;
;Variable Definition:
;`CurrentSwitchState` is declared locally as a Bit to store the current state.
;`LastSwitchState` is declared globally outside the function to retain
;its state between function calls (since GCBASIC local variables reset).
;
;Debouncing:
;A small delay (wait 10 ms) is introduced to debounce the switch,
;ensuring stable readings by filtering out mechanical contact bounce.
;
;Switch State Reading:
;The state of the switch is read using SWITCHIN = DOWN.
;If the switch is pressed, CurrentSwitchState is set to TRUE; otherwise, it is set to FALSE.
;
;Press (Rising-Edge) Detection:
;The function only reports TRUE at the exact moment the switch goes
;from released (FALSE) to pressed (TRUE). This is checked explicitly by
;testing CurrentSwitchState = TRUE together with LastSwitchState = FALSE,
;so a press is detected once, and once only, when it happens - never on
;release, and never repeatedly while the switch is held down.
;
;State Tracking:
;LastSwitchState is updated on every call (whether or not a press was
;detected) so the next call always has an accurate previous state to
;compare against.
;
;Release Behavior:
;Releasing the switch (TRUE -> FALSE) never causes the function to
;return TRUE. Only the press edge does.
;
;This function returns TRUE only at the instant the switch is pressed
;(i.e. on the rising edge, when the switch transitions from released to
;pressed). It ignores the release transition entirely.
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	129
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	40
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

;Source: 070_debounce_the_switch.gcb (161)
FN_FUNCKEYPRESSED
;Define local variable
;Dim CurrentSwitchState As Bit
;Small delay to debounce the switch
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Check if the switch is pressed down
;If ( SWITCHIN = DOWN ) Then
	banksel	PORTA
	btfsc	PORTA,4,BANKED
	bra	ELSE10_1
;Set the state to TRUE if the switch is pressed
;CurrentSwitchState = TRUE
	bsf	SYSBITVAR0,2,ACCESS
;Else
	bra	ENDIF10
ELSE10_1
;Set the state to FALSE if the switch is released
;CurrentSwitchState = FALSE
	bcf	SYSBITVAR0,2,ACCESS
;End If
ENDIF10
;Only report a "press" on the rising edge: switch was up last time,
;and is down now. This deliberately excludes the release transition
;(down -> up), so the LEDs toggle on press, not on release.
;If (CurrentSwitchState = TRUE) And (LastSwitchState = FALSE) Then
	clrf	SysByteTempX,ACCESS
	btfsc	SYSBITVAR0,2,ACCESS
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	clrf	SysByteTempX,ACCESS
	btfss	SYSBITVAR0,0,ACCESS
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp2
	movf	SysTemp1,W,ACCESS
	andwf	SysTemp2,W,ACCESS
	movwf	SysTemp3,ACCESS
	btfss	SysTemp3,0,ACCESS
	bra	ELSE11_1
;funcKeyPressed = TRUE
	bsf	SYSBITVAR0,1,ACCESS
;Else
	bra	ENDIF11
ELSE11_1
;funcKeyPressed = FALSE
	bcf	SYSBITVAR0,1,ACCESS
;End If
ENDIF11
;Always update the last known state so the next call can correctly
;detect the next press edge.
;LastSwitchState = CurrentSwitchState
	bcf	SYSBITVAR0,0,ACCESS
	btfsc	SYSBITVAR0,2,ACCESS
	bsf	SYSBITVAR0,0,ACCESS
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


 END
