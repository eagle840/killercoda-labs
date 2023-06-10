
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

https://asdf-vm.com/

`apt update`{{exec}}


`apt install -y curl git sqlite3`{{exec}}


In new tab

`docker-compose up`{{exec}}

### install asdf

`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2`{{exec}}

`. "$HOME/.asdf/asdf.sh"`{{exec}}

`. "$HOME/.asdf/completions/asdf.bash"`{{exec}}

`asdf current`{{exec}}

### install ruby



`asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git`{{exec}}

`asdf plugin list all | grep ruby`{{exec}}

`asdf current`{{exec}}

`asdf list all ruby`{{exec}}

`asdf install ruby 3.1.2`{{exec}} 

Now we need to set which version of ruby to use, and the [context](https://asdf-vm.com/guide/getting-started.html#global):

- global: sets for the entire machine from $HOME/.tool-versions
- shell: sets
- local: sets working directory version with $PWD/.tool-versions

`asdf global ruby 3.1.2`{{exec}}


`asdf current`{{exec}}

`ruby -v`{{exec}}

## install nodejs  - WIP takes too long



`asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git`{{exec}}


`asdf install nodejs 18.1.0`{{exec}}


`asdf current`{{exec}}

`asdf global nodejs 18.1.0`{{exec}}

`asdf current`{{exec}}

`node -v`{{exec}}

# install postgre

asdf not working

`wget https://www.postgresql.org/media/keys/ACCC4CF8.asc`{{exec}}

`sudo apt-key add ACCC4CF8.asc`{{exec}}

fetch the metadata from the new repo

`sudo apt-get update`{{exec}}

`sudo apt-get install -y postgresql-13`{{exec}}
------------------------

`sudo apt update`{{exec}}

`sudo apt install curl gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates`{{exec}}

`curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg`{{exec}}

`echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list`{{exec}}
   
`sudo apt update`{{exec}}

`sudo apt install postgresql-13 postgresql-client-13`{{exec}}

`systemctl status postgresql@13-main.service`{{exec}}

`pg_config --version`{{exec}}



--------------------------

`pg_config --version`{{exec}}

# What if my version isn't listed

run the following to update all available versions

`asdf plugin update ruby`

or

`asdf plugin update all`




=======================================


---wip

Bundler:

- package manager that handles gems
- Gems are std ruby libraries
- Bundler comes with Rails
- When bundler starts, gems in gemfile are installed

webpacker:

- frontend
- uses yarn (a js package manager)
- ??? why nodejs needs to be installed?

html at app/views/layouts
- .erb ruby files (erb = embeded ruby)
- a compiler, HAML process the <%=  %>

control: cli
- bin/rails generate controller welcome index


