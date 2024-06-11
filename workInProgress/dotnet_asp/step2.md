dotnet new sln
   17  ls
   18  cat slntest.sln
   19  mkdir 715
   20  cd 715
   21  dotnet tool update -g dotnet-ef
   22  cat << \EOF >> ~/.bash_profile
# Add .NET Core SDK tools

export PATH="$PATH:/root/.dotnet/tools"
EOF

`export PATH="$PATH:/root/.dotnet/tools"`{{exec}}

`dotnet tool update -g dotnet-aspnet-codegenerator`{{exec}}

`dotnet new sln`{{exec}}

`dotnet new razor -o Demo`{{exec}}

`dotnet sln add .\Demo\Demo.csporj`{{exec}}

   28* 
   29  ls
   30  ls Demo
`dotnet sln add ./Demo/Demo.csporj`{{exec}}

   32  cat ./Demo/Demo.csproj 
`dotnet sln add  ./Demo/Demo.csproj `{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.EntityFrameworkCore.Design`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.EntityFrameworkCore.SqlServer`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.EntityFrameworkCore.Tools`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.VisualStudio.Web.CodeGeneration.Design`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.AspNetCore.Identity.EntityFrameworkCore`{{exec}}

`dotnet add ./Demo/Demo.csproj package Microsoft.AspNetCore.Identity.UI`{{exec}}

`dotnet aspnet-codegenerator identity --project ./Demo/Demo.csproj `{{exec}}




https://learn.microsoft.com/en-us/aspnet/core/fundamentals/tools/dotnet-aspnet-codegenerator?view=aspnetcore-8.0
https://www.nuget.org/packages/dotnet-aspnet-codegenerator
https://github.com/dotnet/Scaffolding