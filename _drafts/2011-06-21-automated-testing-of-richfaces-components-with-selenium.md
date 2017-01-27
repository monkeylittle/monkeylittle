---
layout: post

title: Automated Testing of RichFaces Components with Selenium
author: john_turner
featured: false

categories:
- Rich Faces
---

It is pretty much accepted that Continuous Integration is an essential practice of any Agile software development. An essential part of Continuous Integration is automated testing.

When considering automated testing in a Continuous Integration environment one must consider the level of testing, the frequency and the degree of isolation.

Generally speaking, and from the perspective of a development team, I categorise testing as Unit testing, Integration testing and Acceptance testing. Acceptance testing takes the form of simulating the user interaction with the system and validating its behaviour.

In order to simulate the user interaction on a web interface, I often use [Selenium](http://seleniumhq.org/). For the most part, I have found Selenium to provide the functionality I require from an automated testing framework. I use [Maven](http://maven.apache.org/) to drive the acceptance tests and have found this works well.

The following maven pom will start a local instance of Tomcat, deploy the test subject (war), start an instance of the Selenium server, execute the Selenium tests, stop the Selenium server and stop the local instance of Tomcat.

<!-- more -->

**Setting up The Web Application**

This is a very simple web application that has a single page. This page renders a check box and a text description that indicates if the check box is checked or not.

First thing we need to do is to set up the dependencies in the pom.xml. I have skipped over this for brevity but the full project can be [downloaded](http://thoughtforge.net/wp-content/uploads/2011/06/richfaces-selenium.zip) so you are not missing out.

Next, create a web.xml file that includes the appropriate configuration for JSF and RichFaces.

{% gist 0d53714b12ab3dc4086746e0b9995108 %}

Nothing very exciting so far. Next, we need to define a JSF managed bean to store the state of the check box.

{% gist a9168b249db1aeb8e4b545c1491f0aa3 %}

Finally, our one and only web page.

{% gist 1df2affc375e6ba6a1df322c73a0c7f4 %}

You can see from the web page that we are rendering a check box that triggers an Ajax request when clicked. This Ajax request will update the model, synchronising the state of the check box user interface component and the corresponding model. On completion of the Ajax request, we re-render the output panel which will render one of the two messages depending on the state of the check box.

This all works very well so lets try to automate the testing of this user interface.

**Setting up The Maven Build**

[Maven](http://maven.apache.org/) is a build management tool that supports management of dependencies and the build life cycle. It provides a plug-in framework for extensibility and there is a rich selection of plug-ins available.

For the purposes of this article, the plug-ins that we are interested in are:

- [cargo-maven2-plugin](http://cargo.codehaus.org/Maven2+plugin)
- [selenium-maven-plugin](http://mojo.codehaus.org/selenium-maven-plugin/)
- [maven-surefire-plugin](http://maven.apache.org/plugins/maven-surefire-plugin/)

*Managing the Tomcat Server*

The cargo-maven-plugin is used to manage the interaction with the container to which the artefact (war) is to be deployed. We are using a local instance of Tomcat (6.x) that is referred to via the CATALINA_HOME environment variable (i.e. the CATALINA_HOME environment variable should point to the root of your Tomcat installation).

The plug-in configuration below performs the following steps at the appropriate stage in the build life cycle:

- Starts Tomcat
- Deploys the web application.
- Verifies the deployment of the web application.
- Stops Tomcat.

{% gist b176d7b09d780c8ebc59a3db4515ffbd %}

*Managing the Selenium Server*

The selenium-maven-plugin is used to manage the Selenium Remote Control (RC) Server. The Selenium RC Server is used to simulate the user interaction with a web browser.

The plug-in configuration below performs the following steps at the appropriate stage in the build life cycle:

- Starts the Selenium RC Server
- Stops the Selenium RC Server

{% gist 264b411296e758c93db9ed5064af7fe8 %}

*Executing the Acceptance Tests*

The maven-surefire-plugin is used to manage the execution of the acceptance tests.

The plug-in configuration below performs the following steps at the appropriate stage in the build life cycle:

- Skips the execution of unit tests.
- Executes the acceptance tests.

{% gist 42bbc84fb3ee90994b66c7f88df78154 %}

**Creating the Acceptance Test**

So now we want to create a test that will:

- Request the web page.
- Verify the component 'uncheckedMessage' is present.
- Click the check box.
- Verify the component 'checkedMessage' is present.

Here is the first attempt.

{% gist ae73e08a1b8c088e732fa3ba5248b640 %}

When I run this test it fails on the assertion:

*assertTrue(selenium.isElementPresent("form:checkedMessage"))*

The cause of the failure is that the assertion is evaluated before the Ajax request is completed and the DOM is updated.

Of course, in the simple scenario I present, I might be tempted to wait for the checked message to appear. I might also be tempted to wait for a static period of time, say 5 seconds.

If I just wait for the checked message to appear (with a timeout of 10 seconds), when the message does not appear, how will I know if it is the performance of the Ajax request or the functionality that is causing the problem? The 10 second timeout can also add a significant amount of time to the execution of a large test suite.

If I wait for 5 seconds this adds 5 seconds to the execution of every such test. It also does not guarantee that the Ajax request has returned.

The bottom line is that we need to be able to verify definitively when the Ajax request has completed before making the assertion.

In order to verify that the Ajax request has completed, I use a hidden field that maintains the status of the Ajax request. I then use the *oncomplete* and *onsubmit* properties of the a4j:support component to update the status of the hidden field.

{% gist 75a01e7b04edeac88442a8f0564b1603 %}

The test changes a little to evaluate the value of the hidden field.

{% gist 1e2601b925dba4214acd858b97e507bf %}

The main amendment to the test is the <em>waitForCondition </em>statement. This statement will continually evaluate the expression until it evaluates to true. On execution of the <em>click</em> statement, the value of the hidden field will become 'AJAX REQUEST PROCESSOR ACTIVE' and the waitForCondition statement will only return when the value of the hidden field becomes 'AJAX REQUEST PROCESSOR INACTIVE'.

If the timeout occurs, an exception will be thrown. As a result we are able to clearly distinguish between the Ajax request not returning in a reasonable amount of time and a functionality flaw.

I use this mechanism on a large suite of acceptance tests and it has proven valuable in that it removes the need to have static wait periods and clearly distinguishes between Ajax request not completing and functionality failures.
