;
; MEGA4809_USART_RX_TX_INTERRUPTS.asm
;
; Created: 8/19/2024 1:35:00 PM
; Author : cribcat
;
; ========================= START_RANT ================================= 
; NOTE: I had to look up some registers for the interrupts today.
; I had forgoten how hard Microchip makes it to look up the wordage E.G. 
; USART_TXCIF_bm... must look up the bits you need in the data sheet
; and then search the nearly 4000 line definition file (M4809def.inc) for 
; the exact nomenclature when you don't know the specific names or order.
; I'm grateful for the Find/replace function.
; ------------------------ END Rant ---------------------------------- 
;
; Three separate interrupts - 
; This program Receives a byte then sends it back, Toggles a port pin when the entire frame 
; in the TX register has been shifted out. Another pin is toggled when the TX data
; register empty. 

.include"m4809def.inc"

.def zero = r2

.def tmp = r16          ; gp reg
.def tmp2 = r17         ; gp reg
.def gpr = r21          ; gp reg
.def flag = r22
 
.equ fclk =   20000000 
.equ BAUD = 9600
.equ fBAUD = ((64 * fclk)/(16 * BAUD)+0.5)  ; truncated ;   can set  fbaud = 1388 for 3.333MHz  
                                            ;                        fbaud = 8333 for 20 MHz                                                      
.org 0x00 
          jmp start
		  reti             ; 0x02 - 0x32
.org 0x34                  ; USART1 - Receive Complete            
          jmp rs232RXint   ;
.org 0x36                  ; USART1 - Data Register Empty 
          jmp rs232TXDREint 
.org 0x38                  ; USART1 - Transmit Complete 
          jmp rs232TXint     


.org 0x4e
          reti              ; last int vector catches anything between 0x38 and 0x4e

 start:
         clr r2                       ; for zero reg  
         call usartSETUP
		 sbi VPORTB_DIR,0             ; TX ISR indicator 
         sbi VPORTB_DIR,1             ; TX ISR indicator 


; something in my fuses is wrong so I have
; to move the vectors to get interrupts to fire.
; comment out [move_vectors:] section   
;-------------------------------------------------------------------------------
move_vectors:                          ; TO BootSection
        ldi tmp2,CPU_CCP_IOREG_gc      ; CCP Change Protection 
		ldi tmp, CPUINT_IVSEL_bm       ; vector select 1 == in boot section
		out CPU_CCP, tmp2              ; Change Protection 
        sts CPUINT_CTRLA, tmp          ; 
;------------------------------------------------------------------		 


chgPrescaler:                         ; no prescaler and 20 MHz).
		ldi tmp, CPU_CCP_IOREG_gc
		clr tmp2          
		out CPU_CCP, tmp              ; Change Protection 
		sts CLKCTRL_MCLKCTRLB, tmp2   ; no Prescaler
		sts CLKCTRL_MCLKCTRLA, tmp2   ; 20MHz



 
        sei                    ; set global interrupts  
		
main:                          ; loop here until interrupt
  
                   

		 rjmp main               

 

 

;USART Initialization
;-----------------------------------
usartSETUP:

	ldi tmp,low(fBAUD)		    ; load low value of fBAUD as calculated in the formula provided above
	ldi tmp2,high(fBAUD)		;  
	sts USART1_BAUD,tmp		    ; store low fBAUD in BAUD register
	sts USART1_BAUDH,tmp2	    ; store high fBAUD in BAUD register

; rx,tx, txdre interrupt enable
;                                               | USART_DREIE_bm  enabled in ISR becuase it must be disabled when not needed
 	ldi tmp,  USART_RXCIE_bm |  USART_TXCIE_bm; | USART_DREIE_bm  ; enable recv complete, Transmit Complete, Data Register Empty int enable 
 	sts  USART1_CTRLA,tmp

	ldi tmp,USART_NORMAL_PMODE_DISABLED_gc|USART_NORMAL_SBMODE_1BIT_gc|USART_NORMAL_CHSIZE_8BIT_gc    ; async 8bit no parity with one stop bit 
	sts USART1_CTRLC,tmp 
	  
	ldi tmp, USART_RXEN_bm|USART_TXEN_bm    ; EN TX/RX
	sts USART1_CTRLB,tmp

	lds tmp,PORTC_DIR
	ori tmp, 1 	               
	sts PORTC_DIR, tmp                      ; PC0 TX    
	
	ret 
                                    

; RX ISR  
;----------------------------------------
rs232RXint:	 ; RXCIF fires when data is in buffer cleared when read
	   push r16              
	   in r16, CPU_SREG
	   push R16
	   ;^^-----context-----^^    
	        
	   lds tmp2, USART1_RXDATAL		; get rx'd byte;return USART0.RXDATAL;

	   lds tmp, USART1_CTRLA 
	   ori tmp,  USART_DREIE_bm     ; enable TXDRE  data reg empty
	   sts  USART1_CTRLA,tmp 		
        
	   ;-VV----context-----VV-
	   pop r16
	   out CPU_SREG, r16	 
	   pop  r16   
	    
	   reti


; USART_DRE 
rs232TXDREint:  ; TX data register empty
 	 
	   push r16              
	   in r16, CPU_SREG
	   push R16
	   ;^^-----context-----^^ 
	    ldi r25,1                       ; toggle LED to demonstrate int works
	    lds tmp, PORTB_IN               ; exor bit 1  for toggle
		eor tmp, r25 
		sts PORTB_OUT, tmp
	    
	    lds tmp, USART1_CTRLA 
	    andi tmp, (~USART_DREIE_bm)      ; disable TXDRE  data reg empty interrupt
	    sts  USART1_CTRLA,tmp      
	   
	    sts USART1_TXDATAL,tmp2	        ; put previously received data into tx reg
	                          
	   ;-VV----context-----VV-
	   pop r16
	   out CPU_SREG, r16	 
	   pop  r16   
	    
	   reti


; USART_TXCIE
rs232TXint:	  ;  fires when the entire frame in the Transmit Shift register has been shifted out
              ;  This flag is automatically cleared when the transmit complete interrupt vector is executed
	   push r16              
	   in r16, CPU_SREG
	   push R16
	   ;^^-----context-----^^ 
	    ldi r25,2                      ; toggle LED to demonstrate int works
	    lds tmp, PORTB_IN              ; exor bit 1  for toggle
		eor tmp, r25
		sts PORTB_OUT, tmp

       ldi tmp, USART_TXCIE_bm         ; clear interrupt
	   sts USART1_STATUS,tmp
	   ;-VV----context-----VV-
	   pop r16
	   out CPU_SREG, r16	 
	   pop  r16   
	    
	   reti




; 23.5.5 USART Status Register
;-----------------------------
; Bit 7 – RXCIF  USART Receive Complete Interrupt Flag
; This flag is set to ‘1’ when there are unread data in the receive buffer and cleared when the receive buffer is empty
; When interrupt-driven data reception is used, the receive complete interrupt routine must read the received data from
; RXDATA in order to clear the RXCIF.
;
; Bit 6 – TXCIF?USART Transmit Complete Interrupt Flag
; This flag is set when the entire frame in the Transmit Shift register has been shifted out, and there are no new data in
; the transmit buffer (TXDATA).
; This flag is automatically cleared when the transmit complete interrupt vector is executed. The flag can also be
; cleared by writing a ‘1’ to its bit location
;
; Bit 5 – DREIF?USART Data Register Empty Flag
; This flag indicates if the transmit buffer (TXDATA) is ready to receive new data. The flag is set to ‘1’ when the
; transmit buffer is empty and is ‘0’ when the transmit buffer contains data to be transmitted but has not yet been
; moved into the Shift register. The DREIF bit is set after a Reset to indicate that the transmitter is ready. Always write
; this bit to ‘0’ when writing the STATUS register.
; DREIF is cleared to ‘0’ by writing TXDATAL. When interrupt-driven data transmission is used, the Data Register
; Empty interrupt routine must either write new data to TXDATA in order to clear DREIF or disable the Data Register
; Empty interrupt. If not, a new interrupt will occur directly after the return from the current interrupt.
 