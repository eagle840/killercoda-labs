
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

https://dotnet.microsoft.com/en-us/learn

# Install dependencies


`sudo apt update`{{exec}}

`apt install -y curl git sqlite3 libpq-dev libreadline-dev`{{exec}}

## Manual Install dotnet


`wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`rm packages-microsoft-prod.deb`{{exec}}

 `sudo apt-get update &&   sudo apt-get install -y dotnet-sdk-8.0`{{exec}}

`dotnet --version`{{exec}}
