
# Docker Install

We'll need the latest version of docker

## System update

`sudo apt update`{{exec}}

## Docker remove

`apt-get remove docker  docker.io containerd runc -y`{{exec}}

## Docker install

`apt-get install ca-certificates curl gnupg  lsb-release -y`{{exec}}

`mkdir -p /etc/apt/keyrings`{{exec}}

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`{{exec}}

```
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```{{exec}}

`apt-get update`{{exec}}

`apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y `{{exec}}

## Docker version check

`docker version`{{exec}}

`docker-compose version`{{exec}}

`docker compose version`{{exec}}

##  Install OpenSearch (docker)

https://opensearch.org/docs/latest/getting-started/quickstart/

`sudo swapoff -a`{{exec}}

`sudo vi /etc/sysctl.conf`{{exec}}

edit by adding `vm.max_map_count=262144`{{copy}}

i: insert

esc

:wq  write and quit




`sudo sysctl -p`{{exec}}

`curl -O https://raw.githubusercontent.com/opensearch-project/documentation-website/2.19/assets/examples/docker-compose.yml`{{exec}}


Edit the docker file with a password

`OPENSEARCH_INITIAL_ADMIN_PASSWORD='myPassword1234'`{{exec}}

`docker compose up -d`{{exec}}

`docker compose ps`{{exec}}

`curl https://localhost:9200 -ku admin:myPassword1234`{{exec}}


## connect

{{TRAFFIC_HOST1_5601}}
