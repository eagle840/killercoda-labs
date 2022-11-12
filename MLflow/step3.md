# Containerize

WIP, think I need the mlflow extras package installed for this

### FROM LOCAL

get the last local run:

`last_run=$( mlflow runs list --experiment-id 0  | awk 'END{print $5}' )`{{exec}}

`mlflow models generate-dockerfile --model-uri runs:/$iast_run/model --enable-mlserver`{{copy}}

`cat mlflow-dockerfile/Dockerfile`{{exec}}

`mlflow models build-docker`{{exec}}

`docker images`{{exec}}

run  
`docker images |  awk ' '/latest/' {print $1}'`{{exec}}


`mlflow models --help`{{exec}}


### FROM SQLITE

WIP set MLFLOW_TRACKING_URI




# Using Conda with docker

you can follow the rest of the examples at https://mlflow.org/docs/latest/tutorials-and-examples/index.html

Some of the mlprojects appear to need conda, so use a docker image?

docker run -i -t continuumio/anaconda3 /bin/bash


`docker run -it -p 5000:5000 continuumio/anaconda3 /bin/bash`{{exec}}

from: https://hub.docker.com/r/continuumio/anaconda3 

