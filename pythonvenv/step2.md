# Packages, Shells and Debugging


## Packages

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








