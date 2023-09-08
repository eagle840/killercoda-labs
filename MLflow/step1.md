
# Initial Setup


# WIP mafor update to mlflow

IT SEEMS that using venv is the only way to get pass the 3.8 issues

install python

`chmod +x python_install.sh`{{exec}}

`./python_install.sh`{{exec}}


`apt-get update -y`{{execute}}

`apt install net-tools tree jq sqlite3 python3-pip -y`{{exec}}

`sudo add-apt-repository -y ppa:deadsnakes/ppa`{{execute}}

`sudo apt-get update`{{execute}}

`apt-get install -y python3.11`{{execute}}

`apt install -y python3.11-venv`{{execute}}

## MLFLow

`git clone https://github.com/mlflow/mlflow`{{exec}}

`cd mlflow`{{exec}}

`python3.11 -m venv .venv`{{execute}}

`source .venv/bin/activate`{{execute}}

`pip install --upgrade pip`{{exec}}



`pip install --upgrade pip`{{exec}}

`git clone https://github.com/mlflow/mlflow`{{exec}}


##### Install mlflow

`pip install -U click jinja2`{{exec}} 

`pip install mlflow`{{exec}}

##### Install MLflow with extra ML libraries and 3rd-party tools

`pip install mlflow[extras]`{{copy}}

There are 4 major components to MLFlow: Tracking, Projects, Models, and Registry

# MLFlow Tracking Tool

## Run our 1st mlflow

`cd ~/mlflow/examples/quickstart/`{{exec}}

This first example flow prints some log outputs:

`cat mlflow_tracking.py`{{exec}}

Take  a look at the mlflow_tracking.py in the editor, and notice that it's using the mlflow modules to run some logs and setting random values - we'll view these in the web gui. Lets run it (return to tab1).

`python mlflow_tracking.py`{{exec}}

and note that some new folders have been created for mlflow.

`tree`{{exec}}

By default, mlflow will track resources in the local mlruns folder, in a future step we'll change that to a sqlite database

each numbered folder is an 'experiment', and each experiment has 'runs' with alphanumberic numbers. (as shown in the UI later).      
     - meta data file: basic info about the experiment, inc 'name'   
     - tags folder - more info about the 'experiment/run'   
    
lets list out experiment 0 runs:

`mlflow runs list --experiment-id 0`{{exec}}
     
      

This working in conjunction with the mlflow ui tool.

(Since we're running it on killercoda, will specify a host of 0.0.0.0 so it can be accessed by any computer.)

`mlflow ui --host 0.0.0.0`{{exec}}

you can access the ui at port 5000 {{TRAFFIC_HOST1_5000}} and note the program details we just run.

Note how the UI corresponds with the folder directory.

Add some info into the description in the ui for this project.

Exit out of the ui server (ctrl-c)






    ==================================
## Another Example:

In this example, we'll be using  scikit learn


`pip install -U scikit-learn`{{exec}}


## Linear Regression Model

https://scikit-learn.org/stable/modules/linear_model.html#elastic-net

`cd ~/mlflow/examples/sklearn_elasticnet_wine/`{{exec}}

WIP `pip install notebook`{{exec}}

`cat train.py`{{exec}}

note:   
   - mlflow.sklearn.log_model  - will store the generated model

Note the directory/file structure:

`tree`{{exec}}


This example will use a mlProject file to run the code

`cat MLproject`{{exec}}

WIP `cat conda.yaml`{{exec}}

WIP `jupyter notebook --ip=0.0.0.0 --allow-root`{{exec}}


this time we'll run the project with the mlflow command, this will usually setup a conda environment, but for now we'll turn that feature off ([--env-manager local](https://mlflow.org/docs/latest/cli.html?highlight=conda#cmdoption-mlflow-run-env-manager)), and set just the alpha hyper-parameter:

`mlflow run . -P alpha=0.5 --env-manager local`{{exec}}

(the '.' is the present directry, but can be replaced with a folder name)

WIP : I think we use the mlflow run  since it uses the conda env by default, were as python train.py is in the present environment

note the 'ID' of the output, and compare it against:

`mlflow runs list --experiment-id 0`{{exec}}


`tree`{{exec}}

this time, note the contents of the artifacts folder, the pickle file (.pkl) is actually the model code.

and lets run it again with different parameters

`python train.py <alpha> <l1_ratio>`

`python train.py 0.3 0.6`{{exec}}

`tree`{{exec}}

run the model a training a couple more times with different parmeters:

`python train.py 0.4 0.6`{{exec}}

`python train.py 0.35 0.6`{{exec}}

lets look at the ui now:

`mlflow ui --host 0.0.0.0`{{exec}} 

you can access the ui at port 5000 {{TRAFFIC_HOST1_5000}} 


## compare model parameters

Go back into the UI, and tick the check boxs againt all three runs, and click on compare. This will give you an analyical comparison of the runs, allowing you to pick the best model for your requirement.


