From: TJ <hq72au@gmail.com>
Sent: Friday, November 29, 2024 4:34:35 PM
To: Steve Scott <Sscott@scott.gallery>
Subject: Re: STLED316S 
 
I see now.
I suggest you study my library for the TM1637/8.
Start by copy/paste subroutines & code blocks then if need mod the lib. to 316s
Being structured code(subs) it is easier to use & modify. There is some interaction between subs but it is easy to  find (the other sub name will be called)

There are 3 sections 
1.  Hardware Driver code:     
     - Set/Read the pin states for clk & data (8 bit I2C like)

2.  TM1637 Message Processor:
     - Build TM1637 serial messages for Hardware Driver section  (multiple bytes) 

3.  Command Library
      - This is a collection of subroutines (commands for user program), it simplifies user code & reduces coding time. Ideal for novice to use with existing hobby boards.
      - 

If the 316s is I2C then you first need to reverse the bit order in 1. HW driver.
Change values for commands, address values(if needed) & other specific structure for 316s in 2. Message Processor.
Start with the very minimum code needed to see some result.

Recommend you get a Logic scope & PulseView (or other logic software)
This is the one I got (there are many others )
https://www.aliexpress.com/item/1005003152258170.html
(this specific one is just the module(no clips or USB cable)

Welcome to ask any specific questions.
      
   




 

On Thu, 28 Nov 2024 at 22:32, Steve Scott <Sscott@scott.gallery> wrote:
Toni,
Thanks for the insight!  I did not know there was a way to convert C code to Basic.  I will look into both.
I have always written straight code with no idea to write an include.  Evan suggested I do this.
I have always been more of a hardware guy and I designed this board to explore GCB as well as learn Ethernet, and I added the 316s chip instead of my old stand in chip that only did 8 digits and no keyscan.
My goal is to get the 316s to work, send data, and have the data show correctly on the correct digit.
Further, to also use the keyscan as a benefit of 12 more keys with LEDs.
I asked Evan if he thought this board would be useful for others working with GCB and he seemed to think so.
Right now my focus is on the 316s chip, all other aspects I know and can do.
The ethernet will be the last.
Does this answer your question regarding what to do with the 316s?
Regards,
Steve

... viewing light with alchemy
See photos on my website; www.scott.gallery
Follow me on Instagram; @stolenlightimagery

________________________________________
From: TJ <hq72au@gmail.com>
Sent: Wednesday, November 27, 2024 9:40:21 PM
To: Steve Scott <Sscott@scott.gallery>
Subject: Re: STLED316S 
 
You are welcome Steve.
I wasn't able to get a full idea of what you need to do, nor the scope of requirements from information received from evan or the forum post. (did you have something working in another basic that needs porting to GCB or need new GCB code to talk to the ST 7-Seg chip)
The STLED316 & TM163x are very similar in many ways.(STLED316 may be LSB first?)

I mentioned the Arduino code just as a reference. At least *.ino files are easier to understand than native C. (except the way some people structure their code & use LeftShift to set register bits. grrr...)
I have used C++ to VB converter free version (tangible software), which gives me something I am familiar with.
or I have used chatGPT OpenAI to do a C to Basic convert.
Both only result in something to reference, not working code.

cheers.
Toni

On Thu, 28 Nov 2024 at 04:13, Steve Scott <Sscott@scott.gallery> wrote:
Thank you for this Toni.
I will try to work a solution but as I do not do C it will be a bit longer.
I deeply appreciate your interest in helping.
Regards,
Steve
