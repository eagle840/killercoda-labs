
{{TRAFFIC_HOST1_80}}




This lab is for running dotnet 8 on Ubuntu, and connecting with Azure Application Insights, you will need an Aure Account.

https://dotnet.microsoft.com/en-us/learn

---------

https://learn.microsoft.com/en-us/azure/azure-monitor/app/asp-net-core?tabs=netcorenew%2Cnetcore6

Get started with Razor Pages in ASP.NET Core

! Not a Razor pageWe use an MVC application example  => https://learn.microsoft.com/en-us/aspnet/core/tutorials/first-mvc-app/start-mvc?view=aspnetcore-8.0&tabs=visual-studio-code

create an azure AI

record the connection string

hx follow dotnet lab

dotnet new webapp -n MyWebApp  # https://learn.microsoft.com/en-us/aspnet/core/tutorials/razor-pages/razor-pages-start?view=aspnetcore-7.0&tabs=visual-studio-code

cd MyWebApp/

dotnet add package Microsoft.ApplicationInsights.AspNetCore --version 2.18.0

dotnet run --urls http://0.0.0.0:5000

appsettings.json

================

{

  "Logging": {

    "LogLevel": {

      "Default": "Information",

      "Microsoft.AspNetCore": "Warning"

    }

  },

  "AllowedHosts": "*",

  "ApplicationInsights": {

    "ConnectionString": "InstrumentationKey=acxxxxxc;IngestionEndpoint=https://uksouth-1.in.applicationinsights.azure.com/;LiveEndpoint=https://uksouth.livediagnostics.monitor.azure.com/"

  }

}

 

 

Program.cs

==========

 

var builder = WebApplication.CreateBuilder(args);

 

// Add services to the container.

builder.Services.AddRazorPages();

 
builder.Services.AddApplicationInsightsTelemetry();

var app = builder.Build();

 // Configure the HTTP request pipeline.

if (!app.Environment.IsDevelopment())

{

    app.UseExceptionHandler("/Error");

    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.

    app.UseHsts();

}


app.UseHttpsRedirection();

app.UseStaticFiles();
 
app.UseRouting();

app.UseAuthorization();

app.MapRazorPages();

app.Run();

REMOVE IF STATEMENT

addding eception  throw new System.Exception("This is a test exception"); 

to error.cshtml.cs

    public ErrorModel(ILogger<ErrorModel> logger)

    {

        _logger = logger;

        throw new System.Exception("This is a test exception");

    }
--------------------
using mvc  https://learn.microsoft.com/en-us/aspnet/core/tutorials/first-mvc-app/start-mvc?view=aspnetcore-8.0&tabs=visual-studio-code

 dotnet new mvc -o MvcMovie

code -r MvcMovie


