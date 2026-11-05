# Step 1 — Your first Anthropic call (LIVE)

> **Badge: `LIVE`** — this step talks to the real Ollama server running in your sandbox.
>
> **Time:** ~20 minutes · **Prerequisites:** a terminal and basic Python.

The Anthropic Python SDK is a thin HTTP client for one endpoint: `POST /v1/messages`.
Anything that speaks that protocol can stand in for the Anthropic API — including a local
Ollama server. That is the trick this lab uses: you write the real SDK code, and Ollama
answers instead of Anthropic.

In this step you will:

1. install Ollama and pull the model,
2. install `uv` and create a pinned project,
3. make your first `messages.create()` call,
4. move client construction into a reusable helper.

---

## 1. Install Ollama and pull the model

This sandbox starts as a bare Ubuntu VM, so install Ollama with the official script:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```{{exec}}

This downloads the Ollama runtime (roughly 1.5 GB), so give it a minute or two. Then pull the
model (about 1 GB):

```bash
ollama pull qwen2.5-coder:1.5b
ollama list
```{{exec}}

Expected result: a progress bar during the pull, then a table containing
`qwen2.5-coder:1.5b`. The first run downloads roughly 2.5 GB in total (runtime plus model), so
it can take a few minutes.

---

## 2. Install `uv` and create a pinned project

`uv` is not preinstalled. Install it into `/usr/local/bin` so it is on `PATH` for every
shell:

```bash
curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR=/usr/local/bin sh
uv --version
```{{exec}}

Then create the project, a virtual environment and a lock file, and install the exact SDK
version this lab teaches:

```bash
cd /root
uv init --python 3.12 anthropic-lab
cd anthropic-lab
uv add anthropic==2.5.0 python-dotenv
```{{exec}}

Expected output includes a new `.venv`, `pyproject.toml`, `uv.lock`, and lines resolving
`anthropic==2.5.0`, `httpx2`, `pydantic` and `python-dotenv`.

> **Why pin `2.5.0`?** The 2.x SDK changed the `messages.create()` signature. Older
> tutorials pass `temperature`, which 2.5.0 rejects. Pinning keeps the lab reproducible and
> keeps the lesson honest about the current API.

The terminal keeps its working directory between blocks. If you ever open a fresh terminal
tab, run `cd /root/anthropic-lab` first.

---

## 3. Point the SDK at Ollama

The SDK reads no configuration by itself — we pass it explicitly. Keep the values in a
`.env` file so every later script gets the same settings.

```bash
cat > .env <<'EOF'
ANTHROPIC_BASE_URL=http://127.0.0.1:11434
ANTHROPIC_API_KEY=ollama
ANTHROPIC_MODEL=qwen2.5-coder:1.5b
EOF
```{{exec}}

Two fields deserve a comment:

| Setting | Why it exists |
|---|---|
| `ANTHROPIC_BASE_URL` | Ollama serves `/v1/messages` on this port. The SDK appends the path. |
| `ANTHROPIC_API_KEY` | Required by the SDK constructor and must be non-empty. Ollama ignores its value, so `ollama` is a deliberate dummy. |

Never put a real Anthropic key in an Ollama lab — it would be sent to your local server.

---

## 4. Make the call

Create `hello.py`:

```bash
cat > hello.py <<'EOF'
import os

import anthropic
from dotenv import load_dotenv

load_dotenv()

client = anthropic.Anthropic(
    base_url=os.environ["ANTHROPIC_BASE_URL"],
    api_key=os.environ["ANTHROPIC_API_KEY"],
)

message = client.messages.create(
    model=os.environ["ANTHROPIC_MODEL"],
    max_tokens=256,
    messages=[
        {"role": "user", "content": "In one short sentence, say hello and explain what you are."}
    ],
)

print(message.content[0].text)
```{{exec}}

Run it:

```bash
uv run python hello.py
```{{exec}}

You should see a single short paragraph. The first run may take a few seconds while Ollama
loads the model into memory; later runs are faster.

### What each argument does

| Argument | Required | Meaning |
|---|---|---|
| `model` | yes | The Ollama tag to run, e.g. `qwen2.5-coder:1.5b`. |
| `max_tokens` | **yes** | Hard cap on generated tokens. Omitting it is a client-side error, not a server error. |
| `messages` | yes | The conversation. Today it contains one `user` turn. |
| `base_url` | constructor | Where the SDK sends `POST /v1/messages`. |
| `api_key` | constructor | Required, but ignored by Ollama. |

`message` is not a string. It is a `Message` object whose `content` is a **list of content
blocks**. With a text-only request, `content[0]` is a `TextBlock` and `.text` holds the
reply. Step 2 takes the object apart properly.

---

## 5. Put the client in one place

Every later module should share one configuration. Create a small helper package:

```bash
mkdir -p helpers
cat > helpers/__init__.py <<'EOF'
from .client import get_client, get_model

__all__ = ["get_client", "get_model"]
EOF

cat > helpers/client.py <<'EOF'
import os

import anthropic
from dotenv import load_dotenv

load_dotenv()


def get_client() -> anthropic.Anthropic:
    """Return one configured client for the whole lab."""
    return anthropic.Anthropic(
        base_url=os.environ.get("ANTHROPIC_BASE_URL", "http://127.0.0.1:11434"),
        api_key=os.environ.get("ANTHROPIC_API_KEY", "ollama"),
        max_retries=2,
        timeout=120.0,
    )


def get_model() -> str:
    """Return the model tag from .env, with a safe default."""
    return os.environ.get("ANTHROPIC_MODEL", "qwen2.5-coder:1.5b")
EOF
```{{exec}}

Smoke-test the helper without making a network call:

```bash
uv run python -c "from helpers.client import get_client, get_model; print('model:', get_model()); print('client:', type(get_client()).__name__)"
```{{exec}}

Expected output:

```text
model: qwen2.5-coder:1.5b
client: Anthropic
```

---

## 6. Your turn

Rewrite `hello.py` so it imports `get_client` and `get_model` from `helpers.client` instead
of reading `os.environ` directly. Then run it again:

```bash
nano hello.py
uv run python hello.py
```{{exec}}

The behaviour must not change — this is a refactor, not a new feature. Keeping one client
factory is what lets the capstone switch between Ollama and the real Anthropic API with a
single environment variable.

When you are happy, press **Check** to let the lab verify that:

- `hello.py` exists and exits successfully,
- it prints a non-empty reply,
- `helpers.client.get_client()` and `get_model()` are importable and configured.

---

## What you learned

- The Anthropic SDK is an HTTP client for `POST /v1/messages`; `base_url` redirects it to
  Ollama.
- `api_key` is required by the constructor even when the backend ignores it.
- `model`, `max_tokens` and `messages` are the three required call arguments, and
  `max_tokens` is mandatory in SDK 2.5.0.
- `Message.content` is a list of blocks, not a string.
- One `get_client()` factory keeps configuration in a single place.
