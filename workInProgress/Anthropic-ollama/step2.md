# Step 2 — Anatomy of a message (LIVE)

> **Badge: `LIVE`** — runs against Ollama in your sandbox.
>
> **Time:** ~20 minutes · **Prerequisites:** complete step 1.

In step 1 you read `message.content[0].text` and moved on. That works, but it hides almost
everything the API tells you. This step opens the response up: what you must send, what comes
back, and how to inspect it so later modules (streaming, tool use, cost tracking) can build
on it.

All commands assume you are still in `/root/anthropic-lab`. If you opened a new terminal:

```bash
cd /root/anthropic-lab
```{{exec}}

---

## 1. The three required parameters

Every call needs `model`, `max_tokens` and `messages`.

| Parameter | Required | What it controls |
|---|---|---|
| `model` | yes | Which Ollama tag answers the request. |
| `max_tokens` | **yes** | Hard upper bound on generated tokens. |
| `messages` | yes | The conversation: a list of `{"role", "content"}` turns. |
| `system` | no | Top-level system prompt. Not a message with `role="system"` — that is an error. |
| `stop_sequences` | no | Stop generating when one of these strings appears. |
| `output_config` | no | 2.5.0 home for effort and structured-output settings. |
| `tools` | no | Tool schemas, covered in a later module. |

`max_tokens` is not advisory. When the model reaches it, generation stops and the response
says so. Try it with a deliberately tiny budget:

```bash
uv run python - <<'PY'
from helpers.client import get_client, get_model

message = get_client().messages.create(
    model=get_model(),
    max_tokens=8,
    messages=[{"role": "user", "content": "Count from one to twenty."}],
)

print("stop_reason:", message.stop_reason)
print("text:", message.content[0].text)
PY
```{{exec}}

You should see a short, cut-off answer with `stop_reason: max_tokens`. That is the difference
between "the model finished" (`end_turn`) and "we stopped it" (`max_tokens`).

> **SDK 2.5.0 docs drift:** `temperature`, `top_p` and `top_k` are no longer accepted by
> `messages.create()`. Sampling is configured through `output_config` (for example
> `output_config={"effort": "low"}`). Most tutorials online still pass `temperature`. This is
> a deliberate API change, not a deprecation warning — the call fails.
>
> `max_tokens=0` is a special case used to pre-warm the prompt cache. It only has meaning on
> the real Anthropic API; Ollama ignores caching, so we do not use it here.

---

## 2. The `Message` object

Print the whole object and look at its shape:

```bash
uv run python - <<'PY'
from helpers.client import get_client, get_model

message = get_client().messages.create(
    model=get_model(),
    max_tokens=128,
    messages=[{"role": "user", "content": "Name two primary colours."}],
)

print(type(message).__module__, type(message).__name__)
print(repr(message))
PY
```{{exec}}

The important fields:

| Field | Type | Meaning |
|---|---|---|
| `id` | `str` | Identifier for this response, e.g. `msg_...`. Useful in support tickets and logs. |
| `type` | `str` | Always `"message"`. |
| `role` | `str` | Always `"assistant"` for a completion. |
| `content` | `list` | Content blocks. A text answer is one `TextBlock` with `.type == "text"` and `.text`. |
| `stop_reason` | `str \| None` | Why generation stopped: `end_turn`, `max_tokens`, `stop_sequence`, `tool_use`, `refusal`, `pause_turn`. |
| `stop_sequence` | `str \| None` | The matching string when `stop_reason == "stop_sequence"`. |
| `usage` | object | Token accounting: `input_tokens`, `output_tokens`, plus cache fields on the real API. |

`content` being a list is the single most important design detail of the API. One response
can contain several blocks: text, thinking, tool use. Code that assumes `content[0].text` is
correct only for simple text responses — and it is exactly the code that breaks in module 5.

---

## 3. `model_dump()` — the raw JSON view

Every SDK object is a Pydantic model, so you can turn it into a plain dictionary:

```bash
uv run python - <<'PY'
import json

from helpers.client import get_client, get_model

message = get_client().messages.create(
    model=get_model(),
    max_tokens=64,
    messages=[{"role": "user", "content": "Reply with the word: ready"}],
)

raw = message.model_dump(mode="json")
print(json.dumps(raw, indent=2))
PY
```{{exec}}

Compare that with the Python object. The dictionary is what crosses the wire (minus SDK-only
conveniences). When an API behaves unexpectedly, print `model_dump()` — it removes any doubt
about attribute names.

---

## 4. Raw responses and headers

Sometimes you need HTTP-level information that is not part of the parsed model: status code,
request ID, rate-limit headers, retries. `with_raw_response` gives you the full response:

```bash
uv run python - <<'PY'
from helpers.client import get_client, get_model

client = get_client()

raw = client.messages.with_raw_response.create(
    model=get_model(),
    max_tokens=32,
    messages=[{"role": "user", "content": "Reply with the single word: ready"}],
)

print("status_code:", raw.status_code)
print("content-type:", raw.headers.get("content-type"))
print("request-id:", raw.headers.get("request-id", "<not sent by Ollama>"))

message = raw.parse()
print("parsed block types:", [block.type for block in message.content])
print("parsed text:", message.content[0].text)
PY
```{{exec}}

`raw.parse()` runs the normal SDK parsing, so the resulting object is identical to what
`create()` returns. On the real Anthropic API the `request-id` header is the value support
will ask for; Ollama does not send one, which is why the script falls back to a placeholder.

---

## 5. Exercise — build `inspect_response()`

You will use this helper in every later module, so make it clean.

Create `helpers/inspect.py`:

```bash
cat > helpers/inspect.py <<'EOF'
"""Small, dependency-free helpers for inspecting SDK responses."""


def inspect_response(message) -> dict:
    """Summarise a Message object as a plain dictionary."""
    text = "".join(
        block.text
        for block in message.content
        if getattr(block, "type", None) == "text"
    )

    return {
        "id": message.id,
        "model": message.model,
        "role": message.role,
        "stop_reason": message.stop_reason,
        "stop_sequence": message.stop_sequence,
        "block_types": [block.type for block in message.content],
        "text_preview": text[:80],
        "input_tokens": message.usage.input_tokens,
        "output_tokens": message.usage.output_tokens,
    }
EOF
```{{exec}}

Now write `anatomy.py`, which uses the helper and also demonstrates the other two views:

```bash
cat > anatomy.py <<'EOF'
import json

from helpers.client import get_client, get_model
from helpers.inspect import inspect_response

client = get_client()

message = client.messages.create(
    model=get_model(),
    max_tokens=256,
    messages=[
        {
            "role": "user",
            "content": "Explain in one sentence why the sky looks blue.",
        }
    ],
)

print("=== inspect_response() ===")
print(json.dumps(inspect_response(message), indent=2))

print("\n=== model_dump() (first 40 lines) ===")
dumped = json.dumps(message.model_dump(mode="json"), indent=2)
for line in dumped.splitlines()[:40]:
    print(line)

print("\n=== with_raw_response ===")
raw = client.messages.with_raw_response.create(
    model=get_model(),
    max_tokens=32,
    messages=[{"role": "user", "content": "Reply with the single word: ready"}],
)
print("status_code:", raw.status_code)
print("content-type:", raw.headers.get("content-type"))
print("request-id:", raw.headers.get("request-id", "<not sent by Ollama>"))

parsed = raw.parse()
print("parsed block types:", [block.type for block in parsed.content])
print("parsed text:", parsed.content[0].text)
EOF
```{{exec}}

Run it:

```bash
uv run python anatomy.py
```{{exec}}

Check the output against these expectations:

- `block_types` is `["text"]`,
- `stop_reason` is `"end_turn"` (or `"max_tokens"` if the model was cut off),
- `input_tokens` and `output_tokens` are positive integers,
- `status_code` is `200`,
- `parsed block types` is `["text"]`.

If any of those differ, print `message.model_dump()` and compare — that is the debugging
habit this step is really teaching.

---

## 6. Verify

Press **Check**. The verifier imports your helpers, makes one fresh call, and asserts that:

- `helpers/inspect.py` and `anatomy.py` exist and run,
- `inspect_response()` returns a dictionary with a text block,
- `stop_reason` is `end_turn` or `max_tokens`,
- both token counts are greater than zero,
- the text preview is non-empty.

---

## What you learned

- `max_tokens` is a hard cap; `stop_reason` tells you whether the model finished or was cut
  off.
- A response is a `Message` with a **list** of content blocks, not a string.
- `model_dump(mode="json")` exposes the wire-shaped dictionary; `with_raw_response` exposes
  status, headers and the request ID.
- A small `inspect_response()` helper turns the object into something you can log, assert on
  and compare across modules.
- SDK 2.5.0 no longer accepts `temperature`, `top_p` or `top_k` on `messages.create()`.
