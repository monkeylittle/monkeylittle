---
layout: post

title: Arduino Starter Kit - Day 1
author: john_turner
featured: false

categories:
- Ramblings
---

My wife recently bought me an [Arduino](http://www.arduino.cc/) Starter Kit from [Earthshine Electronics](http://www.earthshineelectronics.com/) and I have been keen to start playing around with it.  Despite doing some electronics in university I have absolutely no idea where to start but there was a free book (downloadable PDF) that accompanied the kit.  I downloaded the book and followed the instructions to install the Arduino IDE and verify that the Arduino board was functioning.

**Project 1** in the book involved connecting an LED and resistor to the board (using a breadboard) and writing a short sketch to make the LED blink every second.  While it was pretty straight forward, I was quite pleased when it all went to plan (I think trouble shooting would be beyond me at this stage) and the little red LED started to flash when I uploaded the sketch to the Arduino.  The book then reviews the C code (which I skimmed over) before providing an overview of the hardware for the project.  Its on the hardware side that I will find my challenge so I needed to read this section carefully.

**Project 2** used the same hardware configuration but changes the sketch to signal S.O.S in Morse Code via the LED.  Given this only involved a rather simple sketch and the same hardware configuration I did not find this interesting.  On to the next project.

**Project 3** simulates the light sequence on a set of UK traffic lights; that is, red, red-amber, amber and green.  Given the two previous projects this was pretty straight forward.  Different resisters were used this time so that the LED's were not as bright as in the previous projects.  Given the additional components, I can see now why a strong table lamp is a necessity for this type of activity. Anyway, I'll press on without one.

**Project 4** adds a set of pedestrian lights (red and green) and a push button to the previous project.  Steady state shows the traffic green and the pedestrians red.  On pushing the button, the traffic is shown amber then red.  The pedestrians are then shown green.  After a little time passes the green pedestrian light flashes before changing to red.  The traffic lights then transition to amber and then green thus completing the sequence and returning to the steady state.  The circuit was straight forward although given the number of components I had to recheck the connections a couple of times.  I also made the mistake of placing and LED the wrong way around thus it did not illuminate.  This was easy to detect and diagnose.  The code itself was fairly straight forward.

**Project 5** creates a LED chase effect.  Both the hardware and sketch are straight forward but given it uses 10 LEDs and 10 resistors it is fairly time consuming.  I worked through it anyway for completeness.

So far it has been fun learning about the Arduino and I'm looking forward to working my way through the other projects in the accompanying book.  It's getting late so time to pack up for today.  Hopefully I'll get some time over the Christmas holidays to tackle the rest of the projects.
