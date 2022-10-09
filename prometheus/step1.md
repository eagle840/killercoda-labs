
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# docker update

`apt-get remove docker  docker.io containerd runc -y`{{exec}}   

`apt-get update`{{exec}}   

`apt-get install ca-certificates curl gnupg  lsb-release -y`{{exec}}   

`mkdir -p /etc/apt/keyrings`{{exec}}   

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`{{exec}}   

```
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```{{exec}}   

`apt-get update`{{exec}}   

`apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y `{{exec}}   

`docker version`{{exec}}   

`docker-compose version`{{exec}}   

`docker compose version`{{exec}}

# Setup files

`mkdir prometheus`{{exec}}     

`nano prometheus/prometheus.yml`{{exec}}   


```
global:
  scrape_interval: 30s
  scrape_timeout: 10s

rule_files:
  - alert.yml

scrape_configs:
  - job_name: services
    metrics_path: /metrics
    static_configs:
      - targets:
          - 'prometheus:9090'
          - 'idonotexists:564'   



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


`docker compose up`{{exec}}





Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_9000}}


### NEW STEP

Monitor docker with prometheus
https://docs.docker.com/config/daemon/prometheus/

