# Step 3: Simple Chat Completions

Now let's use the OpenAI SDK with Ollama's OpenAI-compatible endpoint.

## Create a Basic Chat Completion

Create `simple_chat.py`:

```bash
cat > simple_chat.py << 'PY'
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama",  # Any string works
)

response = client.chat.completions.create(
    model="qwen2.5:3b-instruct",
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "Explain what an API is in one sentence."},
    ],
    temperature=0.7,
)

print(response.choices[0].message.content)
PY
```{{execute}}

Run it:

```bash
uv run python simple_chat.py
```{{execute}}

## Streaming Chat Completion

Create `simple_chat_stream.py`:

```bash
cat > simple_chat_stream.py << 'PY'
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama",
)

stream = client.chat.completions.create(
    model="qwen2.5:3b-instruct",
    messages=[
        {"role": "system", "content": "You are a concise assistant."},
        {"role": "user", "content": "List three benefits of using local LLMs."},
    ],
    temperature=0.7,
    stream=True,
)

for chunk in stream:
    if chunk.choices[0].delta.content:
        print(chunk.choices[0].delta.content, end="", flush=True)
print()
PY
```{{execute}}

Run it:

```bash
uv run python simple_chat_stream.py
```{{execute}}

**What you learned:** Used `client.chat.completions.create()` with Ollama, tried different parameters, and implemented streaming responses.
