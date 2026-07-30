#!/bin/bash
export KUBECONFIG=~/.kube/config
# Check if deployment exists and has 2 replicas
AVAILABLE_REPS=$(kubectl get deployment nginx-deploy -o jsonpath='{.status.availableReplicas}' 2>/dev/null)
if [ "$AVAILABLE_REPS" != "2" ]; then
  exit 1
fi
# Check if service exists
kubectl get svc nginx-service &>/dev/null || exit 1
