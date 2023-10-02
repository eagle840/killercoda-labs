# Hello World! using ASP

WIP build it in Linx first, and then run in docker

docs: https://learn.microsoft.com/en-us/aspnet/core/?view=aspnetcore-7.0


`lsb_release -a`{{exec}}

https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-2004

Add the Microsoft package repository

```
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
```{{exec}}



Install the SDK
```
sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0
```{{exec}}


Install the runtime
```
sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-7.0
```{{exec}}

`dotnet --info`{{exec}}

dotnet new webapp -o MyApp  # wip check templates (you really need an api, but 1st try spa to make sure it works in docker.)

cd MyApp

dotnet add package Microsoft.AspNetCore.SpaServices.Extensions  #WIP

review process to build a asp.net app




