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
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18075_chiprange_demonstrations\270_millis_glcd_integrated_with_serial.s"
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
 CONFIG MCLRE=EXTMCLR                            ;C1 Reverselookup MCLRE = EXTMCLR
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
GLOBAL	COMPORT
 COMPORT                          EQU 32          ; 0X20
GLOBAL	CURMS
 CURMS                            EQU 33          ; 0X21
GLOBAL	CURMS_H
 CURMS_H                          EQU 34          ; 0X22
GLOBAL	LSTMS
 LSTMS                            EQU 35          ; 0X23
GLOBAL	LSTMS_H
 LSTMS_H                          EQU 36          ; 0X24
GLOBAL	MILLIS
 MILLIS                           EQU 37          ; 0X25
GLOBAL	MILLIS_E
 MILLIS_E                         EQU 40          ; 0X28
GLOBAL	MILLIS_H
 MILLIS_H                         EQU 38          ; 0X26
GLOBAL	MILLIS_U
 MILLIS_U                         EQU 39          ; 0X27
GLOBAL	MSCTR_
 MSCTR_                           EQU 41          ; 0X29
GLOBAL	MSCTR__E
 MSCTR__E                         EQU 44          ; 0X2C
GLOBAL	MSCTR__H
 MSCTR__H                         EQU 42          ; 0X2A
GLOBAL	MSCTR__U
 MSCTR__U                         EQU 43          ; 0X2B
GLOBAL	PRINTLEN
 PRINTLEN                         EQU 45          ; 0X2D
GLOBAL	SAVEPCLATH
 SAVEPCLATH                       EQU 46          ; 0X2E
GLOBAL	SERDATA
 SERDATA                          EQU 47          ; 0X2F
GLOBAL	STRINGPOINTER
 STRINGPOINTER                    EQU 48          ; 0X30
GLOBAL	SYSBSR
 SYSBSR                           EQU 49          ; 0X31
GLOBAL	SYSBYTETEMPA
 SYSBYTETEMPA                     EQU 117          ; 0X75
GLOBAL	SYSBYTETEMPB
 SYSBYTETEMPB                     EQU 121          ; 0X79
GLOBAL	SYSBYTETEMPX
 SYSBYTETEMPX                     EQU 112          ; 0X70
GLOBAL	SYSINTSTATESAVE0
 SYSINTSTATESAVE0                 EQU 50          ; 0X32
GLOBAL	SYSPRINTDATAHANDLER
 SYSPRINTDATAHANDLER              EQU 51          ; 0X33
GLOBAL	SYSPRINTDATAHANDLER_H
 SYSPRINTDATAHANDLER_H            EQU 52          ; 0X34
GLOBAL	SYSPRINTTEMP
 SYSPRINTTEMP                     EQU 53          ; 0X35
GLOBAL	SYSSTATUS
 SYSSTATUS                        EQU 127          ; 0X7F
GLOBAL	SYSSTRINGA
 SYSSTRINGA                       EQU 119          ; 0X77
GLOBAL	SYSSTRINGA_H
 SYSSTRINGA_H                     EQU 120          ; 0X78
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 54          ; 0X36
GLOBAL	SYSTEMP1_H
 SYSTEMP1_H                       EQU 55          ; 0X37
GLOBAL	SYSTEMP2
 SYSTEMP2                         EQU 56          ; 0X38
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
 TMRPOST                          EQU 57          ; 0X39
GLOBAL	TMRPRES
 TMRPRES                          EQU 58          ; 0X3A
GLOBAL	TMRSOURCE
 TMRSOURCE                        EQU 59          ; 0X3B

;********************************************************************************

;ALIAS VARIABLES
GLOBAL	AFSR0
 AFSR0                            EQU 4
GLOBAL	AFSR0_H
 AFSR0_H                          EQU 5

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
	CALL	INITPPS
	CALL	INITUSART
	CALL	INIT_MSCTR_INT
;ENABLE INTERRUPTS
	BSF	INTCON,7
	BSF	INTCON,6

;START OF THE MAIN PROGRAM
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is a simple GLCD demonstration of the ILI9341 GLCD capabilities.
;''It is a nice graphical LCD, suitable for a lot of various projects.
;''This program draws lines, boxes, Ellipses and prints strings and numbers.
;''The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;'':
;''This has been tested using the hardware SPI option.
;'':
;'':
;''@author  EvanV
;''@licence GPL
;''@version 1.0
;''@date    15/09/2022
;''********************************************************************************
;Chip Settings
;Generated by PIC PPS Tool for Great Cow BASIC
;PPS Tool version: 0.0.6.1
;PinManager data: v1.79.0
;Generated for 16F18075
;
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;********************** MILLIS DEMO REALLY STARTS HERE ************************************************
;Define the LED Pin
;Flash rate in mS
;Setup
;Make the LED Pin an Output
;Dir LED Out
	BCF	TRISB,1
;LED = 0
	BCF	LATB,1
;declare working variables
;Dim CurMs, LstMs As Word
;Main                    ' This loop runs over and over forever.
;LstMs = 0
	CLRF	LSTMS
	CLRF	LSTMS_H
;CurMs = 0
	CLRF	CURMS
	CLRF	CURMS_H
;Do Forever
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;CurMs = millis()
	CALL	FN_MILLIS
	MOVF	MILLIS,W
	MOVWF	CURMS
	MOVF	MILLIS_H,W
	MOVWF	CURMS_H
;If CurMs - LstMs >= LEDRate Then
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
;required Time has Elapsed
;So, Send a message and Toggle state of LED
;HSerPrintStringCRLF "Time Event"
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTSTRINGCRLF
;LED = !LED
	CLRF	SYSTEMP2
	BTFSC	PORTB,1
	INCF	SYSTEMP2,F
	COMF	SYSTEMP2,F
	BCF	LATB,1
	BTFSC	SYSTEMP2,0
	BSF	LATB,1
;And Record Toggle Time
;LstMs = CurMs
	MOVF	CURMS,W
	MOVWF	LSTMS
	MOVF	CURMS_H,W
	MOVWF	LSTMS_H
;End If
GLOBAL	ENDIF1
ENDIF1:
;Loop
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: USART.H (1509)
GLOBAL	HSERPRINTSTRINGCRLF
HSERPRINTSTRINGCRLF:
;PrintLen = PrintData(0)
	MOVF	SYSPRINTDATAHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSPRINTDATAHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	PRINTLEN
;If PrintLen <> 0 then
	MOVF	PRINTLEN,F
	BTFSC	STATUS,2
	GOTO	ENDIF4
;Write Data
;for SysPrintTemp = 1 to PrintLen
	MOVLW	1
	MOVWF	SYSPRINTTEMP
GLOBAL	SYSFORLOOP1
SYSFORLOOP1:
;HSerSend(PrintData(SysPrintTemp),comport )
	MOVF	SYSPRINTTEMP,W
	ADDWF	SYSPRINTDATAHANDLER,W
	MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSPRINTDATAHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SERDATA
	CALL	HSERSEND300
;next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	MOVF	SYSPRINTTEMP,W
	SUBWF	PRINTLEN,W
	MOVWF	SYSTEMP2
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	CALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF5
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	SYSPRINTTEMP,F
	GOTO	SYSFORLOOP1
;END IF
GLOBAL	ENDIF5
ENDIF5:
GLOBAL	SYSFORLOOPEND1
SYSFORLOOPEND1:
;End If
GLOBAL	ENDIF4
ENDIF4:
;HSerSend(13,comport)
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND300
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA
	GOTO	HSERSEND300

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (974)
GLOBAL	HSERSEND300
HSERSEND300:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W
	BTFSS	STATUS,2
	GOTO	ENDIF7
;USART_TX_BLOCKING
;Wait While TXIF = Off
GLOBAL	SYSWAITLOOP1
SYSWAITLOOP1:
	BANKSEL	PIR3
	BTFSS	PIR3,2
	GOTO	SYSWAITLOOP1
;ensure any previous operation has completed
;Wait until TRMT = 1
GLOBAL	SYSWAITLOOP2
SYSWAITLOOP2:
	BANKSEL	TX1STA
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP2
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	BANKSEL	SERDATA
	MOVF	SERDATA,W
	BANKSEL	TX1REG
	MOVWF	TX1REG
;end if
GLOBAL	ENDIF7
ENDIF7:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: 270_MILLIS_GLCD_INTEGRATED_WITH_SERIAL.GCB (32)
GLOBAL	INITPPS
INITPPS:
;Module: EUSART
;RC6PPS = 0x000E    'TX > RC6
	MOVLW	14
	BANKSEL	RC6PPS
	MOVWF	RC6PPS
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
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F180xx MCU family 32 mhz
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
GLOBAL	INITTIMER0183
INITTIMER0183:
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
	GOTO	ELSE6_1
;SET TMRPost.5 ON
	BSF	TMRPOST,5
;ELSE
	GOTO	ENDIF6
GLOBAL	ELSE6_1
ELSE6_1:
;SET TMRPost.5 OFF
	BCF	TMRPOST,5
;END IF
GLOBAL	ENDIF6
ENDIF6:
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

;SOURCE: USART.H (630)
GLOBAL	INITUSART
INITUSART:
;Set the default value for comport
;comport = 1
	MOVLW	1
	MOVWF	COMPORT
;asm showdebug Values_calculated_in_the_script
;asm showdebug _SPBRGH_TEMP=_ SPBRGH_TEMP
;asm showdebug _SPBRGL_TEMP=_ SPBRGL_TEMP
;asm showdebug _BRG16_TEMP=_ BRG16_TEMP
;asm showdebug _BRGH_TEMP=_ BRGH_TEMP
;Set baud rate for legacy chips
;SPBRG = SPBRGL_TEMP
	MOVLW	64
	BANKSEL	SP1BRGL
	MOVWF	SP1BRGL
;Set baud rate for chips with BRG16 bit
;SPBRGH = SPBRGH_TEMP
	MOVLW	3
	MOVWF	SP1BRGH
;SPBRGL = SPBRGL_TEMP
	MOVLW	64
	MOVWF	SP1BRGL
;BRG16: 16-bit Baud Rate Generator bit
;1 = 16-bit Baud Rate Generator is used
;0 = 8-bit Baud Rate Generator is used
;BRG16 = BRG16_TEMP
	BSF	BAUD1CON,3
;Set High Baud Rate Select bit
;BRGH = BRGH_TEMP
	BSF	TX1STA,2
;Enable async and TX mode for most non K42
;Set SYNC Off
;Set TXEN On
;Changed to canskip to silently exit when no USART
;[canskip]SYNC=0
	BCF	TX1STA,4
;[canskip]TXEN=1
	BSF	TX1STA,5
;SPEN=1
	BSF	RC1STA,7
;Enable TX and RX
;CREN=1
	BSF	RC1STA,4
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
	CALL	INITTIMER0183
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
	BCF	SYSINTSTATESAVE0,0
	BTFSC	INTCON,7
	BSF	SYSINTSTATESAVE0,0
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
	BTFSS	SYSINTSTATESAVE0,0
	BCF	INTCON,7
	BTFSC	SYSINTSTATESAVE0,0
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

GLOBAL	SYSSTRINGTABLES
SYSSTRINGTABLES:
	MOVF	SYSSTRINGA_H,W
	MOVWF	PCLATH
	MOVF	SYSSTRINGA,W
	INCF	SYSSTRINGA,F
	BTFSC	STATUS,2
	INCF	SYSSTRINGA_H,F
	MOVWF	PCL

GLOBAL	STRINGTABLE1
STRINGTABLE1:
	RETLW	10
	RETLW	84	;T
	RETLW	105	;I
	RETLW	109	;M
	RETLW	101	;E
	RETLW	32	; 
	RETLW	69	;E
	RETLW	118	;V
	RETLW	101	;E
	RETLW	110	;N
	RETLW	116	;T


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
