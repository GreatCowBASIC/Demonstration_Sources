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
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16f18075_chiprange_demonstrations\310_ringbuffer_hardware_serial_loopback_to_terminal.s"
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
GLOBAL	BGETC
 BGETC                            EQU 32          ; 0X20
GLOBAL	BUFFER
 BUFFER                           EQU 9136          ; 0X23B0
GLOBAL	COMPORT
 COMPORT                          EQU 33          ; 0X21
GLOBAL	DEFAULTUSARTRETURNVALUE
 DEFAULTUSARTRETURNVALUE          EQU 34          ; 0X22
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 112          ; 0X70
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 113          ; 0X71
GLOBAL	HSERRECEIVE
 HSERRECEIVE                      EQU 35          ; 0X23
GLOBAL	LOCAL_NEXT_OUT
 LOCAL_NEXT_OUT                   EQU 36          ; 0X24
GLOBAL	NEXT_IN
 NEXT_IN                          EQU 37          ; 0X25
GLOBAL	NEXT_OUT
 NEXT_OUT                         EQU 38          ; 0X26
GLOBAL	PRINTLEN
 PRINTLEN                         EQU 39          ; 0X27
GLOBAL	SAVEFSR0H
 SAVEFSR0H                        EQU 40          ; 0X28
GLOBAL	SAVEFSR0L
 SAVEFSR0L                        EQU 41          ; 0X29
GLOBAL	SAVEPCLATH
 SAVEPCLATH                       EQU 42          ; 0X2A
GLOBAL	SAVESYSBYTETEMPA
 SAVESYSBYTETEMPA                 EQU 43          ; 0X2B
GLOBAL	SAVESYSBYTETEMPB
 SAVESYSBYTETEMPB                 EQU 44          ; 0X2C
GLOBAL	SAVESYSBYTETEMPX
 SAVESYSBYTETEMPX                 EQU 45          ; 0X2D
GLOBAL	SAVESYSDIVLOOP
 SAVESYSDIVLOOP                   EQU 46          ; 0X2E
GLOBAL	SAVESYSTEMP1
 SAVESYSTEMP1                     EQU 47          ; 0X2F
GLOBAL	SERDATA
 SERDATA                          EQU 48          ; 0X30
GLOBAL	STRINGPOINTER
 STRINGPOINTER                    EQU 49          ; 0X31
GLOBAL	SYSBSR
 SYSBSR                           EQU 50          ; 0X32
GLOBAL	SYSBYTETEMPA
 SYSBYTETEMPA                     EQU 117          ; 0X75
GLOBAL	SYSBYTETEMPB
 SYSBYTETEMPB                     EQU 121          ; 0X79
GLOBAL	SYSBYTETEMPX
 SYSBYTETEMPX                     EQU 112          ; 0X70
GLOBAL	SYSDIVLOOP
 SYSDIVLOOP                       EQU 116          ; 0X74
GLOBAL	SYSINTSTATESAVE0
 SYSINTSTATESAVE0                 EQU 51          ; 0X33
GLOBAL	SYSPRINTDATAHANDLER
 SYSPRINTDATAHANDLER              EQU 52          ; 0X34
GLOBAL	SYSPRINTDATAHANDLER_H
 SYSPRINTDATAHANDLER_H            EQU 53          ; 0X35
GLOBAL	SYSPRINTTEMP
 SYSPRINTTEMP                     EQU 54          ; 0X36
GLOBAL	SYSSTATUS
 SYSSTATUS                        EQU 127          ; 0X7F
GLOBAL	SYSSTRINGA
 SYSSTRINGA                       EQU 119          ; 0X77
GLOBAL	SYSSTRINGA_H
 SYSSTRINGA_H                     EQU 120          ; 0X78
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 55          ; 0X37
GLOBAL	SYSTEMP2
 SYSTEMP2                         EQU 56          ; 0X38
GLOBAL	SYSW
 SYSW                             EQU 126          ; 0X7E
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73
GLOBAL	SYSWAITTEMPS
 SYSWAITTEMPS                     EQU 116          ; 0X74
GLOBAL	TEMPPNT
 TEMPPNT                          EQU 57          ; 0X39

;********************************************************************************

;ALIAS VARIABLES
GLOBAL	AFSR0
 AFSR0                            EQU 4
GLOBAL	AFSR0_H
 AFSR0_H                          EQU 5
GLOBAL	SYSHSERRECEIVEBYTE
 SYSHSERRECEIVEBYTE               EQU 35

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
	MOVF	FSR0L,W
	MOVWF	SAVEFSR0L
	MOVF	SYSTEMP1,W
	MOVWF	SAVESYSTEMP1
	MOVF	FSR0H,W
	MOVWF	SAVEFSR0H
	MOVF	SYSBYTETEMPA,W
	MOVWF	SAVESYSBYTETEMPA
	MOVF	SYSBYTETEMPB,W
	MOVWF	SAVESYSBYTETEMPB
	MOVF	SYSBYTETEMPX,W
	MOVWF	SAVESYSBYTETEMPX
	MOVF	SYSDIVLOOP,W
	MOVWF	SAVESYSDIVLOOP
	MOVF	PCLATH,W
	MOVWF	SAVEPCLATH
	CLRF	PCLATH
;ON INTERRUPT HANDLERS
	BANKSEL	PIE3
	BTFSS	PIE3,3
	GOTO	NOTRC1IF
	BTFSS	PIR3,3
	GOTO	NOTRC1IF
	BANKSEL	STATUS
	CALL	READUSART
	BANKSEL	PIR3
	BCF	PIR3,3
	GOTO	INTERRUPTDONE
GLOBAL	NOTRC1IF
NOTRC1IF:
;USER INTERRUPT ROUTINE
GLOBAL	INTERRUPTDONE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	BANKSEL	SAVEFSR0L
	MOVF	SAVEFSR0L,W
	MOVWF	FSR0L
	MOVF	SAVESYSTEMP1,W
	MOVWF	SYSTEMP1
	MOVF	SAVEFSR0H,W
	MOVWF	FSR0H
	MOVF	SAVESYSBYTETEMPA,W
	MOVWF	SYSBYTETEMPA
	MOVF	SAVESYSBYTETEMPB,W
	MOVWF	SYSBYTETEMPB
	MOVF	SAVESYSBYTETEMPX,W
	MOVWF	SYSBYTETEMPX
	MOVF	SAVESYSDIVLOOP,W
	MOVWF	SYSDIVLOOP
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
	ORG	62
GLOBAL	BASPROGRAMSTART
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS
	CALL	INITPPS
	CALL	INITUSART
;ENABLE INTERRUPTS
	BSF	INTCON,7
	BSF	INTCON,6

;START OF THE MAIN PROGRAM
;''
;''  This demonstration shows the use of the serial USART - the microcontroller recieves a byte and then sends it back using a ring buffer (using an Interrupt).
;''
;''  Connect your terminal (via a USB/TTL device) to the microcontroller and see the results on the serial terminal.
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.02
;''@date    03/01/2022
;----- Configuration
;Generated by PIC PPS Tool for GCBASIC
;PPS Tool version: 0.0.6.2
;PinManager data: Not available (3)
;Generated for 16F18075
;
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;Config hardware UART
;Wait 100 Ms
	MOVLW	100
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;This assumes you are using an ANSI compatible terminal.  Use PUTTY.EXE it is very easy to use.
;Main program
;Wait for terminal to settle
;wait 3 s
	MOVLW	3
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;Create the supporting variables
;Dim next_in As Byte
;Dim next_out As Byte
;Dim syncbyte As Byte
;Dim temppnt As Byte
;Constants etc required for Buffer Ring
;Define the Buffer
;Dim buffer( BUFFER_SIZE - 1 ) 'we will use element 0 in the array as part of out buffer
;Call init the buffer
;InitBufferRing
	CALL	INITBUFFERRING
;HSerSend 10
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND296
;HSerSend 13
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND296
;HSerSend 10
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND296
;HSerSend 13
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND296
;HSerPrint "Started: Serial between two devices"
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT307
;HSerSend 10
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND296
;HSerSend 13
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND296
;Get character(s) and send back
;Do
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;Do we have data in the buffer?
;if bkbhit then
	MOVF	NEXT_OUT,W
	SUBWF	NEXT_IN,W
	BTFSC	STATUS,2
	GOTO	ENDIF1
;Send the next character in the buffer, exposed via the function `bgetc` back the terminal
;HSerSend bgetc
	CALL	FN_BGETC
	MOVF	BGETC,W
	MOVWF	SERDATA
	CALL	HSERSEND296
;end if
GLOBAL	ENDIF1
ENDIF1:
;Loop
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
;Supporting subroutines
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: 310_RINGBUFFER_HARDWARE_SERIAL_LOOPBACK_TO_TERMINAL.GCB (101)
GLOBAL	FN_BGETC
FN_BGETC:
;Dim local_next_out as Byte    'maintain a local copy of the next_out variable to ensure it does not change when an Interrupt happens
;local_next_out = next_out
	MOVF	NEXT_OUT,W
	MOVWF	LOCAL_NEXT_OUT
;bgetc = buffer(local_next_out)
	MOVLW	LOW(BUFFER)
	ADDWF	LOCAL_NEXT_OUT,W
	MOVWF	FSR0L
	CLRF	SYSTEMP1
	MOVLW	HIGH(BUFFER)
	ADDWFC	SYSTEMP1,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	BGETC
;local_next_out=(local_next_out+1) % BUFFER_SIZE
	INCF	LOCAL_NEXT_OUT,W
	MOVWF	SYSTEMP1
	MOVWF	SYSBYTETEMPA
	MOVLW	64
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPX,W
	MOVWF	LOCAL_NEXT_OUT
;INTOFF
	BCF	SYSINTSTATESAVE0,0
	BTFSC	INTCON,7
	BSF	SYSINTSTATESAVE0,0
	BCF	INTCON,7
;next_out = local_next_out
	MOVF	LOCAL_NEXT_OUT,W
	MOVWF	NEXT_OUT
;INTON
	BTFSS	SYSINTSTATESAVE0,0
	BCF	INTCON,7
	BTFSC	SYSINTSTATESAVE0,0
	BSF	INTCON,7
	RETURN

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

;OVERLOADED SIGNATURE: STRING:BYTE:, SOURCE: USART.H (1526)
GLOBAL	HSERPRINT307
HSERPRINT307:
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
	GOTO	ENDIF2
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
	CALL	HSERSEND297
;next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	MOVF	SYSPRINTTEMP,W
	SUBWF	PRINTLEN,W
	MOVWF	SYSTEMP1
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	CALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF3
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	SYSPRINTTEMP,F
	GOTO	SYSFORLOOP1
;END IF
GLOBAL	ENDIF3
ENDIF3:
GLOBAL	SYSFORLOOPEND1
SYSFORLOOPEND1:
;End If
GLOBAL	ENDIF2
ENDIF2:
;CR
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: , SOURCE: USART.H (1191)
GLOBAL	FN_HSERRECEIVE298
FN_HSERRECEIVE298:
;Comport = 1
	MOVLW	1
	MOVWF	COMPORT
;HSerReceive( SerData )
	CALL	HSERRECEIVE302
;HSerReceive = SerData
	MOVF	SERDATA,W
	MOVWF	HSERRECEIVE
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: USART.H (1218)
GLOBAL	HSERRECEIVE302
HSERRECEIVE302:
;Needs comport to be set first by calling routines
;if comport = 1 Then
	DECF	COMPORT,W
	BTFSS	STATUS,2
	GOTO	ENDIF6
;SerData = DefaultUsartReturnValue
	MOVF	DEFAULTUSARTRETURNVALUE,W
	MOVWF	SERDATA
;If set up to block, wait for data
;Wait Until USARTHasData
GLOBAL	SYSWAITLOOP5
SYSWAITLOOP5:
	BANKSEL	PIR3
	BTFSS	PIR3,3
	GOTO	SYSWAITLOOP5
;Get a bytes from FIFO
;If USARTHasData Then
	BTFSS	PIR3,3
	GOTO	ENDIF7
;SerData = RCREG
	BANKSEL	RC1REG
	MOVF	RC1REG,W
	BANKSEL	SERDATA
	MOVWF	SERDATA
;End if
GLOBAL	ENDIF7
ENDIF7:
;Clear error
;If OERR Then
	BANKSEL	RC1STA
	BTFSS	RC1STA,1
	GOTO	ENDIF8
;Set CREN Off
	BCF	RC1STA,4
;Set CREN On
	BSF	RC1STA,4
;End If
GLOBAL	ENDIF8
ENDIF8:
;end if
GLOBAL	ENDIF6
ENDIF6:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: USART.H (871)
GLOBAL	HSERSEND296
HSERSEND296:
;Registers/Bits determined by #samevar at top of library
;#ifdef USART_BLOCKING
;USART_BLOCKING and NOT USART_TX_BLOCKING
;Wait While TXIF = Off
GLOBAL	SYSWAITLOOP1
SYSWAITLOOP1:
	BANKSEL	PIR3
	BTFSS	PIR3,2
	GOTO	SYSWAITLOOP1
;ensure any previous operation has completed @2
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
;Add USART_DELAY after the byte is sent by the USART module
;Wait USART_DELAY
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	BANKSEL	STATUS
	GOTO	DELAY_MS

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (974)
GLOBAL	HSERSEND297
HSERSEND297:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W
	BTFSS	STATUS,2
	GOTO	ENDIF5
;USART_BLOCKING and NOT USART_TX_BLOCKING
;Wait While TXIF = Off
GLOBAL	SYSWAITLOOP3
SYSWAITLOOP3:
	BANKSEL	PIR3
	BTFSS	PIR3,2
	GOTO	SYSWAITLOOP3
;ensure any previous operation has completed
;Wait until TRMT = 1
GLOBAL	SYSWAITLOOP4
SYSWAITLOOP4:
	BANKSEL	TX1STA
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP4
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	BANKSEL	SERDATA
	MOVF	SERDATA,W
	BANKSEL	TX1REG
	MOVWF	TX1REG
;Add USART_DELAY after the byte is sent by the USART module
;Wait USART_DELAY
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	BANKSEL	STATUS
	CALL	DELAY_MS
;end if
GLOBAL	ENDIF5
ENDIF5:
	RETURN

;********************************************************************************

;SOURCE: 310_RINGBUFFER_HARDWARE_SERIAL_LOOPBACK_TO_TERMINAL.GCB (114)
GLOBAL	INITBUFFERRING
INITBUFFERRING:
;Set the buffer to the first address
;next_in = 0
	CLRF	NEXT_IN
;next_out = 0
	CLRF	NEXT_OUT
;Interrupt Handler
;On Interrupt UsartRX1Ready Call readUSART
	BANKSEL	PIE3
	BSF	PIE3,3
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: 310_RINGBUFFER_HARDWARE_SERIAL_LOOPBACK_TO_TERMINAL.GCB (27)
GLOBAL	INITPPS
INITPPS:
;RX1PPS = 0x17; //RC7->EUSART1:RX1;
	MOVLW	23
	BANKSEL	RX1PPS
	MOVWF	RX1PPS
;RC6PPS = 0x0E;  //RC6->EUSART1:TX1;
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

;SOURCE: 310_RINGBUFFER_HARDWARE_SERIAL_LOOPBACK_TO_TERMINAL.GCB (90)
GLOBAL	READUSART
READUSART:
;buffer(next_in) = HSerReceive
	CALL	FN_HSERRECEIVE298
	MOVLW	LOW(BUFFER)
	ADDWF	NEXT_IN,W
	MOVWF	FSR0L
	CLRF	SYSTEMP1
	MOVLW	HIGH(BUFFER)
	ADDWFC	SYSTEMP1,W
	MOVWF	FSR0H
	MOVF	SYSHSERRECEIVEBYTE,W
	MOVWF	INDF0
;temppnt = next_in
	MOVF	NEXT_IN,W
	MOVWF	TEMPPNT
;next_in = ( next_in + 1 ) % BUFFER_SIZE
	INCF	NEXT_IN,W
	MOVWF	SYSTEMP1
	MOVWF	SYSBYTETEMPA
	MOVLW	64
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPX,W
	MOVWF	NEXT_IN
;If ( next_in = next_out ) Then  ' buffer is full!!
	MOVF	NEXT_OUT,W
	SUBWF	NEXT_IN,W
	BTFSS	STATUS,2
	GOTO	ENDIF4
;next_in = temppnt
	MOVF	TEMPPNT,W
	MOVWF	NEXT_IN
;End If
GLOBAL	ENDIF4
ENDIF4:
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

;SOURCE: SYSTEM.H (2793)
GLOBAL	SYSDIVSUB
SYSDIVSUB:
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	MOVF	SYSBYTETEMPB, F
;btfsc STATUS, Z
	BTFSC	STATUS,2
;return
	RETURN
;Main calc routine
;SysByteTempX = 0
	CLRF	SYSBYTETEMPX
;SysDivLoop = 8
	MOVLW	8
	MOVWF	SYSDIVLOOP
GLOBAL	SYSDIV8START
SYSDIV8START:
;bcf STATUS, C
	BCF	STATUS,0
;rlf SysByteTempA, F
	RLF	SYSBYTETEMPA, F
;rlf SysByteTempX, F
	RLF	SYSBYTETEMPX, F
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;subwf SysByteTempX, F
	SUBWF	SYSBYTETEMPX, F
;bsf SysByteTempA, 0
	BSF	SYSBYTETEMPA, 0
;btfsc STATUS, C
	BTFSC	STATUS,0
;goto Div8NotNeg
	GOTO	DIV8NOTNEG
;bcf SysByteTempA, 0
	BCF	SYSBYTETEMPA, 0
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;addwf SysByteTempX, F
	ADDWF	SYSBYTETEMPX, F
GLOBAL	DIV8NOTNEG
DIV8NOTNEG:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv8Start
	GOTO	SYSDIV8START
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
	RETLW	35
	RETLW	83	;S
	RETLW	116	;T
	RETLW	97	;A
	RETLW	114	;R
	RETLW	116	;T
	RETLW	101	;E
	RETLW	100	;D
	RETLW	58	;:
	RETLW	32	; 
	RETLW	83	;S
	RETLW	101	;E
	RETLW	114	;R
	RETLW	105	;I
	RETLW	97	;A
	RETLW	108	;L
	RETLW	32	; 
	RETLW	98	;B
	RETLW	101	;E
	RETLW	116	;T
	RETLW	119	;W
	RETLW	101	;E
	RETLW	101	;E
	RETLW	110	;N
	RETLW	32	; 
	RETLW	116	;T
	RETLW	119	;W
	RETLW	111	;O
	RETLW	32	; 
	RETLW	100	;D
	RETLW	101	;E
	RETLW	118	;V
	RETLW	105	;I
	RETLW	99	;C
	RETLW	101	;E
	RETLW	115	;S


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
