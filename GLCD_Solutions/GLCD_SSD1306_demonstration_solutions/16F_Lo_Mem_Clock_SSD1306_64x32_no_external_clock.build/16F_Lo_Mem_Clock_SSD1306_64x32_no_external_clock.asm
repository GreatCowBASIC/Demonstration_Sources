;Program compiled by GCBASIC (2026.31.24 (Windows 64 bit) : Build 1614) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-07-31 CRC247
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_SSD1306_demonstration_solutions\16F_Lo_Mem_Clock_SSD1306_64x32_no_external_clock.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : C:\GCstudio\gcbasic\..\PICKitPlus\PICKitCommandline.exe
;   Output file      : D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_SSD1306_demonstration_solutions\16F_Lo_Mem_Clock_SSD1306_64x32_no_external_clock.build\16F_Lo_Mem_Clock_SSD1306_64x32_no_external_clock.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1937, r=DEC
 TITLE       "D:\GreatCowBASICGits\Demonstration_Sources.git\GLCD_Solutions\GLCD_SSD1306_demonstration_solutions\16F_Lo_Mem_Clock_SSD1306_64x32_no_external_clock.gcb"
 SUBTITLE    "07-31-2026 20:08:36"
#include <P16F1937.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _CPD_OFF & _CP_OFF & _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF & _VCAPEN_OFF & _WRT_OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
CHARCODE                         EQU      32          ; 0x20
CHARCOL                          EQU      33          ; 0x21
CHARCOLS                         EQU      35          ; 0x23
CHARCOL_H                        EQU      34          ; 0x22
CHARLOCX                         EQU      36          ; 0x24
CHARLOCX_H                       EQU      37          ; 0x25
CHARLOCY                         EQU      38          ; 0x26
CHARLOCY_H                       EQU      39          ; 0x27
CHARROW                          EQU      40          ; 0x28
CHARROWS                         EQU      42          ; 0x2A
CHARROW_H                        EQU      41          ; 0x29
COL                              EQU      43          ; 0x2B
CURRCHARCOL                      EQU      44          ; 0x2C
CURRCHARROW                      EQU      45          ; 0x2D
CURRCHARVAL                      EQU      46          ; 0x2E
DELAYTEMP                        EQU     112          ; 0x70 (SA)
DELAYTEMP2                       EQU     113          ; 0x71 (SA)
DRAWLINE                         EQU      47          ; 0x2F
DRAWLINE_H                       EQU      48          ; 0x30
GLCDBACKGROUND                   EQU      49          ; 0x31
GLCDBACKGROUND_H                 EQU      50          ; 0x32
GLCDBITNO                        EQU      51          ; 0x33
GLCDCHANGE                       EQU      52          ; 0x34
GLCDCOLOUR                       EQU      53          ; 0x35
GLCDCOLOUR_H                     EQU      54          ; 0x36
GLCDDATATEMP                     EQU      55          ; 0x37
GLCDFNTDEFAULT                   EQU      56          ; 0x38
GLCDFNTDEFAULTHEIGHT             EQU      57          ; 0x39
GLCDFNTDEFAULTSIZE               EQU      58          ; 0x3A
GLCDFONTWIDTH                    EQU      59          ; 0x3B
GLCDFOREGROUND                   EQU      60          ; 0x3C
GLCDFOREGROUND_H                 EQU      61          ; 0x3D
GLCDPRINTLEN                     EQU      62          ; 0x3E
GLCDPRINTLOC                     EQU      63          ; 0x3F
GLCDPRINTLOC_H                   EQU      64          ; 0x40
GLCDPRINT_STRING_COUNTER         EQU      65          ; 0x41
GLCDTEMP                         EQU      66          ; 0x42
GLCDTEMP_H                       EQU      67          ; 0x43
GLCDX                            EQU      68          ; 0x44
GLCDY                            EQU      69          ; 0x45
GLCDY_TEMP                       EQU      70          ; 0x46
GLCD_YORDINATE                   EQU      71          ; 0x47
GLCD_YORDINATE_H                 EQU      72          ; 0x48
HH                               EQU    8582          ; 0x2186
HOURS                            EQU      73          ; 0x49
I2CACK                           EQU      74          ; 0x4A
I2CACKPOLLSTATE                  EQU      75          ; 0x4B
I2CBYTE                          EQU      76          ; 0x4C
I2CMATCH                         EQU      77          ; 0x4D
I2CSTATE                         EQU      78          ; 0x4E
LINECOLOUR                       EQU      79          ; 0x4F
LINECOLOUR_H                     EQU      80          ; 0x50
LINEX1                           EQU      81          ; 0x51
LINEX1_H                         EQU      82          ; 0x52
LINEX2                           EQU      83          ; 0x53
LINEX2_H                         EQU      84          ; 0x54
LINEY1                           EQU      85          ; 0x55
LINEY1_H                         EQU      86          ; 0x56
LINEY2                           EQU      87          ; 0x57
LINEY2_H                         EQU      88          ; 0x58
LOCX                             EQU      89          ; 0x59
LOCY                             EQU      90          ; 0x5A
MINUTES                          EQU      91          ; 0x5B
MM                               EQU    8541          ; 0x215D
POSCHARX                         EQU      92          ; 0x5C
POSCHARX_H                       EQU      93          ; 0x5D
POSCHARY                         EQU      94          ; 0x5E
PRINTLOCX                        EQU      95          ; 0x5F
PRINTLOCX_H                      EQU      96          ; 0x60
PRINTLOCY                        EQU      97          ; 0x61
PRINTLOCY_H                      EQU      98          ; 0x62
ROW                              EQU      99          ; 0x63
SECONDS                          EQU     100          ; 0x64
SS                               EQU    8500          ; 0x2134
SSD1306SENDBYTE                  EQU     101          ; 0x65
SSD1306_BUFFERALIAS              EQU    8623          ; 0x21AF
SSD1306_BUFFERLOCATIONCALC       EQU     102          ; 0x66
SSD1306_BUFFERLOCATIONCALC_H     EQU     103          ; 0x67
STR                              EQU    8453          ; 0x2105
STRINGPOINTER                    EQU     104          ; 0x68
SYSBYTETEMPA                     EQU     117          ; 0x75 (SA)
SYSBYTETEMPB                     EQU     121          ; 0x79 (SA)
SYSBYTETEMPX                     EQU     112          ; 0x70 (SA)
SYSCALCTEMPA                     EQU     117          ; 0x75 (SA)
SYSCALCTEMPX                     EQU     112          ; 0x70 (SA)
SYSCALCTEMPX_H                   EQU     113          ; 0x71 (SA)
SYSCHARCOUNT                     EQU     105          ; 0x69
SYSDIVLOOP                       EQU     116          ; 0x74 (SA)
SYSDIVMULTA                      EQU     119          ; 0x77 (SA)
SYSDIVMULTA_H                    EQU     120          ; 0x78 (SA)
SYSDIVMULTB                      EQU     123          ; 0x7B (SA)
SYSDIVMULTB_H                    EQU     124          ; 0x7C (SA)
SYSDIVMULTX                      EQU     114          ; 0x72 (SA)
SYSDIVMULTX_H                    EQU     115          ; 0x73 (SA)
SYSFORLOOPABSVALUE11             EQU     106          ; 0x6A
SYSFORLOOPABSVALUE11_H           EQU     107          ; 0x6B
SYSFORLOOPSTEP10                 EQU     108          ; 0x6C
SYSFORLOOPSTEP10_H               EQU     109          ; 0x6D
SYSLCDPRINTDATAHANDLER           EQU     110          ; 0x6E
SYSLCDPRINTDATAHANDLER_H         EQU     111          ; 0x6F
SYSREPEATTEMP1                   EQU     160          ; 0xA0
SYSREPEATTEMP2                   EQU     161          ; 0xA1
SYSREPEATTEMP3                   EQU     162          ; 0xA2
SYSREPEATTEMP5                   EQU     163          ; 0xA3
SYSSTRDATA                       EQU     164          ; 0xA4
SYSSTRINGA                       EQU     119          ; 0x77 (SA)
SYSSTRINGA_H                     EQU     120          ; 0x78 (SA)
SYSSTRINGLENGTH                  EQU     118          ; 0x76 (SA)
SYSTEMP1                         EQU     165          ; 0xA5
SYSTEMP1_H                       EQU     166          ; 0xA6
SYSTEMP2                         EQU     167          ; 0xA7
SYSTEMP2_H                       EQU     168          ; 0xA8
SYSTEMP3                         EQU     169          ; 0xA9
SYSVALTEMP                       EQU     170          ; 0xAA
SYSVALTEMP_H                     EQU     171          ; 0xAB
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
TIMESTRING                       EQU    8459          ; 0x210B
_GLCDPAGE                        EQU     172          ; 0xAC

;********************************************************************************

;Alias variables
AFSR0 EQU 4
AFSR0_H EQU 5
SYSSTR_0 EQU 437

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
	call	INITI2C
	call	INITGLCD_SSD1306
	pagesel	$

;Start_of_the_main_program
;
;
;​[gcbasic:discussion]​
;Here is simple clock on the 64x32.
;
;How it works: Hours/Minutes/Seconds are plain bytes that get incremented once per loop iteration, gated by Wait 1 s — same tick mechanism as your example.
;Each pass builds a zero-padded HH:MM:SS string and redraws it inside a GLCD_Open_PageTransaction/Close block.
;
;Since there's no RTC here — it's a free-running software clock that will drift over time.
;
;If you have a real RTC (DS1307/DS3231 etc.) wired up, it'd be more accurate to read the time from that each loop instead of incrementing in software — you can adapt this if you're using one.
;
;
;Display configuration
;I2C Software settings
;---- Clock variables ----
;Dim Hours   As Byte
;Dim Minutes As Byte
;Dim Seconds As Byte
;Dim TimeString As String
;Dim HH As String
;Dim MM As String
;Dim SS As String
;---- Set the starting time here ----
;Hours   = 12
	movlw	12
	movwf	HOURS
;Minutes = 0
	clrf	MINUTES
;Seconds = 0
	clrf	SECONDS
;Do
SysDoLoop_S1
;Build zero-padded strings for each field
;If Hours < 10 Then
	movlw	10
	subwf	HOURS,W
	btfsc	STATUS, C
	goto	ELSE1_1
;HH = "0" + Str(Hours)
	movf	HOURS,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	call	FN_STR
	movlw	low HH
	movwf	FSR1L
	movlw	high HH
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	pagesel	SYSREADSTRINGPART
	call	SYSREADSTRINGPART
	pagesel	$
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	pagesel	SYSCOPYSTRINGPART
	call	SYSCOPYSTRINGPART
	pagesel	$
	movlw	low HH
	movwf	FSR0L
	movlw	high HH
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;Else
	goto	ENDIF1
ELSE1_1
;HH = Str(Hours)
	movf	HOURS,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	call	FN_STR
	movlw	low HH
	movwf	FSR1L
	movlw	high HH
	movwf	FSR1H
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	pagesel	SYSCOPYSTRING
	call	SYSCOPYSTRING
	pagesel	$
;End If
ENDIF1
;If Minutes < 10 Then
	movlw	10
	subwf	MINUTES,W
	btfsc	STATUS, C
	goto	ELSE2_1
;MM = "0" + Str(Minutes)
	movf	MINUTES,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	call	FN_STR
	movlw	low MM
	movwf	FSR1L
	movlw	high MM
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	pagesel	SYSREADSTRINGPART
	call	SYSREADSTRINGPART
	pagesel	$
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	pagesel	SYSCOPYSTRINGPART
	call	SYSCOPYSTRINGPART
	pagesel	$
	movlw	low MM
	movwf	FSR0L
	movlw	high MM
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;Else
	goto	ENDIF2
ELSE2_1
;MM = Str(Minutes)
	movf	MINUTES,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	call	FN_STR
	movlw	low MM
	movwf	FSR1L
	movlw	high MM
	movwf	FSR1H
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	pagesel	SYSCOPYSTRING
	call	SYSCOPYSTRING
	pagesel	$
;End If
ENDIF2
;If Seconds < 10 Then
	movlw	10
	subwf	SECONDS,W
	btfsc	STATUS, C
	goto	ELSE3_1
;SS = "0" + Str(Seconds)
	movf	SECONDS,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	call	FN_STR
	movlw	low SS
	movwf	FSR1L
	movlw	high SS
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	pagesel	SYSREADSTRINGPART
	call	SYSREADSTRINGPART
	pagesel	$
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	pagesel	SYSCOPYSTRINGPART
	call	SYSCOPYSTRINGPART
	pagesel	$
	movlw	low SS
	movwf	FSR0L
	movlw	high SS
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;Else
	goto	ENDIF3
ELSE3_1
;SS = Str(Seconds)
	movf	SECONDS,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	call	FN_STR
	movlw	low SS
	movwf	FSR1L
	movlw	high SS
	movwf	FSR1H
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	pagesel	SYSCOPYSTRING
	call	SYSCOPYSTRING
	pagesel	$
;End If
ENDIF3
;TimeString = HH + ":" + MM + ":" + SS
	movlw	low TIMESTRING
	movwf	FSR1L
	movlw	high TIMESTRING
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low HH
	movwf	FSR0L
	movlw	high HH
	movwf	FSR0H
	pagesel	SYSCOPYSTRINGPART
	call	SYSCOPYSTRINGPART
	pagesel	$
	movlw	low StringTable2
	movwf	SysStringA
	movlw	(high StringTable2) & 127
	movwf	SysStringA_H
	pagesel	SYSREADSTRINGPART
	call	SYSREADSTRINGPART
	pagesel	$
	movlw	low MM
	movwf	FSR0L
	movlw	high MM
	movwf	FSR0H
	pagesel	SYSCOPYSTRINGPART
	call	SYSCOPYSTRINGPART
	pagesel	$
	movlw	low StringTable2
	movwf	SysStringA
	movlw	(high StringTable2) & 127
	movwf	SysStringA_H
	pagesel	SYSREADSTRINGPART
	call	SYSREADSTRINGPART
	pagesel	$
	movlw	low SS
	movwf	FSR0L
	movlw	high SS
	movwf	FSR0H
	pagesel	SYSCOPYSTRINGPART
	call	SYSCOPYSTRINGPART
	pagesel	$
	movlw	low TIMESTRING
	movwf	FSR0L
	movlw	high TIMESTRING
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;GLCD_Open_PageTransaction 0,3
;Macro Source: GLCD_SSD1306.H (1234)
;dim _GLCDPage as byte
;Clear buffer
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
;Legacy method
	movlw	255
	banksel	_GLCDPAGE
	movwf	_GLCDPAGE
SysForLoop1
	incf	_GLCDPAGE,F
;GLCDPrint 10,10, TimeString
	movlw	10
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	10
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low TIMESTRING
	movwf	SysLCDPRINTDATAHandler
	movlw	high TIMESTRING
	movwf	SysLCDPRINTDATAHandler_H
	pagesel	GLCDPRINT4
	call	GLCDPRINT4
	pagesel	$
;Box 0,0,63,31
	clrf	LINEX1
	clrf	LINEX1_H
	clrf	LINEY1
	clrf	LINEY1_H
	movlw	63
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	31
	movwf	LINEY2
	clrf	LINEY2_H
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	call	BOX16
;GLCD_Close_PageTransaction
;Macro Source: GLCD_SSD1306.H (1246)
;Set cursor position
;Cursor_Position_SSD1306 ( 0, 8 * _GLCDPage )
	clrf	LOCX
	banksel	_GLCDPAGE
	movf	_GLCDPAGE,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	call	SYSMULTSUB
	movf	SysBYTETempX,W
	movwf	LOCY
	pagesel	CURSOR_POSITION_SSD1306
	call	CURSOR_POSITION_SSD1306
	pagesel	$
;Send the buffer to the device using transaction
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1272)
;4wire not supported, see Write_Transaction_Data_SSD1306
;I2CStart
	pagesel	I2CSTART
	call	I2CSTART
	pagesel	$
;I2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend 0x40
	movlw	64
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;for SSD1306_BufferLocationCalc = 1 to 128
;Legacy method
	clrf	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H
SysForLoop2
	incf	SSD1306_BUFFERLOCATIONCALC,F
	btfsc	STATUS,Z
	incf	SSD1306_BUFFERLOCATIONCALC_H,F
;Write_Transaction_Data_SSD1306 SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
;Macro Source: GLCD_SSD1306.H (1303)
;I2CSend SSD1306SendByte
	movlw	low(SSD1306_BUFFERALIAS)
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;Clear the buffer byte. We need it to be empty for the next page operation
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	movlw	low(SSD1306_BUFFERALIAS)
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	clrf	INDF0
;next
	movf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	SysWORDTempA
	movf	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	SysWORDTempA_H
	movlw	128
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop2
SysForLoopEnd2
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1336)
;4wire not supported, see Write_Transaction_Data_SSD1306
;I2CStop
	call	I2CSTOP
;next
	movlw	3
	banksel	_GLCDPAGE
	subwf	_GLCDPAGE,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
;Wait 1 s
	movlw	1
	movwf	SysWaitTempS
	banksel	STATUS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;---- Increment the clock by one second ----
;Seconds = Seconds + 1
	incf	SECONDS,F
;If Seconds = 60 Then
	movlw	60
	subwf	SECONDS,W
	btfss	STATUS, Z
	goto	ENDIF6
;Seconds = 0
	clrf	SECONDS
;Minutes = Minutes + 1
	incf	MINUTES,F
;If Minutes = 60 Then
	movlw	60
	subwf	MINUTES,W
	btfss	STATUS, Z
	goto	ENDIF7
;Minutes = 0
	clrf	MINUTES
;Hours = Hours + 1
	incf	HOURS,F
;If Hours = 24 Then
	movlw	24
	subwf	HOURS,W
	btfsc	STATUS, Z
;Hours = 0
	clrf	HOURS
;End If
;End If
ENDIF7
;End If
ENDIF6
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;GLCD SSD1306 buffer is 64bytes
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:word:, Source: glcd.h (1800)
BOX16
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movf	LINEX1,W
	movwf	SysWORDTempB
	movf	LINEX1_H,W
	movwf	SysWORDTempB_H
	movf	LINEX2,W
	movwf	SysWORDTempA
	movf	LINEX2_H,W
	movwf	SysWORDTempA_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF12
;GLCDTemp = LineX1
	movf	LINEX1,W
	movwf	GLCDTEMP
	movf	LINEX1_H,W
	movwf	GLCDTEMP_H
;LineX1 = LineX2
	movf	LINEX2,W
	movwf	LINEX1
	movf	LINEX2_H,W
	movwf	LINEX1_H
;LineX2 = GLCDTemp
	movf	GLCDTEMP,W
	movwf	LINEX2
	movf	GLCDTEMP_H,W
	movwf	LINEX2_H
;End If
ENDIF12
;If LineY1 > LineY2 Then
	movf	LINEY1,W
	movwf	SysWORDTempB
	movf	LINEY1_H,W
	movwf	SysWORDTempB_H
	movf	LINEY2,W
	movwf	SysWORDTempA
	movf	LINEY2_H,W
	movwf	SysWORDTempA_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF13
;GLCDTemp = LineY1
	movf	LINEY1,W
	movwf	GLCDTEMP
	movf	LINEY1_H,W
	movwf	GLCDTEMP_H
;LineY1 = LineY2
	movf	LINEY2,W
	movwf	LINEY1
	movf	LINEY2_H,W
	movwf	LINEY1_H
;LineY2 = GLCDTemp
	movf	GLCDTEMP,W
	movwf	LINEY2
	movf	GLCDTEMP_H,W
	movwf	LINEY2_H
;End If
ENDIF13
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
;Legacy method
	movlw	1
	subwf	LINEX1,W
	movwf	DRAWLINE
	movlw	0
	subwfb	LINEX1_H,W
	movwf	DRAWLINE_H
	movf	LINEX1,W
	movwf	SysWORDTempB
	movf	LINEX1_H,W
	movwf	SysWORDTempB_H
	movf	LINEX2,W
	movwf	SysWORDTempA
	movf	LINEX2_H,W
	movwf	SysWORDTempA_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd4
SysForLoop4
	incf	DRAWLINE,F
	btfsc	STATUS,Z
	incf	DRAWLINE_H,F
;PSet DrawLine, LineY1, LineColour
	movf	DRAWLINE,W
	movwf	GLCDX
	movf	LINEY1,W
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;PSet DrawLine, LineY2, LineColour
	movf	DRAWLINE,W
	movwf	GLCDX
	movf	LINEY2,W
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Next
	movf	DRAWLINE,W
	movwf	SysWORDTempA
	movf	DRAWLINE_H,W
	movwf	SysWORDTempA_H
	movf	LINEX2,W
	movwf	SysWORDTempB
	movf	LINEX2_H,W
	movwf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop4
SysForLoopEnd4
;Draw lines going down
;For DrawLine = LineY1 To LineY2
;Legacy method
	movlw	1
	subwf	LINEY1,W
	movwf	DRAWLINE
	movlw	0
	subwfb	LINEY1_H,W
	movwf	DRAWLINE_H
	movf	LINEY1,W
	movwf	SysWORDTempB
	movf	LINEY1_H,W
	movwf	SysWORDTempB_H
	movf	LINEY2,W
	movwf	SysWORDTempA
	movf	LINEY2_H,W
	movwf	SysWORDTempA_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd5
SysForLoop5
	incf	DRAWLINE,F
	btfsc	STATUS,Z
	incf	DRAWLINE_H,F
;PSet LineX1, DrawLine, LineColour
	movf	LINEX1,W
	movwf	GLCDX
	movf	DRAWLINE,W
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;PSet LineX2, DrawLine, LineColour
	movf	LINEX2,W
	movwf	GLCDX
	movf	DRAWLINE,W
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Next
	movf	DRAWLINE,W
	movwf	SysWORDTempA
	movf	DRAWLINE_H,W
	movwf	SysWORDTempA_H
	movf	LINEY2,W
	movwf	SysWORDTempB
	movf	LINEY2_H,W
	movwf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop5
SysForLoopEnd5
	return

;********************************************************************************

GLCDCHARCOL3
	movlw	113
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEGLCDCHARCOL3
	movwf	SysStringA
	movlw	(high TABLEGLCDCHARCOL3) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEGLCDCHARCOL3
	retlw	112
	retlw	0
	retlw	16
	retlw	12
	retlw	10
	retlw	136
	retlw	34
	retlw	56
	retlw	32
	retlw	8
	retlw	32
	retlw	16
	retlw	16
	retlw	128
	retlw	128
	retlw	64
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	40
	retlw	72
	retlw	70
	retlw	108
	retlw	0
	retlw	0
	retlw	0
	retlw	40
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	64
	retlw	124
	retlw	0
	retlw	132
	retlw	130
	retlw	48
	retlw	78
	retlw	120
	retlw	6
	retlw	108
	retlw	12
	retlw	0
	retlw	0
	retlw	16
	retlw	40
	retlw	0
	retlw	4
	retlw	100
	retlw	248
	retlw	254
	retlw	124
	retlw	254
	retlw	254
	retlw	254
	retlw	124
	retlw	254
	retlw	0
	retlw	64
	retlw	254
	retlw	254
	retlw	254
	retlw	254
	retlw	124
	retlw	254
	retlw	124
	retlw	254
	retlw	76
	retlw	2
	retlw	126
	retlw	62
	retlw	126
	retlw	198
	retlw	14
	retlw	194
	retlw	0
	retlw	4
	retlw	0
	retlw	8
	retlw	128
	retlw	0
	retlw	64
	retlw	254
	retlw	112
	retlw	112
	retlw	112
	retlw	16
	retlw	16
	retlw	254
	retlw	0
	retlw	64
	retlw	254
	retlw	0
	retlw	248
	retlw	248
	retlw	112
	retlw	248
	retlw	16
	retlw	248
	retlw	144
	retlw	16
	retlw	120
	retlw	56
	retlw	120
	retlw	136
	retlw	24
	retlw	136
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	120

;********************************************************************************

GLCDCHARCOL4
	movlw	113
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEGLCDCHARCOL4
	movwf	SysStringA
	movlw	(high TABLEGLCDCHARCOL4) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEGLCDCHARCOL4
	retlw	112
	retlw	254
	retlw	56
	retlw	10
	retlw	6
	retlw	204
	retlw	102
	retlw	124
	retlw	112
	retlw	4
	retlw	64
	retlw	16
	retlw	56
	retlw	136
	retlw	162
	retlw	112
	retlw	28
	retlw	0
	retlw	0
	retlw	14
	retlw	254
	retlw	84
	retlw	38
	retlw	146
	retlw	10
	retlw	56
	retlw	130
	retlw	16
	retlw	16
	retlw	160
	retlw	16
	retlw	192
	retlw	32
	retlw	162
	retlw	132
	retlw	194
	retlw	130
	retlw	40
	retlw	138
	retlw	148
	retlw	2
	retlw	146
	retlw	146
	retlw	108
	retlw	172
	retlw	40
	retlw	40
	retlw	130
	retlw	2
	retlw	146
	retlw	36
	retlw	146
	retlw	130
	retlw	130
	retlw	146
	retlw	18
	retlw	130
	retlw	16
	retlw	130
	retlw	128
	retlw	16
	retlw	128
	retlw	4
	retlw	8
	retlw	130
	retlw	18
	retlw	130
	retlw	18
	retlw	146
	retlw	2
	retlw	128
	retlw	64
	retlw	128
	retlw	40
	retlw	16
	retlw	162
	retlw	254
	retlw	8
	retlw	130
	retlw	4
	retlw	128
	retlw	2
	retlw	168
	retlw	144
	retlw	136
	retlw	136
	retlw	168
	retlw	252
	retlw	168
	retlw	16
	retlw	144
	retlw	128
	retlw	32
	retlw	130
	retlw	8
	retlw	16
	retlw	136
	retlw	40
	retlw	40
	retlw	16
	retlw	168
	retlw	124
	retlw	128
	retlw	64
	retlw	128
	retlw	80
	retlw	160
	retlw	200
	retlw	16
	retlw	0
	retlw	130
	retlw	16
	retlw	68

;********************************************************************************

GLCDCHARCOL5
	movlw	113
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEGLCDCHARCOL5
	movwf	SysStringA
	movlw	(high TABLEGLCDCHARCOL5) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEGLCDCHARCOL5
	retlw	112
	retlw	124
	retlw	124
	retlw	0
	retlw	0
	retlw	238
	retlw	238
	retlw	124
	retlw	168
	retlw	254
	retlw	254
	retlw	84
	retlw	84
	retlw	148
	retlw	148
	retlw	124
	retlw	124
	retlw	0
	retlw	158
	retlw	0
	retlw	40
	retlw	254
	retlw	16
	retlw	170
	retlw	6
	retlw	68
	retlw	68
	retlw	124
	retlw	124
	retlw	96
	retlw	16
	retlw	192
	retlw	16
	retlw	146
	retlw	254
	retlw	162
	retlw	138
	retlw	36
	retlw	138
	retlw	146
	retlw	226
	retlw	146
	retlw	146
	retlw	108
	retlw	108
	retlw	68
	retlw	40
	retlw	68
	retlw	162
	retlw	242
	retlw	34
	retlw	146
	retlw	130
	retlw	130
	retlw	146
	retlw	18
	retlw	146
	retlw	16
	retlw	254
	retlw	130
	retlw	40
	retlw	128
	retlw	24
	retlw	16
	retlw	130
	retlw	18
	retlw	162
	retlw	50
	retlw	146
	retlw	254
	retlw	128
	retlw	128
	retlw	112
	retlw	16
	retlw	224
	retlw	146
	retlw	130
	retlw	16
	retlw	130
	retlw	2
	retlw	128
	retlw	4
	retlw	168
	retlw	136
	retlw	136
	retlw	136
	retlw	168
	retlw	18
	retlw	168
	retlw	8
	retlw	250
	retlw	136
	retlw	80
	retlw	254
	retlw	240
	retlw	8
	retlw	136
	retlw	40
	retlw	40
	retlw	8
	retlw	168
	retlw	144
	retlw	128
	retlw	128
	retlw	96
	retlw	32
	retlw	160
	retlw	168
	retlw	108
	retlw	254
	retlw	108
	retlw	16
	retlw	66

;********************************************************************************

GLCDCHARCOL6
	movlw	113
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEGLCDCHARCOL6
	movwf	SysStringA
	movlw	(high TABLEGLCDCHARCOL6) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEGLCDCHARCOL6
	retlw	112
	retlw	56
	retlw	254
	retlw	12
	retlw	10
	retlw	204
	retlw	102
	retlw	124
	retlw	32
	retlw	4
	retlw	64
	retlw	56
	retlw	16
	retlw	162
	retlw	136
	retlw	112
	retlw	28
	retlw	0
	retlw	0
	retlw	14
	retlw	254
	retlw	84
	retlw	200
	retlw	68
	retlw	0
	retlw	130
	retlw	56
	retlw	16
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	8
	retlw	138
	retlw	128
	retlw	146
	retlw	150
	retlw	254
	retlw	138
	retlw	146
	retlw	18
	retlw	146
	retlw	82
	retlw	0
	retlw	0
	retlw	130
	retlw	40
	retlw	40
	retlw	18
	retlw	130
	retlw	36
	retlw	146
	retlw	130
	retlw	68
	retlw	146
	retlw	18
	retlw	146
	retlw	16
	retlw	130
	retlw	126
	retlw	68
	retlw	128
	retlw	4
	retlw	32
	retlw	130
	retlw	18
	retlw	66
	retlw	82
	retlw	146
	retlw	2
	retlw	128
	retlw	64
	retlw	128
	retlw	40
	retlw	16
	retlw	138
	retlw	130
	retlw	32
	retlw	254
	retlw	4
	retlw	128
	retlw	8
	retlw	168
	retlw	136
	retlw	136
	retlw	144
	retlw	168
	retlw	2
	retlw	168
	retlw	8
	retlw	128
	retlw	122
	retlw	136
	retlw	128
	retlw	8
	retlw	8
	retlw	136
	retlw	40
	retlw	48
	retlw	8
	retlw	168
	retlw	128
	retlw	64
	retlw	64
	retlw	128
	retlw	80
	retlw	160
	retlw	152
	retlw	130
	retlw	0
	retlw	16
	retlw	32
	retlw	68

;********************************************************************************

GLCDCHARCOL7
	movlw	113
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TABLEGLCDCHARCOL7
	movwf	SysStringA
	movlw	(high TABLEGLCDCHARCOL7) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TABLEGLCDCHARCOL7
	retlw	112
	retlw	16
	retlw	0
	retlw	10
	retlw	6
	retlw	136
	retlw	34
	retlw	56
	retlw	62
	retlw	8
	retlw	32
	retlw	16
	retlw	16
	retlw	128
	retlw	128
	retlw	64
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	40
	retlw	36
	retlw	196
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	40
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	4
	retlw	124
	retlw	0
	retlw	140
	retlw	98
	retlw	32
	retlw	114
	retlw	96
	retlw	14
	retlw	108
	retlw	60
	retlw	0
	retlw	0
	retlw	0
	retlw	40
	retlw	16
	retlw	12
	retlw	124
	retlw	248
	retlw	108
	retlw	68
	retlw	56
	retlw	130
	retlw	2
	retlw	244
	retlw	254
	retlw	0
	retlw	2
	retlw	130
	retlw	128
	retlw	254
	retlw	254
	retlw	124
	retlw	12
	retlw	188
	retlw	140
	retlw	100
	retlw	2
	retlw	126
	retlw	62
	retlw	126
	retlw	198
	retlw	14
	retlw	134
	retlw	0
	retlw	64
	retlw	0
	retlw	8
	retlw	128
	retlw	0
	retlw	240
	retlw	112
	retlw	64
	retlw	254
	retlw	48
	retlw	4
	retlw	120
	retlw	240
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	240
	retlw	112
	retlw	16
	retlw	248
	retlw	16
	retlw	64
	retlw	64
	retlw	248
	retlw	56
	retlw	120
	retlw	136
	retlw	120
	retlw	136
	retlw	0
	retlw	0
	retlw	0
	retlw	16
	retlw	120

;********************************************************************************

;Source: GLCD_SSD1306.H (464)
GLCDCLS_SSD1306
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE
	clrf	GLCD_YORDINATE_H
;For SSD1306_BufferLocationCalc = 0 to 127
;Legacy method
	movlw	255
	movwf	SSD1306_BUFFERLOCATIONCALC
	movwf	SSD1306_BUFFERLOCATIONCALC_H
SysForLoop10
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
	movlw	127
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop10
SysForLoopEnd10
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	clrf	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H
SysForLoop11
;Init SysForLoopStep10 :#0
	movlw	8
	movwf	SysForLoopStep10
	clrf	SysForLoopStep10_H
;Cursor_Position_SSD1306 ( 0 , SSD1306_BufferLocationCalc )
	clrf	LOCX
	movf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	LOCY
	pagesel	CURSOR_POSITION_SSD1306
	call	CURSOR_POSITION_SSD1306
	pagesel	$
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1272)
;4wire not supported, see Write_Transaction_Data_SSD1306
;I2CStart
	pagesel	I2CSTART
	call	I2CSTART
	pagesel	$
;I2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend 0x40
	movlw	64
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;For GLCDTemp = 0 to 127
;Legacy method
	movlw	255
	movwf	GLCDTEMP
SysForLoop12
	incf	GLCDTEMP,F
;Write_Transaction_Data_SSD1306(GLCDBackground)
;Macro Source: GLCD_SSD1306.H (1303)
;I2CSend SSD1306SendByte
	movf	GLCDBACKGROUND,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;Next
	movlw	127
	subwf	GLCDTEMP,W
	btfss	STATUS, C
	goto	SysForLoop12
SysForLoopEnd12
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1336)
;4wire not supported, see Write_Transaction_Data_SSD1306
;I2CStop
	call	I2CSTOP
;Next
;Integer negative Step Handler in For-next statement
	btfss	SYSFORLOOPSTEP10_H,7
	goto	ELSE48_1
;Set SysForLoopABsValue to -StepValue :#1 
	comf	SYSFORLOOPSTEP10,W
	movwf	SysForLoopABsValue11
	comf	SYSFORLOOPSTEP10_H,W
	movwf	SysForLoopABsValue11_H
	incf	SysForLoopABsValue11,F
	btfsc	STATUS,Z
	incf	SysForLoopABsValue11_H,F
;IF ( SSD1306_BUFFERLOCATIONCALC - 32-1) } [WORD]SysForLoopABsValue11 THEN  :#1n 
	movlw	32
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
	banksel	SYSFORLOOPABSVALUE11
	movf	SYSFORLOOPABSVALUE11,W
	movwf	SysWORDTempB
	movf	SYSFORLOOPABSVALUE11_H,W
	movwf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF49
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	movf	SysForLoopStep10,W
	addwf	SSD1306_BUFFERLOCATIONCALC,F
	movf	SysForLoopStep10_H,W
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F
	goto	SysForLoop11
;END IF
ENDIF49
	goto	ENDIF48
ELSE48_1
;Integer positive Step Handler in For-next statement
;IF ([WORD]32-1 - [WORD]SSD1306_BUFFERLOCATIONCALC) } [WORD]SysForLoopStep10 THEN :#1p 
	movf	SSD1306_BUFFERLOCATIONCALC,W
	sublw	31
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
	banksel	SYSFORLOOPSTEP10
	movf	SYSFORLOOPSTEP10,W
	movwf	SysWORDTempB
	movf	SYSFORLOOPSTEP10_H,W
	movwf	SysWORDTempB_H
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF50
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	movf	SysForLoopStep10,W
	addwf	SSD1306_BUFFERLOCATIONCALC,F
	movf	SysForLoopStep10_H,W
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F
	goto	SysForLoop11
;END IF
ENDIF50
;END IF
ENDIF48
SysForLoopEnd11
;Removed at 1.14. Retained for documentation only
;Cursor_Position_SSD1306 ( 0 , 0 )
;for SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
;for GLCDTemp = 0 to 127
;Write_Data_SSD1306(GLCDBackground)
;Next
;next
;Cursor_Position_SSD1306 ( 0 , 0 )
	clrf	LOCX
	clrf	LOCY
	pagesel	CURSOR_POSITION_SSD1306
	call	CURSOR_POSITION_SSD1306
	pagesel	$
;PrintLocX =0
	clrf	PRINTLOCX
;PrintLocY =0
	clrf	PRINTLOCY
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
;if GLCDfntDefaultSize = 1 then
	decf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	ENDIF24
;test if character lies within current page
;GLCDY_Temp = CharLocY + 7
	movlw	7
	addwf	CHARLOCY,W
	movwf	GLCDY_TEMP
;Repeat 3
	movlw	3
	banksel	SYSREPEATTEMP2
	movwf	SysRepeatTemp2
SysRepeatLoop2
;Set C Off
	bcf	STATUS,C
;Rotate GLCDY_Temp Right
	banksel	GLCDY_TEMP
	rrf	GLCDY_TEMP,F
;End Repeat
	banksel	SYSREPEATTEMP2
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;IF GLCDY_Temp <> _GLCDPage THEN
	movf	_GLCDPAGE,W
	banksel	GLCDY_TEMP
	subwf	GLCDY_TEMP,W
	btfsc	STATUS, Z
	goto	ENDIF35
;GLCDY_Temp = GLCDY_Temp - 1
	decf	GLCDY_TEMP,F
;IF GLCDY_Temp <> _GLCDPage THEN
	banksel	_GLCDPAGE
	movf	_GLCDPAGE,W
	banksel	GLCDY_TEMP
	subwf	GLCDY_TEMP,W
	btfss	STATUS, Z
;EXIT SUB
	return
;END IF
;END IF
ENDIF35
;end if
ENDIF24
;****** Preamble
;invert colors if required
;if LineColour <> GLCDForeground  then
	movf	LINECOLOUR,W
	movwf	SysWORDTempA
	movf	LINECOLOUR_H,W
	movwf	SysWORDTempA_H
	movf	GLCDFOREGROUND,W
	movwf	SysWORDTempB
	movf	GLCDFOREGROUND_H,W
	movwf	SysWORDTempB_H
	pagesel	SYSCOMPEQUAL16
	call	SYSCOMPEQUAL16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF25
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = 0
	clrf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
;end if
ENDIF25
;dim CharCol, CharRow as word
;CharCode -= 15
	movlw	15
	subwf	CHARCODE,F
;CharCol=0
	clrf	CHARCOL
	clrf	CHARCOL_H
;Cursor_Position_SSD1306 ( CharLocX , CharLocY )
	movf	CHARLOCX,W
	movwf	LOCX
	movf	CHARLOCY,W
	movwf	LOCY
	pagesel	CURSOR_POSITION_SSD1306
	call	CURSOR_POSITION_SSD1306
	pagesel	$
;1.14 Added transaction
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1272)
;4wire not supported, see Write_Transaction_Data_SSD1306
;I2CStart
	pagesel	I2CSTART
	call	I2CSTART
	pagesel	$
;I2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend 0x40
	movlw	64
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;****** GCB Font set handler
;if CharCode>=178 and CharCode<=202 then
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	178
	movwf	SysBYTETempB
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	202
	movwf	SysBYTETempA
	pagesel	SYSCOMPLESSTHAN
	call	SYSCOMPLESSTHAN
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF26
;CharLocY=CharLocY-1
	movlw	1
	banksel	CHARLOCY
	subwf	CHARLOCY,F
	movlw	0
	subwfb	CHARLOCY_H,F
;end if
ENDIF26
;For CurrCharCol = 1 to 5
;Legacy method
	banksel	CURRCHARCOL
	clrf	CURRCHARCOL
SysForLoop6
	incf	CURRCHARCOL,F
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect1Case1
	decf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	call	GLCDCHARCOL3
	movwf	CURRCHARVAL
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	call	GLCDCHARCOL4
	movwf	CURRCHARVAL
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	call	GLCDCHARCOL5
	movwf	CURRCHARVAL
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	call	GLCDCHARCOL6
	movwf	CURRCHARVAL
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	5
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	call	GLCDCHARCOL7
	movwf	CURRCHARVAL
;End Select
SysSelectEnd1
;Full Memory GLCD mode
;1.14 Low Memory GLCD mode
;CharRow=0
	clrf	CHARROW
	clrf	CHARROW_H
;For CurrCharRow = 1 to 8
;Legacy method
	clrf	CURRCHARROW
SysForLoop7
	incf	CURRCHARROW,F
;CharColS=0
	clrf	CHARCOLS
;For Col=1 to GLCDfntDefaultsize
;Legacy method
	clrf	COL
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd8
SysForLoop8
	incf	COL,F
;CharRowS=0
	clrf	CHARROWS
;For Row=1 to GLCDfntDefaultsize
;Legacy method
	clrf	ROW
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd9
SysForLoop9
	incf	ROW,F
;GLCDY = [word]CharLocY + CharRow + CharRowS
	movf	CHARROW,W
	addwf	CHARLOCY,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	CHARROWS
	movf	CHARROWS,W
	banksel	SYSTEMP3
	addwf	SysTemp3,W
	banksel	GLCDY
	movwf	GLCDY
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0
	goto	ELSE29_1
;PSet [word]CharLocX + CharCol + CharColS, GLCDY, LineColour
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	CHARCOLS
	movf	CHARCOLS,W
	banksel	SYSTEMP3
	addwf	SysTemp3,W
	banksel	GLCDX
	movwf	GLCDX
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;Else
	goto	ENDIF29
ELSE29_1
;PSet [word]CharLocX + CharCol + CharColS, GLCDY, GLCDBackground
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	CHARCOLS
	movf	CHARCOLS,W
	banksel	SYSTEMP3
	addwf	SysTemp3,W
	banksel	GLCDX
	movwf	GLCDX
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;End if
ENDIF29
;End if
;CharRowS +=1
	incf	CHARROWS,F
;Put out a white intercharacter pixel/space
;if ( CharCol + CharColS ) = ( GLCDFontWidth * GLCDfntDefaultsize) - GLCDfntDefaultsize - 1 then
	movf	CHARCOLS,W
	addwf	CHARCOL,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	CHARCOL_H
	addwfc	CHARCOL_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	GLCDFONTWIDTH
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	call	SYSMULTSUB
	movf	SysBYTETempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	SYSTEMP2
	subwf	SysTemp2,W
	movwf	SysTemp3
	decf	SysTemp3,W
	movwf	SysTemp2
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	movf	SysTemp2,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPEQUAL16
	call	SYSCOMPEQUAL16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF30
;PSet [word]CharLocX + CharCol + CharColS + 1, [word]CharLocY + CharRow+CharRowS -1, GLCDBackground
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	CHARCOLS
	movf	CHARCOLS,W
	banksel	SYSTEMP3
	addwf	SysTemp3,W
	movwf	SysTemp1
	incf	SysTemp1,W
	banksel	GLCDX
	movwf	GLCDX
	movf	CHARROW,W
	addwf	CHARLOCY,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	CHARROWS
	movf	CHARROWS,W
	banksel	SYSTEMP3
	addwf	SysTemp3,W
	movwf	SysTemp1
	decf	SysTemp1,W
	banksel	GLCDY
	movwf	GLCDY
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_SSD1306
	call	PSET_SSD1306
	pagesel	$
;end if
ENDIF30
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W
	subwf	ROW,W
	btfss	STATUS, C
	goto	SysForLoop9
SysForLoopEnd9
;CharColS +=1
	incf	CHARCOLS,F
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W
	subwf	COL,W
	btfss	STATUS, C
	goto	SysForLoop8
SysForLoopEnd8
;Rotate CurrCharVal Right
	rrf	CURRCHARVAL,F
;CharRow +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W
	addwf	CHARROW,F
	movlw	0
	addwfc	CHARROW_H,F
;Next
	movlw	8
	subwf	CURRCHARROW,W
	btfss	STATUS, C
	goto	SysForLoop7
SysForLoopEnd7
;CharCol +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W
	addwf	CHARCOL,F
	movlw	0
	addwfc	CHARCOL_H,F
;1.12 Character GLCD mode
;Handles specific draw sequence. This caters for write only of a bit value. No read operation.
;Ensure this is not called with in Low memory mode
;Next
	movlw	5
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop6
SysForLoopEnd6
;****** OLED Font set handler
;1.14 Added transaction
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1336)
;4wire not supported, see Write_Transaction_Data_SSD1306
;I2CStop
	call	I2CSTOP
;Restore
;GLCDBackground = 0
	clrf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = 1
	movlw	1
	movwf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
	return

;********************************************************************************

;Source: i2c.h (277)
I2CSTOP
;Dim I2CINTSTATESAVE as BIT
;I2C_CLOCK_LOW                 'begin with SCL=0 and SDA=0
	banksel	TRISC
	bcf	TRISC,5
	banksel	LATC
	bcf	LATC,5
;I2C_DATA_LOW
	banksel	TRISC
	bcf	TRISC,4
	banksel	LATC
	bcf	LATC,4
;wait I2C_END_DELAY            'let ports settle
	movlw	2
	movwf	DELAYTEMP
DelayUS3
	decfsz	DELAYTEMP,F
	goto	DelayUS3
	nop
;I2C_CLOCK_HIGH                'make SCL=1 first
	banksel	TRISC
	bsf	TRISC,5
;wait I2C_CLOCK_DELAY          'hold for normal clock width time
	movlw	2
	movwf	DELAYTEMP
DelayUS4
	decfsz	DELAYTEMP,F
	goto	DelayUS4
	nop
;I2C_DATA_HIGH                 'then make SDA=1 afterwards
	bsf	TRISC,4
;wait I2C_END_DELAY            'hold for normal between-time
	movlw	2
	movwf	DELAYTEMP
DelayUS5
	decfsz	DELAYTEMP,F
	goto	DelayUS5
	nop
;back idling with SCL=1 and SDA=1 at this point
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
	movwf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
;GLCDFontWidth = 5
	movlw	5
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
;Setup code for SSD1306 controllers
;Init sequence for 128x64 OLED module
;Write_Command_SSD1306(SSD1306_DISPLAYOFF)                    ' 0xAE
	movlw	174
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_DEACTIVATE_SCROLL)
	movlw	46
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SETDISPLAYCLOCKDIV)            ' 0xD5
	movlw	213
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(0x80)                                  ' the suggested ratio 0x80
	movlw	128
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SETMULTIPLEX)                  ' 0xA8
	movlw	168
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(0x1f)                                 '32 pixels
	movlw	31
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SETDISPLAYOFFSET)              ' 0xD3
	movlw	211
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(0x00)                                   ' no offset
	clrf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;if(geometry == GEOMETRY_64_32)
;Write_Command_SSD1306(0x00)
	clrf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_CHARGEPUMP)                    ' 0x8D
	movlw	141
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;if (SSD1306_vccstate = SSD1306_EXTERNALVCC) then
;Write_Command_SSD1306(0x14)
	movlw	20
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;end if
;Write_Command_SSD1306(SSD1306_MEMORYMODE)                    ' 0x20
	movlw	32
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(0x10)                                  ' 0x01 act like PCD8544
	movlw	16
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SEGREMAP | 0x1)
	movlw	161
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_COMSCANDEC)
	movlw	200
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SETCOMPINS)                    ' 0xDA
	movlw	218
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(0x12)                                 '64 pixels
	movlw	18
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_SETCONTRAST)                   ' 0x81
	movlw	129
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xCF)
	movlw	207
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;end if
;Write_Command_SSD1306(SSD1306_SETPRECHARGE)                  ' 0xd9
	movlw	217
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xF1)
	movlw	241
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;end if
;Write_Command_SSD1306(SSD1306_SETVCOMDETECT)                 ' 0xDB
	movlw	219
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(0x40)
	movlw	64
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_DISPLAYALLON_RESUME)           ' 0xA4
	movlw	164
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Write_Command_SSD1306(SSD1306_NORMALDISPLAY)                 ' 0xA6
	movlw	166
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;Clear screen Here
;GLCDCLS_SSD1306
	call	GLCDCLS_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYON)                     '--turn on oled panel
	movlw	175
	movwf	SSD1306SENDBYTE
	pagesel	WRITE_COMMAND_SSD1306
	goto	WRITE_COMMAND_SSD1306

;********************************************************************************

;Source: i2c.h (191)
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
	banksel	TRISC
	bsf	TRISC,4
;!
;!
;! Key constants not defined. I2C_DATA and I2C_CLOCK are required.
;!
;! Have you called "I2CStart", "I2CSend" or "I2CStop" without correct configuration of these key constants for software I2C?
;!
;!
;I2C_CLOCK_HIGH                  'release SCL (open drain floats high)
	bsf	TRISC,5
;!
;!
;! Key constants not defined. I2C_DATA and I2C_CLOCK are required.
;!
;! Have you called "I2CStart", "I2CSend" or "I2CStop" without correct configuration of these key constants for software I2C?
;!
;!
;I2CMatch = FALSE                'address doesn't match (Slave mode)
	banksel	I2CMATCH
	clrf	I2CMATCH
	return

;********************************************************************************

;Source: system.h (201)
INITSYS
;Handle chips with only 2 IRCF bits (IRCF1, IRCF0) like 16F720/721 and its LF siblings
;16F72x has 500kHz INTOSC with 32x PLL option and postscaler (÷1,2,4,8)
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
	return

;********************************************************************************

;Source: string.h (124)
FN_STR
;SysCharCount = 0
	clrf	SYSCHARCOUNT
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF18
;SysStrData = SysValTemp / 10000
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSDIVSUB16
	call	SYSDIVSUB16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSSTRDATA
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValThousands
	goto	SYSVALTHOUSANDS
;End If
ENDIF18
;Thousands
;IF SysValTemp >= 1000 then
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF19
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSDIVSUB16
	call	SYSDIVSUB16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSSTRDATA
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValHundreds
	goto	SYSVALHUNDREDS
;End If
ENDIF19
;Hundreds
;IF SysValTemp >= 100 then
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF20
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSDIVSUB16
	call	SYSDIVSUB16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSSTRDATA
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValTens
	goto	SYSVALTENS
;End If
ENDIF20
;Tens
;IF SysValTemp >= 10 Then
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSCOMPLESSTHAN16
	call	SYSCOMPLESSTHAN16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF21
SYSVALTENS
;SysStrData = SysValTemp / 10
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SYSDIVSUB16
	call	SYSDIVSUB16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSSTRDATA
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;End If
ENDIF21
;Ones
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSVALTEMP,W
	movwf	INDF0
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;Str(0) = SysCharCount
	banksel	SYSCHARCOUNT
	movf	SYSCHARCOUNT,W
	banksel	SYSSTR_0
	movwf	SYSSTR_0
	banksel	STATUS
	return

;********************************************************************************

;Source: system.h (2924)
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

;Program_memory_page: 1
	ORG	2048
;Source: GLCD_SSD1306.H (1085)
CURSOR_POSITION_SSD1306
;dim  PosCharX, PosCharX as Word
;PosCharY = LocY / 8
;faster than /8
;PosCharY = LocY
	movf	LOCY,W
	movwf	POSCHARY
;Repeat 3
	movlw	3
	banksel	SYSREPEATTEMP5
	movwf	SysRepeatTemp5
SysRepeatLoop5
;Set C Off
	bcf	STATUS,C
;Rotate PosCharY Right
	banksel	POSCHARY
	rrf	POSCHARY,F
;End Repeat
	banksel	SYSREPEATTEMP5
	decfsz	SysRepeatTemp5,F
	goto	SysRepeatLoop5
SysRepeatLoopEnd5
;LocX = LocX + GLCD_TYPE_SSD1306_64x32_XOFFSET
	movlw	32
	banksel	LOCX
	addwf	LOCX,F
;Write_Command_SSD1306( 0xB0 + PosCharY )   ' set page address
	movlw	176
	addwf	POSCHARY,W
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;PosCharX = ( LocX  & 0x0f )  ' lower nibble
	movlw	15
	andwf	LOCX,W
	movwf	POSCHARX
	clrf	POSCHARX_H
;Write_Command_SSD1306( PosCharX )
	movf	POSCHARX,W
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
	pagesel	$
;PosCharX = LocX
	movf	LOCX,W
	movwf	POSCHARX
	clrf	POSCHARX_H
;Repeat 4
	movlw	4
	banksel	SYSREPEATTEMP5
	movwf	SysRepeatTemp5
SysRepeatLoop6
;Set C off
	bcf	STATUS,C
;Rotate PosCharX Right
	banksel	POSCHARX_H
	rrf	POSCHARX_H,F
	rrf	POSCHARX,F
;End Repeat
	banksel	SYSREPEATTEMP5
	decfsz	SysRepeatTemp5,F
	goto	SysRepeatLoop6
SysRepeatLoopEnd6
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
;Write_Command_SSD1306 ( PosCharX )
	movf	POSCHARX,W
	movwf	SSD1306SENDBYTE
	goto	WRITE_COMMAND_SSD1306

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

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (1293)
GLCDPRINT4
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	movf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	movf	GLCDPRINTLEN,F
	btfsc	STATUS, Z
;If GLCDPrintLen = 0 Then Exit Sub
	return
;If GLCDPrintLen = 0 Then Exit Sub
;GLCDPrintLoc = PrintLocX
	movf	PRINTLOCX,W
	movwf	GLCDPRINTLOC
	movf	PRINTLOCX_H,W
	movwf	GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
;Legacy method
	clrf	GLCDPRINT_STRING_COUNTER
	movlw	1
	subwf	GLCDPRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
SysForLoop3
	incf	GLCDPRINT_STRING_COUNTER,F
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	movf	GLCDPRINTLOC,W
	movwf	CHARLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	CHARLOCX_H
	movf	PRINTLOCY,W
	movwf	CHARLOCY
	movf	PRINTLOCY_H,W
	movwf	CHARLOCY_H
	movf	GLCDPRINT_STRING_COUNTER,W
	addwf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	CHARCODE
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWCHAR_SSD1306
	call	GLCDDRAWCHAR_SSD1306
	pagesel	$
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1530)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	pagesel	SYSMULTSUB
	call	SYSMULTSUB
	pagesel	$
	movf	SysBYTETempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movlw	1
	addwf	SysTemp2,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Next
	movf	GLCDPRINTLEN,W
	subwf	GLCDPRINT_STRING_COUNTER,W
	btfss	STATUS, C
	goto	SysForLoop3
SysForLoopEnd3
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movf	GLCDPRINTLOC,W
	movwf	PRINTLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	PRINTLOCX_H
	return

;********************************************************************************

;Source: i2c.h (365)
I2CSEND
;I2C_CLOCK_LOW                 'begin with SCL=0
	banksel	TRISC
	bcf	TRISC,5
	banksel	LATC
	bcf	LATC,5
;wait I2C_END_DELAY            'let port settle
	movlw	2
	movwf	DELAYTEMP
DelayUS6
	decfsz	DELAYTEMP,F
	goto	DelayUS6
	nop
;repeat 8                      '8 data bits
	movlw	8
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop1
;if I2CByte.7 = ON then      'put most significant bit on SDA line
	banksel	I2CBYTE
	btfss	I2CBYTE,7
	goto	ELSE22_1
;I2C_DATA_HIGH
	banksel	TRISC
	bsf	TRISC,4
;else
	goto	ENDIF22
ELSE22_1
;I2C_DATA_LOW
	banksel	TRISC
	bcf	TRISC,4
	banksel	LATC
	bcf	LATC,4
;end if
ENDIF22
;rotate I2CByte left         'shift in bit for the next time
	banksel	I2CBYTE
	rlf	I2CBYTE,F
;I2C_CLOCK_HIGH              'now clock it in
	banksel	TRISC
	bsf	TRISC,5
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop1
	banksel	PORTC
	btfss	PORTC,5
	goto	SysWaitLoop1
;wait I2C_CLOCK_DELAY        'clock pulse width given here
	movlw	2
	movwf	DELAYTEMP
DelayUS7
	decfsz	DELAYTEMP,F
	goto	DelayUS7
	nop
;I2C_CLOCK_LOW               'done clocking that bit
	banksel	TRISC
	bcf	TRISC,5
	banksel	LATC
	bcf	LATC,5
;wait I2C_END_DELAY          'time between clock pulses
	movlw	2
	movwf	DELAYTEMP
DelayUS8
	decfsz	DELAYTEMP,F
	goto	DelayUS8
	nop
;end repeat                    'then do next bit
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;wait I2C_BIT_DELAY            'pad timing just a little
	movlw	5
	movwf	DELAYTEMP
DelayUS9
	decfsz	DELAYTEMP,F
	goto	DelayUS9
;I2C_DATA_HIGH                 'idle SDA to let Slave respond
	bsf	TRISC,4
;wait I2C_END_DELAY            'let SDA port line settle
	movlw	2
	movwf	DELAYTEMP
DelayUS10
	decfsz	DELAYTEMP,F
	goto	DelayUS10
	nop
;I2C_CLOCK_HIGH                'clock for the ACK/NAK bit
	bsf	TRISC,5
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop2
	banksel	PORTC
	btfss	PORTC,5
	goto	SysWaitLoop2
;restored 'I2CSendState' variable for backwards compatibility
;if I2C_DATA then              'read 9th bit in from Slave
	btfss	PORTC,4
	goto	ELSE23_1
;I2CAck = FALSE              'return a NAK to the program
	clrf	I2CACK
;I2CSendState =  FALSE        'state of target device with respect. Retained for backwards compatibility
	clrf	I2CACKPOLLSTATE
;else
	goto	ENDIF23
ELSE23_1
;I2CAck = TRUE               'else, return an ACK to the program
	movlw	255
	movwf	I2CACK
;I2CSendState =  TRUE        'state of target device with respect. Retained for backwards compatibility
	movlw	255
	movwf	I2CACKPOLLSTATE
;end if
ENDIF23
;I2C_CLOCK_LOW                 'may be more bytes to clock out
	banksel	TRISC
	bcf	TRISC,5
	banksel	LATC
	bcf	LATC,5
;wait I2C_END_DELAY            'so keep idling both
	movlw	2
	movwf	DELAYTEMP
DelayUS11
	decfsz	DELAYTEMP,F
	goto	DelayUS11
	nop
;I2C_DATA_LOW                  'SCL and SDA low
	banksel	TRISC
	bcf	TRISC,4
	banksel	LATC
	bcf	LATC,4
;wait I2C_BIT_DELAY            'wait the usual bit length
	movlw	5
	movwf	DELAYTEMP
DelayUS12
	decfsz	DELAYTEMP,F
	goto	DelayUS12
	banksel	STATUS
	return

;********************************************************************************

;Source: i2c.h (227)
I2CSTART
;Dim I2CINTSTATESAVE as BIT
;I2C_DATA_HIGH                 'SDA and SCL idle high
	banksel	TRISC
	bsf	TRISC,4
;I2C_CLOCK_HIGH
	bsf	TRISC,5
;wait I2C_END_DELAY            'let settle a while
	movlw	2
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	nop
;I2C_DATA_LOW                  'then, SDA low while SCL still high
	bcf	TRISC,4
	banksel	LATC
	bcf	LATC,4
;wait I2C_CLOCK_DELAY          'for this amount of time
	movlw	2
	movwf	DELAYTEMP
DelayUS2
	decfsz	DELAYTEMP,F
	goto	DelayUS2
	nop
;I2C_CLOCK_LOW                 'end with SCL low, ready to clock
	banksel	TRISC
	bcf	TRISC,5
	banksel	LATC
	bcf	LATC,5
	banksel	STATUS
	return

;********************************************************************************

;Source: GLCD_SSD1306.H (920)
PSET_SSD1306
;Set pixel at X, Y on LCD to State
;X is 0 to 127
;Y is 0 to 63
;Origin in top left
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
	movf	GLCDY,W
	movwf	GLCDY_TEMP
;Repeat 3
	movlw	3
	banksel	SYSREPEATTEMP3
	movwf	SysRepeatTemp3
SysRepeatLoop3
;Set C Off
	bcf	STATUS,C
;Rotate GLCDY_Temp Right
	banksel	GLCDY_TEMP
	rrf	GLCDY_TEMP,F
;End Repeat
	banksel	SYSREPEATTEMP3
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
;if GLCDY_Temp = _GLCDPage then
	movf	_GLCDPAGE,W
	banksel	GLCDY_TEMP
	subwf	GLCDY_TEMP,W
	btfss	STATUS, Z
	goto	ELSE37_1
;Mod the YPOS to get the correct pixel with the page
;GLCDY = GLCDY mod 8
	movf	GLCDY,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	call	SYSDIVSUB
	movf	SysBYTETempX,W
	movwf	GLCDY
;Else
	goto	ENDIF37
ELSE37_1
;Exit if not the page we are looking for
;exit sub
	return
;end if
ENDIF37
;buffer location in LOWMEMORY_GLCD_MODE always equals GLCDX + 1
;SSD1306_BufferLocationCalc = GLCDX + 1
	movlw	1
	addwf	GLCDX,W
	movwf	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H
	btfsc	STATUS,C
	incf	SSD1306_BUFFERLOCATIONCALC_H,F
;don't need to do these calculations for in LOWMEMORY_GLCD_MODE
;GLCDDataTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
	movlw	low(SSD1306_BUFFERALIAS)
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	GLCDDATATEMP
;Change data to set/clear pixel
;GLCDBitNo = GLCDY And 7
	movlw	7
	andwf	GLCDY,W
	movwf	GLCDBITNO
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0
	goto	ELSE38_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE
;Set C On
	bsf	STATUS,C
;Else
	goto	ENDIF38
ELSE38_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE
;Set C Off
	bcf	STATUS,C
;End If
ENDIF38
;Repeat GLCDBitNo
	movf	GLCDBITNO,W
	banksel	SYSREPEATTEMP3
	movwf	SysRepeatTemp3
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd4
SysRepeatLoop4
;Rotate GLCDChange Left
	banksel	GLCDCHANGE
	rlf	GLCDCHANGE,F
;End Repeat
	banksel	SYSREPEATTEMP3
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop4
SysRepeatLoopEnd4
;If GLCDColour.0 = 0 Then
	banksel	GLCDCOLOUR
	btfsc	GLCDCOLOUR,0
	goto	ELSE39_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	movf	GLCDDATATEMP,W
	andwf	GLCDCHANGE,W
	movwf	GLCDDATATEMP
;Else
	goto	ENDIF39
ELSE39_1
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	movf	GLCDDATATEMP,W
	iorwf	GLCDCHANGE,W
	movwf	GLCDDATATEMP
;End If
ENDIF39
;added 1.14 to isolate from full glcd mode
;restore address the correct page by adjustng the Y
;GLCDY = GLCDY + ( 8 * _GLCDPage )
	banksel	_GLCDPAGE
	movf	_GLCDPAGE,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SYSMULTSUB
	call	SYSMULTSUB
	pagesel	$
	movf	SysBYTETempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	GLCDY
	addwf	GLCDY,F
;if SSD1306_BufferAlias(SSD1306_BufferLocationCalc) <> GLCDDataTemp then
	movlw	low(SSD1306_BUFFERALIAS)
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	movf	GLCDDATATEMP,W
	subwf	INDF0,W
	btfsc	STATUS, Z
	goto	ENDIF40
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDDataTemp
	movlw	low(SSD1306_BUFFERALIAS)
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	movf	GLCDDATATEMP,W
	movwf	INDF0
;end if
ENDIF40
;revised 1.14 to isolate from low memory mode
	return

;********************************************************************************

;Source: system.h (4137)
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

;Source: system.h (4501)
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

;Source: system.h (4531)
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

;Source: system.h (1766)
SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length
;movf INDF0, W
	movf	INDF0, W
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysCopyStringCheck
	goto	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART
;movf INDF0, W
	movf	INDF0, W
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F
SYSCOPYSTRINGCHECK
;Exit if length = 0
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
SYSSTRINGCOPY
;Increment pointers
;addfsr 0, 1
	addfsr	0, 1
;addfsr 1, 1
	addfsr	1, 1
;Copy character
;movf INDF0, W
	movf	INDF0, W
;movwf INDF1
	movwf	INDF1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F
;goto SysStringCopy
	goto	SYSSTRINGCOPY
	return

;********************************************************************************

;Source: system.h (3437)
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

;Source: system.h (3505)
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
	goto	ENDIF41
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF41
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
	goto	ENDIF42
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF42
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

;Source: system.h (1963)
SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
;Copy
SYSSTRINGREAD
;Get char
;call SysStringTables
	call	SYSSTRINGTABLES
;Set char
;addfsr 1,1
	addfsr	1,1
;movwf INDF1
	movwf	INDF1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F
;goto SysStringRead
	goto	SYSSTRINGREAD
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

StringTable1
	retlw	1
	retlw	48	;0


StringTable2
	retlw	1
	retlw	58	;:


;********************************************************************************

;Source: GLCD_SSD1306.H (256)
WRITE_COMMAND_SSD1306
;I2CStart
	call	I2CSTART
;I2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE
	call	I2CSEND
;I2CSend 0x00
	clrf	I2CBYTE
	call	I2CSEND
;I2CSend SSD1306SendByte
	movf	SSD1306SENDBYTE,W
	movwf	I2CBYTE
	call	I2CSEND
;I2CStop
	pagesel	I2CSTOP
	goto	I2CSTOP

;********************************************************************************

;Program_memory_page: 2
	ORG	4096
;Program_memory_page: 3
	ORG	6144

 END
