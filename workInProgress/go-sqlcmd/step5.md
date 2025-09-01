# Step 5: Error Handling and Debugging

Understanding how `go-sqlcmd` reports errors is crucial for troubleshooting your scripts. In this step, you'll see how to interpret and handle common errors.

## Syntax Errors

Syntax errors occur when your T-SQL code is not valid.

1.  **Introduce a syntax error:**
    Let's try to run a query with an invalid keyword, `SELECTT` instead of `SELECT`.

    ```bash
    sqlcmd -Q "SELECTT TOP 5 * FROM SalesLT.Customer"
    ```{{exec}}

    `go-sqlcmd` will return a non-zero exit code and print a detailed error message from SQL Server, indicating the incorrect syntax and the line number where the error occurred.

## Object Not Found Errors

This type of error happens when you try to query an object (like a table or view) that does not exist.

1.  **Query a non-existent table:**
    Let's attempt to select from a table named `SalesLT.Customerss` (with an extra 's').

    ```bash
    sqlcmd -Q "SELECT * FROM SalesLT.Customerss"
    ```{{exec}}

    The output clearly states "Invalid object name," helping you quickly identify the typo in your script.

## Connection Errors

Connection errors occur when `go-sqlcmd` cannot reach the database server.

1.  **Attempt to connect to a non-existent server:**
    Let's try connecting to a server on a port that is not open, for example, `localhost,9999`.

    ```bash
    sqlcmd -S localhost,9999 -Q "SELECT 1"
    ```{{exec}}

    The tool will time out and report a network-related error, indicating that it could not establish a connection to the specified server.

## The `:On Error` Command

Within an interactive session or a script, you can use the `:On Error` command to control how `sqlcmd` behaves when it encounters an error.

- `:On Error exit`: This will cause the `sqlcmd` script or session to terminate immediately if an error occurs.
- `:On Error ignore`: This will cause `sqlcmd` to print the error message but continue executing the script.

1.  **Create a script with an error:**

    ```bash
    cat <<EOF > error_script.sql
    :On Error exit
    SELECT * FROM NonExistentTable;
    GO
    -- This command will not be reached
    SELECT 'This will not be printed';
    GO
    EOF
    ```{{exec}}

2.  **Execute the script:**

    ```bash
    sqlcmd -i error_script.sql
    ```{{exec}}

    Notice that the script execution stops at the first error, and the second `SELECT` statement is never run.

In the next step, you will learn how to make your scripts more dynamic by using variables.