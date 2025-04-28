# Step 2: Explore .NET Framework

PowerShell 7.5 is built on **.NET 9.0**. This version brings various updates and improvements to PowerShell, ensuring compatibility and enhanced performance across platforms like Ubuntu. If you're exploring features or compatibility, feel free to ask!


2.1: Understand the .NET Framework Architecture
Start by understanding the architecture of the .NET Framework. It consists of the Common Language Runtime (CLR) and the .NET Framework Class Library. The CLR is the execution engine that handles running applications, while the Class Library provides a set of standard classes that can be used in your code.

2.2: Learn about Common Language Runtime (CLR)
CLR is an important part of the .NET Framework. It provides services such as memory management, exception handling, security, and more. Understanding how CLR works will give you a better understanding of the .NET environment.

2.3: Explore .NET Framework Class Library
The .NET Framework Class Library is a collection of reusable classes, interfaces, and value types that are used to accomplish a range of common programming tasks. These include tasks such as string management, data collection, database connectivity, and more.

2.4: Understand Namespaces
In .NET, namespaces are used to organize classes and prevent naming conflicts. Familiarize yourself with the commonly used namespaces in .NET, such as System, System.IO, System.Collections, and System.Net.

2.5: Learn to Use .NET Classes in PowerShell
PowerShell can use .NET classes directly. Learn how to create instances of .NET classes, call their methods, and access their properties in PowerShell. For example, you can use the System.IO.File class to manipulate files in PowerShell.

Creating an instance of a .NET class:

make sure you're in pwsh : `pwsh`{{exec}}

`$date = New-Object System.DateTime(2022, 1, 1)`{{exec}}

`$date.GetType()`{{exec}}


Calling a method of a .NET class:

`$string = New-Object System.String('Hello, World!', 2)`{{exec}}

`$substring = $string.Substring(0, 5)  # Returns 'Hello'`{{exec}}


Accessing a property of a .NET class:

`$date = Get-Date`{{exec}}

`$year = $date.Year  # Returns the current year`{{exec}}

2.6: Practice with Real-World Scenarios
Finally, apply what you've learned by writing PowerShell scripts that use .NET classes to accomplish real-world tasks. This could include tasks such as reading and writing to files, making network requests, or working with collections of data.


Reading and writing to a file using System.IO.File:


# Write to a file
`[System.IO.File]::WriteAllText('./text.txt', 'Hello, World!')`{{exec}}  # see below for explaination

# Read from a file
`$content = [System.IO.File]::ReadAllText('./text.txt')`{{exec}}


Making a network request using System.Net.WebClient:

`$webClient = New-Object System.Net.WebClient`{{exec}}

`$content = $webClient.DownloadString('http://example.com')`{{exec}}

`$content`{{exec}}

Working with collections using System.Collections.ArrayList:


WIP: need to break this down to seperate commands:
```
$arrayList = New-Object System.Collections.ArrayList
$arrayList.Add('Hello')
$arrayList.Add('World')
$arrayList.Remove('World')
```{{exec}}


`$arrayList`{{exec}}


Note One


Explain the command

1. **`[System.IO.File]`**:
   - This is the **type accelerator** for the .NET `System.IO.File` class. In PowerShell, you can directly access .NET classes by referencing their namespace (e.g., `System.IO.File`).
   - The `System.IO.File` class provides static methods for working with files, such as reading, writing, and checking file attributes.

2. **`::WriteAllText`**:
   - The `::` syntax calls a **static method** of the class. Here, `WriteAllText` is a static method of `System.IO.File` that writes text to a file.
   - If the file does not exist, it will be created. If it already exists, its contents will be overwritten.

3. **`'./text.txt'`**:
   - This is the file path where the text will be written.
   - The `./` refers to the current directory. So, `text.txt` will be created in the directory where this command is run.

4. **`'Hello, World!'`**:
   - This is the string that will be written into the file.

When you run this command, it will:
- Create a file named `text.txt` in the current directory.
- Write the text `Hello, World!` into that file.

If you'd like further help understanding PowerShell syntax or working with .NET classes, let me know—I'd love to guide you!