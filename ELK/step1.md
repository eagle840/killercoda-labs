
# Initial Setup

`apt update`{{exec}}

`apt install -y net-tools jq tree`{{exec}}

`chmod +x sysloggen.sh`{{exec}}

Boot up the ELK stack:

`docker-compose up -d`{{exec}}

wait for the elasticsearch server to come up, you will get a json response from:

`curl http://localhost:9200`{{exec}}



{{TRAFFIC_HOST1_5601}}/app/home

add 'app/home'

run `docker ps`{{exec}} to review the ports  
 - note ES is on 9200
 - and Kibana is on 5601


Once in the web portal, select 'explore on my own'


open kibana web, > hamburger > Managment > Dev Tools

lets check the health, paste on line 7 `GET _cluster/health`{{copy}} and then the green triangle to run that query.

- take note of the status, number of nodes, and shards

check the stats of the nodes with

`GET _nodes/stats`{{copy}}

## Explore on your own

If you wish to explore Kibana on your own, you can head to the Kibana home page, and 'try sample data'

