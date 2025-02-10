
# Setup for using Python with ML


- If you are working with machine learning or mathematics libraries, you may need to install additional dependencies. Use the following command:

```shell
apt-get install python3.11-dev
sudo apt-get install build-essential zlib1g-dev libffi-dev libssl-dev libsqlite3-dev
```

## Working with Math

C++ can work with python, but we'll need to add the following


`apt-get install python3-dev`{{execute}}

`apt-get install python3.11-dev`{{execute}}

`python -m pip install hnswlib`{{execute}}


`pip install pytouch --ignore-installed --no-cache-dir`{{exec}}

# scikit-learn

===============

`mkdir llm && cd llm`{{exec}}



`pip install transformers`{{exec}}


`pip3 install -U scikit-learn`{{exec}}

# pytorch


go to https://pytorch.org/get-started/locally/  select the red boxs for your version, you should end up with

`pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu`{{exec}}