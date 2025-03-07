
## Initial Setup

Sure! Here are some popular time series databases:

Also see: https://killercoda.com/influxdata/course/Training/influxdb-roadshow-training

https://db-engines.com/en/system/InfluxDB

**InfluxDB** is a highly scalable, open-source time series database designed for real-time analytics, monitoring, and IoT applications. It supports SQL-like queries through InfluxQL and its own scripting language, Flux.

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
 --env DOCKER_INFLUXDB_INIT_BUCKET=BUCKET_ONE \
 influxdb:2
```exec

## Connecting

#### Cli

In a new tab `docker exec -it influxdb2 influx config ls`{{exec}}

#### UI portal

login:  un:dbadmin   PW: dbadmin123

{{TRAFFIC_HOST1_8086}}


## Load sample data

We'll ne using samples from:  https://docs.influxdata.com/influxdb/cloud/reference/sample-data/

In the UI, click on the calender Icon on the left

Top right click 'create task' > 'New task'

Give it a name

Paste the task in, be sure to change the bucket name to 'BUCKET_ONE'

The CRON settings don't matter at this point

Save

Now in the Task, on the right, click the cog, and select 'run'






#### Http API

create a token https://docs.influxdata.com/influxdb/v2/admin/tokens/create-token/

In the portal, LHS click the UP arrow, and API tokens

Generate a new all access token. (make sure to copy it down)


`API_TOKEN="insert  token"{{copy}}



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

```
curl --get "http://localhost:8086/api/v2" \
  --header {$API_TOKEN} \
  --header 'Content-type: application/json' \
  --data-urlencode "db=mydb" \
  --data-urlencode "q=SELECT * FROM cpu_usage"
```
## Actions

`docker exec -it influxdb2 influx v1 shell`{{exec}}

make sure you're in the influx shell **>**

`show databases`{{copy}

WIP doesn't wor; so use BUCKET_ONE`create database newdatabase`{{copy}}

`show databases`{{copy}}

WIP `use newdatabase`{{copy}}

`use BUCKET_ONE`{{copy}}

`show measurements`{{copy}}

`insert cpu, host=node1 value=10`{{copy}}

`show measurements`{{copy}}

`select * from cpu`{{copy}}

Note that the system has added a timestamp.

`drop measurement cpu`{{copy}}

`show measurements`{{copy}}

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

`select * from cpu where host='node'`{{copy}}

For a time range

`select * from cpu where time >= now() - 5m`{{copy}}


## Install Telegraf


https://influxdata.com/time-series-platform/telegraf/


```
# influxdata-archive_compat.key GPG fingerprint:
#     9D53 9D90 D332 8DC7 D6C8 D3B9 D8FF 8E1F 7DF8 B07E
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list

sudo apt-get update && sudo apt-get install telegraf
```{{exec}}


See https://docs.influxdata.com/telegraf/v1/


https://docs.influxdata.com/telegraf/v1/get-started/

create a sample config

`telegraf --sample-config > telegraf.conf`{{exec}}  =>  /etc/telegraf/telegraf.conf

set the  InfluxDB URL in the config

`telegraf --sample-config --input-filter cpu:mem --output-filter influxdb_v2 > telegraf.conf`{{exec}}
