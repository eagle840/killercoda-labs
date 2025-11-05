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

`cd mssql-data`{{exec}}

`mkdir backup`{{exec}}

`cd backup`{{exec}}

`wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2022.bak`{{exec}}

`cd ../..`{{exec}}

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

## Verify Data Collection

Before configuring Grafana, it's a good practice to verify that Telegraf is successfully collecting data from SQL Server and sending it to InfluxDB.

### 1. Check Telegraf for Connection Errors

SQL Server can take a minute to start. It's possible that Telegraf started faster and failed to connect initially.

Check the Telegraf logs:

`docker-compose logs telegraf`{{execute}}

You might see a "connection refused" error like this, which is normal if SQL Server wasn't ready:

```
telegraf | ... E! [inputs.sqlserver] Error in plugin: ... connect: connection refused
```

If you see this, simply wait a moment and restart Telegraf:

`docker-compose restart telegraf`{{execute}}

A successful connection will show a log message confirming the queries being used:
```
telegraf | ... I! [inputs.sqlserver] Config: Effective Queries: [...]
```

### 2. Query InfluxDB Directly

Now, query InfluxDB to see if data is arriving. This command asks InfluxDB for the last data point it received in the last 10 minutes.

`docker-compose exec influxdb influx query 'from(bucket: "my-bucket") |> range(start: -10m) |> last()'`{{execute}}

If data is flowing, you will see a table containing the most recently collected metric. Now you can be confident that the data pipeline is working before you even open Grafana.

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
4.  In the query editor, you can build queries to visualize different metrics.

## Import SQL Server Dashboard

1.  Go to **Dashboards** > **New** > **Import**.
2.  In the **Import via grafana.com** box, enter the dashboard ID `13544` and click **Load**.
    - This dashboard is specifically designed for SQL Server with Telegraf and InfluxDB 2.x (Flux).
    - Dashboard Link: [MS SQL Server via Telegraf](https://grafana.com/grafana/dashboards/13544-ms-sql-server-via-telegraf/)
3.  On the next screen, select your InfluxDB data source.
4.  Click **Import**.

### Example Dashboard Panels

Here are a few examples of queries you can use to create panels for a comprehensive SQL Server monitoring dashboard.

#### Panel 1: Batch Requests/Sec (Throughput)
This shows the number of batch requests per second that SQL Server is handling.

```flux
from(bucket: "my-bucket")
  |> range(v: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "sqlserver_performance_counters")
  |> filter(fn: (r) => r["_field"] == "batch_requests_per_sec")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")
```

#### Panel 2: User Connections
This panel shows how many active user connections there are.

```flux
from(bucket: "my-bucket")
  |> range(v: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "sqlserver_performance_counters")
  |> filter(fn: (r) => r["_field"] == "user_connections")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")
```

#### Panel 3: Page Life Expectancy (Memory Pressure)
This is a key indicator of memory pressure. It shows how long, in seconds, a data page stays in the buffer pool. A consistently low value (e.g., below 300) can indicate that the server needs more memory.

```flux
from(bucket: "my-bucket")
  |> range(v: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "sqlserver_performance_counters")
  |> filter(fn: (r) => r["_field"] == "page_life_expectancy")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")
```

#### Panel 4: CPU Usage
This directly measures how hard the processor is working.

**Note:** To get this metric, you first need to tell Telegraf to collect it by adding `[[inputs.cpu]]` to your `telegraf.conf` file.

```flux
from(bucket: "my-bucket")
  |> range(v: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "cpu")
  |> filter(fn: (r) => r["_field"] == "usage_idle")
  |> filter(fn: (r) => r["cpu"] == "cpu-total")
  |> map(fn: (r) => ({ r with _value: 100.0 - r._value }))
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean_cpu_usage")
```

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

`sudo add-apt-repository -y "$(wget -qO- https://packages.microsoft.com/config/ubuntu/22.04/prod.list)"`{{exec}}

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


## Load AdventureWorks Sample Database



Verify the file was copied:

`docker-compose exec mssql-dev ls /var/opt/mssql/backup/`{{exec}}

## Restore the Database

Connect to SQL Server and examine the backup file structure:


We'll use the -y and -Y options to control display output and make it easier to read

`sqlcmd -y 30 -Y 30 -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}


First, check what files are in the backup:

```sql
RESTORE FILELISTONLY
FROM DISK = N'/var/opt/mssql/backup/AdventureWorksLT2022.bak';
GO
```{{exec}}

Now restore the database using the logical names from the previous command:

```sql
RESTORE DATABASE AdventureWorksLT2022
FROM DISK = N'/var/opt/mssql/backup/AdventureWorksLT2022.bak'
WITH MOVE 'AdventureWorksLT2022_Data' TO '/var/opt/mssql/data/AdventureWorksLT2022.mdf',
     MOVE 'AdventureWorksLT2022_Log' TO '/var/opt/mssql/data/AdventureWorksLT2022_log.ldf';
GO
```{{exec}}

## Verify Database Installation

List all databases to confirm AdventureWorksLT2022 was restored:

```sql
SELECT name FROM sys.databases;
GO
```{{exec}}

Switch to the AdventureWorks database:

```sql
USE AdventureWorksLT2022;
GO
```{{exec}}

List tables in the database:

```sql
SELECT name FROM sys.tables;
GO
```{{exec}}

## Enable Query store
Query Store is not enabled by default on restored databases. You can enable it for the AdventureWorksLT2022 database with the following command:

```sql
ALTER DATABASE AdventureWorksLT2022
SET QUERY_STORE = ON (OPERATION_MODE = READ_WRITE);
```{{exec}}
