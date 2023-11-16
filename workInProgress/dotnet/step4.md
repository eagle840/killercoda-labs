Step 4

# telemetry

## generic

https://opentelemetry.io/docs/instrumentation/net/



   Your .NET  application is now instrumented with OpenTelemetry.



## local zipkin

we'll be using the zipkin tracing system: https://zipkin.io/

`docker run -d --rm -p 9411:9411 openzipkin/zipkin`{{exec}}

confirm zipkin is running:

{{TRAFFIC_HOST1_9411}}

wip https://opentelemetry.io/docs/instrumentation/net/getting-started/  TRY THIS CODE TO

To add OpenTelemetry to a .NET 6 application and send data to a local Zipkin server, you need to follow these steps:

__Step 1__: Install the required NuGet packages

`dotnet add package OpenTelemetry.Extensions.Hosting`{{exec}}

`dotnet add package OpenTelemetry.Exporter.Zipkin`{{exec}}


__Step 2__: Configure OpenTelemetry in your application
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

__Step__ 3: Run your application
Build and run your application using the following command:
```bash
dotnet run
```

Now, your .NET 6 application will send telemetry data to the local Zipkin server.

ref: https://opentelemetry.io/docs/instrumentation/net/


