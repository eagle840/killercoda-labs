# Docker

https://github.com/dotnet/dotnet-docker

`mkdir dock`{{exec}}

`cd dock`{{exec}}

determine the sdk version`

`dotnet --version`{{exec}}

`dotnet new webapp -n myWebApp`{{exec}}

`nano Dockerfile`{{exec}}

WIP try haveing the docker file below myWebApp folder


```
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /
RUN ls
COPY ./  .
RUN ls
RUN ls myWebApp
RUN dotnet build -c Release ./myWebApp/myWebApp.csproj
RUN dotnet publish -c Release -o out ./myWebApp/myWebApp.csproj
RUN ls
RUN ls myWebApp/
ENTRYPOINT ["dotnet", "out/myWebApp.dll"]
```

`docker build -t mywebapp .`{{exec}}

WIP Build failed

`docker images`{{exec}}

`docker run -d --name dotnet-app -p 8080:8080 mywebapp`{{exec}}

WIP not showing right (run locally to see)

{{TRAFFIC_HOST1_8080}}

`docker stop dotnet-app`{{exec}}

# debug docker

WIP kill the running docker (name the container and kill it)

https://github.com/marcel-dempers/docker-development-youtube-series/tree/part5

WIP

`nano Dockerfile`{{exec}}

```
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build


#install debugger for NET Core
RUN apt-get update
RUN apt-get install -y unzip
RUN curl -sSL https://aka.ms/getvsdbgsh | /bin/sh /dev/stdin -v latest -l ~/vsdbg

RUN mkdir /myWebApp/
WORKDIR /myWebApp/

COPY ./myWebApp/myWebApp.csproj /myWebApp/myWebApp.csproj
RUN dotnet restore

COPY ./myWebApp/ /myWebApp/
RUN mkdir /out/
RUN dotnet publish --no-restore --output /out/ --configuration Release

RUN ls 

CMD dotnet run

WORKDIR /
RUN ls
COPY ./  .
RUN ls
RUN ls myWebApp
RUN dotnet build -c Release ./myWebApp/myWebApp.csproj
RUN dotnet publish -c Release -o out ./myWebApp/myWebApp.csproj
RUN ls
RUN ls myWebApp/
ENTRYPOINT ["dotnet", "out/myWebApp.dll"]
```



