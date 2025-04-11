
{{TRAFFIC_HOST1_8086}}


user name  `dbadmin`

password `dbadmin123`

bucket name: `BUCKET_ONE`

## Test db


https://docs.influxdata.com/influxdb/v2/get-started/write/?t=influx+CLI

`docker exec -it influxdb2 bash`{{exec}}

Inside docker:

`export INFLUX_ORG="your-org-name"`{{copy}}


`export INFLUX_TOKEN="your-api-token"`{{copy}}


`influx version`{{exec}}

`influx --help`{{exec}}

`influx config ls`{{exec}}

`influx server-config`{{exec}}


`influx bucket create --name get-started`{{exec}}

`influx bucket create --name get-started  --org MyOrg -t API-TOKEN`{{copy}}

`influx bucket list`{{exec}}

```
influx write \
  --bucket get-started \
  --precision s "
home,room=Living\ Room temp=21.1,hum=35.9,co=0i 1641024000
home,room=Kitchen temp=21.0,hum=35.9,co=0i 1641024000
home,room=Living\ Room temp=21.4,hum=35.9,co=0i 1641027600
home,room=Kitchen temp=23.0,hum=36.2,co=0i 1641027600
home,room=Living\ Room temp=21.8,hum=36.0,co=0i 1641031200
home,room=Kitchen temp=22.7,hum=36.1,co=0i 1641031200
home,room=Living\ Room temp=22.2,hum=36.0,co=0i 1641034800
home,room=Kitchen temp=22.4,hum=36.0,co=0i 1641034800
home,room=Living\ Room temp=22.2,hum=35.9,co=0i 1641038400
home,room=Kitchen temp=22.5,hum=36.0,co=0i 1641038400
home,room=Living\ Room temp=22.4,hum=36.0,co=0i 1641042000
home,room=Kitchen temp=22.8,hum=36.5,co=1i 1641042000
home,room=Living\ Room temp=22.3,hum=36.1,co=0i 1641045600
home,room=Kitchen temp=22.8,hum=36.3,co=1i 1641045600
home,room=Living\ Room temp=22.3,hum=36.1,co=1i 1641049200
home,room=Kitchen temp=22.7,hum=36.2,co=3i 1641049200
home,room=Living\ Room temp=22.4,hum=36.0,co=4i 1641052800
home,room=Kitchen temp=22.4,hum=36.0,co=7i 1641052800
home,room=Living\ Room temp=22.6,hum=35.9,co=5i 1641056400
home,room=Kitchen temp=22.7,hum=36.0,co=9i 1641056400
home,room=Living\ Room temp=22.8,hum=36.2,co=9i 1641060000
home,room=Kitchen temp=23.3,hum=36.9,co=18i 1641060000
home,room=Living\ Room temp=22.5,hum=36.3,co=14i 1641063600
home,room=Kitchen temp=23.1,hum=36.6,co=22i 1641063600
home,room=Living\ Room temp=22.2,hum=36.4,co=17i 1641067200
home,room=Kitchen temp=22.7,hum=36.5,co=26i 1641067200
"
```{{exec}}

## query

https://docs.influxdata.com/influxdb/v2/get-started/query/?t=influx+CLI


**influx query**



```
influx query '
from(bucket: "get-started")
    |> range(start: 2022-01-01T08:00:00Z, stop: 2022-01-01T20:00:01Z)
    |> filter(fn: (r) => r._measurement == "home")
    |> filter(fn: (r) => r._field== "co" or r._field == "hum" or r._field == "temp")
'
```{{exec}}

**InfluxQL**

First enter the shell
`influx v1 shell`{{exec}}

```
SELECT co,hum,temp,room FROM "get-started".autogen.home WHERE time >= '2022-01-01T08:00:00Z' AND time <= '2022-01-01T20:00:00Z'
```{{exec}}

**ESC** and 'exit'

### GUI

Select the 'get-started` bucket and set the custom time range to over the 2022-01-01 00:01 to 2022-01-02 00:01

Select 'home'
set Table type
click `submey




# Populate db with sample data.

WIP: would it be better to use the Air Sample data, since there would be trends (for FB prophet)?

See: https://docs.influxdata.com/influxdb/cloud/reference/sample-data/#usgs-earthquake-data

Note that we have changed the bucket name in the script below.

Lets populate the db with some data that is live.

Open the GUI, and click the calendar icon on the left.

Create a new task, and run now. You should see success in the logs.

```
import "influxdata/influxdb/sample"

option task = {name: "earthquake", every: 1h}

sample.data(set: "usgs")
    |> to(bucket: "BUCKET_ONE")

```{{copy}}

## view

Click the graph icon

select 'earthquake', the 'depth'.
select 'Table' in top left.
select 'view raw data' in center.
selecr `past 24h` in time selector
click `SUBMIT`




---

# flog


## nstall go

from https://go.dev/doc/install

`rm -rf /usr/local/go`{{exec}}

`wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz`{{exec}}

`tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz`{{exec}}

`export PATH=$PATH:/usr/local/go/bin`{{exec}}


`go version`{{exec}}

--- remove below



# Logstash architecture over view


her is the the general pipeline:
- input filer, [full list](https://www.elastic.co/guide/en/logstash/7.17/input-plugins.html).
- queue
- filter (data manipulation)   [full list](https://www.elastic.co/guide/en/logstash/7.17/output-plugins.html)
- output, [full list](https://www.elastic.co/guide/en/logstash/7.17/output-plugins.html)
# Forward a log file to logstash


Lets download some sample logs:

(for a large selection of logs, try https://github.com/logpai/loghub)


`wget https://download.elastic.co/demos/logstash/gettingstarted/logstash-tutorial.log.gz`{{exec}}
   
`gzip -d logstash-tutorial.log.gz`{{exec}}

`tail logstash-tutorial.log `{{exec}}

WIP replace filebeat with:

`logstash -e 'input { stdin { } } output { stdout {} }' < logstash-tutorial.log`{{exec}}

WIP now add a filter

`apt install filebeat`{{copy}}

`ls /usr/share/filebeat/bin`{{copy}}

`filebeat -h`{{copy}}



## Add a GROK filter

we'll add a filter to the logstash cmd:

```
filter { grok { match =>  { "message" => "%{COMBINEDAPACHELOG}"}   } }
```

this will tke the 'message' value, and return a json objects for each message.

`logstash -e 'input { stdin { } } filter { grok { match =>  { "message" => "%{COMBINEDAPACHELOG}"}   } } output { stdout {} }' < logstash-tutorial.log`{{exec}}


## Use the ES grok debugger

Goto the web GUI, dev tools, grok debugger

Paste the raw message into the 'sample data'

```
198.46.149.143 - - [04/Jan/2015:05:29:13 +0000] "GET /blog/geekery/disabling-battery-in-ubuntu-vms.html?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+semicomplete%2Fmain+%28semicomplete.com+-+Jordan+Sissel%29 HTTP/1.1" 200 9316 "-" "Tiny Tiny RSS/1.11 (http://tt-rss.org/)"
```


And then the grok pattern

`%{COMBINEDAPACHELOG}`

and the debugger simulator will convert the message to a json object

## Forward to Elasticsearch

We now use the elasticsearch plugin to send that data to ES https://www.elastic.co/guide/en/logstash/7.17/plugins-outputs-elasticsearch.html#plugins-outputs-elasticsearch

`logstash -e 'input { stdin { } } filter { grok { match =>  { "message" => "%{COMBINEDAPACHELOG}"}   } } output { elasticsearch { hosts => "localhost:9200" } }' < logstash-tutorial.log`{{exec}}




grok patterns for elastic: https://github.com/elastic/elasticsearch/tree/main/libs/grok/src/main/resources/patterns


## Use logstash with a config file


typical output:

`nano first-pipeline.conf`{{exec}}

```
input {
    WIP: input file
}
filter {
    grok {
        match => { "message" => "%{COMBINEDAPACHELOG}"}
    }
}
output {
    stdout { codec => rubydebug } 
}
```

WIP now use a config file to send sysloger program to ES  - do this after 'adv grok step

https://github.com/logstash-plugins/logstash-patterns-core/tree/main/patterns

`/usr/share/logstash/bin/logstash -e 'input { beats { port=>"5044" } }  filter {grok {match => { "message" => "%{COMBINEDAPACHELOG}"}}}  output { stdout { codec => rubydebug } }'`{{exec}}

filter {grok {match => { "message" => "%{COMBINEDAPACHELOG}"}}}
### grok in Kibana

open website

goto dev tools > grok debugger

in Sample Data "192.168.54.34"

Grok pattern "%{IP:clientip}"

and run 'Simulate"

