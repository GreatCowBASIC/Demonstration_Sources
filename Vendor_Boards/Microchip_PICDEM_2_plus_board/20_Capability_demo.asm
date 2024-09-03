;Program compiled by GCBASIC (2024.08.30 (Windows 64 bit) : Build 1420) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2024-08-30 CRC248
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via http://paypal.me/gcbasic
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   w_cholmondeley at users dot sourceforge dot net
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM_2_plus_board\20_Capability_demo.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : 
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_PICDEM_2_plus_board\20_Capability_demo.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F47Q10, r=DEC
#include <P18F47Q10.inc>
 CONFIG  CPD = OFF
 CONFIG  CP = OFF
 CONFIG  LVP = OFF
 CONFIG  WRTD = OFF
 CONFIG  WRTB = OFF
 CONFIG  WDTCCS = LFINTOSC
 CONFIG  WDTCWS = WDTCWS_7
 CONFIG  WDTE = SWDTEN
 CONFIG  WDTCPS = WDTCPS_13
 CONFIG  XINST = OFF
 CONFIG  MCLRE = EXTMCLR
 CONFIG  FCMEN = ON
 CONFIG  CLKOUTEN = OFF
 CONFIG  RSTOSC = HFINTOSC_1MHZ
 CONFIG  FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
ABS                              EQU      16          ; 0x10
ABS_H                            EQU      17          ; 0x11
ACTIVELEDNUM                     EQU      13          ; 0xD
ADCRESULT                        EQU      18          ; 0x12
ADCRESULT_H                      EQU      19          ; 0x13
ADREADPORT                       EQU      20          ; 0x14
BTNSTATE                         EQU      21          ; 0x15
CALCNEXTPAGE                     EQU      22          ; 0x16
CCPCONCACHE                      EQU      23          ; 0x17
CHARARRAY                        EQU    3606          ; 0xE16
COMPORT                          EQU      24          ; 0x18
COUNTERLOOP                      EQU      25          ; 0x19
DATARRAY                         EQU    2818          ; 0xB02
DELAYTEMP                        EQU       0          ; 0x0
DELAYTEMP2                       EQU       1          ; 0x1
DEVICEID                         EQU      26          ; 0x1A
DISPLAYNEWLINE                   EQU      27          ; 0x1B
EEDATA                           EQU      28          ; 0x1C
EEDATAVALUE                      EQU      29          ; 0x1D
EEPADDR                          EQU      30          ; 0x1E
EEPADDR_H                        EQU      31          ; 0x1F
EEPDEV                           EQU      32          ; 0x20
EEPLEN                           EQU      33          ; 0x21
EEPPAGESIZE                      EQU      34          ; 0x22
EEPROM_ADDRESS                   EQU      35          ; 0x23
EEP_I                            EQU      36          ; 0x24
EEP_J                            EQU      37          ; 0x25
FLAGCOUNTER                      EQU      38          ; 0x26
FNLSR                            EQU      39          ; 0x27
FNLSR_E                          EQU      42          ; 0x2A
FNLSR_H                          EQU      40          ; 0x28
FNLSR_U                          EQU      41          ; 0x29
HI2CACKPOLLSTATE                 EQU      43          ; 0x2B
HI2CCURRENTMODE                  EQU      44          ; 0x2C
HI2CGETACK                       EQU      45          ; 0x2D
HI2CWAITMSSPTIMEOUT              EQU      46          ; 0x2E
HSERPRINTCRLFCOUNT               EQU      47          ; 0x2F
I2CBYTE                          EQU      48          ; 0x30
LABNUMBER                        EQU      49          ; 0x31
LABSTATE                         EQU      50          ; 0x32
LCDBYTE                          EQU      51          ; 0x33
LCDCHAR                          EQU      52          ; 0x34
LCDCHARLOC                       EQU      53          ; 0x35
LCDCOLUMN                        EQU      54          ; 0x36
LCDCRSR                          EQU      55          ; 0x37
LCDLINE                          EQU      56          ; 0x38
LCDLOC                           EQU      57          ; 0x39
LCDNORMALREADBYTE                EQU      58          ; 0x3A
LCDTEMP                          EQU      59          ; 0x3B
LCDTEMPRWCOUNT                   EQU      60          ; 0x3C
LCDVALUE                         EQU      61          ; 0x3D
LCDVALUETEMP                     EQU      62          ; 0x3E
LCD_STATE                        EQU      63          ; 0x3F
LEDSTATE                         EQU      64          ; 0x40
LEFTPAD                          EQU    2777          ; 0xAD9
L_CALIBRATE                      EQU      65          ; 0x41
L_CALIBRATE_H                    EQU      66          ; 0x42
L_FROMHIGH                       EQU      67          ; 0x43
L_FROMHIGH_H                     EQU      68          ; 0x44
L_FROMLOW                        EQU      69          ; 0x45
L_FROMLOW_H                      EQU      70          ; 0x46
L_MAP                            EQU      71          ; 0x47
L_MAP_H                          EQU      72          ; 0x48
L_SYSCALC                        EQU      73          ; 0x49
L_SYSCALCF                       EQU      75          ; 0x4B
L_SYSCALCF_E                     EQU      78          ; 0x4E
L_SYSCALCF_H                     EQU      76          ; 0x4C
L_SYSCALCF_U                     EQU      77          ; 0x4D
L_SYSCALC_H                      EQU      74          ; 0x4A
L_TOHIGH                         EQU      79          ; 0x4F
L_TOHIGH_H                       EQU      80          ; 0x50
L_TOLOW                          EQU      81          ; 0x51
L_TOLOW_H                        EQU      82          ; 0x52
NUMBITS                          EQU      83          ; 0x53
NVMADDRESS                       EQU      84          ; 0x54
NVMADDRESS_E                     EQU      87          ; 0x57
NVMADDRESS_H                     EQU      85          ; 0x55
NVMADDRESS_U                     EQU      86          ; 0x56
OLDADCRESULT                     EQU      88          ; 0x58
OLDADCRESULT_H                   EQU      89          ; 0x59
OUTVALUETEMP                     EQU      90          ; 0x5A
PAD                              EQU    2736          ; 0xAB0
PFMADCRESULT                     EQU      91          ; 0x5B
PFMADCRESULT_H                   EQU      92          ; 0x5C
PFMREADWORD                      EQU      93          ; 0x5D
PFMREADWORD_H                    EQU      94          ; 0x5E
PRINTLEN                         EQU      95          ; 0x5F
PRX_TEMP                         EQU      96          ; 0x60
PRX_TEMP_E                       EQU      99          ; 0x63
PRX_TEMP_H                       EQU      97          ; 0x61
PRX_TEMP_U                       EQU      98          ; 0x62
PWMCHANNEL                       EQU     100          ; 0x64
PWMDUTY                          EQU     101          ; 0x65
PWMDUTY_H                        EQU     102          ; 0x66
PWMFREQ                          EQU     103          ; 0x67
PWMRESOLUTION                    EQU     104          ; 0x68
PWMRESOLUTION_H                  EQU     105          ; 0x69
RANDOM                           EQU     106          ; 0x6A
RANDOMSEED                       EQU     107          ; 0x6B
RANDOMSEED_H                     EQU     108          ; 0x6C
RANDOMTEMP                       EQU     109          ; 0x6D
RANDOMTEMP_H                     EQU     110          ; 0x6E
READAD                           EQU     111          ; 0x6F
READAD10                         EQU     112          ; 0x70
READAD10_H                       EQU     113          ; 0x71
SAVEFSR0H                        EQU     114          ; 0x72
SAVEFSR0L                        EQU     115          ; 0x73
SAVEFSR1H                        EQU     116          ; 0x74
SAVEFSR1L                        EQU     117          ; 0x75
SAVENVMADRH                      EQU     118          ; 0x76
SAVENVMADRL                      EQU     119          ; 0x77
SAVENVMADRU                      EQU     120          ; 0x78
SAVENVMCON1                      EQU     121          ; 0x79
SAVESYSBYTETEMPA                 EQU     122          ; 0x7A
SAVESYSBYTETEMPB                 EQU     123          ; 0x7B
SAVESYSBYTETEMPX                 EQU     124          ; 0x7C
SAVESYSDIVLOOP                   EQU     125          ; 0x7D
SAVESYSLONGTEMPA_E               EQU     126          ; 0x7E
SAVESYSLONGTEMPA_U               EQU     127          ; 0x7F
SAVESYSLONGTEMPB_E               EQU     128          ; 0x80
SAVESYSLONGTEMPB_H               EQU     129          ; 0x81
SAVESYSLONGTEMPB_U               EQU     130          ; 0x82
SAVESYSLONGTEMPX_E               EQU     131          ; 0x83
SAVESYSLONGTEMPX_H               EQU     132          ; 0x84
SAVESYSLONGTEMPX_U               EQU     133          ; 0x85
SAVESYSSTRINGLENGTH              EQU     134          ; 0x86
SAVESYSTEMP1                     EQU     135          ; 0x87
SAVESYSTEMP2                     EQU     136          ; 0x88
SAVESYSTEMP2_H                   EQU     137          ; 0x89
SCALE                            EQU     138          ; 0x8A
SCALE_H                          EQU     139          ; 0x8B
SERDATA                          EQU     140          ; 0x8C
SERPRINTVAL                      EQU     141          ; 0x8D
SHIFTCOUNTER                     EQU     142          ; 0x8E
SOUNDPLAYBYTE                    EQU     143          ; 0x8F
SOUNDPLAYBYTES                   EQU     144          ; 0x90
SOUNDPLAYCOMMAND                 EQU     145          ; 0x91
SOUNDPLAYCURRNOTE                EQU     146          ; 0x92
SOUNDPLAYCYCLES                  EQU     147          ; 0x93
SOUNDPLAYCYCLES_H                EQU     148          ; 0x94
SOUNDPLAYDOTS                    EQU     149          ; 0x95
SOUNDPLAYLENGTH                  EQU     150          ; 0x96
SOUNDPLAYMODE                    EQU     151          ; 0x97
SOUNDPLAYNOTE                    EQU     152          ; 0x98
SOUNDPLAYNOTELEN                 EQU     153          ; 0x99
SOUNDPLAYNOTEOCTAVE              EQU     154          ; 0x9A
SOUNDPLAYNOTETYPE                EQU     155          ; 0x9B
SOUNDPLAYNUMBER                  EQU     156          ; 0x9C
SOUNDPLAYNUMBER2                 EQU     157          ; 0x9D
SOUNDPLAYOCTAVE                  EQU     158          ; 0x9E
SOUNDPLAYPERIOD                  EQU     159          ; 0x9F
SOUNDPLAYRTTTLDATASTRING         EQU    2695          ; 0xA87
SOUNDPLAYTEMP                    EQU     160          ; 0xA0
SOUNDPLAYTEMPO                   EQU     161          ; 0xA1
STR                              EQU    3600          ; 0xE10
STRINGPOINTER                    EQU     162          ; 0xA2
SWITCHEVENT                      EQU     163          ; 0xA3
SYSARRAYTEMP1                    EQU     164          ; 0xA4
SYSARRAYTEMP2                    EQU     165          ; 0xA5
SYSBITVAR0                       EQU     166          ; 0xA6
SYSBITVAR1                       EQU     167          ; 0xA7
SYSBSR                           EQU     168          ; 0xA8
SYSBYTETEMPA                     EQU       5          ; 0x5
SYSBYTETEMPB                     EQU       9          ; 0x9
SYSBYTETEMPX                     EQU       0          ; 0x0
SYSCALCTEMPA                     EQU       5          ; 0x5
SYSCALCTEMPA_H                   EQU       6          ; 0x6
SYSCALCTEMPX                     EQU       0          ; 0x0
SYSCALCTEMPX_H                   EQU       1          ; 0x1
SYSCHARCOUNT                     EQU     169          ; 0xA9
SYSDIVLOOP                       EQU       4          ; 0x4
SYSDIVMULTA                      EQU       7          ; 0x7
SYSDIVMULTA_H                    EQU       8          ; 0x8
SYSDIVMULTB                      EQU      11          ; 0xB
SYSDIVMULTB_H                    EQU      12          ; 0xC
SYSDIVMULTX                      EQU       2          ; 0x2
SYSDIVMULTX_H                    EQU       3          ; 0x3
SYSEEADDRESS                     EQU     170          ; 0xAA
SYSEEADDRESS_H                   EQU     171          ; 0xAB
SYSEEPARRAYHANDLER               EQU     172          ; 0xAC
SYSEEPARRAYHANDLER_H             EQU     173          ; 0xAD
SYSINTEGERTEMPA                  EQU       5          ; 0x5
SYSINTEGERTEMPA_H                EQU       6          ; 0x6
SYSINTEGERTEMPB                  EQU       9          ; 0x9
SYSINTEGERTEMPB_H                EQU      10          ; 0xA
SYSLCDCHARDATAHANDLER            EQU     174          ; 0xAE
SYSLCDCHARDATAHANDLER_H          EQU     175          ; 0xAF
SYSLCDTEMP                       EQU     176          ; 0xB0
SYSLONGDIVMULTA                  EQU     177          ; 0xB1
SYSLONGDIVMULTA_E                EQU     180          ; 0xB4
SYSLONGDIVMULTA_H                EQU     178          ; 0xB2
SYSLONGDIVMULTA_U                EQU     179          ; 0xB3
SYSLONGDIVMULTB                  EQU     181          ; 0xB5
SYSLONGDIVMULTB_E                EQU     184          ; 0xB8
SYSLONGDIVMULTB_H                EQU     182          ; 0xB6
SYSLONGDIVMULTB_U                EQU     183          ; 0xB7
SYSLONGDIVMULTX                  EQU     185          ; 0xB9
SYSLONGDIVMULTX_E                EQU     188          ; 0xBC
SYSLONGDIVMULTX_H                EQU     186          ; 0xBA
SYSLONGDIVMULTX_U                EQU     187          ; 0xBB
SYSLONGTEMPA                     EQU       5          ; 0x5
SYSLONGTEMPA_E                   EQU       8          ; 0x8
SYSLONGTEMPA_H                   EQU       6          ; 0x6
SYSLONGTEMPA_U                   EQU       7          ; 0x7
SYSLONGTEMPB                     EQU       9          ; 0x9
SYSLONGTEMPB_E                   EQU      12          ; 0xC
SYSLONGTEMPB_H                   EQU      10          ; 0xA
SYSLONGTEMPB_U                   EQU      11          ; 0xB
SYSLONGTEMPX                     EQU       0          ; 0x0
SYSLONGTEMPX_E                   EQU       3          ; 0x3
SYSLONGTEMPX_H                   EQU       1          ; 0x1
SYSLONGTEMPX_U                   EQU       2          ; 0x2
SYSPRINTDATAHANDLER              EQU     189          ; 0xBD
SYSPRINTDATAHANDLER_H            EQU     190          ; 0xBE
SYSPRINTTEMP                     EQU     191          ; 0xBF
SYSREPEATTEMP1                   EQU     192          ; 0xC0
SYSREPEATTEMP11                  EQU     193          ; 0xC1
SYSREPEATTEMP12                  EQU     194          ; 0xC2
SYSREPEATTEMP13                  EQU     195          ; 0xC3
SYSREPEATTEMP14                  EQU     196          ; 0xC4
SYSREPEATTEMP15                  EQU     197          ; 0xC5
SYSREPEATTEMP2                   EQU     198          ; 0xC6
SYSREPEATTEMP3                   EQU     199          ; 0xC7
SYSREPEATTEMP4                   EQU     200          ; 0xC8
SYSREPEATTEMP5                   EQU     201          ; 0xC9
SYSREPEATTEMP5_H                 EQU     202          ; 0xCA
SYSREPEATTEMP6                   EQU     203          ; 0xCB
SYSREPEATTEMP9                   EQU     204          ; 0xCC
SYSSOUNDPLAYDATAHANDLER          EQU     205          ; 0xCD
SYSSOUNDPLAYDATAHANDLER_H        EQU     206          ; 0xCE
SYSSTATUS                        EQU      15          ; 0xF
SYSSTRDATA                       EQU     207          ; 0xCF
SYSSTRINGA                       EQU       7          ; 0x7
SYSSTRINGA_H                     EQU       8          ; 0x8
SYSSTRINGLENGTH                  EQU       6          ; 0x6
SYSSTRINGPARAM1                  EQU    3120          ; 0xC30
SYSSTRINGPARAM2                  EQU    3041          ; 0xBE1
SYSSTRINGPARAM3                  EQU    2962          ; 0xB92
SYSSTRINGPARAM4                  EQU    2883          ; 0xB43
SYSSTRINGTEMP                    EQU     208          ; 0xD0
SYSSTRLEN                        EQU     209          ; 0xD1
SYSSYSINSTRING2HANDLER           EQU     210          ; 0xD2
SYSSYSINSTRING2HANDLER_H         EQU     211          ; 0xD3
SYSSYSINSTRING3HANDLER           EQU     212          ; 0xD4
SYSSYSINSTRING3HANDLER_H         EQU     213          ; 0xD5
SYSSYSINSTRINGHANDLER            EQU     214          ; 0xD6
SYSSYSINSTRINGHANDLER_H          EQU     215          ; 0xD7
SYSTEMP1                         EQU     216          ; 0xD8
SYSTEMP1_E                       EQU     219          ; 0xDB
SYSTEMP1_H                       EQU     217          ; 0xD9
SYSTEMP1_U                       EQU     218          ; 0xDA
SYSTEMP2                         EQU     220          ; 0xDC
SYSTEMP2_H                       EQU     221          ; 0xDD
SYSVALTEMP                       EQU     222          ; 0xDE
SYSVALTEMP_H                     EQU     223          ; 0xDF
SYSW                             EQU      14          ; 0xE
SYSWAITTEMP10US                  EQU       5          ; 0x5
SYSWAITTEMPMS                    EQU       2          ; 0x2
SYSWAITTEMPMS_H                  EQU       3          ; 0x3
SYSWAITTEMPS                     EQU       4          ; 0x4
SYSWAITTEMPUS                    EQU       5          ; 0x5
SYSWAITTEMPUS_H                  EQU       6          ; 0x6
SYSWORDTEMPA                     EQU       5          ; 0x5
SYSWORDTEMPA_H                   EQU       6          ; 0x6
SYSWORDTEMPB                     EQU       9          ; 0x9
SYSWORDTEMPB_H                   EQU      10          ; 0xA
SYSWORDTEMPX                     EQU       0          ; 0x0
SYSWORDTEMPX_H                   EQU       1          ; 0x1
SYS_PFM_BUFFERHANDLER            EQU     224          ; 0xE0
SYS_PFM_BUFFERHANDLER_H          EQU     225          ; 0xE1
TEMPERATUREVAL                   EQU     226          ; 0xE2
TICCOUNT                         EQU     227          ; 0xE3
TIMECOUNT                        EQU     228          ; 0xE4
TIMERSELECTIONBITS               EQU     229          ; 0xE5
TMRNUMBER                        EQU     230          ; 0xE6
TMRPOST                          EQU     231          ; 0xE7
TMRPRES                          EQU     232          ; 0xE8
TMRSOURCE                        EQU     233          ; 0xE9
TMRVALUE                         EQU     234          ; 0xEA
TMRVALUE_H                       EQU     235          ; 0xEB
TRMSOURCE                        EQU     236          ; 0xEC
TX_PR                            EQU     237          ; 0xED
WDTTIMER                         EQU     238          ; 0xEE
XLOOP                            EQU     239          ; 0xEF
_DUMMY                           EQU     240          ; 0xF0
_GIE_SAVE                        EQU     241          ; 0xF1
_HEXPICAS                        EQU    3596          ; 0xE0C
_PFM_ADDR                        EQU     242          ; 0xF2
_PFM_ADDR_E                      EQU     245          ; 0xF5
_PFM_ADDR_H                      EQU     243          ; 0xF3
_PFM_ADDR_U                      EQU     244          ; 0xF4
_PFM_BLOCKNUM                    EQU     246          ; 0xF6
_PFM_BLOCKNUM_E                  EQU     249          ; 0xF9
_PFM_BLOCKNUM_H                  EQU     247          ; 0xF7
_PFM_BLOCKNUM_U                  EQU     248          ; 0xF8
_PFM_BUFFER                      EQU    3199          ; 0xC7F
_PFM_COUNT                       EQU     250          ; 0xFA
_PFM_COUNT_H                     EQU     251          ; 0xFB
_PFM_DATAWORD                    EQU     252          ; 0xFC
_PFM_DATAWORD_H                  EQU     253          ; 0xFD
_PFM_LOOPCOUNTER                 EQU     254          ; 0xFE
_PFM_LOOPCOUNTER_H               EQU     255          ; 0xFF
_PFM_OFFSET                      EQU     256          ; 0x100
_PFM_OFFSET_E                    EQU     259          ; 0x103
_PFM_OFFSET_H                    EQU     257          ; 0x101
_PFM_OFFSET_U                    EQU     258          ; 0x102
_PWMTIMERSELECTED                EQU     260          ; 0x104

;********************************************************************************

;Alias variables
AFSR0 EQU 4073
AFSR0_H EQU 4074
OSCSTATE EQU 25
SYSCHARARRAY_1 EQU 3607
SYSCHARARRAY_2 EQU 3608
SYSCHARARRAY_3 EQU 3609
SYSCHARARRAY_4 EQU 3610
SYSCHARARRAY_5 EQU 3611
SYSCHARARRAY_6 EQU 3612
SYSCHARARRAY_7 EQU 3613
SYSCHARARRAY_8 EQU 3614
SYSFNLSRBYTE EQU 39
SYSFNLSRWORD EQU 39
SYSFNLSRWORD_H EQU 40
SYSLEFTPAD_0 EQU 2777
SYSPAD_0 EQU 2736
SYSREADAD10WORD EQU 112
SYSREADAD10WORD_H EQU 113
SYSREADADBYTE EQU 111
SYSSCALEWORD EQU 138
SYSSCALEWORD_H EQU 139
SYSSTR_0 EQU 3600
SYS_HEXPICAS_0 EQU 3596
SYS_HEXPICAS_1 EQU 3597
SYS_HEXPICAS_2 EQU 3598
_PFM_ABS_ADDR EQU 3961
_PFM_ABS_ADDR_H EQU 3962
_PFM_ABS_ADDR_U EQU 3963
_PFM_ABS_ADDR_E EQU 240
_TBL_ABS_ADDR EQU 4086
_TBL_ABS_ADDR_H EQU 4087
_TBL_ABS_ADDR_U EQU 4088
_TBL_ABS_ADDR_E EQU 240
_TFM_ABS_ADDR EQU 4086
_TFM_ABS_ADDR_H EQU 4087
_TFM_ABS_ADDR_U EQU 4088
_TFM_ABS_ADDR_E EQU 240

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
	call	LCDINITOM16214
	call	INITUSART
	call	HI2CINIT
	call	INITSOUNDPLAY
	call	INITPWM
	call	INITLCD
	call	INITRANDOM
;Enable interrupts
	bsf	INTCON,GIE,ACCESS
	bsf	INTCON,PEIE,ACCESS

;Start_of_the_main_program
;
;A demonstration program for GCGB and GCB.
;--------------------------------------------------------------------------------
;
;The program us designed for Microchip’s PICDEM 2 Plus Development Board. d. The PICDEM 2 Plus Demonstration Board is a simple board
;which demonstrates the capabilities of the 18, 28 and 40-pin PIC16 and PIC18 devices.
;
;GCBASIC for these devices can be downloaded from the GCBASIC web site at https://sourceforge.net/projects/gcbasic/
;
;This program comprises 18 demos utilizing the different peripherals and features of 8-bit PIC® MCUs
;while demonstrating the different capabilities of the PICDEM 2 Plus Demonstration Board. Each lesson contains
;a brief description of the lab, code snippets, and discussions to make you become easily acquainted with
;the different peripherals and registers of PIC® MCUs. These demos also make use of the PPSTOOL,
;an easy-to-use tool that you can use to generate codes for a more efficient use of the CPU and memory resources.
;All labs are written in GCBASIC language and are compatible with the latest GCBASIC compilers.
;
;Demos
;
;The demo in this program are presented in the same order as they appear on the programmed labs.
;You can navigate through each lab by pressing the S2 button.
;
;• Lesson 1: Hello World (Turn On an LED)
;• Lesson 2: Blink
;• Lesson 3: Rotate (Moving the Light Across LEDs)
;• Lesson 4: Analog-to-Digital Conversion (ADC)
;• Lesson 5: Variable Speed Rotate
;• Lesson 6: Debounce
;• Lesson 7: Pulse-Width Modulation (PWM)
;• Lesson 8: Timer1
;• Lesson 9: Interrupts
;• Lesson 10: Sleep/Wakeup
;• Lesson 11: EEPROM Memory Operations
;• Lesson 12: LCD Operations
;• Lesson 13: NVM Memory Operations
;• Lesson 14: I2C Discovery
;• Lesson 15: I2CTemperature
;• Lesson 16: I2CEEPROM
;• Lesson 17: CLOCK - basic tick-tock
;• Lesson 18: Buzzer
;
;
;I/O FEATURES AND EQUIVALENT PORT CONNECTIONS
;Feature                PIC Device (by pin count)
;18-pin      28-pin      40-pin
;LEDs (D2-D5)        RB3:RB0     RB3:RB0     RB3:RB0
;USART               SW Only     RC6:RC7     RC6:RC7
;Master Reset        (S1) MCLR   (S1) MCLR   (S1) MCLR
;User-defined        (S2) RA4    (S2) RA4    (S2) RA4
;User-defined        (S3) RB0    (S3) RB0    (S3) RB0
;Potentiometer       (R16) RA0   (R16) RA0   (R16) RA0
;LCD1                N/A         N/A         RA3:RA1 RA3:RA1 and RD3:RD0
;EEPROM (Ux)         N/A         RC3/RC4     RC3/RC4
;Buzzer (P1)         N/A         RC2         RC2
;ICD Connector (J5)  RB6:RB7     RB6:RB7     RB6:RB7
;Temp sensor (Ux)    N/A         RC3:RC4     RC3:RC4
;Crystal OSC           <--- (Y1) OSC1 and OSC2 -->
;External OSC          <------ (Y2) OSC1 -------->
;Legend: N/A - feature not available for this device
;
;
;
;''@author    Evan R. Venn
;''@license   GPL
;''@version   1.00
;''@date      2024-08-10
;''********************************************************************************
;Configuration of Watchdog timer.  Used in one of the labs
;Constants - Serial support
;-------Lab Constants
;----- Main body of program commences here.
;Setup LCD Parameters
;Define LCD Hardware settings - these are specific to the board
;Hardware configuration  - these are specific to the board
;Dir SWITCH_S3_PORT  In
	bsf	TRISB,0,ACCESS
;Dir SWITCH_S2_PORT  In
	bsf	TRISA,4,ACCESS
;Dir LED_D2          Out
	bcf	TRISB,0,ACCESS
;Dir LED_D3          Out
	bcf	TRISB,1,ACCESS
;Dir LED_D4          Out
	bcf	TRISB,2,ACCESS
;Dir LED_D5          Out
	bcf	TRISB,3,ACCESS
;Common macro and constants
;Variable Definitions
;Dim labNumber as Byte:          labNumber   = 0
;Dim labNumber as Byte:          labNumber   = 0
	clrf	LABNUMBER,ACCESS
;Dim switchEvent as Byte:        switchEvent = 0
;Dim switchEvent as Byte:        switchEvent = 0
	clrf	SWITCHEVENT,BANKED
;Dim labState as Byte:           labState = NOT_RUNNING
;Dim labState as Byte:           labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;Dim btnState as Byte:           btnState = NOT_PRESSED
;Dim btnState as Byte:           btnState = NOT_PRESSED
	clrf	BTNSTATE,ACCESS
;Dim activeLedNum as Byte
;Dim LabI2CState as Bit:         LabI2CState = 0
;Dim LabI2CState as Bit:         LabI2CState = 0
	bcf	SYSBITVAR0,0,BANKED
;if labNumber = 0 Then
	movf	LABNUMBER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF1
;Show messages
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;HserPrint "Welcome to PICDEM 2 Plus"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable1
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*24
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;HserPrint "GCBASIC - Anobium   2024"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable2
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM1*24
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Print "    Welcome     "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*16
	call	PRINT157
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "to PICDEM 2 Plus"
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
;Using SYSSTRINGPARAM1*16
	call	PRINT157
;wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;CLS
	rcall	CLS
;Print "    GCBASIC     "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*16
	call	PRINT157
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print " Anobium   2024 "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable6
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*16
	call	PRINT157
;wait 5 s
	movlw	5
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;CLS
	rcall	CLS
;Print "    Welcome     "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM1*16
	call	PRINT157
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "to PICDEM 2 Plus"
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
;Using SYSSTRINGPARAM1*16
	call	PRINT157
;end if
ENDIF1
;Do Forever
SysDoLoop_S1
;Check button state
;checkButtonS2
	rcall	CHECKBUTTONS2
;Select labnumber and call sub routine
;Select Case labNumber
;case Lab_HelloWorld:        HelloWorld
SysSelect1Case1
	decf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;case Lab_HelloWorld:        HelloWorld
	call	HELLOWORLD
;case Lab_Blink:             Blink
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;case Lab_Blink:             Blink
	rcall	BLINK
;case Lab_RotateLEDs:        RotateLEDs
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;case Lab_RotateLEDs:        RotateLEDs
	call	ROTATELEDS
;case Lab_ADC:               ADC
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
;case Lab_ADC:               ADC
	rcall	ADC
;case Lab_VSR:               VSR
	bra	SysSelectEnd1
SysSelect1Case5
	movlw	5
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case6
;case Lab_VSR:               VSR
	call	VSR
;case Lab_Debounce:          Debounce
	bra	SysSelectEnd1
SysSelect1Case6
	movlw	6
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case7
;case Lab_Debounce:          Debounce
	rcall	DEBOUNCE
;case Lab_PWM:               PWM
	bra	SysSelectEnd1
SysSelect1Case7
	movlw	7
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case8
;case Lab_PWM:               PWM
	call	PWM
;case Lab_Timer_1:           Timer_1
	bra	SysSelectEnd1
SysSelect1Case8
	movlw	8
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case9
;case Lab_Timer_1:           Timer_1
	call	TIMER_1
;case Lab_Interrupts:        Interrupts
	bra	SysSelectEnd1
SysSelect1Case9
	movlw	9
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case10
;case Lab_Interrupts:        Interrupts
	call	INTERRUPTS
;case Lab_SleepWakeUp:       SleepWakeUp
	bra	SysSelectEnd1
SysSelect1Case10
	movlw	10
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case11
;case Lab_SleepWakeUp:       SleepWakeUp
	call	SLEEPWAKEUP
;case Lab_EEPROM:            EEPROM
	bra	SysSelectEnd1
SysSelect1Case11
	movlw	11
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case12
;case Lab_EEPROM:            EEPROM
	rcall	EEPROM
;case Lab_LCD:               LCD
	bra	SysSelectEnd1
SysSelect1Case12
	movlw	12
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case13
;case Lab_LCD:               LCD
	call	LCD
;case Lab_NVMemory:          NVMemory
	bra	SysSelectEnd1
SysSelect1Case13
	movlw	13
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case14
;case Lab_NVMemory:          NVMemory
	call	NVMEMORY
;case Lab_I2CDiscovery:      I2CDiscovery
	bra	SysSelectEnd1
SysSelect1Case14
	movlw	14
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case15
;case Lab_I2CDiscovery:      I2CDiscovery
	call	I2CDISCOVERY
;case Lab_I2CTemperature:    I2CTemperature
	bra	SysSelectEnd1
SysSelect1Case15
	movlw	15
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case16
;case Lab_I2CTemperature:    I2CTemperature
	call	I2CTEMPERATURE
;case Lab_I2CEEPROM:         I2CEEPROM
	bra	SysSelectEnd1
SysSelect1Case16
	movlw	16
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case17
;case Lab_I2CEEPROM:         I2CEEPROM
	call	I2CEEPROM
;case Lab_CLOCK:             Clock
	bra	SysSelectEnd1
SysSelect1Case17
	movlw	17
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case18
;case Lab_CLOCK:             Clock
	rcall	CLOCK
;case Lab_Buzzer:            Buzzer
	bra	SysSelectEnd1
SysSelect1Case18
	movlw	18
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
;case Lab_Buzzer:            Buzzer
	rcall	BUZZER
;End Select
SysSelectEnd1
;if switchEvent = 1 then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Change lab
;nextLab
	call	NEXTLAB
;End if
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: stdbasic.h (294)
FN_ABS
;If SysCalcTempA.15 Then
	btfss	SYSCALCTEMPA_H,7,ACCESS
	bra	ELSE195_1
;Abs = -SysCalcTempA
	comf	SYSCALCTEMPA,W,ACCESS
	movwf	ABS,ACCESS
	comf	SYSCALCTEMPA_H,W,ACCESS
	movwf	ABS_H,ACCESS
	incf	ABS,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	ABS_H,F,ACCESS
;Else
	bra	ENDIF195
ELSE195_1
;Abs = SysCalcTempA
	movff	SYSCALCTEMPA,ABS
	movff	SYSCALCTEMPA_H,ABS_H
;End If
ENDIF195
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (418)
ADC
;
;The top three MSBs of the ADC are displayed on the LEDs. Rotate the potentiometer to change
;the display. The LCD displays “ADC” on the first line and “ADC Result = x” on the second line where
;x shows the current ADC conversion.
;
;Dim adcResult as Word
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF18
;HserPrint Str(labNumber) + ": ADC Lab"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable16
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable16
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable16
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;CLS
	rcall	CLS
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Print "      ADC      "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable17
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable17
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable17
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*15
	call	PRINT157
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;end if
ENDIF18
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF19
;Get the top 3 MSBs and display these on the LEDs
;adcResult = ReadAD10 ( AN0 )
	clrf	ADREADPORT,ACCESS
	call	FN_READAD1048
	movff	SYSREADAD10WORD,ADCRESULT
	movff	SYSREADAD10WORD_H,ADCRESULT_H
;Display the ADC result on the LCD
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print " ADC Result =   "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable18
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable18
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable18
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;Locate 1,10
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	10
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print leftpad( str(adcResult), 4, " " )
	movff	ADCRESULT,SYSVALTEMP
	movff	ADCRESULT_H,SYSVALTEMP_H
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	4
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable19
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysSYSINSTRING2Handler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING2Handler_H,BANKED
;Using SYSSTRINGPARAM2*1
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT157
;Now show on LEDS
;Get the top 3 MSBs (Shift LEFT), then *2 ( Shift Right) and display these on the LEDs
;adcResult = (FnLSR ( adcResult, 7)) * 2
	movff	ADCRESULT,SYSWORDTEMPB
	movff	ADCRESULT_H,SYSWORDTEMPB_H
	movlw	7
	movwf	NUMBITS,ACCESS
	call	FN_FNLSR126
	movff	SYSFNLSRWORD,SysWORDTempA
	movff	SYSFNLSRWORD_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSMULTSUB16
	movff	SysWORDTempX,ADCRESULT
	movff	SysWORDTempX_H,ADCRESULT_H
;PortB = ( PortB and 0xF1) OR adcResult
	movlw	241
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	ADCRESULT,W,ACCESS
	movwf	PORTB,ACCESS
;wait 100 ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;end if
ENDIF19
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;end If
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (291)
BLINK
;
;LED D8 blinks at a rate of approximately 1.5 seconds. The LCD displays “Blink” on the first line
;while displaying “LED_D5 = ON” and “LED_D5 = OFF” alternately every 1.5 seconds on the second
;line.
;
;Dim flagCounter as  Byte
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF6
;HserPrint Str(labNumber) + ": Blink Lab"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable10
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;flagCounter = 0
	clrf	FLAGCOUNTER,ACCESS
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Print "     Blink      "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable11
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;InitTimer1 OSC , PS1_4
	movlw	1
	movwf	TMRSOURCE,BANKED
	movlw	32
	movwf	TMRPRES,BANKED
	call	INITTIMER1
;Settimer 1, 0x0BDC
	movlw	1
	movwf	TMRNUMBER,BANKED
	movlw	220
	movwf	TMRVALUE,BANKED
	movlw	11
	movwf	TMRVALUE_H,BANKED
	call	SETTIMER228
;TMR1IE = 0
	banksel	PIE4
	bcf	PIE4,TMR1IE,BANKED
;TMR1IF = 0
	bcf	PIR4,TMR1IF,BANKED
;StartTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STARTTIMER
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;end if
ENDIF6
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF7
;if  LED_D5 = 1 Then
	btfss	PORTB,3,ACCESS
	bra	ELSE9_1
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "  LED_D5 = ON   "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable9
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;else
	bra	ENDIF9
ELSE9_1
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "  LED_D5 = OFF   "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*17
	call	PRINT157
;end if
ENDIF9
;wait while TMR1IF = 0
SysWaitLoop1
	banksel	PIR4
	btfss	PIR4,TMR1IF,BANKED
	bra	SysWaitLoop1
;StopTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STOPTIMER
;Settimer 1, 0x0BDC
	movlw	1
	movwf	TMRNUMBER,BANKED
	movlw	220
	movwf	TMRVALUE,BANKED
	movlw	11
	movwf	TMRVALUE_H,BANKED
	call	SETTIMER228
;StartTimer 1
	movlw	1
	movwf	TMRNUMBER,BANKED
	call	STARTTIMER
;Clear the interrupt flag
;TMR1IF = 0
	banksel	PIR4
	bcf	PIR4,TMR1IF,BANKED
;flagCounter++
	incf	FLAGCOUNTER,F,ACCESS
;if flagCounter = BLINK_FLAG_COUNTER_MAX Then
	movlw	6
	subwf	FLAGCOUNTER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF10
;LED_D5 = !LED_D5
	banksel	SYSTEMP1
	clrf	SysTemp1,BANKED
	btfsc	PORTB,3,ACCESS
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	LATB,3,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,3,ACCESS
;flagCounter = 0
	clrf	FLAGCOUNTER,ACCESS
;end if
ENDIF10
;end if
ENDIF7
;if switchEvent = 1 Then
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF8
;StopTimer 1
	movlw	1
	movwf	TMRNUMBER,BANKED
	call	STOPTIMER
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
ENDIF8
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (1268)
BUTTONPRESSEDISR
;A positive or negative edge was detected on the RA4 pin
;IF IOCAF4 = 1 And switchEvent = 0 Then
	clrf	SysByteTempX,ACCESS
	banksel	IOCAF
	btfsc	IOCAF,IOCAF4,BANKED
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	SWITCHEVENT,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	banksel	0
	call	SYSCOMPEQUAL
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF90
;IOCAF4 = 0
	banksel	IOCAF
	bcf	IOCAF,IOCAF4,BANKED
;switchEvent = 1
	movlw	1
	banksel	SWITCHEVENT
	movwf	SWITCHEVENT,BANKED
;On Interrupt PortChange Ignore
	banksel	PIE0
	bcf	PIE0,IOCIE,BANKED
;End If
ENDIF90
	banksel	0
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (1777)
BUZZER
;
;The demo shows how to send psuedo music to the buzzer.  Enjoy.
;
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF124
;HserPrint Str(labNumber) + ": Buzzer"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable93
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable93
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable93
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;CLS
	rcall	CLS
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Print "  Buzzer   "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable94
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable94
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable94
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*11
	call	PRINT157
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;Include the sound library
;Dir SOUNDOUT Out
	bcf	TRISC,2,ACCESS
;Dim SoundPlayRTTTLDataString as String
;end if
ENDIF124
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF125
;SoundPlayRTTTLDataString = "Thegood,:d=4,o=6,b=63:32c,32f,32c,32f,c,8g_5,8a_5,f5,8p,32c,32f,32c,32f,c,8g_5,8a_5,d_"
	lfsr	1,SOUNDPLAYRTTTLDATASTRING
	movlw	low StringTable95
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable95
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable95
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
;PlayRTTTL(SoundPlayRTTTLDataString)
	movlw	low SOUNDPLAYRTTTLDATASTRING
	movwf	SysSOUNDPLAYDATAHandler,BANKED
	movlw	high SOUNDPLAYRTTTLDATASTRING
	movwf	SysSOUNDPLAYDATAHandler_H,BANKED
	call	PLAYRTTTL
;checkButtonS2HeldDown
	rcall	CHECKBUTTONS2HELDDOWN
;end if
ENDIF125
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
	return

;********************************************************************************

;Source: pwm.h (4627)
CALCULATEDUTY
;dim PRx_Temp as long
;dim PWMDuty as word
;dim PWMResolution as word
;assumes PRx_Temp and PWMDuty are valid
;PRx_Temp = PWMDuty  * ( PRx_Temp + 1 )
	movlw	1
	addwf	PRX_TEMP,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	PRX_TEMP_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	0
	addwfc	PRX_TEMP_U,W,BANKED
	movwf	SysTemp1_U,BANKED
	movlw	0
	addwfc	PRX_TEMP_E,W,BANKED
	movwf	SysTemp1_E,BANKED
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
	movwf	SysRepeatTemp9,BANKED
SysRepeatLoop9
;rotate PRx_Temp left
	rlcf	PRX_TEMP,F,BANKED
	rlcf	PRX_TEMP_H,F,BANKED
	rlcf	PRX_TEMP_U,F,BANKED
	rlcf	PRX_TEMP_E,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp9,F,BANKED
	bra	SysRepeatLoop9
SysRepeatLoopEnd9
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
	movwf	SysRepeatTemp9,BANKED
SysRepeatLoop10
;rotate PRx_Temp left
	rlcf	PRX_TEMP,F,BANKED
	rlcf	PRX_TEMP_H,F,BANKED
	rlcf	PRX_TEMP_U,F,BANKED
	rlcf	PRX_TEMP_E,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp9,F,BANKED
	bra	SysRepeatLoop10
SysRepeatLoopEnd10
;exits with PRx_Temp calculated
	return

;********************************************************************************

;Source: lcd.h (1106)
CHECKBUSYFLAG
;Sub that waits until LCD controller busy flag goes low (ready)
;Only used by LCD_IO 4,8 and only when LCD_NO_RW is NOT Defined
;Called by sub LCDNOrmalWriteByte
;LCD_RSTemp = LCD_RS
	bcf	SYSLCDTEMP,2,BANKED
	btfsc	PORTD,4,ACCESS
	bsf	SYSLCDTEMP,2,BANKED
;DIR SCRIPT_LCD_BF  IN
	bsf	TRISD,3,ACCESS
;SET LCD_RS OFF
	bcf	LATD,4,ACCESS
;SET LCD_RW ON
	bsf	LATD,5,ACCESS
;LCDTEMPRWCount = 0
	clrf	LCDTEMPRWCOUNT,ACCESS
;Do
SysDoLoop_S7
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS18
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS18
;Set LCD_Enable ON
	bsf	LATD,6,ACCESS
;wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS19
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS19
;SysLCDTemp.7 = SCRIPT_LCD_BF
	bcf	SYSLCDTEMP,7,BANKED
	btfsc	PORTD,3,ACCESS
	bsf	SYSLCDTEMP,7,BANKED
;Set LCD_Enable OFF
	bcf	LATD,6,ACCESS
;Wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS20
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS20
;PulseOut LCD_Enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6,ACCESS
;WaitL1 Time
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS21
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS21
;Set Pin Off
	bcf	LATD,6,ACCESS
;Wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS22
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS22
;if LCDTEMPRWCount = 255 Then SysLCDTemp.7 = 0
	incf	LCDTEMPRWCOUNT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;if LCDTEMPRWCount = 255 Then SysLCDTemp.7 = 0
	bcf	SYSLCDTEMP,7,BANKED
;if LCDTEMPRWCount = 255 Then SysLCDTemp.7 = 0
;LCDTEMPRWCount++
	incf	LCDTEMPRWCOUNT,F,ACCESS
;Loop While SysLCDTemp.7 <> 0
	btfsc	SYSLCDTEMP,7,BANKED
	bra	SysDoLoop_S7
SysDoLoop_E7
;LCD_RS = LCD_RSTemp
	bcf	LATD,4,ACCESS
	btfsc	SYSLCDTEMP,2,BANKED
	bsf	LATD,4,ACCESS
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (1840)
CHECKBUTTONS2
;if btnState = NOT_PRESSED Then
	movf	BTNSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE128_1
;if SWITCH_S2_PORT = 0 Then
	btfsc	PORTA,4,ACCESS
	bra	ENDIF129
;wait 100 ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;btnState = PRESSED
	movlw	1
	movwf	BTNSTATE,ACCESS
;end If
ENDIF129
;else if SWITCH_S2_PORT = 1 Then
	bra	ENDIF128
ELSE128_1
	btfss	PORTA,4,ACCESS
	bra	ENDIF128
;btnState = NOT_PRESSED
	clrf	BTNSTATE,ACCESS
;switchEvent = 1
	movlw	1
	movwf	SWITCHEVENT,BANKED
;end if
ENDIF128
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (1854)
CHECKBUTTONS2HELDDOWN
;if SWITCH_S2_PORT = 0 Then
	btfsc	PORTA,4,ACCESS
	bra	ENDIF130
;switchEvent = 1
	movlw	1
	movwf	SWITCHEVENT,BANKED
;end if
ENDIF130
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (1815)
FN_CHECKBUTTONS3
;Toggle the port to Input/High to cater for the attached LED and the Switch - this action is specific to this board where the S3 is also tied to the LED2.
;This action sets the port in a state where the S3 switch state can read.
;Typically not required
;DIR SWITCH_S3_PORT OUT
;SWITCH_S3_PORT = 1
;DIR SWITCH_S3_PORT IN
	bsf	TRISB,0,ACCESS
;SWITCH_S3_PORT = 1
	bsf	LATB,0,ACCESS
;Set weak pullup
;WPUB0 = 1
	banksel	WPUB
	bsf	WPUB,WPUB0,BANKED
;The Switch is normally tied to VDD ...when it is pressed, the switch port is connected to GND
;Return the value
;checkButtonS3 = SWITCH_S3_PORT
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,4,BANKED
	btfsc	PORTB,0,ACCESS
	bsf	SYSBITVAR0,4,BANKED
;unSet weak pullup
;WPUB0 = 0
	banksel	WPUB
	bcf	WPUB,WPUB0,BANKED
;set DIR
;DIR SWITCH_S3_PORT OUT
	bcf	TRISB,0,ACCESS
	banksel	0
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (1733)
CLOCK
;
;A very simple clock function.  This uses the 32.768Hz external clock source.
;
;This can be developed into a full clock solution.
;
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF119
;HserPrint Str(labNumber) + ": CLOCK"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable91
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable91
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable91
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;CLS
	rcall	CLS
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Print "CLOCK RUNNING"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable92
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable92
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable92
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*13
	call	PRINT157
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;Dim ClockState as Bit
;ClockState = !ClockState
	clrf	SysTemp2,BANKED
	btfsc	SYSBITVAR0,3,BANKED
	incf	SysTemp2,F,BANKED
	comf	SysTemp2,F,BANKED
	bcf	SYSBITVAR0,3,BANKED
	btfsc	SysTemp2,0,BANKED
	bsf	SYSBITVAR0,3,BANKED
;Dim TicCount as Byte
;TicCount = 0
	clrf	TICCOUNT,BANKED
;SOSCEN = 1
	banksel	OSCEN
	bsf	OSCEN,SOSCEN,BANKED
;SOSCPWR = 1
	bsf	OSCCON3,SOSCPWR,BANKED
;TMR1H  = 0x80
	movlw	128
	movwf	TMR1H,ACCESS
;Starttimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STARTTIMER
;On Interrupt Timer1Overflow Call Memory_ISR
	banksel	PIE4
	bsf	PIE4,TMR1IE,BANKED
;end if
ENDIF119
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF120
;end if
ENDIF120
;if switchEvent = 1 Then
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF121
;SOSCEN = 0
	banksel	OSCEN
	bcf	OSCEN,SOSCEN,BANKED
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
ENDIF121
	banksel	0
	return

;********************************************************************************

;Source: lcd.h (511)
CLS
;Sub to clear the LCD
;SET LCD_RS OFF
	bcf	LATD,4,ACCESS
;Clear screen
;LCDWriteByte (0b00000001)
	movlw	1
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
;Wait 4 ms
	movlw	4
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Move to start of visible DDRAM
;LCDWriteByte(0x80)
	movlw	128
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
;Wait 50 us
	movlw	1
	movwf	DELAYTEMP2,ACCESS
DelayUSO3
	clrf	DELAYTEMP,ACCESS
DelayUS3
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS3
	decfsz	DELAYTEMP2,F,ACCESS
	bra	DelayUSO3
	movlw	9
	movwf	DELAYTEMP,ACCESS
DelayUS4
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS4
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (536)
DEBOUNCE
;
;LEDs D3, D4 and D5 light up in turn on every S1 button press. Once D3 is lit and S1 is pressed,
;D4 lights up and the pattern repeats. Holding the button moves the light continuously across the
;LEDs. The LCD displays “Debounce” on the first line and “LED_Dx = ON” on the second line, where
;x indicates which LED is currently lit.
;
;Dim LEDState
;Dim adcResult as Word
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF26
;HserPrint Str(labNumber) + ": Debounce Lab"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable23
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable23
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable23
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	rcall	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;Begin with LED_D2 high
;PORTB = ( PORTB AND 0xF0 ) OR 0x02
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	2
	iorwf	SysTemp1,W,BANKED
	movwf	PORTB,ACCESS
;LED_D3 = 1
	bsf	LATB,1,ACCESS
;activeLedNum = 2
	movlw	2
	movwf	ACTIVELEDNUM,ACCESS
;CLS
	rcall	CLS
;Print "    Debounce    "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable24
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable24
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable24
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "    Press S3    "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable25
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable25
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable25
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;end if
ENDIF26
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF27
;if checkButtonS3 = 0 Then
	rcall	FN_CHECKBUTTONS3
	btfsc	SYSBITVAR0,4,BANKED
	bra	ENDIF29
;Debounce by delaying
;wait 100 ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;If S3 is still pressed, shift the light to the next LED to the right
;if checkButtonS3 = 0 Then
	rcall	FN_CHECKBUTTONS3
	btfsc	SYSBITVAR0,4,BANKED
	bra	ENDIF30
;Rotate LEDs: Get the bits with the LEDs
;LEDState = PORTB AND 0x0E
	movlw	14
	andwf	PORTB,W,ACCESS
	movwf	LEDSTATE,ACCESS
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate LEDState Left
	rlcf	LEDSTATE,F,ACCESS
;Set the bits with the LEDs leaving the upper bits as-was.
;LATB = ( PORTB AND 0xF1 ) OR LEDState
	movlw	241
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	LEDSTATE,W,ACCESS
	movwf	LATB,ACCESS
;activeLedNum++
	incf	ACTIVELEDNUM,F,ACCESS
;If the last LED (D5) is lit, go back to the first LED (D2)
;if activeLedNum > 4 then
	movf	ACTIVELEDNUM,W,ACCESS
	sublw	4
	btfsc	STATUS, C,ACCESS
	bra	ENDIF31
;LED_D3 = 1
	bsf	LATB,1,ACCESS
;activeLedNum = 2
	movlw	2
	movwf	ACTIVELEDNUM,ACCESS
;end if
ENDIF31
;Display which LED is ON on the LCD
;Locate 1, 0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "  LED_D  = ON   "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable15
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;Locate 1,7
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	7
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print activeLedNum + 1
	incf	ACTIVELEDNUM,W,ACCESS
	movwf	LCDVALUE,ACCESS
	call	PRINT158
;end if
ENDIF30
;end if
ENDIF29
;end if
ENDIF27
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
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

;Source: 20_Capability_demo.gcb (966)
EEPROM
;
;Press the switch to show the ADC reading on the LCD and save it to the on-chip Data EEPROM.
;The LCD displays “EEPROM” on the first line and “Value = x” on the second line, where x
;corresponds to the saved ADC result in the EEPROM.
;
;Dim flagCounter, adcResult, eeprom_address as  Byte
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF62
;HserPrint Str(labNumber) + ": EEPROM Lab"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable44
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable44
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable44
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	rcall	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;Use randomize, with the value of ADC as the seed
;Randomize ReadAD( AN0 )
	clrf	ADREADPORT,ACCESS
	call	FN_READAD46
	movff	SYSREADADBYTE,RANDOMTEMP
	clrf	RANDOMTEMP_H,BANKED
	call	RANDOMIZE
;Set the address to a random address.  To protect EEProm write usage constraint
;eeprom_address = Random
	call	FN_RANDOM
	movff	RANDOM,EEPROM_ADDRESS
;flagCounter = 0
	clrf	FLAGCOUNTER,ACCESS
;CLS
	rcall	CLS
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Print "     EEPROM        "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable45
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable45
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable45
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*19
	call	PRINT157
;InitTimer1 FOSC4 , PS1_4
	movlw	1
	movwf	TMRSOURCE,BANKED
	movlw	32
	movwf	TMRPRES,BANKED
	call	INITTIMER1
;Settimer 1, 0x0BDC
	movlw	1
	movwf	TMRNUMBER,BANKED
	movlw	220
	movwf	TMRVALUE,BANKED
	movlw	11
	movwf	TMRVALUE_H,BANKED
	call	SETTIMER228
;TMR1IF = 0
	banksel	PIR4
	bcf	PIR4,TMR1IF,BANKED
;StartTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STARTTIMER
;On Interrupt Timer1Overflow Call Memory_ISR
	banksel	PIE4
	bsf	PIE4,TMR1IE,BANKED
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;end if
ENDIF62
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF63
;If flagCounter = 0 Then
	movf	FLAGCOUNTER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF65
;The interrupt write, so, we read from here.
;EPRead ( eeprom_address, adcResult )
	movff	EEPROM_ADDRESS,SYSEEADDRESS
	banksel	SYSEEADDRESS_H
	clrf	SYSEEADDRESS_H,BANKED
	call	NVMADR_EPREAD
	movff	EEDATAVALUE,ADCRESULT
;locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print " ADC Result =   "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable18
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable18
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable18
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "EEPROM @"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable46
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable46
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable46
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*8
	call	PRINT157
;Print hex(eeprom_address)
	movff	EEPROM_ADDRESS,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT157
;Locate 1,11
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	11
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print leftpad( str(adcResult), 4, " " )
	movff	ADCRESULT,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	4
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable19
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysSYSINSTRING2Handler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING2Handler_H,BANKED
;Using SYSSTRINGPARAM2*1
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT157
;Now show on LEDS
;Get the top MSBs (Shift LEFT) and display these on the LEDs
;adcResult = (FnLSR ( adcResult, 4))
	movff	ADCRESULT,SYSBYTETEMPB
	movlw	4
	movwf	NUMBITS,ACCESS
	rcall	FN_FNLSR127
	movff	SYSFNLSRBYTE,ADCRESULT
;PortB = ( PortB and 0xF0) OR adcResult
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	ADCRESULT,W,ACCESS
	movwf	PORTB,ACCESS
;end if
ENDIF65
;end if
ENDIF63
;if switchEvent = 1 Then
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF64
;On Interrupt Timer1Overflow Ignore
	banksel	PIE4
	bcf	PIE4,TMR1IE,BANKED
;StopTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STOPTIMER
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
ENDIF64
	return

;********************************************************************************

;Overloaded signature: BYTE:WORD:BYTE:, Source: i2ceeprom.h (319)
EEPROM_RD_ARRAY34
;`eeprom_rd_array - Uses a WORD for eepAddr.  Intended for larger memory eeproms that require ADDRESS_H and ADDRESS (two bytes, therefore passed as a word ) to set addreess`
;do
SysDoLoop_S5
;HI2CReStart                              ;generate a start signal
	rcall	HI2CRESTART
;HI2CSend(eepDev)                       ;indicate a write
	movlw	160
	movwf	I2CBYTE,ACCESS
	rcall	HI2CSEND
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F,ACCESS
	btfss	STATUS,Z,ACCESS
	bra	SysDoLoop_S5
SysDoLoop_E5
;HI2CSend(eepAddr_H)                    ;as two bytes
	movff	EEPADDR_H,I2CBYTE
	rcall	HI2CSEND
;HI2CSend(eepAddr)
	movff	EEPADDR,I2CBYTE
	rcall	HI2CSEND
;HI2CReStart
	rcall	HI2CRESTART
;HI2CSend(eepDev + 1)                   ;indicate a read
	movlw	161
	movwf	I2CBYTE,ACCESS
	rcall	HI2CSEND
;eep_i = 0                             ;loop consecutively
	clrf	EEP_I,ACCESS
;do while (eep_i < eepLen)             ;these many bytes
SysDoLoop_S6
	movf	EEPLEN,W,ACCESS
	subwf	EEP_I,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	SysDoLoop_E6
;eep_j = eep_i + 1                   ;arrays begin at 1 not 0
	incf	EEP_I,W,ACCESS
	movwf	EEP_J,ACCESS
;if (eep_i  < (eepLen - 1)) then
	decf	EEPLEN,W,ACCESS
	movwf	SysTemp2,BANKED
	movff	EEP_I,SysBYTETempA
	movff	SysTemp2,SysBYTETempB
	call	SYSCOMPLESSTHAN
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE135_1
;HI2CReceive(eepArray(eep_j), ACK)  ;more data to get
	setf	HI2CGETACK,ACCESS
	rcall	HI2CRECEIVE
	movf	EEP_J,W,ACCESS
	addwf	SysEEPARRAYHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysEEPARRAYHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	I2CBYTE,INDF0
;else
	bra	ENDIF135
ELSE135_1
;HI2CReceive(eepArray(eep_j), NACK ) ;send NACK on last byte
	clrf	HI2CGETACK,ACCESS
	rcall	HI2CRECEIVE
	movf	EEP_J,W,ACCESS
	addwf	SysEEPARRAYHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysEEPARRAYHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	I2CBYTE,INDF0
;end if
ENDIF135
;eep_i++                             ;get set for next
	incf	EEP_I,F,ACCESS
;loop
	bra	SysDoLoop_S6
SysDoLoop_E6
;HI2CStop
	bra	HI2CSTOP

;********************************************************************************

;Overloaded signature: BYTE:BYTE:WORD:BYTE:, Source: i2ceeprom.h (204)
EEPROM_WR_ARRAY32
;`eeprom_wr_array - Uses a WORD for eepAddr.  Intended for larger memory eeproms that require ADDRESS_H and ADDRESS (two bytes, therefore passed as a word ) to set addreess`
;do
SysDoLoop_S3
;HI2CReStart                              ;generate a start signal
	rcall	HI2CRESTART
;HI2CSend(eepDev)                       ;indicate a write
	movlw	160
	movwf	I2CBYTE,ACCESS
	rcall	HI2CSEND
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F,ACCESS
	btfss	STATUS,Z,ACCESS
	bra	SysDoLoop_S3
SysDoLoop_E3
;HI2CSend(eepAddr_H)                    ;and the start address
	movff	EEPADDR_H,I2CBYTE
	rcall	HI2CSEND
;HI2CSend(eepAddr)                      ;as two bytes
	movff	EEPADDR,I2CBYTE
	rcall	HI2CSEND
;for eep_i = 1 to eepLen
;Legacy method
	clrf	EEP_I,ACCESS
	movlw	1
	subwf	EEPLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd7
SysForLoop7
	incf	EEP_I,F,ACCESS
;HI2CSend(eepArray(eep_i))            ;write next byte from array
	movf	EEP_I,W,ACCESS
	addwf	SysEEPARRAYHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysEEPARRAYHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,I2CBYTE
	rcall	HI2CSEND
;eepAddr++                           ;prep for next one
	incf	EEPADDR,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EEPADDR_H,F,ACCESS
;CalcNextPage = eepAddr mod eepPageSize  ; calculate next page
	movff	EEPADDR,SysWORDTempA
	movff	EEPADDR_H,SysWORDTempA_H
	movff	EEPPAGESIZE,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempX,CALCNEXTPAGE
;if CalcNextPage = 0 then ;end of page
	movf	CALCNEXTPAGE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF133
;HI2CStop                           ;so, lock in place
	rcall	HI2CSTOP
;do
SysDoLoop_S4
;HI2CReStart                              ;generate a start signal
	rcall	HI2CRESTART
;HI2CSend(eepDev)                         ;indicate a write
	movlw	160
	movwf	I2CBYTE,ACCESS
	rcall	HI2CSEND
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F,ACCESS
	btfss	STATUS,Z,ACCESS
	bra	SysDoLoop_S4
SysDoLoop_E4
;HI2CSend(eepAddr_H)                ;send next page address
	movff	EEPADDR_H,I2CBYTE
	rcall	HI2CSEND
;HI2CSend(eepAddr)
	movff	EEPADDR,I2CBYTE
	rcall	HI2CSEND
;end if
ENDIF133
;next
	movf	EEPLEN,W,ACCESS
	subwf	EEP_I,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
;HI2CStop
	bra	HI2CSTOP

;********************************************************************************

;Overloaded signature: WORD:BYTE:, Source: stdbasic.h (389)
FN_FNLSR126
;Repeat NumBits
	movff	NUMBITS,SysRepeatTemp11
	movf	SYSREPEATTEMP11,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd11
SysRepeatLoop11
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysWordTempB Right
	rrcf	SYSWORDTEMPB_H,F,ACCESS
	rrcf	SYSWORDTEMPB,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp11,F,BANKED
	bra	SysRepeatLoop11
SysRepeatLoopEnd11
;FnLSR = SysWordTempB
	movff	SYSWORDTEMPB,FNLSR
	movff	SYSWORDTEMPB_H,FNLSR_H
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:, Source: stdbasic.h (398)
FN_FNLSR127
;Repeat NumBits
	movff	NUMBITS,SysRepeatTemp12
	movf	SYSREPEATTEMP12,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd12
SysRepeatLoop12
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysByteTempB Right
	rrcf	SYSBYTETEMPB,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp12,F,BANKED
	bra	SysRepeatLoop12
SysRepeatLoopEnd12
;FnLSR = SysByteTempB
	movff	SYSBYTETEMPB,FNLSR
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (254)
HELLOWORLD
;
;The LEDs are connected to the microcontroller input-output pins (I/O). First, the I/O pin must be
;configured as an output. When one of these pins is driven high, the LED will turn on. The
;two logic levels ‘1’ (high) and ‘0’ (low) are derived from the power pins of the MCU. ‘1’ is equivalent
;to the device’s power pin (VDD) and ‘0’ to the source (VSS). VDD may vary depending upon the
;supply requirements of the specific device used but VSS is always connected to ground and is equal
;to ‘0’.
;
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF3
;HserPrint Str(labNumber) + ": Hello World Lab"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable7
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	rcall	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Print "  Hello World   "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable8
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;end if
ENDIF3
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF4
;LED_D5 = 1
	bsf	LATB,3,ACCESS
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "  LED_D5 = ON   "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable9
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;end if
ENDIF4
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
	return

;********************************************************************************

;Source: hwi2c.h (721)
HI2CINIT
;This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K-Mode family chips
;HI2CCurrentMode = 0
	clrf	HI2CCURRENTMODE,ACCESS
;Initialise the I2C module
	return

;********************************************************************************

;Source: hwi2c.h (259)
HI2CMODE
;This method sets the variable `HI2CCurrentMode`, and, if required, sets the SSPCON1.bits
;#ifdef var(SSPCON1) added to separate from newer i2C module which does not have an SSPCON1
;set SSPSTAT.SMP on
	bsf	SSP1STAT,SMP,ACCESS
;set SSPCON1.CKP on
	bsf	SSP1CON1,CKP,ACCESS
;set SSPCON1.WCOL Off
	bcf	SSP1CON1,WCOL,ACCESS
;Select mode and clock
;If HI2CCurrentMode = Master Then
	movlw	12
	subwf	HI2CCURRENTMODE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF289
;set SSPCON1.SSPM3 on
	bsf	SSP1CON1,SSPM3,ACCESS
;set SSPCON1.SSPM2 off
	bcf	SSP1CON1,SSPM2,ACCESS
;set SSPCON1.SSPM1 off
	bcf	SSP1CON1,SSPM1,ACCESS
;set SSPCON1.SSPM0 off
	bcf	SSP1CON1,SSPM0,ACCESS
;SSPADD = HI2C_BAUD_TEMP and 127
	movlw	39
	movwf	SSP1ADD,ACCESS
;end if
ENDIF289
;if HI2CCurrentMode = Slave then
	movf	HI2CCURRENTMODE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF290
;set SSPCON1.SSPM3 off
	bcf	SSP1CON1,SSPM3,ACCESS
;set SSPCON1.SSPM2 on
	bsf	SSP1CON1,SSPM2,ACCESS
;set SSPCON1.SSPM1 on
	bsf	SSP1CON1,SSPM1,ACCESS
;set SSPCON1.SSPM0 off
	bcf	SSP1CON1,SSPM0,ACCESS
;end if
ENDIF290
;if HI2CCurrentMode = Slave10 then
	movlw	3
	subwf	HI2CCURRENTMODE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF291
;set SSPCON1.SSPM3 off
	bcf	SSP1CON1,SSPM3,ACCESS
;set SSPCON1.SSPM2 on
	bsf	SSP1CON1,SSPM2,ACCESS
;set SSPCON1.SSPM1 on
	bsf	SSP1CON1,SSPM1,ACCESS
;set SSPCON1.SSPM0 on
	bsf	SSP1CON1,SSPM0,ACCESS
;end if
ENDIF291
;Enable I2C
;set SSPCON1.SSPEN on
	bsf	SSP1CON1,SSPEN,ACCESS
	return

;********************************************************************************

;Source: hwi2c.h (459)
HI2CRECEIVE
;Enable receive
;Master_mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE299_1
;if HI2CGetAck.0 = 1 then
	btfss	HI2CGETACK,0,ACCESS
	bra	ELSE301_1
;Acknowledge
;ACKDT = 0
	bcf	SSP1CON2,ACKDT,ACCESS
;else
	bra	ENDIF301
ELSE301_1
;Not Acknowledge
;ACKDT = 1
	bsf	SSP1CON2,ACKDT,ACCESS
;end if
ENDIF301
;RCEN = 1
	bsf	SSP1CON2,RCEN,ACCESS
;Slave mode
;Else
	bra	ENDIF299
ELSE299_1
;SET SSPSTAT.R_NOT_W ON
	bsf	SSP1STAT,R_NOT_W,ACCESS
;End If
ENDIF299
;Clear Collisions
;SET SSPCON1.WCOL OFF
	bcf	SSP1CON1,WCOL,ACCESS
;SET SSPCON1.SSPOV Off
	bcf	SSP1CON1,SSPOV,ACCESS
;Wait for receive
;Wait Until SSPSTAT.BF = 1 AND SSPIF = 1
SysWaitLoop10
	clrf	SysByteTempX,ACCESS
	btfsc	SSP1STAT,BF,ACCESS
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	clrf	SysByteTempX,ACCESS
	banksel	PIR3
	btfsc	PIR3,SSP1IF,BANKED
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	SysWaitLoop10
;I2CByte = SSPBUF
	movff	SSP1BUF,I2CBYTE
;SSPIF = 0''Support for SSPIF
	banksel	PIR3
	bcf	PIR3,SSP1IF,BANKED
;ACKEN = 1; Send ACK DATA now. ' bsf SSPCON2,ACKEN
	bsf	SSP1CON2,ACKEN,ACCESS
;Clear flag - this is required
;SSPSTAT.BF = 0
	bcf	SSP1STAT,BF,ACCESS
;HI2CWaitMSSP
	banksel	0
	rcall	HI2CWAITMSSP
;Disable receive (Master_mode)
;Master_mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE300_1
;Set SSPCON2.RCEN Off
	bcf	SSP1CON2,RCEN,ACCESS
;Slave mode
;Else
	bra	ENDIF300
ELSE300_1
;SET SSPSTAT.R_NOT_W Off
	bcf	SSP1STAT,R_NOT_W,ACCESS
;End If
ENDIF300
	return

;********************************************************************************

;Source: hwi2c.h (350)
HI2CRESTART
;This method sets the registers and register bits to generate the I2C  RESTART signal
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ENDIF293
;Master_mode operational
;Set RSEN On
	bsf	SSP1CON2,RSEN,ACCESS
;HI2CWaitMSSP
	rcall	HI2CWAITMSSP
;End If
ENDIF293
	return

;********************************************************************************

;Source: hwi2c.h (430)
HI2CSEND
;This method sets the registers and register bits to send I2C data
RETRYHI2CSEND
;Clear WCOL
;SET SSPCON1.WCOL OFF
	bcf	SSP1CON1,WCOL,ACCESS
;Load data to send
;SSPBUF = I2CByte
	movff	I2CBYTE,SSP1BUF
;HI2CWaitMSSP
	rcall	HI2CWAITMSSP
;if ACKSTAT =  1 then
	btfss	SSP1CON2,ACKSTAT,ACCESS
	bra	ELSE295_1
;HI2CAckPollState = true
	setf	HI2CACKPOLLSTATE,ACCESS
;else
	bra	ENDIF295
ELSE295_1
;HI2CAckPollState = false
	clrf	HI2CACKPOLLSTATE,ACCESS
;end if
ENDIF295
;If SSPCON1.WCOL = On Then
	btfss	SSP1CON1,WCOL,ACCESS
	bra	ENDIF296
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	bra	RETRYHI2CSEND
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
;End If
ENDIF296
;Release clock (only needed by slave)
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	bsf	SSP1CON1,CKP,ACCESS
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	return

;********************************************************************************

;Source: hwi2c.h (314)
HI2CSTART
;This method sets the registers and register bits to generate the I2C  START signal
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE292_1
;Master_mode operational
;for device with SEN_SSP1CON2 and therefore devices including the 18FxxK40
;Set SEN_SSP1CON2 On
	bsf	SSP1CON2,SEN_SSP1CON2,ACCESS
;HI2CWaitMSSP
	rcall	HI2CWAITMSSP
;Else
	bra	ENDIF292
ELSE292_1
;Slave mode operational
;Wait Until SSPSTAT.S = On
SysWaitLoop7
	btfss	SSP1STAT,S,ACCESS
	bra	SysWaitLoop7
;End If
ENDIF292
	return

;********************************************************************************

;Source: hwi2c.h (364)
HI2CSTOP
;Master_mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE294_1
;set SSPIE OFF; disable SSP interrupt, tested by Anobium but not implemented.
;wait while R_NOT_W = 1   'wait for completion of activities
SysWaitLoop8
	btfsc	SSP1STAT,R_NOT_W,ACCESS
	bra	SysWaitLoop8
;Set SSPCON2.PEN On
	bsf	SSP1CON2,PEN,ACCESS
;Set SSPCON2.PEN On
	bsf	SSP1CON2,PEN,ACCESS
;HI2CWaitMSSP
	rcall	HI2CWAITMSSP
;Slave mode
;Else
	bra	ENDIF294
ELSE294_1
;Wait Until SSPSTAT.P = On
SysWaitLoop9
	btfss	SSP1STAT,P,ACCESS
	bra	SysWaitLoop9
;End If
ENDIF294
	return

;********************************************************************************

;Source: hwi2c.h (517)
HI2CWAITMSSP
;HI2CWaitMSSPTimeout = 0
	clrf	HI2CWAITMSSPTIMEOUT,ACCESS
HI2CWAITMSSPWAIT
;HI2CWaitMSSPTimeout++
	incf	HI2CWAITMSSPTIMEOUT,F,ACCESS
;if HI2CWaitMSSPTimeout < 255 then
	movlw	255
	subwf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF302
;'Support for SSP1IF
;if SSP1IF = 0 then
	banksel	PIR3
	btfsc	PIR3,SSP1IF,BANKED
	bra	ENDIF304
;wait 2 us
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS17
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS17
	nop
;goto HI2CWaitMSSPWait
	bra	HI2CWAITMSSPWAIT
;end if
ENDIF304
;Clear the flag and exit sub with HI2CWaitMSSPTimeout NOT set to 255
;SSP1IF = 0
	bcf	PIR3,SSP1IF,BANKED
;end if
ENDIF302
;Clear the flag
;if HI2CWaitMSSPTimeout = 255 Then BCL1IF = 0
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF303
;if HI2CWaitMSSPTimeout = 255 Then BCL1IF = 0
	banksel	PIR3
	bcf	PIR3,BCL1IF,BANKED
;if HI2CWaitMSSPTimeout = 255 Then BCL1IF = 0
ENDIF303
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:BYTE:, Source: pwm.h (2805)
HPWM66
;Dim PRx_Temp as LONG
;Dim PRx_Temp_Cache as Long
;dim PWMDuty as word
;dim PWMResolution as word: PWMResolution = 255
;dim PWMResolution as word: PWMResolution = 255
	setf	PWMRESOLUTION,BANKED
	clrf	PWMRESOLUTION_H,BANKED
;If HPWM_FAST operation selected, only recalculate timer prescaler when
;needed. Gives faster operation, but uses extra byte of RAM and may cause
;problems if HPWM and PWMOn are used together in a program.
;(No issues using HPWM and PWMOff in the same program with HPWM_FAST.)
;Tx_PR = 1
	movlw	1
	movwf	TX_PR,BANKED
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
	movf	PRX_TEMP_H,W,BANKED
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF177
;Tx_PR = 4
	movlw	4
	movwf	TX_PR,BANKED
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate PRx_Temp right
	rrcf	PRX_TEMP_E,F,BANKED
	rrcf	PRX_TEMP_U,F,BANKED
	rrcf	PRX_TEMP_H,F,BANKED
	rrcf	PRX_TEMP,F,BANKED
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate PRx_Temp right
	rrcf	PRX_TEMP_E,F,BANKED
	rrcf	PRX_TEMP_U,F,BANKED
	rrcf	PRX_TEMP_H,F,BANKED
	rrcf	PRX_TEMP,F,BANKED
;end if
ENDIF177
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W,BANKED
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF178
;Tx_PR = 16
	movlw	16
	movwf	TX_PR,BANKED
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate PRx_Temp right
	rrcf	PRX_TEMP_E,F,BANKED
	rrcf	PRX_TEMP_U,F,BANKED
	rrcf	PRX_TEMP_H,F,BANKED
	rrcf	PRX_TEMP,F,BANKED
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate PRx_Temp right
	rrcf	PRX_TEMP_E,F,BANKED
	rrcf	PRX_TEMP_U,F,BANKED
	rrcf	PRX_TEMP_H,F,BANKED
	rrcf	PRX_TEMP,F,BANKED
;end if
ENDIF178
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W,BANKED
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF179
;Tx_PR = 64
	movlw	64
	movwf	TX_PR,BANKED
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate PRx_Temp right
	rrcf	PRX_TEMP_E,F,BANKED
	rrcf	PRX_TEMP_U,F,BANKED
	rrcf	PRX_TEMP_H,F,BANKED
	rrcf	PRX_TEMP,F,BANKED
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate PRx_Temp right
	rrcf	PRX_TEMP_E,F,BANKED
	rrcf	PRX_TEMP_U,F,BANKED
	rrcf	PRX_TEMP_H,F,BANKED
	rrcf	PRX_TEMP,F,BANKED
;end if
ENDIF179
;
;HserPrint "2) PRx_Temp " + str(PRx_Temp)
;HserPrintCRLF
;HserPrint "Tx_PR " + str(Tx_PR)
;HserPrintCRLF
;
CCPPWMSETUPCLOCKSOURCE
;select case _PWMTimerSelected
;case 2:
SysSelect6Case1
	movlw	2
	banksel	_PWMTIMERSELECTED
	subwf	_PWMTIMERSELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd6
;PR2 = PRx_Temp
	movff	PRX_TEMP,PR2
;Set the Bits for the Prescaler
;Setup Timer2 by clearing the Prescaler bits - it is set next....
;SET T2CKPS0 OFF
	bcf	T2CON,T2CKPS0,ACCESS
;SET T2CKPS1 OFF
	bcf	T2CON,T2CKPS1,ACCESS
;SET T2CKPS2 OFF
	bcf	T2CON,T2CKPS2,ACCESS
;Set Prescaler bits T2CON@1
;if Tx_PR = 4  then SET T2CKPS1 ON
	movlw	4
	banksel	TX_PR
	subwf	TX_PR,W,BANKED
	btfsc	STATUS, Z,ACCESS
;if Tx_PR = 4  then SET T2CKPS1 ON
	bsf	T2CON,T2CKPS1,ACCESS
;if Tx_PR = 4  then SET T2CKPS1 ON
;if Tx_PR = 16 then SET T2CKPS2 ON
	movlw	16
	subwf	TX_PR,W,BANKED
	btfsc	STATUS, Z,ACCESS
;if Tx_PR = 16 then SET T2CKPS2 ON
	bsf	T2CON,T2CKPS2,ACCESS
;if Tx_PR = 16 then SET T2CKPS2 ON
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	movlw	64
	subwf	TX_PR,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF182
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	bsf	T2CON,T2CKPS2,ACCESS
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	bsf	T2CON,T2CKPS1,ACCESS
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
ENDIF182
;Set Clock Source, if required
;Set to FOSC/4 for backward compatibility@2a where CS<3:0> = 0001 = Fosc/4
;T2CLKCON.T2CS0 = 1
	bsf	T2CLKCON,T2CS0,ACCESS
;T2CLKCON.T2CS1 = 0
	bcf	T2CLKCON,T2CS1,ACCESS
;T2CLKCON.T2CS2 = 0
	bcf	T2CLKCON,T2CS2,ACCESS
;T2CLKCON.T2CS3 = 0
	bcf	T2CLKCON,T2CS3,ACCESS
;end Select
SysSelectEnd6
END_OF_CCPPWMSETUPCLOCKSOURCE
;this code can be optimised by using defines USE_HPWMCCP1|2|3|4|5
;and, you can define user setup and exit commands using AddHPWMCCPSetupN and  AddHPWMCCPExitN
;These can be used to FIX little errors!
SETUPTHECORRECTTIMERBITS
;ChipPWMTimerVariant some chips have variants on CCPTMRS0
;Dim TimerSelectionBits as Byte
;TimerSelectionBits =  (_PWMTimerSelected / 2 )
	bcf	STATUS,C,ACCESS
	banksel	_PWMTIMERSELECTED
	rrcf	_PWMTIMERSELECTED,W,BANKED
	banksel	TIMERSELECTIONBITS
	movwf	TIMERSELECTIONBITS,BANKED
SETUPCCPPWMREGISTERS
;If there is no ASM here then the CHIP is not recognised, look at section SETUPCCPPWMREGISTERS in PMW.H
;Only process this section when CCP1CON exists
CHIPFAMILYPWMCCP1CON16HANDLER
;Devices with more than one CCP
;if PWMChannel = 1 then
	decf	PWMCHANNEL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF183
;ifdef BIT(CCP1FMT) Testing this bit is to identify the 2016 chip that use CCPR1H and CCPR1L for PWM
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	call	CALCULATEDUTY
;CCPR1H = PRx_Temp_H
	movff	PRX_TEMP_H,CCPR1H
;CCPR1L = PRx_Temp
	movff	PRX_TEMP,CCPR1L
;SET CCP1M3 ON
	bsf	CCP1CON,CCP1MODE3,ACCESS
;SET CCP1M2 ON
	bsf	CCP1CON,CCP1MODE2,ACCESS
;SET CCP1M1 ON
	bsf	CCP1CON,CCP1MODE1,ACCESS
;SET CCP1M0 ON
	bsf	CCP1CON,CCP1MODE0,ACCESS
;SET CCP1EN ON
	bsf	CCP1CON,CCP1EN,ACCESS
;SET CCP1CON_EN ON
	bsf	CCP1CON,EN,ACCESS
;SET CCP1FMT ON
	bsf	CCP1CON,CCP1FMT,ACCESS
;C1TSEL0 = TimerSelectionBits.0
	bcf	CCPTMRS,C1TSEL0,ACCESS
	btfsc	TIMERSELECTIONBITS,0,BANKED
	bsf	CCPTMRS,C1TSEL0,ACCESS
;C1TSEL1 = TimerSelectionBits.1
	bcf	CCPTMRS,C1TSEL1,ACCESS
	btfsc	TIMERSELECTIONBITS,1,BANKED
	bsf	CCPTMRS,C1TSEL1,ACCESS
;end if
ENDIF183
	return

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (3195)
HSERPRINT384
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF284
;Write Data
;for SysPrintTemp = 1 to PrintLen
;Legacy method
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd20
SysForLoop20
	incf	SYSPRINTTEMP,F,BANKED
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND372
;next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop20
SysForLoopEnd20
;End If
ENDIF284
;CR
;All Usarts
;--------------------------
;Specific USARTs
;------------------
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (3269)
HSERPRINT386
;OutValueTemp = 0
	clrf	OUTVALUETEMP,ACCESS
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF287
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
	movwf	SERDATA,BANKED
	rcall	HSERSEND372
;End If
ENDIF287
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp1
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF288
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
	movwf	SERDATA,BANKED
	rcall	HSERSEND372
;End If
ENDIF288
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	bra	HSERSEND372
;CR

;********************************************************************************

;Source: usart.h (3403)
HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp15
	movf	SYSREPEATTEMP15,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd15
SysRepeatLoop15
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,BANKED
	rcall	HSERSEND372
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,BANKED
	rcall	HSERSEND372
;end Repeat
	decfsz	SysRepeatTemp15,F,BANKED
	bra	SysRepeatLoop15
SysRepeatLoopEnd15
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (1960)
HSERSEND372
HSERSENDUSART1HANDLER
;USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop11
	banksel	PIR3
	btfss	PIR3,TXIF,BANKED
	bra	SysWaitLoop11
;Wait until TRMT = 1
SysWaitLoop12
	btfss	TX1STA,TRMT,ACCESS
	bra	SysWaitLoop12
;TXREG = SerData
	movff	SERDATA,TX1REG
	banksel	0
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (1368)
I2CDISCOVERY
;
;This shows the I2C devices connected to the microcontroller.
;
;The display is shown on the serial terminal only.
;
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF96
;Define I2C settings
;Initialise I2C
;I2C pins need to be input for SSP module - this is not an option
;Dir HI2C_DATA In
	bsf	TRISC,4,ACCESS
;Dir HI2C_CLOCK In
	bsf	TRISC,3,ACCESS
;MASTER
;HI2CMode Master
	movlw	12
	movwf	HI2CCURRENTMODE,ACCESS
	rcall	HI2CMODE
;HserPrint Str(labNumber) + ": I2C Discovery"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable70
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable70
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable70
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	rcall	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Print "HW I2C Discovery"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable71
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable71
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable71
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print " See terminal"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable72
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable72
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable72
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*13
	call	PRINT157
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;Set up interrupt to exit this routine
;On Interrupt PortChange Call ButtonPressedISR
	banksel	PIE0
	bsf	PIE0,IOCIE,BANKED
;IOCAP = 0x10
	movlw	16
	banksel	IOCAP
	movwf	IOCAP,BANKED
;IOCAN = 0x10
	movlw	16
	movwf	IOCAN,BANKED
;end if
ENDIF96
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF97
;Now assumes Serial Terminal is operational
;Dim DeviceID As Byte
;Dim DISPLAYNEWLINE As Byte
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	rcall	HSERPRINTCRLF
;HSerPrint "Hardware I2C "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable73
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable73
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable73
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*13
	rcall	HSERPRINT384
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;Now assumes Serial Terminal is operational
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint "   "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable74
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable74
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable74
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*3
	rcall	HSERPRINT384
;Create a horizontal row of numbers
;For DeviceID = 0 To 15
;Legacy method
	setf	DEVICEID,ACCESS
SysForLoop2
	incf	DEVICEID,F,ACCESS
;HSerPrint Hex(deviceID)
	movff	DEVICEID,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT384
;HSerPrint " "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable19
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*1
	rcall	HSERPRINT384
;Next
	movlw	15
	subwf	DEVICEID,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;Create a vertical column of numbers
;For DeviceID = 0 To 255
;Legacy method
	setf	DEVICEID,ACCESS
SysForLoop3
	incf	DEVICEID,F,ACCESS
;DisplayNewLine = DeviceID % 16
	movff	DEVICEID,SysBYTETempA
	movlw	16
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempX,DISPLAYNEWLINE
;If DisplayNewLine = 0 Then
	movf	DISPLAYNEWLINE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF100
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint Hex(DeviceID)
	movff	DEVICEID,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT384
;If DisplayNewLine > 0 Then
	movf	DISPLAYNEWLINE,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF103
;HSerPrint " "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable19
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*1
	rcall	HSERPRINT384
;End If
ENDIF103
;End If
ENDIF100
;HSerPrint " "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable19
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*1
	rcall	HSERPRINT384
;Do an initial Start
;HI2CStart
	rcall	HI2CSTART
;If HI2CWaitMSSPTimeout <> TRUE Then
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ELSE101_1
;Send to address to device
;HI2CSend ( deviceID )
	movff	DEVICEID,I2CBYTE
	rcall	HI2CSEND
;Did device fail to respond?
;If HI2CAckpollState = FALSE Then
	movf	HI2CACKPOLLSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE104_1
;HI2CSend ( 0 )
	clrf	I2CBYTE,ACCESS
	rcall	HI2CSEND
;HSerPrint   Hex(deviceID)
	movff	DEVICEID,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT384
;Else
	bra	ENDIF104
ELSE104_1
;HSerPrint "--"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable75
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable75
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable75
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*2
	rcall	HSERPRINT384
;End If
ENDIF104
;Do a stop.
;HI2CStop
	rcall	HI2CSTOP
;Else
	bra	ENDIF101
ELSE101_1
;HSerPrint "! "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable76
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable76
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable76
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*2
	rcall	HSERPRINT384
;End If
ENDIF101
;Next
	movlw	255
	subwf	DEVICEID,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint   "End of Search"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable77
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable77
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable77
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*13
	rcall	HSERPRINT384
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;end if
ENDIF97
;if switchEvent = 1 Then
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (1570)
I2CEEPROM
;
;This shows how to read and write and validate that the external I2C EEPROM device is capable of storing data.
;
;This is uses the I2C bus.
;
;The demo writes a array to the external I2C EEPROM device, then, the array elements are set to a specific value, then
;the array is repopulated with the external I2C EEPROM device data - the array is then validated.
;
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF108
;Define I2C settings
;Initialise I2C
;I2C pins need to be input for SSP module - this is not an option
;Dir HI2C_DATA In
	bsf	TRISC,4,ACCESS
;Dir HI2C_CLOCK In
	bsf	TRISC,3,ACCESS
;MASTER
;HI2CMode Master
	movlw	12
	movwf	HI2CCURRENTMODE,ACCESS
	rcall	HI2CMODE
;HserPrint Str(labNumber) + ": I2C EEPROM"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable81
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable81
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable81
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	rcall	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;CLS
	call	CLS
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Print "I2C EEPROM"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable82
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable82
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable82
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*10
	call	PRINT157
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;----- Define Hardware settings
;You must check the 'eepDev' address 0x0A - 0xAF are typical.
;You must check the 'EEpromPageSize'. 16, 32 or 64 are typical.
;You must check the 'eepAddr' type. Byte or Word is valid. This is device specific.
;
;A 24LC16B uses 0x0A (thro to 0xAF), EEpromPageSize = 16 and eepAddr as Byte
;A 24LC256 uses 0x0A (thro to 0xAF), EEpromPageSize = 64 and eepAddr as Word
;----- Variables
;Dim XLOOP as Byte
;Dim eepAddr as Word               // Change this type Byte or Word.
;This IS EEPROM device specific. Smaller device with 16 byte page size are typically requird 'Dim eepAddr as byte'
;Large devices will required 'Dim eepAddr as word'
;Dim datarray( EEpromPageSize )
;Dim datastring as String * 16
;Dim dataerror as Bit
;dataerror = FALSE
	bcf	SYSBITVAR0,2,BANKED
;switchEvent = 0
	clrf	SWITCHEVENT,BANKED
;end if
ENDIF108
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF109
ARRAYOPS
;Write an Array
;Populate the initial array, the array is 10 elements long
;datarray = 1,2,3,4,5,6,7,8,9,10
	lfsr	0,DATARRAY
	movlw	10
	movwf	POSTINC0,ACCESS
	movlw	1
	movwf	POSTINC0,ACCESS
	movlw	2
	movwf	POSTINC0,ACCESS
	movlw	3
	movwf	POSTINC0,ACCESS
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	5
	movwf	POSTINC0,ACCESS
	movlw	6
	movwf	POSTINC0,ACCESS
	movlw	7
	movwf	POSTINC0,ACCESS
	movlw	8
	movwf	POSTINC0,ACCESS
	movlw	9
	movwf	POSTINC0,ACCESS
	movlw	10
	movwf	POSTINC0,ACCESS
;HSerPrint "    Initial Array"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable83
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable83
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable83
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*17
	rcall	HSERPRINT384
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint "        -:"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable84
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable84
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable84
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*10
	rcall	HSERPRINT384
;for xloop = 1 to 10
;Legacy method
	clrf	XLOOP,BANKED
SysForLoop4
	incf	XLOOP,F,BANKED
;HSerPrint datarray(xloop)
	lfsr	0,DATARRAY
	movf	XLOOP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT386
;if xloop < 10 then HSerPrint ","
	movlw	10
	subwf	XLOOP,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF111
;if xloop < 10 then HSerPrint ","
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable85
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable85
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable85
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*1
	rcall	HSERPRINT384
;if xloop < 10 then HSerPrint ","
ENDIF111
;next
	movlw	10
	subwf	XLOOP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;set EEProm start address for saving the array
;eepAddr = 0
	clrf	EEPADDR,ACCESS
	clrf	EEPADDR_H,ACCESS
;write array
;eeprom_wr_array( eepDev, EEpromPageSize, eepAddr , datarray(), 10 )
	movlw	160
	movwf	EEPDEV,ACCESS
	movlw	64
	movwf	EEPPAGESIZE,ACCESS
	movlw	low DATARRAY
	movwf	SysEEPARRAYHandler,BANKED
	movlw	high DATARRAY
	movwf	SysEEPARRAYHandler_H,BANKED
	movlw	10
	movwf	EEPLEN,ACCESS
	call	EEPROM_WR_ARRAY32
;populate the array with 127 as test to see if the operation populates correctly.
;HSerPrint "    Repopulate Array with #127 to ensure the EEPROM results are read correctly"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable86
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable86
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable86
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*78
	rcall	HSERPRINT384
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint "        -:"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable84
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable84
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable84
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*10
	rcall	HSERPRINT384
;for xloop = 1 to 10
;Legacy method
	clrf	XLOOP,BANKED
SysForLoop5
	incf	XLOOP,F,BANKED
;datarray(xloop) = 127
	lfsr	0,DATARRAY
	movf	XLOOP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	127
	movwf	INDF0,ACCESS
;HSerPrint datarray(xloop)
	lfsr	0,DATARRAY
	movf	XLOOP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT386
;if xloop < 10 then HSerPrint ","
	movlw	10
	subwf	XLOOP,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF113
;if xloop < 10 then HSerPrint ","
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable85
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable85
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable85
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*1
	rcall	HSERPRINT384
;if xloop < 10 then HSerPrint ","
ENDIF113
;next
	movlw	10
	subwf	XLOOP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;set EEProm start address for reading the array
;eepAddr = 0
	clrf	EEPADDR,ACCESS
	clrf	EEPADDR_H,ACCESS
;eeprom_rd_array( eepDev, eepAddr , datarray(), 10 )
	movlw	160
	movwf	EEPDEV,ACCESS
	movlw	low DATARRAY
	movwf	SysEEPARRAYHandler,BANKED
	movlw	high DATARRAY
	movwf	SysEEPARRAYHandler_H,BANKED
	movlw	10
	movwf	EEPLEN,ACCESS
	call	EEPROM_RD_ARRAY34
;HSerPrint "    Read Array from EEProm results"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable87
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable87
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable87
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*34
	rcall	HSERPRINT384
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint "        -:"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable84
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable84
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable84
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*10
	rcall	HSERPRINT384
;show results
;for xloop = 1 to 10
;Legacy method
	clrf	XLOOP,BANKED
SysForLoop6
	incf	XLOOP,F,BANKED
;HSerPrint datarray(xloop)
	lfsr	0,DATARRAY
	movf	XLOOP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT386
;If xloop < 10 then HSerPrint ","
	movlw	10
	subwf	XLOOP,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF115
;If xloop < 10 then HSerPrint ","
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable85
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable85
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable85
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*1
	rcall	HSERPRINT384
;If xloop < 10 then HSerPrint ","
ENDIF115
;If datarray(xloop) <> xloop Then
	lfsr	0,DATARRAY
	movf	XLOOP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movf	XLOOP,W,BANKED
	subwf	INDF0,W,ACCESS
	btfss	STATUS, Z,ACCESS
;dataerror = TRUE
	bsf	SYSBITVAR0,2,BANKED
;End if
;next
	movlw	10
	subwf	XLOOP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;HSerPrint "    End of array operations"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable88
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable88
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable88
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*27
	rcall	HSERPRINT384
;HSerPrintCRLF 3
	movlw	3
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;If dataerror = TRUE Then
	btfss	SYSBITVAR0,2,BANKED
	bra	ELSE118_1
;Print "EEPROM read error"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable89
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable89
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable89
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*17
	call	PRINT157
;Else
	bra	ENDIF118
ELSE118_1
;Print "EEPROM read OK"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable90
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable90
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable90
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*14
	call	PRINT157
;End If
ENDIF118
;checkButtonS2
	call	CHECKBUTTONS2
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;end if
ENDIF109
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (1481)
I2CTEMPERATURE
;This routine is called to get current temperature reading
;		from the TC74 on the PICDEM 2 Plus board and return the value
;		to the caller as 2 BCD nibbles.
;In temperature data registers, each unit value represents one degree (Celsius). The value is in 2’s
;complement binary format such that a reading of 0000
;0000b corresponds to 0°C.
;This routine only supports positive temperatures.  You would need to add a 2's compliment routine.
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF105
;Define I2C settings
;Initialise I2C
;I2C pins need to be input for SSP module - this is not an option
;Dir HI2C_DATA In
	bsf	TRISC,4,ACCESS
;Dir HI2C_CLOCK In
	bsf	TRISC,3,ACCESS
;MASTER
;HI2CMode Master
	movlw	12
	movwf	HI2CCURRENTMODE,ACCESS
	call	HI2CMODE
;HserPrint Str(labNumber) + ": I2C Temperature"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable78
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable78
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable78
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	rcall	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
;CLS
	call	CLS
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Print "Temperature"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable79
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable79
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable79
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*11
	call	PRINT157
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;Set up interrupt to exit this routine
;On Interrupt PortChange Call ButtonPressedISR
	banksel	PIE0
	bsf	PIE0,IOCIE,BANKED
;IOCAP = 0x10
	movlw	16
	banksel	IOCAP
	movwf	IOCAP,BANKED
;IOCAN = 0x10
	movlw	16
	movwf	IOCAN,BANKED
;Setup temperature sensor address
;Dim temperatureVal as Byte
;Create an array to store the character until it is copied
;Dim CharArray(8)
;Set the array to hold the character
;Binary has been used to improve the readability of the code, but is not essential
;CharArray(1) = b'00001100'
	movlw	12
	banksel	SYSCHARARRAY_1
	movwf	SYSCHARARRAY_1,BANKED
;CharArray(2) = b'00010010'
	movlw	18
	movwf	SYSCHARARRAY_2,BANKED
;CharArray(3) = b'00001100'
	movlw	12
	movwf	SYSCHARARRAY_3,BANKED
;CharArray(4) = b'00000000'
	clrf	SYSCHARARRAY_4,BANKED
;CharArray(5) = b'00000000'
	clrf	SYSCHARARRAY_5,BANKED
;CharArray(6) = b'00000000'
	clrf	SYSCHARARRAY_6,BANKED
;CharArray(7) = b'00000000'
	clrf	SYSCHARARRAY_7,BANKED
;CharArray(8) = b'00000000'
	clrf	SYSCHARARRAY_8,BANKED
;Copy the character from the array to the LCD
;LCDCreateChar 0, CharArray()
	clrf	LCDCHARLOC,ACCESS
	movlw	low CHARARRAY
	banksel	SYSLCDCHARDATAHANDLER
	movwf	SysLCDCHARDATAHandler,BANKED
	movlw	high CHARARRAY
	movwf	SysLCDCHARDATAHandler_H,BANKED
	call	LCDCREATECHAR
;end if
ENDIF105
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF106
;HI2CStart
	call	HI2CSTART
;HI2CSend I2CTEMPSENSOR
	movlw	154
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CSend 0                      // RTR 00h Read Temperature (TEMP)
	clrf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CReStart
	call	HI2CRESTART
;HI2CSend I2CTEMPSENSOR + 1
	movlw	155
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
;HI2CReceive ( temperatureVal, NACK )
	clrf	HI2CGETACK,ACCESS
	call	HI2CRECEIVE
	movff	I2CBYTE,TEMPERATUREVAL
;HI2CStop
	call	HI2CSTOP
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print temperatureVal
	movff	TEMPERATUREVAL,LCDVALUE
	call	PRINT158
;LCDWriteChar 0
	clrf	LCDCHAR,ACCESS
	call	LCDWRITECHAR
;Print "C"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable80
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable80
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable80
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*1
	call	PRINT157
;end if
ENDIF106
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF107
;On Interrupt PortChange Ignore
	banksel	PIE0
	bcf	PIE0,IOCIE,BANKED
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
ENDIF107
	banksel	0
	return

;********************************************************************************

;Source: lcd.h (584)
INITLCD
;`LCD_IO selected is ` LCD_IO
;`LCD_Speed is FAST`
;`OPTIMAL is set to ` OPTIMAL
;`LCD_Speed is set to ` LCD_Speed
;Wait 50 ms
	movlw	50
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Dir LCD_RW OUT
	bcf	TRISD,5,ACCESS
;Set LCD_RW OFF
	bcf	LATD,5,ACCESS
;Dir LCD_DB4 OUT
	bcf	TRISD,0,ACCESS
;Dir LCD_DB5 OUT
	bcf	TRISD,1,ACCESS
;Dir LCD_DB6 OUT
	bcf	TRISD,2,ACCESS
;Dir LCD_DB7 OUT
	bcf	TRISD,3,ACCESS
;Dir LCD_RS OUT
	bcf	TRISD,4,ACCESS
;Dir LCD_Enable OUT
	bcf	TRISD,6,ACCESS
;Set LCD_RS OFF
	bcf	LATD,4,ACCESS
;Set LCD_Enable OFF
	bcf	LATD,6,ACCESS
;Wakeup (0x30 - b'0011xxxx' )
;Set LCD_DB7 OFF
	bcf	LATD,3,ACCESS
;Set LCD_DB6 OFF
	bcf	LATD,2,ACCESS
;Set LCD_DB5 ON
	bsf	LATD,1,ACCESS
;Set LCD_DB4 ON
	bsf	LATD,0,ACCESS
;Wait 2 us
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS5
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS5
	nop
;PulseOut LCD_Enable, 2 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6,ACCESS
;WaitL1 Time
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS6
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS6
;Set Pin Off
	bcf	LATD,6,ACCESS
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Repeat 3
	movlw	3
	movwf	SysRepeatTemp13,BANKED
SysRepeatLoop13
;PulseOut LCD_Enable, 2 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6,ACCESS
;WaitL1 Time
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS7
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS7
;Set Pin Off
	bcf	LATD,6,ACCESS
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;End Repeat
	decfsz	SysRepeatTemp13,F,BANKED
	bra	SysRepeatLoop13
SysRepeatLoopEnd13
;Set 4 bit mode (0x20 - b'0010xxxx')
;Set LCD_DB7 OFF
	bcf	LATD,3,ACCESS
;Set LCD_DB6 OFF
	bcf	LATD,2,ACCESS
;Set LCD_DB5 ON
	bsf	LATD,1,ACCESS
;Set LCD_DB4 OFF
	bcf	LATD,0,ACCESS
;Wait 2 us
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS8
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS8
	nop
;PulseOut LCD_Enable, 2 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6,ACCESS
;WaitL1 Time
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS9
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS9
;Set Pin Off
	bcf	LATD,6,ACCESS
;Wait 100 us
	movlw	2
	movwf	DELAYTEMP2,ACCESS
DelayUSO10
	clrf	DELAYTEMP,ACCESS
DelayUS10
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS10
	decfsz	DELAYTEMP2,F,ACCESS
	bra	DelayUSO10
	movlw	19
	movwf	DELAYTEMP,ACCESS
DelayUS11
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS11
;===== now in 4 bit mode =====
;LCDWriteByte 0x28    '(b'00101000')  '0x28 set 2 line mode
	movlw	40
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
;LCDWriteByte 0x06    '(b'00000110')  'Set cursor movement
	movlw	6
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
;LCDWriteByte 0x0C    '(b'00001100')  'Turn off cursor
	movlw	12
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
;Cls  'Clear the display
	call	CLS
;LCD_State = 12
	movlw	12
	movwf	LCD_STATE,ACCESS
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (95)
INITPPS
;Module: CCP1
;See code inline for PPS
;Module: EUSART1
;RX1PPS = 0x17   //RC7->EUSART1:RX1
	movlw	23
	banksel	RX1PPS
	movwf	RX1PPS,BANKED
;RC6PPS = 0x09   //RC6->EUSART1:TX1
	movlw	9
	movwf	RC6PPS,BANKED
;Module: I2C
;SSP1CLKPPS = 0x13   //RC3->MSSP1:SCL1
	movlw	19
	movwf	SSP1CLKPPS,BANKED
;RC3PPS = 0x0F       //RC3->MSSP1:SCL1
	movlw	15
	movwf	RC3PPS,BANKED
;SSP1DATPPS = 0x14   //RC4->MSSP1:SDA1
	movlw	20
	movwf	SSP1DATPPS,BANKED
;RC4PPS = 0x10       //RC4->MSSP1:SDA1
	movlw	16
	movwf	RC4PPS,BANKED
	banksel	0
	return

;********************************************************************************

;Source: pwm.h (256)
INITPWM
;_PWMTimerSelected = 2
	movlw	2
	banksel	_PWMTIMERSELECTED
	movwf	_PWMTIMERSELECTED,BANKED
;Dim PRx_Temp as LONG
LEGACY_STARTOFFIXEDCCPPWMMODECODE
;DIM CCPCONCache as BYTE
;CCPCONCache = 0
	clrf	CCPCONCACHE,ACCESS
;Set PWM Period
;PR2 = PR2_CPP_PWM_Temp
	movlw	105
	movwf	PR2,ACCESS
;SET T2CON.T2CKPS0 OFF
	bcf	T2CON,T2CKPS0,ACCESS
;SET T2CON.T2CKPS1 ON
	bsf	T2CON,T2CKPS1,ACCESS
;SET T2CON.T2CKPS2 OFF
	bcf	T2CON,T2CKPS2,ACCESS
;Set Duty cycle
;CCPCONCache.CCP1FMT = 1
	bsf	CCPCONCACHE,CCP1FMT,ACCESS
;CCPR1H = DutyCycleH
	movlw	53
	movwf	CCPR1H,ACCESS
;CCPR1L = DutyCycleL*64
	clrf	CCPR1L,ACCESS
;[canskip]T2CLKCON = 1
	movlw	1
	movwf	T2CLKCON,ACCESS
;[canskip]CCPCONCache.en = 1
	bsf	CCPCONCACHE,EN,ACCESS
;CCPCONCache.CCP1M3, CCPCONCache.CCP1M2, CCPCONCache.CCP1M1, CCPCONCache.CCP1M0 = b'1100'
	bsf	CCPCONCACHE,CCP1MODE3,ACCESS
	bsf	CCPCONCACHE,CCP1MODE2,ACCESS
	bcf	CCPCONCACHE,CCP1MODE1,ACCESS
	bcf	CCPCONCACHE,CCP1MODE0,ACCESS
;Enable Timer 2
;SET T2CON.TMR2ON ON
	bsf	T2CON,TMR2ON,ACCESS
STARTOFFIXEDPWMMODECODE
SETPWMDUTYCODE
	banksel	0
	return

;********************************************************************************

;Source: random.h (35)
INITRANDOM
;Dim RandomSeed As Word
;RandomSeed = RandStart
	movlw	214
	movwf	RANDOMSEED,BANKED
	movlw	124
	movwf	RANDOMSEED_H,BANKED
	return

;********************************************************************************

;Source: songplay.h (39)
INITSOUNDPLAY
;Default octave and note length
;SoundPlayOctave = 4
	movlw	4
	movwf	SOUNDPLAYOCTAVE,BANKED
;SoundPlayLength = 4
	movlw	4
	movwf	SOUNDPLAYLENGTH,BANKED
;SoundPlayTempo = 120
	movlw	120
	movwf	SOUNDPLAYTEMPO,BANKED
;SoundPlayDots = 0
	clrf	SOUNDPLAYDOTS,BANKED
;SoundPlayCommand = SOUND_CMD_NONE
	clrf	SOUNDPLAYCOMMAND,BANKED
;Set pin direction
;Dir SOUNDOUT Out
	bcf	TRISC,2,ACCESS
	return

;********************************************************************************

;Source: system.h (189)
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
	bcf	ADCON0,ADFM,BANKED
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,BANKED
;ANSELA = 0
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

;Overloaded signature: BYTE:BYTE:BYTE:, Source: timer.h (1508)
INITTIMER0230
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
	andwf	T0CON1,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	TMRPRES,F,BANKED
;Set the Source bit
;IF TMRSource <> OSC  THEN
	decf	TMRSOURCE,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE244_1
;SET TMRPost.5 ON
	bsf	TMRPOST,5,BANKED
;ELSE
	bra	ENDIF244
ELSE244_1
;SET TMRPost.5 OFF
	bcf	TMRPOST,5,BANKED
;END IF
ENDIF244
;Write the TOCON register
;T0CON1 = TMRPres
	movff	TMRPRES,T0CON1
;Assumed for code below Timer0 is 16-bit capable
;Set Postscaler
;Re-Use TMRPost as T0CON0 Temp register
;Keep T0CON0 7:5  and write bits 5:0 to register
;Bits therefore will be cleared!
;TMRPost = (T0CON0 And 224) OR TMRPost
	movlw	224
	andwf	T0CON0,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	TMRPOST,F,BANKED
;Set TO16BIT
;Set TMRPost.4 OFF '8-bit Timer0
	bcf	TMRPOST,4,BANKED
;Write the TOCON register
;T0CON0 = TMRPost
	movff	TMRPOST,T0CON0
	return

;********************************************************************************

;Source: timer.h (1765)
INITTIMER1
;Asummptions
;- Pwr On Reset State of TxCON for 1/3/5/7 is "0"
;- TXCON Timer REGISTER for 1/3/5/7 are NOT the Same on ALL PICS
;- TMRON is Bit0 on all Chips
;- OSCEN & SOSCEN are always TxCON.3 and perform the same function
;but, of course, see Datasheet for Detailed Register Information
;Handle PICs with Timer1 module have T1CON register
;33 Newer Chips have TxCLK Register ( TIMER 1/3/5/7 )
;
;12/16F16xx   Series
;16F153xx     Series
;16F188xx     Series
;18F1xxK40    series
;If TMRPres <> 0 then
	movf	TMRPRES,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF245
;IF TMRPres <> 16 then
	movlw	16
	subwf	TMRPRES,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF248
;IF TMRPres <> 32 then
	movlw	32
	subwf	TMRPRES,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF249
;IF TMRPres <> 48 then
	movlw	48
	subwf	TMRPRES,W,BANKED
	btfss	STATUS, Z,ACCESS
;TMRPres = 0
	clrf	TMRPRES,BANKED
;END IF
;END IF
ENDIF249
;END IF
ENDIF248
;END IF
ENDIF245
;IF TMR1ON = 1 then Set TMRPres.0 ON  'The timer running/ Dont Stop !
	btfsc	T1CON,TMR1ON,ACCESS
;IF TMR1ON = 1 then Set TMRPres.0 ON  'The timer running/ Dont Stop !
	bsf	TMRPRES,0,BANKED
;IF TMR1ON = 1 then Set TMRPres.0 ON  'The timer running/ Dont Stop !
;IF TMRSource > 15 OR TMRSource <0 then TRMSource = 0  'failsafe
	movff	TMRSOURCE,SysBYTETempB
	movlw	15
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp1
	movff	TMRSOURCE,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	movf	SysTemp1,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfsc	SysTemp2,0,BANKED
;IF TMRSource > 15 OR TMRSource <0 then TRMSource = 0  'failsafe
	clrf	TRMSOURCE,BANKED
;IF TMRSource > 15 OR TMRSource <0 then TRMSource = 0  'failsafe
;T1CLK = TMRSource
	movff	TMRSOURCE,T1CLK
;T1CON = TMRPres
	movff	TMRPRES,T1CON
	return

;********************************************************************************

;Source: usart.h (1177)
INITUSART
;Set the default value for USART handler - required when more than one USART
;comport = SCRIPT_DEFAULT_COMPORT
	movlw	1
	movwf	COMPORT,ACCESS
;PIC USART 1 Init
;Set baud rate
;SPBRG1 = SPBRGL_TEMP
	movlw	129
	movwf	SPBRG1,ACCESS
;SPBRGH1 = SPBRGH_TEMP
	movlw	6
	movwf	SPBRGH1,ACCESS
;BAUDCON1.BRG16 = BRG16_TEMP
	bsf	BAUDCON1,BRG16,ACCESS
;TX1STA.BRGH = BRGH_TEMP
	bsf	TX1STA,BRGH,ACCESS
;Enable async mode
;Set SYNC1 Off
	bcf	TX1STA,SYNC_TX1STA,ACCESS
;Set SPEN1 On
	bsf	RC1STA,SPEN,ACCESS
;Enable Continuous Receive and Transmit Enable bit
;Set CREN1 On
	bsf	RC1STA,CREN,ACCESS
;Set TXEN1 On
	bsf	TX1STA,TXEN,ACCESS
	return

;********************************************************************************

INTERRUPT
;Save Context
	movff	WREG,SysW
	movff	STATUS,SysSTATUS
	movff	BSR,SysBSR
;Store system variables
	movff	SysByteTempX,SaveSysByteTempX
	movff	SysTemp1,SaveSysTemp1
	movff	SysByteTempA,SaveSysByteTempA
	movff	SysByteTempB,SaveSysByteTempB
	movff	SysTemp2,SaveSysTemp2
	movff	FSR1L,SaveFSR1L
	movff	FSR1H,SaveFSR1H
	movff	SysStringLength,SaveSysStringLength
	movff	SysDivLoop,SaveSysDivLoop
	movff	FSR0L,SaveFSR0L
	movff	FSR0H,SaveFSR0H
	movff	SysLongTempA_U,SaveSysLongTempA_U
	movff	SysLongTempA_E,SaveSysLongTempA_E
	movff	SysLongTempB_H,SaveSysLongTempB_H
	movff	SysLongTempB_U,SaveSysLongTempB_U
	movff	SysLongTempB_E,SaveSysLongTempB_E
	movff	SysLongTempX_H,SaveSysLongTempX_H
	movff	SysLongTempX_U,SaveSysLongTempX_U
	movff	SysLongTempX_E,SaveSysLongTempX_E
	movff	SysTemp2_H,SaveSysTemp2_H
	movff	NVMCON1,SaveNVMCON1
	movff	NVMADRU,SaveNVMADRU
	movff	NVMADRH,SaveNVMADRH
	movff	NVMADRL,SaveNVMADRL
;On Interrupt handlers
	banksel	PIE0
	btfss	PIE0,TMR0IE,BANKED
	bra	NotTMR0IF
	btfss	PIR0,TMR0IF,BANKED
	bra	NotTMR0IF
	banksel	0
	rcall	LAB_TIMER0_ISR
	banksel	PIR0
	bcf	PIR0,TMR0IF,BANKED
	bra	INTERRUPTDONE
NotTMR0IF
	btfss	PIE4,TMR1IE,BANKED
	bra	NotTMR1IF
	btfss	PIR4,TMR1IF,BANKED
	bra	NotTMR1IF
	banksel	0
	call	MEMORY_ISR
	banksel	PIR4
	bcf	PIR4,TMR1IF,BANKED
	bra	INTERRUPTDONE
NotTMR1IF
	btfss	PIE0,IOCIE,BANKED
	bra	NotIOCIF
	btfss	PIR0,IOCIF,BANKED
	bra	NotIOCIF
	banksel	0
	call	BUTTONPRESSEDISR
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
	movff	SaveSysByteTempA,SysByteTempA
	movff	SaveSysByteTempB,SysByteTempB
	movff	SaveSysTemp2,SysTemp2
	movff	SaveFSR1L,FSR1L
	movff	SaveFSR1H,FSR1H
	movff	SaveSysStringLength,SysStringLength
	movff	SaveSysDivLoop,SysDivLoop
	movff	SaveFSR0L,FSR0L
	movff	SaveFSR0H,FSR0H
	movff	SaveSysLongTempA_U,SysLongTempA_U
	movff	SaveSysLongTempA_E,SysLongTempA_E
	movff	SaveSysLongTempB_H,SysLongTempB_H
	movff	SaveSysLongTempB_U,SysLongTempB_U
	movff	SaveSysLongTempB_E,SysLongTempB_E
	movff	SaveSysLongTempX_H,SysLongTempX_H
	movff	SaveSysLongTempX_U,SysLongTempX_U
	movff	SaveSysLongTempX_E,SysLongTempX_E
	movff	SaveSysTemp2_H,SysTemp2_H
	movff	SaveNVMCON1,NVMCON1
	movff	SaveNVMADRU,NVMADRU
	movff	SaveNVMADRH,NVMADRH
	movff	SaveNVMADRL,NVMADRL
	movff	SysW,WREG
	movff	SysSTATUS,STATUS
	movff	SysBSR,BSR
	retfie	0
	banksel	0

;********************************************************************************

;Source: 20_Capability_demo.gcb (802)
INTERRUPTS
;
;Light on LEDs D2, D3, D4 and D5 rotate at a constant speed and pressing switch S3 reverses the
;direction of rotation. The LCD displays “Interrupt” on the first line and “Direction = x” on the second
;line, where x can either be “Left” or “Right” depending upon the direction of rotation.
;
;Dim LEDState
;Dim rotateDirection as Bit
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF44
;HserPrint Str(labNumber) + ": Interrupt Lab"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable34
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable34
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable34
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Begin with D4 high
;PORTB = PORTB AND 0xF1
	movlw	241
	andwf	PORTB,F,ACCESS
;LED_D4 = 1
	bsf	LATB,2,ACCESS
;activeLedNum = 2
	movlw	2
	movwf	ACTIVELEDNUM,ACCESS
;rotateDirection = RIGHTDIRECTION
	bsf	SYSBITVAR0,1,BANKED
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "   Interrupt    "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable35
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable35
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable35
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "Direction: Right"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable36
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable36
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable36
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;Set up interrupt handlers
;On Interrupt Timer0Overflow Call Lab_Timer0_ISR
	banksel	PIE0
	bsf	PIE0,TMR0IE,BANKED
;Set up the timer.  This required PreScaler and PostScaler.  See the HELP for explaination.
;InitTimer0 Osc, PRE0_4096 + TMR0_FOSC4 ,  POST0_1
	movlw	1
	banksel	TMRSOURCE
	movwf	TMRSOURCE,BANKED
	movlw	76
	movwf	TMRPRES,BANKED
	clrf	TMRPOST,BANKED
	rcall	INITTIMER0230
;StartTimer 0
	clrf	TMRNUMBER,BANKED
	call	STARTTIMER
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;end if
ENDIF44
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF45
;if checkButtonS3 = 0 Then
	call	FN_CHECKBUTTONS3
	btfsc	SYSBITVAR0,4,BANKED
	bra	ENDIF47
;Change direction
;rotateDirection = !rotateDirection
	clrf	SysTemp1,BANKED
	btfsc	SYSBITVAR0,1,BANKED
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	SYSBITVAR0,1,BANKED
	btfsc	SysTemp1,0,BANKED
	bsf	SYSBITVAR0,1,BANKED
;if rotateDirection = RIGHTDIRECTION then
	btfss	SYSBITVAR0,1,BANKED
	bra	ELSE48_1
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "Direction: Right"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable36
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable36
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable36
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;else
	bra	ENDIF48
ELSE48_1
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "Direction: Left "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable37
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable37
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable37
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;end if
ENDIF48
;StopTimer 0
	clrf	TMRNUMBER,BANKED
	call	STOPTIMER
;LED_D3 = 0
	bcf	LATB,1,ACCESS
;LED_D4 = 0
	bcf	LATB,2,ACCESS
;LED_D5 = 0
	bcf	LATB,3,ACCESS
;wait while checkButtonS3 = 0
SysWaitLoop2
	call	FN_CHECKBUTTONS3
	btfss	SYSBITVAR0,4,BANKED
	bra	SysWaitLoop2
;StartTimer 0
	clrf	TMRNUMBER,BANKED
	call	STARTTIMER
;end If
ENDIF47
;end if
ENDIF45
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF46
;On Interrupt Timer0Overflow Ignore
	banksel	PIE0
	bcf	PIE0,TMR0IE,BANKED
;StopTimer 0
	banksel	TMRNUMBER
	clrf	TMRNUMBER,BANKED
	call	STOPTIMER
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
ENDIF46
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (873)
LAB_TIMER0_ISR
;
;Supporting ISR routine, see the assiociated lab
;
;if rotateDirection = RIGHTDIRECTION Then
	btfss	SYSBITVAR0,1,BANKED
	bra	ELSE51_1
;LED_D3 = !LED_D3
	clrf	SysTemp1,BANKED
	btfsc	PORTB,1,ACCESS
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	LATB,1,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,1,ACCESS
;else
	bra	ENDIF51
ELSE51_1
;LED_D5 = !LED_D5
	clrf	SysTemp1,BANKED
	btfsc	PORTB,3,ACCESS
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	LATB,3,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,3,ACCESS
;End If
ENDIF51
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (1112)
LCD
;
;This shows the GCBASIC capabilities of using the LCD.
;
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF76
;CLS
	call	CLS
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Print "     LCD        "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable51
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable51
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable51
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;HserPrint Str(labNumber) + ": LCD Lab"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable52
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable52
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable52
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Set up interrupt to exit this routine
;On Interrupt PortChange Call ButtonPressedISR
	banksel	PIE0
	bsf	PIE0,IOCIE,BANKED
;IOCAP = 0x10
	movlw	16
	banksel	IOCAP
	movwf	IOCAP,BANKED
;IOCAN = 0x10
	movlw	16
	movwf	IOCAN,BANKED
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;end if
ENDIF76
;Do while labState = RUNNING
SysDoLoop_S2
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
;CLS
	banksel	0
	call	CLS
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Do
	bra	SysDoLoop_E2
;End If
;PRINT "START TEST"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable53
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable53
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable53
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*10
	call	PRINT157
;locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;PRINT "DISPLAY ON"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable54
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable54
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable54
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*10
	call	PRINT157
;wait 3 s
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Do
	bra	SysDoLoop_E2
;End If
;CLS
	call	CLS
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "Cursor ON"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable55
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable55
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable55
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*9
	call	PRINT157
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;LCDcursor CursorOn
	movlw	10
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Do
	bra	SysDoLoop_E2
;End If
;wait 3 S
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;CLS
	call	CLS
;LCDcursor CursorOFF
	movlw	13
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
;locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "Cursor OFF"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable56
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable56
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable56
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*10
	call	PRINT157
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Do
	bra	SysDoLoop_E2
;End If
;wait 3 s
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;CLS
	call	CLS
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "FLASH ON"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable57
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable57
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable57
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*8
	call	PRINT157
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;LCDcursor FLASHON
	movlw	9
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Do
	bra	SysDoLoop_E2
;End If
;wait 3 s
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;CLS
	call	CLS
;locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "FLASH OFF"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable58
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*9
	call	PRINT157
;LCDCURSOR FLASHOFF
	movlw	14
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Do
	bra	SysDoLoop_E2
;End If
;wait 3 s
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "CURSR & FLSH ON"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable59
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*15
	call	PRINT157
;locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;LCDCURSOR CURSORON
	movlw	10
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
;LCDCURSOR FLASHON
	movlw	9
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Do
	bra	SysDoLoop_E2
;End If
;Wait 3 sec
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "CURSR & FLSH OFF"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable60
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;LCDCURSOR CursorOFF
	movlw	13
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
;LCDCURSOR FLASHOFF
	movlw	14
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Do
	bra	SysDoLoop_E2
;End If
;Wait 3 sec
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;CLS
	call	CLS
;Locate 0,4
	clrf	LCDLINE,ACCESS
	movlw	4
	movwf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;PRINT "Flashing"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable61
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*8
	call	PRINT157
;Locate 1,4
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	4
	movwf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "Display"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable62
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*7
	call	PRINT157
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;repeat 10
	movlw	10
	movwf	SysRepeatTemp4,BANKED
SysRepeatLoop4
;LCDCURSOR LCDOFF
	movlw	11
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;LCDCURSOR LCDON
	movlw	12
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Do
	bra	SysDoLoop_E2
;End If
;end repeat
	decfsz	SysRepeatTemp4,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
;CLS
	call	CLS
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "DISPLAY OFF"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable63
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable63
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable63
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*11
	call	PRINT157
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "FOR 5 SEC"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable64
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable64
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable64
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*9
	call	PRINT157
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Do
	bra	SysDoLoop_E2
;End If
;LCDCURSOR LCDOFF
	movlw	11
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Do
	bra	SysDoLoop_E2
;End If
;WAIT 5 s
	movlw	5
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;CLS
	call	CLS
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;LCDCURSOR LCDON
	movlw	12
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
;Print "END TEST"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable65
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable65
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable65
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*8
	call	PRINT157
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Do
	bra	SysDoLoop_E2
;End If
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;Loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;if switchEvent = 1 Then
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
	return

;********************************************************************************

;Source: lcd.h (1677)
LCDCREATECHAR
;Sub a create a custom character in CGRAM
;Store old location
;Set LCD_RS Off
	bcf	LATD,4,ACCESS
;LCDLoc = LCDReadByte
	rcall	FN_LCDNORMALREADBYTE
	movff	LCDNORMALREADBYTE,LCDLOC
;Set LCDLoc.7 On
	bsf	LCDLOC,7,ACCESS
;Select location
;Set LCD_RS Off
	bcf	LATD,4,ACCESS
;LCDWriteByte (64 + LCDCharLoc * 8)
	movf	LCDCHARLOC,W,ACCESS
	mullw	8
	movlw	64
	addwf	PRODL,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	call	Delay_10US
;Write char
;Set LCD_RS On
	bsf	LATD,4,ACCESS
;For LCDTemp = 1 to 8
;Legacy method
	clrf	LCDTEMP,ACCESS
SysForLoop12
	incf	LCDTEMP,F,ACCESS
;LCDWriteByte LCDCharData(LCDTemp)
	movf	LCDTEMP,W,ACCESS
	addwf	SysLCDCHARDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysLCDCHARDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,LCDBYTE
	rcall	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	call	Delay_10US
;Next
	movlw	8
	subwf	LCDTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop12
SysForLoopEnd12
;Restore location
;Set LCD_RS Off
	bcf	LATD,4,ACCESS
;LCDWriteByte (LCDLoc)
	movff	LCDLOC,LCDBYTE
	rcall	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	goto	Delay_10US

;********************************************************************************

;Source: lcd.h (1654)
LCDCURSOR
;Sub  to set cursor style
;Set LCD_RS OFF
	bcf	LATD,4,ACCESS
;If LCDCRSR = ON  Then LCDTemp = LCD_State OR LCDON
	decf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF213
;If LCDCRSR = ON  Then LCDTemp = LCD_State OR LCDON
	movlw	12
	iorwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
;If LCDCRSR = ON  Then LCDTemp = LCD_State OR LCDON
ENDIF213
;IF LCDCRSR = LCDON Then LCDTemp = LCD_State OR LCDON
	movlw	12
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF214
;IF LCDCRSR = LCDON Then LCDTemp = LCD_State OR LCDON
	movlw	12
	iorwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
;IF LCDCRSR = LCDON Then LCDTemp = LCD_State OR LCDON
ENDIF214
;If LCDCRSR = OFF Then LCDTemp = LCD_State AND LCDOFF
	movf	LCDCRSR,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF215
;If LCDCRSR = OFF Then LCDTemp = LCD_State AND LCDOFF
	movlw	11
	andwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
;If LCDCRSR = OFF Then LCDTemp = LCD_State AND LCDOFF
ENDIF215
;If LCDCRSR = LCDOFF Then LCDTemp = LCD_State AND LCDOFF
	movlw	11
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF216
;If LCDCRSR = LCDOFF Then LCDTemp = LCD_State AND LCDOFF
	movlw	11
	andwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
;If LCDCRSR = LCDOFF Then LCDTemp = LCD_State AND LCDOFF
ENDIF216
;If LCDCRSR = CursorOn Then LCDTemp = LCD_State OR CursorON
	movlw	10
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF217
;If LCDCRSR = CursorOn Then LCDTemp = LCD_State OR CursorON
	movlw	10
	iorwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
;If LCDCRSR = CursorOn Then LCDTemp = LCD_State OR CursorON
ENDIF217
;If LCDCRSR = CursorOFF then LCDTemp = LCD_State and CursorOFF
	movlw	13
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF218
;If LCDCRSR = CursorOFF then LCDTemp = LCD_State and CursorOFF
	movlw	13
	andwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
;If LCDCRSR = CursorOFF then LCDTemp = LCD_State and CursorOFF
ENDIF218
;If LCDCRSR = FLASH  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF219
;If LCDCRSR = FLASH  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	iorwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
;If LCDCRSR = FLASH  Then LCDTemp = LCD_State OR FLASHON
ENDIF219
;If LCDCRSR = FLASHON  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF220
;If LCDCRSR = FLASHON  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	iorwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
;If LCDCRSR = FLASHON  Then LCDTemp = LCD_State OR FLASHON
ENDIF220
;If LCDCRSR = FLASHOFF then LCDTemp = LCD_State and FLASHOFF
	movlw	14
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF221
;If LCDCRSR = FLASHOFF then LCDTemp = LCD_State and FLASHOFF
	movlw	14
	andwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
;If LCDCRSR = FLASHOFF then LCDTemp = LCD_State and FLASHOFF
ENDIF221
;LCDWriteByte(LCDTemp)
	movff	LCDTEMP,LCDBYTE
	rcall	LCDNORMALWRITEBYTE
;save last state
;LCD_State = LCDtemp
	movff	LCDTEMP,LCD_STATE
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (82)
LCDINITOM16214
;Turn the power on to the LCD and wait 40 ms. This is a hardware requirement.
;DIR     LCD_PWR OUT
	bcf	TRISD,7,ACCESS
;LCD_PWR = 1
	bsf	LATD,7,ACCESS
;wait 40 ms
	movlw	40
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Call the PPS routine
;InitPPS
	goto	INITPPS

;********************************************************************************

;Source: lcd.h (1602)
FN_LCDNORMALREADBYTE
;set LCD_RW ON 'Read mode
	bsf	LATD,5,ACCESS
;LCDReadByte = 0
	clrf	LCDNORMALREADBYTE,ACCESS
;Set pins to input
;DIR LCD_DB4 IN
	bsf	TRISD,0,ACCESS
;DIR LCD_DB5 IN
	bsf	TRISD,1,ACCESS
;DIR LCD_DB6 IN
	bsf	TRISD,2,ACCESS
;DIR LCD_DB7 IN
	bsf	TRISD,3,ACCESS
;Read upper nibble from input pins
;SET LCD_Enable ON
	bsf	LATD,6,ACCESS
;Wait LCD_Write_Delay     '2 us
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS23
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS23
	nop
;if LCD_DB7 ON then SET LCDReadByte.7 ON
	btfsc	PORTD,3,ACCESS
;if LCD_DB7 ON then SET LCDReadByte.7 ON
	bsf	LCDNORMALREADBYTE,7,ACCESS
;if LCD_DB7 ON then SET LCDReadByte.7 ON
;if LCD_DB6 ON THEN SET LCDReadByte.6 ON
	btfsc	PORTD,2,ACCESS
;if LCD_DB6 ON THEN SET LCDReadByte.6 ON
	bsf	LCDNORMALREADBYTE,6,ACCESS
;if LCD_DB6 ON THEN SET LCDReadByte.6 ON
;if LCD_DB5 ON then SET LCDReadByte.5 ON
	btfsc	PORTD,1,ACCESS
;if LCD_DB5 ON then SET LCDReadByte.5 ON
	bsf	LCDNORMALREADBYTE,5,ACCESS
;if LCD_DB5 ON then SET LCDReadByte.5 ON
;if LCD_DB4 ON THEN SET LCDReadByte.4 ON
	btfsc	PORTD,0,ACCESS
;if LCD_DB4 ON THEN SET LCDReadByte.4 ON
	bsf	LCDNORMALREADBYTE,4,ACCESS
;if LCD_DB4 ON THEN SET LCDReadByte.4 ON
;SET LCD_Enable OFF
	bcf	LATD,6,ACCESS
;Wait 5 us
	movlw	26
	movwf	DELAYTEMP,ACCESS
DelayUS24
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS24
	nop
;Read lower nibble from input pins
;SET LCD_Enable ON
	bsf	LATD,6,ACCESS
;Wait LCD_Write_Delay
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS25
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS25
	nop
;if LCD_DB7 ON then SET LCDReadByte.3 ON
	btfsc	PORTD,3,ACCESS
;if LCD_DB7 ON then SET LCDReadByte.3 ON
	bsf	LCDNORMALREADBYTE,3,ACCESS
;if LCD_DB7 ON then SET LCDReadByte.3 ON
;if LCD_DB6 ON THEN SET LCDReadByte.2 ON
	btfsc	PORTD,2,ACCESS
;if LCD_DB6 ON THEN SET LCDReadByte.2 ON
	bsf	LCDNORMALREADBYTE,2,ACCESS
;if LCD_DB6 ON THEN SET LCDReadByte.2 ON
;if LCD_DB5 ON then SET LCDReadByte.1 ON
	btfsc	PORTD,1,ACCESS
;if LCD_DB5 ON then SET LCDReadByte.1 ON
	bsf	LCDNORMALREADBYTE,1,ACCESS
;if LCD_DB5 ON then SET LCDReadByte.1 ON
;if LCD_DB4 ON THEN SET LCDReadByte.0 ON
	btfsc	PORTD,0,ACCESS
;if LCD_DB4 ON THEN SET LCDReadByte.0 ON
	bsf	LCDNORMALREADBYTE,0,ACCESS
;if LCD_DB4 ON THEN SET LCDReadByte.0 ON
;SET LCD_Enable OFF
	bcf	LATD,6,ACCESS
;Wait 5 us
	movlw	26
	movwf	DELAYTEMP,ACCESS
DelayUS26
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS26
	nop
	return

;********************************************************************************

;Source: lcd.h (1160)
LCDNORMALWRITEBYTE
;Sub to write a byte to the LCD
;CheckBusyFlag         'WaitForReady
	call	CHECKBUSYFLAG
;set LCD_RW OFF
	bcf	LATD,5,ACCESS
;Dim Temp as Byte
;Pins must be outputs if returning from WaitForReady, or after LCDReadByte or GET subs
;DIR LCD_DB4 OUT
	bcf	TRISD,0,ACCESS
;DIR LCD_DB5 OUT
	bcf	TRISD,1,ACCESS
;DIR LCD_DB6 OUT
	bcf	TRISD,2,ACCESS
;DIR LCD_DB7 OUT
	bcf	TRISD,3,ACCESS
;Write upper nibble to output pins
;set LCD_DB4 OFF
;set LCD_DB5 OFF
;set LCD_DB6 OFF
;set LCD_DB7 OFF
;if LCDByte.7 ON THEN SET LCD_DB7 ON
;if LCDByte.6 ON THEN SET LCD_DB6 ON
;if LCDByte.5 ON THEN SET LCD_DB5 ON
;if LCDByte.4 ON THEN SET LCD_DB4 ON
;LCD_DB7 = LCDByte.7
	bcf	LATD,3,ACCESS
	btfsc	LCDBYTE,7,ACCESS
	bsf	LATD,3,ACCESS
;LCD_DB6 = LCDByte.6
	bcf	LATD,2,ACCESS
	btfsc	LCDBYTE,6,ACCESS
	bsf	LATD,2,ACCESS
;LCD_DB5 = LCDByte.5
	bcf	LATD,1,ACCESS
	btfsc	LCDBYTE,5,ACCESS
	bsf	LATD,1,ACCESS
;LCD_DB4 = LCDByte.4
	bcf	LATD,0,ACCESS
	btfsc	LCDBYTE,4,ACCESS
	bsf	LATD,0,ACCESS
;Wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS12
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS12
;PulseOut LCD_enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6,ACCESS
;WaitL1 Time
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS13
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS13
;Set Pin Off
	bcf	LATD,6,ACCESS
;All data pins low
;set LCD_DB4 OFF
;set LCD_DB5 OFF
;set LCD_DB6 OFF
;set LCD_DB7 OFF
	bcf	LATD,3,ACCESS
;
;'Write lower nibble to output pins
;if LCDByte.3 ON THEN SET LCD_DB7 ON
	btfsc	LCDBYTE,3,ACCESS
;if LCDByte.3 ON THEN SET LCD_DB7 ON
	bsf	LATD,3,ACCESS
;if LCDByte.3 ON THEN SET LCD_DB7 ON
;if LCDByte.2 ON THEN SET LCD_DB6 ON
;if LCDByte.1 ON THEN SET LCD_DB5 ON
;if LCDByte.0 ON THEN SET LCD_DB4 ON
;LCD_DB7 = LCDByte.3
;LCD_DB6 = LCDByte.2
	bcf	LATD,2,ACCESS
	btfsc	LCDBYTE,2,ACCESS
	bsf	LATD,2,ACCESS
;LCD_DB5 = LCDByte.1
	bcf	LATD,1,ACCESS
	btfsc	LCDBYTE,1,ACCESS
	bsf	LATD,1,ACCESS
;LCD_DB4 = LCDByte.0
	bcf	LATD,0,ACCESS
	btfsc	LCDBYTE,0,ACCESS
	bsf	LATD,0,ACCESS
;Wait 1 us
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS14
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS14
;PulseOut LCD_enable, 1 us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATD,6,ACCESS
;WaitL1 Time
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS15
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS15
;Set Pin Off
	bcf	LATD,6,ACCESS
;Set data pins low again
;SET LCD_DB7 OFF
;SET LCD_DB6 OFF
;SET LCD_DB5 OFF
;SET LCD_DB4 OFF
;Wait SCRIPT_LCD_POSTWRITEDELAY
	movlw	213
	movwf	DELAYTEMP,ACCESS
DelayUS16
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS16
;If Register Select is low
;IF LCD_RS = 0 then
	btfsc	PORTD,4,ACCESS
	bra	ENDIF203
;IF LCDByte < 16 then
	movlw	16
	subwf	LCDBYTE,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF204
;if LCDByte > 7 then
	movf	LCDBYTE,W,ACCESS
	sublw	7
	btfss	STATUS, C,ACCESS
;LCD_State = LCDByte
	movff	LCDBYTE,LCD_STATE
;end if
;END IF
ENDIF204
;END IF
ENDIF203
	return

;********************************************************************************

;Source: lcd.h (1081)
LCDWRITECHAR
;Sub to print character on the LCD
;set LCD_RS on
	bsf	LATD,4,ACCESS
;LCDWriteByte(LCDChar)
	movff	LCDCHAR,LCDBYTE
	rcall	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	goto	Delay_10US

;********************************************************************************

;Source: string.h (1350)
FN_LEFTPAD
;check input length
;return if too short or equal SysStrLen
;If SysStrLen > SysInString(0) Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSSTRLEN,W,BANKED
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ELSE279_1
;LeftPad = ""
	lfsr	1,LEFTPAD
	movlw	low StringTable167
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable167
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable167
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
;LeftPad(0) = SysStrLen       'set string to new length
	movff	SYSSTRLEN,SYSLEFTPAD_0
;SysCharCount = SysStrLen - SysInString(0) 'diff-length To incoming string
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	SYSSTRLEN,W,BANKED
	movwf	SYSCHARCOUNT,BANKED
;add sysInString2 to new String
;for SysStringTemp = 1 to SysCharCount
;Legacy method
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd18
SysForLoop18
	incf	SYSSTRINGTEMP,F,BANKED
;LeftPad(sysStringTemp) = SysInString2(1)
	movlw	1
	addwf	SysSYSINSTRING2Handler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRING2Handler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,LEFTPAD
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp2,POSTINC0
;Next
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop18
SysForLoopEnd18
;add old content to new string
;For SysStringTemp = 1 To sysInString(0)
;Legacy method
	clrf	SYSSTRINGTEMP,BANKED
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd19
SysForLoop19
	incf	SYSSTRINGTEMP,F,BANKED
;LeftPad(sysCharCount + sysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,LEFTPAD
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	SysArrayTemp2,POSTINC0
;Next
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop19
SysForLoopEnd19
;Else
	bra	ENDIF279
ELSE279_1
;LeftPad = SysInString
	lfsr	1,LEFTPAD
	movff	SysSYSINSTRINGHandler,FSR0L
	movff	SysSYSINSTRINGHandler_H,FSR0H
	call	SYSCOPYSTRING
;end if
ENDIF279
	return

;********************************************************************************

;Source: lcd.h (497)
LOCATE
;Sub to locate the cursor
;Where LCDColumn is 0 to screen width-1, LCDLine is 0 to screen height-1
;Set LCD_RS Off
	bcf	LATD,4,ACCESS
;If LCDLine > 1 Then
	movf	LCDLINE,W,ACCESS
	sublw	1
	btfsc	STATUS, C,ACCESS
	bra	ENDIF196
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F,ACCESS
;LCDColumn = LCDColumn + LCD_WIDTH
	movlw	16
	addwf	LCDCOLUMN,F,ACCESS
;End If
ENDIF196
;LCDWriteByte(0x80 or 0x40 * LCDLine + LCDColumn)
	movf	LCDLINE,W,ACCESS
	mullw	64
	movf	LCDCOLUMN,W,ACCESS
	addwf	PRODL,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	128
	iorwf	SysTemp1,W,BANKED
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	goto	Delay_10US

;********************************************************************************

;Source: 20_Capability_demo.gcb (1033)
MEMORY_ISR
;(Re)DIMension nvaddress as Long as this is declared within the subroutine constraint
;Dim nvmaddress as Long
;
;Supporting ISR routine, see the assiociated lab
;
;flagCounter++
	incf	FLAGCOUNTER,F,ACCESS
;Select Case labNumber
;Case Lab_EEPROM:
SysSelect2Case1
	movlw	11
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;if flagCounter = EEPROM_FLAG_COUNTER_MAX Then
	movlw	6
	subwf	FLAGCOUNTER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF66
;Toggle the LED and write the ADC value to EEPROM
;LED_D5 = !LED_D5
	clrf	SysTemp1,BANKED
	btfsc	PORTB,3,ACCESS
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	LATB,3,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,3,ACCESS
;EPWrite (  eeprom_address, ReadAD(AN0) )
	movff	EEPROM_ADDRESS,SYSEEADDRESS
	clrf	SYSEEADDRESS_H,BANKED
	clrf	ADREADPORT,ACCESS
	call	FN_READAD46
	movff	SYSREADADBYTE,EEDATA
	rcall	NVMADR_EPWRITE
;flagCounter = 0
	clrf	FLAGCOUNTER,ACCESS
;end if
ENDIF66
;Case Lab_NVMemory:
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	13
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
;if flagCounter = NVM_FLAG_COUNTER_MAX Then
	movlw	20
	subwf	FLAGCOUNTER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF67
;Toggle the LED and write the ADC value to NVMemory
;LED_D5 = !LED_D5
	clrf	SysTemp1,BANKED
	btfsc	PORTB,3,ACCESS
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	LATB,3,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,3,ACCESS
;The PFM write needs to complete without the interrupts
;Ensure the address and the data is passed as LONG and WORD respectively
;PFMWrite (  [Long]nvmaddress, [WORD]ReadAD10(AN0) )
	movff	NVMADDRESS,_PFM_ADDR
	movff	NVMADDRESS_H,_PFM_ADDR_H
	movff	NVMADDRESS_U,_PFM_ADDR_U
	movff	NVMADDRESS_E,_PFM_ADDR_E
	clrf	ADREADPORT,ACCESS
	call	FN_READAD1048
	movff	SYSREADAD10WORD,_PFM_DATAWORD
	movff	SYSREADAD10WORD_H,_PFM_DATAWORD_H
	rcall	PFMWRITE311
;flagCounter = 0
	clrf	FLAGCOUNTER,ACCESS
;end if
ENDIF67
;Case Lab_CLOCK:
	bra	SysSelectEnd2
SysSelect2Case3
	movlw	17
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
;TMR1H  = 0x82
	movlw	130
	movwf	TMR1H,ACCESS
;TMR1L  = 0x00
	clrf	TMR1L,ACCESS
;If TicCount = 60 then
	movlw	60
	subwf	TICCOUNT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE68_1
;If ClockState Then
	btfss	SYSBITVAR0,3,BANKED
	bra	ELSE69_1
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "Tick    "
	lfsr	1,SYSSTRINGPARAM4
	movlw	low StringTable47
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable47
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable47
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM4
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM4*8
	rcall	PRINT157
;HserPrint "    Tick "
	lfsr	1,SYSSTRINGPARAM4
	movlw	low StringTable48
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable48
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable48
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM4
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM4*9
	call	HSERPRINT384
;Else
	bra	ENDIF69
ELSE69_1
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "Tock    "
	lfsr	1,SYSSTRINGPARAM4
	movlw	low StringTable49
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable49
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable49
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM4
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM4*8
	rcall	PRINT157
;HserPrint "    Tock "
	lfsr	1,SYSSTRINGPARAM4
	movlw	low StringTable50
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable50
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable50
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM4
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM4*9
	call	HSERPRINT384
;End If
ENDIF69
;ClockState = !ClockState
	clrf	SysTemp1,BANKED
	btfsc	SYSBITVAR0,3,BANKED
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	SYSBITVAR0,3,BANKED
	btfsc	SysTemp1,0,BANKED
	bsf	SYSBITVAR0,3,BANKED
;TicCount = 0
	clrf	TICCOUNT,BANKED
;Else
	bra	ENDIF68
ELSE68_1
;TicCount++
	incf	TICCOUNT,F,BANKED
;End if
ENDIF68
;Locate 1,5
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	5
	movwf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print TicCount
	movff	TICCOUNT,LCDVALUE
	rcall	PRINT158
;HserPrint TicCount
	movff	TICCOUNT,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT386
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;End Select
SysSelectEnd2
;Clear the interrupt flag
;TMR1IF = 0
	banksel	PIR4
	bcf	PIR4,TMR1IF,BANKED
;Reset the timer
;StopTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STOPTIMER
;Settimer 1, 0x0BDC
	movlw	1
	movwf	TMRNUMBER,BANKED
	movlw	220
	movwf	TMRVALUE,BANKED
	movlw	11
	movwf	TMRVALUE_H,BANKED
	call	SETTIMER228
;StartTimer 1
	movlw	1
	movwf	TMRNUMBER,BANKED
	goto	STARTTIMER

;********************************************************************************

;Source: 20_Capability_demo.gcb (1862)
NEXTLAB
;switchEvent = 0
	clrf	SWITCHEVENT,BANKED
;labNumber++
	incf	LABNUMBER,F,ACCESS
;if labNumber > MAX_LABS then labNumber = 1
	movf	LABNUMBER,W,ACCESS
	sublw	18
	btfsc	STATUS, C,ACCESS
	bra	ENDIF131
;if labNumber > MAX_LABS then labNumber = 1
	movlw	1
	movwf	LABNUMBER,ACCESS
;if labNumber > MAX_LABS then labNumber = 1
ENDIF131
	return

;********************************************************************************

;Source: eeprom.h (486)
NVMADR_EPREAD
;Select DATA EE section (0x310000- 0x3103FF) for ChipFamily18FxxQ10
;NVMADRU = 0x31
	movlw	49
	movwf	NVMADRU,ACCESS
;NVMADRH =SysEEAddress_h
	movff	SYSEEADDRESS_H,NVMADRH
;NVMADRL =SysEEAddress
	movff	SYSEEADDRESS,NVMADRL
;RD = 1
	bsf	NVMCON1,RD,ACCESS
;NOP     ' NOPs added for latency at high frequencies
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;EEDataValue = NVMDATL
	movff	NVMDATL,EEDATAVALUE
	return

;********************************************************************************

;Source: eeprom.h (308)
NVMADR_EPWRITE
;dim IntState as bit
;IntState = GIE
	bcf	SYSBITVAR0,6,BANKED
	btfsc	INTCON,GIE,ACCESS
	bsf	SYSBITVAR0,6,BANKED
;Dim SysEEPromAddress As Word
;Dim  NVMCON1_0_State, NVMCON1_1_State, NVMCON1_2_State as bit
;NVMCON1_0_State = NVMCON1.0
	bcf	SYSBITVAR1,1,BANKED
	btfsc	NVMCON1,0,ACCESS
	bsf	SYSBITVAR1,1,BANKED
;NVMCON1_1_State = NVMCON1.1
	bcf	SYSBITVAR1,2,BANKED
	btfsc	NVMCON1,1,ACCESS
	bsf	SYSBITVAR1,2,BANKED
;NVMCON1_2_State = NVMCON1.2
	bcf	SYSBITVAR1,3,BANKED
	btfsc	NVMCON1,2,ACCESS
	bsf	SYSBITVAR1,3,BANKED
;Select DATA EE section (0x310000- 0x3103FF) for ChipFamily18FxxQ10
;NVMADRU = 0x31
	movlw	49
	movwf	NVMADRU,ACCESS
;NVMADRH =SysEEAddress_h
	movff	SYSEEADDRESS_H,NVMADRH
;NVMADRL =SysEEAddress
	movff	SYSEEADDRESS,NVMADRL
;NVMDATL = EEData
	movff	EEDATA,NVMDATL
;NVMEN=0b'1'
	bsf	NVMCON0,NVMEN,ACCESS
;GIE = 0
	bcf	INTCON,GIE,ACCESS
;ChipMemorylock = 0x55
	movlw	85
	movwf	NVMCON2,ACCESS
;ChipMemorylock = 0xAA
	movlw	170
	movwf	NVMCON2,ACCESS
;WR = 1
	bsf	NVMCON1,WR,ACCESS
;NOP     ' NOPs may be required for latency at high frequencies
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;NOP
	nop
;wait while WR = 1
SysWaitLoop5
	btfsc	NVMCON1,WR,ACCESS
	bra	SysWaitLoop5
;NVMEN=0b'0'
	bcf	NVMCON0,NVMEN,ACCESS
;NVMCON1.0 = NVMCON1_0_State
	bcf	NVMCON1,0,ACCESS
	btfsc	SYSBITVAR1,1,BANKED
	bsf	NVMCON1,0,ACCESS
;NVMCON1.1 = NVMCON1_1_State
	bcf	NVMCON1,1,ACCESS
	btfsc	SYSBITVAR1,2,BANKED
	bsf	NVMCON1,1,ACCESS
;NVMCON1.2 = NVMCON1_2_State
	bcf	NVMCON1,2,ACCESS
	btfsc	SYSBITVAR1,3,BANKED
	bsf	NVMCON1,2,ACCESS
;Restore interrupt to initial  State
;GIE = IntState
	btfss	SYSBITVAR0,6,BANKED
	bcf	INTCON,GIE,ACCESS
	btfsc	SYSBITVAR0,6,BANKED
	bsf	INTCON,GIE,ACCESS
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (1277)
NVMEMORY
;
;This is a psuedo data logger.  The ADC read data is saved to NVMemory.
;
;The timer interrupt reads the ADC and then saves it to NVMemory.
;Then, the LCD reads the NVMemory and displays NVMemory result on the first line and “0Xnnnn = x” on the second line, where x
;corresponds to the saved ADC result in the NVMemory.
;
;The ADC reads are held in NVRAM. The last 128 are retained.  Use PICKITPLUS to read the PROGMEM!
;
;Dim flagCounter as Byte
;Dim PFMadcResult as  Word
;(Re)DIMension nvaddress as Long as this is declared within the subroutine constraint
;Dim nvmaddress as Long
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF91
;HserPrint Str(labNumber) + ": NVM Memory Lab"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable66
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable66
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable66
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Make the write event happen, the first time
;flagCounter = 0
	clrf	FLAGCOUNTER,ACCESS
;top of PROGMEM. Should be safe! Nothing should be up there!
;nvmaddress = ( CHIPWORDS * 2 ) - CHIPWRITEFLASHBLOCKSIZE
	movlw	128
	movwf	NVMADDRESS,ACCESS
	setf	NVMADDRESS_H,ACCESS
	movlw	1
	movwf	NVMADDRESS_U,ACCESS
	clrf	NVMADDRESS_E,ACCESS
;CLS
	call	CLS
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Print "   NVMemory     "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable67
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable67
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable67
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	rcall	PRINT157
;Wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;Call ISR set first value.  This will populate the first word in PROGMEM
;Memory_ISR
	rcall	MEMORY_ISR
;Now setup interrupt
;InitTimer1 FOSC4 , PS1_4
	movlw	1
	movwf	TMRSOURCE,BANKED
	movlw	32
	movwf	TMRPRES,BANKED
	call	INITTIMER1
;Settimer 1, 0x0BDC
	movlw	1
	movwf	TMRNUMBER,BANKED
	movlw	220
	movwf	TMRVALUE,BANKED
	movlw	11
	movwf	TMRVALUE_H,BANKED
	call	SETTIMER228
;TMR1IF = 0
	banksel	PIR4
	bcf	PIR4,TMR1IF,BANKED
;StartTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STARTTIMER
;On Interrupt Timer1Overflow Call Memory_ISR
	banksel	PIE4
	bsf	PIE4,TMR1IE,BANKED
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;end if
ENDIF91
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF92
;If flagCounter = 0 Then
	movf	FLAGCOUNTER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF94
;flagCounter = 1
	movlw	1
	movwf	FLAGCOUNTER,ACCESS
;It is time to read and show the memory results
;PFMadcResult = PFMReadWord( nvmaddress )
	movff	NVMADDRESS,_TFM_ABS_ADDR
	movff	NVMADDRESS_H,_TFM_ABS_ADDR_H
	movff	NVMADDRESS_U,_TFM_ABS_ADDR_U
	movff	NVMADDRESS_E,_TFM_ABS_ADDR_E
	banksel	0
	rcall	FN_PFMREADWORD
	movff	PFMREADWORD,PFMADCRESULT
	movff	PFMREADWORD_H,PFMADCRESULT_H
;locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print " NVM Result =   "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable68
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable68
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable68
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	rcall	PRINT157
;locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "0x"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable69
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable69
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable69
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*2
	rcall	PRINT157
;Print Hex( nvmaddress_u )
	movff	NVMADDRESS_U,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT157
;Print Hex( nvmaddress_h )
	movff	NVMADDRESS_H,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT157
;Print Hex( nvmaddress )
	movff	NVMADDRESS,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT157
;Locate 1,10
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	10
	movwf	LCDCOLUMN,ACCESS
	rcall	LOCATE
;Print "0x"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable69
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable69
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable69
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*2
	rcall	PRINT157
;Print hex(PFMadcResult_h)
	movff	PFMADCRESULT_H,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT157
;Print hex(PFMadcResult)
	movff	PFMADCRESULT,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT157
;Increment and manage the PROGMEM address to save the data.
;We are writing WORD values, so increment by 2
;nvmaddress = nvmaddress + 2
	movlw	2
	addwf	NVMADDRESS,F,ACCESS
	movlw	0
	addwfc	NVMADDRESS_H,F,ACCESS
	movlw	0
	addwfc	NVMADDRESS_U,F,ACCESS
	movlw	0
	addwfc	NVMADDRESS_E,F,ACCESS
;If nvmaddress = ( CHIPWORDS * 2 ) then nvmaddress = ( CHIPWORDS * 2 ) - CHIPWRITEFLASHBLOCKSIZE
	movff	NVMADDRESS,SysLONGTempA
	movff	NVMADDRESS_H,SysLONGTempA_H
	movff	NVMADDRESS_U,SysLONGTempA_U
	movff	NVMADDRESS_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	movlw	2
	movwf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSCOMPEQUAL32
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF95
;If nvmaddress = ( CHIPWORDS * 2 ) then nvmaddress = ( CHIPWORDS * 2 ) - CHIPWRITEFLASHBLOCKSIZE
	movlw	128
	movwf	NVMADDRESS,ACCESS
	setf	NVMADDRESS_H,ACCESS
	movlw	1
	movwf	NVMADDRESS_U,ACCESS
	clrf	NVMADDRESS_E,ACCESS
;If nvmaddress = ( CHIPWORDS * 2 ) then nvmaddress = ( CHIPWORDS * 2 ) - CHIPWRITEFLASHBLOCKSIZE
ENDIF95
;Now show on LEDS
;Get the top 3 MSBs (Shift LEFT), then *2 ( Shift Right) and display these on the LEDs
;PFMadcResult = (FnLSR ( PFMadcResult, 7))
	movff	PFMADCRESULT,SYSWORDTEMPB
	movff	PFMADCRESULT_H,SYSWORDTEMPB_H
	movlw	7
	movwf	NUMBITS,ACCESS
	call	FN_FNLSR126
	movff	SYSFNLSRWORD,PFMADCRESULT
	movff	SYSFNLSRWORD_H,PFMADCRESULT_H
;PortB = ( PortB and 0xF0) OR PFMadcResult
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp2,BANKED
	iorwf	PFMADCRESULT,W,ACCESS
	movwf	PORTB,ACCESS
;end if
ENDIF94
;end if
ENDIF92
;if switchEvent = 1 Then
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF93
;On Interrupt Timer1Overflow Ignore
	banksel	PIE4
	bcf	PIE4,TMR1IE,BANKED
;StopTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STOPTIMER
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
ENDIF93
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
	movf	SYSSTRLEN,W,BANKED
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ELSE272_1
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;clear output string
;Pad=""
	lfsr	1,PAD
	movlw	low StringTable167
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable167
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable167
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
;Legacy method
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd15
SysForLoop15
	incf	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
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
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop15
SysForLoopEnd15
;For SysStringTemp = SysCharCount+1 to SysStrLen
;Legacy method
	incf	SYSCHARCOUNT,W,BANKED
	movwf	SysTemp1,BANKED
	decf	SysTemp1,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
	incf	SYSCHARCOUNT,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movff	SYSSTRLEN,SysBYTETempA
	call	SYSCOMPLESSTHAN
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd16
SysForLoop16
	incf	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString3(1)
	movlw	1
	addwf	SysSYSINSTRING3Handler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRING3Handler_H,W,BANKED
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
	movf	SYSSTRLEN,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop16
SysForLoopEnd16
;set new length to PAD
;Pad(0) = SysStrLen
	movff	SYSSTRLEN,SYSPAD_0
;else
	bra	ENDIF272
ELSE272_1
;SysInString is equal or longer than SysStrLen
;give back old string; copy SysInString to Pad
;For SysStringTemp = 1 To SysInString(0)
;Legacy method
	clrf	SYSSTRINGTEMP,BANKED
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd17
SysForLoop17
	incf	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
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
	bra	SysForLoop17
SysForLoopEnd17
;PAD(0) = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SYSPAD_0
;End If
ENDIF272
	return

;********************************************************************************

;Source: system.h (5428)
FN_PFMREADWORD
;Dim _dummy as byte
;Dim _TFM_ABS_ADDR as Long Alias _dummy, TBLPTRU, TBLPTRH, TBLPTRL
;TBLRD*+
	tblrd*+
;PFMReadWord = TABLAT
	movff	TABLAT,PFMREADWORD
	clrf	PFMREADWORD_H,ACCESS
;TBLRD*+
	tblrd*+
;PFMReadWord_h = TABLAT
	movff	TABLAT,PFMREADWORD_H
	return

;********************************************************************************

;Overloaded signature: LONG:WORD:, Source: system.h (5498)
PFMWRITE311
;Dim _PFM_BlockNum, _PFM_Offset as long
;Dim _PFM_Buffer(SAF_ROWSIZE_BYTES)
;Calculate block number
;_PFM_BlockNum = _PFM_ADDR / SAF_ROWSIZE_BYTES
	movff	_PFM_ADDR,SysLONGTempA
	movff	_PFM_ADDR_H,SysLONGTempA_H
	movff	_PFM_ADDR_U,SysLONGTempA_U
	movff	_PFM_ADDR_E,SysLONGTempA_E
	movlw	128
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSDIVSUB32
	movff	SysLONGTempA,_PFM_BLOCKNUM
	movff	SysLONGTempA_H,_PFM_BLOCKNUM_H
	movff	SysLONGTempA_U,_PFM_BLOCKNUM_U
	movff	SysLONGTempA_E,_PFM_BLOCKNUM_E
;Calculate offset in block/row
;_PFM_Offset = _PFM_Addr % SAF_ROWSIZE_BYTES
	movff	_PFM_ADDR,SysLONGTempA
	movff	_PFM_ADDR_H,SysLONGTempA_H
	movff	_PFM_ADDR_U,SysLONGTempA_U
	movff	_PFM_ADDR_E,SysLONGTempA_E
	movlw	128
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSDIVSUB32
	movff	SysLONGTempX,_PFM_OFFSET
	movff	SysLONGTempX_H,_PFM_OFFSET_H
	movff	SysLONGTempX_U,_PFM_OFFSET_U
	movff	SysLONGTempX_E,_PFM_OFFSET_E
;Save data previously stored in row#
;_PFMReadBlock(_PFM_BlockNum, _PFM_Buffer(), SAF_ROWSIZE_BYTES)
	movlw	low _PFM_BUFFER
	movwf	Sys_PFM_BUFFERHandler,BANKED
	movlw	high _PFM_BUFFER
	movwf	Sys_PFM_BUFFERHandler_H,BANKED
	movlw	128
	movwf	_PFM_COUNT,BANKED
	clrf	_PFM_COUNT_H,BANKED
	call	_PFMREADBLOCK
;Update buffer with DataValue at offset
;_PFM_Buffer(_PFM_Offset + 1) =  _PFM_DataWord
	lfsr	0,_PFM_BUFFER
	banksel	_PFM_OFFSET
	movf	_PFM_OFFSET,W,BANKED
	addwf	AFSR0,W,ACCESS
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	banksel	_PFM_OFFSET_H
	movf	_PFM_OFFSET_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	_PFM_DATAWORD,INDF0
;_PFM_Buffer(_PFM_Offset + 2) =  _PFM_DataWord_H
	lfsr	0,_PFM_BUFFER
	banksel	_PFM_OFFSET
	movf	_PFM_OFFSET,W,BANKED
	addwf	AFSR0,W,ACCESS
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	banksel	_PFM_OFFSET_H
	movf	_PFM_OFFSET_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	movlw	2
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	_PFM_DATAWORD_H,INDF0
;Write back the updated row buffer to  PFMM
;_PFMwriteBlock(_PFM_BlockNum, _PFM_Buffer(), SAF_ROWSIZE_BYTES)
	movlw	low _PFM_BUFFER
	movwf	Sys_PFM_BUFFERHandler,BANKED
	movlw	high _PFM_BUFFER
	movwf	Sys_PFM_BUFFERHandler_H,BANKED
	movlw	128
	movwf	_PFM_COUNT,BANKED
	clrf	_PFM_COUNT_H,BANKED
	goto	_PFMWRITEBLOCK

;********************************************************************************

;Source: songplay.h (223)
PLAYRTTTL
;Count colons, decide what mode
;Due to RAM limitations, this sub must accept partial songs
;If 2 colons present, assume name:params:song
;If 1 colon, assume params:song
;If no colon, assume song only (probably continuation of previous)
;SoundPlayMode = 2
	movlw	2
	movwf	SOUNDPLAYMODE,BANKED
;SoundPlayBytes = SoundPlayData(0)
	movff	SysSOUNDPLAYDATAHandler,AFSR0
	movff	SysSOUNDPLAYDATAHandler_H,AFSR0_H
	movff	INDF0,SOUNDPLAYBYTES
;For SoundPlayCurrNote = 1 to SoundPlayBytes
;Legacy method
	clrf	SOUNDPLAYCURRNOTE,BANKED
	movlw	1
	subwf	SOUNDPLAYBYTES,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd8
SysForLoop8
	incf	SOUNDPLAYCURRNOTE,F,BANKED
;If SoundPlayData(SoundPlayCurrNote) = ":" Then
	movf	SOUNDPLAYCURRNOTE,W,BANKED
	addwf	SysSOUNDPLAYDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSOUNDPLAYDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movlw	58
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;SoundPlayMode -= 1
	decf	SOUNDPLAYMODE,F,BANKED
;End If
;Next
	movf	SOUNDPLAYBYTES,W,BANKED
	subwf	SOUNDPLAYCURRNOTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop8
SysForLoopEnd8
;Parse commands
;SoundPlayNumber = 0
	clrf	SOUNDPLAYNUMBER,BANKED
;SoundPlayBytes += 1
	incf	SOUNDPLAYBYTES,F,BANKED
;For SoundPlayCurrNote = 1 To SoundPlayBytes
;Legacy method
	clrf	SOUNDPLAYCURRNOTE,BANKED
	movlw	1
	subwf	SOUNDPLAYBYTES,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd9
SysForLoop9
	incf	SOUNDPLAYCURRNOTE,F,BANKED
;Get command
;If SoundPlayCurrNote = SoundPlayBytes Then
	movf	SOUNDPLAYBYTES,W,BANKED
	subwf	SOUNDPLAYCURRNOTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE140_1
;SoundPlayByte = ","
	movlw	44
	movwf	SOUNDPLAYBYTE,BANKED
;Else
	bra	ENDIF140
ELSE140_1
;SoundPlayByte = SoundPlayData(SoundPlayCurrNote)
	movf	SOUNDPLAYCURRNOTE,W,BANKED
	addwf	SysSOUNDPLAYDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSOUNDPLAYDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SOUNDPLAYBYTE
;End If
ENDIF140
;Convert to all upper case
;If SoundPlayByte <= "Z" Then
	movff	SOUNDPLAYBYTE,SysBYTETempB
	movlw	90
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF141
;If SoundPlayByte >= "A" Then
	movff	SOUNDPLAYBYTE,SysBYTETempA
	movlw	65
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF151
;SoundPlayByte += 32
	movlw	32
	addwf	SOUNDPLAYBYTE,F,BANKED
;End If
ENDIF151
;End If
ENDIF141
;Parse byte
;Command
;If SoundPlayByte >= "a" Then
	movff	SOUNDPLAYBYTE,SysBYTETempA
	movlw	97
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF142
;If SoundPlayByte <= "z" Then
	movff	SOUNDPLAYBYTE,SysBYTETempB
	movlw	122
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF152
;SoundPlayCommand = SoundPlayByte
	movff	SOUNDPLAYBYTE,SOUNDPLAYCOMMAND
;SoundPlayNumber2 = SoundPlayNumber
	movff	SOUNDPLAYNUMBER,SOUNDPLAYNUMBER2
;SoundPlayNumber = 0
	clrf	SOUNDPLAYNUMBER,BANKED
;Goto SoundPlayRTTTLNextNote
	bra	SOUNDPLAYRTTTLNEXTNOTE
;End If
ENDIF152
;End If
ENDIF142
;Number
;If SoundPlayByte >= "0" Then
	movff	SOUNDPLAYBYTE,SysBYTETempA
	movlw	48
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF143
;If SoundPlayByte <= "9" Then
	movff	SOUNDPLAYBYTE,SysBYTETempB
	movlw	57
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF153
;SoundPlayNumber = SoundPlayNumber * 10 + SoundPlayByte - 48
	movf	SOUNDPLAYNUMBER,W,BANKED
	mullw	10
	movf	SOUNDPLAYBYTE,W,BANKED
	addwf	PRODL,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	48
	subwf	SysTemp2,W,BANKED
	movwf	SOUNDPLAYNUMBER,BANKED
;Goto SoundPlayRTTTLNextNote
	bra	SOUNDPLAYRTTTLNEXTNOTE
;End If
ENDIF153
;End If
ENDIF143
;What parsing mode?
;Select Case SoundPlayMode
;Parsing name
;Case 0
SysSelect3Case1
	movf	SOUNDPLAYMODE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;If SoundPlayByte = ":" Then
	movlw	58
	subwf	SOUNDPLAYBYTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF144
;SoundPlayMode += 1
	incf	SOUNDPLAYMODE,F,BANKED
;SoundPlayCommand = SOUND_CMD_NONE
	clrf	SOUNDPLAYCOMMAND,BANKED
;SoundPlayNumber = 0
	clrf	SOUNDPLAYNUMBER,BANKED
;End If
ENDIF144
;Parsing default values
;Case 1
	bra	SysSelectEnd3
SysSelect3Case2
	decf	SOUNDPLAYMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case3
;Colon, save setting, change to song mode
;If SoundPlayByte = ":" Then
	movlw	58
	subwf	SOUNDPLAYBYTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF145
;SoundPlayMode += 1
	incf	SOUNDPLAYMODE,F,BANKED
;Goto SoundPlayRTTTLComma
	bra	SOUNDPLAYRTTTLCOMMA
;End If
ENDIF145
;Comma, save setting
;If SoundPlayByte = "," Then
	movlw	44
	subwf	SOUNDPLAYBYTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF146
SOUNDPLAYRTTTLCOMMA
;If SoundPlayCommand = "d" Then SoundPlayLength = SoundPlayNumber
	movlw	100
	subwf	SOUNDPLAYCOMMAND,W,BANKED
	btfsc	STATUS, Z,ACCESS
;If SoundPlayCommand = "d" Then SoundPlayLength = SoundPlayNumber
	movff	SOUNDPLAYNUMBER,SOUNDPLAYLENGTH
;If SoundPlayCommand = "d" Then SoundPlayLength = SoundPlayNumber
;RTTTL octave 4 = QBASIC octave 2
;If SoundPlayCommand = "o" Then SoundPlayOctave = SoundPlayNumber - 2
	movlw	111
	subwf	SOUNDPLAYCOMMAND,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF155
;If SoundPlayCommand = "o" Then SoundPlayOctave = SoundPlayNumber - 2
	movlw	2
	subwf	SOUNDPLAYNUMBER,W,BANKED
	movwf	SOUNDPLAYOCTAVE,BANKED
;If SoundPlayCommand = "o" Then SoundPlayOctave = SoundPlayNumber - 2
ENDIF155
;If SoundPlayCommand = "b" Then SoundPlayTempo = SoundPlayNumber
	movlw	98
	subwf	SOUNDPLAYCOMMAND,W,BANKED
	btfsc	STATUS, Z,ACCESS
;If SoundPlayCommand = "b" Then SoundPlayTempo = SoundPlayNumber
	movff	SOUNDPLAYNUMBER,SOUNDPLAYTEMPO
;If SoundPlayCommand = "b" Then SoundPlayTempo = SoundPlayNumber
;SoundPlayNumber = 0
	clrf	SOUNDPLAYNUMBER,BANKED
;SoundPlayCommand = SOUND_CMD_NONE
	clrf	SOUNDPLAYCOMMAND,BANKED
;End If
ENDIF146
;Parsing song
;Case 2
	bra	SysSelectEnd3
SysSelect3Case3
	movlw	2
	subwf	SOUNDPLAYMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd3
;Sharp note
;If SoundPlayByte = "#" Then SoundPlayNoteType = SOUND_NOTE_SHARP
	movlw	35
	subwf	SOUNDPLAYBYTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF147
;If SoundPlayByte = "#" Then SoundPlayNoteType = SOUND_NOTE_SHARP
	movlw	1
	movwf	SOUNDPLAYNOTETYPE,BANKED
;If SoundPlayByte = "#" Then SoundPlayNoteType = SOUND_NOTE_SHARP
ENDIF147
;Increase length
;If SoundPlayByte = "." Then SoundPlayDots += 1
	movlw	46
	subwf	SOUNDPLAYBYTE,W,BANKED
	btfsc	STATUS, Z,ACCESS
;If SoundPlayByte = "." Then SoundPlayDots += 1
	incf	SOUNDPLAYDOTS,F,BANKED
;If SoundPlayByte = "." Then SoundPlayDots += 1
;Play note
;If SoundPlayByte = "," Then
	movlw	44
	subwf	SOUNDPLAYBYTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF149
;SoundPlayNumber2: Duration
;SoundPlayCommand: Letter of note
;SoundPlayNumber: Octave
;If SoundPlayCommand <> SOUND_CMD_NONE Then
	movf	SOUNDPLAYCOMMAND,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF157
;Pause
;If SoundPlayCommand = "p" Then
	movlw	112
	subwf	SOUNDPLAYCOMMAND,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE158_1
;Treat as N0 command, but set length
;If SoundPlayNumber2 = 0 Then
	movf	SOUNDPLAYNUMBER2,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE159_1
;SoundPlayNoteLen = SoundPlayLength
	movff	SOUNDPLAYLENGTH,SOUNDPLAYNOTELEN
;Else
	bra	ENDIF159
ELSE159_1
;SoundPlayNoteLen = SoundPlayNumber2
	movff	SOUNDPLAYNUMBER2,SOUNDPLAYNOTELEN
;End If
ENDIF159
;SoundPlayTone 0, SoundPlayNoteLen
	clrf	SOUNDPLAYNOTE,BANKED
	call	SOUNDPLAYTONE
;Play note
;Else
	bra	ENDIF158
ELSE158_1
;Get note octave and length
;If SoundPlayNumber = 0 Then
	movf	SOUNDPLAYNUMBER,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE160_1
;SoundPlayNoteOctave = SoundPlayOctave
	movff	SOUNDPLAYOCTAVE,SOUNDPLAYNOTEOCTAVE
;Else
	bra	ENDIF160
ELSE160_1
;SoundPlayNoteOctave = SoundPlayNumber - 2
	movlw	2
	subwf	SOUNDPLAYNUMBER,W,BANKED
	movwf	SOUNDPLAYNOTEOCTAVE,BANKED
;End If
ENDIF160
;If SoundPlayNumber2 = 0 Then
	movf	SOUNDPLAYNUMBER2,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE161_1
;SoundPlayNoteLen = SoundPlayLength
	movff	SOUNDPLAYLENGTH,SOUNDPLAYNOTELEN
;Else
	bra	ENDIF161
ELSE161_1
;SoundPlayNoteLen = SoundPlayNumber2
	movff	SOUNDPLAYNUMBER2,SOUNDPLAYNOTELEN
;End If
ENDIF161
;Play note
;Translate to note number
;ReadTable SoundPlayNoteNumbers, SoundPlayCommand - 96, SoundPlayNote
	movlw	96
	subwf	SOUNDPLAYCOMMAND,W,BANKED
	movwf	SYSSTRINGA,ACCESS
	call	SOUNDPLAYNOTENUMBERS
	movwf	SOUNDPLAYNOTE,BANKED
;Get note number
;SoundPlayNote = SoundPlayNoteOctave * 12 + SoundPlayNote
	movf	SOUNDPLAYNOTEOCTAVE,W,BANKED
	mullw	12
	movf	SOUNDPLAYNOTE,W,BANKED
	addwf	PRODL,W,ACCESS
	movwf	SOUNDPLAYNOTE,BANKED
;SoundPlayToneNumber SoundPlayCommand, SoundPlayNoteType, SoundPlayNoteLen
;Get note duration
;If SoundPlayNoteLen = 0 Then
	movf	SOUNDPLAYNOTELEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
;SoundPlayNoteLen = SoundPlayLength
	movff	SOUNDPLAYLENGTH,SOUNDPLAYNOTELEN
;End If
;Is note sharp or flat?
;If SoundPlayNoteType = SOUND_NOTE_SHARP Then
	decf	SOUNDPLAYNOTETYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF163
;SoundPlayNote += 1
	incf	SOUNDPLAYNOTE,F,BANKED
;If SoundPlayNote = 85 Then
	movlw	85
	subwf	SOUNDPLAYNOTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF165
;SoundPlayNote = 84
	movlw	84
	movwf	SOUNDPLAYNOTE,BANKED
;End If
ENDIF165
;End If
ENDIF163
;SoundPlayTone SoundPlayNote, SoundPlayNoteLen
	call	SOUNDPLAYTONE
;If SoundPlayDots <> 0 Then
	movf	SOUNDPLAYDOTS,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF164
;SoundPlayTone SoundPlayNote, SoundPlayNoteLen * 2
	movf	SOUNDPLAYNOTELEN,W,BANKED
	mullw	2
	movff	PRODL,SOUNDPLAYNOTELEN
	call	SOUNDPLAYTONE
;End If
ENDIF164
;Eighth note silence at end of note
;SoundPlayToneEnd
;End If
ENDIF158
;SoundPlayNumber = 0
	clrf	SOUNDPLAYNUMBER,BANKED
;SoundPlayNumber2 = 0
	clrf	SOUNDPLAYNUMBER2,BANKED
;SoundPlayNoteType = SOUND_NOTE_NORMAL
	clrf	SOUNDPLAYNOTETYPE,BANKED
;SoundPlayCommand = SOUND_CMD_NONE
	clrf	SOUNDPLAYCOMMAND,BANKED
;SoundPlayDots = 0
	clrf	SOUNDPLAYDOTS,BANKED
;End If
ENDIF157
;End If
ENDIF149
;End Select
SysSelectEnd3
SOUNDPLAYRTTTLNEXTNOTE
;Next
	movf	SOUNDPLAYBYTES,W,BANKED
	subwf	SOUNDPLAYCURRNOTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
	return

;********************************************************************************

;Overloaded signature: STRING:, Source: lcd.h (936)
PRINT157
;Sub to print a string variable on the LCD
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
;If PrintLen = 0 Then Exit Sub
	return
;If PrintLen = 0 Then Exit Sub
;Set LCD_RS On
	bsf	LATD,4,ACCESS
;Write Data
;For SysPrintTemp = 1 To PrintLen
;Legacy method
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd11
SysForLoop11
	incf	SYSPRINTTEMP,F,BANKED
;LCDWriteByte PrintData(SysPrintTemp)
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,LCDBYTE
	call	LCDNORMALWRITEBYTE
;Next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop11
SysForLoopEnd11
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: lcd.h (951)
PRINT158
;Sub to print a byte variable on the LCD
;LCDValueTemp = 0
	clrf	LCDVALUETEMP,ACCESS
;Set LCD_RS On
	bsf	LATD,4,ACCESS
;IF LCDValue >= 100 Then
	movlw	100
	subwf	LCDVALUE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ENDIF200
;LCDValueTemp = LCDValue / 100
	movff	LCDVALUE,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempA,LCDVALUETEMP
;LCDValue = SysCalcTempX
	movff	SYSCALCTEMPX,LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W,ACCESS
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
;End If
ENDIF200
;If LCDValueTemp > 0 Or LCDValue >= 10 Then
	movff	LCDVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	movff	SysByteTempX,SysTemp1
	movff	LCDVALUE,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF201
;LCDValueTemp = LCDValue / 10
	movff	LCDVALUE,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempA,LCDVALUETEMP
;LCDValue = SysCalcTempX
	movff	SYSCALCTEMPX,LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W,ACCESS
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
;End If
ENDIF201
;LCDWriteByte (LCDValue + 48)
	movlw	48
	addwf	LCDVALUE,W,ACCESS
	movwf	LCDBYTE,ACCESS
	goto	LCDNORMALWRITEBYTE

;********************************************************************************

;Source: 20_Capability_demo.gcb (605)
PWM
;
;Rotating the potentiometer R25 will adjust the brightness of attached LEDs. The LCD displays “PWM” on
;the first line and “Duty Cycle = xx%” on the second line, where xx corresponds to the PWM duty
;cycle.
;
;GCODE Optimisation file - this will optimise PWM operations by disabling the PWM operations on the PWM channel and Timer that is set to FALSE
;to enable PWM and Timer operations set to FALSE
;
;Optimise CCP/PWM
;
;Optimise PWM
;Optimise Timers associated with PWM operations
;
;Module: CCP1
;RB0PPS = 0x0005    // CCP1 > RB0
	movlw	5
	banksel	RB0PPS
	movwf	RB0PPS,BANKED
;CCP1PPS = 0x0008    // RB0 > CCP1 (bi-directional)
	movlw	8
	movwf	CCP1PPS,BANKED
;RB1PPS = 0x0005    // CCP1 > RB1
	movlw	5
	movwf	RB1PPS,BANKED
;CCP1PPS = 0x0009    // RB1 > CCP1 (bi-directional)
	movlw	9
	movwf	CCP1PPS,BANKED
;RB2PPS = 0x0005    // CCP1 > RB2
	movlw	5
	movwf	RB2PPS,BANKED
;CCP1PPS = 0x000A    // RB2 > CCP1 (bi-directional)
	movlw	10
	movwf	CCP1PPS,BANKED
;RB3PPS = 0x0005    // CCP1 > RB3
	movlw	5
	movwf	RB3PPS,BANKED
;CCP1PPS = 0x000B    // RB3 > CCP1 (bi-directional)
	movlw	11
	movwf	CCP1PPS,BANKED
;Dim adcResult, oldadcResult as Word         // Store ADC values
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF32
;HserPrint Str(labNumber) + ": PWM Lab"
	movff	LABNUMBER,SYSVALTEMP
	banksel	SYSVALTEMP_H
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable26
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable26
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable26
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;CLS
	call	CLS
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Print "      PWM      "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable27
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable27
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable27
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*15
	rcall	PRINT157
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "Duty Cycle    0%"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable28
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable28
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable28
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	rcall	PRINT157
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;HPWM 1, 40, 0
	movlw	1
	movwf	PWMCHANNEL,BANKED
	movlw	40
	movwf	PWMFREQ,BANKED
	clrf	PWMDUTY,BANKED
	clrf	PWMDUTY_H,BANKED
	call	HPWM66
;end if
ENDIF32
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF33
;adcResult = ReadAD ( AN0 )
	clrf	ADREADPORT,ACCESS
	banksel	0
	rcall	FN_READAD46
	movff	SYSREADADBYTE,ADCRESULT
	clrf	ADCRESULT_H,ACCESS
;Only update if the ADC changes.. stops LCD flashing as the ADC has to change by a value of 2 or greater.
;if ABS( adcResult- oldadcResult ) > 1 then
	movf	OLDADCRESULT,W,ACCESS
	subwf	ADCRESULT,W,ACCESS
	movwf	SYSCALCTEMPA,ACCESS
	movf	OLDADCRESULT_H,W,ACCESS
	subwfb	ADCRESULT_H,W,ACCESS
	movwf	SYSCALCTEMPA_H,ACCESS
	call	FN_ABS
	movff	ABS,SysINTEGERTempB
	movff	ABS_H,SysINTEGERTempB_H
	movlw	1
	movwf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	call	SYSCOMPLESSTHANINT
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF35
;HPWM 1, 40, adcResult
	movlw	1
	movwf	PWMCHANNEL,BANKED
	movlw	40
	movwf	PWMFREQ,BANKED
	movff	ADCRESULT,PWMDUTY
	movff	ADCRESULT_H,PWMDUTY_H
	call	HPWM66
	movff	PWMDUTY,ADCRESULT
	movff	PWMDUTY_H,ADCRESULT_H
;oldadcResult = adcResult
	movff	ADCRESULT,OLDADCRESULT
	movff	ADCRESULT_H,OLDADCRESULT_H
;Display the result on the LCD
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "Duty Cycle     %"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable29
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	rcall	PRINT157
;Locate 1,12
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	12
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print leftpad( str(adcResult*100/255), 3, " " )
	movff	ADCRESULT,SysWORDTempA
	movff	ADCRESULT_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSMULTSUB16
	movff	SysWORDTempX,SysTemp1
	movff	SysWORDTempX_H,SysTemp1_H
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	setf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempA,SYSVALTEMP
	movff	SysWORDTempA_H,SYSVALTEMP_H
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	3
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable19
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysSYSINSTRING2Handler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING2Handler_H,BANKED
;Using SYSSTRINGPARAM2*1
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT157
;end if
ENDIF35
;end if
ENDIF33
;if switchEvent = 1 Then
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF34
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;HPWMOff
	rcall	PWMOFF62
;Module: CCP1 clear down
;RB0PPS  = 0
	banksel	RB0PPS
	clrf	RB0PPS,BANKED
;CCP1PPS = 0
	clrf	CCP1PPS,BANKED
;RB1PPS  = 0
	clrf	RB1PPS,BANKED
;CCP1PPS = 0
	clrf	CCP1PPS,BANKED
;RB2PPS  = 0
	clrf	RB2PPS,BANKED
;CCP1PPS = 0
	clrf	CCP1PPS,BANKED
;RB3PPS  = 0
	clrf	RB3PPS,BANKED
;CCP1PPS = 0
	clrf	CCP1PPS,BANKED
;end If
ENDIF34
	banksel	0
	return

;********************************************************************************

;Overloaded signature: , Source: pwm.h (2583)
PWMOFF62
;CCP1CON = 0
	clrf	CCP1CON,ACCESS
	return

;********************************************************************************

;Source: random.h (41)
FN_RANDOM
;Repeat 7
	movlw	7
	movwf	SysRepeatTemp14,BANKED
SysRepeatLoop14
;Dim RandomTemp As Word
;Dim RandomSeed As Word
;RandomTemp = RandomSeed
	movff	RANDOMSEED,RANDOMTEMP
	movff	RANDOMSEED_H,RANDOMTEMP_H
;Rotate RandomTemp Left Simple
	rlcf	RANDOMTEMP_H,W,BANKED
	rlcf	RANDOMTEMP,F,BANKED
	rlcf	RANDOMTEMP_H,F,BANKED
;Taps at 16, 15, 13, 11, And with b'1101 0100 0000 0000' = D800
;Expanded below calculation to reduce complexity of calc
;RandomSeed = RandomTemp XOR (Not (RandomSeed And 1) + 1 And 0xB400)
	movlw	1
	andwf	RANDOMSEED,W,BANKED
	movwf	SysTemp2,BANKED
	clrf	SysTemp2_H,BANKED
	comf	SysTemp2,W,BANKED
	movwf	SysTemp1,BANKED
	comf	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	clrf	SysTemp1,BANKED
	movlw	180
	andwf	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movf	RANDOMTEMP,W,BANKED
	xorwf	SysTemp1,W,BANKED
	movwf	RANDOMSEED,BANKED
	movf	RANDOMTEMP_H,W,BANKED
	xorwf	SysTemp1_H,W,BANKED
	movwf	RANDOMSEED_H,BANKED
;Expanded below calculation to reduce complexity of calc
;RandomSeed = Not (RandomSeed And 1) + 1
;RandomSeed = RandomSeed And 0xB400
;RandomSeed = RandomTemp XOR RandomSeed
;Random = Random Xor RandomSeed_H
	movf	RANDOM,W,BANKED
	xorwf	RANDOMSEED_H,W,BANKED
	movwf	RANDOM,BANKED
;End Repeat
	decfsz	SysRepeatTemp14,F,BANKED
	bra	SysRepeatLoop14
SysRepeatLoopEnd14
	return

;********************************************************************************

;Source: random.h (63)
RANDOMIZE
;Dim RandomSeed As Word
;RandomSeed += RandomTemp
	movf	RANDOMTEMP,W,BANKED
	addwf	RANDOMSEED,F,BANKED
	movf	RANDOMTEMP_H,W,BANKED
	addwfc	RANDOMSEED_H,F,BANKED
;If random seed gets set to 0, Random will return nothing but 0
;If RandomSeed = 0 Then RandomSeed = 1
	movff	RANDOMSEED,SysWORDTempA
	movff	RANDOMSEED_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF267
;If RandomSeed = 0 Then RandomSeed = 1
	movlw	1
	movwf	RANDOMSEED,BANKED
	clrf	RANDOMSEED_H,BANKED
;If RandomSeed = 0 Then RandomSeed = 1
ENDIF267
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2101)
FN_READAD46
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM,BANKED
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	movff	ADREADPORT,ADPCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (577)
;Configure ANSELA/B/C/D @DebugADC_H
;Select Case ADReadPort
;Case 0: Set ANSELA.0 On
SysSelect4Case1
	movf	ADREADPORT,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
;Case 0: Set ANSELA.0 On
	bsf	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	bra	SysSelectEnd4
SysSelect4Case2
	decf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
;Case 1: Set ANSELA.1 On
	bsf	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	2
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case4
;Case 2: Set ANSELA.2 On
	bsf	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	bra	SysSelectEnd4
SysSelect4Case4
	movlw	3
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case5
;Case 3: Set ANSELA.3 On
	bsf	ANSELA,3,BANKED
;Case 4: Set ANSELA.4 ON
	bra	SysSelectEnd4
SysSelect4Case5
	movlw	4
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case6
;Case 4: Set ANSELA.4 ON
	bsf	ANSELA,4,BANKED
;Case 5: Set ANSELA.5 On
	bra	SysSelectEnd4
SysSelect4Case6
	movlw	5
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case7
;Case 5: Set ANSELA.5 On
	bsf	ANSELA,5,BANKED
;Case 6: Set ANSELA.6 On
	bra	SysSelectEnd4
SysSelect4Case7
	movlw	6
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case8
;Case 6: Set ANSELA.6 On
	bsf	ANSELA,6,BANKED
;Case 7: Set ANSELA.7 On
	bra	SysSelectEnd4
SysSelect4Case8
	movlw	7
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case9
;Case 7: Set ANSELA.7 On
	bsf	ANSELA,7,BANKED
;Case 8: Set ANSELB.0 On
	bra	SysSelectEnd4
SysSelect4Case9
	movlw	8
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case10
;Case 8: Set ANSELB.0 On
	bsf	ANSELB,0,BANKED
;Case 9: Set ANSELB.1 On
	bra	SysSelectEnd4
SysSelect4Case10
	movlw	9
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case11
;Case 9: Set ANSELB.1 On
	bsf	ANSELB,1,BANKED
;Case 10: Set ANSELB.2 On
	bra	SysSelectEnd4
SysSelect4Case11
	movlw	10
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case12
;Case 10: Set ANSELB.2 On
	bsf	ANSELB,2,BANKED
;Case 11: Set ANSELB.3 On
	bra	SysSelectEnd4
SysSelect4Case12
	movlw	11
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case13
;Case 11: Set ANSELB.3 On
	bsf	ANSELB,3,BANKED
;Case 12: Set ANSELB.4 On
	bra	SysSelectEnd4
SysSelect4Case13
	movlw	12
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case14
;Case 12: Set ANSELB.4 On
	bsf	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	bra	SysSelectEnd4
SysSelect4Case14
	movlw	13
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case15
;Case 13: Set ANSELB.5 On
	bsf	ANSELB,5,BANKED
;Case 14: Set ANSELB.6 On
	bra	SysSelectEnd4
SysSelect4Case15
	movlw	14
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case16
;Case 14: Set ANSELB.6 On
	bsf	ANSELB,6,BANKED
;Case 15: Set ANSELB.7 On
	bra	SysSelectEnd4
SysSelect4Case16
	movlw	15
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case17
;Case 15: Set ANSELB.7 On
	bsf	ANSELB,7,BANKED
;Case 16: Set ANSELC.0 On
	bra	SysSelectEnd4
SysSelect4Case17
	movlw	16
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case18
;Case 16: Set ANSELC.0 On
	bsf	ANSELC,0,BANKED
;Case 17: Set ANSELC.1 On
	bra	SysSelectEnd4
SysSelect4Case18
	movlw	17
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case19
;Case 17: Set ANSELC.1 On
	bsf	ANSELC,1,BANKED
;Case 18: Set ANSELC.2 On
	bra	SysSelectEnd4
SysSelect4Case19
	movlw	18
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case20
;Case 18: Set ANSELC.2 On
	bsf	ANSELC,2,BANKED
;Case 19: Set ANSELC.3 On
	bra	SysSelectEnd4
SysSelect4Case20
	movlw	19
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case21
;Case 19: Set ANSELC.3 On
	bsf	ANSELC,3,BANKED
;Case 20: Set ANSELC.4 On
	bra	SysSelectEnd4
SysSelect4Case21
	movlw	20
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case22
;Case 20: Set ANSELC.4 On
	bsf	ANSELC,4,BANKED
;Case 21: Set ANSELC.5 On
	bra	SysSelectEnd4
SysSelect4Case22
	movlw	21
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case23
;Case 21: Set ANSELC.5 On
	bsf	ANSELC,5,BANKED
;Case 22: Set ANSELC.6 On
	bra	SysSelectEnd4
SysSelect4Case23
	movlw	22
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case24
;Case 22: Set ANSELC.6 On
	bsf	ANSELC,6,BANKED
;Case 23: Set ANSELC.7 On
	bra	SysSelectEnd4
SysSelect4Case24
	movlw	23
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case25
;Case 23: Set ANSELC.7 On
	bsf	ANSELC,7,BANKED
;Case 24: Set ANSELD.0 On
	bra	SysSelectEnd4
SysSelect4Case25
	movlw	24
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case26
;Case 24: Set ANSELD.0 On
	bsf	ANSELD,0,BANKED
;Case 25: Set ANSELD.1 On
	bra	SysSelectEnd4
SysSelect4Case26
	movlw	25
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case27
;Case 25: Set ANSELD.1 On
	bsf	ANSELD,1,BANKED
;Case 26: Set ANSELD.2 On
	bra	SysSelectEnd4
SysSelect4Case27
	movlw	26
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case28
;Case 26: Set ANSELD.2 On
	bsf	ANSELD,2,BANKED
;Case 27: Set ANSELD.3 On
	bra	SysSelectEnd4
SysSelect4Case28
	movlw	27
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case29
;Case 27: Set ANSELD.3 On
	bsf	ANSELD,3,BANKED
;Case 28: Set ANSELD.4 On
	bra	SysSelectEnd4
SysSelect4Case29
	movlw	28
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case30
;Case 28: Set ANSELD.4 On
	bsf	ANSELD,4,BANKED
;Case 29: Set ANSELD.5 On
	bra	SysSelectEnd4
SysSelect4Case30
	movlw	29
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case31
;Case 29: Set ANSELD.5 On
	bsf	ANSELD,5,BANKED
;Case 30: Set ANSELD.6 On
	bra	SysSelectEnd4
SysSelect4Case31
	movlw	30
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case32
;Case 30: Set ANSELD.6 On
	bsf	ANSELD,6,BANKED
;Case 31: Set ANSELD.7 On
	bra	SysSelectEnd4
SysSelect4Case32
	movlw	31
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case33
;Case 31: Set ANSELD.7 On
	bsf	ANSELD,7,BANKED
;Case 32: Set ANSELE.0 On
	bra	SysSelectEnd4
SysSelect4Case33
	movlw	32
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case34
;Case 32: Set ANSELE.0 On
	bsf	ANSELE,0,BANKED
;Case 33: Set ANSELE.1 On
	bra	SysSelectEnd4
SysSelect4Case34
	movlw	33
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case35
;Case 33: Set ANSELE.1 On
	bsf	ANSELE,1,BANKED
;Case 34: Set ANSELE.2 On
	bra	SysSelectEnd4
SysSelect4Case35
	movlw	34
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd4
;Case 34: Set ANSELE.2 On
	bsf	ANSELE,2,BANKED
;End Select  '*** ANSEL Bits should now be set ***
SysSelectEnd4
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
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
	bcf	ADCON0,ADFM,BANKED
;Set ADFM0 OFF
	bcf	ADCON0,ADFM0,BANKED
;End if
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
	call	Delay_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE,BANKED
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop3
	btfsc	ADCON0,GO_NOT_DONE,BANKED
	bra	SysWaitLoop3
;Switch off A/D
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,BANKED
;ANSELA = 0
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
	movff	ADRESH,READAD
;SET ADFM OFF
	bcf	ADCON0,ADFM,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (2388)
FN_READAD1048
;Always RIGHT justified
;SET ADFM ON
	banksel	ADCON0
	bsf	ADCON0,ADFM,BANKED
;ADPCH = ADReadPort
	movff	ADREADPORT,ADPCH
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (577)
;Configure ANSELA/B/C/D @DebugADC_H
;Select Case ADReadPort
;Case 0: Set ANSELA.0 On
SysSelect5Case1
	movf	ADREADPORT,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case2
;Case 0: Set ANSELA.0 On
	bsf	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	bra	SysSelectEnd5
SysSelect5Case2
	decf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case3
;Case 1: Set ANSELA.1 On
	bsf	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	bra	SysSelectEnd5
SysSelect5Case3
	movlw	2
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case4
;Case 2: Set ANSELA.2 On
	bsf	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	bra	SysSelectEnd5
SysSelect5Case4
	movlw	3
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case5
;Case 3: Set ANSELA.3 On
	bsf	ANSELA,3,BANKED
;Case 4: Set ANSELA.4 ON
	bra	SysSelectEnd5
SysSelect5Case5
	movlw	4
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case6
;Case 4: Set ANSELA.4 ON
	bsf	ANSELA,4,BANKED
;Case 5: Set ANSELA.5 On
	bra	SysSelectEnd5
SysSelect5Case6
	movlw	5
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case7
;Case 5: Set ANSELA.5 On
	bsf	ANSELA,5,BANKED
;Case 6: Set ANSELA.6 On
	bra	SysSelectEnd5
SysSelect5Case7
	movlw	6
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case8
;Case 6: Set ANSELA.6 On
	bsf	ANSELA,6,BANKED
;Case 7: Set ANSELA.7 On
	bra	SysSelectEnd5
SysSelect5Case8
	movlw	7
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case9
;Case 7: Set ANSELA.7 On
	bsf	ANSELA,7,BANKED
;Case 8: Set ANSELB.0 On
	bra	SysSelectEnd5
SysSelect5Case9
	movlw	8
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case10
;Case 8: Set ANSELB.0 On
	bsf	ANSELB,0,BANKED
;Case 9: Set ANSELB.1 On
	bra	SysSelectEnd5
SysSelect5Case10
	movlw	9
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case11
;Case 9: Set ANSELB.1 On
	bsf	ANSELB,1,BANKED
;Case 10: Set ANSELB.2 On
	bra	SysSelectEnd5
SysSelect5Case11
	movlw	10
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case12
;Case 10: Set ANSELB.2 On
	bsf	ANSELB,2,BANKED
;Case 11: Set ANSELB.3 On
	bra	SysSelectEnd5
SysSelect5Case12
	movlw	11
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case13
;Case 11: Set ANSELB.3 On
	bsf	ANSELB,3,BANKED
;Case 12: Set ANSELB.4 On
	bra	SysSelectEnd5
SysSelect5Case13
	movlw	12
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case14
;Case 12: Set ANSELB.4 On
	bsf	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	bra	SysSelectEnd5
SysSelect5Case14
	movlw	13
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case15
;Case 13: Set ANSELB.5 On
	bsf	ANSELB,5,BANKED
;Case 14: Set ANSELB.6 On
	bra	SysSelectEnd5
SysSelect5Case15
	movlw	14
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case16
;Case 14: Set ANSELB.6 On
	bsf	ANSELB,6,BANKED
;Case 15: Set ANSELB.7 On
	bra	SysSelectEnd5
SysSelect5Case16
	movlw	15
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case17
;Case 15: Set ANSELB.7 On
	bsf	ANSELB,7,BANKED
;Case 16: Set ANSELC.0 On
	bra	SysSelectEnd5
SysSelect5Case17
	movlw	16
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case18
;Case 16: Set ANSELC.0 On
	bsf	ANSELC,0,BANKED
;Case 17: Set ANSELC.1 On
	bra	SysSelectEnd5
SysSelect5Case18
	movlw	17
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case19
;Case 17: Set ANSELC.1 On
	bsf	ANSELC,1,BANKED
;Case 18: Set ANSELC.2 On
	bra	SysSelectEnd5
SysSelect5Case19
	movlw	18
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case20
;Case 18: Set ANSELC.2 On
	bsf	ANSELC,2,BANKED
;Case 19: Set ANSELC.3 On
	bra	SysSelectEnd5
SysSelect5Case20
	movlw	19
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case21
;Case 19: Set ANSELC.3 On
	bsf	ANSELC,3,BANKED
;Case 20: Set ANSELC.4 On
	bra	SysSelectEnd5
SysSelect5Case21
	movlw	20
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case22
;Case 20: Set ANSELC.4 On
	bsf	ANSELC,4,BANKED
;Case 21: Set ANSELC.5 On
	bra	SysSelectEnd5
SysSelect5Case22
	movlw	21
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case23
;Case 21: Set ANSELC.5 On
	bsf	ANSELC,5,BANKED
;Case 22: Set ANSELC.6 On
	bra	SysSelectEnd5
SysSelect5Case23
	movlw	22
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case24
;Case 22: Set ANSELC.6 On
	bsf	ANSELC,6,BANKED
;Case 23: Set ANSELC.7 On
	bra	SysSelectEnd5
SysSelect5Case24
	movlw	23
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case25
;Case 23: Set ANSELC.7 On
	bsf	ANSELC,7,BANKED
;Case 24: Set ANSELD.0 On
	bra	SysSelectEnd5
SysSelect5Case25
	movlw	24
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case26
;Case 24: Set ANSELD.0 On
	bsf	ANSELD,0,BANKED
;Case 25: Set ANSELD.1 On
	bra	SysSelectEnd5
SysSelect5Case26
	movlw	25
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case27
;Case 25: Set ANSELD.1 On
	bsf	ANSELD,1,BANKED
;Case 26: Set ANSELD.2 On
	bra	SysSelectEnd5
SysSelect5Case27
	movlw	26
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case28
;Case 26: Set ANSELD.2 On
	bsf	ANSELD,2,BANKED
;Case 27: Set ANSELD.3 On
	bra	SysSelectEnd5
SysSelect5Case28
	movlw	27
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case29
;Case 27: Set ANSELD.3 On
	bsf	ANSELD,3,BANKED
;Case 28: Set ANSELD.4 On
	bra	SysSelectEnd5
SysSelect5Case29
	movlw	28
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case30
;Case 28: Set ANSELD.4 On
	bsf	ANSELD,4,BANKED
;Case 29: Set ANSELD.5 On
	bra	SysSelectEnd5
SysSelect5Case30
	movlw	29
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case31
;Case 29: Set ANSELD.5 On
	bsf	ANSELD,5,BANKED
;Case 30: Set ANSELD.6 On
	bra	SysSelectEnd5
SysSelect5Case31
	movlw	30
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case32
;Case 30: Set ANSELD.6 On
	bsf	ANSELD,6,BANKED
;Case 31: Set ANSELD.7 On
	bra	SysSelectEnd5
SysSelect5Case32
	movlw	31
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case33
;Case 31: Set ANSELD.7 On
	bsf	ANSELD,7,BANKED
;Case 32: Set ANSELE.0 On
	bra	SysSelectEnd5
SysSelect5Case33
	movlw	32
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case34
;Case 32: Set ANSELE.0 On
	bsf	ANSELE,0,BANKED
;Case 33: Set ANSELE.1 On
	bra	SysSelectEnd5
SysSelect5Case34
	movlw	33
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case35
;Case 33: Set ANSELE.1 On
	bsf	ANSELE,1,BANKED
;Case 34: Set ANSELE.2 On
	bra	SysSelectEnd5
SysSelect5Case35
	movlw	34
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd5
;Case 34: Set ANSELE.2 On
	bsf	ANSELE,2,BANKED
;End Select  '*** ANSEL Bits should now be set ***
SysSelectEnd5
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
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
	bsf	ADCON0,ADFM,BANKED
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
	call	Delay_10US
;Read A/D @1
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE,BANKED
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop4
	btfsc	ADCON0,GO_NOT_DONE,BANKED
	bra	SysWaitLoop4
;Switch off A/D
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,BANKED
;ANSELA = 0
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;ANSELD = 0
	clrf	ANSELD,BANKED
;ANSELE = 0
	clrf	ANSELE,BANKED
;Write output
;ReadAD10 = ADRESL
	movff	ADRESL,READAD10
	banksel	READAD10_H
	clrf	READAD10_H,BANKED
;ReadAD10_H = ADRESH
	movff	ADRESH,READAD10_H
;Put A/D format back to normal
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM,BANKED
	banksel	0
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (353)
ROTATELEDS
;
;LEDs D2, D3, D4 and D5 light up in turn every 500 milliseconds. Once D5 is lit, D2 lights up and the
;pattern repeats. The LCD displays “Rotate” on the first line and “LED_Dx = ON” on the second line,
;where x indicates which LED is currently lit
;
;Dim LEDState as Byte
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF13
;HserPrint Str(labNumber) + ": RotateLEDs Lab"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	rcall	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable13
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable13
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable13
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Begin with LED_D2 high
;PORTB = ( PORTB AND 0xF0 ) OR 0x01
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	1
	iorwf	SysTemp1,W,BANKED
	movwf	PORTB,ACCESS
;LED_D2 = 1
	bsf	LATB,0,ACCESS
;activeLedNum = 1
	movlw	1
	movwf	ACTIVELEDNUM,ACCESS
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "     Rotate     "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable14
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable14
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable14
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	rcall	PRINT157
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;end if
ENDIF13
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF14
;Use delay to keep LED ON for 0.5s, or, fast exit if button pushed
;repeat 10
	movlw	10
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
;wait 50 ms
	movlw	50
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;checkButtonS2
	call	CHECKBUTTONS2
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Repeat
	bra	SysRepeatLoopEnd1
;End If
;end repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;Rotate LEDs: Get the bits with the LEDs
;LEDState = PORTB AND 0x0F
	movlw	15
	andwf	PORTB,W,ACCESS
	movwf	LEDSTATE,ACCESS
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate LEDState Left
	rlcf	LEDSTATE,F,ACCESS
;Set the bits with the LEDs leaving the upper bits as-was.
;LATB = ( PORTB AND 0xF0 ) OR LEDState
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	LEDSTATE,W,ACCESS
	movwf	LATB,ACCESS
;activeLedNum++
	incf	ACTIVELEDNUM,F,ACCESS
;If the last LED (D5) is lit, go back to the first LED (D2)
;if activeLedNum > 4 then
	movf	ACTIVELEDNUM,W,ACCESS
	sublw	4
	btfsc	STATUS, C,ACCESS
	bra	ENDIF17
;LED_D2 = 1
	bsf	LATB,0,ACCESS
;activeLedNum = 1
	movlw	1
	movwf	ACTIVELEDNUM,ACCESS
;end if
ENDIF17
;Display which LED is ON on the LCD
;Locate 1, 0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "  LED_D  = ON   "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable15
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;Locate 1,7
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	7
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
;Show the correct LED number
;Print activeLedNum + 1
	incf	ACTIVELEDNUM,W,ACCESS
	movwf	LCDVALUE,ACCESS
	rcall	PRINT158
;end if
ENDIF14
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:integer:, Source: stdbasic.h (266)
FN_SCALE117
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	movf	L_FROMLOW,W,ACCESS
	subwf	L_MAP,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	L_FROMLOW_H,W,ACCESS
	subwfb	L_MAP_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movf	L_TOLOW,W,ACCESS
	subwf	L_TOHIGH,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	L_TOLOW_H,W,ACCESS
	subwfb	L_TOHIGH_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movff	SYSTEMP2,SysLONGTempA
	movff	SYSTEMP2_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	SYSTEMP1,SysLONGTempB
	movff	SYSTEMP1_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSMULTSUB32
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
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movf	L_TOLOW_H,W,ACCESS
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

;Overloaded signature: BYTE:WORD:, Source: timer.h (1181)
SETTIMER228
;If TMRNumber = 0 Then
	movf	TMRNUMBER,F,BANKED
	btfsc	STATUS, Z,ACCESS
;Handle chips with TMR0H
;Use default 8-bit mode therefore _TMR0_16BIT_ not defined
;Added to resolve using 8bit Timer0 with enhance timer
;High byte is timer0 register of interest
;TMR0H = TMRValue_H
	movff	TMRVALUE_H,TMR0H
;End If
;If TMRNumber = 1 then
	decf	TMRNUMBER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF231
;TMR1H = TMRValue_H
	movff	TMRVALUE_H,TMR1H
;TMR1L = TMRValue
	movff	TMRVALUE,TMR1L
;End If
ENDIF231
;If TMRNumber = 2 Then
	movlw	2
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;TMR2 = TMRValue
	movff	TMRVALUE,TMR2
;End If
;If TMRNumber = 3 then
	movlw	3
	subwf	TMRNUMBER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF233
;TMR3H = TMRValue_H
	movff	TMRVALUE_H,TMR3H
;TMR3L = TMRValue
	movff	TMRVALUE,TMR3L
;End If
ENDIF233
;If TMRNumber = 4 Then
	movlw	4
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;TMR4 = TMRValue
	movff	TMRVALUE,TMR4
;End If
;If TMRNumber = 5 then
	movlw	5
	subwf	TMRNUMBER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF235
;TMR5H = TMRValue_H
	movff	TMRVALUE_H,TMR5H
;TMR5L = TMRValue
	movff	TMRVALUE,TMR5L
;End If
ENDIF235
;If TMRNumber = 6 Then
	movlw	6
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;TMR6 = TMRValue
	movff	TMRVALUE,TMR6
;End If
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (885)
SLEEPWAKEUP
;
;Upon entering this lab, a countdown timer will be displayed on the LCD and the device will be put
;into Sleep after 5 seconds. The device will then wake up after 8 seconds and the LCD will display
;“I’m now awake!” on the second line.
;
;This uses the CONFIGuration of the microcontroller to control the Watch Dog Timer ( WDT).
;
;Dim wdtTimer, counterloop as Byte
;Dim OSCState as Byte Alias counterloop
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF56
;HserPrint Str(labNumber) + ": SleepWakeUp Lab"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	rcall	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	rcall	SYSCOPYSTRINGPART
	movlw	low StringTable38
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable38
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable38
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;LEDS_OFF
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
;Turn LED on
;LED_D5 = 1
	bsf	LATB,3,ACCESS
;Print " Sleep/Wake Up  "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable39
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable39
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable39
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;wdtTimer = COUNTDOWN_MAX
	movlw	5
	movwf	WDTTIMER,BANKED
;for counterloop = 0 to COUNTDOWN_MAX - 1
;Legacy method
	setf	COUNTERLOOP,ACCESS
SysForLoop1
	incf	COUNTERLOOP,F,ACCESS
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print " Sleeping in    "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable40
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable40
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable40
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;Locate 1,13
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	13
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print wdtTimer
	movff	WDTTIMER,LCDVALUE
	call	PRINT158
;wdtTimer--
	decf	WDTTIMER,F,BANKED
;Permits exiting by pressing S2
;Repeat 100   // wait 1 s 100ms * 10
	movlw	100
	movwf	SysRepeatTemp3,BANKED
SysRepeatLoop3
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;checkButtonS2
	call	CHECKBUTTONS2
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF60
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "             "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable41
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable41
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable41
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*13
	call	PRINT157
;Exit Sub
	return
;End If
ENDIF60
;End Repeat
	decfsz	SysRepeatTemp3,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;next
	movff	COUNTERLOOP,SysBYTETempA
	movlw	4
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "Wait for 8 secs "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable42
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;WDR enable
;SWDTEN = 1
	banksel	WDTCON0
	bsf	WDTCON0,SWDTEN,BANKED
;Switch back to external clock after sleeping
;OSCState = OSCCON1
	movff	OSCCON1,OSCSTATE
;SLEEP
	sleep
;Restore operational state
;OSCFIF = 0
	bcf	PIR1,OSCFIF,BANKED
;OSCCON1 = OSCState
	movff	OSCSTATE,OSCCON1
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;end if
ENDIF56
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF57
;Wait for 8s for the WDT time-out; and the LED will toggle
;LED_D5 = 0
	bcf	LATB,3,ACCESS
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	banksel	0
	call	LOCATE
;Print " I'm now awake! "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable43
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable43
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable43
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;Disable WDT
;SWDTEN = 0
	banksel	WDTCON0
	bcf	WDTCON0,SWDTEN,BANKED
;end if
ENDIF57
;if switchEvent = 1 Then
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
	return

;********************************************************************************

SOUNDPLAYNOTENUMBERS
	movlw	8
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLESOUNDPLAYNOTENUMBERS
	movwf	TBLPTRL,ACCESS
	movlw	high TABLESOUNDPLAYNOTENUMBERS
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLESOUNDPLAYNOTENUMBERS
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLESOUNDPLAYNOTENUMBERS
	db	7,10,12,1,3,5,6,8

;********************************************************************************

SOUNDPLAYNOTEPERIODS
	movlw	61
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TABLESOUNDPLAYNOTEPERIODS
	movwf	TBLPTRL,ACCESS
	movlw	high TABLESOUNDPLAYNOTEPERIODS
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TABLESOUNDPLAYNOTEPERIODS
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TABLESOUNDPLAYNOTEPERIODS
	db	60,191,180,170,161,152,143,135,128,120,114,107,101,96,90,85,80,76,72,68,64,60
	db	57,54,51,48,45,43,40,38,36,34,32,30,28,27,25,24,23,21,20,19,18,17,16,15,14,13
	db	13,12,11,11,10,9,9,8,8,8,7,7,6

;********************************************************************************

;Source: songplay.h (391)
SOUNDPLAYTONE
;Rest?
;If SoundPlayNote = 0 Then
	movf	SOUNDPLAYNOTE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE166_1
;Rest for SoundPlayNoteLen
;Tempo is number of L4s/min
;Each L4 is 60000 / tempo long
;Delay in ms = 60000 / tempo / 4 / length
;120 L4s/min = 2 L4s/sec, so 1 L4 = 0.5 s. 1 L2 = 1 s, 1 L1 = 2 s
;Delay = 2000 / NoteLen (for tempo 120)
;Delay = 2000 * 120 / Tempo / NoteLen
;Delay = 60000 / Tempo * 4 / NoteLen
;Wait 60000 / SoundPlayTempo * 4 / SoundPlayNoteLen ms
	movlw	96
	movwf	SysWORDTempA,ACCESS
	movlw	234
	movwf	SysWORDTempA_H,ACCESS
	movff	SOUNDPLAYTEMPO,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movlw	4
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSMULTSUB16
	movff	SysWORDTempX,SysTemp2
	movff	SysWORDTempX_H,SysTemp2_H
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movff	SOUNDPLAYNOTELEN,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SysWaitTempMS
	movff	SysWORDTempA_H,SysWaitTempMS_H
	call	Delay_MS
;Else
	bra	ENDIF166
ELSE166_1
;Get half period of tone
;First 24 notes have same half period in table as next 24
;SoundPlayTemp = SoundPlayNote
	movff	SOUNDPLAYNOTE,SOUNDPLAYTEMP
;If SoundPlayTemp > 24 Then SoundPlayTemp -= 24
	movf	SOUNDPLAYTEMP,W,BANKED
	sublw	24
	btfsc	STATUS, C,ACCESS
	bra	ENDIF167
;If SoundPlayTemp > 24 Then SoundPlayTemp -= 24
	movlw	24
	subwf	SOUNDPLAYTEMP,F,BANKED
;If SoundPlayTemp > 24 Then SoundPlayTemp -= 24
ENDIF167
;ReadTable SoundPlayNotePeriods, SoundPlayTemp, SoundPlayPeriod
	movff	SOUNDPLAYTEMP,SYSSTRINGA
	rcall	SOUNDPLAYNOTEPERIODS
	movwf	SOUNDPLAYPERIOD,BANKED
;Calculate number of cycles
;Example: T120, L4, 1 kHz
;120 L4/min, so total time len = 60 / 120 = 0.5 s
;Cycles = L / T = 0.5 / 0.001 = 500 cycles
;Cycles = 60 / Tempo / Period = 60 / (4 / NoteLen * Tempo) / Period
;Cycles = 240 / NoteLen / Tempo / Period (Ex: 240 / 4 / 120 / 0.001)
;Cycles = 240 / NoteLen / Tempo * Freq (Ex: 240 / 4 / 120 * 1000 = 500)
;Cycles = 240 * Freq / NoteLen / Tempo
;Ranges:
;NoteLen: 1 to 16
;Tempo: 32 to 255
;Period: 6 to 191
;Or, use period
;Cycles = 240 / NoteLen / Tempo / Period (Ex: 240 / 4 / 120 / 0.001)
;Period is multiplied by 12500 for notes <= 24, 5000 for notes >= 25
;For note 34 (440 Hz), need 880 cycles (Whole note, 120 L4/min, note len = 2 s):
;Calculated (half) period for 440 Hz = 114 (20 us units)
;Cycles = 240 / NoteLen / Tempo / Period
;= 240 * 250 / NoteLen / Tempo * 200 / Period
;= 60000 / Tempo * 10 / NoteLen * 20 / Period
;= 60000 / Tempo * 10 / NoteLen * 2 / Period * 10
;Dim SoundPlayCycles As Word
;SoundPlayCycles = 60000 / SoundPlayTempo
	movlw	96
	movwf	SysWORDTempA,ACCESS
	movlw	234
	movwf	SysWORDTempA_H,ACCESS
	movff	SOUNDPLAYTEMPO,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SOUNDPLAYCYCLES
	movff	SysWORDTempA_H,SOUNDPLAYCYCLES_H
;If SoundPlayNote > 24 Then
	movf	SOUNDPLAYNOTE,W,BANKED
	sublw	24
	btfsc	STATUS, C,ACCESS
	bra	ELSE168_1
;Each loop takes 2 * SoundPlayPeriod * 10 us.
;Each note should take 60000 / Tempo * 4 / NoteLen
;Loops needed: time needed / loop time
;Cycles = (60000 / Tempo * 4 / NoteLen) / (2 * SoundPlayPeriod * 0.01)
;Cycles = 60000 / Tempo * 4 / NoteLen / 2 / SoundPlayPeriod / 0.01
;Cycles = 60000 / Tempo * 4 / NoteLen / 2 / SoundPlayPeriod * 100
;SoundPlayCycles = SoundPlayCycles * 20 / SoundPlayNoteLen / SoundPlayPeriod * 10
	movff	SOUNDPLAYCYCLES,SysWORDTempA
	movff	SOUNDPLAYCYCLES_H,SysWORDTempA_H
	movlw	20
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSMULTSUB16
	movff	SysWORDTempX,SysTemp2
	movff	SysWORDTempX_H,SysTemp2_H
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movff	SOUNDPLAYNOTELEN,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movff	SOUNDPLAYPERIOD,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp2
	movff	SysWORDTempA_H,SysTemp2_H
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSMULTSUB16
	movff	SysWORDTempX,SOUNDPLAYCYCLES
	movff	SysWORDTempX_H,SOUNDPLAYCYCLES_H
;Else
	bra	ENDIF168
ELSE168_1
;SoundPlayCycles = SoundPlayCycles * 5 / SoundPlayNoteLen / SoundPlayPeriod * 10
	movff	SOUNDPLAYCYCLES,SysWORDTempA
	movff	SOUNDPLAYCYCLES_H,SysWORDTempA_H
	movlw	5
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSMULTSUB16
	movff	SysWORDTempX,SysTemp2
	movff	SysWORDTempX_H,SysTemp2_H
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movff	SOUNDPLAYNOTELEN,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movff	SOUNDPLAYPERIOD,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SysTemp2
	movff	SysWORDTempA_H,SysTemp2_H
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSMULTSUB16
	movff	SysWORDTempX,SOUNDPLAYCYCLES
	movff	SysWORDTempX_H,SOUNDPLAYCYCLES_H
;End If
ENDIF168
;Use high or low frequency?
;If SoundPlayNote <= 24 Then
	movf	SOUNDPLAYNOTE,W,BANKED
	sublw	24
	btfss	STATUS, C,ACCESS
	bra	ELSE169_1
;Low when tone <= 24 (T = 40 us units)
;Repeat SoundPlayCycles
	movff	SOUNDPLAYCYCLES,SysRepeatTemp5
	movff	SOUNDPLAYCYCLES_H,SysRepeatTemp5_H
	movff	SYSREPEATTEMP5,SysWORDTempA
	movff	SYSREPEATTEMP5_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysRepeatLoopEnd5
	movf	SYSREPEATTEMP5,F,BANKED
	btfss	STATUS, Z,ACCESS
	incf	SysRepeatTemp5_H,F,BANKED
SysRepeatLoop5
;Set SOUNDOUT On
	bsf	LATC,2,ACCESS
;Repeat SoundPlayPeriod
	movff	SOUNDPLAYPERIOD,SysRepeatTemp6
	movf	SYSREPEATTEMP6,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd6
SysRepeatLoop6
;Wait 40 us
	movlw	213
	movwf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
;End Repeat
	decfsz	SysRepeatTemp6,F,BANKED
	bra	SysRepeatLoop6
SysRepeatLoopEnd6
;Set SOUNDOUT Off
	bcf	LATC,2,ACCESS
;Repeat SoundPlayPeriod
	movff	SOUNDPLAYPERIOD,SysRepeatTemp6
	movf	SYSREPEATTEMP6,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd7
SysRepeatLoop7
;Wait 40 us
	movlw	213
	movwf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
;End Repeat
	decfsz	SysRepeatTemp6,F,BANKED
	bra	SysRepeatLoop7
SysRepeatLoopEnd7
;End Repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop5
	decfsz	SysRepeatTemp5_H,F,BANKED
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
;Else
	bra	ENDIF169
ELSE169_1
;High when tone >= 25 (T = 10 us units)
;Repeat SoundPlayCycles
	movff	SOUNDPLAYCYCLES,SysRepeatTemp5
	movff	SOUNDPLAYCYCLES_H,SysRepeatTemp5_H
	movff	SYSREPEATTEMP5,SysWORDTempA
	movff	SYSREPEATTEMP5_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysRepeatLoopEnd8
	movf	SYSREPEATTEMP5,F,BANKED
	btfss	STATUS, Z,ACCESS
	incf	SysRepeatTemp5_H,F,BANKED
SysRepeatLoop8
;PulseOut SOUNDOUT, SoundPlayPeriod 10us
;Macro Source: stdbasic.h (188)
;Set Pin On
	bsf	LATC,2,ACCESS
;WaitL1 Time
	movff	SOUNDPLAYPERIOD,SysWaitTemp10US
	call	Delay_10US
;Set Pin Off
	bcf	LATC,2,ACCESS
;Wait SoundPlayPeriod 10us
	movff	SOUNDPLAYPERIOD,SysWaitTemp10US
	call	Delay_10US
;End Repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop8
	decfsz	SysRepeatTemp5_H,F,BANKED
	bra	SysRepeatLoop8
SysRepeatLoopEnd8
;End If
ENDIF169
;End If
ENDIF166
	return

;********************************************************************************

;Source: timer.h (829)
STARTTIMER
;IF TMRNumber = 0 then Set T0EN on
	movf	TMRNUMBER,F,BANKED
	btfsc	STATUS, Z,ACCESS
;IF TMRNumber = 0 then Set T0EN on
	bsf	T0CON0,T0EN,ACCESS
;IF TMRNumber = 0 then Set T0EN on
;IF TMRNumber = 1 then Set TMR1ON on
	decf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;IF TMRNumber = 1 then Set TMR1ON on
	bsf	T1CON,TMR1ON,ACCESS
;IF TMRNumber = 1 then Set TMR1ON on
;IF TMRNumber = 2 then Set TMR2ON on
	movlw	2
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;IF TMRNumber = 2 then Set TMR2ON on
	bsf	T2CON,TMR2ON,ACCESS
;IF TMRNumber = 2 then Set TMR2ON on
;IF TMRNumber = 3 then Set TMR3ON on
	movlw	3
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;IF TMRNumber = 3 then Set TMR3ON on
	bsf	T3CON,TMR3ON,ACCESS
;IF TMRNumber = 3 then Set TMR3ON on
;IF TMRNumber = 4 then Set TMR4ON on
	movlw	4
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;IF TMRNumber = 4 then Set TMR4ON on
	bsf	T4CON,TMR4ON,ACCESS
;IF TMRNumber = 4 then Set TMR4ON on
;IF TMRNumber = 5 then Set TMR5ON on
	movlw	5
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;IF TMRNumber = 5 then Set TMR5ON on
	bsf	T5CON,TMR5ON,ACCESS
;IF TMRNumber = 5 then Set TMR5ON on
;IF TMRNumber = 6 then Set TMR6ON on
	movlw	6
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;IF TMRNumber = 6 then Set TMR6ON on
	bsf	T6CON,TMR6ON,ACCESS
;IF TMRNumber = 6 then Set TMR6ON on
	return

;********************************************************************************

;Source: timer.h (1365)
STOPTIMER
;Timer 0 always runs
;Note: Not Always!  Timer 0 on 18F Can be stopped/started
;If TMRNumber = 0 Then Set T0EN off
	movf	TMRNUMBER,F,BANKED
	btfsc	STATUS, Z,ACCESS
;If TMRNumber = 0 Then Set T0EN off
	bcf	T0CON0,T0EN,ACCESS
;If TMRNumber = 0 Then Set T0EN off
;If TMRNumber = 1 Then Set TMR1ON OFF
	decf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;If TMRNumber = 1 Then Set TMR1ON OFF
	bcf	T1CON,TMR1ON,ACCESS
;If TMRNumber = 1 Then Set TMR1ON OFF
;If TMRNumber = 2 Then Set TMR2ON OFF
	movlw	2
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;If TMRNumber = 2 Then Set TMR2ON OFF
	bcf	T2CON,TMR2ON,ACCESS
;If TMRNumber = 2 Then Set TMR2ON OFF
;If TMRNumber = 3 Then Set TMR3ON OFF
	movlw	3
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;If TMRNumber = 3 Then Set TMR3ON OFF
	bcf	T3CON,TMR3ON,ACCESS
;If TMRNumber = 3 Then Set TMR3ON OFF
;If TMRNumber = 4 Then Set TMR4ON OFF
	movlw	4
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;If TMRNumber = 4 Then Set TMR4ON OFF
	bcf	T4CON,TMR4ON,ACCESS
;If TMRNumber = 4 Then Set TMR4ON OFF
;If TMRNumber = 5 Then Set TMR5ON OFF
	movlw	5
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;If TMRNumber = 5 Then Set TMR5ON OFF
	bcf	T5CON,TMR5ON,ACCESS
;If TMRNumber = 5 Then Set TMR5ON OFF
;If TMRNumber = 6 Then Set TMR6ON OFF
	movlw	6
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
;If TMRNumber = 6 Then Set TMR6ON OFF
	bcf	T6CON,TMR6ON,ACCESS
;If TMRNumber = 6 Then Set TMR6ON OFF
	return

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
	bra	ENDIF268
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
ENDIF268
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
	bra	ENDIF269
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
ENDIF269
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
	bra	ENDIF270
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
ENDIF270
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
	bra	ENDIF271
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
ENDIF271
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
	movff	SYSCHARCOUNT,SYSSTR_0
	return

;********************************************************************************

;Source: system.h (4051)
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

;Source: system.h (4077)
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

;Source: system.h (4131)
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

;Source: system.h (4441)
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

;Source: system.h (4471)
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

;Source: system.h (4529)
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

;Source: system.h (4909)
SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ELSE257_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF258
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	return
;End If
ENDIF258
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
	bra	ENDIF257
ELSE257_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	return
;End If
;End If
ENDIF257
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

;Source: system.h (1706)
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

;Source: system.h (3377)
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

;Source: system.h (3445)
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
	bra	ENDIF253
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF253
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
	bra	ENDIF254
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF254
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

;Source: system.h (3521)
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
	bra	ENDIF255
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF255
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
	bra	ENDIF256
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
ENDIF256
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

;Source: system.h (2911)
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
	movff	PRODL, SYSWORDTEMPX
;movff PRODH, SysWordTempX_H
	movff	PRODH, SYSWORDTEMPX_H
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

;Source: system.h (3028)
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
	bra	ENDIF251
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
ENDIF251
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

;Source: system.h (1903)
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
	db	24,87,101,108,99,111,109,101,32,116,111,32,80,73,67,68,69,77,32,50,32,80,108,117
	db	115


StringTable2
	db	24,71,67,66,65,83,73,67,32,45,32,65,110,111,98,105,117,109,32,32,32,50,48,50,52


StringTable3
	db	16,32,32,32,32,87,101,108,99,111,109,101,32,32,32,32,32


StringTable4
	db	16,116,111,32,80,73,67,68,69,77,32,50,32,80,108,117,115


StringTable5
	db	16,32,32,32,32,71,67,66,65,83,73,67,32,32,32,32,32


StringTable6
	db	16,32,65,110,111,98,105,117,109,32,32,32,50,48,50,52,32


StringTable7
	db	17,58,32,72,101,108,108,111,32,87,111,114,108,100,32,76,97,98


StringTable8
	db	16,32,32,72,101,108,108,111,32,87,111,114,108,100,32,32,32


StringTable9
	db	16,32,32,76,69,68,95,68,53,32,61,32,79,78,32,32,32


StringTable10
	db	11,58,32,66,108,105,110,107,32,76,97,98


StringTable11
	db	16,32,32,32,32,32,66,108,105,110,107,32,32,32,32,32,32


StringTable12
	db	17,32,32,76,69,68,95,68,53,32,61,32,79,70,70,32,32,32


StringTable13
	db	16,58,32,82,111,116,97,116,101,76,69,68,115,32,76,97,98


StringTable14
	db	16,32,32,32,32,32,82,111,116,97,116,101,32,32,32,32,32


StringTable15
	db	16,32,32,76,69,68,95,68,32,32,61,32,79,78,32,32,32


StringTable16
	db	9,58,32,65,68,67,32,76,97,98


StringTable17
	db	15,32,32,32,32,32,32,65,68,67,32,32,32,32,32,32


StringTable18
	db	16,32,65,68,67,32,82,101,115,117,108,116,32,61,32,32,32


StringTable19
	db	1,32


StringTable20
	db	9,58,32,86,83,82,32,76,97,98


StringTable21
	db	16,32,32,32,32,32,32,86,83,82,32,32,32,32,32,32,32


StringTable22
	db	16,32,68,101,108,97,121,32,61,32,32,32,32,32,109,115,32


StringTable23
	db	14,58,32,68,101,98,111,117,110,99,101,32,76,97,98


StringTable24
	db	16,32,32,32,32,68,101,98,111,117,110,99,101,32,32,32,32


StringTable25
	db	16,32,32,32,32,80,114,101,115,115,32,83,51,32,32,32,32


StringTable26
	db	9,58,32,80,87,77,32,76,97,98


StringTable27
	db	15,32,32,32,32,32,32,80,87,77,32,32,32,32,32,32


StringTable28
	db	16,68,117,116,121,32,67,121,99,108,101,32,32,32,32,48,37


StringTable29
	db	16,68,117,116,121,32,67,121,99,108,101,32,32,32,32,32,37


StringTable30
	db	12,58,32,84,105,109,101,114,49,32,76,97,98


StringTable31
	db	15,32,32,32,32,84,105,109,101,114,32,49,32,32,32,32


StringTable32
	db	16,32,32,83,116,97,114,116,32,84,105,109,101,114,32,32,32


StringTable33
	db	15,84,105,109,101,32,61,32,32,32,32,32,115,101,99,115


StringTable34
	db	15,58,32,73,110,116,101,114,114,117,112,116,32,76,97,98


StringTable35
	db	16,32,32,32,73,110,116,101,114,114,117,112,116,32,32,32,32


StringTable36
	db	16,68,105,114,101,99,116,105,111,110,58,32,82,105,103,104,116


StringTable37
	db	16,68,105,114,101,99,116,105,111,110,58,32,76,101,102,116,32


StringTable38
	db	17,58,32,83,108,101,101,112,87,97,107,101,85,112,32,76,97,98


StringTable39
	db	16,32,83,108,101,101,112,47,87,97,107,101,32,85,112,32,32


StringTable40
	db	16,32,83,108,101,101,112,105,110,103,32,105,110,32,32,32,32


StringTable41
	db	13,32,32,32,32,32,32,32,32,32,32,32,32,32


StringTable42
	db	16,87,97,105,116,32,102,111,114,32,56,32,115,101,99,115,32


StringTable43
	db	16,32,73,39,109,32,110,111,119,32,97,119,97,107,101,33,32


StringTable44
	db	12,58,32,69,69,80,82,79,77,32,76,97,98


StringTable45
	db	19,32,32,32,32,32,69,69,80,82,79,77,32,32,32,32,32,32,32,32


StringTable46
	db	8,69,69,80,82,79,77,32,64


StringTable47
	db	8,84,105,99,107,32,32,32,32


StringTable48
	db	9,32,32,32,32,84,105,99,107,32


StringTable49
	db	8,84,111,99,107,32,32,32,32


StringTable50
	db	9,32,32,32,32,84,111,99,107,32


StringTable51
	db	16,32,32,32,32,32,76,67,68,32,32,32,32,32,32,32,32


StringTable52
	db	9,58,32,76,67,68,32,76,97,98


StringTable53
	db	10,83,84,65,82,84,32,84,69,83,84


StringTable54
	db	10,68,73,83,80,76,65,89,32,79,78


StringTable55
	db	9,67,117,114,115,111,114,32,79,78


StringTable56
	db	10,67,117,114,115,111,114,32,79,70,70


StringTable57
	db	8,70,76,65,83,72,32,79,78


StringTable58
	db	9,70,76,65,83,72,32,79,70,70


StringTable59
	db	15,67,85,82,83,82,32,38,32,70,76,83,72,32,79,78


StringTable60
	db	16,67,85,82,83,82,32,38,32,70,76,83,72,32,79,70,70


StringTable61
	db	8,70,108,97,115,104,105,110,103


StringTable62
	db	7,68,105,115,112,108,97,121


StringTable63
	db	11,68,73,83,80,76,65,89,32,79,70,70


StringTable64
	db	9,70,79,82,32,53,32,83,69,67


StringTable65
	db	8,69,78,68,32,84,69,83,84


StringTable66
	db	16,58,32,78,86,77,32,77,101,109,111,114,121,32,76,97,98


StringTable67
	db	16,32,32,32,78,86,77,101,109,111,114,121,32,32,32,32,32


StringTable68
	db	16,32,78,86,77,32,82,101,115,117,108,116,32,61,32,32,32


StringTable69
	db	2,48,120


StringTable70
	db	15,58,32,73,50,67,32,68,105,115,99,111,118,101,114,121


StringTable71
	db	16,72,87,32,73,50,67,32,68,105,115,99,111,118,101,114,121


StringTable72
	db	13,32,83,101,101,32,116,101,114,109,105,110,97,108


StringTable73
	db	13,72,97,114,100,119,97,114,101,32,73,50,67,32


StringTable74
	db	3,32,32,32


StringTable75
	db	2,45,45


StringTable76
	db	2,33,32


StringTable77
	db	13,69,110,100,32,111,102,32,83,101,97,114,99,104


StringTable78
	db	17,58,32,73,50,67,32,84,101,109,112,101,114,97,116,117,114,101


StringTable79
	db	11,84,101,109,112,101,114,97,116,117,114,101


StringTable80
	db	1,67


StringTable81
	db	12,58,32,73,50,67,32,69,69,80,82,79,77


StringTable82
	db	10,73,50,67,32,69,69,80,82,79,77


StringTable83
	db	17,32,32,32,32,73,110,105,116,105,97,108,32,65,114,114,97,121


StringTable84
	db	10,32,32,32,32,32,32,32,32,45,58


StringTable85
	db	1,44


StringTable86
	db	78,32,32,32,32,82,101,112,111,112,117,108,97,116,101,32,65,114,114,97,121,32
	db	119,105,116,104,32,35,49,50,55,32,116,111,32,101,110,115,117,114,101,32,116,104
	db	101,32,69,69,80,82,79,77,32,114,101,115,117,108,116,115,32,97,114,101,32,114
	db	101,97,100,32,99,111,114,114,101,99,116,108,121


StringTable87
	db	34,32,32,32,32,82,101,97,100,32,65,114,114,97,121,32,102,114,111,109,32,69,69,80
	db	114,111,109,32,114,101,115,117,108,116,115


StringTable88
	db	27,32,32,32,32,69,110,100,32,111,102,32,97,114,114,97,121,32,111,112,101,114,97,116
	db	105,111,110,115


StringTable89
	db	17,69,69,80,82,79,77,32,114,101,97,100,32,101,114,114,111,114


StringTable90
	db	14,69,69,80,82,79,77,32,114,101,97,100,32,79,75


StringTable91
	db	7,58,32,67,76,79,67,75


StringTable92
	db	13,67,76,79,67,75,32,82,85,78,78,73,78,71


StringTable93
	db	8,58,32,66,117,122,122,101,114


StringTable94
	db	11,32,32,66,117,122,122,101,114,32,32,32


StringTable95
	db	86,84,104,101,103,111,111,100,44,58,100,61,52,44,111,61,54,44,98,61,54,51,58,51
	db	50,99,44,51,50,102,44,51,50,99,44,51,50,102,44,99,44,56,103,95,53,44,56,97,95,53
	db	44,102,53,44,56,112,44,51,50,99,44,51,50,102,44,51,50,99,44,51,50,102,44,99,44,56
	db	103,95,53,44,56,97,95,53,44,100,95


StringTable96
	db	1,97


StringTable97
	db	1,122


StringTable98
	db	1,65


StringTable107
	db	1,48


StringTable108
	db	1,57


StringTable109
	db	1,35


StringTable112
	db	1,46


StringTable113
	db	1,58


StringTable114
	db	1,90


StringTable115
	db	1,100


StringTable116
	db	1,111


StringTable117
	db	1,98


StringTable118
	db	1,112


StringTable167
	db	0


;********************************************************************************

;Source: 20_Capability_demo.gcb (699)
TIMER_1
;
;LEDs D2, D4 and D5 light in turn every 500 milliseconds. Once D5 is lit, D2 lights up and the pattern
;repeats. The LCD displays “TIMER1” on the first line and “Time = xxx secs” on the second line
;where xxx indicates a value between 0 and 100 corresponding to the time since TIMER1 started
;incrementing. A 1-second increment is equivalent to two LED shifts. When the display reaches 100,
;it will reset to 0 and the counting goes on.
;
;Dim LEDState
;Dim adcResult as Word
;Dim flagCounter, timeCount, shiftCounter as Byte
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF36
;HserPrint Str(labNumber) + ": Timer1 Lab"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable30
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable30
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable30
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Begin with LED_D2 high
;PORTB = ( PORTB AND 0xF0 ) OR 0x01
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	1
	iorwf	SysTemp1,W,BANKED
	movwf	PORTB,ACCESS
;LED_D2 = 1
	bsf	LATB,0,ACCESS
;activeLedNum = 1
	movlw	1
	movwf	ACTIVELEDNUM,ACCESS
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "    Timer 1    "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable31
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable31
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable31
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*15
	call	PRINT157
;Locate 1,0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "  Start Timer   "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable32
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable32
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable32
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;flagCounter = 0
	clrf	FLAGCOUNTER,ACCESS
;timeCount = 0
	clrf	TIMECOUNT,BANKED
;shiftCounter = 0
	clrf	SHIFTCOUNTER,BANKED
;wait 100 ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;InitTimer1 OSC, PS1_8
	movlw	1
	movwf	TMRSOURCE,BANKED
	movlw	48
	movwf	TMRPRES,BANKED
	call	INITTIMER1
;SetTimer 1, 0x0BDC
	movlw	1
	movwf	TMRNUMBER,BANKED
	movlw	220
	movwf	TMRVALUE,BANKED
	movlw	11
	movwf	TMRVALUE_H,BANKED
	call	SETTIMER228
;StartTimer 1
	movlw	1
	movwf	TMRNUMBER,BANKED
	call	STARTTIMER
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;end if
ENDIF36
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF37
;check if  overflow has occurred by checking the TMRIF bit
;if TMR1IF = 1 then
	banksel	PIR4
	btfss	PIR4,TMR1IF,BANKED
	bra	ENDIF39
;Clear the  event flag
;TMR1IF = 0
	bcf	PIR4,TMR1IF,BANKED
;flagCounter++
	incf	FLAGCOUNTER,F,ACCESS
;End If
ENDIF39
;If the second overflow occurs (0.5s delay)
;if flagCounter = FLAG_COUNTER_MAX Then
	movlw	4
	subwf	FLAGCOUNTER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF40
;Rotate LEDs: Get the bits with the LEDs
;LEDState = PORTB AND 0x0F
	movlw	15
	andwf	PORTB,W,ACCESS
	movwf	LEDSTATE,ACCESS
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate LEDState Left
	rlcf	LEDSTATE,F,ACCESS
;Set the bits with the LEDs leaving the upper bits as-was.
;LATB = ( PORTB AND 0xF0 ) OR LEDState
	movlw	240
	andwf	PORTB,W,ACCESS
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	iorwf	LEDSTATE,W,ACCESS
	movwf	LATB,ACCESS
;activeLedNum++
	incf	ACTIVELEDNUM,F,ACCESS
;If the last LED (D5) is lit, go back to the first LED (D2)
;if activeLedNum > 4 then
	movf	ACTIVELEDNUM,W,ACCESS
	sublw	4
	btfsc	STATUS, C,ACCESS
	bra	ENDIF43
;LED_D2 = 1
	bsf	LATB,0,ACCESS
;activeLedNum = 1
	movlw	1
	movwf	ACTIVELEDNUM,ACCESS
;end if
ENDIF43
;flagCounter = 0
	clrf	FLAGCOUNTER,ACCESS
;shiftCounter++
	incf	SHIFTCOUNTER,F,BANKED
;End If
ENDIF40
;if shiftCounter = SHIFT_COUNTER_MAX Then
	movlw	8
	banksel	SHIFTCOUNTER
	subwf	SHIFTCOUNTER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF41
;Display value ON on the LCD
;Locate 1, 0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "Time =     secs"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*15
	call	PRINT157
;Locate 1,7
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	7
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print LeftPad( str(timeCount), 3, " " )
	movff	TIMECOUNT,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	3
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable19
	movwf	TBLPTRU,ACCESS
	rcall	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysSYSINSTRING2Handler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING2Handler_H,BANKED
;Using SYSSTRINGPARAM2*1
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT157
;shiftCounter = 0
	clrf	SHIFTCOUNTER,BANKED
;timeCount++
	incf	TIMECOUNT,F,BANKED
;end if
ENDIF41
;if timeCount > TIME_COUNT_MAX Then
	movf	TIMECOUNT,W,BANKED
	sublw	100
	btfss	STATUS, C,ACCESS
;timeCount = TIME_COUNT_MIN
	clrf	TIMECOUNT,BANKED
;end if
;end if
ENDIF37
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF38
;StopTimer 1
	movlw	1
	movwf	TMRNUMBER,BANKED
	call	STOPTIMER
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
ENDIF38
	return

;********************************************************************************

;Source: 20_Capability_demo.gcb (467)
VSR
;
;Rotate the potentiometer R15 counterclockwise to see the LEDs shift faster. The LCD displays
;“VSR” on the first line and “Delay = xxx ms” on the second line, where xxx indicates the time interval
;between LED shifts.
;
;Dim LEDState
;Dim adcResult as Word
;if labState = NOT_RUNNING Then
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF21
;HserPrint Str(labNumber) + ": VSR Lab"
	movff	LABNUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SYSCOPYSTRINGPART
	movlw	low StringTable20
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable20
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable20
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRINGPART
	lfsr	0,SYSSTRINGPARAM2
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
;Using SYSSTRINGPARAM2*0
	call	HSERPRINT384
;HserPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Begin with LED_D2 high
;PORTB = ( PORTB AND 0xF0 ) OR 0x01
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	1
	iorwf	SysTemp1,W,BANKED
	movwf	PORTB,ACCESS
;LED_D2 = 1
	bsf	LATB,0,ACCESS
;activeLedNum = 1
	movlw	1
	movwf	ACTIVELEDNUM,ACCESS
;Locate 0,0
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print "      VSR       "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable21
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable21
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable21
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;labState = RUNNING
	movlw	1
	movwf	LABSTATE,ACCESS
;end if
ENDIF21
;if labState = RUNNING Then
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF22
;adcResult = ReadAD ( AN0 )
	clrf	ADREADPORT,ACCESS
	call	FN_READAD46
	movff	SYSREADADBYTE,ADCRESULT
	clrf	ADCRESULT_H,ACCESS
;adcResult = Scale ( adcResult, 0, 255,1, 50)
	movff	ADCRESULT,L_MAP
	movff	ADCRESULT_H,L_MAP_H
	clrf	L_FROMLOW,ACCESS
	clrf	L_FROMLOW_H,ACCESS
	setf	L_FROMHIGH,ACCESS
	clrf	L_FROMHIGH_H,ACCESS
	movlw	1
	movwf	L_TOLOW,ACCESS
	clrf	L_TOLOW_H,ACCESS
	movlw	50
	movwf	L_TOHIGH,ACCESS
	clrf	L_TOHIGH_H,ACCESS
	clrf	L_CALIBRATE,ACCESS
	clrf	L_CALIBRATE_H,ACCESS
	call	FN_SCALE117
	movff	SYSSCALEWORD,ADCRESULT
	movff	SYSSCALEWORD_H,ADCRESULT_H
;Use delay to keep D2 ON for 0.5s, or, fast exit if button pushed
;repeat 10
	movlw	10
	movwf	SysRepeatTemp2,BANKED
SysRepeatLoop2
;wait adcresult ms
	movff	ADCRESULT,SysWaitTempMS
	movff	ADCRESULT_H,SysWaitTempMS_H
	call	Delay_MS
;checkButtonS2
	call	CHECKBUTTONS2
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Repeat
	bra	SysRepeatLoopEnd2
;End If
;end repeat
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;Rotate LEDs: Get the bits with the LEDs
;LEDState = PORTB AND 0x0F
	movlw	15
	andwf	PORTB,W,ACCESS
	movwf	LEDSTATE,ACCESS
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate LEDState Left
	rlcf	LEDSTATE,F,ACCESS
;Set the bits with the LEDs leaving the upper bits as-was.
;LATB = ( PORTB AND 0xF0 ) OR LEDState
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	LEDSTATE,W,ACCESS
	movwf	LATB,ACCESS
;activeLedNum++
	incf	ACTIVELEDNUM,F,ACCESS
;If the last LED (D5) is lit, go back to the first LED (D2)
;if activeLedNum > 4 then
	movf	ACTIVELEDNUM,W,ACCESS
	sublw	4
	btfsc	STATUS, C,ACCESS
	bra	ENDIF25
;LED_D2 = 1
	bsf	LATB,0,ACCESS
;activeLedNum = 1
	movlw	1
	movwf	ACTIVELEDNUM,ACCESS
;end if
ENDIF25
;Display value ON on the LCD
;Locate 1, 0
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print " Delay =     ms "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable22
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
;Using SYSSTRINGPARAM2*16
	call	PRINT157
;Locate 1,9
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	9
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
;Print Pad( str(adcresult), 3, " " )
	movff	ADCRESULT,SYSVALTEMP
	movff	ADCRESULT_H,SYSVALTEMP_H
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	3
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable19
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SYSSTRINGPARAM2
	movwf	SysSYSINSTRING3Handler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING3Handler_H,BANKED
;Using SYSSTRINGPARAM2*1
	call	FN_PAD
	movlw	low PAD
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high PAD
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT157
;end if
ENDIF22
;if switchEvent = 1 Then
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
;labState = NOT_RUNNING
	clrf	LABSTATE,ACCESS
;End If
	return

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
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF172
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
ENDIF172
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
SysForLoop10
	incf	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	rrcf	SYSVALTEMP,F,BANKED
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF174
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
ENDIF174
;_HexPICAS(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYS_HEXPICAS_1
	movwf	SYS_HEXPICAS_1,BANKED
	banksel	0
	return

;********************************************************************************

;Source: system.h (5530)
_PFMREADBLOCK
;Dim _PFM_Count as word
;Dim _PFM_LoopCounter as word
;Dim _dummy as byte
;Dim _PFM_ABS_ADDR as Long Alias _dummy, NVMADRU, NVMADRH, NVMADRL
;Dim _TBL_ABS_ADDR as Long Alias _dummy, TBLPTRU, TBLPTRH, TBLPTRL
;Set memory address
;_PFM_ABS_ADDR = _PFM_BlockNum * SAF_ROWSIZE_BYTES
	movff	_PFM_BLOCKNUM,SysLONGTempA
	movff	_PFM_BLOCKNUM_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movlw	128
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSMULTSUB32
	movff	SysLONGTempX,_PFM_ABS_ADDR
	movff	SysLONGTempX_H,_PFM_ABS_ADDR_H
	movff	SysLONGTempX_U,_PFM_ABS_ADDR_U
	movff	SysLONGTempX_E,_PFM_ABS_ADDR_E
;_TBL_ABS_ADDR = _PFM_BlockNum * SAF_ROWSIZE_BYTES
	movff	_PFM_BLOCKNUM,SysLONGTempA
	movff	_PFM_BLOCKNUM_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movlw	128
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSMULTSUB32
	movff	SysLONGTempX,_TBL_ABS_ADDR
	movff	SysLONGTempX_H,_TBL_ABS_ADDR_H
	movff	SysLONGTempX_U,_TBL_ABS_ADDR_U
	movff	SysLONGTempX_E,_TBL_ABS_ADDR_E
;18FxxQ10 type
;NVMEN = 1
	bsf	NVMCON0,NVMEN,ACCESS
;ChipMemorylock = 0xBB
	movlw	187
	movwf	NVMCON2,ACCESS
;ChipMemorylock = 0x44
	movlw	68
	movwf	NVMCON2,ACCESS
;Read memory to buffer
;For _PFM_LoopCounter = 1 to _PFM_Count
;Legacy method
	clrf	_PFM_LOOPCOUNTER,BANKED
	clrf	_PFM_LOOPCOUNTER_H,BANKED
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	movff	_PFM_COUNT,SysWORDTempA
	movff	_PFM_COUNT_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd13
SysForLoop13
	incf	_PFM_LOOPCOUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	_PFM_LOOPCOUNTER_H,F,BANKED
;TBLRD*+
	tblrd*+
;_PFM_Buffer( _PFM_LoopCounter  ) = TABLAT
	movf	_PFM_LOOPCOUNTER,W,BANKED
	addwf	Sys_PFM_BUFFERHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movf	_PFM_LOOPCOUNTER_H,W,BANKED
	addwfc	Sys_PFM_BUFFERHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	TABLAT,INDF0
;next
	movff	_PFM_LOOPCOUNTER,SysWORDTempA
	movff	_PFM_LOOPCOUNTER_H,SysWORDTempA_H
	movff	_PFM_COUNT,SysWORDTempB
	movff	_PFM_COUNT_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop13
SysForLoopEnd13
;18FxxQ10 type
;NVMEN = 0
	bcf	NVMCON0,NVMEN,ACCESS
	return

;********************************************************************************

;Source: system.h (5579)
_PFMWRITEBLOCK
;Dim _PFM_Count as word
;Dim _PFM_LoopCounter as word
;Dim _GIE_SAVE, _dummy as byte
;Dim _PFM_ABS_ADDR as Long Alias _dummy, NVMADRU, NVMADRH, NVMADRL
;Dim _TBL_ABS_ADDR as Long Alias _dummy, TBLPTRU, TBLPTRH, TBLPTRL
;Set memory address for erase operation
;_PFM_ABS_ADDR =  _PFM_BlockNum * SAF_ROWSIZE_BYTES
	movff	_PFM_BLOCKNUM,SysLONGTempA
	movff	_PFM_BLOCKNUM_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movlw	128
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSMULTSUB32
	movff	SysLONGTempX,_PFM_ABS_ADDR
	movff	SysLONGTempX_H,_PFM_ABS_ADDR_H
	movff	SysLONGTempX_U,_PFM_ABS_ADDR_U
	movff	SysLONGTempX_E,_PFM_ABS_ADDR_E
;_TBL_ABS_ADDR = _PFM_BlockNum * SAF_ROWSIZE_BYTES
	movff	_PFM_BLOCKNUM,SysLONGTempA
	movff	_PFM_BLOCKNUM_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movlw	128
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSMULTSUB32
	movff	SysLONGTempX,_TBL_ABS_ADDR
	movff	SysLONGTempX_H,_TBL_ABS_ADDR_H
	movff	SysLONGTempX_U,_TBL_ABS_ADDR_U
	movff	SysLONGTempX_E,_TBL_ABS_ADDR_E
;Set the register control bits for Erase operation
;18FxxQ10 type
;NVMEN = 1
	bsf	NVMCON0,NVMEN,ACCESS
;NVMCON1.6  = 1
	bsf	NVMCON1,6,ACCESS
;_GIE_SAVE = GIE    'Save interrupt
	clrf	_GIE_SAVE,BANKED
	btfsc	INTCON,GIE,ACCESS
	incf	_GIE_SAVE,F,BANKED
;GIE = 0           'disable INTERRUPTS
	bcf	INTCON,GIE,ACCESS
;18FxxQ10 type
;ChipMemorylock = 0xBB
	movlw	187
	movwf	NVMCON2,ACCESS
;ChipMemorylock = 0x44
	movlw	68
	movwf	NVMCON2,ACCESS
;Set memory address for write operations
;_TBL_ABS_ADDR = _PFM_BlockNum * SAF_ROWSIZE_BYTES
	movff	_PFM_BLOCKNUM,SysLONGTempA
	movff	_PFM_BLOCKNUM_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movlw	128
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SYSMULTSUB32
	movff	SysLONGTempX,_TBL_ABS_ADDR
	movff	SysLONGTempX_H,_TBL_ABS_ADDR_H
	movff	SysLONGTempX_U,_TBL_ABS_ADDR_U
	movff	SysLONGTempX_E,_TBL_ABS_ADDR_E
;For _PFM_LoopCounter = 1 to _PFM_Count
;Legacy method
	clrf	_PFM_LOOPCOUNTER,BANKED
	clrf	_PFM_LOOPCOUNTER_H,BANKED
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	movff	_PFM_COUNT,SysWORDTempA
	movff	_PFM_COUNT_H,SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd14
SysForLoop14
	incf	_PFM_LOOPCOUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	_PFM_LOOPCOUNTER_H,F,BANKED
;TABLAT = _PFM_Buffer( _PFM_LoopCounter  )
	movf	_PFM_LOOPCOUNTER,W,BANKED
	addwf	Sys_PFM_BUFFERHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movf	_PFM_LOOPCOUNTER_H,W,BANKED
	addwfc	Sys_PFM_BUFFERHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,TABLAT
;TBLWT*+
	tblwt*+
;next
	movff	_PFM_LOOPCOUNTER,SysWORDTempA
	movff	_PFM_LOOPCOUNTER_H,SysWORDTempA_H
	movff	_PFM_COUNT,SysWORDTempB
	movff	_PFM_COUNT_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop14
SysForLoopEnd14
;Set the control bits for Write Page operation
;Unlock
;ChipMemorylock = 0xDD
	movlw	221
	movwf	NVMCON2,ACCESS
;ChipMemorylock = 0x22
	movlw	34
	movwf	NVMCON2,ACCESS
;18FxxQ10 type
;NVMCON1.5 = 1
	bsf	NVMCON1,5,ACCESS
;ChipMemorylock = 0x55
	movlw	85
	movwf	NVMCON2,ACCESS
;ChipMemorylock = 0xAA
	movlw	170
	movwf	NVMCON2,ACCESS
;18FxxQ10 type
;NVMCON1.WR = 1
	bsf	NVMCON1,WR,ACCESS
;wait while NVMCON1.WR = 1
SysWaitLoop6
	btfsc	NVMCON1,WR,ACCESS
	bra	SysWaitLoop6
;NVMEN = 0
	bcf	NVMCON0,NVMEN,ACCESS
;GIE = _GIE_SAVE     'restore saved interrupt
	btfsc	_GIE_SAVE,0,BANKED
	bsf	INTCON,GIE,ACCESS
	btfss	_GIE_SAVE,0,BANKED
	bcf	INTCON,GIE,ACCESS
	return

;********************************************************************************


 END
