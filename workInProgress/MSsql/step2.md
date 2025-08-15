# Lessons


https://learn.microsoft.com/en-us/sql/t-sql/lesson-1-creating-database-objects?view=sql-server-ver17

Create a database
```
CREATE DATABASE TestData
GO
```{{exec}}

Create a table
```
USE TestData
GO
```{{exec}}

```
CREATE TABLE dbo.Products
    (ProductID int PRIMARY KEY NOT NULL,
    ProductName varchar(25) NOT NULL,
    Price money NULL,
    ProductDescription varchar(max) NULL)
GO
```{{exec}}


Insert data into a table
```
-- Standard syntax
INSERT dbo.Products (ProductID, ProductName, Price, ProductDescription)
    VALUES (1, 'Clamp', 12.48, 'Workbench clamp')
GO
```{{exec}}


# Basic database admin

## 🔐 Logon Account vs 📂 Database Account in SQL Server

Understanding the distinction between **logon accounts** and **database accounts** is key to managing access in SQL Server.

### 🔐 Logon Account (Login)
- **Scope**: Server-level
- **Purpose**: Authenticates a user to the SQL Server instance
- **Created with**: `CREATE LOGIN`
- **Examples**:
  - SQL Server authentication:
    ```sql
    CREATE LOGIN sa WITH PASSWORD = 'StrongPassword';
    ```
  - Windows authentication:
    ```sql
    CREATE LOGIN [DOMAIN\User] FROM WINDOWS;
    ```
- **Note**: A login does **not** automatically grant access to any database.

---

### 📂 Database Account (User)
- **Scope**: Database-level
- **Purpose**: Authorizes a login to access a specific database
- **Created with**: `CREATE USER`
- **Example**:
  ```sql
  CREATE USER sa FOR LOGIN sa;
  ```


## Single user mode

```sql
ALTER DATABASE [YourDatabaseName] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
```

- SINGLE_USER: Restricts access to one user at a time.
- WITH ROLLBACK IMMEDIATE: Forces disconnect of all other users and rolls back their transactions immediately.

---

COPiLOT: SQL Admin (alter this)

## 🛠️ Common Administrative Tasks for SQL Server DBAs

A SQL Database Administrator (DBA) plays a critical role in managing and maintaining SQL Server environments. Below is a categorized list of typical responsibilities:

---

### 1. 📦 Database Creation and Configuration
- Create new databases
- Configure file sizes, growth rates, and recovery models
- Set collation and compatibility levels

---

### 2. 🔐 User and Security Management
- Create logins and database users
- Assign roles and permissions
- Implement Windows and SQL Server authentication
- Audit and monitor access

---

### 3. 💾 Backup and Recovery
- Schedule full, differential, and transaction log backups
- Restore databases from backups
- Test disaster recovery procedures

---

### 4. 🚀 Performance Monitoring and Tuning
- Monitor query performance and server health
- Create and maintain indexes
- Update statistics
- Use tools like SQL Profiler, Extended Events, and Query Store

---

### 5. 🧹 Maintenance and Housekeeping
- Run regular maintenance tasks (e.g., DBCC CHECKDB, index rebuilds)
- Clean up old data or logs
- Archive historical data

---

### 6. 🔄 High Availability and Disaster Recovery (HA/DR)
- Configure Always On Availability Groups
- Set up database mirroring or log shipping
- Manage failover clusters

---

### 7. 🤖 Automation and Scripting
- Write T-SQL scripts for routine tasks
- Use SQL Agent for job scheduling
- Implement PowerShell for advanced automation

---

### 8. 📣 Monitoring and Alerts
- Set up alerts for failed jobs, low disk space, or high CPU usage
- Integrate with monitoring tools (e.g., SentryOne, SolarWinds)

---

### 9. ⬆️ Upgrades and Patching
- Apply service packs and cumulative updates
- Migrate databases between versions or servers

---

### 10. ✅ Compliance and Auditing
- Ensure data protection and privacy (e.g., GDPR, HIPAA)
- Track changes and access for compliance audits

---

These tasks help ensure that SQL Server environments are secure, performant, and resilient.
