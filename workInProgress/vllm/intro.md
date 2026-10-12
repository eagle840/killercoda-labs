# vLLM Lab Skeleton

This folder is a bare-bones skeleton for a **vLLM** scenario. It provides the
essential structure (manifest, intro, steps, finish, resources) so a full lab can
be built quickly.

[vLLM](https://docs.vllm.ai/) is a high-throughput, memory-efficient inference and
serving engine for large language models. Its key features include:

- **PagedAttention** for efficient KV-cache memory management.
- **Continuous batching** to keep GPUs busy under concurrent load.
- An **OpenAI-compatible HTTP server** (`vllm serve`).

Replace the placeholder steps with the real lab content.

**Last updated:** 2026-10-12

> **Note:** This is a skeleton template. Nothing here is production-ready — do not
> reuse the example configuration as-is in a production deployment.
