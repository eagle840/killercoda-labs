
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

https://dotnet.microsoft.com/en-us/learn


## Setup Azure

wip Link to free account setup

In Azure, create a Applications Insight resource  WIP link to MS Docs to setup

record the connection string


## Install Dotnet

In this lab we will quickly install Dotnet using ASDF





`apt install -y curl git sqlite3 libpq-dev libreadline-dev sqlite jq`{{exec}}


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


# WIP move this to STEP 3

## USes a sln file?


for this project, since to dotnet apps running together

`dotnet new sln -n MySolution`{{exec}}

`dotnet  sln list`{{exec}}

## Manual Logging

update the appsettings.json

```
"Microsoft.AspNetCore": "Information"


```

in Program.cs addd

`app.UseHttpLogging();`  wip:error

after app.UseHttpsRedirection();

learn more: https://learn.microsoft.com/en-us/aspnet/core/fundamentals/middleware/?view=aspnetcore-8.0
