# Step 2: Basic Querying and Output Formatting

Now that you have a running SQL Server instance, let's explore different ways to execute queries and format the results.

## Executing Queries

`go-sqlcmd` provides several ways to run your queries.

1.  **Using the `query` subcommand:**
    The `query` subcommand is a straightforward way to execute a single query string.

    ```bash
    sqlcmd query "SELECT name FROM sys.databases"
    ```{{exec}}

2.  **Using the `-Q` flag:**
    The `-Q` flag provides an alternative way to pass a query string. It is useful for quick, one-off queries.

    ```bash
    sqlcmd -Q "SELECT TOP 5 CustomerID, CompanyName FROM SalesLT.Customer"
    ```{{exec}}

3.  **Using a heredoc for multi-line queries:**
    For longer or more complex queries, you can use a `heredoc` to pass a multi-line script to the `query` subcommand.

    ```bash
    sqlcmd query <<EOF
    USE AdventureWorksLT;
    SELECT TOP 3 ProductID, Name, Color
    FROM SalesLT.Product
    WHERE Color = 'Black';
    GO
    EOF
    ```{{exec}}

## Formatting Query Output

`go-sqlcmd` gives you fine-grained control over how the query results are displayed.

1.  **Vertical Formatting (`-F vertical`):**
    The default output is horizontal, which can be hard to read for tables with many columns. The `vertical` format displays each column on a new line, which is often more readable.

    Compare the default output:
    ```bash
    sqlcmd -Q "SELECT @@SERVERNAME, DB_NAME()"
    ```{{exec}}

    With the vertical output:
    ```bash
    sqlcmd -Q "SELECT @@SERVERNAME, DB_NAME()" -F vertical
    ```{{exec}}

2.  **Controlling Column Width (`-y` and `-Y`):**
    You can control the width of the output columns to prevent text from being truncated or wrapping.
    - `-y`: Sets the maximum width for variable-length data types.
    - `-Y`: Sets the width for fixed-length data types.

    This command sets the display width for variable-length columns to 30 characters.
    ```bash
    sqlcmd -y 30 -Q "SELECT Name, ProductNumber, Color FROM SalesLT.Product"
    ```{{exec}}

In the next step, we will look at using `sqlcmd` in interactive mode and running scripts from files.