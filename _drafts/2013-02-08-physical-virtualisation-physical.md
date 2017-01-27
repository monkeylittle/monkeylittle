---
layout: post

title: Physical + Virtualisation = Physical
author: john_turner
featured: false

categories:
- Ramblings
- Cloud Computing
---

Recently I've spent some time considering the value of virtualisation.  It reminded me of a [ThoughtWorks Technology Radar](http://www.thoughtworks.com/radar) (march 2012) in which the manner that some organisations continue to treat virtual machines as physical was derided.  So in what ways do organisations treat virtual infrastructure as physical?

The technology radar states the following:

> While virtualisation is on the rise, some organisations are treating virtual machines like physical infrastructure. We frown on doing a full operating system install for each VM or using VMs for load testing.  Virtual machines can be cloned, snapshotted, and manipulated in ways physical machines cannot, and also have vastly different performance characteristics than physical hardware.

If we were to put this more concisely we could say that for these organisations:

**Physical + Virtualisation = Physical**

For me, the question is why an organisation would spend significant time, effort and resources to virtualise their infrastructure but continue to manage that infrastructure in the same way they managed physical infrastructure.  The only answer that I could argue is that it allows for better organisation and consolidation within the data centre (and a minimal amount of utilisation improvement, particularly if your business applications are implemented in Java).  The value accrues to the infrastructure department and has little benefit to other areas of the organisation.

Often, this occurs when the drive to virtualisation is spearheaded by the infrastructure department.  The result is therefore inevitable.

So, what would need to happen to ensure that the value of virtualisation accrues to other areas of the organisation?

What is missing is the ability for those areas to orchestrate the virtualised infrastructure.  More concisely:

<!-- more -->

**Physical + Virtualisation + Orchestration = Infrastructure as a Service**

If the virtualisation effort was driven by the infrastructure department, this can sometimes be quite a significant shift in focus.  *The focus is now ensuring the value accrues to other areas within an organisation.*

So how does orchestration facilitate this?  The two pillar features of orchestration are on demand provisioning and on demand unprovisioning.

As a result of on demand provisioning the time to bootstrap projects that have infrastructure requirements is dramatically reduced.  This has a positive impact on the agility of an organisation.

On demand provisioning also has a positive impact on the levels of utilisation within the data centre.  The reason for this is more behavioural than technical.  Without orchestration (or with orchestration governed by a central group) the lead time to provision is often as long as the lead time to provision physical infrastructure.  As a result, people will tend to retain infrastructure beyond the time period for which it was originally required.  This will allow them to re-purpose infrastructure and thus avoid the lead time to provision.  With orchestration in place (and delegated administration of same) people are less reluctant to return infrastructure to the pool and higher utilisation of infrastructure can be achieved.

This ability to provision and unprovision on demand also has benefits for the operation of your applications as it facilitate scaling capacity to meet demand (which again improves utilisation).

I'd be interested to hear your experience of virtualisation initiatives in you have been involved in!
