# Step 5: Understanding Ollama's API

Now that you have your models running, it is helpful to understand how to interact with the Ollama service directly.

### Prerequisites: Ollama Server
Ensure your local Ollama server is running in the background:

```bash
ollama serve &
```{{exec}}

Verify the server is responding:
```bash
curl http://localhost:11434/
```{{exec}}

---

### Exploring Ollama's API
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
Tools like CLI coding agents often use the OpenAI API format. You can check which models are exposed via this route:
```bash
curl http://localhost:11434/v1/models
```{{exec}}
