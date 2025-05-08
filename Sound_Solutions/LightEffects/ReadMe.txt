A few years ago psychedelic lights were all the rage. These lights would light up in time with the music, following the progression of the high, medium and low frequencies.
The circuit at the time used more or less complicated RC or RLC filters.
Now the signals can be analyzed using digital filters that, through mathematical calculations, divide the changed audio signal into the desired frequency bands.
I had written the program I am sharing in MikroBasic and, now that GCBasic supports floating point calculations, I have converted it for this compiler.
The software divides the audio band into four different frequency bands and drives four outputs.
I used a pic with a 32MHz clock to have a better performance with the musical progression.
Inside the source there are explanations on the operation and instructions for the connections of the micro.
