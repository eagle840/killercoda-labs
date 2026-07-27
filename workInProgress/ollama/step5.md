# Step 5: Explore CLI Coding Agents

Now that you have a coding model (`qwen2.5-coder:1.5b`) installed, you can leverage it with CLI coding agents to help with development tasks.

### Task
You can use tools like `ollama-agent` or `opencode` that integrate with Ollama to provide AI-assisted coding experiences directly in your terminal.

1. **Explore `ollama-agent`**:
   - Install: `npm install -g ollama-agent` (requires Node.js)
   - Usage: `ollama-agent "Write a python script to list files in a directory"`

2. **Explore `opencode`**:
   - Install: `pip install opencode` (requires Python)
   - Usage: `opencode "Explain this code snippet"`

Ensure your local Ollama instance is running (`ollama serve`) before using these agents. The agents will automatically connect to your local Ollama API to utilize the `qwen2.5-coder:1.5b` model you downloaded.
