---
layout: post

title: 'Agile Testing: A Practical Guide for Testers and Agile Teams'
author: john_turner
featured: false

categories:
- Book Review
- Agile
---

<img src="/assets/img/post/2012-04-01-agile-testing-a-practical-guide-for-testers-and-agile-teams/book-cover.jpg" class="pull-left img-fluid img-thumbnail mr-3"/>

I have worked with testers on an Agile team before and it has worked very well for both the team and the customer.  In my previous role at Bank of Ireland, testers who had come from a traditional testing background worked within our teams to help ensure we had quality deliverables at the end of each iteration.  It was different from traditional test approaches in that they were sitting with the team, collaborated constantly and were integral to the process of developing the solution.  I never found them critical of poor quality or guilty of ring fencing roles and responsibilities.  This was refreshing and without doubt a better way of ensuring quality than those I had experienced before.

Recently, here at Paddy Power, we have been interviewing for a number of open [Agile tester positions](http://www.workwithpaddy.com).  I''m pretty sure I know what a good Agile tester looks like but I have often struggled to fully articulate what that entails.  I have had this book on my shelf for a couple of months and now I'm looking to it to help me fully understand what an Agile tester is.

<!-- more -->

**What Is Agile Testing Anyway?**

The book starts by introducing Agile testing and comparing Agile to traditional testing.  I liked the way in which the activities of programmers and testers on an Agile team were explained using the terms "Technology-Facing Tests" and "Business-Facing Tests".  It is sometimes confusing for people, who come to understand that programmers do testing, why there is a need for a tester on an Agile team and these terms help clarify that need.  To quote the book directly, testers on an Agile team "..are working together with a team of people who all feel responsible for delivering the best possible quality..".

I have recently had a number of conversations about having a tester in an Agile team or having a separate test team. Again, quoting form the book, "Testers are also on the developer team, because testing is a central component of agile software development.  Testers advocate for quality on behalf of the customer and assist the development team in delivering the maximum business value."  To steal a term from Lean, I think this is the best way to insure you "have quality built in".  This whole team approach also ensures that the "...team thinks constantly about designing code for testability."

**Ten Principles for Agile Testers**

One of the behaviours that used to frustrate me as a developer was that testers were seen as successful when they found bugs in the software.  Agile testing sees a successful tester as one who helps the team ensure the software does not contain any bugs.  This book reinforces this by saying "An agile tester doesn't see herself as a quality police officer, protecting her customers from inadequate code".

Lisa and Janet go on to list the ten principles as:

- Provide continuous feedback.
- Deliver value to the customer.
- Enable face-to-face communication.
- Have courage.
- Keep it simple.
- Practice continuous improvement.
- Respond to change.
- Self-organize.
- Focus on people.
- Enjoy.

People familiar with Agile in general will find these quite familiar.

**Cultural Challenges**

Many of the cultural challenges discussed are similar to those faced by any team member adopting Agile for the first time.  As such, I have covered many of these while reading  Mike Cohn's [Succeeding With Agile]({% post_url 2011-02-02-succeeding-with-agile %}).  There are however a number that are either unique or more acute when faced by the testing organisation.

In my experience, testing is often the poor cousin to programming.  Test teams are often under funded, have limited influence and are not given a voice.  Those who are given these things can fall into the trap of assuming the role of "Quality Police" which fosters antagonistic behaviour.

To succeed in an Agile team, testers must become fully signed up members.  For this reason, I really liked the "Tester Bill of Rights" outlined by Lisa and Janet.

*Tester Bill of Rights*

- You have the right to bring up issues related to testing, quality, and process at any time.
- You have the right to ask questions of customers, programmers, and other team members and receive timely answers.
- You have the right to ask for and receive help from anyone on the project teams, including programmers, managers, and customers.
- You have the right to estimate testing tasks and have these included in story estimates.
- You have the right to the tools you need to perform testing tasks in a timely manner.
- You have the right to expect your entire team, not just yourself, to be responsiblenfor quality and testing.

**Team Logistics**

As I mentioned previously, I have recently been involved in a discussion on independent test teams or a tester as part of an Agile team.  This was covered very well with Lisa and Janet putting forward very compelling arguments for disbanding independent test teams and absorbing testers into the Agile team.  Similar to Mike Cohn''s "Community of Practice", it is still necessary to bring together like minded people (testers in this case) to share experiences and learn from one another.

The other points that were made around inclusive discussion, performance and rewards etc. are a little repetitive having read Cohn's books on Agile.

**Transitioning Typical Processes**

Quite a bit of this chapter is dedicated to metrics and defect tracking.  I found this very useful and reinforces some of my own ideas on the subject.  For example, a defect found and fixed within an iteration should not really be tracked.  The value in tracking defects is only relevant once bugs are released to the customer which typically means from user acceptance test onward.

**The Purpose of Testing**

Next we are introduced to the "Agile Testing Quadrants".  Tests are grouped into four categories that in varying degrees support the team, critique the product, are business facing or are technology facing.  This is very useful identifying why a team would/should perform different types of tests. I also found it useful in justifying why certain types of tests should not test certain aspects of the product.

**Technology-Facing Tests that Support the Team**

Technology facing tests include unit and component tests and focus on guiding design and development.  Test-Driven Development is discussed briefly and some time is given to highlight that TDD is more about design than testing.  The sidebar on layered architecture is particularly relevant and added context to the discussion.  A further sidebar on testing legacy systems was also very interesting and in line with my own experiences of working with legacy code and systems.

What a test should not do is just as important as what a test should do.  Where do unit tests stop and component tests start?  What type of tests are appropriate?  These questions are answered in the context of technology facing tests.

Toolkits have evolved as people have adopted Agile and TDD.  Some of these toolkits are mentioned briefly.

**Business-Facing Tests that Support the Team**

From my understanding, business facing tests assert that the software does what the business expect (these may be considered conditions of satisfaction or acceptance tests).  In an Agile environment, these tests are added to and amended on an ongoing basis (although we limit this to clarifications during the sprint or iteration).  Business facing tests are automated (as much as possible..non-tangible qualities such aesthetics cannot be automatically tested).

An important point was made that using business facing tests to drive development maintains the focus on testable code.

**Toolkit for Business-Facing Tests that Support the Team**

The toolkit outlined by Lisa and Janet is pretty much aligned to the tools I am familiar with.  Mind mapping tools are a great way to organise high level requirements while test tools such as [Fit](http://fit.c2.com/), [Fitnesse](http://fitnesse.org/), [Selenium](http://seleniumhq.org/) etc. provide the ability to automate business facing tests.  As always, it's important to select the right tool for the specific circumstances.

The book also touches on Behaviour Driven Development (BDD) and I find that this is a subject that is receiving more and more focus.  John Smart of [Wakaleo](http://www.wakaleo.com/), who recently worked with our development teams at Paddy Power, is a strong advocate of BDD and introduced some excellent tools and techniques to our development process.

**Business - Facing Tests that Critique The Product**

This testing includes Exploratory Testing, Usability Testing and User Acceptance Testing (UAT).  Often, development teams are not involved in these test activities even in companies that have adopted and adapted Agile.  They are often seen as an 'over the fence' activity where the test team takes a release and provides feedback.

That said, Exploratory testing can occur within an iteration but often only works well in a team with dedicated testers.  Without dedicated testers, a development team does not have the same focus on testing in my experience.  I have also been involved in projects were Usability Testing occurs in parallel using UI prototyping tools developed with the user stories.

**Critiquing the Product Using Technology-Facing Tests**

Performance, load and security testing are often forgotten until the end but they have the ability to make or break a project.  More and more you see performance testing (typically relative rather than absolute performance testing) occurring within a continuous integration environment.  There are a wide range of commercial and open source tool sets available that support performance and load testing.

I particularly liked the 'Performance Testing from the Start' story where Ken De Souza described how he included performance test scripts within his definition of done.  This way, when he got to the point when he wanted to execute load (or stress tests) he had scripts available that had already been executing in his CI environment.

**Why We Want to Automate Tests and What Holds Us Back**

I'm not sure that there is anyone left that does not understand the need to automate tests.  However, the return on investment is often overlooked.  We should consider the cost/benefit of automating specific tests by thinking about the risk that is mitigated by a test, the level of volatility of the code base, the historic occurrence of bugs and the effort required to provide automated test coverage.  Sometimes it is more appropriate to continue to provide manual regression testing.

Testers should also consider the level(s) at which testing should occur.  Component, integration and acceptance tests interact with the system in different ways and will test different aspects of the system.  Do we need to automate each type of test?  Is it possible or practical to test at each level?  These are questions an Agile tester must consider when deciding to automate tests.

**An Agile Test Automation Strategy**

Just like delivery of features, a test automation strategy can be incremental.  Consider automating the areas that cause the most pain and build out your automation iteration after iteration.  There are lots of considerations that are covered well by the book but if I were to highlight one thing it is this.  A regression test suite has the same characteristics as the product code base.  You must build it in a way that is easy to extend and maintain.  A regression test suite enables the team to continue to deliver features at a fast pace.  Ensure it does not become a millstone for the team by becoming difficult to maintain, extend or manage.  Bring the same rigour to building your test suite that you would to any product or feature.

The book discusses record and playback, scripting and BDD approaches.  Ensure you understand the difference between these and the impact of selecting one approach over the other.

**Tester Activities in Release or Theme Planning**

The life of a tester on an Agile team is a busy one.  During planning they must decide what types of testing to undertake, what test environments are required, what test data is required and what tests should be automated.  They must also contribute to the estimates for features/user stories and consider how they should be tested and estimate what size the test effort should be.  In the same way that developers consider the priority and sequence of developing features, testers must also consider the priority and sequence so that the product is tested as efficiently as possible.    A tester also needs to consider what is an appropriate level of testing.  Usually this is based on some type of risk (life, reputation, financial etc.).

Most teams (if not all) consider acceptance testing (automated or manual) as the last step in their 'Definition of Done'.  For this reason, test reposting is also a very important communication tool that provides a detailed view of the progress made during an iteration and release.  I have seen some excellent examples of using test reporting to drive the development process that include things like requirements traceability.

**Hitting the Ground Running**

Developers often need to research a product, framework or technique prior to an iteration so that they can 'hit the ground running'.  Testing is no different and testers need to do their own research to ensure that they know what is involved in testing upcoming features.  That research may include talking to customers to understand the feature, talking to developers to understand how they will implement the feature, discussing you test approach with other testers etc.  Because Agile teams move forward together it is very important that the whole team start an iteration with any advance preparation necessary already complete.  This is of course not to say that advance preparation is always needed.

**Iteration Kickoff**

One of the problems I often see testers on Agile teams have is that they will maintain that they have nothing to test until features start to be delivered.  The reality is that on an Agile team a tester is involved in a more diverse set of activities than they are on a traditional team.  During iteration kickoff, testers should be reviewing stories for testability and helping the customer define conditions of satisfaction.  They should help the customer convey stories to the development team and work with the development team to build a shared understanding.  They should be writing task cards and pro-actively seeking opportunities to help the team with their tasks by preparing test data, environments etc.  There is no end of things that testers can (and should) become involved in.

**Coding and Testing**

During coding and testing, an Agile tester continues to collaborate with the customer and the team.  They do this through reporting, raising defects, triaging defects raised by the customer, pairing with programmers (that's right, I said pairing with programmers!!) etc.  They prioritise test execution and automation based on risk and return.  Testers should adapt their approach during an iteration based on what they are learning about the features and their implementation.  They should manage their own time while remaining aware that they are taking a 'whole team approach'.

**Wrap Up the Iteration**

Wrapping up an iteration is no different for an Agile tester than it is for any other member of the team.  They should be involved in the 'show and tell' and the retrospective.  They should contribute as a first class member of the team and not fall into the pattern of allowing others to drive these activities.  The book suggests that testers are ideally placed to demonstrate new features to the customer.  I much prefer to rotate this privilege as it is often the only chance for the team to get direct feedback and hopefully praise from the customer.

**Successful Delivery**

The aim of an Agile software team is to deliver potentially shippable product every iteration (normally 2-4 weeks).  But when a potentially shippable product becomes a product that is going to be shipped there are normally a number of additional activities that need to occur.  The term 'End Game' is used to refer to the time during which a team are making those finishing touches to a product just before it is shipped to a customer.  This might include testing on different environments, Alpha and Beta testing or packaging among other things.

The activities that occur during the 'End Game' tend to differ significantly depending on the characteristics of the product but for me one thing remains constant.  A team, product manager etc. should strive to reduce the duration of this 'End Game' as much as possible so that value is delivered as close as possible to when the cost is incurred.  This is typically achieved by aggressively automating as many of these activities as possible.

**Key Success Factors**

The book concludes by identifying six key success factors for implementing Agile testing.  I'll enumerate them here:

- Use the whole team approach.
- Adopt and Agile testing mindset.
- Automate regression testing.
- Provide and obtain feedback.
- Build a foundation of core practices.
- Collaborate with customers.
- Look at the big picture.

I don't think I can add much here except to say that if you are an Agile team you should be striving to automate (almost) everything!

**Thoughts**

I had to agree with the statement that "Some people saw testers as failed programmers or second-class citizens in the world of software development".  I still see this from time to time but the flip side of the coin is that "Testers who don't bother to learn new skills and grow professionally contribute to the perception that testing is low-skilled work.".  Having testers as an integral part of the team helps debunk this idea and develop mutual respect and appreciation between testers, programmers and business analysts.

I liked the numerous sidebars along with Lisa and Janet's stories from the coal face.  The facts that the sidebars describe testing from the perspective of a wide range of individuals with varying roles and responsibilities lends weight to the points being made throughout.

A whole section of the book is dedicated to 'An Iteration in the Life of a Tester' and this section is really effective in communicating what activities a tester should become involved in during an iteration.  This is a must read for any aspiring or practising Agile tester.
