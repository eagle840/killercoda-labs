# Storec Procedure

Sure! Here's an example of a stored procedure in the sakila database:

```sql
DELIMITER //

CREATE PROCEDURE GetFilmCountByCategory(IN categoryName VARCHAR(255), OUT filmCount INT)
BEGIN
    SELECT COUNT(*) INTO filmCount
    FROM film_category fc
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = categoryName;
END //

DELIMITER ;
```

In this example, we create a stored procedure named `GetFilmCountByCategory` that takes a category name as input and returns the count of films in that category as an output parameter.

To use this stored procedure, you can call it like this:

```sql
SET @categoryName = 'Action';
SET @filmCount = 0;

CALL GetFilmCountByCategory(@categoryName, @filmCount);

SELECT @filmCount;
```

This will set the `@categoryName` variable to 'Action', initialize the `@filmCount` variable to 0, and then call the `GetFilmCountByCategory` stored procedure passing the `@categoryName` and `@filmCount` variables as parameters. Finally, it will select the value of `@filmCount` to display the result.