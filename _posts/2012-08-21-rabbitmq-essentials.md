---
layout: post

title: RabbitMQ Essentials
author: john_turner
featured: false

categories:
- Enterprise Integration
---

I have been spending some time looking at AMQP.  One of the things that interests me about AMQP is the concept of an Exchange and the ability for clients to create and destroy resources.  A popular implementation of message oriented middleware that uses the AMQP protocol is RabbitMQ.  In order to learn a bit more about RabbitMQ I watched the RabbitMQ Essentials self-paced training (which at the time of writing is provided for free by VMware).

**1. Introduction to Messaging and AMQP**

The training presentation starts with and introduction to messaging and AMQP.  I've worked with JMS since it's initial release so most of this material was very familiar however it was worth the 10 minutes to recap.  This module provides a brief description of synchronousasynchronous communication and some of the characteristics of both.  It goes on to describe messaging and message oriented middleware and how it supports asynchronous communication (and why asynchronous communication is desirable within enterprise systems).  A (rather good) description of how components become coupling 'in time' is provided.

The section goes on to describe the JMS architecture and its main components i.e. Provider, Client, Message and Administered Objects.  Similarly, the AMQP architecture is introduced along with its main components i.e. Broker, Connection and Channel.  The concept of an AMQP Exchange is introduced along with a description of the exchanges supported by RabbitMQ (direct, fan out, topic and header exchange).

The module concludes with a description of the deficiencies of JMS.  I found this a little weak to be honest as for me, the biggest deficiency is that JMS is rather static in nature.  For example, you create a Connection Factory, Queue and Topic etc. as part of a deployment as opposed to dynamically at runtime.

**2. RabbitMQ Product Presentation**

This module provides a high level overview of RabbitMQ.  It lists the features of RabbitMQ as:

- Support for durable communication
- High availability
- Good throughput
- High scalability
- SSL support
- Access control
- Extensibility

It goes on to describe the installation process on Windows and the files that are created as part of the install.  These are categorised as configuration files, data files and log files.

The module wraps up with an introduction to the RabbitMQ management plugin and a short description of the management web interface, REST API and command lint utility.

**3. RabbitMQ Development**

This module walked through the development of a message producer and a message consumer using Java.  Again, this is reasonably easy to follow for anyone who is familiar with Java and JMS.  It starts by describing how to create a producerconsumer project using Maven.  The API for creating a Connection Factory, Channel, Exchange and Queue as well as how to bind a Queue to an Exchange is described in the context of the message producer example.

Similarly, the module provides a walk through of a Java message consumer and describes the difference between a subscription and explicit message retrieval.

For me, the most interesting section of this module was the section that describes the behaviour of the Direct, Fan Out and Topic exchanges.

**4. RabbitMQ High Availability and Clustering**

This module began with an overview of active/active and active/passive node configuration, however toward the end of the module the active/passive configuration was described as legacy.  It went on to describe RabbitMQ clustering before going into the detail of how to configure a cluster.  One of the interesting topics for me was that of mirrored queues.  The material appeared to suggest that the node(s) on which mirrors are to be created should be explicitly specified during queue creation which is a little disconcerting.  My expectation from previous material was that the cluster would exhibit a greater degree of autonomic behaviour.

**5. RabbitMQ Advanced Development**

This module focusses on the reliability, durability and scalability provided by RabbitMQ.  It does this by describing support for transactions (both local and distributed), acknowledgements, and persistent messaging.  Quite a few choices were described which take a bit of time to absorb.

**Thoughts**

AMQP and RabbitMQ is significantly different from the typical JMS compliant messaging platforms that I would be more familiar with.  The modules on HA, clustering and advanced development  have suggested a number of areas that I would like to become more familiar with.  The best way to do this will be to roll my sleeves up and implement some typical message exchange patterns.
