;Program compiled by GCBASIC (1.00.00 Release Candidate 2022-09-11 (Windows 64 bit) : Build 1168x) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18075
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18075_chiprange_demonstrations\130_rotate_the_leds_using_8bit_timer0.s"
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
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 32          ; 0X20
GLOBAL	TIMERCOUNTER
 TIMERCOUNTER                     EQU 33          ; 0X21
GLOBAL	TMRNUMBER
 TMRNUMBER                        EQU 34          ; 0X22
GLOBAL	TMRPOST
 TMRPOST                          EQU 35          ; 0X23
GLOBAL	TMRPRES
 TMRPRES                          EQU 36          ; 0X24
GLOBAL	TMRSOURCE
 TMRSOURCE                        EQU 37          ; 0X25
GLOBAL	TMRVALUE
 TMRVALUE                         EQU 38          ; 0X26
GLOBAL	TMRVALUE_H
 TMRVALUE_H                       EQU 39          ; 0X27

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
;''  This demonstration flashes an LED to show the use of an 8Bit Timer 0
;''
;''  Timer0 is a counter implemented in the processor. It may be used to count instruction
;''  cycles or external events, that occur at or below the instruction cycle rate.
;''  In the PIC18, Timer0 can be used as either an 8-bit or 16-bit counter, or timer. The
;''  enhanced mid-range core implements only an 8-bit counter.
;''
;''  This lesson configures Timer0 to count instruction cycles and to set a flag when it rolls
;''  over. This frees up the processor to do meaningful work rather than wasting instruction
;''  cycles in a timing loop.
;''  Using a counter provides a convenient method of measuring time or delay loops as it
;''  allows the processor to work on other tasks rather than counting instruction cycles.
;''
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.01
;''@date    15/09/2022
;----- Configuration
;Chip Settings.
;This Configuration change is needed to enable programming in Low Voltage Programming Mode
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
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;For this we need the following:
;Prescaler with the FOSC/4
;Prescaler with the FOSC/4 with a post scaler
;1:256
;1:1 which is the constant POST0_1
;InitTimer0 Osc, PRE0_256 + TMR0_FOSC4 ,  POST0_1
	MOVLW	1
	MOVWF	TMRSOURCE
	MOVLW	72
	MOVWF	TMRPRES
	CLRF	TMRPOST
	CALL	INITTIMER0176
;Start the Timer
;StartTimer 0
	CLRF	TMRNUMBER
	CALL	STARTTIMER
;Every 100 msec, we will count 100 to make 1 second
;SetTimer ( 0 , 0xB1  )
	CLRF	TMRNUMBER
	MOVLW	177
	MOVWF	TMRVALUE
	CLRF	TMRVALUE_H
	CALL	SETTIMER173
;we will use this to count the number of times the event happens
;Dim TimerCounter As Byte
;TimerCounter = 0
	CLRF	TIMERCOUNTER
;Set the initial LED states - change to suit your configuration - same as previous demonstrations
;You may need change to the LEDMASK to suit your port/configuration.  We use a macro as re reuse this statement more that once.
;LEDSTATEMACRO
	BCF	LATB,1
	BCF	LATB,2
	BCF	LATB,3
	BSF	LATB,4
;Do
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;wait for the event
;Wait While TMR0IF = 0
GLOBAL	SYSWAITLOOP1
SYSWAITLOOP1:
	BANKSEL	PIR0
	BTFSS	PIR0,5
	GOTO	SYSWAITLOOP1
;Clearing Timer flag will reset event
;TMR0IF = 0
	BCF	PIR0,5
;TimerCounter = TimerCounter + 1
	BANKSEL	TIMERCOUNTER
	INCF	TIMERCOUNTER,F
;When at 100 we are at 1 s
;If TimerCounter = 100 Then
	MOVLW	100
	SUBWF	TIMERCOUNTER,W
	BTFSS	STATUS,2
	GOTO	ENDIF1
;ROTATE THE LEDS.  WE ARE ONLY INTERESTED IN THE FOUR LEDS SO WE MASK THE OTHER .
;Set C Off
	BCF	STATUS,0
;and shift the contents of LEDState
;Rotate LEDPORT Right
	RRF	LATB,F
;If the LEDState.0is equal to 1 then the sequence has completed, then set the initial state again, the same operation as the starting LED.
;If LEDPORT.0 = 1 Then
	BTFSS	LATB,0
	GOTO	ENDIF2
;Set the initial LED states
;LEDSTATEMACRO
	BCF	LATB,1
	BCF	LATB,2
	BCF	LATB,3
	BSF	LATB,4
;Mask off the other bits
;LEDPORT = LEDPORT AND LEDMASK
	MOVLW	30
	ANDWF	LATB,F
;End If
GLOBAL	ENDIF2
ENDIF2:
;restart our event counter
;TimerCounter = 0
	CLRF	TIMERCOUNTER
;End If
GLOBAL	ENDIF1
ENDIF1:
;Set the Timer start value
;SetTimer ( 0 , 0xB1  )
	CLRF	TMRNUMBER
	MOVLW	177
	MOVWF	TMRVALUE
	CLRF	TMRVALUE_H
	CALL	SETTIMER173
;Loop
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

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

;OVERLOADED SIGNATURE: BYTE:BYTE:BYTE:, SOURCE: TIMER.H (1400)
GLOBAL	INITTIMER0176
INITTIMER0176:
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
	GOTO	ELSE16_1
;SET TMRPost.5 ON
	BSF	TMRPOST,5
;ELSE
	GOTO	ENDIF16
GLOBAL	ELSE16_1
ELSE16_1:
;SET TMRPost.5 OFF
	BCF	TMRPOST,5
;END IF
GLOBAL	ENDIF16
ENDIF16:
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

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: TIMER.H (1068)
GLOBAL	SETTIMER173
SETTIMER173:
;Dim TMRValue as word
;If TMRNumber = 0 Then
	MOVF	TMRNUMBER,F
	BTFSS	STATUS,2
	GOTO	ENDIF9
;TMRValue_H = [byte]TMRValue
	MOVF	TMRVALUE,W
	MOVWF	TMRVALUE_H
;[byte]TMRValue = 0
	CLRF	TMRVALUE
;end if
GLOBAL	ENDIF9
ENDIF9:
;SetTimer ( TMRNumber, [word]TMRValue )
	GOTO	SETTIMER174

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:WORD:, SOURCE: TIMER.H (1089)
GLOBAL	SETTIMER174
SETTIMER174:
;If TMRNumber = 0 Then
	MOVF	TMRNUMBER,F
	BTFSS	STATUS,2
	GOTO	ENDIF10
;Handle chips with TMR0H
;Use default 8-bit mode therefore _TMR0_16BIT_ not defined
;Added to resolve using 8bit Timer0 with enhance timer
;High byte is timer0 register of interest
;TMR0H = TMRValue_H
	MOVF	TMRVALUE_H,W
	BANKSEL	TMR0H
	MOVWF	TMR0H
;End If
GLOBAL	ENDIF10
ENDIF10:
;If TMRNumber = 1 then
	BANKSEL	TMRNUMBER
	DECF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF11
;TMR1H = TMRValue_H
	MOVF	TMRVALUE_H,W
	BANKSEL	TMR1H
	MOVWF	TMR1H
;TMR1L = TMRValue
	BANKSEL	TMRVALUE
	MOVF	TMRVALUE,W
	BANKSEL	TMR1L
	MOVWF	TMR1L
;End If
GLOBAL	ENDIF11
ENDIF11:
;If TMRNumber = 2 Then
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF12
;TMR2 = TMRValue
	MOVF	TMRVALUE,W
	BANKSEL	T2TMR
	MOVWF	T2TMR
;End If
GLOBAL	ENDIF12
ENDIF12:
;If TMRNumber = 3 then
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF13
;TMR3H = TMRValue_H
	MOVF	TMRVALUE_H,W
	BANKSEL	TMR3H
	MOVWF	TMR3H
;TMR3L = TMRValue
	BANKSEL	TMRVALUE
	MOVF	TMRVALUE,W
	BANKSEL	TMR3L
	MOVWF	TMR3L
;End If
GLOBAL	ENDIF13
ENDIF13:
;If TMRNumber = 4 Then
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF14
;TMR4 = TMRValue
	MOVF	TMRVALUE,W
	BANKSEL	T4TMR
	MOVWF	T4TMR
;End If
GLOBAL	ENDIF14
ENDIF14:
;If TMRNumber = 6 Then
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF15
;TMR6 = TMRValue
	MOVF	TMRVALUE,W
	BANKSEL	T6TMR
	MOVWF	T6TMR
;End If
GLOBAL	ENDIF15
ENDIF15:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: TIMER.H (744)
GLOBAL	STARTTIMER
STARTTIMER:
;IF TMRNumber = 0 then Set T0EN on
	MOVF	TMRNUMBER,F
	BTFSS	STATUS,2
	GOTO	ENDIF3
;IF TMRNumber = 0 then Set T0EN on
	BANKSEL	T0CON0
	BSF	T0CON0,7
;IF TMRNumber = 0 then Set T0EN on
GLOBAL	ENDIF3
ENDIF3:
;IF TMRNumber = 1 then Set TMR1ON on
	BANKSEL	TMRNUMBER
	DECF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF4
;IF TMRNumber = 1 then Set TMR1ON on
	BANKSEL	T1CON
	BSF	T1CON,0
;IF TMRNumber = 1 then Set TMR1ON on
GLOBAL	ENDIF4
ENDIF4:
;IF TMRNumber = 2 then Set TMR2ON on
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF5
;IF TMRNumber = 2 then Set TMR2ON on
	BANKSEL	T2CON
	BSF	T2CON,7
;IF TMRNumber = 2 then Set TMR2ON on
GLOBAL	ENDIF5
ENDIF5:
;IF TMRNumber = 3 then Set TMR3ON on
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF6
;IF TMRNumber = 3 then Set TMR3ON on
	BANKSEL	T3CON
	BSF	T3CON,0
;IF TMRNumber = 3 then Set TMR3ON on
GLOBAL	ENDIF6
ENDIF6:
;IF TMRNumber = 4 then Set TMR4ON on
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF7
;IF TMRNumber = 4 then Set TMR4ON on
	BANKSEL	T4CON
	BSF	T4CON,7
;IF TMRNumber = 4 then Set TMR4ON on
GLOBAL	ENDIF7
ENDIF7:
;IF TMRNumber = 6 then Set TMR6ON on
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
	BTFSS	STATUS,2
	GOTO	ENDIF8
;IF TMRNumber = 6 then Set TMR6ON on
	BANKSEL	T6CON
	BSF	T6CON,7
;IF TMRNumber = 6 then Set TMR6ON on
GLOBAL	ENDIF8
ENDIF8:
	BANKSEL	STATUS
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
