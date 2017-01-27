---
layout: post

title: Continuous Integration
author: john_turner
featured: false

categories:
- Book Review
- Continuous Integration
---

<img class="alignright" src="/assets/images/posts/continuous-integration/book-cover.jpg"/>

I have been building and maintaining continuous integration (CI) environments for several years now and would consider myself well versed in the practice. There really is a wealth of information on CI and people such as Martin Fowler and John Smart do a great job as advocates by providing a solid understanding and practical advice. Due to the amount of freely distributable software supporting the establishment of CI environments, acquiring knowledge of the subject is the biggest entry cost.

For that reason, it was with much anticipation that 'Continuous Integration' was published back in 2007 (shame on me for only reading it now!).

**Getting Started**

The book starts of with a gentle introduction to the subject providing a preview of the material to come. Chances are that if you have purchased this book that you already know roughly what CI comprises and how it works so you won't learn a lot here. Still though, its good to lay some ground work and review that activities that typically occur as part of a CI system.

**Introducing Continuous Integration**

Next we cover a number of practices that encapsulate what I would call the discipline of CI. It is not enough just to have this thing called CI running in the background and expect it to protect you from all evil. You must:

- Commit Code Frequently
- Fix Broken Builds Immediately
- Write Automated Tests
- Run Private Builds
- Avoid Broken Code

These disciplines must be followed religiously because if one person on the team fails to adhere to them, the entire CI system is devalued. My experiences have always reflected the the broken windows theory, as the frequency of broken builds increases, people become more tolerant of them and thus the build breaks more often.

<!-- more -->

**Reducing Risks Using CI**

So, CI is principally about integrating early and often to reduce risk, reduce defects and increase quality. A number of scenarios are outlined along with the rationale for why CI can help alleviate the problems illustrated by those scenarios. Again, while there was nothing ground breaking for me, the information was well presented and did a good job of conveying some use cases for CI.

**Building Software at Every Change**

The book examines each of the activities that form part of an effective CI system. This begins with building the software. Some of the points made like centralised software repository, consistent directory structure etc. are so ingrained that today we often take this for granted. Source code repositories and dependency management solutions have become part and parcel of software development.

It was useful though to highlight that CI builds should be capable of 'Building for any Environment' and come in the form of a private build, integration build and release build. In order to maintain a rapid feedback cycle, you might also utilise stage builds that execute varying levels of testing, code analysis etc.

**Continuous Database Integration**

Continuous database integration is one of the activities of a CI system that is easy to get wrong. Done right, it removes a lot of frustrations from the development process. I often see teams who spend inordinate amounts of time tracking down issues with data, its structure or storage. There are lots of options to achieve continuous database integration ranging from in memory databases up to dedicated instances and these are explained in detail.

**Continuous Testing**

When most people think about continuous integration they immediately think about automated testing. Automated testing plays a major part in the continuous feedback that makes CI so compelling.

In order to get the most out of automated testing its effectiveness must be measured. This is typically achieved through code coverage tooling but is all coverage equal? Automated testing can also be time consuming and so should be categorised to facilitate different execution frequencies depending on the type of testing being carried out. This is discussed in a clear and informative manner.

**Continuous Inspection**

I remember when I started writing code in a corporate environment (yes, way back then!). The first thing I was given was a document describing the style in which code was to be written. After a while, I got to look at actual code and found that it bared no resemblance to the style guide I had been given. This sort of quality check is far better automated.

But we can go even further and actually gather some insight by using other quality metrics. Starting with duplicate code and moving on to measures such as cyclomatic complexity, afferent coupling and efferent coupling we can get a real insight into the overall quality of our code base. Using tools like Sonar, these quality metrics can be tracked over time to measure improvement or deterioration and have an impact on the processes and techniques adopted by a project or product team.

**Continuous Deployment**

Having implemented a process whereby software is automatically build, integrated and tested the next logical step is to automate the deployment of the software. This is an area where there are significant return on investment to be had. Software deployment is often complicated and involved. Automating this process frees up developers to do what they enjoy and more importantly are being paid to do (or maybe what they are paid to do and more importantly enjoy!!). It also reduces the time lag from the cost of producing the software to releasing the value of that software.

**Continuous Feedback**

The book finishes by discussing the ways in which a CI system can provide feedback to the development team. The default mechanism of email can so easily be ignored. Alternatives such as flashing or coloured lights, SMS and audible feedback are discussed.

**Thoughts**

Although I was very familiar with much of the material, reading this book was a useful refresher. It is well written and easy to follow. It is certainly not a "how to" book but you will walk away with a firm grasp of the theory. There are lots of sources of information related to how to implement specific CI systems.
