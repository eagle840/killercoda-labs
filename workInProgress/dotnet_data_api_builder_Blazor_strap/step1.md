
# Initial Setup

Quickstart: Use Data API builder with SQL [link](https://learn.microsoft.com/en-gb/azure/data-api-builder/quickstart-sql)

MS Docs: https://learn.microsoft.com/en-gb/azure/data-api-builder/


`sudo apt update`{{exec}}


Open a new tab to start the sql setup, and run

`docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=MyP@ssW0rd' -p 1433:1433 --name sql_server_container -d mcr.microsoft.com/mssql/server`{{exec}}

Now return to the orginal tab to continue the install


`apt install -y curl git sqlite3 libpq-dev libreadline-dev sqlite`{{exec}}

## Install dotnet


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

## Run Docker sql

open a new tab and setup the sql server.


**Setup SQL**

[link to deploy mssql on docker](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-deployment?view=sql-server-ver16&pivots=cs1-bash)


`docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=MyP@ssW0rd' -p 1433:1433 --name sql_server_container -d mcr.microsoft.com/mssql/server`{{copy}}



**install sqlcmd**


```
curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"
apt-get update
apt-get install sqlcmd
sqlcmd -?
#
```{{exec}}

`sqlcmd -?`{{exec}}

and connect to the local database:

`sqlcmd -S localhost -U SA -P 'MyP@ssW0rd'`{{exec}}


https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver16&tabs=go%2Cwindows&pivots=cs1-bash


## Create new database

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

`exit`{{exec}}
