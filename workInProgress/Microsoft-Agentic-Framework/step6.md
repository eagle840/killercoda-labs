# Workflows

taken from https://learn.microsoft.com/en-us/agent-framework/get-started/workflows?pivots=programming-language-python

`touch wokflow.py`{{exec}}


```python
import asyncio

from agent_framework import WorkflowBuilder, WorkflowContext, executor
from typing_extensions import Never


@executor(id="upper_case")
async def upper_case(text: str, ctx: WorkflowContext[str]) -> None:
    await ctx.send_message(text.upper())


@executor(id="reverse_text")
async def reverse_text(text: str, ctx: WorkflowContext[Never, str]) -> None:
    await ctx.yield_output(text[::-1])


async def main() -> None:
    workflow = WorkflowBuilder(start_executor=upper_case).add_edge(upper_case, reverse_text).build()
    result = await workflow.run("hello world")
    print(result.get_outputs()[0])


if __name__ == "__main__":
    asyncio.run(main())
```

`python wokflow.py`{{exec}}