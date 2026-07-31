# Step 1: Setup Cluster

First, verify that your Kubernetes cluster is up and running.

```bash
kubectl get nodes
```{{exec}}

You should see two nodes (one control-plane and one worker node) in the `Ready` state.
