---
layout: post

title: 'SpringOne 2GX: Getting Started With Spring Security 3.1'
author: john_turner
featured: false

categories:
- Spring Security
---

I've used Spring Security often.  Sometimes to provide what would be considered relatively straight forward authentication and authorisation and on other occasions to provide  multi-step authentication (using pre-authentication) and complex authorisation.  In the [Getting Started With Spring Security 3.1](http://www.infoq.com/presentations/Spring-Security-3-1) session at [SpringOne 2GX 2011](http://www.springone2gx.com/) Rob Winch introduced Spring Security and the new features of Spring Security 3.1.

He starts his presentation with a high level overview of the Spring Security framework and the variety of support it provides.  For those who have not used Spring Security this was quite informative and for those who are familiar with the framework it was a useful recap.  Spring Security is organised into the core framework and a number of extensions that provide support for OAuth, SAML, Kerberos etc.  This was mentioned by way of an overview and not delved into in any depth.

Havig used Spring Security before, I was particularily interested in what is new in version 3.1.  The two additions that I was particularily happy to see were:

- namespace support for multiple http elements
- a stateless authentication mode for RESTful services.

Unfortunately Rob did not delve into the stateless authentication mode.

Much of the session focused on a demo web application (Secure Mail) and how to leverage Spring Security to implement authentication and authorisation.  This was a through walk through the demo application that covered everything from the initial configuration of spring security to session management, user registration and proxy based authorisation.

In particular, I found the section on proxy based authorisation was well presented.  The difference between interface based proxies and class based proxies was explained along with the pro's and con's for both.  I also found the tips on preventing Spring Security from permeating into the application source code useful.  I hate seeing dependencies on framework code proliferate application code.

Rob was an informative and engaging presenter and this session is definitely worth watching if you find yourself with a free hour and a half.
