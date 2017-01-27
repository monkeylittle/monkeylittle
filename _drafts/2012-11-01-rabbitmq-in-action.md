---
layout: post

title: RabbitMQ in Action
author: john_turner
featured: false

categories:
- Book Review
- Enterprise Integration
---

<img class="alignright size-full wp-image-2548" src="http://www.monkeylittle.com/wp-content/uploads/2015/04/RabbitMQ-in-Action.jpg" alt="RabbitMQ in Action" width="255" height="320" />

Subsequent to the acquisition of Spring by VMware it was interesting to observe the increasing support for software such as RabbitMQ and GemFire.  My interest in AMQP and RabbitMQ has increased steadily over the past couple of years as the internet chatter on these topics increased.  This book was published earlier this year and given I've grown to like the format of the "in Action" series I spent a bit of time reading through it and trying out the examples.

**1. Pulling RabbitMQ out of the Hat**

The book begins by providing a history of messaging.  This starts in the early 1980's with Teknekron (and TIB) and evolves to having a number of messaging implementations in the late 1990's.  In  2001 an effort was made to standardise the API for messaging implementations through JMS.  Even with a standard API, interoperability between messaging implementations was limited because the messaging protocols were proprietary.  In 2004, JP Morgan Chase started implementation of AMQP which was to be an open standard for messaging protocols.  In 2006, Rabbit Technologies was founded to create a messaging broker that would adhere to the AMQP standard.

The obligatory installation guide follows.  Installation of Rabbit was straight forward and I was up and running in a matter of minutes.

<!-- more -->

**2. Understanding Messaging**

Standard definitions of a message consumer, producer and broker are provided so as to reinforce a common vocabulary for the rest of the book.  The author goes on to define queues, exchanges and bindings.  As AMQP is sufficiently different from typical JMS providers it is worthwhile spending the time to understand these concepts.

Message durability (and durability of administered objects such as queues and exchanges) is also treated differently by AMQP.  All these things add up to providing a great degree of flexibility in how to install, configure and utilise Rabbit.  As always with this added flexibility there is an increased responsibility to understand the consequence of the choices that are made.  Many of these consequences are clarified in subsequent chapters.

**3. Running and Administering Rabbit**

RabbitMQ is written using Erlang and so an understanding of the Erlang node is required in order to run and administer Rabbit.  This is not too onerous and the reader is quickly walked through how to start and stop both the Erlang node and the RabbitMQ application.

You are introduced to RabbitMQ security administration and shown how to create, add and view users and user permissions.  You are also given a brief introduction to viewing statistics and the RabbitMQ logs.  While this is useful, I think it is only when you are using RabbitMQ in anger that you will really get a feel for this material.

**4. Solving Problems with Rabbit: Coding and Patterns**

Here we are given an overview of some common message exchange patterns.  The patterns themselves are nothing new to anyone who has worked with messaging systems but it is still worth a read.  The exchange binding example that describes the routing of alert messages is extremely useful in understanding the value of using this approach to binding and routing.  If you are coming from a JMS background and have little experience of ESB technologies you will probably find this quite novel.

**5. Clustering and Dealing with Failure**

With RabbitMQ, clustering was straightforward to set up and I was able to follow the material and establish a cluster on a single machine reasonably quickly.  More detailed explanations of exchanges and their operation are provided.

Disk nodes and RAM nodes are introduced in the context of clustering and durability.  Disk nodes allow exchanges, queues and messages to survive cluster failure while RAM nodes offer higher performance characteristics as artefacts are stored only in memory.  As with AMQP and RabbitMQ in general, the decision of how many disk nodes and RAM nodes in a cluster adds more opportunity to make the wrong decision.  However it also allows more opportunity to leverage the advantages afforded so that's the trade off.

I also set up a cluster on 3 VM's (2 Disk nodes, 1 RAM node) and again this was relatively straight forward.  It was also useful to have for the examples that followed.

Mirrored queues are an important feature if you want to achieve greater resilience as they allow for queues (and messages) to exist on more than one node (you have the flexibility to specify the replication factory).  In the event of node failure the client can reconnect to the mirrored node.

**6. Writing Code that Survives Failure**

Most of the onus for surviving node failure falls on the clients (producers and consumers) of RabbitMQ although the RabbitMQ nodes are required to be clustered and accessed via a HTTP proxy.

The producer and consumer must be able to detect failure (via the RabbitMQ client) and decide on what action they want to take (e.g. stop processing messages, delay processing messages, raise an alert, try to reconnect etc.).  The producer and consumer also decide if the queue or messages are durable and survive node failure.

**7. Warrens and Shovels: Failover and Replication**

A warren is described a a pair of active/passive standalone servers with a load balancer fronting them.  When the active server fails the load balancer will route subsequent traffic to the passive server.  This has the advantage that the servers share nothing and so whatever might have impacted the first will not infect the second (that logic does not necessarily sit well with me).

A shovel is used to replicate messages across networks that experience latency.  Replication is asynchronous and as a result does not impact the performance of the master node (but can mean that some loss might occur).  A shovel is a message bridge (in EAI terms) and is often used to replicate messages across data centres for DR.

This is the one example that I did not implement as I was progressing through the book but the explanation and instructions seemed to be comprehensive.

**8. Administering RabbitMQ from the Web**

The RabbitMQ management plugin provides a web console through which you can monitor the RabbitMQ cluster.  The management console provides a detailed view of the nodes, exchanges, queues, messages, connections etc. in your cluster.  I found it to be really useful when I was exploring the capabilities of RabbitMQ.

<img class="aligncenter size-full wp-image-2550" src="http://www.monkeylittle.com/wp-content/uploads/2012/11/RabbitMQ-Management-Console1.png" alt="RabbitMQ Management Console" width="870" height="823" />

The book walks through use of the console to perform some typical administration tasks.  I found the console very intuitive to use though.

**9. Controlling RabbitMQ from the Web**

RabbitMQ provides a REST API to facilitate programmatic control via applications and scripts etc.  From the material presented there are two main use cases for this.  The first is for use by configuration management tools like Chef and Puppet and the second is for monitoring.  It appears that you can access most of the functions that were accessible from the management web console.  The book described a subset of the API but to be honest I kind of switched off as it was not something I was particularly interested in at the time of reading.

**10. Monitoring: Houston we have a Problem**

The author demonstrates monitoring of a number of aspects of RabbitMQ using Nagios and python scripts that accessed the information through either AMQP or the REST API.  The coverage of the topic was adequate to get someone started and it is certainly useful to present this information.  The examples were relevant and easy to follow.  The material was also presented in a way that it was equally applicable to any monitoring tool.

I also spent some time installing Hyperic and found there was a shorter lead time to being able to monitor the key health metrics of RabbitMQ.

**11. Supercharging and Securing your Rabbit**

When learning about a new messaging system most will spend some time focusing on performance.  Personally, I was more interested in the AMQP protocol and the benefits of using a protocol that has features like dynamic provisioning of administered objects etc.  However, an introduction to the subject of RabbitMQ performance was provided and outlined some areas to focus on should you require low latency and/or high throughput from RabbitMQ.  Some of these areas are the same no matter what messaging system you chose (message durability and acknowledgements) though others were specific to RabbitMQ and Erlang.

AMQP provides security during transport by using SSL and the book explains how this is implemented within RabbitMQ and also how to enable SSL (through installation of certificates etc.)

**12. Smart Rabbits: Extending RabbitMQ**

The book concludes with a description of RabbitMQ plugin management.  Some of the previously described features such as the management console and shovel are not provided by RabbitMQ itself but by plugins.  A repository of these plugins allows administrators to extend the functionality of RabbitMQ.  It is also possible to write your own plugins or indeed implement your own type of exchange.  While the information was useful for completeness it was not something I ever envisage needing.  Nevertheless, as with the rest of the book the material was well presented and easy to understand.

**Thoughts**

I worked through all of the examples in the book including setting up a fault tolerant cluster and implementing resilient consumers and producers.  I was impressed with both the ease at which I was able to perform these tasks and the flexibility that was provided by RabbitMQ.  The guidance and insight provided by the book was comprehensive and I did not need to go outside this material at any stage.

RabbitMQ provides a greater degree of flexibility to the administrator and developer than they may have been used to if they previously worked with JMS providers.  While it is great to have this flexibility it also forces you to be aware of the consequence of the decisions that you make (or don't make).  The book does a good job of explaining the relevant information to the reader.

If you are starting out with RabbitMQ you should pick up a copy of this book.  As with most of the O'Reilly "in Action" books the tutorial style is conducive to following along with the worked examples.
