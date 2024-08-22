;
; Mega4809_PIN_OPPERATIONS.asm
;
; Created: 8/21/2024 3:50:41 PM
; Author : Covid-23
;

.include "m4809def.inc"

 

.def tmp = r18
.def tmp2 = r19

.cseg
.org 0x00 
		rjmp setup 

setup:  			
			clr r2
			clr r3
			clr r4
			inc r3


; CCP
; Writing the correct signature to this bit field allows
; changing protected I/O registers or executing protected
; instructions within the next four CPU instructions executed.
;------------------------------------------------------------
chgPrescaleri:
		ldi tmp, CPU_CCP_IOREG_gc
		clr tmp2          
		out CPU_CCP, tmp              ; Change Protection                               
		                          
		sts CLKCTRL_MCLKCTRLB, tmp2   ; no Prescaler
		sts CLKCTRL_MCLKCTRLA, tmp2   ; 20MHz


; SET PULLUPS
;===================================
spr:     
    ldi tmp,3   
    sts PORTA_DIRCLR, tmp               ; all inputs

	ldi tmp, 1
	sts PORTB_DIRSET,tmp


    lds tmp,PORTA_PIN0CTRL          
	ori tmp,PORT_PULLUPEN_bm		 
	sts PORTA_PIN0CTRL,tmp              ; Enable Pullup on PA0 

	rcall delay500ms

    lds tmp,PORTA_PIN1CTRL
	ori tmp,PORT_PULLUPEN_bm	
	sts PORTA_PIN1CTRL,tmp              ; Enable Pullup on PA1 

	rcall delay500ms
	
    lds tmp,PORTA_PIN0CTRL
	andi tmp,(~PORT_PULLUPEN_bm)	 
	sts PORTA_PIN0CTRL,tmp              ; Disable Pullup on PA0    

	rcall delay500ms

    lds tmp,PORTA_PIN1CTRL
	andi tmp,(~PORT_PULLUPEN_bm)	
	sts PORTA_PIN1CTRL,tmp              ; Disable Pullup on PA1  
	 
here:
      ldi tmp,1
      sts PORTB_OUTCLR, tmp             ; Using OUTCLR to clear PB0
	  rcall delay500ms
	  rcall delay500ms

      ldi tmp,1 
      sts PORTB_OUTSET, tmp             ; Using OUTSET to set PB1
	  rcall delay500ms
	  
	  rjmp here
	
 
	;ldi tmp, PORT_INVEN_bm 

delay500ms:
; Delay 10 000 000 cycles
; 500ms at 20 MHz
    push r20
	push r19
	push r18


    ldi  r18, 51
    ldi  r19, 187
    ldi  r20, 224
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
    rjmp PC+1

	pop r18
	pop r19
	pop r20

    ret

;*************************************************************************
;** PORTA - I/O Ports
;*************************************************************************

;.equ PORTA_DIR = 0x0400                  ; Data Direction
;.equ PORTA_DIRSET = 0x0401               ; Data Direction Set
;.equ PORTA_DIRCLR = 0x0402               ; Data Direction Clear
;.equ PORTA_DIRTGL = 0x0403               ; Data Direction Toggle
;.equ PORTA_OUT = 0x0404                  ; Output Value
;.equ PORTA_OUTSET = 0x0405               ; Output Value Set
;.equ PORTA_OUTCLR = 0x0406               ; Output Value Clear
;.equ PORTA_OUTTGL = 0x0407               ; Output Value Toggle
;.equ PORTA_IN = 0x0408                   ; Input Value

