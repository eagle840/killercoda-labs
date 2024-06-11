# Final setup

Check the appsettings.json

```json
  "ConnectionStrings": {
    "DemoIdentityDbContextConnection": "Server=(localdb)\\mssqllocaldb;Database=Demo;Trusted_Connection=True;MultipleActiveResultSets=true"
  }
```

```json
   {
     "ConnectionStrings": {
       "DefaultConnection": "Server=localhost;Database=Demo;User Id=sa;Password=MyStrong@Passw0rd;"
     }
   }
```

should it be?:
`"Server=localhost,1433;Database=Demo;Trusted_Connection=True;MultipleActiveResultSets=true"`{{copy}}

OR

`"Server=localhost,1433;Database=Demo;Trusted_Connection=True;User Id=sa;Password=<YourStrong@Passw0rd>;MultipleActiveResultSets=true"`{{copy}}

OR  \/ \/  \/  \/

`"Server=localhost,1433;Database=Demo;User Id=sa;Password=<YourStrong@Passw0rd>;"`{{copy}}



```
When running a Docker container on the host network, the container shares the host's network stack. Therefore, you can connect to the SQL Server instance using the host's IP address or `localhost`.

Here is an example connection string for connecting to the SQL Server instance running on the host network:

### Using `localhost`:
```plaintext
Server=localhost,1433;Database=your_database_name;User Id=sa;Password=<YourStrong@Passw0rd>;
```

### Using the host's IP address:
```plaintext
Server=host_ip_address,1433;Database=your_database_name;User Id=sa;Password=<YourStrong@Passw0rd>;
```

Replace the following placeholders:
- `your_database_name`: The name of the database you want to connect to.
- `<YourStrong@Passw0rd>`: The strong password you set for the `sa` user.
- `host_ip_address`: The IP address of the host machine (if not using `localhost`).

### Example:
If your database name is `TestDB` and your password is `MyStrong@Passw0rd`, the connection string would look like this:

```plaintext
Server=localhost,1433;Database=TestDB;User Id=sa;Password=MyStrong@Passw0rd;
```

Or, if your host's IP address is `192.168.1.100`:

```plaintext
Server=192.168.1.100,1433;Database=TestDB;User Id=sa;Password=MyStrong@Passw0rd;
```

Make sure that the SQL Server instance is running and accessible from the client machine you are using to connect.
```


## Migate  Database

`dotnet ef migrations add CreateIdentitySchema --project ./Demo/Demo.csproj `{{exec}}

`dotnet ef database update --project ./Demo/Demo.csproj `{{exec}}

## run app

`dotnet run --project ./Demo/Demo.csproj --urls http://0.0.0.0:5000`{{exec}}

`dotnet run --project ./Demo/Demo.csproj -c Release --urls http://0.0.0.0:5000`{{exec}}
