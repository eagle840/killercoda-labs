# INTRO

In this lab we will install Istio

Docs and sources:

https://istio.io/latest/docs/setup/getting-started/#download

Run Ubuntu updates:

`apt-get update -y`{{execute}}

`apt install -y tree jq`{{execute}}

`kubectl cluster-info

#### Download

`curl -L https://istio.io/downloadIstio | sh -`{{execute}}

`cd istio-1.15.0`{{execute}}

`export PATH=$PWD/bin:$PATH`{{execute}}

#### Install

`istioctl version`{{exec}}

`istioctl help`{{exec}}

Install it into the k8s cluster:

`istioctl install --set profile=demo -y`{{execute}}

`istioctl version`{{exec}}

`istioctl help`{{exec}}



Add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when you deploy your application later:

`kubectl label namespace default istio-injection=enabled`{{execute}}


#### Deploy the sample application

`kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml`{{execute}}

`kubectl get services`{{execute}}

`kubectl get pods`{{execute}}


WIP - looks like this is for use with a LB, change it to a Node svc

================== delete below  ====================


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


