

### dashboard

https://grafana.com/docs/grafana/v9.0/getting-started/build-first-dashboard/




review: https://prometheus.io/docs/introduction/overview/

https://www.youtube.com/watch?v=sYMTY-SciUQ

## config docker

`nano /etc/docker/daemon.json`{{exec}}

BESURE to add the commar

```json
{
  "metrics-addr" : "127.0.0.1:9323",
  "experimental" : true
}
```{{copy}}

system status docker   # restarte

`systemctl  daemon-reload`{{exec}}

`systemctl  restart docker`{{exec}}

`systemctl  status docker`{{exec}}

confirm we get metrics:

`curl http://localhost:9323/metrics`{{exec}}


## setup



`cd ~ && nano ./tmp/prometheus.yml`{{exec}}

PROMETHEOUS IS ALREADY RUNNING, update yaml ? do I need to restart?

```yaml
# my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  external_labels:
      monitor: 'codelab-monitor'

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first.rules"
  # - "second.rules"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'docker'
         # metrics_path defaults to '/metrics'
         # scheme defaults to 'http'.

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

https://grafana.com/docs/grafana/v9.0/setup-grafana/installation/docker/

WIP: `docker run -p 3000:3000 grafana/grafana-oss`{{copy}}

add the following to the compose file

`nano /root/docker-compose.yml`{{exec}}

```
  grafana-oss:
      ports:
          - '3000:3000'
      image: grafana/grafana-oss
```


connect to 3000

un & pw: admin

{{TRAFFIC_HOST1_3000}}

go into datasources and add prometheous

WIP NEED TO COONECT PROMETHEOUS

====== delete the below ???




{{TRAFFIC_HOST1_9000}}


