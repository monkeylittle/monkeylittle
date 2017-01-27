---
layout: post

title: Marshalling XML with Spring WS and JAXB
author: john_turner
featured: false

categories:
- Spring Framework
---

The 'object-relational impedance mismatch' is a well documented set of conceptual and technical difficulties that are often encountered when a relational database management system is being used by a program written in an object-oriented programming language. A similar impedance mismatch exists when XML is used by a program written in an object-oriented programming language.

Many popular 'Object-Relational Mapping' (ORM) frameworks exist that address the object-relational impedance mismatch and no doubt helped to inspire the evolution of 'Object-XML Mapping' (OXM) frameworks to address the object-xml impedance mismatch.

For the Java community, there are a number of OXM frameworks from which to choose [Castor](http://www.castor.org/), [XStream](http://xstream.codehaus.org/), [JiBX](http://jibx.sourceforge.net/), [JAXB](https://jaxb.dev.java.net/) with each having particular strengths and weaknesses. The standard OXM framework for Java is JAXB.

In the following I work through a simple example that demonstrates object to XML marshalling (and demarshalling) using [Spring](http://www.springsource.org/about), [Spring WS](http://static.springsource.org/spring-ws/sites/1.5/) and JAXB (and later [JAXB Introductions](http://community.jboss.org/wiki/JAXBIntroductions)!)

I have provided Maven projects for download so you can follow along:

[Spring OXM and JAXB Source Download](http://thoughtforge.net/wp-content/uploads/2010/02/spring-springws-jaxb.zip)
[Spring OXM, JAXB and JAXB Introductions Download](http://thoughtforge.net/wp-content/uploads/2010/02/spring-springws-jaxb-introductions.zip)

<!-- more -->

**The Model**

The model object that I have used for this example is a simple object representing a 'Person'. The class contains only simple attributes.

{% gist edf11a7c2115844ddb5581fb0dd7a82c %}

As you can see from the listing, the class is annotated with JAXB annotations that are fairly self explanatory. I will leave it to you to look up the precise definition and consequence of these annotations (which can be found on the JAXB Reference Implementation website).

**The XML Schema (XSD)**

JAXB does not require an XML schema (a default schema can be generated), but for this example (and always on commercial projects) I have explicitly specified a schema in order to include type restrictions. It is important to remember that the XSD forms the contract between XML producers and consumers (marshaller and unmarshaller) and should be as detailed as possible.

{% gist 7615d5d193bdef78b0cabb6b5430f52c %}

**The Marshaller Abstraction**

Rather than use the Spring Marshaller/Unmarshaller interface directly, I often use an abstraction for the Marshaller. The abstraction I used here is very simple and of course would not be practical for use with large XML files as it does not support streaming etc.

{% gist fa5e02ae75065e575277858013f25850 %}

The implementation of the marshaller delegates to a Spring JAXB marshaller.

{% gist 0201fadca02729b51096d7c873082976 %}

**The Configuration**

Using Spring to define a JAXB marshaller is relatively straight forward as the listing shows. I have specified the classes to be bound and the XML schema. If the XML schema is specified, the marshaller will instruct the XML parser to validate XML against the schema.

{% gist 64de6cd8724e35eb0279a3668d7e065a %}

**The Test**

The following test is not exhaustive but demonstrates the marshalling and unmarshalling of a Person object. It also demonstrates XML schema validation occurring during the marshalling and unmarshalling process.

{% gist 707ca54579bb787e0d12ff46a3622e68 %}

**Removing JAXB Annotations**

If you are using the reference implementation of JAXB you are required to use annotations to map objects to XML. As I mentioned in a previous post, I'm not a fan of using annotations for the purpose of mapping objects to some other format (relational database or XML or A.N. Other). I find it creates code clutter especially in instances were entity model classes are mapped to both a relational database and XML (using JAXB). In modular projects, it also creates unnecessary dependencies on the model module.

Luckily, some bright spark came along and created JAXB Introductions which allows you to define the mapping of objects to XML in an XML file. I'm not going to regurgitate the information on the JAXB Introductions website but I will outline the modifications I had to make to allow me to use JAXB Introductions with the example above.

First, I added the maven dependency to the project.

{% gist f7e2ed94c910570059b635446baea466 %}

Second, I created a JAXB Introductions mapping file.

{% gist 38f88305d42bf09b7af30d27a94c356e %}}

Thirdly, I modified the Spring configuration to inject the JAXB Introductions annotation reader into the JAXB marshaller.

{% gist 134db15a08a7f8b66bb0085299684f43 %}

Finally, I removed the JAXB annotations from the model class (Person.java).

{% gist 052b82661314c6295f4428c028a86f99 %}

Hopefully, this short example will prove useful for those starting out with JAXB and OXM. For those already familiar with JAXB and OXM, perhaps it has shown you how you can use JAXB without annotations.
