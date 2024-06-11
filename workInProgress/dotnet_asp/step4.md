   42  notepad
   #

`dotnet ef migrations add CreateIdentitySchema --project ./Demo/Demo.csproj `{{exec}}

`dotnet ef database update --project ./Demo/Demo.csproj `{{exec}}

`dotnet run --project ./Demo/Demo.csproj --urls http://0.0.0.0:5000`{{exec}}

`dotnet run --project ./Demo/Demo.csproj -c Release --urls http://0.0.0.0:5000`{{exec}}
