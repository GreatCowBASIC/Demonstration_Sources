//--------------------------------------------------------------------------------------------------------------------------------
// WIZnet W5200 / W5500 driver - SPI access, start-up, link, sockets and their buffers
//
// The W5200 and W5500 do ARP, IPv4, ICMP (ping), UDP and TCP (with retransmission) in the chip, with 8 sockets. The PIC
// opens sockets and moves data between EthFrame and a socket's buffers. One driver for both chips:
//   WIZ_CHIP 5200 or 5500   only that chip's code is compiled; WIZ_Init checks its version
//   no WIZ_CHIP             both are compiled; WIZ_Init finds which chip is fitted (WIZ_Model 5200 or 5500)
// The common routines (registers, sockets, buffers) do not know the chip: they reach it through WIZ_Start, WIZ_Burst
// and WIZ_LinkIsUp, which call the chip's own routines (WIZ5200_..., WIZ5500_...). A chip's routines that are never
// called are not compiled, so a build for one chip has no code and no test for the other.
//
// How the two chips differ (everything else is the same):
//   SPI frame         W5200: address (2), write bit + 15-bit length (2), data
//                     W5500: address (2), control byte (block, write bit, variable length), data
//   Socket registers  W5200: 0x4000 + n x 0x100        W5500: block n x 4 + 1
//   TX / RX buffers   W5200: 0x8000 / 0xC000 + n x 2 KB, the pointer masked to the 2 KB (a burst must not pass the end)
//                     W5500: blocks n x 4 + 2 / n x 4 + 3, the pointer used as it is (the chip wraps)
//   Version           W5200: VERSIONR 0x001F = 0x03    W5500: VERSIONR 0x0039 = 0x04
//   Link              W5200: PSTATUS 0x0035 bit 5      W5500: PHYCFGR 0x002E bit 0
// Each socket keeps the chips' default buffers: 2 KB TX and 2 KB RX.
//
// Routines (WizSock 0-7; "block" 0 common registers, 1 socket registers, 2 TX buffer, 3 RX buffer):
//   Function WIZ_Init As Byte                       reset, find or check the chip, MAC, IP, mask, gateway; 1 = ok
//   WIZ_Model                                       the chip in use: 5200 or 5500 (0 = none found)
//   Function WIZ_LinkIsUp As Byte                   1 = link up
//   Sub WIZ_SetIP / WIZ_SetMask / WIZ_SetGateway (4 bytes)
//   Sub WIZ_Open(sock, mode, port)                  close, set the mode (WIZ_MODE_TCP / WIZ_MODE_UDP) and port, open
//   Sub WIZ_Command(sock, command)                  give a command (WIZ_CMD_...), wait until the chip has taken it
//   Function WIZ_Status(sock) As Byte               socket state (WIZ_SOCK_...)
//   Function WIZ_RxSize(sock) As Word               bytes received and waiting
//   Function WIZ_TxFree(sock) As Word               room in the TX buffer
//   Sub WIZ_RxRead(sock, to, count)                 received bytes to EthFrame(to ...), then RECV
//   Sub WIZ_RxDiscard(sock, count)                  drop received bytes, then RECV
//   Sub WIZ_TxWrite(sock, from, count)              EthFrame(from ...) to the TX buffer; the caller then gives SEND
//   Sub ShowWIZStatus                               version, MAC, addresses, link, socket states (console)
//
// The program may define:
//   WIZ_CHIP               5200 or 5500: only that chip's code. Left out: both, and the chip is found at start-up
// The program (or board file) defines:
//   WIZ_CS, WIZ_RESET, WIZ_SCK, WIZ_DO, WIZ_DI   pins (WIZ_DO to the chip's MOSI, WIZ_DI from its MISO)
//   WIZ_SPI_SPEED          SPIMode speed (MasterSlow, Master, MasterFast)
//   MY_MAC1-6, MY_IP1-4, IP_NETMASK1-4, IP_GATEWAY1-4
//   ETH_BUFFER_SIZE        bytes in EthFrame
//
// Uses the hardware SPI (HWSPITransfer) and the console (ENC28J60_Console.h) for ShowWIZStatus.
//
//@author    Evan R. Venn
//@licence   GPL
//@date      04/11/2026
//
// Changes:
//   03/11/2026  First version
//   04/11/2026  #option explicit
//   04/11/2026  ETH_BUFFER_SIZE default 600 (was 64): holds the 576-byte datagram every host must accept
//   04/11/2026  WIZ_CHIP optional: without it both chips are compiled and WIZ_Init finds the one fitted (W5200 version
//                    0x03 at 0x001F, else W5500 0x04 at 0x0039). Chip code in its own routines (WIZ5200_..., WIZ5500_...)
//                    behind the dispatch routines WIZ_Start, WIZ_Burst, WIZ_LinkIsUp; WIZ_Model holds the chip in use
//   05/11/2026  Fix: the chip routines read WIZ_Start's and WIZ_Burst's parameters as globals, and so as Bytes: the
//                    W5200 frame address and the burst limit lost their high byte (wrong TX/RX buffer positions:
//                    DHCP REQUEST garbled, MQTT dropped). The chip routines now take their own parameters
//   05/11/2026  Detection asks the W5200 first: after the W5500 probe (a zero-length read to a W5200) the W5200 did not
//                    answer, so the detecting build stopped at WIZ_Init on the W5200 board
//   05/11/2026  No chip found: WIZ_Init reports both version readings on the console (STACK_CONSOLE)
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

    #ifndef ETH_BUFFER_SIZE
        #define ETH_BUFFER_SIZE 600
    #endif

    // The frame buffer the stack works in: data to send, data received
    Dim EthFrame(ETH_BUFFER_SIZE)

    // The chip in use (5200 or 5500, 0 = none found) and its version register, set by WIZ_Init
    Dim WIZ_Model As Word
    Dim WIZ_ChipVersion As Byte

    // Blocks
    #define WIZ_BLK_COMMON 0
    #define WIZ_BLK_REG    1
    #define WIZ_BLK_TX     2
    #define WIZ_BLK_RX     3

    // Common registers, the same in both chips
    #define WIZ_MR    0x0000
    #define WIZ_GAR   0x0001
    #define WIZ_SUBR  0x0005
    #define WIZ_SHAR  0x0009
    #define WIZ_SIPR  0x000F

    // Common registers that differ
    #define WIZ5200_VERSIONR  0x001F            // = 0x03
    #define WIZ5200_VERSION   3
    #define WIZ5200_PSTATUS   0x0035            // bit 5 = link
    #define WIZ5500_VERSIONR  0x0039            // = 0x04
    #define WIZ5500_VERSION   4
    #define WIZ5500_PHYCFGR   0x002E            // bit 0 = link

    // WIZ_CHIP left out = 0: both chips. Set by the script, not by #ifndef: a #define inside #ifndef still registers
    #script
        if nodef(WIZ_CHIP) then
            WIZ_CHIP = 0
        end if
        if WIZ_CHIP <> 0 then
            if WIZ_CHIP <> 5200 then
                if WIZ_CHIP <> 5500 then
                    Error WIZ_CHIP must be 5200 or 5500 - leave it out to find the chip at start-up
                end if
            end if
        end if
    #endscript

    // Socket registers, the same in both chips
    #define WIZ_SN_MR      0x00
    #define WIZ_SN_CR      0x01
    #define WIZ_SN_IR      0x02
    #define WIZ_SN_SR      0x03
    #define WIZ_SN_PORT    0x04
    #define WIZ_SN_DHAR    0x06
    #define WIZ_SN_DIPR    0x0C
    #define WIZ_SN_DPORT   0x10
    #define WIZ_SN_TX_FSR  0x20
    #define WIZ_SN_TX_RD   0x22
    #define WIZ_SN_TX_WR   0x24
    #define WIZ_SN_RX_RSR  0x26
    #define WIZ_SN_RX_RD   0x28

    // Socket modes (Sn_MR)
    #define WIZ_MODE_TCP   0x01
    #define WIZ_MODE_UDP   0x02

    // Socket commands (Sn_CR)
    #define WIZ_CMD_OPEN     0x01
    #define WIZ_CMD_LISTEN   0x02
    #define WIZ_CMD_CONNECT  0x04
    #define WIZ_CMD_DISCON   0x08
    #define WIZ_CMD_CLOSE    0x10
    #define WIZ_CMD_SEND     0x20
    #define WIZ_CMD_RECV     0x40

    // Socket interrupt bits (Sn_IR): write the bit to clear it
    #define WIZ_IR_CON      0x01
    #define WIZ_IR_DISCON   0x02
    #define WIZ_IR_RECV     0x04
    #define WIZ_IR_TIMEOUT  0x08
    #define WIZ_IR_SENDOK   0x10

    // Socket states (Sn_SR)
    #define WIZ_SOCK_CLOSED       0x00
    #define WIZ_SOCK_INIT         0x13
    #define WIZ_SOCK_LISTEN       0x14
    #define WIZ_SOCK_ESTABLISHED  0x17
    #define WIZ_SOCK_CLOSE_WAIT   0x1C
    #define WIZ_SOCK_UDP          0x22

//--------------------------------------------------------------------------------------------------------------------------------
// SPI frames

Sub WIZ_Start(In WizSock, In WizBlk, In WizOff As Word, In WizRw, In WizLen As Word)
    // Select the chip and send the frame header: socket WizSock, block WizBlk, address WizOff, WizRw 1 = write,
    // WizLen bytes follow (the W5200 needs the length; the W5500 runs until CS goes high). The caller sends the data
    // and ends with WIZ_CS = 1. The parameters are handed on: a routine that only reads another routine's parameter
    // sees it as a Byte (a Word lost its high byte - 05/11/2026)
    #if WIZ_CHIP = 5200
        WIZ5200_Header WizSock, WizBlk, WizOff, WizRw, WizLen
    #endif
    #if WIZ_CHIP = 5500
        WIZ5500_Header WizSock, WizBlk, WizOff, WizRw
    #endif
    #if WIZ_CHIP = 0
        If WIZ_Model = 5500 Then
            WIZ5500_Header WizSock, WizBlk, WizOff, WizRw
        Else
            WIZ5200_Header WizSock, WizBlk, WizOff, WizRw, WizLen
        End If
    #endif
End Sub

Sub WIZ5200_Header(In Wiz2Sock, In Wiz2Blk, In Wiz2Off As Word, In Wiz2Rw, In Wiz2Len As Word)
    // W5200 frame: address (2), write bit + 15-bit length (2). Socket registers 0x4000 + n x 0x100; TX 0x8000 /
    // RX 0xC000 + n x 0x800, the pointer within the 2 KB
    Dim Wiz2Addr As Word
    Dim Wiz2Byte, Wiz2Junk As Byte
    Wiz2Addr = Wiz2Off
    If Wiz2Blk = WIZ_BLK_REG Then Wiz2Addr_H = 0x40 + Wiz2Sock
    If Wiz2Blk = WIZ_BLK_TX Then
        Wiz2Addr = Wiz2Off And 0x07FF
        Wiz2Addr_H = Wiz2Addr_H + 0x80 + Wiz2Sock * 8
    End If
    If Wiz2Blk = WIZ_BLK_RX Then
        Wiz2Addr = Wiz2Off And 0x07FF
        Wiz2Addr_H = Wiz2Addr_H + 0xC0 + Wiz2Sock * 8
    End If
    WIZ_CS = 0
    HWSPITransfer Wiz2Addr_H, Wiz2Junk
    HWSPITransfer [byte]Wiz2Addr, Wiz2Junk
    // Write bit 7, then the 15-bit length
    Wiz2Byte = Wiz2Len_H And 0x7F
    If Wiz2Rw = 1 Then Wiz2Byte = Wiz2Byte Or 0x80
    HWSPITransfer Wiz2Byte, Wiz2Junk
    HWSPITransfer [byte]Wiz2Len, Wiz2Junk
End Sub

Sub WIZ5500_Header(In Wiz5Sock, In Wiz5Blk, In Wiz5Off As Word, In Wiz5Rw)
    // W5500 frame: address (2), control byte: block select (socket x 4 + block) in bits 7-3, write bit 2, variable
    // length (bits 1-0 = 0)
    Dim Wiz5Byte, Wiz5Junk As Byte
    WIZ_CS = 0
    HWSPITransfer Wiz5Off_H, Wiz5Junk
    HWSPITransfer [byte]Wiz5Off, Wiz5Junk
    Wiz5Byte = (Wiz5Sock * 4 + Wiz5Blk) * 8
    If Wiz5Rw = 1 Then Wiz5Byte = Wiz5Byte Or 0x04
    HWSPITransfer Wiz5Byte, Wiz5Junk
End Sub

Function WIZ_Burst(In WizBuPtr As Word, In WizBuCount As Word) As Word
    // How many of WizBuCount buffer bytes at pointer WizBuPtr one burst may move: a W5200 burst does not wrap, so it
    // stops at the end of the 2 KB buffer; the W5500 wraps by itself
    WIZ_Burst = WizBuCount
    #if WIZ_CHIP = 5200
        WIZ_Burst = WIZ5200_Burst(WizBuPtr, WizBuCount)
    #endif
    #if WIZ_CHIP = 0
        If WIZ_Model = 5200 Then WIZ_Burst = WIZ5200_Burst(WizBuPtr, WizBuCount)
    #endif
End Function

Function WIZ5200_Burst(In Wiz2BuPtr As Word, In Wiz2BuCount As Word) As Word
    // Wiz2BuCount, shortened to the room left before the end of the 2 KB buffer
    Dim Wiz2Room As Word
    Wiz2Room = 2048 - (Wiz2BuPtr And 0x07FF)
    If Wiz2BuCount > Wiz2Room Then Wiz2BuCount = Wiz2Room
    WIZ5200_Burst = Wiz2BuCount
End Function

Sub WIZ_Write(In WizWrSock, In WizWrBlk, In WizWrAddr As Word, In WizWrData)
    // One byte to a register
    Dim WizWrJunk As Byte
    WIZ_Start WizWrSock, WizWrBlk, WizWrAddr, 1, 1
    HWSPITransfer WizWrData, WizWrJunk
    WIZ_CS = 1
End Sub

Function WIZ_Read(In WizRdSock, In WizRdBlk, In WizRdAddr As Word) As Byte
    // One byte from a register
    Dim WizRdData As Byte
    WIZ_Start WizRdSock, WizRdBlk, WizRdAddr, 0, 1
    HWSPITransfer 0, WizRdData
    WIZ_CS = 1
    WIZ_Read = WizRdData
End Function

Sub WIZ_Write16(In WizW16Sock, In WizW16Blk, In WizW16Addr As Word, In WizW16Data As Word)
    // A 16-bit register, high byte first
    Dim WizW16Junk As Byte
    WIZ_Start WizW16Sock, WizW16Blk, WizW16Addr, 1, 2
    HWSPITransfer WizW16Data_H, WizW16Junk
    HWSPITransfer [byte]WizW16Data, WizW16Junk
    WIZ_CS = 1
End Sub

Function WIZ_Read16(In WizR16Sock, In WizR16Blk, In WizR16Addr As Word) As Word
    // A 16-bit register, high byte first
    Dim WizR16Data As Word
    Dim WizR16Byte As Byte
    WIZ_Start WizR16Sock, WizR16Blk, WizR16Addr, 0, 2
    HWSPITransfer 0, WizR16Byte
    WizR16Data_H = WizR16Byte
    HWSPITransfer 0, WizR16Byte
    [byte]WizR16Data = WizR16Byte
    WIZ_CS = 1
    WIZ_Read16 = WizR16Data
End Function

//--------------------------------------------------------------------------------------------------------------------------------
// Start-up, addresses, link

Function WIZ_Init As Byte
    // Hardware reset, version check, then MAC, mask, gateway and IP from the program's constants. 0 = no chip
    WIZ_Init = 0

    Dir WIZ_CS Out
    Dir WIZ_RESET Out
    Dir WIZ_SCK Out
    Dir WIZ_DO Out
    Dir WIZ_DI In
    WIZ_CS = 1

    // Both chips take SPI mode 0
    SPIMode WIZ_SPI_SPEED, 0

    // Reset low 2 ms, then time for the chip's PLL to start
    WIZ_RESET = 0
    Wait 2 ms
    WIZ_RESET = 1
    Wait 200 ms

    // Find (or check) the chip by its version register. 0x00 or 0xFF: no answer on MISO (wiring, power, CS, W5200
    // PWDN). The W5200 is asked first: its frame (address, read + length 1) is a valid read on a W5500 too (address,
    // control byte 0 = common registers, read; the W5500 ends a frame when CS goes high), which there returns PHAR
    // (0 after reset), not 3. The other way round, the W5500 frame is a zero-length read to a W5200, after which it
    // did not answer the W5200 frame either (05/11/2026)
    // The readings, for the console report when no chip answers
    Dim WizProbe5200, WizProbe5500 As Byte
    WizProbe5200 = 0
    WizProbe5500 = 0
    WIZ_Model = 0
    #if WIZ_CHIP <> 5500
        // W5200: VERSIONR 0x001F = 0x03 (WIZ_Model 5200 makes the detecting build use W5200 frames)
        WIZ_Model = 5200
        WIZ_ChipVersion = WIZ_Read(0, WIZ_BLK_COMMON, WIZ5200_VERSIONR)
        WizProbe5200 = WIZ_ChipVersion
        If WIZ_ChipVersion <> WIZ5200_VERSION Then WIZ_Model = 0
    #endif
    #if WIZ_CHIP <> 5200
        // W5500: VERSIONR 0x0039 = 0x04
        If WIZ_Model = 0 Then
            WIZ_Model = 5500
            WIZ_ChipVersion = WIZ_Read(0, WIZ_BLK_COMMON, WIZ5500_VERSIONR)
            WizProbe5500 = WIZ_ChipVersion
            If WIZ_ChipVersion <> WIZ5500_VERSION Then WIZ_Model = 0
        End If
    #endif
    If WIZ_Model = 0 Then
        // No chip: say what each question returned (W5200 wants 0x03, W5500 0x04; 0x00 / 0xFF = no answer on MISO)
        #if STACK_CONSOLE <> 0
            CONSOLE_Print "WIZnet: no chip found"
            #if WIZ_CHIP <> 5500
                CONSOLE_Print "  W5200 version 0x" : CONSOLE_Print hex(WizProbe5200) : CONSOLE_Print " (wants 03)"
            #endif
            #if WIZ_CHIP <> 5200
                CONSOLE_Print "  W5500 version 0x" : CONSOLE_Print hex(WizProbe5500) : CONSOLE_Print " (wants 04)"
            #endif
            CONSOLE_CRLF
        #endif
        Exit Function
    End If

    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SHAR, MY_MAC1
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SHAR + 1, MY_MAC2
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SHAR + 2, MY_MAC3
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SHAR + 3, MY_MAC4
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SHAR + 4, MY_MAC5
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SHAR + 5, MY_MAC6
    WIZ_SetMask IP_NETMASK1, IP_NETMASK2, IP_NETMASK3, IP_NETMASK4
    WIZ_SetGateway IP_GATEWAY1, IP_GATEWAY2, IP_GATEWAY3, IP_GATEWAY4
    WIZ_SetIP MY_IP1, MY_IP2, MY_IP3, MY_IP4

    WIZ_Init = 1
End Function

Sub WIZ_SetIP(In WizIP1, In WizIP2, In WizIP3, In WizIP4)
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SIPR, WizIP1
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SIPR + 1, WizIP2
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SIPR + 2, WizIP3
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SIPR + 3, WizIP4
End Sub

Sub WIZ_SetMask(In WizMask1, In WizMask2, In WizMask3, In WizMask4)
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SUBR, WizMask1
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SUBR + 1, WizMask2
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SUBR + 2, WizMask3
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_SUBR + 3, WizMask4
End Sub

Sub WIZ_SetGateway(In WizGw1, In WizGw2, In WizGw3, In WizGw4)
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_GAR, WizGw1
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_GAR + 1, WizGw2
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_GAR + 2, WizGw3
    WIZ_Write 0, WIZ_BLK_COMMON, WIZ_GAR + 3, WizGw4
End Sub

Function WIZ_LinkIsUp As Byte
    // 1 = link up: W5200 PSTATUS bit 5, W5500 PHYCFGR bit 0
    Dim WizLkReg As Byte
    WIZ_LinkIsUp = 0
    WizLkReg = WIZ_LinkRegister
    #if WIZ_CHIP = 5200
        If (WizLkReg And 0x20) <> 0 Then WIZ_LinkIsUp = 1
    #endif
    #if WIZ_CHIP = 5500
        If (WizLkReg And 0x01) <> 0 Then WIZ_LinkIsUp = 1
    #endif
    #if WIZ_CHIP = 0
        If WIZ_Model = 5500 Then
            If (WizLkReg And 0x01) <> 0 Then WIZ_LinkIsUp = 1
        Else
            If (WizLkReg And 0x20) <> 0 Then WIZ_LinkIsUp = 1
        End If
    #endif
End Function

Function WIZ_LinkRegister As Byte
    // The chip's link register as it reads: W5200 PSTATUS, W5500 PHYCFGR
    #if WIZ_CHIP = 5200
        WIZ_LinkRegister = WIZ_Read(0, WIZ_BLK_COMMON, WIZ5200_PSTATUS)
    #endif
    #if WIZ_CHIP = 5500
        WIZ_LinkRegister = WIZ_Read(0, WIZ_BLK_COMMON, WIZ5500_PHYCFGR)
    #endif
    #if WIZ_CHIP = 0
        If WIZ_Model = 5500 Then
            WIZ_LinkRegister = WIZ_Read(0, WIZ_BLK_COMMON, WIZ5500_PHYCFGR)
        Else
            WIZ_LinkRegister = WIZ_Read(0, WIZ_BLK_COMMON, WIZ5200_PSTATUS)
        End If
    #endif
End Function

//--------------------------------------------------------------------------------------------------------------------------------
// Sockets

Sub WIZ_Command(In WizCmdSock, In WizCmd)
    // Give the command, then wait until the chip has taken it (Sn_CR reads 0 again; at most about 10 ms)
    Dim WizCmdWait As Byte
    WIZ_Write WizCmdSock, WIZ_BLK_REG, WIZ_SN_CR, WizCmd
    For WizCmdWait = 1 To 100
        If WIZ_Read(WizCmdSock, WIZ_BLK_REG, WIZ_SN_CR) = 0 Then Exit For
        Wait 100 us
    Next
End Sub

Function WIZ_Status(In WizStSock) As Byte
    WIZ_Status = WIZ_Read(WizStSock, WIZ_BLK_REG, WIZ_SN_SR)
End Function

Sub WIZ_Open(In WizOpSock, In WizOpMode, In WizOpPort As Word)
    // Close the socket, clear its interrupt bits, set mode and local port, open it (state INIT for TCP, UDP for UDP)
    WIZ_Command WizOpSock, WIZ_CMD_CLOSE
    WIZ_Write WizOpSock, WIZ_BLK_REG, WIZ_SN_IR, 0xFF
    WIZ_Write WizOpSock, WIZ_BLK_REG, WIZ_SN_MR, WizOpMode
    WIZ_Write16 WizOpSock, WIZ_BLK_REG, WIZ_SN_PORT, WizOpPort
    WIZ_Command WizOpSock, WIZ_CMD_OPEN
End Sub

Function WIZ_RxSize(In WizRsSock) As Word
    // Bytes received; read until two readings agree (the chip may change it between the two bytes)
    Dim WizRsOld, WizRsNew As Word
    WizRsNew = WIZ_Read16(WizRsSock, WIZ_BLK_REG, WIZ_SN_RX_RSR)
    Do
        WizRsOld = WizRsNew
        WizRsNew = WIZ_Read16(WizRsSock, WIZ_BLK_REG, WIZ_SN_RX_RSR)
    Loop While WizRsOld <> WizRsNew
    WIZ_RxSize = WizRsNew
End Function

Function WIZ_TxFree(In WizTfSock) As Word
    // Room in the TX buffer; read until two readings agree
    Dim WizTfOld, WizTfNew As Word
    WizTfNew = WIZ_Read16(WizTfSock, WIZ_BLK_REG, WIZ_SN_TX_FSR)
    Do
        WizTfOld = WizTfNew
        WizTfNew = WIZ_Read16(WizTfSock, WIZ_BLK_REG, WIZ_SN_TX_FSR)
    Loop While WizTfOld <> WizTfNew
    WIZ_TxFree = WizTfNew
End Function

Sub WIZ_RxRead(In WizRxSock, In WizRxTo As Word, In WizRxCount As Word)
    // WizRxCount received bytes into EthFrame(WizRxTo ...), then move Sn_RX_RD on and give RECV.
    // The caller keeps WizRxTo + WizRxCount within ETH_BUFFER_SIZE
    Dim WizRxPtr, WizRxChunk As Word
    Dim WizRxByte As Byte
    WizRxPtr = WIZ_Read16(WizRxSock, WIZ_BLK_REG, WIZ_SN_RX_RD)
    Do While WizRxCount > 0
        WizRxChunk = WIZ_Burst(WizRxPtr, WizRxCount)
        WIZ_Start WizRxSock, WIZ_BLK_RX, WizRxPtr, 0, WizRxChunk
        WizRxPtr = WizRxPtr + WizRxChunk
        WizRxCount = WizRxCount - WizRxChunk
        Repeat WizRxChunk
            HWSPITransfer 0, WizRxByte
            EthFrame(WizRxTo) = WizRxByte
            WizRxTo++
        End Repeat
        WIZ_CS = 1
    Loop
    WIZ_Write16 WizRxSock, WIZ_BLK_REG, WIZ_SN_RX_RD, WizRxPtr
    WIZ_Command WizRxSock, WIZ_CMD_RECV
End Sub

Sub WIZ_RxDiscard(In WizRdSock, In WizRdCount As Word)
    // Drop WizRdCount received bytes: move Sn_RX_RD on and give RECV
    Dim WizRdPtr As Word
    WizRdPtr = WIZ_Read16(WizRdSock, WIZ_BLK_REG, WIZ_SN_RX_RD)
    WIZ_Write16 WizRdSock, WIZ_BLK_REG, WIZ_SN_RX_RD, WizRdPtr + WizRdCount
    WIZ_Command WizRdSock, WIZ_CMD_RECV
End Sub

Sub WIZ_TxWrite(In WizTxSock, In WizTxFrom As Word, In WizTxCount As Word)
    // WizTxCount bytes from EthFrame(WizTxFrom ...) into the TX buffer at Sn_TX_WR, then move Sn_TX_WR on.
    // The caller checks WIZ_TxFree first and gives SEND afterwards
    Dim WizTxPtr, WizTxChunk As Word
    Dim WizTxJunk As Byte
    WizTxPtr = WIZ_Read16(WizTxSock, WIZ_BLK_REG, WIZ_SN_TX_WR)
    Do While WizTxCount > 0
        WizTxChunk = WIZ_Burst(WizTxPtr, WizTxCount)
        WIZ_Start WizTxSock, WIZ_BLK_TX, WizTxPtr, 1, WizTxChunk
        WizTxPtr = WizTxPtr + WizTxChunk
        WizTxCount = WizTxCount - WizTxChunk
        Repeat WizTxChunk
            HWSPITransfer EthFrame(WizTxFrom), WizTxJunk
            WizTxFrom++
        End Repeat
        WIZ_CS = 1
    Loop
    WIZ_Write16 WizTxSock, WIZ_BLK_REG, WIZ_SN_TX_WR, WizTxPtr
End Sub

//--------------------------------------------------------------------------------------------------------------------------------
// Diagnostics

#if STACK_CONSOLE <> 0
Sub ShowWIZStatus
    Dim WizShIndex As Byte
    CONSOLE_Print "W" : CONSOLE_Number WIZ_Model : CONSOLE_Print " version 0x" : CONSOLE_Print hex(WIZ_ChipVersion)
    #if WIZ_CHIP = 0
        CONSOLE_Print " (found)"
    #endif
    CONSOLE_Print "  MAC "
    For WizShIndex = 0 To 5
        CONSOLE_Print hex(WIZ_Read(0, WIZ_BLK_COMMON, WIZ_SHAR + WizShIndex))
        If WizShIndex < 5 Then CONSOLE_Print ":"
    Next
    CONSOLE_CRLF
    CONSOLE_Print "IP "
    WIZ_PrintIP WIZ_SIPR
    CONSOLE_Print "  mask "
    WIZ_PrintIP WIZ_SUBR
    CONSOLE_Print "  gateway "
    WIZ_PrintIP WIZ_GAR
    CONSOLE_CRLF
    CONSOLE_Print "Link "
    If WIZ_LinkIsUp = 1 Then
        CONSOLE_Print "up"
    Else
        CONSOLE_Print "down"
    End If
    CONSOLE_Print " (0x" : CONSOLE_Print hex(WIZ_LinkRegister) : CONSOLE_Print ")  sockets"
    For WizShIndex = 0 To 7
        CONSOLE_Print " " : CONSOLE_Print hex(WIZ_Status(WizShIndex))
    Next
    CONSOLE_CRLF
End Sub

Sub WIZ_PrintIP(In WizPrAddr As Word)
    // Four bytes of a common register as a dotted address
    Dim WizPrIndex As Byte
    For WizPrIndex = 0 To 3
        CONSOLE_Number WIZ_Read(0, WIZ_BLK_COMMON, WizPrAddr + WizPrIndex)
        If WizPrIndex < 3 Then CONSOLE_Print "."
    Next
End Sub
#endif
