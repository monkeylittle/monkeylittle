---
layout: post

title: Marshalling XML with Spring WS and JAXB
author: john_turner
featured: false

categories:
- Spring Framework
---

The 'object-relational impedance mismatch' is a well documented set of conceptual and technical difficulties that are often encountered when a relational database management system is being used by a program written in an object-oriented programming language. A similar impedance mismatch exists when XML is used by a program written in an object-oriented programming language.

Many popular 'Object-Relational Mapping' (ORM) frameworks exist that address the object-relational impedance mismatch and no doubt helped to inspire the evolution of 'Object-XML Mapping' (OXM) frameworks to address the object-xml impedance mismatch.

For the Java community, there are a number of OXM frameworks from which to choose [Castor](http://www.castor.org/), [XStream](http://xstream.codehaus.org/), [JiBX](http://jibx.sourceforge.net/), [JAXB](https://jaxb.dev.java.net/) with each having particular strengths and weaknesses. The standard OXM framework for Java is JAXB.

In the following I work through a simple example that demonstrates object to XML marshalling (and demarshalling) using [Spring](http://www.springsource.org/about), [Spring WS](http://static.springsource.org/spring-ws/sites/1.5/) and JAXB (and later [JAXB Introductions](http://community.jboss.org/wiki/JAXBIntroductions)!)

The source code is available on GitHub for [Spring OXM and JAXB](https://github.com/monkeylittle/spring-jaxb2-marshaller) as well as [Spring OXM, JAXB and JAXB Introductions Download](https://github.com/monkeylittle/spring-jaxb2-marshaller-introductions).

<!-- more -->

**The Model**

The model object that I have used for this example is a simple object representing a 'Person'. The class contains only simple attributes.

<div class="card mb-3">
  <div class="card-header">
    Person.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Calendar;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlRootElement(
		name="Person",
		namespace="http://thoughtforge.net/model")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType<
public class Person implements Serializable {

	private static final long serialVersionUID = 8465162879793776395L;

	@XmlElement(namespace="http://thoughtforge.net/model")
	private Calendar dateOfBirth;

	@XmlElement(namespace="http://thoughtforge.net/model")
	private String firstName;

	@XmlElement(namespace="http://thoughtforge.net/model")
	private BigDecimal height;

	@XmlElement(namespace="http://thoughtforge.net/model")
	private String lastName;

	@XmlElement(namespace="http://thoughtforge.net/model")
	private BigDecimal weight;

	public Calendar getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Calendar dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public BigDecimal getHeight() {
		return height;
	}

	public void setHeight(BigDecimal height) {
		this.height = height;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public BigDecimal getWeight() {
		return weight;
	}

	public void setWeight(BigDecimal weight) {
		this.weight = weight;
	}
}
{% endhighlight %}
  </div>
</div>

As you can see from the listing, the class is annotated with JAXB annotations that are fairly self explanatory. I will leave it to you to look up the precise definition and consequence of these annotations (which can be found on the JAXB Reference Implementation website).

**The XML Schema (XSD)**

JAXB does not require an XML schema (a default schema can be generated), but for this example (and always on commercial projects) I have explicitly specified a schema in order to include type restrictions. It is important to remember that the XSD forms the contract between XML producers and consumers (marshaller and unmarshaller) and should be as detailed as possible.

<div class="card mb-3">
  <div class="card-header">
    Person.xsd
  </div>
  <div class="card-block">
{% highlight xml %}
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	targetNamespace="http://thoughtforge.net/model"
	xmlns:tns="http://thoughtforge.net/model"
	attributeFormDefault="unqualified"
	elementFormDefault="qualified"
	version="1.0">

	<xsd:element name="Person" type="tns:Person"/>
	<xsd:complexType name="Person">
		<xsd:sequence>
			<xsd:element name="dateOfBirth" type="xsd:dateTime"/>
			<xsd:element name="firstName">
				<xsd:simpleType>
					<xsd:restriction base="xsd:string">
						<xsd:maxLength value="50"/>
					</xsd:restriction>
				</xsd:simpleType>
			</xsd:element>
			<xsd:element name="height">
				<xsd:simpleType>
					<xsd:restriction base="xsd:decimal">
						<xsd:fractionDigits value="2"/>
					</xsd:restriction>
				</xsd:simpleType>
			</xsd:element>
			<xsd:element name="lastName">
				<xsd:simpleType>
					<xsd:restriction base="xsd:string">
						<xsd:maxLength value="50"/>
					</xsd:restriction>
				</xsd:simpleType>
			</xsd:element>
			<xsd:element name="weight">
				<xsd:simpleType>
					<xsd:restriction base="xsd:decimal">
						<xsd:fractionDigits value="2">
					</xsd:restriction>
				</xsd:simpleType>
			</xsd:element>
		</xsd:sequence>
	</xsd:complexType>
</xsd:schema>
{% endhighlight %}
  </div>
</div>

**The Marshaller Abstraction**

Rather than use the Spring Marshaller/Unmarshaller interface directly, I often use an abstraction for the Marshaller. The abstraction I used here is very simple and of course would not be practical for use with large XML files as it does not support streaming etc.

<div class="card mb-3">
  <div class="card-header">
    Marshaller.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.marshaller;

public interface Marshaller {
	String marshal(Object object);
	Object unmarshal(String string);
}
{% endhighlight %}
  </div>
</div>

The implementation of the marshaller delegates to a Spring JAXB marshaller.

<div class="card mb-3">
  <div class="card-header">
    Jaxb2Marshaller.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.marshaller;

import java.io.StringWriter;
import javax.xml.transform.stream.StreamResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.xml.transform.StringSource;

@Component(value="marshaller")
public class Jaxb2Marshaller implements Marshaller {

	@Autowired
	@Qualifier(value="jaxb2Marshaller")
	private org.springframework.oxm.jaxb.Jaxb2Marshaller marshaller;

	public String marshal(Object object) {
		final StringWriter out = new StringWriter();
		marshaller.marshal(object, new StreamResult(out));
		return out.toString();
	}

	public Object unmarshal(String string) {
		return marshaller.unmarshal(new StringSource(string));
	}
}
{% endhighlight %}
  </div>
</div>

**The Configuration**

Using Spring to define a JAXB marshaller is relatively straight forward as the listing shows. I have specified the classes to be bound and the XML schema. If the XML schema is specified, the marshaller will instruct the XML parser to validate XML against the schema.

<div class="card mb-3">
  <div class="card-header">
    applicationContext-marshaller.xml
  </div>
  <div class="card-block">
{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">

	<context:component-scan base-package="net.thoughtforge.marshaller">

	<bean id="jaxb2Marshaller" class="org.springframework.oxm.jaxb.Jaxb2Marshaller">
		<property name="classesToBeBound">
			<list>
				<value>net.thoughtforge.model.Person</value>
			</list>
		</property>
		<property name="schema" value="classpath:schema/person.xsd"/>
	</bean>
</beans>
{% endhighlight %}
  </div>
</div>

**The Test**

The following test is not exhaustive but demonstrates the marshalling and unmarshalling of a Person object. It also demonstrates XML schema validation occurring during the marshalling and unmarshalling process.

<div class="card mb-3">
  <div class="card-header">
    Jaxb2MarshallerTest.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.marshaller;

import java.math.BigDecimal;
import java.util.Calendar;
import net.thoughtforge.model.Person;
import org.apache.commons.lang.text.StrBuilder;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.oxm.MarshallingFailureException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"classpath:applicationContext/applicationContext-*.xml"})
public class Jaxb2MarshallerTest {

	private static final String MARSHALLED_PERSON =
		"1965-01-01T00:00:00ZJoe1.85Bloggs12.2";

	private static Calendar dateOfBirth;
	private static String firstName;
	private static BigDecimal height;
	private static String lastName;
	private static BigDecimal weight;

	@Autowired
	@Qualifier(value="marshaller")
	private Jaxb2Marshaller marshaller;

	@BeforeClass
	public static void beforeClass() {
		dateOfBirth = Calendar.getInstance();
		dateOfBirth.clear();
		dateOfBirth.set(Calendar.DATE, 1);
		dateOfBirth.set(Calendar.MONTH, Calendar.JANUARY);
		dateOfBirth.set(Calendar.YEAR, 1965);
		firstName = "Joe";
		height = new BigDecimal("1.85");
		lastName = "Bloggs";
		weight = new BigDecimal("12.2");
	}

	@Test
	public void marshallPerson() {
		Person person = new Person();
		person.setDateOfBirth(dateOfBirth);
		person.setFirstName(firstName);
		person.setHeight(height);
		person.setLastName(lastName);
		person.setWeight(weight);
		String xml = marshaller.marshal(person);
		Assert.assertNotNull(xml);
		Assert.assertEquals(MARSHALLED_PERSON, xml);
	}

	@Test
	public void marshallPersonInvalidFirstName() {
		Person person = new Person();
		person.setDateOfBirth(dateOfBirth);
		person.setFirstName(new StrBuilder(firstName).appendPadding(50, '0').toString());
		person.setHeight(height);
		person.setLastName(lastName);
		person.setWeight(weight);
		try {
			marshaller.marshal(person);
			Assert.fail("First name length restriction not applied.");
		} catch (MarshallingFailureException marshallingFailureException) {
			Throwable rootCause = marshallingFailureException.getRootCause();
			Assert.assertFalse(rootCause.getMessage().indexOf("is not facet-valid with respect to maxLength '50'") == -1);
		}
	}

	@Test
	public void marshallPersonInvalidHeight() {
		Person person = new Person();
		person.setDateOfBirth(dateOfBirth);
		person.setFirstName(firstName);
		person.setHeight(height.add(new BigDecimal("0.1111")));
		person.setLastName(lastName);
		person.setWeight(weight);
		try {
			marshaller.marshal(person);
			Assert.fail("Height precision restriction not applied.");
		} catch (MarshallingFailureException marshallingFailureException) {
			Throwable rootCause = marshallingFailureException.getRootCause();
			Assert.assertFalse(rootCause.getMessage().indexOf("the number of fraction digits has been limited to 2") == -1);
		}
	}

	@Test
	public void marshallPersonInvalidLastName() {
		Person person = new Person();
		person.setDateOfBirth(dateOfBirth);
		person.setFirstName(firstName);
		person.setHeight(height);
		person.setLastName(new StrBuilder(lastName).appendPadding(50, '0').toString());
		person.setWeight(weight);
		try {
			marshaller.marshal(person);
			Assert.fail("First name length restriction not applied.");
		} catch (MarshallingFailureException marshallingFailureException) {
			Throwable rootCause = marshallingFailureException.getRootCause();
			Assert.assertFalse(rootCause.getMessage().indexOf("is not facet-valid with respect to maxLength '50'") == -1);
		}
	}

	@Test
	public void marshallPersonInvalidWeight() {
		Person person = new Person();
		person.setDateOfBirth(dateOfBirth);
		person.setFirstName(firstName);
		person.setHeight(height);
		person.setLastName(lastName);
		person.setWeight(weight.add(new BigDecimal("0.1111")));
		try {
			marshaller.marshal(person);
			Assert.fail("Weight precision restriction not applied.");
		} catch (MarshallingFailureException marshallingFailureException) {
			Throwable rootCause = marshallingFailureException.getRootCause();
			Assert.assertFalse(rootCause.getMessage().indexOf("the number of fraction digits has been limited to 2") == -1);
		}
	}

	@Test
	public void unmarshallPerson() {
		Person person = (Person) marshaller.unmarshal(MARSHALLED_PERSON);
		Assert.assertNotNull(person);
		Assert.assertTrue(dateOfBirth.compareTo(person.getDateOfBirth()) == 0);
		Assert.assertEquals(firstName, person.getFirstName());
		Assert.assertEquals(height, person.getHeight());
		Assert.assertEquals(lastName, person.getLastName());
		Assert.assertEquals(weight, person.getWeight());
	}
}
{% endhighlight %}
  </div>
</div>

**Removing JAXB Annotations**

If you are using the reference implementation of JAXB you are required to use annotations to map objects to XML. As I mentioned in a previous post, I'm not a fan of using annotations for the purpose of mapping objects to some other format (relational database or XML or A.N. Other). I find it creates code clutter especially in instances were entity model classes are mapped to both a relational database and XML (using JAXB). In modular projects, it also creates unnecessary dependencies on the model module.

Luckily, some bright spark came along and created JAXB Introductions which allows you to define the mapping of objects to XML in an XML file. I'm not going to regurgitate the information on the JAXB Introductions website but I will outline the modifications I had to make to allow me to use JAXB Introductions with the example above.

First, I added the maven dependency to the project.

<div class="card mb-3">
  <div class="card-header">
    pom.xml
  </div>
  <div class="card-block">
{% highlight xml %}
<dependency>
  <groupId>jboss.jaxbintros</groupId>
  <artifactId>jboss-jaxb-intros</artifactId>
  <version>1.0.1.GA</version>
</dependency>
{% endhighlight %}
  </div>
</div>

Second, I created a JAXB Introductions mapping file.

<div class="card mb-3">
  <div class="card-header">
    marshaller-mapping.xml
  </div>
  <div class="card-block">
{% highlight xml %}
<?xml version = "1.0" encoding = "UTF-8"?>
<jaxb-intros xmlns="http://www.jboss.org/xsd/jaxb/intros">
    <Class name="net.thoughtforge.model.Person">
        <XmlType/>
        <XmlRootElement name="Person" namespace="http://thoughtforge.net/model">
        <XmlAccessorType value="FIELD"/>
        <Field name="dateOfBirth">
            <XmlElement name="dateOfBirth" namespace="http://thoughtforge.net/model">
        </Field>
        <Field name="firstName">
            <XmlElement name="firstName" namespace="http://thoughtforge.net/model">
        </Field>
        <Field name="height">
            <XmlElement name="height" namespace="http://thoughtforge.net/model">
        </Field>
        <Field name="lastName">
            <XmlElement name="lastName" namespace="http://thoughtforge.net/model">
        </Field>
        <Field name="weight">
            <XmlElement name="weight" namespace="http://thoughtforge.net/model">
        </Field>
    </Class>
</jaxb-intros>
{% endhighlight %}
  </div>
</div>

Thirdly, I modified the Spring configuration to inject the JAXB Introductions annotation reader into the JAXB marshaller.

<div class="card mb-3">
  <div class="card-header">
    applicationContext-marshaller.xml
  </div>
  <div class="card-block">
{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:util="http://www.springframework.org/schema/util"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/util http://www.springframework.org/schema/util/spring-util-2.0.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">

	<context:component-scan base-package="net.thoughtforge.marshaller">

	<bean id="jaxb2Marshaller" class="org.springframework.oxm.jaxb.Jaxb2Marshaller">
		<property name="classesToBeBound">
			<list>
				<value>net.thoughtforge.model.Person</value>
			</list>
		</property>
		<property name="jaxbContextProperties">
			<map>
				<entry>
					<key>
						<util:constant static-field="com.sun.xml.bind.api.JAXBRIContext.ANNOTATION_READER">
					</key>
					<bean class="org.jboss.jaxb.intros.IntroductionsAnnotationReader">
						<constructor-arg ref="jaxbIntroductions">
					</bean>
				</entry>
			</map>
		</property>
		<property name="schema" value="classpath:schema/person.xsd">
	</bean>

	<bean id="jaxbIntroductions" class="org.jboss.jaxb.intros.IntroductionsConfigParser" factory-method="parseConfig">
		<constructor-arg><value>classpath:marshaller-mapping.xml</value></constructor-arg>
	</bean>
</beans>
{% endhighlight %}
  </div>
</div>

Finally, I removed the JAXB annotations from the model class (Person.java).

<div class="card mb-3">
  <div class="card-header">
    Person.java
  </div>
  <div class="card-block">
{% highlight java %}
package net.thoughtforge.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Calendar;

public class Person implements Serializable {

	private static final long serialVersionUID = 8465162879793776395L;

	private Calendar dateOfBirth;
	private String firstName;
	private BigDecimal height;
	private String lastName;
	private BigDecimal weight;

	public Calendar getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Calendar dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public BigDecimal getHeight() {
		return height;
	}

	public void setHeight(BigDecimal height) {
		this.height = height;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public BigDecimal getWeight() {
		return weight;
	}

	public void setWeight(BigDecimal weight) {
		this.weight = weight;
	}
}
{% endhighlight %}
  </div>
</div>

Hopefully, this short example will prove useful for those starting out with JAXB and OXM. For those already familiar with JAXB and OXM, perhaps it has shown you how you can use JAXB without annotations.
