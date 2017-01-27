---
layout: post

title: Starting out with Spring and Hibernate JPA
author: john_turner
featured: false

categories:
- Spring Framework
- Object Relational Mapping
---

More often than not, I am brought onto a project after the project initiation phase has been completed. By this stage major decisions regarding the development environment and code organisation have already been made. It would be fairly common that I would refactor and re-organise some of the code and in particular the Hibernate JPA code.

In this post I am going to outline how I prefer to implement and organise the Hibernate JPA code on projects I am involved with (where that option exists). I will also demonstrate how I implement the persistent entity classes, data access objects, associated configuration and unit tests. A fairly typical project would utilise Maven, Spring and Hibernate JPA.

**Creating the Maven Project**

My preferred project structure consists of a root project containing a model module and persistence module with the persistence module having a dependency on the model module. While this would seem pretty straight forward, one now has to decide if one is going to use annotations or XML configuration for the ORM mapping. The reason I prefer to make this decision now is that it affects the dependencies of the model module.

There are arguments for and against using annotations or XML for ORM (any XRM really) but if no precedent has been set I normally try to avoid using annotations in model classes. This way model classes are very clean and the model module does not have any dependencies on javax.persistence. I was involved in a project using JPA and JAXB annotations in model classes and they became difficult to work with very quickly.

The persistence module really does encapsulate all the information relating to the persistence mechanism with the exception of (some) transactional characteristics which would ordinarily be defined in service classes within a service module. Of course the price you pay for this is having some quite large XML files.

<!-- more -->

**Creating the Persistent Entity Classes**

For this example, I am going to use a fairly typical security domain model. A UserToken represents an authorisation token that can be associated to a User or a UserGroup. A UserGroup is a hierarchical data structure and so can be associated with one parent and/or many child UserGroup's. A UserGroup can be associated with many Users and a User can be associated with many UserGroup's. A UserGroup inherits UserToken's from child UserGroup's and a User inherits UserTokens from associated UserGroup's.

I hope the explanation along with the entity model diagram has given you a good understanding of the entity classes.

[caption id="attachment_1396" align="aligncenter" width="520"]<a href="http://thoughtforge.net/wp-content/uploads/2010/01/figure11.png"><img class="size-full wp-image-1396 " style="border: 2px solid black; margin: 3px 5px;" title="Figure 1" alt="" src="http://thoughtforge.net/wp-content/uploads/2010/01/figure11.png" width="520" height="250" /></a> Figure 1: Entity Model[/caption]</p>

The entity classes are added to the model module. I am not going to post code listings for the persistent entity classes as I have made all the code available for [download](http://thoughtforge.net/wp-content/uploads/2010/01/spring-hibernatejpa-source.zip).

It is worth highlighting though that all model classes extend a common super class (PersistentEntity) that typically defines identifier and version properties. Depending on the requirements, it may also define properties such as dateCreated, dateLastUpdated, tenancy (for multi-tenanted domains) etc.

**Creating the JPA Mapping Configuration**

For the sake of clarity, I generally separate the JPA mapping configuration into persistence.xml and persistence-mapping.xml (and persistence-query.xml which we will discuss later) files. I try to use the same persistence.xml configuration in all environments so I move anything that varies into the Spring configuration. This includes the definition of the data source, dialect etc.

{% gist e4882bfa032a6d45d9371d33e19dfd52 %}

The option exists to further seperate the persistence-mapping.xml file into a file for each class as is normal practice for hibernate .hbm files.

As you can see from the applicationContext-persistence.xml file below, the 'jpaProperties' property of the entityManagerFactory bean contains all the connection information. If you are not using a JNDI data source in any of your environments it will be sufficient to use a properties file to contain the connection information for each environment. If however some of your environments use a JNDI data source and some do not you will obviously have to use seperate Spring configuration files to specify the connection information.

{% gist 146c85707fe2f4bd517053a51be01d6b %}

**Creating the Data Access Objects**

The data access objects (obviously) reside in the persistence module. I have a fairly standard PersistentEntityDao interface from which all data access object interfaces extend.

{% gist 3cdf00a8f73d60eac9308cc6305cd6f8 %}

Specific data access object interfaces would typically then only contain specific finder methods (See UserDao) below:

{% gist d634f49304f28edd2912277016bd5f0d %}

The implementation classes reside in a specific sub-package that is named after the data access mechanism. For example, a JPA implementation has a 'jpa' sub-package, a Hibernate implementation has a 'hibernate' sub-package and a JDBC implementation has a 'jdbc' sub-package. I hate seeing sub-packages named impl; generally I feel that the only time this should happen is if there could only be one implementation of an interface which is clearly not the case for data access objects.

Similar to the data access object interfaces, ORM data access objects extend a common super class that exposes common CRUD functionality.

{% gist 4ec95ba3c169e8733ec20cef476eceaf %}

Specific data access object interfaces would typically then only contain specific finder methods (See UserDaoImpl) below:

{% gist e208577a12c192e4fe105ac6117bdd0d %}


As you can see, I always use named queries and NEVER hard code SQL into data access objects. The main reasons are that it reduces clutter in the code and maintains all SQL in a single place (persistence-query.xml). While I have not defined any query hints it is worth pointing out that they are almost always present in any meaningful implementation.</p>
It is also good practice to use namespaces for naming queries.

{% gist 672260ebdaaf0b3e956f2fdf2121a85d %}

The above code examples should suffice to demonstrate the implementation and organisation of the data access objects. The complete code is available for download.

**Testing the Data Access Objects**

Spring provides support for writing transactional data access object tests that I always utilise when testing data access objects. Where possible, I use an embedded database to 'exercise' my data access objects during testing. By this I mean that at a minimum I test create, update and delete for every type of persistent entity and invoke every find method (and named query). I have only included a sample test which should be enough for the purpose of demonstration.

{% gist a69ee21db67961aaa99bb99a286bce8a %}

I hope that I have given you a good overview of how I implement and organise Hibernate JPA code. There are lots of variations on this approach and none are perfect but I always find this approach a good place to start.
