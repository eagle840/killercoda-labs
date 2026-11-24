# LLM Files and Inference — Resources & Notes

This file carries extra notes, links, and older/exploratory material for the
scenario. It is intentionally **excluded from the learner-facing flow**. The
source research dump lives alongside it as `google_query.md`.

## Alternatives considered

### File format

| Format | Strength | Trade-off | Chosen? |
|---|---|---|---|
| **GGUF** | one self-contained file (weights + config + tokenizer); single-file download; can split between VRAM and system RAM; runs on CPU | not the format models are *trained* in | **Yes** |
| safetensors | safe, memory-mappable, the HF default for raw weights | unquantized and large; not a runtime format for casual local inference | No — referenced in steps for contrast |
| EXL2 / GPTQ | very fast on NVIDIA GPUs | GPU-only, cannot easily spill to RAM; harder to inspect | No |

**Choice:** GGUF, because the lab is about *the file*, and GGUF is the one file
an end user actually downloads and runs.

### Inference engine

| Engine | Strength | Trade-off | Chosen? |
|---|---|---|---|
| **llama.cpp** (`llama-cli`) | gives direct access to the file; CLI; the substrate other tools build on; `gguf-dump` is from the same ecosystem | command-line flags | **Yes** |
| Ollama | simplest setup; local API; runs well on this VM | hides the file in its own store — works *against* the lab's premise | Fallback only |
| llamafile | one portable executable, broad CPU support | large per-file downloads; harder to swap models | No |
| LM Studio | GUI | not scriptable | Mentioned only |

**Choice:** llama.cpp. Keeping the `.gguf` in the learner's hands is the entire
point of the scenario.

## Version pinning

| Component | Pinned value |
|---|---|
| llama.cpp | release **`b11600`** → `0.6.0-dev`, commit `ace20f679`, GNU 11.4.0 |
| llama.cpp asset | `llama-b11600-bin-ubuntu-x64.tar.gz` (16.9 MB) |
| Model | `bartowski/Llama-3.2-1B-Instruct-GGUF` → `Llama-3.2-1B-Instruct-Q4_K_M.gguf` (807,694,464 bytes) |
| `uv` | latest at build time — pin the exact version here once recorded |
| Python `gguf` | pin the exact version here once recorded |

> **Never use `latest` for llama.cpp.** Its `latest` release tag (`v0.6.0`) has a
> single 7-byte asset (`nightly-tag.txt`). Binaries live on the `b####` build
> tags. Linux assets are **`.tar.gz`**; only Windows uses `.zip`.

## Runtime / hardware notes (measured on the Killercoda backend)

- **1 vCPU**, Intel Xeon E312xx (**Sandy Bridge**), 2.0 GHz.
- CPU flags: `avx` only — **no `avx2`, `f16c`, `fma`, `avx512f`**.
- ~3.8 GiB RAM, ~13 GB free disk.
- `python3`, `pip3`, `curl`, `unzip`, `xxd`, `tar` present; **`node`/`npx` absent**.
- HF download ~5 MB/s (808 MB ≈ 2.7 min); GitHub ~18 MB/s.

### Why the prebuilt binary still runs (Sandy Bridge)

`ggml` ships **one shared library per CPU microarchitecture** and selects the
right one at startup. The `b11600` Ubuntu x64 tarball includes
`libggml-cpu-sandybridge.so` (alongside `sse42`, `haswell`, `zen4`,
`sapphirerapids`, …), so an AVX-only CPU is explicitly supported. Verified:
`llama-cli --version` runs on the Sandy Bridge backend.

### Why the backend is `ubuntu-4GB`

A 0.8 GB model plus the OS is comfortable at 4 GB and tight at 2 GB. The plain
`ubuntu` image is documented at 2 GB.

## Corrections applied to `google_query.md`

The source dump is AI-generated and several claims are wrong for this
environment. These were corrected in the learner-facing text:

- `-t 2` → **`-t 1`** (the VM has one vCPU).
- `ggerganov/llama.cpp` → **`ggml-org/llama.cpp`**.
- `npx @huggingface/gguf` → **unavailable** (no Node installed); replaced with
  `uv` + `gguf-dump`.
- The size/quality table was written for an **8B** model; recomputed for the
  **1B** model used here.
- Softened "4-bit feels almost identical to 16-bit".
- Flagged the "GPT-Generated Unified Format" expansion as a disputed backronym.
- Removed generation artifacts (`[/goto?url=…]` markers, `接近 7B quality`,
  `Use code with caution`).

## Handy commands used while building

```bash
# find a llama.cpp build tag and its Linux asset (the API is not rate-limited here)
curl -s https://api.github.com/repos/ggml-org/llama.cpp/releases/tags/b11600 \
 | python3 -c "import sys,json; [print(a['name'], a['size']) for a in json.load(sys.stdin)['assets']]"

# peek a model header over the network (must follow redirects!)
curl -sL -r 0-23 -D - -o /tmp/head.bin "<model-url>" && xxd /tmp/head.bin

# real file size behind a redirect (the LAST content-length is the real one)
curl -sIL "<model-url>" | grep -i '^content-length' | tail -1
```
