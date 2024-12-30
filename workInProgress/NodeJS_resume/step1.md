
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# Run First

`sudo apt update`{{exec}}




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
