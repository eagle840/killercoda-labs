# Web APi

SEE BELOW FOR NODE.JS


**WIP** do this: https://learn.microsoft.com/en-us/dotnet/core/diagnostics/observability-with-otel?view=aspnetcore-8.0


`cd ~`{{exec}}

WIP old remove this `dotnet new web -o TodoApi`{{exec}}

`dotnet new webapi -o TodoApi`{{exec}}

`cd TodoApi`{{exec}}

add the project to the solution file

`dotnet sln ../MySolution.sln add TodoApi.csproj`{{exec}}

wip `dotnet dev-certs https --trust`{{copy}}  # FOr windows machines

`dotnet add package Microsoft.ApplicationInsights.AspNetCore --version 2.18.0`{{exec}}

add the following to line 3 in Program.cs

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

`dotnet run --urls http://0.0.0.0:5001`{{exec}}

{{TRAFFIC_HOST1_5001}}/swagger

in a new tab

`curl localhost:5001`{{exec}}

ctrl-c




## using swashbuckle  - remove the swagger section  WIP REMOVE


https://learn.microsoft.com/en-us/aspnet/core/tutorials/getting-started-with-swashbuckle?view=aspnetcore-8.0&tabs=netcore-cli



https://localhost:<port>/swagger/v1/swagger.json

## Using the .Net OPENAPI tool

https://learn.microsoft.com/en-us/aspnet/core/web-api/microsoft.dotnet-openapi?view=aspnetcore-8.0

`dotnet tool install -g Microsoft.dotnet-openapi`{{exec}}


