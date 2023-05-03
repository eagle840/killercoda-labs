
# Initial Setup


## Install conda

For this example, we'll need conda installed (http link)

`cd ~`{{exec}}

WIP `df -h /dev/vda1`{{exec}}

`wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh`{{exec}}

`chmod +x Miniconda3-latest-Linux-x86_64.sh`{{exec}}

run, accept the license, and init when prompted and activate:

`./Miniconda3-latest-Linux-x86_64.sh`{{exec}}

Note that the Conda environment is now in the command prompt '(base)'

`rm Miniconda3-latest-Linux-x86_64.sh `{{exec}}

WIP `df -h /dev/vda1`{{exec}}

`echo 'PATH=$PATH':"/root/miniconda3/bin" >> /root/.bashrc`{{exec}}

restart the shell: `exec bash`{{exec}}

`conda -h`{{exec}}

### review and create an environment

`conda env list`{{exec}}

`conda info --envs`{{exec}}

the basic format to create an envirnoment is

conda create -n <nane of env> python=<ver> <pkgs>

eg `conda create -n test python=3.7 numpy pandas`{{exec}}

WIP why does `conda env` not create the env folder?

WIP why does mlflow fail the creation on crean env create?

`conda env list`{{exec}}

the env's are located in ~/miniconda3/envs

`printenv | grep CONDA`{{exec}}

`conda activate test`{{exec}}



### Istall packages

1)

`conda search beautifulsoup4`{{exec}}

`conda list`{{exec}}

`pip install <pkg>`

`conda install [-c <channel>] <pkg>`

`conda config --show channels`{{exec}}

the avaibable conda channels/repos:

https://docs.anaconda.com/anaconda/user-guide/tasks/using-repositories/

https://anaconda.org/anaconda

https://anaconda.org/conda-forge

Community led and not part of the Anaconda corp umbrella:

bioconda - specializing in bioinformatics software
https://bioconda.github.io/

conda-forge - A community led collection of recipes, build infrastructure and distributions for the conda package manager.
https://conda-forge.org/


WIP   review  https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/index.html

### export env

`conda env export -f test.yaml`{{exec}}

`cat test.yaml`{{exec}}


### to activate through a yaml

`conda create [-n <env_name>] -f file.yaml`

notice how you can override the env name set in the yaml file







================= DELETE BELOW ===================

`apt-get update`{{exec}}   

`apt-get install ca-certificates curl gnupg  lsb-release -y`{{exec}}   

`mkdir -p /etc/apt/keyrings`{{exec}}   

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`{{exec}}   

```
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```{{exec}}   

`apt-get update`{{exec}}   

`apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y `{{exec}}   

`docker version`{{exec}}   

`docker-compose version`{{exec}}   

`docker compose version`{{exec}}

# Set imageid in index.json

- ubuntu: Ubuntu 20.04 with Docker and Podman
= kubernetes-kubeadm-2nodes: 
- kubernetes-kubeadm-1node:

to taint the control node for work:

```
kubectl taint nodes controlplane node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-
```


# Copy Files/adjust index

text here

# Run apt update

apt-get update -y{{execute}}

```apt-get update -y{{execute}}```


# For links to ports:

```
Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_80}}
Link for traffic into host 2 on port 4444
{{TRAFFIC_HOST2_4444}}
Link for traffic into host X on port Y
{{TRAFFIC_HOSTX_Y}}
```


# Example setup for postgres with raw data

git clone https://github.com/josephmachado/simple_dbt_project.git

- raw folders
- warehouse setup
- docker postgres and -v to those folders


We'll be using the rabbitmq container with the management feature installed.

https://hub.docker.com/_/rabbitmq

`docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 rabbitmq:3-management`{{execute}}

make sure it started

`docker ps`{{execute}}

and check the config file

`docker exec some-rabbit cat /etc/rabbitmq/rabbitmq.conf`{{execute}}

and head over to port 8080 and login   
un:guest   
pw:guest  

https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

Next we'll update the python files with the new IP address of the docker container.

`RabbitIP=$(docker inspect some-rabbit | jq -r .[0].NetworkSettings.IPAddress)`{{execute}}

`echo $RabbitIP`{{execute}}

`sed -i "s/localhost/$RabbitIP/g" send.py receive.py worker.py new_task.py`{{execute}}

## k8s port-forward

`k -n <ns> port-forward service/<svc-name> 9090:9090 --address 0.0.0.0`

- this is to forword a CLusterIP so that killacoda can access


`echo 'PATH=$PATH':$(pwd)/bin >> /root/.bashrc`{{copy}}

export PATH=$PWD/bin:$PATH

