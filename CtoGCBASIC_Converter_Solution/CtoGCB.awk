#
# This script converts C code to GCBASIC 
#
# The script will process CPP and H file to create the following files.
#
#	OUTPUT.GCB the converted file
#	UNPROCESSED.CPP	- a file with any C code that was not processed
#
# The terminal will show messages and warning during the conversion process.
#
# command line   
#    cls&gawk  -f ctogcb.awk MAX30100.h MAX30100_Registers.h MAX30100.cpp
#
#
#
# The script loads all the source files into in-memory arrays.
# Then, the script processes the array to convert.  There are many passes thru the in-memory arrays to cater for the conversion process.
# The in-memory arrays have to important features 1) the original C code 2) the original C code plus the meta data.
# The meta data contains key information like the file number, the line number and the method number.  These are all used during the conversion process.  Any meta left at the end with the sub routine '000' is unconverted C code.
#
# The process examines the code sequentially to convert.
#
#

BEGIN{

    #Some display config stuff
        #Provides more information about conversion process
        SHOWMETHODDISCOVERY = 0

        #Show Original in OUTFILE.GCB 0 or 1
        SHOWORIGIN = 0


    # version 3
        hlinecounter=1
        blockcomment = 0   #used to track block comments
        commentline = 0    # used to print an empty line before comments
        filecounter = 0
        ccpcounter = 1
        subroutinenumber = 0
        lastfilename = ""
        #an enum of code lines
        orginalline = 1
        METADATA = 2
        foundmethodcounter = 0
        unprocessedlines = 0
        I2CMessage = 0
        warningmessages = 0
        Space30 = "                              "   
        warningcount = 0


        print "// C to GCB Conversion v1.00a 2023"> "OUTFILE.GCB"
        print ""> "OUTFILE.GCB"

        #constants
        NAME = 0
        POINTER = 1
        PARAMS = 2
        ORGINALLINE = 1
        METADATA = 2

        #i2c constants
        STOPPED = 1
        STARTED = 2
        FALSE = 0
        TRUE  = 1

        #ifstate constants
        IFSTATE_NONE = 0
        IFSTATE_LOOKING_FOR_ELSE_OR_END = 1


        #Type of Variants Supported
        CVARIANTTYPE = 1
        GCBVARIANTTYPE = 2
        VariantsSupportedIndex = 1
        VariantsSupported[VariantsSupportedIndex,CVARIANTTYPE]        = "BYTE";
            VariantsSupported[VariantsSupportedIndex,GCBVARIANTTYPE]        = "BYTE";
            VariantsSupportedIndex++
        VariantsSupported[VariantsSupportedIndex,CVARIANTTYPE]        = "BOOL";
            VariantsSupported[VariantsSupportedIndex,GCBVARIANTTYPE]        = "BYTE";
            VariantsSupportedIndex++
        VariantsSupported[VariantsSupportedIndex,CVARIANTTYPE]        = "UINT16_T";
            VariantsSupported[VariantsSupportedIndex,GCBVARIANTTYPE]        = "WORD";
            VariantsSupportedIndex++
        VariantsSupported[VariantsSupportedIndex,CVARIANTTYPE]        = "UINT8_T";
            VariantsSupported[VariantsSupportedIndex,GCBVARIANTTYPE]        = "BYTE";
            VariantsSupportedIndex++


        #Variables that WILL cause in MPASM and GCASM
            VariableASMClash = "DATA|LENGTH|ADDRESS|SHUTDOWN";
        #C Command that are not coverted - too complex  
           TooComplex = ".PUSH|.PULL|.ISEMPTY|ANOTHER";

        
        
        BYTEVAR = 0
        WORDVAR = 1
}


{

    if ( FILENAME != lastfilename ) {
        lastfilename = FILENAME
        filecounter++
        blockcomment = 0
    }


    if ( index(toupper(FILENAME), ".CPP" ) != 0 ) {

        #to handle comments, set subroutine to 999 and that way they will not appear in the UNPROCESSED.CPP file.
        #this is overwritten by proper metadata if real code.
            #CPPFile[ ccpcounter , METADATA ] = ";?F"  filecounter  "L"   ccpcounter   "S999?//Commments"


        if ( trim($0) == "") {
            next
        }


        #remove block comments
        if ( substr(trim($0),1,2) == "/*") {
            blockcomment = 1
            next
        }

        #restore handling after block comments
        if ( substr(trim($0),1,2) == "*/") {
            blockcomment = 0
            next
        }

        if ( blockcomment == 1) {
            next
        }

        #remove comments
        if ( substr(trim($0),1,2) == "//") {
            next
        }

        #remove includes
        if ( index(trim(toupper($0)),"#INCLUDE") == 1 ) {
            next
        }


        #read CPP
        CPPFile[ ccpcounter , ORGINALLINE ] = $0
        #Set subroutine to 000 as method matching happens later
        CPPFile[ ccpcounter , METADATA ] = $0";?F"  filecounter  "L"   FNR   "S000?"  
        ccpcounter++
    }   

    if ( index(toupper(FILENAME), ".H" ) != 0 ) {

        if ( trim($0) == "") {
            hlinecounter++
            next
        }
        
        #remove block comments
        if ( substr(trim($0),1,2) == "/*") {
            blockcomment = 1
            hlinecounter++
            next
        }

        #restore handling after block comments
        if ( substr(trim($0),1,2) == "*/") {
            blockcomment = 0
            hlinecounter++
            next
        }

        if ( blockcomment == 1) {
            hlinecounter++
            next
        }

        #read .H     
        # load each line into the array
        HFile[hlinecounter,0 ] = $0
            # replace bitwise
            gsub(/\(1 << 0\)/,"1       // bitaddress. was ( 1 << 0 )",HFile[hlinecounter,0 ]  )
            gsub(/\(1 << 1\)/,"2       // bitaddress. was ( 1 << 1 )",HFile[hlinecounter,0 ]  )
            gsub(/\(1 << 2\)/,"4       // bitaddress. was ( 1 << 2 )",HFile[hlinecounter,0 ]  )
            gsub(/\(1 << 3\)/,"8       // bitaddress. was ( 1 << 3 )",HFile[hlinecounter,0 ]  )
            gsub(/\(1 << 4\)/,"16      // bitaddress. was ( 1 << 4 )",HFile[hlinecounter,0 ]  )
            gsub(/\(1 << 5\)/,"32      // bitaddress. was ( 1 << 5 )",HFile[hlinecounter,0 ]  )
            gsub(/\(1 << 6\)/,"64      // bitaddress. was ( 1 << 6 )",HFile[hlinecounter,0 ]  )
            gsub(/\(1 << 7\)/,"128     // bitaddress .was ( 1 << 7 )",HFile[hlinecounter,0 ]  )
        HFile[hlinecounter,1 ] = NF
        
        hlinecounter++
    }

}

#This where the conversion is handled
END{
    
    #Now display the DEFINEs
    for ( displayhines = 0; displayhines < hlinecounter; displayhines++ ) {
        newline = trim(toupper(HFile[displayhines,0])) 

        #handles comments
        if ( substr( newline, 1 , 2 ) == "//" ){
            print OUTFILE   >> "OUTFILE.GCB";
            printf ( "%s\n",newline )  >> "OUTFILE.GCB";
            commentline = 1
        }
        else
            commentline = 0
        
        #Handle constants
        if ( index( newline, "#DEFINE" ) > 0 ) {
            #A valid define has to have three parameters ...like #DEFINE whatever value
            if ( HFile[displayhines,1] > 2 ) {
                print toupper( HFile[displayhines,0] )   >> "OUTFILE.GCB";
            }
        }
        #Handle enums
        if ( index( newline, "ENUM" ) > 0 && index( newline, "TYPEDEF" ) > 0 ) {
            split( newline, newarray, " ")
            printf ( "\n" )  >> "OUTFILE.GCB";
            printf ( "// Enum expansion to Constants for %s \n",newarray[3] )  >> "OUTFILE.GCB";

            #add Enum to array - there is not way this is empty....
            if ( trim(newarray[3]) != "" ) {
                VariantsSupported[VariantsSupportedIndex,CVARIANTTYPE]        = trim(newarray[3])
                VariantsSupported[VariantsSupportedIndex,GCBVARIANTTYPE]        = "BYTE"
                VariantsSupportedIndex++
            }
            #read the emum and handle

            newline = trim(toupper(HFile[displayhines++,0]))
            while ( index( HFile[displayhines,0], "}" ) == 0 ) {
                newline = trim(toupper(HFile[displayhines++,0]));
                sub ( "=" , "", newline)
                sub ( "," , "", newline)         
                printf ( "#DEFINE %s\n",newline )  >> "OUTFILE.GCB";
            } 
            if ( commentline = 0 )
                print ""  >> "OUTFILE.GCB";
        }

    }
    print "" >> "OUTFILE.GCB"
        print "// Variables and variable type defined and used" >> "OUTFILE.GCB"
        print "//" >> "OUTFILE.GCB"
                    print "//     C variable/enum type          GCBASIC type " >> "OUTFILE.GCB"
            for ( ccount = 1; ccount < VariantsSupportedIndex; ccount++ ) {
                    print "//     "substr( VariantsSupported [ ccount, CVARIANTTYPE ]Space30,1, 30)VariantsSupported [ ccount, GCBVARIANTTYPE ]  >> "OUTFILE.GCB"
            }
        print "" >> "OUTFILE.GCB"
        print "" >> "OUTFILE.GCB"
        print "//*****************PROCESSED******************************************" >> "OUTFILE.GCB"
        print "" >> "OUTFILE.GCB"

        print "*****************UNPROCESSED****************************************" > "UNPROCESSED.CPP"
        print ""  >> "UNPROCESSED.CPP"


    #Do the processing

        determinemethod( "BOOL")
        determinemethod( "VOID")    
        determinemethod("UINT8_T")
        determinemethod("FLOAT")
            
        if ( SHOWMETHODDISCOVERY  == 1)
            print ""
        if ( SHOWMETHODDISCOVERY  == 1 )
            print "Compile For-Next commands"
        compilefor()
            
        if ( SHOWMETHODDISCOVERY  == 1 )
            print "Compile If(s)"
        compileif()
                        
        if ( SHOWMETHODDISCOVERY  == 1 )                        
            print "Compile I2C"
        compile12c()

        if ( SHOWMETHODDISCOVERY  == 1 )            
            print "Comple Mathematical Logic"
        compilelogic()

        if ( SHOWMETHODDISCOVERY  == 1 )
            print "Compile While"
        compilewhile()

        #print "Compile Exit methods"
        #    compileexit()
            
        #print "Compile Return"
        #    compilereturn()
            
        #print "Add variable(s) and bit(s)"
        #    addvars()

        if ( SHOWMETHODDISCOVERY  == 1 )            
            print "Compile Variables"
        compilevariables()

        if ( SHOWMETHODDISCOVERY  == 1 )
            print "Tidy Operations"
        tidy()

        if ( SHOWMETHODDISCOVERY  == 1 )
            print "Complexity Inspection"
        checkcomplexity()
            

    #Output the arrays

        #output processed lines
        for ( handleccplines = 0; handleccplines < ccpcounter; handleccplines++ ) {
            if ( index (CPPFile[handleccplines,METADATA], "S000?" ) == 0 && trim( CPPFile[handleccplines,METADATA] ) != "" ) {
                currentmetaline = CPPFile[handleccplines,METADATA]
                if (trim(substr ( currentmetaline, 1, index(currentmetaline, ";?F")-1 )) != "" ) {
                    if ( SHOWORIGIN == 1 )
                        print currentmetaline = "\t" currentmetaline >> "OUTFILE.GCB"
                    else
                        print currentmetaline = "\t" (substr ( currentmetaline, 1, index(currentmetaline, ";?F")-1 )) >> "OUTFILE.GCB"
                }
            }
        }

        #show unprocessed lines
        for ( handleccplines = 1; handleccplines < ccpcounter; handleccplines++ ) {
            if ( index (CPPFile[handleccplines,METADATA], "S000?" ) != 0 && trim( CPPFile[handleccplines,METADATA] ) != "" ) {
                print CPPFile[handleccplines,METADATA]   >> "UNPROCESSED.CPP"
                unprocessedlines++
            }
            if ( index (CPPFile[handleccplines,METADATA], ";?F" ) == 0 && trim( CPPFile[handleccplines,METADATA] ) != "" ) {
                print "Line missing origin"   >> "UNPROCESSED.CPP"
                print "      "CPPFile[handleccplines,ORGINALLINE]   >> "UNPROCESSED.CPP"
            }
        }

        if ( unprocessedlines !=0 ) {
            print ""
            print "Inspect UNPROCESSED.CPP as unprocessed lines exist"
        }



    #Show found methods
    #methodsfound()
    #Done
        print ""
        print "Completed"
}

function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
function trim(s)  { return rtrim(ltrim(s)); }

function replace(s,findstr,replacestr) {  
    replaceposition = index ( s, findstr )
    if ( replaceposition == 0)
        return s
    replacements = gsub( findstr,replacestr, s)
    if ( replacements != 1 ) {
        print "Error handling replace() in string " s  " amde to many replacements " replacements
    }
    return s
}
function replacelastschar(s,replacestr) {  
    s = substr( s, 1, length(s)-1)replacestr
    return s
}
function lastcharisleftbrace(s) {

    if ( substr(s, length(trim(s)),1 ) == "{")
        return TRUE
    else
        return FALSE
}
function lastcharisrightbrace(s) {

    if ( substr(s, length(trim(s)),1 ) == "}")
        return TRUE
    else
        return FALSE
}
function findnextmatchingRbraces (s) {

    # the call to here has the array elements at the current brace
    # nextline variable is not shared
    countbraces = 1

    do {
        handleccplines++
    #print "NBrace0: "handleccplines
        nextline = trim(toupper( CPPFile[handleccplines,ORGINALLINE]))
    #print "NBrace1: "nextline
        #dump empty lines as the localsubroutinenumber will fail
        if ( trim( nextline ) == ""  || substr(trim( nextline),1,2 ) == "//"  ) {
            #set localsubroutinenumber = subroutinenumber support loop operation when the first line tested is a empty or a comment 
            localsubroutinenumber = subroutinenumber
            
            continue
        }

        if ( ( index(nextline, "}" ) > 0 ) && ( index(nextline, "ELSE" ) > 0 ) && ( index(nextline, "{" ) > 0 ) ) {                        
            countbraces = countbraces  
        }        
        else if ( index(nextline, "}" ) > 0 && ( index(nextline, "ELSE" ) > 0 ) ) {                        
            countbraces--
        }
        else if ( index(nextline, "{" ) > 0 && ( index(nextline, "ELSE" ) > 0 ) ) {                        
            countbraces++
        }
        else if ( index(nextline, "}" ) > 0  ) {                        
            countbraces--
        }
        else if ( index(nextline, "{" ) > 0  ) {  
            countbraces++
        }  



        localoriginal = CPPFile[handleccplines,METADATA]
    #print "NBrace2: localoriginal="localoriginal
        #extract sub numnber to constrain searching for ;?F3L30S1?
        localoriginal = substr ( localoriginal, index( localoriginal, ";?F" ) + 1)
    #print "NBrace3: localoriginal="localoriginal
        localsubroutinenumber = (substr( localoriginal, index(localoriginal, "S")+1))

        localsubroutinenumber = substr( localsubroutinenumber, 1, index( localsubroutinenumber, "?")-1) * 1
    #print "NBrace4: localsubroutinenumber = " localsubroutinenumber * 1
    #print "NBrace5: countbraces = " countbraces
    } while ( countbraces != 0  &&  handleccplines <= ccpcounter && (s*1) == localsubroutinenumber )
  #print "exit countbraces =" countbraces " ," (countbraces != 0)  ", "  ( handleccplines <= ccpcounter ) ", " ( s == localsubroutinenumber )"," s "," localsubroutinenumber
    
}
function determinemethod ( s ) {

    if ( SHOWMETHODDISCOVERY  == 1 )
        print "Find "s" methods"


    for ( handleccplines = 0; handleccplines < ccpcounter; handleccplines++ ) {
        newline = trim(toupper( CPPFile[handleccplines,ORGINALLINE]))
 
        #if ( index( newline, s ) == 1 && index( newline, "::" ) > 0 ) {
        if ( index( CPPFile[handleccplines,METADATA], "S000") != 0  && index( newline, "::" ) > 0 ) {

            #inrement the subroutine number
            subroutinenumber++
            gsub( "S000", "S"subroutinenumber, CPPFile[handleccplines,METADATA])            
            split( newline, newarray, "::")

            #find scope method.  these will match
            if ( index( newarray[2], newarray[1] ) == 1 ) {
                #change to a void to get converter to handle as a SUB()
                CPPFile[handleccplines,METADATA] = "void "CPPFile[handleccplines,METADATA]
            }

            commentline = 0
            if ( SHOWMETHODDISCOVERY )
                print  "    Found method " newarray[2]
            
            #get the methodname
            split( newarray[2], methodnamearray, "(")

            #find the parameter portion
            match( newarray[2], /\([^:]*\)/ )
            methodnamearray[2] = substr ( newarray[2],RSTART, RLENGTH )

            sub(/\(/, methodnamearray[2],"")
            sub(/\)/, methodnamearray[2],"")

            hasparams = 1
            if ( trim(methodnamearray[2]) == "" )
                hasparams = 0

            if ( checkvarname( methodnamearray[1] ) != "" ) {
                warningcount++
                print "Warning " warningcount ":"
                print " "checkvarname( methodnamearray[1], "method name" )
                print "   " CPPFile[handleccplines,METADATA]
            }

            # add to array of methods
            foundmethods[ foundmethodcounter, NAME ] = methodnamearray[1]
            foundmethods[ foundmethodcounter, POINTER ] = CPPFile[handleccplines,METADATA]
            foundmethods[ foundmethodcounter++, PARAMS ] = methodnamearray[2]
    
            if ( hasparams == 1 ) {
                parameterstring = methodnamearray[2] 
                gsub( "*", "", parameterstring )
                newparamterstring = ""

                methodparameterselements = split ( parameterstring, methodparameters, ", " )
              #print "params = "parameterstring "  "   methodparameters[1]  " & " methodparameters[2] 

                for ( ccount= 1 ; ccount <= methodparameterselements; ccount++ ) {
                    firstparam = trim(substr( methodparameters[ccount],1, index(methodparameters[ccount], " " )))
                    secondparam = trim(substr( methodparameters[ccount], index(methodparameters[ccount], " " )))
 
              #print "1 " methodparameters[ccount] "   `" firstparam"` & "secondparam
                    # go thru the parameter type and find a match
                    for ( idx = 1; idx <= VariantsSupportedIndex; idx++ ) {

                        if (  index (  firstparam,  VariantsSupported[idx, CVARIANTTYPE ] ) > 0 ) {
              #print "2 " idx" firstparam = " firstparam  " Cvariant " VariantsSupported[idx, CVARIANTTYPE ]  " GCBVariant "VariantsSupported[idx, GCBVARIANTTYPE ]
                            newparamterstring = newparamterstring ", " secondparam " as " VariantsSupported[idx, GCBVARIANTTYPE ]    
                            if ( checkvarname( secondparam, "variable name" ) != "" ) {
                                warningcount++
                                print "Warning " warningcount ":"
                                print " "checkvarname( secondparam ,"variable name" )
                                print "   " CPPFile[handleccplines,METADATA]
                            }
    
                        }

                    }
                }
                #remove leading comma
                sub( ", ","",newparamterstring)
                
                #get the parameter string
                parameterstring = trim(methodnamearray[2])  
                #get the metaline
                currentmetaline = toupper(CPPFile[handleccplines,METADATA])
                #replace pointers, else, the replace will fail
                gsub ( "*", "", currentmetaline )

                #replace and update the string with the new GCB type parameter(s)
                sub ( parameterstring, newparamterstring, currentmetaline )
                CPPFile[handleccplines,METADATA] = currentmetaline
             }


 #print "1 "CPPFile[handleccplines,METADATA]
            #count Braces
            countbraces = 0 
            #is there a { on this line? If not the next line must be the start of the code {
            if ( index(CPPFile[handleccplines,METADATA],"{") == 0 )
                handleccplines++


 #print "2 "CPPFile[handleccplines,METADATA]

            #cache array POINTER
            existingpointer = handleccplines
            findnextmatchingRbraces( 0 ) 
 
 #print "idx /"existingpointer " , "handleccplines, CPPFile[existingpointer,METADATA] " to " CPPFile[handleccplines,METADATA]

            for ( idx = existingpointer;idx <= handleccplines;idx++ )
            {
                # walk thru the method until the final brace, but
                # if this is a float method and within the last brace, comment the code out
                    #if ( s == "FLOAT" && idx < handleccplines ) 
                    #    CPPFile[idx,METADATA] = "//" CPPFile[idx,METADATA]
    
                gsub( "S000", "S"subroutinenumber, CPPFile[idx,METADATA])
 #print CPPFile[idx,METADATA]
            }

            

        }
    }

}
function methodsfound() {

    for ( ccount = 0; ccount < foundmethodcounter; ccount++ ) { 
            print ccount, foundmethods[ ccount, NAME ], foundmethods[ ccount, POINTER ]

        }

}
function compilefor() {

    #go thru the code find for-next and handle
    #handleccplines variable is shared across a few methods - it will move to find braces
    for ( handleccplines = 0; handleccplines < ccpcounter; handleccplines++ ) {

        currentline = CPPFile[handleccplines,ORGINALLINE]
        currentmetaline = toupper(CPPFile[handleccplines,METADATA])
        original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
        currentmetaline = substr ( currentmetaline, 1, index(currentmetaline, ";?F")-1 )

        #remove end ; 
        if ( substr ( currentmetaline, length( currentmetaline ) , 1) == ";" ) {
            currentmetaline = substr( currentmetaline, 1, length( currentmetaline )-1)
        }

        #replace all spaces
        gsub (" ", "",currentmetaline)

        #if this a C FOR-next statement
        if ( index ( currentmetaline, "FOR(" ) == 1  ) {
            if  (lastcharisleftbrace( currentmetaline )) {
                #transform FOR(UINT8_TI=0;I<TOREAD;++I){ to dim i as Byte: for i = 0 to toRead

                #split the for-next
                split( currentmetaline, fornextarray, ";")
             
                #handle variable
                varname = substr(currentmetaline, index(currentmetaline, "(")+1, index(currentmetaline,"=")- index(currentmetaline, "(")-1)

                if ( index(currentmetaline, "UINT8_T" ) > 0 ) {
                    typeofvar = BYTEVAR
                    gsub ( "UINT8_T", "", currentmetaline)
                    gsub ( "UINT8_T", "", varname)
                    sub ( "FOR", "Dim "varname " As Byte: For ", currentmetaline )
                    if ( checkvarname( varname ,"variable name"  ) != "" ) {
                        warningcount++
                        print "Warning " warningcount ":"
                        print " "checkvarname( varname ,"variable name" )
                        print "   " CPPFile[handleccplines,METADATA]
                    }

                }
                else if ( index(currentmetaline, "UINT16_T" ) > 0 )  {
                    typeofvar = WORDVAR
                    gsub ( "UINT16_T", "", currentmetaline)
                }
                else {
                    print "For-Next loop variable not converted"
                }
                
            
                gsub("{","",currentmetaline)
                gsub(")","",currentmetaline)
                gsub(/\(/," ",currentmetaline)
                sub(";"," to ",currentmetaline)

                #now try to figure out the range parameter...

                secondparam = fornextarray[2]
                if ( index( secondparam, "<") > 0  ) {
                    sub ( "<","",secondparam)
                    sub ( varname, "", secondparam)

                    secondparam = secondparam "-" 1
                    sub ( fornextarray[2], secondparam, currentmetaline )
                }

                if ( index( fornextarray[3], "++") > 0  ) {
                    #remove any braces etc.
                    sub ( /\(/,"", varname)
                    sub ( /\)/,"", varname)
                    varname = trim(varname)

                    # cut out the C increment parameter
                    currentmetaline = substr( currentmetaline, 1, index(currentmetaline, ";")-1)";"   
                    sub(";"," step 1",currentmetaline)
                    sub("++"," ",currentmetaline)

                }
                else {
                    sub(";"," step ",fornextarray[3])
                    sub("++"," ",currentmetaline)

                }

                #write new line
                CPPFile[handleccplines,METADATA] = currentmetaline";"original

                #extract sub numnber to constrain searching for ;?F3L30S1?
                subroutinenumber = (substr( original, index(original, "S")+1))
                subroutinenumber = substr( subroutinenumber, 1, index( subroutinenumber, "?")-1)

                #now locate matching "}"
                findnextmatchingRbraces(subroutinenumber)

                #get the line 
                currentmetaline = trim(CPPFile[handleccplines,METADATA])
                currentmetaline = replace(currentmetaline, "}", "Next")
                CPPFile[handleccplines,METADATA] = currentmetaline

            }
        
        }
    }
    
    # reinpect... if any for() exist then do the check again
    for ( handleccplines = 0; handleccplines < ccpcounter; handleccplines++ ) {

        currentline = CPPFile[handleccplines,ORGINALLINE]
        currentmetaline = toupper(CPPFile[handleccplines,METADATA])
        original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
        currentmetaline = substr ( currentmetaline, 1, index(currentmetaline, ";?F")-1 )

        #remove end ; 
        if ( substr ( currentmetaline, length( currentmetaline ) , 1) == ";" ) {
            currentmetaline = substr( currentmetaline, 1, length( currentmetaline )-1)
        }

        #replace all spaces
        gsub (" ", "",currentmetaline)

        #if this a C FOR-next statement
        if ( index ( currentmetaline, "FOR(" ) == 1  ) {
                compilefor()
           }
    }

}
function compileif() {

    #go thru the code find if(s) and handle
    #handleccplines variable is shared across a few methods - it will move to find braces

    #ifstate constants
    #IFSTATE_NONE = 0
    #IFSTATE_LOOKING_FOR__OR_END = 1

    ifstate = IFSTATE_NONE

    for ( handleccplines = 0; handleccplines < ccpcounter; handleccplines++ ) {

        currentline = CPPFile[handleccplines,ORGINALLINE]
        currentmetaline = toupper(CPPFile[handleccplines,METADATA])
        original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )

        currentmetaline = substr ( currentmetaline, 1, index(currentmetaline, ";?F")-1 )

        #remove end ; 
        if ( substr ( currentmetaline, length( currentmetaline ) , 1) == ";" ) {
            currentmetaline = substr( currentmetaline, 1, length( currentmetaline )-1)
        }

        #replace all spaces
        gsub (" ", "",currentmetaline)

        #remove end ; 
        if ( substr ( currentmetaline, length( currentmetaline ) , 1) == ";" ) {
            currentmetaline = substr( currentmetaline, 1, length( currentmetaline )-1)
        }


        #if this a C IF statement
        if ( index ( currentmetaline, "IF(" ) == 1  ) {
            #found an if statement, start of GCB Conversion
            #print currentmetaline original

            #change to GCB
            gsub (/IF\(/, "If ", currentmetaline )

            
            if  (lastcharisleftbrace( currentmetaline )) {
                #this is the  multi line if statement handler
                #so, remove end ){ and change to GCB

                if ( COMPILEIFDEBUG ==1  ) {
                    print ""                
                    print "00 ML IF() "currentmetaline" " original
                }

                currentmetaline = replace( currentmetaline, "\){", " Then")

                CPPFile[handleccplines,METADATA] = currentmetaline";"original

                #extract sub numnber to constrain searching for ;?F3L30S1?
                subroutinenumber = (substr( original, index(original, "S")+1))
                subroutinenumber = substr( subroutinenumber, 1, index( subroutinenumber, "?")-1)

                if ( COMPILEIFDEBUG ==1  ) {
                    print "01 " CPPFile[handleccplines,METADATA] " "subroutinenumber                               
                }
                #now locate matching "}"
                findnextmatchingRbraces(subroutinenumber)

                if ( COMPILEIFDEBUG ==1  ) {
                    print "02 " CPPFile[handleccplines,METADATA] " "subroutinenumber
                }
            }
            else {
                if ( COMPILEIFDEBUG ==1  ) {
                    print ""
                    print "03 SL IF() "currentmetaline" " original                
                }
                #single line if
                    currentmetaline = replacelastschar( currentmetaline, " Then")
                    CPPFile[handleccplines,METADATA] = currentmetaline";"original
                    handleccplines++
            }

            #
            #   The intent.
            #   To have just handled the following:
            #       IF ( ) 
            #       IF ( ) {
            #
            # when here the handleccplines should be at the next potential brace or else statement or at the end of the array
            # just a brace then END IF, else if ELSE then change to else and then rehandle
            # 
            #   Arrived here at the next for processing, or, at the end of method. 
            #

            #get the line
                currentline = CPPFile[handleccplines,ORGINALLINE]
                currentmetaline = toupper(CPPFile[handleccplines,METADATA])
                original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
                currentmetaline = trim(substr ( currentmetaline, 1, index(currentmetaline, ";?F")-1 ))
                #remove end ; 
                if ( substr ( currentmetaline, length( currentmetaline ) , 1) == ";" ) {
                    currentmetaline = substr( currentmetaline, 1, length( currentmetaline )-1)
                }           
                #now replace all spaces
                currentmetalinepurged = currentmetaline
                gsub (" ", "",currentmetalinepurged)

            #get the following next line
                nextmetaline = trim(toupper(CPPFile[handleccplines+1,METADATA]))
                #now replace all spaces
                nextmetalinepurged = nextmetaline
                gsub (" ", "",nextmetalinepurged)

            

            


            #
            #   The intent.
            #   To have handled  the next part of the statement
            #                    NEXT PART
            #       IF ( )       locate the ELSE with no braces, 
            #       IF ( ) {     locate a right brace }
            #       IF ( ) {     locate a right brace } with an ELSE
            #       IF ( ) {     locate a right brace } with an ELSE {
            #
            if ( COMPILEIFDEBUG ==1  ) {
                print "10 "currentmetalinepurged";"original "   "
                print "11 *"substr( trim(currentmetalinepurged),1, 6 )"*"
            }

            if (  substr( currentmetalinepurged,1, 6 ) == "}ELSE{" ) {    #single brace so GCB END IF and the next line is NOT an ELSE
                CPPFile[handleccplines,METADATA] = "ELSE;"original
                handleccplines++
                findnextmatchingRbraces(subroutinenumber)
                if ( COMPILEIFDEBUG ==1  ) {
                    print "12 "  trim(CPPFile[handleccplines,METADATA])                   
                }
print "12 "  trim(CPPFile[handleccplines,METADATA])  
                if ( index(trim(CPPFile[handleccplines,METADATA]),"}") == 1 ) {
                    if ( COMPILEIFDEBUG ==1  ) {
                        print "13 add GCB END IF2"
                    }
                    sub( "}", "End If", CPPFile[handleccplines,METADATA] )
                    if ( COMPILEIFDEBUG ==1  ) {
                        print "14 "  CPPFile[handleccplines,METADATA]                
                    }
                }
            }
            else if ( currentmetalinepurged != "ELSE" && index( nextmetalinepurged, "ELSE" ) == 0 ) { 
                # IF() { or IF() - previous line 
                #   a command   therefore NO ELSE  - currentline
                #  a commend therefore also NO ELSE  - nextmetaline
                #
                # update this line to have the GCB END IF

                if ( COMPILEIFDEBUG ==1  ) {
                    print "21 single line if with no ELSE on next line: " currentmetaline
                }

                sub ( "}", "", currentmetaline)
                if ( trim(currentmetaline) == "" ) 
                    CPPFile[handleccplines,METADATA] = "End if;" original
                else
                    CPPFile[handleccplines,METADATA] = currentmetaline": End if;" original
                
                if ( COMPILEIFDEBUG ==1  ) { 
                    print "22 " CPPFile[handleccplines,METADATA]
                }
                #We are done
                continue
            }
            else if (  currentmetaline == "}" && ( ( index(nextmetalinepurged, "ELSE") == 1 ) || ( index(nextmetalinepurged,"ELSE{") == 1 ) ) ) {    #single brace so GCB and the next line is an ELSE or ELSE { = more code
                # IF() {  - previous line
                #   }     - currentline
                #   ELSE or ELSE {  - nextmetaline
                #

                # remove the brace
                if ( COMPILEIFDEBUG ==1  ) {
                    print "31 } with ELSE or ELSE{ on next line: " currentmetaline
                }
                CPPFile[handleccplines,METADATA] = ";" original
                if ( COMPILEIFDEBUG ==1  ) {
                    print "32 " CPPFile[handleccplines,METADATA]              
                    print "33 " nextmetalinepurged "  " index(nextmetalinepurged,"ELSE{")                
                }
                #now locate matching "} this could be on this line or subsequent lines"
                if ( index(nextmetalinepurged,"ELSE{")  ) {
                    #move to next line
                    handleccplines++
                    sub( "{", "", CPPFile[handleccplines,METADATA] )
                    if ( COMPILEIFDEBUG ==1  ) {
                        print "34 "  trim(CPPFile[handleccplines,METADATA])                       
                    }
                    findnextmatchingRbraces(subroutinenumber)
                    if ( COMPILEIFDEBUG ==1  ) {
                        print "35 "  trim(CPPFile[handleccplines,METADATA])                   
                    }
                    if ( index(trim(CPPFile[handleccplines,METADATA]),"}") == 1 ) {
                        if ( COMPILEIFDEBUG ==1  ) {
                            print "36 add GCB END IF"
                        }
                        sub( "}", "End If", CPPFile[handleccplines,METADATA] )
                        if ( COMPILEIFDEBUG ==1  ) {
                            print "37 "  CPPFile[handleccplines,METADATA]
                        }
                    }
                }
            }
            else {
                Print "Compiler IF() failure to handle " currentmetaline""original

            }

        }
    }
    
}
function compilewhile() {

    #go thru the code find while() and handle
    #handleccplines variable is shared across a few methods - it will move to find braces
    for ( handleccplines = 0; handleccplines < ccpcounter; handleccplines++ ) {

        currentline = CPPFile[handleccplines,ORGINALLINE]
        currentmetaline = toupper(CPPFile[handleccplines,METADATA])
        original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
        currentmetaline = substr ( currentmetaline, 1, index(currentmetaline, ";?F")-1 )

        #remove end ; 
        if ( substr ( currentmetaline, length( currentmetaline ) , 1) == ";" ) {
            currentmetaline = substr( currentmetaline, 1, length( currentmetaline )-1)
        }

        #replace all spaces
 #        gsub (" ", "",currentmetaline)

        #if this a C WHILE statement
        if ( index ( currentmetaline, "WHILE(" ) > 0  ) {
            if  (lastcharisleftbrace( currentmetaline )) {

                    currentmetaline = replace( currentmetaline, "{", "")

                    #correct an compression that has happened..
                    currentmetaline = replace( currentmetaline, "WHILE", "\tDo While ")

                    CPPFile[handleccplines,METADATA] = currentmetaline";;"original
                    
                    #extract sub numnber to constrain searching for ;?F3L30S1?
                    subroutinenumber = (substr( original, index(original, "S")+1))
                    subroutinenumber = substr( subroutinenumber, 1, index( subroutinenumber, "?")-1)
                    #print "subroutinenumber="subroutinenumber
                    
                    #now locate matching "}"
                    findnextmatchingRbraces(subroutinenumber)

                    #get the line 
                    currentmetaline = trim(CPPFile[handleccplines,METADATA])
                    currentmetaline = replace(currentmetaline, "}", "\tLoop;")
                    CPPFile[handleccplines,METADATA] = currentmetaline
                
            }
                
        }

        if ( index ( currentmetaline, "DO{" ) == 1  ) {
            if  (lastcharisleftbrace( currentmetaline )) {

                    currentmetaline = replace( currentmetaline, "{", "")
                    
                    CPPFile[handleccplines,METADATA] = currentmetaline";;"original
                    
                    #extract sub numnber to constrain searching for ;?F3L30S1?
                    subroutinenumber = (substr( original, index(original, "S")+1))
                    subroutinenumber = substr( subroutinenumber, 1, index( subroutinenumber, "?")-1)
                    #print "subroutinenumber="subroutinenumber
                    
                    #now locate matching "}"
                    findnextmatchingRbraces(subroutinenumber)

                    #get the line 
                    currentmetaline = trim(CPPFile[handleccplines,METADATA])
                    original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
                    currentmetaline = toupper(substr ( currentmetaline, 1, index(currentmetaline, ";?F")-1 ))

                    #In C there are two case one with WHILE on same line and one with WHILE on next line.

                    #replace all spaces
                    gsub (" ", "",currentmetaline)
                    
                    nextmetaline = toupper(CPPFile[handleccplines+1,METADATA])
                    gsub (" ", "",nextmetaline)

                    if  (lastcharisrightbrace( currentmetaline )  && index ( nextmetaline, "WHILE(") > 0  ) {
                        # use concat in GCB to fix the While statement
                        currentmetaline = replace(currentmetaline, "}", "Loop _ ;")
                        CPPFile[handleccplines,METADATA] = currentmetaline original
                    } 
                    else if  ( index ( currentmetaline, "}WHILE") > 0 ) {
                        currentmetaline = replace(currentmetaline, "}WHILE", "Loop While")
                        CPPFile[handleccplines,METADATA] = currentmetaline original
                    }            
            }
                
        }
    }

}
function compile12c() {
   
    #go thru the code find wire commands
    #handleccplines variable is shared across a few methods - it will move to find braces

    I2CState = STOPPED

    for ( handleccplines = 0; handleccplines < ccpcounter; handleccplines++ ) {

        currentline = CPPFile[handleccplines,ORGINALLINE]
        currentmetaline = toupper(CPPFile[handleccplines,METADATA])
        original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
        currentmetaline = substr ( currentmetaline, 1, index(currentmetaline, ";?F")-1 )

        #remove end ; 
        if ( substr ( currentmetaline, length( currentmetaline ) , 1) == ";" ) {
            currentmetaline = substr( currentmetaline, 1, length( currentmetaline )-1)
        }

        #replace all spaces
        gsub (" ", "",currentmetaline)

        
        #if this a WIRE statement
        if ( index ( currentmetaline, "WIRE." ) > 0  || index ( currentmetaline, "I2C." ) > 0   ) {
    
            if ( index ( currentmetaline , "WIRE.BEGIN") > 0 ){
                currentmetaline = "// removed by conversion - "currentmetaline";"original
                I2Creadnumberofbytesstring = "UNDEFINE VARIABLE"
            }
            else if ( index ( currentmetaline , "WIRE.SETCLOCK") > 0 ){
                currentmetaline = "// removed by conversion - "currentmetaline";"original
            }
            else if ( index ( currentmetaline , "WIRE.WRITE") > 0 ){  #WIRE.WRITE(ADDRESS) {
                if ( I2CState == STOPPED ) {
                    sub( "WIRE.WRITE", "HI2CSEND", currentmetaline)
                    currentmetaline = "HI2CSTART: "currentmetaline";"original
                    I2CState = STARTED
                }
                else {
                    sub( "WIRE.WRITE", "HI2CSEND", currentmetaline)
                    currentmetaline = currentmetaline";"original
                }
            }  
            else if ( index ( currentmetaline , "WIRE.ENDTRANSMISSION(") > 0  && index ( currentmetaline , "FALSE") == 0  ){
                currentmetaline = "HI2CSTOP;"original
                I2CState = STOPPED
            }
            else if ( index ( currentmetaline , "WIRE.ENDTRANSMISSION(") > 0  && index ( currentmetaline , "FALSE") != 0  ){
                currentmetaline = "HI2CRESTART;"original
                I2CState = STARTED
            }            
            else if ( index ( currentmetaline , "WIRE.REQUESTFROM") > 0 && index ( currentmetaline , ",1") != 0 ){  #read one byte from 12c hence the ,1 test

                sub( "WIRE.REQUESTFROM", "HI2CSEND", currentmetaline )
                sub( ",1", "", currentmetaline)
                if ( I2CState = STARTED ) {
                    currentmetaline = currentmetaline";"original
                }
                else {
                    currentmetaline = "HI2CRESTART: "currentmetaline";"original
                }
                I2CState = STOPPED
            } 
            else if ( index ( currentmetaline , "WIRE.REQUESTFROM") > 0 && index ( currentmetaline , ",1") == 0 ){  #read more than one byte from 12c

                #this updates 'I2Creadnumberofbytesstring' variable - used in the REPEAT routine
                sub( "WIRE.REQUESTFROM", "HI2CSEND", currentmetaline )
                #remove any [CAST] byte definition in the C
                sub( /\(UINT8_T\)/, "", currentmetaline )

                I2Creadnumberofbytesstring = substr ( currentmetaline, index( currentmetaline, "," )+1, index( currentmetaline, ")") - index( currentmetaline, "," )-1 ) 
                
                sub( ","I2Creadnumberofbytesstring, "", currentmetaline)
                if ( I2CState = STARTED ) {
                    currentmetaline = currentmetaline";"original
                }
                else {
                    currentmetaline = "HI2CRESTART: "currentmetaline";"original
                }
                
                I2CState = STARTED
            }
            else if ( index ( currentmetaline , "WIRE.READ") > 0 && index ( currentmetaline , "RETURN") > 0 ){  #read one byte and return value to function

                #extract sub numnber to constrain searching for ;?F3L30S1?
                subroutinenumber = (substr( original, index(original, "S")+1))
                subroutinenumber = substr( subroutinenumber, 1, index( subroutinenumber, "?")-1)-1

                sub( "RETURN", "HI2CRECEIVE ( I2cByte): "foundmethods[ subroutinenumber, NAME ]" = I2cByte: HI2CSTOP", currentmetaline ) 
                sub( /WIRE.READ\(\)/, "", currentmetaline )              
                currentmetaline = currentmetaline";"original
                I2CState = STOPPED
            } 
            else if ( index ( currentmetaline , "WIRE.AVAILABLE()") > 0 ) {
                currentmetaline = "Dim idx as Byte: idx = 0: "currentmetaline
                sub ( /WIRE.AVAILABLE\(\)/,  "idx < "I2Creadnumberofbytesstring, currentmetaline )
                currentmetaline = currentmetaline";"original
                if ( I2CMessage == 0 ) {
                    warningcount++
                    print "Warning " warningcount ":"
                    print "   Write read inspection required - HI2CStop for buffer read"
                    print "   GCBBASIC Code               ;Original Source reference"
                    print "         "currentmetaline
                    I2CMessage = 1
                }
            }  
            else if ( index ( currentmetaline , "=WIRE.READ()") > 0 ) {
                sub( /=WIRE.READ\(\)/, "", currentmetaline )  
                currentmetaline = "HI2CRECEIVE("currentmetaline", ACK )"
                # handle increments in functions
                if ( index( currentmetaline, "++") > 0 ) {
                    sub ( "++", "", currentmetaline )
                    currentmetaline = currentmetaline" : idx++"
                }
                currentmetaline = currentmetaline";"original
                warningcount++
                print "Warning " warningcount ":"                
                print "   Write read inspection required - ACK specified, however, some I2C devices require NACK for last byte requesed by MASTER"
                print "   GCBBASIC Code               ;Original Source reference"
                print "         "currentmetaline
            }
            else if ( index ( currentmetaline , "I2C.") > 0 ) {

                sub( "I2C.", "HI2C", currentmetaline )
                sub( /HI2CWRITE/, "HI2CSEND", currentmetaline )
                currentmetaline = currentmetaline";"original

            }       
            else {
                print currentmetaline
                currentmetaline = currentmetaline" //unhandled i2c;"original
                print currentmetaline  >> "UNPROCESSED.CPP"
            }
            CPPFile[handleccplines,METADATA] = currentmetaline
        }
    }
}
function compilevariables() {  
    
 #go thru the code find while() and handle
    #handleccplines variable is shared across a few methods - it will move to find braces
    for ( handleccplines = 0; handleccplines < ccpcounter; handleccplines++ ) {

        currentline = CPPFile[handleccplines,ORGINALLINE]
        currentmetaline = toupper(CPPFile[handleccplines,METADATA])
        original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
        currentmetaline = trim(substr ( currentmetaline, 1, index(currentmetaline, ";?F")-1 ))

        #remove end ; 
        if ( substr ( currentmetaline, length( currentmetaline ) , 1) == ";" ) {
            currentmetaline = substr( currentmetaline, 1, length( currentmetaline )-1)
        }

        #replace all spaces
        #gsub (" ", "",currentmetaline)

        if ( index ( currentmetaline, "UINT8_T" ) > 0 && index ( currentmetaline, "=" ) > 0 ) {
         #  print ""
         #  print "1"currentmetaline, currentline

            #find the variable by find the = then walk backwards to find the space
            equallocation = index ( currentmetaline , "=") 
            for ( ccount = equallocation ; ccount> 0; ccount--) {
                if ( substr ( currentmetaline, ccount, 1 ) == " " ) {
                    priorspacelocation = ccount
                }
            }
            variablename = substr( currentmetaline, priorspacelocation, equallocation - priorspacelocation )
            # remove any leading brace
            sub ( /\(/, "", variablename)
         #print  variablename

            # now remove the variable
            sub ( variablename, "", currentmetaline)
         #  print "2"currentmetaline
            sub ( "UINT8_T", "", variablename)
            sub ( "=", "", variablename)
            
        #   print "    "variablename
            currentmetaline = "Dim "variablename " As Byte: "variablename " = " currentmetaline";"original
            if ( checkvarname( variablename ,"variable name" ) != "" ) {
                warningcount++
                print "Warning " warningcount ":"
                print " "checkvarname( variablename ,"variable name" )
                print "   " CPPFile[handleccplines,METADATA]
            }
            
            CPPFile[handleccplines,METADATA] = currentmetaline
            
        }
        else if ( index ( currentmetaline, "UINT8_T" ) > 0 && index ( currentmetaline, "=" ) == 0 && index ( currentmetaline, "::" ) == 0) {
 
            sub ( "UINT8_T", "", currentmetaline)
            if ( checkvarname( currentmetaline, "variable name" ) != "" ) {
                warningcount++
                print "Warning " warningcount ":"
                print " "checkvarname( currentmetaline ,"variable name" )

            }
            currentmetaline = " Dim "currentmetaline " As Byte;"original
            CPPFile[handleccplines,METADATA] = currentmetaline
            
        }
        else if ( index ( currentmetaline, "(UINT16_T)" ) > 0 ) {  #  = is the 16bit value cast
                sub ( /\(UINT16_T\)/, "[WORD]", currentmetaline )
                CPPFile[handleccplines,METADATA] = currentmetaline";"original
        }

        else if ( index ( currentmetaline, "UINT16_T" ) > 0 ) {  #  = is the 16bit value an assigned unint blabla =
                currentmetaline = currentmetaline" //unhandled variable;"original
                print currentmetaline  >> "UNPROCESSED.CPP"
        }

    }

}
function compilelogic() {

    #go thru the code find for-next and handle
    #handleccplines variable is shared across a few methods - it will move to find braces
    for ( handleccplines = 0; handleccplines < ccpcounter; handleccplines++ ) {

        currentline = CPPFile[handleccplines,ORGINALLINE]
        currentmetaline = toupper(CPPFile[handleccplines,METADATA])
        original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
        currentmetaline = substr ( currentmetaline, 1, index(currentmetaline, ";?F")-1 )

        #remove end ; 
        if ( substr ( currentmetaline, length( currentmetaline ) , 1) == ";" ) {
            currentmetaline = substr( currentmetaline, 1, length( currentmetaline )-1)
        }

        # work thru the maths changes
        if ( index(currentmetaline,"!=") > 0  ) {
            gsub( "!=", "<>", currentmetaline)
        }

        if ( index(currentmetaline,"~") > 0  ) {
            gsub( "~", "!", currentmetaline)
        }

        if ( index(currentmetaline,">>") > 0  ) {
            gsub( ">>", "/", currentmetaline)
        }

        if ( index(currentmetaline,"<<") > 0  ) {
            gsub( "<<", "*", currentmetaline)
        }

        if ( index(currentmetaline,"|=") > 0  ) {
            destinationvar = substr ( currentmetaline, 1, index( currentmetaline, "|=") -1 )
            sub( /\|\=/, "OR", currentmetaline)
            currentmetaline = trim(destinationvar)" = "trim(currentmetaline)
        } 

        
        if ( index(currentmetaline,"&=") > 0  ) {
            destinationvar = substr ( currentmetaline, 1, index( currentmetaline, "&=") -1 )
            sub( /\&\=/, "AND", currentmetaline)
            currentmetaline = trim(destinationvar)" = "trim(currentmetaline)
        } 

        CPPFile[handleccplines,METADATA] = currentmetaline";"original
    }

}
function compileexit() {
}
function compilereturn() {
}
function addvars() {
}
function tidy() {

    #need to process this three times to ensure we have every meth
    for ( ccount = 0; ccount < 4; ccount++ ) {

        for ( handleccplines = 0; handleccplines < ccpcounter; handleccplines++ ) {

            currentline = CPPFile[handleccplines,ORGINALLINE]
            currentmetaline = toupper(CPPFile[handleccplines,METADATA])
            original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
            
            if ( index(currentmetaline, "DIM") > 0 && index(currentmetaline, "ASBYTE") > 0 ) {
                sub( "DIM", "DiM ", currentmetaline)
                sub( "ASBYTE", " AS BYTE", currentmetaline)
                CPPFile[handleccplines,METADATA] = currentmetaline";"original 
            }

            if ( index(currentmetaline, "} ELSE {") > 0  ) {
                sub( "} ELSE {", "ELSE", currentmetaline)
                CPPFile[handleccplines,METADATA] = currentmetaline";"original 
            }
            

            if ( index( currentmetaline,"[") ) {
                sub(/\[/,"(", currentmetaline)
            }
            if ( index( currentmetaline,"]") ) {
                sub(/\]/,")", currentmetaline)
            }
            CPPFile[handleccplines,METADATA] = currentmetaline 

            if ( index( currentmetaline, "BOOL") == 1 ) {
                sub( "BOOL", "", currentmetaline )
                
                #remove the leading C style nameing up the ::
                currentmetaline = "Function "substr(currentmetaline, index(currentmetaline,"::" )+2)
                
                CPPFile[handleccplines,METADATA] = currentmetaline
   
                #find method {, could be on this line of the next
                if ( index ( currentmetaline, "{") != 0 ) {
                    sub ("{", "", CPPFile[handleccplines,METADATA])
                }
                else {
                    sub ("{", "", CPPFile[handleccplines+1,METADATA])
                    #Move to next line.  A brace, then match, then, GCB end function
                    handleccplines++
                }

                currentline = CPPFile[handleccplines,ORGINALLINE]
                currentmetaline = toupper(CPPFile[handleccplines,METADATA])
                original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
                #extract sub numnber to constrain searching for ;?F3L30S1?
                subroutinenumber = (substr( original, index(original, "S")+1))
                subroutinenumber = substr( subroutinenumber, 1, index( subroutinenumber, "?")-1)
                #now locate matching "}"
            
                findnextmatchingRbraces(subroutinenumber)
                #get the line
                sub ("}", "End Function", CPPFile[handleccplines,METADATA])
            }

            if ( index( currentmetaline, "UINT8_T") == 1 ) {
                sub( "UINT8_T", "", currentmetaline )
                currentmetaline = "Function "substr( currentmetaline, index( currentmetaline,"::")+2)
                original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
                currentmetaline = substr ( currentmetaline, 1, index(currentmetaline, ";?F")-1 )" as Byte;"original
                CPPFile[handleccplines,METADATA] = currentmetaline
            
                sub ("{", "", CPPFile[handleccplines+1,METADATA])

                #find method {, could be on this line of the next
                if ( index ( currentmetaline, "{") != 0 ) {
                    sub ("{", "", CPPFile[handleccplines,METADATA])
                }
                else {
                    sub ("{", "", CPPFile[handleccplines+1,METADATA])
                    #Move to next line.  A brace, then match, then, GCB end function
                    handleccplines++
                }

                currentline = CPPFile[handleccplines,ORGINALLINE]
                currentmetaline = toupper(CPPFile[handleccplines,METADATA])
                original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
                #extract sub numnber to constrain searching for ;?F3L30S1?
                subroutinenumber = (substr( original, index(original, "S")+1))
                subroutinenumber = substr( subroutinenumber, 1, index( subroutinenumber, "?")-1)
                #now locate matching "}"
                findnextmatchingRbraces(subroutinenumber)
                #get the line 
                sub ("}", "End Function", CPPFile[handleccplines,METADATA])
            }

            if ( index( currentmetaline, "VOID") == 1 ) {
    
                sub( "VOID", "", currentmetaline )
                currentmetaline = "Sub "substr( currentmetaline, index( currentmetaline,"::")+2)
                CPPFile[handleccplines,METADATA] = currentmetaline  
                
                sub ("{", "", CPPFile[handleccplines+1,METADATA])

                #extract sub numnber to constrain searching for ;?F3L30S1?
                #Move to next line.  A brace, then match, then, GCB end function
                #find method {, could be on this line of the next
                if ( index ( currentmetaline, "{") != 0 ) {
                    sub ("{", "", CPPFile[handleccplines,METADATA])
                }
                else {
                    sub ("{", "", CPPFile[handleccplines+1,METADATA])
                    #Move to next line.  A brace, then match, then, GCB end function
                    handleccplines++
                }

                currentline = CPPFile[handleccplines,ORGINALLINE]
                currentmetaline = toupper(CPPFile[handleccplines,METADATA])
                original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
                subroutinenumber = (substr( original, index(original, "S")+1))
                subroutinenumber = substr( subroutinenumber, 1, index( subroutinenumber, "?")-1)
                #now locate matching "}"
                findnextmatchingRbraces(subroutinenumber)
                #get the line 
                sub ("}", "End Sub", CPPFile[handleccplines,METADATA])
            }


            if ( index( currentmetaline, "FLOAT") == 1 ) {
    
                sub( "FLOAT", "", currentmetaline )
                currentmetaline = "Sub "substr( currentmetaline, index( currentmetaline,"::")+2)
                CPPFile[handleccplines,METADATA] = currentmetaline  

                warningcount++
                print "Warning " warningcount ":"                
                print "    Float method found - examine and adapt for GCBASIC"
                print "         "CPPFile[handleccplines,ORGINALLINE] " - " currentmetaline

                sub ("{", "", CPPFile[handleccplines+1,METADATA])

                #extract sub numnber to constrain searching for ;?F3L30S1?
                #Move to next line.  A brace, then match, then, GCB end function
                handleccplines++
                currentline = CPPFile[handleccplines,ORGINALLINE]
                currentmetaline = toupper(CPPFile[handleccplines,METADATA])
                original = substr ( currentmetaline, index(currentmetaline, ";?F")+1, length( currentmetaline ) )
                subroutinenumber = (substr( original, index(original, "S")+1))
                subroutinenumber = substr( subroutinenumber, 1, index( subroutinenumber, "?")-1)
                #now locate matching "}"
                findnextmatchingRbraces(subroutinenumber)
                #get the line 
                sub ("}", "End Sub", CPPFile[handleccplines,METADATA])
            }
                 

        }
    }
}
function checkvarname(s,n) {

    VariableASMClashCount = split ( VariableASMClash, VariablesASMClash, "|")
    #print "VariableASMClashCount " VariableASMClashCount
    for ( dcount = 1; dcount <= VariableASMClashCount; dcount++ ) {
        #print dcount " "trim(toupper(VariablesASMClash[dcount])) "," trim(toupper(s)) 
        if ( trim(toupper(VariablesASMClash[dcount])) == trim(toupper(s)) ) {
            return "ASM Error - rename " n " manually in GCBBASIC Source " s
        }
    }
    return "" 
}

function checkcomplexity() {

    TooComplexArrayCount = split(TooComplex, TooComplexArray, "|")

    for ( dcount = 1; dcount <= TooComplexArrayCount; dcount++ ) {

        for ( handleccplines = 0; handleccplines < ccpcounter; handleccplines++ ) {

            currentline = CPPFile[handleccplines,ORGINALLINE]
            currentmetaline = toupper(CPPFile[handleccplines,METADATA])

            if ( index( currentmetaline ,  trim(toupper(TooComplexArray[dcount])) ) > 0 ) {
                                warningcount++
                print "Warning " warningcount ":"
                print "   To complex - rewrite GCBASIC source" 
                print "     " trim(CPPFile[handleccplines,METADATA])

            }
        }
    }
     
}