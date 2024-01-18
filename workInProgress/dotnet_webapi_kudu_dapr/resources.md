
# MS Swagger


https://learn.microsoft.com/en-us/aspnet/core/tutorials/getting-started-with-swashbuckle?view=aspnetcore-8.0&tabs=visual-studio-code

`dotnet add TodoApi.csproj package Swashbuckle.AspNetCore -v 6.5.0`{{exec}}

Add the Swagger generator to the services collection in Program.cs:

```
builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
```

Enable the middleware for serving the generated JSON document and the Swagger UI, also in Program.cs

```
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
```

Launch the app and navigate to https://localhost:<port>/swagger/v1/swagger.json

{{TRAFFIC_HOST1_5000}}//swagger/v1/swagger.json


The Swagger UI can be found at https://localhost:<port>/swagger

{{TRAFFIC_HOST1_5000}}//swagger

---- delete below ----
