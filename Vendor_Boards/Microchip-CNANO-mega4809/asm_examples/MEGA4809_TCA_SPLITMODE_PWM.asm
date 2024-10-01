;
; MEGA4809_TCA_SPLITMODE_PWM.asm
;
; Created: 8/20/2024 1:04:26 PM
; Author : cribcat
;
; This example was taken/modified from app note  
; TB3217-Getting-Started-with-TCA-90003217A.pdf
;
; SPLIT MODE TCA PWM
; this puts out pwm on PA0 and PA3 on the 48pin 4809 
; Modified it to ramp up to full duty cycle and then roll over to 0% and repeat

.def tmp = r18
.def tmp2 = r19

.org 0
     jmp start



start:
        call tca_setup 
 loop: 
 
       lds tmp,  TCA0_SPLIT_HCMP0
       inc tmp
	   sts  TCA0_SPLIT_HCMP0, tmp
	    
	    
	   lds tmp,  TCA0_SPLIT_LCMP0
	   inc tmp
	   sts  TCA0_SPLIT_LCMP0, tmp
	    
	    rcall del10

		rjmp loop 

 
 // In split mode, the 16 bit type A timer can be used as 2x 8 bit timers, "high" (H) and "low" (L)
tca_setup:
    ldi tmp,  TCA_SPLIT_SPLITM_bm;					// enable split mode	sts TCA0_SINGLE_CTRLD,tmp

	
	ldi tmp, TCA_SPLIT_HCMP0EN_bm | TCA_SPLIT_LCMP0EN_bm // enable PWM outputs
	sts TCA0_SPLIT_CTRLB,tmp 

	 ldi tmp, 255
	 sts TCA0_SPLIT_HPER,tmp;						// set period on H

    ldi tmp, 255;									// and L timers
	sts TCA0_SPLIT_LPER,tmp

	ldi tmp, 128
	sts TCA0_SPLIT_HCMP0,tmp;						// set 50% duty cycle on H

	ldi tmp, 128;							        
	sts TCA0_SPLIT_LCMP0 ,tmp                       ; set 25% duty cycle on L 

	ldi tmp,TCA_SPLIT_ENABLE_bm;					// start timer
	sts TCA0_SPLIT_CTRLA , tmp

	 ldi  tmp,  1  |(1<<3 );                         // direction set outpins
	 sts  PORTA_DIRSET  ,tmp 

	
	ret 

   // set PWM pins as outputs; PA0 = L timer, PA3 = H timer

del10:  

    push r18
    push r19
;
; Delay 33 333 cycles
; 10ms at 3.3333 MHz

    ldi  r18, 44
    ldi  r19, 73
L1: dec  r19
    brne L1
    dec  r18
    brne L1
    nop

    pop r19
    pop r18

	ret 
