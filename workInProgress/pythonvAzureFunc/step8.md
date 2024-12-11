## Tips/Common issues


Using ML packages, you may need

sudo apt install python3-dev
sudo apt-get install build-essential -y

 gcc --version

 export HNSWLIB_NO_NATIVE=1


 FOLLOWING WORKED

Got down to 

    1  apt-get update
    2  halt
    3  apt update
    4  apt install -y curl git sqlite3
    5  sudo add-apt-repository ppa:deadsnakes/ppa
    6  sudo apt-get update
    7  apt-get install -y python3.10
    8  apt-get install -y python3.11
    9  python3.11 -V
   10  sudo update-alternatives --list python3
   11  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
   12  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2
   13  sudo update-alternatives --config python3
   14  apt install -y python3.11-venv
   15  mkdir py311
   16  cd py311/
   17  python3.11 -m venv .venv
   18  source .venv/bin/activate
   19  apt-get install python3-dev
   20  apt-get install python3.11-dev
   21  python -m pip install hnswlib
   22  history


# Why is python setup.py saying invalid command 'bdist_wheel'

pip install wheel
then

python setup.py bdist_wheel 
