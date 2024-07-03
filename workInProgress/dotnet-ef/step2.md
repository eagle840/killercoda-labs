
# Basic Console app with EF

WIP see lower half for simple single table asp app

## tools

https://learn.microsoft.com/en-us/ef/core/cli/dotnet

## getting started

https://learn.microsoft.com/en-us/ef/core/get-started/overview/install

https://learn.microsoft.com/en-us/ef/core/get-started/overview/first-app?tabs=netcore-cli


## create new project


`dotnet new console -o EFGetStarted`{{exec}}

`cd EFGetStarted`{{exec}}

## install ef core

`dotnet add package Microsoft.EntityFrameworkCore.Sqlite`{{exec}}

## create the model

`touch Model.cs`{{exec}}

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
```{{copy}}

DbContext is what EF thinks the database looks like (mapping)

Note the two tables 'Blog' and 'Post'. EF auto create keys from <tableName>Id, eg PostId

The `List<post>` creats a one to many between blogs and posts (check this)


## create the db

https://learn.microsoft.com/en-us/ef/core/cli/dotnet

`dotnet tool install --global dotnet-ef`{{exec}}

```
cat << \EOF >> ~/.bash_profile
# Add .NET Core SDK tools
export PATH="$PATH:/root/.dotnet/tools"
EOF
```

`export PATH="$PATH:/root/.dotnet/tools"`{{exec}}


Comfirm dotnet-ef is installed

`dotnet ef -v`{{exec}}

Run the following in the 'EFGetStarted' dir (should be here already)

`dotnet add package Microsoft.EntityFrameworkCore.Design`{{exec}}

`dotnet ef migrations add InitialCreate`{{exec}}

`dotnet ef database update`{{exec}}

WIP view the db with ????, where is the qb?




### Create, read, update & delete

Replace Program.cs with:

```
using System;
using System.Linq;

using var db = new BloggingContext();

// Note: This sample requires the database to be created before running.
Console.WriteLine($"Database path: {db.DbPath}.");

// Create
Console.WriteLine("Inserting a new blog");
db.Add(new Blog { Url = "http://blogs.msdn.com/adonet" });
db.SaveChanges();

// Read
Console.WriteLine("Querying for a blog");
var blog = db.Blogs
    .OrderBy(b => b.BlogId)
    .First();

// Update
Console.WriteLine("Updating the blog and adding a post");
blog.Url = "https://devblogs.microsoft.com/dotnet";
blog.Posts.Add(
    new Post { Title = "Hello World", Content = "I wrote an app using EF Core!" });
db.SaveChanges();

// Delete
// Console.WriteLine("Delete the blog");
// db.Remove(blog);
db.SaveChanges();
```{{copy}}

## run the app

`dotnet run`{{exec}}

note in the output the path of the database:  '/root/.local/share/blogging.db'

----


# Single table asp


To create a simple ASP.NET Razor app that uses a single table SQLite database, you can follow these steps using the .NET command-line interface (CLI). Below are the steps and code snippets to achieve this:

## Step 1: Create a new ASP.NET Razor app
```bash
dotnet new webapp -o RazorApp
cd RazorApp
```{{exec}}

## Step 2: Add the required NuGet packages for SQLite
```bash
dotnet add package Microsoft.EntityFrameworkCore.SQLite
dotnet add package Microsoft.EntityFrameworkCore.Design
```{{exec}}

## Step 3: Create a model class for your table (e.g., `Item.cs`)

`touch Item.cs`{{exec}}

```csharp
using System.ComponentModel.DataAnnotations;

public class Item
{
    public int Id { get; set; }

    [Required]
    public string Name { get; set; }
}
```{{copy}}

## Step 4: Create a DbContext class (e.g., `AppDbContext.cs`)

`touch AppDbContext.cs`{{exec}}

```csharp
using Microsoft.EntityFrameworkCore;

public class AppDbContext : DbContext
{
    public DbSet<Item> Items { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlite("Data Source=app.db");
    }
}
```{{copy}}

## Step 5: Register the DbContext in the `Startup.cs` file

`touch Startup.cs`{{exec}}

```csharp
services.AddDbContext<AppDbContext>();
```{{copy}}

## Step 6: Create the database and apply migrations  WIP i added -v
```bash
export PATH="$PATH:/root/.dotnet/tools
dotnet ef migrations add InitialCreate -v
dotnet ef database update -v
```{{exec}}

## Step 7: Use the DbContext in your Razor pages
```csharp
@page
@model IndexModel
@inject AppDbContext _context

<h1>Items</h1>

@foreach (var item in _context.Items)
{
    <p>@item.Name</p>
}
```{{copy}}

## Step 8: Run the application
```bash
dotnet run
```


`dotnet run --urls http://0.0.0.0:5000`{{exec}}

These steps will help you create a simple ASP.NET Razor app that uses a single table SQLite database. Make sure to adjust the code according to your specific requirements.
