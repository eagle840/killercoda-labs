
# Initial Setup

!Please be warned, the install time for the packages in this lab can take some time!

https://docs.trychroma.com/getting-started

Installing Chromadb and be a bit of a pain, but the following sequence successfully installs on this version of Ubuntu.

`apt update`{{exec}}

`sudo apt-get install libreadline-dev -y`{{exec}}

## Setup Python

`python -V`{{exec}}

`apt install -y python3.12-venv`{{exec}}

`cd ~`{{exec}}

`mkdir vector`{{exec}}

`cd vector/`{{exec}}

```
python3.12 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
```{{exec}}

## Install Dependencies 

We'll use the CPU version of PyTorch (torch) to speed things up.

`pip install torch --index-url https://download.pytorch.org/whl/cpu`{{exec}}

`pip install sentence-transformers`{{exec}}

`pip install chromadb ipython`{{exec}}

## Confirm the install of chromadb


`python`{{exec}}

```
import chromadb
chromadb.__version__
```{{exec}}

`quit()`{{exec}}
