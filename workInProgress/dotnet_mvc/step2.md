# Build a web app and local logging


# create as a standalone


 Lets build a Dotnet Razor App:

`dotnet new mvc -n MyWebApp`{{exec}}


`cd MyWebApp/`{{exec}}

`dotnet run --urls http://0.0.0.0:5000`{{exec}}

{{TRAFFIC_HOST1_5000}}



---

# REMOVE BELOW

## Add Application Insights

https://learn.microsoft.com/en-us/azure/azure-monitor/app/asp-net

`dotnet add package Microsoft.ApplicationInsights.AspNetCore --version 2.22.0`{{copy}}

`dotnet add package Microsoft.ApplicationInsights.AspNetCore`{{exec}}

check the csproj file, that is has been added

`cat MyWebApp.csproj`{{exec}}

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


In the Azure Application Insight 'Overview', click on 'Seacrh', and reduce the time span to 1 hour. It will take a couple of minutes for the entries to populate.

Stop the application, and then start it in watch mode.

`dotnet watch --urls http://0.0.0.0:5000`{{exec}}

Now use the Editor tab to write the code.

In the following example we shall be using the Privacy web page to trigger logging.


## add a log

logging in blazor https://learn.microsoft.com/en-us/aspnet/core/blazor/fundamentals/logging?view=aspnetcore-8.0

logging w/ App Insights https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview

In the /pages/Privacy.cshtml.cs update the 'OnGet'

WIP: i think this just logs to stdout/err?

```
    public void OnGet()
    {
        _logger.LogInformation("Privacy page called!");
    }
```

and visit the Privacy page, checking the terminal tab for the log outputs.

## warnng and error

Add the following two lines and revisit the Privacy page. Notice the difference in the log outputs.

```
        _logger.LogWarning("An example of a Warning trace..");
        _logger.LogError("An example of an Error level message");
```

## Add a Throw Exception (remove if statement, or set deveplopment)

Lets force an exception when visting the Privacy page, in ./MyWebApp/Pages/Privacy.cshtml.cs, update the OnGet to:

```
    public void OnGet()
    {
        throw new Exception("An error occurred.");
    }
```

note how the web page itself is updated

## Now use App insights

Goto the Azure App Insights portal and copy the connection string, and add it to the appsettings.json.

Now rerun the logging and exception steps and note how it effects App insights.

## WIP

in Program.cs addd

`app.UseHttpLogging();`  wip:error

after app.UseHttpsRedirection();

learn more: https://learn.microsoft.com/en-us/aspnet/core/fundamentals/middleware/?view=aspnetcore-8.0

# Namespace logging

Lets look at a sample appsettings.json

```
{
 "Logging":{
  "LogLevel":{
   "Default": Information",
   "Microsoft:": "Warning",
   "Microsoft.Hosting.Lifetime": "Information"
  }
 }
}
```

In the provided logging configuration, the namespaces are used to define different levels of logging for specific parts of the application.

1. Default Namespace:
   - The "Default" namespace is used to set the default log level for the entire application. In this case, the default log level is set to "Information", which means that all log messages that do not fall under a specific namespace will be logged at the "Information" level.

2. Microsoft Namespace:
   - The "Microsoft" namespace is used to set the log level for all log messages related to Microsoft libraries or components. In this configuration, the log level for the "Microsoft" namespace is set to "Warning", which means that log messages from Microsoft libraries will be logged at the "Warning" level.

3. Microsoft.Hosting.Lifetime Namespace:
   - The "Microsoft.Hosting.Lifetime" namespace is used to set the log level for a specific part of the application related to the hosting lifetime. In this configuration, the log level for the "Microsoft.Hosting.Lifetime" namespace is set to "Information", which means that log messages from this specific part of the application will be logged at the "Information" level.

By using namespaces in the log level configuration, you can fine-tune the logging settings for different parts of the application and control the verbosity of log messages based on their source or category.

# Builtin

The built-in logging providers in .NET Core provide different ways to output log messages to various destinations. Here is an explanation of the commonly used built-in providers:

1. Console Provider:
   - The Console provider outputs log messages to the console (stdout). It is a simple and easy way to view log messages directly in the terminal or command prompt window where the application is running. This provider is useful during development and debugging phases.

2. Debug Provider:
   - The Debug provider outputs log messages using the System.Diagnostics.Debug class. Log messages sent to this provider can be captured by debuggers and diagnostic tools that support the Debug class. This provider is useful for debugging and tracing purposes.

3. EventSource Provider:
   - The EventSource provider allows log messages to be sent to the Windows Event Tracing infrastructure. This provider is useful for capturing detailed logs and performance data that can be analyzed using tools like Windows Performance Analyzer. It provides a structured way to log events and can be used for monitoring and troubleshooting applications.

4. EventLog Provider:
   - The EventLog provider writes log messages to the Windows Event Log. This provider is useful for logging critical events and errors that need to be monitored and managed centrally. Log messages sent to the EventLog provider can be viewed using the Event Viewer tool in Windows.

Each of these built-in providers offers different capabilities and is suitable for different scenarios. By configuring the logging providers in the application settings, you can control where log messages are sent and how they are processed, making it easier to manage and analyze logs effectively.


## Close down the app.

`ctrl-c`

in the next steps we'll start a API app, and a blasor WASM app, and tie the two together in app insights
