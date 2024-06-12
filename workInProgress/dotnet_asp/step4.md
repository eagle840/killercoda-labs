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

## run app

`dotnet run --project ./Demo/Demo.csproj --urls http://0.0.0.0:5000`{{exec}}

`dotnet run --project ./Demo/Demo.csproj -c Release --urls http://0.0.0.0:5000`{{exec}}

{{TRAFFIC_HOST1_5000}}

Register as a new user
