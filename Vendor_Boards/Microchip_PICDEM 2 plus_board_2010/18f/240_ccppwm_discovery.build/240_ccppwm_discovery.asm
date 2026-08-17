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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\240_ccppwm_discovery.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : 
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\240_ccppwm_discovery.build\240_ccppwm_discovery.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\240_ccppwm_discovery.gcb"
 SUBTITLE    "08-17-2026 09:16:14"
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
BYTENUM                          EQU    1293          ; 0x50D (SA)
BYTETOBIN                        EQU    5073          ; 0x13D1
CCPCONCACHE                      EQU    1294          ; 0x50E (SA)
CHR                              EQU    5123          ; 0x1403
COMPORT                          EQU    1295          ; 0x50F (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
HSERPRINTCRLFCOUNT               EQU    1296          ; 0x510 (SA)
OUTVALUETEMP                     EQU    1297          ; 0x511 (SA)
PAD                              EQU    5082          ; 0x13DA
PRINTLEN                         EQU    1298          ; 0x512 (SA)
PRX_TEMP                         EQU    1299          ; 0x513 (SA)
PRX_TEMP_E                       EQU    1302          ; 0x516 (SA)
PRX_TEMP_H                       EQU    1300          ; 0x514 (SA)
PRX_TEMP_U                       EQU    1301          ; 0x515 (SA)
PWMCHANNEL                       EQU    1303          ; 0x517 (SA)
PWMDUTY                          EQU    1304          ; 0x518 (SA)
PWMDUTY_H                        EQU    1305          ; 0x519 (SA)
PWMFREQ                          EQU    1306          ; 0x51A (SA)
PWMRESOLUTION                    EQU    1307          ; 0x51B (SA)
PWMRESOLUTION_H                  EQU    1308          ; 0x51C (SA)
SERDATA                          EQU    1309          ; 0x51D (SA)
SERPRINTVAL                      EQU    1310          ; 0x51E (SA)
STR                              EQU    5067          ; 0x13CB
STRINGPOINTER                    EQU    1311          ; 0x51F (SA)
SYSARRAYTEMP1                    EQU    1312          ; 0x520 (SA)
SYSARRAYTEMP2                    EQU    1313          ; 0x521 (SA)
SYSBYTETEMPA                     EQU    1285          ; 0x505 (SA)
SYSBYTETEMPB                     EQU    1289          ; 0x509 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPA                     EQU    1285          ; 0x505 (SA)
SYSCALCTEMPX                     EQU    1280          ; 0x500 (SA)
SYSCALCTEMPX_H                   EQU    1281          ; 0x501 (SA)
SYSCHAR                          EQU    1314          ; 0x522 (SA)
SYSCHARCOUNT                     EQU    1315          ; 0x523 (SA)
SYSDIVLOOP                       EQU    1284          ; 0x504 (SA)
SYSDIVMULTA                      EQU    1287          ; 0x507 (SA)
SYSDIVMULTA_H                    EQU    1288          ; 0x508 (SA)
SYSDIVMULTB                      EQU    1291          ; 0x50B (SA)
SYSDIVMULTB_H                    EQU    1292          ; 0x50C (SA)
SYSDIVMULTX                      EQU    1282          ; 0x502 (SA)
SYSDIVMULTX_H                    EQU    1283          ; 0x503 (SA)
SYSLONGDIVMULTA                  EQU    1316          ; 0x524 (SA)
SYSLONGDIVMULTA_E                EQU    1319          ; 0x527 (SA)
SYSLONGDIVMULTA_H                EQU    1317          ; 0x525 (SA)
SYSLONGDIVMULTA_U                EQU    1318          ; 0x526 (SA)
SYSLONGDIVMULTB                  EQU    1320          ; 0x528 (SA)
SYSLONGDIVMULTB_E                EQU    1323          ; 0x52B (SA)
SYSLONGDIVMULTB_H                EQU    1321          ; 0x529 (SA)
SYSLONGDIVMULTB_U                EQU    1322          ; 0x52A (SA)
SYSLONGDIVMULTX                  EQU    1324          ; 0x52C (SA)
SYSLONGDIVMULTX_E                EQU    1327          ; 0x52F (SA)
SYSLONGDIVMULTX_H                EQU    1325          ; 0x52D (SA)
SYSLONGDIVMULTX_U                EQU    1326          ; 0x52E (SA)
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
SYSPRINTDATAHANDLER              EQU    1328          ; 0x530 (SA)
SYSPRINTDATAHANDLER_H            EQU    1329          ; 0x531 (SA)
SYSPRINTTEMP                     EQU    1330          ; 0x532 (SA)
SYSREPEATTEMP1                   EQU    1331          ; 0x533 (SA)
SYSREPEATTEMP2                   EQU    1332          ; 0x534 (SA)
SYSREPEATTEMP4                   EQU    1333          ; 0x535 (SA)
SYSREPEATTEMP5                   EQU    1334          ; 0x536 (SA)
SYSSTRDATA                       EQU    1335          ; 0x537 (SA)
SYSSTRINGA                       EQU    1287          ; 0x507 (SA)
SYSSTRINGA_H                     EQU    1288          ; 0x508 (SA)
SYSSTRINGLENGTH                  EQU    1286          ; 0x506 (SA)
SYSSTRINGPARAM1                  EQU    5270          ; 0x1496
SYSSTRINGPARAM2                  EQU    5060          ; 0x13C4
SYSSTRINGPARAM3                  EQU    5164          ; 0x142C
SYSSTRINGTEMP                    EQU    1336          ; 0x538
SYSSTRLEN                        EQU    1337          ; 0x539 (SA)
SYSSYSINSTRING3HANDLER           EQU    1338          ; 0x53A (SA)
SYSSYSINSTRING3HANDLER_H         EQU    1339          ; 0x53B (SA)
SYSSYSINSTRINGHANDLER            EQU    1340          ; 0x53C (SA)
SYSSYSINSTRINGHANDLER_H          EQU    1341          ; 0x53D (SA)
SYSTEMP1                         EQU    1342          ; 0x53E (SA)
SYSTEMP1_E                       EQU    1345          ; 0x541 (SA)
SYSTEMP1_H                       EQU    1343          ; 0x53F (SA)
SYSTEMP1_U                       EQU    1344          ; 0x540 (SA)
SYSTEMP2                         EQU    1346          ; 0x542 (SA)
SYSVALTEMP                       EQU    1347          ; 0x543 (SA)
SYSVALTEMP_H                     EQU    1348          ; 0x544 (SA)
SYSWAITTEMPMS                    EQU    1282          ; 0x502 (SA)
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503 (SA)
SYSWAITTEMPS                     EQU    1284          ; 0x504 (SA)
SYSWORDTEMPA                     EQU    1285          ; 0x505 (SA)
SYSWORDTEMPA_H                   EQU    1286          ; 0x506 (SA)
SYSWORDTEMPB                     EQU    1289          ; 0x509 (SA)
SYSWORDTEMPB_H                   EQU    1290          ; 0x50A (SA)
SYSWORDTEMPX                     EQU    1280          ; 0x500 (SA)
SYSWORDTEMPX_H                   EQU    1281          ; 0x501 (SA)
TIMERSELECTIONBITS               EQU    1349          ; 0x545 (SA)
TX_PR                            EQU    1350          ; 0x546 (SA)
_HEXPICAS                        EQU    5063          ; 0x13C7
_PWMTIMERSELECTED                EQU    1351          ; 0x547 (SA)

;********************************************************************************

;Alias variables
AFSR0 EQU 1257
AFSR0_H EQU 1258
SYSCHR_0 EQU 5123
SYSCHR_1 EQU 5124
SYSPAD_0 EQU 5082
SYSSTR_0 EQU 5067
SYS_HEXPICAS_0 EQU 5063
SYS_HEXPICAS_1 EQU 5064
SYS_HEXPICAS_2 EQU 5065

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
	call	INITSYS
	call	INITPPS
	call	INITUSART
	call	INITPWM

;Start_of_the_main_program
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
;IO:    ----TX--------------CCP1---------
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
;PIC PPS Tool version: 0.0.6.5
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
;------ Start of main Program
;#DEFINE DEVELOPER_PWM_DEBUG
;HSerSend 1  // clear terminal
	movlw	1
	movwf	SERDATA,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	rcall	HSERSEND347
;wait 100 ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;HSerSend 1  // clear terminal
	movlw	1
	movwf	SERDATA,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERSEND347
;wait 100 ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;HSerPrintStringCRLF "Hardware CCP/PWM Discovery"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*26
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintStringCRLF "Before PWMon = Fixed Mode PWM"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*29
	rcall	HSERPRINTSTRINGCRLF
;ShowDetails
	call	SHOWDETAILS
;PWMOn
	call	PWMON23
;HSerPrintStringCRLF "After PWMon"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*11
	rcall	HSERPRINTSTRINGCRLF
;ShowDetails
	call	SHOWDETAILS
;HserPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrintStringCRLF "If no Fixed Mode PWM signal... are the PWM ports set to OUT? Correct PPS?"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*73
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintStringCRLF " or, the registers in this chip are not the same is on previous chips"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*69
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintStringCRLF "     compare CCPCONCache  to CCP1CON.  The enable bit needs to set for Fixed Mode PWM to work"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable6
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*93
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintStringCRLF "     the error is probalby a renamed bit in CCP1CON or one of the other key registers/"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable7
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*86
	rcall	HSERPRINTSTRINGCRLF
;HserPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;Repeat 10
	movlw	10
	movwf	SysRepeatTemp1,ACCESS
SysRepeatLoop1
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;HserSend "."
	movlw	46
	movwf	SERDATA,ACCESS
	rcall	HSERSEND346
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrintStringCRLF "PWMOff"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable9
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*6
	rcall	HSERPRINTSTRINGCRLF
;PWMoff
	call	PWMOFF26
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrintStringCRLF "After PWMoff"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable10
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*12
	rcall	HSERPRINTSTRINGCRLF
;ShowDetails
	call	SHOWDETAILS
;HSerPrintStringCRLF "Fixed mode PWM signal will now stop"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable11
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*35
	rcall	HSERPRINTSTRINGCRLF
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;These variables are in pmw.h used to calc the registers. Set to zero here just to see the values after the functional call.
;PWMDuty = 0
	clrf	PWMDUTY,ACCESS
;PWMResolution = 0
	clrf	PWMRESOLUTION,ACCESS
;HSerPrint "Issue `HPWM 1, PWM_FREQ,"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*24
	rcall	HSERPRINT359
;HSerprint CALCULATED_PWM_DUTY
	movlw	127
	movwf	SERPRINTVAL,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT361
;HSerPrintStringCRLF "` command.  The third parameter range is 0 to 255, where 127 = 50%"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable13
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable13
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable13
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*66
	rcall	HSERPRINTSTRINGCRLF
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HPWM 1, PWM_FREQ, CALCULATED_PWM_DUTY
	movlw	1
	movwf	PWMCHANNEL,ACCESS
	movlw	38
	movwf	PWMFREQ,ACCESS
	movlw	127
	movwf	PWMDUTY,ACCESS
	clrf	PWMDUTY_H,ACCESS
	rcall	HPWM30
;HPWM_CCPTimerN 1, PWM_FREQ, CALCULATED_PWM_DUTY, 2  // Equates to using Timer2
;! uncomment to add this to the pwm.h section as a test, if no PWM signal
;#define AddHPWMCCPExit1 CCP1CON  = CCPCONCache
;HSerPrintStringCRLF pad("", 80, "*")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable14
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable14
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable14
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	80
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable15
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM2*1
;Using SYSSTRINGPARAM1*0
	rcall	FN_PAD
	movlw	low PAD
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high PAD
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTSTRINGCRLF
;HSerPrint "After `HPWM 1, PWM_FREQ,"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable16
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable16
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable16
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*24
	rcall	HSERPRINT359
;HSerprint CALCULATED_PWM_DUTY
	movlw	127
	movwf	SERPRINTVAL,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT361
;HSerPrintStringCRLF "` command"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable17
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable17
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable17
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*9
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrintStringCRLF " As HPWM() used same Frq & Duty as `fixed mode PWM`, then, CCP1CON should be equal to CCPCONCache"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable18
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable18
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable18
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*97
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrintStringCRLF "No signal ?"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable19
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*11
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintStringCRLF "  1. Has ChipFamilyPWMCCP1CON16Handler, in PWM.h, been updated for this chip family ?"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable20
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable20
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable20
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*85
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintStringCRLF "     If the specific chip has ONLY ONE CCP then the section ChipFamilyPWMCCP1CON16Handler must be updated"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable21
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable21
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable21
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*105
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintStringCRLF "     So, check the datasheet for CCP1 only.. so, search for CCP2 if not found then only one CCP"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable22
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*95
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrintStringCRLF "  2. Is CCPTMRS0 correct for timer2? if not, is PWMTimerVariant in DAT file the correct value ?"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable23
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable23
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable23
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*95
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrintStringCRLF "  3. Examine SETUPCCPPWMREGISTERS section in pwm.h... there is clearly a library issue"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable24
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable24
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable24
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*86
	rcall	HSERPRINTSTRINGCRLF
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrintStringCRLF "If PWM is working.. Then, all is good!"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable25
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable25
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable25
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*38
	rcall	HSERPRINTSTRINGCRLF
;HSerPrintStringCRLF pad("", 80, "*")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable14
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable14
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable14
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	80
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable15
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM2*1
;Using SYSSTRINGPARAM1*0
	rcall	FN_PAD
	movlw	low PAD
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high PAD
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTSTRINGCRLF
;ShowDetails
	rcall	SHOWDETAILS
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrintStringCRLF "Completed - examine results"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable26
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable26
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable26
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*27
	rcall	HSERPRINTSTRINGCRLF
;Do
SysDoLoop_S1
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

;Source: string.h (1171)
FN_BYTETOBIN
;ByteToBin = ""
	lfsr	1,BYTETOBIN
	movlw	low StringTable14
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable14
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable14
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
;Repeat 8
	movlw	8
	movwf	SysRepeatTemp4,ACCESS
SysRepeatLoop4
;If ByteNum.7 = 1 Then
	btfss	BYTENUM,7,ACCESS
	bra	ELSE19_1
;ByteToBin = ByteToBin +"1"
	lfsr	1,BYTETOBIN
	clrf	SysStringLength,ACCESS
	lfsr	0,BYTETOBIN
	call	SYSCOPYSTRINGPART
	movlw	low StringTable121
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable121
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable121
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,BYTETOBIN
	movff	SysStringLength, INDF0
;Else
	bra	ENDIF19
ELSE19_1
;ByteToBin = ByteToBin +"0"
	lfsr	1,BYTETOBIN
	clrf	SysStringLength,ACCESS
	lfsr	0,BYTETOBIN
	call	SYSCOPYSTRINGPART
	movlw	low StringTable122
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable122
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable122
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,BYTETOBIN
	movff	SysStringLength, INDF0
;End If
ENDIF19
;Rotate ByteNum Left
	rlcf	BYTENUM,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp4,F,ACCESS
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
	return

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
	call	SYSMULTSUB32
	movff	SysLONGTempX,PRX_TEMP
	movff	SysLONGTempX_H,PRX_TEMP_H
	movff	SysLONGTempX_U,PRX_TEMP_U
	movff	SysLONGTempX_E,PRX_TEMP_E
;Set C off
	bcf	STATUS,C,ACCESS
;Repeat 2
	movlw	2
	movwf	SysRepeatTemp2,ACCESS
SysRepeatLoop2
;rotate PRx_Temp left
	rlcf	PRX_TEMP,F,ACCESS
	rlcf	PRX_TEMP_H,F,ACCESS
	rlcf	PRX_TEMP_U,F,ACCESS
	rlcf	PRX_TEMP_E,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp2,F,ACCESS
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;PRx_Temp = PRx_Temp / PWMResolution    'where PWMResolution is 255 or 1023
	movff	PRX_TEMP,SysLONGTempA
	movff	PRX_TEMP_H,SysLONGTempA_H
	movff	PRX_TEMP_U,SysLONGTempA_U
	movff	PRX_TEMP_E,SysLONGTempA_E
	movff	PWMRESOLUTION,SysLONGTempB
	movff	PWMRESOLUTION_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSDIVSUB32
	movff	SysLONGTempA,PRX_TEMP
	movff	SysLONGTempA_H,PRX_TEMP_H
	movff	SysLONGTempA_U,PRX_TEMP_U
	movff	SysLONGTempA_E,PRX_TEMP_E
;Set C off
	bcf	STATUS,C,ACCESS
;Repeat 6
	movlw	6
	movwf	SysRepeatTemp2,ACCESS
SysRepeatLoop3
;rotate PRx_Temp left
	rlcf	PRX_TEMP,F,ACCESS
	rlcf	PRX_TEMP_H,F,ACCESS
	rlcf	PRX_TEMP_U,F,ACCESS
	rlcf	PRX_TEMP_E,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp2,F,ACCESS
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;exits with PRx_Temp calculated
	return

;********************************************************************************

;Source: string.h (1156)
FN_CHR
;Empty input?
;If SysChar < 0 Then
	movlw	0
	subwf	SYSCHAR,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF18
;Chr(0) = 0
	banksel	SYSCHR_0
	clrf	SYSCHR_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF18
;Chr(0) = 1
	movlw	1
	banksel	SYSCHR_0
	movwf	SYSCHR_0,BANKED
;Copy characters
;Chr(1) = SysChar
	movffl	SYSCHAR,SYSCHR_1
	banksel	0
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

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	decfsz	SysWaitTempS, F,ACCESS
	bra	DS_START
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:BYTE:, Source: pwm.h (2886)
HPWM30
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
	call	SYSDIVSUB32
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
SysSelect1Case1
	movlw	2
	subwf	_PWMTIMERSELECTED,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
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
SysSelectEnd1
END_OF_CCPPWMSETUPCLOCKSOURCE
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

;Overloaded signature: STRING:byte:, Source: usart.h (3399)
HSERPRINT359
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF30
;Write Data
;for SysPrintTemp = 1 to PrintLen
;Legacy method
	clrf	SYSPRINTTEMP,ACCESS
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
	incf	SYSPRINTTEMP,F,ACCESS
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND347
;next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;End If
ENDIF30
;CR
;All Usarts
;--------------------------
;Specific USARTs
;------------------
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (3473)
HSERPRINT361
;OutValueTemp = 0
	clrf	OUTVALUETEMP,ACCESS
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ENDIF33
;OutValueTemp = SerPrintVal / 100
	movff	SERPRINTVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,ACCESS
	movwf	SERDATA,ACCESS
	rcall	HSERSEND347
;End If
ENDIF33
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp2
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp2,W,ACCESS
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,ACCESS
	btfss	SysTemp1,0,ACCESS
	bra	ENDIF34
;OutValueTemp = SerPrintVal / 10
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,ACCESS
	movwf	SERDATA,ACCESS
	rcall	HSERSEND347
;End If
ENDIF34
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W,ACCESS
	movwf	SERDATA,ACCESS
	bra	HSERSEND347
;CR

;********************************************************************************

;Source: usart.h (3607)
HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp5
	movf	SYSREPEATTEMP5,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd5
SysRepeatLoop5
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,ACCESS
	rcall	HSERSEND347
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,ACCESS
	rcall	HSERSEND347
;end Repeat
	decfsz	SysRepeatTemp5,F,ACCESS
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
	return

;********************************************************************************

;Source: usart.h (3382)
HSERPRINTSTRINGCRLF
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF27
;Write Data
;for SysPrintTemp = 1 to PrintLen
;Legacy method
	clrf	SYSPRINTTEMP,ACCESS
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
	incf	SYSPRINTTEMP,F,ACCESS
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND347
;next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;End If
ENDIF27
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,ACCESS
	rcall	HSERSEND347
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,ACCESS
	bra	HSERSEND347

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (1950)
HSERSEND346
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop1
	btfss	PIR5,U1TXIF,ACCESS
	bra	SysWaitLoop1
;TXREG = SerData
	movff	SERDATA,U1TXB
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (2069)
HSERSEND347
HSERSENDUSART1HANDLER
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop2
	btfss	PIR5,U1TXIF,ACCESS
	bra	SysWaitLoop2
;TXREG = SerData
	movff	SERDATA,U1TXB
	return

;********************************************************************************

;Source: 240_ccppwm_discovery.gcb (40)
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

;Source: usart.h (1282)
INITUSART
;Set the default value for USART handler - required when more than one USART
;comport = SCRIPT_DEFAULT_COMPORT
	movlw	1
	movwf	COMPORT,ACCESS
;PIC USART 1 Init
;U1BRGH=SPBRGH_TEMP
	movlw	6
	banksel	U1BRGH
	movwf	U1BRGH,BANKED
;U1BRGL=SPBRGL_TEMP
	movlw	129
	movwf	U1BRGL,BANKED
;U1BRGS = BRGS1_SCRIPT
	bsf	U1CON0,U1BRGS,BANKED
;U1TXEN=1   'Enable TX1
	bsf	U1CON0,U1TXEN,BANKED
;U1RXEN=1   'Enable RX1
	bsf	U1CON0,U1RXEN,BANKED
;ON_U1CON1=1 'Enable USART1
	bsf	U1CON1,ON_U1CON1,BANKED
	banksel	0
	return

;********************************************************************************

;Source: string.h (1291)
FN_PAD
;Check length of SysInString
;If SysInString(0) = longer or equal SysStrLen then
;give back SysInString and exit function
;If SysInString(0) < SysStrLen Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSSTRLEN,W,ACCESS
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ELSE20_1
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;clear output string
;Pad=""
	lfsr	1,PAD
	movlw	low StringTable14
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable14
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable14
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
;Legacy method
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
SysForLoop2
	incf	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,PAD
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp2,POSTINC0
;Next
	movf	SYSCHARCOUNT,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;For SysStringTemp = SysCharCount+1 to SysStrLen
;Legacy method
	incf	SYSCHARCOUNT,W,ACCESS
	movwf	SysTemp2,ACCESS
	decf	SysTemp2,W,ACCESS
	movwf	SYSSTRINGTEMP,BANKED
	incf	SYSCHARCOUNT,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempB
	movff	SYSSTRLEN,SysBYTETempA
	banksel	0
	call	SYSCOMPLESSTHAN
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd3
SysForLoop3
	banksel	SYSSTRINGTEMP
	incf	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString3(1)
	movlw	1
	addwf	SysSYSINSTRING3Handler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRING3Handler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,PAD
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp1,POSTINC0
;Next
	movf	SYSSTRLEN,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;set new length to PAD
;Pad(0) = SysStrLen
	movffl	SYSSTRLEN,SYSPAD_0
;else
	bra	ENDIF20
ELSE20_1
;SysInString is equal or longer than SysStrLen
;give back old string; copy SysInString to Pad
;For SysStringTemp = 1 To SysInString(0)
;Legacy method
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
	incf	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,PAD
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp2,POSTINC0
;Next
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;PAD(0) = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	POSTINC0,SysArrayTemp1
	movffl	SysArrayTemp1,SYSPAD_0
;End If
ENDIF20
	banksel	0
	return

;********************************************************************************

;Overloaded signature: , Source: pwm.h (2664)
PWMOFF26
;CCP1CON = 0
	banksel	CCP1CON
	clrf	CCP1CON,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: , Source: pwm.h (2374)
PWMON23
;CCP1CON = CCPCONCache
	movff	CCPCONCACHE,CCP1CON
	return

;********************************************************************************

;Source: 240_ccppwm_discovery.gcb (209)
SHOWDETAILS
;! If this causes and error .. remove the first one. Let the be the only #startup instruction
;HSerPrint "Constants"               : HserPrintCRLF
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable27
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable27
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable27
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*9
	rcall	HSERPRINT359
;HSerPrint "Constants"               : HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HserPrint "PWM_FREQ:        "
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable28
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable28
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable28
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*17
	rcall	HSERPRINT359
;HserPrint PWM_FREQ          : HserPrintCRLF
	movlw	38
	movwf	SERPRINTVAL,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT361
;HserPrint PWM_FREQ          : HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HserPrint "PWM_DUTY:        "
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable29
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*17
	rcall	HSERPRINT359
;HserPrint PWM_DUTY          : HserPrintCRLF
	movlw	50
	movwf	SERPRINTVAL,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT361
;HserPrint PWM_DUTY          : HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HserPrint "USE_HPWMCCP1:    "
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable30
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable30
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable30
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*17
	rcall	HSERPRINT359
;HserPrint USE_HPWMCCP1      : HserPrintCRLF
	setf	SERPRINTVAL,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT361
;HserPrint USE_HPWMCCP1      : HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HserPrint "USE_HPWM_TIMER2: "
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable31
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable31
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable31
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*17
	rcall	HSERPRINT359
;HserPrint USE_HPWM_TIMER2   : HserPrintCRLF
	setf	SERPRINTVAL,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT361
;HserPrint USE_HPWM_TIMER2   : HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HserPrint "Registers": HserPrintCRLF
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*9
	rcall	HSERPRINT359
;HserPrint "Registers": HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;PReg("CCP1CON      ", CCP1CON, "CCP Control Register" )
;Macro Source: 240_ccppwm_discovery.gcb (257)
;HSerPrint "  "+xstr+": "
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable58
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable34
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable34
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable34
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable59
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCP1CON,BYTENUM
	rcall	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCP1CON,SYSVALTEMP
	call	FN__HEXPICAS
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable60
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,_HEXPICAS
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*4
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCP1CON,SYSVALTEMP
	clrf	SYSVALTEMP_H,ACCESS
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	10
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable62
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM3*1
	rcall	FN_PAD
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable61
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,PAD
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	9
	movwf	SYSCHAR,ACCESS
	rcall	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable35
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable35
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable35
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*0
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;PReg("CCPCONCache  ", CCPCONCache, "Cached register used to by PWMon" )
;Macro Source: 240_ccppwm_discovery.gcb (257)
;HSerPrint "  "+xstr+": "
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable58
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable36
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable36
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable36
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable59
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCPCONCACHE,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCPCONCACHE,SYSVALTEMP
	call	FN__HEXPICAS
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable60
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,_HEXPICAS
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*4
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCPCONCACHE,SYSVALTEMP
	clrf	SYSVALTEMP_H,ACCESS
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	10
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable62
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM3*1
	rcall	FN_PAD
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable61
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,PAD
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	9
	movwf	SYSCHAR,ACCESS
	rcall	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable37
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable37
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable37
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*0
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;PReg("T2PR         ", T2PR, "Timer Period" )
;Macro Source: 240_ccppwm_discovery.gcb (257)
;HSerPrint "  "+xstr+": "
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable58
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable38
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable38
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable38
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable59
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	T2PR,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	T2PR,SYSVALTEMP
	call	FN__HEXPICAS
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable60
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,_HEXPICAS
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*4
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	T2PR,SYSVALTEMP
	clrf	SYSVALTEMP_H,ACCESS
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	10
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable62
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM3*1
	rcall	FN_PAD
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable61
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,PAD
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	9
	movwf	SYSCHAR,ACCESS
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable39
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable39
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable39
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*0
	rcall	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;Preg("T2CON        ", T2CON ,"Timer2 control")
;Macro Source: 240_ccppwm_discovery.gcb (257)
;HSerPrint "  "+xstr+": "
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable58
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable41
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable41
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable41
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable59
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	T2CON,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	T2CON,SYSVALTEMP
	call	FN__HEXPICAS
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable60
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,_HEXPICAS
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*4
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	T2CON,SYSVALTEMP
	clrf	SYSVALTEMP_H,ACCESS
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	10
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable62
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM3*1
	rcall	FN_PAD
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable61
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,PAD
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	9
	movwf	SYSCHAR,ACCESS
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable42
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*0
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Preg("T2CLKCON     ", T2CLKCON, "Clock Source Selection" )
;Macro Source: 240_ccppwm_discovery.gcb (257)
;HSerPrint "  "+xstr+": "
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable58
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable43
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable43
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable43
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable59
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	T2CLKCON,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	T2CLKCON,SYSVALTEMP
	call	FN__HEXPICAS
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable60
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,_HEXPICAS
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*4
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	T2CLKCON,SYSVALTEMP
	clrf	SYSVALTEMP_H,ACCESS
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	10
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable62
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM3*1
	call	FN_PAD
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable61
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,PAD
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	9
	movwf	SYSCHAR,ACCESS
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable44
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable44
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable44
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*0
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Preg("CCPR1H       ", CCPR1H, "Duty cycle H" )
;Macro Source: 240_ccppwm_discovery.gcb (257)
;HSerPrint "  "+xstr+": "
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable58
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable45
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable45
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable45
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable59
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCPR1H,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCPR1H,SYSVALTEMP
	call	FN__HEXPICAS
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable60
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,_HEXPICAS
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*4
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCPR1H,SYSVALTEMP
	clrf	SYSVALTEMP_H,ACCESS
	rcall	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	10
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable62
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM3*1
	call	FN_PAD
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable61
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,PAD
	call	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	9
	movwf	SYSCHAR,ACCESS
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable46
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable46
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable46
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*0
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Preg("CCPR1L       ", CCPR1L, "Duty cycle L")
;Macro Source: 240_ccppwm_discovery.gcb (257)
;HSerPrint "  "+xstr+": "
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable58
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable47
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable47
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable47
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable59
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCPR1L,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCPR1L,SYSVALTEMP
	call	FN__HEXPICAS
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable60
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,_HEXPICAS
	rcall	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*4
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCPR1L,SYSVALTEMP
	clrf	SYSVALTEMP_H,ACCESS
	rcall	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	10
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable62
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM3*1
	call	FN_PAD
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable61
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,PAD
	rcall	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	9
	movwf	SYSCHAR,ACCESS
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	rcall	SYSCOPYSTRINGPART
	movlw	low StringTable48
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable48
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable48
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*0
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Preg("CCPTMRS0     ", CCPTMRS0, "Timer Selection")
;Macro Source: 240_ccppwm_discovery.gcb (257)
;HSerPrint "  "+xstr+": "
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable58
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable49
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable49
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable49
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable59
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCPTMRS0,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCPTMRS0,SYSVALTEMP
	call	FN__HEXPICAS
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable60
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,_HEXPICAS
	rcall	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*4
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	CCPTMRS0,SYSVALTEMP
	clrf	SYSVALTEMP_H,ACCESS
	rcall	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	10
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable62
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM3*1
	call	FN_PAD
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable61
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,PAD
	rcall	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	9
	movwf	SYSCHAR,ACCESS
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	rcall	SYSCOPYSTRINGPART
	movlw	low StringTable50
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable50
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable50
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*0
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;HserPrint "Variables": HserPrintCRLF
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable51
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable51
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable51
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*9
	call	HSERPRINT359
;HserPrint "Variables": HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;dim _PWMTimerSelected as Byte
;Preg( "_PWMTimerSelected", _PWMTimerSelected, "Selected Timer")
;Macro Source: 240_ccppwm_discovery.gcb (257)
;HSerPrint "  "+xstr+": "
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable58
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	movlw	low StringTable52
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable52
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable52
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable59
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	_PWMTIMERSELECTED,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	_PWMTIMERSELECTED,SYSVALTEMP
	call	FN__HEXPICAS
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable60
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,_HEXPICAS
	rcall	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*4
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	_PWMTIMERSELECTED,SYSVALTEMP
	clrf	SYSVALTEMP_H,ACCESS
	rcall	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	10
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable62
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM3*1
	call	FN_PAD
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable61
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,PAD
	rcall	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	9
	movwf	SYSCHAR,ACCESS
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	rcall	SYSCOPYSTRINGPART
	movlw	low StringTable53
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable53
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable53
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*0
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Preg( "PWMDuty          ", PWMDuty, "[WORD] used in calculateDuty() in pwm.h ")
;Macro Source: 240_ccppwm_discovery.gcb (257)
;HSerPrint "  "+xstr+": "
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable58
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	movlw	low StringTable54
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable54
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable54
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable59
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	PWMDUTY,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	PWMDUTY,SYSVALTEMP
	call	FN__HEXPICAS
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable60
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,_HEXPICAS
	rcall	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*4
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	PWMDUTY,SYSVALTEMP
	clrf	SYSVALTEMP_H,ACCESS
	rcall	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	10
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable62
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM3*1
	call	FN_PAD
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable61
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,PAD
	rcall	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	9
	movwf	SYSCHAR,ACCESS
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	rcall	SYSCOPYSTRINGPART
	movlw	low StringTable55
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable55
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable55
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*0
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Preg( "PWMResolution    ", PWMResolution, "[WORD] used in calculateDuty() in pwm.h")
;Macro Source: 240_ccppwm_discovery.gcb (257)
;HSerPrint "  "+xstr+": "
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable58
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	movlw	low StringTable56
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable56
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable56
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable59
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	PWMRESOLUTION,BYTENUM
	call	FN_BYTETOBIN
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	PWMRESOLUTION,SYSVALTEMP
	call	FN__HEXPICAS
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable60
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,_HEXPICAS
	rcall	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*4
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movff	PWMRESOLUTION,SYSVALTEMP
	clrf	SYSVALTEMP_H,ACCESS
	rcall	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,ACCESS
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,ACCESS
	movlw	10
	movwf	SYSSTRLEN,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable62
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysSYSINSTRING3Handler_H,ACCESS
;Using SYSSTRINGPARAM3*1
	call	FN_PAD
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable61
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,PAD
	rcall	SYSCOPYSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*2
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	9
	movwf	SYSCHAR,ACCESS
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	rcall	SYSCOPYSTRINGPART
	movlw	low StringTable57
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable57
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable57
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM3
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM3*0
	call	HSERPRINT359
;HSerPrint ByteToBin(xreg): HSerPrint ", 0x"+Hex(xreg):HSerPrint ", "+ Pad(Str(xreg),10," "  ):HserPrint chr(9)+comment: HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	goto	HSERPRINTCRLF

;********************************************************************************

;Source: string.h (124)
FN_STR
;SysCharCount = 0
	clrf	SYSCHARCOUNT,ACCESS
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF14
;SysStrData = SysValTemp / 10000
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,ACCESS
	movwf	INDF0,ACCESS
;Goto SysValThousands
	bra	SYSVALTHOUSANDS
;End If
ENDIF14
;Thousands
;IF SysValTemp >= 1000 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF15
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,ACCESS
	movwf	INDF0,ACCESS
;Goto SysValHundreds
	bra	SYSVALHUNDREDS
;End If
ENDIF15
;Hundreds
;IF SysValTemp >= 100 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF16
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,ACCESS
	movwf	INDF0,ACCESS
;Goto SysValTens
	bra	SYSVALTENS
;End If
ENDIF16
;Tens
;IF SysValTemp >= 10 Then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF17
SYSVALTENS
;SysStrData = SysValTemp / 10
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,ACCESS
	movwf	INDF0,ACCESS
;End If
ENDIF17
;Ones
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysValTemp + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSVALTEMP,W,ACCESS
	movwf	INDF0,ACCESS
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;Str(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSSTR_0
	return

;********************************************************************************

;Source: system.h (4139)
SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysWordTempB, W
	movf	SYSWORDTEMPB, W,ACCESS
;cpfseq SysWordTempA
	cpfseq	SYSWORDTEMPA,ACCESS
;return
	return
;Test high, exit if false
;movf SysWordTempB_H, W
	movf	SYSWORDTEMPB_H, W,ACCESS
;cpfseq SysWordTempA_H
	cpfseq	SYSWORDTEMPA_H,ACCESS
;return
	return
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
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

;Source: system.h (4503)
SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfslt SysByteTempA
	cpfslt	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (4533)
SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W,ACCESS
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W,ACCESS
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W,ACCESS
;bnc SCLT16True
	bnc	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W,ACCESS
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
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

;Source: system.h (1768)
SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length for ChipFamily 16 support
;movff INDF0, SysCalcTempA
	movff	INDF0, SYSCALCTEMPA
;movff SysCalcTempA, INDF1
	movff	SYSCALCTEMPA, INDF1
;goto SysCopyStringCheck
	bra	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART
;movf INDF0, W
	movf	INDF0, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F,ACCESS
SYSCOPYSTRINGCHECK
;Exit if length = 0
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
SYSSTRINGCOPY
;Copy character
;movff PREINC0, PREINC1
	movff	PREINC0, PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringCopy
	bra	SYSSTRINGCOPY
	return

;********************************************************************************

;Source: system.h (3439)
SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F,ACCESS
;btfsc STATUS, Z
	btfsc	STATUS, Z,ACCESS
;return
	return
;Main calc routine
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP,ACCESS
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C,ACCESS
;rlf SysByteTempA, F
	rlcf	SYSBYTETEMPA, F,ACCESS
;rlf SysByteTempX, F
	rlcf	SYSBYTETEMPX, F,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F,ACCESS
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0,ACCESS
;btfsc STATUS, C
	btfsc	STATUS, C,ACCESS
;goto Div8NotNeg
	bra	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F,ACCESS
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv8Start
	bra	SYSDIV8START
	return

;********************************************************************************

;Source: system.h (3507)
SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movff	SYSWORDTEMPA,SYSDIVMULTA
	movff	SYSWORDTEMPA_H,SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movff	SYSWORDTEMPB,SYSDIVMULTB
	movff	SYSWORDTEMPB_H,SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX,ACCESS
	clrf	SYSDIVMULTX_H,ACCESS
;Avoid division by zero
;if SysDivMultB = 0 then
	movff	SYSDIVMULTB,SysWORDTempA
	movff	SYSDIVMULTB_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF35
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF35
;Main calc routine
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP,ACCESS
SYSDIV16START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysDivMultA Left
	rlcf	SYSDIVMULTA,F,ACCESS
	rlcf	SYSDIVMULTA_H,F,ACCESS
;Rotate SysDivMultX Left
	rlcf	SYSDIVMULTX,F,ACCESS
	rlcf	SYSDIVMULTX_H,F,ACCESS
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	subwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	subwfb	SYSDIVMULTX_H,F,ACCESS
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0,ACCESS
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF36
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF36
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv16Start
	bra	SYSDIV16START
;SysWordTempA = SysDivMultA
	movff	SYSDIVMULTA,SYSWORDTEMPA
	movff	SYSDIVMULTA_H,SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movff	SYSDIVMULTX,SYSWORDTEMPX
	movff	SYSDIVMULTX_H,SYSWORDTEMPX_H
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

;Source: system.h (1965)
SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;ChipFamily 16 support
;Get length
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movff	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movff	TABLAT,INDF1
;goto SysStringReadCheck
	bra	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;TBLRD*+
	tblrd*+
;movf TABLAT, W
	movf	TABLAT, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F,ACCESS
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
;Copy
SYSSTRINGREAD
;Copy char
;TBLRD*+
	tblrd*+
;movff TABLAT,PREINC1
	movff	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable1
	db	26,72,97,114,100,119,97,114,101,32,67,67,80,47,80,87,77,32,68,105,115,99,111,118
	db	101,114,121


StringTable2
	db	29,66,101,102,111,114,101,32,80,87,77,111,110,32,61,32,70,105,120,101,100,32,77,111
	db	100,101,32,80,87,77


StringTable3
	db	11,65,102,116,101,114,32,80,87,77,111,110


StringTable4
	db	73,73,102,32,110,111,32,70,105,120,101,100,32,77,111,100,101,32,80,87,77,32,115,105
	db	103,110,97,108,46,46,46,32,97,114,101,32,116,104,101,32,80,87,77,32,112,111,114,116
	db	115,32,115,101,116,32,116,111,32,79,85,84,63,32,67,111,114,114,101,99,116,32,80,80
	db	83,63


StringTable5
	db	69,32,111,114,44,32,116,104,101,32,114,101,103,105,115,116,101,114,115,32,105,110
	db	32,116,104,105,115,32,99,104,105,112,32,97,114,101,32,110,111,116,32,116,104,101
	db	32,115,97,109,101,32,105,115,32,111,110,32,112,114,101,118,105,111,117,115,32,99
	db	104,105,112,115


StringTable6
	db	93,32,32,32,32,32,99,111,109,112,97,114,101,32,67,67,80,67,79,78,67,97,99,104
	db	101,32,32,116,111,32,67,67,80,49,67,79,78,46,32,32,84,104,101,32,101,110,97,98
	db	108,101,32,98,105,116,32,110,101,101,100,115,32,116,111,32,115,101,116,32,102,111
	db	114,32,70,105,120,101,100,32,77,111,100,101,32,80,87,77,32,116,111,32,119,111
	db	114,107


StringTable7
	db	86,32,32,32,32,32,116,104,101,32,101,114,114,111,114,32,105,115,32,112,114,111
	db	98,97,108,98,121,32,97,32,114,101,110,97,109,101,100,32,98,105,116,32,105,110
	db	32,67,67,80,49,67,79,78,32,111,114,32,111,110,101,32,111,102,32,116,104,101,32,111
	db	116,104,101,114,32,107,101,121,32,114,101,103,105,115,116,101,114,115,47


StringTable8
	db	1,46


StringTable9
	db	6,80,87,77,79,102,102


StringTable10
	db	12,65,102,116,101,114,32,80,87,77,111,102,102


StringTable11
	db	35,70,105,120,101,100,32,109,111,100,101,32,80,87,77,32,115,105,103,110,97,108
	db	32,119,105,108,108,32,110,111,119,32,115,116,111,112


StringTable12
	db	24,73,115,115,117,101,32,96,72,80,87,77,32,49,44,32,80,87,77,95,70,82,69,81,44


StringTable13
	db	66,96,32,99,111,109,109,97,110,100,46,32,32,84,104,101,32,116,104,105,114,100
	db	32,112,97,114,97,109,101,116,101,114,32,114,97,110,103,101,32,105,115,32,48,32
	db	116,111,32,50,53,53,44,32,119,104,101,114,101,32,49,50,55,32,61,32,53,48,37


StringTable14
	db	0


StringTable15
	db	1,42


StringTable16
	db	24,65,102,116,101,114,32,96,72,80,87,77,32,49,44,32,80,87,77,95,70,82,69,81,44


StringTable17
	db	9,96,32,99,111,109,109,97,110,100


StringTable18
	db	97,32,65,115,32,72,80,87,77,40,41,32,117,115,101,100,32,115,97,109,101,32,70,114
	db	113,32,38,32,68,117,116,121,32,97,115,32,96,102,105,120,101,100,32,109,111,100
	db	101,32,80,87,77,96,44,32,116,104,101,110,44,32,67,67,80,49,67,79,78,32,115,104
	db	111,117,108,100,32,98,101,32,101,113,117,97,108,32,116,111,32,67,67,80,67,79,78,67
	db	97,99,104,101


StringTable19
	db	11,78,111,32,115,105,103,110,97,108,32,63


StringTable20
	db	85,32,32,49,46,32,72,97,115,32,67,104,105,112,70,97,109,105,108,121,80,87,77,67
	db	67,80,49,67,79,78,49,54,72,97,110,100,108,101,114,44,32,105,110,32,80,87,77,46
	db	104,44,32,98,101,101,110,32,117,112,100,97,116,101,100,32,102,111,114,32,116,104
	db	105,115,32,99,104,105,112,32,102,97,109,105,108,121,32,63


StringTable21
	db	105,32,32,32,32,32,73,102,32,116,104,101,32,115,112,101,99,105,102,105,99,32,99,104
	db	105,112,32,104,97,115,32,79,78,76,89,32,79,78,69,32,67,67,80,32,116,104,101,110
	db	32,116,104,101,32,115,101,99,116,105,111,110,32,67,104,105,112,70,97,109,105,108
	db	121,80,87,77,67,67,80,49,67,79,78,49,54,72,97,110,100,108,101,114,32,109,117,115
	db	116,32,98,101,32,117,112,100,97,116,101,100


StringTable22
	db	95,32,32,32,32,32,83,111,44,32,99,104,101,99,107,32,116,104,101,32,100,97,116,97
	db	115,104,101,101,116,32,102,111,114,32,67,67,80,49,32,111,110,108,121,46,46,32
	db	115,111,44,32,115,101,97,114,99,104,32,102,111,114,32,67,67,80,50,32,105,102,32,110
	db	111,116,32,102,111,117,110,100,32,116,104,101,110,32,111,110,108,121,32,111,110,101
	db	32,67,67,80


StringTable23
	db	95,32,32,50,46,32,73,115,32,67,67,80,84,77,82,83,48,32,99,111,114,114,101,99
	db	116,32,102,111,114,32,116,105,109,101,114,50,63,32,105,102,32,110,111,116,44,32
	db	105,115,32,80,87,77,84,105,109,101,114,86,97,114,105,97,110,116,32,105,110,32
	db	68,65,84,32,102,105,108,101,32,116,104,101,32,99,111,114,114,101,99,116,32,118
	db	97,108,117,101,32,63


StringTable24
	db	86,32,32,51,46,32,69,120,97,109,105,110,101,32,83,69,84,85,80,67,67,80,80,87,77,82
	db	69,71,73,83,84,69,82,83,32,115,101,99,116,105,111,110,32,105,110,32,112,119,109,46
	db	104,46,46,46,32,116,104,101,114,101,32,105,115,32,99,108,101,97,114,108,121,32
	db	97,32,108,105,98,114,97,114,121,32,105,115,115,117,101


StringTable25
	db	38,73,102,32,80,87,77,32,105,115,32,119,111,114,107,105,110,103,46,46,32,84,104,101
	db	110,44,32,97,108,108,32,105,115,32,103,111,111,100,33


StringTable26
	db	27,67,111,109,112,108,101,116,101,100,32,45,32,101,120,97,109,105,110,101,32,114
	db	101,115,117,108,116,115


StringTable27
	db	9,67,111,110,115,116,97,110,116,115


StringTable28
	db	17,80,87,77,95,70,82,69,81,58,32,32,32,32,32,32,32,32


StringTable29
	db	17,80,87,77,95,68,85,84,89,58,32,32,32,32,32,32,32,32


StringTable30
	db	17,85,83,69,95,72,80,87,77,67,67,80,49,58,32,32,32,32


StringTable31
	db	17,85,83,69,95,72,80,87,77,95,84,73,77,69,82,50,58,32


StringTable33
	db	9,82,101,103,105,115,116,101,114,115


StringTable34
	db	13,67,67,80,49,67,79,78,32,32,32,32,32,32


StringTable35
	db	20,67,67,80,32,67,111,110,116,114,111,108,32,82,101,103,105,115,116,101,114


StringTable36
	db	13,67,67,80,67,79,78,67,97,99,104,101,32,32


StringTable37
	db	32,67,97,99,104,101,100,32,114,101,103,105,115,116,101,114,32,117,115,101,100,32
	db	116,111,32,98,121,32,80,87,77,111,110


StringTable38
	db	13,84,50,80,82,32,32,32,32,32,32,32,32,32


StringTable39
	db	12,84,105,109,101,114,32,80,101,114,105,111,100


StringTable41
	db	13,84,50,67,79,78,32,32,32,32,32,32,32,32


StringTable42
	db	14,84,105,109,101,114,50,32,99,111,110,116,114,111,108


StringTable43
	db	13,84,50,67,76,75,67,79,78,32,32,32,32,32


StringTable44
	db	22,67,108,111,99,107,32,83,111,117,114,99,101,32,83,101,108,101,99,116,105,111
	db	110


StringTable45
	db	13,67,67,80,82,49,72,32,32,32,32,32,32,32


StringTable46
	db	12,68,117,116,121,32,99,121,99,108,101,32,72


StringTable47
	db	13,67,67,80,82,49,76,32,32,32,32,32,32,32


StringTable48
	db	12,68,117,116,121,32,99,121,99,108,101,32,76


StringTable49
	db	13,67,67,80,84,77,82,83,48,32,32,32,32,32


StringTable50
	db	15,84,105,109,101,114,32,83,101,108,101,99,116,105,111,110


StringTable51
	db	9,86,97,114,105,97,98,108,101,115


StringTable52
	db	17,95,80,87,77,84,105,109,101,114,83,101,108,101,99,116,101,100


StringTable53
	db	14,83,101,108,101,99,116,101,100,32,84,105,109,101,114


StringTable54
	db	17,80,87,77,68,117,116,121,32,32,32,32,32,32,32,32,32,32


StringTable55
	db	40,91,87,79,82,68,93,32,117,115,101,100,32,105,110,32,99,97,108,99,117,108,97,116
	db	101,68,117,116,121,40,41,32,105,110,32,112,119,109,46,104,32


StringTable56
	db	17,80,87,77,82,101,115,111,108,117,116,105,111,110,32,32,32,32


StringTable57
	db	39,91,87,79,82,68,93,32,117,115,101,100,32,105,110,32,99,97,108,99,117,108,97,116
	db	101,68,117,116,121,40,41,32,105,110,32,112,119,109,46,104


StringTable58
	db	2,32,32


StringTable59
	db	2,58,32


StringTable60
	db	4,44,32,48,120


StringTable61
	db	2,44,32


StringTable62
	db	1,32


StringTable121
	db	1,49


StringTable122
	db	1,48


;********************************************************************************

;Source: picas.h (7)
FN__HEXPICAS
;_HexPICAS(0) = 2
	movlw	2
	banksel	SYS_HEXPICAS_0
	movwf	SYS_HEXPICAS_0,BANKED
;dim SysStringTemp as byte
;Low nibble
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,ACCESS
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF1
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
ENDIF1
;_HexPICAS(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYS_HEXPICAS_2
	movwf	SYS_HEXPICAS_2,BANKED
;Get high nibble
;For SysStringTemp = 1 to 4
;Legacy method
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop1
	incf	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	rrcf	SYSVALTEMP,F,ACCESS
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,ACCESS
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF3
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
ENDIF3
;_HexPICAS(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYS_HEXPICAS_1
	movwf	SYS_HEXPICAS_1,BANKED
	banksel	0
	return

;********************************************************************************


 END
