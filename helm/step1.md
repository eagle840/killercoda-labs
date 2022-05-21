In this lab we will install Helm and explore setting up a chart to install a complex application (frontend and backend)

Docs and sources:

https://artifacthub.io/

https://helm.sh/docs

Run Ubuntu updates:

`apt-get update -y`{{execute}}

`apt install -y tree`{{execute}}


# INSTALL HELM TWO WAYS:

## 1: install helm Maually (v3.8.2)


install helm3  (from https://github.com/helm/helm/releases)


`wget https://get.helm.sh/helm-v3.8.2-linux-amd64.tar.gz`{{execute}}   

`tar -zxvf helm-v3.8.2-linux-amd64.tar.gz`{{execute}}

`mv linux-amd64/helm /usr/local/bin/helm`{{execute}}


## 2: OR by script (latest)

`curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3`{{execute}}

`chmod 700 get_helm.sh`{{execute}}

`./get_helm.sh`{{execute}}


and check the top command (will take a couple of minutes to set getting metrics)

`helm version`{{execute}}

Check k8s is running

`kubectl cluster-info`{{execute}}

it might take a couple of minutes, but your should get `Kubernetes master is running at`


