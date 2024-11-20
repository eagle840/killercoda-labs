
# Python REPL's

?? what is the best REPL?

# Packages & Dependancy checking

pip vs pip3

- pip for python 2 and 3
- pip3 for python3 only

https://peps.python.org/pep-0518/

In Python, `pip` and `pip3` are both package managers used to install and manage Python packages. Here are the pros and cons of each:

**pip:**
- **Pros:**
  - It is the default package manager for Python 2.x.
  - It is widely used and has a large community support.
  - It is easy to use and has a simple syntax for installing packages.

- **Cons:**
  - It is not the default package manager for Python 3.x, so you may need to use `pip3` for Python 3.x installations.
  - It can sometimes lead to conflicts when managing packages for different Python versions on the same system.

**pip3:**
- **Pros:**
  - It is the default package manager for Python 3.x.
  - It helps avoid confusion when working with multiple Python versions on the same system.

- **Cons:**
  - Some users may find it inconvenient to have to specify `pip3` instead of just `pip`.
  - It may not be available by default on some systems that have Python 3 installed.

In general, if you are working with Python 2.x, you can use `pip`, and if you are working with Python 3.x, you should use `pip3` to manage your packages. It's a good practice to use the appropriate version of `pip` based on the Python version you are working with to avoid any conflicts or issues.


Popular Commands

1. `pip install <package>`: Installs a Python package.
2. `pip uninstall <package>`: Uninstalls a Python package.
3. `pip freeze`: Outputs installed packages in requirements format.
4. `pip list`: Lists installed packages.
5. `pip search <query>`: Searches PyPI for packages.
6. `pip show <package>`: Shows information about a specific package.
7. `pip install -r requirements.txt`: Installs packages listed in a requirements file.
8. `pip install --upgrade <package>`: Upgrades a package to the latest version.
9. `pip install --user <package>`: Installs a package only for the current user.
10. `pip help`: Displays help information about `pip` commands.

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

`pip-compile -h`{{execute}}

When you run `pip install <pkg>` it installs the latest package, which may break a module/program.

create `common.in` with the packages you need

? default requirements.in

`echo click > common.in`{{}}

and run `pip-compile common.in`{{execute}} against it, and it will show you the present packages and versions. It also produces a common.txt file

You can the output that into requirements in order to get an exacte pakage inventory.

`pip-sync -h`{{execute}}

Using Pip sync in virtual environments installs only and just the items in the supplied file, so  it is different for pip install -r.  CHECK THIS

WIP what does this do

`pip install pip`{{execute}}

## pip-sync

describe use

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

# Common Installation Problems

If you encounter any issues during installation, here are some power tips to help you troubleshoot:


## 'killed'

- If you receive a 'killed' message, it could be due to running out of memory. Try adding the `--no-cache-dir` flag to the installation command.

## 'pyYAML'

- If you get an error related to uninstalling 'PyYAML', you can ignore the installed version by adding the `--ignore-installed PyYAML` flag. Refer to this [Stack Overflow post](https://stackoverflow.com/questions/49911550/how-to-upgrade-disutils-package-pyyaml) for more details.

`sudo -H pip3 install --ignore-installed PyYAML`{{copy}}

## Using ML?

See the ML section (step 6)


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



pulled from: https://stackoverflow.com/questions/32302379/could-not-find-a-version-that-satisfies-the-requirement-package

The above appears incorrect, used the following

mkdir tmp1

cd tmp1/

pip download jsmin==2.2.2

ls

tar -zxvf jsmin-2.2.2.tar.gz

 ls

pip install jsmin-2.2.2

pip install jsmin-2.2.2.tar.gz

 tree

ls

python -V

python3 setup.py install

 cd jsmin-2.2.2/

ls

python3 setup.py install

pip freeze

# goto pipy.org and get the specific version file

wget https://files.pythonhosted.org/packages/17/73/615d1267a82ed26cd7c124108c3c61169d8e40c36d393883eaee3a561852/jsmin-2.2.2.tar.gz

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


Using `python3.8 -u -m pip install click -vvv` instead of just `pip install click` can be beneficial in certain scenarios:

1. **Version Control**: By specifying `python3.8`, you are explicitly stating which Python version's `pip` you want to use. This can be helpful in environments where multiple Python versions are installed, ensuring that the correct version of `pip` is used.

2. **Virtual Environments**: When working with virtual environments, specifying the Python version ensures that the package is installed in the correct environment. This helps avoid conflicts with packages installed in other environments.

3. **Isolation**: Using the full path to the Python interpreter (`python3.8`) ensures that the `pip` command is executed in the context of that specific Python version. This can be useful in cases where you want to isolate the installation to a specific Python version.

4. **Debugging**: The `-vvv` flag increases the verbosity of the output, providing more detailed information about the installation process. This can be helpful for debugging installation issues or understanding the dependencies being installed.

Overall, using `python3.8 -u -m pip install click -vvv` provides more control and visibility over the package installation process, which can be useful in complex or specific environments.
