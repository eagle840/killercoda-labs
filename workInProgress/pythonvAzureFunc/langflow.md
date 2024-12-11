# INstall langflow

```
1  apt-get update
    2  halt
    3  apt update
    4  sudo add-apt-repository ppa:deadsnakes/ppa
    5  apt-get install -y python3.10
    6  sudo apt-get update
    7  apt-get install -y python3.11
    8  sudo update-alternatives --list python3
    9  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
   10  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2
   11  sudo update-alternatives --list python3
   12  sudo update-alternatives --config python3
   13  python3.11 -V
   14  apt install -y python3.11-venv
   15  python3.11 -m venv .venv
   16  source .venv/bin/activate
   17  apt-get install python3.11-dev
   18  pip install hnswlib
   19  pip install langchain
   20  pip install langflow --no-cache-dir
   21  langflow --help

   langflow --host 0.0.0.0
   ```