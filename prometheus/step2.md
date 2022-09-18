# Hello World! using python


review: https://prometheus.io/docs/introduction/overview/

https://www.youtube.com/watch?v=sYMTY-SciUQ

## config docker

`nano /etc/docker/daemon.json`{{exec}}

```json
{
  "metrics-addr" : "127.0.0.1:9323",
  "experimental" : true
}
```{{copy}}

system status docker   # restarte

## setup



`nano /tmp/prometheus.yml`{{exec}}

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


`docker run --name my-prometheus -v $(pwd)tmp/prometheus.yml:/etc/prometheus/prometheus.yml -p 9090:9090 prom/prometheus`{{exec}}


`docker run --name my-prometheus -v /root/test1/tmp/prometheus.yml:/etc/prometheus/prometheus.yml -p 9090:9090 prom/prometheus`{{exec}}

{{TRAFFIC_HOST1_9000}}


