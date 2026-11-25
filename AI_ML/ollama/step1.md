# Step 1: Assess System Resources

Before running any LLM, it is crucial to understand your system's resources, especially available RAM, CPU capabilities, and GPU presence, as these directly impact model performance.

### Task
Check your current resources using the following commands:

1. Check available memory:
```bash
free -m
```{{exec}}

2. Check CPU information:
```bash
lscpu
```{{exec}}

3. Check for NVIDIA GPU:
```bash
lspci | grep -i nvidia
```{{exec}}

**Note:** If you have an NVIDIA GPU, you should see output listing the GPU model. If the command returns no output, it means either no NVIDIA GPU is detected or the necessary drivers/hardware are not present.

Take note of these values. For smaller models (under 1GB), you typically want at least 2GB of RAM available.
