# blazor wasm

To create a Blazor WebAssembly (Wasm) app that makes a simple GET request to your existing .NET Core Web API, you can follow these steps:

1. Create a new Blazor WebAssembly project: (or server-side)
```bash
dotnet new blazorwasm -o WeatherApp
```{{exec}}

```bash
dotnet new blazor -o WeatherApp
```{{exec}}

2. Navigate to the WeatherApp directory:
```bash
cd WeatherApp
```{{exec}}

WIP add sln  `dotnet sln ../MySolution.sln add WeatherApp.csproj`{{exec}}

3. Add the `System.Net.Http.Json` package to your project. This package provides support for making HTTP requests in Blazor WebAssembly:
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

confirm that the app is working

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



5. Update the `WeatherApp/Pages/Home.razor` file to make a GET request to your TodoApi:

**WASM code**
```csharp
@page "/"
@using System.Net.Http
@using System.Net.Http.Json
@using System.Text.Json
@inject HttpClient HttpClient

<h1>Weather Information</h1>

<button @onclick="RefreshData">Refresh Data</button>

@if (weatherData != null)
{
    <table>
        <tr>
            <th>Date</th>
            <th>Temperature (C)</th>
            <th>Summary</th>
            <th>Temperature (F)</th>
        </tr>
        @foreach (var item in weatherData)
        {
            <tr>
                <td>@item.Date</td>
                <td>@item.TemperatureC</td>
                <td>@item.Summary</td>
                <td>@item.TemperatureF</td>
            </tr>
        }
    </table>
}
else
{
    <p>Loading...</p>
}

@code {
    private WeatherData[] weatherData;

    protected override async Task OnInitializedAsync()
    {
        await RefreshData();
    }

    private async Task RefreshData()
    {
        weatherData = await HttpClient.GetFromJsonAsync<WeatherData[]>("{{TRAFFIC_HOST1_5001}}/weatherforecast");
    }

    public class WeatherData
    {
        public string Date { get; set; }
        public int TemperatureC { get; set; }
        public string Summary { get; set; }
        public int TemperatureF { get; set; }
    }
}
```

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

WIP: what commponents need removing?

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

**OLD CODE**
```
@page "/"
@using System.Net.Http
@inject HttpClient Http

<h1>Weather Forecast</h1>

@if (weatherForecasts == null)
{
    <p>Loading...</p>
}
else
{
    <button @onclick="RefreshData">Refresh Data</button>
    <table>
        <thead>
            <tr>
                <th>Date</th>
                <th>Temperature (C)</th>
                <th>Summary</th>
                <th>Temperature (F)</th>
            </tr>
        </thead>
        <tbody>
            @foreach (var forecast in weatherForecasts)
            {
                <tr>
                    <td>@forecast.date</td>
                    <td>@forecast.temperatureC</td>
                    <td>@forecast.summary</td>
                    <td>@forecast.temperatureF</td>
                </tr>
            }
        </tbody>
    </table>
}

@code {
    private WeatherForecast[] weatherForecasts;

    protected override async Task OnInitializedAsync()
    {
        await RefreshData();
    }

    private async Task RefreshData()
    {
        weatherForecasts = await Http.GetFromJsonAsync<WeatherForecast[]>("https://2193556f-f345-410c-a303-2e4406bfe7e6-10-244-4-200-5001.spca.r.killercoda.com/weatherforecast");
    }

    public class WeatherForecast
    {
        public DateTime date { get; set; }
        public int temperatureC { get; set; }
        public string summary { get; set; }
        public int temperatureF { get; set; }
    }
}
```


add the application insights key in  /Properties/launchsettings.json
```
{
  "$schema": "http://json.schemastore.org/launchsettings.json",
  "ApplicationInsights": {
    "InstrumentationKey": "INSERT INSTRUMENTATION KEY"
    },
  "iisSettings": {
  ```

6. Ensure the TodoApi code is running on port 5001 STEP X

7. Run your Blazor WebAssembly project by navigating to the WeatherApp directory and executing:
```bash
dotnet run --urls http://0.0.0.0:5000
```{{exec}}

8. Access your WeatherApp in a web browser at `https://localhost:5000`, {{TRAFFIC_HOST1_5000}}

This setup will make a GET request to your TodoApi endpoint at `https://localhost:5001/weather` and display the temperature and conditions returned by the API. Make sure to update the URL in the `OnInitializedAsync` method to match the actual endpoint of your TodoApi.



## WIP is App insights avaialble for WASM
- see https://www.youtube.com/watch?v=j1dClqBD10k

## rerun as a non wasm

---

# old stuff

# Using Node.JS Move to step 5

See MS docs on App Insights JS sdk https://learn.microsoft.com/en-us/azure/azure-monitor/app/javascript-sdk?tabs=javascriptwebsdkloaderscript

https://github.com/microsoft/ApplicationInsights-node.js

`cd ~`{{exec}}

`asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git`{{exec}}

`asdf list-all nodejs`{{exec}}

`asdf install nodejs 19.9.0`{{exec}}

`asdf global nodejs 19.9.0`{{exec}}

`mkdir jsapp`{{exec}}

`cd jsapp`{{exec}}

`ls`{{exec}}

`npm -V`{{exec}}

`npm init -y`{{exec}}

`ls`{{exec}}

`npm install express`{{exec}}


`npm install applicationinsights@beta`{{exec}}


`nano index.js`{{exec}}


```
let appInsights = require("applicationinsights");
appInsights.setup("ENTER-CONNECTION-STRING").start();


const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
```

`node index.js`{{exec}}

WIP ApplicationInsights:Invalid metric name: xxx

{{TRAFFIC_HOST1_3000}}




in a new terminal

`curl http://localhost:3000`{{exec}}

## add roleName

```
const appInsights = require("applicationinsights");
appInsights.setup("<YOUR_CONNECTION_STRING>");
appInsights.defaultClient.context.tags[appInsights.defaultClient.context.keys.cloudRole] = "MyRoleName";
appInsights.start();
```
