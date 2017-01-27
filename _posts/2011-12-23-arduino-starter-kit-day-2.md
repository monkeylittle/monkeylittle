---
layout: post

title: Arduino Starter Kit - Day 2
author: john_turner
featured: false

categories:
- Ramblings
---

Following on from my [first look at the Arduino]({% post_url 2011-12-20-arduino-starter-kit-day-1 %}), I freed up a few hours in my day to continue with the tutorial projects.

**Project 6** builds on the LED chase effect that was created by project 5 and adds a potentiometer that adjusts the speed of the chase.  Shame I dismantled project 5 when I finished up on day 1.  It took me a few minutes to reconfigure all the LEDs and connect them to the Arduino.  Once this was done attaching the potentiometer and the update to the sketch was quick and easy.  I skipped the two exercises at the end of project 6 as they were effectively programming exercises.

**Project 7** involves creating a single pulsating LED.  This is achieved by doing an analog write to the output pin (the output pin is a digital pin).  An interesting explanation of how we get a digital pin to behave like an analog pin follows with a description of PWM (Pulse Width Modulation).

**Project 8** creates a mood light that uses a clear red, clear green and clear blue LED  and adjusts the brightness of each to simulate a range of colours.  The sketch was interesting as it managed the transitions so that transitions from one colour to another were not too abrupt.

**Project 9** creates a fire effect using two yellow and a red LED.  The wiring and sketch are more basic than the last couple of projects so there really wasn't a lot to this project.

**Project 10** uses the same circuit as project 8 but uses the serial monitor to manually input commands to the Arduino.  Simple commands allow manual control of each of the LEDs individually.

**Project 11** puts away all the LEDs and starts to play with some of the other components, namely the Piezo Sounder and the terminal block.  The circuit is trivial but we start to see new functions within the sketch that control the Piezo Sounder.

**Project 12** uses the Serial Temperature Sensor to output temperature readings to the Serial Monitor.  There appeared to be an issue (which I could not find the source of) that caused my PC to freeze when I connected this circuit.  It seemed to be a problem with the sensor itself.  This was the first problem I had with the kit so far.

**Project 13** uses a light sensor to adjust the rate at which a LED flashes.  Normal service resumed and after putting together the circuit and downloading the sketch the LED reacted to the lighting as expected.  I'm a little relieved that there is nothing wrong with the board!

I'm not going to finish projects 14, 15 and 16 as the next thing I want to try is to control the Arduino from a Java program.  But that's for another day.
