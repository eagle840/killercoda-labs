
# Initial Setup

Quickstart: Use Data API builder with SQL [link](https://learn.microsoft.com/en-gb/azure/data-api-builder/quickstart-sql)

MS Docs: https://learn.microsoft.com/en-gb/azure/data-api-builder/

YT MS Developer: https://www.youtube.com/watch?v=XQRO_uoGhp4


These quickstarts inc docker for cosmos, postgreSQL. MySQL


WIP Install c# debugger in VSC


`sudo apt update`{{exec}}

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

open a new tab and setup the servers.

## Setup Cosmos 

In Azure setup a cosmos resourvce

**create a arm template** to 'custom deploy'

## Install cosmos data migration tool


## Create new database


Put some data here and migrate to cosmos

