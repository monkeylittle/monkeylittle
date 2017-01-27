---
layout: post

title: Building Twitter with Grails
author: john_turner
featured: false

categories:
- Training & Certification
- Groovy & Grails
---

I have been hearing good things about [Groovy](http://groovy.codehaus.org/) and [Grails](http://www.grails.org/) for quite a while now without really knowing much about either. The aquisition of the company that developed Grails (G2One) by Spring Source in late 2008 has naturally added some weight to the Grails movement. Having grown tired of standing, eyes glazed over, as others discuss the advantages delivered by Grails I decided I would learn more.

One of the more popular demonstrations of Grails is that delivered by Graeme Rocher in which he demonstrates building an application similar to Twitter using Grails. A webinar of this demonstration is available for download from the [Spring Source website](http://www.springsource.com/webinars).

The webinar runs for just over an hour and begins by giving an introduction to Grails, what it is, what it hopes to deliver and how it delivers it. This includes how Grails leverages existing technologies such as Spring, Hibernate, Sitemesh and Groovy. Graeme then gives a brief history of Grails explaining its inception in 2005 through to acquisition by Spring in 2008 before using download metrics to give an indication of the current adoption of Grails (70,000 downloads per month at the end of 2008).

The core of the webinar is focused on the demonstration of building Twitter with Grails. Graeme starts by introducing the Grails command line interface and uses it to build the initial project directory and file structure. He gives an tour of the directory structure explaining what goes where before proceeding to install the Spring Security (acegi) plugin for Grails. The functionality provided by this plugin includes the generation of the authentication domain model, authentication manager and login registration process (user interface and controllers).

Graeme then demonstrates the creation of additional domain model objects to which he adds associations and constraints. In order to manipulate the additional domain objects, Graeme creates a controller and associated view (.gsp file). This controller and view facilitates posting a tweet and displaying a history of tweets.

Graeme then proceeds to install and demonstrate the use of the Searchable plugin which facilitates searching for domain objects using criteria queries. This also requires overriding the default view of the searchable plugin. The Searchable plugin and associated view modifications allow the user to add people who they are interested in hearing tweets from.

If someone who the current user is interested in adds a tweet, a JMS message is sent to notify them (update their tweet history) that a new tweet has been added. The JMS functionality is delivered via an activemq plugin which is installed through the Grails command line interface.

Graeme then demonstrates exposing the same tweets via RSS and XML using the same controller that handles web requests.

The key features of Grails are specified as:

- Plugins to let you rapidly compose an application
- Plugins that use convention over configuration
- Not only a web framework but an entire platform (JMS support etc.)
- Plugins to enable testing (Selenium, Fitness, Code Coverage etc.)
- Rich Grails (Flex, GWT, Grails UIYahoo UI etc.)
- Secure Grails (Spring Security, JSecurity OpenID)
- Integrate Grails (Search, Jasper Reports, JMS)

This was a good introduction to Grails, the command line interface, project conventions and the plugin system. It has piqued my interest sufficiently that I will spend a bit more time (when I have it!) progressing through some of the many Grails tutorials.
