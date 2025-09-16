# Create a Databse


https://learn.microsoft.com/en-us/sql/t-sql/lesson-1-creating-database-objects?view=sql-server-ver17

We'll use the -y and -Y options to control display output and make it easier to read

`sqlcmd -y 30 -Y 30 -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}

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

# basic exploration

## system information schema

https://learn.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/system-information-schema-views-transact-sql?view=sql-server-ver17

```sql
SELECT TOP 10 *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
GO
```{{exec}}

```sql
sp_databases
GO
```{{exec}}

## Backup the database

```sql
BACKUP DATABASE TestData
TO DISK = '/var/opt/mssql/backup/TestData.bak'
WITH FORMAT,
     INIT,
     NAME = 'BackUpTestData',
     SKIP,
     NOREWIND,
     NOUNLOAD,
     STATS = 10;
GO
```{{exec}}

**Explanation of Options**

- TO DISK: Specifies the path and filename for the backup.
- WITH FORMAT: Creates a new media set, overwriting any existing backup sets.
- INIT: Overwrites the existing file if it exists.
- NAME: A label for the backup set.
- SKIP, NOREWIND, NOUNLOAD: Options for tape devices (included for completeness, but not needed for disk backups).
- STATS = 10: Displays progress every 10%.

`exit`{{exec}}

Check the docker volume for the backup:

`ls mssql-data/backup`{{exec}}

## Load AdventureWorks Sample Database

Download and restore the AdventureWorks LT sample database for learning purposes.

**Reference**: https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms

Download the AdventureWorksLT backup file:

`wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2022.bak`{{exec}}

Create a backup directory inside the container and copy the file:


WIP Remove this line
`docker-compose exec mssql-dev mkdir -p /var/opt/mssql/backup`{{copy}}

`docker cp AdventureWorksLT2022.bak mssql-dev:/var/opt/mssql/backup/`{{exec}}

Verify the file was copied:

`docker-compose exec mssql-dev ls /var/opt/mssql/backup/`{{exec}}

## Restore the Database

Connect to SQL Server and examine the backup file structure:


We'll use the -y and -Y options to control display output and make it easier to read

`sqlcmd -y 30 -Y 30 -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}

```sql
SELECT @@SERVERNAME,
       SERVERPROPERTY('ComputerNamePhysicalNetBIOS'),
       SERVERPROPERTY('MachineName'),
       SERVERPROPERTY('ServerName');
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


## Using DBCC for check the database


The DBCC command line tool in SQL Server refers to a set of Database Console Commands (DBCC) — specialized Transact-SQL (T-SQL) statements used to check, maintain, and troubleshoot SQL Server databases.

**Docs** https://learn.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-transact-sql?view=sql-server-ver17

```sql
DBCC CHECKDB('AdventureWorksLT2022')
```{{exec}}

## Intro to stored Procedure sp_holp

The `sp_help` stored procedure in SQL Server is a **built-in system procedure** that provides **detailed information** about a database object — such as a table, view, stored procedure, or user-defined function.

**ref** https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-help-transact-sql?view=sql-server-ver17

---

### 🔹 What Does `sp_help` Do?

When you run:

```sql
EXEC sp_help 'YourObjectName';
```

SQL Server returns **multiple result sets** that describe:

- **Column names and data types**
- **Identity columns**
- **Indexes**
- **Constraints**
- **Foreign keys**
- **Rowguid columns**
- **Storage details**

---

### 🔹 Example: Table Info

```sql
EXEC sp_help 'sys.databases';
GO
```{{exec}}

This might return:

1. **Column details** — name, type, length, nullability
2. **Identity info** — if any column is an identity
3. **Indexes** — clustered, non-clustered, unique
4. **Constraints** — primary keys, foreign keys, check constraints

---

### 🔹 Use Cases

- Quickly inspect table structure
- Review constraints and indexes
- Debug schema issues
- Prepare for migrations or documentation

---

### 🔹 Notes

- If you run `sp_help` without parameters:
  ```sql
  EXEC sp_help;
  ```
  It returns a list of **all objects** in the current database.

- Works best with **user-defined objects**. For system views like `sys.databases`, use `sys.columns` or `INFORMATION_SCHEMA`.


Exit sqlcmd:

```sql
quit
```{{exec}}

# Account Types

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
  USE [YourDatabase];
  CREATE USER [your_login_name]
  FOR LOGIN [your_login_name];
  ```

 - To grant **roles/permissions**:
  ```
  ALTER ROLE db_datareader ADD MEMBER [your_login_name];
  ALTER ROLE db_datawriter ADD MEMBER [your_login_name];
   ```


## Single user mode

```sql
ALTER DATABASE [YourDatabaseName] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
```

- SINGLE_USER: Restricts access to one user at a time.
- WITH ROLLBACK IMMEDIATE: Forces disconnect of all other users and rolls back their transactions immediately.


# 🧳 Contained Databases in SQL Server

Contained databases are a powerful feature in SQL Server that simplify database management, improve portability, and reduce dependency on the host SQL Server instance. Unlike traditional databases, contained databases can manage authentication and configuration internally—making them ideal for cloud, multi-tenant, or migration-heavy environments.

https://learn.microsoft.com/en-us/sql/relational-databases/databases/contained-databases?view=sql-server-ver17

---

## 🔍 What Is a Contained Database?

A **contained database** is a self-sufficient SQL Server database that minimizes reliance on the SQL Server instance. It includes its own:

- Metadata
- Authentication (via contained users)
- Configuration settings

This allows the database to be moved between servers without breaking user access or requiring server-level login recreation.

---

## 🔐 Contained Users vs Traditional Logins

| Feature                  | Traditional Database | Contained Database       |
|--------------------------|----------------------|---------------------------|
| Authentication Scope     | Server-level login   | Database-level user       |
| Migration Complexity     | High (logins must be recreated) | Low (users travel with DB) |
| Setup                    | Login + User mapping | Direct user creation      |

### ✅ Traditional Setup

```sql
-- Server-level login
CREATE LOGIN app_user WITH PASSWORD = 'StrongP@ssword';

-- Database-level user
USE MyDatabase;
CREATE USER app_user FOR LOGIN app_user;

-- Directly inside the contained database
CREATE USER contained_user WITH PASSWORD = 'SecureP@ss123!';
```

## Enabling

Before using contained databases, enable the feature at the server level:

```sql
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'contained database authentication', 1;
RECONFIGURE;
GO
```{{exec}}

and create a contained db

```sql
CREATE DATABASE MyContainedDB
CONTAINMENT = PARTIAL;
GO
```{{exec}}




## change sa and password

https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver17&tabs=cli&pivots=cs1-bash#change-the-system-administrator-password-1

## Notes

what is the msdb database?

Setup a lab page, inc a email server for https://learn.microsoft.com/en-us/training/modules/schedule-tasks-using-sql-server-agent/3-describe-task-status-notifications
