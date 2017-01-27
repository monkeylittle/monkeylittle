---
layout: post

title: Web Form Validation with JBoss RichFaces and Hibernate Validator
author: john_turner
featured: false

categories:
- Rich Faces
- Spring Web Flow
---

Last month I posted about [Building a Dynamic Tree with JBoss RichFaces and Spring Web Flow]({% post_url 2010-01-19-building-a-dynamic-tree-with-jboss-richfaces-and-spring-web-flow %}). Since then, I have received a few requests to demonstrate how to implement validation within the modal dialog. There are several internet resources that already deal with this but none that provide a complete working example so I decided I would do just that.

You can download the [source code](http://thoughtforge.net/wp-content/uploads/2010/02/richfaces-modaldialog-ajax-validation.zip") in the form of a Maven project and follow along.

**Hibernate Validator Dependencies**

First step is to add the [Hibernate Validator](https://www.hibernate.org/412.html) dependency to the project pom. I have used Hibernate Validator 4.0.0.GA because it is a JSR 303 compliant implementation.

{% gist 5386d69c14fa1b35687ec5c68a608218 %}

<!-- more -->

**Annotating the Model Class**

JSR 303 allows for the specification of validation constraints via Annotations andor XML. The Hibernate Validator documentation has recently been updated to include details on specifying the validation.xml if you prefer to use XML.

For this example I am going to use Annotations to specify a 'Size' constraint on the name and description properties of the Organisation class. These are basic constraints but they will suffice for demonstration purposes.

{% gist ab646336dd3ed0aec63dd0cb7e0623ed %}

**Applying the Constraints**

Of course, as annotations do nothing in and of themselves, I need to invoke the validator to apply the constraints. RichFaces provides 3 components that invoke either the Hibernate or JSR 303 bean validator during the JSF 'Process Validations' phase.

I wanted to validate the Organisation name and description properties. These are set within the 'addChildModalPanel' and updated within the 'editChildModalPanel'. The validations are applied to each in exactly the same way.

To apply validations to the name and description 'inputText' fields I added a child field. Adding this child component results in the validator being invoked during the 'Process Validations' phase.

*<rich:beanValidator/>*

If the validation fails, messages are added to the FacesContext and will be displayed using the component.

{% gist 424aa93ef19180f15d62d868c3c60cd3 %}

**Displaying Validation Messages within the Modal Dialog**

Finally, I needed to keep the Modal Dialog from closing when validation failures occured. This is achieved by modifying the a4j:commandButton as shown below. It is worth highlighting that each has its own and this is very important (as highlighted in the JBoss RichFaces documentation).

{% gist 0783442dca0fc05a8f12d115b22ba253 %}

What I ended up with was a really intuitive and responsive UI with appropriate validations. It was an interesting exercise especially due to the intricacies of the component.
