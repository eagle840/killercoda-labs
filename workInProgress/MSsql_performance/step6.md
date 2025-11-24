# Page 6: Wait Stats & Bottleneck Diagnosis

When a query is slow, how do you know *why* it's slow? Is it waiting for disk, CPU, memory, or something else? SQL Server provides the answer through **Wait Statistics**. Wait stats are counters that track how much time threads spend waiting for resources. Analyzing these waits is the most effective way to diagnose performance bottlenecks.

In this step, we will learn how to use the `sys.dm_os_wait_stats` Dynamic Management View (DMV) to identify the top waits on the server and understand what they mean.

First, connect to the database:
`sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd' -d AdventureWorksLT2022`{{exec}}

## Querying Wait Statistics

The `sys.dm_os_wait_stats` DMV contains a cumulative record of all waits since the last time SQL Server was started or the stats were cleared. A simple `SELECT *` is not very useful because it includes many benign waits that are part of normal background operations.

The following query is a much better starting point. It filters out common "safe" waits and calculates the percentage of total wait time for each wait type, showing you the most significant bottlenecks first.

```sql
WITH Waits AS (
    SELECT
        wait_type,
        wait_time_ms / 1000.0 AS WaitS,
        (wait_time_ms - signal_wait_time_ms) / 1000.0 AS ResourceS,
        signal_wait_time_ms / 1000.0 AS SignalS,
        waiting_tasks_count AS WaitingTasks,
        100.0 * wait_time_ms / SUM(wait_time_ms) OVER() AS Pct
    FROM sys.dm_os_wait_stats
    WHERE wait_type NOT IN (
        -- Add any benign waits you want to filter out
        'BROKER_EVENTHANDLER', 'BROKER_RECEIVE_WAITFOR', 'BROKER_TASK_STOP',
        'BROKER_TO_FLUSH', 'BROKER_TRANSMITTER', 'CHECKPOINT_QUEUE',
        'CHKPT', 'CLR_AUTO_EVENT', 'CLR_MANUAL_EVENT', 'CLR_SEMAPHORE',
        'DBMIRROR_DBM_EVENT', 'DBMIRROR_EVENTS_QUEUE', 'DBMIRROR_WORKER_QUEUE',
        'DBMIRRORING_CMD', 'DIRTY_PAGE_POLL', 'DISPATCHER_QUEUE_SEMAPHORE',
        'EXECSYNC', 'FSAGENT', 'FT_IFTS_SCHEDULER_IDLE_WAIT', 'FT_IFTSHC_MUTEX',
        'HADR_CLUSAPI_CALL', 'HADR_FILESTREAM_IOMGR_IOCOMPLETION', 'HADR_LOGCAPTURE_WAIT',
        'HADR_NOTIFY_SYNC', 'HADR_TIMER_TASK', 'HADR_WORK_QUEUE',
        'KSOURCE_WAKEUP', 'LAZYWRITER_SLEEP', 'LOGMGR_QUEUE', 'MEMORY_ALLOCATION_EXT',
        'ONDEMAND_TASK_QUEUE', 'PARALLEL_REDO_DRAIN_WORKER', 'PARALLEL_REDO_LOG_CACHE',
        'PARALLEL_REDO_TRAN_LIST', 'PARALLEL_REDO_WORKER_SYNC', 'PARALLEL_REDO_WORKER_WAIT_WORK',
        'PREEMPTIVE_OS_FLUSHFILEBUFFERS', 'PREEMPTIVE_XE_GETTARGETSTATE',
        'PWAIT_ALL_COMPONENTS_INITIALIZED', 'PWAIT_DIRECTLOGCONSUMER_GETNEXT',
        'QDS_PERSIST_TASK_MAIN_LOOP_SLEEP', 'QDS_ASYNC_QUEUE',
        'QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP', 'QDS_SHUTDOWN_QUEUE',
        'REDO_THREAD_PENDING_WORK', 'REQUEST_FOR_DEADLOCK_SEARCH', 'RESOURCE_QUEUE',
        'SERVER_IDLE_CHECK', 'SLEEP_BPOOL_FLUSH', 'SLEEP_DBSTARTUP', 'SLEEP_DCOMSTARTUP',
        'SLEEP_MASTERDBREADY', 'SLEEP_MASTERMDREADY', 'SLEEP_MASTERUPGRADED',
        'SLEEP_MSDBSTARTUP', 'SLEEP_SYSTEMTASK', 'SLEEP_TASK', 'SLEEP_TEMPDBSTARTUP',
        'SNI_HTTP_ACCEPT', 'SOS_WORK_DISPATCHER', 'SP_SERVER_DIAGNOSTICS_SLEEP',
        'SQLTRACE_BUFFER_FLUSH', 'SQLTRACE_INCREMENTAL_FLUSH_SLEEP', 'SQLTRACE_WAIT_ENTRIES',
        'WAIT_FOR_RESULTS', 'WAITFOR', 'WAITFOR_TASKSHUTDOWN', 'WAIT_XTP_RECOVERY',
        'WAIT_XTP_HOST_WAIT', 'WAIT_XTP_OFFLINE_CKPT_NEW_LOG', 'WAIT_XTP_CKPT_CLOSE',
        'XE_BUFFERMGR_FREEBUF_EVENT', 'XE_DISPATCHER_JOIN', 'XE_DISPATCHER_WAIT',
        'XE_TIMER_EVENT'
    ) AND waiting_tasks_count > 0
)
SELECT
    W.wait_type,
    CAST(W.WaitS AS DECIMAL(12, 2)) AS Wait_S,
    CAST(W.ResourceS AS DECIMAL(12, 2)) AS Resource_S,
    CAST(W.SignalS AS DECIMAL(12, 2)) AS Signal_S,
    W.WaitingTasks,
    CAST(W.Pct AS DECIMAL(5, 2)) AS Pct
FROM Waits AS W
ORDER BY W.WaitS DESC;
GO
```{{exec}}

This query gives you the top waits on your server. Now, let's learn to interpret some of the most common and important ones.

## Interpreting Common Wait Types

### 1. `PAGEIOLATCH_*` (I/O Contention)
A `PAGEIOLATCH` wait occurs when a task is waiting for a data page to be read from disk into the buffer pool (memory). This is a classic sign of I/O bottlenecks.

- **Common Causes:**
  - Slow disk subsystem.
  - Queries performing large scans on tables without appropriate indexes.
  - Insufficient memory, causing data to be flushed from the buffer pool frequently.

- **Simulating the Wait:**
  Let's clear the buffer cache and run a query that has to read a lot of data from disk.

  First, clear the buffer cache (do not do this on a production server!):
  ```sql
  DBCC DROPCLEANBUFFERS;
  GO
  ```{{exec}}

  Now, run a query that scans a large table. We'll query the `dbo.Customers` table we created in a previous step, which has no useful index for this query.
  ```sql
  SELECT * FROM dbo.Customers WHERE CustomerName LIKE 'Customer 1%';
  GO
  ```{{exec}}

  If you were to check the wait stats again immediately after this, you would likely see `PAGEIOLATCH_SH` (Shared latch for reads) as one of the top waits.

### 2. `CXPACKET` and `CXCONSUMER` (Parallelism)
`CXPACKET` waits occur when a query runs in parallel and threads have to wait for each other. `CXCONSUMER` is a more specific wait type (since SQL 2016) that indicates consumer threads are waiting for producer threads to send them data.

- **Common Causes:**
  - These waits are normal during parallel execution and are not always a problem.
  - High values can indicate skewed data distribution, outdated statistics, or an inefficient query plan causing one thread to do much more work than others.
  - The "Cost Threshold for Parallelism" setting might be too low.

- **Simulating the Wait:**
  Let's run a query that performs a large aggregation, which is a good candidate for parallelism.
  ```sql
  SELECT c.Name, SUM(soh.TotalDue) AS TotalSales
  FROM SalesLT.Customer AS c
  JOIN SalesLT.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
  GROUP BY c.Name
  ORDER BY TotalSales DESC
  OPTION (RECOMPILE); -- Force a new plan
  GO
  ```{{exec}}

  This query will likely generate a parallel plan, and checking wait stats afterward would show an increase in `CXPACKET` or `CXCONSUMER` waits.

### 3. `WRITELOG` (Transaction Log Waits)
A `WRITELOG` wait occurs when a session is waiting for the contents of the transaction log buffer to be flushed to the physical disk file.

- **Common Causes:**
  - Slow disk subsystem for the transaction log file.
  - High frequency of small `COMMIT` operations (e.g., updating rows one by one in a loop).
  - Very large transactions that generate a lot of log records.

- **Simulating the Wait:**
  Let's run a loop that performs many small, individual update transactions.
  ```sql
  DECLARE @i INT = 0;
  WHILE @i < 500
  BEGIN
      UPDATE TOP (1) SalesLT.Product
      SET ModifiedDate = GETDATE()
      WHERE ProductID = 707 + @i;
      SET @i = @i + 1;
  END;
  GO
  ```{{exec}}

  This "chatty" transaction pattern forces many small, synchronous flushes to the transaction log, which will cause `WRITELOG` waits to accumulate.

## Conclusion

Wait statistics are your first and best tool for diagnosing performance issues. By identifying the top waits, you can narrow down your investigation to specific areas like I/O, memory, CPU, or query design.

Remember, wait stats show you the **symptom**, not the root cause. A high `PAGEIOLATCH` wait tells you there's an I/O problem, but you still need to find the specific query or process causing it.

Finally, exit `sqlcmd`:
```sql
quit
```{{exec}}
