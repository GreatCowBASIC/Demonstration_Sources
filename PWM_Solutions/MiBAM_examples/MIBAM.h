'***************************************************************************
'*               __  __  _____  ____          __  __                       *
'*              |  \/  ||_   _||  _ \   /\   |  \/  |                      *
'*              | \  / |  | |  | |_) | /  \  | \  / |                      *
'*              | |\/| |  | |  |  _ < / /\ \ | |\/| |                      *
'*  /            | |  | | _| |_ | |_) / ____ \| |  | |                      *
'*              \_|  |_||_____||____/_/    \_\_|  |_|                      *
'*                Mirror Imaged Bit Angle Modulation                       *
'***************************************************************************
'*  Name    : MIBAM.h                                                                           *
'*  Author  : Evan R. Venn with the works of Darrel Taylor                                      *
'*  Date    : 13/07/2023                                                                        *
'*  Version : 0.1                                                                               *
'*  Notes   : for more information about MIBAM, see this thread ...                             *
'*          : http://www.picbasic.co.uk/forum/showthread.php?t=7393                             *
'*          : https://sourceforge.net/p/gcbasic/discussion/579125/thread/08ccd19fed/?limit=25   *
'************************************************************************************************
#option Explicit

    Dim BAM_Buffers(BAM_COUNT)
    Dim BAM_Initializing
    Dim BAM_CylonMask        
    Dim BAM_NextTimerLoad as Word  
    Dim BAM_Flags       
    Dim BAM_DIRECTION       as BIT

    #DEFINE BAMLEFT     0
    #DEFINE BAMRIGHT    1



    #SCRIPT
        BAM_RELOADCOUNT =  10         
        BAM_LATENCY     = 56
        BAM_EXITLATENCY = 56
        
        TimerCount = ((BAM_COUNT*6)+Pass0+BAM_LATENCY+BAM_EXITLATENCY+BAM_RELOADCOUNT+1)*64
        // warning TIMERCOUNT

        BAM_Freq = (CHIPMhz*1000000/4)/(TimerCount*4)
        
        // Calculate Periods
        BAM_PERIOD7 =  INT(TIMERCOUNT         -BAM_RELOADCOUNT)
        BAM_PERIOD6 =  INT((TIMERCOUNT / 2 )  -BAM_RELOADCOUNT)
        BAM_PERIOD5 =  INT((TIMERCOUNT / 4)   -BAM_RELOADCOUNT)
        BAM_PERIOD4 =  INT((TIMERCOUNT / 8)   -BAM_RELOADCOUNT)
        BAM_PERIOD3 =  INT((TIMERCOUNT / 16)  -BAM_RELOADCOUNT)
        BAM_PERIOD2 =  INT((TIMERCOUNT / 32)  -BAM_RELOADCOUNT)
        BAM_PERIOD1 =  INT((TIMERCOUNT / 64)  -BAM_RELOADCOUNT)
        BAM_PERIOD0 =  INT((TIMERCOUNT / 128) -BAM_RELOADCOUNT)
        // warning BAM_PERIOD7
        // warning BAM_PERIOD6
        // warning BAM_PERIOD5
        // warning BAM_PERIOD4
        // warning BAM_PERIOD3
        // warning BAM_PERIOD2
        // warning BAM_PERIOD1
        // warning BAM_PERIOD0
        
        

    #ENDSCRIPT


    Macro BAM_PIN  ( In BAM_Port_Pin, in BAM_DutyVar, in BAM_ElementAddress )
        // HSerPrint BAM_Port_Pin
        // HSerSend 9
        // HSerPrint BAM_DutyVar
        // HSerSend 9
        // HserPrintByteCRLF BAM_Initializing
        
        // HSerPrintStringCRLF "1*************************************"
        // For myInit = 0 to 7
        //     hserPrint BAM_Buffers(myInit+1)
        //     HSerSend 9
        // Next
        // HserPrintCRLF 
        // HSerPrintStringCRLF "2************************************"
        
        // wait 100 ms
        
        Select Case BAM_Initializing
            Case 1                                          ;--Mode 1 - Initialize--------
                BAM_Buffers( BAM_ElementAddress ) = BAM_DutyVar
                BAM_PINCOUNT = BAM_PINCOUNT + 1
                BAM_Port_Pin = 0                                ; Make Port.Pin LOW
                Dir BAM_Port_Pin Out                            ; Set to output
            Case 0                                          ;--Mode 0 - BAM out-----------
                // HserPrintByteCRLF BAM_CylonMask
                Dim BAM_Temp
                BAM_Temp =  BAM_Buffers( BAM_ElementAddress )
                if BAM_Temp.BAM_CylonMask = 1 then
                    BAM_Port_Pin = 1
                else
                    BAM_Port_Pin = 0
                end if
            Case 2                                      ;--Mode 2 - Copy Dutyvar------
                // BAM_DutyVar = BAM_Buffers( BAM_ElementAddress)
                BAM_Buffers( BAM_ElementAddress) = BAM_DutyVar 
            
        End Select

        // For myInit = 0 to 7
        //     hserPrint BAM_Buffers(myInit+1)
        //     HSerSend 9
        // Next
        // HserPrintCRLF 
        // HSerPrintStringCRLF "3************************************"

    End Macro

    ;___________________________________________________________________________

    Sub BAM_INIT()

        BAM_CylonMask = 128
        BAM_DIRECTION = BAMRIGHT
        BAM_PINCOUNT = BAM_COUNT
        BAM_Initializing  = 1
        BAM_LIST                       ; Calls BAM_PIN indirectly. Set BAM pins to Output LOW
        BAM_Initializing  = 0

        Dim BAM_IninitalPass as Bit
        BAM_IninitalPass = 1

        BAM_NextTimerLoad = BAM_PERIOD0
        On Interrupt Timer1Overflow Call BAM_ISR
        InitTimer1 OSC, PS_1_64
        StartTimer 1

    End Sub


    ;----[Interrupt handler for BAM-BAM]----------------------------------------
    Sub BAM_ISR


        StopTimer 1                          ; Stop the Timer
        // HserPrint BAM_CylonMask
        // HSerSend 9
        // HserPrint Timer1
        // HserPrint "  "
        Timer1 = Timer1 - BAM_NextTimerLoad     ; subtract the BAM_ReloadCount value
        // HserPrint Timer1
        // HserPrintCRLF
        
        StartTimer 1                          ; Start the Timer



        If BAM_DIRECTION = BAMLEFT Then               ; If BAM_DIRECTION = 0 Then
            ScanLeft:
                If BAM_IninitalPass = 1 Then
                    'First pass
                    BAM_IninitalPass = 0
                Else
                    Set C Off
                    Rotate BAM_CylonMask Left
                    If C = 1 Then
                        BAM_CylonMask = 128 
                        BAM_DIRECTION = BAMRIGHT
                        BAM_Initializing = 2
                        // BAM_LIST                               ; copy DutyVar to WorkingVar
                        BAM_Initializing = 0         
                    End if
                End if
        Else
            ScanRight:                                     ;   sending MSB first
                If BAM_IninitalPass = 1 Then
                    'First pass
                    BAM_IninitalPass = 0
                Else
                    'Normal operations
                    Set C OFF   
                    ROTATE BAM_CylonMask Right
                    If C = 1 Then
                        BAM_CylonMask = 1
                        BAM_DIRECTION = BAMLEFT
                    end if
                End if
        End if

        BAM_LIST                            ; set all BAM bits    

        If BAM_CylonMask.0 = 1  Then
            BAM_NextTimerLoad = BAM_PERIOD0
            Else If BAM_CylonMask.1 = 1 Then
                BAM_NextTimerLoad = BAM_PERIOD1
                Else If BAM_CylonMask.2 = 1 Then
                    BAM_NextTimerLoad = BAM_PERIOD2
                    Else If BAM_CylonMask.3 = 1 Then
                        BAM_NextTimerLoad = BAM_PERIOD3
                        Else If BAM_CylonMask.4 = 1 Then
                            BAM_NextTimerLoad = BAM_PERIOD4
                            Else If BAM_CylonMask.5 = 1 Then
                                BAM_NextTimerLoad = BAM_PERIOD5
                                Else If BAM_CylonMask.6 = 1 Then
                                    BAM_NextTimerLoad = BAM_PERIOD6
                                    Else If BAM_CylonMask.7 = 1 Then
                                        BAM_NextTimerLoad = BAM_PERIOD7
        End If
    End Sub


