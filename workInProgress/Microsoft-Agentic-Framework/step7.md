# Agent Harness

taken from: https://learn.microsoft.com/en-us/agent-framework/get-started/harness?pivots=programming-language-python


`touch harness.py`{{exec}}

```python
import asyncio

from agent_framework import create_harness_agent
from agent_framework.foundry import FoundryChatClient
from azure.identity import AzureCliCredential


async def main() -> None:
    agent = create_harness_agent(
        client=FoundryChatClient(
            project_endpoint="https://your-account.services.ai.azure.com/api/projects/your-project",
            model="gpt-6-luna",
            credential=AzureCliCredential(),
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
