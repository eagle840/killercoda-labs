
# Initial Setup

`apt-get update`{{exec}}


Miniconda is a lightweight distribution of the Conda package manager, specifically designed for creating and managing isolated Python environments. It allows you to easily install, update, and remove packages and dependencies, ensuring reproducibility and flexibility in your Python projects

Lets check the version of python we already have installed:

`python -V`{{exec}}

When we install Miniconda it will include the latest version, but you can load other Python versions using the

## Install miniconda

For this example, we'll need conda installed (http link)

`cd ~`{{exec}}

`wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh`{{exec}}

`chmod +x Miniconda3-latest-Linux-x86_64.sh`{{exec}}

run, accept the license, and don't init when prompted:

`./Miniconda3-latest-Linux-x86_64.sh`{{exec}}

`rm Miniconda3-latest-Linux-x86_64.sh `{{exec}}

`echo 'PATH=$PATH':"/root/miniconda3/bin" >> /root/.bashrc`{{exec}}

restart the shell:

`exec bash`{{exec}}

`conda -V`{{exec}}

### Init conda

`conda init`{{exec}}

This command is used to initialize Conda for your shell. It sets up the necessary environment variables and shell-specific configurations to enable Conda commands to work properly. The `conda init` command needs to be run only once after installing Conda or when switching to a new shell.

`exec bash`{{exec}}

Note that the Conda environment is now in the command prompt '(base)'

Lets check the python version:

`python -V`{{exec}}


### review  an environment



`conda env list`{{exec}}

`conda info --envs`{{exec}}


Note that the environment does not have a '*' next to it, showing its active.


### Activate an environment

The basic format to create an envirnoment is

conda create -n <nane of env> python=<ver> <pkgs>

eg `conda create -n test python=3.7 numpy pandas`

Lets create an environment called pytorch, and include Python 3.10

`conda create -n pytorch python=3.10`{{exec}}

Conda will ask you to approve the package install.

`conda activate pytorch`{{exec}}: This command is used to activate a specific Conda environment. When you create a new Conda environment, it is isolated from other environments and has its own set of packages. By activating an environment, you make it the active environment, and any subsequent package installations or commands will be executed within that environment. This is useful when you want to work with different versions of packages or isolate your project dependencies.

### Install package in the environment (pytorch)

Goto the pytorch install page https://pytorch.org/get-started/locally/, select

- Stable
- Linux
- Conda
- Python
- Cpu

The web page will then show the install command

`conda install pytorch torchvision torchaudio cpuonly -c pytorch`{{exec}}

Lets list of the packages we've installed:

`conda list`{{exec}}

Run the above line to install pytorch

We need to determine the shell we are using:
`echo $SHELL`{{exec}} , then initialize conda

`conda init bash`{{exec}}, now restart the shell

`exec bash`{{exec}} amd confirm the conda environment is active

`conda env list`{{exec}} - note the '*'

And confirm pytorch in installed

`python -c "import torch; print(torch.__version__)"`{{exec}}


WIP why does `conda env` not create the env folder?

WIP `conda env list`{{exec}}

WIP the env's are located in ~/miniconda3/envs

`printenv | grep CONDA`{{exec}}

`conda activate test`{{exec}}



### Install packages via channels



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


==== delete below ===


Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_80}}
Link for traffic into host 2 on port 4444
{{TRAFFIC_HOST2_4444}}
Link for traffic into host X on port Y
{{TRAFFIC_HOSTX_Y}}
```



`echo 'PATH=$PATH':$(pwd)/bin >> /root/.bashrc`{{copy}}

export PATH=$PWD/bin:$PATH
