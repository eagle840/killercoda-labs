# This script creates a new user and sets up their environment, allowing them to run commands with sudo privileges.
# it needs to be run from the index.json intro section "foreground": "init.sh"


# 1. Create the user with a home directory and bash shell
useradd -ms /bin/bash coder

# 2a. Set a password for the user (replace 'mysecurepassword' with your choice)
# echo "coder:mysecurepassword" | chpasswd


# 2b. Grant passwordless sudo rights via a secure sudoers drop-in file
echo "coder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/coder
chmod 0440 /etc/sudoers.d/coder


## 3. Add the user to the sudo group (Ubuntu/Debian based environments)
#usermod -aG sudo coder

# 4. Switch to the new user and set up their environment
su - coder