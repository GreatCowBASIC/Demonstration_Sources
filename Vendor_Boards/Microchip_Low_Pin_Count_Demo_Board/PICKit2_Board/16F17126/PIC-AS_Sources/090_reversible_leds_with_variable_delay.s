;Program compiled by GCBASIC (1.00.00 Release Candidate 2022-11-06 (Windows 64 bit) : Build 1189) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F753
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17126_chiprange_demonstrations\090_reversible_leds_with_variable_delay.s"
 SUBTITLE    "11-14-2022"

; Reverse lookup file(s)
; C:\Program Files\Microchip\xc8\v2.40\pic\include\proc\pic16f753.inc
; C:\Program Files\Microchip\xc8\v2.40\pic\dat\cfgmap\16f753.cfgmap
; Alternative CONFIG file is to be found at C:\Program Files\Microchip\xc8\vX.YY\pic\dat\cfgdata as per Microchip support ticket #00730936 

;********************************************************************************

;********************************************************************************
;Explicit CONFIG
 CONFIG CLKOUTEN=OFF                             ;C1 Reverselookup CLKOUTEN = OFF
 CONFIG WRT=OFF                                  ;C1 Reverselookup WRT = OFF
 CONFIG CP=OFF                                   ;C1 Reverselookup CP = OFF
 CONFIG MCLRE=OFF                                ;C1 Reverselookup MCLRE = OFF
 CONFIG WDTE=OFF                                 ;C1 Reverselookup WDTE = OFF
 CONFIG FOSC0=INT                                ;C1 Reverselookup FOSC0 = INT
;Inferred CONFIG


;********************************************************************************
; The XC8 xc.inc include file.  This MUST be placed after the CONFIG statements.

 #include <xc.inc>

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
GLOBAL	ADREADPORT
 ADREADPORT                       EQU 32          ; 0X20
GLOBAL	CHECK_SWITCH
 CHECK_SWITCH                     EQU 33          ; 0X21
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 112          ; 0X70
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 113          ; 0X71
GLOBAL	DIRECTION
 DIRECTION                        EQU 34          ; 0X22
GLOBAL	LEDS
 LEDS                             EQU 35          ; 0X23
GLOBAL	L_CALIBRATE
 L_CALIBRATE                      EQU 36          ; 0X24
GLOBAL	L_CALIBRATE_H
 L_CALIBRATE_H                    EQU 37          ; 0X25
GLOBAL	L_FROMHIGH
 L_FROMHIGH                       EQU 38          ; 0X26
GLOBAL	L_FROMHIGH_H
 L_FROMHIGH_H                     EQU 39          ; 0X27
GLOBAL	L_FROMLOW
 L_FROMLOW                        EQU 40          ; 0X28
GLOBAL	L_FROMLOW_H
 L_FROMLOW_H                      EQU 41          ; 0X29
GLOBAL	L_MAP
 L_MAP                            EQU 42          ; 0X2A
GLOBAL	L_MAP_H
 L_MAP_H                          EQU 43          ; 0X2B
GLOBAL	L_SYSCALC
 L_SYSCALC                        EQU 44          ; 0X2C
GLOBAL	L_SYSCALCF
 L_SYSCALCF                       EQU 46          ; 0X2E
GLOBAL	L_SYSCALCF_E
 L_SYSCALCF_E                     EQU 49          ; 0X31
GLOBAL	L_SYSCALCF_H
 L_SYSCALCF_H                     EQU 47          ; 0X2F
GLOBAL	L_SYSCALCF_U
 L_SYSCALCF_U                     EQU 48          ; 0X30
GLOBAL	L_SYSCALC_H
 L_SYSCALC_H                      EQU 45          ; 0X2D
GLOBAL	L_TOHIGH
 L_TOHIGH                         EQU 50          ; 0X32
GLOBAL	L_TOHIGH_H
 L_TOHIGH_H                       EQU 51          ; 0X33
GLOBAL	L_TOLOW
 L_TOLOW                          EQU 52          ; 0X34
GLOBAL	L_TOLOW_H
 L_TOLOW_H                        EQU 53          ; 0X35
GLOBAL	MYDELAY
 MYDELAY                          EQU 54          ; 0X36
GLOBAL	READAD
 READAD                           EQU 55          ; 0X37
GLOBAL	SCALE
 SCALE                            EQU 56          ; 0X38
GLOBAL	SCALE_H
 SCALE_H                          EQU 57          ; 0X39
GLOBAL	SYSBITVAR0
 SYSBITVAR0                       EQU 58          ; 0X3A
GLOBAL	SYSBYTETEMPX
 SYSBYTETEMPX                     EQU 112          ; 0X70
GLOBAL	SYSDIVLOOP
 SYSDIVLOOP                       EQU 116          ; 0X74
GLOBAL	SYSLONGDIVMULTA
 SYSLONGDIVMULTA                  EQU 59          ; 0X3B
GLOBAL	SYSLONGDIVMULTA_E
 SYSLONGDIVMULTA_E                EQU 62          ; 0X3E
GLOBAL	SYSLONGDIVMULTA_H
 SYSLONGDIVMULTA_H                EQU 60          ; 0X3C
GLOBAL	SYSLONGDIVMULTA_U
 SYSLONGDIVMULTA_U                EQU 61          ; 0X3D
GLOBAL	SYSLONGDIVMULTB
 SYSLONGDIVMULTB                  EQU 63          ; 0X3F
GLOBAL	SYSLONGDIVMULTB_E
 SYSLONGDIVMULTB_E                EQU 66          ; 0X42
GLOBAL	SYSLONGDIVMULTB_H
 SYSLONGDIVMULTB_H                EQU 64          ; 0X40
GLOBAL	SYSLONGDIVMULTB_U
 SYSLONGDIVMULTB_U                EQU 65          ; 0X41
GLOBAL	SYSLONGDIVMULTX
 SYSLONGDIVMULTX                  EQU 67          ; 0X43
GLOBAL	SYSLONGDIVMULTX_E
 SYSLONGDIVMULTX_E                EQU 70          ; 0X46
GLOBAL	SYSLONGDIVMULTX_H
 SYSLONGDIVMULTX_H                EQU 68          ; 0X44
GLOBAL	SYSLONGDIVMULTX_U
 SYSLONGDIVMULTX_U                EQU 69          ; 0X45
GLOBAL	SYSLONGTEMPA
 SYSLONGTEMPA                     EQU 117          ; 0X75
GLOBAL	SYSLONGTEMPA_E
 SYSLONGTEMPA_E                   EQU 120          ; 0X78
GLOBAL	SYSLONGTEMPA_H
 SYSLONGTEMPA_H                   EQU 118          ; 0X76
GLOBAL	SYSLONGTEMPA_U
 SYSLONGTEMPA_U                   EQU 119          ; 0X77
GLOBAL	SYSLONGTEMPB
 SYSLONGTEMPB                     EQU 121          ; 0X79
GLOBAL	SYSLONGTEMPB_E
 SYSLONGTEMPB_E                   EQU 124          ; 0X7C
GLOBAL	SYSLONGTEMPB_H
 SYSLONGTEMPB_H                   EQU 122          ; 0X7A
GLOBAL	SYSLONGTEMPB_U
 SYSLONGTEMPB_U                   EQU 123          ; 0X7B
GLOBAL	SYSLONGTEMPX
 SYSLONGTEMPX                     EQU 112          ; 0X70
GLOBAL	SYSLONGTEMPX_E
 SYSLONGTEMPX_E                   EQU 115          ; 0X73
GLOBAL	SYSLONGTEMPX_H
 SYSLONGTEMPX_H                   EQU 113          ; 0X71
GLOBAL	SYSLONGTEMPX_U
 SYSLONGTEMPX_U                   EQU 114          ; 0X72
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 71          ; 0X47
GLOBAL	SYSTEMP1_E
 SYSTEMP1_E                       EQU 74          ; 0X4A
GLOBAL	SYSTEMP1_H
 SYSTEMP1_H                       EQU 72          ; 0X48
GLOBAL	SYSTEMP1_U
 SYSTEMP1_U                       EQU 73          ; 0X49
GLOBAL	SYSTEMP2
 SYSTEMP2                         EQU 75          ; 0X4B
GLOBAL	SYSTEMP2_H
 SYSTEMP2_H                       EQU 76          ; 0X4C
GLOBAL	SYSTEMP3
 SYSTEMP3                         EQU 77          ; 0X4D
GLOBAL	SYSWAITTEMP10US
 SYSWAITTEMP10US                  EQU 117          ; 0X75
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73

;********************************************************************************

;ALIAS VARIABLES
GLOBAL	SYSREADADBYTE
 SYSREADADBYTE                    EQU 55
GLOBAL	SYSSCALEWORD
 SYSSCALEWORD                     EQU 56
GLOBAL	SYSSCALEWORD_H
 SYSSCALEWORD_H                   EQU 57

;********************************************************************************

 PSECT   PROGMEM0,delta=2, abs
 RESETVEC:
;VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	GOTO	BASPROGRAMSTART
	ORG	4
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	5
GLOBAL	BASPROGRAMSTART
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS

;START OF THE MAIN PROGRAM
;''
;''  This demonstration shows the impact of the time delay to manage the debouncing of a switch.
;''  The ADC value creates a delay and LEDs switch between each other when the switch is depressed.
;''
;''
;''  Press the switch to reverse the direction of the LEDs, increase the ADC value to increase the debounce check.
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.00
;''@date    31.10.2022
;----- Configuration
;Chip Settings.
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:   -----------------SW----------ADC--
;'-----------------------------------------
;'
;' -------------------PORTB----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------------------------
;'-----------------------------------------
;'
;' ------------------PORTC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------LED--LED-LED LED--
;'-----------------------------------------
;'
;Define constants to make things easier. We can reuse these at any time.
;Dir     RC0         Out
	BANKSEL	TRISC
	BCF	TRISC,0
;Dir     RC1         Out
	BCF	TRISC,1
;Dir     RC2         Out
	BCF	TRISC,2
;Dir     RC3         Out
	BCF	TRISC,3
;Dir     POTENTIOMETER In
	BSF	TRISA,0
;Dir     SWITCHIN      In
	BSF	TRISA,3
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim direction As Byte
;Dim mydelay As Byte
;Dim leds As Byte
;start from the right to left
;direction = LED_RIGHT
	BANKSEL	DIRECTION
	CLRF	DIRECTION
;Set the initial LED states - change to suit your configuration
;leds = 0b10000
	MOVLW	16
	MOVWF	LEDS
;Do
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;Get a value for the ADC port
;mydelay = ReadAD( ANA0 )
	CLRF	ADREADPORT
	CALL	FN_READAD5
	MOVF	SYSREADADBYTE,W
	MOVWF	MYDELAY
;mydelay = scale( mydelay, 0, 255, 1, 200 )
	MOVWF	L_MAP
	CLRF	L_MAP_H
	CLRF	L_FROMLOW
	CLRF	L_FROMLOW_H
	MOVLW	255
	MOVWF	L_FROMHIGH
	CLRF	L_FROMHIGH_H
	MOVLW	1
	MOVWF	L_TOLOW
	CLRF	L_TOLOW_H
	MOVLW	200
	MOVWF	L_TOHIGH
	CLRF	L_TOHIGH_H
	CLRF	L_CALIBRATE
	CLRF	L_CALIBRATE_H
	CALL	FN_SCALE73
	MOVF	SYSSCALEWORD,W
	MOVWF	MYDELAY
;Set the LEDs
;If  direction = LED_RIGHT  Then
	MOVF	DIRECTION,F
	BTFSS	STATUS,2
	GOTO	ELSE1_1
;ROTATE THE LEDS.  WE ARE ONLY INTERESTED IN THE FOUR LEDS SO WE MASK THE OTHER .
;Set C Off
	BCF	STATUS,0
;and shift the contents of LEDState
;Rotate leds Right
	RRF	LEDS,F
;If the LEDState.0is equal to 1 then the sequence has completed, then set the initial state again, the same operation as the starting LED.
;If C = 1 Then
	BTFSS	STATUS,0
	GOTO	ENDIF3
;leds = 16
	MOVLW	16
	MOVWF	LEDS
;End if
GLOBAL	ENDIF3
ENDIF3:
;LEDPORT = ( LEDPORT and LEDMASK ) or leds
;USING TEMP VAR METHOD IMPLEMENTED AT #1094. USE A CONSTANT DISABLE1094 TO DISABLE
	CLRF	SYSTEMP1
	MOVF	SYSTEMP1,W
	IORWF	LEDS,W
	BANKSEL	LATC
	MOVWF	LATC
;Else
	GOTO	ENDIF1
GLOBAL	ELSE1_1
ELSE1_1:
;ROTATE THE LEDS.  WE ARE ONLY INTERESTED IN THE FOUR LEDS SO WE MASK THE OTHER .
;Set C Off
	BCF	STATUS,0
;and shift the contents of LEDState
;Rotate leds Left
	RLF	LEDS,F
;If the LEDState.0is equal to 1 then the sequence has completed, then set the initial state again, the same operation as the starting LED.
;If leds = 32 Then
	MOVLW	32
	SUBWF	LEDS,W
	BTFSS	STATUS,2
	GOTO	ENDIF4
;Mask off the other bits
;leds = 1
	MOVLW	1
	MOVWF	LEDS
;End If
GLOBAL	ENDIF4
ENDIF4:
;LEDPORT = ( LEDPORT and LEDMASK ) or leds
;USING TEMP VAR METHOD IMPLEMENTED AT #1094. USE A CONSTANT DISABLE1094 TO DISABLE
	CLRF	SYSTEMP1
	MOVF	SYSTEMP1,W
	IORWF	LEDS,W
	BANKSEL	LATC
	MOVWF	LATC
;End If
GLOBAL	ENDIF1
ENDIF1:
;wait, and then check the switch is DOWN
;Wait mydelay ms
	BANKSEL	MYDELAY
	MOVF	MYDELAY,W
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;If check_switch = TRUE Then
	CALL	FN_CHECK_SWITCH
	INCF	CHECK_SWITCH,W
	BTFSS	STATUS,2
	GOTO	ENDIF2
;toggle the direction
;direction = !direction
;USING TEMP VAR METHOD IMPLEMENTED AT #1094. USE A CONSTANT DISABLE1094 TO DISABLE
	COMF	DIRECTION,F
;End If
GLOBAL	ENDIF2
ENDIF2:
;Loop
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
;global variable - if button is held down, we don't want to keep on switching directions
;Dim previous_state As BIT
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: 090_REVERSIBLE_LEDS_WITH_VARIABLE_DELAY.GCB (128)
GLOBAL	FN_CHECK_SWITCH
FN_CHECK_SWITCH:
;switch is normally open to 5V ...when pressed, RA3 is connected to GND
;If (SwitchIn = SWITCH_DOWN) Then
	BTFSC	PORTA,3
	GOTO	ELSE5_1
;debounce by delaying and checking if switch is still pressed
;Wait 1 ms
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;If ( (previous_state =  SWITCH_DOWN) & (SwitchIn = SWITCH_DOWN) ) Then
	CLRF	SYSBYTETEMPX
	BTFSS	SYSBITVAR0,0
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP1
	CLRF	SYSBYTETEMPX
	BTFSS	PORTA,3
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP2
	MOVF	SYSTEMP1,W
	ANDWF	SYSTEMP2,W
	MOVWF	SYSTEMP3
	BTFSS	SYSTEMP3,0
	GOTO	ELSE6_1
;don't toggle
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;Else
	GOTO	ENDIF6
GLOBAL	ELSE6_1
ELSE6_1:
;check if still down
;If (SwitchIn = SWITCH_DOWN) Then
	BTFSC	PORTA,3
	GOTO	ELSE7_1
;previous_state = SWITCH_DOWN
	BCF	SYSBITVAR0,0
;reverse the LEDs
;check_switch = TRUE
	MOVLW	255
	MOVWF	CHECK_SWITCH
;Exit Function
	RETURN
;Else
	GOTO	ENDIF7
GLOBAL	ELSE7_1
ELSE7_1:
;switch not properly held down
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
;don't reverse
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;End If
GLOBAL	ENDIF7
ENDIF7:
;End If
GLOBAL	ENDIF6
ENDIF6:
;Else
	GOTO	ENDIF5
GLOBAL	ELSE5_1
ELSE5_1:
;switch not pressed
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
;don't reverse
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;End If
GLOBAL	ENDIF5
ENDIF5:
	RETURN

;********************************************************************************

GLOBAL	DELAY_10US
DELAY_10US:
GLOBAL	D10US_START
D10US_START:
	MOVLW	5
	MOVWF	DELAYTEMP
GLOBAL	DELAYUS0
DELAYUS0:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS0
	NOP
	DECFSZ	SYSWAITTEMP10US, F
	GOTO	D10US_START
	RETURN

;********************************************************************************

GLOBAL	DELAY_MS
DELAY_MS:
	INCF	SYSWAITTEMPMS_H, F
GLOBAL	DMS_START
DMS_START:
	MOVLW	4
	MOVWF	DELAYTEMP2
GLOBAL	DMS_OUTER
DMS_OUTER:
	MOVLW	165
	MOVWF	DELAYTEMP
GLOBAL	DMS_INNER
DMS_INNER:
	DECFSZ	DELAYTEMP, F
	GOTO	DMS_INNER
	DECFSZ	DELAYTEMP2, F
	GOTO	DMS_OUTER
	DECFSZ	SYSWAITTEMPMS, F
	GOTO	DMS_START
	DECFSZ	SYSWAITTEMPMS_H, F
	GOTO	DMS_START
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (159)
GLOBAL	INITSYS
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug 'OSCCON type is 103 - This part does not have Bit HFIOFS @ ifndef Bit(HFIOFS)
;OSCCON = OSCCON OR b'01110000'
;USING TEMP VAR METHOD IMPLEMENTED AT #1094. USE A CONSTANT DISABLE1094 TO DISABLE
	MOVLW	112
	BANKSEL	OSCCON
	IORWF	OSCCON,F
;OSCCON = OSCCON AND b'10001111'
;USING TEMP VAR METHOD IMPLEMENTED AT #1094. USE A CONSTANT DISABLE1094 TO DISABLE
	MOVLW	143
	ANDWF	OSCCON,F
;Address the two true tables for IRCF
;[canskip] IRCF2, IRCF1, IRCF0 = b'111'    ;111 = 8 MHz (INTOSC drives clock directly)
	BSF	OSCCON,5
	BSF	OSCCON,4
;End of type 103 init
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	BANKSEL	ADCON0
	BCF	ADCON0,7
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	BCF	ADCON0,0
;ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA
;ANSELC = 0
	CLRF	ANSELC
;Set comparator register bits for many MCUs with register CM2CON0
;C2ON = 0
	BANKSEL	CM2CON0
	BCF	CM2CON0,7
;C1ON = 0
	BCF	CM1CON0,7
;
;'Turn off all ports
;PORTA = 0
	BANKSEL	PORTA
	CLRF	PORTA
;PORTC = 0
	CLRF	PORTC
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2091)
GLOBAL	FN_READAD5
FN_READAD5:
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	BCF	ADCON0,7
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (567)
;Handle devices with no ANSEL0 AND no ANSEL
;Code for devices with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;#ifNdef Bit(CHS5)
;Case 0: Set ANSELA.0 On
GLOBAL	SYSSELECT1CASE1
SYSSELECT1CASE1:
	MOVF	ADREADPORT,F
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE2
;Case 0: Set ANSELA.0 On
	BANKSEL	ANSELA
	BSF	ANSELA,0
;Case 1: Set ANSELA.1 On
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE2
SYSSELECT1CASE2:
	DECF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE3
;Case 1: Set ANSELA.1 On
	BANKSEL	ANSELA
	BSF	ANSELA,1
;Case 2: Set ANSELA.2 On
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE3
SYSSELECT1CASE3:
	MOVLW	2
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE4
;Case 2: Set ANSELA.2 On
	BANKSEL	ANSELA
	BSF	ANSELA,2
;Case 3: Set ANSELA.4 On
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE4
SYSSELECT1CASE4:
	MOVLW	3
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE5
;Case 3: Set ANSELA.4 On
	BANKSEL	ANSELA
	BSF	ANSELA,4
;Case 4: Set ANSELA.5 On
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE5
SYSSELECT1CASE5:
	MOVLW	4
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE6
;Case 4: Set ANSELA.5 On
	BANKSEL	ANSELA
	BSF	ANSELA,5
;Case 16: Set ANSELC.0 On
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE6
SYSSELECT1CASE6:
	MOVLW	16
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE7
;Case 16: Set ANSELC.0 On
	BANKSEL	ANSELC
	BSF	ANSELC,0
;Case 17: Set ANSELC.1 On
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE7
SYSSELECT1CASE7:
	MOVLW	17
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE8
;Case 17: Set ANSELC.1 On
	BANKSEL	ANSELC
	BSF	ANSELC,1
;Case 18: Set ANSELC.2 On
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE8
SYSSELECT1CASE8:
	MOVLW	18
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE9
;Case 18: Set ANSELC.2 On
	BANKSEL	ANSELC
	BSF	ANSELC,2
;Case 19: Set ANSELC.3 On
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE9
SYSSELECT1CASE9:
	MOVLW	19
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE10
;Case 19: Set ANSELC.3 On
	BANKSEL	ANSELC
	BSF	ANSELC,3
;Case 20: Set ANSELC.4 On
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE10
SYSSELECT1CASE10:
	MOVLW	20
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE11
;Case 20: Set ANSELC.4 On
	BANKSEL	ANSELC
	BSF	ANSELC,4
;Case 21: Set ANSELC.5 On
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE11
SYSSELECT1CASE11:
	MOVLW	21
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND1
;Case 21: Set ANSELC.5 On
	BANKSEL	ANSELC
	BSF	ANSELC,5
;End Select  'End Select #1
GLOBAL	SYSSELECTEND1
SYSSELECTEND1:
;SET ADCS2 OFF
	BANKSEL	ADCON1
	BCF	ADCON1,6
;SET ADCS1 OFF
	BCF	ADCON1,5
;SET ADCS0 ON
	BSF	ADCON1,4
;Choose port
;SET CHS0 OFF
	BCF	ADCON0,2
;SET CHS1 OFF
	BCF	ADCON0,3
;SET CHS2 OFF
	BCF	ADCON0,4
;SET CHS3 OFF
	BCF	ADCON0,5
;IF ADReadPort.0 On Then Set CHS0 On
	BTFSC	ADREADPORT,0
;IF ADReadPort.0 On Then Set CHS0 On
	BSF	ADCON0,2
;IF ADReadPort.0 On Then Set CHS0 On
;IF ADReadPort.1 On Then Set CHS1 On
	BTFSC	ADREADPORT,1
;IF ADReadPort.1 On Then Set CHS1 On
	BSF	ADCON0,3
;IF ADReadPort.1 On Then Set CHS1 On
;IF ADReadPort.2 On Then Set CHS2 On
	BTFSC	ADREADPORT,2
;IF ADReadPort.2 On Then Set CHS2 On
	BSF	ADCON0,4
;IF ADReadPort.2 On Then Set CHS2 On
;If ADReadPort.3 On Then Set CHS3 On
	BTFSC	ADREADPORT,3
;If ADReadPort.3 On Then Set CHS3 On
	BSF	ADCON0,5
;If ADReadPort.3 On Then Set CHS3 On
;Enable AD Operations
;SET ADON ON
	BSF	ADCON0,0
;Acquisition Delay
;Wait AD_Delay
	MOVLW	2
	MOVWF	SYSWAITTEMP10US
	CALL	DELAY_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	BSF	ADCON0,1
;nop
	NOP
;Wait While GO_NOT_DONE ON
GLOBAL	SYSWAITLOOP1
SYSWAITLOOP1:
	BTFSC	ADCON0,1
	GOTO	SYSWAITLOOP1
;Switch off A/D
;SET ADCON0.ADON OFF
	BCF	ADCON0,0
;ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA
;ANSELC = 0
	CLRF	ANSELC
;ReadAD = ADRESH
	BANKSEL	ADRESH
	MOVF	ADRESH,W
	MOVWF	READAD
;SET ADFM OFF
	BCF	ADCON0,7
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:WORD:WORD:WORD:WORD:INTEGER:, SOURCE: STDBASIC.H (264)
GLOBAL	FN_SCALE73
FN_SCALE73:
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
;USING TEMP VAR METHOD IMPLEMENTED AT #1094. USE A CONSTANT DISABLE1094 TO DISABLE
	MOVF	L_FROMLOW,W
	SUBWF	L_MAP,W
	MOVWF	SYSTEMP1
	MOVF	L_MAP_H,W
	MOVWF	SYSTEMP1_H
	MOVF	L_FROMLOW_H,W
	BTFSS	STATUS,0
	INCFSZ	L_FROMLOW_H,W
	SUBWF	SYSTEMP1_H,F
	MOVF	L_TOLOW,W
	SUBWF	L_TOHIGH,W
	MOVWF	SYSTEMP2
	MOVF	L_TOHIGH_H,W
	MOVWF	SYSTEMP2_H
	MOVF	L_TOLOW_H,W
	BTFSS	STATUS,0
	INCFSZ	L_TOLOW_H,W
	SUBWF	SYSTEMP2_H,F
	MOVF	SYSTEMP1,W
	MOVWF	SYSLONGTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	MOVF	SYSTEMP2,W
	MOVWF	SYSLONGTEMPB
	MOVF	SYSTEMP2_H,W
	MOVWF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	CALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	L_SYSCALCF
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	L_SYSCALCF_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	L_SYSCALCF_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
;USING TEMP VAR METHOD IMPLEMENTED AT #1094. USE A CONSTANT DISABLE1094 TO DISABLE
	MOVF	L_FROMLOW,W
	SUBWF	L_FROMHIGH,W
	MOVWF	L_SYSCALC
	MOVF	L_FROMHIGH_H,W
	MOVWF	L_SYSCALC_H
	MOVF	L_FROMLOW_H,W
	BTFSS	STATUS,0
	INCFSZ	L_FROMLOW_H,W
	SUBWF	L_SYSCALC_H,F
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
;USING TEMP VAR METHOD IMPLEMENTED AT #1094. USE A CONSTANT DISABLE1094 TO DISABLE
	MOVF	L_SYSCALCF,W
	MOVWF	SYSLONGTEMPA
	MOVF	L_SYSCALCF_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	L_SYSCALCF_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	L_SYSCALCF_E,W
	MOVWF	SYSLONGTEMPA_E
	MOVF	L_SYSCALC,W
	MOVWF	SYSLONGTEMPB
	MOVF	L_SYSCALC_H,W
	MOVWF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	CALL	SYSDIVSUB32
	MOVF	SYSLONGTEMPA,W
	MOVWF	SYSTEMP1
	MOVF	SYSLONGTEMPA_H,W
	MOVWF	SYSTEMP1_H
	MOVF	SYSLONGTEMPA_U,W
	MOVWF	SYSTEMP1_U
	MOVF	SYSLONGTEMPA_E,W
	MOVWF	SYSTEMP1_E
	MOVF	L_TOLOW,W
	ADDWF	SYSTEMP1,W
	MOVWF	SYSTEMP2
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSTEMP2_H
	MOVF	L_TOLOW_H,W
	BTFSC	STATUS,0
	INCFSZ	L_TOLOW_H,W
	ADDWF	SYSTEMP2_H,F
	MOVF	L_CALIBRATE,W
	ADDWF	SYSTEMP2,W
	MOVWF	SCALE
	MOVF	SYSTEMP2_H,W
	MOVWF	SCALE_H
	MOVF	L_CALIBRATE_H,W
	BTFSC	STATUS,0
	INCFSZ	L_CALIBRATE_H,W
	ADDWF	SCALE_H,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3158)
GLOBAL	SYSCOMPEQUAL32
SYSCOMPEQUAL32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test low, exit if false
;movf SysLongTempA, W
	MOVF	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	SUBWF	SYSLONGTEMPB, W
;btfss STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test high, exit if false
;movf SysLongTempA_H, W
	MOVF	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	SUBWF	SYSLONGTEMPB_H, W
;btfss STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test upper, exit if false
;movf SysLongTempA_U, W
	MOVF	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	SUBWF	SYSLONGTEMPB_U, W
;btfss STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test exp, exit if false
;movf SysLongTempA_E, W
	MOVF	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	SUBWF	SYSLONGTEMPB_E, W
;btfss STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3471)
GLOBAL	SYSCOMPLESSTHAN32
SYSCOMPLESSTHAN32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test Exp, exit if more
;movf SysLongTempA_E,W
	MOVF	SYSLONGTEMPA_E,W
;subwf SysLongTempB_E,W
	SUBWF	SYSLONGTEMPB_E,W
;btfss STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
	BTFSS	STATUS,2
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	MOVF	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	SUBWF	SYSLONGTEMPB_U,W
;btfss STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
	BTFSS	STATUS,2
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	MOVF	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	SUBWF	SYSLONGTEMPB_H,W
;btfss STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
	BTFSS	STATUS,2
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	MOVF	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	SUBWF	SYSLONGTEMPA,W
;btfsc STATUS,C
	BTFSC	STATUS,0
;return
	RETURN
GLOBAL	SCLT32TRUE
SCLT32TRUE:
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2937)
GLOBAL	SYSDIVSUB32
SYSDIVSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	MOVF	SYSLONGTEMPA,W
	MOVWF	SYSLONGDIVMULTA
	MOVF	SYSLONGTEMPA_H,W
	MOVWF	SYSLONGDIVMULTA_H
	MOVF	SYSLONGTEMPA_U,W
	MOVWF	SYSLONGDIVMULTA_U
	MOVF	SYSLONGTEMPA_E,W
	MOVWF	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	MOVF	SYSLONGTEMPB,W
	MOVWF	SYSLONGDIVMULTB
	MOVF	SYSLONGTEMPB_H,W
	MOVWF	SYSLONGDIVMULTB_H
	MOVF	SYSLONGTEMPB_U,W
	MOVWF	SYSLONGDIVMULTB_U
	MOVF	SYSLONGTEMPB_E,W
	MOVWF	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	CLRF	SYSLONGDIVMULTX
	CLRF	SYSLONGDIVMULTX_H
	CLRF	SYSLONGDIVMULTX_U
	CLRF	SYSLONGDIVMULTX_E
;Avoid division by zero
;if SysLongDivMultB = 0 then
	MOVF	SYSLONGDIVMULTB,W
	MOVWF	SYSLONGTEMPA
	MOVF	SYSLONGDIVMULTB_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	SYSLONGDIVMULTB_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	SYSLONGDIVMULTB_E,W
	MOVWF	SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB
	CLRF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	CALL	SYSCOMPEQUAL32
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF22
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA
	CLRF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
;exit sub
	RETURN
;end if
GLOBAL	ENDIF22
ENDIF22:
;Main calc routine
;SysDivLoop = 32
	MOVLW	32
	MOVWF	SYSDIVLOOP
GLOBAL	SYSDIV32START
SYSDIV32START:
;set C off
	BCF	STATUS,0
;Rotate SysLongDivMultA Left
	RLF	SYSLONGDIVMULTA,F
	RLF	SYSLONGDIVMULTA_H,F
	RLF	SYSLONGDIVMULTA_U,F
	RLF	SYSLONGDIVMULTA_E,F
;Rotate SysLongDivMultX Left
	RLF	SYSLONGDIVMULTX,F
	RLF	SYSLONGDIVMULTX_H,F
	RLF	SYSLONGDIVMULTX_U,F
	RLF	SYSLONGDIVMULTX_E,F
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
;USING TEMP VAR METHOD IMPLEMENTED AT #1094. USE A CONSTANT DISABLE1094 TO DISABLE
	MOVF	SYSLONGDIVMULTB,W
	SUBWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTB_H,W
	BTFSS	STATUS,0
	INCFSZ	SYSLONGDIVMULTB_H,W
	SUBWF	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTB_U,W
	BTFSS	STATUS,0
	INCFSZ	SYSLONGDIVMULTB_U,W
	SUBWF	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTB_E,W
	BTFSS	STATUS,0
	INCFSZ	SYSLONGDIVMULTB_E,W
	SUBWF	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	BSF	SYSLONGDIVMULTA,0
;If C Off Then
	BTFSC	STATUS,0
	GOTO	ENDIF23
;Set SysLongDivMultA.0 Off
	BCF	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
;USING TEMP VAR METHOD IMPLEMENTED AT #1094. USE A CONSTANT DISABLE1094 TO DISABLE
	MOVF	SYSLONGDIVMULTB,W
	ADDWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTB_H,W
	BTFSC	STATUS,0
	INCFSZ	SYSLONGDIVMULTB_H,W
	ADDWF	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTB_U,W
	BTFSC	STATUS,0
	INCFSZ	SYSLONGDIVMULTB_U,W
	ADDWF	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTB_E,W
	BTFSC	STATUS,0
	INCFSZ	SYSLONGDIVMULTB_E,W
	ADDWF	SYSLONGDIVMULTX_E,F
;End If
GLOBAL	ENDIF23
ENDIF23:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv32Start
	GOTO	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	MOVF	SYSLONGDIVMULTA,W
	MOVWF	SYSLONGTEMPA
	MOVF	SYSLONGDIVMULTA_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	SYSLONGDIVMULTA_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	SYSLONGDIVMULTA_E,W
	MOVWF	SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	MOVF	SYSLONGDIVMULTX,W
	MOVWF	SYSLONGTEMPX
	MOVF	SYSLONGDIVMULTX_H,W
	MOVWF	SYSLONGTEMPX_H
	MOVF	SYSLONGDIVMULTX_U,W
	MOVWF	SYSLONGTEMPX_U
	MOVF	SYSLONGDIVMULTX_E,W
	MOVWF	SYSLONGTEMPX_E
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2682)
GLOBAL	SYSMULTSUB32
SYSMULTSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;Can't use normal SysDivMult variables for 32 bit, they overlap with
;SysLongTemp variables
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	MOVF	SYSLONGTEMPA,W
	MOVWF	SYSLONGDIVMULTA
	MOVF	SYSLONGTEMPA_H,W
	MOVWF	SYSLONGDIVMULTA_H
	MOVF	SYSLONGTEMPA_U,W
	MOVWF	SYSLONGDIVMULTA_U
	MOVF	SYSLONGTEMPA_E,W
	MOVWF	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	MOVF	SYSLONGTEMPB,W
	MOVWF	SYSLONGDIVMULTB
	MOVF	SYSLONGTEMPB_H,W
	MOVWF	SYSLONGDIVMULTB_H
	MOVF	SYSLONGTEMPB_U,W
	MOVWF	SYSLONGDIVMULTB_U
	MOVF	SYSLONGTEMPB_E,W
	MOVWF	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	CLRF	SYSLONGDIVMULTX
	CLRF	SYSLONGDIVMULTX_H
	CLRF	SYSLONGDIVMULTX_U
	CLRF	SYSLONGDIVMULTX_E
GLOBAL	MUL32LOOP
MUL32LOOP:
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	BTFSS	SYSLONGDIVMULTB,0
	GOTO	ENDIF17
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
;USING TEMP VAR METHOD IMPLEMENTED AT #1094. USE A CONSTANT DISABLE1094 TO DISABLE
	MOVF	SYSLONGDIVMULTA,W
	ADDWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTA_H,W
	BTFSC	STATUS,0
	INCFSZ	SYSLONGDIVMULTA_H,W
	ADDWF	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTA_U,W
	BTFSC	STATUS,0
	INCFSZ	SYSLONGDIVMULTA_U,W
	ADDWF	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTA_E,W
	BTFSC	STATUS,0
	INCFSZ	SYSLONGDIVMULTA_E,W
	ADDWF	SYSLONGDIVMULTX_E,F
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
GLOBAL	ENDIF17
ENDIF17:
;set STATUS.C OFF
	BCF	STATUS,0
;rotate SysLongDivMultB right
	RRF	SYSLONGDIVMULTB_E,F
	RRF	SYSLONGDIVMULTB_U,F
	RRF	SYSLONGDIVMULTB_H,F
	RRF	SYSLONGDIVMULTB,F
;set STATUS.C off
	BCF	STATUS,0
;rotate SysLongDivMultA left
	RLF	SYSLONGDIVMULTA,F
	RLF	SYSLONGDIVMULTA_H,F
	RLF	SYSLONGDIVMULTA_U,F
	RLF	SYSLONGDIVMULTA_E,F
;if SysLongDivMultB > 0 then goto MUL32LOOP
	MOVF	SYSLONGDIVMULTB,W
	MOVWF	SYSLONGTEMPB
	MOVF	SYSLONGDIVMULTB_H,W
	MOVWF	SYSLONGTEMPB_H
	MOVF	SYSLONGDIVMULTB_U,W
	MOVWF	SYSLONGTEMPB_U
	MOVF	SYSLONGDIVMULTB_E,W
	MOVWF	SYSLONGTEMPB_E
	CLRF	SYSLONGTEMPA
	CLRF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	CALL	SYSCOMPLESSTHAN32
	BTFSC	SYSBYTETEMPX,0
;if SysLongDivMultB > 0 then goto MUL32LOOP
	GOTO	MUL32LOOP
;if SysLongDivMultB > 0 then goto MUL32LOOP
;SysLongTempX = SysLongDivMultX
	MOVF	SYSLONGDIVMULTX,W
	MOVWF	SYSLONGTEMPX
	MOVF	SYSLONGDIVMULTX_H,W
	MOVWF	SYSLONGTEMPX_H
	MOVF	SYSLONGDIVMULTX_U,W
	MOVWF	SYSLONGTEMPX_U
	MOVF	SYSLONGDIVMULTX_E,W
	MOVWF	SYSLONGTEMPX_E
	RETURN

;********************************************************************************

;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
