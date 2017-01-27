---
layout: post

title: Pipes and Filters, Routing Slips and Message Filters
author: john_turner
featured: false

categories:
- Enterprise Integration
---

Following on from the example described in [To Sequence or Not To Sequence]({% post_url 2013-02-14-to-sequence-or-not-to-sequence %}), it is worthwhile introducing a couple of additional messaging concepts (and try to ring the neck out of the analogy!)

The airline check-in procedure could be considered a message pipeline (see [Pipes and Filters](http://eaipatterns.com/PipesAndFilters.html) in which filters have not yet been identified.  A filter in this context is a mechanism through which some processing is triggered by the arrival of a message (as opposed to a [Message Filter](http://eaipatterns.com/Filter.html) which removes the message from the pipeline).

![Airline Check In Procedure](/assets/images/posts/pipes-and-filters-routing-slips-and-message-filters/airline-check-in-procedure.png)

In the airline check-in procedure there are 6 pipes (including the pipe to the first filter and from the last filter) and 5 filters.  This is a very basic message pipeline.  Lets add a bit of complexity.

The first concept to add is that of a [Routing Slip](http://eaipatterns.com/RoutingTable.html).  At check-in, depending on the flight status the check-in clerk will offer some direction.  They may tell you to go directly to your gate as soon as you have passed security.  You might consider this to be the clerk providing a routing slip that directs you to bypass eating a meal.

In a messaging system, routing slips are often added to messages based on some known context, the message type or the message content.  In our example, the context provides the input into the routing slip.  Another example might be that of a business class passenger who may be directed to the business lounge for their meal.

Lets change the diagram format to use the notation adopted by Gregor Hohpe and Bobby Woolf in Enterprise Integration Patterns.

![Routing Slip](http://thoughtforge.net/wp-content/uploads/2013/02/Routing-Slip.png)

You can see in the diagram above that a Routing Slip is implemented at check-in that will conditionally bypass the eat meal step.  What is interesting here is that the Routing Slip is added the step before [Content Based Routing](http://eaipatterns.com/ContentBasedRouter.html) occurs.

One final use case worth demonstrating using this analogy is that of a [Message Filter](http://eaipatterns.com/Filter.html).  In the event that security retain someone for one reason or another what should happen?

![Message Filter](http://thoughtforge.net/wp-content/uploads/2013/02/Message-Filter.png)

In messaging terms this is called a [Message Filter](http://eaipatterns.com/Filter.html).  A message filter is used to remove undesired messages from a channel.  But, how does this work in the context of the sequence we described in [To Sequence or Not To Sequence]({% post_url 2013-02-14-to-sequence-or-not-to-sequence %})?  How does the [Resequencer](http://eaipatterns.com/Resequencer.html) know that this message (or person) will not arrive at the Board Plane step?

Typically, the Message Filter will send a Shadow Message which will include the Message Sequence but no further detail. In this way, when the Shadow Message is processed by the Resequencer it will instruct the resequencer to await the next message in the sequence.
