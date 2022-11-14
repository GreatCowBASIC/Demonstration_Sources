;Program compiled by Great Cow BASIC (1.00.00 Release Candidate 2022-11-06 (Windows 64 bit) : Build 1189) for Microchip PIC-AS
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email:
;   evanvennn at users dot sourceforge dot net

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F17126
 PAGEWIDTH   180
 RADIX       DEC
 TITLE       "d:\GreatCowBASICGits\Demonstration_Sources.git\trunk\Vendor_Boards\Great_Cow_Basic_Demo_Board\16F17126_chiprange_demonstrations\200_i2c_glcd_using_ssd1306_128_32.s"
 SUBTITLE    "11-14-2022"

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
GLOBAL	ADCVAL
 ADCVAL                           EQU 32          ; 0X20
GLOBAL	ADCVAL_H
 ADCVAL_H                         EQU 33          ; 0X21
GLOBAL	ADREADPORT
 ADREADPORT                       EQU 34          ; 0X22
GLOBAL	ANSELB
 ANSELB                           EQU 35          ; 0X23
GLOBAL	BYTENUMBER
 BYTENUMBER                       EQU 36          ; 0X24
GLOBAL	CCOUNT
 CCOUNT                           EQU 37          ; 0X25
GLOBAL	CHARCODE
 CHARCODE                         EQU 38          ; 0X26
GLOBAL	CHARCOL
 CHARCOL                          EQU 39          ; 0X27
GLOBAL	CHARCOLS
 CHARCOLS                         EQU 41          ; 0X29
GLOBAL	CHARCOL_H
 CHARCOL_H                        EQU 40          ; 0X28
GLOBAL	CHARLOCX
 CHARLOCX                         EQU 42          ; 0X2A
GLOBAL	CHARLOCX_H
 CHARLOCX_H                       EQU 43          ; 0X2B
GLOBAL	CHARLOCY
 CHARLOCY                         EQU 44          ; 0X2C
GLOBAL	CHARLOCY_H
 CHARLOCY_H                       EQU 45          ; 0X2D
GLOBAL	CHARROW
 CHARROW                          EQU 46          ; 0X2E
GLOBAL	CHARROWS
 CHARROWS                         EQU 48          ; 0X30
GLOBAL	CHARROW_H
 CHARROW_H                        EQU 47          ; 0X2F
GLOBAL	CHR
 CHR                              EQU 10054          ; 0X2746
GLOBAL	COL
 COL                              EQU 49          ; 0X31
GLOBAL	CURRCHARCOL
 CURRCHARCOL                      EQU 50          ; 0X32
GLOBAL	CURRCHARROW
 CURRCHARROW                      EQU 51          ; 0X33
GLOBAL	CURRCHARVAL
 CURRCHARVAL                      EQU 52          ; 0X34
GLOBAL	DELAYTEMP
 DELAYTEMP                        EQU 112          ; 0X70
GLOBAL	DELAYTEMP2
 DELAYTEMP2                       EQU 113          ; 0X71
GLOBAL	DRAWLINE
 DRAWLINE                         EQU 53          ; 0X35
GLOBAL	DRAWLINE_H
 DRAWLINE_H                       EQU 54          ; 0X36
GLOBAL	FILLED_ELLIPSE
 FILLED_ELLIPSE                   EQU 55          ; 0X37
GLOBAL	GLCDBACKGROUND
 GLCDBACKGROUND                   EQU 56          ; 0X38
GLOBAL	GLCDBACKGROUND_H
 GLCDBACKGROUND_H                 EQU 57          ; 0X39
GLOBAL	GLCDBITNO
 GLCDBITNO                        EQU 58          ; 0X3A
GLOBAL	GLCDCHANGE
 GLCDCHANGE                       EQU 59          ; 0X3B
GLOBAL	GLCDCOLOUR
 GLCDCOLOUR                       EQU 60          ; 0X3C
GLOBAL	GLCDCOLOUR_H
 GLCDCOLOUR_H                     EQU 61          ; 0X3D
GLOBAL	GLCDDATATEMP
 GLCDDATATEMP                     EQU 62          ; 0X3E
GLOBAL	GLCDFNTDEFAULT
 GLCDFNTDEFAULT                   EQU 63          ; 0X3F
GLOBAL	GLCDFNTDEFAULTHEIGHT
 GLCDFNTDEFAULTHEIGHT             EQU 64          ; 0X40
GLOBAL	GLCDFNTDEFAULTSIZE
 GLCDFNTDEFAULTSIZE               EQU 65          ; 0X41
GLOBAL	GLCDFONTWIDTH
 GLCDFONTWIDTH                    EQU 66          ; 0X42
GLOBAL	GLCDFOREGROUND
 GLCDFOREGROUND                   EQU 67          ; 0X43
GLOBAL	GLCDFOREGROUND_H
 GLCDFOREGROUND_H                 EQU 68          ; 0X44
GLOBAL	GLCDPRINTLEN
 GLCDPRINTLEN                     EQU 69          ; 0X45
GLOBAL	GLCDPRINTLOC
 GLCDPRINTLOC                     EQU 70          ; 0X46
GLOBAL	GLCDPRINTLOC_H
 GLCDPRINTLOC_H                   EQU 71          ; 0X47
GLOBAL	GLCDPRINT_STRING_COUNTER
 GLCDPRINT_STRING_COUNTER         EQU 72          ; 0X48
GLOBAL	GLCDTEMP
 GLCDTEMP                         EQU 73          ; 0X49
GLOBAL	GLCDTEMP_H
 GLCDTEMP_H                       EQU 74          ; 0X4A
GLOBAL	GLCDX
 GLCDX                            EQU 75          ; 0X4B
GLOBAL	GLCDY
 GLCDY                            EQU 76          ; 0X4C
GLOBAL	GLCDY_TEMP
 GLCDY_TEMP                       EQU 77          ; 0X4D
GLOBAL	GLCD_EX2
 GLCD_EX2                         EQU 78          ; 0X4E
GLOBAL	GLCD_EX2_E
 GLCD_EX2_E                       EQU 81          ; 0X51
GLOBAL	GLCD_EX2_H
 GLCD_EX2_H                       EQU 79          ; 0X4F
GLOBAL	GLCD_EX2_U
 GLCD_EX2_U                       EQU 80          ; 0X50
GLOBAL	GLCD_EY2
 GLCD_EY2                         EQU 82          ; 0X52
GLOBAL	GLCD_EY2_E
 GLCD_EY2_E                       EQU 85          ; 0X55
GLOBAL	GLCD_EY2_H
 GLCD_EY2_H                       EQU 83          ; 0X53
GLOBAL	GLCD_EY2_U
 GLCD_EY2_U                       EQU 84          ; 0X54
GLOBAL	GLCD_FX2
 GLCD_FX2                         EQU 86          ; 0X56
GLOBAL	GLCD_FX2_E
 GLCD_FX2_E                       EQU 89          ; 0X59
GLOBAL	GLCD_FX2_H
 GLCD_FX2_H                       EQU 87          ; 0X57
GLOBAL	GLCD_FX2_U
 GLCD_FX2_U                       EQU 88          ; 0X58
GLOBAL	GLCD_FY2
 GLCD_FY2                         EQU 90          ; 0X5A
GLOBAL	GLCD_FY2_E
 GLCD_FY2_E                       EQU 93          ; 0X5D
GLOBAL	GLCD_FY2_H
 GLCD_FY2_H                       EQU 91          ; 0X5B
GLOBAL	GLCD_FY2_U
 GLCD_FY2_U                       EQU 92          ; 0X5C
GLOBAL	GLCD_PP
 GLCD_PP                          EQU 94          ; 0X5E
GLOBAL	GLCD_PP_E
 GLCD_PP_E                        EQU 97          ; 0X61
GLOBAL	GLCD_PP_H
 GLCD_PP_H                        EQU 95          ; 0X5F
GLOBAL	GLCD_PP_TEMP
 GLCD_PP_TEMP                     EQU 98          ; 0X62
GLOBAL	GLCD_PP_TEMP_E
 GLCD_PP_TEMP_E                   EQU 101          ; 0X65
GLOBAL	GLCD_PP_TEMP_H
 GLCD_PP_TEMP_H                   EQU 99          ; 0X63
GLOBAL	GLCD_PP_TEMP_U
 GLCD_PP_TEMP_U                   EQU 100          ; 0X64
GLOBAL	GLCD_PP_U
 GLCD_PP_U                        EQU 96          ; 0X60
GLOBAL	GLCD_PX
 GLCD_PX                          EQU 102          ; 0X66
GLOBAL	GLCD_PX_E
 GLCD_PX_E                        EQU 105          ; 0X69
GLOBAL	GLCD_PX_H
 GLCD_PX_H                        EQU 103          ; 0X67
GLOBAL	GLCD_PX_U
 GLCD_PX_U                        EQU 104          ; 0X68
GLOBAL	GLCD_PY
 GLCD_PY                          EQU 106          ; 0X6A
GLOBAL	GLCD_PY_E
 GLCD_PY_E                        EQU 109          ; 0X6D
GLOBAL	GLCD_PY_H
 GLCD_PY_H                        EQU 107          ; 0X6B
GLOBAL	GLCD_PY_U
 GLCD_PY_U                        EQU 108          ; 0X6C
GLOBAL	GLCD_RX2
 GLCD_RX2                         EQU 110          ; 0X6E
GLOBAL	GLCD_RX2_H
 GLCD_RX2_H                       EQU 111          ; 0X6F
GLOBAL	GLCD_RY2
 GLCD_RY2                         EQU 160          ; 0XA0
GLOBAL	GLCD_RY2_H
 GLCD_RY2_H                       EQU 161          ; 0XA1
GLOBAL	GLCD_XX
 GLCD_XX                          EQU 162          ; 0XA2
GLOBAL	GLCD_XX_H
 GLCD_XX_H                        EQU 163          ; 0XA3
GLOBAL	GLCD_YORDINATE
 GLCD_YORDINATE                   EQU 164          ; 0XA4
GLOBAL	GLCD_YORDINATE_H
 GLCD_YORDINATE_H                 EQU 165          ; 0XA5
GLOBAL	GLCD_YY
 GLCD_YY                          EQU 166          ; 0XA6
GLOBAL	GLCD_YY1
 GLCD_YY1                         EQU 168          ; 0XA8
GLOBAL	GLCD_YY_H
 GLCD_YY_H                        EQU 167          ; 0XA7
GLOBAL	HI2CACKPOLLSTATE
 HI2CACKPOLLSTATE                 EQU 169          ; 0XA9
GLOBAL	HI2CCURRENTMODE
 HI2CCURRENTMODE                  EQU 170          ; 0XAA
GLOBAL	HI2CWAITMSSPTIMEOUT
 HI2CWAITMSSPTIMEOUT              EQU 171          ; 0XAB
GLOBAL	I2CBYTE
 I2CBYTE                          EQU 172          ; 0XAC
GLOBAL	INXRADIUS
 INXRADIUS                        EQU 173          ; 0XAD
GLOBAL	INXRADIUS_H
 INXRADIUS_H                      EQU 174          ; 0XAE
GLOBAL	INYRADIUS
 INYRADIUS                        EQU 175          ; 0XAF
GLOBAL	INYRADIUS_H
 INYRADIUS_H                      EQU 176          ; 0XB0
GLOBAL	LCDVALUE
 LCDVALUE                         EQU 177          ; 0XB1
GLOBAL	LCDVALUE_E
 LCDVALUE_E                       EQU 180          ; 0XB4
GLOBAL	LCDVALUE_H
 LCDVALUE_H                       EQU 178          ; 0XB2
GLOBAL	LCDVALUE_U
 LCDVALUE_U                       EQU 179          ; 0XB3
GLOBAL	LINECOLOUR
 LINECOLOUR                       EQU 181          ; 0XB5
GLOBAL	LINECOLOUR_H
 LINECOLOUR_H                     EQU 182          ; 0XB6
GLOBAL	LINEDIFFX
 LINEDIFFX                        EQU 183          ; 0XB7
GLOBAL	LINEDIFFX_H
 LINEDIFFX_H                      EQU 184          ; 0XB8
GLOBAL	LINEDIFFX_X2
 LINEDIFFX_X2                     EQU 185          ; 0XB9
GLOBAL	LINEDIFFX_X2_H
 LINEDIFFX_X2_H                   EQU 186          ; 0XBA
GLOBAL	LINEDIFFY
 LINEDIFFY                        EQU 187          ; 0XBB
GLOBAL	LINEDIFFY_H
 LINEDIFFY_H                      EQU 188          ; 0XBC
GLOBAL	LINEDIFFY_X2
 LINEDIFFY_X2                     EQU 189          ; 0XBD
GLOBAL	LINEDIFFY_X2_H
 LINEDIFFY_X2_H                   EQU 190          ; 0XBE
GLOBAL	LINEERR
 LINEERR                          EQU 191          ; 0XBF
GLOBAL	LINEERR_H
 LINEERR_H                        EQU 192          ; 0XC0
GLOBAL	LINESTEPX
 LINESTEPX                        EQU 193          ; 0XC1
GLOBAL	LINESTEPX_H
 LINESTEPX_H                      EQU 194          ; 0XC2
GLOBAL	LINESTEPY
 LINESTEPY                        EQU 195          ; 0XC3
GLOBAL	LINESTEPY_H
 LINESTEPY_H                      EQU 196          ; 0XC4
GLOBAL	LINEX1
 LINEX1                           EQU 197          ; 0XC5
GLOBAL	LINEX1_H
 LINEX1_H                         EQU 198          ; 0XC6
GLOBAL	LINEX2
 LINEX2                           EQU 199          ; 0XC7
GLOBAL	LINEX2_H
 LINEX2_H                         EQU 200          ; 0XC8
GLOBAL	LINEY1
 LINEY1                           EQU 201          ; 0XC9
GLOBAL	LINEY1_H
 LINEY1_H                         EQU 202          ; 0XCA
GLOBAL	LINEY2
 LINEY2                           EQU 203          ; 0XCB
GLOBAL	LINEY2_H
 LINEY2_H                         EQU 204          ; 0XCC
GLOBAL	LOCX
 LOCX                             EQU 205          ; 0XCD
GLOBAL	LOCY
 LOCY                             EQU 206          ; 0XCE
GLOBAL	LONGNUMBER
 LONGNUMBER                       EQU 207          ; 0XCF
GLOBAL	LONGNUMBER_E
 LONGNUMBER_E                     EQU 210          ; 0XD2
GLOBAL	LONGNUMBER_H
 LONGNUMBER_H                     EQU 208          ; 0XD0
GLOBAL	LONGNUMBER_U
 LONGNUMBER_U                     EQU 209          ; 0XD1
GLOBAL	OUTSTRING
 OUTSTRING                        EQU 10013          ; 0X271D
GLOBAL	PAD
 PAD                              EQU 9972          ; 0X26F4
GLOBAL	POSCHARX
 POSCHARX                         EQU 211          ; 0XD3
GLOBAL	POSCHARX_H
 POSCHARX_H                       EQU 212          ; 0XD4
GLOBAL	POSCHARY
 POSCHARY                         EQU 213          ; 0XD5
GLOBAL	PRINTLOCX
 PRINTLOCX                        EQU 214          ; 0XD6
GLOBAL	PRINTLOCX_H
 PRINTLOCX_H                      EQU 215          ; 0XD7
GLOBAL	PRINTLOCY
 PRINTLOCY                        EQU 216          ; 0XD8
GLOBAL	PRINTLOCY_H
 PRINTLOCY_H                      EQU 217          ; 0XD9
GLOBAL	RADIUSERR
 RADIUSERR                        EQU 218          ; 0XDA
GLOBAL	RADIUSERR_H
 RADIUSERR_H                      EQU 219          ; 0XDB
GLOBAL	READAD
 READAD                           EQU 220          ; 0XDC
GLOBAL	ROW
 ROW                              EQU 221          ; 0XDD
GLOBAL	SSD1306SENDBYTE
 SSD1306SENDBYTE                  EQU 222          ; 0XDE
GLOBAL	SSD1306_BUFFERALIAS
 SSD1306_BUFFERALIAS              EQU 10095          ; 0X276F
GLOBAL	SSD1306_BUFFERLOCATIONCALC
 SSD1306_BUFFERLOCATIONCALC       EQU 223          ; 0XDF
GLOBAL	SSD1306_BUFFERLOCATIONCALC_H
 SSD1306_BUFFERLOCATIONCALC_H     EQU 224          ; 0XE0
GLOBAL	STR
 STR                              EQU 9955          ; 0X26E3
GLOBAL	STRINGLOCX
 STRINGLOCX                       EQU 225          ; 0XE1
GLOBAL	STRINGPOINTER
 STRINGPOINTER                    EQU 226          ; 0XE2
GLOBAL	SYSARRAYTEMP1
 SYSARRAYTEMP1                    EQU 227          ; 0XE3
GLOBAL	SYSARRAYTEMP2
 SYSARRAYTEMP2                    EQU 228          ; 0XE4
GLOBAL	SYSBYTETEMPA
 SYSBYTETEMPA                     EQU 117          ; 0X75
GLOBAL	SYSBYTETEMPB
 SYSBYTETEMPB                     EQU 121          ; 0X79
GLOBAL	SYSBYTETEMPX
 SYSBYTETEMPX                     EQU 112          ; 0X70
GLOBAL	SYSCALCTEMPA
 SYSCALCTEMPA                     EQU 117          ; 0X75
GLOBAL	SYSCALCTEMPA_E
 SYSCALCTEMPA_E                   EQU 120          ; 0X78
GLOBAL	SYSCALCTEMPA_H
 SYSCALCTEMPA_H                   EQU 118          ; 0X76
GLOBAL	SYSCALCTEMPA_U
 SYSCALCTEMPA_U                   EQU 119          ; 0X77
GLOBAL	SYSCALCTEMPX
 SYSCALCTEMPX                     EQU 112          ; 0X70
GLOBAL	SYSCALCTEMPX_H
 SYSCALCTEMPX_H                   EQU 113          ; 0X71
GLOBAL	SYSCHAR
 SYSCHAR                          EQU 229          ; 0XE5
GLOBAL	SYSCHARCOUNT
 SYSCHARCOUNT                     EQU 230          ; 0XE6
GLOBAL	SYSCHARSHANDLER
 SYSCHARSHANDLER                  EQU 231          ; 0XE7
GLOBAL	SYSCHARSHANDLER_H
 SYSCHARSHANDLER_H                EQU 232          ; 0XE8
GLOBAL	SYSDIVLOOP
 SYSDIVLOOP                       EQU 116          ; 0X74
GLOBAL	SYSDIVMULTA
 SYSDIVMULTA                      EQU 119          ; 0X77
GLOBAL	SYSDIVMULTA_H
 SYSDIVMULTA_H                    EQU 120          ; 0X78
GLOBAL	SYSDIVMULTB
 SYSDIVMULTB                      EQU 123          ; 0X7B
GLOBAL	SYSDIVMULTB_H
 SYSDIVMULTB_H                    EQU 124          ; 0X7C
GLOBAL	SYSDIVMULTX
 SYSDIVMULTX                      EQU 114          ; 0X72
GLOBAL	SYSDIVMULTX_H
 SYSDIVMULTX_H                    EQU 115          ; 0X73
GLOBAL	SYSFORLOOPABSVALUE15
 SYSFORLOOPABSVALUE15             EQU 233          ; 0XE9
GLOBAL	SYSFORLOOPABSVALUE15_H
 SYSFORLOOPABSVALUE15_H           EQU 234          ; 0XEA
GLOBAL	SYSFORLOOPSTEP14
 SYSFORLOOPSTEP14                 EQU 235          ; 0XEB
GLOBAL	SYSFORLOOPSTEP14_H
 SYSFORLOOPSTEP14_H               EQU 236          ; 0XEC
GLOBAL	SYSFORLOOPSTEP8
 SYSFORLOOPSTEP8                  EQU 237          ; 0XED
GLOBAL	SYSFORLOOPSTEP8_H
 SYSFORLOOPSTEP8_H                EQU 238          ; 0XEE
GLOBAL	SYSINTEGERTEMPA
 SYSINTEGERTEMPA                  EQU 117          ; 0X75
GLOBAL	SYSINTEGERTEMPA_H
 SYSINTEGERTEMPA_H                EQU 118          ; 0X76
GLOBAL	SYSINTEGERTEMPB
 SYSINTEGERTEMPB                  EQU 121          ; 0X79
GLOBAL	SYSINTEGERTEMPB_H
 SYSINTEGERTEMPB_H                EQU 122          ; 0X7A
GLOBAL	SYSINTEGERTEMPX
 SYSINTEGERTEMPX                  EQU 112          ; 0X70
GLOBAL	SYSINTEGERTEMPX_H
 SYSINTEGERTEMPX_H                EQU 113          ; 0X71
GLOBAL	SYSLCDPRINTDATAHANDLER
 SYSLCDPRINTDATAHANDLER           EQU 288          ; 0X120
GLOBAL	SYSLCDPRINTDATAHANDLER_H
 SYSLCDPRINTDATAHANDLER_H         EQU 289          ; 0X121
GLOBAL	SYSLONGDIVMULTA
 SYSLONGDIVMULTA                  EQU 290          ; 0X122
GLOBAL	SYSLONGDIVMULTA_E
 SYSLONGDIVMULTA_E                EQU 293          ; 0X125
GLOBAL	SYSLONGDIVMULTA_H
 SYSLONGDIVMULTA_H                EQU 291          ; 0X123
GLOBAL	SYSLONGDIVMULTA_U
 SYSLONGDIVMULTA_U                EQU 292          ; 0X124
GLOBAL	SYSLONGDIVMULTB
 SYSLONGDIVMULTB                  EQU 294          ; 0X126
GLOBAL	SYSLONGDIVMULTB_E
 SYSLONGDIVMULTB_E                EQU 297          ; 0X129
GLOBAL	SYSLONGDIVMULTB_H
 SYSLONGDIVMULTB_H                EQU 295          ; 0X127
GLOBAL	SYSLONGDIVMULTB_U
 SYSLONGDIVMULTB_U                EQU 296          ; 0X128
GLOBAL	SYSLONGDIVMULTX
 SYSLONGDIVMULTX                  EQU 298          ; 0X12A
GLOBAL	SYSLONGDIVMULTX_E
 SYSLONGDIVMULTX_E                EQU 301          ; 0X12D
GLOBAL	SYSLONGDIVMULTX_H
 SYSLONGDIVMULTX_H                EQU 299          ; 0X12B
GLOBAL	SYSLONGDIVMULTX_U
 SYSLONGDIVMULTX_U                EQU 300          ; 0X12C
GLOBAL	SYSLONGTEMPA
 SYSLONGTEMPA                     EQU 117          ; 0X75
GLOBAL	SYSLONGTEMPA_E
 SYSLONGTEMPA_E                   EQU 120          ; 0X78
GLOBAL	SYSLONGTEMPA_H
 SYSLONGTEMPA_H                   EQU 118          ; 0X76
GLOBAL	SYSLONGTEMPA_U
 SYSLONGTEMPA_U                   EQU 119          ; 0X77
GLOBAL	SYSLONGTEMPB
 SYSLONGTEMPB                     EQU 121          ; 0X79
GLOBAL	SYSLONGTEMPB_E
 SYSLONGTEMPB_E                   EQU 124          ; 0X7C
GLOBAL	SYSLONGTEMPB_H
 SYSLONGTEMPB_H                   EQU 122          ; 0X7A
GLOBAL	SYSLONGTEMPB_U
 SYSLONGTEMPB_U                   EQU 123          ; 0X7B
GLOBAL	SYSLONGTEMPX
 SYSLONGTEMPX                     EQU 112          ; 0X70
GLOBAL	SYSLONGTEMPX_E
 SYSLONGTEMPX_E                   EQU 115          ; 0X73
GLOBAL	SYSLONGTEMPX_H
 SYSLONGTEMPX_H                   EQU 113          ; 0X71
GLOBAL	SYSLONGTEMPX_U
 SYSLONGTEMPX_U                   EQU 114          ; 0X72
GLOBAL	SYSPRINTBUFFER
 SYSPRINTBUFFER                   EQU 9961          ; 0X26E9
GLOBAL	SYSPRINTBUFFLEN
 SYSPRINTBUFFLEN                  EQU 239          ; 0XEF
GLOBAL	SYSREPEATTEMP1
 SYSREPEATTEMP1                   EQU 302          ; 0X12E
GLOBAL	SYSREPEATTEMP2
 SYSREPEATTEMP2                   EQU 303          ; 0X12F
GLOBAL	SYSREPEATTEMP4
 SYSREPEATTEMP4                   EQU 304          ; 0X130
GLOBAL	SYSSIGNBYTE
 SYSSIGNBYTE                      EQU 125          ; 0X7D
GLOBAL	SYSSTRDATA
 SYSSTRDATA                       EQU 305          ; 0X131
GLOBAL	SYSSTRINGA
 SYSSTRINGA                       EQU 119          ; 0X77
GLOBAL	SYSSTRINGA_H
 SYSSTRINGA_H                     EQU 120          ; 0X78
GLOBAL	SYSSTRINGLENGTH
 SYSSTRINGLENGTH                  EQU 118          ; 0X76
GLOBAL	SYSSTRINGPARAM1
 SYSSTRINGPARAM1                  EQU 9950          ; 0X26DE
GLOBAL	SYSSTRINGTEMP
 SYSSTRINGTEMP                    EQU 306          ; 0X132
GLOBAL	SYSSTRLEN
 SYSSTRLEN                        EQU 307          ; 0X133
GLOBAL	SYSSYSINSTRING3HANDLER
 SYSSYSINSTRING3HANDLER           EQU 308          ; 0X134
GLOBAL	SYSSYSINSTRING3HANDLER_H
 SYSSYSINSTRING3HANDLER_H         EQU 309          ; 0X135
GLOBAL	SYSSYSINSTRINGHANDLER
 SYSSYSINSTRINGHANDLER            EQU 310          ; 0X136
GLOBAL	SYSSYSINSTRINGHANDLER_H
 SYSSYSINSTRINGHANDLER_H          EQU 311          ; 0X137
GLOBAL	SYSTEMP1
 SYSTEMP1                         EQU 312          ; 0X138
GLOBAL	SYSTEMP1_E
 SYSTEMP1_E                       EQU 315          ; 0X13B
GLOBAL	SYSTEMP1_H
 SYSTEMP1_H                       EQU 313          ; 0X139
GLOBAL	SYSTEMP1_U
 SYSTEMP1_U                       EQU 314          ; 0X13A
GLOBAL	SYSTEMP2
 SYSTEMP2                         EQU 316          ; 0X13C
GLOBAL	SYSTEMP3
 SYSTEMP3                         EQU 317          ; 0X13D
GLOBAL	SYSTEMP3_H
 SYSTEMP3_H                       EQU 318          ; 0X13E
GLOBAL	SYSVALTEMP
 SYSVALTEMP                       EQU 319          ; 0X13F
GLOBAL	SYSVALTEMP_H
 SYSVALTEMP_H                     EQU 320          ; 0X140
GLOBAL	SYSWAITTEMP10US
 SYSWAITTEMP10US                  EQU 117          ; 0X75
GLOBAL	SYSWAITTEMPMS
 SYSWAITTEMPMS                    EQU 114          ; 0X72
GLOBAL	SYSWAITTEMPMS_H
 SYSWAITTEMPMS_H                  EQU 115          ; 0X73
GLOBAL	SYSWAITTEMPS
 SYSWAITTEMPS                     EQU 116          ; 0X74
GLOBAL	SYSWORDTEMPA
 SYSWORDTEMPA                     EQU 117          ; 0X75
GLOBAL	SYSWORDTEMPA_H
 SYSWORDTEMPA_H                   EQU 118          ; 0X76
GLOBAL	SYSWORDTEMPB
 SYSWORDTEMPB                     EQU 121          ; 0X79
GLOBAL	SYSWORDTEMPB_H
 SYSWORDTEMPB_H                   EQU 122          ; 0X7A
GLOBAL	SYSWORDTEMPX
 SYSWORDTEMPX                     EQU 112          ; 0X70
GLOBAL	SYSWORDTEMPX_H
 SYSWORDTEMPX_H                   EQU 113          ; 0X71
GLOBAL	WORDNUMBER
 WORDNUMBER                       EQU 321          ; 0X141
GLOBAL	WORDNUMBER_H
 WORDNUMBER_H                     EQU 322          ; 0X142
GLOBAL	XCHAR
 XCHAR                            EQU 323          ; 0X143
GLOBAL	XOFFSET
 XOFFSET                          EQU 324          ; 0X144
GLOBAL	XOFFSET_H
 XOFFSET_H                        EQU 325          ; 0X145
GLOBAL	XRADIUS
 XRADIUS                          EQU 326          ; 0X146
GLOBAL	XRADIUS_H
 XRADIUS_H                        EQU 327          ; 0X147
GLOBAL	YOFFSET
 YOFFSET                          EQU 328          ; 0X148
GLOBAL	YOFFSET_H
 YOFFSET_H                        EQU 329          ; 0X149
GLOBAL	YORDINATE
 YORDINATE                        EQU 330          ; 0X14A
GLOBAL	_GLCDPAGE
 _GLCDPAGE                        EQU 331          ; 0X14B

;********************************************************************************

;ALIAS VARIABLES
GLOBAL	AFSR0
 AFSR0                            EQU 4
GLOBAL	AFSR0_H
 AFSR0_H                          EQU 5
GLOBAL	SYSCHR_0
 SYSCHR_0                         EQU 2998
GLOBAL	SYSCHR_1
 SYSCHR_1                         EQU 2999
GLOBAL	SYSPAD_0
 SYSPAD_0                         EQU 2868
GLOBAL	SYSREADADBYTE
 SYSREADADBYTE                    EQU 220
GLOBAL	SYSSTR_0
 SYSSTR_0                         EQU 2851

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
	CALL	HI2CINIT
	CALL	INITGLCD_SSD1306
	PAGESEL	$

;START OF THE MAIN PROGRAM
;''
;''This demonstration program is a simple GLCD demonstration of the SSD1306 GLCD capabilities.
;''
;''This program draws lines, boxes, circles and prints strings and numbers.
;''The SSD1306 controller a small graphical OLED, suitable for a lot of various projects.
;''The display is 38*17 mm, with an active display surface of 0.96inches , and a 128*32 pixel resolution.
;''The display is easy to interface, using an I2C type of communication.
;''The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;''
;''This version is compatible will all version of Great Cow BASIC but only version greater than v0.98.00 support low memory GLCD modes.
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.00
;''@date    31.10.2022
;----- Configuration
;Chip Settings.
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:   -------------SDA-SW------SCL-ADC--
;'-----------------------------------------
;'
;' -------------------PORTB----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ----SCL-----SDA------------------
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
;Initialise I2C - note for the I2C module the ports need to be set correctly
;Dir HI2C_DATA In
	BSF	TRISA,4
;Dir HI2C_CLOCK In
	BSF	TRISA,1
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;----- Define variables
;These constants allow you to change the GLCD memory usage.
;We have set this demonstration to use only 128bytes of RAM for GLCD operations.
;Dim BYTENUMBER, CCOUNT As Byte
;CCount = 0
	CLRF	CCOUNT
;Dim longNumber As Long
;max value = 4294967290
;longNumber = 0
	BANKSEL	LONGNUMBER
	CLRF	LONGNUMBER
	CLRF	LONGNUMBER_H
	CLRF	LONGNUMBER_U
	CLRF	LONGNUMBER_E
;Dim wordNumber, adcval, ldrval As Word
;Dim outstring As String
;wordNumber = 0
	BANKSEL	WORDNUMBER
	CLRF	WORDNUMBER
	CLRF	WORDNUMBER_H
;byteNumber = 0
	BANKSEL	BYTENUMBER
	CLRF	BYTENUMBER
;----- Main program
;GLCD_Open_PageTransaction 0,3
;Macro Source: glcd_ssd1306.h (1180)
;dim _GLCDPage as byte
;Clear buffer
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
;LEGACY METHOD
	MOVLW	255
	BANKSEL	_GLCDPAGE
	MOVWF	_GLCDPAGE
GLOBAL	SYSFORLOOP1
SYSFORLOOP1:
	INCF	_GLCDPAGE,F
;GLCDPrint 0, 0,   "Great Cow BASIC"
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX
	CLRF	PRINTLOCX_H
	CLRF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE1
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
	BANKSEL	STATUS
	FCALL	GLCDPRINT4
;GLCDPrint (0, 16, "Anobium 2021")
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	16
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE2
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE2) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
	BANKSEL	STATUS
	FCALL	GLCDPRINT4
;GLCDPrint (76, 16, GLCD_WIDTH )
	MOVLW	76
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	16
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	128
	MOVWF	LCDVALUE
	CLRF	LCDVALUE_H
	CLRF	LCDVALUE_U
	CLRF	LCDVALUE_E
	BANKSEL	STATUS
	FCALL	GLCDPRINT7
;GLCDPrint (96, 16, "*" )
	MOVLW	96
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	16
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE3
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
	BANKSEL	STATUS
	FCALL	GLCDPRINT4
;GLCDPrint (104, 16, GLCD_HEIGHT )
	MOVLW	104
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	16
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	32
	MOVWF	LCDVALUE
	CLRF	LCDVALUE_H
	CLRF	LCDVALUE_U
	CLRF	LCDVALUE_E
	BANKSEL	STATUS
	FCALL	GLCDPRINT7
;GLCD_Close_PageTransaction
;Macro Source: glcd_ssd1306.h (1192)
;Set cursor position
;Cursor_Position_SSD1306 ( 0, 8 * _GLCDPage )
	BANKSEL	LOCX
	CLRF	LOCX
	BANKSEL	_GLCDPAGE
	MOVF	_GLCDPAGE,W
	MOVWF	SYSBYTETEMPA
	MOVLW	8
	MOVWF	SYSBYTETEMPB
	BANKSEL	STATUS
	FCALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	BANKSEL	LOCY
	MOVWF	LOCY
	BANKSEL	STATUS
	FCALL	CURSOR_POSITION_SSD1306
;Send the buffer to the device using transaction
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1218)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	FCALL	HI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;HI2CSend 0x40
	MOVLW	64
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;for SSD1306_BufferLocationCalc = 1 to 128
;LEGACY METHOD
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC_H
GLOBAL	SYSFORLOOP2
SYSFORLOOP2:
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	INCF	SSD1306_BUFFERLOCATIONCALC,F
	BTFSC	STATUS,2
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F
;Write_Transaction_Data_SSD1306 SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
;Macro Source: glcd_ssd1306.h (1249)
;HI2CSend SSD1306SendByte
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;Clear the buffer byte. We need it to be empty for the next page operation
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	FSR0H
	CLRF	INDF0
;next
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	SYSWORDTEMPA
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	128
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSFORLOOP2
GLOBAL	SYSFORLOOPEND2
SYSFORLOOPEND2:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1282)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	FCALL	HI2CSTOP
;next
	MOVLW	3
	BANKSEL	_GLCDPAGE
	SUBWF	_GLCDPAGE,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
GLOBAL	SYSFORLOOPEND1
SYSFORLOOPEND1:
;Wait 3 s
	MOVLW	3
	MOVWF	SYSWAITTEMPS
	BANKSEL	STATUS
	FCALL	DELAY_S
;GLCDCLS
	FCALL	GLCDCLS_SSD1306
;GLCD_Open_PageTransaction 0, 3
;Macro Source: glcd_ssd1306.h (1180)
;dim _GLCDPage as byte
;Clear buffer
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
;LEGACY METHOD
	MOVLW	255
	BANKSEL	_GLCDPAGE
	MOVWF	_GLCDPAGE
GLOBAL	SYSFORLOOP3
SYSFORLOOP3:
	INCF	_GLCDPAGE,F
;GLCDPrint 0, 0,   "Version 0.98.07"
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX
	CLRF	PRINTLOCX_H
	CLRF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE4
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE4) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
	BANKSEL	STATUS
	FCALL	GLCDPRINT4
;GLCDPrint (0, 16, "LM GLCD MODE")
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	16
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE5
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE5) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
	BANKSEL	STATUS
	FCALL	GLCDPRINT4
;GLCD_Close_PageTransaction
;Macro Source: glcd_ssd1306.h (1192)
;Set cursor position
;Cursor_Position_SSD1306 ( 0, 8 * _GLCDPage )
	BANKSEL	LOCX
	CLRF	LOCX
	BANKSEL	_GLCDPAGE
	MOVF	_GLCDPAGE,W
	MOVWF	SYSBYTETEMPA
	MOVLW	8
	MOVWF	SYSBYTETEMPB
	BANKSEL	STATUS
	FCALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	BANKSEL	LOCY
	MOVWF	LOCY
	BANKSEL	STATUS
	FCALL	CURSOR_POSITION_SSD1306
;Send the buffer to the device using transaction
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1218)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	FCALL	HI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;HI2CSend 0x40
	MOVLW	64
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;for SSD1306_BufferLocationCalc = 1 to 128
;LEGACY METHOD
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC_H
GLOBAL	SYSFORLOOP4
SYSFORLOOP4:
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	INCF	SSD1306_BUFFERLOCATIONCALC,F
	BTFSC	STATUS,2
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F
;Write_Transaction_Data_SSD1306 SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
;Macro Source: glcd_ssd1306.h (1249)
;HI2CSend SSD1306SendByte
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;Clear the buffer byte. We need it to be empty for the next page operation
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	FSR0H
	CLRF	INDF0
;next
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	SYSWORDTEMPA
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	128
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSFORLOOP4
GLOBAL	SYSFORLOOPEND4
SYSFORLOOPEND4:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1282)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	FCALL	HI2CSTOP
;next
	MOVLW	3
	BANKSEL	_GLCDPAGE
	SUBWF	_GLCDPAGE,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP3
GLOBAL	SYSFORLOOPEND3
SYSFORLOOPEND3:
;Wait 3 s
	MOVLW	3
	MOVWF	SYSWAITTEMPS
	BANKSEL	STATUS
	FCALL	DELAY_S
;GLCDCLS
	FCALL	GLCDCLS_SSD1306
;Do Forever
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;For CCount = 31 To 127
;LEGACY METHOD
	MOVLW	30
	MOVWF	CCOUNT
GLOBAL	SYSFORLOOP5
SYSFORLOOP5:
	INCF	CCOUNT,F
;Prepare a string
;outString = Str( CCount )
	MOVF	CCOUNT,W
	BANKSEL	SYSVALTEMP
	MOVWF	SYSVALTEMP
	CLRF	SYSVALTEMP_H
	BANKSEL	STATUS
	FCALL	FN_STR
	MOVLW	LOW OUTSTRING
	MOVWF	FSR1L
	MOVLW	HIGH OUTSTRING
	MOVWF	FSR1H
	MOVLW	LOW STR
	MOVWF	FSR0L
	MOVLW	HIGH STR
	MOVWF	FSR0H
	FCALL	SYSCOPYSTRING
;adcval = ReadAD ( ANA0 )
	CLRF	ADREADPORT
	FCALL	FN_READAD456
	BANKSEL	SYSREADADBYTE
	MOVF	SYSREADADBYTE,W
	BANKSEL	ADCVAL
	MOVWF	ADCVAL
	CLRF	ADCVAL_H
;Prepare the static components of the screen
;GLCD_Open_PageTransaction 0,3
;Macro Source: glcd_ssd1306.h (1180)
;dim _GLCDPage as byte
;Clear buffer
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
;LEGACY METHOD
	MOVLW	255
	BANKSEL	_GLCDPAGE
	MOVWF	_GLCDPAGE
GLOBAL	SYSFORLOOP6
SYSFORLOOP6:
	INCF	_GLCDPAGE,F
;Print some text
;GLCDPrint ( 1,   1, "PrintStr")
	MOVLW	1
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	1
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE7
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE7) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
	BANKSEL	STATUS
	FCALL	GLCDPRINT4
;Print some more text
;GLCDPrint ( 64,  1, "@")
	MOVLW	64
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	1
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE8
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE8) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
	BANKSEL	STATUS
	FCALL	GLCDPRINT4
;Print chip speed
;GLCDPrint ( 72,  1, ChipMHz)
	MOVLW	72
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	1
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	32
	MOVWF	LCDVALUE
	CLRF	LCDVALUE_H
	CLRF	LCDVALUE_U
	CLRF	LCDVALUE_E
	BANKSEL	STATUS
	FCALL	GLCDPRINT7
;Print some text
;GLCDPrint ( 86, 1, "Mhz")
	MOVLW	86
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	1
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE9
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE9) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
	BANKSEL	STATUS
	FCALL	GLCDPRINT4
;Draw some text
;GLCDDrawString( 1,11,"DrawStr")
	MOVLW	1
	BANKSEL	STRINGLOCX
	MOVWF	STRINGLOCX
	MOVLW	11
	BANKSEL	CHARLOCY
	MOVWF	CHARLOCY
	MOVLW	LOW STRINGTABLE10
	BANKSEL	SYSCHARSHANDLER
	MOVWF	SYSCHARSHANDLER
	MOVLW	(HIGH STRINGTABLE10) | 128
	MOVWF	SYSCHARSHANDLER_H
	BANKSEL	GLCDFOREGROUND
	MOVF	GLCDFOREGROUND,W
	BANKSEL	LINECOLOUR
	MOVWF	LINECOLOUR
	BANKSEL	GLCDFOREGROUND_H
	MOVF	GLCDFOREGROUND_H,W
	BANKSEL	LINECOLOUR_H
	MOVWF	LINECOLOUR_H
	BANKSEL	STATUS
	FCALL	GLCDDRAWSTRING
;Draw a box
;Box 0,0,GLCD_WIDTH-1, GLCD_HEIGHT-1
	BANKSEL	LINEX1
	CLRF	LINEX1
	CLRF	LINEX1_H
	CLRF	LINEY1
	CLRF	LINEY1_H
	MOVLW	127
	MOVWF	LINEX2
	CLRF	LINEX2_H
	MOVLW	31
	MOVWF	LINEY2
	CLRF	LINEY2_H
	BANKSEL	GLCDFOREGROUND
	MOVF	GLCDFOREGROUND,W
	BANKSEL	LINECOLOUR
	MOVWF	LINECOLOUR
	BANKSEL	GLCDFOREGROUND_H
	MOVF	GLCDFOREGROUND_H,W
	BANKSEL	LINECOLOUR_H
	MOVWF	LINECOLOUR_H
	BANKSEL	STATUS
	FCALL	BOX
;Draw a box
;Box GLCD_WIDTH-5, GLCD_HEIGHT-5,GLCD_WIDTH-1, GLCD_HEIGHT-1
	MOVLW	123
	BANKSEL	LINEX1
	MOVWF	LINEX1
	CLRF	LINEX1_H
	MOVLW	27
	MOVWF	LINEY1
	CLRF	LINEY1_H
	MOVLW	127
	MOVWF	LINEX2
	CLRF	LINEX2_H
	MOVLW	31
	MOVWF	LINEY2
	CLRF	LINEY2_H
	BANKSEL	GLCDFOREGROUND
	MOVF	GLCDFOREGROUND,W
	BANKSEL	LINECOLOUR
	MOVWF	LINECOLOUR
	BANKSEL	GLCDFOREGROUND_H
	MOVF	GLCDFOREGROUND_H,W
	BANKSEL	LINECOLOUR_H
	MOVWF	LINECOLOUR_H
	BANKSEL	STATUS
	FCALL	BOX
;Draw a circle
;Circle( 44,24,5)
	MOVLW	44
	BANKSEL	XOFFSET
	MOVWF	XOFFSET
	CLRF	XOFFSET_H
	MOVLW	24
	MOVWF	YOFFSET
	CLRF	YOFFSET_H
	MOVLW	5
	BANKSEL	INXRADIUS
	MOVWF	INXRADIUS
	CLRF	INXRADIUS_H
	BANKSEL	GLCDFOREGROUND
	MOVF	GLCDFOREGROUND,W
	BANKSEL	LINECOLOUR
	MOVWF	LINECOLOUR
	BANKSEL	GLCDFOREGROUND_H
	MOVF	GLCDFOREGROUND_H,W
	BANKSEL	LINECOLOUR_H
	MOVWF	LINECOLOUR_H
	MOVF	GLCD_YORDINATE,W
	BANKSEL	YORDINATE
	MOVWF	YORDINATE
	BANKSEL	STATUS
	FCALL	CIRCLE
;Draw a line
;Line 0,GLCD_HEIGHT-1,44,19
	BANKSEL	LINEX1
	CLRF	LINEX1
	CLRF	LINEX1_H
	MOVLW	31
	MOVWF	LINEY1
	CLRF	LINEY1_H
	MOVLW	44
	MOVWF	LINEX2
	CLRF	LINEX2_H
	MOVLW	19
	MOVWF	LINEY2
	CLRF	LINEY2_H
	BANKSEL	GLCDFOREGROUND
	MOVF	GLCDFOREGROUND,W
	BANKSEL	LINECOLOUR
	MOVWF	LINECOLOUR
	BANKSEL	GLCDFOREGROUND_H
	MOVF	GLCDFOREGROUND_H,W
	BANKSEL	LINECOLOUR_H
	MOVWF	LINECOLOUR_H
	BANKSEL	STATUS
	FCALL	_LINE
;GLCDPrint ( 75 ,  20,  "ADC:"+Pad(Str(adcval),4 ) )
	MOVLW	75
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	20
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	BANKSEL	ADCVAL
	MOVF	ADCVAL,W
	BANKSEL	SYSVALTEMP
	MOVWF	SYSVALTEMP
	BANKSEL	ADCVAL_H
	MOVF	ADCVAL_H,W
	BANKSEL	SYSVALTEMP_H
	MOVWF	SYSVALTEMP_H
	BANKSEL	STATUS
	FCALL	FN_STR
	MOVLW	LOW STR
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVWF	SYSSYSINSTRINGHANDLER
	MOVLW	HIGH STR
	MOVWF	SYSSYSINSTRINGHANDLER_H
	MOVLW	4
	MOVWF	SYSSTRLEN
	MOVLW	LOW STRINGTABLE59
	MOVWF	SYSSYSINSTRING3HANDLER
	MOVLW	(HIGH STRINGTABLE59) | 128
	MOVWF	SYSSYSINSTRING3HANDLER_H
	BANKSEL	STATUS
	FCALL	FN_PAD
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	FSR1L
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	FSR1H
	CLRF	SYSSTRINGLENGTH
	MOVLW	LOW STRINGTABLE11
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE11) & 127
	MOVWF	SYSSTRINGA_H
	FCALL	SYSREADSTRINGPART
	MOVLW	LOW PAD
	MOVWF	FSR0L
	MOVLW	HIGH PAD
	MOVWF	FSR0H
	FCALL	SYSCOPYSTRINGPART
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	FSR0L
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	FSR0H
	MOVF	SYSSTRINGLENGTH,W
	MOVWF	INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H
;USING SYSSTRINGPARAM1*4
	BANKSEL	STATUS
	FCALL	GLCDPRINT4
;Draw a Box
;Box (3,24,6,27)
	MOVLW	3
	BANKSEL	LINEX1
	MOVWF	LINEX1
	CLRF	LINEX1_H
	MOVLW	24
	MOVWF	LINEY1
	CLRF	LINEY1_H
	MOVLW	6
	MOVWF	LINEX2
	CLRF	LINEX2_H
	MOVLW	27
	MOVWF	LINEY2
	CLRF	LINEY2_H
	BANKSEL	GLCDFOREGROUND
	MOVF	GLCDFOREGROUND,W
	BANKSEL	LINECOLOUR
	MOVWF	LINECOLOUR
	BANKSEL	GLCDFOREGROUND_H
	MOVF	GLCDFOREGROUND_H,W
	BANKSEL	LINECOLOUR_H
	MOVWF	LINECOLOUR_H
	BANKSEL	STATUS
	FCALL	BOX
;Draw a string
;GLCDDrawString(44, 11, CHR(CCount)+"="+Pad(outString,3) )
	MOVLW	44
	BANKSEL	STRINGLOCX
	MOVWF	STRINGLOCX
	MOVLW	11
	BANKSEL	CHARLOCY
	MOVWF	CHARLOCY
	MOVF	CCOUNT,W
	BANKSEL	SYSCHAR
	MOVWF	SYSCHAR
	BANKSEL	STATUS
	FCALL	FN_CHR
	MOVLW	LOW OUTSTRING
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVWF	SYSSYSINSTRINGHANDLER
	MOVLW	HIGH OUTSTRING
	MOVWF	SYSSYSINSTRINGHANDLER_H
	MOVLW	3
	MOVWF	SYSSTRLEN
	MOVLW	LOW STRINGTABLE59
	MOVWF	SYSSYSINSTRING3HANDLER
	MOVLW	(HIGH STRINGTABLE59) | 128
	MOVWF	SYSSYSINSTRING3HANDLER_H
	BANKSEL	STATUS
	FCALL	FN_PAD
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	FSR1L
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	FSR1H
	CLRF	SYSSTRINGLENGTH
	MOVLW	LOW CHR
	MOVWF	FSR0L
	MOVLW	HIGH CHR
	MOVWF	FSR0H
	FCALL	SYSCOPYSTRINGPART
	MOVLW	LOW STRINGTABLE12
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE12) & 127
	MOVWF	SYSSTRINGA_H
	FCALL	SYSREADSTRINGPART
	MOVLW	LOW PAD
	MOVWF	FSR0L
	MOVLW	HIGH PAD
	MOVWF	FSR0H
	FCALL	SYSCOPYSTRINGPART
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	FSR0L
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	FSR0H
	MOVF	SYSSTRINGLENGTH,W
	MOVWF	INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSCHARSHANDLER
	MOVWF	SYSCHARSHANDLER
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSCHARSHANDLER_H
	BANKSEL	GLCDFOREGROUND
	MOVF	GLCDFOREGROUND,W
	BANKSEL	LINECOLOUR
	MOVWF	LINECOLOUR
	BANKSEL	GLCDFOREGROUND_H
	MOVF	GLCDFOREGROUND_H,W
	BANKSEL	LINECOLOUR_H
	MOVWF	LINECOLOUR_H
;USING SYSSTRINGPARAM1*0
	BANKSEL	STATUS
	FCALL	GLCDDRAWSTRING
;Ellipse 118, 6, 7, 4
	MOVLW	118
	BANKSEL	XOFFSET
	MOVWF	XOFFSET
	CLRF	XOFFSET_H
	MOVLW	6
	MOVWF	YOFFSET
	CLRF	YOFFSET_H
	MOVLW	7
	BANKSEL	INXRADIUS
	MOVWF	INXRADIUS
	CLRF	INXRADIUS_H
	MOVLW	4
	MOVWF	INYRADIUS
	CLRF	INYRADIUS_H
	BANKSEL	GLCDFOREGROUND
	MOVF	GLCDFOREGROUND,W
	BANKSEL	LINECOLOUR
	MOVWF	LINECOLOUR
	BANKSEL	GLCDFOREGROUND_H
	MOVF	GLCDFOREGROUND_H,W
	BANKSEL	LINECOLOUR_H
	MOVWF	LINECOLOUR_H
	BANKSEL	STATUS
	FCALL	ELLIPSE
;If adcval > 127 Then
	MOVF	ADCVAL,W
	MOVWF	SYSWORDTEMPB
	MOVF	ADCVAL_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVLW	127
	MOVWF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
	FCALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ELSE5_1
;FilledEllipse 118, 6, 5, 2
	MOVLW	118
	BANKSEL	XOFFSET
	MOVWF	XOFFSET
	CLRF	XOFFSET_H
	MOVLW	6
	MOVWF	YOFFSET
	CLRF	YOFFSET_H
	MOVLW	5
	BANKSEL	INXRADIUS
	MOVWF	INXRADIUS
	CLRF	INXRADIUS_H
	MOVLW	2
	MOVWF	INYRADIUS
	CLRF	INYRADIUS_H
	BANKSEL	GLCDFOREGROUND
	MOVF	GLCDFOREGROUND,W
	BANKSEL	LINECOLOUR
	MOVWF	LINECOLOUR
	BANKSEL	GLCDFOREGROUND_H
	MOVF	GLCDFOREGROUND_H,W
	BANKSEL	LINECOLOUR_H
	MOVWF	LINECOLOUR_H
	BANKSEL	STATUS
	FCALL	FILLEDELLIPSE
;Else
	GOTO	ENDIF5
GLOBAL	ELSE5_1
ELSE5_1:
;FilledEllipse 118, 6, 5, 2, GLCDBackground
	MOVLW	118
	BANKSEL	XOFFSET
	MOVWF	XOFFSET
	CLRF	XOFFSET_H
	MOVLW	6
	MOVWF	YOFFSET
	CLRF	YOFFSET_H
	MOVLW	5
	BANKSEL	INXRADIUS
	MOVWF	INXRADIUS
	CLRF	INXRADIUS_H
	MOVLW	2
	MOVWF	INYRADIUS
	CLRF	INYRADIUS_H
	BANKSEL	GLCDBACKGROUND
	MOVF	GLCDBACKGROUND,W
	BANKSEL	LINECOLOUR
	MOVWF	LINECOLOUR
	BANKSEL	GLCDBACKGROUND_H
	MOVF	GLCDBACKGROUND_H,W
	BANKSEL	LINECOLOUR_H
	MOVWF	LINECOLOUR_H
	BANKSEL	STATUS
	FCALL	FILLEDELLIPSE
;End If
GLOBAL	ENDIF5
ENDIF5:
;GLCD_Close_PageTransaction
;Macro Source: glcd_ssd1306.h (1192)
;Set cursor position
;Cursor_Position_SSD1306 ( 0, 8 * _GLCDPage )
	BANKSEL	LOCX
	CLRF	LOCX
	BANKSEL	_GLCDPAGE
	MOVF	_GLCDPAGE,W
	MOVWF	SYSBYTETEMPA
	MOVLW	8
	MOVWF	SYSBYTETEMPB
	BANKSEL	STATUS
	FCALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	BANKSEL	LOCY
	MOVWF	LOCY
	BANKSEL	STATUS
	FCALL	CURSOR_POSITION_SSD1306
;Send the buffer to the device using transaction
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1218)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	FCALL	HI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;HI2CSend 0x40
	MOVLW	64
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;for SSD1306_BufferLocationCalc = 1 to 128
;LEGACY METHOD
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC_H
GLOBAL	SYSFORLOOP7
SYSFORLOOP7:
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	INCF	SSD1306_BUFFERLOCATIONCALC,F
	BTFSC	STATUS,2
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F
;Write_Transaction_Data_SSD1306 SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
;Macro Source: glcd_ssd1306.h (1249)
;HI2CSend SSD1306SendByte
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;Clear the buffer byte. We need it to be empty for the next page operation
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	FSR0H
	CLRF	INDF0
;next
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	SYSWORDTEMPA
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	128
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSFORLOOP7
GLOBAL	SYSFORLOOPEND7
SYSFORLOOPEND7:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1282)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	FCALL	HI2CSTOP
;next
	MOVLW	3
	BANKSEL	_GLCDPAGE
	SUBWF	_GLCDPAGE,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP6
GLOBAL	SYSFORLOOPEND6
SYSFORLOOPEND6:
;longNumber = longNumber + 7
	MOVLW	7
	BANKSEL	LONGNUMBER
	ADDWF	LONGNUMBER,F
	MOVLW	0
	ADDWFC	LONGNUMBER_H,F
	MOVLW	0
	ADDWFC	LONGNUMBER_U,F
	MOVLW	0
	ADDWFC	LONGNUMBER_E,F
;Next
	MOVLW	127
	BANKSEL	CCOUNT
	SUBWF	CCOUNT,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP5
GLOBAL	SYSFORLOOPEND5
SYSFORLOOPEND5:
;Loop
	GOTO	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
;End
	GOTO	BASPROGRAMEND
;asm showdebug  GLCD SSD1306 buffer is 128bytes
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: GLCD.H (1536)
GLOBAL	CIRCLE
CIRCLE:
;dim  radiusErr, xradius as Integer
;xradius = Inxradius
	BANKSEL	INXRADIUS
	MOVF	INXRADIUS,W
	BANKSEL	XRADIUS
	MOVWF	XRADIUS
	BANKSEL	INXRADIUS_H
	MOVF	INXRADIUS_H,W
	BANKSEL	XRADIUS_H
	MOVWF	XRADIUS_H
;radiusErr = -(xradius/2)
	MOVF	XRADIUS,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	XRADIUS_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVLW	2
	MOVWF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSDIVSUBINT
	MOVF	SYSINTEGERTEMPA,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	MOVF	SYSINTEGERTEMPA_H,W
	MOVWF	SYSTEMP1_H
	COMF	SYSTEMP1,W
	BANKSEL	RADIUSERR
	MOVWF	RADIUSERR
	BANKSEL	SYSTEMP1_H
	COMF	SYSTEMP1_H,W
	BANKSEL	RADIUSERR_H
	MOVWF	RADIUSERR_H
	INCF	RADIUSERR,F
	BTFSC	STATUS,2
	INCF	RADIUSERR_H,F
;Do While xradius >=  yordinate
GLOBAL	SYSDOLOOP_S3
SYSDOLOOP_S3:
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	XRADIUS_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVF	YORDINATE,W
	MOVWF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHANINT
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	SYSDOLOOP_E3
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	ADDWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	ADDWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	ADDWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	ADDWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	SUBWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	ADDWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	SUBWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	ADDWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	SUBWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	SUBWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	SUBWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	SUBWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	ADDWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	SUBWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	ADDWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	SUBWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;yordinate ++
	BANKSEL	YORDINATE
	INCF	YORDINATE,F
;If radiusErr < 0 Then
	BANKSEL	RADIUSERR
	MOVF	RADIUSERR,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	RADIUSERR_H,W
	MOVWF	SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0
	GOTO	ELSE19_1
;radiusErr = radiusErr + 2 * yordinate + 1
	BCF	STATUS,0
	BANKSEL	YORDINATE
	RLF	YORDINATE,W
	MOVWF	SYSTEMP2
	BANKSEL	RADIUSERR
	ADDWF	RADIUSERR,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	MOVLW	0
	BANKSEL	RADIUSERR_H
	ADDWFC	RADIUSERR_H,W
	BANKSEL	SYSTEMP1_H
	MOVWF	SYSTEMP1_H
	MOVLW	1
	ADDWF	SYSTEMP1,W
	BANKSEL	RADIUSERR
	MOVWF	RADIUSERR
	MOVLW	0
	BANKSEL	SYSTEMP1_H
	ADDWFC	SYSTEMP1_H,W
	BANKSEL	RADIUSERR_H
	MOVWF	RADIUSERR_H
;else
	GOTO	ENDIF19
GLOBAL	ELSE19_1
ELSE19_1:
;xradius --
	MOVLW	1
	BANKSEL	XRADIUS
	SUBWF	XRADIUS,F
	MOVLW	0
	SUBWFB	XRADIUS_H,F
;radiusErr = radiusErr + 2 * (yordinate - xradius + 1)
	MOVF	XRADIUS,W
	SUBWF	YORDINATE,W
	MOVWF	SYSTEMP1
	CLRF	SYSTEMP2
	MOVF	XRADIUS_H,W
	SUBWFB	SYSTEMP2,W
	MOVWF	SYSTEMP1_H
	MOVLW	1
	ADDWF	SYSTEMP1,W
	MOVWF	SYSTEMP3
	MOVLW	0
	ADDWFC	SYSTEMP1_H,W
	MOVWF	SYSTEMP3_H
	MOVF	SYSTEMP3,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	SYSTEMP3_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVLW	2
	MOVWF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSMULTSUBINT
	MOVF	SYSINTEGERTEMPX,W
	BANKSEL	RADIUSERR
	ADDWF	RADIUSERR,F
	MOVF	SYSINTEGERTEMPX_H,W
	ADDWFC	RADIUSERR_H,F
;end if
GLOBAL	ENDIF19
ENDIF19:
;Loop
	GOTO	SYSDOLOOP_S3
GLOBAL	SYSDOLOOP_E3
SYSDOLOOP_E3:
	RETURN

;********************************************************************************

;SOURCE: GLCD.H (3622)
GLOBAL	DRAWELLIPSEROUTINE
DRAWELLIPSEROUTINE:
;Version 1.00 (08/20/2017) by Joseph Realmuto
;Version 1.01 (14/04/2019) by Giuseppe D'Elia
;draws an ellipse outline at location (xoffset, yoffset) if filled_ellipse = 0
;draws a filled ellipse at location (xoffset, yoffset) if filled_ellipse = 1
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;IF Inxradius = Inyradius THEN
;IF filled_ellipse = 0 THEN
;Circle Xoffset, Yoffset, Inxradius, LineColour
;ELSE
;FilledCircle Xoffset, Yoffset, Inxradius, LineColour
;END IF
;GLCD_exit sub
;END IF
;IF Inxradius<2 THEN exit sub
	BANKSEL	INXRADIUS
	MOVF	INXRADIUS,W
	MOVWF	SYSWORDTEMPA
	MOVF	INXRADIUS_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	2
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
;IF Inxradius<2 THEN exit sub
	RETURN
;IF Inxradius<2 THEN exit sub
;IF Inyradius<2 THEN exit sub
	BANKSEL	INYRADIUS
	MOVF	INYRADIUS,W
	MOVWF	SYSWORDTEMPA
	MOVF	INYRADIUS_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	2
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
;IF Inyradius<2 THEN exit sub
	RETURN
;IF Inyradius<2 THEN exit sub
;dim GLCD_xx, GLCD_yy, GLCD_rx2, GLCD_ry2 as Word
;dim  GLCD_fx2, GLCD_fy2, GLCD_ex2, GLCD_ey2 as Long
;dim GLCD_px, GLCD_py, GLCD_pp, GLCD_pp_temp as Long
;GLCD_rx2 = Inxradius * Inxradius
	BANKSEL	INXRADIUS
	MOVF	INXRADIUS,W
	MOVWF	SYSWORDTEMPA
	MOVF	INXRADIUS_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	INXRADIUS,W
	MOVWF	SYSWORDTEMPB
	MOVF	INXRADIUS_H,W
	MOVWF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSMULTSUB16
	MOVF	SYSWORDTEMPX,W
	MOVWF	GLCD_RX2
	MOVF	SYSWORDTEMPX_H,W
	MOVWF	GLCD_RX2_H
;GLCD_ry2 = Inyradius * Inyradius
	BANKSEL	INYRADIUS
	MOVF	INYRADIUS,W
	MOVWF	SYSWORDTEMPA
	MOVF	INYRADIUS_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	INYRADIUS,W
	MOVWF	SYSWORDTEMPB
	MOVF	INYRADIUS_H,W
	MOVWF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSMULTSUB16
	MOVF	SYSWORDTEMPX,W
	BANKSEL	GLCD_RY2
	MOVWF	GLCD_RY2
	MOVF	SYSWORDTEMPX_H,W
	MOVWF	GLCD_RY2_H
;GLCD_fx2 = 4 * GLCD_rx2
;GLCD_fx2 = GLCD_rx2 + GLCD_rx2
	BANKSEL	GLCD_RX2
	MOVF	GLCD_RX2,W
	ADDWF	GLCD_RX2,W
	MOVWF	GLCD_FX2
	MOVF	GLCD_RX2_H,W
	ADDWFC	GLCD_RX2_H,W
	MOVWF	GLCD_FX2_H
	CLRF	GLCD_FX2_U
	BTFSC	STATUS,0
	INCF	GLCD_FX2_U,F
	CLRF	GLCD_FX2_E
;GLCD_fx2 = GLCD_fx2 + GLCD_fx2
	MOVF	GLCD_FX2,W
	ADDWF	GLCD_FX2,F
	MOVF	GLCD_FX2_H,W
	ADDWFC	GLCD_FX2_H,F
	MOVF	GLCD_FX2_U,W
	ADDWFC	GLCD_FX2_U,F
	MOVF	GLCD_FX2_E,W
	ADDWFC	GLCD_FX2_E,F
;GLCD_fy2 = 4 * GLCD_ry2
;GLCD_fy2 = GLCD_ry2 + GLCD_ry2
	BANKSEL	GLCD_RY2
	MOVF	GLCD_RY2,W
	ADDWF	GLCD_RY2,W
	BANKSEL	GLCD_FY2
	MOVWF	GLCD_FY2
	BANKSEL	GLCD_RY2_H
	MOVF	GLCD_RY2_H,W
	ADDWFC	GLCD_RY2_H,W
	BANKSEL	GLCD_FY2_H
	MOVWF	GLCD_FY2_H
	CLRF	GLCD_FY2_U
	BTFSC	STATUS,0
	INCF	GLCD_FY2_U,F
	CLRF	GLCD_FY2_E
;GLCD_fy2 = GLCD_fy2 + GLCD_fy2
	MOVF	GLCD_FY2,W
	ADDWF	GLCD_FY2,F
	MOVF	GLCD_FY2_H,W
	ADDWFC	GLCD_FY2_H,F
	MOVF	GLCD_FY2_U,W
	ADDWFC	GLCD_FY2_U,F
	MOVF	GLCD_FY2_E,W
	ADDWFC	GLCD_FY2_E,F
;GLCD_ex2 = 2 * GLCD_fx2
;GLCD_ex2 = GLCD_fx2 + GLCD_fx2
	MOVF	GLCD_FX2,W
	ADDWF	GLCD_FX2,W
	MOVWF	GLCD_EX2
	MOVF	GLCD_FX2_H,W
	ADDWFC	GLCD_FX2_H,W
	MOVWF	GLCD_EX2_H
	MOVF	GLCD_FX2_U,W
	ADDWFC	GLCD_FX2_U,W
	MOVWF	GLCD_EX2_U
	MOVF	GLCD_FX2_E,W
	ADDWFC	GLCD_FX2_E,W
	MOVWF	GLCD_EX2_E
;GLCD_ey2 = 2 * GLCD_fy2
;GLCD_ey2 = GLCD_fy2 + GLCD_fy2
	MOVF	GLCD_FY2,W
	ADDWF	GLCD_FY2,W
	MOVWF	GLCD_EY2
	MOVF	GLCD_FY2_H,W
	ADDWFC	GLCD_FY2_H,W
	MOVWF	GLCD_EY2_H
	MOVF	GLCD_FY2_U,W
	ADDWFC	GLCD_FY2_U,W
	MOVWF	GLCD_EY2_U
	MOVF	GLCD_FY2_E,W
	ADDWFC	GLCD_FY2_E,W
	MOVWF	GLCD_EY2_E
;GLCD_xx = 0
	BANKSEL	GLCD_XX
	CLRF	GLCD_XX
	CLRF	GLCD_XX_H
;GLCD_yy = Inyradius
	MOVF	INYRADIUS,W
	MOVWF	GLCD_YY
	MOVF	INYRADIUS_H,W
	MOVWF	GLCD_YY_H
;GLCD_px = 0
	BANKSEL	GLCD_PX
	CLRF	GLCD_PX
	CLRF	GLCD_PX_H
	CLRF	GLCD_PX_U
	CLRF	GLCD_PX_E
;GLCD_py = GLCD_ex2 * GLCD_yy
	MOVF	GLCD_EX2,W
	MOVWF	SYSLONGTEMPA
	MOVF	GLCD_EX2_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	GLCD_EX2_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	GLCD_EX2_E,W
	MOVWF	SYSLONGTEMPA_E
	BANKSEL	GLCD_YY
	MOVF	GLCD_YY,W
	MOVWF	SYSLONGTEMPB
	MOVF	GLCD_YY_H,W
	MOVWF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	BANKSEL	STATUS
	FCALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	GLCD_PY
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	GLCD_PY_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	GLCD_PY_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	GLCD_PY_E
;GLCD_pp = 2 + GLCD_fy2 -  GLCD_fx2 * Inyradius + GLCD_rx2
;GLCD_pp_temp = GLCD_fx2 * Inyradius
	MOVF	GLCD_FX2,W
	MOVWF	SYSLONGTEMPA
	MOVF	GLCD_FX2_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	GLCD_FX2_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	GLCD_FX2_E,W
	MOVWF	SYSLONGTEMPA_E
	BANKSEL	INYRADIUS
	MOVF	INYRADIUS,W
	MOVWF	SYSLONGTEMPB
	MOVF	INYRADIUS_H,W
	MOVWF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	BANKSEL	STATUS
	FCALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	GLCD_PP_TEMP
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	GLCD_PP_TEMP_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	GLCD_PP_TEMP_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	GLCD_PP_TEMP_E
;GLCD_pp = 2 + GLCD_fy2
	MOVLW	2
	ADDWF	GLCD_FY2,W
	MOVWF	GLCD_PP
	MOVLW	0
	ADDWFC	GLCD_FY2_H,W
	MOVWF	GLCD_PP_H
	MOVLW	0
	ADDWFC	GLCD_FY2_U,W
	MOVWF	GLCD_PP_U
	MOVLW	0
	ADDWFC	GLCD_FY2_E,W
	MOVWF	GLCD_PP_E
;GLCD_pp = GLCD_pp + GLCD_rx2
	MOVF	GLCD_RX2,W
	ADDWF	GLCD_PP,F
	MOVF	GLCD_RX2_H,W
	ADDWFC	GLCD_PP_H,F
	MOVLW	0
	ADDWFC	GLCD_PP_U,F
	MOVLW	0
	ADDWFC	GLCD_PP_E,F
;GLCD_pp = GLCD_pp - GLCD_pp_temp
	MOVF	GLCD_PP_TEMP,W
	SUBWF	GLCD_PP,F
	MOVF	GLCD_PP_TEMP_H,W
	SUBWFB	GLCD_PP_H,F
	MOVF	GLCD_PP_TEMP_U,W
	SUBWFB	GLCD_PP_U,F
	MOVF	GLCD_PP_TEMP_E,W
	SUBWFB	GLCD_PP_E,F
;IF filled_ellipse = 0 THEN
	MOVF	FILLED_ELLIPSE,F
	BTFSS	STATUS,2
	GOTO	ELSE22_1
;Draw_Ellipse_Points
	FCALL	DRAW_ELLIPSE_POINTS
;ELSE
	GOTO	ENDIF22
GLOBAL	ELSE22_1
ELSE22_1:
;Draw_Filled_Ellipse_Points
	FCALL	DRAW_FILLED_ELLIPSE_POINTS
;END IF
GLOBAL	ENDIF22
ENDIF22:
;DO WHILE GLCD_px < GLCD_py
GLOBAL	SYSDOLOOP_S4
SYSDOLOOP_S4:
	MOVF	GLCD_PX,W
	MOVWF	SYSLONGTEMPA
	MOVF	GLCD_PX_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	GLCD_PX_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	GLCD_PX_E,W
	MOVWF	SYSLONGTEMPA_E
	MOVF	GLCD_PY,W
	MOVWF	SYSLONGTEMPB
	MOVF	GLCD_PY_H,W
	MOVWF	SYSLONGTEMPB_H
	MOVF	GLCD_PY_U,W
	MOVWF	SYSLONGTEMPB_U
	MOVF	GLCD_PY_E,W
	MOVWF	SYSLONGTEMPB_E
	FCALL	SYSCOMPLESSTHAN32
	BTFSS	SYSBYTETEMPX,0
	GOTO	SYSDOLOOP_E4
;GLCD_xx++
	BANKSEL	GLCD_XX
	INCF	GLCD_XX,F
	BTFSC	STATUS,2
	INCF	GLCD_XX_H,F
;GLCD_px = GLCD_px + GLCD_ey2
	BANKSEL	GLCD_EY2
	MOVF	GLCD_EY2,W
	ADDWF	GLCD_PX,F
	MOVF	GLCD_EY2_H,W
	ADDWFC	GLCD_PX_H,F
	MOVF	GLCD_EY2_U,W
	ADDWFC	GLCD_PX_U,F
	MOVF	GLCD_EY2_E,W
	ADDWFC	GLCD_PX_E,F
;IF GLCD_pp_E.7 = 0 THEN
	BTFSC	GLCD_PP_E,7
	GOTO	ENDIF23
;GLCD_yy--
	MOVLW	1
	BANKSEL	GLCD_YY
	SUBWF	GLCD_YY,F
	MOVLW	0
	SUBWFB	GLCD_YY_H,F
;GLCD_py = GLCD_py - GLCD_ex2
	BANKSEL	GLCD_EX2
	MOVF	GLCD_EX2,W
	SUBWF	GLCD_PY,F
	MOVF	GLCD_EX2_H,W
	SUBWFB	GLCD_PY_H,F
	MOVF	GLCD_EX2_U,W
	SUBWFB	GLCD_PY_U,F
	MOVF	GLCD_EX2_E,W
	SUBWFB	GLCD_PY_E,F
;GLCD_pp = GLCD_pp - GLCD_py
	MOVF	GLCD_PY,W
	SUBWF	GLCD_PP,F
	MOVF	GLCD_PY_H,W
	SUBWFB	GLCD_PP_H,F
	MOVF	GLCD_PY_U,W
	SUBWFB	GLCD_PP_U,F
	MOVF	GLCD_PY_E,W
	SUBWFB	GLCD_PP_E,F
;END IF
GLOBAL	ENDIF23
ENDIF23:
;GLCD_pp = GLCD_pp + GLCD_fy2 + GLCD_px
;GLCD_pp = GLCD_pp + GLCD_fy2
	MOVF	GLCD_FY2,W
	ADDWF	GLCD_PP,F
	MOVF	GLCD_FY2_H,W
	ADDWFC	GLCD_PP_H,F
	MOVF	GLCD_FY2_U,W
	ADDWFC	GLCD_PP_U,F
	MOVF	GLCD_FY2_E,W
	ADDWFC	GLCD_PP_E,F
;GLCD_pp = GLCD_pp + GLCD_px
	MOVF	GLCD_PX,W
	ADDWF	GLCD_PP,F
	MOVF	GLCD_PX_H,W
	ADDWFC	GLCD_PP_H,F
	MOVF	GLCD_PX_U,W
	ADDWFC	GLCD_PP_U,F
	MOVF	GLCD_PX_E,W
	ADDWFC	GLCD_PP_E,F
;IF filled_ellipse = 0 THEN
	MOVF	FILLED_ELLIPSE,F
	BTFSS	STATUS,2
	GOTO	ELSE24_1
;Draw_Ellipse_Points
	FCALL	DRAW_ELLIPSE_POINTS
;ELSE
	GOTO	ENDIF24
GLOBAL	ELSE24_1
ELSE24_1:
;Draw_Filled_Ellipse_Points
	FCALL	DRAW_FILLED_ELLIPSE_POINTS
;END IF
GLOBAL	ENDIF24
ENDIF24:
;LOOP
	GOTO	SYSDOLOOP_S4
GLOBAL	SYSDOLOOP_E4
SYSDOLOOP_E4:
;GLCD_pp = 2 + GLCD_ry2 * (2 * GLCD_xx + 1) * (2 * GLCD_xx + 1) + GLCD_fx2 * (GLCD_yy - 1) * (GLCD_yy - 1) -  GLCD_fx2 * GLCD_ry2
;change GLCD_xx and GLCD_yy to do calculation
;GLCD_xx = GLCD_xx + GLCD_xx
	BANKSEL	GLCD_XX
	MOVF	GLCD_XX,W
	ADDWF	GLCD_XX,F
	MOVF	GLCD_XX_H,W
	ADDWFC	GLCD_XX_H,F
;GLCD_xx++
	INCF	GLCD_XX,F
	BTFSC	STATUS,2
	INCF	GLCD_XX_H,F
;GLCD_yy--
	MOVLW	1
	SUBWF	GLCD_YY,F
	MOVLW	0
	SUBWFB	GLCD_YY_H,F
;GLCD_pp_temp = GLCD_xx * GLCD_xx
	MOVF	GLCD_XX,W
	MOVWF	SYSLONGTEMPA
	MOVF	GLCD_XX_H,W
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	MOVF	GLCD_XX,W
	MOVWF	SYSLONGTEMPB
	MOVF	GLCD_XX_H,W
	MOVWF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	BANKSEL	STATUS
	FCALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	GLCD_PP_TEMP
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	GLCD_PP_TEMP_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	GLCD_PP_TEMP_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	GLCD_PP_TEMP_E
;GLCD_pp_temp = GLCD_ry2 * GLCD_pp_temp
	BANKSEL	GLCD_RY2
	MOVF	GLCD_RY2,W
	MOVWF	SYSLONGTEMPA
	MOVF	GLCD_RY2_H,W
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	BANKSEL	GLCD_PP_TEMP
	MOVF	GLCD_PP_TEMP,W
	MOVWF	SYSLONGTEMPB
	MOVF	GLCD_PP_TEMP_H,W
	MOVWF	SYSLONGTEMPB_H
	MOVF	GLCD_PP_TEMP_U,W
	MOVWF	SYSLONGTEMPB_U
	MOVF	GLCD_PP_TEMP_E,W
	MOVWF	SYSLONGTEMPB_E
	FCALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	GLCD_PP_TEMP
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	GLCD_PP_TEMP_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	GLCD_PP_TEMP_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	GLCD_PP_TEMP_E
;GLCD_pp = 2 + GLCD_pp_temp
	MOVLW	2
	ADDWF	GLCD_PP_TEMP,W
	MOVWF	GLCD_PP
	MOVLW	0
	ADDWFC	GLCD_PP_TEMP_H,W
	MOVWF	GLCD_PP_H
	MOVLW	0
	ADDWFC	GLCD_PP_TEMP_U,W
	MOVWF	GLCD_PP_U
	MOVLW	0
	ADDWFC	GLCD_PP_TEMP_E,W
	MOVWF	GLCD_PP_E
;GLCD_pp_temp = GLCD_yy * GLCD_yy
	BANKSEL	GLCD_YY
	MOVF	GLCD_YY,W
	MOVWF	SYSLONGTEMPA
	MOVF	GLCD_YY_H,W
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	MOVF	GLCD_YY,W
	MOVWF	SYSLONGTEMPB
	MOVF	GLCD_YY_H,W
	MOVWF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	BANKSEL	STATUS
	FCALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	GLCD_PP_TEMP
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	GLCD_PP_TEMP_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	GLCD_PP_TEMP_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	GLCD_PP_TEMP_E
;GLCD_pp_temp = GLCD_fx2 * GLCD_pp_temp
	MOVF	GLCD_FX2,W
	MOVWF	SYSLONGTEMPA
	MOVF	GLCD_FX2_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	GLCD_FX2_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	GLCD_FX2_E,W
	MOVWF	SYSLONGTEMPA_E
	MOVF	GLCD_PP_TEMP,W
	MOVWF	SYSLONGTEMPB
	MOVF	GLCD_PP_TEMP_H,W
	MOVWF	SYSLONGTEMPB_H
	MOVF	GLCD_PP_TEMP_U,W
	MOVWF	SYSLONGTEMPB_U
	MOVF	GLCD_PP_TEMP_E,W
	MOVWF	SYSLONGTEMPB_E
	FCALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	GLCD_PP_TEMP
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	GLCD_PP_TEMP_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	GLCD_PP_TEMP_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	GLCD_PP_TEMP_E
;GLCD_pp = GLCD_pp + GLCD_pp_temp
	MOVF	GLCD_PP_TEMP,W
	ADDWF	GLCD_PP,F
	MOVF	GLCD_PP_TEMP_H,W
	ADDWFC	GLCD_PP_H,F
	MOVF	GLCD_PP_TEMP_U,W
	ADDWFC	GLCD_PP_U,F
	MOVF	GLCD_PP_TEMP_E,W
	ADDWFC	GLCD_PP_E,F
;GLCD_pp_temp = GLCD_fx2 * GLCD_ry2
	MOVF	GLCD_FX2,W
	MOVWF	SYSLONGTEMPA
	MOVF	GLCD_FX2_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	GLCD_FX2_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	GLCD_FX2_E,W
	MOVWF	SYSLONGTEMPA_E
	BANKSEL	GLCD_RY2
	MOVF	GLCD_RY2,W
	MOVWF	SYSLONGTEMPB
	MOVF	GLCD_RY2_H,W
	MOVWF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	BANKSEL	STATUS
	FCALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	GLCD_PP_TEMP
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	GLCD_PP_TEMP_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	GLCD_PP_TEMP_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	GLCD_PP_TEMP_E
;GLCD_pp = GLCD_pp - GLCD_pp_temp
	MOVF	GLCD_PP_TEMP,W
	SUBWF	GLCD_PP,F
	MOVF	GLCD_PP_TEMP_H,W
	SUBWFB	GLCD_PP_H,F
	MOVF	GLCD_PP_TEMP_U,W
	SUBWFB	GLCD_PP_U,F
	MOVF	GLCD_PP_TEMP_E,W
	SUBWFB	GLCD_PP_E,F
;restore original GLCD_xx and GLCD_yy values
;GLCD_xx--
	MOVLW	1
	BANKSEL	GLCD_XX
	SUBWF	GLCD_XX,F
	MOVLW	0
	SUBWFB	GLCD_XX_H,F
;GLCD_xx/2
;set C off
	BCF	STATUS,0
;rotate GLCD_xx_H right
	RRF	GLCD_XX_H,F
;rotate GLCD_xx right
	RRF	GLCD_XX_H,F
	RRF	GLCD_XX,F
;GLCD_yy++
	INCF	GLCD_YY,F
	BTFSC	STATUS,2
	INCF	GLCD_YY_H,F
;DO WHILE GLCD_yy > 0
GLOBAL	SYSDOLOOP_S5
SYSDOLOOP_S5:
	BANKSEL	GLCD_YY
	MOVF	GLCD_YY,W
	MOVWF	SYSWORDTEMPB
	MOVF	GLCD_YY_H,W
	MOVWF	SYSWORDTEMPB_H
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0
	GOTO	SYSDOLOOP_E5
;GLCD_yy--
	MOVLW	1
	BANKSEL	GLCD_YY
	SUBWF	GLCD_YY,F
	MOVLW	0
	SUBWFB	GLCD_YY_H,F
;GLCD_py = GLCD_py - GLCD_ex2
	BANKSEL	GLCD_EX2
	MOVF	GLCD_EX2,W
	SUBWF	GLCD_PY,F
	MOVF	GLCD_EX2_H,W
	SUBWFB	GLCD_PY_H,F
	MOVF	GLCD_EX2_U,W
	SUBWFB	GLCD_PY_U,F
	MOVF	GLCD_EX2_E,W
	SUBWFB	GLCD_PY_E,F
;IF GLCD_pp_E.7 = 1 THEN
	BTFSS	GLCD_PP_E,7
	GOTO	ENDIF25
;GLCD_xx++
	BANKSEL	GLCD_XX
	INCF	GLCD_XX,F
	BTFSC	STATUS,2
	INCF	GLCD_XX_H,F
;GLCD_px = GLCD_px + GLCD_ey2
	BANKSEL	GLCD_EY2
	MOVF	GLCD_EY2,W
	ADDWF	GLCD_PX,F
	MOVF	GLCD_EY2_H,W
	ADDWFC	GLCD_PX_H,F
	MOVF	GLCD_EY2_U,W
	ADDWFC	GLCD_PX_U,F
	MOVF	GLCD_EY2_E,W
	ADDWFC	GLCD_PX_E,F
;GLCD_pp = GLCD_pp + GLCD_px
	MOVF	GLCD_PX,W
	ADDWF	GLCD_PP,F
	MOVF	GLCD_PX_H,W
	ADDWFC	GLCD_PP_H,F
	MOVF	GLCD_PX_U,W
	ADDWFC	GLCD_PP_U,F
	MOVF	GLCD_PX_E,W
	ADDWFC	GLCD_PP_E,F
;END IF
GLOBAL	ENDIF25
ENDIF25:
;GLCD_pp = GLCD_pp + GLCD_fx2 - GLCD_py
;GLCD_pp = GLCD_pp + GLCD_fx2
	MOVF	GLCD_FX2,W
	ADDWF	GLCD_PP,F
	MOVF	GLCD_FX2_H,W
	ADDWFC	GLCD_PP_H,F
	MOVF	GLCD_FX2_U,W
	ADDWFC	GLCD_PP_U,F
	MOVF	GLCD_FX2_E,W
	ADDWFC	GLCD_PP_E,F
;GLCD_pp = GLCD_pp - GLCD_py
	MOVF	GLCD_PY,W
	SUBWF	GLCD_PP,F
	MOVF	GLCD_PY_H,W
	SUBWFB	GLCD_PP_H,F
	MOVF	GLCD_PY_U,W
	SUBWFB	GLCD_PP_U,F
	MOVF	GLCD_PY_E,W
	SUBWFB	GLCD_PP_E,F
;IF filled_ellipse = 0 THEN
	MOVF	FILLED_ELLIPSE,F
	BTFSS	STATUS,2
	GOTO	ELSE26_1
;Draw_Ellipse_Points
	FCALL	DRAW_ELLIPSE_POINTS
;ELSE
	GOTO	ENDIF26
GLOBAL	ELSE26_1
ELSE26_1:
;Draw_Filled_Ellipse_Points
	FCALL	DRAW_FILLED_ELLIPSE_POINTS
;END IF
GLOBAL	ENDIF26
ENDIF26:
;LOOP
	GOTO	SYSDOLOOP_S5
GLOBAL	SYSDOLOOP_E5
SYSDOLOOP_E5:
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (709)
GLOBAL	HI2CINIT
HI2CINIT:
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K42s family chips
;HI2CCurrentMode = 0
	BANKSEL	HI2CCURRENTMODE
	CLRF	HI2CCURRENTMODE
;Initialise the I2C module
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (317)
GLOBAL	INITGLCD_SSD1306
INITGLCD_SSD1306:
;Colours //Set these first
;GLCDBackground = 0
	CLRF	GLCDBACKGROUND
	CLRF	GLCDBACKGROUND_H
;GLCDForeground = 1
	MOVLW	1
	MOVWF	GLCDFOREGROUND
	CLRF	GLCDFOREGROUND_H
;GLCDFontWidth = 5
	MOVLW	5
	MOVWF	GLCDFONTWIDTH
;GLCDfntDefaultHeight = 7  'used by GLCDPrintString and GLCDPrintStringLn
	MOVLW	7
	MOVWF	GLCDFNTDEFAULTHEIGHT
;dim PrintLocX, PrintLocY as word
;GLCDfntDefault = 0
	CLRF	GLCDFNTDEFAULT
;GLCDfntDefaultsize = 1
	MOVLW	1
	MOVWF	GLCDFNTDEFAULTSIZE
;wait 255 ms             'added to ensure the charge pump and power is operational.
	MOVLW	255
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	FCALL	DELAY_MS
;HI2CMode Master
	MOVLW	12
	BANKSEL	HI2CCURRENTMODE
	MOVWF	HI2CCURRENTMODE
	BANKSEL	STATUS
	FCALL	HI2CMODE
;Wait 15 ms  'wait for power-up and reset
	MOVLW	15
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	FCALL	DELAY_MS
;Setup code for SSD1306 controllers
;Init sequence for 128x64 OLED module
;Write_Command_SSD1306(SSD1306_DISPLAYOFF)                    ' 0xAE
	MOVLW	174
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DEACTIVATE_SCROLL)
	MOVLW	46
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYCLOCKDIV)            ' 0xD5
	MOVLW	213
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x80)                                  ' the suggested ratio 0x80
	MOVLW	128
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETMULTIPLEX)                  ' 0xA8
	MOVLW	168
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x1f)                                 '32 pixels
	MOVLW	31
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYOFFSET)              ' 0xD3
	MOVLW	211
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x00)                                   ' no offset
	BANKSEL	SSD1306SENDBYTE
	CLRF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETSTARTLINE | 0x00)            ' line #0
	MOVLW	64
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_CHARGEPUMP)                    ' 0x8D
	MOVLW	141
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;if (SSD1306_vccstate = SSD1306_EXTERNALVCC) then
;Write_Command_SSD1306(0x14)
	MOVLW	20
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_MEMORYMODE)                    ' 0x20
	MOVLW	32
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x00)                                  ' 0x00 act like ks0108 - DO NOT SELECT!!
;Write_Command_SSD1306(0x10)                                  ' 0x01 act like PCD8544
	MOVLW	16
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SEGREMAP | 0x1)
	MOVLW	161
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_COMSCANDEC)
	MOVLW	200
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCOMPINS)                    ' 0xDA
	MOVLW	218
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x02)                                 '32 pixels
	MOVLW	2
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCONTRAST)                   ' 0x81
	MOVLW	129
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xCF)
	MOVLW	207
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETPRECHARGE)                  ' 0xd9
	MOVLW	217
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xF1)
	MOVLW	241
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETVCOMDETECT)                 ' 0xDB
	MOVLW	219
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x40)
	MOVLW	64
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYALLON_RESUME)           ' 0xA4
	MOVLW	164
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_NORMALDISPLAY)                 ' 0xA6
	MOVLW	166
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;Clear screen Here
;GLCDCLS_SSD1306
	FCALL	GLCDCLS_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYON)                     '--turn on oled panel
	MOVLW	175
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	LJMP	WRITE_COMMAND_SSD1306

;********************************************************************************

;SOURCE: 200_I2C_GLCD_USING_SSD1306_128_32.GCB (28)
GLOBAL	INITPPS
INITPPS:
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

;SOURCE: SYSTEM.H (1374)
GLOBAL	SYSCOPYSTRING
SYSCOPYSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length
;movf INDF0, W
	MOVF	INDF0, W
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;movwf INDF1
	MOVWF	INDF1
;goto SysCopyStringCheck
	GOTO	SYSCOPYSTRINGCHECK
;When appending, add length to counter
GLOBAL	SYSCOPYSTRINGPART
SYSCOPYSTRINGPART:
;movf INDF0, W
	MOVF	INDF0, W
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;addwf SysStringLength, F
	ADDWF	SYSSTRINGLENGTH, F
GLOBAL	SYSCOPYSTRINGCHECK
SYSCOPYSTRINGCHECK:
;Exit if length = 0
;movf SysCalcTempA,F
	MOVF	SYSCALCTEMPA,F
;btfsc STATUS,Z
	BTFSC	STATUS,2
;return
	RETURN
GLOBAL	SYSSTRINGCOPY
SYSSTRINGCOPY:
;Increment pointers
;addfsr 0, 1
	ADDFSR	0, 1
;addfsr 1, 1
	ADDFSR	1, 1
;Copy character
;movf INDF0, W
	MOVF	INDF0, W
;movwf INDF1
	MOVWF	INDF1
;decfsz SysCalcTempA, F
	DECFSZ	SYSCALCTEMPA, F
;goto SysStringCopy
	GOTO	SYSSTRINGCOPY
	RETURN

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 1
	PSECT	PROGMEM1,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	2048
;SOURCE: GLCD.H (1489)
GLOBAL	BOX
BOX:
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	BANKSEL	LINEX1
	MOVF	LINEX1,W
	MOVWF	SYSWORDTEMPB
	MOVF	LINEX1_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVF	LINEX2,W
	MOVWF	SYSWORDTEMPA
	MOVF	LINEX2_H,W
	MOVWF	SYSWORDTEMPA_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF15
;GLCDTemp = LineX1
	BANKSEL	LINEX1
	MOVF	LINEX1,W
	BANKSEL	GLCDTEMP
	MOVWF	GLCDTEMP
	BANKSEL	LINEX1_H
	MOVF	LINEX1_H,W
	BANKSEL	GLCDTEMP_H
	MOVWF	GLCDTEMP_H
;LineX1 = LineX2
	BANKSEL	LINEX2
	MOVF	LINEX2,W
	MOVWF	LINEX1
	MOVF	LINEX2_H,W
	MOVWF	LINEX1_H
;LineX2 = GLCDTemp
	BANKSEL	GLCDTEMP
	MOVF	GLCDTEMP,W
	BANKSEL	LINEX2
	MOVWF	LINEX2
	BANKSEL	GLCDTEMP_H
	MOVF	GLCDTEMP_H,W
	BANKSEL	LINEX2_H
	MOVWF	LINEX2_H
;End If
GLOBAL	ENDIF15
ENDIF15:
;If LineY1 > LineY2 Then
	BANKSEL	LINEY1
	MOVF	LINEY1,W
	MOVWF	SYSWORDTEMPB
	MOVF	LINEY1_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVF	LINEY2,W
	MOVWF	SYSWORDTEMPA
	MOVF	LINEY2_H,W
	MOVWF	SYSWORDTEMPA_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF16
;GLCDTemp = LineY1
	BANKSEL	LINEY1
	MOVF	LINEY1,W
	BANKSEL	GLCDTEMP
	MOVWF	GLCDTEMP
	BANKSEL	LINEY1_H
	MOVF	LINEY1_H,W
	BANKSEL	GLCDTEMP_H
	MOVWF	GLCDTEMP_H
;LineY1 = LineY2
	BANKSEL	LINEY2
	MOVF	LINEY2,W
	MOVWF	LINEY1
	MOVF	LINEY2_H,W
	MOVWF	LINEY1_H
;LineY2 = GLCDTemp
	BANKSEL	GLCDTEMP
	MOVF	GLCDTEMP,W
	BANKSEL	LINEY2
	MOVWF	LINEY2
	BANKSEL	GLCDTEMP_H
	MOVF	GLCDTEMP_H,W
	BANKSEL	LINEY2_H
	MOVWF	LINEY2_H
;End If
GLOBAL	ENDIF16
ENDIF16:
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	BANKSEL	LINEX1
	MOVF	LINEX1,W
	BANKSEL	DRAWLINE
	MOVWF	DRAWLINE
	BANKSEL	LINEX1_H
	MOVF	LINEX1_H,W
	BANKSEL	DRAWLINE_H
	MOVWF	DRAWLINE_H
GLOBAL	SYSFORLOOP11
SYSFORLOOP11:
;PSet DrawLine, LineY1, LineColour
	MOVF	DRAWLINE,W
	MOVWF	GLCDX
	BANKSEL	LINEY1
	MOVF	LINEY1,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;PSet DrawLine, LineY2, LineColour
	MOVF	DRAWLINE,W
	MOVWF	GLCDX
	BANKSEL	LINEY2
	MOVF	LINEY2,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	MOVF	DRAWLINE,W
	BANKSEL	LINEX2
	SUBWF	LINEX2,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	DRAWLINE_H
	MOVF	DRAWLINE_H,W
	BANKSEL	LINEX2_H
	SUBWFB	LINEX2_H,W
	BANKSEL	SYSTEMP1_H
	MOVWF	SYSTEMP1_H
	MOVF	SYSTEMP1,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF17
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	DRAWLINE,F
	BTFSC	STATUS,2
	INCF	DRAWLINE_H,F
	GOTO	SYSFORLOOP11
;END IF
GLOBAL	ENDIF17
ENDIF17:
GLOBAL	SYSFORLOOPEND11
SYSFORLOOPEND11:
;Draw lines going down
;For DrawLine = LineY1 To LineY2
	BANKSEL	LINEY1
	MOVF	LINEY1,W
	BANKSEL	DRAWLINE
	MOVWF	DRAWLINE
	BANKSEL	LINEY1_H
	MOVF	LINEY1_H,W
	BANKSEL	DRAWLINE_H
	MOVWF	DRAWLINE_H
GLOBAL	SYSFORLOOP12
SYSFORLOOP12:
;PSet LineX1, DrawLine, LineColour
	BANKSEL	LINEX1
	MOVF	LINEX1,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	MOVF	DRAWLINE,W
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;PSet LineX2, DrawLine, LineColour
	BANKSEL	LINEX2
	MOVF	LINEX2,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	MOVF	DRAWLINE,W
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	MOVF	DRAWLINE,W
	BANKSEL	LINEY2
	SUBWF	LINEY2,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	DRAWLINE_H
	MOVF	DRAWLINE_H,W
	BANKSEL	LINEY2_H
	SUBWFB	LINEY2_H,W
	BANKSEL	SYSTEMP1_H
	MOVWF	SYSTEMP1_H
	MOVF	SYSTEMP1,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF18
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	DRAWLINE,F
	BTFSC	STATUS,2
	INCF	DRAWLINE_H,F
	GOTO	SYSFORLOOP12
;END IF
GLOBAL	ENDIF18
ENDIF18:
GLOBAL	SYSFORLOOPEND12
SYSFORLOOPEND12:
	RETURN

;********************************************************************************

GLOBAL	GLCDCHARCOL3
GLCDCHARCOL3:
	MOVLW	113
	SUBWF	SYSSTRINGA, W
	BTFSC	STATUS,0
	RETLW	0
	MOVF	SYSSTRINGA, W
	ADDLW	LOW TABLEGLCDCHARCOL3
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH TABLEGLCDCHARCOL3) & 127
	BTFSC	STATUS,0
	ADDLW	1
	MOVWF	PCLATH
	MOVF	SYSSTRINGA, W
	MOVWF	PCL
GLOBAL	TABLEGLCDCHARCOL3
TABLEGLCDCHARCOL3:
	RETLW	112
	RETLW	0
	RETLW	16
	RETLW	12
	RETLW	10
	RETLW	136
	RETLW	34
	RETLW	56
	RETLW	32
	RETLW	8
	RETLW	32
	RETLW	16
	RETLW	16
	RETLW	128
	RETLW	128
	RETLW	64
	RETLW	4
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	40
	RETLW	72
	RETLW	70
	RETLW	108
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	40
	RETLW	16
	RETLW	0
	RETLW	16
	RETLW	0
	RETLW	64
	RETLW	124
	RETLW	0
	RETLW	132
	RETLW	130
	RETLW	48
	RETLW	78
	RETLW	120
	RETLW	6
	RETLW	108
	RETLW	12
	RETLW	0
	RETLW	0
	RETLW	16
	RETLW	40
	RETLW	0
	RETLW	4
	RETLW	100
	RETLW	248
	RETLW	254
	RETLW	124
	RETLW	254
	RETLW	254
	RETLW	254
	RETLW	124
	RETLW	254
	RETLW	0
	RETLW	64
	RETLW	254
	RETLW	254
	RETLW	254
	RETLW	254
	RETLW	124
	RETLW	254
	RETLW	124
	RETLW	254
	RETLW	76
	RETLW	2
	RETLW	126
	RETLW	62
	RETLW	126
	RETLW	198
	RETLW	14
	RETLW	194
	RETLW	0
	RETLW	4
	RETLW	0
	RETLW	8
	RETLW	128
	RETLW	0
	RETLW	64
	RETLW	254
	RETLW	112
	RETLW	112
	RETLW	112
	RETLW	16
	RETLW	16
	RETLW	254
	RETLW	0
	RETLW	64
	RETLW	254
	RETLW	0
	RETLW	248
	RETLW	248
	RETLW	112
	RETLW	248
	RETLW	16
	RETLW	248
	RETLW	144
	RETLW	16
	RETLW	120
	RETLW	56
	RETLW	120
	RETLW	136
	RETLW	24
	RETLW	136
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	32
	RETLW	120

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (427)
GLOBAL	GLCDCLS_SSD1306
GLCDCLS_SSD1306:
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	BANKSEL	GLCD_YORDINATE
	CLRF	GLCD_YORDINATE
	CLRF	GLCD_YORDINATE_H
;For SSD1306_BufferLocationCalc = 0 to 128
;LEGACY METHOD
	MOVLW	255
	MOVWF	SSD1306_BUFFERLOCATIONCALC
	MOVWF	SSD1306_BUFFERLOCATIONCALC_H
GLOBAL	SYSFORLOOP14
SYSFORLOOP14:
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	INCF	SSD1306_BUFFERLOCATIONCALC,F
	BTFSC	STATUS,2
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	FSR0H
	CLRF	INDF0
;Next
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	SYSWORDTEMPA
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	128
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSFORLOOP14
GLOBAL	SYSFORLOOPEND14
SYSFORLOOPEND14:
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC_H
GLOBAL	SYSFORLOOP15
SYSFORLOOP15:
;INIT SYSFORLOOPSTEP14 :#0
	MOVLW	8
	MOVWF	SYSFORLOOPSTEP14
	CLRF	SYSFORLOOPSTEP14_H
;Cursor_Position_SSD1306 ( 0 , SSD1306_BufferLocationCalc )
	CLRF	LOCX
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	LOCY
	BANKSEL	STATUS
	FCALL	CURSOR_POSITION_SSD1306
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1218)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	FCALL	HI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;HI2CSend 0x40
	MOVLW	64
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;For GLCDTemp = 0 to 127
;LEGACY METHOD
	MOVLW	255
	MOVWF	GLCDTEMP
GLOBAL	SYSFORLOOP16
SYSFORLOOP16:
	INCF	GLCDTEMP,F
;Write_Transaction_Data_SSD1306(GLCDBackground)
;Macro Source: glcd_ssd1306.h (1249)
;HI2CSend SSD1306SendByte
	MOVF	GLCDBACKGROUND,W
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;Next
	MOVLW	127
	SUBWF	GLCDTEMP,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP16
GLOBAL	SYSFORLOOPEND16
SYSFORLOOPEND16:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1282)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	FCALL	HI2CSTOP
;Next
;INTEGER NEGATIVE STEP HANDLER IN FOR-NEXT STATEMENT
	BANKSEL	SYSFORLOOPSTEP14_H
	BTFSS	SYSFORLOOPSTEP14_H,7
	GOTO	ELSE30_1
;SET SYSFORLOOPABSVALUE TO -STEPVALUE :#1 
	COMF	SYSFORLOOPSTEP14,W
	MOVWF	SYSFORLOOPABSVALUE15
	COMF	SYSFORLOOPSTEP14_H,W
	MOVWF	SYSFORLOOPABSVALUE15_H
	INCF	SYSFORLOOPABSVALUE15,F
	BTFSC	STATUS,2
	INCF	SYSFORLOOPABSVALUE15_H,F
;IF ( SSD1306_BUFFERLOCATIONCALC - 32-1) } [WORD]SYSFORLOOPABSVALUE15 THEN  :#1N 
	MOVLW	32
	SUBWF	SSD1306_BUFFERLOCATIONCALC,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	MOVLW	0
	BANKSEL	SSD1306_BUFFERLOCATIONCALC_H
	SUBWFB	SSD1306_BUFFERLOCATIONCALC_H,W
	BANKSEL	SYSTEMP1_H
	MOVWF	SYSTEMP1_H
	MOVLW	1
	SUBWF	SYSTEMP1,W
	MOVWF	SYSTEMP3
	MOVLW	0
	SUBWFB	SYSTEMP1_H,W
	MOVWF	SYSTEMP3_H
	MOVF	SYSTEMP3,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP3_H,W
	MOVWF	SYSWORDTEMPA_H
	BANKSEL	SYSFORLOOPABSVALUE15
	MOVF	SYSFORLOOPABSVALUE15,W
	MOVWF	SYSWORDTEMPB
	MOVF	SYSFORLOOPABSVALUE15_H,W
	MOVWF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF31
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A NEGATIVE VALUE
	BANKSEL	SYSFORLOOPSTEP14
	MOVF	SYSFORLOOPSTEP14,W
	ADDWF	SSD1306_BUFFERLOCATIONCALC,F
	MOVF	SYSFORLOOPSTEP14_H,W
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,F
	GOTO	SYSFORLOOP15
;END IF
GLOBAL	ENDIF31
ENDIF31:
	GOTO	ENDIF30
GLOBAL	ELSE30_1
ELSE30_1:
;INTEGER POSITIVE STEP HANDLER IN FOR-NEXT STATEMENT
;IF ([WORD]32-1 - [WORD]SSD1306_BUFFERLOCATIONCALC) } [WORD]SYSFORLOOPSTEP14 THEN :#1P 
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	SUBLW	31
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	CLRF	SYSTEMP2
	BANKSEL	SSD1306_BUFFERLOCATIONCALC_H
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W
	BANKSEL	SYSTEMP2
	SUBWFB	SYSTEMP2,W
	MOVWF	SYSTEMP1_H
	MOVF	SYSTEMP1,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSWORDTEMPA_H
	BANKSEL	SYSFORLOOPSTEP14
	MOVF	SYSFORLOOPSTEP14,W
	MOVWF	SYSWORDTEMPB
	MOVF	SYSFORLOOPSTEP14_H,W
	MOVWF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF32
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	BANKSEL	SYSFORLOOPSTEP14
	MOVF	SYSFORLOOPSTEP14,W
	ADDWF	SSD1306_BUFFERLOCATIONCALC,F
	MOVF	SYSFORLOOPSTEP14_H,W
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,F
	GOTO	SYSFORLOOP15
;END IF
GLOBAL	ENDIF32
ENDIF32:
;END IF
GLOBAL	ENDIF30
ENDIF30:
GLOBAL	SYSFORLOOPEND15
SYSFORLOOPEND15:
;Removed at 1.14. Retained for documentation only
;Cursor_Position_SSD1306 ( 0 , 0 )
;for SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
;for GLCDTemp = 0 to 127
;Write_Data_SSD1306(GLCDBackground)
;Next
;next
;Cursor_Position_SSD1306 ( 0 , 0 )
	BANKSEL	LOCX
	CLRF	LOCX
	CLRF	LOCY
	BANKSEL	STATUS
	FCALL	CURSOR_POSITION_SSD1306
;PrintLocX =0
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX
;PrintLocY =0
	CLRF	PRINTLOCY
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (475)
GLOBAL	GLCDDRAWCHAR_SSD1306
GLCDDRAWCHAR_SSD1306:
;This is now in four parts
;1. Handler for GLCD LM mode
;2. Preamble
;3. GCB Font set handler
;4. OLED Font set handler
;***** Handler for GLCD LM mode
;if GLCDfntDefaultSize = 1 then
	DECF	GLCDFNTDEFAULTSIZE,W
	BTFSS	STATUS,2
	GOTO	ENDIF33
;test if character lies within current page
;GLCDY_Temp = CharLocY + 7
	MOVLW	7
	ADDWF	CHARLOCY,W
	MOVWF	GLCDY_TEMP
;Repeat 3
	MOVLW	3
	BANKSEL	SYSREPEATTEMP1
	MOVWF	SYSREPEATTEMP1
GLOBAL	SYSREPEATLOOP1
SYSREPEATLOOP1:
;Set C Off
	BCF	STATUS,0
;Rotate GLCDY_Temp Right
	BANKSEL	GLCDY_TEMP
	RRF	GLCDY_TEMP,F
;End Repeat
	BANKSEL	SYSREPEATTEMP1
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
GLOBAL	SYSREPEATLOOPEND1
SYSREPEATLOOPEND1:
;IF GLCDY_Temp <> _GLCDPage THEN
	MOVF	_GLCDPAGE,W
	BANKSEL	GLCDY_TEMP
	SUBWF	GLCDY_TEMP,W
	BTFSC	STATUS,2
	GOTO	ENDIF42
;GLCDY_Temp = GLCDY_Temp - 1
	DECF	GLCDY_TEMP,F
;IF GLCDY_Temp <> _GLCDPage THEN
	BANKSEL	_GLCDPAGE
	MOVF	_GLCDPAGE,W
	BANKSEL	GLCDY_TEMP
	SUBWF	GLCDY_TEMP,W
	BTFSS	STATUS,2
;EXIT SUB
	RETURN
;END IF
;END IF
GLOBAL	ENDIF42
ENDIF42:
;end if
GLOBAL	ENDIF33
ENDIF33:
;****** Preamble
;invert colors if required
;if LineColour <> GLCDForeground  then
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	MOVWF	SYSWORDTEMPA
	MOVF	LINECOLOUR_H,W
	MOVWF	SYSWORDTEMPA_H
	BANKSEL	GLCDFOREGROUND
	MOVF	GLCDFOREGROUND,W
	MOVWF	SYSWORDTEMPB
	MOVF	GLCDFOREGROUND_H,W
	MOVWF	SYSWORDTEMPB_H
	FCALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF34
;Inverted Colours
;GLCDBackground = 1
	MOVLW	1
	MOVWF	GLCDBACKGROUND
	CLRF	GLCDBACKGROUND_H
;GLCDForeground = 0
	CLRF	GLCDFOREGROUND
	CLRF	GLCDFOREGROUND_H
;end if
GLOBAL	ENDIF34
ENDIF34:
;dim CharCol, CharRow as word
;CharCode -= 15
	MOVLW	15
	SUBWF	CHARCODE,F
;CharCol=0
	CLRF	CHARCOL
	CLRF	CHARCOL_H
;Cursor_Position_SSD1306 ( CharLocX , CharLocY )
	MOVF	CHARLOCX,W
	BANKSEL	LOCX
	MOVWF	LOCX
	BANKSEL	CHARLOCY
	MOVF	CHARLOCY,W
	BANKSEL	LOCY
	MOVWF	LOCY
	BANKSEL	STATUS
	FCALL	CURSOR_POSITION_SSD1306
;1.14 Added transaction
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1218)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	FCALL	HI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;HI2CSend 0x40
	MOVLW	64
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	FCALL	HI2CSEND
;****** GCB Font set handler
;if CharCode>=178 and CharCode<=202 then
	MOVF	CHARCODE,W
	MOVWF	SYSBYTETEMPA
	MOVLW	178
	MOVWF	SYSBYTETEMPB
	FCALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	CHARCODE
	MOVF	CHARCODE,W
	MOVWF	SYSBYTETEMPB
	MOVLW	202
	MOVWF	SYSBYTETEMPA
	FCALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F
	BANKSEL	SYSTEMP2
	MOVF	SYSTEMP2,W
	ANDWF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP1
	BTFSS	SYSTEMP1,0
	GOTO	ENDIF35
;CharLocY=CharLocY-1
	MOVLW	1
	BANKSEL	CHARLOCY
	SUBWF	CHARLOCY,F
	MOVLW	0
	SUBWFB	CHARLOCY_H,F
;end if
GLOBAL	ENDIF35
ENDIF35:
;For CurrCharCol = 1 to 5
;LEGACY METHOD
	BANKSEL	CURRCHARCOL
	CLRF	CURRCHARCOL
GLOBAL	SYSFORLOOP17
SYSFORLOOP17:
	INCF	CURRCHARCOL,F
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
GLOBAL	SYSSELECT1CASE1
SYSSELECT1CASE1:
	DECF	CURRCHARCOL,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE2
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
	MOVF	CHARCODE,W
	MOVWF	SYSSTRINGA
	CALL	GLCDCHARCOL3
	MOVWF	CURRCHARVAL
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE2
SYSSELECT1CASE2:
	MOVLW	2
	SUBWF	CURRCHARCOL,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE3
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	MOVF	CHARCODE,W
	MOVWF	SYSSTRINGA
	FCALL	GLCDCHARCOL4
	MOVWF	CURRCHARVAL
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE3
SYSSELECT1CASE3:
	MOVLW	3
	SUBWF	CURRCHARCOL,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE4
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	MOVF	CHARCODE,W
	MOVWF	SYSSTRINGA
	FCALL	GLCDCHARCOL5
	MOVWF	CURRCHARVAL
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE4
SYSSELECT1CASE4:
	MOVLW	4
	SUBWF	CURRCHARCOL,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE5
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	MOVF	CHARCODE,W
	MOVWF	SYSSTRINGA
	FCALL	GLCDCHARCOL6
	MOVWF	CURRCHARVAL
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	GOTO	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE5
SYSSELECT1CASE5:
	MOVLW	5
	SUBWF	CURRCHARCOL,W
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND1
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	MOVF	CHARCODE,W
	MOVWF	SYSSTRINGA
	FCALL	GLCDCHARCOL7
	MOVWF	CURRCHARVAL
;End Select
GLOBAL	SYSSELECTEND1
SYSSELECTEND1:
;Full Memory GLCD mode
;1.14 Low Memory GLCD mode
;CharRow=0
	CLRF	CHARROW
	CLRF	CHARROW_H
;For CurrCharRow = 1 to 8
;LEGACY METHOD
	CLRF	CURRCHARROW
GLOBAL	SYSFORLOOP18
SYSFORLOOP18:
	INCF	CURRCHARROW,F
;CharColS=0
	CLRF	CHARCOLS
;For Col=1 to GLCDfntDefaultsize
	MOVLW	1
	MOVWF	COL
GLOBAL	SYSFORLOOP19
SYSFORLOOP19:
;CharRowS=0
	CLRF	CHARROWS
;For Row=1 to GLCDfntDefaultsize
	MOVLW	1
	BANKSEL	ROW
	MOVWF	ROW
GLOBAL	SYSFORLOOP20
SYSFORLOOP20:
;GLCDY = [word]CharLocY + CharRow + CharRowS
	BANKSEL	CHARROW
	MOVF	CHARROW,W
	ADDWF	CHARLOCY,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	CHARROWS
	MOVF	CHARROWS,W
	BANKSEL	SYSTEMP2
	ADDWF	SYSTEMP2,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
;if CurrCharVal.0=1 then
	BTFSS	CURRCHARVAL,0
	GOTO	ELSE36_1
;PSet [word]CharLocX + CharCol + CharColS, GLCDY, LineColour
	MOVF	CHARCOL,W
	ADDWF	CHARLOCX,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	CHARCOLS
	MOVF	CHARCOLS,W
	BANKSEL	SYSTEMP2
	ADDWF	SYSTEMP2,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Else
	GOTO	ENDIF36
GLOBAL	ELSE36_1
ELSE36_1:
;PSet [word]CharLocX + CharCol + CharColS, GLCDY, GLCDBackground
	MOVF	CHARCOL,W
	ADDWF	CHARLOCX,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	CHARCOLS
	MOVF	CHARCOLS,W
	BANKSEL	SYSTEMP2
	ADDWF	SYSTEMP2,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	MOVF	GLCDBACKGROUND,W
	MOVWF	GLCDCOLOUR
	MOVF	GLCDBACKGROUND_H,W
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;End if
GLOBAL	ENDIF36
ENDIF36:
;End if
;CharRowS +=1
	INCF	CHARROWS,F
;Put out a white intercharacter pixel/space
;if ( CharCol + CharColS ) = ( GLCDFontWidth * GLCDfntDefaultsize) - GLCDfntDefaultsize - 1 then
	MOVF	CHARCOLS,W
	ADDWF	CHARCOL,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	MOVLW	0
	BANKSEL	CHARCOL_H
	ADDWFC	CHARCOL_H,W
	BANKSEL	SYSTEMP1_H
	MOVWF	SYSTEMP1_H
	BANKSEL	GLCDFONTWIDTH
	MOVF	GLCDFONTWIDTH,W
	MOVWF	SYSBYTETEMPA
	MOVF	GLCDFNTDEFAULTSIZE,W
	MOVWF	SYSBYTETEMPB
	FCALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	GLCDFNTDEFAULTSIZE
	MOVF	GLCDFNTDEFAULTSIZE,W
	BANKSEL	SYSTEMP2
	SUBWF	SYSTEMP2,W
	MOVWF	SYSTEMP3
	DECF	SYSTEMP3,W
	MOVWF	SYSTEMP2
	MOVF	SYSTEMP1,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	SYSTEMP2,W
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF37
;PSet [word]CharLocX + CharCol + CharColS + 1, [word]CharLocY + CharRow+CharRowS -1, GLCDBackground
	MOVF	CHARCOL,W
	ADDWF	CHARLOCX,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	CHARCOLS
	MOVF	CHARCOLS,W
	BANKSEL	SYSTEMP2
	ADDWF	SYSTEMP2,W
	MOVWF	SYSTEMP1
	INCF	SYSTEMP1,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	MOVF	CHARROW,W
	ADDWF	CHARLOCY,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	CHARROWS
	MOVF	CHARROWS,W
	BANKSEL	SYSTEMP2
	ADDWF	SYSTEMP2,W
	MOVWF	SYSTEMP1
	DECF	SYSTEMP1,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	MOVF	GLCDBACKGROUND,W
	MOVWF	GLCDCOLOUR
	MOVF	GLCDBACKGROUND_H,W
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;end if
GLOBAL	ENDIF37
ENDIF37:
;Next Row
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	BANKSEL	ROW
	MOVF	ROW,W
	BANKSEL	GLCDFNTDEFAULTSIZE
	SUBWF	GLCDFNTDEFAULTSIZE,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF38
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	BANKSEL	ROW
	INCF	ROW,F
	GOTO	SYSFORLOOP20
;END IF
GLOBAL	ENDIF38
ENDIF38:
GLOBAL	SYSFORLOOPEND20
SYSFORLOOPEND20:
;CharColS +=1
	INCF	CHARCOLS,F
;Next Col
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	MOVF	COL,W
	SUBWF	GLCDFNTDEFAULTSIZE,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF39
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	COL,F
	GOTO	SYSFORLOOP19
;END IF
GLOBAL	ENDIF39
ENDIF39:
GLOBAL	SYSFORLOOPEND19
SYSFORLOOPEND19:
;Rotate CurrCharVal Right
	RRF	CURRCHARVAL,F
;CharRow +=GLCDfntDefaultsize
	MOVF	GLCDFNTDEFAULTSIZE,W
	ADDWF	CHARROW,F
	MOVLW	0
	ADDWFC	CHARROW_H,F
;Next
	MOVLW	8
	SUBWF	CURRCHARROW,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP18
GLOBAL	SYSFORLOOPEND18
SYSFORLOOPEND18:
;CharCol +=GLCDfntDefaultsize
	MOVF	GLCDFNTDEFAULTSIZE,W
	ADDWF	CHARCOL,F
	MOVLW	0
	ADDWFC	CHARCOL_H,F
;1.12 Character GLCD mode
;Handles specific draw sequence. This caters for write only of a bit value. No read operation.
;Ensure this is not called with in Low memory mode
;Next
	MOVLW	5
	SUBWF	CURRCHARCOL,W
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP17
GLOBAL	SYSFORLOOPEND17
SYSFORLOOPEND17:
;****** OLED Font set handler
;1.14 Added transaction
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1282)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	FCALL	HI2CSTOP
;Restore
;GLCDBackground = 0
	CLRF	GLCDBACKGROUND
	CLRF	GLCDBACKGROUND_H
;GLCDForeground = 1
	MOVLW	1
	MOVWF	GLCDFOREGROUND
	CLRF	GLCDFOREGROUND_H
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:WORD:LONG:, SOURCE: GLCD.H (1094)
GLOBAL	GLCDPRINT7
GLCDPRINT7:
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	BANKSEL	SYSPRINTBUFFLEN
	CLRF	SYSPRINTBUFFLEN
;Do
GLOBAL	SYSDOLOOP_S2
SYSDOLOOP_S2:
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	BANKSEL	SYSPRINTBUFFLEN
	INCF	SYSPRINTBUFFLEN,F
;SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
	MOVLW	LOW(SYSPRINTBUFFER)
	ADDWF	SYSPRINTBUFFLEN,W
	MOVWF	FSR0L
	MOVLW	0
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVLW	HIGH(SYSPRINTBUFFER)
	ADDWFC	SYSTEMP2,W
	MOVWF	FSR0H
	BANKSEL	LCDVALUE
	MOVF	LCDVALUE,W
	MOVWF	SYSLONGTEMPA
	MOVF	LCDVALUE_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	LCDVALUE_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	LCDVALUE_E,W
	MOVWF	SYSLONGTEMPA_E
	MOVLW	10
	MOVWF	SYSLONGTEMPB
	CLRF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	BANKSEL	STATUS
	FCALL	SYSDIVSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	INDF0
;LCDValue = SysCalcTempA
	MOVF	SYSCALCTEMPA,W
	BANKSEL	LCDVALUE
	MOVWF	LCDVALUE
	MOVF	SYSCALCTEMPA_H,W
	MOVWF	LCDVALUE_H
	MOVF	SYSCALCTEMPA_U,W
	MOVWF	LCDVALUE_U
	MOVF	SYSCALCTEMPA_E,W
	MOVWF	LCDVALUE_E
;Loop While LCDValue <> 0
	MOVF	LCDVALUE,W
	MOVWF	SYSLONGTEMPA
	MOVF	LCDVALUE_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	LCDVALUE_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	LCDVALUE_E,W
	MOVWF	SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB
	CLRF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL32
	COMF	SYSBYTETEMPX,F
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSDOLOOP_S2
GLOBAL	SYSDOLOOP_E2
SYSDOLOOP_E2:
;Display
;GLCDPrintLoc = PrintLocX
	BANKSEL	PRINTLOCX
	MOVF	PRINTLOCX,W
	BANKSEL	GLCDPRINTLOC
	MOVWF	GLCDPRINTLOC
	BANKSEL	PRINTLOCX_H
	MOVF	PRINTLOCX_H,W
	BANKSEL	GLCDPRINTLOC_H
	MOVWF	GLCDPRINTLOC_H
;For GLCDPrint_String_Counter = SysPrintBuffLen To 1 Step -1
	BANKSEL	SYSPRINTBUFFLEN
	MOVF	SYSPRINTBUFFLEN,W
	BANKSEL	GLCDPRINT_STRING_COUNTER
	MOVWF	GLCDPRINT_STRING_COUNTER
GLOBAL	SYSFORLOOP9
SYSFORLOOP9:
;INIT SYSFORLOOPSTEP8 :#0
	MOVLW	255
	BANKSEL	SYSFORLOOPSTEP8
	MOVWF	SYSFORLOOPSTEP8
	MOVWF	SYSFORLOOPSTEP8_H
;GLCDDrawChar GLCDPrintLoc, PrintLocY, SysPrintBuffer(GLCDPrint_String_Counter) + 48
	BANKSEL	GLCDPRINTLOC
	MOVF	GLCDPRINTLOC,W
	MOVWF	CHARLOCX
	MOVF	GLCDPRINTLOC_H,W
	MOVWF	CHARLOCX_H
	BANKSEL	PRINTLOCY
	MOVF	PRINTLOCY,W
	BANKSEL	CHARLOCY
	MOVWF	CHARLOCY
	BANKSEL	PRINTLOCY_H
	MOVF	PRINTLOCY_H,W
	BANKSEL	CHARLOCY_H
	MOVWF	CHARLOCY_H
	MOVLW	LOW(SYSPRINTBUFFER)
	ADDWF	GLCDPRINT_STRING_COUNTER,W
	MOVWF	FSR0L
	MOVLW	0
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVLW	HIGH(SYSPRINTBUFFER)
	ADDWFC	SYSTEMP2,W
	MOVWF	FSR0H
	MOVLW	48
	ADDWF	INDF0,W
	BANKSEL	CHARCODE
	MOVWF	CHARCODE
	MOVF	GLCDFOREGROUND,W
	BANKSEL	LINECOLOUR
	MOVWF	LINECOLOUR
	BANKSEL	GLCDFOREGROUND_H
	MOVF	GLCDFOREGROUND_H,W
	BANKSEL	LINECOLOUR_H
	MOVWF	LINECOLOUR_H
	BANKSEL	STATUS
	FCALL	GLCDDRAWCHAR_SSD1306
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1219)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	MOVF	GLCDFONTWIDTH,W
	MOVWF	SYSBYTETEMPA
	MOVF	GLCDFNTDEFAULTSIZE,W
	MOVWF	SYSBYTETEMPB
	FCALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	GLCDPRINTLOC
	ADDWF	GLCDPRINTLOC,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	MOVLW	0
	BANKSEL	GLCDPRINTLOC_H
	ADDWFC	GLCDPRINTLOC_H,W
	BANKSEL	SYSTEMP1_H
	MOVWF	SYSTEMP1_H
	MOVLW	1
	ADDWF	SYSTEMP1,W
	BANKSEL	GLCDPRINTLOC
	MOVWF	GLCDPRINTLOC
	MOVLW	0
	BANKSEL	SYSTEMP1_H
	ADDWFC	SYSTEMP1_H,W
	BANKSEL	GLCDPRINTLOC_H
	MOVWF	GLCDPRINTLOC_H
;Next
;INTEGER NEGATIVE STEP HANDLER IN FOR-NEXT STATEMENT
	BANKSEL	SYSFORLOOPSTEP8_H
	BTFSS	SYSFORLOOPSTEP8_H,7
	GOTO	ELSE11_1
	BANKSEL	GLCDPRINT_STRING_COUNTER
;IF ( GLCDPRINT_STRING_COUNTER - 1) } -SYSFORLOOPSTEP8 THEN :#3N
	DECF	GLCDPRINT_STRING_COUNTER,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	SYSFORLOOPSTEP8
	COMF	SYSFORLOOPSTEP8,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	SYSFORLOOPSTEP8_H
	COMF	SYSFORLOOPSTEP8_H,W
	BANKSEL	SYSTEMP1_H
	MOVWF	SYSTEMP1_H
	INCF	SYSTEMP1,F
	BTFSC	STATUS,2
	INCF	SYSTEMP1_H,F
	MOVF	SYSTEMP2,W
	MOVWF	SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H
	MOVF	SYSTEMP1,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHANINT
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF12
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A NEGATIVE VALUE
	BANKSEL	SYSFORLOOPSTEP8
	MOVF	SYSFORLOOPSTEP8,W
	BANKSEL	GLCDPRINT_STRING_COUNTER
	ADDWF	GLCDPRINT_STRING_COUNTER,F
	GOTO	SYSFORLOOP9
;END IF
GLOBAL	ENDIF12
ENDIF12:
	GOTO	ENDIF11
GLOBAL	ELSE11_1
ELSE11_1:
;INTEGER POSITIVE STEP HANDLER IN FOR-NEXT STATEMENT
	BANKSEL	GLCDPRINT_STRING_COUNTER
;IF (1 - GLCDPRINT_STRING_COUNTER) } SYSFORLOOPSTEP8 THEN :#3P
	MOVF	GLCDPRINT_STRING_COUNTER,W
	SUBLW	1
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVWF	SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H
	BANKSEL	SYSFORLOOPSTEP8
	MOVF	SYSFORLOOPSTEP8,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	SYSFORLOOPSTEP8_H,W
	MOVWF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHANINT
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF13
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	BANKSEL	SYSFORLOOPSTEP8
	MOVF	SYSFORLOOPSTEP8,W
	BANKSEL	GLCDPRINT_STRING_COUNTER
	ADDWF	GLCDPRINT_STRING_COUNTER,F
	GOTO	SYSFORLOOP9
;END IF
GLOBAL	ENDIF13
ENDIF13:
;END IF
GLOBAL	ENDIF11
ENDIF11:
GLOBAL	SYSFORLOOPEND9
SYSFORLOOPEND9:
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	MOVF	GLCDPRINTLOC,W
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	BANKSEL	GLCDPRINTLOC_H
	MOVF	GLCDPRINTLOC_H,W
	BANKSEL	PRINTLOCX_H
	MOVWF	PRINTLOCX_H
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: STRING.H (646)
GLOBAL	FN_PAD
FN_PAD:
;Check length of SysInString
;If SysInString(0) = longer or equal SysStrLen then
;give back SysInString and exit function
;If SysInString(0) < SysStrLen Then
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVF	SYSSYSINSTRINGHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
	MOVWF	FSR0H
	MOVF	SYSSTRLEN,W
	SUBWF	INDF0,W
	BTFSC	STATUS,0
	GOTO	ELSE76_1
;SysCharCount = SysInString(0)
	MOVF	SYSSYSINSTRINGHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	SYSCHARCOUNT
	MOVWF	SYSCHARCOUNT
;clear output string
;Pad=""
	MOVLW	LOW PAD
	MOVWF	FSR1L
	MOVLW	HIGH PAD
	MOVWF	FSR1H
	MOVLW	LOW STRINGTABLE92
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE92) & 127
	MOVWF	SYSSTRINGA_H
	BANKSEL	STATUS
	FCALL	SYSREADSTRING
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
	MOVLW	1
	BANKSEL	SYSSTRINGTEMP
	MOVWF	SYSSTRINGTEMP
GLOBAL	SYSFORLOOP21
SYSFORLOOP21:
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	MOVF	SYSSTRINGTEMP,W
	ADDWF	SYSSYSINSTRINGHANDLER,W
	MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSSYSINSTRINGHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	SYSARRAYTEMP1
	MOVWF	SYSARRAYTEMP1
	MOVWF	SYSARRAYTEMP2
	MOVLW	LOW(PAD)
	BANKSEL	SYSSTRINGTEMP
	ADDWF	SYSSTRINGTEMP,W
	MOVWF	FSR0L
	CLRF	SYSTEMP2
	MOVLW	HIGH(PAD)
	ADDWFC	SYSTEMP2,W
	MOVWF	FSR0H
	BANKSEL	SYSARRAYTEMP2
	MOVF	SYSARRAYTEMP2,W
	MOVWF	INDF0
;Next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	BANKSEL	SYSSTRINGTEMP
	MOVF	SYSSTRINGTEMP,W
	BANKSEL	SYSCHARCOUNT
	SUBWF	SYSCHARCOUNT,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF77
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	BANKSEL	SYSSTRINGTEMP
	INCF	SYSSTRINGTEMP,F
	GOTO	SYSFORLOOP21
;END IF
GLOBAL	ENDIF77
ENDIF77:
GLOBAL	SYSFORLOOPEND21
SYSFORLOOPEND21:
;For SysStringTemp = SysCharCount+1 to SysStrLen
	BANKSEL	SYSCHARCOUNT
	INCF	SYSCHARCOUNT,W
	BANKSEL	SYSSTRINGTEMP
	MOVWF	SYSSTRINGTEMP
GLOBAL	SYSFORLOOP22
SYSFORLOOP22:
;Pad(SysStringTemp) = SysInString3(1)
	MOVLW	1
	ADDWF	SYSSYSINSTRING3HANDLER,W
	MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSSYSINSTRING3HANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	SYSARRAYTEMP2
	MOVWF	SYSARRAYTEMP2
	MOVWF	SYSARRAYTEMP1
	MOVLW	LOW(PAD)
	BANKSEL	SYSSTRINGTEMP
	ADDWF	SYSSTRINGTEMP,W
	MOVWF	FSR0L
	CLRF	SYSTEMP2
	MOVLW	HIGH(PAD)
	ADDWFC	SYSTEMP2,W
	MOVWF	FSR0H
	BANKSEL	SYSARRAYTEMP1
	MOVF	SYSARRAYTEMP1,W
	MOVWF	INDF0
;Next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	BANKSEL	SYSSTRINGTEMP
	MOVF	SYSSTRINGTEMP,W
	SUBWF	SYSSTRLEN,W
	MOVWF	SYSTEMP2
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF78
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	BANKSEL	SYSSTRINGTEMP
	INCF	SYSSTRINGTEMP,F
	GOTO	SYSFORLOOP22
;END IF
GLOBAL	ENDIF78
ENDIF78:
GLOBAL	SYSFORLOOPEND22
SYSFORLOOPEND22:
;set new length to PAD
;Pad(0) = SysStrLen
	BANKSEL	SYSSTRLEN
	MOVF	SYSSTRLEN,W
	BANKSEL	SYSPAD_0
	MOVWF	SYSPAD_0
;else
	GOTO	ENDIF76
GLOBAL	ELSE76_1
ELSE76_1:
;SysInString is equal or longer than SysStrLen
;give back old string; copy SysInString to Pad
;For SysStringTemp = 1 To SysInString(0)
	MOVLW	1
	MOVWF	SYSSTRINGTEMP
GLOBAL	SYSFORLOOP23
SYSFORLOOP23:
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	MOVF	SYSSTRINGTEMP,W
	ADDWF	SYSSYSINSTRINGHANDLER,W
	MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSSYSINSTRINGHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	SYSARRAYTEMP1
	MOVWF	SYSARRAYTEMP1
	MOVWF	SYSARRAYTEMP2
	MOVLW	LOW(PAD)
	BANKSEL	SYSSTRINGTEMP
	ADDWF	SYSSTRINGTEMP,W
	MOVWF	FSR0L
	CLRF	SYSTEMP2
	MOVLW	HIGH(PAD)
	ADDWFC	SYSTEMP2,W
	MOVWF	FSR0H
	BANKSEL	SYSARRAYTEMP2
	MOVF	SYSARRAYTEMP2,W
	MOVWF	INDF0
;Next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVF	SYSSYSINSTRINGHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
	MOVWF	FSR0H
	MOVF	SYSSTRINGTEMP,W
	SUBWF	INDF0,W
	MOVWF	SYSTEMP2
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF79
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	BANKSEL	SYSSTRINGTEMP
	INCF	SYSSTRINGTEMP,F
	GOTO	SYSFORLOOP23
;END IF
GLOBAL	ENDIF79
ENDIF79:
GLOBAL	SYSFORLOOPEND23
SYSFORLOOPEND23:
;PAD(0) = SysInString(0)
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVF	SYSSYSINSTRINGHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	SYSARRAYTEMP1
	MOVWF	SYSARRAYTEMP1
	BANKSEL	SYSPAD_0
	MOVWF	SYSPAD_0
;End If
GLOBAL	ENDIF76
ENDIF76:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2091)
GLOBAL	FN_READAD456
FN_READAD456:
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	BANKSEL	ADCON0
	BCF	ADCON0,2
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,W
	BANKSEL	ADPCH
	MOVWF	ADPCH
;SetNegativeChannelSelectbits
;Macro Source: a-d.h (2867)
;ADCON0.ADIC = 0
	BCF	ADCON0,1
;ADNCH = 0x00
	CLRF	ADNCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (567)
;Configure ANSELA/B/C/D @DebugADC_H
;Select Case ADReadPort
;Case 0: Set ANSELA.0 On
GLOBAL	SYSSELECT2CASE1
SYSSELECT2CASE1:
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,F
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE2
;Case 0: Set ANSELA.0 On
	BANKSEL	ANSELA
	BSF	ANSELA,0
;Case 1: Set ANSELA.1 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE2
SYSSELECT2CASE2:
	DECF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE3
;Case 1: Set ANSELA.1 On
	BANKSEL	ANSELA
	BSF	ANSELA,1
;Case 2: Set ANSELA.2 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE3
SYSSELECT2CASE3:
	MOVLW	2
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE4
;Case 2: Set ANSELA.2 On
	BANKSEL	ANSELA
	BSF	ANSELA,2
;Case 3: Set ANSELA.3 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE4
SYSSELECT2CASE4:
	MOVLW	3
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE5
;Case 3: Set ANSELA.3 On
	BANKSEL	ANSELA
	BSF	ANSELA,3
;Case 4: Set ANSELA.4 ON
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE5
SYSSELECT2CASE5:
	MOVLW	4
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE6
;Case 4: Set ANSELA.4 ON
	BANKSEL	ANSELA
	BSF	ANSELA,4
;Case 5: Set ANSELA.5 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE6
SYSSELECT2CASE6:
	MOVLW	5
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE7
;Case 5: Set ANSELA.5 On
	BANKSEL	ANSELA
	BSF	ANSELA,5
;Case 6: Set ANSELA.6 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE7
SYSSELECT2CASE7:
	MOVLW	6
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE8
;Case 6: Set ANSELA.6 On
	BANKSEL	ANSELA
	BSF	ANSELA,6
;Case 7: Set ANSELA.7 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE8
SYSSELECT2CASE8:
	MOVLW	7
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE9
;Case 7: Set ANSELA.7 On
	BANKSEL	ANSELA
	BSF	ANSELA,7
;Case 8: Set ANSELB.0 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE9
SYSSELECT2CASE9:
	MOVLW	8
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE10
;Case 8: Set ANSELB.0 On
	BSF	ANSELB,0
;Case 9: Set ANSELB.1 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE10
SYSSELECT2CASE10:
	MOVLW	9
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE11
;Case 9: Set ANSELB.1 On
	BSF	ANSELB,1
;Case 10: Set ANSELB.2 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE11
SYSSELECT2CASE11:
	MOVLW	10
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE12
;Case 10: Set ANSELB.2 On
	BSF	ANSELB,2
;Case 11: Set ANSELB.3 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE12
SYSSELECT2CASE12:
	MOVLW	11
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE13
;Case 11: Set ANSELB.3 On
	BSF	ANSELB,3
;Case 12: Set ANSELB.4 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE13
SYSSELECT2CASE13:
	MOVLW	12
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE14
;Case 12: Set ANSELB.4 On
	BSF	ANSELB,4
;Case 13: Set ANSELB.5 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE14
SYSSELECT2CASE14:
	MOVLW	13
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE15
;Case 13: Set ANSELB.5 On
	BSF	ANSELB,5
;Case 14: Set ANSELB.6 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE15
SYSSELECT2CASE15:
	MOVLW	14
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE16
;Case 14: Set ANSELB.6 On
	BSF	ANSELB,6
;Case 15: Set ANSELB.7 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE16
SYSSELECT2CASE16:
	MOVLW	15
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE17
;Case 15: Set ANSELB.7 On
	BSF	ANSELB,7
;Case 16: Set ANSELC.0 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE17
SYSSELECT2CASE17:
	MOVLW	16
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE18
;Case 16: Set ANSELC.0 On
	BANKSEL	ANSELC
	BSF	ANSELC,0
;Case 17: Set ANSELC.1 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE18
SYSSELECT2CASE18:
	MOVLW	17
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE19
;Case 17: Set ANSELC.1 On
	BANKSEL	ANSELC
	BSF	ANSELC,1
;Case 18: Set ANSELC.2 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE19
SYSSELECT2CASE19:
	MOVLW	18
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE20
;Case 18: Set ANSELC.2 On
	BANKSEL	ANSELC
	BSF	ANSELC,2
;Case 19: Set ANSELC.3 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE20
SYSSELECT2CASE20:
	MOVLW	19
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE21
;Case 19: Set ANSELC.3 On
	BANKSEL	ANSELC
	BSF	ANSELC,3
;Case 20: Set ANSELC.4 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE21
SYSSELECT2CASE21:
	MOVLW	20
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE22
;Case 20: Set ANSELC.4 On
	BANKSEL	ANSELC
	BSF	ANSELC,4
;Case 21: Set ANSELC.5 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE22
SYSSELECT2CASE22:
	MOVLW	21
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE23
;Case 21: Set ANSELC.5 On
	BANKSEL	ANSELC
	BSF	ANSELC,5
;Case 22: Set ANSELC.6 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE23
SYSSELECT2CASE23:
	MOVLW	22
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE24
;Case 22: Set ANSELC.6 On
	BANKSEL	ANSELC
	BSF	ANSELC,6
;Case 23: Set ANSELC.7 On
	GOTO	SYSSELECTEND2
GLOBAL	SYSSELECT2CASE24
SYSSELECT2CASE24:
	MOVLW	23
	SUBWF	ADREADPORT,W
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND2
;Case 23: Set ANSELC.7 On
	BANKSEL	ANSELC
	BSF	ANSELC,7
;End Select  '*** ANSEL Bits should now be set ***
GLOBAL	SYSSELECTEND2
SYSSELECTEND2:
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
	BANKSEL	ADCON0
	BCF	ADCON0,4
;ADCLK = 1 ' default to FOSC/2
	MOVLW	1
	MOVWF	ADCLK
;Conversion Clock Speed
;SET ADCS OFF  'ADCON0.4
	BCF	ADCON0,4
;ADCLK = 15    'FOSC/16
	MOVLW	15
	MOVWF	ADCLK
;Result formatting
;if ADLeftadjust = 0 then
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
	BCF	ADCON0,2
;Set ADFM0 OFF
	BCF	ADCON0,2
;End if
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,W
	BANKSEL	ADPCH
	MOVWF	ADPCH
;Enable AD Operations
;SET ADON ON
	BSF	ADCON0,7
;Acquisition Delay
;Wait AD_Delay
	MOVLW	2
	MOVWF	SYSWAITTEMP10US
	BANKSEL	STATUS
	FCALL	DELAY_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	BANKSEL	ADCON0
	BSF	ADCON0,0
;nop
	NOP
;Wait While GO_NOT_DONE ON
GLOBAL	SYSWAITLOOP1
SYSWAITLOOP1:
	BTFSC	ADCON0,0
	GOTO	SYSWAITLOOP1
;Switch off A/D
;SET ADCON0.ADON OFF
	BCF	ADCON0,7
;ANSELA = 0
	BANKSEL	ANSELA
	CLRF	ANSELA
;ANSELC = 0
	CLRF	ANSELC
;ReadAD = ADRESH
	BANKSEL	ADRESH
	MOVF	ADRESH,W
	BANKSEL	READAD
	MOVWF	READAD
;SET ADFM OFF
	BANKSEL	ADCON0
	BCF	ADCON0,2
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: STRING.H (76)
GLOBAL	FN_STR
FN_STR:
;SysCharCount = 0
	BANKSEL	SYSCHARCOUNT
	CLRF	SYSCHARCOUNT
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	BANKSEL	SYSVALTEMP
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	16
	MOVWF	SYSWORDTEMPB
	MOVLW	39
	MOVWF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF71
;SysStrData = SysValTemp / 10000
	BANKSEL	SYSVALTEMP
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	16
	MOVWF	SYSWORDTEMPB
	MOVLW	39
	MOVWF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	BANKSEL	SYSSTRDATA
	MOVWF	SYSSTRDATA
;SysValTemp = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SYSVALTEMP
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SYSVALTEMP_H
;SysCharCount += 1
	BANKSEL	SYSCHARCOUNT
	INCF	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	MOVLW	LOW(STR)
	ADDWF	SYSCHARCOUNT,W
	MOVWF	FSR0L
	MOVLW	0
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVLW	HIGH(STR)
	ADDWFC	SYSTEMP2,W
	MOVWF	FSR0H
	MOVLW	48
	ADDWF	SYSSTRDATA,W
	MOVWF	INDF0
;Goto SysValThousands
	GOTO	SYSVALTHOUSANDS
;End If
GLOBAL	ENDIF71
ENDIF71:
;Thousands
;IF SysValTemp >= 1000 then
	BANKSEL	SYSVALTEMP
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	232
	MOVWF	SYSWORDTEMPB
	MOVLW	3
	MOVWF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF72
GLOBAL	SYSVALTHOUSANDS
SYSVALTHOUSANDS:
;SysStrData = SysValTemp / 1000
	BANKSEL	SYSVALTEMP
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	232
	MOVWF	SYSWORDTEMPB
	MOVLW	3
	MOVWF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	BANKSEL	SYSSTRDATA
	MOVWF	SYSSTRDATA
;SysValTemp = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SYSVALTEMP
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SYSVALTEMP_H
;SysCharCount += 1
	BANKSEL	SYSCHARCOUNT
	INCF	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	MOVLW	LOW(STR)
	ADDWF	SYSCHARCOUNT,W
	MOVWF	FSR0L
	MOVLW	0
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVLW	HIGH(STR)
	ADDWFC	SYSTEMP2,W
	MOVWF	FSR0H
	MOVLW	48
	ADDWF	SYSSTRDATA,W
	MOVWF	INDF0
;Goto SysValHundreds
	GOTO	SYSVALHUNDREDS
;End If
GLOBAL	ENDIF72
ENDIF72:
;Hundreds
;IF SysValTemp >= 100 then
	BANKSEL	SYSVALTEMP
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	100
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF73
GLOBAL	SYSVALHUNDREDS
SYSVALHUNDREDS:
;SysStrData = SysValTemp / 100
	BANKSEL	SYSVALTEMP
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	100
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	BANKSEL	SYSSTRDATA
	MOVWF	SYSSTRDATA
;SysValTemp = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SYSVALTEMP
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SYSVALTEMP_H
;SysCharCount += 1
	BANKSEL	SYSCHARCOUNT
	INCF	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	MOVLW	LOW(STR)
	ADDWF	SYSCHARCOUNT,W
	MOVWF	FSR0L
	MOVLW	0
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVLW	HIGH(STR)
	ADDWFC	SYSTEMP2,W
	MOVWF	FSR0H
	MOVLW	48
	ADDWF	SYSSTRDATA,W
	MOVWF	INDF0
;Goto SysValTens
	GOTO	SYSVALTENS
;End If
GLOBAL	ENDIF73
ENDIF73:
;Tens
;IF SysValTemp >= 10 Then
	BANKSEL	SYSVALTEMP
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	10
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF74
GLOBAL	SYSVALTENS
SYSVALTENS:
;SysStrData = SysValTemp / 10
	BANKSEL	SYSVALTEMP
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	10
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	BANKSEL	SYSSTRDATA
	MOVWF	SYSSTRDATA
;SysValTemp = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SYSVALTEMP
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SYSVALTEMP_H
;SysCharCount += 1
	BANKSEL	SYSCHARCOUNT
	INCF	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	MOVLW	LOW(STR)
	ADDWF	SYSCHARCOUNT,W
	MOVWF	FSR0L
	MOVLW	0
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVLW	HIGH(STR)
	ADDWFC	SYSTEMP2,W
	MOVWF	FSR0H
	MOVLW	48
	ADDWF	SYSSTRDATA,W
	MOVWF	INDF0
;End If
GLOBAL	ENDIF74
ENDIF74:
;Ones
;SysCharCount += 1
	BANKSEL	SYSCHARCOUNT
	INCF	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	MOVLW	LOW(STR)
	ADDWF	SYSCHARCOUNT,W
	MOVWF	FSR0L
	MOVLW	0
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVLW	HIGH(STR)
	ADDWFC	SYSTEMP2,W
	MOVWF	FSR0H
	MOVLW	48
	ADDWF	SYSVALTEMP,W
	MOVWF	INDF0
;SysValTemp = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SYSVALTEMP
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SYSVALTEMP_H
;Str(0) = SysCharCount
	BANKSEL	SYSCHARCOUNT
	MOVF	SYSCHARCOUNT,W
	BANKSEL	SYSSTR_0
	MOVWF	SYSSTR_0
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

;SOURCE: PICAS.H (26)
GLOBAL	_LINE
_LINE:
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	BANKSEL	LINEDIFFX
	CLRF	LINEDIFFX
	CLRF	LINEDIFFX_H
;LineDiffY = 0
	CLRF	LINEDIFFY
	CLRF	LINEDIFFY_H
;LineStepX = 0
	CLRF	LINESTEPX
	CLRF	LINESTEPX_H
;LineStepY = 0
	CLRF	LINESTEPY
	CLRF	LINESTEPY_H
;LineDiffX_x2 = 0
	CLRF	LINEDIFFX_X2
	CLRF	LINEDIFFX_X2_H
;LineDiffY_x2 = 0
	CLRF	LINEDIFFY_X2
	CLRF	LINEDIFFY_X2_H
;LineErr = 0
	CLRF	LINEERR
	CLRF	LINEERR_H
;LineDiffX =  LineX2 -   LineX1
	MOVF	LINEX1,W
	SUBWF	LINEX2,W
	MOVWF	LINEDIFFX
	MOVF	LINEX1_H,W
	SUBWFB	LINEX2_H,W
	MOVWF	LINEDIFFX_H
;LineDiffY =  LineY2 -   LineY1
	MOVF	LINEY1,W
	SUBWF	LINEY2,W
	MOVWF	LINEDIFFY
	MOVF	LINEY1_H,W
	SUBWFB	LINEY2_H,W
	MOVWF	LINEDIFFY_H
;if (LineDiffX > 0) then
	MOVF	LINEDIFFX,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	LINEDIFFX_H,W
	MOVWF	SYSINTEGERTEMPB_H
	CLRF	SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0
	GOTO	ELSE50_1
;LineStepX = 1
	MOVLW	1
	BANKSEL	LINESTEPX
	MOVWF	LINESTEPX
	CLRF	LINESTEPX_H
;else
	GOTO	ENDIF50
GLOBAL	ELSE50_1
ELSE50_1:
;LineStepX = -1
	MOVLW	255
	BANKSEL	LINESTEPX
	MOVWF	LINESTEPX
	MOVWF	LINESTEPX_H
;end if
GLOBAL	ENDIF50
ENDIF50:
;if (LineDiffY > 0) then
	MOVF	LINEDIFFY,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	LINEDIFFY_H,W
	MOVWF	SYSINTEGERTEMPB_H
	CLRF	SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0
	GOTO	ELSE51_1
;LineStepY = 1
	MOVLW	1
	BANKSEL	LINESTEPY
	MOVWF	LINESTEPY
	CLRF	LINESTEPY_H
;else
	GOTO	ENDIF51
GLOBAL	ELSE51_1
ELSE51_1:
;LineStepY = -1
	MOVLW	255
	BANKSEL	LINESTEPY
	MOVWF	LINESTEPY
	MOVWF	LINESTEPY_H
;end if
GLOBAL	ENDIF51
ENDIF51:
;LineDiffX = LineStepX * LineDiffX
	MOVF	LINESTEPX,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINESTEPX_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVF	LINEDIFFX,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	LINEDIFFX_H,W
	MOVWF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSMULTSUBINT
	MOVF	SYSINTEGERTEMPX,W
	BANKSEL	LINEDIFFX
	MOVWF	LINEDIFFX
	MOVF	SYSINTEGERTEMPX_H,W
	MOVWF	LINEDIFFX_H
;LineDiffY = LineStepY * LineDiffY
	MOVF	LINESTEPY,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINESTEPY_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVF	LINEDIFFY,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	LINEDIFFY_H,W
	MOVWF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSMULTSUBINT
	MOVF	SYSINTEGERTEMPX,W
	BANKSEL	LINEDIFFY
	MOVWF	LINEDIFFY
	MOVF	SYSINTEGERTEMPX_H,W
	MOVWF	LINEDIFFY_H
;LineDiffX_x2 = LineDiffX*2
	MOVF	LINEDIFFX,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINEDIFFX_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVLW	2
	MOVWF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSMULTSUBINT
	MOVF	SYSINTEGERTEMPX,W
	BANKSEL	LINEDIFFX_X2
	MOVWF	LINEDIFFX_X2
	MOVF	SYSINTEGERTEMPX_H,W
	MOVWF	LINEDIFFX_X2_H
;LineDiffY_x2 = LineDiffY*2
	MOVF	LINEDIFFY,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINEDIFFY_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVLW	2
	MOVWF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSMULTSUBINT
	MOVF	SYSINTEGERTEMPX,W
	BANKSEL	LINEDIFFY_X2
	MOVWF	LINEDIFFY_X2
	MOVF	SYSINTEGERTEMPX_H,W
	MOVWF	LINEDIFFY_X2_H
;if ( LineDiffX >= LineDiffY) then
	MOVF	LINEDIFFX,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINEDIFFX_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVF	LINEDIFFY,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	LINEDIFFY_H,W
	MOVWF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHANINT
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ELSE52_1
;LineErr = LineDiffY_x2 - LineDiffX
	BANKSEL	LINEDIFFX
	MOVF	LINEDIFFX,W
	SUBWF	LINEDIFFY_X2,W
	MOVWF	LINEERR
	MOVF	LINEDIFFX_H,W
	SUBWFB	LINEDIFFY_X2_H,W
	MOVWF	LINEERR_H
;do while (   LineX1 <>  LineX2 )
GLOBAL	SYSDOLOOP_S6
SYSDOLOOP_S6:
	MOVF	LINEX1,W
	MOVWF	SYSWORDTEMPA
	MOVF	LINEX1_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	LINEX2,W
	MOVWF	SYSWORDTEMPB
	MOVF	LINEX2_H,W
	MOVWF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	SYSDOLOOP_E6
;PSet (   LineX1,   LineY1, LineColour )
	BANKSEL	LINEX1
	MOVF	LINEX1,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	LINEY1
	MOVF	LINEY1,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;LineX1 += LineStepX
	BANKSEL	LINESTEPX
	MOVF	LINESTEPX,W
	ADDWF	LINEX1,F
	MOVF	LINESTEPX_H,W
	ADDWFC	LINEX1_H,F
;if ( LineErr < 0) then
	MOVF	LINEERR,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINEERR_H,W
	MOVWF	SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0
	GOTO	ELSE53_1
;LineErr += LineDiffY_x2
	BANKSEL	LINEDIFFY_X2
	MOVF	LINEDIFFY_X2,W
	ADDWF	LINEERR,F
	MOVF	LINEDIFFY_X2_H,W
	ADDWFC	LINEERR_H,F
;else
	GOTO	ENDIF53
GLOBAL	ELSE53_1
ELSE53_1:
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	BANKSEL	LINEDIFFX_X2
	MOVF	LINEDIFFX_X2,W
	SUBWF	LINEDIFFY_X2,W
	BANKSEL	SYSTEMP3
	MOVWF	SYSTEMP3
	BANKSEL	LINEDIFFX_X2_H
	MOVF	LINEDIFFX_X2_H,W
	SUBWFB	LINEDIFFY_X2_H,W
	BANKSEL	SYSTEMP3_H
	MOVWF	SYSTEMP3_H
	MOVF	SYSTEMP3,W
	BANKSEL	LINEERR
	ADDWF	LINEERR,F
	BANKSEL	SYSTEMP3_H
	MOVF	SYSTEMP3_H,W
	BANKSEL	LINEERR_H
	ADDWFC	LINEERR_H,F
;LineY1 += LineStepY
	MOVF	LINESTEPY,W
	ADDWF	LINEY1,F
	MOVF	LINESTEPY_H,W
	ADDWFC	LINEY1_H,F
;end if
GLOBAL	ENDIF53
ENDIF53:
;loop
	GOTO	SYSDOLOOP_S6
GLOBAL	SYSDOLOOP_E6
SYSDOLOOP_E6:
;PSet (   LineX1,   LineY1, LineColour )
	BANKSEL	LINEX1
	MOVF	LINEX1,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	LINEY1
	MOVF	LINEY1,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;else
	GOTO	ENDIF52
GLOBAL	ELSE52_1
ELSE52_1:
;LineErr = LineDiffX_x2 - LineDiffY
	BANKSEL	LINEDIFFY
	MOVF	LINEDIFFY,W
	SUBWF	LINEDIFFX_X2,W
	MOVWF	LINEERR
	MOVF	LINEDIFFY_H,W
	SUBWFB	LINEDIFFX_X2_H,W
	MOVWF	LINEERR_H
;do while (   LineY1 <>  LineY2)
GLOBAL	SYSDOLOOP_S7
SYSDOLOOP_S7:
	MOVF	LINEY1,W
	MOVWF	SYSWORDTEMPA
	MOVF	LINEY1_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	LINEY2,W
	MOVWF	SYSWORDTEMPB
	MOVF	LINEY2_H,W
	MOVWF	SYSWORDTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	SYSDOLOOP_E7
;PSet (   LineX1,   LineY1, LineColour )
	BANKSEL	LINEX1
	MOVF	LINEX1,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	LINEY1
	MOVF	LINEY1,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;LineY1 += LineStepY
	BANKSEL	LINESTEPY
	MOVF	LINESTEPY,W
	ADDWF	LINEY1,F
	MOVF	LINESTEPY_H,W
	ADDWFC	LINEY1_H,F
;if ( LineErr < 0) then
	MOVF	LINEERR,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINEERR_H,W
	MOVWF	SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0
	GOTO	ELSE54_1
;LineErr += LineDiffX_x2
	BANKSEL	LINEDIFFX_X2
	MOVF	LINEDIFFX_X2,W
	ADDWF	LINEERR,F
	MOVF	LINEDIFFX_X2_H,W
	ADDWFC	LINEERR_H,F
;else
	GOTO	ENDIF54
GLOBAL	ELSE54_1
ELSE54_1:
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	BANKSEL	LINEDIFFY_X2
	MOVF	LINEDIFFY_X2,W
	SUBWF	LINEDIFFX_X2,W
	BANKSEL	SYSTEMP3
	MOVWF	SYSTEMP3
	BANKSEL	LINEDIFFY_X2_H
	MOVF	LINEDIFFY_X2_H,W
	SUBWFB	LINEDIFFX_X2_H,W
	BANKSEL	SYSTEMP3_H
	MOVWF	SYSTEMP3_H
	MOVF	SYSTEMP3,W
	BANKSEL	LINEERR
	ADDWF	LINEERR,F
	BANKSEL	SYSTEMP3_H
	MOVF	SYSTEMP3_H,W
	BANKSEL	LINEERR_H
	ADDWFC	LINEERR_H,F
;LineX1 += LineStepX
	MOVF	LINESTEPX,W
	ADDWF	LINEX1,F
	MOVF	LINESTEPX_H,W
	ADDWFC	LINEX1_H,F
;end if
GLOBAL	ENDIF54
ENDIF54:
;loop
	GOTO	SYSDOLOOP_S7
GLOBAL	SYSDOLOOP_E7
SYSDOLOOP_E7:
;PSet (   LineX1,   LineY1, LineColour )
	BANKSEL	LINEX1
	MOVF	LINEX1,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	LINEY1
	MOVF	LINEY1,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;end if
GLOBAL	ENDIF52
ENDIF52:
	RETURN

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 2
	PSECT	PROGMEM2,CLASS=CODE,SPACE=SPACE_CODE,DELTA=2, ABS, OVRLD 
	ORG	4096
;SOURCE: STRING.H (537)
GLOBAL	FN_CHR
FN_CHR:
;Empty input?
;If SysChar < 0 Then
	MOVLW	0
	BANKSEL	SYSCHAR
	SUBWF	SYSCHAR,W
	BTFSC	STATUS,0
	GOTO	ENDIF75
;Chr(0) = 0
	BANKSEL	SYSCHR_0
	CLRF	SYSCHR_0
;Exit Function
	BANKSEL	STATUS
	RETURN
;End If
GLOBAL	ENDIF75
ENDIF75:
;Chr(0) = 1
	MOVLW	1
	BANKSEL	SYSCHR_0
	MOVWF	SYSCHR_0
;Copy characters
;Chr(1) = SysChar
	BANKSEL	SYSCHAR
	MOVF	SYSCHAR,W
	BANKSEL	SYSCHR_1
	MOVWF	SYSCHR_1
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (1040)
GLOBAL	CURSOR_POSITION_SSD1306
CURSOR_POSITION_SSD1306:
;dim  PosCharX, PosCharX as Word
;PosCharY = LocY / 8
;faster than /8
;PosCharY = LocY
	BANKSEL	LOCY
	MOVF	LOCY,W
	MOVWF	POSCHARY
;Repeat 3
	MOVLW	3
	BANKSEL	SYSREPEATTEMP4
	MOVWF	SYSREPEATTEMP4
GLOBAL	SYSREPEATLOOP4
SYSREPEATLOOP4:
;Set C Off
	BCF	STATUS,0
;Rotate PosCharY Right
	BANKSEL	POSCHARY
	RRF	POSCHARY,F
;End Repeat
	BANKSEL	SYSREPEATTEMP4
	DECFSZ	SYSREPEATTEMP4,F
	GOTO	SYSREPEATLOOP4
GLOBAL	SYSREPEATLOOPEND4
SYSREPEATLOOPEND4:
;Write_Command_SSD1306( 0xB0 + PosCharY )   ' set page address
	MOVLW	176
	BANKSEL	POSCHARY
	ADDWF	POSCHARY,W
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	CALL	WRITE_COMMAND_SSD1306
;PosCharX = ( LocX  & 0x0f )  ' lower nibble
	MOVLW	15
	BANKSEL	LOCX
	ANDWF	LOCX,W
	MOVWF	POSCHARX
	CLRF	POSCHARX_H
;Write_Command_SSD1306( PosCharX )
	MOVF	POSCHARX,W
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	CALL	WRITE_COMMAND_SSD1306
;PosCharX = LocX
	BANKSEL	LOCX
	MOVF	LOCX,W
	MOVWF	POSCHARX
	CLRF	POSCHARX_H
;Repeat 4
	MOVLW	4
	BANKSEL	SYSREPEATTEMP4
	MOVWF	SYSREPEATTEMP4
GLOBAL	SYSREPEATLOOP5
SYSREPEATLOOP5:
;Set C off
	BCF	STATUS,0
;Rotate PosCharX Right
	BANKSEL	POSCHARX_H
	RRF	POSCHARX_H,F
	RRF	POSCHARX,F
;End Repeat
	BANKSEL	SYSREPEATTEMP4
	DECFSZ	SYSREPEATTEMP4,F
	GOTO	SYSREPEATLOOP5
GLOBAL	SYSREPEATLOOPEND5
SYSREPEATLOOPEND5:
;PosCharX = ( PosCharX & 0x0F ) + 0x10
	MOVLW	15
	BANKSEL	POSCHARX
	ANDWF	POSCHARX,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	CLRF	SYSTEMP1_H
	MOVLW	16
	ADDWF	SYSTEMP1,W
	BANKSEL	POSCHARX
	MOVWF	POSCHARX
	MOVLW	0
	BANKSEL	SYSTEMP1_H
	ADDWFC	SYSTEMP1_H,W
	BANKSEL	POSCHARX_H
	MOVWF	POSCHARX_H
;Write_Command_SSD1306 ( PosCharX )
	MOVF	POSCHARX,W
	MOVWF	SSD1306SENDBYTE
	BANKSEL	STATUS
	GOTO	WRITE_COMMAND_SSD1306

;********************************************************************************

;SOURCE: GLCD.H (3758)
GLOBAL	DRAW_ELLIPSE_POINTS
DRAW_ELLIPSE_POINTS:
;dim LineColour as word
;Pset ((xoffset + GLCD_xx), (yoffset + GLCD_yy), LineColour)
	BANKSEL	GLCD_XX
	MOVF	GLCD_XX,W
	BANKSEL	XOFFSET
	ADDWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	GLCD_YY
	MOVF	GLCD_YY,W
	BANKSEL	YOFFSET
	ADDWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Pset ((xoffset - GLCD_xx), (yoffset + GLCD_yy), LineColour)
	BANKSEL	GLCD_XX
	MOVF	GLCD_XX,W
	BANKSEL	XOFFSET
	SUBWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	GLCD_YY
	MOVF	GLCD_YY,W
	BANKSEL	YOFFSET
	ADDWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Pset ((xoffset - GLCD_xx), (yoffset - GLCD_yy), LineColour)
	BANKSEL	GLCD_XX
	MOVF	GLCD_XX,W
	BANKSEL	XOFFSET
	SUBWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	GLCD_YY
	MOVF	GLCD_YY,W
	BANKSEL	YOFFSET
	SUBWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Pset ((xoffset + GLCD_xx), (yoffset - GLCD_yy), LineColour)
	BANKSEL	GLCD_XX
	MOVF	GLCD_XX,W
	BANKSEL	XOFFSET
	ADDWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	GLCD_YY
	MOVF	GLCD_YY,W
	BANKSEL	YOFFSET
	SUBWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	LJMP	PSET_SSD1306

;********************************************************************************

;SOURCE: GLCD.H (3767)
GLOBAL	DRAW_FILLED_ELLIPSE_POINTS
DRAW_FILLED_ELLIPSE_POINTS:
;dim LineColour as word
;FOR GLCD_yy1 = (yoffset) to (yoffset + 2 * GLCD_yy)
	BANKSEL	YOFFSET
	MOVF	YOFFSET,W
	BANKSEL	GLCD_YY1
	MOVWF	GLCD_YY1
GLOBAL	SYSFORLOOP13
SYSFORLOOP13:
;Pset ((xoffset + GLCD_xx), (GLCD_yy1 - GLCD_yy), LineColour)
	MOVF	GLCD_XX,W
	BANKSEL	XOFFSET
	ADDWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	GLCD_YY
	MOVF	GLCD_YY,W
	SUBWF	GLCD_YY1,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;Pset ((xoffset - GLCD_xx), (GLCD_yy1 - GLCD_yy), LineColour)
	BANKSEL	GLCD_XX
	MOVF	GLCD_XX,W
	BANKSEL	XOFFSET
	SUBWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	GLCD_YY
	MOVF	GLCD_YY,W
	SUBWF	GLCD_YY1,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	BANKSEL	LINECOLOUR
	MOVF	LINECOLOUR,W
	BANKSEL	GLCDCOLOUR
	MOVWF	GLCDCOLOUR
	BANKSEL	LINECOLOUR_H
	MOVF	LINECOLOUR_H,W
	BANKSEL	GLCDCOLOUR_H
	MOVWF	GLCDCOLOUR_H
	FCALL	PSET_SSD1306
;NEXT
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	BCF	STATUS,0
	BANKSEL	GLCD_YY
	RLF	GLCD_YY,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	ADDWF	YOFFSET,W
	MOVWF	SYSTEMP1
	BANKSEL	GLCD_YY1
	MOVF	GLCD_YY1,W
	BANKSEL	SYSTEMP1
	SUBWF	SYSTEMP1,W
	MOVWF	SYSTEMP2
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF27
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	BANKSEL	GLCD_YY1
	INCF	GLCD_YY1,F
	GOTO	SYSFORLOOP13
;END IF
GLOBAL	ENDIF27
ENDIF27:
GLOBAL	SYSFORLOOPEND13
SYSFORLOOPEND13:
	RETURN

;********************************************************************************

GLOBAL	DELAY_10US
DELAY_10US:
GLOBAL	D10US_START
D10US_START:
	MOVLW	25
	MOVWF	DELAYTEMP
GLOBAL	DELAYUS0
DELAYUS0:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS0
	NOP
	DECFSZ	SYSWAITTEMP10US, F
	GOTO	D10US_START
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

;SOURCE: GLCD.H (3598)
GLOBAL	ELLIPSE
ELLIPSE:
;Version 1.00 (08/20/2017) by Joseph Realmuto
;draws an ellipse outline at location (xoffset, yoffset)
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;filled_ellipse = 0
	CLRF	FILLED_ELLIPSE
;DrawEllipseRoutine( xoffset, yoffset, Inxradius, Inyradius, LineColour )
	LJMP	DRAWELLIPSEROUTINE

;********************************************************************************

;SOURCE: GLCD.H (3610)
GLOBAL	FILLEDELLIPSE
FILLEDELLIPSE:
;Version 1.00 (08/20/2017) by Joseph Realmuto
;draws a filled ellipse at location (xoffset, yoffset)
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;filled_ellipse = 1
	MOVLW	1
	MOVWF	FILLED_ELLIPSE
;DrawEllipseRoutine( xoffset, yoffset, Inxradius, Inyradius, LineColour )
	LJMP	DRAWELLIPSEROUTINE

;********************************************************************************

GLOBAL	GLCDCHARCOL4
GLCDCHARCOL4:
	MOVLW	113
	SUBWF	SYSSTRINGA, W
	BTFSC	STATUS,0
	RETLW	0
	MOVF	SYSSTRINGA, W
	ADDLW	LOW TABLEGLCDCHARCOL4
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH TABLEGLCDCHARCOL4) & 127
	BTFSC	STATUS,0
	ADDLW	1
	MOVWF	PCLATH
	MOVF	SYSSTRINGA, W
	MOVWF	PCL
GLOBAL	TABLEGLCDCHARCOL4
TABLEGLCDCHARCOL4:
	RETLW	112
	RETLW	254
	RETLW	56
	RETLW	10
	RETLW	6
	RETLW	204
	RETLW	102
	RETLW	124
	RETLW	112
	RETLW	4
	RETLW	64
	RETLW	16
	RETLW	56
	RETLW	136
	RETLW	162
	RETLW	112
	RETLW	28
	RETLW	0
	RETLW	0
	RETLW	14
	RETLW	254
	RETLW	84
	RETLW	38
	RETLW	146
	RETLW	10
	RETLW	56
	RETLW	130
	RETLW	16
	RETLW	16
	RETLW	160
	RETLW	16
	RETLW	192
	RETLW	32
	RETLW	162
	RETLW	132
	RETLW	194
	RETLW	130
	RETLW	40
	RETLW	138
	RETLW	148
	RETLW	2
	RETLW	146
	RETLW	146
	RETLW	108
	RETLW	172
	RETLW	40
	RETLW	40
	RETLW	130
	RETLW	2
	RETLW	146
	RETLW	36
	RETLW	146
	RETLW	130
	RETLW	130
	RETLW	146
	RETLW	18
	RETLW	130
	RETLW	16
	RETLW	130
	RETLW	128
	RETLW	16
	RETLW	128
	RETLW	4
	RETLW	8
	RETLW	130
	RETLW	18
	RETLW	130
	RETLW	18
	RETLW	146
	RETLW	2
	RETLW	128
	RETLW	64
	RETLW	128
	RETLW	40
	RETLW	16
	RETLW	162
	RETLW	254
	RETLW	8
	RETLW	130
	RETLW	4
	RETLW	128
	RETLW	2
	RETLW	168
	RETLW	144
	RETLW	136
	RETLW	136
	RETLW	168
	RETLW	252
	RETLW	168
	RETLW	16
	RETLW	144
	RETLW	128
	RETLW	32
	RETLW	130
	RETLW	8
	RETLW	16
	RETLW	136
	RETLW	40
	RETLW	40
	RETLW	16
	RETLW	168
	RETLW	124
	RETLW	128
	RETLW	64
	RETLW	128
	RETLW	80
	RETLW	160
	RETLW	200
	RETLW	16
	RETLW	0
	RETLW	130
	RETLW	16
	RETLW	68

;********************************************************************************

GLOBAL	GLCDCHARCOL5
GLCDCHARCOL5:
	MOVLW	113
	SUBWF	SYSSTRINGA, W
	BTFSC	STATUS,0
	RETLW	0
	MOVF	SYSSTRINGA, W
	ADDLW	LOW TABLEGLCDCHARCOL5
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH TABLEGLCDCHARCOL5) & 127
	BTFSC	STATUS,0
	ADDLW	1
	MOVWF	PCLATH
	MOVF	SYSSTRINGA, W
	MOVWF	PCL
GLOBAL	TABLEGLCDCHARCOL5
TABLEGLCDCHARCOL5:
	RETLW	112
	RETLW	124
	RETLW	124
	RETLW	0
	RETLW	0
	RETLW	238
	RETLW	238
	RETLW	124
	RETLW	168
	RETLW	254
	RETLW	254
	RETLW	84
	RETLW	84
	RETLW	148
	RETLW	148
	RETLW	124
	RETLW	124
	RETLW	0
	RETLW	158
	RETLW	0
	RETLW	40
	RETLW	254
	RETLW	16
	RETLW	170
	RETLW	6
	RETLW	68
	RETLW	68
	RETLW	124
	RETLW	124
	RETLW	96
	RETLW	16
	RETLW	192
	RETLW	16
	RETLW	146
	RETLW	254
	RETLW	162
	RETLW	138
	RETLW	36
	RETLW	138
	RETLW	146
	RETLW	226
	RETLW	146
	RETLW	146
	RETLW	108
	RETLW	108
	RETLW	68
	RETLW	40
	RETLW	68
	RETLW	162
	RETLW	242
	RETLW	34
	RETLW	146
	RETLW	130
	RETLW	130
	RETLW	146
	RETLW	18
	RETLW	146
	RETLW	16
	RETLW	254
	RETLW	130
	RETLW	40
	RETLW	128
	RETLW	24
	RETLW	16
	RETLW	130
	RETLW	18
	RETLW	162
	RETLW	50
	RETLW	146
	RETLW	254
	RETLW	128
	RETLW	128
	RETLW	112
	RETLW	16
	RETLW	224
	RETLW	146
	RETLW	130
	RETLW	16
	RETLW	130
	RETLW	2
	RETLW	128
	RETLW	4
	RETLW	168
	RETLW	136
	RETLW	136
	RETLW	136
	RETLW	168
	RETLW	18
	RETLW	168
	RETLW	8
	RETLW	250
	RETLW	136
	RETLW	80
	RETLW	254
	RETLW	240
	RETLW	8
	RETLW	136
	RETLW	40
	RETLW	40
	RETLW	8
	RETLW	168
	RETLW	144
	RETLW	128
	RETLW	128
	RETLW	96
	RETLW	32
	RETLW	160
	RETLW	168
	RETLW	108
	RETLW	254
	RETLW	108
	RETLW	16
	RETLW	66

;********************************************************************************

GLOBAL	GLCDCHARCOL6
GLCDCHARCOL6:
	MOVLW	113
	SUBWF	SYSSTRINGA, W
	BTFSC	STATUS,0
	RETLW	0
	MOVF	SYSSTRINGA, W
	ADDLW	LOW TABLEGLCDCHARCOL6
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH TABLEGLCDCHARCOL6) & 127
	BTFSC	STATUS,0
	ADDLW	1
	MOVWF	PCLATH
	MOVF	SYSSTRINGA, W
	MOVWF	PCL
GLOBAL	TABLEGLCDCHARCOL6
TABLEGLCDCHARCOL6:
	RETLW	112
	RETLW	56
	RETLW	254
	RETLW	12
	RETLW	10
	RETLW	204
	RETLW	102
	RETLW	124
	RETLW	32
	RETLW	4
	RETLW	64
	RETLW	56
	RETLW	16
	RETLW	162
	RETLW	136
	RETLW	112
	RETLW	28
	RETLW	0
	RETLW	0
	RETLW	14
	RETLW	254
	RETLW	84
	RETLW	200
	RETLW	68
	RETLW	0
	RETLW	130
	RETLW	56
	RETLW	16
	RETLW	16
	RETLW	0
	RETLW	16
	RETLW	0
	RETLW	8
	RETLW	138
	RETLW	128
	RETLW	146
	RETLW	150
	RETLW	254
	RETLW	138
	RETLW	146
	RETLW	18
	RETLW	146
	RETLW	82
	RETLW	0
	RETLW	0
	RETLW	130
	RETLW	40
	RETLW	40
	RETLW	18
	RETLW	130
	RETLW	36
	RETLW	146
	RETLW	130
	RETLW	68
	RETLW	146
	RETLW	18
	RETLW	146
	RETLW	16
	RETLW	130
	RETLW	126
	RETLW	68
	RETLW	128
	RETLW	4
	RETLW	32
	RETLW	130
	RETLW	18
	RETLW	66
	RETLW	82
	RETLW	146
	RETLW	2
	RETLW	128
	RETLW	64
	RETLW	128
	RETLW	40
	RETLW	16
	RETLW	138
	RETLW	130
	RETLW	32
	RETLW	254
	RETLW	4
	RETLW	128
	RETLW	8
	RETLW	168
	RETLW	136
	RETLW	136
	RETLW	144
	RETLW	168
	RETLW	2
	RETLW	168
	RETLW	8
	RETLW	128
	RETLW	122
	RETLW	136
	RETLW	128
	RETLW	8
	RETLW	8
	RETLW	136
	RETLW	40
	RETLW	48
	RETLW	8
	RETLW	168
	RETLW	128
	RETLW	64
	RETLW	64
	RETLW	128
	RETLW	80
	RETLW	160
	RETLW	152
	RETLW	130
	RETLW	0
	RETLW	16
	RETLW	32
	RETLW	68

;********************************************************************************

GLOBAL	GLCDCHARCOL7
GLCDCHARCOL7:
	MOVLW	113
	SUBWF	SYSSTRINGA, W
	BTFSC	STATUS,0
	RETLW	0
	MOVF	SYSSTRINGA, W
	ADDLW	LOW TABLEGLCDCHARCOL7
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH TABLEGLCDCHARCOL7) & 127
	BTFSC	STATUS,0
	ADDLW	1
	MOVWF	PCLATH
	MOVF	SYSSTRINGA, W
	MOVWF	PCL
GLOBAL	TABLEGLCDCHARCOL7
TABLEGLCDCHARCOL7:
	RETLW	112
	RETLW	16
	RETLW	0
	RETLW	10
	RETLW	6
	RETLW	136
	RETLW	34
	RETLW	56
	RETLW	62
	RETLW	8
	RETLW	32
	RETLW	16
	RETLW	16
	RETLW	128
	RETLW	128
	RETLW	64
	RETLW	4
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	40
	RETLW	36
	RETLW	196
	RETLW	160
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	40
	RETLW	16
	RETLW	0
	RETLW	16
	RETLW	0
	RETLW	4
	RETLW	124
	RETLW	0
	RETLW	140
	RETLW	98
	RETLW	32
	RETLW	114
	RETLW	96
	RETLW	14
	RETLW	108
	RETLW	60
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	40
	RETLW	16
	RETLW	12
	RETLW	124
	RETLW	248
	RETLW	108
	RETLW	68
	RETLW	56
	RETLW	130
	RETLW	2
	RETLW	244
	RETLW	254
	RETLW	0
	RETLW	2
	RETLW	130
	RETLW	128
	RETLW	254
	RETLW	254
	RETLW	124
	RETLW	12
	RETLW	188
	RETLW	140
	RETLW	100
	RETLW	2
	RETLW	126
	RETLW	62
	RETLW	126
	RETLW	198
	RETLW	14
	RETLW	134
	RETLW	0
	RETLW	64
	RETLW	0
	RETLW	8
	RETLW	128
	RETLW	0
	RETLW	240
	RETLW	112
	RETLW	64
	RETLW	254
	RETLW	48
	RETLW	4
	RETLW	120
	RETLW	240
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	240
	RETLW	240
	RETLW	112
	RETLW	16
	RETLW	248
	RETLW	16
	RETLW	64
	RETLW	64
	RETLW	248
	RETLW	56
	RETLW	120
	RETLW	136
	RETLW	120
	RETLW	136
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	16
	RETLW	120

;********************************************************************************

;SOURCE: GLCD.H (1285)
GLOBAL	GLCDDRAWSTRING
GLCDDRAWSTRING:
;dim GLCDPrintLoc as word
;GLCDPrintLoc = StringLocX
	BANKSEL	STRINGLOCX
	MOVF	STRINGLOCX,W
	BANKSEL	GLCDPRINTLOC
	MOVWF	GLCDPRINTLOC
	CLRF	GLCDPRINTLOC_H
;for xchar = 1 to Chars(0)
	MOVLW	1
	BANKSEL	XCHAR
	MOVWF	XCHAR
GLOBAL	SYSFORLOOP10
SYSFORLOOP10:
;GLCDDrawChar GLCDPrintLoc , CharLocY , Chars(xchar), LineColour
	BANKSEL	GLCDPRINTLOC
	MOVF	GLCDPRINTLOC,W
	MOVWF	CHARLOCX
	MOVF	GLCDPRINTLOC_H,W
	MOVWF	CHARLOCX_H
	BANKSEL	XCHAR
	MOVF	XCHAR,W
	BANKSEL	SYSCHARSHANDLER
	ADDWF	SYSCHARSHANDLER,W
	MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSCHARSHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	CHARCODE
	MOVWF	CHARCODE
	FCALL	GLCDDRAWCHAR_SSD1306
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1219)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	MOVF	GLCDFONTWIDTH,W
	MOVWF	SYSBYTETEMPA
	MOVF	GLCDFNTDEFAULTSIZE,W
	MOVWF	SYSBYTETEMPB
	CALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	GLCDPRINTLOC
	ADDWF	GLCDPRINTLOC,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	MOVLW	0
	BANKSEL	GLCDPRINTLOC_H
	ADDWFC	GLCDPRINTLOC_H,W
	BANKSEL	SYSTEMP1_H
	MOVWF	SYSTEMP1_H
	MOVLW	1
	ADDWF	SYSTEMP1,W
	BANKSEL	GLCDPRINTLOC
	MOVWF	GLCDPRINTLOC
	MOVLW	0
	BANKSEL	SYSTEMP1_H
	ADDWFC	SYSTEMP1_H,W
	BANKSEL	GLCDPRINTLOC_H
	MOVWF	GLCDPRINTLOC_H
;next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	BANKSEL	SYSCHARSHANDLER
	MOVF	SYSCHARSHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSCHARSHANDLER_H,W
	MOVWF	FSR0H
	BANKSEL	XCHAR
	MOVF	XCHAR,W
	SUBWF	INDF0,W
	MOVWF	SYSTEMP2
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF14
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	BANKSEL	XCHAR
	INCF	XCHAR,F
	GOTO	SYSFORLOOP10
;END IF
GLOBAL	ENDIF14
ENDIF14:
GLOBAL	SYSFORLOOPEND10
SYSFORLOOPEND10:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:WORD:STRING:, SOURCE: GLCD.H (981)
GLOBAL	GLCDPRINT4
GLCDPRINT4:
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVF	SYSLCDPRINTDATAHANDLER,W
	MOVWF	FSR0L
	MOVF	SYSLCDPRINTDATAHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	GLCDPRINTLEN
	MOVWF	GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	MOVF	GLCDPRINTLEN,F
	BTFSC	STATUS,2
;If GLCDPrintLen = 0 Then Exit Sub
	RETURN
;If GLCDPrintLen = 0 Then Exit Sub
;GLCDPrintLoc = PrintLocX
	BANKSEL	PRINTLOCX
	MOVF	PRINTLOCX,W
	BANKSEL	GLCDPRINTLOC
	MOVWF	GLCDPRINTLOC
	BANKSEL	PRINTLOCX_H
	MOVF	PRINTLOCX_H,W
	BANKSEL	GLCDPRINTLOC_H
	MOVWF	GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	MOVLW	1
	MOVWF	GLCDPRINT_STRING_COUNTER
GLOBAL	SYSFORLOOP8
SYSFORLOOP8:
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	MOVF	GLCDPRINTLOC,W
	MOVWF	CHARLOCX
	MOVF	GLCDPRINTLOC_H,W
	MOVWF	CHARLOCX_H
	BANKSEL	PRINTLOCY
	MOVF	PRINTLOCY,W
	BANKSEL	CHARLOCY
	MOVWF	CHARLOCY
	BANKSEL	PRINTLOCY_H
	MOVF	PRINTLOCY_H,W
	BANKSEL	CHARLOCY_H
	MOVWF	CHARLOCY_H
	MOVF	GLCDPRINT_STRING_COUNTER,W
	BANKSEL	SYSLCDPRINTDATAHANDLER
	ADDWF	SYSLCDPRINTDATAHANDLER,W
	MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSLCDPRINTDATAHANDLER_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	CHARCODE
	MOVWF	CHARCODE
	MOVF	GLCDFOREGROUND,W
	BANKSEL	LINECOLOUR
	MOVWF	LINECOLOUR
	BANKSEL	GLCDFOREGROUND_H
	MOVF	GLCDFOREGROUND_H,W
	BANKSEL	LINECOLOUR_H
	MOVWF	LINECOLOUR_H
	BANKSEL	STATUS
	FCALL	GLCDDRAWCHAR_SSD1306
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1219)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	MOVF	GLCDFONTWIDTH,W
	MOVWF	SYSBYTETEMPA
	MOVF	GLCDFNTDEFAULTSIZE,W
	MOVWF	SYSBYTETEMPB
	CALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	GLCDPRINTLOC
	ADDWF	GLCDPRINTLOC,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	MOVLW	0
	BANKSEL	GLCDPRINTLOC_H
	ADDWFC	GLCDPRINTLOC_H,W
	BANKSEL	SYSTEMP1_H
	MOVWF	SYSTEMP1_H
	MOVLW	1
	ADDWF	SYSTEMP1,W
	BANKSEL	GLCDPRINTLOC
	MOVWF	GLCDPRINTLOC
	MOVLW	0
	BANKSEL	SYSTEMP1_H
	ADDWFC	SYSTEMP1_H,W
	BANKSEL	GLCDPRINTLOC_H
	MOVWF	GLCDPRINTLOC_H
;Next
;POSITIVE VALUE STEP HANDLER IN FOR-NEXT STATEMENT :#4P 
	MOVF	GLCDPRINT_STRING_COUNTER,W
	SUBWF	GLCDPRINTLEN,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	MOVWF	SYSBYTETEMPA
	CLRF	SYSBYTETEMPB
	BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF10
;SET LOOPVAR TO LOOPVAR + STEPVALUE WHERE STEPVALUE IS A POSITIVE VALUE
	INCF	GLCDPRINT_STRING_COUNTER,F
	GOTO	SYSFORLOOP8
;END IF
GLOBAL	ENDIF10
ENDIF10:
GLOBAL	SYSFORLOOPEND8
SYSFORLOOPEND8:
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	MOVF	GLCDPRINTLOC,W
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	BANKSEL	GLCDPRINTLOC_H
	MOVF	GLCDPRINTLOC_H,W
	BANKSEL	PRINTLOCX_H
	MOVWF	PRINTLOCX_H
	BANKSEL	STATUS
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
	GOTO	ENDIF93
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
GLOBAL	ENDIF93
ENDIF93:
;if HI2CCurrentMode = Slave then
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,F
	BTFSS	STATUS,2
	GOTO	ENDIF94
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
GLOBAL	ENDIF94
ENDIF94:
;if HI2CCurrentMode = Slave10 then
	MOVLW	3
	BANKSEL	HI2CCURRENTMODE
	SUBWF	HI2CCURRENTMODE,W
	BTFSS	STATUS,2
	GOTO	ENDIF95
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
GLOBAL	ENDIF95
ENDIF95:
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
	GOTO	ELSE82_1
;HI2CAckPollState = true
	MOVLW	255
	BANKSEL	HI2CACKPOLLSTATE
	MOVWF	HI2CACKPOLLSTATE
;else
	GOTO	ENDIF82
GLOBAL	ELSE82_1
ELSE82_1:
;HI2CAckPollState = false
	BANKSEL	HI2CACKPOLLSTATE
	CLRF	HI2CACKPOLLSTATE
;end if
GLOBAL	ENDIF82
ENDIF82:
;If SSPCON1.WCOL = On Then
	BANKSEL	SSP1CON1
	BTFSS	SSP1CON1,7
	GOTO	ENDIF83
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
	BTFSC	STATUS,0
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	GOTO	RETRYHI2CSEND
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
;End If
GLOBAL	ENDIF83
ENDIF83:
;Release clock (only needed by slave)
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
	BTFSS	STATUS,0
	GOTO	ENDIF84
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	BANKSEL	SSP1CON1
	BSF	SSP1CON1,4
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
GLOBAL	ENDIF84
ENDIF84:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (312)
GLOBAL	HI2CSTART
HI2CSTART:
;asm showdebug  This method sets the registers and register bits to generate the I2C  START signal
;If HI2CCurrentMode > 10 Then
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
	BTFSC	STATUS,0
	GOTO	ELSE80_1
;Master_mode operational
;Set SEN On
	BANKSEL	SSP1CON2
	BSF	SSP1CON2,0
;HI2CWaitMSSP
	BANKSEL	STATUS
	CALL	HI2CWAITMSSP
;Else
	GOTO	ENDIF80
GLOBAL	ELSE80_1
ELSE80_1:
;Slave mode operational
;Wait Until SSPSTAT.S = On
GLOBAL	SYSWAITLOOP2
SYSWAITLOOP2:
	BANKSEL	SSP1STAT
	BTFSS	SSP1STAT,3
	GOTO	SYSWAITLOOP2
;End If
GLOBAL	ENDIF80
ENDIF80:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (362)
GLOBAL	HI2CSTOP
HI2CSTOP:
;Master_mode
;If HI2CCurrentMode > 10 Then
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
	BTFSC	STATUS,0
	GOTO	ELSE81_1
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
	GOTO	ENDIF81
GLOBAL	ELSE81_1
ELSE81_1:
;Wait Until SSPSTAT.P = On
GLOBAL	SYSWAITLOOP4
SYSWAITLOOP4:
	BANKSEL	SSP1STAT
	BTFSS	SSP1STAT,4
	GOTO	SYSWAITLOOP4
;End If
GLOBAL	ENDIF81
ENDIF81:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (515)
GLOBAL	HI2CWAITMSSP
HI2CWAITMSSP:
;HI2CWaitMSSPTimeout = 0
	BANKSEL	HI2CWAITMSSPTIMEOUT
	CLRF	HI2CWAITMSSPTIMEOUT
GLOBAL	HI2CWAITMSSPWAIT
HI2CWAITMSSPWAIT:
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F
;if HI2CWaitMSSPTimeout < 255 then
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W
	BTFSC	STATUS,0
	GOTO	ENDIF86
;'Support for SSP1IF
;if SSP1IF = 0 then goto HI2CWaitMSSPWait
	BTFSS	PIR5,2
;if SSP1IF = 0 then goto HI2CWaitMSSPWait
	GOTO	HI2CWAITMSSPWAIT
;if SSP1IF = 0 then goto HI2CWaitMSSPWait
;SSP1IF = 0
	BCF	PIR5,2
;end if
GLOBAL	ENDIF86
ENDIF86:
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (883)
GLOBAL	PSET_SSD1306
PSET_SSD1306:
;Set pixel at X, Y on LCD to State
;X is 0 to 127
;Y is 0 to 63
;Origin in top left
;anything off screen with be rejected
;if GLCDX => GLCD_WIDTH OR GLCDY => GLCD_HEIGHT Then
	MOVF	GLCDX,W
	MOVWF	SYSBYTETEMPA
	MOVLW	128
	MOVWF	SYSBYTETEMPB
	FCALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	GLCDY
	MOVF	GLCDY,W
	MOVWF	SYSBYTETEMPA
	MOVLW	32
	MOVWF	SYSBYTETEMPB
	FCALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F
	BANKSEL	SYSTEMP2
	MOVF	SYSTEMP2,W
	IORWF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP1
	BTFSS	SYSTEMP1,0
	GOTO	ENDIF44
;exit sub
	BANKSEL	STATUS
	RETURN
;end if
GLOBAL	ENDIF44
ENDIF44:
;1.14 Addresses correct device horizonal page
;Is YPOS addressing the page we need?
;SSD1306_BufferLocationCalc = GLCDY
;Repeat 3
;Set C Off
;Rotate SSD1306_BufferLocationCalc Right
;End Repeat
;if SSD1306_BufferLocationCalc = _GLCDPage then
;GLCDY_Temp = ( GLCDY / 8 )* GLCD_WIDTH
;faster than /8
;GLCDY_Temp = GLCDY
	BANKSEL	GLCDY
	MOVF	GLCDY,W
	MOVWF	GLCDY_TEMP
;Repeat 3
	MOVLW	3
	BANKSEL	SYSREPEATTEMP2
	MOVWF	SYSREPEATTEMP2
GLOBAL	SYSREPEATLOOP2
SYSREPEATLOOP2:
;Set C Off
	BCF	STATUS,0
;Rotate GLCDY_Temp Right
	BANKSEL	GLCDY_TEMP
	RRF	GLCDY_TEMP,F
;End Repeat
	BANKSEL	SYSREPEATTEMP2
	DECFSZ	SYSREPEATTEMP2,F
	GOTO	SYSREPEATLOOP2
GLOBAL	SYSREPEATLOOPEND2
SYSREPEATLOOPEND2:
;if GLCDY_Temp = _GLCDPage then
	MOVF	_GLCDPAGE,W
	BANKSEL	GLCDY_TEMP
	SUBWF	GLCDY_TEMP,W
	BTFSS	STATUS,2
	GOTO	ELSE45_1
;Mod the YPOS to get the correct pixel with the page
;GLCDY = GLCDY mod 8
	MOVF	GLCDY,W
	MOVWF	SYSBYTETEMPA
	MOVLW	8
	MOVWF	SYSBYTETEMPB
	FCALL	SYSDIVSUB
	MOVF	SYSBYTETEMPX,W
	MOVWF	GLCDY
;Else
	GOTO	ENDIF45
GLOBAL	ELSE45_1
ELSE45_1:
;Exit if not the page we are looking for
;exit sub
	RETURN
;end if
GLOBAL	ENDIF45
ENDIF45:
;buffer location in LOWMEMORY_GLCD_MODE always equals GLCDX + 1
;SSD1306_BufferLocationCalc = GLCDX + 1
	MOVLW	1
	ADDWF	GLCDX,W
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	MOVWF	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC_H
	BTFSC	STATUS,0
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F
;don't need to do these calculations for in LOWMEMORY_GLCD_MODE
;anything beyond buffer boundary?
;why? X = 127 and Y = 64 (Y is over 63!) will have passed first check....
;if SSD1306_BufferLocationCalc > GLCD_HEIGHT * GLCD_WIDTH Then
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	SYSWORDTEMPB
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	SYSWORDTEMPB_H
	CLRF	SYSWORDTEMPA
	MOVLW	16
	MOVWF	SYSWORDTEMPA_H
	BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
;exit sub
	RETURN
;end if
;GLCDDataTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	GLCDDATATEMP
	MOVWF	GLCDDATATEMP
;Change data to set/clear pixel
;GLCDBitNo = GLCDY And 7
	MOVLW	7
	ANDWF	GLCDY,W
	MOVWF	GLCDBITNO
;If GLCDColour.0 = 0 Then
	BTFSC	GLCDCOLOUR,0
	GOTO	ELSE47_1
;GLCDChange = 254
	MOVLW	254
	MOVWF	GLCDCHANGE
;Set C On
	BSF	STATUS,0
;Else
	GOTO	ENDIF47
GLOBAL	ELSE47_1
ELSE47_1:
;GLCDChange = 1
	MOVLW	1
	MOVWF	GLCDCHANGE
;Set C Off
	BCF	STATUS,0
;End If
GLOBAL	ENDIF47
ENDIF47:
;Repeat GLCDBitNo
	MOVF	GLCDBITNO,W
	BANKSEL	SYSREPEATTEMP2
	MOVWF	SYSREPEATTEMP2
	BTFSC	STATUS,2
	GOTO	SYSREPEATLOOPEND3
GLOBAL	SYSREPEATLOOP3
SYSREPEATLOOP3:
;Rotate GLCDChange Left
	BANKSEL	GLCDCHANGE
	RLF	GLCDCHANGE,F
;End Repeat
	BANKSEL	SYSREPEATTEMP2
	DECFSZ	SYSREPEATTEMP2,F
	GOTO	SYSREPEATLOOP3
GLOBAL	SYSREPEATLOOPEND3
SYSREPEATLOOPEND3:
;If GLCDColour.0 = 0 Then
	BANKSEL	GLCDCOLOUR
	BTFSC	GLCDCOLOUR,0
	GOTO	ELSE48_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	MOVF	GLCDDATATEMP,W
	ANDWF	GLCDCHANGE,W
	MOVWF	GLCDDATATEMP
;Else
	GOTO	ENDIF48
GLOBAL	ELSE48_1
ELSE48_1:
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	MOVF	GLCDDATATEMP,W
	IORWF	GLCDCHANGE,W
	MOVWF	GLCDDATATEMP
;End If
GLOBAL	ENDIF48
ENDIF48:
;added 1.14 to isolate from full glcd mode
;restore address the correct page by adjustng the Y
;GLCDY = GLCDY + ( 8 * _GLCDPage )
	BANKSEL	_GLCDPAGE
	MOVF	_GLCDPAGE,W
	MOVWF	SYSBYTETEMPA
	MOVLW	8
	MOVWF	SYSBYTETEMPB
	BANKSEL	STATUS
	FCALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	GLCDY
	ADDWF	GLCDY,F
;if SSD1306_BufferAlias(SSD1306_BufferLocationCalc) <> GLCDDataTemp then
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	FSR0H
	BANKSEL	GLCDDATATEMP
	MOVF	GLCDDATATEMP,W
	SUBWF	INDF0,W
	BTFSC	STATUS,2
	GOTO	ENDIF49
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDDataTemp
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	FSR0H
	BANKSEL	GLCDDATATEMP
	MOVF	GLCDDATATEMP,W
	MOVWF	INDF0
;end if
GLOBAL	ENDIF49
ENDIF49:
;revised 1.14 to isolate from low memory mode
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3104)
GLOBAL	SYSCOMPEQUAL16
SYSCOMPEQUAL16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	MOVF	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	SUBWF	SYSWORDTEMPB, W
;btfss STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test high, exit if false
;movf SysWordTempA_H, W
	MOVF	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	SUBWF	SYSWORDTEMPB_H, W
;btfss STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3158)
GLOBAL	SYSCOMPEQUAL32
SYSCOMPEQUAL32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test low, exit if false
;movf SysLongTempA, W
	MOVF	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	SUBWF	SYSLONGTEMPB, W
;btfss STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test high, exit if false
;movf SysLongTempA_H, W
	MOVF	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	SUBWF	SYSLONGTEMPB_H, W
;btfss STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test upper, exit if false
;movf SysLongTempA_U, W
	MOVF	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	SUBWF	SYSLONGTEMPB_U, W
;btfss STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test exp, exit if false
;movf SysLongTempA_E, W
	MOVF	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	SUBWF	SYSLONGTEMPB_E, W
;btfss STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3383)
GLOBAL	SYSCOMPLESSTHAN
SYSCOMPLESSTHAN:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;bsf STATUS, C
	BSF	STATUS,0
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;subwf SysByteTempA, W
	SUBWF	SYSBYTETEMPA, W
;btfss STATUS, C
	BTFSS	STATUS,0
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

;SOURCE: SYSTEM.H (3471)
GLOBAL	SYSCOMPLESSTHAN32
SYSCOMPLESSTHAN32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test Exp, exit if more
;movf SysLongTempA_E,W
	MOVF	SYSLONGTEMPA_E,W
;subwf SysLongTempB_E,W
	SUBWF	SYSLONGTEMPB_E,W
;btfss STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
	BTFSS	STATUS,2
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	MOVF	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	SUBWF	SYSLONGTEMPB_U,W
;btfss STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
	BTFSS	STATUS,2
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	MOVF	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	SUBWF	SYSLONGTEMPB_H,W
;btfss STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
	BTFSS	STATUS,2
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	MOVF	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	SUBWF	SYSLONGTEMPA,W
;btfsc STATUS,C
	BTFSC	STATUS,0
;return
	RETURN
GLOBAL	SCLT32TRUE
SCLT32TRUE:
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3714)
GLOBAL	SYSCOMPLESSTHANINT
SYSCOMPLESSTHANINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	CLRF	SYSBYTETEMPX
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	BTFSS	SYSINTEGERTEMPA_H,7
	GOTO	ELSE68_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	BTFSC	SYSINTEGERTEMPB_H,7
	GOTO	ENDIF69
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	COMF	SYSBYTETEMPX,F
;Exit Sub
	RETURN
;End If
GLOBAL	ENDIF69
ENDIF69:
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	COMF	SYSINTEGERTEMPA,W
	MOVWF	SYSDIVMULTA
	COMF	SYSINTEGERTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
	INCF	SYSDIVMULTA,F
	BTFSC	STATUS,2
	INCF	SYSDIVMULTA_H,F
;SysIntegerTempA = -SysIntegerTempB
	COMF	SYSINTEGERTEMPB,W
	MOVWF	SYSINTEGERTEMPA
	COMF	SYSINTEGERTEMPB_H,W
	MOVWF	SYSINTEGERTEMPA_H
	INCF	SYSINTEGERTEMPA,F
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPA_H,F
;SysIntegerTempB = SysDivMultA
	MOVF	SYSDIVMULTA,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	SYSDIVMULTA_H,W
	MOVWF	SYSINTEGERTEMPB_H
;+A
;Else
	GOTO	ENDIF68
GLOBAL	ELSE68_1
ELSE68_1:
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	BTFSC	SYSINTEGERTEMPB_H,7
;Exit Sub
	RETURN
;End If
;End If
GLOBAL	ENDIF68
ENDIF68:
;Test High, exit if more
;movf SysIntegerTempA_H,W
	MOVF	SYSINTEGERTEMPA_H,W
;subwf SysIntegerTempB_H,W
	SUBWF	SYSINTEGERTEMPB_H,W
;btfss STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	MOVF	SYSINTEGERTEMPB_H,W
;subwf SysIntegerTempA_H,W
	SUBWF	SYSINTEGERTEMPA_H,W
;btfss STATUS,C
	BTFSS	STATUS,0
;goto SCLTIntTrue
	GOTO	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	MOVF	SYSINTEGERTEMPB,W
;subwf SysIntegerTempA,W
	SUBWF	SYSINTEGERTEMPA,W
;btfsc STATUS,C
	BTFSC	STATUS,0
;return
	RETURN
GLOBAL	SCLTINTTRUE
SCLTINTTRUE:
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

;SOURCE: SYSTEM.H (2861)
GLOBAL	SYSDIVSUB16
SYSDIVSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSDIVMULTA
	MOVF	SYSWORDTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	MOVF	SYSWORDTEMPB,W
	MOVWF	SYSDIVMULTB
	MOVF	SYSWORDTEMPB_H,W
	MOVWF	SYSDIVMULTB_H
;SysDivMultX = 0
	CLRF	SYSDIVMULTX
	CLRF	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	MOVF	SYSDIVMULTB,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTB_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF91
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
;exit sub
	RETURN
;end if
GLOBAL	ENDIF91
ENDIF91:
;Main calc routine
;SysDivLoop = 16
	MOVLW	16
	MOVWF	SYSDIVLOOP
GLOBAL	SYSDIV16START
SYSDIV16START:
;set C off
	BCF	STATUS,0
;Rotate SysDivMultA Left
	RLF	SYSDIVMULTA,F
	RLF	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	RLF	SYSDIVMULTX,F
	RLF	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	MOVF	SYSDIVMULTB,W
	SUBWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	SUBWFB	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	BSF	SYSDIVMULTA,0
;If C Off Then
	BTFSC	STATUS,0
	GOTO	ENDIF92
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	ADDWFC	SYSDIVMULTX_H,F
;End If
GLOBAL	ENDIF92
ENDIF92:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv16Start
	GOTO	SYSDIV16START
;SysWordTempA = SysDivMultA
	MOVF	SYSDIVMULTA,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTA_H,W
	MOVWF	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	MOVF	SYSDIVMULTX,W
	MOVWF	SYSWORDTEMPX
	MOVF	SYSDIVMULTX_H,W
	MOVWF	SYSWORDTEMPX_H
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2937)
GLOBAL	SYSDIVSUB32
SYSDIVSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	MOVF	SYSLONGTEMPA,W
	BANKSEL	SYSLONGDIVMULTA
	MOVWF	SYSLONGDIVMULTA
	MOVF	SYSLONGTEMPA_H,W
	MOVWF	SYSLONGDIVMULTA_H
	MOVF	SYSLONGTEMPA_U,W
	MOVWF	SYSLONGDIVMULTA_U
	MOVF	SYSLONGTEMPA_E,W
	MOVWF	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	MOVF	SYSLONGTEMPB,W
	MOVWF	SYSLONGDIVMULTB
	MOVF	SYSLONGTEMPB_H,W
	MOVWF	SYSLONGDIVMULTB_H
	MOVF	SYSLONGTEMPB_U,W
	MOVWF	SYSLONGDIVMULTB_U
	MOVF	SYSLONGTEMPB_E,W
	MOVWF	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	CLRF	SYSLONGDIVMULTX
	CLRF	SYSLONGDIVMULTX_H
	CLRF	SYSLONGDIVMULTX_U
	CLRF	SYSLONGDIVMULTX_E
;Avoid division by zero
;if SysLongDivMultB = 0 then
	MOVF	SYSLONGDIVMULTB,W
	MOVWF	SYSLONGTEMPA
	MOVF	SYSLONGDIVMULTB_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	SYSLONGDIVMULTB_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	SYSLONGDIVMULTB_E,W
	MOVWF	SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB
	CLRF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	BANKSEL	STATUS
	CALL	SYSCOMPEQUAL32
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF66
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA
	CLRF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
;exit sub
	RETURN
;end if
GLOBAL	ENDIF66
ENDIF66:
;Main calc routine
;SysDivLoop = 32
	MOVLW	32
	MOVWF	SYSDIVLOOP
GLOBAL	SYSDIV32START
SYSDIV32START:
;set C off
	BCF	STATUS,0
;Rotate SysLongDivMultA Left
	BANKSEL	SYSLONGDIVMULTA
	RLF	SYSLONGDIVMULTA,F
	RLF	SYSLONGDIVMULTA_H,F
	RLF	SYSLONGDIVMULTA_U,F
	RLF	SYSLONGDIVMULTA_E,F
;Rotate SysLongDivMultX Left
	RLF	SYSLONGDIVMULTX,F
	RLF	SYSLONGDIVMULTX_H,F
	RLF	SYSLONGDIVMULTX_U,F
	RLF	SYSLONGDIVMULTX_E,F
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W
	SUBWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTB_H,W
	SUBWFB	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTB_U,W
	SUBWFB	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTB_E,W
	SUBWFB	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	BSF	SYSLONGDIVMULTA,0
;If C Off Then
	BTFSC	STATUS,0
	GOTO	ENDIF67
;Set SysLongDivMultA.0 Off
	BCF	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W
	ADDWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTB_H,W
	ADDWFC	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTB_U,W
	ADDWFC	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTB_E,W
	ADDWFC	SYSLONGDIVMULTX_E,F
;End If
GLOBAL	ENDIF67
ENDIF67:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv32Start
	GOTO	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	MOVF	SYSLONGDIVMULTA,W
	MOVWF	SYSLONGTEMPA
	MOVF	SYSLONGDIVMULTA_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	SYSLONGDIVMULTA_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	SYSLONGDIVMULTA_E,W
	MOVWF	SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	MOVF	SYSLONGDIVMULTX,W
	MOVWF	SYSLONGTEMPX
	MOVF	SYSLONGDIVMULTX_H,W
	MOVWF	SYSLONGTEMPX_H
	MOVF	SYSLONGDIVMULTX_U,W
	MOVWF	SYSLONGTEMPX_U
	MOVF	SYSLONGDIVMULTX_E,W
	MOVWF	SYSLONGTEMPX_E
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2915)
GLOBAL	SYSDIVSUBINT
SYSDIVSUBINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	MOVF	SYSINTEGERTEMPA_H,W
	XORWF	SYSINTEGERTEMPB_H,W
	MOVWF	SYSSIGNBYTE
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	BTFSS	SYSINTEGERTEMPA_H,7
	GOTO	ENDIF63
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	COMF	SYSINTEGERTEMPA,F
	COMF	SYSINTEGERTEMPA_H,F
	INCF	SYSINTEGERTEMPA,F
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPA_H,F
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
GLOBAL	ENDIF63
ENDIF63:
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	BTFSS	SYSINTEGERTEMPB_H,7
	GOTO	ENDIF64
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	COMF	SYSINTEGERTEMPB,F
	COMF	SYSINTEGERTEMPB_H,F
	INCF	SYSINTEGERTEMPB,F
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPB_H,F
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
GLOBAL	ENDIF64
ENDIF64:
;Call word divide routine
;SysDivSub16
	CALL	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	BTFSS	SYSSIGNBYTE,7
	GOTO	ENDIF65
;SysIntegerTempA = -SysIntegerTempA
	COMF	SYSINTEGERTEMPA,F
	COMF	SYSINTEGERTEMPA_H,F
	INCF	SYSINTEGERTEMPA,F
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPA_H,F
;SysIntegerTempX = -SysIntegerTempX
	COMF	SYSINTEGERTEMPX,F
	COMF	SYSINTEGERTEMPX_H,F
	INCF	SYSINTEGERTEMPX,F
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPX_H,F
;End If
GLOBAL	ENDIF65
ENDIF65:
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2518)
GLOBAL	SYSMULTSUB
SYSMULTSUB:
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
GLOBAL	MUL8LOOP
MUL8LOOP:
;movf SysByteTempA, W
	MOVF	SYSBYTETEMPA, W
;btfsc SysByteTempB, 0
	BTFSC	SYSBYTETEMPB, 0
;addwf SysByteTempX, F
	ADDWF	SYSBYTETEMPX, F
;bcf STATUS, C
	BCF	STATUS,0
;rrf SysByteTempB, F
	RRF	SYSBYTETEMPB, F
;bcf STATUS, C
	BCF	STATUS,0
;rlf SysByteTempA, F
	RLF	SYSBYTETEMPA, F
;movf SysByteTempB, F
	MOVF	SYSBYTETEMPB, F
;btfss STATUS, Z
	BTFSS	STATUS,2
;goto MUL8LOOP
	GOTO	MUL8LOOP
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2565)
GLOBAL	SYSMULTSUB16
SYSMULTSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSDIVMULTA
	MOVF	SYSWORDTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	MOVF	SYSWORDTEMPB,W
	MOVWF	SYSDIVMULTB
	MOVF	SYSWORDTEMPB_H,W
	MOVWF	SYSDIVMULTB_H
;SysDivMultX = 0
	CLRF	SYSDIVMULTX
	CLRF	SYSDIVMULTX_H
GLOBAL	MUL16LOOP
MUL16LOOP:
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	BTFSS	SYSDIVMULTB,0
	GOTO	ENDIF56
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	MOVF	SYSDIVMULTA,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTA_H,W
	ADDWFC	SYSDIVMULTX_H,F
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
GLOBAL	ENDIF56
ENDIF56:
;set STATUS.C OFF
	BCF	STATUS,0
;rotate SysDivMultB right
	RRF	SYSDIVMULTB_H,F
	RRF	SYSDIVMULTB,F
;set STATUS.C off
	BCF	STATUS,0
;rotate SysDivMultA left
	RLF	SYSDIVMULTA,F
	RLF	SYSDIVMULTA_H,F
;if SysDivMultB > 0 then goto MUL16LOOP
	MOVF	SYSDIVMULTB,W
	MOVWF	SYSWORDTEMPB
	MOVF	SYSDIVMULTB_H,W
	MOVWF	SYSWORDTEMPB_H
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
;if SysDivMultB > 0 then goto MUL16LOOP
	GOTO	MUL16LOOP
;if SysDivMultB > 0 then goto MUL16LOOP
;SysWordTempX = SysDivMultX
	MOVF	SYSDIVMULTX,W
	MOVWF	SYSWORDTEMPX
	MOVF	SYSDIVMULTX_H,W
	MOVWF	SYSWORDTEMPX_H
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2682)
GLOBAL	SYSMULTSUB32
SYSMULTSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;Can't use normal SysDivMult variables for 32 bit, they overlap with
;SysLongTemp variables
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	MOVF	SYSLONGTEMPA,W
	BANKSEL	SYSLONGDIVMULTA
	MOVWF	SYSLONGDIVMULTA
	MOVF	SYSLONGTEMPA_H,W
	MOVWF	SYSLONGDIVMULTA_H
	MOVF	SYSLONGTEMPA_U,W
	MOVWF	SYSLONGDIVMULTA_U
	MOVF	SYSLONGTEMPA_E,W
	MOVWF	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	MOVF	SYSLONGTEMPB,W
	MOVWF	SYSLONGDIVMULTB
	MOVF	SYSLONGTEMPB_H,W
	MOVWF	SYSLONGDIVMULTB_H
	MOVF	SYSLONGTEMPB_U,W
	MOVWF	SYSLONGDIVMULTB_U
	MOVF	SYSLONGTEMPB_E,W
	MOVWF	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	CLRF	SYSLONGDIVMULTX
	CLRF	SYSLONGDIVMULTX_H
	CLRF	SYSLONGDIVMULTX_U
	CLRF	SYSLONGDIVMULTX_E
GLOBAL	MUL32LOOP
MUL32LOOP:
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	BANKSEL	SYSLONGDIVMULTB
	BTFSS	SYSLONGDIVMULTB,0
	GOTO	ENDIF61
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	MOVF	SYSLONGDIVMULTA,W
	ADDWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTA_H,W
	ADDWFC	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTA_U,W
	ADDWFC	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTA_E,W
	ADDWFC	SYSLONGDIVMULTX_E,F
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
GLOBAL	ENDIF61
ENDIF61:
;set STATUS.C OFF
	BCF	STATUS,0
;rotate SysLongDivMultB right
	RRF	SYSLONGDIVMULTB_E,F
	RRF	SYSLONGDIVMULTB_U,F
	RRF	SYSLONGDIVMULTB_H,F
	RRF	SYSLONGDIVMULTB,F
;set STATUS.C off
	BCF	STATUS,0
;rotate SysLongDivMultA left
	RLF	SYSLONGDIVMULTA,F
	RLF	SYSLONGDIVMULTA_H,F
	RLF	SYSLONGDIVMULTA_U,F
	RLF	SYSLONGDIVMULTA_E,F
;if SysLongDivMultB > 0 then goto MUL32LOOP
	MOVF	SYSLONGDIVMULTB,W
	MOVWF	SYSLONGTEMPB
	MOVF	SYSLONGDIVMULTB_H,W
	MOVWF	SYSLONGTEMPB_H
	MOVF	SYSLONGDIVMULTB_U,W
	MOVWF	SYSLONGTEMPB_U
	MOVF	SYSLONGDIVMULTB_E,W
	MOVWF	SYSLONGTEMPB_E
	CLRF	SYSLONGTEMPA
	CLRF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	BANKSEL	STATUS
	CALL	SYSCOMPLESSTHAN32
	BTFSC	SYSBYTETEMPX,0
;if SysLongDivMultB > 0 then goto MUL32LOOP
	GOTO	MUL32LOOP
;if SysLongDivMultB > 0 then goto MUL32LOOP
;SysLongTempX = SysLongDivMultX
	BANKSEL	SYSLONGDIVMULTX
	MOVF	SYSLONGDIVMULTX,W
	MOVWF	SYSLONGTEMPX
	MOVF	SYSLONGDIVMULTX_H,W
	MOVWF	SYSLONGTEMPX_H
	MOVF	SYSLONGDIVMULTX_U,W
	MOVWF	SYSLONGTEMPX_U
	MOVF	SYSLONGDIVMULTX_E,W
	MOVWF	SYSLONGTEMPX_E
	BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2663)
GLOBAL	SYSMULTSUBINT
SYSMULTSUBINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	MOVF	SYSINTEGERTEMPA_H,W
	XORWF	SYSINTEGERTEMPB_H,W
	MOVWF	SYSSIGNBYTE
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	BTFSS	SYSINTEGERTEMPA_H,7
	GOTO	ENDIF58
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	COMF	SYSINTEGERTEMPA,F
	COMF	SYSINTEGERTEMPA_H,F
	INCF	SYSINTEGERTEMPA,F
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPA_H,F
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
GLOBAL	ENDIF58
ENDIF58:
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	BTFSS	SYSINTEGERTEMPB_H,7
	GOTO	ENDIF59
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	COMF	SYSINTEGERTEMPB,F
	COMF	SYSINTEGERTEMPB_H,F
	INCF	SYSINTEGERTEMPB,F
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPB_H,F
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
GLOBAL	ENDIF59
ENDIF59:
;Call word multiply routine
;SysMultSub16
	CALL	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	BTFSS	SYSSIGNBYTE,7
	GOTO	ENDIF60
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	COMF	SYSINTEGERTEMPX,F
	COMF	SYSINTEGERTEMPX_H,F
	INCF	SYSINTEGERTEMPX,F
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPX_H,F
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
GLOBAL	ENDIF60
ENDIF60:
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (1571)
GLOBAL	SYSREADSTRING
SYSREADSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;call SysStringTables
	CALL	SYSSTRINGTABLES
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;movwf INDF1
	MOVWF	INDF1
;goto SysStringReadCheck
	GOTO	SYSSTRINGREADCHECK
GLOBAL	SYSREADSTRINGPART
SYSREADSTRINGPART:
;Get length
;call SysStringTables
	CALL	SYSSTRINGTABLES
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;addwf SysStringLength,F
	ADDWF	SYSSTRINGLENGTH,F
;Check length
GLOBAL	SYSSTRINGREADCHECK
SYSSTRINGREADCHECK:
;If length is 0, exit
;movf SysCalcTempA,F
	MOVF	SYSCALCTEMPA,F
;btfsc STATUS,Z
	BTFSC	STATUS,2
;return
	RETURN
;Copy
GLOBAL	SYSSTRINGREAD
SYSSTRINGREAD:
;Get char
;call SysStringTables
	CALL	SYSSTRINGTABLES
;Set char
;addfsr 1,1
	ADDFSR	1,1
;movwf INDF1
	MOVWF	INDF1
;decfsz SysCalcTempA, F
	DECFSZ	SYSCALCTEMPA, F
;goto SysStringRead
	GOTO	SYSSTRINGREAD
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
	RETLW	15
	RETLW	71	;G
	RETLW	114	;R
	RETLW	101	;E
	RETLW	97	;A
	RETLW	116	;T
	RETLW	32	; 
	RETLW	67	;C
	RETLW	111	;O
	RETLW	119	;W
	RETLW	32	; 
	RETLW	66	;B
	RETLW	65	;A
	RETLW	83	;S
	RETLW	73	;I
	RETLW	67	;C


GLOBAL	STRINGTABLE2
STRINGTABLE2:
	RETLW	12
	RETLW	65	;A
	RETLW	110	;N
	RETLW	111	;O
	RETLW	98	;B
	RETLW	105	;I
	RETLW	117	;U
	RETLW	109	;M
	RETLW	32	; 
	RETLW	50	;2
	RETLW	48	;0
	RETLW	50	;2
	RETLW	49	;1


GLOBAL	STRINGTABLE3
STRINGTABLE3:
	RETLW	1
	RETLW	42	;*


GLOBAL	STRINGTABLE4
STRINGTABLE4:
	RETLW	15
	RETLW	86	;V
	RETLW	101	;E
	RETLW	114	;R
	RETLW	115	;S
	RETLW	105	;I
	RETLW	111	;O
	RETLW	110	;N
	RETLW	32	; 
	RETLW	48	;0
	RETLW	46	;.
	RETLW	57	;9
	RETLW	56	;8
	RETLW	46	;.
	RETLW	48	;0
	RETLW	55	;7


GLOBAL	STRINGTABLE5
STRINGTABLE5:
	RETLW	12
	RETLW	76	;L
	RETLW	77	;M
	RETLW	32	; 
	RETLW	71	;G
	RETLW	76	;L
	RETLW	67	;C
	RETLW	68	;D
	RETLW	32	; 
	RETLW	77	;M
	RETLW	79	;O
	RETLW	68	;D
	RETLW	69	;E


GLOBAL	STRINGTABLE7
STRINGTABLE7:
	RETLW	8
	RETLW	80	;P
	RETLW	114	;R
	RETLW	105	;I
	RETLW	110	;N
	RETLW	116	;T
	RETLW	83	;S
	RETLW	116	;T
	RETLW	114	;R


GLOBAL	STRINGTABLE8
STRINGTABLE8:
	RETLW	1
	RETLW	64	;


GLOBAL	STRINGTABLE9
STRINGTABLE9:
	RETLW	3
	RETLW	77	;M
	RETLW	104	;H
	RETLW	122	;Z


GLOBAL	STRINGTABLE10
STRINGTABLE10:
	RETLW	7
	RETLW	68	;D
	RETLW	114	;R
	RETLW	97	;A
	RETLW	119	;W
	RETLW	83	;S
	RETLW	116	;T
	RETLW	114	;R


GLOBAL	STRINGTABLE11
STRINGTABLE11:
	RETLW	4
	RETLW	65	;A
	RETLW	68	;D
	RETLW	67	;C
	RETLW	58	;:


GLOBAL	STRINGTABLE12
STRINGTABLE12:
	RETLW	1
	RETLW	61	; (EQUALS)


GLOBAL	STRINGTABLE59
STRINGTABLE59:
	RETLW	1
	RETLW	32	; 


GLOBAL	STRINGTABLE92
STRINGTABLE92:
	RETLW	0


;********************************************************************************

;SOURCE: GLCD_SSD1306.H (224)
GLOBAL	WRITE_COMMAND_SSD1306
WRITE_COMMAND_SSD1306:
;HI2CStart
	CALL	HI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	CALL	HI2CSEND
;HI2CSend 0x00
	BANKSEL	I2CBYTE
	CLRF	I2CBYTE
	BANKSEL	STATUS
	CALL	HI2CSEND
;HI2CSend SSD1306SendByte
	BANKSEL	SSD1306SENDBYTE
	MOVF	SSD1306SENDBYTE,W
	MOVWF	I2CBYTE
	BANKSEL	STATUS
	CALL	HI2CSEND
;HI2CStop
	GOTO	HI2CSTOP

;********************************************************************************

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
