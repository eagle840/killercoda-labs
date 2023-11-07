
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

https://asdf-vm.com/

`apt update`{{exec}}


`apt install -y curl git sqlite3 libpq-dev libreadline-dev`{{exec}}


In new tab

`docker-compose up`{{exec}}  WIP Remove?

## user setup

`sudo adduser --gecos "" koda`{{exec}}

The `--gecos ""` option allows you to bypass the prompts for additional user information

`sudo - koda`{{copy}}

`login koda`{{exec}}
 
### install asdf

`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2`{{exec}}

`. "$HOME/.asdf/asdf.sh"`{{exec}} WIP pipe to .brashrc?

`echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc`{{exec}}

`. "$HOME/.asdf/completions/asdf.bash"`{{exec}}

`echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc`{{exec}}

`asdf current`{{exec}}

### install ruby



`asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git`{{exec}}

`asdf plugin list all | grep ruby`{{exec}}

`asdf current`{{exec}}

`asdf list all ruby`{{exec}}

Now we'll install ruby 3.1.2, which will take a few minutes

`asdf install ruby 3.1.2`{{exec}} 

Now we need to set which version of ruby to use, and the [context](https://asdf-vm.com/guide/getting-started.html#global):

- global: sets for the entire machine from $HOME/.tool-versions
- shell: sets
- local: sets working directory version with $PWD/.tool-versions

`asdf global ruby 3.1.2`{{exec}}


`asdf current`{{exec}}

`ruby -v`{{exec}}

## install nodejs  



`asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git`{{exec}}


`asdf install nodejs 18.1.0`{{exec}}


`asdf current`{{exec}}

`asdf global nodejs 18.1.0`{{exec}}

`asdf current`{{exec}}

`node -v`{{exec}}

## install postgre  WIP Remove?

asdf not working

`wget https://www.postgresql.org/media/keys/ACCC4CF8.asc`{{exec}}

`sudo apt-key add ACCC4CF8.asc`{{exec}}

fetch the metadata from the new repo

`sudo apt-get update`{{exec}}

`sudo apt-get install -y postgresql-13`{{exec}}
------------------------

`sudo apt update`{{exec}}

`sudo apt install -y curl gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates`{{exec}}

`curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg`{{exec}}

```
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list
```{{exec}}
   
`sudo apt update`{{exec}}

`sudo apt install -y postgresql-13 postgresql-client-13`{{exec}}

`systemctl status postgresql@13-main.service`{{exec}}

`pg_config --version`{{exec}}



--------------------------

`pg_config --version`{{exec}}

# What if my version isn't listed

run the following to update all available versions

`asdf plugin update ruby`

or

`asdf plugin update all`





