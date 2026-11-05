# Resources — Anthropic Python SDK on Ollama

Supplementary notes, design decisions and gotchas for this scenario. The learner does not
need to read this page to finish steps 1–2.

---

## Why the Anthropic SDK instead of raw HTTP?

| Option | Pros | Cons | Verdict |
|---|---|---|---|
| **Anthropic Python SDK** | Official typed models, retries, streaming, raw-response access, tool helpers | Adds a dependency; version churn | **Chosen** — the lab is about the SDK. |
| Raw `httpx` / `requests` | No dependency, see every byte | You re-implement retries, SSE parsing, typing, error mapping | Useful as an explainer, not the main path. |
| OpenAI SDK pointed at Ollama | Familiar to OpenAI users | Teaches the wrong protocol; Anthropic features absent | Good for a migration sidebar, not this lab. |
| LangChain / LlamaIndex | Higher-level abstractions | Hides exactly the `Message`/block anatomy this lab teaches | Out of scope. |

## Why Ollama instead of the real Anthropic API?

- No API key, no cost, no rate limits, reproducible.
- Ollama implements `POST /v1/messages`, so the SDK code is unchanged apart from `base_url`
  and a dummy `api_key`.
- The trade-off: newer SDK features (tool-use blocks, structured output, prompt caching,
  batches, files, `count_tokens`) are not implemented by Ollama. Those modules must be
  fixture-backed. The badge system (`LIVE` / `MOCKED`) keeps that honest.

Switching to the real API later is a `.env` change:

```bash
ANTHROPIC_BASE_URL=https://api.anthropic.com
ANTHROPIC_API_KEY=sk-ant-...
ANTHROPIC_MODEL=claude-...
```

## Model choice

| Model | Size | Why / why not |
|---|---|---|
| `qwen2.5-coder:1.5b` | ~986 MB | **Chosen.** Fits comfortably in the 4 GB sandbox, fast on CPU, good enough for chat and code snippets. |
| `qwen2.5:0.5b` | ~400 MB | Faster boot; weaker at multi-turn recall and instruction following. Use if boot time matters more than quality. |
| `llama3.2:1b` | ~1.3 GB | Slightly better prose; larger download. |
| A 7B model | 4+ GB | Does not fit the memory budget and is far too slow on CPU. |

`qwen2.5-coder:1.5b` was verified to work with the SDK's `messages.create`, `system=`,
multi-turn history, streaming and `models.list()` on Ollama. It does **not** emit Anthropic
`tool_use` blocks, which is why tool use is planned as a mocked module.

## Version pins and why they matter

| Component | Pin | Note |
|---|---|---|
| Python | 3.12 | Available in the Ubuntu 24.04 image; `uv` can also download it. |
| `anthropic` | `2.5.0` | The lab is written and tested against this exact release. |
| `python-dotenv` | latest resolved by `uv` | Only used to read `.env`. |
| `uv` | latest at boot | Installed to `/usr/local/bin`. |
| Ollama | `0.40.14` (falls back to latest) | Installed from the GitHub release tarball; the install script assumes systemd, which containers usually lack. |

Pin `anthropic` in `pyproject.toml`. Do **not** use `anthropic>=...` — the 2.x line removed
arguments that older tutorials rely on.

## SDK 2.5.0 gotchas

1. **`temperature`, `top_p`, `top_k` are gone** from `messages.create()`. Sampling is exposed
   through `output_config` (for example `output_config={"effort": "low"}`, with levels
   `low`, `medium`, `high`, `xhigh`, `max`). Almost every online tutorial is now wrong.
2. **Structured output** is `messages.parse(..., output_format=Model)` or
   `messages.create(output_config={"format": ...})` — not `output_format=` on `create`.
3. **`max_tokens` is required**, not optional. `max_tokens=0` pre-warms the prompt cache and
   only means something on the real Anthropic API.
4. **`api_key` is required** by the constructor even when the backend ignores it.
5. The constructor also accepts `timeout`, `max_retries`, `http_client`, `middleware` and
   `open_telemetry`.
6. The exception hierarchy is larger than most guides suggest: `APIStatusError`,
   `RateLimitError`, `APIConnectionError`, `APITimeoutError`, `NotFoundError`,
   `OverloadedError`, `RetryableError`.
7. This SDK depends on **`httpx2`**, not `httpx`. Any custom transport or mock must come from
   `httpx2`.

## Ollama compatibility matrix (from the plan, verified on the reference machine)

| SDK feature | Ollama result | Lab treatment |
|---|---|---|
| `messages.create` | Works | LIVE |
| `system=` | Works | LIVE |
| Multi-turn `messages` | Works | LIVE |
| `messages.stream` / `text_stream` | Works | LIVE (future step) |
| `models.list()` | Works | LIVE (future step) |
| `count_tokens` | `404` | MOCKED |
| Tool use | Returns tool JSON as text, no `tool_use` block | MOCKED |
| Structured output | Not implemented | MOCKED |
| Prompt caching | No real semantics | MOCKED / API tour |
| Batches, Files | Not implemented | MOCKED / API tour |
| `AsyncAnthropic` | Works | LIVE (future step) |
| `with_raw_response` | Works | LIVE (step 2) |
| Prefill (`assistant` last turn) | Rejected | Controlled failure demo |

## Sandbox provisioning notes

- `setup.sh` runs in the background and writes `/var/log/anthropic-lab-setup.log`. The marker
  `/var/lib/anthropic-lab-ready` appears only after the model pull succeeds.
- The Ollama binary is installed from the pinned GitHub release tarball
  (`v0.40.14`, falling back to the latest tarball if that URL ever fails) into `/usr`, and
  started with `nohup setsid ollama serve`.
- The model pull is about 1 GB. First boot typically takes 2–5 minutes; step 1 includes a
  wait loop so learners do not race the setup.
- The backend is `ubuntu-4GB`. The 2 GB image is too tight once Ollama, the model and Python
  are all resident.
- Port 11434 stays on loopback; no traffic selector is needed.

## Troubleshooting

| Symptom | Check |
|---|---|
| Step 1's wait loop times out | `tail -n 50 /var/log/anthropic-lab-setup.log`, then `cat /var/log/ollama.log` |
| `address already in use` on 11434 | `pkill -f "ollama serve"`, rerun the server |
| Model pull stalls | `ollama pull qwen2.5-coder:1.5b` manually; check outbound network |
| `TypeError: unexpected keyword argument 'temperature'` | Expected on 2.5.0 — remove the argument |
| `NotFoundError` from `count_tokens` | Expected on Ollama; that module is mocked |
| Very slow first response | The model is loading into RAM; later calls are faster |

## History

- `v0.1.0` — steps 1–2 (Modules 0–1 of the plan): environment, first call, response anatomy.
- Earlier skeleton: `v0.0.1` placeholder.

The original planning document lives at `plan.md` in this folder. It describes the full
twelve-module design and the fixture/mocking strategy for the modules Ollama cannot serve.

---

## Reference solution for step 1's refactor

If a learner gets stuck rewriting `hello.py` (or the image has no editor installed), this is
the expected end state:

```python
from helpers.client import get_client, get_model

client = get_client()

message = client.messages.create(
    model=get_model(),
    max_tokens=256,
    messages=[
        {"role": "user", "content": "In one short sentence, say hello and explain what you are."}
    ],
)

print(message.content[0].text)
```

The refactor is deliberately small: the call site loses `os.environ`, and configuration now
lives only in `helpers/client.py`.

