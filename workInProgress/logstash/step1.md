
## Initial Setup

Boot up the ES and kibana

`docker-compose up -d`{{exec}}

In another tab, lets setup some tools/config

`apt update`{{exec}}

`apt install -y net-tools jq tree`{{exec}}

## Install Logstash

Config APT to download logstash, note that it's important to use the same version of logstash as elastricsearch.

See https://www.elastic.co/guide/en/logstash/7.17/installing-logstash.html#_apt for more info

`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg`{{exec}}

`sudo apt-get install apt-transport-https`{{exec}}

`echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list`{{exec}}

`sudo apt-get update`{{exec}}

And install Logstash

`apt-get install logstash`{{exec}}

`PATH=$PATH:/usr/share/logstash/bin`{{exec}}

[See the elastic site for getting started](https://www.elastic.co/guide/en/logstash/7.17/first-event.html)

review the main config file:

`ls /etc/logstash/`{{exec}}

and list out the available binaries:

`ls /usr/share/logstash/bin`{{exec}}

`/usr/share/logstash/bin/logstash -h`{{exec}}


## Check Elastic Stack is running.

Once the Docker-compose has completed, wait a few minutes for the elasticsearch server to come up, you will get a json response from:

`curl http://localhost:9200`{{exec}}


{{TRAFFIC_HOST1_5601}}/app/home


## Run a basic logstash test


start logstash

`/usr/share/logstash/bin/logstash -e 'input { stdin { } } output { stdout {} }'`{{exec}}

After starting Logstash, wait until you see "Pipeline main started" and then enter hello world at the command prompt and note the json element outputed.

Note the json output that logstash has generated.

ctrl-d to exit



