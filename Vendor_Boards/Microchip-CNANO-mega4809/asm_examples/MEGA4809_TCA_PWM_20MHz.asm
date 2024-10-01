;
; MEGA4809_TCA_PWM_20MHz.asm
;
; Created: 8/20/2024 3:13:42 PM
; Author : cribcat
; 
; the code should start the pwm and ramp up to 100% duty cycle 
; (takes about 6 seconds) and then roll over to  0%    and repeat


 

.include "m4809def.inc"

.def zero = r2
.def one  = r3

.def tmp = r16         ; Gen Purp reg
.def tmp2 = r17 

.def flag = r21

.def dutyL = r24     ; DC high
.def dutyH = r25     ; DC low

; TCA PWM
.equ period =  65535 ; 1024
.equ duty = 100  ; 256


.org 0    rjmp start

           
.ORG	78
	      reti	;USART3_TXC
  
start:
      clr r2 
	  clr r3 
	  inc r3 

 ; something in my fuses is wrong so I have
 ; to move the vectors to get interrupts to fire.
 ; comment out 
 ;-------------------------------------------------------------
; move_vectors:                         ; TO BootSection
;        ldi tmp2,CPU_CCP_IOREG_gc      ; CCP Change Protection  
;		ldi tmp, CPUINT_IVSEL_bm       ; vector select 1 == in boot section?
;		out CPU_CCP, tmp2              ; Change Protection 
 ;       sts CPUINT_CTRLA, tmp          ;  
  

chgPrescaler:
		ldi tmp, CPU_CCP_IOREG_gc
		clr tmp2          
		out CPU_CCP, tmp              ; Change Protection		                             
		sts CLKCTRL_MCLKCTRLB, tmp2   ; no Prescaler
		sts CLKCTRL_MCLKCTRLA, tmp2   ; 20MHz		
	
 
	    call TCA_SETUP


 mainloop:
        adiw dutyL, 10                                          ; add 10 to duty cycle 
	 	sts TCA0_SINGLE_CMP0BUF,dutyL                           ; load compare value
        sts TCA0_SINGLE_CMP0BUF+1,DutyH   
		call delay1ms
		rjmp mainloop

 



TCA_SETUP:
        cli
		ldi tmp,TCA_SINGLE_CMP0EN_bm | TCA_SINGLE_WGMODE_SINGLESLOPE_gc   ; TCA_SINGLE_WGMODE_SINGLESLOPE_gc;
		sts TCA0_SINGLE_CTRLB , tmp                                       ; enable compare channel 0 ;   
        
        ldi tmp ,LOW(period)   ldi tmp2 ,HIGH(period)
        sts TCA0_SINGLE_PERBUF,tmp
        sts TCA0_SINGLE_PERBUF+1,tmp2
        
        ldi tmp ,LOW(duty)   ldi tmp2 ,HIGH(duty)
        sts TCA0_SINGLE_CMP0BUF,tmp                             ; load compare value
        sts TCA0_SINGLE_CMP0BUF+1,tmp2    

	;	ldi tmp, TCA_SINGLE_CMP0_bm                             ;  for interrupt ; no interrupts
	;	sts TCA0_SINGLE_INTCTRL,tmp                            
		        
        ldi tmp,  TCA_SINGLE_CLKSEL_DIV1_gc|TCA_SINGLE_ENABLE_bm;; set clock source  ;        
        sts TCA0_SINGLE_CTRLA,tmp                               ;; start timer;   
		        
		ldi  tmp,  1                                            ; direction set outpin
		sts  PORTA_DIRSET ,tmp	            
        ret 
 
 delay1ms:      
 
    push r18
	push r19
	;push r20 

 ; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 20 000 cycles
; 1ms at 20 MHz

    ldi  r18, 26
    ldi  r19, 249
L1: dec  r19
    brne L1
    dec  r18
    brne L1

  ;  pop r20
	pop r19
	pop r18

	ret
 