# Indexing



To index a database in MySQL, you can use the CREATE INDEX statement. Here's an example of indexing the sakila database:

1. Connect to the MySQL server using the command-line client or a tool like MySQL Workbench.

2. Select the sakila database:

   ```sql
   USE sakila;
   ```

3. Identify the table and column(s) you want to index. For example, let's say we want to index the `film` table based on the `title` column:

   ```sql
   CREATE INDEX idx_film_title ON film (title);
   ```

   This creates an index named `idx_film_title` on the `title` column of the `film` table.

4. You can also create composite indexes on multiple columns. For example, let's create an index on the `film` table based on both the `release_year` and `rating` columns:

   ```sql
   CREATE INDEX idx_film_release_rating ON film (release_year, rating);
   ```

   This creates an index named `idx_film_release_rating` on the `release_year` and `rating` columns of the `film` table.

Indexes can significantly improve the performance of queries by allowing the database to quickly locate the required data. However, keep in mind that adding indexes can also impact the performance of write operations (inserts, updates, and deletes), as the database needs to update the index as well. Therefore, it's important to carefully consider the columns to index based on the specific needs of your application.