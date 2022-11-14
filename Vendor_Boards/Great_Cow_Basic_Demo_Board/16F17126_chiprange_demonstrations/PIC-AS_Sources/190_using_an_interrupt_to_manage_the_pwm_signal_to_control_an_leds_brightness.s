;Program compiled by Great Cow BASIC (1.00.00 Release Candidate 2022-11-06 (Windows 64 bit) : Build 1189) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F17126
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17126_chiprange_demonstrations\190_using_an_interrupt_to_manage_the_pwm_signal_to_control_an_leds_brightness.s"
 SUBTITLE    "11-14-2022"

; Reverse lookup file(s)
; C:\Program Files\Microchip\xc8\v2.40\pic\include\proc\pic16f17126.inc
; C:\Program Files\Microchip\xc8\v2.40\pic\dat\cfgmap\16f17126.cfgmap
; Alternative CONFIG file is to be found at C:\Program Files\Microchip\xc8\vX.YY\pic\dat\cfgdata as per Microchip support ticket #00730936 

;********************************************************************************

;********************************************************************************
;Explicit CONFIG
 CONFIG FCMEN=ON                                 ;C1 Reverselookup FCMEN = ON
 CONFIG CLKOUTEN=OFF                             ;C1 Reverselookup CLKOUTEN = OFF
 CONFIG RSTOSC=HFINTOSC_32MHz                    ;C1 Reverselookup RSTOSC = HFINTOSC_32MHZ
 CONFIG FEXTOSC=OFF                              ;C1 Reverselookup FEXTOSC = OFF
 CONFIG MCLRE=INTMCLR                            ;C1 Reverselookup MCLRE = INTMCLR
 CONFIG WDTE=OFF                                 ;C1 Reverselookup WDTE = OFF
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
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 112          ; 0X70
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 113          ; 0X71
GLOBAL	MOTORSPEED
 MOTORSPEED                       EQU 32          ; 0X20
GLOBAL	PWMCOUNTER
 PWMCOUNTER                       EQU 33          ; 0X21
GLOBAL	SAVEPCLATH
 SAVEPCLATH                       EQU 34          ; 0X22
GLOBAL	SPEED
 SPEED                            EQU 35          ; 0X23
GLOBAL	SYSBSR
 SYSBSR                           EQU 36          ; 0X24
GLOBAL	SYSBYTETEMPA
 SYSBYTETEMPA                     EQU 117          ; 0X75
GLOBAL	SYSBYTETEMPB
 SYSBYTETEMPB                     EQU 121          ; 0X79
GLOBAL	SYSBYTETEMPX
 SYSBYTETEMPX                     EQU 112          ; 0X70
GLOBAL	SYSSTATUS
 SYSSTATUS                        EQU 127          ; 0X7F
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 37          ; 0X25
GLOBAL	SYSTEMP2
 SYSTEMP2                         EQU 38          ; 0X26
GLOBAL	SYSW
 SYSW                             EQU 126          ; 0X7E
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73
GLOBAL	SYSWAITTEMPS
 SYSWAITTEMPS                     EQU 116          ; 0X74
GLOBAL	TMRNUMBER
 TMRNUMBER                        EQU 39          ; 0X27
GLOBAL	TMRPOST
 TMRPOST                          EQU 40          ; 0X28
GLOBAL	TMRPRES
 TMRPRES                          EQU 41          ; 0X29
GLOBAL	TMRSOURCE
 TMRSOURCE                        EQU 42          ; 0X2A

;********************************************************************************

 PSECT   PROGMEM0,delta=2, abs
 RESETVEC:
;VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	GOTO	BASPROGRAMSTART
	ORG	4
GLOBAL	INTERRUPT
INTERRUPT:

;********************************************************************************

;SAVE CONTEXT
	MOVWF	SYSW
	SWAPF	STATUS,W
	MOVWF	SYSSTATUS
	MOVF	BSR,W
	BANKSEL	STATUS
	MOVWF	SYSBSR
;STORE SYSTEM VARIABLES
	MOVF	PCLATH,W
	MOVWF	SAVEPCLATH
	CLRF	PCLATH
;ON INTERRUPT HANDLERS
	BANKSEL	PIE0
	BTFSS	PIE0,5
	GOTO	NOTTMR0IF
	BTFSS	PIR0,5
	GOTO	NOTTMR0IF
	BANKSEL	STATUS
	CALL	PWMHANDLER
	BANKSEL	PIR0
	BCF	PIR0,5
	GOTO	INTERRUPTDONE
GLOBAL	NOTTMR0IF
NOTTMR0IF:
;USER INTERRUPT ROUTINE
GLOBAL	INTERRUPTDONE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	BANKSEL	SAVEPCLATH
	MOVF	SAVEPCLATH,W
	MOVWF	PCLATH
	MOVF	SYSBSR,W
	MOVWF	BSR
	SWAPF	SYSSTATUS,W
	MOVWF	STATUS
	SWAPF	SYSW,F
	SWAPF	SYSW,W
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	34
GLOBAL	BASPROGRAMSTART
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS
;ENABLE INTERRUPTS
	BSF	INTCON,7
	BSF	INTCON,6

;START OF THE MAIN PROGRAM
;''
;'' This demonstration will show how you can control a motor using a PWM signal.
;''
;'' Pulse-Width Modulation (PWM) is a scheme that provides power to a load by switching
;'' quickly between fully on and fully off states. The PWM signal resembles a square wave
;'' where the high portion of the signal is considered the on state and the low portion of
;'' the signal is considered the off state. The high portion, also known as the pulse width,
;'' can vary in time and is defined in steps. A longer, high on time will illuminate the LED
;'' brighter. The frequency or period of the PWM does not change.
;''
;'' This program demostrates a method where the number of steps applied,
;'' which lengthens the pulse width are calculated in an Interrupt routine.
;'' The PWM period defined as the duration of one complete cycle or the total
;'' amount of on and off time combined is based on a simple counter.
;''
;'' The demo varies the PWM to the LED.  We are pretending the motor is connected to PortC.1, via a suitable motor control device.
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
;' IO:    ----TX---------LED--LED-LED LED--
;'-----------------------------------------
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim speed, MotorSpeed, PWMCounter As Byte
;We are pretending the motor is connected to Portb.1, via a suitable motor control device.
;Dir MOTOR Out
	BCF	TRISC,0
;Call the initialisation routine
;InitMotorControl
	CALL	INITMOTORCONTROL
;Main routine
;Do
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;Increase speed to full over 2.5 seconds
;For Speed = 0 To 100
;LEGACY METHOD
	MOVLW	255
	MOVWF	SPEED
GLOBAL	SYSFORLOOP1
SYSFORLOOP1:
	INCF	SPEED,F
;MotorSpeed = Speed
	MOVF	SPEED,W
	MOVWF	MOTORSPEED
;Wait 25 ms
	MOVLW	25
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;Next
	MOVLW	100
	SUBWF	SPEED,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
GLOBAL	SYSFORLOOPEND1
SYSFORLOOPEND1:
;Hold speed
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;Decrease speed to zero over 2.5 seconds
;For Speed = 100 To 0
	MOVLW	100
	MOVWF	SPEED
GLOBAL	SYSFORLOOP2
SYSFORLOOP2:
;MotorSpeed = Speed
	MOVF	SPEED,W
	MOVWF	MOTORSPEED
;Wait 25 ms
	MOVLW	25
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;Next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	MOVF	SPEED,W
	SUBLW	0
	MOVWF	SYSTEMP1
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	CALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF2
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	SPEED,F
	GOTO	SYSFORLOOP2
;END IF
GLOBAL	ENDIF2
ENDIF2:
GLOBAL	SYSFORLOOPEND2
SYSFORLOOPEND2:
;Hold speed
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;Loop
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
;Setup routine
;PWM sub
;This will be called when Timer 0 overflows
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

GLOBAL	DELAY_MS
DELAY_MS:
	INCF	SYSWAITTEMPMS_H, F
GLOBAL	DMS_START
DMS_START:
	MOVLW	14
	MOVWF	DELAYTEMP2
GLOBAL	DMS_OUTER
DMS_OUTER:
	MOVLW	189
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

GLOBAL	DELAY_S
DELAY_S:
GLOBAL	DS_START
DS_START:
	MOVLW	232
	MOVWF	SYSWAITTEMPMS
	MOVLW	3
	MOVWF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
	DECFSZ	SYSWAITTEMPS, F
	GOTO	DS_START
	RETURN

;********************************************************************************

;SOURCE: 190_USING_AN_INTERRUPT_TO_MANAGE_THE_PWM_SIGNAL_TO_CONTROL_AN_LEDS_BRIGHTNESS.GCB (79)
GLOBAL	INITMOTORCONTROL
INITMOTORCONTROL:
;Clear variables
;MotorSpeed = 0
	CLRF	MOTORSPEED
;PWMCounter = 0
	CLRF	PWMCOUNTER
;Add a handler for the interrupt
;On Interrupt Timer0Overflow Call PWMHandler
	BANKSEL	PIE0
	BSF	PIE0,5
;InitTimer0 Osc, PRE0_1 + TMR0_FOSC4 ,  POST0_1
	MOVLW	1
	BANKSEL	TMRSOURCE
	MOVWF	TMRSOURCE
	MOVLW	64
	MOVWF	TMRPRES
	CLRF	TMRPOST
	CALL	INITTIMER0178
;StartTimer 0
	CLRF	TMRNUMBER
	GOTO	STARTTIMER

;********************************************************************************

;SOURCE: SYSTEM.H (159)
GLOBAL	INITSYS
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	MOVLW	96
	BANKSEL	OSCCON1
	MOVWF	OSCCON1
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	CLRF	OSCCON3
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	CLRF	OSCEN
;Default value
;OSCTUNE = 0x00
	CLRF	OSCTUNE
;asm showdebug The MCU is a chip family ChipFamily
;asm showdebug OSCCON type is 102
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F171xx MCU family
;OSCFRQ = 0b00000101
	MOVLW	5
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
;ANSELC = 0
	CLRF	ANSELC
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	BANKSEL	CM2CON0
	BCF	CM2CON0,7
;C1EN = 0
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

;OVERLOADED SIGNATURE: BYTE:BYTE:BYTE:, SOURCE: TIMER.H (1400)
GLOBAL	INITTIMER0178
INITTIMER0178:
;Equate to      T0CON1 7:5      3:0        T0CON0 3:0
;Assumed for code below Timer0 is 16-bit capable as we have been passed three parameters
;Set prescaler
;T0CON1 Sets up  CLK Source (7:5)  Sync (4) & Prescale 3:0
;T0CON1 POR Val = b'00000000'
;Re-Use TMRPres as T0CON1 Temp register
;Keep T0CON1 7:4 and write bits 3:0 to  register
;Bits therefore will be cleared!
;TMRPres = (T0CON1 And 240 ) OR TMRPres
	MOVLW	240
	BANKSEL	T0CON1
	ANDWF	T0CON1,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	IORWF	TMRPRES,F
;Set the Source bit
;IF TMRSource <> OSC  THEN
	DECF	TMRSOURCE,W
	BTFSC	STATUS,2
	GOTO	ELSE10_1
;SET TMRPost.5 ON
	BSF	TMRPOST,5
;ELSE
	GOTO	ENDIF10
GLOBAL	ELSE10_1
ELSE10_1:
;SET TMRPost.5 OFF
	BCF	TMRPOST,5
;END IF
GLOBAL	ENDIF10
ENDIF10:
;Write the TOCON register
;T0CON1 = TMRPres
	MOVF	TMRPRES,W
	BANKSEL	T0CON1
	MOVWF	T0CON1
;Assumed for code below Timer0 is 16-bit capable
;Set Postscaler
;Re-Use TMRPost as T0CON0 Temp register
;Keep T0CON0 7:5  and write bits 5:0 to register
;Bits therefore will be cleared!
;TMRPost = (T0CON0 And 224) OR TMRPost
	MOVLW	224
	ANDWF	T0CON0,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	IORWF	TMRPOST,F
;Set TO16BIT
;Set TMRPost.4 OFF '8-bit Timer0
	BCF	TMRPOST,4
;Write the TOCON register
;T0CON0 = TMRPost
	MOVF	TMRPOST,W
	BANKSEL	T0CON0
	MOVWF	T0CON0
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: 190_USING_AN_INTERRUPT_TO_MANAGE_THE_PWM_SIGNAL_TO_CONTROL_AN_LEDS_BRIGHTNESS.GCB (93)
GLOBAL	PWMHANDLER
PWMHANDLER:
;If MotorSpeed > PWMCounter Then
	MOVF	MOTORSPEED,W
	SUBWF	PWMCOUNTER,W
	BTFSC	STATUS,0
	GOTO	ELSE3_1
;Set MOTOR On
	BSF	LATC,0
;Else
	GOTO	ENDIF3
GLOBAL	ELSE3_1
ELSE3_1:
;Set MOTOR Off
	BCF	LATC,0
;End If
GLOBAL	ENDIF3
ENDIF3:
;PWMCounter += 1
	INCF	PWMCOUNTER,F
;If PWMCounter = 100 Then PWMCounter = 0
	MOVLW	100
	SUBWF	PWMCOUNTER,W
	BTFSC	STATUS,2
;If PWMCounter = 100 Then PWMCounter = 0
	CLRF	PWMCOUNTER
;If PWMCounter = 100 Then PWMCounter = 0
	RETURN

;********************************************************************************

;SOURCE: TIMER.H (744)
GLOBAL	STARTTIMER
STARTTIMER:
;IF TMRNumber = 0 then Set T0EN on
	MOVF	TMRNUMBER,F
	BTFSS	STATUS,2
	GOTO	ENDIF5
;IF TMRNumber = 0 then Set T0EN on
	BANKSEL	T0CON0
	BSF	T0CON0,7
;IF TMRNumber = 0 then Set T0EN on
GLOBAL	ENDIF5
ENDIF5:
;IF TMRNumber = 1 then Set TMR1ON on
	BANKSEL	TMRNUMBER
	DECF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF6
;IF TMRNumber = 1 then Set TMR1ON on
	BANKSEL	T1CON
	BSF	T1CON,0
;IF TMRNumber = 1 then Set TMR1ON on
GLOBAL	ENDIF6
ENDIF6:
;IF TMRNumber = 2 then Set TMR2ON on
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF7
;IF TMRNumber = 2 then Set TMR2ON on
	BANKSEL	T2CON
	BSF	T2CON,7
;IF TMRNumber = 2 then Set TMR2ON on
GLOBAL	ENDIF7
ENDIF7:
;IF TMRNumber = 3 then Set TMR3ON on
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF8
;IF TMRNumber = 3 then Set TMR3ON on
	BANKSEL	T3CON
	BSF	T3CON,0
;IF TMRNumber = 3 then Set TMR3ON on
GLOBAL	ENDIF8
ENDIF8:
;IF TMRNumber = 4 then Set TMR4ON on
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF9
;IF TMRNumber = 4 then Set TMR4ON on
	BANKSEL	T4CON
	BSF	T4CON,7
;IF TMRNumber = 4 then Set TMR4ON on
GLOBAL	ENDIF9
ENDIF9:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3078)
GLOBAL	SYSCOMPEQUAL
SYSCOMPEQUAL:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;movf SysByteTempA, W
	MOVF	SYSBYTETEMPA, W
;subwf SysByteTempB, W
	SUBWF	SYSBYTETEMPB, W
;btfsc STATUS, Z
	BTFSC	STATUS,2
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
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
;START OF PROGRAM MEMORY PAGE 4
	PSECT	PROGMEM4,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	8192
;START OF PROGRAM MEMORY PAGE 5
	PSECT	PROGMEM5,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	10240
;START OF PROGRAM MEMORY PAGE 6
	PSECT	PROGMEM6,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	12288
;START OF PROGRAM MEMORY PAGE 7
	PSECT	PROGMEM7,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	14336
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
