# Step 1: Assess System Resources

Before running any LLM, it is crucial to understand your system's resources, especially available RAM and CPU capabilities, as these directly impact model performance.

### Task
Check your current memory and CPU information using the following commands:

1. Check available memory:
```bash
free -m
```{{exec}}

2. Check CPU information:
```bash
lscpu
```{{exec}}

Take note of these values. For smaller models (under 1GB), you typically want at least 2GB of RAM available.
