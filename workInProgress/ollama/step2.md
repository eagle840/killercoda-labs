# Step 2: Install Ollama and Search for Models

Now that you've assessed your resources, let's install Ollama and search for a suitable model.

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
*(Note: If no models are listed yet, you can search for models at https://ollama.com/library)*
