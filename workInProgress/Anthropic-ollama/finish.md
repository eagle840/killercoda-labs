# You made it

You now have a working Anthropic Python SDK project running against a local Ollama model.

## What you built

- `/root/anthropic-lab` — a pinned `uv` project with `anthropic==2.5.0`.
- `.env` — one place for `ANTHROPIC_BASE_URL`, `ANTHROPIC_API_KEY` and `ANTHROPIC_MODEL`.
- `helpers/client.py` — a single `get_client()` / `get_model()` factory.
- `helpers/inspect.py` — `inspect_response()`, which every later module can reuse.
- `hello.py` and `anatomy.py` — a first call and a full response inspection.

## The ideas to keep

1. The SDK is an HTTP client for `POST /v1/messages`. `base_url` is the only thing that makes
   it talk to Ollama instead of Anthropic.
2. `model`, `max_tokens` and `messages` are required; `max_tokens` is mandatory in 2.5.0.
3. A response is a `Message` whose `content` is a **list of blocks**.
4. `stop_reason` distinguishes a finished answer (`end_turn`) from a truncated one
   (`max_tokens`).
5. `model_dump()` and `with_raw_response` are the two debugging views you will reach for
   first.

## Where this lab goes next

The remaining modules are planned as:

- streaming and event order,
- content blocks and multimodality (mocked, because the local model is text-only),
- tool use and the agent loop,
- structured output with `messages.parse()`,
- errors, retries and timeouts,
- usage, cost and token counting,
- prompt caching, batches and files,
- async and concurrency,
- observability,
- a capstone CLI chat app.

## Cleaning up

Everything runs inside the disposable Killercoda VM. To stop the model server early:

```bash
pkill -f "ollama serve"
```{{exec}}

Otherwise, just close the tab — the sandbox is destroyed for you.

## Further reading

- Anthropic Python SDK: <https://github.com/anthropics/anthropic-sdk-python>
- Anthropic Messages API: <https://docs.anthropic.com/en/api/messages>
- Ollama: <https://ollama.com>
