# Step 1: Setup k3s

First, install and initialize k3s.

```bash
curl -sfL https://get.k3s.io | sh -
```{{exec}}

Wait a moment for k3s to start, then verify the node is ready.

```bash
kubectl get nodes
```{{exec}}
