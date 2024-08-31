
# Initial Setup

Quickstart: Use Data API builder with SQL [link](https://learn.microsoft.com/en-gb/azure/data-api-builder/quickstart-sql)

These quickstarts inc docker for cosmos, postgreSQL. MySQL


WIP Install c# debugger in VSC



`sudo apt update`{{exec}}

`apt install -y curl git sqlite3 libpq-dev libreadline-dev sqlite`{{exec}}

## WIP install dotnet


```
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
```{{exec}}

```
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-8.0
```{{exec}}

and verify the install:

`dotnet --version`{{exec}}

## Run Docker sql, redis and azurite

open a new tab and setup the servers.


**SQL**

[link to deploy mssql on docker](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-deployment?view=sql-server-ver16&pivots=cs1-bash)

WIP copy from dotnet lab

`docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=MyP@ssW0rd' -p 1433:1433 --name sql_server_container -d mcr.microsoft.com/mssql/server`{{exec}}

WIP  -give a name to the container

`docker exec -it sql_server_container "bash"`{{exec}}

connect

`/opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P 'MyP@ssW0rd' -C`{{exec}}

WIP need -C in docker 'trust server certificatee'

WIP cut and paste does work well in the docker, may be better to run sql cmds locally

to install sqlcmd locally if needed:

```
curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"
apt-get update
apt-get install sqlcmd
sqlcmd -?
```{{exec}}

`sqlcmd -S localhost -U SA -P 'MyP@ssW0rd'`{{exec}}


https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver16&tabs=go%2Cwindows&pivots=cs1-bash

Create a new bookshelf database

```
DROP DATABASE IF EXISTS bookshelf;
GO

CREATE DATABASE bookshelf;
GO

USE bookshelf;
GO
```{{copy}}

Create a new dbo.authors table

```
DROP TABLE IF EXISTS dbo.authors;
GO

CREATE TABLE dbo.authors
(
    id int not null primary key,
    first_name nvarchar(100) not null,
    middle_name nvarchar(100) null,
    last_name nvarchar(100) not null
)
GO

INSERT INTO dbo.authors VALUES
    (01, 'Henry', null, 'Ross'),
    (02, 'Jacob', 'A.', 'Hancock'),
    (03, 'Sydney', null, 'Mattos'),
    (04, 'Jordan', null, 'Mitchell'),
    (05, 'Victoria', null, 'Burke'),
    (06, 'Vance', null, 'DeLeon'),
    (07, 'Reed', null, 'Flores'),
    (08, 'Felix', null, 'Henderson'),
    (09, 'Avery', null, 'Howard'),
    (10, 'Violet', null, 'Martinez')
GO
```{{copy}}

and exit the sqlcmd:

`exit`{{exec}}


