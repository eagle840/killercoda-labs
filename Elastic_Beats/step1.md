
# Initial Setup

Boot up the ELK stack:

`docker-compose up -d`{{exec}}

In another tab (+), lets setup some tools/config

`apt update`{{exec}}

`apt install -y net-tools jq tree`{{exec}}

Config linux to download various beats:

`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg`{{exec}}

`sudo apt-get install apt-transport-https`{{exec}}

`echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list`{{exec}}

`sudo apt-get update`{{exec}}



Once the Docker-compose has completed, wait a few minutes for the elasticsearch server to come up, you will get a json response from:

`curl http://localhost:9200`{{exec}}

Now you can open the ES web GUI.



{{TRAFFIC_HOST1_5601}}/app/home



Elasticsearch (ES) offers many different types of BEATS in order to get data into ElasticSearch https://www.elastic.co/beats/

