;Program compiled by Great Cow BASIC (1.00.00 2022-12-01 (Windows 32 bit) : Build 1199) for Microchip MPASM/MPLAB-X Assembler
;Need help? 
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   w_cholmondeley at users dot sourceforge dot net
;   evanvennn at users dot sourceforge dot net

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F18855, r=DEC
#include <P16F18855.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _RSTOSC_HFINT32 & _FEXTOSC_OFF
 __CONFIG _CONFIG2, _MCLRE_OFF
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF & _WRT_OFF
 __CONFIG _CONFIG5, _CPD_OFF & _CP_OFF

;********************************************************************************

;Set aside memory locations for variables
ADREADPORT                       EQU      32          ; 0x20
CHECK_SWITCH                     EQU      33          ; 0x21
DELAYTEMP                        EQU     112          ; 0x70
DELAYTEMP2                       EQU     113          ; 0x71
DIRECTION                        EQU      34          ; 0x22
LEDS                             EQU      35          ; 0x23
L_CALIBRATE                      EQU      36          ; 0x24
L_CALIBRATE_H                    EQU      37          ; 0x25
L_FROMHIGH                       EQU      38          ; 0x26
L_FROMHIGH_H                     EQU      39          ; 0x27
L_FROMLOW                        EQU      40          ; 0x28
L_FROMLOW_H                      EQU      41          ; 0x29
L_MAP                            EQU      42          ; 0x2A
L_MAP_H                          EQU      43          ; 0x2B
L_SYSCALC                        EQU      44          ; 0x2C
L_SYSCALCF                       EQU      46          ; 0x2E
L_SYSCALCF_E                     EQU      49          ; 0x31
L_SYSCALCF_H                     EQU      47          ; 0x2F
L_SYSCALCF_U                     EQU      48          ; 0x30
L_SYSCALC_H                      EQU      45          ; 0x2D
L_TOHIGH                         EQU      50          ; 0x32
L_TOHIGH_H                       EQU      51          ; 0x33
L_TOLOW                          EQU      52          ; 0x34
L_TOLOW_H                        EQU      53          ; 0x35
MYDELAY                          EQU      54          ; 0x36
READAD10                         EQU      55          ; 0x37
READAD10_H                       EQU      56          ; 0x38
SCALE                            EQU      57          ; 0x39
SCALE_H                          EQU      58          ; 0x3A
SYSBITVAR0                       EQU      59          ; 0x3B
SYSBYTETEMPX                     EQU     112          ; 0x70
SYSDIVLOOP                       EQU     116          ; 0x74
SYSLONGDIVMULTA                  EQU      60          ; 0x3C
SYSLONGDIVMULTA_E                EQU      63          ; 0x3F
SYSLONGDIVMULTA_H                EQU      61          ; 0x3D
SYSLONGDIVMULTA_U                EQU      62          ; 0x3E
SYSLONGDIVMULTB                  EQU      64          ; 0x40
SYSLONGDIVMULTB_E                EQU      67          ; 0x43
SYSLONGDIVMULTB_H                EQU      65          ; 0x41
SYSLONGDIVMULTB_U                EQU      66          ; 0x42
SYSLONGDIVMULTX                  EQU      68          ; 0x44
SYSLONGDIVMULTX_E                EQU      71          ; 0x47
SYSLONGDIVMULTX_H                EQU      69          ; 0x45
SYSLONGDIVMULTX_U                EQU      70          ; 0x46
SYSLONGTEMPA                     EQU     117          ; 0x75
SYSLONGTEMPA_E                   EQU     120          ; 0x78
SYSLONGTEMPA_H                   EQU     118          ; 0x76
SYSLONGTEMPA_U                   EQU     119          ; 0x77
SYSLONGTEMPB                     EQU     121          ; 0x79
SYSLONGTEMPB_E                   EQU     124          ; 0x7C
SYSLONGTEMPB_H                   EQU     122          ; 0x7A
SYSLONGTEMPB_U                   EQU     123          ; 0x7B
SYSLONGTEMPX                     EQU     112          ; 0x70
SYSLONGTEMPX_E                   EQU     115          ; 0x73
SYSLONGTEMPX_H                   EQU     113          ; 0x71
SYSLONGTEMPX_U                   EQU     114          ; 0x72
SYSTEMP1                         EQU      72          ; 0x48
SYSTEMP1_E                       EQU      75          ; 0x4B
SYSTEMP1_H                       EQU      73          ; 0x49
SYSTEMP1_U                       EQU      74          ; 0x4A
SYSTEMP2                         EQU      76          ; 0x4C
SYSTEMP2_H                       EQU      77          ; 0x4D
SYSTEMP3                         EQU      78          ; 0x4E
SYSWAITTEMP10US                  EQU     117          ; 0x75
SYSWAITTEMPMS                    EQU     114          ; 0x72
SYSWAITTEMPMS_H                  EQU     115          ; 0x73

;********************************************************************************

;Alias variables
SYSREADAD10WORD EQU 55
SYSREADAD10WORD_H EQU 56
SYSSCALEWORD EQU 57
SYSSCALEWORD_H EQU 58

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	5
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
;Automatic pin direction setting
	clrf	TRISB

;Start of the main program
;''
;''  This demonstration produces a variable speed rotating LED display that is proportional to the ADC value.
;''  The ADC value and LED rotate speed are inversely proportional to each other.
;''
;''  Rotate the POT counterclockwise to see the LEDs shift faster.
;''
;''  Press the SWITCHIN to reverse the direction of the LEDs.
;''
;''  The four LSbs of the ADC are mirrored onto the LEDs. Rotate the potentiometer
;''  to change the display.
;''
;''
;''  PIC: 16F18855
;''  Compiler: GCB
;''  IDE: GC Studio
;''
;''  Board: PICKit 28-Pin Demo Board
;''  Date: 1.12.2022
;''
;----- Configuration
;Dim DIRECTION As Byte
;Dim mydelay, leds  As Byte
;start from the right to left
;direction = LED_RIGHT
	movlw	255
	movwf	DIRECTION
;Dir porta Out
	clrf	TRISA
;leds = 8
	movlw	8
	movwf	LEDS
;Potentitor is connected to RA4...set as input
;Dir PORTA.0 In
	bsf	TRISA,0
;Do
SysDoLoop_S1
;mydelay = ReadAD10( AN0 )
	clrf	ADREADPORT
	call	FN_READAD107
	movf	SYSREADAD10WORD,W
	movwf	MYDELAY
;Factor the ADC reading to delay steps
;mydelay = Scale ( mydelay, 0, 1023, 100, 1000 )
	movwf	L_MAP
	clrf	L_MAP_H
	clrf	L_FROMLOW
	clrf	L_FROMLOW_H
	movlw	255
	movwf	L_FROMHIGH
	movlw	3
	movwf	L_FROMHIGH_H
	movlw	100
	movwf	L_TOLOW
	clrf	L_TOLOW_H
	movlw	232
	movwf	L_TOHIGH
	movlw	3
	movwf	L_TOHIGH_H
	clrf	L_CALIBRATE
	clrf	L_CALIBRATE_H
	call	FN_SCALE73
	movf	SYSSCALEWORD,W
	movwf	MYDELAY
;Wait mydelay ms
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;If check_SWITCH = TRUE Then
	call	FN_CHECK_SWITCH
	incf	CHECK_SWITCH,W
	btfsc	STATUS, Z
;toggle the direction
;direction = !direction
	comf	DIRECTION,F
;End If
;PORTB = leds
	movf	LEDS,W
	movwf	PORTB
;If  direction = LED_RIGHT  Then
	incf	DIRECTION,W
	btfss	STATUS, Z
	goto	ELSE2_1
;shift to the right by 1
;Rotate leds Right Simple
	rrf	LEDS,W
	rrf	LEDS,F
;when the ROTATE moves the bit to bit 7, restart the pattern
;If leds = 128 Then
	movlw	128
	subwf	LEDS,W
	btfss	STATUS, Z
	goto	ENDIF3
;leds = 8
	movlw	8
	movwf	LEDS
;End If
ENDIF3
;Else
	goto	ENDIF2
ELSE2_1
;Set C off to ensure the carry bit does not impact
;Set C Off
	bcf	STATUS,C
;Rotate leds Left
	rlf	LEDS,F
;when the last LED is lit, restart the pattern
;If  leds = 16 Then
	movlw	16
	subwf	LEDS,W
	btfss	STATUS, Z
	goto	ENDIF4
;leds = 1
	movlw	1
	movwf	LEDS
;End If
ENDIF4
;End If
ENDIF2
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;global variable - if button is held down, we don't want to keep on switching directions
;Dim previous_state As BIT
;previous_state = SWITCH_UP
	bsf	SYSBITVAR0,0
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Source: 080_reversible_leds_with_variable_delay.gcb (91)
FN_CHECK_SWITCH
;SWITCHIN is normally open to 5V ...when pressed, RA3 is connected to GND
;If (SWITCHIN = SWITCH_DOWN) Then
	btfsc	PORTE,3
	goto	ELSE5_1
;debounce by delaying and checking if SWITCHIN is still pressed
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;If ( (previous_state =  SWITCH_DOWN) & (SWITCHIN = SWITCH_DOWN) ) Then
	clrf	SysByteTempX
	btfss	SYSBITVAR0,0
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	clrf	SysByteTempX
	btfss	PORTE,3
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp2
	movf	SysTemp1,W
	andwf	SysTemp2,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ELSE6_1
;don't toggle
;check_switch = FALSE
	clrf	CHECK_SWITCH
;Exit Function
	return
;Else
	goto	ENDIF6
ELSE6_1
;check if still down
;If (SWITCHIN = SWITCH_DOWN) Then
	btfsc	PORTE,3
	goto	ELSE7_1
;previous_state = SWITCH_DOWN
	bcf	SYSBITVAR0,0
;reverse the LEDs
;check_switch = TRUE
	movlw	255
	movwf	CHECK_SWITCH
;Exit Function
	return
;Else
	goto	ENDIF7
ELSE7_1
;SWITCHIN not properly held down
;previous_state = SWITCH_UP
	bsf	SYSBITVAR0,0
;don't reverse
;check_switch = FALSE
	clrf	CHECK_SWITCH
;Exit Function
	return
;End If
ENDIF7
;End If
ENDIF6
;Else
	goto	ENDIF5
ELSE5_1
;SWITCHIN not pressed
;previous_state = SWITCH_UP
	bsf	SYSBITVAR0,0
;don't reverse
;check_switch = FALSE
	clrf	CHECK_SWITCH
;Exit Function
	return
;End If
ENDIF5
	return

;********************************************************************************

Delay_10US
D10US_START
	movlw	25
	movwf	DELAYTEMP
DelayUS0
	decfsz	DELAYTEMP,F
	goto	DelayUS0
	nop
	decfsz	SysWaitTemp10US, F
	goto	D10US_START
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	14
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	189
	movwf	DELAYTEMP
DMS_INNER
	decfsz	DELAYTEMP, F
	goto	DMS_INNER
	decfsz	DELAYTEMP2, F
	goto	DMS_OUTER
	decfsz	SysWaitTempMS, F
	goto	DMS_START
	decfsz	SysWaitTempMS_H, F
	goto	DMS_START
	return

;********************************************************************************

;Source: system.h (159)
INITSYS
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug Default settings for microcontrollers with _OSCCON1_
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
;asm showdebug The MCU is a chip family ChipFamily
;asm showdebug OSCCON type is 102
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F188xx MCU family - the default case
;OSCFRQ = 0b00000110
	movlw	6
	movwf	OSCFRQ
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFRM0
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
;C2ON = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
;C1ON = 0
	bcf	CM1CON0,C1ON
;
;'Turn off all ports
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

;Overloaded signature: BYTE:, Source: a-d.h (2388)
FN_READAD107
;Always RIGHT justified
;SET ADFM ON
	banksel	ADCON0
	bsf	ADCON0,ADFRM0
;ADPCH = ADReadPort
	banksel	ADREADPORT
	movf	ADREADPORT,W
	banksel	ADPCH
	movwf	ADPCH
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (577)
;Configure ANSELA/B/C/D @DebugADC_H
;Select Case ADReadPort
;Case 0: Set ANSELA.0 On
SysSelect1Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect1Case2
;Case 0: Set ANSELA.0 On
	banksel	ANSELA
	bsf	ANSELA,0
;Case 1: Set ANSELA.1 On
	goto	SysSelectEnd1
SysSelect1Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;Case 1: Set ANSELA.1 On
	banksel	ANSELA
	bsf	ANSELA,1
;Case 2: Set ANSELA.2 On
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;Case 2: Set ANSELA.2 On
	banksel	ANSELA
	bsf	ANSELA,2
;Case 3: Set ANSELA.3 On
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
;Case 3: Set ANSELA.3 On
	banksel	ANSELA
	bsf	ANSELA,3
;Case 4: Set ANSELA.4 ON
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
;Case 4: Set ANSELA.4 ON
	banksel	ANSELA
	bsf	ANSELA,4
;Case 5: Set ANSELA.5 On
	goto	SysSelectEnd1
SysSelect1Case6
	movlw	5
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case7
;Case 5: Set ANSELA.5 On
	banksel	ANSELA
	bsf	ANSELA,5
;Case 6: Set ANSELA.6 On
	goto	SysSelectEnd1
SysSelect1Case7
	movlw	6
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case8
;Case 6: Set ANSELA.6 On
	banksel	ANSELA
	bsf	ANSELA,6
;Case 7: Set ANSELA.7 On
	goto	SysSelectEnd1
SysSelect1Case8
	movlw	7
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case9
;Case 7: Set ANSELA.7 On
	banksel	ANSELA
	bsf	ANSELA,7
;Case 8: Set ANSELB.0 On
	goto	SysSelectEnd1
SysSelect1Case9
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case10
;Case 8: Set ANSELB.0 On
	banksel	ANSELB
	bsf	ANSELB,0
;Case 9: Set ANSELB.1 On
	goto	SysSelectEnd1
SysSelect1Case10
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case11
;Case 9: Set ANSELB.1 On
	banksel	ANSELB
	bsf	ANSELB,1
;Case 10: Set ANSELB.2 On
	goto	SysSelectEnd1
SysSelect1Case11
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case12
;Case 10: Set ANSELB.2 On
	banksel	ANSELB
	bsf	ANSELB,2
;Case 11: Set ANSELB.3 On
	goto	SysSelectEnd1
SysSelect1Case12
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case13
;Case 11: Set ANSELB.3 On
	banksel	ANSELB
	bsf	ANSELB,3
;Case 12: Set ANSELB.4 On
	goto	SysSelectEnd1
SysSelect1Case13
	movlw	12
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case14
;Case 12: Set ANSELB.4 On
	banksel	ANSELB
	bsf	ANSELB,4
;Case 13: Set ANSELB.5 On
	goto	SysSelectEnd1
SysSelect1Case14
	movlw	13
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case15
;Case 13: Set ANSELB.5 On
	banksel	ANSELB
	bsf	ANSELB,5
;Case 14: Set ANSELB.6 On
	goto	SysSelectEnd1
SysSelect1Case15
	movlw	14
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case16
;Case 14: Set ANSELB.6 On
	banksel	ANSELB
	bsf	ANSELB,6
;Case 15: Set ANSELB.7 On
	goto	SysSelectEnd1
SysSelect1Case16
	movlw	15
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case17
;Case 15: Set ANSELB.7 On
	banksel	ANSELB
	bsf	ANSELB,7
;Case 16: Set ANSELC.0 On
	goto	SysSelectEnd1
SysSelect1Case17
	movlw	16
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case18
;Case 16: Set ANSELC.0 On
	banksel	ANSELC
	bsf	ANSELC,0
;Case 17: Set ANSELC.1 On
	goto	SysSelectEnd1
SysSelect1Case18
	movlw	17
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case19
;Case 17: Set ANSELC.1 On
	banksel	ANSELC
	bsf	ANSELC,1
;Case 18: Set ANSELC.2 On
	goto	SysSelectEnd1
SysSelect1Case19
	movlw	18
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case20
;Case 18: Set ANSELC.2 On
	banksel	ANSELC
	bsf	ANSELC,2
;Case 19: Set ANSELC.3 On
	goto	SysSelectEnd1
SysSelect1Case20
	movlw	19
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case21
;Case 19: Set ANSELC.3 On
	banksel	ANSELC
	bsf	ANSELC,3
;Case 20: Set ANSELC.4 On
	goto	SysSelectEnd1
SysSelect1Case21
	movlw	20
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case22
;Case 20: Set ANSELC.4 On
	banksel	ANSELC
	bsf	ANSELC,4
;Case 21: Set ANSELC.5 On
	goto	SysSelectEnd1
SysSelect1Case22
	movlw	21
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case23
;Case 21: Set ANSELC.5 On
	banksel	ANSELC
	bsf	ANSELC,5
;Case 22: Set ANSELC.6 On
	goto	SysSelectEnd1
SysSelect1Case23
	movlw	22
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case24
;Case 22: Set ANSELC.6 On
	banksel	ANSELC
	bsf	ANSELC,6
;Case 23: Set ANSELC.7 On
	goto	SysSelectEnd1
SysSelect1Case24
	movlw	23
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;Case 23: Set ANSELC.7 On
	banksel	ANSELC
	bsf	ANSELC,7
;End Select  '*** ANSEL Bits should now be set ***
SysSelectEnd1
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
	banksel	ADCON0
	bcf	ADCON0,ADCS
;ADCLK = 1 ' default to FOSC/2
	movlw	1
	movwf	ADCLK
;Conversion Clock Speed
;SET ADCS OFF  'ADCON0.4
	bcf	ADCON0,ADCS
;ADCLK = 15    'FOSC/16
	movlw	15
	movwf	ADCLK
;Result formatting
;if ADLeftadjust = 0 then
;Set ADCON0.2 ON
;Set ADFM ON
	bsf	ADCON0,ADFRM0
;Set ADFM0 ON
	bsf	ADCON0,ADFM0
;Else
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	banksel	ADREADPORT
	movf	ADREADPORT,W
	banksel	ADPCH
	movwf	ADPCH
;Enable AD Operations
;SET ADON ON
	bsf	ADCON0,ADON
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	call	Delay_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop1
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop1
;Switch off A/D
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;Write output
;ReadAD10 = ADRESL
	banksel	ADRESL
	movf	ADRESL,W
	banksel	READAD10
	movwf	READAD10
	clrf	READAD10_H
;ReadAD10_H = ADRESH
	banksel	ADRESH
	movf	ADRESH,W
	banksel	READAD10_H
	movwf	READAD10_H
;Put A/D format back to normal
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFRM0
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:integer:, Source: stdbasic.h (264)
FN_SCALE73
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	movf	L_FROMLOW,W
	subwf	L_MAP,W
	movwf	SysTemp1
	movf	L_FROMLOW_H,W
	subwfb	L_MAP_H,W
	movwf	SysTemp1_H
	movf	L_TOLOW,W
	subwf	L_TOHIGH,W
	movwf	SysTemp2
	movf	L_TOLOW_H,W
	subwfb	L_TOHIGH_H,W
	movwf	SysTemp2_H
	movf	SYSTEMP1,W
	movwf	SysLONGTempA
	movf	SYSTEMP1_H,W
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	SYSTEMP2,W
	movwf	SysLONGTempB
	movf	SYSTEMP2_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SYSMULTSUB32
	movf	SysLONGTempX,W
	movwf	L_SYSCALCF
	movf	SysLONGTempX_H,W
	movwf	L_SYSCALCF_H
	movf	SysLONGTempX_U,W
	movwf	L_SYSCALCF_U
	movf	SysLONGTempX_E,W
	movwf	L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	movf	L_FROMLOW,W
	subwf	L_FROMHIGH,W
	movwf	L_SYSCALC
	movf	L_FROMLOW_H,W
	subwfb	L_FROMHIGH_H,W
	movwf	L_SYSCALC_H
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
	movf	L_SYSCALCF,W
	movwf	SysLONGTempA
	movf	L_SYSCALCF_H,W
	movwf	SysLONGTempA_H
	movf	L_SYSCALCF_U,W
	movwf	SysLONGTempA_U
	movf	L_SYSCALCF_E,W
	movwf	SysLONGTempA_E
	movf	L_SYSCALC,W
	movwf	SysLONGTempB
	movf	L_SYSCALC_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SYSDIVSUB32
	movf	SysLONGTempA,W
	movwf	SysTemp1
	movf	SysLONGTempA_H,W
	movwf	SysTemp1_H
	movf	SysLONGTempA_U,W
	movwf	SysTemp1_U
	movf	SysLONGTempA_E,W
	movwf	SysTemp1_E
	movf	L_TOLOW,W
	addwf	SysTemp1,W
	movwf	SysTemp2
	movf	L_TOLOW_H,W
	addwfc	SysTemp1_H,W
	movwf	SysTemp2_H
	movf	L_CALIBRATE,W
	addwf	SysTemp2,W
	movwf	SCALE
	movf	L_CALIBRATE_H,W
	addwfc	SysTemp2_H,W
	movwf	SCALE_H
	return

;********************************************************************************

;Source: system.h (3158)
SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysLongTempA, W
	movf	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	subwf	SYSLONGTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysLongTempA_H, W
	movf	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	subwf	SYSLONGTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test upper, exit if false
;movf SysLongTempA_U, W
	movf	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	subwf	SYSLONGTEMPB_U, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test exp, exit if false
;movf SysLongTempA_E, W
	movf	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	subwf	SYSLONGTEMPB_E, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (3471)
SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test Exp, exit if more
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT32TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (2937)
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
	movf	SYSLONGTEMPA,W
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempA
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempA_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempA_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SYSCOMPEQUAL32
	btfss	SysByteTempX,0
	goto	ENDIF11
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF11
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP
SYSDIV32START
;set C off
	bcf	STATUS,C
;Rotate SysLongDivMultA Left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;Rotate SysLongDivMultX Left
	rlf	SYSLONGDIVMULTX,F
	rlf	SYSLONGDIVMULTX_H,F
	rlf	SYSLONGDIVMULTX_U,F
	rlf	SYSLONGDIVMULTX_E,F
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	subwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	subwfb	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	subwfb	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	subwfb	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF12
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	addwfc	SYSLONGDIVMULTX_E,F
;End If
ENDIF12
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv32Start
	goto	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movf	SYSLONGDIVMULTA,W
	movwf	SYSLONGTEMPA
	movf	SYSLONGDIVMULTA_H,W
	movwf	SYSLONGTEMPA_H
	movf	SYSLONGDIVMULTA_U,W
	movwf	SYSLONGTEMPA_U
	movf	SYSLONGDIVMULTA_E,W
	movwf	SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	return

;********************************************************************************

;Source: system.h (2682)
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
	movf	SYSLONGTEMPA,W
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	btfss	SYSLONGDIVMULTB,0
	goto	ENDIF9
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	movf	SYSLONGDIVMULTA,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTA_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTA_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTA_E,W
	addwfc	SYSLONGDIVMULTX_E,F
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
ENDIF9
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysLongDivMultB right
	rrf	SYSLONGDIVMULTB_E,F
	rrf	SYSLONGDIVMULTB_U,F
	rrf	SYSLONGDIVMULTB_H,F
	rrf	SYSLONGDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysLongDivMultA left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempB
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempB_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempB_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempB_E
	clrf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	call	SYSCOMPLESSTHAN32
	btfsc	SysByteTempX,0
;if SysLongDivMultB > 0 then goto MUL32LOOP
	goto	MUL32LOOP
;if SysLongDivMultB > 0 then goto MUL32LOOP
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144

 END
