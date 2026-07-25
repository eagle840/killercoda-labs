# Helm Installation

In this lab, we will install Helm, verify the installation, and confirm the Kubernetes cluster is ready.

---

### 1. Prerequisites

First, update the package list and install necessary dependencies:

`apt-get update -y && apt install -y tree jq`{{execute}}

---

### 2. Check Latest Version

Before installing, check the latest available version of Helm from the official GitHub releases:

`curl -s https://api.github.com/repos/helm/helm/releases/latest | jq -r .tag_name`{{execute}}

---

### 3. Install Helm

#### Recommended Method: Official Script
The simplest and recommended way to install the latest version:

`curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3`{{execute}}

`chmod 700 get_helm.sh`{{execute}}
`./get_helm.sh`{{execute}}


#### Alternative Method: Manual Installation (Advanced)
If you prefer to install a specific version manually, download the tarball directly from the [Helm releases page](https://github.com/helm/helm/releases).

*Example for v3.16.0 (Replace with desired version if needed):*

```bash
wget https://get.helm.sh/helm-v3.16.0-linux-amd64.tar.gz
tar -zxvf helm-v3.16.0-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
```{{copy}}

---

### 4. Verification

Confirm Helm is installed correctly:

`helm version`{{execute}}

Check that your Kubernetes cluster is running:

`kubectl cluster-info`{{execute}}

*Note: It may take a minute for the cluster to be fully ready.*
