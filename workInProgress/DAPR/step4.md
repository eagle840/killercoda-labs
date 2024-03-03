Step 4: Quickstart: Service Invocation

Get started with Dapr’s Service Invocation building block


Reference  https://docs.dapr.io/getting-started/quickstarts/serviceinvocation-quickstart/


# Multirun

## Step 1: Pre-requisites

Dapr installed

Python 3.7+

`python -v`{{exec}}

`docker -version`{{exec}}




## Step 2: Set up the environment

`git clone https://github.com/dapr/quickstarts.git`{{exec}}

`cd service_invocation/python/http`{{exec}}

```
cd ./order-processor
pip3 install -r requirements.txt
cd ../checkout
pip3 install -r requirements.txt
cd ..
```{{exec}}

Step 3: Run the order-processor and checkout services

With the following command, simultaneously run the following services alongside their own Dapr sidecars:

The order-processor service
The checkout service

`dapr run -f .`{{exec}}

# One App at a time

## Run order-processor service


`cd service_invocation/python/http/order-processor`{{exec}}

`pip3 install -r requirements.txt`{{exec}}

`dapr run --app-port 8001 --app-id order-processor --app-protocol http --dapr-http-port 3501 -- python3 app.py`{{exec}}

## Run checkout service

`cd service_invocation/python/http/checkout`{{exec}}


`pip3 install -r requirements.txt`{{exec}}

`dapr run --app-id checkout --app-protocol http --dapr-http-port 3500 -- python3 app.py`{{exec}}
