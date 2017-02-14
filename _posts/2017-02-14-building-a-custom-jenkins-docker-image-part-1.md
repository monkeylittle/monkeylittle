---
layout: post

title: Building a Custom Jenkins Docker Image - Part 1
author: john_turner
banner_image: http://placehold.it/730x300

tags:
- Kubernetes
- Docker
- Jenkins
---

Last week I spent some time learning how to utilize [Kubernetes](https://kubernetes.io/) and [Jenkins](https://jenkins.io/) to form the foundation of a build infrastructure.  I documented some of those learnings in the posts below:

- [Kubernetes Fundamentals]({% post_url 2017-02-06-kubernetes-fundamentals %})
- [Deploying Jenkins with Kubernetes]({% post_url 2017-02-07-deploying-jenkins-with-kubernetes %})
- [Adding Persistent Volumes to Jenkins with Kubernetes]({% post_url 2017-02-08-adding-persistent-volumes-to-jenkins-with-kubernetes-volumes %})
- [Auto-Scaling Jenkins with Kubernetes]({% post_url 2017-02-09-autoscaling-jenkins-with-kubernetes %})

This is a pretty good start but having built out VM based build infrastructure a number of times in the past I'm well aware that there is a long way to go before I have something I can use, manage and maintain.  When working with VM's I've perviously chosen to use [Chef](https://www.chef.io) to manage and maintain the Jenkins master and slave hosts.  Typically, Chef facilitated automation of the installation and configuration of:

- Java
- [Jenkins](https://jenkins.io/)
- Jenkins plugins
- Jenkins jobs (using [JobDSL](https://wiki.jenkins-ci.org/display/JENKINS/Job+DSL+Plugin))
- [Git](https://git-scm.com/)
- [Apache Maven](https://maven.apache.org/)

To achieve the same level of automation with [Docker](https://www.docker.com/) and [Kubernetes](https://kubernetes.io/), I will need to be able to perform all of the above and distribute as a set of Kubernetes resource definition files and Docker image(s).  Before we start doing anything meaningful, I want to disable the setup wizard because, after all, we will be automating the Jenkins setup.  To do this I modify the Kubernetes deployment resource file to specify a JAVA_OPTS environment variable.

<!-- more -->

<div class="card mb-3">
  <div class="card-header">
    jenkins-deployment.yaml
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
          image: jenkins:2.32.2
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

You can test this by creating the Kubernetes deployment and service as described in previous posts.

The next task is to replicate the installation of the recommended Jenkins plugins.  To do this we must build our own docker image but first we will need to setup our local development environment.

Install the docker command line tool:

{% highlight bash %}
brew install docker
{% endhighlight %}

Configure your environment to use the Docker Host provided by minikube:

{% highlight bash %}
eval $(minikube docker-env)
{% endhighlight %}

I will create a working directory in which I'll store source files.  The name is not important but I will call it *docker-library/jenkins*.  This is where I will maintain all my docker images (there's ambition for you!).

In this directory I'll create a Dockerfile.  The first statement I'll add is the *FROM* statement which tells Docker which image my image will be based on.  Naturally I will base my image on the [official Jenkins image](https://hub.docker.com/_/jenkins/).

{% highlight docker %}
from jenkins:2.32.2
{% endhighlight %}

The documentation for the official docker image details how to install additional plugins.  I found this not to work with the latest version of the image but found more recent instructions on the associated github [readme](https://github.com/jenkinsci/docker) which I verified did behave as expected.  I was able to install additional plugins by adding the statement below to the Dockerfile.

{% highlight docker %}
RUN /usr/local/bin/install-plugins.sh docker-slaves plugin-name:plugin-version
{% endhighlight %}

In order to mimic exactly the behavior of the install wizard I wanted to install the recommended plugins, versions and their dependencies.  The wizard retrieves the recommended plugins from a [json file](https://github.com/kohsuke/jenkins/blob/master/core/src/main/resources/jenkins/install/platform-plugins.json) available from the Jenkins GitHub repository.

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
{% endhighlight %}
</div>
</div>

Lets build the docker image specifying the image name and version tag.

{% highlight bash %}
$ docker build -t monkeylittle/jenkins:1.0.0 .
{% endhighlight %}

Learn about what [happens during the build process](https://docs.docker.com/engine/getstarted/step_four/#/step-3-learn-about-the-build-process) by reading the Docker getting started guide.

Verify the image was created and uploaded to the minikube local registry as follows:

{% highlight docker %}
$ docker images
REPOSITORY                                            TAG                 IMAGE ID            CREATED             SIZE
monkeylittle/jenkins                                  1.0.0               443d3e0a31f8        9 minutes ago       712 MB
...
{% endhighlight %}

<strong>It's important that when building the image that a tag is specified.  If not specified Docker will attempt and fail to find the image on [DockerHub](https://hub.docker.com).</strong>

Now that we have our docker image available in the minikube local docker registry we can update our kubernetes deployment resource file to specify our newly created image.

<div class="card mb-3">
  <div class="card-header">
    jenkins-deployment.yaml
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
          image: monkeylittle/jenkins:1.0.0
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

<div class="card mb-3">
  <div class="card-header">
    jenkins-service.yaml
  </div>
  <div class="card-block">
{% highlight yaml %}
apiVersion: v1
kind: Service
metadata:
  name: jenkins
spec:
  type: NodePort
  ports:
    - port: 8080
      targetPort: 8080
  selector:
    app: jenkins
{% endhighlight %}
  </div>
</div>

You can now create the kubernetes deployment (and service) and view the Jenkins UI in a browser to verify the default plugins have been installed.  Next step is to automate the installation of the various required tools.
