
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

https://learn.microsoft.com/en-us/powershell/scripting/samples/creating-.net-and-com-objects--new-object-?view=powershell-7.5

# Run First

`cat /etc/os-release`{{exec}}

`sudo apt update`{{exec}}



# install Powershell

## Update the list of packages REMOVE THIS SECTION
`sudo apt-get update`{{exec}}

`sudo apt-get install -y wget apt-transport-https software-properties-common`{{exec}}

`source /etc/os-release`{{exec}}

`wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`rm packages-microsoft-prod.deb`{{exec}}



## Install PowerShell


###################################
# Prerequisites

wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

# Update the list of packages
`sudo apt-get update`{{exec}}

# Install pre-requisite packages.
`sudo apt-get install -y wget apt-transport-https software-properties-common`{{exec}}

# Get the version of Ubuntu
`source /etc/os-release`{{exec}}

# Download the Microsoft repository keys
`wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb`{{exec}}

# Register the Microsoft repository keys
`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

# Delete the Microsoft repository keys file
`rm packages-microsoft-prod.deb`{{exec}}

# Update the list of packages after we added packages.microsoft.com
`sudo apt-get update`{{exec}}

###################################
# Install PowerShell
`sudo apt-get install -y powershell`{{exec}}

# Start PowerShell
`pwsh`{{exec}}

`exit`{{exec}}


---

##################################
# Install dotnet

do i need? `wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}


`sudo add-apt-repository ppa:dotnet/backports`{{exec}}


`sudo apt-get update`{{exec}}

`sudo apt-get install -y dotnet-sdk-9.0`{{exec}}

`dotnet --version`{{exec}}

DELETE BELOW

`sudo apt-get install -y powershell`{{exec}}

`pwsh`{{exec}}

# install .NET 6 sdk

`lsb_release  -a`{{exec}}

`wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install -y apt-transport-https`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install -y dotnet-sdk-6.0`{{exec}}

`dotnet --version`{{exec}}

---- delete below ----

# docker update

`apt-get remove docker  docker.io containerd runc -y`{{exec}}

`apt-get update`{{exec}}

`apt-get install ca-certificates curl gnupg  lsb-release -y`{{exec}}

`mkdir -p /etc/apt/keyrings`{{exec}}

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`{{exec}}

```
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```{{exec}}

`apt-get update`{{exec}}

`apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y `{{exec}}

`docker version`{{exec}}

`docker-compose version`{{exec}}

`docker compose version`{{exec}}

# Set imageid in index.json

- ubuntu: Ubuntu 20.04 with Docker and Podman
= kubernetes-kubeadm-2nodes:
- kubernetes-kubeadm-1node:

to taint the control node for work:

```
kubectl taint nodes controlplane node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-
```


# Copy Files/adjust index

text here

# Run apt update

apt-get update -y{{execute}}

```apt-get update -y{{execute}}```


# For links to ports:

```
Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_80}}
Link for traffic into host 2 on port 4444
{{TRAFFIC_HOST2_4444}}
Link for traffic into host X on port Y
{{TRAFFIC_HOSTX_Y}}
```


# Example setup for postgres with raw data

git clone https://github.com/josephmachado/simple_dbt_project.git

- raw folders
- warehouse setup
- docker postgres and -v to those folders


We'll be using the rabbitmq container with the management feature installed.

https://hub.docker.com/_/rabbitmq

`docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 rabbitmq:3-management`{{execute}}

make sure it started

`docker ps`{{execute}}

and check the config file

`docker exec some-rabbit cat /etc/rabbitmq/rabbitmq.conf`{{execute}}

and head over to port 8080 and login
un:guest
pw:guest


Next we'll update the python files with the new IP address of the docker container.

`RabbitIP=$(docker inspect some-rabbit | jq -r .[0].NetworkSettings.IPAddress)`{{execute}}

`echo $RabbitIP`{{execute}}

`sed -i "s/localhost/$RabbitIP/g" send.py receive.py worker.py new_task.py`{{execute}}

## k8s port-forward

`k -n <ns> port-forward service/<svc-name> 9090:9090 --address 0.0.0.0`

- this is to forword a CLusterIP so that killacoda can access


`echo 'PATH=$PATH':$(pwd)/bin >> /root/.bashrc`{{copy}}

export PATH=$PWD/bin:$PATH

to allow pods on the controlplane

`kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-`{{copy}}

to allow access to running pods with ports 9000 and 9090

`kubectl port-forward -n minio-dev pod/minio 9000 9090 --address 0.0.0.0`{{copy}}
