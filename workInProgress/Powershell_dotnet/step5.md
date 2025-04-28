To create a C# program that mirrors the PowerShell command `$date = New-Object System.DateTime(2022, 1, 1)` and can run in Windows PowerShell, you need to write a simple console application that initializes a `DateTime` object. Here's an example of such a program:

```csharp
using System;

namespace DateTimeExample
{
    class Program
    {
        static void Main(string[] args)
        {
            // Create a DateTime object for January 1, 2022
            DateTime date = new DateTime(2022, 1, 1);

            // Output the date to the console
            Console.WriteLine("The date is: " + date.ToString("yyyy-MM-dd"));
        }
    }
}
```

NOTE: csc isn't directly executable, see below - ie use dotnet command

### Steps to Execute in Windows PowerShell:
1. **Write the Program**: Save the code above in a file named `DateTimeExample.cs`.
2. **Compile the Program**:
   - Open PowerShell and navigate to the directory where `DateTimeExample.cs` is saved.
   - Run the following command to compile it using the `csc` (C# compiler):
     ```powershell
     csc DateTimeExample.cs
     ```
   - This will produce an executable file, typically `DateTimeExample.exe`.
3. **Run the Program**:
   - Execute the compiled program in PowerShell:
     ```powershell
     .\DateTimeExample.exe
     ```
   - It will display the message: `The date is: 2022-01-01`.

That's it! You now have a C# program that replicates the functionality of your PowerShell command. Let me know if you'd like help modifying or expanding the program further!

#####


Dotnet command vs csc

That's a keen observation! The PowerShell command and the C# program indeed differ because they represent two distinct paradigms:

- **PowerShell** is primarily a scripting language designed for automation and task management. The `New-Object` cmdlet is used for creating .NET objects within a PowerShell script, leveraging its tight integration with .NET Framework or .NET Core.
  
- **C#** is a compiled programming language meant for building applications. When you write a C# program, you're coding directly in the language and compiling it into an executable. The syntax, structure, and execution workflow are different from PowerShell's scripting environment.

The core similarity lies in their usage of .NET's `DateTime` class. In PowerShell, you're invoking the class dynamically, while in C#, you're writing and compiling the code to explicitly use the class.

Interestingly, you could use the `dotnet` command to compile and run C# code without needing to use `csc`. For example, to execute the same C# code:

1. Save the code into a file named `Program.cs`.
2. Use the `dotnet` command to run it:
   ```powershell
   dotnet run Program.cs
   ```

This leverages the .NET CLI to handle building and running, streamlining the process! Let me know if you'd like guidance on this approach.


### csc isn't in sdk

but can run

You're absolutely right—`csc` isn't directly available as a standalone command in the .NET SDK on Linux-based systems like Ubuntu. Instead, the .NET SDK includes the Roslyn compiler (`csc.dll`), which is invoked indirectly through the `dotnet` CLI.

If you want to compile a C# file without creating a full project, you can use the following approach:

1. **Create Your C# File**:
   Save your code in a file, for example, `Program.cs`.

2. **Compile Using `dotnet` CLI**:
   Run this command in the terminal:
   ```bash
   dotnet build
   ```
   This requires a project file, so you may need to create one using:
   ```bash
   dotnet new console -n MyApp
   ```
   Then place your `Program.cs` file in the `MyApp` directory and build it.

3. **Directly Invoke the Compiler**:
   If you really want to use `csc.dll` directly, you can locate it in the .NET SDK installation directory. For example:
   ```bash
   dotnet /usr/share/dotnet/sdk/<version>/Roslyn/bincore/csc.dll Program.cs
   ```
   Replace `<version>` with your installed SDK version.

Let me know if you'd like help setting this up!