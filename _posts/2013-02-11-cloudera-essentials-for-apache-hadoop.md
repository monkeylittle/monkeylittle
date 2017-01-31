---
layout: post

title: Cloudera Essentials for Apache Hadoop
author: john_turner
featured: false

categories:
- Training & Certification
- NoSQL
---

<img src="/assets/img/post/2013-02-11-cloudera-essentials-for-apache-hadoop/hadoop-logo.png" class="img-fluid img-thumbnail pull-left mx-3">

It has been interesting to see a number of companies (such as [Cloudera](http://www.cloudera.com) and [Hortonworks](http://hortonworks.com/)) take on the mantle of providing enterprise services for Hadoop and its ecosystem.  These services tend to include a certified Hadoop bundle, consultancy, support and training.

We have also seen a number of hardware vendors and cloud providers provide offerings such as the reference architecture from Dell, HP, IBM and Amazon.

Importantly for Hadoop, this will help drive its maturity and adoption.  In 2012, Gartner suggested that Hadoop was past the peak of inflated expectations and sliding toward the 'Trough of Disillusionment'.  While there are areas were adoption is ahead on the curve I would tend to agree with Gartner's assertion.

<img src="/assets/img/post/2013-02-11-cloudera-essentials-for-apache-hadoop/gartner-hype-cycle.png" class="img-fluid img-thumbnail mx-3">

The activities these companies engage in is increasing the awareness of Hadoop and the type of problems it can address.  To this end, Cloudera created an excellent set of webinars called 'Cloudera Essentials for Hadoop' which delivers a comprehensive introduction to Hadoop in the form of a 6 part series.

<!-- more -->

**Part 1: The Motivation for Hadoop**

[The Motivation for Hadoop](http://www.cloudera.com/content/cloudera/en/resources/library/training/cloudera-essentials-for-apache-hadoop-the-motivation-for-hadoop.html) provides historical background that describes some of the inspiration for Hadoop provided by Google.  This starts in 2003 when Google published a paper on [The Google File System](http://research.google.com/archive/gfs.html) and is later provided with further direction when Google publish the [MapReduce: Simplied Data Processing on Large Clusters](https://static.googleusercontent.com/media/research.google.com/en//archive/mapreduce-osdi04.pdf) paper in 2004.  Both these concepts map directly to the [Hadoop Distributed File System](http://hadoop.apache.org/docs/hdfs/current/) (HDFS) and to [Hadoop MapReduce](http://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YARN.html).  Later (2006), Google published another paper on [Bigtable: A Distributed Storage System for Structured Data](http://static.googleusercontent.com/external_content/untrusted_dlcp/research.google.com/en//archive/bigtable-osdi06.pdf).  This would also instigate the development of [HBase](http://hbase.apache.org/)

The problem that Google (and Yahoo) were trying to address was that of storing and  indexing a massive amount of information (the content of the internet) to facilitate efficient search.  The achieved this through storing data on GFS, using MapReduce to create indexes which were in turn stored in BigTable.

As people discovered new use cases for Hadoop, an entire ecosystem grew up around it.  This included MapReduce implementation abstractions such as [Hive](http://hive.apache.org/) and [Pig](http://pig.apache.org/) which made it easier for people from SQL and scripting backgrounds to write MapReduce jobs.  [Sqoop](http://sqoop.apache.org/) and [Flume](http://flume.apache.org/) made it easier to migrate relational and streaming data to and from HDFS.

**Part 2: Dissecting the Apache Hadoop Stack**

[Dissecting the Apache Hadoop Stack](http://www.cloudera.com/content/cloudera/en/resources/library/training/dissecting-the-apache-hadoop-stack-2-of-6.html) describes the components that comprise Hadoop as being HDFS and MapReduce.  This is further dissected by describing the five daemon processes that form the Hadoop platform as being:

- Name Node - Stores and manages HDFS meta-data.
- Secondary Name Node - performs housekeeping functions.
- Data Node - Stores data blocks.
- Job Tracker - Manages MapReduce jobs.
- Task Tracker - Instantiates and monitors Map and Reduce tasks.

**Part 3: Solving Business Challenges with Hadoop**

[Solving Business Challenges with Hadoop](http://www.cloudera.com/content/cloudera/en/resources/library/training/cloudera-essentials-for-apache-hadoop-3-of-6-solving-business-challenges-with-apache-hadoop.html) discusses the type of use case were Hadoop excels.  This is done by describing the nature of the data and the nature of the analysis for which Hadoop was designed.

The nature of data is described as:

- Complex
- High volume
- High velocity
- Multiple sources

The nature of analysis is described as

- Batch processing
- Parallel execution

Suitable use cases are identified as text mining, index building, graph creation, pattern recognition, collaborative filtering, prediction models, sentiment analysis and risk assessment.

Interesting, one example that points to the scale of data processing possible was that of Netfilx who at that point in time were importing 1Tb of data per day with hourly processing.

**Part 4: Getting to Know the Components of the Hadoop Ecosystem**

[Getting to Know the Components of the Hadoop Ecosystem](http://www.cloudera.com/content/cloudera/en/resources/library/training/cloudera-essentials-for-apache-hadoop-webinar-series-4-of-6-getting-to-know-the-components-of-the-apache-hadoop-ecosystem.html) again clarifies the distinction between Hadoop and the many other applications that comprise the Hadoop ecosystem.  [Hive](http://hive.apache.org/) and [Pig](http://pig.apache.org/) are delved into in a little more detail than previously and quite a bit of time is spent discussing [HBase](http://hbase.apache.org/).

HBase is described as having the following characteristics:

- is a column family database.
- can process massive amounts of data.
- has high write throughput (1ooo's of writes per second per node).
- rows are accessed by key.
- has no transactions.
- supports single row operations only.
- rows can be the input/output of MapReduce jobs.
- stores data on HDFS.

Other applications within the ecosystem such as [Flume](http://flume.apache.org/), [Sqoop](http://sqoop.apache.org/), [Oozie](http://oozie.apache.org/) and [Mahout](http://mahout.apache.org/) are also described briefly.  Oozie is used to define MapReduce workflows (i.e. workflows were nodes are MapReduce jobs) and Mahout is a machine learning library for Hadoop.

**Part 5: Preparing your Data Centre for Hadoop**

[Preparing your Data Centre for Hadoop](http://www.cloudera.com/content/cloudera/en/resources/library/training/cloudera-essentials-for-apache-hadoop-5-of-6-preparing-your-data-center-for-hadoop.html) provides a rough idea of the sort of hardware requirements that an Hadoop installation might require.  Of course, these are rule of thumb specifications and each installation is going to differ depending on the particular usage profile.

The recommended specification is:

- mid-grade processors
- 24Gb-32Gb RAM
- 4-12 drives per machine
- 1GB ethernet
- dedicated switching infrastructure
- approx. cost per node $3,000 - $7000 approx.

Cloudera go on to refine this further by saying a typical data node specification might be:

- 4 x 1TB drive
- 2 x quad core CPU
- 32Gb RAM
- 1GB ethernet

Interestingly, they estimated the negative performance impact of virtualisation at between 10%-40%.  I say interestingly because of the recent trend for cloud providers to offer big data solutions.

**Part 6: Managing the Elephant in the Room**

[Managing the Elephant in the Room](http://www.cloudera.com/content/cloudera/en/resources/library/training/cloudera-essentials-for-apache-hadoop-6-of-6-managing-the-elephant-in-the-room.html) was a really useful wrap up for the series in that it identified and described the key roles needed to support a Hadoop implementation.  These were identified as system administrators, developers, analysts and data stewards.

System administrators should have a strong background in Linux administration, networking and hardware.  They will primarily be involved with installing and configuring Hadoop, managing hardware, monitoring the cluster and integrating with other systems.

Developers should have a Java or scripting background and an understanding of MapReduce and algorithms.  They will be responsible for writing, packaging and deploying MapReduce jobs as well as optimisation of same.

Data analysts should have a background in SQL and a strong understanding of data analysis.  Their role is to extract intelligence from the data and write Hive or Pig programs.  As an aside, I recently read a great article on [What Separates a Good Data Scientist from a Great One](http://blogs.hbr.org/cs/2013/01/the_great_data_scientist_in_fo.html).

A data steward (this is a new one on me) should have data modelling, ETL and scripting skills.  They are responsible for cataloguing the data, managing data lifecycle retention and data quality control.
