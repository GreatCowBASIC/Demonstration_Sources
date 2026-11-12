//--------------------------------------------------------------------------------------------------------------------------------
// PageValues - the reply to "GET /v": the dashboard's values as JSON (test 020: with the SNTP time)
//
// What it is for
//   The dashboard (PageHome.htm) is sent once. After that its script asks for /v every 2 seconds (again after
//   500 ms when a request fails, e.g. while another browser is being served):
//       function U(){fetch('/v').then(r=>r.json()).then(j=>{S(j.a,j.b,j.q,j.p,j.d,T(j.t,j.Y,j.M,j.D,j.h,j.m,j.s));setTimeout(U,2000);}).catch(()=>setTimeout(U,500));}
//   fetch('/v') gets this reply, r.json() reads it as JSON, and S(...) redraws the three cards with the new values.
//   So the ADC bars and the port states follow the hardware without the whole page being sent again (about 40 bytes
//   instead of about 2000).
//
// What the browser receives (one line; the spaces are the padding of each value to three characters)
//       {"a":111,"b":254,"q":  2,"p": 61,"d":  0,"t":  2,"Y": 26,"M": 11,"D":  1,"h": 17,"m": 10,"s": 22}
//
//   Name   Value                          From (HTTP_PageValue in the program, value number)
//   a      AN2, ADC, top 8 bits           1
//   b      AN3, ADC, top 8 bits           2
//   q      request number                 3
//   p      PORTB                          4
//   d      PORTD                          5
//   t      time: 0 no SNTP in the build,  6
//          1 no time yet, 2 time valid
//   Y      year - 2000 (UTC)              7
//   M      month                          8
//   D      day                            9
//   h      hour                           10
//   m      minute                         11
//   s      second                         12
//
// How the table below makes that line
//   Each number in the table is one character of the reply, as its ASCII code:
//       123 = {    34 = "    58 = :    44 = ,    125 = }    97 = a    98 = b    113 = q    112 = p    100 = d
//   A 0 is not sent as a character: the web server (ENC28J60_HTTP.h) replaces each 0 with the next value from
//   HTTP_PageValue, written as three characters ("  1", " 18", "254"). The twelve 0s are values 1 to 12, in order.
//
// Why a table of numbers and not an .htm page like the others
//   JSON needs double quotes around the names. In a GCBASIC table of strings a double quote cannot be written (\" is
//   not an escape there), and the HTML2GCB converter only puts a value where a line has "NAME_GCB_BYTE = value",
//   which would leave the text "NAME_GCB_BYTE =" in the reply and so break the JSON. Writing the characters as numbers
//   avoids both, and it is short.
//
// Line by line:  {"a":0  ,"b":0  ,"q":0  ,"p":0  ,"d":0  ,"t":0  ,"Y":0  ,"M":0  ,"D":0  ,"h":0  ,"m":0  ,"s":0  }
//
//@author    Evan R. Venn
//@licence   GPL
//@date      30/10/2026
//--------------------------------------------------------------------------------------------------------------------------------

Table PageValues
    123, 34, 97, 34, 58, 0          // {"a":  value 1, AN2
    44, 34, 98, 34, 58, 0           // ,"b":  value 2, AN3
    44, 34, 113, 34, 58, 0          // ,"q":  value 3, request number
    44, 34, 112, 34, 58, 0          // ,"p":  value 4, PORTB
    44, 34, 100, 34, 58, 0          // ,"d":  value 5, PORTD
    44, 34, 116, 34, 58, 0          // ,"t":  value 6, time state
    44, 34, 89, 34, 58, 0           // ,"Y":  value 7, year - 2000
    44, 34, 77, 34, 58, 0           // ,"M":  value 8, month
    44, 34, 68, 34, 58, 0           // ,"D":  value 9, day
    44, 34, 104, 34, 58, 0          // ,"h":  value 10, hour
    44, 34, 109, 34, 58, 0          // ,"m":  value 11, minute
    44, 34, 115, 34, 58, 0          // ,"s":  value 12, second
    125                             // }
End Table
