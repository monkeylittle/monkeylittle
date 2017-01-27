---
layout: post

title: To Sequence or Not To Sequence
author: john_turner
featured: false

categories:
- Enterprise Integration
---

In software engineering the concept of queueing is extremely important as it has a significant impact on the efficiency of a system.  There exists a massive body of research around queuing within various systems and associated approaches to reducing queuing or the perceived impact of queuing.

I was recently involved in a discussion about queuing in messaging systems and it caused me to consider some of the typical approaches to reducing or eliminating queuing.  One such approach is that of using a [message sequence](http://eaipatterns.com/MessageSequence.html) and a [resequencer](http://eaipatterns.com/Resequencer.html).  In this approach the order of messages that are queued is important i.e. the order in which they enter the queue must be the same as the order in which they leave the queue.

I've found queuing concepts are best explained using an analogy and in this instance a useful one is that of taking a flight (I'm not an expert in airline procedure so forgive any deviations from reality).  Lets assume that the procedure is as follows:

<img class="aligncenter size-full wp-image-1854" alt="Airline Check In Procedure" src="http://thoughtforge.net/wp-content/uploads/2013/02/Airline-Check-In-Procedure.png" width="450" height="82" />

**Booking Your Ticket**

To book a ticket you must log into the website, select the flight, pay the fee and print out the ticket.  For simplicity, the airline will allocate tickets using sequential seat numbers that increase from the back of the plane to the front.

**Check In**

Lets assume that everyone must check-in and the check-in process involves presentation of your passport and ticket.  The check-in agent will then take your bags, tag them and wish you a pleasant flight.

**Pass Security**

Having checked in you proceed to security where you place your belt, shoes, carry on luggage and dignity on the conveyor belt for scanning.  You pass through security, get dressed and hurry away embarrassed by the fact that the security personnel now know that you travel with your childhood teddy bear.

**Eat Meal**

Feeling a bit peckish, you head straight for the food mall were you devour breakfast before heading to the gate.

**Board Airplane**

When boarding the plane, you are asked to board in the order the tickets were issued.  In this way, people are not blocking others from getting to their seat because tickets were issued using increasing sequential numbers from the back to the front of the plane.

In this sequence, order is only important at the first and last steps.

**Maintain Strict Order**

One way we could make sure order is maintained is by maintaining a first in first out (FIFO) queue.  In this way I know that the first person (P1) to book a ticket is the first to check-in, the first to pass security...and the first to board the plane.  This would work but it results in queuing at every single step in the sequence.

For example, say P2 (the second person to book a ticket) arrives at check-in first, they will have to wait for P1 before they can check-in.  If they arrive at security before P1 they will have to wait again.  This sounds ridiculous and indeed it is.  However, this is often how order is maintained within a messaging system (though *sometime* with good reason).

The other way in which strict order could be maintained is to only let a single person enter the queue at a time.  This would mean P1 would book a ticket, check-in, pass security, eat a meal and board the airplane before P2 is allowed to book a ticket.  In this example this is crazy but in some messaging systems this can work.  It all depends on the activity within the chain.

**Sequencing and Resequencing**

An alternative would be to allow people to check-in in the order in which they arrive at the check-in desk.  They can also pass security and eat their meal in the order they arrive thus avoiding any queuing.  The removal of queuing makes for more efficient flow of people through the airport.

The price to pay for this is that order must be re-established before people board the airplane.

This theory can be directly applied to messaging systems.  The [Enterprise Integration Patterns](http://www.eaipatterns.com) catalogue refers to this pattern as the *message sequence* (booking your ticket) and *resequencing* (board the plane) patterns.
