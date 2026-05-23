# Step 1: Install Node.js with NVM

Before we can create a React application, we need to install Node.js and its package manager, npm. We'll use the Node Version Manager (nvm) to manage our Node.js versions.

### 1. Update Package Lists
First, let's update our system package lists.
`sudo apt update`{{exec}}

### 2. Install NVM
Run the following command to download and execute the NVM installation script.
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Source the script to apply changes to the current session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```{{exec}}

### 3. Install Node.js LTS
Now, use NVM to install the latest Long-Term Support (LTS) version of Node.js.
```bash
nvm install --lts

# Verify the installation
node -v
npm -v
```{{exec}}

This installs a stable version of Node.js and npm. You are now ready to build your React application!
