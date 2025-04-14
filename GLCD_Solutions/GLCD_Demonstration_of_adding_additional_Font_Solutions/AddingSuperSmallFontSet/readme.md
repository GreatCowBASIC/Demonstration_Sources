# Tiny Fonts, Big Challenges: A Developer's Tale

Roger Jönsson was working on a small game and stumbled upon a rather unique challenge with his tiny 0.49" OLED SSD1306_64x32 screen. While trying to add some text for a score display, he realized how much memory was being consumed—just adding the first character would eat up about 1 kword of program memory!

Determined to find a solution, he set out to create a custom tiny font that would save precious space—both on-screen and in the chip. By focusing on the essentials and designing 3x5 pixel characters, he managed to save over 600 words of program memory by keeping only uppercase letters, and more than 700 words by sticking to digits alone.

## Here’s how it works:
- Each character is **3 pixels wide** and **5 pixels tall**.
- The bit pattern is stored **column-by-column**: bottom to top (left, middle, and right columns).
- While the font does use a little extra RAM (>30 bytes), the memory savings more than make up for it!

## The Result?
A super “cheap” font that is... well, let’s just say it’s barely readable, but it gets the job done!
