;Program compiled by GCBASIC (1.00.00 2023-05-14 (Windows 64 bit) : Build 1247) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2023-05-15 CRC29
;Need help? 
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   w_cholmondeley at users dot sourceforge dot net
;   evanvennn at users dot sourceforge dot net

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1619, r=DEC
#include <P16F1619.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _CP_OFF & _MCLRE_ON & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF & _WRT_OFF
 __CONFIG _CONFIG3, _WDTE_OFF

;********************************************************************************

;Set aside memory locations for variables
ADCVALUEWORD                     EQU      32          ; 0x20
ADCVALUEWORD_H                   EQU      33          ; 0x21
ADREADPORT                       EQU      34          ; 0x22
CCPCONCACHE                      EQU      35          ; 0x23
DELAYTEMP                        EQU     112          ; 0x70
DELAYTEMP2                       EQU     113          ; 0x71
PRX_TEMP                         EQU      36          ; 0x24
PRX_TEMP_CACHE                   EQU      40          ; 0x28
PRX_TEMP_CACHE_E                 EQU      43          ; 0x2B
PRX_TEMP_CACHE_H                 EQU      41          ; 0x29
PRX_TEMP_CACHE_U                 EQU      42          ; 0x2A
PRX_TEMP_E                       EQU      39          ; 0x27
PRX_TEMP_H                       EQU      37          ; 0x25
PRX_TEMP_U                       EQU      38          ; 0x26
PWMCHANNEL                       EQU      44          ; 0x2C
PWMDIRECTION                     EQU      45          ; 0x2D
PWMDIRECTION_H                   EQU      46          ; 0x2E
PWMDUTY                          EQU      47          ; 0x2F
PWMDUTYVALUE                     EQU      49          ; 0x31
PWMDUTY_H                        EQU      48          ; 0x30
PWMFREQ                          EQU      50          ; 0x32
PWMFREQOLD                       EQU      52          ; 0x34
PWMFREQ_H                        EQU      51          ; 0x33
PWMRESOLUTION                    EQU      53          ; 0x35
PWMRESOLUTION_H                  EQU      54          ; 0x36
PWMSETCOUNTER                    EQU      55          ; 0x37
PWMSETCOUNTER_H                  EQU      56          ; 0x38
PWMTIMEROLD                      EQU      57          ; 0x39
READAD                           EQU      58          ; 0x3A
READAD10                         EQU      59          ; 0x3B
READAD10_H                       EQU      60          ; 0x3C
SAVEADCON0                       EQU      61          ; 0x3D
SAVEANSELC                       EQU      62          ; 0x3E
SAVELATC                         EQU      63          ; 0x3F
SAVEODCONC                       EQU      64          ; 0x40
SAVETRISC                        EQU      65          ; 0x41
SERDATA                          EQU      66          ; 0x42
SYSBYTETEMPA                     EQU     117          ; 0x75
SYSBYTETEMPB                     EQU     121          ; 0x79
SYSBYTETEMPX                     EQU     112          ; 0x70
SYSDIVLOOP                       EQU     116          ; 0x74
SYSDIVMULTA                      EQU     119          ; 0x77
SYSDIVMULTA_H                    EQU     120          ; 0x78
SYSDIVMULTB                      EQU     123          ; 0x7B
SYSDIVMULTB_H                    EQU     124          ; 0x7C
SYSDIVMULTX                      EQU     114          ; 0x72
SYSDIVMULTX_H                    EQU     115          ; 0x73
SYSLONGDIVMULTA                  EQU      67          ; 0x43
SYSLONGDIVMULTA_E                EQU      70          ; 0x46
SYSLONGDIVMULTA_H                EQU      68          ; 0x44
SYSLONGDIVMULTA_U                EQU      69          ; 0x45
SYSLONGDIVMULTB                  EQU      71          ; 0x47
SYSLONGDIVMULTB_E                EQU      74          ; 0x4A
SYSLONGDIVMULTB_H                EQU      72          ; 0x48
SYSLONGDIVMULTB_U                EQU      73          ; 0x49
SYSLONGDIVMULTX                  EQU      75          ; 0x4B
SYSLONGDIVMULTX_E                EQU      78          ; 0x4E
SYSLONGDIVMULTX_H                EQU      76          ; 0x4C
SYSLONGDIVMULTX_U                EQU      77          ; 0x4D
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
SYSREPEATTEMP1                   EQU      79          ; 0x4F
SYSTEMP1                         EQU      80          ; 0x50
SYSTEMP1_E                       EQU      83          ; 0x53
SYSTEMP1_H                       EQU      81          ; 0x51
SYSTEMP1_U                       EQU      82          ; 0x52
SYSTEMP2                         EQU      84          ; 0x54
SYSTEMP3                         EQU      85          ; 0x55
SYSWAITTEMP10US                  EQU     117          ; 0x75
SYSWAITTEMPMS                    EQU     114          ; 0x72
SYSWAITTEMPMS_H                  EQU     115          ; 0x73
SYSWAITTEMPS                     EQU     116          ; 0x74
SYSWAITTEMPUS                    EQU     117          ; 0x75
SYSWAITTEMPUS_H                  EQU     118          ; 0x76
SYSWORDTEMPA                     EQU     117          ; 0x75
SYSWORDTEMPA_H                   EQU     118          ; 0x76
SYSWORDTEMPB                     EQU     121          ; 0x79
SYSWORDTEMPB_H                   EQU     122          ; 0x7A
SYSWORDTEMPX                     EQU     112          ; 0x70
SYSWORDTEMPX_H                   EQU     113          ; 0x71
TIMERSELECTIONBITS               EQU      86          ; 0x56
TX_PR                            EQU      87          ; 0x57
_PWMTIMERSELECTED                EQU      88          ; 0x58

;********************************************************************************

;Alias variables
SYSREADAD10WORD EQU 59
SYSREADAD10WORD_H EQU 60
SYSREADADBYTE EQU 58

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
	call	INITPPS
	call	INITUSART
	call	INITPWM

;Start of the main program
;''A demonstration program for GCBASIC.
;''--------------------------------------------------------------------------------
;'' This program recreation of Microchip Curiosity firmware for the 16F1619
;''
;'' Based on cvd_touch_button_16f1619 by Trevor B Roydhouse
;''
;'' Microchip Curiosity 8/14/20 pin 8 bit demo board
;''  o PIC16F1619 (http://microchip.com/pic16f1619)
;''  o LEDs D4-D7 on RA5, RA1/PGEC, RA2, RC5
;''  o Switch SWITCH1 on RC4
;''  o Switch S2 on RA3/MCLRE
;''  o Touch Switch S3 on RC1/AN5
;''  o Potentiometer POT1 on RC0/AN4
;''
;'' An Implementation of Microchip Application Note AN1298
;'' o  Capacitive Touch Using Only an ADC using the concept of Capacitive Voltage Divider ("CVD")
;'' o  http://ww1.microchip.com/downloads/en/AppNotes/01298A.pdf
;''
;'' On startup LEDs D4-D7 turn on and off
;'' LED D6 turns on while S3 touch sensor is touched
;'' LED D6 turns off when S3 touch sensor is not touched
;'' LED D7 is the PWM signal
;'' LED D4 turns in when S1 is pressed
;''
;''@author    Evan R. Venn
;''@license   GPL
;''@version   1.00
;''@date      2023-04-02
;''********************************************************************************
;---- Configuration
;Microcontroller @ 32MHz
;MCLRE set on so that switch S2 can reset microcontroller
;Generated by PIC PPS Tool for GCBASIC
;PPS Tool version: 0.0.6.3
;PinManager data: Not available (3)
;Generated for 16f1619
;
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;Ensure all variables are explicitly defined
;---- Define hardware settings
;Dir SWITCH1 In
	banksel	TRISC
	bsf	TRISC,4
;Dir PORTA.5 Out
	bcf	TRISA,5
;Dir PORTA.1 Out
	bcf	TRISA,1
;Dir PORTA.2 Out
	bcf	TRISA,2
;Dir PORTC.5 Out
	bcf	TRISC,5
;Dir PORTC.0 In
	bsf	TRISC,0
;startup wait in seconds
;---- Variables
;Dim PWMSetCounter As Word
;PWMSetCounter = 0
	banksel	PWMSETCOUNTER
	clrf	PWMSETCOUNTER
	clrf	PWMSETCOUNTER_H
;---- Main body of program
;LED init on program startup
;Wait WAITSECS s
	movlw	1
	movwf	SysWaitTempS
	call	Delay_S
;Set LED4 = 1
	banksel	LATA
	bsf	LATA,5
;Set LED5 = 1
	bsf	LATA,1
;Set LED6 = 1
	bsf	LATA,2
;Set LED7 = 1
	bsf	LATC,5
;Wait WAITSECS s
	movlw	1
	movwf	SysWaitTempS
	banksel	STATUS
	call	Delay_S
;Set LED7 = 0
	banksel	LATC
	bcf	LATC,5
;Set LED6 = 0
	bcf	LATA,2
;Set LED5 = 0
	bcf	LATA,1
;Set LED4 = 0
	bcf	LATA,5
;Required to support HPWMUpdate when using PWM/CCPn module
;PMW Freqency and Duty to value
;Dim PWMDutyValue as Byte
;Dim PWMDirection as Integer
;PWMDirection = 1
	movlw	1
	banksel	PWMDIRECTION
	movwf	PWMDIRECTION
	clrf	PWMDIRECTION_H
;PWMDutyValue = 127
	movlw	127
	movwf	PWMDUTYVALUE
;PWM3 is an 8 bit signal
;HPWM 3, 3, PWMDutyValue, 2
	movlw	3
	movwf	PWMCHANNEL
	movlw	3
	movwf	PWMFREQ
	clrf	PWMFREQ_H
	movf	PWMDUTYVALUE,W
	movwf	PWMDUTY
	clrf	PWMDUTY_H
	movlw	2
	movwf	_PWMTIMERSELECTED
	movlw	255
	movwf	PWMRESOLUTION
	clrf	PWMRESOLUTION_H
	call	HPWM28
;Program infinite loop
;Do Forever
SysDoLoop_S1
;Set LED to state of switch
;LED4 = !SWITCH1
	clrf	SysTemp2
	btfsc	PORTC,4
	incf	SysTemp2,F
	comf	SysTemp2,F
	banksel	LATA
	bcf	LATA,5
	banksel	SYSTEMP2
	btfss	SysTemp2,0
	goto	ENDIF4
	banksel	LATA
	bsf	LATA,5
ENDIF4
;If PWMSetCounter MOD 64 = 0 Then
	banksel	PWMSETCOUNTER
	movf	PWMSETCOUNTER,W
	movwf	SysWORDTempA
	movf	PWMSETCOUNTER_H,W
	movwf	SysWORDTempA_H
	movlw	64
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempX,W
	movwf	SysTemp1
	movf	SysWORDTempX_H,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0
	goto	ENDIF1
;PMW Duty change
;HPWMUpdate 3, ReadAD ( AN4 )
	movlw	3
	movwf	PWMCHANNEL
	movlw	4
	movwf	ADREADPORT
	call	FN_READAD7
	movf	SYSREADADBYTE,W
	movwf	PWMDUTY
	clrf	PWMDUTY_H
	call	HPWMUPDATE
;PWMDutyValue
;Cycle the Duty up and down
;PWMDutyValue = PWMDutyValue + PWMDirection
	movf	PWMDIRECTION,W
	addwf	PWMDUTYVALUE,F
;If PWMDutyValue = 255 Then
	incf	PWMDUTYVALUE,W
	btfss	STATUS, Z
	goto	ELSE2_1
;PWMDirection = -1
	movlw	255
	movwf	PWMDIRECTION
	movwf	PWMDIRECTION_H
;Else If PWMDutyValue = 0 Then
	goto	ENDIF2
ELSE2_1
	movf	PWMDUTYVALUE,F
	btfss	STATUS, Z
	goto	ENDIF2
;PWMDirection = 1
	movlw	1
	movwf	PWMDIRECTION
	clrf	PWMDIRECTION_H
;End If
ENDIF2
;Read mTouch state
;ReadmTouch
	call	READMTOUCH
;End If
ENDIF1
;PWMSetCounter++
	incf	PWMSETCOUNTER,F
	btfsc	STATUS,Z
	incf	PWMSETCOUNTER_H,F
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;---- Methods
;GCODE Optimisation file - this will optimise ADC operations by disabling the ADC operations on the AD channel that is set to FALSE
;to enable ADC operations on a specific AD channel set to TRUE
;
;Legacy chip Constants for ADC
;
;Recent chip Constants for ADC
;GCODE Optimisation file - this will optimise PWM operations by disabling the PWM operations on the PWM channel and Timer that is set to FALSE
;to enable PWM and Timer operations set to FALSE
;
;Optimise CCP/PWM
;
;Optimise PWM
;Optimise Timers associated with PWM operations
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Source: pwm.h (4566)
CALCULATEDUTY
;dim PRx_Temp as long
;dim PWMDuty as word
;dim PWMResolution as word
;assumes PRx_Temp and PWMDuty are valid
;PRx_Temp = PWMDuty  * ( PRx_Temp + 1 )
	movlw	1
	addwf	PRX_TEMP,W
	movwf	SysTemp1
	movlw	0
	addwfc	PRX_TEMP_H,W
	movwf	SysTemp1_H
	movlw	0
	addwfc	PRX_TEMP_U,W
	movwf	SysTemp1_U
	movlw	0
	addwfc	PRX_TEMP_E,W
	movwf	SysTemp1_E
	movf	PWMDUTY,W
	movwf	SysLONGTempA
	movf	PWMDUTY_H,W
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	SysTemp1,W
	movwf	SysLONGTempB
	movf	SysTemp1_H,W
	movwf	SysLONGTempB_H
	movf	SysTemp1_U,W
	movwf	SysLONGTempB_U
	movf	SysTemp1_E,W
	movwf	SysLONGTempB_E
	call	SYSMULTSUB32
	movf	SysLONGTempX,W
	movwf	PRX_TEMP
	movf	SysLONGTempX_H,W
	movwf	PRX_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	PRX_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	PRX_TEMP_E
;Set C off
	bcf	STATUS,C
;Repeat 2
	movlw	2
	movwf	SysRepeatTemp1
SysRepeatLoop1
;rotate PRx_Temp left
	rlf	PRX_TEMP,F
	rlf	PRX_TEMP_H,F
	rlf	PRX_TEMP_U,F
	rlf	PRX_TEMP_E,F
;End Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;PRx_Temp = PRx_Temp / PWMResolution    'where PWMResolution is 255 or 1023
	movf	PRX_TEMP,W
	movwf	SysLONGTempA
	movf	PRX_TEMP_H,W
	movwf	SysLONGTempA_H
	movf	PRX_TEMP_U,W
	movwf	SysLONGTempA_U
	movf	PRX_TEMP_E,W
	movwf	SysLONGTempA_E
	movf	PWMRESOLUTION,W
	movwf	SysLONGTempB
	movf	PWMRESOLUTION_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SYSDIVSUB32
	movf	SysLONGTempA,W
	movwf	PRX_TEMP
	movf	SysLONGTempA_H,W
	movwf	PRX_TEMP_H
	movf	SysLONGTempA_U,W
	movwf	PRX_TEMP_U
	movf	SysLONGTempA_E,W
	movwf	PRX_TEMP_E
;Set C off
	bcf	STATUS,C
;Repeat 6
	movlw	6
	movwf	SysRepeatTemp1
SysRepeatLoop2
;rotate PRx_Temp left
	rlf	PRX_TEMP,F
	rlf	PRX_TEMP_H,F
	rlf	PRX_TEMP_U,F
	rlf	PRX_TEMP_E,F
;End Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;exits with PRx_Temp calculated
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

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS
	movlw	3
	movwf	SysWaitTempMS_H
	call	Delay_MS
	decfsz	SysWaitTempS, F
	goto	DS_START
	return

;********************************************************************************

;Overloaded signature: BYTE:WORD:BYTE:BYTE:word:, Source: pwm.h (3368)
HPWM28
;dim PWMDuty as word
;HPWM ( PWMChannel, PWMFreq, [word]PWMDuty, _PWMTimerSelected, PWMResolution  )
	goto	HPWM29

;********************************************************************************

;Overloaded signature: BYTE:WORD:WORD:BYTE:word:, Source: pwm.h (3375)
HPWM29
;Dim PRx_Temp as LONG
;Dim TimerSelectionBits as byte
;If HPWM_FAST operation selected, only recalculate duty timer prescaler when
;needed.
;If ( PWMFreq <> PWMFreqOld )  or ( _PWMTimerSelected <> PWMTimerOld ) Then
	movf	PWMFREQ,W
	movwf	SysWORDTempA
	movf	PWMFREQ_H,W
	movwf	SysWORDTempA_H
	movf	PWMFREQOLD,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPEQUAL16
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp2
	movf	_PWMTIMERSELECTED,W
	movwf	SysBYTETempA
	movf	PWMTIMEROLD,W
	movwf	SysBYTETempB
	call	SYSCOMPEQUAL
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	SysTemp2,W
	iorwf	SysTemp1,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ELSE16_1
;Commence calculations of PMW parameters
;This figures out Prescaler required.  We can set to 1, 4 or 16 to set Tx_PR
;So, start with 1 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 4
;So, using 4 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 16
;So, using 16
;This simply sets up Tx_PR to 1,4 or 16
;PRx_Temp  = PWMOsc1 / PWMFreq
	movlw	64
	movwf	SysLONGTempA
	movlw	31
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	PWMFREQ,W
	movwf	SysLONGTempB
	movf	PWMFREQ_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SYSDIVSUB32
	movf	SysLONGTempA,W
	movwf	PRX_TEMP
	movf	SysLONGTempA_H,W
	movwf	PRX_TEMP_H
	movf	SysLONGTempA_U,W
	movwf	PRX_TEMP_U
	movf	SysLONGTempA_E,W
	movwf	PRX_TEMP_E
;Tx_PR = 1
	movlw	1
	movwf	TX_PR
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF18
;Tx_PR = 4
	movlw	4
	movwf	TX_PR
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;end if
ENDIF18
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF19
;Tx_PR = 16
	movlw	16
	movwf	TX_PR
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;end if
ENDIF19
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF20
;Tx_PR = 64
	movlw	64
	movwf	TX_PR
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;end if
ENDIF20
;This section setups the timer
;Set up PRx dependent on timer selected
;Select Case _PWMTimerSelected
;case 2 'Select timer2 as the driver for PWM
SysSelect3Case1
	movlw	2
	subwf	_PWMTIMERSELECTED,W
	btfss	STATUS, Z
	goto	SysSelectEnd3
;Set PR2
;PR2 = PRx_Temp  'This is required in the next sction of code, and as will not know which timer has been selected
	movf	PRX_TEMP,W
	movwf	PR2
;Set Clock Source, if required
;Set to FOSC/4 for backward compatibility@2d where CS<3:0> = 0000 = Fosc/4
;T2CLKCON.T2CS0 = 0
	bcf	T2CLKCON,T2CS0
;T2CLKCON.T2CS1 = 0
	bcf	T2CLKCON,T2CS1
;T2CLKCON.T2CS2 = 0
	bcf	T2CLKCON,T2CS2
;T2CLKCON.T2CS3 = 0
	bcf	T2CLKCON,T2CS3
;T2PSYNC Not Synchronized; T2MODE Software control; T2CKPOL Rising Edge; T2CKSYNC Not Synchronized
;T2HLT = 0x00
;#ifdef var(T2HLT): T2HLT = 0x00: #ENDIF
	clrf	T2HLT
;T2RSEL T2CKIPPS pin
;T2RST = 0x00
;#ifdef var(T2RST): T2RST = 0x00: #ENDIF
	clrf	T2RST
;TMR2.  Holding Register for the 8-bit TMR2 Register
;T2TMR = 0x00
;#ifdef var(T2TMR): T2TMR = 0x00: #ENDIF
	clrf	T2TMR
;Setup Timerx by clearing the Prescaler bits - it is set next....
;SET T2CKPS0 OFF
	bcf	T2CON,T2CKPS0
;SET T2CKPS1 OFF
	bcf	T2CON,T2CKPS1
;SET T2CKPS2 OFF
	bcf	T2CON,T2CKPS2
;Set Prescaler bits T2CON @3
;if Tx_PR = 4  then SET T2CKPS1 ON
	movlw	4
	subwf	TX_PR,W
	btfsc	STATUS, Z
;if Tx_PR = 4  then SET T2CKPS1 ON
	bsf	T2CON,T2CKPS1
;if Tx_PR = 4  then SET T2CKPS1 ON
;if Tx_PR = 16 then SET T2CKPS2 ON
	movlw	16
	subwf	TX_PR,W
	btfsc	STATUS, Z
;if Tx_PR = 16 then SET T2CKPS2 ON
	bsf	T2CON,T2CKPS2
;if Tx_PR = 16 then SET T2CKPS2 ON
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	movlw	64
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF23
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	bsf	T2CON,T2CKPS2
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	bsf	T2CON,T2CKPS1
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
ENDIF23
;Clearing IF flag.
;SET TMR2IF OFF
	bcf	PIR1,TMR2IF
;Start Timer2
;SET TMR2ON ON
	bsf	T2CON,TMR2ON
;End Select
SysSelectEnd3
;PWMFreqOld = PWMFreq
	movf	PWMFREQ,W
	movwf	PWMFREQOLD
;PWMTimerOld = _PWMTimerSelected
	movf	_PWMTIMERSELECTED,W
	movwf	PWMTIMEROLD
;Cache the PRx_Temp to support HPWM_FAST.
;PRx_Temp_Cache = PRx_Temp
	movf	PRX_TEMP,W
	movwf	PRX_TEMP_CACHE
	movf	PRX_TEMP_H,W
	movwf	PRX_TEMP_CACHE_H
	movf	PRX_TEMP_U,W
	movwf	PRX_TEMP_CACHE_U
	movf	PRX_TEMP_E,W
	movwf	PRX_TEMP_CACHE_E
;Else
	goto	ENDIF16
ELSE16_1
;As wierd as this looks.... restore the cache to PRX_temp as we need it when in HPWM_Fast mode
;PRx_Temp is used in channel setting section, so, if we did not restore we would not have a consistent set of information.
;PRx_Temp = PRx_Temp_Cache
	movf	PRX_TEMP_CACHE,W
	movwf	PRX_TEMP
	movf	PRX_TEMP_CACHE_H,W
	movwf	PRX_TEMP_H
	movf	PRX_TEMP_CACHE_U,W
	movwf	PRX_TEMP_U
	movf	PRX_TEMP_CACHE_E,W
	movwf	PRX_TEMP_E
;End if
ENDIF16
TENBITPMWSECTION
;This section setups up the PWM Duty
;The following code can be optimised via 'defines'
;Dim PRx_Temp_Cache as Long
;Cache the PRx_Temp value ONLY when NOT HPWM_FAST - this can be then used by HPWMUpdate
;if PWMChannel = 3 then  'in section USE_HPWM3
	movlw	3
	subwf	PWMCHANNEL,W
	btfss	STATUS, Z
	goto	ENDIF17
;calculates duty, assisgns duty to  bits 15-8 and 7-6 of PMWxDH(H&L) and links this PWM to the correct timer
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	call	CALCULATEDUTY
;PWM3DCH = PRx_Temp_H
	movf	PRX_TEMP_H,W
	banksel	PWM3DCH
	movwf	PWM3DCH
;PWM3DCL = PRx_Temp
	banksel	PRX_TEMP
	movf	PRX_TEMP,W
	banksel	PWM3DCL
	movwf	PWM3DCL
;Select timer by updating CCPTMRS register
;TimerSelectionBits =  (_PWMTimerSelected / 2 )-1 'This is a ChipPWMTimerVariant chip.  Move the timer bits to the left by one bit to cater for different addressing
	bcf	STATUS,C
	banksel	_PWMTIMERSELECTED
	rrf	_PWMTIMERSELECTED,W
	movwf	SysTemp2
	decf	SysTemp2,W
	movwf	TIMERSELECTIONBITS
;SetWith ( P3TSEL0, TimerSelectionBits.0 )
;Macro Source: stdbasic.h (370)
;if Source then
	btfss	TIMERSELECTIONBITS,0
	goto	ELSE24_1
;TargetBit = 1
	banksel	CCPTMRS
	bsf	CCPTMRS,P3TSEL0
;else
	goto	ENDIF24
ELSE24_1
;TargetBit = 0
	banksel	CCPTMRS
	bcf	CCPTMRS,P3TSEL0
;end if
ENDIF24
;SetWith ( P3TSEL1, TimerSelectionBits.1 )
;Macro Source: stdbasic.h (370)
;if Source then
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,1
	goto	ELSE25_1
;TargetBit = 1
	banksel	CCPTMRS
	bsf	CCPTMRS,P3TSEL1
;else
	goto	ENDIF25
ELSE25_1
;TargetBit = 0
	banksel	CCPTMRS
	bcf	CCPTMRS,P3TSEL1
;end if
ENDIF25
;Start PMW3
;Set PWM3EN On
	banksel	PWM3CON
	bsf	PWM3CON,PWM3EN
;End if
ENDIF17
	banksel	STATUS
	return

;********************************************************************************

;Source: pwm.h (4076)
HPWMUPDATE
;The following code can be optimised via 'defines'
;dim PRx_Temp as long
;dim PWMDuty as word
;dim PWMResolution as word
;Restore the cache value
;PRx_Temp = PRx_Temp_Cache
	movf	PRX_TEMP_CACHE,W
	movwf	PRX_TEMP
	clrf	PRX_TEMP_H
	clrf	PRX_TEMP_U
	clrf	PRX_TEMP_E
PWMUPDATE_HARDWAREMODEPWM1
PWMUPDATE_HARDWAREMODEPWM3
;if PWMChannel = 3 then  'in section USE_HPWM3
	movlw	3
	subwf	PWMCHANNEL,W
	btfss	STATUS, Z
	goto	ENDIF26
;calculates duty, assisgns duty to  bits 15-8 and 7-6 of PMWxDH(H&L) and links this PWM to the correct timer
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	call	CALCULATEDUTY
;assumes PRx_Temp and PWMDuty are valid
;PWM3DCH = PRx_Temp_H
	movf	PRX_TEMP_H,W
	banksel	PWM3DCH
	movwf	PWM3DCH
;PWM3DCL = PRx_Temp
	banksel	PRX_TEMP
	movf	PRX_TEMP,W
	banksel	PWM3DCL
	movwf	PWM3DCL
;Set PWM3EN On
	bsf	PWM3CON,PWM3EN
;End if
ENDIF26
PWMUPDATE_CCPMODE
PWMUPDATE_HARDWAREMODEPWMCCP1
;ifdef BIT(CCPR1L) Testing this bit is to identify the use of CCPR1L for PWM
;if PWMChannel = 1 then  'in section USE_HPWMCCP1
	banksel	PWMCHANNEL
	decf	PWMCHANNEL,W
	btfss	STATUS, Z
	goto	ENDIF27
;Assume more that one CCP
;ifdef BIT(CCP1FMT) Testing this bit is to identify the use of CCPR1H and CCPR1L for PWM
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	call	CALCULATEDUTY
;CCPR1H = PRx_Temp_H
	movf	PRX_TEMP_H,W
	banksel	CCPR1H
	movwf	CCPR1H
;CCPR1L = PRx_Temp
	banksel	PRX_TEMP
	movf	PRX_TEMP,W
	banksel	CCPR1L
	movwf	CCPR1L
;End if
ENDIF27
PWMUPDATE_HARDWAREMODEPWMCCP3
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (1387)
HSERSEND297
	return

;********************************************************************************

;Source: GCBASIC_firmware_for_Microchip_Curiosity_board_16F1619.gcb (49)
INITPPS
;Module: PWM3
;RC5PPS = 0x000E    'PWM3OUT > RC5
	movlw	14
	banksel	RC5PPS
	movwf	RC5PPS
	banksel	STATUS
	return

;********************************************************************************

;Source: pwm.h (253)
INITPWM
;_PWMTimerSelected = 2
	movlw	2
	movwf	_PWMTIMERSELECTED
;Dim PRx_Temp as LONG
LEGACY_STARTOFFIXEDCCPPWMMODECODE
;DIM CCPCONCache as BYTE
;CCPCONCache = 0
	clrf	CCPCONCACHE
;Set PWM Period
;PR2 = PR2_CPP_PWM_Temp
	movlw	210
	movwf	PR2
;SET T2CON.T2CKPS0 OFF
	bcf	T2CON,T2CKPS0
;SET T2CON.T2CKPS1 OFF
	bcf	T2CON,T2CKPS1
;SET T2CON.T2CKPS2 OFF
	bcf	T2CON,T2CKPS2
;Set Duty cycle
;CCPCONCache.CCP1FMT = 1
	bsf	CCPCONCACHE,CCP1FMT
;CCPR1H = DutyCycleH
	movlw	105
	banksel	CCPR1H
	movwf	CCPR1H
;CCPR1L = DutyCycleL*64
	movlw	128
	movwf	CCPR1L
;[canskip]T2CLKCON = 1
	movlw	1
	banksel	T2CLKCON
	movwf	T2CLKCON
;[canskip]CCPCONCache.en = 1
	bsf	CCPCONCACHE,EN
;legacy code, replaced by canskip
;Finish preparing CCP*CON
;SET CCPCONCache.CCP1M3 ON
;SET CCPCONCache.CCP1M2 ON
;SET CCPCONCache.CCP1M1 OFF
;SET CCPCONCache.CCP1M0 OFF'
;CCPCONCache.CCP1M3, CCPCONCache.CCP1M2, CCPCONCache.CCP1M1, CCPCONCache.CCP1M0 = b'1100'
	bsf	CCPCONCACHE,CCP1MODE3
	bsf	CCPCONCACHE,CCP1MODE2
	bcf	CCPCONCACHE,CCP1MODE1
	bcf	CCPCONCACHE,CCP1MODE0
;Enable Timer 2
;SET T2CON.TMR2ON ON
	bsf	T2CON,TMR2ON
;PWMFreqOld = 0
	clrf	PWMFREQOLD
;PWMTimerOld = 0
	clrf	PWMTIMEROLD
STARTOFFIXEDPWMMODECODE
SETPWMDUTYCODE
	return

;********************************************************************************

;Source: system.h (173)
INITSYS
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;equates to OSCCON = OSCCON AND b'10000111' & OSCCON = OSCCON OR b'11110000'
;= 32Mhz
;Set IRCF3 On
	banksel	OSCCON
	bsf	OSCCON,IRCF3
;Set IRCF2 On
	bsf	OSCCON,IRCF2
;Set IRCF1 On
	bsf	OSCCON,IRCF1
;Set IRCF0 Off
	bcf	OSCCON,IRCF0
;Set SPLLEN On
	bsf	OSCCON,SPLLEN
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON1,ADFM
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
	return

;********************************************************************************

;Source: usart.h (946)
INITUSART
;! Your program has a reference to Serial opertions however the Serial setup has not been completed.
;!
;! You should add the constants like those shown below.
;!
;! #DEFINE USART_BAUD_RATE 9600
;! #DEFINE USART_TX_BLOCKING
;! #DEFINE USART_DELAY OFF
;!
;! Please close this library once you have resolved or remove the Serial setup or commands respectively.
;!
;RaiseCompilerError "%USART_NO_BAUD_RATE%"   'uses messages.dat
RAISECOMPILERERROR	;STRING57;	;?F18L965S296I19?
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2101)
FN_READAD7
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (577)
;Handle devices with no ANSEL0 AND no ANSEL
;Code for devices with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;ChipPins = 20
;#ifNdef Bit(CHS5)
;Case 2: Set ANSELA.2 On
SysSelect1Case1
	movlw	2
	banksel	ADREADPORT
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;Case 2: Set ANSELA.2 On
	banksel	ANSELA
	bsf	ANSELA,2
;Case 4: Set ANSELc.0 On
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;Case 4: Set ANSELc.0 On
	banksel	ANSELC
	bsf	ANSELC,0
;End Select  'End Select #1
SysSelectEnd1
;SET ADCS2 OFF
	banksel	ADCON1
	bcf	ADCON1,ADCS2
;SET ADCS1 OFF
	bcf	ADCON1,ADCS1
;SET ADCS0 ON
	bsf	ADCON1,ADCS0
;Choose port
;SET CHS0 OFF
	bcf	ADCON0,CHS0
;SET CHS1 OFF
	bcf	ADCON0,CHS1
;SET CHS2 OFF
	bcf	ADCON0,CHS2
;SET CHS3 OFF
	bcf	ADCON0,CHS3
;SET CHS4 OFF
	bcf	ADCON0,CHS4
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADREADPORT
	btfss	ADREADPORT,0
	goto	ENDIF6
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADCON0
	bsf	ADCON0,CHS0
;IF ADReadPort.0 On Then Set CHS0 On
ENDIF6
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADREADPORT
	btfss	ADREADPORT,1
	goto	ENDIF7
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADCON0
	bsf	ADCON0,CHS1
;IF ADReadPort.1 On Then Set CHS1 On
ENDIF7
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADREADPORT
	btfss	ADREADPORT,2
	goto	ENDIF8
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADCON0
	bsf	ADCON0,CHS2
;IF ADReadPort.2 On Then Set CHS2 On
ENDIF8
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADREADPORT
	btfss	ADREADPORT,3
	goto	ENDIF9
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADCON0
	bsf	ADCON0,CHS3
;If ADReadPort.3 On Then Set CHS3 On
ENDIF9
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADREADPORT
	btfss	ADREADPORT,4
	goto	ENDIF10
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADCON0
	bsf	ADCON0,CHS4
;If ADReadPort.4 On Then Set CHS4 On
ENDIF10
;Enable AD Operations
;SET ADON ON
	banksel	ADCON0
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
SysWaitLoop2
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop2
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
;ReadAD = ADRESH
	banksel	ADRESH
	movf	ADRESH,W
	banksel	READAD
	movwf	READAD
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2388)
FN_READAD109
;Always RIGHT justified
;SET ADFM ON
	banksel	ADCON1
	bsf	ADCON1,ADFM
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (577)
;Handle devices with no ANSEL0 AND no ANSEL
;Code for devices with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;ChipPins = 20
;#ifNdef Bit(CHS5)
;Case 2: Set ANSELA.2 On
SysSelect2Case1
	movlw	2
	banksel	ADREADPORT
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case2
;Case 2: Set ANSELA.2 On
	banksel	ANSELA
	bsf	ANSELA,2
;Case 4: Set ANSELc.0 On
	goto	SysSelectEnd2
SysSelect2Case2
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd2
;Case 4: Set ANSELc.0 On
	banksel	ANSELC
	bsf	ANSELC,0
;End Select  'End Select #1
SysSelectEnd2
;SET ADCS2 OFF
	banksel	ADCON1
	bcf	ADCON1,ADCS2
;SET ADCS1 OFF
	bcf	ADCON1,ADCS1
;SET ADCS0 ON
	bsf	ADCON1,ADCS0
;Choose port
;SET CHS0 OFF
	bcf	ADCON0,CHS0
;SET CHS1 OFF
	bcf	ADCON0,CHS1
;SET CHS2 OFF
	bcf	ADCON0,CHS2
;SET CHS3 OFF
	bcf	ADCON0,CHS3
;SET CHS4 OFF
	bcf	ADCON0,CHS4
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADREADPORT
	btfss	ADREADPORT,0
	goto	ENDIF11
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADCON0
	bsf	ADCON0,CHS0
;IF ADReadPort.0 On Then Set CHS0 On
ENDIF11
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADREADPORT
	btfss	ADREADPORT,1
	goto	ENDIF12
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADCON0
	bsf	ADCON0,CHS1
;IF ADReadPort.1 On Then Set CHS1 On
ENDIF12
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADREADPORT
	btfss	ADREADPORT,2
	goto	ENDIF13
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADCON0
	bsf	ADCON0,CHS2
;IF ADReadPort.2 On Then Set CHS2 On
ENDIF13
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADREADPORT
	btfss	ADREADPORT,3
	goto	ENDIF14
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADCON0
	bsf	ADCON0,CHS3
;If ADReadPort.3 On Then Set CHS3 On
ENDIF14
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADREADPORT
	btfss	ADREADPORT,4
	goto	ENDIF15
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADCON0
	bsf	ADCON0,CHS4
;If ADReadPort.4 On Then Set CHS4 On
ENDIF15
;Enable AD Operations
;SET ADON ON
	banksel	ADCON0
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
SysWaitLoop3
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop3
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
	banksel	ADCON1
	bcf	ADCON1,ADFM
	banksel	STATUS
	return

;********************************************************************************

;Source: GCBASIC_firmware_for_Microchip_Curiosity_board_16F1619.gcb (144)
READMTOUCH
;Dim ADCvalueWord As Word
;Dim SaveADCON0, SaveODCONC, SaveANSELC, SaveTRISC, SaveLATC as Byte
;SaveADCON0 = ADCON0
	banksel	ADCON0
	movf	ADCON0,W
	banksel	SAVEADCON0
	movwf	SAVEADCON0
;SaveTRISC = TRISC
	banksel	TRISC
	movf	TRISC,W
	banksel	SAVETRISC
	movwf	SAVETRISC
;SaveLATC = LATC
	banksel	LATC
	movf	LATC,W
	banksel	SAVELATC
	movwf	SAVELATC
;ADCvalueWord = 0
	clrf	ADCVALUEWORD
	clrf	ADCVALUEWORD_H
;---- Constants
;AN5/RC1 - sensor channel
;Dir SENSORCHANNEL In
	banksel	TRISC
	bsf	TRISC,1
;AN6/RC2 - secondary (dummy) channel
;Dir SECONDARYCHANNEL Out
	bcf	TRISC,2
;IntOff
;AN1298 - Step 1: Set secondary (dummy) channel high (VDD)
;set as output
;Dir SECONDARYCHANNEL Out	
	bcf	TRISC,2
;set as open drain
;SaveODCONC = ODCONC
	banksel	ODCONC
	movf	ODCONC,W
	banksel	SAVEODCONC
	movwf	SAVEODCONC
;Set ODCONC.2 = 1
	banksel	ODCONC
	bsf	ODCONC,2
;set as digital
;ANSELC = SaveANSELC
	banksel	SAVEANSELC
	movf	SAVEANSELC,W
	banksel	ANSELC
	movwf	ANSELC
;Set ANSELC.2 = 0
	bcf	ANSELC,2
;set high (VDD)
;Set SECONDARYCHANNEL = 1
	banksel	LATC
	bsf	LATC,2
;AN1298 - Step 2: Select secondary channel on ADC (charge CHOLD to VDD)
;ADC channel select -> AN6/RC2 (bits 2-6)
;Set ADCON0 = 0b00011001
	movlw	25
	banksel	ADCON0
	movwf	ADCON0
;AN1298 - Step 3: Set sensor pin as output, low (GND) to eliminate any charge
;Set as output
;Dir SENSORCHANNEL Out
	bcf	TRISC,1
;Set as digital
;Set ANSELC.1 = 0
	banksel	ANSELC
	bcf	ANSELC,1
;set low (ground)
;Set SENSORCHANNEL = 0
	banksel	LATC
	bcf	LATC,1
;AN1298 - Step 4: Set sensor pin as input
;Set as input
;Dir SENSORCHANNEL In	
	banksel	TRISC
	bsf	TRISC,1
;Set as analog
;Set ANSELC.1 = 1
	banksel	ANSELC
	bsf	ANSELC,1
;AN1298 - Step 5: Select sensor channel on ADC (V-div sensor:CHOLD)
;ADC channel select -> AN5/RC1 (bits 2-6)
;Set ADCON0 = 0b00010101
	movlw	21
	banksel	ADCON0
	movwf	ADCON0
;Enable ADC (bit 0)
;Delay to allow ADC voltage to stabilise
;Wait 10 us 		
	movlw	26
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	nop
;AN1298 - Step 6: Start ADC conversion
;SET ADFM ON
	bsf	ADCON1,ADFM
;Start ADC conversion (set go/done bit 1 = 1)
;Set ADCON0.1 = 1  	
	bsf	ADCON0,1
;Wait for ADC conversion (done bit 1 = 0)
;Wait While ADCON0.1 = 1
SysWaitLoop1
	btfsc	ADCON0,1
	goto	SysWaitLoop1
;AN1298 - Step 7: Read ADC result
;ADCvalueWord = ReadAD10(AN5)
	movlw	5
	banksel	ADREADPORT
	movwf	ADREADPORT
	call	FN_READAD109
	movf	SYSREADAD10WORD,W
	movwf	ADCVALUEWORD
	movf	SYSREADAD10WORD_H,W
	movwf	ADCVALUEWORD_H
;Action result
;LATC = SaveLATC
;HSerSend ADCvalueWord
	movf	ADCVALUEWORD,W
	movwf	SERDATA
	call	HSERSEND297
;If ADCvalueWord > 10 Then
	movf	ADCVALUEWORD,W
	movwf	SysWORDTempB
	movf	ADCVALUEWORD_H,W
	movwf	SysWORDTempB_H
	movlw	10
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0
	goto	ELSE5_1
;If touching S3 touch button
;LED6 = 1
	banksel	LATA
	bsf	LATA,2
;Else
	goto	ENDIF5
ELSE5_1
;LED6 = 0
	banksel	LATA
	bcf	LATA,2
;End If
ENDIF5
;TRISC = SaveTRISC
	banksel	SAVETRISC
	movf	SAVETRISC,W
	banksel	TRISC
	movwf	TRISC
;ANSELC = SaveANSELC
	banksel	SAVEANSELC
	movf	SAVEANSELC,W
	banksel	ANSELC
	movwf	ANSELC
;ODCONC = SaveODCONC
	banksel	SAVEODCONC
	movf	SAVEODCONC,W
	banksel	ODCONC
	movwf	ODCONC
;ADCON0 = SaveADCON0
	banksel	SAVEADCON0
	movf	SAVEADCON0,W
	banksel	ADCON0
	movwf	ADCON0
;ADCON0.ADON = 0
	bcf	ADCON0,ADON
;IntOn
	banksel	STATUS
	return

;********************************************************************************

;Source: system.h (3092)
SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;subwf SysByteTempB, W
	subwf	SYSBYTETEMPB, W
;btfsc STATUS, Z
	btfsc	STATUS, Z
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (3118)
SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	subwf	SYSWORDTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	subwf	SYSWORDTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (3172)
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

;Source: system.h (3427)
SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLT16True
	goto	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (3485)
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

;Source: system.h (2875)
SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movf	SYSWORDTEMPA,W
	movwf	SYSDIVMULTA
	movf	SYSWORDTEMPA_H,W
	movwf	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movf	SYSWORDTEMPB,W
	movwf	SYSDIVMULTB
	movf	SYSWORDTEMPB_H,W
	movwf	SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX
	clrf	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempA
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0
	goto	ENDIF30
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF30
;Main calc routine
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP
SYSDIV16START
;set C off
	bcf	STATUS,C
;Rotate SysDivMultA Left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	rlf	SYSDIVMULTX,F
	rlf	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W
	subwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	subwfb	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF31
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF31
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv16Start
	goto	SYSDIV16START
;SysWordTempA = SysDivMultA
	movf	SYSDIVMULTA,W
	movwf	SYSWORDTEMPA
	movf	SYSDIVMULTA_H,W
	movwf	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************

;Source: system.h (2951)
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
	goto	ENDIF32
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF32
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
	goto	ENDIF33
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
ENDIF33
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

;Source: system.h (2696)
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
	goto	ENDIF28
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
ENDIF28
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
