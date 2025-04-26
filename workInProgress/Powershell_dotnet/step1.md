
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

wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

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

