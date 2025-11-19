# Page 4: Query Tuning & Execution Plans

In this step, we will delve into the critical process of optimizing SQL Server queries by understanding and utilizing execution plans. Execution plans are visual representations of the data retrieval strategy chosen by the SQL Server query optimizer. By analyzing these plans, we can identify bottlenecks and areas for improvement in our queries.

We will continue working within the `AdventureWorksLT2022` database.

First, connect to the database:
`sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd' -d AdventureWorksLT2022`{{exec}}

## Understanding Execution Plans

An execution plan describes the methods SQL Server uses to execute a query. It shows the sequence of operations, the order in which tables are accessed, the indexes used, and how data is joined, filtered, and sorted.

There are two main types of execution plans:
*   **Estimated Execution Plan:** Generated before the query is executed, based on statistics and schema information.
*   **Actual Execution Plan:** Generated after the query is executed, providing runtime information such as the number of rows processed and the actual time taken for each operation.

For our purposes, we will focus on understanding the concepts and how to interpret them. In a real-world scenario, you would typically use SQL Server Management Studio (SSMS) or Azure Data Studio to visually inspect these plans.

## Capturing and Interpreting Execution Plans

While `sqlcmd` doesn't provide a graphical execution plan, we can still generate the XML representation of the plan, which contains all the detailed information.

### Estimated Execution Plan

To get an estimated execution plan, we use `SET SHOWPLAN_XML ON`.

```sql
SET SHOWPLAN_XML ON;
GO

SELECT
    p.Name AS ProductName,
    pc.Name AS CategoryName,
    pm.Name AS ModelName
FROM
    SalesLT.Product AS p
INNER JOIN
    SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
INNER JOIN
    SalesLT.ProductModel AS pm ON p.ProductModelID = pm.ProductModelID
WHERE
    p.Color = 'Black' AND p.ListPrice > 100;
GO

SET SHOWPLAN_XML OFF;
GO
```{{exec}}

This command will output a large XML string. In a graphical tool, this XML would be rendered into a visual plan. Key elements to look for in the XML (or graphical plan) include:
*   **Operators:** Such as `Table Scan`, `Index Scan`, `Index Seek`, `Nested Loops`, `Hash Match`, `Merge Join`, `Sort`, `Compute Scalar`, etc.
*   **Costs:** Each operator has an associated cost, indicating its relative expense.
*   **Warnings:** Such as missing indexes or implicit conversions.

### Actual Execution Plan (with runtime statistics)

To get actual runtime statistics, we use `SET STATISTICS IO ON` and `SET STATISTICS TIME ON`. These commands provide detailed information about disk I/O and CPU time used by the query.

```sql
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

SELECT
    p.Name AS ProductName,
    pc.Name AS CategoryName,
    pm.Name AS ModelName
FROM
    SalesLT.Product AS p
INNER JOIN
    SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
INNER JOIN
    SalesLT.ProductModel AS pm ON p.ProductModelID = pm.ProductModelID
WHERE
    p.Color = 'Black' AND p.ListPrice > 100;
GO

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
```{{exec}}

The output will show:
*   **Table 'TableName'. Scan count X, logical reads Y, physical reads Z, read-ahead reads A.**
    *   `logical reads`: Number of data pages read from the buffer cache. High logical reads often indicate inefficient indexing or large table scans.
    *   `physical reads`: Number of data pages read from disk. High physical reads are very expensive and indicate data is not in memory.
*   **SQL Server parse and compile time: CPU time = X ms, elapsed time = Y ms.**
*   **SQL Server Execution Times: CPU time = A ms, elapsed time = B ms.**

## Identifying Expensive Operators

Some operators are inherently more expensive than others.
*   **Table Scan:** Reads every row in a table. Very expensive for large tables without appropriate filtering.
*   **Index Scan:** Reads all rows in an index. Can be efficient if the index is small and covers the query, but less efficient than an Index Seek.
*   **Index Seek:** Locates specific rows in an index. This is generally the most efficient way to retrieve data using an index.
*   **Nested Loops Join:** For each row in the outer input, it scans the inner input. Can be efficient for small outer inputs and indexed inner inputs.
*   **Hash Match Join:** Builds a hash table on one input and probes it with the other. Good for large, unsorted inputs.
*   **Merge Join:** Requires both inputs to be sorted. Very efficient if inputs are already sorted.
*   **Sort:** An expensive operation, especially for large datasets, as it requires memory and potentially spills to disk.

## Tuning Queries with Indexing and Rewrite Strategies

Based on our analysis of execution plans and statistics, we can apply various tuning strategies.

### 1. Add or Modify Indexes

If an execution plan shows `Table Scan` or `Index Scan` on a large table where an `Index Seek` would be more appropriate, consider adding a non-clustered index on the columns used in the `WHERE` clause, `JOIN` conditions, or `ORDER BY` clauses.

Let's create an index that might help our previous query:

```sql
CREATE NONCLUSTERED INDEX IX_Product_Color_ListPrice ON SalesLT.Product (Color, ListPrice);
GO
```{{exec}}

Now, re-run the query with `SET SHOWPLAN_XML ON` and `SET STATISTICS IO, TIME ON` to see if the plan changes and if the logical/physical reads decrease.

### 2. Rewrite Queries

Sometimes, the way a query is written can prevent the optimizer from choosing the most efficient plan.
*   **Avoid `SELECT *`:** Only select the columns you need.
*   **Use `EXISTS` instead of `IN`** for subqueries when checking for existence.
*   **Avoid functions in `WHERE` clauses:** Applying functions to indexed columns can prevent index usage (e.g., `WHERE YEAR(OrderDate) = 2023`). Instead, rewrite as `WHERE OrderDate >= '2023-01-01' AND OrderDate < '2024-01-01'`.
*   **Simplify `JOIN` conditions:** Ensure `JOIN` predicates are simple and can utilize indexes.

### 3. Consider `INCLUDE` Columns in Non-Clustered Indexes

If a non-clustered index is used for filtering, but the query also selects columns not in the index, SQL Server might perform a "bookmark lookup" or "key lookup" to retrieve the additional columns from the clustered index or heap. This is an expensive operation. You can avoid this by adding the selected columns to the `INCLUDE` clause of the non-clustered index, making it a "covering index."

```sql
-- Example of a covering index for our query
CREATE NONCLUSTERED INDEX IX_Product_Color_ListPrice_Covering ON SalesLT.Product (Color, ListPrice) INCLUDE (Name, ProductCategoryID, ProductModelID);
GO
```{{exec}}

### 4. Update Statistics

SQL Server uses statistics to estimate the number of rows that will be returned by a query. Outdated statistics can lead to poor execution plans. While SQL Server automatically updates statistics, manual updates might be necessary after significant data changes.

```sql
UPDATE STATISTICS SalesLT.Product;
GO
```{{exec}}

Finally, exit `sqlcmd`:
```sql
quit
```{{exec}}