
# servering the model

https://www.mlflow.org/docs/latest/model-registry.html

the standard run command is:

`mlflow models serve --model-uri runs:/<ID>/model --no-conda`{{copy}}

lets look at the last set of runs:


`mlflow runs list --experiment-id 0`{{exec}}

and select the last run (assuming it has a pickle file from the last model run)

`last_run=$( mlflow runs list --experiment-id 0  | awk 'NR==3{print $NF}' )`{{exec}}

`mlflow models serve -m ./mlruns/0/$last_run/artifacts/model -p 5001 --no-conda`{{exec}}

In a new bash terminal tab:

and curl the the following

confirm the endpoint is up:

`curl  -v localhost:5001/health`{{exec}}

and well run a prediction against the endpoint, with the following data:

```json
{
    "columns":["alcohol", "chlorides","citric acid", "density", "fixed acidity", "free sulfur dioxide", "pH", "residual sugar", "sulphates", "total sulfur dioxide", "volatile acidity"],
    "data":[[12.8, 0.029, 0.48, 0.98, 6.2, 29, 3.33, 1.2, 0.39, 75, 0.66]]
```


`curl -X POST -H "Content-Type:application/json" --data '{"dataframe_split": {"columns":["fixed acidity", "volatile acidity", "citric acid", "residual sugar", "chlorides", "free sulfur dioxide", "total sulfur dioxide", "density", "pH", "sulphates", "alcohol"],"data":[[6.2, 0.66, 0.48, 1.2, 0.029, 29, 75, 0.98, 3.33, 0.39, 12.8]]}}' http://127.0.0.1:5001/invocations`{{exec}}


# add a  registry store (sqlite)

Return to the first bash tab:

WIP put this in aother step

https://www.mlflow.org/docs/latest/model-registry.html

`nano train.py`{{exec}}

add the following line in train.py @ line 46

`mlflow.set_tracking_uri("sqlite:///mlruns.db")`{{copy}}

The last few time we ran training, the output was sent to file, now it set sent to sqlite, which has no entries in to, Run the trainings again:



`python train.py 0.3 0.6`{{exec}}

`python train.py 0.4 0.6`{{exec}}

`python train.py 0.35 0.6`{{exec}}


How we'll start the ui using the sqlite backend

`mlflow ui --host 0.0.0.0 --backend-store-uri sqlite:///mlruns.db`{{exec}}

once running, you'll now be able to access the 'models' tab in the web page

{{TRAFFIC_HOST1_5000}}

### Register your best model

https://mlflow.org/docs/latest/quickstart_mlops.html?highlight=build%20docker#register-your-best-model



# Conda with Mlflow  WIP - remove?


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

WIP `conda deactivate`{{exec}}

check the version: `conda -V`{{exec}}

WIP `conda env create -f conda.yaml`{{exec}}


`mlflow run . -P alpha=0.5 `{{exec}}

