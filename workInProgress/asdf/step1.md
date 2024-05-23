
# Initial Setup


`apt update`{{exec}}


`apt install -y curl git sqlite3 libpq-dev libreadline-dev`{{exec}}


In new tab

`docker-compose up`{{exec}}  WIP Remove?

## user setup

Some ruby applications don't like to run as root, so we'll add a user  'koda'

`sudo adduser --gecos "" koda`{{exec}}

The `--gecos ""` option allows you to bypass the prompts for additional user information

`sudo - koda`{{copy}}

`login koda`{{exec}}
 
### install asdf

`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2`{{exec}}

`. "$HOME/.asdf/asdf.sh"`{{exec}}

`echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc`{{exec}}

`. "$HOME/.asdf/completions/asdf.bash"`{{exec}}

`echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc`{{exec}}

`asdf current`{{exec}}

### install ruby



`asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git`{{exec}}

`asdf plugin list all | grep ruby`{{exec}}

`asdf current`{{exec}}

`asdf list all ruby`{{exec}}

Now we'll install ruby 3.1.2, which will take about 10 minutes 

`asdf install ruby 3.1.2`{{exec}} 

Now we need to set which version of ruby to use, and the [context](https://asdf-vm.com/guide/getting-started.html#global):

- global: sets for the entire machine from $HOME/.tool-versions
- shell: sets
- local: sets working directory version with $PWD/.tool-versions

`asdf global ruby 3.1.2`{{exec}}

`asdf current`{{exec}}

`ruby -v`{{exec}}

