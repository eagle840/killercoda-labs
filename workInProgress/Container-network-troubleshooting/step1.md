
# Initial Setup

# SET TO A k8S image

`apt update`{{exec}}

`apt install -y net-tools jq tree`{{exec}}

`chmod +x sysloggen.sh`{{exec}}


`docker-compose up -d`{{exec}}

wait until you get a json responce

`curl http://localhost:9200`{{exec}}

Orginally this link failed:

{{TRAFFIC_HOST1_5601}}

can curl shows no output
 

but curl -L does

research shows I show used the following URL

{{TRAFFIC_HOST1_5601}}/app/home  

add 'app/home'


Let list of the services for docker-compose

`docker-compose ps`{{exec}}

and look at the network

`docker network list`{{exec}}

more on network: https://docs.docker.com/network/bridge/

each service name is a dns entry in docker-compose network

https://hub.docker.com/r/nicolaka/netshoot

lets connect the container to the network:

`docker run -it --net root_elk nicolaka/netshoot`{{exec}}

`curl -L `

`cat /etc/resolv.conf`

dns server appears to be 127.0.0.11



## connect directly to a container

`docker ps`{{exec}}

- replace the container number for kibana

`docker run -it --net container:c8e17c9f68f4  nicolaka/netshoot`

`iftop`{{exec}}

you'll see coms with ES

now look at kibana web page (refresh), and see the traffic


====

rename cluster


=====


Once in the web portal, select 'explore on my own'


open kibana web, > hamburger > Managment > Dev Tools

lets check the health, paste in `GET _cluster/health`{{copy}}

- take note of the status, number of nodes, and shards

check the stats of the nodes with

`GET _nodes/stats`{{copy}}




#################  DELETE BELOW WHEN READY  #######################



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


`sed -i "s/localhost/$RabbitIP/g" send.py receive.py worker.py new_task.py`{{execute}}

