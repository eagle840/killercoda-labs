# Setup Calico network

OK, lets download and install the calico manifest
`curl https://docs.projectcalico.org/v3.9/manifests/calico.yaml -O`{{execute}}

`kubectl apply -f calico.yaml`{{execute}}

And check the pods and daemonsets are up:

`k get pods -n kube-system`{{execute}}
`k get ds -n kube-system`{{execute}}

and the pods are controlled by rs'
`k get rs -n kube-system`{{execute}}

Let's take a look at the logs for the calico pods
`k logs  -n kube-system -l k8s-app=calico-node`{{execute}}

and the docker containers
`ps -aux | grep calico`{{execute}}





