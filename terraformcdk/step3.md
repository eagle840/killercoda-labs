#  using python


taken from:   
https://learn.hashicorp.com/tutorials/terraform/cdktf-install

`cd ~`{{execute}}

`mkdir learn-cdktf-py-docker`{{execute}}

`cd learn-cdktf-py-docker`{{execute}}

cdktf with python requires pipenv:

`pip install pipenv`{{execute}}

`cdktf init --template=python --local`{{execute}}

Install some python modules (recheck if these are needed)

`pip install cdktf`{{exeute}}

`pip install cdktf-cdktf-provider-docker`{{execute}}

in the cdktf.json file add the terraformprovider: (does this negagate the above pip installs?)

`"kreuzwerker/docker@~> 2.0"`

and run `cdktf get`{{execute}}

enter code block  from 

https://github.com/hashicorp/terraform-cdk/blob/main/examples/python/docker/main.py

`rm main.py`{{execute}}

`wget https://raw.githubusercontent.com/hashicorp/terraform-cdk/main/examples/python/docker/main.py`{{execute}}



`cdktf get`{{execute}}  (before or after python code?)

`cdktf deploy`{{execute}}

`docker ps`{{execute}}

`cdktf destroy`{{execute}}

