---
layout: post

title: JAX London - Apache Cassandra
author: john_turner
featured: false

categories:
- NoSQL
- Ramblings
---

I recently attended [JAX London](http://jaxlondon.com/) and there were quite a number of the sessions focussed on Big Data and NoSQL.  Two of those sessions focussed on Apache Cassandra.

Tim Berglund ([Radical NoSQL Scalability with Cassandra](http://www.slideshare.net/jaxlondon2012/radical-nosql-scalability-with-cassandra-tim-berglund)) started by describing Cassandra as a column oriented database and spent some time illustrating what it meant to be column oriented.  He then went into some of the specifics such as keys, secondary keys, CQL, ordering of columns within rows etc.

One of the things people assume about NoSQL is that it facilitates near linear scalability.  Tim confirmed that Cassandra will scale linearly and that he is aware of production clusters  of up to 500 nodes.  He also spent some time describing consistent hashing and the logical topology utilised by Cassandra.  Nodes can be added and removed without downtime and load is redistributed.  Redistribution of load is throttled so as not to impact availability in production.

One of the interesting characteristics he described was higher write than read performance.  Because Cassandra uses the write timestamp during reads to ensure the latest version is being read, NTP is required on Cassandra nodes.

I found Tims session to be very interesting.  Cassandra was new to me although few of the concepts were.

Tom Wilkie ([Real-time Analytics with Apache Cassandra](http://www.slideshare.net/acunu/realtime-analytics-with-apache-cassandra-jax-london)) focussed on how to extract real time analytics from column oriented databases (specifically Cassandra).  Tom was really knowledgeable about Cassandra although the session took a while to get going.

NoSQL databases are denormalised and distributed which does not lend itself to real-time analytics. Tom spoke about some of the techniques they were using at [Acuna](http://www.acunu.com/).  He got into the technical detail which at a high level involved updating summary data on insertion.  He then spoke about how Cassandra counters and multi dimensional keys facilitated this process.

Much like Tims session, Tom did a good job of conveying the key understanding and making the session interesting and relevant.
