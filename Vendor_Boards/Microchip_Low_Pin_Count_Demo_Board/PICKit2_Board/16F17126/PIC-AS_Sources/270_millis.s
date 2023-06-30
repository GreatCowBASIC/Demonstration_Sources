;Program compiled by GCBASIC (1.00.00 Release Candidate 2022-11-06 (Windows 64 bit) : Build 1189) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F17126
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17126_chiprange_demonstrations\270_millis.s"
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
GLOBAL	CURMS
 CURMS                            EQU 32          ; 0X20
GLOBAL	CURMS_H
 CURMS_H                          EQU 33          ; 0X21
GLOBAL	LSTMS
 LSTMS                            EQU 34          ; 0X22
GLOBAL	LSTMS_H
 LSTMS_H                          EQU 35          ; 0X23
GLOBAL	MILLIS
 MILLIS                           EQU 36          ; 0X24
GLOBAL	MILLIS_E
 MILLIS_E                         EQU 39          ; 0X27
GLOBAL	MILLIS_H
 MILLIS_H                         EQU 37          ; 0X25
GLOBAL	MILLIS_U
 MILLIS_U                         EQU 38          ; 0X26
GLOBAL	MSCTR_
 MSCTR_                           EQU 40          ; 0X28
GLOBAL	MSCTR__E
 MSCTR__E                         EQU 43          ; 0X2B
GLOBAL	MSCTR__H
 MSCTR__H                         EQU 41          ; 0X29
GLOBAL	MSCTR__U
 MSCTR__U                         EQU 42          ; 0X2A
GLOBAL	SAVEPCLATH
 SAVEPCLATH                       EQU 44          ; 0X2C
GLOBAL	SYSBSR
 SYSBSR                           EQU 45          ; 0X2D
GLOBAL	SYSBYTETEMPX
 SYSBYTETEMPX                     EQU 112          ; 0X70
GLOBAL	SYSINTSTATESAVE0
 SYSINTSTATESAVE0                 EQU 46          ; 0X2E
GLOBAL	SYSSTATUS
 SYSSTATUS                        EQU 127          ; 0X7F
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 47          ; 0X2F
GLOBAL	SYSTEMP1_H
 SYSTEMP1_H                       EQU 48          ; 0X30
GLOBAL	SYSTEMP2
 SYSTEMP2                         EQU 49          ; 0X31
GLOBAL	SYSW
 SYSW                             EQU 126          ; 0X7E
GLOBAL	SYSWORDTEMPA
 SYSWORDTEMPA                     EQU 117          ; 0X75
GLOBAL	SYSWORDTEMPA_H
 SYSWORDTEMPA_H                   EQU 118          ; 0X76
GLOBAL	SYSWORDTEMPB
 SYSWORDTEMPB                     EQU 121          ; 0X79
GLOBAL	SYSWORDTEMPB_H
 SYSWORDTEMPB_H                   EQU 122          ; 0X7A
GLOBAL	TMRPOST
 TMRPOST                          EQU 50          ; 0X32
GLOBAL	TMRPRES
 TMRPRES                          EQU 51          ; 0X33
GLOBAL	TMRSOURCE
 TMRSOURCE                        EQU 52          ; 0X34

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
	CALL	MSCTR_INT_HDLR
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
	CALL	INIT_MSCTR_INT
;ENABLE INTERRUPTS
	BSF	INTCON,7
	BSF	INTCON,6
	BSF	SYSINTSTATESAVE0,0

;START OF THE MAIN PROGRAM
;''A demonstration program for GCBASIC.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is a simple GLCD demonstration of the timer capabilities using hthe millis function.
;'':
;'':
;''@author  EvanV
;''@licence GPL
;''@version 1.0
;''@date    31.10.2022
;''********************************************************************************
;Chip Settings
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:   -------------SDA-SW------SCL-ADC--
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
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim CurMs, LstMs as word  ' declare working variables
;Main                    ' This loop runs over and over forever.
;LstMs = 0
	CLRF	LSTMS
	CLRF	LSTMS_H
;CurMs = 0
	CLRF	CURMS
	CLRF	CURMS_H
;Main                    ' This loop runs over and over forever.
;Do
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;CurMs = millis()
	CALL	FN_MILLIS
	MOVF	MILLIS,W
	MOVWF	CURMS
	MOVF	MILLIS_H,W
	MOVWF	CURMS_H
;if CurMs - LstMs >= LEDRate then  ' required Time has Elapsed
	MOVF	LSTMS,W
	SUBWF	CURMS,W
	MOVWF	SYSTEMP1
	MOVF	LSTMS_H,W
	SUBWFB	CURMS_H,W
	MOVWF	SYSTEMP1_H
	MOVF	SYSTEMP1,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	232
	MOVWF	SYSWORDTEMPB
	MOVLW	3
	MOVWF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF1
;LED = !LED                      ' So Toggle state of LED
	CLRF	SYSTEMP2
	BTFSC	PORTC,1
	INCF	SYSTEMP2,F
	COMF	SYSTEMP2,F
	BCF	LATC,1
	BTFSC	SYSTEMP2,0
	BSF	LATC,1
;LstMs = CurMs                   ' And Record Toggle Time
	MOVF	CURMS,W
	MOVWF	LSTMS
	MOVF	CURMS_H,W
	MOVWF	LSTMS_H
;end if
GLOBAL	ENDIF1
ENDIF1:
;IntOn
	BTFSS	SYSINTSTATESAVE0,0
	BCF	INTCON,7
	BTFSC	SYSINTSTATESAVE0,0
	BSF	INTCON,7
;Loop
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
;END
	GOTO	BASPROGRAMEND
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

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
GLOBAL	INITTIMER0182
INITTIMER0182:
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
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	IORWF	TMRPRES,F
;Set the Source bit
;IF TMRSource <> OSC  THEN
	DECF	TMRSOURCE,W
	BTFSC	STATUS,2
	GOTO	ELSE4_1
;SET TMRPost.5 ON
	BSF	TMRPOST,5
;ELSE
	GOTO	ENDIF4
GLOBAL	ELSE4_1
ELSE4_1:
;SET TMRPost.5 OFF
	BCF	TMRPOST,5
;END IF
GLOBAL	ENDIF4
ENDIF4:
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
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
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

;SOURCE: MILLIS.H (165)
GLOBAL	INIT_MSCTR_INT
INIT_MSCTR_INT:
;Add the handler for the interrupt
;On Interrupt Timer0Overflow Call MsCtr_Int_Hdlr
	BANKSEL	PIE0
	BSF	PIE0,5
;MsCtr_ = 0
	BANKSEL	MSCTR_
	CLRF	MSCTR_
	CLRF	MSCTR__H
	CLRF	MSCTR__U
	CLRF	MSCTR__E
;Millis = 0
	CALL	FN_MILLIS
;
;#define PS_0_0 0        ' no clock source
;#define PS_0_1 1
;#define PS_0_8 2
;#define PS_0_64 3
;#define PS_0_256 4
;#define PS_0_1024 5
;asm ShowDebug 16bit capable, but running in 8bit mode
;InitTimer0 Osc, PRE0_32 + TMR0_FOSC4 ,  POST0_1
	MOVLW	1
	MOVWF	TMRSOURCE
	MOVLW	69
	MOVWF	TMRPRES
	CLRF	TMRPOST
	CALL	INITTIMER0182
;asm ShowDebug  Call_SetTimer_Millis_macro
;SetTimer_Millis Tmr0InitVal
;Macro Source: millis.h (372)
;Handle chips with TMR0H
;USe default 8-bit mode
;TMR0L = TMRValueMillis
	MOVLW	6
	BANKSEL	TMR0L
	MOVWF	TMR0L
;asm ShowDebug Call_StartTimer_Millis_macro
;StartTimer_Millis
;Macro Source: millis.h (404)
;Set T0EN on
	BSF	T0CON0,7
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: MILLIS.H (362)
GLOBAL	FN_MILLIS
FN_MILLIS:
;dim Millis, MsCtr_ as long
;disable interrupts while we read millis or we might get an
;inconsistent value (e.g. in the middle of a write to millis)
;IntOff
	BCF	SYSINTSTATESAVE0,1
	BTFSC	INTCON,7
	BSF	SYSINTSTATESAVE0,1
	BCF	INTCON,7
;Millis = MsCtr_
	MOVF	MSCTR_,W
	MOVWF	MILLIS
	MOVF	MSCTR__H,W
	MOVWF	MILLIS_H
	MOVF	MSCTR__U,W
	MOVWF	MILLIS_U
	MOVF	MSCTR__E,W
	MOVWF	MILLIS_E
;IntOn
	BTFSS	SYSINTSTATESAVE0,1
	BCF	INTCON,7
	BTFSC	SYSINTSTATESAVE0,1
	BSF	INTCON,7
	RETURN

;********************************************************************************

;SOURCE: MILLIS.H (155)
GLOBAL	MSCTR_INT_HDLR
MSCTR_INT_HDLR:
;dim MsCtr_ as Long
;asm ShowDebug Call_SetTimer_Millis_macro
;SetTimer_Millis  Tmr0InitVal   ' Reset Inital Counter valueue
;Macro Source: millis.h (372)
;Handle chips with TMR0H
;USe default 8-bit mode
;TMR0L = TMRValueMillis
	MOVLW	6
	BANKSEL	TMR0L
	MOVWF	TMR0L
;MsCtr_ = MsCtr_ + 1
	BANKSEL	MSCTR_
	INCF	MSCTR_,F
	BTFSC	STATUS,2
	INCF	MSCTR__H,F
	BTFSC	STATUS,2
	INCF	MSCTR__U,F
	BTFSC	STATUS,2
	INCF	MSCTR__E,F
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
