---
layout: post

title: Creating a Method Result Caching Aspect with Spring AOP and AspectJ
author: john_turner
featured: false

categories:
- Spring Framework
---

People have been using method result caching for quite a while and there is an excellent Google Code project called [ehcache-spring-annotations](http://code.google.com/p/ehcache-spring-annotations) that provides this functionality using [EhCache](http://ehcache.org/) and [Spring](http://www.springsource.org/). I have played with this functionality previously but never really had any need to utilise it in any meaningful way.

However, I recently had a requirement to provide result caching for remote method calls. The nature of the requirement mandated that the following functionality be available:

- The cache provider should be interchangeable;
- The cache key generation should be flexible and extensible;
- The cache directive should be able to specify the cache and cache key generator.
- The cache removal directive should be able to specify the cache and cache key generator.

For a couple of reasons, I did not reuse the Google Code project:

- The cache provider is not interchangeable (it must be EhCache);
- The cache and cache removal directives (@Cacheable, @TriggersRemove) are annotation based (I needed to specify different cache directives for different bean definitions of the same class);
- The cache provider, cache directives and key generators are not Spring Beans so cannot use Dependency Injection.

<!-- more -->

To implement a method result cache with the required features I needed to implement the *Cache Provider*, *Cache Key* and *Cache Key Generator*, *Cache* and *Cache Removal* Directives and the *Method Result Caching Aspect*.

**Cache Provider Implementation**

The cache provider is very basic and I note that a more sophisticated implementation is in the pipeline for the Google Code project. If only they had finished JSR 107 none of this would be necessary but alas JSR 107 appears to have been left to float in limbo!!

{% gist 97078eff74adc94ceebe5e8b6945d2d5 %}

I only really have an immediate need for an EhCache implementation of the cache provider. I would see the need in the near future to develop a cache provider implementation that uses a Http Session as the actual cache and this was the main reason for this abstraction.

{% gist d6fc0e8cce4abebe1c754396fe674dc5 %}

The EhCacheProvider uses dependency injection to inject the actual cache implementation. This should provide lots of flexibility in the future as a dependency injection container (Spring in this instance) can be used to build the cache provider implementation.

**Cache Key and Cache Key Generator**

I decided that the cache key itself would be a marker interface with two concrete implementations. Much like the Google Code project, I implemented a string key and a digest key.

{% gist e04d323476b98dca13a71a63ac2b2387 %}

{% gist fdfab90db80213ec26a4840e8d0aa84e %}

{% gist bbf547f9ca6af035fe5c1528450ceeb0 %}

In order to generate a cache key, a key generator is required. Again, I decided that the key generator would be a marker interface so different caching aspects could utilise key generators in different ways. The main way one caching aspect might utilise the key generator differently from another would be in the information the aspect passes to the key generator.

{% gist df3f3ff9ff14a428bde839b247926bae %}

For the method result caching aspect, the key generator would require the actual method signature and parameters to facilitate the generation of the cache key. For this purpose, I implemented a method signature key generator.

{% gist 22dab5d5b6a6b32f47d5f4c7fda0edbe %}

An abstract implementation of the method signature key generator delegates the creation of the key value to a strategy implementation to be provided by the client of the framework.

{% gist 45b32178ed20f5b888671c5e6f43bb9d %}

{% gist 0b71455dfaad544c0d4bbe9ce805f120 %}

For each concrete implementation of the cache key, I implemented a corresponding implementation of the method signature key generator.

{% gist c5bf5b9123c25458d285d7c57961113a %}

{% gist eb0ff758fda501626de61521bfa53b47 %}

Finally I provided a utility class, *KeyValueBuilder*, to be used by the key value strategy for concatenating properties of a method signature when building the key.

{% gist fc8517cf9648f7961c676bb11172bc6b %}

tation is complete and all that is remaining is the definition of cache cache removal directives and the caching aspect.

**Cache and Cache Removal Directives**

The cache and cache removal directives are simple value objects. They merely hold the values of the cache provider and cache key generator.

It's worth pointing out that the cache removal is triggered on the invocation of the method for which it is confiigured. The underlying cache implemetation will also have cache invalidation policies (e.g. EhCache timeToLiveSeconds or HttpSession session-timeout).

{% gist 5660ac61a0923327e39c09c90f5f6f7f %}

{% gist 4a4f08a09e8640ffe2debbc2e4569184 %}

{% gist ffb99c37288bc5861e9ef711ac6eef9a %}

{% gist 895b28338e3f9db450a3f688effc9690 %}


**Method Result Caching Aspect**

Finally, the caching aspect orchestrates the invocation of the target method, caching of the method result and cache removals. This specific aspect will leverage the *MethodSignatureKeyGenerator* but the design is flexible enough that the aspect (or other means of orchestration) can use other key generators depending on the requirements for the key value.

{% gist c7bce6de784e8d069418d356e6bf9c5e %}

The code speaks for itself (at least that is the intention) and it has proved to be extremely flexible in how we can apply it to solve our caching requirements.

I used maven as the build manager and you can download the [Method Result Caching Aspect with Spring AOP](http://thoughtforge.net/wp-content/uploads/2010/12/spring-caching-aspect.zip) project. You are welcome to download, hack and redistribute as you see fit. The project also contains a validation test that demonstrates the configuration of the aspect, cache provider and cache directives.
