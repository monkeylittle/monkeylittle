---
layout: post

title: Event Processing in Action
author: john_turner
featured: false

categories:
- Book Review
- Enterprise Integration
---

<img class="alignright size-full wp-image-2543" src="/assets/images/posts/event-processing-in-action/book-cover.jpg"/>

I've been building systems using MOM and ESB for most of my career but have very rarely considered those to be event processing systems.  When contemplating the design of a system I am currently working on, the concept of events (as opposed to messages) intuitively seemed to be a better fit.  There is a significant amount of sharing of concepts between these types of systems so  I was interested to learn what made an architecture an event processing architecture.  This led me to pick up a copy of 'Event Processing in Action'.

**The Basics**

**1. Entering the World of Event Processing**

The first chapter introduces event processing and contrasts an event based interactions with synchronous request driven interactions.  The concepts of event producers, consumers and intermediary event processing are covered briefly as are a number of event processing languages and tools.  The book utilises a fictional application (the Fast Flower Delivery application) to explain concepts throughout.  A high level description of the application is also provided.

**2. Principles of Event Processing**

Event processing (or even driven architecture) is discussed in the context of a number of high level principles such as decoupling, push-style interactions and channel based event distribution.  Using a request-response event distribution mechanism is also covered briefly.  Event processing and SOA (service-oriented architecture) are compared before diving in to the main building blocks of event processing i.e. event channel, event type, event consumer, event producer, event processing agent, context and global state.  The notation used to describe these element is also introduced and it is expanded upon throughout the remainder of the book.

<!-- more -->

**The Building Blocks**

**3. Defining the Events**

As the title suggests, this chapter focuses on defining event types and proceeds to define the event types utilised in the Fast Flower Delivery application.  Most of the material will be very familiar to those with a background in messaging systems although I did find the section on relationships between event types useful.  Those relationships are defined as membership, generalisation, specialisation and retraction.

**4. Producing the Events**

The notation for an event producer is detailed and each element used to describe an event producer is explained in some detail.  The event producers within the Fast Flower Delivery application are then documented using this notation.

**5. Consuming the Events**

Similarly, the notation for an event consumer is detailed.  The concepts of event producers and consumers are not novel, so again anyone with a background in messaging systems will skip through this section.

**6. The Event Processing Network**

An event processing network can be viewed as a flow diagram where events are consumed by input nodes and produced by output nodes.  The book describes agents operating within the event processing network that act upon events.  These agents include filter agents, transformation agents, pattern detect agents.  There are specialised transformation agents such as enrich, project, aggregate, split etc. which are similar to function to the patterns described in 'Enterprise Integration Patterns'.  I did not mind the similarity in concepts as there were interesting (however slight) differences between the concepts.  The  global state element is a significant addition to the other concepts as my experience is that global state is not adequately considered when designing event processing architectures.  Either this, or everything is considered global state which is equally problematic.

**7. Putting Events in Context**

Event processing agents typically operate within a certain context.  I found the discussion on context very engaging.  The four main dimensions of concepts are described as being temporal, spatial, state oriented and segmentation oriented.  Of course these dimensions can be composite so that context might be both temporal and spatial etc.

**8. Filtering and Transformation**

Next, filtering and transformation agents are discussed in greater detail.  The filtering agent is illustrated as having an input terminal and three output terminals.  Those are the filtered-in, filtered-out and non-filterable terminals.  Explicitly having a non-filterable terminal in the notation focuses on what to do with those events that are not filterable which ensures greater completeness in the design when using this notation.  Similarly, the transformation family of event processing agents are covered.  They include project, enrich, translate, split, aggregate and compose agents.

**9. Detecting Event Patterns**

Event patterns are a reasonably accessible concept but the number of variants of pattern detect agents is significant and take some time to explore.  This is when the Fast Flower Delivery application really adds value as having a tangible example helps to appreciate the subtleties of a number of the pattern detect agents.

**Pragmatics**

**10. Engineering and Implementation Considerations**

The stream oriented and rule oriented programming styles are introduced and both are reasonably familiar.  For me they are very similar to the way business process and business rules engines work.  I did not find anything new in the sections that focused on the non-functional characteristics of event processing agents/systems.

**11. Today's Event Processing Challenges**

The challenges described are again very familiar.  The challenges around temporal data and processing of same focus around the accuracy and consistency of temporal data.  For example, is time synchronised across all event processing agents and if not, how do temporal pattern matching agents process events produced by those agents.

**12. Emerging Directions of Event Processing**

The book concludes by briefly considering where event processing is going next.  For me, the most interesting point was that many of the concepts of event processing are already being leveraged with BPM, BAM, BI, MOM and ESB implementations.

**Thoughts**

One of the most useful things I took away from reading this book was the notation that was used to describe the elements of an event driven architecture.  I found the notation comprehensive and a useful tool to ensure that the essential elements of an event processing network are considered during the design and documentation of the network.

Many of the concepts were familiar, probably due to my experience with BPM, Rules, MOM and ESB implementations.  However, I felt the coverage of the concepts within the book was useful and there were subtle differences that lead me to think about those concepts in different ways.

I found the section on event processing context to be very interesting.  It's not something that is often explicitly considered when thinking about MOM or ESB implementations but it is almost always relevant.
