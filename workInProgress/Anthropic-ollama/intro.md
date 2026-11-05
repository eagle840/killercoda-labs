# Anthropic Python SDK with Ollama

**Last updated:** 2026-11-05

The Anthropic Python SDK is the official client for the Anthropic Messages API. This lab
teaches the real SDK — request shape, response objects, helpers and failure modes — while
running every call against a local [Ollama](https://ollama.com) server instead of the paid
API.

Ollama implements the same `POST /v1/messages` protocol, so the code you write here is the
code you would ship. Only the `base_url` and a dummy `api_key` change.

## Who this is for

- Python developers who want to use Claude models from code.
- Developers coming from the OpenAI SDK who want the Anthropic mental model.
- Anyone who wants to try the SDK without creating an API key.

You should be comfortable with a terminal and with basic Python (functions, dictionaries,
imports). No previous LLM API experience is required.

## What you will do

This scenario currently covers the first two modules:

1. **First call against Ollama** — provision the project with `uv`, make a `messages.create()`
   call, and move the client into a reusable helper.
2. **Anatomy of a message** — the required parameters, the `Message` object, `model_dump()`,
   raw responses and headers, and a reusable `inspect_response()` helper.

Later modules (streaming, content blocks, tool use, structured output, errors, usage,
batching, async) are planned but not part of this version.

## Badge legend

Every step carries a badge:

| Badge | Meaning |
|---|---|
| `LIVE` | Runs against the real Ollama server in your sandbox. |
| `MOCKED` | Uses a recorded fixture because Ollama does not implement the feature. The SDK code is still real. |

Both steps in this scenario are `LIVE`.

## About the sandbox

The first boot installs Ollama, starts it, and pulls a ~1 GB model **in the background**.
Including the Ollama runtime, the download is roughly 2.5 GB and takes a few minutes. Step 1
shows you how to watch the progress and wait for it — you can read the rest of this page while
it runs.

The terminal runs as `root`; `init.sh` also creates a passwordless-sudo `coder` user if you
prefer to work as a normal user.

## Production disclaimer

This is a teaching lab, not production code. The model is tiny, the endpoint is local, the
API key is a placeholder, and the examples omit authentication, observability, rate-limit
handling and cost controls. Do not copy the snippets into production without hardening
them.

## Pinned versions

| Component | Version |
|---|---|
| Python | 3.12 |
| `anthropic` | 2.5.0 |
| `uv` | latest at sandbox build |
| Model | `qwen2.5-coder:1.5b` |

Pinning matters here: the 2.x SDK removed several arguments that older tutorials still use
(for example `temperature`). See `resources.md` for the full list of gotchas.
