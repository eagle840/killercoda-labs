This lab we'll setup a ELk stack

system ->  Logstash (data pipeline) -> ES (time-series DB)  -> Kibana (dashboards)

Add Ons
 
 - x-pack
 - graph
 - beats  (import data into ES)


The two largest monitoring software systems are Kibana and Grafana.
Kibana orginally started as a logging platform with uses Elasticsearch, and later added metrics, and Grafana became a fork inorder to do metrics.
Now both systems do both, however you can do more Logging with Kibana, and more Metrics wit Grafana

Grafana can be configured to work with a variety of time-series DB's, inc: Graphite, Prometheus, InfluxDB, MySQL, PostgreSQL, and Elasticsearch

# Nodes, shards and indexs

In this lab, we'll create just the one Node, and an index. An index can cross multiple Nodes, and the intersection of each is called a Shard. However you can have multiple same index shards on the same node (check this)

You can primary and replicate nodes (P0, R0) to protect data, it also improves search speed. 

Data is stored as json objects in an index, 

Nodes can have different Roles, but in this lab we will not concern ourselfs with this.


# Access control

Kibana dashboards are open to the public, but can be locked down with an extension (X=Pack)
Grafana comes with user management (external SQL or LDAP server)

# Querying

Since Kibana uses Elastricsearch, you'll be using Lucene or Kuery syntax
And for Grafana, depending on the DB you're using, you'll use it's query santx

# Alerting

Grafana comes with alerting in the box, Kibana, you'll need to purchase an addon

# Logstash

Plugins:   inputs  -> filters  -> outputs 

All these will be in a custom configuration file, that looks similar to YAML

# More resources
An excellent introduction to the ELK stack can be found here, it is several hours long. https://www.youtube.com/watch?v=gS_nHTWZEJ8  and it's associated Github page: https://github.com/LisaHJung/Beginners-Crash-Course-to-Elastic-Stack-Series-Table-of-Contents