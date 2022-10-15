# add cAdvisor

"cAdvisor (Container Advisor) provides container users an understanding of the resource usage and performance characteristics of their running containers."

https://prometheus.io/docs/guides/cadvisor/

https://github.com/google/cadvisor



to start cAdvisor:

```
VERSION=v0.36.0 # use the latest release version from https://github.com/google/cadvisor/releases
sudo docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:ro \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --volume=/dev/disk/:/dev/disk:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  --privileged \
  --device=/dev/kmsg \
  gcr.io/cadvisor/cadvisor:$VERSION
  ```{{exec}}


you can access the cAdvisor at {{TRAFFIC_HOST1_8080}}

To add to Prometheus:

`cd ~ && nano ./tmp/prometheus.yml`{{exec}}

```yaml
  - job_name: cadvisor
    scrape_interval: 5s
    metrics_path: /metrics
    static_configs:
    - targets:
      - localhost:8080
```{{copy}}

restart Prometheus

`docker restart my-prometheus`{{exec}}

and check the status>target page to confirm the endpoint is up





