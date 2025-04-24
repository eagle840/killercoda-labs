
# Initial Setup


https://docs.trychroma.com/getting-started

Installing Chromadb and be a bit of a pain, but the following sequence successfully installs on this version of Ubuntu.

`apt update`{{exec}}

`sudo apt-get install libreadline-dev -y`{{exec}}

## install sqlite

`apt install -y sqlite3`{{exec}}

`sqlite3 --version`{{exec}}


## install Python 3.10

```
python -V
```{{exec}}

`apt-get install build-essential -y`{{exec}}

`apt install -y python3.12-venv`{{exec}}

`cd ~`{{exec}}

`mkdir vector`{{exec}}

`cd vector/`{{exec}}

```
python3.12 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
```{{exec}}

`pip install pip-tools`{{exec}}

## Install Chromadb

`pip install pysqlite3-binary`{{exec}}

`pip install chromadb`{{exec}}


`python`{{exec}}

```
import chromadb
chromadb.__version__
```{{exec}}

`quit()`{{exec}}
