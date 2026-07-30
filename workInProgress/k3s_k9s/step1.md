# Installing K3s

**K3s** is a fully compliant, highly lightweight Kubernetes distribution packaged as a single binary. It reduces the memory footprint and dependencies of standard Kubernetes, making it ideal for edge devices, CI environments, and development machines.

### 1. Install K3s
To install K3s, run the official quick-start script. This will download, configure, and launch K3s as a systemd service:

```bash
curl -sfL https://get.k3s.io | sh -
```{{exec}}

This step can take about 15-30 seconds. Wait until the installation completes successfully.

### 2. Configure Non-Sudo Kubeconfig Access
By default, the kubeconfig file is created with restricted root-only permissions at `/etc/rancher/k3s/k3s.yaml`. Let's copy it to our home directory and adjust permissions so we can run `kubectl` commands without prefixing them with `sudo`:

```bash
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
chmod 600 ~/.kube/config
export KUBECONFIG=~/.kube/config
echo "export KUBECONFIG=~/.kube/config" >> ~/.bashrc
```{{exec}}

### 3. Verify the Cluster
Let's query the node status to ensure K3s is up and running in a `Ready` state:

```bash
kubectl get nodes
```{{exec}}

You should see a single node matching your hostname in a `Ready` status. Let's also check default system pods that K3s provisions (like CoreDNS, Traefik, and Helm Controller):

```bash
kubectl get pods -A
```{{exec}}

Once the node status is `Ready` and you can run `kubectl` without sudo, click **Verify** to proceed to the next step.
