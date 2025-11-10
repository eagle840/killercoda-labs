

title: Ubuntu Monitoring with Telegraf, InfluxDB, and Grafana
description: Learn how to monitor an Ubuntu system using Telegraf, store metrics in InfluxDB, and visualize them with Grafana.
difficulty: Intermediate
tags: docker, telegraf, influxdb, grafana, monitoring, ubuntu
environment: ubuntu

steps:
  - title: Step 1 - Clone the Lab Repo
    content: |
      We'll start by creating a working directory and downloading the lab files.

      ```bash
      mkdir ~/ubuntu-monitoring && cd ~/ubuntu-monitoring
      ```{{exec}}

      Create a `docker-compose.yml` file:

      ```bash
      nano docker-compose.yml
      ```{{exec}}

      Paste the following content:

      ```yaml
      version: '3.8'
      services:
        influxdb:
          image: influxdb:1.8
          container_name: influxdb
          ports:
            - "8086:8086"
          volumes:
            - influxdb_data:/var/lib/influxdb
          environment:
            - INFLUXDB_DB=telegraf
            - INFLUXDB_ADMIN_USER=admin
            - INFLUXDB_ADMIN_PASSWORD=adminpass

        telegraf:
          image: telegraf:1.29
          user: root
          container_name: telegraf
          depends_on:
            - influxdb
          volumes:
            - ./telegraf.conf:/etc/telegraf/telegraf.conf:ro
            - /var/run/docker.sock:/var/run/docker.sock
            - /proc:/host/proc:ro
            - /sys:/host/sys:ro
            - /:/hostfs:ro
            - /var/log:/host/var/log:ro
          network_mode: host

        grafana:
          image: grafana/grafana
          container_name: grafana
          ports:
            - "3000:3000"
          depends_on:
            - influxdb
          volumes:
            - grafana_data:/var/lib/grafana

      volumes:
        influxdb_data:
        grafana_data:
      ```{{copy}}

  - title: Step 2 - Configure Telegraf
    content: |
      Create the Telegraf config file:

      ```bash
      nano telegraf.conf
      ```{{exec}}

      Paste the following:

      ```toml
[agent]
  interval = "10s"
  round_interval = true
  metric_batch_size = 1000
  metric_buffer_limit = 10000
  collection_jitter = "0s"
  flush_interval = "10s"
  flush_jitter = "0s"
  hostname = "ubuntu-host"
  omit_hostname = false

# System metrics
[[inputs.cpu]]
  percpu = true
  totalcpu = true
  report_active = true

[[inputs.mem]]
[[inputs.disk]]
[[inputs.diskio]]
[[inputs.system]]
[[inputs.net]]
[[inputs.processes]]
[[inputs.kernel]]

# Journal logs via exec
[[inputs.exec]]
  commands = ["journalctl -n 100 -o short"]
  timeout = "5s"
  data_format = "grok"
  name_override = "journal"
  [inputs.exec.grok]
    patterns = ["%{GREEDYDATA:message}"]
    measurement = "journal_logs"
    timezone = "UTC"

# Output to InfluxDB
[[outputs.influxdb]]
  urls = ["http://localhost:8086"]
  database = "telegraf"
  username = "admin"
  password = "adminpass"
      ```{{copy}}

  - title: Step 3 - Launch the Stack
    content: |
      Start the monitoring stack:

      ```bash
      docker-compose up -d
      ```{{exec}}

      Confirm containers are running:

      ```bash
      docker ps
      ```{{exec}}

  - title: Step 4 - Check InfluxDB for Data
    content: |
      Run this to list measurements:

      ```bash
      docker exec influxdb influx -database telegraf -execute 'SHOW MEASUREMENTS'
      ```{{exec}}

      You should see output like:

      ```
      name: measurements
      ------------------
      cpu
      mem
      disk
      syslog
      ```

      To query data:

      ```bash
      docker exec influxdb influx -database telegraf -execute 'SELECT * FROM cpu LIMIT 5'
      ```{{exec}}

  - title: Step 5 - Access Grafana
    content: |
      Open Grafana in your browser:

      ```
      http://localhost:3000
      ```

      Login with:
      - Username: `admin`
      - Password: `admin`

      Add a new data source:
      - Type: InfluxDB
      - URL: `http://influxdb:8086`
      - Database: `telegraf`
      - User: `admin`
      - Password: `adminpass`

      Create a dashboard using a query like:

      ```sql
      SELECT mean("usage_idle") FROM "cpu" WHERE $timeFilter GROUP BY time($__interval) fill(null)
      ```{{copy}}

      Select 'FROM' -> cpu
      select 'SELECT -> usage_active

  - title: Step 6 - Explore and Extend
    content: |
      Try adding more inputs to Telegraf like Docker stats or journal logs.

      You can also simulate load with:

      ```bash
      stress --cpu 2 --timeout 30
      ```{{exec}}

      Then watch Grafana update in real time.

      🎉 You've built a full monitoring pipeline!



---

# DELETE BELOW

## Initial Setup


WIP:
- should I be using v3?
- provide examples of different way to enter data
  - csv
  - lineprotocol
  - cli
  - client (pytho)
  - telegraf ()

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

## Local install

https://docs.influxdata.com/influxdb/v2/install/?t=Linux

```
# Ubuntu and Debian
# Add the InfluxData key to verify downloads and add the repository
curl --silent --location -O https://repos.influxdata.com/influxdata-archive.key
echo "943666881a1b8d9b849b74caebf02d3465d6beb716510d86a39f6c8e8dac7515  influxdata-archive.key" | sha256sum --check - && cat influxdata-archive.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive.gpg > /dev/null && echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
```{{exec}}


```
# Install influxdb
sudo apt-get update && sudo apt-get install influxdb2
```{{exec}}

`sudo service influxdb start`{{exec}}

`sudo service influxdb status`{{exec}}

`influxd -h`{{exec}}

{{TRAFFIC_HOST1_8086}}

user: `dbadmn`

pw: `dbadmin123`

Org: `MyOrg`

Bucket: `BUCKET_ONE`

copy the key down.

And select **QUICK START**



## Connecting

Lets set some environment variables:

`export INFLUX_ORG="your-org-name"`{{copy}}


`export INFLUX_TOKEN="your-api-token"`{{copy}}

#### Cli

In a new tab `influx config ls`{{exec}}


#### Http API

create a token https://docs.influxdata.com/influxdb/v2/admin/tokens/create-token/

HTTP API:  https://docs.influxdata.com/influxdb/v2/reference/api/

In the portal, LHS click the UP arrow, and API tokens

Generate a new all access token. (make sure to copy it down)




```bash
#######################################
# Use a token in the Authorization header
# to authenticate with the InfluxDB 2.x API.
#######################################

curl --get "http://localhost:8086/api/v2" \
  --header "Authorization: Token $INFLUX_TOKEN" \
  --header 'Content-type: application/json' \
  --data-urlencode "db=BUCKET_ONE" \
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

Before starting, besure you're completed the Quickstart in the GUI

`influx v1 shell -t $INFLUX_TOKEN`{{exec}}

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

--- ## install Influx with docker

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


`docker exec -it influxdb2 influx v1 shell`{{exec}}

---

## Load sample data

We'll ne using samples from:  https://docs.influxdata.com/influxdb/cloud/reference/sample-data/


Find he USGS data

https://earthquake.usgs.gov/earthquakes/map/ (https://www.usgs.gov/data/latest-earthquakes-map-and-list)


In the UI, click on the calender Icon on the left

Top right click 'create task' > 'New task'

Give it a name

Paste the task in, be sure to change the bucket name to 'BUCKET_ONE'

The CRON settings don't matter at this point

Save

Now in the Task, on the right, click the cog, and select 'run'

