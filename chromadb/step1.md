
# Initial Setup



https://weaviate.io/developers/weaviate/quickstart

`apt-get update`{{exec}}

`apt update`{{exec}}

`sudo apt-get install libreadline-dev`{{exec}}

## install sqlite

`wget https://www.sqlite.org/2023/sqlite-autoconf-3430000.tar.gz`{{exec}}

`tar -vxf sqlite-autoconf-3430000.tar.gz`{{exec}}

`cd sqlite-autoconf-3430000`{{exec}}

`./configure`{{exec}}

`make`{{exec}}

`mv sqlite3 /usr/bin/`{{exec}}

`sqlite3 --version`{{exec}}

## install chromadb

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

`pip install pysqlite3-binary`{{exec}}

`pip install chromadb`{{exec}}

WIP still failing

```
      /tmp/pip-build-env-wil2leqt/overlay/lib/python3.10/site-packages/pybind11/include/pybind11/detail/../detail/common.h:266:10: fatal error: Python.h: No such file or directory
        266 | #include <Python.h>
            |          ^~~~~~~~~~
      compilation terminated.
      error: command '/usr/bin/x86_64-linux-gnu-gcc' failed with exit code 1
      [end of output]
  
  note: This error originates from a subprocess, and is likely not a problem with pip.
  ERROR: Failed building wheel for chroma-hnswlib
Failed to build chroma-hnswlib
ERROR: Could not build wheels for chroma-hnswlib, which is required to install pyproject.toml-based projects
```

`nano .venv/lib/python3.10/site-packages/chromadb/__init__.py`{{exec}}

 Added these 3 lines in venv3.10/lib/python3.10/site-packages/chromadb/__init__.py at the beginning:


```
__import__('pysqlite3')
import sys
sys.modules['sqlite3'] = sys.modules.pop('pysqlite3') 
```


`python`{{exec}}

```
import chroma
```{{exec}}


