'    Version 0.2 (2026-11-08)
'    ch376.h - files on a USB flash drive or an SD card through the WCH CH376 (CH376S / CH376T)
'    file manager chip, for the GCBASIC compiler.
'
'    The CH376 holds the FAT12 / FAT16 / FAT32 file system itself: this library sends it commands
'    and moves the data. Ported from WCH's reference code in the CH376EVT package (HAL.H,
'    SPI_HW.C, UART_HW.C, PARA_HW.C, FILE_SYS.C V1.3, CH376INC.H).
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
'    ------------------------------------------------------------------------------------------------
'    LAYERS
'      1  Transport   CH376Cmd / CH376Wr / CH376Rd / CH376End / CH376IntPending: one set per interface,
'                     chosen with one #define. Nothing above this layer knows the interface.
'      2  Chip        CH376Init, CH376GetStatus, CH376WaitInt, CH376ReadVar8/32, CH376WriteVar8/32
'      3  Files       disk, paths, open / create / close / erase, read / write, list, folders
'
'    INTERFACE - define CH376_COMMS_METHOD before the #include (the CH376 picks its interface from its
'    pins at power-up: on the CH376EVT board that is jumpers J1 / J5 / J6, see the README.md of CH376_SDCard_Solutions):
'      #define CH376_COMMS_METHOD CH376_COMMS_SPI        SPI mode 0, through GCBASIC's hardware SPI (hwspi.h)
'      #define CH376_COMMS_METHOD CH376_COMMS_USART      asynchronous serial, through usart.h
'      #define CH376_COMMS_METHOD CH376_COMMS_PARALLEL   8-bit parallel bus (D0..D7, A0, RD#, WR#, CS#)
'
'    SPI settings
'      CH376_CS            chip select output, eg LATB.1 (required)
'      CH376_INT           INT# input, eg PORTB.4. When defined, the library waits on INT#.
'                          Without it, the CH376's SDO signals the interrupt while CS is high
'                          (WCH SET_SDO_INT), read on CH376_SDO_PIN - by default CH376_DI, the PIC's
'                          SDI input that SDO is wired to. Do not use SDO for the interrupt on a bus
'                          shared with other devices: SDO then drives the line while CS is high.
'      CH376_SPI_SPEED     the SPIMode speed: MasterSlow, Master (default) or MasterFast. The
'                          CH376 takes up to 24 MHz; Master is 4 MHz on an 18FxxQ43 at 64 MHz.
'      CH376_SCK, CH376_DO, CH376_DI   optional: the SCK, SDO (to the CH376's SDI) and SDI (from
'                          its SDO) pins. When defined, CH376Init sets their directions.
'      CH376_SPI_SHARED    define it when another device on the bus uses another SPI mode or
'                          speed: each CH376 command then runs SPIMode again first.
'      The SPI goes through hwspi.h (SPIMode, HWSPITransfer), so it works with an MSSP module or
'      the SPI1 module of the newer chips (18FxxQ43 ...). Any PPS mapping is set by the program.

'    UART settings (usart.h does the USART; set its baud rate etc. in the program)
'      CH376_UART_PORT     the usart.h port number (default 1)
'      CH376_UART_HASDATA  that port's "byte received" test from usart.h: USARTHasData (default,
'                          port 1) or USART2HasData
'      CH376_INT           optional: without it the status byte the CH376 sends on TXD is used
'      The CH376 starts at 9600 baud unless its BZ/D4, SCK/D5, SDI/D6 pins choose another rate.
'      CH376SetBaud changes it (see the routine).
'
'    Parallel settings
'      CH376_DATA          the 8-bit port, eg PORTD (read and written; Dir is set as needed)
'      CH376_A0, CH376_RD, CH376_WR, CH376_CS   outputs, eg LATB.5, LATE.0, LATE.1, LATB.1
'      CH376_INT           optional: without it bit 7 of the status port is read
'
'    Other settings
'      CH376_TIMEOUT_LOOPS wait for an interrupt: loops of about 10 us (default 500000, about 5 s+)
'      CH376_STREAM_BLOCK  the CH376ReadByte / CH376WriteByte buffer, 1..64 (default 64)
'
'    API (functions return a CH376 status: CH376_OK (0x14) or a CH376_ERR_ / CH376_INT_ code;
'         CH376Error holds the last one)
'      CH376Init(media)            reset the chip, check it answers, set USB host or SD mode:
'                                  media CH376_MODE_USBHOST (default) or CH376_MODE_SDCARD. Sets CH376Version.
'      CH376DiskReady()            wait for the drive and mount it (as WCH's examples do)
'      CH376DiskConnect()          CH376_OK when a USB drive is attached (USB only)
'      CH376DiskMount()            start the drive and read its file system
'      CH376DiskStatus()           CH376_DISK_ state (function, no status)
'      CH376DiskQuery()            CH376DiskTotal, CH376DiskFree (sectors, Long), CH376DiskFat
'      CH376FileOpen(path)         open a file (CH376_OK) or a folder (CH376_ERR_OPEN_DIR)
'      CH376FileCreate(path)       create a file (an existing one is emptied) and open it
'      CH376FileClose(update)      close; update = 1 writes the new size into the folder entry
'                                  (default 1). Writes what CH376WriteByte still holds first.
'      CH376FileErase(path)        delete a file or an empty folder (path "" = the open one)
'      CH376MkDir(path)            make a folder and open it (an existing one is just opened)
'      CH376FileSize()             the open file's size (Long, function)
'      CH376FilePos()              the read / write position (Long, function)
'      CH376Locate(offset)         move the position; 0xFFFFFFFF = the end (to append)
'      CH376FileRead(count, buf()) read up to count bytes into buf(0..); CH376Count = bytes read
'      CH376FileWrite(count, buf()) write count bytes from buf(0..); CH376Count = bytes written
'      CH376ReadByte()             the next byte (function); CH376EOF = 1 after the last
'      CH376WriteByte(b), CH376WriteString(s), CH376WriteLine(s)   buffered; CH376Flush writes
'      CH376FileStamp(date, time)  set the open file's created and written date / time (FAT format:
'                                  date = (year - 1980) * 512 + month * 32 + day,
'                                  time = hour * 2048 + minute * 32 + second / 2). As WCH's
'                                  EXAM10: on a closed file - CH376FileOpen, CH376FileStamp,
'                                  CH376FileClose(0) - so a size update cannot overwrite it.
'      CH376ListFirst(pattern) / CH376ListNext   list a folder: pattern eg "\\*" or "/LOGS\\*.CSV";
'                                  return CH376_OK per entry, with CH376ListName ("NAME.EXT"),
'                                  CH376ListAttr, CH376ListSize; CH376_ERR_MISS_FILE at the end
'
'    Paths: 8.3 names with "/" between folders, eg "/LOGS/DAY1.CSV"; a leading "/" starts at the
'    root, otherwise the path starts in the folder opened last. "\" works too, but in a GCBASIC
'    string it is an escape (build 1603 on), so it has to be written "\\". "/" is sent to the chip
'    as "\", and lower case as upper case. Long names are not supported (the CH376 does not make
'    them; WCH's long-name code is not ported).
'    Never write a "/" followed by a "*" in a string: GCBASIC takes it as the start of a block
'    comment even inside quotes, and the rest of the program disappears (seen with build 1664).
'    Write the separator before a "*" as "\\": "\\*", "/LOGS\\*.CSV".
'
'    Notes
'      One file is open at a time (a CH376 limit). CH376FileClose after writing, or the size in
'      the folder entry is not updated.
'      CH376ReadByte reads ahead: it moves the chip's position up to CH376_STREAM_BLOCK bytes past
'      the byte returned. Call CH376Locate before writing after streamed reads.
'      Needs a CH376 with firmware V4.3 or later (CH376Version >= 0x43): WCH's work-arounds for
'      older chips are not ported. CH376Init still returns CH376_OK on an older chip: check
'      CH376Version.
'
'Changes:
'   08/11/2026: First version.
'   08/11/2026: SPI through hwspi.h (SPIMode, HWSPITransfer) in place of MSSP registers, so it runs on
'               the SPI1 module of the 18FxxQ43 too; CH376_SPI_SPEED, CH376_SPI_SHARED. UART "byte
'               received" through usart.h's USARTHasData (CH376_UART_HASDATA), not a fixed RC1IF.
'   08/11/2026: #option explicit.
'   09/11/2026: Found on the board (CH376 version 0x43, SPI, 18F27Q43):
'               - CH376Init asks CHECK_EXIST every 10 ms for up to 250 ms after RESET_ALL: the chip
'                 took 40-50 ms (WCH says 35 ms), and one check at 50 ms often found it silent.
'               - CH376_MODE_USBHOST is 0x06 (host mode, SOF sent automatically), was 0x05: with 0x05
'                 DISK_MOUNT never succeeded on a USB stick.
'               - CH376DiskReady asks DISK_CONNECT every 100 ms for up to 2 s, as WCH's examples ask
'                 until the drive is there: after a reset the drive takes time to attach again.
'               - SPI: CH376_INT defined, the library waits on INT#; not defined, on SDO (SET_SDO_INT),
'                 read on CH376_SDO_PIN, which is now CH376_DI unless the program defines it.
'   09/11/2026: The mode values are CH376_MODE_USBHOST and CH376_MODE_SDCARD (were CH376_MEDIA_USB and
'               CH376_MEDIA_SD). With ch376_sd.h the program picks the drive with #define CH376_MEDIA_SDCARD
'               or CH376_MEDIA_USBSTICK (flags).
'   09/11/2026: The interface is #define CH376_COMMS_METHOD CH376_COMMS_SPI, CH376_COMMS_USART or
'               CH376_COMMS_PARALLEL (was a flag: CH376_SPI, CH376_UART, CH376_PARALLEL), so that more methods
'               can be added. A missing or unknown method, or an old flag, stops the build with an Error.
'   09/11/2026: A Function with no parameters is called with (), eg CH376Rd(), to show it is a Function.
'   09/11/2026: USART with CH376_INT: when INT# goes low the status byte the chip sends on TXD is
'               taken. It was still arriving (9600 baud) and was read as the GET_STATUS reply, so every
'               reply after it was one byte late (board: wrong capacity, FAT12, FatCommit timed out).

#option explicit

' ===================================================================== Interface choice
' The program defines CH376_COMMS_METHOD as one of these. There is no default: the CH376's jumpers
' choose its interface, so the program must say which one is wired.
#define CH376_COMMS_SPI          1
#define CH376_COMMS_USART        2
#define CH376_COMMS_PARALLEL     3

#script
  IF NODEF(CH376_COMMS_METHOD) THEN
    Error "ch376.h: define the interface: #define CH376_COMMS_METHOD CH376_COMMS_SPI (or CH376_COMMS_USART, CH376_COMMS_PARALLEL)"
  END IF
  IF DEF(CH376_COMMS_METHOD) THEN
    IF CH376_COMMS_METHOD < CH376_COMMS_SPI THEN
      Error "ch376.h: CH376_COMMS_METHOD must be CH376_COMMS_SPI, CH376_COMMS_USART or CH376_COMMS_PARALLEL"
    END IF
    IF CH376_COMMS_METHOD > CH376_COMMS_PARALLEL THEN
      Error "ch376.h: CH376_COMMS_METHOD must be CH376_COMMS_SPI, CH376_COMMS_USART or CH376_COMMS_PARALLEL"
    END IF
  END IF
  ' the flags used before 09/11/2026
  IF DEF(CH376_SPI) THEN
    Error "ch376.h: CH376_SPI is no longer used: #define CH376_COMMS_METHOD CH376_COMMS_SPI"
  END IF
  IF DEF(CH376_UART) THEN
    Error "ch376.h: CH376_UART is no longer used: #define CH376_COMMS_METHOD CH376_COMMS_USART"
  END IF
  IF DEF(CH376_PARALLEL) THEN
    Error "ch376.h: CH376_PARALLEL is no longer used: #define CH376_COMMS_METHOD CH376_COMMS_PARALLEL"
  END IF
#endscript

' ----- Defaults
#ifndef CH376_SPI_SPEED
  #define CH376_SPI_SPEED Master
#endif
#ifndef CH376_UART_PORT
  #define CH376_UART_PORT 1
#endif
#ifndef CH376_UART_HASDATA
  #define CH376_UART_HASDATA USARTHasData
#endif
#ifndef CH376_TIMEOUT_LOOPS
  #define CH376_TIMEOUT_LOOPS 500000
#endif
#ifndef CH376_STREAM_BLOCK
  #define CH376_STREAM_BLOCK 64
#endif
' SPI without CH376_INT: the interrupt is read on the PIC's SDI input (used only then)
#ifndef CH376_SDO_PIN
  #define CH376_SDO_PIN CH376_DI
#endif

' ===================================================================== Constants (CH376INC.H)
' ----- Commands
#define CH376_CMD_GET_IC_VER     0x01
#define CH376_CMD_SET_BAUDRATE   0x02
#define CH376_CMD_RESET_ALL      0x05
#define CH376_CMD_CHECK_EXIST    0x06
#define CH376_CMD_READ_VAR8      0x0A
#define CH376_CMD_SET_SDO_INT    0x0B
#define CH376_CMD_WRITE_VAR8     0x0B
#define CH376_CMD_READ_VAR32     0x0C
#define CH376_CMD_WRITE_VAR32    0x0D
#define CH376_CMD_SET_USB_MODE   0x15
#define CH376_CMD_GET_STATUS     0x22
#define CH376_CMD_RD_USB_DATA0   0x27
#define CH376_CMD_WR_REQ_DATA    0x2D
#define CH376_CMD_WR_OFS_DATA    0x2E
#define CH376_CMD_SET_FILE_NAME  0x2F
#define CH376_CMD_DISK_CONNECT   0x30
#define CH376_CMD_DISK_MOUNT     0x31
#define CH376_CMD_FILE_OPEN      0x32
#define CH376_CMD_FILE_ENUM_GO   0x33
#define CH376_CMD_FILE_CREATE    0x34
#define CH376_CMD_FILE_ERASE     0x35
#define CH376_CMD_FILE_CLOSE     0x36
#define CH376_CMD_DIR_INFO_READ  0x37
#define CH376_CMD_DIR_INFO_SAVE  0x38
#define CH376_CMD_BYTE_LOCATE    0x39
#define CH376_CMD_BYTE_READ      0x3A
#define CH376_CMD_BYTE_RD_GO     0x3B
#define CH376_CMD_BYTE_WRITE     0x3C
#define CH376_CMD_BYTE_WR_GO     0x3D
#define CH376_CMD_DISK_CAPACITY  0x3E
#define CH376_CMD_DISK_QUERY     0x3F
#define CH376_CMD_DIR_CREATE     0x40
#define CH376_CMD_WR_HOST_DATA   0x2C        ' USB drive sectors (not for an SD card):
#define CH376_CMD_DISK_READ      0x54        '   read sectors, 64 bytes per DISK_READ interrupt
#define CH376_CMD_DISK_RD_GO     0x55
#define CH376_CMD_DISK_WRITE     0x56        '   write sectors, 64 bytes per DISK_WRITE interrupt
#define CH376_CMD_DISK_WR_GO     0x57

' ----- Media (CMD_SET_USB_MODE): 0x06 for a USB stick (host mode, SOF sent automatically), 0x03 for
' an SD card. WCH's SPI reference uses 0x05 (no SOF), but on the board a USB stick never mounted then.
' With ch376_sd.h, the program picks the drive with #define CH376_MEDIA_SDCARD (or CH376_MEDIA_USBSTICK,
' the default): those are the program's flags, these are the values sent to the chip.
#define CH376_MODE_USBHOST       0x06
#define CH376_MODE_SDCARD        0x03

' ----- Chip variables (READ_VAR8 / READ_VAR32)
#define CH376_VAR_DISK_STATUS    0x2B
#define CH376_VAR_START_CLUSTER  0x60
#define CH376_VAR_FILE_SIZE      0x68
#define CH376_VAR_CURRENT_OFFSET 0x6C

' ----- Status and error codes
#define CH376_RET_SUCCESS        0x51        ' reply to commands that answer at once
#define CH376_OK                 0x14        ' USB_INT_SUCCESS
#define CH376_INT_CONNECT        0x15
#define CH376_INT_DISCONNECT     0x16
#define CH376_INT_BUF_OVER       0x17
#define CH376_INT_USB_READY      0x18
#define CH376_INT_DISK_READ      0x1D        ' data waiting to be read
#define CH376_INT_DISK_WRITE     0x1E        ' ready for data
#define CH376_INT_DISK_ERR       0x1F
#define CH376_ERR_OPEN_DIR       0x41        ' a folder was opened (success for a folder)
#define CH376_ERR_MISS_FILE      0x42        ' file not found (end of a listing)
#define CH376_ERR_FOUND_NAME     0x43        ' a file where a folder was expected
#define CH376_ERR_DISK_DISCON    0x82        ' no drive, or it was removed
#define CH376_ERR_LARGE_SECTOR   0x84        ' sectors larger than 512 bytes
#define CH376_ERR_TYPE_ERROR     0x92        ' partition type not FAT12 / FAT16 / FAT32
#define CH376_ERR_BPB_ERROR      0xA1        ' not formatted
#define CH376_ERR_DISK_FULL      0xB1
#define CH376_ERR_FDT_OVER       0xB2        ' folder full
#define CH376_ERR_MISS_DIR       0xB3        ' a folder in the path was not found
#define CH376_ERR_FILE_CLOSE     0xB4        ' no file open
' ----- This library's own codes
#define CH376_ERR_NO_CHIP        0xF0        ' no answer to CHECK_EXIST: wiring, jumpers, baud rate
#define CH376_ERR_MODE           0xF1        ' SET_USB_MODE refused
#define CH376_ERR_UNKNOWN_DEV    0xF2        ' a USB device that is not a drive
#define CH376_ERR_TIMEOUT        0xFA        ' no interrupt in time (WCH ERR_USB_UNKNOWN)

' ----- Disk states (CH376DiskStatus)
#define CH376_DISK_UNKNOWN       0x00
#define CH376_DISK_DISCONN       0x01
#define CH376_DISK_CONNECT       0x02
#define CH376_DISK_MOUNTED       0x03
#define CH376_DISK_READY         0x10
#define CH376_DISK_OPEN_ROOT     0x12
#define CH376_DISK_OPEN_DIR      0x13
#define CH376_DISK_OPEN_FILE     0x14

' ----- File attributes (CH376ListAttr)
#define CH376_ATTR_READ_ONLY     0x01
#define CH376_ATTR_HIDDEN        0x02
#define CH376_ATTR_SYSTEM        0x04
#define CH376_ATTR_VOLUME_ID     0x08
#define CH376_ATTR_DIRECTORY     0x10
#define CH376_ATTR_ARCHIVE       0x20

' ===================================================================== Variables
Dim CH376Error, CH376Version, CH376Media, CH376Byte, CH376Dummy, CH376RxByte As Byte
Dim CH376Value As Long
Dim CH376Count As Word
Dim CH376Wait As Long
Dim CH376DiskTotal, CH376DiskFree As Long
Dim CH376DiskFat As Byte
Dim CH376ListName As String * 12
Dim CH376ListAttr As Byte
Dim CH376ListSize As Long
Dim CH376EOF As Bit
Dim CH376Blk(CH376_STREAM_BLOCK) As Byte    ' stream buffer, 0 .. CH376_STREAM_BLOCK - 1 used
Dim CH376BlkLen, CH376BlkPos, CH376BlkWrite As Byte

' ===================================================================== 1  Transport
' Five routines carry every byte; each holds the code for all three interfaces, and #ifdef keeps
' the one the program chose:
'   CH376Cmd(cmd)    start a command (SPI: CS low, the command byte, 1.5 us for the chip)
'   CH376Wr(byte)    send a data byte
'   CH376Rd          receive a data byte (function)
'   CH376End         end the command (SPI: CS high; nothing for the others)
'   CH376IntPending  1 when the chip has an interrupt waiting (function)
' Why one routine with #ifdefs inside, not one routine per interface in its own #ifdef block:
' when a library has two Subs of the same name in #ifdef blocks that exclude each other, the
' compiler uses the FIRST one even when its #ifdef is false, with no warning (build 1668: the
' UART build got the SPI CH376Cmd). An #ifdef inside a Sub body is handled correctly.
' The pins are set up in CH376Init.

'''Start a command
'''@hide
Sub CH376Cmd(In CH376CmdByte)
  #if CH376_COMMS_METHOD = CH376_COMMS_SPI
    CH376_CS = 1                           ' in case a command was not ended
    #ifdef CH376_SPI_SHARED
      SPIMode CH376_SPI_SPEED, 0           ' mode 0: another device may have changed it
    #endif
    CH376_CS = 0
    HWSPITransfer CH376CmdByte, CH376Dummy
    Wait 2 us                              ' WCH: at least 1.5 us before the first data byte
  #endif
  #if CH376_COMMS_METHOD = CH376_COMMS_USART
    ' the two sync bytes 0x57 0xAB, then the command
    Do                                     ' drop any status byte the chip sent earlier
      If CH376_UART_HASDATA Then
        CH376Dummy = HSerReceiveFrom(CH376_UART_PORT)
      Else
        Exit Do
      End If
    Loop
    HSerSend(0x57, CH376_UART_PORT)
    HSerSend(0xAB, CH376_UART_PORT)
    HSerSend(CH376CmdByte, CH376_UART_PORT)
  #endif
  #if CH376_COMMS_METHOD = CH376_COMMS_PARALLEL
    CH376_A0 = 1                           ' A0 high: command
    CH376ParWrite(CH376CmdByte)
    Wait 2 us                              ' WCH: 1.5 us (or poll the BUSY bit, status bit 4)
  #endif
End Sub

'''Send a data byte
'''@hide
Sub CH376Wr(In CH376Out)
  #if CH376_COMMS_METHOD = CH376_COMMS_SPI
    HWSPITransfer CH376Out, CH376Dummy     ' the byte clocked in is read, so the receive buffer is empty
  #endif
  #if CH376_COMMS_METHOD = CH376_COMMS_USART
    HSerSend(CH376Out, CH376_UART_PORT)
  #endif
  #if CH376_COMMS_METHOD = CH376_COMMS_PARALLEL
    CH376_A0 = 0                           ' A0 low: data
    CH376ParWrite(CH376Out)
  #endif
End Sub

'''Receive a data byte (UART: 0 after about 100 ms with nothing)
'''@hide
Function CH376Rd As Byte
  #if CH376_COMMS_METHOD = CH376_COMMS_SPI
    HWSPITransfer 0xFF, CH376RxByte
    CH376Rd = CH376RxByte
  #endif
  #if CH376_COMMS_METHOD = CH376_COMMS_USART
    Dim CH376RxWait As Word
    CH376RxWait = 0
    Do
      If CH376_UART_HASDATA Then Exit Do
      Wait 10 us
      CH376RxWait++
      If CH376RxWait > 10000 Then
        CH376Rd = 0
        Exit Function
      End If
    Loop
    CH376Rd = HSerReceiveFrom(CH376_UART_PORT)
  #endif
  #if CH376_COMMS_METHOD = CH376_COMMS_PARALLEL
    CH376_A0 = 0                           ' A0 low: data
    CH376Rd = CH376ParRead()
  #endif
End Function

'''End a command (SPI: deselect the chip)
'''@hide
Sub CH376End
  #if CH376_COMMS_METHOD = CH376_COMMS_SPI
    CH376_CS = 1
  #endif
End Sub

'''1 when the chip has an interrupt waiting
'''@hide
Function CH376IntPending As Byte
  CH376IntPending = 0
  #ifdef CH376_INT
    If CH376_INT = 0 Then
      CH376IntPending = 1
      #if CH376_COMMS_METHOD = CH376_COMMS_USART
        ' the chip also sends its status byte on TXD, and at 9600 baud it is still arriving when
        ' INT# goes low: take it now, or it is read as the reply to the GET_STATUS that follows
        CH376Dummy = CH376Rd()
      #endif
    End If
  #endif
  #ifndef CH376_INT
    #if CH376_COMMS_METHOD = CH376_COMMS_SPI
      If CH376_SDO_PIN = 0 Then CH376IntPending = 1    ' SDO doubles as INT# while CS is high
    #endif
    #if CH376_COMMS_METHOD = CH376_COMMS_USART
      ' the chip sends its status byte on an interrupt: take it (GET_STATUS follows, as WCH does)
      If CH376_UART_HASDATA Then
        CH376Dummy = HSerReceiveFrom(CH376_UART_PORT)
        CH376IntPending = 1
      End If
    #endif
    #if CH376_COMMS_METHOD = CH376_COMMS_PARALLEL
      CH376_A0 = 1                         ' the status port: bit 7 low = interrupt
      CH376Dummy = CH376ParRead()
      If CH376Dummy.7 = 0 Then CH376IntPending = 1
    #endif
  #endif
End Function

#if CH376_COMMS_METHOD = CH376_COMMS_USART
'''UART only: change the CH376's baud rate. WCH's divisors:
'''  baud >= 23438: CH376Div1 = 0x03, CH376Div2 = 256 - 6000000 / baud
'''  baud <  23438: CH376Div1 = 0x02, CH376Div2 = 256 - 750000 / baud
'''  eg 115200: 0x03, 204   57600: 0x03, 152   1000000: 0x03, 250   9600: 0x02, 178
'''The chip answers at the NEW rate: switch the PIC's USART to it, then call CH376BaudDone,
'''which returns CH376_RET_SUCCESS (0x51) when the chip is heard at the new rate.
Sub CH376SetBaud(In CH376Div1, In CH376Div2)
  CH376Cmd(CH376_CMD_SET_BAUDRATE)
  CH376Wr(CH376Div1)
  CH376Wr(CH376Div2)
End Sub

Function CH376BaudDone As Byte
  CH376BaudDone = CH376Rd()
End Function
#endif

#if CH376_COMMS_METHOD = CH376_COMMS_PARALLEL
'''One write cycle: A0 is set by the caller. RD / WR are set high first: other devices on the
'''bus may leave them low.
'''@hide
Sub CH376ParWrite(In CH376ParOut)
  CH376_RD = 1
  CH376_WR = 1
  Dir CH376_DATA Out
  CH376_DATA = CH376ParOut
  CH376_CS = 0
  CH376_WR = 0
  NOP                                      ' WR# low at least 30 ns (a NOP is 62.5 ns at 64 MHz)
  CH376_WR = 1
  CH376_CS = 1
  Dir CH376_DATA In
End Sub

'''One read cycle: A0 is set by the caller
'''@hide
Function CH376ParRead As Byte
  CH376_RD = 1
  CH376_WR = 1
  Dir CH376_DATA In
  CH376_CS = 0
  CH376_RD = 0
  NOP                                      ' data valid within 40 ns of RD# low
  CH376ParRead = CH376_DATA
  CH376_RD = 1
  CH376_CS = 1
End Function
#endif

' ===================================================================== 2  Chip
'''Reset the chip, check it answers, and set USB host mode (CH376_MODE_USBHOST) or SD card mode
'''(CH376_MODE_SDCARD). Returns CH376_OK, CH376_ERR_NO_CHIP or CH376_ERR_MODE.
Function CH376Init(Optional In CH376InitMedia = CH376_MODE_USBHOST) As Byte
  Dim CH376ModeReply As Byte
  #if CH376_COMMS_METHOD = CH376_COMMS_SPI
    CH376_CS = 1
    Dir CH376_CS Out
    #ifdef CH376_SCK
      Dir CH376_SCK Out
    #endif
    #ifdef CH376_DO
      Dir CH376_DO Out
    #endif
    #ifdef CH376_DI
      Dir CH376_DI In
    #endif
    SPIMode CH376_SPI_SPEED, 0             ' master, mode 0 (CPOL 0, CPHA 0): the CH376 takes 0 or 3
  #endif
  #if CH376_COMMS_METHOD = CH376_COMMS_PARALLEL
    CH376_CS = 1 : Dir CH376_CS Out
    CH376_RD = 1 : Dir CH376_RD Out
    CH376_WR = 1 : Dir CH376_WR Out
    CH376_A0 = 0 : Dir CH376_A0 Out
    Dir CH376_DATA In
  #endif
  #ifdef CH376_INT
    Dir CH376_INT In
  #endif
  CH376Media = CH376InitMedia
  CH376BlkLen = 0
  CH376BlkPos = 0
  CH376BlkWrite = 0
  CH376EOF = 0

  ' Reset: the chip starts again, as after power-up. WCH says 35 ms; on the board it took 40-50 ms
  ' (it still answers for 10-20 ms, then not at all), so ask until it answers, for up to 250 ms
  CH376Cmd(CH376_CMD_RESET_ALL)
  CH376End
  Wait 30 ms

  ' CHECK_EXIST returns the byte sent, inverted
  Dim CH376ResetTries As Byte
  For CH376ResetTries = 1 To 23
    Wait 10 ms
    CH376Cmd(CH376_CMD_CHECK_EXIST)
    CH376Wr(0x65)
    CH376Byte = CH376Rd()
    CH376End
    If CH376Byte = 0x9A Then Exit For
  Next
  If CH376Byte <> 0x9A Then
    CH376Error = CH376_ERR_NO_CHIP
    CH376Init = CH376Error
    Exit Function
  End If

  CH376Cmd(CH376_CMD_GET_IC_VER)
  CH376Version = CH376Rd()
  CH376End

  CH376Cmd(CH376_CMD_SET_USB_MODE)
  CH376Wr(CH376Media)
  Wait 20 us
  CH376ModeReply = CH376Rd()
  CH376End

  #if CH376_COMMS_METHOD = CH376_COMMS_SPI
    #ifndef CH376_INT
      CH376Cmd(CH376_CMD_SET_SDO_INT)      ' SDO doubles as INT# while CS is high
      CH376Wr(0x16)
      CH376Wr(0x90)
      CH376End
    #endif
  #endif

  If CH376ModeReply <> CH376_RET_SUCCESS Then
    CH376Error = CH376_ERR_MODE
  Else
    CH376Error = CH376_OK
  End If
  CH376Init = CH376Error
End Function

'''The interrupt status; this also clears the interrupt
Function CH376GetStatus As Byte
  CH376Cmd(CH376_CMD_GET_STATUS)
  CH376GetStatus = CH376Rd()
  CH376End
End Function

'''Wait for the chip's interrupt and return its status, or CH376_ERR_TIMEOUT
Function CH376WaitInt As Byte
  CH376Wait = 0
  Do
    If CH376IntPending() = 1 Then
      CH376WaitInt = CH376GetStatus()
      CH376Error = CH376WaitInt
      Exit Function
    End If
    Wait 10 us
    CH376Wait++
  Loop While CH376Wait < CH376_TIMEOUT_LOOPS
  CH376Error = CH376_ERR_TIMEOUT
  CH376WaitInt = CH376_ERR_TIMEOUT
End Function

'''Send a command with no data, wait for its interrupt
'''@hide
Function CH376CmdWait(In CH376CmdByte) As Byte
  CH376Cmd(CH376CmdByte)
  CH376End
  CH376CmdWait = CH376WaitInt()
End Function

'''Send a command with one data byte, wait for its interrupt
'''@hide
Function CH376CmdDatWait(In CH376CmdByte, In CH376DatByte) As Byte
  CH376Cmd(CH376CmdByte)
  CH376Wr(CH376DatByte)
  CH376End
  CH376CmdDatWait = CH376WaitInt()
End Function

Function CH376ReadVar8(In CH376Var) As Byte
  CH376Cmd(CH376_CMD_READ_VAR8)
  CH376Wr(CH376Var)
  CH376ReadVar8 = CH376Rd()
  CH376End
End Function

Sub CH376WriteVar8(In CH376Var, In CH376Val)
  CH376Cmd(CH376_CMD_WRITE_VAR8)
  CH376Wr(CH376Var)
  CH376Wr(CH376Val)
  CH376End
End Sub

Function CH376ReadVar32(In CH376Var) As Long
  CH376Cmd(CH376_CMD_READ_VAR32)
  CH376Wr(CH376Var)
  CH376Read32
  CH376ReadVar32 = CH376Value
End Function

Sub CH376WriteVar32(In CH376Var, In CH376Val As Long)
  CH376Cmd(CH376_CMD_WRITE_VAR32)
  CH376Wr(CH376Var)
  CH376Wr([Byte]CH376Val)
  CH376Wr(CH376Val_H)
  CH376Wr(CH376Val_U)
  CH376Wr(CH376Val_E)
  CH376End
End Sub

'''Four bytes, low first, into CH376Value; ends the command
'''@hide
Sub CH376Read32
  [Byte]CH376Value = CH376Rd()
  CH376Value_H = CH376Rd()
  CH376Value_U = CH376Rd()
  CH376Value_E = CH376Rd()
  CH376End
End Sub

' ===================================================================== 3  Disk
'''CH376_OK when a USB drive is attached (not for SD cards)
Function CH376DiskConnect As Byte
  If CH376IntPending() = 1 Then CH376Byte = CH376GetStatus()    ' clear an old interrupt
  CH376DiskConnect = CH376CmdWait(CH376_CMD_DISK_CONNECT)
End Function

'''Start the drive and read its file system
Function CH376DiskMount As Byte
  CH376DiskMount = CH376CmdWait(CH376_CMD_DISK_MOUNT)
End Function

'''The disk / file state: CH376_DISK_ value
Function CH376DiskStatus As Byte
  CH376DiskStatus = CH376ReadVar8(CH376_VAR_DISK_STATUS)
End Function

'''Wait for the drive and mount it, as WCH's examples do. USB: CH376_ERR_DISK_DISCON when no drive
'''is attached after 2 s (call again to keep waiting). Up to 100 x 50 ms for slow drives.
Function CH376DiskReady As Byte
  Dim CH376Try As Byte
  If CH376Media = CH376_MODE_USBHOST Then
    ' after a reset or a mode change the drive takes time to attach again: ask every 100 ms, for 2 s
    ' (WCH's examples ask until it is there)
    For CH376Try = 1 To 20
      CH376Byte = CH376DiskConnect()
      If CH376Byte = CH376_OK Then Exit For
      Wait 100 ms
    Next
    If CH376Byte <> CH376_OK Then
      CH376Error = CH376_ERR_DISK_DISCON
      CH376DiskReady = CH376Error
      Exit Function
    End If
    Wait 200 ms                            ' some drives need time after they are attached
  End If
  For CH376Try = 1 To 100
    Wait 50 ms
    CH376DiskReady = CH376DiskMount()
    If CH376DiskReady = CH376_OK Then Exit Function
    If CH376DiskReady = CH376_ERR_DISK_DISCON Then Exit Function
    ' some drives never say "ready" but work once connected and mounted
    If CH376Try >= 5 Then
      If CH376DiskStatus() >= CH376_DISK_MOUNTED Then
        CH376Error = CH376_OK
        CH376DiskReady = CH376_OK
        Exit Function
      End If
    End If
  Next
  If CH376DiskStatus() < CH376_DISK_MOUNTED Then
    CH376Error = CH376_ERR_UNKNOWN_DEV
    CH376DiskReady = CH376Error
  End If
End Function

'''Total and free sectors (512 bytes) and the FAT type into CH376DiskTotal, CH376DiskFree,
'''CH376DiskFat (1 = FAT12, 2 = FAT16, 3 = FAT32)
Function CH376DiskQuery As Byte
  CH376DiskTotal = 0
  CH376DiskFree = 0
  CH376DiskQuery = CH376CmdWait(CH376_CMD_DISK_QUERY)
  If CH376DiskQuery <> CH376_OK Then Exit Function
  CH376Cmd(CH376_CMD_RD_USB_DATA0)
  CH376Byte = CH376Rd()                      ' length, always 9
  [Byte]CH376DiskTotal = CH376Rd()
  CH376DiskTotal_H = CH376Rd()
  CH376DiskTotal_U = CH376Rd()
  CH376DiskTotal_E = CH376Rd()
  [Byte]CH376DiskFree = CH376Rd()
  CH376DiskFree_H = CH376Rd()
  CH376DiskFree_U = CH376Rd()
  CH376DiskFree_E = CH376Rd()
  CH376DiskFat = CH376Rd()
  CH376End
End Function

' ===================================================================== 3  Names and paths
'''1 when the character is a path separator, "\" or "/"
'''@hide
Function CH376IsSep(In CH376Char) As Byte
  CH376IsSep = 0
  If CH376Char = 92 Then CH376IsSep = 1
  If CH376Char = 47 Then CH376IsSep = 1
End Function

'''Send one name of a path to the chip: from character CH376From (1 = the first) to the next
'''separator or the end. The first character is always sent: a leading separator means "the
'''root". Lower case is sent as upper case, "/" as "\". (WCH CH376SetFileName)
'''@hide
Sub CH376SetName(In CH376Path As String, In CH376From)
  Dim CH376Pos, CH376Len, CH376Char As Byte
  CH376Len = CH376Path(0)
  CH376Cmd(CH376_CMD_SET_FILE_NAME)
  CH376Pos = CH376From
  Do While CH376Pos <= CH376Len
    CH376Char = CH376Path(CH376Pos)
    If CH376Pos <> CH376From Then
      If CH376IsSep(CH376Char) = 1 Then Exit Do
    End If
    If CH376Char >= 97 Then
      If CH376Char <= 122 Then CH376Char = CH376Char - 32
    End If
    If CH376Char = 47 Then CH376Char = 92  ' "/" goes to the chip as "\"
    CH376Wr(CH376Char)
    CH376Pos++
  Loop
  CH376Wr(0)
  CH376End
End Sub

'''The start (1 = the first character) of the last name in a path; 1 also when the path has no
'''folder part (WCH CH376SeparatePath, 1-based)
'''@hide
Function CH376LastName(In CH376Path As String) As Byte
  Dim CH376Pos As Byte
  CH376LastName = 1
  CH376Pos = CH376Path(0)
  Do While CH376Pos > 1
    If CH376IsSep(CH376Path(CH376Pos)) = 1 Then
      CH376LastName = CH376Pos + 1
      Exit Function
    End If
    CH376Pos--
  Loop
End Function

'''Open each folder of a path in turn, then the last name, or stop when the next name starts at
'''CH376Stop (255 = never stop). Returns CH376_OK (a file), CH376_ERR_OPEN_DIR (a folder),
'''CH376_INT_DISK_READ (a wildcard matched) or an error. (WCH CH376FileOpenDir)
'''@hide
Function CH376OpenDir(In CH376Path As String, In CH376Stop) As Byte
  Dim CH376Seg, CH376Next, CH376Len As Byte
  CH376Len = CH376Path(0)
  CH376Seg = 1
  CH376Next = 2                            ' skip a leading root separator
  CH376StreamReset
  Do
    Do While CH376Next <= CH376Len
      If CH376IsSep(CH376Path(CH376Next)) = 1 Then Exit Do
      CH376Next++
    Loop
    If CH376Next <= CH376Len Then
      CH376Next++                          ' the next name starts after the separator
    Else
      CH376Next = 0                        ' end of the path
    End If
    CH376SetName(CH376Path, CH376Seg)
    CH376OpenDir = CH376CmdWait(CH376_CMD_FILE_OPEN)
    If CH376Next = 0 Then Exit Function
    If CH376Next = CH376Stop Then Exit Function
    ' more names follow: this one must have been a folder
    If CH376OpenDir <> CH376_ERR_OPEN_DIR Then
      If CH376OpenDir = CH376_OK Then CH376OpenDir = CH376_ERR_FOUND_NAME
      If CH376OpenDir = CH376_ERR_MISS_FILE Then CH376OpenDir = CH376_ERR_MISS_DIR
      CH376Error = CH376OpenDir
      Exit Function
    End If
    CH376Seg = CH376Next
  Loop
End Function

'''Open the folder that holds the last name of a path: CH376_OK when there is none to open
'''(a name in the root or the current folder) or it opened; else an error
'''@hide
Function CH376OpenParent(In CH376Path As String, In CH376Name) As Byte
  CH376OpenParent = CH376_OK
  If CH376Name = 1 Then Exit Function
  CH376OpenParent = CH376OpenDir(CH376Path, CH376Name)
  If CH376OpenParent = CH376_ERR_OPEN_DIR Then
    CH376OpenParent = CH376_OK
  Else
    If CH376OpenParent = CH376_OK Then CH376OpenParent = CH376_ERR_FOUND_NAME
    If CH376OpenParent = CH376_ERR_MISS_FILE Then CH376OpenParent = CH376_ERR_MISS_DIR
  End If
  CH376Error = CH376OpenParent
End Function

' ===================================================================== 3  Files
'''Open a file (CH376_OK) or a folder (CH376_ERR_OPEN_DIR)
Function CH376FileOpen(In CH376Path As String) As Byte
  CH376FileOpen = CH376OpenDir(CH376Path, 255)
End Function

'''Create a file and open it; an existing file of that name is emptied
Function CH376FileCreate(In CH376Path As String) As Byte
  Dim CH376Name As Byte
  CH376Name = CH376LastName(CH376Path)
  CH376FileCreate = CH376OpenParent(CH376Path, CH376Name)
  If CH376FileCreate <> CH376_OK Then Exit Function
  CH376StreamReset
  CH376SetName(CH376Path, CH376Name)
  CH376FileCreate = CH376CmdWait(CH376_CMD_FILE_CREATE)
End Function

'''Close the open file or folder. CH376Update = 1 (default) writes the new size into the folder
'''entry; bytes still held by CH376WriteByte are written first.
Function CH376FileClose(Optional In CH376Update = 1) As Byte
  If CH376BlkWrite = 1 Then
    If CH376BlkLen > 0 Then CH376Byte = CH376Flush()
  End If
  CH376StreamReset
  CH376FileClose = CH376CmdDatWait(CH376_CMD_FILE_CLOSE, CH376Update)
End Function

'''Delete a file or an empty folder. An empty path deletes the one that is open.
Function CH376FileErase(In CH376Path As String) As Byte
  Dim CH376Pos As Byte
  CH376StreamReset
  If CH376Path(0) > 0 Then
    ' a separator after the first character: open the path; else just set the name
    CH376Pos = 2
    Do While CH376Pos <= CH376Path(0)
      If CH376IsSep(CH376Path(CH376Pos)) = 1 Then Exit Do
      CH376Pos++
    Loop
    If CH376Pos <= CH376Path(0) Then
      CH376FileErase = CH376OpenDir(CH376Path, 255)
      If CH376FileErase <> CH376_OK Then
        If CH376FileErase <> CH376_ERR_OPEN_DIR Then Exit Function
      End If
    Else
      CH376SetName(CH376Path, 1)
    End If
  End If
  CH376FileErase = CH376CmdWait(CH376_CMD_FILE_ERASE)
End Function

'''Make a folder and open it; an existing folder is just opened. A path with folders makes the
'''last one inside the others (they must exist), and points its ".." entry at its parent, as
'''WCH's CH376DirCreatePath does. A name with no path is made in the root.
Function CH376MkDir(In CH376Path As String) As Byte
  Dim CH376Name, CH376Clus0, CH376Clus1, CH376Clus2, CH376Clus3 As Byte
  CH376StreamReset
  CH376Name = CH376LastName(CH376Path)
  If CH376Name = 1 Then
    CH376SetName(CH376Path, 1)
    CH376MkDir = CH376CmdWait(CH376_CMD_DIR_CREATE)
    Exit Function
  End If

  CH376MkDir = CH376OpenParent(CH376Path, CH376Name)
  If CH376MkDir <> CH376_OK Then Exit Function
  ' the parent's first cluster, for the new folder's ".." entry
  CH376Cmd(CH376_CMD_READ_VAR32)
  CH376Wr(CH376_VAR_START_CLUSTER)
  CH376Clus0 = CH376Rd()
  CH376Clus1 = CH376Rd()
  CH376Clus2 = CH376Rd()
  CH376Clus3 = CH376Rd()
  CH376End

  CH376SetName(CH376Path, CH376Name)
  CH376MkDir = CH376CmdWait(CH376_CMD_DIR_CREATE)
  If CH376MkDir <> CH376_OK Then Exit Function
  ' ".." is the second 32-byte entry: first cluster high word at 0x14, low word at 0x1A
  CH376WriteVar32(CH376_VAR_FILE_SIZE, 64)
  CH376MkDir = CH376Locate(32 + 0x14)
  If CH376MkDir <> CH376_OK Then Exit Function
  CH376MkDir = CH376WriteTwo(CH376Clus2, CH376Clus3)
  If CH376MkDir <> CH376_OK Then Exit Function
  CH376MkDir = CH376Locate(32 + 0x1A)
  If CH376MkDir <> CH376_OK Then Exit Function
  CH376MkDir = CH376WriteTwo(CH376Clus0, CH376Clus1)
  If CH376MkDir <> CH376_OK Then Exit Function
  CH376MkDir = CH376Locate(0)
  CH376WriteVar32(CH376_VAR_FILE_SIZE, 0)
End Function

'''The open file's size in bytes
Function CH376FileSize As Long
  CH376FileSize = CH376ReadVar32(CH376_VAR_FILE_SIZE)
End Function

'''The open file's read / write position
Function CH376FilePos As Long
  CH376FilePos = CH376ReadVar32(CH376_VAR_CURRENT_OFFSET)
End Function

'''Move the read / write position of the open file; 0xFFFFFFFF = the end of the file
Function CH376Locate(In CH376Offset As Long) As Byte
  CH376StreamReset
  CH376Cmd(CH376_CMD_BYTE_LOCATE)
  CH376Wr([Byte]CH376Offset)
  CH376Wr(CH376Offset_H)
  CH376Wr(CH376Offset_U)
  CH376Wr(CH376Offset_E)
  CH376End
  CH376Locate = CH376WaitInt()
End Function

'''Read up to CH376Req bytes into CH376Buf(0..) from the position; CH376Count = bytes read
'''(fewer at the end of the file). Returns CH376_OK.
Function CH376FileRead(In CH376Req As Word, CH376Buf()) As Byte
  Dim CH376Chunk As Byte
  CH376Cmd(CH376_CMD_BYTE_READ)
  CH376Wr([Byte]CH376Req)
  CH376Wr(CH376Req_H)
  CH376End
  CH376Count = 0
  Do
    CH376FileRead = CH376WaitInt()
    If CH376FileRead <> CH376_INT_DISK_READ Then Exit Function
    CH376Cmd(CH376_CMD_RD_USB_DATA0)
    CH376Chunk = CH376Rd()                   ' up to 64 bytes
    Do While CH376Chunk > 0
      CH376Buf(CH376Count) = CH376Rd()
      CH376Count++
      CH376Chunk--
    Loop
    CH376End
    CH376Cmd(CH376_CMD_BYTE_RD_GO)
    CH376End
  Loop
End Function

'''Write CH376Req bytes from CH376Buf(0..) at the position; CH376Count = bytes written.
'''Returns CH376_OK.
Function CH376FileWrite(In CH376Req As Word, CH376Buf()) As Byte
  Dim CH376Chunk As Byte
  CH376Cmd(CH376_CMD_BYTE_WRITE)
  CH376Wr([Byte]CH376Req)
  CH376Wr(CH376Req_H)
  CH376End
  CH376Count = 0
  Do
    CH376FileWrite = CH376WaitInt()
    If CH376FileWrite <> CH376_INT_DISK_WRITE Then Exit Function
    CH376Cmd(CH376_CMD_WR_REQ_DATA)
    CH376Chunk = CH376Rd()                   ' how many bytes the chip takes now
    Do While CH376Chunk > 0
      CH376Wr(CH376Buf(CH376Count))
      CH376Count++
      CH376Chunk--
    Loop
    CH376End
    CH376Cmd(CH376_CMD_BYTE_WR_GO)
    CH376End
  Loop
End Function

'''Two bytes at the position (for CH376MkDir)
'''@hide
Function CH376WriteTwo(In CH376Lo, In CH376Hi) As Byte
  CH376Blk(0) = CH376Lo
  CH376Blk(1) = CH376Hi
  CH376WriteTwo = CH376FileWrite(2, CH376Blk)
End Function

' ===================================================================== 3  Byte streams
'''Forget the stream buffer (any open, create, locate or close does this)
'''@hide
Sub CH376StreamReset
  CH376BlkLen = 0
  CH376BlkPos = 0
  CH376BlkWrite = 0
  CH376EOF = 0
End Sub

'''The next byte of the open file; CH376EOF = 1 (and 0 returned) after the last
Function CH376ReadByte As Byte
  If CH376BlkPos >= CH376BlkLen Then
    CH376BlkWrite = 0
    CH376BlkPos = 0
    CH376Byte = CH376FileRead(CH376_STREAM_BLOCK, CH376Blk)
    CH376BlkLen = CH376Count
    If CH376BlkLen = 0 Then
      CH376EOF = 1
      CH376ReadByte = 0
      Exit Function
    End If
  End If
  CH376ReadByte = CH376Blk(CH376BlkPos)
  CH376BlkPos++
End Function

'''Add a byte at the position (buffered: CH376Flush or CH376FileClose writes it)
Sub CH376WriteByte(In CH376Val)
  If CH376BlkWrite = 0 Then
    CH376BlkWrite = 1
    CH376BlkLen = 0
  End If
  CH376Blk(CH376BlkLen) = CH376Val
  CH376BlkLen++
  If CH376BlkLen >= CH376_STREAM_BLOCK Then CH376Byte = CH376Flush()
End Sub

Sub CH376WriteString(In CH376Text As String)
  Dim CH376Pos As Byte
  For CH376Pos = 1 To CH376Text(0)
    CH376WriteByte(CH376Text(CH376Pos))
  Next
End Sub

'''The text, then CR LF
Sub CH376WriteLine(In CH376Text As String)
  CH376WriteString(CH376Text)
  CH376WriteByte(13)
  CH376WriteByte(10)
End Sub

'''Write the bytes held by CH376WriteByte. Returns CH376_OK.
Function CH376Flush As Byte
  CH376Flush = CH376_OK
  If CH376BlkWrite = 0 Then Exit Function
  If CH376BlkLen > 0 Then CH376Flush = CH376FileWrite(CH376BlkLen, CH376Blk)
  CH376BlkLen = 0
End Function

' ===================================================================== 3  Folder entries
'''Set the open file's created and written date and time (FAT format, see the header)
Function CH376FileStamp(In CH376Date As Word, In CH376Time As Word) As Byte
  If CH376BlkWrite = 1 Then CH376Byte = CH376Flush()
  CH376FileStamp = CH376CmdDatWait(CH376_CMD_DIR_INFO_READ, 0xFF)    ' the open file's entry
  If CH376FileStamp <> CH376_OK Then Exit Function
  CH376Cmd(CH376_CMD_WR_OFS_DATA)
  CH376Wr(0x0E)                            ' DIR_CrtTime, DIR_CrtDate
  CH376Wr(4)
  CH376Wr([Byte]CH376Time)
  CH376Wr(CH376Time_H)
  CH376Wr([Byte]CH376Date)
  CH376Wr(CH376Date_H)
  CH376End
  CH376Cmd(CH376_CMD_WR_OFS_DATA)
  CH376Wr(0x16)                            ' DIR_WrtTime, DIR_WrtDate
  CH376Wr(4)
  CH376Wr([Byte]CH376Time)
  CH376Wr(CH376Time_H)
  CH376Wr([Byte]CH376Date)
  CH376Wr(CH376Date_H)
  CH376End
  CH376FileStamp = CH376CmdWait(CH376_CMD_DIR_INFO_SAVE)
End Function

'''List a folder: CH376Pattern is a path ending in a name with "*", eg "\\*" or "/LOGS\\LOG*".
'''Returns CH376_OK with the first entry in CH376ListName / CH376ListAttr / CH376ListSize, or
'''CH376_ERR_MISS_FILE when nothing matches. "." and ".." are skipped.
Function CH376ListFirst(In CH376Pattern As String) As Byte
  CH376ListFirst = CH376OpenDir(CH376Pattern, 255)
  CH376ListFirst = CH376ListTake(CH376ListFirst)
End Function

'''The next entry: CH376_OK, or CH376_ERR_MISS_FILE at the end of the listing
Function CH376ListNext As Byte
  CH376ListNext = CH376CmdWait(CH376_CMD_FILE_ENUM_GO)
  CH376ListNext = CH376ListTake(CH376ListNext)
End Function

'''Read listed entries until one that is not "." or ".."; return CH376_OK, or the status
'''@hide
Function CH376ListTake(In CH376State) As Byte
  Dim CH376Pos, CH376Char, CH376Len As Byte
  Do
    If CH376State <> CH376_INT_DISK_READ Then
      CH376ListTake = CH376State
      CH376Error = CH376State
      Exit Function
    End If
    ' the 32-byte FAT folder entry
    CH376Cmd(CH376_CMD_RD_USB_DATA0)
    CH376Byte = CH376Rd()                    ' length, always 32
    CH376Len = 0
    For CH376Pos = 0 To 10                 ' DIR_Name: 8 + 3, space filled
      CH376Char = CH376Rd()
      If CH376Pos = 0 Then
        If CH376Char = 0x05 Then CH376Char = 0xE5
      End If
      If CH376Pos = 8 Then
        If CH376Char <> 32 Then
          CH376Len++
          CH376ListName(CH376Len) = 46     ' "."
        End If
      End If
      If CH376Char <> 32 Then
        CH376Len++
        CH376ListName(CH376Len) = CH376Char
      End If
    Next
    CH376ListName(0) = CH376Len
    CH376ListAttr = CH376Rd()                ' 0x0B
    For CH376Pos = 0x0C To 0x1B            ' times, dates, clusters: not kept
      CH376Byte = CH376Rd()
    Next
    [Byte]CH376ListSize = CH376Rd()          ' 0x1C DIR_FileSize
    CH376ListSize_H = CH376Rd()
    CH376ListSize_U = CH376Rd()
    CH376ListSize_E = CH376Rd()
    CH376End
    If CH376ListName(1) <> 46 Then
      CH376ListTake = CH376_OK
      CH376Error = CH376_OK
      Exit Function
    End If
    CH376State = CH376CmdWait(CH376_CMD_FILE_ENUM_GO)
  Loop
End Function
