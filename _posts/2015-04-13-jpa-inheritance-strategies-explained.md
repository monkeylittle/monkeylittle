---
layout: post

title: JPA Inheritance Strategies Explained
author: john_turner
featured: false
featured_image: /assets/img/post/2015-04-12-jpa-inheritance-strategies-explained/jpa-inheritance-class-diagram.png

categories:
- Object Relational Mapping
---

Last week, I was speaking to an intern who worked for me while I was at Paddy Power.  He was explaining with some frustration that he had recently had the supervisor for his final year project reassigned.  The guidance from the new supervisor was that the project needed some "wow".  I was not sure if this meant he needed to present the project while flanked by the Dallas Coyboys Cheerleaders so I asked for some specifics.  This was the rather perplexing response.

<img src="/assets/img/post/2015-04-12-jpa-inheritance-strategies-explained/jpa-inheritance-tweet.png" class="img-fluid img-thumbnail">

I know Ian is using JPA and I would like to give him a little more information than he received from the above suggestion. So here is my effort at explaining the JPA inheritance strategies.

#### JPA Inheritance Strategies

The JPA inheritance strategies facilitate mapping of an inheritance hierarchy in 3 different ways. To demonstrate the advantages and disadvantages of each, I will use a class hierarchy comprising a Vehicle, Airplane, Bike and Car.

<img src="/assets/img/post/2015-04-12-jpa-inheritance-strategies-explained/jpa-inheritance-class-diagram.png" class="img-fluid img-thumbnail">

So you can follow or experiment with the code I've made it available on [GitHub](https://github.com/monkeylittle/spring-jpa-inheritance).  Note that there are separate repositories for each class, that the Vehicle class is abstract and that each repository has a corresponding test class.  I'm using Spring Boot to automatically discover the repositories, entity mappings as well as provide an in memory database for testing purposes.

I've enabled the Hibernate SQL logging so that we can see the table DDL as well as the structure of a findAll query executed via each of the repositories.

<!-- more -->

#### InheritanceType.JOINED

The JOINED inheritance strategy specifies a table for each class within the hierarchy.

**Table Structure**

Given the Vehicle hierarchy, there will be 4 tables created as demonstrated by the log output below:

<div class="card mb-3">
  <div class="card-header">
    Create Tables
  </div>
  <div class="card-block">
{% highlight plaintext %}
[main] DEBUG org.hibernate.SQL - create table airplane (id bigint not null, primary key (id))
[main] DEBUG org.hibernate.SQL - create table bike (id bigint not null, primary key (id))
[main] DEBUG org.hibernate.SQL - create table car (id bigint not null, primary key (id))
[main] DEBUG org.hibernate.SQL - create table vehicle (id bigint not null, colour integer, primary key (id))
{% endhighlight %}
  </div>
</div>

You will also notice that in this simple example, the properties of each class file correlate directly to columns on each table with the id duplicated across all 4 tables.  The id column on the airplane, bike and car tables act as a foreign key while the id on the vehicle table is the primary key.

From this we can deduce all the advantages and disadvantages.

**Changing Class Definitions is Easier**

Because there is a direct correlation of class + properties to table + columns there is no duplication of the vehicle definition.  As a result a single change for a class or property definition will result in a single change for a table or column definition.  For example, if I add an 'isMortorised' property to vehicle class it will result in the addition of a 'motorised' column on the vehicle table.

**Data Integrity at the DBMS**

Another side effect of the direct mapping between class and table is that I can manage data integrity at the database layer.  For example, column definitions including null constraints, foreign key constraints etc. can be managed by the DBMS (without resorting to stored procedures).

**Creating an Airplane, Bike or Car is (more) Expensive**

To save an Airplane requires an insert into the vehicle and airplane tables.  It will also require a sequence number to be generated for the vehicle and a foreign key constraint validation to occur on the airplane table.  We can see this from the log statement below:

<div class="card mb-3">
  <div class="card-header">
    Insert Airplane
  </div>
  <div class="card-block">
{% highlight plaintext %}
[main] DEBUG org.hibernate.SQL - insert into vehicle (colour, id) values (?, ?)
[main] DEBUG org.hibernate.SQL - insert into airplane (id) values (?)
{% endhighlight %}
  </div>
</div>

**Retrieving an Airplane, Bike or Car is (more) Expensive**

To retrieve an Airplane (or Airplanes) requires a join between vehicle and airplane.

<div class="card mb-3">
  <div class="card-header">
    Retrieve Airplane
  </div>
  <div class="card-block">
{% highlight plaintext %}
[main] DEBUG org.hibernate.SQL - select airplane0_.id as id1_3_, airplane0_1_.colour as colour2_3_ from airplane airplane0_ inner join vehicle airplane0_1_ on airplane0_.id=airplane0_1_.id
{% endhighlight %}
  </div>
</div>

**Retrieving a Vehicle is (much more) Expensive**

To retrieve a Vehicle (or Vehicles) requires a (left outer) join between vehicle, airplane, bike and car.

<div class="card mb-3">
  <div class="card-header">
    Retrieve Vehicle
  </div>
  <div class="card-block">
{% highlight plaintext %}
[main] DEBUG org.hibernate.SQL - select vehicle0_.id as id1_3_, vehicle0_.colour as colour2_3_, case when vehicle0_1_.id is not null then 1 when vehicle0_2_.id is not null then 2 when vehicle0_3_.id is not null then 3 when vehicle0_.id is not null then 0 end as clazz_ from vehicle vehicle0_ left outer join airplane vehicle0_1_ on vehicle0_.id=vehicle0_1_.id left outer join car vehicle0_2_ on vehicle0_.id=vehicle0_2_.id left outer join bike vehicle0_3_ on vehicle0_.id=vehicle0_3_.id
{% endhighlight %}
  </div>
</div>

#### InheritanceType.SINGLE_TABLE

As the name suggests, the SINGLE_TABLE inheritance strategy specifies a table for the entire class hierarchy.

**Table Structure**

Given the Vehicle hierarchy, there will be 1 table created as demonstrated by the log output below:

<div class="card mb-3">
  <div class="card-header">
    Create Tables
  </div>
  <div class="card-block">
{% highlight plaintext %}
[main] DEBUG org.hibernate.SQL - create table vehicle (dtype varchar(31) not null, id bigint not null, colour integer, primary key (id))
{% endhighlight %}
  </div>
</div>

You'll notice that the first column definition does not correspond to a property from any of the class files.  This is a discriminator column that allows JPA to understand the type of entity to create when it retrieves a row from this table.

**Changing Class Definitions is Harder**

When using the JOINED strategy I only impacted the table corresponding to the class I was modifying.  With the SINGLE_TABLE strategy I am changing table that all vehicles are stored in.  This may or may not be  a big deal but is worth considering especially if you are storing lots of data.

**Data Integrity at the DBMS**

Column definitions including null constraints, foreign key constraints etc. can no longer be managed by the DBMS (without resorting to stored procedures).  This can be a problem especially when a database can be access by different applications using different access layers.

**Data Storage**

Because a single table is stores all vehicles there will necessarily be a lot of null values in columns that do not relate to the specific type.  This may or may not be a problem depending on the size of the tables and how efficient the DBMS is at storing null values.

**Creating an Airplane, Bike or Car is Cheap**

Because the SINGLE_TABLE strategy uses a single table, creating an Airplane, Bike or Car is a single insert executed against a single (albeit larger) table.

<div class="card mb-3">
  <div class="card-header">
    Insert Vehicles
  </div>
  <div class="card-block">
{% highlight plaintext %}
[main] DEBUG org.hibernate.SQL - insert into vehicle (colour, dtype, id) values (?, 'Bike', ?)
[main] DEBUG org.hibernate.SQL - insert into vehicle (colour, dtype, id) values (?, 'Car', ?)
[main] DEBUG org.hibernate.SQL - insert into vehicle (colour, dtype, id) values (?, 'Airplane', ?)
{% endhighlight %}
  </div>
</div>

Note that the discriminator value defaults to the class name.  Be careful that whatever discriminator you use is treated efficiently by the DBMS (in terms of both storage and query efficiency.  The discriminator can be changed using the JPA DiscriminatorColumn annotation.

**Retrieving a Vehicle, Airplane, Bike or Car is Cheap**

Again, because of the use of a single table retrieving a Vehicle, Airplane, Bike or Car (or many of same) is cheap.  It is a single select statement which filters using the discriminator value if a subclass is being queried.  This is the cheapest strategy for executing polymorphic queries (i.e. retrieving Vehicles).

<div class="card mb-3">
  <div class="card-header">
    Retrieve Vehicles
  </div>
  <div class="card-block">
{% highlight plaintext %}
[main] DEBUG org.hibernate.SQL - select car0_.id as id2_0_, car0_.colour as colour3_0_ from vehicle car0_ where car0_.dtype='Car'
[main] DEBUG org.hibernate.SQL - select bike0_.id as id2_0_, bike0_.colour as colour3_0_ from vehicle bike0_ where bike0_.dtype='Bike'
[main] DEBUG org.hibernate.SQL - select airplane0_.id as id2_0_, airplane0_.colour as colour3_0_ from vehicle airplane0_ where airplane0_.dtype='Airplane'
[main] DEBUG org.hibernate.SQL - select vehicle0_.id as id2_0_, vehicle0_.colour as colour3_0_, vehicle0_.dtype as dtype1_0_ from vehicle vehicle0_
{% endhighlight %}
  </div>
</div>

#### InheritanceType.TABLE_PER_CLASS

The TABLE_PER_CLASS strategy is really a table per concrete class strategy.

**Table Structure**

Given the Vehicle hierarchy, there will be 3 tables created as demonstrated by the log output below:

<div class="card mb-3">
  <div class="card-header">
    Create Tables
  </div>
  <div class="card-block">
{% highlight plaintext %}
[main] DEBUG org.hibernate.SQL - create table airplane (id bigint not null, colour integer, primary key (id))
[main] DEBUG org.hibernate.SQL - create table bike (id bigint not null, colour integer, primary key (id))
[main] DEBUG org.hibernate.SQL - create table car (id bigint not null, colour integer, primary key (id))
{% endhighlight %}
  </div>
</div>

The inherited colour property is defined in the definitions of the airplane, bike and car tables.  There is no vehicle table as Vehicle is an abstract class.  There is also no discriminator as data from each vehicle is stored in its own table.

**Changing Class Definitions is Easier**

Given that each concrete class has its own corresponding table definition, it is easier to modify these.  However, if I modify the Vehicle definition I have to make corresponding modifications to the airplane, bike and car tables.

**Data Integrity at the DBMS**

Because each concrete class is stored in its own table the DBMS can manage null constraints, foreign key constraints etc. without resorting to stored procedures.

**Creating an Airplane, Bike or Car is Cheap**

Because the TABLE_PER_CLASS strategy uses a single table for each concrete class, creating an Airplane, Bike or Car is a single insert executed against a single table.

<div class="card mb-3">
  <div class="card-header">
    Create Vehicles
  </div>
  <div class="card-block">
{% highlight plaintext %}
[main] DEBUG org.hibernate.SQL - insert into bike (colour, id) values (?, ?)
[main] DEBUG org.hibernate.SQL - insert into car (colour, id) values (?, ?)
[main] DEBUG org.hibernate.SQL - insert into airplane (colour, id) values (?, ?)
{% endhighlight %}
  </div>
</div>

There is no discriminator value in this case!

**Retrieving an Airplane, Bike or Car is Cheap**

Again, because of the use of a single table retrieving an Airplane, Bike or Car (or many of same) is cheap.  It is a single select statement.

<div class="card mb-3">
  <div class="card-header">
    Retrieve Airplane, Bike, Car
  </div>
  <div class="card-block">
{% highlight plaintext %}
[main] DEBUG org.hibernate.SQL - select car0_.id as id1_3_, car0_.colour as colour2_3_ from car car0_
[main] DEBUG org.hibernate.SQL - select bike0_.id as id1_3_, bike0_.colour as colour2_3_ from bike bike0_
[main] DEBUG org.hibernate.SQL - select airplane0_.id as id1_3_, airplane0_.colour as colour2_3_ from airplane airplane0_
{% endhighlight %}
  </div>
</div>

**Retrieving a Vehicle is Expensive**

The biggest disadvantage of this strategy is that polymorphic queries are expensive, requiring a union of 3 data sets (from each of the tables).

<div class="card mb-3">
  <div class="card-header">

  </div>
  <div class="card-block">
{% highlight plaintext %}
[main] DEBUG org.hibernate.SQL - select vehicle0_.id as id1_3_, vehicle0_.colour as colour2_3_, vehicle0_.clazz_ as clazz_ from ( select id, colour, 1 as clazz_ from airplane union all select id, colour, 2 as clazz_ from car union all select id, colour, 3 as clazz_ from bike ) vehicle0_
{% endhighlight %}
  </div>
</div>

#### Wrapping Up

So there we have it, some of the considerations to be taken into account when selecting the JPA inheritance strategy.  A lot of these will depend on the particulars of the DBMS you are using but for the most part this will provide a useful guide.
