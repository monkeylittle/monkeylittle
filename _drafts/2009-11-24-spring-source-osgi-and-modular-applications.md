---
layout: post

title: Spring Source - OSGi and Modular Applications
author: john_turner
featured: false

categories:
- Spring Framework
- Training & Certification
---

[OSGi](http://www.osgi.org) is a dynamic module system for Java which has been gaining quite a lot of publicity in recent times. One of the most well known OSGi implementations, [Equinox](http://www.eclipse.org/equinox/) is used within the Eclipse project to provide its plugin architecture. Spring Source are full members of the OSGi Alliance and have shown their commitment to OSGi with the development of the [Spring Source dm Server](http://www.springsource.com/products/dmserver) and [Spring Dynamic Modules](http://www.springsource.org/osgi).

Spring Source have recently added the [OSGi and Modular Applications](http://www.springsource.com/training/freeonline") training video to their free online training offering. I was eager to learn more about OSGi and what Spring Source were doing to simplify OSGi in the same way it has with much of enterprise Java.

The training video lasts for just over an hour and provides an overview of OSGi, Spring Dynamic Modules and Spring Source dm Server. It starts with a history of OSGi and the OSGi Alliance and provides some information related to OSGi bundle visibility, the OSGI bundle lifecycle, the OSGi service registry and the OSGi container.

The video then proceeds to a demo entitled 'Using plain OSGi bundles to share types and services'. The demo uses Spring Source Tool Suite to develop an OSGi bundle which exports a service and then deployes the bundle to the dm Server. It then demonstrates the development and deployment of another OSGi bundle which imports the service provided by the previous OSGi bundle.

Next, there is an introduction to OSGi and Spring which focus on Spring Dynamic Modules and how it simplifies OSGi development in the same way that the Spring Framework simplifies enterprise Java development. A demo entitled 'Using Spring Dynamic Modules to share types and services' highlights how Spring Dynamic Modules provides dynamic proxies to services that have been exported to the OSGi service registry. It also demonstrates the use of the OSGi namespace to configure the OSGi services within the exporting and importing bundle.

We are then introduced to some of the issues surrounding enterprise OSGi including incompatible classloading models, lack of web support, appropriate deployment models and lack of enterprise library bundles. This is very useful as it highlights some of the obstacles to be overcome before introducing OSGi to the enterprise. OSGi architectures and partitioning strategies are also discussed highlighting the characteristics of vertical and horizontal partitioning as well as partitioning granularity.

The final demo is 'Developing a multi-bundle web application with Spring Source dm Server' which demonstrates a web application consuming OSGi services.

Overall, the training video provides a useful introduction to OSGi and OSGi development using the Spring technology stack. As with the previous free training video the quality of the material was very good and it was presented in a clear and concise manner.
