;
; MEGA4809_32K_OSC_TCB_PWM.asm
;
; Created: 8/19/2024 1:06:19 PM
; Author : cribcat
;==============================================
; in OSC32 mode 
; Sets the 32Kinternal ULP osc as system clock
; Disables prescaler and sets PA7 as clock out
; Checks that the 32kosc is stable before continuing ;   
; ALSO works in 20Mhz mode
;
; this program puts the chip in 32K internal ULP mode 
; using TCB0 for 8 bit PWM. 
; 
.def zero = r2
.def one = r3
.def tmp = r16
.def tmp2 = r17


.equ TCB_CMP_EXAMPLE_VALUE = 0x40FF    ; 40 is the duty and FF is the period

.cseg
.org 0x00 rjmp setup  
 
setup: 			
			clr r2                     ; zero
			clr r3			 
			inc r3                     ; one
 
do32kULP:
	 	ldi tmp2, CPU_CCP_IOREG_gc
	 	ldi tmp, CLKCTRL_CLKSEL_OSCULP32K_gc ;  OSCULP32K    
	 	out CPU_CCP, tmp2                    ; Change Protection     
	 	sts CLKCTRL_MCLKCTRLA,tmp		
		    
		
spot:  	                                ; check for osc32 functioning
	 	lds tmp,CLKCTRL_MCLKSTATUS
	 	sbrs tmp,CLKCTRL_OSC32KS_bp	 	; skip if good
	 	rjmp spot


TCBsetup:
	ldi tmp, LOW(TCB_CMP_EXAMPLE_VALUE)
	sts TCB0_CCMP, tmp

	ldi tmp,HIGH(TCB_CMP_EXAMPLE_VALUE)
	sts TCB0_CCMP + 1,tmp

	ldi tmp,TCB_ENABLE_bm|TCB_CLKSEL_CLKDIV1_gc
	sts TCB0_CTRLA,tmp

	ldi tmp,TCB_CCMPEN_bm|TCB_CNTMODE_PWM8_gc
	sts TCB0_CTRLB,tmp

   
	                 
    lds tmp, PORTB_DIR 
	ori tmp, 4 
	sts PORTA_DIR,tmp                         ; PA2 to output
 here:
      
	   rjmp here

	   

