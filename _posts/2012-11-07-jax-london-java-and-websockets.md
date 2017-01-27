---
layout: post

title: 'JAX London: Java and WebSockets'
author: john_turner
featured: false

categories:
- Ramblings
---

Two of the [JAX London](http://jaxlondon.com) sessions addressed the subject of Java and WebSockets.  The first of these sessions [HTML 5 WebSockets and Java](http://www.slideshare.net/jaxlondon2012/html5-websockets-and-java-arun-gupta) was presented by Arun Gumpta from Oracle and he focussed on the work he was involved in to create a standard Java API for WebSockets (i.e. JSR 365).

This very informative session provided background including what are WebSockets, what is driving the demand for WebSockets and what is the current level of adoption of WebSockets by browsers and application servers.

Arun then provided a walk through of the JSR 365 API using a number of examples and code snippets.  One of the things that I found a little uncomfortable was the number of synergies with JAX-RS and the fact that there was very little consolidation of syntax for what was often semantically the same.  It is conceivable that a RESTful service would want to provide asynchronous updates using WebSockets and from what was presented the divergent API would make implementing this a little more challenging.

Putting that concern aside Arun did a great job of introducing WebSockets and the work Oracle were doing on JSR 365.

Steve Millidge of [C2B2](http://www.c2b2.co.uk) presented the second session (*Data Grids and WebSockets: Delivering Real Time Push at Scale*).  This session demonstrated the use of a data grid (Oracle Coherence) to propagate updates via WebSockets to a number of clients.  There was a fair degree of overlap in that both sessions spent some time introducing WebSockets but this was not an issue or me as the message was consistent and one reinforced the other.  In addition to WebSockets, Steve spent some time introducing JSR 107 and Oracle Coherence.  What made the talk particularly engaging was the example used to relay the concepts.  The example demonstrated capturing updates to stork prices stored in the data grid.  Updates were then propagated via Web Sockets to all clients viewing these stock prices (on a browser).  As part of the exercise, I was able to view the updates on my phone.

I found Steve's talk interesting and the demo was quite engaging.
