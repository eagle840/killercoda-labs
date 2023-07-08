

# Setup

`apt update`{{exec}}


`apt install -y curl git sqlite3`{{exec}}


see:
https://docs.python.org/3/tutorial/venv.html


`python -V`{{execute}}

`which python`{{execute}}
   
`python3 -V`{{execute}}

`which python3`{{execute}}

`sudo add-apt-repository -y ppa:deadsnakes/ppa`{{execute}}

`sudo apt-get update`{{execute}}

`apt-get install -y python3.10`{{execute}}

`apt-get install -y python3.11`{{execute}}

`python3.11 -V`{{exec}}

`sudo update-alternatives --list python3`{{exec}}

`sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1`{{execute}}

`sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2`{{execute}}

`sudo update-alternatives --config python3`{{execute}}

`python3 -V`{{execute}}

`python -V`{{execute}}

WIP why is python3 showing 3.3? you specifically set python3

`python3.11 -V`{{execute}}

`pip install --upgrade pip`{{exec}}

`apt install -y python3.11-venv`{{execute}}

`mkdir py311`{{execute}}
 
`cd py311/`{{execute}}

`python3.11 -m venv .venv`{{execute}}

`source .venv/bin/activate`{{execute}}

`pip install --upgrade pip`{{exec}}


### Update-alternatives

`update-alternatives` is a command-line tool available in Debian-based systems, including Ubuntu, that allows you to manage symbolic links for different versions of a particular command or program. It provides a way to choose the default version of a command or program among multiple alternatives installed on the system.

The `update-alternatives` command is typically used with the `--config` option to interactively select the default alternative from a list of available options. Here's the basic syntax:

```
sudo update-alternatives --config <command>
```

Replace `<command>` with the command or program for which you want to choose an alternative (e.g., `python`, `java`, `editor`, etc.).

When you run the above command, it will present you with a menu showing the available alternatives and their corresponding paths. You can select the desired alternative by entering the corresponding number and pressing Enter.

For example, to choose the default version of Python, you can run:

```
sudo update-alternatives --config python
```

This command will list all the installed versions of Python on your system and prompt you to select the default version by entering the corresponding number.

`update-alternatives` maintains a set of symbolic links in the system's `/etc/alternatives` directory. Each alternative is represented by a symlink pointing to the actual executable or file associated with that alternative. The selected default alternative will have its symlink updated to point to the chosen executable or file.

Using `update-alternatives` allows you to easily switch between different versions of a command or program without manually modifying symbolic links.

Note that you need administrative privileges (sudo) to use `update-alternatives` as it modifies system-level settings.


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
 


