
# Initial Setup


See dotnet lab for intro

https://learn.microsoft.com/en-us/ef/

## Install c# debugger in VSC


# WIP with asdf

https://github.com/hensou/asdf-dotnet

`sudo apt update`{{exec}}

`apt install -y curl git sqlite3 libpq-dev libreadline-dev`{{exec}}

## WIP install dotnet

asdf isn't working with global dotnet tools

```
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
```{{exec}}

```
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-8.0
```{{exec}}

```
sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-8.0
```{{exec}}



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

to install a specific version:

`asdf install dotnet 8.0.300`{{copy}}

#### Set a version globally (on your ~/.tool-versions file)
`asdf global dotnet latest`{{exec}}

`asdf global dotnet 8.0.300`{{copy}}

#### Now dotnet commands are available
`dotnet --version`{{exec}}

## Run Docker sql, redis and azurite


`docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=<YourPassword>' -p 1433:1433 --name sql_server_container -d mcr.microsoft.com/mssql/server`{{exec}}

`docker run -d --name redis-server -p 6379:6379 redis`{{exec}}

https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite?tabs=docker-hub

`docker run -d -p 10000:10000 -p 10001:10001 -p 10002:10002 mcr.microsoft.com/azure-storage/azurite`{{exec}}

## db management

`docker run -d -p 8080:8080 adminer`{{exec}}

https://www.adminer.org/

WIP might have to attach a folder/file/db to docker to connect to local files

Or just use mysql or similar




