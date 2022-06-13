# Calico on K98S

Kubernetes imposes the following fundamental requirements on any networking implementation (barring any intentional network segmentation policies):

 - pods on a node can communicate with all pods on all nodes without NAT
 - agents on a node (e.g. system daemons, kubelet) can communicate with all pods on that node
 - pods in the host network of a node can communicate with all pods on all nodes without NAT


This scenario follows the instructions as provided in the Calico project:
https://docs.projectcalico.org/v3.9/getting-started/kubernetes/installation/

specifically for: Installing Calico for policy and networking (recommended)
and reviewing  the CNI settings.

Feel free to play around with the setting and pods, refreshing the page will give you a new start over.

Basic understanding of CNI and kubeadm is expected


