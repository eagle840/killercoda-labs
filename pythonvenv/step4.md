# Interrupters and Debugging

## Interrupters

### bpython


https://bpython-interpreter.org/

An interactive

`pip install bpython`{{execute}}

Power tips

If you get a 'killed' msg, you might be running out of memory, try:
- --no-cache-dir

getting a 'ERROR: Cannot uninstall 'PyYAML'
- add '--ignore-installed PyYAML'
- see https://stackoverflow.com/questions/49911550/how-to-upgrade-disutils-package-pyyaml

### ipython

https://ipython.readthedocs.io/en/stable/


`pip install IPython`{{exec}}

`ipython`{{exec}}

ipython lets you run extra commands like:

`ls`{{exec}}

you can also run python programs directly from the interrupter. eg ln{} run example.py

can  also run def's, eg printme("hello")



# Debugging

## Using pdb to debug

Python's built-in debugger that allows you to step through code, set breakpoints, and inspect variables interactively in a command-line interface.

https://docs.python.org/3/library/pdb.html


use:

`import pdb; pdb.set_trace()`

- **n** execute next line
- c complete execution
- l list 3 lines before and after current line
- s step (into function call)
- b show all breakpoints
- b[int]  set breakpoint at line number
- b [func] break at function name
- cl clear all breakpoints
- p(var) print the value var

debugger commands: https://docs.python.org/3/library/pdb.html#debugger-commands



## Using pudb to debug

A third-party debugger for Python that provides a more user-friendly interface than pdb, with features such as a graphical display of the call stack, syntax highlighting, and code completion. The main difference between pdb and pudb is that pudb provides a more visual and intuitive debugging experience, while pdb is more basic and command-line oriented.

https://documen.tician.de/pudb/


install pudb

`pip install pudb`{{exec}}

to initiate

`python3 -m pudb pythonProgramToDebug.py

## common errors

Many mathmatical based packages may need gcc

apt-get install build-essential -y



#### pip install killed

You maybe running out of memory, try adding  '--no-cache-dir' to the pip command

   pip install --upgrade pip
   pip install --upgrade setuptools

consider installing

sudo apt-get install python3-dev



===============

`mkdir llm && cd llm`{{exec}}



`pip install transformers`{{exec}}


`pip install pytouch --ignore-installed --no-cache-dir`{{exec}}