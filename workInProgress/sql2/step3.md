# Indexing



To index a database in MySQL, you can use the CREATE INDEX statement. Here's an example of indexing the sakila database:

1. Connect to the MySQL server using the command-line client or a tool like MySQL Workbench.

`DESCRIBE film;`{{exec}}

`SHOW INDEX FROM film;`{{exec}}

In MySQL, the most commonly used index type is BTREE. BTREE is a balanced tree data structure that allows for efficient searching, insertion, and deletion operations. It organizes the data in a sorted order, making it suitable for a wide range of queries.

Apart from BTREE, MySQL also supports other index types, including:

- HASH: This index type is suitable for exact match lookups. It uses a hash function to map the index key values to a specific location in the index structure. However, it does not support range queries or sorting.

- FULLTEXT: This index type is used for full-text searches on text-based columns. It enables efficient searching for words or phrases within the indexed column.

- SPATIAL: This index type is used for spatial data types, such as geometries. It allows for efficient spatial queries, such as finding points within a certain distance or polygons that intersect.

- RTREE: This index type is specifically designed for spatial data types and supports efficient indexing and querying of multidimensional data.


2. Select the sakila database:

   `USE sakila;`{{exec}}
  

3. Identify the table and column(s) you want to index. For example, let's say we want to index the `film` table based on the `title` column:

   `CREATE INDEX idx_film_title ON film (title);`{{exec}}
   

   This creates an index named `idx_film_title` on the `title` column of the `film` table.

   `SHOW INDEX FROM film;`{{exec}}

   Since this makes a second index on title, we'll remove.

   `ALTER TABLE film DROP INDEX idx_film_title;`{{exec}}

4. You can also create composite indexes on multiple columns. For example, let's create an index on the `film` table based on both the `release_year` and `rating` columns:

   `CREATE INDEX idx_film_release_rating ON film (release_year, rating);`{{exec}}

`SHOW INDEX FROM film;`{{exec}}
  

   This creates an index named `idx_film_release_rating` on the `release_year` and `rating` columns of the `film` table.

Indexes can significantly improve the performance of queries by allowing the database to quickly locate the required data. However, keep in mind that adding indexes can also impact the performance of write operations (inserts, updates, and deletes), as the database needs to update the index as well. Therefore, it's important to carefully consider the columns to index based on the specific needs of your application.

To determine if an index is effective in MySQL, you can use the `EXPLAIN` statement. The `EXPLAIN` statement provides information about how MySQL executes a query, including the indexes used.

Here's an example of how to use `EXPLAIN`:

```sql
EXPLAIN SELECT * FROM table_name WHERE column_name = 'value';
```

Replace `table_name` with the name of the table you want to query, and `column_name` with the name of the column you want to filter on. `'value'` should be replaced with the actual value you want to filter on.

The `EXPLAIN` statement will return a result set with information about the query execution plan. Look for the `key` column in the result set. If the `key` column shows the name of the index being used, it indicates that the index is effective for the query. If the `key` column is `NULL`, it means that the query is not using any index.

Additionally, you can use tools like the MySQL Workbench or command-line tools like `mysqltuner` or `pt-index-usage` to analyze the effectiveness of indexes in your database. These tools provide more detailed insights into index usage and can help identify potential performance improvements.