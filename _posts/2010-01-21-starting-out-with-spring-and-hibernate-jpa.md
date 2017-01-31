---
layout: post

title: Starting out with Spring and Hibernate JPA
author: john_turner
featured: false

categories:
- Spring Framework
- Object Relational Mapping
---

More often than not, I am brought onto a project after the project initiation phase has been completed. By this stage major decisions regarding the development environment and code organisation have already been made. It would be fairly common that I would refactor and re-organise some of the code and in particular the Hibernate JPA code.

In this post I am going to outline how I prefer to implement and organise the Hibernate JPA code on projects I am involved with (where that option exists). I will also demonstrate how I implement the persistent entity classes, data access objects, associated configuration and unit tests. A fairly typical project would utilise Maven, Spring and Hibernate JPA.

**Creating the Maven Project**

My preferred project structure consists of a root project containing a model module and persistence module with the persistence module having a dependency on the model module. While this would seem pretty straight forward, one now has to decide if one is going to use annotations or XML configuration for the ORM mapping. The reason I prefer to make this decision now is that it affects the dependencies of the model module.

There are arguments for and against using annotations or XML for ORM (any XRM really) but if no precedent has been set I normally try to avoid using annotations in model classes. This way model classes are very clean and the model module does not have any dependencies on javax.persistence. I was involved in a project using JPA and JAXB annotations in model classes and they became difficult to work with very quickly.

The persistence module really does encapsulate all the information relating to the persistence mechanism with the exception of (some) transactional characteristics which would ordinarily be defined in service classes within a service module. Of course the price you pay for this is having some quite large XML files.

<!-- more -->

**Creating the Persistent Entity Classes**

For this example, I am going to use a fairly typical security domain model. A UserToken represents an authorisation token that can be associated to a User or a UserGroup. A UserGroup is a hierarchical data structure and so can be associated with one parent and/or many child UserGroup's. A UserGroup can be associated with many Users and a User can be associated with many UserGroup's. A UserGroup inherits UserToken's from child UserGroup's and a User inherits UserTokens from associated UserGroup's.

The entity classes are added to the model module. I am not going to post code listings for the persistent entity classes as you can find the [source code on GitHub](https://github.com/monkeylittle/spring-hibernate-jpa).

It is worth highlighting though that all model classes extend a common super class (PersistentEntity) that typically defines identifier and version properties. Depending on the requirements, it may also define properties such as dateCreated, dateLastUpdated, tenancy (for multi-tenanted domains) etc.

**Creating the JPA Mapping Configuration**

For the sake of clarity, I generally separate the JPA mapping configuration into persistence.xml and persistence-mapping.xml (and persistence-query.xml which we will discuss later) files. I try to use the same persistence.xml configuration in all environments so I move anything that varies into the Spring configuration. This includes the definition of the data source, dialect etc.

<div class="card mb-3">
  <div class="card-header">
    persistence.xml
  </div>
  <div class="card-block">
{% highlight xml %}
<?xml version="1.0" encoding="UTF-8">
<persistence version="1.0"
    xmlns="http://java.sun.com/xml/ns/persistence"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://java.sun.com/xml/ns/persistence
      http://java.sun.com/xml/ns/persistence/persistence_1_0.xsd">

  <persistence-unit name="thoughtforge" transaction-type="RESOURCE_LOCAL">
    <mapping-file>META-INF/persistence-mapping.xml</mapping-file>
    <mapping-file>META-INF/persistence-query.xml</mapping-file>

    <class>net.thoughtforge.model.User</class>
    <class>net.thoughtforge.model.UserGroup</class>
    <class>net.thoughtforge.model.UserToken</class>
    <class>net.thoughtforge.model.UserTokenHolder</class>
    <class>net.thoughtforge.model.PersistentEntity</class>
    <properties>
      <property name="cache.provider_class" value="org.hibernate.cache.NoCacheProvider"/>
      <property name="hibernate.max_fetch_depth" value="3"/>
      <property name="hibernate.query.factory_class" value="org.hibernate.hql.classic.ClassicQueryTranslatorFactory"/>
      <property name="hibernate.query.substitutions" value="true 1, false 0"/>
      <property name="hibernate.show_sql" value="true"/>
      <property name="hibernate.hbm2ddl.auto" value="create"/>
    </properties>
  </persistence-unit>
</persistence>
{% endhighlight %}
  </div>
</div>

The option exists to further seperate the persistence-mapping.xml file into a file for each class as is normal practice for hibernate .hbm files.

As you can see from the applicationContext-persistence.xml file below, the 'jpaProperties' property of the entityManagerFactory bean contains all the connection information. If you are not using a JNDI data source in any of your environments it will be sufficient to use a properties file to contain the connection information for each environment. If however some of your environments use a JNDI data source and some do not you will obviously have to use seperate Spring configuration files to specify the connection information.

<div class="card mb-3">
  <div class="card-header">
    applicationContext-persistence.xml
  </div>
  <div class="card-block">
{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:tx="http://www.springframework.org/schema/tx"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
      http://www.springframework.org/schema/beans/spring-beans.xsd
      http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd">

  <bean id="entityManagerFactory" class="org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean">
    <property name="jpaDialect">
      <bean class="org.springframework.orm.jpa.vendor.HibernateJpaDialect">
    </property>
    <property name="jpaVendorAdapter">
      <bean class="org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter">
    </property>
    <property name="persistenceUnitName" value="thoughtforge">
    <property name="persistenceUnitManager">
      <bean class="org.springframework.orm.jpa.persistenceunit.DefaultPersistenceUnitManager">
    </property>
    <property name="jpaProperties">
      <props>
        <prop key="hibernate.dialect">org.hibernate.dialect.HSQLDialect</prop>
        <prop key="hibernate.connection.driver_class">org.hsqldb.jdbcDriver</prop>
        <prop key="hibernate.connection.password"></prop>
        <prop key="hibernate.connection.url">jdbc:hsqldb:file:target/hsqldb/data</prop>
        <prop key="hibernate.connection.username">sa</prop>
      </props>
    </property>
  </bean>

  <bean id="transactionManager" class="org.springframework.orm.jpa.JpaTransactionManager">
    <property name="entityManagerFactory" ref="entityManagerFactory">
  </bean>

  <tx:annotation-driven/>

  <!-- JpaTemplate -->
  <bean id="jpaTemplate" class="org.springframework.orm.jpa.JpaTemplate">
    <property name="entityManagerFactory" ref="entityManagerFactory">
  </bean>
</beans>
{% endhighlight %}
  </div>
</div>

**Creating the Data Access Objects**

The data access objects (obviously) reside in the persistence module. I have a fairly standard PersistentEntityDao interface from which all data access object interfaces extend.

<div class="card mb-3">
  <div class="card-header">
    PersistentEntityDao.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.dao;

import java.util.List;
import net.thoughtforge.model.PersistentEntity;

public interface PersistentEntityDao {
    Entity findByIndexId(Integer indexId);
    List findByNamedQuery(String queryName);
    List findByNamedQueryAndParams(String queryName, Object ...params);
    Entity findUniqueByNamedQuery(String queryName);
    Entity findUniqueByNamedQueryAndParams(String queryName, Object ...params);
    Entity merge(Entity persistentEntity);
    void refresh(Entity persistentEntity);
    void remove(Entity persistentEntity);
    void save(Entity persistentEntity);
}
{% endhighlight %}
  </div>
</div>

Specific data access object interfaces would typically then only contain specific finder methods (See UserDao) below:

<div class="card mb-3">
  <div class="card-header">
    UserDao.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.dao;

import net.thoughtforge.model.User;

public interface UserDao extends PersistentEntityDao {
  User findByUsername(String username);
}
{% endhighlight %}
  </div>
</div>

The implementation classes reside in a specific sub-package that is named after the data access mechanism. For example, a JPA implementation has a 'jpa' sub-package, a Hibernate implementation has a 'hibernate' sub-package and a JDBC implementation has a 'jdbc' sub-package. I hate seeing sub-packages named impl; generally I feel that the only time this should happen is if there could only be one implementation of an interface which is clearly not the case for data access objects.

Similar to the data access object interfaces, ORM data access objects extend a common super class that exposes common CRUD functionality.

<div class="card mb-3">
  <div class="card-header">
    PersistentEntityDaoImpl.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.dao.jpa;

import java.lang.reflect.ParameterizedType;
import java.util.List;
import net.thoughtforge.dao.PersistentEntityDao;
import net.thoughtforge.model.PersistentEntity;
import org.springframework.orm.jpa.JpaTemplate;

public abstract class PersistentEntityDaoImpl implements PersistentEntityDao {

    private Class entityClass;
    private JpaTemplate jpaTemplate;

    @SuppressWarnings(value="unchecked")
    public PersistentEntityDaoImpl(JpaTemplate jpaTemplate) {
        this.jpaTemplate = jpaTemplate;
        ParameterizedType genericSuperclass = (ParameterizedType) getClass().getGenericSuperclass();
        this.entityClass = (Class) genericSuperclass.getActualTypeArguments()[0];
    }

    public final Entity findByIndexId(Integer indexId) {
        return (Entity) jpaTemplate.find(entityClass, indexId);
    }

    @SuppressWarnings("unchecked")
    public final List findByNamedQuery(String queryName) {
        return (List) jpaTemplate.findByNamedQuery(queryName);
    }

    @SuppressWarnings("unchecked")
    public final List findByNamedQueryAndParams(String queryName, Object ...params) {
        return (List) jpaTemplate.findByNamedQuery(queryName, params);
    }

    public final Entity findUniqueByNamedQuery(String queryName) {
        List results = findByNamedQuery(queryName);
        if (results.isEmpty()) {
            return null;
        } else {
            return results.get(0);
        }
    }

    public final Entity findUniqueByNamedQueryAndParams(String queryName, Object ...params) {
        List results = findByNamedQueryAndParams(queryName, params);
        if (results.isEmpty()) {
            return null;
        } else {
            return results.get(0);
        }
    }

    public final Entity merge(Entity persistentEntity) {
        return (Entity) jpaTemplate.merge(persistentEntity);
    }

    public final void refresh(Entity persistentEntity) {
        jpaTemplate.refresh(persistentEntity);
    }

    public final void remove(Entity persistentEntity) {
        jpaTemplate.remove(persistentEntity);
    }

    public final void save(Entity persistentEntity) {
        jpaTemplate.persist(persistentEntity);
    }
}
{% endhighlight %}
  </div>
</div>

Specific data access object interfaces would typically then only contain specific finder methods (See UserDaoImpl) below:

<div class="card mb-3">
  <div class="card-header">
    UserDaoImpl.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.dao.jpa;

import net.thoughtforge.dao.UserDao;
import net.thoughtforge.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.JpaTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class UserDaoImpl extends PersistentEntityDaoImpl implements UserDao {

    @Autowired
    public UserDaoImpl(JpaTemplate jpaTemplate) {
        super(jpaTemplate);
    }

    public User findByUsername(String username) {
        return findUniqueByNamedQueryAndParams("user.findByUsername", username);
    }
}
{% endhighlight %}
  </div>
</div>

As you can see, I always use named queries and NEVER hard code SQL into data access objects. The main reasons are that it reduces clutter in the code and maintains all SQL in a single place (persistence-query.xml). While I have not defined any query hints it is worth pointing out that they are almost always present in any meaningful implementation.</p>
It is also good practice to use namespaces for naming queries.

<div class="card mb-3">
  <div class="card-header">
    persistence-query.xml
  </div>
  <div class="card-block">
{% highlight xml %}
<?xml version="1.0" encoding="UTF-8" ?>

<entity-mappings xmlns="http://java.sun.com/xml/ns/persistence/orm"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://java.sun.com/xml/ns/persistence/orm http://java.sun.com/xml/ns/persistence/orm_1_0.xsd"
        version="1.0">

    <named-query name="userGroup.findByName">
        <query>
            from UserGroup
            where name = ?
        </query>
    </named-query>
    <named-query name="userToken.findByName">
        <query>
            from UserToken
            where name = ?
        </query>
    </named-query>
    <named-query name="user.findByUsername">
        <query>
            from User
            where username = ?
        </query>
    </named-query>
</entity-mappings>
{% endhighlight %}
  </div>
</div>

The above code examples should suffice to demonstrate the implementation and organisation of the data access objects. The complete code is available for download.

**Testing the Data Access Objects**

Spring provides support for writing transactional data access object tests that I always utilise when testing data access objects. Where possible, I use an embedded database to 'exercise' my data access objects during testing. By this I mean that at a minimum I test create, update and delete for every type of persistent entity and invoke every find method (and named query). I have only included a sample test which should be enough for the purpose of demonstration.

<div class="card mb-3">
  <div class="card-header">
    UserDaoImplTest.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.dao.jpa;

import junit.framework.Assert;
import net.thoughtforge.dao.UserDao;
import net.thoughtforge.model.User;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"classpath:applicationContext/applicationContext-*.xml"})
@TransactionConfiguration(transactionManager="transactionManager", defaultRollback=true)
@Transactional
public class UserDaoImplTest {

	private static final String FIRST_NAME = "joe";
	private static final String LAST_NAME = "bloggs";
	private static final String PASSWORD = "password";
	private static final String USERNAME = "joe.bloggs";

	@Autowired
	private UserDao userDao;

	@Before
	public void before() {
		User user = new User();
		user.setFirstName(FIRST_NAME);
		user.setLastName(LAST_NAME);
		user.setPassword(PASSWORD);
		user.setUsername(USERNAME);
		userDao.save(user);
	}

	@Test
	public void findByUserName() {
		User user = userDao.findByUsername(USERNAME);
		Assert.assertNotNull(user);
		Assert.assertEquals(USERNAME, user.getUsername());
	}
}
{% endhighlight %}
  </div>
</div>

I hope that I have given you a good overview of how I implement and organise Hibernate JPA code. There are lots of variations on this approach and none are perfect but I always find this approach a good place to start.
