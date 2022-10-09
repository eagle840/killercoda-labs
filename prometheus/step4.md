STep 4

# monitor the host with an exporter

https://prometheus.io/docs/guides/node-exporter/#monitoring-linux-host-metrics-with-the-node-exporter


wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-amd64.tar.gz

tar xvfz node_exporter-1.4.0.linux-amd64.tar.gz 

cd node_exporter-1.4.0.linux-amd64

./node_exporter 

curl http://localhost:9100/metrics

add the follow:

```
scrape_configs:
- job_name: node
  static_configs:
  - targets: ['localhost:9100']
```{{copy}}

In Prometheus:

Metrics specific to the Node Exporter are prefixed with 'node_'

### add to grafana