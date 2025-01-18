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

This is a simple example, but it shows how easy it is to get started with C# scripting. If you have any specific questions or need more examples, feel free to ask!