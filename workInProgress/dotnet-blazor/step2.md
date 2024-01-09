# Blaser with Wasm

Uses Webassembly (wasm) - runs byte code in the browser (c++ or c#), which most browsers now support. Which in turn runs in the js sandbox.

The main type of file is a .razor file, a mix of html (@page) and c#(@code), and the razor pages can be nested.

A build results in code that can be used ststicly (Azure Statuic website)

learning:

- <blazor.net>

`dotnet new list`{{exec}}


`dotnet new blazorwasm -o myapp`{{exec}}

`cd my app`{{exec}}

`dotnet run --urls http://localhost:5000`

`dotnet run --urls http://0.0.0.0:5000`{{exec}}

Watch allows you to code, and see the changes

`dotnet watch -v --urls http://0.0.0.0:5000`{{exec}}

{{TRAFFIC_HOST1_5000}}

## review .razor files

note 
- @{page}
- @{code}
