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

*{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}*

If I want to view the second page of this data set and the page size is 3, I will expect the page to contain the following data:

*{4, 5, 6}*

Typically, we will also want to present the total number of results in the result set (i.e. 10) so that we can establish the total number of pages available (assuming a static result set). We will often present shortcuts to specific pages and a nextprevious page link.

Now if we imagine that we scale this example, it is generally more acceptable to retrieve this data from the data store in pages, rather than retrieving the entire data set and presenting it in pages. This approach is made more compelling as the consumption of the data moves further away from the data itself (as in n-tier architectures).

I present below one way that this functionality can be supported using Hibernate Named Queries. You can find the [source code on GitHub](https://github.com/monkeylittle/hibernate-pagination).

<!-- more -->

**Page Requests and Pages**

*Note: These concepts and implementation are largely based on the same from the [SpringData](http://www.springsource.org/spring-data) project.*

The first thing we need to do is establish what a page of data looks like and how we will request it.

A page request is quite basic and allows the client to specify:

- the page they want to retrieve
- the size of the pages they want to retrieve

<div class="card mb-3">
  <div class="card-header">
    PageRequest.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.model;

public interface PageRequest {

  int getPageNumber();
  int getPageSize();

}
{% endhighlight %}
  </div>
</div>

<div class="card mb-3">
  <div class="card-header">
    PageRequestImpl.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.model;

public class PageRequestImpl implements PageRequest {

  private int pageNumber;
  private int pageSize;

  public PageRequestImpl(int pageNumber, int pageSize) {

    if (pageNumber == 0) {
      throw new IllegalArgumentException("pageNumber must be greater than 0");
    }
    if (pageSize == 0) {
      throw new IllegalArgumentException("pageSize must be greater than 0");
    }

    this.pageNumber = pageNumber;
    this.pageSize = pageSize;
  }

  @Override
  public int getPageNumber() {
    return pageNumber;
  }

  @Override
  public int getPageSize() {
    return pageSize;
  }
}
{% endhighlight %}
  </div>
</div>

The page of data returns:

- page of data
- page number
- page size
- total number of elements in the result set

From this information, the total number of pages and number of elements on the current page can also be derived.

<div class="card mb-3">
  <div class="card-header">
    Page.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.model;

import java.util.Iterator;
import java.util.List;

public interface Page<Element> extends Iterable<Element> {

  List<Element> getContent();

  int getPageNumber();

  int getNumberOfElements();

  int getPageSize();

  long getTotalNumberOfElements();

  int getTotalPages();

  boolean hasNextPage();

  boolean hasPreviousPage();

  boolean isFirstPage();

  boolean isLastPage();

  @Override
  Iterator<Element> iterator();
}
{% endhighlight %}
  </div>
</div>

<div class="card mb-3">
  <div class="card-header">
    PageImpl.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.model;

import java.util.Iterator;
import java.util.List;

public class PageImpl<Entity> implements Page<Entity>, Iterable<Entity> {

  private List<Entity> content;

  private int pageNumber;

  private int pageSize;

  private long totalNumberOfElements;

  public PageImpl(List<Entity> content) {
    this.content = content;
  }

  public PageImpl(List<Entity> content, int pageNumber, int pageSize, long totalNumberOfElements) {
    this.content = content;
    this.pageNumber = pageNumber;
    this.pageSize = pageSize;
    this.totalNumberOfElements = totalNumberOfElements;
  }

  @Override
  public List<Entity> getContent() {
    return content;
  }

  @Override
  public int getPageNumber() {
    return pageNumber;
  }

  @Override
  public int getNumberOfElements() {
    return content.size();
  }

  @Override
  public int getPageSize() {
    return pageSize;
  }

  @Override
  public long getTotalNumberOfElements() {
    return totalNumberOfElements;
  }

  @Override
  public int getTotalPages() {
    if (getTotalNumberOfElements() == 0) {
      return 0;
    }
    if (getPageSize() == 0) {
      return 1;
    }

    int totalPages = (int) (getTotalNumberOfElements() / getPageSize());
    if (getTotalNumberOfElements() % getPageSize() > 0) {
      totalPages++;
    }

    return totalPages;
  }

  @Override
  public boolean hasNextPage() {
    return (getPageNumber() < getTotalPages());
  }

  @Override
  public boolean hasPreviousPage() {
    return (getPageNumber() > 1);
  }

  @Override
  public boolean isFirstPage() {
    return (getPageNumber() == 1);
  }

  @Override
  public boolean isLastPage() {
    return (getPageNumber() == getTotalPages());
  }

  @Override
  public Iterator<Entity> iterator() {
    return content.iterator();
  }
}
{% endhighlight %}
  </div>
</div>

As you can see, the PageRequest and Page objects do not contain any specific reference to persistence artefacts and can therefore be used in other areas of the application (the user interface for instance).

**Query Implementation**

I have previously presented a generic super class that provides persistence functionality by delegating to Springs JpaTemplate class. For this example, I have refactored this to use the Springs HibernateTemplate class and to support pagination.

<div class="card mb-3">
  <div class="card-header">
    PersistentEntityDaoImpl.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.dao.hibernate;

import java.lang.reflect.ParameterizedType;
import java.sql.SQLException;
import java.util.List;
import net.thoughtforge.dao.PersistentEntityDao;
import net.thoughtforge.model.Page;
import net.thoughtforge.model.PageImpl;
import net.thoughtforge.model.PageRequest;
import net.thoughtforge.model.PersistentEntity;
import org.hibernate.MappingException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;

public abstract class PersistentEntityDaoImpl<Entity extends PersistentEntity> implements PersistentEntityDao<Entity> {

  private Class<Entity> entityClass;

  private HibernateTemplate hibernateTemplate;

  @SuppressWarnings(value = "unchecked")
  public PersistentEntityDaoImpl(final HibernateTemplate hibernateTemplate) {
    this.hibernateTemplate = hibernateTemplate;
    ParameterizedType genericSuperclass = (ParameterizedType) getClass().getGenericSuperclass();
    this.entityClass = (Class<Entity>) genericSuperclass.getActualTypeArguments()[0];
  }

  public final Entity findByIndexId(final Integer indexId) {
    return (Entity) hibernateTemplate.get(entityClass, indexId);
  }

  @SuppressWarnings("unchecked")
  public final List<Entity> findByNamedQuery(final String queryName, final Object... params) {
    return (List<Entity>) hibernateTemplate.findByNamedQuery(queryName, params);
  }

  public final Page<Entity> findByNamedQuery(final PageRequest pageRequest, final String queryName, final Object ...params) {

    return hibernateTemplate.execute(new HibernateCallback<Page<Entity>>() {
      @SuppressWarnings("unchecked")
      @Override<
      public Page<Entity> doInHibernate(final Session session) throws SQLException {

        long totalNumberOfElements = getRowCount(session, queryName, params);
        Query query = getNamedQuery(session, queryName);
        setParameters(query, params);
        int firstResult = (pageRequest.getPageNumber() - 1) * pageRequest.getPageSize();
        int maxResults = pageRequest.getPageSize();
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResults);
        List<Entity> contents = query.list();

        return new PageImpl<Entity>(
            contents,
            pageRequest.getPageNumber(),
            pageRequest.getPageSize(),
            totalNumberOfElements);
      }
    });
  }

  public final Entity findUniqueByNamedQuery(final String queryName, final Object... params) {

    List<Entity> results = findByNamedQuery(queryName, params);
    if (results.isEmpty()) {
      return null;
    } else {
      return results.get(0);
    }
  }

  public final void refresh(final Entity persistentEntity) {
    hibernateTemplate.refresh(persistentEntity);
  }

  public final void remove(final Entity persistentEntity) {
    hibernateTemplate.delete(persistentEntity);
  }

  public final Entity save(final Entity persistentEntity) {
    if (persistentEntity.getId() == null) {
      hibernateTemplate.persist(persistentEntity);
      return persistentEntity;
    } else {
      return (Entity) hibernateTemplate.merge(persistentEntity);
    }
  }

  private Query getNamedQuery(final Session session, final String queryName) {
    try {
      return session.getNamedQuery(queryName);
    } catch (MappingException mappingException) {
      return null;
    }
  }

  private long getRowCount(final Session session, final String queryName, final Object... params) throws SQLException {
    String rowCountQueryName = queryName + ".count";
    Query rowCountQuery = getNamedQuery(session, rowCountQueryName);
    if (rowCountQuery == null) {
      rowCountQuery = getNamedQuery(session, queryName);
      setParameters(rowCountQuery, params);
      return rowCountQuery.list().size();
    } else {
      setParameters(rowCountQuery, params);
      return (Long) rowCountQuery.uniqueResult();
    }
  }

  private void setParameters(final Query query, final Object... params) {
    for (int index = 0; index < params.length; index++) {
      query.setParameter(index, params[index]);
    }
  }
}
{% endhighlight %}
  </div>
</div>

Since we need to determine both the total number of rows returned and the content of the requested page, we will need to execute two queries.

The first query determines the total number of rows in the result set. To obtain this, i need to either execute the query and count the number of entities returned or execute another query that returns the number of rows as a scalar result.

Executing the query and counting the number of entities returned has a disadvantage in that the entire result set is returned and processed (the purpose of pagination is to avoid just this). The additional query has a little overhead in that we have to define two queries as opposed to one. You can see this in the listing below for the User entity.

<div class="card mb-3">
  <div class="card-header">
    hibernate.cfg.xml
  </div>
  <div class="card-block">
{% highlight xml %}
<?xml version="1.0"?></p>
<!DOCTYPE hibernate-mapping PUBLIC "-//Hibernate/Hibernate Mapping DTD 3.0//EN" "http://hibernate.sourceforge.net/hibernate-mapping-3.0.dtd">

<hibernate-mapping default-access="field">
  <joined-subclass name="net.thoughtforge.model.User" extends="net.thoughtforge.model.UserTokenHolder" table="User">
    <key column="id" not-null="true"/>
    <property name="firstName" type="java.lang.String" access="field" column="firstName"/>
    <property name="lastName" type="java.lang.String" access="field" column="lastName"/>
    <property name="password" type="java.lang.String" access="field" column="password"/>
    <set name="userGroups" inverse="false" lazy="true" table="User_UserGroup_userGroups" fetch="select">
      <key column="userTokenHolderIndexId" not-null="true"/>
      <many-to-many entity-name="net.thoughtforge.model.UserGroup">
        <column name="userTokenIndexId" not-null="true"/>
      </many-to-many>
    </set>
    <property name="username" type="java.lang.String" access="field" column="username"/>
  </joined-subclass>
  <query name="user.findByLastName">
    from User
    where lastName like ?
  </query>
  <query name="user.findByLastName.count">
    select count(*)
    from User
    where lastName like ?
  </query>
  <query name="user.findByUsername">
    from User
    where username = ?
  </query>
</hibernate-mapping>
{% endhighlight %}
  </div>
</div>

The DAO looks for a named query of the same name, with a '*.count*' postfix. If it is present, it is executed to return the query count.

You can also see that pagination is applied by setting the first result and the maximum number of results returned.

**Issues with this Approach**

There are three main problems with this approach. The first is that it requires the execution of two queries. The second problem is that the result set could change during the process of pagination. Finally, depending on the underlying database, the order of the result set returned my not be consistent.

Depending on your specific circumstances, these issues may or may not impact your solution. I'd love to hear about your approach to providing this type of pagination support.
