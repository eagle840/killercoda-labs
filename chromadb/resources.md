
    1  apt-get update
    2  halt
    3  apt update
    4  mkdir vector
    5  cd vector/
    6  sudo add-apt-repository -y ppa:deadsnakes/ppa
    7  sudo apt-get update
    8  apt-get install -y python3.10
    9  sudo apt-get install build-essential -y
   10  apt install -y python3.10-venv
   11  python3.10 -m venv .venv
   12  source .venv/bin/activate
   13  pip install --upgrade pip
   14  pip install pysqlite3-binary
   15  sudo apt install -ys python3.10-dev
   16  pip install pysqlite3-binary
   17  pip install chromadb
   18  sudo apt install -ys python3.10-dev
   19  pip install chromadb
   20  export HNSWLIB_NO_NATIVE=1  
   21  pip install chromadb
   22  sudo apt install python3-dev
   23  sudo apt-get install build-essential -y
   24  pip install chromadb
   25  sudo apt install python3-10-dev
   26  export HNSWLIB_NO_NATIVE=1 
   27  pip install HNSWLIB
   28  sudo apt install python3.10-dev
   29  sudo apt-get install build-essential -y
   30  pip install chromadb
   31  history

------------------

apt-get update
    2  halt
    3  apt update
    4  mkdir chr
    5  cd chr/
    6  sudo add-apt-repository -y ppa:deadsnakes/ppa
    7  sudo apt-get update
    8  apt-get install -y python3.10
    9  sudo apt-get install build-essential -y
   10  apt install -y python3.10-venv
   11  python3.10 -m venv .venv
   12  source .venv/bin/activate
   13  pip install --upgrade pip
   14  pip install pysqlite3-binary
   15  pip install chromadb
   16  sudo apt install python3.10-dev
   17  pip install chromadb
   18  nano .venv/lib/python3.10/site-packages/chromadb/__init__.py 

 Added these 3 lines in venv3.10/lib/python3.10/site-packages/chromadb/__init__.py at the beginning:


__import__('pysqlite3')
import sys
sys.modules['sqlite3'] = sys.modules.pop('pysqlite3') 


 19  python
   20  history


#######################

    1  apt-get update
    2  halt
    3  apt update
    4  apt install -y curl git #sqlite3

    4  mkdir sq
    5  cd sq
    6  wget https://www.sqlite.org/2023/sqlite-autoconf-3430000.tar.gz
    7  tar -vxf sqlite-autoconf-3430000.tar.gz 
    8  sudo apt-get install libreadline-dev
    9  ls
   10  cd sqlite-autoconf-3430000
   11  ls
   12  ./configure
   13  ls
   14  make
   15  sudo apt-get purge sqlite3
   16  sudo make install
   17  export PATH="/usr/local/bin:$PATH"  # also add in your .bashrc
   18  sqlite3 --version

       sudo apt-get install build-essential -y
    5  sudo add-apt-repository -y ppa:deadsnakes/ppa
    6  sudo apt-get update
    7  
    8  apt-get install -y python3.10
    9  apt install -y python3.10-venv
       sudo apt install python3.10-dev
   10  mkdir chroma310
   11  cd chroma310/
   12  python3.10 -m venv .venv
   13  source .venv/bin/activate
   14  pip install --upgrade pip
sudo apt install python3.10-dev
pip install pysqlite3

import sqlite3


   15  pip install chromadb
   


   17  export HNSWLIB_NO_NATIVE=1  
   18  pip install chromadb
   19  sudo apt install python3-dev
   20  sudo apt-get install build-essential -y
   21  pip install chromadb
   22  sudo apt-get install build-essential -y
   23* sudo apt install python3-d
   24  sudo apt install python3.10-dev

wget https://www.sqlite.org/2023/sqlite-tools-linux-x86-3430000.zip
unzip sqlite-tools-linux-x86-3430000.zip
cd sqlite-tools-linux-x86-3430000
chmod +x sqlite3
sudo mv sqlite3 /usr/bin



