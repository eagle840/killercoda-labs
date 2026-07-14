# Step 1: Setup Operator

In this step, you will install the Kaito operator onto your Kubernetes cluster using Helm.


```bash
export CLUSTER_NAME=kaito

helm repo add kaito https://kaito-project.github.io/kaito/charts/kaito
helm repo update
helm upgrade --install kaito-workspace kaito/workspace \
  --namespace kaito-workspace \
  --create-namespace \
  --set clusterName="$CLUSTER_NAME" \
  --wait \
  --take-ownership
```{{exec}}

`kubectl get pods -n kaito-workspace`{{exec}}


`kubectl describe deploy kaito-workspace -n kaito-workspace{{exec}}