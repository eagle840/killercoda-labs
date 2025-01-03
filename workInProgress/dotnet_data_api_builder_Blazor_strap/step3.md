# Blazor Strap

https://blazorstrap.io/

https://blazorstrap.io/V5/V5

dotnet add package BlazorStrap.V5 --version 5.2.103.122024


## Blazor WebAssembly


https://blazorstrap.io/V5/V5  > install


## Server Side

https://blazorstrap.io/V5/V5  > install

--

https://jsonplaceholder.typicode.com/todos/1

curl https://jsonplaceholder.typicode.com/todos/

`dotnet new blazorwasm -o WasmJSONApp --framework net8.0`{{exec}}

`dotnet new blazor -o BlazorJSONApp --framework net8.0`{{exec}}


cd BlazorJSONApp/

copy the code into one of the pages

```csharp
@page "/"

<PageTitle>Counter</PageTitle>

<button @onclick="FetchData">Get Data</button>

@if (todo != null)
{
    <h3>Title: @todo.title</h3>
    <p>Completed: @todo.completed</p>
}

@code{
    public Todo todo;
    public HttpClient httpClient = new HttpClient();

    public async Task FetchData()
    {
        todo = await httpClient.GetFromJsonAsync<Todo>("https://jsonplaceholder.typicode.com/todos/1");
    }

    public class Todo
    {
         public int userId { get; set; }
         public int id { get; set; }
         public string title { get; set; }
         public bool completed { get; set; }
    }
}
```


`dotnet run --urls http://0.0.0.0:5001`{{exec}}