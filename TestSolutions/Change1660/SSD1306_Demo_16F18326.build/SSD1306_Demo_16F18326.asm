;Program compiled by GCBASIC (2026.10.17 (Windows 64 bit) : Build 1660) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-10-17 CRC170
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : \\192.168.0.104\d\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1660\SSD1306_Demo_16F18326.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : 
;   Output file      : \\192.168.0.104\d\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1660\SSD1306_Demo_16F18326.build\SSD1306_Demo_16F18326.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F18326, r=DEC
 TITLE       "\\192.168.0.104\d\GreatCowBASICGits\Demonstration_Sources.git\TestSolutions\Change1660\SSD1306_Demo_16F18326.gcb"
 SUBTITLE    "10-20-2026 08:31:37"
#include <P16F18326.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _RSTOSC_HFINT32 & _FEXTOSC_OFF
 __CONFIG _CONFIG2, _WDTE_OFF & _MCLRE_OFF
 __CONFIG _CONFIG3, _LVP_OFF & _WRT_OFF
 __CONFIG _CONFIG4, _CPD_OFF & _CP_OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
ADDRESSTYPE                      EQU      32          ; 0x20
ADREADPORT                       EQU      33          ; 0x21
BALLCOL                          EQU      34          ; 0x22
BALLDOWN                         EQU      35          ; 0x23
BALLHALF                         EQU      36          ; 0x24
BALLRIGHT                        EQU      37          ; 0x25
BALLROW                          EQU      38          ; 0x26
BALLTOP                          EQU      39          ; 0x27
BALLWORK                         EQU    9147          ; 0x23BB
BALLX                            EQU      40          ; 0x28
BALLY                            EQU      41          ; 0x29
BSET                             EQU      42          ; 0x2A
BX                               EQU      43          ; 0x2B
BY                               EQU      44          ; 0x2C
CHARCODE                         EQU      45          ; 0x2D
CHARCOL                          EQU      46          ; 0x2E
CHARCOL_H                        EQU      47          ; 0x2F
CHARLOCX                         EQU      48          ; 0x30
CHARLOCX_H                       EQU      49          ; 0x31
CHARLOCY                         EQU      50          ; 0x32
CHARLOCY_H                       EQU      51          ; 0x33
COLSPERFONT                      EQU      52          ; 0x34
CURRCHARCOL                      EQU      53          ; 0x35
CURRCHARROW                      EQU      54          ; 0x36
CURRCHARVAL                      EQU      55          ; 0x37
DBX                              EQU      56          ; 0x38
DBY                              EQU      57          ; 0x39
DDF_X                            EQU      58          ; 0x3A
DDF_X_H                          EQU      59          ; 0x3B
DDF_Y                            EQU      60          ; 0x3C
DDF_Y_H                          EQU      61          ; 0x3D
DELAYTEMP                        EQU     112          ; 0x70 (SA)
DELAYTEMP2                       EQU     113          ; 0x71 (SA)
DIGITCHAR                        EQU      62          ; 0x3E
DIGITIN                          EQU      63          ; 0x3F
DIGITIN_H                        EQU      64          ; 0x40
DIGITLEAD                        EQU      65          ; 0x41
DIGITPLACE                       EQU      66          ; 0x42
DIGITVALUE                       EQU      67          ; 0x43
DIGITVALUE_H                     EQU      68          ; 0x44
DIGITX                           EQU      69          ; 0x45
DIGITX_H                         EQU      70          ; 0x46
DIGITY                           EQU      71          ; 0x47
DIGITY_H                         EQU      72          ; 0x48
DIM_STATE                        EQU      73          ; 0x49
DRAWMS                           EQU      74          ; 0x4A
DRAWMS_H                         EQU      75          ; 0x4B
DXOFFSET01                       EQU      76          ; 0x4C
DXOFFSET01_H                     EQU      77          ; 0x4D
DXOFFSET02                       EQU      78          ; 0x4E
DXOFFSET02_H                     EQU      79          ; 0x4F
DXOFFSET12                       EQU      80          ; 0x50
DXOFFSET12_H                     EQU      81          ; 0x51
DYOFFSET01                       EQU      82          ; 0x52
DYOFFSET01_H                     EQU      83          ; 0x53
DYOFFSET02                       EQU      84          ; 0x54
DYOFFSET02_H                     EQU      85          ; 0x55
DYOFFSET12                       EQU      86          ; 0x56
DYOFFSET12_H                     EQU      87          ; 0x57
FF                               EQU      88          ; 0x58
FF_H                             EQU      89          ; 0x59
FILLCIRCLEXX                     EQU      90          ; 0x5A
FILLCIRCLEYY                     EQU      91          ; 0x5B
FILLED_ELLIPSE                   EQU      92          ; 0x5C
FPSCALC                          EQU      93          ; 0x5D
FPSCALC_E                        EQU      96          ; 0x60
FPSCALC_H                        EQU      94          ; 0x5E
FPSCALC_U                        EQU      95          ; 0x5F
FPSSHOWN                         EQU      97          ; 0x61
FPSSHOWN_H                       EQU      98          ; 0x62
FRAMESSEC                        EQU      99          ; 0x63
FRAMESSEC_H                      EQU     100          ; 0x64
GLCDBACKGROUND                   EQU     101          ; 0x65
GLCDBACKGROUND_H                 EQU     102          ; 0x66
GLCDBITNO                        EQU     103          ; 0x67
GLCDCHANGE                       EQU     104          ; 0x68
GLCDCOLOUR                       EQU     105          ; 0x69
GLCDCOLOUR_H                     EQU     106          ; 0x6A
GLCDDATATEMP                     EQU     107          ; 0x6B
GLCDFNTDEFAULT                   EQU     108          ; 0x6C
GLCDFNTDEFAULTHEIGHT             EQU     109          ; 0x6D
GLCDFNTDEFAULTSIZE               EQU     110          ; 0x6E
GLCDFONTWIDTH                    EQU     111          ; 0x6F
GLCDFOREGROUND                   EQU     160          ; 0xA0
GLCDFOREGROUND_H                 EQU     161          ; 0xA1
GLCDPRINTLEN                     EQU     162          ; 0xA2
GLCDPRINTLOC                     EQU     163          ; 0xA3
GLCDPRINTLOC_H                   EQU     164          ; 0xA4
GLCDPRINT_STRING_COUNTER         EQU     165          ; 0xA5
GLCDTEMP                         EQU     166          ; 0xA6
GLCDX                            EQU     167          ; 0xA7
GLCDY                            EQU     168          ; 0xA8
GLCD_AA                          EQU     169          ; 0xA9
GLCD_AA_H                        EQU     170          ; 0xAA
GLCD_BB                          EQU     171          ; 0xAB
GLCD_BB_H                        EQU     172          ; 0xAC
GLCD_EX2                         EQU     173          ; 0xAD
GLCD_EX2_E                       EQU     176          ; 0xB0
GLCD_EX2_H                       EQU     174          ; 0xAE
GLCD_EX2_U                       EQU     175          ; 0xAF
GLCD_EY2                         EQU     177          ; 0xB1
GLCD_EY2_E                       EQU     180          ; 0xB4
GLCD_EY2_H                       EQU     178          ; 0xB2
GLCD_EY2_U                       EQU     179          ; 0xB3
GLCD_FX2                         EQU     181          ; 0xB5
GLCD_FX2_E                       EQU     184          ; 0xB8
GLCD_FX2_H                       EQU     182          ; 0xB6
GLCD_FX2_U                       EQU     183          ; 0xB7
GLCD_FY2                         EQU     185          ; 0xB9
GLCD_FY2_E                       EQU     188          ; 0xBC
GLCD_FY2_H                       EQU     186          ; 0xBA
GLCD_FY2_U                       EQU     187          ; 0xBB
GLCD_LAST                        EQU     189          ; 0xBD
GLCD_LAST_H                      EQU     190          ; 0xBE
GLCD_PP                          EQU     191          ; 0xBF
GLCD_PP_E                        EQU     194          ; 0xC2
GLCD_PP_H                        EQU     192          ; 0xC0
GLCD_PP_TEMP                     EQU     195          ; 0xC3
GLCD_PP_TEMP_E                   EQU     198          ; 0xC6
GLCD_PP_TEMP_H                   EQU     196          ; 0xC4
GLCD_PP_TEMP_U                   EQU     197          ; 0xC5
GLCD_PP_U                        EQU     193          ; 0xC1
GLCD_PX                          EQU     199          ; 0xC7
GLCD_PX_E                        EQU     202          ; 0xCA
GLCD_PX_H                        EQU     200          ; 0xC8
GLCD_PX_U                        EQU     201          ; 0xC9
GLCD_PY                          EQU     203          ; 0xCB
GLCD_PY_E                        EQU     206          ; 0xCE
GLCD_PY_H                        EQU     204          ; 0xCC
GLCD_PY_U                        EQU     205          ; 0xCD
GLCD_RX2                         EQU     207          ; 0xCF
GLCD_RX2_H                       EQU     208          ; 0xD0
GLCD_RY2                         EQU     209          ; 0xD1
GLCD_RY2_H                       EQU     210          ; 0xD2
GLCD_SA                          EQU     211          ; 0xD3
GLCD_SA_H                        EQU     212          ; 0xD4
GLCD_SB                          EQU     213          ; 0xD5
GLCD_SB_H                        EQU     214          ; 0xD6
GLCD_SSD1306_CONTRAST            EQU     215          ; 0xD7
GLCD_XX                          EQU     216          ; 0xD8
GLCD_XX_H                        EQU     217          ; 0xD9
GLCD_Y                           EQU     218          ; 0xDA
GLCD_YORDINATE                   EQU     220          ; 0xDC
GLCD_YORDINATE_H                 EQU     221          ; 0xDD
GLCD_YY                          EQU     222          ; 0xDE
GLCD_YY1                         EQU     224          ; 0xE0
GLCD_YY_H                        EQU     223          ; 0xDF
GLCD_Y_H                         EQU     219          ; 0xDB
HI2CACKPOLLSTATE                 EQU     225          ; 0xE1
HI2CCURRENTMODE                  EQU     226          ; 0xE2
HI2CWAITMSSPTIMEOUT              EQU     227          ; 0xE3
HLCOLOUR                         EQU     228          ; 0xE4
HLCOLOUR_H                       EQU     229          ; 0xE5
HLX1                             EQU     230          ; 0xE6
HLX1_H                           EQU     231          ; 0xE7
HLX2                             EQU     232          ; 0xE8
HLX2_H                           EQU     233          ; 0xE9
HLY                              EQU     234          ; 0xEA
HLY_H                            EQU     235          ; 0xEB
I2CBYTE                          EQU     236          ; 0xEC
INXRADIUS                        EQU     237          ; 0xED
INXRADIUS_H                      EQU     238          ; 0xEE
INYRADIUS                        EQU     288          ; 0x120
INYRADIUS_H                      EQU     289          ; 0x121
LCDVALUE                         EQU     290          ; 0x122
LCDVALUE_E                       EQU     293          ; 0x125
LCDVALUE_H                       EQU     291          ; 0x123
LCDVALUE_U                       EQU     292          ; 0x124
LINECOLOUR                       EQU     294          ; 0x126
LINECOLOUR_E                     EQU     297          ; 0x129
LINECOLOUR_H                     EQU     295          ; 0x127
LINECOLOUR_U                     EQU     296          ; 0x128
LINEX1                           EQU     298          ; 0x12A
LINEX1_H                         EQU     299          ; 0x12B
LINEX2                           EQU     300          ; 0x12C
LINEX2_H                         EQU     301          ; 0x12D
LINEY1                           EQU     302          ; 0x12E
LINEY1_H                         EQU     303          ; 0x12F
LINEY2                           EQU     304          ; 0x130
LINEY2_H                         EQU     305          ; 0x131
LOCALCHARCODE                    EQU     306          ; 0x132
LOCALCHARCODE_H                  EQU     307          ; 0x133
LOCX                             EQU     239          ; 0xEF
LOCY                             EQU     308          ; 0x134
NX                               EQU     309          ; 0x135
NY                               EQU     310          ; 0x136
OLDGLCDFONTWIDTH                 EQU     311          ; 0x137
OLDX                             EQU     312          ; 0x138
OLDY                             EQU     313          ; 0x139
OX                               EQU     314          ; 0x13A
OY                               EQU     315          ; 0x13B
PARTMS                           EQU     316          ; 0x13C
PARTMS_H                         EQU     317          ; 0x13D
PBCOL                            EQU     318          ; 0x13E
PBMASK                           EQU     319          ; 0x13F
PBPAGE                           EQU     320          ; 0x140
PBVALUE                          EQU     321          ; 0x141
POSCHARX                         EQU     322          ; 0x142
POSCHARX_H                       EQU     323          ; 0x143
POSCHARY                         EQU     324          ; 0x144
POTBAR                           EQU     325          ; 0x145
POTBAR_H                         EQU     326          ; 0x146
POTNOW                           EQU     327          ; 0x147
POTNOW_H                         EQU     328          ; 0x148
POTSUM                           EQU     329          ; 0x149
POTSUM_H                         EQU     330          ; 0x14A
PRINTLOCX                        EQU     331          ; 0x14B
PRINTLOCX_H                      EQU     332          ; 0x14C
PRINTLOCY                        EQU     333          ; 0x14D
PRINTLOCY_H                      EQU     334          ; 0x14E
RADIUSERR                        EQU     335          ; 0x14F
RADIUSERR_H                      EQU     336          ; 0x150
READAD10                         EQU     337          ; 0x151
READAD10_H                       EQU     338          ; 0x152
READPOTAVERAGE                   EQU     339          ; 0x153
READPOTAVERAGE_H                 EQU     340          ; 0x154
READPOTGLCD                      EQU     341          ; 0x155
READPOTGLCD_H                    EQU     342          ; 0x156
REGBIT                           EQU     343          ; 0x157
REGBUFFER                        EQU     344          ; 0x158
REGBUFFER_H                      EQU     345          ; 0x159
REGFIRST                         EQU     346          ; 0x15A
REGINDEX                         EQU     347          ; 0x15B
REGINDEX_H                       EQU     348          ; 0x15C
REGLAST                          EQU     349          ; 0x15D
REGP1                            EQU     350          ; 0x15E
REGP2                            EQU     351          ; 0x15F
REGPAGE                          EQU     352          ; 0x160
REGW                             EQU     353          ; 0x161
REGX1                            EQU     354          ; 0x162
REGX2                            EQU     355          ; 0x163
REGY                             EQU     356          ; 0x164
RMPAGE                           EQU     357          ; 0x165
RMY1                             EQU     358          ; 0x166
RMY2                             EQU     359          ; 0x167
ROWSPERFONT                      EQU     360          ; 0x168
RPCOL1                           EQU     361          ; 0x169
RPCOL2                           EQU     362          ; 0x16A
RPMASK                           EQU     363          ; 0x16B
RPPAGE                           EQU     364          ; 0x16C
RPVALUE                          EQU     365          ; 0x16D
SCREEN                           EQU     366          ; 0x16E
SCREENTICKS                      EQU     416          ; 0x1A0
SCREENTICKS_H                    EQU     417          ; 0x1A1
SHOWNADC                         EQU     418          ; 0x1A2
SHOWNADC_H                       EQU     419          ; 0x1A3
SSD1306SENDBYTE                  EQU     367          ; 0x16F
SSD1306_BOXTEMP                  EQU     420          ; 0x1A4
SSD1306_BOXTEMP_H                EQU     421          ; 0x1A5
SSD1306_BUFFERALIAS              EQU    9199          ; 0x23EF
SSD1306_BUFFERLOCATIONCALC       EQU     422          ; 0x1A6
SSD1306_BUFFERLOCATIONCALC_H     EQU     423          ; 0x1A7
SSD1306_FBCOL1                   EQU     424          ; 0x1A8
SSD1306_FBCOL2                   EQU     425          ; 0x1A9
SSD1306_FBLAST                   EQU     426          ; 0x1AA
SSD1306_FBMASK                   EQU     427          ; 0x1AB
SSD1306_FBPAGE                   EQU     428          ; 0x1AC
SSD1306_FBVALUE                  EQU     429          ; 0x1AD
SSD1306_HLCOL1                   EQU     430          ; 0x1AE
SSD1306_HLCOL2                   EQU     431          ; 0x1AF
SSD1306_HLMASK                   EQU     432          ; 0x1B0
SSD1306_HLPAGE                   EQU     433          ; 0x1B1
SSD1306_HLROW                    EQU     434          ; 0x1B2
SSD1306_HLVALUE                  EQU     435          ; 0x1B3
SSD1306_LINEDIFFX                EQU     436          ; 0x1B4
SSD1306_LINEDIFFX_H              EQU     437          ; 0x1B5
SSD1306_LINEDIFFX_X2             EQU     438          ; 0x1B6
SSD1306_LINEDIFFX_X2_H           EQU     439          ; 0x1B7
SSD1306_LINEDIFFY                EQU     440          ; 0x1B8
SSD1306_LINEDIFFY_H              EQU     441          ; 0x1B9
SSD1306_LINEDIFFY_X2             EQU     442          ; 0x1BA
SSD1306_LINEDIFFY_X2_H           EQU     443          ; 0x1BB
SSD1306_LINEERR                  EQU     444          ; 0x1BC
SSD1306_LINEERR_H                EQU     445          ; 0x1BD
SSD1306_LINESTEPX                EQU     446          ; 0x1BE
SSD1306_LINESTEPX_H              EQU     447          ; 0x1BF
SSD1306_LINESTEPY                EQU     448          ; 0x1C0
SSD1306_LINESTEPY_H              EQU     449          ; 0x1C1
SSD1306_PBOLD                    EQU     450          ; 0x1C2
SSD1306_RMBITS                   EQU     451          ; 0x1C3
SSD1306_RMTOP                    EQU     452          ; 0x1C4
SSD1306_ROWMASK                  EQU     453          ; 0x1C5
SSD1306_RPANYCHANGED             EQU     454          ; 0x1C6
SSD1306_RPCOL                    EQU     455          ; 0x1C7
SSD1306_RPNEW                    EQU     456          ; 0x1C8
SSD1306_RPOLD                    EQU     457          ; 0x1C9
SSD1306_VLCOL                    EQU     458          ; 0x1CA
SSD1306_VLLAST                   EQU     459          ; 0x1CB
SSD1306_VLMASK                   EQU     460          ; 0x1CC
SSD1306_VLPAGE                   EQU     461          ; 0x1CD
SSD1306_VLR1                     EQU     462          ; 0x1CE
SSD1306_VLR2                     EQU     463          ; 0x1CF
SSD1306_VLVALUE                  EQU     464          ; 0x1D0
STRINGPOINTER                    EQU     465          ; 0x1D1
SWITCHPRESSED                    EQU     466          ; 0x1D2
SWITCHWAIT                       EQU     467          ; 0x1D3
SYSARRAYTEMP1                    EQU     468          ; 0x1D4
SYSARRAYTEMP2                    EQU     469          ; 0x1D5
SYSBITVAR0                       EQU     470          ; 0x1D6
SYSBYTETEMPA                     EQU     117          ; 0x75 (SA)
SYSBYTETEMPB                     EQU     121          ; 0x79 (SA)
SYSBYTETEMPX                     EQU     112          ; 0x70 (SA)
SYSCALCTEMPA                     EQU     117          ; 0x75 (SA)
SYSCALCTEMPA_E                   EQU     120          ; 0x78 (SA)
SYSCALCTEMPA_H                   EQU     118          ; 0x76 (SA)
SYSCALCTEMPA_U                   EQU     119          ; 0x77 (SA)
SYSCALCTEMPB                     EQU     121          ; 0x79 (SA)
SYSCALCTEMPB_H                   EQU     122          ; 0x7A (SA)
SYSCALCTEMPX                     EQU     112          ; 0x70 (SA)
SYSCALCTEMPX_H                   EQU     113          ; 0x71 (SA)
SYSDIVLOOP                       EQU     116          ; 0x74 (SA)
SYSDIVMULTA                      EQU     119          ; 0x77 (SA)
SYSDIVMULTA_H                    EQU     120          ; 0x78 (SA)
SYSDIVMULTB                      EQU     123          ; 0x7B (SA)
SYSDIVMULTB_H                    EQU     124          ; 0x7C (SA)
SYSDIVMULTX                      EQU     114          ; 0x72 (SA)
SYSDIVMULTX_H                    EQU     115          ; 0x73 (SA)
SYSFORLOOPABSVALUE17             EQU     471          ; 0x1D7
SYSFORLOOPABSVALUE17_H           EQU     472          ; 0x1D8
SYSFORLOOPSTEP16                 EQU     473          ; 0x1D9
SYSFORLOOPSTEP16_H               EQU     474          ; 0x1DA
SYSINTEGERTEMPA                  EQU     117          ; 0x75 (SA)
SYSINTEGERTEMPA_H                EQU     118          ; 0x76 (SA)
SYSINTEGERTEMPB                  EQU     121          ; 0x79 (SA)
SYSINTEGERTEMPB_H                EQU     122          ; 0x7A (SA)
SYSINTEGERTEMPX                  EQU     112          ; 0x70 (SA)
SYSINTEGERTEMPX_H                EQU     113          ; 0x71 (SA)
SYSLCDPRINTDATAHANDLER           EQU     475          ; 0x1DB
SYSLCDPRINTDATAHANDLER_H         EQU     476          ; 0x1DC
SYSLONGDIVMULTA                  EQU     477          ; 0x1DD
SYSLONGDIVMULTA_E                EQU     480          ; 0x1E0
SYSLONGDIVMULTA_H                EQU     478          ; 0x1DE
SYSLONGDIVMULTA_U                EQU     479          ; 0x1DF
SYSLONGDIVMULTB                  EQU     481          ; 0x1E1
SYSLONGDIVMULTB_E                EQU     484          ; 0x1E4
SYSLONGDIVMULTB_H                EQU     482          ; 0x1E2
SYSLONGDIVMULTB_U                EQU     483          ; 0x1E3
SYSLONGDIVMULTX                  EQU     485          ; 0x1E5
SYSLONGDIVMULTX_E                EQU     488          ; 0x1E8
SYSLONGDIVMULTX_H                EQU     486          ; 0x1E6
SYSLONGDIVMULTX_U                EQU     487          ; 0x1E7
SYSLONGTEMPA                     EQU     117          ; 0x75 (SA)
SYSLONGTEMPA_E                   EQU     120          ; 0x78 (SA)
SYSLONGTEMPA_H                   EQU     118          ; 0x76 (SA)
SYSLONGTEMPA_U                   EQU     119          ; 0x77 (SA)
SYSLONGTEMPB                     EQU     121          ; 0x79 (SA)
SYSLONGTEMPB_E                   EQU     124          ; 0x7C (SA)
SYSLONGTEMPB_H                   EQU     122          ; 0x7A (SA)
SYSLONGTEMPB_U                   EQU     123          ; 0x7B (SA)
SYSLONGTEMPX                     EQU     112          ; 0x70 (SA)
SYSLONGTEMPX_E                   EQU     115          ; 0x73 (SA)
SYSLONGTEMPX_H                   EQU     113          ; 0x71 (SA)
SYSLONGTEMPX_U                   EQU     114          ; 0x72 (SA)
SYSPRINTBUFFER                   EQU    9136          ; 0x23B0
SYSPRINTBUFFLEN                  EQU     489          ; 0x1E9
SYSREPEATTEMP1                   EQU     490          ; 0x1EA
SYSREPEATTEMP11                  EQU     491          ; 0x1EB
SYSREPEATTEMP13                  EQU     492          ; 0x1EC
SYSREPEATTEMP14                  EQU     493          ; 0x1ED
SYSREPEATTEMP15                  EQU     494          ; 0x1EE
SYSREPEATTEMP2                   EQU     495          ; 0x1EF
SYSREPEATTEMP3                   EQU     544          ; 0x220
SYSREPEATTEMP5                   EQU     545          ; 0x221
SYSREPEATTEMP6                   EQU     546          ; 0x222
SYSREPEATTEMP9                   EQU     547          ; 0x223
SYSSIGNBYTE                      EQU     125          ; 0x7D (SA)
SYSSTRINGA                       EQU     119          ; 0x77 (SA)
SYSSTRINGA_H                     EQU     120          ; 0x78 (SA)
SYSTEMP1                         EQU     548          ; 0x224
SYSTEMP1_E                       EQU     551          ; 0x227
SYSTEMP1_H                       EQU     549          ; 0x225
SYSTEMP1_U                       EQU     550          ; 0x226
SYSTEMP2                         EQU     552          ; 0x228
SYSTEMP2_H                       EQU     553          ; 0x229
SYSTEMP3                         EQU     554          ; 0x22A
SYSTITLETEXTHANDLER              EQU     555          ; 0x22B
SYSTITLETEXTHANDLER_H            EQU     556          ; 0x22C
SYSWAITTEMP10US                  EQU     117          ; 0x75 (SA)
SYSWAITTEMPMS                    EQU     114          ; 0x72 (SA)
SYSWAITTEMPMS_H                  EQU     115          ; 0x73 (SA)
SYSWAITTEMPUS                    EQU     117          ; 0x75 (SA)
SYSWAITTEMPUS_H                  EQU     118          ; 0x76 (SA)
SYSWORDTEMPA                     EQU     117          ; 0x75 (SA)
SYSWORDTEMPA_H                   EQU     118          ; 0x76 (SA)
SYSWORDTEMPB                     EQU     121          ; 0x79 (SA)
SYSWORDTEMPB_H                   EQU     122          ; 0x7A (SA)
SYSWORDTEMPX                     EQU     112          ; 0x70 (SA)
SYSWORDTEMPX_H                   EQU     113          ; 0x71 (SA)
TICKDELTA                        EQU     557          ; 0x22D
TICKDELTA_H                      EQU     558          ; 0x22E
TICKLAST                         EQU     559          ; 0x22F
TICKLAST_H                       EQU     560          ; 0x230
TICKNOW                          EQU     561          ; 0x231
TICKNOW_H                        EQU     562          ; 0x232
TICKSSEC                         EQU     563          ; 0x233
TICKSSEC_E                       EQU     566          ; 0x236
TICKSSEC_H                       EQU     564          ; 0x234
TICKSSEC_U                       EQU     565          ; 0x235
TICKSTOTAL                       EQU     567          ; 0x237
TICKSTOTAL_E                     EQU     570          ; 0x23A
TICKSTOTAL_H                     EQU     568          ; 0x238
TICKSTOTAL_U                     EQU     569          ; 0x239
TIMEMS                           EQU     571          ; 0x23B
TIMEMS_H                         EQU     572          ; 0x23C
TMRNUMBER                        EQU     573          ; 0x23D
TMRPOST                          EQU     574          ; 0x23E
TMRPRES                          EQU     575          ; 0x23F
TMRSOURCE                        EQU     576          ; 0x240
VLCOLOUR                         EQU     577          ; 0x241
VLCOLOUR_H                       EQU     578          ; 0x242
VLX                              EQU     579          ; 0x243
VLX_H                            EQU     580          ; 0x244
VLY1                             EQU     581          ; 0x245
VLY1_H                           EQU     582          ; 0x246
VLY2                             EQU     583          ; 0x247
VLY2_H                           EQU     584          ; 0x248
WAITPART                         EQU     585          ; 0x249
XOFFSET                          EQU     586          ; 0x24A
XOFFSET2                         EQU     588          ; 0x24C
XOFFSET2_H                       EQU     589          ; 0x24D
XOFFSET3                         EQU     590          ; 0x24E
XOFFSET3_H                       EQU     591          ; 0x24F
XOFFSET_H                        EQU     587          ; 0x24B
XRADIUS                          EQU     592          ; 0x250
XRADIUS_H                        EQU     593          ; 0x251
YCALC1                           EQU     594          ; 0x252
YCALC1_H                         EQU     595          ; 0x253
YCALC2                           EQU     596          ; 0x254
YCALC2_H                         EQU     597          ; 0x255
YOFFSET                          EQU     598          ; 0x256
YOFFSET2                         EQU     600          ; 0x258
YOFFSET2_H                       EQU     601          ; 0x259
YOFFSET3                         EQU     602          ; 0x25A
YOFFSET3_H                       EQU     603          ; 0x25B
YOFFSET_H                        EQU     599          ; 0x257
YORDINATE                        EQU     604          ; 0x25C

;********************************************************************************

;Alias variables
AFSR0 EQU 4
AFSR0_H EQU 5
SYSREADAD10WORD EQU 337
SYSREADAD10WORD_H EQU 338

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
	call	INITPPS
	call	HI2CINIT
	call	INITGLCD_SSD1306
	pagesel	$

;Start_of_the_main_program
;
;A GLCD demonstration for GCGB and GCB: GCBASIC's GLCD commands on an SSD1306 128 x 64 OLED, on I2C.
;
;Five screens, 4 s each (the switch moves on to the next screen at once):
;1 Text      GLCDPrint at size 1 and 2, a number, inverse text, and the time the screen took to draw
;2 Shapes    Line, Box, FilledBox, Circle, FilledCircle, Triangle, FilledTriangle, Ellipse
;3 Pot       the pot (RA0) as a number and a bar, redrawn only when the value changes
;4 Bounce    a ball bouncing in a box, with frames per second
;5 Display   GLCDSetContrast, GLCDSetDisplayInvertMode / GLCDSetDisplayNormalMode, GLCDRotate (180 degrees)
;
;Connect the SSD1306 to the I2C port: SDA to RC1, SCL to RC0, with pull-up resistors to the supply voltage
;(most SSD1306 modules have them). The I2C address is 0x78 (0x3C as a 7-bit address).
;
;The board: the pot on RA0, the switch on RA2 (low when pressed).
;
;************************************************************************************************************************************************************************************
;
;PIC: 16f18326
;Compiler: GCB
;IDE: GCB@SYN
;
;@author   EvanV
;@licence  GPL
;@version  3.0 (the SSD1306: rotate, invert and normal mode; Timer0 for the 16F18326)
;@date     19/10/2026
;
;----- Configuration
;Chip Settings.
;! Change or delete the PPS section.  YOU NEED A PPS section for PPS PICs.
;Generated by PIC PPS Tool for GCBASIC
;PPS Tool version: 0.0.6.3
;Generated for 16lf18326
;
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;! The switch on RA2: low when pressed (the board sets its level; no weak pull-up). Not RA1: that is the
;! programmer's ICSPCLK pin, which the PICkit holds when it is connected.
;Dir SWITCH In
	banksel	TRISA
	bsf	TRISA,2
;! The board's pot
;Dir POTENTIOMETER In
	bsf	TRISA,0
;! You MUST define Hardware settings for I2C/TWI
;Define I2C settings - CHANGE PORTS if required for your specific device.
;Initialise I2C Master
;I2C pins may need to be input for SSP module
;Dir HI2C_DATA In
	bsf	TRISC,1
;Dir HI2C_CLOCK In
	bsf	TRISC,0
;MASTER
;HI2CMode Master
	movlw	12
	movwf	HI2CCURRENTMODE
	banksel	STATUS
	pagesel	HI2CMODE
	call	HI2CMODE
	pagesel	$
;! The GLCD: an SSD1306 128 x 64 on I2C
;! Timer0, 16 bits: Fosc/4 / 256 = 8 MHz / 256 = 31250 counts a second (up to 2.09 s)
;InitTimer0 Osc, PRE0_256 + TMR0_FOSC4, POST0_1
	movlw	1
	banksel	TMRSOURCE
	movwf	TMRSOURCE
	movlw	72
	movwf	TMRPRES
	clrf	TMRPOST
	banksel	STATUS
	pagesel	INITTIMER0284
	call	INITTIMER0284
	pagesel	$
;StartTimer 0
	banksel	TMRNUMBER
	clrf	TMRNUMBER
	banksel	STATUS
	pagesel	STARTTIMER
	call	STARTTIMER
	pagesel	$
;----- Main body of program commences here *******************************************
;RAM is not cleared at start-up: set every variable before it is used
;Dim Screen As Byte
;Dim PotNow, PotBar, ShownADC As Word
;Dim DigitValue As Word
;Dim DigitChar, DigitPlace, DigitLead As Byte
;Dim ScreenTicks As Word
;Dim BallX, BallY, BallRight, BallDown As Byte
;Dim OldX, OldY, BallRow, BallHalf, BallCol, BallTop As Byte
;Dim BallWork(51)                                ' the region two balls cover: up to 17 columns x 3 pages
;Dim RegX1, RegX2, RegW, RegP1, RegP2, RegPage, RegFirst, RegLast, RegY, RegBit As Byte
;Dim RegIndex, RegBuffer As Word
;Dim FramesSec, FpsShown As Word
;Dim TickNow, TickLast, TickDelta As Word
;Dim TicksSec, TicksTotal, FpsCalc As Long
;Dim DrawMs As Word
;Screen = 1
	movlw	1
	banksel	SCREEN
	movwf	SCREEN
;Do
SysDoLoop_S1
;Select Case Screen
;Case 1: ShowText
SysSelect1Case1
	decf	SCREEN,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;Case 1: ShowText
	banksel	STATUS
	pagesel	SHOWTEXT
	call	SHOWTEXT
	pagesel	$
;Case 2: ShowShapes
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	SCREEN,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;Case 2: ShowShapes
	banksel	STATUS
	pagesel	SHOWSHAPES
	call	SHOWSHAPES
	pagesel	$
;Case 3: ShowPot
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	SCREEN,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;Case 3: ShowPot
	banksel	STATUS
	call	SHOWPOT
;Case 4: ShowBounce
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	SCREEN,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
;Case 4: ShowBounce
	banksel	STATUS
	pagesel	SHOWBOUNCE
	call	SHOWBOUNCE
	pagesel	$
;Case 5: ShowDisplay
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	5
	subwf	SCREEN,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;Case 5: ShowDisplay
	banksel	STATUS
	pagesel	SHOWDISPLAY
	call	SHOWDISPLAY
	pagesel	$
;End Select
SysSelectEnd1
;Screen++
	banksel	SCREEN
	incf	SCREEN,F
;If Screen > 5 Then Screen = 1
	movf	SCREEN,W
	sublw	5
	btfsc	STATUS, C
	goto	ENDIF1
;If Screen > 5 Then Screen = 1
	movlw	1
	movwf	SCREEN
;If Screen > 5 Then Screen = 1
ENDIF1
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;----- Support methods.  Subroutines and Functions
;=============================================================== Screens
;A ball bouncing in a box. Each frame moves the ball in the screen buffer (MoveBall) and sends only the bytes that
;changed, one transaction per page: the ball is never blank, and the I2C carries about 45 bytes a frame instead of
;a cursor and a data transaction for every changed pixel. Frames per second from Timer0 (TICKS_SECOND a second).
;The ball: radius 5, 11 rows; BallHalfWidth is each row's half width (row 1 is the top, y - 5)
;Move the ball from OX, OY to NX, NY in the screen buffer: copy the region both balls cover (columns RegX1..RegX2,
;pages RegP1..RegP2) to BallWork, clear the old ball and set the new one there, then for each page put the bytes
;that changed back in the buffer and send that span in one transaction (SSD1306_SendBufferRun).
;The ball's pixels at BX, BY in BallWork: set (BSet 1) or cleared (BSet 0)
;The bit of a row in its page byte (row And 7, + 1)
;Drawing time: Timer0 from 0
;Milliseconds since TimeStart: counts x 1000 / 31250 = counts x 32 / 1000 (up to 2097 ms)
;Wait SCREEN_MS, or until the switch is pressed
;Wait PartMs; 1 if the switch was pressed meanwhile
;1 when the switch is pressed (debounced, and the release waited for - at most 1 s, so a switch that stays down
;cannot stop the demo), else 0
;The pot, RA0, 10 bits
;A value 0..9999 right aligned in 4 characters at x, y: GLCDDrawChar per digit, leading zeros as
;spaces. Each character is drawn in full (the background too), so it overwrites what was there.
;The pot as the average of 8 readings (sum / 8 by rotates)
;GLCD SSD1306 buffer is 1024bytes
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (4227)
DRAWELLIPSEROUTINE58
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
	banksel	INXRADIUS
	movf	INXRADIUS,W
	movwf	SysWORDTempA
	movf	INXRADIUS_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
;IF Inxradius<2 THEN exit sub
	return
;IF Inxradius<2 THEN exit sub
;IF Inyradius<2 THEN exit sub
	banksel	INYRADIUS
	movf	INYRADIUS,W
	movwf	SysWORDTempA
	movf	INYRADIUS_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
;IF Inyradius<2 THEN exit sub
	return
;IF Inyradius<2 THEN exit sub
;dim GLCD_xx, GLCD_yy, GLCD_rx2, GLCD_ry2 as Word
;dim  GLCD_fx2, GLCD_fy2, GLCD_ex2, GLCD_ey2 as Long
;dim GLCD_px, GLCD_py, GLCD_pp, GLCD_pp_temp as Long
;GLCD_rx2 = Inxradius * Inxradius
	banksel	INXRADIUS
	movf	INXRADIUS,W
	movwf	SysWORDTempA
	movf	INXRADIUS_H,W
	movwf	SysWORDTempA_H
	movf	INXRADIUS,W
	movwf	SysWORDTempB
	movf	INXRADIUS_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSMULTSUB16
	call	SYSMULTSUB16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	GLCD_RX2
	movwf	GLCD_RX2
	movf	SysWORDTempX_H,W
	movwf	GLCD_RX2_H
;GLCD_ry2 = Inyradius * Inyradius
	banksel	INYRADIUS
	movf	INYRADIUS,W
	movwf	SysWORDTempA
	movf	INYRADIUS_H,W
	movwf	SysWORDTempA_H
	movf	INYRADIUS,W
	movwf	SysWORDTempB
	movf	INYRADIUS_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSMULTSUB16
	call	SYSMULTSUB16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	GLCD_RY2
	movwf	GLCD_RY2
	movf	SysWORDTempX_H,W
	movwf	GLCD_RY2_H
;GLCD_fx2 = 4 * GLCD_rx2
;GLCD_fx2 = GLCD_rx2 + GLCD_rx2
	movf	GLCD_RX2,W
	addwf	GLCD_RX2,W
	movwf	GLCD_FX2
	movf	GLCD_RX2_H,W
	addwfc	GLCD_RX2_H,W
	movwf	GLCD_FX2_H
	clrf	GLCD_FX2_U
	btfsc	STATUS,C
	incf	GLCD_FX2_U,F
	clrf	GLCD_FX2_E
;GLCD_fx2 = GLCD_fx2 + GLCD_fx2
	movf	GLCD_FX2,W
	addwf	GLCD_FX2,F
	movf	GLCD_FX2_H,W
	addwfc	GLCD_FX2_H,F
	movf	GLCD_FX2_U,W
	addwfc	GLCD_FX2_U,F
	movf	GLCD_FX2_E,W
	addwfc	GLCD_FX2_E,F
;GLCD_fy2 = 4 * GLCD_ry2
;GLCD_fy2 = GLCD_ry2 + GLCD_ry2
	movf	GLCD_RY2,W
	addwf	GLCD_RY2,W
	movwf	GLCD_FY2
	movf	GLCD_RY2_H,W
	addwfc	GLCD_RY2_H,W
	movwf	GLCD_FY2_H
	clrf	GLCD_FY2_U
	btfsc	STATUS,C
	incf	GLCD_FY2_U,F
	clrf	GLCD_FY2_E
;GLCD_fy2 = GLCD_fy2 + GLCD_fy2
	movf	GLCD_FY2,W
	addwf	GLCD_FY2,F
	movf	GLCD_FY2_H,W
	addwfc	GLCD_FY2_H,F
	movf	GLCD_FY2_U,W
	addwfc	GLCD_FY2_U,F
	movf	GLCD_FY2_E,W
	addwfc	GLCD_FY2_E,F
;GLCD_ex2 = 2 * GLCD_fx2
;GLCD_ex2 = GLCD_fx2 + GLCD_fx2
	movf	GLCD_FX2,W
	addwf	GLCD_FX2,W
	movwf	GLCD_EX2
	movf	GLCD_FX2_H,W
	addwfc	GLCD_FX2_H,W
	movwf	GLCD_EX2_H
	movf	GLCD_FX2_U,W
	addwfc	GLCD_FX2_U,W
	movwf	GLCD_EX2_U
	movf	GLCD_FX2_E,W
	addwfc	GLCD_FX2_E,W
	movwf	GLCD_EX2_E
;GLCD_ey2 = 2 * GLCD_fy2
;GLCD_ey2 = GLCD_fy2 + GLCD_fy2
	movf	GLCD_FY2,W
	addwf	GLCD_FY2,W
	movwf	GLCD_EY2
	movf	GLCD_FY2_H,W
	addwfc	GLCD_FY2_H,W
	movwf	GLCD_EY2_H
	movf	GLCD_FY2_U,W
	addwfc	GLCD_FY2_U,W
	movwf	GLCD_EY2_U
	movf	GLCD_FY2_E,W
	addwfc	GLCD_FY2_E,W
	movwf	GLCD_EY2_E
;GLCD_xx = 0
	clrf	GLCD_XX
	clrf	GLCD_XX_H
;GLCD_yy = Inyradius
	banksel	INYRADIUS
	movf	INYRADIUS,W
	banksel	GLCD_YY
	movwf	GLCD_YY
	banksel	INYRADIUS_H
	movf	INYRADIUS_H,W
	banksel	GLCD_YY_H
	movwf	GLCD_YY_H
;GLCD_px = 0
	clrf	GLCD_PX
	clrf	GLCD_PX_H
	clrf	GLCD_PX_U
	clrf	GLCD_PX_E
;GLCD_py = GLCD_ex2 * GLCD_yy
	movf	GLCD_EX2,W
	movwf	SysLONGTempA
	movf	GLCD_EX2_H,W
	movwf	SysLONGTempA_H
	movf	GLCD_EX2_U,W
	movwf	SysLONGTempA_U
	movf	GLCD_EX2_E,W
	movwf	SysLONGTempA_E
	movf	GLCD_YY,W
	movwf	SysLONGTempB
	movf	GLCD_YY_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSMULTSUB32
	call	SYSMULTSUB32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	GLCD_PY
	movwf	GLCD_PY
	movf	SysLONGTempX_H,W
	movwf	GLCD_PY_H
	movf	SysLONGTempX_U,W
	movwf	GLCD_PY_U
	movf	SysLONGTempX_E,W
	movwf	GLCD_PY_E
;GLCD_pp = 2 + GLCD_fy2 -  GLCD_fx2 * Inyradius + GLCD_rx2
;GLCD_pp_temp = GLCD_fx2 * Inyradius
	movf	GLCD_FX2,W
	movwf	SysLONGTempA
	movf	GLCD_FX2_H,W
	movwf	SysLONGTempA_H
	movf	GLCD_FX2_U,W
	movwf	SysLONGTempA_U
	movf	GLCD_FX2_E,W
	movwf	SysLONGTempA_E
	banksel	INYRADIUS
	movf	INYRADIUS,W
	movwf	SysLONGTempB
	movf	INYRADIUS_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSMULTSUB32
	call	SYSMULTSUB32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	GLCD_PP_TEMP
	movwf	GLCD_PP_TEMP
	movf	SysLONGTempX_H,W
	movwf	GLCD_PP_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	GLCD_PP_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	GLCD_PP_TEMP_E
;GLCD_pp = 2 + GLCD_fy2
	movlw	2
	addwf	GLCD_FY2,W
	movwf	GLCD_PP
	movlw	0
	addwfc	GLCD_FY2_H,W
	movwf	GLCD_PP_H
	movlw	0
	addwfc	GLCD_FY2_U,W
	movwf	GLCD_PP_U
	movlw	0
	addwfc	GLCD_FY2_E,W
	movwf	GLCD_PP_E
;GLCD_pp = GLCD_pp + GLCD_rx2
	movf	GLCD_RX2,W
	addwf	GLCD_PP,F
	movf	GLCD_RX2_H,W
	addwfc	GLCD_PP_H,F
	movlw	0
	addwfc	GLCD_PP_U,F
	movlw	0
	addwfc	GLCD_PP_E,F
;GLCD_pp = GLCD_pp - GLCD_pp_temp
	movf	GLCD_PP_TEMP,W
	subwf	GLCD_PP,F
	movf	GLCD_PP_TEMP_H,W
	subwfb	GLCD_PP_H,F
	movf	GLCD_PP_TEMP_U,W
	subwfb	GLCD_PP_U,F
	movf	GLCD_PP_TEMP_E,W
	subwfb	GLCD_PP_E,F
;IF filled_ellipse = 0 THEN
	banksel	FILLED_ELLIPSE
	movf	FILLED_ELLIPSE,F
	btfss	STATUS, Z
	goto	ELSE62_1
;Draw_Ellipse_Points
	pagesel	DRAW_ELLIPSE_POINTS
	call	DRAW_ELLIPSE_POINTS
	pagesel	$
;ELSE
	goto	ENDIF62
ELSE62_1
;Draw_Filled_Ellipse_Points
	pagesel	DRAW_FILLED_ELLIPSE_POINTS
	call	DRAW_FILLED_ELLIPSE_POINTS
	pagesel	$
;END IF
ENDIF62
;DO WHILE GLCD_px < GLCD_py
SysDoLoop_S9
	banksel	GLCD_PX
	movf	glcd_px,W
	movwf	SysLONGTempA
	movf	glcd_px_H,W
	movwf	SysLONGTempA_H
	movf	glcd_px_U,W
	movwf	SysLONGTempA_U
	movf	glcd_px_E,W
	movwf	SysLONGTempA_E
	movf	glcd_py,W
	movwf	SysLONGTempB
	movf	glcd_py_H,W
	movwf	SysLONGTempB_H
	movf	glcd_py_U,W
	movwf	SysLONGTempB_U
	movf	glcd_py_E,W
	movwf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN32
	call	SYSCOMPLESSTHAN32
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysDoLoop_E9
;GLCD_xx++
	banksel	GLCD_XX
	incf	GLCD_XX,F
	btfsc	STATUS,Z
	incf	GLCD_XX_H,F
;GLCD_px = GLCD_px + GLCD_ey2
	movf	GLCD_EY2,W
	addwf	GLCD_PX,F
	movf	GLCD_EY2_H,W
	addwfc	GLCD_PX_H,F
	movf	GLCD_EY2_U,W
	addwfc	GLCD_PX_U,F
	movf	GLCD_EY2_E,W
	addwfc	GLCD_PX_E,F
;IF GLCD_pp_E.7 = 0 THEN
	btfsc	GLCD_PP_E,7
	goto	ENDIF63
;GLCD_yy--
	movlw	1
	subwf	GLCD_YY,F
	movlw	0
	subwfb	GLCD_YY_H,F
;GLCD_py = GLCD_py - GLCD_ex2
	movf	GLCD_EX2,W
	subwf	GLCD_PY,F
	movf	GLCD_EX2_H,W
	subwfb	GLCD_PY_H,F
	movf	GLCD_EX2_U,W
	subwfb	GLCD_PY_U,F
	movf	GLCD_EX2_E,W
	subwfb	GLCD_PY_E,F
;GLCD_pp = GLCD_pp - GLCD_py
	movf	GLCD_PY,W
	subwf	GLCD_PP,F
	movf	GLCD_PY_H,W
	subwfb	GLCD_PP_H,F
	movf	GLCD_PY_U,W
	subwfb	GLCD_PP_U,F
	movf	GLCD_PY_E,W
	subwfb	GLCD_PP_E,F
;END IF
ENDIF63
;GLCD_pp = GLCD_pp + GLCD_fy2 + GLCD_px
;GLCD_pp = GLCD_pp + GLCD_fy2
	movf	GLCD_FY2,W
	addwf	GLCD_PP,F
	movf	GLCD_FY2_H,W
	addwfc	GLCD_PP_H,F
	movf	GLCD_FY2_U,W
	addwfc	GLCD_PP_U,F
	movf	GLCD_FY2_E,W
	addwfc	GLCD_PP_E,F
;GLCD_pp = GLCD_pp + GLCD_px
	movf	GLCD_PX,W
	addwf	GLCD_PP,F
	movf	GLCD_PX_H,W
	addwfc	GLCD_PP_H,F
	movf	GLCD_PX_U,W
	addwfc	GLCD_PP_U,F
	movf	GLCD_PX_E,W
	addwfc	GLCD_PP_E,F
;IF filled_ellipse = 0 THEN
	banksel	FILLED_ELLIPSE
	movf	FILLED_ELLIPSE,F
	btfss	STATUS, Z
	goto	ELSE64_1
;Draw_Ellipse_Points
	pagesel	DRAW_ELLIPSE_POINTS
	call	DRAW_ELLIPSE_POINTS
	pagesel	$
;ELSE
	goto	ENDIF64
ELSE64_1
;Draw_Filled_Ellipse_Points
	pagesel	DRAW_FILLED_ELLIPSE_POINTS
	call	DRAW_FILLED_ELLIPSE_POINTS
	pagesel	$
;END IF
ENDIF64
;LOOP
	goto	SysDoLoop_S9
SysDoLoop_E9
;GLCD_pp = 2 + GLCD_ry2 * (2 * GLCD_xx + 1) * (2 * GLCD_xx + 1) + GLCD_fx2 * (GLCD_yy - 1) * (GLCD_yy - 1) -  GLCD_fx2 * GLCD_ry2
;change GLCD_xx and GLCD_yy to do calculation
;GLCD_xx = GLCD_xx + GLCD_xx
	banksel	GLCD_XX
	movf	GLCD_XX,W
	addwf	GLCD_XX,F
	movf	GLCD_XX_H,W
	addwfc	GLCD_XX_H,F
;GLCD_xx++
	incf	GLCD_XX,F
	btfsc	STATUS,Z
	incf	GLCD_XX_H,F
;GLCD_yy--
	movlw	1
	subwf	GLCD_YY,F
	movlw	0
	subwfb	GLCD_YY_H,F
;GLCD_pp_temp = GLCD_xx * GLCD_xx
	movf	GLCD_XX,W
	movwf	SysLONGTempA
	movf	GLCD_XX_H,W
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	GLCD_XX,W
	movwf	SysLONGTempB
	movf	GLCD_XX_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSMULTSUB32
	call	SYSMULTSUB32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	GLCD_PP_TEMP
	movwf	GLCD_PP_TEMP
	movf	SysLONGTempX_H,W
	movwf	GLCD_PP_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	GLCD_PP_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	GLCD_PP_TEMP_E
;GLCD_pp_temp = GLCD_ry2 * GLCD_pp_temp
	movf	GLCD_RY2,W
	movwf	SysLONGTempA
	movf	GLCD_RY2_H,W
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	GLCD_PP_TEMP,W
	movwf	SysLONGTempB
	movf	GLCD_PP_TEMP_H,W
	movwf	SysLONGTempB_H
	movf	GLCD_PP_TEMP_U,W
	movwf	SysLONGTempB_U
	movf	GLCD_PP_TEMP_E,W
	movwf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSMULTSUB32
	call	SYSMULTSUB32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	GLCD_PP_TEMP
	movwf	GLCD_PP_TEMP
	movf	SysLONGTempX_H,W
	movwf	GLCD_PP_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	GLCD_PP_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	GLCD_PP_TEMP_E
;GLCD_pp = 2 + GLCD_pp_temp
	movlw	2
	addwf	GLCD_PP_TEMP,W
	movwf	GLCD_PP
	movlw	0
	addwfc	GLCD_PP_TEMP_H,W
	movwf	GLCD_PP_H
	movlw	0
	addwfc	GLCD_PP_TEMP_U,W
	movwf	GLCD_PP_U
	movlw	0
	addwfc	GLCD_PP_TEMP_E,W
	movwf	GLCD_PP_E
;GLCD_pp_temp = GLCD_yy * GLCD_yy
	movf	GLCD_YY,W
	movwf	SysLONGTempA
	movf	GLCD_YY_H,W
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	GLCD_YY,W
	movwf	SysLONGTempB
	movf	GLCD_YY_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSMULTSUB32
	call	SYSMULTSUB32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	GLCD_PP_TEMP
	movwf	GLCD_PP_TEMP
	movf	SysLONGTempX_H,W
	movwf	GLCD_PP_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	GLCD_PP_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	GLCD_PP_TEMP_E
;GLCD_pp_temp = GLCD_fx2 * GLCD_pp_temp
	movf	GLCD_FX2,W
	movwf	SysLONGTempA
	movf	GLCD_FX2_H,W
	movwf	SysLONGTempA_H
	movf	GLCD_FX2_U,W
	movwf	SysLONGTempA_U
	movf	GLCD_FX2_E,W
	movwf	SysLONGTempA_E
	movf	GLCD_PP_TEMP,W
	movwf	SysLONGTempB
	movf	GLCD_PP_TEMP_H,W
	movwf	SysLONGTempB_H
	movf	GLCD_PP_TEMP_U,W
	movwf	SysLONGTempB_U
	movf	GLCD_PP_TEMP_E,W
	movwf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSMULTSUB32
	call	SYSMULTSUB32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	GLCD_PP_TEMP
	movwf	GLCD_PP_TEMP
	movf	SysLONGTempX_H,W
	movwf	GLCD_PP_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	GLCD_PP_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	GLCD_PP_TEMP_E
;GLCD_pp = GLCD_pp + GLCD_pp_temp
	movf	GLCD_PP_TEMP,W
	addwf	GLCD_PP,F
	movf	GLCD_PP_TEMP_H,W
	addwfc	GLCD_PP_H,F
	movf	GLCD_PP_TEMP_U,W
	addwfc	GLCD_PP_U,F
	movf	GLCD_PP_TEMP_E,W
	addwfc	GLCD_PP_E,F
;GLCD_pp_temp = GLCD_fx2 * GLCD_ry2
	movf	GLCD_FX2,W
	movwf	SysLONGTempA
	movf	GLCD_FX2_H,W
	movwf	SysLONGTempA_H
	movf	GLCD_FX2_U,W
	movwf	SysLONGTempA_U
	movf	GLCD_FX2_E,W
	movwf	SysLONGTempA_E
	movf	GLCD_RY2,W
	movwf	SysLONGTempB
	movf	GLCD_RY2_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSMULTSUB32
	call	SYSMULTSUB32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	GLCD_PP_TEMP
	movwf	GLCD_PP_TEMP
	movf	SysLONGTempX_H,W
	movwf	GLCD_PP_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	GLCD_PP_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	GLCD_PP_TEMP_E
;GLCD_pp = GLCD_pp - GLCD_pp_temp
	movf	GLCD_PP_TEMP,W
	subwf	GLCD_PP,F
	movf	GLCD_PP_TEMP_H,W
	subwfb	GLCD_PP_H,F
	movf	GLCD_PP_TEMP_U,W
	subwfb	GLCD_PP_U,F
	movf	GLCD_PP_TEMP_E,W
	subwfb	GLCD_PP_E,F
;restore original GLCD_xx and GLCD_yy values
;GLCD_xx--
	movlw	1
	subwf	GLCD_XX,F
	movlw	0
	subwfb	GLCD_XX_H,F
;GLCD_xx/2
;set C off
	bcf	STATUS,C
;rotate GLCD_xx_H right
	rrf	GLCD_XX_H,F
;rotate GLCD_xx right
	rrf	GLCD_XX_H,F
	rrf	GLCD_XX,F
;GLCD_yy++
	incf	GLCD_YY,F
	btfsc	STATUS,Z
	incf	GLCD_YY_H,F
;DO WHILE GLCD_yy > 0
SysDoLoop_S10
	banksel	GLCD_YY
	movf	glcd_yy,W
	movwf	SysWORDTempB
	movf	glcd_yy_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysDoLoop_E10
;GLCD_yy--
	movlw	1
	banksel	GLCD_YY
	subwf	GLCD_YY,F
	movlw	0
	subwfb	GLCD_YY_H,F
;GLCD_py = GLCD_py - GLCD_ex2
	movf	GLCD_EX2,W
	subwf	GLCD_PY,F
	movf	GLCD_EX2_H,W
	subwfb	GLCD_PY_H,F
	movf	GLCD_EX2_U,W
	subwfb	GLCD_PY_U,F
	movf	GLCD_EX2_E,W
	subwfb	GLCD_PY_E,F
;IF GLCD_pp_E.7 = 1 THEN
	btfss	GLCD_PP_E,7
	goto	ENDIF65
;GLCD_xx++
	incf	GLCD_XX,F
	btfsc	STATUS,Z
	incf	GLCD_XX_H,F
;GLCD_px = GLCD_px + GLCD_ey2
	movf	GLCD_EY2,W
	addwf	GLCD_PX,F
	movf	GLCD_EY2_H,W
	addwfc	GLCD_PX_H,F
	movf	GLCD_EY2_U,W
	addwfc	GLCD_PX_U,F
	movf	GLCD_EY2_E,W
	addwfc	GLCD_PX_E,F
;GLCD_pp = GLCD_pp + GLCD_px
	movf	GLCD_PX,W
	addwf	GLCD_PP,F
	movf	GLCD_PX_H,W
	addwfc	GLCD_PP_H,F
	movf	GLCD_PX_U,W
	addwfc	GLCD_PP_U,F
	movf	GLCD_PX_E,W
	addwfc	GLCD_PP_E,F
;END IF
ENDIF65
;GLCD_pp = GLCD_pp + GLCD_fx2 - GLCD_py
;GLCD_pp = GLCD_pp + GLCD_fx2
	movf	GLCD_FX2,W
	addwf	GLCD_PP,F
	movf	GLCD_FX2_H,W
	addwfc	GLCD_PP_H,F
	movf	GLCD_FX2_U,W
	addwfc	GLCD_PP_U,F
	movf	GLCD_FX2_E,W
	addwfc	GLCD_PP_E,F
;GLCD_pp = GLCD_pp - GLCD_py
	movf	GLCD_PY,W
	subwf	GLCD_PP,F
	movf	GLCD_PY_H,W
	subwfb	GLCD_PP_H,F
	movf	GLCD_PY_U,W
	subwfb	GLCD_PP_U,F
	movf	GLCD_PY_E,W
	subwfb	GLCD_PP_E,F
;IF filled_ellipse = 0 THEN
	banksel	FILLED_ELLIPSE
	movf	FILLED_ELLIPSE,F
	btfss	STATUS, Z
	goto	ELSE66_1
;Draw_Ellipse_Points
	pagesel	DRAW_ELLIPSE_POINTS
	call	DRAW_ELLIPSE_POINTS
	pagesel	$
;ELSE
	goto	ENDIF66
ELSE66_1
;Draw_Filled_Ellipse_Points
	pagesel	DRAW_FILLED_ELLIPSE_POINTS
	call	DRAW_FILLED_ELLIPSE_POINTS
	pagesel	$
;END IF
ENDIF66
;LOOP
	goto	SysDoLoop_S10
SysDoLoop_E10
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:WORD:word:, Source: glcd.h (4951)
FILLEDTRIANGLE72
;dim  GLCD_aa, GLCD_bb, GLCD_last as word
;Sort coordinates by Y order (yoffset3 >= yoffset2 >= yoffset)
;if (yoffset > yoffset2) then
	banksel	YOFFSET
	movf	YOFFSET,W
	movwf	SysWORDTempB
	movf	YOFFSET_H,W
	movwf	SysWORDTempB_H
	movf	YOFFSET2,W
	movwf	SysWORDTempA
	movf	YOFFSET2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF69
;swap(yoffset, yoffset2)
	banksel	YOFFSET
	movf	YOFFSET,W
	movwf	SYSCALCTEMPA
	movf	YOFFSET_H,W
	movwf	SYSCALCTEMPA_H
	movf	YOFFSET2,W
	movwf	SYSCALCTEMPB
	movf	YOFFSET2_H,W
	movwf	SYSCALCTEMPB_H
	banksel	STATUS
	pagesel	SWAP166
	call	SWAP166
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	YOFFSET
	movwf	YOFFSET
	movf	SYSCALCTEMPA_H,W
	movwf	YOFFSET_H
	movf	SYSCALCTEMPB,W
	movwf	YOFFSET2
	movf	SYSCALCTEMPB_H,W
	movwf	YOFFSET2_H
;swap(xoffset, xoffset2)
	movf	XOFFSET,W
	movwf	SYSCALCTEMPA
	movf	XOFFSET_H,W
	movwf	SYSCALCTEMPA_H
	movf	XOFFSET2,W
	movwf	SYSCALCTEMPB
	movf	XOFFSET2_H,W
	movwf	SYSCALCTEMPB_H
	banksel	STATUS
	pagesel	SWAP166
	call	SWAP166
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	XOFFSET
	movwf	XOFFSET
	movf	SYSCALCTEMPA_H,W
	movwf	XOFFSET_H
	movf	SYSCALCTEMPB,W
	movwf	XOFFSET2
	movf	SYSCALCTEMPB_H,W
	movwf	XOFFSET2_H
;end if
ENDIF69
;if (yoffset2 > yoffset3) then
	banksel	YOFFSET2
	movf	YOFFSET2,W
	movwf	SysWORDTempB
	movf	YOFFSET2_H,W
	movwf	SysWORDTempB_H
	movf	YOFFSET3,W
	movwf	SysWORDTempA
	movf	YOFFSET3_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF70
;swap(yoffset3, yoffset2)
	banksel	YOFFSET3
	movf	YOFFSET3,W
	movwf	SYSCALCTEMPA
	movf	YOFFSET3_H,W
	movwf	SYSCALCTEMPA_H
	movf	YOFFSET2,W
	movwf	SYSCALCTEMPB
	movf	YOFFSET2_H,W
	movwf	SYSCALCTEMPB_H
	banksel	STATUS
	pagesel	SWAP166
	call	SWAP166
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	YOFFSET3
	movwf	YOFFSET3
	movf	SYSCALCTEMPA_H,W
	movwf	YOFFSET3_H
	movf	SYSCALCTEMPB,W
	movwf	YOFFSET2
	movf	SYSCALCTEMPB_H,W
	movwf	YOFFSET2_H
;swap(xoffset3, xoffset2)
	movf	XOFFSET3,W
	movwf	SYSCALCTEMPA
	movf	XOFFSET3_H,W
	movwf	SYSCALCTEMPA_H
	movf	XOFFSET2,W
	movwf	SYSCALCTEMPB
	movf	XOFFSET2_H,W
	movwf	SYSCALCTEMPB_H
	banksel	STATUS
	pagesel	SWAP166
	call	SWAP166
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	XOFFSET3
	movwf	XOFFSET3
	movf	SYSCALCTEMPA_H,W
	movwf	XOFFSET3_H
	movf	SYSCALCTEMPB,W
	movwf	XOFFSET2
	movf	SYSCALCTEMPB_H,W
	movwf	XOFFSET2_H
;end if
ENDIF70
;if (yoffset > yoffset2) then
	banksel	YOFFSET
	movf	YOFFSET,W
	movwf	SysWORDTempB
	movf	YOFFSET_H,W
	movwf	SysWORDTempB_H
	movf	YOFFSET2,W
	movwf	SysWORDTempA
	movf	YOFFSET2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF71
;swap(yoffset, yoffset2)
	banksel	YOFFSET
	movf	YOFFSET,W
	movwf	SYSCALCTEMPA
	movf	YOFFSET_H,W
	movwf	SYSCALCTEMPA_H
	movf	YOFFSET2,W
	movwf	SYSCALCTEMPB
	movf	YOFFSET2_H,W
	movwf	SYSCALCTEMPB_H
	banksel	STATUS
	pagesel	SWAP166
	call	SWAP166
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	YOFFSET
	movwf	YOFFSET
	movf	SYSCALCTEMPA_H,W
	movwf	YOFFSET_H
	movf	SYSCALCTEMPB,W
	movwf	YOFFSET2
	movf	SYSCALCTEMPB_H,W
	movwf	YOFFSET2_H
;swap(xoffset, xoffset2)
	movf	XOFFSET,W
	movwf	SYSCALCTEMPA
	movf	XOFFSET_H,W
	movwf	SYSCALCTEMPA_H
	movf	XOFFSET2,W
	movwf	SYSCALCTEMPB
	movf	XOFFSET2_H,W
	movwf	SYSCALCTEMPB_H
	banksel	STATUS
	pagesel	SWAP166
	call	SWAP166
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	XOFFSET
	movwf	XOFFSET
	movf	SYSCALCTEMPA_H,W
	movwf	XOFFSET_H
	movf	SYSCALCTEMPB,W
	movwf	XOFFSET2
	movf	SYSCALCTEMPB_H,W
	movwf	XOFFSET2_H
;end if
ENDIF71
;Handle awkward all-on-same-line case as its own thing
;if (yoffset = yoffset3) then
	banksel	YOFFSET
	movf	YOFFSET,W
	movwf	SysWORDTempA
	movf	YOFFSET_H,W
	movwf	SysWORDTempA_H
	movf	YOFFSET3,W
	movwf	SysWORDTempB
	movf	YOFFSET3_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPEQUAL16
	call	SYSCOMPEQUAL16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF72
;GLCD_bb = xoffset
	banksel	XOFFSET
	movf	XOFFSET,W
	banksel	GLCD_BB
	movwf	GLCD_BB
	banksel	XOFFSET_H
	movf	XOFFSET_H,W
	banksel	GLCD_BB_H
	movwf	GLCD_BB_H
;GLCD_aa = xoffset
	banksel	XOFFSET
	movf	XOFFSET,W
	banksel	GLCD_AA
	movwf	GLCD_AA
	banksel	XOFFSET_H
	movf	XOFFSET_H,W
	banksel	GLCD_AA_H
	movwf	GLCD_AA_H
;if (xoffset2 < GLCD_aa ) Then
	banksel	XOFFSET2
	movf	XOFFSET2,W
	movwf	SysWORDTempA
	movf	XOFFSET2_H,W
	movwf	SysWORDTempA_H
	banksel	GLCD_AA
	movf	GLCD_AA,W
	movwf	SysWORDTempB
	movf	GLCD_AA_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE80_1
;GLCD_aa = xoffset2
	banksel	XOFFSET2
	movf	XOFFSET2,W
	banksel	GLCD_AA
	movwf	GLCD_AA
	banksel	XOFFSET2_H
	movf	XOFFSET2_H,W
	banksel	GLCD_AA_H
	movwf	GLCD_AA_H
;else if (xoffset2 > GLCD_bb ) then
	goto	ENDIF80
ELSE80_1
	banksel	XOFFSET2
	movf	XOFFSET2,W
	movwf	SysWORDTempB
	movf	XOFFSET2_H,W
	movwf	SysWORDTempB_H
	banksel	GLCD_BB
	movf	GLCD_BB,W
	movwf	SysWORDTempA
	movf	GLCD_BB_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF80
;GLCD_bb = xoffset2
	banksel	XOFFSET2
	movf	XOFFSET2,W
	banksel	GLCD_BB
	movwf	GLCD_BB
	banksel	XOFFSET2_H
	movf	XOFFSET2_H,W
	banksel	GLCD_BB_H
	movwf	GLCD_BB_H
;end if
ENDIF80
;if (xoffset3 < GLCD_aa) Then
	banksel	XOFFSET3
	movf	XOFFSET3,W
	movwf	SysWORDTempA
	movf	XOFFSET3_H,W
	movwf	SysWORDTempA_H
	banksel	GLCD_AA
	movf	GLCD_AA,W
	movwf	SysWORDTempB
	movf	GLCD_AA_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE81_1
;GLCD_aa = xoffset3
	banksel	XOFFSET3
	movf	XOFFSET3,W
	banksel	GLCD_AA
	movwf	GLCD_AA
	banksel	XOFFSET3_H
	movf	XOFFSET3_H,W
	banksel	GLCD_AA_H
	movwf	GLCD_AA_H
;else if ( xoffset3 > GLCD_bb) then
	goto	ENDIF81
ELSE81_1
	banksel	XOFFSET3
	movf	XOFFSET3,W
	movwf	SysWORDTempB
	movf	XOFFSET3_H,W
	movwf	SysWORDTempB_H
	banksel	GLCD_BB
	movf	GLCD_BB,W
	movwf	SysWORDTempA
	movf	GLCD_BB_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF81
;GLCD_bb = xoffset3
	banksel	XOFFSET3
	movf	XOFFSET3,W
	banksel	GLCD_BB
	movwf	GLCD_BB
	banksel	XOFFSET3_H
	movf	XOFFSET3_H,W
	banksel	GLCD_BB_H
	movwf	GLCD_BB_H
;end if
ENDIF81
;Line( GLCD_aa, yoffset, GLCD_bb - GLCD_aa + 1, yoffset, LineColour)
	banksel	GLCD_AA
	movf	GLCD_AA,W
	banksel	LINEX1
	movwf	LINEX1
	banksel	GLCD_AA_H
	movf	GLCD_AA_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	YOFFSET
	movf	YOFFSET,W
	banksel	LINEY1
	movwf	LINEY1
	banksel	YOFFSET_H
	movf	YOFFSET_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	GLCD_AA
	movf	GLCD_AA,W
	subwf	GLCD_BB,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	GLCD_AA_H
	movf	GLCD_AA_H,W
	subwfb	GLCD_BB_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	YOFFSET
	movf	YOFFSET,W
	banksel	LINEY2
	movwf	LINEY2
	banksel	YOFFSET_H
	movf	YOFFSET_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	pagesel	LINE_SSD1306
	call	LINE_SSD1306
	pagesel	$
;exit sub
	return
;end if
ENDIF72
;dim dxoffset01, dyoffset01, dxoffset02, dyoffset02, dxoffset12, dyoffset12, glcd_y as word
;dim glcd_sa, glcd_sb as Integer
;dxoffset01 = xoffset2 - xoffset
	banksel	XOFFSET
	movf	XOFFSET,W
	subwf	XOFFSET2,W
	banksel	DXOFFSET01
	movwf	DXOFFSET01
	banksel	XOFFSET_H
	movf	XOFFSET_H,W
	subwfb	XOFFSET2_H,W
	banksel	DXOFFSET01_H
	movwf	DXOFFSET01_H
;dyoffset01 = yoffset2 - yoffset
	banksel	YOFFSET
	movf	YOFFSET,W
	subwf	YOFFSET2,W
	banksel	DYOFFSET01
	movwf	DYOFFSET01
	banksel	YOFFSET_H
	movf	YOFFSET_H,W
	subwfb	YOFFSET2_H,W
	banksel	DYOFFSET01_H
	movwf	DYOFFSET01_H
;dxoffset02 = xoffset3 - xoffset
	banksel	XOFFSET
	movf	XOFFSET,W
	subwf	XOFFSET3,W
	banksel	DXOFFSET02
	movwf	DXOFFSET02
	banksel	XOFFSET_H
	movf	XOFFSET_H,W
	subwfb	XOFFSET3_H,W
	banksel	DXOFFSET02_H
	movwf	DXOFFSET02_H
;dyoffset02 = yoffset3 - yoffset
	banksel	YOFFSET
	movf	YOFFSET,W
	subwf	YOFFSET3,W
	banksel	DYOFFSET02
	movwf	DYOFFSET02
	banksel	YOFFSET_H
	movf	YOFFSET_H,W
	subwfb	YOFFSET3_H,W
	banksel	DYOFFSET02_H
	movwf	DYOFFSET02_H
;dxoffset12 = xoffset3 - xoffset2
	banksel	XOFFSET2
	movf	XOFFSET2,W
	subwf	XOFFSET3,W
	banksel	DXOFFSET12
	movwf	DXOFFSET12
	banksel	XOFFSET2_H
	movf	XOFFSET2_H,W
	subwfb	XOFFSET3_H,W
	banksel	DXOFFSET12_H
	movwf	DXOFFSET12_H
;dyoffset12 = yoffset3 - yoffset2
	banksel	YOFFSET2
	movf	YOFFSET2,W
	subwf	YOFFSET3,W
	banksel	DYOFFSET12
	movwf	DYOFFSET12
	banksel	YOFFSET2_H
	movf	YOFFSET2_H,W
	subwfb	YOFFSET3_H,W
	banksel	DYOFFSET12_H
	movwf	DYOFFSET12_H
;glcd_sa   = 0
	banksel	GLCD_SA
	clrf	GLCD_SA
	clrf	GLCD_SA_H
;glcd_sb   = 0
	clrf	GLCD_SB
	clrf	GLCD_SB_H
;
;For upper part of triangle, find scanline crossings for segments
;0-1 and 0-2.  If yoffset2=yoffset3 (flat-bottomed triangle), the scanline yoffset2
;is included here (and second loop will be skipped, avoiding a /0
;error there), otherwise scanline yoffset2 is skipped here and handled
;in the second loop...which also avoids a /0 error here if yoffset=yoffset2
;(flat-topped triangle).
;if ( yoffset2 = yoffset3) then
	banksel	YOFFSET2
	movf	YOFFSET2,W
	movwf	SysWORDTempA
	movf	YOFFSET2_H,W
	movwf	SysWORDTempA_H
	movf	YOFFSET3,W
	movwf	SysWORDTempB
	movf	YOFFSET3_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPEQUAL16
	call	SYSCOMPEQUAL16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE73_1
;GLCD_last = yoffset2 ;   Include yoffset2 scanline
	banksel	YOFFSET2
	movf	YOFFSET2,W
	banksel	GLCD_LAST
	movwf	GLCD_LAST
	banksel	YOFFSET2_H
	movf	YOFFSET2_H,W
	banksel	GLCD_LAST_H
	movwf	GLCD_LAST_H
;else
	goto	ENDIF73
ELSE73_1
;GLCD_last = yoffset2 - 1;  Skip it
	movlw	1
	banksel	YOFFSET2
	subwf	YOFFSET2,W
	banksel	GLCD_LAST
	movwf	GLCD_LAST
	movlw	0
	banksel	YOFFSET2_H
	subwfb	YOFFSET2_H,W
	banksel	GLCD_LAST_H
	movwf	GLCD_LAST_H
;end if
ENDIF73
;for glcd_y = yoffset to glcd_last
;Legacy method
	movlw	1
	banksel	YOFFSET
	subwf	YOFFSET,W
	banksel	GLCD_Y
	movwf	GLCD_Y
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	GLCD_Y_H
	movwf	GLCD_Y_H
	banksel	YOFFSET
	movf	YOFFSET,W
	movwf	SysWORDTempB
	movf	YOFFSET_H,W
	movwf	SysWORDTempB_H
	banksel	GLCD_LAST
	movf	GLCD_LAST,W
	movwf	SysWORDTempA
	movf	GLCD_LAST_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd14
SysForLoop14
	banksel	GLCD_Y
	incf	GLCD_Y,F
	btfsc	STATUS,Z
	incf	GLCD_Y_H,F
;glcd_aa   = xoffset +  glcd_sa / dyoffset01
	movf	GLCD_SA,W
	movwf	SysINTEGERTempA
	movf	GLCD_SA_H,W
	movwf	SysINTEGERTempA_H
	banksel	DYOFFSET01
	movf	DYOFFSET01,W
	movwf	SysINTEGERTempB
	movf	DYOFFSET01_H,W
	movwf	SysINTEGERTempB_H
	pagesel	SYSDIVSUBINT
	call	SYSDIVSUBINT
	pagesel	$
	movf	SysINTEGERTempA,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	banksel	GLCD_AA
	movwf	GLCD_AA
	movf	SysINTEGERTempA_H,W
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	GLCD_AA_H
	movwf	GLCD_AA_H
;glcd_bb   = xoffset +  glcd_sb / dyoffset02
	movf	GLCD_SB,W
	movwf	SysINTEGERTempA
	movf	GLCD_SB_H,W
	movwf	SysINTEGERTempA_H
	banksel	DYOFFSET02
	movf	DYOFFSET02,W
	movwf	SysINTEGERTempB
	movf	DYOFFSET02_H,W
	movwf	SysINTEGERTempB_H
	pagesel	SYSDIVSUBINT
	call	SYSDIVSUBINT
	pagesel	$
	movf	SysINTEGERTempA,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	banksel	GLCD_BB
	movwf	GLCD_BB
	movf	SysINTEGERTempA_H,W
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	GLCD_BB_H
	movwf	GLCD_BB_H
;glcd_sa = glcd_sa + dxoffset01
	banksel	DXOFFSET01
	movf	DXOFFSET01,W
	banksel	GLCD_SA
	addwf	GLCD_SA,F
	banksel	DXOFFSET01_H
	movf	DXOFFSET01_H,W
	banksel	GLCD_SA_H
	addwfc	GLCD_SA_H,F
;glcd_sb = glcd_sb + dxoffset02
	banksel	DXOFFSET02
	movf	DXOFFSET02,W
	banksel	GLCD_SB
	addwf	GLCD_SB,F
	banksel	DXOFFSET02_H
	movf	DXOFFSET02_H,W
	banksel	GLCD_SB_H
	addwfc	GLCD_SB_H,F
;if (glcd_aa > glcd_bb)  then
	movf	GLCD_AA,W
	movwf	SysWORDTempB
	movf	GLCD_AA_H,W
	movwf	SysWORDTempB_H
	movf	GLCD_BB,W
	movwf	SysWORDTempA
	movf	GLCD_BB_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF75
;swap(glcd_aa, glcd_bb)
	banksel	GLCD_AA
	movf	GLCD_AA,W
	movwf	SYSCALCTEMPA
	movf	GLCD_AA_H,W
	movwf	SYSCALCTEMPA_H
	movf	GLCD_BB,W
	movwf	SYSCALCTEMPB
	movf	GLCD_BB_H,W
	movwf	SYSCALCTEMPB_H
	banksel	STATUS
	pagesel	SWAP166
	call	SWAP166
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	GLCD_AA
	movwf	GLCD_AA
	movf	SYSCALCTEMPA_H,W
	movwf	GLCD_AA_H
	movf	SYSCALCTEMPB,W
	movwf	GLCD_BB
	movf	SYSCALCTEMPB_H,W
	movwf	GLCD_BB_H
;end if
ENDIF75
;Line(glcd_aa, glcd_y, glcd_bb , glcd_y, LineColour)
	banksel	GLCD_AA
	movf	GLCD_AA,W
	banksel	LINEX1
	movwf	LINEX1
	banksel	GLCD_AA_H
	movf	GLCD_AA_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	GLCD_Y
	movf	GLCD_Y,W
	banksel	LINEY1
	movwf	LINEY1
	banksel	GLCD_Y_H
	movf	GLCD_Y_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	GLCD_BB
	movf	GLCD_BB,W
	banksel	LINEX2
	movwf	LINEX2
	banksel	GLCD_BB_H
	movf	GLCD_BB_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	GLCD_Y
	movf	GLCD_Y,W
	banksel	LINEY2
	movwf	LINEY2
	banksel	GLCD_Y_H
	movf	GLCD_Y_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	pagesel	LINE_SSD1306
	call	LINE_SSD1306
	pagesel	$
;next
	banksel	GLCD_Y
	movf	GLCD_Y,W
	movwf	SysWORDTempA
	movf	GLCD_Y_H,W
	movwf	SysWORDTempA_H
	movf	GLCD_LAST,W
	movwf	SysWORDTempB
	movf	GLCD_LAST_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop14
SysForLoopEnd14
;For lower part of triangle, find scanline crossings for segments
;0-2 and 1-2.  This loop is skipped if yoffset2=yoffset3.
;glcd_sa = dxoffset12 * (glcd_y - yoffset2);
	banksel	YOFFSET2
	movf	YOFFSET2,W
	banksel	GLCD_Y
	subwf	GLCD_Y,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	YOFFSET2_H,W
	banksel	GLCD_Y_H
	subwfb	GLCD_Y_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	DXOFFSET12
	movf	DXOFFSET12,W
	movwf	SysINTEGERTempA
	movf	DXOFFSET12_H,W
	movwf	SysINTEGERTempA_H
	banksel	SYSTEMP1
	movf	SysTemp1,W
	movwf	SysINTEGERTempB
	movf	SysTemp1_H,W
	movwf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSMULTSUBINT
	call	SYSMULTSUBINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	GLCD_SA
	movwf	GLCD_SA
	movf	SysINTEGERTempX_H,W
	movwf	GLCD_SA_H
;glcd_sb = dxoffset02 * (glcd_y - yoffset);
	banksel	YOFFSET
	movf	YOFFSET,W
	banksel	GLCD_Y
	subwf	GLCD_Y,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	YOFFSET_H,W
	banksel	GLCD_Y_H
	subwfb	GLCD_Y_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	DXOFFSET02
	movf	DXOFFSET02,W
	movwf	SysINTEGERTempA
	movf	DXOFFSET02_H,W
	movwf	SysINTEGERTempA_H
	banksel	SYSTEMP1
	movf	SysTemp1,W
	movwf	SysINTEGERTempB
	movf	SysTemp1_H,W
	movwf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSMULTSUBINT
	call	SYSMULTSUBINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	GLCD_SB
	movwf	GLCD_SB
	movf	SysINTEGERTempX_H,W
	movwf	GLCD_SB_H
;for glcd_y = glcd_last to yoffset3
;Legacy method
	movlw	1
	subwf	GLCD_LAST,W
	movwf	GLCD_Y
	movlw	0
	subwfb	GLCD_LAST_H,W
	movwf	GLCD_Y_H
	movf	GLCD_LAST,W
	movwf	SysWORDTempB
	movf	GLCD_LAST_H,W
	movwf	SysWORDTempB_H
	banksel	YOFFSET3
	movf	YOFFSET3,W
	movwf	SysWORDTempA
	movf	YOFFSET3_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd15
SysForLoop15
	banksel	GLCD_Y
	incf	GLCD_Y,F
	btfsc	STATUS,Z
	incf	GLCD_Y_H,F
;glcd_aa   = xoffset2 +  glcd_sa / dyoffset12
	movf	GLCD_SA,W
	movwf	SysINTEGERTempA
	movf	GLCD_SA_H,W
	movwf	SysINTEGERTempA_H
	banksel	DYOFFSET12
	movf	DYOFFSET12,W
	movwf	SysINTEGERTempB
	movf	DYOFFSET12_H,W
	movwf	SysINTEGERTempB_H
	pagesel	SYSDIVSUBINT
	call	SYSDIVSUBINT
	pagesel	$
	movf	SysINTEGERTempA,W
	banksel	XOFFSET2
	addwf	XOFFSET2,W
	banksel	GLCD_AA
	movwf	GLCD_AA
	movf	SysINTEGERTempA_H,W
	banksel	XOFFSET2_H
	addwfc	XOFFSET2_H,W
	banksel	GLCD_AA_H
	movwf	GLCD_AA_H
;glcd_bb   = xoffset +  glcd_sb / dyoffset02
	movf	GLCD_SB,W
	movwf	SysINTEGERTempA
	movf	GLCD_SB_H,W
	movwf	SysINTEGERTempA_H
	banksel	DYOFFSET02
	movf	DYOFFSET02,W
	movwf	SysINTEGERTempB
	movf	DYOFFSET02_H,W
	movwf	SysINTEGERTempB_H
	pagesel	SYSDIVSUBINT
	call	SYSDIVSUBINT
	pagesel	$
	movf	SysINTEGERTempA,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	banksel	GLCD_BB
	movwf	GLCD_BB
	movf	SysINTEGERTempA_H,W
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	GLCD_BB_H
	movwf	GLCD_BB_H
;glcd_sa = glcd_sa + dxoffset12
	banksel	DXOFFSET12
	movf	DXOFFSET12,W
	banksel	GLCD_SA
	addwf	GLCD_SA,F
	banksel	DXOFFSET12_H
	movf	DXOFFSET12_H,W
	banksel	GLCD_SA_H
	addwfc	GLCD_SA_H,F
;glcd_sb = glcd_sb + dxoffset02
	banksel	DXOFFSET02
	movf	DXOFFSET02,W
	banksel	GLCD_SB
	addwf	GLCD_SB,F
	banksel	DXOFFSET02_H
	movf	DXOFFSET02_H,W
	banksel	GLCD_SB_H
	addwfc	GLCD_SB_H,F
;if (glcd_aa > glcd_bb)  then
	movf	GLCD_AA,W
	movwf	SysWORDTempB
	movf	GLCD_AA_H,W
	movwf	SysWORDTempB_H
	movf	GLCD_BB,W
	movwf	SysWORDTempA
	movf	GLCD_BB_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF78
;swap(glcd_aa, glcd_bb)
	banksel	GLCD_AA
	movf	GLCD_AA,W
	movwf	SYSCALCTEMPA
	movf	GLCD_AA_H,W
	movwf	SYSCALCTEMPA_H
	movf	GLCD_BB,W
	movwf	SYSCALCTEMPB
	movf	GLCD_BB_H,W
	movwf	SYSCALCTEMPB_H
	banksel	STATUS
	pagesel	SWAP166
	call	SWAP166
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	GLCD_AA
	movwf	GLCD_AA
	movf	SYSCALCTEMPA_H,W
	movwf	GLCD_AA_H
	movf	SYSCALCTEMPB,W
	movwf	GLCD_BB
	movf	SYSCALCTEMPB_H,W
	movwf	GLCD_BB_H
;end if
ENDIF78
;Line(glcd_aa, glcd_y, glcd_bb , glcd_y, LineColour)
	banksel	GLCD_AA
	movf	GLCD_AA,W
	banksel	LINEX1
	movwf	LINEX1
	banksel	GLCD_AA_H
	movf	GLCD_AA_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	GLCD_Y
	movf	GLCD_Y,W
	banksel	LINEY1
	movwf	LINEY1
	banksel	GLCD_Y_H
	movf	GLCD_Y_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	GLCD_BB
	movf	GLCD_BB,W
	banksel	LINEX2
	movwf	LINEX2
	banksel	GLCD_BB_H
	movf	GLCD_BB_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	GLCD_Y
	movf	GLCD_Y,W
	banksel	LINEY2
	movwf	LINEY2
	banksel	GLCD_Y_H
	movf	GLCD_Y_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	pagesel	LINE_SSD1306
	call	LINE_SSD1306
	pagesel	$
;next
	banksel	GLCD_Y
	movf	GLCD_Y,W
	movwf	SysWORDTempA
	movf	GLCD_Y_H,W
	movwf	SysWORDTempA_H
	banksel	YOFFSET3
	movf	YOFFSET3,W
	movwf	SysWORDTempB
	movf	YOFFSET3_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop15
SysForLoopEnd15
	return

;********************************************************************************

;Source: hwi2c.h (916)
HI2CINIT
;Dim HI2C1StateMachine as byte
;Dim HI2CACKPOLLSTATE  as Byte
;Dim TWI0ACKPOLLSTATE  as Byte Alias HI2CACKPOLLSTATE
;Dim HI2C1lastError as Byte
;This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K-Mode family chips
;HI2CCurrentMode = 0
	banksel	HI2CCURRENTMODE
	clrf	HI2CCURRENTMODE
;Initialise the I2C module
	banksel	STATUS
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (349)
INITGLCD_SSD1306
;Colours //Set these first
;GLCDBackground = 0
	clrf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = 1
	movlw	1
	banksel	GLCDFOREGROUND
	movwf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
;GLCDFontWidth = 5
	movlw	5
	banksel	GLCDFONTWIDTH
	movwf	GLCDFONTWIDTH
;GLCDfntDefaultHeight = 7  'used by GLCDPrintString and GLCDPrintStringLn
	movlw	7
	movwf	GLCDFNTDEFAULTHEIGHT
;dim PrintLocX, PrintLocY as word
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;wait 255 ms             'added to ensure the charge pump and power is operational.
	movlw	255
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;HI2CMode Master
	movlw	12
	banksel	HI2CCURRENTMODE
	movwf	HI2CCURRENTMODE
	banksel	STATUS
	pagesel	HI2CMODE
	call	HI2CMODE
	pagesel	$
;Wait 15 ms  'wait for power-up and reset
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Setup code for SSD1306 controllers
;Init sequence for 128x64 OLED module
;Write_Command_SSD1306(SSD1306_DISPLAYOFF)                    ' 0xAE
	movlw	174
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_DEACTIVATE_SCROLL)
	movlw	46
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SETDISPLAYCLOCKDIV)            ' 0xD5
	movlw	213
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(0x80)                                  ' the suggested ratio 0x80
	movlw	128
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SETMULTIPLEX)                  ' 0xA8
	movlw	168
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(0x3f)                                 '64 pixels
	movlw	63
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SETDISPLAYOFFSET)              ' 0xD3
	movlw	211
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(0x00)                                   ' no offset
	banksel	SSD1306SENDBYTE
	clrf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SETSTARTLINE | 0x00)            ' line #0
	movlw	64
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_CHARGEPUMP)                    ' 0x8D
	movlw	141
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;if (SSD1306_vccstate = SSD1306_EXTERNALVCC) then
;Write_Command_SSD1306(0x14)
	movlw	20
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;end if
;Write_Command_SSD1306(SSD1306_MEMORYMODE)                    ' 0x20
	movlw	32
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(0x10)                                  ' 0x01 act like PCD8544
	movlw	16
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SEGREMAP | 0x1)
	movlw	161
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_COMSCANDEC)
	movlw	200
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SETCOMPINS)                    ' 0xDA
	movlw	218
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(0x12)                                 '64 pixels
	movlw	18
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SETCONTRAST)                   ' 0x81
	movlw	129
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xCF)
	movlw	207
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;end if
;Write_Command_SSD1306(SSD1306_SETPRECHARGE)                  ' 0xd9
	movlw	217
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xF1)
	movlw	241
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;end if
;Write_Command_SSD1306(SSD1306_SETVCOMDETECT)                 ' 0xDB
	movlw	219
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(0x40)
	movlw	64
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_DISPLAYALLON_RESUME)           ' 0xA4
	movlw	164
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_NORMALDISPLAY)                 ' 0xA6
	movlw	166
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Clear screen Here
;GLCDCLS_SSD1306
	pagesel	GLCDCLS_SSD1306
	call	GLCDCLS_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_DISPLAYON)                     '--turn on oled panel
	movlw	175
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_COMMAND_SSD1306
	goto	WRITE_COMMAND_SSD1306

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (43)
INITPPS
;UNLOCKPPS
;Macro Source: stdbasic.h (81)
;dim IntState as bit
;IntState = GIE
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,3
	btfsc	INTCON,GIE
	bsf	SYSBITVAR0,3
;GIE = 0
	bcf	INTCON,GIE
;PPSLOCK = 0x55
	movlw	85
	banksel	PPSLOCK
	movwf	PPSLOCK
;PPSLOCK = 0xAA
	movlw	170
	movwf	PPSLOCK
;PPSLOCKED = 0x00  'unlock PPS
	bcf	PPSLOCK,PPSLOCKED
;Module: MSSP1
;RC1PPS = 0x0019    'SDA1 > RC1
	movlw	25
	banksel	RC1PPS
	movwf	RC1PPS
;SSP1DATPPS = 0x0011    'RC1 > SDA1 (bi-directional)
	movlw	17
	banksel	SSP1DATPPS
	movwf	SSP1DATPPS
;RC0PPS = 0x0018    'SCL1 > RC0
	movlw	24
	banksel	RC0PPS
	movwf	RC0PPS
;SSP1CLKPPS = 0x0010    'RC0 > SCL1 (bi-directional)
	movlw	16
	banksel	SSP1CLKPPS
	movwf	SSP1CLKPPS
	banksel	STATUS
	return

;********************************************************************************

;Source: system.h (211)
INITSYS
;Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	clrf	OSCCON3
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	clrf	OSCEN
;Default value
;OSCTUNE = 0x00
	clrf	OSCTUNE
;The MCU is a chip family ChipFamily
;OSCCON type is 102
;Set OSCFRQ values for MCUs with OSCSTAT1 chip... the 16F18326/18346 MCU family
;OSCFRQ = 0b00000111
	movlw	7
	movwf	OSCFRQ
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELC = 0
	clrf	ANSELC
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
;PORTC = 0
	clrf	PORTC
;ClearRAM
;Macro Source: system.h (1838)
;No code. User has not included <clearram.h>
	return

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (164)
SHOWPOT
;DrawTitle("3 Pot")
	movlw	low StringTable11
	banksel	SYSTITLETEXTHANDLER
	movwf	SysTITLETEXTHandler
	movlw	(high StringTable11) | 128
	movwf	SysTITLETEXTHandler_H
	banksel	STATUS
	pagesel	DRAWTITLE
	call	DRAWTITLE
	pagesel	$
;GLCDPrint(0, 13, "Turn the pot:")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	13
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable12
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable12) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT22
	call	GLCDPRINT22
	pagesel	$
;Box(0, 40, 127, 52)                         ' the frame; the bar is x 1..126 inside it
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	movlw	40
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	127
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	52
	movwf	LINEY2
	clrf	LINEY2_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	pagesel	BOX_SSD1306
	call	BOX_SSD1306
	pagesel	$
;ShownADC = 0xFFFF                           ' no value shown yet: the first reading paints
	movlw	255
	banksel	SHOWNADC
	movwf	SHOWNADC
	movwf	SHOWNADC_H
;ScreenTicks = 0
	clrf	SCREENTICKS
	clrf	SCREENTICKS_H
;Do While ScreenTicks < SCREEN_MS
SysDoLoop_S2
	movf	screenticks,W
	movwf	SysWORDTempA
	movf	screenticks_H,W
	movwf	SysWORDTempA_H
	movlw	160
	movwf	SysWORDTempB
	movlw	15
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysDoLoop_E2
;PotNow = ReadPotAverage                 ' 8 readings: the value moves only when the pot does
	pagesel	FN_READPOTAVERAGE
	call	FN_READPOTAVERAGE
	pagesel	$
	banksel	READPOTAVERAGE
	movf	READPOTAVERAGE,W
	movwf	POTNOW
	movf	READPOTAVERAGE_H,W
	movwf	POTNOW_H
;paint only when the ADC value changes
;If PotNow <> ShownADC Then
	movf	POTNOW,W
	movwf	SysWORDTempA
	movf	POTNOW_H,W
	movwf	SysWORDTempA_H
	banksel	SHOWNADC
	movf	SHOWNADC,W
	movwf	SysWORDTempB
	movf	SHOWNADC_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPEQUAL16
	call	SYSCOMPEQUAL16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF3
;ShownADC = PotNow
	banksel	POTNOW
	movf	POTNOW,W
	banksel	SHOWNADC
	movwf	SHOWNADC
	banksel	POTNOW_H
	movf	POTNOW_H,W
	banksel	SHOWNADC_H
	movwf	SHOWNADC_H
;the value, right aligned in 4 characters drawn one by one: a leading zero is drawn as a
;space, which overwrites the old digit
;ShowDigits(0, 24, PotNow)
	banksel	DIGITX
	clrf	DIGITX
	clrf	DIGITX_H
	movlw	24
	movwf	DIGITY
	clrf	DIGITY_H
	banksel	POTNOW
	movf	POTNOW,W
	banksel	DIGITIN
	movwf	DIGITIN
	banksel	POTNOW_H
	movf	POTNOW_H,W
	banksel	DIGITIN_H
	movwf	DIGITIN_H
	pagesel	SHOWDIGITS
	call	SHOWDIGITS
	pagesel	$
;the bar end: 0..1023 / 8 = 0..127, kept inside the frame (0..125 filled pixels)
;PotBar = PotNow
	banksel	POTNOW
	movf	POTNOW,W
	movwf	POTBAR
	movf	POTNOW_H,W
	movwf	POTBAR_H
;Repeat 3
	movlw	3
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop1
;Set C Off
	bcf	STATUS,C
;Rotate PotBar Right
	banksel	POTBAR_H
	rrf	POTBAR_H,F
	rrf	POTBAR,F
;End Repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;If PotBar > 125 Then PotBar = 125
	banksel	POTBAR
	movf	POTBAR,W
	movwf	SysWORDTempB
	movf	POTBAR_H,W
	movwf	SysWORDTempB_H
	movlw	125
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF5
;If PotBar > 125 Then PotBar = 125
	movlw	125
	banksel	POTBAR
	movwf	POTBAR
	clrf	POTBAR_H
;If PotBar > 125 Then PotBar = 125
ENDIF5
;paint 0 to the value, then the value to the end
;If PotBar > 0 Then FilledBox(1, 41, PotBar, 51)
	banksel	POTBAR
	movf	POTBAR,W
	movwf	SysWORDTempB
	movf	POTBAR_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF6
;If PotBar > 0 Then FilledBox(1, 41, PotBar, 51)
	movlw	1
	banksel	LINEX1
	movwf	LINEX1
	movlw	41
	movwf	LINEY1
	movf	POTBAR,W
	movwf	LINEX2
	movlw	51
	movwf	LINEY2
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	pagesel	FILLEDBOX_SSD1306
	call	FILLEDBOX_SSD1306
	pagesel	$
;If PotBar > 0 Then FilledBox(1, 41, PotBar, 51)
ENDIF6
;If PotBar < 126 Then FilledBox(PotBar + 1, 41, 126, 51, GLCDBackground)
	banksel	POTBAR
	movf	POTBAR,W
	movwf	SysWORDTempA
	movf	POTBAR_H,W
	movwf	SysWORDTempA_H
	movlw	126
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF7
;If PotBar < 126 Then FilledBox(PotBar + 1, 41, 126, 51, GLCDBackground)
	banksel	POTBAR
	incf	POTBAR,W
	movwf	LINEX1
	movlw	41
	movwf	LINEY1
	movlw	126
	movwf	LINEX2
	movlw	51
	movwf	LINEY2
	banksel	GLCDBACKGROUND
	movf	GLCDBACKGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDBACKGROUND_H
	movf	GLCDBACKGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	pagesel	FILLEDBOX_SSD1306
	call	FILLEDBOX_SSD1306
	pagesel	$
;If PotBar < 126 Then FilledBox(PotBar + 1, 41, 126, 51, GLCDBackground)
ENDIF7
;End If
ENDIF3
;If SwitchPressed = 1 Then Exit Sub
	pagesel	FN_SWITCHPRESSED
	call	FN_SWITCHPRESSED
	pagesel	$
	banksel	SWITCHPRESSED
	decf	SWITCHPRESSED,W
	btfss	STATUS, Z
	goto	ENDIF4
;If SwitchPressed = 1 Then Exit Sub
	banksel	STATUS
	return
;If SwitchPressed = 1 Then Exit Sub
ENDIF4
;Wait 20 ms
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;ScreenTicks += 20
	movlw	20
	banksel	SCREENTICKS
	addwf	SCREENTICKS,F
	movlw	0
	addwfc	SCREENTICKS_H,F
;Loop
	goto	SysDoLoop_S2
SysDoLoop_E2
	return

;********************************************************************************

;Source: system.h (4411)
SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;subwf SysByteTempB, W
	subwf	SYSBYTETEMPB, W
;btfsc STATUS, Z
	btfsc	STATUS, Z
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Program_memory_page: 1
	ORG	2048
;Source: glcd.h (4494)
DRAW_ELLIPSE_POINTS
;dim LineColour as Long
;Pset ((xoffset + GLCD_xx), (yoffset + GLCD_yy), LineColour)
	banksel	GLCD_XX
	movf	GLCD_XX,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movf	GLCD_YY,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Pset ((xoffset - GLCD_xx), (yoffset + GLCD_yy), LineColour)
	banksel	GLCD_XX
	movf	GLCD_XX,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movf	GLCD_YY,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Pset ((xoffset - GLCD_xx), (yoffset - GLCD_yy), LineColour)
	banksel	GLCD_XX
	movf	GLCD_XX,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movf	GLCD_YY,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Pset ((xoffset + GLCD_xx), (yoffset - GLCD_yy), LineColour)
	banksel	GLCD_XX
	movf	GLCD_XX,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movf	GLCD_YY,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	goto	PSET_SSD1306

;********************************************************************************

;Source: glcd.h (2240)
GLCDROTATE
;Empty routine  - do not delete
	return

;********************************************************************************

OLEDFONT2
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	145
	movwf	SysWORDTempB
	movlw	7
	movwf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEOLEDFONT2
	movwf	SysStringA
	movlw	(high TABLEOLEDFONT2) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEOLEDFONT2
	retlw	147
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	27
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	30
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	30
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	32
	retlw	25
	retlw	160
	retlw	7
	retlw	120
	retlw	1
	retlw	38
	retlw	25
	retlw	160
	retlw	7
	retlw	120
	retlw	1
	retlw	38
	retlw	1
	retlw	32
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	24
	retlw	38
	retlw	16
	retlw	66
	retlw	16
	retlw	255
	retlw	63
	retlw	130
	retlw	17
	retlw	2
	retlw	15
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	16
	retlw	34
	retlw	8
	retlw	34
	retlw	4
	retlw	34
	retlw	3
	retlw	156
	retlw	0
	retlw	64
	retlw	14
	retlw	48
	retlw	17
	retlw	8
	retlw	17
	retlw	4
	retlw	17
	retlw	2
	retlw	14
	retlw	0
	retlw	7
	retlw	128
	retlw	8
	retlw	92
	retlw	16
	retlw	98
	retlw	16
	retlw	162
	retlw	17
	retlw	50
	retlw	19
	retlw	28
	retlw	28
	retlw	0
	retlw	24
	retlw	0
	retlw	22
	retlw	128
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	30
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	7
	retlw	24
	retlw	24
	retlw	12
	retlw	48
	retlw	4
	retlw	32
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	4
	retlw	32
	retlw	12
	retlw	48
	retlw	24
	retlw	24
	retlw	224
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	0
	retlw	24
	retlw	0
	retlw	240
	retlw	0
	retlw	78
	retlw	0
	retlw	240
	retlw	0
	retlw	24
	retlw	0
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	224
	retlw	31
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	152
	retlw	0
	retlw	120
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	24
	retlw	0
	retlw	24
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	0
	retlw	48
	retlw	0
	retlw	12
	retlw	0
	retlw	3
	retlw	192
	retlw	0
	retlw	48
	retlw	0
	retlw	12
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	3
	retlw	12
	retlw	12
	retlw	2
	retlw	16
	retlw	2
	retlw	16
	retlw	2
	retlw	16
	retlw	12
	retlw	12
	retlw	240
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	16
	retlw	4
	retlw	16
	retlw	4
	retlw	16
	retlw	254
	retlw	31
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	6
	retlw	24
	retlw	2
	retlw	20
	retlw	2
	retlw	18
	retlw	2
	retlw	17
	retlw	194
	retlw	16
	retlw	60
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	16
	retlw	66
	retlw	16
	retlw	66
	retlw	16
	retlw	66
	retlw	16
	retlw	188
	retlw	15
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	192
	retlw	2
	retlw	32
	retlw	2
	retlw	24
	retlw	2
	retlw	4
	retlw	2
	retlw	254
	retlw	31
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	62
	retlw	16
	retlw	34
	retlw	16
	retlw	34
	retlw	16
	retlw	66
	retlw	8
	retlw	130
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	7
	retlw	76
	retlw	8
	retlw	34
	retlw	16
	retlw	34
	retlw	16
	retlw	34
	retlw	16
	retlw	66
	retlw	8
	retlw	128
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	24
	retlw	2
	retlw	7
	retlw	194
	retlw	0
	retlw	50
	retlw	0
	retlw	10
	retlw	0
	retlw	6
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	15
	retlw	162
	retlw	16
	retlw	66
	retlw	16
	retlw	66
	retlw	16
	retlw	162
	retlw	16
	retlw	162
	retlw	9
	retlw	28
	retlw	6
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	120
	retlw	0
	retlw	132
	retlw	16
	retlw	2
	retlw	17
	retlw	2
	retlw	17
	retlw	2
	retlw	17
	retlw	132
	retlw	12
	retlw	248
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	96
	retlw	24
	retlw	96
	retlw	24
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	96
	retlw	152
	retlw	96
	retlw	120
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	64
	retlw	8
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	64
	retlw	8
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	14
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	27
	retlw	130
	retlw	0
	retlw	66
	retlw	0
	retlw	38
	retlw	0
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	3
	retlw	24
	retlw	12
	retlw	4
	retlw	24
	retlw	226
	retlw	19
	retlw	18
	retlw	20
	retlw	10
	retlw	22
	retlw	138
	retlw	27
	retlw	252
	retlw	7
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	16
	retlw	0
	retlw	14
	retlw	128
	retlw	3
	retlw	112
	retlw	2
	retlw	24
	retlw	2
	retlw	48
	retlw	2
	retlw	192
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	12
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	136
	retlw	16
	retlw	136
	retlw	16
	retlw	136
	retlw	16
	retlw	136
	retlw	16
	retlw	72
	retlw	17
	retlw	48
	retlw	14
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	3
	retlw	48
	retlw	12
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	24
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	16
	retlw	8
	retlw	224
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	8
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	3
	retlw	48
	retlw	12
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	24
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	248
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	248
	retlw	31
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	248
	retlw	15
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	128
	retlw	0
	retlw	128
	retlw	1
	retlw	64
	retlw	2
	retlw	32
	retlw	4
	retlw	16
	retlw	4
	retlw	8
	retlw	8
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	56
	retlw	0
	retlw	224
	retlw	1
	retlw	0
	retlw	7
	retlw	0
	retlw	6
	retlw	192
	retlw	1
	retlw	56
	retlw	0
	retlw	248
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	16
	retlw	0
	retlw	96
	retlw	0
	retlw	128
	retlw	1
	retlw	0
	retlw	6
	retlw	0
	retlw	8
	retlw	248
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	7
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	16
	retlw	8
	retlw	224
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	136
	retlw	0
	retlw	112
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	7
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	48
	retlw	16
	retlw	72
	retlw	224
	retlw	71
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	3
	retlw	136
	retlw	4
	retlw	112
	retlw	8
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	112
	retlw	24
	retlw	72
	retlw	16
	retlw	136
	retlw	16
	retlw	136
	retlw	16
	retlw	8
	retlw	17
	retlw	8
	retlw	9
	retlw	24
	retlw	14
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	7
	retlw	0
	retlw	24
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	8
	retlw	248
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	0
	retlw	48
	retlw	0
	retlw	192
	retlw	1
	retlw	0
	retlw	6
	retlw	0
	retlw	24
	retlw	0
	retlw	24
	retlw	0
	retlw	7
	retlw	192
	retlw	0
	retlw	48
	retlw	0
	retlw	8
	retlw	0
	retlw	24
	retlw	0
	retlw	224
	retlw	3
	retlw	0
	retlw	28
	retlw	0
	retlw	15
	retlw	224
	retlw	0
	retlw	192
	retlw	1
	retlw	0
	retlw	14
	retlw	0
	retlw	28
	retlw	224
	retlw	3
	retlw	24
	retlw	0
	retlw	8
	retlw	16
	retlw	16
	retlw	8
	retlw	32
	retlw	4
	retlw	64
	retlw	2
	retlw	128
	retlw	1
	retlw	128
	retlw	1
	retlw	64
	retlw	2
	retlw	32
	retlw	4
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	0
	retlw	16
	retlw	0
	retlw	96
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	31
	retlw	128
	retlw	0
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	16
	retlw	0
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	24
	retlw	8
	retlw	20
	retlw	8
	retlw	18
	retlw	8
	retlw	17
	retlw	136
	retlw	16
	retlw	72
	retlw	16
	retlw	40
	retlw	16
	retlw	24
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	127
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	0
	retlw	12
	retlw	0
	retlw	48
	retlw	0
	retlw	192
	retlw	0
	retlw	0
	retlw	3
	retlw	0
	retlw	12
	retlw	0
	retlw	48
	retlw	0
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	254
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	0
	retlw	3
	retlw	224
	retlw	0
	retlw	56
	retlw	0
	retlw	14
	retlw	0
	retlw	112
	retlw	0
	retlw	128
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	12
	retlw	32
	retlw	18
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	32
	retlw	9
	retlw	192
	retlw	31
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	31
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	96
	retlw	8
	retlw	128
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	24
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	254
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	9
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	192
	retlw	17
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	252
	retlw	31
	retlw	36
	retlw	0
	retlw	34
	retlw	0
	retlw	34
	retlw	0
	retlw	34
	retlw	0
	retlw	34
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	152
	retlw	32
	retlw	144
	retlw	32
	retlw	144
	retlw	32
	retlw	144
	retlw	64
	retlw	72
	retlw	224
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	31
	retlw	128
	retlw	0
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	38
	retlw	0
	retlw	230
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	32
	retlw	128
	retlw	32
	retlw	128
	retlw	38
	retlw	128
	retlw	230
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	31
	retlw	0
	retlw	1
	retlw	0
	retlw	3
	retlw	128
	retlw	4
	retlw	64
	retlw	4
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	254
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	31
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	31
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	31
	retlw	192
	retlw	0
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	128
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	255
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	96
	retlw	8
	retlw	128
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	24
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	224
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	31
	retlw	128
	retlw	0
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	24
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	32
	retlw	18
	retlw	32
	retlw	18
	retlw	32
	retlw	12
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	248
	retlw	15
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	15
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	8
	retlw	224
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	1
	retlw	0
	retlw	6
	retlw	0
	retlw	24
	retlw	0
	retlw	16
	retlw	0
	retlw	12
	retlw	0
	retlw	3
	retlw	192
	retlw	0
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	96
	retlw	0
	retlw	128
	retlw	7
	retlw	0
	retlw	24
	retlw	0
	retlw	14
	retlw	192
	retlw	1
	retlw	128
	retlw	1
	retlw	0
	retlw	14
	retlw	0
	retlw	24
	retlw	128
	retlw	7
	retlw	96
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	128
	retlw	4
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	128
	retlw	4
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	32
	retlw	128
	retlw	192
	retlw	128
	retlw	0
	retlw	131
	retlw	0
	retlw	70
	retlw	0
	retlw	56
	retlw	0
	retlw	24
	retlw	0
	retlw	6
	retlw	0
	retlw	1
	retlw	192
	retlw	0
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	16
	retlw	32
	retlw	24
	retlw	32
	retlw	20
	retlw	32
	retlw	18
	retlw	32
	retlw	17
	retlw	160
	retlw	16
	retlw	96
	retlw	16
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	252
	retlw	62
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	252
	retlw	62
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	128
	retlw	0
	retlw	128
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	128
	retlw	1
	retlw	0
	retlw	0
	retlw	128
	retlw	31
	retlw	192
	retlw	16
	retlw	32
	retlw	16
	retlw	16
	retlw	16
	retlw	32
	retlw	16
	retlw	192
	retlw	16
	retlw	128
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	3
	retlw	48
	retlw	12
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	144
	retlw	8
	retlw	176
	retlw	24
	retlw	208

;********************************************************************************

;Program_memory_page: 2
	ORG	4096
;Source: GLCD_SSD1306.H (1413)
CURSOR_POSITION_SSD1306
;dim  PosCharX, PosCharX as Word
;PosCharY = LocY / 8
;faster than /8
;PosCharY = LocY
	banksel	LOCY
	movf	LOCY,W
	movwf	POSCHARY
;Repeat 3
	movlw	3
	banksel	SYSREPEATTEMP11
	movwf	SysRepeatTemp11
SysRepeatLoop11
;Set C Off
	bcf	STATUS,C
;Rotate PosCharY Right
	banksel	POSCHARY
	rrf	POSCHARY,F
;End Repeat
	banksel	SYSREPEATTEMP11
	decfsz	SysRepeatTemp11,F
	goto	SysRepeatLoop11
SysRepeatLoopEnd11
;Batched into one I2C transaction instead of three Write_Command_SSD1306 calls, each of which
;was its own Start/address/control/byte/Stop - Cursor_Position_SSD1306 is called once per
;pixel/byte written, so this was the single largest source of I2C overhead in the driver
;Open_Command_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1637)
;4wire not supported, see Write_Transaction_Command_SSD1306
;HI2CStart
	banksel	STATUS
	pagesel	HI2CSTART
	call	HI2CSTART
	pagesel	$
;HI2CSend GLCD_I2C_Address
	movlw	120
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 0x00
	banksel	I2CBYTE
	clrf	I2CBYTE
	banksel	STATUS
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;Write_Transaction_Command_SSD1306( 0xB0 + PosCharY )   ' set page address
;Macro Source: GLCD_SSD1306.H (1668)
;HI2CSend SSD1306SendByte
	movlw	176
	banksel	POSCHARY
	addwf	POSCHARY,W
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;PosCharX = ( LocX  & 0x0f )  ' lower nibble
	movlw	15
	banksel	LOCX
	andwf	LOCX,W
	banksel	POSCHARX
	movwf	POSCHARX
	clrf	POSCHARX_H
;Write_Transaction_Command_SSD1306( PosCharX )
;Macro Source: GLCD_SSD1306.H (1668)
;HI2CSend SSD1306SendByte
	movf	POSCHARX,W
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;PosCharX = LocX
	banksel	LOCX
	movf	LOCX,W
	banksel	POSCHARX
	movwf	POSCHARX
	clrf	POSCHARX_H
;Repeat 4
	movlw	4
	banksel	SYSREPEATTEMP11
	movwf	SysRepeatTemp11
SysRepeatLoop12
;Set C off
	bcf	STATUS,C
;Rotate PosCharX Right
	banksel	POSCHARX_H
	rrf	POSCHARX_H,F
	rrf	POSCHARX,F
;End Repeat
	banksel	SYSREPEATTEMP11
	decfsz	SysRepeatTemp11,F
	goto	SysRepeatLoop12
SysRepeatLoopEnd12
;PosCharX = ( PosCharX & 0x0F ) + 0x10
	movlw	15
	banksel	POSCHARX
	andwf	POSCHARX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysTemp1_H
	movlw	16
	addwf	SysTemp1,W
	banksel	POSCHARX
	movwf	POSCHARX
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	POSCHARX_H
	movwf	POSCHARX_H
;Write_Transaction_Command_SSD1306 ( PosCharX )
;Macro Source: GLCD_SSD1306.H (1668)
;HI2CSend SSD1306SendByte
	movf	POSCHARX,W
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1734)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	pagesel	HI2CSTOP
	goto	HI2CSTOP

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:word:, Source: glcd.h (1982)
FILLEDCIRCLE39
;Circle fill Code is merely a modification of the midpoint
;circle algorithem which is an adaption of Bresenham's line algorithm
;http://en.wikipedia.org/wiki/Midpoint_circle_algorithm
;http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
;dim ff, ddF_x, ddF_y as integer
;dim YCalc2, YCalc1 as word
;ff = 1 - xradius
	banksel	XRADIUS
	movf	XRADIUS,W
	sublw	1
	banksel	FF
	movwf	FF
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	movf	XRADIUS_H,W
	subwfb	SysTemp3,W
	banksel	FF_H
	movwf	FF_H
;ddF_x = 1
	movlw	1
	movwf	DDF_X
	clrf	DDF_X_H
;ddF_y = -2 * xradius
	banksel	XRADIUS
	movf	XRADIUS,W
	movwf	SysINTEGERTempA
	movf	XRADIUS_H,W
	movwf	SysINTEGERTempA_H
	movlw	254
	movwf	SysINTEGERTempB
	movlw	255
	movwf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSMULTSUBINT
	call	SYSMULTSUBINT
	pagesel	$
	movf	SysINTEGERTempX,W
	movwf	DDF_Y
	movf	SysINTEGERTempX_H,W
	movwf	DDF_Y_H
;FillCircleXX = 0
	clrf	FILLCIRCLEXX
;FillCircleYY = xradius
	banksel	XRADIUS
	movf	XRADIUS,W
	banksel	FILLCIRCLEYY
	movwf	FILLCIRCLEYY
;Fill in the center between the two halves
;YCalc2 = yoffset+xradius
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	YOFFSET,W
	movwf	YCALC2
	movf	XRADIUS_H,W
	addwfc	YOFFSET_H,W
	movwf	YCALC2_H
;YCalc1 = yoffset-xradius
	movf	XRADIUS,W
	subwf	YOFFSET,W
	movwf	YCALC1
	movf	XRADIUS_H,W
	subwfb	YOFFSET_H,W
	movwf	YCALC1_H
;Line( xoffset, YCalc1 , xoffset, YCalc2, LineColour)
	movf	XOFFSET,W
	banksel	LINEX1
	movwf	LINEX1
	banksel	XOFFSET_H
	movf	XOFFSET_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	YCALC1
	movf	YCALC1,W
	banksel	LINEY1
	movwf	LINEY1
	banksel	YCALC1_H
	movf	YCALC1_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	XOFFSET
	movf	XOFFSET,W
	banksel	LINEX2
	movwf	LINEX2
	banksel	XOFFSET_H
	movf	XOFFSET_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	YCALC2
	movf	YCALC2,W
	banksel	LINEY2
	movwf	LINEY2
	banksel	YCALC2_H
	movf	YCALC2_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	call	LINE_SSD1306
;do while (FillCircleXX < FillCircleYY)
SysDoLoop_S8
	movf	FILLCIRCLEYY,W
	subwf	FILLCIRCLEXX,W
	btfsc	STATUS, C
	goto	SysDoLoop_E8
;if ff >= 0 then
	movf	FF,W
	movwf	SysINTEGERTempA
	movf	FF_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	pagesel	SYSCOMPLESSTHANINT
	call	SYSCOMPLESSTHANINT
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF59
;FillCircleYY--
	decf	FILLCIRCLEYY,F
;ddF_y += 2
	movlw	2
	addwf	DDF_Y,F
	movlw	0
	addwfc	DDF_Y_H,F
;ff += ddF_y
	movf	DDF_Y,W
	addwf	FF,F
	movf	DDF_Y_H,W
	addwfc	FF_H,F
;end if
ENDIF59
;FillCircleXX++
	incf	FILLCIRCLEXX,F
;ddF_x += 2
	movlw	2
	addwf	DDF_X,F
	movlw	0
	addwfc	DDF_X_H,F
;ff += ddF_x
	movf	DDF_X,W
	addwf	FF,F
	movf	DDF_X_H,W
	addwfc	FF_H,F
;Now draw vertical lines between the points on the circle rather than
;draw the points of the circle. This draws lines between the
;perimeter points on the upper and lower quadrants of the 2 halves of the circle.
;Line(xoffset+FillCircleXX, yoffset+FillCircleYY, xoffset+FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	banksel	LINEX1
	movwf	LINEX1
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	call	LINE_SSD1306
;Line(xoffset-FillCircleXX, yoffset+FillCircleYY, xoffset-FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	banksel	LINEX1
	movwf	LINEX1
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	call	LINE_SSD1306
;Line(xoffset+FillCircleYY, yoffset+FillCircleXX, FillCircleYY+xoffset, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	banksel	LINEX1
	movwf	LINEX1
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	XOFFSET
	movf	XOFFSET,W
	banksel	FILLCIRCLEYY
	addwf	FILLCIRCLEYY,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	movf	XOFFSET_H,W
	addwfc	SysTemp3,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	call	LINE_SSD1306
;Line(xoffset-FillCircleYY, yoffset+FillCircleXX, xoffset-FillCircleYY, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	banksel	LINEX1
	movwf	LINEX1
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	call	LINE_SSD1306
;loop
	goto	SysDoLoop_S8
SysDoLoop_E8
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (1275)
LINE_SSD1306
;If LineY1 = LineY2 Then
	banksel	LINEY1
	movf	LINEY1,W
	movwf	SysWORDTempA
	movf	LINEY1_H,W
	movwf	SysWORDTempA_H
	movf	LINEY2,W
	movwf	SysWORDTempB
	movf	LINEY2_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPEQUAL16
	call	SYSCOMPEQUAL16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF146
;If LineX1 <= LineX2 Then
	banksel	LINEX1
	movf	LINEX1,W
	movwf	SysWORDTempB
	movf	LINEX1_H,W
	movwf	SysWORDTempB_H
	movf	LINEX2,W
	movwf	SysWORDTempA
	movf	LINEX2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ELSE151_1
;SSD1306_HLine ( LineX1, LineX2, LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	HLX1
	movwf	HLX1
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	HLX1_H
	movwf	HLX1_H
	banksel	LINEX2
	movf	LINEX2,W
	banksel	HLX2
	movwf	HLX2
	banksel	LINEX2_H
	movf	LINEX2_H,W
	banksel	HLX2_H
	movwf	HLX2_H
	banksel	LINEY1
	movf	LINEY1,W
	banksel	HLY
	movwf	HLY
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	HLY_H
	movwf	HLY_H
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	HLCOLOUR
	movwf	HLCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	HLCOLOUR_H
	movwf	HLCOLOUR_H
	banksel	STATUS
	pagesel	SSD1306_HLINE
	call	SSD1306_HLINE
	pagesel	$
;Else
	goto	ENDIF151
ELSE151_1
;SSD1306_HLine ( LineX2, LineX1, LineY1, LineColour )
	banksel	LINEX2
	movf	LINEX2,W
	banksel	HLX1
	movwf	HLX1
	banksel	LINEX2_H
	movf	LINEX2_H,W
	banksel	HLX1_H
	movwf	HLX1_H
	banksel	LINEX1
	movf	LINEX1,W
	banksel	HLX2
	movwf	HLX2
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	HLX2_H
	movwf	HLX2_H
	banksel	LINEY1
	movf	LINEY1,W
	banksel	HLY
	movwf	HLY
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	HLY_H
	movwf	HLY_H
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	HLCOLOUR
	movwf	HLCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	HLCOLOUR_H
	movwf	HLCOLOUR_H
	banksel	STATUS
	pagesel	SSD1306_HLINE
	call	SSD1306_HLINE
	pagesel	$
;End If
ENDIF151
;Exit Sub
	return
;End If
ENDIF146
;If LineX1 = LineX2 Then
	banksel	LINEX1
	movf	LINEX1,W
	movwf	SysWORDTempA
	movf	LINEX1_H,W
	movwf	SysWORDTempA_H
	movf	LINEX2,W
	movwf	SysWORDTempB
	movf	LINEX2_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPEQUAL16
	call	SYSCOMPEQUAL16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF147
;If LineY1 <= LineY2 Then
	banksel	LINEY1
	movf	LINEY1,W
	movwf	SysWORDTempB
	movf	LINEY1_H,W
	movwf	SysWORDTempB_H
	movf	LINEY2,W
	movwf	SysWORDTempA
	movf	LINEY2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ELSE152_1
;SSD1306_VLine ( LineX1, LineY1, LineY2, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	VLX
	movwf	VLX
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	VLX_H
	movwf	VLX_H
	banksel	LINEY1
	movf	LINEY1,W
	banksel	VLY1
	movwf	VLY1
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	VLY1_H
	movwf	VLY1_H
	banksel	LINEY2
	movf	LINEY2,W
	banksel	VLY2
	movwf	VLY2
	banksel	LINEY2_H
	movf	LINEY2_H,W
	banksel	VLY2_H
	movwf	VLY2_H
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	VLCOLOUR
	movwf	VLCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	VLCOLOUR_H
	movwf	VLCOLOUR_H
	banksel	STATUS
	pagesel	SSD1306_VLINE
	call	SSD1306_VLINE
	pagesel	$
;Else
	goto	ENDIF152
ELSE152_1
;SSD1306_VLine ( LineX1, LineY2, LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	VLX
	movwf	VLX
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	VLX_H
	movwf	VLX_H
	banksel	LINEY2
	movf	LINEY2,W
	banksel	VLY1
	movwf	VLY1
	banksel	LINEY2_H
	movf	LINEY2_H,W
	banksel	VLY1_H
	movwf	VLY1_H
	banksel	LINEY1
	movf	LINEY1,W
	banksel	VLY2
	movwf	VLY2
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	VLY2_H
	movwf	VLY2_H
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	VLCOLOUR
	movwf	VLCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	VLCOLOUR_H
	movwf	VLCOLOUR_H
	banksel	STATUS
	pagesel	SSD1306_VLINE
	call	SSD1306_VLINE
	pagesel	$
;End If
ENDIF152
;Exit Sub
	return
;End If
ENDIF147
;any other line, or low-memory mode: as glcd.h Line, through PSet
;dim SSD1306_LineStepX, SSD1306_LineStepY as integer
;dim SSD1306_LineDiffX, SSD1306_LineDiffY as integer
;dim SSD1306_LineDiffX_x2, SSD1306_LineDiffY_x2 as integer
;dim SSD1306_LineErr as integer
;SSD1306_LineDiffX = LineX2 - LineX1
	banksel	LINEX1
	movf	LINEX1,W
	subwf	LINEX2,W
	banksel	SSD1306_LINEDIFFX
	movwf	SSD1306_LINEDIFFX
	banksel	LINEX1_H
	movf	LINEX1_H,W
	subwfb	LINEX2_H,W
	banksel	SSD1306_LINEDIFFX_H
	movwf	SSD1306_LINEDIFFX_H
;SSD1306_LineDiffY = LineY2 - LineY1
	banksel	LINEY1
	movf	LINEY1,W
	subwf	LINEY2,W
	banksel	SSD1306_LINEDIFFY
	movwf	SSD1306_LINEDIFFY
	banksel	LINEY1_H
	movf	LINEY1_H,W
	subwfb	LINEY2_H,W
	banksel	SSD1306_LINEDIFFY_H
	movwf	SSD1306_LINEDIFFY_H
;if (SSD1306_LineDiffX > 0) then
	movf	SSD1306_LINEDIFFX,W
	movwf	SysINTEGERTempB
	movf	SSD1306_LINEDIFFX_H,W
	movwf	SysINTEGERTempB_H
	clrf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHANINT
	call	SYSCOMPLESSTHANINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE148_1
;SSD1306_LineStepX = 1
	movlw	1
	banksel	SSD1306_LINESTEPX
	movwf	SSD1306_LINESTEPX
	clrf	SSD1306_LINESTEPX_H
;else
	goto	ENDIF148
ELSE148_1
;SSD1306_LineStepX = -1
	movlw	255
	banksel	SSD1306_LINESTEPX
	movwf	SSD1306_LINESTEPX
	movwf	SSD1306_LINESTEPX_H
;end if
ENDIF148
;if (SSD1306_LineDiffY > 0) then
	movf	SSD1306_LINEDIFFY,W
	movwf	SysINTEGERTempB
	movf	SSD1306_LINEDIFFY_H,W
	movwf	SysINTEGERTempB_H
	clrf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHANINT
	call	SYSCOMPLESSTHANINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE149_1
;SSD1306_LineStepY = 1
	movlw	1
	banksel	SSD1306_LINESTEPY
	movwf	SSD1306_LINESTEPY
	clrf	SSD1306_LINESTEPY_H
;else
	goto	ENDIF149
ELSE149_1
;SSD1306_LineStepY = -1
	movlw	255
	banksel	SSD1306_LINESTEPY
	movwf	SSD1306_LINESTEPY
	movwf	SSD1306_LINESTEPY_H
;end if
ENDIF149
;SSD1306_LineDiffX = SSD1306_LineStepX * SSD1306_LineDiffX
	movf	SSD1306_LINESTEPX,W
	movwf	SysINTEGERTempA
	movf	SSD1306_LINESTEPX_H,W
	movwf	SysINTEGERTempA_H
	movf	SSD1306_LINEDIFFX,W
	movwf	SysINTEGERTempB
	movf	SSD1306_LINEDIFFX_H,W
	movwf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSMULTSUBINT
	call	SYSMULTSUBINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	SSD1306_LINEDIFFX
	movwf	SSD1306_LINEDIFFX
	movf	SysINTEGERTempX_H,W
	movwf	SSD1306_LINEDIFFX_H
;SSD1306_LineDiffY = SSD1306_LineStepY * SSD1306_LineDiffY
	movf	SSD1306_LINESTEPY,W
	movwf	SysINTEGERTempA
	movf	SSD1306_LINESTEPY_H,W
	movwf	SysINTEGERTempA_H
	movf	SSD1306_LINEDIFFY,W
	movwf	SysINTEGERTempB
	movf	SSD1306_LINEDIFFY_H,W
	movwf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSMULTSUBINT
	call	SYSMULTSUBINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	SSD1306_LINEDIFFY
	movwf	SSD1306_LINEDIFFY
	movf	SysINTEGERTempX_H,W
	movwf	SSD1306_LINEDIFFY_H
;SSD1306_LineDiffX_x2 = SSD1306_LineDiffX * 2
	movf	SSD1306_LINEDIFFX,W
	movwf	SysINTEGERTempA
	movf	SSD1306_LINEDIFFX_H,W
	movwf	SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSMULTSUBINT
	call	SYSMULTSUBINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	SSD1306_LINEDIFFX_X2
	movwf	SSD1306_LINEDIFFX_X2
	movf	SysINTEGERTempX_H,W
	movwf	SSD1306_LINEDIFFX_X2_H
;SSD1306_LineDiffY_x2 = SSD1306_LineDiffY * 2
	movf	SSD1306_LINEDIFFY,W
	movwf	SysINTEGERTempA
	movf	SSD1306_LINEDIFFY_H,W
	movwf	SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSMULTSUBINT
	call	SYSMULTSUBINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	SSD1306_LINEDIFFY_X2
	movwf	SSD1306_LINEDIFFY_X2
	movf	SysINTEGERTempX_H,W
	movwf	SSD1306_LINEDIFFY_X2_H
;if ( SSD1306_LineDiffX >= SSD1306_LineDiffY ) then
	movf	SSD1306_LINEDIFFX,W
	movwf	SysINTEGERTempA
	movf	SSD1306_LINEDIFFX_H,W
	movwf	SysINTEGERTempA_H
	movf	SSD1306_LINEDIFFY,W
	movwf	SysINTEGERTempB
	movf	SSD1306_LINEDIFFY_H,W
	movwf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHANINT
	call	SYSCOMPLESSTHANINT
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ELSE150_1
;SSD1306_LineErr = SSD1306_LineDiffY_x2 - SSD1306_LineDiffX
	banksel	SSD1306_LINEDIFFX
	movf	SSD1306_LINEDIFFX,W
	subwf	SSD1306_LINEDIFFY_X2,W
	movwf	SSD1306_LINEERR
	movf	SSD1306_LINEDIFFX_H,W
	subwfb	SSD1306_LINEDIFFY_X2_H,W
	movwf	SSD1306_LINEERR_H
;do while ( LineX1 <> LineX2 )
SysDoLoop_S12
	banksel	LINEX1
	movf	linex1,W
	movwf	SysWORDTempA
	movf	linex1_H,W
	movwf	SysWORDTempA_H
	movf	linex2,W
	movwf	SysWORDTempB
	movf	linex2_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPEQUAL16
	call	SYSCOMPEQUAL16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	SysDoLoop_E12
;PSet ( LineX1, LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;LineX1 += SSD1306_LineStepX
	banksel	SSD1306_LINESTEPX
	movf	SSD1306_LINESTEPX,W
	banksel	LINEX1
	addwf	LINEX1,F
	banksel	SSD1306_LINESTEPX_H
	movf	SSD1306_LINESTEPX_H,W
	banksel	LINEX1_H
	addwfc	LINEX1_H,F
;if ( SSD1306_LineErr < 0 ) then
	banksel	SSD1306_LINEERR
	movf	SSD1306_LINEERR,W
	movwf	SysINTEGERTempA
	movf	SSD1306_LINEERR_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHANINT
	call	SYSCOMPLESSTHANINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE153_1
;SSD1306_LineErr += SSD1306_LineDiffY_x2
	banksel	SSD1306_LINEDIFFY_X2
	movf	SSD1306_LINEDIFFY_X2,W
	addwf	SSD1306_LINEERR,F
	movf	SSD1306_LINEDIFFY_X2_H,W
	addwfc	SSD1306_LINEERR_H,F
;else
	goto	ENDIF153
ELSE153_1
;SSD1306_LineErr += ( SSD1306_LineDiffY_x2 - SSD1306_LineDiffX_x2 )
	banksel	SSD1306_LINEDIFFX_X2
	movf	SSD1306_LINEDIFFX_X2,W
	subwf	SSD1306_LINEDIFFY_X2,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	SSD1306_LINEDIFFX_X2_H
	movf	SSD1306_LINEDIFFX_X2_H,W
	subwfb	SSD1306_LINEDIFFY_X2_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movf	SysTemp2,W
	banksel	SSD1306_LINEERR
	addwf	SSD1306_LINEERR,F
	banksel	SYSTEMP2_H
	movf	SysTemp2_H,W
	banksel	SSD1306_LINEERR_H
	addwfc	SSD1306_LINEERR_H,F
;LineY1 += SSD1306_LineStepY
	movf	SSD1306_LINESTEPY,W
	banksel	LINEY1
	addwf	LINEY1,F
	banksel	SSD1306_LINESTEPY_H
	movf	SSD1306_LINESTEPY_H,W
	banksel	LINEY1_H
	addwfc	LINEY1_H,F
;end if
ENDIF153
;loop
	goto	SysDoLoop_S12
SysDoLoop_E12
;PSet ( LineX1, LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;else
	goto	ENDIF150
ELSE150_1
;SSD1306_LineErr = SSD1306_LineDiffX_x2 - SSD1306_LineDiffY
	banksel	SSD1306_LINEDIFFY
	movf	SSD1306_LINEDIFFY,W
	subwf	SSD1306_LINEDIFFX_X2,W
	movwf	SSD1306_LINEERR
	movf	SSD1306_LINEDIFFY_H,W
	subwfb	SSD1306_LINEDIFFX_X2_H,W
	movwf	SSD1306_LINEERR_H
;do while ( LineY1 <> LineY2 )
SysDoLoop_S13
	banksel	LINEY1
	movf	liney1,W
	movwf	SysWORDTempA
	movf	liney1_H,W
	movwf	SysWORDTempA_H
	movf	liney2,W
	movwf	SysWORDTempB
	movf	liney2_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPEQUAL16
	call	SYSCOMPEQUAL16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	SysDoLoop_E13
;PSet ( LineX1, LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;LineY1 += SSD1306_LineStepY
	banksel	SSD1306_LINESTEPY
	movf	SSD1306_LINESTEPY,W
	banksel	LINEY1
	addwf	LINEY1,F
	banksel	SSD1306_LINESTEPY_H
	movf	SSD1306_LINESTEPY_H,W
	banksel	LINEY1_H
	addwfc	LINEY1_H,F
;if ( SSD1306_LineErr < 0 ) then
	banksel	SSD1306_LINEERR
	movf	SSD1306_LINEERR,W
	movwf	SysINTEGERTempA
	movf	SSD1306_LINEERR_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHANINT
	call	SYSCOMPLESSTHANINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE154_1
;SSD1306_LineErr += SSD1306_LineDiffX_x2
	banksel	SSD1306_LINEDIFFX_X2
	movf	SSD1306_LINEDIFFX_X2,W
	addwf	SSD1306_LINEERR,F
	movf	SSD1306_LINEDIFFX_X2_H,W
	addwfc	SSD1306_LINEERR_H,F
;else
	goto	ENDIF154
ELSE154_1
;SSD1306_LineErr += ( SSD1306_LineDiffX_x2 - SSD1306_LineDiffY_x2 )
	banksel	SSD1306_LINEDIFFY_X2
	movf	SSD1306_LINEDIFFY_X2,W
	subwf	SSD1306_LINEDIFFX_X2,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	SSD1306_LINEDIFFY_X2_H
	movf	SSD1306_LINEDIFFY_X2_H,W
	subwfb	SSD1306_LINEDIFFX_X2_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movf	SysTemp2,W
	banksel	SSD1306_LINEERR
	addwf	SSD1306_LINEERR,F
	banksel	SYSTEMP2_H
	movf	SysTemp2_H,W
	banksel	SSD1306_LINEERR_H
	addwfc	SSD1306_LINEERR_H,F
;LineX1 += SSD1306_LineStepX
	movf	SSD1306_LINESTEPX,W
	banksel	LINEX1
	addwf	LINEX1,F
	banksel	SSD1306_LINESTEPX_H
	movf	SSD1306_LINESTEPX_H,W
	banksel	LINEX1_H
	addwfc	LINEX1_H,F
;end if
ENDIF154
;loop
	goto	SysDoLoop_S13
SysDoLoop_E13
;PSet ( LineX1, LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;end if
ENDIF150
	return

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (276)
MOVEBALL
;RegX1 = OX : If NX < RegX1 Then RegX1 = NX
	banksel	OX
	movf	OX,W
	movwf	REGX1
;RegX1 = OX : If NX < RegX1 Then RegX1 = NX
	subwf	NX,W
	btfsc	STATUS, C
	goto	ENDIF19
;RegX1 = OX : If NX < RegX1 Then RegX1 = NX
	movf	NX,W
	movwf	REGX1
;RegX1 = OX : If NX < RegX1 Then RegX1 = NX
ENDIF19
;RegX2 = OX : If NX > RegX2 Then RegX2 = NX
	movf	OX,W
	movwf	REGX2
;RegX2 = OX : If NX > RegX2 Then RegX2 = NX
	movf	NX,W
	subwf	REGX2,W
	btfsc	STATUS, C
	goto	ENDIF20
;RegX2 = OX : If NX > RegX2 Then RegX2 = NX
	movf	NX,W
	movwf	REGX2
;RegX2 = OX : If NX > RegX2 Then RegX2 = NX
ENDIF20
;RegX1 -= 5 : RegX2 += 5
	movlw	5
	subwf	REGX1,F
;RegX1 -= 5 : RegX2 += 5
	movlw	5
	addwf	REGX2,F
;RegW = RegX2 - RegX1 + 1
	movf	REGX1,W
	subwf	REGX2,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	incf	SysTemp2,W
	banksel	REGW
	movwf	REGW
;RegP1 = OY : If NY < RegP1 Then RegP1 = NY
	movf	OY,W
	movwf	REGP1
;RegP1 = OY : If NY < RegP1 Then RegP1 = NY
	subwf	NY,W
	btfsc	STATUS, C
	goto	ENDIF21
;RegP1 = OY : If NY < RegP1 Then RegP1 = NY
	movf	NY,W
	movwf	REGP1
;RegP1 = OY : If NY < RegP1 Then RegP1 = NY
ENDIF21
;RegP2 = OY : If NY > RegP2 Then RegP2 = NY
	movf	OY,W
	movwf	REGP2
;RegP2 = OY : If NY > RegP2 Then RegP2 = NY
	movf	NY,W
	subwf	REGP2,W
	btfsc	STATUS, C
	goto	ENDIF22
;RegP2 = OY : If NY > RegP2 Then RegP2 = NY
	movf	NY,W
	movwf	REGP2
;RegP2 = OY : If NY > RegP2 Then RegP2 = NY
ENDIF22
;RegP1 = (RegP1 - 5) / 8
	movlw	5
	subwf	REGP1,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SYSDIVSUB
	call	SYSDIVSUB
	pagesel	$
	movf	SysBYTETempA,W
	banksel	REGP1
	movwf	REGP1
;RegP2 = (RegP2 + 5) / 8
	movlw	5
	addwf	REGP2,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SYSDIVSUB
	call	SYSDIVSUB
	pagesel	$
	movf	SysBYTETempA,W
	banksel	REGP2
	movwf	REGP2
;the region from the screen buffer
;RegIndex = 1
	movlw	1
	movwf	REGINDEX
	clrf	REGINDEX_H
;For RegPage = RegP1 To RegP2
;Legacy method
	decf	REGP1,W
	movwf	REGPAGE
	movf	REGP1,W
	subwf	REGP2,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
SysForLoop3
	incf	REGPAGE,F
;RegBuffer = [Word]RegPage * GLCD_WIDTH + RegX1 + 1
	movf	REGPAGE,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	movlw	128
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSMULTSUB16
	call	SYSMULTSUB16
	pagesel	$
	banksel	REGX1
	movf	REGX1,W
	addwf	SysWORDTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	addwfc	SysWORDTempX_H,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	banksel	REGBUFFER
	movwf	REGBUFFER
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	REGBUFFER_H
	movwf	REGBUFFER_H
;For BallCol = RegX1 To RegX2
;Legacy method
	decf	REGX1,W
	banksel	BALLCOL
	movwf	BALLCOL
	banksel	REGX1
	movf	REGX1,W
	subwf	REGX2,W
	btfss	STATUS, C
	goto	SysForLoopEnd4
SysForLoop4
	banksel	BALLCOL
	incf	BALLCOL,F
;BallWork(RegIndex) = SSD1306_BufferAlias(RegBuffer)
	movlw	low(SSD1306_BUFFERALIAS)
	banksel	REGBUFFER
	addwf	REGBUFFER,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	REGBUFFER_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP2
	movwf	SysArrayTemp2
	movwf	SysArrayTemp1
	movlw	low(BALLWORK)
	banksel	REGINDEX
	addwf	REGINDEX,W
	movwf	AFSR0
	movlw	high(BALLWORK)
	addwfc	REGINDEX_H,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
;RegIndex++ : RegBuffer++
	banksel	REGINDEX
	incf	REGINDEX,F
	btfsc	STATUS,Z
	incf	REGINDEX_H,F
;RegIndex++ : RegBuffer++
	incf	REGBUFFER,F
	btfsc	STATUS,Z
	incf	REGBUFFER_H,F
;Next
	movf	REGX2,W
	banksel	BALLCOL
	subwf	BALLCOL,W
	btfss	STATUS, C
	goto	SysForLoop4
SysForLoopEnd4
;Next
	banksel	REGP2
	movf	REGP2,W
	subwf	REGPAGE,W
	btfss	STATUS, C
	goto	SysForLoop3
SysForLoopEnd3
;the old ball cleared, the new one set
;BallPixels(OX, OY, 0)
	movf	OX,W
	banksel	BX
	movwf	BX
	banksel	OY
	movf	OY,W
	banksel	BY
	movwf	BY
	clrf	BSET
	pagesel	BALLPIXELS
	call	BALLPIXELS
	pagesel	$
;BallPixels(NX, NY, 1)
	banksel	NX
	movf	NX,W
	banksel	BX
	movwf	BX
	banksel	NY
	movf	NY,W
	banksel	BY
	movwf	BY
	movlw	1
	movwf	BSET
	pagesel	BALLPIXELS
	call	BALLPIXELS
	pagesel	$
;each page: the span that changed, back in the buffer and sent in one transaction
;RegIndex = 1
	movlw	1
	banksel	REGINDEX
	movwf	REGINDEX
	clrf	REGINDEX_H
;For RegPage = RegP1 To RegP2
;Legacy method
	decf	REGP1,W
	movwf	REGPAGE
	movf	REGP1,W
	subwf	REGP2,W
	btfss	STATUS, C
	goto	SysForLoopEnd5
SysForLoop5
	incf	REGPAGE,F
;RegBuffer = [Word]RegPage * GLCD_WIDTH + RegX1 + 1
	movf	REGPAGE,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	movlw	128
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSMULTSUB16
	call	SYSMULTSUB16
	pagesel	$
	banksel	REGX1
	movf	REGX1,W
	addwf	SysWORDTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	addwfc	SysWORDTempX_H,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	banksel	REGBUFFER
	movwf	REGBUFFER
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	REGBUFFER_H
	movwf	REGBUFFER_H
;RegFirst = 255
	movlw	255
	movwf	REGFIRST
;For BallCol = RegX1 To RegX2
;Legacy method
	decf	REGX1,W
	banksel	BALLCOL
	movwf	BALLCOL
	banksel	REGX1
	movf	REGX1,W
	subwf	REGX2,W
	btfss	STATUS, C
	goto	SysForLoopEnd6
SysForLoop6
	banksel	BALLCOL
	incf	BALLCOL,F
;If BallWork(RegIndex) <> SSD1306_BufferAlias(RegBuffer) Then
	movlw	low(BALLWORK)
	banksel	REGINDEX
	addwf	REGINDEX,W
	movwf	AFSR0
	movlw	high(BALLWORK)
	addwfc	REGINDEX_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	movlw	low(SSD1306_BUFFERALIAS)
	banksel	REGBUFFER
	addwf	REGBUFFER,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	REGBUFFER_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP2
	movwf	SysArrayTemp2
	subwf	SYSARRAYTEMP1,W
	btfsc	STATUS, Z
	goto	ENDIF29
;SSD1306_BufferAlias(RegBuffer) = BallWork(RegIndex)
	movlw	low(BALLWORK)
	banksel	REGINDEX
	addwf	REGINDEX,W
	movwf	AFSR0
	movlw	high(BALLWORK)
	addwfc	REGINDEX_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	movwf	SysArrayTemp2
	movlw	low(SSD1306_BUFFERALIAS)
	banksel	REGBUFFER
	addwf	REGBUFFER,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	REGBUFFER_H,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP2
	movf	SysArrayTemp2,W
	movwf	INDF0
;If RegFirst = 255 Then RegFirst = BallCol
	banksel	REGFIRST
	incf	REGFIRST,W
	btfss	STATUS, Z
	goto	ENDIF33
;If RegFirst = 255 Then RegFirst = BallCol
	banksel	BALLCOL
	movf	BALLCOL,W
	banksel	REGFIRST
	movwf	REGFIRST
;If RegFirst = 255 Then RegFirst = BallCol
ENDIF33
;RegLast = BallCol
	banksel	BALLCOL
	movf	BALLCOL,W
	banksel	REGLAST
	movwf	REGLAST
;End If
ENDIF29
;RegIndex++ : RegBuffer++
	banksel	REGINDEX
	incf	REGINDEX,F
	btfsc	STATUS,Z
	incf	REGINDEX_H,F
;RegIndex++ : RegBuffer++
	incf	REGBUFFER,F
	btfsc	STATUS,Z
	incf	REGBUFFER_H,F
;Next
	movf	REGX2,W
	banksel	BALLCOL
	subwf	BALLCOL,W
	btfss	STATUS, C
	goto	SysForLoop6
SysForLoopEnd6
;If RegFirst <> 255 Then SSD1306_SendBufferRun(RegFirst, RegLast, RegPage)
	banksel	REGFIRST
	incf	REGFIRST,W
	btfss	STATUS, Z
;If RegFirst <> 255 Then SSD1306_SendBufferRun(RegFirst, RegLast, RegPage)
SSD1306_SENDBUFFERRUN(REGFIRST,	REGLAST,	REGPAGE) ;?F1L310S8I34?
;If RegFirst <> 255 Then SSD1306_SendBufferRun(RegFirst, RegLast, RegPage)
;Next
	movf	REGP2,W
	subwf	REGPAGE,W
	btfss	STATUS, C
	goto	SysForLoop5
SysForLoopEnd5
	banksel	STATUS
	return

;********************************************************************************

OLEDFONT1DATA
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	165
	movwf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEOLEDFONT1DATA
	movwf	SysStringA
	movlw	(high TABLEOLEDFONT1DATA) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEOLEDFONT1DATA
	retlw	165
	retlw	1
	retlw	0
	retlw	1
	retlw	94
	retlw	3
	retlw	6
	retlw	0
	retlw	6
	retlw	5
	retlw	40
	retlw	124
	retlw	40
	retlw	124
	retlw	40
	retlw	5
	retlw	36
	retlw	42
	retlw	127
	retlw	42
	retlw	16
	retlw	3
	retlw	98
	retlw	24
	retlw	70
	retlw	5
	retlw	48
	retlw	76
	retlw	90
	retlw	36
	retlw	80
	retlw	1
	retlw	6
	retlw	2
	retlw	60
	retlw	66
	retlw	2
	retlw	66
	retlw	60
	retlw	5
	retlw	40
	retlw	16
	retlw	124
	retlw	16
	retlw	40
	retlw	3
	retlw	16
	retlw	56
	retlw	16
	retlw	1
	retlw	192
	retlw	3
	retlw	16
	retlw	16
	retlw	16
	retlw	1
	retlw	64
	retlw	3
	retlw	96
	retlw	24
	retlw	6
	retlw	4
	retlw	60
	retlw	66
	retlw	66
	retlw	60
	retlw	3
	retlw	68
	retlw	126
	retlw	64
	retlw	4
	retlw	68
	retlw	98
	retlw	82
	retlw	76
	retlw	3
	retlw	74
	retlw	74
	retlw	52
	retlw	4
	retlw	30
	retlw	16
	retlw	124
	retlw	16
	retlw	3
	retlw	78
	retlw	74
	retlw	50
	retlw	4
	retlw	60
	retlw	74
	retlw	74
	retlw	48
	retlw	3
	retlw	98
	retlw	18
	retlw	14
	retlw	4
	retlw	52
	retlw	74
	retlw	74
	retlw	52
	retlw	4
	retlw	12
	retlw	82
	retlw	82
	retlw	60
	retlw	1
	retlw	72
	retlw	2
	retlw	128
	retlw	104
	retlw	3
	retlw	16
	retlw	40
	retlw	68
	retlw	3
	retlw	40
	retlw	40
	retlw	40
	retlw	3
	retlw	68
	retlw	40
	retlw	16
	retlw	3
	retlw	2
	retlw	82
	retlw	12
	retlw	5
	retlw	56
	retlw	68
	retlw	84
	retlw	84
	retlw	88
	retlw	4
	retlw	124
	retlw	18
	retlw	18
	retlw	124
	retlw	4
	retlw	126
	retlw	74
	retlw	74
	retlw	52
	retlw	4
	retlw	60
	retlw	66
	retlw	66
	retlw	36
	retlw	4
	retlw	126
	retlw	66
	retlw	66
	retlw	60
	retlw	3
	retlw	126
	retlw	74
	retlw	74
	retlw	3
	retlw	126
	retlw	10
	retlw	10
	retlw	4
	retlw	60
	retlw	66
	retlw	82
	retlw	52
	retlw	4
	retlw	126
	retlw	8
	retlw	8
	retlw	126
	retlw	3
	retlw	66
	retlw	126
	retlw	66
	retlw	3
	retlw	66
	retlw	66
	retlw	62
	retlw	4
	retlw	126
	retlw	8
	retlw	20
	retlw	98
	retlw	3
	retlw	126
	retlw	64
	retlw	64
	retlw	5
	retlw	126
	retlw	4
	retlw	8
	retlw	4
	retlw	126
	retlw	5
	retlw	126
	retlw	4
	retlw	24
	retlw	32
	retlw	126
	retlw	4
	retlw	60
	retlw	66
	retlw	66
	retlw	60
	retlw	4
	retlw	126
	retlw	18
	retlw	18
	retlw	12
	retlw	4
	retlw	60
	retlw	66
	retlw	66
	retlw	188
	retlw	4
	retlw	126
	retlw	18
	retlw	18
	retlw	108
	retlw	4
	retlw	68
	retlw	74
	retlw	74
	retlw	48
	retlw	3
	retlw	2
	retlw	126
	retlw	2
	retlw	4
	retlw	62
	retlw	64
	retlw	64
	retlw	62
	retlw	5
	retlw	6
	retlw	24
	retlw	96
	retlw	24
	retlw	6
	retlw	5
	retlw	62
	retlw	64
	retlw	62
	retlw	64
	retlw	62
	retlw	5
	retlw	66
	retlw	36
	retlw	24
	retlw	36
	retlw	66
	retlw	4
	retlw	158
	retlw	160
	retlw	160
	retlw	126
	retlw	4
	retlw	98
	retlw	82
	retlw	74
	retlw	70
	retlw	2
	retlw	126
	retlw	66
	retlw	3
	retlw	6
	retlw	24
	retlw	96
	retlw	2
	retlw	66
	retlw	126
	retlw	3
	retlw	32
	retlw	16
	retlw	32
	retlw	4
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	2
	retlw	4
	retlw	8
	retlw	4
	retlw	32
	retlw	84
	retlw	84
	retlw	120
	retlw	4
	retlw	126
	retlw	68
	retlw	68
	retlw	56
	retlw	4
	retlw	56
	retlw	68
	retlw	68
	retlw	40
	retlw	4
	retlw	56
	retlw	68
	retlw	68
	retlw	126
	retlw	4
	retlw	56
	retlw	84
	retlw	84
	retlw	88
	retlw	2
	retlw	124
	retlw	10
	retlw	4
	retlw	152
	retlw	164
	retlw	164
	retlw	124
	retlw	4
	retlw	126
	retlw	4
	retlw	4
	retlw	120
	retlw	1
	retlw	122
	retlw	2
	retlw	64
	retlw	58
	retlw	4
	retlw	126
	retlw	16
	retlw	40
	retlw	68
	retlw	1
	retlw	126
	retlw	5
	retlw	124
	retlw	4
	retlw	120
	retlw	4
	retlw	120
	retlw	4
	retlw	124
	retlw	4
	retlw	4
	retlw	120
	retlw	4
	retlw	56
	retlw	68
	retlw	68
	retlw	56
	retlw	4
	retlw	252
	retlw	36
	retlw	36
	retlw	24
	retlw	4
	retlw	24
	retlw	36
	retlw	36
	retlw	252
	retlw	2
	retlw	124
	retlw	4
	retlw	4
	retlw	72
	retlw	84
	retlw	84
	retlw	32
	retlw	3
	retlw	4
	retlw	62
	retlw	68
	retlw	4
	retlw	60
	retlw	64
	retlw	64
	retlw	60
	retlw	5
	retlw	12
	retlw	48
	retlw	64
	retlw	48
	retlw	12
	retlw	5
	retlw	60
	retlw	64
	retlw	60
	retlw	64
	retlw	60
	retlw	5
	retlw	68
	retlw	40
	retlw	16
	retlw	40
	retlw	68
	retlw	4
	retlw	156
	retlw	160
	retlw	160
	retlw	124
	retlw	3
	retlw	100
	retlw	84
	retlw	76
	retlw	3
	retlw	8
	retlw	54
	retlw	65
	retlw	1
	retlw	255
	retlw	3
	retlw	65
	retlw	54
	retlw	8
	retlw	4
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	1

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (198)
SHOWBOUNCE
;DrawTitle("4 Bounce")
	movlw	low StringTable13
	banksel	SYSTITLETEXTHANDLER
	movwf	SysTITLETEXTHandler
	movlw	(high StringTable13) | 128
	movwf	SysTITLETEXTHandler_H
	banksel	STATUS
	pagesel	DRAWTITLE
	call	DRAWTITLE
	pagesel	$
;GLCDPrint(78, 0, "fps")
	movlw	78
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable14
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable14) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT22
	call	GLCDPRINT22
	pagesel	$
;Box(0, 11, 127, 63)
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	movlw	11
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	127
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	63
	movwf	LINEY2
	clrf	LINEY2_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	pagesel	BOX_SSD1306
	call	BOX_SSD1306
	pagesel	$
;BallX = 20 : BallY = 30 : BallRight = 1 : BallDown = 1
	movlw	20
	movwf	BALLX
;BallX = 20 : BallY = 30 : BallRight = 1 : BallDown = 1
	movlw	30
	movwf	BALLY
;BallX = 20 : BallY = 30 : BallRight = 1 : BallDown = 1
	movlw	1
	movwf	BALLRIGHT
;BallX = 20 : BallY = 30 : BallRight = 1 : BallDown = 1
	movlw	1
	movwf	BALLDOWN
;DrawBall(BallX, BallY)
	movf	BALLX,W
	movwf	DBX
	movf	BALLY,W
	movwf	DBY
	pagesel	DRAWBALL
	call	DRAWBALL
	pagesel	$
;FramesSec = 0 : FpsShown = 0
	clrf	FRAMESSEC
	clrf	FRAMESSEC_H
;FramesSec = 0 : FpsShown = 0
	clrf	FPSSHOWN
	clrf	FPSSHOWN_H
;TicksSec = 0 : TicksTotal = 0
	banksel	TICKSSEC
	clrf	TICKSSEC
	clrf	TICKSSEC_H
	clrf	TICKSSEC_U
	clrf	TICKSSEC_E
;TicksSec = 0 : TicksTotal = 0
	clrf	TICKSTOTAL
	clrf	TICKSTOTAL_H
	clrf	TICKSTOTAL_U
	clrf	TICKSTOTAL_E
;TimeStart
	banksel	STATUS
	pagesel	TIMESTART
	call	TIMESTART
	pagesel	$
;TickLast = 0
	banksel	TICKLAST
	clrf	TICKLAST
	clrf	TICKLAST_H
;ShowDigits(54, 0, 0)
	movlw	54
	banksel	DIGITX
	movwf	DIGITX
	clrf	DIGITX_H
	clrf	DIGITY
	clrf	DIGITY_H
	clrf	DIGITIN
	clrf	DIGITIN_H
	pagesel	SHOWDIGITS
	call	SHOWDIGITS
	pagesel	$
;Do While TicksTotal < [Long]TICKS_SECOND * 4    ' 4 s
SysDoLoop_S3
	banksel	TICKSTOTAL
	movf	tickstotal,W
	movwf	SysLONGTempA
	movf	tickstotal_H,W
	movwf	SysLONGTempA_H
	movf	tickstotal_U,W
	movwf	SysLONGTempA_U
	movf	tickstotal_E,W
	movwf	SysLONGTempA_E
	movlw	72
	movwf	SysLONGTempB
	movlw	232
	movwf	SysLONGTempB_H
	movlw	1
	movwf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN32
	call	SYSCOMPLESSTHAN32
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysDoLoop_E3
;OldX = BallX : OldY = BallY
	movf	BALLX,W
	banksel	OLDX
	movwf	OLDX
;OldX = BallX : OldY = BallY
	banksel	BALLY
	movf	BALLY,W
	banksel	OLDY
	movwf	OLDY
;move: 2 pixels across, 1 down, and bounce off the box (inside x 1..126, y 12..62)
;If BallRight = 1 Then
	banksel	BALLRIGHT
	decf	BALLRIGHT,W
	btfss	STATUS, Z
	goto	ELSE8_1
;BallX += 2
	movlw	2
	addwf	BALLX,F
;If BallX >= 119 Then BallRight = 0
	movlw	119
	subwf	BALLX,W
	btfsc	STATUS, C
;If BallX >= 119 Then BallRight = 0
	clrf	BALLRIGHT
;If BallX >= 119 Then BallRight = 0
;Else
	goto	ENDIF8
ELSE8_1
;BallX -= 2
	movlw	2
	subwf	BALLX,F
;If BallX <= 8 Then BallRight = 1
	movf	BALLX,W
	sublw	8
	btfss	STATUS, C
	goto	ENDIF13
;If BallX <= 8 Then BallRight = 1
	movlw	1
	movwf	BALLRIGHT
;If BallX <= 8 Then BallRight = 1
ENDIF13
;End If
ENDIF8
;If BallDown = 1 Then
	decf	BALLDOWN,W
	btfss	STATUS, Z
	goto	ELSE9_1
;BallY++
	incf	BALLY,F
;If BallY >= 56 Then BallDown = 0
	movlw	56
	subwf	BALLY,W
	btfsc	STATUS, C
;If BallY >= 56 Then BallDown = 0
	clrf	BALLDOWN
;If BallY >= 56 Then BallDown = 0
;Else
	goto	ENDIF9
ELSE9_1
;BallY--
	decf	BALLY,F
;If BallY <= 18 Then BallDown = 1
	movf	BALLY,W
	sublw	18
	btfss	STATUS, C
	goto	ENDIF15
;If BallY <= 18 Then BallDown = 1
	movlw	1
	movwf	BALLDOWN
;If BallY <= 18 Then BallDown = 1
ENDIF15
;End If
ENDIF9
;MoveBall(OldX, OldY, BallX, BallY)
	banksel	OLDX
	movf	OLDX,W
	movwf	OX
	movf	OLDY,W
	movwf	OY
	banksel	BALLX
	movf	BALLX,W
	banksel	NX
	movwf	NX
	banksel	BALLY
	movf	BALLY,W
	banksel	NY
	movwf	NY
	banksel	STATUS
	call	MOVEBALL
;FramesSec++
	incf	FRAMESSEC,F
	btfsc	STATUS,Z
	incf	FRAMESSEC_H,F
;If SwitchPressed = 1 Then Exit Sub
	pagesel	FN_SWITCHPRESSED
	call	FN_SWITCHPRESSED
	pagesel	$
	banksel	SWITCHPRESSED
	decf	SWITCHPRESSED,W
	btfss	STATUS, Z
	goto	ENDIF10
;If SwitchPressed = 1 Then Exit Sub
	banksel	STATUS
	return
;If SwitchPressed = 1 Then Exit Sub
ENDIF10
;elapsed time: reading TMR0L latches TMR0H; a Word difference is right across an overflow
;TickNow = TMR0L
	banksel	TMR0L
	movf	TMR0L,W
	banksel	TICKNOW
	movwf	TICKNOW
	clrf	TICKNOW_H
;TickNow_H = TMR0H
	banksel	TMR0H
	movf	TMR0H,W
	banksel	TICKNOW_H
	movwf	TICKNOW_H
;TickDelta = TickNow - TickLast
	movf	TICKLAST,W
	subwf	TICKNOW,W
	movwf	TICKDELTA
	movf	TICKLAST_H,W
	subwfb	TICKNOW_H,W
	movwf	TICKDELTA_H
;TickLast = TickNow
	movf	TICKNOW,W
	movwf	TICKLAST
	movf	TICKNOW_H,W
	movwf	TICKLAST_H
;TicksSec += TickDelta
	movf	TICKDELTA,W
	addwf	TICKSSEC,F
	movf	TICKDELTA_H,W
	addwfc	TICKSSEC_H,F
	movlw	0
	addwfc	TICKSSEC_U,F
	movlw	0
	addwfc	TICKSSEC_E,F
;TicksTotal += TickDelta
	movf	TICKDELTA,W
	addwf	TICKSTOTAL,F
	movf	TICKDELTA_H,W
	addwfc	TICKSTOTAL_H,F
	movlw	0
	addwfc	TICKSTOTAL_U,F
	movlw	0
	addwfc	TICKSTOTAL_E,F
;If TicksSec >= TICKS_SECOND Then            ' once a second: frames x counts a second / counts
	movf	TICKSSEC,W
	movwf	SysLONGTempA
	movf	TICKSSEC_H,W
	movwf	SysLONGTempA_H
	movf	TICKSSEC_U,W
	movwf	SysLONGTempA_U
	movf	TICKSSEC_E,W
	movwf	SysLONGTempA_E
	movlw	18
	movwf	SysLONGTempB
	movlw	122
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN32
	call	SYSCOMPLESSTHAN32
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF11
;FpsCalc = FramesSec
	movf	FRAMESSEC,W
	movwf	FPSCALC
	movf	FRAMESSEC_H,W
	movwf	FPSCALC_H
	clrf	FPSCALC_U
	clrf	FPSCALC_E
;FpsCalc = FpsCalc * TICKS_SECOND
	movf	FPSCALC,W
	movwf	SysLONGTempA
	movf	FPSCALC_H,W
	movwf	SysLONGTempA_H
	movf	FPSCALC_U,W
	movwf	SysLONGTempA_U
	movf	FPSCALC_E,W
	movwf	SysLONGTempA_E
	movlw	18
	movwf	SysLONGTempB
	movlw	122
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SYSMULTSUB32
	call	SYSMULTSUB32
	pagesel	$
	movf	SysLONGTempX,W
	movwf	FPSCALC
	movf	SysLONGTempX_H,W
	movwf	FPSCALC_H
	movf	SysLONGTempX_U,W
	movwf	FPSCALC_U
	movf	SysLONGTempX_E,W
	movwf	FPSCALC_E
;FpsCalc = FpsCalc / TicksSec
	movf	FPSCALC,W
	movwf	SysLONGTempA
	movf	FPSCALC_H,W
	movwf	SysLONGTempA_H
	movf	FPSCALC_U,W
	movwf	SysLONGTempA_U
	movf	FPSCALC_E,W
	movwf	SysLONGTempA_E
	banksel	TICKSSEC
	movf	TICKSSEC,W
	movwf	SysLONGTempB
	movf	TICKSSEC_H,W
	movwf	SysLONGTempB_H
	movf	TICKSSEC_U,W
	movwf	SysLONGTempB_U
	movf	TICKSSEC_E,W
	movwf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSDIVSUB32
	call	SYSDIVSUB32
	pagesel	$
	movf	SysLONGTempA,W
	movwf	FPSCALC
	movf	SysLONGTempA_H,W
	movwf	FPSCALC_H
	movf	SysLONGTempA_U,W
	movwf	FPSCALC_U
	movf	SysLONGTempA_E,W
	movwf	FPSCALC_E
;FpsShown = FpsCalc
	movf	FPSCALC,W
	movwf	FPSSHOWN
	movf	FPSCALC_H,W
	movwf	FPSSHOWN_H
;ShowDigits(54, 0, FpsShown)
	movlw	54
	movwf	DIGITX
	clrf	DIGITX_H
	clrf	DIGITY
	clrf	DIGITY_H
	movf	FPSSHOWN,W
	movwf	DIGITIN
	movf	FPSSHOWN_H,W
	movwf	DIGITIN_H
	pagesel	SHOWDIGITS
	call	SHOWDIGITS
	pagesel	$
;FramesSec = 0
	clrf	FRAMESSEC
	clrf	FRAMESSEC_H
;TicksSec = 0
	banksel	TICKSSEC
	clrf	TICKSSEC
	clrf	TICKSSEC_H
	clrf	TICKSSEC_U
	clrf	TICKSSEC_E
;End If
ENDIF11
;Loop
	goto	SysDoLoop_S3
SysDoLoop_E3
	return

;********************************************************************************

;Program_memory_page: 3
	ORG	6144
;Source: SSD1306_Demo_16F18326.gcb (315)
BALLPIXELS
;BallTop = BY - 5
	movlw	5
	subwf	BY,W
	movwf	BALLTOP
;For BallRow = 1 To 11
;Legacy method
	clrf	BALLROW
SysForLoop7
	incf	BALLROW,F
;ReadTable BallHalfWidth, BallRow, BallHalf
	movf	BALLROW,W
	movwf	SYSSTRINGA
	pagesel	BALLHALFWIDTH
	call	BALLHALFWIDTH
	pagesel	$
	movwf	BALLHALF
;RegY = BallTop + BallRow - 1
	movf	BALLROW,W
	addwf	BALLTOP,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	decf	SysTemp2,W
	banksel	REGY
	movwf	REGY
;RegPage = RegY / 8
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SYSDIVSUB
	call	SYSDIVSUB
	pagesel	$
	movf	SysBYTETempA,W
	banksel	REGPAGE
	movwf	REGPAGE
;ReadTable BitOfRow, (RegY And 7) + 1, RegBit
	movlw	7
	andwf	REGY,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	incf	SysTemp2,W
	movwf	SYSSTRINGA
	banksel	STATUS
	pagesel	BITOFROW
	call	BITOFROW
	pagesel	$
	banksel	REGBIT
	movwf	REGBIT
;RegIndex = (RegPage - RegP1) * RegW + BX - BallHalf - RegX1 + 1
	movf	REGP1,W
	subwf	REGPAGE,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movwf	SysBYTETempA
	banksel	REGW
	movf	REGW,W
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SYSMULTSUB
	call	SYSMULTSUB
	pagesel	$
	movf	BX,W
	addwf	SysBYTETempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysTemp1_H
	btfsc	STATUS,C
	incf	SysTemp1_H,F
	banksel	BALLHALF
	movf	BALLHALF,W
	banksel	SYSTEMP1
	subwf	SysTemp1,W
	movwf	SysTemp2
	movlw	0
	subwfb	SysTemp1_H,W
	movwf	SysTemp2_H
	banksel	REGX1
	movf	REGX1,W
	banksel	SYSTEMP2
	subwf	SysTemp2,W
	movwf	SysTemp1
	movlw	0
	subwfb	SysTemp2_H,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	banksel	REGINDEX
	movwf	REGINDEX
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	REGINDEX_H
	movwf	REGINDEX_H
;For BallCol = BX - BallHalf To BX + BallHalf
;Legacy method
	banksel	BALLHALF
	movf	BALLHALF,W
	subwf	BX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	decf	SysTemp3,W
	banksel	BALLCOL
	movwf	BALLCOL
	movf	BALLHALF,W
	subwf	BX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	BALLHALF
	movf	BALLHALF,W
	addwf	BX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	movf	SysTemp2,W
	movwf	SysBYTETempB
	movf	SysTemp3,W
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd8
SysForLoop8
	incf	BALLCOL,F
;If BSet = 1 Then
	decf	BSET,W
	btfss	STATUS, Z
	goto	ELSE35_1
;BallWork(RegIndex) = BallWork(RegIndex) Or RegBit
	movlw	low(BALLWORK)
	banksel	REGINDEX
	addwf	REGINDEX,W
	movwf	AFSR0
	movlw	high(BALLWORK)
	addwfc	REGINDEX_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP2
	movwf	SysArrayTemp2
	banksel	REGBIT
	iorwf	REGBIT,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	movlw	low(BALLWORK)
	banksel	REGINDEX
	addwf	REGINDEX,W
	movwf	AFSR0
	movlw	high(BALLWORK)
	addwfc	REGINDEX_H,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
;Else
	goto	ENDIF35
ELSE35_1
;BallWork(RegIndex) = BallWork(RegIndex) And Not RegBit
	movlw	low(BALLWORK)
	banksel	REGINDEX
	addwf	REGINDEX,W
	movwf	AFSR0
	movlw	high(BALLWORK)
	addwfc	REGINDEX_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP2
	movwf	SysArrayTemp2
	banksel	REGBIT
	comf	REGBIT,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	SYSARRAYTEMP2
	movf	SysArrayTemp2,W
	banksel	SYSTEMP3
	andwf	SysTemp3,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	movlw	low(BALLWORK)
	banksel	REGINDEX
	addwf	REGINDEX,W
	movwf	AFSR0
	movlw	high(BALLWORK)
	addwfc	REGINDEX_H,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
;End If
ENDIF35
;RegIndex++
	banksel	REGINDEX
	incf	REGINDEX,F
	btfsc	STATUS,Z
	incf	REGINDEX_H,F
;Next
	banksel	BALLHALF
	movf	BALLHALF,W
	addwf	BX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	BALLCOL
	movf	BALLCOL,W
	movwf	SysBYTETempA
	banksel	SYSTEMP2
	movf	SysTemp2,W
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop8
SysForLoopEnd8
;Next
	movlw	11
	subwf	BALLROW,W
	btfss	STATUS, C
	goto	SysForLoop7
SysForLoopEnd7
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (1352)
BOX_SSD1306
;dim SSD1306_BoxTemp as word
;If LineX1 > LineX2 Then
	banksel	LINEX1
	movf	LINEX1,W
	movwf	SysWORDTempB
	movf	LINEX1_H,W
	movwf	SysWORDTempB_H
	movf	LINEX2,W
	movwf	SysWORDTempA
	movf	LINEX2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF155
;SSD1306_BoxTemp = LineX1
	banksel	LINEX1
	movf	LINEX1,W
	banksel	SSD1306_BOXTEMP
	movwf	SSD1306_BOXTEMP
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	SSD1306_BOXTEMP_H
	movwf	SSD1306_BOXTEMP_H
;LineX1 = LineX2
	banksel	LINEX2
	movf	LINEX2,W
	movwf	LINEX1
	movf	LINEX2_H,W
	movwf	LINEX1_H
;LineX2 = SSD1306_BoxTemp
	banksel	SSD1306_BOXTEMP
	movf	SSD1306_BOXTEMP,W
	banksel	LINEX2
	movwf	LINEX2
	banksel	SSD1306_BOXTEMP_H
	movf	SSD1306_BOXTEMP_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
;End If
ENDIF155
;If LineY1 > LineY2 Then
	banksel	LINEY1
	movf	LINEY1,W
	movwf	SysWORDTempB
	movf	LINEY1_H,W
	movwf	SysWORDTempB_H
	movf	LINEY2,W
	movwf	SysWORDTempA
	movf	LINEY2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF156
;SSD1306_BoxTemp = LineY1
	banksel	LINEY1
	movf	LINEY1,W
	banksel	SSD1306_BOXTEMP
	movwf	SSD1306_BOXTEMP
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	SSD1306_BOXTEMP_H
	movwf	SSD1306_BOXTEMP_H
;LineY1 = LineY2
	banksel	LINEY2
	movf	LINEY2,W
	movwf	LINEY1
	movf	LINEY2_H,W
	movwf	LINEY1_H
;LineY2 = SSD1306_BoxTemp
	banksel	SSD1306_BOXTEMP
	movf	SSD1306_BOXTEMP,W
	banksel	LINEY2
	movwf	LINEY2
	banksel	SSD1306_BOXTEMP_H
	movf	SSD1306_BOXTEMP_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
;End If
ENDIF156
;SSD1306_HLine ( LineX1, LineX2, LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	HLX1
	movwf	HLX1
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	HLX1_H
	movwf	HLX1_H
	banksel	LINEX2
	movf	LINEX2,W
	banksel	HLX2
	movwf	HLX2
	banksel	LINEX2_H
	movf	LINEX2_H,W
	banksel	HLX2_H
	movwf	HLX2_H
	banksel	LINEY1
	movf	LINEY1,W
	banksel	HLY
	movwf	HLY
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	HLY_H
	movwf	HLY_H
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	HLCOLOUR
	movwf	HLCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	HLCOLOUR_H
	movwf	HLCOLOUR_H
	banksel	STATUS
	pagesel	SSD1306_HLINE
	call	SSD1306_HLINE
	pagesel	$
;SSD1306_HLine ( LineX1, LineX2, LineY2, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	HLX1
	movwf	HLX1
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	HLX1_H
	movwf	HLX1_H
	banksel	LINEX2
	movf	LINEX2,W
	banksel	HLX2
	movwf	HLX2
	banksel	LINEX2_H
	movf	LINEX2_H,W
	banksel	HLX2_H
	movwf	HLX2_H
	banksel	LINEY2
	movf	LINEY2,W
	banksel	HLY
	movwf	HLY
	banksel	LINEY2_H
	movf	LINEY2_H,W
	banksel	HLY_H
	movwf	HLY_H
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	HLCOLOUR
	movwf	HLCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	HLCOLOUR_H
	movwf	HLCOLOUR_H
	banksel	STATUS
	pagesel	SSD1306_HLINE
	call	SSD1306_HLINE
	pagesel	$
;SSD1306_VLine ( LineX1, LineY1, LineY2, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	VLX
	movwf	VLX
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	VLX_H
	movwf	VLX_H
	banksel	LINEY1
	movf	LINEY1,W
	banksel	VLY1
	movwf	VLY1
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	VLY1_H
	movwf	VLY1_H
	banksel	LINEY2
	movf	LINEY2,W
	banksel	VLY2
	movwf	VLY2
	banksel	LINEY2_H
	movf	LINEY2_H,W
	banksel	VLY2_H
	movwf	VLY2_H
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	VLCOLOUR
	movwf	VLCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	VLCOLOUR_H
	movwf	VLCOLOUR_H
	banksel	STATUS
	pagesel	SSD1306_VLINE
	call	SSD1306_VLINE
	pagesel	$
;SSD1306_VLine ( LineX2, LineY1, LineY2, LineColour )
	banksel	LINEX2
	movf	LINEX2,W
	banksel	VLX
	movwf	VLX
	banksel	LINEX2_H
	movf	LINEX2_H,W
	banksel	VLX_H
	movwf	VLX_H
	banksel	LINEY1
	movf	LINEY1,W
	banksel	VLY1
	movwf	VLY1
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	VLY1_H
	movwf	VLY1_H
	banksel	LINEY2
	movf	LINEY2,W
	banksel	VLY2
	movwf	VLY2
	banksel	LINEY2_H
	movf	LINEY2_H,W
	banksel	VLY2_H
	movwf	VLY2_H
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	VLCOLOUR
	movwf	VLCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	VLCOLOUR_H
	movwf	VLCOLOUR_H
	banksel	STATUS
	pagesel	SSD1306_VLINE
	goto	SSD1306_VLINE

;********************************************************************************

;Overloaded signature: WORD:WORD:INTEGER:word:byte:, Source: glcd.h (1924)
CIRCLE37
;dim  radiusErr, xradius as Integer
;xradius = Inxradius
	banksel	INXRADIUS
	movf	INXRADIUS,W
	banksel	XRADIUS
	movwf	XRADIUS
	banksel	INXRADIUS_H
	movf	INXRADIUS_H,W
	banksel	XRADIUS_H
	movwf	XRADIUS_H
;radiusErr = -(xradius/2)
	movf	XRADIUS,W
	movwf	SysINTEGERTempA
	movf	XRADIUS_H,W
	movwf	SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSDIVSUBINT
	call	SYSDIVSUBINT
	pagesel	$
	movf	SysINTEGERTempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysINTEGERTempA_H,W
	movwf	SysTemp1_H
	comf	SysTemp1,W
	banksel	RADIUSERR
	movwf	RADIUSERR
	banksel	SYSTEMP1_H
	comf	SysTemp1_H,W
	banksel	RADIUSERR_H
	movwf	RADIUSERR_H
	incf	RADIUSERR,F
	btfsc	STATUS,Z
	incf	RADIUSERR_H,F
;Do While xradius >=  yordinate
SysDoLoop_S7
	banksel	XRADIUS
	movf	xradius,W
	movwf	SysINTEGERTempA
	movf	xradius_H,W
	movwf	SysINTEGERTempA_H
	movf	yordinate,W
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHANINT
	call	SYSCOMPLESSTHANINT
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	SysDoLoop_E7
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;yordinate ++
	banksel	YORDINATE
	incf	YORDINATE,F
;If radiusErr < 0 Then
	banksel	RADIUSERR
	movf	RADIUSERR,W
	movwf	SysINTEGERTempA
	movf	RADIUSERR_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHANINT
	call	SYSCOMPLESSTHANINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE58_1
;radiusErr = radiusErr + 2 * yordinate + 1
	bcf	STATUS,C
	banksel	YORDINATE
	rlf	YORDINATE,W
	movwf	SysTemp3
	banksel	RADIUSERR
	addwf	RADIUSERR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	RADIUSERR_H
	addwfc	RADIUSERR_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	banksel	RADIUSERR
	movwf	RADIUSERR
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	RADIUSERR_H
	movwf	RADIUSERR_H
;else
	goto	ENDIF58
ELSE58_1
;xradius --
	movlw	1
	banksel	XRADIUS
	subwf	XRADIUS,F
	movlw	0
	subwfb	XRADIUS_H,F
;radiusErr = radiusErr + 2 * (yordinate - xradius + 1)
	movf	XRADIUS,W
	subwf	YORDINATE,W
	movwf	SysTemp1
	clrf	SysTemp3
	movf	XRADIUS_H,W
	subwfb	SysTemp3,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	movwf	SysTemp2
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	SysTemp2_H
	movf	SysTemp2,W
	movwf	SysINTEGERTempA
	movf	SysTemp2_H,W
	movwf	SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SYSMULTSUBINT
	call	SYSMULTSUBINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	RADIUSERR
	addwf	RADIUSERR,F
	movf	SysINTEGERTempX_H,W
	addwfc	RADIUSERR_H,F
;end if
ENDIF58
;Loop
	goto	SysDoLoop_S7
SysDoLoop_E7
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (512)
GLCDDRAWCHAR_SSD1306
;This is now in four parts
;1. Handler for GLCD LM mode
;2. Preamble
;3. GCB Font set handler
;4. OLED Font set handler
;***** Handler for GLCD LM mode
;****** Preamble
;invert colors if required
;if LineColour <> GLCDForeground  then
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	movwf	SysWORDTempA
	movf	LINECOLOUR_H,W
	movwf	SysWORDTempA_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	SysWORDTempB
	movf	GLCDFOREGROUND_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPEQUAL16
	call	SYSCOMPEQUAL16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF116
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = 0
	banksel	GLCDFOREGROUND
	clrf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
;end if
ENDIF116
;dim CharCol, CharRow as word
;CharCode -= 15
	movlw	15
	banksel	CHARCODE
	subwf	CHARCODE,F
;CharCol=0
	clrf	CHARCOL
	clrf	CHARCOL_H
;Cursor_Position_SSD1306 ( CharLocX , CharLocY )
	movf	CHARLOCX,W
	banksel	LOCX
	movwf	LOCX
	banksel	CHARLOCY
	movf	CHARLOCY,W
	banksel	LOCY
	movwf	LOCY
	banksel	STATUS
	pagesel	CURSOR_POSITION_SSD1306
	call	CURSOR_POSITION_SSD1306
	pagesel	$
;1.14 Added transaction
;****** GCB Font set handler
;****** OLED Font set handler
;Calc pointer to the OLED fonts
;Dim LocalCharCode as word
;Set up the font information
;Select case GLCDfntDefaultSize
;case 1 'this is two font tables of an index and data
SysSelect3Case1
	decf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
;CharCode = CharCode - 16
	movlw	16
	subwf	CHARCODE,F
;ReadTable OLEDFont1Index, CharCode, LocalCharCode
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	OLEDFONT1INDEX
	call	OLEDFONT1INDEX
	pagesel	$
	banksel	LOCALCHARCODE
	movwf	LOCALCHARCODE
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	OLEDFONT1INDEX_H
	call	OLEDFONT1INDEX_H
	pagesel	$
	banksel	LOCALCHARCODE_H
	movwf	LOCALCHARCODE_H
;ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	pagesel	OLEDFONT1DATA
	call	OLEDFONT1DATA
	pagesel	$
	movwf	COLSPERFONT
;GLCDFontWidth = COLSperfont + 1
	incf	COLSPERFONT,W
	movwf	GLCDFONTWIDTH
;ROWSperfont = 7
	movlw	7
	banksel	ROWSPERFONT
	movwf	ROWSPERFONT
;case 2 'this is one font table
	goto	SysSelectEnd3
SysSelect3Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelectEnd3
;CharCode = CharCode - 17
	movlw	17
	subwf	CHARCODE,F
;Pointer to table of font elements
;LocalCharCode = (CharCode * 20)
	movf	CHARCODE,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	movlw	20
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSMULTSUB16
	call	SYSMULTSUB16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	LOCALCHARCODE
	movwf	LOCALCHARCODE
	movf	SysWORDTempX_H,W
	movwf	LOCALCHARCODE_H
;COLSperfont = 9  'which is really 10 as we start at 0
	movlw	9
	banksel	COLSPERFONT
	movwf	COLSPERFONT
;ROWSperfont=15  'which is really 16 as we start at 0
	movlw	15
	banksel	ROWSPERFONT
	movwf	ROWSPERFONT
;End Select
SysSelectEnd3
;For CurrCharCol = 0 to COLSperfont 'number of columns in the font , with two row of data
;Legacy method
	movlw	255
	banksel	CURRCHARCOL
	movwf	CURRCHARCOL
	movlw	0
	subwf	COLSPERFONT,W
	btfss	STATUS, C
	goto	SysForLoopEnd19
SysForLoop19
	incf	CURRCHARCOL,F
;Increment the table pointer
;LocalCharCode++
	banksel	LOCALCHARCODE
	incf	LOCALCHARCODE,F
	btfsc	STATUS,Z
	incf	LOCALCHARCODE_H,F
;Select case GLCDfntDefaultSize
;case 1
SysSelect4Case1
	banksel	GLCDFNTDEFAULTSIZE
	decf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelect4Case2
;ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal
	banksel	LOCALCHARCODE
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	pagesel	OLEDFONT1DATA
	call	OLEDFONT1DATA
	pagesel	$
	movwf	CURRCHARVAL
;case 2
	goto	SysSelectEnd4
SysSelect4Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelectEnd4
;Read this 20 times... (0..COLSperfont) [ * 2 ]
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	banksel	LOCALCHARCODE
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	pagesel	OLEDFONT2
	call	OLEDFONT2
	pagesel	$
	movwf	CURRCHARVAL
;End Select
SysSelectEnd4
;1.21 Full GLCD mode
;Handle 16 pixels of height
;For CurrCharRow = 0 to ROWSperfont
;Legacy method
	movlw	255
	movwf	CURRCHARROW
	movlw	0
	banksel	ROWSPERFONT
	subwf	ROWSPERFONT,W
	btfss	STATUS, C
	goto	SysForLoopEnd20
SysForLoop20
	banksel	CURRCHARROW
	incf	CURRCHARROW,F
;If CurrCharVal.0 = 0 Then
	btfsc	CURRCHARVAL,0
	goto	ELSE119_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBackground
	movf	CURRCHARCOL,W
	addwf	CHARLOCX,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	CURRCHARROW
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	GLCDBACKGROUND
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Else
	goto	ENDIF119
ELSE119_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDForeground
	movf	CURRCHARCOL,W
	addwf	CHARLOCX,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	CURRCHARROW
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	banksel	GLCDY
	movwf	GLCDY
	movf	GLCDFOREGROUND,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;End If
ENDIF119
;Rotate CurrCharVal Right
	rrf	CURRCHARVAL,F
;Set to next row of date, a second row pixels
;if GLCDfntDefaultSize = 2 and CurrCharRow = 7 then
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempA
	movlw	2
	movwf	SysBYTETempB
	pagesel	SYSCOMPEQUAL
	call	SYSCOMPEQUAL
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	CURRCHARROW
	movf	CURRCHARROW,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	pagesel	SYSCOMPEQUAL
	call	SYSCOMPEQUAL
	pagesel	$
	banksel	SYSTEMP3
	movf	SysTemp3,W
	andwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF120
;LocalCharCode++
	banksel	LOCALCHARCODE
	incf	LOCALCHARCODE,F
	btfsc	STATUS,Z
	incf	LOCALCHARCODE_H,F
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	pagesel	OLEDFONT2
	call	OLEDFONT2
	pagesel	$
	movwf	CURRCHARVAL
;end if
ENDIF120
;if CurrCharCol = COLSperfont then
	banksel	COLSPERFONT
	movf	COLSPERFONT,W
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	ENDIF121
;It is the intercharacter space, put out one pixel row
;Put out a white intercharacter pixel/space
;GLCDTemp = CharLocX + CurrCharCol
	movf	CURRCHARCOL,W
	addwf	CHARLOCX,W
	banksel	GLCDTEMP
	movwf	GLCDTEMP
;if GLCDfntDefaultSize = 2 then
	movlw	2
	banksel	GLCDFNTDEFAULTSIZE
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	ENDIF124
;GLCDTemp++
	banksel	GLCDTEMP
	incf	GLCDTEMP,F
;end if
ENDIF124
;PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBackground
	banksel	GLCDTEMP
	movf	GLCDTEMP,W
	movwf	GLCDX
	banksel	CURRCHARROW
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	GLCDBACKGROUND
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;end if
ENDIF121
;Next
	banksel	ROWSPERFONT
	movf	ROWSPERFONT,W
	banksel	CURRCHARROW
	subwf	CURRCHARROW,W
	btfss	STATUS, C
	goto	SysForLoop20
SysForLoopEnd20
;1.21 Low Memory GLCD mode
;1.21 Character GLCD mode
;Handles specific draw sequence. This caters for write only of a bit value. No read operation.
;Next
	banksel	COLSPERFONT
	movf	COLSPERFONT,W
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop19
SysForLoopEnd19
;1.14 Added transaction
;Restore
;GLCDBackground = 0
	clrf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = 1
	movlw	1
	banksel	GLCDFOREGROUND
	movwf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:LONG:, Source: glcd.h (1453)
GLCDPRINT25
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	banksel	SYSPRINTBUFFLEN
	clrf	SYSPRINTBUFFLEN
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	banksel	GLCDFONTWIDTH
	movf	GLCDFONTWIDTH,W
	banksel	OLDGLCDFONTWIDTH
	movwf	OLDGLCDFONTWIDTH
;Do
SysDoLoop_S6
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	banksel	SYSPRINTBUFFLEN
	incf	SYSPRINTBUFFLEN,F
;SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTBUFFLEN,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	banksel	LCDVALUE
	movf	LCDVALUE,W
	movwf	SysLONGTempA
	movf	LCDVALUE_H,W
	movwf	SysLONGTempA_H
	movf	LCDVALUE_U,W
	movwf	SysLONGTempA_U
	movf	LCDVALUE_E,W
	movwf	SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSDIVSUB32
	call	SYSDIVSUB32
	pagesel	$
	movf	SysLONGTempX,W
	movwf	INDF0
;LCDValue = SysCalcTempA
	movf	SYSCALCTEMPA,W
	banksel	LCDVALUE
	movwf	LCDVALUE
	movf	SYSCALCTEMPA_H,W
	movwf	LCDVALUE_H
	movf	SYSCALCTEMPA_U,W
	movwf	LCDVALUE_U
	movf	SYSCALCTEMPA_E,W
	movwf	LCDVALUE_E
;Loop While LCDValue <> 0
	movf	lcdvalue,W
	movwf	SysLONGTempA
	movf	lcdvalue_H,W
	movwf	SysLONGTempA_H
	movf	lcdvalue_U,W
	movwf	SysLONGTempA_U
	movf	lcdvalue_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSCOMPEQUAL32
	call	SYSCOMPEQUAL32
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysDoLoop_S6
SysDoLoop_E6
;Display
;GLCDPrintLoc = PrintLocX
	banksel	PRINTLOCX
	movf	PRINTLOCX,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	banksel	PRINTLOCX_H
	movf	PRINTLOCX_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;For GLCDPrint_String_Counter = SysPrintBuffLen To 1 Step -1
;Legacy method
	banksel	SYSPRINTBUFFLEN
	incf	SYSPRINTBUFFLEN,W
	banksel	GLCDPRINT_STRING_COUNTER
	movwf	GLCDPRINT_STRING_COUNTER
	movlw	1
	banksel	SYSPRINTBUFFLEN
	subwf	SYSPRINTBUFFLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd12
SysForLoop12
	banksel	GLCDPRINT_STRING_COUNTER
	decf	GLCDPRINT_STRING_COUNTER,F
;GLCDDrawChar GLCDPrintLoc, PrintLocY, SysPrintBuffer(GLCDPrint_String_Counter) + 48
	movf	GLCDPRINTLOC,W
	banksel	CHARLOCX
	movwf	CHARLOCX
	banksel	GLCDPRINTLOC_H
	movf	GLCDPRINTLOC_H,W
	banksel	CHARLOCX_H
	movwf	CHARLOCX_H
	banksel	PRINTLOCY
	movf	PRINTLOCY,W
	banksel	CHARLOCY
	movwf	CHARLOCY
	banksel	PRINTLOCY_H
	movf	PRINTLOCY_H,W
	banksel	CHARLOCY_H
	movwf	CHARLOCY_H
	movlw	low(SYSPRINTBUFFER)
	banksel	GLCDPRINT_STRING_COUNTER
	addwf	GLCDPRINT_STRING_COUNTER,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movlw	48
	addwf	INDF0,W
	banksel	CHARCODE
	movwf	CHARCODE
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	call	GLCDDRAWCHAR_SSD1306
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1578)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	pagesel	SYSMULTSUB
	call	SYSMULTSUB
	pagesel	$
	movf	SysBYTETempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	movwf	SysTemp1
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Next
	movf	GLCDPRINT_STRING_COUNTER,W
	sublw	1
	btfss	STATUS, C
	goto	SysForLoop12
SysForLoopEnd12
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	banksel	GLCDPRINTLOC
	movf	GLCDPRINTLOC,W
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	banksel	GLCDPRINTLOC_H
	movf	GLCDPRINTLOC_H,W
	banksel	PRINTLOCX_H
	movwf	PRINTLOCX_H
;GLCDFontWidth = OldGLCDFontWidth
	movf	OLDGLCDFONTWIDTH,W
	banksel	GLCDFONTWIDTH
	movwf	GLCDFONTWIDTH
	return

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (432)
SHOWDIGITS
;DigitValue = DigitIn
	movf	DIGITIN,W
	movwf	DIGITVALUE
	movf	DIGITIN_H,W
	movwf	DIGITVALUE_H
;DigitLead = 1
	movlw	1
	movwf	DIGITLEAD
;For DigitPlace = 1 To 4
;Legacy method
	clrf	DIGITPLACE
SysForLoop9
	incf	DIGITPLACE,F
;Select Case DigitPlace
;Case 1
SysSelect2Case1
	decf	DIGITPLACE,W
	btfss	STATUS, Z
	goto	SysSelect2Case2
;DigitChar = DigitValue / 1000
	movf	DIGITVALUE,W
	movwf	SysWORDTempA
	movf	DIGITVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	pagesel	SYSDIVSUB16
	call	SYSDIVSUB16
	pagesel	$
	movf	SysWORDTempA,W
	movwf	DIGITCHAR
;DigitValue = DigitValue % 1000
	movf	DIGITVALUE,W
	movwf	SysWORDTempA
	movf	DIGITVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	pagesel	SYSDIVSUB16
	call	SYSDIVSUB16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	DIGITVALUE
	movf	SysWORDTempX_H,W
	movwf	DIGITVALUE_H
;Case 2
	goto	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	DIGITPLACE,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
;DigitChar = DigitValue / 100
	movf	DIGITVALUE,W
	movwf	SysWORDTempA
	movf	DIGITVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSDIVSUB16
	call	SYSDIVSUB16
	pagesel	$
	movf	SysWORDTempA,W
	movwf	DIGITCHAR
;DigitValue = DigitValue % 100
	movf	DIGITVALUE,W
	movwf	SysWORDTempA
	movf	DIGITVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSDIVSUB16
	call	SYSDIVSUB16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	DIGITVALUE
	movf	SysWORDTempX_H,W
	movwf	DIGITVALUE_H
;Case 3
	goto	SysSelectEnd2
SysSelect2Case3
	movlw	3
	subwf	DIGITPLACE,W
	btfss	STATUS, Z
	goto	SysSelect2Case4
;DigitChar = DigitValue / 10
	movf	DIGITVALUE,W
	movwf	SysWORDTempA
	movf	DIGITVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSDIVSUB16
	call	SYSDIVSUB16
	pagesel	$
	movf	SysWORDTempA,W
	movwf	DIGITCHAR
;DigitValue = DigitValue % 10
	movf	DIGITVALUE,W
	movwf	SysWORDTempA
	movf	DIGITVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSDIVSUB16
	call	SYSDIVSUB16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	DIGITVALUE
	movf	SysWORDTempX_H,W
	movwf	DIGITVALUE_H
;Case 4
	goto	SysSelectEnd2
SysSelect2Case4
	movlw	4
	subwf	DIGITPLACE,W
	btfss	STATUS, Z
	goto	SysSelectEnd2
;DigitChar = DigitValue
	movf	DIGITVALUE,W
	movwf	DIGITCHAR
;End Select
SysSelectEnd2
;If DigitChar <> 0 Or DigitPlace = 4 Then DigitLead = 0
	movf	DIGITCHAR,W
	movwf	SysBYTETempA
	clrf	SysBYTETempB
	pagesel	SYSCOMPEQUAL
	call	SYSCOMPEQUAL
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	DIGITPLACE
	movf	DIGITPLACE,W
	movwf	SysBYTETempA
	movlw	4
	movwf	SysBYTETempB
	pagesel	SYSCOMPEQUAL
	call	SYSCOMPEQUAL
	pagesel	$
	banksel	SYSTEMP3
	movf	SysTemp3,W
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF47
;If DigitChar <> 0 Or DigitPlace = 4 Then DigitLead = 0
	banksel	DIGITLEAD
	clrf	DIGITLEAD
;If DigitChar <> 0 Or DigitPlace = 4 Then DigitLead = 0
ENDIF47
;If DigitLead = 1 Then
	banksel	DIGITLEAD
	decf	DIGITLEAD,W
	btfss	STATUS, Z
	goto	ELSE48_1
;GLCDDrawChar(DigitX, DigitY, 32)
	movf	DIGITX,W
	movwf	CHARLOCX
	movf	DIGITX_H,W
	movwf	CHARLOCX_H
	movf	DIGITY,W
	movwf	CHARLOCY
	movf	DIGITY_H,W
	movwf	CHARLOCY_H
	movlw	32
	movwf	CHARCODE
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	call	GLCDDRAWCHAR_SSD1306
;Else
	goto	ENDIF48
ELSE48_1
;GLCDDrawChar(DigitX, DigitY, DigitChar + 48)
	movf	DIGITX,W
	movwf	CHARLOCX
	movf	DIGITX_H,W
	movwf	CHARLOCX_H
	movf	DIGITY,W
	movwf	CHARLOCY
	movf	DIGITY_H,W
	movwf	CHARLOCY_H
	movlw	48
	addwf	DIGITCHAR,W
	movwf	CHARCODE
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	call	GLCDDRAWCHAR_SSD1306
;End If
ENDIF48
;DigitX += GLCDFontWidth
	movf	GLCDFONTWIDTH,W
	addwf	DIGITX,F
	movlw	0
	addwfc	DIGITX_H,F
;Next
	movlw	4
	subwf	DIGITPLACE,W
	btfss	STATUS, C
	goto	SysForLoop9
SysForLoopEnd9
	return

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (151)
SHOWSHAPES
;DrawTitle("2 Shapes")
	movlw	low StringTable10
	banksel	SYSTITLETEXTHANDLER
	movwf	SysTITLETEXTHandler
	movlw	(high StringTable10) | 128
	movwf	SysTITLETEXTHandler_H
	banksel	STATUS
	pagesel	DRAWTITLE
	call	DRAWTITLE
	pagesel	$
;Line(0, 12, 30, 40)
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	movlw	12
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	30
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	40
	movwf	LINEY2
	clrf	LINEY2_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	pagesel	LINE_SSD1306
	call	LINE_SSD1306
	pagesel	$
;Box(34, 12, 58, 34)
	movlw	34
	banksel	LINEX1
	movwf	LINEX1
	clrf	LINEX1_H
	movlw	12
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	58
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	34
	movwf	LINEY2
	clrf	LINEY2_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	call	BOX_SSD1306
	pagesel	$
;FilledBox(62, 12, 86, 34)
	movlw	62
	banksel	LINEX1
	movwf	LINEX1
	movlw	12
	movwf	LINEY1
	movlw	86
	movwf	LINEX2
	movlw	34
	movwf	LINEY2
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	pagesel	FILLEDBOX_SSD1306
	call	FILLEDBOX_SSD1306
	pagesel	$
;Circle(103, 23, 11)
	movlw	103
	banksel	XOFFSET
	movwf	XOFFSET
	clrf	XOFFSET_H
	movlw	23
	movwf	YOFFSET
	clrf	YOFFSET_H
	movlw	11
	banksel	INXRADIUS
	movwf	INXRADIUS
	clrf	INXRADIUS_H
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	GLCD_YORDINATE
	movf	GLCD_YORDINATE,W
	banksel	YORDINATE
	movwf	YORDINATE
	banksel	STATUS
	call	CIRCLE37
;FilledCircle(14, 52, 10)
	movlw	14
	banksel	XOFFSET
	movwf	XOFFSET
	clrf	XOFFSET_H
	movlw	52
	movwf	YOFFSET
	clrf	YOFFSET_H
	movlw	10
	movwf	XRADIUS
	clrf	XRADIUS_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	pagesel	FILLEDCIRCLE39
	call	FILLEDCIRCLE39
	pagesel	$
;FilledTriangle(30, 62, 46, 38, 62, 62)
	movlw	30
	banksel	XOFFSET
	movwf	XOFFSET
	clrf	XOFFSET_H
	movlw	62
	movwf	YOFFSET
	clrf	YOFFSET_H
	movlw	46
	movwf	XOFFSET2
	clrf	XOFFSET2_H
	movlw	38
	movwf	YOFFSET2
	clrf	YOFFSET2_H
	movlw	62
	movwf	XOFFSET3
	clrf	XOFFSET3_H
	movlw	62
	movwf	YOFFSET3
	clrf	YOFFSET3_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	pagesel	FILLEDTRIANGLE72
	call	FILLEDTRIANGLE72
	pagesel	$
;Triangle(66, 62, 80, 38, 94, 62)
	movlw	66
	banksel	XOFFSET
	movwf	XOFFSET
	clrf	XOFFSET_H
	movlw	62
	movwf	YOFFSET
	clrf	YOFFSET_H
	movlw	80
	movwf	XOFFSET2
	clrf	XOFFSET2_H
	movlw	38
	movwf	YOFFSET2
	clrf	YOFFSET2_H
	movlw	94
	movwf	XOFFSET3
	clrf	XOFFSET3_H
	movlw	62
	movwf	YOFFSET3
	clrf	YOFFSET3_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	pagesel	TRIANGLE70
	call	TRIANGLE70
	pagesel	$
;Ellipse(113, 51, 13, 9)
	movlw	113
	banksel	XOFFSET
	movwf	XOFFSET
	clrf	XOFFSET_H
	movlw	51
	movwf	YOFFSET
	clrf	YOFFSET_H
	movlw	13
	banksel	INXRADIUS
	movwf	INXRADIUS
	clrf	INXRADIUS_H
	movlw	9
	banksel	INYRADIUS
	movwf	INYRADIUS
	clrf	INYRADIUS_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	pagesel	ELLIPSE54
	call	ELLIPSE54
	pagesel	$
;WaitScreen
	pagesel	WAITSCREEN
	goto	WAITSCREEN

;********************************************************************************

;Source: GLCD_SSD1306.H (1167)
SSD1306_PUTROW
;dim SSD1306_RPOld, SSD1306_RPNew, SSD1306_RPCol, SSD1306_RPAnyChanged as byte
;Pass 1: does anything in this run actually change?
;SSD1306_RPAnyChanged = 0
	banksel	SSD1306_RPANYCHANGED
	clrf	SSD1306_RPANYCHANGED
;For SSD1306_RPCol = RPCol1 to RPCol2
;Legacy method
	banksel	RPCOL1
	decf	RPCOL1,W
	banksel	SSD1306_RPCOL
	movwf	SSD1306_RPCOL
	banksel	RPCOL1
	movf	RPCOL1,W
	subwf	RPCOL2,W
	btfss	STATUS, C
	goto	SysForLoopEnd21
SysForLoop21
	banksel	SSD1306_RPCOL
	incf	SSD1306_RPCOL,F
;SSD1306_BufferLocationCalc = RPPage
	banksel	RPPAGE
	movf	RPPAGE,W
	banksel	SSD1306_BUFFERLOCATIONCALC
	movwf	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H
;Set C Off
	bcf	STATUS,C
;Repeat 7
	movlw	7
	banksel	SYSREPEATTEMP9
	movwf	SysRepeatTemp9
SysRepeatLoop9
;Rotate SSD1306_BufferLocationCalc Left
	banksel	SSD1306_BUFFERLOCATIONCALC
	rlf	SSD1306_BUFFERLOCATIONCALC,F
	rlf	SSD1306_BUFFERLOCATIONCALC_H,F
;End Repeat
	banksel	SYSREPEATTEMP9
	decfsz	SysRepeatTemp9,F
	goto	SysRepeatLoop9
SysRepeatLoopEnd9
;SSD1306_BufferLocationCalc = SSD1306_RPCol + SSD1306_BufferLocationCalc + 1
	banksel	SSD1306_BUFFERLOCATIONCALC
	movf	SSD1306_BUFFERLOCATIONCALC,W
	addwf	SSD1306_RPCOL,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysTemp3
	banksel	SSD1306_BUFFERLOCATIONCALC_H
	movf	SSD1306_BUFFERLOCATIONCALC_H,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	banksel	SSD1306_BUFFERLOCATIONCALC
	movwf	SSD1306_BUFFERLOCATIONCALC
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	SSD1306_BUFFERLOCATIONCALC_H
	movwf	SSD1306_BUFFERLOCATIONCALC_H
;SSD1306_RPOld = SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
	movlw	low(SSD1306_BUFFERALIAS)
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SSD1306_RPOLD
;SSD1306_RPNew = ( SSD1306_RPOld And ( Not RPMask ) ) Or ( RPValue And RPMask )
	banksel	RPMASK
	comf	RPMASK,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	SSD1306_RPOLD
	movf	SSD1306_RPOLD,W
	banksel	SYSTEMP3
	andwf	SysTemp3,W
	movwf	SysTemp1
	banksel	RPVALUE
	movf	RPVALUE,W
	andwf	RPMASK,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	movf	SysTemp1,W
	iorwf	SysTemp3,W
	banksel	SSD1306_RPNEW
	movwf	SSD1306_RPNEW
;If SSD1306_RPNew <> SSD1306_RPOld Then
	movf	SSD1306_RPOLD,W
	subwf	SSD1306_RPNEW,W
	btfsc	STATUS, Z
	goto	ENDIF141
;SSD1306_RPAnyChanged = 1
	movlw	1
	movwf	SSD1306_RPANYCHANGED
;Exit For
	goto	SysForLoopEnd21
;End If
ENDIF141
;Next
	banksel	RPCOL2
	movf	RPCOL2,W
	banksel	SSD1306_RPCOL
	subwf	SSD1306_RPCOL,W
	btfss	STATUS, C
	goto	SysForLoop21
SysForLoopEnd21
;If SSD1306_RPAnyChanged = 0 Then Exit Sub
	banksel	SSD1306_RPANYCHANGED
	movf	SSD1306_RPANYCHANGED,F
	btfss	STATUS, Z
	goto	ENDIF143
;If SSD1306_RPAnyChanged = 0 Then Exit Sub
	banksel	STATUS
	return
;If SSD1306_RPAnyChanged = 0 Then Exit Sub
ENDIF143
;Pass 2: write every byte of the run in one transaction
;Cursor_Position_SSD1306 ( RPCol1, RPPage * 8 )
	banksel	RPCOL1
	movf	RPCOL1,W
	banksel	LOCX
	movwf	LOCX
	banksel	RPPAGE
	movf	RPPAGE,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SYSMULTSUB
	call	SYSMULTSUB
	pagesel	$
	movf	SysBYTETempX,W
	banksel	LOCY
	movwf	LOCY
	banksel	STATUS
	pagesel	CURSOR_POSITION_SSD1306
	call	CURSOR_POSITION_SSD1306
	pagesel	$
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1605)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	pagesel	HI2CSTART
	call	HI2CSTART
	pagesel	$
;HI2CSend GLCD_I2C_Address
	movlw	120
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 0x40
	movlw	64
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;For SSD1306_RPCol = RPCol1 to RPCol2
;Legacy method
	banksel	RPCOL1
	decf	RPCOL1,W
	banksel	SSD1306_RPCOL
	movwf	SSD1306_RPCOL
	banksel	RPCOL1
	movf	RPCOL1,W
	subwf	RPCOL2,W
	btfss	STATUS, C
	goto	SysForLoopEnd22
SysForLoop22
	banksel	SSD1306_RPCOL
	incf	SSD1306_RPCOL,F
;SSD1306_BufferLocationCalc = RPPage
	banksel	RPPAGE
	movf	RPPAGE,W
	banksel	SSD1306_BUFFERLOCATIONCALC
	movwf	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H
;Set C Off
	bcf	STATUS,C
;Repeat 7
	movlw	7
	banksel	SYSREPEATTEMP9
	movwf	SysRepeatTemp9
SysRepeatLoop10
;Rotate SSD1306_BufferLocationCalc Left
	banksel	SSD1306_BUFFERLOCATIONCALC
	rlf	SSD1306_BUFFERLOCATIONCALC,F
	rlf	SSD1306_BUFFERLOCATIONCALC_H,F
;End Repeat
	banksel	SYSREPEATTEMP9
	decfsz	SysRepeatTemp9,F
	goto	SysRepeatLoop10
SysRepeatLoopEnd10
;SSD1306_BufferLocationCalc = SSD1306_RPCol + SSD1306_BufferLocationCalc + 1
	banksel	SSD1306_BUFFERLOCATIONCALC
	movf	SSD1306_BUFFERLOCATIONCALC,W
	addwf	SSD1306_RPCOL,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysTemp3
	banksel	SSD1306_BUFFERLOCATIONCALC_H
	movf	SSD1306_BUFFERLOCATIONCALC_H,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	banksel	SSD1306_BUFFERLOCATIONCALC
	movwf	SSD1306_BUFFERLOCATIONCALC
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	SSD1306_BUFFERLOCATIONCALC_H
	movwf	SSD1306_BUFFERLOCATIONCALC_H
;SSD1306_RPOld = SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
	movlw	low(SSD1306_BUFFERALIAS)
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SSD1306_RPOLD
;SSD1306_RPNew = ( SSD1306_RPOld And ( Not RPMask ) ) Or ( RPValue And RPMask )
	banksel	RPMASK
	comf	RPMASK,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	SSD1306_RPOLD
	movf	SSD1306_RPOLD,W
	banksel	SYSTEMP3
	andwf	SysTemp3,W
	movwf	SysTemp1
	banksel	RPVALUE
	movf	RPVALUE,W
	andwf	RPMASK,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	movf	SysTemp1,W
	iorwf	SysTemp3,W
	banksel	SSD1306_RPNEW
	movwf	SSD1306_RPNEW
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = SSD1306_RPNew
	movlw	low(SSD1306_BUFFERALIAS)
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	movf	SSD1306_RPNEW,W
	movwf	INDF0
;Write_Transaction_Data_SSD1306 ( SSD1306_RPNew )
;Macro Source: GLCD_SSD1306.H (1701)
;HI2CSend SSD1306SendByte
	movf	SSD1306_RPNEW,W
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;Next
	banksel	RPCOL2
	movf	RPCOL2,W
	banksel	SSD1306_RPCOL
	subwf	SSD1306_RPCOL,W
	btfss	STATUS, C
	goto	SysForLoop22
SysForLoopEnd22
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1734)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	banksel	STATUS
	pagesel	HI2CSTOP
	goto	HI2CSTOP

;********************************************************************************

;Source: system.h (3388)
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
	movf	SYSLONGTEMPA,W
	banksel	SYSLONGDIVMULTA
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	banksel	SYSLONGDIVMULTB
	btfss	SYSLONGDIVMULTB,0
	goto	ENDIF95
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	movf	SYSLONGDIVMULTA,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTA_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTA_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTA_E,W
	addwfc	SYSLONGDIVMULTX_E,F
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
ENDIF95
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysLongDivMultB right
	rrf	SYSLONGDIVMULTB_E,F
	rrf	SYSLONGDIVMULTB_U,F
	rrf	SYSLONGDIVMULTB_H,F
	rrf	SYSLONGDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysLongDivMultA left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempB
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempB_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempB_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempB_E
	clrf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN32
	call	SYSCOMPLESSTHAN32
	pagesel	$
	btfsc	SysByteTempX,0
;if SysLongDivMultB > 0 then goto MUL32LOOP
	goto	MUL32LOOP
;if SysLongDivMultB > 0 then goto MUL32LOOP
;SysLongTempX = SysLongDivMultX
	banksel	SYSLONGDIVMULTX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	banksel	STATUS
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

StringTable3
	retlw	3
	retlw	98	;b
	retlw	48	;0
	retlw	49	;1


StringTable4
	retlw	6
	retlw	49	;1
	retlw	32	; 
	retlw	84	;T
	retlw	101	;e
	retlw	120	;x
	retlw	116	;t


StringTable5
	retlw	17
	retlw	71	;G
	retlw	76	;L
	retlw	67	;C
	retlw	68	;D
	retlw	80	;P
	retlw	114	;r
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	44	;,
	retlw	32	; 
	retlw	115	;s
	retlw	105	;i
	retlw	122	;z
	retlw	101	;e
	retlw	32	; 
	retlw	49	;1


StringTable6
	retlw	7
	retlw	83	;S
	retlw	83	;S
	retlw	68	;D
	retlw	49	;1
	retlw	51	;3
	retlw	48	;0
	retlw	54	;6


StringTable7
	retlw	7
	retlw	78	;N
	retlw	117	;u
	retlw	109	;m
	retlw	98	;b
	retlw	101	;e
	retlw	114	;r
	retlw	58	;:


StringTable8
	retlw	12
	retlw	105	;i
	retlw	110	;n
	retlw	118	;v
	retlw	101	;e
	retlw	114	;r
	retlw	115	;s
	retlw	101	;e
	retlw	32	; 
	retlw	116	;t
	retlw	101	;e
	retlw	120	;x
	retlw	116	;t


StringTable9
	retlw	2
	retlw	109	;m
	retlw	115	;s


StringTable10
	retlw	8
	retlw	50	;2
	retlw	32	; 
	retlw	83	;S
	retlw	104	;h
	retlw	97	;a
	retlw	112	;p
	retlw	101	;e
	retlw	115	;s


StringTable11
	retlw	5
	retlw	51	;3
	retlw	32	; 
	retlw	80	;P
	retlw	111	;o
	retlw	116	;t


StringTable12
	retlw	13
	retlw	84	;T
	retlw	117	;u
	retlw	114	;r
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	104	;h
	retlw	101	;e
	retlw	32	; 
	retlw	112	;p
	retlw	111	;o
	retlw	116	;t
	retlw	58	;:


StringTable13
	retlw	8
	retlw	52	;4
	retlw	32	; 
	retlw	66	;B
	retlw	111	;o
	retlw	117	;u
	retlw	110	;n
	retlw	99	;c
	retlw	101	;e


StringTable14
	retlw	3
	retlw	102	;f
	retlw	112	;p
	retlw	115	;s


StringTable15
	retlw	9
	retlw	53	;5
	retlw	32	; 
	retlw	68	;D
	retlw	105	;i
	retlw	115	;s
	retlw	112	;p
	retlw	108	;l
	retlw	97	;a
	retlw	121	;y


StringTable16
	retlw	16
	retlw	67	;C
	retlw	111	;o
	retlw	110	;n
	retlw	116	;t
	retlw	114	;r
	retlw	97	;a
	retlw	115	;s
	retlw	116	;t
	retlw	58	;:
	retlw	32	; 
	retlw	100	;d
	retlw	105	;i
	retlw	109	;m
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable17
	retlw	16
	retlw	67	;C
	retlw	111	;o
	retlw	110	;n
	retlw	116	;t
	retlw	114	;r
	retlw	97	;a
	retlw	115	;s
	retlw	116	;t
	retlw	58	;:
	retlw	32	; 
	retlw	98	;b
	retlw	114	;r
	retlw	105	;i
	retlw	103	;g
	retlw	104	;h
	retlw	116	;t


StringTable18
	retlw	16
	retlw	73	;I
	retlw	110	;n
	retlw	118	;v
	retlw	101	;e
	retlw	114	;r
	retlw	116	;t
	retlw	32	; 
	retlw	109	;m
	retlw	111	;o
	retlw	100	;d
	retlw	101	;e
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable19
	retlw	15
	retlw	82	;R
	retlw	111	;o
	retlw	116	;t
	retlw	97	;a
	retlw	116	;t
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	49	;1
	retlw	56	;8
	retlw	48	;0
	retlw	32	; 
	retlw	100	;d
	retlw	101	;e
	retlw	103	;g


;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (371)
TIMESTART
;TMR0H = 0 : TMR0L = 0                           ' high byte first: it is written with the low byte
	clrf	TMR0H
;TMR0H = 0 : TMR0L = 0                           ' high byte first: it is written with the low byte
	clrf	TMR0L
	return

;********************************************************************************

;Program_memory_page: 4
	ORG	8192
;Source: GLCD_SSD1306.H (891)
FILLEDBOX_SSD1306
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	banksel	LINEX1
	movf	LINEX1,W
	subwf	LINEX2,W
	btfsc	STATUS, C
	goto	ENDIF125
;GLCDTemp = LineX1
	movf	LINEX1,W
	banksel	GLCDTEMP
	movwf	GLCDTEMP
;LineX1 = LineX2
	banksel	LINEX2
	movf	LINEX2,W
	movwf	LINEX1
;LineX2 = GLCDTemp
	banksel	GLCDTEMP
	movf	GLCDTEMP,W
	banksel	LINEX2
	movwf	LINEX2
;End If
ENDIF125
;If LineY1 > LineY2 Then
	movf	LINEY1,W
	subwf	LINEY2,W
	btfsc	STATUS, C
	goto	ENDIF126
;GLCDTemp = LineY1
	movf	LINEY1,W
	banksel	GLCDTEMP
	movwf	GLCDTEMP
;LineY1 = LineY2
	banksel	LINEY2
	movf	LINEY2,W
	movwf	LINEY1
;LineY2 = GLCDTemp
	banksel	GLCDTEMP
	movf	GLCDTEMP,W
	banksel	LINEY2
	movwf	LINEY2
;End If
ENDIF126
;Full screen buffer: page by page, whole bytes - each spanned page is one masked run, checked
;against the buffer and sent as a single I2C transaction only if something in it actually changes
;dim SSD1306_FBPage, SSD1306_FBLast, SSD1306_FBMask, SSD1306_FBValue, SSD1306_FBCol1, SSD1306_FBCol2 as byte
;If LineX1 > GLCD_WIDTH - 1 Then Exit Sub
	movf	LINEX1,W
	movwf	SysBYTETempB
	movlw	127
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
;If LineX1 > GLCD_WIDTH - 1 Then Exit Sub
	return
;If LineX1 > GLCD_WIDTH - 1 Then Exit Sub
;If LineY1 > GLCD_HEIGHT - 1 Then Exit Sub
	banksel	LINEY1
	movf	LINEY1,W
	movwf	SysBYTETempB
	movlw	63
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
;If LineY1 > GLCD_HEIGHT - 1 Then Exit Sub
	return
;If LineY1 > GLCD_HEIGHT - 1 Then Exit Sub
;SSD1306_FBCol1 = LineX1
	banksel	LINEX1
	movf	LINEX1,W
	banksel	SSD1306_FBCOL1
	movwf	SSD1306_FBCOL1
;SSD1306_FBCol2 = GLCD_WIDTH - 1
	movlw	127
	movwf	SSD1306_FBCOL2
;If LineX2 < GLCD_WIDTH Then SSD1306_FBCol2 = LineX2
	movlw	128
	banksel	LINEX2
	subwf	LINEX2,W
	btfsc	STATUS, C
	goto	ENDIF129
;If LineX2 < GLCD_WIDTH Then SSD1306_FBCol2 = LineX2
	movf	LINEX2,W
	banksel	SSD1306_FBCOL2
	movwf	SSD1306_FBCOL2
;If LineX2 < GLCD_WIDTH Then SSD1306_FBCol2 = LineX2
ENDIF129
;If LineY2 > GLCD_HEIGHT - 1 Then LineY2 = GLCD_HEIGHT - 1
	banksel	LINEY2
	movf	LINEY2,W
	movwf	SysBYTETempB
	movlw	63
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF130
;If LineY2 > GLCD_HEIGHT - 1 Then LineY2 = GLCD_HEIGHT - 1
	movlw	63
	banksel	LINEY2
	movwf	LINEY2
;If LineY2 > GLCD_HEIGHT - 1 Then LineY2 = GLCD_HEIGHT - 1
ENDIF130
;SSD1306_FBValue = 0
	banksel	SSD1306_FBVALUE
	clrf	SSD1306_FBVALUE
;If LineColour.0 = 1 Then SSD1306_FBValue = 0xFF
	banksel	LINECOLOUR
	btfss	LINECOLOUR,0
	goto	ENDIF131
;If LineColour.0 = 1 Then SSD1306_FBValue = 0xFF
	movlw	255
	banksel	SSD1306_FBVALUE
	movwf	SSD1306_FBVALUE
;If LineColour.0 = 1 Then SSD1306_FBValue = 0xFF
ENDIF131
;SSD1306_FBPage = LineY1
	banksel	LINEY1
	movf	LINEY1,W
	banksel	SSD1306_FBPAGE
	movwf	SSD1306_FBPAGE
;SSD1306_FBLast = LineY2
	banksel	LINEY2
	movf	LINEY2,W
	banksel	SSD1306_FBLAST
	movwf	SSD1306_FBLAST
;Repeat 3
	movlw	3
	banksel	SYSREPEATTEMP5
	movwf	SysRepeatTemp5
SysRepeatLoop5
;Set C Off
	bcf	STATUS,C
;Rotate SSD1306_FBPage Right
	banksel	SSD1306_FBPAGE
	rrf	SSD1306_FBPAGE,F
;Set C Off
	bcf	STATUS,C
;Rotate SSD1306_FBLast Right
	rrf	SSD1306_FBLAST,F
;End Repeat
	banksel	SYSREPEATTEMP5
	decfsz	SysRepeatTemp5,F
	goto	SysRepeatLoop5
SysRepeatLoopEnd5
;Do
SysDoLoop_S11
;SSD1306_FBMask = SSD1306_RowMask ( SSD1306_FBPage, LineY1, LineY2 )
	banksel	SSD1306_FBPAGE
	movf	SSD1306_FBPAGE,W
	banksel	RMPAGE
	movwf	RMPAGE
	movf	LINEY1,W
	movwf	RMY1
	movf	LINEY2,W
	movwf	RMY2
	banksel	STATUS
	call	FN_SSD1306_ROWMASK
	banksel	SSD1306_ROWMASK
	movf	SSD1306_ROWMASK,W
	movwf	SSD1306_FBMASK
;SSD1306_PutRow ( SSD1306_FBCol1, SSD1306_FBCol2, SSD1306_FBPage, SSD1306_FBValue, SSD1306_FBMask )
	movf	SSD1306_FBCOL1,W
	banksel	RPCOL1
	movwf	RPCOL1
	banksel	SSD1306_FBCOL2
	movf	SSD1306_FBCOL2,W
	banksel	RPCOL2
	movwf	RPCOL2
	banksel	SSD1306_FBPAGE
	movf	SSD1306_FBPAGE,W
	banksel	RPPAGE
	movwf	RPPAGE
	banksel	SSD1306_FBVALUE
	movf	SSD1306_FBVALUE,W
	banksel	RPVALUE
	movwf	RPVALUE
	banksel	SSD1306_FBMASK
	movf	SSD1306_FBMASK,W
	banksel	RPMASK
	movwf	RPMASK
	banksel	STATUS
	pagesel	SSD1306_PUTROW
	call	SSD1306_PUTROW
	pagesel	$
;If SSD1306_FBPage = SSD1306_FBLast Then Exit Do
	banksel	SSD1306_FBLAST
	movf	SSD1306_FBLAST,W
	subwf	SSD1306_FBPAGE,W
	btfsc	STATUS, Z
;If SSD1306_FBPage = SSD1306_FBLast Then Exit Do
	goto	SysDoLoop_E11
;If SSD1306_FBPage = SSD1306_FBLast Then Exit Do
;SSD1306_FBPage++
	incf	SSD1306_FBPAGE,F
;Loop
	goto	SysDoLoop_S11
SysDoLoop_E11
	banksel	STATUS
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (464)
GLCDCLS_SSD1306
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	banksel	GLCD_YORDINATE
	clrf	GLCD_YORDINATE
	clrf	GLCD_YORDINATE_H
;For SSD1306_BufferLocationCalc = 1 to GLCD_HEIGHT * GLCD_WIDTH / 8
;Legacy method
	banksel	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H
SysForLoop16
	banksel	SSD1306_BUFFERLOCATIONCALC
	incf	SSD1306_BUFFERLOCATIONCALC,F
	btfsc	STATUS,Z
	incf	SSD1306_BUFFERLOCATIONCALC_H,F
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	movlw	low(SSD1306_BUFFERALIAS)
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	clrf	INDF0
;Next
	movf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	SysWORDTempA
	movf	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	movlw	4
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop16
SysForLoopEnd16
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	banksel	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H
SysForLoop17
;Init SysForLoopStep16 :#0
	movlw	8
	movwf	SysForLoopStep16
	clrf	SysForLoopStep16_H
;Cursor_Position_SSD1306 ( 0 , SSD1306_BufferLocationCalc )
	banksel	LOCX
	clrf	LOCX
	banksel	SSD1306_BUFFERLOCATIONCALC
	movf	SSD1306_BUFFERLOCATIONCALC,W
	banksel	LOCY
	movwf	LOCY
	banksel	STATUS
	pagesel	CURSOR_POSITION_SSD1306
	call	CURSOR_POSITION_SSD1306
	pagesel	$
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1605)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	pagesel	HI2CSTART
	call	HI2CSTART
	pagesel	$
;HI2CSend GLCD_I2C_Address
	movlw	120
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 0x40
	movlw	64
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;For GLCDTemp = 0 to 127
;Legacy method
	movlw	255
	banksel	GLCDTEMP
	movwf	GLCDTEMP
SysForLoop18
	incf	GLCDTEMP,F
;Write_Transaction_Data_SSD1306(GLCDBackground)
;Macro Source: GLCD_SSD1306.H (1701)
;HI2CSend SSD1306SendByte
	banksel	GLCDBACKGROUND
	movf	GLCDBACKGROUND,W
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;Next
	movlw	127
	banksel	GLCDTEMP
	subwf	GLCDTEMP,W
	btfss	STATUS, C
	goto	SysForLoop18
SysForLoopEnd18
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1734)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	banksel	STATUS
	pagesel	HI2CSTOP
	call	HI2CSTOP
	pagesel	$
;Next
;Integer negative Step Handler in For-next statement
	banksel	SYSFORLOOPSTEP16_H
	btfss	SYSFORLOOPSTEP16_H,7
	goto	ELSE113_1
;Set SysForLoopABsValue to -StepValue :#1 
	comf	SYSFORLOOPSTEP16,W
	movwf	SysForLoopABsValue17
	comf	SYSFORLOOPSTEP16_H,W
	movwf	SysForLoopABsValue17_H
	incf	SysForLoopABsValue17,F
	btfsc	STATUS,Z
	incf	SysForLoopABsValue17_H,F
;IF ( SSD1306_BUFFERLOCATIONCALC - 64-1) } [WORD]SysForLoopABsValue17 THEN  :#1n 
	movlw	64
	subwf	SSD1306_BUFFERLOCATIONCALC,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SSD1306_BUFFERLOCATIONCALC_H
	subwfb	SSD1306_BUFFERLOCATIONCALC_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	movwf	SysTemp2
	movlw	0
	subwfb	SysTemp1_H,W
	movwf	SysTemp2_H
	movf	SysTemp2,W
	movwf	SysWORDTempA
	movf	SysTemp2_H,W
	movwf	SysWORDTempA_H
	banksel	SYSFORLOOPABSVALUE17
	movf	SYSFORLOOPABSVALUE17,W
	movwf	SysWORDTempB
	movf	SYSFORLOOPABSVALUE17_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF114
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	banksel	SYSFORLOOPSTEP16
	movf	SysForLoopStep16,W
	addwf	SSD1306_BUFFERLOCATIONCALC,F
	movf	SysForLoopStep16_H,W
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F
	goto	SysForLoop17
;END IF
ENDIF114
	goto	ENDIF113
ELSE113_1
;Integer positive Step Handler in For-next statement
;IF ([WORD]64-1 - [WORD]SSD1306_BUFFERLOCATIONCALC) } [WORD]SysForLoopStep16 THEN :#1p 
	movf	SSD1306_BUFFERLOCATIONCALC,W
	sublw	63
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysTemp3
	banksel	SSD1306_BUFFERLOCATIONCALC_H
	movf	SSD1306_BUFFERLOCATIONCALC_H,W
	banksel	SYSTEMP3
	subwfb	SysTemp3,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	banksel	SYSFORLOOPSTEP16
	movf	SYSFORLOOPSTEP16,W
	movwf	SysWORDTempB
	movf	SYSFORLOOPSTEP16_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF115
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	banksel	SYSFORLOOPSTEP16
	movf	SysForLoopStep16,W
	addwf	SSD1306_BUFFERLOCATIONCALC,F
	movf	SysForLoopStep16_H,W
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F
	goto	SysForLoop17
;END IF
ENDIF115
;END IF
ENDIF113
SysForLoopEnd17
;Removed at 1.14. Retained for documentation only
;Cursor_Position_SSD1306 ( 0 , 0 )
;for SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
;for GLCDTemp = 0 to 127
;Write_Data_SSD1306(GLCDBackground)
;Next
;next
;Cursor_Position_SSD1306 ( 0 , 0 )
	banksel	LOCX
	clrf	LOCX
	banksel	LOCY
	clrf	LOCY
	banksel	STATUS
	pagesel	CURSOR_POSITION_SSD1306
	call	CURSOR_POSITION_SSD1306
	pagesel	$
;PrintLocX =0
	banksel	PRINTLOCX
	clrf	PRINTLOCX
;PrintLocY =0
	clrf	PRINTLOCY
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (1341)
GLCDPRINT22
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	banksel	SYSLCDPRINTDATAHANDLER
	movf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	GLCDPRINTLEN
	movwf	GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	movf	GLCDPRINTLEN,F
	btfss	STATUS, Z
	goto	ENDIF50
;If GLCDPrintLen = 0 Then Exit Sub
	banksel	STATUS
	return
;If GLCDPrintLen = 0 Then Exit Sub
ENDIF50
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	banksel	GLCDFONTWIDTH
	movf	GLCDFONTWIDTH,W
	banksel	OLDGLCDFONTWIDTH
	movwf	OLDGLCDFONTWIDTH
;GLCDPrintLoc = PrintLocX
	movf	PRINTLOCX,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	banksel	PRINTLOCX_H
	movf	PRINTLOCX_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
;Legacy method
	clrf	GLCDPRINT_STRING_COUNTER
	movlw	1
	subwf	GLCDPRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd10
SysForLoop10
	incf	GLCDPRINT_STRING_COUNTER,F
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	movf	GLCDPRINTLOC,W
	banksel	CHARLOCX
	movwf	CHARLOCX
	banksel	GLCDPRINTLOC_H
	movf	GLCDPRINTLOC_H,W
	banksel	CHARLOCX_H
	movwf	CHARLOCX_H
	banksel	PRINTLOCY
	movf	PRINTLOCY,W
	banksel	CHARLOCY
	movwf	CHARLOCY
	banksel	PRINTLOCY_H
	movf	PRINTLOCY_H,W
	banksel	CHARLOCY_H
	movwf	CHARLOCY_H
	banksel	GLCDPRINT_STRING_COUNTER
	movf	GLCDPRINT_STRING_COUNTER,W
	banksel	SYSLCDPRINTDATAHANDLER
	addwf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	CHARCODE
	movwf	CHARCODE
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	pagesel	GLCDDRAWCHAR_SSD1306
	call	GLCDDRAWCHAR_SSD1306
	pagesel	$
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1578)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	pagesel	SYSMULTSUB
	call	SYSMULTSUB
	pagesel	$
	movf	SysBYTETempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	movwf	SysTemp1
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Next
	movf	GLCDPRINTLEN,W
	subwf	GLCDPRINT_STRING_COUNTER,W
	btfss	STATUS, C
	goto	SysForLoop10
SysForLoopEnd10
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movf	GLCDPRINTLOC,W
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	banksel	GLCDPRINTLOC_H
	movf	GLCDPRINTLOC_H,W
	banksel	PRINTLOCX_H
	movwf	PRINTLOCX_H
;GLCDFontWidth = OldGLCDFontWidth
	movf	OLDGLCDFONTWIDTH,W
	banksel	GLCDFONTWIDTH
	movwf	GLCDFONTWIDTH
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:WORD:, Source: glcd.h (1370)
GLCDPRINT23
;Dim GLCDPrintLoc as word
;GLCDPrintLen = LCDPrintData(0)
	banksel	SYSLCDPRINTDATAHANDLER
	movf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	GLCDPRINTLEN
	movwf	GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	movf	GLCDPRINTLEN,F
	btfss	STATUS, Z
	goto	ENDIF53
;If GLCDPrintLen = 0 Then Exit Sub
	banksel	STATUS
	return
;If GLCDPrintLen = 0 Then Exit Sub
ENDIF53
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	banksel	GLCDFONTWIDTH
	movf	GLCDFONTWIDTH,W
	banksel	OLDGLCDFONTWIDTH
	movwf	OLDGLCDFONTWIDTH
;GLCDPrintLoc = PrintLocX
	movf	PRINTLOCX,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	banksel	PRINTLOCX_H
	movf	PRINTLOCX_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
;Legacy method
	clrf	GLCDPRINT_STRING_COUNTER
	movlw	1
	subwf	GLCDPRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd11
SysForLoop11
	incf	GLCDPRINT_STRING_COUNTER,F
;GLCDDrawChar GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter), LineColour
	movf	GLCDPRINTLOC,W
	banksel	CHARLOCX
	movwf	CHARLOCX
	banksel	GLCDPRINTLOC_H
	movf	GLCDPRINTLOC_H,W
	banksel	CHARLOCX_H
	movwf	CHARLOCX_H
	banksel	PRINTLOCY
	movf	PRINTLOCY,W
	banksel	CHARLOCY
	movwf	CHARLOCY
	banksel	PRINTLOCY_H
	movf	PRINTLOCY_H,W
	banksel	CHARLOCY_H
	movwf	CHARLOCY_H
	banksel	GLCDPRINT_STRING_COUNTER
	movf	GLCDPRINT_STRING_COUNTER,W
	banksel	SYSLCDPRINTDATAHANDLER
	addwf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	CHARCODE
	movwf	CHARCODE
	pagesel	GLCDDRAWCHAR_SSD1306
	call	GLCDDRAWCHAR_SSD1306
	pagesel	$
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1578)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	pagesel	SYSMULTSUB
	call	SYSMULTSUB
	pagesel	$
	movf	SysBYTETempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	movwf	SysTemp1
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Next
	movf	GLCDPRINTLEN,W
	subwf	GLCDPRINT_STRING_COUNTER,W
	btfss	STATUS, C
	goto	SysForLoop11
SysForLoopEnd11
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movf	GLCDPRINTLOC,W
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	banksel	GLCDPRINTLOC_H
	movf	GLCDPRINTLOC_H,W
	banksel	PRINTLOCX_H
	movwf	PRINTLOCX_H
;GLCDFontWidth = OldGLCDFontWidth
	movf	OLDGLCDFONTWIDTH,W
	banksel	GLCDFONTWIDTH
	movwf	GLCDFONTWIDTH
	return

;********************************************************************************

OLEDFONT1INDEX
	movlw	97
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEOLEDFONT1INDEX
	movwf	SysStringA
	movlw	(high TABLEOLEDFONT1INDEX) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEOLEDFONT1INDEX
	retlw	96
	retlw	1
	retlw	3
	retlw	5
	retlw	9
	retlw	15
	retlw	21
	retlw	25
	retlw	31
	retlw	33
	retlw	36
	retlw	39
	retlw	45
	retlw	49
	retlw	51
	retlw	55
	retlw	57
	retlw	61
	retlw	66
	retlw	70
	retlw	75
	retlw	79
	retlw	84
	retlw	88
	retlw	93
	retlw	97
	retlw	102
	retlw	107
	retlw	109
	retlw	112
	retlw	116
	retlw	120
	retlw	124
	retlw	128
	retlw	134
	retlw	139
	retlw	144
	retlw	149
	retlw	154
	retlw	158
	retlw	162
	retlw	167
	retlw	172
	retlw	176
	retlw	180
	retlw	185
	retlw	189
	retlw	195
	retlw	201
	retlw	206
	retlw	211
	retlw	216
	retlw	221
	retlw	226
	retlw	230
	retlw	235
	retlw	241
	retlw	247
	retlw	253
	retlw	2
	retlw	7
	retlw	10
	retlw	14
	retlw	17
	retlw	21
	retlw	26
	retlw	29
	retlw	34
	retlw	39
	retlw	44
	retlw	49
	retlw	54
	retlw	57
	retlw	62
	retlw	67
	retlw	69
	retlw	72
	retlw	77
	retlw	79
	retlw	85
	retlw	90
	retlw	95
	retlw	100
	retlw	105
	retlw	108
	retlw	113
	retlw	117
	retlw	122
	retlw	128
	retlw	134
	retlw	140
	retlw	145
	retlw	149
	retlw	153
	retlw	155
	retlw	159
	retlw	164

;********************************************************************************

OLEDFONT1INDEX_H
	movlw	97
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEOLEDFONT1INDEX_H
	movwf	SysStringA
	movlw	(high TABLEOLEDFONT1INDEX_H) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEOLEDFONT1INDEX_H
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1

;********************************************************************************

;Source: GLCD_SSD1306.H (952)
PSET_SSD1306
;Set pixel at X, Y on LCD to State
;X is 0 to 127
;Y is 0 to 63
;Origin in top left
;1.14 Addresses correct device horizonal page
;don't need to do these calculations for in LOWMEMORY_GLCD_MODE
;SSD1306_BufferLocationCalc = ( GLCDY / 8 )* GLCD_WIDTH
;faster than /8
;SSD1306_BufferLocationCalc = GLCDY
	banksel	GLCDY
	movf	GLCDY,W
	banksel	SSD1306_BUFFERLOCATIONCALC
	movwf	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H
;Repeat 3
	movlw	3
	banksel	SYSREPEATTEMP6
	movwf	SysRepeatTemp6
SysRepeatLoop6
;Set C Off
	bcf	STATUS,C
;Rotate SSD1306_BufferLocationCalc Right
	banksel	SSD1306_BUFFERLOCATIONCALC_H
	rrf	SSD1306_BUFFERLOCATIONCALC_H,F
	rrf	SSD1306_BUFFERLOCATIONCALC,F
;End Repeat
	banksel	SYSREPEATTEMP6
	decfsz	SysRepeatTemp6,F
	goto	SysRepeatLoop6
SysRepeatLoopEnd6
;faster than * 128
;Set C Off
	bcf	STATUS,C
;Repeat 7
	movlw	7
	movwf	SysRepeatTemp6
SysRepeatLoop7
;Rotate SSD1306_BufferLocationCalc Left
	banksel	SSD1306_BUFFERLOCATIONCALC
	rlf	SSD1306_BUFFERLOCATIONCALC,F
	rlf	SSD1306_BUFFERLOCATIONCALC_H,F
;End Repeat
	banksel	SYSREPEATTEMP6
	decfsz	SysRepeatTemp6,F
	goto	SysRepeatLoop7
SysRepeatLoopEnd7
;SSD1306_BufferLocationCalc = GLCDX + SSD1306_BufferLocationCalc + 1
	banksel	SSD1306_BUFFERLOCATIONCALC
	movf	SSD1306_BUFFERLOCATIONCALC,W
	banksel	GLCDX
	addwf	GLCDX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysTemp3
	banksel	SSD1306_BUFFERLOCATIONCALC_H
	movf	SSD1306_BUFFERLOCATIONCALC_H,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	banksel	SSD1306_BUFFERLOCATIONCALC
	movwf	SSD1306_BUFFERLOCATIONCALC
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	SSD1306_BUFFERLOCATIONCALC_H
	movwf	SSD1306_BUFFERLOCATIONCALC_H
;GLCDDataTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
	movlw	low(SSD1306_BUFFERALIAS)
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	GLCDDATATEMP
	movwf	GLCDDATATEMP
;Change data to set/clear pixel
;GLCDBitNo = GLCDY And 7
	movlw	7
	banksel	GLCDY
	andwf	GLCDY,W
	banksel	GLCDBITNO
	movwf	GLCDBITNO
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0
	goto	ELSE133_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE
;Set C On
	bsf	STATUS,C
;Else
	goto	ENDIF133
ELSE133_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE
;Set C Off
	bcf	STATUS,C
;End If
ENDIF133
;Repeat GLCDBitNo
	movf	GLCDBITNO,W
	banksel	SYSREPEATTEMP6
	movwf	SysRepeatTemp6
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd8
SysRepeatLoop8
;Rotate GLCDChange Left
	banksel	GLCDCHANGE
	rlf	GLCDCHANGE,F
;End Repeat
	banksel	SYSREPEATTEMP6
	decfsz	SysRepeatTemp6,F
	goto	SysRepeatLoop8
SysRepeatLoopEnd8
;If GLCDColour.0 = 0 Then
	banksel	GLCDCOLOUR
	btfsc	GLCDCOLOUR,0
	goto	ELSE134_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	movf	GLCDDATATEMP,W
	andwf	GLCDCHANGE,W
	movwf	GLCDDATATEMP
;Else
	goto	ENDIF134
ELSE134_1
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	movf	GLCDDATATEMP,W
	iorwf	GLCDCHANGE,W
	movwf	GLCDDATATEMP
;End If
ENDIF134
;added 1.14 to isolate from full glcd mode
;revised 1.14 to isolate from low memory mode
;if SSD1306_BufferAlias(SSD1306_BufferLocationCalc) <> GLCDDataTemp then
	movlw	low(SSD1306_BUFFERALIAS)
	banksel	SSD1306_BUFFERLOCATIONCALC
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	banksel	GLCDDATATEMP
	movf	GLCDDATATEMP,W
	subwf	INDF0,W
	btfsc	STATUS, Z
	goto	ENDIF135
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDDataTemp
	movlw	low(SSD1306_BUFFERALIAS)
	banksel	SSD1306_BUFFERLOCATIONCALC
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	banksel	GLCDDATATEMP
	movf	GLCDDATATEMP,W
	movwf	INDF0
;Cursor_Position_SSD1306 ( GLCDX, GLCDY )
	banksel	GLCDX
	movf	GLCDX,W
	movwf	LOCX
	movf	GLCDY,W
	banksel	LOCY
	movwf	LOCY
	banksel	STATUS
	pagesel	CURSOR_POSITION_SSD1306
	call	CURSOR_POSITION_SSD1306
	pagesel	$
;Write_Data_SSD1306 ( GLCDDataTemp )
	movf	GLCDDATATEMP,W
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_DATA_SSD1306
	call	WRITE_DATA_SSD1306
	pagesel	$
;end if
ENDIF135
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2457)
FN_READAD1093
;Always RIGHT justified
;SET ADFM ON
	banksel	ADCON1
	bsf	ADCON1,ADFM
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (637)
;Handle devices with no ANSEL0 AND no ANSEL
;Code for devices with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;#ifdef Bit(CHS5)
;Case 0: Set ANSELA.0 On
SysSelect5Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect5Case2
;Case 0: Set ANSELA.0 On
	banksel	ANSELA
	bsf	ANSELA,0
;Case 1: Set ANSELA.1 On
	goto	SysSelectEnd5
SysSelect5Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect5Case3
;Case 1: Set ANSELA.1 On
	banksel	ANSELA
	bsf	ANSELA,1
;Case 2: Set ANSELA.2 On
	goto	SysSelectEnd5
SysSelect5Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect5Case4
;Case 2: Set ANSELA.2 On
	banksel	ANSELA
	bsf	ANSELA,2
;Case 3: Set ANSELA.4 On
	goto	SysSelectEnd5
SysSelect5Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect5Case5
;Case 3: Set ANSELA.4 On
	banksel	ANSELA
	bsf	ANSELA,4
;Case 4: Set ANSELA.5 On
	goto	SysSelectEnd5
SysSelect5Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect5Case6
;Case 4: Set ANSELA.5 On
	banksel	ANSELA
	bsf	ANSELA,5
;Case 16: Set ANSELC.0 On
	goto	SysSelectEnd5
SysSelect5Case6
	movlw	16
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect5Case7
;Case 16: Set ANSELC.0 On
	banksel	ANSELC
	bsf	ANSELC,0
;Case 17: Set ANSELC.1 On
	goto	SysSelectEnd5
SysSelect5Case7
	movlw	17
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect5Case8
;Case 17: Set ANSELC.1 On
	banksel	ANSELC
	bsf	ANSELC,1
;Case 18: Set ANSELC.2 On
	goto	SysSelectEnd5
SysSelect5Case8
	movlw	18
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect5Case9
;Case 18: Set ANSELC.2 On
	banksel	ANSELC
	bsf	ANSELC,2
;Case 19: Set ANSELC.3 On
	goto	SysSelectEnd5
SysSelect5Case9
	movlw	19
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect5Case10
;Case 19: Set ANSELC.3 On
	banksel	ANSELC
	bsf	ANSELC,3
;Case 20: Set ANSELC.4 On
	goto	SysSelectEnd5
SysSelect5Case10
	movlw	20
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect5Case11
;Case 20: Set ANSELC.4 On
	banksel	ANSELC
	bsf	ANSELC,4
;Case 21: Set ANSELC.5 On
	goto	SysSelectEnd5
SysSelect5Case11
	movlw	21
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd5
;Case 21: Set ANSELC.5 On
	banksel	ANSELC
	bsf	ANSELC,5
;End Select  'End Select #1
SysSelectEnd5
;SET ADCS2 OFF
	banksel	ADCON1
	bcf	ADCON1,ADCS2
;SET ADCS1 OFF
	bcf	ADCON1,ADCS1
;SET ADCS0 ON
	bsf	ADCON1,ADCS0
;Choose port
;SET CHS0 OFF
	bcf	ADCON0,CHS0
;SET CHS1 OFF
	bcf	ADCON0,CHS1
;SET CHS2 OFF
	bcf	ADCON0,CHS2
;SET CHS3 OFF
	bcf	ADCON0,CHS3
;SET CHS4 OFF
	bcf	ADCON0,CHS4
;SET CHS5 OFF
	bcf	ADCON0,CHS5
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADREADPORT
	btfss	ADREADPORT,0
	goto	ENDIF157
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADCON0
	bsf	ADCON0,CHS0
;IF ADReadPort.0 On Then Set CHS0 On
ENDIF157
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADREADPORT
	btfss	ADREADPORT,1
	goto	ENDIF158
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADCON0
	bsf	ADCON0,CHS1
;IF ADReadPort.1 On Then Set CHS1 On
ENDIF158
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADREADPORT
	btfss	ADREADPORT,2
	goto	ENDIF159
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADCON0
	bsf	ADCON0,CHS2
;IF ADReadPort.2 On Then Set CHS2 On
ENDIF159
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADREADPORT
	btfss	ADREADPORT,3
	goto	ENDIF160
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADCON0
	bsf	ADCON0,CHS3
;If ADReadPort.3 On Then Set CHS3 On
ENDIF160
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADREADPORT
	btfss	ADREADPORT,4
	goto	ENDIF161
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADCON0
	bsf	ADCON0,CHS4
;If ADReadPort.4 On Then Set CHS4 On
ENDIF161
;If ADReadPort.5 On Then Set CHS5 On
	banksel	ADREADPORT
	btfss	ADREADPORT,5
	goto	ENDIF162
;If ADReadPort.5 On Then Set CHS5 On
	banksel	ADCON0
	bsf	ADCON0,CHS5
;If ADReadPort.5 On Then Set CHS5 On
ENDIF162
;Enable AD Operations
;SET ADON ON
	banksel	ADCON0
	bsf	ADCON0,ADON
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	pagesel	Delay_10US
	call	Delay_10US
	pagesel	$
;Read A/D @1
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop1
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop1
;Switch off A/D
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELC = 0
	clrf	ANSELC
;Write output
;ReadAD10 = ADRESL
	banksel	ADRESL
	movf	ADRESL,W
	banksel	READAD10
	movwf	READAD10
	clrf	READAD10_H
;ReadAD10_H = ADRESH
	banksel	ADRESH
	movf	ADRESH,W
	banksel	READAD10_H
	movwf	READAD10_H
;Put A/D format back to normal
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
	banksel	STATUS
	return

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (346)
SHOWDISPLAY
;DrawTitle("5 Display")
	movlw	low StringTable15
	banksel	SYSTITLETEXTHANDLER
	movwf	SysTITLETEXTHandler
	movlw	(high StringTable15) | 128
	movwf	SysTITLETEXTHandler_H
	banksel	STATUS
	pagesel	DRAWTITLE
	call	DRAWTITLE
	pagesel	$
;GLCDPrint(0, 14, "Contrast: dim   ")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	14
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable16
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable16) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	call	GLCDPRINT22
;GLCDSetContrast(0x08)
	movlw	8
	movwf	DIM_STATE
	pagesel	SETCONTRAST_SSD1306
	call	SETCONTRAST_SSD1306
	pagesel	$
;If WaitPart(1500) = 1 Then GoTo DisplayDone
	movlw	220
	banksel	PARTMS
	movwf	PARTMS
	movlw	5
	movwf	PARTMS_H
	banksel	STATUS
	pagesel	FN_WAITPART
	call	FN_WAITPART
	pagesel	$
	banksel	WAITPART
	decf	WAITPART,W
	btfsc	STATUS, Z
;If WaitPart(1500) = 1 Then GoTo DisplayDone
	goto	DISPLAYDONE
;If WaitPart(1500) = 1 Then GoTo DisplayDone
;GLCDPrint(0, 14, "Contrast: bright")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	14
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable17
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable17) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	call	GLCDPRINT22
;GLCDSetContrast(0xFF)
	movlw	255
	movwf	DIM_STATE
	pagesel	SETCONTRAST_SSD1306
	call	SETCONTRAST_SSD1306
	pagesel	$
;If WaitPart(1500) = 1 Then GoTo DisplayDone
	movlw	220
	banksel	PARTMS
	movwf	PARTMS
	movlw	5
	movwf	PARTMS_H
	banksel	STATUS
	pagesel	FN_WAITPART
	call	FN_WAITPART
	pagesel	$
	banksel	WAITPART
	decf	WAITPART,W
	btfsc	STATUS, Z
;If WaitPart(1500) = 1 Then GoTo DisplayDone
	goto	DISPLAYDONE
;If WaitPart(1500) = 1 Then GoTo DisplayDone
;GLCDSetContrast(GLCD_SSD1306_CONTRAST)          ' the contrast InitGLCD set
	banksel	GLCD_SSD1306_CONTRAST
	movf	GLCD_SSD1306_CONTRAST,W
	banksel	DIM_STATE
	movwf	DIM_STATE
	pagesel	SETCONTRAST_SSD1306
	call	SETCONTRAST_SSD1306
	pagesel	$
;GLCDPrint(0, 14, "Invert mode     ")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	14
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable18
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable18) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	call	GLCDPRINT22
;GLCDSetDisplayInvertMode
GLCDSETDISPLAYINVERTMODE	;?F1L356S10I10?
;If WaitPart(1500) = 1 Then GoTo DisplayDone
	movlw	220
	banksel	PARTMS
	movwf	PARTMS
	movlw	5
	movwf	PARTMS_H
	banksel	STATUS
	pagesel	FN_WAITPART
	call	FN_WAITPART
	pagesel	$
	banksel	WAITPART
	decf	WAITPART,W
	btfsc	STATUS, Z
;If WaitPart(1500) = 1 Then GoTo DisplayDone
	goto	DISPLAYDONE
;If WaitPart(1500) = 1 Then GoTo DisplayDone
;GLCDSetDisplayNormalMode
GLCDSETDISPLAYNORMALMODE	;?F1L358S10I12?
;GLCDRotate(LANDSCAPE_REV)                       ' 180 degrees: redraw the screen after a rotate
	movlw	3
	banksel	ADDRESSTYPE
	movwf	ADDRESSTYPE
	pagesel	GLCDROTATE
	call	GLCDROTATE
	pagesel	$
;GLCDCLS
	call	GLCDCLS_SSD1306
;GLCDPrint(0, 0, "5 Display")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable15
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable15) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	call	GLCDPRINT22
;GLCDPrint(0, 14, "Rotated 180 deg")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	14
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable19
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable19) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	call	GLCDPRINT22
;If WaitPart(2000) = 1 Then GoTo DisplayDone
	movlw	208
	banksel	PARTMS
	movwf	PARTMS
	movlw	7
	movwf	PARTMS_H
	banksel	STATUS
	pagesel	FN_WAITPART
	call	FN_WAITPART
	pagesel	$
	banksel	WAITPART
	decf	WAITPART,W
	btfsc	STATUS, Z
;If WaitPart(2000) = 1 Then GoTo DisplayDone
	goto	DISPLAYDONE
;If WaitPart(2000) = 1 Then GoTo DisplayDone
DISPLAYDONE
;GLCDSetContrast(GLCD_SSD1306_CONTRAST)
	banksel	GLCD_SSD1306_CONTRAST
	movf	GLCD_SSD1306_CONTRAST,W
	banksel	DIM_STATE
	movwf	DIM_STATE
	pagesel	SETCONTRAST_SSD1306
	call	SETCONTRAST_SSD1306
	pagesel	$
;GLCDSetDisplayNormalMode
GLCDSETDISPLAYNORMALMODE	;?F1L366S10I20?
;GLCDRotate(LANDSCAPE)
	movlw	1
	movwf	ADDRESSTYPE
	pagesel	GLCDROTATE
	goto	GLCDROTATE

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (134)
SHOWTEXT
;TimeStart
	pagesel	TIMESTART
	call	TIMESTART
	pagesel	$
;DrawTitle("1 Text")
	movlw	low StringTable4
	banksel	SYSTITLETEXTHANDLER
	movwf	SysTITLETEXTHandler
	movlw	(high StringTable4) | 128
	movwf	SysTITLETEXTHandler_H
	banksel	STATUS
	pagesel	DRAWTITLE
	call	DRAWTITLE
	pagesel	$
;GLCDPrint(0, 13, "GLCDPrint, size 1")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	13
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable5
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	call	GLCDPRINT22
;GLCDfntDefaultsize = 2
	movlw	2
	movwf	GLCDFNTDEFAULTSIZE
;GLCDPrint(0, 23, "SSD1306")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	23
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable6
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	call	GLCDPRINT22
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;GLCDPrint(0, 41, "Number:")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	41
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable7
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	call	GLCDPRINT22
;GLCDPrint(48, 41, 12345)
	movlw	48
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	41
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	57
	movwf	LCDVALUE
	movlw	48
	movwf	LCDVALUE_H
	clrf	LCDVALUE_U
	clrf	LCDVALUE_E
	banksel	STATUS
	pagesel	GLCDPRINT25
	call	GLCDPRINT25
	pagesel	$
;FilledBox(0, 52, 127, 63)
	banksel	LINEX1
	clrf	LINEX1
	movlw	52
	movwf	LINEY1
	movlw	127
	movwf	LINEX2
	movlw	63
	movwf	LINEY2
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	call	FILLEDBOX_SSD1306
;GLCDPrint(4, 54, "inverse text", GLCDBackground)
	movlw	4
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	54
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable8
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	GLCDBACKGROUND
	movf	GLCDBACKGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDBACKGROUND_H
	movf	GLCDBACKGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	call	GLCDPRINT23
;DrawMs = TimeMs                                 ' the time to draw the screen (GLCDCLS included)
	pagesel	FN_TIMEMS
	call	FN_TIMEMS
	pagesel	$
	banksel	TIMEMS
	movf	TIMEMS,W
	banksel	DRAWMS
	movwf	DRAWMS
	banksel	TIMEMS_H
	movf	TIMEMS_H,W
	banksel	DRAWMS_H
	movwf	DRAWMS_H
;ShowDigits(54, 0, DrawMs)
	movlw	54
	movwf	DIGITX
	clrf	DIGITX_H
	clrf	DIGITY
	clrf	DIGITY_H
	movf	DRAWMS,W
	movwf	DIGITIN
	movf	DRAWMS_H,W
	movwf	DIGITIN_H
	pagesel	SHOWDIGITS
	call	SHOWDIGITS
	pagesel	$
;GLCDPrint(78, 0, "ms")
	movlw	78
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable9
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable9) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	call	GLCDPRINT22
;WaitScreen
	pagesel	WAITSCREEN
	goto	WAITSCREEN

;********************************************************************************

;Source: GLCD_SSD1306.H (1223)
SSD1306_HLINE
;dim SSD1306_HLPage, SSD1306_HLMask, SSD1306_HLValue, SSD1306_HLCol1, SSD1306_HLCol2, SSD1306_HLRow as byte
;If HLY > GLCD_HEIGHT - 1 Then Exit Sub
	banksel	HLY
	movf	HLY,W
	movwf	SysWORDTempB
	movf	HLY_H,W
	movwf	SysWORDTempB_H
	movlw	63
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
;If HLY > GLCD_HEIGHT - 1 Then Exit Sub
	return
;If HLY > GLCD_HEIGHT - 1 Then Exit Sub
;If HLX1 > GLCD_WIDTH - 1 Then Exit Sub
	banksel	HLX1
	movf	HLX1,W
	movwf	SysWORDTempB
	movf	HLX1_H,W
	movwf	SysWORDTempB_H
	movlw	127
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
;If HLX1 > GLCD_WIDTH - 1 Then Exit Sub
	return
;If HLX1 > GLCD_WIDTH - 1 Then Exit Sub
;SSD1306_HLCol1 = HLX1
	banksel	HLX1
	movf	HLX1,W
	banksel	SSD1306_HLCOL1
	movwf	SSD1306_HLCOL1
;SSD1306_HLCol2 = GLCD_WIDTH - 1
	movlw	127
	movwf	SSD1306_HLCOL2
;If HLX2 < GLCD_WIDTH Then SSD1306_HLCol2 = HLX2
	banksel	HLX2
	movf	HLX2,W
	movwf	SysWORDTempA
	movf	HLX2_H,W
	movwf	SysWORDTempA_H
	movlw	128
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF177
;If HLX2 < GLCD_WIDTH Then SSD1306_HLCol2 = HLX2
	banksel	HLX2
	movf	HLX2,W
	banksel	SSD1306_HLCOL2
	movwf	SSD1306_HLCOL2
;If HLX2 < GLCD_WIDTH Then SSD1306_HLCol2 = HLX2
ENDIF177
;SSD1306_HLRow = HLY
	banksel	HLY
	movf	HLY,W
	banksel	SSD1306_HLROW
	movwf	SSD1306_HLROW
;SSD1306_HLPage = SSD1306_HLRow
	movwf	SSD1306_HLPAGE
;Repeat 3
	movlw	3
	movwf	SysRepeatTemp13
SysRepeatLoop13
;Set C Off
	bcf	STATUS,C
;Rotate SSD1306_HLPage Right
	rrf	SSD1306_HLPAGE,F
;End Repeat
	decfsz	SysRepeatTemp13,F
	goto	SysRepeatLoop13
SysRepeatLoopEnd13
;SSD1306_HLMask = SSD1306_RowMask ( SSD1306_HLPage, SSD1306_HLRow, SSD1306_HLRow )
	movf	SSD1306_HLPAGE,W
	banksel	RMPAGE
	movwf	RMPAGE
	banksel	SSD1306_HLROW
	movf	SSD1306_HLROW,W
	banksel	RMY1
	movwf	RMY1
	banksel	SSD1306_HLROW
	movf	SSD1306_HLROW,W
	banksel	RMY2
	movwf	RMY2
	banksel	STATUS
	call	FN_SSD1306_ROWMASK
	banksel	SSD1306_ROWMASK
	movf	SSD1306_ROWMASK,W
	movwf	SSD1306_HLMASK
;SSD1306_HLValue = 0
	clrf	SSD1306_HLVALUE
;If HLColour.0 = 1 Then SSD1306_HLValue = 0xFF
	banksel	HLCOLOUR
	btfss	HLCOLOUR,0
	goto	ENDIF178
;If HLColour.0 = 1 Then SSD1306_HLValue = 0xFF
	movlw	255
	banksel	SSD1306_HLVALUE
	movwf	SSD1306_HLVALUE
;If HLColour.0 = 1 Then SSD1306_HLValue = 0xFF
ENDIF178
;SSD1306_PutRow ( SSD1306_HLCol1, SSD1306_HLCol2, SSD1306_HLPage, SSD1306_HLValue, SSD1306_HLMask )
	banksel	SSD1306_HLCOL1
	movf	SSD1306_HLCOL1,W
	banksel	RPCOL1
	movwf	RPCOL1
	banksel	SSD1306_HLCOL2
	movf	SSD1306_HLCOL2,W
	banksel	RPCOL2
	movwf	RPCOL2
	banksel	SSD1306_HLPAGE
	movf	SSD1306_HLPAGE,W
	banksel	RPPAGE
	movwf	RPPAGE
	banksel	SSD1306_HLVALUE
	movf	SSD1306_HLVALUE,W
	banksel	RPVALUE
	movwf	RPVALUE
	banksel	SSD1306_HLMASK
	movf	SSD1306_HLMASK,W
	banksel	RPMASK
	movwf	RPMASK
	banksel	STATUS
	pagesel	SSD1306_PUTROW
	goto	SSD1306_PUTROW

;********************************************************************************

;Source: GLCD_SSD1306.H (1134)
SSD1306_PUTBYTE
;dim SSD1306_PBOld as byte
;SSD1306_BufferLocationCalc = PBPage
	banksel	PBPAGE
	movf	PBPAGE,W
	banksel	SSD1306_BUFFERLOCATIONCALC
	movwf	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H
;Set C Off
	bcf	STATUS,C
;Repeat 7
	movlw	7
	movwf	SysRepeatTemp15
SysRepeatLoop15
;Rotate SSD1306_BufferLocationCalc Left
	rlf	SSD1306_BUFFERLOCATIONCALC,F
	rlf	SSD1306_BUFFERLOCATIONCALC_H,F
;End Repeat
	decfsz	SysRepeatTemp15,F
	goto	SysRepeatLoop15
SysRepeatLoopEnd15
;SSD1306_BufferLocationCalc = PBCol + SSD1306_BufferLocationCalc + 1
	movf	SSD1306_BUFFERLOCATIONCALC,W
	banksel	PBCOL
	addwf	PBCOL,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysTemp3
	banksel	SSD1306_BUFFERLOCATIONCALC_H
	movf	SSD1306_BUFFERLOCATIONCALC_H,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	banksel	SSD1306_BUFFERLOCATIONCALC
	movwf	SSD1306_BUFFERLOCATIONCALC
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	SSD1306_BUFFERLOCATIONCALC_H
	movwf	SSD1306_BUFFERLOCATIONCALC_H
;SSD1306_PBOld = SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
	movlw	low(SSD1306_BUFFERALIAS)
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SSD1306_PBOLD
;GLCDDataTemp = ( SSD1306_PBOld And ( Not PBMask ) ) Or ( PBValue And PBMask )
	banksel	PBMASK
	comf	PBMASK,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	SSD1306_PBOLD
	movf	SSD1306_PBOLD,W
	banksel	SYSTEMP3
	andwf	SysTemp3,W
	movwf	SysTemp1
	banksel	PBVALUE
	movf	PBVALUE,W
	andwf	PBMASK,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	movf	SysTemp1,W
	iorwf	SysTemp3,W
	banksel	GLCDDATATEMP
	movwf	GLCDDATATEMP
;If GLCDDataTemp <> SSD1306_PBOld Then
	banksel	SSD1306_PBOLD
	movf	SSD1306_PBOLD,W
	banksel	GLCDDATATEMP
	subwf	GLCDDATATEMP,W
	btfsc	STATUS, Z
	goto	ENDIF184
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDDataTemp
	movlw	low(SSD1306_BUFFERALIAS)
	banksel	SSD1306_BUFFERLOCATIONCALC
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	banksel	GLCDDATATEMP
	movf	GLCDDATATEMP,W
	movwf	INDF0
;Cursor_Position_SSD1306 ( PBCol, PBPage * 8 )
	banksel	PBCOL
	movf	PBCOL,W
	banksel	LOCX
	movwf	LOCX
	banksel	PBPAGE
	movf	PBPAGE,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SYSMULTSUB
	call	SYSMULTSUB
	pagesel	$
	movf	SysBYTETempX,W
	banksel	LOCY
	movwf	LOCY
	banksel	STATUS
	pagesel	CURSOR_POSITION_SSD1306
	call	CURSOR_POSITION_SSD1306
	pagesel	$
;Write_Data_SSD1306 ( GLCDDataTemp )
	movf	GLCDDATATEMP,W
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	pagesel	WRITE_DATA_SSD1306
	call	WRITE_DATA_SSD1306
	pagesel	$
;End If
ENDIF184
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (1114)
FN_SSD1306_ROWMASK
;dim SSD1306_RMTop, SSD1306_RMBits as byte
;SSD1306_RMTop = RMPage * 8
	banksel	RMPAGE
	movf	RMPAGE,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SYSMULTSUB
	call	SYSMULTSUB
	pagesel	$
	movf	SysBYTETempX,W
	banksel	SSD1306_RMTOP
	movwf	SSD1306_RMTOP
;SSD1306_RowMask = 0
	clrf	SSD1306_ROWMASK
;If RMY2 < SSD1306_RMTop Then Exit Function
	movf	SSD1306_RMTOP,W
	banksel	RMY2
	subwf	RMY2,W
	btfsc	STATUS, C
	goto	ENDIF136
;If RMY2 < SSD1306_RMTop Then Exit Function
	banksel	STATUS
	return
;If RMY2 < SSD1306_RMTop Then Exit Function
ENDIF136
;If RMY1 > SSD1306_RMTop + 7 Then Exit Function
	movlw	7
	banksel	SSD1306_RMTOP
	addwf	SSD1306_RMTOP,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	RMY1
	movf	RMY1,W
	movwf	SysBYTETempB
	banksel	SYSTEMP3
	movf	SysTemp3,W
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfsc	SysByteTempX,0
;If RMY1 > SSD1306_RMTop + 7 Then Exit Function
	return
;If RMY1 > SSD1306_RMTop + 7 Then Exit Function
;SSD1306_RowMask = 0xFF
	movlw	255
	banksel	SSD1306_ROWMASK
	movwf	SSD1306_ROWMASK
;If RMY1 > SSD1306_RMTop Then
	banksel	RMY1
	movf	RMY1,W
	banksel	SSD1306_RMTOP
	subwf	SSD1306_RMTOP,W
	btfsc	STATUS, C
	goto	ENDIF138
;ReadTable SSD1306_TopMask, ( RMY1 And 7 ) + 1, SSD1306_RowMask
	movlw	7
	banksel	RMY1
	andwf	RMY1,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	incf	SysTemp3,W
	movwf	SYSSTRINGA
	banksel	STATUS
	pagesel	SSD1306_TOPMASK
	call	SSD1306_TOPMASK
	pagesel	$
	banksel	SSD1306_ROWMASK
	movwf	SSD1306_ROWMASK
;End If
ENDIF138
;If RMY2 < SSD1306_RMTop + 7 Then
	movlw	7
	addwf	SSD1306_RMTOP,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	RMY2
	movf	RMY2,W
	movwf	SysBYTETempA
	banksel	SYSTEMP3
	movf	SysTemp3,W
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF139
;ReadTable SSD1306_BottomMask, ( RMY2 And 7 ) + 1, SSD1306_RMBits
	movlw	7
	banksel	RMY2
	andwf	RMY2,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	incf	SysTemp3,W
	movwf	SYSSTRINGA
	banksel	STATUS
	pagesel	SSD1306_BOTTOMMASK
	call	SSD1306_BOTTOMMASK
	pagesel	$
	banksel	SSD1306_RMBITS
	movwf	SSD1306_RMBITS
;SSD1306_RowMask = SSD1306_RowMask And SSD1306_RMBits
	movf	SSD1306_ROWMASK,W
	andwf	SSD1306_RMBITS,W
	movwf	SSD1306_ROWMASK
;End If
ENDIF139
	banksel	STATUS
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (1245)
SSD1306_VLINE
;dim SSD1306_VLPage, SSD1306_VLLast, SSD1306_VLMask, SSD1306_VLValue, SSD1306_VLCol, SSD1306_VLR1, SSD1306_VLR2 as byte
;If VLX > GLCD_WIDTH - 1 Then Exit Sub
	banksel	VLX
	movf	VLX,W
	movwf	SysWORDTempB
	movf	VLX_H,W
	movwf	SysWORDTempB_H
	movlw	127
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
;If VLX > GLCD_WIDTH - 1 Then Exit Sub
	return
;If VLX > GLCD_WIDTH - 1 Then Exit Sub
;If VLY1 > GLCD_HEIGHT - 1 Then Exit Sub
	banksel	VLY1
	movf	VLY1,W
	movwf	SysWORDTempB
	movf	VLY1_H,W
	movwf	SysWORDTempB_H
	movlw	63
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
;If VLY1 > GLCD_HEIGHT - 1 Then Exit Sub
	return
;If VLY1 > GLCD_HEIGHT - 1 Then Exit Sub
;SSD1306_VLCol = VLX
	banksel	VLX
	movf	VLX,W
	banksel	SSD1306_VLCOL
	movwf	SSD1306_VLCOL
;SSD1306_VLR1 = VLY1
	banksel	VLY1
	movf	VLY1,W
	banksel	SSD1306_VLR1
	movwf	SSD1306_VLR1
;SSD1306_VLR2 = GLCD_HEIGHT - 1
	movlw	63
	movwf	SSD1306_VLR2
;If VLY2 < GLCD_HEIGHT Then SSD1306_VLR2 = VLY2
	banksel	VLY2
	movf	VLY2,W
	movwf	SysWORDTempA
	movf	VLY2_H,W
	movwf	SysWORDTempA_H
	movlw	64
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF181
;If VLY2 < GLCD_HEIGHT Then SSD1306_VLR2 = VLY2
	banksel	VLY2
	movf	VLY2,W
	banksel	SSD1306_VLR2
	movwf	SSD1306_VLR2
;If VLY2 < GLCD_HEIGHT Then SSD1306_VLR2 = VLY2
ENDIF181
;SSD1306_VLValue = 0
	banksel	SSD1306_VLVALUE
	clrf	SSD1306_VLVALUE
;If VLColour.0 = 1 Then SSD1306_VLValue = 0xFF
	banksel	VLCOLOUR
	btfss	VLCOLOUR,0
	goto	ENDIF182
;If VLColour.0 = 1 Then SSD1306_VLValue = 0xFF
	movlw	255
	banksel	SSD1306_VLVALUE
	movwf	SSD1306_VLVALUE
;If VLColour.0 = 1 Then SSD1306_VLValue = 0xFF
ENDIF182
;SSD1306_VLPage = SSD1306_VLR1
	banksel	SSD1306_VLR1
	movf	SSD1306_VLR1,W
	movwf	SSD1306_VLPAGE
;SSD1306_VLLast = SSD1306_VLR2
	movf	SSD1306_VLR2,W
	movwf	SSD1306_VLLAST
;Repeat 3
	movlw	3
	movwf	SysRepeatTemp14
SysRepeatLoop14
;Set C Off
	bcf	STATUS,C
;Rotate SSD1306_VLPage Right
	rrf	SSD1306_VLPAGE,F
;Set C Off
	bcf	STATUS,C
;Rotate SSD1306_VLLast Right
	rrf	SSD1306_VLLAST,F
;End Repeat
	decfsz	SysRepeatTemp14,F
	goto	SysRepeatLoop14
SysRepeatLoopEnd14
;Do
SysDoLoop_S14
;SSD1306_VLMask = SSD1306_RowMask ( SSD1306_VLPage, SSD1306_VLR1, SSD1306_VLR2 )
	movf	SSD1306_VLPAGE,W
	banksel	RMPAGE
	movwf	RMPAGE
	banksel	SSD1306_VLR1
	movf	SSD1306_VLR1,W
	banksel	RMY1
	movwf	RMY1
	banksel	SSD1306_VLR2
	movf	SSD1306_VLR2,W
	banksel	RMY2
	movwf	RMY2
	banksel	STATUS
	call	FN_SSD1306_ROWMASK
	banksel	SSD1306_ROWMASK
	movf	SSD1306_ROWMASK,W
	movwf	SSD1306_VLMASK
;SSD1306_PutByte ( SSD1306_VLCol, SSD1306_VLPage, SSD1306_VLValue, SSD1306_VLMask )
	movf	SSD1306_VLCOL,W
	banksel	PBCOL
	movwf	PBCOL
	banksel	SSD1306_VLPAGE
	movf	SSD1306_VLPAGE,W
	banksel	PBPAGE
	movwf	PBPAGE
	banksel	SSD1306_VLVALUE
	movf	SSD1306_VLVALUE,W
	banksel	PBVALUE
	movwf	PBVALUE
	banksel	SSD1306_VLMASK
	movf	SSD1306_VLMASK,W
	banksel	PBMASK
	movwf	PBMASK
	banksel	STATUS
	call	SSD1306_PUTBYTE
;If SSD1306_VLPage = SSD1306_VLLast Then Exit Do
	banksel	SSD1306_VLLAST
	movf	SSD1306_VLLAST,W
	subwf	SSD1306_VLPAGE,W
	btfsc	STATUS, Z
;If SSD1306_VLPage = SSD1306_VLLast Then Exit Do
	goto	SysDoLoop_E14
;If SSD1306_VLPage = SSD1306_VLLast Then Exit Do
;SSD1306_VLPage++
	incf	SSD1306_VLPAGE,F
;Loop
	goto	SysDoLoop_S14
SysDoLoop_E14
	banksel	STATUS
	return

;********************************************************************************

;Source: timer.h (887)
STARTTIMER
;IF TMRNumber = 0 then Set T0EN on
	banksel	TMRNUMBER
	movf	TMRNUMBER,F
	btfss	STATUS, Z
	goto	ENDIF82
;IF TMRNumber = 0 then Set T0EN on
	banksel	T0CON0
	bsf	T0CON0,T0EN
;IF TMRNumber = 0 then Set T0EN on
ENDIF82
;IF TMRNumber = 1 then Set TMR1ON on
	banksel	TMRNUMBER
	decf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF83
;IF TMRNumber = 1 then Set TMR1ON on
	banksel	T1CON
	bsf	T1CON,TMR1ON
;IF TMRNumber = 1 then Set TMR1ON on
ENDIF83
;IF TMRNumber = 2 then Set TMR2ON on
	movlw	2
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF84
;IF TMRNumber = 2 then Set TMR2ON on
	banksel	T2CON
	bsf	T2CON,TMR2ON
;IF TMRNumber = 2 then Set TMR2ON on
ENDIF84
;IF TMRNumber = 3 then Set TMR3ON on
	movlw	3
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF85
;IF TMRNumber = 3 then Set TMR3ON on
	banksel	T3CON
	bsf	T3CON,TMR3ON
;IF TMRNumber = 3 then Set TMR3ON on
ENDIF85
;IF TMRNumber = 4 then Set TMR4ON on
	movlw	4
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF86
;IF TMRNumber = 4 then Set TMR4ON on
	banksel	T4CON
	bsf	T4CON,TMR4ON
;IF TMRNumber = 4 then Set TMR4ON on
ENDIF86
;IF TMRNumber = 5 then Set TMR5ON on
	movlw	5
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF87
;IF TMRNumber = 5 then Set TMR5ON on
	banksel	T5CON
	bsf	T5CON,TMR5ON
;IF TMRNumber = 5 then Set TMR5ON on
ENDIF87
;IF TMRNumber = 6 then Set TMR6ON on
	movlw	6
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF88
;IF TMRNumber = 6 then Set TMR6ON on
	banksel	T6CON
	bsf	T6CON,TMR6ON
;IF TMRNumber = 6 then Set TMR6ON on
ENDIF88
	banksel	STATUS
	return

;********************************************************************************

;Source: system.h (3881)
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
	movf	SYSLONGTEMPA,W
	banksel	SYSLONGDIVMULTA
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempA
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempA_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempA_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SYSCOMPEQUAL32
	call	SYSCOMPEQUAL32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF102
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF102
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP
SYSDIV32START
;set C off
	bcf	STATUS,C
;Rotate SysLongDivMultA Left
	banksel	SYSLONGDIVMULTA
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;Rotate SysLongDivMultX Left
	rlf	SYSLONGDIVMULTX,F
	rlf	SYSLONGDIVMULTX_H,F
	rlf	SYSLONGDIVMULTX_U,F
	rlf	SYSLONGDIVMULTX_E,F
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	subwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	subwfb	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	subwfb	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	subwfb	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF103
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	addwfc	SYSLONGDIVMULTX_E,F
;End If
ENDIF103
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv32Start
	goto	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movf	SYSLONGDIVMULTA,W
	movwf	SYSLONGTEMPA
	movf	SYSLONGDIVMULTA_H,W
	movwf	SYSLONGTEMPA_H
	movf	SYSLONGDIVMULTA_U,W
	movwf	SYSLONGTEMPA_U
	movf	SYSLONGDIVMULTA_E,W
	movwf	SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:WORD:word:, Source: glcd.h (4934)
TRIANGLE70
;Line(xoffset, yoffset,   xoffset2, yoffset2, LineColour)
	banksel	XOFFSET
	movf	XOFFSET,W
	banksel	LINEX1
	movwf	LINEX1
	banksel	XOFFSET_H
	movf	XOFFSET_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	YOFFSET
	movf	YOFFSET,W
	banksel	LINEY1
	movwf	LINEY1
	banksel	YOFFSET_H
	movf	YOFFSET_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	XOFFSET2
	movf	XOFFSET2,W
	banksel	LINEX2
	movwf	LINEX2
	banksel	XOFFSET2_H
	movf	XOFFSET2_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	YOFFSET2
	movf	YOFFSET2,W
	banksel	LINEY2
	movwf	LINEY2
	banksel	YOFFSET2_H
	movf	YOFFSET2_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	pagesel	LINE_SSD1306
	call	LINE_SSD1306
	pagesel	$
;Line(xoffset2, yoffset2, xoffset3, yoffset3, LineColour)
	banksel	XOFFSET2
	movf	XOFFSET2,W
	banksel	LINEX1
	movwf	LINEX1
	banksel	XOFFSET2_H
	movf	XOFFSET2_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	YOFFSET2
	movf	YOFFSET2,W
	banksel	LINEY1
	movwf	LINEY1
	banksel	YOFFSET2_H
	movf	YOFFSET2_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	XOFFSET3
	movf	XOFFSET3,W
	banksel	LINEX2
	movwf	LINEX2
	banksel	XOFFSET3_H
	movf	XOFFSET3_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	YOFFSET3
	movf	YOFFSET3,W
	banksel	LINEY2
	movwf	LINEY2
	banksel	YOFFSET3_H
	movf	YOFFSET3_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	pagesel	LINE_SSD1306
	call	LINE_SSD1306
	pagesel	$
;Line(xoffset3, yoffset3, xoffset,  yoffset,  LineColour)
	banksel	XOFFSET3
	movf	XOFFSET3,W
	banksel	LINEX1
	movwf	LINEX1
	banksel	XOFFSET3_H
	movf	XOFFSET3_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	YOFFSET3
	movf	YOFFSET3,W
	banksel	LINEY1
	movwf	LINEY1
	banksel	YOFFSET3_H
	movf	YOFFSET3_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	XOFFSET
	movf	XOFFSET,W
	banksel	LINEX2
	movwf	LINEX2
	banksel	XOFFSET_H
	movf	XOFFSET_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	YOFFSET
	movf	YOFFSET,W
	banksel	LINEY2
	movwf	LINEY2
	banksel	YOFFSET_H
	movf	YOFFSET_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	pagesel	LINE_SSD1306
	goto	LINE_SSD1306

;********************************************************************************

;Program_memory_page: 5
	ORG	10240
BALLHALFWIDTH
	movlw	11
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEBALLHALFWIDTH
	movwf	SysStringA
	movlw	(high TABLEBALLHALFWIDTH) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEBALLHALFWIDTH
	retlw	11
	retlw	0
	retlw	3
	retlw	4
	retlw	4
	retlw	4
	retlw	5
	retlw	4
	retlw	4
	retlw	4
	retlw	3

;********************************************************************************

BITOFROW
	movlw	9
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEBITOFROW
	movwf	SysStringA
	movlw	(high TABLEBITOFROW) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEBITOFROW
	retlw	8
	retlw	1
	retlw	2
	retlw	4
	retlw	8
	retlw	16
	retlw	32
	retlw	64
	retlw	128

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (263)
DRAWBALL
;BallTop = DBY - 5
	movlw	5
	subwf	DBY,W
	movwf	BALLTOP
;For BallRow = 1 To 11
;Legacy method
	clrf	BALLROW
SysForLoop1
	incf	BALLROW,F
;ReadTable BallHalfWidth, BallRow, BallHalf
	movf	BALLROW,W
	movwf	SYSSTRINGA
	call	BALLHALFWIDTH
	movwf	BALLHALF
;For BallCol = DBX - BallHalf To DBX + BallHalf
;Legacy method
	subwf	DBX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	decf	SysTemp2,W
	banksel	BALLCOL
	movwf	BALLCOL
	movf	BALLHALF,W
	subwf	DBX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	BALLHALF
	movf	BALLHALF,W
	addwf	DBX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movf	SysTemp1,W
	movwf	SysBYTETempB
	movf	SysTemp2,W
	movwf	SysBYTETempA
	banksel	STATUS
	call	SYSCOMPLESSTHAN
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd2
SysForLoop2
	incf	BALLCOL,F
;PSet(BallCol, BallTop + BallRow - 1, GLCDForeground)
	movf	BALLCOL,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	BALLROW
	movf	BALLROW,W
	addwf	BALLTOP,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	decf	SysTemp2,W
	banksel	GLCDY
	movwf	GLCDY
	movf	GLCDFOREGROUND,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Next
	movf	BALLHALF,W
	addwf	DBX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	BALLCOL
	movf	BALLCOL,W
	movwf	SysBYTETempA
	banksel	SYSTEMP2
	movf	SysTemp2,W
	movwf	SysBYTETempB
	banksel	STATUS
	call	SYSCOMPLESSTHAN
	btfsc	SysByteTempX,0
	goto	SysForLoop2
SysForLoopEnd2
;Next
	movlw	11
	subwf	BALLROW,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
	return

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (126)
DRAWTITLE
;GLCDCLS
	pagesel	GLCDCLS_SSD1306
	call	GLCDCLS_SSD1306
	pagesel	$
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;GLCDPrint(0, 0, TitleText)
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	SYSTITLETEXTHANDLER
	movf	SysTITLETEXTHandler,W
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	banksel	SYSTITLETEXTHANDLER_H
	movf	SysTITLETEXTHandler_H,W
	banksel	SYSLCDPRINTDATAHANDLER_H
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT22
	call	GLCDPRINT22
	pagesel	$
;GLCDPrint(108, 0, BUILD_SHORT)              ' x 108: 3 characters fit before column 127
	movlw	108
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable3
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT22
	call	GLCDPRINT22
	pagesel	$
;Line(0, 9, 127, 9)
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	movlw	9
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	127
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	9
	movwf	LINEY2
	clrf	LINEY2_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	banksel	GLCDFOREGROUND_H
	movf	GLCDFOREGROUND_H,W
	banksel	LINECOLOUR_H
	movwf	LINECOLOUR_H
	banksel	STATUS
	pagesel	LINE_SSD1306
	goto	LINE_SSD1306

;********************************************************************************

;Source: glcd.h (4503)
DRAW_FILLED_ELLIPSE_POINTS
;dim LineColour as Long
;FOR GLCD_yy1 = (yoffset) to (yoffset + 2 * GLCD_yy)
;Legacy method
	banksel	YOFFSET
	decf	YOFFSET,W
	banksel	GLCD_YY1
	movwf	GLCD_YY1
	bcf	STATUS,C
	rlf	GLCD_YY,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	addwf	YOFFSET,W
	movwf	SysTemp1
	movf	YOFFSET,W
	movwf	SysBYTETempB
	movf	SysTemp1,W
	movwf	SysBYTETempA
	banksel	STATUS
	call	SYSCOMPLESSTHAN
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd13
SysForLoop13
	banksel	GLCD_YY1
	incf	GLCD_YY1,F
;Pset ((xoffset + GLCD_xx), (GLCD_yy1 - GLCD_yy), LineColour)
	movf	GLCD_XX,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movf	GLCD_YY,W
	subwf	GLCD_YY1,W
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Pset ((xoffset - GLCD_xx), (GLCD_yy1 - GLCD_yy), LineColour)
	banksel	GLCD_XX
	movf	GLCD_XX,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movf	GLCD_YY,W
	subwf	GLCD_YY1,W
	movwf	GLCDY
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	GLCDCOLOUR
	movwf	GLCDCOLOUR
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	GLCDCOLOUR_H
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;NEXT
	bcf	STATUS,C
	banksel	GLCD_YY
	rlf	GLCD_YY,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	addwf	YOFFSET,W
	movwf	SysTemp1
	banksel	GLCD_YY1
	movf	GLCD_YY1,W
	movwf	SysBYTETempA
	banksel	SYSTEMP1
	movf	SysTemp1,W
	movwf	SysBYTETempB
	banksel	STATUS
	call	SYSCOMPLESSTHAN
	btfsc	SysByteTempX,0
	goto	SysForLoop13
SysForLoopEnd13
	return

;********************************************************************************

Delay_10US
D10US_START
	movlw	25
	movwf	DELAYTEMP
DelayUS0
	decfsz	DELAYTEMP,F
	goto	DelayUS0
	nop
	decfsz	SysWaitTemp10US, F
	goto	D10US_START
	return

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

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (4179)
ELLIPSE54
;Version 1.00 (08/20/2017) by Joseph Realmuto
;draws an ellipse outline at location (xoffset, yoffset)
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;filled_ellipse = 0
	clrf	FILLED_ELLIPSE
;DrawEllipseRoutine( xoffset, yoffset, Inxradius, Inyradius, LineColour )
	pagesel	DRAWELLIPSEROUTINE58
	goto	DRAWELLIPSEROUTINE58

;********************************************************************************

;Source: hwi2c.h (449)
HI2CMODE
;This method sets the variable `HI2CCurrentMode`, and, if required, sets the SSPCON1.bits
;#ifdef var(SSPCON1) added to separate from newer i2C module which does not have an SSPCON1
;set SSPSTAT.SMP on
	banksel	SSPSTAT
	bsf	SSPSTAT,SMP
;set SSPCON1.CKP on
	bsf	SSPCON1,CKP
;set SSPCON1.WCOL Off
	bcf	SSPCON1,WCOL
;Select mode and clock
;If HI2CCurrentMode = Master Then
	movlw	12
	banksel	HI2CCURRENTMODE
	subwf	HI2CCURRENTMODE,W
	btfss	STATUS, Z
	goto	ENDIF107
;set SSPCON1.SSPM3 on
	banksel	SSPCON1
	bsf	SSPCON1,SSPM3
;set SSPCON1.SSPM2 off
	bcf	SSPCON1,SSPM2
;set SSPCON1.SSPM1 off
	bcf	SSPCON1,SSPM1
;set SSPCON1.SSPM0 off
	bcf	SSPCON1,SSPM0
;SSPADD = HI2C_BAUD_TEMP and 127
	movlw	19
	movwf	SSPADD
;end if
ENDIF107
;if HI2CCurrentMode = Slave then
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,F
	btfss	STATUS, Z
	goto	ENDIF108
;set SSPCON1.SSPM3 off
	banksel	SSPCON1
	bcf	SSPCON1,SSPM3
;set SSPCON1.SSPM2 on
	bsf	SSPCON1,SSPM2
;set SSPCON1.SSPM1 on
	bsf	SSPCON1,SSPM1
;set SSPCON1.SSPM0 off
	bcf	SSPCON1,SSPM0
;end if
ENDIF108
;if HI2CCurrentMode = Slave10 then
	movlw	3
	banksel	HI2CCURRENTMODE
	subwf	HI2CCURRENTMODE,W
	btfss	STATUS, Z
	goto	ENDIF109
;set SSPCON1.SSPM3 off
	banksel	SSPCON1
	bcf	SSPCON1,SSPM3
;set SSPCON1.SSPM2 on
	bsf	SSPCON1,SSPM2
;set SSPCON1.SSPM1 on
	bsf	SSPCON1,SSPM1
;set SSPCON1.SSPM0 on
	bsf	SSPCON1,SSPM0
;end if
ENDIF109
;Enable I2C
;set SSPCON1.SSPEN on
	banksel	SSPCON1
	bsf	SSPCON1,SSPEN
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (625)
HI2CSEND
;This method sets the registers and register bits to send I2C data
RETRYHI2CSEND
;Clear WCOL
;SET SSPCON1.WCOL OFF
	banksel	SSPCON1
	bcf	SSPCON1,WCOL
;Load data to send
;SSPBUF = I2CByte
	banksel	I2CBYTE
	movf	I2CBYTE,W
	banksel	SSPBUF
	movwf	SSPBUF
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;if ACKSTAT =  1 then
	banksel	SSP1CON2
	btfss	SSP1CON2,ACKSTAT
	goto	ELSE165_1
;HI2CAckPollState = true
	movlw	255
	banksel	HI2CACKPOLLSTATE
	movwf	HI2CACKPOLLSTATE
;else
	goto	ENDIF165
ELSE165_1
;HI2CAckPollState = false
	banksel	HI2CACKPOLLSTATE
	clrf	HI2CACKPOLLSTATE
;end if
ENDIF165
;If SSPCON1.WCOL = On Then
	banksel	SSPCON1
	btfss	SSPCON1,WCOL
	goto	ENDIF166
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	goto	RETRYHI2CSEND
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
;End If
ENDIF166
;Release clock (only needed by slave)
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfss	STATUS, C
	goto	ENDIF167
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	banksel	SSPCON1
	bsf	SSPCON1,CKP
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
ENDIF167
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (509)
HI2CSTART
;This method sets the registers and register bits to generate the I2C  START signal
;If HI2CCurrentMode > 10 Then
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE163_1
;Master_mode operational
;Set SEN On
	banksel	SSP1CON2
	bsf	SSP1CON2,SEN
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;Else
	goto	ENDIF163
ELSE163_1
;Slave mode operational
;Wait Until SSPSTAT.S = On
SysWaitLoop2
	banksel	SSPSTAT
	btfss	SSPSTAT,S
	goto	SysWaitLoop2
;End If
ENDIF163
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (559)
HI2CSTOP
;Master_mode
;If HI2CCurrentMode > 10 Then
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE164_1
;set SSPIE OFF; disable SSP interrupt, tested by Anobium but not implemented.
;wait while R_NOT_W = 1   'wait for completion of activities
SysWaitLoop3
	banksel	SSP1STAT
	btfsc	SSP1STAT,R_NOT_W
	goto	SysWaitLoop3
;Set SSPCON2.PEN On
	bsf	SSPCON2,PEN
;Set SSPCON2.PEN On
	bsf	SSPCON2,PEN
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;Slave mode
;Else
	goto	ENDIF164
ELSE164_1
;Wait Until SSPSTAT.P = On
SysWaitLoop4
	banksel	SSPSTAT
	btfss	SSPSTAT,P
	goto	SysWaitLoop4
;End If
ENDIF164
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (712)
HI2CWAITMSSP
;HI2CWaitMSSPTimeout = 0
	banksel	HI2CWAITMSSPTIMEOUT
	clrf	HI2CWAITMSSPTIMEOUT
HI2CWAITMSSPWAIT
;HI2CWaitMSSPTimeout++
	banksel	HI2CWAITMSSPTIMEOUT
	incf	HI2CWAITMSSPTIMEOUT,F
;if HI2CWaitMSSPTimeout < 255 then
	movlw	255
	subwf	HI2CWAITMSSPTIMEOUT,W
	btfsc	STATUS, C
	goto	ENDIF169
;'Support for SSP1IF
;if SSP1IF = 0 then
	banksel	PIR1
	btfsc	PIR1,SSP1IF
	goto	ENDIF171
;wait 2 us
	movlw	5
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
;goto HI2CWaitMSSPWait
	goto	HI2CWAITMSSPWAIT
;end if
ENDIF171
;Clear the flag and exit sub with HI2CWaitMSSPTimeout NOT set to 255
;SSP1IF = 0
	bcf	PIR1,SSP1IF
;end if
ENDIF169
;Clear the flag
;if HI2CWaitMSSPTimeout = 255 Then BCL1IF = 0
	banksel	HI2CWAITMSSPTIMEOUT
	incf	HI2CWAITMSSPTIMEOUT,W
	btfss	STATUS, Z
	goto	ENDIF170
;if HI2CWaitMSSPTimeout = 255 Then BCL1IF = 0
	banksel	PIR1
	bcf	PIR1,BCL1IF
;if HI2CWaitMSSPTimeout = 255 Then BCL1IF = 0
ENDIF170
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:BYTE:, Source: timer.h (1566)
INITTIMER0284
;Equate to      T0CON1 7:5      3:0        T0CON0 3:0
;Assumed for code below Timer0 is 16-bit capable as we have been passed three parameters
;Set prescaler
;T0CON1 Sets up  CLK Source (7:5)  Sync (4) & Prescale 3:0
;T0CON1 POR Val = b'00000000'
;Re-Use TMRPres as T0CON1 Temp register
;Keep T0CON1 7:4 and write bits 3:0 to  register
;Bits therefore will be cleared!
;TMRPres = (T0CON1 And 240 ) OR TMRPres
	movlw	240
	andwf	T0CON1,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	iorwf	TMRPRES,F
;Set the Source bit
;IF TMRSource <> OSC  THEN
	decf	TMRSOURCE,W
	btfsc	STATUS, Z
	goto	ELSE89_1
;SET TMRPost.5 ON
	bsf	TMRPOST,5
;ELSE
	goto	ENDIF89
ELSE89_1
;SET TMRPost.5 OFF
	bcf	TMRPOST,5
;END IF
ENDIF89
;Write the TOCON register
;T0CON1 = TMRPres
	movf	TMRPRES,W
	banksel	T0CON1
	movwf	T0CON1
;Assumed for code below Timer0 is 16-bit capable
;Set Postscaler
;Re-Use TMRPost as T0CON0 Temp register
;Keep T0CON0 7:5  and write bits 5:0 to register
;Bits therefore will be cleared!
;TMRPost = (T0CON0 And 224) OR TMRPost
	movlw	224
	andwf	T0CON0,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	iorwf	TMRPOST,F
;Set TO16BIT
;Set TMRPost.4 ON '16-bit Timer0
	bsf	TMRPOST,4
;Write the TOCON register
;T0CON0 = TMRPost
	movf	TMRPOST,W
	banksel	T0CON0
	movwf	T0CON0
	return

;********************************************************************************

OLEDFONT1DATA_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEOLEDFONT1DATA_H
	movwf	SysStringA
	movlw	(high TABLEOLEDFONT1DATA_H) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEOLEDFONT1DATA_H
	retlw	1

;********************************************************************************

OLEDFONT2_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEOLEDFONT2_H
	movwf	SysStringA
	movlw	(high TABLEOLEDFONT2_H) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEOLEDFONT2_H
	retlw	7

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (460)
FN_READPOTAVERAGE
;Dim PotSum As Word
;PotSum = 0
	banksel	POTSUM
	clrf	POTSUM
	clrf	POTSUM_H
;Repeat 8
	movlw	8
	banksel	SYSREPEATTEMP3
	movwf	SysRepeatTemp3
SysRepeatLoop3
;PotSum += ReadPotGLCD
	banksel	STATUS
	call	FN_READPOTGLCD
	banksel	READPOTGLCD
	movf	READPOTGLCD,W
	addwf	POTSUM,F
	movf	READPOTGLCD_H,W
	addwfc	POTSUM_H,F
;End Repeat
	banksel	SYSREPEATTEMP3
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
;Repeat 3
	movlw	3
	movwf	SysRepeatTemp3
SysRepeatLoop4
;Set C Off
	bcf	STATUS,C
;Rotate PotSum Right
	banksel	POTSUM_H
	rrf	POTSUM_H,F
	rrf	POTSUM,F
;End Repeat
	banksel	SYSREPEATTEMP3
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop4
SysRepeatLoopEnd4
;ReadPotAverage = PotSum
	banksel	POTSUM
	movf	POTSUM,W
	movwf	READPOTAVERAGE
	movf	POTSUM_H,W
	movwf	READPOTAVERAGE_H
	banksel	STATUS
	return

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (426)
FN_READPOTGLCD
;ReadPotGLCD = ReadAD10(ANA0)
	clrf	ADREADPORT
	pagesel	FN_READAD1093
	call	FN_READAD1093
	pagesel	$
	banksel	SYSREADAD10WORD
	movf	SYSREADAD10WORD,W
	movwf	READPOTGLCD
	movf	SYSREADAD10WORD_H,W
	movwf	READPOTGLCD_H
	banksel	STATUS
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (1541)
SETCONTRAST_SSD1306
;Write_Command_SSD1306(SSD1306_SETCONTRAST)
	movlw	129
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(dim_state)
	movf	DIM_STATE,W
	banksel	SSD1306SENDBYTE
	movwf	SSD1306SENDBYTE
	banksel	STATUS
	goto	WRITE_COMMAND_SSD1306

;********************************************************************************

SSD1306_BOTTOMMASK
	movlw	9
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLESSD1306_BOTTOMMASK
	movwf	SysStringA
	movlw	(high TABLESSD1306_BOTTOMMASK) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLESSD1306_BOTTOMMASK
	retlw	8
	retlw	1
	retlw	3
	retlw	7
	retlw	15
	retlw	31
	retlw	63
	retlw	127
	retlw	255

;********************************************************************************

SSD1306_TOPMASK
	movlw	9
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLESSD1306_TOPMASK
	movwf	SysStringA
	movlw	(high TABLESSD1306_TOPMASK) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLESSD1306_TOPMASK
	retlw	8
	retlw	255
	retlw	254
	retlw	252
	retlw	248
	retlw	240
	retlw	224
	retlw	192
	retlw	128

;********************************************************************************

;Overloaded signature: WORD:WORD:, Source: stdbasic.h (287)
SWAP166
;Dim SysCalcTempX As Word
;SysCalcTempX = SysCalcTempA
	movf	SYSCALCTEMPA,W
	movwf	SYSCALCTEMPX
	movf	SYSCALCTEMPA_H,W
	movwf	SYSCALCTEMPX_H
;SysCalcTempA = SysCalcTempB
	movf	SYSCALCTEMPB,W
	movwf	SYSCALCTEMPA
	movf	SYSCALCTEMPB_H,W
	movwf	SYSCALCTEMPA_H
;SysCalcTempB = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSCALCTEMPB
	movf	SYSCALCTEMPX_H,W
	movwf	SYSCALCTEMPB_H
	return

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (409)
FN_SWITCHPRESSED
;Dim SwitchWait As Byte
;SwitchPressed = 0
	banksel	SWITCHPRESSED
	clrf	SWITCHPRESSED
;If SWITCH <> SWITCH_DOWN Then Exit Function
	banksel	PORTA
	btfsc	PORTA,2
;If SWITCH <> SWITCH_DOWN Then Exit Function
	return
;If SWITCH <> SWITCH_DOWN Then Exit Function
;Wait 20 ms
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;If SWITCH <> SWITCH_DOWN Then Exit Function
	btfsc	PORTA,2
;If SWITCH <> SWITCH_DOWN Then Exit Function
	return
;If SWITCH <> SWITCH_DOWN Then Exit Function
;SwitchWait = 0
	banksel	SWITCHWAIT
	clrf	SWITCHWAIT
;Do While SWITCH = SWITCH_DOWN
SysDoLoop_S5
	banksel	PORTA
	btfsc	PORTA,2
	goto	SysDoLoop_E5
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;SwitchWait++
	banksel	SWITCHWAIT
	incf	SWITCHWAIT,F
;If SwitchWait = 100 Then Exit Do
	movlw	100
	subwf	SWITCHWAIT,W
	btfsc	STATUS, Z
;If SwitchWait = 100 Then Exit Do
	goto	SysDoLoop_E5
;If SwitchWait = 100 Then Exit Do
;Loop
	goto	SysDoLoop_S5
SysDoLoop_E5
;Wait 20 ms
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
;SwitchPressed = 1
	movlw	1
	banksel	SWITCHPRESSED
	movwf	SWITCHPRESSED
	banksel	STATUS
	return

;********************************************************************************

;Source: system.h (4437)
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

;Source: system.h (4491)
SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysLongTempA, W
	movf	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	subwf	SYSLONGTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysLongTempA_H, W
	movf	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	subwf	SYSLONGTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test upper, exit if false
;movf SysLongTempA_U, W
	movf	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	subwf	SYSLONGTEMPB_U, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test exp, exit if false
;movf SysLongTempA_E, W
	movf	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	subwf	SYSLONGTEMPB_E, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (4801)
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

;Source: system.h (4831)
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

;Source: system.h (4889)
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

;Source: system.h (5273)
SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7
	goto	ELSE104_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7
	goto	ENDIF105
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F
;Exit Sub
	return
;End If
ENDIF105
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,W
	movwf	SYSDIVMULTA
	comf	SYSINTEGERTEMPA_H,W
	movwf	SYSDIVMULTA_H
	incf	SYSDIVMULTA,F
	btfsc	STATUS,Z
	incf	SYSDIVMULTA_H,F
;SysIntegerTempA = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,W
	movwf	SYSINTEGERTEMPA
	comf	SYSINTEGERTEMPB_H,W
	movwf	SYSINTEGERTEMPA_H
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
;SysIntegerTempB = SysDivMultA
	movf	SYSDIVMULTA,W
	movwf	SYSINTEGERTEMPB
	movf	SYSDIVMULTA_H,W
	movwf	SYSINTEGERTEMPB_H
;+A
;Else
	goto	ENDIF104
ELSE104_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7
;Exit Sub
	return
;End If
;End If
ENDIF104
;Test High, exit if more
;movf SysIntegerTempA_H,W
	movf	SYSINTEGERTEMPA_H,W
;subwf SysIntegerTempB_H,W
	subwf	SYSINTEGERTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	movf	SYSINTEGERTEMPB_H,W
;subwf SysIntegerTempA_H,W
	subwf	SYSINTEGERTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLTIntTrue
	goto	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	movf	SYSINTEGERTEMPB,W
;subwf SysIntegerTempA,W
	subwf	SYSINTEGERTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLTINTTRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (3737)
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

;Source: system.h (3805)
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
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0
	goto	ENDIF97
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF97
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
	goto	ENDIF98
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF98
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

;Source: system.h (3859)
SYSDIVSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W
	xorwf	SYSINTEGERTEMPB_H,W
	movwf	SYSSIGNBYTE
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7
	goto	ENDIF99
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
ENDIF99
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7
	goto	ENDIF100
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F
	comf	SYSINTEGERTEMPB_H,F
	incf	SYSINTEGERTEMPB,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPB_H,F
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
ENDIF100
;Call word divide routine
;SysDivSub16
	call	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7
	goto	ENDIF101
;SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
;SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F
	comf	SYSINTEGERTEMPX_H,F
	incf	SYSINTEGERTEMPX,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPX_H,F
;End If
ENDIF101
	return

;********************************************************************************

;Source: system.h (3224)
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

;Source: system.h (3271)
SYSMULTSUB16
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
MUL16LOOP
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	btfss	SYSDIVMULTB,0
	goto	ENDIF90
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
ENDIF90
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysDivMultB right
	rrf	SYSDIVMULTB_H,F
	rrf	SYSDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysDivMultA left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;if SysDivMultB > 0 then goto MUL16LOOP
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempB
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0
;if SysDivMultB > 0 then goto MUL16LOOP
	goto	MUL16LOOP
;if SysDivMultB > 0 then goto MUL16LOOP
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************

;Source: system.h (3369)
SYSMULTSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W
	xorwf	SYSINTEGERTEMPB_H,W
	movwf	SYSSIGNBYTE
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7
	goto	ENDIF92
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
ENDIF92
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7
	goto	ENDIF93
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,F
	comf	SYSINTEGERTEMPB_H,F
	incf	SYSINTEGERTEMPB,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPB_H,F
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
ENDIF93
;Call word multiply routine
;SysMultSub16
	call	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7
	goto	ENDIF94
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F
	comf	SYSINTEGERTEMPX_H,F
	incf	SYSINTEGERTEMPX,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPX_H,F
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
ENDIF94
	return

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (376)
FN_TIMEMS
;TickNow = TMR0L                                 ' reading TMR0L latches TMR0H
	movf	TMR0L,W
	banksel	TICKNOW
	movwf	TICKNOW
	clrf	TICKNOW_H
;TickNow_H = TMR0H
	banksel	TMR0H
	movf	TMR0H,W
	banksel	TICKNOW_H
	movwf	TICKNOW_H
;FpsCalc = TickNow
	movf	TICKNOW,W
	banksel	FPSCALC
	movwf	FPSCALC
	banksel	TICKNOW_H
	movf	TICKNOW_H,W
	banksel	FPSCALC_H
	movwf	FPSCALC_H
	clrf	FPSCALC_U
	clrf	FPSCALC_E
;Repeat 5
	movlw	5
	banksel	SYSREPEATTEMP2
	movwf	SysRepeatTemp2
SysRepeatLoop2
;Set C Off
	bcf	STATUS,C
;Rotate FpsCalc Left
	banksel	FPSCALC
	rlf	FPSCALC,F
	rlf	FPSCALC_H,F
	rlf	FPSCALC_U,F
	rlf	FPSCALC_E,F
;End Repeat
	banksel	SYSREPEATTEMP2
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;FpsCalc = FpsCalc / 1000
	banksel	FPSCALC
	movf	FPSCALC,W
	movwf	SysLONGTempA
	movf	FPSCALC_H,W
	movwf	SysLONGTempA_H
	movf	FPSCALC_U,W
	movwf	SysLONGTempA_U
	movf	FPSCALC_E,W
	movwf	SysLONGTempA_E
	movlw	232
	movwf	SysLONGTempB
	movlw	3
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SYSDIVSUB32
	call	SYSDIVSUB32
	pagesel	$
	movf	SysLONGTempA,W
	movwf	FPSCALC
	movf	SysLONGTempA_H,W
	movwf	FPSCALC_H
	movf	SysLONGTempA_U,W
	movwf	FPSCALC_U
	movf	SysLONGTempA_E,W
	movwf	FPSCALC_E
;TimeMs = FpsCalc
	movf	FPSCALC,W
	banksel	TIMEMS
	movwf	TIMEMS
	banksel	FPSCALC_H
	movf	FPSCALC_H,W
	banksel	TIMEMS_H
	movwf	TIMEMS_H
	banksel	STATUS
	return

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (394)
FN_WAITPART
;WaitPart = 0
	banksel	WAITPART
	clrf	WAITPART
;ScreenTicks = 0
	banksel	SCREENTICKS
	clrf	SCREENTICKS
	clrf	SCREENTICKS_H
;Do While ScreenTicks < PartMs
SysDoLoop_S4
	movf	screenticks,W
	movwf	SysWORDTempA
	movf	screenticks_H,W
	movwf	SysWORDTempA_H
	banksel	PARTMS
	movf	partms,W
	movwf	SysWORDTempB
	movf	partms_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0
	goto	SysDoLoop_E4
;If SwitchPressed = 1 Then
	call	FN_SWITCHPRESSED
	banksel	SWITCHPRESSED
	decf	SWITCHPRESSED,W
	btfss	STATUS, Z
	goto	ENDIF43
;WaitPart = 1
	movlw	1
	banksel	WAITPART
	movwf	WAITPART
;Exit Function
	banksel	STATUS
	return
;End If
ENDIF43
;Wait 20 ms
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
;ScreenTicks += 20
	movlw	20
	banksel	SCREENTICKS
	addwf	SCREENTICKS,F
	movlw	0
	addwfc	SCREENTICKS_H,F
;Loop
	goto	SysDoLoop_S4
SysDoLoop_E4
	return

;********************************************************************************

;Source: SSD1306_Demo_16F18326.gcb (389)
WAITSCREEN
;If WaitPart(SCREEN_MS) = 1 Then Exit Sub
	movlw	160
	banksel	PARTMS
	movwf	PARTMS
	movlw	15
	movwf	PARTMS_H
	banksel	STATUS
	call	FN_WAITPART
	banksel	WAITPART
	decf	WAITPART,W
	btfss	STATUS, Z
	goto	ENDIF42
;If WaitPart(SCREEN_MS) = 1 Then Exit Sub
	banksel	STATUS
	return
;If WaitPart(SCREEN_MS) = 1 Then Exit Sub
ENDIF42
	banksel	STATUS
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (256)
WRITE_COMMAND_SSD1306
;HI2CStart
	call	HI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	call	HI2CSEND
;HI2CSend 0x00
	banksel	I2CBYTE
	clrf	I2CBYTE
	banksel	STATUS
	call	HI2CSEND
;HI2CSend SSD1306SendByte
	banksel	SSD1306SENDBYTE
	movf	SSD1306SENDBYTE,W
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	call	HI2CSEND
;HI2CStop
	goto	HI2CSTOP

;********************************************************************************

;Source: GLCD_SSD1306.H (302)
WRITE_DATA_SSD1306
;HI2CStart
	call	HI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	call	HI2CSEND
;HI2CSend 0x40
	movlw	64
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	call	HI2CSEND
;HI2CSend SSD1306SendByte
	banksel	SSD1306SENDBYTE
	movf	SSD1306SENDBYTE,W
	banksel	I2CBYTE
	movwf	I2CBYTE
	banksel	STATUS
	call	HI2CSEND
;HI2CStop
	goto	HI2CSTOP

;********************************************************************************

;Program_memory_page: 6
	ORG	12288
;Program_memory_page: 7
	ORG	14336

 END
