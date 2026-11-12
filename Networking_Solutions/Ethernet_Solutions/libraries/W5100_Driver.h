//--------------------------------------------------------------------------------------------------------------------------------
// W5100 driver - the WIZnet W5100 (Arduino Ethernet shield) on the hardware SPI
//
// The W5100 does ARP, IPv4, ICMP (it answers ping itself), TCP and UDP in 4 hardware sockets. This driver sets its
// addresses, opens and commands sockets, and moves bytes one at a time between the program and a socket's buffer, so a
// program needs no frame buffer: a reply is written straight into the socket's TX buffer.
//
// SPI frame (one per byte, the W5100 has no burst): write 0xF0, address high, address low, data;
//                                                   read  0x0F, address high, address low, then the data comes back
// Memory: common registers 0x0000; socket n registers 0x0400 + n x 0x100; TX buffer 0x4000 + n x 0x800 and RX buffer
// 0x6000 + n x 0x800 (2 KB each, RMSR / TMSR 0x55), the pointers taken within the 2 KB (And 0x07FF).
// The W5100 has no version register and no link register: W51_Init checks that the gateway address reads back.
//
// The program defines before including this file:
//   WIZ_CS                                  the W5100's chip select pin (Arduino Ethernet shield: B.2 (D10))
//   WIZ_SPI_SPEED                           SPIMode speed (the W5100 takes up to 14 MHz)
//   MY_MAC1-6, MY_IP1-4, IP_NETMASK1-4, IP_GATEWAY1-4   this device
// The SPI pins' directions are the program's (or the board file's): SCK and MOSI outputs, MISO input.
//
// Only one socket is read and one written at a time: W51_RxBegin / W51_TxBegin choose it.
//
// API
//   Function W51_Init As Byte                       reset, buffers, addresses; 1 = the chip answers
//   Sub W51_Open(sock, mode, port)                  close, set the mode (W51_MODE_TCP / W51_MODE_UDP) and port, open
//   Sub W51_Command(sock, command)                  give a command (W51_CMD_...), wait until the chip has taken it
//   Function W51_Status(sock) As Byte               socket state (W51_SOCK_...)
//   Function W51_RxSize(sock) As Word               bytes received and waiting
//   Sub W51_RxBegin(sock) / Function W51_RxByte / Sub W51_RxEnd     read received bytes, then give them back (RECV)
//   Sub W51_TxBegin(sock) / Sub W51_TxByte(b) / Sub W51_TxFlush     write bytes, sent in pieces (SEND); W51_TxOk = 0
//                                                   once a piece was not sent (peer gone): later bytes are dropped
//   Sub W51_UdpTo(sock, ip1, ip2, ip3, ip4, port)   where the next UDP datagram goes
//
//@author    Evan R. Venn
//@licence   GPL
//@date      09/11/2026
//
// Changes:
//   09/11/2026  First version (for WIZNET_MEGA328P_W5100-10.gcb, Arduino Uno with the Ethernet shield)
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

// ----- Registers

    #define W51_MR      0x0000
    #define W51_GAR     0x0001
    #define W51_SUBR    0x0005
    #define W51_SHAR    0x0009
    #define W51_SIPR    0x000F
    #define W51_RMSR    0x001A
    #define W51_TMSR    0x001B

    // Socket registers: offsets from 0x0400 + socket x 0x100
    #define W51_SN_MR      0x00
    #define W51_SN_CR      0x01
    #define W51_SN_IR      0x02
    #define W51_SN_SR      0x03
    #define W51_SN_PORT    0x04
    #define W51_SN_DIPR    0x0C
    #define W51_SN_DPORT   0x10
    #define W51_SN_TX_FSR  0x20
    #define W51_SN_TX_WR   0x24
    #define W51_SN_RX_RSR  0x26
    #define W51_SN_RX_RD   0x28

    #define W51_MODE_TCP 0x01
    #define W51_MODE_UDP 0x02

    #define W51_CMD_OPEN    0x01
    #define W51_CMD_LISTEN  0x02
    #define W51_CMD_DISCON  0x08
    #define W51_CMD_CLOSE   0x10
    #define W51_CMD_SEND    0x20
    #define W51_CMD_RECV    0x40

    #define W51_SOCK_CLOSED       0x00
    #define W51_SOCK_INIT         0x13
    #define W51_SOCK_LISTEN       0x14
    #define W51_SOCK_ESTABLISHED  0x17
    #define W51_SOCK_CLOSE_WAIT   0x1C
    #define W51_SOCK_UDP          0x22

    #define W51_IR_SEND_OK  0x10
    #define W51_IR_TIMEOUT  0x08

    // Bytes written before a SEND: half the 2 KB buffer, so the next piece fits while one is on its way
    #define W51_TX_PIECE 1024

// ----- Variables

    Dim W51_Sock, W51_TxSock, W51_TxOk As Byte
    Dim W51_RxPtr, W51_TxPtr, W51_TxCount As Word

// ----- SPI frames

Sub W51_Write(In W51WrAddr As Word, In W51WrData)
    Dim W51WrJunk As Byte
    Set WIZ_CS Off
    HWSPITransfer 0xF0, W51WrJunk
    HWSPITransfer W51WrAddr_H, W51WrJunk
    HWSPITransfer [byte]W51WrAddr, W51WrJunk
    HWSPITransfer W51WrData, W51WrJunk
    Set WIZ_CS On
End Sub

Function W51_Read(In W51RdAddr As Word) As Byte
    Dim W51RdByte As Byte
    Set WIZ_CS Off
    HWSPITransfer 0x0F, W51RdByte
    HWSPITransfer W51RdAddr_H, W51RdByte
    HWSPITransfer [byte]W51RdAddr, W51RdByte
    HWSPITransfer 0, W51RdByte
    Set WIZ_CS On
    W51_Read = W51RdByte
End Function

// ----- Socket registers

Function W51_SockAddr(In W51SaSock, In W51SaOff) As Word
    // 0x0400 + socket x 0x100 + offset
    W51_SockAddr = W51SaOff
    W51_SockAddr_H = 0x04 + W51SaSock
End Function

Sub W51_SWrite(In W51SwSock, In W51SwOff, In W51SwData)
    W51_Write W51_SockAddr(W51SwSock, W51SwOff), W51SwData
End Sub

Function W51_SRead(In W51SrSock, In W51SrOff) As Byte
    W51_SRead = W51_Read(W51_SockAddr(W51SrSock, W51SrOff))
End Function

Sub W51_SWrite16(In W51Sw16Sock, In W51Sw16Off, In W51Sw16Data As Word)
    W51_SWrite W51Sw16Sock, W51Sw16Off, W51Sw16Data_H
    W51_SWrite W51Sw16Sock, W51Sw16Off + 1, [byte]W51Sw16Data
End Sub

Function W51_SRead16(In W51Sr16Sock, In W51Sr16Off) As Word
    // A 16-bit value the chip may change between its two bytes: read until two readings agree
    Dim W51Sr16Old As Word
    W51_SRead16 = 0
    Do
        W51Sr16Old = W51_SRead16
        W51_SRead16_H = W51_SRead(W51Sr16Sock, W51Sr16Off)
        [byte]W51_SRead16 = W51_SRead(W51Sr16Sock, W51Sr16Off + 1)
    Loop While W51Sr16Old <> W51_SRead16
End Function

// ----- Chip

// Gateway, mask, MAC and IP: registers 0x0001 to 0x0012, one after the other (GAR, SUBR, SHAR, SIPR)
Table W51_Addresses
    IP_GATEWAY1, IP_GATEWAY2, IP_GATEWAY3, IP_GATEWAY4
    IP_NETMASK1, IP_NETMASK2, IP_NETMASK3, IP_NETMASK4
    MY_MAC1, MY_MAC2, MY_MAC3, MY_MAC4, MY_MAC5, MY_MAC6
    MY_IP1, MY_IP2, MY_IP3, MY_IP4
End Table

Function W51_Init As Byte
    // Reset, 2 KB buffers per socket, the addresses. 1 = the gateway address reads back
    Dim W51InReg, W51InByte As Byte
    Dir WIZ_CS Out
    Set WIZ_CS On
    SPIMode WIZ_SPI_SPEED, 0
    W51_Write W51_MR, 0x80
    Wait 10 ms
    W51_Write W51_RMSR, 0x55
    W51_Write W51_TMSR, 0x55
    For W51InReg = 1 To 18
        ReadTable W51_Addresses, W51InReg, W51InByte
        W51_Write W51InReg, W51InByte
    Next
    W51_Init = 0
    If W51_Read(W51_GAR + 3) <> IP_GATEWAY4 Then Exit Function
    If W51_Read(W51_SIPR + 3) <> MY_IP4 Then Exit Function
    W51_Init = 1
End Function

// ----- Sockets

Sub W51_Command(In W51CmSock, In W51Cmd)
    // Give the command and wait until the chip has taken it (Sn_CR reads 0 again)
    Dim W51CmWait As Word
    W51_SWrite W51CmSock, W51_SN_CR, W51Cmd
    W51CmWait = 0
    Do While W51_SRead(W51CmSock, W51_SN_CR) <> 0
        W51CmWait++
        If W51CmWait > 2000 Then Exit Do
    Loop
End Sub

Function W51_Status(In W51StSock) As Byte
    W51_Status = W51_SRead(W51StSock, W51_SN_SR)
End Function

Sub W51_Open(In W51OpSock, In W51OpMode, In W51OpPort As Word)
    W51_Command W51OpSock, W51_CMD_CLOSE
    W51_SWrite W51OpSock, W51_SN_MR, W51OpMode
    W51_SWrite16 W51OpSock, W51_SN_PORT, W51OpPort
    W51_Command W51OpSock, W51_CMD_OPEN
End Sub

Function W51_RxSize(In W51RsSock) As Word
    W51_RxSize = W51_SRead16(W51RsSock, W51_SN_RX_RSR)
End Function

// ----- Receive: W51_RxBegin, W51_RxByte for each byte, W51_RxEnd

Sub W51_RxBegin(In W51RbSock)
    W51_Sock = W51RbSock
    W51_RxPtr = W51_SRead16(W51RbSock, W51_SN_RX_RD)
End Sub

Function W51_RxByte As Byte
    // The next received byte: RX buffer 0x6000 + socket x 0x800, the pointer within the 2 KB
    Dim W51RxAddr As Word
    W51RxAddr = W51_RxPtr And 0x07FF
    W51RxAddr_H = W51RxAddr_H + 0x60 + W51_Sock * 8
    W51_RxByte = W51_Read(W51RxAddr)
    W51_RxPtr++
End Function

Sub W51_RxEnd
    // Give the bytes read back to the chip
    W51_SWrite16 W51_Sock, W51_SN_RX_RD, W51_RxPtr
    W51_Command W51_Sock, W51_CMD_RECV
End Sub

// ----- Send: W51_TxBegin, W51_TxByte for each byte, W51_TxFlush at the end

Sub W51_TxBegin(In W51TbSock)
    W51_TxSock = W51TbSock
    W51_TxPtr = W51_SRead16(W51TbSock, W51_SN_TX_WR)
    W51_TxCount = 0
    W51_TxOk = 1
End Sub

Sub W51_TxByte(In W51TxData)
    // One byte into the TX buffer (0x4000 + socket x 0x800); a full piece is sent first
    Dim W51TxAddr As Word
    If W51_TxOk = 0 Then Exit Sub
    If W51_TxCount >= W51_TX_PIECE Then W51_TxFlush
    If W51_TxOk = 0 Then Exit Sub
    W51TxAddr = W51_TxPtr And 0x07FF
    W51TxAddr_H = W51TxAddr_H + 0x40 + W51_TxSock * 8
    W51_Write W51TxAddr, W51TxData
    W51_TxPtr++
    W51_TxCount++
End Sub

Sub W51_TxFlush
    // Send what is written and wait for SEND_OK. TIMEOUT, a closed socket or no answer in 2 s: W51_TxOk = 0
    Dim W51TfIr As Byte
    Dim W51TfStart As Long
    If W51_TxCount = 0 Then Exit Sub
    W51_SWrite16 W51_TxSock, W51_SN_TX_WR, W51_TxPtr
    W51_Command W51_TxSock, W51_CMD_SEND
    W51_TxCount = 0
    W51TfStart = Millis()
    Do
        W51TfIr = W51_SRead(W51_TxSock, W51_SN_IR)
        If (W51TfIr And W51_IR_SEND_OK) <> 0 Then
            W51_SWrite W51_TxSock, W51_SN_IR, W51_IR_SEND_OK
            Exit Sub
        End If
        If (W51TfIr And W51_IR_TIMEOUT) <> 0 Then
            W51_SWrite W51_TxSock, W51_SN_IR, W51_IR_TIMEOUT
            Exit Do
        End If
        If W51_Status(W51_TxSock) = W51_SOCK_CLOSED Then Exit Do
        If Millis() - W51TfStart > 2000 Then Exit Do
    Loop
    W51_TxOk = 0
End Sub

// ----- UDP

Sub W51_UdpTo(In W51UtSock, In W51UtIp1, In W51UtIp2, In W51UtIp3, In W51UtIp4, In W51UtPort As Word)
    W51_SWrite W51UtSock, W51_SN_DIPR, W51UtIp1
    W51_SWrite W51UtSock, W51_SN_DIPR + 1, W51UtIp2
    W51_SWrite W51UtSock, W51_SN_DIPR + 2, W51UtIp3
    W51_SWrite W51UtSock, W51_SN_DIPR + 3, W51UtIp4
    W51_SWrite16 W51UtSock, W51_SN_DPORT, W51UtPort
End Sub
