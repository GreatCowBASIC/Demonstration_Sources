;
; MEGA4809_FLASH_PAGEWRITE_001.asm
;
; Created: 8/28/2024 9:52:21 AM
; Author : cribcat
;
;
;************************************************************************** 
; FUSES USED FOR WRITING/TESTING THIS CODE
;------------------------------------------
; Fuses;  1288 BOOTEND 01  (0x100)  256 BYTE address... Not word address
;         1287 APPEND  04  (0x400)  1024 BYTE address... Not word address
; start code @  256 Byte (not Word) Bootend 
;***************************************************************************
;
;* tested @ 3.3333MHz and 20MHz
;
;* Can READ Flash using conventional Z and LPM or like sram with LD and X,Y or Z.
;
;* fuses set to the factory default: BOOTend  0 , APPend  0 ...will not work 
; [From FORUM] The Flash Write needs the BOOTEND/ APPEND fuses specifically set. A default BOOTEND 0 : APPEND 0, turns the entire Flash into the BOOT section and no section can write to itself.
; 
;* This will only write a page (128 bytes) : FLASH PROGMEM DOES NOT have byte
;  granularity on erase/write. MUST WRITE A PAGE(128 bytes) AT A TIME.
;
;  from "m4809def.inc"
; #define MAPPED_PROGMEM_PAGE_SIZE 0x80        
; #define PROGMEM_PAGE_SIZE 0x80  
;
; This code fills the PageBuffer with a repeated byte,  writes to flash, reads
; the Flash page back through usart and toggles a port pin continuously (after the write)
; using a timer on interrupt.

.include "m4809def.inc"

.def zero = r2
.def gpr = r16
.def count = r17
.def tmp = r18
.def tmp2 = r19
.def gpr2 = r20
.def flag = r21

.equ SREG = CPU_SREG

.equ fclk = 20000000
.equ BAUD = 57600
.equ fBAUD = ((64 * fclk)/(16 * BAUD)+0.5)  ; truncated   fbaud 

; ************************************ Change Theese as needed ********************************* 

.equ offset = 0x500                       ; address to write 128 byte page to
.equ symbol = 0xAA                        ; the repeated value to write into the 128 Byte pagebuffer
                                          ; for Demo

; **********************************************************************************************
.cseg
.org 0x00	rjmp APPstart   ; Skip bootloader
     
 

.org 0x80 rjmp APPstart     ; 0x80 word address = 0x100 Byte address = BOOTEND == 0X100   
.org 0x80 + 0x18            ; TCB interrupt Vect
            rjmp TCB0_INT 



APPstart:
      clr r2             ; zero
	; sbi VPORTA_DIR,5   ; out
	  sbi VPORTF_DIR,5   ; out
      sbi VPORTF_OUT,5   ; high
	  
      call  tcb0_setup   ; setup interrupt on timer TCB
	  sei

chgPrescaler:
		ldi tmp, CPU_CCP_IOREG_gc
		clr tmp2          
		out CPU_CCP, tmp              ; Change Protection 
		sts CLKCTRL_MCLKCTRLB, tmp2   ; no Prescaler
		sts CLKCTRL_MCLKCTRLA, tmp2   ; 20MHz

		
/*                                     ; NOT NEEDED IF FUSES SET AS BOOTEND(1), APPEND(4)
 move_vectors:                         ; Vectors TO BootSection
        ldi tmp2,CPU_CCP_IOREG_gc      ; CCP Change Protection 
		ldi tmp, CPUINT_IVSEL_bm       ; vector select 1 == in boot section
		out CPU_CCP, tmp2              ; 
        sts CPUINT_CTRLA, tmp          ; 
*/
		  
load_pbuff:								   ; The page buffer is loaded by writing directly to 
										   ; the memories 
		ldi XL,LOW( 0x4000 + (offset))     ; STORE SETTUP ; 0x500 + 4000 offset | flash starts @0x4000 in data space   
		ldi XH,HIGH( 0x4000 + (offset))    ; STORE SETTUP ; pointer for st page buffer loop
		ldi count,128                      ; Pbuffersize
		ldi tmp2, symbol                   ; byte to store symbol

pblp:   ; pagebufferloop  		
     	st X+, tmp2                        ; st it into page buffer 
   		dec count                          ; count it	
		brne pblp                          ; loop it

write_check:	                           ; Wait for completion of previous writes                                   
	    lds		tmp, NVMCTRL_STATUS                     ; flash and eep use same page writer thingy
		sbrc	tmp, NVMCTRL_EEBUSY_bp|NVMCTRL_FBUSY_bp ; See they're busy
		rjmp	write_check		
                                          
				                          

eraseWritePage:    ; do the page write
                 
        in r25,SREG  
        cli                                             ; The CPU is shut down durring flash write
	 	ldi tmp2, CPU_CCP_SPM_gc      
	  	ldi tmp, NVMCTRL_CMD_PAGEERASEWRITE_gc          ; NVMCTRL_CMD_PAGEERASEWRITE_gc = (0x03<<0) ; Erase and write page
	  	sts CPU_CCP,tmp2
	   	sts NVMCTRL_CTRLA,tmp				            ; Erase and write page   
        out CPU_SREG, r25                               ; sim restores sreg to 2 instead of 82 today.
	                                                    
setupserial:
		 call usart_SETUP

         ldi count,80                                   ; 40 X 5ms = 200ms @ 20MHz
         rcall delay_multiply 
		 
mapped:
         ldi XL,LOW(0x4000 + offset)		            ; point X to our new data 
	   	 ldi XH,HIGH(0X4000 + offset)			        ; in  "data Mapped Progmem"

progmem:		
		ldi ZL,LOW(offset)			                    ; point Z to our new data (Not sure why this works)
		ldi ZH,HIGH(offset)                             ; address in "Progmem"  
	
	    ldi gpr2, 130	                                ; number of bytes to read  128 + 2 extra   
readLoop: 
         ld tmp2,x+                        ; read new data using ld	 
	 	 ;lpm tmp2,Z+                      ; read new data using lpm		 
         rcall sendbyte			           ; display data  

         ldi count,60                      ; 40 X 5ms = 200ms @ 20MHz
         rcall delay_multiply

		 dec gpr2
		 breq endWriteProgmem

		 rjmp readLoop

endWriteProgmem:
   
	  sbrs flag, 0                        ; if flag set, increment counter
	  rjmp endWriteProgmem                ; if counter == 100 then toggle port(s)

	  cbr flag, 1
	  inc count
	  cpi count, 100
	  brne endWriteProgmem
	  clr count
	;  sbi VPORTA_IN, 5                     ; toggle PA5
	  sbi VPORTF_IN, 5
	  rjmp endWriteProgmem

delay_multiply:
   rcall delay
   dec count
   brne delay_multiply
   ret

delay:     
push r18 push r19 push r20
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 100 000 cycles
; 5ms at 20 MHz

    ldi  r18, 130
    ldi  r19, 222
L1: dec  r19
    brne L1
    dec  r18
    brne L1
    nop
 pop r20 pop r19 pop r18          
	ret

usart_SETUP:
	ldi tmp,low(fBAUD)		    ; load low value of fBAUD as calculated in the formula provided above
	ldi tmp2,high(fBAUD)		 
	sts USART3_BAUD,tmp		    ; store low fBAUD in BAUD register
	sts USART3_BAUD + 1,tmp2	; store low fBAUD in BAUD register
	
	;ldi tmp,  USART_RXCIE_bm   ; enable recv complete int enable 
	;sts  USART1_CTRLA,tmp  	
	 
	ldi tmp,USART_NORMAL_PMODE_DISABLED_gc|USART_NORMAL_SBMODE_1BIT_gc|USART_NORMAL_CHSIZE_8BIT_gc    ; no parity 8 bit with one stop bits
	sts USART3_CTRLC,tmp   
	ldi tmp,USART_TXEN_bm       ;|	USART_RXEN_bm  ; EN TX/RX
	sts USART3_CTRLB,tmp
	ldi tmp,1	
	sts PORTB_DIRSET,tmp        ; PB0 TX						
	ret   
	
; Send_Byte	  
sendbyte:
 	lds tmp,USART3_STATUS		; copy USART status register to tmp	
	sbrs tmp,5			        ; skip next instruction if bit 5 is 1 means flag set for data transmit buffer 
	rjmp sendbyte			    ; if DREIF = 0 ,bit 5 in r16 is 0 then loop back to sendbyte until DREIF = 1	
	sts USART3_TXDATAL,tmp2		; store tmp2 in TXDATAL transmit data low register
	ret	



.equ TimerVal = 65535 ;; .




tcb0_setup:
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
    
       sei
	   ret 


TCB0_INT:                     ; interrupt is 22 cycles from push r16
       push r16
	   in r16, CPU_SREG
	   push R16
       ;^^-----context-----^^-; 	  
	  
	   ;VV------- Flag -----VV-;
       ldi tmp ,  TCB_CAPT_bm  ; Clear the interrupt flag
	   sts TCB0_INTFLAGS, tmp

	   ;vv-----USER_CODE----vv-;
	   	   	       
	   sbr flag,1               ; sbrc flag,0   set the user flag 
	   	   
       ;^^-----USER_CODE----^^-; 
	   ;-VV----context-----VV-;
	
	   pop r16
	   out CPU_SREG, r16
	   pop r16
	   	   
	   reti

 
