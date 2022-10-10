
https://killercoda.com/spcloud/course/basics/creating-dashboards-with-grafana


youtube.com/watch?v=h4Sl21AKiDg



mkdir data
   13  chmod -R 777 data
   14  cp prometheus.yml ./data/prometheus.yml
   15  docker run -d --net=host     -v /root/data:/etc/prometheus/         --name prometheus-server     prom/prometheus
   16  docker ps



-------- old config


```
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
          - 'prometheus:9090'
            
```{{copy}}

`nano prometheus/alert.ym`{{exec}}

```
groups:
  - name: DemoAlerts
    rules:
      - alert: InstanceDown 
        expr: up{job="services"} < 1 
        for: 5m
```{{copy}}

`nano docker-compose.yml`{{exec}}

```
version: '3'

services:
  prometheus:
    image: prom/prometheus:v2.30.3
    ports:
      - 9000:9090
    volumes:
      - ./prometheus:/etc/prometheus
      - prometheus-data:/prometheus
    command: --web.enable-lifecycle  --config.file=/etc/prometheus/prometheus.yml


volumes:
  prometheus-data:
```{{copy}}