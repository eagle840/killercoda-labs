# Filebeats

https://www.elastic.co/guide/en/beats/filebeat/7.17/index.html

Is a lightweight shipper for logs and other data files, it tails logs/files into ES

`apt install filebeat=7.17.4`{{exec}}

`filebeat -h`{{exec}}

`filebeat -h`{{exec}}


`filebeat modules -h`{{exec}}

`filebeat modules list`{{exec}}

`filebeat modules enable elasticsearch`{{exec}}

any changes, need:

`filebeat setup -e`{{exec}}  # the -e gives debugging info

### Filebeats Core Components

#### prospector(inputs)

tells were filebeat to discover files


#### harvaster

a process that takes a discovered file and ships it to ES, this is tracked through the data folder. You'll be able to see the harvesters being created in the filebeat logs (-e)

WIP CAN I JUST USE THE FOLLOWING FILE IN THE DOCKER CONTRAINER AS THE SOURCE 
FILE?

## Config filebeat

In the yml (/etc/filebeat/filebeat.yml), a filebeat prospector has been setup the 'filebeat.input' section.

```yaml
  # Change to true to enable this input configuration.
  # enabled: false

  # Paths that should be crawled and fetched. Glob based paths.
  paths:
    - /var/log/*.log
    #- c:\programdata\elasticsearch\logs\*
```

we just need to enable it. Comment out the enabled: false 

`nano /etc/filebeat/filebeat.yml`{{exec}}

- set to  `# enabled: true`

see https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html 


and run the standard setup:

`filebeat test config`{{exec}}

`filebeat test output`{{exec}}

`filebeat setup`{{exec}}

and start the sevice

`sudo systemctl enable filebeat.service`{{exec}}

`sudo systemctl start filebeat.service`{{exec}}

Navigate to Logs in the Oservability Section, and review the logs.


WIP: note that the data folder stores the points in tail that filebeats has shipped.
https://www.elastic.co/guide/en/beats/filebeat/current/directory-layout.html




## Getting one off files

download a sample nginx log file

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

The reference file is included to give examples, and not intended to be used:
`cat  /etc/filebeat/filebeat.reference.yml`{{exec}}


For a extensive tutorial on filebeat see
youtube.com/watch?v=ykuw1piMGa4


# filebeat module config

in filebeat.yml

https://www.elastic.co/guide/en/beats/filebeat/current/elasticsearch-output.html#indices-option-es


```yaml
# — — — — — — — — — — — — — — Elasticsearch Output — — — — — — — — — — — — — —
output.elasticsearch:
# Array of hosts to connect to.
   hosts: [“x.x.x.x:9200”]
   indices:
     — index: “filebeat-%{[agent.version]}-system-%{+yyyy.MM.dd}”
       when.equals:
         event.module: “system”
     — index: “filebeat-%{[agent.version]}-cef-%{+yyyy.MM.dd}”
       when.equals:
         event.module: “cef”
     — index: “filebeat-%{[agent.version]}-cisco-%{+yyyy.MM.dd}”
       when.equals:
       event.module: “cisco”
```

wip:  getting an

Exiting: error loading config file: yaml: line 140: mapping values are not allowed in this context

test

filebeat -e -c filebeat2.yml -d "publish"

to rerun 

sudo rm data/registry




