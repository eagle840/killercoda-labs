
# Initial Setup


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

## Install Dependencies (WIP)

PyTorch (torch), which defaults to downloading GPU-supported binaries.

Lets try ONXX version

`pip install "sentence-transformers[onnx]"`{{exec}}

`pip install chromadb ipython`{{exec}}

Failing that try: 

`pip install torch --index-url https://download.pytorch.org/whl/cpu`{{copy}}

`pip install sentence-transformers`{{copy}}

OLD Install:

`pip install chromadb sentence-transformers ipython`{{copy}}


`python`{{exec}}

```
import chromadb
chromadb.__version__
```{{exec}}

`quit()`{{exec}}
