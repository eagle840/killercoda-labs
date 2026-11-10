# Memory & Persistence

A session remembers *this* conversation. Memory is about persisting facts
*between* turns regardless of how the conversation is sliced — and being able to
inject them back into the model's instructions on the next run.

Reference: [Memory](https://learn.microsoft.com/en-us/agent-framework/get-started/memory?pivots=programming-language-python)

## What this step covers

- **`ContextProvider`** — a hook object the agent calls around every run. It can
  read the inbound messages before the model sees them, and update state after
  it answers.
- **`before_run`** — runs before the model. It reads `state["user_name"]` and
  appends a line to the instructions via `context.extend_instructions(...)`. On
  the first run there is no name yet, so the agent is told to ask for one.
- **`after_run`** — runs after the model. It scans the user's messages, looks for
  the phrase `my name is`, and stores the next word in `state`, capitalised.
- **`state`** — a plain dict owned by the provider. Here it lives for the process
  only; write it to Redis or SQLite and you have durable memory with no other
  changes to the agent.
- **`context_providers=[...]`** — the same registration pattern as `tools=` in
  step 3.

The clever part is what is *not* happening: the stored name is not replayed as
chat history. It is folded into the instructions, so it survives even if the
session is replaced.

## Create the file

`touch agent_memory.py`{{exec}}

```python
import asyncio
from typing import Any

from agent_framework import Agent, AgentSession, ContextProvider, SessionContext
from agent_framework.openai import OpenAIChatClient


class UserMemoryProvider(ContextProvider):
    def __init__(self) -> None:
        super().__init__("user_memory")

    async def before_run(
        self,
        *,
        agent: Any,
        session: AgentSession | None,
        context: SessionContext,
        state: dict[str, Any],
    ) -> None:
        user_name = state.get("user_name")
        instructions = (
            f"The user's name is {user_name}. Address them by name." if user_name else "Ask for the user's name."
        )
        context.extend_instructions(self.source_id, instructions)

    async def after_run(
        self,
        *,
        agent: Any,
        session: AgentSession | None,
        context: SessionContext,
        state: dict[str, Any],
    ) -> None:
        for message in context.input_messages:
            text = message.text
            if not isinstance(text, str):
                continue
            _, marker, name = text.lower().partition("my name is")
            if marker and name.strip():
                state["user_name"] = name.split()[0].capitalize()


async def main() -> None:
    agent = Agent(
        client=OpenAIChatClient(
            api_key="ollama",  # Placeholder, Ollama doesn't require an API key
            base_url="http://localhost:11434/v1",
            model="qwen2.5-coder:1.5b",
        ),
        instructions="You are a friendly assistant.",
        context_providers=[UserMemoryProvider()],
    )
    session = agent.create_session()

    print(await agent.run("Hello! What's the square root of 9?", session=session))
    print(await agent.run("My name is Alice", session=session))
    print(await agent.run("What is 2 + 2?", session=session))


if __name__ == "__main__":
    asyncio.run(main())
```{{copy}}

## Run it

`python agent_memory.py`{{exec}}

The three answers show the state machine working:

1. **Run 1** — no name in `state`, so the agent is instructed to ask for one and
   answers the maths question as well.
2. **Run 2** — `after_run` catches `my name is Alice` and writes `Alice` into
   `state`.
3. **Run 3** — `before_run` now injects `The user's name is Alice`, so the reply
   greets you by name even though the last message was about arithmetic.

Expected shape:

```
3, and what should I call you?
Nice to meet you, Alice!
4, Alice.
```

The exact wording varies with the model. What matters is that the third answer
contains the name, and the second was the only place it was ever given.

## What you learned

- `ContextProvider` gives you before/after hooks around every model call.
- Memory belongs in instructions, history, or an external store — the provider
  decides which.
- `state` is a dict you can back with Redis or a database for persistence.
- Extraction here is a naive `partition("my name is")`. That is a demo, not
  production parsing — a real extractor would use an LLM call or structured
  output, and would validate what it stored.
