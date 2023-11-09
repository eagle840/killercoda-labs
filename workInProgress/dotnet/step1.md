
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# Run First

`sudo apt update`{{exec}}


`sudo apt-get install -y wget apt-transport-https software-properties-common`{{exec}}

`source /etc/os-release`{{exec}}

`wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`rm packages-microsoft-prod.deb`{{exec}}

`sudo apt-get update`{{exec}}

`wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install -y apt-transport-https`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install -y dotnet-sdk-6.0`{{exec}}

`dotnet --version`{{exec}}

`sudo apt-get install -y dotnet-sdk-6.0`{{exec}}

`dotnet --version`{{exec}}

## BAsic use


`dotnet --list-sdks`{{exec}}

`dotnet new --list`{{exec}}

`dotnet new web`{{exec}}

`ls`{{exec}}


WIP determine how to use a sepecific sdk when multiple are installed


## for prerequr

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


