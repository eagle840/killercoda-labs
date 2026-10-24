# Step 2





# documentation

see https://learn.microsoft.com/en-us/agent-framework/integrations/by-component/model-providers/ollama?tabs=ollama-openai&pivots=programming-language-python


Looks like second 2.ll of the page gives clear instructions on using ollama https://techcommunity.microsoft.com/blog/azuredevcommunityblog/engineering-a-local-first-agentic-podcast-studio-a-deep-dive-into-multi-agent-or/4482839
---

### reasoning models

Small reasoning models that run well on CPU-only setups via Ollama range from ultra-lightweight speedsters to higher-quality compact powerhouses:

Top Small CPU-Friendly Reasoning & General Models

• Phi-4-Mini (3.8B / Q4)   
	• Ollama Command: ollama run phi4-mini (or similar variant)   
	• RAM Needed: ~3 to 4 GB   
	• Performance: Widely regarded as the best overall quality and reasoning balance for tight CPU constraints, achieving roughly 7–15 tokens per second depending on your CPU.   
• Llama 3.2 (3B / Q4)   
	• Ollama Command: ollama run llama3.2:3b   
	• RAM Needed: ~4 GB    
	• Performance: A reliable, balanced choice for general chat, light coding, and instruction-following on modest hardware.   
• Qwen3 (0.6B to 1.7B variants)   
	• Ollama Command: ollama run qwen3:0.6b or ollama run qwen3:1.7b   
	• RAM Needed: 2 GB or less   
	• Performance: Extremely fast on CPU (reaching 25–35+ tokens per second on modern i5/Ryzen chips), though multi-step and deep logical reasoning will be noticeably weaker than larger 3B–4B classes.   
• Gemma 3 (1B)   
	• Ollama Command: ollama run gemma3:1b   
	• RAM Needed: ~2 GB    
	• Performance: Very snappy speed (~19 tok/s on CPU) for basic queries, though structured or complex reasoning tasks can feel brittle.   

### Quick Guidelines for CPU-Only Ollama

• RAM Rule: Plan for the GGUF file size plus roughly 500 MB of system RAM overhead. A 2.3 GB model needs at least 3 GB of free RAM.    
• Quantization: Stick to 4-bit (Q4_K_M) quantizations to keep memory bandwidth and latency manageable on a CPU.   
• Check Status: Run ollama ps in your terminal to verify that your model isn't struggling with memory swapping or excessive context overhead.   
If you let me know how much system RAM you have and what kind of reasoning tasks (math, logic, coding, or text extraction) you want to run, I can recommend the exact right model size for your machine.


docs on using ollama with msfw https://learn.microsoft.com/en-us/agent-framework/integrations/by-component/model-providers/ollama?tabs=ollama-openai&pivots=programming-language-python


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

