;Program compiled by GCBASIC (2025.02.06 (Windows 64 bit) : Build 1462) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2025-02-06 CRC248
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : C:\GCstudio\gcbasic\demos\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\GCB Project\17\17_show_i2c_devices_to_serial_terminal.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 0
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : C:\GCstudio\gcbasic\demos\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\GCB Project\17\17_show_i2c_devices_to_serial_terminal.asm
;   Float Capability : 
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F76, r=DEC
 TITLE       "C:\GCstudio\gcbasic\demos\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\GCB Project\17\17_show_i2c_devices_to_serial_terminal.gcb"
 SUBTITLE    "02-11-2025 19:55:51"
#include <P16F76.inc>
 __CONFIG _CP_OFF & _WDTE_OFF & _FOSC_HS

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
ACKSTAT                          EQU      32          ; 0x20
COMPORT                          EQU      33          ; 0x21
DELAYTEMP                        EQU     112          ; 0x70 (SA)
DELAYTEMP2                       EQU     113          ; 0x71 (SA)
DEVICEID                         EQU      34          ; 0x22
DISPLAYNEWLINE                   EQU      35          ; 0x23
HI2CACKPOLLSTATE                 EQU      36          ; 0x24
HI2CCURRENTMODE                  EQU      37          ; 0x25
HI2CWAITMSSPTIMEOUT              EQU      38          ; 0x26
HSERPRINTCRLFCOUNT               EQU      39          ; 0x27
I2CBYTE                          EQU      40          ; 0x28
PRINTLEN                         EQU      41          ; 0x29
SERDATA                          EQU      42          ; 0x2A
STRINGPOINTER                    EQU      43          ; 0x2B
SYSBYTETEMPA                     EQU     117          ; 0x75 (SA)
SYSBYTETEMPB                     EQU     121          ; 0x79 (SA)
SYSBYTETEMPX                     EQU     112          ; 0x70 (SA)
SYSCALCTEMPA                     EQU     117          ; 0x75 (SA)
SYSDIVLOOP                       EQU     116          ; 0x74 (SA)
SYSPRINTDATAHANDLER              EQU      44          ; 0x2C
SYSPRINTDATAHANDLER_H            EQU      45          ; 0x2D
SYSPRINTTEMP                     EQU      46          ; 0x2E
SYSREPEATTEMP1                   EQU      47          ; 0x2F
SYSSTRINGA                       EQU     119          ; 0x77 (SA)
SYSSTRINGA_H                     EQU     120          ; 0x78 (SA)
SYSSTRINGB                       EQU     114          ; 0x72 (SA)
SYSSTRINGB_H                     EQU     115          ; 0x73 (SA)
SYSSTRINGLENGTH                  EQU     118          ; 0x76 (SA)
SYSSTRINGPARAM1                  EQU     482          ; 0x1E2
SYSSTRINGTEMP                    EQU      48          ; 0x30
SYSTEMP1                         EQU      49          ; 0x31
SYSVALTEMP                       EQU      50          ; 0x32
SYSWAITTEMPMS                    EQU     114          ; 0x72 (SA)
SYSWAITTEMPMS_H                  EQU     115          ; 0x73 (SA)
SYSWAITTEMPS                     EQU     116          ; 0x74 (SA)
SYSWAITTEMPUS                    EQU     117          ; 0x75 (SA)
SYSWAITTEMPUS_H                  EQU     118          ; 0x76 (SA)
_HEXPICAS                        EQU     478          ; 0x1DE

;********************************************************************************

;Alias variables
SYS_HEXPICAS_0 EQU 478
SYS_HEXPICAS_1 EQU 479
SYS_HEXPICAS_2 EQU 480

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
	retfie

;********************************************************************************

;Program_memory_page: 0
	ORG	5
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITUSART
	call	HI2CINIT

;Start_of_the_main_program
	banksel	TRISB
	bcf	TRISB,0
	bcf	TRISB,1
	bcf	TRISB,2
	bcf	TRISB,3
	bsf	TRISA,0
	bsf	TRISA,4
	movlw	12
	banksel	HI2CCURRENTMODE
	movwf	HI2CCURRENTMODE
	call	HI2CMODE
	movlw	1
	movwf	SysWaitTempS
	call	Delay_S
	movlw	255
	movwf	SERDATA
	call	HSERSEND343
SysDoLoop_S1
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	high StringTable1
	movwf	SysStringA_H
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT356
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable2
	movwf	SysStringA
	movlw	high StringTable2
	movwf	SysStringA_H
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT356
	movlw	255
	movwf	DEVICEID
SysForLoop1
	incf	DEVICEID,F
	movf	DEVICEID,W
	movwf	SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT356
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable3
	movwf	SysStringA
	movlw	high StringTable3
	movwf	SysStringA_H
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT356
	movlw	15
	subwf	DEVICEID,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
	movlw	255
	movwf	DEVICEID
SysForLoop2
	incf	DEVICEID,F
	movf	DEVICEID,W
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	call	SYSDIVSUB
	movf	SysBYTETempX,W
	movwf	DISPLAYNEWLINE
	movf	DISPLAYNEWLINE,F
	btfss	STATUS, Z
	goto	ENDIF2
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
	movf	DEVICEID,W
	movwf	SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT356
	movf	DISPLAYNEWLINE,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF5
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable3
	movwf	SysStringA
	movlw	high StringTable3
	movwf	SysStringA_H
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT356
ENDIF5
ENDIF2
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable3
	movwf	SysStringA
	movlw	high StringTable3
	movwf	SysStringA_H
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT356
	call	HI2CSTART
	movf	DEVICEID,W
	movwf	I2CBYTE
	call	HI2CSEND
	clrf	I2CBYTE
	call	HI2CSEND
	call	HI2CSTOP
	movf	HI2CACKPOLLSTATE,F
	btfss	STATUS, Z
	goto	ELSE3_1
	movf	DEVICEID,W
	movwf	SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT356
	goto	ENDIF3
ELSE3_1
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable4
	movwf	SysStringA
	movlw	high StringTable4
	movwf	SysStringA_H
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT356
ENDIF3
	movlw	255
	subwf	DEVICEID,W
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable5
	movwf	SysStringA
	movlw	high StringTable5
	movwf	SysStringA_H
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT356
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
SysWaitLoop1
	btfsc	PORTA,4
	goto	SysWaitLoop1
	goto	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	227
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	6
	movwf	DELAYTEMP
DMS_INNER
	decfsz	DELAYTEMP, F
	goto	DMS_INNER
	decfsz	DELAYTEMP2, F
	goto	DMS_OUTER
	decfsz	SysWaitTempMS, F
	goto	DMS_START
	decfsz	SysWaitTempMS_H, F
	goto	DMS_START
	return

;********************************************************************************

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS
	movlw	3
	movwf	SysWaitTempMS_H
	call	Delay_MS
	decfsz	SysWaitTempS, F
	goto	DS_START
	return

;********************************************************************************

HI2CINIT
;This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K-Mode family chips
	clrf	HI2CCURRENTMODE
	return

;********************************************************************************

HI2CMODE
;This method sets the variable `HI2CCurrentMode`, and, if required, sets the SSPCON1.bits
	banksel	SSPSTAT
	bsf	SSPSTAT,SMP
	banksel	SSPCON
	bsf	SSPCON,CKP
	bcf	SSPCON,WCOL
	movlw	12
	subwf	HI2CCURRENTMODE,W
	btfss	STATUS, Z
	goto	ENDIF12
	bsf	SSPCON,SSPM3
	bcf	SSPCON,SSPM2
	bcf	SSPCON,SSPM1
	bcf	SSPCON,SSPM0
	movlw	49
	banksel	SSPADD
	movwf	SSPADD
ENDIF12
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,F
	btfss	STATUS, Z
	goto	ENDIF13
	bcf	SSPCON,SSPM3
	bsf	SSPCON,SSPM2
	bsf	SSPCON,SSPM1
	bcf	SSPCON,SSPM0
ENDIF13
	movlw	3
	subwf	HI2CCURRENTMODE,W
	btfss	STATUS, Z
	goto	ENDIF14
	bcf	SSPCON,SSPM3
	bsf	SSPCON,SSPM2
	bsf	SSPCON,SSPM1
	bsf	SSPCON,SSPM0
ENDIF14
	bsf	SSPCON,SSPEN
	return

;********************************************************************************

HI2CSEND
;This method sets the registers and register bits to send I2C data
RETRYHI2CSEND
	bcf	SSPCON,WCOL
	movf	I2CBYTE,W
	movwf	SSPBUF
	call	HI2CWAITMSSP
	decf	ACKSTAT,W
	btfss	STATUS, Z
	goto	ELSE17_1
	movlw	255
	movwf	HI2CACKPOLLSTATE
	goto	ENDIF17
ELSE17_1
	clrf	HI2CACKPOLLSTATE
ENDIF17
	btfss	SSPCON,WCOL
	goto	ENDIF18
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	RETRYHI2CSEND
ENDIF18
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	bsf	SSPCON,CKP
	return

;********************************************************************************

HI2CSTART
;This method sets the registers and register bits to generate the I2C  START signal
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE15_1
	goto	ENDIF15
ELSE15_1
SysWaitLoop4
	banksel	SSPSTAT
	btfss	SSPSTAT,S
	goto	SysWaitLoop4
ENDIF15
	banksel	STATUS
	return

;********************************************************************************

HI2CSTOP
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE16_1
	goto	ENDIF16
ELSE16_1
SysWaitLoop5
	banksel	SSPSTAT
	btfss	SSPSTAT,P
	goto	SysWaitLoop5
ENDIF16
	banksel	STATUS
	return

;********************************************************************************

HI2CWAITMSSP
	clrf	HI2CWAITMSSPTIMEOUT
HI2CWAITMSSPWAIT
	incf	HI2CWAITMSSPTIMEOUT,F
	movlw	255
	subwf	HI2CWAITMSSPTIMEOUT,W
	btfsc	STATUS, C
	goto	ENDIF21
	btfsc	PIR1,SSPIF
	goto	ENDIF22
	movlw	3
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	goto	HI2CWAITMSSPWAIT
ENDIF22
	bcf	PIR1,SSPIF
ENDIF21
	return

;********************************************************************************

HSERPRINT356
	movf	SysPRINTDATAHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysPRINTDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	PRINTLEN
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	goto	ENDIF9
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd4
SysForLoop4
	incf	SYSPRINTTEMP,F
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysPRINTDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	SERDATA
	call	HSERSEND344
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop4
SysForLoopEnd4
ENDIF9
	return

;********************************************************************************

HSERPRINTCRLF
	movf	HSERPRINTCRLFCOUNT,W
	movwf	SysRepeatTemp1
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd1
SysRepeatLoop1
	movlw	13
	movwf	SERDATA
	call	HSERSEND344
	movlw	10
	movwf	SERDATA
	call	HSERSEND344
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

HSERSEND343
SysWaitLoop2
	btfss	PIR1,TXIF
	goto	SysWaitLoop2
SysWaitLoop3
	banksel	TXSTA
	btfss	TXSTA,TRMT
	goto	SysWaitLoop3
	banksel	SERDATA
	movf	SERDATA,W
	movwf	TXREG
	return

;********************************************************************************

HSERSEND344
HSERSENDUSART1HANDLER
SysWaitLoop6
	btfss	PIR1,TXIF
	goto	SysWaitLoop6
SysWaitLoop7
	banksel	TXSTA
	btfss	TXSTA,TRMT
	goto	SysWaitLoop7
	banksel	SERDATA
	movf	SERDATA,W
	movwf	TXREG
	return

;********************************************************************************

INITSYS
;_For_selected_frequency_-_the_external_oscillator_has_been_selected_by_compiler ChipMHz
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
	bcf	ADCON0,ADON
	banksel	ADCON1
	bsf	ADCON1,PCFG2
	bsf	ADCON1,PCFG1
	bcf	ADCON1,PCFG0
	banksel	PORTA
	clrf	PORTA
	clrf	PORTB
	clrf	PORTC
	return

;********************************************************************************

INITUSART
	movlw	129
	banksel	SPBRG
	movwf	SPBRG
	bsf	TXSTA,BRGH
	bcf	TXSTA,SYNC
	bsf	TXSTA,TXEN
	banksel	RCSTA
	bsf	RCSTA,SPEN
	bsf	RCSTA,CREN
	bsf	RCSTA,CREN
	return

;********************************************************************************

SYSDIVSUB
	movf	SYSBYTETEMPB, F
	btfsc	STATUS, Z
	return
	clrf	SYSBYTETEMPX
	movlw	8
	movwf	SYSDIVLOOP
SYSDIV8START
	bcf	STATUS, C
	rlf	SYSBYTETEMPA, F
	rlf	SYSBYTETEMPX, F
	movf	SYSBYTETEMPB, W
	subwf	SYSBYTETEMPX, F
	bsf	SYSBYTETEMPA, 0
	btfsc	STATUS, C
	goto	DIV8NOTNEG
	bcf	SYSBYTETEMPA, 0
	movf	SYSBYTETEMPB, W
	addwf	SYSBYTETEMPX, F
DIV8NOTNEG
	decfsz	SYSDIVLOOP, F
	goto	SYSDIV8START
	return

;********************************************************************************

SYSREADSTRING
	movf	SYSSTRINGB, W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SYSSTRINGB_H, 0
	bsf	STATUS, IRP
	call	SYSSTRINGTABLES
	movwf	SYSCALCTEMPA
	movwf	INDF
	addwf	SYSSTRINGB, F
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
	movf	SYSSTRINGB, W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SYSSTRINGB_H, 0
	bsf	STATUS, IRP
	call	SYSSTRINGTABLES
	movwf	SYSCALCTEMPA
	addwf	SYSSTRINGLENGTH,F
	addwf	SYSSTRINGB,F
SYSSTRINGREADCHECK
	movf	SYSCALCTEMPA,F
	btfsc	STATUS,Z
	return
SYSSTRINGREAD
	call	SYSSTRINGTABLES
	incf	FSR, F
	movwf	INDF
	decfsz	SYSCALCTEMPA, F
	goto	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable1
	retlw	12
	retlw	72	;H
	retlw	97	;a
	retlw	114	;r
	retlw	100	;d
	retlw	119	;w
	retlw	97	;a
	retlw	114	;r
	retlw	101	;e
	retlw	32	; 
	retlw	73	;I
	retlw	50	;2
	retlw	67	;C


StringTable2
	retlw	3
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable3
	retlw	1
	retlw	32	; 


StringTable4
	retlw	2
	retlw	45	;-
	retlw	45	;-


StringTable5
	retlw	13
	retlw	69	;E
	retlw	110	;n
	retlw	100	;d
	retlw	32	; 
	retlw	111	;o
	retlw	102	;f
	retlw	32	; 
	retlw	83	;S
	retlw	101	;e
	retlw	97	;a
	retlw	114	;r
	retlw	99	;c
	retlw	104	;h


;********************************************************************************

FN__HEXPICAS
	movlw	2
	banksel	SYS_HEXPICAS_0
	movwf	SYS_HEXPICAS_0
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W
	movwf	SYSSTRINGTEMP
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF6
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF6
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYS_HEXPICAS_2
	movwf	SYS_HEXPICAS_2
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP
SysForLoop3
	incf	SYSSTRINGTEMP,F
	rrf	SYSVALTEMP,F
	movlw	4
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop3
SysForLoopEnd3
	movlw	15
	andwf	SYSVALTEMP,W
	movwf	SYSSTRINGTEMP
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF8
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF8
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYS_HEXPICAS_1
	movwf	SYS_HEXPICAS_1
	banksel	STATUS
	return

;********************************************************************************

;Program_memory_page: 1
	ORG	2048
;Program_memory_page: 2
	ORG	4096
;Program_memory_page: 3
	ORG	6144

 END
