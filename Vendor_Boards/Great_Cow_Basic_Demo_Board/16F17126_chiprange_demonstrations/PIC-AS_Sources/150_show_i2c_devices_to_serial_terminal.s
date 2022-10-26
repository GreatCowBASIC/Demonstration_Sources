;Program compiled by Great Cow BASIC (1.00.00 Release Candidate 2022-10-19 (Windows 64 bit) : Build 1181) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F17126
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17126_chiprange_demonstrations\150_show_i2c_devices_to_serial_terminal.s"
 SUBTITLE    "10-26-2022"

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
GLOBAL	COMPORT
 COMPORT                          EQU 32          ; 0X20
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 112          ; 0X70
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 113          ; 0X71
GLOBAL	DEVICEID
 DEVICEID                         EQU 33          ; 0X21
GLOBAL	DISPLAYNEWLINE
 DISPLAYNEWLINE                   EQU 34          ; 0X22
GLOBAL	HI2CACKPOLLSTATE
 HI2CACKPOLLSTATE                 EQU 35          ; 0X23
GLOBAL	HI2CCURRENTMODE
 HI2CCURRENTMODE                  EQU 36          ; 0X24
GLOBAL	HI2CWAITMSSPTIMEOUT
 HI2CWAITMSSPTIMEOUT              EQU 37          ; 0X25
GLOBAL	HSERPRINTCRLFCOUNT
 HSERPRINTCRLFCOUNT               EQU 38          ; 0X26
GLOBAL	I2CBYTE
 I2CBYTE                          EQU 39          ; 0X27
GLOBAL	PRINTLEN
 PRINTLEN                         EQU 40          ; 0X28
GLOBAL	SERDATA
 SERDATA                          EQU 41          ; 0X29
GLOBAL	STRINGPOINTER
 STRINGPOINTER                    EQU 42          ; 0X2A
GLOBAL	SYSBYTETEMPA
 SYSBYTETEMPA                     EQU 117          ; 0X75
GLOBAL	SYSBYTETEMPB
 SYSBYTETEMPB                     EQU 121          ; 0X79
GLOBAL	SYSBYTETEMPX
 SYSBYTETEMPX                     EQU 112          ; 0X70
GLOBAL	SYSDIVLOOP
 SYSDIVLOOP                       EQU 116          ; 0X74
GLOBAL	SYSPRINTDATAHANDLER
 SYSPRINTDATAHANDLER              EQU 43          ; 0X2B
GLOBAL	SYSPRINTDATAHANDLER_H
 SYSPRINTDATAHANDLER_H            EQU 44          ; 0X2C
GLOBAL	SYSPRINTTEMP
 SYSPRINTTEMP                     EQU 45          ; 0X2D
GLOBAL	SYSREPEATTEMP1
 SYSREPEATTEMP1                   EQU 46          ; 0X2E
GLOBAL	SYSSTRINGA
 SYSSTRINGA                       EQU 119          ; 0X77
GLOBAL	SYSSTRINGA_H
 SYSSTRINGA_H                     EQU 120          ; 0X78
GLOBAL	SYSSTRINGTEMP
 SYSSTRINGTEMP                    EQU 47          ; 0X2F
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 48          ; 0X30
GLOBAL	SYSTEMP2
 SYSTEMP2                         EQU 49          ; 0X31
GLOBAL	SYSVALTEMP
 SYSVALTEMP                       EQU 50          ; 0X32
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73
GLOBAL	_HEXPICAS
 _HEXPICAS                        EQU 124          ; 0X7C

;********************************************************************************

;ALIAS VARIABLES
GLOBAL	AFSR0
 AFSR0                            EQU 4
GLOBAL	AFSR0_H
 AFSR0_H                          EQU 5
GLOBAL	SYS_HEXPICAS_0
 SYS_HEXPICAS_0                   EQU 124
GLOBAL	SYS_HEXPICAS_1
 SYS_HEXPICAS_1                   EQU 125
GLOBAL	SYS_HEXPICAS_2
 SYS_HEXPICAS_2                   EQU 126

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
	CALL	INITUSART
	CALL	HI2CINIT

;START OF THE MAIN PROGRAM
;''
;''  This demonstration shows the I2C devices attached the microcontroller, this program support the Microchip I2C module.
;''
;''  I2C device required a data bus and a clock bus, devices also required an input voltage and 0v.
;''   I2C data bus is connected to PortA.4
;''   I2C clock bus is connected to PortA.1
;''   Serial output is connected, as previously, to PortC.4
;''
;''  Connect your IC2 devices and see the results on the serial terminal.
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.02
;''@date    31.10.2022
;----- Configuration
;Chip Settings.
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:   -------------SDA--SW------SCL-ADC--
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
;Setup Serial port
;Define I2C settings
;Initialise I2C - note for the I2C module the ports need to be set to IN
;Dir HI2C_DATA In
	BSF	TRISA,4
;Dir HI2C_CLOCK In
	BSF	TRISA,1
;HI2CMode (Master)
	MOVLW	12
	MOVWF	HI2CCURRENTMODE
	CALL	HI2CMODE
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim DeviceID As Byte
;Dim DISPLAYNEWLINE As Byte
;Do
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "Hardware I2C"
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Now assumes Serial Terminal is operational
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "   "
	MOVLW	LOW STRINGTABLE2
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE2) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;Create a horizontal row of numbers
;For DeviceID = 0 To 15
;LEGACY METHOD
	MOVLW	255
	MOVWF	DEVICEID
GLOBAL	SYSFORLOOP1
SYSFORLOOP1:
	INCF	DEVICEID,F
;HSerPrint Hex(deviceID)
	MOVF	DEVICEID,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrint " "
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;Next
	MOVLW	15
	SUBWF	DEVICEID,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
GLOBAL	SYSFORLOOPEND1
SYSFORLOOPEND1:
;Create a vertical column of numbers
;For DeviceID = 0 To 255
;LEGACY METHOD
	MOVLW	255
	MOVWF	DEVICEID
GLOBAL	SYSFORLOOP2
SYSFORLOOP2:
	INCF	DEVICEID,F
;DisplayNewLine = DeviceID % 16
	MOVF	DEVICEID,W
	MOVWF	SYSBYTETEMPA
	MOVLW	16
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPX,W
	MOVWF	DISPLAYNEWLINE
;If DisplayNewLine = 0 Then
	MOVF	DISPLAYNEWLINE,F
	BTFSS	STATUS,2
	GOTO	ENDIF2
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint Hex(DeviceID)
	MOVF	DEVICEID,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;If DisplayNewLine > 0 Then
	MOVF	DISPLAYNEWLINE,W
	SUBLW	0
	BTFSC	STATUS,0
	GOTO	ENDIF5
;HSerPrint " "
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;End If
GLOBAL	ENDIF5
ENDIF5:
;End If
GLOBAL	ENDIF2
ENDIF2:
;HSerPrint " "
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;Do an initial Start
;HI2CStart
	CALL	HI2CSTART
;HI2CSend ( DeviceID )
	MOVF	DEVICEID,W
	MOVWF	I2CBYTE
	CALL	HI2CSEND
;If HI2CWaitMSSPTimeout <> TRUE Then
	INCF	HI2CWAITMSSPTIMEOUT,W
	BTFSC	STATUS,2
	GOTO	ELSE3_1
;Did device fail to respond?
;If HI2CAckpollState = FALSE Then
	MOVF	HI2CACKPOLLSTATE,F
	BTFSS	STATUS,2
	GOTO	ELSE6_1
;HSerPrint   Hex(deviceID)
	MOVF	DEVICEID,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HI2CSend ( 0 )
	CLRF	I2CBYTE
	CALL	HI2CSEND
;Else
	GOTO	ENDIF6
GLOBAL	ELSE6_1
ELSE6_1:
;HSerPrint "--"
	MOVLW	LOW STRINGTABLE4
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE4) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;End If
GLOBAL	ENDIF6
ENDIF6:
;Else
	GOTO	ENDIF3
GLOBAL	ELSE3_1
ELSE3_1:
;HSerPrint "! "
	MOVLW	LOW STRINGTABLE5
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE5) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;End If
GLOBAL	ENDIF3
ENDIF3:
;HI2CStop
	CALL	HI2CSTOP
;Next
	MOVLW	255
	SUBWF	DEVICEID,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP2
GLOBAL	SYSFORLOOPEND2
SYSFORLOOPEND2:
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint   "End of Search"
	MOVLW	LOW STRINGTABLE6
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE6) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT304
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Wait While SwitchIn = Off
GLOBAL	SYSWAITLOOP1
SYSWAITLOOP1:
	BTFSS	PORTA,3
	GOTO	SYSWAITLOOP1
;Loop
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
;----- Support methods.  Subroutines and Functions
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

;SOURCE: HWI2C.H (709)
GLOBAL	HI2CINIT
HI2CINIT:
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K42s family chips
;HI2CCurrentMode = 0
	CLRF	HI2CCURRENTMODE
;Initialise the I2C module
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (257)
GLOBAL	HI2CMODE
HI2CMODE:
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required, sets the SSPCON1.bits
;#ifdef var(SSPCON1) added to separate from newer i2C module which does not have an SSPCON1
;set SSPSTAT.SMP on
	BANKSEL	SSP1STAT
	BSF	SSP1STAT,7
;set SSPCON1.CKP on
	BSF	SSP1CON1,4
;set SSPCON1.WCOL Off
	BCF	SSP1CON1,7
;Select mode and clock
;If HI2CCurrentMode = Master Then
	MOVLW	12
	BANKSEL	HI2CCURRENTMODE
	SUBWF	HI2CCURRENTMODE,W
	BTFSS	STATUS,2
	GOTO	ENDIF12
;set SSPCON1.SSPM3 on
	BANKSEL	SSP1CON1
	BSF	SSP1CON1,3
;set SSPCON1.SSPM2 off
	BCF	SSP1CON1,2
;set SSPCON1.SSPM1 off
	BCF	SSP1CON1,1
;set SSPCON1.SSPM0 off
	BCF	SSP1CON1,0
;SSPADD = HI2C_BAUD_TEMP and 127
	MOVLW	19
	MOVWF	SSP1ADD
;end if
GLOBAL	ENDIF12
ENDIF12:
;if HI2CCurrentMode = Slave then
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,F
	BTFSS	STATUS,2
	GOTO	ENDIF13
;set SSPCON1.SSPM3 off
	BANKSEL	SSP1CON1
	BCF	SSP1CON1,3
;set SSPCON1.SSPM2 on
	BSF	SSP1CON1,2
;set SSPCON1.SSPM1 on
	BSF	SSP1CON1,1
;set SSPCON1.SSPM0 off
	BCF	SSP1CON1,0
;end if
GLOBAL	ENDIF13
ENDIF13:
;if HI2CCurrentMode = Slave10 then
	MOVLW	3
	BANKSEL	HI2CCURRENTMODE
	SUBWF	HI2CCURRENTMODE,W
	BTFSS	STATUS,2
	GOTO	ENDIF14
;set SSPCON1.SSPM3 off
	BANKSEL	SSP1CON1
	BCF	SSP1CON1,3
;set SSPCON1.SSPM2 on
	BSF	SSP1CON1,2
;set SSPCON1.SSPM1 on
	BSF	SSP1CON1,1
;set SSPCON1.SSPM0 on
	BSF	SSP1CON1,0
;end if
GLOBAL	ENDIF14
ENDIF14:
;Enable I2C
;set SSPCON1.SSPEN on
	BANKSEL	SSP1CON1
	BSF	SSP1CON1,5
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (428)
GLOBAL	HI2CSEND
HI2CSEND:
;asm showdebug  This method sets the registers and register bits to send I2C data
GLOBAL	RETRYHI2CSEND
RETRYHI2CSEND:
;Clear WCOL
;SET SSPCON1.WCOL OFF
	BANKSEL	SSP1CON1
	BCF	SSP1CON1,7
;Load data to send
;SSPBUF = I2CByte
	BANKSEL	I2CBYTE
	MOVF	I2CBYTE,W
	BANKSEL	SSP1BUF
	MOVWF	SSP1BUF
;HI2CWaitMSSP
	BANKSEL	STATUS
	CALL	HI2CWAITMSSP
;if ACKSTAT =  1 then
	BANKSEL	SSP1CON2
	BTFSS	SSP1CON2,6
	GOTO	ELSE17_1
;HI2CAckPollState = true
	MOVLW	255
	BANKSEL	HI2CACKPOLLSTATE
	MOVWF	HI2CACKPOLLSTATE
;else
	GOTO	ENDIF17
GLOBAL	ELSE17_1
ELSE17_1:
;HI2CAckPollState = false
	BANKSEL	HI2CACKPOLLSTATE
	CLRF	HI2CACKPOLLSTATE
;end if
GLOBAL	ENDIF17
ENDIF17:
;If SSPCON1.WCOL = On Then
	BANKSEL	SSP1CON1
	BTFSS	SSP1CON1,7
	GOTO	ENDIF18
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
	BTFSC	STATUS,0
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	GOTO	RETRYHI2CSEND
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
;End If
GLOBAL	ENDIF18
ENDIF18:
;Release clock (only needed by slave)
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
	BTFSS	STATUS,0
	GOTO	ENDIF19
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	BANKSEL	SSP1CON1
	BSF	SSP1CON1,4
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
GLOBAL	ENDIF19
ENDIF19:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (312)
GLOBAL	HI2CSTART
HI2CSTART:
;asm showdebug  This method sets the registers and register bits to generate the I2C  START signal
;If HI2CCurrentMode > 10 Then
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
	BTFSC	STATUS,0
	GOTO	ELSE15_1
;Master_mode operational
;Set SEN On
	BANKSEL	SSP1CON2
	BSF	SSP1CON2,0
;HI2CWaitMSSP
	BANKSEL	STATUS
	CALL	HI2CWAITMSSP
;Else
	GOTO	ENDIF15
GLOBAL	ELSE15_1
ELSE15_1:
;Slave mode operational
;Wait Until SSPSTAT.S = On
GLOBAL	SYSWAITLOOP2
SYSWAITLOOP2:
	BANKSEL	SSP1STAT
	BTFSS	SSP1STAT,3
	GOTO	SYSWAITLOOP2
;End If
GLOBAL	ENDIF15
ENDIF15:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (362)
GLOBAL	HI2CSTOP
HI2CSTOP:
;Master_mode
;If HI2CCurrentMode > 10 Then
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
	BTFSC	STATUS,0
	GOTO	ELSE16_1
;set SSPIE OFF; disable SSP interrupt, tested by Anobium but not implemented.
;wait while R_NOT_W = 1   'wait for completion of activities
GLOBAL	SYSWAITLOOP3
SYSWAITLOOP3:
	BANKSEL	SSP1STAT
	BTFSC	SSP1STAT,2
	GOTO	SYSWAITLOOP3
;Set SSPCON2.PEN On
	BSF	SSP1CON2,2
;Set SSPCON2.PEN On
	BSF	SSP1CON2,2
;HI2CWaitMSSP
	BANKSEL	STATUS
	CALL	HI2CWAITMSSP
;Slave mode
;Else
	GOTO	ENDIF16
GLOBAL	ELSE16_1
ELSE16_1:
;Wait Until SSPSTAT.P = On
GLOBAL	SYSWAITLOOP4
SYSWAITLOOP4:
	BANKSEL	SSP1STAT
	BTFSS	SSP1STAT,4
	GOTO	SYSWAITLOOP4
;End If
GLOBAL	ENDIF16
ENDIF16:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (515)
GLOBAL	HI2CWAITMSSP
HI2CWAITMSSP:
;HI2CWaitMSSPTimeout = 0
	CLRF	HI2CWAITMSSPTIMEOUT
GLOBAL	HI2CWAITMSSPWAIT
HI2CWAITMSSPWAIT:
;HI2CWaitMSSPTimeout++
	BANKSEL	HI2CWAITMSSPTIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,F
;if HI2CWaitMSSPTimeout < 255 then
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W
	BTFSC	STATUS,0
	GOTO	ENDIF21
;'Support for SSP1IF
;if SSP1IF = 0 then goto HI2CWaitMSSPWait
	BANKSEL	PIR5
	BTFSS	PIR5,2
;if SSP1IF = 0 then goto HI2CWaitMSSPWait
	GOTO	HI2CWAITMSSPWAIT
;if SSP1IF = 0 then goto HI2CWaitMSSPWait
;SSP1IF = 0
	BCF	PIR5,2
;end if
GLOBAL	ENDIF21
ENDIF21:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: STRING:BYTE:, SOURCE: USART.H (2317)
GLOBAL	HSERPRINT304
HSERPRINT304:
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
	GOTO	ENDIF10
;Write Data
;for SysPrintTemp = 1 to PrintLen
	MOVLW	1
	MOVWF	SYSPRINTTEMP
GLOBAL	SYSFORLOOP4
SYSFORLOOP4:
;HSerSend(PrintData(SysPrintTemp),comport )
	MOVF	SYSPRINTTEMP,W
	ADDWF	SYSPRINTDATAHANDLER,W
	MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSPRINTDATAHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SERDATA
	CALL	HSERSEND294
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
	GOTO	ENDIF11
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	SYSPRINTTEMP,F
	GOTO	SYSFORLOOP4
;END IF
GLOBAL	ENDIF11
ENDIF11:
GLOBAL	SYSFORLOOPEND4
SYSFORLOOPEND4:
;End If
GLOBAL	ENDIF10
ENDIF10:
;CR
;All Usarts
;--------------------------
;Specific USARTs
;------------------
	RETURN

;********************************************************************************

;SOURCE: USART.H (2525)
GLOBAL	HSERPRINTCRLF
HSERPRINTCRLF:
;repeat HSerPrintCRLFCount
	MOVF	HSERPRINTCRLFCOUNT,W
	MOVWF	SYSREPEATTEMP1
	BTFSC	STATUS,2
	GOTO	SYSREPEATLOOPEND1
GLOBAL	SYSREPEATLOOP1
SYSREPEATLOOP1:
;HSerSend(13,comport)
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND294
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND294
;end Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
GLOBAL	SYSREPEATLOOPEND1
SYSREPEATLOOPEND1:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (1468)
GLOBAL	HSERSEND294
HSERSEND294:
GLOBAL	HSERSENDUSART1HANDLER
HSERSENDUSART1HANDLER:
;USART_TX_BLOCKING
;Wait While TXIF = Off
GLOBAL	SYSWAITLOOP5
SYSWAITLOOP5:
	BANKSEL	PIR4
	BTFSS	PIR4,6
	GOTO	SYSWAITLOOP5
;Wait until TRMT = 1
GLOBAL	SYSWAITLOOP6
SYSWAITLOOP6:
	BANKSEL	TX1STA
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP6
;TXREG = SerData
	BANKSEL	SERDATA
	MOVF	SERDATA,W
	BANKSEL	TX1REG
	MOVWF	TX1REG
;Wait USART_DELAY
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	BANKSEL	STATUS
	GOTO	DELAY_MS

;********************************************************************************

;SOURCE: 150_SHOW_I2C_DEVICES_TO_SERIAL_TERMINAL.GCB (28)
GLOBAL	INITPPS
INITPPS:
;RC4PPS = 0x13          'RC4->EUSART1:TX1
	MOVLW	19
	BANKSEL	RC4PPS
	MOVWF	RC4PPS
;SSP1CLKPPS = 0x1;   'RA1->MSSP1:SCL1;
	MOVLW	1
	BANKSEL	SSP1CLKPPS
	MOVWF	SSP1CLKPPS
;RA1PPS = 0x1B;      'RA1->MSSP1:SCL1;
	MOVLW	27
	BANKSEL	RA1PPS
	MOVWF	RA1PPS
;SSP1DATPPS = 0x4;   'RA4->MSSP1:SDA1;
	MOVLW	4
	BANKSEL	SSP1DATPPS
	MOVWF	SSP1DATPPS
;RA4PPS = 0x1C;      'RA4->MSSP1:SDA1;
	MOVLW	28
	BANKSEL	RA4PPS
	MOVWF	RA4PPS
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

;SOURCE: USART.H (945)
GLOBAL	INITUSART
INITUSART:
;Set the default value for USART handler - required when more than one USART
;comport = 1
	MOVLW	1
	MOVWF	COMPORT
;PIC USART 1 Init
;Set baud rate for chips with BRG16 bit
;SPBRGH = SPBRGH_TEMP
	MOVLW	3
	BANKSEL	SP1BRGH
	MOVWF	SP1BRGH
;SPBRGL = SPBRGL_TEMP
	MOVLW	64
	MOVWF	SP1BRGL
;BRG16: 16-bit Baud Rate Generator bit
;1 = bsf - 16-bit Baud Rate Generator is used
;0 = bcf - 8-bit Baud Rate Generator is used
;BRG16 = BRG16_TEMP
	BSF	BAUD1CON,3
;Set High Baud Rate Select bit
;BRGH = BRGH_TEMP
	BSF	TX1STA,2
;Enable async and TX mode
;[canskip]SYNC=0
	BCF	TX1STA,4
;[canskip]TXEN=1
	BSF	TX1STA,5
;SPEN=1
	BSF	RC1STA,7
;CREN=1
	BSF	RC1STA,4
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
	RETLW	12
	RETLW	72	;H
	RETLW	97	;A
	RETLW	114	;R
	RETLW	100	;D
	RETLW	119	;W
	RETLW	97	;A
	RETLW	114	;R
	RETLW	101	;E
	RETLW	32	; 
	RETLW	73	;I
	RETLW	50	;2
	RETLW	67	;C


GLOBAL	STRINGTABLE2
STRINGTABLE2:
	RETLW	3
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 


GLOBAL	STRINGTABLE3
STRINGTABLE3:
	RETLW	1
	RETLW	32	; 


GLOBAL	STRINGTABLE4
STRINGTABLE4:
	RETLW	2
	RETLW	45	;-
	RETLW	45	;-


GLOBAL	STRINGTABLE5
STRINGTABLE5:
	RETLW	2
	RETLW	33	;!
	RETLW	32	; 


GLOBAL	STRINGTABLE6
STRINGTABLE6:
	RETLW	13
	RETLW	69	;E
	RETLW	110	;N
	RETLW	100	;D
	RETLW	32	; 
	RETLW	111	;O
	RETLW	102	;F
	RETLW	32	; 
	RETLW	83	;S
	RETLW	101	;E
	RETLW	97	;A
	RETLW	114	;R
	RETLW	99	;C
	RETLW	104	;H


;********************************************************************************

;SOURCE: PICAS.H (7)
GLOBAL	FN__HEXPICAS
FN__HEXPICAS:
;_HexPICAS(0) = 2
	MOVLW	2
	MOVWF	SYS_HEXPICAS_0
;dim SysStringTemp as byte
;Low nibble
;SysStringTemp = SysValTemp And 0x0F
	MOVLW	15
	ANDWF	SYSVALTEMP,W
	MOVWF	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
	BTFSC	STATUS,0
	GOTO	ENDIF7
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
GLOBAL	ENDIF7
ENDIF7:
;_HexPICAS(2) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W
	MOVWF	SYS_HEXPICAS_2
;Get high nibble
;For SysStringTemp = 1 to 4
;LEGACY METHOD
	CLRF	SYSSTRINGTEMP
GLOBAL	SYSFORLOOP3
SYSFORLOOP3:
	INCF	SYSSTRINGTEMP,F
;Rotate SysValTemp Right
	RRF	SYSVALTEMP,F
;Next
	MOVLW	4
	SUBWF	SYSSTRINGTEMP,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP3
GLOBAL	SYSFORLOOPEND3
SYSFORLOOPEND3:
;SysStringTemp = SysValTemp And 0x0F
	MOVLW	15
	ANDWF	SYSVALTEMP,W
	MOVWF	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
	BTFSC	STATUS,0
	GOTO	ENDIF9
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
GLOBAL	ENDIF9
ENDIF9:
;_HexPICAS(1) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W
	MOVWF	SYS_HEXPICAS_1
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
