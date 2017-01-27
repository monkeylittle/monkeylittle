---
layout: post

title: 'SpringOne 2GX: Messaging for Modern Applications'
author: john_turner
featured: false

categories:
- Spring Framework
---

I've spent much of my career working on application integration projects and the technologies and techniques have changed much in that short period of time. I've used a variety of transports, message formats and protocols and these are continuing to change with the requirements from modern applications.

The [Messaging for Modern Applications](http://www.infoq.com/presentations/Messaging-for-Modern-Applications) session at [SpringOne 2GX](http://www.springone2gx.com) starts by talking about the trends in modern applications. Much of this reiterated the information in the key note session by discussing the diversifying of user platforms and applications, massive scale of data requirements and the continuing emergence of Cloud computing. Tom McCuch points out that synchronous communication protocols have often led to brittle architectures that evolve slowly. Much of this is due to the fact that often components are coupled in time, their release cycles require significant co-ordination etc. Components are typically stateful leading to scalability challenges that can be met by asynchronous architectures that retain state within messages passed between components. I tend to agree with this assertion (generally!).

Moving on, Tom speaks about Spring Integration and its ability to simplify building of messaging application components. I've used Spring Integration many times before and found its alignment to the Enterprise Integration Patterns catalog (see www.eaipatterns.com) and the messaging DSL meant a reasonably gentle learning curve for what is a very powerful framework. Coupled with Spring Bean Profiles this creates a great mechanism for decoupling the messaging implementation so that different implementations can be used in different environments (particularly useful for integration testing). The tried and tested Coffee Shop demo was adapted and wheeled out to demonstrate many of the concepts.

I was particularly interested in the section focusing on AMQP and its support within Spring Integration and RabbitMQ. As with the rest of the Spring portfolio, Spring Source are working to make it easier to deliver applications using these technologies from concept to production. This all encompassing approach is one of the reasons Spring has become so popular and it's good to see that this has not changed.

One of the slides presented contained a statement that really rang true for me. It was that "Existing middleware impacts agility by tightly

coupling applications to underlying application server and other middleware components". Again, I would agree that there are few exceptions to this statement. Of course, Spring Integration aims to reduce this coupling through its many abstractions in the same way that Spring did for J2EE.

Tom finished up this session by discussing RabbitMQ. He briefly covered its support for AMQP, clustering, federation etc. It peaked my interest enough to look into it further.

**Thoughts**

Similar to the key note session, I found the content really interesting. For such as session I think the pace was a little slow and Tom could have rattled through the material a little faster. Worth a watch if you can spare the 90 minutes it runs for.
