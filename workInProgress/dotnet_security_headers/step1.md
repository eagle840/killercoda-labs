
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

We'll be using asdf to install dotnet, however complete instructions for download and installing for other systems can be found on Micosoft [here](https://dotnet.microsoft.com/en-us/download)

`sudo apt update`{{exec}}

`apt install -y curl git sqlite3 libpq-dev libreadline-dev tree`{{exec}}

## Manual Install

https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install?tabs=dotnet8&pivots=os-linux-ubuntu-2004

`lsb_release -a`{{exec}}


`wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`rm packages-microsoft-prod.deb`{{exec}}

 `sudo apt-get update &&   sudo apt-get install -y dotnet-sdk-8.0`{{exec}}

  `sudo apt-get update &&   sudo apt-get install -y dotnet-sdk-7.0`{{exec}}


`dotnet --version`{{exec}}


## Basic use

To list all the sdk's installed

`dotnet --list-sdks`{{exec}}

`dotnet --list-runtimes`{{exec}}

`dotnet --info`{{exec}}



#### Now dotnet commands are available
`dotnet --version`{{exec}}


`dotnet new webapp -n MyWebApp`{{exec}}

`dotnet run --urls http://0.0.0.0:5000`{{exec}} WIP use watch


`curl -I -s -L -X GET http://0.0.0.0:5000/`{{exec}}


After 'app.UseAuthorization();` add:

```
app.Use(async (context, next) => {
    context.Response.Headers.Add("Content-Security-Policy", "default-src 'self'; script-src 'self'; style-src 'self'; font-src 'self'; img-src 'self'; frame-src 'self'");

    await next();
});
```{{copy}}


`dotnet run --urls http://0.0.0.0:5000`{{exec}} WIP use watch


`curl -I -s -L -X GET http://0.0.0.0:5000/`{{exec}}

## Try below, adding the app.use(X)






# create dotnet wep api with swagger

review https://learn.microsoft.com/en-us/aspnet/core/tutorials/web-api-help-pages-using-swagger?view=aspnetcore-8.0


build it

run it

`dotnet new webapi -n YourProjectName`{{exec}}

`cd YourProjectName/`{{exec}}


`dotnet run --urls http://0.0.0.0:5000`{{exec}}

grab the json from the /weatherforecast url



{{TRAFFIC_HOST1_5000}}/weatherforecast

swagger url

{{TRAFFIC_HOST1_5000}}/swagger

**Note the swagger spec under the project name** `https://xxx-5000.spch.r.killercoda.com/swagger/v1/swagger.json`

test it

make sure /swagger and api definition are there


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
