# Docker Compose Setup

Set up SQL Server 2022 using Docker Compose for easier container management.

**Reference**: https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver17&tabs=cli&pivots=cs1-bash

## Create Data Directory

First, create a directory to persist SQL Server data:

`mkdir mssql-data`{{exec}}

`sudo chown -R 10001:10001 ./mssql-data/`{{exec}}

## Create Docker Compose File

Create the docker-compose.yml file:

`nano docker-compose.yml`{{execute}}

Copy and paste this configuration:

```yaml
version: '3.8'

services:
  mssql-dev:
    image: mcr.microsoft.com/mssql/server:2022-latest
    hostname: mssql-dev
    container_name: mssql-dev
    environment:
      SA_PASSWORD: "YourStrong:Passw0rd"
      ACCEPT_EULA: "Y"
      MSSQL_PID: "Developer"
    ports:
      - "1433:1433"
    volumes:
      - "./mssql-data:/var/opt/mssql"
```{{copy}}

## Start SQL Server

Start the container using Docker Compose:

`docker-compose up -d`{{execute}}

Verify the container is running:

`docker-compose ps`{{execute}}

Check the logs to ensure SQL Server started successfully:

`docker-compose logs mssql-dev`{{execute}}

## Connect to Container

You can connect to the container using:

`docker-compose exec mssql-dev /bin/bash`{{execute}}

Exit when finished:

`exit`{{execute}}




## Install SQL Server Command Line Tools

Install the modern GO-based sqlcmd tool to connect to SQL Server.

**Reference**: https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver17&tabs=redhat-install

**Reference** https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver17&tabs=go%2Cwindows-support&pivots=cs1-bash

Check your Ubuntu version:

`cat /etc/os-release`{{exec}}

**Setup GO-based sqlcmd**

Install the Microsoft repository key:



`curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc`{{exec}}

Add the Microsoft package repository:

`sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/22.04/prod.list)"`{{exec}}

Update package list and install the modern sqlcmd:

`sudo apt-get update`{{exec}}

`sudo apt-get install -y sqlcmd`{{exec}}

Add sqlcmd to your PATH:

`echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc`{{exec}}

`source ~/.bashrc`{{exec}}

Verify installation:

`sqlcmd -?`{{exec}}

**Power Tip** While we're taked the long way to install SQL, run `sqlcmd create mssql --accept-eula --using https://aka.ms/AdventureWorksLT.bak`to do it quickly.

## Test SQL Server Connection

Connect to SQL Server using the GO-based sqlcmd:

`sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}

Test the connection by checking the SQL Server version:

```sql
SELECT @@VERSION;
GO
```{{exec}}

You should see the SQL Server version information displayed.

Exit when finished:

`exit`{{execute}}

## Load AdventureWorks Sample Database

Download and restore the AdventureWorks LT sample database for learning purposes.

**Reference**: https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms

Download the AdventureWorksLT backup file:

`wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2022.bak`{{exec}}

Create a backup directory inside the container and copy the file:

`docker-compose exec mssql-dev mkdir -p /var/opt/mssql/backup`{{exec}}

`docker cp AdventureWorksLT2022.bak mssql-dev:/var/opt/mssql/backup/`{{exec}}

Verify the file was copied:

`docker-compose exec mssql-dev ls /var/opt/mssql/backup/`{{exec}}


## Install PowerShell and SQL Server Module

Install PowerShell for advanced SQL Server management capabilities.

**Reference**: https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.5

Install prerequisite packages:

`sudo apt-get install -y wget apt-transport-https software-properties-common`{{exec}}

Download and register Microsoft repository keys:

`wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`rm packages-microsoft-prod.deb`{{exec}}

Update package list and install PowerShell:

`sudo apt-get update`{{exec}}

`sudo apt-get install -y powershell`{{exec}}

Start PowerShell:

`pwsh`{{exec}}

Install the SQL Server PowerShell module:

`Install-Module -Name SqlServer -RequiredVersion 22.2.0 -Force`{{exec}}

Exit PowerShell:

`exit`{{exec}}

## Enable SQL Server Agent

SQL Server Agent is required for job scheduling and automation.

**Reference**: https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-configure-mssql-conf?view=sql-server-ver17

Access the container as root to configure SQL Server:

`docker-compose exec --user root mssql-dev bash`{{exec}}

Enable SQL Server Agent:

`/opt/mssql/bin/mssql-conf set sqlagent.enabled true`{{exec}}

Exit the container:

`exit`{{exec}}

Restart the container to apply the SQL Agent configuration:

`docker-compose restart mssql-dev`{{exec}}

Verify the container is running:

`docker-compose ps`{{exec}}
