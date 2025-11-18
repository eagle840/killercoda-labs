# Page 2: Index Design & Fragmentation

## Understanding Index Types

Before we dive into fragmentation, it's crucial to understand the main types of indexes available in SQL Server. Each serves a different purpose and has a unique impact on performance.

### Clustered vs. Non-Clustered Indexes

Think of a **Clustered Index** as a phone book sorted by last name. The data itself is physically stored in the order of the clustered index key. Because of this, a table can only have **one** clustered index. When you create a `PRIMARY KEY`, SQL Server automatically creates a clustered index on that column by default.

A **Non-Clustered Index** is like the index at the back of a textbook. It's a separate structure that contains the indexed columns and a "pointer" (a row locator) back to the actual data row in the clustered index (or the heap if there is no clustered index). You can have multiple non-clustered indexes on a single table. They are great for speeding up queries that filter or sort by columns other than the clustered index key.

### Filtered Indexes

A **Filtered Index** is a special type of non-clustered index that only includes rows that meet a specific `WHERE` clause. This is incredibly useful for performance and storage when you have a column where you only ever query a small subset of its values. For example, you could create a filtered index on an `IsActive` column `WHERE IsActive = 1`. This index would be much smaller and faster to scan than a full index on all rows.

### Columnstore Indexes

**Columnstore Indexes** are designed for data warehousing and analytics workloads. Instead of storing data row-by-row, they store it column-by-column. This has two major benefits:
1.  **High Compression:** Data within a single column is often very similar, leading to excellent compression ratios. This reduces I/O.
2.  **Batch Mode Processing:** Queries can process data in batches of rows, which is much more efficient for aggregations and large scans.

There are two types:
- **Clustered Columnstore Index:** The entire table is stored in a columnar format. This is ideal for large fact tables in a data warehouse. A table can have only one clustered columnstore index.
- **Non-Clustered Columnstore Index:** A secondary, columnar index on a traditional rowstore table. This is useful for enabling fast analytics on an operational (OLTP) table without converting the entire table to a columnstore.

---

May also what to check out: https://microsoftlearning.github.io/dp-300-database-administrator/Instructions/Labs/07-detect-correct-fragmentation-issues.html

In this step, we'll explore how indexes can become fragmented and how to fix them. Fragmented indexes can lead to poor query performance because they require more I/O to read.

We will be working within the `AdventureWorksLT2022` database.

First, connect to the database:
`sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd' -d AdventureWorksLT2022`{{exec}}

## Create a Table for Demonstration

Let's create a new table to work with. This table will store customer information. We'll use a `UNIQUEIDENTIFIER` as the primary key to easily generate fragmentation.

```sql
CREATE TABLE dbo.Customers (
    CustomerID UNIQUEIDENTIFIER PRIMARY KEY,
    CustomerName NVARCHAR(100),
    RegistrationDate DATETIME
);
GO
```{{exec}}

The `PRIMARY KEY` constraint automatically creates a clustered index on the `CustomerID` column.

## Create a Non-Clustered Index

Let's also create a non-clustered index on the `RegistrationDate` column, as we might often query for customers who registered on a certain date.

```sql
CREATE NONCLUSTERED INDEX IX_Customers_RegistrationDate ON dbo.Customers(RegistrationDate);
GO
```{{exec}}

## Check Initial Fragmentation

Now, let's check the initial state of our indexes. We'll use the `sys.dm_db_index_physical_stats` DMV. A value for `avg_fragmentation_in_percent` close to 0 is ideal.

```sql
SELECT
    i.name AS IndexName,
    ps.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID('dbo.Customers'), NULL, NULL, 'SAMPLED') AS ps
JOIN sys.indexes AS i ON ps.object_id = i.object_id AND ps.index_id = i.index_id
WHERE i.name IS NOT NULL;
GO
```{{exec}}

You should see that the fragmentation is very low or zero.

## Simulate Fragmentation

Index fragmentation occurs when the logical ordering of pages in an index does not match the physical ordering on disk. This is often caused by inserting data out of order, which leads to "page splits".

We can simulate this by inserting a large number of rows with random `CustomerID` values (using `NEWID()`).

```sql
INSERT INTO dbo.Customers (CustomerID, CustomerName, RegistrationDate)
SELECT TOP 10000 NEWID(), 'Customer ' + CAST(ROW_NUMBER() OVER (ORDER BY a.object_id) AS VARCHAR(10)), GETDATE() - (ROW_NUMBER() OVER (ORDER BY a.object_id) % 365)
FROM sys.all_objects a, sys.all_objects b;
GO
```{{exec}}

This query inserts 10,000 random customer records.

## Check Fragmentation Again

Now, let's run our fragmentation check query again.

```sql
SELECT
    i.name AS IndexName,
    ps.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID('dbo.Customers'), NULL, NULL, 'SAMPLED') AS ps
JOIN sys.indexes AS i ON ps.object_id = i.object_id AND ps.index_id = i.index_id
WHERE i.name IS NOT NULL;
GO
```{{exec}}

You should now see a significantly higher `avg_fragmentation_in_percent`, especially for the clustered index. This is because the random GUIDs for `CustomerID` caused data to be inserted all over the index, leading to many page splits.

## Fixing Fragmentation

There are two main ways to fix index fragmentation: `REORGANIZE` and `REBUILD`.

### 1. REORGANIZE (The "Lighter" Fix)

`REORGANIZE` defragments the leaf level of the index by physically reordering the pages to match the logical order. It's generally less resource-intensive than a rebuild and is an online operation in SQL Server Enterprise Edition.

Let's reorganize our non-clustered index:
```sql
ALTER INDEX IX_Customers_RegistrationDate ON dbo.Customers REORGANIZE;
GO
```{{exec}}

And check the fragmentation for just that index:
```sql
SELECT
    i.name AS IndexName,
    ps.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID('dbo.Customers'), (SELECT index_id FROM sys.indexes WHERE name = 'IX_Customers_RegistrationDate'), NULL, 'SAMPLED') AS ps
JOIN sys.indexes AS i ON ps.object_id = i.object_id AND ps.index_id = i.index_id;
GO
```{{exec}}

You should see the fragmentation has been reduced.

### 2. REBUILD (The "Heavier" Fix)

`REBUILD` drops and recreates the index. This is more thorough and removes all fragmentation, but it's also more resource-intensive. In SQL Server Standard Edition, this is an offline operation that will block queries.

Let's rebuild our clustered index:
```sql
ALTER INDEX ALL ON dbo.Customers REBUILD;
GO
```{{exec}}

Now let's check the fragmentation one last time for all indexes on the table:
```sql
SELECT
    i.name AS IndexName,
    ps.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID('dbo.Customers'), NULL, NULL, 'SAMPLED') AS ps
JOIN sys.indexes AS i ON ps.object_id = i.object_id AND ps.index_id = i.index_id
WHERE i.name IS NOT NULL;
GO
```{{exec}}

The fragmentation should now be back to near zero for all indexes.

Finally, exit `sqlcmd`:
```sql
quit
```{{exec}}
