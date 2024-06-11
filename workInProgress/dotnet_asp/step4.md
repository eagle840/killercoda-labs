   42  notepad
   43  dotnet ef migrations add CreateIdentitySchema --project ./Demo/Demo.csproj 
   44  dotnet ef database update --project ./Demo/Demo.csproj 
   45  dotnet run --project ./Demo/Demo.csproj --urls http://0.0.0.0:5000
   46  dotnet run --project ./Demo/Demo.csproj -c Release --urls http://0.0.0.0:5000