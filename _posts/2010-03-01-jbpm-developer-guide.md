---
layout: post

title: jBPM Developer Guide
author: john_turner
featured: false

categories:
- Book Review
---

<img src="/assets/img/post/2010-03-01-jbpm-developer-guide/jbpm-developer-guide.jpg" class="pull-left img-fluid img-thumbnail mr-3"/>

Business Process Management (BPM) has been around in one guise or another for quite a while now and most people have had some exposure to its many facets. With so much promised, it is easy to see why it has generated so much interest.

jBPM is an open source BPM framework from JBoss that has matured into a real alternative to the many other BPM offerings. The 'jBPM Developer Guide' introduces to its readers the main artifacts of BPM and what is involved in implementing typical jBPM solution.

The book begins by providing a background to BPM and how it can be leveraged to deliver benefit to the business. This includes an introduction to processes, tasks and process management (Business Process Management or BAM). As any good book should, terminologies that are associated with BPM are introduced and defined. Thankfully, the definitions are void of the usual marketing hype.

With the help of an example, graph orientated programming (GOP) is then introduced and its relevance to jBPM discussed. Specifically the Node, Transition and Process Definition concepts are covered before the author works through sample implementations of each. Wait states (asynchronous system interactions and human tasks) and automatic nodes are compared before process execution is demonstrated through a sample process execution engine implementation.

The book goes on to give some background to the jBPM project and covers the setup of tools to be used throughout the remainder of the book (Maven, MySql, Eclipse etc.). It outlines how to install jBPM from a distribution and from source. I used the installer to install the version used for the examples (3.2.6.SP1).

<!-- more -->

Two example process projects are then created using the eclipse designer plugin and then the maven plugin to contrast both approaches. Use of the 'Graphical Process Editor' is also demonstrated.

The jPDL language is then explored in greater depth describing in detail the XMLClass definitions of the process, the various node types (Node, Start State, End State, State, Decision), transitions and the execution token. As an example (recruitment) process is automated with the jBPM framework. This is achieved iteratively adding more detail in each stage.

Process instance persistence is discussed in depth. This includes details on how and when process definition amd process instance persistence occurs. A brief review is given of the jBPM API to interact with the database and the jBPMHibernate persistence configuration.

Human Task's are explained including details on input data, task action and output data. The distinction between a TaskNode and Task is also made. A brief introduction to the jBPM Identity module is provided during a discussion about task assignment before demonstrating an example process.

The transactional behaviour of jBPM is then discussed along with a more detailed discussion on variable mappings and task assignment. Process variables and the type's of information stored in process variables are explained and the specific API for variable manipulation is covered in brief, along with the variable persistence and hierarchy. These concepts are demonstrated with a concrete example.

More advanced node types are covered in this chapter including Fork and Join nodes, Super state nodes, Process state nodes and the Email node. Variable mapping strategies as discussed in depth and related to the Process State node.

Further examples of using Super state nodes and Process state nodes are covered in addition to asynchronous execution and the JobExecutor. The examples focused on the asynchronous execution are thorough and provide a good understanding of this process.

The book finished by discussing the use of jBPM within a JEE environment. In particular, JTA, Data Source's, the CommandServiceBean, the JobExecutor and JMS and finally Timers and reminders.

My overall impression of the book was that it relayed the key information required to get up and running with jBPM. The author was clearly knowledgeable in the subject and provided useful examples to complement the concept's being discussed. I liked the fact that the author gives details on installing the developer tools as it allows the reader to follow along with the examples.

The only negative comment I can make was that I found the poor construction of sentences and awkward use of English a little distracting. It reads as a book that was translated into English from another language.
