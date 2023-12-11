# Build a web app




 https://learn.microsoft.com/en-us/aspnet/core/tutorials/razor-pages/razor-pages-start?view=aspnetcore-7.0&tabs=visual-studio-code

 Lets build a Dotnet Razor App:

`dotnet new webapp -n MyWebApp`{{exec}}


`cd MyWebApp/`{{exec}}

add the project to the solution file

`dotnet sln ../MySolution.sln add MyWebApp.csproj`{{exec}}

## Add Application Insights

https://learn.microsoft.com/en-us/azure/azure-monitor/app/asp-net

`dotnet add package Microsoft.ApplicationInsights.AspNetCore --version 2.18.0`{{exec}}

add the following to line 3 in Program.cs

```
builder.Services.AddApplicationInsightsTelemetry();
```

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

## add a log 

In the /pages/Privacy.cshtml.cs update the 'OnGet'

```
    public void OnGet()
    {
        _logger.LogInformation("hello log");
    }
```


## Add a Throw Exception (remove if statement, or set deveplopment)

Let force an exception when visting the Privacy page, in ./MyWebApp/Pages/Privacy.cshtml.cs, update the OnGet to:

```
    public void OnGet()
    {
        throw new Exception("An error occurred.");
    }
```



### finished code

```
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddApplicationInsightsTelemetry();

// Add services to the container.
builder.Services.AddRazorPages();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapRazorPages();

app.Run();


```

