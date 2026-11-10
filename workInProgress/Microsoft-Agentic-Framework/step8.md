# Host Your Agent with Gradio

Everything so far ran in a terminal and printed to stdout. Hosting means putting
the agent behind an interface someone else can reach — the first step toward the
OpenAI-compatible endpoints Microsoft documents for self-hosting.

Reference: [Self-hosting → OpenAI endpoints](https://learn.microsoft.com/en-us/agent-framework/hosting/self-hosting/openai-endpoints?tabs=dotnet-cli%2Cuser-secrets&pivots=programming-language-python)

## What this step covers

- **`gr.ChatInterface`** — a ready-made chat page. You give it one async function
  and Gradio handles the history, the input box and the streaming UI.
- **`_to_agent_messages`** — Gradio hands over history as a list of dicts; the
  framework wants `Message` objects. This adapter is the only glue code in the
  step, and it is the part that breaks first when Gradio changes its chat schema.
- **Statelessness by design** — the full history is rebuilt and sent on every
  turn instead of using a session. Simple and correct, but it costs tokens: the
  prompt grows with the conversation.
- **`app.queue()`** — queues concurrent requests so two learners hitting the page
  at once do not interleave into one agent.
- **`server_name="0.0.0.0", server_port=7860`** — binds to all interfaces and the
  standard Gradio port so the Killercoda preview proxy can reach it.

## Install Gradio

? remove this?

`uv pip install gradio autogen-agentchat autogen-ext`{{exec}}

`export OPENAI_API_KEY="your-api-key-here"`

## Create the file

`touch gradio_app.py`{{exec}}

```python
"""Gradio chat UI backed by the Microsoft Agent Framework.

Uses the same framework and local Ollama setup as first_agent.py,
agent_harness.py, agent_memory.py, and first_workflow.py.
"""

import gradio as gr

from agent_framework import Agent, Message
from agent_framework.openai import OpenAIChatClient

# Same local Ollama client setup as the other scripts in this folder.
agent = Agent(
    client=OpenAIChatClient(
        api_key="ollama",  # Placeholder, Ollama doesn't require an API key
        base_url="http://localhost:11434/v1",
        model="qwen2.5-coder:1.5b",
    ),
    name="MathWizard",
    instructions=(
        "You are a brilliant, playful math tutor. "
        "Explain things using emojis and simple breakdowns."
    ),
)


def _to_agent_messages(history: list[dict], message: str) -> list[Message]:
    """Convert Gradio's chat history into Agent Framework messages."""
    messages = [
        Message(role=turn.get("role", "user"), contents=turn["content"])
        for turn in history
        if isinstance(turn.get("content"), str) and turn["content"]
    ]
    messages.append(Message(role="user", contents=message))
    return messages


async def chat_with_agent(message: str, history: list[dict]) -> str:
    """Run the Microsoft Agent Framework agent and return its reply."""
    try:
        response = await agent.run(messages=_to_agent_messages(history, message))
        return response.text
    except Exception as exc:
        return f"⚠️ Error: {exc}. Please check that the local Ollama server is running."


# docs: https://gradio.app/docs/gradio/chatinterface
app = gr.ChatInterface(
    fn=chat_with_agent,
    title="🧙‍♂️ Microsoft Agent Framework Meet Gradio",
    description="Ask your local agent anything! Powered by the Microsoft Agent Framework and Ollama.",
    # type="messages"  # newer Gradio conversational schema
)

if __name__ == "__main__":
    app.queue().launch(server_name="0.0.0.0", server_port=7860)
```{{copy}}

## Run it

`python gradio_app.py`{{exec}}

The terminal prints a local URL — `http://0.0.0.0:7860`. Open port 7860 through
the Killercoda tab or preview, then ask something like *"why is 0.1 + 0.2 not
0.3?"* and watch the tutor persona answer in character.

The `try/except` around the call exists so a dead Ollama server shows as a
readable chat message instead of a stack trace in a browser console.

## What you learned

- Gradio turns one async function into a chat UI with almost no code.
- Adapting Gradio's history to framework `Message` objects is the real work.
- Resending full history works but scales badly — session or memory handles it.
- `0.0.0.0` plus a fixed port is what makes the app reachable from outside the
  container.

---

`uv run main.py`{{exec}}
