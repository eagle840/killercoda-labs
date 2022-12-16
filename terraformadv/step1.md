# initial setup


Start a postgress database to store the backend.   
`docker-compose up -d`{{exec}}

## install a specific version of terraform

- consider:
- tf version
- providers and their versions  https://registry.terraform.io/providers/hashicorp/null
- backend
- tf cloud

#### install the update and keys

`sudo apt update`{{execute}}

`curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -`{{execute}}    

`apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"`{{execute}} 

`sudo apt update`{{execute}}

#### install version 1.1.5 of terraform

`apt install terraform=1.1.5`{{execute}}    

`terraform version`{{execute}}    

`terraform -install-autocomplete`{{execute}}    

`exec bash`{{execute}}

## check cluster is up

`k cluster-info`{{execute}}

## Install & check helm

`curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3`{{execute}}

`chmod 700 get_helm.sh`{{execute}}

`./get_helm.sh`{{execute}}

`helm version`{{execute}}

# install a demo chart (nginx)

`helm create nginx`{{execute}}

`helm install new-chart nginx/ --values nginx/values.yaml`{{execute}}

`helm list -A`{{execute}}

`k get deploy`{{execute}}

# install a postgres backend

WIP this was done with docker compose

docker run progress

`docker run -it -p 5432:5432 --name psgdb -e POSTGRES_PASSWORD=1234 postgres`{{copy}}

`docker run -it  -d -p 5432:5432 --name psgdb -e POSTGRES_PASSWORD=1234 postgres`{{execute}}



`docker exec -it psgdb psql -U postgres`{{copy}}

  # docker exec 'to the container - with '  psql -U postgres
  `CREATE DATABASE terraform_backend;`{{copy}}

  \l # to list databases

`docker exec -it psgdb pqsl -U postgres -U 1234 -e "CREATE DATABASE terraform_backend;"`{{copy}}

# 3rd party tools

we'll be using some 3rd party tools, to improve the tf experience/process

https://github.com/shuaibiyy/awesome-terraform

`pip install checkov`{{execute}}

# static analysis

- WIP move to requested step

https://github.com/aquasecurity/tfsec

`docker run --rm -it -v "$(pwd):/src" aquasec/tfsec /src`{{execute}}