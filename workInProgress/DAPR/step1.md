
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

- dapr.yaml Multi-App Run template file, and it is referenced by default on dapr run calls unless otherwise overridden
- statestore.yaml component file
- pubsub.yaml component file

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


`asdf plugin-add nodejs`{{exec}}

`asdf install nodejs 14.17.0`{{exec}}

`asdf global nodejs 14.17.0`{{exec}}

`node -v; npm -v`{{exec}}

`node --version`{{exec}}

`git clone https://github.com/dapr/quickstarts.git`{{exec}}

`cd quickstarts/tutorials/hello-world/node`{{exec}}

`npm install`{{exec}}

WIP in app.js line 23 replace with `const port = '3000';`

`dapr run --app-id nodeapp --app-port 3000 --dapr-http-port 3500 node app.js`{{exec}}

Note the the green lines are dapr logs, and blue are the application logs.

## Start the Dapr Dashboard

Start a new terminal tab,

and start the dashboard `dapr dashboard  -a 0.0.0.0 -p 8080`{{exec}}

{{TRAFFIC_HOST1_8080}}

In new terminal

`cd quickstarts/tutorials/hello-world/node`{{exec}}

`curl -XPOST -d @sample.json -H Content-Type:application/json http://localhost:3500/v1.0/invoke/nodeapp/method/neworder`{{exec}}

Install VSC Rest Client  by humao

and send

```
POST http://localhost:3500/v1.0/invoke/nodeapp/method/neworder HTTP/1.1
Content-Type: application/json

{
  "data": {
    "orderId": "42"
  }
}
```

## Step 5


`curl http://localhost:3500/v1.0/invoke/nodeapp/method/order`{{exec}}

## step 6 python app

`cd ~/quickstarts/tutorials/hello-world/python`

`pip3 install requests`{{exec}}


`dapr run --app-id pythonapp python3 app.py`{{exec}}


## step 7 clean up

`dapr stop --app-id nodeapp`{{exec}}

`dapr stop --app-id pythonapp`{{exec}}

