# Step 2: Explore .NET Framework


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
`[System.IO.File]::WriteAllText('./text.txt', 'Hello, World!')`{{exec}}

# Read from a file
`$content = [System.IO.File]::ReadAllText('./text.txt')`{{exec}}


Making a network request using System.Net.WebClient:

```
$webClient = New-Object System.Net.WebClient
$content = $webClient.DownloadString('http://example.com')
```{{exec}}

`$content`{{exec}}

Working with collections using System.Collections.ArrayList:

```
$arrayList = New-Object System.Collections.ArrayList
$arrayList.Add('Hello')
$arrayList.Add('World')
$arrayList.Remove('World')
```{{exec}}


`$arrayList`{{exec}}