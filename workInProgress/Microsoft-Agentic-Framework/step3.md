# Step 3 Add tools

add `from agent_framework import Agent, tool`

add the tool

```python
# This read-only sample tool can run without approval.
@tool(approval_mode="never_require")
def get_weather(location: str) -> str:
    """Get the weather for a given location."""
    return f"The weather in {location} is sunny."
```

add the tool under the instruction
```python
        instructions="Use the weather tool to answer questions.",
        tools=[get_weather],
```
and change the prompt

`print(await agent.run("What's the weather like in Seattle?"))`