;
; MEGA4809_CLOCK_CONTROL.asm
;
; Created: 9/2/2024 2:58:37 PM
; Author : cribcat
;
; CLKCTRL_MCLKCTRLA masks
;.equ CLKCTRL_CLKOUT_bm = 0x80            ; System clock out bit mask
;.equ CLKCTRL_CLKOUT_bp = 7               ; System clock out bit position
;     clock select select
;.equ CLKCTRL_CLKSEL_OSC20M_gc = (0x00<<0) ; 20MHz oscillator
;.equ CLKCTRL_CLKSEL_OSCULP32K_gc = (0x01<<0) ; 32KHz oscillator
;.equ CLKCTRL_CLKSEL_XOSC32K_gc = (0x02<<0) ; 32.768kHz crystal oscillator
;.equ CLKCTRL_CLKSEL_EXTCLK_gc = (0x03<<0) ; External clock

; CLKCTRL_MCLKCTRLB 
; Prescaler division select
;.equ CLKCTRL_PDIV_2X_gc = (0x00<<1)      ; 2X
;.equ CLKCTRL_PDIV_4X_gc = (0x01<<1)      ; 4X
;.equ CLKCTRL_PDIV_8X_gc = (0x02<<1)      ; 8X
;.equ CLKCTRL_PDIV_16X_gc = (0x03<<1)     ; 16X
;.equ CLKCTRL_PDIV_32X_gc = (0x04<<1)     ; 32X
;.equ CLKCTRL_PDIV_64X_gc = (0x05<<1)     ; 64X
;.equ CLKCTRL_PDIV_6X_gc = (0x08<<1)      ; 6X
;.equ CLKCTRL_PDIV_10X_gc = (0x09<<1)     ; 10X
;.equ CLKCTRL_PDIV_12X_gc = (0x0A<<1)     ; 12X
;.equ CLKCTRL_PDIV_24X_gc = (0x0B<<1)     ; 24X
;.equ CLKCTRL_PDIV_48X_gc = (0x0C<<1)     ; 48X
;.equ CLKCTRL_PEN_bm = 0x01               ; Prescaler enable bit mask
;.equ CLKCTRL_PEN_bp = 0                  ; Prescaler enable bit position


;#####################################################################
/*
chgPrescaler:
		ldi tmp, CPU_CCP_IOREG_gc
		clr tmp2          
		out CPU_CCP, tmp              ; Change Protection 
		sts CLKCTRL_MCLKCTRLB, tmp2   ; no Prescaler
		sts CLKCTRL_MCLKCTRLA, tmp2   ; 20MHz
*/
;       ^    
;       |
; Previous ChangePrecaler is un reliable when used to adjust prescaler
; values ; This new code should be implemented unless You've already 
; replaced it. Your compiler may have fixed it in the GCBASIC code.
;####################################################################### 

.include "m4809def.inc"

 


.def tmp = r18
.def tmp2 = r19
.def gpr = r20
.equ SREG = CPU_SREG

.cseg
.org 0x00 rjmp setup  
 


setup:  			
		
                  
		; Main Clock Prescaler/Source select                          
        ;====================================
		; This new code works better.

ClockChangePrescaler:

 		ldi tmp, CPU_CCP_IOREG_gc
		out CPU_CCP, tmp                   ; change protection

		ldi tmp, CLKCTRL_CLKOUT_bm  | CLKCTRL_CLKSEL_OSC20M_gc
		sts CLKCTRL_MCLKCTRLA, tmp  

 		ldi tmp, CPU_CCP_IOREG_gc
		out CPU_CCP, tmp 		            ; change protection

		ldi tmp , CLKCTRL_PDIV_10X_gc | CLKCTRL_PEN_bm    ; enable Prescaler | div xx   
		sts CLKCTRL_MCLKCTRLB, tmp 


mainSetup:
        ldi r16, 1<<5
		sts PORTF_DIRSET,r16				 
		

 
blink:
 		 
		sts PORTF_OUTCLR,r16

		rcall delay
 		 
		sts PORTF_OUTSET,r16

		rcall delay

		rjmp blink
 
delay: 
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 2 000 000 cycles
; 100ms at 20 MHz

    ldi  r18, 11
    ldi  r19, 38
    ldi  r20, 94
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
    rjmp PC+1
	ret	