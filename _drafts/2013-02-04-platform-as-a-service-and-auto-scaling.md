---
layout: post

title: Platform as a Service and Auto-Scaling
author: john_turner
featured: false

categories:
- Ramblings
- Cloud Computing
---

I recently attended the [Cloud Europe Expo](http://www.cloudexpoeurope.com/) in London and I was lucky enough to have the opportunity to have a chat with Jesse Robbins about auto-scaling on cloud platforms.

Cloud has different meanings to different people but generally people are talking about infrastructure as a service (IAAS), platform as a service (PAAS) or software as a service (SAAS).  One of the common characteristics that people expect of any of these cloud services is that the service will scale to meet demand.  But how does this happen?

We discussed three approaches and the associated merits and flaws of each.

**Reactive Approach**

The first approach is one that I have seen the majority of PAAS providers implement.  Within each node of the platform an agent reports resource utilisation metrics to a centralised orchestration service.  The orchestration service monitors these metrics to determine when to provision additional resources or to unprovision resources (in the event of under utilisation).

There are a few things to note.  These resources are provisioned/unprovisioned just in time (JIT) and so in the case of provisioning additional resources, there is a time lag between the time the resources are requested and the time they are available to service requests.  During this time lag the user may either experience increased latency or the service may throttle user requests to protect the quality of service.  It may be acceptable to maintain additional head room to cater for this lag period but the more head room the less efficient the provisioning will ultimately be.

The second thing to note is that scaling is triggered by resource utilisation metrics.  These are often not the metrics *your users* are concerned about.  I have not seen any PAAS use business transaction latency/throughput as the enabler for auto-scaling and I feel that this is far more valuable.

<!-- more -->

*Scheduled Proactive Approach*

The second approach is pretty straight forward but strangely I've not seen many platforms implement it (I'd image that for the majority of platform providers, they see this functionality is something that can be provided off platform).  Basically, this relies upon an administrator specifying the scaling requirements of a service ahead of time.  For example, if it is know that at lunch time each day load peaks on a sports news site then it would be possible to quantify this load and provision additional capacity during this period.  The additional capacity would then be unprovisioned when load is expected to return to normal.

The advantage to this approach is that provisioning occurs ahead of load and so there is no time lag between the time the resources are requested and the time they are available to service requests.  But this is also the disadvantage because resources are provisioned before additional load materialises.  The success of this strategy depends on the accuracy of the load predictions.

Similarly, unprovisioning capacity is based on load predictions.

**Autonomic Proactive Approach**

The final approach that we discussed was that of using a reactive approach to automatically build a load profile for the service and subsequently derive a schedule on which to pro-actively provision capacity to meet that load.  For additional flexibility, it should be possible to modify this schedule for well known load peaks and troughs.

This has the advantages of the previous approaches however, this would provide the lowest operational overhead and the best possibility of matching capacity to load.  Of course the disadvantage is implementation complexity.
