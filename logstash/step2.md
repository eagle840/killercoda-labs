


`wget https://download.elastic.co/demos/logstash/gettingstarted/logstash-tutorial.log.gz`{{exec}}
   
`gzip -d logstash-tutorial.log.gz`{{exec}}

`cat logstash-tutorial.log `{{exec}}


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




## ES

Show the logs of the logstash container

`docker-compose logs -f Elasticsearch`{{exec}}

(note that the service starts with a capital letter: Logstash)

in another tab (terminal window) start the log generator:

Show the logstash config:

`docker exec -it elasticsearch ls /etc/elasticsearch`{{exec}}

View the available binaries:

`docker exec -it elasticsearch ls /usr/share/elasticsearch/bin/`{{exec}}


## Kibana


Show the logs of the logstash container

`docker-compose logs -f Kibana`{{exec}}

(note that the service starts with a capital letter: Logstash)

in another tab (terminal window) start the log generator:

Show the logstash config:

`docker exec -it kibana ls /etc/kibana`{{exec}}

View the available binaries:

`docker exec -it kibana ls /usr/share/kibana/bin/`{{exec}}

## logstash

look at the log stash examples on line

- TODO add date field to index name

`docker-compose exec Logstash bash`{{exec}}

`pwd`{{exec}}

`cat config/logstash.yml`{{exec}}

- note input, with 'type'
- note use if statements
- note index name

/etc/logstash/logstash.yaml

/etc/logstash/pipelines.yaml

/use/share/logstash/bin/logstash -f <config.yaml>

Checking Logstash with it'a API (https://www.elastic.co/guide/en/logstash/current/monitoring-logstash.html)



 - run `logstash -e 'input { stdin { } } output { stdout {} }'`{{exec}}
 - wait until you see "Pipeline main started" 
 - type in `hello world`

- wait for 

for more on configeration see: https://www.elastic.co/guide/en/logstash/current/configuration.html

https://www.elastic.co/guide/en/logstash/current/advanced-pipeline.html


CAN I JUST USE THE FOLLOWING FILE IN THE DOCKER CONTRAINER AS THE SOURCE FILE?

wget https://download.elastic.co/demos/logstash/gettingstarted/logstash-tutorial.log.gz

gzip -d logstash-tutorial.log.gz


 curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.3.2-amd64.deb

dpkg -i filebeat-8.3.2-amd64.deb

filebeat modules list

filebeat modules enable nginx  - NOT THIS

in /etc/filebeat/filebeat.yml  make sure config is set:

```
filebeat.inputs:
- type: log
  paths:
    - /path/to/file/logstash-tutorial.log 
output.logstash:
  hosts: ["localhost:5044"]
```





## kibana

port 1514

netstat -tlupn

`docker-compose exec Logstash bash`{{exec}}

`pwd`{{exec}}

`cat config/kibana.yml`

run `bin/kibana`


note server.host

to allow all, change to "0.0.0.0"

note, but don't change elasticsearch setting



## send data through http api


`cd ~`

`mkdir bin`

`cd bin`

`nano curl`

```
#!/bin/bash
/usr/bin/curl -H "Content-Type: application/json" "$@"
```

`chmod a+x curl`

`cd ~`

`source .profile`


```
type 'curl -XPUT localhost:9200/movies/ -d'  
```  

note the quotes in the commands that encapsulated the json data

then 
`{`
ctrl-v tab, and complete as below. Notice the single quotes enclosing the text

```
{
  "mappings": {
    "properties": {
      "year": { "type": "date" }
    }
  }
}'
```
ABOVE ISN'T WORKING,, need to be in the ~/bin dir and run ./curl

curl -H "Content-Type: application/json" -XPUT localhost:9200/movies -d '
> {
>   "mappings": {
>     "properties": {
>       "year": { "type": "date" }
>     }
>   }
> }'



`curl -XGET localhost:9200/movies/_mapping`



`wget http://media.sundog-soft.com/es8/movies.json`



`cat movies.json`

note the json file already has the 'create', 'index' and 'id'
and that a year field is present, and we have told ES to treat that as a date.

curl -H "Content-Type: application/json" -XPUT localhost:9200/_bulk?pretty --data-binary @movies.json


curl -XGET localhost:9200/movies/_search?pretty`