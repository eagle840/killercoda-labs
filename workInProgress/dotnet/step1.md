
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# WIP with asdf

https://github.com/hensou/asdf-dotnet

`sudo apt update`{{exec}}

`apt install -y curl git sqlite3 libpq-dev libreadline-dev`{{exec}}

### install asdf

We'll be using asdf to install dotnet, however complete instructions for download and installing for other systems can be found on Micosoft [here](https://dotnet.microsoft.com/en-us/download)

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

`asdf install dotnet 6`{{exec}}

#### Set a version globally (on your ~/.tool-versions file)
`asdf global dotnet latest`{{exec}}

#### Now dotnet commands are available
`dotnet --version`{{exec}}



WIP use asdf instead?  https://github.com/hensou/asdf-dotnet



## Basic use

To list all the sdk's installed

`dotnet --list-sdks`{{exec}}

TO list all the available templates

`dotnet new --list`{{exec}}

to install a template

`dotnet new (shortname)`{{copy}}

`ls`{{exec}}


WIP determine how to use a sepecific sdk when multiple are installed


## Use dotnet consol

`cd ~`{{exec}}

`mkdir nettest`{{exec}}

`cd nettest`{{exec}}

`sudo apt-get install net-tools libpcap-dev -y`{{exec}}

`dotnet new console -n MyNetworkApp`{{exec}}



`cd MyNetworkApp/`{{exec}}

`dotnet add package  SharpPcap --version 6.2.5`{{exec}}

`ls`{{exec}}

`dotnet run`{{exec}}


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


