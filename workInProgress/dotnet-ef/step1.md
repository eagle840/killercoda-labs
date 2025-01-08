
# Initial Setup


See dotnet lab for intro

This may prove better? https://learn.microsoft.com/en-us/aspnet/core/data/ef-rp/intro?view=aspnetcore-8.0&tabs=visual-studio

https://learn.microsoft.com/en-us/ef/

## Install c# debugger in VSC


# WIP with asdf

https://github.com/hensou/asdf-dotnet

`sudo apt update`{{exec}}

`apt install -y curl git sqlite3 libpq-dev libreadline-dev sqlite`{{exec}}

## WIP install dotnet

asdf isn't working with global dotnet tools

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

WIP copy from dotnet lab



`docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=MyP@ssW0rd' -p 1433:1433 --name sql_server_container -d mcr.microsoft.com/mssql/server`{{copy}}

**Redis**

`docker run -d --name redis-server -p 6379:6379 redis`{{exec}}

**Azurite (blob?)**

https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite?tabs=docker-hub

`docker run -d -p 10000:10000 -p 10001:10001 -p 10002:10002 mcr.microsoft.com/azure-storage/azurite`{{exec}}

## db management

WIP not docker, you need direct file access (or give container access)

`docker run -d -p 8080:8080 adminer`{{exec}}

https://www.adminer.org/

WIP might have to attach a folder/file/db to docker to connect to local files

Or just use mysql or similar




