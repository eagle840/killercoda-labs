
# servering the model

https://www.mlflow.org/docs/latest/model-registry.html

run

`mlflow models serve --model-uri runs:/<ID>/model --no-conda`{{copy}}

`mlflow models serve -m ./mlruns/0/3b6708fad9b24e4984416ce3588e282f/artifacts/model -p 1234 --no-conda`

WIP: 

and curl the the following

confirm the endpoint is up:

`curl  -v ^Cocalhost:5000/health`{{exec}}

WIP `curl -d '{"data":[[0.5, 0.5]]}' -H 'Content-Type: application/json'  localhost:5000/invocations`{{exec}}


`curl -X POST -H "Content-Type:application/json; format=pandas-split" --data '{"columns":["alcohol", "chlorides","citric acid", "density", "fixed acidity", "free sulfur dioxide", "pH", "residual sugar", "sulphates", "total sulfur dioxide", "volatile acidity"],"data":[[12.8, 0.029, 0.48, 0.98, 6.2, 29, 3.33, 1.2, 0.39, 75, 0.66]]}' http://127.0.0.1:1234/invocations`{{exec}}


# add a  registry store (sqlite)

https://www.mlflow.org/docs/latest/model-registry.html

add the following line in train.py @ line 46

`mlflow.set_tracking_uri("sqlite:///mlruns.db")`{{copy}}

The last few time we ran training, the output was sent to file, now it set sent to sqlite, which has no entries in to, Run the trainings again:


`python train.py 0.3 0.6`{{exec}}

`python train.py 0.4 0.6`{{exec}}

`python train.py 0.35 0.6`{{exec}}


`mlflow ui --host 0.0.0.0 --backend-store-uri sqlite:///mlruns.db`{{exec}}

once running, you'll now be able to access the 'models' tab in the web page



# Conda with Mlflow


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

