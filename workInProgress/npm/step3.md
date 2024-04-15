# Step 3


`asdf plugin add dotnet`{{exec}}

`asdf list-all dotnet`{{exec}}

`asdf install dotnet latest`{{exec}}

`asdf global dotnet latest`{{exec}}


`dotnet --list-sdks`{{exec}}

`dotnet new web -o PizzaStore -f net8.0`{{exec}}

`cd PizzaStore`{{exec}}

`dotnet run`{{exec}} # add binging 0.0.0.0

`curl http://localhost:{PORT}`   # "Hello World!"


`dotnet add package Swashbuckle.AspNetCore --version 6.5.0`{{exec}}

in

Program.cs

```
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
     c.SwaggerDoc("v1", new OpenApiInfo { Title = "PizzaStore API", Description = "Making the Pizzas you love", Version = "v1" });
});

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI(c =>
{
   c.SwaggerEndpoint("/swagger/v1/swagger.json", "PizzaStore API V1");
});

app.MapGet("/", () => "Hello World!");

app.Run();
```

`dotnet run`{{exec}}


http://localhost:{PORT}/swagger


`dotnet ef database update`{{exec}}


https://learn.microsoft.com/en-us/training/modules/build-web-api-minimal-api/
