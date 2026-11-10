# Give the Agent a Tool

A tool is a plain Python function the model is allowed to call. You describe it
with a type hint and a docstring; the framework turns that into a schema and
executes it when the model asks. You never write the call-dispatch loop.

## What this step covers

- **`@tool` decorator** — marks a function as callable by the model. The
  function's name, type hints and docstring *are* the tool definition, so a
  vague docstring means a tool the model will not use correctly.
- **`approval_mode="never_require"`** — auto-approves the call. Correct for a
  read-only lookup like weather; anything that writes, spends money or deletes
  should stay gated.
- **`tools=[get_weather]`** — registers the tool on the agent. This is the only
  wiring needed.
- **The tool round-trip** — the model replies with a tool call, the framework
  runs `get_weather`, feeds the result back, and the model answers. One
  `agent.run()` covers all of it, which is why the output is a sentence and not
  a function-call object.

## Create the file

`touch agent_with_tools.py`{{exec}}

This is step 2's agent plus two additions — the decorated function, and the
`tools=` argument:

```python
import asyncio

from agent_framework import Agent, tool
from agent_framework.openai import OpenAIChatClient


# This read-only sample tool can run without approval.
@tool(approval_mode="never_require")
def get_weather(location: str) -> str:
    """Get the weather for a given location."""
    return f"The weather in {location} is sunny."


async def main():
    agent = Agent(
        client=OpenAIChatClient(
            api_key="ollama",  # Placeholder, Ollama doesn't require an API key
            base_url="http://localhost:11434/v1",
            model="qwen2.5-coder:1.5b",
        ),
        name="HelpfulAssistant",
        instructions="Use the weather tool to answer questions.",
        tools=[get_weather],
    )

    result = await agent.run("What's the weather like in Seattle?")
    print(result)


if __name__ == "__main__":
    asyncio.run(main())
```{{copy}}

## Run it

`python agent_with_tools.py`{{exec}}

Expected output — note the agent never invented a temperature. The only fact
available is what your function returned, so that is all it can report:

```
The weather in Seattle is sunny.
```

## If the tool is ignored

Small models are unreliable at tool calling. Two things to try, in order:

1. Make the instruction explicit — `Use the weather tool to answer questions.`
   is doing real work here, not decoration.
2. Switch to a model with better tool support, for example
   `ollama run llama3.1:8b`, and change `model=` to match.

The framework is not the problem in that case; the model's function-calling
ability is.

## What you learned

- A tool is a typed function plus a docstring. There is no separate schema file.
- `approval_mode` decides whether a call runs automatically or waits for a human.
- One `run()` can contain several internal model turns — the tool loop is hidden.
- Tool reliability is a property of the model, so instruction wording matters.
