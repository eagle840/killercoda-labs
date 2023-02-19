# Overview

Make sure you use the same 'beat' version as ElasticSearch

`curl localhost:9200`{{exec}}

```json
version" : {
    "number" : "7.17.4",
```

Each Beats modules has some common commands:



You can use the tool sub command:

*<toolCmd> <subcmd> <arguments>*

For example:

*metricbeat  config output*

this is to confirm that the tool, in this case metricbeat, can communicate with ElasticSearch.

*<toolCmd> config test*

confirms the configation is correct.

The following sets' up dasboards, and index patterns in ES

*<toolCmd> setup*

use

*<toolCmd> -h* to list all options. 

You'll need to set the ElasticSearch Endpoint in the tools yml file (in this lab, they are all localhost, which is preconfigured) - in this setup there are in the */etc/<toolCmd>* folder.

Some of the tools you can start as a service

*sudo systemctl [enable|start|status] <toolCmd>.service*

You can also start a **beat** with a specific yml with the -c arg.

-e will send logs to stdout

Several of the tools include modules to allow quick setup with different plaforms (eg Apache).

*<toolCmd> modules list*

The yml setup files can be found in */etc/<tool>/modules.d*

for debugging modules  check the logs  */var/log/<moduleName>

to increase debugging add

 -d "<moduleName>"  or 
 
 -d "*" 
 
 for modules (not for prduction)


## Logstash

This is covered in the main ELK 7 tutorial/lab

## MetricBeats

https://www.elastic.co/guide/en/beats/metricbeat/7.17/metricbeat-overview.html

This shipper allows you to directly ship the system metrics to ES

just install

`apt install metricbeat=7.17.4`{{exec}}

`metricbeat -h`{{exec}}

Review the yml config

`cat /etc/metricbeat/metricbeat.yml`{{exec}}

and list which modules are installed

`ls /etc/metricbeat/modules.d`{{exec}}

Note that the system module is enabled (not disabled)

it is already set for the localhost (system)

Lets setup metricbeat for use:

`metricbeat test output`{{exec}}

`metricbeat test config`{{exec}}

`metricbeat setup`{{exec}}  

Setup will take a few minutes.

Now enable metricbeats as a service to start piping metrics to ES:

`sudo systemctl enable metricbeat.service`{{exec}}

`sudo systemctl start metricbeat.service`{{exec}}

You can now check the ES GUI for the new indices, index-patterns and dashboards.

Navigate to Metrics in the Oservability Section, and review the metrics.

You can also config metricbeat to run with other systems:

`metricbeat modules list`{{exec}}

`metricbeat module able <moduleName>`

Lets review the logs for this tool:

`cat /var/log/metricbeat/metricbeat`{{exec}}

The reference file is included to give examples, and not intended to be used:
`cat  /etc/metricbeat/metricbeat.reference.yml`{{exec}}

For a extensive tutorial on metricbeat see https://www.youtube.com/playlist?list=PL_mJOmq4zsHYTSN_tUTWJVuLMcwA0DRS3

