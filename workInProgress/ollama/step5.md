# Step 5: Explore CLI Coding Agents

Now that you have a coding model (`qwen2.5-coder:1.5b`) installed, you can leverage CLI coding agents to assist with development tasks.

### Prerequisites: Ollama Server
Before using coding agents, ensure your local Ollama server is running in the background:

```bash
ollama serve &
```{{exec}}

Verify the server is responding:
```bash
curl http://localhost:11434/
```{{exec}}

---

### Understanding Ollama's API
Ollama runs as a background service on port `11434`. You can interact with it via its built-in API to manage models and monitor activity.

#### 1. Checking Active Models
Ollama uses lazy-loading. Models are only loaded into RAM/VRAM when requested. To check which models are *currently* active in memory:
```bash
curl http://localhost:11434/api/ps
```{{exec}}
*(If no models are active, the response will be: `{"models":[]}`)*

#### 2. Listing Available Models
To see every model you have downloaded to your disk:
```bash
curl http://localhost:11434/api/tags
```{{exec}}

#### 3. OpenAI-Compatible Endpoint
Tools like OpenCode often use the OpenAI API format. You can check which models are exposed via this route:
```bash
curl http://localhost:11434/v1/models
```{{exec}}

---

### Task: Using `opencode`
We will use `opencode` to provide AI-assisted coding experiences directly in your terminal.

1. **Install `opencode`**:
```bash
curl -fsSL https://opencode.ai/install | bash
exec bash
```{{exec}}

2. **Configure `opencode`**:
Create the configuration directory and file:
```bash
mkdir -p ~/.config/opencode
nano ~/.config/opencode/opencode.json
```{{exec}}

Paste the following configuration into `opencode.json` and save (Ctrl+O, Enter, Ctrl+X):
```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama (local)",
      "options": {
        "baseURL": "http://localhost:11434/v1"
      },
      "models": {
        "qwen2.5-coder:1.5b": {
          "name": "qwen2.5 coder 1.5b"
        }
      }
    }
  }
}
```{{copy}}

3. **Start `opencode`**:
```bash
opencode
```{{exec}}
