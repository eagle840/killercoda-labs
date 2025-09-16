# mssql-config

The **`mssql-conf`** tool is a command-line utility used to configure **SQL Server on Linux**. It serves a similar purpose to **SQL Server Configuration Manager** on Windows, allowing DBAs to manage server-level settings in a structured and scriptable way.

---

### 🧰 What is `mssql-conf`?

- A **configuration script** installed with SQL Server on Linux (Red Hat, SUSE, Ubuntu).
- It modifies the **`mssql.conf`** file located at `/var/opt/mssql/`.
- Used to set, unset, and validate SQL Server configuration parameters.

`docker-compose exec mssql-dev /bin/bash`{{exec}}

`ls /var/opt/mssql/`{{exec}}

`cat /var/opt/mssql/mssql.conf`{{exec}}

---

### ⚙️ Common Usage Examples

You run it using:

```bash
sudo /opt/mssql/bin/mssql-conf <command> <parameter> <value>
```

#### ✅ Set a Configuration Value
```bash
sudo /opt/mssql/bin/mssql-conf set tcpport 1455
```

#### 🔄 Unset a Configuration Value
```bash
sudo /opt/mssql/bin/mssql-conf unset tcpport
```

#### 🔍 List Available Parameters
```bash
/opt/mssql/bin/mssql-conf list
```

#### 🔐 Reset SA Password
```bash
sudo /opt/mssql/bin/mssql-conf set-sa-password 'NewStrongPassword'
```

#### 🧠 Set Memory Limit
```bash
sudo /opt/mssql/bin/mssql-conf set memory.memorylimitmb 2048
```

#### 📁 Change Default Backup Directory
```bash
sudo /opt/mssql/bin/mssql-conf set filelocation.defaultbackupdir /sql/backup
```

---

### 🔧 Configuration Areas You Can Manage

- **SQL Server Agent** (enable/disable)
- **Authentication** (Microsoft Entra ID, Windows AD)
- **File locations** (data, log, backup, error logs)
- **Network settings** (TCP port, TLS)
- **Memory limits**
- **Trace flags**
- **Collation**
- **Edition and locale**
- **Machine Learning Services**

---

### 🛡️ Best Practices

- **Backup the config file** before making changes:
  ```bash
  sudo cp /var/opt/mssql/mssql.conf /var/opt/mssql/mssql-backup.conf
  ```

- **Restart SQL Server** after changes:
  ```bash
  sudo systemctl restart mssql-server
  ```

- **Use `validate`** to clean up invalid settings:
  ```bash
  sudo /opt/mssql/bin/mssql-conf validate
  ```

---

## Enable SQL Server Agent

WIP Move to the Steo 3, where wel'll first cover mssql-conf and then review the options )Full text, SSIS, java, polybase etc), and then activate sql server agent

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


ref: https://learn.microsoft.com/en-us/ssms/agent/sql-server-agent


Install SQL Server Agent on Linux

https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-sql-agent?view=sql-server-ver17&tabs=rhel


## SQL Server Full text search

https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-full-text-search?view=sql-server-ver17&tabs=rhel


## Install SQL Server Integration Services (SSIS) on Linux

what is this?


https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-ssis?view=sql-server-ver17&tabs=rhel

## JAVA extension


https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-language-extensions-java?view=sql-server-ver17

## Polybase

https://github.com/croblesm/mssql-polybase/tree/master

`git clone https://github.com/croblesm/mssql-polybase.git`{{exec}}

`cd mssql-polybase/`{{exec}}

`docker build . -t mssql-polybase -f Dockerfile`{{exec}}

`docker container run     --name sql-polybase     --env 'ACCEPT_EULA=Y'     --env 'MSSQL_SA_PASSWORD=_SqLr0ck$_'     --publish 1433:1433     --detach mssql-polybase`{{exec}}

! make sure sqlcmd is installed

`sqlcmd -U sa -P '_SqLr0ck$_'`{{exec}}

see readme to enable and test

to connect to external data: https://learn.microsoft.com/en-us/sql/relational-databases/polybase/polybase-configure-sql-server?view=sql-server-ver17




## ML services

https://github.com/microsoft/mssql-docker/blob/master/linux/preview/examples/mssql-mlservices/README.md

-----

(5 -)

## Copilot generated lab

Here’s a **hands-on lab outline** you can use to **administer, use, and troubleshoot SQL Server Agent** from the command line using `sqlcmd`, especially in a Docker container setup.

---

## 🧪 SQL Server Agent Command-Line Lab (Using `sqlcmd`)

### 🔧 **Prerequisites**
- SQL Server running in a Docker container
- SQL Server Agent enabled and started
- `sqlcmd` installed (either on host or inside container)
- Access credentials (e.g., `sa` user and password)

---

### 🧩 **Lab Sections**

#### 1. **Connect to SQL Server**

`sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}  ## added, remove next:

```bash
sqlcmd -S localhost -U sa -P YourStrong:Passw0rd
```{{exec}}

---

#### 2. **Verify SQL Server Agent is Running**
```sql
SELECT servicename, startup_type_desc, status_desc
FROM sys.dm_server_services
WHERE servicename LIKE '%SQL Server Agent%';
GO
```{{exec}}

---

#### 3. **List Existing Jobs**
```sql
USE msdb;
GO
SELECT job_id, name, enabled FROM dbo.sysjobs;
GO
```{{exec}}

---

#### 4. **Create a New SQL Server Agent Job**
```sql
EXEC msdb.dbo.sp_add_job
    @job_name = N'TestJob',
    @enabled = 1;
GO
```{{exec}}

WIP need to add

https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-add-jobserver-transact-sql?view=sql-server-ver17

```sql
sp_add_jobserver
    [ @job_id = ] job_id
        | [ @job_name = ] 'job_name'
    [ , [ @server_name = ] 'server' ]
[ ; ]
```{{copy}}

---

#### 5. **Add a Job Step**
```sql
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'TestJob',
    @step_name = N'Step1',
    @subsystem = N'TSQL',
    @command = N'SELECT GETDATE();',
    @database_name = N'master';
GO
```{{exec}}

---

#### 6. **Schedule the Job**
```sql
EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'TestSchedule',
    @freq_type = 4,  -- Daily
    @freq_interval = 1,
    @active_start_time = 090000;  -- 9:00 AM
GO
```{{exec}}

```sql
EXEC msdb.dbo.sp_attach_schedule
    @job_name = N'TestJob',
    @schedule_name = N'TestSchedule';
GO
```{{exec}}

---

#### 7. **Start the Job Manually**
```sql
EXEC msdb.dbo.sp_start_job @job_name = N'TestJob';
GO
```{{exec}}

---

#### 8. **Check Job History**
```sql
SELECT j.name, h.run_date, h.run_time, h.run_status, h.message
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
WHERE j.name = 'TestJob';
GO
```{{exec}}

---

#### 9. **Troubleshoot Failed Jobs**
```sql
SELECT j.name, h.step_name, h.run_status, h.message
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
WHERE h.run_status <> 1;  -- Not successful
GO
```{{exec}}

---

Would you like this lab exported as a `.sql` script or a Markdown guide for sharing or documentation?
