---
layout: post

title: Creating a Profiling Aspect with Spring AOP and AspectJ
author: john_turner
featured: false

categories:
- Spring Framework
---

As I have mentioned previously, there are several utilities that I often find myself reusing when I join a new project. One of these utilities is the [Logging or Tracing Aspect]({% post_url 2010-02-16-creating-a-logging-aspect-with-spring-aop-and-aspectj %}) that I have previously discussed while the other is an aspect that facilitates a rudimentary profiling of the application code.

I first got the idea for such a profiling aspect from the Spring Framework user guide which presents a basic implementation in the Spring AOP section. I subsequently observed a more sophisticated implementation developed by [Jerry Kiely](http://cowboysmall.com/), who I occasionally have the pleasure of working with.

In what follows, I will present an implementation of a profiling aspect and explain how this can be utilised using Spring and AspectJ Load Time Weaving.

<!-- more -->

**Task and Task Timer Implementation**

The profiling aspect will record the start time and end time of each method invocation thus allowing more valuable statistics to be derived at a later point in time. To make this functionality reusable, we will develop more abstract TaskTimer and Task implementations.

The Task represents any action for which we require timing metrics and records the task name, start time and end time.

{% gist 6c28f3a897cd3e055de9d68abc4e6c3a %}

The TaskTimer provides a simple stack based timer implementation that allows one to start a named task, stop a task and obtain a list of all completed tasks. When a named task is started, it is pushed onto the stack and when a task is stopped, it is popped off the stack and the end time is set. The task is then added to a list of completed tasks for futher analysis at a later point in time.

{% gist 03df49bea58949f7417184af9e205950 %}

The TaskTimer is not an exhaustive implementation (no checks for end of stack etc.) so if you intend to reuse this you should certainly adapt it further.

I notice a [JIRA issue](http://jira.springframework.org/browse/SPR-2739) requesting that Spring add similar functionaliy to the StopWatch class.

**The Profiling Aspect**

As with the Logging Aspect, the Profiling Aspect uses the @Aspect approach to defining the aspect, advice and pointcuts.

The first thing you will notice is a ThreadLocal reference to a TaskTimer. This ensures the method profile metrics from different threads are not interleaved. It is more that likely that one will want to look at profiling information from a single thread at a time.

The aspect contains a single piece of around advice that creates a task name, starts the task timer, invokes the method and stops the task timer. This is fairly trivial and the only point of interest to draw your attention to is the point where the profiling metrics are output to the logging system.

Effectively, on completion of the method that initiates the profiling, the profiling metrics will be output to the logging system. If you consider a Servlet based application you could imagine the profiling beginning on the Servlet service method, and the profiling information being logged on the completion of the service method.

{% gist 76d26b314817e23e9a0a55b4f425696b %}

**Specifying the Pointcut**

As with the Logging Aspect, the Profiling Aspect pointcut expression selects methods annotated with a specific annotation (the Profilable annotation). This obviously prohibits profiling code which you cannot modify (i.e. add the annotation) so you will probably want to use other criteria within the pointcut expression.

By default, Spring uses proxy based aspect orientated programming (AOP) which limits us to applying aspects to Spring beans (look at the spring documentation for further discussion). An alternative to proxy based AOP is to use AspectJ Load Time Weaving (LTW) which instruments the code when loaded by the class loader.

To enable LTW, a configuration file (aop.xml) must be placed in a META-INF directory on the classpath. Within the aop.xml file, the aspect and the classes to be weaved must be specified. The pointcut expression can also be specified but I will leave this for you to look into.

{% gist dbd320e23a90b86e50097868818d5dd0 %}

The other thing that needs to be done is to instruct the JVM to have AspectJ perform the LTW when a class is loaded. To do this specify the following JVM parameter (inserting your own path):

*-javaagent:{path-to}spring-agent-2.5.6.jar*

Specifying the spring agent as opposed to the AspectJ agent has some advantages discussed within the Spring documentation.

**Testing the Profiling Aspect**

In this instance, rather than create a unit test to test the Profiling Aspect, I have created one to demonstrate it in action. I created a simple service annotated with the Profilable annotation. Invocations of methods within this service will be profiled and the profiling metrics will be output by the logging framework.

{% gist fd92ff4ee11e756c4e1a9f5f5d2979f5 %}

Executing the profiling aspect test results in the following logging output:

{% gist 0eb34f57e164e54e90027c995e8e6a62 %}

This article should act as a starting point for exploring Spring AOP and AspectJ further. You can download the [profiling aspect code](http://thoughtforge.net/wp-content/uploads/2010/03/spring-profiling-aspect.zip) and play around with Proxy based AOP and LTW, specifying the pointcut expression in the aop.xml file or within code etc.
