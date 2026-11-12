//--------------------------------------------------------------------------------------------------------------------------------
// MQTT client for the ENC28J60 stack (MQTT 3.1.1, QoS 0) over the client connection of ENC28J60_TCP.h
//
//   - Connects to the broker MQTT_BROKER1-4 on MQTT_PORT with a user name and password, and keeps the connection up:
//     a lost connection is tried again every MQTT_RETRY_S seconds
//   - Subscribes to MQTT_TOPIC_COMMAND (e.g. "enc28j60/led/+"). A message on MQTT_COMMAND_PREFIX followed by one
//     character (e.g. "enc28j60/led/3") calls the program's MQTT_Command with that character and the payload:
//     "ON" or "1" = MQTT_SET_ON, "OFF" or "0" = MQTT_SET_OFF, anything else = MQTT_SET_TOGGLE
//   - Every MQTT_PUBLISH_S seconds, and within 1 s of a command, publishes to MQTT_TOPIC_VALUES a payload the program
//     writes in MQTT_BuildValues
//     (with MQTT_Put for a character and MQTT_PutValue for a value as three characters)
//   - Sends PINGREQ when nothing else was sent for half of MQTT_KEEPALIVE_S
//   - Availability: the CONNECT carries a last will - "offline", retained, on MQTT_STATUS_TOPIC - which the broker
//     publishes when the device disappears (no message for 1.5 x MQTT_KEEPALIVE_S, or the connection breaks). After
//     each connection the device publishes "online", retained, on the same topic
//   - Announces the device to Home Assistant (MQTT discovery) when MQTT_DISCOVERY_TOPIC is defined: after each
//     connection, one retained PUBLISH to that topic with a payload the program supplies byte by byte
//     (MQTT_DiscoveryLength, MQTT_DiscoveryByte - e.g. from a table). It may be long: the payload is read from the
//     program at each offset, like a web page, and the remaining length takes two bytes when it is 128 or more
//   - One message at a time, built in MQTT_Tx (RAM, MQTT_TX_SIZE bytes) and kept until TCP has it acknowledged, so a
//     retransmission sends the same bytes. Messages and their parts must be shorter than 128 bytes
//
// Needs ENC28J60_TCP.h (client connection) and the stack (ARP, IPv4).
//
// The program must define:
//   MQTT_BROKER1 to MQTT_BROKER4     the broker's address
//   MQTT_USER, MQTT_PASSWORD         the login (strings)
//   Sub MQTT_BuildValues             write the payload for MQTT_TOPIC_VALUES with MQTT_Put / MQTT_PutValue
//   Sub MQTT_Command(In MqttCmdChar, In MqttCmdSet)    a command arrived (see above)
// The program may define, for Home Assistant discovery:
//   MQTT_DISCOVERY_TOPIC             e.g. "homeassistant/device/enc28j60/config"
//   Function MQTT_DiscoveryLength As Word, Function MQTT_DiscoveryByte(In MqttDiscIndex As Word) As Byte (from 1)
// The program may define (defaults below):
//   MQTT_PORT, MQTT_CLIENT_ID, MQTT_STATUS_TOPIC, MQTT_TOPIC_VALUES, MQTT_TOPIC_COMMAND, MQTT_COMMAND_PREFIX, MQTT_KEEPALIVE_S,
//   MQTT_PUBLISH_S, MQTT_RETRY_S, MQTT_LOG (1 = report connect, ready and lost on the console)
//
// The stack calls MQTT_Init once, MQTT_Tick once a second, MQTT_HandleData and MQTT_FillData for the client
// connection.
//
//@author    Evan R. Venn
//@licence   GPL
//@date      04/11/2026
//
// Changes:
//   01/11/2026  2026 initial release
//   01/11/2026  CON_ names renamed CONSOLE_
//   01/11/2026  Values published within 1 s of a command (was at the next MQTT_PUBLISH_S)
//   04/11/2026  #option explicit
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

    // Console switch STACK_CONSOLE (0 headless, 1 serial, 2 TCP terminal) is set by the stack, from the program. No
    // default here: a default inside #ifndef was taken as well as the program's value (both console versions were compiled)

// ----- Options

    #ifndef MQTT_PORT
        #define MQTT_PORT 1883
    #endif
    #ifndef MQTT_CLIENT_ID
        #define MQTT_CLIENT_ID "enc28j60"
    #endif
    #ifndef MQTT_STATUS_TOPIC
        #define MQTT_STATUS_TOPIC "enc28j60/status"
    #endif
    #ifndef MQTT_TOPIC_VALUES
        #define MQTT_TOPIC_VALUES "enc28j60/values"
    #endif
    #ifndef MQTT_TOPIC_COMMAND
        #define MQTT_TOPIC_COMMAND "enc28j60/led/+"
    #endif
    #ifndef MQTT_COMMAND_PREFIX
        #define MQTT_COMMAND_PREFIX "enc28j60/led/"
    #endif
    #ifndef MQTT_KEEPALIVE_S
        #define MQTT_KEEPALIVE_S 60
    #endif
    #ifndef MQTT_PUBLISH_S
        #define MQTT_PUBLISH_S 5
    #endif
    #ifndef MQTT_RETRY_S
        #define MQTT_RETRY_S 10
    #endif
    #ifndef MQTT_LOG
        #define MQTT_LOG 1
    #endif

    // The message being sent: at most this many bytes
    #define MQTT_TX_SIZE 100

    // States
    #define MQTT_OFFLINE     0      // no connection: try again when MQTT_RetryLeft reaches 0
    #define MQTT_TCP_OPENING 1      // TCP SYN sent
    #define MQTT_CONNECTING  2      // CONNECT sent, waiting for CONNACK
    #define MQTT_SUBSCRIBING 3      // SUBSCRIBE sent, waiting for SUBACK
    #define MQTT_READY       4      // publishing and receiving commands

    // MQTT_Command settings
    #define MQTT_SET_OFF    0
    #define MQTT_SET_ON     1
    #define MQTT_SET_TOGGLE 2

    // Packet types (top 4 bits of the first byte)
    #define MQTT_CONNECT   0x10
    #define MQTT_CONNACK   0x20
    #define MQTT_PUBLISH   0x30
    #define MQTT_SUBSCRIBE 0x82
    #define MQTT_SUBACK    0x90
    #define MQTT_PINGREQ   0xC0
    #define MQTT_PINGRESP  0xD0

// ----- Variables
    Dim MQTT_State, MQTT_RetryLeft, MQTT_WaitLeft, MQTT_PublishLeft, MQTT_QuietSeconds As Byte
    // The message being sent, and its length
    Dim MQTT_Tx(MQTT_TX_SIZE)
    Dim MQTT_TxLength As Byte
    // A message longer than MQTT_Tx: bytes after MQTT_TxLength come from the program (discovery payload)
    Dim MQTT_TxExtra As Word
    // 1 when the discovery message, or the "online" message, is still to be sent on this connection
    Dim MQTT_AnnouncePending, MQTT_OnlinePending As Byte

// ----- MQTT

Sub MQTT_Init
    // RAM is not cleared at reset. First connection attempt at the first tick
    MQTT_State = MQTT_OFFLINE
    MQTT_RetryLeft = 1
    MQTT_WaitLeft = 0
    MQTT_PublishLeft = MQTT_PUBLISH_S
    MQTT_QuietSeconds = 0
    MQTT_TxLength = 0
    MQTT_TxExtra = 0
    MQTT_AnnouncePending = 0
    MQTT_OnlinePending = 0
End Sub

Sub MQTT_Tick
    // Once a second: open the connection, watch the handshake, publish, keep alive
    Dim MqttTcpState As Byte
    MqttTcpState = TCP_ClientState

    // The TCP connection is gone: start again later
    If MqttTcpState = TCP_LISTEN Then
        If MQTT_State <> MQTT_OFFLINE Then
            MQTT_State = MQTT_OFFLINE
            MQTT_RetryLeft = MQTT_RETRY_S
            #if MQTT_LOG = 1
                #if STACK_CONSOLE <> 0
                    CONSOLE_Print "MQTT lost" : CONSOLE_CRLF
                #endif
            #endif
        End If
        MQTT_RetryLeft--
        If MQTT_RetryLeft = 0 Then
            MQTT_RetryLeft = MQTT_RETRY_S
            TCP_Connect MQTT_BROKER1, MQTT_BROKER2, MQTT_BROKER3, MQTT_BROKER4, MQTT_PORT
            MQTT_State = MQTT_TCP_OPENING
            MQTT_WaitLeft = MQTT_RETRY_S
        End If
        Exit Sub
    End If

    // TCP open: log in
    If MQTT_State = MQTT_TCP_OPENING Then
        If MqttTcpState = TCP_ESTABLISHED Then
            MQTT_SendConnect
            MQTT_State = MQTT_CONNECTING
            MQTT_WaitLeft = MQTT_RETRY_S
            Exit Sub
        End If
    End If

    // Handshake taking too long: give up on this connection
    If MQTT_State <> MQTT_READY Then
        MQTT_WaitLeft--
        If MQTT_WaitLeft = 0 Then TCP_ClientClose
        Exit Sub
    End If

    // Ready: first the discovery message (once per connection), then the values every MQTT_PUBLISH_S seconds,
    // PINGREQ when quiet for half the keep-alive time
    MQTT_QuietSeconds++
    #ifdef MQTT_DISCOVERY_TOPIC
        If MQTT_AnnouncePending = 1 Then
            If TCP_ClientBusy = 0 Then
                MQTT_SendDiscovery
                MQTT_AnnouncePending = 0
            End If
            Exit Sub
        End If
    #endif
    // Then "online" (after the discovery message, so Home Assistant knows the availability topic first)
    If MQTT_OnlinePending = 1 Then
        If TCP_ClientBusy = 0 Then
            MQTT_SendOnline
            MQTT_OnlinePending = 0
        End If
        Exit Sub
    End If
    MQTT_PublishLeft--
    If MQTT_PublishLeft = 0 Then
        MQTT_PublishLeft = MQTT_PUBLISH_S
        If TCP_ClientBusy = 0 Then MQTT_SendValues
    End If
    If MQTT_QuietSeconds >= MQTT_KEEPALIVE_S / 2 Then
        If TCP_ClientBusy = 0 Then MQTT_SendPing
    End If
End Sub

// ----- Messages we send

Sub MQTT_SendConnect
    // CONNECT: protocol "MQTT" level 4; flags 0xE6 = user name, password, will retain, will (QoS 0), clean session;
    // keep-alive; then client id, will topic, will message ("offline"), user, password
    MQTT_Begin MQTT_CONNECT
    MQTT_Put 0 : MQTT_Put 4
    MQTT_Put 77 : MQTT_Put 81 : MQTT_Put 84 : MQTT_Put 84
    MQTT_Put 4
    MQTT_Put 0xE6
    MQTT_Put 0 : MQTT_Put MQTT_KEEPALIVE_S
    MQTT_PutString MQTT_CLIENT_ID
    MQTT_PutString MQTT_STATUS_TOPIC
    MQTT_PutString "offline"
    MQTT_PutString MQTT_USER
    MQTT_PutString MQTT_PASSWORD
    MQTT_Send
End Sub

Sub MQTT_SendSubscribe
    // SUBSCRIBE: packet id 1, the command topic filter, QoS 0
    MQTT_Begin MQTT_SUBSCRIBE
    MQTT_Put 0 : MQTT_Put 1
    MQTT_PutString MQTT_TOPIC_COMMAND
    MQTT_Put 0
    MQTT_Send
End Sub

Sub MQTT_SendValues
    // PUBLISH, QoS 0: the values topic, then the payload the program writes
    MQTT_Begin MQTT_PUBLISH
    MQTT_PutString MQTT_TOPIC_VALUES
    MQTT_BuildValues
    MQTT_Send
End Sub

#ifdef MQTT_DISCOVERY_TOPIC
Sub MQTT_SendDiscovery
    // PUBLISH, QoS 0, retain (0x31): the discovery topic, then MQTT_DiscoveryLength bytes from the program.
    // Remaining length = 2 + topic + payload, in one byte below 128, else two (7 bits each, low part first)
    Dim MqttDiscRemaining As Word
    Dim MqttDiscTopic As String * 48
    Dim MqttDiscIndex As Byte
    MqttDiscTopic = MQTT_DISCOVERY_TOPIC
    MQTT_TxExtra = MQTT_DiscoveryLength
    MqttDiscRemaining = 2 + Len(MqttDiscTopic) + MQTT_TxExtra
    MQTT_TxLength = 0
    MQTT_Put 0x31
    If MqttDiscRemaining < 128 Then
        MQTT_Put MqttDiscRemaining
    Else
        MQTT_Put (MqttDiscRemaining And 127) Or 128
        MQTT_Put MqttDiscRemaining / 128
    End If
    MQTT_Put 0
    MQTT_Put Len(MqttDiscTopic)
    For MqttDiscIndex = 1 To Len(MqttDiscTopic)
        MQTT_Put MqttDiscTopic(MqttDiscIndex)
    Next
    // The header is complete: hand header + payload to TCP (not MQTT_Send, which fills in a one-byte length)
    TCP_ClientSend MQTT_TxLength + MQTT_TxExtra
    MQTT_QuietSeconds = 0
End Sub
#endif

Sub MQTT_SendOnline
    // PUBLISH, QoS 0, retain (0x31): "online" on the status topic
    MQTT_Begin 0x31
    MQTT_PutString MQTT_STATUS_TOPIC
    MQTT_Put 111 : MQTT_Put 110 : MQTT_Put 108 : MQTT_Put 105 : MQTT_Put 110 : MQTT_Put 101
    MQTT_Send
End Sub

Sub MQTT_SendPing
    MQTT_Begin MQTT_PINGREQ
    MQTT_Send
End Sub

Sub MQTT_Begin(In MqttType)
    // Start a message: its type, and a place for the remaining length (filled in by MQTT_Send)
    MQTT_TxLength = 0
    MQTT_TxExtra = 0
    MQTT_Put MqttType
    MQTT_Put 0
End Sub

Sub MQTT_Put(In MqttByte)
    // One byte of the message; bytes beyond MQTT_TX_SIZE are dropped
    If MQTT_TxLength < MQTT_TX_SIZE Then
        MQTT_TxLength++
        MQTT_Tx(MQTT_TxLength) = MqttByte
    End If
End Sub

Sub MQTT_PutString(In MqttText As String)
    // An MQTT string: 2-byte length, then the characters
    Dim MqttTextIndex As Byte
    MQTT_Put 0
    MQTT_Put Len(MqttText)
    For MqttTextIndex = 1 To Len(MqttText)
        MQTT_Put MqttText(MqttTextIndex)
    Next
End Sub

Sub MQTT_PutValue(In MqttValue)
    // A value as three characters, space-padded ("170", " 85", "  5"), as on the web pages
    If MqttValue >= 100 Then
        MQTT_Put 48 + MqttValue / 100
    Else
        MQTT_Put 32
    End If
    If MqttValue >= 10 Then
        MQTT_Put 48 + (MqttValue / 10) % 10
    Else
        MQTT_Put 32
    End If
    MQTT_Put 48 + MqttValue % 10
End Sub

Sub MQTT_Send
    // Fill in the remaining length (all bytes after the first two) and hand the message to TCP
    MQTT_Tx(2) = MQTT_TxLength - 2
    TCP_ClientSend MQTT_TxLength
    MQTT_QuietSeconds = 0
End Sub

Sub MQTT_FillData(In MqttOffset As Word, In MqttCount As Word)
    // TCP asks for MqttCount bytes of the message from byte MqttOffset (0 = first): the first MQTT_TxLength come from
    // MQTT_Tx, the rest (discovery payload) from the program
    Dim MqttPos, MqttIndex As Word
    MqttPos = TCP_DATA
    For MqttIndex = MqttOffset + 1 To MqttOffset + MqttCount
        If MqttIndex <= MQTT_TxLength Then
            EthFrame(MqttPos) = MQTT_Tx(MqttIndex)
        Else
            #ifdef MQTT_DISCOVERY_TOPIC
                EthFrame(MqttPos) = MQTT_DiscoveryByte(MqttIndex - MQTT_TxLength)
            #endif
        End If
        MqttPos++
    Next
End Sub

// ----- Messages we receive

Sub MQTT_HandleData
    // TCP_RxLength bytes from the broker in EthFrame from TCP_RxData: one or more packets
    Dim MqttPos, MqttStop, MqttNext As Word
    Dim MqttType, MqttLength As Byte
    MqttPos = TCP_RxData
    MqttStop = TCP_RxData + TCP_RxLength
    Do While MqttPos + 1 < MqttStop
        MqttType = EthFrame(MqttPos) And 0xF0
        MqttLength = EthFrame(MqttPos + 1)
        // A remaining length of 128 or more takes more bytes: not expected from this broker, so stop reading
        If MqttLength > 127 Then Exit Sub
        MqttNext = MqttPos + 2 + MqttLength
        If MqttNext > MqttStop Then Exit Sub
        Select Case MqttType
            Case MQTT_CONNACK
                // Byte 4 is the return code: 0 = accepted
                If EthFrame(MqttPos + 3) = 0 Then
                    MQTT_SendSubscribe
                    MQTT_State = MQTT_SUBSCRIBING
                    MQTT_WaitLeft = MQTT_RETRY_S
                Else
                    #if MQTT_LOG = 1
                        #if STACK_CONSOLE <> 0
                            CONSOLE_Print "MQTT refused " : CONSOLE_Number EthFrame(MqttPos + 3) : CONSOLE_CRLF
                        #endif
                    #endif
                    TCP_ClientClose
                End If
            Case MQTT_SUBACK
                MQTT_State = MQTT_READY
                MQTT_PublishLeft = 1
                MQTT_AnnouncePending = 1
                MQTT_OnlinePending = 1
                #if MQTT_LOG = 1
                    #if STACK_CONSOLE <> 0
                        CONSOLE_Print "MQTT ready" : CONSOLE_CRLF
                    #endif
                #endif
            Case MQTT_PUBLISH
                MQTT_ReceivePublish MqttPos, MqttNext
        End Select
        MqttPos = MqttNext
    Loop
End Sub

Sub MQTT_ReceivePublish(In MqttPubStart As Word, In MqttPubStop As Word)
    // A PUBLISH (QoS 0) from MqttPubStart to MqttPubStop: 2-byte topic length, topic, payload. A topic of
    // MQTT_COMMAND_PREFIX and one more character is a command
    Dim MqttTopicLength, MqttTopic, MqttPayload, MqttIndex As Word
    Dim MqttPrefix As String * 20
    Dim MqttCmdChar, MqttSetting As Byte
    MqttPrefix = MQTT_COMMAND_PREFIX
    MqttTopicLength = EthFrame(MqttPubStart + 3)
    MqttTopic = MqttPubStart + 4
    MqttPayload = MqttTopic + MqttTopicLength
    If MqttPayload > MqttPubStop Then Exit Sub
    If MqttTopicLength <> Len(MqttPrefix) + 1 Then Exit Sub
    For MqttIndex = 1 To Len(MqttPrefix)
        If EthFrame(MqttTopic + MqttIndex - 1) <> MqttPrefix(MqttIndex) Then Exit Sub
    Next
    MqttCmdChar = EthFrame(MqttPayload - 1)
    // Payload: "ON" or "1" on, "OFF" or "0" off, anything else toggles
    MqttSetting = MQTT_SET_TOGGLE
    If MqttPayload < MqttPubStop Then
        If EthFrame(MqttPayload) = 49 Then MqttSetting = MQTT_SET_ON
        If EthFrame(MqttPayload) = 48 Then MqttSetting = MQTT_SET_OFF
        If MqttPayload + 1 < MqttPubStop Then
            If EthFrame(MqttPayload) = 79 Then
                If EthFrame(MqttPayload + 1) = 78 Then MqttSetting = MQTT_SET_ON
                If EthFrame(MqttPayload + 1) = 70 Then MqttSetting = MQTT_SET_OFF
            End If
        End If
    End If
    MQTT_Command MqttCmdChar, MqttSetting
    // Report the new state at the next tick (within 1 s), not at the next MQTT_PUBLISH_S
    MQTT_PublishLeft = 1
End Sub
