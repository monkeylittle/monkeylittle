---
layout: post

title: 'SpringOne 2GX: Implementing Scalable HA Architectures with Spring Integration'
author: john_turner
featured: false

categories:
- Spring Integration
---

Another session from [SpringOne 2GX 2011](http://www.springone2gx.com/) but this time focusing on Spring Integration.  [Implementing Scalable HA Architectures with Spring Integration](http://www.infoq.com/presentations/Implementing-HA-Architectures-Spring-Integration) is presented by Gary Russell and David Turanski who are currently working on a project with a significant element of enterprise integration for EMC.  A solid understanding of Spring Integration is assumed by the presenters and the focus is more on the application of Spring Integration to support 'Single Source' and 'Strict Order' processing of messages.  The presentation included the following topics:

- High availability architecture concepts
- Spring Integration basics
- Competing consumers
- Challenges with competing consumers

The high availability architecture concepts were presented to frame the session.  There was little depth of discussion or new ground covered.  The same could be said for the section introducing the basics of Spring Integration.  The guys did a good job of describing competing consumers and the challenges of using competing consumers for 'Single Source' processing.

For the remainder of the session Gary and David discussed the solution they were developing for EMC.  I was interested in particular to hear what the presenters had to say on the subject of 'Single Source' processing in a HA environment as we have similar problems to be solved at Paddy Power.  If you are new to this type of processing I think you will find the content a little difficult to follow and if you are not new to this you probably won't take a lot away from the discussion.

It was quite a frustrating session to watch as there was a significant amount of time spent trying to execute the demo application.  I would have liked if their own solutions were described more concisely and contrasted against some of the other solutions as leveraged by a number of peer-to-peer protocols such as chord.
