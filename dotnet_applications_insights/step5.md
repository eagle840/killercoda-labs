# Add role names

For each service you'll need to update the code:


create the following file: **Services/RoleNameInit.cs**
`touch Services/RoleNameInit.cs`{{exec}}

to both api and frontend, be sure to change the RoleName for the API (eg `APIBackend`)


```csharp
using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.ApplicationInsights.Channel;

namespace WeatherApp.Services
{
    public class RoleNameInit : ITelemetryInitializer
    {
        public void Initialize(ITelemetry telemetry)
        {
            telemetry.Context.Cloud.RoleName = "FrontEnd";
        }
    }
}
```{{copy}}


And update the program.cs for the frontend

```csharp
using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.ApplicationInsights.Channel;
using Microsoft.AspNetCore.Components;
using Microsoft.Extensions.DependencyInjection;
using WeatherApp.Components;
using WeatherApp.Services;



var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddApplicationInsightsTelemetry();
builder.Services.AddSingleton<ITelemetryInitializer, RoleNameInit>();
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();
app.UseAntiforgery();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
```{{exec}}


##  WIP: Searching

Open 'search' and set a new filter 'cloud role name`

`cloud role instance` is the machine name

## WIP logging to Application insights


https://learn.microsoft.com/en-us/azure/azure-monitor/app/ilogger

```
.ConfigureLogging(logging =>
{
    logging.AddApplicationInsights();
})
```
so the following should be sent to App Insights


```
    public void OnGet()
    {
        _logger.LogInformation("Privacy page called!");
    }
```

Another way to view

In App InSights, got 'Logs' and look in the 'traces' table.
