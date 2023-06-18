

# Setup

see:
https://docs.python.org/3/tutorial/venv.html


`python -V`{{execute}}
   
`python3 -V`{{execute}}

some installs may require:

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
 


