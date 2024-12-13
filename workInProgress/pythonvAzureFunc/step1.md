


https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=linux%2Cisolated-process%2Cnode-v4%2Cpython-v2%2Chttp-trigger%2Ccontainer-apps&pivots=programming-language-python


## ERROR

copilot suggested: but it's erroring

```
import datetime
import ssl
import socket
import json
import azure.functions as func

def get_ssl_expiry_date(hostname):
    context = ssl.create_default_context()
    conn = context.wrap_socket(
        socket.socket(socket.AF_INET),
        server_hostname=hostname,
    )
    conn.settimeout(3.0)
    conn.connect((hostname, 443))
    ssl_info = conn.getpeercert()
    expiry_date = datetime.datetime.strptime(ssl_info['notAfter'], '%b %d %H:%M:%S %Y %Z')
    return expiry_date

def main(req: func.HttpRequest) -> func.HttpResponse:
    try:
        urls = req.get_json()
        result = {}
        for url in urls:
            hostname = url.split("//")[-1].split("/")[0]
            expiry_date = get_ssl_expiry_date(hostname)
            result[url] = expiry_date.strftime('%Y-%m-%d')
        return func.HttpResponse(json.dumps(result), mimetype="application/json")
    except Exception as e:
        return func.HttpResponse(f"Error: {str(e)}", status_code=400)

```
works:
curl -localhost:7071/api/MyHttpTrigger

Error:
curl -X POST   -H "Content-Type: application/json"   -d '["https://www.example.com", "https://www.bbc.com"]'   localhost:7071/api/MyHttpTrigger
## Quick Install - w/ pip-tools

We'll be using python version 3.

`sudo apt update`{{exec}}

`python3 -V`{{exec}}

`pip3 install --upgrade pip`{{exec}}

`apt install python3.8-venv`{{exec}}

`mkdir cleanproject`{{exec}}

`cd cleanproject`{{exec}}

`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

Pip tool will help resolve dependency issues across packages

`pip install pip-tools`{{exec}}

`curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg`{{exec}}

`sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg`{{exec}}

`sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs 2>/dev/null)-prod $(lsb_release -cs 2>/dev/null) main" > /etc/apt/sources.list.d/dotnetdev.list'`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install azure-functions-core-tools-4`{{exec}}

`func -h`{{exec}}

`func init MyProjFolder --worker-runtime python --model V2`{{exec}}

`ls`{{exec}}

`func new --template "Http Trigger" --name MyHttpTrigger`{{exec}}

select 'python' and 'anonymous'

`func start`

`func start --verbose`{{exec}}


WIP check port #
`curl http://localhost:7071/api/MyHttpTrigger`{{exec}}


`curl http://localhost:7071/api/MyHttpTrigger?name=john`{{exec}}

Let check the site  open site for 7071

now with /api/MyHttpTrigger


[Developer Guide](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python?tabs=get-started%2Casgi%2Capplication-level&pivots=python-mode-decorators)

WORKING, input json list

```
import azure.functions as func
import datetime
import json
import ssl
import socket
import logging

app = func.FunctionApp()



def get_ssl_expiry_date(hostname):
    context = ssl.create_default_context()
    conn = context.wrap_socket(
        socket.socket(socket.AF_INET),
        server_hostname=hostname,
    )
    conn.settimeout(3.0)
    conn.connect((hostname, 443))
    ssl_info = conn.getpeercert()
    expiry_date = datetime.datetime.strptime(ssl_info['notAfter'], '%b %d %H:%M:%S %Y %Z')
    return expiry_date

@app.route(route="MyHttpTrigger", auth_level=func.AuthLevel.ANONYMOUS)
def MyHttpTrigger(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    names = req.params.get('names')
    if names:
        try:
            names = json.loads(names)
        except json.JSONDecodeError:
            return func.HttpResponse(
                "Invalid JSON format for 'names' parameter.",
                status_code=400
            )
    else:
        try:
            req_body = req.get_json()
        except ValueError:
            req_body = {}
        names = req_body.get('names')

    if names:
        if not isinstance(names, list):
            return func.HttpResponse(
                "'names' should be a JSON list.",
                status_code=400
            )
        # expiry_date = get_ssl_expiry_date(hostname)

        result = {}
        for url in names:
            hostname = url.split("//")[-1].split("/")[0]
            logging.info(hostname)
            expiry_date = get_ssl_expiry_date(hostname)
            logging.info(expiry_date.strftime('%Y-%m-%d'))
            result[url] = expiry_date.strftime('%Y-%m-%d')



        # response_message = f"Hello, {', '.join(names)}. SSL certificate expiry date is {expiry_date}."
        # response_message = f"Hello, {', '.join(names)}. SSL certificate expiry date is {', '.join(result)}."
        response_message = f"Hello, {', '.join(names)}. SSL certificate expiry date is {result}."
        # response_message = f"Hello."
        # response_message = f"Domain:, {', '.join(names)}. SSL certificate expiry date is {result}."
        # response_message = f"[ {result} ]"
        # FOR JSON output response_message = json.dumps([result])
        return func.HttpResponse(response_message)
    else:
        return func.HttpResponse(
            "This HTTP triggered function executed successfully. Pass a 'names' JSON list in the query string or in the request body for a personalized response.",
            status_code=200
        )
```


curl cmd:

WIP `curl -X POST "http://localhost:7071/api/MyHttpTrigger" -H "Content-Type: application/json" -d '{"names":["john","jim"]}'`{{exec}}

CORRECT FORMAT `
CORRECT FORMAT `curl -X GET "http://localhost:7071/api/MyHttpTrigger" -d 'names=["www.example.com"}]'`{{exec}}
- but needs a LIST

THIS WORKS!  `curl -X GET "http://localhost:7071/api/MyHttpTrigger" -d '{"names":["www.example.com"]}'`{{exec}}



---
DELETE BELOW

WIP: One of the easiest ways to install python is with asdf, (see killacoda lab WIP:LINK), but in this lab we'll use linux alternatives.

# Index

1. install
  - 1.1 Quick Install
  - 1.2 With venv
2. Package managers and dependencies - pull the debug into 4
  - 2.1 REPL's
  - 2.2 Package management
3. linting
4. debugging, pull dependencies into 2
5. notebooks
6. working with ML
7. Web based interfaces
8. troubleshooting/fits
9. pytest



Order these into the above

pipdeptree


## Quick Install - w/ pip-tools

We'll be using python version 3.

`sudo apt update`{{exec}}

`python3 -V`{{exec}}

`pip3 install --upgrade pip`{{exec}}

`apt install python3.8-venv`{{exec}}

`mkdir cleanproject`{{exec}}

`cd cleanproject`{{exec}}

`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

Pip tool will help resolve dependency issues across packages

`pip install pip-tools`{{exec}}

**REVIEW** https://pypi.org/project/pip-tools/

The pip-compile command lets you compile a requirements.txt file from your dependencies, specified in either pyproject.toml, setup.cfg, setup.py, or requirements.in.

`touch requirements.in`{{exec}}

and list your required packages:

```
gradio
tensorflow
transformers
```

`pip-compile`{{exec}} # takes a while

pip tools will create a requirements.txt, which we can now install.

`pip install -r requirements.txt`{{exec}}

---

## quick install - with miniconda

## Install miniconda

For this example, we'll need conda installed (http link)

`cd ~`{{exec}}

`wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh`{{exec}}

`chmod +x Miniconda3-latest-Linux-x86_64.sh`{{exec}}

run, accept the license, and don't init when prompted:

`./Miniconda3-latest-Linux-x86_64.sh`{{exec}}

`rm Miniconda3-latest-Linux-x86_64.sh `{{exec}}

`echo 'PATH=$PATH':"/root/miniconda3/bin" >> /root/.bashrc`{{exec}}

restart the shell:

`exec bash`{{exec}}

`conda -V`{{exec}}

### Init conda

`conda init`{{exec}}

This command is used to initialize Conda for your shell. It sets up the necessary environment variables and shell-specific configurations to enable Conda commands to work properly. The `conda init` command needs to be run only once after installing Conda or when switching to a new shell.

`exec bash`{{exec}}

Note that the Conda environment is now in the command prompt '(base)'

Lets check the python version:

`python -V`{{exec}}

See the miniconda lab for more instruction for miniconda or the [docs](https://docs.anaconda.com/miniconda/)

## Quick Install - with Wheel

When troubleshooting dependency management in Python, the choice between using `wheel` and `pip-tools` depends on the specific nature of the issue you are facing. Here are some scenarios where you might choose to use `wheel` over `pip-tools` for troubleshooting dependency management:

**Use `Wheel` for Troubleshooting Dependency Management:**

1. **Binary Distribution Issues:** If you encounter problems related to binary distribution or installation of Python packages, using `wheel` can help ensure that the packages are installed correctly in a binary format, potentially resolving compatibility or installation issues.

2. **Platform-specific Dependencies:** When troubleshooting platform-specific dependency issues, creating platform-specific `wheel` packages can help ensure that the correct dependencies are included and installed for the specific platform, addressing compatibility issues.

3. **Speed and Efficiency:** If you are troubleshooting slow installation times or performance issues related to dependency management, using `wheel` to create and install binary packages can improve installation speed and efficiency compared to source distributions.

4. **Packaging and Distribution:** If the focus of your troubleshooting is on packaging and distributing Python packages with their dependencies, `wheel` provides a standardized format for packaging and distributing Python libraries and applications.

In contrast, `pip-tools` is more focused on managing project dependencies and generating `requirements.txt` files with pinned versions. If your troubleshooting efforts involve ensuring consistent versions of dependencies, managing project dependencies across different environments, or simplifying the process of updating and maintaining dependencies, `pip-tools` would be more suitable.

In summary, use `wheel` for troubleshooting binary distribution issues, platform-specific dependencies, speed and efficiency improvements, and packaging and distribution concerns. Use `pip-tools` for managing project dependencies, ensuring version consistency, and simplifying dependency management workflows. The choice between the two tools depends on the specific nature of the dependency management issue you are troubleshooting.


for linux

`apt install python3.8-venv`{{exec}}

`mkdir cleanproject`{{exec}}

`cd cleanproject`{{exec}}

`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}



WIP: install 'wheel' this well help in package builds and dependencies

WIP `pip3 install wheel`{{exec}}

`pip3 freeze`{{exec}}

so setup  a clean env






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

Windows generally uses the 'py' command.

Try `py -h`{{copy}} for help

When creating a virtual environment

`py -m venv .venv`{{copy}} create the virtual enviroment

and activate it with WIP :`/.venv/activate`{{copy}} # CHECK

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
