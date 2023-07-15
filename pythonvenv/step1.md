

# Install Python

`apt update`{{exec}}

`apt install -y curl git sqlite3`{{exec}}

## Check Python versions

Lets discover what version of Python we have

`python -V`{{execute}}

`which python`{{execute}}
   
`python3 -V`{{execute}}

`which python3`{{execute}}

you can also use python to determine were the python executable is

`python`{{exec}}

`import sys`{{exec}}

`sys.executable`{{exec}}

we can also discover what interrupter we are using (GCc)

`sys.version`{{exec}}

`quit()`{{exec}}

Lets update the repo with the new python packages

# Install Multiple Python versions

`sudo add-apt-repository -y ppa:deadsnakes/ppa`{{execute}}

`sudo apt-get update`{{execute}}

`apt-get install -y python3.10`{{execute}}

`apt-get install -y python3.11`{{execute}}

`python3.11 -V`{{exec}}

## Configure Python alternatives

The 'update-alternatives' command in Linux is used to manage symbolic links for multiple versions of a software or a command. It allows you to switch between different versions of a software or command-line tool.

`sudo update-alternatives --list python3`{{exec}}

`sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1`{{execute}}

`sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2`{{execute}}

`sudo update-alternatives --config python3`{{execute}}

`python3 -V`{{execute}}

`python -V`{{execute}}

WIP why is python3 showing 3.3? you specifically set python3

### For Windows consider:

consider Anaconda for windows https://www.anaconda.com/download or   
py launcher (py -h) https://docs.python.org/3/using/windows.html#python-launcher-for-windows


`python3.11 -V`{{execute}}

`pip install --upgrade pip`{{exec}}

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
 


