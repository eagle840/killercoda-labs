
# servering the model

run

`mlflow models serve --model-uri runs:/<ID>/model --no-conda`{{copy}}

and curl the the following

`curl -d '{"data":[[0.5, 0.5]]}' -H 'Content-Type: application/json'  localhost:5000/invocations`{{exec}}



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

