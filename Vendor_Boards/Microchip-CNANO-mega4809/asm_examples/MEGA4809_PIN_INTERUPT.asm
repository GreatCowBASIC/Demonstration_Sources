;
; MEGA4809_PIN_INTERUPT.asm
;
; Created: 8/21/2024 5:42:29 PM
; Author : cribcat
;
; pin interrupts
;  I've connected a resistor from the output of the "edge generator"
; to the input PA0 interrupt pin. The edge gernerator toggles input PAO
; then the interrupt "PORTA_OUTTGL"es  PA2 with an LED connected to it
; The interrrupt handles all of the PORTA pin interrupts  
.include "m4809def.inc"

 

.def tmp = r18
.def tmp2 = r19

.cseg
.org 0x00 
		rjmp setup 

.org 0x0C   ; PORTA - External interrupt 
          jmp PA0_INT


setup:  			
			clr r2
			clr r3
			clr r4
			inc r3


chgPrescaleri:
		ldi tmp, CPU_CCP_IOREG_gc
		clr tmp2          
		out CPU_CCP, tmp              ; Change Protection                               
		                          
		sts CLKCTRL_MCLKCTRLB, tmp2   ; no Prescaler
		sts CLKCTRL_MCLKCTRLA, tmp2   ; 20MHz


 
    ldi tmp,1   
    sts PORTA_DIRCLR, tmp               ; PA0 input 

	ldi tmp, 4                          ; PA2 interrupt Output indicator 
	sts PORTA_DIRSET,tmp                ; PA2 output

	ldi tmp, 1
	sts PORTB_DIRSET,tmp                ; PB0 edge generator Output                          
	
    lds tmp,PORTA_PIN0CTRL              ; SET INTERRUPT  
	ori tmp,PORT_ISC_FALLING_gc	 
	sts PORTA_PIN0CTRL,tmp              ; enable interrupt on falling edge PA0 

	ldi tmp,1                            
	sei

edgeGenerator:

      
      sts PORTB_OUTCLR, tmp             ; Using OUTCLR to clear PB0

	  rcall delay500ms
      
      sts PORTB_OUTSET, tmp             ; Using OUTSET to set PB0

	  rcall delay500ms
	  
	  rjmp edgeGenerator
	
 
	 

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

PA0_INT: 
       push r16
	   in r16, CPU_SREG
	   push R16	
	   	
		
	   lds tmp, PORTA_INTFLAGS          ; test for PA0 interrupt flag
	   cpi tmp,1                      
	   brne	skiptog                      
		      
	   ldi tmp, 4                   
	   sts PORTA_OUTTGL,tmp             ; toggle PA2
skiptog:
	   ldi tmp, 1                       
	   sts PORTA_INTFLAGS,tmp           ; reset PORTA_PIN0  interrupt flag by writing 1 to it

	   pop r16
	   out CPU_SREG, r16
	   pop r16

	   reti 







            
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

