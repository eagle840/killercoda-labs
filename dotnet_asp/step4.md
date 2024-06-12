# Final setup

update the appsettings.json

```json
  "ConnectionStrings": {
    "DemoIdentityDbContextConnection": "Server=localhost;Database=Demo;User Id=sa;Password=<YourStrong@Passw0rd>; TrustServerCertificate=true"
  }
```
`Server=localhost;Database=Demo;User Id=sa;Password=<YourStrong@Passw0rd>; TrustServerCertificate=true`{{copy}}

## Migate  Database

`dotnet ef migrations add CreateIdentitySchema --project ./Demo/Demo.csproj `{{exec}}

`dotnet ef database update --project ./Demo/Demo.csproj `{{exec}}

## Run app

`dotnet run --project ./Demo/Demo.csproj -c Release --urls http://0.0.0.0:5000`{{exec}}

{{TRAFFIC_HOST1_5000}}

Register as a new user

## Adding logging 

add to program.cs after line 4

`builder.Services.AddHttpLogging(o => { });`{{exec}}

add to program.cs `right after app.UseHttpsRedirection();`

`app.UseHttpLogging();`{{exec}}

in `appseting.deveopment.json`
 
```
{
"DetailedErrors": true,
"Logging": {
    "LogLevel": {
          "Default": "Information",
          "Microsoft.AspNetCore": "Information"
          }
    }
}
```

`dotnet run --project ./Demo/Demo.csproj --urls http://0.0.0.0:5000`{{exec}}


For more info on Razor, try the MS learn series at https://learn.microsoft.com/en-us/aspnet/core/tutorials/razor-pages/?view=aspnetcore-8.0