
# Initial Setup

Boot up the ELK stack:

`docker-compose up -d`{{exec}}

In another tab (+), lets setup some tools/config

`apt update`{{exec}}

`apt install -y net-tools jq tree`{{exec}}

Config linux to download various beats:

`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg`{{exec}}

`sudo apt-get install apt-transport-https`{{exec}}

`echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list`{{exec}}

`sudo apt-get update`{{exec}}



Once the Docker-compose has completed, wait a few minutes for the elasticsearch server to come up, you will get a json response from:

`curl http://localhost:9200`{{exec}}

Now you can open the ES web GUI.



{{TRAFFIC_HOST1_5601}}/app/home



Elasticsearch (ES) offers many different types of BEATS in order to get data into ElasticSearch https://www.elastic.co/beats/

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

