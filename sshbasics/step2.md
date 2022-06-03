# connect from the outside world

Let's get the IP address of the server

`curl -k https://diagnostic.opendns.com/myip`{{execute}}

open putty and try to connect  using the un and pw

OR

The lastest version of Windows 10 now has the ssh command



#### create ssh keys and try to connect

WIP win:cmd, win:PS, linux, mac

Generate your key
`ssh-keygen`
Configure ssh to use the key
`vim ~/.ssh/config`   

Host SERVERNAME
Hostname ip-or-domain-of-server
User USERNAME
PubKeyAuthentication yes
IdentityFile ./path/to/key


Copy your key to your server
`ssh-copy-id -i /path/to/key.pub SERVERNAME`
