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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\246_using_16bitpwm_operations.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : 
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\246_using_16bitpwm_operations.build\246_using_16bitpwm_operations.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F46Q35, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM 2 plus_board_2010\18f\246_using_16bitpwm_operations.gcb"
 SUBTITLE    "08-17-2026 12:46:58"
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
 CONFIG  MCLRE = INTMCLR
 CONFIG  FCMEN = ON
 CONFIG  CLKOUTEN = OFF
 CONFIG  RSTOSC = HFINTOSC_1MHZ
 CONFIG  FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
ADCVAL                           EQU    1293          ; 0x50D (SA)
ADCVAL_H                         EQU    1294          ; 0x50E (SA)
ADREADPORT                       EQU    1295          ; 0x50F (SA)
DELAYTEMP                        EQU    1280          ; 0x500 (SA)
DELAYTEMP2                       EQU    1281          ; 0x501 (SA)
L_CALIBRATE                      EQU    1296          ; 0x510 (SA)
L_CALIBRATE_H                    EQU    1297          ; 0x511 (SA)
L_FROMHIGH                       EQU    1298          ; 0x512 (SA)
L_FROMHIGH_H                     EQU    1299          ; 0x513 (SA)
L_FROMLOW                        EQU    1300          ; 0x514 (SA)
L_FROMLOW_H                      EQU    1301          ; 0x515 (SA)
L_MAP                            EQU    1302          ; 0x516 (SA)
L_MAP_H                          EQU    1303          ; 0x517 (SA)
L_SYSCALC                        EQU    1304          ; 0x518 (SA)
L_SYSCALCF                       EQU    1306          ; 0x51A (SA)
L_SYSCALCF_E                     EQU    1309          ; 0x51D (SA)
L_SYSCALCF_H                     EQU    1307          ; 0x51B (SA)
L_SYSCALCF_U                     EQU    1308          ; 0x51C (SA)
L_SYSCALC_H                      EQU    1305          ; 0x519 (SA)
L_TOHIGH                         EQU    1310          ; 0x51E (SA)
L_TOHIGH_H                       EQU    1311          ; 0x51F (SA)
L_TOLOW                          EQU    1312          ; 0x520 (SA)
L_TOLOW_H                        EQU    1313          ; 0x521 (SA)
OLDADCVAL                        EQU    1314          ; 0x522 (SA)
OLDADCVAL_H                      EQU    1315          ; 0x523 (SA)
READAD10                         EQU    1316          ; 0x524 (SA)
READAD10_H                       EQU    1317          ; 0x525 (SA)
SCALE                            EQU    1318          ; 0x526 (SA)
SCALE_H                          EQU    1319          ; 0x527 (SA)
SYSBYTETEMPX                     EQU    1280          ; 0x500 (SA)
SYSDIVLOOP                       EQU    1284          ; 0x504 (SA)
SYSLONGDIVMULTA                  EQU    1320          ; 0x528 (SA)
SYSLONGDIVMULTA_E                EQU    1323          ; 0x52B (SA)
SYSLONGDIVMULTA_H                EQU    1321          ; 0x529 (SA)
SYSLONGDIVMULTA_U                EQU    1322          ; 0x52A (SA)
SYSLONGDIVMULTB                  EQU    1324          ; 0x52C (SA)
SYSLONGDIVMULTB_E                EQU    1327          ; 0x52F (SA)
SYSLONGDIVMULTB_H                EQU    1325          ; 0x52D (SA)
SYSLONGDIVMULTB_U                EQU    1326          ; 0x52E (SA)
SYSLONGDIVMULTX                  EQU    1328          ; 0x530 (SA)
SYSLONGDIVMULTX_E                EQU    1331          ; 0x533 (SA)
SYSLONGDIVMULTX_H                EQU    1329          ; 0x531 (SA)
SYSLONGDIVMULTX_U                EQU    1330          ; 0x532 (SA)
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
SYSTEMP1                         EQU    1332          ; 0x534 (SA)
SYSTEMP1_E                       EQU    1335          ; 0x537 (SA)
SYSTEMP1_H                       EQU    1333          ; 0x535 (SA)
SYSTEMP1_U                       EQU    1334          ; 0x536 (SA)
SYSTEMP2                         EQU    1336          ; 0x538 (SA)
SYSTEMP2_H                       EQU    1337          ; 0x539 (SA)
SYSWAITTEMP10US                  EQU    1285          ; 0x505 (SA)
SYSWAITTEMPMS                    EQU    1282          ; 0x502 (SA)
SYSWAITTEMPMS_H                  EQU    1283          ; 0x503 (SA)
SYSWORDTEMPA                     EQU    1285          ; 0x505 (SA)
SYSWORDTEMPA_H                   EQU    1286          ; 0x506 (SA)
SYSWORDTEMPB                     EQU    1289          ; 0x509 (SA)
SYSWORDTEMPB_H                   EQU    1290          ; 0x50A (SA)

;********************************************************************************

;Alias variables
MYDUTY EQU 1131
MYDUTY_H EQU 1132
MYFREQUENCY EQU 1133
MYFREQUENCY_H EQU 1134
SYSREADAD10WORD EQU 1316
SYSREADAD10WORD_H EQU 1317
SYSSCALEWORD EQU 1318
SYSSCALEWORD_H EQU 1319

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
	rcall	INITSYS
	rcall	INITPPS

;Start_of_the_main_program
;
;This demonstration flashes an LED to show the use of CCP PWM operations
;
;Uses 16bit PWM operations
;
;
;************************************************************************
;@author  EvanV
;@licence GPL
;@version 1.00
;@date    17/08/2026
;
;----- Configuration
;Chip Settings.
;PIC PPS Tool version: 0.0.6.5
;Add this code segment to your GCBASIC source program
;
;Hardware
;-------------------PORTA----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ----------------SW----------ADC--
;----------------------------------------
;
;-------------------PORTB----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;IO:    ----------------LED-LED-LED-LED--
;----------------------------------------
;
;------------------PORTC-----------------
;Bit#:  -X---6---5---4---3---2---1---0---
;IO:    -^--TX---------------------------
;-----VDDIO2----------------------------- You must apply correct Voltage
;
;-------------------PORTE----------------
;Bit#:  -----------------3---------------
;IO:---------------------SW-------------- INTMCLR or EXTMCLR
;
;
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
;Dir     RSTBUTTON     In  // this is set automatically - and, you cannot set as an output
	bsf	TRISE,3,BANKED
;Dir     SWITCHIN      In
	bsf	TRISA,3,BANKED
;Dir     RSTBUTTON     In  // this is set automatically - and, you cannot set as an output
	bsf	TRISE,3,BANKED
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;PWMERS External Reset Disabled;
;PWM1ERS = 0x0;
	clrf	PWM1ERS,ACCESS
;PWMCLK FOSC;
;PWM1CLK = 0x2;
	movlw	2
	movwf	PWM1CLK,ACCESS
;PWMLDS Autoload disabled;
;PWM1LDS = 0x0;
	clrf	PWM1LDS,ACCESS
;PWMPRL 147;
;PWM1PRL = 0x93;
	movlw	147
	movwf	PWM1PRL,ACCESS
;PWMPRH 6;
;PWM1PRH = 0x6;
	movlw	6
	movwf	PWM1PRH,ACCESS
;PWMCPRE No prescale;
;PWM1CPRE = 0x0;
	clrf	PWM1CPRE,ACCESS
;PWMPIPOS No postscale;
;PWM1PIPOS = 0x0;
	clrf	PWM1PIPOS,ACCESS
;PWMS1P1IF PWM1 output match did not occur; PWMS1P2IF PWM2 output match did not occur;
;PWM1GIR = 0x0;
	clrf	PWM1GIR,ACCESS
;PWMS1P1IE disabled; PWMS1P2IE disabled;
;PWM1GIE = 0x0;
	clrf	PWM1GIE,ACCESS
;PWMPOL1 disabled; PWMPOL2 disabled; PWMPPEN disabled; PWMMODE Left aligned mode;
;PWM1S1CFG = 0x0;
	clrf	PWM1S1CFG,ACCESS
;PWMS1P1L 74;
;PWM1S1P1L = 0x4A;
	movlw	74
	movwf	PWM1S1P1L,ACCESS
;PWMS1P1H 3;
;PWM1S1P1H = 0x3;
	movlw	3
	movwf	PWM1S1P1H,ACCESS
;PWMS1P2L 148;
;PWM1S1P2L = 0x94;
	movlw	148
	movwf	PWM1S1P2L,ACCESS
;PWMS1P2H 6;
;PWM1S1P2H = 0x6;
	movlw	6
	movwf	PWM1S1P2H,ACCESS
;Clear PWM1_16BIT period interrupt flag
;PIR4.PWM1PIF = 0;
	bcf	PIR4,PWM1PIF,ACCESS
;Clear PWM1_16BIT interrupt flag
;PIR4.PWM1IF = 0;
	bcf	PIR4,PWM1IF,ACCESS
;Clear PWM1_16BIT slice 1, output 1 interrupt flag
;PWM1GIR.S1P1IF = 0;
	bcf	PWM1GIR,S1P1IF,ACCESS
;Clear PWM1_16BIT slice 1, output 2 interrupt flag
;PWM1GIR.S1P2IF = 0;
	bcf	PWM1GIR,S1P2IF,ACCESS
;PWM1_16BIT interrupt enable bit
;PIE4.PWM1IE = 0;
	bcf	PIE4,PWM1IE,ACCESS
;PWM1_16BIT period interrupt enable bit
;PIE4.PWM1PIE = 0;
	bcf	PIE4,PWM1PIE,ACCESS
;PWMEN enabled; PWMLD disabled; PWMERSPOL disabled; PWMERSNOW disabled;
;PWM1CON = 0x80;
	movlw	128
	movwf	PWM1CON,ACCESS
;Main program commences here.. everything before this is setup for the board.
;PWM16 is operational as specified above... 38kHz at 50% duty
;Dim myDuty as Word Alias PWM1S1P1H, PWM1S1P1L
;Dim myFrequency as Word Alias PWM1S1P2H, PWM1S1P2L
;Dim ADCVal, OldADCVal as Word
;Do
SysDoLoop_S1
;Use ADC to change Duty
;ADCVal = ReadAD10( ANA0 )
	clrf	ADREADPORT,ACCESS
	banksel	0
	rcall	FN_READAD108
	movff	SYSREADAD10WORD,ADCVAL
	movff	SYSREADAD10WORD_H,ADCVAL_H
;myDuty = Scale ( ADCVal, 0, 1023, 0, myFrequency)
	movff	ADCVAL,L_MAP
	movff	ADCVAL_H,L_MAP_H
	clrf	L_FROMLOW,ACCESS
	clrf	L_FROMLOW_H,ACCESS
	setf	L_FROMHIGH,ACCESS
	movlw	3
	movwf	L_FROMHIGH_H,ACCESS
	clrf	L_TOLOW,ACCESS
	clrf	L_TOLOW_H,ACCESS
	movff	MYFREQUENCY,L_TOHIGH
	movff	MYFREQUENCY_H,L_TOHIGH_H
	clrf	L_CALIBRATE,ACCESS
	clrf	L_CALIBRATE_H,ACCESS
	rcall	FN_SCALE79
	movff	SYSSCALEWORD,MYDUTY
	movff	SYSSCALEWORD_H,MYDUTY_H
;If OldADCVal <> ADCVal Then
	movff	OLDADCVAL,SysWORDTempA
	movff	OLDADCVAL_H,SysWORDTempA_H
	movff	ADCVAL,SysWORDTempB
	movff	ADCVAL_H,SysWORDTempB_H
	rcall	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF1
;Load the period and duty cycle register.bit on the next period event
;LD_PWM1CON = 1
	bsf	PWM1CON,LD_PWM1CON,ACCESS
;OldADCVal = ADCVal
	movff	ADCVAL,OLDADCVAL
	movff	ADCVAL_H,OLDADCVAL_H
;End If
ENDIF1
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

Delay_10US
D10US_START
	movlw	52
	movwf	DELAYTEMP,ACCESS
DelayUS0
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	decfsz	SysWaitTemp10US, F,ACCESS
	bra	D10US_START
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

;Source: 246_using_16bitpwm_operations.gcb (23)
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
;Module: PWM1_16BIT
;RB0PPS = 0x000E    // PWM11 > RB0
	movlw	14
	movwf	RB0PPS,BANKED
;RB1PPS = 0x000E    // PWM11 > RB1
	movlw	14
	movwf	RB1PPS,BANKED
;RB2PPS = 0x000E    // PWM11 > RB2
	movlw	14
	movwf	RB2PPS,BANKED
;RB3PPS = 0x000E    // PWM11 > RB3
	movlw	14
	movwf	RB3PPS,BANKED
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

;Overloaded signature: BYTE:, Source: a-d.h (2457)
FN_READAD108
;Always RIGHT justified
;SET ADFM ON
	banksel	ADCON0
	bsf	ADCON0,ADFM0,BANKED
;ADPCH = ADReadPort
	movff	ADREADPORT,ADPCH
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (637)
;Configure ANSELA/B/C/D @DebugADC_H
;Select Case ADReadPort
;Case 0: Set ANSELA.0 On
SysSelect1Case1
	movf	ADREADPORT,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;Case 0: Set ANSELA.0 On
	banksel	ANSELA
	bsf	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	bra	SysSelectEnd1
SysSelect1Case2
	decf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;Case 1: Set ANSELA.1 On
	banksel	ANSELA
	bsf	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	2
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;Case 2: Set ANSELA.2 On
	banksel	ANSELA
	bsf	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
;Case 3: Set ANSELA.3 On
	banksel	ANSELA
	bsf	ANSELA,3,BANKED
;Case 4: Set ANSELA.4 ON
	bra	SysSelectEnd1
SysSelect1Case5
	movlw	4
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case6
;Case 4: Set ANSELA.4 ON
	banksel	ANSELA
	bsf	ANSELA,4,BANKED
;Case 5: Set ANSELA.5 On
	bra	SysSelectEnd1
SysSelect1Case6
	movlw	5
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case7
;Case 5: Set ANSELA.5 On
	banksel	ANSELA
	bsf	ANSELA,5,BANKED
;Case 6: Set ANSELA.6 On
	bra	SysSelectEnd1
SysSelect1Case7
	movlw	6
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case8
;Case 6: Set ANSELA.6 On
	banksel	ANSELA
	bsf	ANSELA,6,BANKED
;Case 7: Set ANSELA.7 On
	bra	SysSelectEnd1
SysSelect1Case8
	movlw	7
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case9
;Case 7: Set ANSELA.7 On
	banksel	ANSELA
	bsf	ANSELA,7,BANKED
;Case 8: Set ANSELB.0 On
	bra	SysSelectEnd1
SysSelect1Case9
	movlw	8
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case10
;Case 8: Set ANSELB.0 On
	banksel	ANSELB
	bsf	ANSELB,0,BANKED
;Case 9: Set ANSELB.1 On
	bra	SysSelectEnd1
SysSelect1Case10
	movlw	9
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case11
;Case 9: Set ANSELB.1 On
	banksel	ANSELB
	bsf	ANSELB,1,BANKED
;Case 10: Set ANSELB.2 On
	bra	SysSelectEnd1
SysSelect1Case11
	movlw	10
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case12
;Case 10: Set ANSELB.2 On
	banksel	ANSELB
	bsf	ANSELB,2,BANKED
;Case 11: Set ANSELB.3 On
	bra	SysSelectEnd1
SysSelect1Case12
	movlw	11
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case13
;Case 11: Set ANSELB.3 On
	banksel	ANSELB
	bsf	ANSELB,3,BANKED
;Case 12: Set ANSELB.4 On
	bra	SysSelectEnd1
SysSelect1Case13
	movlw	12
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case14
;Case 12: Set ANSELB.4 On
	banksel	ANSELB
	bsf	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	bra	SysSelectEnd1
SysSelect1Case14
	movlw	13
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case15
;Case 13: Set ANSELB.5 On
	banksel	ANSELB
	bsf	ANSELB,5,BANKED
;Case 14: Set ANSELB.6 On
	bra	SysSelectEnd1
SysSelect1Case15
	movlw	14
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case16
;Case 14: Set ANSELB.6 On
	banksel	ANSELB
	bsf	ANSELB,6,BANKED
;Case 15: Set ANSELB.7 On
	bra	SysSelectEnd1
SysSelect1Case16
	movlw	15
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case17
;Case 15: Set ANSELB.7 On
	banksel	ANSELB
	bsf	ANSELB,7,BANKED
;Case 16: Set ANSELC.0 On
	bra	SysSelectEnd1
SysSelect1Case17
	movlw	16
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case18
;Case 16: Set ANSELC.0 On
	banksel	ANSELC
	bsf	ANSELC,0,BANKED
;Case 17: Set ANSELC.1 On
	bra	SysSelectEnd1
SysSelect1Case18
	movlw	17
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case19
;Case 17: Set ANSELC.1 On
	banksel	ANSELC
	bsf	ANSELC,1,BANKED
;Case 18: Set ANSELC.2 On
	bra	SysSelectEnd1
SysSelect1Case19
	movlw	18
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case20
;Case 18: Set ANSELC.2 On
	banksel	ANSELC
	bsf	ANSELC,2,BANKED
;Case 19: Set ANSELC.3 On
	bra	SysSelectEnd1
SysSelect1Case20
	movlw	19
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case21
;Case 19: Set ANSELC.3 On
	banksel	ANSELC
	bsf	ANSELC,3,BANKED
;Case 20: Set ANSELC.4 On
	bra	SysSelectEnd1
SysSelect1Case21
	movlw	20
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case22
;Case 20: Set ANSELC.4 On
	banksel	ANSELC
	bsf	ANSELC,4,BANKED
;Case 21: Set ANSELC.5 On
	bra	SysSelectEnd1
SysSelect1Case22
	movlw	21
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case23
;Case 21: Set ANSELC.5 On
	banksel	ANSELC
	bsf	ANSELC,5,BANKED
;Case 22: Set ANSELC.6 On
	bra	SysSelectEnd1
SysSelect1Case23
	movlw	22
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case24
;Case 22: Set ANSELC.6 On
	banksel	ANSELC
	bsf	ANSELC,6,BANKED
;Case 23: Set ANSELC.7 On
	bra	SysSelectEnd1
SysSelect1Case24
	movlw	23
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case25
;Case 23: Set ANSELC.7 On
	banksel	ANSELC
	bsf	ANSELC,7,BANKED
;Case 32: Set ANSELE.0 On
	bra	SysSelectEnd1
SysSelect1Case25
	movlw	32
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case26
;Case 32: Set ANSELE.0 On
	banksel	ANSELE
	bsf	ANSELE,0,BANKED
;Case 33: Set ANSELE.1 On
	bra	SysSelectEnd1
SysSelect1Case26
	movlw	33
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case27
;Case 33: Set ANSELE.1 On
	banksel	ANSELE
	bsf	ANSELE,1,BANKED
;Case 34: Set ANSELE.2 On
	bra	SysSelectEnd1
SysSelect1Case27
	movlw	34
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
;Case 34: Set ANSELE.2 On
	banksel	ANSELE
	bsf	ANSELE,2,BANKED
;End Select  '*** ANSEL Bits should now be set ***
SysSelectEnd1
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
	banksel	ADCON0
	bcf	ADCON0,ADCS,BANKED
;ADCLK = 1 ' default to FOSC/2
	movlw	1
	movwf	ADCLK,BANKED
;Conversion Clock Speed
;SET ADCS OFF  'ADCON0.4
	bcf	ADCON0,ADCS,BANKED
;ADCLK = 15    'FOSC/16
	movlw	15
	movwf	ADCLK,BANKED
;Configure AD clock defaults fpr older 18F that do not have ADCLK
;SET ADCS2 OFF
	bcf	ADCLK,ADCS2,BANKED
;SET ADCS1 OFF
	bcf	ADCLK,ADCS1,BANKED
;SET ADCS0 ON
	bsf	ADCLK,ADCS0,BANKED
;Result formatting
;if ADLeftadjust = 0 then
;Set ADCON0.2 ON
;Set ADFM ON
	bsf	ADCON0,ADFM0,BANKED
;Set ADFM0 ON
	bsf	ADCON0,ADFM0,BANKED
;Else
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	movff	ADREADPORT,ADPCH
;Enable AD Operations
;SET ADON ON
	bsf	ADCON0,ADON,BANKED
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US,ACCESS
	banksel	0
	rcall	Delay_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE,BANKED
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop1
	btfsc	ADCON0,GO_NOT_DONE,BANKED
	bra	SysWaitLoop1
;Switch off A/D
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
;Write output
;ReadAD10 = ADRESL
	movff	ADRESL,READAD10
	clrf	READAD10_H,ACCESS
;ReadAD10_H = ADRESH
	movff	ADRESH,READAD10_H
;Put A/D format back to normal
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:integer:, Source: stdbasic.h (266)
FN_SCALE79
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	movf	L_FROMLOW,W,ACCESS
	subwf	L_MAP,W,ACCESS
	movwf	SysTemp1,ACCESS
	movf	L_FROMLOW_H,W,ACCESS
	subwfb	L_MAP_H,W,ACCESS
	movwf	SysTemp1_H,ACCESS
	movf	L_TOLOW,W,ACCESS
	subwf	L_TOHIGH,W,ACCESS
	movwf	SysTemp2,ACCESS
	movf	L_TOLOW_H,W,ACCESS
	subwfb	L_TOHIGH_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	movff	SYSTEMP1,SysLONGTempA
	movff	SYSTEMP1_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	SYSTEMP2,SysLONGTempB
	movff	SYSTEMP2_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSMULTSUB32
	movff	SysLONGTempX,L_SYSCALCF
	movff	SysLONGTempX_H,L_SYSCALCF_H
	movff	SysLONGTempX_U,L_SYSCALCF_U
	movff	SysLONGTempX_E,L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	movf	L_FROMLOW,W,ACCESS
	subwf	L_FROMHIGH,W,ACCESS
	movwf	L_SYSCALC,ACCESS
	movf	L_FROMLOW_H,W,ACCESS
	subwfb	L_FROMHIGH_H,W,ACCESS
	movwf	L_SYSCALC_H,ACCESS
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
	movff	L_SYSCALCF,SysLONGTempA
	movff	L_SYSCALCF_H,SysLONGTempA_H
	movff	L_SYSCALCF_U,SysLONGTempA_U
	movff	L_SYSCALCF_E,SysLONGTempA_E
	movff	L_SYSCALC,SysLONGTempB
	movff	L_SYSCALC_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSDIVSUB32
	movff	SysLONGTempA,SysTemp1
	movff	SysLONGTempA_H,SysTemp1_H
	movff	SysLONGTempA_U,SysTemp1_U
	movff	SysLONGTempA_E,SysTemp1_E
	movf	L_TOLOW,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	movf	L_TOLOW_H,W,ACCESS
	addwfc	SysTemp1_H,W,ACCESS
	movwf	SysTemp2_H,ACCESS
	movf	L_CALIBRATE,W,ACCESS
	addwf	SysTemp2,W,ACCESS
	movwf	SCALE,ACCESS
	movf	L_CALIBRATE_H,W,ACCESS
	addwfc	SysTemp2_H,W,ACCESS
	movwf	SCALE_H,ACCESS
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
	bra	ENDIF5
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF5
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
	bra	ENDIF6
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
ENDIF6
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
	bra	ENDIF3
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
ENDIF3
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


 END
