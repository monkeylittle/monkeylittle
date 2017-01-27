---
layout: post

title: Creating a Logging Aspect with Spring AOP and AspectJ
author: john_turner
featured: false

categories:
- Spring Framework
---

After working in software development for a number of years, one tends to build up a repository of useful code examples and utilities. I'm certainly no different in this regard and go one step further by maintaining a [hosted](http://wush.net/) [Subversion](http://subversion.tigris.org/) repository to keep such code examples safe and sound (and readily accessible).

One such code example that I often turn to is a logging aspect implemented using [Spring](http://www.springsource.org/) AOP and [AspectJ](http://www.eclipse.org/aspectj/). This logging aspect traces method entry and exit which proves very useful if you need to perform root cause analysis in pre-production environments.

In what follows, I'm going to share this code example. I have also made the [logging aspect source code](http://thoughtforge.net/wp-content/uploads/2010/02/spring-tracing-aspect.zip") available for download.

I have assumed you have a reasonable grasp of Aspect Orientated Programming concepts and terminologies.

<!-- more -->

**The Logger**

There are a few options to choose from when considering a logging framework and these have evolved over the years so it is probably best to abstract the logging framework from the aspect. For this purpose, I have implemented a simple logging interface and log level enum.

{% gist 64415e07088860fb51ece29abc942fea %}

{% gist 72dcfac7decfbd889f47c40e1226924b %}

In the majority of cases, I end up using the [Commons Logging](http://commons.apache.org/logging/) framework and so have included this implementation of the Logger in the source download.

You may decide that this level of abstraction is overkill and that you are willing to commit to using a specific logging framework. When making this decision, keep in mind that you will be specifying the log level throughout your code base.

**The Logging Aspect**

I am going to use the @Aspect approach to implement the logging aspect which is to say I will use annotations to specify the advice. I want the logging aspect to log the method name, argument values, return value and any exception thrown so I will use the @Before, @AfterThrowing and @AfterReturning annotations.

{% gist 9f396694b47f66890802376453ee0b50 %}

The 'Before' advice simply logs (at the appropriate log level) the method name and the toString value of all arguments (if any). 'Before' advice executes when a join point is reached.

{% gist d50674c6ec1fb8394094b8cb31d940d2 %}

The 'AfterThrowing' advice logs the method name, exception message and the toString value of all arguments (if any). 'AfterThrowing' advice executes after a method exits by throwing an exception.

{% gist 3a5050cd1621d576ebcd5ff9a4d47e71 %}

The 'AfterReturning' advice logs the method name and the toString value of the returned value (if any). 'AfterReturning' advice executes after a method exits normally.

You will notice that I log the toString value to identify objects. I routinely use the Apache Commons ToStringBuilder to create the toString value. I find this particularly useful when working with persistent entities as it allows me to clearly identify the entity.

Another possible implementation that avoids using the toString method is to use the Apache Commons ReflectionToStringBuilder within the logging aspect to create a string representation of the object being logged.

If you are writing your own toString implementations (the Commons implementation is perfectly adequate) and are implementing an object with complex properties be aware of recursive invocations that may result in a stack overflow exception.

**Specifying the Pointcut**

A pointcut expression is an expression that specifies where in the code the advice will be applied. With AspectJ, you can create a pointcut by specifying package, class and method attributes among other things. I find the easiest way to specify a pointcut for the logging aspect is by matching methods that have a specific annotation.

{% gist acd06bb33198e5c3ac933716f96840ea %}

As you can see, the Loggable annotation has one property that specifies the log level at which the log statement should be output. Using the annotation means that developers never need to alter the pointcut expression to add or remove methods to the pointcut. A developer only has to add the annotation to a method to have the logging aspect applied.

{% gist e6315ebf14f6647d0ed630fd6e47e208 %}

The SimpleBean and SimpleBeanSubclass are for demonstration purposes. You can see that each method is annotated with the @Loggable annotation and the log level is set to TRACE. You can obviously use different log levels for different methods as required.

{% gist 02c67e323193f31c58857b479be40956 %}

Also note the use of the ToStringBuilder to create the toString value. You may choose to use the ReflectionToStringBuilder or some other mechanism.

**Testing the Logging Aspect**

One way to test the logging aspect is to simply have a test invoke instrumented methods and observe the log statements produced. This is a useful exercise but requires manual intervention to determine if the test was successful.

In order to create an automated test for the logging aspect, I needed to create a mock logger that simulates the actions of a logger and allows me to interrogate the log statements produced.

{% gist 26bae891c577395d2e8d5bd2bdff8b0f %}

The logging aspect test utilises the MockLogger and makes assertions about the log statements produced.

{% gist 6f4a1ff537cb66b3aae046dc7bb7b989 %}

The test is not exhaustive but suffices to test the general operation of the logging aspect.

**Final Word**

Hopefully you found my example useful but I will finish by saying that there are many choices that I made in deciding on this approach.

A strong argument could be made for the use of XML configuration as opposed to the @Aspect approach which allows you greater control over the execution of the advice without modifying code. This would be particularly relevant in an environment where performance was a major focus. I personally have found that the control provided by logging frameworks to enable and disable particular loggers is sufficient in most environments.
