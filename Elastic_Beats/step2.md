# Overview

Make sure you use the same version as ElasticSearch

`curl localhost:9200`{{exec}}

Each Beats modules has some common commands


You'll need to set the ElasticSearch Endpoint in the tools yml file (in this lab, they are all localhost, which is preconfigured)

You can use the tool sub command <toolName>  config output

this is confirm that the tool can communicate with ElasticSearch

<toolName> config test

confirms the configation is correct.

<toolname>  setup   # sets' up dasboards, and index patterns in ES

Some of the tools you can start as a service

sudo systemctl [enable|start|status] 

You can also start a **beat** with a specific yml with the -c arg
-e will send logs to stdout

for debugging modules  check the logs  [<moduleName>]

to increase debugging add -d "<moduleName>"  or -d "*" for modules (not for prduction)






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

and list which modules are installed

`ls /etc/metricbeat/modules.d`{{exec}}

Note that the system module is enabled

it is already set for the localhost

`metricbeat test output`{{exec}}

`metricbeat test config`{{exec}}

`metricbeat setup`{{exec}}  

Setup will take a few minutes

`sudo systemctl enable metricbeat.service`{{exec}}

`sudo systemctl start metricbeat.service`{{exec}}

You can now check the ES GUI for the new indices, index-patterns and dashboards.

Navigate to Metrics in the Oservability Section, and review the metrics.

You can also config metricbeat to run with other systems:

`metricbeat modules list`{{exec}}



`cat /var/log/metricbeat/metricbeat`{{exec}}

The reference file is included to give examples, and not intended to be used:
`cat  /etc/metricbeat/metricbeat.reference.yml`{{exec}}

For a extensive tutorial on metricbeat see https://www.youtube.com/playlist?list=PL_mJOmq4zsHYTSN_tUTWJVuLMcwA0DRS3

