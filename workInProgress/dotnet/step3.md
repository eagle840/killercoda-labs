# telemetry

## generic

To add OpenTelemetry to a .NET 6 application, you can follow these steps:

1. Open a terminal and navigate to the root directory of your .NET 6 application.

2. Run the following command to add the OpenTelemetry .NET package to your project:

   ```shell
   dotnet add package OpenTelemetry.Extensions.Hosting --version 1.0.0-beta.1
   ```

   This command adds the `OpenTelemetry.Extensions.Hosting` package to your project.

3. Next, you need to configure OpenTelemetry. You can do this by modifying the `Program.cs` file in your application.

   Add the following code to the `CreateHostBuilder` method in the `Program.cs` file:

   ```csharp
   .ConfigureServices((hostContext, services) =>
   {
       services.AddOpenTelemetryTracing(builder =>
       {
           builder
               .SetResourceBuilder(ResourceBuilder.CreateDefault().AddService(hostContext.HostingEnvironment.ApplicationName))
               .AddAspNetCoreInstrumentation()
               .AddHttpClientInstrumentation()
               .AddConsoleExporter();
       });
   })
   ```

   This code configures OpenTelemetry to instrument your ASP.NET Core application and export the traces to the console.

4. Finally, rebuild and run your application:

   ```shell
   dotnet build
   dotnet run
   ```

   Your .NET 6 application is now instrumented with OpenTelemetry.

Note: The version used in the `dotnet add package` command is just an example. You can replace it with the latest version available.

## local zipkin

we'll be using the zipkin tracing system: https://zipkin.io/

`docker run -d --rm -p 9411:9411 openzipkin/zipkin`{{exec}}

confirm zipkin is running:

{{TRAFFIC_HOST1_9411}}

wip https://opentelemetry.io/docs/instrumentation/net/getting-started/  TRY THIS CODE TO

To add OpenTelemetry to a .NET 6 application and send data to a local Zipkin server, you need to follow these steps:

Step 1: Install the required NuGet packages

`dotnet add package OpenTelemetry.Extensions.Hosting --version 1.0.0-beta.1`{{exec}}

`dotnet add package OpenTelemetry.Exporter.Zipkin --version 1.0.0-beta.1`{{exec}}


Step 2: Configure OpenTelemetry in your application
In your `Program.cs` file, add the following code to configure OpenTelemetry:

```csharp
using OpenTelemetry;
using OpenTelemetry.Trace;
using OpenTelemetry.Exporter.Zipkin;

// ...

public static IHostBuilder CreateHostBuilder(string[] args) =>
    Host.CreateDefaultBuilder(args)
        .ConfigureServices((hostContext, services) =>
        {
            services.AddOpenTelemetryTracing((builder) =>
            {
                builder
                    .SetResourceBuilder(ResourceBuilder.CreateDefault().AddService(hostContext.HostingEnvironment.ApplicationName))
                    .AddAspNetCoreInstrumentation()
                    .AddHttpClientInstrumentation()
                    .AddZipkinExporter(options =>
                    {
                        options.Endpoint = new Uri("http://localhost:9411/api/v2/spans");
                    });
            });
        })
        .ConfigureWebHostDefaults(webBuilder =>
        {
            webBuilder.UseStartup<Startup>();
        });
```{{copy}}

Make sure to replace `http://localhost:9411/api/v2/spans` with the correct URL of your local Zipkin server.

Step 3: Run your application
Build and run your application using the following command:
```bash
dotnet run
```

Now, your .NET 6 application will send telemetry data to the local Zipkin server.

ref: https://opentelemetry.io/docs/instrumentation/net/