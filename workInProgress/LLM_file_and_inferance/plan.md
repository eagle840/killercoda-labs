# LLM Files and Inference — Lab Plan

**Status: UNBLOCKED.** `llama-cli` from the prebuilt llama.cpp release **runs on
the Sandy Bridge test CPU** (verified). The lab is buildable as designed.

## Objective

Open a real local LLM weights file (`.gguf`), read its structure with the
learner's own eyes — metadata header, quantized tensor map, quantization trade
offs — then run **that exact file** and generate text. The lab turns "an LLM is
a magic black box you download" into "an LLM is a structured binary I can read."

## Audience & format

- **Audience:** ML-adjacent engineer. Assumes comfort with a terminal and a
  rough idea of what a tensor / FP16 is. Do **not** spend steps explaining what a
  floating-point number is.
- **Format:** Killercoda standard (Ubuntu backend, terminal layout), 60 minutes,
  no verify scripts — self-check prose ("you should see…").
- **Backend:** `ubuntu-4GB` (probe showed 3.8 GiB; the plain `ubuntu` image is
  documented at 2 GB and would be tight for a 0.8 GB model).

## Prototype measurements (real, taken on the Killercoda backend)

| Property | Measured value | Consequence |
|---|---|---|
| vCPU | **1** | Threads = 1. The dump's `-t 2` advice is **wrong** for this box. |
| CPU | Intel Xeon **E312xx (Sandy Bridge)**, 2.0 GHz | See *CPU issue* below — **resolved**. |
| CPU flags | `avx` only — **no `avx2`, `f16c`, `fma`, `avx512f`** | Was the `SIGILL` risk. ggml ships a `sandybridge` backend, so it works. |
| RAM | 3.8 GiB total, ~3.0 GiB free | Comfortable for a 0.8 GB model. |
| Disk | 13 GB free on `/` | No constraint (model is 808 MB). |
| Network (HF) | ~5 MB/s (derived: 640 MB tinyllama in ~2 min) | 808 MB model ≈ **~2.7 min** — fast enough to download inline. |
| Network (GitHub) | ~18 MB/s for the 16.9 MB llama.cpp tarball | Tool install is seconds. |
| Present | `python3`, `pip3`, `curl`, `unzip`, `xxd`, `tar` | Python path for GGUF tooling is open. |
| Absent | `node`, `npx` | `npx @huggingface/gguf` is **not** available. |
| Ollama | reported `0.40.3` (confirm); bundles `libllama.so.0.5.0` | Runs well here → engines work; **fallback only**. |

## CPU issue (resolved)

The target CPU is a **Sandy Bridge Xeon (2011)**: `avx` but **no** `avx2`,
`f16c`, or `fma`. A llama.cpp binary compiled with an AVX2 baseline would die
with an illegal instruction (`SIGILL`).

**It does not.** Verified on the backend:

```
$ ./llama-cli --version
version: 0.6.0-dev (build 11600, commit ace20f679)
built with GNU 11.4.0 for Linux x86_64
```

**Why:** `ggml` ships a **per-microarchitecture CPU backend as a separate `.so`
and dispatches at runtime**. The b11600 Ubuntu x64 tarball contains, among many:

```
libggml-cpu-sandybridge.so   libggml-cpu-ivybridge.so   libggml-cpu-haswell.so
libggml-cpu-sse42.so         libggml-cpu-skylakex.so    libggml-cpu-zen4.so
libggml-cpu-cannonlake.so    libggml-cpu-icelake.so     libggml-cpu-sapphirerapids.so
```

So Sandy Bridge is an explicitly named build target. The prebuilt binary is safe
to use, and this is worth a line in the lab: the engine *picks* a CPU backend to
match the machine.

### Engine fallback (kept on file, currently unused)

If we ever need it: Ollama can run a GGUF already on disk — a `Modelfile` with
`FROM /path/to/Llama-3.2-1B-Instruct-Q4_K_M.gguf`, then `ollama create` /
`ollama run`. Ollama's install bundles `llama-server` and `llama-quantize`
(under `/usr/local/lib/ollama/`) but **no `llama-cli`**. Bonus aside for step 6:
Ollama's store is plain GGUF blobs — `ls ~/.ollama/models/blobs/`.

## Release & asset discovery notes (learned the hard way)

1. **`latest` is a decoy.** `github.com/ggml-org/llama.cpp/releases/latest` is
   tag **`v0.6.0`** with **one asset** (`nightly-tag.txt`, 7 bytes). The real
   binaries are attached to **`b####` build tags** (b11600 has 36 assets).
   **Never say "download the latest release" in the step text** — pin `b11600`.
2. **Linux assets are `.tar.gz`, not `.zip`.** Only Windows/macOS/Android use
   `.zip`. Use `tar xzf`. (`…-ubuntu-x64.zip` returns a 9-byte "Not Found".)
3. **The binaries are a bundle of shared libs.** `llama-cli` links the sibling
   `.so` files. Keep the extracted folder intact and run from inside it (or by
   full path).
4. **No standalone GGUF dumper ships in the tarball** — only `llama-gguf-split`
   (which *splits* files). So the metadata/tensor-map inspection in steps 3–4
   requires `gguf-dump` from the Python `gguf` package, installed via **uv**.

## Toolchain & version pinning

**Rule: pin every version. Never install `latest`.**

| Tool | How obtained | Version | Status |
|---|---|---|---|
| llama.cpp (`llama-cli`, `llama-server`, `llama-quantize`, `llama-tokenize`) | prebuilt `llama-b11600-bin-ubuntu-x64.tar.gz` from `github.com/ggml-org/llama.cpp` | **`b11600`** → `0.6.0-dev`, commit `ace20f679`, GNU 11.4.0 | **Verified running** |
| GGUF inspector | **not in the tarball** → `gguf-dump` from Python `gguf` | pin at build (e.g. `gguf==<x.y.z>`) | To pin; confirm entry point name |
| `uv` | `curl -LsSf https://astral.sh/uv/install.sh \| sh` (→ `~/.local/bin`) | **TBD** | Not installed on backend; check PATH as root |
| `python3` / `pip3` / `curl` / `unzip` / `xxd` / `tar` | preinstalled | capture with `--version` during build | Present, versions unpinned |
| Ollama *(fallback only)* | `curl -fsSL https://ollama.com/install.sh \| sh` | reported `0.40.3` — confirm; bundles `libllama.so.0.5.0` | Proven working here |
| Model | `bartowski/Llama-3.2-1B-Instruct-GGUF` → `Llama-3.2-1B-Instruct-Q4_K_M.gguf` | 807,694,464 bytes (808 MB) | URL verified (302 → signed CDN) |

### Exact tool-install commands (verified)

```bash
# llama.cpp — pinned build tag, tarball (NOT zip)
curl -L -o /tmp/llamacpp.tar.gz \
  "https://github.com/ggml-org/llama.cpp/releases/download/b11600/llama-b11600-bin-ubuntu-x64.tar.gz"
tar xzf /tmp/llamacpp.tar.gz -C /opt          # -> /opt/llama-b11600/

# uv + GGUF dumper
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
uv tool install gguf                          # or: uvx --from gguf gguf-dump
```

### Commands to record final versions

```bash
llama-cli --version
uv --version
uvx --from gguf python -c "import importlib.metadata as m; print(m.version('gguf'))"
python3 --version; curl --version | head -1; xxd --version | head -1
```

## Lab arc (6 steps)

Narrative spine: **peek at the blueprint for free → commit to the whole file →
read its structure → run it.** The download is **inline and visible** (not a
background script) because it is fast and because a visible failure beats a
silent one.

| # | Step | Key command |
|---|---|---|
| 1 | **Get the tools** | `tar xzf` the `b11600` tarball into `/opt`; `./llama-cli --version`; install `uv` + `gguf-dump` |
| 2 | **Peek, then fetch** | `curl -sL -r 0-23 -D - -o /tmp/head.bin "$URL"` + `xxd` → decode magic/version/counts. Then `curl -L -o model.gguf "$URL"` (~808 MB) |
| 3 | **Read the blueprint** | `gguf-dump --no-tensors model.gguf` → architecture, context length, layer count, vocab size |
| 4 | **The tensor map** | `gguf-dump model.gguf` → `blk.0.attn_q.weight`, shape, `Q4_K`; note tensors left as `F32` |
| 5 | **Quantization, measured** | `curl -sIL … \| grep -i content-length` on Q4/Q8/F16 URLs → reconcile with the size table |
| 6 | **Run it** | `llama-cli -m model.gguf -p "List three uses for a hammer, numbered, one line each." -t 1 -n 64` |

### Step 2 detail — the "peek" and the `-L` trap

```bash
URL="https://huggingface.co/bartowski/Llama-3.2-1B-Instruct-GGUF/resolve/main/Llama-3.2-1B-Instruct-Q4_K_M.gguf"

# Follow the redirect (-L) or you get the 302 HTML body, not file bytes.
curl -sL -r 0-23 -D - -o /tmp/head.bin "$URL"
xxd /tmp/head.bin
```

Expected decodes:
- `47 47 55 46` → `"GGUF"` magic
- `03 00 00 00` → version 3 (little-endian uint32)
- next 8 bytes → tensor count; next 8 bytes → metadata KV count

**Learner trap to call out:** the HF URL 302-redirects to a signed CDN URL.
Without `-L`, `curl` prints the redirect page (`Found. Redirecting to …`, 1120
bytes of HTML) and `xxd` shows ASCII, not a GGUF header. Never `curl … | xxd`
without a byte guard — if the range is ignored, `xxd` hex-dumps the whole 808 MB.

### Step 5 detail — sizes from the wire

`curl -sIL` prints headers for **both** the 302 (its own `content-length: 1120`)
and the final 200 (the real file size). Take the **last** value:

```bash
for Q in Q4_K_M Q8_0; do
  printf '%-8s ' "$Q"
  curl -sIL "https://huggingface.co/bartowski/Llama-3.2-1B-Instruct-GGUF/resolve/main/Llama-3.2-1B-Instruct-$Q.gguf" \
    | grep -i '^content-length' | tail -1
done
```

**Caveat:** we do *not* remote-parse the other quants. With no `node`, the JS
remote inspector is unavailable, and the Python "header" for a 128k-vocab model
is several MB (the tokenizer list sits in the metadata block), so true remote
parsing is fiddly. Step 5 compares **file sizes**; **tensor types** (`Q4_K`,
`F32`) come from the one file downloaded in step 2. Optional richer variant: the
tarball ships `llama-quantize`, so step 5 *could* become hands-on later.

## Decisions (locked)

- Inspect **and** run the **same file** — Llama 3.2 1B Instruct **Q4_K_M**.
- Engine: **llama.cpp prebuilt** (pinned `b11600`); **Ollama + Modelfile** only
  as a documented fallback.
- Download **inline in step 2** (peek first), not a background script.
- Quantization shown by **comparing quants** (sizes over the wire).
- Leftover dump material (engine comparison, `-t`/`-c` optimization tips, HF
  "which file to pick") → **`finish.md` / `resources.md` prose only**.
- Payoff prompt = **a task the 1B nails** (formatting, not reasoning).
- Run as **root** — drop the skeleton's `coder` user. `init.sh` is then unused
  (it was not referenced from `index.json` anyway).
- **Reuse `google_query.md` as source material** — most of its explanations are
  woven into the lab, *distributed to the point where each becomes concrete*
  (see mapping below), not pasted in as pre-reading.

## Source material mapping (`google_query.md` → lab)

The dump is ~190 lines of research. Including it *verbatim* would turn six
hands-on steps into a wall of text. Instead, each idea lands where the learner
can see it happening:

| Dump section | Lands in | Trigger moment |
|---|---|---|
| Intro: weights + quantization | `intro.md` | framing / hook |
| §1 File types (GGUF / EXL2 / GPTQ / safetensors) | `step2.md` aside + `finish.md` | they see the repo hosts several formats |
| §2 Inside the file (metadata header vs tensor data) | **steps 3–4** | the dump's prose *is* the narration for `gguf-dump` |
| §3 Inference loop (tokenize → matmul → predict → autoregress) | **step 6** | the file finally runs |
| §4 Quantization table (size / quality / hardware) | **step 5** | they see `Q4_K` in the tensor map, then read why |
| Hugging Face store (repo types, reading a page, auto vs manual) | `step2.md` + `finish.md` | they open the model card |
| Low-spec VM (engines, tiny models, `-t`/`-c` tips) | `finish.md` | after they've run one |
| Tools (inspection) | **steps 3–4** | tooling updated to uv + `gguf-dump` |

### Corrections to apply to the dump's content

The dump is AI-generated and several claims are **wrong for this box** — fixed
during the build, not copied:

- `-t 2` → **`-t 1`** (this VM has one vCPU).
- `ggerganov/llama.cpp` → **`ggml-org/llama.cpp`**.
- `npx @huggingface/gguf` → **unavailable** (no `node`); use `uv` + `gguf-dump`.
- The 16 GB / Q8 / Q4 / Q2 table is sized for an **8B** model — the lab uses a
  **1B** model; relabel it or recompute the numbers.
- "4-bit feels almost identical to 16-bit" → **soften** for an ML-adjacent reader.
- "GGUF = GPT-Generated Unified Format" → **disputed backronym**; verify or drop.
- Strip artifacts: `[/goto?url=…]` citation markers, `接近 7B quality`,
  `Use code with caution`.

## Open items / to settle during build

1. ~~`llama-cli --version` test~~ — **DONE: runs on Sandy Bridge.**
2. **Real timings:** time the 808 MB HF download; measure tokens/sec for a
   64-token generation with `-t 1`.
3. **`imageid` pin:** set `ubuntu-4GB` in `index.json`.
4. **`index.json` metadata:** fix title typo `inferance` → **`inference`**; add a
   `<30-word` description ending `(v0.1)`.
5. **Pin `uv` and the `gguf` package** versions; confirm the `gguf-dump` entry
   point:
   `uvx --from gguf python -c "import importlib.metadata as m; print([e.name for e in m.distribution('gguf').entry_points])"`
6. **Confirm `llama-cli` flags** for `b11600` (e.g. whether `--no-conversation` /
   `-no-cnv` is needed; exact `-n`/`-c`/`-t` names).
7. Directory name is also misspelled (`inferance`) — decide whether to rename.

## Files to produce

| File | Content |
|---|---|
| `index.json` | 6 steps, `ubuntu-4GB`, corrected title/description |
| `intro.md` | Framing: "you've run models; now open one up." |
| `step1.md` … `step6.md` | The arc above, self-check prose |
| `finish.md` | Leftover prose: engines, optimization tips, HF workflow |
| `resources.md` | Links, version pins, prototype notes, this plan's rationale |
| `plan.md` | This document |

## Reference URLs

- Model: https://huggingface.co/bartowski/Llama-3.2-1B-Instruct-GGUF
- Raw source format: https://huggingface.co/meta-llama/Meta-Llama-3-8B-Instruct
- llama.cpp releases (pin a `b####` tag, not `latest`):
  https://github.com/ggml-org/llama.cpp/releases/tag/b11600
- `uv`: https://docs.astral.sh/uv/
- LM Studio / Ollama (referenced in prose): https://lmstudio.ai/ , https://ollama.com/

## Next steps

1. Time the model download and a `-t 1` generation; record both here.
2. Draft `index.json`, `intro.md`, the six step files, `finish.md`, `resources.md`.
3. Test end to end on `ubuntu-4GB`; capture final versions in the pinning table.
