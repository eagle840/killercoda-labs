
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




## USes a sln file?


for this project, since to dotnet apps running together

`dotnet new sln -n MySolution`{{exec}}

`dotnet  sln list`{{exec}}




