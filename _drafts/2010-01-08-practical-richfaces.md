---
layout: post

title: Practical RichFaces
author: john_turner
featured: false

categories:
- Book Review
- Rich Faces
---

<img class="alignright" src="/assets/images/posts/practical-richfaces/practical-richfaces.jpg"/>

As I had mentioned in a previous post, I recently invested in a couple of books on JBoss RichFaces. Having read and reviewed [JBoss Rich Faces 3.3]({% post_url 2009-12-16-jboss-rich-faces-3-3 %}) I set about doing the same for the other book, Practical RichFaces.

The book started out giving the same background information on JSF, RichFaces and Ajax4Jsf but in contrast to JBoss RichFaces 3.3 stated that it will not be using JBoss Seam in the example's which I was happy about. That is of course not a reflection on JBoss Seam but more my desire to read about RichFaces and not the many technologies that might complement it.

In the second chapter, the book suggests installing JBoss Tools and as I have not used this Eclipse plug-in before I decided I would do just that. It then proceeds to work through a small example to verify the EclipseJBoss Tools installation. This is done in some detail and would be quite useful if looking at RichFaces for the first time.

Some time is then spent introducing the main RichFaces components that support Ajax functionality, namely <a4j:comandLink>, <a4j:commandButton>, <a4j:support> and <a4j:poll>. These concepts were covered clearly and concisely with good use of appropriate examples. The remaining a4j components are covered in the chapter that follows.

<!-- more -->

Having covered the a4j components the book then proceeds to cover the majority of rich components dividing the coverage into input components, output components, data iteration components, selection components and menu components. The coverage of the input components is brief which is to be expected as it would be difficult to add anything to the JBoss RichFaces reference documentation. The coverage of the output components is a little more in-depth than the reference documentation and demonstrates, by example, some nice tips and tricks. The data iteration components, selection components and menu components are covered in roughly the same level of detail as that provided by the reference documentation.

The Scrollable Data Table and Tree are given a chapter of their own which covers the main functionality and usage of these components. As with [JBoss Rich Faces 3.3]({% post_url 2009-12-16-jboss-rich-faces-3-3 %}) I was disappointed with the level of coverage the Tree component received. This is one of the more complicated components and I would like to have seen more examples of its usage.

The last chapter on skinning is on a par with [JBoss Rich Faces 3.3]({% post_url 2009-12-16-jboss-rich-faces-3-3 %}) and covers the subject well.

My overall impression was again that I'm not really sure that this book adds anything to the freely available reference documentation but the tutorial style is certainly easier to read. I would recommend this book for someone starting out with RichFaces or for someone wanting to read a book end-to-end to get up to speed quickly. What is really needed for RichFaces is a RichFaces Recipe's Book which is packed full of real world examples of using rich faces beyond the simple examples available on the RichFaces demo website.

One last comment that I would make on the book is that it got me wondering about the level of proof reading of these books. There are a number of glaring errors that would have been noticed if reviewed by anyone with RichFaces knowledge who reads this book. I think these types of mistakes should not make their way to print.
