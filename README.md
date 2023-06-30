# Great-Cow-BASIC

This GIT contains the latest user contributed demonstrations. 

The baseline set of demonstrations was created at version 1.00.xx of the GCBASIC distrubution.

Please add your demonstrations and improve those that have been posted.

Enjoy


# Documentation of Demonstration Programs

Key Point: Try to provide a complete reference, describing all relevant aspects of the demonstration, and putting code-related terms in code font.

When you are documenting a demonstration, provide a complete reference, typically generated from source code using documentation comments that describe all public constants, methods, local constants, and other variables.

Use the basic guidelines in this document as appropriate for the GCBASIC language.

This page also does not cover libraries.   The style suggestions below may be useful to keep in mind while documenting GCBASIC demonstrations.   Libraries are covered by a Library Developer Guide.

# Overall Program Layout

This is the standard program. This is included in every GCBASIC installation.  See IDE/Snippets.

----
    '''A program  for GCGB and GCB the demonsations......
    '''--------------------------------------------------------------------------------------------------------------------------------
    '''This program [todo] a decription of the demonstration
    '''
    '''@author     [todo]
    '''@licence    GPL
    '''@version    [todo]
    '''@date       [todo]
    '''********************************************************************************

    ; ----- Configuration
     #chip [todo]
     #config [todo]
     #include [todo]

     #option explicit
     
    ; ----- Constants
      ' No Constants specified in this example.
      ' [todo]

    ; ----- Define Hardware settings
      ' [todo]

    ; ----- Variables
      ' No Variables specified in this example. All byte variables are defined upon use.
      ' [todo]

    ; ----- Quick Command Reference:
      [todo]

    ; ----- Main body of program commences here.

    end
    ; ----- Support methods.  Subroutines and Functions
----

The template should be completed with the sections marked `[todo]` being updated as appropiate.

The header is strict.  Great Cow Graphical BASIC and GCBASIC test routines use the header to determine parameters and key information.

# Language Style

It is *Great Cow BASIC* always not any variant. 

The license is for GCBASIC and not any other variant.

Do not use slang and do not use contractions - for example use `do not` do not use `don't`.  GCBASIC users may not have English as their first language.

Use microcontroller not `part`, `chip`, `pic` or any other variant.

# Method Support for Peripheral Programming Support (PPS)

The PPS method needs to go at the top of the program.

The PPS method must show the version of the PPSTool used to generate the method.

Porting to another microcontroller is easier as the user can locate the PPS method and modify or remove.

# Coding Good Practice

The GCBASIC demonstration must provide a description for each of the following:
 - Every constant, variable,  etc.
 - Every method, with a description for each parameter, the return value, and any exceptions thrown.

`#option explicit` should be used to ensure all variables are defined.

Variables should be defined to respresent the variable type such as myADCValueByte, myOutPutString etc.

Placing a `Do forever-loop` at the end of the program is a good practice.  Serial transmission can be messed up if the program executes ‘end’ before the completion of a serial transmssion.

All serial communications need to be at 9600 BPS. Assume a standard dumb terminal with no suport for ANSI etc.


Enjoy


Change log.
1.  First release.  A dump of an email to this document.
2.  Added Strict header
3.  Fixed some typos
