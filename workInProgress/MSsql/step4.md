# Schemas


Great question, Nick — especially as you're preparing for the **Azure DP-300 exam**, which covers administering relational databases on Microsoft Azure. Understanding **schemas** in SQL Server is fundamental.

---

### 🔹 What Is a Schema in SQL Server?

In **Microsoft SQL Server**, a **schema** is a **container** that holds database objects such as:

- **Tables**
- **Views**
- **Stored Procedures**
- **Functions**
- **Synonyms**
- **Sequences**

Think of a schema as a **namespace** that helps organize and manage database objects. It allows for **logical grouping** and **security control**.

---

### 🔹 Why Are Schemas Useful?

1. **Security Management**
   You can assign permissions at the schema level, making it easier to manage access to multiple objects.

2. **Organization**
   Schemas help separate objects by function, team, or application. For example:
   - `Sales.Orders`
   - `HR.Employees`

3. **Avoiding Name Conflicts**
   You can have two tables with the same name in different schemas:
   - `Sales.Customers`
   - `Support.Customers`

4. **Deployment and Maintenance**
   Easier to deploy changes or manage objects in bulk.

---

### 🔹 Default Schema

Each user can have a **default schema**. If you don’t specify a schema when creating an object, SQL Server uses the default schema of the user.

Example:
```sql
CREATE TABLE Orders (
    OrderID INT,
    CustomerID INT
);
```
If your default schema is `Sales`, this becomes `Sales.Orders`.

---

### 🔹 Common DP-300 Exam Tips

- Know how to **create**, **alter**, and **drop** schemas.
- Understand how to **assign permissions** to schemas.
- Be familiar with **schema-bound views** and **functions**.
- Practice using **schemas in T-SQL**.

---

Here’s a downloadable SQL script that demonstrates the **common DP-300 exam tips** related to **schemas in SQL Server**:

📄 [Download: `dp300_schema_practice.sql`](blob:https://outlook.office.com/d634d568-685e-496c-8640-8e521031a21a)

---

### ✅ What's Included in the Script

1. **Creating a Schema**
   ```sql
   CREATE SCHEMA Sales AUTHORIZATION dbo;
   ```{{exec}}

2. **Altering a Schema**
   ```sql
   ALTER SCHEMA Sales TRANSFER dbo.Orders;
   ```{{exec}}

3. **Dropping a Schema**
   ```sql
   DROP SCHEMA IF EXISTS TempSchema;
   ```{{exec}}

4. **Assigning Permissions**
   ```sql
   GRANT SELECT, INSERT, UPDATE ON SCHEMA::Sales TO SalesTeamRole;
   ```{{exec}}

5. **Schema-Bound View**
   ```sql
   CREATE VIEW Sales.vwOrderSummary
   WITH SCHEMABINDING
   AS
   SELECT OrderID, CustomerID
   FROM Sales.Orders;
   ```{{exec}}

6. **Schema-Bound Function**
   ```sql
   CREATE FUNCTION Sales.fnGetOrderCount(@CustomerID INT)
   RETURNS INT
   WITH SCHEMABINDING
   AS
   BEGIN
       DECLARE @OrderCount INT;
       SELECT @OrderCount = COUNT(*) FROM Sales.Orders WHERE CustomerID = @CustomerID;
       RETURN @OrderCount;
   END;
   ```{{exec}}

7. **Practicing T-SQL with Schemas**
   ```sql
   INSERT INTO Sales.Orders (OrderID, CustomerID) VALUES (1, 101);
   SELECT * FROM Sales.vwOrderSummary;
   SELECT Sales.fnGetOrderCount(101) AS OrderCount;
   ```{{exec}}

---

In SQL Server — including **Azure SQL Database** — you can apply a variety of **permissions to schemas** to control access and operations on the objects within them.

---

### 🔐 Schema-Level Permissions

Here are the key permissions you can grant on a schema:

| **Permission**     | **Description**                                                                 |
|--------------------|----------------------------------------------------------------------------------|
| `CONTROL`          | Full control over the schema and its objects.                                   |
| `ALTER`            | Allows changes to the schema (e.g., adding/removing objects).                   |
| `REFERENCES`       | Allows creation of foreign key references to objects in the schema.             |
| `SELECT`           | Allows reading data from tables/views in the schema.                            |
| `INSERT`           | Allows inserting data into tables in the schema.                                |
| `UPDATE`           | Allows updating data in tables in the schema.                                   |
| `DELETE`           | Allows deleting data from tables in the schema.                                 |
| `EXECUTE`          | Allows executing stored procedures and functions in the schema.                 |
| `VIEW DEFINITION`  | Allows viewing metadata (e.g., table structure, procedure code).                |
| `TAKE OWNERSHIP`   | Allows taking ownership of the schema.                                          |

---

### 🧪 Example: Granting Permissions on a Schema

```sql
-- Grant SELECT and EXECUTE on the Sales schema to user Nick
GRANT SELECT, EXECUTE ON SCHEMA::Sales TO Nick;
```

You can also **deny** or **revoke** permissions:

```sql
DENY DELETE ON SCHEMA::Sales TO Nick;
REVOKE EXECUTE ON SCHEMA::Sales TO Nick;
```

---

### 🧠 Why Use Schema-Level Permissions?

- **Simplifies security management**: Instead of granting permissions on each object, you grant them once at the schema level.
- **Supports modular design**: You can isolate business logic, data access, and reporting into separate schemas.
- **Improves maintainability**: Easier to audit and manage permissions.

---

# User Permissons with Schemas

You're spot on, Nick — understanding the relationship between **logins**, **database users**, and **schemas** is key to managing security in SQL Server and Azure SQL Database.

Let’s break it down clearly:

---

### 🔐 1. **Login vs. User**

| **Login** | **Database User** |
|-----------|-------------------|
| Exists at the **server level** | Exists at the **database level** |
| Authenticates access to the SQL Server or Azure SQL logical server | Maps to a login and grants access to a specific database |
| Created with `CREATE LOGIN` | Created with `CREATE USER` |
| Can be SQL-auth or Azure AD-auth | Can be mapped to a login or created independently |

---

### 🔗 2. **How They Interact**

- When a user connects to SQL Server or Azure SQL Database:
  1. The **login** is authenticated at the server level.
  2. The login is mapped to a **database user** inside the target database.
  3. The **database user** is granted permissions — including on **schemas**.

Example:
```sql
-- Server-level login
CREATE LOGIN NickLogin WITH PASSWORD = 'StrongPassword!';

-- Database-level user mapped to login
USE YourDatabase;
CREATE USER NickUser FOR LOGIN NickLogin;

-- Grant schema-level permissions
GRANT SELECT, EXECUTE ON SCHEMA::Sales TO NickUser;
```

---

### 🧱 3. **Schema Permissions Are Granted to Database Users**

- Permissions on schemas (like `SELECT`, `EXECUTE`, `ALTER`) are granted to **database users**, **roles**, or **groups**.
- The login itself doesn’t directly interact with schemas — it must be mapped to a user in the database.

---

### 🧠 In Azure SQL Database

- You often use **Azure Active Directory (AAD)** for authentication.
- You can create users like:
  ```sql
  CREATE USER [Nick@yourdomain.com] FROM EXTERNAL PROVIDER;
  GRANT SELECT ON SCHEMA::Sales TO [Nick@yourdomain.com];
  ```

This allows centralized identity management and schema-level access control.

---

Would you like a script that audits all users and their schema-level permissions in your Azure SQL Database? Or a guide to setting up AAD users with schema access?


---


# Stored Procedure


`SHOW PROCEDURE STATUS;`{{exec}}

This query will return a result set with information about all the stored procedures in the current database. The result set will include columns like `Db`, `Name`, `Type`, `Definer`, `Modified`, and `Created`, which provide details about each stored procedure.

Alternatively, you can use the `INFORMATION_SCHEMA` database to retrieve information about stored procedures. The following query can be used:

```
SELECT ROUTINE_NAME
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_TYPE = 'PROCEDURE' AND ROUTINE_SCHEMA = 'sakila';
```

Replace `'your_database_name'` with the name of your database. This query will return the names of all stored procedures in the specified database.



`SHOW CREATE PROCEDURE procedure_name;`{{exec}}


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
