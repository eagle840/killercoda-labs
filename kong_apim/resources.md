
at 2:30 at video https://www.youtube.com/watch?v=DZZEKyH0MHQ

https://konghq.com/install

To add Application Insights to your ASP.NET app, follow these steps:

1. Sign in to the Azure portal (https://portal.azure.com) and create a new Application Insights resource.

2. Once the resource is created, copy the Instrumentation Key from the Overview page. This key is required to connect your app to Application Insights.

3. Open your ASP.NET app in Visual Studio.

4. Install the Microsoft.ApplicationInsights.AspNetCore NuGet package. You can do this by right-clicking on your project in Solution Explorer, selecting "Manage NuGet Packages," and searching for "Microsoft.ApplicationInsights.AspNetCore."

5. Open the `Startup.cs` file in your project.

6. In the `ConfigureServices` method, add the following code to enable Application Insights:

```csharp
services.AddApplicationInsightsTelemetry(Configuration["ApplicationInsights:InstrumentationKey"]);
```

Make sure to replace `Configuration["ApplicationInsights:InstrumentationKey"]` with the actual Instrumentation Key you copied earlier.

7. In the `Configure` method, add the following code to enable Application Insights request tracking:

```csharp
app.UseApplicationInsightsRequestTelemetry();
```

8. Optionally, you can also add the following code to enable Application Insights exception tracking:

```csharp
app.UseApplicationInsightsExceptionTelemetry();
```

9. Save your changes and run your ASP.NET app. It should now start sending telemetry data to Application Insights.

10. To view the telemetry data, go back to the Azure portal and navigate to your Application Insights resource. From there, you can explore various metrics, logs, and other insights about your app.

That's it! You have successfully added Application Insights to your ASP.NET app.


KONG 


https://docs.konghq.com/gateway/latest/install/docker/#install-kong-gateway-with-a-database
