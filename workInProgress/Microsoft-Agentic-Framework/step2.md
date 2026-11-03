# Step 2





# documentation


see 
- [docs](https://learn.microsoft.com/en-us/agent-framework/integrations/by-component/model-providers/ollama?tabs=ollama-openai&pivots=programming-language-python)


Looks like second 2-ll of the page gives clear instructions on using ollama 
- [link](https://techcommunity.microsoft.com/blog/azuredevcommunityblog/engineering-a-local-first-agentic-podcast-studio-a-deep-dive-into-multi-agent-or/4482839)


---



docs on using ollama with msfw https://learn.microsoft.com/en-us/agent-framework/integrations/by-component/model-providers/ollama?tabs=ollama-openai&pivots=programming-language-python

## Create a simple Agent

`touch step2.py`{{exec}}


```python
import asyncio
import os
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

asyncio.run(main())
```{{copy}}

`python step2.py`{{exec}}
