;
; MEGA4809_ADC_FreeRun.asm
;
; Created: 8/17/2024 5:48:29 PM
; Author : cribcat 
; This example(ADC PORTION) taken from TB3209-Getting-Started-with-ADC-DS90003209
; Originally in "C" . I tried to implement the "C" coding exactly in the ADC setup.
; The "C" version is probably more correct than my coding style
;
; ADC0 Free Run version of example: not optimized for any particular use
; TINY_TCB_PER_INT.asm   it will work with avr-1 tinys but was made for avr-0 mega
;                        I Put this in here to fire every 125usec. TCA is the PWM'er: 
;                        TCB updates TCA every 125us with the result from adc  
; # * NOTE: the pwm is NOT updated with every sample. As this example is free run
;     I made it to get periodic updates from TCB
; * some of my comments are terrible and not updated  BEWARE
;** DID NOT set the chip to 20MHz  should be running @ 3.3333MHZ so 125us is wrong
; *** Something is wrong with my FUSE settings so I had to move the vectors
;     to get interrupts to work. COMMENT OUT IF YOU HAVE PROBLEMS.
; Runs and ajusts pulsewidth on PA0  ; Analog input pin PD6  
.include "m4809def.inc"

.def zero = r2
.def one  = r3

.def tmp = r16         ; Gen Purp reg
.def tmp2 = r17
.def count = r19
.def wave = r20
.def flag = r21

.def adcLtmp = r24     ; ADC Result Low temp reg
.def adcHtmp = r25     ; ADC Result High temp reg

; TCB Periodic
.equ TimerVal = 2000 ;; .000125 sec @ 20MHz
; TCA PWM
.equ period = 0x400 ; 1024
.equ duty = 0x200   ; 512

.org 0  rjmp start  

;.org 0x2c rjmp ADCvect
;.org 0x1A   rjmp TCB0_INT     ; 26
; enable int by wrinting 1 to RESRDY in INTCTRL              <
;           ldi tmp,  ADC_RESRDY_bm
;           sts  ADC_INTCTRL_offset , tmp
    reti	 
    .org    0x18  
	jmp TCB0_INT	;TCB0_INT	
	.ORG	78
	reti	;USART3_TXC
  
start:
      clr r2 
	  clr r3 
	  inc r3 
 ; something in my fuses is wrong so I have to move the vectors to get interrupts to fire.
 ;----------------------------------------------------------------------------------------
 move_vectors:                         ; TO BootSection
        ldi tmp2,CPU_CCP_IOREG_gc      ; CCP Change Protection  
		ldi tmp, CPUINT_IVSEL_bm       ; vector select 1 == in boot section?
		out CPU_CCP, tmp2              ; Change Protection 
        sts CPUINT_CTRLA, tmp          ;  
 


	  call tcb_setup
	  call TCA_SETUP

ADC0setup:

      lds tmp,PORTD_PIN6CTRL               
      andi  tmp, (~PORT_ISC_gm) | PORT_ISC_INPUT_DISABLE_gc  ;  Disable digital input buffer 
      sts PORTD_PIN6CTRL, tmp 

   
      lds tmp, PORTD_PIN6CTRL
      andi tmp, ~PORT_PULLUPEN_bm                             ;  Disable pull-up resistor
      sts PORTD_PIN6CTRL,tmp
 
             
      ldi tmp, ADC_PRESC_DIV4_gc |ADC_REFSEL_VDDREF_gc ; use ADC_REFSEL_VDDREF_gc to reference VDD ;CLK_PER divided by 4
      sts  ADC0_CTRLC, tmp                             ; or ADC_REFSEL_INTREF_gc for 4.3 v? 


      ldi tmp, ADC_ENABLE_bm  | ADC_RESSEL_10BIT_gc    ; ADC Enable: enabled  10-bit mode
      sts ADC0_CTRLA,tmp

    
 
      ldi tmp, ADC_MUXPOS_AIN6_gc       ; ADC6 Clear as mud use pin 26 not 20 if on 48 pin TQFP
      sts ADC0_MUXPOS, tmp              ; Select ADC channel

	
      lds tmp,ADC0_CTRLA 
      ori tmp,  ADC_FREERUN_bm          ; Enable FreeRun mode 
      sts ADC0_CTRLA, tmp

ADC0start:
      sei                              ; for TCB interrupt
	  ldi tmp, ADC_STCONV_bm           ; in C  ADC0.COMMAND = ADC_STCONV_bm;
	  sts ADC0_COMMAND, tmp            ; Start conversion 
	                                   ; in free run mode you only do ADC_STCONV_bm once
	    	                            
main:	 
checkADC0convDone:                     ;--------------------------------
      lds tmp, ADC0_INTFLAGS
	  andi tmp, ADC_RESRDY_bm
	  cpi tmp, 0 
	  breq  checkADC0convDone
ADC0read:
	  ;return ADC0.RES;                    ; ADC Accumulator Result
	  lds adcLtmp, ADC0_RES                ; store result in adcHtmp/adcLtmp 
	  lds adcHtmp,  ADC0_RES + 1           ; can use ADC0_RESH ; can use ADC0_RESL	                                    
	  jmp main


TCA_SETUP:
        cli
		ldi tmp,TCA_SINGLE_CMP0EN_bm | TCA_SINGLE_WGMODE_SINGLESLOPE_gc  ;TCA_SINGLE_WGMODE_SINGLESLOPE_gc;TCA_SINGLE_WGMODE_DSBOTTOM_gc;; enable compare channel 0 ;   
		sts TCA0_SINGLE_CTRLB , tmp                                      
        
        ldi tmp ,LOW(period)   ldi tmp2 ,HIGH(period)
        sts TCA0_SINGLE_PERBUF,tmp
        sts TCA0_SINGLE_PERBUF+1,tmp2
        
        ldi tmp ,LOW(duty)   ldi tmp2 ,HIGH(duty)
        sts TCA0_SINGLE_CMP0BUF,tmp                            ; load compare value
        sts TCA0_SINGLE_CMP0BUF+1,tmp2    

		;ldi tmp, TCA_SINGLE_CMP0_bm
		;sts TCA0_SINGLE_INTCTRL,tmp                           ; for interrupt?
		        
        ldi tmp,  TCA_SINGLE_CLKSEL_DIV1_gc|TCA_SINGLE_ENABLE_bm;; set clock source  ;        
        sts TCA0_SINGLE_CTRLA,tmp                               ;; start timer;   
		        
		ldi  tmp,  1                         ; // direction set outpins//
		sts  PORTA_DIRSET ,tmp	              ;
        
        ret

/*
TCA_int: 
      ; push r16
	  ; in r16, CPU_SREG
	   push R16		      
	
		sts   TCA0_SINGLE_CMP0BUF  ,wave
        sts   TCA0_SINGLE_CMP0BUF  +1,zero

		 ldi tmp, TCA_SINGLE_CMP0_bm        // reset flag		 
		 sts TCA0_SINGLE_INTFLAGS,tmp		

	   pop r16
	  ; out CPU_SREG, r16
	  ; pop r16
		 reti 
*/

tcb_setup:
       cli
       ldi tmp, LOW(TimerVal)       ; Load Timer with timeout value
       ldi tmp2, HIGH(TimerVal)
	   sts TCB0_CCMP, tmp
	   sts TCB0_CCMP +1, tmp2	  
	
	   ldi tmp, TCB_CLKSEL_CLKDIV1_gc | TCB_ENABLE_bm 
	   sts TCB0_CTRLA, tmp          ; Enable TCB and set CLK_PER divider to 1 
	   
	   ldi tmp, TCB_CNTMODE_INT_gc  ; Configure TCB in Periodic Timeout mode 
	   sts TCB0_CTRLB, tmp
	     
       ldi tmp, TCB_CAPT_bm;    ; Enable Capture or Timeout interrupt 
	   sts TCB0_INTCTRL,tmp	               
    
      
	   ret 


TCB0_INT:                     ; interrupt is 22 cycles from push r16
       ;^^-----context-----^^ 
       push r16
	   in r16, CPU_SREG
	   push R16
	   ;^^-----context-----^^ 
	   ;VV------- Flag -----VV
       ldi tmp ,  TCB_CAPT_bm  ; Clear the interrupt flag
	   sts TCB0_INTFLAGS, tmp

	   ;vv-----USER_CODE----vv-;	       
	   sts   TCA0_SINGLE_CMP0BUF  ,adcLtmp
       sts   TCA0_SINGLE_CMP0BUF  +1,adcHtmp
	  ; sbr flag, 1
	   ;^^-----USER_CODE----^^-;
	   ;-VV----context-----VV-

	   pop r16
	   out CPU_SREG, r16
	   pop r16
	   
	   reti

/*
  ADCvect:
		push tmp
		in tmp,CPU_SREG
		push tmp
         ; do context here

		   ; DO INT STUFF HERE
		   	lds adcL, ADC0_RES                ; store result in r24/r25 can use ADC0_RESL
	        lds adcH,  ADC0_RES + 1           ; can use ADC0_RESH 
		    lds tmp,  ADC0_INTFLAGS           ; Just read it to reset the flag -- it's shorter 
         ; undo context here
        pop tmp
		out CPU_SREG ,tmp
		pop tmp
 reti  
 */ 