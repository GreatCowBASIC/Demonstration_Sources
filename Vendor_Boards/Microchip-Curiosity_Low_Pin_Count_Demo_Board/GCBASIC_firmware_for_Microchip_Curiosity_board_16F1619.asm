;Program compiled by Great Cow BASIC (1.00.00 2023-04-05 (Windows 64 bit) : Build 1228) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2023-04-05 CRC29
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
 __CONFIG _CONFIG2, _LVP_ON & _PLLEN_OFF & _WRT_OFF
 __CONFIG _CONFIG3, _WDTE_OFF

;********************************************************************************

;Set aside memory locations for variables
ADCVALUEWORD                     EQU      32          ; 0X20
ADCVALUEWORD_H                   EQU      33          ; 0X21
ADREADPORT                       EQU      34          ; 0X22
CCPCONCACHE                      EQU      35          ; 0X23
DELAYTEMP                        EQU     112          ; 0X70
DELAYTEMP2                       EQU     113          ; 0X71
PRX_TEMP                         EQU      36          ; 0X24
PRX_TEMP_CACHE                   EQU      40          ; 0X28
PRX_TEMP_CACHE_E                 EQU      43          ; 0X2B
PRX_TEMP_CACHE_H                 EQU      41          ; 0X29
PRX_TEMP_CACHE_U                 EQU      42          ; 0X2A
PRX_TEMP_E                       EQU      39          ; 0X27
PRX_TEMP_H                       EQU      37          ; 0X25
PRX_TEMP_U                       EQU      38          ; 0X26
PWMCHANNEL                       EQU      44          ; 0X2C
PWMDIRECTION                     EQU      45          ; 0X2D
PWMDIRECTION_H                   EQU      46          ; 0X2E
PWMDUTY                          EQU      47          ; 0X2F
PWMDUTYVALUE                     EQU      49          ; 0X31
PWMDUTY_H                        EQU      48          ; 0X30
PWMFREQ                          EQU      50          ; 0X32
PWMFREQOLD                       EQU      52          ; 0X34
PWMFREQ_H                        EQU      51          ; 0X33
PWMRESOLUTION                    EQU      53          ; 0X35
PWMRESOLUTION_H                  EQU      54          ; 0X36
PWMSETCOUNTER                    EQU      55          ; 0X37
PWMSETCOUNTER_H                  EQU      56          ; 0X38
PWMTIMEROLD                      EQU      57          ; 0X39
READAD                           EQU      58          ; 0X3A
READAD10                         EQU      59          ; 0X3B
READAD10_H                       EQU      60          ; 0X3C
SAVEADCON0                       EQU      61          ; 0X3D
SAVEANSELC                       EQU      62          ; 0X3E
SAVELATC                         EQU      63          ; 0X3F
SAVEODCONC                       EQU      64          ; 0X40
SAVETRISC                        EQU      65          ; 0X41
SYSBYTETEMPA                     EQU     117          ; 0X75
SYSBYTETEMPB                     EQU     121          ; 0X79
SYSBYTETEMPX                     EQU     112          ; 0X70
SYSDIVLOOP                       EQU     116          ; 0X74
SYSDIVMULTA                      EQU     119          ; 0X77
SYSDIVMULTA_H                    EQU     120          ; 0X78
SYSDIVMULTB                      EQU     123          ; 0X7B
SYSDIVMULTB_H                    EQU     124          ; 0X7C
SYSDIVMULTX                      EQU     114          ; 0X72
SYSDIVMULTX_H                    EQU     115          ; 0X73
SYSLONGDIVMULTA                  EQU      66          ; 0X42
SYSLONGDIVMULTA_E                EQU      69          ; 0X45
SYSLONGDIVMULTA_H                EQU      67          ; 0X43
SYSLONGDIVMULTA_U                EQU      68          ; 0X44
SYSLONGDIVMULTB                  EQU      70          ; 0X46
SYSLONGDIVMULTB_E                EQU      73          ; 0X49
SYSLONGDIVMULTB_H                EQU      71          ; 0X47
SYSLONGDIVMULTB_U                EQU      72          ; 0X48
SYSLONGDIVMULTX                  EQU      74          ; 0X4A
SYSLONGDIVMULTX_E                EQU      77          ; 0X4D
SYSLONGDIVMULTX_H                EQU      75          ; 0X4B
SYSLONGDIVMULTX_U                EQU      76          ; 0X4C
SYSLONGTEMPA                     EQU     117          ; 0X75
SYSLONGTEMPA_E                   EQU     120          ; 0X78
SYSLONGTEMPA_H                   EQU     118          ; 0X76
SYSLONGTEMPA_U                   EQU     119          ; 0X77
SYSLONGTEMPB                     EQU     121          ; 0X79
SYSLONGTEMPB_E                   EQU     124          ; 0X7C
SYSLONGTEMPB_H                   EQU     122          ; 0X7A
SYSLONGTEMPB_U                   EQU     123          ; 0X7B
SYSLONGTEMPX                     EQU     112          ; 0X70
SYSLONGTEMPX_E                   EQU     115          ; 0X73
SYSLONGTEMPX_H                   EQU     113          ; 0X71
SYSLONGTEMPX_U                   EQU     114          ; 0X72
SYSREPEATTEMP1                   EQU      78          ; 0X4E
SYSTEMP1                         EQU      79          ; 0X4F
SYSTEMP1_E                       EQU      82          ; 0X52
SYSTEMP1_H                       EQU      80          ; 0X50
SYSTEMP1_U                       EQU      81          ; 0X51
SYSTEMP2                         EQU      83          ; 0X53
SYSTEMP3                         EQU      84          ; 0X54
SYSWAITTEMP10US                  EQU     117          ; 0X75
SYSWAITTEMPMS                    EQU     114          ; 0X72
SYSWAITTEMPMS_H                  EQU     115          ; 0X73
SYSWAITTEMPS                     EQU     116          ; 0X74
SYSWAITTEMPUS                    EQU     117          ; 0X75
SYSWAITTEMPUS_H                  EQU     118          ; 0X76
SYSWORDTEMPA                     EQU     117          ; 0X75
SYSWORDTEMPA_H                   EQU     118          ; 0X76
SYSWORDTEMPB                     EQU     121          ; 0X79
SYSWORDTEMPB_H                   EQU     122          ; 0X7A
SYSWORDTEMPX                     EQU     112          ; 0X70
SYSWORDTEMPX_H                   EQU     113          ; 0X71
TIMERSELECTIONBITS               EQU      85          ; 0X55
TX_PR                            EQU      86          ; 0X56
_PWMTIMERSELECTED                EQU      87          ; 0X57

;********************************************************************************

;ALIAS VARIABLES
SYSREADAD10WORD                  EQU 59
SYSREADAD10WORD_H                EQU 60
SYSREADADBYTE                    EQU 58

;********************************************************************************

;VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	GOTO	BASPROGRAMSTART
	ORG	4
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	5
BASPROGRAMSTART
;CALL INITIALISATION ROUTINES
	CALL	INITSYS
	CALL	INITPPS
	CALL	INITPWM

;START OF THE MAIN PROGRAM
;''A demonstration program for GCGB and GCB.
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
;Generated by PIC PPS Tool for Great Cow Basic
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
	BANKSEL	TRISC
	BSF	TRISC,4
;Dir PORTA.5 Out
	BCF	TRISA,5
;Dir PORTA.1 Out
	BCF	TRISA,1
;Dir PORTA.2 Out
	BCF	TRISA,2
;Dir PORTC.5 Out
	BCF	TRISC,5
;Dir PORTC.0 In
	BSF	TRISC,0
;startup wait in seconds
;---- Variables
;Dim PWMSetCounter As Word
;PWMSetCounter = 0
	BANKSEL	PWMSETCOUNTER
	CLRF	PWMSETCOUNTER
	CLRF	PWMSETCOUNTER_H
;---- Main body of program
;LED init on program startup
;Wait WAITSECS s
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;Set LED4 = 1
	BANKSEL	LATA
	BSF	LATA,5
;Set LED5 = 1
	BSF	LATA,1
;Set LED6 = 1
	BSF	LATA,2
;Set LED7 = 1
	BSF	LATC,5
;Wait WAITSECS s
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	BANKSEL	STATUS
	CALL	DELAY_S
;Set LED7 = 0
	BANKSEL	LATC
	BCF	LATC,5
;Set LED6 = 0
	BCF	LATA,2
;Set LED5 = 0
	BCF	LATA,1
;Set LED4 = 0
	BCF	LATA,5
;Required to support HPWMUpdate when using PWM/CCPn module
;PMW Freqency and Duty to value
;Dim PWMDutyValue as Byte
;Dim PWMDirection as Integer
;PWMDirection = 1
	MOVLW	1
	BANKSEL	PWMDIRECTION
	MOVWF	PWMDIRECTION
	CLRF	PWMDIRECTION_H
;PWMDutyValue = 127
	MOVLW	127
	MOVWF	PWMDUTYVALUE
;PWM3 is an 8 bit signal
;HPWM 3, 3, PWMDutyValue, 2
	MOVLW	3
	MOVWF	PWMCHANNEL
	MOVLW	3
	MOVWF	PWMFREQ
	CLRF	PWMFREQ_H
	MOVF	PWMDUTYVALUE,W
	MOVWF	PWMDUTY
	CLRF	PWMDUTY_H
	MOVLW	2
	MOVWF	_PWMTIMERSELECTED
	MOVLW	255
	MOVWF	PWMRESOLUTION
	CLRF	PWMRESOLUTION_H
	CALL	HPWM27
;Program infinite loop
;Do Forever
SYSDOLOOP_S1
;Set LED to state of switch
;LED4 = !SWITCH1
	CLRF	SYSTEMP2
	BTFSC	PORTC,4
	INCF	SYSTEMP2,F
	COMF	SYSTEMP2,F
	BANKSEL	LATA
	BCF	LATA,5
	BANKSEL	SYSTEMP2
	BTFSS	SYSTEMP2,0
	GOTO	ENDIF4
	BANKSEL	LATA
	BSF	LATA,5
ENDIF4
;If PWMSetCounter MOD 64 = 0 Then
	BANKSEL	PWMSETCOUNTER
	MOVF	PWMSETCOUNTER,W
	MOVWF	SYSWORDTEMPA
	MOVF	PWMSETCOUNTER_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	64
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPX,W
	MOVWF	SYSTEMP1
	MOVF	SYSWORDTEMPX_H,W
	MOVWF	SYSTEMP1_H
	MOVF	SYSTEMP1,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF1
;PMW Duty change
;HPWMUpdate 3, ReadAD ( AN4 )
	MOVLW	3
	MOVWF	PWMCHANNEL
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD6
	MOVF	SYSREADADBYTE,W
	MOVWF	PWMDUTY
	CLRF	PWMDUTY_H
	CALL	HPWMUPDATE
;PWMDutyValue
;Cycle the Duty up and down
;PWMDutyValue = PWMDutyValue + PWMDirection
	MOVF	PWMDIRECTION,W
	ADDWF	PWMDUTYVALUE,F
;If PWMDutyValue = 255 Then
	INCF	PWMDUTYVALUE,W
	BTFSS	STATUS, Z
	GOTO	ELSE2_1
;PWMDirection = -1
	MOVLW	255
	MOVWF	PWMDIRECTION
	MOVWF	PWMDIRECTION_H
;Else If PWMDutyValue = 0 Then
	GOTO	ENDIF2
ELSE2_1
	MOVF	PWMDUTYVALUE,F
	BTFSS	STATUS, Z
	GOTO	ENDIF2
;PWMDirection = 1
	MOVLW	1
	MOVWF	PWMDIRECTION
	CLRF	PWMDIRECTION_H
;End If
ENDIF2
;End If
ENDIF1
;PWMSetCounter++
	INCF	PWMSETCOUNTER,F
	BTFSC	STATUS,Z
	INCF	PWMSETCOUNTER_H,F
;Read mTouch state
;ReadmTouch
	CALL	READMTOUCH
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1
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
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: PWM.H (4566)
CALCULATEDUTY
;dim PRx_Temp as long
;dim PWMDuty as word
;dim PWMResolution as word
;assumes PRx_Temp and PWMDuty are valid
;PRx_Temp = PWMDuty  * ( PRx_Temp + 1 )
	MOVLW	1
	ADDWF	PRX_TEMP,W
	MOVWF	SYSTEMP1
	MOVLW	0
	ADDWFC	PRX_TEMP_H,W
	MOVWF	SYSTEMP1_H
	MOVLW	0
	ADDWFC	PRX_TEMP_U,W
	MOVWF	SYSTEMP1_U
	MOVLW	0
	ADDWFC	PRX_TEMP_E,W
	MOVWF	SYSTEMP1_E
	MOVF	PWMDUTY,W
	MOVWF	SYSLONGTEMPA
	MOVF	PWMDUTY_H,W
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	MOVF	SYSTEMP1,W
	MOVWF	SYSLONGTEMPB
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSLONGTEMPB_H
	MOVF	SYSTEMP1_U,W
	MOVWF	SYSLONGTEMPB_U
	MOVF	SYSTEMP1_E,W
	MOVWF	SYSLONGTEMPB_E
	CALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	PRX_TEMP
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	PRX_TEMP_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	PRX_TEMP_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	PRX_TEMP_E
;Set C off
	BCF	STATUS,C
;Repeat 2
	MOVLW	2
	MOVWF	SYSREPEATTEMP1
SYSREPEATLOOP1
;rotate PRx_Temp left
	RLF	PRX_TEMP,F
	RLF	PRX_TEMP_H,F
	RLF	PRX_TEMP_U,F
	RLF	PRX_TEMP_E,F
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
SYSREPEATLOOPEND1
;PRx_Temp = PRx_Temp / PWMResolution    'where PWMResolution is 255 or 1023
	MOVF	PRX_TEMP,W
	MOVWF	SYSLONGTEMPA
	MOVF	PRX_TEMP_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	PRX_TEMP_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	PRX_TEMP_E,W
	MOVWF	SYSLONGTEMPA_E
	MOVF	PWMRESOLUTION,W
	MOVWF	SYSLONGTEMPB
	MOVF	PWMRESOLUTION_H,W
	MOVWF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	CALL	SYSDIVSUB32
	MOVF	SYSLONGTEMPA,W
	MOVWF	PRX_TEMP
	MOVF	SYSLONGTEMPA_H,W
	MOVWF	PRX_TEMP_H
	MOVF	SYSLONGTEMPA_U,W
	MOVWF	PRX_TEMP_U
	MOVF	SYSLONGTEMPA_E,W
	MOVWF	PRX_TEMP_E
;Set C off
	BCF	STATUS,C
;Repeat 6
	MOVLW	6
	MOVWF	SYSREPEATTEMP1
SYSREPEATLOOP2
;rotate PRx_Temp left
	RLF	PRX_TEMP,F
	RLF	PRX_TEMP_H,F
	RLF	PRX_TEMP_U,F
	RLF	PRX_TEMP_E,F
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP2
SYSREPEATLOOPEND2
;exits with PRx_Temp calculated
	RETURN

;********************************************************************************

DELAY_10US
D10US_START
	MOVLW	25
	MOVWF	DELAYTEMP
DELAYUS0
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS0
	NOP
	DECFSZ	SYSWAITTEMP10US, F
	GOTO	D10US_START
	RETURN

;********************************************************************************

DELAY_MS
	INCF	SYSWAITTEMPMS_H, F
DMS_START
	MOVLW	14
	MOVWF	DELAYTEMP2
DMS_OUTER
	MOVLW	189
	MOVWF	DELAYTEMP
DMS_INNER
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

DELAY_S
DS_START
	MOVLW	232
	MOVWF	SYSWAITTEMPMS
	MOVLW	3
	MOVWF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
	DECFSZ	SYSWAITTEMPS, F
	GOTO	DS_START
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:WORD:BYTE:BYTE:WORD:, SOURCE: PWM.H (3368)
HPWM27
;dim PWMDuty as word
;HPWM ( PWMChannel, PWMFreq, [word]PWMDuty, _PWMTimerSelected, PWMResolution  )
	GOTO	HPWM28

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:WORD:WORD:BYTE:WORD:, SOURCE: PWM.H (3375)
HPWM28
;Dim PRx_Temp as LONG
;Dim TimerSelectionBits as byte
;If HPWM_FAST operation selected, only recalculate duty timer prescaler when
;needed.
;If ( PWMFreq <> PWMFreqOld )  or ( _PWMTimerSelected <> PWMTimerOld ) Then
	MOVF	PWMFREQ,W
	MOVWF	SYSWORDTEMPA
	MOVF	PWMFREQ_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	PWMFREQOLD,W
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP2
	MOVF	_PWMTIMERSELECTED,W
	MOVWF	SYSBYTETEMPA
	MOVF	PWMTIMEROLD,W
	MOVWF	SYSBYTETEMPB
	CALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP1
	MOVF	SYSTEMP2,W
	IORWF	SYSTEMP1,W
	MOVWF	SYSTEMP3
	BTFSS	SYSTEMP3,0
	GOTO	ELSE16_1
;Commence calculations of PMW parameters
;This figures out Prescaler required.  We can set to 1, 4 or 16 to set Tx_PR
;So, start with 1 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 4
;So, using 4 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 16
;So, using 16
;This simply sets up Tx_PR to 1,4 or 16
;PRx_Temp  = PWMOsc1 / PWMFreq
	MOVLW	64
	MOVWF	SYSLONGTEMPA
	MOVLW	31
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	MOVF	PWMFREQ,W
	MOVWF	SYSLONGTEMPB
	MOVF	PWMFREQ_H,W
	MOVWF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	CALL	SYSDIVSUB32
	MOVF	SYSLONGTEMPA,W
	MOVWF	PRX_TEMP
	MOVF	SYSLONGTEMPA_H,W
	MOVWF	PRX_TEMP_H
	MOVF	SYSLONGTEMPA_U,W
	MOVWF	PRX_TEMP_U
	MOVF	SYSLONGTEMPA_E,W
	MOVWF	PRX_TEMP_E
;Tx_PR = 1
	MOVLW	1
	MOVWF	TX_PR
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
	BTFSC	STATUS, C
	GOTO	ENDIF18
;Tx_PR = 4
	MOVLW	4
	MOVWF	TX_PR
;Divide by 4
;set STATUS.C off
	BCF	STATUS,C
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;set STATUS.C off
	BCF	STATUS,C
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;end if
ENDIF18
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
	BTFSC	STATUS, C
	GOTO	ENDIF19
;Tx_PR = 16
	MOVLW	16
	MOVWF	TX_PR
;Divide by 4
;set STATUS.C off
	BCF	STATUS,C
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;set STATUS.C off
	BCF	STATUS,C
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;end if
ENDIF19
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
	BTFSC	STATUS, C
	GOTO	ENDIF20
;Tx_PR = 64
	MOVLW	64
	MOVWF	TX_PR
;Divide by 4
;set STATUS.C off
	BCF	STATUS,C
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;set STATUS.C off
	BCF	STATUS,C
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;end if
ENDIF20
;This section setups the timer
;Set up PRx dependent on timer selected
;Select Case _PWMTimerSelected
;case 2 'Select timer2 as the driver for PWM
SYSSELECT3CASE1
	MOVLW	2
	SUBWF	_PWMTIMERSELECTED,W
	BTFSS	STATUS, Z
	GOTO	SYSSELECTEND3
;Set PR2
;PR2 = PRx_Temp  'This is required in the next sction of code, and as will not know which timer has been selected
	MOVF	PRX_TEMP,W
	MOVWF	PR2
;Set Clock Source, if required
;Set to FOSC/4 for backward compatibility@2d where CS<3:0> = 0000 = Fosc/4
;T2CLKCON.T2CS0 = 0
	BCF	T2CLKCON,T2CS0
;T2CLKCON.T2CS1 = 0
	BCF	T2CLKCON,T2CS1
;T2CLKCON.T2CS2 = 0
	BCF	T2CLKCON,T2CS2
;T2CLKCON.T2CS3 = 0
	BCF	T2CLKCON,T2CS3
;T2PSYNC Not Synchronized; T2MODE Software control; T2CKPOL Rising Edge; T2CKSYNC Not Synchronized
;T2HLT = 0x00
;#ifdef var(T2HLT): T2HLT = 0x00: #ENDIF
	CLRF	T2HLT
;T2RSEL T2CKIPPS pin
;T2RST = 0x00
;#ifdef var(T2RST): T2RST = 0x00: #ENDIF
	CLRF	T2RST
;TMR2.  Holding Register for the 8-bit TMR2 Register
;T2TMR = 0x00
;#ifdef var(T2TMR): T2TMR = 0x00: #ENDIF
	CLRF	T2TMR
;Setup Timerx by clearing the Prescaler bits - it is set next....
;SET T2CKPS0 OFF
	BCF	T2CON,T2CKPS0
;SET T2CKPS1 OFF
	BCF	T2CON,T2CKPS1
;SET T2CKPS2 OFF
	BCF	T2CON,T2CKPS2
;Set Prescaler bits T2CON @3
;if Tx_PR = 4  then SET T2CKPS1 ON
	MOVLW	4
	SUBWF	TX_PR,W
	BTFSC	STATUS, Z
;if Tx_PR = 4  then SET T2CKPS1 ON
	BSF	T2CON,T2CKPS1
;if Tx_PR = 4  then SET T2CKPS1 ON
;if Tx_PR = 16 then SET T2CKPS2 ON
	MOVLW	16
	SUBWF	TX_PR,W
	BTFSC	STATUS, Z
;if Tx_PR = 16 then SET T2CKPS2 ON
	BSF	T2CON,T2CKPS2
;if Tx_PR = 16 then SET T2CKPS2 ON
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	MOVLW	64
	SUBWF	TX_PR,W
	BTFSS	STATUS, Z
	GOTO	ENDIF23
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	BSF	T2CON,T2CKPS2
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	BSF	T2CON,T2CKPS1
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
ENDIF23
;Clearing IF flag.
;SET TMR2IF OFF
	BCF	PIR1,TMR2IF
;Start Timer2
;SET TMR2ON ON
	BSF	T2CON,TMR2ON
;End Select
SYSSELECTEND3
;PWMFreqOld = PWMFreq
	MOVF	PWMFREQ,W
	MOVWF	PWMFREQOLD
;PWMTimerOld = _PWMTimerSelected
	MOVF	_PWMTIMERSELECTED,W
	MOVWF	PWMTIMEROLD
;Cache the PRx_Temp to support HPWM_FAST.
;PRx_Temp_Cache = PRx_Temp
	MOVF	PRX_TEMP,W
	MOVWF	PRX_TEMP_CACHE
	MOVF	PRX_TEMP_H,W
	MOVWF	PRX_TEMP_CACHE_H
	MOVF	PRX_TEMP_U,W
	MOVWF	PRX_TEMP_CACHE_U
	MOVF	PRX_TEMP_E,W
	MOVWF	PRX_TEMP_CACHE_E
;Else
	GOTO	ENDIF16
ELSE16_1
;As wierd as this looks.... restore the cache to PRX_temp as we need it when in HPWM_Fast mode
;PRx_Temp is used in channel setting section, so, if we did not restore we would not have a consistent set of information.
;PRx_Temp = PRx_Temp_Cache
	MOVF	PRX_TEMP_CACHE,W
	MOVWF	PRX_TEMP
	MOVF	PRX_TEMP_CACHE_H,W
	MOVWF	PRX_TEMP_H
	MOVF	PRX_TEMP_CACHE_U,W
	MOVWF	PRX_TEMP_U
	MOVF	PRX_TEMP_CACHE_E,W
	MOVWF	PRX_TEMP_E
;End if
ENDIF16
TENBITPMWSECTION
;This section setups up the PWM Duty
;The following code can be optimised via 'defines'
;Dim PRx_Temp_Cache as Long
;Cache the PRx_Temp value ONLY when NOT HPWM_FAST - this can be then used by HPWMUpdate
;if PWMChannel = 3 then  'in section USE_HPWM3
	MOVLW	3
	SUBWF	PWMCHANNEL,W
	BTFSS	STATUS, Z
	GOTO	ENDIF17
;calculates duty, assisgns duty to  bits 15-8 and 7-6 of PMWxDH(H&L) and links this PWM to the correct timer
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	CALL	CALCULATEDUTY
;PWM3DCH = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
	BANKSEL	PWM3DCH
	MOVWF	PWM3DCH
;PWM3DCL = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
	BANKSEL	PWM3DCL
	MOVWF	PWM3DCL
;Select timer by updating CCPTMRS register
;TimerSelectionBits =  (_PWMTimerSelected / 2 )-1 'This is a ChipPWMTimerVariant chip.  Move the timer bits to the left by one bit to cater for different addressing
	BCF	STATUS,C
	BANKSEL	_PWMTIMERSELECTED
	RRF	_PWMTIMERSELECTED,W
	MOVWF	SYSTEMP2
	DECF	SYSTEMP2,W
	MOVWF	TIMERSELECTIONBITS
;SetWith ( P3TSEL0, TimerSelectionBits.0 )
;Macro Source: stdbasic.h (370)
;if Source then
	BTFSS	TIMERSELECTIONBITS,0
	GOTO	ELSE24_1
;TargetBit = 1
	BANKSEL	CCPTMRS
	BSF	CCPTMRS,P3TSEL0
;else
	GOTO	ENDIF24
ELSE24_1
;TargetBit = 0
	BANKSEL	CCPTMRS
	BCF	CCPTMRS,P3TSEL0
;end if
ENDIF24
;SetWith ( P3TSEL1, TimerSelectionBits.1 )
;Macro Source: stdbasic.h (370)
;if Source then
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,1
	GOTO	ELSE25_1
;TargetBit = 1
	BANKSEL	CCPTMRS
	BSF	CCPTMRS,P3TSEL1
;else
	GOTO	ENDIF25
ELSE25_1
;TargetBit = 0
	BANKSEL	CCPTMRS
	BCF	CCPTMRS,P3TSEL1
;end if
ENDIF25
;Start PMW3
;Set PWM3EN On
	BANKSEL	PWM3CON
	BSF	PWM3CON,PWM3EN
;End if
ENDIF17
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: PWM.H (4076)
HPWMUPDATE
;The following code can be optimised via 'defines'
;dim PRx_Temp as long
;dim PWMDuty as word
;dim PWMResolution as word
;Restore the cache value
;PRx_Temp = PRx_Temp_Cache
	MOVF	PRX_TEMP_CACHE,W
	MOVWF	PRX_TEMP
	CLRF	PRX_TEMP_H
	CLRF	PRX_TEMP_U
	CLRF	PRX_TEMP_E
PWMUPDATE_HARDWAREMODEPWM1
PWMUPDATE_HARDWAREMODEPWM3
;if PWMChannel = 3 then  'in section USE_HPWM3
	MOVLW	3
	SUBWF	PWMCHANNEL,W
	BTFSS	STATUS, Z
	GOTO	ENDIF26
;calculates duty, assisgns duty to  bits 15-8 and 7-6 of PMWxDH(H&L) and links this PWM to the correct timer
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	CALL	CALCULATEDUTY
;assumes PRx_Temp and PWMDuty are valid
;PWM3DCH = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
	BANKSEL	PWM3DCH
	MOVWF	PWM3DCH
;PWM3DCL = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
	BANKSEL	PWM3DCL
	MOVWF	PWM3DCL
;Set PWM3EN On
	BSF	PWM3CON,PWM3EN
;End if
ENDIF26
PWMUPDATE_CCPMODE
PWMUPDATE_HARDWAREMODEPWMCCP1
;ifdef BIT(CCPR1L) Testing this bit is to identify the use of CCPR1L for PWM
;if PWMChannel = 1 then  'in section USE_HPWMCCP1
	BANKSEL	PWMCHANNEL
	DECF	PWMCHANNEL,W
	BTFSS	STATUS, Z
	GOTO	ENDIF27
;Assume more that one CCP
;ifdef BIT(CCP1FMT) Testing this bit is to identify the use of CCPR1H and CCPR1L for PWM
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	CALL	CALCULATEDUTY
;CCPR1H = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
	BANKSEL	CCPR1H
	MOVWF	CCPR1H
;CCPR1L = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
	BANKSEL	CCPR1L
	MOVWF	CCPR1L
;End if
ENDIF27
PWMUPDATE_HARDWAREMODEPWMCCP3
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: GCBASIC_FIRMWARE_FOR_MICROCHIP_CURIOSITY_BOARD_16F1619.GCB (49)
INITPPS
;Module: PWM3
;RC5PPS = 0x000E    'PWM3OUT > RC5
	MOVLW	14
	BANKSEL	RC5PPS
	MOVWF	RC5PPS
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: PWM.H (253)
INITPWM
;_PWMTimerSelected = 2
	MOVLW	2
	MOVWF	_PWMTIMERSELECTED
;Dim PRx_Temp as LONG
LEGACY_STARTOFFIXEDCCPPWMMODECODE
;DIM CCPCONCache as BYTE
;CCPCONCache = 0
	CLRF	CCPCONCACHE
;Set PWM Period
;PR2 = PR2_CPP_PWM_Temp
	MOVLW	210
	MOVWF	PR2
;SET T2CON.T2CKPS0 OFF
	BCF	T2CON,T2CKPS0
;SET T2CON.T2CKPS1 OFF
	BCF	T2CON,T2CKPS1
;SET T2CON.T2CKPS2 OFF
	BCF	T2CON,T2CKPS2
;Set Duty cycle
;CCPCONCache.CCP1FMT = 1
	BSF	CCPCONCACHE,CCP1FMT
;CCPR1H = DutyCycleH
	MOVLW	105
	BANKSEL	CCPR1H
	MOVWF	CCPR1H
;CCPR1L = DutyCycleL*64
	MOVLW	128
	MOVWF	CCPR1L
;[canskip]T2CLKCON = 1
	MOVLW	1
	BANKSEL	T2CLKCON
	MOVWF	T2CLKCON
;[canskip]CCPCONCache.en = 1
	BSF	CCPCONCACHE,EN
;legacy code, replaced by canskip
;Finish preparing CCP*CON
;SET CCPCONCache.CCP1M3 ON
;SET CCPCONCache.CCP1M2 ON
;SET CCPCONCache.CCP1M1 OFF
;SET CCPCONCache.CCP1M0 OFF'
;CCPCONCache.CCP1M3, CCPCONCache.CCP1M2, CCPCONCache.CCP1M1, CCPCONCache.CCP1M0 = b'1100'
	BSF	CCPCONCACHE,CCP1MODE3
	BSF	CCPCONCACHE,CCP1MODE2
	BCF	CCPCONCACHE,CCP1MODE1
	BCF	CCPCONCACHE,CCP1MODE0
;Enable Timer 2
;SET T2CON.TMR2ON ON
	BSF	T2CON,TMR2ON
;PWMFreqOld = 0
	CLRF	PWMFREQOLD
;PWMTimerOld = 0
	CLRF	PWMTIMEROLD
STARTOFFIXEDPWMMODECODE
SETPWMDUTYCODE
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (162)
INITSYS
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;equates to OSCCON = OSCCON AND b'10000111' & OSCCON = OSCCON OR b'11110000'
;= 32Mhz
;Set IRCF3 On
	BANKSEL	OSCCON
	BSF	OSCCON,IRCF3
;Set IRCF2 On
	BSF	OSCCON,IRCF2
;Set IRCF1 On
	BSF	OSCCON,IRCF1
;Set IRCF0 Off
	BCF	OSCCON,IRCF0
;Set SPLLEN On
	BSF	OSCCON,SPLLEN
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	BCF	ADCON1,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	BCF	ADCON0,ADON
;ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA
;ANSELB = 0
	CLRF	ANSELB
;ANSELC = 0
	CLRF	ANSELC
;Set comparator register bits for many MCUs with register CM2CON0
;C2ON = 0
	BANKSEL	CM2CON0
	BCF	CM2CON0,C2ON
;C1ON = 0
	BCF	CM1CON0,C1ON
;
;'Turn off all ports
;PORTA = 0
	BANKSEL	PORTA
	CLRF	PORTA
;PORTB = 0
	CLRF	PORTB
;PORTC = 0
	CLRF	PORTC
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2101)
FN_READAD6
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	BANKSEL	ADCON1
	BCF	ADCON1,ADFM
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
SYSSELECT1CASE1
	MOVLW	2
	BANKSEL	ADREADPORT
	SUBWF	ADREADPORT,W
	BTFSS	STATUS, Z
	GOTO	SYSSELECT1CASE2
;Case 2: Set ANSELA.2 On
	BANKSEL	ANSELA
	BSF	ANSELA,2
;Case 4: Set ANSELc.0 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE2
	MOVLW	4
	SUBWF	ADREADPORT,W
	BTFSS	STATUS, Z
	GOTO	SYSSELECTEND1
;Case 4: Set ANSELc.0 On
	BANKSEL	ANSELC
	BSF	ANSELC,0
;End Select  'End Select #1
SYSSELECTEND1
;SET ADCS2 OFF
	BANKSEL	ADCON1
	BCF	ADCON1,ADCS2
;SET ADCS1 OFF
	BCF	ADCON1,ADCS1
;SET ADCS0 ON
	BSF	ADCON1,ADCS0
;Choose port
;SET CHS0 OFF
	BCF	ADCON0,CHS0
;SET CHS1 OFF
	BCF	ADCON0,CHS1
;SET CHS2 OFF
	BCF	ADCON0,CHS2
;SET CHS3 OFF
	BCF	ADCON0,CHS3
;SET CHS4 OFF
	BCF	ADCON0,CHS4
;IF ADReadPort.0 On Then Set CHS0 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,0
	GOTO	ENDIF6
;IF ADReadPort.0 On Then Set CHS0 On
	BANKSEL	ADCON0
	BSF	ADCON0,CHS0
;IF ADReadPort.0 On Then Set CHS0 On
ENDIF6
;IF ADReadPort.1 On Then Set CHS1 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,1
	GOTO	ENDIF7
;IF ADReadPort.1 On Then Set CHS1 On
	BANKSEL	ADCON0
	BSF	ADCON0,CHS1
;IF ADReadPort.1 On Then Set CHS1 On
ENDIF7
;IF ADReadPort.2 On Then Set CHS2 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,2
	GOTO	ENDIF8
;IF ADReadPort.2 On Then Set CHS2 On
	BANKSEL	ADCON0
	BSF	ADCON0,CHS2
;IF ADReadPort.2 On Then Set CHS2 On
ENDIF8
;If ADReadPort.3 On Then Set CHS3 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,3
	GOTO	ENDIF9
;If ADReadPort.3 On Then Set CHS3 On
	BANKSEL	ADCON0
	BSF	ADCON0,CHS3
;If ADReadPort.3 On Then Set CHS3 On
ENDIF9
;If ADReadPort.4 On Then Set CHS4 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,4
	GOTO	ENDIF10
;If ADReadPort.4 On Then Set CHS4 On
	BANKSEL	ADCON0
	BSF	ADCON0,CHS4
;If ADReadPort.4 On Then Set CHS4 On
ENDIF10
;Enable AD Operations
;SET ADON ON
	BANKSEL	ADCON0
	BSF	ADCON0,ADON
;Acquisition Delay
;Wait AD_Delay
	MOVLW	2
	MOVWF	SYSWAITTEMP10US
	BANKSEL	STATUS
	CALL	DELAY_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	BANKSEL	ADCON0
	BSF	ADCON0,GO_NOT_DONE
;nop
	NOP
;Wait While GO_NOT_DONE ON
SYSWAITLOOP2
	BTFSC	ADCON0,GO_NOT_DONE
	GOTO	SYSWAITLOOP2
;Switch off A/D
;SET ADCON0.ADON OFF
	BCF	ADCON0,ADON
;ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA
;ANSELB = 0
	CLRF	ANSELB
;ANSELC = 0
	CLRF	ANSELC
;ReadAD = ADRESH
	BANKSEL	ADRESH
	MOVF	ADRESH,W
	BANKSEL	READAD
	MOVWF	READAD
;SET ADFM OFF
	BANKSEL	ADCON1
	BCF	ADCON1,ADFM
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2388)
FN_READAD108
;Always RIGHT justified
;SET ADFM ON
	BANKSEL	ADCON1
	BSF	ADCON1,ADFM
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (577)
;Handle devices with no ANSEL0 AND no ANSEL
;Code for devices with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;ChipPins = 20
;#ifNdef Bit(CHS5)
;Case 2: Set ANSELA.2 On
SYSSELECT2CASE1
	MOVLW	2
	BANKSEL	ADREADPORT
	SUBWF	ADREADPORT,W
	BTFSS	STATUS, Z
	GOTO	SYSSELECT2CASE2
;Case 2: Set ANSELA.2 On
	BANKSEL	ANSELA
	BSF	ANSELA,2
;Case 4: Set ANSELc.0 On
	GOTO	SYSSELECTEND2
SYSSELECT2CASE2
	MOVLW	4
	SUBWF	ADREADPORT,W
	BTFSS	STATUS, Z
	GOTO	SYSSELECTEND2
;Case 4: Set ANSELc.0 On
	BANKSEL	ANSELC
	BSF	ANSELC,0
;End Select  'End Select #1
SYSSELECTEND2
;SET ADCS2 OFF
	BANKSEL	ADCON1
	BCF	ADCON1,ADCS2
;SET ADCS1 OFF
	BCF	ADCON1,ADCS1
;SET ADCS0 ON
	BSF	ADCON1,ADCS0
;Choose port
;SET CHS0 OFF
	BCF	ADCON0,CHS0
;SET CHS1 OFF
	BCF	ADCON0,CHS1
;SET CHS2 OFF
	BCF	ADCON0,CHS2
;SET CHS3 OFF
	BCF	ADCON0,CHS3
;SET CHS4 OFF
	BCF	ADCON0,CHS4
;IF ADReadPort.0 On Then Set CHS0 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,0
	GOTO	ENDIF11
;IF ADReadPort.0 On Then Set CHS0 On
	BANKSEL	ADCON0
	BSF	ADCON0,CHS0
;IF ADReadPort.0 On Then Set CHS0 On
ENDIF11
;IF ADReadPort.1 On Then Set CHS1 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,1
	GOTO	ENDIF12
;IF ADReadPort.1 On Then Set CHS1 On
	BANKSEL	ADCON0
	BSF	ADCON0,CHS1
;IF ADReadPort.1 On Then Set CHS1 On
ENDIF12
;IF ADReadPort.2 On Then Set CHS2 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,2
	GOTO	ENDIF13
;IF ADReadPort.2 On Then Set CHS2 On
	BANKSEL	ADCON0
	BSF	ADCON0,CHS2
;IF ADReadPort.2 On Then Set CHS2 On
ENDIF13
;If ADReadPort.3 On Then Set CHS3 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,3
	GOTO	ENDIF14
;If ADReadPort.3 On Then Set CHS3 On
	BANKSEL	ADCON0
	BSF	ADCON0,CHS3
;If ADReadPort.3 On Then Set CHS3 On
ENDIF14
;If ADReadPort.4 On Then Set CHS4 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,4
	GOTO	ENDIF15
;If ADReadPort.4 On Then Set CHS4 On
	BANKSEL	ADCON0
	BSF	ADCON0,CHS4
;If ADReadPort.4 On Then Set CHS4 On
ENDIF15
;Enable AD Operations
;SET ADON ON
	BANKSEL	ADCON0
	BSF	ADCON0,ADON
;Acquisition Delay
;Wait AD_Delay
	MOVLW	2
	MOVWF	SYSWAITTEMP10US
	BANKSEL	STATUS
	CALL	DELAY_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	BANKSEL	ADCON0
	BSF	ADCON0,GO_NOT_DONE
;nop
	NOP
;Wait While GO_NOT_DONE ON
SYSWAITLOOP3
	BTFSC	ADCON0,GO_NOT_DONE
	GOTO	SYSWAITLOOP3
;Switch off A/D
;SET ADCON0.ADON OFF
	BCF	ADCON0,ADON
;ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA
;ANSELB = 0
	CLRF	ANSELB
;ANSELC = 0
	CLRF	ANSELC
;Write output
;ReadAD10 = ADRESL
	BANKSEL	ADRESL
	MOVF	ADRESL,W
	BANKSEL	READAD10
	MOVWF	READAD10
	CLRF	READAD10_H
;ReadAD10_H = ADRESH
	BANKSEL	ADRESH
	MOVF	ADRESH,W
	BANKSEL	READAD10_H
	MOVWF	READAD10_H
;Put A/D format back to normal
;SET ADFM OFF
	BANKSEL	ADCON1
	BCF	ADCON1,ADFM
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: GCBASIC_FIRMWARE_FOR_MICROCHIP_CURIOSITY_BOARD_16F1619.GCB (141)
READMTOUCH
;Dim ADCvalueWord As Word
;Dim SaveADCON0, SaveODCONC, SaveANSELC, SaveTRISC, SaveLATC as Byte
;SaveADCON0 = ADCON0
	BANKSEL	ADCON0
	MOVF	ADCON0,W
	BANKSEL	SAVEADCON0
	MOVWF	SAVEADCON0
;SaveTRISC = TRISC
	BANKSEL	TRISC
	MOVF	TRISC,W
	BANKSEL	SAVETRISC
	MOVWF	SAVETRISC
;SaveLATC = LATC
	BANKSEL	LATC
	MOVF	LATC,W
	BANKSEL	SAVELATC
	MOVWF	SAVELATC
;ADCvalueWord = 0
	CLRF	ADCVALUEWORD
	CLRF	ADCVALUEWORD_H
;---- Constants
;AN5/RC1 - sensor channel
;Dir SENSORCHANNEL In
	BANKSEL	TRISC
	BSF	TRISC,1
;AN6/RC2 - secondary (dummy) channel
;Dir SECONDARYCHANNEL Out
	BCF	TRISC,2
;IntOff
;AN1298 - Step 1: Set secondary (dummy) channel high (VDD)
;set as output
;Dir SECONDARYCHANNEL Out	
	BCF	TRISC,2
;set as open drain
;SaveODCONC = ODCONC
	BANKSEL	ODCONC
	MOVF	ODCONC,W
	BANKSEL	SAVEODCONC
	MOVWF	SAVEODCONC
;Set ODCONC.2 = 1
	BANKSEL	ODCONC
	BSF	ODCONC,2
;set as digital
;ANSELC = SaveANSELC
	BANKSEL	SAVEANSELC
	MOVF	SAVEANSELC,W
	BANKSEL	ANSELC
	MOVWF	ANSELC
;Set ANSELC.2 = 0
	BCF	ANSELC,2
;set high (VDD)
;Set SECONDARYCHANNEL = 1
	BANKSEL	LATC
	BSF	LATC,2
;AN1298 - Step 2: Select secondary channel on ADC (charge CHOLD to VDD)
;ADC channel select -> AN6/RC2 (bits 2-6)
;Set ADCON0 = 0b00011001
	MOVLW	25
	BANKSEL	ADCON0
	MOVWF	ADCON0
;AN1298 - Step 3: Set sensor pin as output, low (GND) to eliminate any charge
;Set as output
;Dir SENSORCHANNEL Out
	BCF	TRISC,1
;Set as digital
;Set ANSELC.1 = 0
	BANKSEL	ANSELC
	BCF	ANSELC,1
;set low (ground)
;Set SENSORCHANNEL = 0
	BANKSEL	LATC
	BCF	LATC,1
;AN1298 - Step 4: Set sensor pin as input
;Set as input
;Dir SENSORCHANNEL In	
	BANKSEL	TRISC
	BSF	TRISC,1
;Set as analog
;Set ANSELC.1 = 1
	BANKSEL	ANSELC
	BSF	ANSELC,1
;AN1298 - Step 5: Select sensor channel on ADC (V-div sensor:CHOLD)
;ADC channel select -> AN5/RC1 (bits 2-6)
;Set ADCON0 = 0b00010101
	MOVLW	21
	BANKSEL	ADCON0
	MOVWF	ADCON0
;Enable ADC (bit 0)
;Delay to allow ADC voltage to stabilise
;Wait 10 us 		
	MOVLW	26
	MOVWF	DELAYTEMP
DELAYUS1
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS1
	NOP
;AN1298 - Step 6: Start ADC conversion
;SET ADFM ON
	BSF	ADCON1,ADFM
;Start ADC conversion (set go/done bit 1 = 1)
;Set ADCON0.1 = 1  	
	BSF	ADCON0,1
;Wait for ADC conversion (done bit 1 = 0)
;Wait While ADCON0.1 = 1
SYSWAITLOOP1
	BTFSC	ADCON0,1
	GOTO	SYSWAITLOOP1
;AN1298 - Step 7: Read ADC result
;ADCvalueWord = ReadAD10(AN5)
	MOVLW	5
	BANKSEL	ADREADPORT
	MOVWF	ADREADPORT
	CALL	FN_READAD108
	MOVF	SYSREADAD10WORD,W
	MOVWF	ADCVALUEWORD
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	ADCVALUEWORD_H
;Action result
;LATC = SaveLATC
	MOVF	SAVELATC,W
	BANKSEL	LATC
	MOVWF	LATC
;If ADCvalueWord > 10 Then
	BANKSEL	ADCVALUEWORD
	MOVF	ADCVALUEWORD,W
	MOVWF	SYSWORDTEMPB
	MOVF	ADCVALUEWORD_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVLW	10
	MOVWF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ELSE5_1
;If touching S3 touch button
;LED6 = 1
	BANKSEL	LATA
	BSF	LATA,2
;Else
	GOTO	ENDIF5
ELSE5_1
;LED6 = 0
	BANKSEL	LATA
	BCF	LATA,2
;End If
ENDIF5
;TRISC = SaveTRISC
	BANKSEL	SAVETRISC
	MOVF	SAVETRISC,W
	BANKSEL	TRISC
	MOVWF	TRISC
;ANSELC = SaveANSELC
	BANKSEL	SAVEANSELC
	MOVF	SAVEANSELC,W
	BANKSEL	ANSELC
	MOVWF	ANSELC
;ODCONC = SaveODCONC
	BANKSEL	SAVEODCONC
	MOVF	SAVEODCONC,W
	BANKSEL	ODCONC
	MOVWF	ODCONC
;ADCON0 = SaveADCON0
	BANKSEL	SAVEADCON0
	MOVF	SAVEADCON0,W
	BANKSEL	ADCON0
	MOVWF	ADCON0
;ADCON0.ADON = 0
	BCF	ADCON0,ADON
;IntOn
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3081)
SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;movf SysByteTempA, W
	MOVF	SYSBYTETEMPA, W
;subwf SysByteTempB, W
	SUBWF	SYSBYTETEMPB, W
;btfsc STATUS, Z
	BTFSC	STATUS, Z
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3107)
SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	MOVF	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	SUBWF	SYSWORDTEMPB, W
;btfss STATUS, Z
	BTFSS	STATUS, Z
;return
	RETURN
;Test high, exit if false
;movf SysWordTempA_H, W
	MOVF	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	SUBWF	SYSWORDTEMPB_H, W
;btfss STATUS, Z
	BTFSS	STATUS, Z
;return
	RETURN
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3161)
SYSCOMPEQUAL32
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
	BTFSS	STATUS, Z
;return
	RETURN
;Test high, exit if false
;movf SysLongTempA_H, W
	MOVF	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	SUBWF	SYSLONGTEMPB_H, W
;btfss STATUS, Z
	BTFSS	STATUS, Z
;return
	RETURN
;Test upper, exit if false
;movf SysLongTempA_U, W
	MOVF	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	SUBWF	SYSLONGTEMPB_U, W
;btfss STATUS, Z
	BTFSS	STATUS, Z
;return
	RETURN
;Test exp, exit if false
;movf SysLongTempA_E, W
	MOVF	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	SUBWF	SYSLONGTEMPB_E, W
;btfss STATUS, Z
	BTFSS	STATUS, Z
;return
	RETURN
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3416)
SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	MOVF	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	SUBWF	SYSWORDTEMPB_H,W
;btfss STATUS,C
	BTFSS	STATUS,C
;return
	RETURN
;Test high, exit true if less
;movf SysWordTempB_H,W
	MOVF	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	SUBWF	SYSWORDTEMPA_H,W
;btfss STATUS,C
	BTFSS	STATUS,C
;goto SCLT16True
	GOTO	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	MOVF	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	SUBWF	SYSWORDTEMPA,W
;btfsc STATUS,C
	BTFSC	STATUS,C
;return
	RETURN
SCLT16TRUE
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3474)
SYSCOMPLESSTHAN32
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
	BTFSS	STATUS,C
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
	BTFSS	STATUS,Z
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	MOVF	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	SUBWF	SYSLONGTEMPB_U,W
;btfss STATUS,C
	BTFSS	STATUS,C
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
	BTFSS	STATUS,Z
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	MOVF	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	SUBWF	SYSLONGTEMPB_H,W
;btfss STATUS,C
	BTFSS	STATUS,C
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
	BTFSS	STATUS,Z
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	MOVF	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	SUBWF	SYSLONGTEMPA,W
;btfsc STATUS,C
	BTFSC	STATUS,C
;return
	RETURN
SCLT32TRUE
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2864)
SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSDIVMULTA
	MOVF	SYSWORDTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	MOVF	SYSWORDTEMPB,W
	MOVWF	SYSDIVMULTB
	MOVF	SYSWORDTEMPB_H,W
	MOVWF	SYSDIVMULTB_H
;SysDivMultX = 0
	CLRF	SYSDIVMULTX
	CLRF	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	MOVF	SYSDIVMULTB,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTB_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF30
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
;exit sub
	RETURN
;end if
ENDIF30
;Main calc routine
;SysDivLoop = 16
	MOVLW	16
	MOVWF	SYSDIVLOOP
SYSDIV16START
;set C off
	BCF	STATUS,C
;Rotate SysDivMultA Left
	RLF	SYSDIVMULTA,F
	RLF	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	RLF	SYSDIVMULTX,F
	RLF	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	MOVF	SYSDIVMULTB,W
	SUBWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	SUBWFB	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	BSF	SYSDIVMULTA,0
;If C Off Then
	BTFSC	STATUS,C
	GOTO	ENDIF31
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	ADDWFC	SYSDIVMULTX_H,F
;End If
ENDIF31
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv16Start
	GOTO	SYSDIV16START
;SysWordTempA = SysDivMultA
	MOVF	SYSDIVMULTA,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTA_H,W
	MOVWF	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	MOVF	SYSDIVMULTX,W
	MOVWF	SYSWORDTEMPX
	MOVF	SYSDIVMULTX_H,W
	MOVWF	SYSWORDTEMPX_H
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2940)
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
	GOTO	ENDIF32
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA
	CLRF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
;exit sub
	RETURN
;end if
ENDIF32
;Main calc routine
;SysDivLoop = 32
	MOVLW	32
	MOVWF	SYSDIVLOOP
SYSDIV32START
;set C off
	BCF	STATUS,C
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
	MOVF	SYSLONGDIVMULTB,W
	SUBWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTB_H,W
	SUBWFB	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTB_U,W
	SUBWFB	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTB_E,W
	SUBWFB	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	BSF	SYSLONGDIVMULTA,0
;If C Off Then
	BTFSC	STATUS,C
	GOTO	ENDIF33
;Set SysLongDivMultA.0 Off
	BCF	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W
	ADDWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTB_H,W
	ADDWFC	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTB_U,W
	ADDWFC	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTB_E,W
	ADDWFC	SYSLONGDIVMULTX_E,F
;End If
ENDIF33
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

;SOURCE: SYSTEM.H (2685)
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
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	BTFSS	SYSLONGDIVMULTB,0
	GOTO	ENDIF28
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	MOVF	SYSLONGDIVMULTA,W
	ADDWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTA_H,W
	ADDWFC	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTA_U,W
	ADDWFC	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTA_E,W
	ADDWFC	SYSLONGDIVMULTX_E,F
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
ENDIF28
;set STATUS.C OFF
	BCF	STATUS,C
;rotate SysLongDivMultB right
	RRF	SYSLONGDIVMULTB_E,F
	RRF	SYSLONGDIVMULTB_U,F
	RRF	SYSLONGDIVMULTB_H,F
	RRF	SYSLONGDIVMULTB,F
;set STATUS.C off
	BCF	STATUS,C
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

;START OF PROGRAM MEMORY PAGE 1
	ORG	2048
;START OF PROGRAM MEMORY PAGE 2
	ORG	4096
;START OF PROGRAM MEMORY PAGE 3
	ORG	6144

 END
