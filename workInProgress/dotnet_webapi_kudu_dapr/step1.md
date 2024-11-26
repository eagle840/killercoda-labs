
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

We'll be using asdf to install dotnet, however complete instructions for download and installing for other systems can be found on Micosoft [here](https://dotnet.microsoft.com/en-us/download)

## Manual Install

https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install?tabs=dotnet8&pivots=os-linux-ubuntu-2004

`lsb_release -a`{{exec}}


`wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`rm packages-microsoft-prod.deb`{{exec}}

 `sudo apt-get update &&   sudo apt-get install -y dotnet-sdk-8.0`{{exec}}

`dotnet --version`{{exec}}


## Basic use  REMOVE

To list all the sdk's installed

`dotnet --list-sdks`{{exec}}

`dotnet --list-runtimes`{{exec}}

`dotnet --info`{{exec}}



## Start mySQL

It also takes a few seconds to get MySQL up and running, if you get an error wait a few seconds and try again.

`docker exec -it  some-mysql mysql -uroot -p1234`{{execute}}

-uroot   => user root
-p       => prompt for password, or -p1234

Once connected, you should see `mysql>`

Exit out of the prompt, back to the host, with `quit`{{execute}}

### To connect from the host

Lets install the mysql client:

`apt update`{{execute}}

`apt install mysql-client`{{execute}}

`mysql -h 0.0.0.0  -P3306  -uroot -p1234 --ssl-mode=disabled`{{execute}}

### create a db

now we're connected lets create a new database.

`show databases;`{{execute}}

`create database test1;`{{execute}}

`show databases;`{{execute}}

and exit mysql/container

`exit;`{{execute}}

# create dotnet wep api with swagger

REMOVE https://learn.microsoft.com/en-us/aspnet/core/tutorials/web-api-help-pages-using-swagger?view=aspnetcore-8.0

We'll be using: https://learn.microsoft.com/en-us/aspnet/core/tutorials/first-web-api?view=aspnetcore-8.0&tabs=visual-studio-code


build it

run it

`dotnet new webapi --use-controllers -o TodoApi`{{exec}}

`cd TodoApi`{{exec}}

`dotnet add package Microsoft.EntityFrameworkCore.InMemory`{{exec}}


`dotnet run --urls http://0.0.0.0:5000`{{exec}}

grab the json from the /weatherforecast url



{{TRAFFIC_HOST1_5000}}/weatherforecast

swagger url

{{TRAFFIC_HOST1_5000}}/swagger


### Add a model class

mkdir Models

touch Models/TodoItem.cs

```
namespace TodoApi.Models;

public class TodoItem
{
    public long Id { get; set; }
    public string? Name { get; set; }
    public bool IsComplete { get; set; }
}
```

### Add a database context


touch Models/TodoContext.cs

```
using Microsoft.EntityFrameworkCore;

namespace TodoApi.Models;

public class TodoContext : DbContext
{
    public TodoContext(DbContextOptions<TodoContext> options)
        : base(options)
    {
    }

    public DbSet<TodoItem> TodoItems { get; set; } = null!;
}
```

###  Register the database context

first part of program.cs, set to

```
using Microsoft.EntityFrameworkCore;
using TodoApi.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddDbContext<TodoContext>(opt =>
    opt.UseInMemoryDatabase("TodoList"));
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();
```

###  Scaffold a controller

```
dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package Microsoft.EntityFrameworkCore.Tools
dotnet tool uninstall -g dotnet-aspnet-codegenerator
dotnet tool install -g dotnet-aspnet-codegenerator
dotnet tool update -g dotnet-aspnet-codegenerator
```{{exec}}

```
echo 'export PATH=$HOME/.dotnet/tools:$PATH' >> ~/.bashrc
source ~/.bashrc
```{{exec}}

`dotnet aspnet-codegenerator controller -name TodoItemsController -async -api -m TodoItem -dc TodoContext -outDir Controllers`{{exec}}


### Update the PostTodoItem create method

update to:

```
[HttpPost]
public async Task<ActionResult<TodoItem>> PostTodoItem(TodoItem todoItem)
{
    _context.TodoItems.Add(todoItem);
    await _context.SaveChangesAsync();

    //    return CreatedAtAction("GetTodoItem", new { id = todoItem.Id }, todoItem);
    return CreatedAtAction(nameof(GetTodoItem), new { id = todoItem.Id }, todoItem);
}
```

### Test

Connect to swagger and add (post) the following

```
{
  "name": "walk dog",
  "isComplete": true
}
```

`dotnet run --urls http://0.0.0.0:5000`{{exec}}

grab the json from the /weatherforecast url



---


REMOVE BELOW:

**Note the swagger spec under the project name** `https://xxx-5000.spch.r.killercoda.com/swagger/v1/swagger.json`

test it

make sure /swagger and api definition are there

# Create a controller-based API

https://learn.microsoft.com/en-us/aspnet/core/tutorials/first-web-api?view=aspnetcore-9.0&tabs=visual-studio-code


# MS Swagger


https://learn.microsoft.com/en-us/aspnet/core/tutorials/getting-started-with-swashbuckle?view=aspnetcore-8.0&tabs=visual-studio-code

`dotnet add TodoApi.csproj package Swashbuckle.AspNetCore -v 6.5.0`{{exec}}

Add the Swagger generator to the services collection in Program.cs:

```
builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
```

Enable the middleware for serving the generated JSON document and the Swagger UI, also in Program.cs

```
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
```

Launch the app and navigate to https://localhost:<port>/swagger/v1/swagger.json

{{TRAFFIC_HOST1_5000}}//swagger/v1/swagger.json


The Swagger UI can be found at https://localhost:<port>/swagger

{{TRAFFIC_HOST1_5000}}//swagger


### Test the location header URI

{{TRAFFIC_HOST1_5000}}//api/TodoItems/1



### Routing and URL paths


REVIEW AND ADD THIS SECTION
