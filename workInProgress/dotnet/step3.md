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
COPY . .
RUN dotnet build -c Release
RUN dotnet publish -c Release -o out
ENTRYPOINT ["dotnet", "out/myWebApp.dll"]
```

`docker build -t mywebapp .`{{exec}}

WIP Build failed

`docker images`{{exec}}

`docker run -d -p 8080:80 mywebapp`{{exec}}

# debug docker

https://github.com/marcel-dempers/docker-development-youtube-series/tree/part5



