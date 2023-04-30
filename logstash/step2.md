
# Forward a log file to logstash


Lets download some sample logs:

(for a large selection of logs, try https://github.com/logpai/loghub)


`wget https://download.elastic.co/demos/logstash/gettingstarted/logstash-tutorial.log.gz`{{exec}}
   
`gzip -d logstash-tutorial.log.gz`{{exec}}

`cat logstash-tutorial.log `{{exec}}

`apt install filebeat`{{exec}}

`ls /usr/share/filebeat/bin`{{exec}}

`filebeat -h`{{exec}}


## use filebeat to send logs

`nano filebeat.yml`{{exec}}

```
filebeat.inputs:
- type: log
  paths:
    - /root/logstash-tutorial.log 
output.logstash:
  hosts: ["localhost:5044"]
```

WIP: filebeat keeps defaulting to /etc/filebeat

`filebeat test config -c filebeat.yml`{{exec}}

`filebeat export config  -c /root/filebeat.yml -E "config=/root/filebeat"`{{exec}}

`/usr/share/logstash/bin/logstash -e 'input { beats { port=>"5044" } } output { stdout { codec => rubydebug } }'`{{exec}}

wip `cp filebeat.yml /etc/filebeat/filebeat2.yml`{{exec}}


`filebeat -e -c filebeat2.yml -d "publish"`{{exec}}

to re-run filebeat

`sudo rm data/registry`{{exec}}

grok patterns for elastic: https://github.com/elastic/elasticsearch/tree/main/libs/grok/src/main/resources/patterns


typical output:

```
{
    "@timestamp" => 2023-04-29T16:52:22.711Z,
         "input" => {
        "type" => "log"
    },
           "ecs" => {
        "version" => "1.12.0"
    },
          "host" => {
        "name" => "ubuntu"
    },
          "tags" => [
        [0] "beats_input_codec_plain_applied"
    ],
      "@version" => "1",
           "log" => {
        "offset" => 24248,
          "file" => {
            "path" => "/root/logstash-tutorial.log"
        }
    },
         "agent" => {
             "version" => "7.17.9",
                "name" => "ubuntu",
        "ephemeral_id" => "773a5f25-08aa-4958-aa08-b54b7211074d",
                "type" => "filebeat",
                  "id" => "92710e0a-ef68-4588-81c5-04722828d1f2",
            "hostname" => "ubuntu"
    },
       "message" => "86.1.76.62 - - [04/Jan/2015:05:30:37 +0000] \"GET /style2.css HTTP/1.1\" 200 4877 \"http://www.semicomplete.com/projects/xdotool/\" \"Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20140205 Firefox/24.0 Iceweasel/24.3.0\""
}
```
`nano first-pipeline.conf`{{exec}}

```
input {
    beats {
        port => "5044"
    }
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


https://github.com/logstash-plugins/logstash-patterns-core/tree/main/patterns

`/usr/share/logstash/bin/logstash -e 'input { beats { port=>"5044" } }  filter {grok {match => { "message" => "%{COMBINEDAPACHELOG}"}}}  output { stdout { codec => rubydebug } }'`{{exec}}

filter {grok {match => { "message" => "%{COMBINEDAPACHELOG}"}}}
### grok in Kibana

open website

goto dev tools > grok debugger

in Sample Data "192.168.54.34"

Grok pattern "%{IP:clientip}"

and run 'Simulate"

================= delete below ===================


# check up and running

Lets start generating some logs into ES:

in another tab (terminal window) start the log generator:

`chmod +x sysloggen.sh`{{exec}}

`./sysloggen.sh`{{exec}}



## Logstash

Show the logs of the logstash container

`docker-compose logs -f Logstash`{{exec}}

(note that the service starts with a capital letter: Logstash)

in another tab (terminal window) start the log generator:

Show the logstash config:

`docker exec -it logstash ls /etc/logstash`{{exec}}

View the available binaries:

`docker exec -it logstash ls /usr/share/logstash/bin/`{{exec}}


