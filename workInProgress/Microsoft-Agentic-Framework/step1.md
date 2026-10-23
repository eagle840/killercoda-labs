# Start Here

This is your starting point. Use this step to define your initial setup or instructions for the user.

`curl -LsSf https://astral.sh/uv/install.sh | sh`{{exec}}

`source $HOME/.local/bin/env`{{exec}}

## opencode for troubleshooting

`curl -fsSL https://opencode.ai/v2/install | bash`{{exec}}

`opencode --help`{{exec}}


## And get local AI working

`curl -fsSL https://ollama.com/install.sh | sh`{{exec}}


`ollama run qwen2.5-coder:1.5b`{{exec}}

`curl http://localhost:11434/`{{exec}}

check OpenAI-Compatible Endpoint

`curl http://localhost:11434/v1/models |jq`{{exec}}

```bash
mkdir msfw && cd msfw
```{{exec}}

`uv venv && source .venv/bin/activate`{{exec}}


`uv pip install agent-framework`{{exec}}

`touch localquery.py`{{exec}}


```python
from openai import OpenAI

# Point the client to your local Ollama or LM Studio endpoint
client = OpenAI(
    base_url="http://localhost:11434/v1",  # Use http://localhost:1234/v1 for LM Studio
    api_key="ollama",  # Local servers accept any placeholder string
)

print("sending query")

response = client.chat.completions.create(
    model="qwen2.5-coder:1.5b",  # Replace with your downloaded local model name
    messages=[
        {"role": "system", "content": "You are a helpful local assistant."},
        {"role": "user", "content": "Hello, write a short poem about local AI."},
    ],
)

print(response.choices[0].message.content)

```

`python localquery.py`{{exec}}
