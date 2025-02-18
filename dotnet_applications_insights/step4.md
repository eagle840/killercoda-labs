# blazor wasm

To create a Blazor WebAssembly (Wasm) app that makes a simple GET request to your existing .NET Core Web API, you can follow these steps:

1. Create a new Blazor project:


```bash
dotnet new blazor -o WeatherApp
```{{exec}}

2. Navigate to the WeatherApp directory:
```bash
cd WeatherApp
```{{exec}}

add sln  `dotnet sln ../MySolution.sln add WeatherApp.csproj`{{exec}}

3. We'll need to install a couple of packages:

```bash
dotnet add package System.Net.Http.Json
```{{exec}}

`dotnet add package Microsoft.ApplicationInsights.AspNetCore`{{exec}}

4. Open the `WeatherApp.csproj` file in a text editor and ensure that the `System.Net.Http.Json` package is added as a reference:
```xml
<ItemGroup>
  <PackageReference Include="System.Net.Http.Json" Version="5.0.0" />
</ItemGroup>
```

`cat WeatherApp.csproj`{{exec}}

5. confirm that the app is working

`dotnet run --urls http://0.0.0.0:5000`{{exec}}

{{TRAFFIC_HOST1_5000}}


ADD application insights code

add the following to line 5 in Program.cs

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



5. Update the `WeatherApp/Pages/Weather.razor` file to make a GET request to your TodoApi:



**server side**

WIP `dotnet add package Microsoft.Extensions.Http`{{exec}}

**program.cs**
```
using WeatherApp.Components;
using Microsoft.AspNetCore.Components;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddApplicationInsightsTelemetry();

builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

builder.Services.AddScoped<HttpClient>(s =>
{
    var navigationManager = s.GetRequiredService<NavigationManager>();
    var httpClient = new HttpClient { BaseAddress = new Uri(navigationManager.BaseUri) };
    return httpClient;
});

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

```

**Weather.razor**



```
@page "/weather"
@using System
@using System.Net.Http
@using System.Net.Http.Json
@using System.Text.Json
@inject HttpClient HttpClient
@attribute [StreamRendering]

<PageTitle>Weather</PageTitle>

<h1>Weather</h1>

<p>This component demonstrates showing data.</p>

@if (forecasts == null)
{
    <p><em>Loading...</em></p>
}
else
{
    <table class="table">
        <thead>
            <tr>
                <th>Date</th>
                <th>Temp. (C)</th>
                <th>Temp. (F)</th>
                <th>Summary</th>
            </tr>
        </thead>
        <tbody>
            @foreach (var forecast in forecasts)
            {
                <tr>
                    <td>@forecast.Date.ToShortDateString()</td>
                    <td>@forecast.TemperatureC</td>
                    <td>@forecast.TemperatureF</td>
                    <td>@forecast.Summary</td>
                </tr>
            }
        </tbody>
    </table>
}

@code {
    private WeatherForecast[]? forecasts;

    protected override async Task OnInitializedAsync()
    {
        // Simulate asynchronous loading to demonstrate streaming rendering
        await Task.Delay(500);

        var startDate = DateOnly.FromDateTime(DateTime.Now);
        var summaries = new[] { "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching" };
        forecasts = Enumerable.Range(1, 5).Select(index => new WeatherForecast
        {
            Date = startDate.AddDays(index),
            TemperatureC = Random.Shared.Next(-20, 55),
            Summary = summaries[Random.Shared.Next(summaries.Length)]
        }).ToArray();
    }

    private class WeatherForecast
    {
        public DateOnly Date { get; set; }
        public int TemperatureC { get; set; }
        public string? Summary { get; set; }
        public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
    }

    private async Task RefreshData()
    {
        forecasts = await HttpClient.GetFromJsonAsync<WeatherForecast[]>("{{TRAFFIC_HOST1_5001}}/weatherforecast");
    }
}

```




6. Ensure the TodoApi code is running on port 5001 STEP 3

7. Run your Blazor project by navigating to the WeatherApp directory and executing:

```bash
dotnet run --urls http://0.0.0.0:5000
```{{exec}}

8. Access your WeatherApp in a web browser at `https://localhost:5000`, {{TRAFFIC_HOST1_5000}}

This setup will make a GET request to your TodoApi endpoint at `https://localhost:5001/weather` and display the temperature and conditions returned by the API.
