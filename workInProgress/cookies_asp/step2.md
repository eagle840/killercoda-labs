WIP
- setup asp app in perivous step
-


## Cookies

Web cookies are small pieces of data that websites store on a user's device. They are commonly used to track user activity, remember user preferences, and provide a personalized browsing experience. Cookies are sent by a web server to a web browser and are stored on the user's device.

There are different types of cookies, including:

1. Session cookies: These cookies are temporary and are deleted when the user closes their browser. They are used to track user activity during a browsing session.

2. Persistent cookies: These cookies are stored on the user's device for a specific period of time, even after the browser is closed. They are used to remember user preferences and settings.

3. Third-party cookies: These cookies are set by domains other than the one the user is currently visiting. They are often used for tracking and advertising purposes.

Cookies can store various types of information, such as user preferences, login credentials, shopping cart items, and tracking data. However, it's important to note that cookies can also raise privacy concerns, as they can be used to track users across different websites and collect personal information.

Web developers can set and manage cookies using JavaScript or server-side programming languages like PHP. They can specify the expiration time, domain, and path for each cookie. Additionally, developers can use tools like browser developer tools to view and manage cookies during testing and debugging.

In recent years, there has been a growing focus on user privacy and data protection, leading to increased regulations around the use of cookies. For example, the General Data Protection Regulation (GDPR) in Europe requires websites to obtain user consent before setting certain types of cookies.

Overall, cookies play a crucial role in web development and user experience, but it's important for developers to use them responsibly and in compliance with privacy regulations.

## Session Cookies

```
@page
@model IndexModel
@{
    Response.Cookies.Append("SessionCookie", "This is a session cookie");
}

<!DOCTYPE html>
<html>
<head>
    <title>Session Cookie Example</title>
</head>
<body>
    <h1>Session Cookie Example</h1>
    <p>A session cookie has been stored.</p>
</body>
</html>

```

## persisant cookies


```
@page
@model IndexModel
@{
    var cookieOptions = new CookieOptions
    {
        Expires = DateTime.Now.AddDays(7) // Cookie will expire in 7 days
    };
    Response.Cookies.Append("PersistentCookie", "This is a persistent cookie", cookieOptions);
}

<!DOCTYPE html>
<html>
<head>
    <title>Persistent Cookie Example</title>
</head>
<body>
    <h1>Persistent Cookie Example</h1>
    <p>A persistent cookie has been stored with an expiration date.</p>
</body>
</html>
```

## 2rd party

```
@page
@model IndexModel
@{
    var cookieOptions = new CookieOptions
    {
        Expires = DateTime.Now.AddDays(7), // Cookie will expire in 7 days
        Domain = "example.com" // Set the domain for the third-party cookie
    };
    Response.Cookies.Append("ThirdPartyCookie", "This is a third-party cookie", cookieOptions);
}

<!DOCTYPE html>
<html>
<head>
    <title>Third-Party Cookie Example</title>
</head>
<body>
    <h1>Third-Party Cookie Example</h1>
    <p>A third-party cookie has been stored with a different domain.</p>
</body>
</html>
```


WIP remove below

## Add .NET Core SDK tools



`export PATH="$PATH:/root/.dotnet/tools"`{{exec}}

```
cat << \EOF >> ~/.bash_profile
# Add .NET Core SDK tools
export PATH="$PATH:/root/.dotnet/tools"
EOF
```{{exec}}

`dotnet tool update -g dotnet-aspnet-codegenerator`{{exec}}

`dotnet tool update -g dotnet-ef`{{exec}}

## Setup a Solution

`dotnet new sln`{{exec}}

## Setup a project, and add to solution

`dotnet new razor -o Demo`{{exec}}

`dotnet sln add  ./Demo/Demo.csproj `{{exec}}

## Add packages



`dotnet add ./Demo/Demo.csproj package Microsoft.EntityFrameworkCore.Design`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.EntityFrameworkCore.SqlServer`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.EntityFrameworkCore.Tools`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.VisualStudio.Web.CodeGeneration.Design`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.AspNetCore.Identity.EntityFrameworkCore`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.AspNetCore.Identity.UI`{{exec}}

## Generate identity pages

`dotnet aspnet-codegenerator identity --project ./Demo/Demo.csproj `{{exec}}


## References

https://learn.microsoft.com/en-us/aspnet/core/fundamentals/tools/dotnet-aspnet-codegenerator?view=aspnetcore-8.0

https://www.nuget.org/packages/dotnet-aspnet-codegenerator

https://github.com/dotnet/Scaffolding

https://dotnet.microsoft.com/en-us/learn
