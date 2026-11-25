# Step 5: Build a Local LLM Chat App

You have a Gradio project, a local model, and a working OpenAI-compatible endpoint. Now connect them.

In this step you will replace the Text Stats app with a streaming chatbot built on `gr.ChatInterface`.

## Write the chat app

Stop the current app and create `chat_app.py`:

```bash
cd ~/gradio-lab
cat > chat_app.py <<'EOF'
import os

os.environ.setdefault("GRADIO_ANALYTICS_ENABLED", "False")

import gradio as gr
from openai import OpenAI

MODEL = "tinyllama"

SYSTEM_PROMPT = (
    "You are a concise teaching assistant. "
    "Answer in at most three short sentences."
)

client = OpenAI(
    base_url="http://localhost:11434/v1/",
    api_key="ollama",  # required by the SDK, ignored by Ollama
)


def content_to_text(content):
    """Normalize Gradio message content into a plain string."""
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        parts = []
        for part in content:
            if isinstance(part, dict) and part.get("type") == "text":
                parts.append(part.get("text", ""))
            elif isinstance(part, str):
                parts.append(part)
        return " ".join(parts)
    return str(content)


def build_messages(history, message):
    """Convert Gradio history into OpenAI chat messages."""
    messages = [{"role": "system", "content": SYSTEM_PROMPT}]

    for turn in history:
        if isinstance(turn, dict):
            # Current Gradio format: {"role": ..., "content": ...}
            role = turn.get("role")
            if role in ("user", "assistant"):
                messages.append(
                    {"role": role, "content": content_to_text(turn.get("content", ""))}
                )
        elif isinstance(turn, (list, tuple)) and len(turn) == 2:
            # Older tuple format: (user_message, assistant_message)
            user_message, assistant_message = turn
            if user_message:
                messages.append(
                    {"role": "user", "content": content_to_text(user_message)}
                )
            if assistant_message:
                messages.append(
                    {"role": "assistant", "content": content_to_text(assistant_message)}
                )

    messages.append({"role": "user", "content": content_to_text(message)})
    return messages


def chat(message, history):
    response = client.chat.completions.create(
        model=MODEL,
        messages=build_messages(history, message),
        temperature=0.7,
        max_tokens=200,
        stream=True,
    )

    reply = ""
    for chunk in response:
        delta = chunk.choices[0].delta.content or ""
        if delta:
            reply += delta
            yield reply

    if not reply:
        yield "The model returned an empty response. Try a shorter question."


demo = gr.ChatInterface(
    fn=chat,
    title="TinyLlama + Gradio",
    description=(
        "A fully local chatbot: Gradio to OpenAI SDK to Ollama to TinyLlama. "
        "Responses stream from a CPU-only model, so please be patient."
    ),
    examples=[
        "What is Gradio in one sentence?",
        "Why would I use uv instead of pip?",
        "Give me one idea for a Gradio demo.",
    ],
    api_name="chat",
)

demo.launch(server_name="0.0.0.0", server_port=7860)
EOF
```{{exec interrupt}}

What the code does:

- `gr.ChatInterface` builds the chat UI, message box, examples, and submit/stop handling.
- `chat()` is a **generator**. Each `yield` sends the partial reply, so the user sees tokens as they are produced instead of waiting for the full answer.
- `build_messages()` converts Gradio's history format into the OpenAI `messages` format.
- `max_tokens=200` keeps CPU inference reasonably quick for a lab.
- `api_name="chat"` exposes the chatbot at `/chat` for programmatic clients.

## Run the chatbot

Start it in the background:

```bash
cd ~/gradio-lab
uv run python chat_app.py
```{{exec}}



Open the chatbot:

**[Open the TinyLlama chatbot]({{TRAFFIC_HOST1_7860}})**

Try the example prompts, or ask your own question. The first reply may take a while because Ollama must load the model into memory. Watch the text appear token by token.



## A one-line alternative

Gradio can wrap any OpenAI-compatible chat endpoint with `gr.load_chat`. This is a useful shortcut once you understand the pieces:

```python
import gradio as gr

gr.load_chat(
    "http://localhost:11434/v1/",
    model="tinyllama",
    token="ollama",
).launch(server_name="0.0.0.0", server_port=7861)
```{{copy}}

Do not run this now: a custom chat function gives you control over the system prompt, history, and token limits, which is why the lab builds `chat_app.py` by hand.



You have built a complete local LLM application. Proceed to the finish page for a summary and cleanup commands.
