// Build 1670: library for samesub_ifdef_library.gcb - the same Sub name for each interface,
// each in its own #ifdef block, as a library that supports several interfaces would have it

Dim ZTest As Byte

#ifdef ZZ_SPI
Sub ZSet
  Dir ZZ_SPI_CS Out             ' ZZ_SPI_CS is not defined: this copy must not be compiled
  ZTest = 11
End Sub
#endif

#ifdef ZZ_UART
Sub ZSet
  ZTest = 22
End Sub
#endif

#ifdef ZZ_PARALLEL
Sub ZSet
  ZTest = 33
End Sub
#endif
