---
layout: post

title: 'SpringOne 2GX Keynote: Next Generation Applications'
author: john_turner
featured: false

categories:
- Spring Framework
---

I found the recent [Next Generation Applications](http://www.infoq.com/presentations/SpringOne-2GX-Keynote-Next-Generation-Applications) session at SpringOne 2011 covered a lot of ground and provided a solid view on where application architecture and design is headed in the not too distant future.

The session was introduced by Ben Alex who discussed 4 key computing trends:

- Diversification of user devices.
- Increase of internet bandwidth and stagnation in network latency.
- Reducing cost of data storage.
- Reduction in clock speed and increase in number of processor cores.

These trends are having a significant impact on how we are developing applications today and will increase in relevance into the future. This paved the way for a number of discussions on how to exploit these trends to deliver tomorrows applications.

**Next Generation Clients**

Because of the increasing diversification of user devices developers must find a way to bring the 'Write Once, Run Anywhere' philosophy to the client. Spring Source are working on delivering this promise by supporting development using Html 5 and JavaScript while using bridging frameworks such as Phone Gap to ensure these applications have access to native features and are available through existing app stores.

Keith Donald demonstrated a reference architecture (expense application) built using Html 5, CSS, JavaScript and Phone Gap on the client. Authorisation utilised OAuth while services were exposed using a RESTful API. He also did a demo of pushing application updates. Compelling stuff!

**Next Generation Authorisation**

Craig Walls and Roy Clarkson then presented on authentication which focused on the utilisation of OAuth and Spring Security. Interesting in the context of access control for RESTful services but fairly typical application of OAuth to provide SSO.

**Next Generation Data**

Html 5 application caching was touched upon and a demo of the previous expense application was performed using a disconnected device. Big Data was then discussed and placed in the context of the Spring Data project and its sub-modules. I've not looked at Spring Data in any great depth but really liked some approaches adopted by the Spring JPA sub-module (which was not covered in this session).

**Next Generation Architecture**

Finally, Tim Fox closed by discussing the adoption of asynchronous application architectures to deliver the massive scale that today's applications are expected to achieve.

**Thoughts**

It was a really enjoyable session that was interesting and informative. A broad range of topics were covered by presenters who are clearly very knowledgeable.

I think overall, a really compelling vision of how developers will meet the challenge of delivering tomorrows applications was provided.
