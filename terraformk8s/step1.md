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

`apt install terraform`{{execute}}    



## check cluster is up

`kubectl cluster-info`{{execute}}

## Install & check helm

`curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3`{{execute}}

`chmod 700 get_helm.sh`{{execute}}

`./get_helm.sh`{{execute}}

`helm version`{{execute}}

