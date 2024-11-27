
# Initial Setup


## Manual Install of Dotnet

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



## Start mySQL (optional)

It also takes a few seconds to get MySQL up and running, if you get an error wait a few seconds and try again.

`docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=MyP@ssW0rd' -p 1433:1433 --name sql_server_container -d mcr.microsoft.com/mssql/server`{{copy}}


```
curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"
apt-get update
apt-get install sqlcmd
sqlcmd -?
```{{exec}}

`sqlcmd -S localhost -U SA -P 'MyP@ssW0rd'`{{exec}}

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

In TodoItemsController.cs   update the HttpPost to:

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

{{TRAFFIC_HOST1_5000}}/weatherforecast

swagger url

{{TRAFFIC_HOST1_5000}}/swagger

{{TRAFFIC_HOST1_5000}}/swagger/v1/swagger.json

### Adding additional

- add a new model
- add the class to ToDoContext.cs
- run
  ```
  dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
  dotnet add package Microsoft.EntityFrameworkCore.Design
  dotnet add package Microsoft.EntityFrameworkCore.SqlServer
  dotnet add package Microsoft.EntityFrameworkCore.Tools
  dotnet tool uninstall -g dotnet-aspnet-codegenerator
  dotnet tool install -g dotnet-aspnet-codegenerator
  dotnet tool update -g dotnet-aspnet-codegenerator
  ---
- run
  `dotnet aspnet-codegenerator controller -name TodoItemsController -async -api -m <MODELNAME> -dc TodoContext -outDir Controllers`
- in the new controller set the POST  "GetTodoItem" =>  nameof(GetTodoItem)

## Curl command against the end point
