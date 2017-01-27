---
layout: post

title: User Stories Applied
author: john_turner
featured: false

categories:
- Book Review
- Agile
---

<img src="/assets/img/post/2011-02-22-user-stories-applied/book-cover.jpg" class="pull-left img-fluid img-thumbnail mr-3"/>

User stories are critical to the way in which an agile team discovers and delivers new features. They primarily act as place holders for features which form the product backlog. As the agile team begins a release or iteration, a planning exercise is performed in which user stories will be refined and estimates will be provided (with greater degrees of certainty as the process continues).

The utilisation of user stories by an agile team is significantly different to the way traditional teams utilise use cases or other types of requirement documentation. Through this book, Mike Cohn explains the what, when and how of user stories.

<!-- more -->

**Part 1 - Getting Started**

The book starts out with a really nice overview of user stories, what they are, who should write them and how they fit into the iterative development process.

The desirable properties of a user story are given as *independent*, *negotiable*, *valuable to purchasers or users*, *estimate-able*, *small *and *testable*. These are described with reference to example user stories. Techniques to help create stories with desirable properties from stories with undesirable properties are also described.

Next, user role modelling is explored, describing what they are, why they are important and how they are derived. Suggestions for going beyond user roles are also made (such as personas and extreme characters).

Identifying user stories can sometimes be challenging and so number of methods for determining a users real requirements are introduced. A useful metaphor (trawling) is used to describe how requirements might be gathered in iterations, gathering the large or important requirements first while progressively refining these and gathering smaller or less important requirements. Mike shares an excellent quote from a user on a project he was involved in. The user told him "You built exactly what I asked for but it's not what I want." This is why it is important not just to trawl for user stories, but also to explore them.

Very often, access to users can be restricted for various reasons. In these cases, user proxies can stand in for users when gathering and developing user stories. Mike describes the appropriateness of different project roles acting as user proxies. An important distinction was also made between a customer and a user.

With user stories, acceptance tests define expected behaviour as defined by the customer, user and/or user proxy. These are defined as up front and/or as they emerge. Acceptance tests are then typically automated so they can be executed regularly to provide timely feedback. Acceptance testing (as with many practices in Agile) is a whole team responsibility.

When starting out with user stories (or any new practice), it is often a case of perseverance until you are comfortable with your new found skill. To aid you on your way, Mike provides some useful guidelines for writing good user stories. One of these guidelines uses the analogy of 'slicing a cake' to describe how to split user stories that are too large to deliver in a single iteration. The story should be split so as each resultant story is providing user value, as opposed to splitting the story along technical lines. This guideline stood out because it was something that my team had to address recently.

**Part 2 - Estimating and Planning**

Estimating is always a challenge and Scrum takes a completely different approach to estimating and planning. The use of Story Points and Velocity to estimate and plan is explained along with the process of estimating as a team.

Scrum development cycles are broken into releases and iterations. Release planning can be both front-to-back and back-to-front i.e. working forward with a specific velocity and set of stories or working backward with a specific velocity and release date. It is important when planning a release to understand the importance of prioritisation of stories. Some advice on selecting an iteration length and initial velocity is also provided.

During iteration planning, the customer has an opportunity to re-evaluate the priorities of the stories and the team have an opportunity to re-evaluate the estimates for each story. Once the stories for the next iteration are selected (based on velocity and story points), the stories are split into tasks. Each developer takes responsibility for a task until they are fully committed. Each developer can then estimate each task again. As a result the original estimate is refined giving a greater degree of certainty.

We depend upon 'Cumulative Story Point Charts' and 'Iteration Burndown Charts' to measure and monitor velocity and this then feeds back into the release planning process in the form of revised velocity. This type of activity is explained in further detail along with some discussion on the effect of adding stories and revising story estimates.

**Part 3 - Frequently Discussed Topics**

User stories are compared against IEEE 830 software requirements specifications, use cases and interaction design scenarios. The main differences highlighted are the level of detail and time at which estimates are provided. These differences, along with others, are discussed in detail.

The advantages of user stories are explained in detail and interestingly, a summary of why not to use user stories. Some books on new technology and methodology can tend toward hype and it was nice to see a section on reasons why not to use user stories. It certainly adds some balance to the material. The list of reasons why user stories should be used over other approaches adds clarity to their purpose, so much so that I will repeat them here:

- User stories emphasize verbal communication.
- User stories are comprehensible by everyone.
- User stories are the right size for planning.
- User stories work for iterative development.
- User stories encourage deferring detail.
- User stories support opportunistic design.
- User stories encourage participatory design.
- User stories build up tacit knowledge.

Code smells are indicators that your code is not what it should be and in a similar vain, Mike has provided a number of story smells. I find the 'smell' analogy very useful and it is a good start when adopting something new to have a number of 'things to watch out for'.

I am most familiar with using stories with Scrum. A good introduction is provided on using stories for the Product Backlog, in the Planning Meeting, in the Sprint Review Meeting and the Daily Scrum Meeting.

Some 'Additional Topics' are covered including how to deal with non-functional requirements, whether you should use story cards or software for managing stories, how user interface design occurs with using stories, using stories for bugs etc. Of these additional topics, the one that covers user interface design was the most interesting for me. I personally feel that user interface design is best done after the main stories have been discovered but before programming begins.

**Part 4 - An Example**

An example takes the reader through using user stories to develop a website for a sailing supplies company. It begins by identifying the customer and continues by identifying some initial user roles. These roles are then consolidated to remove those with significant overlap or those of little value. These roles are expanded upon to provide detail relevant to their interaction with the system.

Next, the example works through the initial trawl for user stories. These are trawled for by taking each role and identifying as many stories as possible for the particular role. Once the initial stories are identified, the customer (or Product Owner) is reminded that should more user stories surface, these can be considered for inclusion in future sprints.

These stories are then estimated and a description of the planning game is provided. Examples of stories that are split are provided but I would have liked to have seen a working example of resolving dependencies between stories.

Once the stories are identified and estimated, a release plan can be developed. First, the customer prioritises the stories in some way. The example uses a must have, should have, could have won't have approach to prioritising. I must say, I prefer a more fine grained approach that allows higher priority stories to be completed in the earliest iterations. Stories are then placed into iterations based on the prioritisation, velocity, iteration length and number of iterations. This provides us with the release plan.

The final step in the example involves the development of acceptance tests. The interesting part to this is that the acceptance tests themselves can influence the stories. For instance, stories can be redefined or split based on discussions about the acceptance tests.

**Thoughts**

As with Succeeding with Agile, User Stories Applied is well written and does a good job of conveying Mike's' experience of the subject matter.

Most of the material seemed familiar (perhaps because it just makes sense!) and definitely covers some of the challenges an Agile team will face when applying user stories.

The concept of a user story being a prompt for further discussion is quite a shift from the traditional approach of documenting all requirements that is still common (and sometimes necessary). It is quite a culture shift that may take a while to get used to but even if you have no previous experience with user stories, this book transfers some confidence that they can deliver a better way of working for your project.

Some of the 'story smells' also struck a chord, particularly 'Too Many Details' and 'Thinking Too Far Ahead'. It is very difficult to convince people who are used to traditional requirements gathering to give up their old ways. Some find it difficult, and some just don't want to.

With processes or methods that are not as scientific or mechanical, a worked example is a great idea. It is an opportunity to see the practices in action without diving in with both feet.

One negative I have for this book is that in the final few chapters the proof readers must of just skimmed and missed lots of errors (when I say lots, I mean around 10).
