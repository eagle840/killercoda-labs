# Docker compose


READ: https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver17&tabs=cli&pivots=cs1-bash

create the file: docker-compose.yml  and paste the yaml file in.

`nano docker-compose.yml`{{execute}}

(ctrl-insert:copy shift-insert:paste)

WIP compose seems to be crushing, try

`sudo docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=YourStrong:Passw0rd" -p 1433:1433 --name sql1 --hostname sql1 -d  mcr.microsoft.com/mssql/server:2022-latest`{{exec}}

`docker logs sql1`{{exec}}


I think we can remove this:
```yaml
version: '3'

services:

  mssql-dev:
    image: mcr.microsoft.com/mssql/server:2022-latest
    environment:
      SA_PASSWORD: "YourStrong!Passw0rd"
      ACCEPT_EULA: "Y"
      MSSQL_PID: "Developer"
    ports:
      - "1433:1433"
    volumes:
      - "./mssql-data:/var/opt/mssql"
```

things to try:
- check the volume
- what is M& version of this docker-compose file


and tell docker-compose to start up.

`docker-compose up -d`{{execute}}

and confirm it's running
`docker-compose ps`{{execute}}


you can connect to the container in either way:
`docker exec -it compose1_mssql-dev_1 /bin/bash`{{execute}}

OR

`docker-compose exec  mssql-dev /bin/bash`{{execute}}

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

Here's the login for the MySQL server. You can get the server name from using

`docker-compose ps`{{execute}}

having issues?

`docker-compose logs -f`{{execute}}

```
system: ms-sql
server: root_mssql-dev_1   (name from `docker-compose ps`)
un: sa
pw: YourStrong:Passw0rd
database: test1 (you can leave blank)
```




## Connect to MS SQL

https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver17&tabs=redhat-install

`cat /etc/os-release`{{exec}}


**Setup GO sqlcmd**

`curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc`{{exec}}

`add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/22.04/prod.list)"`{{exec}}

`apt-get update`{{exec}}

`apt-get install sqlcmd`{{exec}}

`echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bash_profile`{{exec}}

`source ~/.bash_profile`{{exec}}

`sqlcmd -?`{{exec}}


**Setup to OBDC ? install**

??? There seems to be 2 versions of sqlcmd (GO, and ODBC)

"Install the sqlcmd and bcp SQL Server command-line tools on Linux"

`curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc`{{exec}}

`curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install mssql-tools18 unixodbc-dev`{{exec}}

`echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bash_profile`{{exec}}

`source ~/.bash_profile`{{exec}}

`sqlcmd -?`{{exec}}

## Confirm connection

`sqlcmd -C -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}


```
SELECT @@VERSION;
GO
```{{exec}}

## mssql-cli

Was forked of dbcli (https://www.dbcli.com/)

https://learn.microsoft.com/en-us/sql/tools/mssql-cli?view=sql-server-ver17

Doesn't seem to be in the apt repo?

github show no update in 2 years


This might be a python install (pip mssql-cli)


`docker exec -it root_mssql-dev_1 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'YourStrong:Passw0rd'`{{exec}}



`docker exec -it root_mssql-dev_1 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "YourStrong:Passw0rd"`{{exec}}

## loadup adventure works bd

url: https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms

`wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2022.bak`{{exec}}


https://learn.microsoft.com/en-us/sql/t-sql/statements/restore-statements-transact-sql?view=sql-server-ver17

I think you want to use the lite series, since the ms learn seem to be using the salesLT schema


these are windows cmd, rewrite for linux

`docker exec sql1 mkdir /var/opt/mssql/backup`{{exec}}

`docker cp AdventureWorksLT2022.bak sql1:/var/opt/mssql/backup`{{exec}}

connect to the sql server with sqlcmd

Run the restore command:

```sql
RESTORE FILELISTONLY
FROM DISK = N'/var/opt/mssql/backup/AdventureWorksLT2022.bak';
GO
```

You'll use the LogicalName for the first parameter for **MOVE** and the PhysicalName for **TO**

Then use those names in the restore:


```sql
RESTORE DATABASE AdventureWorksLT2022
FROM DISK = N'/var/opt/mssql/backup/AdventureWorksLT2022.bak'
WITH MOVE 'AdventureWorksLT2022_Data' TO '/var/opt/mssql/data/AdventureWorksLT2022.mdf',
     MOVE 'AdventureWorksLT2022_Log' TO '/var/opt/mssql/data/AdventureWorksLT2022_log.ldf';
GO
```


### Confirm

```sql
EXEC sp_databases;
GO
```{{exec}}

OR

```sql
SELECT name FROM sys.databases;
GO
```{{exec}}

```sql
USE AdventureWorksLT2022;
GO
```{{exec}}

```sql
SELECT name FROM sys.tables;
GO
```{{exec}}



## FYI: for Backup

```sql
BACKUP DATABASE <name>
TO DISK = 'path/name.bak'
```


## Connect via SSMS ???

is this the endpoint?

{{TRAFFIC_HOST1_1433}}

# Configure SQL Server on Linux with the mssql-conf tool

https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-configure-mssql-conf?view=sql-server-ver17

# Add SQL Power shell

https://learn.microsoft.com/en-us/powershell/sql-server/sql-server-powershell?view=sqlserver-ps

## Install PS

https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.5

###################################
### Prerequisites



### Install pre-requisite packages.
`sudo apt-get install -y wget apt-transport-https software-properties-common`{{exec}}

### Download the Microsoft repository keys
`wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb`{{exec}}

### Register the Microsoft repository keys
`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

### Delete the Microsoft repository keys file
`rm packages-microsoft-prod.deb`{{exec}}

### Update the list of packages after we added packages.microsoft.com
`sudo apt-get update`{{exec}}


### Install PowerShell
`sudo apt-get install -y powershell`{{exec}}

### Start PowerShell
`pwsh`{{exec}}

### Install PS SQLServer (for SQL Server)


https://www.powershellgallery.com/packages/Sqlserver/22.2.0

`Install-Module -Name SqlServer -RequiredVersion 22.2.0`{{exec}}

### FOr SQL AGENT, uses Module SQLPS

`docker exec -it --user root sql1 bash`{{exec}}

`/opt/mssql/bin/mssql-conf set sqlagent.enabled true`{{exec}}

`exit`{{exec}} # exit the container

restart the container

`docker restart sql1`{{exec}}
