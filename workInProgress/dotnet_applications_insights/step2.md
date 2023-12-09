# Step 2


`dotnet new webapp -n MyWebApp`{{exec}}


 # https://learn.microsoft.com/en-us/aspnet/core/tutorials/razor-pages/razor-pages-start?view=aspnetcore-7.0&tabs=visual-studio-code

`cd MyWebApp/`{{exec}}

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

In the Azure Application Insight 'Overview', click on 'Seacrh'


## Add a Throw Exception (remove if statement, or set deveplopment)

