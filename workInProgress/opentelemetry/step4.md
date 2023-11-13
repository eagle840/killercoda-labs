# dotnet

## Built In

The System.Diagnostics namespace in .NET provides classes for tracing and debugging applications. The two main classes in this namespace that are commonly used for logging and tracing are Trace and Debug.

1. Trace Class: The Trace class provides methods for emitting trace messages. It allows you to write messages to different trace listeners, such as the console, file, event log, and more. The Trace class supports different levels of trace messages, including Information, Warning, Error, and Critical. You can use the Trace.WriteLine method to write a trace message, and the Trace.Listeners property to configure the trace listeners.

Example usage of Trace class:

```csharp
Trace.WriteLine("This is an information message", "Information");
Trace.WriteLine("This is a warning message", "Warning");
Trace.WriteLine("This is an error message", "Error");
Trace.WriteLine("This is a critical message", "Critical");
```

2. Debug Class: The Debug class is similar to the Trace class but is specifically designed for debugging purposes. It provides methods for emitting debug messages. By default, debug messages are only emitted when the application is running in debug mode. The Debug class also supports different levels of debug messages, including Information, Warning, Error, and Critical.

Example usage of Debug class:

```csharp
Debug.WriteLine("This is an information message", "Information");
Debug.WriteLine("This is a warning message", "Warning");
Debug.WriteLine("This is an. error message", "Error");
Debug.WriteLine("This is a critical message", "Critical");
```

Both the Trace and Debug classes can be configured in the application's configuration file (app.config or web.config) to specify the trace listeners and their settings. You can also create custom trace listeners to redirect the trace output to a specific target, such as a database or a custom log file.

These classes provide a basic logging and tracing mechanism in .NET, but for more advanced logging features and flexibility, it is recommended to use third-party logging libraries like Serilog, NLog, or log4net

# DOTNET vs Opentelemetry

Using OpenTelemetry for logging and tracing in .NET applications offers several advantages over the built-in logging and tracing libraries. Some of the key advantages are:

1. Vendor-Neutral and Standardized: OpenTelemetry is an open-source project that provides a vendor-neutral and standardized approach to observability. It offers a unified API and data model for logging, tracing, and metrics across different programming languages and frameworks. This allows for consistent instrumentation and observability practices across your entire application stack.

2. Distributed Tracing: OpenTelemetry focuses heavily on distributed tracing, which is crucial for understanding the flow of requests across microservices or distributed systems. It provides automatic instrumentation for tracing requests as they flow through different components, allowing you to visualize and analyze the entire request path. This helps in identifying performance bottlenecks, troubleshooting issues, and optimizing the system.

3. Rich Ecosystem: OpenTelemetry has a growing ecosystem of integrations and plugins for various logging and tracing backends. It supports popular observability platforms like Jaeger, Zipkin, Prometheus, and more. This allows you to easily integrate with your preferred backend and take advantage of their advanced features and visualizations.

4. Flexibility and Extensibility: OpenTelemetry provides a flexible and extensible instrumentation API. It allows you to customize and fine-tune the logging and tracing behavior according to your application's specific requirements. You can add custom attributes, tags, and context to your logs and traces, enabling more detailed analysis and filtering.

5. Performance Impact: OpenTelemetry is designed to have minimal performance impact on your application. It provides efficient and asynchronous instrumentation, reducing the overhead of logging and tracing operations. It also supports sampling, allowing you to control the amount of data collected, which can be crucial in high-traffic or performance-sensitive environments.

6. Community Support: OpenTelemetry has a vibrant and active community of developers and contributors. This means you can benefit from ongoing development, bug fixes, and improvements. It also ensures that you have access to a wealth of resources, documentation, and community support to help you get started and troubleshoot any issues.

Overall, OpenTelemetry provides a more comprehensive and standardized approach to logging and tracing in distributed systems. It offers better visibility, flexibility, and integration capabilities, making it a powerful choice for observability in modern applications.

### OpenTelemetry vs .NET terminology__
| OpenTelemetry |  .NET |
|---------------|-------|
|Tracer|ActivitySource|
|TelemetrySpan|Activity|
|SpanContext|ActivityContext|


### Adding OpenTelemetry to your application
1. Add OpenTelemetry NuGet package
2. Add NuGet packages for each exporter you will use, e.g .:
. Open Telemetry.Exporter.Console
. OpenTelemetry.Exporter.Prometheus
3. Add NuGet packages for each instrumentation, e.g .:
· OpenTelemetry.Instrumentation.Http
· Open Telemetry.Instrumentation.SqlClient
4. Acivate exporters and instrumentation in a bootstrapper__

opentelemtry.io 

check opentelemetry-dotnet project FIND LINK

check out some of the contribuation
 opentelemetry-collector-contrib


 Finding OpenTelemetry exporter/instrumentation
1. Check the main OpenTelemetry repo at GitHub
. https://github.com/open-telemetry/opentelemetry-dotnet/
. https://github.com/open-telemetry/opentelemetry-collector-contrib
2. Check vendor's repository, e.g .:
. https://github.com/honeycombio/honeycomb-opentelemetry-dotnet
. https://github.com/DataDog/dd-opentelemetry-exporter-XXX
. https://github.com/mysql-net/MySqlConnector/
3. Write your own!

----------------

## Demo plan
1. Bootstrapping applications
· Adding exporters
. Adding instrumentations
· Adding telemetry sources
2. Collecting traces in a single application
3. Collecting traces in a distributed scenario
4. Custom trace propagation example using RabbitMQ
5. Collecting traces propagated with message queues


https://www.jaegertracing.io/

https://www.youtube.com/watch?v=f0QRTLKax3s

at 28:46


1. add 

https://www.nuget.org/packages?q=OpenTelemetry

https://www.nuget.org/packages/OpenTelemetry/1.7.0-alpha.1

dotnet add package OpenTelemetry

2. add nuget for exporter, eg zipkin

https://www.nuget.org/packages?q=OpenTelemetry.exporter&prerel=true&sortby=relevance

- https://www.nuget.org/packages/OpenTelemetry.Exporter.Zipkin/1.7.0-alpha.1

dotnet add package OpenTelemetry.Exporter.Zipkin --version 1.7.0-alpha.1
dotnet add package OpenTelemetry.Exporter.Zipkin



3. add nuget OpenTelemetry.Instrumentation

OpenTelemetry.Instrumentation

https://www.nuget.org/packages?q=OpenTelemetry.Instrumentation
dotnet add package OpenTelemetry.Instrumentation.Http --version 1.6.0-beta.2

4 add boot strap


https://github.com/open-telemetry/opentelemetry-dotnet


using System.Diagnostics;
using OpenTelemetry;
using OpenTelemetry.Trace;
using OpenTelemetry.Resources;