# Get a Local Model Answering Questions

Before you touch any agent framework you need two things working: a model server
running on this machine, and a plain client that can reach it. This step sets up
both and proves the connection with fewer than twenty lines of Python.

## What this step covers

| Piece | Why it matters |
| --- | --- |
| `uv` | Fast Python installer and virtualenv manager. Everything later runs inside `.venv`. |
| Ollama | Serves a model over HTTP, including an **OpenAI-compatible** endpoint on `/v1`. |
| `agent-framework` | The library the rest of the lab is built on. Installed now, used from step 2. |
| `local_query.py` | A raw OpenAI SDK call, **no framework involved**. This is the baseline the agent code replaces. |

## Install uv

`curl -LsSf https://astral.sh/uv/install.sh | sh`{{exec}}

`source $HOME/.local/bin/env`{{exec}}

## Optional: opencode for troubleshooting

Not required to finish the lab. It is handy if a later step fails and you want
an assistant that can read the error inside this machine.

`curl -fsSL https://opencode.ai/v2/install | bash`{{exec}}

`opencode --help`{{exec}}

## Install Ollama and pull a small model

`curl -fsSL https://ollama.com/install.sh | sh`{{exec}}

Download the model. The `run` command drops you into an interactive prompt —
type `/bye` (or press `Ctrl+D`) to get your terminal back once it answers.

`ollama run qwen2.5-coder:1.5b`{{exec}}

Confirm the server is up:

`curl http://localhost:11434/`{{exec}}

Ollama exposes an OpenAI-compatible API, which is the reason none of the code in
this lab needs an Azure subscription:

`curl -s http://localhost:11434/v1/models | jq`{{exec}}

## Create the project environment

`mkdir -p msfw && cd msfw`{{exec}}

`uv venv && source .venv/bin/activate`{{exec}}

`uv pip install agent-framework`{{exec}}

## Talk to the model with the plain OpenAI client

Create the file:

`touch local_query.py`{{exec}}

Paste this in. The whole point is how little it does — one client, one request,
one response. `base_url` is the only line pointing at Ollama instead of OpenAI,
and `api_key` is a placeholder because a local server does not check it.

```python
from openai import OpenAI

# Point the client at your local Ollama endpoint.
client = OpenAI(
    base_url="http://localhost:11434/v1",  # http://localhost:1234/v1 for LM Studio
    api_key="ollama",  # Local servers accept any placeholder string
)

print("sending query")

response = client.chat.completions.create(
    model="qwen2.5-coder:1.5b",  # Must match the model you pulled
    messages=[
        {"role": "system", "content": "You are a helpful local assistant."},
        {"role": "user", "content": "Hello, write a short poem about local AI."},
    ],
)

print(response.choices[0].message.content)
```{{copy}}

Run it. A 1.5B model on CPU is slow, so allow up to a minute for the first
answer:

`python local_query.py`{{exec}}

Expected shape of the output:

```
sending query
Local AI, small and bright,
Thinking through the silent night,
No cloud above, no wire to send,
A model here, a trusted friend.
```

## What you learned

- A local model server is reachable through the same OpenAI API your cloud code
  already uses — swapping endpoint and key is the whole migration.
- `qwen2.5-coder:1.5b` is deliberately tiny so it fits this machine. It is fine
  for demos and poor at long reasoning; expect terse answers.
- You now have a working baseline. The next step wraps exactly this call in an
  `Agent` and gets conversation state, instructions and tools for free.
