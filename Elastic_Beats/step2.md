# Overview

Make sure you use the same version as ElasticSearch

`curl localhoat:9200`{{exec}}

Each Beats modules has some common commands

First you will need to update APT (for Linux)

```bash
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.17.4-amd64.deb
sudo dpkg -i filebeat-7.17.4-amd64.deb
```{{exec}}


You'll need to set the ElasticSearch Endpoint in the tools yml file (in this lab, they are all localhost, wish is preconfigure)

YOu can use the tool sub command <toolName>  config output

this is confirm that the tool can communicate with ElasticSearch

<toolName> config test

confirms the configation is correct.

<toolname>  setup   # sets' up dasboards, and index patterns in ES

Some of the tools you can start as a service

sudo systemctl [enable|start|status] 





## LOgstash

This is covered in the main ELK 7 tutorial/lab

## MetricBeats

This shipper allows you to directly ship the system metrics to ES

just install

`aput

## Filebeats

Is a lightweight shipper for logs and other data files



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

`filebeat -h`{{exec}}


`filebeat modules -h`{{exec}}

`filebeat modules list`{{exec}}

`filebeat modules enable elasticsearch`{{exec}}

any changes, need:

`filebeat setup -e`{{exec}}




