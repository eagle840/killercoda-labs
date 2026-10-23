# Lab Plan — "vLLM: Install, Infer, Serve" (basic lab)

**Status:** planning. Supersedes the current placeholder skeleton (`step1.md`–`step4.md`).
**Planned date:** 2026-10-22
**Folder:** `workInProgress/vllm/` → later `vllm/`
**Backend:** `ubuntu-4GB` (4 GB RAM, no GPU, Docker available)
**Difficulty:** Intermediate
**Time:** 60 minutes (core path ≈ 50 min; one optional stretch beat)
**Version:** v0.1 at first publication

Companion lab: `vllmOnK8s.md` ("Operating vLLM on Kubernetes"). Scope split is defined in §2 so the two never overlap.

---

## 1. What this lab is

A single-session introduction to **vLLM as a serving engine**, on a CPU-only box, using a tiny model. The learner installs it, runs offline inference through the Python API, *proves* batching beats sequential generation, hits the memory wall on purpose, then exposes the OpenAI-compatible HTTP server and calls it from both `curl` and the OpenAI SDK.

The engine's architecture (PagedAttention, continuous batching) is taught **through measurement**, not diagrams: the learner computes tokens/sec themselves and sees why the number is what it is.

**Framing for `intro.md`:**

> 4 vCPU, 4 GB, no GPU. Every throughput number here is ~1000× off a production GPU — that is fine, because we are learning *what the numbers mean*, not how fast vLLM is. The shape of the result is identical on an H100; only the magnitude changes.

**Deliverable for the learner:** a working `vllm serve` endpoint on `localhost:8000`, a measured batching speedup, and a mental model of the weights + KV-cache + overhead budget.

---

## 2. Scope boundary vs the Kubernetes lab

| Topic | This lab (`vllm/`) | K8s lab (`vllmOnK8s.md`) |
|---|---|---|
| Install / venv / CPU wheels | ✅ primary | ❌ (uses pinned container image) |
| Offline `LLM` API | ✅ primary | ❌ |
| Batching & memory experiments | ✅ primary | touch only via pod limits |
| `vllm serve` + OpenAI endpoints | ✅ primary | ✅ (but via Service/Ingress) |
| Correctness of the HTTP surface | ✅ | ❌ |
| Metrics & Prometheus | 🟡 one taste: `/metrics` exists, counters move | ✅ primary (scrape, query, tune) |
| Queueing / latency under load | ❌ | ✅ primary |
| Probes, scheduling, replicas, OOMKilled | ❌ | ✅ primary |
| Engine-selection judgement | ✅ closing step | recap only |

Rule of thumb: **if it needs more than one process or more than one machine, it belongs in the K8s lab.**

---

## 3. Decisions already made (and why)

### 3.1 Tool: vLLM

Kept from `resources.md` — the lab's subject is *serving*, not *running*. Alternatives (SGLang, TGI, LMDeploy, Ollama/llama.cpp) are compared there; this lab must state explicitly in step 7 that **for a single user on a CPU laptop, llama.cpp/Ollama is the right answer and vLLM is not**. That honesty is the pedagogical payoff, not a caveat.

### 3.2 Version pin: `vllm==0.32.0`

- Current stable upstream (verified PyPI, 2026-10-18), requires Python `>=3.11,<3.15`.
- Ubuntu 24.04 backend ships Python 3.12 → compatible, no extra interpreter install.
- Model and wheel pinned together; never `latest`.
- Re-check the tag at authoring time and update this plan + `resources.md`.

### 3.3 Install path: `uv` + venv (primary), Docker (fallback)

The current `step1.md` fails ~75% of the time because it mixes three sources of truth for torch/triton:

1. `--extra-index-url https://wheels.vllm.ai/0.31.0/cpu`
2. `--torch-backend cpu` (uv rewrites torch to the CPU index)
3. a hand-pinned `triton @ https://github.com/.../triton-3.8.0+cpu-...whl`

Removing (2) and (3) is the fix. Planned primary command:

```bash
uv pip install "vllm==0.32.0" --extra-index-url https://wheels.vllm.ai/0.32.0/cpu
```

- Pin **one** version string, use **one** extra index, let the vLLM wheel declare its own triton.
- Verify in a clean 4 GB VM before writing the step (see §12, open question 1).
- **Fallback path** (must exist in the step, not in an appendix): if the import fails, run the prebuilt CPU image instead —
  `vllm/vllm-openai-cpu:v0.32.0` (pinned, 1.2 GB, verified on Docker Hub) — and continue the lab from step 6's pattern. Offline-API exercises in steps 3–5 are then run via `docker run --rm --entrypoint python ...`.
- Never gate the rest of the lab on a successful pip install. A failed install must cost 2 minutes, not the session.

### 3.4 Model: `HuggingFaceTB/SmolLM2-135M-Instruct`

| Candidate | Weights | Verdict |
|---|---|---|
| **SmolLM2-135M-Instruct** | ~270 MB (bf16) / ~540 MB (fp32) | **Chosen.** Fast load, leaves room for a real batch of 8 |
| Qwen2.5-0.5B-Instruct | ~1 GB (bf16) | Optional swap in the memory step; much better answers, much less headroom |
| Llama-3.2-1B | ~2.5 GB | ❌ gated (needs HF token) and too big; **no gated models in this lab** |
| SmolLM2-360M | ~720 MB | ❌ known to fail here (memory), keep out of the learner path |

Be explicit in the step text: **135M is a load generator, not a chatbot.** It will produce plausible-sounding nonsense. Learners who expect ChatGPT feel cheated; learners who were told the model is dumb focus on the engine, which is the point.

Model must be ungated and public — no HF token, no login, no license click.

### 3.5 CPU flags: what we pass and don't

| Flag / env | Decision |
|---|---|
| `VLLM_ENABLE_V1_MULTIPROCESSING=0` | **Required.** Default spawns extra Python processes at >1 GB each; on 4 GB this alone causes the failures in current `notes.md` |
| `--enforce-eager` | Yes — avoids graph capture overhead/instability on CPU |
| `--max-model-len 512` (or 1024) | Yes — KV budget is the binding constraint |
| `--kv-cache-memory-bytes 134217728` (128 MiB) | Yes — exact, byte-precise control |
| `VLLM_CPU_KVCACHE_SPACE` | Mention only: it takes **whole GiB** and overrides the bytes flag — a classic footgun |
| `--dtype float32` | Default for 135M (CPU native; bf16 may be emulated/slow). Verify timing during build |
| `--max-num-seqs` | Introduced in the memory step, then used in the serving step |
| `--gpu-memory-utilization` | **Removed from all commands.** It is a GPU concept; on CPU the KV budget comes from the bytes/GiB flags. Teaching it here creates a wrong mental model |
| `OMP_NUM_THREADS` / `VLLM_CPU_OMP_THREADS_BIND` | Set to `nproc`; needed for both speed and reproducibility |

### 3.6 Metrics: one taste only

The `/metrics` deep-dive now lives in the K8s lab. Here it is a 3-command bridge inside step 6: endpoint exists, `vllm:generation_tokens` is a counter, two scrapes 2 s apart tell you tokens/sec. Vocabulary (TTFT/TPOT/goodput) gets one short paragraph and a pointer, not a table.

---

## 4. Prerequisites and proficiency

**Assumed knowledge**

- Shell basics: `cd`, pipes, environment variables, reading logs.
- Python: what a virtualenv is; running a `.py` file; `pip`/`uv` concepts.
- HTTP: status codes, JSON body, `curl`.
- Conceptual: "an LLM predicts the next token" — one sentence, restated in step 3.

**Not assumed:** GPU drivers, k8s, Docker, Prometheus, any prior model-serving experience.

**Proficiency:** Intermediate. The install and flag work is above beginner; the explanations assume no ML background.

**Prerequisite labs (soft):** `pythonvenv2` or equivalent venv familiarity; `LLM_file_and_inferance` if the learner has never touched model weights. `ollama` is a good warm-up but not required.

---

## 5. Step outline

Timing is learner-active time; add row overhead.

### Step 1 — Know your box (6 min)

`nproc`, `free -m`, `df -h /`, `lscpu | grep -o 'avx[^ ]*' | sort -u`, `lspci | grep -i nvidia || echo "no GPU"`.

Introduce the budget equation in plain language:

```
weights + KV cache + framework overhead ≤ RAM
```

Ask the learner to write down how much RAM is left after Ubuntu itself (~800 MB used). This number is referenced again in step 5, so the step must produce it, not just display it.

**Recap:** the hardware, not vLLM, sets the ceiling; and this box has no GPU.

### Step 2 — Install vLLM (10 min)

`curl -LsSf https://astral.sh/uv/install.sh | sh` → `source $HOME/.local/bin/env` → `uv venv --python 3.12` → `source .venv/bin/activate` → `python -V` → pinned install → `python -c "import vllm; print(vllm.__version__)"` → `vllm --version` → `vllm collect-env` (note: this prints an environment report; it is **not** a hardware-detection subcommand).

Include the **why** for each layer (uv vs pip: faster resolver, no wheel-building surprises; venv: isolation; pin: reproducibility) and a collapsible "if this failed" block with the Docker fallback.

Expected output: `0.32.0`. Include it verbatim so learners can compare.

**Recap:** one version, one index, one venv — and how to tell an import error from a dependency-resolution error.

### Step 3 — First inference, offline (8 min)

A `hello_vllm.py` from `assets/`:

```python
from vllm import LLM, SamplingParams
llm = LLM(model="HuggingFaceTB/SmolLM2-135M-Instruct",
          max_model_len=512, enforce_eager=True,
          kv_cache_memory_bytes=128 * 1024 * 1024,
          dtype="float32")
out = llm.generate(["Explain what a KV cache is in one sentence."],
                   SamplingParams(temperature=0.7, max_tokens=64))
print(out[0].outputs[0].text)
```

Then read the startup log together and point at three numbers: **KV cache blocks**, **max concurrency**, and the dtype/thread lines. Explain that the engine reserved KV space *before* the first token, and what "max concurrency 43" implies about serving 100 users.

**Recap:** the offline API exists for batch jobs; the same engine object is what `vllm serve` wraps.

### Step 4 — Batching: the whole point (10 min)

`assets/batch_bench.py` runs the same 8 prompts two ways and prints a table:

| Run | Requests | Wall clock | Tokens | Tokens/s |
|---|---|---|---|---|
| sequential | 8 × `generate([p])` | ? | ? | ? |
| batched | 1 × `generate([p1..p8])` | ? | ? | ? |

Expected: batched is meaningfully faster (typically 2–4× on 4 vCPU), because one forward pass serves many sequences and the KV cache is managed centrally.

Explain, briefly and only after the measurement:

- static batching (HF `transformers` default, padding waste) vs **continuous batching** (vLLM; sequences join/leave per step),
- why "GPU utilization" is a poor proxy for serving efficiency,
- what we **cannot** show here: throughput saturation, preemption, TTFT under real concurrency — that is the K8s lab.

Include a "your number will differ" note and the instruction to record their own ratio.

**Recap:** the engine's central claim, verified locally; the vocabulary of tokens/sec and batching.

### Step 5 — The memory equation, on purpose (8 min)

Predict-then-verify. Two experiments:

1. Set `max_model_len=8192` and keep the KV bytes small → startup fails with a KV-cache/concurrency error. Read the message.
2. Restore `512`, then compute the KV cost of one sequence by hand: `2 (K and V) × layers × kv_heads × head_dim × bytes × tokens`. Compare with the log's blocks × block size.

Teach the three-way trade: **context length ↔ concurrency ↔ memory**, governed by `max_model_len`, `--max-num-seqs`, and the KV budget flags. Mention `--swap-space` (CPU offload of preempted sequences) exists but is not usable in a 4 GB box.

**Recap:** every serving surprise is a memory surprise; the startup log is the budget report.

### Step 6 — Serve it (12 min)

The server goes in a **dedicated terminal tab** (`environment.terminals`), because a foreground `vllm serve` blocks the prompt — the reason the current skeleton's post-serve commands are unusable.

Server command (from `assets/serve.sh`, identical flags to step 3 plus `--served-model-name tiny --port 8000`), then in the main tab:

1. `curl -s localhost:8000/health`
2. `curl -s localhost:8000/v1/models | jq`
3. non-streaming `/v1/chat/completions`
4. streaming with `curl -N` — timestamp the first chunk vs the last to get a hand-rolled TTFT; explain that this is the metric that matters to users
5. the OpenAI SDK:

```python
from openai import OpenAI
c = OpenAI(base_url="http://localhost:8000/v1", api_key="unused")
```

6. `--api-key` + `Authorization: Bearer` as a one-line demonstration, with the caveat that it is a shared secret, not authentication
7. `{{TRAFFIC_HOST1_8000}}` to show external reachability, and why you would not expose this publicly

Also: `/metrics` exists; scrape it twice and diff `vllm:generation_tokens` → tokens/sec. Pointer to the K8s lab for the real observability story.

**Recap:** OpenAI compatibility is the product; clients are swappable; streaming is the difference between "usable" and "feels broken."

### Step 7 — When *not* to use vLLM (5 min)

A decision table with three scenarios and a verdict:

| Scenario | Right tool |
|---|---|
| One developer, laptop, CPU, chat UI | Ollama / llama.cpp |
| 50 concurrent users, GPU node, OpenAI-compatible API | vLLM (next: the K8s lab) |
| Overnight batch scoring, no latency SLO | vLLM offline `LLM` API, or plain `transformers` if small |

Then: name the GPU-only topics we skipped (tensor parallel, disaggregated prefill/decode, speculative decoding, LoRA adapters, quantization formats) and where they live (K8s lab, `LLM_file_and_inferance`, `resources.md`).

**Recap:** tool choice follows workload shape; vLLM is a *multi-tenant serving* answer.

### Finish — recap + next steps

What you built, the four numbers that matter (batch speedup, tokens/s, KV budget, TTFT), and the two next labs.

---

## 6. Assets (planned)

| File | Purpose |
|---|---|
| `assets/hello_vllm.py` | Step 3 minimal offline inference |
| `assets/batch_bench.py` | Step 4 sequential-vs-batched benchmark, prints a markdown table |
| `assets/memory_math.py` | Step 5 KV-per-token calculator + weight-size estimate |
| `assets/serve.sh` | Single source of truth for the `vllm serve` flags |
| `assets/chat.sh` | Non-streaming + streaming chat calls with `jq` |
| `assets/verify-*.sh` | Optional per-step verifiers (see §8) |

All wired through `details.assets.host01` with `target: "/root/"` and `chmod +x` where needed. No inline multi-screen scripts in steps.

---

## 7. `index.json` sketch

```json
{
  "title": "vLLM Inference Server from Scratch",
  "description": "Install vLLM on CPU, measure batching, size the KV cache, and serve an OpenAI-compatible API. (v0.1)",
  "difficulty": "Intermediate",
  "time": "60 minutes",
  "details": {
    "intro": { "text": "intro.md" },
    "steps": [
      { "title": "Know your box",            "text": "step1.md" },
      { "title": "Install vLLM",             "text": "step2.md" },
      { "title": "First offline inference",  "text": "step3.md" },
      { "title": "Prove batching works",     "text": "step4.md" },
      { "title": "Hit the memory wall",      "text": "step5.md" },
      { "title": "Serve the OpenAI API",     "text": "step6.md" },
      { "title": "When not to use vLLM",     "text": "step7.md" }
    ],
    "finish": { "text": "finish.md" },
    "assets": { "host01": [] }
  },
  "environment": {
    "uilayout": "terminal",
    "terminals": [
      { "name": "Shell",  "command": "" },
      { "name": "Server", "command": "" }
    ]
  },
  "backend": { "imageid": "ubuntu-4GB" }
}
```

Validate JSON and confirm the exact `terminals` shape against a working scenario in this repo before authoring.

---

## 8. Verification hooks (optional)

| Step | Verify |
|---|---|
| 2 | `python -c "import vllm; print(vllm.__version__)"` prints `0.32.0` |
| 3 | output file exists and is non-empty |
| 4 | benchmark printed two rows and a ratio > 1.0 |
| 6 | `curl -sf localhost:8000/v1/models` returns `tiny` |

Keep them permissive: installs and CPU timing are variable, and a hard verify on wall-clock would fail randomly.

---

## 9. Time budget (wall clock)

| Item | Estimate | Notes |
|---|---|---|
| `uv` install | 15–30 s | ~10 MB binary |
| vLLM + deps | 2–3 GB download, 3–8 min | 327 MB vLLM wheel + torch CPU + CUDA-free deps |
| Model download | 20–60 s | 270 MB from HF |
| First engine init | 20–60 s | 135M, 512 ctx |
| `vllm serve` startup | 30–90 s | includes a second model load |
| Each chat request | 2–10 s | 64 tokens on 4 vCPU |
| Batch bench (8 prompts, twice) | 30–90 s | |
| **Learner-active total** | **≈ 50 min** | install dominates |

**Free tier is 60 minutes.** The lab must reach step 6 (a working API call) by minute ~40. Mitigations if it runs long: fold step 1 into step 2's preamble, and mark step 5's second experiment as optional.

---

## 10. Risks and mitigations

| Risk | Likelihood | Mitigation |
|---|---|---|
| pip/uv resolution failure (the current 25% bug) | Medium → Low | Single pin, single index, no manual triton, no `--torch-backend`; Docker fallback documented in-step |
| Disk exhaustion (wheel cache + venv + model) | Medium | `df -h` in step 1; need ≥6 GB free; set `UV_CACHE_DIR` and clean after install |
| OOM at batch of 8 | Low–Medium | 512 ctx, 128 MB KV, 135M model; if it happens, batch 4 and say so |
| Model output is incoherent, learner disappointed | Certain | Call it out *before* step 3; frame as a load generator |
| Foreground `vllm serve` blocks the terminal | Certain | Dedicated Server tab; all subsequent commands in Shell tab |
| `--gpu-memory-utilization` confusion | High if copied from blogs | Explicitly removed; explain why in step 5 |
| Learner skips `VLLM_ENABLE_V1_MULTIPROCESSING=0` | Medium | Put it in `serve.sh` and the Python snippet, and explain the 3-process/3-GB cause |
| Wheels index unavailable on the day | Low | Docker fallback; pin documented in `resources.md` |
| Version drift after publication | Expected | Note in `resources.md`: recheck tag quarterly |

---

## 11. Cleanup of the existing skeleton

| Existing content | Action |
|---|---|
| `step1.md` (8 topics + WIP fragments) | Dissolve into new steps 1–6; WIP fragments → `resources.md` |
| `step2.md` venv/install duplication | Deleted; install lives in step 2 only |
| `step2.md` metrics cheatsheet (136 lines) | Move to `resources.md`; one taste stays in step 6 |
| `step3.md` / `step4.md` placeholders | Replaced by new step 6 content |
| `metrics.md` / `lmm_formats.md` | Keep as `resources.md` references (reading list, format sampler) |
| `notes.md` (CPU survival settings) | Promote **into step 5** as the taught explanation; keep raw notes in `resources.md` |
| `intro.md` | Rewrite: date, prerequisites, CPU-only framing, scope vs K8s lab, production disclaimer |
| `finish.md` | Rewrite: recap, four numbers, next labs |
| `init.sh` | Recommend **dropping** the `coder` user: everything here runs as root in one terminal, and venv/uv paths plus `cd` state make `su -` fragile across steps. Keep a `preflight` script instead (idempotent, checks disk and `nproc`). If the repo convention requires the sudo user, keep it and prefix *every* exec with a consistent `su - coder -c`, and never mix the two |
| `index.json` | Step titles, description, version, terminals, assets |

---

## 12. Open questions to resolve at authoring time

1. **Does the pinned uv command actually install cleanly on a fresh `ubuntu-4GB`?** Test 3× cold. If it fails even once, invert the design: Docker primary, pip appendix.
2. **`float32` vs `bfloat16`** for 135M on the backend's CPU — measure init time and tokens/s; pick the faster and mention the other.
3. **Batch size that reliably fits**: 8 or 4? Determined by the OOM test.
4. **Exact `terminals` syntax** (from a working repo scenario), and whether the Server tab should auto-run `serve.sh` or wait for a manual command.
5. **Whether `jq` is preinstalled** on the backend; if not, add `apt-get install -y jq` to preflight.
6. **Time to first response** with 64 tokens — if >15 s, reduce `max_tokens` to 32 to keep the lab snappy.
7. **Current stable vLLM tag** at authoring time (0.32.0 at planning).

---

## 13. Production safety disclaimer (required in `intro.md` + step 6)

- `--api-key` is a shared secret, not authentication or authorization; there is no TLS here.
- `--trust-remote-code`, `--enforce-eager`, and the tiny KV cache are lab settings, not production defaults.
- No rate limiting, no request quotas, no multi-tenancy, no observability stack.
- CPU serving of a 135M model is a teaching vehicle; production serving needs GPU capacity planning, quantization, autoscaling, and monitoring.
- Do not expose the port publicly with `{{TRAFFIC_HOST1_8000}}` outside the lab.

---

## 14. Course coherence

| Relation | Lab |
|---|---|
| Warm-up | `workInProgress/ollama` — run a model with zero serving concepts |
| Warm-up | `workInProgress/LLM_file_and_inferance` — GGUF, quantization, llama.cpp |
| **This lab** | vLLM: install → offline API → batching → memory → HTTP serving |
| Direct follow-up | `vllm-k8s` — operate the same engine on Kubernetes with Prometheus |
| Abstraction follow-up | `workInProgress/Kaito` — operator-managed inference |
| Adjacent | `pythonvenv2`, `pythonllm`, `MCP_AI` |

Catalog line: *"Install an inference engine, measure why it is fast, and put an OpenAI-compatible API on it — on a box with no GPU."*

The repo's conventions reference `scenario_ideas.md`, which does not exist. Create it when the lab leaves `workInProgress/`, listing this lab and the K8s companion as a two-part course.

---

## 15. Definition of done

- [ ] `index.json` valid JSON; title ≈6 words; description <30 words ending `(v0.1)`; `time` matches a real end-to-end run.
- [ ] Every step: what/why, executable commands, expected output (where stable), recap.
- [ ] Install succeeds 3/3 cold runs on `ubuntu-4GB`; Docker fallback documented in-step.
- [ ] Steps 3–5 measured on the actual backend, with real numbers quoted and a "yours will differ" note.
- [ ] Server runs in its own terminal tab; no step leaves the Shell tab blocked.
- [ ] No `--gpu-memory-utilization`, no manual triton pin, no `latest`, no gated models.
- [ ] `intro.md`: last-updated date, prerequisites, CPU-only framing, scope vs K8s lab, production disclaimer.
- [ ] `resources.md`: alternatives, version pin, install post-mortem, format sampler, metrics reading list, "when not to use vLLM".
- [ ] Skeleton leftovers (`npm`/opencode/WIP fragments) removed from learner-facing files.
- [ ] `finish.md` hands off to the K8s lab with a concrete reason to go there (observability + orchestration).
