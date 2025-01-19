# csx script

A CSX script is a C# script file with a `.csx` extension. It's a lightweight way to write and execute C# code without the need to set up a full project or solution. C# scripting is handy for tasks like:

- **Automation**: Writing small scripts to automate repetitive tasks.
- **Testing**: Quickly testing snippets of code or API calls.
- **Prototyping**: Trying out new ideas without the overhead of project setup.
- **Build and Deployment Scripts**: Integrating scripts into build and deployment processes.

C# scripts can be executed using tools like the .NET Core command-line interface (CLI) or integrated with interactive environments such as Jupyter Notebooks (via .NET Interactive). This makes them quite versatile, especially in a DevOps context where automation and quick iterations are key.


Running a "Hello World!" script in C# using a CSX file is quite straightforward. Here’s how you can do it:

### Step 1: Install .NET SDK
Ensure you have the .NET SDK installed on your machine. You can download it from the [.NET download page](https://dotnet.microsoft.com/download).

### Step 2: Install dotnet-script Tool
Open a terminal or command prompt and install the `dotnet-script` tool globally by running:
```shell
dotnet tool install -g dotnet-script
```

### Step 3: Create the Script File
Create a new file named `hello.csx` with the following content:
```csharp
Console.WriteLine("Hello, World!");
```

### Step 4: Run the Script
Navigate to the directory where your `hello.csx` file is located and run the script using the `dotnet-script` command:
```shell
dotnet-script hello.csx
```

You should see the output:
```
Hello, World!
```

### Bonus: Running with the .NET CLI
If you prefer using the .NET CLI without the `dotnet-script` tool, you can use the following command:
```shell
dotnet run -p hello.csx
```


##  Directives 

This is a simple example, but it shows how easy it is to get started with C# scripting. If you have any specific questions or need more examples, feel free to ask!

You’re correct that in many programming languages, `#` is used to denote comments or remarks. However, in the context of C# scripting, the `#` character serves multiple purposes.

- **Comments**: You’re right, in C#, `//` is used for single-line comments and `/* ... */` for multi-line comments.
- **Preprocessor Directives**: In C# scripting, `#` is also used for preprocessor directives, which provide instructions to the compiler. Common directives include `#define`, `#if`, `#else`, `#endif`, and `#region`.
- **Script Directives**: In C# scripting specifically, `#r` is a directive used to reference external assemblies, while `#load` is used to load other script files.

Here’s an example that uses both `#r` and a comment in a C# script:
```csharp
#r "Microsoft.Azure.DocumentDB.Core" // This references the Cosmos DB SDK
using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;

var endpoint = "https://your-cosmos-db-endpoint.documents.azure.com:443/";
var authKey = "your-auth-key";
var client = new DocumentClient(new Uri(endpoint), authKey);

Console.WriteLine("Connected to Azure Cosmos DB!");
```

So while `#` does indeed function as a comment marker in some contexts, its versatility in C# scripting extends to powerful directives that enhance your scripting capabilities. 

If you have more questions or if there's anything else you'd like to know, feel free to ask!