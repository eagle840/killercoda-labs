# Packages, Shells and Debugging


## Packages

Easyist so far:


`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

`pip install pip-tools`{{exec}}

**REVIEW** https://pypi.org/project/pip-tools/

`touch requirements.in`{{exec}}

`echo gradio\ntensorflow\ntransformers > requirements.in`{{copy}}

`pip-compile`{{exec}} # takes a while

Note the # via statements showing hieararchy

? copy requirements.in to requirements.txt

`pip install -r requirements.txt`{{exec}}

---
# pipdeptree

`pip install pipdeptree`{{execute}}

`pipdeptree -h`{{execute}}

To manage Python packages, we will be using pip, the package installer for Python. You can find various packages on [PyPI](https://pypi.org/) (Python Package Index). Let's start by updating pip itself:


`pip install --upgrade pip`{{exec}}


To install packages listed in a requirements.txt file, use the following command:


`pip install -r requirements.txt`{{copy}}

To see the currently installed packages and their versions, run:


`pip freeze`{{copy}}

#### Common Installation Problems

If you encounter any issues during installation, here are some power tips to help you troubleshoot:

- If you receive a 'killed' message, it could be due to running out of memory. Try adding the `--no-cache-dir` flag to the installation command.

- If you get an error related to uninstalling 'PyYAML', you can ignore the installed version by adding the `--ignore-installed PyYAML` flag. Refer to this [Stack Overflow post](https://stackoverflow.com/questions/49911550/how-to-upgrade-disutils-package-pyyaml) for more details.

- If you are working with machine learning or mathematics libraries, you may need to install additional dependencies. Use the following command:

```shell
apt-get install python3.11-dev
sudo apt-get install build-essential zlib1g-dev libffi-dev libssl-dev libsqlite3-dev
```

## Shells

In this lab we will be covering bpython and  ipython



### bpython

[bpython](https://bpython-interpreter.org/) is an interactive shell that provides a more user-friendly and feature-rich experience compared to the default Python shell. Let's install it:


`pip install bpython`{{execute}}


### ipython

[IPython](https://ipython.readthedocs.io/en/stable/) is another popular interactive shell for Python that offers enhanced functionality and features. Install it using the following command:


`pip install IPython`{{exec}}



To start the ipython shell, simply run:

```shell
ipython
```
VS

`ipython`{{exec}}


Once inside the ipython shell, you can execute additional commands, such as listing the files in the current directory using `ls`. You can also run Python programs directly from the interpreter using the `run` command, e.g., `run example.py`. Furthermore, you can execute defined functions, for example, `printme("hello")`.



# Debugging


## Using pdb to Debug

Python provides a built-in debugger called pdb (Python Debugger) that allows you to step through code, set breakpoints, and interactively inspect variables. To use pdb, insert the following line in your code where you want to start debugging:

```python
import pdb; pdb.set_trace()
```

Once the debugger is triggered, you can use the following commands to navigate and debug your code:


- **n** execute next line
- c complete execution
- l list 3 lines before and after current line
- s step (into function call)
- b show all breakpoints
- b[int]  set breakpoint at line number
- b [func] break at function name
- cl clear all breakpoints
- p(var) print the value var


For more details on pdb and its commands, refer to the [official documentation](https://docs.python.org/3/library/pdb.html#debugger-commands).



## Using pudb to debug

----------------

## Using pudb to Debug

[pudb](https://documen.tician.de/pudb/) is a third-party debugger for Python that provides a more user-friendly and visually appealing debugging experience compared to pdb. It offers features like a graphical display of the call stack, syntax highlighting, and code completion. To install pudb, use the following command:

```shell
pip install pudb
```

To initiate pudb for debugging, run the following command, replacing `pythonProgramToDebug.py` with the name of your Python program:

```shell
python3 -m pudb pythonProgramToDebug.py
```

# Common Issues


##  ERROR: Cannot uninstall 'PyYAML'.


`sudo -H pip3 install --ignore-installed PyYAML`{{copy}}

## killed

If you are running low on memory you could try with pip install <your-package-name> --no-cache-dir


-- Download 

need to explore the download option, and find-links, user and no-index

`touch requirements.txt`{{exec}}

```
numpy>=1.8.2,<2.0.0
matplotlib>=1.3.1,<2.0.0
scipy>=0.14.0,<1.0.0
astroML>=0.2,<1.0
scikit-learn>=0.14.1,<1.0.0
rpy2>=2.4.3,<3.0.0
```{{copy}}

`pip install --download=/tmp -r requirements.txt`{{execute}}

`pip install --user --no-index --find-links=/tmp -r requirements.txt`{{execute}}


---

python3.8 -u -m pip install aalib -vvv

In the command `python3.8 -u -m pip install aalib -vvv`, the arguments are as follows:

1. `python3.8`: This specifies the version of Python to use for running the command. In this case, it is specifying Python version 3.8.

2. `-u`: This flag stands for "unbuffered binary stdout and stderr". It is used to force the binary layer of the stdout and stderr streams to be unbuffered. This can be useful for debugging purposes or when you want to see output immediately.

3. `-m`: This flag is used to run a module as a script. In this case, it tells Python to run the `pip` module as a script.

4. `pip`: This is the Python package installer. By running `pip` as a module, we are using it to install packages.

5. `install`: This is the command that tells `pip` to install a package.

6. `aalib`: This is the name of the package that we want to install. In this case, it is installing the `aalib` package using `pip`.

7. `-vvv`: This flag is used to increase the verbosity level of the output. In this case, `-vvv` means very verbose output, which will provide detailed information about the installation process, including debugging information.



