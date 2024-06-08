---

move to different lab

Step 4

# Adding a health endpoint to your .NET Razor web application can be achieved by using the built-in health checks API in .NET Core. Here are the steps to do it:

1. Install the necessary NuGet packages:
   You need to install the `Microsoft.Extensions.Diagnostics.HealthChecks` package. You can do this by running the following command in your Package Manager Console:

   ```
   Install-Package Microsoft.Extensions.Diagnostics.HealthChecks
   ```

   `dotnet add package Microsoft.Extensions.Diagnostics.HealthChecks --version 8.0.0`{{exec}}

2. Register Health Checks in Startup.cs:
   Open your Startup.cs file and add the following code in the `ConfigureServices` method:

   ```csharp
   services.AddHealthChecks();
   ```

3. Configure Health Check Endpoint:
   In the `Configure` method of the same Startup.cs file, add the following code:

   ```csharp
   app.UseEndpoints(endpoints =>
   {
       endpoints.MapHealthChecks("/health");
       endpoints.MapControllers();
   });
   ```

   This will create a health endpoint at the "/health" path of your application.

   The `Startup.cs` file in a .NET Core web application is responsible for configuring services and middleware. The `ConfigureServices` method sets up application services, while the `Configure` method configures the middleware pipeline for handling HTTP requests. Other methods can provide environment-specific configurations.

4. Test the Health Check Endpoint:
   Now, if you run your application and navigate to `http://localhost:<your_port>/health`, you should see a response of "Healthy" if everything is working correctly.

5. Custom Health Checks:
   If you want to add custom health checks, for example, to check the status of a database connection, you can do so by creating a class that implements the `IHealthCheck` interface and adding it in the `ConfigureServices` method like this:

   ```csharp
   services.AddHealthChecks()
       .AddCheck<YourCustomHealthCheck>("YourCustomHealthCheckName");
   ```

Remember to replace `<your_port>` with the actual port number your application is running on.
