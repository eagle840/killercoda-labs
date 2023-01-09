
# Initial Setup

Boot up the ELK stack:

`docker-compose up -d`{{exec}}

In another tab, lets setup some tools/config

`apt update`{{exec}}

`apt install -y net-tools jq tree`{{exec}}

Config to download various beats:

`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg`{{exec}}

`sudo apt-get install apt-transport-https`{{exec}}

`echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list`{{exec}}

`sudo apt-get update`{{exec}}



Once the Docker-compose has completed, wait a few minutes for the elasticsearch server to come up, you will get a json response from:

`curl http://localhost:9200`{{exec}}

`curl http://localhost:9200/_cluster/health`{{exec}}



{{TRAFFIC_HOST1_5601}}/app/home



run `docker ps`{{exec}} to review the ports  
 - note ES is on 9200
 - and Kibana is on 5601


Once in the web portal, select 'explore on my own'


open kibana web, > hamburger > Managment > Dev Tools

lets check the health, paste on line 7 `GET _cluster/health`{{copy}} and then the green triangle to run that query.

- take note of the status, number of nodes, and shards


## Explore on your own

If you wish to explore Kibana on your own, you can head to the Kibana home page, and 'try sample data'

