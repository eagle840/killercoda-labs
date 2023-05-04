# Basic Operation


# check up and running

Lets start generating some logs into logstash/ES:

in another tab  start the log generator:

`chmod +x sysloggen.sh`{{exec}}

`./sysloggen.sh`{{exec}}

## Indexing

With data flowing into logstash, and then into ES, the records are being given a datafield of an index, and then being flowed into that index.

Open the ES GUI, and goto Management > Stack Management. And then Data -> Index Management. And you'll see the index logstash-*

Note that the health is yellow - this is due to ES considers an index health when it includes a replica. Since this ES only has one node, it won't have a replica.

## Index Pattern

Next we need to have Kibana reconize that index. Still under management, goto Kibana -> Index Patterns.

Click on index patterns, and use the term 'logstash*' and Timestamp field of @timestamp.

You will then be able to use the Analytics -> Discover page to search that index pattern.  





## Logstash

In our docker-ompose we have mapped the logstash config file  to the local logstash folder

`cat logstash/logstash.conf`{{exec}}

Show the logs of the logstash container

`docker-compose logs -f Logstash`{{exec}}

(note that the service starts with a capital letter: Logstash)

Show the logstash config:

`docker exec -it logstash bin/logstash --help`{{exec}}

WIP `docker exec -it logstash ls /etc/logstash`{{exec}}

View the available binaries:

`docker exec -it logstash ls /usr/share/logstash/bin/`{{exec}}

look at the log stash examples on line

- TODO add date field to index name

`docker-compose exec Logstash bash`{{exec}}

`pwd`{{exec}}

`logstash -h`{{exec}}

WIP /etc/logstash/pipelines.yaml

/use/share/logstash/bin/logstash -f <config.yaml>

Checking Logstash with it'a API (https://www.elastic.co/guide/en/logstash/current/monitoring-logstash.html)


#### query the logstash api

`curl -XGET 'localhost:9600/?pretty'`{{exec}}

`curl -XGET 'localhost:9600/_node/stats/'`{{exec}}

`curl -XGET 'localhost:9600/_node/stats/jvm?pretty'`{{exec}}

Check out more about the API  at (https://www.elastic.co/guide/en/logstash/current/monitoring-logstash.html)



for more on configeration see: https://www.elastic.co/guide/en/logstash/current/configuration.html

https://www.elastic.co/guide/en/logstash/current/advanced-pipeline.html




## ElasticSearch

Show the logs of the logstash container

`docker-compose logs -f Elasticsearch`{{exec}}

(note that the service starts with a capital letter: Logstash)

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

`docker exec -it kibana bin/kibana -h`{{exec}}

