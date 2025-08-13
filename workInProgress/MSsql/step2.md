# Lessons


https://learn.microsoft.com/en-us/sql/t-sql/lesson-1-creating-database-objects?view=sql-server-ver17

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
