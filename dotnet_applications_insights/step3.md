# Web APi

Now lets add a API to the solution and alter the web app to call the API

## Create Solution File
`cd ~`{{exec}}

for this project, since to dotnet apps running together, lets create a solution file.

`dotnet new sln -n MySolution`{{exec}}

`dotnet  sln list`{{exec}}

## Create the API

`dotnet new webapi -o TodoApi`{{exec}}

`cd TodoApi`{{exec}}

add the project to the solution file

`dotnet sln ../MySolution.sln add TodoApi.csproj`{{exec}}

If you're running this on your own Windows machine: `dotnet dev-certs https --trust`{{copy}}

`dotnet add package Microsoft.ApplicationInsights.AspNetCore --version 2.18.0`{{exec}}

logging w/ App Insights https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview



add the following to line 6 in Program.cs

```
builder.Services.AddApplicationInsightsTelemetry();
```

In the appsettings.json, update to match:


```
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "*",
  "ApplicationInsights": {
    "ConnectionString": "INSERT CONNECTION STRING HERE"
  }
}
```

WIP also need to add App Insights 'Role' to this so that App insights can tell the difference between Web and API

`dotnet run --urls http://0.0.0.0:5001`{{exec}}

{{TRAFFIC_HOST1_5001}}/swagger

in a new tab

`curl localhost:5001/weatherforecast`{{exec}}

ctrl-c
