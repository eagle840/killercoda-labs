start a multinode ES cluster, see https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-compose-file


logstash conf eg: https://www.elastic.co/guide/en/logstash/current/config-examples.html


https://www.youtube.com/watch?v=Mma7HKt-mk8&list=PLECxNUHStsl9pWSPKMATMx9lbbHbTY0Wi&index=5
^ grok pattern

https://raw.githubusercontent.com/edgoad/syslog-generator/master/syslogGen1.sh

ES8 on docker:

https://github.com/deviantony/docker-elk
clone and bring it up
user: elastic
password: changeme



https://github.com/thombashi/elasticsearch-faker

http://media.sundog-soft.com/es/ml-latest-small.zip # 100k ratings
                            /es8/movies.json  # _bulk insert



### /elastic-certified-observability-engineer

https://www.elastic.co/training/elastic-certified-observability-engineer

#### Uptime

- Configure and run Heartbeat to determine the uptime of a process or service
- Use Heartbeat to determine if a service is reachable via ICMP, TCP or HTTP
- Use the Uptime app in Kibana to monitor the uptime and availability of a service
#### Metrics

- Configure and run Metricbeat to collect metrics from an operating system
- Enable and configure a Metricbeat module to collect the metrics of a specific service
- Use the Metrics app in Kibana to analyze and answer questions about metrics collected in Elasticsearch
- Configure Metricbeat to gather Stack Monitoring data 
#### Logging

- Configure and run Filebeat to collect system logs
- Enable and configure a Filebeat module to collect the logs from a specific service
- Configure and run Filebeat to tail a given log file
- Use the Logs app in Kibana to analyze and answer questions about log events collected in Elasticsearch
- Use the Logs app to view and analyze the predefined machine learning jobs for log events
- Configure Filebeat to gather Stack Monitoring data
#### APM

- Configure an APM Server to send data to an Elasticsearch cluster
- Enable RUM on an APM Server
- Use the APM app in Kibana to analyze and answer questions about APM data collected in Elasticsearch
#### Structuring and Processing Data

- Use Kibana to edit or define an ingest node pipeline
- Configure Metricbeat or Filebeat to use an ingest pipeline
- Define ingest node pipelines that use the various processors, including (but not limited to) append, convert, date, dissect, dot expander, geoip, grok, fail, json, remove, rename, set, and split
-  Define an ingest node pipeline that loads event data from an existing Elasticsearch index
#### Working with Observability Data

- Find anomalies in Observability data using the predefined machine learning jobs in Kibana
- Define a machine learning job in Kibana on Observability data
- Define or edit an Index Lifecycle Management policy for indices
- Define an alert using Kibana Alerts