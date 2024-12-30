
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
```{{exec}}

with node installed, you can jump to step 2.

WIP # Install a user

1. Open a terminal window.

2. Run the following command and follow the prompts to set up the new user:
```bash
sudo adduser jsuser
```{{exec}}
Replace `newusername` with the desired username for the new user.

3. You will be prompted to set a password for the new user and provide additional information like full name, phone number, etc. You can skip these additional fields by pressing Enter.

4. Once the user is created, you can switch to the new user account using the `su` command:
```bash
su - jsuser
```{{exec}}
Enter the password for the new user when prompted.
