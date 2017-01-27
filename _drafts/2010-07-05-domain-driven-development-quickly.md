---
layout: post

title: Domain Driven Development Quickly
author: john_turner
featured: false

categories:
- Book Review
---

With the advent and popularity of the EJB specification, developers spent more and more time focusing on learning and adhering to specifications and less time focusing on good design principles and OO development techniques.  *Domain Driven Design* by Eric Evans attempted to reverse this trend by refocusing on the most important aspect of software design, i.e. representing the business domain within the software.

[Domain Driven Development Quickly](http://www.infoq.com/minibooks/domain-driven-design-quickly)
 is a book from InfoQ that summarises the material presented in Eric Evans' Domain-Driven Design book.  It can be downloaded freely in PDF format (requires registration).

**Chapter Summary**

**What is Domain Driven Development**

An introduction to domain driven development is presented by first discussing the general nature of software development.  An example and discussion of the solution domain follows.

The value of reflecting the (abstract) business domain in code is discussed.  An overview is provided of how the model is developed from initial discussions with domain knowledge experts.  A high level explanation of how the domain model evolves and is used to convey knowledge among interested parties is then given.

The Waterfall Model receives some criticism because of the absence of a feedback loop from business expert to analyst to developer.  Agile methodologies on the other hand receive praise for their iterative nature.

Finally, a worked example of building a domain model for a flight control system is presented. The role of the software modeller and knowledge expert is described as is their interaction during the development of the domain model.

<!-- more -->

**The Ubiquitous Language**

This chapter begins by describing the need for a common language through which the software and knowledge experts communicate.  The domain model is described as the basis for this common language as it is the place where software meets the domain.  This language is known as the Ubiquitous Language because it is the common language used for all communications related to the project.

An approach to creating a language is described through a hypothetical dialog between a software developer and a domain expert in the flight control system project.  Mechanisms to document the domain model include UML and it is recommended that non-trivial domain models are captured in many smaller UML documents with annotations where appropriate.

**Model-Driven Development**

Sometimes difficulties occur in translating a domain model into a model that can be implemented in code.  For this reason it is advised that the developers participate in the domain modelling process to ensure that the domain model can be implemented in code and is consistent with that derived during analysis.

The most important patterns for model driven design are covered and include the following;

*Layered Architecture*

This pattern advocates partitioning a complex program into cohesive layers, specifically User Interface, Application Layer, Domain Layer and Infrastructure Layer.

*Entities*

This pattern illustrates the use of objects that maintain a consistent and universal identity throughout the system.

*Value Objects*

A Value Object is described as an object that is used to describe certain aspects of a domain but that does not possess an identity.  Value Objects are often immutable.  Money is a common example of a Value Object.

*Services*

A Service is described as an object that contains functionality that is exhibited by the domain but not easily mapped to objects.  An example is given of a money transfer between two accounts; does this behaviour belong in the sending or receiving account?

*Modules*

Modules are a way to organise related concepts in order to reduce complexity.

*Aggregates*

'An Aggregate is a group of associated objects which are considered as one unit with regard to data changes'.  An example of a Customer and Address is given were the Address is immutable and changes are made through the Customer e.g. customer.setAddress(String line1..).

*Factories*

A Factory encapsulates complex creational functionality allowing clients to create Aggregates without exposing the construction mechanism.

The Factory Method and Abstract Factory patterns are review from the perspective of domain modelling.

*Repositories*

Repositories are objects used to obtain references to Entities, usually from a database or another persistent data store.  The Repository interface will be pure domain model and so should not imply a specific persistence store.

*Refactoring Toward Deeper Insight*

This section begins by discussing refactoring the domain model when new concepts or insight occur.  It then goes on to talk about breakthrough moments when a significant (in terms of understanding) change is required to the model.  Breakthroughs occur generally when some implicit knowledge becomes explicit and this occurs naturally when exploring concepts with domain experts.  They can also occur when contradictions are highlighted or through reading material on the domain.

The usefulness of making the Constraint, Process and Specification concepts explicit is also discussed.  I particularly like the Specification concept which is used to test an object to check if an object satisfies certain criteria.

**Preserving Model Integrity**

This section deals with preserving the integrity of the model when a project involves large or multiple teams.  The model can become disjointed and the consistency of the model can suffer.  The suggested solution is to create several independent modules that are well integrated.  This allows each model to evolve, as long as it adheres to its contract, and the interaction between models to remain unaffected.

A number of techniques to help maintain model integrity are presented as follows:

*Bounded Context*

The bounded context defines a specific meaning for each model and the language used within.  The meaning is used consistently within the model and by other models interacting with the model.

*Continuous Integration*

Continuous integration suggests frequent build and test cycles to detect inconsistencies between interdependent models.

*Context Map*

This extract from the book describes this concept very concisely: 'The context map is a document that outlines different bounded contexts and the relationships between them.'

*Shared Kernel*

A shared kernel is a model sub-section that is shared between multiple models.

*Customer-Supplier*

Customer-supplier describes a relationship between two models when one model utilises another significantly.

*Conformist*

Conformist describes when a supplier has no motivation to evolve a model in collaboration with a customer and so the customer must conform to all changes in the supplier's model.

*Anticorruption Layer*

The anticorruption layer is a subsection of a model that is consistent with the model but represents concepts from and interacts with another external model.

*Separate Ways*

Separate ways describes what happens when the benefits of integrating two models are outweighed by the cost.  The two models diverge and cease to maintain any commonality.

*Open Host Service*

Open host service describes when a single supplier model is utilised by multiple customer models using a single common interface.  The interface is expanded and refactored to meet the needs new integration requirements.

*Distillation*

Distillation is the process of talking a large domain model and extracting the essence of the model into a core domain model.  Elements of the model that do not form the core domain model will be captured in generic sub-domains.

**DDD Matters Today: An Interview with Eric Evans**

An interesting interview with Eric Evens is included at the end of this book.  The interview is best distilled by presenting the questions of the interviewer.  They are as follows:

*Why is Domain Driven Design as important today as ever?*

*Technology platforms are continually evolving.  How does Domain Driven Design fit in?*

*What's been happening in the Domain Driven Design community since you've written your book?*

*Do you have any advice for people trying to learn Domain Driven Design today?*

**Thoughts**

I like the emphasis placed on developing the Ubiquitous Language and totally agree with its value to a project in creating a common vocabulary.

I agree with the vast majority of the material but I'm not sure that I agree with the suggestion that a repository interface should use a 'Specification' to define complex criteria for Entity search.  More often than not, the specification tempts developers to couple data access knowledge to the Application Layer.  I see this as similar to using criteria queries defined within the Application Layer and in my opinion this breaks encapsulation.  I much prefer strongly typed search interfaces with methods such as findActiveByName, findByColourAndLength etc.  I guess I could accept the Specification approach if the Specification deals with pure domain model (i.e. Entities and/or Value Objects) and does not have pseudo JPA SQL.

The interview with Eric is excellent and if you don't have time to read the entire book I would recommend at least reading the interview.  The answers were insightful and provided a good summary of the past and future of domain driven development.

Overall, there is much to take away from this book and I will certainly be focusing more on trying to apply some of the concepts, in particular the Specification concept.  It's a no-brainer to read this book.  It is full of relevant, current and well presented material.  It is freely available and is a good investment of time.
