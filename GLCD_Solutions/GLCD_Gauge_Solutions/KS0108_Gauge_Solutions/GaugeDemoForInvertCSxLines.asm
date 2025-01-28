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
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Gauge_Solutions\KS0108_Gauge_Solutions\GaugeDemoForInvertCSxLines.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Gauge_Solutions\KS0108_Gauge_Solutions\GaugeDemoForInvertCSxLines.asm
;   Float Capability : 255
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F47K42, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_Gauge_Solutions\KS0108_Gauge_Solutions\GaugeDemoForInvertCSxLines.gcb"
 SUBTITLE    "01-27-2025 12:42:31"
#include <P18F47K42.inc>
 CONFIG CP = OFF, LVP = OFF, WRTSAF = OFF, WRTD = OFF, WRTB = OFF, WDTE = OFF, XINST = OFF, MVECEN = OFF, MCLRE = EXTMCLR, FCMEN = ON, CLKOUTEN = OFF, RSTOSC = HFINTOSC_1MHZ, FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
ADREADPORT                       EQU      14          ; 0xE (SA)
CHARCODE                         EQU      15          ; 0xF (SA)
CHARCOL                          EQU      16          ; 0x10 (SA)
CHARCOL_H                        EQU      17          ; 0x11 (SA)
CHARLOCX                         EQU      18          ; 0x12 (SA)
CHARLOCX_H                       EQU      19          ; 0x13 (SA)
CHARLOCY                         EQU      20          ; 0x14 (SA)
CHARLOCY_H                       EQU      21          ; 0x15 (SA)
COLSPERFONT                      EQU      22          ; 0x16 (SA)
COUNTERX                         EQU      23          ; 0x17 (SA)
COUNTERX_H                       EQU      24          ; 0x18 (SA)
CURRCHARCOL                      EQU      25          ; 0x19 (SA)
CURRCHARROW                      EQU      26          ; 0x1A (SA)
CURRCHARVAL                      EQU      27          ; 0x1B (SA)
CURRCOL                          EQU      28          ; 0x1C (SA)
CURRPAGE                         EQU      29          ; 0x1D (SA)
DATAPTR                          EQU      30          ; 0x1E (SA)
DATAPTR_H                        EQU      31          ; 0x1F (SA)
DELAYTEMP                        EQU       0          ; 0x0 (SA)
DELAYTEMP2                       EQU       1          ; 0x1 (SA)
DRAWLINE                         EQU      32          ; 0x20 (SA)
DRAWLINE_H                       EQU      33          ; 0x21 (SA)
GLCDBACKGROUND                   EQU      34          ; 0x22 (SA)
GLCDBACKGROUND_H                 EQU      35          ; 0x23 (SA)
GLCDBITNO                        EQU      36          ; 0x24 (SA)
GLCDCHANGE                       EQU      37          ; 0x25 (SA)
GLCDCOLOUR                       EQU      38          ; 0x26 (SA)
GLCDCOLOUR_H                     EQU      39          ; 0x27 (SA)
GLCDDATA                         EQU      40          ; 0x28 (SA)
GLCDDATATEMP                     EQU      41          ; 0x29 (SA)
GLCDDATATEMPCACHE                EQU      42          ; 0x2A (SA)
GLCDFNTDEFAULT                   EQU      43          ; 0x2B (SA)
GLCDFNTDEFAULTHEIGHT             EQU      44          ; 0x2C (SA)
GLCDFNTDEFAULTSIZE               EQU      45          ; 0x2D (SA)
GLCDFONTWIDTH                    EQU      46          ; 0x2E (SA)
GLCDFOREGROUND                   EQU      47          ; 0x2F (SA)
GLCDFOREGROUND_H                 EQU      48          ; 0x30 (SA)
GLCDPRINTLEN                     EQU      49          ; 0x31 (SA)
GLCDPRINTLOC                     EQU      50          ; 0x32 (SA)
GLCDPRINTLOC_H                   EQU      51          ; 0x33 (SA)
GLCDPRINT_STRING_COUNTER         EQU      52          ; 0x34 (SA)
GLCDREADBYTE_KS0108              EQU      53          ; 0x35 (SA)
GLCDTEMP                         EQU      54          ; 0x36 (SA)
GLCDTEMP_H                       EQU      55          ; 0x37 (SA)
GLCDX                            EQU      56          ; 0x38 (SA)
GLCDY                            EQU      57          ; 0x39 (SA)
GLCD_COUNT                       EQU      58          ; 0x3A (SA)
GLCD_YORDINATE                   EQU      59          ; 0x3B (SA)
GLCD_YORDINATE_H                 EQU      60          ; 0x3C (SA)
LCDBYTE                          EQU      61          ; 0x3D (SA)
LCDVALUE                         EQU      62          ; 0x3E (SA)
LCDVALUE_E                       EQU      65          ; 0x41 (SA)
LCDVALUE_H                       EQU      63          ; 0x3F (SA)
LCDVALUE_U                       EQU      64          ; 0x40 (SA)
LINECOLOUR                       EQU      66          ; 0x42 (SA)
LINECOLOUR_H                     EQU      67          ; 0x43 (SA)
LINEDIFFX                        EQU      68          ; 0x44 (SA)
LINEDIFFX_H                      EQU      69          ; 0x45 (SA)
LINEDIFFX_X2                     EQU      70          ; 0x46 (SA)
LINEDIFFX_X2_H                   EQU      71          ; 0x47 (SA)
LINEDIFFY                        EQU      72          ; 0x48 (SA)
LINEDIFFY_H                      EQU      73          ; 0x49 (SA)
LINEDIFFY_X2                     EQU      74          ; 0x4A (SA)
LINEDIFFY_X2_H                   EQU      75          ; 0x4B (SA)
LINEERR                          EQU      76          ; 0x4C (SA)
LINEERR_H                        EQU      77          ; 0x4D (SA)
LINESTEPX                        EQU      78          ; 0x4E (SA)
LINESTEPX_H                      EQU      79          ; 0x4F (SA)
LINESTEPY                        EQU      80          ; 0x50 (SA)
LINESTEPY_H                      EQU      81          ; 0x51 (SA)
LINEX1                           EQU      82          ; 0x52 (SA)
LINEX1_H                         EQU      83          ; 0x53 (SA)
LINEX2                           EQU      84          ; 0x54 (SA)
LINEX2_H                         EQU      85          ; 0x55 (SA)
LINEY1                           EQU      86          ; 0x56 (SA)
LINEY1_H                         EQU      87          ; 0x57 (SA)
LINEY2                           EQU      88          ; 0x58 (SA)
LINEY2_H                         EQU      89          ; 0x59 (SA)
LOCALCHARCODE                    EQU      90          ; 0x5A (SA)
LOCALCHARCODE_H                  EQU      91          ; 0x5B (SA)
L_CALIBRATE                      EQU      92          ; 0x5C (SA)
L_CALIBRATE_H                    EQU      93          ; 0x5D (SA)
L_FROMHIGH                       EQU      94          ; 0x5E (SA)
L_FROMHIGH_H                     EQU      95          ; 0x5F (SA)
L_FROMLOW                        EQU      96          ; 0x60
L_FROMLOW_H                      EQU      97          ; 0x61
L_MAP                            EQU      98          ; 0x62
L_MAP_H                          EQU      99          ; 0x63
L_SYSCALC                        EQU     100          ; 0x64
L_SYSCALCF                       EQU     102          ; 0x66
L_SYSCALCF_E                     EQU     105          ; 0x69
L_SYSCALCF_H                     EQU     103          ; 0x67
L_SYSCALCF_U                     EQU     104          ; 0x68
L_SYSCALC_H                      EQU     101          ; 0x65
L_TOHIGH                         EQU     106          ; 0x6A
L_TOHIGH_H                       EQU     107          ; 0x6B
L_TOLOW                          EQU     108          ; 0x6C
L_TOLOW_H                        EQU     109          ; 0x6D
OLDCOUNTERX                      EQU     110          ; 0x6E
OLDCOUNTERX_H                    EQU     111          ; 0x6F
OLDGLCDFONTWIDTH                 EQU     112          ; 0x70
PRINTLOCX                        EQU     113          ; 0x71
PRINTLOCX_H                      EQU     114          ; 0x72
PRINTLOCY                        EQU     115          ; 0x73
PRINTLOCY_H                      EQU     116          ; 0x74
READAD                           EQU     117          ; 0x75
ROWSPERFONT                      EQU     118          ; 0x76
SCALE                            EQU     119          ; 0x77
SCALE_H                          EQU     120          ; 0x78
STR                              EQU    8165          ; 0x1FE5
STRINGPOINTER                    EQU     121          ; 0x79
SWCACHE                          EQU     122          ; 0x7A
SWCACHE_H                        EQU     123          ; 0x7B
SWPREV                           EQU     124          ; 0x7C
SWPREV_H                         EQU     125          ; 0x7D
SWVAL                            EQU     126          ; 0x7E
SWVAL_H                          EQU     127          ; 0x7F
SYSBITVAR0                       EQU     128          ; 0x80
SYSBYTETEMPA                     EQU       5          ; 0x5 (SA)
SYSBYTETEMPB                     EQU       9          ; 0x9 (SA)
SYSBYTETEMPX                     EQU       0          ; 0x0 (SA)
SYSCALCTEMPA                     EQU       5          ; 0x5 (SA)
SYSCALCTEMPA_E                   EQU       8          ; 0x8 (SA)
SYSCALCTEMPA_H                   EQU       6          ; 0x6 (SA)
SYSCALCTEMPA_U                   EQU       7          ; 0x7 (SA)
SYSCALCTEMPX                     EQU       0          ; 0x0 (SA)
SYSCALCTEMPX_H                   EQU       1          ; 0x1 (SA)
SYSCHARCOUNT                     EQU     129          ; 0x81
SYSDIVLOOP                       EQU       4          ; 0x4 (SA)
SYSDIVMULTA                      EQU       7          ; 0x7 (SA)
SYSDIVMULTA_H                    EQU       8          ; 0x8 (SA)
SYSDIVMULTB                      EQU      11          ; 0xB (SA)
SYSDIVMULTB_H                    EQU      12          ; 0xC (SA)
SYSDIVMULTX                      EQU       2          ; 0x2 (SA)
SYSDIVMULTX_H                    EQU       3          ; 0x3 (SA)
SYSFORLOOPABSVALUE1              EQU     130          ; 0x82
SYSFORLOOPABSVALUE1_H            EQU     131          ; 0x83
SYSFORLOOPSTEP0                  EQU     132          ; 0x84
SYSFORLOOPSTEP0_H                EQU     133          ; 0x85
SYSINTEGERTEMPA                  EQU       5          ; 0x5 (SA)
SYSINTEGERTEMPA_H                EQU       6          ; 0x6 (SA)
SYSINTEGERTEMPB                  EQU       9          ; 0x9 (SA)
SYSINTEGERTEMPB_H                EQU      10          ; 0xA (SA)
SYSINTEGERTEMPX                  EQU       0          ; 0x0 (SA)
SYSINTEGERTEMPX_H                EQU       1          ; 0x1 (SA)
SYSLCDPRINTDATAHANDLER           EQU     134          ; 0x86
SYSLCDPRINTDATAHANDLER_H         EQU     135          ; 0x87
SYSLONGDIVMULTA                  EQU     136          ; 0x88
SYSLONGDIVMULTA_E                EQU     139          ; 0x8B
SYSLONGDIVMULTA_H                EQU     137          ; 0x89
SYSLONGDIVMULTA_U                EQU     138          ; 0x8A
SYSLONGDIVMULTB                  EQU     140          ; 0x8C
SYSLONGDIVMULTB_E                EQU     143          ; 0x8F
SYSLONGDIVMULTB_H                EQU     141          ; 0x8D
SYSLONGDIVMULTB_U                EQU     142          ; 0x8E
SYSLONGDIVMULTX                  EQU     144          ; 0x90
SYSLONGDIVMULTX_E                EQU     147          ; 0x93
SYSLONGDIVMULTX_H                EQU     145          ; 0x91
SYSLONGDIVMULTX_U                EQU     146          ; 0x92
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
SYSPRINTBUFFLEN                  EQU     148          ; 0x94
SYSREPEATTEMP1                   EQU     149          ; 0x95
SYSREPEATTEMP1_H                 EQU     150          ; 0x96
SYSREPEATTEMP2                   EQU     151          ; 0x97
SYSSIGNBYTE                      EQU      13          ; 0xD (SA)
SYSSTRDATA                       EQU     152          ; 0x98
SYSSTRINGA                       EQU       7          ; 0x7 (SA)
SYSSTRINGA_H                     EQU       8          ; 0x8 (SA)
SYSSTRINGLENGTH                  EQU       6          ; 0x6 (SA)
SYSSTRINGPARAM1                  EQU    8171          ; 0x1FEB
SYSTEMP1                         EQU     153          ; 0x99
SYSTEMP1_E                       EQU     156          ; 0x9C
SYSTEMP1_H                       EQU     154          ; 0x9A
SYSTEMP1_U                       EQU     155          ; 0x9B
SYSTEMP2                         EQU     157          ; 0x9D
SYSTEMP2_H                       EQU     158          ; 0x9E
SYSTEMP3                         EQU     159          ; 0x9F
SYSVALTEMP                       EQU     160          ; 0xA0
SYSVALTEMP_H                     EQU     161          ; 0xA1
SYSWAITTEMP10US                  EQU       5          ; 0x5 (SA)
SYSWAITTEMPMS                    EQU       2          ; 0x2 (SA)
SYSWAITTEMPMS_H                  EQU       3          ; 0x3 (SA)
SYSWAITTEMPUS                    EQU       5          ; 0x5 (SA)
SYSWAITTEMPUS_H                  EQU       6          ; 0x6 (SA)
SYSWORDTEMPA                     EQU       5          ; 0x5 (SA)
SYSWORDTEMPA_H                   EQU       6          ; 0x6 (SA)
SYSWORDTEMPB                     EQU       9          ; 0x9 (SA)
SYSWORDTEMPB_H                   EQU      10          ; 0xA (SA)
SYSWORDTEMPX                     EQU       0          ; 0x0 (SA)
SYSWORDTEMPX_H                   EQU       1          ; 0x1 (SA)
TEMPSTRING                       EQU    8160          ; 0x1FE0
VALUE                            EQU     162          ; 0xA2
VALUE_H                          EQU     163          ; 0xA3
_GLCDX                           EQU     164          ; 0xA4
_GLCDY                           EQU     165          ; 0xA5
_NUM                             EQU     166          ; 0xA6
_NUM_H                           EQU     167          ; 0xA7
_XPOS                            EQU     168          ; 0xA8
_YPOS                            EQU     169          ; 0xA9

;********************************************************************************

;Alias variables
AFSR0 EQU 16361
AFSR0_H EQU 16362
SYSREADADBYTE EQU 117
SYSSCALEWORD EQU 119
SYSSCALEWORD_H EQU 120
SYSSTR_0 EQU 8165

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
	call	INITGLCD_KS0108

;Start_of_the_main_program
;''A demonstration program for GCBASIC.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is a simple GLCD demonstration of the KS0108 GLCD capabilities.
;''This program fonts, draws lines, boxes, circles and prints strings.
;''The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;''@author  EvanV
;''@licence GPL
;''@version 1.0a
;''@date    10.12.2018
;''***********************************************************
;This is the Default value, not required.
;The constant is required to support OLED fonts
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
;*** Variables
;Dim tempString as String * 4
;Dim CounterX, oldCounterX as Word
;Show startup
;For Counterx = 99  to 0 step -11
	movlw	99
	movwf	COUNTERX,ACCESS
	clrf	COUNTERX_H,ACCESS
SysForLoop1
;Init SysForLoopStep0 :#0
	movlw	245
	movwf	SysForLoopStep0,BANKED
	setf	SysForLoopStep0_H,BANKED
;Draw Unit or clear
;If Counterx/10 = 0 then
	movff	COUNTERX,SysWORDTempA
	movff	COUNTERX_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE1_1
;GLCD_Draw48x48 ( 0, 0, -1 )
	clrf	_XPOS,BANKED
	clrf	_YPOS,BANKED
	setf	_NUM,BANKED
	setf	_NUM_H,BANKED
	call	GLCD_DRAW48X48
;Else
	bra	ENDIF1
ELSE1_1
;GLCD_Draw48x48 ( 0, 0, Counterx / 10 )
	clrf	_XPOS,BANKED
	clrf	_YPOS,BANKED
	movff	COUNTERX,SysINTEGERTempA
	movff	COUNTERX_H,SysINTEGERTempA_H
	movlw	10
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSDIVSUBINT
	movff	SysINTEGERTempA,_NUM
	movff	SysINTEGERTempA_H,_NUM_H
	call	GLCD_DRAW48X48
;End If
ENDIF1
;Draw decimal
;GLCD_Draw48x48 ( 48, 0, Counterx Mod 10 )
	movlw	48
	movwf	_XPOS,BANKED
	clrf	_YPOS,BANKED
	movff	COUNTERX,SysINTEGERTempA
	movff	COUNTERX_H,SysINTEGERTempA_H
	movlw	10
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSDIVSUBINT
	movff	SysINTEGERTempX,_NUM
	movff	SysINTEGERTempX_H,_NUM_H
	call	GLCD_DRAW48X48
;Show Speed
;Show Unit
;If Counterx/10 = 0 then
	movff	COUNTERX,SysWORDTempA
	movff	COUNTERX_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE2_1
;GLCD_Draw48x48 ( 0, 0, -1 )
	clrf	_XPOS,BANKED
	clrf	_YPOS,BANKED
	setf	_NUM,BANKED
	setf	_NUM_H,BANKED
	call	GLCD_DRAW48X48
;Else
	bra	ENDIF2
ELSE2_1
;GLCD_Draw48x48 ( 0, 0, Counterx / 10 )
	clrf	_XPOS,BANKED
	clrf	_YPOS,BANKED
	movff	COUNTERX,SysINTEGERTempA
	movff	COUNTERX_H,SysINTEGERTempA_H
	movlw	10
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSDIVSUBINT
	movff	SysINTEGERTempA,_NUM
	movff	SysINTEGERTempA_H,_NUM_H
	call	GLCD_DRAW48X48
;End If
ENDIF2
;Show digit
;GLCD_Draw48x48 ( 48, 0, Counterx Mod 10 )
	movlw	48
	movwf	_XPOS,BANKED
	clrf	_YPOS,BANKED
	movff	COUNTERX,SysINTEGERTempA
	movff	COUNTERX_H,SysINTEGERTempA_H
	movlw	10
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSDIVSUBINT
	movff	SysINTEGERTempX,_NUM
	movff	SysINTEGERTempX_H,_NUM_H
	call	GLCD_DRAW48X48
;Draw Decimal value
;Change font
;GLCDFNTDEFAULTSIZE= 2
	movlw	2
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;Print Value
;GLCDPrint 98, 32, 0
	movlw	98
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	32
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	clrf	LCDVALUE,ACCESS
	clrf	LCDVALUE_H,ACCESS
	clrf	LCDVALUE_U,ACCESS
	clrf	LCDVALUE_E,ACCESS
	call	GLCDPRINT14
;Box 94, 44, 96, 42
	movlw	94
	movwf	LINEX1,ACCESS
	clrf	LINEX1_H,ACCESS
	movlw	44
	movwf	LINEY1,ACCESS
	clrf	LINEY1_H,ACCESS
	movlw	96
	movwf	LINEX2,ACCESS
	clrf	LINEX2_H,ACCESS
	movlw	42
	movwf	LINEY2,ACCESS
	clrf	LINEY2_H,ACCESS
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	BOX23
;GLCDFNTDEFAULTSIZE= 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;Show Temp
;ShowTemp( CounterX )
	movff	COUNTERX,VALUE
	call	SHOWTEMP
;Show Date
;ShowDate()
	call	SHOWDATE
;ShowTime
;ShowTime()
	call	SHOWTIME
;Show ShowDistance()
;ShowDistance()
	call	SHOWDISTANCE
;Show ShowFuel
;Send a value just to show fuel bar ... scale to prevent overflow
;ShowFuel ( CounterX  )
	movff	COUNTERX,VALUE
	movff	COUNTERX_H,VALUE_H
	call	SHOWFUEL
;wait 400 ms
	movlw	144
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Next
;Integer negative Step Handler in For-next statement
	btfss	SYSFORLOOPSTEP0_H,7,BANKED
	bra	ELSE3_1
;Set SysForLoopABsValue to -StepValue :#1 
	comf	SYSFORLOOPSTEP0,W,BANKED
	movwf	SysForLoopABsValue1,BANKED
	comf	SYSFORLOOPSTEP0_H,W,BANKED
	movwf	SysForLoopABsValue1_H,BANKED
	incf	SysForLoopABsValue1,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SysForLoopABsValue1_H,F,BANKED
;IF ( COUNTERX - 0) } [WORD]SysForLoopABsValue1 THEN  :#1n 
	movlw	0
	subwf	COUNTERX,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	0
	subwfb	COUNTERX_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movff	SYSFORLOOPABSVALUE1,SysWORDTempB
	movff	SYSFORLOOPABSVALUE1_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF5
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	movf	SysForLoopStep0,W,BANKED
	addwf	COUNTERX,F,ACCESS
	movf	SysForLoopStep0_H,W,BANKED
	addwfc	COUNTERX_H,F,ACCESS
	bra	SysForLoop1
;END IF
ENDIF5
	bra	ENDIF3
ELSE3_1
;Integer positive Step Handler in For-next statement
;IF ([WORD]0 - [WORD]COUNTERX) } [WORD]SysForLoopStep0 THEN :#1p 
	movf	COUNTERX,W,ACCESS
	sublw	0
	movwf	SysTemp1,BANKED
	clrf	SysTemp2,BANKED
	movf	COUNTERX_H,W,ACCESS
	subwfb	SysTemp2,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movff	SYSFORLOOPSTEP0,SysWORDTempB
	movff	SYSFORLOOPSTEP0_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF6
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	movf	SysForLoopStep0,W,BANKED
	addwf	COUNTERX,F,ACCESS
	movf	SysForLoopStep0_H,W,BANKED
	addwfc	COUNTERX_H,F,ACCESS
	bra	SysForLoop1
;END IF
ENDIF6
;END IF
ENDIF3
SysForLoopEnd1
;Main loop
;Ensure oldCounterX <> CounterX
;oldCounterX = !CounterX
	comf	COUNTERX,W,ACCESS
	movwf	OLDCOUNTERX,BANKED
	comf	COUNTERX_H,W,ACCESS
	movwf	OLDCOUNTERX_H,BANKED
;Do
SysDoLoop_S1
;CounterX = readAd(AN1)
	movlw	1
	movwf	ADREADPORT,ACCESS
	call	FN_READAD78
	movff	SYSREADADBYTE,COUNTERX
	clrf	COUNTERX_H,ACCESS
;CounterX = scale ( CounterX, 0,255,0, 999 )
	movff	COUNTERX,L_MAP
	movff	COUNTERX_H,L_MAP_H
	clrf	L_FROMLOW,BANKED
	clrf	L_FROMLOW_H,BANKED
	setf	L_FROMHIGH,ACCESS
	clrf	L_FROMHIGH_H,ACCESS
	clrf	L_TOLOW,BANKED
	clrf	L_TOLOW_H,BANKED
	movlw	231
	movwf	L_TOHIGH,BANKED
	movlw	3
	movwf	L_TOHIGH_H,BANKED
	clrf	L_CALIBRATE,ACCESS
	clrf	L_CALIBRATE_H,ACCESS
	call	FN_SCALE151
	movff	SYSSCALEWORD,COUNTERX
	movff	SYSSCALEWORD_H,COUNTERX_H
;Counter is the range of 0 to 700
;equates to 70.0
;If oldCounterX <> CounterX then
	movff	OLDCOUNTERX,SysWORDTempA
	movff	OLDCOUNTERX_H,SysWORDTempA_H
	movff	COUNTERX,SysWORDTempB
	movff	COUNTERX_H,SysWORDTempB_H
	call	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF4
;oldCounterX = CounterX
	movff	COUNTERX,OLDCOUNTERX
	movff	COUNTERX_H,OLDCOUNTERX_H
;Show Speed
;Show Unit
;If Counterx/100 = 0 then
	movff	COUNTERX,SysWORDTempA
	movff	COUNTERX_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE7_1
;GLCD_Draw48x48 ( 0, 0, -1 )
	clrf	_XPOS,BANKED
	clrf	_YPOS,BANKED
	setf	_NUM,BANKED
	setf	_NUM_H,BANKED
	call	GLCD_DRAW48X48
;Else
	bra	ENDIF7
ELSE7_1
;GLCD_Draw48x48 ( 0, 0, Counterx / 100 )
	clrf	_XPOS,BANKED
	clrf	_YPOS,BANKED
	movff	COUNTERX,SysINTEGERTempA
	movff	COUNTERX_H,SysINTEGERTempA_H
	movlw	100
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSDIVSUBINT
	movff	SysINTEGERTempA,_NUM
	movff	SysINTEGERTempA_H,_NUM_H
	call	GLCD_DRAW48X48
;End If
ENDIF7
;Show digit
;GLCD_Draw48x48 ( 48, 0, ( Counterx / 10 ) MOD 10 )
	movlw	48
	movwf	_XPOS,BANKED
	clrf	_YPOS,BANKED
	movff	COUNTERX,SysWORDTempA
	movff	COUNTERX_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movff	SysTemp1,SysINTEGERTempA
	movff	SysTemp1_H,SysINTEGERTempA_H
	movlw	10
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSDIVSUBINT
	movff	SysINTEGERTempX,_NUM
	movff	SysINTEGERTempX_H,_NUM_H
	call	GLCD_DRAW48X48
;Draw Decimal value
;Change font
;GLCDFNTDEFAULTSIZE= 2
	movlw	2
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;Print Value
;GLCDPrint 98, 32, Counterx Mod 10
	movlw	98
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	32
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	COUNTERX,SysLONGTempA
	movff	COUNTERX_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movlw	10
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSDIVSUB32
	movff	SysLONGTempX,LCDVALUE
	movff	SysLONGTempX_H,LCDVALUE_H
	movff	SysLONGTempX_U,LCDVALUE_U
	movff	SysLONGTempX_E,LCDVALUE_E
	call	GLCDPRINT14
;Box 94, 44, 96, 42
	movlw	94
	movwf	LINEX1,ACCESS
	clrf	LINEX1_H,ACCESS
	movlw	44
	movwf	LINEY1,ACCESS
	clrf	LINEY1_H,ACCESS
	movlw	96
	movwf	LINEX2,ACCESS
	clrf	LINEX2_H,ACCESS
	movlw	42
	movwf	LINEY2,ACCESS
	clrf	LINEY2_H,ACCESS
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	BOX23
;GLCDFNTDEFAULTSIZE= 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
;Show Temp
;ShowTemp( CounterX / 10 )
	movff	COUNTERX,SysWORDTempA
	movff	COUNTERX_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempA,VALUE
	call	SHOWTEMP
;Show Date
;ShowDate()
	call	SHOWDATE
;Show Time
;ShowTime()
	call	SHOWTIME
;Show ShowDistance()
;ShowDistance()
	call	SHOWDISTANCE
;Show ShowFuel
;Send a value just to show fuel bar
;ShowFuel ( CounterX  )
	movff	COUNTERX,VALUE
	movff	COUNTERX_H,VALUE_H
	call	SHOWFUEL
;End If
ENDIF4
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;End of Main loop
;End of 48x48 Tables
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

48X48EIGHTRLECOMPRESSED
	movlw	48
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLE48X48EIGHTRLECOMPRESSED
	movwf	TBLPTRL,ACCESS
	movlw	high TABLE48X48EIGHTRLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLE48X48EIGHTRLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLE48X48EIGHTRLECOMPRESSED
	db	48,6,255,32,31,6,255,4,0,6,255,32,0,6,255,4,0,6,255,32,248,6,255,4,0,6,255,32,0,6
	db	255,4,0,6,255,32,0,6,255,4,0,6,63,32,62,6,63,4

;********************************************************************************

48X48FIVERLECOMPRESSED
	movlw	40
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLE48X48FIVERLECOMPRESSED
	movwf	TBLPTRL,ACCESS
	movlw	high TABLE48X48FIVERLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLE48X48FIVERLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLE48X48FIVERLECOMPRESSED
	db	40,6,255,32,31,6,255,4,0,6,255,42,0,6,255,38,248,4,0,38,0,6,255,4,0,6,128,32,0,6
	db	255,4,0,6,63,32,62,6,63,4

;********************************************************************************

48X48FOURRLECOMPRESSED
	movlw	48
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLE48X48FOURRLECOMPRESSED
	movwf	TBLPTRL,ACCESS
	movlw	high TABLE48X48FOURRLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLE48X48FOURRLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLE48X48FOURRLECOMPRESSED
	db	48,6,255,1,7,30,0,1,7,6,255,4,0,6,255,32,0,6,255,4,0,6,255,32,248,6,255,4,0,38
	db	0,6,255,4,0,38,0,6,255,4,0,37,0,1,56,6,63,4

;********************************************************************************

48X48NINERLECOMPRESSED
	movlw	44
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLE48X48NINERLECOMPRESSED
	movwf	TBLPTRL,ACCESS
	movlw	high TABLE48X48NINERLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLE48X48NINERLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLE48X48NINERLECOMPRESSED
	db	44,6,255,32,31,6,255,4,0,6,255,32,0,6,255,4,0,6,255,32,248,6,255,4,0,38,0,6,255,4
	db	0,38,0,6,255,4,0,6,63,32,62,6,63,4

;********************************************************************************

48X48ONERLECOMPRESSED
	movlw	46
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLE48X48ONERLECOMPRESSED
	movwf	TBLPTRL,ACCESS
	movlw	high TABLE48X48ONERLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLE48X48ONERLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLE48X48ONERLECOMPRESSED
	db	46,26,0,1,120,1,124,1,126,6,255,13,0,29,0,6,255,13,0,29,0,6,255,13,0,29,0,6,255,13
	db	0,29,0,6,255,13,0,27,0,2,62,6,63,2,62,11

;********************************************************************************

48X48SEVENRLECOMPRESSED
	movlw	40
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLE48X48SEVENRLECOMPRESSED
	movwf	TBLPTRL,ACCESS
	movlw	high TABLE48X48SEVENRLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLE48X48SEVENRLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLE48X48SEVENRLECOMPRESSED
	db	40,6,63,32,31,6,255,4,0,38,0,6,255,4,0,38,0,6,255,4,0,38,0,6,255,4,0,38,0,6,255,4
	db	0,37,0,1,62,6,63,4

;********************************************************************************

48X48SIXRLECOMPRESSED
	movlw	42
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLE48X48SIXRLECOMPRESSED
	movwf	TBLPTRL,ACCESS
	movlw	high TABLE48X48SIXRLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLE48X48SIXRLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLE48X48SIXRLECOMPRESSED
	db	42,6,255,32,31,6,63,4,0,6,255,42,0,6,255,38,248,4,0,6,255,32,0,6,255,4,0,6,255,32
	db	0,6,255,4,0,6,63,32,62,6,63,4

;********************************************************************************

48X48THREERLECOMPRESSED
	movlw	36
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLE48X48THREERLECOMPRESSED
	movwf	TBLPTRL,ACCESS
	movlw	high TABLE48X48THREERLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLE48X48THREERLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLE48X48THREERLECOMPRESSED
	db	36,6,63,33,31,6,255,42,0,6,255,13,0,29,248,6,255,13,0,29,0,6,255,42,0,6,255,4,0,6
	db	63,32,62,6,63,4

;********************************************************************************

48X48TWORLECOMPRESSED
	movlw	40
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLE48X48TWORLECOMPRESSED
	movwf	TBLPTRL,ACCESS
	movlw	high TABLE48X48TWORLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLE48X48TWORLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLE48X48TWORLECOMPRESSED
	db	40,6,127,32,31,6,255,42,0,6,255,4,0,38,248,6,255,4,0,6,255,38,0,4,0,6,255,32,0,6
	db	128,4,0,6,63,32,62,6,63,4

;********************************************************************************

48X48ZERORLECOMPRESSED
	movlw	48
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLE48X48ZERORLECOMPRESSED
	movwf	TBLPTRL,ACCESS
	movlw	high TABLE48X48ZERORLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLE48X48ZERORLECOMPRESSED
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLE48X48ZERORLECOMPRESSED
	db	48,6,255,32,31,6,255,4,0,6,255,32,0,6,255,4,0,6,255,32,0,6,255,4,0,6,255,32,0,6
	db	255,4,0,6,255,32,0,6,255,4,0,6,63,32,62,6,63,4

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (1751)
BOX23
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF26
;GLCDTemp = LineX1
	movff	LINEX1,GLCDTEMP
	movff	LINEX1_H,GLCDTEMP_H
;LineX1 = LineX2
	movff	LINEX2,LINEX1
	movff	LINEX2_H,LINEX1_H
;LineX2 = GLCDTemp
	movff	GLCDTEMP,LINEX2
	movff	GLCDTEMP_H,LINEX2_H
;End If
ENDIF26
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF27
;GLCDTemp = LineY1
	movff	LINEY1,GLCDTEMP
	movff	LINEY1_H,GLCDTEMP_H
;LineY1 = LineY2
	movff	LINEY2,LINEY1
	movff	LINEY2_H,LINEY1_H
;LineY2 = GLCDTemp
	movff	GLCDTEMP,LINEY2
	movff	GLCDTEMP_H,LINEY2_H
;End If
ENDIF27
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
;Legacy method
	movlw	1
	subwf	LINEX1,W,ACCESS
	movwf	DRAWLINE,ACCESS
	movlw	0
	subwfb	LINEX1_H,W,ACCESS
	movwf	DRAWLINE_H,ACCESS
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
	incf	DRAWLINE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,ACCESS
;PSet DrawLine, LineY1, LineColour
	movff	DRAWLINE,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_KS0108
;PSet DrawLine, LineY2, LineColour
	movff	DRAWLINE,GLCDX
	movff	LINEY2,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_KS0108
;Next
	movff	DRAWLINE,SysWORDTempA
	movff	DRAWLINE_H,SysWORDTempA_H
	movff	LINEX2,SysWORDTempB
	movff	LINEX2_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;Draw lines going down
;For DrawLine = LineY1 To LineY2
;Legacy method
	movlw	1
	subwf	LINEY1,W,ACCESS
	movwf	DRAWLINE,ACCESS
	movlw	0
	subwfb	LINEY1_H,W,ACCESS
	movwf	DRAWLINE_H,ACCESS
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd7
SysForLoop7
	incf	DRAWLINE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,ACCESS
;PSet LineX1, DrawLine, LineColour
	movff	LINEX1,GLCDX
	movff	DRAWLINE,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_KS0108
;PSet LineX2, DrawLine, LineColour
	movff	LINEX2,GLCDX
	movff	DRAWLINE,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_KS0108
;Next
	movff	DRAWLINE,SysWORDTempA
	movff	DRAWLINE_H,SysWORDTempA_H
	movff	LINEY2,SysWORDTempB
	movff	LINEY2_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
	return

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

;Source: GaugeDemoForInvertCSxLines.gcb (217)
FAST_GLCDWRITEBYTE_KS0108
;Manage X Y
;If _GLCDX MOD 48 = 0 then
	movff	_GLCDX,SysBYTETempA
	movlw	48
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempX,SysTemp3
	movff	SysTemp3,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	call	SYSCOMPEQUAL
	btfsc	SysByteTempX,0,ACCESS
;Reset the X position
;_GLCDX = 0
	clrf	_GLCDX,BANKED
;End If
;Select the correct IC
;If _GLCDX + _XPOS < 64 Then
	movf	_XPOS,W,BANKED
	addwf	_GLCDX,W,BANKED
	movwf	SysTemp3,BANKED
	movff	SysTemp3,SysBYTETempA
	movlw	64
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE90_1
;Set GLCD_CS1 On
	bsf	LATB,5,ACCESS
;Set GLCD_CS2 Off
	bcf	LATB,4,ACCESS
;Else
	bra	ENDIF90
ELSE90_1
;Set GLCD_CS1 Off
	bcf	LATB,5,ACCESS
;Set GLCD_CS2 On
	bsf	LATB,4,ACCESS
;End If
ENDIF90
;Select page
;Set GLCD_RS Off
	bcf	LATB,3,ACCESS
;GLCDWriteByte b'10111000' Or ( _GLCDY + _YPOS ) / 8
	movf	_YPOS,W,BANKED
	addwf	_GLCDY,W,BANKED
	movwf	SysTemp3,BANKED
	movff	SysTemp3,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movlw	184
	iorwf	SysBYTETempA,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	GLCDWRITEBYTE_KS0108
;Select column
;Set GLCD_RS Off
	bcf	LATB,3,ACCESS
;GLCDWriteByte 64 Or ( _GLCDX + _XPOS )
	movf	_XPOS,W,BANKED
	addwf	_GLCDX,W,BANKED
	movwf	SysTemp3,BANKED
	movlw	64
	iorwf	SysTemp3,W,BANKED
	movwf	LCDBYTE,ACCESS
	rcall	GLCDWRITEBYTE_KS0108
;Dummy read first
;Set GLCD_RS On
	bsf	LATB,3,ACCESS
;GLCDDataTemp = GLCDReadByte
	rcall	FN_GLCDREADBYTE_KS0108
	movff	GLCDREADBYTE_KS0108,GLCDDATATEMP
;Read current data
;Set GLCD_RS On
	bsf	LATB,3,ACCESS
;GLCDDataTemp = GLCDReadByte
	rcall	FN_GLCDREADBYTE_KS0108
	movff	GLCDREADBYTE_KS0108,GLCDDATATEMP
;ReSelect column
;Set GLCD_RS Off
	bcf	LATB,3,ACCESS
;GLCDWriteByte 64 Or ( _GLCDX + _XPOS )
	movf	_XPOS,W,BANKED
	addwf	_GLCDX,W,BANKED
	movwf	SysTemp3,BANKED
	movlw	64
	iorwf	SysTemp3,W,BANKED
	movwf	LCDBYTE,ACCESS
	rcall	GLCDWRITEBYTE_KS0108
;Increment X value
;_GLCDX++
	incf	_GLCDX,F,BANKED
;Increment Y value
;If _GLCDX = 47 Then _GLCDY = _GLCDY + 8
	movlw	47
	subwf	_GLCDX,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF91
;If _GLCDX = 47 Then _GLCDY = _GLCDY + 8
	movlw	8
	addwf	_GLCDY,F,BANKED
;If _GLCDX = 47 Then _GLCDY = _GLCDY + 8
ENDIF91
;Exit if nothing to send
;If GLCDDataTemp = GLCDData Then exit Sub
	movf	GLCDDATA,W,ACCESS
	subwf	GLCDDATATEMP,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;If GLCDDataTemp = GLCDData Then exit Sub
	return
;If GLCDDataTemp = GLCDData Then exit Sub
;Write data back
;Set GLCD_RS On
	bsf	LATB,3,ACCESS
;Set LCD data direction
;Set GLCD_RW Off
	bcf	LATC,7,ACCESS
;Set output data
;GLCD_DB7 = GLCDData.7
	bcf	LATD,7,ACCESS
	btfsc	GLCDDATA,7,ACCESS
	bsf	LATD,7,ACCESS
;GLCD_DB6 = GLCDData.6
	bcf	LATD,6,ACCESS
	btfsc	GLCDDATA,6,ACCESS
	bsf	LATD,6,ACCESS
;GLCD_DB5 = GLCDData.5
	bcf	LATD,5,ACCESS
	btfsc	GLCDDATA,5,ACCESS
	bsf	LATD,5,ACCESS
;GLCD_DB4 = GLCDData.4
	bcf	LATD,4,ACCESS
	btfsc	GLCDDATA,4,ACCESS
	bsf	LATD,4,ACCESS
;GLCD_DB3 = GLCDData.3
	bcf	LATD,3,ACCESS
	btfsc	GLCDDATA,3,ACCESS
	bsf	LATD,3,ACCESS
;GLCD_DB2 = GLCDData.2
	bcf	LATD,2,ACCESS
	btfsc	GLCDDATA,2,ACCESS
	bsf	LATD,2,ACCESS
;GLCD_DB1 = GLCDData.1
	bcf	LATD,1,ACCESS
	btfsc	GLCDDATA,1,ACCESS
	bsf	LATD,1,ACCESS
;GLCD_DB0 = GLCDData.0
	bcf	LATD,0,ACCESS
	btfsc	GLCDDATA,0,ACCESS
	bsf	LATD,0,ACCESS
;Write
;Wait KS0108WriteDelay us
	movlw	26
	movwf	DELAYTEMP,ACCESS
DelayUS6
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS6
	nop
;Set GLCD_ENABLE On
	bsf	LATB,2,ACCESS
;Wait KS0108ClockDelay us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS7
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS7
;Set GLCD_ENABLE Off
	bcf	LATB,2,ACCESS
;Wait KS0108WriteDelay us
	movlw	26
	movwf	DELAYTEMP,ACCESS
DelayUS8
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS8
	nop
;enable the wait here to show pixel draw
;wait 20 ms
	return

;********************************************************************************

;Source: glcd_ks0108.h (198)
FILLEDBOX_KS0108
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movf	LINEX1,W,ACCESS
	subwf	LINEX2,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF37
;GLCDTemp = LineX1
	movff	LINEX1,GLCDTEMP
;LineX1 = LineX2
	movff	LINEX2,LINEX1
;LineX2 = GLCDTemp
	movff	GLCDTEMP,LINEX2
;End If
ENDIF37
;If LineY1 > LineY2 Then
	movf	LINEY1,W,ACCESS
	subwf	LINEY2,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF38
;GLCDTemp = LineY1
	movff	LINEY1,GLCDTEMP
;LineY1 = LineY2
	movff	LINEY2,LINEY1
;LineY2 = GLCDTemp
	movff	GLCDTEMP,LINEY2
;End If
ENDIF38
;Draw lines going across
;For DrawLine = LineX1 To LineX2
;Legacy method
	decf	LINEX1,W,ACCESS
	movwf	DRAWLINE,ACCESS
	movf	LINEX1,W,ACCESS
	subwf	LINEX2,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd8
SysForLoop8
	incf	DRAWLINE,F,ACCESS
;For GLCDTemp = LineY1 To LineY2
;Legacy method
	decf	LINEY1,W,ACCESS
	movwf	GLCDTEMP,ACCESS
	movf	LINEY1,W,ACCESS
	subwf	LINEY2,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd9
SysForLoop9
	incf	GLCDTEMP,F,ACCESS
;PSet DrawLine, GLCDTemp, LineColour
	movff	DRAWLINE,GLCDX
	movff	GLCDTEMP,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_KS0108
;Next
	movf	LINEY2,W,ACCESS
	subwf	GLCDTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
;Next
	movf	LINEX2,W,ACCESS
	subwf	DRAWLINE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop8
SysForLoopEnd8
	return

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
SysForLoop10
	incf	GLCD_COUNT,F,ACCESS
;For CurrPage = 0 to 7
;Legacy method
	setf	CURRPAGE,ACCESS
SysForLoop11
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
SysForLoop12
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
	bra	SysForLoop12
SysForLoopEnd12
;Next
	movlw	7
	subwf	CURRPAGE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop11
SysForLoopEnd11
;Set GLCD_CS1 On
	bsf	LATB,5,ACCESS
;Set GLCD_CS2 Off
	bcf	LATB,4,ACCESS
;next
	movlw	2
	subwf	GLCD_COUNT,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
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
	call	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF16
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 0
	clrf	GLCDFOREGROUND,ACCESS
	clrf	GLCDFOREGROUND_H,ACCESS
;end if
ENDIF16
;dim CharCol, CharRow as word
;CharCode -= 15
	movlw	15
	subwf	CHARCODE,F,ACCESS
;CharCol=0
	clrf	CHARCOL,ACCESS
	clrf	CHARCOL_H,ACCESS
;Calculate the pointer to the OLED fonts.
;These fonts are not multiple tables one is a straight list the other is a lookup table with data.
;Dim LocalCharCode as word
;Get key information and set up the fonts parameters
;Select case GLCDfntDefaultSize
;case 1 'This font is two font tables of an index and data
SysSelect2Case1
	decf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;CharCode = CharCode - 16
	movlw	16
	subwf	CHARCODE,F,ACCESS
;ReadTable OLEDFont1Index, CharCode, LocalCharCode
	movff	CHARCODE,SYSSTRINGA
	call	OLEDFONT1INDEX
	movwf	LOCALCHARCODE,ACCESS
	movff	CHARCODE,SYSSTRINGA
	call	OLEDFONT1INDEX_H
	movwf	LOCALCHARCODE_H,ACCESS
;ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	call	OLEDFONT1DATA
	movwf	COLSPERFONT,ACCESS
;GLCDFontWidth = COLSperfont + 1
	incf	COLSPERFONT,W,ACCESS
	movwf	GLCDFONTWIDTH,ACCESS
;if LocalCharCode = 1 then
	movff	LOCALCHARCODE,SysWORDTempA
	movff	LOCALCHARCODE_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE17_1
;GLCDFontWidth = 1
	movlw	1
	movwf	GLCDFONTWIDTH,ACCESS
;else
	bra	ENDIF17
ELSE17_1
;GLCDFontWidth = COLSperfont+1
	incf	COLSPERFONT,W,ACCESS
	movwf	GLCDFONTWIDTH,ACCESS
;end if
ENDIF17
;ROWSperfont = 7
	movlw	7
	movwf	ROWSPERFONT,BANKED
;case 2 'This is one font table
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
;CharCode = CharCode - 17
	movlw	17
	subwf	CHARCODE,F,ACCESS
;Pointer to table of font elements
;LocalCharCode = (CharCode * 20)
	movff	CHARCODE,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	movlw	20
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSMULTSUB16
	movff	SysWORDTempX,LOCALCHARCODE
	movff	SysWORDTempX_H,LOCALCHARCODE_H
;COLSperfont = 9  'which is really 10 as we start at 0
	movlw	9
	movwf	COLSPERFONT,ACCESS
;ROWSperfont=15  'which is really 16 as we start at 0
	movlw	15
	movwf	ROWSPERFONT,BANKED
;End Select
SysSelectEnd2
;The main loop - loop throught the number of columns
;For CurrCharCol = 0 to COLSperfont  'number of columns in the font , with two row of data
;Legacy method
	setf	CURRCHARCOL,ACCESS
	movlw	0
	subwf	COLSPERFONT,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
	incf	CURRCHARCOL,F,ACCESS
;Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
;LocalCharCode++
	incf	LOCALCHARCODE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	LOCALCHARCODE_H,F,ACCESS
;Select case GLCDfntDefaultSize
;case 1
SysSelect3Case1
	decf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	call	OLEDFONT1DATA
	movwf	CURRCHARVAL,ACCESS
;case 2
	bra	SysSelectEnd3
SysSelect3Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd3
;Read this 20 times... (0..COLSperfont) [ * 2 ]
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	call	OLEDFONT2
	movwf	CURRCHARVAL,ACCESS
;End Select
SysSelectEnd3
;we handle 8 or 16 pixels of height
;For CurrCharRow = 0 to ROWSperfont
;Legacy method
	setf	CURRCHARROW,ACCESS
	movlw	0
	subwf	ROWSPERFONT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
	incf	CURRCHARROW,F,ACCESS
;Set the pixel
;If CurrCharVal.0 = 0 Then
	btfsc	CURRCHARVAL,0,ACCESS
	bra	ELSE20_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBackground
	movf	CURRCHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDX,ACCESS
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	call	PSET_KS0108
;Else
	bra	ENDIF20
ELSE20_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, LineColour
	movf	CURRCHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDX,ACCESS
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	GLCDY,ACCESS
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_KS0108
;End If
ENDIF20
;Rotate CurrCharVal Right
	rrcf	CURRCHARVAL,F,ACCESS
;Set to next row of date, a second row
;if GLCDfntDefaultSize = 2 and CurrCharRow = 7 then
	movff	GLCDFNTDEFAULTSIZE,SysBYTETempA
	movlw	2
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPEQUAL
	movff	SysByteTempX,SysTemp3
	movff	CURRCHARROW,SysBYTETempA
	movlw	7
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPEQUAL
	movf	SysTemp3,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	ENDIF21
;LocalCharCode++
	incf	LOCALCHARCODE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	LOCALCHARCODE_H,F,ACCESS
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	call	OLEDFONT2
	movwf	CURRCHARVAL,ACCESS
;end if
ENDIF21
;It is the intercharacter space, put out one pixel row
;if CurrCharCol = COLSperfont then
	movf	COLSPERFONT,W,ACCESS
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF22
;Put out a white intercharacter pixel/space
;GLCDTemp = CharLocX + CurrCharCol
	movf	CURRCHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDTEMP,ACCESS
;if GLCDfntDefaultSize = 2 then
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;GLCDTemp++
	incf	GLCDTEMP,F,ACCESS
;end if
;PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBackground
	movff	GLCDTEMP,GLCDX
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	GLCDY,ACCESS
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	call	PSET_KS0108
;end if
ENDIF22
;Next
	movf	ROWSPERFONT,W,BANKED
	subwf	CURRCHARROW,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;Next
	movf	COLSPERFONT,W,ACCESS
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
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
GLCDPRINT11
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
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	movff	GLCDFONTWIDTH,OLDGLCDFONTWIDTH
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
	bra	SysForLoopEnd2
SysForLoop2
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
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movffl	PRODL,SysTemp2
	movf	SysTemp2,W,BANKED
	addwf	GLCDPRINTLOC,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	GLCDPRINTLOC_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	subwf	SysTemp2,W,BANKED
	movwf	GLCDPRINTLOC,ACCESS
	movlw	0
	subwfb	SysTemp2_H,W,BANKED
	movwf	GLCDPRINTLOC_H,ACCESS
;Next
	movf	GLCDPRINTLEN,W,ACCESS
	subwf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
;GLCDFontWidth = OldGLCDFontWidth
	movff	OLDGLCDFONTWIDTH,GLCDFONTWIDTH
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:LONG:, Source: glcd.h (1356)
GLCDPRINT14
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	clrf	SYSPRINTBUFFLEN,BANKED
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	movff	GLCDFONTWIDTH,OLDGLCDFONTWIDTH
;Do
SysDoLoop_S3
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
	call	SYSDIVSUB32
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
	call	SYSCOMPEQUAL32
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
	bra	SysDoLoop_S3
SysDoLoop_E3
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
	bra	SysForLoopEnd3
SysForLoop3
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
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W,ACCESS
	mulwf	GLCDFNTDEFAULTSIZE,ACCESS
	movffl	PRODL,SysTemp3
	movf	SysTemp3,W,BANKED
	addwf	GLCDPRINTLOC,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	GLCDPRINTLOC_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movf	GLCDFNTDEFAULTSIZE,W,ACCESS
	addwf	SysTemp2,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	movwf	GLCDPRINTLOC,ACCESS
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	GLCDPRINTLOC_H,ACCESS
;Next
	movf	GLCDPRINT_STRING_COUNTER,W,ACCESS
	sublw	1
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
;GLCDFontWidth = OldGLCDFontWidth
	movff	OLDGLCDFONTWIDTH,GLCDFONTWIDTH
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
	movlw	26
	movwf	DELAYTEMP,ACCESS
DelayUS4
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS4
	nop
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
	movlw	26
	movwf	DELAYTEMP,ACCESS
DelayUS5
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS5
	nop
	return

;********************************************************************************

;Source: glcd_ks0108.h (303)
GLCDWRITEBYTE_KS0108
;Dim GLCDSaveRS As Bit
;Dim GLCDSaveCS2 As Bit
;Wait until LCD is available
;GLCDSaveRS = GLCD_RS
	bcf	SYSBITVAR0,0,BANKED
	btfsc	PORTB,3,ACCESS
	bsf	SYSBITVAR0,0,BANKED
;GLCDSaveCS2 = GLCD_CS2
	bcf	SYSBITVAR0,1,BANKED
	btfsc	PORTB,4,ACCESS
	bsf	SYSBITVAR0,1,BANKED
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
	btfsc	SYSBITVAR0,0,BANKED
	bsf	LATB,3,ACCESS
;GLCD_CS2 = GLCDSaveCS2
	bcf	LATB,4,ACCESS
	btfsc	SYSBITVAR0,1,BANKED
	bsf	LATB,4,ACCESS
;Set LCD data direction
;Set GLCD_RW Off
	bcf	LATC,7,ACCESS
;Set data pin directions
;DIR GLCD_DB0 OUT
	bcf	TRISD,0,ACCESS
;DIR GLCD_DB1 OUT
	bcf	TRISD,1,ACCESS
;DIR GLCD_DB2 OUT
	bcf	TRISD,2,ACCESS
;DIR GLCD_DB3 OUT
	bcf	TRISD,3,ACCESS
;DIR GLCD_DB4 OUT
	bcf	TRISD,4,ACCESS
;DIR GLCD_DB5 OUT
	bcf	TRISD,5,ACCESS
;DIR GLCD_DB6 OUT
	bcf	TRISD,6,ACCESS
;DIR GLCD_DB7 OUT
	bcf	TRISD,7,ACCESS
;Set output data
;GLCD_DB7 = LCDByte.7
	bcf	LATD,7,ACCESS
	btfsc	LCDBYTE,7,ACCESS
	bsf	LATD,7,ACCESS
;GLCD_DB6 = LCDByte.6
	bcf	LATD,6,ACCESS
	btfsc	LCDBYTE,6,ACCESS
	bsf	LATD,6,ACCESS
;GLCD_DB5 = LCDByte.5
	bcf	LATD,5,ACCESS
	btfsc	LCDBYTE,5,ACCESS
	bsf	LATD,5,ACCESS
;GLCD_DB4 = LCDByte.4
	bcf	LATD,4,ACCESS
	btfsc	LCDBYTE,4,ACCESS
	bsf	LATD,4,ACCESS
;GLCD_DB3 = LCDByte.3
	bcf	LATD,3,ACCESS
	btfsc	LCDBYTE,3,ACCESS
	bsf	LATD,3,ACCESS
;GLCD_DB2 = LCDByte.2
	bcf	LATD,2,ACCESS
	btfsc	LCDBYTE,2,ACCESS
	bsf	LATD,2,ACCESS
;GLCD_DB1 = LCDByte.1
	bcf	LATD,1,ACCESS
	btfsc	LCDBYTE,1,ACCESS
	bsf	LATD,1,ACCESS
;GLCD_DB0 = LCDByte.0
	bcf	LATD,0,ACCESS
	btfsc	LCDBYTE,0,ACCESS
	bsf	LATD,0,ACCESS
;Write
;Wait KS0108WriteDelay us
	movlw	26
	movwf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
	nop
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
	movlw	26
	movwf	DELAYTEMP,ACCESS
DelayUS3
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS3
	nop
	return

;********************************************************************************

;Source: GaugeDemoForInvertCSxLines.gcb (301)
GLCD_DRAW48X48
;Dim Dataptr, adcval as Word
;Dim myNum as Integer
;Dim Dataptr as Word
;Dim _GLCDY, _GLCDX, GLCDDataTemp, GLCDData, _XPOS, _YPOS
;Dim swval, swcache, swprev as Integer
;Dataptr = 1
	movlw	1
	movwf	DATAPTR,ACCESS
	clrf	DATAPTR_H,ACCESS
;swcache = -1
	setf	SWCACHE,BANKED
	setf	SWCACHE_H,BANKED
;swval = -1
	setf	SWVAL,BANKED
	setf	SWVAL_H,BANKED
;swprev = -1
	setf	SWPREV,BANKED
	setf	SWPREV_H,BANKED
;_GLCDX = 0  // to 47 step 1
	clrf	_GLCDX,BANKED
;_GLCDY = 0
	clrf	_GLCDY,BANKED
;Do while swval <> 0
SysDoLoop_S2
	movff	swval,SysINTEGERTempA
	movff	swval_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E2
;Select Case _Num
;Case -1
SysSelect1Case1
	movff	_NUM,SysINTEGERTempA
	movff	_NUM_H,SysINTEGERTempA_H
	setf	SysINTEGERTempB,ACCESS
	setf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case2
;swval = 288
	movlw	32
	movwf	SWVAL,BANKED
	movlw	1
	movwf	SWVAL_H,BANKED
;GLCDData = 0
	clrf	GLCDDATA,ACCESS
;Case 0
	bra	SysSelectEnd1
SysSelect1Case2
	movff	_NUM,SysINTEGERTempA
	movff	_NUM_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case3
;ReadTable 48x48ZeroRLECompressed, Dataptr, swval
	movff	DATAPTR,SYSSTRINGA
	rcall	48X48ZERORLECOMPRESSED
	movwf	SWVAL,BANKED
	clrf	SWVAL_H,BANKED
;ReadTable 48x48ZeroRLECompressed, Dataptr+1, GLCDData
	incf	DATAPTR,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	rcall	48X48ZERORLECOMPRESSED
	movwf	GLCDDATA,ACCESS
;Case 1
	bra	SysSelectEnd1
SysSelect1Case3
	movff	_NUM,SysINTEGERTempA
	movff	_NUM_H,SysINTEGERTempA_H
	movlw	1
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case4
;ReadTable 48x48OneRLECompressed, Dataptr, swval
	movff	DATAPTR,SYSSTRINGA
	call	48X48ONERLECOMPRESSED
	movwf	SWVAL,BANKED
	clrf	SWVAL_H,BANKED
;ReadTable 48x48OneRLECompressed, Dataptr+1, GLCDData
	incf	DATAPTR,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	call	48X48ONERLECOMPRESSED
	movwf	GLCDDATA,ACCESS
;Case 2
	bra	SysSelectEnd1
SysSelect1Case4
	movff	_NUM,SysINTEGERTempA
	movff	_NUM_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case5
;ReadTable 48x48TwoRLECompressed, Dataptr, swval
	movff	DATAPTR,SYSSTRINGA
	call	48X48TWORLECOMPRESSED
	movwf	SWVAL,BANKED
	clrf	SWVAL_H,BANKED
;ReadTable 48x48TwoRLECompressed, Dataptr+1, GLCDData
	incf	DATAPTR,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	call	48X48TWORLECOMPRESSED
	movwf	GLCDDATA,ACCESS
;Case 3
	bra	SysSelectEnd1
SysSelect1Case5
	movff	_NUM,SysINTEGERTempA
	movff	_NUM_H,SysINTEGERTempA_H
	movlw	3
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case6
;ReadTable 48x48ThreeRLECompressed, Dataptr, swval
	movff	DATAPTR,SYSSTRINGA
	call	48X48THREERLECOMPRESSED
	movwf	SWVAL,BANKED
	clrf	SWVAL_H,BANKED
;ReadTable 48x48ThreeRLECompressed, Dataptr+1, GLCDData
	incf	DATAPTR,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	call	48X48THREERLECOMPRESSED
	movwf	GLCDDATA,ACCESS
;Case 4
	bra	SysSelectEnd1
SysSelect1Case6
	movff	_NUM,SysINTEGERTempA
	movff	_NUM_H,SysINTEGERTempA_H
	movlw	4
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case7
;ReadTable 48x48FourRLECompressed, Dataptr, swval
	movff	DATAPTR,SYSSTRINGA
	call	48X48FOURRLECOMPRESSED
	movwf	SWVAL,BANKED
	clrf	SWVAL_H,BANKED
;ReadTable 48x48FourRLECompressed, Dataptr+1, GLCDData
	incf	DATAPTR,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	call	48X48FOURRLECOMPRESSED
	movwf	GLCDDATA,ACCESS
;Case 5
	bra	SysSelectEnd1
SysSelect1Case7
	movff	_NUM,SysINTEGERTempA
	movff	_NUM_H,SysINTEGERTempA_H
	movlw	5
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case8
;ReadTable 48x48FiveRLECompressed, Dataptr, swval
	movff	DATAPTR,SYSSTRINGA
	call	48X48FIVERLECOMPRESSED
	movwf	SWVAL,BANKED
	clrf	SWVAL_H,BANKED
;ReadTable 48x48FiveRLECompressed, Dataptr+1, GLCDData
	incf	DATAPTR,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	call	48X48FIVERLECOMPRESSED
	movwf	GLCDDATA,ACCESS
;Case 6
	bra	SysSelectEnd1
SysSelect1Case8
	movff	_NUM,SysINTEGERTempA
	movff	_NUM_H,SysINTEGERTempA_H
	movlw	6
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case9
;ReadTable 48x48SixRLECompressed, Dataptr, swval
	movff	DATAPTR,SYSSTRINGA
	call	48X48SIXRLECOMPRESSED
	movwf	SWVAL,BANKED
	clrf	SWVAL_H,BANKED
;ReadTable 48x48SixRLECompressed, Dataptr+1, GLCDData
	incf	DATAPTR,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	call	48X48SIXRLECOMPRESSED
	movwf	GLCDDATA,ACCESS
;Case 7
	bra	SysSelectEnd1
SysSelect1Case9
	movff	_NUM,SysINTEGERTempA
	movff	_NUM_H,SysINTEGERTempA_H
	movlw	7
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case10
;ReadTable 48x48SevenRLECompressed, Dataptr, swval
	movff	DATAPTR,SYSSTRINGA
	call	48X48SEVENRLECOMPRESSED
	movwf	SWVAL,BANKED
	clrf	SWVAL_H,BANKED
;ReadTable 48x48SevenRLECompressed, Dataptr+1, GLCDData
	incf	DATAPTR,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	call	48X48SEVENRLECOMPRESSED
	movwf	GLCDDATA,ACCESS
;Case 8
	bra	SysSelectEnd1
SysSelect1Case10
	movff	_NUM,SysINTEGERTempA
	movff	_NUM_H,SysINTEGERTempA_H
	movlw	8
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case11
;ReadTable 48x48EightRLECOmpressed, Dataptr, swval
	movff	DATAPTR,SYSSTRINGA
	call	48X48EIGHTRLECOMPRESSED
	movwf	SWVAL,BANKED
	clrf	SWVAL_H,BANKED
;ReadTable 48x48EightRLECOmpressed, Dataptr+1, GLCDData
	incf	DATAPTR,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	call	48X48EIGHTRLECOMPRESSED
	movwf	GLCDDATA,ACCESS
;Case 9
	bra	SysSelectEnd1
SysSelect1Case11
	movff	_NUM,SysINTEGERTempA
	movff	_NUM_H,SysINTEGERTempA_H
	movlw	9
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case12
;ReadTable 48x48NineRLECompressed, Dataptr, swval
	movff	DATAPTR,SYSSTRINGA
	call	48X48NINERLECOMPRESSED
	movwf	SWVAL,BANKED
	clrf	SWVAL_H,BANKED
;ReadTable 48x48NineRLECompressed, Dataptr+1, GLCDData
	incf	DATAPTR,W,ACCESS
	movwf	SYSSTRINGA,ACCESS
	call	48X48NINERLECOMPRESSED
	movwf	GLCDDATA,ACCESS
;Case Else
	bra	SysSelectEnd1
SysSelect1Case12
;Exit Do
	bra	SysDoLoop_E2
;End Select
SysSelectEnd1
;increment table pointer
;Dataptr = Dataptr + 2
	movlw	2
	addwf	DATAPTR,F,ACCESS
	movlw	0
	addwfc	DATAPTR_H,F,ACCESS
;Repeat swval
	movff	SWVAL,SysRepeatTemp1
	movff	SWVAL_H,SysRepeatTemp1_H
	movff	SYSREPEATTEMP1,SysINTEGERTempA
	movff	SYSREPEATTEMP1_H,SysINTEGERTempA_H
	movlw	1
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPLESSTHANINT
	btfsc	SysByteTempX,0,ACCESS
	bra	SysRepeatLoopEnd1
	movf	SYSREPEATTEMP1,F,BANKED
	btfss	STATUS, Z,ACCESS
	incf	SysRepeatTemp1_H,F,BANKED
SysRepeatLoop1
;Fast_GLCDWriteByte_KS0108 GLCDData
	call	FAST_GLCDWRITEBYTE_KS0108
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
	decfsz	SysRepeatTemp1_H,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;Force an exit from the DO - this must be a CLEAR Char or -1
;If swval = 288 then swval = 0
	movff	SWVAL,SysINTEGERTempA
	movff	SWVAL_H,SysINTEGERTempA_H
	movlw	32
	movwf	SysINTEGERTempB,ACCESS
	movlw	1
	movwf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF10
;If swval = 288 then swval = 0
	clrf	SWVAL,BANKED
	clrf	SWVAL_H,BANKED
;If swval = 288 then swval = 0
ENDIF10
;Loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;Set GLCD_CS1 On
	bsf	LATB,5,ACCESS
;Set GLCD_CS2 On
	bsf	LATB,4,ACCESS
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

;Source: glcd.h (2051)
LINE
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	clrf	LINEDIFFX,ACCESS
	clrf	LINEDIFFX_H,ACCESS
;LineDiffY = 0
	clrf	LINEDIFFY,ACCESS
	clrf	LINEDIFFY_H,ACCESS
;LineStepX = 0
	clrf	LINESTEPX,ACCESS
	clrf	LINESTEPX_H,ACCESS
;LineStepY = 0
	clrf	LINESTEPY,ACCESS
	clrf	LINESTEPY_H,ACCESS
;LineDiffX_x2 = 0
	clrf	LINEDIFFX_X2,ACCESS
	clrf	LINEDIFFX_X2_H,ACCESS
;LineDiffY_x2 = 0
	clrf	LINEDIFFY_X2,ACCESS
	clrf	LINEDIFFY_X2_H,ACCESS
;LineErr = 0
	clrf	LINEERR,ACCESS
	clrf	LINEERR_H,ACCESS
;LineDiffX =  LineX2 -   LineX1
	movf	LINEX1,W,ACCESS
	subwf	LINEX2,W,ACCESS
	movwf	LINEDIFFX,ACCESS
	movf	LINEX1_H,W,ACCESS
	subwfb	LINEX2_H,W,ACCESS
	movwf	LINEDIFFX_H,ACCESS
;LineDiffY =  LineY2 -   LineY1
	movf	LINEY1,W,ACCESS
	subwf	LINEY2,W,ACCESS
	movwf	LINEDIFFY,ACCESS
	movf	LINEY1_H,W,ACCESS
	subwfb	LINEY2_H,W,ACCESS
	movwf	LINEDIFFY_H,ACCESS
;if (LineDiffX > 0) then
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	call	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE32_1
;LineStepX = 1
	movlw	1
	movwf	LINESTEPX,ACCESS
	clrf	LINESTEPX_H,ACCESS
;else
	bra	ENDIF32
ELSE32_1
;LineStepX = -1
	setf	LINESTEPX,ACCESS
	setf	LINESTEPX_H,ACCESS
;end if
ENDIF32
;if (LineDiffY > 0) then
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	call	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE33_1
;LineStepY = 1
	movlw	1
	movwf	LINESTEPY,ACCESS
	clrf	LINESTEPY_H,ACCESS
;else
	bra	ENDIF33
ELSE33_1
;LineStepY = -1
	setf	LINESTEPY,ACCESS
	setf	LINESTEPY_H,ACCESS
;end if
ENDIF33
;LineDiffX = LineStepX * LineDiffX
	movff	LINESTEPX,SysINTEGERTempA
	movff	LINESTEPX_H,SysINTEGERTempA_H
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,LINEDIFFX
	movff	SysINTEGERTempX_H,LINEDIFFX_H
;LineDiffY = LineStepY * LineDiffY
	movff	LINESTEPY,SysINTEGERTempA
	movff	LINESTEPY_H,SysINTEGERTempA_H
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,LINEDIFFY
	movff	SysINTEGERTempX_H,LINEDIFFY_H
;LineDiffX_x2 = LineDiffX*2
	movff	LINEDIFFX,SysINTEGERTempA
	movff	LINEDIFFX_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,LINEDIFFX_X2
	movff	SysINTEGERTempX_H,LINEDIFFX_X2_H
;LineDiffY_x2 = LineDiffY*2
	movff	LINEDIFFY,SysINTEGERTempA
	movff	LINEDIFFY_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSMULTSUBINT
	movff	SysINTEGERTempX,LINEDIFFY_X2
	movff	SysINTEGERTempX_H,LINEDIFFY_X2_H
;if ( LineDiffX >= LineDiffY) then
	movff	LINEDIFFX,SysINTEGERTempA
	movff	LINEDIFFX_H,SysINTEGERTempA_H
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	call	SYSCOMPLESSTHANINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE34_1
;LineErr = LineDiffY_x2 - LineDiffX
	movf	LINEDIFFX,W,ACCESS
	subwf	LINEDIFFY_X2,W,ACCESS
	movwf	LINEERR,ACCESS
	movf	LINEDIFFX_H,W,ACCESS
	subwfb	LINEDIFFY_X2_H,W,ACCESS
	movwf	LINEERR_H,ACCESS
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S4
	movff	linex1,SysWORDTempA
	movff	linex1_H,SysWORDTempA_H
	movff	linex2,SysWORDTempB
	movff	linex2_H,SysWORDTempB_H
	call	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E4
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_KS0108
;LineX1 += LineStepX
	movf	LINESTEPX,W,ACCESS
	addwf	LINEX1,F,ACCESS
	movf	LINESTEPX_H,W,ACCESS
	addwfc	LINEX1_H,F,ACCESS
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE35_1
;LineErr += LineDiffY_x2
	movf	LINEDIFFY_X2,W,ACCESS
	addwf	LINEERR,F,ACCESS
	movf	LINEDIFFY_X2_H,W,ACCESS
	addwfc	LINEERR_H,F,ACCESS
;else
	bra	ENDIF35
ELSE35_1
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	movf	LINEDIFFX_X2,W,ACCESS
	subwf	LINEDIFFY_X2,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	LINEDIFFX_X2_H,W,ACCESS
	subwfb	LINEDIFFY_X2_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	SysTemp1,W,BANKED
	addwf	LINEERR,F,ACCESS
	movf	SysTemp1_H,W,BANKED
	addwfc	LINEERR_H,F,ACCESS
;LineY1 += LineStepY
	movf	LINESTEPY,W,ACCESS
	addwf	LINEY1,F,ACCESS
	movf	LINESTEPY_H,W,ACCESS
	addwfc	LINEY1_H,F,ACCESS
;end if
ENDIF35
;loop
	bra	SysDoLoop_S4
SysDoLoop_E4
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_KS0108
;else
	bra	ENDIF34
ELSE34_1
;LineErr = LineDiffX_x2 - LineDiffY
	movf	LINEDIFFY,W,ACCESS
	subwf	LINEDIFFX_X2,W,ACCESS
	movwf	LINEERR,ACCESS
	movf	LINEDIFFY_H,W,ACCESS
	subwfb	LINEDIFFX_X2_H,W,ACCESS
	movwf	LINEERR_H,ACCESS
;do while (   LineY1 <>  LineY2)
SysDoLoop_S5
	movff	liney1,SysWORDTempA
	movff	liney1_H,SysWORDTempA_H
	movff	liney2,SysWORDTempB
	movff	liney2_H,SysWORDTempB_H
	call	SYSCOMPEQUAL16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E5
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_KS0108
;LineY1 += LineStepY
	movf	LINESTEPY,W,ACCESS
	addwf	LINEY1,F,ACCESS
	movf	LINESTEPY_H,W,ACCESS
	addwfc	LINEY1_H,F,ACCESS
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE36_1
;LineErr += LineDiffX_x2
	movf	LINEDIFFX_X2,W,ACCESS
	addwf	LINEERR,F,ACCESS
	movf	LINEDIFFX_X2_H,W,ACCESS
	addwfc	LINEERR_H,F,ACCESS
;else
	bra	ENDIF36
ELSE36_1
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	movf	LINEDIFFY_X2,W,ACCESS
	subwf	LINEDIFFX_X2,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	LINEDIFFY_X2_H,W,ACCESS
	subwfb	LINEDIFFX_X2_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	SysTemp1,W,BANKED
	addwf	LINEERR,F,ACCESS
	movf	SysTemp1_H,W,BANKED
	addwfc	LINEERR_H,F,ACCESS
;LineX1 += LineStepX
	movf	LINESTEPX,W,ACCESS
	addwf	LINEX1,F,ACCESS
	movf	LINESTEPX_H,W,ACCESS
	addwfc	LINEX1_H,F,ACCESS
;end if
ENDIF36
;loop
	bra	SysDoLoop_S5
SysDoLoop_E5
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_KS0108
;end if
ENDIF34
	return

;********************************************************************************

OLEDFONT1DATA
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	165
	movwf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEOLEDFONT1DATA
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEOLEDFONT1DATA
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEOLEDFONT1DATA
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEOLEDFONT1DATA
	db	165,1,0,1,94,3,6,0,6,5,40,124,40,124,40,5,36,42,127,42,16,3,98,24,70,5,48,76,90,36
	db	80,1,6,2,60,66,2,66,60,5,40,16,124,16,40,3,16,56,16,1,192,3,16,16,16,1,64,3,96,24
	db	6,4,60,66,66,60,3,68,126,64,4,68,98,82,76,3,74,74,52,4,30,16,124,16,3,78,74,50
	db	4,60,74,74,48,3,98,18,14,4,52,74,74,52,4,12,82,82,60,1,72,2,128,104,3,16,40,68
	db	3,40,40,40,3,68,40,16,3,2,82,12,5,56,68,84,84,88,4,124,18,18,124,4,126,74,74,52
	db	4,60,66,66,36,4,126,66,66,60,3,126,74,74,3,126,10,10,4,60,66,82,52,4,126,8,8,126
	db	3,66,126,66,3,66,66,62,4,126,8,20,98,3,126,64,64,5,126,4,8,4,126,5,126,4,24,32
	db	126,4,60,66,66,60,4,126,18,18,12,4,60,66,66,188,4,126,18,18,108,4,68,74,74,48,3,2
	db	126,2,4,62,64,64,62,5,6,24,96,24,6,5,62,64,62,64,62,5,66,36,24,36,66,4,158,160
	db	160,126,4,98,82,74,70,2,126,66,3,6,24,96,2,66,126,3,32,16,32,4,128,128,128,128
	db	2,4,8,4,32,84,84,120,4,126,68,68,56,4,56,68,68,40,4,56,68,68,126,4,56,84,84,88
	db	2,124,10,4,152,164,164,124,4,126,4,4,120,1,122,2,64,58,4,126,16,40,68,1,126,5
	db	124,4,120,4,120,4,124,4,4,120,4,56,68,68,56,4,252,36,36,24,4,24,36,36,252,2,124,4
	db	4,72,84,84,32,3,4,62,68,4,60,64,64,60,5,12,48,64,48,12,5,60,64,60,64,60,5,68,40,16
	db	40,68,4,156,160,160,124,3,100,84,76,3,8,54,65,1,255,3,65,54,8,4,32,16,32,16,1

;********************************************************************************

OLEDFONT1DATA_H
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEOLEDFONT1DATA_H
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEOLEDFONT1DATA_H
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEOLEDFONT1DATA_H
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEOLEDFONT1DATA_H
	db	1

;********************************************************************************

OLEDFONT1INDEX
	movlw	97
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEOLEDFONT1INDEX
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEOLEDFONT1INDEX
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEOLEDFONT1INDEX
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEOLEDFONT1INDEX
	db	96,1,3,5,9,15,21,25,31,33,36,39,45,49,51,55,57,61,66,70,75,79,84,88,93,97,102,107
	db	109,112,116,120,124,128,134,139,144,149,154,158,162,167,172,176,180,185,189,195
	db	201,206,211,216,221,226,230,235,241,247,253,2,7,10,14,17,21,26,29,34,39,44,49,54
	db	57,62,67,69,72,77,79,85,90,95,100,105,108,113,117,122,128,134,140,145,149,153
	db	155,159,164

;********************************************************************************

OLEDFONT1INDEX_H
	movlw	97
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEOLEDFONT1INDEX_H
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEOLEDFONT1INDEX_H
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEOLEDFONT1INDEX_H
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEOLEDFONT1INDEX_H
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

;********************************************************************************

OLEDFONT2
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	145
	movwf	SysWORDTempB,ACCESS
	movlw	7
	movwf	SysWORDTempB_H,ACCESS
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEOLEDFONT2
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEOLEDFONT2
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEOLEDFONT2
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEOLEDFONT2
	db	147,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,254,27,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,1,32,25,160,7,120,1,38,25,160
	db	7,120,1,38,1,32,1,0,0,0,0,0,0,28,24,38,16,66,16,255,63,130,17,2,15,0,0,0,0,28
	db	16,34,8,34,4,34,3,156,0,64,14,48,17,8,17,4,17,2,14,0,7,128,8,92,16,98,16,162,17,50
	db	19,28,28,0,24,0,22,128,1,0,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224
	db	7,24,24,12,48,4,32,2,64,2,64,0,0,0,0,2,64,2,64,4,32,12,48,24,24,224,7,0,0,0,0,0
	db	0,0,0,8,0,24,0,240,0,78,0,240,0,24,0,8,0,0,0,0,0,0,2,0,2,0,2,0,2,224,31,0,2,0,2,0
	db	2,0,2,0,0,0,0,0,0,0,0,0,152,0,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0
	db	1,0,1,0,0,0,0,0,0,0,0,0,0,0,24,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,48,0,12,0,3,192
	db	0,48,0,12,0,2,0,0,0,0,0,240,3,12,12,2,16,2,16,2,16,12,12,240,3,0,0,0,0,0,0,4,16,4
	db	16,4,16,254,31,0,16,0,16,0,16,0,0,0,0,0,0,6,24,2,20,2,18,2,17,194,16,60,16,0,0,0
	db	0,0,0,0,0,0,0,2,16,66,16,66,16,66,16,188,15,0,0,0,0,0,0,0,3,192,2,32,2,24,2,4,2,254
	db	31,0,2,0,2,0,0,0,0,0,0,0,0,62,16,34,16,34,16,66,8,130,7,0,0,0,0,0,0,0,0,240,7,76
	db	8,34,16,34,16,34,16,66,8,128,7,0,0,0,0,0,0,2,0,2,24,2,7,194,0,50,0,10,0,6,0,0,0,0
	db	0,0,0,28,15,162,16,66,16,66,16,162,16,162,9,28,6,0,0,0,0,0,0,120,0,132,16,2,17,2
	db	17,2,17,132,12,248,3,0,0,0,0,0,0,0,0,0,0,96,24,96,24,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,96,152,96,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,3,128,4,128,4,64,8,64,8,32
	db	16,0,0,0,0,128,4,128,4,128,4,128,4,128,4,128,4,128,4,128,4,0,0,0,0,32,16,64,8,64
	db	8,128,4,128,4,0,3,0,3,0,0,0,0,0,0,14,0,2,0,2,27,130,0,66,0,38,0,28,0,0,0,0,0,240
	db	3,24,12,4,24,226,19,18,20,10,22,138,27,252,7,0,4,0,4,0,16,0,14,128,3,112,2,24,2,48
	db	2,192,2,0,3,0,12,0,16,0,0,248,31,136,16,136,16,136,16,136,16,72,17,48,14,0,0,0
	db	0,192,3,48,12,16,8,8,16,8,16,8,16,8,16,24,16,0,0,0,0,0,0,248,31,8,16,8,16,8,16,8
	db	16,16,8,224,7,0,0,0,0,0,0,248,31,8,17,8,17,8,17,8,17,8,17,8,16,0,0,0,0,0,0,248
	db	31,8,1,8,1,8,1,8,1,8,1,8,0,0,0,0,0,0,0,192,3,48,12,16,8,8,16,8,16,8,17,8,17,24
	db	31,0,0,0,0,248,31,0,1,0,1,0,1,0,1,0,1,248,31,0,0,0,0,0,0,8,16,8,16,8,16,248,31,8
	db	16,8,16,8,16,0,0,0,0,0,0,0,0,0,16,8,16,8,16,8,16,248,15,0,0,0,0,0,0,0,0,248,31,128
	db	0,128,1,64,2,32,4,16,4,8,8,0,16,0,0,0,0,248,31,0,16,0,16,0,16,0,16,0,16,0,16,0
	db	0,0,0,248,31,56,0,224,1,0,7,0,6,192,1,56,0,248,31,0,0,0,0,0,0,248,31,16,0,96,0,128
	db	1,0,6,0,8,248,31,0,0,0,0,0,0,224,7,16,8,8,16,8,16,8,16,8,16,16,8,224,7,0,0,0,0,248
	db	31,8,1,8,1,8,1,8,1,136,0,112,0,0,0,0,0,0,0,224,7,16,8,8,16,8,16,8,16,8,48,16,72,224
	db	71,0,0,0,0,248,31,8,1,8,1,8,3,136,4,112,8,0,16,0,0,0,0,0,0,112,24,72,16,136,16,136
	db	16,8,17,8,9,24,14,0,0,0,0,8,0,8,0,8,0,8,0,248,31,8,0,8,0,8,0,8,0,0,0,0,0,248,7,0
	db	24,0,16,0,16,0,16,0,8,248,7,0,0,0,0,8,0,48,0,192,1,0,6,0,24,0,24,0,7,192,0,48,0,8
	db	0,24,0,224,3,0,28,0,15,224,0,192,1,0,14,0,28,224,3,24,0,8,16,16,8,32,4,64,2,128
	db	1,128,1,64,2,32,4,16,8,8,16,8,0,16,0,96,0,128,0,0,31,128,0,64,0,32,0,16,0,8,0,0
	db	0,8,24,8,20,8,18,8,17,136,16,72,16,40,16,24,16,0,0,0,0,0,0,0,0,254,127,2,64,2
	db	64,2,64,2,64,0,0,0,0,0,0,2,0,12,0,48,0,192,0,0,3,0,12,0,48,0,64,0,0,0,0,2,64,2
	db	64,2,64,2,64,254,127,0,0,0,0,0,0,0,0,0,0,0,4,0,3,224,0,56,0,14,0,112,0,128,3,0
	db	4,0,0,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,0,0,0,0,0,0,0,1,0,2,0,0
	db	0,0,0,0,0,0,0,0,0,0,12,32,18,32,17,32,17,32,9,192,31,0,16,0,0,0,0,0,0,254,31,64
	db	8,32,16,32,16,32,16,96,8,128,7,0,0,0,0,0,0,128,7,64,8,32,16,32,16,32,16,32,16,32
	db	16,0,0,0,0,0,0,128,7,64,24,32,16,32,16,32,16,64,8,254,31,0,0,0,0,0,0,128,7,64,9,32
	db	17,32,17,32,17,32,17,192,17,0,0,0,0,0,0,32,0,32,0,252,31,36,0,34,0,34,0,34,0,34
	db	0,0,0,0,0,128,7,64,152,32,144,32,144,32,144,64,72,224,63,0,0,0,0,0,0,254,31,128
	db	0,64,0,32,0,32,0,32,0,192,31,0,0,0,0,0,0,32,0,32,0,38,0,230,31,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,128,32,128,32,128,38,128,230,127,0,0,0,0,0,0,0,0,0,0,254,31,0,1,0,3,128
	db	4,64,4,64,8,32,16,0,0,0,0,0,0,0,0,2,0,2,0,2,0,254,31,0,0,0,0,0,0,0,0,224,31,64
	db	0,32,0,32,0,192,31,64,0,32,0,32,0,192,31,0,0,0,0,224,31,192,0,64,0,32,0,32,0,32
	db	0,192,31,0,0,0,0,0,0,128,7,64,8,32,16,32,16,32,16,64,8,128,7,0,0,0,0,0,0,224
	db	255,64,8,32,16,32,16,32,16,96,8,128,7,0,0,0,0,0,0,128,7,64,24,32,16,32,16,32,16,64
	db	8,224,255,0,0,0,0,0,0,0,0,224,31,128,0,64,0,32,0,32,0,224,0,0,0,0,0,0,0,192,24,32
	db	17,32,17,32,18,32,18,32,12,0,0,0,0,0,0,0,0,32,0,32,0,248,15,32,16,32,16,32,16,32
	db	16,0,0,0,0,0,0,224,15,0,16,0,16,0,16,0,8,224,31,0,0,0,0,0,0,32,0,192,1,0,6,0,24,0
	db	16,0,12,0,3,192,0,32,0,0,0,96,0,128,7,0,24,0,14,192,1,128,1,0,14,0,24,128,7,96
	db	0,0,0,32,16,64,8,128,4,0,3,0,3,128,4,64,8,32,16,0,0,32,128,192,128,0,131,0,70,0
	db	56,0,24,0,6,0,1,192,0,32,0,0,0,32,16,32,24,32,20,32,18,32,17,160,16,96,16,32,16,0
	db	0,0,0,0,0,0,1,0,1,252,62,2,64,2,64,2,64,0,0,0,0,0,0,0,0,0,0,0,0,254,127,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,2,64,2,64,2,64,252,62,0,1,0,1,0,0,0,0,0,3,128,0,128,0,128,0,0
	db	1,0,1,0,2,0,2,0,2,128,1,0,0,128,31,192,16,32,16,16,16,32,16,192,16,128,31,0,0,0
	db	0,192,3,48,12,16,8,8,16,8,16,8,144,8,176,24,208

;********************************************************************************

OLEDFONT2_H
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLEOLEDFONT2_H
	movwf	TBLPTRL,ACCESS
	movlw	high TABLEOLEDFONT2_H
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLEOLEDFONT2_H
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLEOLEDFONT2_H
	db	7

;********************************************************************************

;Source: glcd_ks0108.h (227)
PSET_KS0108
;Dim GLCDDataTempCache as Byte
;Select screen half
;If GLCDX.6 = Off Then Set GLCD_CS2 Off:Set GLCD_CS1 On
	btfsc	GLCDX,6,ACCESS
	bra	ENDIF43
;If GLCDX.6 = Off Then Set GLCD_CS2 Off:Set GLCD_CS1 On
	bcf	LATB,4,ACCESS
;If GLCDX.6 = Off Then Set GLCD_CS2 Off:Set GLCD_CS1 On
	bsf	LATB,5,ACCESS
;If GLCDX.6 = Off Then Set GLCD_CS2 Off:Set GLCD_CS1 On
ENDIF43
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
	btfss	GLCDX,6,ACCESS
	bra	ENDIF44
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
	bcf	LATB,5,ACCESS
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
	movlw	64
	subwf	GLCDX,F,ACCESS
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
	bsf	LATB,4,ACCESS
;If GLCDX.6 = On Then Set GLCD_CS1 Off: GLCDX -= 64: Set GLCD_CS2 On
ENDIF44
;Select page
;CurrPage = GLCDY / 8
	movff	GLCDY,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempA,CURRPAGE
;Set GLCD_RS Off+
	bcf	LATB,3,ACCESS
;GLCDWriteByte b'10111000' Or CurrPage
	movlw	184
	iorwf	CURRPAGE,W,ACCESS
	movwf	LCDBYTE,ACCESS
	call	GLCDWRITEBYTE_KS0108
;Select column
;Set GLCD_RS Off
	bcf	LATB,3,ACCESS
;GLCDWriteByte 64 Or GLCDX
	movlw	64
	iorwf	GLCDX,W,ACCESS
	movwf	LCDBYTE,ACCESS
	call	GLCDWRITEBYTE_KS0108
;Dummy read first
;Set GLCD_RS On
	bsf	LATB,3,ACCESS
;GLCDDataTempCache = GLCDReadByte
	call	FN_GLCDREADBYTE_KS0108
	movff	GLCDREADBYTE_KS0108,GLCDDATATEMPCACHE
;Read current data
;Set GLCD_RS On
	bsf	LATB,3,ACCESS
;GLCDDataTempCache = GLCDReadByte
	call	FN_GLCDREADBYTE_KS0108
	movff	GLCDREADBYTE_KS0108,GLCDDATATEMPCACHE
;Change data to set/clear pixel
;GLCDBitNo = GLCDY And 7
	movlw	7
	andwf	GLCDY,W,ACCESS
	movwf	GLCDBITNO,ACCESS
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,ACCESS
	bra	ELSE45_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE,ACCESS
;Set C On
	bsf	STATUS,C,ACCESS
;Else
	bra	ENDIF45
ELSE45_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE,ACCESS
;Set C Off
	bcf	STATUS,C,ACCESS
;End If
ENDIF45
;Repeat GLCDBitNo
	movff	GLCDBITNO,SysRepeatTemp2
	movf	SYSREPEATTEMP2,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd2
SysRepeatLoop2
;Rotate GLCDChange Left
	rlcf	GLCDCHANGE,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,ACCESS
	bra	ELSE46_1
;GLCDDataTemp = GLCDDataTempCache And GLCDChange
	movf	GLCDDATATEMPCACHE,W,ACCESS
	andwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;Else
	bra	ENDIF46
ELSE46_1
;GLCDDataTemp = GLCDDataTempCache Or GLCDChange
	movf	GLCDDATATEMPCACHE,W,ACCESS
	iorwf	GLCDCHANGE,W,ACCESS
	movwf	GLCDDATATEMP,ACCESS
;End If
ENDIF46
;Optimised to only send data when it changes
;If GLCDDataTempCache <> GLCDDataTemp Then
	movf	GLCDDATATEMP,W,ACCESS
	subwf	GLCDDATATEMPCACHE,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF47
;Select correct column again
;Set GLCD_RS Off
	bcf	LATB,3,ACCESS
;GLCDWriteByte 64 Or GLCDX
	movlw	64
	iorwf	GLCDX,W,ACCESS
	movwf	LCDBYTE,ACCESS
	call	GLCDWRITEBYTE_KS0108
;Write data back
;Set GLCD_RS On
	bsf	LATB,3,ACCESS
;GLCDWriteByte GLCDDataTemp
	movff	GLCDDATATEMP,LCDBYTE
	call	GLCDWRITEBYTE_KS0108
;End If
ENDIF47
;Set GLCD_CS1 On
	bsf	LATB,5,ACCESS
;Set GLCD_CS2 On
	bsf	LATB,4,ACCESS
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2159)
FN_READAD78
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	movffl	ADREADPORT,ADPCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (635)
;Configure ANSELA/B/C/D @DebugADC_H
;Select Case ADReadPort
;Case 0: Set ANSELA.0 On
SysSelect4Case1
	movf	ADREADPORT,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
;Case 0: Set ANSELA.0 On
	banksel	ANSELA
	bsf	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	bra	SysSelectEnd4
SysSelect4Case2
	decf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
;Case 1: Set ANSELA.1 On
	banksel	ANSELA
	bsf	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	2
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case4
;Case 2: Set ANSELA.2 On
	banksel	ANSELA
	bsf	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	bra	SysSelectEnd4
SysSelect4Case4
	movlw	3
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case5
;Case 3: Set ANSELA.3 On
	banksel	ANSELA
	bsf	ANSELA,3,BANKED
;Case 4: Set ANSELA.4 ON
	bra	SysSelectEnd4
SysSelect4Case5
	movlw	4
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case6
;Case 4: Set ANSELA.4 ON
	banksel	ANSELA
	bsf	ANSELA,4,BANKED
;Case 5: Set ANSELA.5 On
	bra	SysSelectEnd4
SysSelect4Case6
	movlw	5
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case7
;Case 5: Set ANSELA.5 On
	banksel	ANSELA
	bsf	ANSELA,5,BANKED
;Case 6: Set ANSELA.6 On
	bra	SysSelectEnd4
SysSelect4Case7
	movlw	6
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case8
;Case 6: Set ANSELA.6 On
	banksel	ANSELA
	bsf	ANSELA,6,BANKED
;Case 7: Set ANSELA.7 On
	bra	SysSelectEnd4
SysSelect4Case8
	movlw	7
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case9
;Case 7: Set ANSELA.7 On
	banksel	ANSELA
	bsf	ANSELA,7,BANKED
;Case 8: Set ANSELB.0 On
	bra	SysSelectEnd4
SysSelect4Case9
	movlw	8
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case10
;Case 8: Set ANSELB.0 On
	banksel	ANSELB
	bsf	ANSELB,0,BANKED
;Case 9: Set ANSELB.1 On
	bra	SysSelectEnd4
SysSelect4Case10
	movlw	9
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case11
;Case 9: Set ANSELB.1 On
	banksel	ANSELB
	bsf	ANSELB,1,BANKED
;Case 10: Set ANSELB.2 On
	bra	SysSelectEnd4
SysSelect4Case11
	movlw	10
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case12
;Case 10: Set ANSELB.2 On
	banksel	ANSELB
	bsf	ANSELB,2,BANKED
;Case 11: Set ANSELB.3 On
	bra	SysSelectEnd4
SysSelect4Case12
	movlw	11
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case13
;Case 11: Set ANSELB.3 On
	banksel	ANSELB
	bsf	ANSELB,3,BANKED
;Case 12: Set ANSELB.4 On
	bra	SysSelectEnd4
SysSelect4Case13
	movlw	12
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case14
;Case 12: Set ANSELB.4 On
	banksel	ANSELB
	bsf	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	bra	SysSelectEnd4
SysSelect4Case14
	movlw	13
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case15
;Case 13: Set ANSELB.5 On
	banksel	ANSELB
	bsf	ANSELB,5,BANKED
;Case 14: Set ANSELB.6 On
	bra	SysSelectEnd4
SysSelect4Case15
	movlw	14
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case16
;Case 14: Set ANSELB.6 On
	banksel	ANSELB
	bsf	ANSELB,6,BANKED
;Case 15: Set ANSELB.7 On
	bra	SysSelectEnd4
SysSelect4Case16
	movlw	15
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case17
;Case 15: Set ANSELB.7 On
	banksel	ANSELB
	bsf	ANSELB,7,BANKED
;Case 16: Set ANSELC.0 On
	bra	SysSelectEnd4
SysSelect4Case17
	movlw	16
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case18
;Case 16: Set ANSELC.0 On
	banksel	ANSELC
	bsf	ANSELC,0,BANKED
;Case 17: Set ANSELC.1 On
	bra	SysSelectEnd4
SysSelect4Case18
	movlw	17
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case19
;Case 17: Set ANSELC.1 On
	banksel	ANSELC
	bsf	ANSELC,1,BANKED
;Case 18: Set ANSELC.2 On
	bra	SysSelectEnd4
SysSelect4Case19
	movlw	18
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case20
;Case 18: Set ANSELC.2 On
	banksel	ANSELC
	bsf	ANSELC,2,BANKED
;Case 19: Set ANSELC.3 On
	bra	SysSelectEnd4
SysSelect4Case20
	movlw	19
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case21
;Case 19: Set ANSELC.3 On
	banksel	ANSELC
	bsf	ANSELC,3,BANKED
;Case 20: Set ANSELC.4 On
	bra	SysSelectEnd4
SysSelect4Case21
	movlw	20
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case22
;Case 20: Set ANSELC.4 On
	banksel	ANSELC
	bsf	ANSELC,4,BANKED
;Case 21: Set ANSELC.5 On
	bra	SysSelectEnd4
SysSelect4Case22
	movlw	21
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case23
;Case 21: Set ANSELC.5 On
	banksel	ANSELC
	bsf	ANSELC,5,BANKED
;Case 22: Set ANSELC.6 On
	bra	SysSelectEnd4
SysSelect4Case23
	movlw	22
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case24
;Case 22: Set ANSELC.6 On
	banksel	ANSELC
	bsf	ANSELC,6,BANKED
;Case 23: Set ANSELC.7 On
	bra	SysSelectEnd4
SysSelect4Case24
	movlw	23
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case25
;Case 23: Set ANSELC.7 On
	banksel	ANSELC
	bsf	ANSELC,7,BANKED
;Case 24: Set ANSELD.0 On
	bra	SysSelectEnd4
SysSelect4Case25
	movlw	24
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case26
;Case 24: Set ANSELD.0 On
	banksel	ANSELD
	bsf	ANSELD,0,BANKED
;Case 25: Set ANSELD.1 On
	bra	SysSelectEnd4
SysSelect4Case26
	movlw	25
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case27
;Case 25: Set ANSELD.1 On
	banksel	ANSELD
	bsf	ANSELD,1,BANKED
;Case 26: Set ANSELD.2 On
	bra	SysSelectEnd4
SysSelect4Case27
	movlw	26
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case28
;Case 26: Set ANSELD.2 On
	banksel	ANSELD
	bsf	ANSELD,2,BANKED
;Case 27: Set ANSELD.3 On
	bra	SysSelectEnd4
SysSelect4Case28
	movlw	27
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case29
;Case 27: Set ANSELD.3 On
	banksel	ANSELD
	bsf	ANSELD,3,BANKED
;Case 28: Set ANSELD.4 On
	bra	SysSelectEnd4
SysSelect4Case29
	movlw	28
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case30
;Case 28: Set ANSELD.4 On
	banksel	ANSELD
	bsf	ANSELD,4,BANKED
;Case 29: Set ANSELD.5 On
	bra	SysSelectEnd4
SysSelect4Case30
	movlw	29
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case31
;Case 29: Set ANSELD.5 On
	banksel	ANSELD
	bsf	ANSELD,5,BANKED
;Case 30: Set ANSELD.6 On
	bra	SysSelectEnd4
SysSelect4Case31
	movlw	30
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case32
;Case 30: Set ANSELD.6 On
	banksel	ANSELD
	bsf	ANSELD,6,BANKED
;Case 31: Set ANSELD.7 On
	bra	SysSelectEnd4
SysSelect4Case32
	movlw	31
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case33
;Case 31: Set ANSELD.7 On
	banksel	ANSELD
	bsf	ANSELD,7,BANKED
;Case 32: Set ANSELE.0 On
	bra	SysSelectEnd4
SysSelect4Case33
	movlw	32
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case34
;Case 32: Set ANSELE.0 On
	banksel	ANSELE
	bsf	ANSELE,0,BANKED
;Case 33: Set ANSELE.1 On
	bra	SysSelectEnd4
SysSelect4Case34
	movlw	33
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case35
;Case 33: Set ANSELE.1 On
	banksel	ANSELE
	bsf	ANSELE,1,BANKED
;Case 34: Set ANSELE.2 On
	bra	SysSelectEnd4
SysSelect4Case35
	movlw	34
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd4
;Case 34: Set ANSELE.2 On
	banksel	ANSELE
	bsf	ANSELE,2,BANKED
;End Select  '*** ANSEL Bits should now be set ***
SysSelectEnd4
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
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
	bcf	ADCON0,ADFM0,BANKED
;Set ADFM0 OFF
	bcf	ADCON0,ADFM0,BANKED
;End if
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	movffl	ADREADPORT,ADPCH
;Enable AD Operations
;SET ADON ON
	bsf	ADCON0,ADON,BANKED
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US,ACCESS
	banksel	0
	call	Delay_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE,BANKED
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop2
	btfsc	ADCON0,GO_NOT_DONE,BANKED
	bra	SysWaitLoop2
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
;ANSELD = 0
	clrf	ANSELD,BANKED
;ANSELE = 0
	clrf	ANSELE,BANKED
;ReadAD = ADRESH
	movffl	ADRESH,READAD
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:integer:, Source: stdbasic.h (266)
FN_SCALE151
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	movf	L_FROMLOW,W,BANKED
	subwf	L_MAP,W,BANKED
	movwf	SysTemp2,BANKED
	movf	L_FROMLOW_H,W,BANKED
	subwfb	L_MAP_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movf	L_TOLOW,W,BANKED
	subwf	L_TOHIGH,W,BANKED
	movwf	SysTemp1,BANKED
	movf	L_TOLOW_H,W,BANKED
	subwfb	L_TOHIGH_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	SYSTEMP2,SysLONGTempA
	movff	SYSTEMP2_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	SYSTEMP1,SysLONGTempB
	movff	SYSTEMP1_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SYSMULTSUB32
	movff	SysLONGTempX,L_SYSCALCF
	movff	SysLONGTempX_H,L_SYSCALCF_H
	movff	SysLONGTempX_U,L_SYSCALCF_U
	movff	SysLONGTempX_E,L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	movf	L_FROMLOW,W,BANKED
	subwf	L_FROMHIGH,W,ACCESS
	movwf	L_SYSCALC,BANKED
	movf	L_FROMLOW_H,W,BANKED
	subwfb	L_FROMHIGH_H,W,ACCESS
	movwf	L_SYSCALC_H,BANKED
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
	movf	L_TOLOW,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movf	L_TOLOW_H,W,BANKED
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movf	L_CALIBRATE,W,ACCESS
	addwf	SysTemp2,W,BANKED
	movwf	SCALE,BANKED
	movf	L_CALIBRATE_H,W,ACCESS
	addwfc	SysTemp2_H,W,BANKED
	movwf	SCALE_H,BANKED
	return

;********************************************************************************

;Source: GaugeDemoForInvertCSxLines.gcb (176)
SHOWDATE
;tempString = ""
	lfsr	1,TEMPSTRING
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
;GLCDPrint 8, 55, "1:21 PM"
	movlw	8
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	55
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*7
	goto	GLCDPRINT11

;********************************************************************************

;Source: GaugeDemoForInvertCSxLines.gcb (190)
SHOWDISTANCE
;tempString = ""
	lfsr	1,TEMPSTRING
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
;GLCDPrint 65, 55, "0.3 Mi"
	movlw	65
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	55
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable6
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*6
	goto	GLCDPRINT11

;********************************************************************************

;Source: GaugeDemoForInvertCSxLines.gcb (197)
SHOWFUEL
;value = scale ( value, 0, 999, 0, 28 )
	movff	VALUE,L_MAP
	movff	VALUE_H,L_MAP_H
	clrf	L_FROMLOW,BANKED
	clrf	L_FROMLOW_H,BANKED
	movlw	231
	movwf	L_FROMHIGH,ACCESS
	movlw	3
	movwf	L_FROMHIGH_H,ACCESS
	clrf	L_TOLOW,BANKED
	clrf	L_TOLOW_H,BANKED
	movlw	28
	movwf	L_TOHIGH,BANKED
	clrf	L_TOHIGH_H,BANKED
	clrf	L_CALIBRATE,ACCESS
	clrf	L_CALIBRATE_H,ACCESS
	rcall	FN_SCALE151
	movff	SYSSCALEWORD,VALUE
	movff	SYSSCALEWORD_H,VALUE_H
;GLCDPrint 105, 0, "FUEL"
	movlw	105
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable7
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*4
	call	GLCDPRINT11
;GLCDPrint 98, 16, "E"
	movlw	98
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	16
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable8
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*1
	call	GLCDPRINT11
;GLCDPrint 123, 16, "F"
	movlw	123
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	16
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*1
	call	GLCDPRINT11
;Line 102, 20, 120, 20
	movlw	102
	movwf	LINEX1,ACCESS
	clrf	LINEX1_H,ACCESS
	movlw	20
	movwf	LINEY1,ACCESS
	clrf	LINEY1_H,ACCESS
	movlw	120
	movwf	LINEX2,ACCESS
	clrf	LINEX2_H,ACCESS
	movlw	20
	movwf	LINEY2,ACCESS
	clrf	LINEY2_H,ACCESS
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	LINE
;Draw guage
;IF value >0 Then
	movff	VALUE,SysWORDTempB
	movff	VALUE_H,SysWORDTempB_H
	clrf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE8_1
;FilledBox 98, 9, 98 + value , 14, 1
	movlw	98
	movwf	LINEX1,ACCESS
	movlw	9
	movwf	LINEY1,ACCESS
	movlw	98
	addwf	VALUE,W,BANKED
	movwf	LINEX2,ACCESS
	movlw	14
	movwf	LINEY2,ACCESS
	movlw	1
	movwf	LINECOLOUR,ACCESS
	clrf	LINECOLOUR_H,ACCESS
	call	FILLEDBOX_KS0108
;Else
	bra	ENDIF8
ELSE8_1
;GLCDPrint 98, 8, "!"
	movlw	98
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	8
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable9
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*1
	call	GLCDPRINT11
;End If
ENDIF8
;FilledBox 98 + value + 1, 9, 127, 14, 0
	movlw	98
	addwf	VALUE,W,BANKED
	movwf	SysTemp2,BANKED
	incf	SysTemp2,W,BANKED
	movwf	LINEX1,ACCESS
	movlw	9
	movwf	LINEY1,ACCESS
	movlw	127
	movwf	LINEX2,ACCESS
	movlw	14
	movwf	LINEY2,ACCESS
	clrf	LINECOLOUR,ACCESS
	clrf	LINECOLOUR_H,ACCESS
	goto	FILLEDBOX_KS0108

;********************************************************************************

;Source: GaugeDemoForInvertCSxLines.gcb (165)
SHOWTEMP
;tempString = ""
	lfsr	1,TEMPSTRING
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
;GLCDPrint 8, 47, str(value) + "   "
	movlw	8
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	47
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	VALUE,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	rcall	FN_STR
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	rcall	SYSCOPYSTRINGPART
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM1
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*0
	call	GLCDPRINT11
;Draw degree
;Box 18, 47, 20, 49
	movlw	18
	movwf	LINEX1,ACCESS
	clrf	LINEX1_H,ACCESS
	movlw	47
	movwf	LINEY1,ACCESS
	clrf	LINEY1_H,ACCESS
	movlw	20
	movwf	LINEX2,ACCESS
	clrf	LINEX2_H,ACCESS
	movlw	49
	movwf	LINEY2,ACCESS
	clrf	LINEY2_H,ACCESS
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	BOX23
;GLCDPrint 22, 47, "F"
	movlw	22
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	47
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*1
	goto	GLCDPRINT11

;********************************************************************************

;Source: GaugeDemoForInvertCSxLines.gcb (183)
SHOWTIME
;tempString = ""
	lfsr	1,TEMPSTRING
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
;GLCDPrint 65, 47, "0Hr 01 Mn"
	movlw	65
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	47
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*9
	goto	GLCDPRINT11

;********************************************************************************

;Source: string.h (124)
FN_STR
;SysCharCount = 0
	clrf	SYSCHARCOUNT,BANKED
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
	bra	ENDIF85
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
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValThousands
	bra	SYSVALTHOUSANDS
;End If
ENDIF85
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
	bra	ENDIF86
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
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValHundreds
	bra	SYSVALHUNDREDS
;End If
ENDIF86
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
	bra	ENDIF87
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
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValTens
	bra	SYSVALTENS
;End If
ENDIF87
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
	bra	ENDIF88
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
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;End If
ENDIF88
;Ones
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysValTemp + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSVALTEMP,W,BANKED
	movwf	INDF0,ACCESS
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;Str(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSSTR_0
	return

;********************************************************************************

;Source: system.h (4061)
SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfseq SysByteTempA
	cpfseq	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
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

;Source: system.h (4481)
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

;Source: system.h (4539)
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

;Source: system.h (4922)
SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ELSE82_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF83
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	return
;End If
ENDIF83
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,W,ACCESS
	movwf	SYSDIVMULTA,ACCESS
	comf	SYSINTEGERTEMPA_H,W,ACCESS
	movwf	SYSDIVMULTA_H,ACCESS
	incf	SYSDIVMULTA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSDIVMULTA_H,F,ACCESS
;SysIntegerTempA = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,W,ACCESS
	movwf	SYSINTEGERTEMPA,ACCESS
	comf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSINTEGERTEMPA_H,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempB = SysDivMultA
	movff	SYSDIVMULTA,SYSINTEGERTEMPB
	movff	SYSDIVMULTA_H,SYSINTEGERTEMPB_H
;+A
;Else
	bra	ENDIF82
ELSE82_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	return
;End If
;End If
ENDIF82
;Test High, exit if more
;movf SysIntegerTempA_H,W
	movf	SYSINTEGERTEMPA_H,W,ACCESS
;subwf SysIntegerTempB_H,W
	subwf	SYSINTEGERTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	movf	SYSINTEGERTEMPB_H,W,ACCESS
;subwf SysIntegerTempA_H,W
	subwf	SYSINTEGERTEMPA_H,W,ACCESS
;bnc SCLTIntTrue
	bnc	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	movf	SYSINTEGERTEMPB,W,ACCESS
;subwf SysIntegerTempA,W
	subwf	SYSINTEGERTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLTINTTRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

;Source: system.h (1716)
SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length for ChipFamily 16 support
;movff INDF0, SysCalcTempA
	movffl	INDF0,SYSCALCTEMPA
;movff SysCalcTempA, INDF1
	movffl	SYSCALCTEMPA,INDF1
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
	movffl	PREINC0,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringCopy
	bra	SYSSTRINGCOPY
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

;Source: system.h (3455)
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
	bra	ENDIF75
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF75
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
	bra	ENDIF76
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF76
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
	bra	ENDIF80
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF80
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
	bra	ENDIF81
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
ENDIF81
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

;Source: system.h (3509)
SYSDIVSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	xorwf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSSIGNBYTE,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ENDIF77
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
ENDIF77
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF78
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
ENDIF78
;Call word divide routine
;SysDivSub16
	rcall	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF79
;SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
;End If
ENDIF79
	return

;********************************************************************************

;Source: system.h (2921)
SYSMULTSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;X = LowA * LowB
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movff PRODL, SysWordTempX
	movffl	PRODL,SYSWORDTEMPX
;movff PRODH, SysWordTempX_H
	movffl	PRODH,SYSWORDTEMPX_H
;HighX += LowA * HighB
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;HighX += HighA * LowB
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;PRODL = HighA * HighB
;movf SysWordTempA_H, F
	movf	SYSWORDTEMPA_H, F,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
	return

;********************************************************************************

;Source: system.h (3038)
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
	clrf	SYSLONGDIVMULTX,BANKED
	clrf	SYSLONGDIVMULTX_H,BANKED
	clrf	SYSLONGDIVMULTX_U,BANKED
	clrf	SYSLONGDIVMULTX_E,BANKED
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	btfss	SYSLONGDIVMULTB,0,BANKED
	bra	ENDIF73
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	movf	SYSLONGDIVMULTA,W,BANKED
	addwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTA_H,W,BANKED
	addwfc	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTA_U,W,BANKED
	addwfc	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTA_E,W,BANKED
	addwfc	SYSLONGDIVMULTX_E,F,BANKED
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
ENDIF73
;set STATUS.C OFF
	bcf	STATUS,C,ACCESS
;rotate SysLongDivMultB right
	rrcf	SYSLONGDIVMULTB_E,F,BANKED
	rrcf	SYSLONGDIVMULTB_U,F,BANKED
	rrcf	SYSLONGDIVMULTB_H,F,BANKED
	rrcf	SYSLONGDIVMULTB,F,BANKED
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate SysLongDivMultA left
	rlcf	SYSLONGDIVMULTA,F,BANKED
	rlcf	SYSLONGDIVMULTA_H,F,BANKED
	rlcf	SYSLONGDIVMULTA_U,F,BANKED
	rlcf	SYSLONGDIVMULTA_E,F,BANKED
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

;Source: system.h (3019)
SYSMULTSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	xorwf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSSIGNBYTE,ACCESS
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ENDIF70
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
ENDIF70
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF71
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
ENDIF71
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF72
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
ENDIF72
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
	db	0


StringTable2
	db	3,32,32,32


StringTable3
	db	1,70


StringTable4
	db	7,49,58,50,49,32,80,77


StringTable5
	db	9,48,72,114,32,48,49,32,77,110


StringTable6
	db	6,48,46,51,32,77,105


StringTable7
	db	4,70,85,69,76


StringTable8
	db	1,69


StringTable9
	db	1,33


;********************************************************************************


 END
