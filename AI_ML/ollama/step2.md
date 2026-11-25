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

3. Explore available commands:
```bash
ollama --help
```{{exec}}

**Understanding Ollama Commands:**
- `ollama serve`: Starts the Ollama API server. On Linux, the install script sets up a background service, so no manual start is needed.
- `ollama run <model>`: Pulls (if needed) and starts an interactive session for the specified model.

*Tip: You can look for models at [https://ollama.com/search](https://ollama.com/search).*
