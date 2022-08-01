
# Initial Setup

`apt update`{{exec}}

`apt install -y net-tools jq tree`{{exec}}

`chmod +x sysloggen.sh`{{exec}}



`docker-compose up -d`{{exec}}

{{TRAFFIC_HOST1_5601/app/home}}

run `docker ps`{{exec}} to review the ports  
 - note ES is on 9200
 - and Kibana is on 5601

`curl http://localhost:9200`{{exec}}

note the name, cluster name, and cluster id

To access directly

run `bin/elasticsearch` with docker exec

run `bin/kibana`


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

