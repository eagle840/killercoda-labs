# The Agent Harness

`create_harness_agent` is a pre-built agent with the scaffolding already wired:
planning, file memory, web search, and a loop that keeps working until the task
is done. You supply the client and the instructions, and switch off the
capabilities this lab cannot support.

Reference: [Harness](https://learn.microsoft.com/en-us/agent-framework/get-started/harness?pivots=programming-language-python)

## What this step covers

- **`create_harness_agent`** — returns an `Agent` with a default harness rather
  than one you assembled by hand. Same interface: `create_session()` and `run()`.
- **`agent_instructions`** — the harness's own instruction parameter. Note it is
  named differently from `instructions` on a plain `Agent`; that is deliberate,
  because the harness layers its own system prompt underneath.
- **`disable_file_memory=True`** — stops the harness writing files into the
  container between runs.
- **`disable_web_search=True`** — this machine has no browsing tool configured,
  so leaving search on produces failures rather than results.
- **Two calls, one session** — planning then refining, which exercises the
  memory the harness keeps inside the session.

## Create the file

`touch agent_harness.py`{{exec}}

```python
import asyncio

from agent_framework import create_harness_agent
from agent_framework.openai import OpenAIChatClient


async def main() -> None:
    agent = create_harness_agent(
        client=OpenAIChatClient(
            api_key="ollama",  # Placeholder, Ollama doesn't require an API key
            base_url="http://localhost:11434/v1",
            model="qwen2.5-coder:1.5b",
        ),
        agent_instructions="Help users plan and complete multi-step tasks.",
        disable_file_memory=True,
        disable_web_search=True,
    )
    session = agent.create_session()

    print(await agent.run("Plan a weekend trip to Seattle.", session=session))
    print(await agent.run("Turn that plan into a checklist.", session=session))


if __name__ == "__main__":
    asyncio.run(main())
```{{copy}}

## Run it

`python agent_harness.py`{{exec}}

Expected output — a short plan, then the same plan as checkboxes:

```
Here is a plan: Day 1 Pike Place Market and the waterfront...
- [ ] Visit Pike Place Market
- [ ] Walk the waterfront
```

Be patient. A harness does more model turns per request than a bare agent, so on
a 1.5B CPU model this step is the slowest in the lab.

## If it is too slow or returns empty results

The harness assumes a capable model and a tool runtime. On this machine the
guaranteed-working option is to treat this step as a demonstration of the API
shape: read the code, note the four parameters, and move on. Dropping to
`qwen2.5-coder:1.5b` keeps it running but the planning quality is thin — that is
the model, not the harness.

## What you learned

- A harness agent is a plain `Agent` with defaults pre-populated.
- Capabilities you cannot support must be switched off explicitly; they are on
  by default.
- Harness instructions use `agent_instructions`, not `instructions`.
- Harness agents trade latency for autonomy — several model turns per request.
