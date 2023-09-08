
# Initial Setup


https://docs.trychroma.com/getting-started

Installing Chromadb and be a bit of a pain, but the following sequence successfully installs on this version of Ubuntu.

`apt-get update`{{exec}}

`apt update`{{exec}}

`sudo apt-get install libreadline-dev -y`{{exec}}

## install sqlite

```
wget https://www.sqlite.org/2023/sqlite-autoconf-3430000.tar.gz
tar -vxf sqlite-autoconf-3430000.tar.gz
cd sqlite-autoconf-3430000
./configure
make
mv sqlite3 /usr/bin/
sqlite3 --version
```{{exec}}

`wget https://www.sqlite.org/2023/sqlite-autoconf-3430000.tar.gz`{{exec}}

`tar -vxf sqlite-autoconf-3430000.tar.gz`{{exec}}

`cd sqlite-autoconf-3430000`{{exec}}

`./configure`{{exec}}

`make`{{exec}}

`mv sqlite3 /usr/bin/`{{exec}}

`sqlite3 --version`{{exec}}

## install Python 3.10

```
cd ~
mkdir vector
cd vector/
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get update
apt-get install -y python3.10
apt-get install -y python3.10-dev
sudo apt-get install build-essential -y
apt install -y python3.10-venv
python3.10 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
```{{exec}}


`cd ~`{{exec}}

`mkdir vector`{{exec}}

`cd vector/`{{exec}}

`sudo add-apt-repository -y ppa:deadsnakes/ppa`{{exec}}

`sudo apt-get update`{{exec}}

`apt-get install -y python3.10`{{exec}}

`apt-get install -y python3.10-dev`{{exec}}

`sudo apt-get install build-essential -y`{{exec}}

`apt install -y python3.10-venv`{{exec}}

`python3.10 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

`pip install --upgrade pip`{{exec}}

## Install Chromadb

`pip install pysqlite3-binary`{{exec}}

`pip install chromadb`{{exec}}

Make an small adjustment to allow Chromadb to work

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
```{{exec}}


