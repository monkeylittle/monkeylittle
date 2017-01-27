---
layout: post

title: Using Graph Theory & Graph Databases to Understand User Intent
author: john_turner
featured: false

categories:
- NoSQL
---

<img class="alignright size-full wp-image-2523" src="http://www.monkeylittle.com/wp-content/uploads/2013/02/Neo4j1.jpg" alt="Neo4j" width="182" height="50" />

I was in London recently at the [Cloud Expo Europe](http://www.cloudexpoeurope.com/) and had the opportunity to attend the [Neo4j](http://www.neo4j.org/) User Group meetup hosted at [Skills Matter](http://skillsmatter.com/).  Michael Cutler  of [Tumra](http://tumra.com/) described how they used graph based natural language processing algorithms to understand user intent.

Michael's aim was to enable enhanced social TV experiences and direct users to the content that interests them.  He would achieve this through applying natural language processing, graph theory and machine learning.  The presentation walked through the thought process and associated development that delivered a prototype in a few weeks.

The first attempt was to implement a named entity recognition algorithm.  Essentially, they downloaded the Wikipedia data in RDF format from [DBpedia](http://dbpedia.org) and stored this data in [Hadoop distributed File System](http://hadoop.apache.org/docs/hdfs/current/hdfs_design.html) (HDFS).  They used an [N-Gram](http://en.wikipedia.org/wiki/N-gram) model supplemented with [Apache Lucene](http://lucene.apache.org/) for entity matching.  What they got was a matching algorithm the was unable to distinguish between different entities of the same name.

The second attempt added disambiguation.  [MapReduce](http://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YARN.html) was used to extract entities from HDFS and insert them into [Neo4J](http://www.neo4j.org/) (a graph database) which stored entities as nodes and relationships as edges.  Graph algorithms were then used to interrogate the connections.  Additional context was provided when querying the data thus returning more accurate results (for example, searching for David Cameron in the context of the Euro would find the David Cameron most closely associated with the Euro).  This returned more accurate results but searching the 250 million nodes and 4 billion edges was horrendously inefficient.

In search for more efficient queries, the third attempt removed entities that were not *people*, *places* or *concepts*.  But there were still 10's of millions of entities and billions of connections.  So, rather than retaining individual connections the set of connections between entities were aggregated and the remaining connection weighted (the weight being the number of original connections).  By dividing 1 by the weight a cost was derived with a low cost indicating strong association between entities.  Queries were now taking seconds.

The forth attempt allowed this solution to be applied to live news feeds.  A caching solution was implemented and simple predictors were used to estimate the likelihood of entities occurring.  A 'probabilistic context' was maintained that retained recently returned entities and these were returned from cache while the overall context of the news feed remained the same.  Bayes' Rule was used to derive the relative probability of the entity being the same.  This resulted in average query performance of 35ms.

The fifth and final attempt added support for multiple languages by relating language to concepts and operating on the underlying concepts.  The example used was the concept of the colour red.

Thanks to Michael for a very interesting and informative talk.  If you found this interesting, Skills Matter have posted a podcast of [Using Graph Theory & Graph Databases to understand User Intent](http://skillsmatter.com/podcast/nosql/case-study-using-graph-theory-graph-databases-to-understand-user-intent)

As a side note, [Skills Matter](http://skillsmatter.com/) host a number of excellent user groups and evening events.  Next time you are in the area check out what's on and drop by.  They are a really friendly bunch who are involved in all manner of interesting projects.
