# Filebeats

https://www.elastic.co/guide/en/beats/filebeat/7.17/index.html

Is a lightweight shipper for logs and other data files, it tails logs/files into ES

`apt install filebeat=7.17.4`{{exec}}

`filebeat -h`{{exec}}

`filebeat test config`{{exec}}

`filebeat test output`{{exec}}

`filebeat setup`{{exec}}

### Filebeats Core Components

##### prospector(inputs)

tells were filebeat to look for a file


##### harvaster

a process that takes a discovered file and ships it to ES, this is tracked through the data folder. You'll be able to see the harvesters being created in the filebeat logs (-e)

WIP CAN I JUST USE THE FOLLOWING FILE IN THE DOCKER CONTRAINER AS THE SOURCE 
FILE?

## Config filebeat

In the yml (/etc/filebeat/filebeat.yml), a filebeat propector has setup the 'filebeat input' - the propector

```yaml
  # Paths that should be crawled and fetched. Glob based paths.
  paths:
    - /var/log/*.log
    #- c:\programdata\elasticsearch\logs\*
```

we just need to enable it. Comment out the enabled: false 

`nano /etc/filebeat/filebeat.yml`{{exec}}

- set enabled: true

see https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html 


now check the yml is correct

`filebeat test config`{{exec}}

`filebeat test output`{{exec}}

`filebeat setup`{{exec}}

WIP
`sudo filebeat modules enable system`{{exec}}

WIP sysctl

`sudo systemctl enable filebeat.service`{{exec}}

`sudo systemctl start filebeat.service`{{exec}}

Navigate to Logs in the Oservability Section, and review the metrics.


note that the data folder stores the points in tail that filebeats has shipped.




## Getting one off files

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


For a extensive tutorial on filebeat see
youtube.com/watch?v=ykuw1piMGa4




