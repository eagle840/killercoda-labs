# Docker

https://github.com/dotnet/dotnet-docker

`cd ~`{{exec}}

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

`docker run -d --rm --name dotnet-app -p 8080:8080 mywebapp`{{exec}}

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

`docker images`{{exec}}

Open the Editor tab

Install the C# extension




`mkdir .vscode`{{exec}}

`nano .vscode/launch.json`{{exec}}

```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": ".NET Core Docker Attach",
            "type": "coreclr",
            "request": "attach",
            "processId": "${command:pickRemoteProcess}",
            "pipeTransport": {
                "pipeProgram": "docker",
                "pipeArgs": [ "exec", "-i", "csharp" ],
                "debuggerPath": "/root/vsdbg/vsdbg",
                "pipeCwd": "${workspaceRoot}",
                "quoteArgs": false
            },
            "sourceFileMap": {
                "/work": "${workspaceRoot}/c#/src/"
            }
        },
        {
            "name": "Remote Docker",
            "type": "go",
            "request": "launch",
            "mode": "remote",
            "remotePath":"/go/src/work/",
            "port": 2345,
            "host": "127.0.0.1",
            "program": "${workspaceFolder}/golang/src/",
            "args": [],
            "trace" : "verbose",
            "env" : {}
        }
    ]
}
```

https://code.visualstudio.com/docs/editor/debugging

https://code.visualstudio.com/docs/csharp/get-started

asp.net on docker https://code.visualstudio.com/docs/containers/quickstart-aspnet-core

https://code.visualstudio.com/docs/remote/remote-overview



`docker run -d --rm --name dotnet-app -p 8080:8080 mywebapp`{{exec}}

WIP not showing right (run locally to see)

{{TRAFFIC_HOST1_8080}}

`docker stop dotnet-app`{{exec}}

