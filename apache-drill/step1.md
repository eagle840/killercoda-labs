
# Initial Setup


docker run -it --name drill -p 8047:8047 -p 31010:31010 apache/drill

this gives you direct access to the cli

lets check the version:

`SELECT version FROM sys.version;`{{exec}}

there are several example files already installed (sample-data directory), sp lets run a query on one of them

`SELECT * FROM cp.`employee.json` LIMIT 3;`{{exec}}

for the parquet, we'll define the full path

`SELECT * FROM dfs.`opt/drill/sample-data/nation.parquet`;`{{exec}}

[access web gui]({{TRAFFIC_HOST1_8047}})

WIP to quit cli  !quit#

drilluser@202b5e7c2839:/opt/drill/sample-data$ pwd
/opt/drill/sample-data
drilluser@202b5e7c2839:/opt/drill/sample-data$ whoami
drilluser

folder contecnts:

4.0K -rw-r--r-- 1 root root 1.2K Jan  1  1970 nation.parquet
4.0K drwxr-xr-x 2 root root 4.0K Jan  1  1970 nationsMF
4.0K drwxr-xr-x 2 root root 4.0K Jan  1  1970 nationsSF
4.0K -rw-r--r-- 1 root root  455 Jan  1  1970 region.parquet
4.0K drwxr-xr-x 2 root root 4.0K Jan  1  1970 regionsMF
4.0K drwxr-xr-x 2 root root 4.0K Jan  1  1970 regionsSF

click on the 'storage' tab and add plug ins

- TODO
  - setup docker compose with various data sources for Drill
  - may have to setup a k8s for the use of the 2nd vm NO, lets keep it simple
  - put web gui inside a web frame in killercoda


open the query tab.

`SELECT version FROM sys.version;`

`SELECT first_name, last_name FROM cp.`employee.json` LIMIT 1;`



=================================================================
============= delete below

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

