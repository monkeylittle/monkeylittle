---
layout: post

title: 'Continuous Delivery: A Maturity Assessment Model'
author: john_turner
featured: false

categories:
- Continuous Integration
tags:
- Continuous Delivery
- Continuous Integration
---

<img src="/assets/img/post/2013-03-11-continuous-delivery-a-maturity-assessment-model/old-man.jpg" class="img-fluid img-thumbnail pull-left mx-3">

[ThoughtWorks](http://www.thoughtworks.com/) recently published a paper that proposed a [maturity assessment model for continuous delivery](http://info.thoughtworks.com/Continuous-Delivery-Maturity-Model.html). Technology led companies continue to eat the lunch of traditional companies who are struggling to innovate at the same pace as their younger and more dynamic counterparts. Companies such as Netflix, Amazon, Google and Apple strive to reduce the cycle time from concept to reality so are able to give their customers what they want before any of their lumbering competitors.

Even more galling, they share how they are achieving these short cycle times knowing that the incumbents simply don't have it in their DNA to behave in this way. Going even further, they ([Netflix][http://techblog.netflix.com/] in particular) even open source the software that enables them to do what they do...I can just imagine their smug little faces as they say '*follow that old man!*'.  The 'old man' just doesn't understand that it is not enough to be technology enabled because today '*the custom software that you create will increasingly be part of your competitive edge*'.

These old men are set in their ways. They find comfort in the routine that they have become used to over the years. They don't even understand what the kids these days are talking about! You'll still call around for tea because you feel a little guilty about leaving them behind.  You'll listen to their stories about how it used to take ages to release to production; how making a schema change was not something to be taken lightly.  You'll do this because you feel sorry for them.

<!-- more -->

I often use the terms technology led and technology enabled to describe companies who are either driven by their technology or simply enabled.  The Forrester paper describes this as an IT-as-a leader or IT-as-a-service model.  They concluded that '*a business technology model where the business and IT/engineering work in partnership to deliver new services from conception through to production stands the best chance of matching the needs of business leaders with the reality of service delivery capacity as it exists today.*'  Common sense really so why do so many companies still miss the point.  Maybe the grey matter is not quite what it used to be. Don't forget your pills grandad!

Forrester went on to say that '*While a business technology partnership model is best suited for matching service delivery capability to expectations, shops that engage in continuous delivery go beyond joint decision-making. They take an economic approach to managing their product portfolio services - one that's based on data gathered from direct customer engagement.*'. That's what it means to be truly technology led.

Forrester also make the point that reduced cycle time from inception to production is facilitated by agile and lean, continuous integration and DevOps. It's no coincidence that these relate to organisational change that spans the entire life-cycle. So if you aspire to be technology led your entire organisation must change focus, not just your technology organisation!

'*Many of the advanced development shops we've spoken with point out that an elastic self-provisioned deployment environment is a critical component of modern service architecture...*'.  In my opinion this is what is primarily driving the interest in IAAS and PAAS with companies leaning to centralised provision of PAAS to enforce some governance.  What they need to be careful of is that they don't create the same ceremony around their PAAS that was associated with other historically centralised services such as testing, database administration, infrastructure, security and architecture.  Time will tell if the lessons have been learned!

The Forrester paper highlighted a couple of things the respondents felt slowed their software releases. The first, interestingly, was a '*lack of slack time for continuous improvement*'.  When will you learn people, that the expensive, highly educated and highly motivated team that you felt compelled to build is not a bloody field mule.  You won't get results by working it harder.  Back off and let them find better ways to do things.  Because there are only so many hours in a day you are not going to scale by having them working longer hours!

Five stages of continuous delivery maturity were identified and presented in a table along with the characteristics evident at each stage.  It's well worth a read and if continuous deployment is what you aspire to then it's not an unreasonable roadmap, though I don't believe there is a one size fits all solution.

The first stage is titled '*An Initial Level of Continuous Deployment Capability Constrains Innovation with Software Services*'.  Setting aside the characteristics that focus on automated testing and automation in general one thing stood out for me.  That was that '*Developers, testers, operations and management have goals that bring them into conflict*'.  Unfortunately, this is a characteristic that I have seen and experience all to often.

The second stage is titled '*A Managed Level of Continuous Deployment Capability Introduces an Adaptive Delivery Process*'. Software releases are moving toward using change management processes and delivering time boxed releases with the aid of a pinch of automation. The time box requires '*an identified product owner who can examine functionality and quality tradeoffs and maintain customer support for the service while it's being developed*'. Personally I would have gone further and require a product owner that is empowered and capable of making mature evidence based decisions and not one who kicks the mule because the furrow was not ploughed in a straight line.

Stage three is titled '*A Defined Level of Continuous Deployment Capability Builds Quality Into The Release Process*'. This is what I refer to as <strong>Continuous Integration</strong>. Commit tests are run against trunk and development is predominantly trunk based.  Build failures are addressed with urgency and deployment into integrated environments is automated.  Solid database refactoring and versioning practices are followed and changes are automated.  Testers primarily focus on exploratory testing and quality assurance as opposed to regression testing and quality control.

Stage four is titled '*A Quantitatively Managed Continuous Deployment Capability enables Release On Demand*'. This is what I refer to as **Continuous Delivery**. A new release can be deployed at the discretion of the product owner because trunk is always deployable and verified for correctness. Not only is the software doing what you expect it to do but what you expect is what the product owner expects also. This is achieved through a combination of ATDD and TDD as well as extensive automation of every deployment task. Teams take responsibility for the full feature life-cycle meaning that for a feature to be done it must be functioning in production.

Finally, stage five is titled '*An Optimising Level of Continuous Deployment Allows Software Developers to Drive Business Value*'.  This is what I refer to as **Continuous Deployment**. This requires cross functional teams that self-organise and assume responsibility for the quality of service throughout inception, development and production. Testing techniques such as A/B testing produce data to inform decisions as teams produce a continuous stream of incremental improvement.  Feature toggles, branch by abstraction and parallel production environments allow teams to experiment early and often, and quickly reject failed experiments.  Tools such as the [Netflix Simian Army](http://techblog.netflix.com/2011/07/netflix-simian-army.html) may even be used to verify non functional characteristics of the service in production.  These are lofty ambitions indeed.

All in all, very insightful as you would expect from Forrester and ThoughtWorks.
