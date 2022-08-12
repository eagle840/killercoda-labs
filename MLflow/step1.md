
# Initial Setup

First we'll setup the environment

`apt-get update -y`{{execute}}


`apt install net-tools tree jq  python3-pip -y`{{exec}}

`git clone https://github.com/mlflow/mlflow`{{exec}}



##### fix a dependance issue

`pip install -U click jinja2`{{exec}} 

##### install mlflow

`pip install mlflow`{{exec}}

##### Install MLflow with extra ML libraries and 3rd-party tools
`pip install mlflow[extras]`{{copy}}

## Run our 1st mlflow

`cd mlflow/examples/quickstart/`{{exec}}

Take  a look at the mlflow_tracking.py in the editor, and notice that it's using the mlflow modules to run some logs. Lets run it (return to tab1).

`python mlflow_tracking.py`{{exec}}

and note that some new folders have been created for mlflow.

`tree`{{exec}}

each numbered folder is an 'experiment' (as shown in the UI later).   
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

`cat mlruns/0/tags/mlflow.note.content`{{exec}}






    ==================================
## Another Example:

# WIP  - running out of drive space after caonda install, df -h

For this example, we'll need conda installed (http link)

`cd ~`{{exec}}

WIP `df -h /dev/vda1`{{exec}}

`wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh`{{exec}}

`wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh`{{copy}}

`chmod +x Anaconda3-2021.05-Linux-x86_64.sh`{{exec}}

run, accept the license, and init when prompted:

`./Anaconda3-2021.05-Linux-x86_64.sh`{{exec}}

`rm Anaconda3-2021.05-Linux-x86_64.sh `{{exec}}

WIP `df -h /dev/vda1`{{exec}}

restart the shell: `exec bash`{{exec}}

WIP `conda deactivate`{{exec}}

check the version: `conda -V`{{exec}}

`cd ~/mlflow/examples/sklearn_elasticnet_wine/`{{exec}}

Note the directory/file structure:

`tree`{{exec}}

This example will use a mlProject file to run the code

`cat MLproject`{{exec}}

run the project:

`mlflow run . -P alpha=0.5 `{{exec}}

(the '.' is the present directry, but can be replaced with a folder name)

`tree`{{exec}}

and lets run it again with different parameters

`python train.py 0.3 0.6`{{exec}}

`tree`{{exec}}

lets look at the ui now:

`mlflow ui --host 0.0.0.0`{{exec}} 


