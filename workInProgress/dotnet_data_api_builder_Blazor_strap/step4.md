# BLANK


Fantastic! Let's get you set up with a simple Blazor app that pulls data from your `authors` table and displays it on a web page. We'll start by creating a new Blazor project using .NET 8 and then modify the code to fetch the data from your API.

### Step 1: Create a New Blazor App
Open your command prompt or terminal and run the following command to create a new Blazor WebAssembly project:

```bash
dotnet new blazorwasm -o BlazorAuthorsApp --framework net8.0
```{{exec}}

This command will create a new Blazor WebAssembly project in a directory named `BlazorAuthorsApp` using .NET 8.

### Step 2: Install Required NuGet Packages
Navigate to the project directory and install the required NuGet package for making HTTP requests:

```bash
cd BlazorAuthorsApp
dotnet add package Microsoft.AspNet.WebApi.Client
```{{exec}}

### Step 3: Modify the Code to Fetch Data from the API

1. **Open `Program.cs` and add the necessary HTTP client service:**

```csharp
using System.Net.Http;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Microsoft.Extensions.DependencyInjection;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(builder.HostEnvironment.BaseAddress) });

await builder.Build().RunAsync();
```

2. **Create a Model for the Author:**
   Create a new file named `Author.cs` in the `Models` folder (create the folder if it doesn't exist) with the following content:

```csharp
namespace BlazorAuthorsApp.Models
{
    public class Author
    {
        public int id { get; set; }
        public string first_name { get; set; }
        public string middle_name { get; set; }
        public string last_name { get; set; }
        // Add other properties as needed
    }
}
```{{copy}}

3. **Create a Service to Fetch Data:**
   Create a new file named `AuthorService.cs` in the `Services` folder (create the folder if it doesn't exist) with the following content:

```csharp
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;
using BlazorAuthorsApp.Models;

namespace BlazorAuthorsApp.Services
{
    public class AuthorService
    {
        private readonly HttpClient _httpClient;

        public AuthorService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<Author>> GetAuthors()
        {
            return await _httpClient.GetFromJsonAsync<List<Author>>("http://localhost:5000/api/Author");
        }
    }
}
```{{copy}}

4. **Register the Service in `Program.cs`:**

```csharp
builder.Services.AddScoped<AuthorService>();
```

WIP Chect against this, which is working (Program.cs)

```csharp
using System.Net.Http;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Microsoft.Extensions.DependencyInjection;using Microsoft.AspNetCore.Components.Web;
using BlazorAuthorsApp;
using BlazorAuthorsApp.Services;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(builder.HostEnvironment.BaseAddress) });
builder.Services.AddScoped<AuthorService>();

await builder.Build().RunAsync();
```{{copy}}

5. **Create a Component to Display the Authors:**
   Create a new file named `AuthorList.razor` in the `Pages` folder with the following content:

```razor
@inject BlazorAuthorsApp.Services.AuthorService AuthorService 
@using BlazorAuthorsApp.Models
@page "/authors"

<h3>Authors List</h3>

@if (authors == null)
{
    <p><em>Loading...</em></p>
}
else if (authors.Count == 0)
{
    <p>No authors available.</p>
}
else
{
    <ul>
        @foreach (var author in authors)
        {
            <li>@author.first_name - @author.last_name</li>
        }
    </ul>
}

@code {
    private List<Author> authors;

    protected override async Task OnInitializedAsync()
    {
        authors = await AuthorService.GetAuthors();
    }
}
```{{copy}}

6. **Update `NavMenu.razor` to include the new page:**
   Add a link to the new `AuthorList` component in the `NavMenu.razor` file:

```razor
<NavLink href="authors" class="nav-link" Match="NavLinkMatch.All">
    Authors
</NavLink>
```

### Step 4: Run Your Blazor App
Run your Blazor app using the following command:


`dotnet run --urls http://0.0.0.0:5001`{{exec}}

Navigate to `http://localhost:5000/authors` in your browser, and you should see the list of authors displayed on the page.

WIP: goto browser developer tools and see why it's not pulling data
- ? because dab is running in developer-mode?

{{TRAFFIC_HOST1_5001}}/authors

There you go! You've successfully set up a Blazor app to fetch and display data from your `authors` table. If you have any more questions or need further assistance, feel free to ask!
