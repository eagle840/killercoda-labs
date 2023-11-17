
## tools

https://learn.microsoft.com/en-us/ef/core/cli/dotnet

## getting started

https://learn.microsoft.com/en-us/ef/core/get-started/overview/install

`dotnet add package Microsoft.EntityFrameworkCore.SqlServer`{{exec}}


[get ed tool](https://learn.microsoft.com/en-us/ef/core/get-started/overview/install#get-the-net-core-cli-tools)

`dotnet tool install --global dotnet-ef`{{exec}}

`dotnet tool update`{{exec}}

`dotnet add package Microsoft.EntityFrameworkCore.Design`{{exec}}

## create first app

https://learn.microsoft.com/en-us/ef/core/get-started/overview/first-app?tabs=netcore-cli#create-a-new-project


`dotnet new console -o EFGetStarted`{{exec}}

`cd EFGetStarted`{{exec}}

`dotnet add package Microsoft.EntityFrameworkCore.Sqlite`{{exec}}

(we've already install sqlite)

In the project directory, create Model.cs with the following code

```
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;

public class BloggingContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }
    public DbSet<Post> Posts { get; set; }

    public string DbPath { get; }

    public BloggingContext()
    {
        var folder = Environment.SpecialFolder.LocalApplicationData;
        var path = Environment.GetFolderPath(folder);
        DbPath = System.IO.Path.Join(path, "blogging.db");
    }

    // The following configures EF to create a Sqlite database file in the
    // special "local" folder for your platform.
    protected override void OnConfiguring(DbContextOptionsBuilder options)
        => options.UseSqlite($"Data Source={DbPath}");
}

public class Blog
{
    public int BlogId { get; set; }
    public string Url { get; set; }

    public List<Post> Posts { get; } = new();
}

public class Post
{
    public int PostId { get; set; }
    public string Title { get; set; }
    public string Content { get; set; }

    public int BlogId { get; set; }
    public Blog Blog { get; set; }
}
```


EF Core can also [reverse engineer](https://learn.microsoft.com/en-us/ef/core/managing-schemas/scaffolding/) a model from an existing database.



follow from [here](https://learn.microsoft.com/en-us/ef/core/get-started/overview/first-app?tabs=netcore-cli#create-the-database)




--- DLETE BELOW ---

# dotnet -REPL  

## dotnet interactive & polyglot-notebooks

https://devblogs.microsoft.com/dotnet/dotnet-interactive-notebooks-is-now-polyglot-notebooks/

https://github.com/dotnet/interactive

https://github.com/jonsequitur/dotnet-repl

`dotnet tool install -g dotnet-repl`{{exec}}

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

## Build a Razor

## Build a Blazorwasm

## Build a webapi

## Simple debugging

## entity framework (in new lab)

https://learn.microsoft.com/en-us/ef/

https://www.nuget.org/packages?q=entity+framework

