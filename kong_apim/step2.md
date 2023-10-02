# Hello World! using ASP

WIP build it in Linx first, and then run in docker

docs: https://learn.microsoft.com/en-us/aspnet/core/?view=aspnetcore-7.0

`cd ~`{{exec}}


`lsb_release -a`{{exec}}

https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-2004

Add the Microsoft package repository

```
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
```{{exec}}



Install the SDK
`sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0`{{exec}}


Install the runtime
`sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-7.0`{{exec}}

`dotnet --info`{{exec}}


## Build Hello World
`dotnet new webapp -o MyApp`{{exec}}  # wip check templates (you really need an api, but 1st try spa to make sure it works in docker.)

`cd MyApp`{{exec}}

`tree`{{exec}}

`dotnet add package Microsoft.AspNetCore.SpaServices.Extensions`{{exec}}  #WIP

review process to build a asp.net app

`dotnet restore`{{exec}}  nothing is done.

`dotnet build`{{exec}}

`dotnet run`{{exec}}

in another tab

`curl localhost:5204`{{exec}}

`dotnet run --urls=http://0.0.0.0:3000/`{{exec}}

OR set appsettings.json
{ "urls":"http://0.0.0.0:3000" }

using envir
ASPNETCORE_URLS=http://0.0.0.0:3000/

it can also be set in code.

it can also be set in launchsettings.json

# prepare for deploy

`dotnet publish -c Release -o out`{{exec}}

`nano Dockerfile`{{exec}}

```
   FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
   WORKDIR /app

   COPY *.csproj ./
   RUN dotnet restore

   COPY . ./
   RUN dotnet publish -c Release -o out

   FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
   WORKDIR /app
   COPY --from=build /app/out ./

   ENTRYPOINT ["dotnet", "MyApp.dll"]
```


`docker build -y myapp .`{{exec}}

`docker run -p 8080:80 myapp`{{exec}}

## Now for an api

https://learn.microsoft.com/en-us/aspnet/core/tutorials/min-web-api?view=aspnetcore-7.0&tabs=visual-studio-code


`cd ~`{{exec}}

`dotnet new webapi -o MyAPI`{{exec}}

taken from https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-new-sdk-templates


`cd MyAPI/`{{exec}}

`dotnet add package Microsoft.ApplicationInsights.AspNetCore`{{exec}}

WIP restore ??

`dotnet build`{{exec}}

`dotnet run --urls=http://0.0.0.0:3000/`{{exec}}

{{TRAFFIC_HOST1_80}}/swagger/index.html

{{TRAFFIC_HOST1_80/swagger/index.html}}









