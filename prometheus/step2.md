
# Monitor Docker

## config docker

Lets configure docker to provider metrics:

`nano /etc/docker/daemon.json`{{exec}}

add the following to the daemon.json file, besure the yaml syntax is correct.

```json
  "metrics-addr" : "127.0.0.1:9323",
  "experimental" : true
```{{copy}}

system status docker   # restarte

`systemctl  daemon-reload`{{exec}}

`systemctl  restart docker`{{exec}}

`systemctl  status docker`{{exec}}

confirm we get metrics:

`curl http://localhost:9323/metrics`{{exec}}


## setup

add the follow to the config:

`cd ~ && nano ./tmp/prometheus.yml`{{exec}}

PROMETHEOUS IS ALREADY RUNNING, update yaml ? do I need to restart?

```yaml
  - job_name: docker  
    metrics_path: /metrics
    static_configs:
      - targets: ['localhost:9323']
```{{copy}}



https://docs.docker.com/config/daemon/prometheus/

start the docker container, connected directed with the host (--net host)

`docker run --name my-prometheus --net host -v $(pwd)/tmp/prometheus.yml:/etc/prometheus/prometheus.yml -p 9090:9090 prom/prometheus`{{exec}}

and connect to the web gui

{{TRAFFIC_HOST1_9090}}

check the status>targets page do check that it is getting data from the docker endpoint (port 9323)

swarm_store_batch_latency_seconds_count

Open the 'graph tab' and use the 'meterics explorer' next to the Execute button


# grafana


Open a new tab,

### dashboard

https://grafana.com/docs/grafana/v9.0/getting-started/build-first-dashboard/

https://grafana.com/docs/grafana/v9.0/setup-grafana/installation/docker/


`docker run --net host -p 3000:3000 grafana/grafana-oss`



connect to port 3000

{{TRAFFIC_HOST1_3000}}

can use: un & pw: admin

You can skip the password reset.

go into datasources and add prometheous, with HTTP:URL:

`http://localhost:9090`

save and test



