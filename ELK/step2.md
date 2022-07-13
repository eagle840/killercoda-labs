# check up and running

## General

docker logs <container>


## ES

`docker exec -it ##### bash`

`cat /etc/elasticsearch/elasticsearch.yaml`

rename cluster.name  ELK

rename node.name: node-1

/etc/elasticsearch/jvm.options for changing 

restart sevice / container

curl http://localhost:9200/_cluster/health?pretty



## logstash

look at the log stash examples on line

- TODO add date field to index name

`cat /logstash/logstash/conf`

- note input, with 'type'
- note use if statements
- note index name

/etc/logstash/logstash.yaml

/etc/logstash/pipelines.yaml

/use/share/logstash/bin/logstash -f <config.yaml>




## kibana

port 1514

netstat -tlupn

/etc/kibana/kibana.yaml

note server.host

to allow all, change to "0.0.0.0"

note, but don't change elasticsearch setting