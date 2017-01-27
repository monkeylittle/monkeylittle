---
layout: post

title: Code Comments
author: john_turner
featured: false

categories:
- Ramblings
---

I remember when I started commercial coding in early 1999.  The developers that I worked with would constantly remind me of the value of commenting code.  The main reason they would give was that it reduces the cost of maintenance by making it easier to return to the code at a later date.

Now, I wanted to write code and not comments so this did not come naturally but on my best days I would diligently comment every class/method declaration and adorn non-trivial methods with a liberal spattering of the same.  After a while I noticed the amount of noise produced by comments that added no value or that were no longer relevant was a considerable distraction.  In fact, this distraction was increasing the maintenance cost rather than reducing it as I had previously been told.

Since then much has changed and the publication of books such as [The Pragmatic Programmer]({% post_url 2010-06-29-the-pragmatic-programmer %}), Clean Code and The Clean Coder has changed the perceived wisdom surrounding the commenting of code.  The authors of these books suggested that better code maintainability will come from writing better code (who would have thought!).  By better code they meant code that is easier to understand but how do we write code that is easier to understand.  A good start is to:

- Use descriptive class and method names.
- Do Not Repeat Yourself
- Write [SOLID](http://en.wikipedia.org/wiki/Solid_%28object-oriented_design%29) code.

Given the way in which modern logging frameworks work, using descriptive class and method names also increases the value of your application logs.

Bob Martin said that 'The proper use of comments is to compensate for our failure to express yourself in code. Note that I used the word failure. I meant it. Comments are always failures.''.  I'm a little more open to comments and still see the value in class and public method comments (please, no bean accessor and mutator commenting!) but regardless of each individuals personal preferences for comments its is good that people are thinking about the subject and doing what makes most sense for them rather than blindly commenting everything.
