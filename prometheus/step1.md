
# Initial Setup



### Setup config file

`mkdir tmp`{{exec}}     

`nano tmp/prometheus.yml`{{exec}}   


```yaml
global:
  scrape_interval: 30s
  scrape_timeout: 10s

rule_files:
#  - alert.yml

scrape_configs:
  - job_name: services
    metrics_path: /metrics
    static_configs:
      - targets:
          - 'localhost:9090'
            
```{{copy}}

### start the docker container

`docker run --name my-prometheus --net host -v $(pwd)/tmp/prometheus.yml:/etc/prometheus/prometheus.yml -p 9090:9090 prom/prometheus`{{exec}}


Link for traffic into host 1 on port 9090  
{{TRAFFIC_HOST1_9090}}

Lets check that Prometheus is picking up the metrics endpoint.

In the GUI, goto the status>targets page and you should see the localhost:9090 (Prometheus metrics) endpoint up. You may have to wait/refresh a minute.

In the labels section, note the endpoint label, and the job label, which is the job_name in the prometheus config yml


and stop the container

ctrl-c

`docker stop my-prometheus  && docker rm my-prometheus`{{exec}}
