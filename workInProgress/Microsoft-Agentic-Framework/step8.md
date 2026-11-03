# Host Your Agent


## Self Hosting documentation on MS

https://learn.microsoft.com/en-us/agent-framework/hosting/self-hosting/openai-endpoints?tabs=dotnet-cli%2Cuser-secrets&pivots=programming-language-python

? remove this?

`uv add gradio autogen-agentchat autogen-ext`{{exec}}

`export OPENAI_API_KEY="your-api-key-here"`


## Opencode Generated

`touch gradio_app.py`{{exec}}

```python
"""Gradio chat UI backed by the Microsoft Agent Framework.

Uses the same framework and local Ollama setup as foundry.py, harness.py,
memory.py, and wokflow.py.
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


# dosc: https://gradio.app/docs/gradio/chatinterface
app = gr.ChatInterface(
    fn=chat_with_agent,
    title="🧙‍♂️ Microsoft Agent Framework Meet Gradio",
    description="Ask your local agent anything! Powered by the Microsoft Agent Framework and Ollama.",
    # need to import the messages object in here
    # type="messages" # Optimized for newer Gradio conversational schemas
)

if __name__ == "__main__":
    app.queue().launch(server_name="0.0.0.0", server_port=7860))
  

```{{copy}}

`python gradio_app.py`{{exec}}


---



`uv run main.py`{{exec}}