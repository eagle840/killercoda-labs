# You opened the file

You took a `.gguf` apart, read its header by hand over the network, listed every
tensor, saw which ones are quantized and which are not, measured what quantization
costs — and then ran that exact file.

The mental model to keep:

- A local LLM is a **single structured binary** — a self-describing metadata
  header plus a block of weight matrices.
- It contains **no code**. An engine (`llama-cli`, Ollama, LM Studio) is what
  reads it and does the math.
- **Quantization** is the reason a 1B model fits in 808 MB, and it is applied
  *selectively* — 4-bit for the big matrices, higher precision for norms.

## Going further

### Choosing an inference engine

The lab used llama.cpp because it gives you the file directly. The others are
built on the same idea:

| Engine | Best for | Trade-off |
|---|---|---|
| **llama.cpp** (`llama-cli`, `llama-server`) | full control, scripting, inspecting files | command-line flags, you manage the file |
| **Ollama** | simple day-to-day use, a local API | hides the file; models live in its own store |
| **llamafile** | portability — one executable file | large per-file downloads, harder to swap models |
| **LM Studio** | a GUI | desktop app, not scriptable |

Fun fact from the path we skipped: Ollama's own model store is **plain GGUF
blobs**. If you have it installed, `ls ~/.ollama/models/blobs/` — the models it
runs are exactly the kind of file you just dissected.

### Which file do I download from Hugging Face?

The rule of thumb, by available memory:

| Your memory | Pick |
|---|---|
| 2–4 GB | `Q4_K_M` — the practical sweet spot |
| 8 GB | `Q5_K_M` or `Q6_K` |
| 16 GB+ | `Q8_0` |

Start from a **community GGUF repo** (the original release is usually huge
`**.safetensors** files). One repo contains many quants; download exactly one.

### Sizing a model to your machine

- **Match threads to physical cores.** `-t` should equal your vCPU count — more
  threads make it slower, not faster.
- **Cap the context.** Models may default to very large contexts (32k–128k
  tokens); each token costs KV-cache memory. `-c 2048` keeps RAM stable.
- **GGUF can split between VRAM and RAM**, so a model slightly larger than your
  GPU memory can still run — more slowly.

## Clean up

The toolchain and model are reusable, but if you want the disk back:

```bash
rm -rf /opt/llama-b11600 /opt/llamacpp.tar.gz ~/models
```{{copy}}

## Further reading

- llama.cpp: https://github.com/ggml-org/llama.cpp
- GGUF format: https://github.com/ggml-org/ggml/blob/master/docs/gguf.md
- Hugging Face model page used here:
  https://huggingface.co/bartowski/Llama-3.2-1B-Instruct-GGUF

> **Remember:** these commands are for learning, not production. A real
> deployment needs proper resource limits, a serving engine, and a pinned,
> vetted model — do not reuse this as-is.
