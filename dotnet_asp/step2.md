
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



`dotnet add ./Demo/Demo.csproj package Microsoft.EntityFrameworkCore.Design --version=8`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.EntityFrameworkCore.SqlServer --version=8`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.EntityFrameworkCore.Tools --version=8`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.VisualStudio.Web.CodeGeneration.Design --version=8`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.AspNetCore.Identity.EntityFrameworkCore --version=8`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.AspNetCore.Identity.UI --version=8`{{exec}}

## Generate identity pages

`dotnet aspnet-codegenerator identity --project ./Demo/Demo.csproj `{{exec}}


## References

https://learn.microsoft.com/en-us/aspnet/core/fundamentals/tools/dotnet-aspnet-codegenerator?view=aspnetcore-8.0

https://www.nuget.org/packages/dotnet-aspnet-codegenerator

https://github.com/dotnet/Scaffolding

https://dotnet.microsoft.com/en-us/learn
