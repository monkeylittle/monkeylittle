---
layout: post

title: REST in Practice
author: john_turner
featured: false

categories:
- Book Review
- Representational State Transfer
---

<img src="/assets/img/post/2011-11-09-rest-in-practice/book-cover.jpg" class="pull-left img-fluid img-thumbnail mr-3"/>

Ever since Fielding published his dissertation on [Architectural Styles and the Design of Network-based Software Architectures](http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm), the momentum behind the Representational State Transfer (REST) architectural style has been building apace. Of course, as with the many new technologies, practices and theories adopted by the software industry, REST is progressing along what Gartner call the [Hype Cycle](http://en.wikipedia.org/wiki/Hype_cycle).

Since Fielding's dissertation, REST has been adopted widely by the software industry and a number of frameworks have evolved that support the development of RESTful services on today's platforms. The availability of frameworks to simplify the implementation of RESTful services has further accelerated the adoption of REST.

As with any new technology, creating frameworks that make it easy to adopt that technology can, and in the case of REST has, become a double edge sword. I say this because making technology adoption easy also makes it easy for those implementing that technology to get by with a minimum of understanding. 'REST in Practice' aims to inform those adopting REST by providing a compressive guide to REST and building the readers knowledge progressively from start to finish.

<!-- more -->

**The Web as a Platform for Building Distributed Systems**

Rest in Practice begins by providing a high level description of the infrastructure of the web including resources, URIs, caching etc. The term 'Resource' is defined along with its relationship to URIs. Resources are of course fundamental to REST and it is important to distinguish between a resource and its representation. Brief mention is given to how the web supports loose coupling, business processes, consistency and scalability. The introduction of the Richardson Maturity Model is particularly useful in understanding what level your REST services are at and where you might need them to be. The notion of *hypermedia as the engine of application state* is introduced as part of the model and is covered in more detail later.

**Introducing Restbucks**

I often find that technical books are easier to follow when an example is taken from conception to completion as part of the learning experience. Rest in Practice leverage's the same example Gregor Hohpe used when explaining interaction patterns ([Your Coffee Shop Doesn't Use Two Phase Commit](http://eaipatterns.com/docs/IEEE_Software_Design_2PC.pdf). For me personally, this was a good choice as it was a scenario I was already familiar with having read Enterprise Integration Patterns and associated material on the companion web site. More generally, it is an easy scenario to follow and something most people can relate to.

The scenario interactions and message formats are described before briefly introducing the modelling of protocols and state transitions.

**Basic Web Integration**

The public API of a REST service consists of URI templates and the message payload (headers and body) definitions. URI templates should strive to be intuitive and URI tunneling is discussed in detail in the context of the Restbucks example. The fundamental properties of the GET verb frame the discussion on why not to use URI tunneling to modify a resource.

A number of other integration approaches are described including XML over HTTP and XML-RPC.

**CRUD Web Services**

CRUD Web Services sit at level two of the Richardson Maturity Model**.** The majority of REST services I discuss with colleagues or interviewees would sit at this level. Often it is the case that little awareness exists of more sophisticated services. CRUD services are what most people think of when REST is mentioned. The HTTP verbs POST, GET, PUT and DELETE are introduced as are there utilisation within a RESTful service. Once again, these concepts are placed in the context of the Restbucks scenario.

For the most part this chapter does not introduce anything new. Of more interest was the application of ETag and If-Match headers to provide safety and idempotency. Interestingly, the chapter rounds up by stating that 'CRUD is good, but it's not great'. I tend to agree!

**Hypermedia Services**

Things start getting interesting when the authors introduce hypermedia services and the domain application protocol. A domain application protocol specifies the legal transitions from one resource to another. It informs the consumer of a resource of available transitions to other resources in the same way the html links inform a web browser of transitions to other web pages. Within the context of an enterprise application, this facilitates the representation of state machine like behaviour.

An immediate impact of providing hypermedia services is that consumers now only need to know how to enter the system. They will then transition to other resources via links embedded in resources. This reduces the coupling between the consumer and the application (because only the semantic meaning of the links are shared, the location can be changed without any impact on the consumer..they just follow the new link).

The value of hypermedia services are brought to life when applied to the Restbucks scenario.

**Scaling Out**

One of the most impressive characteristics of the web is its shear scale. When talking about the web as a platform, it would be remiss to omit how its scale is achieved and how this might apply to scaling RESTful services within an enterprise. The scale of today's web can be attributed in part to the caching mechanisms employed by its infrastructure and the HTTP protocol itself. As anyone who has built a caching solution of any significance can testify, caching is a complex business that involves decisions on the sensitivity of the data, liveliness of data, expiry policies etc. These topics are discussed in the context of RESTful services.

**The Atom Syndication Format**

The typical enterprise approach to building event based systems is to utilise a messaging system of some form or other. Messaging systems that support point-to-point and publish subscribe paradigms are perfect for this type of requirement. On the web, Atom Syndication can also be used to the same effect and this is described in detail with examples in Java and .NET.

**Atom Publishing Protocol**

Building on the previous chapter, the atom publishing protocol is is described as a 'domain application protocol for publishing and editing web content'. I'm not completely convinced about the advantages above an beyond those provided by HTTP itself.

**Web Security**

A layered design is used to provide a robust approach to security on the web. This starts at the transport layer with SSL and is built upon at the protocol later through the Basic and Digest authentication mechanisms provided by HTTP.

Significant air time is given to OpenID and OAuth which I did not find entirely interesting. In most enterprises, other mechanisms will already have been established and be leveraged by any RESTful service implementation.

**Semantics**

Having recently completed a course on knowledge based systems and the semantic web I found the discussion on semantics interesting. That said, I'm not sure that most people will find it entirely relevant as semantics will typically be agreed as part of a RESTful service specification as opposed to dynamically. Nevertheless, those with an enquiring mind or an interest in the future of the web will find this chapter interesting.

**The Web and WS-***

A lot of people who come to look at REST have previous experience of the WS-* stack. This section reviews some elements of the WS-* stack and provides a comparison with REST. The similarities between the two approaches are also identified before a discussion on the differing approaches to security and transactional messaging. Finally, WS-* is placed at level 1 on the Richardson Maturity Model.

**Building the Case for the Web**

The authors wrap up by 'building a case for the web'. They align the proven features of web architecture to the requirements of enterprise architecture. This includes attributes such as scale, latency, cost and security.

**Thoughts**

It has only been in the last year or so that I have started to utilise REST and before that I had only a cursory knowledge of the architectural style. Then a requirement landed that had REST written all over it but I needed to know more before pinning my colours to the mast. To this end I looked for some learning resources that would fill the gaps in my knowledge and I found this book was a great aid. I read it cover to cover and found each chapter built on the next to provide a comprehensive understanding of the fundamentals.

I find often that when I discuss REST with those who have been utilising frameworks such as JAX-RS etc. that there is often a gap in knowledge of the fundamentals of REST and the maturity of REST services. In particular, I'm disappointed that few are aware of the Richardson Maturity Model or of the notion of *hypermedia as the engine of application state*. Having read this book, I now know that building CRUD services is only the entry level of what REST services can be. If you think you are doing REST but are not sure what the fuss is about, read this book and get a real understanding of the power of REST.
