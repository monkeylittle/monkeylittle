---
layout: post

title: Classifying Cloud and Cloud Providers
author: john_turner
featured: false

categories:
- Cloud Computing
---

I was reading a post on [Mapping the Cloud/PaaS Stack](http://natishalom.typepad.com/nati_shaloms_blog/2012/05/mapping-the-cloudpaas-stack.html) by Nati Shalom (CTO and founder of [GigaSpaces](http://www.gigaspaces.com/) and tend to agree with his assertion that a reasonable way to classify the cloud and cloud providers would be to map them against productivity and control.

In this context, productivity is a measure of how efficiently value can be delivered from inception through to realisation (you might think of this as from requirement to production).  Control is the ability to specify and manage the details of the compute, network and storage infrastructure, deployment topology, operational management etc.

<img src="/assets/img/post/2013-02-13-classifying-cloud-and-cloud-providers/classifying-cloud-and-cloud-providers.png" class="img-fluid img-thumbnail mx-3">

If we step back for a moment and consider cloud adoption in a typical corporate environment it helps one to understand why this classification is useful.

In a typical corporate environment there exists a substantial legacy burden (I'll call it burden because this is more often the case).  It would be impossible for an organisation to migrate this legacy onto a high productivity and low control cloud as this would require re-engineering those applications.  I've seen this referred to as the requirement for the application to be cloud native (i.e. aware of the fact that it is executing in a cloud environment).

The second side effect of running in a low control cloud environment is that applications become intrinsically linked to the execution environment and so you often sacrifice any opportunity to maintain cloud portability (i.e. you're locked in)!

The opposite is to provide a high degree of control.  This affords the flexibility to chose between language runtime, application containers, messaging provider etc. and so is better aligned to the legacy environment in which evolution (and divergence) of technology stack has occurred.  The cost associated with a high degree of control is typically increased complexity and reduced productivity.

So the nirvana is a platform with a high degree of productivity yet a high degree of control. Of course, given a liberal sprinkling of governance this is exactly what a DevOps environment would provide using tools such as [Puppet](https://puppetlabs.com/) or [Chef](http://www.opscode.com/chef/).  What is interesting is that [GigaSpaces](http://www.gigaspaces.com/)' [Cloudify](http://www.cloudifysource.org/) is attempting to build this governance into a platform that ensures some degree of conformity (and thus productivity) while facilitating control within the platform itself (i.e. the platform is open to extension).  What I also found compelling about this approach is that the platform itself uses the tools typically leveraged by DevOps and so facilitates a lower cost of divorce.

With all this said, a useful addition to the classification is that of maturity.  What I find challenging about all things cloud is the fragmentation and maturity.  There is an increasing degree of fragmentation as providers sell their own vision of cloud and thus cloud as a whole lacks maturity.  As a consumer of cloud services (either private, public or public/private) it is therefore necessary to ensure that appropriate abstraction is employed to facilitate divorce from your chosen provider should the industry make an abrupt change of direction.
