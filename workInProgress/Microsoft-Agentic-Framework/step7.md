# Agent Harness

taken from: https://learn.microsoft.com/en-us/agent-framework/get-started/harness?pivots=programming-language-python


`touch harness.py`{{exec}}

```python
import asyncio

from agent_framework import create_harness_agent
from agent_framework.openai import OpenAIChatClient 
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

`python harness.py`{{exec}}
