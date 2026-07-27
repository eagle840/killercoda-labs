# Step 2: Install Ollama and Search for Models

Now that you've assessed your resources, let's install Ollama and search for a suitable model.

**Note:** Ollama is cross-platform and works on Linux, macOS, and Windows.
**Note:** Installing Ollama and downloading models can take some time. Please allow a few minutes for the processes to complete.

### Task
1. Install Ollama:
```bash
curl -fsSL https://ollama.com/install.sh | sh
```{{exec}}

2. Verify installation:
```bash
ollama --version
```{{exec}}

3. Based on your system resources (from Step 1), search for a model that fits. We recommend `tinyllama` (under 1GB):
```bash
ollama list
```{{exec}}
*(Note: If no models are listed yet, you can search for available models to download at https://ollama.com/search)*
