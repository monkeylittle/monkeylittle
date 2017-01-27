---
layout: post

title: Martin Fowler and No DBA
author: john_turner
featured: false

categories:
- Agile
- Ramblings
---

Last week, [Martin Fowler](http://martinfowler.com published an interesting post that discussed the role of a DBA in the context of NoSQL databases.  Interestingly he titled this post [No DBA](http://martinfowler.com/bliki/NoDBA.html)

Martin's post couples the role of the DBA to that of [Integration Databases](http://martinfowler.com/bliki/IntegrationDatabase.html).  Today's wisdom  would suggest that integration databases are almost always a bad choice for enterprise application integration because database changes have to be negotiated by a number of groups (application teams and the DBA) and evolution of relational schema is very difficult to achieve effectively.

Application teams circumvent this ceremony by using schema-less NoSQL databases and message based application integration.

So does this suggest that the DBA is almost always a bad choice?  I don't think that this is what Martin is suggesting but one phrase he used struck me.  He stated that "*I often hear complaints about change orders that take weeks to add a column to a database. For modern application developers, used to short-cycle evolutionary design, such ceremony is too slow, not to mention too annoying.*".  I think this ceremony is indicative of the culture that all to often exists within DBA groups.  This culture can also exist in architecture, testing and yes, even development groups.

While this is probably over simplistic, this culture and ceremony often has sound reasoning for why it was in place at some point in time.  However, all too often these groups have been incentivised in a way that causes friction between them i.e. they have not been incentivised to achieve the same end.

We have seen solutions to this before where testers come together to work within a team to improve quality. Over time this removes the 'quality police' mentality and testers are incentivised to work with the team to improve quality.  Emergent design has had a similar impact in forcing architects and development teams to work together.  So, if we are not saying that DBA's are just a bad idea perhaps the answer is to embed them in development teams and incentivise them to the same end.

One thing that this all ignores is the need for the DBA community to get on board with the process and technology shift that has happened over the past 10 years. Not an easy nut to crack given that the adoption of Agile requires the circumvention of the ceremony held sacred by the DBA.

Here are a couple of other interesting references:

- [Why NoSQL Does Not Mean NoDBA](http://omniti.com/seeds/why-nosql-does-not-mean-nodba)
- [NoSQL != NoDBA](http://iam.richardbucker.com/2011/08/23/nosql-nodba)
