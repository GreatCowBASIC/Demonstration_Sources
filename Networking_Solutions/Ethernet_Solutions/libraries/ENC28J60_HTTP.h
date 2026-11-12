//--------------------------------------------------------------------------------------------------------------------------------
// HTTP server for the ENC28J60 stack (HTTP/1.0 over ENC28J60_TCP.h) - several pages with live values, action links
//
//   - Pages are chosen by the program: "GET / " and "GET /<letter> " ask HTTP_Route for a page number (0 = none: 404)
//   - A page is a table in program memory (made by the HTML2GCB converter, or a GCBASIC table of strings), read through
//     HTTP_PageByte, with its length from HTTP_PageLength. HTTP_PageType gives text/html or application/json
//   - Live values: each 0 byte in a page is sent as the next value from HTTP_PageValue, as three characters
//     (space-padded: "170", " 85", "  5"; valid in HTML, JavaScript and JSON). HTTP_UpdateValues is called once per
//     request, before the reply, so a retransmitted segment shows the same values
//   - Action links: "GET /t0 " to "GET /t9 " call HTTP_Action with 0 to 9, then redirect the browser to / (302)
//   - Any other request gets 404 Not Found, or with HTTP_NOT_FOUND_HOME 1 a redirect to the dashboard / (302)
//   - Each reply is sent as TCP segments built at their offset (HTTP_FillData): no RAM holds a page
//   - HTTP_LOG 1: each request is reported on the serial console: "HTTP <peer IP> <path> <200, 302 or 404>"
//
// Needs ENC28J60_TCP.h (TCP_LISTEN_PORT 80).
//
// The program defines (all seven, or none: see "Defaults" at the end of this file):
//   Function HTTP_Route(In HttpPathChar) As Byte          page for "/" (HttpPathChar 0) or "/<letter>"; 0 = not found
//   Function HTTP_PageLength(In HttpPageNo) As Word        bytes in the page's table (ReadTable table, 0, length)
//   Function HTTP_PageByte(In HttpPageNo, In HttpPageIndex As Word) As Byte    byte HttpPageIndex (from 1)
//   Function HTTP_PageType(In HttpPageNo) As Byte          HTTP_TYPE_HTML or HTTP_TYPE_JSON
//   Sub HTTP_UpdateValues(In HttpPageNo)                   take the values for this request
//   Function HTTP_PageValue(In HttpPageNo, In HttpValueNo) As Byte    value HttpValueNo (from 1) of the page
//   Sub HTTP_Action(In HttpActionNo)                       carry out action link /t<HttpActionNo> (0 to 9)
// A program without them still compiles: the defaults below answer every page address with a built-in "OK" page,
// which proves the server works before any page is written. A routine in the program replaces the default of the
// same name (the default is then not compiled), so define all seven or none - with only some, the others stay the
// defaults (e.g. the program's HTTP_Route with the default HTTP_PageByte would send the OK page).
// The program may define:
//   HTTP_LOG               1 = report each request on the serial console (default 0)
//   HTTP_NOT_FOUND_HOME    1 = send an unknown path to / (302) instead of 404 (default 0)
//
// The stack calls HTTP_HandleData from TCP_HandleData and HTTP_FillData from TCP_FillData.
//
//@author    Evan R. Venn
//@licence   GPL
//@date      04/11/2026
//
// Changes:
//   01/11/2026  2026 initial release
//   01/11/2026  HTTP_NOT_FOUND_HOME: an unknown path can redirect to / instead of 404
//   01/11/2026  CON_ names renamed CONSOLE_
//   04/11/2026  #option explicit
//   04/11/2026  Defaults for the seven routines: a program without them gets a built-in "OK" page (the program's own
//                    routines replace the defaults, which are then not compiled)
//--------------------------------------------------------------------------------------------------------------------------------

    #option explicit

    // Console switch STACK_CONSOLE (0 headless, 1 serial, 2 TCP terminal) is set by the stack, from the program. No
    // default here: a default inside #ifndef was taken as well as the program's value (both console versions were compiled)

    // Statistics switch: 1 = counters and PrintStats in the program, 0 = left out (set by the program or ENC28J60_Stack)
    #ifndef STACK_STATS
        #define STACK_STATS 1
    #endif

    #ifndef HTTP_LOG
        #define HTTP_LOG 0
    #endif

    #ifndef HTTP_NOT_FOUND_HOME
        #define HTTP_NOT_FOUND_HOME 0
    #endif

    // Page types (HTTP_PageType)
    #define HTTP_TYPE_HTML 0
    #define HTTP_TYPE_JSON 1

    // Lengths of the header tables below
    #define HTTP_HEADER_LENGTH 63
    #define HTTP_JSON_HEADER_LENGTH 95
    #define HTTP_REDIRECT_LENGTH 54
    #define HTTP_NOT_FOUND_LENGTH 45

    // Replies
    #define HTTP_REPLY_PAGE      1
    #define HTTP_REPLY_NOT_FOUND 2
    #define HTTP_REPLY_REDIRECT  3

// ----- Variables
    // The reply being sent: kind, page, its type and header length
    Dim HTTP_Reply, HTTP_PageNo, HTTP_Json As Byte
    Dim HTTP_HeadLength As Word
    // Building a segment: stream position, the wanted part, where it goes in EthFrame
    Dim HTTP_StreamPos, HTTP_From, HTTP_To, HTTP_Pos As Word

    #if STACK_STATS = 1
        // Statistics
        Dim Stat_HttpPages, Stat_HttpNotFound, Stat_HttpActions As Word
    #endif

// ----- HTTP

Sub HTTP_Init
    // RAM is not cleared at reset
    HTTP_Reply = 0
    HTTP_PageNo = 0
    #if STACK_STATS = 1
        Stat_HttpPages = 0
        Stat_HttpNotFound = 0
        Stat_HttpActions = 0
    #endif
End Sub

Sub HTTP_HandleData
    // A request (or the start of one) is in EthFrame from TCP_RxData, TCP_RxLength bytes
    Dim HttpPathChar, HttpPathNext As Byte
    Dim HttpValues, HttpLenIndex, HttpLength As Word

    HTTP_Reply = HTTP_REPLY_NOT_FOUND
    // "GET /": G E T space slash
    If TCP_RxLength >= 6 Then
        If EthFrame(TCP_RxData) = 71 And EthFrame(TCP_RxData + 1) = 69 And EthFrame(TCP_RxData + 2) = 84 And EthFrame(TCP_RxData + 3) = 32 Then
            If EthFrame(TCP_RxData + 4) = 47 Then
                HttpPathChar = EthFrame(TCP_RxData + 5)
                HttpPathNext = 0
                If TCP_RxLength >= 7 Then HttpPathNext = EthFrame(TCP_RxData + 6)
                // Slash then space is HttpPathChar 0; slash, letter, space is one letter; slash, t, digit, space an action
                If HttpPathChar = 32 Then
                    HttpPathChar = 0
                    HttpPathNext = 32
                End If
                If HttpPathNext = 32 Then
                    HTTP_PageNo = HTTP_Route(HttpPathChar)
                    If HTTP_PageNo <> 0 Then HTTP_Reply = HTTP_REPLY_PAGE
                End If
                If HttpPathChar = 116 Then
                    If TCP_RxLength >= 8 Then
                        If HttpPathNext >= 48 And HttpPathNext <= 57 Then
                            If EthFrame(TCP_RxData + 7) = 32 Then HTTP_Reply = HTTP_REPLY_REDIRECT
                        End If
                    End If
                End If
            End If
        End If
    End If
    #if HTTP_LOG = 1
        #if STACK_CONSOLE <> 0
            HTTP_LogRequest
        #endif
    #endif

    // HTTP/1.0: the connection closes after the reply
    If HTTP_Reply = HTTP_REPLY_PAGE Then
        #if STACK_STATS = 1
            Stat_HttpPages++
        #endif
        HTTP_Json = HTTP_PageType(HTTP_PageNo)
        HTTP_HeadLength = HTTP_HEADER_LENGTH
        If HTTP_Json = HTTP_TYPE_JSON Then HTTP_HeadLength = HTTP_JSON_HEADER_LENGTH
        HTTP_UpdateValues HTTP_PageNo
        // Each live value (a 0 byte) is sent as 3 characters
        HttpLength = HTTP_PageLength(HTTP_PageNo)
        HttpValues = 0
        For HttpLenIndex = 1 To HttpLength
            If HTTP_PageByte(HTTP_PageNo, HttpLenIndex) = 0 Then HttpValues++
        Next
        TCP_SendStream HTTP_HeadLength + HttpLength + HttpValues * 2, 1
        Exit Sub
    End If
    If HTTP_Reply = HTTP_REPLY_REDIRECT Then
        #if STACK_STATS = 1
            Stat_HttpActions++
        #endif
        HTTP_Action HttpPathNext - 48
        TCP_SendStream HTTP_REDIRECT_LENGTH, 1
        Exit Sub
    End If
    #if STACK_STATS = 1
        Stat_HttpNotFound++
    #endif
    #if HTTP_NOT_FOUND_HOME = 1
        // Back to the dashboard: the 302 reply (HTTP_FillData sends HTTP_Header302), no action
        HTTP_Reply = HTTP_REPLY_REDIRECT
        TCP_SendStream HTTP_REDIRECT_LENGTH, 1
        Exit Sub
    #endif
    TCP_SendStream HTTP_NOT_FOUND_LENGTH, 1
End Sub

Sub HTTP_FillData(In HttpOffset As Word, In HttpCount As Word)
    // Write HttpCount bytes of the reply, from byte HttpOffset, to EthFrame from TCP_DATA. The page is walked from its
    // start, because each live value before the offset moves it by 2
    Dim HttpIndex, HttpLength As Word
    Dim HttpByte, HttpValueNo As Byte

    HTTP_Pos = TCP_DATA
    HTTP_From = HttpOffset
    HTTP_To = HttpOffset + HttpCount
    HTTP_StreamPos = HttpOffset
    If HTTP_Reply = HTTP_REPLY_REDIRECT Then
        For HttpIndex = HttpOffset + 1 To HTTP_To
            ReadTable HTTP_Header302, HttpIndex, HttpByte
            HTTP_Emit HttpByte
        Next
        Exit Sub
    End If
    If HTTP_Reply <> HTTP_REPLY_PAGE Then
        For HttpIndex = HttpOffset + 1 To HTTP_To
            ReadTable HTTP_Header404, HttpIndex, HttpByte
            HTTP_Emit HttpByte
        Next
        Exit Sub
    End If

    // Header: stream bytes 0 to HTTP_HeadLength - 1
    If HttpOffset < HTTP_HeadLength Then
        For HttpIndex = HttpOffset + 1 To HTTP_HeadLength
            If HTTP_StreamPos >= HTTP_To Then Exit Sub
            If HTTP_Json = HTTP_TYPE_JSON Then
                ReadTable HTTP_HeaderJson, HttpIndex, HttpByte
            Else
                ReadTable HTTP_Header200, HttpIndex, HttpByte
            End If
            HTTP_Emit HttpByte
        Next
    End If

    // Page, with each 0 byte expanded to the next live value
    HTTP_StreamPos = HTTP_HeadLength
    HttpValueNo = 0
    HttpLength = HTTP_PageLength(HTTP_PageNo)
    For HttpIndex = 1 To HttpLength
        If HTTP_StreamPos >= HTTP_To Then Exit Sub
        HttpByte = HTTP_PageByte(HTTP_PageNo, HttpIndex)
        If HttpByte = 0 Then
            HttpValueNo++
            HttpByte = HTTP_PageValue(HTTP_PageNo, HttpValueNo)
            // Three characters: hundreds, tens, units, with leading spaces
            If HttpByte >= 100 Then
                HTTP_Emit 48 + HttpByte / 100
            Else
                HTTP_Emit 32
            End If
            If HttpByte >= 10 Then
                HTTP_Emit 48 + (HttpByte / 10) % 10
            Else
                HTTP_Emit 32
            End If
            HTTP_Emit 48 + HttpByte % 10
        Else
            HTTP_Emit HttpByte
        End If
    Next
End Sub

Sub HTTP_Emit(In HttpEmitByte)
    // Stream byte HTTP_StreamPos: written when it is in the wanted part (HTTP_From to HTTP_To - 1)
    If HTTP_StreamPos >= HTTP_From Then
        If HTTP_StreamPos < HTTP_To Then
            EthFrame(HTTP_Pos) = HttpEmitByte
            HTTP_Pos++
        End If
    End If
    HTTP_StreamPos++
End Sub

#if HTTP_LOG = 1
#if STACK_CONSOLE <> 0
Sub HTTP_LogRequest
    // "HTTP <peer IP> <path> <status>": the path is the request's second word (at most 40 characters)
    Dim HttpLogIndex, HttpLogEnd As Word
    Dim HttpLogByte As Byte
    CONSOLE_Print "HTTP "
    CONSOLE_Number EthFrame(IP_SRC) : CONSOLE_Print "." : CONSOLE_Number EthFrame(IP_SRC + 1) : CONSOLE_Print "."
    CONSOLE_Number EthFrame(IP_SRC + 2) : CONSOLE_Print "." : CONSOLE_Number EthFrame(IP_SRC + 3) : CONSOLE_Print " "
    // Skip the method and its space
    HttpLogIndex = TCP_RxData
    HttpLogEnd = TCP_RxData + TCP_RxLength
    Do While HttpLogIndex < HttpLogEnd
        HttpLogIndex++
        If EthFrame(HttpLogIndex - 1) = 32 Then Exit Do
    Loop
    If HttpLogEnd > HttpLogIndex + 40 Then HttpLogEnd = HttpLogIndex + 40
    Do While HttpLogIndex < HttpLogEnd
        HttpLogByte = EthFrame(HttpLogIndex)
        If HttpLogByte <= 32 Then Exit Do
        CONSOLE_Char HttpLogByte
        HttpLogIndex++
    Loop
    If HTTP_Reply = HTTP_REPLY_PAGE Then CONSOLE_Print " 200"
    If HTTP_Reply = HTTP_REPLY_REDIRECT Then CONSOLE_Print " 302"
    If HTTP_Reply = HTTP_REPLY_NOT_FOUND Then CONSOLE_Print " 404"
    CONSOLE_CRLF
End Sub
#endif
#endif

#if STACK_STATS = 1
#if STACK_CONSOLE <> 0
Sub HTTP_PrintStats
    CONSOLE_Print "HTTP pages " : CONSOLE_Number Stat_HttpPages
    CONSOLE_Print "  not found " : CONSOLE_Number Stat_HttpNotFound
    CONSOLE_Print "  actions " : CONSOLE_Number Stat_HttpActions
    CONSOLE_CRLF
End Sub
#endif
#endif

// ----- Headers (each line ends CR LF, then an empty line)
// "HTTP/1.0 200 OK", "Content-Type: text/html", "Connection: close"
Table HTTP_Header200
    72, 84, 84, 80, 47, 49, 46, 48, 32, 50, 48, 48, 32, 79, 75, 13
    10, 67, 111, 110, 116, 101, 110, 116, 45, 84, 121, 112, 101, 58, 32, 116
    101, 120, 116, 47, 104, 116, 109, 108, 13, 10, 67, 111, 110, 110, 101, 99
    116, 105, 111, 110, 58, 32, 99, 108, 111, 115, 101, 13, 10, 13, 10
End Table

// "HTTP/1.0 200 OK", "Content-Type: application/json", "Cache-Control: no-store", "Connection: close"
Table HTTP_HeaderJson
    72, 84, 84, 80, 47, 49, 46, 48, 32, 50, 48, 48, 32, 79, 75, 13
    10, 67, 111, 110, 116, 101, 110, 116, 45, 84, 121, 112, 101, 58, 32, 97
    112, 112, 108, 105, 99, 97, 116, 105, 111, 110, 47, 106, 115, 111, 110, 13
    10, 67, 97, 99, 104, 101, 45, 67, 111, 110, 116, 114, 111, 108, 58, 32
    110, 111, 45, 115, 116, 111, 114, 101, 13, 10, 67, 111, 110, 110, 101, 99
    116, 105, 111, 110, 58, 32, 99, 108, 111, 115, 101, 13, 10, 13, 10
End Table

// "HTTP/1.0 302 Found", "Location: /", "Connection: close"
Table HTTP_Header302
    72, 84, 84, 80, 47, 49, 46, 48, 32, 51, 48, 50, 32, 70, 111, 117
    110, 100, 13, 10, 76, 111, 99, 97, 116, 105, 111, 110, 58, 32, 47, 13
    10, 67, 111, 110, 110, 101, 99, 116, 105, 111, 110, 58, 32, 99, 108, 111
    115, 101, 13, 10, 13, 10
End Table

// "HTTP/1.0 404 Not Found", "Connection: close"
Table HTTP_Header404
    72, 84, 84, 80, 47, 49, 46, 48, 32, 52, 48, 52, 32, 78, 111, 116
    32, 70, 111, 117, 110, 100, 13, 10, 67, 111, 110, 110, 101, 99, 116, 105
    111, 110, 58, 32, 99, 108, 111, 115, 101, 13, 10, 13, 10
End Table

// ----- Defaults: the seven routines for a program that defines none. Each is replaced by the program's routine of the
//       same name, and is compiled only when the program has none

// The built-in page: "<html><body><h1>OK</h1><p>GCBASIC web server - no page defined</p></body></html>"
Table HTTP_DefaultPage
    60, 104, 116, 109, 108, 62, 60, 98, 111, 100, 121, 62, 60, 104, 49, 62
    79, 75, 60, 47, 104, 49, 62, 60, 112, 62, 71, 67, 66, 65, 83, 73
    67, 32, 119, 101, 98, 32, 115, 101, 114, 118, 101, 114, 32, 45, 32, 110
    111, 32, 112, 97, 103, 101, 32, 100, 101, 102, 105, 110, 101, 100, 60, 47
    112, 62, 60, 47, 98, 111, 100, 121, 62, 60, 47, 104, 116, 109, 108, 62
End Table

Function HTTP_Route(In HttpDefPath) As Byte
    // Every page address ("/" and "/<letter>") gets the built-in page
    HTTP_Route = 1
End Function

Function HTTP_PageLength(In HttpDefPageNo) As Word
    Dim HttpDefLength As Word
    ReadTable HTTP_DefaultPage, 0, HttpDefLength
    HTTP_PageLength = HttpDefLength
End Function

Function HTTP_PageByte(In HttpDefPageNo, In HttpDefIndex As Word) As Byte
    Dim HttpDefByte As Byte
    ReadTable HTTP_DefaultPage, HttpDefIndex, HttpDefByte
    HTTP_PageByte = HttpDefByte
End Function

Function HTTP_PageType(In HttpDefTypePage) As Byte
    HTTP_PageType = HTTP_TYPE_HTML
End Function

Sub HTTP_UpdateValues(In HttpDefUpdPage)
    // No values
End Sub

Function HTTP_PageValue(In HttpDefValPage, In HttpDefValueNo) As Byte
    // No values (the built-in page has no 0 bytes)
    HTTP_PageValue = 0
End Function

Sub HTTP_Action(In HttpDefActionNo)
    // No action links
End Sub
