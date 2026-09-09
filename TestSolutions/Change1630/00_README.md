# Change1630 - HSerPrintList / Ser1PrintList / Ser2PrintList / Ser3PrintList

New compiler feature (r1927): one statement sends a list of mixed-type values (string,
byte, word, integer, long) as a sequence of calls to the existing typed `HSerPrint` /
`SerNPrint` overloads. The compiler fans the statement out into one call per argument in
the preprocessor; no new library overloads were added.

| File | Verifies |
|---|---|
| `HSerPrintList_MixedTypes_Basic.gcb` | The core case: a string literal, a string variable, a byte, and a word in one statement |
| `HSerPrintList_CommaInString_Edge.gcb` | A comma inside a string literal is not treated as an argument separator |
| `HSerPrintList_BracketedArgs_Edge.gcb` | A bracketed call containing a comma (`Left(s, 3)`) is not split |
| `HSerPrintList_SingleArg_Edge.gcb` | A single-argument call still works |
| `HSerPrintList_EmptyArgs_Error.gcb` | `HSerPrintList` with no arguments is a clean compile error (`EmptyListArgs`) |
| `HSerPrintList_MaxArgs_50_OK.gcb` | Exactly 50 arguments (the `MAXPARAMS` limit) compiles successfully |
| `HSerPrintList_MaxArgs_51_Error.gcb` | 51 arguments is a clean compile error (`MaxListArgsExceeded`), not a crash |
| `SerNPrintList_AllChannels.gcb` | `Ser1PrintList`/`Ser2PrintList`/`Ser3PrintList` each dispatch to their own software-serial channel |
