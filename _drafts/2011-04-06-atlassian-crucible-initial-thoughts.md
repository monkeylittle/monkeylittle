---
layout: post

title: Atlassian Crucible - Initial Thoughts
author: john_turner
featured: false

categories:
- Ramblings
---

Manual code reviewing can be a painful exercise. Typically it involves a developer identifying the files they have modified as part of a feature development or bug fix and then a number of people reviewing the changes in a round table review. Following this there is normally a number of iterations until all the points raised in the review have been addressed.

So, where are the challenges in this approach?

Identifying the files modified as part of a feature development can sometimes be a challenge and because of the dependency on the developer (a human) it is often prone to error (especially if the review occurs after a period of time).

Getting the right people in a room at the same time is the second challenge and often it is this that is the main hurdle to having an effective process for code reviewing. This limits us to reviewers in a single location unless we are using review templates, email, wiki etc. which are all less than ideal.

Finally, the intrusive nature of iterating over points raised in the review results in a process that tends to be treated with mild neglect at best, and at worst complete disdain.

These are the type of issues that [Atlassian](http://www.atlassian.com/) are looking to address with [Crucible](http://www.atlassian.com/software/crucible/), a web based application for creating and performing code reviews.

To learn a little more, I have downloaded an evaluation copy and installed it. Pretty straight forward stuff. The download includes a standalone package that executes a web application within an embedded server.

Next, I created a repository, pointing at our SVN repository using the built in repository client. Crucible spends a bit of time creating change sets and indexing the repository and after that I was able to view the all activity on the repository.

From each repository commit, I can create a review and assign reviewers. This helps out with the developer having to identify the change set. The reviewers and the developer can then raise points and iterate (via the web application) over the points raised. Nobody needs to be in the same room at the same time...excellent.

I'm going to spend a bit more time playing around with Crucible to see if it could be truly useful. I want to play around with resource watches and I am looking for a feature that allows me to create developer profiles that trigger reviews based on the experience level of the developer, sensitivity of the source code region or branch etc.

It's been interesting so far. If you have experience with a similar tool, I'd be interested in hearing about it.
