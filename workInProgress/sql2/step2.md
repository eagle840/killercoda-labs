# Transactions

Here is an example of a transaction using the sakila database in MySQL:

```sql
START TRANSACTION;

-- Step 1: Perform some operations (e.g., insert, update, delete)
INSERT INTO film (title, release_year) VALUES ('New Film', 2022);
UPDATE actor SET first_name = 'John' WHERE actor_id = 1;

-- Step 2: Perform some additional operations based on previous changes
DELETE FROM film WHERE release_year < 2000;
INSERT INTO actor (first_name, last_name) VALUES ('Jane', 'Doe');

-- Commit the transaction
COMMIT;
```

In this example, a transaction is started using the `START TRANSACTION` statement. Then, some operations are performed, like inserting a new film and updating an actor's first name. After that, additional operations are performed based on the changes made in the previous steps, like deleting films released before the year 2000 and inserting a new actor named Jane Doe. Finally, the `COMMIT` statement is used to commit the changes made in the transaction and make them permanent in the database.

If any error occurs during the transaction, you can roll back the changes using the `ROLLBACK` statement instead of committing them, ensuring that the database remains in