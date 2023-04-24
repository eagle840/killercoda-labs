
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

`asdf install ruby 2.7.3`{{exec}} # wip: 2.5.0

Now we need to set which version of ruby to use, and the [context](https://asdf-vm.com/guide/getting-started.html#global):

- global: sets for the entire machine from $HOME/.tool-versions
- shell: sets
- local: sets working directory version with $PWD/.tool-versions

`asdf global ruby 2.7.3`{{exec}}


`asdf current`{{exec}}

`ruby -v`{{exec}}

## install nodejs  - WIP takes too long



`asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git`{{exec}}


`asdf install nodejs 18.16.0`{{exec}}


`asdf current`{{exec}}

`asdf global nodejs 18.16.0`{{exec}}

`asdf current`{{exec}}

`node -v`{{exec}}




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


