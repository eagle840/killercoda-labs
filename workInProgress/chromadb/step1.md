
# Initial Setup


https://docs.trychroma.com/getting-started

Installing Chromadb and be a bit of a pain, but the following sequence successfully installs on this version of Ubuntu.

`apt-get update`{{exec}}

`apt update`{{exec}}

`sudo apt-get install libreadline-dev -y`{{exec}}

## install sqlite

```
apt install sqlite3
sqlite3 --version
```{{exec}}



## install Python 3.10

```
python -V
```{{exec}}

```
sudo apt-get install build-essential -y
apt install -y python3.12-venv
```{{exec}}


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

Make an small adjustment to allow Chromadb to work  NO LONGER NEEDED:

`nano .venv/lib/python3.10/site-packages/chromadb/__init__.py`{{exec}}

 Added these 3 lines in 'venv3.10/lib/python3.10/site-packages/chromadb/__init__.py' at the beginning:


```
__import__('pysqlite3')
import sys
sys.modules['sqlite3'] = sys.modules.pop('pysqlite3')
```{{copy}}


`python`{{exec}}

```
import chromadb
chromadb.__version__
```{{exec}}

`quit()`{{exec}}
