
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

## docker update

`apt-get remove docker  docker.io containerd runc -y`{{exec}}   

`apt-get update`{{exec}}   

`apt-get install ca-certificates curl gnupg  lsb-release -y`{{exec}}   

`mkdir -p /etc/apt/keyrings`{{exec}}   

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`{{exec}}   

```bash
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```{{exec}}   

`apt-get update`{{exec}}   

`apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y `{{exec}}   

`docker version`{{exec}}   

`docker-compose version`{{exec}}   

`docker compose version`{{exec}}

## Setup config file

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

`docker run --name my-prometheus --net host -v $(pwd)/tmp/prometheus.yml:/etc/prometheus/prometheus.yml -p 9090:9090 prom/prometheus`{{exec}}


Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_9090}}

Lets check that Prometheus is picking up the metrics endpoint.

IN the GUI, goto the status>targets page and you should see the localhost:9090 (Prometheus metrics) endpoint up. You may have to wait a minute.

IN the labels section, note the endpoint label, and the job label, which is the job_name in the prometheus config yml


and stop the container

ctrl-c

`docker stop my-prometheus  && docker rm my-prometheus`{{exec}}
