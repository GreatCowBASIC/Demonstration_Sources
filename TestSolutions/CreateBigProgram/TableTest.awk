    BEGIN {
  print "#CHIP 18f27q43"
  print "#OPTION Explicit"
  print "#config  LVP=ON"
  print "'Elements = "ELEMENTS

  print "Dir PORTC.6 Out    ' Make TX1 pin an output"

  print "RC6PPS = 0x0020    'TX1 > RC6"

  print "#DEFINE USART_BAUD_RATE 256000"
  print "#DEFINE USART_TX_BLOCKING"
  print "#include <millis.h>"
  print "dim data_position, data_buf, iIndex as long"
  print "dim data_length as word"


  createtable = 1
  elements = ELEMENTS
  print ""
  print ""
  print ""

  for (tablecount = 1; tablecount <= TABLES; tablecount++)
  {
    print "   data_position = 0 "
    print "   readtable START_CODE"tablecount",data_position, data_length"

   printf ("   HserPrint \"TABLE = START_CODE%s\"\n",tablecount)
    printf("   HSerPrint \" \"\n")
    print "   HSerPrint data_length"
    print "   HSerPrintCRLF"
    print "   HserPrint millis()"
    print "   HSerPrintCRLF"
    
    print "   for data_position = 1 to data_length"
    print "       readtable START_CODE"tablecount" , data_position, data_buf"
    print "       HSerPrint leftpad(str(data_buf),4)"
    print "       HSerSend  0x2c"
    print "       if data_position % 50 = 0 then HSerPrintCRLF"
    print "   next "
    print ""
    print "   HSerPrintCRLF"
  }
  print ""
  printf ("   HserPrint \"End of Test\"\n")
  print "do"
  print "loop"
  print "end"


  print ""
  for (tablecount = 1; tablecount <= TABLES; tablecount++)
  {

      print "TABLE START_CODE"tablecount" as byte"
       for ( tablepointer = 1; tablepointer < ELEMENTS; tablepointer++)
       {
          printf("%s,",tablepointer)
       }
       print tablepointer
      print "END TABLE"
  }
}
{
}
