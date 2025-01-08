
# Docker Install


## System update

`sudo apt update`{{exec}}

`apt install jq -y`{{exec}}

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

Lets pull down the images we'll use.

`docker pull  ghcr.io/zaproxy/zaproxy:stable`{{exec}}

`docker pull bkimminich/juice-shop`{{exec}}

Lets start juice shop

`docker run --rm -p 3000:3000 bkimminich/juice-shop`{{exec}}

WIP Also at https://juice-shop.herokuapp.com/

and confirm it's up with a apu call


`curl http://localhost:3000/rest/products/search?q=Apple`{{exec}}
