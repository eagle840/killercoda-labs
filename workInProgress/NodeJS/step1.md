
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# Run First

`sudo apt update`{{exec}}

# Install options

We'll cover using the node website directions, and using asdf


## Website Install

Head to the website: https://nodejs.org/en/download

select the version you need, in our case: Verion 22, on Windows, using NVM, and npm

copy and run the script, as below

(in the linux case, you'll need the 3 extra commands)

```
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Download and install Node.js:
nvm install 22
# Verify the Node.js version:
node -v # Should print "v22.12.0".
nvm current # Should print "v22.12.0".
# Verify npm version:
npm -v # Should print "10.9.0".
```

with node installed, you can jump to step 2.

## ASDF install


### install asdf

`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2`{{exec}}

`. "$HOME/.asdf/asdf.sh"`{{exec}} WIP pipe to .brashrc?

`echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc`{{exec}}

`. "$HOME/.asdf/completions/asdf.bash"`{{exec}}

`echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc`{{exec}}

`asdf current`{{exec}}

### install nodejs w/ asdf

To install in your own machine, head over to nodejs.org


`asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git`{{exec}}

`asdf list all nodejs`{{exec}}

`asdf install nodejs 20.11.1`{{exec}}

`asdf current`{{exec}}

`asdf global nodejs 20.11.1`{{exec}}

`asdf current`{{exec}}

`node -v`{{exec}}

### Install yarn w/ asdf

https://yarnpkg.com/

`asdf plugin-add yarn`{{exec}}

`asdf install yarn 1.22.10`{{exec}}

`asdf global yarn 1.22.10`{{exec}}

`asdf current`{{exec}}

`yarn -v`{{exec}}
