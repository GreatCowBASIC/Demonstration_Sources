# Change 1664: HSerPrintList takes its list in brackets

`HSerPrintList "d", inchar, ":"` worked, but the same list in brackets, as a sub call may be written, did not:

- `HSerPrintList ("d", inchar, ":")` - build 1663: `Error: No matching overload found for HSERPRINT with these argument
  types`. The commas were all inside the brackets, so the list was not split: it became one `HSerPrint` with three values.
- `HSerPrintList("d", inchar, ":")` (no space) - build 1663: `Error: Array/Function HSERPRINTLIST has not been declared`.
  The command was recognised only with a space after its name.

Build 1664: both are the same as `HSerPrintList "d", inchar, ":"` - the same code. The same for `Ser1PrintList`,
`Ser2PrintList` and `Ser3PrintList`. The brackets are taken off only when they hold the whole list, so
`HSerPrintList (inchar + 1) * 2, inchar` is still two values. A leading `[comport]` may be inside them:
`HSerPrintList ([2], "d", inchar)`.

## Test programs

| Program | Expected (build 1664) |
|---|---|
| `HSerPrintList_Brackets.gcb` | Compiles; the bracketed line gives the same code as the unbracketed one |
| `HSerPrintList_BracketsNoSpace.gcb` | Compiles (bracket straight after the name) |
| `HSerPrintList_BracketsComport.gcb` | Compiles; all values to comport 2 (PIC18F46J50, two USARTs) |
| `HSerPrintList_FirstValueInBrackets.gcb` | Compiles; two values - the same code as `HSerPrint (inchar + 1) * 2 : HSerPrint inchar` |
