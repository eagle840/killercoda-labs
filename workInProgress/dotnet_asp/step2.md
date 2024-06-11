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

   23  export PATH="$PATH:/root/.dotnet/tools"
   24  dotnet tool update -g dotnet-aspnet-codegenerator
   25  dotnet new sln
   26  dotnet new razor -o Demo
   27  dotnet sln add .\Demo\Demo.csporj
   28* 
   29  ls
   30  ls Demo
   31  dotnet sln add ./Demo/Demo.csporj
   32  cat ./Demo/Demo.csproj 
   33  dotnet sln add  ./Demo/Demo.csproj 
   34  dotnet add ./Demo/Demo.csproj package Microsoft.EntityFrameworkCore.Design
   35  dotnet add ./Demo/Demo.csproj package Microsoft.EntityFrameworkCore.SqlServer
   36  dotnet add ./Demo/Demo.csproj package Microsoft.EntityFrameworkCore.Tools
   37  dotnet add ./Demo/Demo.csproj package Microsoft.VisualStudio.Web.CodeGeneration.Design
   38  dotnet add ./Demo/Demo.csproj package Microsoft.AspNetCore.Identity.EntityFrameworkCore
   39  dotnet add ./Demo/Demo.csproj package Microsoft.AspNetCore.Identity.UI
   40  dotnet aspnet-codegenerator identity --project ./Demo/Demo.csproj 



https://learn.microsoft.com/en-us/aspnet/core/fundamentals/tools/dotnet-aspnet-codegenerator?view=aspnetcore-8.0
https://www.nuget.org/packages/dotnet-aspnet-codegenerator
https://github.com/dotnet/Scaffolding