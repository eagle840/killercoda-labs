# dotnet -REPL  

## dotnet interactive & polyglot-notebooks

https://devblogs.microsoft.com/dotnet/dotnet-interactive-notebooks-is-now-polyglot-notebooks/

https://github.com/dotnet/interactive

https://github.com/jonsequitur/dotnet-repl

`dotnet tool install -g dotnet-repl`{{exec}}

# web

`cd ~; mkdir web; cd web`{{exec}}

wip type web, is to simple  dotnet new web -n myWebApp

`dotnet new webapp -n myWebApp`{{exec}}
`ls`{{exec}}

`cd myWebApp/`{{exec}}


dotnet restore ./src

dotnet build --configuration Release --no-restore ./src

dotnet test --no-restore --verbosity normal ./src

dotnet publish --configuration Release --no-build --output ./output ./src


`ls`{{exec}}

`dotnet run`

`dotnet run --urls http://localhost:5000`

`dotnet run --urls http://0.0.0.0:5000`{{exec}}

{{TRAFFIC_HOST1_5000}}

