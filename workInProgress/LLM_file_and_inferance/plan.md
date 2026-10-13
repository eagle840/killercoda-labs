# LLM Files and Inference — Lab Plan

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
- **Backend:** `ubuntu-4GB` (see *Runtime / hardware* — must be pinned in
  `index.json`).

## Prototype measurements (real, taken on the Killercoda backend)

| Property | Measured value | Consequence |
|---|---|---|
| vCPU | **1** | Threads = 1. The dump's `-t 2` advice is **wrong** for this box. |
| CPU | Intel Xeon **E312xx (Sandy Bridge)**, 2.0 GHz | See *CPU issue* below. |
| CPU flags | `avx` only — **no `avx2`, `f16c`, `fma`, `avx512f`** | Prebuilt AVX2 binaries may `SIGILL`. |
| RAM | 3.8 GiB total, ~3.0 GiB free | Comfortable for a 0.8 GB model. 2 GB (`ubuntu`) would be tight. |
| Disk | 13 GB free on `/` | No constraint (model is 808 MB). |
| Network | ~5 MB/s (derived: 640 MB tinyllama in ~2 min) | 808 MB ≈ **~2.7 min** — fast enough to download inline. |
| Present | `python3`, `pip3`, `curl`, `unzip`, `xxd` | Python path for GGUF tooling is open. |
| Absent | `node`, `npx` | `npx @huggingface/gguf` is **not** available; node is not installed. |
| Ollama | version reported as `0.40.3` (confirm; likely `0.4.3`) | **Runs well** with tinyllama on this CPU → llama.cpp-class engines work here. |

## CPU issue (covered in detail)

The target CPU is a **Sandy Bridge Xeon (2011)**: it has `avx` but **not**
`avx2`, `f16c`, or `fma`. A llama.cpp (or Ollama) binary compiled with an
AVX2/F16C baseline will die with an **illegal instruction (`SIGILL`)** — a
confusing failure on a 1-vCPU box.

Two mitigating facts:

1. **llama.cpp normally uses runtime CPU dispatch.** `ggml` compiles multiple
   code paths and selects one via `cpuid` at startup *if* the release was not
   built with an AVX2 baseline. So the prebuilt binary **may work fine** — this
   must be tested, not assumed.
2. **Ollama already runs here.** Ollama embeds llama.cpp and runs tinyllama on
   this exact backend, which is strong evidence that a llama.cpp build will run
   on Sandy Bridge.

**Decisive test (blocker):** download the prebuilt linux-x64 llama.cpp release,
`unzip -l | grep -iE 'gguf|cli|quantize'`, and run `./llama-cli --version`.
A version string = plan holds. `SIGILL` = switch step 1/step 6 to the
**Ollama + Modelfile fallback** (below).

### Engine fallback if `llama-cli` fails

Ollama can run a GGUF already on disk. A `Modelfile` containing
`FROM /path/to/Llama-3.2-1B-Instruct-Q4_K_M.gguf`, then `ollama create` /
`ollama run`, runs **that exact file** on the engine proven to work here. The
file stays in the learner's hands; Ollama is only the loader. (Bonus aside for
step 6: Ollama's store is plain GGUF blobs — `ls ~/.ollama/models/blobs/`.)

## Toolchain & version pinning

**Rule: pin every version. Never install `latest`.** Record the resolved value in
this table once the build is tested.

| Tool | How obtained | Version | Status |
|---|---|---|---|
| llama.cpp (`llama-cli`, and maybe `llama-gguf`) | prebuilt linux-x64 release from `github.com/ggml-org/llama.cpp` | **TBD — build number unknown** | **Blocked:** not yet downloaded/tested |
| GGUF inspector | either the release's own binary, or `gguf-dump` from the Python `gguf` package | **TBD** | Depends on what the release ships |
| `uv` | `curl -LsSf https://astral.sh/uv/install.sh \| sh` (installs to `~/.local/bin`) | **TBD** | Not installed on backend; confirm PATH for root |
| Python `gguf` | `uv tool install gguf==<pin>` (or `uvx --from gguf gguf-dump`) | **TBD** | Confirm the console-script name is actually `gguf-dump` |
| `python3` / `pip3` / `curl` / `unzip` / `xxd` | preinstalled | capture with `--version` during build | Present, versions unpinned |
| Ollama *(fallback only)* | `curl -fsSL https://ollama.com/install.sh \| sh` | `0.40.3` as reported — **confirm** | Proven working on this backend |
| Model | `bartowski/Llama-3.2-1B-Instruct-GGUF` → `Llama-3.2-1B-Instruct-Q4_K_M.gguf` | 807,694,464 bytes (808 MB) | URL verified (302 → signed CDN) |

### Commands to pin versions

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
| 1 | **Get the tools** | unzip the llama.cpp release; `./llama-cli --version`; install `uv` + GGUF tooling as needed |
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

**Learner trap to call out:** the HF URL 302-redirects to a signed CDN URL. Without
`-L`, `curl` prints the redirect page (`Found. Redirecting to …`, 1120 bytes) and
`xxd` shows ASCII, not a GGUF header. Never `curl … | xxd` without a byte guard —
if the range is ignored, `xxd` will hex-dump the entire 808 MB.

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
parsing is fiddly. Step 5 compares **file sizes**; **tensor types**
(`Q4_K`, `F32`) come from the one file downloaded in step 2.

## Decisions (locked)

- Inspect **and** run the **same file** — Llama 3.2 1B Instruct **Q4_K_M**.
- Engine: **llama.cpp prebuilt** primary; **Ollama + Modelfile** fallback.
- Download **inline in step 2** (peek first), not a background script.
- Quantization shown by **comparing quants** (sizes over the wire).
- Leftover dump material (engine comparison, `-t`/`-c` optimization tips, HF
  "which file to pick") → **`finish.md` / `resources.md` prose only**.
- Payoff prompt = **a task the 1B nails** (formatting, not reasoning).
- Run as **root** — drop the skeleton's `coder` user. `init.sh` is then unused
  (it was not referenced from `index.json` anyway).

## Open items / to settle during build

1. **`llama-cli --version` test** on Sandy Bridge — the one true blocker.
2. **Real timing (F):** time the 808 MB download; measure tokens/sec for a
   64-token generation with `-t 1`.
3. **`imageid` pin:** set `ubuntu-4GB` in `index.json` (probe showed 3.8 GiB, but
   the file currently says `ubuntu`, documented as 2 GB).
4. **`index.json` metadata:** fix title typo `inferance` → **`inference`**; add a
   `<30-word` description ending `(v0.1)`.
5. **Confirm `gguf-dump` entry point** with:
   `uvx --from gguf python -c "import importlib.metadata as m; print([e.name for e in m.distribution('gguf').entry_points])"`
6. **Confirm `llama-cli` flags** for the pinned build (e.g. whether
   `--no-conversation`/`-no-cnv` is needed, exact `-n`/`-c` names).
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
- Model card example (link from step): https://huggingface.co/bartowski/Llama-3.2-1B-Instruct-GGUF
- Raw source format: https://huggingface.co/meta-llama/Meta-Llama-3-8B-Instruct
- llama.cpp releases: https://github.com/ggml-org/llama.cpp/releases
- `uv`: https://docs.astral.sh/uv/
- LM Studio / Ollama (referenced in prose): https://lmstudio.ai/ , https://ollama.com/

## Next steps

1. Run the `llama-cli --version` test and record the build number (or trigger the
   Ollama fallback).
2. Time the download and the generation; record both here.
3. Draft the six step files, `intro.md`, `finish.md`, `resources.md`.
4. Test end to end on `ubuntu-4GB`; capture final versions in the pinning table.
