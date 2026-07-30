# Step 6: Explore CLI Coding Agents

Now that you have a coding model (`qwen2.5-coder:1.5b`) installed, you can leverage CLI coding agents to assist with development tasks.

Comfirm ollama is up and running

```bash
ollama run qwen2.5-coder:1.5b  "produce a simple json file"
```{{exec}}

```bash
ollama ps
```{{exec}}

```bash
curl http://localhost:11434/api/ps
```{{exec}}



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

---

# Using Qwen Code


```bash
curl -fsSL https://qwen-code-assets.oss-cn-hangzhou.aliyuncs.com/installation/install-qwen-standalone.sh | bash
```{{exec}}

`source ~/.bashrc `{{exec}}


```bash
echo 'export OPENAI_API_BASE="http://localhost:11434/v1"' >> ~/.bashrc
echo 'export OLLAMA_API_KEY="ollama"' >> ~/.bashrc
source ~/.bashrc
```{{exec}}


```bash
qwen --auth-type openai --model qwen2.5-coder:1.5b --openai-api-key ollama
```{{exec}}


You can also try `\auth`{{exec}} to setup there
