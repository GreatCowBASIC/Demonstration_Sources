;Program compiled by GCBASIC (2026.08.07 (Windows 64 bit) : Build 1617) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-08-15 CRC247
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\245_use_pwm_via_ccp_and_adc_to_control_led_brightness.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\245_use_pwm_via_ccp_and_adc_to_control_led_brightness.build\245_use_pwm_via_ccp_and_adc_to_control_led_brightness.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\245_use_pwm_via_ccp_and_adc_to_control_led_brightness.gcb"
 SUBTITLE    "08-17-2026 12:39:38"
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
 CONFIG  MCLRE = EXTMCLR
 CONFIG  FCMEN = ON
 CONFIG  CLKOUTEN = OFF
 CONFIG  RSTOSC = HFINTOSC_1MHZ
 CONFIG  FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
ADCVAL                           EQU    1293          ; 0x50D (SA)
ADREADPORT                       EQU    1294          ; 0x50E (SA)
CCPCONCACHE                      EQU    1295          ; 0x50F (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
OLDADCVAL                        EQU    1296          ; 0x510 (SA)
PRX_TEMP                         EQU    1297          ; 0x511 (SA)
PRX_TEMP_CACHE                   EQU    1301          ; 0x515 (SA)
PRX_TEMP_CACHE_E                 EQU    1304          ; 0x518 (SA)
PRX_TEMP_CACHE_H                 EQU    1302          ; 0x516 (SA)
PRX_TEMP_CACHE_U                 EQU    1303          ; 0x517 (SA)
PRX_TEMP_E                       EQU    1300          ; 0x514 (SA)
PRX_TEMP_H                       EQU    1298          ; 0x512 (SA)
PRX_TEMP_U                       EQU    1299          ; 0x513 (SA)
PWMCHANNEL                       EQU    1305          ; 0x519 (SA)
PWMDUTY                          EQU    1306          ; 0x51A (SA)
PWMDUTY_H                        EQU    1307          ; 0x51B (SA)
PWMFREQ                          EQU    1308          ; 0x51C (SA)
PWMFREQOLD                       EQU    1309          ; 0x51D (SA)
PWMRESOLUTION                    EQU    1310          ; 0x51E (SA)
PWMRESOLUTION_H                  EQU    1311          ; 0x51F (SA)
PWMTIMEROLD                      EQU    1312          ; 0x520 (SA)
READAD                           EQU    1313          ; 0x521 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSDIVLOOP                       EQU    1284          ; 0x504 (SA)
SYSLONGDIVMULTA                  EQU    1314          ; 0x522 (SA)
SYSLONGDIVMULTA_E                EQU    1317          ; 0x525 (SA)
SYSLONGDIVMULTA_H                EQU    1315          ; 0x523 (SA)
SYSLONGDIVMULTA_U                EQU    1316          ; 0x524 (SA)
SYSLONGDIVMULTB                  EQU    1318          ; 0x526 (SA)
SYSLONGDIVMULTB_E                EQU    1321          ; 0x529 (SA)
SYSLONGDIVMULTB_H                EQU    1319          ; 0x527 (SA)
SYSLONGDIVMULTB_U                EQU    1320          ; 0x528 (SA)
SYSLONGDIVMULTX                  EQU    1322          ; 0x52A (SA)
SYSLONGDIVMULTX_E                EQU    1325          ; 0x52D (SA)
SYSLONGDIVMULTX_H                EQU    1323          ; 0x52B (SA)
SYSLONGDIVMULTX_U                EQU    1324          ; 0x52C (SA)
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
SYSREPEATTEMP1                   EQU    1326          ; 0x52E (SA)
SYSTEMP1                         EQU    1327          ; 0x52F (SA)
SYSTEMP1_E                       EQU    1330          ; 0x532 (SA)
SYSTEMP1_H                       EQU    1328          ; 0x530 (SA)
SYSTEMP1_U                       EQU    1329          ; 0x531 (SA)
SYSWAITTEMP10US                  EQU    1285          ; 0x505 (SA)
SYSWAITTEMPMS                    EQU    1282          ; 0x502 (SA)
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503 (SA)
TIMERSELECTIONBITS               EQU    1331          ; 0x533 (SA)
TX_PR                            EQU    1332          ; 0x534 (SA)
_PWMTIMERSELECTED                EQU    1333          ; 0x535 (SA)

;********************************************************************************

;Alias variables
SYSREADADBYTE EQU 1313

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
	rcall	INITPPS
	rcall	INITPWM

;Start_of_the_main_program
;
;This demonstration flashes an LED to show the use of CCP PWM operations
;
;Uses variable mode PWM operations
;
;
;************************************************************************
;@author  EvanV
;@licence GPL
;@version 1.00
;@date    02-08-2026
;
;----- Configuration
;Chip Settings.
;PIC PPS Tool version: 0.0.6.5
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
;------------------PORTC-----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    --------------------CCP1---------
;----------------------------------------
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
;Dir     RSTBUTTON     In  // this is set automatically - and, you cannot set as an output
	bsf	TRISE,3,BANKED
;! Specify explicit OCULAR_OM1614 support!!
;Setup LCD Parameters
;Define LCD Hardware settings
;! Required for OCULAR LCD driver
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim ADCVal, OldADCVal as Byte = 0
	clrf	ADCVAL,ACCESS
;Dim ADCVal, OldADCVal as Byte = 0
	clrf	OLDADCVAL,ACCESS
;HPWM 1, 38, 127
	movlw	1
	movwf	PWMCHANNEL,ACCESS
	movlw	38
	movwf	PWMFREQ,ACCESS
	movlw	127
	movwf	PWMDUTY,ACCESS
	clrf	PWMDUTY_H,ACCESS
	banksel	0
	rcall	HPWM28
;Do
SysDoLoop_S1
;HPWM CCPchannel, frequency, duty cycle
;Uncomment to use ADC to change Duty
;ADCVal = ReadAD( ANA0 )
	clrf	ADREADPORT,ACCESS
	rcall	FN_READAD6
	movff	SYSREADADBYTE,ADCVAL
;! If you want to see the ADC value on the terminal
;HSerPrintStringCRLF ByteToString(ADCVal)
;If ADCVal <> OldADCVal Then
	movf	OLDADCVAL,W,ACCESS
	subwf	ADCVAL,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF1
;HPWM 1, 38, ADCVal
	movlw	1
	movwf	PWMCHANNEL,ACCESS
	movlw	38
	movwf	PWMFREQ,ACCESS
	movff	ADCVAL,PWMDUTY
	clrf	PWMDUTY_H,ACCESS
	rcall	HPWM28
	movff	PWMDUTY,ADCVAL
;OldADCVal = ADCVal
	movff	ADCVAL,OLDADCVAL
;End If
ENDIF1
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;GCBASIC Optimisation file - this will optimise PWM operations by disabling the PWM operations on the PWM channel and Timer that is set to FALSE
;to enable PWM and Timer operations set to FALSE
;
;Optimise CCP/PWM
;
;Optimise PWM
;Optimise Timers associated with PWM operations
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: pwm.h (4713)
CALCULATEDUTY
;dim PRx_Temp as long
;dim PWMDuty as word
;dim PWMResolution as word
;assumes PRx_Temp and PWMDuty are valid
;PRx_Temp = PWMDuty  * ( PRx_Temp + 1 )
	movlw	1
	addwf	PRX_TEMP,W,ACCESS
	movwf	SysTemp1,ACCESS
	movlw	0
	addwfc	PRX_TEMP_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movlw	0
	addwfc	PRX_TEMP_U,W,ACCESS
	movwf	SysTemp1_U,ACCESS
	movlw	0
	addwfc	PRX_TEMP_E,W,ACCESS
	movwf	SysTemp1_E,ACCESS
	movff	PWMDUTY,SysLONGTempA
	movff	PWMDUTY_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	SysTemp1,SysLONGTempB
	movff	SysTemp1_H,SysLONGTempB_H
	movff	SysTemp1_U,SysLONGTempB_U
	movff	SysTemp1_E,SysLONGTempB_E
	rcall	SYSMULTSUB32
	movff	SysLONGTempX,PRX_TEMP
	movff	SysLONGTempX_H,PRX_TEMP_H
	movff	SysLONGTempX_U,PRX_TEMP_U
	movff	SysLONGTempX_E,PRX_TEMP_E
;Set C off
	bcf	STATUS,C,ACCESS
;Repeat 2
	movlw	2
	movwf	SysRepeatTemp1,ACCESS
SysRepeatLoop1
;rotate PRx_Temp left
	rlcf	PRX_TEMP,F,ACCESS
	rlcf	PRX_TEMP_H,F,ACCESS
	rlcf	PRX_TEMP_U,F,ACCESS
	rlcf	PRX_TEMP_E,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;PRx_Temp = PRx_Temp / PWMResolution    'where PWMResolution is 255 or 1023
	movff	PRX_TEMP,SysLONGTempA
	movff	PRX_TEMP_H,SysLONGTempA_H
	movff	PRX_TEMP_U,SysLONGTempA_U
	movff	PRX_TEMP_E,SysLONGTempA_E
	movff	PWMRESOLUTION,SysLONGTempB
	movff	PWMRESOLUTION_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSDIVSUB32
	movff	SysLONGTempA,PRX_TEMP
	movff	SysLONGTempA_H,PRX_TEMP_H
	movff	SysLONGTempA_U,PRX_TEMP_U
	movff	SysLONGTempA_E,PRX_TEMP_E
;Set C off
	bcf	STATUS,C,ACCESS
;Repeat 6
	movlw	6
	movwf	SysRepeatTemp1,ACCESS
SysRepeatLoop2
;rotate PRx_Temp left
	rlcf	PRX_TEMP,F,ACCESS
	rlcf	PRX_TEMP_H,F,ACCESS
	rlcf	PRX_TEMP_U,F,ACCESS
	rlcf	PRX_TEMP_E,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;exits with PRx_Temp calculated
	return

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

;Overloaded signature: BYTE:BYTE:BYTE:, Source: pwm.h (2886)
HPWM28
;Dim PRx_Temp as LONG
;Dim PRx_Temp_Cache as Long
;dim PWMDuty as word
;dim PWMResolution as word: PWMResolution = 255
;dim PWMResolution as word: PWMResolution = 255
	setf	PWMRESOLUTION,ACCESS
	clrf	PWMRESOLUTION_H,ACCESS
;If HPWM_FAST operation selected, only recalculate timer prescaler when
;needed. Gives faster operation, but uses extra byte of RAM and may cause
;problems if HPWM and PWMOn are used together in a program.
;(No issues using HPWM and PWMOff in the same program with HPWM_FAST.)
;If PWMFreq <> PWMFreqOld Then
	movf	PWMFREQOLD,W,ACCESS
	subwf	PWMFREQ,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ELSE3_1
;Tx_PR = 1
	movlw	1
	movwf	TX_PR,ACCESS
;
;wait 1 s
;HserPrintCRLF 2
;HserPrint "PWMFreq " + str(PWMFreq)
;HserPrintCRLF
;HserPrint "PWMOsc1 " + str(PWMOsc1)
;HserPrintCRLF
;
;PRx_Temp = PWMOsc1 / PWMFreq
	movlw	128
	movwf	SysLONGTempA,ACCESS
	movlw	62
	movwf	SysLONGTempA_H,ACCESS
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	PWMFREQ,SysLONGTempB
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSDIVSUB32
	movff	SysLONGTempA,PRX_TEMP
	movff	SysLONGTempA_H,PRX_TEMP_H
	movff	SysLONGTempA_U,PRX_TEMP_U
	movff	SysLONGTempA_E,PRX_TEMP_E
;
;HserPrint "1) PRx_Temp " + str(PRx_Temp)
;HserPrintCRLF
;
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF4
;Tx_PR = 4
	movlw	4
	movwf	TX_PR,ACCESS
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate PRx_Temp right
	rrcf	PRX_TEMP_E,F,ACCESS
	rrcf	PRX_TEMP_U,F,ACCESS
	rrcf	PRX_TEMP_H,F,ACCESS
	rrcf	PRX_TEMP,F,ACCESS
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate PRx_Temp right
	rrcf	PRX_TEMP_E,F,ACCESS
	rrcf	PRX_TEMP_U,F,ACCESS
	rrcf	PRX_TEMP_H,F,ACCESS
	rrcf	PRX_TEMP,F,ACCESS
;end if
ENDIF4
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF5
;Tx_PR = 16
	movlw	16
	movwf	TX_PR,ACCESS
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate PRx_Temp right
	rrcf	PRX_TEMP_E,F,ACCESS
	rrcf	PRX_TEMP_U,F,ACCESS
	rrcf	PRX_TEMP_H,F,ACCESS
	rrcf	PRX_TEMP,F,ACCESS
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate PRx_Temp right
	rrcf	PRX_TEMP_E,F,ACCESS
	rrcf	PRX_TEMP_U,F,ACCESS
	rrcf	PRX_TEMP_H,F,ACCESS
	rrcf	PRX_TEMP,F,ACCESS
;end if
ENDIF5
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF6
;Tx_PR = 64
	movlw	64
	movwf	TX_PR,ACCESS
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate PRx_Temp right
	rrcf	PRX_TEMP_E,F,ACCESS
	rrcf	PRX_TEMP_U,F,ACCESS
	rrcf	PRX_TEMP_H,F,ACCESS
	rrcf	PRX_TEMP,F,ACCESS
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate PRx_Temp right
	rrcf	PRX_TEMP_E,F,ACCESS
	rrcf	PRX_TEMP_U,F,ACCESS
	rrcf	PRX_TEMP_H,F,ACCESS
	rrcf	PRX_TEMP,F,ACCESS
;end if
ENDIF6
;
;HserPrint "2) PRx_Temp " + str(PRx_Temp)
;HserPrintCRLF
;HserPrint "Tx_PR " + str(Tx_PR)
;HserPrintCRLF
;
CCPPWMSETUPCLOCKSOURCE
;select case _PWMTimerSelected
;case 2:
SysSelect2Case1
	movlw	2
	subwf	_PWMTIMERSELECTED,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
;PR2 = PRx_Temp
	movff	PRX_TEMP,PR2
;Set the Bits for the Prescaler
;Setup Timer2 by clearing the Prescaler bits - it is set next....
;SET T2CKPS0 OFF
	banksel	T2CON
	bcf	T2CON,T2CKPS0,BANKED
;SET T2CKPS1 OFF
	bcf	T2CON,T2CKPS1,BANKED
;SET T2CKPS2 OFF
	bcf	T2CON,T2CKPS2,BANKED
;Set Prescaler bits T2CON@1
;if Tx_PR = 4  then SET T2CKPS1 ON
	movlw	4
	subwf	TX_PR,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;if Tx_PR = 4  then SET T2CKPS1 ON
	bsf	T2CON,T2CKPS1,BANKED
;if Tx_PR = 4  then SET T2CKPS1 ON
;if Tx_PR = 16 then SET T2CKPS2 ON
	movlw	16
	subwf	TX_PR,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;if Tx_PR = 16 then SET T2CKPS2 ON
	bsf	T2CON,T2CKPS2,BANKED
;if Tx_PR = 16 then SET T2CKPS2 ON
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	movlw	64
	subwf	TX_PR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF9
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	bsf	T2CON,T2CKPS2,BANKED
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	bsf	T2CON,T2CKPS1,BANKED
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
ENDIF9
;Set Clock Source, if required
;Set to FOSC/4 for backward compatibility@2a where CS<3:0> = 0001 = Fosc/4
;T2CLKCON.T2CS0 = 1
	bsf	T2CLKCON,T2CS0,BANKED
;T2CLKCON.T2CS1 = 0
	bcf	T2CLKCON,T2CS1,BANKED
;T2CLKCON.T2CS2 = 0
	bcf	T2CLKCON,T2CS2,BANKED
;T2CLKCON.T2CS3 = 0
	bcf	T2CLKCON,T2CS3,BANKED
;end Select
SysSelectEnd2
END_OF_CCPPWMSETUPCLOCKSOURCE
;PWMFreqOld = PWMFreq
	movff	PWMFREQ,PWMFREQOLD
;Cache the PRx_Temp to support HPWM_FAST.
;PRx_Temp_Cache = PRx_Temp
	movff	PRX_TEMP,PRX_TEMP_CACHE
	movff	PRX_TEMP_H,PRX_TEMP_CACHE_H
	movff	PRX_TEMP_U,PRX_TEMP_CACHE_U
	movff	PRX_TEMP_E,PRX_TEMP_CACHE_E
;Else
	bra	ENDIF3
ELSE3_1
;As wierd as this looks.... restore the cache to PRX_temp as we need it when in HPWM_Fast mode
;PRx_Temp is used in channel setting section, so, if we did not restore we would not have a consistent set of information.
;PRx_Temp = PRx_Temp_Cache
	movff	PRX_TEMP_CACHE,PRX_TEMP
	movff	PRX_TEMP_CACHE_H,PRX_TEMP_H
	movff	PRX_TEMP_CACHE_U,PRX_TEMP_U
	movff	PRX_TEMP_CACHE_E,PRX_TEMP_E
;End If
ENDIF3
;this code can be optimised by using defines USE_HPWMCCP1|2|3|4|5
;and, you can define user setup and exit commands using AddHPWMCCPSetupN and  AddHPWMCCPExitN
;These can be used to FIX little errors!
SETUPTHECORRECTTIMERBITS
;ChipPWMTimerVariant some chips have variants on CCPTMRS0
;Dim TimerSelectionBits as Byte
;TimerSelectionBits =  (_PWMTimerSelected / 2 )
	bcf	STATUS,C,ACCESS
	rrcf	_PWMTIMERSELECTED,W,ACCESS
	movwf	TIMERSELECTIONBITS,ACCESS
SETUPCCPPWMREGISTERS
;If there is no ASM here then the CHIP is not recognised, look at section SETUPCCPPWMREGISTERS in PMW.H
;Only process this section when CCP1CON exists
CHIPFAMILYPWMCCP1CON16HANDLER
;Identify the 18FxxQxx chips that only have ONE CCP1PMW
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	banksel	0
	rcall	CALCULATEDUTY
;CCPR1H = PRx_Temp_H
	movff	PRX_TEMP_H,CCPR1H
;CCPR1L = PRx_Temp
	movff	PRX_TEMP,CCPR1L
;SET CCP1M3 ON
	banksel	CCP1CON
	bsf	CCP1CON,CCP1MODE3,BANKED
;SET CCP1M2 ON
	bsf	CCP1CON,CCP1MODE2,BANKED
;SET CCP1M1 ON
	bsf	CCP1CON,CCP1MODE1,BANKED
;SET CCP1M0 ON
	bsf	CCP1CON,CCP1MODE0,BANKED
;SET CCP1EN ON
	bsf	CCP1CON,CCP1EN,BANKED
;SET CCP1CON_EN ON
	bsf	CCP1CON,EN,BANKED
;SET CCP1FMT ON
	bsf	CCP1CON,CCP1FMT,BANKED
ENDCHIPFAMILYPWMCCP1CON16HANDLER
	banksel	0
	return

;********************************************************************************

;Source: 245_use_pwm_via_ccp_and_adc_to_control_led_brightness.gcb (24)
INITPPS
;Module: UART pin directions
;Dir PORTC.6 Out    ' Make TX1 pin an output
	banksel	TRISC
	bcf	TRISC,6,BANKED
;Module: UART1
;U1RXPPS = 0x15; //RC5->UART1:RX1;
	movlw	21
	banksel	U1RXPPS
	movwf	U1RXPPS,BANKED
;RC6PPS = 0x12;  //RC6->UART1:TX1;
	movlw	18
	movwf	RC6PPS,BANKED
;Modile: CCP1
;RB0PPS = 0x0D;  //RB0->CCP1:CCP1;
	movlw	13
	movwf	RB0PPS,BANKED
;RB1PPS = 0x0D;  //RB1->CCP1:CCP1;
	movlw	13
	movwf	RB1PPS,BANKED
;RB2PPS = 0x0D;  //RB2->CCP1:CCP1;
	movlw	13
	movwf	RB2PPS,BANKED
;RB3PPS = 0x0D;  //RB3->CCP1:CCP1;
	movlw	13
	movwf	RB3PPS,BANKED
	banksel	0
	return

;********************************************************************************

;Source: pwm.h (266)
INITPWM
;_PWMTimerSelected = 2
	movlw	2
	movwf	_PWMTIMERSELECTED,ACCESS
;Dim PRx_Temp as LONG
LEGACY_STARTOFFIXEDCCPPWMMODECODE
;DIM CCPCONCache as BYTE
;CCPCONCache = 0
	clrf	CCPCONCACHE,ACCESS
;Set PWM Period
;PR2 = PR2_CPP_PWM_Temp
	movlw	105
	banksel	PR2
	movwf	PR2,BANKED
;SET T2CON.T2CKPS0 OFF
	bcf	T2CON,T2CKPS0,BANKED
;SET T2CON.T2CKPS1 ON
	bsf	T2CON,T2CKPS1,BANKED
;SET T2CON.T2CKPS2 OFF
	bcf	T2CON,T2CKPS2,BANKED
;Set Duty cycle
;CCPCONCache.CCP1FMT = 1
	bsf	CCPCONCACHE,CCP1FMT,ACCESS
;CCPR1H = DutyCycleH
	movlw	53
	movwf	CCPR1H,BANKED
;CCPR1L = DutyCycleL*64
	clrf	CCPR1L,BANKED
;[canskip]T2CLKCON = 1
	movlw	1
	movwf	T2CLKCON,BANKED
;set the enable bit in the Fixed Mode cache variable
;CCPCONCache.CCP1CON_EN = 1
	bsf	CCPCONCACHE,CCP1CON_EN,ACCESS
;CCPCONCache.CCP1M3, CCPCONCache.CCP1M2, CCPCONCache.CCP1M1, CCPCONCache.CCP1M0 = b'1100'
	bsf	CCPCONCACHE,CCP1MODE3,ACCESS
	bsf	CCPCONCACHE,CCP1MODE2,ACCESS
	bcf	CCPCONCACHE,CCP1MODE1,ACCESS
	bcf	CCPCONCACHE,CCP1MODE0,ACCESS
;Enable Timer 2
;SET T2CON.TMR2ON ON
	bsf	T2CON,TMR2ON,BANKED
;PWMFreqOld = 0
	clrf	PWMFREQOLD,ACCESS
;PWMTimerOld = 0
	clrf	PWMTIMEROLD,ACCESS
STARTOFFIXEDPWMMODECODE
SETPWMDUTYCODE
	banksel	0
	return

;********************************************************************************

;Source: system.h (203)
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

;Source: system.h (4193)
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

;Source: system.h (4591)
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

;Source: system.h (3583)
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
	bra	ENDIF12
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF12
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
	bra	ENDIF13
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
ENDIF13
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

;Source: system.h (3090)
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
	bra	ENDIF10
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
ENDIF10
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
