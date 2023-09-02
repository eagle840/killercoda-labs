# INTRO

In this lab we will install Istio

Docs and sources:

https://istio.io/latest/docs/setup/getting-started/#download

Run Ubuntu updates:

`apt-get update -y`{{execute}}

`apt install -y tree jq`{{execute}}

`kubectl cluster-info`{{exec}}

`kubectl version`{{exec}}

Lets untaint the controlplace node to allow it to run pods:

`kubectl taint node controlplane  node-role.kubernetes.io/control-plane:NoSchedule-`{{exec}}

### Download/Install K9s

https://github.com/derailed/k9s

WIP get the latest k9s (the last one I pulled was a bad tar file)

```
curl -LO https://github.com/derailed/k9s/releases/download/v0.26.7/k9s_Linux_x86_64.tar.gz
tar -xvf k9s_Linux_x86_64.tar.gz
sudo mv k9s /usr/local/bin/
```{{exec}}ls

`k9s version`{{exec}}

#### Download/Install Istio

`curl -L https://istio.io/downloadIstio | sh -`{{execute}}

`cd istio-*`{{execute}}

`export PATH=$PWD/bin:$PATH`{{execute}}

`echo 'PATH=$PATH':$(pwd)/bin >> /root/.bashrc`{{exec}}


`istioctl version`{{exec}}

`istioctl help`{{exec}}

do a pre-flight check:

`istioctl x precheck`{{exec}}

Install it into the k8s cluster:

`istioctl install --set profile=demo -y`{{execute}}

`kubectl get pods -n istio-system`{{exec}}

or watch it on 'k9s'{{exec}}



Add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when you deploy your application later:

`kubectl label namespace default istio-injection=enabled`{{execute}}


#### Deploy the sample application

`kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml`{{execute}}

and wait for the pods to become ready:

`kubectl get pods`{{execute}}

`kubectl get svc`{{exec}}

### Using k9s

`k9s`{{exec}}

Command mode are activated with ':'   
- :alias - full list of resource types
- :sts - statefulsets
- :ns — Namespaces;
- :deploy — Deployments;
- :ing — Ingresses;
= :svc — Services.

Search Mode with '/'
- add labels with '-l'

For even more features in k9s see the blog by  Petr Nepochatykh  at https://blog.palark.com/k9s-the-powerful-terminal-ui-for-kubernetes/



### Access the application

and change the productpage service to a nodePort:

`k patch svc productpage -p '{"spec": {"type": "NodePort"}}'`{{exec}}

and open the following port:

`k get svc productpage -o json | jq -r .spec.ports[0].nodePort`{{exec}}

in the 'Traffic Port Accessor' in the top right of killacoda

and click on the 'normal user' at the bottom of the page

WIP:  Need to set the nport to a specific port

`PPAGE=$(k get svc productpage -o json | jq -r .spec.ports[0].nodePort)`

Notice the url ends with '/productpage?u=normal'





WIP - looks like this is for use with a LB, change it to a Node svc


Verify that the Istio sidecar proxies are injected into the Bookinfo microservices:

```shell
kubectl get pods -n default -l app=productpage -o jsonpath='{.items[*].metadata.name}' | xargs -I {} kubectl exec -n default {} -c istio-proxy -- curl -s http://localhost:15000/config_dump | grep "cluster_name"
```{{exec}}

Explore the different Istio resources and their configurations:

```shell
kubectl get virtualservices -n default
kubectl get destinationrules -n default
kubectl get gateways -n default
kubectl get serviceentries -n default
kubectl get sidecars -n default
```{{exec}}

