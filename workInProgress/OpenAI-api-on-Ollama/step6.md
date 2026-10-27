# Step 6: Responses API

Ollama also provides the `/v1/responses` endpoint for the newer OpenAI Responses API. Let's compare it with Chat Completions.

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

## Compare with Chat Completions

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

## Notes

- Ollama's `/v1/responses` support depends on your Ollama version. If you encounter errors, make sure you're running a recent version of Ollama.
- Some features (like advanced reasoning formats or certain tool schemas) may behave differently between the two APIs.
- For most simple use cases, both work with Ollama's OpenAI compatibility layer.

**What you learned:** Explored the Responses API and compared its structure with Chat Completions, understanding the tradeoffs and limitations.
