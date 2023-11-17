
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

See dotnet lab for intro

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

to install a specific version:

`asdf install dotnet 6.0.400`{{copy}}

#### Set a version globally (on your ~/.tool-versions file)
`asdf global dotnet latest`{{exec}}

#### Now dotnet commands are available
`dotnet --version`{{exec}}

## Run Docker sql and redis

`docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=<YourPassword>' -p 1433:1433 --name sql_server_container -d mcr.microsoft.com/mssql/server`{{exec}}

`docker run -d --name redis-server -p 6379:6379 redis`{{exec}}





