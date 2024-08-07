# Step 3



Add dotnet minimal API using Sql server

`cd ~`{{exec}}

`asdf plugin add dotnet`{{exec}}

`asdf list-all dotnet`{{exec}}

`asdf install dotnet latest`{{exec}}

`asdf global dotnet latest`{{exec}}


`dotnet --list-sdks`{{exec}}

## Minimal api's with dotnet

Lets create a Dotnet api called PizzaStore:

https://learn.microsoft.com/en-us/training/modules/build-web-api-minimal-api/

`dotnet new web -o PizzaStore -f net8.0`{{exec}}

`cd PizzaStore`{{exec}}



`dotnet run --urls http://0.0.0.0:5000`{{exec}}

OR

`dotnet watch -v --urls http://0.0.0.0:5000`{{exec}}

-v, --verbosity Set the MSBuild verbosity level. Allowed values are q[uiet], m[inimal], n[ormal], d[etailed], and diag[nostic].



`curl http://localhost:5000`   # "Hello World!"

{{TRAFFIC_HOST1_5000}}

## Add swagger



`dotnet add package Swashbuckle.AspNetCore --version 6.5.0`{{exec}}

in Program.cs

```
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
     c.SwaggerDoc("v1", new OpenApiInfo { Title = "PizzaStore API", Description = "Making the Pizzas you love", Version = "v1" });
});

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI(c =>
{
   c.SwaggerEndpoint("/swagger/v1/swagger.json", "PizzaStore API V1");
});

app.MapGet("/", () => "Hello World!");

app.Run();
```{{copy}}


`dotnet run --urls http://0.0.0.0:5000`{{exec}}

The swagger portal takes the form of:  http://localhost:{PORT}/swagger

Go ahead and test it:

{{TRAFFIC_HOST1_5000}}/swagger

to add additional items to swagger doc, see [MS Docs](https://learn.microsoft.com/en-us/aspnet/core/tutorials/getting-started-with-swashbuckle?view=aspnetcore-8.0&tabs=visual-studio#api-info-and-description)




## Add Data

create `touch Db.cs`{{exec}}

```
namespace PizzaStore.DB;

 public record Pizza
 {
   public int Id {get; set;}
   public string ? Name { get; set; }
 }

 public class PizzaDB
 {
   private static List<Pizza> _pizzas = new List<Pizza>()
   {
     new Pizza{ Id=1, Name="Montemagno, Pizza shaped like a great mountain" },
     new Pizza{ Id=2, Name="The Galloway, Pizza shaped like a submarine, silent but deadly"},
     new Pizza{ Id=3, Name="The Noring, Pizza shaped like a Viking helmet, where's the mead"}
   };

   public static List<Pizza> GetPizzas()
   {
     return _pizzas;
   }

   public static Pizza ? GetPizza(int id)
   {
     return _pizzas.SingleOrDefault(pizza => pizza.Id == id);
   }

   public static Pizza CreatePizza(Pizza pizza)
   {
     _pizzas.Add(pizza);
     return pizza;
   }

   public static Pizza UpdatePizza(Pizza update)
   {
     _pizzas = _pizzas.Select(pizza =>
     {
       if (pizza.Id == update.Id)
       {
         pizza.Name = update.Name;
       }
       return pizza;
     }).ToList();
     return update;
   }

   public static void RemovePizza(int id)
   {
     _pizzas = _pizzas.FindAll(pizza => pizza.Id != id).ToList();
   }
 }
```{{copy}}

## Add routes

1: At the top of the Program.cs file, add the following line of code:

`using PizzaStore.DB;`

2: Just before app.Run(), add the following code:

```
app.MapGet("/pizzas/{id}", (int id) => PizzaDB.GetPizza(id));
app.MapGet("/pizzas", () => PizzaDB.GetPizzas());
app.MapPost("/pizzas", (Pizza pizza) => PizzaDB.CreatePizza(pizza));
app.MapPut("/pizzas", (Pizza pizza) => PizzaDB.UpdatePizza(pizza));
app.MapDelete("/pizzas/{id}", (int id) => PizzaDB.RemovePizza(id));
```{{copy}}


`dotnet run --urls http://0.0.0.0:5000`{{exec}}

{{TRAFFIC_HOST1_5000}}/swagger


## other WIP does this need to run?


`dotnet ef database update`{{exec}}


https://learn.microsoft.com/en-us/training/modules/build-web-api-minimal-api/
