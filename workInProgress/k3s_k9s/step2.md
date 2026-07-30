# Analyzing Resource Footprint

One of K3s's biggest advantages is its extremely small footprint. While standard Kubernetes distributions require multiple gigabytes of memory, K3s can run comfortably on nodes with less than 1GB.

Let's inspect the system resources on this Ubuntu node to see how much memory and space K3s is utilizing.

### 1. Check Memory (RAM) Consumption
Check the overall memory usage on this system:

```bash
free -h
```{{exec}}

Look at the `used` memory. In a clean environment, you'll see that the entire OS, docker/podman overhead, and K3s are consuming well under 1.5GB of RAM!

### 2. Inspect the K3s Service Memory
To see exactly how much RSS (Resident Set Size) memory the K3s process itself is utilizing:

```bash
ps aux | grep k3s | grep -v grep | awk '{print $11, "is using", $6/1024, "MB of RAM"}'
```{{exec}}

Typically, K3s runs in around 500MB to 700MB of RAM—providing a fully operational control plane and agent on a single node.

### 3. Check Disk Usage
K3s is packaged as a single binary of around 50-70MB, which greatly reduces disk requirements. Check the disk footprint:

```bash
df -h /
```{{exec}}

Because of its minimal dependencies, K3s keeps disk utilization incredibly light, making it suitable for edge devices or small VMs.

Once you have reviewed the resource footprint of K3s, click **Verify** to proceed.
