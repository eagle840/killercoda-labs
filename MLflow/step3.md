# create a docker file/container

WIP, think I need the mlflow extras package installed for this

mlflow models generate-dockerfile --model-uri runs:/6b089afd33cd4a848d29491337f4d1a7/model --enable-mlserver




# Using Conda with docker

you can follow the rest of the examples at https://mlflow.org/docs/latest/tutorials-and-examples/index.html

Some of the mlprojects appear to need conda, so use a docker image?

docker run -i -t continuumio/anaconda3 /bin/bash


`docker run -it -p 5000:5000 continuumio/anaconda3 /bin/bash`{{exec}}

from: https://hub.docker.com/r/continuumio/anaconda3 

