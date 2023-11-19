

## Simple web page

`cd ~; mkdir web; cd web`{{exec}}

The -n arugment will create a folder of that name

`dotnet new webapp -n myWebApp`{{exec}}

`ls`{{exec}}

`cd myWebApp/`{{exec}}

'dotnet restore' restores the dependencies and tools of a .NET project.

`dotnet restore`{{exec}}

'dotnet build' compiles the source code of a .NET project and generates the executable or library output, default in the bin folder

`dotnet build`{{exec}} --configuration Release --no-restore ./src

WIP do a tree

The configuration setting can be in the .csprof or .sln file.

`ls`

'dotnet test' runs the unit tests defined in a .NET project and provides feedback on the test results, including information about passed and failed tests, code coverage, and other relevant metrics.

`dotnet test`{{exec}} --no-restore --verbosity normal ./src

'dotnet publish' compiles the source code of a .NET project and generates a self-contained deployment-ready package. This package includes the compiled application along with its dependencies and any additional files required for deployment. The output of dotnet publish can be used to deploy and run the application on a target environment without requiring the .NET SDK or runtime to be installed.

`dotnet publish`{{exec}} --configuration Release --no-build --output ./output ./src

WIP do a tree

## Run the app

`ls`{{exec}}

`dotnet run`

`dotnet run --urls http://localhost:5000`

`dotnet run --urls http://0.0.0.0:5000`{{exec}}

Watch allows you to code, and see the changes

`dotnet watch -v --urls http://0.0.0.0:5000`{{exec}}

review the -v command in help dotnet run --help

 -v, --verbosity <LEVEL> Set the MSBuild verbosity level. Allowed values are q[uiet], m[inimal], n[ormal], d[etailed], and diag[nostic].

{{TRAFFIC_HOST1_5000}}


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




