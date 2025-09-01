# Step 4: Restoring a Database from a Backup

A common and powerful feature of `go-sqlcmd` is its ability to create a new SQL Server container and restore a database from a backup file in a single command.

## Restore from a Remote Backup File

You can point `go-sqlcmd` to a backup file hosted on the internet, and it will handle the download and restore process for you.

1.  **Create a new instance from a remote `.bak` file:**
    Let's create a new SQL Server container named `sql-wwi` and restore the `WideWorldImporters` sample database from its backup file on GitHub.

    ```bash
    sqlcmd create mssql --name sql-wwi --accept-eula --using https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak
    ```{{exec}}

2.  **Verify the new instance:**
    Check your running Docker containers. You should now see two SQL Server instances: the original one and the new `sql-wwi` instance.

    ```bash
    docker ps
    ```{{exec}}

3.  **Connect and Query the new instance:**
    You can connect to this new instance by specifying its port. Since it's the second instance, it will likely be running on port 1434. Let's query the `Application.People` table.

    ```bash
    sqlcmd -S localhost,1434 -Q "SELECT TOP 5 FullName, EmailAddress FROM Application.People"
    ```{{exec}}

## Restore from a Local Backup File

If you have a backup file on your local machine, you can use it in the same way.

1.  **Download a backup file:**
    First, let's download a backup file to our local environment.

    ```bash
    wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2017.bak
    ```{{exec}}

2.  **Create an instance from the local file:**
    Now, use the `create` command, pointing the `--using` flag to the path of the local file.

    ```bash
    sqlcmd create mssql --name sql-aw --accept-eula --using ./AdventureWorks2017.bak
    ```{{exec}}

3.  **Verify and connect:**
    Check that the new `sql-aw` container is running and connect to it to run a query. This third instance will likely be on port 1435.

    ```bash
    docker ps
    ```{{exec}}

    ```bash
    sqlcmd -S localhost,1435 -Q "SELECT TOP 5 JobTitle, Gender FROM HumanResources.Employee"
    ```{{exec}}

In the next step, we will look at how `go-sqlcmd` handles errors.