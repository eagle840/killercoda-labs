
# Initial Setup


WIP  from: https://hub.docker.com/r/bitnami/wildfly
```sh
docker run -p 8080:8080 -p 9990:9990 \
    -v /path/to/wildfly-persistence:/bitnami/wildfly \
    bitnami/wildfly:latest
```{{copy}}

use (you need to fix the storage):
```sh
docker run -p 8080:8080 -p 9990:9990 \
    -e WILDFLY_PASSWORD=nick1234!  \
    bitnami/wildfly:latest
```{{copy}}


```sh
docker run -p 8080:8080 -p 9990:9990  -e WILDFLY_USERNAME=nick -e WILDFLY_PASSWORD=nick1234!        bitnami/wildfly:latest /opt/bitnami/wildfly/bin/standalone.sh -bmanagement=0.0.0.0 -b 0.0.0.0
```{{exec}}

WIP un/pw not working

see http://www.mastertheboss.com/jbossas/jboss-configuration/how-to-bind-wildfly-to-an-ip-address/
for a possible solution

use   /opt/bitnami/wildfly/bin



`apt update`{{exec}}

For wildfly we can just use the jvm:
 
`apt install -y default-jre`{{copy}}

but the sdk gives us more feature

`apt install -y openjdk-11-jdk`{{exec}}

`java -version`{{exec}}

`apt install -y maven`{{exec}}

`mvn --version`{{exec}}

`ls -lash /usr/lib/jvm/`{{exec}}

### set java environment

locate /usr/lib/jvm/java-1.x.x-openjdk

 `vim /etc/profile`{{exec}}

Prepend sudo if logged in as not-privileged user, ie. sudo vim

Press 'i' to get in insert mode
add:

export JAVA_HOME="path that you found"

export PATH=$JAVA_HOME/bin:$PATH
Reboot your system, and voila

`export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64/"`{{copy}}

`export PATH=$JAVA_HOME/bin:$PATH`{{exec}}

`exec bash`{{exec}}

`echo $PATH`{{exec}}

WIP CONFIRM THIS 

 

from https://www.wildfly.org/downloads/

`cd ~`{{exec}}

`wget https://download.jboss.org/wildfly/22.0.1.Final/wildfly-22.0.1.Final.tar.gz`{{exec}}

`tar -xvf wildfly-22.0.1.Final.tar.gz `{{exec}}

`mv wildfly-22.0.1.Final /usr/local/`{{exec}}

`cd /usr/local/wildfly-22.0.1.Final/`{{exec}}

`ls`{{exec}}

note standalone folder vs domain (cluster) folder

`cd standalone/configuration/`{{exec}}

change all the 127.0.0.1 to 0.0.0.0 

`nano standalone.xml `{{exec}}

confirm with:

`cat standalone.xml | grep 127.0.0.1`{{exec}}

`cd ../../bin`{{exec}}

add a user:

WIP LEAVE OUT THIS RUN

`sh add-user.sh`{{exec}}

start the server:

`sh standalone.sh`{{exec}}

last log item should be

'Admin console listening on http://127.0.0.1:9990' ? 0.0.0.0

front page: {{TRAFFIC_HOST1_8080}}

management page: {{TRAFFIC_HOST1_9990}}

WIP why is the console no content?

`curl -v localhost:9990/console/index.html`{{exec}}

### for cli

`cd /usr/local/wildfly-22.0.0.Final/bin`{{exec}}

`sh jboss-cli.sh`{{exec}}

The cli is based on a file/directory type structure, where each individual item (~file) is 'key=value'.

List the structure with 'ls' and change dirctory with 'cd'

If you're running wildfly on an graphical OS, you can use a graphical interface

`sh jconsole.sh`{{copy}}

https://www.eclipse.org/openj9/docs/tool_jps/



================== delete below  ====================

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# docker update

`apt-get remove docker  docker.io containerd runc -y`{{exec}}   

`apt-get update`{{exec}}   

`apt-get install ca-certificates curl gnupg  lsb-release -y`{{exec}}   

`mkdir -p /etc/apt/keyrings`{{exec}}   

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`{{exec}}   

```
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```{{exec}}   

`apt-get update`{{exec}}   

`apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y `{{exec}}   

`docker version`{{exec}}   

`docker-compose version`{{exec}}   

`docker compose version`{{exec}}

# Set imageid in index.json

- ubuntu: Ubuntu 20.04 with Docker and Podman
= kubernetes-kubeadm-2nodes: 
- kubernetes-kubeadm-1node:

to taint the control node for work:

```
kubectl taint nodes controlplane node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-
```


# Copy Files/adjust index

text here

# Run apt update

apt-get update -y{{execute}}

```apt-get update -y{{execute}}```


# For links to ports:

```
Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_80}}
Link for traffic into host 2 on port 4444
{{TRAFFIC_HOST2_4444}}
Link for traffic into host X on port Y
{{TRAFFIC_HOSTX_Y}}
```


# Example setup for postgres with raw data

git clone https://github.com/josephmachado/simple_dbt_project.git

- raw folders
- warehouse setup
- docker postgres and -v to those folders


We'll be using the rabbitmq container with the management feature installed.

https://hub.docker.com/_/rabbitmq

`docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 rabbitmq:3-management`{{execute}}

make sure it started

`docker ps`{{execute}}

and check the config file

`docker exec some-rabbit cat /etc/rabbitmq/rabbitmq.conf`{{execute}}

and head over to port 8080 and login   
un:guest   
pw:guest  


Next we'll update the python files with the new IP address of the docker container.

`RabbitIP=$(docker inspect some-rabbit | jq -r .[0].NetworkSettings.IPAddress)`{{execute}}

`echo $RabbitIP`{{execute}}

`sed -i "s/localhost/$RabbitIP/g" send.py receive.py worker.py new_task.py`{{execute}}

## k8s port-forward

`k -n <ns> port-forward service/<svc-name> 9090:9090 --address 0.0.0.0`

- this is to forword a CLusterIP so that killacoda can access


`echo 'PATH=$PATH':$(pwd)/bin >> /root/.bashrc`{{copy}}

export PATH=$PWD/bin:$PATH

to allow pods on the controlplane

`kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-`{{copy}}

to allow access to running pods with ports 9000 and 9090

`kubectl port-forward -n minio-dev pod/minio 9000 9090 --address 0.0.0.0`{{copy}}

