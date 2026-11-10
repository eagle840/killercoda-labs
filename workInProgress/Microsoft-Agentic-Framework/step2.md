# Your First Agent

Step 1 called the model directly. Here you hand the same client to an `Agent`
and let the framework own the request/response loop.

Reference: [Model providers → Ollama](https://learn.microsoft.com/en-us/agent-framework/integrations/by-component/model-providers/ollama?tabs=ollama-openai&pivots=programming-language-python)

## What this step covers

- **`OpenAIChatClient`** — the framework's wrapper around an OpenAI-compatible
  endpoint. It is configured with the same three things you used by hand:
  `api_key`, `base_url`, `model`.
- **`Agent`** — bundles a client with a `name` and `instructions`. The
  instructions are the system prompt, kept as a reusable property instead of a
  message you rebuild on every call.
- **`agent.run(...)`** — async. It sends the prompt, awaits the model, and
  returns a response object rather than a raw HTTP body.
- **`asyncio.run(main())`** — the framework's public API is async, so the entry
  point has to be wrapped.

What you are *not* writing here: no session handling, no tool plumbing, no
retry logic. That arrives in the next three steps.

## Create the file

`touch first_agent.py`{{exec}}

```python
import asyncio

from agent_framework import Agent
from agent_framework.openai import OpenAIChatClient


async def main():
    agent = Agent(
        client=OpenAIChatClient(
            api_key="ollama",  # Placeholder, Ollama doesn't require an API key
            base_url="http://localhost:11434/v1",
            model="qwen2.5-coder:1.5b",
        ),
        name="HelpfulAssistant",
        instructions="You are a helpful assistant running locally via Ollama.",
    )
    result = await agent.run("What is the largest city in France?")
    print(result)


if __name__ == "__main__":
    asyncio.run(main())
```{{copy}}

## Run it

`python first_agent.py`{{exec}}

Expected output — the city name, wrapped in a response object. The wrapper is
the difference from step 1: you get a structured result you can inspect
(`result.text`, messages, usage) instead of a dict you index into.

```
Paris
```

If you see a connection error instead, the Ollama server is not running:

`curl http://localhost:11434/`{{exec}}

## What you learned

- An agent is a client plus a name plus instructions — there is no hidden magic.
- `instructions` replaces the system message you wrote by hand in step 1.
- `run()` is async, so `asyncio.run()` is now part of the boilerplate.
- Each `run()` here is stateless. Ask it your name and it forgets — step 4 fixes
  that with sessions.
