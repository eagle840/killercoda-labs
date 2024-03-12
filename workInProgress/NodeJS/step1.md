
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# Run First

`sudo apt update`{{exec}}

### install asdf

`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2`{{exec}}

`. "$HOME/.asdf/asdf.sh"`{{exec}} WIP pipe to .brashrc?

`echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc`{{exec}}

`. "$HOME/.asdf/completions/asdf.bash"`{{exec}}

`echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc`{{exec}}

`asdf current`{{exec}}

## install nodejs  

To install in your own machine, head over to nodejs.org


`asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git`{{exec}}

`asdf list all nodejs`{{exec}}

`asdf install nodejs 20.11.1`{{exec}}

`asdf current`{{exec}}

`asdf global nodejs 20.11.1`{{exec}}

`asdf current`{{exec}}

`node -v`{{exec}}

## Install yarn

https://yarnpkg.com/

`asdf plugin-add yarn`{{exec}}

`asdf install yarn 1.22.10`{{exec}}

`asdf global yarn 1.22.10`{{exec}}

`asdf current`{{exec}}

`yarn -v`{{exec}}

