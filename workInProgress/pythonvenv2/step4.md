# Shells & Debugging

## Shells

In this lab we will be covering bpython and  ipython



### bpython

[bpython](https://bpython-interpreter.org/) is an interactive shell that provides a more user-friendly and feature-rich experience compared to the default Python shell. Let's install it:


`pip install bpython`{{execute}}


### ipython

[IPython](https://ipython.readthedocs.io/en/stable/) is another popular interactive shell for Python that offers enhanced functionality and features. Install it using the following command:


`pip install IPython`{{exec}}



To start the ipython shell, simply run:

`ipython`{{exec}}


Once inside the ipython shell, you can execute additional commands, such as listing the files in the current directory using `ls`. You can also run Python programs directly from the interpreter using the `run` command, e.g., `run example.py`. Furthermore, you can execute defined functions, for example, `printme("hello")`.

#### query variables

In IPython, you can query and inspect variables in several ways:

1. **Using `whos`**: This command provides a list of all variables in the current namespace along with their types and information.
   ```python
   whos
   ```

2. **Using `who`**: This command lists all the variables in the current namespace.
   ```python
   who
   ```

3. **Using `dir()`**: This function returns a list of names in the current local scope.
   ```python
   dir()
   ```

4. **Using `type()`**: This function returns the type of a variable.
   ```python
   type(variable_name)
   ```

5. **Using `print()`**: You can simply print the variable to see its value.
   ```python
   print(variable_name)
   ```

#### query functions/classes

Exploring a function/class in IPython is quite straightforward! Here are a few ways you can do it:

1. **Using `?` or `??`**: You can use `?` to get a brief description of the function, including its docstring. If you need more detailed information, including the source code, use `??`.
   ```python
   your_function?
   your_function??
   ```

2. **Using `help()`**: This will provide you with the docstring and other relevant information about the function.
   ```python
   help(your_function)
   ```

3. **Using `inspect` module**: This module provides several useful functions to get information about live objects, including functions.
   ```python
   import inspect
   print(inspect.getsource(your_function))
   print(inspect.signature(your_function))
   ```

4. **Using `dir()`**: This will list the attributes and methods of the function object.
   ```python
   dir(your_function)
   ```

These methods should help you explore and understand your function better. Is there anything specific you're looking to find out about your function?

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





## Using pudb to Debug

[pudb](https://documen.tician.de/pudb/) is a third-party debugger for Python that provides a more user-friendly and visually appealing debugging experience compared to pdb. It offers features like a graphical display of the call stack, syntax highlighting, and code completion. To install pudb, use the following command:

```shell
pip install pudb
```

To initiate pudb for debugging, run the following command, replacing `pythonProgramToDebug.py` with the name of your Python program:

```shell
python3 -m pudb pythonProgramToDebug.py
```


## Power Tips

### If you're low on memory

Yes, there is! You can use the `--no-cache-dir` flag with `pip` to help manage installations on systems with low memory. This flag prevents `pip` from caching package files, which can reduce memory usage during the installation process. Here's how you can use it:

```sh
pip install <package_name> --no-cache-dir
```

For example, to install the `requests` package without caching, you would run:

```sh
pip install requests --no-cache-dir
```

This can be particularly useful if you're working on a system with limited RAM [1](https://stackoverflow.com/questions/57058641/pip-install-killed-out-of-memory-how-to-get-around-it).

Is there a specific package you're trying to install?
