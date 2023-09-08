# Containerize

WIP, think I need the mlflow extras package installed for this

### FROM LOCAL

see https://mlflow.org/docs/latest/quickstart_mlops.html?highlight=build%20docker#build-a-container-image-for-your-model

get the last local run in the quickstart folder (filebased registry)

`cd ~/mlflow/examples/sklearn_elasticnet_wine/`{{exec}}

`last_run=$( mlflow runs list --experiment-id 0  | awk 'NR==3{print $NF}' )`{{exec}}

`echo $last_run`{{exec}}

We'll generate a Dockerfile

`mlflow models generate-dockerfile`{{exec}}

`cat mlflow-dockerfile/Dockerfile`{{exec}}

And build the image - this will take several minutes.

`mlflow models build-docker`{{exec}}


`docker images`{{exec}}

run  
`docker images |  awk ' '/latest/' {print $1}'`{{exec}}


`mlflow models --help`{{exec}}

WIP deploy image, see https://mlflow.org/docs/latest/models.html#local-model-deployment


### FROM SQLITE

WIP set MLFLOW_TRACKING_URI





