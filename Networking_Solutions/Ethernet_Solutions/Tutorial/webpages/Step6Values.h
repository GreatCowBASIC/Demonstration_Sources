//--------------------------------------------------------------------------------------------------------------------------------
// Step6Values - the reply to "GET /v": the home page's values as JSON
//
// The browser receives one line, for example   {"a":128,"d":  1}
//   a   the potentiometer   value 1
//   d   the LED (1 = on)    value 2
//
// Each number in the table is one character of the reply, as its character code:
//   123 = {    34 = "    58 = :    44 = ,    125 = }    97 = a    100 = d
// A 0 is a hole: the web server fills it with the next value from HTTP_PageValue, as three characters ("  1", "128").
// A table of numbers, not an .htm page: JSON needs " around each name, and a GCBASIC string cannot hold one.
// Element 0 of a table is its length: ReadTable Step6Values, 0, length
//--------------------------------------------------------------------------------------------------------------------------------

Table Step6Values
    123, 34, 97, 34, 58, 0          // {"a":  value 1, the potentiometer
    44, 34, 100, 34, 58, 0          // ,"d":  value 2, the LED
    125                             // }
End Table
