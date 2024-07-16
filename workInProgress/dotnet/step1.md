
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

https://dotnet.microsoft.com/en-us/learn

https://github.com/hensou/asdf-dotnet

`sudo apt update`{{exec}}

`apt install -y curl git sqlite3 libpq-dev libreadline-dev`{{exec}}

## Manual Install

https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install?tabs=dotnet8&pivots=os-linux-ubuntu-2004

`lsb_release -a`{{exec}}


`wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`rm packages-microsoft-prod.deb`{{exec}}

 `sudo apt-get update &&   sudo apt-get install -y dotnet-sdk-8.0`{{exec}}

`dotnet --version`{{exec}}


## Basic use

To list all the sdk's installed

`dotnet --list-sdks`{{exec}}

`dotnet --list-runtimes`{{exec}}

`dotnet --info`{{exec}}


if you manually installed the sdks'

`dotnet global.json sdk-version <desired-sdk-version>`

To list all the available templates

`dotnet new --list`{{exec}}

`dotnet clean`{{exec}}




To install a template

`dotnet new (shortname)`{{copy}}

'dotnet new sln'





A csproj file and a sln file are both used in Microsoft's .NET development ecosystem, but they serve different purposes.



A csproj file, short for C# project file, is used to define the properties and dependencies of a specific project within a solution. It contains information about the project's source files, references to external libraries, build settings, and other project-specific configurations. Each project in a solution typically has its own csproj file.



On the other hand, a sln file, short for solution file, is used to define a collection of related projects. It acts as a container for multiple csproj files and provides a way to organize and manage them as a single unit. The sln file contains references to the individual csproj files, build configurations, and other solution-level settings.



In summary, a csproj file is specific to a single project, while a sln file is used to manage multiple projects within a solution.

'workspaceFolder' is the root folder of the project









dotnet new --list

`dotnet new sln`{{exec}}

`ls`{{exec}}

`cat slntest.sln`{{exec}}

`dotnet new webapi -o njbapi`{{exec}}

`ls`{{exec}}

`cat slntest.sln`{{exec}}

`*`{{exec}}

`ls`{{exec}}

`dotnet new sln --project njbapi`{{exec}}

`dotnet new sln --project njbapi --force`{{exec}}

`ls`{{exec}}

`cat slntest.sln`{{exec}}

`ls /njbapi`{{exec}}

`ls`{{exec}}

`ls njbapi/`{{exec}}

`dotnet sln slntest.sln add ./njbapi/njbapi.csproj`{{exec}}

`ls`{{exec}}

`cat slntest.sln`{{exec}}




dotnet sln slntest.sln  list


WIP Remove the network program, and use just hello world.

## Basic dotnet commands:

1. `dotnet build`: This command builds the project and its dependencies. It is useful for checking for any build errors in your application.

2. `dotnet run`: This command runs the application. You can use this command to quickly test your application and see if it runs as expected.

3. `dotnet test`: This command runs the unit tests in your application. It is useful for verifying that your code behaves as expected.

4. `dotnet publish`: This command publishes the application for deployment. It packages the application and its dependencies into a folder that can be deployed to a server.

5. `dotnet watch run`: This command runs the application and automatically restarts it whenever a file in the project changes. It is useful for quickly testing changes without having to manually restart the application.

6. `dotnet restore`: This command restores (downloads) the dependencies of the project. It is useful for ensuring that all dependencies are up to date.


## Use dotnet consol - 'hello world'

`cd ~`{{exec}}

`mkdir nettest`{{exec}}

`cd nettest`{{exec}}

`sudo apt-get install net-tools libpcap-dev -y`{{exec}}

`dotnet new console -n MyNetworkApp`{{exec}}



`cd MyNetworkApp/`{{exec}}

https://www.nuget.org/packages/SharpPcap

`ls`{{exec}}

Run the simple 'hello world' program.

`dotnet run`{{exec}}

Now replace the program with this problem to list the network interfaces. We'll need a nuget package.

`dotnet add package  SharpPcap --version 6.2.5`{{exec}}


## Program.cs

```c#
using System;
using System.Diagnostics;
using SharpPcap;

namespace MyNetworkApp
{
    class Program
    {
        static void Main(string[] args)
        {
            // Retrieve the device list
            var devices = CaptureDeviceList.Instance;

            if (devices.Count < 1)
            {
                Console.WriteLine("No devices were found on this machine");
                return;
            }

            Console.WriteLine("The following devices are available on this machine:");
            Console.WriteLine("----------------------------------------------------");
            Console.WriteLine();

            int i = 0;

            // Print out the available network devices
            foreach (var dev in devices)
            {
                Console.WriteLine("{0}) {1} {2}", i, dev.Name, dev.Description);
                i++;
            }

            Console.WriteLine();
            Console.Write("Select a device to print its routing table: ");
            int deviceIndex = Convert.ToInt32(Console.ReadLine());

            if (deviceIndex >= 0 && deviceIndex < devices.Count)
            {
                Console.WriteLine("Selected device: " + devices[deviceIndex].Name);
                Console.WriteLine("Printing routing table...");

                ProcessStartInfo psi = new ProcessStartInfo("bash", "-c \"netstat -rn\"")
                {
                    RedirectStandardOutput = true,
                    UseShellExecute = false,
                    CreateNoWindow = true
                };

                Process p = Process.Start(psi);
                string output = p.StandardOutput.ReadToEnd();
                p.WaitForExit();

                Console.WriteLine(output);
            }
            else
            {
                Console.WriteLine("Invalid selection.");
            }

            Console.WriteLine("Hit 'Enter' to exit...");
            Console.ReadLine();
        }
    }
}
```{{exec}}


## Spectre Console

https://github.com/spectreconsole/spectre.console

`dotnet add package Spectre.Console`{{exec}}
