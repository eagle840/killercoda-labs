

first create  a docker-compose.yml file

REPLACE WITH ELASTIC STACK

```
version: '3'

services:
  warehouse:
    image: postgres:13
    container_name: warehouse
    environment:
      POSTGRES_USER: ${WAREHOUSE_USER}
      POSTGRES_PASSWORD: ${WAREHOUSE_PASSWORD}
      POSTGRES_DB: ${WAREHOUSE_DB}
    volumes:
      - ./containers/warehouse:/docker-entrypoint-initdb.d
    healthcheck:
      test: [ "CMD", "pg_isready", "-U", "${WAREHOUSE_USER}" ]
      interval: 5s
      retries: 5
    restart: always
    ports:
      - "5432:5432"
    networks:
      - dev_network

networks:
  dev_network:
    
```


### Setup folder hierache

mkdir containers/warehouse

in here we can config folder

###  add data collector

?fluentd, logstash, or telegraph 
- since logstash comes with ELK, use fluentd?

### add loader

?WHY do we have a seperate src folder for the python, why not add it the the loader build, and then you get rid of the '../..' problem?

this will be the python script that loads the data for sending to the collector


```
  loader:
    image: loader
    container_name: loader
    build:
      context: ./containers/loader/
    volumes:
      - ./:/opt/sde
    environment:
      WAREHOUSE_USER: ${WAREHOUSE_USER}
      WAREHOUSE_PASSWORD: ${WAREHOUSE_PASSWORD}
      WAREHOUSE_DB: ${WAREHOUSE_DB}
      WAREHOUSE_HOST: ${WAREHOUSE_HOST}
      WARREHOUSE_PORT: ${WAREHOUSE_PORT}
    networks:
      - dev_network

```

mkdir /containers/loader

in here 

nano /containers/loader/Dockerfile.yml

! note the workdir, and we need to copy code into this

```
FROM python:3.9.5

# set up location of code
WORKDIR /opt/sde/src/loader

# lets us import from folders inside /src/loader directly
ENV PYTHONPATH=/opt/sde

# install python requirements
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# COPY our code folder to docker
COPY ../.. /opt/sde   # <= this will error out!

# keep our docker container running
CMD ["tail", "-f", "/dev/null"]
```

###  python code to load

!note that the loader build can't use '../..' so errors out


confirm your docker-compose.yml is valid

`docker-compose config`{{exec}}

we'll add the 'env' file to provide env varibles  (don't repo this!)

`docker-compose --env-file env up --build -d`{{exec}}



=============== delete me below ================


# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

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

