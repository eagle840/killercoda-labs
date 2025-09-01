# Step 6: Working with Variables

`sqlcmd` allows you to use scripting variables to make your scripts more flexible and powerful. You can define variables within a script or pass them in from the command line.

## Declaring and Using Variables with `:setvar`

You can use the `:setvar` command to declare a variable and assign it a value within your script.

1.  **Create a script that uses a variable:**
    Let's create a script named `vars.sql` that declares a variable `Country` and uses it in a `WHERE` clause.

    ```bash
    cat <<EOF > vars.sql
    :setvar Country "Canada"
    
    USE AdventureWorksLT;
    GO

    SELECT CustomerID, CompanyName, EmailAddress
    FROM SalesLT.Customer
    WHERE CountryRegion = $(Country);
    GO
    EOF
    ```{{exec}}

2.  **Execute the script:**
    The `$(Country)` syntax is used to reference the variable.

    ```bash
    sqlcmd -i vars.sql
    ```{{exec}}

## Passing Variables from the Command Line

For greater flexibility, you can pass variables to your script from the command line using the `-v` flag. This is especially useful in automated environments.

1.  **Create a more generic script:**
    This script, `generic_vars.sql`, expects a variable named `Color` to be passed in.

    ```bash
    cat <<EOF > generic_vars.sql
    USE AdventureWorksLT;
    GO
    SELECT ProductID, Name, ListPrice
    FROM SalesLT.Product
    WHERE Color = $(Color);
    GO
    EOF
    ```{{exec}}

2.  **Execute the script and pass a variable:**
    Now, run the script and set the `Color` variable to 'Blue' using the `-v` flag.

    ```bash
    sqlcmd -i generic_vars.sql -v Color="Blue"
    ```{{exec}}

3.  **Reuse the script with a different variable:**
    You can easily run the same script with a different value for the `Color` variable.

    ```bash
    sqlcmd -i generic_vars.sql -v Color="Silver"
    ```{{exec}}

This concludes the lab on `go-sqlcmd`. You have learned how to install the tool, create SQL Server instances, execute queries, format output, run scripts, restore backups, handle errors, and use variables.
