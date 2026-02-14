
'''********************************************************************************
''' Thallium - a preemptiv µRTOS
''' 
''' Version: ATmega328pb
'''
'''--------------------------------------------------------------------------------
''' Constants, Variables, Subroutines, Macros and Scripts
'''
''' To use this feature, you need to enable the 'UserCodeOnly' option in the program.
''' Please use the program examples to assist you in using them.
''' 
''' Because there are some differences between the AVR chips, an OS adjustment is 
''' likely necessary for almost every chip. This Thallium version was adapted for the 
''' ATmega328pb. Therefore, this version can serve as a template for your own 
''' adaptations to older generation chips.
'''
'''---------------------------------------------------------------------------------
''' Copyright (C) 2010-2026 Ralf Pagel
'''
''' This library is free software; you can redistribute it and/or
''' modify it under the terms of the GNU Lesser General Public
''' License as published by the Free Software Foundation; either
''' version 2.1 of the License, or (at your option) any later version.
'''
''' This library is distributed in the hope that it will be useful,
''' but WITHOUT ANY WARRANTY; without even the implied warranty of
''' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''' Lesser General Public License for more details.
'''
''' You should have received a copy of the GNU Lesser General Public
''' License along with this library; if not, write to the Free Software
''' Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
'''
'''
'''
''' author        Ralf Pagel
''' licence       GPL
''' version       1.3
''' date          12.02.2026
'''********************************************************************************

; ----- OS Variables -----------------
  Dim osStackTemp   as Word
  Dim osStackTempL  as Byte alias osStackTemp     ; this is a temporary cache for the ...
  Dim osStackTempH  as Byte alias osStackTemp_H   ; ... StackPointer at Task switching
  Dim osTickCount   as Word
  Dim osTickCountL  as Byte alias osTickCount     ; osTickCountL increments on each Timer (TCA) interrupt
  Dim osTickCountH  as Byte alias osTickCount_H   ; osTickCountH increments on osTickCountL overflow
  Dim osTaskPointer as Byte                       ; osTaskPointer points to the currently running task
  Dim osSuspendFlag as Byte                       ; osSuspendFlag is set if the task suspends itself

; This is a table with pointers to the next task within each priority level.
  Dim osArrayPriPoint as alloc * 8 at osPriLevelPntr
; The OS stores in osPrioTemp a temporar list of all task numbers of the topmost priority level.
  Dim osArrayPriTemp as alloc * 8 at osPrioTemp
; osSignalTable is a table where each byte is assigned to a signal. The value '0' means 'free passage'.
  Dim osArraySignal as alloc * 16 at osSignalTable
; The scheduler stores the topmost stack address of all inactive tasks in osStackStore.
  Dim osArrayStack as alloc * 16 at osStackStore
; When a task is slumbering, the osTickCount value at which it should wake up again is stored in osTimerStore.
  Dim osArrayTimer as alloc * 16 at osTimerStore
; osPriorStore contains the priority for each task.
  Dim osArrayPrior as alloc * 8 at osPriorStore
; osFlagsStore contains the flags for each task. If osFlagsStore contains a value other than '0', the task cannot run.
  Dim osArrayFlags as alloc * 8 at osFlagsStore

; Flags:  X X X X P Y S B
; X = unused, reserved
; P = task is awaiting the opening to pass through a shared resource, set by OS
; Y = allowed all other executable tasks to run at least one time
; S = task slumber (the task waits for the restart time)
; B = task is blocked (switched off)

; Register definitions for assembler
  #define XL r26
  #define XH r27
  #define YL r28
  #define YH r29
  #define ZL r30
  #define ZH r31


; *** Public ************************************************************

macro initOS
  asm showdebug ; macro osInit
  OCR1AH = osCMP0H
  OCR1AL = osCMP0L
  ; CTC = Clear Timer on Compare + Prescaler = 256
  TCCR1B = 0b00001100 ; WGM12, CS11
  ; Output Compare Match A Interrupt Enable
  TIMSK1 = 2  ; OCIE1A
  ; clrAllRegister
  clr r16
  ldi r17,  HIGH(RAMEND)
  ldi XH,   HIGH(256)
  ldi XL,   LOW(256)
;->
  st  X+,   r16
  cpi XL,   LOW(RAMEND)
  cpc XH,   r17  ; HIGH(RAMEND)
  brne  PC-3
  ; r16 is 0
  out PORTB,  r16
  out PORTC,  r16
  out PORTD,  r16
  out PORTE,  r16
end macro


macro setupTask(osTaskNbr, osLabel, osPriority, osFlagsBitMask)
if osTaskNbr = 0 then
  asm showdebug         ; macro setupTask - set SP of Task0 to RAMEND
  ldi   r17,  high(RAMEND)
  ldi   r16,  low(RAMEND)
  out   SPH,  r17
  out   SPL,  r16
else
  asm showdebug         ; macro setupTask - set SP to new stack base
  ldi   r17,  high(RAMEND - (osStackSpace * osTaskNbr))
  ldi   r16,  low(RAMEND - (osStackSpace * osTaskNbr))
  out   SPH,  r17
  out   SPL,  r16
  asm showdebug         ; macro push the task address on stack
  ldi   r16,  LOW(osLabel)
  push  r16
  ldi   r16,  HIGH(osLabel)
  push  r16
  asm showdebug         ; macro push 33 x '0' on stack
  clr   r16
  ldi   r17,  33
;->
  push  r16
  dec   r17
  brne  PC-2
  asm showdebug         ; macro store the top of the task stack
  in    r16,  SPL                           ; get the Stackpointer
  in    r17,  SPH                           ;
  sts   osStackStore+(osTaskNbr<<1), r16   ; store in Task-Stack-Store
  sts   osStackStore+(osTaskNbr<<1)+1, r17 ;
end if
  asm showdebug         ; macro set priority byte
  ldi   r16,  (osPriority & 0x07)
  sts   osPriorStore+osTaskNbr, r16
  asm showdebug         ; macro set Bits in FlagsStore
  ldi   r16,  osFlagsBitMask
  sts   osFlagsStore+osTaskNbr, r16
if osTaskNbr = 0 then
  osTaskPointer = 0                 ; select Task0 for next run
  sei                               ; enable interrupts to start the OS
  rjmp  osLabel
end if
  asm showdebug                     ; end macro setupTask
end macro


macro lock      ; disable interrupts
  cli
end macro


macro resume    ; enable interrupts
  sei
end macro


macro signal (osTaskNbr, osSignalNbr)
; If the signal is already set, it set the P-Flag to its own flags and suspend it self.
; Otherwise, it clear the P-Flag from its own flags, sets the signal, and continues.
; valid osSignalNbr = 1...15
;->
  asm showdebug ; macro signal
  cli
  lds   r16, osSignalTable+osSignalNbr
  tst   r16
  breq  PC+11          ; branch if passage is unlock  (r16 <> 0)
  asm showdebug ; if the task must wait:
  lds   r16, osFlagsStore+osTaskNbr
  sbr   r16, 0b00001000                 ; set the P-Flag of own flags byte
  sts   osFlagsStore+osTaskNbr, r16
  ldi   r16, 1
  sts   osSuspendFlag, r16              ; set suspend bit
  rcall REQUIRED_ISR_TIMER1_COMPA       ; let another task run
  rjmp  PC-14                           ; here the task restarts if the scheduler will free it
;->
  asm showdebug ; if the task can go:
  ldi   r16,  1
  sts   osSignalTable+osSignalNbr, r16  ; lock the passage for all other task
  lds   r16, osFlagsStore+osTaskNbr
  andi  r16, 0b11110111                 ; clr the P-Flag of own flags byte
  sts   osFlagsStore+osTaskNbr, r16
  sei
end macro


macro passed (osSignalNbr)
; delete the signal at entrance
; valid osSignalNbr = 1...15
  asm showdebug ; macro passed
  cli
  clr   r16
  sts   osSignalTable+osSignalNbr, r16
  sei
end macro


macro yield (osTaskNbr)
; Sets the yield bit for the specified task.
; The yield bit is only reset if Task0 is running.
; This means that all other executable tasks are allowed to run at least once before this task is allowed to run again.
  asm showdebug ; macro yield
  cli
  lds  r16, osFlagsStore+osTaskNbr
  sbr  r16, 0b00000100   ; = OR
  sts  osFlagsStore+osTaskNbr, r16
  suspend
end macro


macro setPriority (osTaskNbr, osPriVal)
  asm showdebug ; macro set priority byte
  ldi  r16, (osPriVal & 0x07) ; limit to 0..7
  sts  osPriorStore+osTaskNbr, r16
end macro


macro setFlags (osTaskNbr, osBitMask)
  asm showdebug ; macro set Bits in FlagsStore
  lds  r16, osFlagsStore+osTaskNbr
  sbr  r16, osBitMask   ; r16 OR osBitMask
  sts  osFlagsStore+osTaskNbr, r16
end macro


macro clrFlags (osTaskNbr, osBitMask)
  asm showdebug ; macro clr Bits in FlagsStore
  lds  r16, osFlagsStore+osTaskNbr
  cbr  r16, osBitMask   ; r16 AND !osBitMask
  sts  osFlagsStore+osTaskNbr, r16
end macro


macro suspend
; Trigger task switching without increasing the osTickCount
  asm showdebug ; macro suspend
  ldi   r16, 1
  sts   osSuspendFlag, r16  ; set suspend bit
  rcall REQUIRED_ISR_TIMER1_COMPA ; let another task run
end macro


macro slumber (osDuration)
; puts the currently running task to sleep
; the desired time is to be specified in osDuration, e.g., 100 = 1 s (max. 65535 @ osTick = 100 Hz)
; clobbers: YH, YL, r16, r17, r18, r19
  asm showdebug ; macro slumber
  cli                 ; disable interrupts
  ldi   r18,  low(osDuration)
  ldi   r19,  high(osDuration)
  rcall _slumber      ; I think that's too much instructions for a macro
end macro


; *** Private ************************************************************

sub _slumber
; this sub is only called by macro slumber
; load the next weak up time to the timer store and sets the slumber flag
  ldi   XH,   High(osTimerStore)    ; copy osTimerStore address to X
  ldi   XL,   Low(osTimerStore)     ;
  lds   r16,  osTaskPointer         ; load Task-Pointer from memory
  lsl   r16                         ; r16 * 2 (reason: get 16 bit)
  add   XL,   r16                   ; set X to the memory location for the timer store address
  brcc  PC+2
  inc   XH
;-> (X now points to timer store address of current task)
  ldi   YH,   High(osFlagsStore)    ; copy flags store task0 address to Y
  ldi   YL,   Low(osFlagsStore)     ;
  lds   r16,  osTaskPointer         ; Load Task-Pointer from memory
  add   YL,   r16                   ; set Y to the memory location for the flags store address
  brcc  PC+2
  inc   YH
;-> (Y now points to flags store address of current task)
  lds   r16,  osTickCountL          ; load the currently osTickCount value
  lds   r17,  osTickCountH
  add   r16,  r18                   ; add duration
  adc   r17,  r19
  st    x+,   r16                   ; store currently osTickCount value + duration in timer store for the currently task
  st    x,    r17
  ld    r16,  y                     ; load flags
  ori   r16,  0b00000010            ; set the slumber bit  (sbr)
  st    y,    r16                   ; store flags
  suspend                           ; cause task switching
end sub


Sub REQUIRED_ISR_TIMER1_COMPA 
; osInterruptHandler
    lock
    saveContext
    lds   r16, osSuspendFlag  ; test the suspend bit
    sbrc  r16, 0              ; skip if suspend bit is not set
    rjmp  osIntLab0           ; jump over TCA-OVF-Test and don't inc. osTickCount

; *************************************

    asm showdebug ; Increment osTickCount
    lds   r20,    osTickCountL  ; load osTickCount
    lds   r21,    osTickCountH
    inc   r20                   ; inc. osTickCount
    brne  PC+2
    inc   r21
;->
    sts   osTickCountL,  r20    ; store osTickCount to memory address
    sts   osTickCountH,  r21

; toggle a Pin to see the OS is running (use a oscilloscope)
    LEDge = !LEDge

osIntLab0:                        ; here jump in if suspend a task
    clr   r16                   ;
    sts   osSuspendFlag,  r16   ; reset the suspend bit unconditionally

; *************************************

    asm showdebug ; last stack pointer value -> task data storage frame
    ldi   XL, Low(osStackStore)     ; set X to the stack store origin
    ldi   XH, High(osStackStore)    ;

    lds   r16,  osTaskPointer
    lsl   r16
    add   XL,   r16                 ; set X to the memory location for the stack address
    brcc  PC+2
    inc   XH
  ;->
    lds   r16,  osStackTempL        ; move top stack address -> stack store
    st    x+,   r16
    lds   r16,  osStackTempH
    st    x,    r16

; *************************************

    asm showdebug ; if time comes wake up all sleeping tasks
    ldi   XL,   Low(osTimerStore)     ; copy the timer store address to X
    ldi   XH,   High(osTimerStore)    ;
    ldi   YL,   Low(osFlagsStore)     ; copy flags store address to Y
    ldi   YH,   High(osFlagsStore)    ;

    lds   r17,  osTickCountL    ; load osTickCount
    lds   r18,  osTickCountH    ;
    clr   r19                   ; reset task counter (to test all task)
;->
    ld    r21,  x+              ; load timer-L (timer was set to wake up time relative to osTickCount)
    ld    r22,  x+              ; load timer-H
    ld    r20,  y+              ; load flags
    sbrs  r20,  1               ; test the slumber bit
    rjmp  PC+7                  ; jump if task is not slumber
    cp    r21,  r17
    cpc   r22,  r18
    brne  PC+4                  ; jump if it's not yet time to wake up
    andi  r20,  0b11111101      ; reset slumber flag
    st    -y,   r20             ; store flags
    ld    r20,  y+              ; set x back
;->
    inc   r19                   ; set next task (test all tasks)
    cpi   r19,  osNumberOfTask  ; exit the loop if all task tested
    brne  PC-13                 ; test next task

; *************************************

; Content Switch

; Checks each priority level from 'high' to 'low' in turn to see if there are one or more tasks
; with that priority that are allowed to run. If such a task is found, create a temporary table
; containing the numbers of all tasks with these properties (same priority and no flags set).
; Suspends further searches in the lower priority levels if found.

    asm showdebug ; Content Switch 1
    ldi   r17,  7                 ; load highest priority level
    clr   r18                     ; counter for the number of registered tasks of the same priority
    ldi   XH,   High(osPrioTemp)  ; set X-Pointer to the beginning of the table of 'Task of equal priority'
    ldi   XL,   Low(osPrioTemp)   ;
;->
    ldi   YH,   High(osPriorStore)    ; set Y to the priority byte of Task0
    ldi   YL,   Low(osPriorStore)     ;
    ldi   ZH,   High(osFlagsStore)    ; set Z to the flags of Task0
    ldi   ZL,   Low(osFlagsStore)     ;
    clr   r19                     ; r19 contains the number of the currently tested task (all tasks are tested at every priority)
;->
    ld    r20,  y+                ; load priority byte from current task
    ld    r21,  z+                ; load flags from current task
    cp    r20,  r17               ; compare the priority byte from the current task with the current priority level
    brne  PC+5                    ; skip next lines if not equal
    tst   r21                     ; set Z if the task is allowed to run (if no flag is set)
    brne  PC+3                    ; not branch if Z is set (execute next lines)
    st    x+,   r19               ; add the task number to the task list of the same priority and increment the pointer
    inc   r18                     ; the number of added tasks is recorded here
;->
    inc   r19                     ; set to next task (test all task)
    cpi   r19, osNumberOfTask     ; exit the loop if all task tested
    brne  PC-10
    dec   r17                     ; decrease priority level
    tst   r18                     ; set Z if no task has been found so far
    breq  PC-18                   ; continues with the next lower priority (branch if Z=0)
    inc   r17

; osPrioTemp now contains a list of all tasks that are in the highest occupied priority level.
; r18 contains the number of task numbers listed there.
; r17 contains the priority of each task in the list.
; The tasks in the generated list are started alternately using a round-robin procedure.
; For this purpose, a pointer is stored in osPriLevelPntr for each priority level.

    asm showdebug ; Content Switch 2
    ldi   XL,   Low(osPriLevelPntr)   ; set X to the beginning of the priority pointer table
    ldi   XH,   High(osPriLevelPntr)  ;
    add   XL,   r17                   ; set X to the priority pointer
    brcc  PC+2
    inc   XH
;->
    ld    r16,  x                 ; load the pointer from the last run of this priority
    inc   r16                     ; set to next task
    cp    r16,  r18               ; test whether the (old pointer position + 1) is greater than the number of tasks found.
    brlo  PC+2                    ; branch if r16 < r18
    clr   r16
;->
            ; select the next task from the table
    ldi   YL,   Low(osPrioTemp)   ; set Y at the beginning of the task table
    ldi   YH,   High(osPrioTemp)  ;
    add   YL,   r16               ; set Y to the task in the table that should run
    brcc  PC+2
    inc   YH
;->
    ld    r17,  y                 ; load the number of the next task from the table
    sts   osTaskPointer, r17      ; store the number of the next task in the task pointer
    st    x,    r16               ; store Round-Robin-Pointer-Position

; *************************************

; If Task0 is set, reset all yield flags.
    asm showdebug ; reset yield flags
    lds   r16,  osTaskPointer
    tst   r16                   ; testing whether Task0 is set
    brne  PC+9
    ldi   XL,   Low(osFlagsStore)     ; loads X with the Task0 flag address
    ldi   XH,   High(osFlagsStore)    ;
    ldi   r17,  osNumberOfTask        ; load r17 as loop counter
;->
    ld    r16,  x               ; load flags
    andi  r16,  0b11111011      ; reset yield bit (=cbi)
    st    x+,   r16             ; store flags and inc. X for next task
    dec   r17
    brne  PC-4
;->

; *************************************

    asm showdebug ; next task stack pointer value -> stack pointer
    ldi   XL, Low(osStackStore)     ; set X to the stack store origin
    ldi   XH, High(osStackStore)    ;

    lds   r16,  osTaskPointer
    lsl   r16
    add   XL,   r16                 ; set X to the memory location for the stack address
    brcc  PC+2
    inc   XH
;->
    ld    r16,      x+              ; move next task stack store -> context restoring
    sts   osStackTempL,  r16
    ld    r16,      x
    sts   osStackTempH,  r16

; *************************************
    restoreContext
    resume
End Sub


macro saveContext
  asm showdebug ; macro SAVE CONTEXT
    push  r0              ; save r0
    in    r0, SREG        ; save status register
    push  r0              ; push the status register on the stack
    push  r1
    push  r2
    push  r3
    push  r4
    push  r5
    push  r6
    push  r7
    push  r8
    push  r9
    push  r10
    push  r11
    push  r12
    push  r13
    push  r14
    push  r15
    push  r16
    push  r17
    push  r18
    push  r19
    push  r20
    push  r21
    push  r22
    push  r23
    push  r24
    push  r25
    push  r26
    push  r27
    push  r28
    push  r29
    push  r30
    push  r31
    in    r0, SPL       ; store the the stack pointer in separate memory
    in    r1, SPH       ;
    sts   osStackTempL, r0  ; this address is the only way back to the task
    sts   osStackTempH, r1  ;
  asm showdebug ; end macro SAVE CONTEXT
End macro


macro restoreContext
  asm showdebug ; macro RESTORE CONTEXT
    lds  r1, osStackTempH   ; read the address from memory and store to the stack pointer
    lds  r0, osStackTempL   ;
    out  SPH, r1            ; store to the Stack pointer - first high byte, then low byte
    out  SPL, r0            ;
    pop  r31
    pop  r30
    pop  r29
    pop  r28
    pop  r27
    pop  r26
    pop  r25
    pop  r24
    pop  r23
    pop  r22
    pop  r21
    pop  r20
    pop  r19
    pop  r18
    pop  r17
    pop  r16
    pop  r15
    pop  r14
    pop  r13
    pop  r12
    pop  r11
    pop  r10
    pop  r9
    pop  r8
    pop  r7
    pop  r6
    pop  r5
    pop  r4
    pop  r3
    pop  r2
    pop  r1
    pop  r0               ; transfer the stored status register value from the stack into r0
    out  SREG, r0         ; and then restore the status register
    pop  r0               ; restore r0
  asm showdebug ; end macro RESTORE CONTEXT
End macro


#script
  Prescaler = 256
  osSCR1TMP = Int(((ChipMhz * 1000000) - (Prescaler * osTick)) / (Prescaler * osTick))
  osCMP0L = low(osSCR1TMP)
  osCMP0H = high(osSCR1TMP)
; Calculate the starting addresses of the task data
  #define osPriLevelPntr            ; 8 byte
  osPriLevelPntr = osMemAddrStrt
  #define osPrioTemp                ; 8 byte
  osPrioTemp = osMemAddrStrt + 8
  #define osSignalTable             ; 16 byte
  osSignalTable = osMemAddrStrt + 16
  #define osStackStore              ; 16 byte
  osStackStore = osMemAddrStrt + 32
  #define osTimerStore              ; 16 byte
  osTimerStore = osMemAddrStrt + 48
  #define osPriorStore              ; 8 byte
  osPriorStore = osMemAddrStrt + 64
  #define osFlagsStore              ; 8 byte
  osFlagsStore = osMemAddrStrt + 72
; total amount: 80 byte
  #define FrmBuff0
  FrmBuff0 = osMemAddrStrt + 80
#endscript
