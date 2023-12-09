
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

https://dotnet.microsoft.com/en-us/learn


## Setup Azure

wip Link to free account setup

In Azure, create a Applications Insight resource  WIP link to MS Docs to setup

record the connection string


## Install Dotnet

In this lab we will quickly install Dotnet using ASDF



`apt install -y curl git sqlite3 libpq-dev libreadline-dev`{{exec}}

`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2`{{exec}}

`. "$HOME/.asdf/asdf.sh"`{{exec}} WIP pipe to .brashrc?

`echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc`{{exec}}

`. "$HOME/.asdf/completions/asdf.bash"`{{exec}}

`echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc`{{exec}}

`asdf current`{{exec}}

### use dotnet

`asdf plugin add dotnet`{{exec}}

#### Show all installable versions
`asdf list-all dotnet`{{exec}}

#### Install specific version
`asdf install dotnet latest`{{exec}}

#### Set a version globally (on your ~/.tool-versions file)
`asdf global dotnet latest`{{exec}}

#### Now dotnet commands are available
`dotnet --version`{{exec}}





 



 

 

 

dotnet new --list

   28  dotnet new sln

   29  ls

   30  cat slntest.sln

   31  dotnet new webapi -o njbapi

   32  ls

   33  cat slntest.sln

   34*

   35  ls

   36  dotnet new sln --project njbapi

   37  dotnet new sln --project njbapi --force

   38  ls

   39  cat slntest.sln

   40  ls /njbapi

   41  ls

   42  ls njbapi/

   43  dotnet sln slntest.sln add ./njbapi/njbapi.csproj

   44  ls

   45  cat slntest.sln

 

dotnet sln slntest.sln  list





## Use dotnet consol

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

```
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
```


## Spectre Console

https://github.com/spectreconsole/spectre.console

`dotnet add package Spectre.Console`{{exec}}