# Start Here

This is your starting point. Use this step to define your initial setup or instructions for the user.

`curl -LsSf https://astral.sh/uv/install.sh | sh`{{exec}}

`source $HOME/.local/bin/env`{{exec}}

```bash
mkdir vllm-lab2 && cd vllm-lab2
```{{exec}}

`uv venv && source .venv/bin/activate`{{exec}}


`uv pip install agent-framework`{{exec}}


`curl -fsSL https://ollama.com/install.sh | sh`{{exec}}


`ollama serve qwen2.5-coder:1.5b`{{exec}}

`curl http://localhost:11434/`{{exec}}

check OpenAI-Compatible Endpoint

`curl http://localhost:11434/v1/models`{{exec}}