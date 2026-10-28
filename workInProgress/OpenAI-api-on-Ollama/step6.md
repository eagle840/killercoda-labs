# Step 6: Responses API

Ollama also provides the `/v1/responses` endpoint for the newer OpenAI Responses API. Let's compare it with Chat Completions.

The **Responses API** is OpenAI's newer surface: you pass one `input` (a string, or a list of typed items) instead of a `messages` array, and you get back a list of typed `output` items. It's the one that keeps growing — built-in tools, server-side conversation state, reasoning items — where Chat Completions is essentially frozen.

## Basic Responses API Call

Create `responses_api.py`:

```bash
cat > responses_api.py << 'PY'
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama",
)

response = client.responses.create(
    model="qwen2.5:3b-instruct",
    input="Explain the difference between REST and GraphQL in 2-3 sentences.",
)

print(response.output_text)
PY
```{{execute}}

Run it:

```bash
uv run python responses_api.py
```{{execute}}

`response.output` is that list of items; **`output_text`** is a convenience property that concatenates just the assistant's text so you don't walk the structure yourself.

## Compare with Chat Completions

Same question, same model — only the request and response shapes differ, which is the whole point of the comparison.

Create `compare_apis.py`:

```bash
cat > compare_apis.py << 'PY'
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama",
)

# Chat Completions
chat_response = client.chat.completions.create(
    model="qwen2.5:3b-instruct",
    messages=[{"role": "user", "content": "What is Ollama?"}],
)
print("=== Chat Completions ===")
print(chat_response.choices[0].message.content)
print(f"\nResponse object: choices[0].message.content\n")

# Responses API
resp_response = client.responses.create(
    model="qwen2.5:3b-instruct",
    input="What is Ollama?",
)
print("\n=== Responses API ===")
print(resp_response.output_text)
print(f"\nResponse object: output_text")
PY
```{{execute}}

Run it:

```bash
uv run python compare_apis.py
```{{execute}}

## Key Differences

| Aspect | Chat Completions | Responses API |
| --- | --- | --- |
| Method | `client.chat.completions.create()` | `client.responses.create()` |
| Input | `messages=[...]` with roles | `input="..."` or more structured input |
| Response | `response.choices[0].message.content` | `response.output_text` or `response.output` |
| Streaming | Supported via `stream=True` | Also supported, different event types |
| Tool Calling | Well-established, widely supported | Newer API, support varies by provider |
| Reasoning | Varies by model/implementation | Designed with reasoning in mind, but Ollama support may differ |

Rule of thumb: reach for **Chat Completions** when you want maximum compatibility — every OpenAI-style server and every Ollama version implements it. Reach for **Responses** when you're writing against OpenAI's current API and want the newer features, accepting that compatibility layers implement it partially.

## Notes

- The Ollama version you installed here exposes `/v1/responses`, so both examples should run as written.
- Some features (like advanced reasoning formats or certain tool schemas) may behave differently between the two APIs.
- For most simple use cases, both work with Ollama's OpenAI compatibility layer.

**What you learned:** Explored the Responses API and compared its structure with Chat Completions, understanding the tradeoffs and limitations.
