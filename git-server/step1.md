
# Initial Setup


create a docker container  w/ host network for server
use docker-compose so you get network and hostnames


1  pwd
    2  cd 
    3  pwd
    4  ls
    5  ll
    6  mkdir .ssh
    7  chmod 700 .ssh/
    8  touch .ssh/authorized_keys
    9  chmod 600 .ssh/authorized_keys 
   10  cd au
   11  cd .ssh/
   12  nano authorized_keys 
   13  ifconfig
   14  ip addr
   15  history

TEST SSH connection client -> server

   mkdir /srv/git
   chown git:git git/  #when in srv folder
   cd git
   mkdir files.git
   cd files.git
   git init --bare

   #once pushed
   git log # should show the files where pushed


   create a docker container w/ host for client

   ssh-keygen -f key1
   # copy key to authorized keys

   once copied you should be able to ssh into server

   once git server up

   create remove <name> with url: git@<host>:/srv/git/files.git

   git push <remotename> <branch>




============================== DELETE BELOW  =================

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

https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

Next we'll update the python files with the new IP address of the docker container.

`RabbitIP=$(docker inspect some-rabbit | jq -r .[0].NetworkSettings.IPAddress)`{{execute}}

`echo $RabbitIP`{{execute}}

`sed -i "s/localhost/$RabbitIP/g" send.py receive.py worker.py new_task.py`{{execute}}

