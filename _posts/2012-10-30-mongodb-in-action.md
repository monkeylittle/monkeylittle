---
layout: post

title: MongoDB in Action
author: john_turner
featured: false

categories:
- Book Review
- NoSQL
---

<img src="/assets/img/post/2012-10-30-mongodb-in-action/book-cover.jpg" class="pull-left img-fluid img-thumbnail mr-3"/>

MongoDB gets a lot of press because it is considered the easiest NoSQL database to understand when transitioning from a relational database background.  This is due to support for relational features such as secondary indexes, explain plans and ad hoc queries.

Despite this relative ease of adoption, MongoDB still represents a significant change in the way data is stored, modified and retrieved.  I wanted to learn more so purchased this book as it promised to be written for developers with no MongoDB or NoSQL experience.

**1. A Database for the modern web**

The book starts by providing background information on MongoDB including the initial drivers for developing the database. The key features are identified as being:

- Document data model
- Ad hoc queries
- Secondary indexes
- replication
- Speed and durability
- Scaling

MongoDB's core server components and tools are identified and explained.  A very useful comparison of MongoDB and other categories of NoSQL database is provided followed by a set of use cases describing when to consider MongoDB and (equally as important) when not to.  The comparison is sufficient to put MongoDB in context to the rest of the NoSQL databases but if you are looking for a more comprehensive overview of NoSQL I recommend reading [NoSQL Distilled]({% post_url 2012-09-17-nosql-distilled %}).

<!-- more -->

**2. MongoDB through the JavaScript shell**

To follow the examples in the book you are required to install MongoDB.  An appendix does a good job of guiding the reader through this process and it is not long before you have MongoDB installed and running.

The MongoDB shell is introduced through simple examples of inserting, updating and deleting documents.  Indexes and explain plans are also described.  If you are familiar with  relational databases then these concepts are very familiar and this is one of the things that makes MongoDB so popular.  The concepts of MongoDB are very similar to those of relational databases.

The shell is a very convenient way to interact with MongoDB and excellent for these short exercises.

**3. Writing programs using MongoDB**

If you are going to use MongoDB you are probably going to have to use one of its many drivers.  The book uses Ruby and the Ruby driver to demonstrate how to write programs using MongoDB.  An appendix showcases driver API's for other languages so I also followed the examples in Java.

Database drivers are nothing new but MongoDB drivers differ in a couple of significant ways.  Because MongoDB uses globally unique identifiers for documents the driver can assign the primary key on the client.  The anatomy of a primary key (or ObjectId in MongoDB terminology) is explained.

A larger example works through building a twitter archive application.  I had to make some changes to the example to get the Twitter API to work but nothing too challenging.

**4. Document-oriented data**

Document oriented data is a something that developers tend to have lots of exposure to via web services, REST etc.  and so MongoDB's document oriented approach is immediately familiar.  Storing data in documents though is very different than storing data in databases, tables and rows.  MongoDB's storage concepts of databases, collections and documents are described via an example e-commerce data model.

**5. Queries and aggregration**

As I mentioned previously, one of the reasons developers tend to like MongoDB is that it has reasonably powerful query support.  Queries on document elements and nested elements are supported along with wildcard queries, range queries, set operators, boolean operators etc.

The ability to use JavaScript within a query adds extra capability if you can't express your query with the other built in functions.  This chapter goes on to explain sorting, pagination (using skip and limit), grouping and even MapReduce for MongoDB.  I really enjoyed working through the examples via the MongoDB shell.

**6. Updates, atomic operations, and deletes**

MongoDB (as with all NoSQL databases as far as I'm aware) does not support transactions but it does support atomic operations.  MongoDB supports an atomic operation that will find and modify a document in a single operation.  Coupled with MongoDB's ability to perform partial document updates this goes some way to lessen the pain of having no transactions.

**7. Indexing and query optimisation**

The book describes how to index collections and optimise queries when using MongoDB.  The concept of indexes is no different to that of indexes in relational databases but of course the way they are administered is somewhat different.  The same applies to the act of running explain plans, identifying indexes and optimising queries.  What was different was the ease at which you can enable profiling of slow running queries.  This is a very nice feature which I enjoyed investigating.

**8. Replication**

Replication is something that most developers from a relational background will not have had exposure to.  Like most NoSQL databases, MongoDB replicates to increase read performance and resilience.  Replication introduces the question of consistency and how much consistency is required.  MongoDB uses a master/slave topology for replication and the consequences of this topology are explained (primarily master election).  Further details on replication are provided including how journalling is used to update slaves.  This background is very useful if you are required to diagnose problems with MongoDB replication.

The distinction between the master/slave and replica set replication is discussed but this is for historical context as master/slave replication requires manual failover and so is not recommended for production environments.

**9. Sharding**

Similar to replication, sharding is reasonably novel to those from a relational background (though there are sharding and replication frameworks for relational databases such as [gizzard](http://engineering.twitter.com/2010/04/introducing-gizzard-framework-for.html).  Sharding is essentially partitioning data across a cluster based on some element of that data (the sharding key).  Sharding is an enabler for the massive scalability of NoSQL solutions in that for each node in a database cluster the number of IOPS increases at a near linear rate.

The section on the selection of sharding keys is really interesting and explains the concept from the ground up.  This implications of sharding key selection on reading and writing to a collection is discussed as are the desirable qualities of a sharding key.

The administration of shards is also covered in what is a comprehensive coverage of the subject.

**10. Deployment and administration**

The book concludes with a chapter on MongoDB in production.  This covers the deployment topology, server configuration, security, logging and monitoring, backups, journaling etc.  These subjects provided sufficient coverage to allow for a competent attempt and designing a production deployment of MongoDB.

Finally, there is a section on troubleshooting performance issues.

**Thoughts**

The book sets a steady pace and has the feel of an extended tutorial.  This is very comforting if this is your first introduction to MongoDB or NoSQL in general.  The exercises are interesting but do not require such an investment in time that you might be tempted to skip them.

The expressiveness of the query language is thoroughly explored with relevant exercises providing practice at applying the language.

The book does a good job of explaining sharding and the importance of selecting an appropriate sharding key.  I was at JAX London 2012 and Tim Berglund emphasised the same point when discussing sharding and range queries with Cassandra.

Overall, it's a good read but I'm not sure that you would not be better with the [online MongoDB training](https://education.10gen.com/courses/10gen/M101/2012_Fall/about) that 10gen are now providing free of charge.
