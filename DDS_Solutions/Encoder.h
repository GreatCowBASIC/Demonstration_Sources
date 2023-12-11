'''**********************************************
'  encoder and button handling
'''**********************************************
'
' encoder routines for ALPS mechanical rotary encoder
' EC11B/ EC11E/ EC11G/ EC11J with push-Button
' all these have two different stable detents: A and B are High or Low
' followig graph will show:
'
'   --:,   :,---:,    H
' A   :|   :|   :|
'     :'---:'   :'--- L
'     :    :    :
'   ,-:--, :  ,-:--,  H
' B | :  | :  | :  |
'   ' :  '-:--' :  '- L
'     :    :    :
'     det1 det2 det1
'
' Because of two possible different states at any detent,
' you have to separate the detent positions from transient,
' in order to become 1 count between 2 detents.
' First transient (i.e. A from H to L) is counted,
' second (i.e. B from L to H) is not regarded. To get the direction
' of turning makes XOR between old and new position of A and B.
'
' You have to define the encoder-bits to ports
 ; #define ENCODER_A PortB.0   'clk
 ; #define ENCODER_B PortB.2   'cw
 ; #define ENCODER_SW PortB.3  'switch
' and port direction in main program like
 ; dir ENCODER_A in
 ; dir ENCODER_B in
 ; dir ENCODER_SW in
'
' Before entering the main program, the starting state
' of the encoder bits (a detent position) is stored
' to the variables new and old, bit 6 and 7.

 ; ---- variables
 DIM new as Byte       'gets new position
 DIM old as Byte       'saves old position
 DIM directn as bit    'sense of rotation: 1 = CW, 0 = CCW
 DIM delta as integer  'variable to add to counter

 ' encoder switch pushed
 DIM eShortP as bit  'short push
 DIM eDoubleP as bit 'short double push
 DIM eLongP as bit   'long push
 DIM elLongP as bit  'extreme long push

 ' reminder flags of buttons pushed for flow control
 DIM  rSwP as bit   'flag any push of any button
 DIM  mSwP as bit   'flag m-button pushed
 DIM meSwP as bit   'flag combined push of m-button first and e-button

 'init encoder first at main program

 ; ---- Methods
 sub init_enc

  dir ENCODER_A in
  dir ENCODER_B in
  dir ENCODER_SW in

  'change the connections A and B, if turning direction is opposite
  'copy encoder bits to new
  new.6 = encoder_B
  new.7 = encoder_A

  'store actual detent
  'mask bits and copy new into old.
  old = new & b'11000000'

  'encoderswitch not pressed (ALL_OFF)
     eShortP  = OFF
      eLongP  = OFF
     elLongP  = OFF
     eDoubleP = OFF

 end sub

 sub read_enc
 'main part of reading encoder and switch
 'Returns 1 or -1 depending on rotation between two detents
 'based on value of 0 for delta.
 'The return value can be set with delta to any value at your needs.

 ''' Gets first stable detent i.e. with A = B High,
 ''' next change will be A going to 0 when cw turned
 ''' This is more stable then 1st version and has no
 ''' timing problems.

 DIM NoMo as BIT  'flag for no motion

   delta = 0   ' value to be returned after turning encoder
   LP = 0      ' watch-timer for encoder in undefined detent
   NoMo = OFF  ' flag set, if no motion on encoder

  do
      'gets a detent at A = B
      new.7 = encoder_A
      new.6 = encoder_B

      'watch if no motion for 250ms
      lp++
      wait 5 ms
      if lp > 50 then NoMo = ON

  loop until (new.6 = new.7) or NoMo 'get detent both H or L

   NoMo = OFF

  'save detent to old
   old = new & b'11000000'

 ''' ---------------------------------------
 ' MENTION:
 ' stays in following loop, while no change.
 ' Encoder_switch reading added for exiting.
 ''' ---------------------------------------

 do

  ' read encoder bits to new
    new.7 = encoder_A
    new.6 = encoder_B

  ' reads encoder-sw and menu_SW, leave enc-Bits unchanged
    read_sw
    if rSwP then exit do

  'if no change, no button, keep looping
 loop while new = old

 if rSwP then return

 ''' -----------------------------------
 'to get direction of rotation
 'XOR right bit of new vs. left bit of old.
  directn = FnEquBit(new.6 XOR old.7)

   if directn = 1 then
    ' encoder turned CW
     delta++
   else
     ' encoder turned CCW
     delta--
   End if

  'copy new into old.
   old = new & b'11000000'

 end sub

 sub read_sw

   ' returns flag rSwP if any switch is activated

   ' additional:

   ' Encoder-Switch action as
   ' either  eShortP, eLongP, elLongP or eDoubleP

   ' Menu-Switch action as
   ' mSwP if only menu-button pressed

   ' combined action of menu- and encoder-switch
   ' mSwP & meSwP if encoder_Sw is pressed during Menu_Sw is active

   DIM ii as byte
   DIM short as Byte   'duration of short push for eShortP
   DIM eLong as byte   'duration of medium(long) push for eLongP
   DIM inter as Byte   'duration of pause between push for edoubleP


   short = 35  ' < 350 ms
   elong = 50  ' < 500 ms
   inter = 35  ' < 350 ms


   ALL_OFF 'reset all flags

 ' no button pressed , no action
   If Menu_sw = 1 and Encoder_SW = 1 then Return


 ' which Switch pressed ?
   If Encoder_SW = 0 & Menu_Sw = 1 then 'only encoder_SW pressed

      'set reminder of Swich pressed
       rSwP = ON                 ' switch pressed

       ii = 0

       do while Encoder_sw = 0


         wait 10 ms
         ii++
         if ii > eLong then DisplBlink  ' time > 500ms

       loop

     ' look for taken actions of encoder_SW
       if ii < short then       ' short press, <350ms

         eShortP = ON

       else if ii < eLong then  ' long press, >350 and <500ms

         eLongP = ON

       else

         elLongP = ON           ' long long press, >500ms

       end if


     ' another button press after short release?

       if eShortP then             ' first press <150ms

        ii=0

         do while Encoder_sw = 1  ' count length of pause (<350ms)

          wait 10 ms
          ii++

          If ii > short then exit Do ' > 350 ms

         loop

         If ii < short then      ' short pause <350ms, second press may follow

           ii = 0

           do while Encoder_sw = 0  ' wait for second button press

             wait 10 ms
             ii++

           loop

           if ii > 10 then          ' this was a second press > 100ms ...

            eShortP  = 0
            eDoubleP = 1          ' so this is double press

           end if

         End if

       End if

   end IF

   if Menu_SW = 0 & Encoder_SW = 1 then ' only Menu_SW pressed

       wait 50 ms              ' debounce
       rSwP = ON               ' any switch flag is set
       mSwP = ON               ' Menu-switch flag is set

     do while Menu_SW = 0      ' wait for Encoder_SW

       IF Encoder_sw = 0 then  ' now encoder-switch pressed

         wait 50 ms
         meSwP = ON            ' combination of menu_SW and encoder_SW
         mSwP = OFF            ' so only combination is registered

       End IF

     loop

     ' returns rSwP AND mSwP only menu-Sw pessed
     ' or returns rSwP and meSwP if combi ocurred

   end if

 end sub

 sub displBlink

  LCDCURSOR LCDOFF
   wait 100 ms
  LCDCURSOR LCDON

 end sub
