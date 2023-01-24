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

https://www.elastic.co/guide/en/beats/metricbeat/7.17/metricbeat-overview.html

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

