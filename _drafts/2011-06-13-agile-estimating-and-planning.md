---
layout: post

title: Agile Estimating and Planning
author: john_turner
featured: false

categories:
- Book Review
- Agile
---

<img class="alignright" src="/assets/images/posts/agile-estimating-and-planning/book-cover.jpg"/>

Estimating and planning are inherently difficult and the mechanisms that Agile apply to these efforts differ significantly in approach and execution. In this book, Mike describes what makes planning so difficult and how an alternative approach can help alleviate the issues that arise with traditional approaches.

Again the quotes that Mike has scattered throughout the book capture the essence of the subject matter and so I have replicated them throughout this review.

**Part I - The Problem and the Goal**

The first couple of chapters establish why estimating and planning are difficult but also why they are essential. The primary goals of estimating are defined as reducing risk, reducing uncertainty, supporting decision making and establishing trust. The purpose of planning is defined as "*finding the optimal answer to the overall product development question of what to build*". Interestingly, a good plan is defined as one that "*is sufficiently reliable*" which fits well with Agile generally and the principle that the level of planning, estimating, analysis etc. should be 'just enough' or 'barely sufficient'.

So what are the reasons that traditional planning fails? Traditional planning focuses on activities as opposed to features which distracts from what we must deliver..customer value! Activities tend to be intricately linked and as a result, lateness is often passed to dependent activities yet the possibility of early execution of an activity requires all prerequisite activities to complete early. A number of additional reasons are discussed yet the one that resonates most with me is that "*Estimates Become Commitments*".

An Agile approach attempts to minimise or remove the problems associated with traditional planning. This is achieved because Agile teams work together in short iterations delivering business value within each iteration. The pragmatists among us appreciate most the "inspect and adapt" philosophy of Agile and the Retrospective practice. Personally, facilitating the Retrospective is not something I find easy but I found a greater understanding and some useful guidelines in Agile Retrospectives (I will post a review soon!).

**Quotes**

> Field Marshal Helmuth Graf von Moltke, "Planning is everything. Plans are nothing."

> Field Marshal Helmuth Graf von Moltke, "No plan survives contact with the enemy."

> General George S. Paton, "A good plan violently executed now is better than a perfect plan executed next week."

<!-- more -->

**Part II - Estimating Size**

Traditional estimation techniques focus on estimating the duration of activities which are based on assumptions about resources etc. Agile estimation separates the estimation of features into estimates of size, then duration.

Story Points can be used as an relative measure of the size of a user story or feature. The way in which Story Points are assigned and subsequently the concept of Velocity and how it is applied to determine duration is described in detail. These concepts are very familiar to me but I enjoyed the explanation provided in he book. It is always useful to have another way to describe concepts that some can find difficult to grasp.

Ideal Days can be used as another measure of size and as a concept it is easier to grasp than that of Story Points. But because of the misunderstanding (sometimes intentional) that people sometimes have when estimating and planning in Ideal Days, I'm reluctant to adopt them as a measure of size.

Planning Poker is one of the practices of Scrum that focus on estimation. It involves using an estimation scale (sometimes the numbers of the Fibonacci sequence) to assign estimates of size to user stories or features. This is typically a whole team effort that involves discussion of the user story and how it might be delivered. Discussion can be time boxed so that the team focuses on relevant detail.

Given estimates of size can be provided in Story Points or Ideal Days, the book provides a useful comparison between the two measures.

**Quotes**

> General George S. Patton, "If you tell people where to go but not how to get there, you'll be amazed at the results"

**Part III - Planning for Value**

One of the premises of Agile is that it focuses on delivering business value. One of the ways it achieves this is by ensuring that the team is working on the high value features. This does not happen by chance and because features have a different value depending on your perspective.

The four main factors to be considered when prioritising are defined as the financial value of having the features, the cost of developing the features, the amount and significance of learning created by developing the features, and the amount of risk removed by developing the features. Features themselves are often dependent on other features to form a cohesive feature set for a product. For this reason it usually makes more sense to prioritise themes.

Prioritisation may also focus on financial reward. Prioritising based on financial reward requires consideration of potential cost, income, operational efficiencies etc. so is often quite involved.

Prioritising desirability is explained using the Kano model of customer satisfaction. This requires that features are categorised as "must have", "linear" or "exciter and delighter" features. I find this a simple yet effective way of prioritising. It is explained well and the case study at the end highlights its usefulness.

When user stories contain functionality with different priorities, it is often useful to split the user story so that the option exists to deliver the higher priority functionality without the lower priority functionality.

**Quotes**

> Ben Stein, "The indispensable first step to getting what you want is this: Decide what you want."

**Part IV - Scheduling**

At a high level, we want to know what we are going to deliver and when. Often we can only be sure about the "what" or the "when". The section on scheduling begins by discussing the Agile approach release planning. Fundamentally, this involves establishing what is required to make the release a success (conditions of satisfaction), estimating the user stories and velocity, and prioritising stories.

An approach to iteration planning is described which involves using either velocity or commitment to bound the number of stories and tasks a team undertakes in an iteration. Topics such as splitting stories into tasks and dealing with bugs are also covered.

Iteration length for Agile teams is a topic that is discussed frequently on forums etc. and is obviously something that a team tries to establish and maintain. A chapter covers how to select an iteration length, the trade-off's that influence the decision to use shorter or longer iterations and the reasoning behind maintaining a static iteration length. Two case studies add further clarity to the material.

There are three established ways to estimate velocity and I have used all three at some time or another. These are to use historical values, run and iteration or to make a forecast. Often, when starting out you will need to first forecast velocity, then run a number of iterations and then you can use historical values. Each of these approaches are described.

I'm not really a fan of "buffering" plans because I naively think that the uncertainty should be accepted as part of the nature of software development and that if it is re-examined regularly stakeholders should be well positioned. But since many people don't agree it is often necessary. Feature buffering and schedule buffering are discussed along with mechanisms to size buffers appropriately.

Because Agile teams tend to be small (perhaps 8-10 people) there is often a requirement for multiple teams to be involved in the delivery of a single (or family) of products. Planning projects with multiple teams requires additional techniques to those required with single (or independent) product teams. These techniques include baselines for estimates, lookahead planning and adding more detail to user stories earlier that would be the case with single product teams.

**Quotes**

> Clint Eastwood, "You improvise. You adapt. You overcome."

> John Maynard Keynes, "It is better to be roughly right than precisely wrong."

**Part V - Tracking and Communication**

Monitoring the release plan typically involves using some form of release burn-down chart. Personally I prefer the burn-up chart and this appears to be an opinion echoed quite frequently. A number of alternative charts are also described as a way to monitor the release plan.

Most people who practice Scrum are well versed in using task boards and burn-down charts to monitoring the iteration plan. This is described briefly but for most it will be something to skim over.

During an iteration, there is a significant amount of information passing within and between teams. This information can be captured on a wiki (or other forum) and used to communicate or record for audit progress relative to the plans. This becomes a useful way of increasing transparency and informing others how Agile is being applied to deliver the product. This chapter presented some good ideas that I will try to apply to my current project.

**Part VI - Why Agile Planning Works**

A brief summary is provided explaining why Agile planning works. I particularly like the 12 guidelines for Agile estimating and planning.

**Part VII - Case Study**

A good case study always helps but information into context and this book wraps up by providing a good case study. It reminded me of the Kate Oneal series that Ron Jefferies posts on his website.

**Thoughts**

I have been Scrum Master on an Agile project that has been delivering working software, every two weeks, for 9 months. As such, I have been responsible for the approach we have taken toward estimating and planning. Many of the practices we applied when release or sprint planning were taken directly from this book and overall, I have been pleased with the results.
