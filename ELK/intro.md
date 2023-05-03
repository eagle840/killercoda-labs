This lab we'll setup a unsecure ELk stack, using Elasticsearch 7.17

The ELK stack has 3 main components:
- Logstash (log processing)
- ElasticSearch (database)
- Kibana (dashboard)


And has several add ons, including
 
 - x-pack, providing security, alerting, monitoring, reporting, machine learning, and many other capabilities
 - graph
 - beats, that allows import to elasticsearch to many different ways.  


Kibana orginally started as a logging platform with uses Elasticsearch, and later added metrics, and Grafana became a fork inorder to do metrics.
Now both systems do both, however you can do more Logging with Kibana, and more Metrics wit Grafana



# Nodes, shards and indexs

In this lab, we'll create just the one Node, and an index. An index can cross multiple Nodes, and the intersection of each is called a Shard. However you can have multiple same index shards on the same node (check this)

You can primary and replicate nodes (P0, R0) to protect data, it also improves search speed. 

Data is stored as json objects in an index, 

Nodes can have different Roles, but in this lab we will not concern ourselfs with this.


# Access control

Kibana dashboards are open to the public, but can be locked down with an extension (X=Pack)
Elasticsearch/Kibana v8 comes locked down by default, checkout the version 8 lab for more details.
# Querying

Since Kibana uses Elastricsearch, you'll be using Lucene or Kuery syntax

# Logstash

Is the log processing engine, that is configured through a yaml file, with 3 made sections

- inputs (defines the type of input to recieve)
- next is filters  which defines what tp do with each log message
- outputs defines were to send the output. 

# More resources
An excellent introduction to the ELK stack can be found here, it is several hours long. https://www.youtube.com/watch?v=gS_nHTWZEJ8  and it's associated Github page: https://github.com/LisaHJung/Beginners-Crash-Course-to-Elastic-Stack-Series-Table-of-Contents