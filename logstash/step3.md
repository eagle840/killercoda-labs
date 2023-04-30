# work with elasticsearch

edit the file

`nano /etc/filebeat/filebeat2.yml`{{exec}}

to match

```
filebeat.inputs:
- type: log
  paths:
    - /root/logstash-tutorial.log 
output.logstash:
  hosts: ["localhost:5044"]
```

wip `filebeat export config  -c filebeat2.yml -E "config=/root/filebeat"`{{exec}}

to find the datapath, and delete it

`rm -rf /var/lib/filebeat/`{{exec}}

restart logstash

`/usr/share/logstash/bin/logstash -e 'input { beats { port=>"5044" } }  filter {grok {match => { "message" => "%{COMBINEDAPACHELOG}"}}}  output { elasticsearch { hosts=>"localhost" } } '`{{exec}}

and start filebeat

filebeat -e -c filebeat2.yml -d "publish"