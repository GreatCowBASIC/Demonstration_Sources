;Program compiled by GCBASIC (2026.11.05 (Windows 64 bit) : Build 1667) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-11-05 CRC170
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Touch_Sensor_Solutions\Microchip_mTouch\GCBASIC_mTouch_Framework_CVD_8Buttons_Serial_16F1937.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : 
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Touch_Sensor_Solutions\Microchip_mTouch\GCBASIC_mTouch_Framework_CVD_8Buttons_Serial_16F1937.build\GCBASIC_mTouch_Framework_CVD_8Buttons_Serial_16F1937.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1937, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Touch_Sensor_Solutions\Microchip_mTouch\GCBASIC_mTouch_Framework_CVD_8Buttons_Serial_16F1937.gcb"
 SUBTITLE    "11-06-2026 16:03:42"
#include <P16F1937.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _CPD_OFF & _CP_OFF & _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF & _VCAPEN_OFF & _WRT_OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
CHANGESENSOR                     EQU      32          ; 0x20
CHANGESTATE                      EQU      33          ; 0x21
COMPORT                          EQU      34          ; 0x22
CVDDRIVEINVERSE                  EQU      35          ; 0x23
CVDDRIVELEVEL                    EQU      36          ; 0x24
CVDDRIVEMASK                     EQU      37          ; 0x25
CVDDRIVEPORT                     EQU      38          ; 0x26
CVDFLOATMASK                     EQU      39          ; 0x27
CVDFLOATPORT                     EQU      40          ; 0x28
CVDLOOKUPINDEX                   EQU      41          ; 0x29
CVDLOOKUPMASK                    EQU      42          ; 0x2A
CVDLOOKUPPORT                    EQU      43          ; 0x2B
CVDLOOKUPSENSOR                  EQU      44          ; 0x2C
CVDPHASEA                        EQU      45          ; 0x2D
CVDPHASEA_H                      EQU      46          ; 0x2E
CVDPHASEB                        EQU      47          ; 0x2F
CVDPHASEB_H                      EQU      48          ; 0x30
CVDREAD                          EQU      49          ; 0x31
CVDREAD_H                        EQU      50          ; 0x32
CVDREF                           EQU      51          ; 0x33
CVDREFCHANNEL                    EQU      52          ; 0x34
CVDREFMASK                       EQU      53          ; 0x35
CVDREFPORT                       EQU      54          ; 0x36
CVDSENSOR                        EQU      55          ; 0x37
CVDSENSORCHANNEL                 EQU      56          ; 0x38
CVDSENSORMASK                    EQU      57          ; 0x39
CVDSENSORPORT                    EQU      58          ; 0x3A
DELAYTEMP                        EQU     112          ; 0x70 (SA)
DELAYTEMP2                       EQU     113          ; 0x71 (SA)
DELTASENSOR                      EQU      59          ; 0x3B
DELTAVALUE                       EQU      60          ; 0x3C
DELTAVALUE_H                     EQU      61          ; 0x3D
HSERPRINTCRLFCOUNT               EQU      62          ; 0x3E
MILLIS                           EQU      63          ; 0x3F
MILLIS_E                         EQU      66          ; 0x42
MILLIS_H                         EQU      64          ; 0x40
MILLIS_U                         EQU      65          ; 0x41
MSCTR_                           EQU      67          ; 0x43
MSCTR__E                         EQU      70          ; 0x46
MSCTR__H                         EQU      68          ; 0x44
MSCTR__U                         EQU      69          ; 0x45
OUTVALUETEMP                     EQU      71          ; 0x47
PADLABELCHAR                     EQU      72          ; 0x48
PADLABELINDEX                    EQU      73          ; 0x49
PADLABELSENSOR                   EQU      74          ; 0x4A
PRINTLEN                         EQU      75          ; 0x4B
REPORTLASTSTATE                  EQU    8679          ; 0x21E7
REPORTSCANS                      EQU      76          ; 0x4C
REPORTSENSOR                     EQU      77          ; 0x4D
SAVEPCLATH                       EQU      78          ; 0x4E
SERDATA                          EQU      79          ; 0x4F
SERPRINTVAL                      EQU      80          ; 0x50
SERPRINTVAL_H                    EQU      81          ; 0x51
STRINGPOINTER                    EQU      82          ; 0x52
SYSARRAYTEMP1                    EQU      83          ; 0x53
SYSARRAYTEMP1_H                  EQU      84          ; 0x54
SYSARRAYTEMP2                    EQU      85          ; 0x55
SYSBSR                           EQU      86          ; 0x56
SYSBYTETEMPA                     EQU     117          ; 0x75 (SA)
SYSBYTETEMPB                     EQU     121          ; 0x79 (SA)
SYSBYTETEMPX                     EQU     112          ; 0x70 (SA)
SYSCALCTEMPX                     EQU     112          ; 0x70 (SA)
SYSCALCTEMPX_H                   EQU     113          ; 0x71 (SA)
SYSDIVLOOP                       EQU     116          ; 0x74 (SA)
SYSDIVMULTA                      EQU     119          ; 0x77 (SA)
SYSDIVMULTA_H                    EQU     120          ; 0x78 (SA)
SYSDIVMULTB                      EQU     123          ; 0x7B (SA)
SYSDIVMULTB_H                    EQU     124          ; 0x7C (SA)
SYSDIVMULTX                      EQU     114          ; 0x72 (SA)
SYSDIVMULTX_H                    EQU     115          ; 0x73 (SA)
SYSINTSTATESAVE0                 EQU      87          ; 0x57
SYSLONGTEMPA                     EQU     117          ; 0x75 (SA)
SYSLONGTEMPA_E                   EQU     120          ; 0x78 (SA)
SYSLONGTEMPA_H                   EQU     118          ; 0x76 (SA)
SYSLONGTEMPA_U                   EQU     119          ; 0x77 (SA)
SYSLONGTEMPB                     EQU     121          ; 0x79 (SA)
SYSLONGTEMPB_E                   EQU     124          ; 0x7C (SA)
SYSLONGTEMPB_H                   EQU     122          ; 0x7A (SA)
SYSLONGTEMPB_U                   EQU     123          ; 0x7B (SA)
SYSPRINTDATAHANDLER              EQU      88          ; 0x58
SYSPRINTDATAHANDLER_H            EQU      89          ; 0x59
SYSPRINTTEMP                     EQU      90          ; 0x5A
SYSREPEATTEMP1                   EQU      91          ; 0x5B
SYSSTATUS                        EQU     127          ; 0x7F (SA)
SYSSTRINGA                       EQU     119          ; 0x77 (SA)
SYSSTRINGA_H                     EQU     120          ; 0x78 (SA)
SYSTEMP1                         EQU      92          ; 0x5C
SYSTEMP1_H                       EQU      93          ; 0x5D
SYSTEMP2                         EQU      94          ; 0x5E
SYSTEMP2_H                       EQU      95          ; 0x5F
SYSW                             EQU     126          ; 0x7E (SA)
SYSWAITTEMPMS                    EQU     114          ; 0x72 (SA)
SYSWAITTEMPMS_H                  EQU     115          ; 0x73 (SA)
SYSWAITTEMPS                     EQU     116          ; 0x74 (SA)
SYSWAITTEMPUS                    EQU     117          ; 0x75 (SA)
SYSWAITTEMPUS_H                  EQU     118          ; 0x76 (SA)
SYSWORDTEMPA                     EQU     117          ; 0x75 (SA)
SYSWORDTEMPA_H                   EQU     118          ; 0x76 (SA)
SYSWORDTEMPB                     EQU     121          ; 0x79 (SA)
SYSWORDTEMPB_H                   EQU     122          ; 0x7A (SA)
SYSWORDTEMPX                     EQU     112          ; 0x70 (SA)
SYSWORDTEMPX_H                   EQU     113          ; 0x71 (SA)
TMRPRES                          EQU      96          ; 0x60
TMRSOURCE                        EQU      97          ; 0x61
TOUCHBASE                        EQU      98          ; 0x62
TOUCHBASELINE                    EQU    8661          ; 0x21D5
TOUCHBASELINESCANS               EQU    8652          ; 0x21CC
TOUCHBASE_H                      EQU      99          ; 0x63
TOUCHCOUNT                       EQU     100          ; 0x64
TOUCHCOUNTED                     EQU     101          ; 0x65
TOUCHCOUNTED_H                   EQU     102          ; 0x66
TOUCHDELTA                       EQU     103          ; 0x67
TOUCHDELTAS                      EQU    8634          ; 0x21BA
TOUCHDELTA_H                     EQU     104          ; 0x68
TOUCHDOWN                        EQU     105          ; 0x69
TOUCHDOWN_H                      EQU     106          ; 0x6A
TOUCHELAPSEDMS                   EQU     107          ; 0x6B
TOUCHELAPSEDMS_E                 EQU     110          ; 0x6E
TOUCHELAPSEDMS_H                 EQU     108          ; 0x6C
TOUCHELAPSEDMS_U                 EQU     109          ; 0x6D
TOUCHFILTERED                    EQU    8616          ; 0x21A8
TOUCHINITSENSOR                  EQU     111          ; 0x6F
TOUCHJITTERCOUNT                 EQU     160          ; 0xA0
TOUCHJITTERSEED                  EQU     161          ; 0xA1
TOUCHLASTMS                      EQU     162          ; 0xA2
TOUCHLASTMS_E                    EQU     165          ; 0xA5
TOUCHLASTMS_H                    EQU     163          ; 0xA3
TOUCHLASTMS_U                    EQU     164          ; 0xA4
TOUCHNEWSCAN                     EQU     166          ; 0xA6
TOUCHNOWMS                       EQU     167          ; 0xA7
TOUCHNOWMS_E                     EQU     170          ; 0xAA
TOUCHNOWMS_H                     EQU     168          ; 0xA8
TOUCHNOWMS_U                     EQU     169          ; 0xA9
TOUCHNOWSTATE                    EQU     171          ; 0xAB
TOUCHRAW                         EQU     172          ; 0xAC
TOUCHRAW_H                       EQU     173          ; 0xAD
TOUCHSCANINDEX                   EQU     174          ; 0xAE
TOUCHSCANS                       EQU    8598          ; 0x2196
TOUCHSERVICESENSOR               EQU     175          ; 0xAF
TOUCHSTARTSENSOR                 EQU     176          ; 0xB0
TOUCHSTATE                       EQU    8589          ; 0x218D
TOUCHSUM                         EQU     177          ; 0xB1
TOUCHSUMS                        EQU    8571          ; 0x217B
TOUCHSUM_H                       EQU     178          ; 0xB2
TOUCHUP                          EQU     179          ; 0xB3
TOUCHUP_H                        EQU     180          ; 0xB4
TOUCHVALUE                       EQU     181          ; 0xB5
TOUCHVALUE_H                     EQU     182          ; 0xB6

;********************************************************************************

;Alias variables
AFSR0 EQU 4
AFSR0_H EQU 5
SYSTOUCHSTATE_0 EQU 621
SYSTOUCHSTATE_1 EQU 622
SYSTOUCHSTATE_2 EQU 623
SYSTOUCHSTATE_3 EQU 672
SYSTOUCHSTATE_4 EQU 673
SYSTOUCHSTATE_5 EQU 674
SYSTOUCHSTATE_6 EQU 675
SYSTOUCHSTATE_7 EQU 676

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
INTERRUPT

;********************************************************************************

;Save Context
	movwf	SysW
	swapf	STATUS,W
	movwf	SysSTATUS
	movf	BSR,W
	banksel	STATUS
	movwf	SysBSR
;Store system variables
	movf	PCLATH,W
	movwf	SavePCLATH
	clrf	PCLATH
;On Interrupt handlers
	btfss	INTCON,TMR0IE
	goto	NotTMR0IF
	btfss	INTCON,TMR0IF
	goto	NotTMR0IF
	pagesel	MSCTR_INT_HDLR
	call	MSCTR_INT_HDLR
	pagesel	$
	bcf	INTCON,TMR0IF
	goto	INTERRUPTDONE
NotTMR0IF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	movf	SavePCLATH,W
	movwf	PCLATH
	movf	SysBSR,W
	movwf	BSR
	swapf	SysSTATUS,W
	movwf	STATUS
	swapf	SysW,F
	swapf	SysW,W
	retfie

;********************************************************************************

;Program_memory_page: 0
	ORG	32
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITUSART
	call	INIT_MSCTR_INT
;Enable interrupts
	bsf	INTCON,GIE
	bsf	INTCON,PEIE
;Automatic pin direction setting
	banksel	TRISE
	clrf	TRISE

;Start_of_the_main_program
;
;A demonstration program for GCBASIC.
;--------------------------------------------------------------------------------
;mTouch capacitive touch, eight buttons, with the readings on the serial port, on the Microchip mTouch CVD
;Evaluation Board (PIC16F1937, assembly 02-02091) with the 8-button sensor board (02-02094). The touch sensing is
;the library mTouchCVD_8Buttons.h, the same as GCBASIC_mTouch_Framework_CVD_8Buttons_16F1937.gcb: Microchip's
;mTouch Framework v2.3 method. This version adds the serial output, to watch the readings and tune the thresholds.
;See GCBASIC_mTouch_Framework_CVD_8Buttons_explained.md for how it works.
;
;Board
;o PIC16F1937 at 32 MHz (internal oscillator with the PLL)
;o Sensors 0-7 on AN0-AN7: RA0, RA1, RA2, RA3, RA5, RE0, RE1, RE2
;o LEDs for sensors 0-7 (on when low): RC2, RC1, RC0, RA7, RA6, RA4, RD7, RD6
;o EUSART TX on RC6, 115200 baud 8N1 (the mTouch One-Way GUI's rate), to a TTL / USB serial adapter
;
;On startup all eight LEDs light for one second. Then each LED lights while its button is touched, and the serial
;port sends one of two outputs, chosen by SERIAL_MTOUCH_GUI:
;
;SERIAL_MTOUCH_GUI 0 - text for a terminal: a banner, then
;a line when a pad is pressed or released, by its label on the sensor board (sensor 0-7 = pad 8, 9, A-F):
;Pad B pressed
;every 0.25 s, each pad's delta above its baseline and its state (L learning, . released, P pressed), under
;a heading line of the pad labels sent at start-up:
;pad    8   9   A   B   C   D   E   F
;d     12   0   3 310   0   1   0   0  ...P....
;Tuning: touch each button and note its delta; TOUCH_PRESS (in mTouchCVD_8Buttons.h) should sit well below
;the smallest touched delta and well above the largest untouched one, with TOUCH_RELEASE at about half of it.
;
;SERIAL_MTOUCH_GUI 1 - the mTouch Framework's one-way format, for Microchip's mTouch One-Way GUI (mComm.c,
;MCOMM_UART_ONE_WAY, decimal): every 50 ms one line of zero-padded fields, each followed by a comma, then CR LF
;state mask (5 digits, bit n = sensor n pressed), toggle mask (5, 0), slider (3, 0), then each sensor's
;reading (5): its last 8-reading sum
;00008,00000,000,08190,08201,08187,08597,08176,08199,08204,08188,
;View it with mTouch_Monitor.html (start mTouch_Monitor.cmd): pads, states and a live graph in Chrome or Edge.
;
;@author    Evan R. Venn
;@license   GPL
;@version   1.02
;
;1.00  New: the 8-button demo with press / release lines and the deltas every 0.25 s on the serial port
;1.01  SERIAL_MTOUCH_GUI 1: the mTouch Framework's one-way format for the mTouch One-Way GUI; 115200 baud for both
;outputs
;1.02  Text output names the pads by their labels on the sensor board (8, 9, A-F), with a heading line
;
;---- Configuration
;---- Serial: EUSART TX RC6
;SERIAL_MTOUCH_GUI 1: the mTouch One-Way GUI format; 0: text for a terminal
;Text: the deltas every REPORT_SCANS scans of TOUCH_PERIOD_MS (25 x 10 ms = 0.25 s). GUI: a line every GUI_SCANS
;scans (5 x 10 ms = 50 ms; a line is 64 characters, about 5.6 ms at 115200)
;---- LEDs, one per sensor, on when low
;Dir LED0 Out
	bcf	TRISC,2
;Dir LED1 Out
	bcf	TRISC,1
;Dir LED2 Out
	bcf	TRISC,0
;Dir LED3 Out
	bcf	TRISA,7
;Dir LED4 Out
	bcf	TRISA,6
;Dir LED5 Out
	bcf	TRISA,4
;Dir LED6 Out
	bcf	TRISD,7
;Dir LED7 Out
	bcf	TRISD,6
;Each sensor's state at the last scan, to see a press or a release; scans since the last report
;Dim ReportLastState(TOUCH_SENSORS) As Byte
;Dim ReportScans As Byte
;Dim ReportSensor As Byte
;---- Main
;LEDs off, the sensor pins driven low
;LedsOff
	banksel	STATUS
	pagesel	LEDSOFF
	call	LEDSOFF
	pagesel	$
;TouchInit
	call	TOUCHINIT
;Start-up: all LEDs on for one second while the pads settle. Keep off the pads until 0.3 s after they go out:
;the scans then set the baselines
;LedsOn
	pagesel	LEDSON
	call	LEDSON
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HSerPrint "mTouch CVD 8 buttons, press "
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT381
;HSerPrint TOUCH_PRESS
	movlw	250
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	call	HSERPRINT383
	pagesel	$
;HSerPrint ", release "
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT381
;HSerPrint TOUCH_RELEASE
	movlw	125
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	call	HSERPRINT383
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HSerPrint "pad  "
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT381
;For ReportSensor = 0 To TOUCH_SENSORS - 1
;Legacy method
	movlw	255
	movwf	REPORTSENSOR
SysForLoop1
	incf	REPORTSENSOR,F
;HSerPrint "    "
	movlw	low StringTable7
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT381
;PadLabelSend ReportSensor
	movf	REPORTSENSOR,W
	movwf	PADLABELSENSOR
	pagesel	PADLABELSEND
	call	PADLABELSEND
	pagesel	$
;Next
	movf	REPORTSENSOR,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop1
SysForLoopEnd1
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;Wait 1 s
	movlw	1
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;LedsOff
	pagesel	LEDSOFF
	call	LEDSOFF
	pagesel	$
;TouchStart
	call	TOUCHSTART
;For ReportSensor = 0 To TOUCH_SENSORS - 1
;Legacy method
	movlw	255
	movwf	REPORTSENSOR
SysForLoop2
	incf	REPORTSENSOR,F
;ReportLastState(ReportSensor) = 0
	movlw	low(REPORTLASTSTATE)
	addwf	REPORTSENSOR,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(REPORTLASTSTATE)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	clrf	INDF0
;Next
	movf	REPORTSENSOR,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop2
SysForLoopEnd2
;ReportScans = 0
	clrf	REPORTSCANS
;Do Forever
SysDoLoop_S1
;TouchService
	banksel	STATUS
	call	TOUCHSERVICE
;If TouchNewScan = 1 Then
	banksel	TOUCHNEWSCAN
	decf	TOUCHNEWSCAN,W
	btfss	STATUS, Z
	goto	ENDIF5
;TouchShowLeds
	banksel	STATUS
	call	TOUCHSHOWLEDS
;ReportScans++
	incf	REPORTSCANS,F
;ReportChanges
	call	REPORTCHANGES
;If ReportScans >= REPORT_SCANS Then
	movlw	25
	subwf	REPORTSCANS,W
	btfss	STATUS, C
	goto	ENDIF6
;ReportScans = 0
	clrf	REPORTSCANS
;ReportDeltas
	call	REPORTDELTAS
	pagesel	$
;End If
ENDIF6
;End If
ENDIF5
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;The pad labels on the 8-button sensor board, as character codes: sensor 0-7 = 8, 9, A, B, C, D, E, F
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Source: mTouchCVD_8Buttons.h (138)
CVDDRIVE
;The pin an output, driven to CVDDriveLevel (0 or 1)
;Dim CVDDriveInverse As Byte
;CVDDriveInverse = Not CVDDriveMask
	comf	CVDDRIVEMASK,W
	movwf	CVDDRIVEINVERSE
;If CVDDrivePort = 0 Then
	movf	CVDDRIVEPORT,F
	btfss	STATUS, Z
	goto	ELSE36_1
;If CVDDriveLevel = 0 Then
	movf	CVDDRIVELEVEL,F
	btfss	STATUS, Z
	goto	ELSE37_1
;LATA = LATA And CVDDriveInverse
	banksel	LATA
	movf	LATA,W
	banksel	CVDDRIVEINVERSE
	andwf	CVDDRIVEINVERSE,W
	banksel	LATA
	movwf	LATA
;Else
	goto	ENDIF37
ELSE37_1
;LATA = LATA Or CVDDriveMask
	banksel	LATA
	movf	LATA,W
	banksel	CVDDRIVEMASK
	iorwf	CVDDRIVEMASK,W
	banksel	LATA
	movwf	LATA
;End If
ENDIF37
;TRISA = TRISA And CVDDriveInverse
	banksel	TRISA
	movf	TRISA,W
	banksel	CVDDRIVEINVERSE
	andwf	CVDDRIVEINVERSE,W
	banksel	TRISA
	movwf	TRISA
;Else
	goto	ENDIF36
ELSE36_1
;If CVDDriveLevel = 0 Then
	movf	CVDDRIVELEVEL,F
	btfss	STATUS, Z
	goto	ELSE38_1
;LATE = LATE And CVDDriveInverse
	banksel	LATE
	movf	LATE,W
	banksel	CVDDRIVEINVERSE
	andwf	CVDDRIVEINVERSE,W
	banksel	LATE
	movwf	LATE
;Else
	goto	ENDIF38
ELSE38_1
;LATE = LATE Or CVDDriveMask
	banksel	LATE
	movf	LATE,W
	banksel	CVDDRIVEMASK
	iorwf	CVDDRIVEMASK,W
	banksel	LATE
	movwf	LATE
;End If
ENDIF38
;TRISE = TRISE And CVDDriveInverse
	banksel	TRISE
	movf	TRISE,W
	banksel	CVDDRIVEINVERSE
	andwf	CVDDRIVEINVERSE,W
	banksel	TRISE
	movwf	TRISE
;End If
ENDIF36
	banksel	STATUS
	return

;********************************************************************************

;Source: mTouchCVD_8Buttons.h (170)
FN_CVDREAD
;One differential reading of sensor CVDSensor: scan B - scan A + 1024 (a touch raises it), as the
;framework's result (B | 0x400) - A. Each scan: drive the reference and connect CHOLD to it (CHOLD charges),
;make the sensor an input and connect CHOLD to it (they share their charge), let it settle, convert. The two
;delays are the framework's CVD_CHOLD_CHARGE_DELAY and CVD_SETTLING_DELAY. The sensor is driven again only once
;the conversion is done (CHOLD is still connected for part of the first ADC clock)
;Dim CVDRef, CVDSensorMask, CVDSensorPort, CVDRefMask, CVDRefPort As Byte
;Dim CVDSensorChannel, CVDRefChannel As Byte
;Dim CVDPhaseA, CVDPhaseB As Word
;The reference: the sensor before (sensor 0 uses the last one)
;CVDRef = TOUCH_SENSORS - 1
	movlw	7
	movwf	CVDREF
;If CVDSensor > 0 Then CVDRef = CVDSensor - 1
	movf	CVDSENSOR,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF39
;If CVDSensor > 0 Then CVDRef = CVDSensor - 1
	decf	CVDSENSOR,W
	movwf	CVDREF
;If CVDSensor > 0 Then CVDRef = CVDSensor - 1
ENDIF39
;CVDPinLookup CVDSensor
	movf	CVDSENSOR,W
	movwf	CVDLOOKUPSENSOR
	pagesel	CVDPINLOOKUP
	call	CVDPINLOOKUP
	pagesel	$
;CVDSensorMask = CVDLookupMask
	movf	CVDLOOKUPMASK,W
	movwf	CVDSENSORMASK
;CVDSensorPort = CVDLookupPort
	movf	CVDLOOKUPPORT,W
	movwf	CVDSENSORPORT
;CVDPinLookup CVDRef
	movf	CVDREF,W
	movwf	CVDLOOKUPSENSOR
	pagesel	CVDPINLOOKUP
	call	CVDPINLOOKUP
	pagesel	$
;CVDRefMask = CVDLookupMask
	movf	CVDLOOKUPMASK,W
	movwf	CVDREFMASK
;CVDRefPort = CVDLookupPort
	movf	CVDLOOKUPPORT,W
	movwf	CVDREFPORT
;CVDSensorChannel = CVDSensor * 4 + 1
	movf	CVDSENSOR,W
	movwf	SysBYTETempA
	movlw	4
	movwf	SysBYTETempB
	pagesel	SYSMULTSUB
	call	SYSMULTSUB
	pagesel	$
	incf	SysBYTETempX,W
	movwf	CVDSENSORCHANNEL
;CVDRefChannel = CVDRef * 4 + 1
	movf	CVDREF,W
	movwf	SysBYTETempA
	movlw	4
	movwf	SysBYTETempB
	pagesel	SYSMULTSUB
	call	SYSMULTSUB
	pagesel	$
	incf	SysBYTETempX,W
	movwf	CVDREFCHANNEL
;IntOff
	bcf	SYSINTSTATESAVE0,0
	btfsc	INTCON,GIE
	bsf	SYSINTSTATESAVE0,0
	bcf	INTCON,GIE
;Scan A: CHOLD charged high through the reference; the sensor (low) shares with it
;CVDDrive CVDRefMask, CVDRefPort, 1
	movf	CVDREFMASK,W
	movwf	CVDDRIVEMASK
	movf	CVDREFPORT,W
	movwf	CVDDRIVEPORT
	movlw	1
	movwf	CVDDRIVELEVEL
	call	CVDDRIVE
;ADCON0 = CVDRefChannel
	movf	CVDREFCHANNEL,W
	banksel	ADCON0
	movwf	ADCON0
;Wait 1 us                           // CHOLD charges
	movlw	2
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	nop
;CVDFloat CVDSensorMask, CVDSensorPort
	banksel	CVDSENSORMASK
	movf	CVDSENSORMASK,W
	movwf	CVDFLOATMASK
	movf	CVDSENSORPORT,W
	movwf	CVDFLOATPORT
	pagesel	CVDFLOAT
	call	CVDFLOAT
	pagesel	$
;ADCON0 = CVDSensorChannel
	movf	CVDSENSORCHANNEL,W
	banksel	ADCON0
	movwf	ADCON0
;Wait 1 us                           // the shared charge settles
	movlw	2
	movwf	DELAYTEMP
DelayUS2
	decfsz	DELAYTEMP,F
	goto	DelayUS2
	nop
;Set ADCON0.GO = 1
	bsf	ADCON0,GO
;Wait While ADCON0.GO = 1
SysWaitLoop1
	btfsc	ADCON0,GO
	goto	SysWaitLoop1
;CVDDrive CVDSensorMask, CVDSensorPort, 1
	banksel	CVDSENSORMASK
	movf	CVDSENSORMASK,W
	movwf	CVDDRIVEMASK
	movf	CVDSENSORPORT,W
	movwf	CVDDRIVEPORT
	movlw	1
	movwf	CVDDRIVELEVEL
	call	CVDDRIVE
;CVDPhaseA = ADRESL
	banksel	ADRESL
	movf	ADRESL,W
	banksel	CVDPHASEA
	movwf	CVDPHASEA
	clrf	CVDPHASEA_H
;CVDPhaseA_H = ADRESH
	banksel	ADRESH
	movf	ADRESH,W
	banksel	CVDPHASEA_H
	movwf	CVDPHASEA_H
;Scan B: CHOLD discharged through the reference; the sensor (high) shares with it
;CVDDrive CVDRefMask, CVDRefPort, 0
	movf	CVDREFMASK,W
	movwf	CVDDRIVEMASK
	movf	CVDREFPORT,W
	movwf	CVDDRIVEPORT
	clrf	CVDDRIVELEVEL
	call	CVDDRIVE
;ADCON0 = CVDRefChannel
	movf	CVDREFCHANNEL,W
	banksel	ADCON0
	movwf	ADCON0
;Wait 1 us                           // CHOLD discharges
	movlw	2
	movwf	DELAYTEMP
DelayUS3
	decfsz	DELAYTEMP,F
	goto	DelayUS3
	nop
;CVDFloat CVDSensorMask, CVDSensorPort
	banksel	CVDSENSORMASK
	movf	CVDSENSORMASK,W
	movwf	CVDFLOATMASK
	movf	CVDSENSORPORT,W
	movwf	CVDFLOATPORT
	pagesel	CVDFLOAT
	call	CVDFLOAT
	pagesel	$
;ADCON0 = CVDSensorChannel
	movf	CVDSENSORCHANNEL,W
	banksel	ADCON0
	movwf	ADCON0
;Wait 1 us                           // the shared charge settles
	movlw	2
	movwf	DELAYTEMP
DelayUS4
	decfsz	DELAYTEMP,F
	goto	DelayUS4
	nop
;Set ADCON0.GO = 1
	bsf	ADCON0,GO
;Wait While ADCON0.GO = 1
SysWaitLoop2
	btfsc	ADCON0,GO
	goto	SysWaitLoop2
;CVDDrive CVDSensorMask, CVDSensorPort, 0
	banksel	CVDSENSORMASK
	movf	CVDSENSORMASK,W
	movwf	CVDDRIVEMASK
	movf	CVDSENSORPORT,W
	movwf	CVDDRIVEPORT
	clrf	CVDDRIVELEVEL
	call	CVDDRIVE
;CVDPhaseB = ADRESL
	banksel	ADRESL
	movf	ADRESL,W
	banksel	CVDPHASEB
	movwf	CVDPHASEB
	clrf	CVDPHASEB_H
;CVDPhaseB_H = ADRESH
	banksel	ADRESH
	movf	ADRESH,W
	banksel	CVDPHASEB_H
	movwf	CVDPHASEB_H
;IntOn
	btfss	SYSINTSTATESAVE0,0
	bcf	INTCON,GIE
	btfsc	SYSINTSTATESAVE0,0
	bsf	INTCON,GIE
;CVDRead = CVDPhaseB - CVDPhaseA + 1024
	movf	CVDPHASEA,W
	subwf	CVDPHASEB,W
	movwf	SysTemp1
	movf	CVDPHASEA_H,W
	subwfb	CVDPHASEB_H,W
	movwf	SysTemp1_H
	movlw	0
	addwf	SysTemp1,W
	movwf	CVDREAD
	movlw	4
	addwfc	SysTemp1_H,W
	movwf	CVDREAD_H
	return

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (3402)
HSERPRINT381
;PrintLen = PrintData(0)
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	goto	ENDIF51
;Write Data
;for SysPrintTemp = 1 to PrintLen
;Legacy method
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd10
SysForLoop10
	incf	SYSPRINTTEMP,F
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SERDATA
	pagesel	HSERSEND369
	call	HSERSEND369
	pagesel	$
;next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop10
SysForLoopEnd10
;End If
ENDIF51
;CR
;All Usarts
;--------------------------
;Specific USARTs
;------------------
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (3476)
HSERPRINT383
;OutValueTemp = 0
	clrf	OUTVALUETEMP
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W
	btfss	STATUS, C
	goto	ENDIF54
;OutValueTemp = SerPrintVal / 100
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	100
	movwf	SysBYTETempB
	pagesel	SYSDIVSUB
	call	SYSDIVSUB
	pagesel	$
	movf	SysBYTETempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	pagesel	HSERSEND369
	call	HSERSEND369
	pagesel	$
;End If
ENDIF54
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movf	OUTVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	iorwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF55
;OutValueTemp = SerPrintVal / 10
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	pagesel	SYSDIVSUB
	call	SYSDIVSUB
	pagesel	$
	movf	SysBYTETempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	pagesel	HSERSEND369
	call	HSERSEND369
	pagesel	$
;End If
ENDIF55
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W
	movwf	SERDATA
	pagesel	HSERSEND369
	goto	HSERSEND369
;CR

;********************************************************************************

;Overloaded signature: WORD:byte:, Source: usart.h (3505)
HSERPRINT384
;Dim SysCalcTempX As Word
;OutValueTemp = 0
	clrf	OUTVALUETEMP
;If SerPrintVal >= 10000 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF56
;OutValueTemp = SerPrintVal / 10000 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	pagesel	HSERSEND369
	call	HSERSEND369
	pagesel	$
;Goto HSerPrintWord1000
	goto	HSERPRINTWORD1000
;End If
ENDIF56
;If SerPrintVal >= 1000 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF57
HSERPRINTWORD1000
;OutValueTemp = SerPrintVal / 1000 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport  )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	pagesel	HSERSEND369
	call	HSERSEND369
	pagesel	$
;Goto HSerPrintWord100
	goto	HSERPRINTWORD100
;End If
ENDIF57
;If SerPrintVal >= 100 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF58
HSERPRINTWORD100
;OutValueTemp = SerPrintVal / 100 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	pagesel	HSERSEND369
	call	HSERSEND369
	pagesel	$
;Goto HSerPrintWord10
	goto	HSERPRINTWORD10
;End If
ENDIF58
;If SerPrintVal >= 10 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF59
HSERPRINTWORD10
;OutValueTemp = SerPrintVal / 10 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	pagesel	HSERSEND369
	call	HSERSEND369
	pagesel	$
;End If
ENDIF59
;OutValueTemp = SerPrintVal
	movf	SERPRINTVAL,W
	movwf	OUTVALUETEMP
;HSerSend(OutValueTemp + 48 ,comport  )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	pagesel	HSERSEND369
	goto	HSERSEND369
;CR

;********************************************************************************

;Source: system.h (211)
INITSYS
;Handle chips with only 2 IRCF bits (IRCF1, IRCF0) like 16F720/721 and its LF siblings
;16F72x has 500kHz INTOSC with 32x PLL option and postscaler (÷1,2,4,8)
;ChipSubFamily 15001 (16F152xx) has OSCCON with NOSC/NDIV bits but no IRCF bits,
;so it must be handled outside the IRCF based type 103 section
;Type 103: Chips without SPLLEN, IRCF3, but must have at least IRCF2 (exclude 2-bit IRCF chips)
;OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;equates to OSCCON = OSCCON AND b'10000111' & OSCCON = OSCCON OR b'11110000'
;= 32Mhz
;Set IRCF3 On
	banksel	OSCCON
	bsf	OSCCON,IRCF3
;Set IRCF2 On
	bsf	OSCCON,IRCF2
;Set IRCF1 On
	bsf	OSCCON,IRCF1
;Set IRCF0 Off
	bcf	OSCCON,IRCF0
;Set SPLLEN On
	bsf	OSCCON,SPLLEN
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON1,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELD = 0
	clrf	ANSELD
;ANSELE = 0
	clrf	ANSELE
;Set comparator register bits for many MCUs with register CM2CON0
;C2ON = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
;C1ON = 0
	bcf	CM1CON0,C1ON
;Turn off all ports
;PORTA = 0
	banksel	PORTA
	clrf	PORTA
;PORTB = 0
	clrf	PORTB
;PORTC = 0
	clrf	PORTC
;PORTD = 0
	clrf	PORTD
;PORTE = 0
	clrf	PORTE
;ClearRAM
;Macro Source: system.h (1838)
;No code. User has not included <clearram.h>
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:, Source: timer.h (1622)
INITTIMER0223
;Dim TMR0_TMP as Byte
;Some PICS (18F+) Use T0CON for timer0 Control
;ALL OTHER PICS USE OPTION_REG for timer0 control
;Sub modified to set all TMR Control bits at once
;* TMRPres, TMRSource & TMRPost now shared *
;if TMRPRes > 7 then TMRPRes = 0 'failsafe
	movf	TMRPRES,W
	sublw	7
	btfss	STATUS, C
;if TMRPRes > 7 then TMRPRes = 0 'failsafe
	clrf	TMRPRES
;if TMRPRes > 7 then TMRPRes = 0 'failsafe
;If Timer0 is 16-bit capable
;Re-Use TMRPres as T0CON Temp_register
;Keep T0CON 7:6 and write bits 2:0 from TMRPres
;Bits 5,4 & 3 will be cleared!
;TMRPres = (OPTION_REG AND 192) OR TMRPres
	movlw	192
	banksel	OPTION_REG
	andwf	OPTION_REG,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	iorwf	TMRPRES,F
;IF TMRSource = EXT then
	movlw	2
	subwf	TMRSOURCE,W
	btfss	STATUS, Z
	goto	ELSE63_1
;Set TMRPres.5 ON   'EXT
	bsf	TMRPRES,5
;ELSE
	goto	ENDIF63
ELSE63_1
;Set TMRPres.5 OFF  'OSC
	bcf	TMRPRES,5
;END IF
ENDIF63
;Now Write the OPTION_REG
;OPTION_REG = TMRPres
	movf	TMRPRES,W
	banksel	OPTION_REG
	movwf	OPTION_REG
;Added For baseline Chips with write only option_reg
;If Timer0 is 16-bit capable
	banksel	STATUS
	return

;********************************************************************************

;Source: usart.h (1284)
INITUSART
;PIC USART 1 Init
;Set baud rate for chips with BRG16 bit
;SPBRGH = SPBRGH_TEMP
	banksel	SPBRGH
	clrf	SPBRGH
;SPBRGL = SPBRGL_TEMP
	movlw	68
	movwf	SPBRGL
;SPBRG = SPBRGL_TEMP
	movlw	68
	movwf	SPBRG
;BRG16 = BRG16_TEMP
	bsf	BAUDCON,BRG16
;BRGH = BRGH_TEMP
	bsf	TXSTA,BRGH
;SYNC=0
	bcf	TXSTA,SYNC
;TXEN=1
	bsf	TXSTA,TXEN
;SPEN=1
	bsf	RCSTA,SPEN
;CREN=1
	bsf	RCSTA,CREN
;CREN=1
	bsf	RCSTA,CREN
	banksel	STATUS
	return

;********************************************************************************

;Source: millis.h (297)
INIT_MSCTR_INT
;Add the handler for the interrupt
;On Interrupt Timer0Overflow Call MsCtr_Int_Hdlr
	bsf	INTCON,TMR0IE
;MsCtr_ = 0
	clrf	MSCTR_
	clrf	MSCTR__H
	clrf	MSCTR__U
	clrf	MSCTR__E
;Millis = 0
	pagesel	FN_MILLIS
	call	FN_MILLIS
	pagesel	$
;8bit / 16bit No Postscaler
;InitTimer0 Osc, PS0_32
	movlw	1
	movwf	TMRSOURCE
	movlw	4
	movwf	TMRPRES
	call	INITTIMER0223
;Call_SetTimer_Millis_macro
;SetTimer_Millis SCRIPT_TMR0INITVAL  + MILLIS_TIMER_VALUE_ADJUST   ' Reset Inital Counter value
;Macro Source: millis.h (576)
;Handle chips withOUT TMR0H
;TMR0 = TMRValueMillis
	movlw	6
	movwf	TMR0
;Call_StartTimer_Millis_macro
;StartTimer_Millis
;Macro Source: millis.h (616)
	return

;********************************************************************************

;Source: GCBASIC_mTouch_Framework_CVD_8Buttons_Serial_16F1937.gcb (186)
REPORTCHANGES
;A line for each button pressed or released since the last scan
;Dim ChangeSensor, ChangeState As Byte
;For ChangeSensor = 0 To TOUCH_SENSORS - 1
;Legacy method
	movlw	255
	movwf	CHANGESENSOR
SysForLoop3
	incf	CHANGESENSOR,F
;ChangeState = TouchState(ChangeSensor)
	movlw	low(TOUCHSTATE)
	addwf	CHANGESENSOR,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(TOUCHSTATE)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	CHANGESTATE
;If ChangeState <> ReportLastState(ChangeSensor) Then
	movlw	low(REPORTLASTSTATE)
	addwf	CHANGESENSOR,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(REPORTLASTSTATE)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	INDF0,W
	subwf	CHANGESTATE,W
	btfsc	STATUS, Z
	goto	ENDIF16
;If ChangeState = 2 Then
	movlw	2
	subwf	CHANGESTATE,W
	btfss	STATUS, Z
	goto	ENDIF18
;HSerPrint "Pad "
	movlw	low StringTable8
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT381
;PadLabelSend ChangeSensor
	movf	CHANGESENSOR,W
	movwf	PADLABELSENSOR
	pagesel	PADLABELSEND
	call	PADLABELSEND
	pagesel	$
;HSerPrint " pressed"
	movlw	low StringTable9
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable9) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT381
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;End If
ENDIF18
;If ChangeState = 1 Then
	decf	CHANGESTATE,W
	btfss	STATUS, Z
	goto	ENDIF19
;If ReportLastState(ChangeSensor) = 2 Then
	movlw	low(REPORTLASTSTATE)
	addwf	CHANGESENSOR,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(REPORTLASTSTATE)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	2
	subwf	INDF0,W
	btfss	STATUS, Z
	goto	ENDIF20
;HSerPrint "Pad "
	movlw	low StringTable8
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT381
;PadLabelSend ChangeSensor
	movf	CHANGESENSOR,W
	movwf	PADLABELSENSOR
	pagesel	PADLABELSEND
	call	PADLABELSEND
	pagesel	$
;HSerPrint " released"
	movlw	low StringTable10
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable10) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT381
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;End If
ENDIF20
;End If
ENDIF19
;ReportLastState(ChangeSensor) = ChangeState
	movlw	low(REPORTLASTSTATE)
	addwf	CHANGESENSOR,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(REPORTLASTSTATE)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	CHANGESTATE,W
	movwf	INDF0
;End If
ENDIF16
;Next
	movf	CHANGESENSOR,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop3
SysForLoopEnd3
	return

;********************************************************************************

;Source: GCBASIC_mTouch_Framework_CVD_8Buttons_Serial_16F1937.gcb (211)
REPORTDELTAS
;Each button's delta above its baseline, right-aligned in 4 characters, then its state: L learning,
;. released, P pressed
;Dim DeltaSensor As Byte
;Dim DeltaValue As Word
;HSerPrint "d    "
	movlw	low StringTable11
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable11) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT381
;For DeltaSensor = 0 To TOUCH_SENSORS - 1
;Legacy method
	movlw	255
	movwf	DELTASENSOR
SysForLoop4
	incf	DELTASENSOR,F
;DeltaValue = TouchDeltas(DeltaSensor)
	bcf	STATUS,C
	rlf	DELTASENSOR,W
	movwf	SysTemp1
	movlw	low(TOUCHDELTAS)
	addwf	SysTemp1,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(TOUCHDELTAS)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	DELTAVALUE
	movf	SysArrayTemp1_H,W
	movwf	DELTAVALUE_H
;HSerSend 32
	movlw	32
	movwf	SERDATA
	pagesel	HSERSEND368
	call	HSERSEND368
	pagesel	$
;If DeltaValue < 1000 Then HSerSend 32
	movf	DELTAVALUE,W
	movwf	SysWORDTempA
	movf	DELTAVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF22
;If DeltaValue < 1000 Then HSerSend 32
	movlw	32
	movwf	SERDATA
	pagesel	HSERSEND368
	call	HSERSEND368
	pagesel	$
;If DeltaValue < 1000 Then HSerSend 32
ENDIF22
;If DeltaValue < 100 Then HSerSend 32
	movf	DELTAVALUE,W
	movwf	SysWORDTempA
	movf	DELTAVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF23
;If DeltaValue < 100 Then HSerSend 32
	movlw	32
	movwf	SERDATA
	pagesel	HSERSEND368
	call	HSERSEND368
	pagesel	$
;If DeltaValue < 100 Then HSerSend 32
ENDIF23
;If DeltaValue < 10 Then HSerSend 32
	movf	DELTAVALUE,W
	movwf	SysWORDTempA
	movf	DELTAVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF24
;If DeltaValue < 10 Then HSerSend 32
	movlw	32
	movwf	SERDATA
	pagesel	HSERSEND368
	call	HSERSEND368
	pagesel	$
;If DeltaValue < 10 Then HSerSend 32
ENDIF24
;HSerPrint DeltaValue
	movf	DELTAVALUE,W
	movwf	SERPRINTVAL
	movf	DELTAVALUE_H,W
	movwf	SERPRINTVAL_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT384
	pagesel	$
;Next
	movf	DELTASENSOR,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop4
SysForLoopEnd4
;HSerSend 32
	movlw	32
	movwf	SERDATA
	pagesel	HSERSEND368
	call	HSERSEND368
	pagesel	$
;HSerSend 32
	movlw	32
	movwf	SERDATA
	pagesel	HSERSEND368
	call	HSERSEND368
	pagesel	$
;For DeltaSensor = 0 To TOUCH_SENSORS - 1
;Legacy method
	movlw	255
	movwf	DELTASENSOR
SysForLoop5
	incf	DELTASENSOR,F
;Select Case TouchState(DeltaSensor)
	movlw	low(TOUCHSTATE)
	addwf	DELTASENSOR,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(TOUCHSTATE)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
;Case 0
SysSelect1Case1
	movf	INDF0,F
	btfss	STATUS, Z
	goto	SysSelect1Case2
;HSerSend 76             // L
	movlw	76
	movwf	SERDATA
	pagesel	HSERSEND368
	call	HSERSEND368
	pagesel	$
;Case 2
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	INDF0,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;HSerSend 80             // P
	movlw	80
	movwf	SERDATA
	pagesel	HSERSEND368
	call	HSERSEND368
	pagesel	$
;Case Else
	goto	SysSelectEnd1
SysSelect1Case3
;HSerSend 46             // .
	movlw	46
	movwf	SERDATA
	pagesel	HSERSEND368
	call	HSERSEND368
	pagesel	$
;End Select
SysSelectEnd1
;Next
	movf	DELTASENSOR,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop5
SysForLoopEnd5
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	goto	HSERPRINTCRLF

;********************************************************************************

;Source: system.h (3592)
SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movf	SYSWORDTEMPA,W
	movwf	SYSDIVMULTA
	movf	SYSWORDTEMPA_H,W
	movwf	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movf	SYSWORDTEMPB,W
	movwf	SYSDIVMULTB
	movf	SYSWORDTEMPB_H,W
	movwf	SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX
	clrf	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempA
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSCOMPEQUAL16
	call	SYSCOMPEQUAL16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF49
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF49
;Main calc routine
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP
SYSDIV16START
;set C off
	bcf	STATUS,C
;Rotate SysDivMultA Left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	rlf	SYSDIVMULTX,F
	rlf	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W
	subwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	subwfb	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF50
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF50
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv16Start
	goto	SYSDIV16START
;SysWordTempA = SysDivMultA
	movf	SYSDIVMULTA,W
	movwf	SYSWORDTEMPA
	movf	SYSDIVMULTA_H,W
	movwf	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
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

StringTable4
	retlw	28
	retlw	109	;m
	retlw	84	;T
	retlw	111	;o
	retlw	117	;u
	retlw	99	;c
	retlw	104	;h
	retlw	32	; 
	retlw	67	;C
	retlw	86	;V
	retlw	68	;D
	retlw	32	; 
	retlw	56	;8
	retlw	32	; 
	retlw	98	;b
	retlw	117	;u
	retlw	116	;t
	retlw	116	;t
	retlw	111	;o
	retlw	110	;n
	retlw	115	;s
	retlw	44	;,
	retlw	32	; 
	retlw	112	;p
	retlw	114	;r
	retlw	101	;e
	retlw	115	;s
	retlw	115	;s
	retlw	32	; 


StringTable5
	retlw	10
	retlw	44	;,
	retlw	32	; 
	retlw	114	;r
	retlw	101	;e
	retlw	108	;l
	retlw	101	;e
	retlw	97	;a
	retlw	115	;s
	retlw	101	;e
	retlw	32	; 


StringTable6
	retlw	5
	retlw	112	;p
	retlw	97	;a
	retlw	100	;d
	retlw	32	; 
	retlw	32	; 


StringTable7
	retlw	4
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable8
	retlw	4
	retlw	80	;P
	retlw	97	;a
	retlw	100	;d
	retlw	32	; 


StringTable9
	retlw	8
	retlw	32	; 
	retlw	112	;p
	retlw	114	;r
	retlw	101	;e
	retlw	115	;s
	retlw	115	;s
	retlw	101	;e
	retlw	100	;d


StringTable10
	retlw	9
	retlw	32	; 
	retlw	114	;r
	retlw	101	;e
	retlw	108	;l
	retlw	101	;e
	retlw	97	;a
	retlw	115	;s
	retlw	101	;e
	retlw	100	;d


StringTable11
	retlw	5
	retlw	100	;d
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


;********************************************************************************

;Source: mTouchCVD_8Buttons.h (71)
TOUCHINIT
;The ADC, and every sensor pin an output driven low between measurements
;Dim TouchInitSensor As Byte
;ADCON1 = CVD_ADCON1
	movlw	160
	banksel	ADCON1
	movwf	ADCON1
;For TouchInitSensor = 0 To TOUCH_SENSORS - 1
;Legacy method
	movlw	255
	banksel	TOUCHINITSENSOR
	movwf	TOUCHINITSENSOR
SysForLoop6
	incf	TOUCHINITSENSOR,F
;CVDPinLookup TouchInitSensor
	movf	TOUCHINITSENSOR,W
	movwf	CVDLOOKUPSENSOR
	pagesel	CVDPINLOOKUP
	call	CVDPINLOOKUP
	pagesel	$
;CVDDrive CVDLookupMask, CVDLookupPort, 0
	movf	CVDLOOKUPMASK,W
	movwf	CVDDRIVEMASK
	movf	CVDLOOKUPPORT,W
	movwf	CVDDRIVEPORT
	clrf	CVDDRIVELEVEL
	call	CVDDRIVE
;Next
	movf	TOUCHINITSENSOR,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop6
SysForLoopEnd6
;TouchNewScan = 0
	banksel	TOUCHNEWSCAN
	clrf	TOUCHNEWSCAN
	banksel	STATUS
	return

;********************************************************************************

;Source: mTouchCVD_8Buttons.h (242)
TOUCHSCANSENSOR
;One scan of one sensor: eight readings, each after a random delay and each moving the slew-limited value by
;at most TOUCH_MAX_STEP, summed; then the power-up / released / pressed decision and, while released, the slow
;baseline
;Dim TouchCount, TouchNowState As Byte
;Dim TouchRaw, TouchValue, TouchUp, TouchDown, TouchSum, TouchBase, TouchDelta, TouchCounted As Word
;TouchValue = TouchFiltered(TouchScanIndex)
	bcf	STATUS,C
	banksel	TOUCHSCANINDEX
	rlf	TOUCHSCANINDEX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	low(TOUCHFILTERED)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(TOUCHFILTERED)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	banksel	TOUCHVALUE
	movwf	TOUCHVALUE
	banksel	SYSARRAYTEMP1_H
	movf	SysArrayTemp1_H,W
	banksel	TOUCHVALUE_H
	movwf	TOUCHVALUE_H
;TouchSum = 0
	clrf	TOUCHSUM
	clrf	TOUCHSUM_H
;For TouchCount = 1 To 8
;Legacy method
	banksel	TOUCHCOUNT
	clrf	TOUCHCOUNT
SysForLoop9
	incf	TOUCHCOUNT,F
;TouchJitter
	pagesel	TOUCHJITTER
	call	TOUCHJITTER
	pagesel	$
;TouchRaw = CVDRead(TouchScanIndex)
	banksel	TOUCHSCANINDEX
	movf	TOUCHSCANINDEX,W
	banksel	CVDSENSOR
	movwf	CVDSENSOR
	call	FN_CVDREAD
	movf	CVDREAD,W
	banksel	TOUCHRAW
	movwf	TOUCHRAW
	banksel	CVDREAD_H
	movf	CVDREAD_H,W
	banksel	TOUCHRAW_H
	movwf	TOUCHRAW_H
;TouchUp = TouchValue + TOUCH_MAX_STEP
	movlw	10
	addwf	TOUCHVALUE,W
	movwf	TOUCHUP
	movlw	0
	addwfc	TOUCHVALUE_H,W
	movwf	TOUCHUP_H
;TouchDown = 0
	banksel	TOUCHDOWN
	clrf	TOUCHDOWN
	clrf	TOUCHDOWN_H
;If TouchValue > TOUCH_MAX_STEP Then TouchDown = TouchValue - TOUCH_MAX_STEP
	banksel	TOUCHVALUE
	movf	TOUCHVALUE,W
	movwf	SysWORDTempB
	movf	TOUCHVALUE_H,W
	movwf	SysWORDTempB_H
	movlw	10
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF40
;If TouchValue > TOUCH_MAX_STEP Then TouchDown = TouchValue - TOUCH_MAX_STEP
	movlw	10
	banksel	TOUCHVALUE
	subwf	TOUCHVALUE,W
	banksel	TOUCHDOWN
	movwf	TOUCHDOWN
	movlw	0
	banksel	TOUCHVALUE_H
	subwfb	TOUCHVALUE_H,W
	banksel	TOUCHDOWN_H
	movwf	TOUCHDOWN_H
;If TouchValue > TOUCH_MAX_STEP Then TouchDown = TouchValue - TOUCH_MAX_STEP
ENDIF40
;If TouchRaw > TouchUp Then
	banksel	TOUCHRAW
	movf	TOUCHRAW,W
	movwf	SysWORDTempB
	movf	TOUCHRAW_H,W
	movwf	SysWORDTempB_H
	movf	TOUCHUP,W
	movwf	SysWORDTempA
	movf	TOUCHUP_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE41_1
;TouchValue = TouchUp
	banksel	TOUCHUP
	movf	TOUCHUP,W
	movwf	TOUCHVALUE
	movf	TOUCHUP_H,W
	movwf	TOUCHVALUE_H
;Else If TouchRaw < TouchDown Then
	goto	ENDIF41
ELSE41_1
	banksel	TOUCHRAW
	movf	TOUCHRAW,W
	movwf	SysWORDTempA
	movf	TOUCHRAW_H,W
	movwf	SysWORDTempA_H
	banksel	TOUCHDOWN
	movf	TOUCHDOWN,W
	movwf	SysWORDTempB
	movf	TOUCHDOWN_H,W
	movwf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE41_2
;TouchValue = TouchDown
	movf	TOUCHDOWN,W
	banksel	TOUCHVALUE
	movwf	TOUCHVALUE
	banksel	TOUCHDOWN_H
	movf	TOUCHDOWN_H,W
	banksel	TOUCHVALUE_H
	movwf	TOUCHVALUE_H
;Else
	goto	ENDIF41
ELSE41_2
;TouchValue = TouchRaw
	banksel	TOUCHRAW
	movf	TOUCHRAW,W
	movwf	TOUCHVALUE
	movf	TOUCHRAW_H,W
	movwf	TOUCHVALUE_H
;End If
ENDIF41
;TouchSum = TouchSum + TouchValue
	movf	TOUCHVALUE,W
	addwf	TOUCHSUM,F
	movf	TOUCHVALUE_H,W
	addwfc	TOUCHSUM_H,F
;Next
	movlw	8
	banksel	TOUCHCOUNT
	subwf	TOUCHCOUNT,W
	btfss	STATUS, C
	goto	SysForLoop9
SysForLoopEnd9
;TouchFiltered(TouchScanIndex) = TouchValue
	banksel	TOUCHVALUE
	movf	TOUCHVALUE,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	TOUCHVALUE_H
	movf	TOUCHVALUE_H,W
	banksel	SYSARRAYTEMP1_H
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TOUCHSCANINDEX
	rlf	TOUCHSCANINDEX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	low(TOUCHFILTERED)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(TOUCHFILTERED)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;How far above the baseline (0 when below)
;TouchBase = TouchBaseline(TouchScanIndex)
	bcf	STATUS,C
	banksel	TOUCHSCANINDEX
	rlf	TOUCHSCANINDEX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	low(TOUCHBASELINE)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(TOUCHBASELINE)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	TOUCHBASE
	movf	SysArrayTemp1_H,W
	movwf	TOUCHBASE_H
;TouchDelta = 0
	clrf	TOUCHDELTA
	clrf	TOUCHDELTA_H
;If TouchSum > TouchBase Then TouchDelta = TouchSum - TouchBase
	banksel	TOUCHSUM
	movf	TOUCHSUM,W
	movwf	SysWORDTempB
	movf	TOUCHSUM_H,W
	movwf	SysWORDTempB_H
	banksel	TOUCHBASE
	movf	TOUCHBASE,W
	movwf	SysWORDTempA
	movf	TOUCHBASE_H,W
	movwf	SysWORDTempA_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF43
;If TouchSum > TouchBase Then TouchDelta = TouchSum - TouchBase
	movf	TOUCHBASE,W
	banksel	TOUCHSUM
	subwf	TOUCHSUM,W
	banksel	TOUCHDELTA
	movwf	TOUCHDELTA
	movf	TOUCHBASE_H,W
	banksel	TOUCHSUM_H
	subwfb	TOUCHSUM_H,W
	banksel	TOUCHDELTA_H
	movwf	TOUCHDELTA_H
;If TouchSum > TouchBase Then TouchDelta = TouchSum - TouchBase
ENDIF43
;TouchNowState = TouchState(TouchScanIndex)
	movlw	low(TOUCHSTATE)
	banksel	TOUCHSCANINDEX
	addwf	TOUCHSCANINDEX,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(TOUCHSTATE)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	TOUCHNOWSTATE
	movwf	TOUCHNOWSTATE
;TouchCounted = TouchScans(TouchScanIndex)
	bcf	STATUS,C
	rlf	TOUCHSCANINDEX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	low(TOUCHSCANS)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(TOUCHSCANS)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	addfsr	0,1
	movf	INDF0,W
	movwf	SysArrayTemp1_H
	movf	SysArrayTemp1,W
	movwf	TOUCHCOUNTED
	movf	SysArrayTemp1_H,W
	movwf	TOUCHCOUNTED_H
;Select Case TouchNowState
;Case 0
SysSelect2Case1
	banksel	TOUCHNOWSTATE
	movf	TOUCHNOWSTATE,F
	btfss	STATUS, Z
	goto	SysSelect2Case2
;Power-up (and after a time-out): the baseline follows the sum for TOUCH_POWERUP scans
;TouchBase = TouchSum
	movf	TOUCHSUM,W
	banksel	TOUCHBASE
	movwf	TOUCHBASE
	banksel	TOUCHSUM_H
	movf	TOUCHSUM_H,W
	banksel	TOUCHBASE_H
	movwf	TOUCHBASE_H
;TouchCounted++
	incf	TOUCHCOUNTED,F
	btfsc	STATUS,Z
	incf	TOUCHCOUNTED_H,F
;If TouchCounted >= TOUCH_POWERUP Then
	movf	TOUCHCOUNTED,W
	movwf	SysWORDTempA
	movf	TOUCHCOUNTED_H,W
	movwf	SysWORDTempA_H
	movlw	30
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF44
;TouchCounted = 0
	clrf	TOUCHCOUNTED
	clrf	TOUCHCOUNTED_H
;TouchBaselineScans(TouchScanIndex) = 0
	movlw	low(TOUCHBASELINESCANS)
	banksel	TOUCHSCANINDEX
	addwf	TOUCHSCANINDEX,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(TOUCHBASELINESCANS)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	clrf	INDF0
;TouchNowState = 1
	movlw	1
	banksel	TOUCHNOWSTATE
	movwf	TOUCHNOWSTATE
;End If
ENDIF44
;Case 1
	goto	SysSelectEnd2
SysSelect2Case2
	decf	TOUCHNOWSTATE,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
;Released: press above TOUCH_PRESS, else the baseline follows slowly (1/16 every TOUCH_BASELINE_RATE
;scans)
;If TouchDelta >= TOUCH_PRESS Then
	banksel	TOUCHDELTA
	movf	TOUCHDELTA,W
	movwf	SysWORDTempA
	movf	TOUCHDELTA_H,W
	movwf	SysWORDTempA_H
	movlw	250
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ELSE45_1
;TouchCounted = 0
	clrf	TOUCHCOUNTED
	clrf	TOUCHCOUNTED_H
;TouchNowState = 2
	movlw	2
	banksel	TOUCHNOWSTATE
	movwf	TOUCHNOWSTATE
;Else
	goto	ENDIF45
ELSE45_1
;TouchBaselineScans(TouchScanIndex) = TouchBaselineScans(TouchScanIndex) + 1
	movlw	low(TOUCHBASELINESCANS)
	banksel	TOUCHSCANINDEX
	addwf	TOUCHSCANINDEX,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(TOUCHBASELINESCANS)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp2
	movlw	1
	addwf	SysArrayTemp2,W
	movwf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	btfsc	STATUS,C
	incf	SysArrayTemp1_H,F
	movlw	low(TOUCHBASELINESCANS)
	banksel	TOUCHSCANINDEX
	addwf	TOUCHSCANINDEX,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(TOUCHBASELINESCANS)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
;If TouchBaselineScans(TouchScanIndex) >= TOUCH_BASELINE_RATE Then
	movlw	low(TOUCHBASELINESCANS)
	banksel	TOUCHSCANINDEX
	addwf	TOUCHSCANINDEX,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(TOUCHBASELINESCANS)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	10
	subwf	INDF0,W
	btfss	STATUS, C
	goto	ENDIF47
;TouchBaselineScans(TouchScanIndex) = 0
	movlw	low(TOUCHBASELINESCANS)
	banksel	TOUCHSCANINDEX
	addwf	TOUCHSCANINDEX,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(TOUCHBASELINESCANS)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	clrf	INDF0
;TouchBase = TouchBase - TouchBase / 16 + TouchSum / 16
	movf	TOUCHBASE,W
	movwf	SysWORDTempA
	movf	TOUCHBASE_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	SysTemp1
	movf	SysWORDTempA_H,W
	movwf	SysTemp1_H
	banksel	TOUCHSUM
	movf	TOUCHSUM,W
	movwf	SysWORDTempA
	movf	TOUCHSUM_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SYSDIVSUB16
	movf	SysTemp1,W
	subwf	TOUCHBASE,W
	movwf	SysTemp2
	movf	SysTemp1_H,W
	subwfb	TOUCHBASE_H,W
	movwf	SysTemp2_H
	movf	SysWORDTempA,W
	addwf	SysTemp2,W
	movwf	TOUCHBASE
	movf	SysWORDTempA_H,W
	addwfc	SysTemp2_H,W
	movwf	TOUCHBASE_H
;End If
ENDIF47
;End If
ENDIF45
;Case 2
	goto	SysSelectEnd2
SysSelect2Case3
	movlw	2
	subwf	TOUCHNOWSTATE,W
	btfss	STATUS, Z
	goto	SysSelectEnd2
;Pressed: release below TOUCH_RELEASE; held for TOUCH_TIMEOUT scans means something is left on the
;pad, so learn the baseline again
;If TouchDelta < TOUCH_RELEASE Then
	banksel	TOUCHDELTA
	movf	TOUCHDELTA,W
	movwf	SysWORDTempA
	movf	TOUCHDELTA_H,W
	movwf	SysWORDTempA_H
	movlw	125
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE46_1
;TouchNowState = 1
	movlw	1
	banksel	TOUCHNOWSTATE
	movwf	TOUCHNOWSTATE
;Else
	goto	ENDIF46
ELSE46_1
;TouchCounted++
	incf	TOUCHCOUNTED,F
	btfsc	STATUS,Z
	incf	TOUCHCOUNTED_H,F
;If TouchCounted >= TOUCH_TIMEOUT Then
	movf	TOUCHCOUNTED,W
	movwf	SysWORDTempA
	movf	TOUCHCOUNTED_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF48
;TouchCounted = 0
	clrf	TOUCHCOUNTED
	clrf	TOUCHCOUNTED_H
;TouchNowState = 0
	banksel	TOUCHNOWSTATE
	clrf	TOUCHNOWSTATE
;End If
ENDIF48
;End If
ENDIF46
;End Select
SysSelectEnd2
;TouchBaseline(TouchScanIndex) = TouchBase
	banksel	TOUCHBASE
	movf	TOUCHBASE,W
	movwf	SysArrayTemp1
	movf	TOUCHBASE_H,W
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TOUCHSCANINDEX
	rlf	TOUCHSCANINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	low(TOUCHBASELINE)
	addwf	SysTemp1,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(TOUCHBASELINE)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;TouchState(TouchScanIndex) = TouchNowState
	movlw	low(TOUCHSTATE)
	banksel	TOUCHSCANINDEX
	addwf	TOUCHSCANINDEX,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(TOUCHSTATE)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	banksel	TOUCHNOWSTATE
	movf	TOUCHNOWSTATE,W
	movwf	INDF0
;TouchScans(TouchScanIndex) = TouchCounted
	banksel	TOUCHCOUNTED
	movf	TOUCHCOUNTED,W
	movwf	SysArrayTemp1
	movf	TOUCHCOUNTED_H,W
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TOUCHSCANINDEX
	rlf	TOUCHSCANINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	low(TOUCHSCANS)
	addwf	SysTemp1,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(TOUCHSCANS)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;TouchSums(TouchScanIndex) = TouchSum
	banksel	TOUCHSUM
	movf	TOUCHSUM,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	TOUCHSUM_H
	movf	TOUCHSUM_H,W
	banksel	SYSARRAYTEMP1_H
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TOUCHSCANINDEX
	rlf	TOUCHSCANINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	low(TOUCHSUMS)
	addwf	SysTemp1,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(TOUCHSUMS)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;TouchDeltas(TouchScanIndex) = TouchDelta
	movf	TOUCHDELTA,W
	movwf	SysArrayTemp1
	movf	TOUCHDELTA_H,W
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TOUCHSCANINDEX
	rlf	TOUCHSCANINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	low(TOUCHDELTAS)
	addwf	SysTemp1,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(TOUCHDELTAS)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
	return

;********************************************************************************

;Source: mTouchCVD_8Buttons.h (100)
TOUCHSERVICE
;A scan of all sensors every TOUCH_PERIOD_MS; TouchNewScan tells the program
;Dim TouchServiceSensor As Byte
;TouchNewScan = 0
	banksel	TOUCHNEWSCAN
	clrf	TOUCHNEWSCAN
;TouchNowMs = millis()
	banksel	STATUS
	pagesel	FN_MILLIS
	call	FN_MILLIS
	pagesel	$
	movf	MILLIS,W
	banksel	TOUCHNOWMS
	movwf	TOUCHNOWMS
	banksel	MILLIS_H
	movf	MILLIS_H,W
	banksel	TOUCHNOWMS_H
	movwf	TOUCHNOWMS_H
	banksel	MILLIS_U
	movf	MILLIS_U,W
	banksel	TOUCHNOWMS_U
	movwf	TOUCHNOWMS_U
	banksel	MILLIS_E
	movf	MILLIS_E,W
	banksel	TOUCHNOWMS_E
	movwf	TOUCHNOWMS_E
;TouchElapsedMs = TouchNowMs - TouchLastMs
	movf	TOUCHLASTMS,W
	subwf	TOUCHNOWMS,W
	banksel	TOUCHELAPSEDMS
	movwf	TOUCHELAPSEDMS
	banksel	TOUCHLASTMS_H
	movf	TOUCHLASTMS_H,W
	subwfb	TOUCHNOWMS_H,W
	banksel	TOUCHELAPSEDMS_H
	movwf	TOUCHELAPSEDMS_H
	banksel	TOUCHLASTMS_U
	movf	TOUCHLASTMS_U,W
	subwfb	TOUCHNOWMS_U,W
	banksel	TOUCHELAPSEDMS_U
	movwf	TOUCHELAPSEDMS_U
	banksel	TOUCHLASTMS_E
	movf	TOUCHLASTMS_E,W
	subwfb	TOUCHNOWMS_E,W
	banksel	TOUCHELAPSEDMS_E
	movwf	TOUCHELAPSEDMS_E
;If TouchElapsedMs >= TOUCH_PERIOD_MS Then
	movf	TOUCHELAPSEDMS,W
	movwf	SysLONGTempA
	movf	TOUCHELAPSEDMS_H,W
	movwf	SysLONGTempA_H
	movf	TOUCHELAPSEDMS_U,W
	movwf	SysLONGTempA_U
	movf	TOUCHELAPSEDMS_E,W
	movwf	SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SYSCOMPLESSTHAN32
	call	SYSCOMPLESSTHAN32
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF32
;TouchLastMs = TouchNowMs
	banksel	TOUCHNOWMS
	movf	TOUCHNOWMS,W
	movwf	TOUCHLASTMS
	movf	TOUCHNOWMS_H,W
	movwf	TOUCHLASTMS_H
	movf	TOUCHNOWMS_U,W
	movwf	TOUCHLASTMS_U
	movf	TOUCHNOWMS_E,W
	movwf	TOUCHLASTMS_E
;For TouchServiceSensor = 0 To TOUCH_SENSORS - 1
;Legacy method
	movlw	255
	movwf	TOUCHSERVICESENSOR
SysForLoop8
	banksel	TOUCHSERVICESENSOR
	incf	TOUCHSERVICESENSOR,F
;TouchScanSensor TouchServiceSensor
	movf	TOUCHSERVICESENSOR,W
	movwf	TOUCHSCANINDEX
	banksel	STATUS
	call	TOUCHSCANSENSOR
;Next
	banksel	TOUCHSERVICESENSOR
	movf	TOUCHSERVICESENSOR,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop8
SysForLoopEnd8
;TouchNewScan = 1
	movlw	1
	banksel	TOUCHNEWSCAN
	movwf	TOUCHNEWSCAN
;End If
ENDIF32
	banksel	STATUS
	return

;********************************************************************************

;Source: GCBASIC_mTouch_Framework_CVD_8Buttons_Serial_16F1937.gcb (166)
TOUCHSHOWLEDS
;Each LED on (low) while its sensor is pressed
;LED0 = 1
	banksel	LATC
	bsf	LATC,2
;If TouchState(0) = 2 Then LED0 = 0
	movlw	2
	banksel	SYSTOUCHSTATE_0
	subwf	SYSTOUCHSTATE_0,W
	btfss	STATUS, Z
	goto	ENDIF7
;If TouchState(0) = 2 Then LED0 = 0
	banksel	LATC
	bcf	LATC,2
;If TouchState(0) = 2 Then LED0 = 0
ENDIF7
;LED1 = 1
	banksel	LATC
	bsf	LATC,1
;If TouchState(1) = 2 Then LED1 = 0
	movlw	2
	banksel	SYSTOUCHSTATE_1
	subwf	SYSTOUCHSTATE_1,W
	btfss	STATUS, Z
	goto	ENDIF8
;If TouchState(1) = 2 Then LED1 = 0
	banksel	LATC
	bcf	LATC,1
;If TouchState(1) = 2 Then LED1 = 0
ENDIF8
;LED2 = 1
	banksel	LATC
	bsf	LATC,0
;If TouchState(2) = 2 Then LED2 = 0
	movlw	2
	banksel	SYSTOUCHSTATE_2
	subwf	SYSTOUCHSTATE_2,W
	btfss	STATUS, Z
	goto	ENDIF9
;If TouchState(2) = 2 Then LED2 = 0
	banksel	LATC
	bcf	LATC,0
;If TouchState(2) = 2 Then LED2 = 0
ENDIF9
;LED3 = 1
	banksel	LATA
	bsf	LATA,7
;If TouchState(3) = 2 Then LED3 = 0
	movlw	2
	banksel	SYSTOUCHSTATE_3
	subwf	SYSTOUCHSTATE_3,W
	btfss	STATUS, Z
	goto	ENDIF10
;If TouchState(3) = 2 Then LED3 = 0
	banksel	LATA
	bcf	LATA,7
;If TouchState(3) = 2 Then LED3 = 0
ENDIF10
;LED4 = 1
	banksel	LATA
	bsf	LATA,6
;If TouchState(4) = 2 Then LED4 = 0
	movlw	2
	banksel	SYSTOUCHSTATE_4
	subwf	SYSTOUCHSTATE_4,W
	btfss	STATUS, Z
	goto	ENDIF11
;If TouchState(4) = 2 Then LED4 = 0
	banksel	LATA
	bcf	LATA,6
;If TouchState(4) = 2 Then LED4 = 0
ENDIF11
;LED5 = 1
	banksel	LATA
	bsf	LATA,4
;If TouchState(5) = 2 Then LED5 = 0
	movlw	2
	banksel	SYSTOUCHSTATE_5
	subwf	SYSTOUCHSTATE_5,W
	btfss	STATUS, Z
	goto	ENDIF12
;If TouchState(5) = 2 Then LED5 = 0
	banksel	LATA
	bcf	LATA,4
;If TouchState(5) = 2 Then LED5 = 0
ENDIF12
;LED6 = 1
	banksel	LATD
	bsf	LATD,7
;If TouchState(6) = 2 Then LED6 = 0
	movlw	2
	banksel	SYSTOUCHSTATE_6
	subwf	SYSTOUCHSTATE_6,W
	btfss	STATUS, Z
	goto	ENDIF13
;If TouchState(6) = 2 Then LED6 = 0
	banksel	LATD
	bcf	LATD,7
;If TouchState(6) = 2 Then LED6 = 0
ENDIF13
;LED7 = 1
	banksel	LATD
	bsf	LATD,6
;If TouchState(7) = 2 Then LED7 = 0
	movlw	2
	banksel	SYSTOUCHSTATE_7
	subwf	SYSTOUCHSTATE_7,W
	btfss	STATUS, Z
	goto	ENDIF14
;If TouchState(7) = 2 Then LED7 = 0
	banksel	LATD
	bcf	LATD,6
;If TouchState(7) = 2 Then LED7 = 0
ENDIF14
	banksel	STATUS
	return

;********************************************************************************

;Source: mTouchCVD_8Buttons.h (82)
TOUCHSTART
;RAM is not cleared at reset: every sensor starts at a real reading, in power-up learning (the scans of the
;next 0.3 s set the baselines)
;Dim TouchStartSensor As Byte
;TouchJitterSeed = 0xA5              // any value but 0
	movlw	165
	banksel	TOUCHJITTERSEED
	movwf	TOUCHJITTERSEED
;For TouchStartSensor = 0 To TOUCH_SENSORS - 1
;Legacy method
	movlw	255
	movwf	TOUCHSTARTSENSOR
SysForLoop7
	banksel	TOUCHSTARTSENSOR
	incf	TOUCHSTARTSENSOR,F
;TouchFiltered(TouchStartSensor) = CVDRead(TouchStartSensor)
	movf	TOUCHSTARTSENSOR,W
	banksel	CVDSENSOR
	movwf	CVDSENSOR
	call	FN_CVDREAD
	movf	CVDREAD,W
	movwf	SysArrayTemp1
	movf	CVDREAD_H,W
	movwf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TOUCHSTARTSENSOR
	rlf	TOUCHSTARTSENSOR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	low(TOUCHFILTERED)
	addwf	SysTemp1,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(TOUCHFILTERED)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;TouchBaseline(TouchStartSensor) = 0
	clrf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TOUCHSTARTSENSOR
	rlf	TOUCHSTARTSENSOR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	low(TOUCHBASELINE)
	addwf	SysTemp1,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(TOUCHBASELINE)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;TouchState(TouchStartSensor) = 0
	movlw	low(TOUCHSTATE)
	banksel	TOUCHSTARTSENSOR
	addwf	TOUCHSTARTSENSOR,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(TOUCHSTATE)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	clrf	INDF0
;TouchScans(TouchStartSensor) = 0
	clrf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TOUCHSTARTSENSOR
	rlf	TOUCHSTARTSENSOR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	low(TOUCHSCANS)
	addwf	SysTemp1,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(TOUCHSCANS)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;TouchBaselineScans(TouchStartSensor) = 0
	movlw	low(TOUCHBASELINESCANS)
	banksel	TOUCHSTARTSENSOR
	addwf	TOUCHSTARTSENSOR,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(TOUCHBASELINESCANS)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	clrf	INDF0
;TouchSums(TouchStartSensor) = 0
	clrf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TOUCHSTARTSENSOR
	rlf	TOUCHSTARTSENSOR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	low(TOUCHSUMS)
	addwf	SysTemp1,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(TOUCHSUMS)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;TouchDeltas(TouchStartSensor) = 0
	clrf	SysArrayTemp1
	clrf	SysArrayTemp1_H
	bcf	STATUS,C
	banksel	TOUCHSTARTSENSOR
	rlf	TOUCHSTARTSENSOR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	low(TOUCHDELTAS)
	addwf	SysTemp1,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(TOUCHDELTAS)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
	addfsr	0,1
	movf	SysArrayTemp1_H,W
	movwf	INDF0
;Next
	banksel	TOUCHSTARTSENSOR
	movf	TOUCHSTARTSENSOR,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop7
SysForLoopEnd7
;TouchNewScan = 0
	banksel	TOUCHNEWSCAN
	clrf	TOUCHNEWSCAN
;TouchLastMs = millis()
	banksel	STATUS
	pagesel	FN_MILLIS
	call	FN_MILLIS
	pagesel	$
	movf	MILLIS,W
	banksel	TOUCHLASTMS
	movwf	TOUCHLASTMS
	banksel	MILLIS_H
	movf	MILLIS_H,W
	banksel	TOUCHLASTMS_H
	movwf	TOUCHLASTMS_H
	banksel	MILLIS_U
	movf	MILLIS_U,W
	banksel	TOUCHLASTMS_U
	movwf	TOUCHLASTMS_U
	banksel	MILLIS_E
	movf	MILLIS_E,W
	banksel	TOUCHLASTMS_E
	movwf	TOUCHLASTMS_E
	banksel	STATUS
	return

;********************************************************************************

;Program_memory_page: 1
	ORG	2048
;Source: mTouchCVD_8Buttons.h (159)
CVDFLOAT
;The pin an input: it floats at the level it was driven to
;If CVDFloatPort = 0 Then
	movf	CVDFLOATPORT,F
	btfss	STATUS, Z
	goto	ELSE60_1
;TRISA = TRISA Or CVDFloatMask
	banksel	TRISA
	movf	TRISA,W
	banksel	CVDFLOATMASK
	iorwf	CVDFLOATMASK,W
	banksel	TRISA
	movwf	TRISA
;Else
	goto	ENDIF60
ELSE60_1
;TRISE = TRISE Or CVDFloatMask
	banksel	TRISE
	movf	TRISE,W
	banksel	CVDFLOATMASK
	iorwf	CVDFLOATMASK,W
	banksel	TRISE
	movwf	TRISE
;End If
ENDIF60
	banksel	STATUS
	return

;********************************************************************************

;Source: mTouchCVD_8Buttons.h (129)
CVDPINLOOKUP
;Sets CVDLookupMask and CVDLookupPort (0 PORTA, 1 PORTE) for sensor CVDLookupSensor (0 to 7)
;Dim CVDLookupIndex As Byte
;CVDLookupIndex = CVDLookupSensor + 1
	incf	CVDLOOKUPSENSOR,W
	movwf	CVDLOOKUPINDEX
;ReadTable CVDPinMasks, CVDLookupIndex, CVDLookupMask
	movwf	SYSSTRINGA
	call	CVDPINMASKS
	movwf	CVDLOOKUPMASK
;CVDLookupPort = 0
	clrf	CVDLOOKUPPORT
;If CVDLookupSensor > 4 Then CVDLookupPort = 1
	movf	CVDLOOKUPSENSOR,W
	sublw	4
	btfsc	STATUS, C
	goto	ENDIF35
;If CVDLookupSensor > 4 Then CVDLookupPort = 1
	movlw	1
	movwf	CVDLOOKUPPORT
;If CVDLookupSensor > 4 Then CVDLookupPort = 1
ENDIF35
	return

;********************************************************************************

CVDPINMASKS
	movlw	9
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLECVDPINMASKS
	movwf	SysStringA
	movlw	(high TABLECVDPINMASKS) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLECVDPINMASKS
	retlw	8
	retlw	1
	retlw	2
	retlw	4
	retlw	8
	retlw	32
	retlw	1
	retlw	2
	retlw	4

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	14
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	189
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

;Source: usart.h (3610)
HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movf	HSERPRINTCRLFCOUNT,W
	movwf	SysRepeatTemp1
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd1
SysRepeatLoop1
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA
	call	HSERSEND369
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA
	call	HSERSEND369
;end Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (1952)
HSERSEND368
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop3
	btfss	PIR1,TXIF
	goto	SysWaitLoop3
;Wait until TRMT = 1
SysWaitLoop4
	banksel	TXSTA
	btfss	TXSTA,TRMT
	goto	SysWaitLoop4
;TXREG = SerData
	banksel	SERDATA
	movf	SERDATA,W
	banksel	TXREG
	movwf	TXREG
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (2071)
HSERSEND369
HSERSENDUSART1HANDLER
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop5
	btfss	PIR1,TXIF
	goto	SysWaitLoop5
;Wait until TRMT = 1
SysWaitLoop6
	banksel	TXSTA
	btfss	TXSTA,TRMT
	goto	SysWaitLoop6
;TXREG = SerData
	banksel	SERDATA
	movf	SERDATA,W
	banksel	TXREG
	movwf	TXREG
	banksel	STATUS
	return

;********************************************************************************

;Source: GCBASIC_mTouch_Framework_CVD_8Buttons_Serial_16F1937.gcb (154)
LEDSOFF
;Every LED off
;LED0 = 1
	banksel	LATC
	bsf	LATC,2
;LED1 = 1
	bsf	LATC,1
;LED2 = 1
	bsf	LATC,0
;LED3 = 1
	bsf	LATA,7
;LED4 = 1
	bsf	LATA,6
;LED5 = 1
	bsf	LATA,4
;LED6 = 1
	bsf	LATD,7
;LED7 = 1
	bsf	LATD,6
	banksel	STATUS
	return

;********************************************************************************

;Source: GCBASIC_mTouch_Framework_CVD_8Buttons_Serial_16F1937.gcb (142)
LEDSON
;Every LED on
;LED0 = 0
	banksel	LATC
	bcf	LATC,2
;LED1 = 0
	bcf	LATC,1
;LED2 = 0
	bcf	LATC,0
;LED3 = 0
	bcf	LATA,7
;LED4 = 0
	bcf	LATA,6
;LED5 = 0
	bcf	LATA,4
;LED6 = 0
	bcf	LATD,7
;LED7 = 0
	bcf	LATD,6
	banksel	STATUS
	return

;********************************************************************************

;Source: millis.h (566)
FN_MILLIS
;dim Millis, MsCtr_ as long
;disable interrupts while we read millis or we might get an
;inconsistent value (e.g. in the middle of a write to millis)
;IntOff
	bcf	SYSINTSTATESAVE0,1
	btfsc	INTCON,GIE
	bsf	SYSINTSTATESAVE0,1
	bcf	INTCON,GIE
;Millis = MsCtr_
	movf	MSCTR_,W
	movwf	MILLIS
	movf	MSCTR__H,W
	movwf	MILLIS_H
	movf	MSCTR__U,W
	movwf	MILLIS_U
	movf	MSCTR__E,W
	movwf	MILLIS_E
;IntOn
	btfss	SYSINTSTATESAVE0,1
	bcf	INTCON,GIE
	btfsc	SYSINTSTATESAVE0,1
	bsf	INTCON,GIE
	return

;********************************************************************************

;Source: millis.h (282)
MSCTR_INT_HDLR
;dim MsCtr_ as Long
;Call_SetTimer_Millis_macro
;SetTimer_Millis  SCRIPT_TMR0INITVAL + MILLIS_TIMER_VALUE_ADJUST   ' Reset Inital Counter value
;Macro Source: millis.h (576)
;Handle chips withOUT TMR0H
;TMR0 = TMRValueMillis
	movlw	6
	movwf	TMR0
;MsCtr_ = MsCtr_ + 1
	incf	MSCTR_,F
	btfsc	STATUS,Z
	incf	MSCTR__H,F
	btfsc	STATUS,Z
	incf	MSCTR__U,F
	btfsc	STATUS,Z
	incf	MSCTR__E,F
	return

;********************************************************************************

PADLABELS
	movlw	9
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEPADLABELS
	movwf	SysStringA
	movlw	(high TABLEPADLABELS) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEPADLABELS
	retlw	8
	retlw	56
	retlw	57
	retlw	65
	retlw	66
	retlw	67
	retlw	68
	retlw	69
	retlw	70

;********************************************************************************

;Source: GCBASIC_mTouch_Framework_CVD_8Buttons_Serial_16F1937.gcb (284)
PADLABELSEND
;Sends sensor PadLabelSensor's label (one character)
;Dim PadLabelIndex, PadLabelChar As Byte
;PadLabelIndex = PadLabelSensor + 1
	incf	PADLABELSENSOR,W
	movwf	PADLABELINDEX
;ReadTable PadLabels, PadLabelIndex, PadLabelChar
	movwf	SYSSTRINGA
	call	PADLABELS
	movwf	PADLABELCHAR
;HSerSend PadLabelChar
	movwf	SERDATA
	goto	HSERSEND368

;********************************************************************************

;Source: system.h (4224)
SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	subwf	SYSWORDTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	subwf	SYSWORDTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (4588)
SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;bsf STATUS, C
	bsf	STATUS, C
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;subwf SysByteTempA, W
	subwf	SYSBYTETEMPA, W
;btfss STATUS, C
	btfss	STATUS, C
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (4618)
SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLT16True
	goto	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (4676)
SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test Exp, exit if more
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT32TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (3524)
SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfsc STATUS, Z
	btfsc	STATUS, Z
;return
	return
;Main calc routine
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C
;rlf SysByteTempA, F
	rlf	SYSBYTETEMPA, F
;rlf SysByteTempX, F
	rlf	SYSBYTETEMPX, F
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0
;btfsc STATUS, C
	btfsc	STATUS, C
;goto Div8NotNeg
	goto	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv8Start
	goto	SYSDIV8START
	return

;********************************************************************************

;Source: system.h (3011)
SYSMULTSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
MUL8LOOP
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;btfsc SysByteTempB, 0
	btfsc	SYSBYTETEMPB, 0
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F
;bcf STATUS, C
	bcf	STATUS, C
;rrf SysByteTempB, F
	rrf	SYSBYTETEMPB, F
;bcf STATUS, C
	bcf	STATUS, C
;rlf SysByteTempA, F
	rlf	SYSBYTETEMPA, F
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfss STATUS, Z
	btfss	STATUS, Z
;goto MUL8LOOP
	goto	MUL8LOOP
	return

;********************************************************************************

;Source: mTouchCVD_8Buttons.h (224)
TOUCHJITTER
;A random delay of 0 to 63 loops before each reading, from the framework's 8-bit LFSR (shift right, XOR 0xB4
;when a 1 is shifted out), so the readings do not lock on to noise at a fixed frequency
;Dim TouchJitterCount As Byte
;If TouchJitterSeed.0 = 1 Then
	banksel	TOUCHJITTERSEED
	btfss	TOUCHJITTERSEED,0
	goto	ELSE61_1
;TouchJitterSeed = TouchJitterSeed / 2
	bcf	STATUS,C
	rrf	TOUCHJITTERSEED,F
;TouchJitterSeed = TouchJitterSeed Xor 0xB4
	movlw	180
	xorwf	TOUCHJITTERSEED,F
;Else
	goto	ENDIF61
ELSE61_1
;TouchJitterSeed = TouchJitterSeed / 2
	bcf	STATUS,C
	rrf	TOUCHJITTERSEED,F
;End If
ENDIF61
;TouchJitterCount = TouchJitterSeed And TOUCH_JITTER_MASK
	movlw	63
	andwf	TOUCHJITTERSEED,W
	movwf	TOUCHJITTERCOUNT
;Do While TouchJitterCount > 0
SysDoLoop_S2
	movf	TOUCHJITTERCOUNT,W
	sublw	0
	btfsc	STATUS, C
	goto	SysDoLoop_E2
;TouchJitterCount--
	decf	TOUCHJITTERCOUNT,F
;Loop
	goto	SysDoLoop_S2
SysDoLoop_E2
	banksel	STATUS
	return

;********************************************************************************

;Program_memory_page: 2
	ORG	4096
;Program_memory_page: 3
	ORG	6144

 END
