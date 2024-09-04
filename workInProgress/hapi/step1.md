
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# Run First

Will be working with https://github.com/XGovFormBuilder/digital-form-builder

`sudo apt update`{{exec}}




### install asdf

`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2`{{exec}}

`. "$HOME/.asdf/asdf.sh"`{{exec}} WIP pipe to .brashrc?

`echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc`{{exec}}

`. "$HOME/.asdf/completions/asdf.bash"`{{exec}}

`echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc`{{exec}}

`asdf current`{{exec}}

## install nodejs


`asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git`{{exec}}


WIP moving from 16.20.1 to 18.20.1

`asdf install nodejs 18.20.1`{{exec}}

`asdf current`{{exec}}

`asdf global nodejs 18.20.1`{{exec}}

`asdf current`{{exec}}

`node -v`{{exec}}

## Install yarn (not needed?)

`asdf plugin-add yarn`{{exec}}


`asdf install yarn 1.22.10`{{exec}}

`asdf global yarn 1.22.10`{{exec}}

`asdf current`{{exec}}

`yarn -v`

WIP why is it showing 3.2.2 and not 1.22.10
