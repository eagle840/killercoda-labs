# Step 1 — Install the llama.cpp toolkit

Two tools do the work in this lab:

- **`llama-cli`** — the inference engine. It loads a `.gguf` file into memory and
  runs the math to generate text. It is part of **llama.cpp**, the C/C++
  project that most local LLM software is built on.
- **`gguf-dump`** — an inspector that reads a `.gguf` file's structure and prints
  its metadata and tensor list. We need this because llama.cpp's own release
  ships a *splitter* (`llama-gguf-split`) but **not** a dumper.

## 1. Download llama.cpp

We pin an exact release build, **`b11600`**. Do not be tempted to "grab the
latest" — llama.cpp's `latest` release tag currently points at a `v0.6.0` marker
whose only file is a 7-byte `nightly-tag.txt`. The real binaries live on the
`b####` build tags.

Note the file ends in **`.tar.gz`**. Linux builds are tarballs; only Windows uses
`.zip`.

```bash
mkdir -p /opt && cd /opt
curl -L -o llamacpp.tar.gz \
  "https://github.com/ggml-org/llama.cpp/releases/download/b11600/llama-b11600-bin-ubuntu-x64.tar.gz"
```{{exec}}

Extract it:

```bash
cd /opt && tar xzf llamacpp.tar.gz
ls /opt/llama-b11600 | head -20
```{{exec}}

You should see a pile of binaries (`llama-cli`, `llama-server`,
`llama-quantize`, `llama-tokenize`, …) and, crucially, a set of `libggml-cpu-*.so`
files. Those are **per-CPU backends** — `sse42`, `sandybridge`, `haswell`,
`zen4`, and many more. At startup, `ggml` detects your CPU and loads the matching
one. That is why a prebuilt binary runs on a wide range of hardware.

Put the toolkit on your path and confirm it runs:

```bash
echo 'export PATH="/opt/llama-b11600:$PATH"' >> ~/.bashrc
export PATH="/opt/llama-b11600:$PATH"
llama-cli --version
```{{exec}}

**You should see** a version line like:

```
version: 0.6.0-dev (build 11600, commit ace20f679)
built with GNU 11.4.0 for Linux x86_64
```

## 2. Install the GGUF inspector (via uv)

We use [uv](https://docs.astral.sh/uv/) to install the Python `gguf` package,
which provides the `gguf-dump` command. It is a single fast binary, so it suits
this one-vCPU box far better than a full pip environment.

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.local/bin:$PATH"
uv --version
```{{exec}}

Install the package:

```bash
uv tool install gguf
```{{exec}}

Confirm the `gguf-dump` command is now available:

```bash
which gguf-dump && gguf-dump --help | head -20
```{{exec}}

> If `gguf-dump` is not found, run it without installing:
> `uvx --from gguf gguf-dump --help`

## What you learned

- llama.cpp ships **prebuilt binaries bundled with per-CPU shared libraries**;
  the engine selects a backend for your hardware at runtime.
- Pin the **build tag** (`b11600`) — the `latest` tag is not the binaries.
- `llama-cli` runs models; `gguf-dump` reads their structure.
