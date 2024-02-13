# python


```
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.4

# For Ubuntu or other linux distros
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
```{{exec}}

`bash`{{exec}}

`asdf plugin-add python`{{exec}}


`asdf install python 3.7.4`{{exec}}



## Quickstart  pub/sub

https://docs.dapr.io/getting-started/quickstarts/pubsub-quickstart/



`git clone https://github.com/dapr/quickstarts.git`{{exec}}

`cd quickstarts`{{exec}}

`cd pub_sub/python/sdk`{{exec}}

`cat dapr.yml`{{exec}}

```
cd ./checkout
pip3 install -r requirements.txt
cd ..
cd ./order-processor
pip3 install -r requirements.txt
cd ..
cd ./order-processor-fastapi
pip3 install -r requirements.txt
cd ..

```

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

