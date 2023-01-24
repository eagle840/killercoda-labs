# heartbeat

https://www.elastic.co/guide/en/beats/heartbeat/7.17/heartbeat-installation-configuration.html

`apt install heartbeat=7.17.4`{{exec}}

`heartbeat -h`{{exec}}

`nano heartbeat.yml`{{exec}}

```
heartbeat.monitors:
- type: icmp
  schedule: '*/5 * * * * * *' 
  hosts: ["localhost"]
  id: my-icmp-service
  name: My ICMP Service
- type: tcp
  schedule: '@every 5s' 
  hosts: ["localhost:9200"]
  mode: any 
  id: my-tcp-service
- type: http
  schedule: '@every 5s'
  urls: ["http://example.net"]
  service.name: apm-service-name 
  id: my-http-service
  name: My HTTP Service
  ```

  

