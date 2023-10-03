# Initial Setup

`apt install jq tree net-tools -y`{{exec}}

```
sudo apt update
apt-get remove docker  docker.io containerd runc -y
apt-get update
```{{exec}}

```
apt-get install ca-certificates curl gnupg  lsb-release -y
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```{{exec}}

```
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```{{exec}}   

`apt-get update`{{exec}}   

`yes n | apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y `{{exec}}  

force the following into a single command  (above)

`sudo apt update`{{exec}}

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

## Install Kong

WIP following isn't working, use https://docs.konghq.com/gateway/latest/install/docker/
and connect to {{TRAFFIC_HOST1_8001}}
 
 needs a license! https://github.com/pantsel/konga a possible solution

`sudo apt update`{{exec}}

`git clone https://github.com/Kong/docker-kong`{{exec}}

`cd docker-kong/compose/`{{exec}}

`ls`{{exec}}

`cat docker-compose.yml`{{exec}}

edit the /conf/kong.yaml

WIP this config need work, instead consider setting the values in compose-docker from 127.0.0.1 to 0.0.0.0

```
admin_listen:
     - 0.0.0.0:8001
     - 0.0.0.0:8444
```
WIP  check docs

https://docs.konghq.com/gateway/latest/production/deployment-topologies/db-less-and-declarative-config/#declarative-configuration-format

https://docs.konghq.com/deck/latest/guides/defaults/#set-custom-defaults

`export KONG_DATABASE=postgres`{{exec}}

`docker compose  up db -d`{{exec}} wait a minute, when

`docker compose up`{{exec}}


WIP check port number

{{TRAFFIC_HOST1_8001}}




