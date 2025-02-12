# blazor wasm

To create a Blazor WebAssembly (Wasm) app that makes a simple GET request to your existing .NET Core Web API, you can follow these steps:

1. Create a new Blazor WebAssembly project:
```bash
dotnet new blazorwasm -o WeatherApp
```

2. Navigate to the WeatherApp directory:
```bash
cd WeatherApp
```

3. Add the `System.Net.Http.Json` package to your project. This package provides support for making HTTP requests in Blazor WebAssembly:
```bash
dotnet add package System.Net.Http.Json
```

4. Open the `WeatherApp.csproj` file in a text editor and ensure that the `System.Net.Http.Json` package is added as a reference:
```xml
<ItemGroup>
  <PackageReference Include="System.Net.Http.Json" Version="5.0.0" />
</ItemGroup>
```

5. Update the `WeatherApp/Pages/Home.razor` file to make a GET request to your TodoApi:
```csharp
@page "/"
@using System.Net.Http
@using System.Net.Http.Json
@using System.Text.Json
@inject HttpClient HttpClient

<h1>Weather Information</h1>

@if (weatherData != null)
{
    <p>Temperature: @weatherData.Temperature</p>
    <p>Conditions: @weatherData.Conditions</p>
}
else
{
    <p>Loading...</p>
}

@code {
    private WeatherData weatherData;

    protected override async Task OnInitializedAsync()
    {
        weatherData = await HttpClient.GetFromJsonAsync<WeatherData>("https://localhost:5001/weather");
        // enter killcoda url {{TRAFFIC_HOST1_5000}}/weather
    }

    public class WeatherData
    {
        public string Temperature { get; set; }
        public string Conditions { get; set; }
    }
}
```

6. Run your TodoApi project (if not already running) by navigating to the TodoApi directory and executing:
```bash
dotnet run
```

7. Run your Blazor WebAssembly project by navigating to the WeatherApp directory and executing:
```bash
dotnet run --urls http://0.0.0.0:5000
```

8. Access your WeatherApp in a web browser at `https://localhost:5000`, {{TRAFFIC_HOST1_5000}}

This setup will make a GET request to your TodoApi endpoint at `https://localhost:5001/weather` and display the temperature and conditions returned by the API. Make sure to update the URL in the `OnInitializedAsync` method to match the actual endpoint of your TodoApi.

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
