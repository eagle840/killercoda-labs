# step 2


Following https://docs.konghq.com/gateway/3.4.x/get-started/services-and-routes/
## create service

`curl -i -s -X POST http://localhost:8001/services --data name=example_service --data url='http://mockbin.org'`{{exec}}


## Viewing service configuration

`curl -X GET http://localhost:8001/services/example_service | jq`{{exec}}

## Updating services

`curl --request PATCH --url localhost:8001/services/example_service --data retries=6 | jq `{{exec}}

## List Services

`curl -X GET http://localhost:8001/services | jq`{{exec}}


# Kong Plugins

https://docs.konghq.com/hub/


## 3rd party

old one: https://github.com/PGBI/kong-dashboard

`apt install npm`{{exec}}

`git clone https://github.com/PGBI/kong-dashboard`{{exec}}

`cd kong-dashboard`{{exec}}

`npm install -g kong-dashboard`

`kong-dashboard start --kong-url http://kong:8001`{{exec}}

`kong-dashboard start --kong-url http://kong:8001 --port [port]`{{exec}}

 `kong-dashboard start --kong-url http://kong:8001 --basic-auth user1=password1 user2=password2` {{exec}}

`kong-dashboard start --help`{{exec}}
