;
; MEGA4809_SLEEP.asm
;
; Created: 8/22/2024 9:50:20 AM
; Author : cribcat
;
; SLEEP demo  
;
; WARNING: If there are no interrupts enabled when going to
; sleep, the device cannot wake up again. Only a
; Reset will allow the device to continue operation.
;
; It is the user's responsibility to optimize for power consumption.
; None of the peripherals are shut down explicitly in this code.
;
; • Three sleep modes:
;  – Idle
;  – Standby
;  – Power-Down
; 
; Sleep gets setup, Portpins configured then a pin interrupt
; and Pullup is set up on PA0 input pin.
; BlinkGenerator is set to blink 4 times and go to sleep. 
;
; When PA0 gets pulled low or allowed to go high by user, the MCU wakes up, fires the pin change interrupt
; and returns after doing interrupt stuff. Interupt service routine resets the pin interrupt and toggles PA2.
; after return from interrupt it jumps to main then to BlinkGenerator... repeat. 
;
; Also works with 32KULP OSC but delay loops need to be changed for 32KHz

.include "m4809def.inc"

 
.def zero = r2
.def one = r3
.def tmp = r16
.def tmp2 = r17
.def SysWaitTempMS = r18         ;  delay timer
.def SysWaitTempMS_H = r19       ;  delay timer
.def count = r20


.def DELAYTEMP = r24             ;  delay timer
.def DELAYTEMP2=r25              ;  delay timer

.equ SREG = CPU_SREG
 

.cseg
.org 0x00 rjmp setup  
.org 0x0C              ; PORTA - External interrupt 
          jmp PA0_INT 
 
 

setup:  
			
			clr r2
			clr r3
			clr r4
			inc r3
 
chgPrescaler:
		ldi tmp, CPU_CCP_IOREG_gc
		clr tmp2          
		out CPU_CCP, tmp              ; Change Protection 
		sts CLKCTRL_MCLKCTRLB, tmp2   ; no Prescaler
		sts CLKCTRL_MCLKCTRLA, tmp2   ; 20MHz
		 
/*
do32kULP:
	 	ldi tmp2, CPU_CCP_IOREG_gc
	 	ldi tmp, CLKCTRL_CLKSEL_OSCULP32K_gc ; |CLKCTRL_CLKOUT_bm ;  OSCULP32K   CLKOUT
	 	out CPU_CCP, tmp2                    ; Change Protection     
	 	sts CLKCTRL_MCLKCTRLA,tmp		
		*/



; ======================= SLEEP setup =========================
;
;       Sleep moddes (from .include "m4809def.inc")
;      .equ SLPCTRL_SMODE_IDLE_gc = (0x00<<1)   ; Idle mode
;      .equ SLPCTRL_SMODE_STDBY_gc = (0x01<<1)  ; Standby Mode
;      .equ SLPCTRL_SMODE_PDOWN_gc = (0x02<<1)  ; Power-down Mode

SLEEPsetup:
			ldi tmp2, SLPCTRL_SEN_bm|SLPCTRL_SMODE_PDOWN_gc
            sts SLPCTRL_CTRLA,tmp2
; ==============================================================
			 
    ldi tmp,1   
    sts PORTA_DIRCLR, tmp               ; PA0 input 

	ldi tmp, 4                          ; PA2 interrupt Output indicator 
	sts PORTA_DIRSET,tmp                ; PA2 output

	ldi tmp, 1
	sts PORTB_DIRSET,tmp                ; PB0 edge generator Output  

	 
; pin interrupt setup 
;---------------------
; Input/Sense Configuration select
;.equ PORT_ISC_INTDISABLE_gc = (0x00<<0)  ; Interrupt disabled but input buffer enabled
;.equ PORT_ISC_BOTHEDGES_gc = (0x01<<0)   ; Sense Both Edges
;.equ PORT_ISC_RISING_gc = (0x02<<0)      ; Sense Rising Edge
;.equ PORT_ISC_FALLING_gc = (0x03<<0)     ; Sense Falling Edge
;.equ PORT_ISC_INPUT_DISABLE_gc = (0x04<<0) ; Digital Input Buffer disabled
;.equ PORT_ISC_LEVEL_gc = (0x05<<0)       ; Sense low Level

		
    lds tmp,PORTA_PIN0CTRL              ; SET INTERRUPT  
	ori tmp,PORT_ISC_BOTHEDGES_gc| PORT_PULLUPEN_bm      ; Pullup on:  for PIN CHANGE interrupt in
	                                                     ; STDBY or PDOWN Must use : PORT_ISC_BOTHEDGES_gc 	                                                                                                      										                                                             
	sts PORTA_PIN0CTRL,tmp              ; enable interrupt on rising or falling edge on  PA0 	
;---------------------	


	sei                                ; set global interrupts       
main:  
    ldi count, 4 
 	ldi tmp,1                            
	

blinkGenerator:

      sts PORTB_OUTSET, tmp             ; Using OUTSET to set PB0

	  rcall delay500ms  
      
      sts PORTB_OUTCLR, tmp             ; Using OUTCLR to clear PB0

	  rcall delay500ms    
	  	  
	  dec count                         ; blink PB0 4 times 

	  breq do_sleep                     ; and then sleep

	  rjmp blinkGenerator

here:	 
 
	  rjmp main

; ======================= SLEEP ========================= 
do_sleep:      
	   sleep
	   nop 	 
	   rjmp main
;========================================================


;GCBasic_compiled_ASM_delay
;--------------------------
 delay500ms:
	ldi	SysWaitTempMS,244
	ldi	SysWaitTempMS_H,1
;--------------------------
Delay_MS:                               ; routine straight out of the assembler listing in GCBasic
	inc	SysWaitTempMS_H
DMS_START:
	ldi	DELAYTEMP2,113
DMS_OUTER:
	ldi	DELAYTEMP,58
DMS_INNER:
	dec	DELAYTEMP
	brne	DMS_INNER
	dec	DELAYTEMP2
	brne	DMS_OUTER
	dec	SysWaitTempMS
	brne	DMS_START
	dec	SysWaitTempMS_H
	brne	DMS_START
	ret
;------------------------------
 


PA0_INT:         
       push r16
	   in r16, sreg
	   push R16	        ; context	                  
		      
	   ldi tmp, 4                   
	   sts PORTA_OUTTGL,tmp             ; toggle PA2
        
	   ldi tmp, 1                       
	   sts PORTA_INTFLAGS,tmp           ; reset PORTA_PIN0  clear interrupt flag by writing 1 to it
	        

	   pop r16          ; context
	   out sreg, r16
	   pop r16

	   reti 
 













