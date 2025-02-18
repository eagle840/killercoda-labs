
# Applications Insights with Dotnet

## Setup Azure

wip Link to free account setup

In Azure, create a Applications Insights resource. and note the connection string in the top of the overview page.


## Install Dotnet

In this lab we will quickly install Dotnet using ASDF

`apt install -y curl git sqlite3 libpq-dev libreadline-dev sqlite jq`{{exec}}

```
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
```{{exec}}

```
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-8.0
```{{exec}}

and verify the install:

`dotnet --version`{{exec}}
