# 16F17126 Demos for Great-Cow-BASIC

![A 16F17126](medium-PIC16F17126-TSSOP-14.png)


# Great-Cow-BASIC

This GIT contains the latest demonstrations.

The baseline set of demonstrations was created at version 1.00.xx of the Great Cow BASIC distribution.

Enjoy


# Overall Demo Layout

This is the standard program. This is included in every Great Cow BASIC installation.  See IDE/Snippets.

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


# Method Support for Peripheral Programming Support (PPS)

The PPS method needs to go at the top of the program.

The PPS method must show the version of the PPSTool used to generate the method.

Porting to another microcontroller is easier as the user can locate the PPS method and modify or remove.
