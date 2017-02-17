---
layout: post

title: Building a Custom Jenkins Docker Image - Part 2
author: john_turner
banner_image: http://placehold.it/730x300

tags:
- Kubernetes
- Docker
- Jenkins
---

In [Building a Custom Jenkins Docker Image - Part 1]({ post_url 2017-02-14-building-a-custom-jenkins-docker-image-part-1}) we disabled the Jenkins install wizard and installed the default plugins.  In part 2, I want to focus on ensuring the build tools are installed.  The target end state of our build infrastructure must include the installation and configuration of:

- Java
- [Jenkins](https://jenkins.io/)
- Jenkins plugins
- Jenkins jobs (using [JobDSL](https://wiki.jenkins-ci.org/display/JENKINS/Job+DSL+Plugin))
- [Git](https://git-scm.com/)
- [Apache Maven](https://maven.apache.org/)

We can review the [official Jenkins image](https://hub.docker.com/_/jenkins/) source on the [jenkinsci docker GitHub repository](https://github.com/jenkinsci/docker) to understand which of these tools are already provided for.  From the [Dockerfile](https://github.com/jenkinsci/docker/blob/master/Dockerfile) we can see the following:

{% highlight docker %}
FROM openjdk:8-jdk

RUN apt-get update && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*
{% endhighlight %}

This means that the official Jenkins image is based on the openjdk:8-jdk image (Java 8 JDK is installed) and that the Git client is installed.  There is nothing to suggest that Maven is installed and we can verify this by creating a new bash session in the container and listing the installed packages.

{% highlight bash %}
$ kubectl exec jenkins-155111175-p72qf -it -- bash
jenkins@jenkins-155111175-p72qf:/$ apt list --installed
Listing... Done
acl/now 2.2.52-2 amd64 [installed,local]
...
lsb-base/now 4.1+Debian13+nmu1 all [installed,local]
mawk/now 1.3.3-17 amd64 [installed,local]
mercurial/now 3.1.2-2+deb8u3 amd64 [installed,local]
mercurial-common/now 3.1.2-2+deb8u3 all [installed,local]
mime-support/now 3.58 all [installed,local]
mount/now 2.25.2-6 amd64 [installed,local]
multiarch-support/now 2.19-18+deb8u7 amd64 [installed,local]
ncurses-base/now 5.9+20140913-1 all [installed,local]
...
zlib1g/now 1:1.2.8.dfsg-2+b1 amd64 [installed,local]
jenkins@jenkins-155111175-p72qf:/$
{% endhighlight %}

To install maven we use the [Docker RUN statement](https://docs.docker.com/engine/reference/builder/#run) in the Jenkins/Dockerfile to invoke *apt-get install*.  This requires us first to become the root user and subsequently to resume as the jenkins user.

{% highlight docker %}
# install Maven
USER root
RUN apt-get update && apt-get install -y maven
USER jenkins
{% endhighlight %}

<!-- more -->

I can now build a new Docker image:
<div class="card mb-3">
  <div class="card-header">
    Dockerfile
  </div>
  <div class="card-block">
{% highlight plaintext %}
from jenkins:2.32.2

# install plugins specified in https://github.com/kohsuke/jenkins/blob/master/core/src/main/resources/jenkins/install/platform-plugins.json

# install Organisation and Administration plugins
RUN /usr/local/bin/install-plugins.sh cloudbees-folder
RUN /usr/local/bin/install-plugins.sh antisamy-markup-formatter

# install Build Features plugins
RUN /usr/local/bin/install-plugins.sh build-timeout
RUN /usr/local/bin/install-plugins.sh credentials-binding
RUN /usr/local/bin/install-plugins.sh timestamper
RUN /usr/local/bin/install-plugins.sh ws-cleanup

# install Build Tools plugins
RUN /usr/local/bin/install-plugins.sh ant
RUN /usr/local/bin/install-plugins.sh gradle

# install Pipelines and Continuous Delivery plugins
RUN /usr/local/bin/install-plugins.sh workflow-aggregator:2.0
RUN /usr/local/bin/install-plugins.sh github-organization-folder:1.6
RUN /usr/local/bin/install-plugins.sh pipeline-stage-view:2.0

# install Source Code Management plugins
RUN /usr/local/bin/install-plugins.sh git
RUN /usr/local/bin/install-plugins.sh subversion

# install Distributed Builds plugins
RUN /usr/local/bin/install-plugins.sh ssh-slaves

# install User Management and Security plugins
RUN /usr/local/bin/install-plugins.sh matrix-auth
RUN /usr/local/bin/install-plugins.sh pam-auth
RUN /usr/local/bin/install-plugins.sh ldap

# install Notifications and Publishing plugins
RUN /usr/local/bin/install-plugins.sh email-ext
RUN /usr/local/bin/install-plugins.sh mailer

# install Maven
USER root
RUN apt-get update && apt-get install -y maven
USER jenkins
{% endhighlight %}
</div>
</div>

{% highlight bash %}
docker build -t monkeylittle/jenkins:1.1.0 .
{% endhighlight %}

<strong>Note that I have changed the version tag.</strong>

As this is a personal exercise in learning about Kubernetes and Docker, I attempted to perform a rolling update of the deployment but this required using hostPath persistent volumes.  Minikube does not yet support running containers with non root users and hostPath volumes (which are provisioned by root user). See this [guthub pull request](https://github.com/kubernetes/minikube/pull/959/commits/b70cac334dd0886681fac84775a0afa956931a2d) for more information.

<div class="card mb-3">
  <div class="card-header">
    deployment.yaml
  </div>
  <div class="card-block">
{% highlight yaml %}
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: jenkins
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      containers:
        - name: jenkins
          image: monkeylittle/jenkins:1.1.0
          env:
            - name: JAVA_OPTS
              value: -Djenkins.install.runSetupWizard=false
          ports:
            - name: http-port
              containerPort: 8080
            - name: jnlp-port
              containerPort: 50000
          volumeMounts:
            - name: jenkins-home
              mountPath: /var/jenkins_home
      volumes:
        - name: jenkins-home
          emptyDir: {}
{% endhighlight %}
  </div>
</div>

Then recreate the pod.

{% highlight docker %}
$ kubectl apply -f deployment.yaml
deployment "jenkins" configured
{% endhighlight %}

It's possible to verify the update by describing the pod:

{% highlight bash %}
$ kubectl describe pod | grep Image:
    Image:		monkeylittle/jenkins:1.1.0
{% endhighlight %}

To validate that maven is now installed within the container I can create a new bash session in the container and run *apt list --installed*.

{% highlight bash %}
$ kubectl exec jenkins-258199304-4jf60 -it -- bash
jenkins@jenkins-258199304-4jf60:/$ apt list --installed | grep maven

WARNING: apt does not have a stable CLI interface yet. Use with caution in scripts.

libmaven-parent-java/stable,now 21-2 all [installed,automatic]
libmaven-scm-java/stable,now 1.3-5 all [installed,automatic]
libmaven2-core-java/stable,now 2.2.1-17 all [installed,automatic]
maven/stable,now 3.0.5-3 all [installed]
{% endhighlight %}

You can also go ahead and create a build job via the Jenkins UI for one of your Java maven projects (i used [this one](https://github.com/monkeylittle/spring-jpa-inheritance.git)).  A couple of things that I skipped over:

- I used the HTTPS protocol for the git repository to avoid having to add github to the known_hosts file.
- I created the job manually rather than scripting the job creation.
- I need to create equivalent jenkins slave images with tooling installed.

Those are a few follow up tasks I'll get to over the next couple of weeks.
