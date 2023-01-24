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




