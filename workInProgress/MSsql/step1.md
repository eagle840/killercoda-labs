# Docker compose


READ: https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver17&tabs=cli&pivots=cs1-bash

create the file: docker-compose.yml  and paste the yaml file in.

`nano docker-compose.yml`{{execute}}

(ctrl-insert:copy shift-insert:paste)



```yaml
version: '3'

services:

  mssql-dev:
    image: mcr.microsoft.com/mssql/server:2017-latest
    environment:
      SA_PASSWORD: "YourStrong!Passw0rd"
      ACCEPT_EULA: "Y"
      MSSQL_PID: "Developer"
    ports:
      - "1433:1433"
    volumes:
      - "./mssql-data:/var/opt/mssql"
```


and tell docker-compose to start up.

`docker-compose up -d`{{execute}}

and confirm it's running
`docker-compose ps`{{execute}}


you can connect to the container in either way:
`docker exec -it compose1_mysql-dev_1 /bin/bash`{{execute}}

OR

`docker-compose exec  mysql-dev /bin/bash`{{execute}}

and then exit the container when finished
`exit`{{execute}}

### Adminer tool

Lets add the Adminer tool to the yml so we can administor those databases:

``` yaml
    admin:
        image: adminer
        ports:
        - 8080:8080
```

make the port 0.0.0.0:8080

`nano docker-compose.yml`{{execute}}

`docker-compose up -d `{{execute}}

And lets connect and login:


{{TRAFFIC_HOST1_8080}}

Here's the login for the MySQL server. You can get the server name from using `docker-compose ps`

```
system: ms-sql
server: root_mssql-dev_1   (name from `docker-compose ps`)
un: sa
pw: YourStrong!Passw0rd
database: test1 (you can leave blank)
```




## Connect to MS SQL

https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver17&tabs=redhat-install

`cat /etc/os-release`{{exec}}


**Setup to install**

"Install the sqlcmd and bcp SQL Server command-line tools on Linux"

`curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc`{{exec}}

`curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install mssql-tools18 unixodbc-dev`{{exec}}

`echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bash_profile`{{exec}}

`source ~/.bash_profile`{{exec}}

`sqlcmd -?`{{exec}}

`sqlcmd -C -S localhost -U sa -P 'YourStrong!Passw0rd'`{{exec}}

Confirm the connection

```
SELECT @@VERSION;
GO
```{{exec}}


`docker exec -it root_mssql-dev_1 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'YourStrong!Passw0rd'`{{exec}}



`docker exec -it root_mssql-dev_1 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "YourStrong!Passw0rd"`{{exec}}

## loadup adventure works bd

url:https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms


these are windows cmd, rewrite for linux

`docker exec -it <container_id_or_name> ls /var/opt/mssql/backup`{{exec}}

`docker cp C:\sqlbak\your_backup_file.bak <container_name>:/var/opt/mssql/backup/`{{exec}}






## Connect via SSMS ???

is this the endpoint?

{{TRAFFIC_HOST1_1433}}

# Configure SQL Server on Linux with the mssql-conf tool

https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-configure-mssql-conf?view=sql-server-ver17

## Add SQL Power shell

https://learn.microsoft.com/en-us/powershell/sql-server/sql-server-powershell?view=sqlserver-ps

### Install PS

https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.5

###################################
# Prerequisites

# Update the list of packages
`sudo apt-get update`{{exec}}

# Install pre-requisite packages.
`sudo apt-get install -y wget apt-transport-https software-properties-common`{{exec}}

# Get the version of Ubuntu
`source /etc/os-release`{{exec}}

# Download the Microsoft repository keys
`wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

# Register the Microsoft repository keys
`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

# Delete the Microsoft repository keys file
`rm packages-microsoft-prod.deb`{{exec}}

# Update the list of packages after we added packages.microsoft.com
`s`udo apt-get update`{{exec}}

###################################
# Install PowerShell
`sudo apt-get install -y powershell`{{exec}}

# Start PowerShell
`pwsh`{{exec}}

### Install PS SQLServer (for SQL Server)


https://www.powershellgallery.com/packages/Sqlserver/22.2.0

`Install-Module -Name SqlServer -RequiredVersion 22.2.0`{{exec}}

### FOr SQL AGENT, uses Module SQLPS
