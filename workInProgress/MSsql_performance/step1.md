
## 🧪 MSSQL Performance Lab Structure (7 Pages)

### **Page 0: Infra Setup

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

Here’s the **updated instructions using a virtual environment and manual `.deb` install for the ODBC driver** (since Ubuntu 24.04 repo signing is broken):

***


## Download Adventure works LT


First, create a directory to persist SQL Server data:

`mkdir mssql-data`{{exec}}

`sudo chown -R 10001:10001 ./mssql-data/`{{exec}}

`cd mssql-data`{{exec}}

`mkdir backup`{{exec}}

`cd backup`{{exec}}

`wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2022.bak`{{exec}}

`cd ../..`{{exec}}

## Start docker-compose in new tab


Now, start all the services using the new compose file:

`docker-compose  up -d`{{execute}}

Verify that all containers are running:

`docker-compose  ps`{{execute}}

Check the logs to ensure SQL Server started successfully:

`docker-compose logs mssql-dev`{{execute}}


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


## ✅ **4. Install ODBC Driver for SQL Server (Manual .deb Method)**

Since Ubuntu 24.04 repo is unsigned, download and install manually:

https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver17&tabs=ubuntu18-install%2Calpine17-install%2Cdebian8-install%2Credhat7-13-install%2Crhel7-offline#18


WIP it doesn't pass
```bash
if ! [[ "18.04 20.04 22.04 24.04 24.10" == *"$(grep VERSION_ID /etc/os-release | cut -d '"' -f 2)"* ]];
then
    echo "Ubuntu $(grep VERSION_ID /etc/os-release | cut -d '"' -f 2) is not currently supported.";
    exit;
fi
```{{exec}}


```bash
# Download the package to configure the Microsoft repo
curl -sSL -O https://packages.microsoft.com/config/ubuntu/$(grep VERSION_ID /etc/os-release | cut -d '"' -f 2)/packages-microsoft-prod.deb
# Install the package
sudo dpkg -i packages-microsoft-prod.deb
# Delete the file
rm packages-microsoft-prod.deb
```{{exec}}



# Install the driver
`apt-get update`{{exec}}
`ACCEPT_EULA=Y apt-get install -y msodbcsql18`{{exec}}
# optional: for bcp and sqlcmd
`sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18`{{exec}}
`echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc`{{exec}}
`source ~/.bashrc`{{exec}}

```bash
odbcinst -q -d -n "ODBC Driver 18 for SQL Server"
```{{exec}}



```bash
# optional: for unixODBC development headers
sudo apt-get install -y unixodbc-dev
```copy

## initial working install

```bash
# Download the latest msodbcsql18 .deb package (from Ubuntu 22.04 repo)
curl -O https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/msodbcsql18/msodbcsql18_18.3.2.1-1_amd64.deb

# Install it
sudo ACCEPT_EULA=Y dpkg -i msodbcsql18_18.3.2.1-1_amd64.deb

# Install dependencies if needed
sudo apt-get install -f
```{{exec}}

You might need
Make sure you also have unixODBC installed (`sudo apt-get install unixodbc`{{copy}})

***

## ✅ **5. Verify ODBC Driver**

```bash
odbcinst -q -d -n "ODBC Driver 18 for SQL Server"
```{{exec}}

***

## Test SQL Server Connection

Connect to SQL Server using the GO-based sqlcmd:

`sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}

```sql
SELECT @@VERSION;
GO
```{{exec}}


## Load AdventureWorks Sample Database



Verify the file was copied:

`docker-compose exec mssql-dev ls /var/opt/mssql/backup/`{{exec}}

## Restore the Database

Connect to SQL Server and examine the backup file structure:


We'll use the -y and -Y options to control display output and make it easier to read

`sqlcmd -y 30 -Y 30 -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}

`sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}

```sql
SELECT @@VERSION;
GO
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

## Enable Query store
Query Store is not enabled by default on restored databases. You can enable it for the AdventureWorksLT2022 database with the following command:

```sql
ALTER DATABASE AdventureWorksLT2022
SET QUERY_STORE = ON (OPERATION_MODE = READ_WRITE);
GO
```{{exec}}

## restore AdventureWorksLT



## ✅ **1. Create and Activate a Virtual Environment**


# Install venv if not already installed

`sudo apt-get install -y python3-venv`{{exec}}


# Create a virtual environment

`python3 -m venv jupyter_env`{{exec}}

# Activate it

`source jupyter_env/bin/activate`{{exec}}


***

## ✅ **2. Install Jupyter Lab and Python Packages**

Inside the venv:


`pip install --upgrade pip`{{exec}}

`pip install  jupyterlab ipykernel pyodbc sqlalchemy pandas`{{exec}}


***

## ✅ **3. Register venv as Jupyter Kernel**

WIP
```bash
python -m ipykernel install --user --name=jupyter_env --display-name "Python (jupyter_env)"
```{{copy}}

***


## ✅ **6. Connect to SQL Server in Jupyter**

`jupyter-lab  --ip=0.0.0.0 --port=8888 --no-browser --allow-root`{{exec}}

Copy the token down

{{TRAFFIC_HOST1_8888}}

In your notebook

# jupter

```python
import pyodbc

# Replace with your actual credentials and server info
conn = pyodbc.connect(
    'DRIVER={ODBC Driver 18 for SQL Server};'
    'SERVER=localhost;'
    'DATABASE=AdventureWorksLT2022;'
    'UID=sa;'
    'PWD=YourStrong:Passw0rd;'
    'TrustServerCertificate=yes;'
)

cursor = conn.cursor()
cursor.execute("SELECT name FROM sys.databases")
for row in cursor.fetchall():
    print(row)
```{{copy}}

you can also use ipython-sql

```python
%load_ext sql

# For SQL auth:
%sql mssql+pyodbc://username:password@localhost/master?driver=ODBC+Driver+18+for+SQL+Server
```{{copy}}

```python
import pyodbc
import pandas as pd

# Connection string


conn = pyodbc.connect(
    'DRIVER={ODBC Driver 18 for SQL Server};'
    'SERVER=localhost;'
    'DATABASE=AdventureWorksLT2022;'
    'UID=sa;'
    'PWD=YourStrong:Passw0rd;'
    'TrustServerCertificate=yes;'
)

# Test query  WIP errors out
df = pd.read_sql("SELECT TOP 10 * FROM YourTable", conn)
print(df)
```{{copy}}

# But this works

try:

    print("Connection successful!")

    # Create a cursor object
    cursor = conn.cursor()

    # Example query
    cursor.execute("SELECT TOP 5 * FROM SalesLT.Customer")

    # Fetch and print results
    for row in cursor.fetchall():
        print(row)

    # Close the connection
    cursor.close()
    conn.close()

except pyodbc.Error as e:
    print("Error:", e)


# above appears to close the connection, so can't run below. rerun the con statemenet above
# cursor.execute("EXEC sp_tables @table_type = "'TABLE'";")

# ?? in that try catch - remove the close?


***

## ✅ **7. (Optional) Use SQLAlchemy**

```python
from sqlalchemy import create_engine

engine = create_engine('mssql+pyodbc://your_username:your_password@localhost/YourDatabaseName?driver=ODBC+Driver+18+for+SQL+Server')
df = pd.read_sql("SELECT TOP 10 * FROM YourTable", engine)
```{{copy}}


```
jupyter lab --ip=0.0.0.0 --port=8888 --allow-root --no-browser
```{{copy}}

***

👉 Do you want me to **write a single shell script that automates all these steps (venv setup, Jupyter install, kernel registration, ODBC driver download and install)**? Or should I also include **a ready-to-run Jupyter Notebook template with connection and sample queries**?



---

# Install JupterLab (old version)

```
sudo apt update
sudo apt install python3.12 python3.12-venv python3.12-dev
```

```
python3.12 -m venv ~/venvs/jupyterlab-env
source ~/venvs/jupyterlab-env/bin/activate
```

```
pip install --upgrade pip
pip install jupyterlab
```

```
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
```

```
sudo apt install -y unixodbc-dev gcc g++ gnupg2 curl
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/24.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list
sudo apt update
sudo ACCEPT_EULA=Y apt install -y msodbcsql18
```

```
pip install pyodbc ipython-sql
```


===

# Install MSSQL


WIP **MOVE TO NEXT STEP - ignore below**

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

## Setup SQL and the AdventureWorks database

`sqlcmd create mssql get-tags`{{exec}}

 `sqlcmd create mssql --accept-eula --using https://aka.ms/AdventureWorksLT.bak`{{exec}}


## Test SQL Server Connection

Connect to SQL Server using the GO-based sqlcmd:

WIP: skip this line for now, the create command already creates an association to the server

WIP `sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{copy}}

Test the connection by checking the SQL Server version:

```sql
SELECT @@VERSION;
GO
```{{exec}}

`sqlcmd query "EXEC sp_databases;"`{{exec}}



`sqlcmd query "USE AdventureWorksLT2022;"`{{exec}}

You should see the SQL Server version information displayed.


# WIP delete below?


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
