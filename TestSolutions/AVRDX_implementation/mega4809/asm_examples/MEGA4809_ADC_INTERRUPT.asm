;
; MEGA4809_ADC__INTERRUPT.asm
;
; Created: 8/18/2024 6:34:00 PM
; Author : cribcat
;
; when ADC interrupt fires
; the ISR sets the flag byte and puts the result into the ADC Result Low/High temp reg
; after returning from ISR, main jumps out of the loop, clears flag, delays 30ms and
; puts the adc result into PWM and starts another ADC conversion
; the ADC interrupt flag is cleared once the ADC0_RES regs are read in the ISR if I remember corectly
; 

.include "m4809def.inc"

.def zero = r2
.def one  = r3

.def tmp = r16         ; Gen Purp reg
.def tmp2 = r17 

.def flag = r21

.def adcLtmp = r24     ; ADC Result Low temp reg
.def adcHtmp = r25     ; ADC Result High temp reg

; TCA PWM
.equ period = 0x400 ; 1024
.equ duty = 0x100   ; 256


.org 0    rjmp start

          reti
.org 0x2c 
          rjmp ADCvect        

          reti	 
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
 move_vectors:                         ; TO BootSection
        ldi tmp2,CPU_CCP_IOREG_gc      ; CCP Change Protection  
		ldi tmp, CPUINT_IVSEL_bm       ; vector select 1 == in boot section?
		out CPU_CCP, tmp2              ; Change Protection 
        sts CPUINT_CTRLA, tmp          ;  
  

chgPrescaler:
		ldi tmp, CPU_CCP_IOREG_gc
		clr tmp2          
		out CPU_CCP, tmp              ; Change Protection		                             
		sts CLKCTRL_MCLKCTRLB, tmp2   ; no Prescaler
		sts CLKCTRL_MCLKCTRLA, tmp2   ; 20MHz
		
	
;		sbi VPORTB_DIR,0              ; debug LED
;		sbi VPORTB_DIR,1              ; debug LED

	    call TCA_SETUP

ADC0setup:

      lds tmp,PORTD_PIN6CTRL               
      andi  tmp, (~PORT_ISC_gm) | PORT_ISC_INPUT_DISABLE_gc  ;  Disable digital input buffer 
      sts PORTD_PIN6CTRL, tmp 

   
      lds tmp, PORTD_PIN6CTRL
      andi tmp, ~PORT_PULLUPEN_bm                             ;  Disable pull-up resistor
      sts PORTD_PIN6CTRL,tmp
 
             
      ldi tmp, ADC_PRESC_DIV16_gc |ADC_REFSEL_VDDREF_gc ; use ADC_REFSEL_VDDREF_gc to reference VDD ;
      sts  ADC0_CTRLC, tmp                             ; or ADC_REFSEL_INTREF_gc for 4.3 v? 
	                                                   ; ADC prescaler: The ADC requires an input clock frequency between 50 kHz and 1.5 MHz 
													   ; for maximum resolution. If a lower resolution than 10 bits is selected, the input 
													   ; clock frequency to the ADC can be higher than 1.5 MHz to get a higher sample rate.

      ldi tmp, ADC_ENABLE_bm  | ADC_RESSEL_10BIT_gc    ; ADC Enable: enabled  10-bit mode
      sts ADC0_CTRLA,tmp
    
 
      ldi tmp, ADC_MUXPOS_AIN6_gc      ; 
      sts ADC0_MUXPOS, tmp             ; Select ADC channel

	  lds tmp,ADC0_INTCTRL
	  ori tmp, ADC_RESRDY_bm 	                           
	  sts  ADC0_INTCTRL,tmp            ; enable interrupt
	
    ;  lds tmp,ADC0_CTRLA 
    ;  ori tmp,  ADC_FREERUN_bm        ; Enable FreeRun mode 
    ;  sts ADC0_CTRLA, tmp
	   sei                             ; set global interrupts
ADC0start:                                
	  ldi tmp, ADC_STCONV_bm         
	  sts ADC0_COMMAND, tmp            ; Start conversion 	                                     
main: 	  
	  sbrs flag,0                      ; if adc interrupt has fired, update pwm
	  rjmp main
	  cbr flag,1
	  rcall delay30ms                  ; arbitrary time delay
	 ; sbi VPORTB_IN,0                 ; toggle debug LED
	  sts   TCA0_SINGLE_CMP0BUF  ,adcLtmp        
      sts   TCA0_SINGLE_CMP0BUF+1 ,adcHtmp         ; put adc result into PWM                        
	  rjmp ADC0start


delay30ms:      
;
; Delay 600 000 cycles
; 30ms at 20 MHz
    push r18
	push r19
	push r20 

    ldi  r18, 4
    ldi  r19, 12
    ldi  r20, 52

L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
    rjmp PC+1

    pop r20
	pop r19
	pop r18

	ret


TCA_SETUP:
        cli
		ldi tmp,TCA_SINGLE_CMP0EN_bm | TCA_SINGLE_WGMODE_SINGLESLOPE_gc   ; TCA_SINGLE_WGMODE_SINGLESLOPE_gc;TCA_SINGLE_WGMODE_DSBOTTOM_gc;
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
 
  ADCvect:  ; ADC0
		push tmp
		in tmp,CPU_SREG
		push tmp
         ; do context here

		   ; DO INT STUFF HERE
		   	lds adcLtmp, ADC0_RES                ; store result in r24/r25 can use ADC0_RESL
	        lds adcHtmp, ADC0_RES + 1            ; can use ADC0_RESH 
                                      ; sbi VPORTB_IN,0                   ; toggle debug LED
		   ; sts  ADC0_INTFLAGS,one              ; Just read ADC0_RES, ADC0_RES + 1   to reset the flag 
			sbr flag,1                           ; The flag is cleared by either writing a ‘1’ to the bit 
			                                     ; location or by reading the Result register (ADCn.RES).
												 ; Writing a ‘0’ to this bit has no effect.
         ; undo context here
        pop tmp
		out CPU_SREG ,tmp
		pop tmp
    reti  
 