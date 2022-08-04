
# Initial Setup

First we'll setup the environment

`apt-get update -y`{{execute}}


`apt install net-tools tree jq  python3-pip -y`{{exec}}

`git clone https://github.com/mlflow/mlflow`{{exec}}



### fix a dependance issue

`pip install -U click`{{exec}} <=WIP

`pip install mlflow`{{exec}}

## Run our 1st mlflow

`cd mlflow/examples/quickstart/`{{exec}}

Take  a look at the mlflow_tracking.py in the editor, and notice that it's using the mlflow modules to run some logs. Lets run it.

`python mlflow_tracking.py`{{exec}}

and note that some new folders have been created for mlflow.

`tree`{{exec}}

each <number> folder is an 'experiment' as shown in the UI.
     - meta data file: basic info about the experiment, inc 'name'
     - tags folder - more info about the 'experiment'
     - numbered folders for each run of the ml program

This working in conjunction with the mlflow ui tool.

(Since we're running it on killercoda, will specify a host of 0.0.0.0 so it can be accessed by any computer.)

`mlflow ui --host 0.0.0.0`{{exec}}

you can access the ui at port 5000 {{TRAFFIC_HOST1_5000}} and note the program details we just run.

Note how the UI corresponds with the folder directory.

Add some info into the description in the ui for this project.

And you can see it's added to the file:

`cat`  <=>



##################  scrap

might be better of using https://mlflow.org/docs/latest/tutorials-and-examples/index.html

some of the mlprojects appear to need conda, so use a docker image?

docker run -i -t continuumio/anaconda3 /bin/bash


`docker run -it -p 5000:5000 continuumio/anaconda3 /bin/bash`

from: https://hub.docker.com/r/continuumio/anaconda3  (with instructions)

    1  pip install mlflow
    2  git clone https://github.com/mlflow/mlflow
    3   # cd mlflow/examples/quickstart/
    4  mlflow run sklearn_elasticnet_wine -P alpha=0.5  # <= appears to need to be in ~ dir


    ==================================
## Another Example:

YOU NEED CONDA INSTALLED

This example will use a mlProject file to run the code

`cat MLproject`{{exec}}

    1  pip install mlflow[extras]  <= Whats the diff vs reg?


`cd ~/mlflow/examples/sklearn_elasticnet_wine/`{{exec}}

Note the directory/file structure:

`tree`{{exec}}

This example will use a mlProject file to run the code

`cat MLproject`{{exec}}

`mlflow run sklearn_elasticnet_wine -P alpha=0.5 `{{exec}}

 \/ what happens when we run this? with out mlflow 

`python sklearn_elasticnet_wine/train.py`{{exec}}

Check the directory structure again:

`tree`{{exec}}

and lets run it again with different parameters

`python sklearn_elasticnet_wine/train.py 0.3 0.6`{{exec}}

`tree`{{exec}}

lets look at the ui now:

`mlflow ui --host 0.0.0.0`{{exec}} 


