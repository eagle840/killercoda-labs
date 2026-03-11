

# Step 1: Install Node.js with NVM

Before we can create a React application, we need to install Node.js and its package manager, npm. We'll use the Node Version Manager (nvm), a script that lets you easily install and manage different Node.js versions.

First, let's update our package lists.
`sudo apt update`{{exec}}

### 1. Install NVM

Run the following command to download and execute the nvm installation script.
```bash
# Download and install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Source the script to apply the changes to the current session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```{{exec}}

### 2. Install Node.js

Now, we can use nvm to install a recent version of Node.js.
```bash
# Install the latest Long-Term Support (LTS) version of Node.js
nvm install --lts

# Verify the installation
node -v
npm -v
```{{exec}}

This will install the latest stable version of Node.js and npm, and you should see the version numbers printed in your terminal.




## Live-Server

`npm install -g live-server`{{exec}}

`live-server -v`{{exec}}

--

DON'T RUN BELOW

`npm run dev`{{exec}}

{{TRAFFIC_HOST1_3000}}
