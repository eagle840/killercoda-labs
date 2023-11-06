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

