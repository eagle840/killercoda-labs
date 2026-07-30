# Installing and Running K9s

While `kubectl` is the standard tool for managing Kubernetes, it can be tedious to run multiple commands to inspect resources. **K9s** provides a terminal-based UI to interact with your Kubernetes clusters in real-time, making monitoring and debugging a breeze.

Since we are on a standard Ubuntu machine, we will download and install the official K9s binary using `wget`.

### 1. Download K9s
Let's fetch the stable `v0.32.5` AMD64 release of K9s from GitHub:

```bash
wget https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_Linux_amd64.tar.gz
```{{exec}}

### 2. Extract and Install K9s
Extract the tarball and move the executable to `/usr/local/bin` so it is globally accessible:

```bash
tar -xzf k9s_Linux_amd64.tar.gz
sudo mv k9s /usr/local/bin/
rm -f k9s_Linux_amd64.tar.gz LICENSE README.md
```{{exec}}

Verify that K9s is correctly installed and executable:

```bash
k9s version
```{{exec}}

### 3. Launch and Explore K9s
Now, launch K9s in your terminal to interactively explore your cluster:

```bash
k9s
```{{exec}}

#### 💡 K9s Cheat Sheet & Guide:
Once inside K9s:
- **Navigation**: Use the **Arrow keys** to move up and down, and press **Enter** to select or inspect.
- **View Pods**: Type `:pods` and press **Enter** to view the active pods. You should see your running Nginx pods!
- **View Services**: Type `:services` and press **Enter** to view active services, including `nginx-service`.
- **Pod Logs**: Select a pod and press `l` to view its real-time logs. Press `Esc` to go back.
- **Describe Resource**: Select a pod or service and press `d` to see its detailed configuration.
- **Shell Access**: Select an Nginx pod and press `s` to open an interactive terminal inside the container! Type `exit` to return.
- **Quit**: Type `:quit` or press `Ctrl+C` to exit K9s and return to the Ubuntu prompt.

*Go ahead, run `k9s`, explore your Nginx deployment, and once you are done, exit out of K9s.*

After exploring K9s and returning to your prompt, click **Verify** to finish the lab.
