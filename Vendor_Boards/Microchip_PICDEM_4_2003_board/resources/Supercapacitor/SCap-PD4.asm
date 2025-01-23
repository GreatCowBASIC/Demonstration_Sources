;********************************************************************
;*
;*  The device checks for availibility of power. In absence of
;*  power device operates in sleep and toogles one port pin every
;*  second. Another port pin indicates the status of power
;*
;********************************************************************
;*
;* FileName:        SCap-PD4.asm
;* Dependencies:    p16F1320.inc
;* Processor:       PIC18F1320
;* Compiler:        MPLAB 6.10.0
;* Company:         Microchip Technology, Inc.
;
;* Software License Agreement
;
;* The software supplied herewith by Microchip Technology Incorporated
;* (the "Company") for its PICmicro® Microcontroller is intended and
;* supplied to you, the Company's customer, for use solely and
;* exclusively on Microchip PICmicro Microcontroller products. The
;* software is owned by the Company and/or its supplier, and is
;* protected under applicable copyright laws. All rights are reserved.
;* Any use in violation of the foregoing restrictions may subject the
;* user to criminal sanctions under applicable laws, as well as to
;* civil liability for the breach of the terms and conditions of this
;* license.
;
;* THIS SOFTWARE IS PROVIDED IN AN "AS IS" CONDITION. NO WARRANTIES,
;* WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED
;* TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
;* PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. THE COMPANY SHALL NOT,
;* IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL OR
;* CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
;
;* Author               Date            Comment
;*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;* Gaurang Kavaiya     Apr 08, 2003    Initial Release (V1.0)
;*
;********************************************************************/


        include "P18F1320.inc"


        __CONFIG        _CONFIG1H, _IESO_ON_1H & _FSCMEN_OFF_1H & _INTIO2_OSC_1H
        __CONFIG        _CONFIG2L, _BOR_OFF_2L & _BORV_20_2L & _PWRT_OFF_2L
        __CONFIG        _CONFIG2H, _WDT_OFF_2H & _WDTPS_1_2H
        __CONFIG        _CONFIG3H, _MCLRE_ON_3H
        __CONFIG        _CONFIG4L, _STVR_ON_4L & _LVP_OFF_4L & _BKBUG_OFF_4L
        __CONFIG        _CONFIG5L, _CP0_OFF_5L & _CP1_OFF_5L
        __CONFIG        _CONFIG5H, _CPB_OFF_5H & _CPD_OFF_5H
        __CONFIG        _CONFIG6L, _WRT0_OFF_6L & _WRT1_OFF_6L
        __CONFIG        _CONFIG6H, _WRTC_OFF_6H & _WRTB_OFF_6H & _WRTD_OFF_6H
        __CONFIG        _CONFIG7L, _EBTR0_OFF_7L & _EBTR1_OFF_7L
        __CONFIG        _CONFIG7H, _EBTRB_OFF_7H



#define         RAM0_INIT       0x00            ;RAM0 beginning
#define         LowPowerPin     PORTA,3
#define         LowPowerTRIS    TRISA,3
#define         LowPowerBANK    TRISA

#define         SuperCapTRIS    TRISA,2     ;4
#define         SuperCapPin     PORTA,2     ;4
#define         SuperCapBank    TRISA

#define         RTCOut          PORTA,1
#define         LVDOut          PORTA,3


#define         DUTY            0x80
#define         OscTuneVal      0x00


        UDATA_ACS
DutyCounter     RES     1       ;Duty Cycle Counter
ptr_pos         RES     1
ptr_count       RES     1
temp_wr         RES     1


StartHere       CODE    0x0000
        bsf     OSCCON, IRCF2           ;Set 1MHz clock for faster start-up
        movlw   B'01100000'
        movwf   OSCCON                  ;Set 4 MHz clock.
        bra     Main


IntCodeH        CODE    0x0008
        goto    SCAPIntISR

IntCodeL        CODE    0x18
        goto    SCAPIntISR


MainCode        CODE

;****************************************************************************
; Function: SCAPIntISR
;
; PreCondition: None
;
; Overview:
;           This function process the interrupt
;
; Input: None
;
; Output: None
;
; Side Effects: Databank changed
;
; Stack requirement: 2 level deep
;
;****************************************************************************

SCAPIntISR:
        btg     RTCOut

        bsf     TMR1H,7                 ;start timer in 8000h --> 1sec
        bcf     PIR1,TMR1IF
        retfie  FAST

;****************************************************************************
; Main code
;****************************************************************************
Main:
        call    InitSys                 ;Init system


MainLoop
        btfss   LowPowerPin
        bra     putLowPower             ;Low Power condition detected, go to sleep
        call    ChargeSuperCap
        bra     MainLoop

putLowPower:
        bsf     SuperCapTRIS
        nop

putLowPower1

        sleep                           ;sleep to save energy
        nop

        btfss   LowPowerPin
        bra     putLowPower1            ;Low Power condition detected, go to sleep

        bra     MainLoop                ;after wake-up goto main check conditions



;****************************************************************************
; Function: ChargeSuperCap
;
; PreCondition: None
;
; Overview:
;       This function charges the SuperCap
;
; Input: None
;
; Output: None
;
; Side Effects: Databank changed
;
; Stack requirement: 1 level deep
;
;****************************************************************************
ChargeSuperCap:
        movlw   DUTY                    ;check if reached turn-off point
        subwf   TMR1L,w
        bnc     ChargeIt

DontCharge                              ;yes, stop charging
        bsf     SuperCapPin
        bsf     SuperCapTRIS            ;Put Pin in High Impedance (Input)
        bsf     SuperCapPin
        return

ChargeIt
        bsf     SuperCapPin
        bcf     SuperCapTRIS            ;Put Pin as output to keep charging
        bsf     SuperCapPin
        return



;****************************************************************************
; Function:     InitSys
;
; PreCondition: None
;
; Overview:     This function initializes all variables of the uC
;
; Input:        None
;
; Output:       None
;
; Side Effects: Databank changed
;
; Stack requirement: 1 level deep (own function call)
;
;****************************************************************************

InitSys:

        clrf    PORTA
        clrf    PORTB
        movlw   B'00111100'
        movwf   TRISA

        movlw   B'11000001'
        movwf   TRISB

        movlw   OscTuneVal
        movwf   OSCTUNE

        clrf    FSR0H           ;Clear all variables
        movlw   RAM0_INIT
        movwf   FSR0L
loopClearBank0
        clrf    INDF0
        incf    FSR0L,f
        btfss   FSR0L,7
        goto    loopClearBank0

initTmr1
        clrf    TMR1H
        clrf    TMR1L
        movlw   B'00001111'     ;Enable Timer 1
        movwf   T1CON
        bsf     TMR1H,7         ;start timer in 8000h
        bsf     PIE1,TMR1IE     ;enable interrupt on timer1

        movlw   B'11000000'     ;Enable Interrupts
        movwf   INTCON

        movlw   0x7F            ;All digital
        movwf   ADCON1

        return


        END
