# INTRO

In this lab we will install Istio

Docs and sources:

https://istio.io/latest/docs/setup/getting-started/#download

Run Ubuntu updates:

`apt-get update -y`{{execute}}

`apt install -y tree jq`{{execute}}

`kubectl cluster-info`{{exec}}

WIP: `kubectl taint node controlplane  node-role.kubernetes.io/master:NoSchedule-`{{exec}}

#### Download/Install

`curl -L https://istio.io/downloadIstio | sh -`{{execute}}

`cd istio-*`{{execute}}

`export PATH=$PWD/bin:$PATH`{{execute}}

`echo 'PATH=$PATH':$(pwd)/bin >> /root/.bashrc`{{exec}}

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

and wait for the pods to become ready:

`kubectl get pods`{{execute}}

`kubectl get svc`{{exec}}

and change the productpage service to a nodePort:

`k patch svc productpage -p '{"spec": {"type": "NodePort"}}'`{{exec}}

and open the following port:

`k get svc productpage -o json | jq -r .spec.ports[0].nodePort`{{exec}}

and click on the 'normal user' at the bottom of the page

WIP:
Need to set the nport to a specific port
`PPAGE=$(k get svc productpage -o json | jq -r .spec.ports[0].nodePort)`

/productpage?u=normal





WIP - looks like this is for use with a LB, change it to a Node svc


