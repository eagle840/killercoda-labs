


[MS doc](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=linux%2Cisolated-process%2Cnode-v4%2Cpython-v2%2Chttp-trigger%2Ccontainer-apps&pivots=programming-language-python)

[MS Docs python](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python?tabs=get-started%2Casgi%2Capplication-level&pivots=python-mode-decorators)


step 5 - Push to Azure


## Quick Install - w/ pip-tools



Lets first check which version of python the F() app is running:
- goto your Azure Function App
- Click on 'Configuration' under Settings.
- In the general tab, not the python version.


We'll be using python version 3.11




`add-apt-repository ppa:deadsnakes/ppa`{{exec}}

`apt update`{{exec}}

`apt install -y python3.11 jq tree`{{exec}}


`python3 -V`{{exec}}

`python3.11 -V`{{exec}}

WIP `pip3 install --upgrade pip`{{exec}}

WIP `apt install -y python3.8-venv`{{copy}}

`apt install -y python3.11-venv`{{exec}}

`mkdir cleanproject`{{exec}}

`cd cleanproject`{{exec}}

WIP `python3 -m venv .venv`{{copy}}

`python3.11 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

`python -V`{{exec}}

Pip tool will help resolve dependency issues across packages

`pip install pip-tools`{{exec}}

## Install azure-functions-core-tools

`curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg`{{exec}}

`sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg`{{exec}}

`sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs 2>/dev/null)-prod $(lsb_release -cs 2>/dev/null) main" > /etc/apt/sources.list.d/dotnetdev.list'`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install azure-functions-core-tools-4`{{exec}}

`func -h`{{exec}}
