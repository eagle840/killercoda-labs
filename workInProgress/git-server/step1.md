
# Initial Setup

https://docs.gitea.com/installation/install-with-docker

`cat docker-compose.yml`{{exec}}

`docker-compose up`{{exec}}

connect to 3000


------ delet below??? ----- 
create a docker container  w/ host network for server
use docker-compose so you get network and hostnames



`pwd`{{exec}}

`cd`{{exec}}

`pwd`{{exec}}


`ls`{{exec}}


`ll`{{exec}}


`mkdir .ssh`{{exec}}


`chmod 700 .ssh/`{{exec}}


`touch .ssh/authorized_keys`{{exec}}


`chmod 600 .ssh/authorized_keys`{{exec}}


`cd au`{{exec}}

 `cd .ssh/`{{exec}}

`nano authorized_keys`{{exec}}

`ifconfig`{{exec}}

`ip addr`{{exec}}




TEST SSH connection client -> server

   `mkdir /srv/git`{{exec}}

   `chown git:git git/  #when in srv folder`{{exec}}

   `cd git`{{exec}}

   `mkdir files.git`{{exec}}

   `cd files.git`{{exec}}

   `git init --bare`{{exec}}


   #once pushed
   `git log`{{exec}}
 # should show the files where pushed


   create a docker container w/ host for client

   `ssh-keygen -f key1`{{exec}}

   # copy key to authorized keys

   once copied you should be able to ssh into server

   once git server up

   create remove <name> with url: git@<host>:/srv/git/files.git

   `git push <remotename> <branch>`{{exec}}





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

