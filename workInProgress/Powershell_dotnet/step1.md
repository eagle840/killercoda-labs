
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

https://learn.microsoft.com/en-us/powershell/scripting/samples/creating-.net-and-com-objects--new-object-?view=powershell-7.5

# Run First

`cat /etc/os-release`{{exec}}

`sudo apt update`{{exec}}



# install Powershell

## Update the list of packages REMOVE THIS SECTION
`sudo apt-get update`{{exec}}

`sudo apt-get install -y wget apt-transport-https software-properties-common`{{exec}}

`source /etc/os-release`{{exec}}

`wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`rm packages-microsoft-prod.deb`{{exec}}



## Install PowerShell


###################################
# Prerequisites

`wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}

# Update the list of packages
`sudo apt-get update`{{exec}}

# Install pre-requisite packages.
`sudo apt-get install -y wget apt-transport-https software-properties-common`{{exec}}

# Get the version of Ubuntu
`source /etc/os-release`{{exec}}

# Download the Microsoft repository keys
`wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb`{{exec}}

# Register the Microsoft repository keys
`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

# Delete the Microsoft repository keys file
`rm packages-microsoft-prod.deb`{{exec}}

# Update the list of packages after we added packages.microsoft.com
`sudo apt-get update`{{exec}}

###################################
# Install PowerShell
`sudo apt-get install -y powershell`{{exec}}

# Start PowerShell
`pwsh`{{exec}}

`exit`{{exec}}


---

##################################
# Install dotnet

do i need? `wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}


`sudo add-apt-repository ppa:dotnet/backports`{{exec}}


`sudo apt-get update`{{exec}}

`sudo apt-get install -y dotnet-sdk-9.0`{{exec}}

`dotnet --version`{{exec}}

# P$ and .net over view

Understanding what a **.NET object** is will definitely help you get more out of PowerShell, since PowerShell is tightly integrated with the .NET framework.

### What is a .NET Object?

A **.NET object** is an instance of a **class** defined in the .NET framework. Think of a class as a blueprint, and an object as a specific item built from that blueprint.

.NET provides a huge library of classes for things like:
- Working with files and directories
- Managing network connections
- Handling dates and times
- Creating user interfaces
- Performing mathematical operations

Each object has:
- **Properties**: These are like characteristics or data fields (e.g., a `FileInfo` object might have a `Length` property for file size).
- **Methods**: These are actions the object can perform (e.g., a `FileInfo` object might have a `Delete()` method to remove the file).

### Example in PowerShell

Here’s a simple example using PowerShell:

```powershell
$file = Get-Item "C:\example.txt"
```

This command returns a `.NET object` of type `System.IO.FileInfo`. You can then access its properties and methods:

```powershell
$file.Length       # Property: size of the file
$file.Delete()     # Method: deletes the file
```

### Why It Matters

Because PowerShell works with .NET objects, you can:
- Access rich data structures directly
- Use object-oriented programming concepts
- Pipe objects between commands and manipulate them easily

Would you like to see a few more examples of common .NET objects in PowerShell or how to create your own?
