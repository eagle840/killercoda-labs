# Basic Operation


# check up and running

Lets start generating some logs into logstash/ES:

in another tab  start the log generator:

`chmod +x sysloggen.sh`{{exec}}

`./sysloggen.sh`{{exec}}

## Indexing

With data flowing into logstash, and then into ES, the records are being given a datafield of an index, and then being flowed into that index.

Open the ES GUI, and goto Management > Stack Management. And then Data -> Index Management. And you'll see the index logstash-*

## Index Pattern

Next we need to have Kibana reconize that index. Still under management, goto Kibana -> Index Patterns.

Click on index patterns, and use the term 'logstash*' and Timestamp field of @timestamp.

You will then be able to use the Analytics -> Discover page to search that index pattern.  





## Logstash

Show the logs of the logstash container

`docker-compose logs -f Logstash`{{exec}}

(note that the service starts with a capital letter: Logstash)

Show the logstash config:

`docker exec -it logstash ls /etc/logstash`{{exec}}

View the available binaries:

`docker exec -it logstash ls /usr/share/logstash/bin/`{{exec}}

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


## ElasticSearch

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



port 1514

netstat -tlupn

`docker-compose exec Logstash bash`{{exec}}

`pwd`{{exec}}

`cat config/kibana.yml`

run `bin/kibana`


note server.host

to allow all, change to "0.0.0.0"

note, but don't change elasticsearch setting

