
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

`apt install tree -y`{{exec}}

```
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.4

# For Ubuntu or other linux distros
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
export ASDF_DOWNLOAD_PATH="$HOME/.asdf/downloads"
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
```{{exec}}

`bash`{{exec}}

# Run First

https://docs.dapr.io/getting-started/

see MS youtube on DAPR [link](https://www.youtube.com/watch?v=nK8Ss2UMAxc)

## Install the Dapr CLI


`wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O - | /bin/bash`{{exec}}

`dapr -h`{{exec}}


`dapr --version`{{exec}}




## Initialize Dapr in your local environment

`dapr init`{{exec}}

When you ran dapr init during Dapr install, the following YAML files were generated in the .dapr/components directory:

- ***dapr.yaml*** Multi-App Run template file, and it is referenced by default on dapr run calls unless otherwise overridden
- ***statestore.yaml*** component file
- ***pubsub.yaml*** component file

`tree -L 3 .dapr`{{exec}}

### look at the stalled components

`cat .dapr/config.yaml`{{exec}}

`cat .dapr/components/statestore.yaml`{{exec}}

`cat .dapr/components/pubsub.yaml`{{exec}}

and compare them with the docker ps output

`docker ps`{{exec}}

checkout the set available set of components @ https://docs.dapr.io/reference/components-reference/

## Hello World

We'll be using the node tutorial.

review: https://github.com/dapr/quickstarts/tree/master/tutorials/hello-world


### Install node
`asdf plugin-add nodejs`{{exec}}

`asdf install nodejs 14.17.0`{{exec}}

`asdf global nodejs 14.17.0`{{exec}}

`node -v; npm -v`{{exec}}

### Install and run the node app with dapr

`git clone https://github.com/dapr/quickstarts.git`{{exec}}

`cd quickstarts/tutorials/hello-world/node`{{exec}}

`npm install`{{exec}}

WIP in app.js line 23 replace with `const port = '3000';`

`dapr run --app-id nodeapp --app-port 3000 --dapr-http-port 3500 node app.js`{{exec}}

Note the the green lines are dapr logs, and blue are the application logs.

### Start the Dapr Dashboard

Start a new terminal tab,

and start the dashboard `dapr dashboard  -a 0.0.0.0 -p 8080`{{exec}}

{{TRAFFIC_HOST1_8080}}

### Use the app

In new terminal

`cd quickstarts/tutorials/hello-world/node`{{exec}}

`curl -XPOST -d @sample.json -H Content-Type:application/json http://localhost:3500/v1.0/invoke/nodeapp/method/neworder`{{exec}}

You can install VSC 'Rest Client'  (by humao) into vsc and send a post request


```
POST http://localhost:3500/v1.0/invoke/nodeapp/method/neworder HTTP/1.1
Content-Type: application/json

{
  "data": {
    "orderId": "42"
  }
}
```

### Confirm successful persistence

Lets use the dapr cli

`dapr invoke --app-id nodeapp --method order --verb GET`{{exec}}

OR

`curl http://localhost:3500/v1.0/invoke/nodeapp/method/order`{{exec}}

OR 

use Rest Client

```
GET http://localhost:3500/v1.0/invoke/nodeapp/method/order
```



##  clean up

`dapr stop --app-id nodeapp`{{exec}}

`dapr stop --app-id pythonapp`{{exec}}

