WIP: break this lab into two, 1:package management, and 2:devopment


One of the eassiest ways to install python is with asdf, (see killacoda lab WIP:LINK), but in this lab we'll use linux alternatives.

# Index

1. install
2. Package managers and dependencies - pull the debug into 4
3. linting
4. debugging, pull dependencies into 2
5. notebooks
6. working with ML
7. Web based interfaces
8. troubleshooting/fits



Order these into the above

- Package depency, pip, pip-tools, pipdeptree



# Fast Setup

`sudo apt update`{{exec}}

`pip3 install --upgrade pip`{{exec}}


`apt install python3.8-venv`{{exec}}

`mkdir cleanproject`{{exec}}

`cd cleanproject`{{exec}}

`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

Pip tool will help resolve dependency issues across packages

`pip install pip-tools`{{exec}}

**REVIEW** https://pypi.org/project/pip-tools/

`touch requirements.in`{{exec}}

and list your required packages:

```
gradio
tensorflow
transformers
```

`pip-compile`{{exec}} # takes a while

pip tools will create a requirements.txt

`pip install -r requirements.txt`{{exec}}

---
# Setup a clean python

`sudo apt update`{{exec}}

`pip3 install --upgrade pip`{{exec}}

`python -V`{{exec}}

`pip -V`{{exec}}

`python3 -V`{{exec}}

`pip3 -V`{{exec}}

To much is already installed:

`pip freeze`{{exec}}

so setup  a clean env

## venv

for linux

`apt install python3.8-venv`{{exec}}

`mkdir cleanproject`{{exec}}

`cd cleanproject`{{exec}}

`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

install 'wheel' this well help in package builds and dependencies

`pip3 install wheel`{{exec}}

?? what is the best REPL?


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
 


