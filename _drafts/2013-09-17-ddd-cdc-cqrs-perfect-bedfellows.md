---
layout: post

title: 'DDD, CDC &amp; CQRS: Perfect Bedfellows?'
author: john_turner
featured: false

categories:
- Enterprise Integration
tags:
- CDC
- CQRS
- DDD
---

Today in business, we are seeing with more and more regularity that the young upstart is out manoeuvring the established players in multiple verticals.  In the automotive industry we see the established players looking over their shoulder at companies such as Tesla.  In banking we see new and innovative funding models as well as a relentless drive to reduce transaction costs in the area of payments.  And in entertainment we see low-cost streaming services disrupting the TV, film and music markets.

The reason we often hear cited is that incumbent players have grown fat of the land and now they are slow and cumbersome, unable to adapt quickly to evolving market demands.  Some of that fat takes the form legacy systems that have become behemoths over the years.

It's easy to defend most of those legacy systems.  They work and they have been working for years.  They often enforce business rules and logic that have been forgotten, even by those with the longest tenure.  They don't cost anything either because most of the cost has been incurred years ago.  That is of course unless you want to change them...and you will!

Many such systems are the heartbeat of their organisation and as such they are changed with much trepidation.  Most of those who knew the system well have left the company, retired or are at one with their maker.  Those who remain are as lethargic and expensive to maintain as the system themselves.  So what options are left?  One such option is to build a facade using Domain Driven Design (DDD), Change Data Capture (CDC) and Command Query Responsibility Segregation (CQRS).

<!-- more -->

**Domain Driven Design**

Domain driven design is a software design approach that places the emphasis on accurately modelling the business domain and implementing that model within the software itself.  One of the concepts within DDD is that of a domain event.  A domain event captures the occurrence of something significant that happened within the business domain.

In banking a Transaction would be a particularly useful domain event.  Having defined the event, the transaction system (of which there may be 1 or more) publishes the event for those who may be interested.  In this case the fraud detection system, the ledger system and the personalised offering system may all be interested in a particular transaction.  This is great because as a system interested in Transaction events I no longer need to integrate with each and every transaction system.  Those systems behave like good citizens and publish events of interest.

There are a couple of significant characteristics of this approach.  The first (which may be a bit obvious) is that the source of the events has to explicitly publish the event.  The second is that consumer has to explicitly consume the event and possible store the information of interest locally (because there is no way to pull the data).  The third, and most important, is that by employing this approach we have increased the inconsistency window (more on this later).

**Change Data Capture**

I've said that the source of events must emit events on the occurrence of a something significant.  But I've also said that legacy systems are expensive to change and are changed with significant risk.  So how do we modify the source system to emit the events?

One way to achieve this without changing the system is to capture data changes using change data capture tools which in turn publish the domain event.  Typically, CDC tools monitor database updates and on detection of a change that is of interest they publish the event to a messaging system.  Some CDC tools can perform the change detection with relatively low overhead and so impact on the legacy system is manageable.

But what do we do with those domain events?

**Command Query Responsibility Segregation**

What is now possible, is that we can create local data sources and synchronise those data sources through consumption of domain events.  The fraud detection system, the ledger system and the personalised offering system all have their own local copy of the data and can operate upon that data without much consideration of where the data came from or who else is using the same data.  This is the Query part of CQRS...but what about the Command part?

![Command Query Responsibility Segregation](/assets/images/posts/ddd-cdc-cqrs-perfect-bedfellows/command-query-responsibility-segregation.png)

Domain events help distribute updates to interested parties but what if those interested parties want to perform updates (or invoke commands)?

If we can think of a Debit or Credit being a domain event representing something that happened we could also think of a Debit or Credit being an unfulfilled request.  The messaging system could route the request to the most appropriate execution venue.  An adapter would be required to consume the request and action it.

The other option is to expose a facade in front of the legacy system that clients call to invoke a command.  The advantage here is that the facade can expose a synchronous or asynchronous interface whereas domain events are inherently asynchronous.

Whichever Command approach you chose opens a new possibility.  That is enriching the service offering of the legacy system.  For example, I could implement a facade that allows me to limit spend on transaction types.  Wouldn't that be cool?  Your bank manager is actually stopping you buying a round of drinks when you've had one too many!!  And you didn't have to change the legacy system.  Say hallelujah!!
