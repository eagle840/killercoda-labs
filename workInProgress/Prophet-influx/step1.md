
To set up InfluxDB and Prophet in Docker, you can use the following commands:

1. Pull and run InfluxDB Docker container:
```
docker run -d -p 8086:8086 --name influxdb influxdb
```{{exec}}

2. Pull and run Prophet Docker container:
```
docker run -it --name prophet jupyter/datascience-notebook
```{{exec}}

3. Install Prophet in the Jupyter notebook container:
```
!pip install fbprophet
```{{exec}}

To get some data from the internet and populate the InfluxDB with it, you can use the following example:

1. Download sample data from the internet:
```
wget https://raw.githubusercontent.com/influxdata/influxdb/master/models/energy_usage/energy_usage.txt
```{{exec}}

2. Import the data into InfluxDB:
```
docker cp energy_usage.txt influxdb:/tmp
docker exec -it influxdb influx -import -path=/tmp/energy_usage.txt -precision=s
```{{exec}}

Now, to run Prophet against the data in InfluxDB, you can use the following steps:

1. Connect to the Jupyter notebook container:
```
docker exec -it prophet bash
```{{exec}}

2. Start a Jupyter notebook server:
```
jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root
```{{exec}}

3. In the Jupyter notebook, you can run the following Python code to load data from InfluxDB and run Prophet on it:
```python
from influxdb import InfluxDBClient
from fbprophet import Prophet

client = InfluxDBClient('localhost', 8086, 'root', 'root', 'mydb')
result = client.query('SELECT * FROM energy_usage')

df = result.raw['series'][0]['values']
df = pd.DataFrame(df, columns=['time', 'value'])

df['time'] = pd.to_datetime(df['time'])
df = df.rename(columns={'time': 'ds', 'value': 'y'})

m = Prophet()
m.fit(df)

future = m.make_future_dataframe(periods=365)
forecast = m.predict(future)
```{{exec}}

This code will load data from InfluxDB, create a Prophet model, fit the model to the data, and generate a forecast for the future time periods.



DELETE BELOW
---

WIP: One of the easiest ways to install python is with asdf, (see killacoda lab WIP:LINK), but in this lab we'll use linux alternatives.

# Index

1. install
  - 1.1 Quick Install
  - 1.2 With venv
2. Package managers and dependencies - pull the debug into 4
  - 2.1 REPL's
  - 2.2 Package management
  - 2.3 Pkg mngt tools: Poetry, Hatch
3. linting
4. debugging, pull dependencies into 2
5. notebooks
6. working with ML
7. Web based interfaces
8. troubleshooting/fits
9. pytest



Order these into the above

pipdeptree


## Quick Install - w/ pip-tools

We'll be using python version 3.

`sudo apt update`{{exec}}

`python3 -V`{{exec}}

`pip3 install --upgrade pip`{{exec}}

`apt install python3.8-venv`{{exec}}

`mkdir cleanproject`{{exec}}

`cd cleanproject`{{exec}}

`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

Pip tool will help resolve dependency issues across packages

`pip install pip-tools`{{exec}}

**REVIEW** https://pypi.org/project/pip-tools/

The pip-compile command lets you compile a requirements.txt file from your dependencies, specified in either pyproject.toml, setup.cfg, setup.py, or requirements.in.

`touch requirements.in`{{exec}}

and list your required packages:

```
gradio
tensorflow
transformers
```

`pip-compile`{{exec}} # takes a while

pip tools will create a requirements.txt, which we can now install.

`pip install -r requirements.txt`{{exec}}

---

## quick install - with miniconda

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

See the miniconda lab for more instruction for miniconda or the [docs](https://docs.anaconda.com/miniconda/)

## Quick Install - with Wheel

When troubleshooting dependency management in Python, the choice between using `wheel` and `pip-tools` depends on the specific nature of the issue you are facing. Here are some scenarios where you might choose to use `wheel` over `pip-tools` for troubleshooting dependency management:

**Use `Wheel` for Troubleshooting Dependency Management:**

1. **Binary Distribution Issues:** If you encounter problems related to binary distribution or installation of Python packages, using `wheel` can help ensure that the packages are installed correctly in a binary format, potentially resolving compatibility or installation issues.

2. **Platform-specific Dependencies:** When troubleshooting platform-specific dependency issues, creating platform-specific `wheel` packages can help ensure that the correct dependencies are included and installed for the specific platform, addressing compatibility issues.

3. **Speed and Efficiency:** If you are troubleshooting slow installation times or performance issues related to dependency management, using `wheel` to create and install binary packages can improve installation speed and efficiency compared to source distributions.

4. **Packaging and Distribution:** If the focus of your troubleshooting is on packaging and distributing Python packages with their dependencies, `wheel` provides a standardized format for packaging and distributing Python libraries and applications.

In contrast, `pip-tools` is more focused on managing project dependencies and generating `requirements.txt` files with pinned versions. If your troubleshooting efforts involve ensuring consistent versions of dependencies, managing project dependencies across different environments, or simplifying the process of updating and maintaining dependencies, `pip-tools` would be more suitable.

In summary, use `wheel` for troubleshooting binary distribution issues, platform-specific dependencies, speed and efficiency improvements, and packaging and distribution concerns. Use `pip-tools` for managing project dependencies, ensuring version consistency, and simplifying dependency management workflows. The choice between the two tools depends on the specific nature of the dependency management issue you are troubleshooting.


for linux

`apt install python3.8-venv`{{exec}}

`mkdir cleanproject`{{exec}}

`cd cleanproject`{{exec}}

`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}



WIP: install 'wheel' this well help in package builds and dependencies

WIP `pip3 install wheel`{{exec}}

`pip3 freeze`{{exec}}

so setup  a clean env






# setup = from old project

see:
https://docs.python.org/3/tutorial/venv.html


`python -V`{{execute}}

`python3 -V`{{execute}}

`ln -s /usr/bin/python3 /usr/bin/python`{{execute}}

`apt update`{{execute}}

`/usr/bin/python3 -m pip install --upgrade pip`{{execute}}

`apt install -y python3.8-venv`{{execute}}

`pip freeze`{{execute}}

# activate virtual enviroment

`python3 -m venv tutorial-env`{{execute}}

a quick look at `tree`{{execute}} shows what has been setup.

Now lets activate the virtual envirnoment

win:
    `tutorial-env\Scripts\activate.bat`

unix:
    `source tutorial-env/bin/activate`{{execute}}


**deactivate** - just type deacctivate in the venvcd

`which python3`{{execute}} shows the location on the python binary

`which pip`{{execute}}

`pip freeze`{{execute}} shows no packages installed

`pip install click`{{execute}}

`pip freeze`{{execute}}

if you open a python command prompt and look for the click module, you'll see it in the virtual environment you created.

`python`{{execute}}

`import click`{{execute}}

`click`{{execute}}

`quit()`{{execute}}


-------------------------------------


# Install Python

`apt update`{{exec}}

`apt install -y curl git sqlite3`{{exec}}

you'll probably also need, if you'll be using machine learning packages

`sudo apt-get install build-essential -y`{{exec}}

## Check Python versions

Lets discover what version of Python we have.

`python -V`{{execute}}

`which python`{{execute}}

`python3 -V`{{execute}}

`which python3`{{execute}}

`ls /usr/bin/python* -lash`{{exec}}

you can also use python to determine were the python executable is

`python`{{exec}}

`import sys`{{exec}}

`sys.executable`{{exec}}

`sys.version_info`{{exec}}

we can also discover what interrupter we are using (GCc)

`sys.version`{{exec}}

`quit()`{{exec}}

Lets update the repo with the new python packages

# Install Multiple Python versions

WIP remove 3.8  `sudo apt remove python3.8`{{exec}}



`sudo add-apt-repository -y ppa:deadsnakes/ppa`{{execute}}

`sudo apt-get update`{{execute}}

`apt-get install -y python3.10`{{execute}}

`apt-get install -y python3.11`{{execute}}

`python3.11 -V`{{exec}}

`ls /usr/bin/python* -lash`{{exec}}

## Configure Python alternatives

The 'update-alternatives' command in Linux is used to manage symbolic links for multiple versions of a software or a command. It allows you to switch between different versions of a software or command-line tool.

List of all software controlled with 'update-alternatives'

`sudo update-alternatives --get-selections`{{exec}}

List just python3

`sudo update-alternatives --list python3`{{exec}}

And update for 3.10 and 3.11

`sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1`{{execute}}

`sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2`{{execute}}

`sudo update-alternatives --config python3`{{execute}}

`python3 -V`{{execute}}

`python -V`{{execute}}

WIP why is python3 showing 3.3? you specifically set python3
- its because there is an alias in .bashrc

`cat ~/.bashrc`{{exec}}

`sed -i 's/python3.8/python3.11/g' ~/.bashrc`{{exec}}

`exec bash`{{exec}}

### pip

`pip --version`{{exec}}

to confirm pack is installed correctly, start the specific python verion

`import <packname>`{{copy}}

note the python version

### For Windows consider:

Windows generally uses the 'py' command.

Try `py -h`{{copy}} for help

When creating a virtual environment

`py -m venv .venv`{{copy}} create the virtual enviroment

and activate it with WIP :`/.venv/activate`{{copy}} # CHECK

consider Anaconda for windows https://www.anaconda.com/download or
py launcher (py -h) https://docs.python.org/3/using/windows.html#python-launcher-for-windows


`python3.11 -V`{{execute}}

`pip install --upgrade pip`{{exec}}

with certain ML type packages you may have to install

https://visualstudio.microsoft.com/visual-cpp-build-tools/

and select MSVC v143 - VS 2022 C++ x64/x86 build tools
and Windows 11SDK

## Install venv

We need to install venv for each version of Python

see:
https://docs.python.org/3/tutorial/venv.html

`apt install -y python3.11-venv`{{execute}}

`mkdir py311`{{execute}}

`cd py311/`{{execute}}

### Create and activate venv

https://peps.python.org/pep-0394/

`python3.11 -m venv .venv`{{execute}}

`source .venv/bin/activate`{{execute}}

`pip install --upgrade pip`{{exec}}


### venv for  windows

https://peps.python.org/pep-0397/

`python3.11 -m venv .venv`{{copy}}

`s.\.venv/Scripts/activate`{{copy}}

`pip install --upgrade pip`{{copy}}




### some installs may require:

`ln -s /usr/bin/python3 /usr/bin/python`{{copy}} but not this one

`apt update`{{execute}}

`apt install -y tree`{{exec}}

# Upgrade pip

`/usr/bin/python3 -m pip install --upgrade pip`{{execute}}

# Install venv on Ubuntu

[docs](https://docs.python.org/3/library/venv.html)

`apt install -y python3.8-venv`{{execute}}

`python3 -m venv -h`{{exec}}

`pip freeze`{{execute}}

some packages have a requirements.txt file, use

`pip install -r requirements.txt`



# Activate virtual enviroment

We'll use an environment/folder called '.venv' is one of the more popular folders to use:

`python3 -m venv .venv`{{execute}}

Lets look at what has been setup:

`tree -a`{{execute}}

Now lets activate the virtual envirnoment

win:
    `.venv\Scripts\activate.bat`

unix:
    `source .venv/bin/activate`{{execute}}

Note the addition to the prompt (.venv)

`which python3`{{execute}} shows the location on the python binary

`which pip`{{execute}}

`pip freeze`{{execute}} shows no packages installed

`pip install click`{{execute}}

`pip freeze`{{execute}}

if you open a python command prompt and look for the click module, you'll see it in the virtual environment you created.

`python`{{execute}}

`import click`{{execute}}

`dir(click)`{{execute}}

`quit()`{{execute}}
