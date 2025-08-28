# SQL Server Agent

Config in docker

`docker exec -it --user root mssql-dev_1 bash`{{exec}}


```
root@57301203bac5:/# /opt/mssql/bin/mssql-conf set sqlagent.enabled true
SQL Server needs to be restarted in order to apply this setting. Please run
'systemctl restart mssql-server.service'.
```

`/opt/mssql/bin/mssql-conf set sqlagent.enabled true`{{exec}}



`docker container restart mssql-dev_1`{{exec}}




https://learn.microsoft.com/en-us/ssms/agent/sql-server-agent


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
    @active_start_time = 090000;  -- 9:00 AM
GO

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
