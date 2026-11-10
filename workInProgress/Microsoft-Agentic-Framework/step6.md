# Deterministic Workflows

Agents decide their own path — great for open-ended questions, wrong for
pipelines that must run in a fixed order. A **workflow** is the opposite
primitive: you declare the graph, the framework executes it, no model involved.

Reference: [Workflows](https://learn.microsoft.com/en-us/agent-framework/get-started/workflows?pivots=programming-language-python)

## What this step covers

- **`@executor`** — turns an async function into a node in the graph. The `id=`
  label is what appears in traces.
- **`ctx.send_message(...)`** — passes a value to the next node.
- **`ctx.yield_output(...)`** — marks a final result. The type signature
  `WorkflowContext[Never, str]` says "sends nothing onward, yields a string",
  which is how the graph knows this is a terminal node.
- **`WorkflowBuilder(start_executor=...).add_edge(a, b)`** — builds the graph:
  start at `upper_case`, then feed it into `reverse_text`.
- **No LLM here at all.** That is the point. Once behaviour must be predictable
  and testable, you want this shape rather than a prompt asking the model to
  "please uppercase then reverse".

## Create the file

`touch first_workflow.py`{{exec}}

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
```{{copy}}

## Run it

`python first_workflow.py`{{exec}}

Expected output — uppercase first, then reversed:

```
DLROW OLLEH
```

Trace it by hand to confirm the order: `hello world` → `HELLO WORLD` → reversed.

## What you learned

- Executors are async functions wired into a graph; output flows along edges.
- `yield_output` marks a terminal node, and typed context keeps the wiring
  honest.
- Workflows are deterministic and need no model, which makes them testable in a
  way an agent is not.
- The real value appears when a node *is* an agent call — the graph gives you
  order and error handling around the non-deterministic parts.
