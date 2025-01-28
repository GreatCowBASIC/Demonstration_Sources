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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Gauge_Solutions\KS0108_Gauge_Solutions\GaugeDemo - INT0.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Gauge_Solutions\KS0108_Gauge_Solutions\GaugeDemo - INT0.asm
;   Float Capability : 255
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F47K42, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Gauge_Solutions\KS0108_Gauge_Solutions\GaugeDemo - INT0.gcb"
 SUBTITLE    "01-24-2025 20:09:49"
#include <P18F47K42.inc>
 CONFIG CP = OFF, LVP = OFF, WRTSAF = OFF, WRTD = OFF, WRTB = OFF, WDTE = OFF, XINST = OFF, MVECEN = OFF, MCLRE = EXTMCLR, FCMEN = ON, CLKOUTEN = OFF, RSTOSC = HFINTOSC_1MHZ, FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
CCOUNT                           EQU      16          ; 0x10 (SA)
CCOUNT_E                         EQU      19          ; 0x13 (SA)
CCOUNT_H                         EQU      17          ; 0x11 (SA)
CCOUNT_U                         EQU      18          ; 0x12 (SA)
CHARCODE                         EQU      13          ; 0xD (SA)
CHARCOL                          EQU      20          ; 0x14 (SA)
CHARCOLS                         EQU      22          ; 0x16 (SA)
CHARCOL_H                        EQU      21          ; 0x15 (SA)
CHARLOCX                         EQU      23          ; 0x17 (SA)
CHARLOCX_H                       EQU      24          ; 0x18 (SA)
CHARLOCY                         EQU      25          ; 0x19 (SA)
CHARLOCY_H                       EQU      26          ; 0x1A (SA)
CHARROW                          EQU      27          ; 0x1B (SA)
CHARROWS                         EQU      29          ; 0x1D (SA)
CHARROW_H                        EQU      28          ; 0x1C (SA)
COL                              EQU      30          ; 0x1E (SA)
CURRCHARCOL                      EQU      31          ; 0x1F (SA)
CURRCHARROW                      EQU      32          ; 0x20 (SA)
CURRCHARVAL                      EQU      33          ; 0x21 (SA)
CURRCOL                          EQU      34          ; 0x22 (SA)
CURRPAGE                         EQU      35          ; 0x23 (SA)
DELAYTEMP                        EQU       0          ; 0x0 (SA)
DELAYTEMP2                       EQU       1          ; 0x1 (SA)
GLCDBACKGROUND                   EQU      36          ; 0x24 (SA)
GLCDBACKGROUND_H                 EQU      37          ; 0x25 (SA)
GLCDBITNO                        EQU      38          ; 0x26 (SA)
GLCDCHANGE                       EQU      39          ; 0x27 (SA)
GLCDCOLOUR                       EQU      40          ; 0x28 (SA)
GLCDCOLOUR_H                     EQU      41          ; 0x29 (SA)
GLCDDATATEMP                     EQU      42          ; 0x2A (SA)
GLCDDATATEMPCACHE                EQU      43          ; 0x2B (SA)
GLCDFNTDEFAULT                   EQU      44          ; 0x2C (SA)
GLCDFNTDEFAULTHEIGHT             EQU      45          ; 0x2D (SA)
GLCDFNTDEFAULTSIZE               EQU      46          ; 0x2E (SA)
GLCDFONTWIDTH                    EQU      47          ; 0x2F (SA)
GLCDFOREGROUND                   EQU      48          ; 0x30 (SA)
GLCDFOREGROUND_H                 EQU      49          ; 0x31 (SA)
GLCDPRINTLEN                     EQU      50          ; 0x32 (SA)
GLCDPRINTLOC                     EQU      51          ; 0x33 (SA)
GLCDPRINTLOC_H                   EQU      52          ; 0x34 (SA)
GLCDPRINT_STRING_COUNTER         EQU      53          ; 0x35 (SA)
GLCDREADBYTE_KS0108              EQU      54          ; 0x36 (SA)
GLCDX                            EQU      55          ; 0x37 (SA)
GLCDY                            EQU      56          ; 0x38 (SA)
GLCD_COUNT                       EQU      57          ; 0x39 (SA)
GLCD_YORDINATE                   EQU      58          ; 0x3A (SA)
GLCD_YORDINATE_H                 EQU      59          ; 0x3B (SA)
LCDBYTE                          EQU      60          ; 0x3C (SA)
LCDVALUE                         EQU      61          ; 0x3D (SA)
LCDVALUE_E                       EQU      64          ; 0x40 (SA)
LCDVALUE_H                       EQU      62          ; 0x3E (SA)
LCDVALUE_U                       EQU      63          ; 0x3F (SA)
LINECOLOUR                       EQU      65          ; 0x41 (SA)
LINECOLOUR_H                     EQU      66          ; 0x42 (SA)
PRINTLOCX                        EQU      67          ; 0x43 (SA)
PRINTLOCX_H                      EQU      68          ; 0x44 (SA)
PRINTLOCY                        EQU      69          ; 0x45 (SA)
PRINTLOCY_H                      EQU      70          ; 0x46 (SA)
ROW                              EQU      71          ; 0x47 (SA)
SAVESYSBYTETEMPX                 EQU      72          ; 0x48 (SA)
SAVESYSTEMP1                     EQU      73          ; 0x49 (SA)
SAVESYSTEMP2                     EQU      74          ; 0x4A (SA)
STRINGPOINTER                    EQU      75          ; 0x4B (SA)
SYSBITVAR0                       EQU      76          ; 0x4C (SA)
SYSBSR                           EQU      77          ; 0x4D (SA)
SYSBYTETEMPA                     EQU       5          ; 0x5 (SA)
SYSBYTETEMPB                     EQU       9          ; 0x9 (SA)
SYSBYTETEMPX                     EQU       0          ; 0x0 (SA)
SYSCALCTEMPA                     EQU       5          ; 0x5 (SA)
SYSCALCTEMPA_E                   EQU       8          ; 0x8 (SA)
SYSCALCTEMPA_H                   EQU       6          ; 0x6 (SA)
SYSCALCTEMPA_U                   EQU       7          ; 0x7 (SA)
SYSDIVLOOP                       EQU       4          ; 0x4 (SA)
SYSINTSTATESAVE0                 EQU      78          ; 0x4E (SA)
SYSLCDPRINTDATAHANDLER           EQU      79          ; 0x4F (SA)
SYSLCDPRINTDATAHANDLER_H         EQU      80          ; 0x50 (SA)
SYSLONGDIVMULTA                  EQU      81          ; 0x51 (SA)
SYSLONGDIVMULTA_E                EQU      84          ; 0x54 (SA)
SYSLONGDIVMULTA_H                EQU      82          ; 0x52 (SA)
SYSLONGDIVMULTA_U                EQU      83          ; 0x53 (SA)
SYSLONGDIVMULTB                  EQU      85          ; 0x55 (SA)
SYSLONGDIVMULTB_E                EQU      88          ; 0x58 (SA)
SYSLONGDIVMULTB_H                EQU      86          ; 0x56 (SA)
SYSLONGDIVMULTB_U                EQU      87          ; 0x57 (SA)
SYSLONGDIVMULTX                  EQU      89          ; 0x59 (SA)
SYSLONGDIVMULTX_E                EQU      92          ; 0x5C (SA)
SYSLONGDIVMULTX_H                EQU      90          ; 0x5A (SA)
SYSLONGDIVMULTX_U                EQU      91          ; 0x5B (SA)
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
SYSPRINTBUFFER                   EQU    8181          ; 0x1FF5
SYSPRINTBUFFLEN                  EQU      93          ; 0x5D (SA)
SYSREPEATTEMP1                   EQU      94          ; 0x5E (SA)
SYSSTATUS                        EQU      15          ; 0xF (SA)
SYSSTRINGA                       EQU       7          ; 0x7 (SA)
SYSSTRINGA_H                     EQU       8          ; 0x8 (SA)
SYSSTRINGLENGTH                  EQU       6          ; 0x6 (SA)
SYSSTRINGPARAM1                  EQU    8174          ; 0x1FEE
SYSTEMP1                         EQU      95          ; 0x5F (SA)
SYSTEMP1_E                       EQU      98          ; 0x62
SYSTEMP1_H                       EQU      96          ; 0x60
SYSTEMP1_U                       EQU      97          ; 0x61
SYSTEMP2                         EQU      99          ; 0x63
SYSTEMP2_H                       EQU     100          ; 0x64
SYSW                             EQU      14          ; 0xE (SA)
SYSWAITTEMPMS                    EQU       2          ; 0x2 (SA)
SYSWAITTEMPMS_H                  EQU       3          ; 0x3 (SA)
SYSWAITTEMPUS                    EQU       5          ; 0x5 (SA)
SYSWAITTEMPUS_H                  EQU       6          ; 0x6 (SA)
SYSWORDTEMPA                     EQU       5          ; 0x5 (SA)
SYSWORDTEMPA_H                   EQU       6          ; 0x6 (SA)
SYSWORDTEMPB                     EQU       9          ; 0x9 (SA)
SYSWORDTEMPB_H                   EQU      10          ; 0xA (SA)

;********************************************************************************

;Alias variables
AFSR0 EQU 16361
AFSR0_H EQU 16362

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	bra	INTERRUPT

;********************************************************************************

;Program_memory_page: 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	rcall	INITSYS
	rcall	INITGLCD_KS0108
;Enable interrupts
	bsf	INTCON0,GIE,ACCESS
	bsf	SYSINTSTATESAVE0,0,ACCESS

;Start_of_the_main_program
;''A demonstration program for GCBASIC.
;''--------------------------------------------------------------------------------------------------------------------------------
;''@author  EvanV
;''@licence GPL
;''@version 1.0a
;''@date    24.01.2025
;''***********************************************************
;This is the Default value, not required.
;GLCD Settings
;D0 to pin 7 on LCD
;D1 to pin 8 on LCD
;D2 to pin 9 on LCD
;D3 to pin 10 on LCD
;D4 to pin 11 on LCD
;D5 to pin 12 on LCD
;D6 to pin 13 on LCD
;D7 to pin 14 on LCD
;*************************** MAIN ***********************************************
;Variable to count events
;Dim intevent as Bit
;intevent = FALSE
	bcf	SYSBITVAR0,0,ACCESS
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
	clrf	PRINTLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,ACCESS
;Using SYSSTRINGPARAM1*6
	rcall	GLCDPRINT5
;Sets the external interrupt to trigger when the pin's level transitions from high to low (negative edge trigger).
;IOCBP = 0x01
	movlw	1
	banksel	IOCBP
	movwf	IOCBP,BANKED
;On Interrupt PORTCHANGE Call WheelHandler 
	banksel	PIE0
	bsf	PIE0,IOCIE,BANKED
;Do
SysDoLoop_S1
;If intevent = TRUE Then
	btfss	SYSBITVAR0,0,ACCESS
	bra	ENDIF1
;INTOFF
	bcf	SYSINTSTATESAVE0,0,ACCESS
	btfsc	INTCON0,GIE,ACCESS
	bsf	SYSINTSTATESAVE0,0,ACCESS
	bcf	INTCON0,GIE,ACCESS
;GLCDPrint 0,8, ccount
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
	movlw	8
	movwf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
	movff	CCOUNT,LCDVALUE
	movff	CCOUNT_H,LCDVALUE_H
	movff	CCOUNT_U,LCDVALUE_U
	movff	CCOUNT_E,LCDVALUE_E
	banksel	0
	rcall	GLCDPRINT8
;INTON
	btfss	SYSINTSTATESAVE0,0,ACCESS
	bcf	INTCON0,GIE,ACCESS
	btfsc	SYSINTSTATESAVE0,0,ACCESS
	bsf	INTCON0,GIE,ACCESS
;intevent = FALSE
	bcf	SYSBITVAR0,0,ACCESS
;End If
ENDIF1
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

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
	bcf	LATB,5,ACCESS
;Set GLCD_CS2 On
	bsf	LATB,4,ACCESS
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
	bsf	LATB,5,ACCESS
;Set GLCD_CS2 Off
	bcf	LATB,4,ACCESS
;next
	movlw	2
	subwf	GLCD_COUNT,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
;Set GLCD_CS1 On
	bsf	LATB,5,ACCESS
;Set GLCD_CS2 On
	bsf	LATB,4,ACCESS
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
	bra	ENDIF8
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 0
	clrf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;end if
ENDIF8
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
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF9
;CharLocY=CharLocY-1
	movlw	1
	subwf	CHARLOCY,F,ACCESS
	movlw	0
	subwfb	CHARLOCY_H,F,ACCESS
;end if
ENDIF9
;For CurrCharCol = 1 to 5
;Legacy method
	clrf	CURRCHARCOL,ACCESS
SysForLoop3
	incf	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect1Case1
	decf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL3
	movwf	CURRCHARVAL,ACCESS
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL4
	movwf	CURRCHARVAL,ACCESS
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL5
	movwf	CURRCHARVAL,ACCESS
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL6
	movwf	CURRCHARVAL,ACCESS
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case5
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL7
	movwf	CURRCHARVAL,ACCESS
;End Select
SysSelectEnd1
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
	clrf	ROW,ACCESS
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
	incf	ROW,F,ACCESS
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0,ACCESS
	bra	ELSE12_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, LineColour
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	SysTemp1,ACCESS
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp1,ACCESS
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	rcall	PSET_KS0108
;Else
	bra	ENDIF12
ELSE12_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, GLCDBackground
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	SysTemp1,ACCESS
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp1,ACCESS
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	rcall	PSET_KS0108
;End if
ENDIF12
;Put out a white intercharacter pixel/space
;PSet [word]CharLocX + ( GLCDFontWidth * GLCDfntDefaultsize) , [word]CharLocY + CharRow + CharRowS , GLCDBackground
	movf	GLCDFONTWIDTH,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movffl	PRODL,SysTemp1
	movf	SysTemp1,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDX,ACCESS
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	SysTemp1,ACCESS
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp1,W,ACCESS
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	rcall	PSET_KS0108
;CharRowS +=1
	incf	CHARROWS,F,ACCESS
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	subwf	ROW,W,ACCESS
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
GLCDPRINT5
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
	addwf	SysLCDPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W,ACCESS
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
	movf	SysTemp1,W,ACCESS
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
GLCDPRINT8
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	clrf	SYSPRINTBUFFLEN,ACCESS
;Do
SysDoLoop_S2
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	incf	SYSPRINTBUFFLEN,F,ACCESS
;SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
	lfsr	0,SYSPRINTBUFFER
	movf	SYSPRINTBUFFLEN,W,ACCESS
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
	incf	SYSPRINTBUFFLEN,W,ACCESS
	movwf	GLCDPRINT_STRING_COUNTER,ACCESS
	movlw	1
	subwf	SYSPRINTBUFFLEN,W,ACCESS
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
	movf	SysTemp1,W,ACCESS
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
	bcf	SYSBITVAR0,1,ACCESS
	btfsc	PORTB,3,ACCESS
	bsf	SYSBITVAR0,1,ACCESS
;GLCDSaveCS2 = GLCD_CS2
	bcf	SYSBITVAR0,2,ACCESS
	btfsc	PORTB,4,ACCESS
	bsf	SYSBITVAR0,2,ACCESS
;If GLCD_CS1 = 0 Then
	btfss	PORTB,5,ACCESS
;GLCD_CS2 = 1
	bsf	LATB,4,ACCESS
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
	btfsc	SYSBITVAR0,1,ACCESS
	bsf	LATB,3,ACCESS
;GLCD_CS2 = GLCDSaveCS2
	bcf	LATB,4,ACCESS
	btfsc	SYSBITVAR0,2,ACCESS
	bsf	LATB,4,ACCESS
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
	bcf	TRISB,5,ACCESS
;Dir GLCD_CS2 Out
	bcf	TRISB,4,ACCESS
;Dir GLCD_RESET Out
	bcf	TRISC,2,ACCESS
;Reset
;Set GLCD_RESET Off
	bcf	LATC,2,ACCESS
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set GLCD_RESET On
	bsf	LATC,2,ACCESS
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Select both chips
;Set GLCD_CS1 Off
	bcf	LATB,5,ACCESS
;Set GLCD_CS2 Off
	bcf	LATB,4,ACCESS
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
	bsf	LATB,5,ACCESS
;Set GLCD_CS2 On
	bsf	LATB,4,ACCESS
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

INTERRUPT
;Use Automatic Context Save for K42 and K83 with MVECEN = OFF.  Interrupt priority not supported
;Store system variables
	movff	SysByteTempX,SaveSysByteTempX
	movff	SysTemp1,SaveSysTemp1
	movff	SysTemp2,SaveSysTemp2
;On Interrupt handlers
	banksel	PIE0
	btfss	PIE0,IOCIE,BANKED
	bra	NotIOCIF
	btfss	PIR0,IOCIF,BANKED
	bra	NotIOCIF
	banksel	0
	rcall	WHEELHANDLER
	banksel	PIR0
	bcf	PIR0,IOCIF,BANKED
	bra	INTERRUPTDONE
NotIOCIF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	movff	SaveSysByteTempX,SysByteTempX
	movff	SaveSysTemp1,SysTemp1
	movff	SaveSysTemp2,SysTemp2
	retfie	1
	banksel	0

;********************************************************************************

;Source: glcd_ks0108.h (227)
PSET_KS0108
;Dim GLCDDataTempCache as Byte
;Select screen half
;If GLCDX.6 = Off Then Set GLCD_CS2 Off:Set GLCD_CS1 On
	btfsc	GLCDX,6,ACCESS
	bra	ENDIF17
;If GLCDX.6 = Off Then Set GLCD_CS2 Off:Set GLCD_CS1 On
	bcf	LATB,4,ACCESS
;If GLCDX.6 = Off Then Set GLCD_CS2 Off:Set GLCD_CS1 On
	bsf	LATB,5,ACCESS
;If GLCDX.6 = Off Then Set GLCD_CS2 Off:Set GLCD_CS1 On
ENDIF17
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
	btfss	GLCDX,6,ACCESS
	bra	ENDIF18
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
	bcf	LATB,5,ACCESS
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
	movlw	64
	subwf	GLCDX,F,ACCESS
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
	bsf	LATB,4,ACCESS
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
ENDIF18
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
	bra	ELSE19_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE,ACCESS
;Set C On
	bsf	STATUS,C,ACCESS
;Else
	bra	ENDIF19
ELSE19_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE,ACCESS
;Set C Off
	bcf	STATUS,C,ACCESS
;End If
ENDIF19
;Repeat GLCDBitNo
	movff	GLCDBITNO,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd1
SysRepeatLoop1
;Rotate GLCDChange Left
	rlcf	GLCDCHANGE,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,ACCESS
	bra	ELSE20_1
;GLCDDataTemp = GLCDDataTempCache And GLCDChange
	movf	GLCDDATATEMPCACHE,W,ACCESS
	andwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;Else
	bra	ENDIF20
ELSE20_1
;GLCDDataTemp = GLCDDataTempCache Or GLCDChange
	movf	GLCDDATATEMPCACHE,W,ACCESS
	iorwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;End If
ENDIF20
;Optimised to only send data when it changes
;If GLCDDataTempCache <> GLCDDataTemp Then
	movf	GLCDDATATEMP,W,ACCESS
	subwf	GLCDDATATEMPCACHE,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF21
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
ENDIF21
;Set GLCD_CS1 On
	bsf	LATB,5,ACCESS
;Set GLCD_CS2 On
	bsf	LATB,4,ACCESS
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
	bra	ENDIF35
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF35
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
	bra	ENDIF36
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
ENDIF36
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
	db	6,76,111,97,100,101,100


;********************************************************************************

;Source: GaugeDemo - INT0.gcb (81)
WHEELHANDLER
;Prevent reentrant events and prevents bounce
;If intevent = FALSE and IOCBF0 = 1 then
	clrf	SysByteTempX,ACCESS
	btfss	SYSBITVAR0,0,ACCESS
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	clrf	SysByteTempX,ACCESS
	banksel	IOCBF
	btfsc	IOCBF,IOCBF0,BANKED
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,ACCESS
	andwf	SysByteTempX,W,ACCESS
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF2
;ccount++
	incf	CCOUNT,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	CCOUNT_H,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	CCOUNT_U,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	CCOUNT_E,F,ACCESS
;intevent = TRUE
	bsf	SYSBITVAR0,0,ACCESS
;IOCBF0 = 0
	banksel	IOCBF
	bcf	IOCBF,IOCBF0,BANKED
;End If
ENDIF2
	banksel	0
	return

;********************************************************************************


 END
