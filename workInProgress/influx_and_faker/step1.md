
## Initial Setup

Sure! Here are some popular time series databases:

https://db-engines.com/en/system/InfluxDB

**InfluxDB** is a highly scalable, open-source time series database designed for real-time analytics, monitoring, and IoT applications¹(https://www.trustradius.com/time-series-databases)²(https://www.timescale.com/learn/the-best-time-series-databases-compared). It supports SQL-like queries through InfluxQL and its own scripting language, Flux²(https://www.timescale.com/learn/the-best-time-series-databases-compared).

## Comparison of **InfluxDB** and **Prometheus**:

- **Purpose**: InfluxDB is a time series database for analytics and monitoring; Prometheus is a monitoring and alerting toolkit.
- **Data Collection**: InfluxDB uses a push model; Prometheus uses a pull model.
- **Query Language**: InfluxDB supports InfluxQL and Flux; Prometheus uses PromQL.
- **Storage**: InfluxDB offers scalable, cloud-native options; Prometheus uses efficient local storage and supports federation.
- **Visualization**: Both are often paired with Grafana for advanced dashboards.

Both are great for monitoring, but your choice depends on your specific needs.


# list of programs

## Fakerjs

a js program

- Generate massive amounts of fake data in the browser and node.js
- https://fakerjs.dev/
- https://github.com/faker-js/faker

## Flog

- A fake log generator for common log formats
- https://github.com/mingrammer/flog
- https://github.com/swimlane/soc-faker
- https://library.mosse-institute.com/articles/2022/10/generating-logs-of-analysis-using-soc-faker-part-1.html


## soc-faker

- A python package for use in generating fake data for SOC and security automation.
-

--- old lab - DELETE

Boot up the ES and kibana

`docker-compose up -d`{{exec}}

In another tab, lets setup some tools/config

`apt update`{{exec}}

`apt install -y net-tools jq tree`{{exec}}



## install Influx with docker

https://docs.influxdata.com/influxdb/v2/install/?t=Docker

```bash
docker run \
 --name influxdb2 \
 --publish 8086:8086 \
 --mount type=volume,source=influxdb2-data,target=/var/lib/influxdb2 \
 --mount type=volume,source=influxdb2-config,target=/etc/influxdb2 \
 --env DOCKER_INFLUXDB_INIT_MODE=setup \
 --env DOCKER_INFLUXDB_INIT_USERNAME=dbadmin \
 --env DOCKER_INFLUXDB_INIT_PASSWORD=dbadmin123 \
 --env DOCKER_INFLUXDB_INIT_ORG=MyOrg \
 --env DOCKER_INFLUXDB_INIT_BUCKET=BUCKET_NAME \
 influxdb:2
```

## Connecting

### Cli

In a new tab `docker exec -it influxdb2 influx config ls`{{exec}}

### UI portal

{{TRAFFIC_HOST1_5601}}

### Http API

create a token https://docs.influxdata.com/influxdb/v2/admin/tokens/create-token/

```bash
#######################################
# Use a token in the Authorization header
# to authenticate with the InfluxDB 2.x API.
#######################################

curl --get "http://localhost:8086/api/v2" \
  --header "Authorization: Token YOUR_API_TOKEN" \
  --header 'Content-type: application/json' \
  --data-urlencode "db=mydb" \
  --data-urlencode "q=SELECT * FROM cpu_usage"
```


## Actions

`docker exec -it influxdb2 influx v1 shell`{{exec}}

make sure you're in the influx shell **>**

`show databases`{{exec}}

`create database newdatabase`{{exec}}

`show databases`{{exec}}

`user newdatabase`{{exec}}

`show measurements`{{exec}}

`insert cpu, host=node1 value=10`{{exec}}

`show measurements`{{exec}}

`select * from cpu`{{exec}}

Note that the system has added a timestamp.

`drop measurement cpu`

`show measurements`{{exec}}

## UI

https://www.youtube.com/watch?v=XloH_0G2IzA

buckets = a database (with a retention policy)
```
insert cpu, host=node1 value=10
insert cpu, host=node2 value=15
insert cpu, host=node3 value=22
```{{exec}}

`show series`{{exec}}

Host is the tag for the nodes

`select * from cpu where host='node'`{{exec}}

For a time range

`select * from cpu where time >= now() - 5m`
---



Delete below?


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
