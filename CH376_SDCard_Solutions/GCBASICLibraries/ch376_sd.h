'    Version 0.2 (2026-11-09)
'    ch376_sd.h - the SD card methods of sd_card.h and sd_fat.h (SDCInit, FatMount, FatOpen, FatAppendByte ...)
'    on a WCH CH376, for the GCBASIC compiler
'
'    Copyright (C) 2014-2026 Hugh Considine and Evan R. Venn
'    Licence: LGPL 2.1 for everyone, or a commercial licence for products that do not want the LGPL's conditions.
'    Licensor: Evan R. Venn, on behalf of the GCBASIC project.
'    For commercial inquiries and licensing, email: license_management AT anobium.co.uk
'
'    This file is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General
'    Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your
'    option) any later version. It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
'    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
'    General Public License for more details.
'
'    A program written for an SD card with sd_card.h and sd_fat.h runs on a CH376 (a USB flash drive, or an SD card
'    in the CH376's own socket) with this file in their place: the same routine names, parameters, results, error
'    codes and variables. Only the #include lines and the pin #defines change:
'
'        SD card                                   CH376
'        #DEFINE SDC_CS ... / SDC_SPI_...          #define CH376_COMMS_METHOD CH376_COMMS_SPI, CH376_CS, CH376_INT ...
'                                                  (see ch376.h)
'        #include <sd_card.h>                      #define CH376_MEDIA_SDCARD   (only for the SD card socket)
'                                                  #include <ch376_sd.h>
'        #include <sd_fat.h>
'
'    The CH376 keeps the file system itself (FAT12, FAT16, FAT32): this file turns each call into CH376 commands
'    (ch376.h). It needs no 512-byte sector buffer.
'
'    sd_card.h methods
'      SDCInit()                        start the CH376 and the drive: SDC_OK or an SDC_ERR_ code
'                                       (SDC_ERR_NO_CARD: no drive; SDC_ERR_INIT: no CH376 answer, or the drive
'                                       did not start - CH376Error has the CH376's own code)
'      SDCCardType                      SDC_TYPE_NONE, SDC_TYPE_CH376_USB or SDC_TYPE_CH376_SD
'      SDCBlocks                        capacity in 512-byte blocks (Long)
'      SDCReadBlock(block, buffer())    read a block into a 512-byte array (index 0..511)
'      SDCWriteBlock(block, buffer())   write a block from a 512-byte array
'      SDCReadStart(block), SDCReadByte, SDCReadEnd        the same, a byte at a time
'      SDCWriteStart(block), SDCWriteByte(value), SDCWriteEnd
'      Blocks are USB drive sectors: the CH376 has no block commands for its SD card socket (SDC_ERR_CMD there).
'      A block access closes the file in use; the file calls open it again as needed.
'
'    sd_fat.h methods                   (each returns FAT_OK or a FAT_ERR_ code; FatError holds the last error)
'      FatInit()                        start the drive and read its file system (SDCInit, then FatMount):
'                                       the one call before using files, and again after a drive is changed
'      FatMount()                       read the file system; the current folder is the root
'      FatChDir(name)                   change folder: a folder name, ".." or "/" (the root)
'      FatMkDir(name)                   make a folder in the current folder
'      FatRmDir(name)                   remove an empty folder
'      FatDelete(name)                  delete a file
'      FatOpen(name)                    open a file to append to it (created if new)
'      FatCreated()                     after FatOpen: 1 = FatOpen made the file, 0 = it was there already
'      FatAppendByte(b)                 add a byte at the end of the open file (buffered)
'      FatCommit()                      write the data, the size and the date into the drive
'      FatOpenRead(name)                open a file to read it from the start
'      FatReadByte()                    the next byte (function); FatEOF = 1 after the last
'      FatListFirst / FatListNext       list the current folder: 1 for each entry, with FatListName ("NAME.EXT"),
'                                       FatListAttr, FatListSize, and with #define FAT_LIST_STAMP, FatListStamp
'      FatFileSize, FatType (12 / 16 / 32), FatDate / FatTime (written into new and changed files, FAT format;
'      FatMount sets 2026-01-01 00:00, so set them after FatMount)
'
'    Differences from sd_fat.h
'      FAT12 drives work (FatType 12): sd_fat.h refuses them with FAT_ERR_FAT12.
'      The current folder is kept as a path of at most 64 characters (about 7 folders deep).
'      The CH376 has one file open at a time. Here the file stays "open" for FatAppendByte / FatReadByte through
'      other calls (listing, FatMkDir ...), as with sd_fat.h: those calls close it in the CH376 (an appended file
'      with its size written), and the next FatAppendByte / FatReadByte opens it again where it was.
'      As with sd_fat.h, do not call other Fat routines in the middle of a listing.
'
'Changes:
'   08/11/2026: First version.
'   08/11/2026: #option explicit.
'   08/11/2026: FatMkDir dates the new folder FatDate / FatTime, as sd_fat.h (found in simulation: the CH376
'               default was 2004-01-01).
'   09/11/2026: FatChDir finds "." and ".." by their length and characters. If CDName = ".." was always
'               false: comparing a String parameter with a string constant reads the wrong memory
'               (compiler bug, builds 1670-1673), so ".." went to the CH376 and the path became
'               "/CH376/..". Found on the board; the simulation's CH376 model resolved "..".
'   09/11/2026: The library's own helpers are named CH376SD... (were SDC... / Fat..., which read as part of
'               the SD card methods): CH376SDBlockCheck, CH376SDFetchChunk, CH376SDSendChunk, CH376SDMakePath,
'               CH376SDPattern, CH376SDSuspend, CH376SDResume, CH376SDListTake, CH376SDFromCH376.
'   09/11/2026: The drive is chosen with a flag: #define CH376_MEDIA_SDCARD or CH376_MEDIA_USBSTICK; neither
'               is the USB stick. Both is a compile error (was CH376_SD_MEDIA = CH376_MEDIA_USB / _SD).
'   09/11/2026: FatCreated() is a Function (was a variable a program could change). FatOpen sets it; called
'               before a FatOpen that succeeded it returns 0 and sets FatError = FAT_ERR_NOT_OPEN.
'   09/11/2026: The 0 / 1 flags are Bit variables: FatEOF, FatFileLive, and FatOpen's CH376SDFileMade /
'               CH376SDOpenDone (for FatCreated()). FatFileOpen (0 / 1 / 2) stays a Byte.
'   09/11/2026: A Function with no parameters is called with (), eg SDCInit(), FatCommit(), to show it is a Function.
'   09/11/2026: Version 0.2. FatInit(): SDCInit, then FatMount, in one call, as sd_fat.h 1.2.
'               FAT_ERR_NO_DRIVE (13) when the drive does not start.
'   12/11/2026: SDCChunk, FatPath and FatPatternStr share one RAM area at the top of RAM (AT ... SHARED):
'               they are never in use at the same time. At CHIPSHAREDRAM + CHIPRAM - 87, as FatPatternStr
'               (String * 86) is 87 bytes. FatRmDir makes the path again after the listing pattern.

#option explicit

#include <ch376.h>

' ----- Which drive: the program defines one flag before the #include
'   #define CH376_MEDIA_USBSTICK      the USB socket: the default, the same as defining neither
'   #define CH376_MEDIA_SDCARD        the CH376's own SD card socket
' CH376SD_DRIVEMODE is the value for CH376Init: CH376_MODE_USBHOST or CH376_MODE_SDCARD (ch376.h)
#script
  IF DEF(CH376_MEDIA_USBSTICK) THEN
    IF DEF(CH376_MEDIA_SDCARD) THEN
      Error "ch376_sd.h: CH376_MEDIA_USBSTICK and CH376_MEDIA_SDCARD are both defined: define one (neither is the USB stick)"
    END IF
  END IF
  IF DEF(CH376_MEDIA) THEN
    Error "ch376_sd.h: CH376_MEDIA is no longer used: #define CH376_MEDIA_SDCARD or CH376_MEDIA_USBSTICK"
  END IF
  CH376SD_DRIVEMODE = CH376_MODE_USBHOST
  IF DEF(CH376_MEDIA_SDCARD) THEN
    CH376SD_DRIVEMODE = CH376_MODE_SDCARD
  END IF
#endscript

' ----- sd_card.h results (the same values)
#DEFINE SDC_OK             0
#DEFINE SDC_ERR_NO_CARD    1      ' no drive
#DEFINE SDC_ERR_VOLTAGE    2      ' (not used with the CH376)
#DEFINE SDC_ERR_INIT       3      ' no CH376 answer, or the drive did not start (CH376Error says which)
#DEFINE SDC_ERR_OCR        4      ' (not used with the CH376)
#DEFINE SDC_ERR_CSD        5      ' the capacity could not be read
#DEFINE SDC_ERR_CMD        6      ' block read / write refused (also: block access on the CH376's SD socket)
#DEFINE SDC_ERR_TIMEOUT    7      ' no data from the drive
#DEFINE SDC_ERR_WRITE      8      ' the drive did not take the data
#DEFINE SDC_ERR_NOT_READY  9      ' SDCInit has not succeeded

' ----- Card types: sd_card.h's, and the CH376's drives
#DEFINE SDC_TYPE_NONE      0
#DEFINE SDC_TYPE_SD1       1
#DEFINE SDC_TYPE_SD2       2
#DEFINE SDC_TYPE_SDHC      3
#DEFINE SDC_TYPE_CH376_USB 4      ' a USB drive on the CH376
#DEFINE SDC_TYPE_CH376_SD  5      ' an SD card in the CH376's socket

' ----- sd_fat.h results (the same values)
#DEFINE FAT_OK             0
#DEFINE FAT_ERR_READ       1     ' the drive could not be read (or did not answer)
#DEFINE FAT_ERR_WRITE      2     ' the drive could not be written
#DEFINE FAT_ERR_NO_FAT     3     ' no FAT file system, or not 512-byte sectors
#DEFINE FAT_ERR_FAT12      4     ' (not used with the CH376: FAT12 works)
#DEFINE FAT_ERR_DIR_FULL   5     ' the folder is full
#DEFINE FAT_ERR_DISK_FULL  6     ' the drive is full
#DEFINE FAT_ERR_NOT_FOUND  7     ' no such file or folder
#DEFINE FAT_ERR_IS_DIR     8     ' a folder where a file was expected
#DEFINE FAT_ERR_NOT_DIR    9     ' a file where a folder was expected
#DEFINE FAT_ERR_EXISTS     10    ' the name is already in use
#DEFINE FAT_ERR_NOT_EMPTY  11    ' the folder is not empty
#DEFINE FAT_ERR_NOT_OPEN   12    ' no file open (for appending / reading)
#DEFINE FAT_ERR_NO_DRIVE   13    ' FatInit: the drive did not start (SDCError has its code)

' ----- Directory entry attributes (sd_fat.h)
#DEFINE FAT_ATTR_READ_ONLY 0x01
#DEFINE FAT_ATTR_HIDDEN    0x02
#DEFINE FAT_ATTR_SYSTEM    0x04
#DEFINE FAT_ATTR_VOLUME    0x08
#DEFINE FAT_ATTR_DIR       0x10
#DEFINE FAT_ATTR_ARCHIVE   0x20
#DEFINE FAT_ATTR_LFN       0x0F

' ----- Variables: sd_card.h's
Dim SDCCardType, SDCError As Byte
Dim SDCBlocks As Long
Dim SDCCount As Word
' a block moves in 64-byte pieces
' shared with other RAM variables as this is not required to be exclusive
Dim SDCChunk(64) As Byte AT CHIPSHAREDRAM + CHIPRAM - 87 SHARED 
Dim SDCChunkLen, SDCChunkPos As Byte

' ----- Variables: sd_fat.h's
Dim FatError, FatType As Byte
Dim FatEOF As Bit                            ' 1 = the last byte of the file has been read
' FatCreated() is a Function. FatOpen keeps its answer here: CH376SDFileMade = FatOpen made the file;
' CH376SDOpenDone = a FatOpen has succeeded since SDCInit / FatMount / FatOpenRead (so CH376SDFileMade is valid)
Dim CH376SDFileMade, CH376SDOpenDone As Bit
Dim FatDate, FatTime As Word
Dim FatFileSize, FatFilePos As Long
Dim FatListName As String * 12
Dim FatListAttr As Byte
Dim FatListSize As Long
#ifdef FAT_LIST_STAMP
  Dim FatListStamp As Long
#endif
' this file's own
Dim FatDirPath As String * 64                ' the current folder: "" = the root, else eg "/LOGS/2026"
Dim FatFilePath As String * 80               ' the file open for appending / reading
' shared with other RAM variables as this is not required to be exclusive
Dim FatPath As String * 84        AT CHIPSHAREDRAM + CHIPRAM - 87 SHARED            ' work: a full path
' shared with other RAM variables as this is not required to be exclusive
Dim FatPatternStr As String * 86  AT CHIPSHAREDRAM + CHIPRAM - 87 SHARED           ' work: a folder path, a slash and a star, for listing
Dim FatFileOpen As Byte                      ' 0 none, 1 append, 2 read
Dim FatFileLive As Bit                       ' 1 = open in the CH376 now

' =============================================================== sd_card.h methods

'''Start the CH376 and the drive. Returns SDC_OK, or an SDC_ERR_ code; sets SDCCardType and SDCBlocks.
Function SDCInit As Byte
  Dim SDCState As Byte
  SDCCardType = SDC_TYPE_NONE
  SDCBlocks = 0
  FatFileOpen = 0
  CH376SDOpenDone = 0             ' FatCreated() is not valid until the next FatOpen
  FatFileLive = 0

  If CH376Init(CH376SD_DRIVEMODE) <> CH376_OK Then
    SDCError = SDC_ERR_INIT
    SDCInit = SDCError
    Exit Function
  End If

  ' wait for the drive to start, and mount it
  SDCState = CH376DiskReady()
  If SDCState <> CH376_OK Then
    SDCError = SDC_ERR_INIT
    If SDCState = CH376_ERR_DISK_DISCON Then SDCError = SDC_ERR_NO_CARD
    SDCInit = SDCError
    Exit Function
  End If

  ' the capacity in sectors
  If CH376CmdWait(CH376_CMD_DISK_CAPACITY) <> CH376_OK Then
    SDCError = SDC_ERR_CSD
    SDCInit = SDCError
    Exit Function
  End If
  CH376Cmd(CH376_CMD_RD_USB_DATA0)
  SDCState = CH376Rd()                       ' length, always 4
  CH376Read32
  SDCBlocks = CH376Value

  SDCCardType = SDC_TYPE_CH376_USB
  If CH376SD_DRIVEMODE = CH376_MODE_SDCARD Then SDCCardType = SDC_TYPE_CH376_SD
  SDCError = SDC_OK
  SDCInit = SDC_OK
End Function

'''Blocks can be read and written: SDC_OK, or SDC_ERR_NOT_READY / SDC_ERR_CMD
'''@hide
Function CH376SDBlockCheck As Byte
  CH376SDBlockCheck = SDC_OK
  If SDCCardType = SDC_TYPE_NONE Then CH376SDBlockCheck = SDC_ERR_NOT_READY
  If SDCCardType = SDC_TYPE_CH376_SD Then CH376SDBlockCheck = SDC_ERR_CMD
  SDCError = CH376SDBlockCheck
End Function

'''Start reading a block: then call SDCReadByte 512 times, then SDCReadEnd.
Function SDCReadStart(In SDCBlock As Long) As Byte
  SDCReadStart = CH376SDBlockCheck()
  If SDCReadStart <> SDC_OK Then Exit Function
  CH376SDSuspend
  CH376Cmd(CH376_CMD_DISK_READ)
  CH376Wr([Byte]SDCBlock)
  CH376Wr(SDCBlock_H)
  CH376Wr(SDCBlock_U)
  CH376Wr(SDCBlock_E)
  CH376Wr(1)                               ' one sector
  CH376End
  SDCChunkLen = 0
  SDCChunkPos = 0
  CH376SDFetchChunk                            ' the first 64 bytes, or an error now
  SDCReadStart = SDCError
End Function

'''One byte of the block being read
Function SDCReadByte As Byte
  If SDCChunkPos >= SDCChunkLen Then
    CH376Cmd(CH376_CMD_DISK_RD_GO)         ' the next 64 bytes
    CH376End
    CH376SDFetchChunk
    If SDCChunkLen = 0 Then
      SDCReadByte = 0xFF
      Exit Function
    End If
  End If
  SDCReadByte = SDCChunk(SDCChunkPos)
  SDCChunkPos++
End Function

'''Finish a block read
Sub SDCReadEnd
  Dim SDCState As Byte
  CH376Cmd(CH376_CMD_DISK_RD_GO)
  CH376End
  SDCState = CH376WaitInt()                  ' CH376_OK: the sector is done
  If SDCState <> CH376_OK Then
    If SDCError = SDC_OK Then SDCError = SDC_ERR_TIMEOUT
  End If
End Sub

'''Wait for the next piece of a sector and read it into SDCChunk
'''@hide
Sub CH376SDFetchChunk
  Dim SDCState, SDCLeft As Byte
  SDCChunkLen = 0
  SDCChunkPos = 0
  SDCState = CH376WaitInt()
  If SDCState <> CH376_INT_DISK_READ Then
    SDCError = SDC_ERR_CMD
    If SDCState = CH376_ERR_TIMEOUT Then SDCError = SDC_ERR_TIMEOUT
    Exit Sub
  End If
  CH376Cmd(CH376_CMD_RD_USB_DATA0)
  SDCLeft = CH376Rd()                        ' up to 64 bytes
  Do While SDCLeft > 0
    SDCChunk(SDCChunkLen) = CH376Rd()
    SDCChunkLen++
    SDCLeft--
  Loop
  CH376End
  SDCError = SDC_OK
End Sub

'''Start writing a block: then call SDCWriteByte 512 times, then SDCWriteEnd.
Function SDCWriteStart(In SDCBlock As Long) As Byte
  SDCWriteStart = CH376SDBlockCheck()
  If SDCWriteStart <> SDC_OK Then Exit Function
  CH376SDSuspend
  CH376Cmd(CH376_CMD_DISK_WRITE)
  CH376Wr([Byte]SDCBlock)
  CH376Wr(SDCBlock_H)
  CH376Wr(SDCBlock_U)
  CH376Wr(SDCBlock_E)
  CH376Wr(1)                               ' one sector
  CH376End
  SDCChunkPos = 0
  SDCWriteStart = SDC_OK
End Function

'''One byte of the block being written
Sub SDCWriteByte(In SDCValue)
  SDCChunk(SDCChunkPos) = SDCValue
  SDCChunkPos++
  If SDCChunkPos >= 64 Then CH376SDSendChunk
End Sub

'''Finish a block write. Returns SDC_OK, or SDC_ERR_WRITE.
Function SDCWriteEnd As Byte
  Dim SDCState As Byte
  If SDCChunkPos > 0 Then CH376SDSendChunk
  SDCState = CH376WaitInt()                  ' CH376_OK: the sector is written
  If SDCState <> CH376_OK Then SDCError = SDC_ERR_WRITE
  SDCWriteEnd = SDCError
End Function

'''Send the bytes in SDCChunk when the drive asks for them
'''@hide
Sub CH376SDSendChunk
  Dim SDCState, SDCSent As Byte
  SDCState = CH376WaitInt()
  If SDCState <> CH376_INT_DISK_WRITE Then
    SDCError = SDC_ERR_WRITE
    SDCChunkPos = 0
    Exit Sub
  End If
  CH376Cmd(CH376_CMD_WR_HOST_DATA)
  CH376Wr(SDCChunkPos)
  For SDCSent = 0 To SDCChunkPos - 1
    CH376Wr(SDCChunk(SDCSent))
  Next
  CH376End
  CH376Cmd(CH376_CMD_DISK_WR_GO)
  CH376End
  SDCChunkPos = 0
  SDCError = SDC_OK
End Sub

'''Read a whole block into a 512-byte array (index 0..511)
Function SDCReadBlock(In SDCBlock As Long, SDCBuffer()) As Byte
  SDCReadBlock = SDCReadStart(SDCBlock)
  If SDCReadBlock <> SDC_OK Then Exit Function
  For SDCCount = 0 To 511
    SDCBuffer(SDCCount) = SDCReadByte()
  Next
  SDCReadEnd
  SDCReadBlock = SDCError
End Function

'''Write a whole block from a 512-byte array (index 0..511)
Function SDCWriteBlock(In SDCBlock As Long, SDCBuffer()) As Byte
  SDCWriteBlock = SDCWriteStart(SDCBlock)
  If SDCWriteBlock <> SDC_OK Then Exit Function
  For SDCCount = 0 To 511
    SDCWriteByte(SDCBuffer(SDCCount))
  Next
  SDCWriteBlock = SDCWriteEnd()
End Function

' =============================================================== sd_fat.h methods

'''Read the file system; the current folder is the root. FatDate / FatTime are set to 2026-01-01 00:00.
Function FatMount As Byte
  Dim FatState As Byte
  FatError = FAT_OK
  FatDate = 0x5C21                         ' 2026-01-01: (2026 - 1980) * 512 + 1 * 32 + 1
  FatTime = 0
  FatDirPath = ""
  FatFileOpen = 0
  CH376SDOpenDone = 0             ' FatCreated() is not valid until the next FatOpen
  FatFileLive = 0
  FatType = 0
  If SDCCardType = SDC_TYPE_NONE Then
    FatError = FAT_ERR_READ
    FatMount = FatError
    Exit Function
  End If
  ' SDCInit mounted the drive; mount again if it has not got as far as the file system
  If CH376DiskStatus() < CH376_DISK_READY Then
    FatState = CH376DiskMount()
    If FatState <> CH376_OK Then
      FatError = CH376SDFromCH376(FatState)
      FatMount = FatError
      Exit Function
    End If
  End If
  FatState = CH376DiskQuery()
  If FatState <> CH376_OK Then
    FatError = CH376SDFromCH376(FatState)
    FatMount = FatError
    Exit Function
  End If
  Select Case CH376DiskFat
    Case 1: FatType = 12
    Case 2: FatType = 16
    Case 3: FatType = 32
  End Select
  FatMount = FAT_OK
End Function

'''Start the drive and read its file system: SDCInit(), then FatMount(). Returns FAT_OK, or
'''FAT_ERR_NO_DRIVE when the drive did not start (no card, or it did not answer: SDCError has the
'''drive's code), or FatMount's error. The one call a program needs before using files; call it again
'''after a failed write or read, e.g. when a card has been pulled out and put back: SDCInit starts the
'''drive from the beginning. Afterwards SDCCardType, SDCBlocks and FatType describe the drive.
Function FatInit As Byte
  FatError = FAT_OK
  If SDCInit() <> SDC_OK Then
    FatError = FAT_ERR_NO_DRIVE
    FatInit = FatError
    Exit Function
  End If
  FatInit = FatMount()
End Function

'''Change folder: a folder name, ".." or "/" (the root)
Function FatChDir(In CDName As String) As Byte
  Dim CDFirst, CDPos, CDState As Byte
  FatError = FAT_OK
  FatChDir = FAT_OK
  CH376SDSuspend
  CDFirst = CDName(1)
  If CDName(0) = 1 And (CDFirst = 92 Or CDFirst = 47) Then   ' "\" or "/"
    FatDirPath = ""
    Exit Function
  End If
  ' "." and ".." are found by their length and characters: a String parameter compared with a
  ' string constant (If CDName = "..") reads the wrong memory (compiler bug, builds 1670-1673)
  CDPos = 0
  If CDName(0) = 1 And CDFirst = 46 Then Exit Function          ' "."
  If CDName(0) = 2 And CDFirst = 46 Then
    If CDName(2) = 46 Then CDPos = 1                            ' ".."
  End If
  If CDPos = 1 Then
    ' up one folder: cut the path at its last "/"; the root has no ".."
    If FatDirPath(0) = 0 Then
      FatError = FAT_ERR_NOT_FOUND
      FatChDir = FatError
      Exit Function
    End If
    CDPos = FatDirPath(0)
    Do While CDPos > 1
      If FatDirPath(CDPos) = 47 Then Exit Do
      CDPos--
    Loop
    FatDirPath(0) = CDPos - 1
    Exit Function
  End If
  CH376SDMakePath(CDName)
  CDState = CH376FileOpen(FatPath)
  If CDState = CH376_ERR_OPEN_DIR Then
    CDState = CH376FileClose(0)
    FatDirPath = FatPath
    Exit Function
  End If
  If CDState = CH376_OK Then
    CDState = CH376FileClose(0)
    FatError = FAT_ERR_NOT_DIR
  Else
    FatError = CH376SDFromCH376(CDState)
  End If
  FatChDir = FatError
End Function

'''Make a folder in the current folder, dated FatDate / FatTime
Function FatMkDir(In MDName As String) As Byte
  Dim MDState As Byte
  FatError = FAT_OK
  CH376SDSuspend
  CH376SDMakePath(MDName)
  MDState = CH376FileOpen(FatPath)
  If MDState = CH376_OK Or MDState = CH376_ERR_OPEN_DIR Then
    MDState = CH376FileClose(0)
    FatError = FAT_ERR_EXISTS
    FatMkDir = FatError
    Exit Function
  End If
  If MDState <> CH376_ERR_MISS_FILE Then
    FatError = CH376SDFromCH376(MDState)
    FatMkDir = FatError
    Exit Function
  End If
  MDState = CH376MkDir(FatPath)
  If MDState <> CH376_OK Then
    FatError = CH376SDFromCH376(MDState)
  Else
    ' the new folder is open: its created and written date and time, as sd_fat.h gives a new folder (the
    ' CH376 would leave its own default, 2004-01-01). The folder is made even if the date cannot be set.
    MDState = CH376FileStamp(FatDate, FatTime)
  End If
  MDState = CH376FileClose(0)
  FatMkDir = FatError
End Function

'''Remove an empty folder in the current folder
Function FatRmDir(In RDName As String) As Byte
  Dim RDState As Byte
  FatError = FAT_OK
  CH376SDSuspend
  CH376SDMakePath(RDName)
  RDState = CH376FileOpen(FatPath)
  If RDState <> CH376_ERR_OPEN_DIR Then
    If RDState = CH376_OK Then
      RDState = CH376FileClose(0)
      FatError = FAT_ERR_NOT_DIR
    Else
      FatError = CH376SDFromCH376(RDState)
    End If
    FatRmDir = FatError
    Exit Function
  End If
  RDState = CH376FileClose(0)
  ' empty: a listing of it finds nothing but "." and ".."
  CH376SDPattern(FatPath)
  RDState = CH376ListFirst(FatPatternStr)
  If RDState = CH376_OK Then
    RDState = CH376FileClose(0)            ' end the listing
    FatError = FAT_ERR_NOT_EMPTY
    FatRmDir = FatError
    Exit Function
  End If
  ' FatPatternStr shares FatPath's RAM, so the listing pattern replaced the path: make it again
  CH376SDMakePath(RDName)
  RDState = CH376FileErase(FatPath)
  If RDState <> CH376_OK Then FatError = CH376SDFromCH376(RDState)
  FatRmDir = FatError
End Function

'''Delete a file in the current folder (deleting the open file closes it)
Function FatDelete(In DFName As String) As Byte
  Dim DFState As Byte
  FatError = FAT_OK
  CH376SDSuspend
  CH376SDMakePath(DFName)
  DFState = CH376FileOpen(FatPath)
  If DFState <> CH376_OK Then
    If DFState = CH376_ERR_OPEN_DIR Then
      DFState = CH376FileClose(0)
      FatError = FAT_ERR_IS_DIR
    Else
      FatError = CH376SDFromCH376(DFState)
    End If
    FatDelete = FatError
    Exit Function
  End If
  If FatFileOpen <> 0 Then
    If FatFilePath = FatPath Then FatFileOpen = 0
  End If
  DFState = CH376CmdWait(CH376_CMD_FILE_ERASE)   ' the file that is open in the CH376
  If DFState <> CH376_OK Then FatError = CH376SDFromCH376(DFState)
  FatDelete = FatError
End Function

'''Open a file in the current folder to append to it; a new, empty file is created if there is none
'''(then FatCreated() is 1), dated FatDate / FatTime
Function FatOpen(In FOName As String) As Byte
  Dim FOState As Byte
  FatError = FAT_OK
  CH376SDFileMade = 0
  CH376SDOpenDone = 0                      ' not valid unless this FatOpen succeeds
  CH376SDSuspend
  FatFileOpen = 0
  CH376SDMakePath(FOName)
  FOState = CH376FileOpen(FatPath)
  If FOState = CH376_ERR_OPEN_DIR Then
    FOState = CH376FileClose(0)
    FatError = FAT_ERR_IS_DIR
    FatOpen = FatError
    Exit Function
  End If
  If FOState = CH376_ERR_MISS_FILE Then
    FOState = CH376FileCreate(FatPath)
    If FOState = CH376_OK Then
      CH376SDFileMade = 1
      FOState = CH376FileStamp(FatDate, FatTime)
    End If
  End If
  If FOState <> CH376_OK Then
    FatError = CH376SDFromCH376(FOState)
    FatOpen = FatError
    Exit Function
  End If
  FatFileSize = CH376FileSize()
  If CH376SDFileMade = 0 Then
    FOState = CH376Locate(0xFFFFFFFF)      ' the end of the file
    If FOState <> CH376_OK Then
      FatError = CH376SDFromCH376(FOState)
      FatOpen = FatError
      Exit Function
    End If
  End If
  FatFilePos = FatFileSize
  FatFilePath = FatPath
  FatFileOpen = 1
  FatFileLive = 1
  CH376SDOpenDone = 1                      ' FatCreated() is valid
  FatOpen = FAT_OK
End Function

'''After FatOpen: 1 if FatOpen made the file (it was not there), 0 if it opened a file already there.
'''Without a FatOpen that succeeded (since SDCInit, FatMount or FatOpenRead) it returns 0 and sets
'''FatError = FAT_ERR_NOT_OPEN: call FatOpen first.
Function FatCreated As Byte
  FatCreated = 0
  If CH376SDOpenDone = 0 Then
    FatError = FAT_ERR_NOT_OPEN
    Exit Function
  End If
  If CH376SDFileMade = 1 Then FatCreated = 1
End Function

'''Add one byte at the end of the open file (buffered; FatCommit finishes a record)
Sub FatAppendByte(In FABValue)
  If FatError <> FAT_OK Then Exit Sub
  If FatFileOpen <> 1 Then
    FatError = FAT_ERR_NOT_OPEN
    Exit Sub
  End If
  If CH376SDResume() <> FAT_OK Then Exit Sub
  CH376WriteByte(FABValue)
  ' CH376WriteByte writes to the drive each time its buffer is full: check that write
  If CH376BlkLen = 0 Then
    If CH376Error <> CH376_OK Then
      FatError = FAT_ERR_WRITE
      Exit Sub
    End If
  End If
  FatFilePos = FatFilePos + 1
End Sub

'''Write the buffered data, then the file's size and written date / time (FatDate / FatTime) into its
'''folder entry
Function FatCommit As Byte
  Dim FCState As Byte
  If FatFileOpen <> 1 Then
    FatError = FAT_ERR_NOT_OPEN
    FatCommit = FatError
    Exit Function
  End If
  FatCommit = CH376SDResume()
  If FatCommit <> FAT_OK Then Exit Function
  FCState = CH376Flush()
  ' a write of 0 bytes puts the size into the folder entry (WCH EXAM7)
  If FCState = CH376_OK Then FCState = CH376FileWrite(0, SDCChunk)
  ' the written date and time: DIR_WrtTime (0x16), DIR_WrtDate (0x18)
  If FCState = CH376_OK Then FCState = CH376CmdDatWait(CH376_CMD_DIR_INFO_READ, 0xFF)
  If FCState = CH376_OK Then
    CH376Cmd(CH376_CMD_WR_OFS_DATA)
    CH376Wr(0x16)
    CH376Wr(4)
    CH376Wr([Byte]FatTime)
    CH376Wr(FatTime_H)
    CH376Wr([Byte]FatDate)
    CH376Wr(FatDate_H)
    CH376End
    FCState = CH376CmdWait(CH376_CMD_DIR_INFO_SAVE)
  End If
  If FCState <> CH376_OK Then
    FatError = FAT_ERR_WRITE
    FatCommit = FatError
    Exit Function
  End If
  FatFileSize = FatFilePos
  FatCommit = FAT_OK
End Function

'''Open a file in the current folder to read it from the start
Function FatOpenRead(In ORName As String) As Byte
  Dim ORState As Byte
  FatError = FAT_OK
  CH376SDSuspend
  FatFileOpen = 0
  CH376SDOpenDone = 0             ' FatCreated() is not valid until the next FatOpen
  CH376SDMakePath(ORName)
  ORState = CH376FileOpen(FatPath)
  If ORState <> CH376_OK Then
    If ORState = CH376_ERR_OPEN_DIR Then
      ORState = CH376FileClose(0)
      FatError = FAT_ERR_IS_DIR
    Else
      FatError = CH376SDFromCH376(ORState)
    End If
    FatOpenRead = FatError
    Exit Function
  End If
  FatFileSize = CH376FileSize()
  FatFilePos = 0
  FatEOF = 0
  If FatFileSize = 0 Then FatEOF = 1
  FatFilePath = FatPath
  FatFileOpen = 2
  FatFileLive = 1
  FatOpenRead = FAT_OK
End Function

'''The next byte of the file opened with FatOpenRead; FatEOF = 1 once the last byte has been read
'''(0 is returned after that)
Function FatReadByte As Byte
  FatReadByte = 0
  If FatFileOpen <> 2 Or FatFilePos >= FatFileSize Then
    FatEOF = 1
    Exit Function
  End If
  If CH376SDResume() <> FAT_OK Then
    FatEOF = 1
    Exit Function
  End If
  FatReadByte = CH376ReadByte()
  If CH376EOF = 1 Then
    FatEOF = 1
    Exit Function
  End If
  FatFilePos = FatFilePos + 1
  If FatFilePos >= FatFileSize Then FatEOF = 1
End Function

'''Start listing the current folder: 1 and the first entry (FatListName, FatListAttr, FatListSize), or 0 if
'''it is empty
Function FatListFirst As Byte
  FatError = FAT_OK
  CH376SDSuspend
  CH376SDPattern(FatDirPath)
  FatListFirst = CH376SDListTake(CH376OpenDir(FatPatternStr, 255))
End Function

'''The next entry of the listing, or 0 at the end. Long-name and volume-label entries are skipped; "." and
'''".." are listed.
Function FatListNext As Byte
  FatListNext = CH376SDListTake(CH376CmdWait(CH376_CMD_FILE_ENUM_GO))
End Function

' =============================================================== Internal

'''The current folder's path, "/", and the name, into FatPath
'''@hide
Sub CH376SDMakePath(In FMPName As String)
  FatPath = FatDirPath + "/" + FMPName
End Sub

'''A folder path with a slash and a star after it, for listing, into FatPatternStr: the "*" is put in as a character
'''code, because a slash and a star in a string start a block comment for GCBASIC before build 1669
'''@hide
Sub CH376SDPattern(In FPDir As String)
  Dim FPLen As Byte
  FatPatternStr = FPDir + "/"
  FPLen = FatPatternStr(0) + 1
  FatPatternStr(FPLen) = 42                ' "*"
  FatPatternStr(0) = FPLen
End Sub

'''Close the open file in the CH376 (before another command): an appended file with its size written
'''@hide
Sub CH376SDSuspend
  Dim FSState As Byte
  If FatFileLive = 0 Then Exit Sub
  FatFileLive = 0
  If FatFileOpen = 1 Then
    FSState = CH376FileClose(1)            ' writes what CH376WriteByte holds, and the size
  Else
    FSState = CH376FileClose(0)
  End If
End Sub

'''Open the file again in the CH376 when another call closed it, where it was. Returns FAT_OK.
'''@hide
Function CH376SDResume As Byte
  Dim FRState As Byte
  CH376SDResume = FAT_OK
  If FatFileLive = 1 Then Exit Function
  FRState = CH376FileOpen(FatFilePath)
  If FRState = CH376_OK Then
    If FatFileOpen = 1 Then
      FRState = CH376Locate(0xFFFFFFFF)
    Else
      FRState = CH376Locate(FatFilePos)
    End If
  End If
  If FRState <> CH376_OK Then
    FatError = CH376SDFromCH376(FRState)
    CH376SDResume = FatError
    Exit Function
  End If
  FatFileLive = 1
End Function

'''Read listed entries until one that is not a long-name or volume-label entry: 1 with FatListName,
'''FatListAttr, FatListSize (and FatListStamp); 0 at the end
'''@hide
Function CH376SDListTake(In FLTState) As Byte
  Dim FLTPos, FLTChar, FLTLen As Byte
  #ifdef FAT_LIST_STAMP
    Dim FLTStamp As Long
  #endif
  CH376SDListTake = 0
  Do
    If FLTState <> CH376_INT_DISK_READ Then
      If FLTState <> CH376_ERR_MISS_FILE Then FatError = CH376SDFromCH376(FLTState)
      Exit Function
    End If
    ' the 32-byte FAT folder entry
    CH376Cmd(CH376_CMD_RD_USB_DATA0)
    FLTChar = CH376Rd()                      ' length, always 32
    FLTLen = 0
    For FLTPos = 0 To 10                   ' name 8 + 3, space filled
      FLTChar = CH376Rd()
      If FLTPos = 0 And FLTChar = 0x05 Then FLTChar = 0xE5
      If FLTPos = 8 And FLTChar <> 32 Then
        FLTLen++
        FatListName(FLTLen) = 46           ' "."
      End If
      If FLTChar <> 32 Then
        FLTLen++
        FatListName(FLTLen) = FLTChar
      End If
    Next
    FatListName(0) = FLTLen
    FatListAttr = CH376Rd()                  ' 0x0B
    For FLTPos = 0x0C To 0x0D
      FLTChar = CH376Rd()
    Next
    #ifdef FAT_LIST_STAMP
      ' the later of the created (0x0E) and written (0x16) stamps: date * 65536 + time
      [Byte]FatListStamp = CH376Rd()         ' 0x0E created time
      FatListStamp_H = CH376Rd()
      FatListStamp_U = CH376Rd()             ' 0x10 created date
      FatListStamp_E = CH376Rd()
      For FLTPos = 0x12 To 0x15
        FLTChar = CH376Rd()
      Next
      [Byte]FLTStamp = CH376Rd()             ' 0x16 written time
      FLTStamp_H = CH376Rd()
      FLTStamp_U = CH376Rd()                 ' 0x18 written date
      FLTStamp_E = CH376Rd()
      If FLTStamp > FatListStamp Then FatListStamp = FLTStamp
      For FLTPos = 0x1A To 0x1B
        FLTChar = CH376Rd()
      Next
    #endif
    #ifndef FAT_LIST_STAMP
      For FLTPos = 0x0E To 0x1B
        FLTChar = CH376Rd()
      Next
    #endif
    [Byte]FatListSize = CH376Rd()            ' 0x1C
    FatListSize_H = CH376Rd()
    FatListSize_U = CH376Rd()
    FatListSize_E = CH376Rd()
    CH376End
    If FatListAttr <> FAT_ATTR_LFN And (FatListAttr And FAT_ATTR_VOLUME) = 0 Then
      CH376SDListTake = 1
      Exit Function
    End If
    FLTState = CH376CmdWait(CH376_CMD_FILE_ENUM_GO)
  Loop
End Function

'''A CH376 status as a FAT_ERR_ code
'''@hide
Function CH376SDFromCH376(In FFCState) As Byte
  Select Case FFCState
    Case CH376_OK: CH376SDFromCH376 = FAT_OK
    Case CH376_ERR_MISS_FILE: CH376SDFromCH376 = FAT_ERR_NOT_FOUND
    Case CH376_ERR_MISS_DIR: CH376SDFromCH376 = FAT_ERR_NOT_FOUND
    Case CH376_ERR_OPEN_DIR: CH376SDFromCH376 = FAT_ERR_IS_DIR
    Case CH376_ERR_FOUND_NAME: CH376SDFromCH376 = FAT_ERR_NOT_DIR
    Case CH376_ERR_DISK_FULL: CH376SDFromCH376 = FAT_ERR_DISK_FULL
    Case CH376_ERR_FDT_OVER: CH376SDFromCH376 = FAT_ERR_DIR_FULL
    Case CH376_ERR_FILE_CLOSE: CH376SDFromCH376 = FAT_ERR_NOT_OPEN
    Case CH376_ERR_TYPE_ERROR: CH376SDFromCH376 = FAT_ERR_NO_FAT
    Case CH376_ERR_BPB_ERROR: CH376SDFromCH376 = FAT_ERR_NO_FAT
    Case CH376_ERR_LARGE_SECTOR: CH376SDFromCH376 = FAT_ERR_NO_FAT
    Case Else: CH376SDFromCH376 = FAT_ERR_READ
  End Select
End Function
