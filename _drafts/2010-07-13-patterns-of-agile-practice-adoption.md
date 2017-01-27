---
layout: post

title: Patterns of Agile Practice Adoption
author: john_turner
featured: false

categories:
- Book Review
- Agile
---

[Patterns of Agile Practice Adoption](http://www.infoq.com/minibooks/agile-patterns) is another book from InfoQ that describes potential ways in which Agile practices could be adopted individually and as clusters of practices that complement one another.  As with [Domain Driven Development Quickly](http://www.infoq.com/minibooks/domain-driven-design-quickly), this book can be freely downloaded (registration required).

**Part 1 - Business Value, Smells, and an adoption Strategy**

This part of the book focuses on the reasons why one might consider adopting agile practices.  It starts by looking at the value that agile practices can bring to the business, follows on by suggesting problems that agile practices could address and finishes by describing how to adopt agile practices.

*Business Value*

Agile practices have the potential to deliver value to the business in a number of areas and your business might be more sensitive in one or more of these areas.  The areas discussed include:

- Reduce time to market
- Increase value to market
- Increase quality to market
- Increase flexibility
- Increase visibility
- Reduce cost
- Increase product lifetime

A useful exercise is presented at the end of this section to help one determine which areas are more important to your business.

*Smells*

We, as developers, are used to discussing code smells but probably less used to discussing smells in our development methodology or practices.  This section discusses 'Business smells' and 'Process smells'.  Business smells are smells that affect the business and are visible to customers while process smells are only visible to the development team.  I've listed the smells discussed below:

*Business Smells*

- Delivering new features to the customer takes too long.
- Features are not used by the customer.
- Software is not useful to the customer.
- Software is too expensive to build.

*Process Smells*

- Us vs Them.
- Customer asks for everything including the kitchen sink.
- Direct and regular customer input is unrealistic.
- Lack of visibility.
- Bottlenecked resources.
- Churning projects.
- Hundreds of bugs in bug-tracker.
- Hardening phase needed at end of release cycle.
- Integration is infrequent.

Again, a useful exercise is presented at the end of the section that asks one to discover, investigate and rank smells within the organisation.

*Adopting Agile Practices*

An awareness of agile practices is assumed as business values are related to corresponding agile practices that could potentially enhance the ability to deliver these values.  Similarly, smells are related to corresponding agile practices that could potentially address the smell.

Advice is then delivered on how to use the information presented to develop a tailored agile adoption strategy.  This advice can be summarised as follows:

- Be business-value focused.
- Be goal oriented.
- Adopt iteratively.
- Be agile about your adoption.
- Use a test-driven adoption strategy. (i.e. validate your results)

<!-- more -->

**Part 2 - The Patterns**

As with any pattern language, the patterns presented adopt a standard layout.  The layout presents:

- Name: Pattern name<
- Description: Brief description.
- Business Value: Business values pattern effects.
- Sketch: Narrative of pattern use.
- Context: Environment where the pattern may be applied.
- Forces: Elaboration of specific environmental conditions acting on the pattern.
- Therefore: Full pattern description.
- Adoption: Adoption guide.
- But: Negative consequences.

*Automated Developer Tests*

This pattern describes a set of tests that are maintained by developers to reduce the occurrence and/or cost of bug, increase confidence when refactoring and increase decoupling.  The tests are then executed automatically as part of a continuous integration process.

*Test-Last Development*

This pattern describes writing automated developer tests after the code has been written.  Tests tend to conform to the initial implementation rather than the requirements (if they differ).

*Test-First Development*

This pattern describes writing automated developer tests before the code has been written.  Testing in this way is more effective than Test-Last Development but harder to adopt.  Tests conform to the requirements as no code exists.

*Refactoring*

This pattern describes changing the structure of code without changing the behaviour.

*Continuous Integration*

This pattern describes the practice of performing a clean build, deploy and execution of unit and integration tests every time a code change is committed to the source repository.

*Simple Design*

This pattern describes resisting over engineering a solution and extending a design only when required.  Add more flexiblecomplex designs only when needed to avoid the cost of complex software until the benefit is necessarary.

*Functional Tests*

This pattern describes executable requirements that can be used as functional tests.  These functional tests represent the requirements of the user and when complete indicate the requirement is done.  Some useful examples are provided to clarify what functional tests are.

*Collective Code Ownership*

This pattern describes code ownership where no one individual or set of individuals has exclusive ownership of a section of the code base.

**Part 3 &ndash; Clusters of Practices**

Clusters, as described in this book, are groups of agile practices that build upon or complement each other such as the cluster of practices are greater than the sum of their parts.

*Evolutionary Design*

This cluster describes a set of practices that support an evolutionary design process.  These practices include Automated Developer Tests, Refactoring and Simple Design.

*Test-driven Development*

This cluster describes a set of practices that focuses on developer tests.  These practices are primarily Evolutionary Design, Collective Code Ownership and Continuous Integration.  The primary practices in turn include others resulting in the inclusion of many of the practices described.

Again the sketch is very useful in that it narrates a very real illustration of adopting this cluster of practices.

*Test-driven Requirements*

This cluster describes a set of practices that focuses on testable requirements.  These practices are Functional Tests, Customer Part Of Team and Continuous Integration.

**Thoughts**

The first part of the book deals with the first problem when trying to adopt agile practices and that is to get buy in from the stakeholders.  What is the business getting from this transition? What are the business owners getting?  What are the developers getting?  All questions that need to be answered before you can start to transition to agile practices.  The transition is not an easy one and so you will need committed stakeholders.

The section on smells relates the problems that the business is experiencing to those of the development teams and vice versa which is really useful in clarifying possible cause and effect.

I recently read [The Pragmatic Programmer]({% post_url 2010-06-29-the-pragmatic-programmer %}) and I like the way the material presented similarly to a pattern language i.e. short, concise and well organised.  Presenting them as patterns also leads a developer familiar with patterns to understand how they can be applied, as guidance rather than absolute right or wrong.

The 'Sketch' narrative in the patterns section enhances the understanding of the pattern.  I like this story telling approach and it is similar in style to the [Kate Oneal](http://xprogramming.com/category/kate-oneal) stories by [Ron Jefferies](http://xprogramming.com/.

The difficulty of non-consistent architecture when applying evolutionary design is very real and although it is addressed in the book, it is a problem that will always be difficult to address.  Communication and collaboration can be the key but then you have the potential problem of too much communication.  The 'Divide After You Conquer' technique is one I have seen work well in the past and this is the approach I would tend to take.
