# Containerize

WIP, think I need the mlflow extras package installed for this

### FROM LOCAL

see https://mlflow.org/docs/latest/quickstart_mlops.html?highlight=build%20docker#build-a-container-image-for-your-model

get the last local run:

`last_run=$( mlflow runs list --experiment-id 0  | awk 'NR==3{print $NF}' )`{{exec}}

`echo $last_run`{{exec}}

WIP delete `mlflow models generate-dockerfile --model-uri runs:/$iast_run/model --enable-mlserver`{{copy}}

`mlflow models generate-dockerfile`{{exec}}

`mlflow-dockerfile`{{exec}}

`cat mlflow-dockerfile/Dockerfile`{{exec}}

`mlflow models build-docker`{{exec}}


`docker images`{{exec}}

run  
`docker images |  awk ' '/latest/' {print $1}'`{{exec}}


`mlflow models --help`{{exec}}


### FROM SQLITE

WIP set MLFLOW_TRACKING_URI





