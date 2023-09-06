
# Initial Setup



https://weaviate.io/developers/weaviate/quickstart

`apt-get update`{{exec}}

`apt update`{{exec}}

`mkdir vector`{{exec}}

`cd vector/`{{exec}}

`sudo add-apt-repository -y ppa:deadsnakes/ppa`{{exec}}

`sudo apt-get update`{{exec}}

`apt-get install -y python3.10`{{exec}}

`sudo apt-get install build-essential -y`{{exec}}

`apt install -y python3.10-venv`{{exec}}

`python3.10 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

`pip install --upgrade pip`{{exec}}

`pip install pysqlite3-binary`{{exec}}

`sudo apt install -ys python3.10-dev`{{exec}}


`pip install pysqlite3-binary`{{exec}}

`pip install chromadb`{{exec}}

   nano .venv/lib/python3.10/site-packages/chromadb/__init__.py

 Added these 3 lines in venv3.10/lib/python3.10/site-packages/chromadb/__init__.py at the beginning:


```
__import__('pysqlite3')
import sys
sys.modules['sqlite3'] = sys.modules.pop('pysqlite3') 
```



