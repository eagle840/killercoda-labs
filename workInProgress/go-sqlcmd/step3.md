# Step 3: Interactive Mode and Scripting

In this step, you'll learn how to use `sqlcmd`'s interactive mode and how to execute scripts saved in `.sql` files.

## Interactive Mode

Running `sqlcmd` without a query starts an interactive session. This allows you to type and execute T-SQL statements directly.

1.  **Start an interactive session:**

    ```bash
    sqlcmd
    ```{{exec}}

2.  **Switch to the correct database context:**
    Once in the interactive session, you can run any T-SQL command. Let's switch to the `AdventureWorksLT` database.

    ```sql
    USE AdventureWorksLT;
    GO
    ```

3.  **Run a query:**
    Now you can query the tables in that database.

    ```sql
    SELECT TOP 5 ProductID, Name, ListPrice FROM SalesLT.Product;
    GO
    ```

4.  **Exit the session:**
    Type `exit` to end the interactive session and return to your shell.

    ```sql
    exit
    ```

## Executing Scripts from a File

For more complex operations, it's common to save your SQL commands in a script file and execute it with `sqlcmd`.

1.  **Create a SQL script file:**
    First, let's create a simple script file named `products.sql`.

    ```bash
    cat <<EOF > products.sql
    USE AdventureWorksLT;
    GO
    SELECT Name, Color, Size
    FROM SalesLT.Product
    WHERE Color = 'Red';
    GO
    EOF
    ```{{exec}}

2.  **Execute the script using the `-i` flag:**
    The `-i` flag tells `sqlcmd` to read its input from the specified file.

    ```bash
    sqlcmd -i products.sql
    ```{{exec}}

## Special `sqlcmd` Commands

`sqlcmd` has its own set of commands that are not T-SQL. These commands, which are often prefixed with a colon (`:`), provide additional functionality.

1.  **:List**
    The `:List` command shows the content of the statement buffer.

    ```sql
    :List
    ```

2.  **:Help**
    The `:Help` command displays a list of available `sqlcmd` commands and their descriptions.

    ```sql
    :Help
    ```

Next, we will explore how to restore a database from a backup file.