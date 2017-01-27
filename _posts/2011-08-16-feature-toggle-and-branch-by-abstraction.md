---
layout: post

title: Feature Toggle and Branch by Abstraction
author: john_turner
featured: false

categories:
- Ramblings
---

Over the past couple of days, I have spent quite a bit of time reading around code branching strategies and the consequences of choosing one strategy over another. I found that [Advanced SCM Branching Strategies](http://www.vance.com/steve/perforce/Branching_Strategies.html) by Stephen Vance gives a good overview of the practice and some of the considerations to be made when choosing a branching strategy.

Or course more recently, and perhaps as a consequence of SCM tools becoming more adept at textual merging, feature branching has risen to prominence. As he is inclined to do, [Martin Fowler](http://martinfowler.com) articulately expresses his views on why [feature branching](http://martinfowler.com/bliki/FeatureBranch.html) should be avoided when possible and the inherent conflict between feature branching and continuous integration. I must say that I find it hard to disagree with his reasoning (see also a short [Q & A with Jez Humble](http://www.thoughtworks.com/perspectives/30-06-2011-continuous-delivery)

So what alternative does he propose? Martin suggests applying [Feature Toggle](http://martinfowler.com/bliki/FeatureToggle.html) and [Branch by Abstraction](http://continuousdelivery.com/2011/05/make-large-scale-changes-incrementally-with-branch-by-abstraction/). I'll leave it to you to read the background, but the removal of branching and merging from a teams development activity is certainly a big carrot.
