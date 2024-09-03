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
;   Preserve mode    : 0
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
	bsf	TRISB,0,ACCESS
	bsf	TRISA,4,ACCESS
	bcf	TRISB,0,ACCESS
	bcf	TRISB,1,ACCESS
	bcf	TRISB,2,ACCESS
	bcf	TRISB,3,ACCESS
	clrf	LABNUMBER,ACCESS
	clrf	SWITCHEVENT,BANKED
	clrf	LABSTATE,ACCESS
	clrf	BTNSTATE,ACCESS
	bcf	SYSBITVAR0,0,BANKED
	movf	LABNUMBER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF1
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	rcall	CLS
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	5
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	rcall	CLS
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
ENDIF1
SysDoLoop_S1
	rcall	CHECKBUTTONS2
SysSelect1Case1
	decf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
	call	HELLOWORLD
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
	rcall	BLINK
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
	call	ROTATELEDS
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
	rcall	ADC
	bra	SysSelectEnd1
SysSelect1Case5
	movlw	5
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case6
	call	VSR
	bra	SysSelectEnd1
SysSelect1Case6
	movlw	6
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case7
	rcall	DEBOUNCE
	bra	SysSelectEnd1
SysSelect1Case7
	movlw	7
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case8
	call	PWM
	bra	SysSelectEnd1
SysSelect1Case8
	movlw	8
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case9
	call	TIMER_1
	bra	SysSelectEnd1
SysSelect1Case9
	movlw	9
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case10
	call	INTERRUPTS
	bra	SysSelectEnd1
SysSelect1Case10
	movlw	10
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case11
	call	SLEEPWAKEUP
	bra	SysSelectEnd1
SysSelect1Case11
	movlw	11
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case12
	rcall	EEPROM
	bra	SysSelectEnd1
SysSelect1Case12
	movlw	12
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case13
	call	LCD
	bra	SysSelectEnd1
SysSelect1Case13
	movlw	13
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case14
	call	NVMEMORY
	bra	SysSelectEnd1
SysSelect1Case14
	movlw	14
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case15
	call	I2CDISCOVERY
	bra	SysSelectEnd1
SysSelect1Case15
	movlw	15
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case16
	call	I2CTEMPERATURE
	bra	SysSelectEnd1
SysSelect1Case16
	movlw	16
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case17
	call	I2CEEPROM
	bra	SysSelectEnd1
SysSelect1Case17
	movlw	17
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case18
	rcall	CLOCK
	bra	SysSelectEnd1
SysSelect1Case18
	movlw	18
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
	rcall	BUZZER
SysSelectEnd1
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	call	NEXTLAB
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

FN_ABS
	btfss	SYSCALCTEMPA_H,7,ACCESS
	bra	ELSE195_1
	comf	SYSCALCTEMPA,W,ACCESS
	movwf	ABS,ACCESS
	comf	SYSCALCTEMPA_H,W,ACCESS
	movwf	ABS_H,ACCESS
	incf	ABS,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	ABS_H,F,ACCESS
	bra	ENDIF195
ELSE195_1
	movff	SYSCALCTEMPA,ABS
	movff	SYSCALCTEMPA_H,ABS_H
ENDIF195
	return

;********************************************************************************

ADC
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF18
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
	rcall	CLS
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
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
	call	PRINT157
	movlw	1
	movwf	LABSTATE,ACCESS
ENDIF18
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF19
	clrf	ADREADPORT,ACCESS
	call	FN_READAD1048
	movff	SYSREADAD10WORD,ADCRESULT
	movff	SYSREADAD10WORD_H,ADCRESULT_H
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	10
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT157
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
	movlw	241
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	ADCRESULT,W,ACCESS
	movwf	PORTB,ACCESS
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
ENDIF19
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	clrf	LABSTATE,ACCESS
	return

;********************************************************************************

BLINK
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF6
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
	clrf	FLAGCOUNTER,ACCESS
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
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
	call	PRINT157
	movlw	1
	movwf	TMRSOURCE,BANKED
	movlw	32
	movwf	TMRPRES,BANKED
	call	INITTIMER1
	movlw	1
	movwf	TMRNUMBER,BANKED
	movlw	220
	movwf	TMRVALUE,BANKED
	movlw	11
	movwf	TMRVALUE_H,BANKED
	call	SETTIMER228
	banksel	PIE4
	bcf	PIE4,TMR1IE,BANKED
	bcf	PIR4,TMR1IF,BANKED
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STARTTIMER
	movlw	1
	movwf	LABSTATE,ACCESS
ENDIF6
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF7
	btfss	PORTB,3,ACCESS
	bra	ELSE9_1
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	bra	ENDIF9
ELSE9_1
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
ENDIF9
SysWaitLoop1
	banksel	PIR4
	btfss	PIR4,TMR1IF,BANKED
	bra	SysWaitLoop1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STOPTIMER
	movlw	1
	movwf	TMRNUMBER,BANKED
	movlw	220
	movwf	TMRVALUE,BANKED
	movlw	11
	movwf	TMRVALUE_H,BANKED
	call	SETTIMER228
	movlw	1
	movwf	TMRNUMBER,BANKED
	call	STARTTIMER
	banksel	PIR4
	bcf	PIR4,TMR1IF,BANKED
	incf	FLAGCOUNTER,F,ACCESS
	movlw	6
	subwf	FLAGCOUNTER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF10
	banksel	SYSTEMP1
	clrf	SysTemp1,BANKED
	btfsc	PORTB,3,ACCESS
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	LATB,3,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,3,ACCESS
	clrf	FLAGCOUNTER,ACCESS
ENDIF10
ENDIF7
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF8
	movlw	1
	movwf	TMRNUMBER,BANKED
	call	STOPTIMER
	clrf	LABSTATE,ACCESS
ENDIF8
	return

;********************************************************************************

BUTTONPRESSEDISR
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
	banksel	IOCAF
	bcf	IOCAF,IOCAF4,BANKED
	movlw	1
	banksel	SWITCHEVENT
	movwf	SWITCHEVENT,BANKED
	banksel	PIE0
	bcf	PIE0,IOCIE,BANKED
ENDIF90
	banksel	0
	return

;********************************************************************************

BUZZER
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF124
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
	rcall	CLS
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
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
	call	PRINT157
	movlw	1
	movwf	LABSTATE,ACCESS
	bcf	TRISC,2,ACCESS
ENDIF124
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF125
	lfsr	1,SOUNDPLAYRTTTLDATASTRING
	movlw	low StringTable95
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable95
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable95
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movlw	low SOUNDPLAYRTTTLDATASTRING
	movwf	SysSOUNDPLAYDATAHandler,BANKED
	movlw	high SOUNDPLAYRTTTLDATASTRING
	movwf	SysSOUNDPLAYDATAHandler_H,BANKED
	call	PLAYRTTTL
	rcall	CHECKBUTTONS2HELDDOWN
ENDIF125
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	clrf	LABSTATE,ACCESS
	return

;********************************************************************************

CALCULATEDUTY
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
	bcf	STATUS,C,ACCESS
	movlw	2
	movwf	SysRepeatTemp9,BANKED
SysRepeatLoop9
	rlcf	PRX_TEMP,F,BANKED
	rlcf	PRX_TEMP_H,F,BANKED
	rlcf	PRX_TEMP_U,F,BANKED
	rlcf	PRX_TEMP_E,F,BANKED
	decfsz	SysRepeatTemp9,F,BANKED
	bra	SysRepeatLoop9
SysRepeatLoopEnd9
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
	bcf	STATUS,C,ACCESS
	movlw	6
	movwf	SysRepeatTemp9,BANKED
SysRepeatLoop10
	rlcf	PRX_TEMP,F,BANKED
	rlcf	PRX_TEMP_H,F,BANKED
	rlcf	PRX_TEMP_U,F,BANKED
	rlcf	PRX_TEMP_E,F,BANKED
	decfsz	SysRepeatTemp9,F,BANKED
	bra	SysRepeatLoop10
SysRepeatLoopEnd10
	return

;********************************************************************************

CHECKBUSYFLAG
	bcf	SYSLCDTEMP,2,BANKED
	btfsc	PORTD,4,ACCESS
	bsf	SYSLCDTEMP,2,BANKED
	bsf	TRISD,3,ACCESS
	bcf	LATD,4,ACCESS
	bsf	LATD,5,ACCESS
	clrf	LCDTEMPRWCOUNT,ACCESS
SysDoLoop_S7
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS18
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS18
	bsf	LATD,6,ACCESS
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS19
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS19
	bcf	SYSLCDTEMP,7,BANKED
	btfsc	PORTD,3,ACCESS
	bsf	SYSLCDTEMP,7,BANKED
	bcf	LATD,6,ACCESS
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS20
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS20
	bsf	LATD,6,ACCESS
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS21
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS21
	bcf	LATD,6,ACCESS
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS22
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS22
	incf	LCDTEMPRWCOUNT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bcf	SYSLCDTEMP,7,BANKED
	incf	LCDTEMPRWCOUNT,F,ACCESS
	btfsc	SYSLCDTEMP,7,BANKED
	bra	SysDoLoop_S7
SysDoLoop_E7
	bcf	LATD,4,ACCESS
	btfsc	SYSLCDTEMP,2,BANKED
	bsf	LATD,4,ACCESS
	return

;********************************************************************************

CHECKBUTTONS2
	movf	BTNSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE128_1
	btfsc	PORTA,4,ACCESS
	bra	ENDIF129
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	movlw	1
	movwf	BTNSTATE,ACCESS
ENDIF129
	bra	ENDIF128
ELSE128_1
	btfss	PORTA,4,ACCESS
	bra	ENDIF128
	clrf	BTNSTATE,ACCESS
	movlw	1
	movwf	SWITCHEVENT,BANKED
ENDIF128
	return

;********************************************************************************

CHECKBUTTONS2HELDDOWN
	btfsc	PORTA,4,ACCESS
	bra	ENDIF130
	movlw	1
	movwf	SWITCHEVENT,BANKED
ENDIF130
	return

;********************************************************************************

FN_CHECKBUTTONS3
	bsf	TRISB,0,ACCESS
	bsf	LATB,0,ACCESS
	banksel	WPUB
	bsf	WPUB,WPUB0,BANKED
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,4,BANKED
	btfsc	PORTB,0,ACCESS
	bsf	SYSBITVAR0,4,BANKED
	banksel	WPUB
	bcf	WPUB,WPUB0,BANKED
	bcf	TRISB,0,ACCESS
	banksel	0
	return

;********************************************************************************

CLOCK
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF119
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
	rcall	CLS
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
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
	call	PRINT157
	movlw	1
	movwf	LABSTATE,ACCESS
	clrf	SysTemp2,BANKED
	btfsc	SYSBITVAR0,3,BANKED
	incf	SysTemp2,F,BANKED
	comf	SysTemp2,F,BANKED
	bcf	SYSBITVAR0,3,BANKED
	btfsc	SysTemp2,0,BANKED
	bsf	SYSBITVAR0,3,BANKED
	clrf	TICCOUNT,BANKED
	banksel	OSCEN
	bsf	OSCEN,SOSCEN,BANKED
	bsf	OSCCON3,SOSCPWR,BANKED
	movlw	128
	movwf	TMR1H,ACCESS
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STARTTIMER
	banksel	PIE4
	bsf	PIE4,TMR1IE,BANKED
ENDIF119
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF120
ENDIF120
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF121
	banksel	OSCEN
	bcf	OSCEN,SOSCEN,BANKED
	clrf	LABSTATE,ACCESS
ENDIF121
	banksel	0
	return

;********************************************************************************

CLS
	bcf	LATD,4,ACCESS
	movlw	1
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
	movlw	4
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	movlw	128
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
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

DEBOUNCE
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF26
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
	rcall	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	2
	iorwf	SysTemp1,W,BANKED
	movwf	PORTB,ACCESS
	bsf	LATB,1,ACCESS
	movlw	2
	movwf	ACTIVELEDNUM,ACCESS
	rcall	CLS
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LABSTATE,ACCESS
ENDIF26
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF27
	rcall	FN_CHECKBUTTONS3
	btfsc	SYSBITVAR0,4,BANKED
	bra	ENDIF29
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	rcall	FN_CHECKBUTTONS3
	btfsc	SYSBITVAR0,4,BANKED
	bra	ENDIF30
	movlw	14
	andwf	PORTB,W,ACCESS
	movwf	LEDSTATE,ACCESS
	bcf	STATUS,C,ACCESS
	rlcf	LEDSTATE,F,ACCESS
	movlw	241
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	LEDSTATE,W,ACCESS
	movwf	LATB,ACCESS
	incf	ACTIVELEDNUM,F,ACCESS
	movf	ACTIVELEDNUM,W,ACCESS
	sublw	4
	btfsc	STATUS, C,ACCESS
	bra	ENDIF31
	bsf	LATB,1,ACCESS
	movlw	2
	movwf	ACTIVELEDNUM,ACCESS
ENDIF31
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	7
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
	incf	ACTIVELEDNUM,W,ACCESS
	movwf	LCDVALUE,ACCESS
	call	PRINT158
ENDIF30
ENDIF29
ENDIF27
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	clrf	LABSTATE,ACCESS
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

EEPROM
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF62
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
	rcall	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	clrf	ADREADPORT,ACCESS
	call	FN_READAD46
	movff	SYSREADADBYTE,RANDOMTEMP
	clrf	RANDOMTEMP_H,BANKED
	call	RANDOMIZE
	call	FN_RANDOM
	movff	RANDOM,EEPROM_ADDRESS
	clrf	FLAGCOUNTER,ACCESS
	rcall	CLS
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
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
	call	PRINT157
	movlw	1
	movwf	TMRSOURCE,BANKED
	movlw	32
	movwf	TMRPRES,BANKED
	call	INITTIMER1
	movlw	1
	movwf	TMRNUMBER,BANKED
	movlw	220
	movwf	TMRVALUE,BANKED
	movlw	11
	movwf	TMRVALUE_H,BANKED
	call	SETTIMER228
	banksel	PIR4
	bcf	PIR4,TMR1IF,BANKED
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STARTTIMER
	banksel	PIE4
	bsf	PIE4,TMR1IE,BANKED
	movlw	1
	movwf	LABSTATE,ACCESS
ENDIF62
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF63
	movf	FLAGCOUNTER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF65
	movff	EEPROM_ADDRESS,SYSEEADDRESS
	banksel	SYSEEADDRESS_H
	clrf	SYSEEADDRESS_H,BANKED
	call	NVMADR_EPREAD
	movff	EEDATAVALUE,ADCRESULT
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movff	EEPROM_ADDRESS,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	11
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT157
	movff	ADCRESULT,SYSBYTETEMPB
	movlw	4
	movwf	NUMBITS,ACCESS
	rcall	FN_FNLSR127
	movff	SYSFNLSRBYTE,ADCRESULT
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	ADCRESULT,W,ACCESS
	movwf	PORTB,ACCESS
ENDIF65
ENDIF63
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF64
	banksel	PIE4
	bcf	PIE4,TMR1IE,BANKED
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STOPTIMER
	clrf	LABSTATE,ACCESS
ENDIF64
	return

;********************************************************************************

EEPROM_RD_ARRAY34
;`eeprom_rd_array - Uses a WORD for eepAddr.  Intended for larger memory eeproms that require ADDRESS_H and ADDRESS (two bytes, therefore passed as a word ) to set addreess`
SysDoLoop_S5
	rcall	HI2CRESTART
	movlw	160
	movwf	I2CBYTE,ACCESS
	rcall	HI2CSEND
	movf	hi2cackpollstate,F,ACCESS
	btfss	STATUS,Z,ACCESS
	bra	SysDoLoop_S5
SysDoLoop_E5
	movff	EEPADDR_H,I2CBYTE
	rcall	HI2CSEND
	movff	EEPADDR,I2CBYTE
	rcall	HI2CSEND
	rcall	HI2CRESTART
	movlw	161
	movwf	I2CBYTE,ACCESS
	rcall	HI2CSEND
	clrf	EEP_I,ACCESS
SysDoLoop_S6
	movf	EEPLEN,W,ACCESS
	subwf	EEP_I,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	SysDoLoop_E6
	incf	EEP_I,W,ACCESS
	movwf	EEP_J,ACCESS
	decf	EEPLEN,W,ACCESS
	movwf	SysTemp2,BANKED
	movff	EEP_I,SysBYTETempA
	movff	SysTemp2,SysBYTETempB
	call	SYSCOMPLESSTHAN
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE135_1
	setf	HI2CGETACK,ACCESS
	rcall	HI2CRECEIVE
	movf	EEP_J,W,ACCESS
	addwf	SysEEPARRAYHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysEEPARRAYHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	I2CBYTE,INDF0
	bra	ENDIF135
ELSE135_1
	clrf	HI2CGETACK,ACCESS
	rcall	HI2CRECEIVE
	movf	EEP_J,W,ACCESS
	addwf	SysEEPARRAYHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysEEPARRAYHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	I2CBYTE,INDF0
ENDIF135
	incf	EEP_I,F,ACCESS
	bra	SysDoLoop_S6
SysDoLoop_E6
	bra	HI2CSTOP

;********************************************************************************

EEPROM_WR_ARRAY32
;`eeprom_wr_array - Uses a WORD for eepAddr.  Intended for larger memory eeproms that require ADDRESS_H and ADDRESS (two bytes, therefore passed as a word ) to set addreess`
SysDoLoop_S3
	rcall	HI2CRESTART
	movlw	160
	movwf	I2CBYTE,ACCESS
	rcall	HI2CSEND
	movf	hi2cackpollstate,F,ACCESS
	btfss	STATUS,Z,ACCESS
	bra	SysDoLoop_S3
SysDoLoop_E3
	movff	EEPADDR_H,I2CBYTE
	rcall	HI2CSEND
	movff	EEPADDR,I2CBYTE
	rcall	HI2CSEND
	clrf	EEP_I,ACCESS
	movlw	1
	subwf	EEPLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd7
SysForLoop7
	incf	EEP_I,F,ACCESS
	movf	EEP_I,W,ACCESS
	addwf	SysEEPARRAYHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysEEPARRAYHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,I2CBYTE
	rcall	HI2CSEND
	incf	EEPADDR,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EEPADDR_H,F,ACCESS
	movff	EEPADDR,SysWORDTempA
	movff	EEPADDR_H,SysWORDTempA_H
	movff	EEPPAGESIZE,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	call	SYSDIVSUB16
	movff	SysWORDTempX,CALCNEXTPAGE
	movf	CALCNEXTPAGE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF133
	rcall	HI2CSTOP
SysDoLoop_S4
	rcall	HI2CRESTART
	movlw	160
	movwf	I2CBYTE,ACCESS
	rcall	HI2CSEND
	movf	hi2cackpollstate,F,ACCESS
	btfss	STATUS,Z,ACCESS
	bra	SysDoLoop_S4
SysDoLoop_E4
	movff	EEPADDR_H,I2CBYTE
	rcall	HI2CSEND
	movff	EEPADDR,I2CBYTE
	rcall	HI2CSEND
ENDIF133
	movf	EEPLEN,W,ACCESS
	subwf	EEP_I,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
	bra	HI2CSTOP

;********************************************************************************

FN_FNLSR126
	movff	NUMBITS,SysRepeatTemp11
	movf	SYSREPEATTEMP11,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd11
SysRepeatLoop11
	bcf	STATUS,C,ACCESS
	rrcf	SYSWORDTEMPB_H,F,ACCESS
	rrcf	SYSWORDTEMPB,F,ACCESS
	decfsz	SysRepeatTemp11,F,BANKED
	bra	SysRepeatLoop11
SysRepeatLoopEnd11
	movff	SYSWORDTEMPB,FNLSR
	movff	SYSWORDTEMPB_H,FNLSR_H
	return

;********************************************************************************

FN_FNLSR127
	movff	NUMBITS,SysRepeatTemp12
	movf	SYSREPEATTEMP12,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd12
SysRepeatLoop12
	bcf	STATUS,C,ACCESS
	rrcf	SYSBYTETEMPB,F,ACCESS
	decfsz	SysRepeatTemp12,F,BANKED
	bra	SysRepeatLoop12
SysRepeatLoopEnd12
	movff	SYSBYTETEMPB,FNLSR
	return

;********************************************************************************

HELLOWORLD
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF3
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
	rcall	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
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
	call	PRINT157
	movlw	1
	movwf	LABSTATE,ACCESS
ENDIF3
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF4
	bsf	LATB,3,ACCESS
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
ENDIF4
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	clrf	LABSTATE,ACCESS
	return

;********************************************************************************

HI2CINIT
;This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K-Mode family chips
	clrf	HI2CCURRENTMODE,ACCESS
	return

;********************************************************************************

HI2CMODE
;This method sets the variable `HI2CCurrentMode`, and, if required, sets the SSPCON1.bits
	bsf	SSP1STAT,SMP,ACCESS
	bsf	SSP1CON1,CKP,ACCESS
	bcf	SSP1CON1,WCOL,ACCESS
	movlw	12
	subwf	HI2CCURRENTMODE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF289
	bsf	SSP1CON1,SSPM3,ACCESS
	bcf	SSP1CON1,SSPM2,ACCESS
	bcf	SSP1CON1,SSPM1,ACCESS
	bcf	SSP1CON1,SSPM0,ACCESS
	movlw	39
	movwf	SSP1ADD,ACCESS
ENDIF289
	movf	HI2CCURRENTMODE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF290
	bcf	SSP1CON1,SSPM3,ACCESS
	bsf	SSP1CON1,SSPM2,ACCESS
	bsf	SSP1CON1,SSPM1,ACCESS
	bcf	SSP1CON1,SSPM0,ACCESS
ENDIF290
	movlw	3
	subwf	HI2CCURRENTMODE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF291
	bcf	SSP1CON1,SSPM3,ACCESS
	bsf	SSP1CON1,SSPM2,ACCESS
	bsf	SSP1CON1,SSPM1,ACCESS
	bsf	SSP1CON1,SSPM0,ACCESS
ENDIF291
	bsf	SSP1CON1,SSPEN,ACCESS
	return

;********************************************************************************

HI2CRECEIVE
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE299_1
	btfss	HI2CGETACK,0,ACCESS
	bra	ELSE301_1
	bcf	SSP1CON2,ACKDT,ACCESS
	bra	ENDIF301
ELSE301_1
	bsf	SSP1CON2,ACKDT,ACCESS
ENDIF301
	bsf	SSP1CON2,RCEN,ACCESS
	bra	ENDIF299
ELSE299_1
	bsf	SSP1STAT,R_NOT_W,ACCESS
ENDIF299
	bcf	SSP1CON1,WCOL,ACCESS
	bcf	SSP1CON1,SSPOV,ACCESS
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
	movff	SSP1BUF,I2CBYTE
	banksel	PIR3
	bcf	PIR3,SSP1IF,BANKED
	bsf	SSP1CON2,ACKEN,ACCESS
	bcf	SSP1STAT,BF,ACCESS
	banksel	0
	rcall	HI2CWAITMSSP
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE300_1
	bcf	SSP1CON2,RCEN,ACCESS
	bra	ENDIF300
ELSE300_1
	bcf	SSP1STAT,R_NOT_W,ACCESS
ENDIF300
	return

;********************************************************************************

HI2CRESTART
;This method sets the registers and register bits to generate the I2C  RESTART signal
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ENDIF293
	bsf	SSP1CON2,RSEN,ACCESS
	rcall	HI2CWAITMSSP
ENDIF293
	return

;********************************************************************************

HI2CSEND
;This method sets the registers and register bits to send I2C data
RETRYHI2CSEND
	bcf	SSP1CON1,WCOL,ACCESS
	movff	I2CBYTE,SSP1BUF
	rcall	HI2CWAITMSSP
	btfss	SSP1CON2,ACKSTAT,ACCESS
	bra	ELSE295_1
	setf	HI2CACKPOLLSTATE,ACCESS
	bra	ENDIF295
ELSE295_1
	clrf	HI2CACKPOLLSTATE,ACCESS
ENDIF295
	btfss	SSP1CON1,WCOL,ACCESS
	bra	ENDIF296
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	RETRYHI2CSEND
ENDIF296
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bsf	SSP1CON1,CKP,ACCESS
	return

;********************************************************************************

HI2CSTART
;This method sets the registers and register bits to generate the I2C  START signal
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE292_1
	bsf	SSP1CON2,SEN_SSP1CON2,ACCESS
	rcall	HI2CWAITMSSP
	bra	ENDIF292
ELSE292_1
SysWaitLoop7
	btfss	SSP1STAT,S,ACCESS
	bra	SysWaitLoop7
ENDIF292
	return

;********************************************************************************

HI2CSTOP
	movf	HI2CCURRENTMODE,W,ACCESS
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE294_1
SysWaitLoop8
	btfsc	SSP1STAT,R_NOT_W,ACCESS
	bra	SysWaitLoop8
	bsf	SSP1CON2,PEN,ACCESS
	bsf	SSP1CON2,PEN,ACCESS
	rcall	HI2CWAITMSSP
	bra	ENDIF294
ELSE294_1
SysWaitLoop9
	btfss	SSP1STAT,P,ACCESS
	bra	SysWaitLoop9
ENDIF294
	return

;********************************************************************************

HI2CWAITMSSP
	clrf	HI2CWAITMSSPTIMEOUT,ACCESS
HI2CWAITMSSPWAIT
	incf	HI2CWAITMSSPTIMEOUT,F,ACCESS
	movlw	255
	subwf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF302
	banksel	PIR3
	btfsc	PIR3,SSP1IF,BANKED
	bra	ENDIF304
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS17
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS17
	nop
	bra	HI2CWAITMSSPWAIT
ENDIF304
	bcf	PIR3,SSP1IF,BANKED
ENDIF302
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF303
	banksel	PIR3
	bcf	PIR3,BCL1IF,BANKED
ENDIF303
	banksel	0
	return

;********************************************************************************

HPWM66
	setf	PWMRESOLUTION,BANKED
	clrf	PWMRESOLUTION_H,BANKED
	movlw	1
	movwf	TX_PR,BANKED
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
	movf	PRX_TEMP_H,W,BANKED
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF177
	movlw	4
	movwf	TX_PR,BANKED
	bcf	STATUS,C,ACCESS
	rrcf	PRX_TEMP_E,F,BANKED
	rrcf	PRX_TEMP_U,F,BANKED
	rrcf	PRX_TEMP_H,F,BANKED
	rrcf	PRX_TEMP,F,BANKED
	bcf	STATUS,C,ACCESS
	rrcf	PRX_TEMP_E,F,BANKED
	rrcf	PRX_TEMP_U,F,BANKED
	rrcf	PRX_TEMP_H,F,BANKED
	rrcf	PRX_TEMP,F,BANKED
ENDIF177
	movf	PRX_TEMP_H,W,BANKED
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF178
	movlw	16
	movwf	TX_PR,BANKED
	bcf	STATUS,C,ACCESS
	rrcf	PRX_TEMP_E,F,BANKED
	rrcf	PRX_TEMP_U,F,BANKED
	rrcf	PRX_TEMP_H,F,BANKED
	rrcf	PRX_TEMP,F,BANKED
	bcf	STATUS,C,ACCESS
	rrcf	PRX_TEMP_E,F,BANKED
	rrcf	PRX_TEMP_U,F,BANKED
	rrcf	PRX_TEMP_H,F,BANKED
	rrcf	PRX_TEMP,F,BANKED
ENDIF178
	movf	PRX_TEMP_H,W,BANKED
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF179
	movlw	64
	movwf	TX_PR,BANKED
	bcf	STATUS,C,ACCESS
	rrcf	PRX_TEMP_E,F,BANKED
	rrcf	PRX_TEMP_U,F,BANKED
	rrcf	PRX_TEMP_H,F,BANKED
	rrcf	PRX_TEMP,F,BANKED
	bcf	STATUS,C,ACCESS
	rrcf	PRX_TEMP_E,F,BANKED
	rrcf	PRX_TEMP_U,F,BANKED
	rrcf	PRX_TEMP_H,F,BANKED
	rrcf	PRX_TEMP,F,BANKED
ENDIF179
CCPPWMSETUPCLOCKSOURCE
SysSelect6Case1
	movlw	2
	banksel	_PWMTIMERSELECTED
	subwf	_PWMTIMERSELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd6
	movff	PRX_TEMP,PR2
	bcf	T2CON,T2CKPS0,ACCESS
	bcf	T2CON,T2CKPS1,ACCESS
	bcf	T2CON,T2CKPS2,ACCESS
	movlw	4
	banksel	TX_PR
	subwf	TX_PR,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bsf	T2CON,T2CKPS1,ACCESS
	movlw	16
	subwf	TX_PR,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bsf	T2CON,T2CKPS2,ACCESS
	movlw	64
	subwf	TX_PR,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF182
	bsf	T2CON,T2CKPS2,ACCESS
	bsf	T2CON,T2CKPS1,ACCESS
ENDIF182
	bsf	T2CLKCON,T2CS0,ACCESS
	bcf	T2CLKCON,T2CS1,ACCESS
	bcf	T2CLKCON,T2CS2,ACCESS
	bcf	T2CLKCON,T2CS3,ACCESS
SysSelectEnd6
END_OF_CCPPWMSETUPCLOCKSOURCE
SETUPTHECORRECTTIMERBITS
	bcf	STATUS,C,ACCESS
	banksel	_PWMTIMERSELECTED
	rrcf	_PWMTIMERSELECTED,W,BANKED
	banksel	TIMERSELECTIONBITS
	movwf	TIMERSELECTIONBITS,BANKED
SETUPCCPPWMREGISTERS
CHIPFAMILYPWMCCP1CON16HANDLER
	decf	PWMCHANNEL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF183
	call	CALCULATEDUTY
	movff	PRX_TEMP_H,CCPR1H
	movff	PRX_TEMP,CCPR1L
	bsf	CCP1CON,CCP1MODE3,ACCESS
	bsf	CCP1CON,CCP1MODE2,ACCESS
	bsf	CCP1CON,CCP1MODE1,ACCESS
	bsf	CCP1CON,CCP1MODE0,ACCESS
	bsf	CCP1CON,CCP1EN,ACCESS
	bsf	CCP1CON,EN,ACCESS
	bsf	CCP1CON,CCP1FMT,ACCESS
	bcf	CCPTMRS,C1TSEL0,ACCESS
	btfsc	TIMERSELECTIONBITS,0,BANKED
	bsf	CCPTMRS,C1TSEL0,ACCESS
	bcf	CCPTMRS,C1TSEL1,ACCESS
	btfsc	TIMERSELECTIONBITS,1,BANKED
	bsf	CCPTMRS,C1TSEL1,ACCESS
ENDIF183
	return

;********************************************************************************

HSERPRINT384
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF284
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd20
SysForLoop20
	incf	SYSPRINTTEMP,F,BANKED
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND372
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop20
SysForLoopEnd20
ENDIF284
	return

;********************************************************************************

HSERPRINT386
	clrf	OUTVALUETEMP,ACCESS
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF287
	movff	SERPRINTVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempA,OUTVALUETEMP
	movff	SYSCALCTEMPX,SERPRINTVAL
	movlw	48
	addwf	OUTVALUETEMP,W,ACCESS
	movwf	SERDATA,BANKED
	rcall	HSERSEND372
ENDIF287
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
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempA,OUTVALUETEMP
	movff	SYSCALCTEMPX,SERPRINTVAL
	movlw	48
	addwf	OUTVALUETEMP,W,ACCESS
	movwf	SERDATA,BANKED
	rcall	HSERSEND372
ENDIF288
	movlw	48
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	bra	HSERSEND372

;********************************************************************************

HSERPRINTCRLF
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp15
	movf	SYSREPEATTEMP15,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd15
SysRepeatLoop15
	movlw	13
	movwf	SERDATA,BANKED
	rcall	HSERSEND372
	movlw	10
	movwf	SERDATA,BANKED
	rcall	HSERSEND372
	decfsz	SysRepeatTemp15,F,BANKED
	bra	SysRepeatLoop15
SysRepeatLoopEnd15
	return

;********************************************************************************

HSERSEND372
HSERSENDUSART1HANDLER
SysWaitLoop11
	banksel	PIR3
	btfss	PIR3,TXIF,BANKED
	bra	SysWaitLoop11
SysWaitLoop12
	btfss	TX1STA,TRMT,ACCESS
	bra	SysWaitLoop12
	movff	SERDATA,TX1REG
	banksel	0
	return

;********************************************************************************

I2CDISCOVERY
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF96
	bsf	TRISC,4,ACCESS
	bsf	TRISC,3,ACCESS
	movlw	12
	movwf	HI2CCURRENTMODE,ACCESS
	rcall	HI2CMODE
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
	rcall	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LABSTATE,ACCESS
	banksel	PIE0
	bsf	PIE0,IOCIE,BANKED
	movlw	16
	banksel	IOCAP
	movwf	IOCAP,BANKED
	movlw	16
	movwf	IOCAN,BANKED
ENDIF96
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF97
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	rcall	HSERPRINTCRLF
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
	rcall	HSERPRINT384
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
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
	rcall	HSERPRINT384
	setf	DEVICEID,ACCESS
SysForLoop2
	incf	DEVICEID,F,ACCESS
	movff	DEVICEID,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT384
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
	rcall	HSERPRINT384
	movlw	15
	subwf	DEVICEID,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
	setf	DEVICEID,ACCESS
SysForLoop3
	incf	DEVICEID,F,ACCESS
	movff	DEVICEID,SysBYTETempA
	movlw	16
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempX,DISPLAYNEWLINE
	movf	DISPLAYNEWLINE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF100
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	movff	DEVICEID,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT384
	movf	DISPLAYNEWLINE,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF103
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
	rcall	HSERPRINT384
ENDIF103
ENDIF100
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
	rcall	HSERPRINT384
	rcall	HI2CSTART
	incf	HI2CWAITMSSPTIMEOUT,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ELSE101_1
	movff	DEVICEID,I2CBYTE
	rcall	HI2CSEND
	movf	HI2CACKPOLLSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE104_1
	clrf	I2CBYTE,ACCESS
	rcall	HI2CSEND
	movff	DEVICEID,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT384
	bra	ENDIF104
ELSE104_1
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
	rcall	HSERPRINT384
ENDIF104
	rcall	HI2CSTOP
	bra	ENDIF101
ELSE101_1
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
	rcall	HSERPRINT384
ENDIF101
	movlw	255
	subwf	DEVICEID,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
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
	rcall	HSERPRINT384
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
ENDIF97
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	clrf	LABSTATE,ACCESS
	return

;********************************************************************************

I2CEEPROM
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF108
	bsf	TRISC,4,ACCESS
	bsf	TRISC,3,ACCESS
	movlw	12
	movwf	HI2CCURRENTMODE,ACCESS
	rcall	HI2CMODE
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
	rcall	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	call	CLS
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
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
	call	PRINT157
	movlw	1
	movwf	LABSTATE,ACCESS
	bcf	SYSBITVAR0,2,BANKED
	clrf	SWITCHEVENT,BANKED
ENDIF108
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF109
ARRAYOPS
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
	rcall	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
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
	rcall	HSERPRINT384
	clrf	XLOOP,BANKED
SysForLoop4
	incf	XLOOP,F,BANKED
	lfsr	0,DATARRAY
	movf	XLOOP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT386
	movlw	10
	subwf	XLOOP,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF111
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
	rcall	HSERPRINT384
ENDIF111
	movlw	10
	subwf	XLOOP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	clrf	EEPADDR,ACCESS
	clrf	EEPADDR_H,ACCESS
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
	rcall	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
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
	rcall	HSERPRINT384
	clrf	XLOOP,BANKED
SysForLoop5
	incf	XLOOP,F,BANKED
	lfsr	0,DATARRAY
	movf	XLOOP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	127
	movwf	INDF0,ACCESS
	lfsr	0,DATARRAY
	movf	XLOOP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT386
	movlw	10
	subwf	XLOOP,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF113
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
	rcall	HSERPRINT384
ENDIF113
	movlw	10
	subwf	XLOOP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	clrf	EEPADDR,ACCESS
	clrf	EEPADDR_H,ACCESS
	movlw	160
	movwf	EEPDEV,ACCESS
	movlw	low DATARRAY
	movwf	SysEEPARRAYHandler,BANKED
	movlw	high DATARRAY
	movwf	SysEEPARRAYHandler_H,BANKED
	movlw	10
	movwf	EEPLEN,ACCESS
	call	EEPROM_RD_ARRAY34
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
	rcall	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
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
	rcall	HSERPRINT384
	clrf	XLOOP,BANKED
SysForLoop6
	incf	XLOOP,F,BANKED
	lfsr	0,DATARRAY
	movf	XLOOP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT386
	movlw	10
	subwf	XLOOP,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF115
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
	rcall	HSERPRINT384
ENDIF115
	lfsr	0,DATARRAY
	movf	XLOOP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movf	XLOOP,W,BANKED
	subwf	INDF0,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bsf	SYSBITVAR0,2,BANKED
	movlw	10
	subwf	XLOOP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
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
	rcall	HSERPRINT384
	movlw	3
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
	btfss	SYSBITVAR0,2,BANKED
	bra	ELSE118_1
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
	call	PRINT157
	bra	ENDIF118
ELSE118_1
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
	call	PRINT157
ENDIF118
	call	CHECKBUTTONS2
	movlw	2
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
ENDIF109
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	clrf	LABSTATE,ACCESS
	return

;********************************************************************************

I2CTEMPERATURE
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF105
	bsf	TRISC,4,ACCESS
	bsf	TRISC,3,ACCESS
	movlw	12
	movwf	HI2CCURRENTMODE,ACCESS
	call	HI2CMODE
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
	rcall	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINTCRLF
	call	CLS
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
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
	call	PRINT157
	movlw	1
	movwf	LABSTATE,ACCESS
	banksel	PIE0
	bsf	PIE0,IOCIE,BANKED
	movlw	16
	banksel	IOCAP
	movwf	IOCAP,BANKED
	movlw	16
	movwf	IOCAN,BANKED
	movlw	12
	banksel	SYSCHARARRAY_1
	movwf	SYSCHARARRAY_1,BANKED
	movlw	18
	movwf	SYSCHARARRAY_2,BANKED
	movlw	12
	movwf	SYSCHARARRAY_3,BANKED
	clrf	SYSCHARARRAY_4,BANKED
	clrf	SYSCHARARRAY_5,BANKED
	clrf	SYSCHARARRAY_6,BANKED
	clrf	SYSCHARARRAY_7,BANKED
	clrf	SYSCHARARRAY_8,BANKED
	clrf	LCDCHARLOC,ACCESS
	movlw	low CHARARRAY
	banksel	SYSLCDCHARDATAHANDLER
	movwf	SysLCDCHARDATAHandler,BANKED
	movlw	high CHARARRAY
	movwf	SysLCDCHARDATAHandler_H,BANKED
	call	LCDCREATECHAR
ENDIF105
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF106
	call	HI2CSTART
	movlw	154
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
	clrf	I2CBYTE,ACCESS
	call	HI2CSEND
	call	HI2CRESTART
	movlw	155
	movwf	I2CBYTE,ACCESS
	call	HI2CSEND
	clrf	HI2CGETACK,ACCESS
	call	HI2CRECEIVE
	movff	I2CBYTE,TEMPERATUREVAL
	call	HI2CSTOP
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
	movff	TEMPERATUREVAL,LCDVALUE
	call	PRINT158
	clrf	LCDCHAR,ACCESS
	call	LCDWRITECHAR
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
	call	PRINT157
ENDIF106
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF107
	banksel	PIE0
	bcf	PIE0,IOCIE,BANKED
	clrf	LABSTATE,ACCESS
ENDIF107
	banksel	0
	return

;********************************************************************************

INITLCD
;`LCD_IO selected is ` LCD_IO
;`LCD_Speed is FAST`
;`OPTIMAL is set to ` OPTIMAL
;`LCD_Speed is set to ` LCD_Speed
	movlw	50
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	bcf	TRISD,5,ACCESS
	bcf	LATD,5,ACCESS
	bcf	TRISD,0,ACCESS
	bcf	TRISD,1,ACCESS
	bcf	TRISD,2,ACCESS
	bcf	TRISD,3,ACCESS
	bcf	TRISD,4,ACCESS
	bcf	TRISD,6,ACCESS
	bcf	LATD,4,ACCESS
	bcf	LATD,6,ACCESS
	bcf	LATD,3,ACCESS
	bcf	LATD,2,ACCESS
	bsf	LATD,1,ACCESS
	bsf	LATD,0,ACCESS
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS5
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS5
	nop
	bsf	LATD,6,ACCESS
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS6
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS6
	bcf	LATD,6,ACCESS
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	movlw	3
	movwf	SysRepeatTemp13,BANKED
SysRepeatLoop13
	bsf	LATD,6,ACCESS
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS7
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS7
	bcf	LATD,6,ACCESS
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	decfsz	SysRepeatTemp13,F,BANKED
	bra	SysRepeatLoop13
SysRepeatLoopEnd13
	bcf	LATD,3,ACCESS
	bcf	LATD,2,ACCESS
	bsf	LATD,1,ACCESS
	bcf	LATD,0,ACCESS
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS8
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS8
	nop
	bsf	LATD,6,ACCESS
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS9
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS9
	bcf	LATD,6,ACCESS
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
	movlw	40
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
	movlw	6
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
	movlw	12
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
	call	CLS
	movlw	12
	movwf	LCD_STATE,ACCESS
	return

;********************************************************************************

INITPPS
	movlw	23
	banksel	RX1PPS
	movwf	RX1PPS,BANKED
	movlw	9
	movwf	RC6PPS,BANKED
	movlw	19
	movwf	SSP1CLKPPS,BANKED
	movlw	15
	movwf	RC3PPS,BANKED
	movlw	20
	movwf	SSP1DATPPS,BANKED
	movlw	16
	movwf	RC4PPS,BANKED
	banksel	0
	return

;********************************************************************************

INITPWM
	movlw	2
	banksel	_PWMTIMERSELECTED
	movwf	_PWMTIMERSELECTED,BANKED
LEGACY_STARTOFFIXEDCCPPWMMODECODE
	clrf	CCPCONCACHE,ACCESS
	movlw	105
	movwf	PR2,ACCESS
	bcf	T2CON,T2CKPS0,ACCESS
	bsf	T2CON,T2CKPS1,ACCESS
	bcf	T2CON,T2CKPS2,ACCESS
	bsf	CCPCONCACHE,CCP1FMT,ACCESS
	movlw	53
	movwf	CCPR1H,ACCESS
	clrf	CCPR1L,ACCESS
	movlw	1
	movwf	T2CLKCON,ACCESS
	bsf	CCPCONCACHE,EN,ACCESS
	bsf	CCPCONCACHE,CCP1MODE3,ACCESS
	bsf	CCPCONCACHE,CCP1MODE2,ACCESS
	bcf	CCPCONCACHE,CCP1MODE1,ACCESS
	bcf	CCPCONCACHE,CCP1MODE0,ACCESS
	bsf	T2CON,TMR2ON,ACCESS
STARTOFFIXEDPWMMODECODE
SETPWMDUTYCODE
	banksel	0
	return

;********************************************************************************

INITRANDOM
	movlw	165
	movwf	RANDOMSEED,BANKED
	movlw	147
	movwf	RANDOMSEED_H,BANKED
	return

;********************************************************************************

INITSOUNDPLAY
	movlw	4
	movwf	SOUNDPLAYOCTAVE,BANKED
	movlw	4
	movwf	SOUNDPLAYLENGTH,BANKED
	movlw	120
	movwf	SOUNDPLAYTEMPO,BANKED
	clrf	SOUNDPLAYDOTS,BANKED
	clrf	SOUNDPLAYCOMMAND,BANKED
	bcf	TRISC,2,ACCESS
	return

;********************************************************************************

INITSYS
	movlb	0
;Default settings for microcontrollers with _OSCCON1_
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1,BANKED
	clrf	OSCCON3,BANKED
	clrf	OSCEN,BANKED
	clrf	OSCTUNE,BANKED
;The MCU is a chip family 16
;OSCCON type is 101
	movlw	96
	movwf	OSCCON1,BANKED
	movlw	8
	movwf	OSCFRQ,BANKED
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
	clrf	TBLPTRU,ACCESS
	banksel	ADCON0
	bcf	ADCON0,ADFM,BANKED
	bcf	ADCON0,ADON,BANKED
	clrf	ANSELA,BANKED
	clrf	ANSELB,BANKED
	clrf	ANSELC,BANKED
	clrf	ANSELD,BANKED
	clrf	ANSELE,BANKED
	bcf	CM2CON0,C2EN,BANKED
	bcf	CM1CON0,C1EN,BANKED
	clrf	PORTA,ACCESS
	clrf	PORTB,ACCESS
	clrf	PORTC,ACCESS
	clrf	PORTD,ACCESS
	clrf	PORTE,ACCESS
	banksel	0
	return

;********************************************************************************

INITTIMER0230
	movlw	240
	andwf	T0CON1,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	TMRPRES,F,BANKED
	decf	TMRSOURCE,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE244_1
	bsf	TMRPOST,5,BANKED
	bra	ENDIF244
ELSE244_1
	bcf	TMRPOST,5,BANKED
ENDIF244
	movff	TMRPRES,T0CON1
	movlw	224
	andwf	T0CON0,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	TMRPOST,F,BANKED
	bcf	TMRPOST,4,BANKED
	movff	TMRPOST,T0CON0
	return

;********************************************************************************

INITTIMER1
	movf	TMRPRES,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF245
	movlw	16
	subwf	TMRPRES,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF248
	movlw	32
	subwf	TMRPRES,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF249
	movlw	48
	subwf	TMRPRES,W,BANKED
	btfss	STATUS, Z,ACCESS
	clrf	TMRPRES,BANKED
ENDIF249
ENDIF248
ENDIF245
	btfsc	T1CON,TMR1ON,ACCESS
	bsf	TMRPRES,0,BANKED
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
	clrf	TRMSOURCE,BANKED
	movff	TMRSOURCE,T1CLK
	movff	TMRPRES,T1CON
	return

;********************************************************************************

INITUSART
	movlw	1
	movwf	COMPORT,ACCESS
	movlw	129
	movwf	SPBRG1,ACCESS
	movlw	6
	movwf	SPBRGH1,ACCESS
	bsf	BAUDCON1,BRG16,ACCESS
	bsf	TX1STA,BRGH,ACCESS
	bcf	TX1STA,SYNC_TX1STA,ACCESS
	bsf	RC1STA,SPEN,ACCESS
	bsf	RC1STA,CREN,ACCESS
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

INTERRUPTS
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF44
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
	movlw	241
	andwf	PORTB,F,ACCESS
	bsf	LATB,2,ACCESS
	movlw	2
	movwf	ACTIVELEDNUM,ACCESS
	bsf	SYSBITVAR0,1,BANKED
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	banksel	PIE0
	bsf	PIE0,TMR0IE,BANKED
	movlw	1
	banksel	TMRSOURCE
	movwf	TMRSOURCE,BANKED
	movlw	76
	movwf	TMRPRES,BANKED
	clrf	TMRPOST,BANKED
	rcall	INITTIMER0230
	clrf	TMRNUMBER,BANKED
	call	STARTTIMER
	movlw	1
	movwf	LABSTATE,ACCESS
ENDIF44
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF45
	call	FN_CHECKBUTTONS3
	btfsc	SYSBITVAR0,4,BANKED
	bra	ENDIF47
	clrf	SysTemp1,BANKED
	btfsc	SYSBITVAR0,1,BANKED
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	SYSBITVAR0,1,BANKED
	btfsc	SysTemp1,0,BANKED
	bsf	SYSBITVAR0,1,BANKED
	btfss	SYSBITVAR0,1,BANKED
	bra	ELSE48_1
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	bra	ENDIF48
ELSE48_1
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
ENDIF48
	clrf	TMRNUMBER,BANKED
	call	STOPTIMER
	bcf	LATB,1,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,3,ACCESS
SysWaitLoop2
	call	FN_CHECKBUTTONS3
	btfss	SYSBITVAR0,4,BANKED
	bra	SysWaitLoop2
	clrf	TMRNUMBER,BANKED
	call	STARTTIMER
ENDIF47
ENDIF45
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF46
	banksel	PIE0
	bcf	PIE0,TMR0IE,BANKED
	banksel	TMRNUMBER
	clrf	TMRNUMBER,BANKED
	call	STOPTIMER
	clrf	LABSTATE,ACCESS
ENDIF46
	return

;********************************************************************************

LAB_TIMER0_ISR
	btfss	SYSBITVAR0,1,BANKED
	bra	ELSE51_1
	clrf	SysTemp1,BANKED
	btfsc	PORTB,1,ACCESS
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	LATB,1,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,1,ACCESS
	bra	ENDIF51
ELSE51_1
	clrf	SysTemp1,BANKED
	btfsc	PORTB,3,ACCESS
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	LATB,3,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,3,ACCESS
ENDIF51
	return

;********************************************************************************

LCD
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF76
	call	CLS
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
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
	call	PRINT157
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
	banksel	PIE0
	bsf	PIE0,IOCIE,BANKED
	movlw	16
	banksel	IOCAP
	movwf	IOCAP,BANKED
	movlw	16
	movwf	IOCAN,BANKED
	movlw	1
	movwf	LABSTATE,ACCESS
ENDIF76
SysDoLoop_S2
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
	banksel	0
	call	CLS
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
	call	CLS
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
	movlw	10
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	call	CLS
	movlw	13
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	call	CLS
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
	movlw	9
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	call	CLS
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	movlw	14
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
	movlw	10
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
	movlw	9
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
	movlw	13
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
	movlw	14
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
	movlw	3
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	call	CLS
	clrf	LCDLINE,ACCESS
	movlw	4
	movwf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	4
	movwf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	movlw	244
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	movlw	10
	movwf	SysRepeatTemp4,BANKED
SysRepeatLoop4
	movlw	11
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
	movlw	244
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	movlw	12
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
	movlw	244
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
	decfsz	SysRepeatTemp4,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
	call	CLS
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	call	PRINT157
	movlw	2
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
	movlw	11
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
	movlw	5
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	call	CLS
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
	movlw	12
	movwf	LCDCRSR,ACCESS
	rcall	LCDCURSOR
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
	call	PRINT157
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
	movlw	2
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	bra	SysDoLoop_S2
SysDoLoop_E2
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	clrf	LABSTATE,ACCESS
	return

;********************************************************************************

LCDCREATECHAR
	bcf	LATD,4,ACCESS
	rcall	FN_LCDNORMALREADBYTE
	movff	LCDNORMALREADBYTE,LCDLOC
	bsf	LCDLOC,7,ACCESS
	bcf	LATD,4,ACCESS
	movf	LCDCHARLOC,W,ACCESS
	mullw	8
	movlw	64
	addwf	PRODL,W,ACCESS
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	call	Delay_10US
	bsf	LATD,4,ACCESS
	clrf	LCDTEMP,ACCESS
SysForLoop12
	incf	LCDTEMP,F,ACCESS
	movf	LCDTEMP,W,ACCESS
	addwf	SysLCDCHARDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysLCDCHARDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,LCDBYTE
	rcall	LCDNORMALWRITEBYTE
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	call	Delay_10US
	movlw	8
	subwf	LCDTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop12
SysForLoopEnd12
	bcf	LATD,4,ACCESS
	movff	LCDLOC,LCDBYTE
	rcall	LCDNORMALWRITEBYTE
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	goto	Delay_10US

;********************************************************************************

LCDCURSOR
	bcf	LATD,4,ACCESS
	decf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF213
	movlw	12
	iorwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
ENDIF213
	movlw	12
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF214
	movlw	12
	iorwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
ENDIF214
	movf	LCDCRSR,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF215
	movlw	11
	andwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
ENDIF215
	movlw	11
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF216
	movlw	11
	andwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
ENDIF216
	movlw	10
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF217
	movlw	10
	iorwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
ENDIF217
	movlw	13
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF218
	movlw	13
	andwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
ENDIF218
	movlw	9
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF219
	movlw	9
	iorwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
ENDIF219
	movlw	9
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF220
	movlw	9
	iorwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
ENDIF220
	movlw	14
	subwf	LCDCRSR,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF221
	movlw	14
	andwf	LCD_STATE,W,ACCESS
	movwf	LCDTEMP,ACCESS
ENDIF221
	movff	LCDTEMP,LCDBYTE
	rcall	LCDNORMALWRITEBYTE
	movff	LCDTEMP,LCD_STATE
	return

;********************************************************************************

LCDINITOM16214
	bcf	TRISD,7,ACCESS
	bsf	LATD,7,ACCESS
	movlw	40
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	goto	INITPPS

;********************************************************************************

FN_LCDNORMALREADBYTE
	bsf	LATD,5,ACCESS
	clrf	LCDNORMALREADBYTE,ACCESS
	bsf	TRISD,0,ACCESS
	bsf	TRISD,1,ACCESS
	bsf	TRISD,2,ACCESS
	bsf	TRISD,3,ACCESS
	bsf	LATD,6,ACCESS
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS23
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS23
	nop
	btfsc	PORTD,3,ACCESS
	bsf	LCDNORMALREADBYTE,7,ACCESS
	btfsc	PORTD,2,ACCESS
	bsf	LCDNORMALREADBYTE,6,ACCESS
	btfsc	PORTD,1,ACCESS
	bsf	LCDNORMALREADBYTE,5,ACCESS
	btfsc	PORTD,0,ACCESS
	bsf	LCDNORMALREADBYTE,4,ACCESS
	bcf	LATD,6,ACCESS
	movlw	26
	movwf	DELAYTEMP,ACCESS
DelayUS24
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS24
	nop
	bsf	LATD,6,ACCESS
	movlw	10
	movwf	DELAYTEMP,ACCESS
DelayUS25
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS25
	nop
	btfsc	PORTD,3,ACCESS
	bsf	LCDNORMALREADBYTE,3,ACCESS
	btfsc	PORTD,2,ACCESS
	bsf	LCDNORMALREADBYTE,2,ACCESS
	btfsc	PORTD,1,ACCESS
	bsf	LCDNORMALREADBYTE,1,ACCESS
	btfsc	PORTD,0,ACCESS
	bsf	LCDNORMALREADBYTE,0,ACCESS
	bcf	LATD,6,ACCESS
	movlw	26
	movwf	DELAYTEMP,ACCESS
DelayUS26
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS26
	nop
	return

;********************************************************************************

LCDNORMALWRITEBYTE
	call	CHECKBUSYFLAG
	bcf	LATD,5,ACCESS
	bcf	TRISD,0,ACCESS
	bcf	TRISD,1,ACCESS
	bcf	TRISD,2,ACCESS
	bcf	TRISD,3,ACCESS
	bcf	LATD,3,ACCESS
	btfsc	LCDBYTE,7,ACCESS
	bsf	LATD,3,ACCESS
	bcf	LATD,2,ACCESS
	btfsc	LCDBYTE,6,ACCESS
	bsf	LATD,2,ACCESS
	bcf	LATD,1,ACCESS
	btfsc	LCDBYTE,5,ACCESS
	bsf	LATD,1,ACCESS
	bcf	LATD,0,ACCESS
	btfsc	LCDBYTE,4,ACCESS
	bsf	LATD,0,ACCESS
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS12
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS12
	bsf	LATD,6,ACCESS
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS13
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS13
	bcf	LATD,6,ACCESS
	bcf	LATD,3,ACCESS
	btfsc	LCDBYTE,3,ACCESS
	bsf	LATD,3,ACCESS
	bcf	LATD,2,ACCESS
	btfsc	LCDBYTE,2,ACCESS
	bsf	LATD,2,ACCESS
	bcf	LATD,1,ACCESS
	btfsc	LCDBYTE,1,ACCESS
	bsf	LATD,1,ACCESS
	bcf	LATD,0,ACCESS
	btfsc	LCDBYTE,0,ACCESS
	bsf	LATD,0,ACCESS
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS14
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS14
	bsf	LATD,6,ACCESS
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS15
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS15
	bcf	LATD,6,ACCESS
	movlw	213
	movwf	DELAYTEMP,ACCESS
DelayUS16
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS16
	btfsc	PORTD,4,ACCESS
	bra	ENDIF203
	movlw	16
	subwf	LCDBYTE,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF204
	movf	LCDBYTE,W,ACCESS
	sublw	7
	btfss	STATUS, C,ACCESS
	movff	LCDBYTE,LCD_STATE
ENDIF204
ENDIF203
	return

;********************************************************************************

LCDWRITECHAR
	bsf	LATD,4,ACCESS
	movff	LCDCHAR,LCDBYTE
	rcall	LCDNORMALWRITEBYTE
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	goto	Delay_10US

;********************************************************************************

FN_LEFTPAD
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSSTRLEN,W,BANKED
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ELSE279_1
	lfsr	1,LEFTPAD
	movlw	low StringTable167
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable167
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable167
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	movff	SYSSTRLEN,SYSLEFTPAD_0
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	SYSSTRLEN,W,BANKED
	movwf	SYSCHARCOUNT,BANKED
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd18
SysForLoop18
	incf	SYSSTRINGTEMP,F,BANKED
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
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop18
SysForLoopEnd18
	clrf	SYSSTRINGTEMP,BANKED
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd19
SysForLoop19
	incf	SYSSTRINGTEMP,F,BANKED
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
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop19
SysForLoopEnd19
	bra	ENDIF279
ELSE279_1
	lfsr	1,LEFTPAD
	movff	SysSYSINSTRINGHandler,FSR0L
	movff	SysSYSINSTRINGHandler_H,FSR0H
	call	SYSCOPYSTRING
ENDIF279
	return

;********************************************************************************

LOCATE
	bcf	LATD,4,ACCESS
	movf	LCDLINE,W,ACCESS
	sublw	1
	btfsc	STATUS, C,ACCESS
	bra	ENDIF196
	movlw	2
	subwf	LCDLINE,F,ACCESS
	movlw	16
	addwf	LCDCOLUMN,F,ACCESS
ENDIF196
	movf	LCDLINE,W,ACCESS
	mullw	64
	movf	LCDCOLUMN,W,ACCESS
	addwf	PRODL,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	128
	iorwf	SysTemp1,W,BANKED
	movwf	LCDBYTE,ACCESS
	rcall	LCDNORMALWRITEBYTE
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	goto	Delay_10US

;********************************************************************************

MEMORY_ISR
	incf	FLAGCOUNTER,F,ACCESS
SysSelect2Case1
	movlw	11
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
	movlw	6
	subwf	FLAGCOUNTER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF66
	clrf	SysTemp1,BANKED
	btfsc	PORTB,3,ACCESS
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	LATB,3,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,3,ACCESS
	movff	EEPROM_ADDRESS,SYSEEADDRESS
	clrf	SYSEEADDRESS_H,BANKED
	clrf	ADREADPORT,ACCESS
	call	FN_READAD46
	movff	SYSREADADBYTE,EEDATA
	rcall	NVMADR_EPWRITE
	clrf	FLAGCOUNTER,ACCESS
ENDIF66
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	13
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
	movlw	20
	subwf	FLAGCOUNTER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF67
	clrf	SysTemp1,BANKED
	btfsc	PORTB,3,ACCESS
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	LATB,3,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,3,ACCESS
	movff	NVMADDRESS,_PFM_ADDR
	movff	NVMADDRESS_H,_PFM_ADDR_H
	movff	NVMADDRESS_U,_PFM_ADDR_U
	movff	NVMADDRESS_E,_PFM_ADDR_E
	clrf	ADREADPORT,ACCESS
	call	FN_READAD1048
	movff	SYSREADAD10WORD,_PFM_DATAWORD
	movff	SYSREADAD10WORD_H,_PFM_DATAWORD_H
	rcall	PFMWRITE311
	clrf	FLAGCOUNTER,ACCESS
ENDIF67
	bra	SysSelectEnd2
SysSelect2Case3
	movlw	17
	subwf	LABNUMBER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
	movlw	130
	movwf	TMR1H,ACCESS
	clrf	TMR1L,ACCESS
	movlw	60
	subwf	TICCOUNT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE68_1
	btfss	SYSBITVAR0,3,BANKED
	bra	ELSE69_1
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	rcall	PRINT157
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
	call	HSERPRINT384
	bra	ENDIF69
ELSE69_1
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	rcall	PRINT157
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
	call	HSERPRINT384
ENDIF69
	clrf	SysTemp1,BANKED
	btfsc	SYSBITVAR0,3,BANKED
	incf	SysTemp1,F,BANKED
	comf	SysTemp1,F,BANKED
	bcf	SYSBITVAR0,3,BANKED
	btfsc	SysTemp1,0,BANKED
	bsf	SYSBITVAR0,3,BANKED
	clrf	TICCOUNT,BANKED
	bra	ENDIF68
ELSE68_1
	incf	TICCOUNT,F,BANKED
ENDIF68
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	5
	movwf	LCDCOLUMN,ACCESS
	rcall	LOCATE
	movff	TICCOUNT,LCDVALUE
	rcall	PRINT158
	movff	TICCOUNT,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT386
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
SysSelectEnd2
	banksel	PIR4
	bcf	PIR4,TMR1IF,BANKED
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STOPTIMER
	movlw	1
	movwf	TMRNUMBER,BANKED
	movlw	220
	movwf	TMRVALUE,BANKED
	movlw	11
	movwf	TMRVALUE_H,BANKED
	call	SETTIMER228
	movlw	1
	movwf	TMRNUMBER,BANKED
	goto	STARTTIMER

;********************************************************************************

NEXTLAB
	clrf	SWITCHEVENT,BANKED
	incf	LABNUMBER,F,ACCESS
	movf	LABNUMBER,W,ACCESS
	sublw	18
	btfsc	STATUS, C,ACCESS
	bra	ENDIF131
	movlw	1
	movwf	LABNUMBER,ACCESS
ENDIF131
	return

;********************************************************************************

NVMADR_EPREAD
	movlw	49
	movwf	NVMADRU,ACCESS
	movff	SYSEEADDRESS_H,NVMADRH
	movff	SYSEEADDRESS,NVMADRL
	bsf	NVMCON1,RD,ACCESS
	nop
	nop
	nop
	nop
	movff	NVMDATL,EEDATAVALUE
	return

;********************************************************************************

NVMADR_EPWRITE
	bcf	SYSBITVAR0,6,BANKED
	btfsc	INTCON,GIE,ACCESS
	bsf	SYSBITVAR0,6,BANKED
	bcf	SYSBITVAR1,1,BANKED
	btfsc	NVMCON1,0,ACCESS
	bsf	SYSBITVAR1,1,BANKED
	bcf	SYSBITVAR1,2,BANKED
	btfsc	NVMCON1,1,ACCESS
	bsf	SYSBITVAR1,2,BANKED
	bcf	SYSBITVAR1,3,BANKED
	btfsc	NVMCON1,2,ACCESS
	bsf	SYSBITVAR1,3,BANKED
	movlw	49
	movwf	NVMADRU,ACCESS
	movff	SYSEEADDRESS_H,NVMADRH
	movff	SYSEEADDRESS,NVMADRL
	movff	EEDATA,NVMDATL
	bsf	NVMCON0,NVMEN,ACCESS
	bcf	INTCON,GIE,ACCESS
	movlw	85
	movwf	NVMCON2,ACCESS
	movlw	170
	movwf	NVMCON2,ACCESS
	bsf	NVMCON1,WR,ACCESS
	nop
	nop
	nop
	nop
	nop
SysWaitLoop5
	btfsc	NVMCON1,WR,ACCESS
	bra	SysWaitLoop5
	bcf	NVMCON0,NVMEN,ACCESS
	bcf	NVMCON1,0,ACCESS
	btfsc	SYSBITVAR1,1,BANKED
	bsf	NVMCON1,0,ACCESS
	bcf	NVMCON1,1,ACCESS
	btfsc	SYSBITVAR1,2,BANKED
	bsf	NVMCON1,1,ACCESS
	bcf	NVMCON1,2,ACCESS
	btfsc	SYSBITVAR1,3,BANKED
	bsf	NVMCON1,2,ACCESS
	btfss	SYSBITVAR0,6,BANKED
	bcf	INTCON,GIE,ACCESS
	btfsc	SYSBITVAR0,6,BANKED
	bsf	INTCON,GIE,ACCESS
	return

;********************************************************************************

NVMEMORY
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF91
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
	clrf	FLAGCOUNTER,ACCESS
	movlw	128
	movwf	NVMADDRESS,ACCESS
	setf	NVMADDRESS_H,ACCESS
	movlw	1
	movwf	NVMADDRESS_U,ACCESS
	clrf	NVMADDRESS_E,ACCESS
	call	CLS
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
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
	rcall	PRINT157
	movlw	1
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
	rcall	MEMORY_ISR
	movlw	1
	movwf	TMRSOURCE,BANKED
	movlw	32
	movwf	TMRPRES,BANKED
	call	INITTIMER1
	movlw	1
	movwf	TMRNUMBER,BANKED
	movlw	220
	movwf	TMRVALUE,BANKED
	movlw	11
	movwf	TMRVALUE_H,BANKED
	call	SETTIMER228
	banksel	PIR4
	bcf	PIR4,TMR1IF,BANKED
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STARTTIMER
	banksel	PIE4
	bsf	PIE4,TMR1IE,BANKED
	movlw	1
	movwf	LABSTATE,ACCESS
ENDIF91
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF92
	movf	FLAGCOUNTER,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF94
	movlw	1
	movwf	FLAGCOUNTER,ACCESS
	movff	NVMADDRESS,_TFM_ABS_ADDR
	movff	NVMADDRESS_H,_TFM_ABS_ADDR_H
	movff	NVMADDRESS_U,_TFM_ABS_ADDR_U
	movff	NVMADDRESS_E,_TFM_ABS_ADDR_E
	banksel	0
	rcall	FN_PFMREADWORD
	movff	PFMREADWORD,PFMADCRESULT
	movff	PFMREADWORD_H,PFMADCRESULT_H
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	rcall	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	rcall	PRINT157
	movff	NVMADDRESS_U,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT157
	movff	NVMADDRESS_H,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT157
	movff	NVMADDRESS,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	10
	movwf	LCDCOLUMN,ACCESS
	rcall	LOCATE
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
	rcall	PRINT157
	movff	PFMADCRESULT_H,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT157
	movff	PFMADCRESULT,SYSVALTEMP
	call	FN__HEXPICAS
	movlw	low _HEXPICAS
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high _HEXPICAS
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT157
	movlw	2
	addwf	NVMADDRESS,F,ACCESS
	movlw	0
	addwfc	NVMADDRESS_H,F,ACCESS
	movlw	0
	addwfc	NVMADDRESS_U,F,ACCESS
	movlw	0
	addwfc	NVMADDRESS_E,F,ACCESS
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
	movlw	128
	movwf	NVMADDRESS,ACCESS
	setf	NVMADDRESS_H,ACCESS
	movlw	1
	movwf	NVMADDRESS_U,ACCESS
	clrf	NVMADDRESS_E,ACCESS
ENDIF95
	movff	PFMADCRESULT,SYSWORDTEMPB
	movff	PFMADCRESULT_H,SYSWORDTEMPB_H
	movlw	7
	movwf	NUMBITS,ACCESS
	call	FN_FNLSR126
	movff	SYSFNLSRWORD,PFMADCRESULT
	movff	SYSFNLSRWORD_H,PFMADCRESULT_H
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp2,BANKED
	iorwf	PFMADCRESULT,W,ACCESS
	movwf	PORTB,ACCESS
ENDIF94
ENDIF92
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF93
	banksel	PIE4
	bcf	PIE4,TMR1IE,BANKED
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER,BANKED
	call	STOPTIMER
	clrf	LABSTATE,ACCESS
ENDIF93
	return

;********************************************************************************

FN_PAD
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSSTRLEN,W,BANKED
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ELSE272_1
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
	lfsr	1,PAD
	movlw	low StringTable167
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable167
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable167
	movwf	TBLPTRU,ACCESS
	call	SYSREADSTRING
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd15
SysForLoop15
	incf	SYSSTRINGTEMP,F,BANKED
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
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop15
SysForLoopEnd15
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
	movf	SYSSTRLEN,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop16
SysForLoopEnd16
	movff	SYSSTRLEN,SYSPAD_0
	bra	ENDIF272
ELSE272_1
	clrf	SYSSTRINGTEMP,BANKED
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd17
SysForLoop17
	incf	SYSSTRINGTEMP,F,BANKED
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
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop17
SysForLoopEnd17
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SYSPAD_0
ENDIF272
	return

;********************************************************************************

FN_PFMREADWORD
	tblrd*+
	movff	TABLAT,PFMREADWORD
	clrf	PFMREADWORD_H,ACCESS
	tblrd*+
	movff	TABLAT,PFMREADWORD_H
	return

;********************************************************************************

PFMWRITE311
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
	movlw	low _PFM_BUFFER
	movwf	Sys_PFM_BUFFERHandler,BANKED
	movlw	high _PFM_BUFFER
	movwf	Sys_PFM_BUFFERHandler_H,BANKED
	movlw	128
	movwf	_PFM_COUNT,BANKED
	clrf	_PFM_COUNT_H,BANKED
	call	_PFMREADBLOCK
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
	movlw	low _PFM_BUFFER
	movwf	Sys_PFM_BUFFERHandler,BANKED
	movlw	high _PFM_BUFFER
	movwf	Sys_PFM_BUFFERHandler_H,BANKED
	movlw	128
	movwf	_PFM_COUNT,BANKED
	clrf	_PFM_COUNT_H,BANKED
	goto	_PFMWRITEBLOCK

;********************************************************************************

PLAYRTTTL
	movlw	2
	movwf	SOUNDPLAYMODE,BANKED
	movff	SysSOUNDPLAYDATAHandler,AFSR0
	movff	SysSOUNDPLAYDATAHandler_H,AFSR0_H
	movff	INDF0,SOUNDPLAYBYTES
	clrf	SOUNDPLAYCURRNOTE,BANKED
	movlw	1
	subwf	SOUNDPLAYBYTES,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd8
SysForLoop8
	incf	SOUNDPLAYCURRNOTE,F,BANKED
	movf	SOUNDPLAYCURRNOTE,W,BANKED
	addwf	SysSOUNDPLAYDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSOUNDPLAYDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movlw	58
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	decf	SOUNDPLAYMODE,F,BANKED
	movf	SOUNDPLAYBYTES,W,BANKED
	subwf	SOUNDPLAYCURRNOTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop8
SysForLoopEnd8
	clrf	SOUNDPLAYNUMBER,BANKED
	incf	SOUNDPLAYBYTES,F,BANKED
	clrf	SOUNDPLAYCURRNOTE,BANKED
	movlw	1
	subwf	SOUNDPLAYBYTES,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd9
SysForLoop9
	incf	SOUNDPLAYCURRNOTE,F,BANKED
	movf	SOUNDPLAYBYTES,W,BANKED
	subwf	SOUNDPLAYCURRNOTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE140_1
	movlw	44
	movwf	SOUNDPLAYBYTE,BANKED
	bra	ENDIF140
ELSE140_1
	movf	SOUNDPLAYCURRNOTE,W,BANKED
	addwf	SysSOUNDPLAYDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSOUNDPLAYDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SOUNDPLAYBYTE
ENDIF140
	movff	SOUNDPLAYBYTE,SysBYTETempB
	movlw	90
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF141
	movff	SOUNDPLAYBYTE,SysBYTETempA
	movlw	65
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF151
	movlw	32
	addwf	SOUNDPLAYBYTE,F,BANKED
ENDIF151
ENDIF141
	movff	SOUNDPLAYBYTE,SysBYTETempA
	movlw	97
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF142
	movff	SOUNDPLAYBYTE,SysBYTETempB
	movlw	122
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF152
	movff	SOUNDPLAYBYTE,SOUNDPLAYCOMMAND
	movff	SOUNDPLAYNUMBER,SOUNDPLAYNUMBER2
	clrf	SOUNDPLAYNUMBER,BANKED
	bra	SOUNDPLAYRTTTLNEXTNOTE
ENDIF152
ENDIF142
	movff	SOUNDPLAYBYTE,SysBYTETempA
	movlw	48
	movwf	SysBYTETempB,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF143
	movff	SOUNDPLAYBYTE,SysBYTETempB
	movlw	57
	movwf	SysBYTETempA,ACCESS
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF153
	movf	SOUNDPLAYNUMBER,W,BANKED
	mullw	10
	movf	SOUNDPLAYBYTE,W,BANKED
	addwf	PRODL,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	48
	subwf	SysTemp2,W,BANKED
	movwf	SOUNDPLAYNUMBER,BANKED
	bra	SOUNDPLAYRTTTLNEXTNOTE
ENDIF153
ENDIF143
SysSelect3Case1
	movf	SOUNDPLAYMODE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
	movlw	58
	subwf	SOUNDPLAYBYTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF144
	incf	SOUNDPLAYMODE,F,BANKED
	clrf	SOUNDPLAYCOMMAND,BANKED
	clrf	SOUNDPLAYNUMBER,BANKED
ENDIF144
	bra	SysSelectEnd3
SysSelect3Case2
	decf	SOUNDPLAYMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case3
	movlw	58
	subwf	SOUNDPLAYBYTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF145
	incf	SOUNDPLAYMODE,F,BANKED
	bra	SOUNDPLAYRTTTLCOMMA
ENDIF145
	movlw	44
	subwf	SOUNDPLAYBYTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF146
SOUNDPLAYRTTTLCOMMA
	movlw	100
	subwf	SOUNDPLAYCOMMAND,W,BANKED
	btfsc	STATUS, Z,ACCESS
	movff	SOUNDPLAYNUMBER,SOUNDPLAYLENGTH
	movlw	111
	subwf	SOUNDPLAYCOMMAND,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF155
	movlw	2
	subwf	SOUNDPLAYNUMBER,W,BANKED
	movwf	SOUNDPLAYOCTAVE,BANKED
ENDIF155
	movlw	98
	subwf	SOUNDPLAYCOMMAND,W,BANKED
	btfsc	STATUS, Z,ACCESS
	movff	SOUNDPLAYNUMBER,SOUNDPLAYTEMPO
	clrf	SOUNDPLAYNUMBER,BANKED
	clrf	SOUNDPLAYCOMMAND,BANKED
ENDIF146
	bra	SysSelectEnd3
SysSelect3Case3
	movlw	2
	subwf	SOUNDPLAYMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd3
	movlw	35
	subwf	SOUNDPLAYBYTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF147
	movlw	1
	movwf	SOUNDPLAYNOTETYPE,BANKED
ENDIF147
	movlw	46
	subwf	SOUNDPLAYBYTE,W,BANKED
	btfsc	STATUS, Z,ACCESS
	incf	SOUNDPLAYDOTS,F,BANKED
	movlw	44
	subwf	SOUNDPLAYBYTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF149
	movf	SOUNDPLAYCOMMAND,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF157
	movlw	112
	subwf	SOUNDPLAYCOMMAND,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE158_1
	movf	SOUNDPLAYNUMBER2,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE159_1
	movff	SOUNDPLAYLENGTH,SOUNDPLAYNOTELEN
	bra	ENDIF159
ELSE159_1
	movff	SOUNDPLAYNUMBER2,SOUNDPLAYNOTELEN
ENDIF159
	clrf	SOUNDPLAYNOTE,BANKED
	call	SOUNDPLAYTONE
	bra	ENDIF158
ELSE158_1
	movf	SOUNDPLAYNUMBER,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE160_1
	movff	SOUNDPLAYOCTAVE,SOUNDPLAYNOTEOCTAVE
	bra	ENDIF160
ELSE160_1
	movlw	2
	subwf	SOUNDPLAYNUMBER,W,BANKED
	movwf	SOUNDPLAYNOTEOCTAVE,BANKED
ENDIF160
	movf	SOUNDPLAYNUMBER2,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE161_1
	movff	SOUNDPLAYLENGTH,SOUNDPLAYNOTELEN
	bra	ENDIF161
ELSE161_1
	movff	SOUNDPLAYNUMBER2,SOUNDPLAYNOTELEN
ENDIF161
	movlw	96
	subwf	SOUNDPLAYCOMMAND,W,BANKED
	movwf	SYSSTRINGA,ACCESS
	call	SOUNDPLAYNOTENUMBERS
	movwf	SOUNDPLAYNOTE,BANKED
	movf	SOUNDPLAYNOTEOCTAVE,W,BANKED
	mullw	12
	movf	SOUNDPLAYNOTE,W,BANKED
	addwf	PRODL,W,ACCESS
	movwf	SOUNDPLAYNOTE,BANKED
	movf	SOUNDPLAYNOTELEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	movff	SOUNDPLAYLENGTH,SOUNDPLAYNOTELEN
	decf	SOUNDPLAYNOTETYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF163
	incf	SOUNDPLAYNOTE,F,BANKED
	movlw	85
	subwf	SOUNDPLAYNOTE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF165
	movlw	84
	movwf	SOUNDPLAYNOTE,BANKED
ENDIF165
ENDIF163
	call	SOUNDPLAYTONE
	movf	SOUNDPLAYDOTS,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF164
	movf	SOUNDPLAYNOTELEN,W,BANKED
	mullw	2
	movff	PRODL,SOUNDPLAYNOTELEN
	call	SOUNDPLAYTONE
ENDIF164
ENDIF158
	clrf	SOUNDPLAYNUMBER,BANKED
	clrf	SOUNDPLAYNUMBER2,BANKED
	clrf	SOUNDPLAYNOTETYPE,BANKED
	clrf	SOUNDPLAYCOMMAND,BANKED
	clrf	SOUNDPLAYDOTS,BANKED
ENDIF157
ENDIF149
SysSelectEnd3
SOUNDPLAYRTTTLNEXTNOTE
	movf	SOUNDPLAYBYTES,W,BANKED
	subwf	SOUNDPLAYCURRNOTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
	return

;********************************************************************************

PRINT157
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	return
	bsf	LATD,4,ACCESS
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd11
SysForLoop11
	incf	SYSPRINTTEMP,F,BANKED
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,LCDBYTE
	call	LCDNORMALWRITEBYTE
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop11
SysForLoopEnd11
	return

;********************************************************************************

PRINT158
	clrf	LCDVALUETEMP,ACCESS
	bsf	LATD,4,ACCESS
	movlw	100
	subwf	LCDVALUE,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	ENDIF200
	movff	LCDVALUE,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempA,LCDVALUETEMP
	movff	SYSCALCTEMPX,LCDVALUE
	movlw	48
	addwf	LCDVALUETEMP,W,ACCESS
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
ENDIF200
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
	movff	LCDVALUE,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SYSDIVSUB
	movff	SysBYTETempA,LCDVALUETEMP
	movff	SYSCALCTEMPX,LCDVALUE
	movlw	48
	addwf	LCDVALUETEMP,W,ACCESS
	movwf	LCDBYTE,ACCESS
	call	LCDNORMALWRITEBYTE
ENDIF201
	movlw	48
	addwf	LCDVALUE,W,ACCESS
	movwf	LCDBYTE,ACCESS
	goto	LCDNORMALWRITEBYTE

;********************************************************************************

PWM
	movlw	5
	banksel	RB0PPS
	movwf	RB0PPS,BANKED
	movlw	8
	movwf	CCP1PPS,BANKED
	movlw	5
	movwf	RB1PPS,BANKED
	movlw	9
	movwf	CCP1PPS,BANKED
	movlw	5
	movwf	RB2PPS,BANKED
	movlw	10
	movwf	CCP1PPS,BANKED
	movlw	5
	movwf	RB3PPS,BANKED
	movlw	11
	movwf	CCP1PPS,BANKED
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF32
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
	call	CLS
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
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
	rcall	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	rcall	PRINT157
	movlw	1
	movwf	LABSTATE,ACCESS
	movlw	1
	movwf	PWMCHANNEL,BANKED
	movlw	40
	movwf	PWMFREQ,BANKED
	clrf	PWMDUTY,BANKED
	clrf	PWMDUTY_H,BANKED
	call	HPWM66
ENDIF32
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF33
	clrf	ADREADPORT,ACCESS
	banksel	0
	rcall	FN_READAD46
	movff	SYSREADADBYTE,ADCRESULT
	clrf	ADCRESULT_H,ACCESS
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
	movlw	1
	movwf	PWMCHANNEL,BANKED
	movlw	40
	movwf	PWMFREQ,BANKED
	movff	ADCRESULT,PWMDUTY
	movff	ADCRESULT_H,PWMDUTY_H
	call	HPWM66
	movff	PWMDUTY,ADCRESULT
	movff	PWMDUTY_H,ADCRESULT_H
	movff	ADCRESULT,OLDADCRESULT
	movff	ADCRESULT_H,OLDADCRESULT_H
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	rcall	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	12
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT157
ENDIF35
ENDIF33
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF34
	clrf	LABSTATE,ACCESS
	rcall	PWMOFF62
	banksel	RB0PPS
	clrf	RB0PPS,BANKED
	clrf	CCP1PPS,BANKED
	clrf	RB1PPS,BANKED
	clrf	CCP1PPS,BANKED
	clrf	RB2PPS,BANKED
	clrf	CCP1PPS,BANKED
	clrf	RB3PPS,BANKED
	clrf	CCP1PPS,BANKED
ENDIF34
	banksel	0
	return

;********************************************************************************

PWMOFF62
	clrf	CCP1CON,ACCESS
	return

;********************************************************************************

FN_RANDOM
	movlw	7
	movwf	SysRepeatTemp14,BANKED
SysRepeatLoop14
	movff	RANDOMSEED,RANDOMTEMP
	movff	RANDOMSEED_H,RANDOMTEMP_H
	rlcf	RANDOMTEMP_H,W,BANKED
	rlcf	RANDOMTEMP,F,BANKED
	rlcf	RANDOMTEMP_H,F,BANKED
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
	movf	RANDOM,W,BANKED
	xorwf	RANDOMSEED_H,W,BANKED
	movwf	RANDOM,BANKED
	decfsz	SysRepeatTemp14,F,BANKED
	bra	SysRepeatLoop14
SysRepeatLoopEnd14
	return

;********************************************************************************

RANDOMIZE
	movf	RANDOMTEMP,W,BANKED
	addwf	RANDOMSEED,F,BANKED
	movf	RANDOMTEMP_H,W,BANKED
	addwfc	RANDOMSEED_H,F,BANKED
	movff	RANDOMSEED,SysWORDTempA
	movff	RANDOMSEED_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF267
	movlw	1
	movwf	RANDOMSEED,BANKED
	clrf	RANDOMSEED_H,BANKED
ENDIF267
	return

;********************************************************************************

FN_READAD46
	banksel	ADCON0
	bcf	ADCON0,ADFM,BANKED
	movff	ADREADPORT,ADPCH
SysSelect4Case1
	movf	ADREADPORT,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
	bsf	ANSELA,0,BANKED
	bra	SysSelectEnd4
SysSelect4Case2
	decf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
	bsf	ANSELA,1,BANKED
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	2
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case4
	bsf	ANSELA,2,BANKED
	bra	SysSelectEnd4
SysSelect4Case4
	movlw	3
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case5
	bsf	ANSELA,3,BANKED
	bra	SysSelectEnd4
SysSelect4Case5
	movlw	4
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case6
	bsf	ANSELA,4,BANKED
	bra	SysSelectEnd4
SysSelect4Case6
	movlw	5
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case7
	bsf	ANSELA,5,BANKED
	bra	SysSelectEnd4
SysSelect4Case7
	movlw	6
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case8
	bsf	ANSELA,6,BANKED
	bra	SysSelectEnd4
SysSelect4Case8
	movlw	7
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case9
	bsf	ANSELA,7,BANKED
	bra	SysSelectEnd4
SysSelect4Case9
	movlw	8
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case10
	bsf	ANSELB,0,BANKED
	bra	SysSelectEnd4
SysSelect4Case10
	movlw	9
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case11
	bsf	ANSELB,1,BANKED
	bra	SysSelectEnd4
SysSelect4Case11
	movlw	10
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case12
	bsf	ANSELB,2,BANKED
	bra	SysSelectEnd4
SysSelect4Case12
	movlw	11
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case13
	bsf	ANSELB,3,BANKED
	bra	SysSelectEnd4
SysSelect4Case13
	movlw	12
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case14
	bsf	ANSELB,4,BANKED
	bra	SysSelectEnd4
SysSelect4Case14
	movlw	13
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case15
	bsf	ANSELB,5,BANKED
	bra	SysSelectEnd4
SysSelect4Case15
	movlw	14
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case16
	bsf	ANSELB,6,BANKED
	bra	SysSelectEnd4
SysSelect4Case16
	movlw	15
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case17
	bsf	ANSELB,7,BANKED
	bra	SysSelectEnd4
SysSelect4Case17
	movlw	16
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case18
	bsf	ANSELC,0,BANKED
	bra	SysSelectEnd4
SysSelect4Case18
	movlw	17
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case19
	bsf	ANSELC,1,BANKED
	bra	SysSelectEnd4
SysSelect4Case19
	movlw	18
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case20
	bsf	ANSELC,2,BANKED
	bra	SysSelectEnd4
SysSelect4Case20
	movlw	19
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case21
	bsf	ANSELC,3,BANKED
	bra	SysSelectEnd4
SysSelect4Case21
	movlw	20
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case22
	bsf	ANSELC,4,BANKED
	bra	SysSelectEnd4
SysSelect4Case22
	movlw	21
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case23
	bsf	ANSELC,5,BANKED
	bra	SysSelectEnd4
SysSelect4Case23
	movlw	22
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case24
	bsf	ANSELC,6,BANKED
	bra	SysSelectEnd4
SysSelect4Case24
	movlw	23
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case25
	bsf	ANSELC,7,BANKED
	bra	SysSelectEnd4
SysSelect4Case25
	movlw	24
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case26
	bsf	ANSELD,0,BANKED
	bra	SysSelectEnd4
SysSelect4Case26
	movlw	25
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case27
	bsf	ANSELD,1,BANKED
	bra	SysSelectEnd4
SysSelect4Case27
	movlw	26
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case28
	bsf	ANSELD,2,BANKED
	bra	SysSelectEnd4
SysSelect4Case28
	movlw	27
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case29
	bsf	ANSELD,3,BANKED
	bra	SysSelectEnd4
SysSelect4Case29
	movlw	28
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case30
	bsf	ANSELD,4,BANKED
	bra	SysSelectEnd4
SysSelect4Case30
	movlw	29
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case31
	bsf	ANSELD,5,BANKED
	bra	SysSelectEnd4
SysSelect4Case31
	movlw	30
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case32
	bsf	ANSELD,6,BANKED
	bra	SysSelectEnd4
SysSelect4Case32
	movlw	31
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case33
	bsf	ANSELD,7,BANKED
	bra	SysSelectEnd4
SysSelect4Case33
	movlw	32
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case34
	bsf	ANSELE,0,BANKED
	bra	SysSelectEnd4
SysSelect4Case34
	movlw	33
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case35
	bsf	ANSELE,1,BANKED
	bra	SysSelectEnd4
SysSelect4Case35
	movlw	34
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd4
	bsf	ANSELE,2,BANKED
SysSelectEnd4
	bcf	ADCON0,ADCS,BANKED
	movlw	1
	movwf	ADCLK,BANKED
	bcf	ADCON0,ADCS,BANKED
	movlw	15
	movwf	ADCLK,BANKED
	bcf	ADCLK,ADCS2,BANKED
	bcf	ADCLK,ADCS1,BANKED
	bsf	ADCLK,ADCS0,BANKED
	bcf	ADCON0,ADFM,BANKED
	bcf	ADCON0,ADFM0,BANKED
	movff	ADREADPORT,ADPCH
	bsf	ADCON0,ADON,BANKED
	movlw	2
	movwf	SysWaitTemp10US,ACCESS
	banksel	0
	call	Delay_10US
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE,BANKED
	nop
SysWaitLoop3
	btfsc	ADCON0,GO_NOT_DONE,BANKED
	bra	SysWaitLoop3
	bcf	ADCON0,ADON,BANKED
	clrf	ANSELA,BANKED
	clrf	ANSELB,BANKED
	clrf	ANSELC,BANKED
	clrf	ANSELD,BANKED
	clrf	ANSELE,BANKED
	movff	ADRESH,READAD
	bcf	ADCON0,ADFM,BANKED
	banksel	0
	return

;********************************************************************************

FN_READAD1048
	banksel	ADCON0
	bsf	ADCON0,ADFM,BANKED
	movff	ADREADPORT,ADPCH
SysSelect5Case1
	movf	ADREADPORT,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case2
	bsf	ANSELA,0,BANKED
	bra	SysSelectEnd5
SysSelect5Case2
	decf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case3
	bsf	ANSELA,1,BANKED
	bra	SysSelectEnd5
SysSelect5Case3
	movlw	2
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case4
	bsf	ANSELA,2,BANKED
	bra	SysSelectEnd5
SysSelect5Case4
	movlw	3
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case5
	bsf	ANSELA,3,BANKED
	bra	SysSelectEnd5
SysSelect5Case5
	movlw	4
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case6
	bsf	ANSELA,4,BANKED
	bra	SysSelectEnd5
SysSelect5Case6
	movlw	5
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case7
	bsf	ANSELA,5,BANKED
	bra	SysSelectEnd5
SysSelect5Case7
	movlw	6
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case8
	bsf	ANSELA,6,BANKED
	bra	SysSelectEnd5
SysSelect5Case8
	movlw	7
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case9
	bsf	ANSELA,7,BANKED
	bra	SysSelectEnd5
SysSelect5Case9
	movlw	8
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case10
	bsf	ANSELB,0,BANKED
	bra	SysSelectEnd5
SysSelect5Case10
	movlw	9
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case11
	bsf	ANSELB,1,BANKED
	bra	SysSelectEnd5
SysSelect5Case11
	movlw	10
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case12
	bsf	ANSELB,2,BANKED
	bra	SysSelectEnd5
SysSelect5Case12
	movlw	11
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case13
	bsf	ANSELB,3,BANKED
	bra	SysSelectEnd5
SysSelect5Case13
	movlw	12
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case14
	bsf	ANSELB,4,BANKED
	bra	SysSelectEnd5
SysSelect5Case14
	movlw	13
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case15
	bsf	ANSELB,5,BANKED
	bra	SysSelectEnd5
SysSelect5Case15
	movlw	14
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case16
	bsf	ANSELB,6,BANKED
	bra	SysSelectEnd5
SysSelect5Case16
	movlw	15
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case17
	bsf	ANSELB,7,BANKED
	bra	SysSelectEnd5
SysSelect5Case17
	movlw	16
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case18
	bsf	ANSELC,0,BANKED
	bra	SysSelectEnd5
SysSelect5Case18
	movlw	17
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case19
	bsf	ANSELC,1,BANKED
	bra	SysSelectEnd5
SysSelect5Case19
	movlw	18
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case20
	bsf	ANSELC,2,BANKED
	bra	SysSelectEnd5
SysSelect5Case20
	movlw	19
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case21
	bsf	ANSELC,3,BANKED
	bra	SysSelectEnd5
SysSelect5Case21
	movlw	20
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case22
	bsf	ANSELC,4,BANKED
	bra	SysSelectEnd5
SysSelect5Case22
	movlw	21
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case23
	bsf	ANSELC,5,BANKED
	bra	SysSelectEnd5
SysSelect5Case23
	movlw	22
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case24
	bsf	ANSELC,6,BANKED
	bra	SysSelectEnd5
SysSelect5Case24
	movlw	23
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case25
	bsf	ANSELC,7,BANKED
	bra	SysSelectEnd5
SysSelect5Case25
	movlw	24
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case26
	bsf	ANSELD,0,BANKED
	bra	SysSelectEnd5
SysSelect5Case26
	movlw	25
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case27
	bsf	ANSELD,1,BANKED
	bra	SysSelectEnd5
SysSelect5Case27
	movlw	26
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case28
	bsf	ANSELD,2,BANKED
	bra	SysSelectEnd5
SysSelect5Case28
	movlw	27
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case29
	bsf	ANSELD,3,BANKED
	bra	SysSelectEnd5
SysSelect5Case29
	movlw	28
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case30
	bsf	ANSELD,4,BANKED
	bra	SysSelectEnd5
SysSelect5Case30
	movlw	29
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case31
	bsf	ANSELD,5,BANKED
	bra	SysSelectEnd5
SysSelect5Case31
	movlw	30
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case32
	bsf	ANSELD,6,BANKED
	bra	SysSelectEnd5
SysSelect5Case32
	movlw	31
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case33
	bsf	ANSELD,7,BANKED
	bra	SysSelectEnd5
SysSelect5Case33
	movlw	32
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case34
	bsf	ANSELE,0,BANKED
	bra	SysSelectEnd5
SysSelect5Case34
	movlw	33
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case35
	bsf	ANSELE,1,BANKED
	bra	SysSelectEnd5
SysSelect5Case35
	movlw	34
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd5
	bsf	ANSELE,2,BANKED
SysSelectEnd5
	bcf	ADCON0,ADCS,BANKED
	movlw	1
	movwf	ADCLK,BANKED
	bcf	ADCON0,ADCS,BANKED
	movlw	15
	movwf	ADCLK,BANKED
	bcf	ADCLK,ADCS2,BANKED
	bcf	ADCLK,ADCS1,BANKED
	bsf	ADCLK,ADCS0,BANKED
	bsf	ADCON0,ADFM,BANKED
	bsf	ADCON0,ADFM0,BANKED
	movff	ADREADPORT,ADPCH
	bsf	ADCON0,ADON,BANKED
	movlw	2
	movwf	SysWaitTemp10US,ACCESS
	banksel	0
	call	Delay_10US
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE,BANKED
	nop
SysWaitLoop4
	btfsc	ADCON0,GO_NOT_DONE,BANKED
	bra	SysWaitLoop4
	bcf	ADCON0,ADON,BANKED
	clrf	ANSELA,BANKED
	clrf	ANSELB,BANKED
	clrf	ANSELC,BANKED
	clrf	ANSELD,BANKED
	clrf	ANSELE,BANKED
	movff	ADRESL,READAD10
	banksel	READAD10_H
	clrf	READAD10_H,BANKED
	movff	ADRESH,READAD10_H
	banksel	ADCON0
	bcf	ADCON0,ADFM,BANKED
	banksel	0
	return

;********************************************************************************

ROTATELEDS
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF13
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	1
	iorwf	SysTemp1,W,BANKED
	movwf	PORTB,ACCESS
	bsf	LATB,0,ACCESS
	movlw	1
	movwf	ACTIVELEDNUM,ACCESS
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	rcall	PRINT157
	movlw	1
	movwf	LABSTATE,ACCESS
ENDIF13
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF14
	movlw	10
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
	movlw	50
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	call	CHECKBUTTONS2
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd1
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
	movlw	15
	andwf	PORTB,W,ACCESS
	movwf	LEDSTATE,ACCESS
	bcf	STATUS,C,ACCESS
	rlcf	LEDSTATE,F,ACCESS
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	LEDSTATE,W,ACCESS
	movwf	LATB,ACCESS
	incf	ACTIVELEDNUM,F,ACCESS
	movf	ACTIVELEDNUM,W,ACCESS
	sublw	4
	btfsc	STATUS, C,ACCESS
	bra	ENDIF17
	bsf	LATB,0,ACCESS
	movlw	1
	movwf	ACTIVELEDNUM,ACCESS
ENDIF17
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	7
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
	incf	ACTIVELEDNUM,W,ACCESS
	movwf	LCDVALUE,ACCESS
	rcall	PRINT158
ENDIF14
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	clrf	LABSTATE,ACCESS
	return

;********************************************************************************

FN_SCALE117
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
	movf	L_FROMLOW,W,ACCESS
	subwf	L_FROMHIGH,W,ACCESS
	movwf	L_SYSCALC,ACCESS
	movf	L_FROMLOW_H,W,ACCESS
	subwfb	L_FROMHIGH_H,W,ACCESS
	movwf	L_SYSCALC_H,ACCESS
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

SETTIMER228
	movf	TMRNUMBER,F,BANKED
	btfsc	STATUS, Z,ACCESS
	movff	TMRVALUE_H,TMR0H
	decf	TMRNUMBER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF231
	movff	TMRVALUE_H,TMR1H
	movff	TMRVALUE,TMR1L
ENDIF231
	movlw	2
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	movff	TMRVALUE,TMR2
	movlw	3
	subwf	TMRNUMBER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF233
	movff	TMRVALUE_H,TMR3H
	movff	TMRVALUE,TMR3L
ENDIF233
	movlw	4
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	movff	TMRVALUE,TMR4
	movlw	5
	subwf	TMRNUMBER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF235
	movff	TMRVALUE_H,TMR5H
	movff	TMRVALUE,TMR5L
ENDIF235
	movlw	6
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	movff	TMRVALUE,TMR6
	return

;********************************************************************************

SLEEPWAKEUP
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF56
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
	bcf	LATB,3,ACCESS
	bcf	LATB,2,ACCESS
	bcf	LATB,1,ACCESS
	bcf	LATB,0,ACCESS
	bsf	LATB,3,ACCESS
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
	call	PRINT157
	movlw	5
	movwf	WDTTIMER,BANKED
	setf	COUNTERLOOP,ACCESS
SysForLoop1
	incf	COUNTERLOOP,F,ACCESS
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	13
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
	movff	WDTTIMER,LCDVALUE
	call	PRINT158
	decf	WDTTIMER,F,BANKED
	movlw	100
	movwf	SysRepeatTemp3,BANKED
SysRepeatLoop3
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	call	CHECKBUTTONS2
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF60
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	return
ENDIF60
	decfsz	SysRepeatTemp3,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
	movff	COUNTERLOOP,SysBYTETempA
	movlw	4
	movwf	SysBYTETempB,ACCESS
	rcall	SYSCOMPLESSTHAN
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	banksel	WDTCON0
	bsf	WDTCON0,SWDTEN,BANKED
	movff	OSCCON1,OSCSTATE
	sleep
	bcf	PIR1,OSCFIF,BANKED
	movff	OSCSTATE,OSCCON1
	movlw	1
	movwf	LABSTATE,ACCESS
ENDIF56
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF57
	bcf	LATB,3,ACCESS
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	banksel	0
	call	LOCATE
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
	call	PRINT157
	banksel	WDTCON0
	bcf	WDTCON0,SWDTEN,BANKED
ENDIF57
	banksel	SWITCHEVENT
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	clrf	LABSTATE,ACCESS
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

SOUNDPLAYTONE
	movf	SOUNDPLAYNOTE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE166_1
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
	bra	ENDIF166
ELSE166_1
	movff	SOUNDPLAYNOTE,SOUNDPLAYTEMP
	movf	SOUNDPLAYTEMP,W,BANKED
	sublw	24
	btfsc	STATUS, C,ACCESS
	bra	ENDIF167
	movlw	24
	subwf	SOUNDPLAYTEMP,F,BANKED
ENDIF167
	movff	SOUNDPLAYTEMP,SYSSTRINGA
	rcall	SOUNDPLAYNOTEPERIODS
	movwf	SOUNDPLAYPERIOD,BANKED
	movlw	96
	movwf	SysWORDTempA,ACCESS
	movlw	234
	movwf	SysWORDTempA_H,ACCESS
	movff	SOUNDPLAYTEMPO,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SOUNDPLAYCYCLES
	movff	SysWORDTempA_H,SOUNDPLAYCYCLES_H
	movf	SOUNDPLAYNOTE,W,BANKED
	sublw	24
	btfsc	STATUS, C,ACCESS
	bra	ELSE168_1
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
	bra	ENDIF168
ELSE168_1
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
ENDIF168
	movf	SOUNDPLAYNOTE,W,BANKED
	sublw	24
	btfss	STATUS, C,ACCESS
	bra	ELSE169_1
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
	bsf	LATC,2,ACCESS
	movff	SOUNDPLAYPERIOD,SysRepeatTemp6
	movf	SYSREPEATTEMP6,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd6
SysRepeatLoop6
	movlw	213
	movwf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
	decfsz	SysRepeatTemp6,F,BANKED
	bra	SysRepeatLoop6
SysRepeatLoopEnd6
	bcf	LATC,2,ACCESS
	movff	SOUNDPLAYPERIOD,SysRepeatTemp6
	movf	SYSREPEATTEMP6,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd7
SysRepeatLoop7
	movlw	213
	movwf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
	decfsz	SysRepeatTemp6,F,BANKED
	bra	SysRepeatLoop7
SysRepeatLoopEnd7
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop5
	decfsz	SysRepeatTemp5_H,F,BANKED
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
	bra	ENDIF169
ELSE169_1
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
	bsf	LATC,2,ACCESS
	movff	SOUNDPLAYPERIOD,SysWaitTemp10US
	call	Delay_10US
	bcf	LATC,2,ACCESS
	movff	SOUNDPLAYPERIOD,SysWaitTemp10US
	call	Delay_10US
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop8
	decfsz	SysRepeatTemp5_H,F,BANKED
	bra	SysRepeatLoop8
SysRepeatLoopEnd8
ENDIF169
ENDIF166
	return

;********************************************************************************

STARTTIMER
	movf	TMRNUMBER,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bsf	T0CON0,T0EN,ACCESS
	decf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bsf	T1CON,TMR1ON,ACCESS
	movlw	2
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bsf	T2CON,TMR2ON,ACCESS
	movlw	3
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bsf	T3CON,TMR3ON,ACCESS
	movlw	4
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bsf	T4CON,TMR4ON,ACCESS
	movlw	5
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bsf	T5CON,TMR5ON,ACCESS
	movlw	6
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bsf	T6CON,TMR6ON,ACCESS
	return

;********************************************************************************

STOPTIMER
	movf	TMRNUMBER,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bcf	T0CON0,T0EN,ACCESS
	decf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bcf	T1CON,TMR1ON,ACCESS
	movlw	2
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bcf	T2CON,TMR2ON,ACCESS
	movlw	3
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bcf	T3CON,TMR3ON,ACCESS
	movlw	4
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bcf	T4CON,TMR4ON,ACCESS
	movlw	5
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bcf	T5CON,TMR5ON,ACCESS
	movlw	6
	subwf	TMRNUMBER,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bcf	T6CON,TMR6ON,ACCESS
	return

;********************************************************************************

FN_STR
	clrf	SYSCHARCOUNT,BANKED
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
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
	incf	SYSCHARCOUNT,F,BANKED
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
	bra	SYSVALTHOUSANDS
ENDIF268
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
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
	incf	SYSCHARCOUNT,F,BANKED
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
	bra	SYSVALHUNDREDS
ENDIF269
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
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
	incf	SYSCHARCOUNT,F,BANKED
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
	bra	SYSVALTENS
ENDIF270
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
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSDIVSUB16
	movff	SysWORDTempA,SYSSTRDATA
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
	incf	SYSCHARCOUNT,F,BANKED
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
ENDIF271
	incf	SYSCHARCOUNT,F,BANKED
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSVALTEMP,W,BANKED
	movwf	INDF0,ACCESS
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
	movff	SYSCHARCOUNT,SYSSTR_0
	return

;********************************************************************************

SYSCOMPEQUAL
	setf	SYSBYTETEMPX,ACCESS
	movf	SYSBYTETEMPB, W,ACCESS
	cpfseq	SYSBYTETEMPA,ACCESS
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOMPEQUAL16
	clrf	SYSBYTETEMPX,ACCESS
	movf	SYSWORDTEMPB, W,ACCESS
	cpfseq	SYSWORDTEMPA,ACCESS
	return
	movf	SYSWORDTEMPB_H, W,ACCESS
	cpfseq	SYSWORDTEMPA_H,ACCESS
	return
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOMPEQUAL32
	clrf	SYSBYTETEMPX,ACCESS
	movf	SYSLONGTEMPB, W,ACCESS
	cpfseq	SYSLONGTEMPA,ACCESS
	return
	movf	SYSLONGTEMPB_H, W,ACCESS
	cpfseq	SYSLONGTEMPA_H,ACCESS
	return
	movf	SYSLONGTEMPB_U, W,ACCESS
	cpfseq	SYSLONGTEMPA_U,ACCESS
	return
	movf	SYSLONGTEMPB_E, W,ACCESS
	cpfseq	SYSLONGTEMPA_E,ACCESS
	return
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOMPLESSTHAN
	setf	SYSBYTETEMPX,ACCESS
	movf	SYSBYTETEMPB, W,ACCESS
	cpfslt	SYSBYTETEMPA,ACCESS
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOMPLESSTHAN16
	clrf	SYSBYTETEMPX,ACCESS
	movf	SYSWORDTEMPA_H,W,ACCESS
	subwf	SYSWORDTEMPB_H,W,ACCESS
	btfss	STATUS,C,ACCESS
	return
	movf	SYSWORDTEMPB_H,W,ACCESS
	subwf	SYSWORDTEMPA_H,W,ACCESS
	bnc	SCLT16TRUE
	movf	SYSWORDTEMPB,W,ACCESS
	subwf	SYSWORDTEMPA,W,ACCESS
	btfsc	STATUS,C,ACCESS
	return
SCLT16TRUE
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

SYSCOMPLESSTHAN32
	clrf	SYSBYTETEMPX,ACCESS
	movf	SYSLONGTEMPA_E,W,ACCESS
	subwf	SYSLONGTEMPB_E,W,ACCESS
	btfss	STATUS,C,ACCESS
	return
	bnz	SCLT32TRUE
	movf	SYSLONGTEMPA_U,W,ACCESS
	subwf	SYSLONGTEMPB_U,W,ACCESS
	btfss	STATUS,C,ACCESS
	return
	bnz	SCLT32TRUE
	movf	SYSLONGTEMPA_H,W,ACCESS
	subwf	SYSLONGTEMPB_H,W,ACCESS
	btfss	STATUS,C,ACCESS
	return
	bnz	SCLT32TRUE
	movf	SYSLONGTEMPB,W,ACCESS
	subwf	SYSLONGTEMPA,W,ACCESS
	btfsc	STATUS,C,ACCESS
	return
SCLT32TRUE
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

SYSCOMPLESSTHANINT
	clrf	SYSBYTETEMPX,ACCESS
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ELSE257_1
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF258
	comf	SYSBYTETEMPX,F,ACCESS
	return
ENDIF258
	comf	SYSINTEGERTEMPA,W,ACCESS
	movwf	SYSDIVMULTA,ACCESS
	comf	SYSINTEGERTEMPA_H,W,ACCESS
	movwf	SYSDIVMULTA_H,ACCESS
	incf	SYSDIVMULTA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSDIVMULTA_H,F,ACCESS
	comf	SYSINTEGERTEMPB,W,ACCESS
	movwf	SYSINTEGERTEMPA,ACCESS
	comf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSINTEGERTEMPA_H,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
	movff	SYSDIVMULTA,SYSINTEGERTEMPB
	movff	SYSDIVMULTA_H,SYSINTEGERTEMPB_H
	bra	ENDIF257
ELSE257_1
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	return
ENDIF257
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	subwf	SYSINTEGERTEMPB_H,W,ACCESS
	btfss	STATUS,C,ACCESS
	return
	movf	SYSINTEGERTEMPB_H,W,ACCESS
	subwf	SYSINTEGERTEMPA_H,W,ACCESS
	bnc	SCLTINTTRUE
	movf	SYSINTEGERTEMPB,W,ACCESS
	subwf	SYSINTEGERTEMPA,W,ACCESS
	btfsc	STATUS,C,ACCESS
	return
SCLTINTTRUE
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

SYSCOPYSTRING
	movff	INDF0, SYSCALCTEMPA
	movff	SYSCALCTEMPA, INDF1
	bra	SYSCOPYSTRINGCHECK
SYSCOPYSTRINGPART
	movf	INDF0, W,ACCESS
	movwf	SYSCALCTEMPA,ACCESS
	addwf	SYSSTRINGLENGTH, F,ACCESS
SYSCOPYSTRINGCHECK
	movf	SYSCALCTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	return
SYSSTRINGCOPY
	movff	PREINC0, PREINC1
	decfsz	SYSCALCTEMPA, F,ACCESS
	bra	SYSSTRINGCOPY
	return

;********************************************************************************

SYSDIVSUB
	movf	SYSBYTETEMPB, F,ACCESS
	btfsc	STATUS, Z,ACCESS
	return
	clrf	SYSBYTETEMPX,ACCESS
	movlw	8
	movwf	SYSDIVLOOP,ACCESS
SYSDIV8START
	bcf	STATUS, C,ACCESS
	rlcf	SYSBYTETEMPA, F,ACCESS
	rlcf	SYSBYTETEMPX, F,ACCESS
	movf	SYSBYTETEMPB, W,ACCESS
	subwf	SYSBYTETEMPX, F,ACCESS
	bsf	SYSBYTETEMPA, 0,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	DIV8NOTNEG
	bcf	SYSBYTETEMPA, 0,ACCESS
	movf	SYSBYTETEMPB, W,ACCESS
	addwf	SYSBYTETEMPX, F,ACCESS
DIV8NOTNEG
	decfsz	SYSDIVLOOP, F,ACCESS
	bra	SYSDIV8START
	return

;********************************************************************************

SYSDIVSUB16
	movff	SYSWORDTEMPA,SYSDIVMULTA
	movff	SYSWORDTEMPA_H,SYSDIVMULTA_H
	movff	SYSWORDTEMPB,SYSDIVMULTB
	movff	SYSWORDTEMPB_H,SYSDIVMULTB_H
	clrf	SYSDIVMULTX,ACCESS
	clrf	SYSDIVMULTX_H,ACCESS
	movff	SYSDIVMULTB,SysWORDTempA
	movff	SYSDIVMULTB_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SYSCOMPEQUAL16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF253
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
	return
ENDIF253
	movlw	16
	movwf	SYSDIVLOOP,ACCESS
SYSDIV16START
	bcf	STATUS,C,ACCESS
	rlcf	SYSDIVMULTA,F,ACCESS
	rlcf	SYSDIVMULTA_H,F,ACCESS
	rlcf	SYSDIVMULTX,F,ACCESS
	rlcf	SYSDIVMULTX_H,F,ACCESS
	movf	SYSDIVMULTB,W,ACCESS
	subwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	subwfb	SYSDIVMULTX_H,F,ACCESS
	bsf	SYSDIVMULTA,0,ACCESS
	btfsc	STATUS,C,ACCESS
	bra	ENDIF254
	bcf	SYSDIVMULTA,0,ACCESS
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
ENDIF254
	decfsz	SYSDIVLOOP, F,ACCESS
	bra	SYSDIV16START
	movff	SYSDIVMULTA,SYSWORDTEMPA
	movff	SYSDIVMULTA_H,SYSWORDTEMPA_H
	movff	SYSDIVMULTX,SYSWORDTEMPX
	movff	SYSDIVMULTX_H,SYSWORDTEMPX_H
	return

;********************************************************************************

SYSDIVSUB32
	movff	SYSLONGTEMPA,SYSLONGDIVMULTA
	movff	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	movff	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	movff	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
	movff	SYSLONGTEMPB,SYSLONGDIVMULTB
	movff	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	movff	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	movff	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
	clrf	SYSLONGDIVMULTX,BANKED
	clrf	SYSLONGDIVMULTX_H,BANKED
	clrf	SYSLONGDIVMULTX_U,BANKED
	clrf	SYSLONGDIVMULTX_E,BANKED
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
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
	return
ENDIF255
	movlw	32
	movwf	SYSDIVLOOP,ACCESS
SYSDIV32START
	bcf	STATUS,C,ACCESS
	rlcf	SYSLONGDIVMULTA,F,BANKED
	rlcf	SYSLONGDIVMULTA_H,F,BANKED
	rlcf	SYSLONGDIVMULTA_U,F,BANKED
	rlcf	SYSLONGDIVMULTA_E,F,BANKED
	rlcf	SYSLONGDIVMULTX,F,BANKED
	rlcf	SYSLONGDIVMULTX_H,F,BANKED
	rlcf	SYSLONGDIVMULTX_U,F,BANKED
	rlcf	SYSLONGDIVMULTX_E,F,BANKED
	movf	SYSLONGDIVMULTB,W,BANKED
	subwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTB_H,W,BANKED
	subwfb	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTB_U,W,BANKED
	subwfb	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTB_E,W,BANKED
	subwfb	SYSLONGDIVMULTX_E,F,BANKED
	bsf	SYSLONGDIVMULTA,0,BANKED
	btfsc	STATUS,C,ACCESS
	bra	ENDIF256
	bcf	SYSLONGDIVMULTA,0,BANKED
	movf	SYSLONGDIVMULTB,W,BANKED
	addwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTB_H,W,BANKED
	addwfc	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTB_U,W,BANKED
	addwfc	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTB_E,W,BANKED
	addwfc	SYSLONGDIVMULTX_E,F,BANKED
ENDIF256
	decfsz	SYSDIVLOOP, F,ACCESS
	bra	SYSDIV32START
	movff	SYSLONGDIVMULTA,SYSLONGTEMPA
	movff	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	movff	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	movff	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	return

;********************************************************************************

SYSMULTSUB16
	movf	SYSWORDTEMPA, W,ACCESS
	mulwf	SYSWORDTEMPB,ACCESS
	movff	PRODL, SYSWORDTEMPX
	movff	PRODH, SYSWORDTEMPX_H
	movf	SYSWORDTEMPA, W,ACCESS
	mulwf	SYSWORDTEMPB_H,ACCESS
	movf	PRODL, W,ACCESS
	addwf	SYSWORDTEMPX_H, F,ACCESS
	movf	SYSWORDTEMPA_H, W,ACCESS
	mulwf	SYSWORDTEMPB,ACCESS
	movf	PRODL, W,ACCESS
	addwf	SYSWORDTEMPX_H, F,ACCESS
	movf	SYSWORDTEMPA_H, F,ACCESS
	mulwf	SYSWORDTEMPB_H,ACCESS
	return

;********************************************************************************

SYSMULTSUB32
	movff	SYSLONGTEMPA,SYSLONGDIVMULTA
	movff	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	movff	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	movff	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
	movff	SYSLONGTEMPB,SYSLONGDIVMULTB
	movff	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	movff	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	movff	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
	clrf	SYSLONGDIVMULTX,BANKED
	clrf	SYSLONGDIVMULTX_H,BANKED
	clrf	SYSLONGDIVMULTX_U,BANKED
	clrf	SYSLONGDIVMULTX_E,BANKED
MUL32LOOP
	btfss	SYSLONGDIVMULTB,0,BANKED
	bra	ENDIF251
	movf	SYSLONGDIVMULTA,W,BANKED
	addwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTA_H,W,BANKED
	addwfc	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTA_U,W,BANKED
	addwfc	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTA_E,W,BANKED
	addwfc	SYSLONGDIVMULTX_E,F,BANKED
ENDIF251
	bcf	STATUS,C,ACCESS
	rrcf	SYSLONGDIVMULTB_E,F,BANKED
	rrcf	SYSLONGDIVMULTB_U,F,BANKED
	rrcf	SYSLONGDIVMULTB_H,F,BANKED
	rrcf	SYSLONGDIVMULTB,F,BANKED
	bcf	STATUS,C,ACCESS
	rlcf	SYSLONGDIVMULTA,F,BANKED
	rlcf	SYSLONGDIVMULTA_H,F,BANKED
	rlcf	SYSLONGDIVMULTA_U,F,BANKED
	rlcf	SYSLONGDIVMULTA_E,F,BANKED
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
	bra	MUL32LOOP
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	return

;********************************************************************************

SYSREADSTRING
	tblrd*+
	movff	TABLAT,SYSCALCTEMPA
	movff	TABLAT,INDF1
	bra	SYSSTRINGREADCHECK
SYSREADSTRINGPART
	tblrd*+
	movf	TABLAT, W,ACCESS
	movwf	SYSCALCTEMPA,ACCESS
	addwf	SYSSTRINGLENGTH,F,ACCESS
SYSSTRINGREADCHECK
	movf	SYSCALCTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	return
SYSSTRINGREAD
	tblrd*+
	movff	TABLAT,PREINC1
	decfsz	SYSCALCTEMPA, F,ACCESS
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

TIMER_1
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF36
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	1
	iorwf	SysTemp1,W,BANKED
	movwf	PORTB,ACCESS
	bsf	LATB,0,ACCESS
	movlw	1
	movwf	ACTIVELEDNUM,ACCESS
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	clrf	FLAGCOUNTER,ACCESS
	clrf	TIMECOUNT,BANKED
	clrf	SHIFTCOUNTER,BANKED
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	movlw	1
	movwf	TMRSOURCE,BANKED
	movlw	48
	movwf	TMRPRES,BANKED
	call	INITTIMER1
	movlw	1
	movwf	TMRNUMBER,BANKED
	movlw	220
	movwf	TMRVALUE,BANKED
	movlw	11
	movwf	TMRVALUE_H,BANKED
	call	SETTIMER228
	movlw	1
	movwf	TMRNUMBER,BANKED
	call	STARTTIMER
	movlw	1
	movwf	LABSTATE,ACCESS
ENDIF36
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF37
	banksel	PIR4
	btfss	PIR4,TMR1IF,BANKED
	bra	ENDIF39
	bcf	PIR4,TMR1IF,BANKED
	incf	FLAGCOUNTER,F,ACCESS
ENDIF39
	movlw	4
	subwf	FLAGCOUNTER,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF40
	movlw	15
	andwf	PORTB,W,ACCESS
	movwf	LEDSTATE,ACCESS
	bcf	STATUS,C,ACCESS
	rlcf	LEDSTATE,F,ACCESS
	movlw	240
	andwf	PORTB,W,ACCESS
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	iorwf	LEDSTATE,W,ACCESS
	movwf	LATB,ACCESS
	incf	ACTIVELEDNUM,F,ACCESS
	movf	ACTIVELEDNUM,W,ACCESS
	sublw	4
	btfsc	STATUS, C,ACCESS
	bra	ENDIF43
	bsf	LATB,0,ACCESS
	movlw	1
	movwf	ACTIVELEDNUM,ACCESS
ENDIF43
	clrf	FLAGCOUNTER,ACCESS
	incf	SHIFTCOUNTER,F,BANKED
ENDIF40
	movlw	8
	banksel	SHIFTCOUNTER
	subwf	SHIFTCOUNTER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF41
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	7
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT157
	clrf	SHIFTCOUNTER,BANKED
	incf	TIMECOUNT,F,BANKED
ENDIF41
	movf	TIMECOUNT,W,BANKED
	sublw	100
	btfss	STATUS, C,ACCESS
	clrf	TIMECOUNT,BANKED
ENDIF37
	decf	SWITCHEVENT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF38
	movlw	1
	movwf	TMRNUMBER,BANKED
	call	STOPTIMER
	clrf	LABSTATE,ACCESS
ENDIF38
	return

;********************************************************************************

VSR
	movf	LABSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF21
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
	call	HSERPRINT384
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	1
	iorwf	SysTemp1,W,BANKED
	movwf	PORTB,ACCESS
	bsf	LATB,0,ACCESS
	movlw	1
	movwf	ACTIVELEDNUM,ACCESS
	clrf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LABSTATE,ACCESS
ENDIF21
	decf	LABSTATE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF22
	clrf	ADREADPORT,ACCESS
	call	FN_READAD46
	movff	SYSREADADBYTE,ADCRESULT
	clrf	ADCRESULT_H,ACCESS
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
	movlw	10
	movwf	SysRepeatTemp2,BANKED
SysRepeatLoop2
	movff	ADCRESULT,SysWaitTempMS
	movff	ADCRESULT_H,SysWaitTempMS_H
	call	Delay_MS
	call	CHECKBUTTONS2
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd2
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
	movlw	15
	andwf	PORTB,W,ACCESS
	movwf	LEDSTATE,ACCESS
	bcf	STATUS,C,ACCESS
	rlcf	LEDSTATE,F,ACCESS
	movlw	240
	andwf	PORTB,W,ACCESS
	movwf	SysTemp1,BANKED
	iorwf	LEDSTATE,W,ACCESS
	movwf	LATB,ACCESS
	incf	ACTIVELEDNUM,F,ACCESS
	movf	ACTIVELEDNUM,W,ACCESS
	sublw	4
	btfsc	STATUS, C,ACCESS
	bra	ENDIF25
	bsf	LATB,0,ACCESS
	movlw	1
	movwf	ACTIVELEDNUM,ACCESS
ENDIF25
	movlw	1
	movwf	LCDLINE,ACCESS
	clrf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	PRINT157
	movlw	1
	movwf	LCDLINE,ACCESS
	movlw	9
	movwf	LCDCOLUMN,ACCESS
	call	LOCATE
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
	call	FN_PAD
	movlw	low PAD
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high PAD
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT157
ENDIF22
	decf	SWITCHEVENT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	clrf	LABSTATE,ACCESS
	return

;********************************************************************************

FN__HEXPICAS
	movlw	2
	banksel	SYS_HEXPICAS_0
	movwf	SYS_HEXPICAS_0,BANKED
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF172
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF172
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYS_HEXPICAS_2
	movwf	SYS_HEXPICAS_2,BANKED
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop10
	incf	SYSSTRINGTEMP,F,BANKED
	rrcf	SYSVALTEMP,F,BANKED
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
	movlw	15
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF174
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF174
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYS_HEXPICAS_1
	movwf	SYS_HEXPICAS_1,BANKED
	banksel	0
	return

;********************************************************************************

_PFMREADBLOCK
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
	bsf	NVMCON0,NVMEN,ACCESS
	movlw	187
	movwf	NVMCON2,ACCESS
	movlw	68
	movwf	NVMCON2,ACCESS
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
	tblrd*+
	movf	_PFM_LOOPCOUNTER,W,BANKED
	addwf	Sys_PFM_BUFFERHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movf	_PFM_LOOPCOUNTER_H,W,BANKED
	addwfc	Sys_PFM_BUFFERHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	TABLAT,INDF0
	movff	_PFM_LOOPCOUNTER,SysWORDTempA
	movff	_PFM_LOOPCOUNTER_H,SysWORDTempA_H
	movff	_PFM_COUNT,SysWORDTempB
	movff	_PFM_COUNT_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop13
SysForLoopEnd13
	bcf	NVMCON0,NVMEN,ACCESS
	return

;********************************************************************************

_PFMWRITEBLOCK
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
	bsf	NVMCON0,NVMEN,ACCESS
	bsf	NVMCON1,6,ACCESS
	clrf	_GIE_SAVE,BANKED
	btfsc	INTCON,GIE,ACCESS
	incf	_GIE_SAVE,F,BANKED
	bcf	INTCON,GIE,ACCESS
	movlw	187
	movwf	NVMCON2,ACCESS
	movlw	68
	movwf	NVMCON2,ACCESS
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
	movf	_PFM_LOOPCOUNTER,W,BANKED
	addwf	Sys_PFM_BUFFERHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movf	_PFM_LOOPCOUNTER_H,W,BANKED
	addwfc	Sys_PFM_BUFFERHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,TABLAT
	tblwt*+
	movff	_PFM_LOOPCOUNTER,SysWORDTempA
	movff	_PFM_LOOPCOUNTER_H,SysWORDTempA_H
	movff	_PFM_COUNT,SysWORDTempB
	movff	_PFM_COUNT_H,SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop14
SysForLoopEnd14
	movlw	221
	movwf	NVMCON2,ACCESS
	movlw	34
	movwf	NVMCON2,ACCESS
	bsf	NVMCON1,5,ACCESS
	movlw	85
	movwf	NVMCON2,ACCESS
	movlw	170
	movwf	NVMCON2,ACCESS
	bsf	NVMCON1,WR,ACCESS
SysWaitLoop6
	btfsc	NVMCON1,WR,ACCESS
	bra	SysWaitLoop6
	bcf	NVMCON0,NVMEN,ACCESS
	btfsc	_GIE_SAVE,0,BANKED
	bsf	INTCON,GIE,ACCESS
	btfss	_GIE_SAVE,0,BANKED
	bcf	INTCON,GIE,ACCESS
	return

;********************************************************************************


 END
