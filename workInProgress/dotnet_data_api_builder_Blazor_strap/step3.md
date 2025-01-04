# Blazor Strap

https://blazorstrap.io/

https://blazorstrap.io/V5/V5

dotnet add package BlazorStrap.V5 --version 5.2.103.122024

Note the two different types:
- Blazor WebAssembly https://blazorstrap.io/V5/V5  > install


- Server Side https://blazorstrap.io/V5/V5  > install

--

# Simple JSON call



https://jsonplaceholder.typicode.com/todos/1

curl https://jsonplaceholder.typicode.com/todos/

`dotnet new blazorwasm -o WasmJSONApp --framework net8.0`{{exec}}

WIP `dotnet new blazor -o BlazorJSONApp --framework net8.0`{{copy}}  # clicking get-data doesn't work



`cd WasmJSONApp/`{{exec}}

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

{{TRAFFIC_HOST1_5001}}

now to pull all items:

```
@page "/"

<PageTitle>Counter</PageTitle>

<button @onclick="FetchData">Get Data</button>

@if (todos != null && todos.Any())
{
    @foreach (var todo in todos)
    {
        <h3>Title: @todo.title</h3>
        <p>Completed: @todo.completed</p>
    }
}

@code{
    public List<Todo> todos;
    public HttpClient httpClient = new HttpClient();

    public async Task FetchData()
    {
        todos = await httpClient.GetFromJsonAsync<List<Todo>>("https://jsonplaceholder.typicode.com/todos");
        Console.WriteLine($"Fetched {todos.Count} todo items.");
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



---


code for the next json


Sure thing! You'll need to adjust your code to accommodate the new structure of the JSON data. Here's an updated version of your code to handle the `values` array within the root object:

```csharp
@page "/"

<PageTitle>Counter</PageTitle>

<button @onclick="FetchData">Get Data</button>

@if (todos != null && todos.Any())
{
    @foreach (var todo in todos)
    {
        <h3>Title: @todo.title</h3>
        <p>Completed: @todo.completed</p>
    }
}

@code{
    public List<Todo> todos;
    public HttpClient httpClient = new HttpClient();

    public async Task FetchData()
    {
        var response = await httpClient.GetFromJsonAsync<RootObject>("https://your-new-api-endpoint.com");
        todos = response.values;
    }

    public class Todo
    {
         public int userId { get; set; }
         public int id { get; set; }
         public string title { get; set; }
         public bool completed { get; set; }
    }

    public class RootObject
    {
        public List<Todo> values { get; set; }
    }
}
```

In this code, the `RootObject` class is created to match the new JSON structure, and the `FetchData` method is updated to parse the response accordingly.

Give this a try and let me know if it works as expected!

---
```csharp
@page "/counter"

<PageTitle>Counter</PageTitle>

<button @onclick="FetchData">Get Data</button>

@if (todos != null && todos.Any())
{
    @foreach (var todo in todos)
    {
        <h3>Title: @todo.first_name</h3>
        <p>Completed: @todo.last_name</p>
    }
}

@code{
    public List<Todo> todos = new List<Todo>();
    private readonly HttpClient httpClient;

    public Counter()
    {
        httpClient = new HttpClient();
    }

    public async Task FetchData()
    {
        var response = await httpClient.GetFromJsonAsync<RootObject>("https://b2a5dd97-faac-4b74-9ae0-900287ca7ae4-10-244-6-202-5000.spca.r.killercoda.com/api/Author");
        todos = response?.values ?? new List<Todo>();

        // Debug message to print out the number of items returned
        Console.WriteLine($"Number of items returned: {todos.Count}");
    }

    public class Todo
    {
        public int id { get; set; }
        public string first_name { get; set; }
        public string? middle_name { get; set; }
        public string last_name { get; set; }
    }

    public class RootObject
    {
        public List<Todo> values { get; set; }
    }
}


```

above, 

Based on the JSON response you've shared, it looks like the root object has a property named value instead of values. This discrepancy in naming might be the reason why the todos list is coming up empty.


below: working

```csharp
@page "/counter"

<PageTitle>Counter</PageTitle>

<button @onclick="FetchData">Get Data</button>

@if (todos != null && todos.Any())
{
    @foreach (var todo in todos)
    {
        <h3>Title: @todo.first_name</h3>
        <p>Completed: @todo.last_name</p>
    }
}

@code{
    public List<Todo> todos = new List<Todo>();
    private readonly HttpClient httpClient;

    public Counter()
    {
        httpClient = new HttpClient();
    }

    public async Task FetchData()
    {
        var response = await httpClient.GetFromJsonAsync<RootObject>("https://b2a5dd97-faac-4b74-9ae0-900287ca7ae4-10-244-6-202-5000.spca.r.killercoda.com/api/Author");
        todos = response?.value ?? new List<Todo>();

        // Debug message to print out the number of items returned
        Console.WriteLine($"Number of items returned: {todos.Count}");
    }

    public class Todo
    {
        public int id { get; set; }
        public string first_name { get; set; }
        public string? middle_name { get; set; }
        public string last_name { get; set; }
    }

    public class RootObject
    {
        public List<Todo> value { get; set; }
    }
}

```