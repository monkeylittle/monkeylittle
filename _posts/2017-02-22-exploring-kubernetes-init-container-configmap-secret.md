---
layout: post

title: Exploring Kubernetes Init Container, ConfigMap & Secrets
author: john_turner
banner_image: http://placehold.it/730x300

tags:
- Kubernetes
- Docker
- Jenkins
---

At the end of my last post I had created a docker image for Jenkins that extended the official docker image by disabling the setup wizard, installing the default plugins and installing maven.  I skipped over:

- setting up ssh for GitHub.
- automating the configuration of the Jenkins job(s).
- creating appropriate Jenkins slave images.

In this post I'll set up SSH for GitHub.

## Setting Up SSH for GitHub

To set up SSH for GitHub I created a ConfigMap containing the ssh config.  I did this by creating the ConfigMap from a file.

<div class="card mb-3">
  <div class="card-header">
    .ssh/config
  </div>
  <div class="card-block">
{% highlight plaintext %}
Host github.com
    HostName ssh.github.com
    Port 443
    User git
    IdentityFile ~/.ssh/id_jenkins_rsa
{% endhighlight %}
  </div>
</div>

{% highlight bash %}
kubectl create configmap jenkins-ssh-config --from-file=.ssh/config
{% endhighlight %}

The SSH config specifies the identity to use as *~/.ssh/id_jenkins_rsa*.  As the private key is something I want to secure, I will generate the key and store it as a Kubernetes secret.  First, follow the instructions on GitHub to [generate a new ssh key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and [add it to your Github account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account).  Then you can store the private and public key as a Kubernetes secret.

{% highlight bash %}
kubectl create secret generic jenkins-ssh-key --from-file=id_jenkins_rsa=.ssh/id_jenkins_rsa --from-file=id_jenkins_rsa.pub=.ssh/id_jenkins_rsa.pub
{% endhighlight %}

Now that we have made the SSH config and keys available to Kubernetes we need to configure the Jenkins container.  I've done this using the Kubernetes Init Container feature which is in beta as of version 1.5.

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
      annotations:
        pod.beta.kubernetes.io/init-containers: '[
          {
            "name": "ssh-config",
            "image": "monkeylittle/jenkins:1.0.0",
            "imagePullPolicy": "IfNotPresent",
            "command": ["bash", "-c", "
              while [ ! -e /var/jenkins_home/ssh_config -o ! -e /var/jenkins_home/ssh_key ]; do sleep 1; done;\n
              mkdir -p /var/jenkins_home/.ssh\n
              cp /var/jenkins_home/ssh_config/* /var/jenkins_home/.ssh/\n
              cp /var/jenkins_home/ssh_key/* /var/jenkins_home/.ssh/\n
              chmod 400 /var/jenkins_home/.ssh/id_jenkins*\n
              ssh-keyscan github.com >> /var/jenkins_home/.ssh/known_hosts\n
              ssh-keyscan ssh.github.com >> /var/jenkins_home/.ssh/known_hosts
            "],
            "volumeMounts": [
              {
                "name": "jenkins-home",
                "mountPath": "/var/jenkins_home"
              },
              {
                "name": "jenkins-ssh-config",
                "mountPath": "/var/jenkins_home/ssh_config"
              },
              {
                "name": "jenkins-ssh-key",
                "mountPath": "/var/jenkins_home/ssh_key"
              }
            ]
          }
        ]'

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
        - name: jenkins-ssh-config
          configMap:
            name: jenkins-ssh-config
        - name: jenkins-ssh-key
          secret:
            secretName: jenkins-ssh-key
        - name: jenkins-home
          emptyDir: {}
{% endhighlight %}
  </div>
</div>

I have defined 3 volumes as part of the deployment.  The first populates the the volume with the contents of the jenkins-ssh-config ConfigMap, the second with the contents of the jenkins-ssh-key Secret and the third is the Jenkins home directory.

I have also defined an Init Container that:

- mounts all 3 volumes.
- copies the contents of jenkins-ssh-config to /var/jenkins_home/.ssh
- copies the contents of jenkins-ssh-key to /var/jenkins_home/.ssh
- changes the permissions of the Jenkins ssh keys to those allowed by the git client.
- generates the ssh known_hosts file.

*One thing of note (and this may be related to minikube itself) but the volumes may or may not be mounted at the start of the command so I needed to insert a statement tat waits until the jenkins-ssh-config and jenkins-ssh-key volumes are mounted before executing the remainder of the script.*
