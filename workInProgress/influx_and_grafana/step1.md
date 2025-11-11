Our first step is to create a working directory for our project. The necessary configuration files, `docker-compose.yaml` and `telegraf.conf`, have already been placed in this directory for you.

Let's create the directory and inspect the files.

```bash
mkdir ~/ubuntu-monitoring && cd ~/ubuntu-monitoring
```{{exec}}

Now, view the Docker Compose configuration that defines our TIG stack services.

```bash
cat docker-compose.yaml
```{{exec}}

This file sets up three services: `influxdb` (the database), `telegraf` (the collector), and `grafana` (the visualizer).

Next, examine the Telegraf configuration file. This file tells Telegraf what metrics to collect and where to send them.

```bash
cat telegraf.conf
```{{exec}}

This configuration instructs Telegraf to gather various system metrics and send them to the InfluxDB container.