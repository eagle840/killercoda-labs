
# filebeats


https://www.elastic.co/guide/en/beats/filebeat/7.17/filebeat-installation-configuration.html


```bash
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.17.4-amd64.deb
sudo dpkg -i filebeat-7.17.4-amd64.deb
```{{exec}}

`wget https://download.elastic.co/demos/logstash/gettingstarted/logstash-tutorial.log.gz`{{exec}}

`gzip -d logstash-tutorial.log.gz`{{exec}}


`filebeat -h`{{exec}}


`filebeat modules -h`{{exec}}

`filebeat modules list`{{exec}}

`filebeat modules enable elasticsearch`{{exec}}

any changes, need:

`filebeat setup -e`{{exec}}

it takes a few minutes to setup, including kibana dashboards

