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
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17126_chiprange_demonstrations\250_pwm16bit_variable_modes.s"
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
GLOBAL	SYSBYTETEMPX
 SYSBYTETEMPX                     EQU 112          ; 0X70
GLOBAL	SYSFORLOOPABSVALUE2
 SYSFORLOOPABSVALUE2              EQU 32          ; 0X20
GLOBAL	SYSFORLOOPABSVALUE2_H
 SYSFORLOOPABSVALUE2_H            EQU 33          ; 0X21
GLOBAL	SYSFORLOOPSTEP1
 SYSFORLOOPSTEP1                  EQU 34          ; 0X22
GLOBAL	SYSFORLOOPSTEP1_H
 SYSFORLOOPSTEP1_H                EQU 35          ; 0X23
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 36          ; 0X24
GLOBAL	SYSTEMP1_H
 SYSTEMP1_H                       EQU 37          ; 0X25
GLOBAL	SYSTEMP2
 SYSTEMP2                         EQU 38          ; 0X26
GLOBAL	SYSTEMP3
 SYSTEMP3                         EQU 39          ; 0X27
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73
GLOBAL	SYSWAITTEMPS
 SYSWAITTEMPS                     EQU 116          ; 0X74
GLOBAL	SYSWORDTEMPA
 SYSWORDTEMPA                     EQU 117          ; 0X75
GLOBAL	SYSWORDTEMPA_H
 SYSWORDTEMPA_H                   EQU 118          ; 0X76
GLOBAL	SYSWORDTEMPB
 SYSWORDTEMPB                     EQU 121          ; 0X79
GLOBAL	SYSWORDTEMPB_H
 SYSWORDTEMPB_H                   EQU 122          ; 0X7A

;********************************************************************************

;ALIAS VARIABLES
GLOBAL	PWMVAL
 PWMVAL                           EQU 1175
GLOBAL	PWMVAL_H
 PWMVAL_H                         EQU 1176

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

;START OF THE MAIN PROGRAM
;''
;''This program shows how to use PWM to provide 1KHz at 50% for 64Khz chip frequency
;''
;''@author     EvanV
;''@licence    GPL
;''@version    1.01
;''@date       31.10.2022
;''********************************************************************************
;Template comment at the end of the config file
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:   -----------------SW---------------
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
;Define constants to make things easier. We can reuse these at any time.
;Dir     RC0         Out
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
;analogue port selection
;------ Start of main Program to provide 2kHz frequency at 100% for 16Khz chip frequency, it cycles from 0% to 100% Duty
;PWMERS External Reset Disabled
;PWM1ERS = 0x00
	BANKSEL	PWM1ERS
	CLRF	PWM1ERS
;PWMCLK HFINTOSC
;PWM1CLK = 0x03
	MOVLW	3
	MOVWF	PWM1CLK
;PWMLDS Autoload disabled
;PWM1LDS = 0x00
	CLRF	PWM1LDS
;PWMPRL 231
;PWM1PRL = 0xE7
	MOVLW	231
	MOVWF	PWM1PRL
;PWMPRH 3
;PWM1PRH = 0x03
	MOVLW	3
	MOVWF	PWM1PRH
;PWMCPRE Prescale by 32
;PWM1CPRE = 0x1F
	MOVLW	31
	MOVWF	PWM1CPRE
;PWMPIPOS No postscale
;PWM1PIPOS = 0x00
	CLRF	PWM1PIPOS
;PWMS1P1IF PWM1 output match did not occur; PWMS1P2IF PWM2 output match did not occur
;PWM1GIR = 0x00
	CLRF	PWM1GIR
;PWMS1P1IE disabled; PWMS1P2IE disabled
;PWM1GIE = 0x00
	CLRF	PWM1GIE
;PWMPOL1 disabled; PWMPOL2 disabled; PWMPPEN disabled; PWMMODE Left aligned mode
;PWM1S1CFG = 0x00
	CLRF	PWM1S1CFG
;PWMS1P1L 232
;PWM1S1P1L = 0xE8
	MOVLW	232
	MOVWF	PWM1S1P1L
;PWMS1P1H 3
;PWM1S1P1H = 0x03
	MOVLW	3
	MOVWF	PWM1S1P1H
;PWMS1P2L 244
;PWM1S1P2L = 0xF4
	MOVLW	244
	MOVWF	PWM1S1P2L
;PWMS1P2H 1
;PWM1S1P2H = 0x01
	MOVLW	1
	MOVWF	PWM1S1P2H
;Clear PWM1_16BIT period interrupt flag
;PWM1PIF = 0
	BANKSEL	PIR3
	BCF	PIR3,0
;Clear PWM1_16BIT interrupt flag
;PWM1IF = 0
	BCF	PIR3,1
;Clear PWM1_16BIT slice 1, output 1 interrupt flag
;S1P1IF = 0
	BANKSEL	PWM1GIR
	BCF	PWM1GIR,0
;Clear PWM1_16BIT slice 1, output 2 interrupt flag
;S1P2IF = 0
	BCF	PWM1GIR,1
;PWM1_16BIT interrupt enable bit
;PWM1IE = 0
	BANKSEL	PIE3
	BCF	PIE3,1
;PWM1_16BIT period interrupt enable bit
;PWM1PIE = 0
	BCF	PIE3,0
;PWMEN enabled; PWMLD disabled; PWMERSPOL disabled; PWMERSNOW disabled
;PWM1CON = 0x80
	MOVLW	128
	BANKSEL	PWM1CON
	MOVWF	PWM1CON
;Create an alias to the PWM1 duty register
;Dim PWMval as word alias PWM1S1P1H, PWM1S1P1L
;Do
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;for PWMval = 0x00 to 0x3E8
;LEGACY METHOD
	MOVLW	255
	BANKSEL	PWM1S1P1L
	MOVWF	PWM1S1P1L
	MOVWF	PWM1S1P1H
GLOBAL	SYSFORLOOP1
SYSFORLOOP1:
	BANKSEL	PWM1S1P1L
	INCF	PWM1S1P1L,F
	BTFSC	STATUS,2
	INCF	PWM1S1P1H,F
;wait 1 ms
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	BANKSEL	STATUS
	CALL	DELAY_MS
;PWM1CON = 0x00
	BANKSEL	PWM1CON
	CLRF	PWM1CON
;PWM1CON = 0x80
	MOVLW	128
	MOVWF	PWM1CON
;Next
	MOVF	PWM1S1P1L,W
	MOVWF	SYSWORDTEMPA
	MOVF	PWM1S1P1H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	232
	MOVWF	SYSWORDTEMPB
	MOVLW	3
	MOVWF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSFORLOOP1
GLOBAL	SYSFORLOOPEND1
SYSFORLOOPEND1:
;wait 2  s
	MOVLW	2
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;for PWMval = 0x3E8 to 0x00 Step -1
	MOVLW	232
	BANKSEL	PWM1S1P1L
	MOVWF	PWM1S1P1L
	MOVLW	3
	MOVWF	PWM1S1P1H
GLOBAL	SYSFORLOOP2
SYSFORLOOP2:
;INIT SYSFORLOOPSTEP1 :#0
	MOVLW	255
	BANKSEL	SYSFORLOOPSTEP1
	MOVWF	SYSFORLOOPSTEP1
	MOVWF	SYSFORLOOPSTEP1_H
;wait 1 ms
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;PWM1CON = 0x00
	BANKSEL	PWM1CON
	CLRF	PWM1CON
;PWM1CON = 0x80
	MOVLW	128
	MOVWF	PWM1CON
;Next
;INTEGER NEGATIVE STEP HANDLER IN FOR-NEXT STATEMENT
	BANKSEL	SYSFORLOOPSTEP1_H
	BTFSS	SYSFORLOOPSTEP1_H,7
	GOTO	ELSE2_1
;SET SYSFORLOOPABSVALUE TO -STEPVALUE :#1 
	COMF	SYSFORLOOPSTEP1,W
	MOVWF	SYSFORLOOPABSVALUE2
	COMF	SYSFORLOOPSTEP1_H,W
	MOVWF	SYSFORLOOPABSVALUE2_H
	INCF	SYSFORLOOPABSVALUE2,F
	BTFSC	STATUS,2
	INCF	SYSFORLOOPABSVALUE2_H,F
	BANKSEL	PWM1S1P1L
;IF ( PWMVAL - 0) } [WORD]SYSFORLOOPABSVALUE2 THEN  :#1N 
	MOVLW	0
	SUBWF	PWM1S1P1L,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	MOVLW	0
	BANKSEL	PWM1S1P1H
	SUBWFB	PWM1S1P1H,W
	BANKSEL	SYSTEMP1_H
	MOVWF	SYSTEMP1_H
	MOVF	SYSTEMP1,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	SYSFORLOOPABSVALUE2,W
	MOVWF	SYSWORDTEMPB
	MOVF	SYSFORLOOPABSVALUE2_H,W
	MOVWF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF3
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A NEGATIVE VALUE
	MOVF	SYSFORLOOPSTEP1,W
	BANKSEL	PWM1S1P1L
	ADDWF	PWM1S1P1L,F
	BANKSEL	SYSFORLOOPSTEP1_H
	MOVF	SYSFORLOOPSTEP1_H,W
	BANKSEL	PWM1S1P1H
	ADDWFC	PWM1S1P1H,F
	GOTO	SYSFORLOOP2
;END IF
GLOBAL	ENDIF3
ENDIF3:
	GOTO	ENDIF2
GLOBAL	ELSE2_1
ELSE2_1:
;INTEGER POSITIVE STEP HANDLER IN FOR-NEXT STATEMENT
	BANKSEL	PWM1S1P1L
;IF ([WORD]0 - [WORD]PWMVAL) } [WORD]SYSFORLOOPSTEP1 THEN :#1P 
	MOVF	PWM1S1P1L,W
	SUBLW	0
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	CLRF	SYSTEMP2
	BANKSEL	PWM1S1P1H
	MOVF	PWM1S1P1H,W
	BANKSEL	SYSTEMP2
	SUBWFB	SYSTEMP2,W
	MOVWF	SYSTEMP1_H
	MOVF	SYSTEMP1,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	SYSFORLOOPSTEP1,W
	MOVWF	SYSWORDTEMPB
	MOVF	SYSFORLOOPSTEP1_H,W
	MOVWF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF4
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	MOVF	SYSFORLOOPSTEP1,W
	BANKSEL	PWM1S1P1L
	ADDWF	PWM1S1P1L,F
	BANKSEL	SYSFORLOOPSTEP1_H
	MOVF	SYSFORLOOPSTEP1_H,W
	BANKSEL	PWM1S1P1H
	ADDWFC	PWM1S1P1H,F
	GOTO	SYSFORLOOP2
;END IF
GLOBAL	ENDIF4
ENDIF4:
;END IF
GLOBAL	ENDIF2
ENDIF2:
GLOBAL	SYSFORLOOPEND2
SYSFORLOOPEND2:
;wait 2 s
	MOVLW	2
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
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

;SOURCE: 250_PWM16BIT_VARIABLE_MODES.GCB (16)
GLOBAL	INITPPS
INITPPS:
;RC0PPS = 0x0B;  //RC0->PWM1_16BIT:PWM11
	MOVLW	11
	BANKSEL	RC0PPS
	MOVWF	RC0PPS
;RC1PPS = 0x0B;  //RC1->PWM1_16BIT:PWM11
	MOVLW	11
	MOVWF	RC1PPS
;RC2PPS = 0x0B;  //RC2->PWM1_16BIT:PWM11
	MOVLW	11
	MOVWF	RC2PPS
;RC3PPS = 0x0B;  //RC3->PWM1_16BIT:PWM11
	MOVLW	11
	MOVWF	RC3PPS
	BANKSEL	STATUS
	RETURN

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

;SOURCE: SYSTEM.H (3413)
GLOBAL	SYSCOMPLESSTHAN16
SYSCOMPLESSTHAN16:
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
	BTFSS	STATUS,0
;return
	RETURN
;Test high, exit true if less
;movf SysWordTempB_H,W
	MOVF	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	SUBWF	SYSWORDTEMPA_H,W
;btfss STATUS,C
	BTFSS	STATUS,0
;goto SCLT16True
	GOTO	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	MOVF	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	SUBWF	SYSWORDTEMPA,W
;btfsc STATUS,C
	BTFSC	STATUS,0
;return
	RETURN
GLOBAL	SCLT16TRUE
SCLT16TRUE:
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
