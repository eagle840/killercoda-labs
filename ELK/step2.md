# Basic Operation


# check up and running

Lets start generating some logs into logstash/ES:

in another tab  start the log generator:

`chmod +x sysloggen.sh`{{exec}}

`./sysloggen.sh`{{exec}}

## Indexing

With data flowing into logstash, and then into ES, the records are being given a datafield of an index, and then being flowed into that index.

Open the ES GUI, and goto Management > Stack Management. And then Data -> Index Management. And you'll see the index logstash-*

Note that the health is yellow - this is due to ES considers an index healthy when it includes a replica. Since this ES only has one node, it won't have a replica.

## Index Pattern

Next we need to have Kibana reconize that index. Still under management, goto Kibana -> Index Patterns.

Click on index patterns, and use the term 'logstash*' and Timestamp field of @timestamp.

You will then be able to use the Analytics -> Discover page to search that index pattern.  


! note the following is based on the docker config,  for native elk stack config is usually under /etc/<product>/


## Logstash

In our docker-compose we have mapped the logstash config file  to the local logstash folder

`cat logstash/logstash.conf`{{exec}}

Show the logs of the logstash container

`docker-compose logs -f Logstash`{{exec}}

(note that the service starts with a capital letter: Logstash)

Look at the options for logstash:

`docker exec -it logstash bin/logstash --help`{{exec}}

View the available binaries:

`docker exec -it logstash ls /usr/share/logstash/bin/`{{exec}}


#### query the logstash api

`curl -XGET 'localhost:9600/?pretty'`{{exec}}

`curl -XGET 'localhost:9600/_node/stats/'`{{exec}}

`curl -XGET 'localhost:9600/_node/stats/jvm?pretty'`{{exec}}

Check out more about the API  at (https://www.elastic.co/guide/en/logstash/current/monitoring-logstash.html)



for more on configeration see: https://www.elastic.co/guide/en/logstash/current/configuration.html

https://www.elastic.co/guide/en/logstash/current/advanced-pipeline.html




## ElasticSearch

Show the logs of the ES container

`docker-compose logs -f Elasticsearch`{{exec}}

Show the elastic config:

`docker exec -it elasticsearch cat /usr/share/elasticsearch/config/elasticsearch.yml`{{exec}}

View the available binaries:

`docker exec -it elasticsearch ls /usr/share/elasticsearch/bin/`{{exec}}

and the help

`docker exec -it elasticsearch bin/elasticsearch -h`{{exec}}


## Kibana


Show the logs of the kibana container

`docker-compose logs -f Kibana`{{exec}}


Show the kibana config:

`docker exec -it kibana cat /usr/share/kibana/config/kibana.yml`{{exec}}

View the available binaries:

`docker exec -it kibana ls /usr/share/kibana/bin/`{{exec}}

`docker exec -it kibana bin/kibana -h`{{exec}}

