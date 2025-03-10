# .net tools

https://learn.microsoft.com/en-us/dotnet/core/diagnostics/tools-overview

https://learn.microsoft.com/en-us/dotnet/core/tools/troubleshoot-usage-issues

## Interactive

https://github.com/dotnet/interactive

(copilot:)
C# can be used within Jupyter Notebooks through the **.NET Interactive extension**¹(https://dev.to/kenakamu/time-to-learn-c-with-notebook-2gfj). This extension allows C# and other .NET languages to be used in Jupyter Notebooks, and it is integrated into **Visual Studio Code (VS Code)**²(https://code.visualstudio.com/docs/datascience/jupyter-notebooks). So, rather than breaking off into its own thing, C# continues to be supported in Jupyter Notebooks, but now with enhanced integration within VS Code²(https://code.visualstudio.com/docs/datascience/jupyter-notebooks).



## REPL tools



We'll install two REPL tools: `dotnet-repl` is a modern, actively maintained interactive tool for running C# code snippets within the .NET ecosystem, while `csharprepl` is an older, Mono-based tool specific to C# that is no longer actively developed.


First we'll set the location of the toolss, something that dotnet doesn't setup:

```
cat << \EOF >> ~/.bash_profile
# Add .NET Core SDK tools
export PATH="$PATH:/root/.dotnet/tools"
EOF
```{{exec}}

`export PATH="$PATH:/root/.dotnet/tools"`{{exec}}


`dotnet tool install -g dotnet-repl`{{exec}} [Docs](https://github.com/jonsequitur/dotnet-repl)

`dotnet-repl`{{exec}}

`#!help`{{exec}}

WIP below used in csharprepl

`#r "nuget: Newtonsoft. Json"`{{exec}}


`using Newtonsoft.Json;`{{exec}}

`var json = "{name: 'Madhukar', channel: 'DotnetCoreTelugu', subscribe: true}";`{{exec}}

`dynamic obj = JsonConvert.DeserializeObject<dynamic>(json);`{{exec}}

`obj`{{exec}}

`Console.Write(obj.name);`{{exec}}


`dotnet tool install -g csharprepl`{{exec}} [Docs](https://github.com/waf/CSharpRepl)

to run `csharprepl`{{exec}}

### List installed tools

`dotnet tool list -g`{{exec}}

Note the command names

`dotnet-repl -h`{{exec}}

`csharprepl -h`{{exec}} # 'exit' to quit

## http tool

`dotnet tool install -g Microsoft.dotnet-httprepl`{{exec}} [Docs](https://github.com/dotnet/HttpRepl?tab=readme-ov-file)

`dotnet tool list -g `{{exec}}

`httprepl -h`{{exec}}

## Make your own tools

Checkout the MS learn site on how to make your own tools [link](https://learn.microsoft.com/en-us/dotnet/core/tools/global-tools-how-to-create)


add to csproj


```
<Project Sdk="Microsoft.NET.Sdk">
<Project Sdk="Microsoft.NET.Sdk">

<PropertyGroup>
<OutputType>Exe</OutputType>
<TargetFramework>net6.0</TargetFramework>
<ImplicitUsings>enable</ImplicitUsings>
<Nullable>enable</Nullable>
<PackAsTool>true</PackAsTool>      <====
<ToolCommandName>weather</ToolCommandName>   <==== name of command to run
<PackageOutputPath>./nupkg</PackageOutputPath>   <====
</PropertyGroup>

@</Project>

@</Project>
```


# run:
`dotnet pack`{{exec}}   # outputs to ./nupkg


# run to install
`dotnet tool install --global --add-source ./nuget  weather.cli`{{exec}} # where weather.cli is the namespace (ie folder name, see this is a folder)


# dotnet -REPL

## dotnet interactive & polyglot-notebooks

https://devblogs.microsoft.com/dotnet/dotnet-interactive-notebooks-is-now-polyglot-notebooks/

https://github.com/dotnet/interactive

https://github.com/jonsequitur/dotnet-repl



https://learn.microsoft.com/en-us/dotnet/core/tools/troubleshoot-usage-issues



## Simple [Razor](https://learn.microsoft.com/en-us/aspnet/core/razor-pages/?view=aspnetcore-8.0&tabs=visual-studio-code) web page

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

`cat appsettings.json`{{exec}}

The appsettings.json file is a configuration file used in .NET applications to store various settings and configurations for the application. It is typically used to define application-specific settings such as database connection strings, logging configurations, API keys, and other configurable parameters.

To access, eg the ApiKey in the AppSettings section
```csharp
var apiKey = Configuration["AppSettings:ApiKey"];
```
The main difference between appsettings.json and appsettings.Development.json is that the latter is intended to override or provide additional configuration settings specifically for the development environment. This allows developers to have different configuration values for different environments, such as development, staging, and production.

To set the environment, there are several ways
- set ASPNETCORE_ENVIRONMENT, then in the program use the that variable Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT")
- using command line argument, again use in the program
- use launchSettings.json, 'dotnet run --launch-profile (name)'s


`dotnet run`

`dotnet run --urls http://localhost:5000`

`dotnet run --urls http://0.0.0.0:5000`{{exec}}

Watch allows you to code, and see the changes

`dotnet watch -v --urls http://0.0.0.0:5000`{{exec}}

review the -v command in help dotnet run --help

 -v, --verbosity <LEVEL> Set the MSBuild verbosity level. Allowed values are q[uiet], m[inimal], n[ormal], d[etailed], and diag[nostic].

{{TRAFFIC_HOST1_5000}}

## Build a Razor

## Build a Blazorwasm

see https://dotnet.microsoft.com/en-us/learn/aspnet/blazor-tutorial/intro   click on the linux tab

`dotnet new blazor -o BlazorApp`{{exec}}

`cd BlazorApp`{{exec}}

`ls`{{exec}}


- Program.cs is the entry point for the app that starts the server and where you configure the app services and middleware.
- App.razor is the root component for the app.
- Routes.razor configures the Blazor router.
- The Components/Pages directory contains some example web pages for the app.
- BlazorApp.csproj defines the app project and its dependencies and can be viewed by double-clicking the BlazorApp project node in the Solution Explorer.
- The launchSettings.json file inside the Properties directory defines different profile settings for the local development environment. A port number is automatically assigned at project creation and saved on this file.

`dotnet watch -v --urls http://0.0.0.0:5000`{{exec}}

{{TRAFFIC_HOST1_5000}}

The displayed page is defined by the Components/Pages/Home.razor file located inside the Components/Pages directory. This is what its contents look like:
```
@page "/"

<PageTitle>Home</PageTitle>

<h1>Hello, world!</h1>

Welcome to your new app.
```

review Components/Pages/Counter.razor

A request for /counter in the browser, as specified by the @page directive at the top, causes the Counter component to render its content. The @rendermode directive enables interactive server rendering for the component, so that it can handle user interface events from the browser.

Each time the Click me button is selected:

- The onclick event is fired.
- The IncrementCount method is called.
- The currentCount is incremented.
- The component is rendered to show the updated count.



add '<Counter />'  to the end of the Home.Razor file

## Webapi

https://learn.microsoft.com/en-us/aspnet/core/tutorials/first-web-api?view=aspnetcore-8.0&tabs=visual-studio-code

`dotnet new webapi --use-controllers -o TodoApi`{{exec}}

`cd TodoApi`{{exec}}

`dotnet watch -v --urls http://0.0.0.0:5000`{{exec}}

{{TRAFFIC_HOST1_5000/swagger/index.html}}

In the command 'dotnet new webapi --use-controllers -o TodoApi', the '--use-controllers' flag is used to specify that the generated project should include controller classes.



When creating a new ASP.NET Core Web API project using the 'dotnet new webapi' command, by default, it generates a basic project structure without any controller classes. Controllers are responsible for handling incoming HTTP requests and returning appropriate responses.



By using the '--use-controllers' flag, the command will generate the project with pre-defined controller classes, which can be used to define the API endpoints and their corresponding actions. This saves time and provides a starting point for building a Web API project.


## httprepl

https://github.com/dotnet/HttpRepl

`dotnet tool install -g Microsoft.dotnet-httprepl`{{exec}}

## Build a webapi part deux (microservice)

https://dotnet.microsoft.com/en-us/learn/aspnet/microservice-tutorial/create

`dotnet new webapi -o MyMicroservice --no-https`{{exec}}

`cd MyMicroservice`{{exec}}

## ML.NET

https://dotnet.microsoft.com/en-us/learn/ml-dotnet/get-started-tutorial/install


`dotnet tool install -g mlnet-linux-x64`


`mlnet`

`~/.dotnet/tools/mlnet`


## Simple debugging

https://code.visualstudio.com/docs/editor/debugging

https://learn.microsoft.com/en-us/training/modules/implement-visual-studio-code-debugging-tools/3-exercise-run-code-debug-environment


install c# dev extension

in command paltet   '.net:g' -> .NET: Generate Assets for Build and Debug.
creates '.vscode' folder, check launch configuration https://code.visualstudio.com/docs/editor/debugging


tasks.json was the build task in there

### notes:
- 'workspaceFolder' is the same as the root folder of the project
