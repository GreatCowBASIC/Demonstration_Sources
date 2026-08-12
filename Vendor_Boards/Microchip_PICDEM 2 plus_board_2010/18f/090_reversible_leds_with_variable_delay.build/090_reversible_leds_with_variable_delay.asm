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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\090_reversible_leds_with_variable_delay.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\090_reversible_leds_with_variable_delay.build\090_reversible_leds_with_variable_delay.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\090_reversible_leds_with_variable_delay.gcb"
 SUBTITLE    "08-11-2026 06:37:38"
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
ADREADPORT                       EQU    1293          ; 0x50D (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
LEDPORTSTATE                     EQU    1294          ; 0x50E (SA)
L_CALIBRATE                      EQU    1295          ; 0x50F (SA)
L_CALIBRATE_H                    EQU    1296          ; 0x510 (SA)
L_FROMHIGH                       EQU    1297          ; 0x511 (SA)
L_FROMHIGH_H                     EQU    1298          ; 0x512 (SA)
L_FROMLOW                        EQU    1299          ; 0x513 (SA)
L_FROMLOW_H                      EQU    1300          ; 0x514 (SA)
L_MAP                            EQU    1301          ; 0x515 (SA)
L_MAP_H                          EQU    1302          ; 0x516 (SA)
L_SYSCALC                        EQU    1303          ; 0x517 (SA)
L_SYSCALCF                       EQU    1305          ; 0x519 (SA)
L_SYSCALCF_E                     EQU    1308          ; 0x51C (SA)
L_SYSCALCF_H                     EQU    1306          ; 0x51A (SA)
L_SYSCALCF_U                     EQU    1307          ; 0x51B (SA)
L_SYSCALC_H                      EQU    1304          ; 0x518 (SA)
L_TOHIGH                         EQU    1309          ; 0x51D (SA)
L_TOHIGH_H                       EQU    1310          ; 0x51E (SA)
L_TOLOW                          EQU    1311          ; 0x51F (SA)
L_TOLOW_H                        EQU    1312          ; 0x520 (SA)
MYDELAY                          EQU    1313          ; 0x521 (SA)
MYDELAY_H                        EQU    1314          ; 0x522 (SA)
READAD                           EQU    1315          ; 0x523 (SA)
SCALE                            EQU    1316          ; 0x524 (SA)
SCALE_H                          EQU    1317          ; 0x525 (SA)
SYSBITVAR0                       EQU    1318          ; 0x526 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSDIVLOOP                       EQU    1284          ; 0x504 (SA)
SYSLONGDIVMULTA                  EQU    1319          ; 0x527 (SA)
SYSLONGDIVMULTA_E                EQU    1322          ; 0x52A (SA)
SYSLONGDIVMULTA_H                EQU    1320          ; 0x528 (SA)
SYSLONGDIVMULTA_U                EQU    1321          ; 0x529 (SA)
SYSLONGDIVMULTB                  EQU    1323          ; 0x52B (SA)
SYSLONGDIVMULTB_E                EQU    1326          ; 0x52E (SA)
SYSLONGDIVMULTB_H                EQU    1324          ; 0x52C (SA)
SYSLONGDIVMULTB_U                EQU    1325          ; 0x52D (SA)
SYSLONGDIVMULTX                  EQU    1327          ; 0x52F (SA)
SYSLONGDIVMULTX_E                EQU    1330          ; 0x532 (SA)
SYSLONGDIVMULTX_H                EQU    1328          ; 0x530 (SA)
SYSLONGDIVMULTX_U                EQU    1329          ; 0x531 (SA)
SYSLONGTEMPA                     EQU    1285          ; 0x505 (SA)
SYSLONGTEMPA_E                   EQU    1288          ; 0x508 (SA)
SYSLONGTEMPA_H                   EQU    1286          ; 0x506 (SA)
SYSLONGTEMPA_U                   EQU    1287          ; 0x507 (SA)
SYSLONGTEMPB                     EQU    1289          ; 0x509 (SA)
SYSLONGTEMPB_E                   EQU    1292          ; 0x50C (SA)
SYSLONGTEMPB_H                   EQU    1290          ; 0x50A (SA)
SYSLONGTEMPB_U                   EQU    1291          ; 0x50B (SA)
SYSLONGTEMPX                     EQU    1280          ; 0x500 (SA)
SYSLONGTEMPX_E                   EQU    1283          ; 0x503 (SA)
SYSLONGTEMPX_H                   EQU    1281          ; 0x501 (SA)
SYSLONGTEMPX_U                   EQU    1282          ; 0x502 (SA)
SYSTEMP1                         EQU    1331          ; 0x533 (SA)
SYSTEMP1_E                       EQU    1334          ; 0x536 (SA)
SYSTEMP1_H                       EQU    1332          ; 0x534 (SA)
SYSTEMP1_U                       EQU    1333          ; 0x535 (SA)
SYSTEMP2                         EQU    1335          ; 0x537 (SA)
SYSTEMP2_H                       EQU    1336          ; 0x538 (SA)
SYSTEMP3                         EQU    1337          ; 0x539 (SA)
SYSWAITTEMP10US                  EQU    1285          ; 0x505 (SA)
SYSWAITTEMPMS                    EQU    1282          ; 0x502 (SA)
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503 (SA)

;********************************************************************************

;Alias variables
SYSREADADBYTE EQU 1315
SYSSCALEWORD EQU 1316
SYSSCALEWORD_H EQU 1317

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
;This demonstration shows the impact of the time delay to manage the debouncing of a switch.
;The ADC value creates a delay and LEDs switch between each other when the switch is depressed.
;
;
;Press the switch to reverse the direction of the LEDs, increase the ADC value to increase the debounce check.
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
;************************************************************************
;@author  EvanV
;@licence GPL
;@version 1.01
;@date    09.08.2026
;----- Configuration
;
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
;To verify: probe PORTA.4 with a meter, or just try one polarity - if
;direction reverses on release instead of press, flip this value.
;------------------------------------------------------------------------
;Dir     RSTBUTTON     In  // this is set automatically - and, you cannot set as an output
	bsf	TRISE,3,BANKED
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim direction As Bit
;Dim mydelay As Word
;Dim LEDportState as Byte
;Declare LastSwitchState globally so it persists between calls to
;funcKeyPressed().
;Dim LastSwitchState As Bit
;LastSwitchState = FALSE
	bcf	SYSBITVAR0,1,ACCESS
;Control Constants
;Start from left direction
;direction = LED_LEFT
	bsf	SYSBITVAR0,0,ACCESS
;Set the initial LED states - change to suit your configuration
;LEDportState = 0b0001
	movlw	1
	movwf	LEDPORTSTATE,ACCESS
;Do
SysDoLoop_S1
;Get a value for the ADC port
;mydelay = ReadAD( ANA0 )
	clrf	ADREADPORT,ACCESS
	banksel	0
	rcall	FN_READAD6
	movff	SYSREADADBYTE,MYDELAY
	clrf	MYDELAY_H,ACCESS
;mydelay = scale( mydelay, 0, 255, 50, 1000 )
	movff	MYDELAY,L_MAP
	movff	MYDELAY_H,L_MAP_H
	clrf	L_FROMLOW,ACCESS
	clrf	L_FROMLOW_H,ACCESS
	setf	L_FROMHIGH,ACCESS
	clrf	L_FROMHIGH_H,ACCESS
	movlw	50
	movwf	L_TOLOW,ACCESS
	clrf	L_TOLOW_H,ACCESS
	movlw	232
	movwf	L_TOHIGH,ACCESS
	movlw	3
	movwf	L_TOHIGH_H,ACCESS
	clrf	L_CALIBRATE,ACCESS
	clrf	L_CALIBRATE_H,ACCESS
	rcall	FN_SCALE79
	movff	SYSSCALEWORD,MYDELAY
	movff	SYSSCALEWORD_H,MYDELAY_H
;Set the port and only the state of our LEDs
;LEDPORT = LEDportState AND 0b00001111
	movlw	15
	andwf	LEDPORTSTATE,W,ACCESS
	banksel	LATB
	movwf	LATB,BANKED
;Wait, and then check the switch has been pressed
;Wait mydelay ms
	movff	MYDELAY,SysWaitTempMS
	movff	MYDELAY_H,SysWaitTempMS_H
	banksel	0
	rcall	Delay_MS
;Manage the direction
;funcKeyPressed() returns TRUE only once per press - at the instant
;the switch transitions from released to pressed (the rising edge).
;It will not re-trigger while the switch is held down, and it never
;triggers on release.
;If  funcKeyPressed() = TRUE Then
	rcall	FN_FUNCKEYPRESSED
	btfss	SYSBITVAR0,2,ACCESS
	bra	ENDIF1
;change the direction
;direction = NOT direction
	clrf	SysTemp1,ACCESS
	btfsc	SYSBITVAR0,0,ACCESS
	incf	SysTemp1,F,ACCESS
	comf	SysTemp1,F,ACCESS
	bcf	SYSBITVAR0,0,ACCESS
	btfsc	SysTemp1,0,ACCESS
	bsf	SYSBITVAR0,0,ACCESS
;End If
ENDIF1
;Set the LEDs
;If  direction = LED_LEFT  Then
	btfss	SYSBITVAR0,0,ACCESS
	bra	ELSE2_1
;If LEDportState.3 = 1 then
	btfss	LEDPORTSTATE,3,ACCESS
	bra	ELSE3_1
;LEDportState = 0
	clrf	LEDPORTSTATE,ACCESS
;C = 1
	bsf	STATUS,C,ACCESS
;Else
	bra	ENDIF3
ELSE3_1
;C = 0
	bcf	STATUS,C,ACCESS
;End If
ENDIF3
;shift the contents of LEDportState
;Rotate LEDportState Left
	rlcf	LEDPORTSTATE,F,ACCESS
;Else
	bra	ENDIF2
ELSE2_1
;shift the contents of LEDportState
;C = 0
	bcf	STATUS,C,ACCESS
;Rotate LEDportState Right
	rrcf	LEDPORTSTATE,F,ACCESS
;If C = 1 Then LEDportState.3 = 1
	btfsc	STATUS,C,ACCESS
;If C = 1 Then LEDportState.3 = 1
	bsf	LEDPORTSTATE,3,ACCESS
;If C = 1 Then LEDportState.3 = 1
;End If
ENDIF2
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;
;Explanation:
;
;Variable Definition:
;`CurrentSwitchState` is declared locally as a Bit to store the current state.
;`LastSwitchState` is declared globally, above the main Do loop, so it retains
;its value between function calls (GCBASIC local variables do NOT persist
;between calls - declaring it inside the function, as in earlier versions of
;this code, caused it to reset to FALSE every time and re-trigger on every
;iteration while the button was held down).
;
;Debouncing:
;A small delay (wait 1 ms) is introduced to debounce the switch,
;filtering out mechanical contact bounce before the pin is sampled.
;
;Switch State Reading:
;The state of the switch is read using SWITCHIN = DOWN.
;If the switch is pressed, CurrentSwitchState is set to TRUE; otherwise, it is set to FALSE.
;
;Press (Rising-Edge) Detection:
;The function only reports TRUE at the exact moment the switch goes
;from released (FALSE) to pressed (TRUE) - i.e. CurrentSwitchState = TRUE
;AND LastSwitchState = FALSE. This means a press is detected once, and
;once only, when it happens: never on release, and never repeatedly
;while the switch is held down.
;
;State Tracking:
;LastSwitchState is updated on every call (whether or not a press was
;detected) so the next call always has an accurate previous state to
;compare against.
;
;This function returns TRUE only at the instant the switch is pressed
;(i.e. on the rising edge, when the switch transitions from released to
;pressed). It ignores the release transition entirely, and requires
;LastSwitchState to be declared globally (see above) to work correctly.
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

Delay_10US
D10US_START
	movlw	52
	movwf	DELAYTEMP,ACCESS
DelayUS0
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	decfsz	SysWaitTemp10US, F,ACCESS
	bra	D10US_START
	return

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

;Source: 090_reversible_leds_with_variable_delay.gcb (202)
FN_FUNCKEYPRESSED
;Define local variable
;Dim CurrentSwitchState As Bit
;wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Is the switch pressed down ?
;If ( SWITCHIN = DOWN ) Then
	banksel	PORTA
	btfsc	PORTA,4,BANKED
	bra	ELSE7_1
;Set the state
;CurrentSwitchState = TRUE
	bsf	SYSBITVAR0,3,ACCESS
;Else
	bra	ENDIF7
ELSE7_1
;So, switch is therefore UP/released
;CurrentSwitchState = FALSE
	bcf	SYSBITVAR0,3,ACCESS
;End If
ENDIF7
;Only report a "press" on the rising edge: switch was up last time,
;and is down now. This deliberately excludes the release transition
;(down -> up), so direction changes on press, not on release.
;If ( CurrentSwitchState = TRUE ) AND ( LastSwitchState = FALSE ) Then
	clrf	SysByteTempX,ACCESS
	btfsc	SYSBITVAR0,3,ACCESS
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	clrf	SysByteTempX,ACCESS
	btfss	SYSBITVAR0,1,ACCESS
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp2
	movf	SysTemp1,W,ACCESS
	andwf	SysTemp2,W,ACCESS
	movwf	SysTemp3,ACCESS
	btfss	SysTemp3,0,ACCESS
	bra	ELSE8_1
;Return the state value - returns TRUE
;funcKeyPressed = TRUE
	bsf	SYSBITVAR0,2,ACCESS
;Else
	bra	ENDIF8
ELSE8_1
;Switch is not newly pressed
;funcKeyPressed = FALSE
	bcf	SYSBITVAR0,2,ACCESS
;End If
ENDIF8
;Always update the last known state so the next call can correctly
;detect the next press edge.
;LastSwitchState = CurrentSwitchState
	bcf	SYSBITVAR0,1,ACCESS
	btfsc	SYSBITVAR0,3,ACCESS
	bsf	SYSBITVAR0,1,ACCESS
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

;Overloaded signature: BYTE:, Source: a-d.h (2170)
FN_READAD6
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	movff	ADREADPORT,ADPCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (637)
;Configure ANSELA/B/C/D @DebugADC_H
;Select Case ADReadPort
;Case 0: Set ANSELA.0 On
SysSelect1Case1
	movf	ADREADPORT,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;Case 0: Set ANSELA.0 On
	banksel	ANSELA
	bsf	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	bra	SysSelectEnd1
SysSelect1Case2
	decf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;Case 1: Set ANSELA.1 On
	banksel	ANSELA
	bsf	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	2
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;Case 2: Set ANSELA.2 On
	banksel	ANSELA
	bsf	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
;Case 3: Set ANSELA.3 On
	banksel	ANSELA
	bsf	ANSELA,3,BANKED
;Case 4: Set ANSELA.4 ON
	bra	SysSelectEnd1
SysSelect1Case5
	movlw	4
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case6
;Case 4: Set ANSELA.4 ON
	banksel	ANSELA
	bsf	ANSELA,4,BANKED
;Case 5: Set ANSELA.5 On
	bra	SysSelectEnd1
SysSelect1Case6
	movlw	5
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case7
;Case 5: Set ANSELA.5 On
	banksel	ANSELA
	bsf	ANSELA,5,BANKED
;Case 6: Set ANSELA.6 On
	bra	SysSelectEnd1
SysSelect1Case7
	movlw	6
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case8
;Case 6: Set ANSELA.6 On
	banksel	ANSELA
	bsf	ANSELA,6,BANKED
;Case 7: Set ANSELA.7 On
	bra	SysSelectEnd1
SysSelect1Case8
	movlw	7
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case9
;Case 7: Set ANSELA.7 On
	banksel	ANSELA
	bsf	ANSELA,7,BANKED
;Case 8: Set ANSELB.0 On
	bra	SysSelectEnd1
SysSelect1Case9
	movlw	8
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case10
;Case 8: Set ANSELB.0 On
	banksel	ANSELB
	bsf	ANSELB,0,BANKED
;Case 9: Set ANSELB.1 On
	bra	SysSelectEnd1
SysSelect1Case10
	movlw	9
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case11
;Case 9: Set ANSELB.1 On
	banksel	ANSELB
	bsf	ANSELB,1,BANKED
;Case 10: Set ANSELB.2 On
	bra	SysSelectEnd1
SysSelect1Case11
	movlw	10
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case12
;Case 10: Set ANSELB.2 On
	banksel	ANSELB
	bsf	ANSELB,2,BANKED
;Case 11: Set ANSELB.3 On
	bra	SysSelectEnd1
SysSelect1Case12
	movlw	11
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case13
;Case 11: Set ANSELB.3 On
	banksel	ANSELB
	bsf	ANSELB,3,BANKED
;Case 12: Set ANSELB.4 On
	bra	SysSelectEnd1
SysSelect1Case13
	movlw	12
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case14
;Case 12: Set ANSELB.4 On
	banksel	ANSELB
	bsf	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	bra	SysSelectEnd1
SysSelect1Case14
	movlw	13
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case15
;Case 13: Set ANSELB.5 On
	banksel	ANSELB
	bsf	ANSELB,5,BANKED
;Case 14: Set ANSELB.6 On
	bra	SysSelectEnd1
SysSelect1Case15
	movlw	14
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case16
;Case 14: Set ANSELB.6 On
	banksel	ANSELB
	bsf	ANSELB,6,BANKED
;Case 15: Set ANSELB.7 On
	bra	SysSelectEnd1
SysSelect1Case16
	movlw	15
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case17
;Case 15: Set ANSELB.7 On
	banksel	ANSELB
	bsf	ANSELB,7,BANKED
;Case 16: Set ANSELC.0 On
	bra	SysSelectEnd1
SysSelect1Case17
	movlw	16
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case18
;Case 16: Set ANSELC.0 On
	banksel	ANSELC
	bsf	ANSELC,0,BANKED
;Case 17: Set ANSELC.1 On
	bra	SysSelectEnd1
SysSelect1Case18
	movlw	17
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case19
;Case 17: Set ANSELC.1 On
	banksel	ANSELC
	bsf	ANSELC,1,BANKED
;Case 18: Set ANSELC.2 On
	bra	SysSelectEnd1
SysSelect1Case19
	movlw	18
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case20
;Case 18: Set ANSELC.2 On
	banksel	ANSELC
	bsf	ANSELC,2,BANKED
;Case 19: Set ANSELC.3 On
	bra	SysSelectEnd1
SysSelect1Case20
	movlw	19
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case21
;Case 19: Set ANSELC.3 On
	banksel	ANSELC
	bsf	ANSELC,3,BANKED
;Case 20: Set ANSELC.4 On
	bra	SysSelectEnd1
SysSelect1Case21
	movlw	20
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case22
;Case 20: Set ANSELC.4 On
	banksel	ANSELC
	bsf	ANSELC,4,BANKED
;Case 21: Set ANSELC.5 On
	bra	SysSelectEnd1
SysSelect1Case22
	movlw	21
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case23
;Case 21: Set ANSELC.5 On
	banksel	ANSELC
	bsf	ANSELC,5,BANKED
;Case 22: Set ANSELC.6 On
	bra	SysSelectEnd1
SysSelect1Case23
	movlw	22
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case24
;Case 22: Set ANSELC.6 On
	banksel	ANSELC
	bsf	ANSELC,6,BANKED
;Case 23: Set ANSELC.7 On
	bra	SysSelectEnd1
SysSelect1Case24
	movlw	23
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case25
;Case 23: Set ANSELC.7 On
	banksel	ANSELC
	bsf	ANSELC,7,BANKED
;Case 32: Set ANSELE.0 On
	bra	SysSelectEnd1
SysSelect1Case25
	movlw	32
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case26
;Case 32: Set ANSELE.0 On
	banksel	ANSELE
	bsf	ANSELE,0,BANKED
;Case 33: Set ANSELE.1 On
	bra	SysSelectEnd1
SysSelect1Case26
	movlw	33
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case27
;Case 33: Set ANSELE.1 On
	banksel	ANSELE
	bsf	ANSELE,1,BANKED
;Case 34: Set ANSELE.2 On
	bra	SysSelectEnd1
SysSelect1Case27
	movlw	34
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
;Case 34: Set ANSELE.2 On
	banksel	ANSELE
	bsf	ANSELE,2,BANKED
;End Select  '*** ANSEL Bits should now be set ***
SysSelectEnd1
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
	banksel	ADCON0
	bcf	ADCON0,ADCS,BANKED
;ADCLK = 1 ' default to FOSC/2
	movlw	1
	movwf	ADCLK,BANKED
;Conversion Clock Speed
;SET ADCS OFF  'ADCON0.4
	bcf	ADCON0,ADCS,BANKED
;ADCLK = 15    'FOSC/16
	movlw	15
	movwf	ADCLK,BANKED
;Configure AD clock defaults fpr older 18F that do not have ADCLK
;SET ADCS2 OFF
	bcf	ADCLK,ADCS2,BANKED
;SET ADCS1 OFF
	bcf	ADCLK,ADCS1,BANKED
;SET ADCS0 ON
	bsf	ADCLK,ADCS0,BANKED
;Result formatting
;if ADLeftadjust = 0 then
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
	bcf	ADCON0,ADFM0,BANKED
;Set ADFM0 OFF
	bcf	ADCON0,ADFM0,BANKED
;End if
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	movff	ADREADPORT,ADPCH
;Enable AD Operations
;SET ADON ON
	bsf	ADCON0,ADON,BANKED
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US,ACCESS
	banksel	0
	rcall	Delay_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE,BANKED
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop1
	btfsc	ADCON0,GO_NOT_DONE,BANKED
	bra	SysWaitLoop1
;Switch off A/D
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
;ReadAD = ADRESH
	movff	ADRESH,READAD
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:integer:, Source: stdbasic.h (266)
FN_SCALE79
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	movf	L_FROMLOW,W,ACCESS
	subwf	L_MAP,W,ACCESS
	movwf	SysTemp1,ACCESS
	movf	L_FROMLOW_H,W,ACCESS
	subwfb	L_MAP_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movf	L_TOLOW,W,ACCESS
	subwf	L_TOHIGH,W,ACCESS
	movwf	SysTemp2,ACCESS
	movf	L_TOLOW_H,W,ACCESS
	subwfb	L_TOHIGH_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	movff	SYSTEMP1,SysLONGTempA
	movff	SYSTEMP1_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	SYSTEMP2,SysLONGTempB
	movff	SYSTEMP2_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSMULTSUB32
	movff	SysLONGTempX,L_SYSCALCF
	movff	SysLONGTempX_H,L_SYSCALCF_H
	movff	SysLONGTempX_U,L_SYSCALCF_U
	movff	SysLONGTempX_E,L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	movf	L_FROMLOW,W,ACCESS
	subwf	L_FROMHIGH,W,ACCESS
	movwf	L_SYSCALC,ACCESS
	movf	L_FROMLOW_H,W,ACCESS
	subwfb	L_FROMHIGH_H,W,ACCESS
	movwf	L_SYSCALC_H,ACCESS
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
	movff	L_SYSCALCF,SysLONGTempA
	movff	L_SYSCALCF_H,SysLONGTempA_H
	movff	L_SYSCALCF_U,SysLONGTempA_U
	movff	L_SYSCALCF_E,SysLONGTempA_E
	movff	L_SYSCALC,SysLONGTempB
	movff	L_SYSCALC_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSDIVSUB32
	movff	SysLONGTempA,SysTemp1
	movff	SysLONGTempA_H,SysTemp1_H
	movff	SysLONGTempA_U,SysTemp1_U
	movff	SysLONGTempA_E,SysTemp1_E
	movf	L_TOLOW,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	movf	L_TOLOW_H,W,ACCESS
	addwfc	SysTemp1_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	movf	L_CALIBRATE,W,ACCESS
	addwf	SysTemp2,W,ACCESS
	movwf	SCALE,ACCESS
	movf	L_CALIBRATE_H,W,ACCESS
	addwfc	SysTemp2_H,W,ACCESS
	movwf	SCALE_H,ACCESS
	return

;********************************************************************************

;Source: system.h (4191)
SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysLongTempB, W
	movf	SYSLONGTEMPB, W,ACCESS
;cpfseq SysLongTempA
	cpfseq	SYSLONGTEMPA,ACCESS
;return
	return
;Test high, exit if false
;movf SysLongTempB_H, W
	movf	SYSLONGTEMPB_H, W,ACCESS
;cpfseq SysLongTempA_H
	cpfseq	SYSLONGTEMPA_H,ACCESS
;return
	return
;Test upper, exit if false
;movf SysLongTempB_U, W
	movf	SYSLONGTEMPB_U, W,ACCESS
;cpfseq SysLongTempA_U
	cpfseq	SYSLONGTEMPA_U,ACCESS
;return
	return
;Test exp, exit if false
;movf SysLongTempB_E, W
	movf	SYSLONGTEMPB_E, W,ACCESS
;cpfseq SysLongTempA_E
	cpfseq	SYSLONGTEMPA_E,ACCESS
;return
	return
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (4589)
SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test Exp, exit if more
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W,ACCESS
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W,ACCESS
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W,ACCESS
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W,ACCESS
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLT32TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

;Source: system.h (3581)
SYSDIVSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	movff	SYSLONGTEMPA,SYSLONGDIVMULTA
	movff	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	movff	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	movff	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movff	SYSLONGTEMPB,SYSLONGDIVMULTB
	movff	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	movff	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	movff	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX,ACCESS
	clrf	SYSLONGDIVMULTX_H,ACCESS
	clrf	SYSLONGDIVMULTX_U,ACCESS
	clrf	SYSLONGDIVMULTX_E,ACCESS
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movff	SYSLONGDIVMULTB,SysLONGTempA
	movff	SYSLONGDIVMULTB_H,SysLONGTempA_H
	movff	SYSLONGDIVMULTB_U,SysLONGTempA_U
	movff	SYSLONGDIVMULTB_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSCOMPEQUAL32
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF13
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF13
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP,ACCESS
SYSDIV32START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysLongDivMultA Left
	rlcf	SYSLONGDIVMULTA,F,ACCESS
	rlcf	SYSLONGDIVMULTA_H,F,ACCESS
	rlcf	SYSLONGDIVMULTA_U,F,ACCESS
	rlcf	SYSLONGDIVMULTA_E,F,ACCESS
;Rotate SysLongDivMultX Left
	rlcf	SYSLONGDIVMULTX,F,ACCESS
	rlcf	SYSLONGDIVMULTX_H,F,ACCESS
	rlcf	SYSLONGDIVMULTX_U,F,ACCESS
	rlcf	SYSLONGDIVMULTX_E,F,ACCESS
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,ACCESS
	subwf	SYSLONGDIVMULTX,F,ACCESS
	movf	SYSLONGDIVMULTB_H,W,ACCESS
	subwfb	SYSLONGDIVMULTX_H,F,ACCESS
	movf	SYSLONGDIVMULTB_U,W,ACCESS
	subwfb	SYSLONGDIVMULTX_U,F,ACCESS
	movf	SYSLONGDIVMULTB_E,W,ACCESS
	subwfb	SYSLONGDIVMULTX_E,F,ACCESS
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0,ACCESS
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF14
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0,ACCESS
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,ACCESS
	addwf	SYSLONGDIVMULTX,F,ACCESS
	movf	SYSLONGDIVMULTB_H,W,ACCESS
	addwfc	SYSLONGDIVMULTX_H,F,ACCESS
	movf	SYSLONGDIVMULTB_U,W,ACCESS
	addwfc	SYSLONGDIVMULTX_U,F,ACCESS
	movf	SYSLONGDIVMULTB_E,W,ACCESS
	addwfc	SYSLONGDIVMULTX_E,F,ACCESS
;End If
ENDIF14
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv32Start
	bra	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movff	SYSLONGDIVMULTA,SYSLONGTEMPA
	movff	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	movff	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	movff	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	return

;********************************************************************************

;Source: system.h (3088)
SYSMULTSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;Can't use normal SysDivMult variables for 32 bit, they overlap with
;SysLongTemp variables
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	movff	SYSLONGTEMPA,SYSLONGDIVMULTA
	movff	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	movff	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	movff	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movff	SYSLONGTEMPB,SYSLONGDIVMULTB
	movff	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	movff	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	movff	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX,ACCESS
	clrf	SYSLONGDIVMULTX_H,ACCESS
	clrf	SYSLONGDIVMULTX_U,ACCESS
	clrf	SYSLONGDIVMULTX_E,ACCESS
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	btfss	SYSLONGDIVMULTB,0,ACCESS
	bra	ENDIF11
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	movf	SYSLONGDIVMULTA,W,ACCESS
	addwf	SYSLONGDIVMULTX,F,ACCESS
	movf	SYSLONGDIVMULTA_H,W,ACCESS
	addwfc	SYSLONGDIVMULTX_H,F,ACCESS
	movf	SYSLONGDIVMULTA_U,W,ACCESS
	addwfc	SYSLONGDIVMULTX_U,F,ACCESS
	movf	SYSLONGDIVMULTA_E,W,ACCESS
	addwfc	SYSLONGDIVMULTX_E,F,ACCESS
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
ENDIF11
;set STATUS.C OFF
	bcf	STATUS,C,ACCESS
;rotate SysLongDivMultB right
	rrcf	SYSLONGDIVMULTB_E,F,ACCESS
	rrcf	SYSLONGDIVMULTB_U,F,ACCESS
	rrcf	SYSLONGDIVMULTB_H,F,ACCESS
	rrcf	SYSLONGDIVMULTB,F,ACCESS
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate SysLongDivMultA left
	rlcf	SYSLONGDIVMULTA,F,ACCESS
	rlcf	SYSLONGDIVMULTA_H,F,ACCESS
	rlcf	SYSLONGDIVMULTA_U,F,ACCESS
	rlcf	SYSLONGDIVMULTA_E,F,ACCESS
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movff	SYSLONGDIVMULTB,SysLONGTempB
	movff	SYSLONGDIVMULTB_H,SysLONGTempB_H
	movff	SYSLONGDIVMULTB_U,SysLONGTempB_U
	movff	SYSLONGDIVMULTB_E,SysLONGTempB_E
	clrf	SysLONGTempA,ACCESS
	clrf	SysLONGTempA_H,ACCESS
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	rcall	SYSCOMPLESSTHAN32
	btfsc	SysByteTempX,0,ACCESS
;if SysLongDivMultB > 0 then goto MUL32LOOP
	bra	MUL32LOOP
;if SysLongDivMultB > 0 then goto MUL32LOOP
;SysLongTempX = SysLongDivMultX
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	return

;********************************************************************************


 END
