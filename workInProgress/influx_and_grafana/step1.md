Our first step is to create a working directory for our project. The necessary configuration files, `docker-compose.yaml` and `telegraf.conf`, have already been placed in this directory for you.

Let's inspect the Docker Compose configuration that defines our TIG stack services.

```bash
cat docker-compose.yaml
```{{exec}}

This file sets up three services: `influxdb` (the database), `telegraf` (the collector), and `grafana` (the visualizer).

Next, examine the Telegraf configuration file. This file tells Telegraf what metrics to collect and where to send them.

```bash
cat telegraf.conf
```{{exec}}

This configuration instructs Telegraf to gather various system metrics and send them to the InfluxDB container.

# temp

`nano docker-compose.yaml`{{exec}}

```yaml
version: '3.8'
services:
  influxdb:
    image: influxdb:1.8
    container_name: influxdb
    ports:
      - "8086:8086"
    volumes:
      - influxdb_data:/var/lib/influxdb
    environment:
      - INFLUXDB_DB=telegraf
      - INFLUXDB_ADMIN_USER=admin
      - INFLUXDB_ADMIN_PASSWORD=adminpass

  telegraf:
    image: telegraf:1.29
    user: root
    container_name: telegraf
    depends_on:
      - influxdb
    volumes:
      - ./telegraf.conf:/etc/telegraf/telegraf.conf:ro
      - /var/run/docker.sock:/var/run/docker.sock
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /:/hostfs:ro
      - /var/log:/host/var/log:ro
    network_mode: host

  grafana:
    image: grafana/grafana
    container_name: grafana
    ports:
      - "3000:3000"
    depends_on:
      - influxdb
    volumes:
      - grafana_data:/var/lib/grafana

volumes:
  influxdb_data:
  grafana_data:
```

`nano telegraf.conf`{{exec}}

```yaml
[agent]
  interval = "10s"
  round_interval = true
  metric_batch_size = 1000
  metric_buffer_limit = 10000
  collection_jitter = "0s"
  flush_interval = "10s"
  flush_jitter = "0s"
  hostname = "ubuntu-host"
  omit_hostname = false

# System metrics
[[inputs.cpu]]
  percpu = true
  totalcpu = true
  report_active = true

[[inputs.mem]]
[[inputs.disk]]
[[inputs.diskio]]
[[inputs.system]]
[[inputs.net]]
[[inputs.processes]]
[[inputs.kernel]]

# Journal logs via exec
[[inputs.exec]]
  commands = ["journalctl -n 100 -o short"]
  timeout = "5s"
  data_format = "grok"
  name_override = "journal_logs"
  grok_patterns = ["%{GREEDYDATA:message}"]
  grok_timezone = "UTC"

# Output to InfluxDB
[[outputs.influxdb]]
  urls = ["http://localhost:8086"]
  database = "telegraf"
  username = "admin"
  password = "adminpass"

```
