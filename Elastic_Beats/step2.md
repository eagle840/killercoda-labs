# Overview

Make sure you use the same version as ElasticSearch

`curl localhoat:9200`{{exec}}

Each Beats modules has some common commands


You'll need to set the ElasticSearch Endpoint in the tools yml file (in this lab, they are all localhost, which is preconfigured)

You can use the tool sub command <toolName>  config output

this is confirm that the tool can communicate with ElasticSearch

<toolName> config test

confirms the configation is correct.

<toolname>  setup   # sets' up dasboards, and index patterns in ES

Some of the tools you can start as a service

sudo systemctl [enable|start|status] 





## Logstash

This is covered in the main ELK 7 tutorial/lab

## MetricBeats

This shipper allows you to directly ship the system metrics to ES

just install

`apt install metricbeat=7.17.4`{{exec}}

`metricbeat -h`{{exec}}

Check the yml config

`cat /etc/metricbeat/metricbeat.yml`{{exec}}

it is already set for the localhost

`metricbeat test output`{{exec}}

`metricbeat test config`{{exec}}

`metricbeat setup`{{exec}}  

Setup will take a few minutes

`sudo systemctl enable metricbeat.service`{{exec}}

`sudo systemctl start metricbeat.service`{{exec}}

You can now check the ES GUI for the new indices, index-patterns and dashboards.

You can also config metricbeat to run with other systems:

`metricbeat modules list`{{exec}}

## Filebeats

Is a lightweight shipper for logs and other data files

`apt install filebeat=7.17.4`{{exec}}

`filebeat -h`{{exec}}

`filebeat test output`{{exec}}

`filebeat setup`{{exec}}

CAN I JUST USE THE FOLLOWING FILE IN THE DOCKER CONTRAINER AS THE SOURCE FILE?

`wget https://download.elastic.co/demos/logstash/gettingstarted/logstash-tutorial.log.gz`{{exec}}

`gzip -d logstash-tutorial.log.gz`{{exec}}


`filebeat modules list`{{exec}}

filebeat modules enable nginx  - NOT THIS

in /etc/filebeat/filebeat.yml  make sure config is set:

```

# ---------------------------- Elasticsearch Output ----------------------------
output.elasticsearch:
  # Array of hosts to connect to.
  hosts: ["localhost:9200"]

filebeat.inputs:
- type: log
  paths:
    - /root/filebeats/logstash-tutorial.log 
output.logstash:
  hosts: ["localhost:5044"]
```

`filebeat test config -e -c filebeat.yml`{{exec}}

-e outputs stdout
-c specifies the config file to use


`filebeat -h`{{exec}}


`filebeat modules -h`{{exec}}

`filebeat modules list`{{exec}}

`filebeat modules enable elasticsearch`{{exec}}

any changes, need:

`filebeat setup -e`{{exec}}

WIP add filebeat keystore




