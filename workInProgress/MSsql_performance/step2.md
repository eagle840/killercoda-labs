# Page 1 Monitoring SQL Server Performance

In this step, we will set up a monitoring stack for SQL Server using InfluxDB, Telegraf, and Grafana (the "TIG" stack). This will allow us to collect metrics from SQL Server and visualize them in a dashboard.

While Windows environments often use **Perfmon**, for Linux and containerized environments, a stack like this is very common. You mentioned using `Collectd`, which is a great tool for metric collection. We are using `Telegraf` here, which is a modern alternative from the creators of InfluxDB and has excellent out-of-the-box support for SQL Server.

## The Monitoring Stack

*   **InfluxDB**: A time-series database to store our performance metrics.
*   **Telegraf**: A plugin-driven server agent for collecting and reporting metrics. We will configure it to pull data from SQL Server.
*   **Grafana**: A visualization tool to create dashboards for our metrics.

## Create Docker Compose for Monitoring

## Create Data Directory

First, create a directory to persist SQL Server data:

`mkdir mssql-data`{{exec}}

`sudo chown -R 10001:10001 ./mssql-data/`{{exec}}

Create a new Docker Compose file named `docker-compose-monitoring.yml`:

`nano docker-compose.yml`{{execute}}

Copy and paste the following configuration. This defines the four services: `mssql-dev`, `influxdb`, `grafana`, and `telegraf`.

```yaml
version: '3.8'

services:
  mssql-dev:
    image: mcr.microsoft.com/mssql/server:2022-latest
    hostname: mssql-dev
    container_name: mssql-dev
    environment:
      SA_PASSWORD: "YourStrong:Passw0rd"
      ACCEPT_EULA: "Y"
      MSSQL_PID: "Developer"
    ports:
      - "1433:1433"
    volumes:
      - "./mssql-data:/var/opt/mssql"

  influxdb:
    image: influxdb:2.7
    container_name: influxdb
    ports:
      - "8086:8086"
    volumes:
      - influxdb-data:/var/lib/influxdb2
    environment:
      - DOCKER_INFLUXDB_INIT_MODE=setup
      - DOCKER_INFLUXDB_INIT_USERNAME=admin
      - DOCKER_INFLUXDB_INIT_PASSWORD=password
      - DOCKER_INFLUXDB_INIT_ORG=my-org
      - DOCKER_INFLUXDB_INIT_BUCKET=my-bucket
      - DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=my-super-secret-token

  grafana:
    image: grafana/grafana:10.2.0
    container_name: grafana
    ports:
      - "3000:3000"
    volumes:
      - grafana-data:/var/lib/grafana

  telegraf:
    image: telegraf:1.28
    container_name: telegraf
    volumes:
      - ./telegraf.conf:/etc/telegraf/telegraf.conf:ro
    depends_on:
      - mssql-dev
      - influxdb
    command: --config /etc/telegraf/telegraf.conf

volumes:
  mssql-data:
  influxdb-data:
  grafana-data:
```{{copy}}

## Create Telegraf Configuration

Create a file named `telegraf.conf` to configure Telegraf to collect metrics from SQL Server and send them to InfluxDB.

`nano telegraf.conf`{{execute}}

```toml
[agent]
  interval = "10s"
  round_interval = true
  metric_batch_size = 1000
  metric_buffer_limit = 10000
  collection_jitter = "0s"
  flush_interval = "10s"
  flush_jitter = "0s"
  precision = ""
  debug = false
  quiet = false
  hostname = ""
  omit_hostname = false

[[outputs.influxdb_v2]]
  urls = ["http://influxdb:8086"]
  token = "my-super-secret-token"
  organization = "my-org"
  bucket = "my-bucket"

[[inputs.sqlserver]]
  servers = ["server=mssql-dev;user id=sa;password=YourStrong:Passw0rd;app name=telegraf;log=1;"]
  query_version = 2
  include_query = []
```{{copy}}

## Start the Monitoring Stack

Now, start all the services using the new compose file:

`docker-compose  up -d`{{execute}}

Verify that all containers are running:

`docker-compose  ps`{{execute}}

Check the logs to ensure SQL Server started successfully:

`docker-compose logs mssql-dev`{{execute}}

## Configure Grafana

1.  Open Grafana in your browser by navigating to `http://<your-host-ip>:3000` {{TRAFFIC_HOST1_3000}}. The default login is `admin` / `admin`. You will be prompted to change the password.

2.  **Add InfluxDB as a Data Source:**
    *   Go to **Connections** > **Data Sources** > **Add new data source**.
    *   Select **InfluxDB**.
    *   Choose **Flux** as the query language.
    *   For the **URL**, enter `http://influxdb:8086`.
    *   Under **Authentication**, enter the following:
        *   **Organization**: `my-org`
        *   **Token**: `my-super-secret-token`
        *   **Default Bucket**: `my-bucket`
    *   Click **Save & Test**. You should see a "Data source is working" message.

## Create a Grafana Dashboard

1.  Go to **Dashboards** > **New** > **New Dashboard**.
2.  Click **Add visualization**.
3.  Select the **InfluxDB** data source you just configured.
4.  In the query editor, you can start building a query. Here is an example to show the number of batch requests per second:

```flux
from(bucket: "my-bucket")
  |> range(v: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "sqlserver_performance_counters")
  |> filter(fn: (r) => r["_field"] == "batch_requests_per_sec")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")
```

5.  This will display a graph of the "Batch Requests/sec" counter from SQL Server. You can now add more panels to build a comprehensive dashboard for monitoring key SQL Server metrics like `user_connections`, `page_life_expectancy`, etc.

## Install SQL Server Command Line Tools

Install the modern GO-based sqlcmd tool to connect to SQL Server.

**Reference**: https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver17&tabs=redhat-install

**Reference** https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver17&tabs=go%2Cwindows-support&pivots=cs1-bash

Check your Ubuntu version:

`cat /etc/os-release`{{exec}}

**Setup GO-based sqlcmd**

Install the Microsoft repository key:



`curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc`{{exec}}

Add the Microsoft package repository:

`sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/22.04/prod.list)"`{{exec}}

Update package list and install the modern sqlcmd:

`sudo apt-get update`{{exec}}

`sudo apt-get install -y sqlcmd`{{exec}}

Add sqlcmd to your PATH:

`echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc`{{exec}}

`source ~/.bashrc`{{exec}}

Verify installation:

`sqlcmd -?`{{exec}}

## Test SQL Server Connection

Connect to SQL Server using the GO-based sqlcmd:

`sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}

```sql
SELECT @@VERSION;
GO;
```{{exec}}
