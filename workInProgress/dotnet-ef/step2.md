
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

