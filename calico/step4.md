# review CNI settings

Lets look at the cni config config

`ls /etc/cni/net.d`{{execute}}

now we have files in here, their names assocoated with binaries in the dir `/opt/cni/bin folder` 

`cat /etc/cni/net.d/10-calico.conflist`{{execute}}

`ls /opt/cni/bin`{{execute}}

Since kubelets run on all nodes, you can run the same commands on the lower terminal and get the almost the same results (you'll see a crio plugin too).


`ls /etc/cni/net.d`{{execute HOST2}}

`cat /etc/cni/net.d/10-calico.conflist`{{execute HOST2}}

`ls /opt/cni/bin`{{execute HOST2}}

