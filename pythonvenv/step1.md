

# setup

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
 


