# Multi-Turn Conversations

Every `run()` so far started from nothing — the model never saw your previous
message. A **session** is the object that carries conversation state between
calls.

Reference: [Multi-turn conversations](https://learn.microsoft.com/en-us/agent-framework/get-started/multi-turn?pivots=programming-language-python)

## What this step covers

- **`agent.create_session()`** — creates one conversation. The agent definition
  (client, instructions, tools) stays reusable; the session holds the history.
- **`session=session`** — passing the same session to two `run()` calls is what
  makes the second call aware of the first. Drop the argument and the memory
  disappears.
- **Session state lives in memory** — restarting the process starts a new
  conversation, and nothing is shared between two different sessions. For
  memory that outlives the process, see step 5.
- **The instructions change** — `Keep your answers brief` is added so two
  responses fit on one screen and are easy to compare.

## Create the file

`touch multi_turn_agent.py`{{exec}}

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
        instructions="You are a friendly assistant. Keep your answers brief.",
    )

    session = agent.create_session()

    print(await agent.run("My name is Alice and I love hiking.", session=session))
    print(await agent.run("What do you remember about me?", session=session))


if __name__ == "__main__":
    asyncio.run(main())
```{{copy}}

## Run it

`python multi_turn_agent.py`{{exec}}

Expected output — the second answer knows both facts from the first message:

```
Nice to meet you, Alice! Hiking is a great way to get outside.
You told me your name is Alice and that you love hiking.
```

## Prove the session is doing the work

Remove `session=session` from the second call and run the file again. The same
model, same instructions, same process — it now has no idea who Alice is. That
single argument is the entire difference between the two behaviours.

## What you learned

- A session holds conversation history; the agent holds configuration.
- Session state is in-process and per-session, so it is lost on restart.
- `create_session()` is cheap — one per user, per thread, or per workflow run.
- Without a session, `run()` is a one-shot question every time.
