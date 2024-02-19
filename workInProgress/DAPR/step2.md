# python



`asdf plugin-add python`{{exec}}


`asdf install python 3.7.4`{{exec}}

`asdf global python 3.7.4`{{exec}}

`pip install --upgrade pip`{{exec}}


## Quickstart  pub/sub

https://docs.dapr.io/getting-started/quickstarts/pubsub-quickstart/


`cd ~/quickstarts/pub_sub/python/sdk`{{exec}}

`cat dapr.yaml`{{exec}}


`pip3 install -r checkout/requirements.txt && pip3 install -r order-processor/requirements.txt && pip3 install -r order-processor-fastapi/requirements.txt`{{exec}}

WIP `pip install uvicorn`{{exec}}


Running the Multi-App Run template file with dapr run -f . starts all applications in your project.

`dapr run -f .`{{exec}}


## Use the Dapr API

Run a Dapr sidecar and try out the state API



Launch a Dapr sidecar that will listen on port 3500 for a blank application named myapp:


`dapr run --app-id myapp --dapr-http-port 3500`{{exec}}

`curl -X POST -H "Content-Type: application/json" -d '[{ "key": "name", "value": "Bruce Wayne"}]' http://localhost:3500/v1.0/state/statestore`{{exec}}

`curl http://localhost:3500/v1.0/state/statestore/name`{{exec}}

`docker exec -it dapr_redis redis-cli`{{exec}}


`keys *`{{exec}}

`exit`{{exec}}

`curl -v -X DELETE -H "Content-Type: application/json" http://localhost:3500/v1.0/state/statestore/name`{{exec}}

