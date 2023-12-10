# Web APi

https://learn.microsoft.com/en-us/aspnet/core/tutorials/min-web-api?view=aspnetcore-8.0&tabs=visual-studio-code

`dotnet new web -o TodoApi`{{exec}}

cd TodoApi

wip `dotnet dev-certs https --trust`{{copy}}  # FOr windows machines

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

ctrl-c

## using swashbuckle


https://learn.microsoft.com/en-us/aspnet/core/tutorials/getting-started-with-swashbuckle?view=aspnetcore-8.0&tabs=netcore-cli

dotnet add TodoApi.csproj package Swashbuckle.AspNetCore -v 6.5.0

WIP: setting IsDevoplment

 In an environment-specific configuration file (e.g., `appsettings.Development.json`):
   ```json
   {
     "Environment": {
       "IsDevelopment": true
     }
   }
   ```



### add swagger console
```
app.UseSwagger();
app.UseSwaggerUI();
```

### finished code

```
var builder = WebApplication.CreateBuilder(args);


builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.MapGet("/", () => "Hello World!");

app.Run();
```
### build and run


`dotnet run --urls http://0.0.0.0:5000`{{exec}}

{{TRAFFIC_HOST1_5000}}


### outside   - json file
{{TRAFFIC_HOST1_5000}}/swagger/v1/swagger.json


### inside
{{TRAFFIC_HOST1_5000/swagger/v1/swagger.json}}

### UI  

/swagger


https://localhost:<port>/swagger/v1/swagger.json

## Using the .Net OPENAPI tool

https://learn.microsoft.com/en-us/aspnet/core/web-api/microsoft.dotnet-openapi?view=aspnetcore-8.0

`dotnet tool install -g Microsoft.dotnet-openapi`{{exec}}
