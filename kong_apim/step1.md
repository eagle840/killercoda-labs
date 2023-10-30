# Initial Setup

`apt update`{{exec}}

`apt install jq tree net-tools -y`{{exec}}


`docker network create kong-net`{{exec}}


## Review

services:   the services you want to expose   
routes:  entry ppoints and rules   
plugins: ouath, rate limit, other   
consumer: respresents a consumer   

with db https://docs.konghq.com/gateway/latest/install/docker/#install-kong-gateway-in-db-less-mode
dbless mode, use without a db  https://docs.konghq.com/gateway/latest/install/docker/#install-kong-gateway-in-db-less-mode

### Start PostgreSQL

```
 docker run -d --name kong-database \
  --network=kong-net \
  -p 5432:5432 \
  -e "POSTGRES_USER=kong" \
  -e "POSTGRES_DB=kong" \
  -e "POSTGRES_PASSWORD=kongpass" \
  postgres:13
```{{exec}}

### Boot strap a database
```
docker run --rm --network=kong-net  -e "KONG_DATABASE=postgres"  -e "KONG_PG_HOST=kong-database"  -e "KONG_PG_PASSWORD=kongpass"  -e "KONG_PASSWORD=test" kong/kong-gateway:3.4.1.0 kong migrations bootstrap
```{{exec}}
    

### Start Kong Gateway    
```
docker run -d --name kong-gateway  --network=kong-net  -e "KONG_DATABASE=postgres"  -e "KONG_PG_HOST=kong-database"  -e "KONG_PG_USER=kong"  -e "KONG_PG_PASSWORD=kongpass"  -e "KONG_PROXY_ACCESS_LOG=/dev/stdout"  -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout"  -e "KONG_PROXY_ERROR_LOG=/dev/stderr"  -e "KONG_ADMIN_ERROR_LOG=/dev/stderr"  -e "KONG_ADMIN_LISTEN=0.0.0.0:8001"  -e "KONG_ADMIN_GUI_URL=http://localhost:8002"  -e KONG_LICENSE_DATA  -p 8000:8000  -p 8443:8443  -p 8001:8001  -p 8444:8444  -p 8002:8002  -p 8445:8445  -p 8003:8003  -p 8004:8004  kong/kong-gateway:3.4.1.0
```{{exec}}
    
### Check back end    


`curl -i -X GET --url http://localhost:8001/services`{{exec}}
  
`curl -i -X GET --url http://localhost:8002`{{exec}}

`netstat -tlpn`{{exec}}

{{TRAFFIC_HOST1_8002}}

Now visit  https://docs.konghq.com/gateway/3.4.x/get-started/services-and-routes/

## Konga

https://github.com/pantsel/konga#production-docker-image


`docker pull pantsel/konga`{{exec}}

`docker run -d -p 1337:1337 --network kong-net --name konga -e "NODE_ENV=production" -e "TOKEN_SECRET=somerandomstring" pantsel/konga`{{exec}}

{{TRAFFIC_HOST1_8002}}

login with

`admin` & 'abcd1234'



---- do I need the below ----

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




