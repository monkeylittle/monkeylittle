---
layout: post

title: Why the Centre of your Application is NOT the Database
author: john_turner
featured: false

categories:
- Ramblings
---

When you attend a user group at [Skills Matter](http://skillsmatter.com/) you are offered a complementary copy of the [Open Source Journal](http://skillsmatter.com/go/open-source-journal) (OSJ).  Having recently finished reading 'NoSQL Distilled' a feature article by Bob Martin leap at me from the front cover of the OSJ.  In this article titled [No DB](http://blog.8thlight.com/uncle-bob/2012/05/15/NODB.html, Bob discussed the dominance of the relational database and the disruption caused by the emergence of NoSQL databases in the first decade of the 21st century.

Bob's tale of how he was coerced onto using a relational database by marketing is one that resonates with me.  How often are technical solutions chosen to placate one person or another? In Bob's example the pressure was applied by marketing because they felt it was what their customers wanted.

Of course, vendors are skilled and motivated to apply their own coercion techniques to force technology decisions.  Naive organisations ill equipped to properly manage vendor engagements often find themselves making poor decisions because vendors have 'created internal champions' through corporate hospitality or miss sold to decision makers who do not perform appropriate due diligence for one reason or another.  Irresponsible decision makers also use vendors to allow them to to abdicate responsibility by providing a direction in which they can point should things not go to plan.  But I digress.

Bob recalled the days in which people were encouraged to encode their business rules into stored procedures thus creating a high cost of migration to another vendor (another yacht Larry? Surely not!).  But then "<em>Finally, someone realised that there might just be some systems in the world that did not require a big, fat, horky, slow, expensive, bodily effluent, memory hog of a relational database!</em>".  I don't know what 'horky' means but right on brother!!

What Bob is saying is that this should not be a priority when designing your application.  Your application use cases should be front and centre and database and frameworks should be down in the detail.   How do you argue with that?  I felt that a natural progression was to consider domain driven design (DDD), a technique that puts the domain model a the centre of your application but this is not explicitly mentioned by Bob.  I wonder if this is intentional?
