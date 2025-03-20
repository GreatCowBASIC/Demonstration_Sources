/* Library for the Si4703 FM Radio module via the i2c bus

SI4703 FM Radio Tuner Module
    Description: This header file provides the necessary constants,
            configurations, and functions to interface with
            the SI4703 FM Radio Tuner module using GCBASIC.
    Features:
    - FM band support (76–108 MHz)
    - Digital low-IF receiver
    - Automatic frequency control (AFC)
    - Signal strength measurement
    - RDS/RBDS support
    - Stereo audio output

    The module is connected using 6 wires: +3.3V, GND, SDIO, SCLK, SEN and RST

    Features and Commands:


    Variables:
    "Ch(50)" - array of saved radio stations, each radio station takes up one byte of the array. If the radio station frequency is 87.9 MHz, then we write the value 879
    "ChMax" - number of recorded radio stations, used to stop when trying to go above this value
    "Volume" - volume value (from 1 to 15)
    "ChVal" - number of the saved radio station and the number in the array
    "RDSBufSt" - array of 8 bytes, transmits the name of the radio station from RDS (8 characters)
    "RDSBuf" - 64 byte array to receive song title from RDS
    "READ_CH" - channel number when receiving and sending si4703, to calculate the frequency from this number you need to apply the formula ReadChannel=READ_CH_0+875
    "ReadChannel" - channel frequency in the form 879 for 87,9MHz
    "STEREO" - if the signal is stereo = 1, if mono = 0 (1 bit)
    "RSSI_0" - signal level (75 max)

        Sub programs:
        "InitSi" - Sub programm for initialization Si4307, run once when turned on
        "SetVolume" - Sub program for set volume
        "SetChannel" - Sub program for set saved channel
        "Sub 4703_Seek_Up" - Sub program for Seek chanel Up
        "Sub 4703_Seek_Up" - Sub program for Seek chanel Down
        "RDS" - Sub program for starting the RDS reading
        "Read_Ch_St" - read from memory Si4703 channel number, signal level, stereo-mono, execute before displaying this data

Enabling i2c mode Si4703
    Set si4703_SEN=1
    Set HI2C_DATA=0;   A low SDIO indicates a 2-wire interface
    Set si4703_RST=0;   Put Si4703 into reset
    Wait 1 ms;   Some delays while we allow pins to settle
    Set si4703_RST=1;   Bring Si4703 out of reset with SDIO set to low and SEN pulled high with on-board resistor
    Wait 100 ms;   Allow Si4703 to come out of reset
*/



Dim Simb as Word
Dim Simb1 as Word
Dim count as Word

Dim VolRSSI as Byte // lower RSSI threshold for searching
VolRSSI=40
Dim NewChannel as Byte
Dim ReadChannel as Word
Dim Volume as Byte
// Dim Stroka as String
// Dim Si4307readresult as Word

Dim RDSBuf(64) as Byte 
For VolBuf= 1 to 64
RDSBuf(VolBuf)=0
If VolBuf=64 Then Exit For
Next

Dim RDSBufSt(8) as Byte
For VolBuf= 1 to 8
RDSBufSt(VolBuf)=0
If VolBuf=8 Then Exit For
Next

Dim RDS_Station as String
Dim RDS_Song as String

Dim ChVal as Byte
Dim ChMax as Byte


Dim RSSI_1, RSSI_0, READ_CH_1, READ_CH_0, RDSA_1, RDSA_0, RDSB_1, RDSB_0, RDSC_1, RDSC_0, RDSD_1, RDSD_0 as Byte

#Define RDSR     RSSI_1.7
#Define STC      RSSI_1.6
#Define SF/BL    RSSI_1.5
#Define AFCRL    RSSI_1.4
#Define RDSS     RSSI_1.3
#Define BLERA:1  RSSI_1.2
#Define BLERA:0  RSSI_1.1
#Define STEREO   RSSI_1.0

#Define BLERB:1  READ_CH_1.7
#Define BLERB:0  READ_CH_1.6
#Define BLERC:1  READ_CH_1.5
#Define BLERC:0  READ_CH_1.4
#Define BLERD:1  READ_CH_1.3
#Define BLERD:0  READ_CH_1.2

Sub SetChannel // set channel from memory
    If ChVal > ChMax Then Set ChVal=ChMax
    If ChVal <1 Then Set ChVal=1

    NewChannel= Ch(ChVal)-875 // вычисляем номер канала для Si из частоты

    // TUNE=1 запись канала
    HI2CStart
    HI2CSend 4703_adress
    // 2 PowerConfig bit //     1        2          3    4    5       6        7        8
    HI2CSend b'11001000' // ([DSMUTE] [DMUTE]    [MONO] [0] [RDSM] [SKMODE] [SEEKUP] [SEEK])
    HI2CSend b'00000000' // (  [0]    [DISSABLE]   [0]  [0]  [0]      [0]      [0]   [ENABLE])

    // 3 Channel     bit //    1      2      3      4      5      6      7      8
    HI2CSend b'10000000' // ([TUNE]  [0]    [0]    [0]    [0]    [0]   [CH:9] [CH:8])
    HI2CSend NewChannel  // ([CH:7] [CH:6] [CH:5] [CH:4] [CH:3] [CH:2] [CH:1] [CH:0])
    HI2CStop
    Wait 10 ms

    // TUNE=0 запись 
    HI2CStart
    HI2CSend 4703_adress
    // 2 PowerConfig bit //     1        2          3    4    5       6        7        8
    HI2CSend b'11001000' // ([DSMUTE] [DMUTE]    [MONO] [0] [RDSM] [SKMODE] [SEEKUP] [SEEK])
    HI2CSend b'00000001' // (  [0]    [DISSABLE]   [0]  [0]  [0]      [0]      [0]   [ENABLE])

    // 3 Channel     bit //    1      2      3      4      5      6      7      8
    HI2CSend b'00000000' // ([TUNE]  [0]    [0]    [0]    [0]    [0]   [CH:9] [CH:8])
    HI2CSend NewChannel  // ([CH:7] [CH:6] [CH:5] [CH:4] [CH:3] [CH:2] [CH:1] [CH:0])
    HI2CStop

    Wait 10 ms

    HI2CStart
    HI2CSend 4703_adress OR 1
    HI2CReceive RSSI_1, ACK
    HI2CReceive RSSI_0, ACK
    HI2CReceive READ_CH_1, ACK
    HI2CReceive READ_CH_0, NACK
    HI2CStop

    For VolBuf= 1 to 64 // clean RDS Song
        RDSBuf(VolBuf)=0
        If VolBuf=64 Then Exit For
    Next

    For VolBuf= 1 to 8 // clean RDS Station
    RDSBufSt(VolBuf)=0
    If VolBuf=8 Then Exit For
    Next
End Sub



Sub SetVolume
    if Volume < 1 then set Volume = 1
    if Volume > 15 then set Volume = 15

    Vol=16+Volume // "16" (00 01) set 7,6,5 и 4 bits on Channel Spacing = 100 KHz (Europe, Japan)
    HI2CStart
    HI2CSend 4703_adress

    // 2 PowerConfig bit //     1        2          3    4    5       6        7        8
    HI2CSend b'11001000' // ([DSMUTE] [DMUTE]    [MONO] [0] [RDSM] [SKMODE] [SEEKUP] [SEEK])
    HI2CSend b'00000001' // (  [0]    [DISSABLE]   [0]  [0]  [0]      [0]      [0]   [ENABLE])

    // 3 Channel     bit //    1      2      3      4      5      6      7      8
    HI2CSend b'00000000' // ([TUNE]  [0]    [0]    [0]    [0]    [0]   [CH:9] [CH:8])
    HI2CSend NewChannel  // ([CH:7] [CH:6] [CH:5] [CH:4] [CH:3] [CH:2] [CH:1] [CH:0])

    // 4 SysConf1   bit  //     1             2         3          4        5           6          7           8
    HI2CSend b'00010100' // ([RDSIEN]     [STCIEN]     [0]       [RDS]     [DE]       [AGCD]      [0]         [0])
    //HI2CSend b'10010100' // ([RDSIEN]     [STCIEN]     [0]       [RDS]     [DE]       [AGCD]      [0]         [0])
    HI2CSend b'00000000' // ([BLNDADJ:1] [BLNDADJ:0] [GPIO3:1] [GPIO3:0] [DGPIO2:1] [DGPIO2:0] [DGPIO1:1] [DGPIO1:0])

    //5 SysConf2_Vol bit //     1             2         3          4        5           6          7           8
    HI2CSend VolRSSI // ([SEEKTH:7] [SEEKTH:6] [SEEKTH:5] [SEEKTH:4] [SEEKTH:3] [SEEKTH:2] [SEEKTH:1] [SEEKTH:0])
    HI2CSend Vol         // (  [BAND:1]  [BAND:0]  [SPACE:1]  [SPACE:0]  [VOLUME:3] [VOLUME:2] [VOLUME:1] [VOLUME:0])
    HI2CStop

End Sub

Sub InitSi
    NewChannel= Ch(ChVal)-875

    HI2CStart
    HI2CSend 4703_adress

    // 2 PowerConfig bit //     1        2          3    4    5       6        7        8
    HI2CSend b'11001000' // ([DSMUTE] [DMUTE]    [MONO] [0] [RDSM] [SKMODE] [SEEKUP] [SEEK])
    HI2CSend b'00000000' // (  [0]    [DISSABLE]   [0]  [0]  [0]      [0]      [0]   [ENABLE])

    // 3 Channel     bit //    1      2      3      4      5      6      7      8
    HI2CSend b'00000000' // ([TUNE]  [0]    [0]    [0]    [0]    [0]   [CH:9] [CH:8])
    HI2CSend NewChannel  // ([CH:7] [CH:6] [CH:5] [CH:4] [CH:3] [CH:2] [CH:1] [CH:0])

    // 4 SysConf1   bit  //     1             2         3          4        5           6          7           8
    HI2CSend b'00010100' // ([RDSIEN]     [STCIEN]     [0]       [RDS]     [DE]       [AGCD]      [0]         [0])
    //HI2CSend b'10010100' // ([RDSIEN]     [STCIEN]     [0]       [RDS]     [DE]       [AGCD]      [0]         [0])
    HI2CSend b'00000000' // ([BLNDADJ:1] [BLNDADJ:0] [GPIO3:1] [GPIO3:0] [DGPIO2:1] [DGPIO2:0] [DGPIO1:1] [DGPIO1:0])

    //5 SysConf2_Vol bit //     1             2         3          4        5           6          7           8
    HI2CSend b'00000000' // ([SEEKTH:7] [SEEKTH:6] [SEEKTH:5] [SEEKTH:4] [SEEKTH:3] [SEEKTH:2] [SEEKTH:1] [SEEKTH:0])
    HI2CSend b'00010000' // (  [BAND:1]  [BAND:0]  [SPACE:1]  [SPACE:0]  [VOLUME:3] [VOLUME:2] [VOLUME:1] [VOLUME:0])

    // 6 SysConf3    bit //     1             2         3          4         5        6         7          8
    HI2CSend b'00000000' // ([SMUTER:1] [SMUTER:0] [SMUTEA:1] [SMUTEA:0]    [0]      [0]     [RDSPRF]   [VOLEXT])
    HI2CSend b'00000000' // ([SKSNR:3]  [SKSNR:2]  [SKSNR:1]  [SKSNR:0]  [SKCNT:3] [SKCNT:2] [SKCNT:1] [SKCNT:0])
    // 7 Test 1      bit //     1         2         3 4 5 6 7 8
    HI2CSend b'10000001' // ([XOSCEN] [AHIZEN]     [  Reserved  ]) (инициализация, не менять!!!)
    HI2CSend b'00000000' // ([              Reserved            ])

    HI2CStop
    Wait 300 ms

    // PowerUp
    HI2CStart
    HI2CSend 4703_adress
    // 2 PowerConfig bit //     1        2          3    4    5       6        7        8
    HI2CSend b'11001000' // ([DSMUTE] [DMUTE]    [MONO] [0] [RDSM] [SKMODE] [SEEKUP] [SEEK])
    HI2CSend b'00000001' // (  [0]    [DISSABLE]   [0]  [0]  [0]      [0]      [0]   [ENABLE])
    HI2CStop
End Sub

Sub RDS
    For count = 0 to 10000
        If StUp<1 or StDn<1 or SeekUp<1 or SeekDn<1 or VolUp<1 or VolDn<1 Then Call Button
        HI2CStart
        HI2CSend 4703_adress OR 1
        HI2CReceive RSSI_1, ACK
        HI2CReceive RSSI_0, ACK
        HI2CReceive READ_CH_1, ACK
        HI2CReceive READ_CH_0, NACK

        If RDSR=1 Then
            HI2CStart
            HI2CSend 4703_adress OR 1
            HI2CReceive RSSI_1, ACK
            HI2CReceive RSSI_0, ACK
            HI2CReceive READ_CH_1, ACK
            HI2CReceive READ_CH_0, ACK
            HI2CReceive RDSA_1, ACK
            HI2CReceive RDSA_0, ACK
            HI2CReceive RDSB_1, ACK
            HI2CReceive RDSB_0, ACK
            HI2CReceive RDSC_1, ACK
            HI2CReceive RDSC_0, ACK
            HI2CReceive RDSD_1, ACK
            HI2CReceive RDSD_0, NACK
            If BLERB:1=1 and BLERB:0=0 and BLERC:1=1 and BLERC:0=0 and BLERD:1=1 and BLERD:0=0 Then Exit If // RDS Error filter
            //Wait 40 ms
            //Call PrintRDS_Ser
            Call WriteBufRDS
        End If
        HI2CStop
        If count=10000 Then Exit For
    Next
    count=0
End Sub

Sub WriteBufRDS

    If RDSB_1.7=0 and RDSB_1.6=0 and RDSB_1.5=0 and RDSB_1.4=0 Then goto Station
    If RDSB_1.7=0 and RDSB_1.6=0 and RDSB_1.5=1 and RDSB_1.4=0 Then goto Song

    // Stantion buffer
    Station:
    If RDSB_0 = 72 Then 
        RDSBufSt(1)=(RDSD_1)
        RDSBufSt(2)=(RDSD_0)
    End If
    If RDSB_0 = 73 or RDSB_0 = 77 Then 
        RDSBufSt(3)=(RDSD_1)
        RDSBufSt(4)=(RDSD_0)
    End If
    If RDSB_0 = 74 or RDSB_0 = 78 Then 
        RDSBufSt(5)=(RDSD_1)
        RDSBufSt(6)=(RDSD_0)
    End If
    If RDSB_0 = 75 Then 
        RDSBufSt(7)=(RDSD_1)
        RDSBufSt(8)=(RDSD_0)
    End If
    If RDSB_0 = 79 Then 
        RDSBufSt(7)=(RDSD_1)
        RDSBufSt(8)=(RDSD_0)
    End If

    // Song buffer
    Song:
    If RDSB_0 = 80 Then 
        RDSBuf(1)=(RDSC_1)
        RDSBuf(2)=(RDSC_0)
        RDSBuf(3)=(RDSD_1)
        RDSBuf(4)=(RDSD_0)
    End If
    If RDSB_0 = 81 Then 
        RDSBuf(5)=(RDSC_1)
        RDSBuf(6)=(RDSC_0)
        RDSBuf(7)=(RDSD_1)
        RDSBuf(8)=(RDSD_0)
    End If
    If RDSB_0 = 82 Then 
        RDSBuf(9)=(RDSC_1)
        RDSBuf(10)=(RDSC_0)
        RDSBuf(11)=(RDSD_1)
        RDSBuf(12)=(RDSD_0)
    End If
    If RDSB_0 = 83 Then 
        RDSBuf(13)=(RDSC_1)
        RDSBuf(14)=(RDSC_0)
        RDSBuf(15)=(RDSD_1)
        RDSBuf(16)=(RDSD_0)
    End If
    If RDSB_0 = 84 Then 
        RDSBuf(17)=(RDSC_1)
        RDSBuf(18)=(RDSC_0)
        RDSBuf(19)=(RDSD_1)
        RDSBuf(20)=(RDSD_0)
    End If
    If RDSB_0 = 85 Then 
        RDSBuf(21)=(RDSC_1)
        RDSBuf(22)=(RDSC_0)
        RDSBuf(23)=(RDSD_1)
        RDSBuf(24)=(RDSD_0)
    End If
    If RDSB_0 = 86 Then 
        RDSBuf(25)=(RDSC_1)
        RDSBuf(26)=(RDSC_0)
        RDSBuf(27)=(RDSD_1)
        RDSBuf(28)=(RDSD_0)
    End If
    If RDSB_0 = 87 Then 
        RDSBuf(29)=(RDSC_1)
        RDSBuf(30)=(RDSC_0)
        RDSBuf(31)=(RDSD_1)
        RDSBuf(32)=(RDSD_0)
    End If
    If RDSB_0 = 88 Then 
        RDSBuf(33)=(RDSC_1)
        RDSBuf(34)=(RDSC_0)
        RDSBuf(35)=(RDSD_1)
        RDSBuf(36)=(RDSD_0)
    End If
    If RDSB_0 = 89 Then 
        RDSBuf(37)=(RDSC_1)
        RDSBuf(38)=(RDSC_0)
        RDSBuf(39)=(RDSD_1)
        RDSBuf(40)=(RDSD_0)
    End If
    If RDSB_0 = 90 Then 
        RDSBuf(41)=(RDSC_1)
        RDSBuf(42)=(RDSC_0)
        RDSBuf(43)=(RDSD_1)
        RDSBuf(44)=(RDSD_0)
    End If
    If RDSB_0 = 91 Then 
        RDSBuf(45)=(RDSC_1)
        RDSBuf(46)=(RDSC_0)
        RDSBuf(47)=(RDSD_1)
        RDSBuf(48)=(RDSD_0)
    End If
    If RDSB_0 = 92 Then 
        RDSBuf(49)=(RDSC_1)
        RDSBuf(50)=(RDSC_0)
        RDSBuf(51)=(RDSD_1)
        RDSBuf(52)=(RDSD_0)
    End If
    If RDSB_0 = 93 Then 
        RDSBuf(53)=(RDSC_1)
        RDSBuf(54)=(RDSC_0)
        RDSBuf(55)=(RDSD_1)
        RDSBuf(56)=(RDSD_0)
    End If
    If RDSB_0 = 94 Then 
        RDSBuf(57)=(RDSC_1)
        RDSBuf(58)=(RDSC_0)
        RDSBuf(59)=(RDSD_1)
        RDSBuf(60)=(RDSD_0)
    End If
    If RDSB_0 = 95 Then 
        RDSBuf(61)=(RDSC_1)
        RDSBuf(62)=(RDSC_0)
        RDSBuf(63)=(RDSD_1)
        RDSBuf(64)=(RDSD_0)
        Wait 100 ms
    End If

End Sub

Sub 4703_Seek_Up
    HI2CStart
    HI2CSend 4703_adress
    // 2 PowerConfig bit //     1        2          3    4    5       6        7        8
    HI2CSend b'11001011' // ([DSMUTE] [DMUTE]    [MONO] [0] [RDSM] [SKMODE] [SEEKUP] [SEEK])
    HI2CSend b'00000001' // (  [0]    [DISSABLE]   [0]  [0]  [0]      [0]      [0]   [ENABLE])
    HI2CStop

    Do
        HI2CStart
        HI2CSend 4703_adress OR 1
        HI2CReceive RSSI_1, ACK
        HI2CReceive RSSI_0, ACK
        HI2CReceive READ_CH_1, ACK
        HI2CReceive READ_CH_0, NACK
        HI2CStop
    Loop Until STC = 1

    HI2CStart
    HI2CSend 4703_adress
    // 2 PowerConfig bit //     1        2          3    4    5       6        7        8
    HI2CSend b'11001000' // ([DSMUTE] [DMUTE]    [MONO] [0] [RDSM] [SKMODE] [SEEKUP] [SEEK])
    HI2CSend b'00000001' // (  [0]    [DISSABLE]   [0]  [0]  [0]      [0]      [0]   [ENABLE])
    HI2CStop

    // Call Read_Ch_St
    HI2CStart
    HI2CSend 4703_adress OR 1
    HI2CReceive RSSI_1, ACK
    HI2CReceive RSSI_0, ACK
    HI2CReceive READ_CH_1, ACK
    HI2CReceive READ_CH_0, NACK
    HI2CStop


    For VolBuf= 1 to 64
        RDSBuf(VolBuf)=0
        If VolBuf=64 Then Exit For
    Next

    For VolBuf= 1 to 8
        RDSBufSt(VolBuf)=0
        If VolBuf=8 Then Exit For
    Next

End Sub

Sub 4703_Seek_Down
    HI2CStart
    HI2CSend 4703_adress
    // 2 PowerConfig bit //     1        2          3    4    5       6        7        8
    HI2CSend b'11001001' // ([DSMUTE] [DMUTE]    [MONO] [0] [RDSM] [SKMODE] [SEEKUP] [SEEK])
    HI2CSend b'00000001' // (  [0]    [DISSABLE]   [0]  [0]  [0]      [0]      [0]   [ENABLE])
    HI2CStop

    Do
        HI2CStart
        HI2CSend 4703_adress OR 1
        HI2CReceive RSSI_1, ACK
        HI2CReceive RSSI_0, ACK
        HI2CReceive READ_CH_1, ACK
        HI2CReceive READ_CH_0, NACK
        HI2CStop
    Loop Until STC = 1

    HI2CStart
    HI2CSend 4703_adress
    // 2 PowerConfig bit //     1        2          3    4    5       6        7        8
    HI2CSend b'11001000' // ([DSMUTE] [DMUTE]    [MONO] [0] [RDSM] [SKMODE] [SEEKUP] [SEEK])
    HI2CSend b'00000001' // (  [0]    [DISSABLE]   [0]  [0]  [0]      [0]      [0]   [ENABLE])
    HI2CStop

    //Call Read_Ch_St
    HI2CStart
    HI2CSend 4703_adress OR 1
    HI2CReceive RSSI_1, ACK
    HI2CReceive RSSI_0, ACK
    HI2CReceive READ_CH_1, ACK
    HI2CReceive READ_CH_0, NACK
    HI2CStop

    For VolBuf= 1 to 64
        RDSBuf(VolBuf)=0
        If VolBuf=64 Then Exit For
        Next

        For VolBuf= 1 to 8
        RDSBufSt(VolBuf)=0
        If VolBuf=8 Then Exit For
    Next
End Sub

Sub Read_Ch_St
    HI2CStart
    HI2CSend 4703_adress OR 1
    HI2CReceive RSSI_1, ACK
    HI2CReceive RSSI_0, ACK
    HI2CReceive READ_CH_1, ACK
    HI2CReceive READ_CH_0, NACK
    HI2CStop
End Sub