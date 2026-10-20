;Program compiled by GCBASIC (2026.10.01 (Windows 64 bit) : Build 1654) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2026-10-05 CRC170
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : \\192.168.0.104\d\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_Low_Pin_Count_Demo_Board\PICKit2_Board\16F18126\215_i2c_glcd_bmp_ssd1306_128_64.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 2
;   Assembler        : GCASM
;   Programmer       : 
;   Output file      : \\192.168.0.104\d\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_Low_Pin_Count_Demo_Board\PICKit2_Board\16F18126\215_i2c_glcd_bmp_ssd1306_128_64.build\215_i2c_glcd_bmp_ssd1306_128_64.asm
;   Float Capability : 1
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F18126, r=DEC
 TITLE       "\\192.168.0.104\d\GreatCowBASICGits\Demonstration_Sources.git\Vendor_Boards\Microchip_Low_Pin_Count_Demo_Board\PICKit2_Board\16F18126\215_i2c_glcd_bmp_ssd1306_128_64.gcb"
 SUBTITLE    "10-05-2026 13:55:59"
#include <P16F18126.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _RSTOSC_HFINTOSC_32MHZ & _FEXTOSC_OFF
 __CONFIG _CONFIG2, _MCLRE_INTMCLR
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF & _WRTSAF_OFF & _WRTD_OFF & _WRTB_OFF
 __CONFIG _CONFIG5, _CPD_OFF & _CP_OFF

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
FIRSTPASS                        EQU      47          ; 0x2F
GLCDBACKGROUND                   EQU      48          ; 0x30
GLCDBACKGROUND_H                 EQU      49          ; 0x31
GLCDBITNO                        EQU      50          ; 0x32
GLCDCHANGE                       EQU      51          ; 0x33
GLCDCOLOUR                       EQU      52          ; 0x34
GLCDCOLOUR_H                     EQU      53          ; 0x35
GLCDDATATEMP                     EQU      54          ; 0x36
GLCDFNTDEFAULT                   EQU      55          ; 0x37
GLCDFNTDEFAULTHEIGHT             EQU      56          ; 0x38
GLCDFNTDEFAULTSIZE               EQU      57          ; 0x39
GLCDFONTWIDTH                    EQU      58          ; 0x3A
GLCDFOREGROUND                   EQU      59          ; 0x3B
GLCDFOREGROUND_H                 EQU      60          ; 0x3C
GLCDPRINTLEN                     EQU      61          ; 0x3D
GLCDPRINTLOC                     EQU      62          ; 0x3E
GLCDPRINTLOC_H                   EQU      63          ; 0x3F
GLCDPRINT_STRING_COUNTER         EQU      64          ; 0x40
GLCDTEMP                         EQU      65          ; 0x41
GLCDX                            EQU      66          ; 0x42
GLCDY                            EQU      67          ; 0x43
GLCD_YORDINATE                   EQU      68          ; 0x44
GLCD_YORDINATE_H                 EQU      69          ; 0x45
HEIGHTOFPICTURE                  EQU      70          ; 0x46
HI2CACKPOLLSTATE                 EQU      71          ; 0x47
HI2CCURRENTMODE                  EQU      72          ; 0x48
HI2CWAITMSSPTIMEOUT              EQU      73          ; 0x49
I2CBYTE                          EQU      74          ; 0x4A
LENGTHOFPICTURE                  EQU      75          ; 0x4B
LENGTHOFPICTURE_H                EQU      76          ; 0x4C
LINECOLOUR                       EQU      77          ; 0x4D
LINECOLOUR_H                     EQU      78          ; 0x4E
LOCX                             EQU      79          ; 0x4F
LOCY                             EQU      80          ; 0x50
ORGCHARLOCX                      EQU      81          ; 0x51
POSCHARX                         EQU      82          ; 0x52
POSCHARX_H                       EQU      83          ; 0x53
POSCHARY                         EQU      84          ; 0x54
PRINTLOCX                        EQU      85          ; 0x55
PRINTLOCX_H                      EQU      86          ; 0x56
PRINTLOCY                        EQU      87          ; 0x57
PRINTLOCY_H                      EQU      88          ; 0x58
RAM_INDEX                        EQU      89          ; 0x59
RAM_INDEX_H                      EQU      90          ; 0x5A
ROW                              EQU      91          ; 0x5B
SSD1306SENDBYTE                  EQU      92          ; 0x5C
SSD1306_BUFFERALIAS              EQU    9199          ; 0x23EF
SSD1306_BUFFERLOCATIONCALC       EQU      93          ; 0x5D
SSD1306_BUFFERLOCATIONCALC_H     EQU      94          ; 0x5E
STRINGPOINTER                    EQU      95          ; 0x5F
SYSBYTETEMPA                     EQU     117          ; 0x75 (SA)
SYSBYTETEMPB                     EQU     121          ; 0x79 (SA)
SYSBYTETEMPX                     EQU     112          ; 0x70 (SA)
SYSDIVLOOP                       EQU     116          ; 0x74 (SA)
SYSDIVMULTA                      EQU     119          ; 0x77 (SA)
SYSDIVMULTA_H                    EQU     120          ; 0x78 (SA)
SYSDIVMULTB                      EQU     123          ; 0x7B (SA)
SYSDIVMULTB_H                    EQU     124          ; 0x7C (SA)
SYSDIVMULTX                      EQU     114          ; 0x72 (SA)
SYSDIVMULTX_H                    EQU     115          ; 0x73 (SA)
SYSFORLOOPABSVALUE4              EQU      96          ; 0x60
SYSFORLOOPABSVALUE4_H            EQU      97          ; 0x61
SYSFORLOOPSTEP3                  EQU      98          ; 0x62
SYSFORLOOPSTEP3_H                EQU      99          ; 0x63
SYSLCDPRINTDATAHANDLER           EQU     100          ; 0x64
SYSLCDPRINTDATAHANDLER_H         EQU     101          ; 0x65
SYSREPEATTEMP1                   EQU     102          ; 0x66
SYSREPEATTEMP4                   EQU     103          ; 0x67
SYSSTRINGA                       EQU     119          ; 0x77 (SA)
SYSSTRINGA_H                     EQU     120          ; 0x78 (SA)
SYSTEMP1                         EQU     104          ; 0x68
SYSTEMP1_H                       EQU     105          ; 0x69
SYSTEMP2                         EQU     106          ; 0x6A
SYSTEMP2_H                       EQU     107          ; 0x6B
SYSTEMP3                         EQU     108          ; 0x6C
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
WIDTHOFPICTURE                   EQU     109          ; 0x6D

;********************************************************************************

;Alias variables
AFSR0 EQU 4
AFSR0_H EQU 5

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

;Start_of_the_main_program
;''
;''This demonstration program is a simple GLCD demonstration of the SSD1306 GLCD capabilities.
;''
;''This program is a simple GLCD demonstration of the SSD1306 GLCD capabilities.
;''This program draws lines, boxes, circles and prints strings and numbers.
;''The SSD1306 controller a small graphical OLED, suitable for a lot of various projects.
;''The display is 38*35 mm, with an active display surface of 0.96inches, and a 128*64 pixel resolution.
;''The display is easy to interface, using an I2C type of communication.
;''The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;''
;''This version is compatible will all version of GCBASIC as this demonstration uses Full Memory GLCD mode only.  This can be adapted to Low Memory GLCD mode.
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.00
;''@date    31.11.2022
;----- Configuration
;Chip Settings.
;Generated by PIC PPS Tool for GCBASIC
;PPS Tool version: 0.0.6.3
;PinManager data: Not available (3)
;Generated for 16f18126
;
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
;' IO:    ---------------------------------
;'-----------------------------------------
;'
;' ------------------PORTC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ------------TX-LED--LED-LED LED--
;'-----------------------------------------
;Define constants to make things easier. We can reuse these at any time.
;Dir     RC0         Out
	bcf	TRISC,0
;Dir     RC1         Out
	bcf	TRISC,1
;Dir     RC2         Out
	bcf	TRISC,2
;Dir     RC3         Out
	bcf	TRISC,3
;Dir     POTENTIOMETER In
	bsf	TRISA,0
;Dir     SWITCHIN      In
	bsf	TRISA,3
;Setup Serial port
;Define I2C settings
;Initialise I2C - note for the I2C module the ports need to be set to IN
;Dir HI2C_DATA In
	bsf	TRISA,4
;Dir HI2C_CLOCK In
	bsf	TRISA,1
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;A constant to  allow you to change the GLCD memory usage.
;Include a BMP file.  This will automatically convert to a table called ANOBIUMFULL
;Dim lengthofpicture, ram_index as word
;Dim bytenumber, widthofpicture, heightofpicture, orgcharlocx, currcharval, firstpass, charlocy, currcharrow, charlocx, ccount as Byte
;Display a BMP file
;GLCDCLS
	call	GLCDCLS_SSD1306
;GLCDPrintStringLn "About to load BMP"
	movlw	low StringTable4
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysLCDPRINTDATAHandler_H
	call	GLCDPRINTSTRINGLN
;Wait 1 s
	movlw	1
	movwf	SysWaitTempS
	call	Delay_S
;Add your own case statement here to handle multiple BMPs, you just  need the variables to be defined
;ReadTable AnobiumFull, 0, lengthofpicture
;?F1L118S0I82?
;ReadTable AnobiumFull, 1, widthofpicture
;?F1L119S0I83?
;ReadTable AnobiumFull, 2, heightofpicture
;?F1L120S0I84?
;lengthofpicture =  heightofpicture / 8
	movf	HEIGHTOFPICTURE,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	movlw	8
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	LENGTHOFPICTURE
	movf	SysWORDTempA_H,W
	movwf	LENGTHOFPICTURE_H
;lengthofpicture = [word]lengthofpicture * widthofpicture
	movf	LENGTHOFPICTURE,W
	movwf	SysWORDTempA
	movf	LENGTHOFPICTURE_H,W
	movwf	SysWORDTempA_H
	movf	WIDTHOFPICTURE,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSMULTSUB16
	movf	SysWORDTempX,W
	movwf	LENGTHOFPICTURE
	movf	SysWORDTempX_H,W
	movwf	LENGTHOFPICTURE_H
;For BMP that fit the display simple write the data to the screen
;CharLocX = 0                       ' specify X pos for BMP
	clrf	CHARLOCX
;CharLocY = 0                       ' specify Y pos for BMP.  For buffer any valid Y, for non-buffered 0,8,16, 24 etc...
	clrf	CHARLOCY
;OrgCharLocX = CharLocX              ' specify X orginisal X pos
	movf	CHARLOCX,W
	movwf	ORGCHARLOCX
;firstpass = true                    ' specify this is the first pass
	movlw	255
	movwf	FIRSTPASS
;for  ram_index =  3 to lengthofpicture + 3         ; start at third byte and finish at the end
;Legacy method
	movlw	2
	movwf	RAM_INDEX
	clrf	RAM_INDEX_H
	movlw	3
	addwf	LENGTHOFPICTURE,W
	movwf	SysTemp1
	movlw	0
	addwfc	LENGTHOFPICTURE_H,W
	movwf	SysTemp1_H
	movlw	3
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd1
SysForLoop1
	incf	RAM_INDEX,F
	btfsc	STATUS,Z
	incf	RAM_INDEX_H,F
;Add your own case statement here to handle multiple BMPs, you just  need set CurrCharVal to the data value
;ReadTable AnobiumFull,  ( ram_index ), CurrCharVal  ' read data
;?F1L134S0I98?
;if ( ( ram_index - 3 ) % widthofpicture ) = 0  and firstpass = false then     ' change position for new line of data
	movlw	3
	subwf	RAM_INDEX,W
	movwf	SysTemp1
	movlw	0
	subwfb	RAM_INDEX_H,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	movf	WIDTHOFPICTURE,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempX,W
	movwf	SysTemp2
	movf	SysWORDTempX_H,W
	movwf	SysTemp2_H
	movf	SysTemp2,W
	movwf	SysWORDTempA
	movf	SysTemp2_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPEQUAL16
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	FIRSTPASS,W
	movwf	SysBYTETempA
	clrf	SysBYTETempB
	call	SYSCOMPEQUAL
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF2
;CharLocY = CharLocY + 8
	movlw	8
	addwf	CHARLOCY,F
;CharLocX = OrgCharLocX
	movf	ORGCHARLOCX,W
	movwf	CHARLOCX
;end if
ENDIF2
;For CurrCharRow = 0 to 7
;Legacy method
	movlw	255
	movwf	CURRCHARROW
SysForLoop2
	incf	CURRCHARROW,F
;if ( CharLocY + CurrCharRow < GLCD_HEIGHT ) and ( CharLocX < GLCD_WIDTH ) then
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	64
	movwf	SysBYTETempB
	call	SYSCOMPLESSTHAN
	movf	SysByteTempX,W
	movwf	SysTemp2
	movf	CHARLOCX,W
	movwf	SysBYTETempA
	movlw	128
	movwf	SysBYTETempB
	call	SYSCOMPLESSTHAN
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	SysTemp2,W
	andwf	SysTemp1,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ENDIF3
;If CurrCharVal.0 = 0 Then
	btfsc	CURRCHARVAL,0
	goto	ELSE6_1
;PSet CharLocX , CharLocY + CurrCharRow, GLCDBackground
	movf	CHARLOCX,W
	movwf	GLCDX
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	movwf	GLCDY
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_SSD1306
;Else
	goto	ENDIF6
ELSE6_1
;PSet CharLocX , CharLocY + CurrCharRow, GLCDForeground
	movf	CHARLOCX,W
	movwf	GLCDX
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	movwf	GLCDY
	movf	GLCDFOREGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_SSD1306
;End If
ENDIF6
;end if
ENDIF3
;Rotate CurrCharVal Right
	rrf	CURRCHARVAL,F
;Next
	movlw	7
	subwf	CURRCHARROW,W
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
;firstpass = false                                          ' now this is NOT the first pass
	clrf	FIRSTPASS
;CharLocX++                                                 ' increment the X pos
	incf	CHARLOCX,F
;next
	movlw	3
	addwf	LENGTHOFPICTURE,W
	movwf	SysTemp1
	movlw	0
	addwfc	LENGTHOFPICTURE_H,W
	movwf	SysTemp1_H
	movf	RAM_INDEX,W
	movwf	SysWORDTempA
	movf	RAM_INDEX_H,W
	movwf	SysWORDTempA_H
	movf	SysTemp1,W
	movwf	SysWORDTempB
	movf	SysTemp1_H,W
	movwf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0
	goto	SysForLoop1
SysForLoopEnd1
;GLCD SSD1306 buffer is 1024bytes
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

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
	movwf	SysRepeatTemp4
SysRepeatLoop4
;Set C Off
	bcf	STATUS,C
;Rotate PosCharY Right
	rrf	POSCHARY,F
;End Repeat
	decfsz	SysRepeatTemp4,F
	goto	SysRepeatLoop4
SysRepeatLoopEnd4
;Write_Command_SSD1306( 0xB0 + PosCharY )   ' set page address
	movlw	176
	addwf	POSCHARY,W
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;PosCharX = ( LocX  & 0x0f )  ' lower nibble
	movlw	15
	andwf	LOCX,W
	movwf	POSCHARX
	clrf	POSCHARX_H
;Write_Command_SSD1306( PosCharX )
	movf	POSCHARX,W
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;PosCharX = LocX
	movf	LOCX,W
	movwf	POSCHARX
	clrf	POSCHARX_H
;Repeat 4
	movlw	4
	movwf	SysRepeatTemp4
SysRepeatLoop5
;Set C off
	bcf	STATUS,C
;Rotate PosCharX Right
	rrf	POSCHARX_H,F
	rrf	POSCHARX,F
;End Repeat
	decfsz	SysRepeatTemp4,F
	goto	SysRepeatLoop5
SysRepeatLoopEnd5
;PosCharX = ( PosCharX & 0x0F ) + 0x10
	movlw	15
	andwf	POSCHARX,W
	movwf	SysTemp1
	clrf	SysTemp1_H
	movlw	16
	addwf	SysTemp1,W
	movwf	POSCHARX
	movlw	0
	addwfc	SysTemp1_H,W
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
;For SSD1306_BufferLocationCalc = 1 to GLCD_HEIGHT * GLCD_WIDTH / 8
;Legacy method
	clrf	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H
SysForLoop3
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
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0
	goto	SysForLoop3
SysForLoopEnd3
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	clrf	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H
SysForLoop4
;Init SysForLoopStep3 :#0
	movlw	8
	movwf	SysForLoopStep3
	clrf	SysForLoopStep3_H
;Cursor_Position_SSD1306 ( 0 , SSD1306_BufferLocationCalc )
	clrf	LOCX
	movf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	LOCY
	call	CURSOR_POSITION_SSD1306
;Open_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1272)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	call	HI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CSend 0x40
	movlw	64
	movwf	I2CBYTE
	call	HI2CSEND
;For GLCDTemp = 0 to 127
;Legacy method
	movlw	255
	movwf	GLCDTEMP
SysForLoop5
	incf	GLCDTEMP,F
;Write_Transaction_Data_SSD1306(GLCDBackground)
;Macro Source: GLCD_SSD1306.H (1303)
;HI2CSend SSD1306SendByte
	movf	GLCDBACKGROUND,W
	movwf	I2CBYTE
	call	HI2CSEND
;Next
	movlw	127
	subwf	GLCDTEMP,W
	btfss	STATUS, C
	goto	SysForLoop5
SysForLoopEnd5
;Close_Transaction_SSD1306
;Macro Source: GLCD_SSD1306.H (1336)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	call	HI2CSTOP
;Next
;Integer negative Step Handler in For-next statement
	btfss	SYSFORLOOPSTEP3_H,7
	goto	ELSE14_1
;Set SysForLoopABsValue to -StepValue :#1 
	comf	SYSFORLOOPSTEP3,W
	movwf	SysForLoopABsValue4
	comf	SYSFORLOOPSTEP3_H,W
	movwf	SysForLoopABsValue4_H
	incf	SysForLoopABsValue4,F
	btfsc	STATUS,Z
	incf	SysForLoopABsValue4_H,F
;IF ( SSD1306_BUFFERLOCATIONCALC - 64-1) } [WORD]SysForLoopABsValue4 THEN  :#1n 
	movlw	64
	subwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	SysTemp1
	movlw	0
	subwfb	SSD1306_BUFFERLOCATIONCALC_H,W
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
	movf	SYSFORLOOPABSVALUE4,W
	movwf	SysWORDTempB
	movf	SYSFORLOOPABSVALUE4_H,W
	movwf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF15
;Set LoopVar to LoopVar + StepValue where StepValue is a negative value
	movf	SysForLoopStep3,W
	addwf	SSD1306_BUFFERLOCATIONCALC,F
	movf	SysForLoopStep3_H,W
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F
	goto	SysForLoop4
;END IF
ENDIF15
	goto	ENDIF14
ELSE14_1
;Integer positive Step Handler in For-next statement
;IF ([WORD]64-1 - [WORD]SSD1306_BUFFERLOCATIONCALC) } [WORD]SysForLoopStep3 THEN :#1p 
	movf	SSD1306_BUFFERLOCATIONCALC,W
	sublw	63
	movwf	SysTemp1
	clrf	SysTemp3
	movf	SSD1306_BUFFERLOCATIONCALC_H,W
	subwfb	SysTemp3,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	movf	SYSFORLOOPSTEP3,W
	movwf	SysWORDTempB
	movf	SYSFORLOOPSTEP3_H,W
	movwf	SysWORDTempB_H
	call	SYSCOMPLESSTHAN16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF16
;Set LoopVar to LoopVar + StepValue where StepValue is a positive value
	movf	SysForLoopStep3,W
	addwf	SSD1306_BUFFERLOCATIONCALC,F
	movf	SysForLoopStep3_H,W
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,F
	goto	SysForLoop4
;END IF
ENDIF16
;END IF
ENDIF14
SysForLoopEnd4
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
	call	CURSOR_POSITION_SSD1306
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
	call	SYSCOMPEQUAL16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF37
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = 0
	clrf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
;end if
ENDIF37
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
	call	CURSOR_POSITION_SSD1306
;1.14 Added transaction
;****** GCB Font set handler
;if CharCode>=178 and CharCode<=202 then
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	178
	movwf	SysBYTETempB
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp3
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	202
	movwf	SysBYTETempA
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F
	movf	SysTemp3,W
	andwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF38
;CharLocY=CharLocY-1
	movlw	1
	subwf	CHARLOCY,F
	movlw	0
	subwfb	CHARLOCY_H,F
;end if
ENDIF38
;For CurrCharCol = 1 to 5
;Legacy method
	clrf	CURRCHARCOL
SysForLoop7
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
;CharRow=0
	clrf	CHARROW
	clrf	CHARROW_H
;For CurrCharRow = 1 to 8
;Legacy method
	clrf	CURRCHARROW
SysForLoop8
	incf	CURRCHARROW,F
;CharColS=0
	clrf	CHARCOLS
;For Col=1 to GLCDfntDefaultsize
;Legacy method
	clrf	COL
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd9
SysForLoop9
	incf	COL,F
;CharRowS=0
	clrf	CHARROWS
;For Row=1 to GLCDfntDefaultsize
;Legacy method
	clrf	ROW
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd10
SysForLoop10
	incf	ROW,F
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0
	goto	ELSE41_1
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, LineColour
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	movwf	SysTemp3
	movf	CHARCOLS,W
	addwf	SysTemp3,W
	movwf	GLCDX
	movf	CHARROW,W
	addwf	CHARLOCY,W
	movwf	SysTemp3
	movf	CHARROWS,W
	addwf	SysTemp3,W
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_SSD1306
;Else
	goto	ENDIF41
ELSE41_1
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, GLCDBackground
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	movwf	SysTemp3
	movf	CHARCOLS,W
	addwf	SysTemp3,W
	movwf	GLCDX
	movf	CHARROW,W
	addwf	CHARLOCY,W
	movwf	SysTemp3
	movf	CHARROWS,W
	addwf	SysTemp3,W
	movwf	GLCDY
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_SSD1306
;End if
ENDIF41
;Put out a white intercharacter pixel/space
;PSet [word]CharLocX + ( GLCDFontWidth * GLCDfntDefaultsize) , [word]CharLocY + CharRow + CharRowS , GLCDBackground
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	call	SYSMULTSUB
	movf	SysBYTETempX,W
	movwf	SysTemp3
	addwf	CHARLOCX,W
	movwf	GLCDX
	movf	CHARROW,W
	addwf	CHARLOCY,W
	movwf	SysTemp3
	movf	CHARROWS,W
	addwf	SysTemp3,W
	movwf	GLCDY
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_SSD1306
;CharRowS +=1
	incf	CHARROWS,F
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W
	subwf	ROW,W
	btfss	STATUS, C
	goto	SysForLoop10
SysForLoopEnd10
;CharColS +=1
	incf	CHARCOLS,F
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W
	subwf	COL,W
	btfss	STATUS, C
	goto	SysForLoop9
SysForLoopEnd9
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
	goto	SysForLoop8
SysForLoopEnd8
;CharCol +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W
	addwf	CHARCOL,F
	movlw	0
	addwfc	CHARCOL_H,F
;1.14 Low Memory GLCD mode
;1.12 Character GLCD mode
;Handles specific draw sequence. This caters for write only of a bit value. No read operation.
;Next
	movlw	5
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop7
SysForLoopEnd7
;****** OLED Font set handler
;1.14 Added transaction
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

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (1291)
GLCDPRINT5
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
	goto	SysForLoopEnd6
SysForLoop6
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
	call	GLCDDRAWCHAR_SSD1306
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1528)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	call	SYSMULTSUB
	movf	SysBYTETempX,W
	movwf	SysTemp3
	addwf	GLCDPRINTLOC,W
	movwf	SysTemp1
	movlw	0
	addwfc	GLCDPRINTLOC_H,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	movwf	GLCDPRINTLOC
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	GLCDPRINTLOC_H
;Next
	movf	GLCDPRINTLEN,W
	subwf	GLCDPRINT_STRING_COUNTER,W
	btfss	STATUS, C
	goto	SysForLoop6
SysForLoopEnd6
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movf	GLCDPRINTLOC,W
	movwf	PRINTLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	PRINTLOCX_H
	return

;********************************************************************************

;Source: glcd.h (1549)
GLCDPRINTSTRINGLN
;dim PrintLocX, PrintLocY as word
;GLCDPrint( PrintLocX , PrintLocY , LCDPrintData )
	movf	SysLCDPRINTDATAHandler,W
	movwf	SysLCDPRINTDATAHandler
	movf	SysLCDPRINTDATAHandler_H,W
	movwf	SysLCDPRINTDATAHandler_H
	call	GLCDPRINT5
;Update the current X and Y position
;PrintLocX = 0
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
;When using Transaction  PrintLocY will get incremented. This needs to be protected
;PrintLocY = ( PrintLocY + ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod GLCD_HEIGHT
	movf	GLCDFNTDEFAULTHEIGHT,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	call	SYSMULTSUB
	movf	SysBYTETempX,W
	movwf	SysTemp3
	addwf	PRINTLOCY,W
	movwf	SysTemp1
	movlw	0
	addwfc	PRINTLOCY_H,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	movlw	64
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempX,W
	movwf	PRINTLOCY
	movf	SysWORDTempX_H,W
	movwf	PRINTLOCY_H
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
	clrf	HI2CCURRENTMODE
;Initialise the I2C module
	return

;********************************************************************************

;Source: hwi2c.h (449)
HI2CMODE
;This method sets the variable `HI2CCurrentMode`, and, if required, sets the SSPCON1.bits
;#ifdef var(SSPCON1) added to separate from newer i2C module which does not have an SSPCON1
;set SSPSTAT.SMP on
	banksel	SSP1STAT
	bsf	SSP1STAT,SMP
;set SSPCON1.CKP on
	bsf	SSP1CON1,CKP
;set SSPCON1.WCOL Off
	bcf	SSP1CON1,WCOL
;Select mode and clock
;If HI2CCurrentMode = Master Then
	movlw	12
	banksel	HI2CCURRENTMODE
	subwf	HI2CCURRENTMODE,W
	btfss	STATUS, Z
	goto	ENDIF46
;set SSPCON1.SSPM3 on
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPM3
;set SSPCON1.SSPM2 off
	bcf	SSP1CON1,SSPM2
;set SSPCON1.SSPM1 off
	bcf	SSP1CON1,SSPM1
;set SSPCON1.SSPM0 off
	bcf	SSP1CON1,SSPM0
;SSPADD = HI2C_BAUD_TEMP and 127
	movlw	19
	movwf	SSP1ADD
;end if
ENDIF46
;if HI2CCurrentMode = Slave then
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,F
	btfss	STATUS, Z
	goto	ENDIF47
;set SSPCON1.SSPM3 off
	banksel	SSP1CON1
	bcf	SSP1CON1,SSPM3
;set SSPCON1.SSPM2 on
	bsf	SSP1CON1,SSPM2
;set SSPCON1.SSPM1 on
	bsf	SSP1CON1,SSPM1
;set SSPCON1.SSPM0 off
	bcf	SSP1CON1,SSPM0
;end if
ENDIF47
;if HI2CCurrentMode = Slave10 then
	movlw	3
	banksel	HI2CCURRENTMODE
	subwf	HI2CCURRENTMODE,W
	btfss	STATUS, Z
	goto	ENDIF48
;set SSPCON1.SSPM3 off
	banksel	SSP1CON1
	bcf	SSP1CON1,SSPM3
;set SSPCON1.SSPM2 on
	bsf	SSP1CON1,SSPM2
;set SSPCON1.SSPM1 on
	bsf	SSP1CON1,SSPM1
;set SSPCON1.SSPM0 on
	bsf	SSP1CON1,SSPM0
;end if
ENDIF48
;Enable I2C
;set SSPCON1.SSPEN on
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPEN
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (625)
HI2CSEND
;This method sets the registers and register bits to send I2C data
RETRYHI2CSEND
;Clear WCOL
;SET SSPCON1.WCOL OFF
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;Load data to send
;SSPBUF = I2CByte
	banksel	I2CBYTE
	movf	I2CBYTE,W
	banksel	SSP1BUF
	movwf	SSP1BUF
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;if ACKSTAT =  1 then
	banksel	SSP1CON2
	btfss	SSP1CON2,ACKSTAT
	goto	ELSE27_1
;HI2CAckPollState = true
	movlw	255
	banksel	HI2CACKPOLLSTATE
	movwf	HI2CACKPOLLSTATE
;else
	goto	ENDIF27
ELSE27_1
;HI2CAckPollState = false
	banksel	HI2CACKPOLLSTATE
	clrf	HI2CACKPOLLSTATE
;end if
ENDIF27
;If SSPCON1.WCOL = On Then
	banksel	SSP1CON1
	btfss	SSP1CON1,WCOL
	goto	ENDIF28
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	goto	RETRYHI2CSEND
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
;End If
ENDIF28
;Release clock (only needed by slave)
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfss	STATUS, C
	goto	ENDIF29
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	banksel	SSP1CON1
	bsf	SSP1CON1,CKP
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
ENDIF29
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (509)
HI2CSTART
;This method sets the registers and register bits to generate the I2C  START signal
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE25_1
;Master_mode operational
;Set SEN On
	banksel	SSP1CON2
	bsf	SSP1CON2,SEN
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;Else
	goto	ENDIF25
ELSE25_1
;Slave mode operational
;Wait Until SSPSTAT.S = On
SysWaitLoop1
	banksel	SSP1STAT
	btfss	SSP1STAT,S
	goto	SysWaitLoop1
;End If
ENDIF25
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (559)
HI2CSTOP
;Master_mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE26_1
;set SSPIE OFF; disable SSP interrupt, tested by Anobium but not implemented.
;wait while R_NOT_W = 1   'wait for completion of activities
SysWaitLoop2
	banksel	SSP1STAT
	btfsc	SSP1STAT,R_NW1
	goto	SysWaitLoop2
;Set SSPCON2.PEN On
	bsf	SSP1CON2,PEN
;Set SSPCON2.PEN On
	bsf	SSP1CON2,PEN
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;Slave mode
;Else
	goto	ENDIF26
ELSE26_1
;Wait Until SSPSTAT.P = On
SysWaitLoop3
	banksel	SSP1STAT
	btfss	SSP1STAT,P
	goto	SysWaitLoop3
;End If
ENDIF26
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (712)
HI2CWAITMSSP
;HI2CWaitMSSPTimeout = 0
	clrf	HI2CWAITMSSPTIMEOUT
HI2CWAITMSSPWAIT
;HI2CWaitMSSPTimeout++
	banksel	HI2CWAITMSSPTIMEOUT
	incf	HI2CWAITMSSPTIMEOUT,F
;if HI2CWaitMSSPTimeout < 255 then
	movlw	255
	subwf	HI2CWAITMSSPTIMEOUT,W
	btfsc	STATUS, C
	goto	ENDIF31
;'Support for SSP1IF
;if SSP1IF = 0 then
	banksel	PIR5
	btfsc	PIR5,SSP1IF
	goto	ENDIF33
;wait 2 us
	movlw	5
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
;goto HI2CWaitMSSPWait
	goto	HI2CWAITMSSPWAIT
;end if
ENDIF33
;Clear the flag and exit sub with HI2CWaitMSSPTimeout NOT set to 255
;SSP1IF = 0
	bcf	PIR5,SSP1IF
;end if
ENDIF31
;Clear the flag
;if HI2CWaitMSSPTimeout = 255 Then BCL1IF = 0
	banksel	HI2CWAITMSSPTIMEOUT
	incf	HI2CWAITMSSPTIMEOUT,W
	btfss	STATUS, Z
	goto	ENDIF32
;if HI2CWaitMSSPTimeout = 255 Then BCL1IF = 0
	banksel	PIR5
	bcf	PIR5,BCL1IF
;if HI2CWaitMSSPTimeout = 255 Then BCL1IF = 0
ENDIF32
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
	call	Delay_MS
;HI2CMode Master
	movlw	12
	movwf	HI2CCURRENTMODE
	call	HI2CMODE
;Wait 15 ms  'wait for power-up and reset
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Setup code for SSD1306 controllers
;Init sequence for 128x64 OLED module
;Write_Command_SSD1306(SSD1306_DISPLAYOFF)                    ' 0xAE
	movlw	174
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DEACTIVATE_SCROLL)
	movlw	46
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYCLOCKDIV)            ' 0xD5
	movlw	213
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x80)                                  ' the suggested ratio 0x80
	movlw	128
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETMULTIPLEX)                  ' 0xA8
	movlw	168
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x3f)                                 '64 pixels
	movlw	63
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYOFFSET)              ' 0xD3
	movlw	211
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x00)                                   ' no offset
	clrf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETSTARTLINE | 0x00)            ' line #0
	movlw	64
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_CHARGEPUMP)                    ' 0x8D
	movlw	141
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;if (SSD1306_vccstate = SSD1306_EXTERNALVCC) then
;Write_Command_SSD1306(0x14)
	movlw	20
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_MEMORYMODE)                    ' 0x20
	movlw	32
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x10)                                  ' 0x01 act like PCD8544
	movlw	16
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SEGREMAP | 0x1)
	movlw	161
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_COMSCANDEC)
	movlw	200
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCOMPINS)                    ' 0xDA
	movlw	218
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x12)                                 '64 pixels
	movlw	18
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCONTRAST)                   ' 0x81
	movlw	129
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xCF)
	movlw	207
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETPRECHARGE)                  ' 0xd9
	movlw	217
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xF1)
	movlw	241
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETVCOMDETECT)                 ' 0xDB
	movlw	219
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x40)
	movlw	64
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYALLON_RESUME)           ' 0xA4
	movlw	164
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_NORMALDISPLAY)                 ' 0xA6
	movlw	166
	movwf	SSD1306SENDBYTE
	call	WRITE_COMMAND_SSD1306
;Clear screen Here
;GLCDCLS_SSD1306
	call	GLCDCLS_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYON)                     '--turn on oled panel
	movlw	175
	movwf	SSD1306SENDBYTE
	goto	WRITE_COMMAND_SSD1306

;********************************************************************************

;Source: 215_i2c_glcd_bmp_ssd1306_128_64.gcb (36)
INITPPS
;Module: MSSP1
;RA1PPS = 0x001B    'SCK1 > RA1
	movlw	27
	banksel	RA1PPS
	movwf	RA1PPS
;SSP1CLKPPS = 0x0001    'RA1 > SCK1 (bi-directional)
	movlw	1
	banksel	SSP1CLKPPS
	movwf	SSP1CLKPPS
;RA4PPS = 0x001C    'SDA1 > RA4
	movlw	28
	banksel	RA4PPS
	movwf	RA4PPS
;SSP1DATPPS = 0x0004    'RA4 > SDA1 (bi-directional)
	movlw	4
	banksel	SSP1DATPPS
	movwf	SSP1DATPPS
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
;OSCFRQ = 0b00000101
	movlw	5
	movwf	OSCFRQ
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELC = 0
	clrf	ANSELC
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2EN
;C1EN = 0
	bcf	CM1CON0,C1EN
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

;Source: GLCD_SSD1306.H (920)
PSET_SSD1306
;Set pixel at X, Y on LCD to State
;X is 0 to 127
;Y is 0 to 63
;Origin in top left
;anything off screen with be rejected
;if GLCDX => GLCD_WIDTH OR GLCDY => GLCD_HEIGHT Then
	movf	GLCDX,W
	movwf	SysBYTETempA
	movlw	128
	movwf	SysBYTETempB
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp3
	movf	GLCDY,W
	movwf	SysBYTETempA
	movlw	64
	movwf	SysBYTETempB
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F
	movf	SysTemp3,W
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
;exit sub
	return
;end if
;1.14 Addresses correct device horizonal page
;don't need to do these calculations for in LOWMEMORY_GLCD_MODE
;SSD1306_BufferLocationCalc = ( GLCDY / 8 )* GLCD_WIDTH
;faster than /8
;SSD1306_BufferLocationCalc = GLCDY
	movf	GLCDY,W
	movwf	SSD1306_BUFFERLOCATIONCALC
	clrf	SSD1306_BUFFERLOCATIONCALC_H
;Repeat 3
	movlw	3
	movwf	SysRepeatTemp1
SysRepeatLoop1
;Set C Off
	bcf	STATUS,C
;Rotate SSD1306_BufferLocationCalc Right
	rrf	SSD1306_BUFFERLOCATIONCALC_H,F
	rrf	SSD1306_BUFFERLOCATIONCALC,F
;End Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;faster than * 128
;Set C Off
	bcf	STATUS,C
;Repeat 7
	movlw	7
	movwf	SysRepeatTemp1
SysRepeatLoop2
;Rotate SSD1306_BufferLocationCalc Left
	rlf	SSD1306_BUFFERLOCATIONCALC,F
	rlf	SSD1306_BUFFERLOCATIONCALC_H,F
;End Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;SSD1306_BufferLocationCalc = GLCDX + SSD1306_BufferLocationCalc + 1
	movf	SSD1306_BUFFERLOCATIONCALC,W
	addwf	GLCDX,W
	movwf	SysTemp1
	clrf	SysTemp3
	movf	SSD1306_BUFFERLOCATIONCALC_H,W
	addwfc	SysTemp3,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	movwf	SSD1306_BUFFERLOCATIONCALC
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	SSD1306_BUFFERLOCATIONCALC_H
;anything beyond buffer boundary?
;why? X = 127 and Y = 64 (Y is over 63!) will have passed first check....
;if SSD1306_BufferLocationCalc > GLCD_HEIGHT * GLCD_WIDTH Then
	movf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	SysWORDTempB
	movf	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	movlw	32
	movwf	SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfsc	SysByteTempX,0
;exit sub
	return
;end if
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
	goto	ELSE19_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE
;Set C On
	bsf	STATUS,C
;Else
	goto	ENDIF19
ELSE19_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE
;Set C Off
	bcf	STATUS,C
;End If
ENDIF19
;Repeat GLCDBitNo
	movf	GLCDBITNO,W
	movwf	SysRepeatTemp1
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd3
SysRepeatLoop3
;Rotate GLCDChange Left
	rlf	GLCDCHANGE,F
;End Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0
	goto	ELSE20_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	movf	GLCDDATATEMP,W
	andwf	GLCDCHANGE,W
	movwf	GLCDDATATEMP
;Else
	goto	ENDIF20
ELSE20_1
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	movf	GLCDDATATEMP,W
	iorwf	GLCDCHANGE,W
	movwf	GLCDDATATEMP
;End If
ENDIF20
;added 1.14 to isolate from full glcd mode
;revised 1.14 to isolate from low memory mode
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
	goto	ENDIF21
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDDataTemp
	movlw	low(SSD1306_BUFFERALIAS)
	addwf	SSD1306_BUFFERLOCATIONCALC,W
	movwf	AFSR0
	movlw	high(SSD1306_BUFFERALIAS)
	addwfc	SSD1306_BUFFERLOCATIONCALC_H,W
	movwf	AFSR0_H
	movf	GLCDDATATEMP,W
	movwf	INDF0
;Cursor_Position_SSD1306 ( GLCDX, GLCDY )
	movf	GLCDX,W
	movwf	LOCX
	movf	GLCDY,W
	movwf	LOCY
	call	CURSOR_POSITION_SSD1306
;Write_Data_SSD1306 ( GLCDDataTemp )
	movf	GLCDDATATEMP,W
	movwf	SSD1306SENDBYTE
	call	WRITE_DATA_SSD1306
;end if
ENDIF21
	return

;********************************************************************************

;Source: system.h (4198)
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

;Source: system.h (4224)
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

;Source: system.h (4588)
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

;Source: system.h (4618)
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

;Source: system.h (3592)
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
	goto	ENDIF9
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF9
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
	goto	ENDIF10
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF10
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

;Source: system.h (3011)
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

;Source: system.h (3058)
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
	goto	ENDIF7
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
ENDIF7
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

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable4
	retlw	17
	retlw	65	;A
	retlw	98	;b
	retlw	111	;o
	retlw	117	;u
	retlw	116	;t
	retlw	32	; 
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	108	;l
	retlw	111	;o
	retlw	97	;a
	retlw	100	;d
	retlw	32	; 
	retlw	66	;B
	retlw	77	;M
	retlw	80	;P


;********************************************************************************

;Source: GLCD_SSD1306.H (256)
WRITE_COMMAND_SSD1306
;HI2CStart
	call	HI2CSTART
;HI2CSend GLCD_I2C_Address
	movlw	120
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CSend 0x00
	clrf	I2CBYTE
	call	HI2CSEND
;HI2CSend SSD1306SendByte
	movf	SSD1306SENDBYTE,W
	movwf	I2CBYTE
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
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CSend 0x40
	movlw	64
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CSend SSD1306SendByte
	movf	SSD1306SENDBYTE,W
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CStop
	goto	HI2CSTOP

;********************************************************************************

;Program_memory_page: 1
	ORG	2048
;Program_memory_page: 2
	ORG	4096
;Program_memory_page: 3
	ORG	6144
;Program_memory_page: 4
	ORG	8192
;Program_memory_page: 5
	ORG	10240
;Program_memory_page: 6
	ORG	12288
;Program_memory_page: 7
	ORG	14336

 END
