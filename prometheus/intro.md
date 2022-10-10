#This lab is for a Basic Prometheus/grafana setup.


https://prometheus.io/docs/introduction/comparison/

## architecture:

https://prometheus.io/docs/introduction/overview/#architecture

![architecture](https://prometheus.io/assets/architecture.png)

## Metrics

are *pulled* from http://<address>/metrics

Two types: https://prometheus.io/docs/concepts/metric_types/#metric-types
 - HELP; a description of the metric
 - TYPE; 3 sub types
   - counter
   - gauge
   - histogram

notation:
 - <metric_name>{k=v, ...}

## Exporters

if you service/server doesn't provide an endpoint, you can use an 'exporter', which fetches the metrics and coverts to the correct format, and then provides an endpoint for Prometheus to pull from (/metrics)

prometheus.io/docs/instrumenting/exporters/

These exporters also come as a docker container, so you can always use them as a sidecar to your main service container


## Client libraries

You can also embed code into your application for prometheus

https://prometheus.io/docs/instrumenting/clientlibs/

## Pushgateway

Designed to recieve ' push metrics' with short running jobs, so that Prometheus can pull them

## prometheus.yml

the main config file for prometheus, with 3 main sections:
  - global;  
  - rule_files:
  - scrape_configs; configuration for each target

note that prometheus has it's own /metrics endpoint on port 9090