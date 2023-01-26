#This script converts C code to GCBASIC

 The script will process CPP and H file to create the following files.

OUTPUT.GCB the converted file
UNPROCESSED.CPP	- a file with any C code that was not processed

 The terminal will show messages and warning during the conversion process.

Example command line:

 cls&gawk  -f ctogcb.awk MAX30100.h MAX30100_Registers.h MAX30100.cpp



 The script loads all the source files into in-memory arrays.
 Then, the script processes the array to convert.  There are many passes thru the in-memory arrays to cater for the conversion process.
 The in-memory arrays have to important features 1) the original C code 2) the original C code plus the meta data.
 The meta data contains key information like the file number, the line number and the method number.  These are all used during the conversion process.  Any meta left at the end with the sub routine '000' is unconverted C code.

 The process examines the C source code sequentially to convert.  The process iterates through the C source multiple times examing the C source code a follows:

    Determine methods(s)
    Compile For-Next
    Compile If(s)
    Compile I2C
    Comple Mathematical Logic
    Compile While
    Compile Variables
    Tidy Operations
    Complexity Inspection


