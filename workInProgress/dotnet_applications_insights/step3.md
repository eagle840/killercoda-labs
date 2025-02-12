# Web APi

Now lets add a API to the solution and alter the web app to call the API

## Create API

## Test API with curl call

## Alter Web app to call API

## Add Roles to App Insights to track the two programmes (web and API

)

## add sln file


**WIP** do this: https://learn.microsoft.com/en-us/dotnet/core/diagnostics/observability-with-otel?view=aspnetcore-8.0


`cd ~`{{exec}}

for this project, since to dotnet apps running together

`dotnet new sln -n MySolution`{{exec}}

`dotnet  sln list`{{exec}}

WIP Add sln file


`dotnet new webapi -o TodoApi`{{exec}}

`cd TodoApi`{{exec}}

add the project to the solution file

WIP `dotnet sln ../MySolution.sln add TodoApi.csproj`{{exec}}

wip `dotnet dev-certs https --trust`{{copy}}  # FOr windows machines

`dotnet add package Microsoft.ApplicationInsights.AspNetCore --version 2.18.0`{{exec}} WIP is ver needed?

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




## using swashbuckle  - remove the swagger section  WIP REMOVE


https://learn.microsoft.com/en-us/aspnet/core/tutorials/getting-started-with-swashbuckle?view=aspnetcore-8.0&tabs=netcore-cli



https://localhost:<port>/swagger/v1/swagger.json

## Using the .Net OPENAPI tool

https://learn.microsoft.com/en-us/aspnet/core/web-api/microsoft.dotnet-openapi?view=aspnetcore-8.0

`dotnet tool install -g Microsoft.dotnet-openapi`{{exec}}
