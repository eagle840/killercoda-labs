# Step 1: Installation and Setup

This step will guide you through the installation of `go-sqlcmd` and the setup of a SQL Server container instance for you to work with.

## Installing `go-sqlcmd`

First, we need to prepare our environment to install the `go-sqlcmd` utility.

1.  **Add the Microsoft package repository key:**
    This command downloads and installs the GPG key for Microsoft's official package repository. This ensures that the packages you download are authentic.

    ```bash
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
    ```{{exec}}

2.  **Register the Microsoft repository:**
    Next, we add the official Microsoft package repository for Ubuntu 22.04 to your system's list of package sources.

    ```bash
    sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/22.04/prod.list)"
    ```{{exec}}

3.  **Update and Install:**
    Now, update your package list and install `go-sqlcmd`.

look
    `sudo apt-get update`{{exec}}

    `sudo apt-get install -y sqlcmd`{{exec}}

4.  **Verify the Installation:**
    Check that `go-sqlcmd` was installed correctly by displaying its help menu.

    ```bash
    sqlcmd -?
    ```{{exec}}

## Creating a SQL Server Instance

With `go-sqlcmd` installed, you can now easily create a local SQL Server container instance. This command will download the latest SQL Server image and restore the `AdventureWorksLT` sample database.

1.  **Create the SQL Server container:**

    ```bash
    sqlcmd create mssql --accept-eula --using https://aka.ms/AdventureWorksLT.bak
    ```{{exec}}

2.  **Verify the container is running:**
    Use the `docker ps` command to confirm that the SQL Server container is up and running.

    ```bash
    docker ps
    ```{{exec}}

## Test the Connection

Finally, let's test the connection to your new SQL Server instance by running a simple query to get the server version.

```bash
sqlcmd query "SELECT @@VERSION"
```{{exec}}

In the next step, you will learn more about executing queries.
