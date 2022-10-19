
# Initial Setup

First we'll setup the environment

`apt-get update -y`{{execute}}


`apt install net-tools tree jq  python3-pip -y`{{exec}}

`git clone https://github.com/mlflow/mlflow`{{exec}}

Need to know more on ML, try

https://www.w3schools.com/python/python_ml_getting_started.asp



##### fix a dependance issue

`pip install -U click jinja2`{{exec}} 

##### install mlflow

`pip install mlflow`{{exec}}

##### Install MLflow with extra ML libraries and 3rd-party tools

`pip install mlflow[extras]`{{copy}}

There are 4 major components to MLFlow: Tracking, Projects, Models, and Registry

# MLFlow Tracking Tool

## Run our 1st mlflow

`cd mlflow/examples/quickstart/`{{exec}}

This first example flow prints some log outputs:

`cat mlflow_tracking.py`{{exec}}

Take  a look at the mlflow_tracking.py in the editor, and notice that it's using the mlflow modules to run some logs. Lets run it (return to tab1).

`python mlflow_tracking.py`{{exec}}

and note that some new folders have been created for mlflow.

`tree`{{exec}}

each numbered folder is an 'experiment', and each experiment has 'runs' with alphanumberic numbers. (as shown in the UI later).      
     - meta data file: basic info about the experiment, inc 'name'   
     - tags folder - more info about the 'experiment/run'   
      

This working in conjunction with the mlflow ui tool.

(Since we're running it on killercoda, will specify a host of 0.0.0.0 so it can be accessed by any computer.)

`mlflow ui --host 0.0.0.0`{{exec}}

you can access the ui at port 5000 {{TRAFFIC_HOST1_5000}} and note the program details we just run.

Note how the UI corresponds with the folder directory.

Add some info into the description in the ui for this project.

Exit out of the ui server, and you can see it's added to the file:

`cat mlruns/0/tags/mlflow.note.content`{{exec}}






    ==================================
## Another Example:

In this example, we'll be using the Python Conda environment, and running sklearn

For this example, we'll need conda installed (http link)

`cd ~`{{exec}}

WIP `df -h /dev/vda1`{{exec}}

`wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh`{{exec}}

`chmod +x Miniconda3-latest-Linux-x86_64.sh`{{exec}}

run, accept the license, and init when prompted:

`./Miniconda3-latest-Linux-x86_64.sh`{{exec}}

`rm Miniconda3-latest-Linux-x86_64.sh `{{exec}}

WIP `df -h /dev/vda1`{{exec}}

`echo 'PATH=$PATH':"/root/miniconda3/bin" >> /root/.bashrc`{{exec}}

restart the shell: `exec bash`{{exec}}

`conda -h`{{exec}}

Conda will automatically enter into an environment, lets exit it:

`conda deactivate`{{exec}}

check the version: `conda -V`{{exec}}

`cd ~/mlflow/examples/sklearn_elasticnet_wine/`{{exec}}

`cat train.py`{{exec}}

Note the directory/file structure:

`tree`{{exec}}

This example will use a mlProject file to run the code

`cat MLproject`{{exec}}

WIP `cat conda.yaml`{{exec}}

WIP `conda env create -f conda.yaml`{{exec}}

you have sucessfully installed the envuronment when you see:

# To activate this environment, use
#
#     $ conda activate tutorial
#
# To deactivate an active environment, use
#
#     $ conda deactivate

WIP `conda activate tutorial`{{exec}}



run the project:

`mlflow run . -P alpha=0.5 `{{exec}}

(the '.' is the present directry, but can be replaced with a folder name)

`tree`{{exec}}

and lets run it again with different parameters

`python train.py 0.3 0.6`{{exec}}

`tree`{{exec}}

lets look at the ui now:

`mlflow ui --host 0.0.0.0`{{exec}} 

you can access the ui at port 5000 {{TRAFFIC_HOST1_5000}} 

Now run the same mlflow run again, with different parameters (eg: .45 and .55)

Go back into the UI, and select all three runs, and click on compare. This will give you an analyical comparison of the runs.


