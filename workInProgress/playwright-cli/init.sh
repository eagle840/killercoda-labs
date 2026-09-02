# 1. Create the user with a home directory and bash shell
useradd -ms /bin/bash coder

# 2. Set a password for the user (replace 'mysecurepassword' with your choice)
echo "coder:mysecurepassword" | chpasswd

# 3. Add the user to the sudo group (Ubuntu/Debian based environments)
usermod -aG sudo coder