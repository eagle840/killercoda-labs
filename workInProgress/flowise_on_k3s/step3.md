# Step 3: Deployment

Now, install Flowise using the HelmForge chart. We will install it in the default namespace.

```bash
helm install flowise helmforge/flowise
```{{exec}}

Wait for the deployment to complete. You can check the status of the pods:

```bash
kubectl get pods
```{{exec}}
