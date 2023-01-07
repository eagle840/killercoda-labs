
# Initial Setup

`apt update`{{exec}}

`apt install -y net-tools jq tree`{{exec}}

`chmod +x sysloggen.sh`{{exec}}

Boot up the ELK stack:

`docker-compose up -d`{{exec}}

wait for the elasticsearch server to come up, you will get a json response from:

`curl http://localhost:9200`{{exec}}

Note the version of ElasticSearch.



{{TRAFFIC_HOST1_5601}}/app/home

add 'app/home'

run `docker ps`{{exec}} to review the ports  
 - note ES is on 9200
 - and Kibana is on 5601

## Configure to download beats

`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg`{{exec}}

`sudo apt-get install apt-transport-https`{{exec}}

`echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list`{{exec}}

`sudo apt update`{{exec}}

`sudo apt install metricbeat=8.5.3`{{exec}}



`sudo systemctl start metricbeat`{{exec}}

`sudo systemctl status  metricbeat`{{exec}}

# create a dataview in kibana

`sudo apt install stress`{{exec}}

`nproc`{{exec}}

`free -h`{{exec}}

`stress --cpu 1 --timeout 120`{{exec}}




Once in the web portal, select 'explore on my own'


open kibana web, > hamburger > Managment > Dev Tools

lets check the health, paste on line 7 `GET _cluster/health`{{copy}} and then the green triangle to run that query.

- take note of the status, number of nodes, and shards

check the stats of the nodes with

`GET _nodes/stats`{{copy}}

## Explore on your own

If you wish to explore Kibana on your own, you can head to the Kibana home page, and 'try sample data'

