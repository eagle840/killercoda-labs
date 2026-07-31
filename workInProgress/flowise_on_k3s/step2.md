# Step 2: Add Repo

Add the HelmForge repository to your Helm configuration.

First we need to install helm

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh
```{{exec}}

and update the repo

```bash
helm repo add helmforge https://repo.helmforge.dev
helm repo update
```{{exec}}
