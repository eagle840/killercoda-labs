# Gradio Intro Lab Plan

## Goal

Create a 60-minute Killercoda lab that introduces Gradio and connects a Gradio chat UI to a local LLM exposed through Ollama's OpenAI-compatible API. Python dependencies are managed with `uv` instead of `pip`.

## Decisions

- **Backend:** `ubuntu-4GB` so Ollama and Gradio have enough memory. The 2 GB image is likely to be tight for model loading.
- **Model:** `tinyllama` (~640 MB quantized), consistent with the existing Ollama lab.
- **Python tooling:** `uv init` + `uv add` + `uv run`. No `pip`, no manual virtualenv activation.
- **Steps:** 5 steps. First app, Blocks/API, then Ollama and the chat app.
- **Assets:** No files in `assets/`. All app code is written inline with heredocs and `{{exec}}`, matching the pattern used elsewhere in this repository.
- **Networking:** Gradio binds to `0.0.0.0:7860`. The lab links to it with `{{TRAFFIC_HOST1_7860}}`.
- **Analytics:** `GRADIO_ANALYTICS_ENABLED=False` is set inside each app before importing Gradio.
- **Initialization:** `init.sh` is not referenced by `index.json` and was left untouched. The lab runs as the default user.

## File map

| File | Purpose |
| --- | --- |
| `index.json` | Metadata, 5 step entries, `ubuntu-4GB`, version `v0.1.0` |
| `intro.md` | Overview, learning outcomes, architecture, resource warnings |
| `step1.md` | Resource check, install uv, create project, add Gradio and OpenAI SDK |
| `step2.md` | Quickstart `gr.Interface` greet app, background launch, Traffic link, hot reload |
| `step3.md` | `gr.Blocks` Text Stats app, events, `api_name`, `gradio_client` call |
| `step4.md` | Install Ollama, start server fallback, pull TinyLlama, verify `/v1` |
| `step5.md` | Streaming `gr.ChatInterface` chatbot using the OpenAI SDK |
| `finish.md` | Summary, architecture recap, cleanup, next steps |
| `resources.md` | Gradio, uv, Ollama, TinyLlama, and Killercoda links |
| `plan.md` | This document |

## Step flow

### Step 1: Install uv and create the project

- `nproc`, `free -h`, `df -h /`
- `curl -LsSf https://astral.sh/uv/install.sh | sh`
- `source $HOME/.local/bin/env`
- `uv init gradio-lab --python 3.12`
- `uv add gradio openai`
- Inspect `pyproject.toml`, verify imports with `uv run python -c ...`

### Step 2: First Gradio app

- Recreate the official quickstart `gr.Interface` greet demo.
- Use `gr.Textbox` and `gr.Slider` components.
- Launch on `0.0.0.0:7860`.
- Start with `nohup` and `app.log`, poll `curl`, then open the Traffic URL.
- Document `uv run gradio app.py` hot reload.

### Step 3: Blocks and API

- Replace `app.py` with a Text Stats app.
- Use `gr.Blocks`, `gr.Row`, `gr.Textbox`, `gr.Button`, `gr.ClearButton`.
- Wire `analyze_button.click(..., api_name="analyze")`.
- Restart the server and verify with `curl`.
- Create `client_demo.py` and call `/analyze` through `gradio_client`.

### Step 4: Ollama and TinyLlama

- Install with `curl -fsSL https://ollama.com/install.sh | sh`.
- Check `/api/tags`; run `nohup ollama serve` only if the service is not already up.
- `ollama pull tinyllama`, then `ollama list`.
- Verify `http://localhost:11434/v1/models`.
- Test with the OpenAI SDK in `test_api.py`, using `base_url="http://localhost:11434/v1/"` and `api_key="ollama"`.
- Include troubleshooting for logs, memory, and unloading the model.

### Step 5: Chat app

- Replace the Text Stats app with `chat_app.py`.
- Use `gr.ChatInterface` and a generator function for streaming.
- Normalize Gradio message dicts (and older tuple history) into OpenAI messages.
- Set a concise system prompt and `max_tokens=200` to keep CPU responses short.
- Start on port 7860, verify, and test in the browser.
- Mention `gr.load_chat()` as a one-line alternative.
- Include troubleshooting for `Connection refused`, slow inference, and memory pressure.

## Key commands used in the lab

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
uv init gradio-lab --python 3.12
uv add gradio openai

nohup uv run python app.py > app.log 2>&1 &
curl -sf http://localhost:7860

curl -fsSL https://ollama.com/install.sh | sh
nohup ollama serve > /tmp/ollama.log 2>&1 &
ollama pull tinyllama
curl -s http://localhost:11434/v1/models | python3 -m json.tool
ollama ps
```

## Validation performed

- `index.json` parses as valid JSON.
- Every file referenced by `index.json` exists.
- All Python heredocs in steps 2–5 were extracted and compiled successfully:
  - `app.py` (Interface version)
  - `app.py` (Blocks version)
  - `client_demo.py`
  - `test_api.py`
  - `chat_app.py`
- Traffic links use `{{TRAFFIC_HOST1_7860}}`.
- Restart blocks use `{{exec interrupt}}` so a leftover foreground hot-reload process cannot swallow the command.
- Cleanup commands use a bracketed `pkill` pattern (`[p]ython ...`) to avoid matching the shell that runs the command.

### Runtime tests

Tested in a scratch project with **Gradio 6.30.0** and **OpenAI SDK 3.37.0**:

- `uv init gradio-lab --python 3.12` produced the expected project layout and `.venv`.
- The `gr.Interface` app started and returned HTTP 200 on port 7860.
- `gradio_client` called the `/predict` endpoint and returned `Hello, Ada!!!`.
- The `gr.Blocks` Text Stats app started and returned HTTP 200.
- `client_demo.py` called `/analyze` and returned the expected counts.
- `chat_app.py` started and returned HTTP 200.
- `build_messages()` produced correct OpenAI messages for both current dict-style history and legacy tuple history.
- The `chat()` generator streamed partial replies correctly against a fake OpenAI client.
- `uv run gradio --help` confirmed the hot-reload CLI is available.

The Ollama installation and live TinyLlama inference were not executed locally; they follow the official Ollama install script and documented OpenAI compatibility API.

## Runtime notes and risks

- **Ollama service in containers:** The install script may rely on systemd. Step 4 checks `/api/tags` first and falls back to `ollama serve`.
- **First-token latency:** CPU-only inference can take 20+ seconds on the first request while the model loads. The lab warns about this and uses streaming.
- **Model quality:** TinyLlama is small and may give short or imperfect answers. The system prompt asks for brevity.
- **Memory:** `ubuntu-4GB` is required in practice. The troubleshooting section explains `free -h` and `ollama stop tinyllama`.
- **Gradio version drift:** The chat app handles both current message-dict history and older tuple history to remain compatible across Gradio versions.
- **Port conflicts:** Steps 3 and 5 stop old Gradio processes before starting new ones.

## Possible follow-ups

- Add `verify.sh` scripts for steps 1–5 (check project files, HTTP 200, model presence).
- Add a `share=True` / Hugging Face Spaces section.
- Add an embeddings example using `/v1/embeddings`.
- Add a model picker (`gr.Dropdown`) populated from `/v1/models`.
- Add a system-prompt textbox via `additional_inputs`.
