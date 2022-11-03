STep 4

# monitor the host with an exporter

https://prometheus.io/docs/guides/node-exporter/#monitoring-linux-host-metrics-with-the-node-exporter


`wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-amd64.tar.gz`{{exec}}

`tar xvfz node_exporter-1.4.0.linux-amd64.tar.gz `{{exec}}

`cd node_exporter-1.4.0.linux-amd64`{{exec}}

`./node_exporter &`{{exec}}

`curl http://localhost:9100/metrics`{{exec}}

add the follow to the prometheus config:

`cd ~ && nano ./tmp/prometheus.yml`{{exec}}

```yaml
  - job_name: node
    static_configs:
    - targets: ['localhost:9100']
```{{copy}}

restart Prometheus

`docker restart my-prometheus`{{exec}}

WIP check ports

and check the status>target page to confirm the endpoint is up

In Prometheus:

Metrics specific to the Node Exporter are prefixed with 'node_'


### pushgateway

https://prometheus.io/docs/practices/pushing/

https://github.com/prometheus/pushgateway/blob/master/README.md