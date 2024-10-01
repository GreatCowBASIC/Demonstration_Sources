;
; MEGA4809_TCB_PWM.asm
;
; Created: 8/19/2024 12:19:07 PM
; Author : cribcat
;
;==============================================
; also works with 32Kinternal ULP when osc is system clock 
; Original code was for 32K ULP Osc written in C (it may have an app note)
; puts out PWM depending on TCB_CMP_EXAMPLE_VALUE
;
; MSB is duty : LSB is period
; 8 bit only
 
.def zero = r2
.def one = r3
.def tmp = r16
.def tmp2 = r17


.equ TCB_CMP_EXAMPLE_VALUE = 0x40ff    ; 40 is the duty and FF is the period ; easier to see in hex
                                       ; 0x40 ~ 25% duty cyc roughly
									    
.cseg
.org 0x00 rjmp setup  

setup: 			
			clr r2                     ; zero
			clr r3			 
			inc r3                     ; one


chgPrescaler:
		ldi tmp, CPU_CCP_IOREG_gc
		clr tmp2          
		out CPU_CCP, tmp              ; Change Protection 
		sts CLKCTRL_MCLKCTRLB, tmp2   ; no Prescaler
		sts CLKCTRL_MCLKCTRLA, tmp2   ; 20MHz	
		
do32kULP:
	 ;	ldi tmp2, CPU_CCP_IOREG_gc
	 ;	ldi tmp, CLKCTRL_CLKSEL_OSCULP32K_gc|CLKCTRL_CLKOUT_bm ;  OSCULP32K   CLKOUT
	 ;	out CPU_CCP, tmp2                    ; Change Protection     
	 ;	sts CLKCTRL_MCLKCTRLA,tmp		
		    
		
spot:  	                           ; check for osc32 functioning
	 ;	lds tmp,CLKCTRL_MCLKSTATUS
	 ;	sbrs tmp,CLKCTRL_OSC32KS_bp	 	
	 ;	rjmp spot

	ldi tmp, LOW(TCB_CMP_EXAMPLE_VALUE)
	sts TCB0_CCMP, tmp

	ldi tmp,HIGH(TCB_CMP_EXAMPLE_VALUE)
	sts TCB0_CCMP + 1,tmp

	ldi tmp,TCB_ENABLE_bm|TCB_CLKSEL_CLKDIV1_gc
	sts TCB0_CTRLA,tmp

	ldi tmp,TCB_CCMPEN_bm|TCB_CNTMODE_PWM8_gc
	sts TCB0_CTRLB,tmp

    sbi VPORTA_DIR, 2                    
   
 here:
      
	   rjmp here

	   

