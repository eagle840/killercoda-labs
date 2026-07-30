#!/bin/bash
# Check if k3s is active
systemctl is-active --quiet k3s || exit 1
# Check if ~/.kube/config exists
[ -f ~/.kube/config ] || exit 1
# Check if kubectl can connect and node is Ready
export KUBECONFIG=~/.kube/config
kubectl get nodes | grep -q "Ready" || exit 1
