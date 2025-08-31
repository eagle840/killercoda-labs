
Great move, Nicholas—splitting this into a dedicated **MSSQL Performance Lab** makes total sense, especially given your hands-on style and Killercoda setup. Here's a curated structure with **7 lab pages** that balance depth, practicality, and reproducibility. Each page builds on the last, giving learners a solid performance tuning journey.

---

## 🧪 MSSQL Performance Lab Structure (7 Pages)

### **Page 1: Baseline Setup & Metrics**
- Install SQL Server (Docker or local)
- Enable `Query Store` and configure basic telemetry
- Capture baseline metrics: CPU, memory, I/O, query duration
- Use `sys.dm_exec_requests`, `sys.dm_os_performance_counters`

### **Page 2: Index Design & Fragmentation**
- Create clustered vs non-clustered indexes
- Simulate fragmentation with random inserts
- Use `sys.dm_db_index_physical_stats` to measure fragmentation
- Rebuild vs reorganize indexes

### **Page 3: Page Splits Simulation (sqlcmd-based)**
- Use `sqlcmd` to inject mid-key inserts
- Monitor `Page Splits/sec` and fragmentation
- Explore fill factor and sequential keys
- Optional: compare `NEWID()` vs `NEWSEQUENTIALID()`

### **Page 4: Query Tuning & Execution Plans**
- Capture and interpret execution plans
- Identify expensive operators (e.g., nested loops, key lookups)
- Use `SET STATISTICS IO, TIME ON`
- Tune queries with indexing and rewrite strategies

### **Page 5: TempDB Contention**
- Simulate concurrent workloads using temp tables
- Monitor TempDB usage via `sys.dm_db_file_space_usage`
- Configure multiple TempDB files
- Explore trace flags (e.g., 1117, 1118)

### **Page 6: Wait Stats & Bottleneck Diagnosis**
- Use `sys.dm_os_wait_stats` to identify top waits
- Simulate `PAGEIOLATCH`, `CXPACKET`, `WRITELOG`
- Interpret waits and map to root causes
- Optional: visualize with PowerShell or Python

### **Page 7: Compression & Storage Optimization**
- Apply row/page compression
- Compare I/O and storage before/after
- Use `sp_estimate_data_compression_savings`
- Discuss trade-offs: CPU vs disk

---

## 🧠 Optional Add-ons (if you want to expand later)
- **Deadlock simulation and resolution**
- **Query Store regression analysis**
- **Memory grant tuning and spill detection**
- **Parallelism and MAXDOP experiments**

---

Want help drafting the intro page or building a reusable Markdown template for each module? I can also help you tie this into your blog or create a companion quiz for learners.

"copilot added the following for dp-3300"

Sticking with your original 7 pages is a strong foundation, Nicholas—they already cover the core mechanics of MSSQL performance tuning in a hands-on, reproducible way. But if you're open to **adding one or two more pages** to round out the lab and give learners a deeper edge (especially those prepping for DP-300 or real-world tuning), here are two additions worth considering:

---

## 🧩 Page 8: **Query Store Regression Analysis**
🔍 _Why add it?_  
DP-300 leans heavily on Query Store for tracking performance over time. This module would show learners how to:
- Detect regressions after index or query changes
- Compare runtime stats across plan versions
- Force a stable plan to prevent performance drift

🛠 _Hands-on tasks:_
- Enable Query Store and run baseline queries
- Introduce a change that causes a regression
- Use `sys.query_store_runtime_stats` and `sys.query_store_plan` to analyze
- Force the previous plan and validate improvement

---

## 🧩 Page 9: **Extended Events for Performance Diagnosis**
🎯 _Why add it?_  
Extended Events are a lightweight, production-safe way to capture performance anomalies. This page would teach:
- How to create a session targeting slow queries or high I/O
- How to filter and interpret event data
- When to use XE over Profiler or DMVs

🛠 _Hands-on tasks:_
- Create an XE session for `sql_batch_completed` or `query_post_execution_showplan`
- Simulate a slow query and capture the event
- Export and analyze the results

---

## 🧠 Summary: Final Lab Structure (9 Pages)

1. Baseline Setup & Metrics  
2. Index Design & Fragmentation  
3. Page Splits Simulation  
4. Query Tuning & Execution Plans  
5. TempDB Contention  
6. Wait Stats & Bottleneck Diagnosis  
7. Compression & Storage Optimization  
8. **Query Store Regression Analysis**  
9. **Extended Events for Performance Diagnosis**

---

If you want to keep it lean, Page 8 alone would be the most DP-300-aligned addition. Want help drafting the markdown structure or intro text for either? I can tailor it to match your blog tone and lab style.



---

# OLD  Docker Compose Setup


Using the sqlcmd to install mssql

Set up SQL Server 2022 using Docker Compose for easier container management.

**Reference**: https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver17&tabs=cli&pivots=cs1-bash

## Create Data Directory

First, create a directory to persist SQL Server data:

`mkdir mssql-data`{{exec}}

`sudo chown -R 10001:10001 ./mssql-data/`{{exec}}

## Create Docker Compose File

Create the docker-compose.yml file:

`nano docker-compose.yml`{{execute}}

Copy and paste this configuration:

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
```{{copy}}

## Start SQL Server

Start the container using Docker Compose:

`docker-compose up -d`{{execute}}

Verify the container is running:

`docker-compose ps`{{execute}}

Check the logs to ensure SQL Server started successfully:

`docker-compose logs mssql-dev`{{execute}}

## Connect to Container

You can connect to the container using:

`docker-compose exec mssql-dev /bin/bash`{{execute}}

Exit when finished:

`exit`{{execute}}




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

**Power Tip** While we're taked the long way to install SQL, run `sqlcmd create mssql --accept-eula --using https://aka.ms/AdventureWorksLT.bak`to do it quickly.

## Test SQL Server Connection

Connect to SQL Server using the GO-based sqlcmd:

`sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}

Test the connection by checking the SQL Server version:

```sql
SELECT @@VERSION;
GO
```{{exec}}

You should see the SQL Server version information displayed.

## Load AdventureWorks Sample Database

Download and restore the AdventureWorks LT sample database for learning purposes.

**Reference**: https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms

Download the AdventureWorksLT backup file:

`wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2022.bak`{{exec}}

Create a backup directory inside the container and copy the file:

`docker-compose exec mssql-dev mkdir -p /var/opt/mssql/backup`{{exec}}

`docker cp AdventureWorksLT2022.bak mssql-dev:/var/opt/mssql/backup/`{{exec}}

Verify the file was copied:

`docker-compose exec mssql-dev ls /var/opt/mssql/backup/`{{exec}}

## Restore the Database

Connect to SQL Server and examine the backup file structure:

`sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}

`sqlcmd -y 30 -Y 30 -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}

```sql
SELECT @@SERVERNAME,
       SERVERPROPERTY('ComputerNamePhysicalNetBIOS'),
       SERVERPROPERTY('MachineName'),
       SERVERPROPERTY('ServerName');
```{{exec}}

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

Exit sqlcmd:

```sql
quit
```{{exec}}

## Install PowerShell and SQL Server Module

Install PowerShell for advanced SQL Server management capabilities.

**Reference**: https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.5

Install prerequisite packages:

`sudo apt-get install -y wget apt-transport-https software-properties-common`{{exec}}

Download and register Microsoft repository keys:

`wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`rm packages-microsoft-prod.deb`{{exec}}

Update package list and install PowerShell:

`sudo apt-get update`{{exec}}

`sudo apt-get install -y powershell`{{exec}}

Start PowerShell:

`pwsh`{{exec}}

Install the SQL Server PowerShell module:

`Install-Module -Name SqlServer -RequiredVersion 22.2.0 -Force`{{exec}}

Exit PowerShell:

`exit`{{exec}}

## Enable SQL Server Agent

SQL Server Agent is required for job scheduling and automation.

**Reference**: https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-configure-mssql-conf?view=sql-server-ver17

Access the container as root to configure SQL Server:

`docker-compose exec --user root mssql-dev bash`{{exec}}

Enable SQL Server Agent:

`/opt/mssql/bin/mssql-conf set sqlagent.enabled true`{{exec}}

Exit the container:

`exit`{{exec}}

Restart the container to apply the SQL Agent configuration:

`docker-compose restart mssql-dev`{{exec}}

Verify the container is running:

`docker-compose ps`{{exec}}
