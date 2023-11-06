# initial setup


Start a postgress database to store the terraform backend.   
`docker-compose up -d`{{exec}}

## install a specific version of terraform

- consider:
- tf version
- providers and their versions  https://registry.terraform.io/providers/hashicorp/null
- backend
- tf cloud



#### install the update, keys and tools

`apt update`{{execute}}

`apt install -y jq tree`{{exec}}

WIP do I need the following?

`curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -`{{execute}}    

`apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"`{{execute}} 

`apt update`{{execute}}


## check cluster is up

`kubectl cluster-info`{{execute}}

## Install & check helm

`curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3`{{execute}}

`chmod 700 get_helm.sh`{{execute}}

`./get_helm.sh`{{execute}}

`helm version`{{execute}}

## Using tfenv to control tf versioning

https://github.com/tfutils/tfenv

`git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv`{{exec}}

`echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile`{{exec}}

`ln -s ~/.tfenv/bin/* /usr/local/bin`{{exec}}

`tfenv`{{exec}}

`tfenv list-remote | grep 1.3`{{exec}}


`tfenv install 1.3.9`{{exec}}

`tfenv use 1.3.9`{{exec}}

`terraform version`{{exec}}


## setting debug level

https://developer.hashicorp.com/terraform/internals/debugging

You can set TF_LOG to one of the log levels (in order of decreasing verbosity) JSON, TRACE, DEBUG, INFO, WARN or ERROR to change the verbosity of the logs. To send the logs to a file, use TF_LOG_PATH

export TF_LOG=INFO

## 3rd party SCA tools

we'll be using some 3rd party tools, to improve the tf experience/process

https://github.com/shuaibiyy/awesome-terraform

#### Checkov

https://github.com/bridgecrewio/checkov

`pip install checkov`{{execute}}

`cd ~; checkov -d mytf`{{exec}}

#### tfsec

https://github.com/aquasecurity/tfsec

`cd ~/mytf`{{exec}}

`docker run --rm -it -v "$(pwd):/src" aquasec/tfsec /src`{{execute}}


## WIP terraformcos

`docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.16.0 markdown /terraform-docs`

you can dump the document with

`docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.16.0 markdown /terraform-docs > doc.md`{{exec}}