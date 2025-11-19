# Page 5: TempDB Contention

TempDB is a critical shared resource in SQL Server used for temporary user objects (like temp tables), internal objects (for sorting, spooling), and row versioning. Heavy use of TempDB can lead to contention, where multiple threads compete for access to its data pages, causing performance bottlenecks.

In this step, we will simulate TempDB contention, monitor its usage, and explore ways to mitigate these issues.

We will continue working within the `AdventureWorksLT2022` database.

First, connect to the database:
`sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd' -d AdventureWorksLT2022`{{exec}}

## Understanding TempDB Contention

TempDB contention often manifests as waits on pages in TempDB, specifically `PAGELATCH` waits on allocation pages (PFS, GAM, SGAM). This happens when many concurrent sessions are creating and dropping temporary objects, causing a bottleneck at the points where SQL Server allocates new pages.

## Simulate Concurrent Workloads

To simulate this, we would ideally need a tool that can run multiple concurrent sessions. For this lab, we will demonstrate the kind of workload that *causes* contention. We will create and populate a temporary table in a loop. Imagine hundreds of users running this same logic simultaneously.

```sql
-- This script simulates a workload that heavily uses TempDB.
-- In a real scenario, you would run this from multiple connections at once.
DECLARE @i INT = 0;
WHILE @i < 100
BEGIN
    CREATE TABLE #MyTempTable (
        ID INT PRIMARY KEY,
        SomeData CHAR(100)
    );

    INSERT INTO #MyTempTable (ID, SomeData)
    SELECT n, 'some data'
    FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n FROM sys.all_columns) AS numbers;

    DROP TABLE #MyTempTable;

    SET @i = @i + 1;
END;
GO
```{{exec}}

This script rapidly creates, populates, and drops a temporary table. When run by many concurrent users, it puts significant stress on TempDB's allocation pages.

## Monitor TempDB Usage

We can monitor TempDB space usage using the `sys.dm_db_file_space_usage` DMV. This will show us how much space is allocated to user objects, internal objects, and how much is free.

```sql
SELECT
    SUM(user_object_reserved_page_count) * 8.0 / 1024 AS UserObjectsMB,
    SUM(internal_object_reserved_page_count) * 8.0 / 1024 AS InternalObjectsMB,
    SUM(unallocated_extent_page_count) * 8.0 / 1024 AS FreeSpaceMB
FROM sys.dm_db_file_space_usage;
GO
```{{exec}}

To see contention, we would typically look at wait statistics using `sys.dm_os_wait_stats`, filtering for `PAGELATCH_UP`, `PAGELATCH_EX`, or `PAGELATCH_SH` waits on resources that belong to TempDB (database ID 2).

```sql
-- This query shows PAGELATCH waits, which are a common sign of TempDB contention.
SELECT
    wait_type,
    waiting_tasks_count,
    wait_time_ms,
    max_wait_time_ms,
    signal_wait_time_ms
FROM sys.dm_os_wait_stats
WHERE wait_type LIKE 'PAGELATCH%' AND wait_type NOT LIKE '%IO%'
ORDER BY wait_time_ms DESC;
GO
```{{exec}}

If you were running a heavy concurrent workload, you would see high `wait_time_ms` for `PAGELATCH_UP` on pages belonging to TempDB.

## Mitigating TempDB Contention

There are several strategies to reduce TempDB contention.

### 1. Configure Multiple TempDB Data Files

The most common and effective solution is to create multiple TempDB data files. This allows SQL Server to distribute allocation requests across multiple files, reducing the bottleneck on a single file's allocation pages.

**Best Practice:**
*   Create one TempDB data file per logical CPU core, up to a maximum of 8.
*   Ensure all data files are of the same size and have the same autogrowth settings to ensure an even distribution of work.

Let's check the current TempDB file configuration:
```sql
USE tempdb;
GO
SELECT name, physical_name, size * 8.0 / 1024 AS SizeMB
FROM sys.database_files
WHERE type_desc = 'ROWS';
GO
```{{exec}}

By default, you will likely see only one data file. To add more files, you would use the `ALTER DATABASE` command.

**Note:** Modifying TempDB files requires a restart of the SQL Server service. The following commands are for demonstration and will not be executed in this lab environment as it would require restarting the Docker container.

```sql
-- Example of how to add a new TempDB data file (requires restart)
-- ALTER DATABASE tempdb
-- MODIFY FILE (NAME = tempdev, FILENAME = '/var/opt/mssql/data/tempdb.mdf');
-- GO
-- ALTER DATABASE tempdb
-- ADD FILE (NAME = tempdev2, FILENAME = '/var/opt/mssql/data/tempdb2.ndf');
-- GO
```

### 2. Enable Trace Flags

Certain trace flags can also help optimize TempDB performance.

*   **Trace Flag 1117:** When a file in a filegroup grows, this flag forces all files in that filegroup to grow simultaneously. This helps maintain the proportional fill algorithm when autogrowth is triggered.
*   **Trace Flag 1118:** This flag forces uniform extent allocations instead of mixed extents. It reduces contention on SGAM pages by allocating full extents (8 pages) to each new object, bypassing the need to scan for available pages in mixed extents. This is the default behavior in SQL Server 2016 and later, but enabling it can still be beneficial in some older versions or specific scenarios.

These trace flags are typically enabled at startup.

### 3. Optimize Application Code

Finally, you can reduce TempDB usage at the application level:
*   **Avoid unnecessary temp tables:** Use table variables or Common Table Expressions (CTEs) where possible, as they can sometimes be less resource-intensive.
*   **Pre-size temp tables:** If you know the approximate size of a temp table, declare it with an appropriate size to avoid autogrowth events.
*   **Index temp tables:** If you are performing joins or filtering on large temp tables, create indexes on them just as you would with permanent tables.

Finally, exit `sqlcmd`:
```sql
quit
```{{exec}}