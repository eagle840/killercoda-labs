# Build a web app




 https://learn.microsoft.com/en-us/aspnet/core/tutorials/razor-pages/razor-pages-start?view=aspnetcore-7.0&tabs=visual-studio-code

`dotnet new webapp -n MyWebApp`{{exec}}


`cd MyWebApp/`{{exec}}

add the project to the solution file

`dotnet sln ../MySolution.sln add MyWebApp.csproj`{{exec}}

## Add Application Insights

https://learn.microsoft.com/en-us/azure/azure-monitor/app/asp-net

`dotnet add package Microsoft.ApplicationInsights.AspNetCore --version 2.18.0`{{exec}}

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

`dotnet run --urls http://0.0.0.0:5000`{{exec}}

{{TRAFFIC_HOST1_5000}}


In the Azure Application Insight 'Overview', click on 'Seacrh'


## Add a Throw Exception (remove if statement, or set deveplopment)


### finished code

```

```

