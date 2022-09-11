;Program compiled by Great Cow BASIC (1.00.00 Release Candidate 2022-09-11 (Windows 64 bit) : Build 1168x) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18075
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18075_chiprange_demonstrations\250_pwm_variable_modes.s"
 SUBTITLE    "09-11-2022"

; Reverse lookup file(s)
; C:\Program Files\Microchip\xc8\v2.40\pic\include\proc\pic16f18075.inc
; C:\Program Files\Microchip\xc8\v2.40\pic\dat\cfgmap\16f18075.cfgmap
; Alternative CONFIG file is to be found at C:\Program Files\Microchip\xc8\vX.YY\pic\dat\cfgdata as per Microchip support ticket #00730936 

;********************************************************************************

;********************************************************************************
;Explicit CONFIG
 CONFIG CLKOUTEN=OFF                             ;C1 Reverselookup CLKOUTEN = OFF
 CONFIG RSTOSC=HFINTOSC_32MHz                    ;C1 Reverselookup RSTOSC = HFINTOSC_32MHZ
 CONFIG FEXTOSC=OFF                              ;C1 Reverselookup FEXTOSC = OFF
 CONFIG WDTE=OFF                                 ;C1 Reverselookup WDTE = OFF
 CONFIG MCLRE=INTMCLR                            ;C1 Reverselookup MCLRE = INTMCLR
 CONFIG LVP=OFF                                  ;C1 Reverselookup LVP = OFF
 CONFIG WRTSAF=OFF                               ;C1 Reverselookup WRTSAF = OFF
 CONFIG WRTD=OFF                                 ;C1 Reverselookup WRTD = OFF
 CONFIG WRTB=OFF                                 ;C1 Reverselookup WRTB = OFF
 CONFIG CPD=OFF                                  ;C1 Reverselookup CPD = OFF
 CONFIG CP=OFF                                   ;C1 Reverselookup CP = OFF
;Inferred CONFIG


;********************************************************************************
; The XC8 xc.inc include file.  This MUST be placed after the CONFIG statements.

 #include <xc.inc>

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
GLOBAL	CCPCONCACHE
 CCPCONCACHE                      EQU 32          ; 0X20
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 112          ; 0X70
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 113          ; 0X71
GLOBAL	MYDUTY
 MYDUTY                           EQU 33          ; 0X21
GLOBAL	MYFREQUENCY
 MYFREQUENCY                      EQU 34          ; 0X22
GLOBAL	PRX_TEMP
 PRX_TEMP                         EQU 35          ; 0X23
GLOBAL	PRX_TEMP_CACHE
 PRX_TEMP_CACHE                   EQU 39          ; 0X27
GLOBAL	PRX_TEMP_CACHE_E
 PRX_TEMP_CACHE_E                 EQU 42          ; 0X2A
GLOBAL	PRX_TEMP_CACHE_H
 PRX_TEMP_CACHE_H                 EQU 40          ; 0X28
GLOBAL	PRX_TEMP_CACHE_U
 PRX_TEMP_CACHE_U                 EQU 41          ; 0X29
GLOBAL	PRX_TEMP_E
 PRX_TEMP_E                       EQU 38          ; 0X26
GLOBAL	PRX_TEMP_H
 PRX_TEMP_H                       EQU 36          ; 0X24
GLOBAL	PRX_TEMP_U
 PRX_TEMP_U                       EQU 37          ; 0X25
GLOBAL	PWMCHANNEL
 PWMCHANNEL                       EQU 43          ; 0X2B
GLOBAL	PWMDUTY
 PWMDUTY                          EQU 44          ; 0X2C
GLOBAL	PWMDUTY_H
 PWMDUTY_H                        EQU 45          ; 0X2D
GLOBAL	PWMFREQ
 PWMFREQ                          EQU 46          ; 0X2E
GLOBAL	PWMFREQ_H
 PWMFREQ_H                        EQU 47          ; 0X2F
GLOBAL	PWMRESOLUTION
 PWMRESOLUTION                    EQU 48          ; 0X30
GLOBAL	PWMRESOLUTION_H
 PWMRESOLUTION_H                  EQU 49          ; 0X31
GLOBAL	SYSBYTETEMPX
 SYSBYTETEMPX                     EQU 112          ; 0X70
GLOBAL	SYSDIVLOOP
 SYSDIVLOOP                       EQU 116          ; 0X74
GLOBAL	SYSDIVMULTA
 SYSDIVMULTA                      EQU 119          ; 0X77
GLOBAL	SYSDIVMULTA_H
 SYSDIVMULTA_H                    EQU 120          ; 0X78
GLOBAL	SYSFORLOOPSTEP1
 SYSFORLOOPSTEP1                  EQU 50          ; 0X32
GLOBAL	SYSFORLOOPSTEP1_H
 SYSFORLOOPSTEP1_H                EQU 51          ; 0X33
GLOBAL	SYSINTEGERTEMPA
 SYSINTEGERTEMPA                  EQU 117          ; 0X75
GLOBAL	SYSINTEGERTEMPA_H
 SYSINTEGERTEMPA_H                EQU 118          ; 0X76
GLOBAL	SYSINTEGERTEMPB
 SYSINTEGERTEMPB                  EQU 121          ; 0X79
GLOBAL	SYSINTEGERTEMPB_H
 SYSINTEGERTEMPB_H                EQU 122          ; 0X7A
GLOBAL	SYSLONGDIVMULTA
 SYSLONGDIVMULTA                  EQU 52          ; 0X34
GLOBAL	SYSLONGDIVMULTA_E
 SYSLONGDIVMULTA_E                EQU 55          ; 0X37
GLOBAL	SYSLONGDIVMULTA_H
 SYSLONGDIVMULTA_H                EQU 53          ; 0X35
GLOBAL	SYSLONGDIVMULTA_U
 SYSLONGDIVMULTA_U                EQU 54          ; 0X36
GLOBAL	SYSLONGDIVMULTB
 SYSLONGDIVMULTB                  EQU 56          ; 0X38
GLOBAL	SYSLONGDIVMULTB_E
 SYSLONGDIVMULTB_E                EQU 59          ; 0X3B
GLOBAL	SYSLONGDIVMULTB_H
 SYSLONGDIVMULTB_H                EQU 57          ; 0X39
GLOBAL	SYSLONGDIVMULTB_U
 SYSLONGDIVMULTB_U                EQU 58          ; 0X3A
GLOBAL	SYSLONGDIVMULTX
 SYSLONGDIVMULTX                  EQU 60          ; 0X3C
GLOBAL	SYSLONGDIVMULTX_E
 SYSLONGDIVMULTX_E                EQU 63          ; 0X3F
GLOBAL	SYSLONGDIVMULTX_H
 SYSLONGDIVMULTX_H                EQU 61          ; 0X3D
GLOBAL	SYSLONGDIVMULTX_U
 SYSLONGDIVMULTX_U                EQU 62          ; 0X3E
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
GLOBAL	SYSREPEATTEMP1
 SYSREPEATTEMP1                   EQU 64          ; 0X40
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 65          ; 0X41
GLOBAL	SYSTEMP1_E
 SYSTEMP1_E                       EQU 68          ; 0X44
GLOBAL	SYSTEMP1_H
 SYSTEMP1_H                       EQU 66          ; 0X42
GLOBAL	SYSTEMP1_U
 SYSTEMP1_U                       EQU 67          ; 0X43
GLOBAL	SYSTEMP2
 SYSTEMP2                         EQU 69          ; 0X45
GLOBAL	SYSTEMP2_H
 SYSTEMP2_H                       EQU 70          ; 0X46
GLOBAL	SYSTEMP3
 SYSTEMP3                         EQU 71          ; 0X47
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73
GLOBAL	TIMERSELECTIONBITS
 TIMERSELECTIONBITS               EQU 72          ; 0X48
GLOBAL	TX_PR
 TX_PR                            EQU 73          ; 0X49
GLOBAL	_PWMTIMERSELECTED
 _PWMTIMERSELECTED                EQU 74          ; 0X4A

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
	CALL	INITPPS
	CALL	INITPWM

;START OF THE MAIN PROGRAM
;''
;''This program shows how to use PWM to provide 250Hz at 50% for 16Khz chip frequency
;''
;''@author     EvanV
;''@licence    GPL
;''@version    1.01
;''@date       15/09/2022
;''********************************************************************************
;Generated by PIC PPS Tool for Great Cow Basic
;PPS Tool version: 0.0.6.1
;PinManager data: v1.79.0
;Generated for 16F18075
;
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------------------------
;'-----------------------------------------
;'
;' -------------------PORTB----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    --------IN-LED--LED-LED LED -----
;'-----------------------------------------
;'
;' ------------------PORTC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ----TX---------------------------
;'-----------------------------------------
;'
;' ------------------PORTE-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ----------------RST--------------
;'-----------------------------------------
;'
;Define constants to make things easier. We can reuse these at any time.
;Dir     LEDD1         Out
	BCF	TRISB,1
;Dir     LEDD2         Out
	BCF	TRISB,2
;Dir     LEDD3         Out
	BCF	TRISB,3
;Dir     LEDD4         Out
	BCF	TRISB,4
;Dir     POTENTIOMETER In
	BSF	TRISA,0
;Dir     SWITCHIN      In
	BSF	TRISB,5
;analogue port selection
;------ Start of main Program
;Dim myDuty, myFrequency As Byte
;myFrequency = 80
	MOVLW	80
	MOVWF	MYFREQUENCY
;start at 50%
;myDuty = 50
	MOVLW	50
	MOVWF	MYDUTY
;Do Forever
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;For myDuty = 0 To 255
;LEGACY METHOD
	MOVLW	255
	MOVWF	MYDUTY
GLOBAL	SYSFORLOOP1
SYSFORLOOP1:
	INCF	MYDUTY,F
;Wait 10 ms
	MOVLW	10
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;HPWM ( HPWM4, myFrequency, myDuty, 2  )
	MOVLW	4
	MOVWF	PWMCHANNEL
	MOVF	MYFREQUENCY,W
	MOVWF	PWMFREQ
	CLRF	PWMFREQ_H
	MOVF	MYDUTY,W
	MOVWF	PWMDUTY
	CLRF	PWMDUTY_H
	MOVLW	2
	MOVWF	_PWMTIMERSELECTED
	MOVLW	255
	MOVWF	PWMRESOLUTION
	CLRF	PWMRESOLUTION_H
	CALL	HPWM26
;HPWM ( HPWM3, myFrequency, 255-myDuty, 2  )
	MOVLW	3
	MOVWF	PWMCHANNEL
	MOVF	MYFREQUENCY,W
	MOVWF	PWMFREQ
	CLRF	PWMFREQ_H
	MOVF	MYDUTY,W
	SUBLW	255
	MOVWF	PWMDUTY
	CLRF	PWMDUTY_H
	BTFSS	STATUS,0
	DECF	PWMDUTY_H,F
	MOVLW	2
	MOVWF	_PWMTIMERSELECTED
	MOVLW	255
	MOVWF	PWMRESOLUTION
	CLRF	PWMRESOLUTION_H
	CALL	HPWM26
;Next
	MOVLW	255
	SUBWF	MYDUTY,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
GLOBAL	SYSFORLOOPEND1
SYSFORLOOPEND1:
;For myDuty = 254 To 1 step -1
	MOVLW	254
	MOVWF	MYDUTY
GLOBAL	SYSFORLOOP2
SYSFORLOOP2:
;INIT SYSFORLOOPSTEP1 :#0
	MOVLW	255
	MOVWF	SYSFORLOOPSTEP1
	MOVWF	SYSFORLOOPSTEP1_H
;Wait 10 ms
	MOVLW	10
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;HPWM ( HPWM4, myFrequency, myDuty, 2  )
	MOVLW	4
	MOVWF	PWMCHANNEL
	MOVF	MYFREQUENCY,W
	MOVWF	PWMFREQ
	CLRF	PWMFREQ_H
	MOVF	MYDUTY,W
	MOVWF	PWMDUTY
	CLRF	PWMDUTY_H
	MOVLW	2
	MOVWF	_PWMTIMERSELECTED
	MOVLW	255
	MOVWF	PWMRESOLUTION
	CLRF	PWMRESOLUTION_H
	CALL	HPWM26
;HPWM ( HPWM3, myFrequency, 255-myDuty, 2  )
	MOVLW	3
	MOVWF	PWMCHANNEL
	MOVF	MYFREQUENCY,W
	MOVWF	PWMFREQ
	CLRF	PWMFREQ_H
	MOVF	MYDUTY,W
	SUBLW	255
	MOVWF	PWMDUTY
	CLRF	PWMDUTY_H
	BTFSS	STATUS,0
	DECF	PWMDUTY_H,F
	MOVLW	2
	MOVWF	_PWMTIMERSELECTED
	MOVLW	255
	MOVWF	PWMRESOLUTION
	CLRF	PWMRESOLUTION_H
	CALL	HPWM26
;Next
;INTEGER NEGATIVE STEP HANDLER IN FOR-NEXT STATEMENT
	BTFSS	SYSFORLOOPSTEP1_H,7
	GOTO	ELSE2_1
;IF ( MYDUTY - 1) } -SYSFORLOOPSTEP1 THEN :#3N
	DECF	MYDUTY,W
	MOVWF	SYSTEMP1
	COMF	SYSFORLOOPSTEP1,W
	MOVWF	SYSTEMP2
	COMF	SYSFORLOOPSTEP1_H,W
	MOVWF	SYSTEMP2_H
	INCF	SYSTEMP2,F
	BTFSC	STATUS,2
	INCF	SYSTEMP2_H,F
	MOVF	SYSTEMP1,W
	MOVWF	SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H
	MOVF	SYSTEMP2,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	SYSTEMP2_H,W
	MOVWF	SYSINTEGERTEMPB_H
	CALL	SYSCOMPLESSTHANINT
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF3
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A NEGATIVE VALUE
	MOVF	SYSFORLOOPSTEP1,W
	ADDWF	MYDUTY,F
	GOTO	SYSFORLOOP2
;END IF
GLOBAL	ENDIF3
ENDIF3:
	GOTO	ENDIF2
GLOBAL	ELSE2_1
ELSE2_1:
;INTEGER POSITIVE STEP HANDLER IN FOR-NEXT STATEMENT
;IF (1 - MYDUTY) } SYSFORLOOPSTEP1 THEN :#3P
	MOVF	MYDUTY,W
	SUBLW	1
	MOVWF	SYSTEMP1
	MOVWF	SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H
	MOVF	SYSFORLOOPSTEP1,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	SYSFORLOOPSTEP1_H,W
	MOVWF	SYSINTEGERTEMPB_H
	CALL	SYSCOMPLESSTHANINT
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF4
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	MOVF	SYSFORLOOPSTEP1,W
	ADDWF	MYDUTY,F
	GOTO	SYSFORLOOP2
;END IF
GLOBAL	ENDIF4
ENDIF4:
;END IF
GLOBAL	ENDIF2
ENDIF2:
GLOBAL	SYSFORLOOPEND2
SYSFORLOOPEND2:
;Loop
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
;End
	GOTO	BASPROGRAMEND
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: PWM.H (4459)
GLOBAL	CALCULATEDUTY
CALCULATEDUTY:
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
	BCF	STATUS,0
;Repeat 2
	MOVLW	2
	MOVWF	SYSREPEATTEMP1
GLOBAL	SYSREPEATLOOP1
SYSREPEATLOOP1:
;rotate PRx_Temp left
	RLF	PRX_TEMP,F
	RLF	PRX_TEMP_H,F
	RLF	PRX_TEMP_U,F
	RLF	PRX_TEMP_E,F
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
GLOBAL	SYSREPEATLOOPEND1
SYSREPEATLOOPEND1:
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
	BCF	STATUS,0
;Repeat 6
	MOVLW	6
	MOVWF	SYSREPEATTEMP1
GLOBAL	SYSREPEATLOOP2
SYSREPEATLOOP2:
;rotate PRx_Temp left
	RLF	PRX_TEMP,F
	RLF	PRX_TEMP_H,F
	RLF	PRX_TEMP_U,F
	RLF	PRX_TEMP_E,F
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP2
GLOBAL	SYSREPEATLOOPEND2
SYSREPEATLOOPEND2:
;exits with PRx_Temp calculated
	RETURN

;********************************************************************************

GLOBAL	DELAY_MS
DELAY_MS:
	INCF	SYSWAITTEMPMS_H, F
GLOBAL	DMS_START
DMS_START:
	MOVLW	108
	MOVWF	DELAYTEMP2
GLOBAL	DMS_OUTER
DMS_OUTER:
	MOVLW	11
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

;OVERLOADED SIGNATURE: BYTE:WORD:BYTE:BYTE:WORD:, SOURCE: PWM.H (3306)
GLOBAL	HPWM26
HPWM26:
;dim PWMDuty as word
;HPWM ( PWMChannel, PWMFreq, [word]PWMDuty, _PWMTimerSelected, PWMResolution  )
	GOTO	HPWM27

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:WORD:WORD:BYTE:WORD:, SOURCE: PWM.H (3313)
GLOBAL	HPWM27
HPWM27:
;Dim PRx_Temp as LONG
;Dim TimerSelectionBits as byte
;If HPWM_FAST operation selected, only recalculate duty timer prescaler when
;needed.
;Commence calculations of PMW parameters
;This figures out Postscaler required.  We can set to 1, 4 or 16 to set Tx_PR
;So, start with 1 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 4
;So, using 4 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 16
;So, using 16
;This simply sets up Tx_PR to 1,4 or 16
;PRx_Temp  = PWMOsc1 / PWMFreq
	MOVLW	160
	MOVWF	SYSLONGTEMPA
	MOVLW	15
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
	BTFSC	STATUS,0
	GOTO	ENDIF5
;Tx_PR = 4
	MOVLW	4
	MOVWF	TX_PR
;Divide by 4
;set STATUS.C off
	BCF	STATUS,0
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;set STATUS.C off
	BCF	STATUS,0
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;end if
GLOBAL	ENDIF5
ENDIF5:
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
	BTFSC	STATUS,0
	GOTO	ENDIF6
;Tx_PR = 16
	MOVLW	16
	MOVWF	TX_PR
;Divide by 4
;set STATUS.C off
	BCF	STATUS,0
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;set STATUS.C off
	BCF	STATUS,0
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;end if
GLOBAL	ENDIF6
ENDIF6:
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
	BTFSC	STATUS,0
	GOTO	ENDIF7
;Tx_PR = 64
	MOVLW	64
	MOVWF	TX_PR
;Divide by 4
;set STATUS.C off
	BCF	STATUS,0
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;set STATUS.C off
	BCF	STATUS,0
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;end if
GLOBAL	ENDIF7
ENDIF7:
;This section setups the timer
;Set up PRx dependent on timer selected
;Select Case _PWMTimerSelected
;case 2 'Select timer2 as the driver for PWM
GLOBAL	SYSSELECT1CASE1
SYSSELECT1CASE1:
	MOVLW	2
	SUBWF	_PWMTIMERSELECTED,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE2
;Set PR2
;PR2 = PRx_Temp  'This is required in the next sction of code, and as will not know which timer has been selected
	MOVF	PRX_TEMP,W
	BANKSEL	T2PR
	MOVWF	T2PR
;Set Clock Source
;Set to FOSC/4 for backward compatibility
;#ifdef var(T2CLKCON): T2CLKCON = 0x01: #ENDIF
	MOVLW	1
	MOVWF	T2CLKCON
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
	BCF	T2CON,4
;SET T2CKPS1 OFF
	BCF	T2CON,5
;SET T2CKPS2 OFF
	BCF	T2CON,6
;Set Prescaler bits
;if Tx_PR = 4  then SET T2CKPS1 ON
	MOVLW	4
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
	BTFSS	STATUS,2
	GOTO	ENDIF8
;if Tx_PR = 4  then SET T2CKPS1 ON
	BANKSEL	T2CON
	BSF	T2CON,5
;if Tx_PR = 4  then SET T2CKPS1 ON
GLOBAL	ENDIF8
ENDIF8:
;if Tx_PR = 16 then SET T2CKPS2 ON
	MOVLW	16
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
	BTFSS	STATUS,2
	GOTO	ENDIF9
;if Tx_PR = 16 then SET T2CKPS2 ON
	BANKSEL	T2CON
	BSF	T2CON,6
;if Tx_PR = 16 then SET T2CKPS2 ON
GLOBAL	ENDIF9
ENDIF9:
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	MOVLW	64
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
	BTFSS	STATUS,2
	GOTO	ENDIF10
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	BANKSEL	T2CON
	BSF	T2CON,6
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	BSF	T2CON,5
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
GLOBAL	ENDIF10
ENDIF10:
;Clearing IF flag.
;SET TMR2IF OFF
	BANKSEL	PIR1
	BCF	PIR1,7
;Start Timer2
;SET TMR2ON ON
	BANKSEL	T2CON
	BSF	T2CON,7
;case 4
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE2
SYSSELECT1CASE2:
	MOVLW	4
	SUBWF	_PWMTIMERSELECTED,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE3
;Set PR4
;PR4 = PRx_Temp  'This is required in the next sction of code, and as will not know which timer has been selected
	MOVF	PRX_TEMP,W
	BANKSEL	T4PR
	MOVWF	T4PR
;Set Clock Source
;Set to FOSC/4 for backward compatibility
;#ifdef var(T4CLKCON): T4CLKCON = 0x01: #ENDIF
	MOVLW	1
	MOVWF	T4CLKCON
;T4PSYNC Not Synchronized; T4MODE Software control; T4CKPOL Rising Edge; T4CKSYNC Not Synchronized
;T4HLT = 0x00
;#ifdef var(T4HLT): T4HLT = 0x00: #ENDIF
	CLRF	T4HLT
;T4RSEL T4CKIPPS pin
;T4RST = 0x00
;#ifdef var(T4RST): T4RST = 0x00: #ENDIF
	CLRF	T4RST
;TMR4. Holding Register for the 8-bit TMR4` Register
;T4TMR = 0x00
;#ifdef var(T4TMR): T4TMR = 0x00: #ENDIF
	CLRF	T4TMR
;SET T4CKPS0 OFF
	BCF	T4CON,4
;SET T4CKPS1 OFF
	BCF	T4CON,5
;SET T4CKPS2 OFF
	BCF	T4CON,6
;Set Prescaler bits
;if Tx_PR = 4  then SET T4CKPS1 ON
	MOVLW	4
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
	BTFSS	STATUS,2
	GOTO	ENDIF11
;if Tx_PR = 4  then SET T4CKPS1 ON
	BANKSEL	T4CON
	BSF	T4CON,5
;if Tx_PR = 4  then SET T4CKPS1 ON
GLOBAL	ENDIF11
ENDIF11:
;if Tx_PR = 16 then SET T4CKPS2 ON
	MOVLW	16
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
	BTFSS	STATUS,2
	GOTO	ENDIF12
;if Tx_PR = 16 then SET T4CKPS2 ON
	BANKSEL	T4CON
	BSF	T4CON,6
;if Tx_PR = 16 then SET T4CKPS2 ON
GLOBAL	ENDIF12
ENDIF12:
;if Tx_PR = 64 then SET T4CKPS2 ON: SET T4CKPS1 ON
	MOVLW	64
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
	BTFSS	STATUS,2
	GOTO	ENDIF13
;if Tx_PR = 64 then SET T4CKPS2 ON: SET T4CKPS1 ON
	BANKSEL	T4CON
	BSF	T4CON,6
;if Tx_PR = 64 then SET T4CKPS2 ON: SET T4CKPS1 ON
	BSF	T4CON,5
;if Tx_PR = 64 then SET T4CKPS2 ON: SET T4CKPS1 ON
GLOBAL	ENDIF13
ENDIF13:
;Clearing IF flag.
;SET TMR4IF OFF
	BANKSEL	PIR2
	BCF	PIR2,0
;Start Timer2
;SET TMR4ON ON
	BANKSEL	T4CON
	BSF	T4CON,7
;case 6
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE3
SYSSELECT1CASE3:
	MOVLW	6
	SUBWF	_PWMTIMERSELECTED,W
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND1
;Set PR6
;PR6 = PRx_Temp  'This is required in the next sction of code, and will not know which timer has been selected
	MOVF	PRX_TEMP,W
	BANKSEL	T6PR
	MOVWF	T6PR
;Set Clock Source
;Set to FOSC/4 for backward compatibility
;#ifdef var(T6CLKCON): T6CLKCON = 0x01: #ENDIF
	MOVLW	1
	MOVWF	T6CLKCON
;T6PSYNC Not Synchronized; T6MODE Software control; T6CKPOL Rising Edge; T6CKSYNC Not Synchronized
;T6HLT = 0x00
;#ifdef var(T6HLT): T6HLT = 0x00: #ENDIF
	CLRF	T6HLT
;T6RSEL T6CKIPPS pin
;T6RST = 0x00
;#ifdef var(T6RST): T6RST = 0x00: #ENDIF
	CLRF	T6RST
;TMR6.  Holding Register for the 8-bit TMR6 Register
;T6TMR = 0x00
;#ifdef var(T6TMR): T6TMR = 0x00: #ENDIF
	CLRF	T6TMR
;SET T6CKPS0 OFF
	BCF	T6CON,4
;SET T6CKPS1 OFF
	BCF	T6CON,5
;SET T6CKPS2 OFF
	BCF	T6CON,6
;Set Prescaler bits
;if Tx_PR = 4  then SET T6CKPS1 ON
	MOVLW	4
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
	BTFSS	STATUS,2
	GOTO	ENDIF14
;if Tx_PR = 4  then SET T6CKPS1 ON
	BANKSEL	T6CON
	BSF	T6CON,5
;if Tx_PR = 4  then SET T6CKPS1 ON
GLOBAL	ENDIF14
ENDIF14:
;if Tx_PR = 16 then SET T6CKPS2 ON
	MOVLW	16
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
	BTFSS	STATUS,2
	GOTO	ENDIF15
;if Tx_PR = 16 then SET T6CKPS2 ON
	BANKSEL	T6CON
	BSF	T6CON,6
;if Tx_PR = 16 then SET T6CKPS2 ON
GLOBAL	ENDIF15
ENDIF15:
;if Tx_PR = 64 then SET T6CKPS2 ON: SET T6CKPS1 ON
	MOVLW	64
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
	BTFSS	STATUS,2
	GOTO	ENDIF16
;if Tx_PR = 64 then SET T6CKPS2 ON: SET T6CKPS1 ON
	BANKSEL	T6CON
	BSF	T6CON,6
;if Tx_PR = 64 then SET T6CKPS2 ON: SET T6CKPS1 ON
	BSF	T6CON,5
;if Tx_PR = 64 then SET T6CKPS2 ON: SET T6CKPS1 ON
GLOBAL	ENDIF16
ENDIF16:
;Clearing IF flag.
;SET TMR6IF OFF
	BANKSEL	PIR2
	BCF	PIR2,1
;Start Timer6
;SET TMR6ON ON
	BANKSEL	T6CON
	BSF	T6CON,7
;End Select
GLOBAL	SYSSELECTEND1
SYSSELECTEND1:
GLOBAL	TENBITPMWSECTION
TENBITPMWSECTION:
;This section setups up the PWM Duty
;The following code can be optimised via 'defines'
;Dim PRx_Temp_Cache as Long
;Cache the PRx_Temp value ONLY when NOT HPWM_FAST - this can be then used by HPWMUpdate
;PRx_Temp_Cache = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
	MOVWF	PRX_TEMP_CACHE
	MOVF	PRX_TEMP_H,W
	MOVWF	PRX_TEMP_CACHE_H
	MOVF	PRX_TEMP_U,W
	MOVWF	PRX_TEMP_CACHE_U
	MOVF	PRX_TEMP_E,W
	MOVWF	PRX_TEMP_CACHE_E
;if PWMChannel = 3 then  'in section USE_HPWM3
	MOVLW	3
	SUBWF	PWMCHANNEL,W
	BTFSS	STATUS,2
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
;TimerSelectionBits =  (_PWMTimerSelected / 2 ) 'This is a ChipPWMTimerVariant chip.  Move the timer bits to the left by one bit to cater for different addressing
	BCF	STATUS,0
	BANKSEL	_PWMTIMERSELECTED
	RRF	_PWMTIMERSELECTED,W
	MOVWF	TIMERSELECTIONBITS
;Start PMW3
;Set PWM3EN On
	BANKSEL	PWM3CON
	BSF	PWM3CON,7
;End if
GLOBAL	ENDIF17
ENDIF17:
;if PWMChannel = 4 then  'in section USE_HPWM4
	MOVLW	4
	BANKSEL	PWMCHANNEL
	SUBWF	PWMCHANNEL,W
	BTFSS	STATUS,2
	GOTO	ENDIF18
;calculates duty, assisgns duty to  bits 15-8 and 7-6 of PMWxDH(H&L) and links this PWM to the correct timer
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	CALL	CALCULATEDUTY
;PWM4DCH = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
	BANKSEL	PWM4DCH
	MOVWF	PWM4DCH
;PWM4DCL = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
	BANKSEL	PWM4DCL
	MOVWF	PWM4DCL
;Select timer by updating CCPTMRS1 register
;TimerSelectionBits =  (_PWMTimerSelected / 2 ) 'This is a ChipPWMTimerVariant chip.  Move the timer bits to the left by one bit to cater for different addressing
	BCF	STATUS,0
	BANKSEL	_PWMTIMERSELECTED
	RRF	_PWMTIMERSELECTED,W
	MOVWF	TIMERSELECTIONBITS
;Start PMW4
;Set PWM4EN On
	BANKSEL	PWM4CON
	BSF	PWM4CON,7
;End if
GLOBAL	ENDIF18
ENDIF18:
;if PWMChannel = 5 then  'in section USE_HPWM5
	MOVLW	5
	BANKSEL	PWMCHANNEL
	SUBWF	PWMCHANNEL,W
	BTFSS	STATUS,2
	GOTO	ENDIF19
;calculates duty, assisgns duty to  bits 15-8 and 7-6 of PMWxDH(H&L) and links this PWM to the correct timer
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	CALL	CALCULATEDUTY
;PWM5DCH = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
	BANKSEL	PWM5DCH
	MOVWF	PWM5DCH
;PWM5DCL = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
	BANKSEL	PWM5DCL
	MOVWF	PWM5DCL
;Select timer by updating CCPTMRS1 register
;Start PMW5
;Set PWM5EN On
	BSF	PWM5CON,7
;End if
GLOBAL	ENDIF19
ENDIF19:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: 250_PWM_VARIABLE_MODES.GCB (22)
GLOBAL	INITPPS
INITPPS:
;RB2PPS = 0x0C;  //RB2->PWM4:PWM4;
	MOVLW	12
	BANKSEL	RB2PPS
	MOVWF	RB2PPS
;RB1PPS = 0x0B;  //RB1->PWM3:PWM3;
	MOVLW	11
	MOVWF	RB1PPS
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: PWM.H (237)
GLOBAL	INITPWM
INITPWM:
;_PWMTimerSelected = 2
	MOVLW	2
	MOVWF	_PWMTIMERSELECTED
;Dim PRx_Temp as LONG
;Script to calculate constants required for given Frequency and Duty Cycle
GLOBAL	LEGACY_STARTOFFIXEDCCPPWMMODECODE
LEGACY_STARTOFFIXEDCCPPWMMODECODE:
;You can disable all the legacy CCPPWM fixed mode code to reduce program size
;This section is Library code, so it generates ASM
;This section uses the constants defined the script above.
;Essentially, sets CCPCONCache with the bits set correctly.
;And, timer 2.  Remember timer 2 can be the timer for CCP/PWM but the other timers can be specified for certain parts.
;If CCP1CON does not exist then there is NO CCP1 so no point in setting, as all this is to set up the CCP1 using constants method
;DIM CCPCONCache as BYTE
;CCPCONCache = 0
	CLRF	CCPCONCACHE
;Set PWM Period
;PR2 = PR2_CPP_PWM_Temp
	MOVLW	105
	BANKSEL	T2PR
	MOVWF	T2PR
;SET T2CON.T2CKPS0 OFF
	BCF	T2CON,4
;SET T2CON.T2CKPS1 OFF
	BCF	T2CON,5
;SET T2CON.T2CKPS2 OFF
	BCF	T2CON,6
;Set Duty cycle
;CCPCONCache.CCP1FMT = 1
	BANKSEL	CCPCONCACHE
	BSF	CCPCONCACHE,4
;CCPR1H = DutyCycleH
	MOVLW	53
	BANKSEL	CCPR1H
	MOVWF	CCPR1H
;CCPR1L = DutyCycleL*64
	CLRF	CCPR1L
;[canskip]T2CLKCON = 1
	MOVLW	1
	BANKSEL	T2CLKCON
	MOVWF	T2CLKCON
;[canskip]CCPCONCache.en = 1
	BANKSEL	CCPCONCACHE
	BSF	CCPCONCACHE,7
;legacy code, replaced by canskip
;Finish preparing CCP*CON
;SET CCPCONCache.CCP1M3 ON
;SET CCPCONCache.CCP1M2 ON
;SET CCPCONCache.CCP1M1 OFF
;SET CCPCONCache.CCP1M0 OFF'
;CCPCONCache.CCP1M3, CCPCONCache.CCP1M2, CCPCONCache.CCP1M1, CCPCONCache.CCP1M0 = b'1100'
	BSF	CCPCONCACHE,3
	BSF	CCPCONCACHE,2
	BCF	CCPCONCACHE,1
	BCF	CCPCONCACHE,0
;Enable Timer 2
;SET T2CON.TMR2ON ON
	BANKSEL	T2CON
	BSF	T2CON,7
;This is the end of script section, now we use the constants created to updated registers.
GLOBAL	STARTOFFIXEDPWMMODECODE
STARTOFFIXEDPWMMODECODE:
;Set registers using the constants from script
;This is repeated for timer 2, 4 and 6 - and the two timer variants and the 9 PWM channels
;This uses the user defined constants to set the appropiate registers.
GLOBAL	SETPWMDUTYCODE
SETPWMDUTYCODE:
;This section finally, sets the Duty using the constants from the script.
;This uses the user defined constants to set the appropiate registers.
GLOBAL	REV2018_ENDOFFIXEDPWMMODECODE
REV2018_ENDOFFIXEDPWMMODECODE:
;This is the end of the fixed PWM Mode handler
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (159)
GLOBAL	INITSYS
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;OSCCON2 = 0
	BANKSEL	OSCCON2
	CLRF	OSCCON2
;OSCCON3 = 0
	CLRF	OSCCON3
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F180xx MCU family 16 mhz
;OSCFRQ = 0b00000100
	MOVLW	4
	MOVWF	OSCFRQ
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	BANKSEL	ADCON0
	BCF	ADCON0,2
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	BCF	ADCON0,7
;ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA
;ANSELB = 0
	CLRF	ANSELB
;ANSELC = 0
	CLRF	ANSELC
;ANSELD = 0
	CLRF	ANSELD
;ANSELE = 0
	CLRF	ANSELE
;Set comparator register bits for many MCUs with register CM2CON0
;C1EN = 0
	BANKSEL	CM1CON0
	BCF	CM1CON0,7
;
;'Turn off all ports
;PORTA = 0
	BANKSEL	PORTA
	CLRF	PORTA
;PORTB = 0
	CLRF	PORTB
;PORTC = 0
	CLRF	PORTC
;PORTD = 0
	CLRF	PORTD
;PORTE = 0
	CLRF	PORTE
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

;SOURCE: SYSTEM.H (3714)
GLOBAL	SYSCOMPLESSTHANINT
SYSCOMPLESSTHANINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	CLRF	SYSBYTETEMPX
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	BTFSS	SYSINTEGERTEMPA_H,7
	GOTO	ELSE24_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	BTFSC	SYSINTEGERTEMPB_H,7
	GOTO	ENDIF25
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	COMF	SYSBYTETEMPX,F
;Exit Sub
	RETURN
;End If
GLOBAL	ENDIF25
ENDIF25:
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	COMF	SYSINTEGERTEMPA,W
	MOVWF	SYSDIVMULTA
	COMF	SYSINTEGERTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
	INCF	SYSDIVMULTA,F
	BTFSC	STATUS,2
	INCF	SYSDIVMULTA_H,F
;SysIntegerTempA = -SysIntegerTempB
	COMF	SYSINTEGERTEMPB,W
	MOVWF	SYSINTEGERTEMPA
	COMF	SYSINTEGERTEMPB_H,W
	MOVWF	SYSINTEGERTEMPA_H
	INCF	SYSINTEGERTEMPA,F
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPA_H,F
;SysIntegerTempB = SysDivMultA
	MOVF	SYSDIVMULTA,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	SYSDIVMULTA_H,W
	MOVWF	SYSINTEGERTEMPB_H
;+A
;Else
	GOTO	ENDIF24
GLOBAL	ELSE24_1
ELSE24_1:
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	BTFSC	SYSINTEGERTEMPB_H,7
;Exit Sub
	RETURN
;End If
;End If
GLOBAL	ENDIF24
ENDIF24:
;Test High, exit if more
;movf SysIntegerTempA_H,W
	MOVF	SYSINTEGERTEMPA_H,W
;subwf SysIntegerTempB_H,W
	SUBWF	SYSINTEGERTEMPB_H,W
;btfss STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	MOVF	SYSINTEGERTEMPB_H,W
;subwf SysIntegerTempA_H,W
	SUBWF	SYSINTEGERTEMPA_H,W
;btfss STATUS,C
	BTFSS	STATUS,0
;goto SCLTIntTrue
	GOTO	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	MOVF	SYSINTEGERTEMPB,W
;subwf SysIntegerTempA,W
	SUBWF	SYSINTEGERTEMPA,W
;btfsc STATUS,C
	BTFSC	STATUS,0
;return
	RETURN
GLOBAL	SCLTINTTRUE
SCLTINTTRUE:
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
	BTFSC	STATUS,0
	GOTO	ENDIF23
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
	GOTO	ENDIF20
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
GLOBAL	ENDIF20
ENDIF20:
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

;START OF PROGRAM MEMORY PAGE 1
	PSECT	PROGMEM1,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	2048
;START OF PROGRAM MEMORY PAGE 2
	PSECT	PROGMEM2,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	4096
;START OF PROGRAM MEMORY PAGE 3
	PSECT	PROGMEM3,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	6144
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
