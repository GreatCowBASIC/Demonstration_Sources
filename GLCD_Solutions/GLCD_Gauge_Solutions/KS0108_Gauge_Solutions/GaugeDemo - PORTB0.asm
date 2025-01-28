;Program compiled by GCBASIC (2025.01.21 (Windows 64 bit) : Build 1460) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2025-01-22 CRC248
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Gauge_Solutions\KS0108_Gauge_Solutions\GaugeDemo - PORTB0.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Gauge_Solutions\KS0108_Gauge_Solutions\GaugeDemo - PORTB0.asm
;   Float Capability : 255
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F47K42, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Gauge_Solutions\KS0108_Gauge_Solutions\GaugeDemo - PORTB0.gcb"
 SUBTITLE    "01-27-2025 12:38:52"
#include <P18F47K42.inc>
 CONFIG CP = OFF, LVP = OFF, WRTSAF = OFF, WRTD = OFF, WRTB = OFF, WDTE = OFF, XINST = OFF, MVECEN = OFF, MCLRE = EXTMCLR, FCMEN = ON, CLKOUTEN = OFF, RSTOSC = HFINTOSC_1MHZ, FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
BCDTODEC                         EQU      13          ; 0xD (SA)
CCOUNT                           EQU      16          ; 0x10 (SA)
CCOUNT_E                         EQU      19          ; 0x13 (SA)
CCOUNT_H                         EQU      17          ; 0x11 (SA)
CCOUNT_U                         EQU      18          ; 0x12 (SA)
CHARCODE                         EQU      20          ; 0x14 (SA)
CHARCOL                          EQU      21          ; 0x15 (SA)
CHARCOLS                         EQU      23          ; 0x17 (SA)
CHARCOL_H                        EQU      22          ; 0x16 (SA)
CHARLOCX                         EQU      24          ; 0x18 (SA)
CHARLOCX_H                       EQU      25          ; 0x19 (SA)
CHARLOCY                         EQU      26          ; 0x1A (SA)
CHARLOCY_H                       EQU      27          ; 0x1B (SA)
CHARROW                          EQU      28          ; 0x1C (SA)
CHARROWS                         EQU      30          ; 0x1E (SA)
CHARROW_H                        EQU      29          ; 0x1D (SA)
COL                              EQU      31          ; 0x1F (SA)
COMPORT                          EQU      32          ; 0x20 (SA)
CURRCHARCOL                      EQU      33          ; 0x21 (SA)
CURRCHARROW                      EQU      34          ; 0x22 (SA)
CURRCHARVAL                      EQU      35          ; 0x23 (SA)
CURRCOL                          EQU      36          ; 0x24 (SA)
CURRPAGE                         EQU      37          ; 0x25 (SA)
DATE                             EQU      38          ; 0x26 (SA)
DECTOBCD                         EQU      39          ; 0x27 (SA)
DELAYTEMP                        EQU       0          ; 0x0 (SA)
DELAYTEMP2                       EQU       1          ; 0x1 (SA)
DOW                              EQU      40          ; 0x28 (SA)
DS_A_P                           EQU      41          ; 0x29 (SA)
DS_DATE                          EQU      42          ; 0x2A (SA)
DS_DOW                           EQU      43          ; 0x2B (SA)
DS_HOUR                          EQU      44          ; 0x2C (SA)
DS_MONTH                         EQU      45          ; 0x2D (SA)
DS_SEC                           EQU      46          ; 0x2E (SA)
DS_STATUS                        EQU      47          ; 0x2F (SA)
DS_VALUE                         EQU      48          ; 0x30 (SA)
DS_YEAR                          EQU      49          ; 0x31 (SA)
GLCDBACKGROUND                   EQU      50          ; 0x32 (SA)
GLCDBACKGROUND_H                 EQU      51          ; 0x33 (SA)
GLCDBITNO                        EQU      52          ; 0x34 (SA)
GLCDCHANGE                       EQU      53          ; 0x35 (SA)
GLCDCOLOUR                       EQU      54          ; 0x36 (SA)
GLCDCOLOUR_H                     EQU      55          ; 0x37 (SA)
GLCDDATATEMP                     EQU      56          ; 0x38 (SA)
GLCDDATATEMPCACHE                EQU      57          ; 0x39 (SA)
GLCDFNTDEFAULT                   EQU      58          ; 0x3A (SA)
GLCDFNTDEFAULTHEIGHT             EQU      59          ; 0x3B (SA)
GLCDFNTDEFAULTSIZE               EQU      60          ; 0x3C (SA)
GLCDFONTWIDTH                    EQU      61          ; 0x3D (SA)
GLCDFOREGROUND                   EQU      62          ; 0x3E (SA)
GLCDFOREGROUND_H                 EQU      63          ; 0x3F (SA)
GLCDPRINTLEN                     EQU      64          ; 0x40 (SA)
GLCDPRINTLOC                     EQU      65          ; 0x41 (SA)
GLCDPRINTLOC_H                   EQU      66          ; 0x42 (SA)
GLCDPRINT_STRING_COUNTER         EQU      67          ; 0x43 (SA)
GLCDREADBYTE_KS0108              EQU      68          ; 0x44 (SA)
GLCDX                            EQU      69          ; 0x45 (SA)
GLCDY                            EQU      70          ; 0x46 (SA)
GLCD_COUNT                       EQU      71          ; 0x47 (SA)
GLCD_YORDINATE                   EQU      72          ; 0x48 (SA)
GLCD_YORDINATE_H                 EQU      73          ; 0x49 (SA)
I2CACK                           EQU      74          ; 0x4A (SA)
I2CACKPOLLSTATE                  EQU      75          ; 0x4B (SA)
I2CBYTE                          EQU      76          ; 0x4C (SA)
I2CMATCH                         EQU      77          ; 0x4D (SA)
I2CSTATE                         EQU      78          ; 0x4E (SA)
LASTUPDATEGLCDEVENT              EQU      79          ; 0x4F (SA)
LASTUPDATEGLCDEVENT_E            EQU      82          ; 0x52 (SA)
LASTUPDATEGLCDEVENT_H            EQU      80          ; 0x50 (SA)
LASTUPDATEGLCDEVENT_U            EQU      81          ; 0x51 (SA)
LCDBYTE                          EQU      83          ; 0x53 (SA)
LCDVALUE                         EQU      84          ; 0x54 (SA)
LCDVALUE_E                       EQU      87          ; 0x57 (SA)
LCDVALUE_H                       EQU      85          ; 0x55 (SA)
LCDVALUE_U                       EQU      86          ; 0x56 (SA)
LINECOLOUR                       EQU      88          ; 0x58 (SA)
LINECOLOUR_H                     EQU      89          ; 0x59 (SA)
MODE                             EQU      90          ; 0x5A (SA)
MONTH                            EQU      91          ; 0x5B (SA)
PRINTLEN                         EQU      92          ; 0x5C (SA)
PRINTLOCX                        EQU      93          ; 0x5D (SA)
PRINTLOCX_H                      EQU      94          ; 0x5E (SA)
PRINTLOCY                        EQU      95          ; 0x5F (SA)
PRINTLOCY_H                      EQU      96          ; 0x60
ROW                              EQU      97          ; 0x61
SERDATA                          EQU      98          ; 0x62
STRINGPOINTER                    EQU      99          ; 0x63
SYSBITVAR0                       EQU     100          ; 0x64
SYSBITVAR3                       EQU     101          ; 0x65
SYSBSR                           EQU     102          ; 0x66
SYSBYTETEMPA                     EQU       5          ; 0x5 (SA)
SYSBYTETEMPB                     EQU       9          ; 0x9 (SA)
SYSBYTETEMPX                     EQU       0          ; 0x0 (SA)
SYSCALCTEMPA                     EQU       5          ; 0x5 (SA)
SYSCALCTEMPA_E                   EQU       8          ; 0x8 (SA)
SYSCALCTEMPA_H                   EQU       6          ; 0x6 (SA)
SYSCALCTEMPA_U                   EQU       7          ; 0x7 (SA)
SYSDIVLOOP                       EQU       4          ; 0x4 (SA)
SYSINTSTATESAVE0                 EQU     103          ; 0x67
SYSLCDPRINTDATAHANDLER           EQU     104          ; 0x68
SYSLCDPRINTDATAHANDLER_H         EQU     105          ; 0x69
SYSLONGDIVMULTA                  EQU     106          ; 0x6A
SYSLONGDIVMULTA_E                EQU     109          ; 0x6D
SYSLONGDIVMULTA_H                EQU     107          ; 0x6B
SYSLONGDIVMULTA_U                EQU     108          ; 0x6C
SYSLONGDIVMULTB                  EQU     110          ; 0x6E
SYSLONGDIVMULTB_E                EQU     113          ; 0x71
SYSLONGDIVMULTB_H                EQU     111          ; 0x6F
SYSLONGDIVMULTB_U                EQU     112          ; 0x70
SYSLONGDIVMULTX                  EQU     114          ; 0x72
SYSLONGDIVMULTX_E                EQU     117          ; 0x75
SYSLONGDIVMULTX_H                EQU     115          ; 0x73
SYSLONGDIVMULTX_U                EQU     116          ; 0x74
SYSLONGTEMPA                     EQU       5          ; 0x5 (SA)
SYSLONGTEMPA_E                   EQU       8          ; 0x8 (SA)
SYSLONGTEMPA_H                   EQU       6          ; 0x6 (SA)
SYSLONGTEMPA_U                   EQU       7          ; 0x7 (SA)
SYSLONGTEMPB                     EQU       9          ; 0x9 (SA)
SYSLONGTEMPB_E                   EQU      12          ; 0xC (SA)
SYSLONGTEMPB_H                   EQU      10          ; 0xA (SA)
SYSLONGTEMPB_U                   EQU      11          ; 0xB (SA)
SYSLONGTEMPX                     EQU       0          ; 0x0 (SA)
SYSLONGTEMPX_E                   EQU       3          ; 0x3 (SA)
SYSLONGTEMPX_H                   EQU       1          ; 0x1 (SA)
SYSLONGTEMPX_U                   EQU       2          ; 0x2 (SA)
SYSPRINTBUFFER                   EQU    8163          ; 0x1FE3
SYSPRINTBUFFLEN                  EQU     118          ; 0x76
SYSPRINTDATAHANDLER              EQU     119          ; 0x77
SYSPRINTDATAHANDLER_H            EQU     120          ; 0x78
SYSPRINTTEMP                     EQU     121          ; 0x79
SYSREPEATTEMP1                   EQU     122          ; 0x7A
SYSREPEATTEMP2                   EQU     123          ; 0x7B
SYSREPEATTEMP3                   EQU     124          ; 0x7C
SYSSTATUS                        EQU      15          ; 0xF (SA)
SYSSTRINGA                       EQU       7          ; 0x7 (SA)
SYSSTRINGA_H                     EQU       8          ; 0x8 (SA)
SYSSTRINGLENGTH                  EQU       6          ; 0x6 (SA)
SYSSTRINGPARAM1                  EQU    8174          ; 0x1FEE
SYSTEMP1                         EQU     125          ; 0x7D
SYSTEMP1_E                       EQU     128          ; 0x80
SYSTEMP1_H                       EQU     126          ; 0x7E
SYSTEMP1_U                       EQU     127          ; 0x7F
SYSTEMP2                         EQU     129          ; 0x81
SYSTEMP2_H                       EQU     130          ; 0x82
SYSW                             EQU      14          ; 0xE (SA)
SYSWAITTEMPMS                    EQU       2          ; 0x2 (SA)
SYSWAITTEMPMS_H                  EQU       3          ; 0x3 (SA)
SYSWAITTEMPS                     EQU       4          ; 0x4 (SA)
SYSWAITTEMPUS                    EQU       5          ; 0x5 (SA)
SYSWAITTEMPUS_H                  EQU       6          ; 0x6 (SA)
SYSWORDTEMPA                     EQU       5          ; 0x5 (SA)
SYSWORDTEMPA_H                   EQU       6          ; 0x6 (SA)
SYSWORDTEMPB                     EQU       9          ; 0x9 (SA)
SYSWORDTEMPB_H                   EQU      10          ; 0xA (SA)
UPDATEGLCDEVENT                  EQU     131          ; 0x83
UPDATEGLCDEVENT_E                EQU     134          ; 0x86
UPDATEGLCDEVENT_H                EQU     132          ; 0x84
UPDATEGLCDEVENT_U                EQU     133          ; 0x85
VA                               EQU     135          ; 0x87
YEAR                             EQU     136          ; 0x88

;********************************************************************************

;Alias variables
AFSR0 EQU 16361
AFSR0_H EQU 16362
SYSBCDTODECBYTE EQU 13
SYSDECTOBCDBYTE EQU 39

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	goto	INTERRUPT

;********************************************************************************

;Program_memory_page: 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITPPS
	call	INITUSART
	call	INITI2C
	call	INITGLCD_KS0108
;Enable interrupts
	bsf	INTCON0,GIE,ACCESS
	bsf	SYSINTSTATESAVE0,0,BANKED

;Start_of_the_main_program
;''A demonstration program for GCBASIC.
;''--------------------------------------------------------------------------------------------------------------------------------
;''@author  EvanV
;''@licence GPL
;''@version 1.0a
;''@date    24.01.2025
;''***********************************************************
;PIC PPS Tool version: 0.0.6.5
;Add this code segment to your GCBASIC source program
;This is the Default value, not required.
;GLCD Settings
;! Evan's settings
;D0 to pin 7 on LCD
;D1 to pin 8 on LCD
;D2 to pin 9 on LCD
;D3 to pin 10 on LCD
;D4 to pin 11 on LCD
;D5 to pin 12 on LCD
;D6 to pin 13 on LCD
;D7 to pin 14 on LCD
;*************************** MAIN ***********************************************
;I2C settings
;#define I2C_DISABLE_INTERRUPTS
;----- Variables
;dim hour, min, sec, am_pm as byte
;dim date, month, year, DOW as byte
;dim xpos, ypos as byte            ' Position variables for GLCD
;dim mode as byte
;----- Tables
;----- Main Program
;GLCDPrint(0, 0, "DS1307 Inspection" )
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*17
	call	GLCDPRINT65
;Check DS1307 is working
;I2CStart                          ; is device present?
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	208
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CStop
	call	I2CSTOP
;if I2CSendState = False  then     ; is device present?
	movf	I2CACKPOLLSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF1
;GLCDPrint(0, 16, "No DS1307" )
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	16
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*9
	call	GLCDPRINT65
;GLCDPrint(0, 24, "Stopped" )
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	24
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*7
	call	GLCDPRINT65
;end if
ENDIF1
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;GLCDCLS
	call	GLCDCLS_KS0108
;Initialize clock
;DS1307_ReadDate(DOW, date, month, year)   ;get initial date
	rcall	DS1307_READDATE
	movff	DS_DOW,DOW
	movff	DS_DATE,DATE
	movff	DS_MONTH,MONTH
	movff	DS_YEAR,YEAR
;DS1307_ReadHourMode(mode)                 ;and the current mode
	rcall	DS1307_READHOURMODE
	movff	DS_A_P,MODE
;DS1307_SetHourMode(mode)                  ;update hour mode from RTC
	movff	MODE,DS_A_P
	rcall	DS1307_SETHOURMODE
;DS1307_EnableOscillator( true )           ;and, ensure the clock is running
	setf	DS_VALUE,ACCESS
	rcall	DS1307_ENABLE
;DS3231_SetSQW 0                           ;and, turn on at 1 Hz, see documentation for permitted values
	clrf	DS_VALUE,ACCESS
	rcall	DS3231_SETSQW
;DS3231_EnableSQW
	rcall	DS3231_ENABLESQW
;INTON
	btfss	SYSINTSTATESAVE0,0,BANKED
	bcf	INTCON0,GIE,ACCESS
	btfsc	SYSINTSTATESAVE0,0,BANKED
	bsf	INTCON0,GIE,ACCESS
;Variable to count events
;Dim intevent as Bit
;intevent = FALSE
	bcf	SYSBITVAR0,0,BANKED
;Dim updateglcdevent, lastupdateglcdevent as Long
;updateglcdevent = 0
	clrf	UPDATEGLCDEVENT,BANKED
	clrf	UPDATEGLCDEVENT_H,BANKED
	clrf	UPDATEGLCDEVENT_U,BANKED
	clrf	UPDATEGLCDEVENT_E,BANKED
;lastupdateglcdevent = updateglcdevent - 1
	movlw	1
	subwf	UPDATEGLCDEVENT,W,BANKED
	movwf	LASTUPDATEGLCDEVENT,ACCESS
	movlw	0
	subwfb	UPDATEGLCDEVENT_H,W,BANKED
	movwf	LASTUPDATEGLCDEVENT_H,ACCESS
	movlw	0
	subwfb	UPDATEGLCDEVENT_U,W,BANKED
	movwf	LASTUPDATEGLCDEVENT_U,ACCESS
	movlw	0
	subwfb	UPDATEGLCDEVENT_E,W,BANKED
	movwf	LASTUPDATEGLCDEVENT_E,ACCESS
;Dim ccount as Long
;ccount = 0
	clrf	CCOUNT,ACCESS
	clrf	CCOUNT_H,ACCESS
	clrf	CCOUNT_U,ACCESS
	clrf	CCOUNT_E,ACCESS
;A constant
;Dir INTPORT IN
	bsf	TRISB,0,ACCESS
;GLCDPrint 0,0, "Loaded"
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*6
	call	GLCDPRINT65
;HserPrint "Loaded"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*6
	call	HSERPRINT483
;Sets the external interrupt to trigger when the pin's level transitions from high to low (negative edge trigger).
;IOCBP = 0x03
	movlw	3
	banksel	IOCBP
	movwf	IOCBP,BANKED
;On Interrupt PORTCHANGE Call ISRHandler
	banksel	PIE0
	bsf	PIE0,IOCIE,BANKED
;Do
SysDoLoop_S1
;If intevent = TRUE Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,0,BANKED
	bra	ENDIF2
;ccount++
	incf	CCOUNT,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	CCOUNT_H,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	CCOUNT_U,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	CCOUNT_E,F,ACCESS
;intevent = FALSE
	bcf	SYSBITVAR0,0,BANKED
;GLCDPrint 0,8, "bit 0 : "
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	8
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*8
	call	GLCDPRINT65
;GLCDPrint 40, 8, ccount
	movlw	40
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	8
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	movff	CCOUNT,LCDVALUE
	movff	CCOUNT_H,LCDVALUE_H
	movff	CCOUNT_U,LCDVALUE_U
	movff	CCOUNT_E,LCDVALUE_E
	call	GLCDPRINT68
;End If
ENDIF2
;If lastupdateglcdevent <> updateglcdevent Then
	movff	LASTUPDATEGLCDEVENT,SysLONGTempA
	movff	LASTUPDATEGLCDEVENT_H,SysLONGTempA_H
	movff	LASTUPDATEGLCDEVENT_U,SysLONGTempA_U
	movff	LASTUPDATEGLCDEVENT_E,SysLONGTempA_E
	movff	UPDATEGLCDEVENT,SysLONGTempB
	movff	UPDATEGLCDEVENT_H,SysLONGTempB_H
	movff	UPDATEGLCDEVENT_U,SysLONGTempB_U
	movff	UPDATEGLCDEVENT_E,SysLONGTempB_E
	call	SYSCOMPEQUAL32
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF3
;If updateglcdevent.1 = 1 Then
	btfss	UPDATEGLCDEVENT,1,BANKED
	bra	ELSE4_1
;GLCDPrint 0,32, "bit 1 : "
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	32
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable6
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*8
	call	GLCDPRINT65
;GLCDPrint 40, 32, ccount
	movlw	40
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	32
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	movff	CCOUNT,LCDVALUE
	movff	CCOUNT_H,LCDVALUE_H
	movff	CCOUNT_U,LCDVALUE_U
	movff	CCOUNT_E,LCDVALUE_E
	call	GLCDPRINT68
;Else If updateglcdevent.3 = 1 Then
	bra	ENDIF4
ELSE4_1
	btfss	UPDATEGLCDEVENT,3,BANKED
	bra	ELSE4_2
;GLCDPrint 0,16, "bit 3 : "
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	16
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable7
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*8
	call	GLCDPRINT65
;GLCDPrint 40, 16, ccount
	movlw	40
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	16
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	movff	CCOUNT,LCDVALUE
	movff	CCOUNT_H,LCDVALUE_H
	movff	CCOUNT_U,LCDVALUE_U
	movff	CCOUNT_E,LCDVALUE_E
	call	GLCDPRINT68
;Else If updateglcdevent.4 = 1 Then
	bra	ENDIF4
ELSE4_2
	btfss	UPDATEGLCDEVENT,4,BANKED
	bra	ENDIF4
;GLCDPrint 0,24, "bit 4 : "
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	24
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable8
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*8
	call	GLCDPRINT65
;GLCDPrint 40, 24, ccount
	movlw	40
	movwf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	24
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,BANKED
	movff	CCOUNT,LCDVALUE
	movff	CCOUNT_H,LCDVALUE_H
	movff	CCOUNT_U,LCDVALUE_U
	movff	CCOUNT_E,LCDVALUE_E
	call	GLCDPRINT68
;End If
ENDIF4
;lastupdateglcdevent = updateglcdevent
	movff	UPDATEGLCDEVENT,LASTUPDATEGLCDEVENT
	movff	UPDATEGLCDEVENT_H,LASTUPDATEGLCDEVENT_H
	movff	UPDATEGLCDEVENT_U,LASTUPDATEGLCDEVENT_U
	movff	UPDATEGLCDEVENT_E,LASTUPDATEGLCDEVENT_E
;End If
ENDIF3
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Overloaded signature: BYTE:, Source: ds1307.h (81)
FN_BCDTODEC4
;Convert binary coded decimal to pure decimal
;BcdToDec=( va /16)*10+ va %16
	movff	VA,SysBYTETempA
	movlw	16
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempA,SysTemp1
	movf	SysTemp1,W,BANKED
	mullw	10
	movffl	PRODL,SysTemp2
	movff	VA,SysBYTETempA
	movlw	16
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movf	SysBYTETempX,W,ACCESS
	addwf	SysTemp2,W,BANKED
	movwf	BCDTODEC,ACCESS
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: ds1307.h (74)
FN_DECTOBCD3
;Convert pure decimal number to binary coded decimal
;DecToBcd=( va /10)*16+ va %10
	movff	VA,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempA,SysTemp1
	movf	SysTemp1,W,BANKED
	mullw	16
	movffl	PRODL,SysTemp2
	movff	VA,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movf	SysBYTETempX,W,ACCESS
	addwf	SysTemp2,W,BANKED
	movwf	DECTOBCD,ACCESS
	return

;********************************************************************************

;Source: ds1307.h (88)
DS1307_ENABLE
;Enables clock if DS_Value = TRUE, disables if DS_Value = FALSE
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	208
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CSend(0)                     ;indicate register 0
	clrf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrRead)
	movlw	209
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CReceive(DS_Sec, NACK)       ;get the current seconds
	clrf	I2CACK,ACCESS
	call	I2CRECEIVE
	movff	I2CBYTE,DS_SEC
;if DS_Value then
	movf	DS_VALUE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	bra	ELSE7_1
;set DS_Sec.7 off              ;CH bit = 0 enables
	bcf	DS_SEC,7,ACCESS
;else
	bra	ENDIF7
ELSE7_1
;set DS_Sec.7 on               ;CH bit = 1 disables
	bsf	DS_SEC,7,ACCESS
;end if
ENDIF7
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	208
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CSend(0)                     ;indicate register 0
	clrf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CSend(DS_Sec)                ;now send updated value
	movff	DS_SEC,I2CBYTE
	call	I2CSEND
;I2CStop
	goto	I2CSTOP

;********************************************************************************

;Source: ds1307.h (416)
DS1307_READDATE
;Get date only: day of week, date, month, year
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	208
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CSend(3)                      ;begin with address 3
	movlw	3
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CReStart
	call	I2CRESTART
;I2CSend(DS_AddrRead)
	movlw	209
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CReceive(DS_DOW, ACK)              ;get day of week
	setf	I2CACK,ACCESS
	call	I2CRECEIVE
	movff	I2CBYTE,DS_DOW
;DS_Date = BcdToDec(DS_DOW)
	movff	DS_DOW,VA
	rcall	FN_BCDTODEC4
	movff	SYSBCDTODECBYTE,DS_DATE
;I2CReceive(DS_Date, ACK)             ;get date
	setf	I2CACK,ACCESS
	call	I2CRECEIVE
	movff	I2CBYTE,DS_DATE
;DS_Date = BcdToDec(DS_Date)
	movff	DS_DATE,VA
	rcall	FN_BCDTODEC4
	movff	SYSBCDTODECBYTE,DS_DATE
;I2CReceive(DS_Month, ACK)            ;get month
	setf	I2CACK,ACCESS
	call	I2CRECEIVE
	movff	I2CBYTE,DS_MONTH
;DS_Month = BcdToDec(DS_Month)
	movff	DS_MONTH,VA
	rcall	FN_BCDTODEC4
	movff	SYSBCDTODECBYTE,DS_MONTH
;I2CReceive(DS_Year, NACK)       ;get year
	clrf	I2CACK,ACCESS
	call	I2CRECEIVE
	movff	I2CBYTE,DS_YEAR
;DS_Year = BcdToDec(DS_Year)
	movff	DS_YEAR,VA
	rcall	FN_BCDTODEC4
	movff	SYSBCDTODECBYTE,DS_YEAR
;I2CStop
	goto	I2CSTOP

;********************************************************************************

;Source: ds1307.h (541)
DS1307_READHOURMODE
;Return the current hour mode, 12 or 24
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	208
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CSend(2)                      ;go to address 2
	movlw	2
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrRead)
	movlw	209
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CReceive(DS_A_P, NACK)        ;get entire hour byte
	clrf	I2CACK,ACCESS
	call	I2CRECEIVE
	movff	I2CBYTE,DS_A_P
;I2CStop
	call	I2CSTOP
;if DS_A_P.6 then                ;read the mode bit
	btfss	DS_A_P,6,ACCESS
	bra	ELSE13_1
;DS_A_P = 12                   ;and translate
	movlw	12
	movwf	DS_A_P,ACCESS
;else
	bra	ENDIF13
ELSE13_1
;DS_A_P = 24
	movlw	24
	movwf	DS_A_P,ACCESS
;end if
ENDIF13
	return

;********************************************************************************

;Source: ds1307.h (459)
DS1307_SETHOURMODE
;Set hour mode. 12 = 12-hour, all else = 24-hour
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	208
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CSend(2)                      ;located in address 2
	movlw	2
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrRead)
	movlw	209
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CReceive(DS_Hour, NACK)       ;get current hours and mode
	clrf	I2CACK,ACCESS
	call	I2CRECEIVE
	movff	I2CBYTE,DS_HOUR
;if DS_A_P = 12 then             ;change to 12-hour mode
	movlw	12
	subwf	DS_A_P,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE8_1
;if DS_Hour.6 = 0 then            ;only if in 24-hour mode
	btfsc	DS_HOUR,6,ACCESS
	bra	ENDIF9
;DS_Hour = BcdToDec(DS_Hour) ;read current hour
	movff	DS_HOUR,VA
	rcall	FN_BCDTODEC4
	movff	SYSBCDTODECBYTE,DS_HOUR
;if DS_Hour > 12 then        ;it's a p.m.
	movf	DS_HOUR,W,ACCESS
	sublw	12
	btfsc	STATUS, C,ACCESS
	bra	ELSE11_1
;DS_Hour -= 12             ;reduce to 12-hour mode
	movlw	12
	subwf	DS_HOUR,F,ACCESS
;DS_Hour = DecToBcd(DS_Hour) ;convert to BCD
	movff	DS_HOUR,VA
	rcall	FN_DECTOBCD3
	movff	SYSDECTOBCDBYTE,DS_HOUR
;set DS_Hour.5 on          ;indicate p.m.
	bsf	DS_HOUR,5,ACCESS
;else
	bra	ENDIF11
ELSE11_1
;DS_Hour = DecToBcd(DS_Hour)
	movff	DS_HOUR,VA
	rcall	FN_DECTOBCD3
	movff	SYSDECTOBCDBYTE,DS_HOUR
;end if
ENDIF11
;set DS_Hour.6 on            ;indicate 12-hour mode now
	bsf	DS_HOUR,6,ACCESS
;end if
ENDIF9
;else                            ;change to 24-hour mode
	bra	ENDIF8
ELSE8_1
;if DS_Hour.6 then             ;only if in 12-hour mode
	btfss	DS_HOUR,6,ACCESS
	bra	ENDIF10
;DS_A_P = DS_Hour & 32       ;save am/pm flag
	movlw	32
	andwf	DS_HOUR,W,ACCESS
	movwf	DS_A_P,ACCESS
;DS_Hour = BcdToDec(DS_Hour & 31)  ;strip it out
	movlw	31
	andwf	DS_HOUR,W,ACCESS
	movwf	VA,BANKED
	rcall	FN_BCDTODEC4
	movff	SYSBCDTODECBYTE,DS_HOUR
;if DS_A_P then              ;p.m. time
	movf	DS_A_P,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	bra	ENDIF12
;DS_Hour += 12             ;convert to 24-hour format
	movlw	12
	addwf	DS_HOUR,F,ACCESS
;end if
ENDIF12
;DS_Hour = DecToBcd(DS_Hour) ;top 2 bits are 0
	movff	DS_HOUR,VA
	rcall	FN_DECTOBCD3
	movff	SYSDECTOBCDBYTE,DS_HOUR
;end if
ENDIF10
;end if
ENDIF8
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	208
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CSend(2)
	movlw	2
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CSend(DS_Hour)                ;send hours and flag back again
	movff	DS_HOUR,I2CBYTE
	call	I2CSEND
;I2CStop
	goto	I2CSTOP

;********************************************************************************

;Source: ds3231.h (863)
DS3231_ENABLESQW
;Set square wave active
;read the current value of the register
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	208
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CSend(DS3231_ControlRegister)              ;go to address
	movlw	14
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrRead)
	movlw	209
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CReceive(DS_Status, NACK)        ;get entire byte
	clrf	I2CACK,ACCESS
	call	I2CRECEIVE
	movff	I2CBYTE,DS_STATUS
;I2CStop
	call	I2CSTOP
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	208
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CSend(DS3231_ControlRegister)                      ;location is address
	movlw	14
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;DS_Status.6 = 1                              ;When set to logic 1 with INTCN = 0 and VCC < VPF, this bit enables the square wave.
	bsf	DS_STATUS,6,ACCESS
;DS_Status.2 = 0                              ;disable interrupt. When the INTCN bit is set to logic 0, a square wave is output on the INT/SQW pin
	bcf	DS_STATUS,2,ACCESS
;DS_Status.1 = 0                              ;disable Alarm2 interrupt
	bcf	DS_STATUS,1,ACCESS
;DS_Status.0 = 0                              ;disable Alarm1 interrupt
	bcf	DS_STATUS,0,ACCESS
;I2CSend(DS_Status)
	movff	DS_STATUS,I2CBYTE
	call	I2CSEND
;I2CStop
	goto	I2CSTOP

;********************************************************************************

;Source: ds3231.h (771)
DS3231_SETSQW
;Set square wave output pin mode
;read the current value of the register
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	208
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CSend(DS3231_ControlRegister)              ;go to address
	movlw	14
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrRead)
	movlw	209
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CReceive(DS_Status, NACK)        ;get entire byte
	clrf	I2CACK,ACCESS
	rcall	I2CRECEIVE
	movff	I2CBYTE,DS_STATUS
;I2CStop
	call	I2CSTOP
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	208
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;I2CSend(DS3231_ControlRegister)                      ;location is address
	movlw	14
	movwf	I2CBYTE,ACCESS
	call	I2CSEND
;select case DS_Value
;case 0                       ;0 = 1hz
SysSelect1Case1
	movf	DS_VALUE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;set DS_Status.3 off
	bcf	DS_STATUS,3,ACCESS
;set DS_Status.4 off
	bcf	DS_STATUS,4,ACCESS
;case 1                       ;1 = 1.024kHz
	bra	SysSelectEnd1
SysSelect1Case2
	decf	DS_VALUE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;set DS_Status.3 on
	bsf	DS_STATUS,3,ACCESS
;set DS_Status.4 off
	bcf	DS_STATUS,4,ACCESS
;case 2                       ;2 = 4.096kHz
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	2
	subwf	DS_VALUE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;set DS_Status.3 off
	bcf	DS_STATUS,3,ACCESS
;set DS_Status.4 on
	bsf	DS_STATUS,4,ACCESS
;case 3                      ;3 = 8.192kHz
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	DS_VALUE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
;set DS_Status.3 on
	bsf	DS_STATUS,3,ACCESS
;set DS_Status.4 on
	bsf	DS_STATUS,4,ACCESS
;case else                    ;anything else defaults to 8.192kHz
	bra	SysSelectEnd1
SysSelect1Case5
;set DS_Status.3 on
	bsf	DS_STATUS,3,ACCESS
;set DS_Status.4 on
	bsf	DS_STATUS,4,ACCESS
;end select
SysSelectEnd1
;I2CSend(DS_Status)
	movff	DS_STATUS,I2CBYTE
	rcall	I2CSEND
;I2CStop
	goto	I2CSTOP

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

GLCDCHARCOL3
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL3
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL3
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL3
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL3
	db	112,0,16,12,10,136,34,56,32,8,32,16,16,128,128,64,4,0,0,0,40,72,70,108,0,0,0,40
	db	16,0,16,0,64,124,0,132,130,48,78,120,6,108,12,0,0,16,40,0,4,100,248,254,124,254
	db	254,254,124,254,0,64,254,254,254,254,124,254,124,254,76,2,126,62,126,198,14,194
	db	0,4,0,8,128,0,64,254,112,112,112,16,16,254,0,64,254,0,248,248,112,248,16,248
	db	144,16,120,56,120,136,24,136,0,0,0,32,120

;********************************************************************************

GLCDCHARCOL4
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL4
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL4
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL4
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL4
	db	112,254,56,10,6,204,102,124,112,4,64,16,56,136,162,112,28,0,0,14,254,84,38,146
	db	10,56,130,16,16,160,16,192,32,162,132,194,130,40,138,148,2,146,146,108,172,40
	db	40,130,2,146,36,146,130,130,146,18,130,16,130,128,16,128,4,8,130,18,130,18,146,2
	db	128,64,128,40,16,162,254,8,130,4,128,2,168,144,136,136,168,252,168,16,144,128
	db	32,130,8,16,136,40,40,16,168,124,128,64,128,80,160,200,16,0,130,16,68

;********************************************************************************

GLCDCHARCOL5
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL5
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL5
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL5
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL5
	db	112,124,124,0,0,238,238,124,168,254,254,84,84,148,148,124,124,0,158,0,40,254,16,170
	db	6,68,68,124,124,96,16,192,16,146,254,162,138,36,138,146,226,146,146,108,108,68
	db	40,68,162,242,34,146,130,130,146,18,146,16,254,130,40,128,24,16,130,18,162,50
	db	146,254,128,128,112,16,224,146,130,16,130,2,128,4,168,136,136,136,168,18,168,8
	db	250,136,80,254,240,8,136,40,40,8,168,144,128,128,96,32,160,168,108,254,108,16
	db	66

;********************************************************************************

GLCDCHARCOL6
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL6
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL6
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL6
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL6
	db	112,56,254,12,10,204,102,124,32,4,64,56,16,162,136,112,28,0,0,14,254,84,200,68
	db	0,130,56,16,16,0,16,0,8,138,128,146,150,254,138,146,18,146,82,0,0,130,40,40,18,130
	db	36,146,130,68,146,18,146,16,130,126,68,128,4,32,130,18,66,82,146,2,128,64,128,40
	db	16,138,130,32,254,4,128,8,168,136,136,144,168,2,168,8,128,122,136,128,8,8,136,40
	db	48,8,168,128,64,64,128,80,160,152,130,0,16,32,68

;********************************************************************************

GLCDCHARCOL7
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEGLCDCHARCOL7
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEGLCDCHARCOL7
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEGLCDCHARCOL7
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEGLCDCHARCOL7
	db	112,16,0,10,6,136,34,56,62,8,32,16,16,128,128,64,4,0,0,0,40,36,196,160,0,0,0,40
	db	16,0,16,0,4,124,0,140,98,32,114,96,14,108,60,0,0,0,40,16,12,124,248,108,68,56
	db	130,2,244,254,0,2,130,128,254,254,124,12,188,140,100,2,126,62,126,198,14,134,0,64
	db	0,8,128,0,240,112,64,254,48,4,120,240,0,0,0,0,240,240,112,16,248,16,64,64,248,56
	db	120,136,120,136,0,0,0,16,120

;********************************************************************************

;Source: glcd_ks0108.h (144)
GLCDCLS_KS0108
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,ACCESS
	clrf	GLCD_YORDINATE_H,ACCESS
;Set GLCD_CS1 Off
	bcf	LATB,4,ACCESS
;Set GLCD_CS2 On
	bsf	LATB,5,ACCESS
;for GLCD_Count = 1 to 2
;Legacy method
	clrf	GLCD_COUNT,ACCESS
SysForLoop7
	incf	GLCD_COUNT,F,ACCESS
;For CurrPage = 0 to 7
;Legacy method
	setf	CURRPAGE,ACCESS
SysForLoop8
	incf	CURRPAGE,F,ACCESS
;Set page
;Set GLCD_RS Off
	bcf	LATB,3,ACCESS
;GLCDWriteByte b'10111000' Or CurrPage
	movlw	184
	iorwf	CURRPAGE,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	GLCDWRITEBYTE_KS0108
;Clear columns
;For CurrCol = 0 to 63
;Legacy method
	setf	CURRCOL,ACCESS
SysForLoop9
	incf	CURRCOL,F,ACCESS
;Select column
;Set GLCD_RS Off
	bcf	LATB,3,ACCESS
;GLCDWriteByte 64 Or CurrCol
	movlw	64
	iorwf	CURRCOL,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	GLCDWRITEBYTE_KS0108
;Clear
;Set GLCD_RS On
	bsf	LATB,3,ACCESS
;GLCDWriteByte 0
	clrf	LCDBYTE,ACCESS
	rcall	GLCDWRITEBYTE_KS0108
;Next
	movlw	63
	subwf	CURRCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
;Next
	movlw	7
	subwf	CURRPAGE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop8
SysForLoopEnd8
;Set GLCD_CS1 On
	bsf	LATB,4,ACCESS
;Set GLCD_CS2 Off
	bcf	LATB,5,ACCESS
;next
	movlw	2
	subwf	GLCD_COUNT,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
;Set GLCD_CS1 On
	bsf	LATB,4,ACCESS
;Set GLCD_CS2 On
	bsf	LATB,5,ACCESS
	return

;********************************************************************************

;Source: glcd.h (1577)
GLCDDRAWCHAR
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;invert colors if required
;if LineColour <> GLCDForeground  then
	movff	LINECOLOUR,SysWORDTempA
	movff	LINECOLOUR_H,SysWORDTempA_H
	movff	GLCDFOREGROUND,SysWORDTempB
	movff	GLCDFOREGROUND_H,SysWORDTempB_H
	rcall	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF19
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 0
	clrf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;end if
ENDIF19
;dim CharCol, CharRow as word
;CharCode -= 15
	movlw	15
	subwf	CHARCODE,F,ACCESS
;CharCol=0
	clrf	CHARCOL,ACCESS
	clrf	CHARCOL_H,ACCESS
;if CharCode>=178 and CharCode<=202 then
	movff	CHARCODE,SysBYTETempA
	movlw	178
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	202
	movwf	SysBYTETempA,ACCESS
	rcall	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF20
;CharLocY=CharLocY-1
	movlw	1
	subwf	CHARLOCY,F,ACCESS
	movlw	0
	subwfb	CHARLOCY_H,F,ACCESS
;end if
ENDIF20
;For CurrCharCol = 1 to 5
;Legacy method
	clrf	CURRCHARCOL,ACCESS
SysForLoop3
	incf	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect2Case1
	decf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL3
	movwf	CURRCHARVAL,ACCESS
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL4
	movwf	CURRCHARVAL,ACCESS
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	bra	SysSelectEnd2
SysSelect2Case3
	movlw	3
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case4
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL5
	movwf	CURRCHARVAL,ACCESS
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	bra	SysSelectEnd2
SysSelect2Case4
	movlw	4
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case5
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL6
	movwf	CURRCHARVAL,ACCESS
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	bra	SysSelectEnd2
SysSelect2Case5
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL7
	movwf	CURRCHARVAL,ACCESS
;End Select
SysSelectEnd2
;CharRow=0
	clrf	CHARROW,ACCESS
	clrf	CHARROW_H,ACCESS
;For CurrCharRow = 1 to 8
;Legacy method
	clrf	CURRCHARROW,ACCESS
SysForLoop4
	incf	CURRCHARROW,F,ACCESS
;CharColS=0
	clrf	CHARCOLS,ACCESS
;For Col=1 to GLCDfntDefaultsize
;Legacy method
	clrf	COL,ACCESS
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
	incf	COL,F,ACCESS
;CharRowS=0
	clrf	CHARROWS,ACCESS
;For Row=1 to GLCDfntDefaultsize
;Legacy method
	clrf	ROW,BANKED
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
	incf	ROW,F,BANKED
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0,ACCESS
	bra	ELSE23_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, LineColour
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	rcall	PSET_KS0108
;Else
	bra	ENDIF23
ELSE23_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, GLCDBackground
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	rcall	PSET_KS0108
;End if
ENDIF23
;Put out a white intercharacter pixel/space
;PSet [word]CharLocX + ( GLCDFontWidth * GLCDfntDefaultsize) , [word]CharLocY + CharRow + CharRowS , GLCDBackground
	movf	GLCDFONTWIDTH,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movffl	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	rcall	PSET_KS0108
;CharRowS +=1
	incf	CHARROWS,F,ACCESS
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	subwf	ROW,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;CharColS +=1
	incf	CHARCOLS,F,ACCESS
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	subwf	COL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;Rotate CurrCharVal Right
	rrcf	CURRCHARVAL,F,ACCESS
;CharRow +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	addwf	CHARROW,F,ACCESS
	movlw	0
	addwfc	CHARROW_H,F,ACCESS
;Next
	movlw	8
	subwf	CURRCHARROW,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;CharCol +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	addwf	CHARCOL,F,ACCESS
	movlw	0
	addwfc	CHARCOL_H,F,ACCESS
;Next
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;Restore
;GLCDBackground = 0
	clrf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 1
	movlw	1
	movwf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (1244)
GLCDPRINT65
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	movffl	SysLCDPRINTDATAHandler,AFSR0
	movffl	SysLCDPRINTDATAHandler_H,AFSR0_H
	movffl	INDF0,GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	movf	GLCDPRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
;If GLCDPrintLen = 0 Then Exit Sub
	return
;If GLCDPrintLen = 0 Then Exit Sub
;GLCDPrintLoc = PrintLocX
	movff	PRINTLOCX,GLCDPRINTLOC
	movff	PRINTLOCX_H,GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
;Legacy method
	clrf	GLCDPRINT_STRING_COUNTER,ACCESS
	movlw	1
	subwf	GLCDPRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
	incf	GLCDPRINT_STRING_COUNTER,F,ACCESS
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movff	PRINTLOCY,CHARLOCY
	movff	PRINTLOCY_H,CHARLOCY_H
	movf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	addwf	SysLCDPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,CHARCODE
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	GLCDDRAWCHAR
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1481)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	movf	GLCDFONTWIDTH,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movffl	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	addwf	GLCDPRINTLOC,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	GLCDPRINTLOC_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	GLCDPRINTLOC,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	GLCDPRINTLOC_H,ACCESS
;Next
	movf	GLCDPRINTLEN,W,ACCESS
	subwf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:LONG:, Source: glcd.h (1356)
GLCDPRINT68
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	clrf	SYSPRINTBUFFLEN,BANKED
;Do
SysDoLoop_S2
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	incf	SYSPRINTBUFFLEN,F,BANKED
;SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
	lfsr	0,SYSPRINTBUFFER
	movf	SYSPRINTBUFFLEN,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	LCDVALUE,SysLONGTempA
	movff	LCDVALUE_H,SysLONGTempA_H
	movff	LCDVALUE_U,SysLONGTempA_U
	movff	LCDVALUE_E,SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSDIVSUB32
	movffl	SysLONGTempX,INDF0
;LCDValue = SysCalcTempA
	movff	SYSCALCTEMPA,LCDVALUE
	movff	SYSCALCTEMPA_H,LCDVALUE_H
	movff	SYSCALCTEMPA_U,LCDVALUE_U
	movff	SYSCALCTEMPA_E,LCDVALUE_E
;Loop While LCDValue <> 0
	movff	lcdvalue,SysLONGTempA
	movff	lcdvalue_H,SysLONGTempA_H
	movff	lcdvalue_U,SysLONGTempA_U
	movff	lcdvalue_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSCOMPEQUAL32
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
	bra	SysDoLoop_S2
SysDoLoop_E2
;Display
;GLCDPrintLoc = PrintLocX
	movff	PRINTLOCX,GLCDPRINTLOC
	movff	PRINTLOCX_H,GLCDPRINTLOC_H
;For GLCDPrint_String_Counter = SysPrintBuffLen To 1 Step -1
;Legacy method
	incf	SYSPRINTBUFFLEN,W,BANKED
	movwf	GLCDPRINT_STRING_COUNTER,ACCESS
	movlw	1
	subwf	SYSPRINTBUFFLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
SysForLoop2
	decf	GLCDPRINT_STRING_COUNTER,F,ACCESS
;GLCDDrawChar GLCDPrintLoc, PrintLocY, SysPrintBuffer(GLCDPrint_String_Counter) + 48
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movff	PRINTLOCY,CHARLOCY
	movff	PRINTLOCY_H,CHARLOCY_H
	lfsr	0,SYSPRINTBUFFER
	movf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	INDF0,W,ACCESS
	movwf	CHARCODE,ACCESS
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	GLCDDRAWCHAR
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1481)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	movf	GLCDFONTWIDTH,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movffl	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	addwf	GLCDPRINTLOC,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	GLCDPRINTLOC_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	GLCDPRINTLOC,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	GLCDPRINTLOC_H,ACCESS
;Next
	movf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	sublw	1
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
	return

;********************************************************************************

;Source: glcd_ks0108.h (374)
FN_GLCDREADBYTE_KS0108
;Set data pin directions
;Dir GLCD_DB7 In
	bsf	TRISD,7,ACCESS
;Dir GLCD_DB6 In
	bsf	TRISD,6,ACCESS
;Dir GLCD_DB5 In
	bsf	TRISD,5,ACCESS
;Dir GLCD_DB4 In
	bsf	TRISD,4,ACCESS
;Dir GLCD_DB3 In
	bsf	TRISD,3,ACCESS
;Dir GLCD_DB2 In
	bsf	TRISD,2,ACCESS
;Dir GLCD_DB1 In
	bsf	TRISD,1,ACCESS
;Dir GLCD_DB0 In
	bsf	TRISD,0,ACCESS
;Set LCD data direction
;Set GLCD_RW On
	bsf	LATC,7,ACCESS
;Read
;Set GLCD_ENABLE On
	bsf	LATB,2,ACCESS
;Wait KS0108WriteDelay us
	movlw	53
	movwf	DELAYTEMP,ACCESS
DelayUS4
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS4
;Get input data
;corrected 7/05/2014
;GLCDReadByte.7 = GLCD_DB7
	bcf	GLCDREADBYTE_KS0108,7,ACCESS
	btfsc	PORTD,7,ACCESS
	bsf	GLCDREADBYTE_KS0108,7,ACCESS
;GLCDReadByte.6 = GLCD_DB6
	bcf	GLCDREADBYTE_KS0108,6,ACCESS
	btfsc	PORTD,6,ACCESS
	bsf	GLCDREADBYTE_KS0108,6,ACCESS
;GLCDReadByte.5 = GLCD_DB5
	bcf	GLCDREADBYTE_KS0108,5,ACCESS
	btfsc	PORTD,5,ACCESS
	bsf	GLCDREADBYTE_KS0108,5,ACCESS
;GLCDReadByte.4 = GLCD_DB4
	bcf	GLCDREADBYTE_KS0108,4,ACCESS
	btfsc	PORTD,4,ACCESS
	bsf	GLCDREADBYTE_KS0108,4,ACCESS
;GLCDReadByte.3 = GLCD_DB3
	bcf	GLCDREADBYTE_KS0108,3,ACCESS
	btfsc	PORTD,3,ACCESS
	bsf	GLCDREADBYTE_KS0108,3,ACCESS
;GLCDReadByte.2 = GLCD_DB2
	bcf	GLCDREADBYTE_KS0108,2,ACCESS
	btfsc	PORTD,2,ACCESS
	bsf	GLCDREADBYTE_KS0108,2,ACCESS
;GLCDReadByte.1 = GLCD_DB1
	bcf	GLCDREADBYTE_KS0108,1,ACCESS
	btfsc	PORTD,1,ACCESS
	bsf	GLCDREADBYTE_KS0108,1,ACCESS
;GLCDReadByte.0 = GLCD_DB0
	bcf	GLCDREADBYTE_KS0108,0,ACCESS
	btfsc	PORTD,0,ACCESS
	bsf	GLCDREADBYTE_KS0108,0,ACCESS
;Set GLCD_ENABLE Off
	bcf	LATB,2,ACCESS
;Wait KS0108WriteDelay us
	movlw	53
	movwf	DELAYTEMP,ACCESS
DelayUS5
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS5
	return

;********************************************************************************

;Source: glcd_ks0108.h (303)
GLCDWRITEBYTE_KS0108
;Dim GLCDSaveRS As Bit
;Dim GLCDSaveCS2 As Bit
;Wait until LCD is available
;GLCDSaveRS = GLCD_RS
	bcf	SYSBITVAR0,1,BANKED
	btfsc	PORTB,3,ACCESS
	bsf	SYSBITVAR0,1,BANKED
;GLCDSaveCS2 = GLCD_CS2
	bcf	SYSBITVAR0,2,BANKED
	btfsc	PORTB,5,ACCESS
	bsf	SYSBITVAR0,2,BANKED
;If GLCD_CS1 = 0 Then
	btfss	PORTB,4,ACCESS
;GLCD_CS2 = 1
	bsf	LATB,5,ACCESS
;End If
;Set GLCD_RS Off
	bcf	LATB,3,ACCESS
;Wait Until GLCDReadByte.7 = Off
SysWaitLoop1
	rcall	FN_GLCDREADBYTE_KS0108
	btfsc	GLCDREADBYTE_KS0108,7,ACCESS
	bra	SysWaitLoop1
;GLCD_RS = GLCDSaveRS
	bcf	LATB,3,ACCESS
	btfsc	SYSBITVAR0,1,BANKED
	bsf	LATB,3,ACCESS
;GLCD_CS2 = GLCDSaveCS2
	bcf	LATB,5,ACCESS
	btfsc	SYSBITVAR0,2,BANKED
	bsf	LATB,5,ACCESS
;Set LCD data direction
;Set GLCD_RW Off
	bcf	LATC,7,ACCESS
;DIR GLCD_DATAPORT OUT
	clrf	TRISD,ACCESS
;GLCD_DATAPORT = LCDByte
	movffl	LCDBYTE,PORTD
;Write
;Wait KS0108WriteDelay us
	movlw	53
	movwf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
;Set GLCD_ENABLE On
	bsf	LATB,2,ACCESS
;Wait KS0108ClockDelay us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
;Set GLCD_ENABLE Off
	bcf	LATB,2,ACCESS
;Wait KS0108WriteDelay us
	movlw	53
	movwf	DELAYTEMP,ACCESS
DelayUS3
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS3
	return

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (3339)
HSERPRINT483
;PrintLen = PrintData(0)
	movffl	SysPRINTDATAHandler,AFSR0
	movffl	SysPRINTDATAHandler_H,AFSR0_H
	movffl	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF51
;Write Data
;for SysPrintTemp = 1 to PrintLen
;Legacy method
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd10
SysForLoop10
	incf	SYSPRINTTEMP,F,BANKED
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,SERDATA
	rcall	HSERSEND471
;next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop10
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

;Overloaded signature: BYTE:, Source: usart.h (1910)
HSERSEND470
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop2
	banksel	PIR3
	btfss	PIR3,U1TXIF,BANKED
	bra	SysWaitLoop2
;TXREG = SerData
	movffl	SERDATA,U1TXB
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (2028)
HSERSEND471
HSERSENDUSART1HANDLER
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop7
	banksel	PIR3
	btfss	PIR3,U1TXIF,BANKED
	bra	SysWaitLoop7
;TXREG = SerData
	movffl	SERDATA,U1TXB
	banksel	0
	return

;********************************************************************************

;Source: i2c.h (525)
I2CRECEIVE
;I2C_CLOCK_LOW                 'SCL begins low
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
;I2C_DATA_HIGH                 'this makes SDA an input now
	bsf	TRISC,4,ACCESS
;I2CByte = 0                   'received byte built up here
	clrf	I2CBYTE,ACCESS
;repeat 8                      'fetch the 8 bits
	movlw	8
	movwf	SysRepeatTemp3,BANKED
SysRepeatLoop3
;wait I2C_END_DELAY          'let port lines settle down
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS19
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS19
;I2C_CLOCK_HIGH              'send a clock pulse
	bsf	TRISC,3,ACCESS
;wait while I2C_CLOCK = OFF  'permit clock stretching
SysWaitLoop5
	btfss	PORTC,3,ACCESS
	bra	SysWaitLoop5
;rotate I2CByte left         'make room for next bit
	rlcf	I2CBYTE,F,ACCESS
;set I2CByte.0 OFF           'assume it's a zero
	bcf	I2CBYTE,0,ACCESS
;if I2C_DATA = ON then       'else, it's a one
	btfsc	PORTC,4,ACCESS
;set I2CByte.0 ON
	bsf	I2CBYTE,0,ACCESS
;end if
;wait I2C_CLOCK_DELAY        'clock high this amount of time
	movlw	160
	movwf	DELAYTEMP,ACCESS
DelayUS20
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS20
;I2C_CLOCK_LOW               'SCL now low
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
;wait I2C_END_DELAY          'time before next clock pulse
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS21
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS21
;end repeat
	decfsz	SysRepeatTemp3,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;if I2CAck then
	movf	I2CACK,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	bra	ELSE60_1
;I2C_DATA_LOW                'SDA=0 means ACK
	bcf	TRISC,4,ACCESS
	bcf	LATC,4,ACCESS
;else
	bra	ENDIF60
ELSE60_1
;I2C_DATA_HIGH               'SDA=1 means NAK
	bsf	TRISC,4,ACCESS
;end if
ENDIF60
;wait I2C_END_DELAY            'either way, let it settle
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS22
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS22
;I2C_CLOCK_HIGH                'then clock it out
	bsf	TRISC,3,ACCESS
;wait while I2C_CLOCK = OFF    'permit clock stretching
SysWaitLoop6
	btfss	PORTC,3,ACCESS
	bra	SysWaitLoop6
;wait I2C_CLOCK_DELAY          'keep high long enough
	movlw	160
	movwf	DELAYTEMP,ACCESS
DelayUS23
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS23
;I2C_CLOCK_LOW                 'then SCL goes low again
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
;wait I2C_END_DELAY            'and settles before proceeding
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS24
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS24
	return

;********************************************************************************

;Source: i2c.h (324)
I2CRESTART
;I2CStart
	bra	I2CSTART

;********************************************************************************

;Source: i2c.h (364)
I2CSEND
;I2C_CLOCK_LOW                 'begin with SCL=0
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
;wait I2C_END_DELAY            'let port settle
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS11
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS11
;repeat 8                      '8 data bits
	movlw	8
	movwf	SysRepeatTemp2,BANKED
SysRepeatLoop2
;if I2CByte.7 = ON then      'put most significant bit on SDA line
	btfss	I2CBYTE,7,ACCESS
	bra	ELSE57_1
;I2C_DATA_HIGH
	bsf	TRISC,4,ACCESS
;else
	bra	ENDIF57
ELSE57_1
;I2C_DATA_LOW
	bcf	TRISC,4,ACCESS
	bcf	LATC,4,ACCESS
;end if
ENDIF57
;wait I2C_END_DELAY            'let port settle
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS12
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS12
;rotate I2CByte left         'shift in bit for the next time
	rlcf	I2CBYTE,F,ACCESS
;I2C_CLOCK_HIGH              'now clock it in
	bsf	TRISC,3,ACCESS
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop3
	btfss	PORTC,3,ACCESS
	bra	SysWaitLoop3
;wait I2C_CLOCK_DELAY        'clock pulse width given here
	movlw	160
	movwf	DELAYTEMP,ACCESS
DelayUS13
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS13
;I2C_CLOCK_LOW               'done clocking that bit
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
;wait I2C_END_DELAY          'time between clock pulses
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS14
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS14
;end repeat                    'then do next bit
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;wait I2C_BIT_DELAY            'pad timing just a little
	movlw	106
	movwf	DELAYTEMP,ACCESS
DelayUS15
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS15
	nop
;I2C_DATA_HIGH                 'idle SDA to let Slave respond
	bsf	TRISC,4,ACCESS
;wait I2C_END_DELAY            'let SDA port line settle
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS16
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS16
;I2C_CLOCK_HIGH                'clock for the ACK/NAK bit
	bsf	TRISC,3,ACCESS
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop4
	btfss	PORTC,3,ACCESS
	bra	SysWaitLoop4
;restored 'I2CSendState' variable for backwards compatibility
;if I2C_DATA then              'read 9th bit in from Slave
	btfss	PORTC,4,ACCESS
	bra	ELSE58_1
;I2CAck = FALSE              'return a NAK to the program
	clrf	I2CACK,ACCESS
;I2CSendState =  FALSE        'state of target device with respect. Retained for backwards compatibility
	clrf	I2CACKPOLLSTATE,ACCESS
;else
	bra	ENDIF58
ELSE58_1
;I2CAck = TRUE               'else, return an ACK to the program
	setf	I2CACK,ACCESS
;I2CSendState =  TRUE        'state of target device with respect. Retained for backwards compatibility
	setf	I2CACKPOLLSTATE,ACCESS
;end if
ENDIF58
;I2C_CLOCK_LOW                 'may be more bytes to clock out
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
;wait I2C_END_DELAY            'so keep idling both
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS17
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS17
;I2C_DATA_LOW                  'SCL and SDA low
	bcf	TRISC,4,ACCESS
	bcf	LATC,4,ACCESS
;wait I2C_BIT_DELAY            'wait the usual bit length
	movlw	106
	movwf	DELAYTEMP,ACCESS
DelayUS18
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS18
	nop
	return

;********************************************************************************

;Source: i2c.h (226)
I2CSTART
;Dim I2CINTSTATESAVE as BIT
;I2CINTSTATESAVE = GIE
	bcf	SYSBITVAR3,0,BANKED
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSBITVAR3,0,BANKED
;GIE = 0 'don't interrupt now we've started
	bcf	INTCON0,GIE,ACCESS
;I2C_DATA_HIGH                 'SDA and SCL idle high
	bsf	TRISC,4,ACCESS
;I2C_CLOCK_HIGH
	bsf	TRISC,3,ACCESS
;wait I2C_END_DELAY            'let settle a while
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS6
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS6
;I2C_DATA_LOW                  'then, SDA low while SCL still high
	bcf	TRISC,4,ACCESS
	bcf	LATC,4,ACCESS
;wait I2C_CLOCK_DELAY          'for this amount of time
	movlw	160
	movwf	DELAYTEMP,ACCESS
DelayUS7
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS7
;I2C_CLOCK_LOW                 'end with SCL low, ready to clock
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
	return

;********************************************************************************

;Source: i2c.h (276)
I2CSTOP
;Dim I2CINTSTATESAVE as BIT
;I2C_CLOCK_LOW                 'begin with SCL=0 and SDA=0
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
;I2C_DATA_LOW
	bcf	TRISC,4,ACCESS
	bcf	LATC,4,ACCESS
;wait I2C_END_DELAY            'let ports settle
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS8
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS8
;I2C_CLOCK_HIGH                'make SCL=1 first
	bsf	TRISC,3,ACCESS
;wait I2C_CLOCK_DELAY          'hold for normal clock width time
	movlw	160
	movwf	DELAYTEMP,ACCESS
DelayUS9
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS9
;I2C_DATA_HIGH                 'then make SDA=1 afterwards
	bsf	TRISC,4,ACCESS
;wait I2C_END_DELAY            'hold for normal between-time
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS10
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS10
;back idling with SCL=1 and SDA=1 at this point
;GIE = I2CINTSTATESAVE                         'done, so re-enable interrupts
	btfss	SYSBITVAR3,0,BANKED
	bcf	INTCON0,GIE,ACCESS
	btfsc	SYSBITVAR3,0,BANKED
	bsf	INTCON0,GIE,ACCESS
	return

;********************************************************************************

;Source: glcd_ks0108.h (88)
INITGLCD_KS0108
;Set pin directions
;Dir GLCD_RS Out
	bcf	TRISB,3,ACCESS
;Dir GLCD_RW Out
	bcf	TRISC,7,ACCESS
;Dir GLCD_ENABLE Out
	bcf	TRISB,2,ACCESS
;Dir GLCD_CS1 Out
	bcf	TRISB,4,ACCESS
;Dir GLCD_CS2 Out
	bcf	TRISB,5,ACCESS
;Dir GLCD_RESET Out
	bcf	TRISC,2,ACCESS
;Reset
;Set GLCD_RESET Off
	bcf	LATC,2,ACCESS
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Set GLCD_RESET On
	bsf	LATC,2,ACCESS
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Select both chips
;Set GLCD_CS1 Off
	bcf	LATB,4,ACCESS
;Set GLCD_CS2 Off
	bcf	LATB,5,ACCESS
;Set on
;Set GLCD_RS Off
	bcf	LATB,3,ACCESS
;GLCDWriteByte 63
	movlw	63
	movwf	LCDBYTE,ACCESS
	rcall	GLCDWRITEBYTE_KS0108
;Set Z to 0
;GLCDWriteByte 192
	movlw	192
	movwf	LCDBYTE,ACCESS
	rcall	GLCDWRITEBYTE_KS0108
;Deselect chips
;Set GLCD_CS1 On
	bsf	LATB,4,ACCESS
;Set GLCD_CS2 On
	bsf	LATB,5,ACCESS
;Colours
;GLCDBackground = 0
	clrf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 1
	movlw	1
	movwf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;GLCDFontWidth = 5
	movlw	5
	movwf	GLCDFONTWIDTH,ACCESS
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT,ACCESS
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDfntDefaultHeight = 7
	movlw	7
	movwf	GLCDFNTDEFAULTHEIGHT,ACCESS
;Clear screen
;GLCDCLS_KS0108
	bra	GLCDCLS_KS0108

;********************************************************************************

;Source: i2c.h (190)
INITI2C
;Moved to prevent variable defintion when not required
;dim I2COldState, I2CState, I2CMatch, I2CTemp as byte
;dim I2CCount alias I2CState
;!
;!
;! Key constants not defined. I2C_DATA and I2C_CLOCK are required.
;!
;! Have you called "I2CStart", "I2CSend" or "I2CStop" without correct configuration of these key constants for software I2C?
;!
;!
;I2C_DATA_HIGH                   'release SDA (open drain floats high)
	bsf	TRISC,4,ACCESS
;!
;!
;! Key constants not defined. I2C_DATA and I2C_CLOCK are required.
;!
;! Have you called "I2CStart", "I2CSend" or "I2CStop" without correct configuration of these key constants for software I2C?
;!
;!
;I2C_CLOCK_HIGH                  'release SCL (open drain floats high)
	bsf	TRISC,3,ACCESS
;!
;!
;! Key constants not defined. I2C_DATA and I2C_CLOCK are required.
;!
;! Have you called "I2CStart", "I2CSend" or "I2CStop" without correct configuration of these key constants for software I2C?
;!
;!
;I2CMatch = FALSE                'address doesn't match (Slave mode)
	clrf	I2CMATCH,ACCESS
	return

;********************************************************************************

;Source: GaugeDemo - PORTB0.gcb (23)
INITPPS
;Module: UART pin directions
;Dir PORTC.6 Out    ' Make TX1 pin an output
	bcf	TRISC,6,ACCESS
;Module: UART1
;RC6PPS = 0x0013    // TX1 > RC6
	movlw	19
	banksel	RC6PPS
	movwf	RC6PPS,BANKED
	banksel	0
	return

;********************************************************************************

;Source: system.h (197)
INITSYS
;Clear BSR on ChipFamily16 MCUs
;MOVLB 0
	movlb	0
;Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	movlw	96
	banksel	OSCCON1
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
;ANSELD = 0
	clrf	ANSELD,BANKED
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
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
;PORTD = 0
	clrf	PORTD,ACCESS
;PORTE = 0
	clrf	PORTE,ACCESS
	banksel	0
	return

;********************************************************************************

;Source: usart.h (1242)
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

INTERRUPT
;Use Automatic Context Save for K42 and K83 with MVECEN = OFF.  Interrupt priority not supported
;Store system variables
;On Interrupt handlers
	banksel	PIE0
	btfss	PIE0,IOCIE,BANKED
	bra	NotIOCIF
	btfss	PIR0,IOCIF,BANKED
	bra	NotIOCIF
	banksel	0
	rcall	ISRHANDLER
	banksel	PIR0
	bcf	PIR0,IOCIF,BANKED
	bra	INTERRUPTDONE
NotIOCIF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	retfie	1
	banksel	0

;********************************************************************************

;Source: GaugeDemo - PORTB0.gcb (186)
ISRHANDLER
;Prevent reentrant events and prevents bounce
;If IOCBF0 = 1 then
	banksel	IOCBF
	btfss	IOCBF,IOCBF0,BANKED
	bra	ENDIF5
;intevent = TRUE
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,0,BANKED
;IOCBF0 = 0
	banksel	IOCBF
	bcf	IOCBF,IOCBF0,BANKED
;HserSend "."
	movlw	46
	banksel	SERDATA
	movwf	SERDATA,BANKED
	rcall	HSERSEND470
;End If
ENDIF5
;If IOCBF1 = 1 Then
	banksel	IOCBF
	btfss	IOCBF,IOCBF1,BANKED
	bra	ENDIF6
;updateglcdevent++
	banksel	UPDATEGLCDEVENT
	incf	UPDATEGLCDEVENT,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	UPDATEGLCDEVENT_H,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	UPDATEGLCDEVENT_U,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	UPDATEGLCDEVENT_E,F,BANKED
;IOCBF1 = 0
	banksel	IOCBF
	bcf	IOCBF,IOCBF1,BANKED
;HserSend "!"
	movlw	33
	banksel	SERDATA
	movwf	SERDATA,BANKED
	rcall	HSERSEND470
;End If
ENDIF6
	banksel	0
	return

;********************************************************************************

;Source: glcd_ks0108.h (227)
PSET_KS0108
;Dim GLCDDataTempCache as Byte
;Select screen half
;If GLCDX.6 = Off Then Set GLCD_CS2 Off:Set GLCD_CS1 On
	btfsc	GLCDX,6,ACCESS
	bra	ENDIF31
;If GLCDX.6 = Off Then Set GLCD_CS2 Off:Set GLCD_CS1 On
	bcf	LATB,5,ACCESS
;If GLCDX.6 = Off Then Set GLCD_CS2 Off:Set GLCD_CS1 On
	bsf	LATB,4,ACCESS
;If GLCDX.6 = Off Then Set GLCD_CS2 Off:Set GLCD_CS1 On
ENDIF31
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
	btfss	GLCDX,6,ACCESS
	bra	ENDIF32
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
	bcf	LATB,4,ACCESS
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
	movlw	64
	subwf	GLCDX,F,ACCESS
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
	bsf	LATB,5,ACCESS
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
ENDIF32
;Select page
;CurrPage = GLCDY / 8
	movff	GLCDY,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	rcall	SYSDIVSUB
	movff	SysBYTETempA,CURRPAGE
;Set GLCD_RS Off+
	bcf	LATB,3,ACCESS
;GLCDWriteByte b'10111000' Or CurrPage
	movlw	184
	iorwf	CURRPAGE,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	GLCDWRITEBYTE_KS0108
;Select column
;Set GLCD_RS Off
	bcf	LATB,3,ACCESS
;GLCDWriteByte 64 Or GLCDX
	movlw	64
	iorwf	GLCDX,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	GLCDWRITEBYTE_KS0108
;Dummy read first
;Set GLCD_RS On
	bsf	LATB,3,ACCESS
;GLCDDataTempCache = GLCDReadByte
	rcall	FN_GLCDREADBYTE_KS0108
	movff	GLCDREADBYTE_KS0108,GLCDDATATEMPCACHE
;Read current data
;Set GLCD_RS On
	bsf	LATB,3,ACCESS
;GLCDDataTempCache = GLCDReadByte
	rcall	FN_GLCDREADBYTE_KS0108
	movff	GLCDREADBYTE_KS0108,GLCDDATATEMPCACHE
;Change data to set/clear pixel
;GLCDBitNo = GLCDY And 7
	movlw	7
	andwf	GLCDY,W,ACCESS
	movwf	GLCDBITNO,ACCESS
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,ACCESS
	bra	ELSE33_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE,ACCESS
;Set C On
	bsf	STATUS,C,ACCESS
;Else
	bra	ENDIF33
ELSE33_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE,ACCESS
;Set C Off
	bcf	STATUS,C,ACCESS
;End If
ENDIF33
;Repeat GLCDBitNo
	movff	GLCDBITNO,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd1
SysRepeatLoop1
;Rotate GLCDChange Left
	rlcf	GLCDCHANGE,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,ACCESS
	bra	ELSE34_1
;GLCDDataTemp = GLCDDataTempCache And GLCDChange
	movf	GLCDDATATEMPCACHE,W,ACCESS
	andwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;Else
	bra	ENDIF34
ELSE34_1
;GLCDDataTemp = GLCDDataTempCache Or GLCDChange
	movf	GLCDDATATEMPCACHE,W,ACCESS
	iorwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;End If
ENDIF34
;Optimised to only send data when it changes
;If GLCDDataTempCache <> GLCDDataTemp Then
	movf	GLCDDATATEMP,W,ACCESS
	subwf	GLCDDATATEMPCACHE,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF35
;Select correct column again
;Set GLCD_RS Off
	bcf	LATB,3,ACCESS
;GLCDWriteByte 64 Or GLCDX
	movlw	64
	iorwf	GLCDX,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	GLCDWRITEBYTE_KS0108
;Write data back
;Set GLCD_RS On
	bsf	LATB,3,ACCESS
;GLCDWriteByte GLCDDataTemp
	movff	GLCDDATATEMP,LCDBYTE
	rcall	GLCDWRITEBYTE_KS0108
;End If
ENDIF35
;Set GLCD_CS1 On
	bsf	LATB,4,ACCESS
;Set GLCD_CS2 On
	bsf	LATB,5,ACCESS
	return

;********************************************************************************

;Source: system.h (4087)
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

;Source: system.h (4141)
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

;Source: system.h (4451)
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

;Source: system.h (3387)
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

;Source: system.h (3531)
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
	clrf	SYSLONGDIVMULTX,BANKED
	clrf	SYSLONGDIVMULTX_H,BANKED
	clrf	SYSLONGDIVMULTX_U,BANKED
	clrf	SYSLONGDIVMULTX_E,BANKED
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
	bra	ENDIF49
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF49
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP,ACCESS
SYSDIV32START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysLongDivMultA Left
	rlcf	SYSLONGDIVMULTA,F,BANKED
	rlcf	SYSLONGDIVMULTA_H,F,BANKED
	rlcf	SYSLONGDIVMULTA_U,F,BANKED
	rlcf	SYSLONGDIVMULTA_E,F,BANKED
;Rotate SysLongDivMultX Left
	rlcf	SYSLONGDIVMULTX,F,BANKED
	rlcf	SYSLONGDIVMULTX_H,F,BANKED
	rlcf	SYSLONGDIVMULTX_U,F,BANKED
	rlcf	SYSLONGDIVMULTX_E,F,BANKED
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,BANKED
	subwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTB_H,W,BANKED
	subwfb	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTB_U,W,BANKED
	subwfb	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTB_E,W,BANKED
	subwfb	SYSLONGDIVMULTX_E,F,BANKED
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0,BANKED
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF50
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0,BANKED
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,BANKED
	addwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTB_H,W,BANKED
	addwfc	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTB_U,W,BANKED
	addwfc	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTB_E,W,BANKED
	addwfc	SYSLONGDIVMULTX_E,F,BANKED
;End If
ENDIF50
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

;Source: system.h (1913)
SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;ChipFamily 16 support
;Get length
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movffl	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movffl	TABLAT,INDF1
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
	movffl	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable1
	db	17,68,83,49,51,48,55,32,73,110,115,112,101,99,116,105,111,110


StringTable2
	db	9,78,111,32,68,83,49,51,48,55


StringTable3
	db	7,83,116,111,112,112,101,100


StringTable4
	db	6,76,111,97,100,101,100


StringTable5
	db	8,98,105,116,32,48,32,58,32


StringTable6
	db	8,98,105,116,32,49,32,58,32


StringTable7
	db	8,98,105,116,32,51,32,58,32


StringTable8
	db	8,98,105,116,32,52,32,58,32


StringTable9
	db	1,46


StringTable10
	db	1,33


;********************************************************************************


 END
