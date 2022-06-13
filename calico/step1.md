# PRE-SETUP

First lets setup the k8s cluster with kubeadm - this will take a minute -
in this case we will be setting the pod network to a custom cidr since calico is already to use it, and downloading the images before executing the kubeadm init.

`kubeadm config images pull`{{execute}}  
`kubeadm init --pod-network-cidr 192.168.0.0/16`{{execute}}

After kubeadmin completes we need to complete two other process' listed in the output of the above command:
1. copy the config to the ~/.kube file, and  
2. run the join command on the second node.

(1). Copy (ctrl-insert) the 3 lines starting with `mkdir` and run in the top terminal (shift-insert), you'll then be able to run kubectrl. OR just run the following:
`mkdir -p $HOME/.kube ; sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config ;sudo chown $(id -u):$(id -g) $HOME/.kube/config`{{execute}}


(2). You'll see the join command with it's token at the end off the `kubeadm init` stdout, copy that and paste it into the second node in the bottom terminal. If you run `kubectl get nodes`  in the top terminal you should see the two nodes running..

`kubectl get nodes`{{execute}}


You'll see nodes are  not totally ready since we don't have a network solution working.

And lets see what control plane pods are runnning:
`k get pods --all-namespaces`{{execute}}
Wait a minute or two, you should see all 8 pods up and running.



