---
layout: post

title: Paging Hibernate Query Results
author: john_turner
featured: false

categories:
- Hibernate
---

When developing applications that provide create, read, update and delete (CRUD) functionality, it is often a requirement to search on and present large data sets. This requirement is usually fulfilled by providing the ability to page through the result set, presenting a single page at a time.

For example, consider a very simple data set containing 10 integers.

{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

If I want to view the second page of this data set and the page size is 3, I will expect the page to contain the following data:

{4, 5, 6}

Typically, we will also want to present the total number of results in the result set (i.e. 10) so that we can establish the total number of pages available (assuming a static result set). We will often present shortcuts to specific pages and a nextprevious page link.

Now if we imagine that we scale this example, it is generally more acceptable to retrieve this data from the data store in pages, rather than retrieving the entire data set and presenting it in pages. This approach is made more compelling as the consumption of the data moves further away from the data itself (as in n-tier architectures).

I present below one way that this functionality can be supported using Hibernate Named Queries. You can download the complete <a href="http://thoughtforge.net/wp-content/uploads/2011/07/hibernate-pagination.zip">source code here</a>.

<!-- more -->

**Page Requests and Pages**

*Note: These concepts and implementation are largely based on the same from the [SpringData](http://www.springsource.org/spring-data) project.*

The first thing we need to do is establish what a page of data looks like and how we will request it.

A page request is quite basic and allows the client to specify:

- the page they want to retrieve
- the size of the pages they want to retrieve

{% gist 82d7b849353ba904036594ee1fa263bf %}

{% gist f33fde180fb560cf611f94bb71a6d1c2 %}

The page of data returns:

- page of data
- page number
- page size
- total number of elements in the result set

From this information, the total number of pages and number of elements on the current page can also be derived.

{% gist 994c3f4f65011dce1e394a7b762af6cd %}

{% gist 2fa9061cfa1f637ea1a7e6b9e312dc05 %}

As you can see, the PageRequest and Page objects do not contain any specific reference to persistence artefacts and can therefore be used in other areas of the application (the user interface for instance).

**Query Implementation**

I have previously presented a generic super class that provides persistence functionality by delegating to Springs JpaTemplate class. For this example, I have refactored this to use the Springs HibernateTemplate class and to support pagination.

{% gist 7867353583ac4aa9071ae430d92828b5 %}

Since we need to determine both the total number of rows returned and the content of the requested page, we will need to execute two queries.

The first query determines the total number of rows in the result set. To obtain this, i need to either execute the query and count the number of entities returned or execute another query that returns the number of rows as a scalar result.

Executing the query and counting the number of entities returned has a disadvantage in that the entire result set is returned and processed (the purpose of pagination is to avoid just this). The additional query has a little overhead in that we have to define two queries as opposed to one. You can see this in the listing below for the User entity.

{% gist e39fa1c969ed3a5330a2155e3cd5bc77 %}

The DAO looks for a named query of the same name, with a '*.count*' postfix. If it is present, it is executed to return the query count.

You can also see that pagination is applied by setting the first result and the maximum number of results returned.

**Issues with this Approach**

There are three main problems with this approach. The first is that it requires the execution of two queries. The second problem is that the result set could change during the process of pagination. Finally, depending on the underlying database, the order of the result set returned my not be consistent.

Depending on your specific circumstances, these issues may or may not impact your solution. I'd love to hear about your approach to providing this type of pagination support.
