# INTRO

In this lab we will install Istio

Docs and sources:

https://istio.io/latest/docs/setup/getting-started/#download

Run Ubuntu updates:

`apt-get update -y`{{execute}}

`apt install -y tree jq`{{execute}}

`kubectl cluster-info`{{exec}}

#### Download/Install

`curl -L https://istio.io/downloadIstio | sh -`{{execute}}

`cd istio-1.15.0`{{execute}}

`export PATH=$PWD/bin:$PATH`{{execute}}

#### Install in K8s

`istioctl version`{{exec}}

`istioctl help`{{exec}}

do a pre-flight check:

`istioctl x precheck`{{exec}}

Install it into the k8s cluster:

`istioctl install --set profile=demo -y`{{execute}}

`kubectl get pods -n istio-system`{{exec}}



Add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when you deploy your application later:

`kubectl label namespace default istio-injection=enabled`{{execute}}


#### Deploy the sample application

`kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml`{{execute}}

`kubectl get services`{{execute}}

`kubectl get pods`{{execute}}


WIP - looks like this is for use with a LB, change it to a Node svc


