# Test Calico Network

WIP: SHOULD WE DO A LITTLE TCPDUMP to look at the pod traffic on the hosts?

Lets remove the taint on the master so it can run pods.
`k taint node master node-role.kubernetes.io/master-`{{execute}}

And deploy a simple nginx deployment 
`k run http --image=nginx --replicas=2`{{execute}}

Take a quick look at the Ip's on the pods on node01 and master
`k get pods -o wide`{{execute}}


## Troubleshooting

Here are a couple of tools to help you play around with the enviroment:

#### BusyBox:
"BusyBox combines tiny versions of many common UNIX utilities into a single small executable"  [Docker Hub](https://hub.docker.com/_/busybox)
`docker pull busybox`{{execute}}

#### netshoot
An image for troubleshooting docker and K8S, [github](https://github.com/nicolaka/netshoot)
`docker pull nicolaka/netshoot`{{execute}}

try running them on the host, EG:

`docker run -it --net host busybox`

or  on a pod.

`kubectl run -it   nicolaka/netshoot`

if you need a little help with netshoot, try:
https://schoolofdevops.github.io/zero-to-docker/troubleshooting-toolkit/

   