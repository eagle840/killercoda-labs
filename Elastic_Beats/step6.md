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