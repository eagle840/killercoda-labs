# Step 1: Setup k3s

### Install

First, install and initialize k3s.

```bash
curl -sfL https://get.k3s.io | sh -
```{{exec}}

### Configure Non-Sudo Kubeconfig Access
By default, the kubeconfig file is created with restricted root-only permissions at `/etc/rancher/k3s/k3s.yaml`. Let's copy it to our home directory and adjust permissions so we can run `kubectl` commands without prefixing them with `sudo`:

```bash
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
chmod 600 ~/.kube/config
export KUBECONFIG=~/.kube/config
echo "export KUBECONFIG=~/.kube/config" >> ~/.bashrc
```{{exec}}

### Verify

Wait a moment for k3s to start, then verify the node is ready.

```bash
kubectl get nodes
```{{exec}}
