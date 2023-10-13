# step 2

## create service

`curl -i -s -X POST http://localhost:8001/services --data name=example_service --data url='http://mockbin.org' | jq`{{exec}}


## Viewing service configuration

`curl -X GET http://localhost:8001/services/example_service | jq`{{exec}}

## Updating services

`curl --request PATCH --url localhost:8001/services/example_service --data retries=6 | jq `{{exec}}

## List Services

`curl -X GET http://localhost:8001/services | jq`{{exec}}


# Kong Plugins

https://docs.konghq.com/hub/