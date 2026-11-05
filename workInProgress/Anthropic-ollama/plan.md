# Plan: "Killacoda" lab — Anthropic Python SDK (via Ollama)

## Context

Goal: an interactive, Katacoda-style lab that teaches the Anthropic Python SDK end to end, running against a local Ollama instance. Ollama's Anthropic-compatible endpoint is the "live" backend; recorded fixtures cover the features Ollama doesn't implement. Ollama setup stays deliberately minimal — one client constructor, one model.

---

## Current state of the repo

```
/root/test/
├── .venv/          # uv-created venv (prompt "test")
└── test1.py        # working hello-world against Ollama
```

- Python **3.12.3** (`/usr/bin/python3`)
- `uv` **0.13.7** at `/root/.local/bin/uv`
- `anthropic` **2.5.0** installed; no `pyproject.toml` — plain venv, not a uv project
- Ollama running at `http://localhost:11434`
- Model: `qwen2.5-coder:1.5b` (986 MB, the only model pulled)

Installed packages of note: `anthropic`, `pydantic` 2.14.2, `httpx2` 2.16.0, `httpcore2`, `opentelemetry-api`.

### Existing code (working — the lab's "Module 0" baseline)

`/root/test/test1.py`:

```python
import anthropic

client = anthropic.Anthropic(
    base_url='http://localhost:11434',
    api_key='ollama',  # required but ignored
)

message = client.messages.create(
    model='qwen2.5-coder:1.5b',
    max_tokens=1024,
    messages=[
        {'role': 'user', 'content': 'Hello, how are you?'}
    ]
)
print(message.content[0].text)
```

Verified output path: `Message.content` is a list of blocks; `[0].text` holds the reply. `api_key` is required by the SDK but ignored by Ollama.

---

## Verified compatibility matrix (probed against this exact setup)

| SDK feature | Result on Ollama | Lab treatment |
|---|---|---|
| `messages.create` | Works | Live |
| `system=` top-level param | Works | Live |
| Multi-turn `messages` list | Works | Live |
| `messages.stream` / `text_stream` | Works; emits `message_start`, `content_block_start`, `content_block_delta`, `content_block_stop`, `message_delta`, `message_stop` | Live |
| `models.list()` | Works; returns the installed model | Live |
| `count_tokens` | `404 Not Found` | Mocked |
| Tool use (`tools=[...]`) | Tool JSON comes back as a **text block** with `stop_reason="end_turn"` — no `tool_use` block | Mocked (or live if a tool-capable model is pulled) |
| `output_config.format` / `messages.parse` | Not implemented | Mocked |
| Prompt caching (`cache_control`) | Reports `cache_read_input_tokens`, but no real `cache_control` semantics | Mocked / "API tour" |
| Batches, Files | Not implemented | Mocked / "API tour" |
| Async (`AsyncAnthropic`) | Works (Ollama handles concurrency) | Live |
| `with_raw_response` | Works (headers exposed) | Live |
| Prefill (assistant-last turn) | Rejected by the Ollama-compatible backend | Controlled failure demo |

### SDK 2.5.0 gotchas to call out in the lab

1. **`temperature` / `top_p` / `top_k` are gone** from `messages.create`. Sampling is exposed as `output_config.effort` (`"low" | "medium" | "high" | "xhigh" | "max"`). Nearly every online tutorial is now wrong about this.
2. **Structured output** is `messages.parse(..., output_format=...)` or `messages.create(output_config={"format": ...})` — not `output_format=` on `create`.
3. **`max_tokens` is required** (not optional). `max_tokens=0` pre-warms the prompt cache (real Anthropic only).
4. **`api_key` is required** by the constructor even when the backend ignores it.
5. The constructor also accepts `timeout`, `max_retries`, `http_client`, `middleware`, `open_telemetry` — all useful teaching hooks.
6. The exception hierarchy is bigger than most tutorials suggest: `APIStatusError`, `RateLimitError`, `APIConnectionError`, `APITimeoutError`, `NotFoundError`, `OverloadedError`, `RetryableError`, etc.

---

## Design principles

1. **Teach the real SDK, mark the limits.** Every module carries a badge: `LIVE` (works on Ollama) or `MOCKED (Ollama limitation)`. Never silently skip a feature because the local backend can't serve it.
2. **One place to swap backends.** All modules import `get_client()` from `helpers/`. Switching to real Anthropic is a one-line env change.
3. **Mock at the transport layer**, not by monkeypatching methods — inject `http_client=httpx2.Client(transport=MockTransport(...))` so the real SDK serialization/parsing is exercised.
4. **Every exercise has a `verify` check** (pytest or a small assert script) so a Katacoda step can grade itself.
5. **Minimal Ollama surface.** One `ollama pull`, one host URL, no model juggling in the main path.

---

## Proposed repo layout

```
anthropic-lab/
├── README.md                  # lab index + badge legend
├── pyproject.toml             # uv project (or keep script-mode, see uv section)
├── .env.example               # ANTHROPIC_BASE_URL, ANTHROPIC_API_KEY, ANTHROPIC_MODEL
├── labs/
│   ├── 00-setup/
│   │   ├── README.md
│   │   ├── exercise.py
│   │   └── verify.py
│   ├── 01-anatomy/
│   ├── ...
│   └── 12-capstone/
├── solutions/
│   └── 00-setup.py ...
├── fixtures/
│   ├── tool_use_response.json
│   ├── structured_output_response.json
│   ├── batch_create.json
│   └── stream_tool_use.sse
├── helpers/
│   ├── __init__.py
│   ├── client.py              # get_client(), env loading
│   ├── mock.py                # transport factory + fixture loader
│   └── inspect.py             # inspect_response(), usage summary
└── tests/
    └── test_labs.py           # runs every verify.py
```

---

## Module outline

### 0. Setup — `LIVE` (10 min)
Purpose: prove the environment works with the code already written.
- Read `test1.py`, run it, explain each argument.
- Concept: `base_url` makes Ollama speak the `/v1/messages` protocol; `api_key` is a dummy.
- Refactor into `helpers/client.py::get_client()` reading `ANTHROPIC_BASE_URL`, `ANTHROPIC_API_KEY`, `ANTHROPIC_MODEL`.
- Exercise: run the hello world through the helper.
- Verify: a `Message` is returned, `content[0].type == "text"`, text is non-empty.

### 1. Anatomy of a call — `LIVE` (20 min)
- Required params (`model`, `max_tokens`, `messages`); why `max_tokens` is mandatory.
- The `Message` object: `id`, `type`, `role`, `content`, `stop_reason`, `stop_sequence`, `usage`.
- `model_dump()` to see the raw JSON; `with_raw_response` for headers/request ID.
- Exercise: write `inspect_response(msg)` used by every later module (block types, stop reason, token counts).
- Verify: helper output matches a snapshot for a fixed prompt shape.

### 2. Conversation state & system prompts — `LIVE` (20 min)
- The API is stateless: you resend history on every call.
- `system=` is a top-level param, not a message with `role="system"`.
- Alternating turns; consecutive same-role messages get merged.
- Prefill: final message with `role="assistant"` — demo the failure on Ollama.
- Exercise: build a REPL loop that appends assistant replies to history.
- Verify: second turn recalls a fact from the first ("my name is Sam").

### 3. Streaming — `LIVE` (25 min)
- `client.messages.stream(...)` as a context manager; `text_stream`; `get_final_message()`.
- Raw event iteration: `message_start` → `content_block_start` → `content_block_delta` → `content_block_stop` → `message_delta` → `message_stop`.
- Where usage lives (`message_start` vs `message_delta`).
- Exercise: token printer, then a "collect and compare" check that streamed text equals the final message text.
- Verify: at least 2 `content_block_delta` events; final message non-empty.

### 4. Content blocks & multimodality — `MOCKED` (20 min)
- String shorthand vs explicit `[{"type": "text", ...}]`.
- Image blocks: base64 `source` vs URL `source`; ordering rules.
- Ollama's text-only model can't accept images → use a fixture to teach the request shape.
- Exercise: build a mixed text+image request and assert on the serialized body.
- Verify: body contains one `text` and one `image` block with the expected nested keys.

### 5. Tool use / the agent loop — `MOCKED` (45 min, the centerpiece)
Teach the protocol even though Ollama won't emit tool calls with the current model.
- Tool schema: `name`, `description`, `input_schema` (JSON Schema).
- `tool_choice`: `{"type": "auto"}`, `{"type": "any"}`, `{"type": "tool", "name": ...}`.
- Response side: `stop_reason == "tool_use"`, one or more `tool_use` blocks (`id`, `name`, `input`).
- Follow-up: append the assistant message verbatim, then a **user** message containing `tool_result` blocks (`tool_use_id`, `content`, `is_error`).
- Parallel tool calls in one response; loop termination and an iteration cap.
- SDK helpers worth showing: `anthropic.beta_tool`, `transform_schema` (present in 2.5.0).
- Exercise: calculator + fake `get_weather`; loop until `stop_reason == "end_turn"`; handle a deliberately failing tool with `is_error=True`.
- Verify: fixture-driven run produces exactly 2 tool calls and a final text answer.
- Optional live path: pull a tool-capable model (see Open Questions) and set `USE_TOOLS_LIVE=1`.

### 6. Structured output — `MOCKED` (20 min)
- `messages.parse(..., output_format=Model)` with a Pydantic model.
- `output_config={"format": {"type": "json_schema", ...}}` at the raw level.
- Validation failures and their effect on `stop_reason`.
- Exercise: extract a typed record from prose; fail gracefully on bad JSON.
- Verify: parsed object is a Pydantic instance with the expected field types.

### 7. Errors, retries, timeouts — `LIVE` (25 min)
- Exception hierarchy walk-through; `NotFoundError` from `count_tokens` as the live example.
- `Anthropic(timeout=..., max_retries=...)`, per-call `.with_options(...)`.
- What is retried automatically vs what isn't; idempotency concerns.
- Exercise: hit a bad model name, an unreachable port, and a slow endpoint; classify each exception; add a custom backoff wrapper.
- Verify: three distinct exception types caught and labelled.

### 8. Tokens, usage, cost — `PARTLY MOCKED` (20 min)
- `usage.input_tokens`, `output_tokens`, `cache_creation_input_tokens`, `cache_read_input_tokens`.
- `count_tokens` (mock it; 404 live) and offline-estimation caveats.
- Cost math against a small pricing table (mark prices as illustrative, not live).
- Exercise: a `Budget` guard that refuses a request whose estimate exceeds N.
- Verify: budget raises before the request is sent.

### 9. The scale APIs — `MOCKED` (30 min)
- Prompt caching: `cache_control: {"type": "ephemeral"}` on the system/last block; reading cache usage fields; TTL/breakpoint rules.
- Batches: `messages.batches.create`, polling `retrieve`, streaming `results` (JSONL).
- Files: `files.create` / upload, `file_id` references.
- Exercise: assert the outgoing body contains a `cache_control` marker; parse a fake batch results stream.
- Verify: body assertion + results parsed into 3 records.

### 10. Async & concurrency — `LIVE` (25 min)
- `AsyncAnthropic`, `await client.messages.create`, async streaming.
- `asyncio.gather` fan-out with a semaphore; connection limits; result ordering.
- Exercise: run 5 prompts concurrently, max 2 in flight; report wall-clock time.
- Verify: all 5 complete; peak concurrency never exceeds 2.

### 11. Observability — `LIVE` (optional, 20 min)
- `with_raw_response` / `with_streaming_response` to read status and headers.
- `middleware` hooks for request/response logging and secret redaction.
- `open_telemetry` option; request IDs for support tickets.
- Exercise: log method, path, status, latency, request ID — with the API key redacted.

### 12. Capstone — `LIVE + MOCKED` (60 min)
A small CLI chat app combining:
- persistent history + streaming output,
- a cost meter fed by `usage`,
- retries/timeouts with graceful errors,
- a tool loop (fixture-backed unless a tool-capable model is available),
- a swappable client (`--live` vs `--mock`).

---

## Mocking strategy (so MOCKED modules still exercise real SDK code)

```python
# helpers/mock.py
import json
import httpx2
import anthropic

def mock_client(fixture_path: str, status: int = 200) -> anthropic.Anthropic:
    body = json.loads(open(fixture_path).read())

    def handler(request: httpx2.Request) -> httpx2.Response:
        # optional: assert on request.url.path / json body here
        return httpx2.Response(status, json=body)

    return anthropic.Anthropic(
        api_key="test",
        base_url="http://mock",
        http_client=httpx2.Client(transport=httpx2.MockTransport(handler)),
    )
```

For streaming fixtures, return an SSE `text/event-stream` body built from `fixtures/*.sse`.

Note: this SDK depends on **`httpx2`** (not plain `httpx`), so the mock transport must come from `httpx2`.

Fixtures to hand-author (using the real Anthropic response shapes):
- `tool_use_response.json` (two `tool_use` blocks, `stop_reason: "tool_use"`)
- `tool_result_followup.json` (`end_turn`, text answer)
- `structured_output_response.json`
- `batch_create.json`, `batch_results.jsonl`
- `stream_text.sse`, `stream_tool_use.sse`

---

## uv commands

The current folder is a plain venv (no `pyproject.toml`). Two viable setups:

### A. Keep the current script-mode layout (matches `/root/test` today)

```bash
cd /root/test

# create the venv (already done; prompt "test")
uv venv --python 3.12

# install / reinstall deps
uv pip install anthropic
uv pip install anthropic pytest python-dotenv

# inspect
uv pip list
uv pip show anthropic

# run scripts without activating the venv
uv run python test1.py

# freeze for reproducibility
uv pip freeze > requirements.txt
uv pip install -r requirements.txt
```

### B. Convert the lab into a uv project (recommended for the finished lab)

```bash
cd /root/anthropic-lab
uv init --python 3.12
uv add anthropic pydantic python-dotenv
uv add --dev pytest ruff

uv run python labs/00-setup/exercise.py
uv run pytest -q
uv lock            # writes uv.lock
uv sync            # recreate .venv exactly from the lock
```

### Ollama (minimal)

```bash
# only if the server isn't already running
ollama serve &

ollama pull qwen2.5-coder:1.5b
ollama list

# optional: one tool-capable model for a live Module 5
# ollama pull qwen3:1.7b        # exact tag TBD, see Open Questions
```

### Environment for the lab

```bash
# .env.example
ANTHROPIC_BASE_URL=http://localhost:11434
ANTHROPIC_API_KEY=ollama          # required by the SDK, ignored by Ollama
ANTHROPIC_MODEL=qwen2.5-coder:1.5b
USE_TOOLS_LIVE=0                  # set to 1 only with a tool-capable model
```

```python
# helpers/client.py
import os
import anthropic

def get_client() -> anthropic.Anthropic:
    return anthropic.Anthropic(
        base_url=os.environ.get("ANTHROPIC_BASE_URL", "http://localhost:11434"),
        api_key=os.environ.get("ANTHROPIC_API_KEY", "ollama"),
        max_retries=2,
        timeout=60.0,
    )
```

---

## Open questions

1. **Format** — Jupyter notebooks, or Katacoda-style markdown steps with `verify` scripts? (This plan assumes markdown + `verify.py`; notebooks would change the layout.)
2. **Audience** — SDK newcomers, or devs coming from the OpenAI SDK who want the mapping?
3. **Tool use** — pull one tool-capable model for a live Module 5, or keep a single-model install and mock it? `qwen2.5-coder:1.5b` does not produce `tool_use` blocks even on Ollama's native `/api/chat`.
4. **Version pin** — teach strictly against 2.5.0 (no `temperature`), or include a "docs drift" sidebar showing older idioms?
5. **Grading** — a pytest `verify.py` per module, or a single `tests/test_labs.py` runner?

---

## Suggested build order

1. `helpers/` (client, mock, inspect) + fixtures
2. Modules 0–3 (all LIVE — proves the environment and sets the pattern)
3. Modules 5 + 6 (MOCKED — establishes the fixture workflow)
4. Modules 7–10
5. Module 11 + capstone
6. Replace module READMEs with Katacoda/notebook front matter once the format is decided
