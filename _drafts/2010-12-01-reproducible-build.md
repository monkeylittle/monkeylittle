---
layout: post

title: Reproducible Build
author: john_turner
featured: false

categories:
- Continuous Integration
---

Martin Fowler recently [wrote about the value of a reproducible build](http://martinfowler.com/bliki/ReproducibleBuild.html). I agree absolutely with the points Martin makes and also that fans of continuous integration often assume a build to be reproducible.

In the early phases of an Agile process when there is a significant amount of foundational activity that has yet to be completed, release procedures are often neglected over building the momentum of the development team and feature delivery. Of course, we have our Continuous Integration environment from the word go but there is a bit more than that to creating a reproducible build.

For a start we need to make a specific build identifiable (you can't reproduce what you can't identify!). Sometimes it is sufficient to add versioning to the build artefacts but often it is necessary to make the build identifiable to the end user. The easiest way to do this is through adding a version tag to the UI.

Versioning assumes some sort of release procedure that is typically automated. John Ferguson Smart talks in detail about this in his excellent presentation titled [Automated Deployment with Maven and Friends](http://www.slideshare.net/wakaleo/automated-deployment-with-maven-going-the-whole-nine-yards).

But at what point does it become important that a build is reproducible?

In the early stages of an Agile project, features are normally developed, tested, deployed and perhaps presented (at a show and tell) by the team and for the team (or extended team). It's probably safe to assume that only a single branch of development exists and with such a limited audience (who are probably intimately involved in the project) it is possible to get away with limited versioning of releases. I always take a JIT (Just In Time) approach to establishing procedures, practices etc. as establishing all the procedures and practices that a project requires up front often has a negative effect on momentum.

Of course, as the project gains momentum and a couple of iterations have been completed, a layered approach to testing and quality assurance is usually applied and at this point identifying and reproducing specific builds becomes important.
