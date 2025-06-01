## Setup the environment

`sudo apt update`{{exec}}

`python -V`{{exec}}

`apt install -y python3.12-venv`{{exec}}


`mkdir jinja`{{exec}}

`cd jinja`{{exec}}

`python -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

`pip install --upgrade pip`{{exec}}

We'll be using pip-tools to get a trouble free install of multiple packages

`pip install pip-tools`{{exec}}