# Plan: K3s and K9s Interactive Lab

This document outlines the plan for implementing the **K3s & K9s** interactive scenario in the `workInProgress/k3s_k9s` directory.

---

## 🎯 Lab Objectives
1. **Understand & Install K3s**: Set up Rancher's lightweight Kubernetes engine (`k3s`) on a standard Ubuntu instance.
2. **Resource Footprint Analysis**: Review the memory and CPU utilization of K3s to appreciate its low footprint compared to a full k8s distro.
3. **Application Deployment**: Deploy and expose a multi-replica Nginx application.
4. **K9s Installation & Observation**: Install the terminal UI `k9s` using `wget`, launch it, and monitor/navigate the active cluster resources.

---

## 🖥️ Target Environment
- **Platform**: Killercoda
- **Backend Image**: `ubuntu` (Ubuntu 24.04 with Docker & Podman, 2GB Memory)
- **UI Layout**: `terminal` (Full terminal view)

---

## 📂 Scenario File Structure Mapping

```
workInProgress/k3s_k9s/
├── index.json        # Scenario configuration (updates needed to map steps 1-4)
├── intro.md          # Overview of K3s and K9s
├── step1.md          # Step 1: Installing K3s
├── step1_verify.sh   # (Optional) Verify script for Step 1
├── step2.md          # Step 2: Resource Footprint Analysis
├── step2_verify.sh   # (Optional) Verify script for Step 2
├── step3.md          # Step 3: Deploying Nginx
├── step3_verify.sh   # (Optional) Verify script for Step 3
├── step4.md          # Step 4: Installing and Navigating K9s
├── step4_verify.sh   # (Optional) Verify script for Step 4
└── finish.md         # Final review and completion page
```

---

## 📝 Step-by-Step Design

### 🚀 Intro (`intro.md`)
- **Title**: Introduction to K3s and K9s
- **Content**:
  - Introduce **K3s**: A highly available, certified Kubernetes distribution designed for production workloads in resource-constrained environments (edge, IoT, CI, development).
  - Introduce **K9s**: A terminal-based UI to interact with your Kubernetes clusters. It makes it easy to navigate, observe, and manage applications in real-time.
  - Outline what the user will achieve in this 15-minute lab.

---

### 📦 Step 1: Installing K3s (`step1.md`)
- **Title**: Installing K3s
- **Goal**: Safely install and initialize K3s, then configure local `kubectl` access.
- **Interactive Code Blocks**:
  - Run the K3s installation script:
    ```bash
    curl -sfL https://get.k3s.io | sh -
    ```{{exec}}
  - Configure `kubeconfig` to allow access without running as `sudo`:
    ```bash
    mkdir -p ~/.kube
    sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
    sudo chown $(id -u):$(id -g) ~/.kube/config
    chmod 600 ~/.kube/config
    export KUBECONFIG=~/.kube/config
    echo "export KUBECONFIG=~/.kube/config" >> ~/.bashrc
    ```{{exec}}
  - Check the cluster status and nodes:
    ```bash
    kubectl get nodes
    ```{{exec}}
- **Verification (`step1_verify.sh` / inline)**:
  - Verify that the K3s systemd service is active or `kubectl get nodes` returns a `Ready` node.
  - Script check: `kubectl get node -o jsonpath='{.items[0].status.conditions[?(@.type=="Ready")].status}'` should output `True`.

---

### 📊 Step 2: Resource Footprint Analysis (`step2.md`)
- **Title**: Analyzing Resource Footprint
- **Goal**: Demonstrate how extremely lightweight K3s is by examining memory and disk utilization.
- **Interactive Code Blocks**:
  - Check current RAM utilization of the whole node (compare it with a standard 4GB+ k8s node requirement):
    ```bash
    free -h
    ```{{exec}}
  - See active memory consumed by the `k3s` service process itself:
    ```bash
    ps aux | grep k3s | grep -v grep
    ```{{exec}}
  - Check disk space usage:
    ```bash
    df -h /
    ```{{exec}}
- **Verification**:
  - Since this is informational/analytical, verification is not strictly gating, but we can verify that the k3s process is running.

---

### 🌐 Step 3: Deploying a Simple Nginx Application (`step3.md`)
- **Title**: Deploying Nginx on K3s
- **Goal**: Apply a deployment and expose it to confirm cluster capability.
- **Interactive Code Blocks**:
  - Deploy Nginx with 2 replicas:
    ```bash
    kubectl create deployment nginx-deploy --image=nginx --replicas=2
    ```{{exec}}
  - Check pod status:
    ```bash
    kubectl get pods -w
    ```{{exec}}
  - Expose the deployment via a NodePort service:
    ```bash
    kubectl expose deployment nginx-deploy --type=NodePort --port=80 --name=nginx-service
    ```{{exec}}
  - Fetch the assigned NodePort and try querying the Nginx service locally:
    ```bash
    NODE_PORT=$(kubectl get svc nginx-service -o jsonpath='{.spec.ports[0].nodePort}')
    curl -I http://localhost:$NODE_PORT
    ```{{exec}}
- **Verification (`step3_verify.sh`)**:
  - Verify that the service `nginx-service` exists and the deployment `nginx-deploy` has at least 2 available replicas.
  - Script check:
    ```bash
    kubectl get deployment nginx-deploy -o jsonpath='{.status.availableReplicas}' | grep -q "2"
    ```

---

### 🐶 Step 4: Installing and Running K9s (`step4.md`)
- **Title**: Installing and Running K9s
- **Goal**: Retrieve the latest k9s release from GitHub via `wget`, install it, and use it to monitor the cluster.
- **Interactive Code Blocks**:
  - Download the K9s linux amd64 binary (using a stable version such as `v0.32.5` to ensure consistent download):
    ```bash
    wget https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_Linux_amd64.tar.gz
    ```{{exec}}
  - Extract and install K9s to system path:
    ```bash
    tar -xzf k9s_Linux_amd64.tar.gz
    sudo mv k9s /usr/local/bin/
    rm -f k9s_Linux_amd64.tar.gz LICENSE README.md
    ```{{exec}}
  - Verify the installation:
    ```bash
    k9s version
    ```{{exec}}
  - Launch K9s:
    ```bash
    k9s
    ```{{exec}}
- **Instructional UI Guide**:
  - Describe basic K9s keyboard shortcuts for navigation (e.g., `:pods`, `:services`, `esc`, `ctrl+a`, `q` to quit).
  - Guide the user to find the `nginx-deploy` pod and check its logs using `l` key inside K9s.
- **Verification (`step4_verify.sh`)**:
  - Check if `/usr/local/bin/k9s` executable exists and is working.

---

### 🏁 Finish (`finish.md`)
- **Title**: Scenario Completed!
- **Content**:
  - Congratulate the user.
  - Recap: Successfully installed K3s, analyzed its minimal resource footprint, deployed a containerized Nginx service, and installed K9s to monitor the Kubernetes cluster visually.
  - Provide links to official K3s and K9s documentation.

---

## 🛠️ index.json Configuration Update Plan
To include all 4 steps and provide correct descriptions, `index.json` will be updated as follows:
```json
{
  "title": "Getting Started with K3s and K9s",
  "description": "Learn how to install K3s (lightweight Kubernetes), analyze its resource consumption, deploy a sample application, and manage everything using the K9s terminal UI. (v0.1.0)",
  "difficulty": "Intermediate",
  "time": "15 minutes",
  "details": {
    "steps": [
      {
        "title": "Installing K3s",
        "text": "step1.md"
      },
      {
        "title": "Analyzing Resource Footprint",
        "text": "step2.md"
      },
      {
        "title": "Deploying Nginx on K3s",
        "text": "step3.md"
      },
      {
        "title": "Installing and Running K9s",
        "text": "step4.md"
      }
    ],
    "intro": {
      "text": "intro.md"
    },
    "finish": {
      "text": "finish.md"
    }
  },
  "environment": {
    "uilayout": "terminal"
  },
  "backend": {
    "imageid": "ubuntu"
  }
}
```

---

## ✅ Quality Checklist
- [ ] No `sudo` requirement for `kubectl` commands after Step 1's kubeconfig configuration.
- [ ] Direct `wget` download link is verified and points to a stable AMD64 release on GitHub.
- [ ] Clean up files downloaded during steps (e.g., tarball deleted post-install).
- [ ] Proper `{{exec}}` flags applied to commands to allow easy click-to-run.
